Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1841C302;
	Wed,  1 Jul 2026 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930108; cv=none; b=g3xlX1XRmKkPgMMQkB0grJiZgXYUb/Pz/kR6wEUSBPG3tIHdPS3fcLjRDC268dPwuR5JvBVJ3M2hP/iUD/qWV2EDKVxQWfNIdTkKRlEE7Tk7Ztov6Q+g0KIvBL+sawYc9zVcnK/wwQb7l4nDMeq+sLbMtEG02+D8aSAygMngPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930108; c=relaxed/simple;
	bh=Bniyw73TgYj1gap0wa//hkS7nZUqeOCUdCLmYvEPhKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N28ZxhM5ownJ0CgXqnaaNt2dUw2g4MxSmF9fcpYGYkNeektTi7Ykb7h2cUbkHczTglFW9ZJKYUXalSAmP9eMGvACczsMeSE8Oys1EhH8ZnN63Mfft8wTrBsU8YA/62Sq51Qz8+k4ilSKK78vEzPF0V9wiqEzZs4b00fGYKnIii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrQyZySy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrQyZySy"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 91D231F000E9;
	Wed,  1 Jul 2026 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930106;
	bh=mjoy8b4zeN+eEt8Ujy90M9bpPd/sEjknDPy9PIKCnSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VrQyZySyS1FUeoQXsgdOie2apJP7Rc/8PJ0PhfcRVDlOyeeOeTIzz+NfQZLJtFrk9
	 zxErMSxMblAMBF78EZF1c4I3vblretWEf6ZL+DApfMtsGQEXyeelgeCrEL00js/671
	 +5wjIl471iEN7g3Z3w/hvUubN0T3QujwhMRR8gtP8XV4tDn6d9XP9ULhj6wiXrQ9Uf
	 kcWLJ9QlBSqu91Y9AZ80hz2AzgvJ6JZp9fQJ+fvFd4Vm5AibH5bnt3aiD/fAVnZqj7
	 k6PZzeEuyiqQGZpwEA3xEHdopTiNCTHREM+5Hqo2MJRUe2N/0rrwLg/wEfjUYlmJ60
	 EqES0KglIfNWw==
Date: Wed, 1 Jul 2026 11:21:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	hch@infradead.org, viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v2 3/4] minix: convert file operations to iomap and add
Message-ID: <20260701182146.GD6507@frogsfrogsfrogs>
References: <cover.1782619718.git.jbingham@gmail.com>
 <44e53f18f7bc7d190c2676e66a0b77a40a62d448.1782619718.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e53f18f7bc7d190c2676e66a0b77a40a62d448.1782619718.git.jbingham@gmail.com>

On Sat, Jun 27, 2026 at 10:15:55PM -0700, Jeremy Bingham wrote:
> Subject: [PATCH v2 3/4] minix: convert file operations to iomap and add

...add what?

> Replace generic_file_read_iter and generic_file_write_iter with custom
> minix_file_read_iter and minix_file_write_iter that dispatch to iomap
> for both buffered and direct I/O.
> 
> Buffered writes now go through iomap_file_buffered_write instead of
> the aops write_begin/write_end path (which no longer exists for
> regular files). Buffered reads still use generic_file_read_iter
> for the non-DIO case.
> 
> Direct I/O is implemented via iomap_dio_rw for both reads and writes.
> minix_dio_read_iter takes a shared inode lock; minix_dio_write_iter
> takes an exclusive lock, does generic_write_checks, and falls back
> to buffered writes via iomap_file_buffered_write for the tail of a
> DIO write that is not block-aligned. The minix_dio_write_end_io
> callback updates i_size and marks the inode dirty.
> 
> minix_file_open sets FMODE_CAN_ODIRECT so the VFS allows O_DIRECT
> opens, and splice_write is added to the file operations.

Ignore my question about FMODE_CAN_ODIRECT in the previous patch, then.

> minix_setattr is exported (made non-static) so it can be shared by
> the symlink inode operations in a subsequent patch.
> 
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
> ---
>  fs/minix/file.c  | 157 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/minix/minix.h |   2 +
>  2 files changed, 153 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/minix/file.c b/fs/minix/file.c
> index 86e5943cd2ff..b07c853fa43a 100644
> --- a/fs/minix/file.c
> +++ b/fs/minix/file.c
> @@ -17,21 +17,166 @@ int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  			start, end, datasync);
>  }
>  
> +static ssize_t minix_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = iocb->ki_filp->f_mapping->host;
> +	ssize_t ret;
> +
> +	inode_lock_shared(inode);
> +
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
> +
> +	ret = iomap_dio_rw(iocb, to, ops, NULL, 0, NULL, 0);
> +	inode_unlock_shared(inode);
> +	return ret;
> +}
> +
> +static int minix_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> +		unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	loff_t pos = iocb->ki_pos;
> +
> +	if (error)
> +		return error;
> +
> +	pos += size;
> +	if (size && pos > i_size_read(inode)) {
> +		i_size_write(inode, pos);
> +		mark_inode_dirty(inode);
> +	}
> +	return 0;
> +}
> +
> +static const struct iomap_dio_ops minix_dio_write_ops = {
> +	.end_io = minix_dio_write_end_io,
> +};
> +
> +static ssize_t minix_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = iocb->ki_filp->f_mapping->host;
> +	ssize_t ret;
> +	unsigned int flags = 0;
> +	unsigned long blocksize = inode->i_sb->s_blocksize;
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out_unlock;
> +
> +	ret = kiocb_modified(iocb);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
> +		!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize))
> +		flags |= IOMAP_DIO_FORCE_WAIT;
> +
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
> +
> +	ret = iomap_dio_rw(iocb, from, ops,
> +		&minix_dio_write_ops, flags, NULL, 0);
> +	if (ret == -ENOTBLK)
> +		ret = 0; /* fallback to buffered */
> +
> +	if (ret >= 0 && iov_iter_count(from)) {
> +		loff_t pos;
> +		loff_t endbyte;
> +		ssize_t status;
> +
> +		iocb->ki_flags &= ~IOCB_DIRECT;

Why not set IOC_DSYNC here and let generic_write_sync do all the
flushing work for you?  There's no requirement to dump the pagecache
after a downgraded direct write, but if you want that, use
IOCB_DONTCACHE.

--D

> +		pos = iocb->ki_pos;
> +		status = iomap_file_buffered_write(iocb, from, ops,
> +			NULL, NULL);
> +		if (unlikely(status < 0)) {
> +			ret = status;
> +			goto out_unlock;
> +		}
> +
> +		ret += status;
> +		endbyte = pos + status - 1;
> +		status = filemap_write_and_wait_range(inode->i_mapping, pos, endbyte);
> +		if (!status) {
> +			invalidate_mapping_pages(inode->i_mapping,
> +				pos >> PAGE_SHIFT,
> +				endbyte >> PAGE_SHIFT);
> +			if (ret > 0)
> +				ret = generic_write_sync(iocb, ret);
> +		} else {
> +			ret = status;
> +		}
> +	}
> +
> +out_unlock:
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
> +static ssize_t minix_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return minix_dio_read_iter(iocb, to);
> +
> +	return generic_file_read_iter(iocb, to);
> +}
> +
> +static ssize_t minix_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = iocb->ki_filp->f_mapping->host;
> +	ssize_t ret;
> +
> +	/* minix_dio_write_iter also locks the inode and appears to do the same
> +	 * general sorts of checks as this, so just return directly from there.
> +	 */
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return minix_dio_write_iter(iocb, from);
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto unlock;
> +
> +	ret = file_modified(iocb->ki_filp);
> +	if (ret)
> +		goto unlock;
> +
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
> +
> +	ret = iomap_file_buffered_write(iocb, from, ops,
> +			NULL, NULL);
> +
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +
> +unlock:
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
> +static int minix_file_open(struct inode *inode, struct file *filp)
> +{
> +	filp->f_mode |= FMODE_CAN_ODIRECT;
> +	return generic_file_open(inode, filp);
> +}
> +
>  /*
> - * We have mostly NULLs here: the current defaults are OK for
> - * the minix filesystem.
> + * We still have some NULLs here, but not as many of the current defaults are
> + * still OK for the minix filesystem.
>   */
> +
>  const struct file_operations minix_file_operations = {
>  	.llseek		= generic_file_llseek,
> -	.read_iter	= generic_file_read_iter,
> -	.write_iter	= generic_file_write_iter,
> +	.read_iter	= minix_file_read_iter,
> +	.write_iter	= minix_file_write_iter,
>  	.mmap_prepare	= generic_file_mmap_prepare,
> +	.open		= minix_file_open,
>  	.fsync		= minix_fsync,
>  	.splice_read	= filemap_splice_read,
> +	.splice_write	= iter_file_splice_write,
>  };
>  
> -static int minix_setattr(struct mnt_idmap *idmap,
> -			 struct dentry *dentry, struct iattr *attr)
> +int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +	struct iattr *attr)
>  {
>  	struct inode *inode = d_inode(dentry);
>  	int error;
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index 77e503cca97f..76718f789369 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -58,6 +58,8 @@ void minix_free_block(struct inode *inode, unsigned long block);
>  unsigned long minix_count_free_blocks(struct super_block *sb);
>  int minix_getattr(struct mnt_idmap *, const struct path *,
>  		struct kstat *, u32, unsigned int);
> +int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +	struct iattr *attr);
>  int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
>  struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
>  int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
> -- 
> 2.47.3
> 
> 
