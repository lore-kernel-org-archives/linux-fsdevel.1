Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B94416CFA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497450; cv=none; b=qU4KIKIfR1tzR8kBNR58NDonoh/gBHafa7RImdrTKspNBupeBQxPOlQRcXQv+Qw4wbYSS0D7r6AvM37D/g9WVoZNbysXhre/Nq0Pn2IsunYHVCH0UvdXCx8ZEcK1oUtzs66PAG0+otHGSK/QGGzcAMuLoTMaSp3XBARoIGPhEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497450; c=relaxed/simple;
	bh=ABuklsdgAsyxYHid4rDy6wSqUxRsRkr/tk+xMkawUYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/WmP+P+ro+odSwY69wKmi5jbbHBbF/hhyEdq9jk3rtlrpuTpGxers0mLtqLA2237f3D/BiHXaHX6XJzBZDZ2A/5soHJIGhSJUUG2XPTT2bqhqTKnd79sRxgmyZP6YBHtMQZ1C1pW1GvTNIXKG+p6Gv4HPtGejwFLvDVHJ6V9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=gWMjkbuq; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="gWMjkbuq"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d440939f1so684107b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789497447; x=1790102247; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSVMxYOZ1iYZR4IrHNElejqTsAwt7d9B7oquNKlNyBI=;
        b=gWMjkbuqvf93C59fJOAPPfrczjVUy6H1tt/Ewe3XXuZAiuOs4LvluiXbDhFWIRcQnp
         SZNt0IQe3ORetvfvNos6SVFJtwE3vHj4zTdYcPlgA9lgS+O/nbcpW0qoLDyOTBb2quYw
         LA1/V9SdnfnS8HEKB8GNLPjG489lCKBSYPl4hmG05TRBVom8RL6HOfm+TKqwPbXbJo6M
         RYjxKR7hDEbjaD9VL0SeCOwrI0V5JBKEwLZqVxpT6rAd1lSCaH1ua1DoaARTcno/ap/e
         A8GEbeR8EBdn1GekiUqagtzrcHE17TBJCE/TdXLehEKZUmoreqjovu6HhjX7Gl1ZSDdS
         K2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789497447; x=1790102247;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cSVMxYOZ1iYZR4IrHNElejqTsAwt7d9B7oquNKlNyBI=;
        b=JkNx4/8V9kBj5Ht5dzqInIShyH46ItMamSM9xE7dMXXiSURGdcwnVNYDDaZ5RDFETx
         f/XD2OPf5DA8o/seXcn5DlxDIhL7wZq2B2o4xZskiW6YeOsvaRMUNfEeR2rypNK7pyfy
         4uI9epacu7XpBQchomGOzHR2YPwCEP//6GVfoxHjGKrzCs0KwIigWx0FMP56j6+e7iOB
         2aHUK9MAnEoywjDZJ8CcC5J0FKzLx8hHpMYctaHagFZG6WoNFNUDTfqfiuuGp9XLrLQB
         34k4A3kpVz9bOi8/2Lkg2j42CdT2R1RjGgxafPwvXA4dVzo0MgfcnzDMILdk/O6e6TUj
         h4fA==
X-Forwarded-Encrypted: i=1; AKwUvBzdIFBa913Sfx0tBOqaDg13ibJzwm+O9UWP2GS+qyOXrZtYeDhsXLkP1oXT7P5ZbVFt/DhepRQeALBR0Jvo@vger.kernel.org
X-Gm-Message-State: AFuF++m5dd25Sa4pp0s1vDXJdhhP15sQwn7Du3MWyrcvKu/zjuZjxlft
	kwUQeQdXe4t7KNn1X46GYvT3/n2A8joruTPhvU+AS5iTcnP8sC5DVYLYxgMujYmzlVg=
X-Gm-Gg: AYBFou1Qa6bl76y5Uftx136sOdtirL3wE6rivu5MG58c+o62AbdckXaar8IVgIK1FxG
	t1HaEoy903DVfXe2oKU0ynojzFNojGsCIr16HXYi1HwokPYsABMOZ9HWyh49J4DhdToOYbNu9wr
	+W4mXBkKqQkcu7+EDjzq+D7pb7B1mGcfPBI9lRXbZwqlzQSbAwZLmHFYsioyaQ5gZW4fy0JEsdM
	OCvJbW74c2K9ICIv8JWZ1OR/HiNETbVs/Vjsb7XTmfaCHKwXq62YiOnVN0lrPR0CwAsiU27krw5
	n+d0aUrAZhniOKxbdEYcAJF05BRcl0FhX7Ea5uGD0tgJT66QML71c0hFoTpCjqqsXVdBznPAxl4
	Xmwv143SprMRgwLF+ZdWQMrPveyVufcSvcR6O/mCl/gAt33DiJb/ir0zZg059xj+fV9jkHAQotH
	tM11whPjHe51qpkxDd1C9TpyTfxqV7xsH0umiJPL2jEYo6p7hSC9pc7XbT4cZVAoV4uP2HJKxmJ
	GmOfP1yZDkzl1JB10H3evFqPwqb32ka1d4kpr7cI6/HzXgFh8m2j9FwpRv8hyr94ccYZMM75TYp
	rcCP7DyvhtqaODvrzXL4sksbXeYS5h7mPJLYfAw+6BwF5cv4V0BKVoI70BH22f3C
X-Received: by 2002:a05:690c:6602:b0:825:6bb8:5521 with SMTP id 00721157ae682-890f152f441mr8835507b3.32.1789497447278;
        Tue, 15 Sep 2026 11:37:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e9c6:4a77:70a9:9f1d? ([2600:1700:6476:1430:e9c6:4a77:70a9:9f1d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-891ef6333b2sm390327b3.25.2026.09.15.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:37:26 -0700 (PDT)
Message-ID: <e1a217fa86d2ea18dc817adf7d04bab4151fc117.camel@dubeyko.com>
Subject: Re: [PATCH v4 7/7] hfsplus: switch address_space_operations on
 iomap-based support
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org
Date: Tue, 15 Sep 2026 11:37:20 -0700
In-Reply-To: <20260915022127.GB6244@frogsfrogsfrogs>
References: <20260914233941.2966421-1-slava@dubeyko.com>
	 <20260914233941.2966421-8-slava@dubeyko.com>
	 <20260915022127.GB6244@frogsfrogsfrogs>
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

On Mon, 2026-09-14 at 19:21 -0700, Darrick J. Wong wrote:
> On Mon, Sep 14, 2026 at 04:39:41PM -0700, Viacheslav Dubeyko wrote:
> > This patch switches the regular file operations on iomap-based
> > ones. The hfsplus_aops is redefined as the iomap-based
> > operations. As a result, hfsplus_direct_IO() has been completely
> > removed as a user of blockdev_direct_IO(). Also, unnecessary
> > LEGACY_DIRECT_IO dependency has been removed from Kconfig.
> >=20
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > cc: Christoph Hellwig <hch@lst.de>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> > =C2=A0fs/hfsplus/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 =
-
> > =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 |=C2=A0 47 ++++++++----
> > =C2=A0fs/hfsplus/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +-
> > =C2=A0fs/hfsplus/hfsplus_fs.h |=C2=A0=C2=A0 1 +
> > =C2=A0fs/hfsplus/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 160 ++++++++++=
+++++++++++---------------
> > ----
> > =C2=A0fs/hfsplus/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ++--
> > =C2=A0fs/hfsplus/iomap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 =
+-
> > =C2=A07 files changed, 127 insertions(+), 100 deletions(-)
> >=20
> > diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
> > index 865a1966f395..b4432c64db3b 100644
> > --- a/fs/hfsplus/Kconfig
> > +++ b/fs/hfsplus/Kconfig
> > @@ -5,7 +5,6 @@ config HFSPLUS_FS
> > =C2=A0	select BUFFER_HEAD
> > =C2=A0	select NLS
> > =C2=A0	select NLS_UTF8
> > -	select LEGACY_DIRECT_IO
> > =C2=A0	select FS_IOMAP
> > =C2=A0	help
> > =C2=A0	=C2=A0 If you say Y here, you will be able to mount extended
> > format
> > diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> > index ffd52ad8867c..b724cc1ca3e1 100644
> > --- a/fs/hfsplus/extents.c
> > +++ b/fs/hfsplus/extents.c
> > @@ -15,6 +15,7 @@
> > =C2=A0
> > =C2=A0#include "hfsplus_fs.h"
> > =C2=A0#include "hfsplus_raw.h"
> > +#include "iomap.h"
> > =C2=A0
> > =C2=A0/* Compare two extents keys, returns 0 on same, pos/neg for
> > difference */
> > =C2=A0int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
> > @@ -275,6 +276,8 @@ int hfsplus_map_extent(struct inode *inode, u32
> > ablock, int create,
> > =C2=A0		*max_blocks =3D hfsplus_ext_find_block(hip-
> > >first_extents,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 ablock,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 dblock);
> > +		if (!*max_blocks)
> > +			return -EIO;
> > =C2=A0		return 0;
> > =C2=A0	}
> > =C2=A0
> > @@ -302,6 +305,9 @@ int hfsplus_map_extent(struct inode *inode, u32
> > ablock, int create,
> > =C2=A0	if (was_dirty)
> > =C2=A0		mark_inode_dirty(inode);
> > =C2=A0
> > +	if (!*max_blocks)
> > +		return -EIO;
> > +
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > @@ -342,7 +348,7 @@ int hfsplus_get_block(struct inode *inode,
> > sector_t iblock,
> > =C2=A0
> > =C2=A0	if (create) {
> > =C2=A0		set_buffer_new(bh_result);
> > -		hip->phys_size +=3D sb->s_blocksize;
> > +		hip->phys_size =3D (loff_t)(iblock + 1) << sb-
> > >s_blocksize_bits;
> > =C2=A0		hip->fs_blocks++;
> > =C2=A0		inode_add_bytes(inode, sb->s_blocksize);
> > =C2=A0		mark_inode_dirty(inode);
> > @@ -607,20 +613,33 @@ void hfsplus_file_truncate(struct inode
> > *inode)
> > =C2=A0		inode->i_ino, (long long)hip->phys_size, inode-
> > >i_size);
> > =C2=A0
> > =C2=A0	if (inode->i_size > hip->phys_size) {
> > -		struct address_space *mapping =3D inode->i_mapping;
> > -		struct folio *folio;
> > -		void *fsdata =3D NULL;
> > -		loff_t size =3D inode->i_size;
> > +		if (S_ISREG(inode->i_mode)) {
> > +			res =3D hfsplus_iomap_cont_expand(inode,
> > hip->phys_size,
> > +							inode-
> > >i_size);
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
> > +		}
> > =C2=A0
> > -		res =3D hfsplus_write_begin(NULL, mapping, size, 0,
> > -					=C2=A0 &folio, &fsdata);
> > -		if (res)
> > -			return;
> > -		res =3D generic_write_end(NULL, mapping, size, 0, 0,
> > -					folio, fsdata);
> > -		if (res < 0)
> > -			return;
> > -		mark_inode_dirty(inode);
> > =C2=A0		return;
> > =C2=A0	} else if (inode->i_size =3D=3D hip->phys_size)
> > =C2=A0		return;
> > diff --git a/fs/hfsplus/file.c b/fs/hfsplus/file.c
> > index 5a5776881c3e..0b0ae6b6e307 100644
> > --- a/fs/hfsplus/file.c
> > +++ b/fs/hfsplus/file.c
> > @@ -212,7 +212,7 @@ static ssize_t hfsplus_file_write_iter(struct
> > kiocb *iocb,
> > =C2=A0		loff_t old_size =3D i_size_read(inode);
> > =C2=A0
> > =C2=A0		i_size_write(inode, iocb->ki_pos);
> > -		err =3D hfsplus_iomap_cont_expand(inode, iocb-
> > >ki_pos);
> > +		err =3D hfsplus_iomap_cont_expand(inode, old_size,
> > iocb->ki_pos);
>=20
> Hmm, I guess this was the change that generic/363 required?=C2=A0 Which i=
s
> to
> say, the ability to zero specific EOF ranges rather than just
> phys_size
> to the new EOF?

Yes, exactly. This was the key issue in the previous versions of the
pathset.

Thanks,
Slava.

>=20
> If so, then I think I understand this well enough to
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
>=20
> --D
>=20
> > =C2=A0		if (err) {
> > =C2=A0			i_size_write(inode, old_size);
> > =C2=A0			ret =3D err;
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index 190c7de704fd..844027679a75 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -466,6 +466,7 @@ void hfsplus_file_truncate(struct inode
> > *inode);
> > =C2=A0
> > =C2=A0/* inode.c */
> > =C2=A0extern const struct address_space_operations hfsplus_aops;
> > +extern const struct address_space_operations hfsplus_symlink_aops;
> > =C2=A0extern const struct address_space_operations hfsplus_btree_aops;
> > =C2=A0extern const struct dentry_operations hfsplus_dentry_operations;
> > =C2=A0
> > diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> > index 9d25e6224ee5..1779061dcad5 100644
> > --- a/fs/hfsplus/inode.c
> > +++ b/fs/hfsplus/inode.c
> > @@ -18,15 +18,12 @@
> > =C2=A0#include <linux/cred.h>
> > =C2=A0#include <linux/uio.h>
> > =C2=A0#include <linux/fileattr.h>
> > +#include <linux/iomap.h>
> > =C2=A0
> > =C2=A0#include "hfsplus_fs.h"
> > =C2=A0#include "hfsplus_raw.h"
> > =C2=A0#include "xattr.h"
> > -
> > -static int hfsplus_read_folio(struct file *file, struct folio
> > *folio)
> > -{
> > -	return block_read_full_folio(folio, hfsplus_get_block);
> > -}
> > +#include "iomap.h"
> > =C2=A0
> > =C2=A0static void hfsplus_write_failed(struct address_space *mapping,
> > loff_t to)
> > =C2=A0{
> > @@ -128,67 +125,13 @@ static bool hfsplus_release_folio(struct
> > folio *folio, gfp_t mask)
> > =C2=A0	return res ? try_to_free_buffers(folio) : false;
> > =C2=A0}
> > =C2=A0
> > -static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct
> > iov_iter *iter)
> > +static int hfsplus_btree_read_folio(struct file *file, struct
> > folio *folio)
> > =C2=A0{
> > -	struct file *file =3D iocb->ki_filp;
> > -	struct address_space *mapping =3D file->f_mapping;
> > -	struct inode *inode =3D mapping->host;
> > -	loff_t isize;
> > -	size_t count =3D iov_iter_count(iter);
> > -	loff_t end =3D iocb->ki_pos + count;
> > -	ssize_t ret;
> > -
> > -	/*
> > -	 * The hfsplus_get_block() only allows creating the next
> > sequential block.
> > -	 * For direct writes beyond EOF, expand the file first.
> > -	 */
> > -	if (iov_iter_rw(iter) =3D=3D WRITE && iocb->ki_pos >
> > i_size_read(inode)) {
> > -		loff_t start_off, end_off;
> > -		loff_t start_page, end_page;
> > -
> > -		isize =3D i_size_read(inode);
> > -
> > -		/*
> > -		 * Wait for any in-flight DIO on this inode to
> > finish before
> > -		 * calling generic_cont_expand_simple().
> > -		 */
> > -		inode_dio_wait(inode);
> > -
> > -		ret =3D generic_cont_expand_simple(inode, iocb-
> > >ki_pos);
> > -		if (ret)
> > -			return ret;
> > -
> > -		start_off =3D isize;
> > -		end_off =3D (end > 0) ? end - 1 : end;
> > -
> > -		ret =3D filemap_write_and_wait_range(mapping,
> > start_off, end_off);
> > -		if (ret)
> > -			return ret;
> > -
> > -		start_page =3D start_off >> PAGE_SHIFT;
> > -		end_page =3D end_off >> PAGE_SHIFT;
> > -
> > -		invalidate_inode_pages2_range(mapping, start_page,
> > end_page);
> > -	}
> > -
> > -	ret =3D blockdev_direct_IO(iocb, inode, iter,
> > hfsplus_get_block);
> > -
> > -	/*
> > -	 * In case of error extending write may have instantiated
> > a few
> > -	 * blocks outside i_size. Trim these off again.
> > -	 */
> > -	if (unlikely(iov_iter_rw(iter) =3D=3D WRITE && ret < 0)) {
> > -		isize =3D i_size_read(inode);
> > -
> > -		if (end > isize)
> > -			hfsplus_write_failed(mapping, end);
> > -	}
> > -
> > -	return ret;
> > +	return block_read_full_folio(folio, hfsplus_get_block);
> > =C2=A0}
> > =C2=A0
> > -static int hfsplus_writepages(struct address_space *mapping,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct writeback_control *wbc)
> > +static int hfsplus_btree_writepages(struct address_space *mapping,
> > +				=C2=A0=C2=A0=C2=A0 struct writeback_control *wbc)
> > =C2=A0{
> > =C2=A0	return mpage_writepages(mapping, wbc, hfsplus_get_block);
> > =C2=A0}
> > @@ -196,8 +139,8 @@ static int hfsplus_writepages(struct
> > address_space *mapping,
> > =C2=A0const struct address_space_operations hfsplus_btree_aops =3D {
> > =C2=A0	.dirty_folio	=3D block_dirty_folio,
> > =C2=A0	.invalidate_folio =3D block_invalidate_folio,
> > -	.read_folio	=3D hfsplus_read_folio,
> > -	.writepages	=3D hfsplus_writepages,
> > +	.read_folio	=3D hfsplus_btree_read_folio,
> > +	.writepages	=3D hfsplus_btree_writepages,
> > =C2=A0	.write_begin	=3D hfsplus_write_begin,
> > =C2=A0	.write_end	=3D generic_write_end,
> > =C2=A0	.migrate_folio	=3D buffer_migrate_folio,
> > @@ -205,18 +148,70 @@ const struct address_space_operations
> > hfsplus_btree_aops =3D {
> > =C2=A0	.release_folio	=3D hfsplus_release_folio,
> > =C2=A0};
> > =C2=A0
> > -const struct address_space_operations hfsplus_aops =3D {
> > +static int hfsplus_symlink_read_folio(struct file *file, struct
> > folio *folio)
> > +{
> > +	return block_read_full_folio(folio, hfsplus_get_block);
> > +}
> > +
> > +static int hfsplus_symlink_writepages(struct address_space
> > *mapping,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct writeback_control
> > *wbc)
> > +{
> > +	return mpage_writepages(mapping, wbc, hfsplus_get_block);
> > +}
> > +
> > +const struct address_space_operations hfsplus_symlink_aops =3D {
> > =C2=A0	.dirty_folio	=3D block_dirty_folio,
> > =C2=A0	.invalidate_folio =3D block_invalidate_folio,
> > -	.read_folio	=3D hfsplus_read_folio,
> > +	.read_folio	=3D hfsplus_symlink_read_folio,
> > =C2=A0	.write_begin	=3D hfsplus_write_begin,
> > =C2=A0	.write_end	=3D generic_write_end,
> > =C2=A0	.bmap		=3D hfsplus_bmap,
> > -	.direct_IO	=3D hfsplus_direct_IO,
> > -	.writepages	=3D hfsplus_writepages,
> > +	.writepages	=3D hfsplus_symlink_writepages,
> > =C2=A0	.migrate_folio	=3D buffer_migrate_folio,
> > =C2=A0};
> > =C2=A0
> > +static int hfsplus_read_folio(struct file *file, struct folio
> > *folio)
> > +{
> > +	iomap_bio_read_folio(folio, &hfsplus_iomap_ops);
> > +	return 0;
> > +}
> > +
> > +static void hfsplus_readahead(struct readahead_control *rac)
> > +{
> > +	iomap_bio_readahead(rac, &hfsplus_iomap_ops);
> > +}
> > +
> > +static int hfsplus_writepages(struct address_space *mapping,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct writeback_control *wbc)
> > +{
> > +	struct iomap_writepage_ctx wpc =3D {
> > +		.inode	=3D mapping->host,
> > +		.wbc	=3D wbc,
> > +		.ops	=3D &hfsplus_writeback_ops,
> > +	};
> > +
> > +	return iomap_writepages(&wpc);
> > +}
> > +
> > +static sector_t hfsplus_aop_bmap(struct address_space *mapping,
> > sector_t block)
> > +{
> > +	return iomap_bmap(mapping, block, &hfsplus_iomap_ops);
> > +}
> > +
> > +const struct address_space_operations hfsplus_aops =3D {
> > +	.read_folio		=3D hfsplus_read_folio,
> > +	.readahead		=3D hfsplus_readahead,
> > +	.writepages		=3D hfsplus_writepages,
> > +	.dirty_folio		=3D iomap_dirty_folio,
> > +	.bmap			=3D hfsplus_aop_bmap,
> > +	.migrate_folio		=3D filemap_migrate_folio,
> > +	.is_partially_uptodate	=3D iomap_is_partially_uptodate,
> > +	.error_remove_folio	=3D generic_error_remove_folio,
> > +	.release_folio		=3D iomap_release_folio,
> > +	.invalidate_folio	=3D iomap_invalidate_folio,
> > +	.swap_activate		=3D hfsplus_iomap_swap_activate,
> > +};
> > +
> > =C2=A0const struct dentry_operations hfsplus_dentry_operations =3D {
> > =C2=A0	.d_hash=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D hfsplus_hash_den=
try,
> > =C2=A0	.d_compare=C2=A0=C2=A0=C2=A0 =3D hfsplus_compare_dentry,
> > @@ -290,13 +285,28 @@ static int hfsplus_setattr(struct mnt_idmap
> > *idmap,
> > =C2=A0	=C2=A0=C2=A0=C2=A0 attr->ia_size !=3D i_size_read(inode)) {
> > =C2=A0		inode_dio_wait(inode);
> > =C2=A0		if (attr->ia_size > inode->i_size) {
> > -			error =3D generic_cont_expand_simple(inode,
> > -							=C2=A0=C2=A0 attr-
> > >ia_size);
> > +			loff_t old_size =3D inode->i_size;
> > +
> > +			i_size_write(inode, attr->ia_size);
> > +			error =3D hfsplus_iomap_cont_expand(inode,
> > old_size,
> > +							=C2=A0 attr-
> > >ia_size);
> > +			if (error) {
> > +				i_size_write(inode, old_size);
> > +				return error;
> > +			}
> > +			truncate_setsize(inode, attr->ia_size);
> > +		} else {
> > +			bool did_zero =3D false;
> > +
> > +			error =3D iomap_truncate_page(inode, attr-
> > >ia_size,
> > +						=C2=A0=C2=A0=C2=A0 &did_zero,
> > +						=C2=A0=C2=A0=C2=A0
> > &hfsplus_write_iomap_ops,
> > +						=C2=A0=C2=A0=C2=A0 NULL, NULL);
> > =C2=A0			if (error)
> > =C2=A0				return error;
> > +			truncate_setsize(inode, attr->ia_size);
> > +			hfsplus_file_truncate(inode);
> > =C2=A0		}
> > -		truncate_setsize(inode, attr->ia_size);
> > -		hfsplus_file_truncate(inode);
> > =C2=A0		inode_set_mtime_to_ts(inode,
> > inode_set_ctime_current(inode));
> > =C2=A0	}
> > =C2=A0
> > @@ -399,7 +409,7 @@ struct inode *hfsplus_new_inode(struct
> > super_block *sb, struct inode *dir,
> > =C2=A0		sbi->file_count++;
> > =C2=A0		inode->i_op =3D &hfsplus_symlink_inode_operations;
> > =C2=A0		inode_nohighmem(inode);
> > -		inode->i_mapping->a_ops =3D &hfsplus_aops;
> > +		inode->i_mapping->a_ops =3D &hfsplus_symlink_aops;
> > =C2=A0		hip->clump_blocks =3D 1;
> > =C2=A0	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode-
> > >i_mode) ||
> > =C2=A0		=C2=A0=C2=A0 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode-
> > >i_mode)) {
> > @@ -540,7 +550,7 @@ int hfsplus_cat_read_inode(struct inode *inode,
> > struct hfs_find_data *fd)
> > =C2=A0		} else if (S_ISLNK(inode->i_mode)) {
> > =C2=A0			inode->i_op =3D
> > &hfsplus_symlink_inode_operations;
> > =C2=A0			inode_nohighmem(inode);
> > -			inode->i_mapping->a_ops =3D &hfsplus_aops;
> > +			inode->i_mapping->a_ops =3D
> > &hfsplus_symlink_aops;
> > =C2=A0		} else {
> > =C2=A0			inode->i_op =3D
> > &hfsplus_special_inode_operations;
> > =C2=A0			init_special_inode(inode, inode->i_mode,
> > diff --git a/fs/hfsplus/iomap.c b/fs/hfsplus/iomap.c
> > index 5723e854e58e..0eb392789126 100644
> > --- a/fs/hfsplus/iomap.c
> > +++ b/fs/hfsplus/iomap.c
> > @@ -137,18 +137,16 @@ const struct iomap_ops
> > hfsplus_write_iomap_ops =3D {
> > =C2=A0/*
> > =C2=A0 * hfsplus_iomap_cont_expand()
> > =C2=A0 *
> > - * Zero-extend the backing store from the current phys_size up to
> > 'size'.
> > - * Used both by hfsplus_setattr() and by hfsplus_file_truncate().
> > + * Zero the byte range [from, to) of a file that is being
> > extended, where
> > + * 'from' is the old end-of-file and 'to' the new one. Used by the
> > extending
> > + * write path, hfsplus_setattr() (truncate up) and
> > hfsplus_file_truncate().
> > =C2=A0 */
> > -int hfsplus_iomap_cont_expand(struct inode *inode, loff_t size)
> > +int hfsplus_iomap_cont_expand(struct inode *inode, loff_t from,
> > loff_t to)
> > =C2=A0{
> > -	struct hfsplus_inode_info *hip =3D HFSPLUS_I(inode);
> > -	loff_t start =3D hip->phys_size;
> > -
> > -	if (size <=3D start)
> > +	if (to <=3D from)
> > =C2=A0		return 0;
> > =C2=A0
> > -	return iomap_zero_range(inode, start, size - start, NULL,
> > +	return iomap_zero_range(inode, from, to - from, NULL,
> > =C2=A0				&hfsplus_write_iomap_ops, NULL,
> > NULL);
> > =C2=A0}
> > =C2=A0
> > diff --git a/fs/hfsplus/iomap.h b/fs/hfsplus/iomap.h
> > index dac07a9d25f8..4dd4aca1804f 100644
> > --- a/fs/hfsplus/iomap.h
> > +++ b/fs/hfsplus/iomap.h
> > @@ -11,7 +11,7 @@ extern const struct iomap_ops
> > hfsplus_write_iomap_ops;
> > =C2=A0extern const struct iomap_writeback_ops hfsplus_writeback_ops;
> > =C2=A0extern const struct iomap_dio_ops hfsplus_write_dio_ops;
> > =C2=A0
> > -int hfsplus_iomap_cont_expand(struct inode *inode, loff_t size);
> > +int hfsplus_iomap_cont_expand(struct inode *inode, loff_t from,
> > loff_t to);
> > =C2=A0int hfsplus_iomap_swap_activate(struct swap_info_struct *sis,
> > =C2=A0				struct file *file, sector_t
> > *span);
> > =C2=A0
> > --=20
> > 2.43.0
> >=20
> >=20
