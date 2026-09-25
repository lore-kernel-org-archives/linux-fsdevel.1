Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCC171BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 00:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294838; cv=none; b=Ep2MMxWJKOH8R5YEPcExnga/kKdkzOLuzsEt1pU3iR1nM2KRdNJZci4GImXrKNF3iqR0aFnzra4s/rjz2OExNDzs1Q33RH/Lg3gX3ko8IMuuuDlkDrPEFPt2yraDDJJw0TDmxFpWFjeZd3SdDtEHA+r0Nn+p4f2/GiOl0jExMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294838; c=relaxed/simple;
	bh=X2A7vWIe9NKoDbQqXhFCtPDCxQ7TbNrxQywYCAF2WFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNY/7Xkf9eiuV1BQmJM9sJ0HK9PyvfANT++DuPssvMcFNNApO1hf9zeQB0QoyOTOjxlMS7345oxb1kpK6egWmRekGl8r/Z0TLvX50EFPAJF0hDoJTluURUfj0kmo7bmg2C8jNjKJYiA/vcsOydphZ596DSQedq0LObXHkbFl+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=wqM7LCrh; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="wqM7LCrh"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab22370so421069d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790294836; x=1790899636; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=87Bkgcph1yYiWXFlcH1IznzX3nitWH9GjUlv4RNMedQ=;
        b=wqM7LCrhM5d5CtnWjcn8a1Q+EbWqfdMLYPnK5LRPFt4RTXfGh14qLeNMp/RJ02Y2Na
         JgK9kwdtoh109C2HDannokTlVB+JYz/ogkZFGdO0obNr4oBBUz/MfVOeuM/Zit1rk0Ed
         c3Q1wao5zmEXF+tB5V7HaLKC61oFQ6Ot236sn47P3LxWonVkzl5nUaNzdkVD1CUdibwx
         RnGyD6nL6ybVVq+cWxBNF9zOpseLnGPYGYgO4jbij4xIRYPR6N+UpJK4ibXvc2TuVdTL
         Ld5rR8F1tSJpEiyjLZDPvg0gNNW6i+eK4dftdye7UWQ0W9nlFPjVneGtqC3o7CPFfM4f
         DQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294836; x=1790899636;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=87Bkgcph1yYiWXFlcH1IznzX3nitWH9GjUlv4RNMedQ=;
        b=l8E2fM4aB66ENrDwrG72maW0/8EA+PotNUP9p8/GxAhYlBYzrCUdjqP4kj0KycHWg7
         iRlnxhL3KEvCZtK+oMS5d4LzUIvCDXPQq0Zr2XUcTlkBB76kvYunfMxERK8BXuXt+I+T
         xCMw7dqz6QAgaOePZ6034ZBcJAbV4cjzeUHy5R2Pi+XyaeHZSg/8Gl9esjJLIv7VfUI8
         Me+pQccj+ujPZmEjLmzUU9+fX87KxEWFWqwXOVWRS095CjeWybQYcytC71DJm8gkGRgm
         vpMQuwDEzfWcV49herIYd59/H0tPRslBK4DADoyS/FNOUFgcjjXrDOgUP3PoGHbPKcWL
         21yQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeZP1e3jW279UCgYCHv/OXdYCUPmWxsxdN17b6p7ajt3nrr7/D4SD/4HNcuxRo8WKGwyLlP0ZCTcW4VJ8R@vger.kernel.org
X-Gm-Message-State: AFuF++kN7R0wcCbTQmOhBfc7FAQAl5IN1+VdscAQfMG87gVTD+edR15y
	nHGPRnxjl7uHO47ReqE9D8V5omgPTftgiS7BLXbNDAfW9TtPRcqzwmin4anzAEMRRTU=
X-Gm-Gg: AYBFou0C1vioZAl1D64aUif7klYBsZVl0VCP8nGr1XySKZrb/cD/jQiyZWXKtF2lq6m
	fydGa1JafFun0k9eR/+DpMSfqfhbBpQKBPAQ3G/gcfwU3bqnD3UYtratY8JCD5MGAadn+tcLZ0f
	D77Bsag+OPvpxGPzqdY/I0qwHnIMTc6MukviXf8rESFndljt8Au38JVwMl34sirSbj9+IxpKYXm
	cDdtN79RZ5HLSxfWegL3Vg5kEtzkBxGd8f9qbqs2zw3PAEmjAD3mqThmcwubx/JFViELqhmJRnh
	dFtc2qFXl1ajkbPhQu6zRGbbeLdrpj853+sKeItir0wiua+Jq6FMAzaaR/diMWBnKCH0DpxHOt8
	petwM5KvJX1xfx1MQFOfaywY3JdRebcVKqW4dRZV6y7zk1Yh+rErJesLGF2O+FFE2MMkEZerIKV
	lsNunFP3bSe+4cNnlO6Hq9lYv24rDq4UbAdLE5vv6LE0Lcb+RfE1/0+TTBAnxhkLuR5MVUsrvwL
	ih4mvZchMHz6gFzaoJG76RGJWgoyblm4q4T4dv24lBmk0Jo98nKPzqaWjWfcnPLQ5ork0oX2bPq
	6YvIokMcX93SrdKXzJVogtxaVb00kwzzamoq2UZgKo+/pVrOjsLAMtX8NIDlK25FDg==
X-Received: by 2002:a53:e701:0:b0:66e:5604:ecd3 with SMTP id 956f58d0204a3-672ed2648edmr1416902d50.37.1790294836010;
        Thu, 24 Sep 2026 17:07:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:4935:3bd4:e0b7:fd95? ([2600:1700:6476:1430:4935:3bd4:e0b7:fd95])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef701f3sm260485d50.14.2026.09.24.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:07:15 -0700 (PDT)
Message-ID: <1056cf9f4393443de00137bc8937922d6ab40202.camel@dubeyko.com>
Subject: Re: [PATCH v4 6/7] hfsplus: introduce iomap-based file_operations
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
 djwong@kernel.org
Date: Thu, 24 Sep 2026 17:07:11 -0700
In-Reply-To: <20260918133935.GF18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com>
	 <20260914233941.2966421-7-slava@dubeyko.com>
	 <20260918133935.GF18107@lst.de>
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

On Fri, 2026-09-18 at 15:39 +0200, Christoph Hellwig wrote:
> On Mon, Sep 14, 2026 at 04:39:40PM -0700, Viacheslav Dubeyko wrote:
> > This patch
>=20
> Patch descriptions are not supposed to start with "this patch".
> By the time this fets into git, it isn't a patch any more :)

It depends on how we can defines a patch. From my point of view, patch
is a piece of code that can be applied on some state of git tree. But
even if this piece of code was adopted and applied into the git tree,
then it could be extracted as patch again. So, it exists as patch
forever in the git tree because it is incremental change of the tree.

>=20
> > @@ -55,7 +58,6 @@ int hfsplus_file_fsync(struct file *file, loff_t
> > start, loff_t end,
> > =C2=A0	error =3D file_write_and_wait_range(file, start, end);
> > =C2=A0	if (error)
> > =C2=A0		return error;
> > -	inode_lock(inode);
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Sync inode metadata into the catalog and extent trees.
> > @@ -114,15 +116,184 @@ int hfsplus_file_fsync(struct file *file,
> > loff_t start, loff_t end,
> > =C2=A0	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
> > =C2=A0		blkdev_issue_flush(inode->i_sb->s_bdev);
> > =C2=A0
> > +	return error;
> > +}
>=20
> Changing fsync locking feels like something that should move
> into a well-documented prep patch.

Yeah, as I remember, it was a fix of some issue. So, yes, it is
possible to have it as a patch. I need simply to remember what this fix
was about. :)

>=20
> > +/*
> > + * hfsplus_fallback_buffered_write() - fall back to buffered I/O
> > for the
>=20
> Pointless function name in the comment.
>=20
> > + * tail of a write that iomap_dio_rw() could not perform directly
> > + * (unaligned tail, or no blocks could be mapped without
> > allocation
> > + * outside the direct path).
> > + */
> > +static ssize_t hfsplus_fallback_buffered_write(struct kiocb *iocb,
> > +						struct iov_iter
> > *from)
> > +{
>=20
> Can this use direct_write_fallback()?

Yes, I think it makes sense.

>=20
> > +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(inode->i_sb);
> > +	loff_t total_capacity;
> > +	ssize_t ret;
> > +	int err;
> > +
> > +	inode_lock(inode);
> > +
> > +	ret =3D generic_write_checks(iocb, iter);
> > +	if (ret <=3D 0)
> > +		goto unlock;
> > +
> > +	total_capacity =3D (loff_t)sbi->total_blocks << sbi-
> > >alloc_blksz_shift;
> > +	if (iocb->ki_pos >=3D total_capacity) {
>=20
> This is weird.=C2=A0 The total capacity should not matter for a write.

Yes, I see your point. And I think you are right here. I am trying to
remember what was the point of this check. If I am not wrong it is the
artifact of some bug fix. I need to remove this code and double check
what will happen. Potentially, it could be obsolete code artifact.

Thanks,
Slava.
