Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F93515C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922613; cv=none; b=tNxtYH7apK59TzqsQhZnnUMDc5LZfiTjTdQ3NODkCrsBFMJihmEJ+Gt+qI3jvJPuMmY/br+uvgDllA1zsNkawJX6eKEwa0IgB0JztMW6PWMhwOxuweTkILYx/wyKqiycBYEiChrBsPNNLNvYrKDDePCBu+1fK7MIdzXW6wcCoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922613; c=relaxed/simple;
	bh=Penxe6B5EZ7WrvnTef5YH08E4ICC55/zKGQtE6BxVLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnuGBUcMq2vfFHCkH7JefyxDXg8iPwe+NUr51KcJHlqQZJ08F/McOGGVVGag3G/ZqcrO7W4zsvsOWp2/XTpn6aSEecXnZyzQWi0PTrtEnrJ10sRQwdG/zMvX7cMcujoG/7IyKr8wOQtf3kkxM6ZVB+Tlq6tFgBfBKfI9M/KtZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rW2h/Vxs; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rW2h/Vxs"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-667923d86a7so887511d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784922611; x=1785527411; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkY3daRBFEo9a9qpRojAXJ+ZYw8ghxjhJA94SKVQcUQ=;
        b=rW2h/Vxs9vdjTTK0RedQwt7y+0pDw7VbGakXZ/NlN+jOXjaAfZJjagjYXsrL15YcAZ
         pW5Zyh5a0Y29xeZtamSn2p4eMwHS726Z/JD7J5Z4T236uGT7toWfLy9gzc4WB0XFtXzD
         lsOvTz/CkPetnVJjEOr6+HFN8oEMSbDX49DHfDbLrKdGhoNqvQ7yliHJwD61Wyx/RXjj
         xx2Rw+NifE1Y7mRRP4CGp7yQ6Lqy0mb70bif2mZxFwcShIvMnuImHFDJUddk6m2DnxnD
         6iNusgaOBFyPuvY43TDPqrfUeL2Qw7E6S/jFb2T6MtLP/8tqJ7ScCmXInhpR8035SXzj
         FGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922611; x=1785527411;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jkY3daRBFEo9a9qpRojAXJ+ZYw8ghxjhJA94SKVQcUQ=;
        b=FAIYtPPOSCIhCIwuf8kMZ+0X/cWdg68uwIU/4ZHf6525PlN+6CZ3KTsa2EUVB61yOu
         SLeVRbnUrGk1fJD7yrUnfkd8Xm1Hvwft/OJRdxCDchD1MgPuW1Cb1JEdqwGc7ov4i8FD
         /9DCxuVXUTdHslVhFWt3ig2AT6DZN5Doi+MVUX+PcJ4tBVa8whPaj53GEnLNS/A87ILw
         NpThGZex5bitjfMhKO0qEco0lIi01caUyF+8dmLc6P4+XeonSydggK+e8Vt5GNG/Gjzd
         fvi0rIATNpvrH87H8uSGmf1AK12u+FBj0YAJQC6NdxTuzD+CeQ2GVvt/qPKOJoxO3yb/
         BdQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5zvda8A/MrBgmFeRRAzZWr4bZDZU0EfbcSWBaujET/JeQcx3aEqEzRUbTRVRMFUsAql6Y7OO3gRN40jgG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JGoT+rODYN7zVv+8y1yVCP1c1nt0xv8IIijZM2jWYi4TOzQH
	OrCgyn7ow7SHIpSx1H7v4L8BK2gb8lzr2AW6GrCOA957zu+NQfy0rL/tR5Ijk22iViQ=
X-Gm-Gg: AR+sD13zRIw0I6bOxd8/8yN35CgiK4G/qB2qW3ei+tvm1kOTOy9NrdcG5uYmP5DNhUO
	BzOLPKJhDt1rygvJJ85sVZ7O0a+sWSrEc4t9z6LsXVrPjydrVcvuS8b/AQmSSipSamoVNtHAMjW
	GOQfvDp7ehdnW7UzW9Lpg3ccLJHQ1ILJR8whTbEmBvb9W/hopBkNjMJeb8qstwyKSqYeiWkbmnz
	T1r23Rk2GLv/3ddRE9hJIUroAWEP4bwqjJ2YQ9nXnD3h4Q9e38Z54KVzrI8YKrKb8fxgDgfDP5Z
	GYJ/FGDyBPjyu/AfhNCCnGvSN+d2KjqtivKjXKpzafIHB9p3rIuA0V14sye3CxbcP7ge9dGDrTv
	XWdyq8Q52Q/QEy8jcfE8Gbs0gxHBmzSE54nk7x2rwENwB5OZ5pPlSKKjcds9nqdPH46yXtxnzXU
	Mtsuq+uyiBKX+xemRTyf+GGtThcrdmd54+zvQR46TxC9vtfiO5IEJkj//dusPN0ieifBowqxW8L
	iFy0FGbOJ5xRNTNTdmv1A89LnZKTc5dAXmcI4K36VVhLYggxmdm8lSsn1pGiIWseWnTRIU=
X-Received: by 2002:a05:690e:169d:b0:665:2045:fe47 with SMTP id 956f58d0204a3-668bfd60f01mr498522d50.7.1784922611220;
        Fri, 24 Jul 2026 12:50:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6689076865csm5364915d50.18.2026.07.24.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:50:10 -0700 (PDT)
Message-ID: <cbfaf50caecebcfca08ad583718328760b6dc907.camel@dubeyko.com>
Subject: Re: [PATCH 6/6] hfsplus: switch address_space_operations on
 iomap-based support
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org
Date: Fri, 24 Jul 2026 12:50:07 -0700
In-Reply-To: <20260724053748.GG4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com>
	 <20260722213759.1360225-7-slava@dubeyko.com> <20260724053748.GG4181@lst.de>
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

On Fri, 2026-07-24 at 07:37 +0200, Christoph Hellwig wrote:
> > @@ -605,20 +606,32 @@ void hfsplus_file_truncate(struct inode
> > *inode)
> > =C2=A0		inode->i_ino, (long long)hip->phys_size, inode-
> > >i_size);
> > =C2=A0
> > =C2=A0	if (inode->i_size > hip->phys_size) {
> > +		if (S_ISREG(inode->i_mode)) {
> > +			res =3D hfsplus_iomap_cont_expand(inode,
> > inode->i_size);
> > +			if (res)
> > +				return;
> > +
> > +			mark_inode_dirty(inode);
> > +		} else {
> > +			struct address_space *mapping =3D inode-
> > >i_mapping;
> > +			struct folio *folio;
> > +			void *fsdata =3D NULL;
> > +
> > +			res =3D hfsplus_write_begin(NULL, mapping,
> > +						=C2=A0 inode->i_size,
> > 0,
> > +						=C2=A0 &folio,
> > &fsdata);
> > +			if (res)
> > +				return;
> > +
> > +			res =3D generic_write_end(NULL, mapping,
> > +						inode->i_size, 0,
> > 0,
> > +						folio, fsdata);
> > +			if (res < 0)
> > +				return;
> > +
> > +			mark_inode_dirty(inode);
>=20
> Can't this use the iomap zeroing helpers?

Sounds like a good idea. Let me check it.

>=20
> > -static int hfsplus_writepages(struct address_space *mapping,
> > +static int hfsplus_legacy_writepages(struct address_space
> > *mapping,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct writeback_control *wbc)
> > =C2=A0{
> > =C2=A0	return mpage_writepages(mapping, wbc, hfsplus_get_block);
> > @@ -196,8 +139,8 @@ static int hfsplus_writepages(struct
> > address_space *mapping,
> > =C2=A0const struct address_space_operations hfsplus_btree_aops =3D {
> > =C2=A0	.dirty_folio	=3D block_dirty_folio,
> > =C2=A0	.invalidate_folio =3D block_invalidate_folio,
> > -	.read_folio	=3D hfsplus_read_folio,
> > -	.writepages	=3D hfsplus_writepages,
> > +	.read_folio	=3D hfsplus_legacy_read_folio,
> > +	.writepages	=3D hfsplus_legacy_writepages,
>=20
> Would btree be a better name then legacy?=C2=A0 So the story here is
> there is a btree inode, and you want to keep the buffer_head based
> path for this, at least for now?

Yeah, makes sense. I have the same feeling here. :)

>=20
> > @@ -290,10 +274,22 @@ static int hfsplus_setattr(struct mnt_idmap
> > *idmap,
> > =C2=A0	=C2=A0=C2=A0=C2=A0 attr->ia_size !=3D i_size_read(inode)) {
> > =C2=A0		inode_dio_wait(inode);
> > =C2=A0		if (attr->ia_size > inode->i_size) {
> > -			error =3D generic_cont_expand_simple(inode,
> > -							=C2=A0=C2=A0 attr-
> > >ia_size);
> > -			if (error)
> > -				return error;
> > +			if (S_ISREG(inode->i_mode)) {
> > +				loff_t old_size =3D inode->i_size;
> > +
> > +				i_size_write(inode, attr-
> > >ia_size);
> > +				error =3D
> > hfsplus_iomap_cont_expand(inode,
> > +								=C2=A0
> > attr->ia_size);
> > +				if (error) {
> > +					i_size_write(inode,
> > old_size);
> > +					return error;
> > +				}
> > +			} else {
> > +				error =3D
> > generic_cont_expand_simple(inode,
> > +								=C2=A0=C2=A0
> > attr->ia_size);
> > +				if (error)
> > +					return error;
> > +			}
>=20
> You're not suppoed to see ->setattr for ATTR_SIZE for anything but
> regular files from the VFS.=C2=A0 I don't think there's any hfsplus
> specific
> path that could cause this either, could it?

I think you are right. Let me re-check the code here.

Thanks,
Slava.
