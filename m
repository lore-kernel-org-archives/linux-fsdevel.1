Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403353563E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674397; cv=none; b=ExMt8NdI0JkpdehPd1x5mQ6LpCQwNN7cvYb0z3IRXnLpjSTxnfpKSRR1r6OO1q9iVWNxenUSZOQCiR+vuXfp6wRk2XQG4iKwKdR1puQXYCmfZ2QsPKCBSMz1Z5o/qn//eV4a9KgjTc14R0wrVfkz3JbNZp5AgVvssY2umBqZbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674397; c=relaxed/simple;
	bh=5PzlQx3yfApJix2sagB+OXJ+jY8auSlY1Asj/vh/CEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDM7Ho1nQyxbcRbN2VwjJvkelcYkJWRU4Rstp1VZU5L2/xv+znkO5OLRezBDZsdC6bXU1WNz75zZ35nWHqqIPY18Yhm7+DfaWtuf7UFKoGRDapxvJ8fK87gee8mmqa5dtxRhtCpj0q3XsyMTMkO7HNyR7//wkqsjCHVcO0WStCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=EPi8Klyh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="EPi8Klyh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa69131836so5216706e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781674394; x=1782279194; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9AFZZEAKAWxA2/laIN39x0I+j9qz2p8uDCCx96O9W2M=;
        b=EPi8KlyhA0FXeDOD/dVFZmBvxzMRaxNln4qtAP9yblOEqw/J4tiUG2gSiFoJEhbZRr
         XUF2oY4fIDK8brO65xCqwK61G9ssxMr1HUasGmaioNkbj5/pUBtf4FHVHkPM+T8V6fZw
         dxpGQwWkLmTl1mq47/131351bE06QO5Z2R3K0e6mEE/4E8IpOdN53KBTVyXoY5jH0Rlw
         B3c4UCw0hRrjXqpBaOm4JjA0bdqJxkQEbLBMcn28kYBXiba+pU3KJoXW/aOVLUvlxSpU
         zZZ+1GT1bCd3Btko9r6dQODw5ra1uyD44vN2bOeW/jc1fJXrWeZdoX2yRGWfezRDjvb7
         bMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781674394; x=1782279194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AFZZEAKAWxA2/laIN39x0I+j9qz2p8uDCCx96O9W2M=;
        b=NmkJKtoh2UqsoqZgAgkvbLE3cz+RrHo5e9eV1VyxlOSX81shUppezpDBgGjDnorQ+B
         0Q2tpAefuIbiEDTiCCm+LxepxVbd3nd41bg3B/81DW2LHW6qXZ72S/Clp1jnvmvVDh33
         h392lwsYbt3GG/dCakOXr3SLsmAOndJCobzHCTV5btkVug9JwupqaGwqZE690OVict+r
         VXLRvG5k0EZdVfBpm1aGVutcVkDe1CC//Pi4oViTFwgURhnBmJHsxvyD1m5JwkGzp7nV
         lci1tA500ssP3AaJTZHwrtLyrwvYDZL/iTF368j3dv5uTfWqcN1G0IxqxWZ8LK14MzQQ
         HrCg==
X-Forwarded-Encrypted: i=1; AFNElJ8RCWXx4kDcf9aHm5MwtEUmJaDoH97SYqLwqVrvWia5K86sFhQT1pHd0VbLux0wTBX2j25RJMKh0nAQyh0e@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbHwsvi02bzjn30iTA7ihYxJhY8+3Vji/rM62Mwy60OcT3F/V
	TW339poj0PO4UBhjC7DOqjYd514QnFkq6zJJPzSEPChCmN7x95jqjAG5yIbWvGMYozs=
X-Gm-Gg: Acq92OHTi8/yIFlh8bHoCJSa+Wgz8pW8u1Ms1SyCiQD6xr6+bqwivCOihDS0M5aSu4T
	5yuEPthu+6y8J6xQv5WViiIknrol/9aLO6chsqQA/bvbPpSNHR71Q5WvD3tzgEJgvWgPKOyuTGb
	5N3k49UBPrOM+pBRwndXq4BiEEc7qDiX5Nxv8E9TsY1Rbg65G08KL3NTItsd72700G6UoKq68DH
	OTtq64K4dR5vyebKjHeOVJRSrqVsXeVHaB8sRH01OZmc6DewZPRlRmS/shNmS5A/ITLttl7eVIY
	X3GQGj/fC4x8gAz/BeoMVNnCyZwBD701Pt8gX1CJtrgn6yOqNeA5pH1FGK0T4Nk7lON0ll6+yDx
	8yBm3wlwlHJg8MrRa/n4tK9xGDJVSAsnH5Awo2+tSi/0sLr7zpFvgCCaq1DM486yq26vJPUfipz
	YFcEnv8LQRIqj3F8h+BvIDXnpmOJcs4I3+y5PLpqmtyYo0q3TjiN/xyTiKp488rkSIz5Y4tq+sg
	XhkORJ9j2+3fG7UCHDFZEXoKufx6P0=
X-Received: by 2002:a05:6512:15a3:b0:5aa:8824:156a with SMTP id 2adb3069b0e04-5ad4703682amr586748e87.46.1781674394010;
        Tue, 16 Jun 2026 22:33:14 -0700 (PDT)
Received: from [192.168.3.148] ([31.23.24.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f2fsm4177496e87.11.2026.06.16.22.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:33:13 -0700 (PDT)
Message-ID: <44e2383c0859200e4752f8a782fc75c4240c2a1f.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
 <frank.li@vivo.com>
Date: Tue, 16 Jun 2026 22:33:11 -0700
In-Reply-To: <20260616085127.3b11d855@pumpkin>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
		<2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
		<20260611041845.GC6060@frogsfrogsfrogs>
		<ba59fcb77c31c1848d4a7f52e87829711b747567.camel@dubeyko.com>
	 <20260616085127.3b11d855@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-16 at 08:51 +0100, David Laight wrote:
> On Mon, 15 Jun 2026 23:33:09 -0700
> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>=20
> > On Wed, 2026-06-10 at 21:18 -0700, Darrick J. Wong wrote:
> > > On Wed, Jun 10, 2026 at 08:50:33PM -0700, Viacheslav Dubeyko
> > > wrote:=C2=A0=20
> > > > On Mon, 2026-06-08 at 10:55 +0100,
> > > > david.laight.linux@gmail.com=C2=A0wrote:=C2=A0=20
> > > > > From: David Laight <david.laight.linux@gmail.com>
> > > > >=20
> > > > > xattr_name is kmalloc()ed at the (assumed) maximal size and
> > > > > then
> > > > > the
> > > > > prefix
> > > > > and name concatenated together.
> > > > > Use memcpy() for the prefix - its length is passed and
> > > > > strscpy()
> > > > > for
> > > > > the
> > > > > name to ensure it really doesnt overflow.
> > > > >=20
> > > > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > > > (But I cant see the copy in the old code.)
> > > > > I am also not sure why the buffer isnt created "just long
> > > > > enough".
> > > > >=20
> > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > > ---
> > > > > This is one of a group of patches that remove potentially
> > > > > unbounded
> > > > > strcpy() calls.
> > > > >=20
> > > > > They are mostly replaced by strscpy() or, when strlen() has
> > > > > just
> > > > > been
> > > > > called, with memcpy() (usually including the '\0').
> > > > >=20
> > > > > Calls with copy string literals into arrays are left
> > > > > unchanged.
> > > > > They are safe and easily detected as such.
> > > > >=20
> > > > > The changes were made by getting the compiler to detect the
> > > > > calls
> > > > > and
> > > > > then fixing the code by hand.
> > > > >=20
> > > > > Note that all the changes are only compile tested.
> > > > >=20
> > > > > Some Makefiles were changed to allow files to contain
> > > > > strcpy().
> > > > > As well as 'difficult to fix' files, this included 'show'
> > > > > functions
> > > > > as they really need to use sysfs_emit() or seq_printf().
> > > > >=20
> > > > > All the patches are being sent individually to avoid very
> > > > > long cc
> > > > > lists.
> > > > > Apologies for the terse commit messages and likely unexpected
> > > > > tags.
> > > > > (There are about 100 patches in total.)
> > > > >=20
> > > > > =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> > > > > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > > > > index 452a1f9becb2..0b3dd48c28c9 100644
> > > > > --- a/fs/hfsplus/xattr.c
> > > > > +++ b/fs/hfsplus/xattr.c
> > > > > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode,
> > > > > const
> > > > > char *name,
> > > > > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > > > > =C2=A0	if (!xattr_name)
> > > > > =C2=A0		return -ENOMEM;
> > > > > -	strcpy(xattr_name, prefix);
> > > > > -	strcpy(xattr_name + prefixlen, name);
> > > > > +	memcpy(xattr_name, prefix, prefixlen);=C2=A0=20
> > > >=20
> > > > What's the point to mix memcpy and str*() family of methods?
> > > > What's
> > > > wrong with str*() method here? Otherwise, if it is wrong to use
> > > > str*()
> > > > family of methods, then why is it correct to use for second
> > > > operation?
> > > > =C2=A0=20
> > > > > +	strscpy(xattr_name + prefixlen, name, xattr_name_len
> > > > > -
> > > > > prefixlen);=C2=A0=20
> > > >=20
> > > > Why strscpy() is better than strncpy()? What is the main
> > > > argument
> > > > here?
> > > > =C2=A0=20
> > > > > =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value,
> > > > > size,
> > > > > flags);
> > > > > =C2=A0	kfree(xattr_name);
> > > > > =C2=A0
> > > > > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode
> > > > > *inode,
> > > > > const char *name,
> > > > > =C2=A0			 void *value, size_t size,
> > > > > =C2=A0			 const char *prefix, size_t
> > > > > prefixlen)
> > > > > =C2=A0{
> > > > > +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> > > > > HFSPLUS_ATTR_MAX_STRLEN + 1;=C2=A0=20
> > > >=20
> > > > Frankly speaking, it looks like a constant that should be
> > > > declared
> > > > in
> > > > hfs_common.h. Even if we would like to declare it here, then it
> > > > should
> > > > be const size_t, from my point of view.
> > > > =C2=A0=20
> > > > > =C2=A0	int res;
> > > > > =C2=A0	char *xattr_name;
> > > > > =C2=A0
> > > > > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode
> > > > > *inode,
> > > > > const char *name,
> > > > > =C2=A0		inode->i_ino, name ? name : NULL,
> > > > > =C2=A0		prefix ? prefix : NULL);
> > > > > =C2=A0
> > > > > -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> > > > > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > > > > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);=C2=A0=20
> > > >=20
> > > > Finally, I think kzalloc() should be much better for both
> > > > cases.=C2=A0=20
> > >=20
> > > kasprintf()?=C2=A0=20
> > > > =C2=A0=20
> >=20
> > It sounds much better than suggested fix.
>=20
> If performance matters here it will be a lot slower.
> The snprintf() code itself is slow and kasprintf() has to do it
> twice.
> (As well as looking at the strings twice.)
>=20
> It also only allocates a buffer that is big enough for a single
> terminating '\0' - and (at least some versions) of this code zero
> the rest of the buffer (possibly to avoid a bug).
>=20
> One option would be something like kstrdup() that concatenates two
> strings.
>=20
>=20

We are talking about xattr operations that is not very frequent ones.
Also, xattr names usually are not very long. So, it means that we need
to manage small memory/string blobs.

From my point of view, the benefit of kasprintf() that we can combine
the whole operation into one line of code. It sounds like nice cleanup
to me. I don't think that kasprintf() can introduce a significant
performance degradation for HFS+ xattr functionality support.

Thanks,
Slava.
