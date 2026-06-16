Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E603409138
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596294; cv=none; b=ftTD+VMsunub+0lrBmvcjZSoG3qmx092vuCx6j5HQqfVcPij94XFlJJCAfPUZpKZ98Qp+t7WcGgx3Bzmku+/9tWVxbi1iA7yyv2fNjyL7AgVuMIDyHHZtAOkENa6td7wJsTwwpZ9RIpxdeaX6WIoJQghokrZ0jgHson/lLYASCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596294; c=relaxed/simple;
	bh=RziPevZjm3z1eK2jSastK/VakUqZvqN7tlSiqdnOdKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+C+iNPCQ4cubH6XrT+DvrtUUz/DgqiRC12/+KWjolD0uB6WsRSjuAovxPS1Xsqe1wgbwONdw7aV3qQNB2GvBvyRHyHmgX9dh8uFTCyPHGBbCQNYJlFC1OZngXFcNUxorX+8oabbZdVBCcn1u0s64ev7wTGbdC0OzFEvU+UdgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXzYD4bW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXzYD4bW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4905529b933so42471885e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781596290; x=1782201090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5/NsOrzzl/d9TsugSUWPekYDst5Pv+qw6Cf0EjCiuo=;
        b=MXzYD4bWxd15RyjC/kAgi9yG89Hyy4FF4c4Zt5BpX4DP66RPI6myhVQ0F0QUPbiDpp
         pXH71rc43EPXJm9lC7Ba+519DJ5BhbrVPxu16P91wzwly/QylGJbJBFN6nPT5wxhPeBi
         VNya51vYaR46LTw6fNilXC6Zy4WR9iVsPQpeiyRVPBCiU3+AQaxvr7g89MCQsd9J6ZOx
         d+irg2Bg3/zxui2/Wu42F+NsJlVXush/E6WmT508VylWA1pyy7lUL3S87VHYeyJxHML0
         pvx8+W7OQomOGQTWO4aoQF9bsMPeAqPmPCdt+V1OQrQWa+LlkjUWpQdepE52P6qGtZRL
         rPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596290; x=1782201090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5/NsOrzzl/d9TsugSUWPekYDst5Pv+qw6Cf0EjCiuo=;
        b=AApMosE7Ym3xiQqEedj6XvfnzUjkDCUGSGIU6RhH+iTBbWiTI7pelg6NJK1MrRS1c4
         AVJTfgpiWBnqNYw0BnzmSBOK+qoeiPJ5SNPNjjkoW20vAl3c60pE3FbkPPbLa4ijGgfb
         NKxcUG6xIrLixM7z17nPp73BaAQUGzFkGHukdOp15xYB5r70yfuTB8Gm7K9AJl0yovkL
         Nq5NHJt+6lo9YgWQricn4arHgVOs5m4FrffQxAr6jdAfOj3imXKyo7sBwqjxybdxknp4
         kHQNIN5PvimPtxZXTguZNvWVOPmWqxM5QwTHd3tVl6iwGhd2qt0uZRw2TajErqNZetqw
         lQPg==
X-Forwarded-Encrypted: i=1; AFNElJ9IifYKstrScnJjtQqrYkUYYfaCZr2lzrUrRjO4qdZEYEEsacPOxzwnhPfwXXc3Uqu1XL9fe+nW62/P1k2z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xA/j8xW2dYW9rUG381IV6Z+r0D4o3nIAPiOhykWsRy2WkWNt
	z/wwSRFe/GA/Rlve2VxbiS/0pBarRY6Q239VUJq56PAWQ7hHNJgu6oJk
X-Gm-Gg: Acq92OGKn+y7XDKGiuVJlO9uENI3JnCr8zRNBM74+56fSnid/vc3MQIv86WI0+SRv1R
	ltuktVJCAE4J5af6bv6Mzj8ecPT7iFyJfOgntAEUq6ciIle0e9OZEfjQOOcchmWMQzLuLmqhus1
	f3vnEwbAFkXp5cWSPR3X0DEjgiHzpdTBNE8RwV5vBK2uLtzcSPtlLaqLgidW/F4bzJzwZ75fZrl
	8AQCJYKB+kQy+XXS4QbjO0Z3AyM2HOche2XZodz5Th7v8pps3stS5MRP6c6upXo/YkQyBB0xukw
	3zZobpLMjMKr3egsRaJM1qvRVxcVuozKdS6XhgMfBDGlgSEy8JkGv99o5nfZpxXCb3aWrNCkyzg
	oY0BSkXsdePFtLKUpdC1VZRtE1yZMb31syTepdR2Ch8tbMaotTZX7g+6+W0YnDOsU3hUoG86vG4
	ucgMGfxim5L/eC5s8t+EYxdq5CbaFnbR8VZKyWIS3P3Nk8N/SmBH0XNUncT7DD
X-Received: by 2002:a05:600c:c04b:20b0:490:e1a6:25d with SMTP id 5b1f17b1804b1-4922ff9b097mr30479925e9.26.1781596289395;
        Tue, 16 Jun 2026 00:51:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8eb30sm33223295e9.10.2026.06.16.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:51:29 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:51:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
 <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260616085127.3b11d855@pumpkin>
In-Reply-To: <ba59fcb77c31c1848d4a7f52e87829711b747567.camel@dubeyko.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	<2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
	<20260611041845.GC6060@frogsfrogsfrogs>
	<ba59fcb77c31c1848d4a7f52e87829711b747567.camel@dubeyko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 23:33:09 -0700
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> On Wed, 2026-06-10 at 21:18 -0700, Darrick J. Wong wrote:
> > On Wed, Jun 10, 2026 at 08:50:33PM -0700, Viacheslav Dubeyko wrote: =20
> > > On Mon, 2026-06-08 at 10:55 +0100,
> > > david.laight.linux@gmail.com=C2=A0wrote: =20
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > >=20
> > > > xattr_name is kmalloc()ed at the (assumed) maximal size and then
> > > > the
> > > > prefix
> > > > and name concatenated together.
> > > > Use memcpy() for the prefix - its length is passed and strscpy()
> > > > for
> > > > the
> > > > name to ensure it really doesnt overflow.
> > > >=20
> > > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > > (But I cant see the copy in the old code.)
> > > > I am also not sure why the buffer isnt created "just long
> > > > enough".
> > > >=20
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > ---
> > > > This is one of a group of patches that remove potentially
> > > > unbounded
> > > > strcpy() calls.
> > > >=20
> > > > They are mostly replaced by strscpy() or, when strlen() has just
> > > > been
> > > > called, with memcpy() (usually including the '\0').
> > > >=20
> > > > Calls with copy string literals into arrays are left unchanged.
> > > > They are safe and easily detected as such.
> > > >=20
> > > > The changes were made by getting the compiler to detect the calls
> > > > and
> > > > then fixing the code by hand.
> > > >=20
> > > > Note that all the changes are only compile tested.
> > > >=20
> > > > Some Makefiles were changed to allow files to contain strcpy().
> > > > As well as 'difficult to fix' files, this included 'show'
> > > > functions
> > > > as they really need to use sysfs_emit() or seq_printf().
> > > >=20
> > > > All the patches are being sent individually to avoid very long cc
> > > > lists.
> > > > Apologies for the terse commit messages and likely unexpected
> > > > tags.
> > > > (There are about 100 patches in total.)
> > > >=20
> > > > =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> > > > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > > > index 452a1f9becb2..0b3dd48c28c9 100644
> > > > --- a/fs/hfsplus/xattr.c
> > > > +++ b/fs/hfsplus/xattr.c
> > > > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode,
> > > > const
> > > > char *name,
> > > > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > > > =C2=A0	if (!xattr_name)
> > > > =C2=A0		return -ENOMEM;
> > > > -	strcpy(xattr_name, prefix);
> > > > -	strcpy(xattr_name + prefixlen, name);
> > > > +	memcpy(xattr_name, prefix, prefixlen); =20
> > >=20
> > > What's the point to mix memcpy and str*() family of methods? What's
> > > wrong with str*() method here? Otherwise, if it is wrong to use
> > > str*()
> > > family of methods, then why is it correct to use for second
> > > operation?
> > >  =20
> > > > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > > > prefixlen); =20
> > >=20
> > > Why strscpy() is better than strncpy()? What is the main argument
> > > here?
> > >  =20
> > > > =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> > > > flags);
> > > > =C2=A0	kfree(xattr_name);
> > > > =C2=A0
> > > > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > > > const char *name,
> > > > =C2=A0			 void *value, size_t size,
> > > > =C2=A0			 const char *prefix, size_t prefixlen)
> > > > =C2=A0{
> > > > +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> > > > HFSPLUS_ATTR_MAX_STRLEN + 1; =20
> > >=20
> > > Frankly speaking, it looks like a constant that should be declared
> > > in
> > > hfs_common.h. Even if we would like to declare it here, then it
> > > should
> > > be const size_t, from my point of view.
> > >  =20
> > > > =C2=A0	int res;
> > > > =C2=A0	char *xattr_name;
> > > > =C2=A0
> > > > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode
> > > > *inode,
> > > > const char *name,
> > > > =C2=A0		inode->i_ino, name ? name : NULL,
> > > > =C2=A0		prefix ? prefix : NULL);
> > > > =C2=A0
> > > > -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> > > > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > > > -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > > > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL); =20
> > >=20
> > > Finally, I think kzalloc() should be much better for both cases. =20
> >=20
> > kasprintf()? =20
> > >  =20
>=20
> It sounds much better than suggested fix.

If performance matters here it will be a lot slower.
The snprintf() code itself is slow and kasprintf() has to do it twice.
(As well as looking at the strings twice.)

It also only allocates a buffer that is big enough for a single
terminating '\0' - and (at least some versions) of this code zero
the rest of the buffer (possibly to avoid a bug).

One option would be something like kstrdup() that concatenates two
strings.

	David

>=20
> Thanks,
> Slava.

