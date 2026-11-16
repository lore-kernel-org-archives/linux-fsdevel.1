Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794824742;
	b=V9YD+3RFzUw+HUQNG63aRRKcUN7uEkk9ECxnwza2kal3ibP4anvPH18Frj0jplBNjxcz
	 eqkJwMHQJPqU2TbXMw01qpeSpx7Lf9wsQXTRWuu3orwWqxisF3gOVn32Y1sF8Lbr5ppvD
	 hHAjMlLPnZtQAP6h0X1LAJPrjHkXsAsWvFwasGZ/fkk8VhM5yU3pHHJLq7dk/mC+JzsUb
	 mPuQ+f05fDD1r9CmZe4RsNC6iEo7jiarzTXVeqOwjXGXGLG7k/rh8TB1xTUmHkl7M8wrX
	 OVtjQHAccytu5TyUJHKXUuhzgx/Er70ifuxHKroG983UqA55JgoUmcviyeOSHDmAGxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
	b=5N4TMBbDrk2MDtdLgLngEIcPuNrypZLS3jPdyM/+YNGvMMYj9QKP6+tqqo/liPVYpJKo
	 p7y2CJ+HGAqZHGEENVvvW++Bqw1/PMvKsW2GOX89TwmzryvZYr3SU2SvPHuQCDEqboAlJ
	 x4c+3RTXX9KyVGOVJqsuu5XQxi+MlmP5QAOwbbtq4MUCwsimqhdiNVwTG05URzEDsp6zK
	 P6GO/a6vgXyzdrrdNEaaw4CT3rSCG60wIVNUx4NkLZqQD5+Le71KIjfjOxnDexLF8M5GL
	 5qMQV/1iyVAgadlXCkr5uH9+0+dm7nVvj6SKo4BkUnxD5UhIS61Q2P94JYfJ/AHQFOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoxpA8a5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18F606A332
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A18F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoxpA8a5
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso4556632a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794824741; cv=none;
        d=google.com; s=arc-20260327;
        b=ofuOOXC1wCRRqNjooSjwf4acXcoqx4Q5M34e9ac287V6gKjs5g2QkUkHB8zoFobdIO
         Jmm4nC+X4NjjmXLDbo/DWp418OigtiARWKHDWNgB6oPcWapxl13QXzIe/ilOZrI+3Ptz
         caF42vWGt6mlzNvDutj4gXu+zBFYHP3UpmwMuhjEDaxRbktOMkOvKAu3x52XxQgFeyON
         XG4WxvqJWW1iB6G29nKUHNPMzCzSncOH3y/LQx8JuQWUVI/+vxxpNwfu3bgOxGzd3a3W
         vMUd7alq+L7DKmFUKpwwns32oF7XNpBF1HJmzRrc8ViSXVpXADkM1hk4SscwxvbqxQiQ
         8nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
        fh=17Ms7h6zGtQD+xjt61WTZcRfnsf1d9CCep0EIYFEXpg=;
        b=g5zOqLQ26OAelfOLxqijKbM1froZDL8Isx3ELeQcqqHD7SpyCnPsuCOowRcxUB9q4g
         OgAnVrWZ88b0EYMi7vKeZNkaiDl401eyE6rr7s+C6NyHM4JQomMo5+SqcrqWorsYcmpR
         ZHyFAWo93gO8CR6FLyUoq8GOAFJIHkemj4yEEiurYR/r00QqoNaSidjwKsZmJ+wWfHH9
         mt1VPHAMtXJO6O5OAQdLt9vGkle47YZxSyNLawkCL8IELzhuZb51pI4/Mw+O0eqWYk9s
         of/ZkEOXgY2YfUBHCeU+L4lWSG2Nf8vBrdZmtP4ka6WZ4Xzs5KwNPQacXvEnQhD0iCnI
         mZAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824741; x=1795429541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
        b=FoxpA8a5gWZOiOu4kERAMuUcjyr54gqPoKqiCFVaESBeI/u9TZiW1xZ/8iGXSeL3Ru
         wggr7cd49XGc3Nzx9fjFQIzsVPlWqwNb/33jZlPsYOLZl9dBJczNhPUF9HTIZ3+Sq2DL
         HgpJEHIaYVeehKTXuwao+M7tue+uYok+bSoKtMvnZ5q2JhxF1YJGNEIyjjhAMWVM/k2r
         A7liHN/ZMi28w7H+f9Am4XfgAPAwWkrkdyk0qm/IIwAEOLKwHVBWyQ0GoCjPXrJsVgVn
         jcUnTibHbnEUKqt0uWhMgZLL/kfLxFZVkPj5NQhU8tT0FPGJSUD4UjZqKzOqU/uj6cub
         Zl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824741; x=1795429541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
        b=cY9/RMaX8ZkpXtUP11q3VyPxhksfbfeV/X8ge7j39NeHOiuMPzLiXnxq9AzXxzA3E2
         1A+WvjcVxts0EyKFJu6GNoqeAw5HaHmcyKpyHwg5HJnqONQVEkpb7TCI9G22AaOMJH7c
         epvr5VuPdfEURfD+CWWL/YimsU86kx11wCF5F91wHy4Ry1uqY7kdBCxqZGxCI+j7bjUs
         7Oxe0xRe+di+j+rjDRBIDXS5krZXImlMxuCSL6KXR8SqkskyoZQLI/wYRllk4UiqIhft
         DOSY5LCxGQ2J1jhyCHPw1eDvRc7683nsS0rqt5secvQufKBjfmeNZX01gaIq/X111VdZ
         u7LA==
X-Forwarded-Encrypted: i=1; AL+hErHeoLatEXzhJf3ABvVoWLCjs30qstf+R/Q9P0KUnVrotFnnuFO02DU6xa69x7ILlSj+mtZ94OLo7CeAAfkP@vger.kernel.org
X-Gm-Message-State: APuU4Z97VPYum/pFTKTvxJo49qxu/y8N7AHcdSyBqnV8zGPMoDn4RU12
	NOlJ5HhCqRL9YXMT5+XXIBGt4HyIX1tAoyusEsqx3abosG0cWAFkJhLQ2vvQXGWLbUWu5mSyUvq
	wsLY27F9ikA73L2VKRGxYowA2JKIo5PE=
X-Gm-Gg: AYBFou03+SCE1tvb7l2gu3MXWM6nLWEXraIFyU0VQ1qRTs9QjrbAJ1UsiLcQhbsii1h
	wkG0ebboBwi4WK9vzrSFNxOLUHQNWPge2KzREwGGgimep1xIQYJrjZMgs9Fk2K398+bCCdDnPIk
	OtsC7r1y02ZauB/9zrXzTlkOqBGze1/3NVTYoCPLi3Ivp5v7uAKOSFrpbuWPFH9G3w0NGlN4iCd
	aQdBInlqPddHP3ho4U/xaxUFUrRBHdc6VzoxlExqDomPcF7rCtRtF2Lrcos9AaLTHf6Qc+cInvo
	2mhxNgOiQPgks+HkqkHV/P+MLjWhIJ7iEosS5f8vQkXCXmp5BMs/KOsqiSCklq1Yljb3xFkeV4x
	KrWxWRBQznUPA+o+Nny2edaAKSzz+3C2/AaGgegeXimiHHVr2R4cDrc3oRhgdTs30jZyBxdQ=
X-Received: by 2002:a05:6402:44d4:b0:6b5:79f4:8d52 with SMTP id
 4fb4d7f45d1cf-6b7c0bdfec5mr5191329a12.20.1794824740409; Mon, 16 Nov 2026
 02:25:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com> <20261115210952.2140036-2-graypanda.inzag@gmail.com>
In-Reply-To: <20261115210952.2140036-2-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:25:28 +0100
X-Gm-Features: AclHuK_tvQFpSUcAQinoG9gfJrRW-rTLlA06tTqM7lEBJqVuldEYzXKf_TrLdL0
Message-ID: <CAOQ4uxhZS1w24GXWphu-PNPbGxVJUDwOfqHdRZcb05+_HVv=aA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: reject embedded NULs in readdir entry names
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Junyoung Jang
<graypanda.inzag@gmail.com> wrote:
>
> parse_dirfile() and parse_dirplusfile() reject '/' in dirent->name, but
> do not check for embedded NUL bytes.
>
> Unlike plain getdents() buffers covered by verify_dirent_name() in
> fs/readdir.c, FUSE READDIRPLUS passes dirent->namelen directly to
> QSTR_INIT() in fuse_direntplus_link() and instantiates or aliases live
> dentries via d_splice_alias(). A dirent name containing an embedded NUL
> produces a dentry whose d_name.len extends past the NUL terminator,
> which allows callers such as inotify to copy uninitialized kernel slab
> memory past the NUL byte to userspace.
>
> Reject dirent names containing NUL alongside '/' in the FUSE readdir
> parsers.

My concern is that there are innocent buggy servers that pass NUL
maybe even because of length including the terminating NUL.

It would be more considerate to make this check in fuse_direntplus_link()
rather than to fail the readdir.

See precedent in:
78d04af4995a1 NFS: nfs_prime_dcache must validate the filename

Also, verify_dirent_name() never checks for embedded NUL, so all the
other filesystems can get away with this without failing readdir.

Thanks,
Amir.

>
> Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
>  fs/fuse/readdir.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 1f6cf565477f..e8b47c2a9103 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -126,6 +126,12 @@ static bool fuse_emit(struct file *file, struct dir_=
context *ctx,
>                         dirent->type | FILLDIR_FLAG_NOINTR);
>  }
>
> +static bool fuse_invalid_dirent_name(const struct fuse_dirent *dirent)
> +{
> +       return memchr(dirent->name, '/', dirent->namelen) ||
> +              memchr(dirent->name, '\0', dirent->namelen);
> +}
> +
>  static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
>                          struct dir_context *ctx)
>  {
> @@ -136,7 +142,7 @@ static int parse_dirfile(char *buf, size_t nbytes, st=
ruct file *file,
>                         return -EIO;
>                 if (reclen > nbytes)
>                         break;
> -               if (memchr(dirent->name, '/', dirent->namelen) !=3D NULL)
> +               if (fuse_invalid_dirent_name(dirent))
>                         return -EIO;
>
>                 if (!fuse_emit(file, ctx, dirent))
> @@ -307,7 +313,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes=
, struct file *file,
>                         return -EIO;
>                 if (reclen > nbytes)
>                         break;
> -               if (memchr(dirent->name, '/', dirent->namelen) !=3D NULL)
> +               if (fuse_invalid_dirent_name(dirent))
>                         return -EIO;
>
>                 if (!over) {
> @@ -461,7 +467,7 @@ static enum fuse_parse_result fuse_parse_cache(struct=
 fuse_file *ff,
>                         return FOUND_ERR;
>                 if (WARN_ON(reclen > nbytes))
>                         return FOUND_ERR;
> -               if (WARN_ON(memchr(dirent->name, '/', dirent->namelen) !=
=3D NULL))
> +               if (WARN_ON(fuse_invalid_dirent_name(dirent)))
>                         return FOUND_ERR;
>
>                 if (ff->readdir.pos =3D=3D ctx->pos) {
> --
> 2.43.0
