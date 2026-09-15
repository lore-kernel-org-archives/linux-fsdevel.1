Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C8318EC7;
	Tue, 15 Sep 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438889; cv=none; b=hcwbcbY54NoxrjLiLf1HIY+9AiZkXN+G7EwT68vs9piEiWW1PAPZhqFyOQTlrmS4LRXpDViY8ak0GMBg/mPGrOs8ifkDGSj5lt2LAztzsK/9LFhV26qEVML/L+AkYxVq+VsUyk8TYED/7AvRHCWn6hj6UNNjDxA1bdDOwpud17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438889; c=relaxed/simple;
	bh=QyCzCiCQKqKIqNKkJujbVB9xs+pNK2GcpEVhQzhGGfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OADtItC1c+9IYamjzHtqgG8jzOxq4GyYSxslt/MjWZlNmhQncfMFPH+5iim+n5kKpFhZrL7k1eE9Ehaz3l9PCF6YDSscmu5RaoIwdwC5dtqdkKEaqip0E6g3GbPI6w0GnSEOsATzzYVRY9r7RBxCG+14vOHiiwmeMFlNpPZXQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANJpYFss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANJpYFss"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F1C161F000FF;
	Tue, 15 Sep 2026 02:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438888;
	bh=sAw9QXNvSxj/ebYlXindjh6Kr+uDMmPUDvKEEPKgv5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ANJpYFssEM7aULo/x1CR9LFqmxenVuYBhPNThosHcsLIiLiS01UVX/pLYQdSgAaAT
	 kv9fuSXvnMlGFqj6FiGx5EbVpXtuGV8/GqoK3abpMl6V9r318Xbijl6ghzb8Fkk6n3
	 QPKW0kKzrxcmvwiOKDNr+eTD3hqFWkdk6JdcMdh5eoN2OPgYAjI8MMfQqWPxK2AJGy
	 mELsdd6wSGqMO0myd9VDI2kqyfiLS1/gxU0uxlzTMa3pGnxGuRaxyClOmrNsCg4C23
	 dDs46YCPQd2WwIRkDP6uyLyX9gFUlGXv4fp/FLR7k2+hYlPYSBNGrf99VeASXfMnUV
	 sBJklzfz743Vg==
Date: Mon, 14 Sep 2026 19:21:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org
Subject: Re: [PATCH v4 7/7] hfsplus: switch address_space_operations on
 iomap-based support
Message-ID: <20260915022127.GB6244@frogsfrogsfrogs>
References: <20260914233941.2966421-1-slava@dubeyko.com>
 <20260914233941.2966421-8-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-8-slava@dubeyko.com>

On Mon, Sep 14, 2026 at 04:39:41PM -0700, Viacheslav Dubeyko wrote:
> This patch switches the regular file operations on iomap-based
> ones. The hfsplus_aops is redefined as the iomap-based
> operations. As a result, hfsplus_direct_IO() has been completely
> removed as a user of blockdev_direct_IO(). Also, unnecessary
> LEGACY_DIRECT_IO dependency has been removed from Kconfig.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/hfsplus/Kconfig      |   1 -
>  fs/hfsplus/extents.c    |  47 ++++++++----
>  fs/hfsplus/file.c       |   2 +-
>  fs/hfsplus/hfsplus_fs.h |   1 +
>  fs/hfsplus/inode.c      | 160 +++++++++++++++++++++-------------------
>  fs/hfsplus/iomap.c      |  14 ++--
>  fs/hfsplus/iomap.h      |   2 +-
>  7 files changed, 127 insertions(+), 100 deletions(-)
> 
> diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
> index 865a1966f395..b4432c64db3b 100644
> --- a/fs/hfsplus/Kconfig
> +++ b/fs/hfsplus/Kconfig
> @@ -5,7 +5,6 @@ config HFSPLUS_FS
>  	select BUFFER_HEAD
>  	select NLS
>  	select NLS_UTF8
> -	select LEGACY_DIRECT_IO
>  	select FS_IOMAP
>  	help
>  	  If you say Y here, you will be able to mount extended format
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index ffd52ad8867c..b724cc1ca3e1 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -15,6 +15,7 @@
>  
>  #include "hfsplus_fs.h"
>  #include "hfsplus_raw.h"
> +#include "iomap.h"
>  
>  /* Compare two extents keys, returns 0 on same, pos/neg for difference */
>  int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
> @@ -275,6 +276,8 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
>  		*max_blocks = hfsplus_ext_find_block(hip->first_extents,
>  						     ablock,
>  						     dblock);
> +		if (!*max_blocks)
> +			return -EIO;
>  		return 0;
>  	}
>  
> @@ -302,6 +305,9 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
>  	if (was_dirty)
>  		mark_inode_dirty(inode);
>  
> +	if (!*max_blocks)
> +		return -EIO;
> +
>  	return 0;
>  }
>  
> @@ -342,7 +348,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
>  
>  	if (create) {
>  		set_buffer_new(bh_result);
> -		hip->phys_size += sb->s_blocksize;
> +		hip->phys_size = (loff_t)(iblock + 1) << sb->s_blocksize_bits;
>  		hip->fs_blocks++;
>  		inode_add_bytes(inode, sb->s_blocksize);
>  		mark_inode_dirty(inode);
> @@ -607,20 +613,33 @@ void hfsplus_file_truncate(struct inode *inode)
>  		inode->i_ino, (long long)hip->phys_size, inode->i_size);
>  
>  	if (inode->i_size > hip->phys_size) {
> -		struct address_space *mapping = inode->i_mapping;
> -		struct folio *folio;
> -		void *fsdata = NULL;
> -		loff_t size = inode->i_size;
> +		if (S_ISREG(inode->i_mode)) {
> +			res = hfsplus_iomap_cont_expand(inode, hip->phys_size,
> +							inode->i_size);
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
> +		}
>  
> -		res = hfsplus_write_begin(NULL, mapping, size, 0,
> -					  &folio, &fsdata);
> -		if (res)
> -			return;
> -		res = generic_write_end(NULL, mapping, size, 0, 0,
> -					folio, fsdata);
> -		if (res < 0)
> -			return;
> -		mark_inode_dirty(inode);
>  		return;
>  	} else if (inode->i_size == hip->phys_size)
>  		return;
> diff --git a/fs/hfsplus/file.c b/fs/hfsplus/file.c
> index 5a5776881c3e..0b0ae6b6e307 100644
> --- a/fs/hfsplus/file.c
> +++ b/fs/hfsplus/file.c
> @@ -212,7 +212,7 @@ static ssize_t hfsplus_file_write_iter(struct kiocb *iocb,
>  		loff_t old_size = i_size_read(inode);
>  
>  		i_size_write(inode, iocb->ki_pos);
> -		err = hfsplus_iomap_cont_expand(inode, iocb->ki_pos);
> +		err = hfsplus_iomap_cont_expand(inode, old_size, iocb->ki_pos);

Hmm, I guess this was the change that generic/363 required?  Which is to
say, the ability to zero specific EOF ranges rather than just phys_size
to the new EOF?

If so, then I think I understand this well enough to
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		if (err) {
>  			i_size_write(inode, old_size);
>  			ret = err;
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 190c7de704fd..844027679a75 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -466,6 +466,7 @@ void hfsplus_file_truncate(struct inode *inode);
>  
>  /* inode.c */
>  extern const struct address_space_operations hfsplus_aops;
> +extern const struct address_space_operations hfsplus_symlink_aops;
>  extern const struct address_space_operations hfsplus_btree_aops;
>  extern const struct dentry_operations hfsplus_dentry_operations;
>  
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 9d25e6224ee5..1779061dcad5 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -18,15 +18,12 @@
>  #include <linux/cred.h>
>  #include <linux/uio.h>
>  #include <linux/fileattr.h>
> +#include <linux/iomap.h>
>  
>  #include "hfsplus_fs.h"
>  #include "hfsplus_raw.h"
>  #include "xattr.h"
> -
> -static int hfsplus_read_folio(struct file *file, struct folio *folio)
> -{
> -	return block_read_full_folio(folio, hfsplus_get_block);
> -}
> +#include "iomap.h"
>  
>  static void hfsplus_write_failed(struct address_space *mapping, loff_t to)
>  {
> @@ -128,67 +125,13 @@ static bool hfsplus_release_folio(struct folio *folio, gfp_t mask)
>  	return res ? try_to_free_buffers(folio) : false;
>  }
>  
> -static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> +static int hfsplus_btree_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct file *file = iocb->ki_filp;
> -	struct address_space *mapping = file->f_mapping;
> -	struct inode *inode = mapping->host;
> -	loff_t isize;
> -	size_t count = iov_iter_count(iter);
> -	loff_t end = iocb->ki_pos + count;
> -	ssize_t ret;
> -
> -	/*
> -	 * The hfsplus_get_block() only allows creating the next sequential block.
> -	 * For direct writes beyond EOF, expand the file first.
> -	 */
> -	if (iov_iter_rw(iter) == WRITE && iocb->ki_pos > i_size_read(inode)) {
> -		loff_t start_off, end_off;
> -		loff_t start_page, end_page;
> -
> -		isize = i_size_read(inode);
> -
> -		/*
> -		 * Wait for any in-flight DIO on this inode to finish before
> -		 * calling generic_cont_expand_simple().
> -		 */
> -		inode_dio_wait(inode);
> -
> -		ret = generic_cont_expand_simple(inode, iocb->ki_pos);
> -		if (ret)
> -			return ret;
> -
> -		start_off = isize;
> -		end_off = (end > 0) ? end - 1 : end;
> -
> -		ret = filemap_write_and_wait_range(mapping, start_off, end_off);
> -		if (ret)
> -			return ret;
> -
> -		start_page = start_off >> PAGE_SHIFT;
> -		end_page = end_off >> PAGE_SHIFT;
> -
> -		invalidate_inode_pages2_range(mapping, start_page, end_page);
> -	}
> -
> -	ret = blockdev_direct_IO(iocb, inode, iter, hfsplus_get_block);
> -
> -	/*
> -	 * In case of error extending write may have instantiated a few
> -	 * blocks outside i_size. Trim these off again.
> -	 */
> -	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
> -		isize = i_size_read(inode);
> -
> -		if (end > isize)
> -			hfsplus_write_failed(mapping, end);
> -	}
> -
> -	return ret;
> +	return block_read_full_folio(folio, hfsplus_get_block);
>  }
>  
> -static int hfsplus_writepages(struct address_space *mapping,
> -			      struct writeback_control *wbc)
> +static int hfsplus_btree_writepages(struct address_space *mapping,
> +				    struct writeback_control *wbc)
>  {
>  	return mpage_writepages(mapping, wbc, hfsplus_get_block);
>  }
> @@ -196,8 +139,8 @@ static int hfsplus_writepages(struct address_space *mapping,
>  const struct address_space_operations hfsplus_btree_aops = {
>  	.dirty_folio	= block_dirty_folio,
>  	.invalidate_folio = block_invalidate_folio,
> -	.read_folio	= hfsplus_read_folio,
> -	.writepages	= hfsplus_writepages,
> +	.read_folio	= hfsplus_btree_read_folio,
> +	.writepages	= hfsplus_btree_writepages,
>  	.write_begin	= hfsplus_write_begin,
>  	.write_end	= generic_write_end,
>  	.migrate_folio	= buffer_migrate_folio,
> @@ -205,18 +148,70 @@ const struct address_space_operations hfsplus_btree_aops = {
>  	.release_folio	= hfsplus_release_folio,
>  };
>  
> -const struct address_space_operations hfsplus_aops = {
> +static int hfsplus_symlink_read_folio(struct file *file, struct folio *folio)
> +{
> +	return block_read_full_folio(folio, hfsplus_get_block);
> +}
> +
> +static int hfsplus_symlink_writepages(struct address_space *mapping,
> +				      struct writeback_control *wbc)
> +{
> +	return mpage_writepages(mapping, wbc, hfsplus_get_block);
> +}
> +
> +const struct address_space_operations hfsplus_symlink_aops = {
>  	.dirty_folio	= block_dirty_folio,
>  	.invalidate_folio = block_invalidate_folio,
> -	.read_folio	= hfsplus_read_folio,
> +	.read_folio	= hfsplus_symlink_read_folio,
>  	.write_begin	= hfsplus_write_begin,
>  	.write_end	= generic_write_end,
>  	.bmap		= hfsplus_bmap,
> -	.direct_IO	= hfsplus_direct_IO,
> -	.writepages	= hfsplus_writepages,
> +	.writepages	= hfsplus_symlink_writepages,
>  	.migrate_folio	= buffer_migrate_folio,
>  };
>  
> +static int hfsplus_read_folio(struct file *file, struct folio *folio)
> +{
> +	iomap_bio_read_folio(folio, &hfsplus_iomap_ops);
> +	return 0;
> +}
> +
> +static void hfsplus_readahead(struct readahead_control *rac)
> +{
> +	iomap_bio_readahead(rac, &hfsplus_iomap_ops);
> +}
> +
> +static int hfsplus_writepages(struct address_space *mapping,
> +			      struct writeback_control *wbc)
> +{
> +	struct iomap_writepage_ctx wpc = {
> +		.inode	= mapping->host,
> +		.wbc	= wbc,
> +		.ops	= &hfsplus_writeback_ops,
> +	};
> +
> +	return iomap_writepages(&wpc);
> +}
> +
> +static sector_t hfsplus_aop_bmap(struct address_space *mapping, sector_t block)
> +{
> +	return iomap_bmap(mapping, block, &hfsplus_iomap_ops);
> +}
> +
> +const struct address_space_operations hfsplus_aops = {
> +	.read_folio		= hfsplus_read_folio,
> +	.readahead		= hfsplus_readahead,
> +	.writepages		= hfsplus_writepages,
> +	.dirty_folio		= iomap_dirty_folio,
> +	.bmap			= hfsplus_aop_bmap,
> +	.migrate_folio		= filemap_migrate_folio,
> +	.is_partially_uptodate	= iomap_is_partially_uptodate,
> +	.error_remove_folio	= generic_error_remove_folio,
> +	.release_folio		= iomap_release_folio,
> +	.invalidate_folio	= iomap_invalidate_folio,
> +	.swap_activate		= hfsplus_iomap_swap_activate,
> +};
> +
>  const struct dentry_operations hfsplus_dentry_operations = {
>  	.d_hash       = hfsplus_hash_dentry,
>  	.d_compare    = hfsplus_compare_dentry,
> @@ -290,13 +285,28 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
>  	    attr->ia_size != i_size_read(inode)) {
>  		inode_dio_wait(inode);
>  		if (attr->ia_size > inode->i_size) {
> -			error = generic_cont_expand_simple(inode,
> -							   attr->ia_size);
> +			loff_t old_size = inode->i_size;
> +
> +			i_size_write(inode, attr->ia_size);
> +			error = hfsplus_iomap_cont_expand(inode, old_size,
> +							  attr->ia_size);
> +			if (error) {
> +				i_size_write(inode, old_size);
> +				return error;
> +			}
> +			truncate_setsize(inode, attr->ia_size);
> +		} else {
> +			bool did_zero = false;
> +
> +			error = iomap_truncate_page(inode, attr->ia_size,
> +						    &did_zero,
> +						    &hfsplus_write_iomap_ops,
> +						    NULL, NULL);
>  			if (error)
>  				return error;
> +			truncate_setsize(inode, attr->ia_size);
> +			hfsplus_file_truncate(inode);
>  		}
> -		truncate_setsize(inode, attr->ia_size);
> -		hfsplus_file_truncate(inode);
>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	}
>  
> @@ -399,7 +409,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
>  		sbi->file_count++;
>  		inode->i_op = &hfsplus_symlink_inode_operations;
>  		inode_nohighmem(inode);
> -		inode->i_mapping->a_ops = &hfsplus_aops;
> +		inode->i_mapping->a_ops = &hfsplus_symlink_aops;
>  		hip->clump_blocks = 1;
>  	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
>  		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
> @@ -540,7 +550,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
>  		} else if (S_ISLNK(inode->i_mode)) {
>  			inode->i_op = &hfsplus_symlink_inode_operations;
>  			inode_nohighmem(inode);
> -			inode->i_mapping->a_ops = &hfsplus_aops;
> +			inode->i_mapping->a_ops = &hfsplus_symlink_aops;
>  		} else {
>  			inode->i_op = &hfsplus_special_inode_operations;
>  			init_special_inode(inode, inode->i_mode,
> diff --git a/fs/hfsplus/iomap.c b/fs/hfsplus/iomap.c
> index 5723e854e58e..0eb392789126 100644
> --- a/fs/hfsplus/iomap.c
> +++ b/fs/hfsplus/iomap.c
> @@ -137,18 +137,16 @@ const struct iomap_ops hfsplus_write_iomap_ops = {
>  /*
>   * hfsplus_iomap_cont_expand()
>   *
> - * Zero-extend the backing store from the current phys_size up to 'size'.
> - * Used both by hfsplus_setattr() and by hfsplus_file_truncate().
> + * Zero the byte range [from, to) of a file that is being extended, where
> + * 'from' is the old end-of-file and 'to' the new one. Used by the extending
> + * write path, hfsplus_setattr() (truncate up) and hfsplus_file_truncate().
>   */
> -int hfsplus_iomap_cont_expand(struct inode *inode, loff_t size)
> +int hfsplus_iomap_cont_expand(struct inode *inode, loff_t from, loff_t to)
>  {
> -	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
> -	loff_t start = hip->phys_size;
> -
> -	if (size <= start)
> +	if (to <= from)
>  		return 0;
>  
> -	return iomap_zero_range(inode, start, size - start, NULL,
> +	return iomap_zero_range(inode, from, to - from, NULL,
>  				&hfsplus_write_iomap_ops, NULL, NULL);
>  }
>  
> diff --git a/fs/hfsplus/iomap.h b/fs/hfsplus/iomap.h
> index dac07a9d25f8..4dd4aca1804f 100644
> --- a/fs/hfsplus/iomap.h
> +++ b/fs/hfsplus/iomap.h
> @@ -11,7 +11,7 @@ extern const struct iomap_ops hfsplus_write_iomap_ops;
>  extern const struct iomap_writeback_ops hfsplus_writeback_ops;
>  extern const struct iomap_dio_ops hfsplus_write_dio_ops;
>  
> -int hfsplus_iomap_cont_expand(struct inode *inode, loff_t size);
> +int hfsplus_iomap_cont_expand(struct inode *inode, loff_t from, loff_t to);
>  int hfsplus_iomap_swap_activate(struct swap_info_struct *sis,
>  				struct file *file, sector_t *span);
>  
> -- 
> 2.43.0
> 
> 
