Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71E38888B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234277; cv=pass; b=Bhu2LtFBDeC+97/UGWdUsWi08gNhlGNUVxp+m509TG1AX6yOcACMKprXw3sbKJV6YJ55qvJLmb/jGmhZ9tjRJB7eM29MEsKdztGmgeUpTs5S6ZX9agpAEj1JNRyXwpcmm6P0/qgIgu+hru6gPTQMO1athe86WzeiZ7i0DDj8IJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234277; c=relaxed/simple;
	bh=AmdxDpSAXFZg+NG1Z53JDpqr/ZSkXDFyKiUPoH63AXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNiWEIJxo7m3tA/f+E2Al8LW0KjLLz3yxjeY0OM8y2qAu0kWya55n0ysucl9k/vCPZB9tSz9u8bQZ4mFB0K8tbrRHv9dgxP0gw5H8xIyzIa0AKKic19GHvyaNL4cT9GM4PZxhQad/OqhQnAypNUDBsmBIEklXmMhsis0teGrajE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4AtgucW; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4AtgucW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-464192ab2e1so106998f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 10:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782234275; cv=none;
        d=google.com; s=arc-20240605;
        b=XYxoXVzTrsg2yYnjhEn8tVTLOd7BrdcgBliUjQZqXKuAj2M/lMf39jPv3ohjVLqvI6
         coAHlHo4hlhD1DjfXjktTVt5FjuCIUGjIbxjlIIl7iXJQS3/TmnqcOwoavg7PVnpyDWV
         ix/mURGYuvwjkPYL9rZuL8Aqp3AmSGjDdlALLmjOILLijgZw1TfLmcAzGI3RfwG16z4m
         Kh280Tna8fTTTYydHdus9TRtLFrF7Osjd7gyM0xKylnaCmgzdR+2UUWAm/LuRrHYlBGo
         dlkrOjaDeeCs3dFFuLnm6Ba6fWGpp8qhD7M8AdvUIfQzwSJwQ5u32+jdfy/kP0Y7ohIT
         tXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
        fh=pzcdeHJfpO7DUbZAQxBEbjtAK7mKz1t7YdHrECwUmpk=;
        b=TMj1BD1hlBEwIfjsluarZ7tw6++rdBKGG4agCLllRH6GaZo3pZzEtJJijQLssSKllS
         NqZZi4KiVOpF7FMlgbjPMDPYJnUuIjSUpEXGSjFCC0wL5naGMCoITdiwz1hB2ocoHuvt
         +GKm2hYSb3DsVBO+0X+n+sxnICdY+0cMRiB9JjCONHlXoTKAuaWCvKdFQ5hN2LAgadeT
         7hm417iiLUKL4X2uQFizEKCpn75xAUvfMvXRlDqxW3Q2HELwnvKdVCg6t27kW2zhSioE
         TTt2Myhvxl3DZGUocHP+mMVCaIUluUb9o3Y9cI+N+ktrruqBHwmv+dsNxtKt6hvFaNPS
         80SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782234275; x=1782839075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
        b=e4AtgucWYYgWpt5sMS0CnKX19VmWcar5VBqIGLC5uKuJaqiABj98ORCK++ET3US2uR
         jksobSSTG1VEN3FLECoHySYgLzbO5H3AeXb2N0SlQznVZHlRYEeJI9dKXdBU1GPLKicM
         onD8PFmnIJBAX6dK4jUBhRgydiZBNzj/0M1sRzZ2DybPLCwFmYhqVIbqF8eH9QOr9Mkf
         YXOGyIs/JI1riPuTjiQ/5W/kHKYEJZmI+SRjyvLWuqDgfft2pBjaPVxQi8CDiaq4Yyu2
         rrGCm4QdCoKWFotq2HF/pYffvFW+2Q71H59ee+lI1BEAqqLlip3xkYNtxe7tPwx6QrnO
         l0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234275; x=1782839075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
        b=Wr49ov4GXqhEkNk95Ptc5QF6AQAGIoiEH8bLEY1Zm2/LjPUlsekcaEK39/LpC12Szy
         peDJtDv0dl+j3VMGGEcwUEc5xhRMgBe+x1DTCebU3JbYbKBYO1QFb7rKh2zHO+RI6pog
         uooTrbU1RvclmMmtJRZj5JqLjaLOl30yFy1fTPWnXrGKI+kywq7Zw+qyqoNJYFL/LmzA
         SuLxEmTzOHDJWn5VZchkxffP/UkkNSUxDNowH9dxxgt8KUXdkSQVTUHyEz+hxfqdRIFN
         nnjtpf7TNEyu1Q9KTVRQI3E1UUYXRaedwMZ86RkB44wjNo6cUN1KpBSU/2xacFdhlicm
         uNZA==
X-Forwarded-Encrypted: i=1; AHgh+RqoK92/mytS4QEOYaWoPgVSh5759lQ9EU4Qh6svVReM0d0k6pviqklJb3zp5K70cvKAFTV2K50RL4O/k8iT@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgZJ2Kw/S3KpOOn8NmqvuvXD33jJtpjbXVJG0C57ZQaWjtHOV
	RfhHbfAZQ2GOQan+gIa2gw7OuzDae9eP5ZAL16W0AUSdkn1EflLY0X39Rz79/Tlkm9zrLnNFL2r
	3r4DuJvO0YrClDgM20sMMIEfXTebq4Gc=
X-Gm-Gg: AfdE7clos4+Ibwn4l6VsZhy3C0QjMSedRhdC98Ro+bEp9Wnu1fLJkziOHByCiu6h9Gi
	o1rx2HLuqs9AIsKfSVEDgr+3rXATYW2UpVVq7uMo4RxSUNXJ4zkI7iNB7TF965BxjJ0K0hJsG2x
	boaSksHWzSA7XeOz7nBmgR43M0Ozu249hn5e7JslRD7meWXv19bzqkANBVQ4+1s6IH8A7nzIq/w
	0jM3Zn7f+5W7icUq8ZrzP+f06IOoAx+0cmgjL8pd2hlZ3UByrAQ9KO2qaPAu2v94HVRlwJWZUFv
	OdG22tdBWt+L5A9sbfOts6NRfdwa8Z9jnInCA04aqMeIpTdNfRkQ
X-Received: by 2002:a05:6000:46c4:b0:464:5df5:332a with SMTP id
 ffacd0b85a97d-46add1841f7mr4198572f8f.34.1782234274518; Tue, 23 Jun 2026
 10:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623135208.1812933-1-hch@lst.de> <20260623135208.1812933-2-hch@lst.de>
In-Reply-To: <20260623135208.1812933-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Jun 2026 10:04:22 -0700
X-Gm-Features: AVVi8Cdq1cSEiVKuIT7rCtOjoNPEfhV6BkfHSOO37MXbTaAKd3fDSsQ7oc8pKTc
Message-ID: <CAJnrk1bq7pJEwwDuimp6GzCfdhrjhzs=MFAdRLOAdkJWmeSg7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: consolidate bio submission
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Add a iomap_bio_submit_read_endio helper factored out of
> iomap_bio_submit_read to that all ->submit_read implementations for
> iomap_read_ops that use iomap_bio_read_folio_range can shared the
> logic.
>
> Right now that logic is mostly trivial, but already has a bug for XFS
> because the XFS version is too trivial:  file system integrity validation
> needs a workqueue context and thus can't happen from the default iomap
> bi_end_io I/O handler.  Unfortunately the iomap refactoring just before
> fs integrity landed moved code around here and the call go misplaced,
> meaning it never got called.  The PI information still is verified by
> the block layer, but the offloading is less efficient (and the future
> userspace interface can't get at it).
>
> Fixes: 0b10a370529c ("iomap: support T10 protection information")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
