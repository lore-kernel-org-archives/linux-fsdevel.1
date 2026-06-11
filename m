Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2393314B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149837; cv=none; b=hG9KwoMJYExx6mfGYmuwqaysfkW7HeinmeznqjevdXZuZO2wrKL1yzprbJuzGXHfZbIZwYyDbmXqxYBdoYlPUJDtl6wF6mzbVvbmOEV9pZGv9SUThrfw+PrPmMHJJx6oKGTpQ4yrgj2IE3T4F7G3N+K/x3WC8v7Q4Wu6Sv3G4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149837; c=relaxed/simple;
	bh=gz/msjdtOunMEex2BqTVGDc/ZG31euGpU4mAhP/QZRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4ECiziWGjydsaOp24x46JK1NFKafbOVH2H4/r0QcwmzhJp1UcN28/4r0RxVw8ile5v7R9Bs3nAZHpURnAdtMYBvo6MNk4oAQyH7S0kje5LAs+RfcTa6mUGkbG3Xpx6oJZhtMnfa80XELkrBq8mOaaUmlglrlp/RXmxkOYmm33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Eg91DVsc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Eg91DVsc"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa6c66e6c5so4567114e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 20:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781149834; x=1781754634; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVrzkqwtVWnUjAk0pQWrCKuHIZWdAIMxGLk/tntdOl4=;
        b=Eg91DVscJNYnZU9JOPFYnyXIxVJc52iQBBSVwinl7VUijWvWXslkckyw5+vOoB+j79
         P3eGDZizn4/ZiPFZ5M1GgvLKJNJxeuQtDDRhEYB/U9MqpdpVmThzEEg5i23RGJdav3/u
         CIGo4INay1vUzQuTxbLObLxF8ohOQtt1hoNkmgNN/EGq0qEGJhENJ52Y5XcMc/Jn/9nr
         eqlT7t201aI0mqrDC20H1cqrBk8fVDtkBAOncqs7u2L25J7+doCigq9iwm1F7LeeykT2
         rNBOyOA/mZZQxIsOg/Oj2YonN32T5UyHjP74FCGM0VGcnrUuLaofM1splyLvLD7GYp+3
         zcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149834; x=1781754634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVrzkqwtVWnUjAk0pQWrCKuHIZWdAIMxGLk/tntdOl4=;
        b=ksUTm73tA/dEVpwRGNVGvu+ctR/ldNwzfSDISnKgSTVMrYI5LnomxgppeKibQnVQj0
         mU1/d1ptRcaxZykVu8qd7fVUdzl91kBPSDEqHAV+2lecuUevVLha8D381YhOvCEKv9N3
         2ZZ2Cz0UGdmdM5sZqFdNbWLMKk+7AKVsKkx10Xi7ENwlWLy8a3x6zWksJ1McwHajQuej
         PSiL49ikQbsgAP4Xl2vuVM1RRdPZ0XQDowZ8uA3M7Z8fqHo+vSxvXvpytuHs+jtdLtxc
         EbGwTmEyf8QHUNvejDSfz47rJASBPpqsdBFzgC7JYRxo/gzpP12LENGvYRyoC8aBTC7i
         OYYw==
X-Forwarded-Encrypted: i=1; AFNElJ+HO6/4p+nc5ukoYdXxOliWSICPZiKX33rwYdMi20DI4kXEaQDpjfyPFvKyKCqtkgMYl0qE7FjVU+F7eFS9@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZ1f8N5e+A8ffUL/9J8ZjhQM1Kef1uPdE8DbDLX2B2qIH/r+F
	bayObUTVpqPtw9Jfb71kZjFef7YLqa74TpvEwqBwiiNIvbjSe5z+wRfSIV6j5nrWPYc=
X-Gm-Gg: Acq92OH6Id4BLVHPpU0fVBTFEqIO45sa8RBr3zwsrgkzBbjdYt1Y9nTr9AmK4P2MDWj
	NCwL2868zIlGpF/6xCsh10Su1jpEwTbJiLSlXOkdLOt+mSAoh9xf5ZGohwQZ07b193GfKrXO/rN
	YGXfLrku3Qdb9aEN0eE6dkxCSGpuBH7DmXBKiUbhh8SwI91E52f9VKLhbCt/ApqF0zejL/g1cW7
	RjXkUjEYNwISTJUejeX5edhFsm2w4xzhFPUpUy4AaZLRfI2oOFWKmSAw1BkUAtvuSFTKONsftYp
	WO4KA1rEfgc2VKGMDrTm/QEGG6iVFgEUekkB5sLpQt84DTcsI/kNusb6NfdxlgnvGwwjW0i7T/k
	I+UMgYIofJm5kXH9POC83EjxqD1fjbOCWTKiJqXR64oaUnedGD8mZRK7k03+/dUYX5BQf+6W1QI
	JCh2tZFVjzRiInRqQ6oSxhkgL8N4fUEKJO/nyBOGF1tB4SA25+tOHSULFaIeuSJzMwT0BG8yd6Z
	5jjvnC1PW7QvW0AnL77mtoe1U6VuPXMOsjVdfN8IEZvEDjfm+B0jbBIRGBch2Mt1lo=
X-Received: by 2002:ac2:51cd:0:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5ad27fb70bfmr251340e87.27.1781149834211;
        Wed, 10 Jun 2026 20:50:34 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc8d9sm5921278e87.28.2026.06.10.20.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:50:33 -0700 (PDT)
Message-ID: <2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Date: Wed, 10 Jun 2026 20:50:33 -0700
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

What's the point to mix memcpy and str*() family of methods? What's
wrong with str*() method here? Otherwise, if it is wrong to use str*()
family of methods, then why is it correct to use for second operation?

> +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> prefixlen);

Why strscpy() is better than strncpy()? What is the main argument here?

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

Frankly speaking, it looks like a constant that should be declared in
hfs_common.h. Even if we would like to declare it here, then it should
be const size_t, from my point of view.

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

Finally, I think kzalloc() should be much better for both cases.

Thanks,
Slava.

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
