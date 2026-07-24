Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DA2D8DCA;
	Fri, 24 Jul 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905557; cv=none; b=TEwI5wScbIrd1+B+NQmVxjN5pBvW6wWhex7nJo/bMnnPJjRwguEFdN/KO0nR6MaO9bEPR1RT1stir190DdGcUDJqu/DPJwCsrBE8FmTRYofdlFwThZ3ESidxxQN5XsDhad1jPgsXizC/mw6wdJLNMUIj1uftHBM3iBUy1/ONdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905557; c=relaxed/simple;
	bh=E7XFCLxRIwXaLN0V8uIslzdQB7crLng2788gX5oMVKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IODTRaG1rNI2dBLIEf+QyjNB23mkIl+iYFUrLrd2VUoHQV9sJysVDijmK2HelrbGOFtPT7NSmxUuOahBY8dC05SiPtEla1oMMR6egT7+NsJxhS9700BLGbeWvRoB804aFz9igmWp9Z3PNh3MBJJ41N+cflGnWcqmQ6Y+Y8Rdz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cxS2GECs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cxS2GECs"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 40335408B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1784905554; bh=O1NxEzIyl57DprBUUSOUtSCXB+mtbnXl5Xys+uMdSEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cxS2GECsC1GW8TmvkDKgprdLRf4zXP0KqAMKBACxeJp8x1/CQylIcUMHmeDIHSG6W
	 tInM7iVVgYAv7YId6VctDrqTHx6ySTLJTR5GSKzURLdjlartYvY7R2U6J3qdDdw9j8
	 JfFkhpB3Z9M9ZyjFv8H1Vr8vtPiam8abIcSD156vW8TapLsjIdYyWfNSVXpWEIn/Bk
	 KXH4Hbu9bfDI7CgwTQKJaDxB2kPn2oqppHiFNwHM+0/QQz8j5xhAgPIbQWBGf5K+SB
	 UOTLVI67AIZcjQiM7OTNNgNcJ58WjYx7vV/R9DDVbIoNMKmijTBZII1Xu+9Ln5yXIw
	 URpVEeiZ5/5hQ==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 40335408B5;
	Fri, 24 Jul 2026 15:05:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org, james.quinlan@broadcom.com,
 f.fainelli@gmail.com, vincent.guittot@linaro.org, etienne.carriere@st.com,
 peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
 jic23@kernel.org, elif.topuz@arm.com, lukasz.luba@arm.com,
 philip.radford@arm.com, brauner@kernel.org, souvik.chakravarty@arm.com,
 david@kernel.org, subrahmanya.lingappa@oss.qualcomm.com,
 leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
 usama.arif@linux.dev, kernel-team@meta.com, Cristian Marussi
 <cristian.marussi@arm.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v6 21/22] [RFC] Documentation: Add SCMI System Telemetry
 documentation
In-Reply-To: <20260724144430.1440170-22-cristian.marussi@arm.com>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
 <20260724144430.1440170-22-cristian.marussi@arm.com>
Date: Fri, 24 Jul 2026 09:05:53 -0600
Message-ID: <874iho8m26.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cristian Marussi <cristian.marussi@arm.com> writes:

> Document ARM SCMI Telemetry IOCTLs interface.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> RFC since it still needs more extensive examples
>
> v5 --> v6
>  - fixed typos
> ---
>  Documentation/userspace-api/index.rst |   1 +
>  Documentation/userspace-api/stlm.rst  | 143 ++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 Documentation/userspace-api/stlm.rst
>
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index a68b1bea57a8..22daa7ebf78e 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -54,6 +54,7 @@ Devices and I/O
>     dcdbas
>     vduse
>     isapnp
> +   stlm
>  
>  Everything else
>  ===============
> diff --git a/Documentation/userspace-api/stlm.rst b/Documentation/userspace-api/stlm.rst
> new file mode 100644
> index 000000000000..e34226b11373
> --- /dev/null
> +++ b/Documentation/userspace-api/stlm.rst
> @@ -0,0 +1,143 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. stlm:

I'm not sure what that last line is meant to be?  It *looks* like it's
meant to be the sort of top-of-file label that I've been trying to get
people to stop adding for years...but it lacks the leading underscore,
and so won't work even for that.  Remove that line?

Thanks,

jon
