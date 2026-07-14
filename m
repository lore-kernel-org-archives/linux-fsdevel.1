Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983B41A938
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054752; cv=pass; b=aWoDSC5WZHQ6Dedji/f/qPv49JlWkLDWWI2mGmoJOoJvCQtq80PymnFpCfrC+u1vo9L6HYkgWd1lII28ITx9Wmj+Dzro+AcYaMECArkM9vSnJFgGGH01PpaXgozgjlA/4on170Z9VOrNC23YfZnH2c4l2svuMzUCGhMx6DiFPHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054752; c=relaxed/simple;
	bh=45Ql8Z3kbqBVblNIyez9+I3RbqIfvNNVZRKKDmSg5Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCHFgt7tWrceD3AHMhNSRFK3vPsA58p0EYptT2/NU2ss65M68Og+C4cm44trJNxqvtOYWiaCbg5U08MaIXbmVTZckLxqoK12/77yeIVklzgxeNh2p/CBVnCFAyR+/mFoEYK4D/9IZCvS+wbCMOHKuk0ndQnANz/dXl04nM/SqgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CiDn2c5T; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="CiDn2c5T"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cad4170e8eso55992775ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 11:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784054750; cv=none;
        d=google.com; s=arc-20260327;
        b=SPVVcR3K/e2gX31BlKvmP2r5lUvXE6SNgmnZakkNfJTin55oJLBRLvYaKOnPbpRcDd
         sy2AwP8K3aPGd51UoVpfhb79yTHKpAKSVzuryhUV5B4/wCaD+X5dO2QqoD+YCi4a1ZLt
         06O8u6+wSBQpUM5ZQUfSHSOk87NtGKId9hL9wiTB/vALSxbGDJyP3BRyjy3EYQ7sGJBX
         U9CizfZ6dwZLfLf+FMX+xeOxRaktY7QvSVI/f1JZRX27I+wBVJp1OLhyx2583Tmy+UqW
         tbjoGlLk6Y0Hi/Bst2ZAOfkDB4WBlJwbmix+2kyVywrGgHpyETJjmtSbvkljFK0b2fT2
         VNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+QvsXqURUhdb7jd8kDJcl/mIBB7n1g9Nwu6vbBn0WY=;
        fh=q5JK5y+EKVVpJAQpEyrKlQ46E0fKCiR050XSiZWu0FM=;
        b=bDrHvpBJeGwPLv5iIH4kNX6xME8j6tc8a4kHWbbH81klmjMexagErNi3j0TjeZrFSZ
         TFUBqnuE6Bsr4V7C0X/ngS5EOWudGSiGM+tL/M2BS4Lz9+Ei4POS6ic0hOnVzg7lruk9
         TTqfRY5RbmayLk4NOGm1RSi+fCxIfcxTcNQuzGNuzFz/de2VWDn5+/FfzwvNorJ7YOJA
         mHTGUaAjrj/Z132k+9H5klWObQK6+4QJPO3vZVBhPNm9oT+i6IOdjZA3LvTXXIlyC69a
         Zzvvutr/RZDbsqa/5ZBfDrLp2/ejDTXi64TcdkX/zpWdwErsWEJ1j0VXpPfXXgNcZg/k
         l9pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784054750; x=1784659550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+QvsXqURUhdb7jd8kDJcl/mIBB7n1g9Nwu6vbBn0WY=;
        b=CiDn2c5TEuDotIp5BgPIhYVbYcub6A0VQ7/3MfijW3zzzpyOVtK3QUuFMeP/XBTgmU
         NKy1ldI4mNaHVOngW2IxyVTlwkW4ZeqwoohCEl3BDVxwcx5FiydrlpKOcUyt+UsShaVR
         Yz8BzbR/DU8aEzV9T8GlUoKGjlWax5XRqtIb+luovFkSrZE44ec9OBR1NOGuJw5JA4qJ
         budIAB0+4HnHzZxjjxIpiBmQ0uZL+UzpnumMK82sh5/wYzbXn7CMgNjD8UJ4UEx8ZuVX
         oao8T0ZhR92Mu9PxSes7nnth6hfGY3zaF6yxKcNS9A1oURzNxyeWPniwqmJZM5PUe+vU
         iciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054750; x=1784659550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+QvsXqURUhdb7jd8kDJcl/mIBB7n1g9Nwu6vbBn0WY=;
        b=SmL5UZK6GOjhXF+a1gompLaImDdC0B5Jdr3vFAmsN6NlV0nOCna793BHCSein4OInX
         pJWkDoSymPGPfYkBo74znsTfxxnMYGX/a9E/mIcP77ZECnIIBSfsGcmBpZJ/o7G2964O
         4leAcFpmLqgmPWZxAE8lKg3De7v+SBO4Zot/VUAw39jlaNlJRa7DYgXTHSWupKaraVlT
         sDxEB2PUpIIHBUAMjklAvh83GnFTrYCscTujcwzsJQ83wj2ao+wWxjQlynkz418262I6
         PfP+U03eqiwQBPfC2A/lE43xjfH4o0R7BYv5yVehv2927Cn0NlpC9Txh8oE/m2vZrRJM
         3zuQ==
X-Gm-Message-State: AOJu0YzQC4H3jnByG8uHWQAKTK7iDHuZDxYa0yV57LmlPfC36Q70w6WI
	PZLOw2h1Qu+xU+Jbqk2Xk5MGAXb01PCM+XQnJ4//Z21vmj5u8lg3xsuoGfBQJJ2eLtOmkZMLTKS
	/rewoAVNK8PLLP7VmZLew/5/hGpnX4M0IJY5LHDfD
X-Gm-Gg: AfdE7clCsEYiXjp4cLviaVl4wrcNXDVxNqrTfHDg6vd8KHNJhwYdhFo5EISMyqm61JW
	Bx18DZbxG5plK85sHJ6B7anvY+i38gDA6FH0dP7KzKMT8WbxBMqN/j7ouRLBd0MMTZgDK7yO2Ub
	iUyTbee2ZxO1R+6BnKNLizP+0SZQwHj8C5HQBDbsFNiD5CwSwrbrWnauI1+O0TcNnB40ESiRRRS
	loEcCfOznLbS1RrzFYpSUzHtIJd9fl+E4sfhMmDvJFWm92zGjVR80P4YsjobLaLYY4f40p2i+ln
	ITTzZwooo90sZxD2LMEXz4dc
X-Received: by 2002:a17:902:e751:b0:2cc:307c:51f2 with SMTP id
 d9443c01a7336-2cef143aec1mr37096755ad.22.1784054750171; Tue, 14 Jul 2026
 11:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712234150.3213467-1-xmei5@asu.edu> <ashtj5ttoea4ktrb3jrqvtseleyoqjhhz3qkug5ihjdzqun6hq@q53fyrhupjal>
In-Reply-To: <ashtj5ttoea4ktrb3jrqvtseleyoqjhhz3qkug5ihjdzqun6hq@q53fyrhupjal>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 11:45:37 -0700
X-Gm-Features: AUfX_mx7ZprZlTVKPjDwkDQnENXCI6NuO27nIiUQIVah93ZmmpfSOvori_0HZik
Message-ID: <CAPpSM+Ts9H0DKmeC6P4=7jYpz5gW3bDLKBae2zu+D+qcMCJEtw@mail.gmail.com>
Subject: Re: [PATCH] isofs: fix out-of-bounds page array access on empty
 zisofs block
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 5:35=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 12-07-26 16:41:50, Xiang Mei wrote:
> > zisofs_uncompress_block()'s empty-block fast path returns
> > pcount << PAGE_SHIFT, ignoring the incoming poffset, unlike the
> > decompression path which returns bytes produced relative to poffset.
> > zisofs_fill_pages() uses that return to advance its page cursor, so whe=
n
> > the zisofs block size is below PAGE_SIZE and a sub-page block leaves
> > poffset partway into a page, a following empty block over-counts and
> > advances pages[] one element past its end, after which
> > "if (poffset && *pages)" reads pages[1] out of bounds.  rock.c only
> > rejects a block-size shift > 17, so a crafted "ZF" Rock Ridge record ca=
n
> > set it below PAGE_SHIFT; the bug is reached by an ordinary read() of a
> > compressed file on such a mounted ISO9660 image.
> >
> > Return the byte count relative to poffset and zero only
> > [poffset, PAGE_SIZE) of the first page, matching the decompression path=
.
> > The page-aligned case (poffset =3D=3D 0) is unaffected.
> >
> >   BUG: KASAN: slab-out-of-bounds in zisofs_read_folio (fs/isofs/compres=
s.c:290)
> >   Read of size 8 at addr ffff88800f5eac48 by task exploit/142
> >    zisofs_read_folio (fs/isofs/compress.c:290)
> >    read_pages (mm/readahead.c:184)
> >    ...
> >    filemap_read (mm/filemap.c:2814)
> >    vfs_read (fs/read_write.c:574)
> >    __x64_sys_pread64 (fs/read_write.c:769)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >   The buggy address is located 0 bytes to the right of the
> >   allocated 8-byte region in the kmalloc-8 cache
> >
> > Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files whe=
n PAGE_CACHE_SIZE > compress block size")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Thanks! I've added the patch to my tree.
>
>                                                                         H=
onza
>
Thank you!
Xiang
> > ---
> >  fs/isofs/compress.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> > index 397568b9c7e7..3fda92358e22 100644
> > --- a/fs/isofs/compress.c
> > +++ b/fs/isofs/compress.c
> > @@ -65,12 +65,14 @@ static loff_t zisofs_uncompress_block(struct inode =
*inode, loff_t block_start,
> >       /* Empty block? */
> >       if (block_size =3D=3D 0) {
> >               for ( i =3D 0 ; i < pcount ; i++ ) {
> > +                     unsigned int off =3D i ? 0 : poffset;
> > +
> >                       if (!pages[i])
> >                               continue;
> > -                     memzero_page(pages[i], 0, PAGE_SIZE);
> > +                     memzero_page(pages[i], off, PAGE_SIZE - off);
> >                       SetPageUptodate(pages[i]);
> >               }
> > -             return ((loff_t)pcount) << PAGE_SHIFT;
> > +             return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
> >       }
> >
> >       /* Because zlib is not thread-safe, do all the I/O at the top. */
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
