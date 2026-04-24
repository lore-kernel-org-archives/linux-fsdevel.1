Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2C3FB7DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063141; cv=pass; b=qTUGVQVrDN+7YUBSaf32dWUHEw+GZVQZAkF7Si70D2OJiXDIKbUSGtlGJfu5Ah7pU9rr0L6v0eICmR+lAGen/OukBV1LE3nmO+ZaEDvM7nWpFlp1/JZFokFi4i9E5O2WsUosHhfNlVAwzeNbITFzyAvzxSnhKv3Ey0GaPMp/DGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063141; c=relaxed/simple;
	bh=KmBuB8MIulAJMakc5vosnN5ndLHe+vSUa09xbsYuhXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrWX6QTFa4zH/MIgo6W7WLXNR/syBdCWRk58wzxC5T06/jTn6Y+mHSVn6A5X0DouFaasVHwwWhGbv61uat5H3sGvZZJOCL/ZZWyTpg4MXv4w5458AomNXmpIvsc7mNvXmRFyPm41vBP/z1h7TjIEalKLnKSqFzYry+DJPXZ5psw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rY5Hd84P; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY5Hd84P"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso77428505e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777063137; cv=none;
        d=google.com; s=arc-20240605;
        b=hKTtNRlcHEyfBLDyUR3zReaKpeW5Ti203322Oi7AGVNk9jyuV8N0Y9yL7k2odB46IJ
         fTex1i02DwnQOJqvMhxYM7NHrYCyALH1jkWteTDpqjRSWn+PochFSGp/CcIi67FM5EL0
         ujpE/UGEsJN4MUBLR7Q2Z8lK3I/lwVV4xljcWJPM241MDbNOEK3Y4bkmtJzCCdlrqtyq
         v3Xjhg7jwrdkopMvy5Qa2uh3o7pC2ZLYa4ePgNNNWOH/IwAdVsPo63P8e39UDM5WUn56
         FuCKz4yzbYuuqvQ7bSFPjWL6AJTJhj6yh2ATdn/ABmaBtCKjYAYTdSHQbPsqgIxKzzeC
         vLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=90/AaWsK84JF4RAxGyFXMf8dGYrGrq3WZ71pjIuxCD0=;
        fh=+BHCaeqdUy530ISL2QGjuVSpJw1SjJmB+PXlc/dPaAE=;
        b=IJBgeIn+uwjekmsRAMC7r6Cgx9jeBi3SsGhLs1Bfxk70SJ5kzD99dUTLA1C9kQbXYf
         UZdHTPVhmL/MtxGy1MZwzCJviCVkxof25cCCOR3AMI9sIW9heePx2zR4jTm4Je/djn04
         LlDa8Q8rp2Yv56zMFseZhCBeZHOUwLbDYg8+2ZZczo0jWR0E21rcerHwoimWLzlefE/m
         uNhehNb8P7YkUh0NrFwVCYvzKwE0fUdDGoSgJUknJZsEnJBMJSFgckbunjoU3zVtyt8i
         LKMKdz41pwViJODsg1HM40k+nPBoeACy12nkc1O7txdHC5uELjPMhYzGF9U/QtJeBWKP
         FDBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777063137; x=1777667937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90/AaWsK84JF4RAxGyFXMf8dGYrGrq3WZ71pjIuxCD0=;
        b=rY5Hd84PRWiRfzlfMrtMn1epIZVP/yy7/UWEwugulGrU6WDnPMxs8GO3mtydZai7WP
         ffhcUZ1JNMpkh865y3ax2Tsv9mGLLYW9QFMXBDwrzIX0WaTQkYsPlmelG3y6b/NM0uZ0
         Sxu6FWsjD4OANhdgjnaz4QU99LiuYAjn6b+gA+1cdxTUQmS2Khc5BcX30VmRc96QpmKa
         XdQ5SfhxnTH7/mxbdX9+S3gzSQUmAGMsjG75QoI+NoKkam85CbJZ/Xnqv09rsV+0qjmw
         aAA7P8UHZOMWyREyp8nDt2g48HA4C9FY7WAT7GYicNH2N11TphW1KT5+55onKVsxg2Xj
         qxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777063137; x=1777667937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90/AaWsK84JF4RAxGyFXMf8dGYrGrq3WZ71pjIuxCD0=;
        b=rl3SKlPXrX+iayiXIGZ+PEdCF4KAVK5vNs/cW/B4Xy2nas0mlUX/1w0IhRFGg0rLW6
         M+ep62nV1pojuh2harQTmb23n4sJPW29TegIeOP0HvFN7xyYX8R8By4YHrFvRLJMMzXg
         x8AK4pOzwVMfnnAHsMr/fv+EPWN8KsIJhmuUWFgMEZV1iXcDpdjgtI4RaSyLDImYJnBW
         bq3UdWvxmpl/PgE4Zm9abTmXht3Ned0UG9EBZm01RPyvLv+2vtoLjnZpdulYGjY32mCu
         2pyUopaDMgubQuguxFkKQOzY1FnNQIpjpchvDKaUzoOC4TAXZCOPqfpEmISBld0nNKTH
         yvGA==
X-Forwarded-Encrypted: i=1; AFNElJ9MG3eMG5luUMAR3VMAq9r5H8ACBS6jWntr1GUZqXlHwQIOWlxpFYEkSlR30xEO4QfBZBULqBEewORBeALp@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPfsBbuLicI2cN0CbIjgbw+drIImlBbB9cDlEJpzMUtyr+9kO
	3lULS3GGISQTA+EUYlvzVGoMQGyQKZna77kB8YzD/JAG/2xG1e9Ai2w/+UTzYcEK3dLz6edYG7S
	+lKkEVUmj1zDIeDPXNRHb49KysKD1O+TQNxQvR4M=
X-Gm-Gg: AeBDiev2PUkPk7P8bkmR8L/CHNwzOVOoFLFeqfzay39Zmd58HrD2vtcGLGc/26aS5uK
	Tv/c9ZMOxV2d6Vj0Ip1Xep1eXCpr3ThBEnSpIHbMtgle+XbxXxwj0nbSFEHXZS+XoYi60Sj/NNt
	6QoXIMvRtmrMPzgAgTM6LoumuPd5MTP9PzwF6wW6OZxUhRvfmgFIfTHxQuXe4CHGNzgeNesr6dK
	i9A8o58vGtjLtW7jbfCmCENgiw7JfDdMIZBrV8AOIO+GMIXMBWG6/kNEcQrwOLKs4EwtSprptk0
	fDaLlr3mUeMqUK9P9UeA0zK6WUj9Wgb+fWSDJqLbSiVR
X-Received: by 2002:a05:6000:610:b0:43d:7a97:78c0 with SMTP id
 ffacd0b85a97d-43fe3e0c65dmr49146085f8f.36.1777063137031; Fri, 24 Apr 2026
 13:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403035752.20206-1-liwang@kylinos.cn> <20260423110954.2676-1-liwang@kylinos.cn>
In-Reply-To: <20260423110954.2676-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Apr 2026 13:38:44 -0700
X-Gm-Features: AQROBzBsneter9kG69FavOfuB50o0T5qzVMpoATbkO_Hrxt0YjSek5nk_VPJc_I
Message-ID: <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 4:11=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> Deliver FUSE_FORGET through fuse_uring_queue_fuse_req() when the io_uring
> is ready and userspace has opted in by setting
> FUSE_IO_URING_REGISTER_FORGET_COMMIT in fuse_uring_cmd_req.flags on
> FUSE_IO_URING_CMD_REGISTER. Until any REGISTER
> carries that bit, FORGET continues to use the legacy
> fuse_dev_queue_forget() path even while io_uring is active, so unmodified
> userspace (e.g. libfuse that does not issue a completion SQE for FORGET)
> does not wedge ring entries.
>
> Benefits:
> - FORGET can share the same commit/fetch loop as other opcodes.
> - Reduces split transport for high-volume forgets when the ring is primar=
y.
> - Reuses existing per-queue io-uring machinery and noreply/force
>   request setup.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Hi Li,

Thanks for sending this. To be completely honest, I'm not convinced
delivering forget over io-uring is worth the added complexity/cost. In
the /dev/fuse path we rely on forget batching/amoritizing and explicit
scheduling/fairness logic so forget processing makes progress and
doesn't get drowned out by regular requests; I think we'd likely need
something comparable for the io-uring path as well. Additionally,
routing it through io-uring makes forget behave more like a "real"
request on the ring (it needs per-request state to live until
userspace completes and the entry can be recyycled) which introduces
extra allocation/lifetime management on this path and it requires a
uapi change and corresponding libfuse changes.

Forgets would consume ring entries but they're tiny one-way
notifications and imo I don't think they benefit much from io-uring's
main advantages (eg data-path/zero-copy). I worry theyy could contend
with read-write heavy traffic where ring capacity is more valuable.

Given that, my preference would be to keep forget/interrupts on the
legacy /dev/fuse path even when io-uring is enabled. Sorry for not
bringing this up earlier in v2. Bernd, I=E2=80=99d also be curious to hear
your perspective on this.

Thanks,
Joanne
