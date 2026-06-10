Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6683B47DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082590; cv=none; b=ZyNKJXLPPpjjHomVbKm7eJoudxHFXM2mf6uezzLGxnJ7/sqoP/kDCqdQYRlhiRLhA8tCttwrxCimkF2SxsrJZZkU/nr2+JrDEigV4dKjXW8t7k+Vq5D/aSKxUnnU18lxR4hLobYI9etg/76I8fa3v4vWMhM7R7MkiSesDyLou6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082590; c=relaxed/simple;
	bh=0WJ4UY+DGzKi6B9P1hXaTZJA18fsGtqUzi10S7pOVG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDELfjLSJSrtj2eYW7xv1/ckI+22m+S12MJvOm8Rq8U4lLOqDMr9hu5U3Ouq9o47IAwcqjK/IZTDyi7XU7vkGs4tjvcZlFwSAOBWadlU7LNn+NFHGFX1cCh8IOZjSnBajVJ5XnnQ5abgnsEbmjYjgvkpRhiJrpQwV2TOa8VAbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j++iP20T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j++iP20T"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso50936675e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082587; x=1781687387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWrkOjjLJH5qDnRo8XgcjVbW4R3sL57sCMCmEUy+meI=;
        b=j++iP20T/MgTGRTHqwL3SbEFJl/c43ME3gzzR72zVOvzZEhuy56QyjoZHpcwCrE/6h
         4Rnw6GxHwdX+HNL3vb1CWEJxEQsba73FgOoYo+Toa8fw2cVxJiJFJxcAn3j6jemOzDWG
         RDj+8mYXXR+82uaPSFFHUP/xRvhyoNlafGvl3gV+YhkwX14Z018BUMDisPtCcHgLEFgV
         z3bUIH6PMio4/UdazBrt7UidsFrAvsbhUM9tNN56n6r5WqMBEkH740atbR5qcZrmm0vH
         g3gaH7p5PnMQlDFaHwlfVzKVKB7377TJAF9kpKMXuYqbPG6Gk/1FuM+5ilN+6kLQ/iRk
         n1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082587; x=1781687387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWrkOjjLJH5qDnRo8XgcjVbW4R3sL57sCMCmEUy+meI=;
        b=Py3+b+qJw9X109HQ5KBd859JUm49R68w6ZLtrQY6efwc59PxmcHPz1tSTTA9KQvqwD
         RxP11+qPo64HL+i2mnq4Z61fIdB7roWBE8SR4Lv67qwC0fp2QdgxisgV6ByWwLtumYH0
         ONQLo2OnZsXmCbZ3cEh9zHqipIFclfpZCAtmKQg5vPzruLzxHTb0wpzviy6TZtZnlx+7
         FYw6PVyOHiGZ/pzDFzqQlzX69eF9+Zd/cO0djdNQj1bQzyYFbV4XT6bLsDTFYh4Vtxfz
         6IcPwAECfZkK2V0YYwU39AIrORftaM1GCFlGm1/wVhQ7KYBkXDtNCTN2xqhuhblqUa3w
         27pw==
X-Forwarded-Encrypted: i=1; AFNElJ9Dv766pXXvmSdJV5gifACVXrqiOe6/xV2x6VezcsOJaIGW+ftCCNRFb9/8cPb5NJ/sTtMxTgWCIKGPOeXf@vger.kernel.org
X-Gm-Message-State: AOJu0YytOHq+vw3RtRp+K3loxJlXdDsWmQ9jrBDh9t8SUKmmjOegiVr8
	Jptfotvvrt55A7WGhkExQahB0REZ2X3Iyy2+xlQRfNrruUggO2lmIMR4
X-Gm-Gg: Acq92OGQ/ANQs5OStAN2lomGryNDbRg4O36ed1jDPPOZc1zzmqK5z2snaY/CW8VBP4E
	tU9nDvi2LkgVEVFgTUE1hZgaE+JbxK7+dxCKsJmDRgU9UQXo3AdKpMts0mNjISbDAHn01Pqz83T
	DP0nFxtcfx/E/66bNVEI4wvh0h0OsvYbxveGi5rWhjc5ykHqOoi1Acvw8RloG55nxPvQi9VcwG1
	9D0fxddNdXLM+iP4ldOKYsdG04XH4DgYS+zOJRNhT5EzUhPnI2+/vM7wcKOOyRaLwgaHK+ffJkM
	1VRSExT7ibWTqh7XsIJiOF0LWdX7RkJrktInaSPPa9HQKHx6hFTcjbw9ABThz+fos98s8T64zY0
	LvjbEAFrJBV6nWjFfWqtNcIYFn6UO1AGo4vbxL80nc4lXMTOhpVrTfS/7oBNsmaC2LU/P5cHp+1
	PZLRSRI27fWxc7r10Yat1DHE3n09BNUkM/X+keKJNOhmW+mswNzX6Fi+4VOvCZJUDe416VMls=
X-Received: by 2002:a05:600c:1c29:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490c2ceb6f6mr344978125e9.8.1781082586982;
        Wed, 10 Jun 2026 02:09:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm630684075e9.3.2026.06.10.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:09:46 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:09:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, John Paul Adrian Glaubitz 
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260610100944.3c5a5771@pumpkin>
In-Reply-To: <45e421ab38cfdbddbc0d34970a2db94902ad634b.camel@dubeyko.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	<45e421ab38cfdbddbc0d34970a2db94902ad634b.camel@dubeyko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jun 2026 18:04:46 -0700
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> On Mon, 2026-06-08 at 10:55 +0100, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > xattr_name is kmalloc()ed at the (assumed) maximal size and then the
> > prefix
> > and name concatenated together.
> > Use memcpy() for the prefix - its length is passed and strscpy() for
> > the
> > name to ensure it really doesnt overflow.
> >=20
> > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > (But I cant see the copy in the old code.)
> > I am also not sure why the buffer isnt created "just long enough". =20
>=20
> What do you mean by "the buffer isn't created just long enough"? And
> what is your vision of correct implementation of the logic?

The old code is:
> =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> =C2=A0	if (!xattr_name)
> =C2=A0		return -ENOMEM;
> 	strcpy(xattr_name, prefix);
> 	strcpy(xattr_name + prefixlen, name);

It would be more usual to do:
	size_t name_len =3D strlen(name) + 1;
	xattr_name =3D kmalloc(prefixlen + name_len);
	memcpy(xattr_name, prefix, prefixlen)
	memcpy(xattr_name + prefixlen, name, name_len);
So that the buffer is allocated the correct size for the strings.

(Not that it really makes much difference whether you do kmalloc(32) or
kmalloc(1024) for a temporary buffer - both come of a per-cpu list.)

What I couldn't decide, but seems to be inferred from some of fixes,
was whether a double-terminator was needed.
(That might just be the attribute value.)
One of the related functions got fixed to zero fill a buffer in a loop
because (AFICT) something was reading beyond a '\0' terminator.

This code does seem strange though.
It seems to add a text prefix here and then the called function does
string compares to find out which prefix has added and than act
differently based on the prefix.
I didn't try to follow things any further.

I also don't know if 'name' itself can be 127 wide characters (before the
prefix is added)?
The fixed length buffer isn't long enough if all 127 characters require
6 bytes to encode.

-- David

>=20
> Thanks,
> Slava.
