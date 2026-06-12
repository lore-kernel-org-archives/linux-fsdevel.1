Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A637C0F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259071; cv=none; b=FO2RATKawUcbW+Y2oJEJJRJepasG5tRhshehEgB0sqWciCJOSQz6s04VQG1IaY8bAjchRgSZzWxZl3QA0YtAd3UmlFaDWxo4iDLuZsIiIb5S/DI3y8ngwLhoPkeczJjTMbkxD/NS238bc1o0Y3LudXChQ3JzdSAD22qtUrmDnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259071; c=relaxed/simple;
	bh=BbsZrou20noZ1eCteTU+al1EUZ4Kgg/aMc/ruF0xQ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlNKKm/sFL59pO+5I0CCLt2FhCIlOxQsft3mYGYlTCsqiLT5mU8GUKhgHYtBKB60lrJhSHKgnejKR6ToaL2Wj4ZMI9nbia9Y5RCIrtOZRWMo/Qa7wfd6+OO1hPmfpku71TVXHBt8Itr9eT7XpeWAbXJYzF41Hn+a05QtoO5izz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=guKyFSl+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="guKyFSl+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781259067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzS/kGsf92jGqEw0Cpbkdc2ZLCTfp0DBUP+QupYpFLE=;
	b=guKyFSl+UfdPsiPAbmsBFksClDnPER66iuQB/0VZpZJUYxSrmZUSvQkFzz3h2a3Lx8j05t
	Mg/rTo7oVaCNm32etcLTuHF0fUxBA0+XD/Wkq8RGVtxTCIO1nMAbACU0bzNJoxSQ93GPca
	qOT4RlCNTcqwnOuHkVESEpSONHkhYO0=
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
Subject: Re: [PATCH v3 01/24] firmware: arm_scmi: Add new SCMIv4.0 error codes definitions
Date: Fri, 12 Jun 2026 03:10:59 -0700
Message-ID: <20260612101100.186627-1-usama.arif@linux.dev>
In-Reply-To: <20260329163337.637393-2-cristian.marussi@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 29 Mar 2026 17:33:12 +0100 Cristian Marussi <cristian.marussi@arm.com> wrote:

> SCMIv4.0 introduces a couple of new possible protocol error codes: add
> the needed definitions and mappings to Linux error values.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 7c35c95fddba..44af2018e21d 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -45,6 +45,8 @@ enum scmi_error_codes {
>  	SCMI_ERR_GENERIC = -8,	/* Generic Error */
>  	SCMI_ERR_HARDWARE = -9,	/* Hardware Error */
>  	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
> +	SCMI_ERR_IN_USE = -11,  /* In Use Error */
> +	SCMI_ERR_PARTIAL = -12, /* Partial Error */
>  };
>  
>  static const int scmi_linux_errmap[] = {
> @@ -60,6 +62,8 @@ static const int scmi_linux_errmap[] = {
>  	-EIO,			/* SCMI_ERR_GENERIC */
>  	-EREMOTEIO,		/* SCMI_ERR_HARDWARE */
>  	-EPROTO,		/* SCMI_ERR_PROTOCOL */
> +	-EPERM,			/* SCMI_ERR_IN_USE */

"In use" reads like a resource-state failure, where -EBUSY would normally be expected.
-EPERM suggests an authorization failure,  which is already represented by SCMI_ERR_ACCESS.

> +	-EINVAL,		/* SCMI_ERR_PARTIAL */
>  };
>  
>  static inline int scmi_to_linux_errno(int errno)
> -- 
> 2.53.0
> 
> 
