Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FC19CD1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928755; cv=pass; b=QrG5l4u25QNR3Lk6sFB4VZFu/H/RL9e1RcMkoQ6XHe7RY4cdvAOSJuGsno2jqQtLGdw0EOoIcsj+/b70LdHv14eoOr41k4L+Z7P4DVEBbZbVQCMl4SJpWkn4A/Y+O+fh13H5yuBBpuNTaFrbPsW7CY6ThtdvzqtwL3SRZT1YpkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928755; c=relaxed/simple;
	bh=otVZGSU7hrjCfkPYFWYdvxLSEHvNiwry7YQ1LzMkwqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FB3Tvqq2snLHZtQ8Ik8sI86LvPU+xgPb8NX3vl1KOExMRc0XIvvRr93dQo7RAam58b/ouo8F+Dt9v2qaaoPqclLJreEfcfNWodcBAtQ9e8CTprl8qZ4Bk23u522+y2cj9Q6zOydBQ+LKYuW+72RU+XeBKMCQoyGoq3uaioAKiyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QYcl2VZZ; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QYcl2VZZ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5eb0fabaso43661041cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776928753; cv=none;
        d=google.com; s=arc-20240605;
        b=lviprenkHYN/WmqRmVYrhy2xcvewP3DPeFme9JhU9VZDOhnhpiXTwFRGQxcDK0JKEY
         HduFaI+cnKFYNNmDPGy0BF7BNcqB0Dog1E2JpxovvS9ymnCKKnt/9nkUjWFoN5FQ75nJ
         bwGU/aWAxftaOz/gUJkAe3v+qS9a+hIsBhoY/aHmHvA5UKBsKMpNgmm+48mwk04gkj4V
         OKwITm5N6eUVBvoIEILd2rjklXMPB0CT/ebgYIgdLjLOdD8oC0hSVV/JpcwmgHMKYvSi
         zganC85zhL3doOzo1rSjZm5axHvZT2FzdD0aD+ywkW0HeQqPelncBj5wOqPtrLMB7rNZ
         xO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=otVZGSU7hrjCfkPYFWYdvxLSEHvNiwry7YQ1LzMkwqQ=;
        fh=OScJDAAJ/ttiZ0VU8x0BznQ4UKIZ14Y93W4CK2BLNaI=;
        b=SJ2dml7Al9IxTqMFDWj8vyQt2HoRaaKx3gyoSrRD2VmZAGwyYVWzbJ7BF1nMDE50WR
         AdibCZKWzycAJlURUZ656iFq3tiBusp2GqwgeuZrp9UuFqV1dmctq6eieKaWdxCVXOSL
         bt1sycwxskNTST5F6srbGG1TWJ4exHgm2Ett28Z+48XZsGW5Jz2YZro62P3zI/EEu25O
         DDDMkm/hqHZKcCaDqdAnJMtyLw+7LrZb3PbOSAmsOizAFSwMffbCbncD8Q6GCuZO/snt
         hz1u9mmh5Qb75NBeXXyS/VwjghZ/DQoXw4MOPfa+CptfPRtbaqQYq7o+mtM1ZUU2r4T8
         Dpjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776928753; x=1777533553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=otVZGSU7hrjCfkPYFWYdvxLSEHvNiwry7YQ1LzMkwqQ=;
        b=QYcl2VZZ5KzA3lAJIehje9oA5SkDHORURxMsHaElIYFnI1PnqsYxZc+Q5xc3hIzrU1
         tpo6h4mFWgMrABowJMhVgu1NjyhwPm3OEFLLWgnkSxZESzgxvS/OSMk3bJ5Z7ILbPyma
         9xF60QohGfgpXYtS8iDdyoVTKmH0XU58XDWHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928753; x=1777533553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otVZGSU7hrjCfkPYFWYdvxLSEHvNiwry7YQ1LzMkwqQ=;
        b=SVII6hSv6/6EluGqaxarzVo2NDhJvl48cTSRQlz0GGNIToZElCENG6lhYkjdOvPkwI
         S+4bqGkICfzBCnHdn06h0qiARZxjqS/pE+m40dTT3CUG5DZxqKDW2qxYQU0o+hz/Po9B
         /ABGeyUZ3VPKZrSOnNIAVZ9x4+mIQgevqYWVtu4e17x2ectzBJBSF7bsATnFe9aVUCrN
         RU9Tep01WT7bCKBp2QQIlctT9nCItJt0eQLuMI4/nBvst6x9FnqcGoa/PhVn0WXUkwpf
         SSu0P5snd/tVs31bJ9GPxemTGj3lwPTxCf3IZ2CBlRfgxY9MYwt+XanlB97BCyAxMCtL
         kMFA==
X-Forwarded-Encrypted: i=1; AFNElJ9w0j3o6cGuWYz3YagQ2n/SeqvdOnfLD0aiugoC0rLXb0nn4IQ6yrp3L8RWM9lcN1XX3xiw9hz5H/J6biE2@vger.kernel.org
X-Gm-Message-State: AOJu0YywnjI/jy7CM5eujxwAbVO3xRP5qXR6l//fHMhf5X5Wv+CBcsda
	JEmI+ZpA/KLvG8Mt/l4LkEnWAalg7faPXAYIxHRCIxEoMeZSJoI5eEYCtTnUynwn+PZbOJ9LpgY
	ubR9WBvENzIIGWaF/yTRSRg+bdifBeh1P5i+jPaWO9w==
X-Gm-Gg: AeBDievFsko9rc72su4i4nqqJj8/xV9hyBVnntcio+fAYSM9uTvITBEgLr35MPe4Xup
	uI/Ky024+qXTxuZzShV/gnH+tuKe5lV0ZHc17PWtMOEPQYREnFO54ggAXOQF55GQXD0aG8Yz88Q
	CNwI1jxuRe6b0NXAeL0scY7ejd1V1v07E38S0B96apepgqpBksDgcXAp5j79xvqKw6y/bE0QqiP
	McIh07hP/w0eEltgYF+nObNxhO+OU6tz9IVKaK3w3RfE0om+hOIVjqpVSeJwfsVlHeeP09Hd8Vy
	5Mlv/MJ/eq8JyjdDqZm3Mmh1yvpnnGLuUWmXc3XsMssSYL/GoJAeTU6UxOu4IQ==
X-Received: by 2002:ac8:7c55:0:b0:50d:a248:68e1 with SMTP id
 d75a77b69052e-50e36d9c0d6mr386250861cf.56.1776928752957; Thu, 23 Apr 2026
 00:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-2-mszeredi@redhat.com>
 <3c9f8396-41f4-4c88-b883-34bede72b427@sirena.org.uk> <e3ad44f0-0a3e-4ef5-ab6e-c346814c0104@sirena.org.uk>
 <CAJnrk1Y1JzKJ=RCLBt592EZ+0=hPzaLWuHve_umxtUMOSH76dQ@mail.gmail.com>
 <CAOssrKfVKvJeriSm7zeRd8xd6mMgRqc3YkpY6rehBtGSy=JVbA@mail.gmail.com> <CAJnrk1aC7za1COhMOKe6abhjCPhV-OsNN5v_-dY=qs8ROsG6tA@mail.gmail.com>
In-Reply-To: <CAJnrk1aC7za1COhMOKe6abhjCPhV-OsNN5v_-dY=qs8ROsG6tA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Apr 2026 09:19:02 +0200
X-Gm-Features: AQROBzDcPh7dxwLx_eFSkMzIa3VScZPt6A_mGwaSV9EjaKlpiPa5zofPjpCv60g
Message-ID: <CAJfpegv7cpR4w4td2LiUpGHbMgrjp-hamh3PwFu7Bd-PvRGVyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead of mount
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Mark Brown <broonie@kernel.org>, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>, Aishwarya.TCV@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 19:00, Joanne Koong <joannelkoong@gmail.com> wrote:

> From e434521edf44596239a07838a1a8b37c5f0464cb Mon Sep 17 00:00:00 2001
> From: Joanne Koong <joannelkoong@gmail.com>
> Date: Wed, 22 Apr 2026 09:31:23 -0700
> Subject: [PATCH] fuse: don't block in fuse_get_dev() for non-sync_init case
>
> Commit a8dd5f1b73bc ("fuse: create fuse_dev on /dev/fuse open instead of
> mount") changed behavior so that fuse_get_dev() now unconditionally
> blocks waiting for a connection, even in the case where sync_init was
> not set. Previously, non-sync_init opens returned -EPERM immediately.
>
> Restore the previous behavior of returning -EPERM.
>
> Fixes: a8dd5f1b73bc ("fuse: create fuse_dev on /dev/fuse open instead of mount")
> Reported-by: Mark Brown <broonie@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos
