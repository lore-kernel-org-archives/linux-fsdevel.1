Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427337A82C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871473; cv=none; b=jQwxnWpA9V+Pe2ZDemiRwGW4KS+IzldVeN5EZJypwjdMt6FQR62upmUAfiMmAddPjWJKqTfqVVjyYeIx3VHNmP5rUDSEt2eIjB2LtMYa+S/hT39i3hrY7OkgBgtELL9Rfp3fpYZYl5Yg5dUtgX6DAojePP80JrRkIFhnM9a9aE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871473; c=relaxed/simple;
	bh=btUf793ULRMO21obNP89onMcSoaVURWBWzL+3HfoLFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmeGEY1BPsMKsPM9bx9ba9sH1yf3KNiT49pyb0De2dkADet0xfdHX6d4DmUghkkktgwQK1xLk1Q7eW6rBJcqBYFFekOgFdIG4RHV8kc8mS1+yoLkGKfzOIiqmykeixqv28tfpNQ+5oE199YTu7LZZ7kheQnBqH3xzmGYNnzznOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E38468BEB; Fri, 24 Jul 2026 07:37:49 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:37:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/6] hfsplus: switch address_space_operations on
 iomap-based support
Message-ID: <20260724053748.GG4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-7-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722213759.1360225-7-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> @@ -605,20 +606,32 @@ void hfsplus_file_truncate(struct inode *inode)
>  		inode->i_ino, (long long)hip->phys_size, inode->i_size);
>  
>  	if (inode->i_size > hip->phys_size) {
> +		if (S_ISREG(inode->i_mode)) {
> +			res = hfsplus_iomap_cont_expand(inode, inode->i_size);
> +			if (res)
> +				return;
> +
> +			mark_inode_dirty(inode);
> +		} else {
> +			struct address_space *mapping = inode->i_mapping;
> +			struct folio *folio;
> +			void *fsdata = NULL;
> +
> +			res = hfsplus_write_begin(NULL, mapping,
> +						  inode->i_size, 0,
> +						  &folio, &fsdata);
> +			if (res)
> +				return;
> +
> +			res = generic_write_end(NULL, mapping,
> +						inode->i_size, 0, 0,
> +						folio, fsdata);
> +			if (res < 0)
> +				return;
> +
> +			mark_inode_dirty(inode);

Can't this use the iomap zeroing helpers?

> -static int hfsplus_writepages(struct address_space *mapping,
> +static int hfsplus_legacy_writepages(struct address_space *mapping,
>  			      struct writeback_control *wbc)
>  {
>  	return mpage_writepages(mapping, wbc, hfsplus_get_block);
> @@ -196,8 +139,8 @@ static int hfsplus_writepages(struct address_space *mapping,
>  const struct address_space_operations hfsplus_btree_aops = {
>  	.dirty_folio	= block_dirty_folio,
>  	.invalidate_folio = block_invalidate_folio,
> -	.read_folio	= hfsplus_read_folio,
> -	.writepages	= hfsplus_writepages,
> +	.read_folio	= hfsplus_legacy_read_folio,
> +	.writepages	= hfsplus_legacy_writepages,

Would btree be a better name then legacy?  So the story here is
there is a btree inode, and you want to keep the buffer_head based
path for this, at least for now?

> @@ -290,10 +274,22 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
>  	    attr->ia_size != i_size_read(inode)) {
>  		inode_dio_wait(inode);
>  		if (attr->ia_size > inode->i_size) {
> -			error = generic_cont_expand_simple(inode,
> -							   attr->ia_size);
> -			if (error)
> -				return error;
> +			if (S_ISREG(inode->i_mode)) {
> +				loff_t old_size = inode->i_size;
> +
> +				i_size_write(inode, attr->ia_size);
> +				error = hfsplus_iomap_cont_expand(inode,
> +								  attr->ia_size);
> +				if (error) {
> +					i_size_write(inode, old_size);
> +					return error;
> +				}
> +			} else {
> +				error = generic_cont_expand_simple(inode,
> +								   attr->ia_size);
> +				if (error)
> +					return error;
> +			}

You're not suppoed to see ->setattr for ATTR_SIZE for anything but
regular files from the VFS.  I don't think there's any hfsplus specific
path that could cause this either, could it?

