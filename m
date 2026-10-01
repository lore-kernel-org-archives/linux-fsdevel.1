Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC73EFFC0
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889333; cv=none; b=qvqArGrrcGKl0CmEDob0rOlkXq3rDY+rHYKn+BFWRcYb/7MLe1r4NFicPqApS5nD4rU3/kyQuup3iKhGv8m0w6sbMfd+vk+FgmD7gP6QBFF+XpUaNT41CcMnlu4DCrJKlsovnEiPRNHOqVqik/5VfKlmeA9V5j8mf5Cg9jUWZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889333; c=relaxed/simple;
	bh=bhOBYeNMRLbf//CVHC3yTEwmKPzvtZhHLZaXcwqNFEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Npe0+NGm1bZo+becn1r3ytpUPmwQ9Fvso4QeQphfiSvFv2mL0o+BJqdJiK5teWHtMyjb3l+hUfseMkTrl6yNPniczWwVwiUz6AUiTkgSqyhj7O/fc43+b4ieEBXrIOxw9jx5cZYL6HqvnzzFZFxJchAHxYWs/+/9OQ0BcAmHsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=aaTXtS0k; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="aaTXtS0k"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fded6b087so6523098d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790889328; x=1791494128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FaMh4RqAX9pI7/4DtdIiH6UIpc8LCNjvGeQ4T3Xb7K8=;
        b=aaTXtS0keDH74ll9YveSqoWlwoRS59DppSATCqLRTqEfVppBZonbfNLYiruyzK+ENT
         Z/FgEhZ3/maTTcHhZ+3mF0rpK7u55/A7OuXhfn0IhePP1K5H+cT+R4JwDw5uJUzm6b9k
         zty7U3l/q+tapDn20eZeulR2yQCabpXp9zN0sDoig78Baow7RFeAiKsGgTu2RE8C6l9t
         uGXYDkIG4M5ACJMDIOWpc+TCCjORATmeQ9WnOBQDkBTx9WHaiO8iQ2KnYO/tofD4NkEN
         9Qc9lHKt6zepoI4BBdvacqsYOJ2Kvte6wwRmcK9vX+cFLwoUkIO77eosvtTCQTdsKTuy
         3X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889328; x=1791494128;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FaMh4RqAX9pI7/4DtdIiH6UIpc8LCNjvGeQ4T3Xb7K8=;
        b=jfHgOQjetl1dMxBs9FORbbgd0WzvMkcxHednJ69Ky9wXBEtzwK+I7bBdujZ6Qvg8ee
         Yois06LdVGAlh68+2YhrtwK1n4Rt9rUgJVEuumh8yFdHc+W1gnLV7C8tJePSv0EZ/HPv
         7xQkGWfMcOM+bOnYayvpQStSbkpTRUuFO6TCLXSNvN3FdIN2F1j1JGR8uRfOaHjOVnlA
         i433Q/xTH0pKqT2Kxsvy2bwmHx4QGPYC4w8qWjWn/R7MRKFPSIcPL8T26/zUtAaFCoNj
         HL45JzhJ3IqPuOkjkCcshjbaCCTV2N8Ax5ywQrc4LJvY2USIQtZI985iF4V0I42ZShQP
         EQIw==
X-Forwarded-Encrypted: i=1; AKwUvBwFI4ddzyURa5HFxcWZ4pdMTPDHVKsjooa/ympgxondvgv1yv4kkRPxljdzh1sgO9iJ+7vaZrtfP95ejJ+K@vger.kernel.org
X-Gm-Message-State: AFq9FYIunnuM7OcdWck6GR2/Z8DnSunH/6moEYw1RX6Vzi9ITH3N7lL8
	/Y8f6G8dVvanyKrYCtMDO17R7LsT5/yrJcv4sQB1H4ZJYWn/i1CvZFcO2h7ni+Wivg8=
X-Gm-Gg: AYBFou2HERJC2DdM26YTioORzOnAPBonnPdD5sA3mQKs0MBbYAmbGtvafzSJBlKK0AW
	gKvmcxtV7CecLkyOQCVXCd0uZ+Ua3UNFzyKGFMW+rrzbn4pED2j2rVqNvqd0Hr3qPwzCVPRiPTj
	+k5Wk8t4i69g3e1eAxQj9cagTdaDB0iwlyDXcKEXcXBN7IqPrxV/HwANDKdNSTUaIpRJaorcZru
	Sz5A5S6UrwwZ4lVQWmGGBdeQja9URJ5wyAT+pL0sPmTlsBhEVh8m9oYFJ8F+vEi8oGsh9Sxz+wS
	4tq2nFeApAi9jcOe+UhfWTzZbDatHuGyNimwLmDosSIDBjolK2M35gMLe31EX02EQGCXaq+nyml
	RJnSZY3EGRJSHhjT8zzpKur3rGQgdJKZCpNkK7+yrWpxSg+3bwvCirUyb4AP3IjBYmJ/JAZDggw
	j0UC04e2sn/GsZl2DH1AXSjbgjLggvONj/S0H+GBH4JEMGvgSEwcv3vZsR25aW36rrGJv+eT4ov
	6bDh7xPtPtgyjU/a5o8/TrxjqNRKQ4RmQKF9OdXgDv7134n3NA7U+2z7iJXbHxe+Fe6XvPMI/ue
	mgspo3Empm24QBL2QvSZxQdzTf83R4wHr0rwjVwFuHFLh55FjMgc+SiGWXW5yr5/
X-Received: by 2002:a05:690e:43dc:b0:66f:c1be:a646 with SMTP id 956f58d0204a3-677ac0cddadmr256545d50.56.1790889327878;
        Thu, 01 Oct 2026 14:15:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:67c2:3447:e08d:9418? ([2600:1700:6476:1430:67c2:3447:e08d:9418])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677ac1dce56sm219965d50.0.2026.10.01.14.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:15:27 -0700 (PDT)
Message-ID: <f82d2b0d8adc4705b878ebe7dbf1815ac2042173.camel@dubeyko.com>
Subject: Re: [PATCH v2 1/2] hfs: validate partition map entries in
 hfs_part_find()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 14:15:25 -0700
In-Reply-To: <995c9f50e1d6ac7f10087c67a48afd8f54cc5ffa.1790689266.git.matthias.goergens@gmail.com>
References: <cover.1790689266.git.matthias.goergens@gmail.com>
	 <995c9f50e1d6ac7f10087c67a48afd8f54cc5ffa.1790689266.git.matthias.goergens@gmail.com>
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

On Fri, 2026-10-02 at 00:21 +0800, Matthias Goergens wrote:
> hfs_mdb_get() loops around hfs_part_find(), rereading the MDB
> wherever
> the partition map points, and hfs_part_find() takes the start of a
> matching entry as it is.=C2=A0 A new-style entry with pmPyPartStart 0
> leaves
> part_start where it was, so the loop reads the same blocks forever
> and
> the mount hangs.
>=20
> Check each entry before following it.=C2=A0 The partition must be non-
> empty
> and start inside the device.=C2=A0 For a new-style map it must also start
> after the map, which begins at block 1 and whose size the first
> entry's
> pmMapBlkCnt gives (TN1189); the old-style parser keeps its rule of a
> non-zero start.=C2=A0 An entry that fails these checks is skipped, as the
> old-style parser already skipped entries with a zero start or size.=C2=A0
> The
> old-style parser now also stops at the first match, as the new-style
> one
> and hfsplus's copy do: it used to add up the starts of all matching
> entries, so the start it returned was not one that had been checked.
>=20
> Every partition-table hop now moves part_start past the map entries
> it
> has read, so the loop in hfs_mdb_get() ends and reads each block of a
> map at most once.=C2=A0 Rejecting only a zero start would end the loop
> too,
> but a crafted new-style map with an entry in every block could then
> make
> each of many small hops rescan most of the device.
>=20
> The end of the partition is not checked against the device.=C2=A0 hfs
> already
> mounts such a volume without its alternate MDB, and the block layer
> likewise keeps a partition that runs past the end of the disk,
> trimmed
> to fit.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> v2: check the entries in hfs_part_find() instead of limiting the hops
> in hfs_mdb_get(); stop at the first matching old-style entry.
>=20
> A partition entry pointing at its own map hangs the mount without
> this
> patch and fails at once with it:
>=20
> =C2=A0 img=3Dhfs-partmap-loop.img
> =C2=A0 put() { printf "$2" | dd of=3D$img bs=3D1 seek=3D$1 conv=3Dnotrunc
> status=3Dnone; }
> =C2=A0 truncate --size=3D64K $img
> =C2=A0 put $((512+0x00)) '\x50\x4d'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # pmSig 'PM'
> =C2=A0 put $((512+0x04)) '\x00\x00\x00\x01'=C2=A0 # pmMapBlkCnt 1
> =C2=A0 put $((512+0x08)) '\x00\x00\x00\x00'=C2=A0 # pmPyPartStart 0 (self=
)
> =C2=A0 put $((512+0x0c)) '\x00\x00\x00\x64'=C2=A0 # pmPartBlkCnt 100
> =C2=A0 put $((512+0x30)) 'Apple_HFS'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # pmPartType
> =C2=A0 mount -o ro,loop -t hfs $img /mnt
>=20
> =C2=A0fs/hfs/part_tbl.c | 27 ++++++++++++++++++++++++++-
> =C2=A01 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/part_tbl.c b/fs/hfs/part_tbl.c
> index 36add537d153e..2c15afe098127 100644
> --- a/fs/hfs/part_tbl.c
> +++ b/fs/hfs/part_tbl.c
> @@ -9,6 +9,8 @@
> =C2=A0 * a patch contributed by Holger Schemel (aeglos@valinor.owl.de).
> =C2=A0 */
> =C2=A0
> +#include <linux/blkdev.h>
> +
> =C2=A0#include "hfs_fs.h"
> =C2=A0
> =C2=A0/*
> @@ -49,6 +51,22 @@ struct old_pmap {
> =C2=A0	}	pdEntry[42];
> =C2=A0} __packed;
> =C2=A0
> +/*
> + * Check a partition map entry before following it.=C2=A0 The partition
> must
> + * be non-empty, start inside the device and start at or after
> @first:
> + * after the driver descriptor map in block 0 for an old-style map,
> and
> + * after the whole of a new-style map, whose size the first entry's
> + * pmMapBlkCnt gives (TN1189).=C2=A0 Every hop then moves forward, past
> the
> + * map entries just read, so hfs_mdb_get() cannot loop and reads
> each
> + * block of a map at most once.
> + */

Frankly speaking, comment is long and it only complicates everything. I
don't follow what hop means. Could we make the comment short, clear,
and more informative?

> +static bool hfs_part_valid(struct super_block *sb, sector_t base,
> +			=C2=A0=C2=A0 u64 first, u32 start, u32 size)

The set of argument is very confusing. As a result, it's really hard to
follow what we are checking and it is correct check or not. I think it
will be more clear to provide struct old_pmap pointer as argument. Why
not use part_start instead of base? What the first argument means?

> +{
> +	return start >=3D first && size &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base + start < bdev_nr_sectors(sb-=
>s_bdev);

We have part_size. Is it not the same as bdev_nr_sectors(sb->s_bdev)?

> +}
> +
> =C2=A0/*
> =C2=A0 * hfs_part_find()
> =C2=A0 *
> @@ -77,12 +95,15 @@ int hfs_part_find(struct super_block *sb,
> =C2=A0		p =3D pm->pdEntry;
> =C2=A0		size =3D 42;
> =C2=A0		for (i =3D 0; i < size; p++, i++) {
> -			if (p->pdStart && p->pdSize &&
> +			if (hfs_part_valid(sb, *part_start,
> HFS_DD_BLK + 1,

Do you mean HFS_PMAP_BLK here by HFS_DD_BLK + 1?

> +					=C2=A0=C2=A0 be32_to_cpu(p->pdStart),
> +					=C2=A0=C2=A0 be32_to_cpu(p->pdSize))
> &&
> =C2=A0			=C2=A0=C2=A0=C2=A0 p->pdFSID =3D=3D
> cpu_to_be32(0x54465331)/*"TFS1"*/ &&
> =C2=A0			=C2=A0=C2=A0=C2=A0 (HFS_SB(sb)->part < 0 || HFS_SB(sb)-
> >part =3D=3D i)) {

This check becomes too long and complicated now. I think we need to
introduce some good checking function.

> =C2=A0				*part_start +=3D be32_to_cpu(p-
> >pdStart);
> =C2=A0				*part_size =3D be32_to_cpu(p->pdSize);
> =C2=A0				res =3D 0;
> +				break;
> =C2=A0			}
> =C2=A0		}
> =C2=A0		break;
> @@ -95,6 +116,10 @@ int hfs_part_find(struct super_block *sb,
> =C2=A0		size =3D be32_to_cpu(pm->pmMapBlkCnt);
> =C2=A0		for (i =3D 0; i < size;) {
> =C2=A0			if (!memcmp(pm->pmPartType,"Apple_HFS", 9)
> &&
> +			=C2=A0=C2=A0=C2=A0 hfs_part_valid(sb, *part_start,
> +					=C2=A0=C2=A0 HFS_PMAP_BLK + (u64)size,

Why exactly HFS_PMAP_BLK + (u64)size?

> +					=C2=A0=C2=A0 be32_to_cpu(pm-
> >pmPyPartStart),
> +					=C2=A0=C2=A0 be32_to_cpu(pm-
> >pmPartBlkCnt)) &&
> =C2=A0			=C2=A0=C2=A0=C2=A0 (HFS_SB(sb)->part < 0 || HFS_SB(sb)-
> >part =3D=3D i)) {

Ditto.

Thanks,
Slava.

> =C2=A0				*part_start +=3D be32_to_cpu(pm-
> >pmPyPartStart);
> =C2=A0				*part_size =3D be32_to_cpu(pm-
> >pmPartBlkCnt);
