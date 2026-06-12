Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A4377EDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259345; cv=none; b=pypfRpHYXtb2vfIQdPb4T4Cl5V3RQCLp2c2BqpfITV7DJomcgYw10GCUMvuV/N4GgFbaA+24SuNlm6eM0g+Cw/kGCH+HwtkJ286idleP2ok/3GMkcv1AoSxs1Qri8Ln085cJHyPIES2CrHHlmGNPSsB4Z7t8zZK5oiGrr4DzvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259345; c=relaxed/simple;
	bh=WtwFBdcoNgVFnGaN7wYg5bPQTbJzZm3o2CtR/JVfPBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7OX04y1czbHZNXZb90IlUlLNJYSxMQ2zKFEhQmpZ0AWL30pp79RSSxRqdhwt6jTuoJGG1I5dWTQAz6uxNO04YLwcVd1divvlUR1UDObfzdLt7xpZWELr3Tn2ZRqmRFmarm8paU6+uKVLsxR8RmcAa0Qegqe4OBBwv4fc7Tlwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EQoBDBvf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EQoBDBvf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781259331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNePmwoejC9uECBwHhyf9ZCMhy83FpHG4lebaOpVm0M=;
	b=EQoBDBvfHYiavI3vA2yTca4fC+KP7Jdm89S9rgLab6eg/3U8UnakmhSUbwGwZXDhFNXHC6
	UZM2hqGg6Ri/TRseT5+w2zgSq53/sECP1UOqvX1emDa6+r7eJb9ro5J0Rmcp5qLbKDjRNd
	XJoXg1rwWDXdr8bCEpzg3cCWhsGHzak=
From: Usama Arif <usama.arif@linux.dev>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	sudeep.holla@kernel.org,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 02/24] firmware: arm_scmi: Reduce the scope of protocols mutex
Date: Fri, 12 Jun 2026 03:15:24 -0700
Message-ID: <20260612101525.340337-1-usama.arif@linux.dev>
In-Reply-To: <20260329163337.637393-3-cristian.marussi@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 29 Mar 2026 17:33:13 +0100 Cristian Marussi <cristian.marussi@arm.com> wrote:

> Currently the mutex dedicated to the protection of the list of registered
> protocols is held during all the protocol initialization phase.
> 
> Such a wide locking region is not needed and causes problem when trying to
> initialize notifications from within a protocol initialization routine.
> 
> Reduce the scope of the protocol mutex.

I think this changes more than the mutex scope. scmi_get_protocol_instance()
can now drop protocols_mtx after idr_find() while scmi_protocol_release()
can concurrently drop the final reference, remove the IDR entry, and release
the devres group. Does that leaves a use-after-free window around the returned
pi?


> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1-->v2
>  - Fixed improper mixed usage of cleanup and goto constructs
> ---
>  drivers/firmware/arm_scmi/driver.c | 50 ++++++++++++++----------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3e76a3204ba4..26f192b8d7a9 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -17,6 +17,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bitmap.h>
> +#include <linux/cleanup.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> @@ -2190,7 +2191,6 @@ static void scmi_protocol_version_initialize(struct device *dev,
>   * all resources management is handled via a dedicated per-protocol devres
>   * group.
>   *
> - * Context: Assumes to be called with @protocols_mtx already acquired.
>   * Return: A reference to a freshly allocated and initialized protocol instance
>   *	   or ERR_PTR on failure. On failure the @proto reference is at first
>   *	   put using @scmi_protocol_put() before releasing all the devres group.
> @@ -2236,8 +2236,10 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
>  	if (ret)
>  		goto clean;
>  
> -	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
> -			GFP_KERNEL);
> +	/* Finally register the initialized protocol */
> +	mutex_lock(&info->protocols_mtx);
> +	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1, GFP_KERNEL);
> +	mutex_unlock(&info->protocols_mtx);
>  	if (ret != proto->id)
>  		goto clean;
>  
> @@ -2284,27 +2286,25 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
>  static struct scmi_protocol_instance * __must_check
>  scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
>  {
> -	struct scmi_protocol_instance *pi;
>  	struct scmi_info *info = handle_to_scmi_info(handle);
> +	const struct scmi_protocol *proto;
>  
> -	mutex_lock(&info->protocols_mtx);
> -	pi = idr_find(&info->protocols, protocol_id);
> -
> -	if (pi) {
> -		refcount_inc(&pi->users);
> -	} else {
> -		const struct scmi_protocol *proto;
> +	scoped_guard(mutex, &info->protocols_mtx) {
> +		struct scmi_protocol_instance *pi;
>  
> -		/* Fails if protocol not registered on bus */
> -		proto = scmi_protocol_get(protocol_id, &info->version);
> -		if (proto)
> -			pi = scmi_alloc_init_protocol_instance(info, proto);
> -		else
> -			pi = ERR_PTR(-EPROBE_DEFER);
> +		pi = idr_find(&info->protocols, protocol_id);
> +		if (pi) {
> +			refcount_inc(&pi->users);
> +			return pi;
> +		}
>  	}
> -	mutex_unlock(&info->protocols_mtx);
>  
> -	return pi;
> +	/* Fails if protocol not registered on bus */
> +	proto = scmi_protocol_get(protocol_id, &info->version);
> +	if (!proto)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return scmi_alloc_init_protocol_instance(info, proto);
>  }
>  
>  /**
> @@ -2335,10 +2335,11 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
>  	struct scmi_info *info = handle_to_scmi_info(handle);
>  	struct scmi_protocol_instance *pi;
>  
> -	mutex_lock(&info->protocols_mtx);
> -	pi = idr_find(&info->protocols, protocol_id);
> -	if (WARN_ON(!pi))
> -		goto out;
> +	scoped_guard(mutex, &info->protocols_mtx) {
> +		pi = idr_find(&info->protocols, protocol_id);
> +		if (WARN_ON(!pi))
> +			return;
> +	}
>  
>  	if (refcount_dec_and_test(&pi->users)) {
>  		void *gid = pi->gid;
> @@ -2357,9 +2358,6 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
>  		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
>  			protocol_id);
>  	}
> -
> -out:
> -	mutex_unlock(&info->protocols_mtx);
>  }
>  
>  void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
> -- 
> 2.53.0
> 
> 
