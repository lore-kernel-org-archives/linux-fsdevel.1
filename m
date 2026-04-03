Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276E20E334
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242864; cv=pass; b=CjblMVNwdK+mG8ehkHFtkRFlzkv9KrrTjrD80SQ0RGnDCuwkLZ8g+krT27oL27YQOgjVnIeVQuw8espb/QZHA4F2OBvuoPOZ0GCfqohdTNQkywDtCQVIEtMd8QIyI8oN5/JEWrK9m8pG3P2LJ5jG4CfCL095xwGzvDQ0dEfyQFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242864; c=relaxed/simple;
	bh=BcQp0WcNZ0PCDcShN13d1pqEe9vllKLQaSeRD6IaKDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRcwccJasUx3uAI5fjTTs4tUGJNBDMl3oq9h4IIY3sDY9i6GWFMLMu9f/p1qNmeyB233gPlNbGMZJEtfVQrFsFAVp4YoCpeeNFLgdOwG7z+jmtFh0+amEi4XiOuMHYDLODwGwxGYXJ/9IO0Ut2TvOJ4MnLj6fRGKpgNRtLl1mdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVSNHGEF; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVSNHGEF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so28190525e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 12:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775242861; cv=none;
        d=google.com; s=arc-20240605;
        b=kKNIKdHdWPpMSH2GQDQC59eJ20+U6oWqsrzgxV75xI7j5U1YUwh5qmB/HmOa/mm6g/
         2ozH4tJN2gVEfo+eYwUavYPu+Vd/oduvxHPE2TxxkMPvX/Q8dPrPUmjuRXNq0vhAvJpN
         0id8z5v1YV5OXFj42RMvVb7RPGQ7O4D0s1tJRzvC7kFZF0s2TytcX3fjWis1xRWaDLZP
         /rBB0XcaXAKhVl0fAQv5ELtXrv2c8CZPtNXxv0b/Vjbm5a8761YFEa0ow2siClebwr21
         /QaiNzqca4eHRSjk0Jaj//45Y8+3TE0cGvJyXudiq2eXhXugoSByqOlJWR+xhEiviBfl
         eIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BcQp0WcNZ0PCDcShN13d1pqEe9vllKLQaSeRD6IaKDM=;
        fh=+3I28REhUXhzx+sQzMTbP8nld+MbAwjVDaI3Cyj5Fn0=;
        b=OdbzFbiR2y98yrmQSiqUZt0XdSC7saJee71p2FVu7FIIvqldr5kJsIMoVgHtCLGzjP
         TvYqBsA9PAnAsjDizZNT9P3N6e/l3Sscyka3Yu7ERW3e8Fs8XNlaB7J13hQcHgPjeqK9
         qMysw2K+UJOzhyu7nsvA2nBbtupoE06jnsIkvMRcQk1am3g6qSxjdrDBKe0DznZN/6ml
         5E/5nVB05Z8ZPcVOTTaH+tY7w4bgOQw1UM7YA3Y5agnlT9OJeioFB6443kzGjqYwR4pQ
         arPDgwGb32AeVBv1bAYTL+QTQOC0hudy/PnqxxMYGuek4csV3Oc/GZa1LfTBE/OYs7zV
         2rww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775242861; x=1775847661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcQp0WcNZ0PCDcShN13d1pqEe9vllKLQaSeRD6IaKDM=;
        b=gVSNHGEFpDFHudMtHzYVZXWXfXjQRFDa0xsxGFp7im5242tlXl7mXRfEsGiWIGTtTr
         JM/rAFD/qyeCWkDFx+/3ZrmdqkublW1AMH/YAQFzwrJigG8MQKBHH/6vTG3Bl0GEPUVN
         71+5RD15wWF3sFGjFU3zgU0y8q9J3cUSRRNTigkgBSzYb7VgB0clfYyG2ZB53Y9qG+KD
         siohVv2aic4t7NnU/9Iw6DovLCgy7VCezI9bo0VOeAE13phx369+Hum1is3SXdK50aPa
         Dt/t2SvR4RR6D6HyVfCNOccS/KVH/op2csnDA63qpTaS57nse0qngfK7ouSzcHDgTuPz
         bdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242861; x=1775847661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcQp0WcNZ0PCDcShN13d1pqEe9vllKLQaSeRD6IaKDM=;
        b=ZFN1zabSV6228NYZjtc+RbgbUyhBr/DJiDX3rw/BPR4H4pfoqGdeP64U6YCDfwvnEX
         Vx5dOAkffDzLYDj/vKrwOmlTiUpYPR5G+CYgRqosrveHBCtQMuireeuNCYoiVRY1Bwq8
         r9ZT0ZFK4vgSJrkjuSR+02aaDoVNFHjryZssVAqCURh5rY7hxciUDtVbBELRUb9taJPS
         b0O0oaMvHQVvb/MKkEfW6SvwRb9WjBONpfAuVzKd5kABfFQ4z8DxQZO2cCnrlIaZ1ZGD
         WBoOimc6gI3xBUkYv2hMDcbdznIAFDYjt7t5Chru9lXp9/Elj2qt3XYWZKTGYV/1y4gV
         Jt1g==
X-Forwarded-Encrypted: i=1; AJvYcCV2Um0M4fGiGHH1SefDQ3E3DHkberkcgQvSSeUQgon3N2XQvOTx06nXz3+lpMZbTiaBE/TDoNJJGEnm8LWp@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/xKRFFzZadZ4AD0Cz3wFohyyAjeZkFaaF234Pg2bwrOwenZf
	nP/AWLBp/YiXmbdIprWpJI8Yw+QLVLbjygVFA/cT8pehsDj4HefjG1QwyL8/5SrWJedFcVYAb8X
	AHpci1ssk2cGgtkevOK1ayGPa5MTmnjc=
X-Gm-Gg: ATEYQzx64qFAymwjcfmSgjlT9As0Nu7FRnVmQZU8iwp91aa3aTg96G7xz4h7H7NFSGX
	XEtMeJ4w46vj5EdwIYZwGm/IEaqicwXTedoioIe5KCwAC3Si8uOc/eVdBYdmopRwMzVUPgpOW1l
	/Ge6KgpSMkYbF0h0wnrug0ErAvmWl8dEAkW7cCHfqRoGJAD64EbJxCx+Eqe2SsWPEuS8tgr6I3f
	OjjKNIwu7xaJYZBHdJzDvZHYgupyfwyUMNOnGe5J4VDyDp/dUYs/trHKo5qnz7GSEL//gAuHEU3
	oPABPVjefC2CNl3H
X-Received: by 2002:a05:600c:638e:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-488997b21f4mr64333835e9.16.1775242861201; Fri, 03 Apr 2026
 12:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403035752.20206-1-liwang@kylinos.cn>
In-Reply-To: <20260403035752.20206-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Apr 2026 12:00:48 -0700
X-Gm-Features: AQROBzAhMEZUqaVgUeuxANXR729kYCmPNNLZTU4JVW8UuGEhkPttrC-3jiBed5o
Message-ID: <CAJnrk1b2w5gstgDq9x9ssp+03k0xSexoBH8YyWbb82QXS2rk1g@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Send FORGET over io_uring when ring is ready
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 8:58=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>

Hi Li,

Thanks for your work on this.

> Once the FUSE io_uring is registered and marked ready, most request
> types are delivered through io_uring, while FORGET notifications were sti=
ll
> queued with fuse_dev_queue_forget() and only consumed through the legacy
> path on /dev/fuse.
>
> Deliver single FORGET operations through fuse_uring_queue_fuse_req() when
> the ring is ready. Otherwise, fall back to the legacy forget list path so
> behavior matches the previous implementation.

I don't think routing forgets through fuse_uring_queue_fuse_req()
alone is sufficient. Forgets are one-way and the server does not reply
to them, which is a problem for fuse over io-uring because the server
must submit a completion sqe to reuse the ring entry for future
requests. To support forget requests, I think you will also have to
add

a) on the libfuse side, submit completion sqes for forget requests
b) on the kernel side, keep forget requests on the processing queue
instead of ending them immediately so that when the kernel gets the
completion sqe for the forget request, it can find the corresponding
entry for it and recycle the entry back to the available queue so it
can be used for future requests
c) gate this behind a feature or config flag to resolve any
incompatibilities between older versions of libfuse and newer versions
of the kernel

For c) I think it's cleaner to pass this as a flag during registration
time, but it'd be imo preferable if there was just one generic flag
for requests that had no-op reply expectations, so I think it'd be
ideal if the code for sending interrupts over io-uring was also
included in this series so they could land together and be gated on
the same flag.

Forgets are also prioritized over regular pending requests for
dispatching to the server, so this priority should ideally be
preserved in the fuse io-uring path as well.

Thanks,
Joanne
