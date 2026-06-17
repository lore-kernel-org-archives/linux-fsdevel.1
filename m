Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991E38B7BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684560; cv=pass; b=a65ZKyhEWrJDow1G5bD/7wm3feOQePMQd0qrETM8NvHDsFiQ3XhDaXzZppfvZxn0Nu4+YhaS8W8FDgaIN9Q7Gb5Gia6khjuqYc1MLGJuJP2F+WondfQxLrENqn5PwXNPfirXT3qzzQmCMmhZ9DvM0LacRKCNW6PMLarCnmO5RnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684560; c=relaxed/simple;
	bh=xvOTAcL/OEi1dP4MlZ52ki7wL7tL1sQQL7OUhgqBmNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR39UkoWxeVVbXw+s7ng03zH7fEmy9TDaagA1Hhofs041vXQTadniebcKm7to5P5VmCzuksoX97xgxqBCw94JNy+0DCpGQKkUIsbMPbuXwXmArf+i2DOxJHKaVnAwsMWpxIvIXyzZmJvhrHr4U+QiQOX2xunJeXr6wOSEkLG+wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rMi0iNIN; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rMi0iNIN"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-517583cb07aso60622081cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 01:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781684556; cv=none;
        d=google.com; s=arc-20240605;
        b=lF8vbf7RMcbMqnZKZ9diQkDjLMCRIlW8m4mVx3u5YTgr7QA/4A4GdjP4BXdFCEE8ts
         G6fufVxSNHo9W9cXXbWImT6sjwvUrGz0yLtd5wSt/sGXCMEEQuHbPaU6flRQ2dqDwdEE
         sC+3MMyZmg2kR+oPYotTO1NsuKWW4adLAVpejX2Ej5kyru+CA5Xzai5HXueGoelVNm56
         E1UAeaRpTmjG0vpa6INQKuFtbErddqwt7nklyVEc5SdYxWPuwSYh1I00RPVEaa7UHv51
         GJ+Wn4crdRtxlf/EUX8YTnS7arg8vZfLZ/j6nBU4rKX7DrRClWssaC88hC1qYMqxql9Z
         zqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BU5fXnVq2Oqd0AAAN7spvlRTj86TwPYYP6Lo343Jbco=;
        fh=SagXxygEvhNbOy+v3RWRgJHAD0fVvom2hKs4/5Jzvyo=;
        b=RUxLNDzx6ggHUbQUyvDARCKwIzRG2wWGsaTDBCUdUG3/zfMgzx8wPP700L72t0zD2p
         UtAHCsEHaLFg6F9iUyqnLhDwkEeGvIBCCYkalZ6ZLVzu8I/z4eLn4QqFE49a250MsrGc
         Boifa4pZvSXL9lrwrjWVIi5FubruPwJ/XkpWjpKMKmQmRW0V3yl7GJJdLK3vDNjI4Pya
         1ChETPBCWhLibJjqPO9IaPGCaA5598ORHVX09Vnui59VX+jdxNJPypX3WJfDtLBbJ9pR
         MwHfLOtbtCRtCbmq+fW1R2/virQQ3T3Io9H3g8jv4WFfKM6d6XaCDhmX2Le8XxCU2TNf
         DIqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781684556; x=1782289356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BU5fXnVq2Oqd0AAAN7spvlRTj86TwPYYP6Lo343Jbco=;
        b=rMi0iNINHVIIU04xYxHAox8+KXWg3Km2fZo8UC0ogLSyCYukBp48Y2LATQmEzeKIZ3
         sOokLNQNeqIhVniNeFcxvWMePu7oQKia5baTHQFYKvoJEU7Ctxt3I7Kto5pqxNRT5bPU
         07LzofAiUvuU4B+PFpuYAOSrFfE219M22LYGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781684556; x=1782289356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU5fXnVq2Oqd0AAAN7spvlRTj86TwPYYP6Lo343Jbco=;
        b=QDy+z5GusTELikWkcRuHMgkYS86X7gVMmnS6uAPc3lzNaQwuPQlhqXlOSg03N1VTND
         LtOWt/GM4A2Y4+rRndq1gsErqZaHPnvlBrrp4wZ2c9QDaC+c8BT/iusdDMjJm1bwmORX
         mr87en4ugC4Dk+vQd/9ZKtnod8g/6yjOinokP37qokZAjE4rGEy6GfwkEk81O9AJUV2x
         te7fazvZrRKb0sWhQWy0YNvJV8mnfZMcDWbRzqD1enpwzV5YJuH84PkMKpqc1ZIaOZ/p
         2Ee6wl03hUD+ZQIC8Zqopb6Z/1IXVhIS91wcpBTVV90OC+jikEI6Y49JmrFZTh4w794d
         dgHA==
X-Forwarded-Encrypted: i=1; AFNElJ9kw+4rcjZbLMxbyHczHKXvKduni7KNcMffd9YE3bjRqEUa8oqEsoU8k8ukd2UPEWpyw/b6AIlPwIlkvtl3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1Gif7TnqLiG0rOnxVgQtxSTKZ2SfkMs25+m+2G6+p7xRfXbv
	KEmNXFdaDKDYSB5yCJ2tww1Cr7SJGPyrUgPt2i323VfExLUqcEYR87ZwvVYbIXghrMN3A5bBYCV
	6l6Mta1HAtz1doaWFen8sjHpnJhsMK5O5GAGKYdwF0w==
X-Gm-Gg: Acq92OE0Vmkz8UpVDExTBZtEm9AYkdWePo21jgfqWs959k5Z05tol9+1g1L1vegB0OD
	Ri3qhiT9D57iwrxV/EvVRuVveONsGDUuDV1JhV3jHnaohDnIwyCP6IxaIqg0XDsa59Ns6v/h8qq
	rrWB37EUe28HxPLZniDu+8Kdz9y9331MQKdU6v1RIfQADGPQaMFbtEye5PZ9tOip2IAcem6otZ7
	GHqEcq83vrPEcIK4ONNpzqjQ6xFJyKc/wCsMPp0b4eGdfj4bY+yJAHrceQXMqFYkbfRGW4N0/Mo
	xUDC/Iy4JoT2GRFqvCCwbtSAtA4=
X-Received: by 2002:a05:622a:5516:b0:517:97f9:78f5 with SMTP id
 d75a77b69052e-519a8c6606emr50572071cf.10.1781684556219; Wed, 17 Jun 2026
 01:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616151909.916667-1-jamz@amazon.com> <20260616151909.916667-2-jamz@amazon.com>
In-Reply-To: <20260616151909.916667-2-jamz@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Jun 2026 10:22:24 +0200
X-Gm-Features: AVVi8CfLUvw9HEz1q1LlF1z_PcpL4rUpzyaGd12mSg8e3Xcq01aL572WH-arImg
Message-ID: <CAJfpeguaa4U6Tsxh5opeaLeYQQxP6MQsRMu_JATJwwgj=OBt3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
To: Jimmy Zuber <jamz@amazon.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 at 17:20, Jimmy Zuber <jamz@amazon.com> wrote:

> +/*
> + * A server can stall syncfs()/sync(), so only honor FUSE_HAS_SYNCFS for
> + * mounts owned by the initial user namespace, i.e. set up with host
> + * privilege (like virtiofs and fuseblk).
> + */
> +static bool fuse_syncfs_enable(struct fuse_conn *fc, u64 flags)
> +{
> +       return (flags & FUSE_HAS_SYNCFS) && fc->user_ns == &init_user_ns;
> +}

Sounds really easy to trick: start the server in the initial user ns,
then clone the mounter with a new user/mount namespace.   The
init_user_ns test will pass happily, since the server is running in
the initial namespace.

Thanks,
Miklos
