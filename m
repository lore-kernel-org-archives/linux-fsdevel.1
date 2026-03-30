Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD11B4F0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852266; cv=none; b=GXI27IlH3s1MyvHar2CcArqnoTSXW9UX1JCiS9uG2Ga9CachlM4SSftDO+yvrxoczUeWPgwRJo2umI1z/Lv0VBUL1wA0MJLKd7qG2dLTfSY3skzsnstks7wUgadGnejKAv1A38rVVghUgp9b6EqHk68GeTgOvyxYbVprbmi+RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852266; c=relaxed/simple;
	bh=ojTeJGBV7Nwdf0jSQObbFsiDRxM9F+SWYKKYPCWfOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLxSMwQx2lWjsHdMsaaCvHrQv7nwyOwanPFN1D0zg+nccAPtMpO85PKLucrrcGt/xv2OKfXN46Pzdn1zwvqs8Y6NoP9gFb6H9T6LRVBEYOIKF5zdZEMFscrZewe3RZ/yELLaP6XNMx73qa0Nye4PkC7LSpu98q83V+UjNJCVInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09F7C68B05; Mon, 30 Mar 2026 08:31:00 +0200 (CEST)
Date: Mon, 30 Mar 2026 08:30:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com
Subject: Re: [PATCH 1/5] exfat: add iomap support
Message-ID: <20260330063059.GA5897@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326115045.9525-2-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  
> -static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
> +int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync)

This looks like at least partially unrelated refactoring.  Can you
split this out into a separate well-documented patch, or maybe even
two where one has the bulk reformatting changes, and one adds the
new bsync option?  Also it might help to document the bsync option.
Often it might be more readable to add a flags parameter with a named
flag to make things easier to follow.

> -static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> -		unsigned int *clu, unsigned int *count, int create)
> +int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> +		unsigned int *clu, unsigned int *count, int create,
> +		bool *balloc)

Similarly, this would be a good prep patch.

> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> new file mode 100644
> index 000000000000..e4135a13454f
> --- /dev/null
> +++ b/fs/exfat/iomap.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * iomap callack functions
> + *
> + * Copyright (C) 2026 Namjae Jeon <linkinjeon@kernel.org>
> + */

Also normally new infrastructure would get added with the users.
I.e. the bits you're using in the first iomap conversion would go
with that and so on.  But that's not a strict rule.

> +/*
> + * exfat_iomap_put_folio - Put folio after iomap operation
> + *
> + * Called when iomap is finished with a folio zero-fills portions of
> + * the folio beyond ->valid_size to prevent exposing uninitialized data.
> + */
> +static void exfat_iomap_put_folio(struct inode *inode, loff_t pos,
> +		unsigned int len, struct folio *folio)

Can you explain the logic here?  Shouldn't the iomap buffered I/O
code do all the needed zeroing for you based on the map type?  If not
how could we enhance the core iomap code so that we don't need this
in the file system, which feels like a bit of break of abstraction
barriers?

> +/*
> + * exfat_file_write_dio_end_io - Direct I/O write completion handler
> + *
> + * Updates i_size if the write extended the file. Called from the dio layer
> + * after I/O completion.
> + */
> +static int exfat_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
> +		int error, unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error)
> +		return error;
> +
> +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> +		i_size_write(inode, iocb->ki_pos + size);
> +		mark_inode_dirty(inode);
> +	}
> +
> +	return 0;
> +}

I think in the long run we should just do this as the default in
the core iomap dio code when no end_io routine is provided for
writes.  But I can refactor this later to not hold you up.

> +static int exfat_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{

The read and write routines look very similar, and chance we could
extra most of the logic into a common helper?  Also the rounding of
the length using the start in the write version looks like it would
be the right thing for the read side anyway.

> +static int exfat_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
> +		loff_t length, unsigned int flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	return __exfat_write_iomap_begin(inode, offset, length, iomap);
> +}

The special mkwrite handling looks a bit odd to me.  I'll return to
that later in the series, but this is a good example where keeping
all the related code together would help the reviewer.

> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length) {
> +		int error;
> +
> +		error = exfat_read_iomap_begin(wpc->inode, offset, len,
> +				0, &wpc->iomap, NULL);

The read confused me a bit here, but I guess by the time we do writeback
everything is allocated in exfat.  This would be another good candidate
to directly call the low-level helper suggested above.

> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 83396fd265cd..b69c4b0a926b 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -499,6 +499,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
>  	if (p_boot->num_fats == 2)
>  		sbi->FAT2_start_sector += sbi->num_FAT_sectors;
>  	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
> +	sbi->data_start_bytes = sbi->data_start_sector << p_boot->sect_size_bits;

Is this related to iomap?

