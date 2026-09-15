Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D74BEE58;
	Tue, 15 Sep 2026 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438928; cv=none; b=oqWIK8HR51vfikuUCzGrX71H1prXblv8y8fOnmDV0e1BRlP6eRrDyzoL7zUI1fRt2tsZH1Fbmec+wV0Km88WA/5li4MxaVeiBlBFI47oAzKNL/MYa2DEs+yx9O91ILkpmUilTpS2YmrzHDHn2uOpjmwqoRgsylM7RZylGJr2+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438928; c=relaxed/simple;
	bh=QWL8okAXB0bPfSahAZzZibN5pDSaZiJRHzaA4r7LFn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye2kf3+4nzOo9dq1jgllwoNGBCwmV7o/sLHMdbHUcmSGzWo4D9c5MVP3KIHb5aPWVTMLDoysp4bzaSVUDW8Ff7U8NjWI7BcXuBv1te3vHEhn/6O2dKOr0aZULRO0D6eyNF9a1hlUgfGIJwvbzVOpOT/99/IxwZxsg9xLZV4FgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c23y+VGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c23y+VGP"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 526041F000FF;
	Tue, 15 Sep 2026 02:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438926;
	bh=q4nBabLzKltVP8WrWcjSNTuLhxGDwKZxgHOOQrR0uMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c23y+VGPj0ps3CjlJcCABT5ZDRUK8MevUuvS8BirMjLmvyeFzSn8DBLApNqzkxZY1
	 eW3Nq4LI1URd+/byyxrK4Vuepsm0HFSTtQlmF6x1TVDWzYgh9kwi51CSmkvrSm6b/+
	 6PeS/VqbOXHxx3CPv6WBnTtcQxCRuGdc81TuKvp2bF6vgzacBfDA1fkrrDraXyyqAw
	 cNNUtwuECndd7lVfzbHX4QVL60ECvo83T3w1hvx+PhTh+ZJA+vr4zjbvn5z8JzhXb7
	 /K+UPBrRB7b5h416VH2SpwG3/HRoVXjlBHn+CqV3V5M62kkVmwYHLl5Lk1YJoGFKXH
	 cnyzaLkp3SnDA==
Date: Mon, 14 Sep 2026 19:22:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org
Subject: Re: [PATCH v4 5/7] hfsplus: move file related operations to file.c
Message-ID: <20260915022205.GC6244@frogsfrogsfrogs>
References: <20260914233941.2966421-1-slava@dubeyko.com>
 <20260914233941.2966421-6-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-6-slava@dubeyko.com>

On Mon, Sep 14, 2026 at 04:39:39PM -0700, Viacheslav Dubeyko wrote:
> This patch introduces fs/hfsplus/file.c and moves
> file related operations from fs/hfsplus/inode.c
> into the new file.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org

Makes sense to me to split up file vs. inode code,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/hfsplus/Makefile     |   6 +-
>  fs/hfsplus/file.c       | 133 ++++++++++++++++++++++++++++++++++++++++
>  fs/hfsplus/hfsplus_fs.h |   7 ++-
>  fs/hfsplus/inode.c      | 122 ------------------------------------
>  4 files changed, 141 insertions(+), 127 deletions(-)
>  create mode 100644 fs/hfsplus/file.c
> 
> diff --git a/fs/hfsplus/Makefile b/fs/hfsplus/Makefile
> index 2416dfdc3190..3ddea69a9c69 100644
> --- a/fs/hfsplus/Makefile
> +++ b/fs/hfsplus/Makefile
> @@ -5,9 +5,9 @@
>  
>  obj-$(CONFIG_HFSPLUS_FS) += hfsplus.o
>  
> -hfsplus-objs := super.o options.o inode.o iomap.o ioctl.o extents.o catalog.o \
> -		dir.o btree.o bnode.o brec.o bfind.o tables.o unicode.o \
> -		wrapper.o bitmap.o part_tbl.o \
> +hfsplus-objs := super.o options.o inode.o file.o iomap.o ioctl.o extents.o \
> +		catalog.o dir.o btree.o bnode.o brec.o bfind.o tables.o \
> +		unicode.o wrapper.o bitmap.o part_tbl.o \
>  		attributes.o xattr.o xattr_user.o xattr_security.o xattr_trusted.o
>  
>  # KUnit tests
> diff --git a/fs/hfsplus/file.c b/fs/hfsplus/file.c
> new file mode 100644
> index 000000000000..509046aad0c6
> --- /dev/null
> +++ b/fs/hfsplus/file.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * File operations: open/release/fsync and iomap-based read/write/seek
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/uio.h>
> +#include <linux/mount.h>
> +
> +#include "hfsplus_fs.h"
> +#include "hfsplus_raw.h"
> +
> +static int hfsplus_file_open(struct inode *inode, struct file *file)
> +{
> +	if (HFSPLUS_IS_RSRC(inode))
> +		inode = HFSPLUS_I(inode)->rsrc_inode;
> +	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
> +		return -EOVERFLOW;
> +	atomic_inc(&HFSPLUS_I(inode)->opencnt);
> +	return 0;
> +}
> +
> +static int hfsplus_file_release(struct inode *inode, struct file *file)
> +{
> +	struct super_block *sb = inode->i_sb;
> +
> +	if (HFSPLUS_IS_RSRC(inode))
> +		inode = HFSPLUS_I(inode)->rsrc_inode;
> +	if (atomic_dec_and_test(&HFSPLUS_I(inode)->opencnt)) {
> +		inode_lock(inode);
> +		hfsplus_file_truncate(inode);
> +		if (inode->i_flags & S_DEAD) {
> +			hfsplus_delete_cat(inode->i_ino,
> +					   HFSPLUS_SB(sb)->hidden_dir, NULL);
> +			hfsplus_delete_inode(inode);
> +		}
> +		inode_unlock(inode);
> +	}
> +	return 0;
> +}
> +
> +int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
> +		       int datasync)
> +{
> +	struct inode *inode = file->f_mapping->host;
> +	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
> +	struct hfsplus_vh *vhdr = sbi->s_vhdr;
> +	int error = 0, error2;
> +
> +	hfs_dbg("inode->i_ino %llu, start %llu, end %llu\n",
> +		inode->i_ino, start, end);
> +
> +	error = file_write_and_wait_range(file, start, end);
> +	if (error)
> +		return error;
> +	inode_lock(inode);
> +
> +	/*
> +	 * Sync inode metadata into the catalog and extent trees.
> +	 */
> +	sync_inode_metadata(inode, 1);
> +
> +	/*
> +	 * And explicitly write out the btrees.
> +	 */
> +	if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY,
> +				&HFSPLUS_I(HFSPLUS_CAT_TREE_I(sb))->flags)) {
> +		clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags);
> +		error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
> +	}
> +
> +	if (test_and_clear_bit(HFSPLUS_I_EXT_DIRTY,
> +				&HFSPLUS_I(HFSPLUS_EXT_TREE_I(sb))->flags)) {
> +		clear_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags);
> +		error2 =
> +			filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
> +		if (!error)
> +			error = error2;
> +	}
> +
> +	if (sbi->attr_tree) {
> +		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY,
> +				&HFSPLUS_I(HFSPLUS_ATTR_TREE_I(sb))->flags)) {
> +			clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags);
> +			error2 =
> +				filemap_write_and_wait(
> +					    sbi->attr_tree->inode->i_mapping);
> +			if (!error)
> +				error = error2;
> +		}
> +	} else {
> +		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags))
> +			pr_err("sync non-existent attributes tree\n");
> +	}
> +
> +	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY,
> +				&HFSPLUS_I(sbi->alloc_file)->flags)) {
> +		clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags);
> +		error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
> +		if (!error)
> +			error = error2;
> +	}
> +
> +	mutex_lock(&sbi->vh_mutex);
> +	hfsplus_prepare_volume_header_for_commit(vhdr);
> +	mutex_unlock(&sbi->vh_mutex);
> +
> +	error2 = hfsplus_commit_superblock(inode->i_sb);
> +	if (!error)
> +		error = error2;
> +
> +	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
> +		blkdev_issue_flush(inode->i_sb->s_bdev);
> +
> +	inode_unlock(inode);
> +
> +	return error;
> +}
> +
> +const struct file_operations hfsplus_file_operations = {
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= generic_file_read_iter,
> +	.write_iter	= generic_file_write_iter,
> +	.mmap_prepare	= generic_file_mmap_prepare,
> +	.splice_read	= filemap_splice_read,
> +	.splice_write	= iter_file_splice_write,
> +	.fsync		= hfsplus_file_fsync,
> +	.open		= hfsplus_file_open,
> +	.release	= hfsplus_file_release,
> +	.unlocked_ioctl = hfsplus_ioctl,
> +};
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 0a0df0388e7b..190c7de704fd 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -446,6 +446,11 @@ int hfsplus_rename_cat(u32 cnid, struct inode *src_dir, const struct qstr *src_n
>  extern const struct inode_operations hfsplus_dir_inode_operations;
>  extern const struct file_operations hfsplus_dir_operations;
>  
> +/* file.c */
> +extern const struct file_operations hfsplus_file_operations;
> +int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
> +		       int datasync);
> +
>  /* extents.c */
>  int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
>  			const hfsplus_btree_key *k2);
> @@ -480,8 +485,6 @@ int hfsplus_cat_write_inode(struct inode *inode);
>  int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		    struct kstat *stat, u32 request_mask,
>  		    unsigned int query_flags);
> -int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
> -		       int datasync);
>  int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
>  int hfsplus_fileattr_set(struct mnt_idmap *idmap,
>  			 struct dentry *dentry, struct file_kattr *fa);
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 2ce6de574fa6..9d25e6224ee5 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -276,35 +276,6 @@ static int hfsplus_get_perms(struct inode *inode,
>  	return -EIO;
>  }
>  
> -static int hfsplus_file_open(struct inode *inode, struct file *file)
> -{
> -	if (HFSPLUS_IS_RSRC(inode))
> -		inode = HFSPLUS_I(inode)->rsrc_inode;
> -	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
> -		return -EOVERFLOW;
> -	atomic_inc(&HFSPLUS_I(inode)->opencnt);
> -	return 0;
> -}
> -
> -static int hfsplus_file_release(struct inode *inode, struct file *file)
> -{
> -	struct super_block *sb = inode->i_sb;
> -
> -	if (HFSPLUS_IS_RSRC(inode))
> -		inode = HFSPLUS_I(inode)->rsrc_inode;
> -	if (atomic_dec_and_test(&HFSPLUS_I(inode)->opencnt)) {
> -		inode_lock(inode);
> -		hfsplus_file_truncate(inode);
> -		if (inode->i_flags & S_DEAD) {
> -			hfsplus_delete_cat(inode->i_ino,
> -					   HFSPLUS_SB(sb)->hidden_dir, NULL);
> -			hfsplus_delete_inode(inode);
> -		}
> -		inode_unlock(inode);
> -	}
> -	return 0;
> -}
> -
>  static int hfsplus_setattr(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr)
>  {
> @@ -361,86 +332,6 @@ int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	return 0;
>  }
>  
> -int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
> -		       int datasync)
> -{
> -	struct inode *inode = file->f_mapping->host;
> -	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
> -	struct super_block *sb = inode->i_sb;
> -	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
> -	struct hfsplus_vh *vhdr = sbi->s_vhdr;
> -	int error = 0, error2;
> -
> -	hfs_dbg("inode->i_ino %llu, start %llu, end %llu\n",
> -		inode->i_ino, start, end);
> -
> -	error = file_write_and_wait_range(file, start, end);
> -	if (error)
> -		return error;
> -	inode_lock(inode);
> -
> -	/*
> -	 * Sync inode metadata into the catalog and extent trees.
> -	 */
> -	sync_inode_metadata(inode, 1);
> -
> -	/*
> -	 * And explicitly write out the btrees.
> -	 */
> -	if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY,
> -				&HFSPLUS_I(HFSPLUS_CAT_TREE_I(sb))->flags)) {
> -		clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags);
> -		error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
> -	}
> -
> -	if (test_and_clear_bit(HFSPLUS_I_EXT_DIRTY,
> -				&HFSPLUS_I(HFSPLUS_EXT_TREE_I(sb))->flags)) {
> -		clear_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags);
> -		error2 =
> -			filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
> -		if (!error)
> -			error = error2;
> -	}
> -
> -	if (sbi->attr_tree) {
> -		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY,
> -				&HFSPLUS_I(HFSPLUS_ATTR_TREE_I(sb))->flags)) {
> -			clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags);
> -			error2 =
> -				filemap_write_and_wait(
> -					    sbi->attr_tree->inode->i_mapping);
> -			if (!error)
> -				error = error2;
> -		}
> -	} else {
> -		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags))
> -			pr_err("sync non-existent attributes tree\n");
> -	}
> -
> -	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY,
> -				&HFSPLUS_I(sbi->alloc_file)->flags)) {
> -		clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags);
> -		error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
> -		if (!error)
> -			error = error2;
> -	}
> -
> -	mutex_lock(&sbi->vh_mutex);
> -	hfsplus_prepare_volume_header_for_commit(vhdr);
> -	mutex_unlock(&sbi->vh_mutex);
> -
> -	error2 = hfsplus_commit_superblock(inode->i_sb);
> -	if (!error)
> -		error = error2;
> -
> -	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
> -		blkdev_issue_flush(inode->i_sb->s_bdev);
> -
> -	inode_unlock(inode);
> -
> -	return error;
> -}
> -
>  static const struct inode_operations hfsplus_file_inode_operations = {
>  	.setattr	= hfsplus_setattr,
>  	.getattr	= hfsplus_getattr,
> @@ -462,19 +353,6 @@ static const struct inode_operations hfsplus_special_inode_operations = {
>  	.listxattr	= hfsplus_listxattr,
>  };
>  
> -static const struct file_operations hfsplus_file_operations = {
> -	.llseek		= generic_file_llseek,
> -	.read_iter	= generic_file_read_iter,
> -	.write_iter	= generic_file_write_iter,
> -	.mmap_prepare	= generic_file_mmap_prepare,
> -	.splice_read	= filemap_splice_read,
> -	.splice_write	= iter_file_splice_write,
> -	.fsync		= hfsplus_file_fsync,
> -	.open		= hfsplus_file_open,
> -	.release	= hfsplus_file_release,
> -	.unlocked_ioctl = hfsplus_ioctl,
> -};
> -
>  struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
>  				umode_t mode)
>  {
> -- 
> 2.43.0
> 
> 
