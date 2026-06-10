Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13170213E89
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053494; cv=none; b=hNUVNQs8sffmQsfPiq1UrOuryKfR8E+TC1sjUZxI/tWX1nb60xyCwBCg8Tkk8nHskmrfblk2QqaeU1sCl/V4GyH/46RMwCDGI2Kl6lck/XLbNu6eL4Qb8bs204Y7U9yK/A1Y55lFTJoWkv38snZDUjG1amEIvr/JR6Lh0v0Bc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053494; c=relaxed/simple;
	bh=BgouVNDaMkUocleo1nUzgz4x0HgWmDSLRPJA2tZ6RAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G835w5Zp+ORKUsupGnvSx/MY2wNbSPUjgTDOkCjTnnXT8fLD6qPdh1Uoc9TxLbg1r8HHWSGQwYyKBnaxRQ8ZVP/QVSTwmBrJZ3QwS8aLSvJt98YfqlllkhUs/HCqqryAFrUcpJBNDn8BEC7nZ9K+Vys4mNCyL/L9rseZR8K3U1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=OpBsK6sl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="OpBsK6sl"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-396bed274b9so54329911fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781053491; x=1781658291; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+IHp2l2rrkkQsrMXx/C+M6l/022rECrJz/KtdXmcpQ=;
        b=OpBsK6sllyNkGqKRBfe4snDCkwvgWNNmmjknzfUGHs9KaUxPVjF9hckXGIf0OhYP9A
         UaSy3d6UiqtuaskdwxT5WK2Wz4gSCUfTCUiludAJyBD6pIlylyHXM5mFDyV04CFfWJF3
         WX3Xns8gpbWl+XDEDklQXRN6bvaiZink8eXTCEgQxAo4S5wOyiLI6SbfMcmXQZP70ssy
         g4Q/2yOkjx68lPa4peMvIM4I/wa9k/oOE/+uQRZ+xoJgB7qxkU669r6luy2O0LJodNzy
         xpqZ94e1bUIAILuG+QCrcujFPQbxyDyyP+Cmekm3gL1L+zXBz6Dzue+hFIFmRv6qSHEg
         zwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781053491; x=1781658291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+IHp2l2rrkkQsrMXx/C+M6l/022rECrJz/KtdXmcpQ=;
        b=Y2D6kN7qFCAiurrGpKMjTj3MQFbCiKTPCfLTn9IwmIzt/eqzSo9P22HWkv7CWKHWvs
         j8C5un6kkPyLwt4rIDpQGsp2lvaumz4Xtdy/Y26yYSOizPGl3RHXRmwnDP1pGyejaCt/
         Gwaf2kNOYiQKD9bBFR2XgWZMlQtQJIpRi1f9uErwkcXypCA95OGi5XAG8BIwVkxYDl5T
         kJAEcS/mAjobOWCqWzpQSbPr8CObOA8CsrHeW/CB0oNtyw4JdnImE6IL1eLL6KOTbFQW
         0EZx66y2OfTIjovVvH0/DSrdXJlqXeUFdQBOe+ptFg732ZYnv32y1Tlbl8vR13tYY88B
         UX9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+r7ITgmjoRo1SncIuDfHzVJaEkGKwEEBEUzjgz5QvJxJuxfsalxJD9nxk5TTjYzS7zT7MfKBco0mD641Bf@vger.kernel.org
X-Gm-Message-State: AOJu0YyK58O+NuA6EndL2tXPmqSkcPyliWSt54kGVm5IVzrNnJRpkp9l
	hYgozj3Fj8lBQtuFyeA7C7VjWIP+HHdsTX1HV3KXcD5S9eeft0G1yiKhRwv4C5EJdeM=
X-Gm-Gg: Acq92OEPC50sFwUc0VWaYjIuyhHlHTbxa56mungu0U8dHpbOkAiC6X9w+vAm+z1P2I+
	vWyJtlM9oKE6xkkNeTPpW8mI4WlI4/0BJlWIcroDq0DKh189flobNeJTEqUyOZ2xoOAb/Lrlzyj
	RxP2rzniTm+t3SPXvUGtpItPr6JNA9ZScTaaSV1L0m11NFTwXlNio+l71s+oHzD5oxung/lDXkd
	lJTQqtfUfarIXG43HI4/s0dyFmVQuXv2P7JyEtd30mKGFJ883uB2Qpiz9uQgGVvj4VB0lzLpwcG
	P9HNGmC6dRcI4DbQW+fvChwIqtZlepeAY8yt3MFiYrY6dU9AO6jcxuyHn14T0Ipi3KDLcEYq1X2
	ZKiRXV2/zt/l+l4nYKtOUd5tbBwU3YhkI5IcqCnO0HJv1bccViu3c6yFzlNC0xrjm8epMZtR1T+
	95bPMbVUJ+USmHj9P1BEetCKV1oixiIw/1W09wALuKKLMWzYLqnhgSgeKEpY4X8miiYipB4j45l
	IoXMEDwlJAR94LMaW/tI/uIz3EMM1GhMH/GulHkGIjuX9gmbQMyF92cJqVMQyuZz2krch4jt9IH
	Cw==
X-Received: by 2002:a05:6512:108c:b0:5aa:6f5d:ee0b with SMTP id 2adb3069b0e04-5aa87b8b34cmr6193269e87.2.1781053490709;
        Tue, 09 Jun 2026 18:04:50 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac3fsm5007983e87.42.2026.06.09.18.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:04:49 -0700 (PDT)
Message-ID: <45e421ab38cfdbddbc0d34970a2db94902ad634b.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Date: Tue, 09 Jun 2026 18:04:46 -0700
In-Reply-To: <20260608095523.2606-39-david.laight.linux@gmail.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 10:55 +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>=20
> xattr_name is kmalloc()ed at the (assumed) maximal size and then the
> prefix
> and name concatenated together.
> Use memcpy() for the prefix - its length is passed and strscpy() for
> the
> name to ensure it really doesnt overflow.
>=20
> Prior to bf29e886b242c the buffers were smaller and on-stack.
> (But I cant see the copy in the old code.)
> I am also not sure why the buffer isnt created "just long enough".

What do you mean by "the buffer isn't created just long enough"? And
what is your vision of correct implementation of the logic?

Thanks,
Slava.

>=20
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>=20
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>=20
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>=20
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>=20
> Note that all the changes are only compile tested.
>=20
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>=20
> All the patches are being sent individually to avoid very long cc
> lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>=20
> =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2..0b3dd48c28c9 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode, const
> char *name,
> =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> =C2=A0	if (!xattr_name)
> =C2=A0		return -ENOMEM;
> -	strcpy(xattr_name, prefix);
> -	strcpy(xattr_name + prefixlen, name);
> +	memcpy(xattr_name, prefix, prefixlen);
> +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> prefixlen);
> =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> flags);
> =C2=A0	kfree(xattr_name);
> =C2=A0
> @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> const char *name,
> =C2=A0			 void *value, size_t size,
> =C2=A0			 const char *prefix, size_t prefixlen)
> =C2=A0{
> +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> HFSPLUS_ATTR_MAX_STRLEN + 1;
> =C2=A0	int res;
> =C2=A0	char *xattr_name;
> =C2=A0
> @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> const char *name,
> =C2=A0		inode->i_ino, name ? name : NULL,
> =C2=A0		prefix ? prefix : NULL);
> =C2=A0
> -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> HFSPLUS_ATTR_MAX_STRLEN + 1,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> =C2=A0	if (!xattr_name)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	strcpy(xattr_name, prefix);
> -	strcpy(xattr_name + prefixlen, name);
> +	memcpy(xattr_name, prefix, prefixlen);
> +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> prefixlen);
> =C2=A0
> =C2=A0	res =3D __hfsplus_getxattr(inode, xattr_name, value, size);
> =C2=A0	kfree(xattr_name);
