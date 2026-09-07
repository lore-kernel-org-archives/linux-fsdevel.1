Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BC51E42B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800758; cv=none; b=qeYEycIJjZiqqyLXt7S6maSTTf6wjpnyvh+2mD3bsQgMuGGlXsef8ESEpBm4p1pg6RxZP25Wo+OlcTed/VnvWThu35seZMJ+EtEM9pbhcjGWRteRk1koBdBSh15bUtOEva4KopMVWgAVYPg1kLqUSAW4m0NNU/qdonjthHZSia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800758; c=relaxed/simple;
	bh=30E5+fn1SPBaPinE5yhL9vLNK+JbITEUO6qnT0TgdOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZRwUgSwwT62ehHFG3F1jT+DGSrO/5rtACOFkPk3vFQo+hmeJOrGUHqaTsc9VwZFMEAcSBCW2Y2Aip4iYxBKmexWCTkvvx3KB4ksqLxvhctqhOnlcU362G9s7HN/Yt3zFKtCu2hgeXg2q6+um1KngoZm7U2+X4plt/aGGHfnEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=nMkC82fi; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="nMkC82fi"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-785073ad5ccso2578870137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788800754; x=1789405554; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ViMkmwSoErS7rxxMTiQ1fqBwA5lQ27YbW52AFDf1PI=;
        b=nMkC82fiE0qrtydvqmovNXyKhS6Bo2yeRyyrJqHZdusVz8GawhSnphotCH0CKxvkYp
         THDr1T6zBoK93qFpAhs9h/qbpWq5gGO3RwvKHplbiAQGYRUPDx2yvS8F9Z09PvhK1LwH
         2kPT2sG2CYm5FoaANHqiRiCawKd57LjAvz3wcRDuxC+7wh4PB8lNYXHlNdgcePH7pzze
         cO3xduMT8z2uMB3rDo0yiTz0CqVwVKvOLWE3IcFaIhektlf8ZOxQdkC3otQw7Il4j0kP
         ccgqxvMTsFyNo6I3toclxphc+A2j5PHdUjcAVCfi7JcwQwYgZ5sY73VwSUiy1XEFzwWe
         6yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800754; x=1789405554;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ViMkmwSoErS7rxxMTiQ1fqBwA5lQ27YbW52AFDf1PI=;
        b=LFU1VNzxfixJB08zow9o1dyNN8iRhCfgblbyms2zppuk5RKjPSK8PVfIP7Jotx7OhN
         IeDL2NfIIZyvm20NEsIsco1SE3l1+ZxMLdac7gtuac3Nl/+serc/D5ejGfnW3B7f7JD/
         bxQLJNgmhHZ05LD2837wjXi9RNHY/XBR/bBe+FwK1SkQ+DeuRm5TRdvEIlbE7iDJGNMo
         MsCTXlPGfNiIT+XXM3IojgiQzqPKqwDttb8bHxTOvtm7TFGz7gHC9g4j9JJGR8T2o3OP
         eDc8g/lQi1n+Y+vLetzNDS4Qg/CeVeb1Lp7N6MBbD1YZ6b2Rt9Zet1Qs/Xnvt0zQjkjl
         ugFg==
X-Gm-Message-State: AFuF++kfXaooDeTjMpw2THmURSLDEqmsmdFCj0tNfmfOqA9HagwR3yep
	tI1g9iGrBaqhBxumMrZ0v4tJyw1EWviDDz/c1CRKPzIdaN1fxYMnf6jybf9me5uNe+L0wb8K0Pf
	6CmrKgYc=
X-Gm-Gg: AYBFou3jvLimLcMmzr5lGwscA1+HxT0OWTDcutO9espejq9Imo+qBVzUYJJocugmdI8
	qRocc+yie1ogBz6UCzIN2VkYe/OWCuK0i1znADJ0REsOprMUFJe5m0nu8vRptl7xuAddmAXLYBS
	BFAsBiDAH9frp4suR66avMU6/6iQqk0Gra7/dQSxc9QHreHXLW4ywRhMzGwBKuRcxwwOGV+s1XF
	hhDIg+5KjuuntmO3jILLinUoRBbtRc3sfuB9q15o14jRngceL/hQcHTX8EqO3pCJE85NiLC0Enf
	NyD/7iwaCSF2Z1394VyH6BrvuwqVD6girEKRe3oLdjaNXS1GM+tsV6SGl1WGnyV4RpEM/8GtKG8
	4U1Ho8EY1f747u31fSdhOOjstHa/UwDlJMKk9Apqy5B9f6fdxULXagLlQ0hpGqMyE1z42uC2dOU
	FPDRafQaNBSzBN7Sg7QwYm5itSC/cHCRKlBW6nRU4H8AfZFYhwkZ7mUh0gWupbqv7cxd1En+EGy
	a/5MW/79rEinsdNK5ptB/qqocnJGRJQV/mQgd5Y8IrubCPMdYzC6qkQVMM3jZA3xfvcyZ47fz5v
	Goltdk+M1qN4ifWEOEaNrkHF4WUjKQaRz5+3Zvl1cBfZi6SMEQbA5NM=
X-Received: by 2002:a05:6102:1484:b0:785:1d9c:633c with SMTP id ada2fe7eead31-78a4a8436b7mr10378157137.7.1788800754614;
        Mon, 07 Sep 2026 10:05:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:51d3:d0fc:6793:303f? ([2600:1700:6476:1430:51d3:d0fc:6793:303f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a4764e321sm7450610137.0.2026.09.07.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:05:51 -0700 (PDT)
Message-ID: <56524bbf4d0a08e932f9cea18861538151a89534.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ThangNN99 <ngocthang2710.1999@gmail.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Mon, 07 Sep 2026 10:05:50 -0700
In-Reply-To: <20260906154924.94160-1-ngocthang2710.1999@gmail.com>
References: <20260906154924.94160-1-ngocthang2710.1999@gmail.com>
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

On Sun, 2026-09-06 at 22:49 +0700, ThangNN99 wrote:
> hfs_bmap_reserve() calls hfsplus_file_extend() on tree->inode with
> tree->tree_lock already held.=C2=A0 When the tree is the extents overflow
> B-tree and its own fork already claims more blocks than its eight
> fork extents describe, hfsplus_file_extend() calls
> hfsplus_ext_read_extent() -> hfs_find_init() on that same tree,
> taking tree_lock a second time (lockdep: "possible recursive locking
> ... &tree->tree_lock/1").

Could you please explain the use-case or workload that is trying to
claim more blocks that fork can include for Extents Overflow file?
Could you please share the call trace for the issue?

Thanks,
Slava.

>=20
> Per the HFS+ format the extents overflow file is fully described by
> its eight fork extents, so this state only arises from a corrupted
> image. hfsplus_get_block() already refuses it for lookups; do the
> same when growing the file.
>=20
> Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
> Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
> ---
> =C2=A0fs/hfsplus/extents.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524d18..39920b51e08b 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -458,6 +458,15 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	if (hip->alloc_blocks =3D=3D hip->first_blocks)
> =C2=A0		goal =3D hfsplus_ext_lastblock(hip->first_extents);
> =C2=A0	else {
> +		/*
> +		 * The extents overflow file can't have overflow
> extents of
> +		 * its own; growing it here would re-enter
> hfs_find_init()
> +		 * on the extents tree, whose tree_lock is already
> held.
> +		 */
> +		if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID) {
> +			res =3D -EIO;
> +			goto out;
> +		}
> =C2=A0		res =3D hfsplus_ext_read_extent(inode, hip-
> >alloc_blocks);
> =C2=A0		if (res)
> =C2=A0			goto out;
