Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40637F728;
	Wed,  5 Aug 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939757; cv=none; b=ayWEXb+ts4qmUMwEw3OIhHF520JTHwCGIuEmY+UdsinZnO9SLGET7CD8HBOg8wfNWVxxlYUk6gr4ko8HIM66pXOop4MeiMLaIBGjZ5pwLkoIsJ/Z7ALFbNBWz0IlzMFrBY4r4JjVbtOtube4yOKW3V4TTXk/s5LFgozuRgO0hC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939757; c=relaxed/simple;
	bh=C4o83UnET4uzURflwM4lwPqhbAEM6dutEIC1zJg2MSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMcMCdY7ySeSducLwtcSneu1IFLA8hGpZ3UXcV73IAsunFHEcItHUdTsIxpq//J4fAEZQntqEnfFh2KKmaujOu5cbUPi7mVhn+z530Mlx0E5EtnoXnrIyzAKj+dVTG0xvQvQvyzTtJ6p3XfFjh2OwrCOq7va6tdk2G+MnpWMbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HJh4EKTU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HJh4EKTU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A1BC153B;
	Wed,  5 Aug 2026 07:22:25 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4BD63F632;
	Wed,  5 Aug 2026 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785939749; bh=C4o83UnET4uzURflwM4lwPqhbAEM6dutEIC1zJg2MSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJh4EKTUEis2BCFSeUpsxUs+Q0egrLDeMN8kEPmsRwjh+ZfcbWy71z95VMhoWI8mR
	 66pHcVpfq/Cuym6A0zuN0xbTDd1rxvh/g8qwve0ff6gysp2FvYS05WLnkoauGLMYFV
	 RaP068KoCzfuTrgaYPRA7kIzMPyp4bFddRDXoAog=
Date: Wed, 5 Aug 2026 15:22:07 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
	elif.topuz@arm.com, lukasz.luba@arm.com, philip.radford@arm.com,
	brauner@kernel.org, souvik.chakravarty@arm.com, david@kernel.org,
	subrahmanya.lingappa@oss.qualcomm.com, leitao@kernel.org,
	kas@kernel.org, puranjay@kernel.org, usama.arif@linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v6 03/22] firmware: arm_scmi: Introduce protocol instance
 notifiers
Message-ID: <anNHD3S4tHm6yC9R@pluto>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
 <20260724144430.1440170-4-cristian.marussi@arm.com>
 <20260728010004.35fcac96@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728010004.35fcac96@jic23-huawei>

On Tue, Jul 28, 2026 at 01:00:04AM +0100, Jonathan Cameron wrote:
> On Fri, 24 Jul 2026 15:44:11 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Allow protocols themselves to register for their own notifications and
> > provide their own notifier callbacks. Each protocol can now register one
> > unique per-protocol instance notifier block whose callback will be
> > registered on the proper notification chain as usual: such notifier will
> > be automatically removed during the protocol de-initialiazation phase.
> > 
> 
> Would be nice to say why they might do this. I'm sure it becomes
> apparent later in the series, but anyone looking just this patch
> is missing that useful information.
>

Hi Jonathan,

thanks for your review... 

I've reworked this comment in V8.

> I'd also like something here to talk briefly about why it is fine to
> drop the lock briefly on the unregister side.

I've reviewed this logic... (spoiler... it was wrong :P)...the lock still
cannot be held BUT the new implementation should avoid races by using
the refcount and a new flag...

> 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 8e06e40d1a11..0f9e8dfc6137 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> ...
> 
> 
> > @@ -2367,13 +2402,29 @@ int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id)
> >  void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
> >  {
> >  	struct scmi_info *info = handle_to_scmi_info(handle);
> > +	struct notifier_block *proto_notifier_nb = NULL;
> >  	struct scmi_protocol_instance *pi;
> >  
> > -	mutex_lock(&info->protocols_mtx);
> > -	pi = idr_find(&info->protocols, protocol_id);
> > -	if (WARN_ON(!pi))
> > -		goto out;
> > +	scoped_guard(mutex, &info->protocols_mtx) {
> > +		pi = idr_find(&info->protocols, protocol_id);
> > +		if (WARN_ON(!pi))
> > +			return;
> > +
> > +		proto_notifier_nb = pi->pno.nb;
> > +		/* Ensure NULL is visible */
> > +		smp_store_mb(pi->pno.nb, NULL);
> > +	}
> >  
> 
> I'd like to see a little commentary on safety of not holding
> the mutex over the whole sequence.  Can anything mess around
> with pi between the code getting hold of it and the release below?
> I assume the refcount is enough.

I changed a bit the implementation and added a comment in v8 that
should explain...it has to do with the refcount indeed (but with the
new revised implementation..)

> 
> > +	if (proto_notifier_nb) {
> > +		int ret;
> > +
> > +		ret = scmi_protocol_notifier_unregister(pi->handle, &pi->pno);
> > +		if (ret)
> 
> Maybe this changes later but if not get rid of ret. It kind of suggests
> the value itself is useful in a way that isn't true.

...good point...reviewed in v8.

Thanks,
Cristian
