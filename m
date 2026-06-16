Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61643DC87A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591597; cv=none; b=gH7C0bz8eOO8FnuWC4Qzxyc3ZBtTHfjqug/yRrm3SpurqHQ9ulTvqgfi9ABn5uGfoCn9OxIutq9x9yVoaWewbWqnJFzmablyD7PhchLDxJ3drFRsYhN2N6sOUJD6bN9FnbXbBUzhtsD7uvLsIyrP6HZ45lCOUhNqOqirlQfIh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591597; c=relaxed/simple;
	bh=Ly1Qk435IxkfEda4W8MYRy9yxk0g8XFd+/9qwNlkoFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zb8AH8KobMwSRhuxEZebjVY+36PFL5XfE1n1tdvWBj3koSjkYjGBBRMnGDF5Dtp4orVmzoFPmvGb+F6cjjmi0Xo9f+HDCj9WKunLQLTtfyzwF1/mNZ+RMxSefC74TV2yuoEV5JgYiQlGNLS3zSMUzPyrrDaIKaQIY2ctjEseJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=HSjS0ygJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="HSjS0ygJ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so4721385e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 23:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781591594; x=1782196394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c3qmQUhSpMXt5iO1CpMCJnf1Ep7kmPs8a01Bf2lLn2g=;
        b=HSjS0ygJ6pSTIoAgRoQzicB22VrKgRq/nSrt14N8sWcyXZQmlpnaJoeD5pBUBbtdPP
         7SOxB3X9FdAhlbGVuk1vSeKwHC+C0o/PGOUYVvREMKf6XvV5W8XG7TwJY8mChfM+IYwY
         8uv8KFwuGqc8H8Cp9mFFNKA7OKKLAk0XyAH64OY9gAW8jXSqoKH1+gl462IU4d9R3yNi
         QhsvVwiac6b5/hYZdbt0OxWc3n5k/BgGzUcKjvlXrn17bl0AxaENv0eDII+AQRnGe3T8
         AzGnOI41VINFfdfgO7R22o8V6N4GXKMPj1m+JZwS914M9D7TArohGlkXzNg5IxrGkVEg
         vp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591594; x=1782196394;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3qmQUhSpMXt5iO1CpMCJnf1Ep7kmPs8a01Bf2lLn2g=;
        b=FSvRXUb36Or70bY/zxoXm4j8Dqy7H7WRV8Jr8IcUynZisb6ArrW953rlWNXTUvwNBd
         O8CGC+4iU6uSmruWXUP6ulBzZHNVyrXzxcn6FSdpSEyw4zk7cqcTVYUUXwf307k4rtDP
         BehH6s3lW5M7nAiihWXsQNvN2vE016PhiPQwocSdoybUqEY0NNEtXCO1A829t4/1qqdz
         rw+aflt3TXSfbAkZvgvrBX8DCR5Fbu/V54aU7shke5w43tS+MnFvl5hmikGXBpqFGABy
         hfl3yK57maJXhZx23JV2itwg9U5NtXRZE3eIPY4xBZT/ccQeXRUiM1Y3eFkOK1pAcIwD
         ZNUg==
X-Forwarded-Encrypted: i=1; AFNElJ86F7O8QVMeBo3coDAzVbxYRPnpRn7c1StlHYCtx0qPhXQhqISfsRSJygrEmhicg2sWWKZvSMZdVrcjUw7b@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjCSbu7OWSUscqAhJsZSsQyvcI0KjBchmbOvpZuQkCdGWvWD4
	XvJ2UQd5o9vWJV4QgXUCFZfzURP9f51nrfn/dde9tKEM0EQkidn1Ot/vX6S7+umYRXA=
X-Gm-Gg: Acq92OET0tGLJRX3+cyaPxN+Bh2xcEEzzUL89MKVI8hVXpT+BXBnuw6aLJeFuCDCNc+
	CwPEXvhx3fMQKDIsyTQzGBCmw8NNOj4ZRlupvm+Jl2sT76Jlmy2En/lqHy/ZpHnFE+BTqgbTL6V
	Mk/vpFb/XNSePxl2cEChl5GNG+lgQ7d+65hWrPaZ/qnw4cUadehoV0iR8uQebSLqMaH/6kvMloM
	qdWeI5dk1uit91AksUHBVaq8hy0aKTm/W67xo6CgPiYG0sfZZ8KFNqJWwBqcaOIYbbRYAyPDbHx
	kuE+pMua3jb6mybs1nJPQV2rLscs8Ru30l97n+jbBluwkvNsS1khmoyRBqeP1pzzEIWLfL6Wm4N
	aKSWuQPLBP+EYJNzGwuHhHUkeE52S26SnP1dYhkJlj12s+aVFp3iLagwpuXJ85ccn3GVjNVAdoo
	DEYeTWc+FFQXQ5sGfTRBYKImLrBdVonnf6PbpnCsKXCR91AuCEWbiwLxMEVr1MFuFQVzpsSF5ps
	TrpKwGTsg==
X-Received: by 2002:a05:6512:40c3:b0:5aa:728f:24ec with SMTP id 2adb3069b0e04-5ad427615f2mr557735e87.3.1781591593560;
        Mon, 15 Jun 2026 23:33:13 -0700 (PDT)
Received: from [192.168.3.148] ([31.23.24.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7328sm3250855e87.45.2026.06.15.23.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:33:12 -0700 (PDT)
Message-ID: <ba59fcb77c31c1848d4a7f52e87829711b747567.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
 <frank.li@vivo.com>
Date: Mon, 15 Jun 2026 23:33:09 -0700
In-Reply-To: <20260611041845.GC6060@frogsfrogsfrogs>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	 <2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
	 <20260611041845.GC6060@frogsfrogsfrogs>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 21:18 -0700, Darrick J. Wong wrote:
> On Wed, Jun 10, 2026 at 08:50:33PM -0700, Viacheslav Dubeyko wrote:
> > On Mon, 2026-06-08 at 10:55 +0100,
> > david.laight.linux@gmail.com=C2=A0wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > >=20
> > > xattr_name is kmalloc()ed at the (assumed) maximal size and then
> > > the
> > > prefix
> > > and name concatenated together.
> > > Use memcpy() for the prefix - its length is passed and strscpy()
> > > for
> > > the
> > > name to ensure it really doesnt overflow.
> > >=20
> > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > (But I cant see the copy in the old code.)
> > > I am also not sure why the buffer isnt created "just long
> > > enough".
> > >=20
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > > This is one of a group of patches that remove potentially
> > > unbounded
> > > strcpy() calls.
> > >=20
> > > They are mostly replaced by strscpy() or, when strlen() has just
> > > been
> > > called, with memcpy() (usually including the '\0').
> > >=20
> > > Calls with copy string literals into arrays are left unchanged.
> > > They are safe and easily detected as such.
> > >=20
> > > The changes were made by getting the compiler to detect the calls
> > > and
> > > then fixing the code by hand.
> > >=20
> > > Note that all the changes are only compile tested.
> > >=20
> > > Some Makefiles were changed to allow files to contain strcpy().
> > > As well as 'difficult to fix' files, this included 'show'
> > > functions
> > > as they really need to use sysfs_emit() or seq_printf().
> > >=20
> > > All the patches are being sent individually to avoid very long cc
> > > lists.
> > > Apologies for the terse commit messages and likely unexpected
> > > tags.
> > > (There are about 100 patches in total.)
> > >=20
> > > =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> > > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > > index 452a1f9becb2..0b3dd48c28c9 100644
> > > --- a/fs/hfsplus/xattr.c
> > > +++ b/fs/hfsplus/xattr.c
> > > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode,
> > > const
> > > char *name,
> > > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > > =C2=A0	if (!xattr_name)
> > > =C2=A0		return -ENOMEM;
> > > -	strcpy(xattr_name, prefix);
> > > -	strcpy(xattr_name + prefixlen, name);
> > > +	memcpy(xattr_name, prefix, prefixlen);
> >=20
> > What's the point to mix memcpy and str*() family of methods? What's
> > wrong with str*() method here? Otherwise, if it is wrong to use
> > str*()
> > family of methods, then why is it correct to use for second
> > operation?
> >=20
> > > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > > prefixlen);
> >=20
> > Why strscpy() is better than strncpy()? What is the main argument
> > here?
> >=20
> > > =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> > > flags);
> > > =C2=A0	kfree(xattr_name);
> > > =C2=A0
> > > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > > const char *name,
> > > =C2=A0			 void *value, size_t size,
> > > =C2=A0			 const char *prefix, size_t prefixlen)
> > > =C2=A0{
> > > +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> > > HFSPLUS_ATTR_MAX_STRLEN + 1;
> >=20
> > Frankly speaking, it looks like a constant that should be declared
> > in
> > hfs_common.h. Even if we would like to declare it here, then it
> > should
> > be const size_t, from my point of view.
> >=20
> > > =C2=A0	int res;
> > > =C2=A0	char *xattr_name;
> > > =C2=A0
> > > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode
> > > *inode,
> > > const char *name,
> > > =C2=A0		inode->i_ino, name ? name : NULL,
> > > =C2=A0		prefix ? prefix : NULL);
> > > =C2=A0
> > > -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> > > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> >=20
> > Finally, I think kzalloc() should be much better for both cases.
>=20
> kasprintf()?
> >=20

It sounds much better than suggested fix.

Thanks,
Slava.
