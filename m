Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE08387345;
	Wed, 13 May 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696334; cv=none; b=hCUidiUvrV7YnmTzSl53hL+6yuPA2rO7aCoLpol24Vf9MgtW6dkqNsT1Hzv6Faekq1ShSC2MlAngbrK9cRji+DJy/lqVBwuDKr6xrMj9fDF6p9qXhV1BlppKty0J0RMKBU2myIh1IJfXqSHb/FwWrWGbFEHM1CuK1Vxg3fAu/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696334; c=relaxed/simple;
	bh=IhELT+Yuy76/7x1ahQ7ceXzvqtZQsS7X5OCIgoPSDFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL/F+I7afACt5x6+nS8hjdTdb6QxcD0yOFxANU3Hs+nflXn++iy0EU0orfJAQLQJ3ifBz9MLZUDEttv/WY9AQrXOqR1o0Eg8ZGT+D3kUhXVGo30Gu3stqzxKF/OLHHjooa0T/4zJ4ALE9JFIkXhMB5rDkdJd6idYx5eIbM6s5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TApJNUN3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TApJNUN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42A7C2BCB7;
	Wed, 13 May 2026 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696333;
	bh=IhELT+Yuy76/7x1ahQ7ceXzvqtZQsS7X5OCIgoPSDFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TApJNUN3/EYWX95QeYagdzEhTGiZvf+CcdMzD+RchxXocEOg4owsH0ubhKfmeeMfO
	 1y4b0aq/DVKc8eyQ6MG3qJJu/NHTyuLUJE9h1EVXUocvTHMFMr+3o8frIrd6ktnzow
	 KygtDlY7zeaWvAIowhpwyaqYO8R19mbFxsQcaZiWjTVgLTbcJZSjo+3f9S+7tiYxrC
	 jvd2lH080X14YknMJzuvj3PvbwUVzVGtLHIrhWfU+YJJ5t7n6E7JTJaybMbFuymI4O
	 wy7dxaRjfwlx7jEJexH4VrGLxZl+N/6Eu+qO2kR2Hai26IbAeJbh+GfqYkAqvxx6KO
	 EBxYEBAwhKf8A==
Date: Wed, 13 May 2026 11:18:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 11/33] fuse: isolate the other regular file IO paths from
 iomap
Message-ID: <20260513181853.GJ9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205386.4101881.2569175274476427605.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205386.4101881.2569175274476427605.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:26:33AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> iomap completely takes over all regular file IO, so we don't need to
> access any of the other mechanisms at all.  Gate them off so that we can
> eventually overlay them with a union to save space in struct fuse_inode.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/dir.c    |   14 +++++++++-----
>  fs/fuse/file.c   |   18 +++++++++++++-----
>  fs/fuse/inode.c  |    3 ++-
>  fs/fuse/iomode.c |    3 ++-
>  4 files changed, 26 insertions(+), 12 deletions(-)
> 
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 996d81f263d637..1bb0302f7ce8bb 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2200,6 +2200,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	FUSE_ARGS(args);
>  	struct fuse_setattr_in inarg;
>  	struct fuse_attr_out outarg;
> +	const bool is_iomap = fuse_inode_has_iomap(inode);
>  	bool is_truncate = false;
>  	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
>  	loff_t oldsize;
> @@ -2257,12 +2258,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		if (err)
>  			return err;
>  
> -		fuse_set_nowrite(inode);
> -		fuse_release_nowrite(inode);
> +		if (!is_iomap) {
> +			fuse_set_nowrite(inode);
> +			fuse_release_nowrite(inode);
> +		}
>  	}
>  
>  	if (is_truncate) {
> -		fuse_set_nowrite(inode);
> +		if (!is_iomap)
> +			fuse_set_nowrite(inode);
>  		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
>  		if (trust_local_cmtime && attr->ia_size != inode->i_size)
>  			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
> @@ -2334,7 +2338,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!is_wb || is_truncate)
>  		i_size_write(inode, outarg.attr.size);
>  
> -	if (is_truncate) {
> +	if (is_truncate && !is_iomap) {
>  		/* NOTE: this may release/reacquire fi->lock */
>  		__fuse_release_nowrite(inode);
>  	}
> @@ -2358,7 +2362,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return 0;
>  
>  error:
> -	if (is_truncate)
> +	if (is_truncate && !is_iomap)
>  		fuse_release_nowrite(inode);
>  
>  	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8d55d2f4dd4cc9..2a807c49792d53 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -257,6 +257,7 @@ static int fuse_open(struct inode *inode, struct file *file)
>  	struct fuse_conn *fc = fm->fc;
>  	struct fuse_file *ff;
>  	int err;
> +	const bool is_iomap = fuse_inode_has_iomap(inode);
>  	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
>  	bool is_wb_truncate = is_truncate && fc->writeback_cache;
>  	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
> @@ -278,7 +279,7 @@ static int fuse_open(struct inode *inode, struct file *file)
>  			goto out_inode_unlock;
>  	}
>  
> -	if (is_wb_truncate || dax_truncate)
> +	if ((is_wb_truncate || dax_truncate) && !is_iomap)
>  		fuse_set_nowrite(inode);
>  
>  	err = fuse_do_open(fm, get_node_id(inode), file, false);
> @@ -291,7 +292,7 @@ static int fuse_open(struct inode *inode, struct file *file)
>  			fuse_truncate_update_attr(inode, file);
>  	}
>  
> -	if (is_wb_truncate || dax_truncate)
> +	if ((is_wb_truncate || dax_truncate) && !is_iomap)
>  		fuse_release_nowrite(inode);
>  	if (!err) {
>  		if (is_truncate)
> @@ -539,12 +540,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
>  {
>  	struct inode *inode = file->f_mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	const bool need_sync_writes = !fuse_inode_has_iomap(inode);
>  	int err;
>  
>  	if (fuse_is_bad(inode))
>  		return -EIO;
>  
> -	inode_lock(inode);
> +	if (need_sync_writes)
> +		inode_lock(inode);
>  
>  	/*
>  	 * Start writeback against all dirty pages of the inode, then
> @@ -555,7 +558,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
>  	if (err)
>  		goto out;
>  
> -	fuse_sync_writes(inode);
> +	if (need_sync_writes)
> +		fuse_sync_writes(inode);
>  
>  	/*
>  	 * Due to implementation of fuse writeback
> @@ -579,7 +583,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
>  		err = 0;
>  	}
>  out:
> -	inode_unlock(inode);
> +	if (need_sync_writes)
> +		inode_unlock(inode);
>  
>  	return err;
>  }
> @@ -2015,6 +2020,9 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
>  {
>  	struct fuse_file *ff;
>  
> +	if (fuse_inode_has_iomap(&fi->inode))
> +		return NULL;

Codex observed that fuse_finish_open and fuse_file_mmap can still add
the file pointing to an iomap inode to the inode's write_files list if
writeback_cache is enabled.  Since we don't use /any/ of that
infrastructure, fuse_link_write_file should refrain from doing the
list_add.

That's a good catch, I didn't find that loose end when I went through
and tried to find them all.

--D

> +
>  	spin_lock(&fi->lock);
>  	ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
>  				      write_entry);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f8e5c03580e56b..3cb2ef161ef7c5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -192,7 +192,8 @@ static void fuse_evict_inode(struct inode *inode)
>  		if (inode->i_nlink > 0)
>  			atomic64_inc(&fc->evict_ctr);
>  	}
> -	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
> +	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode) &&
> +	    !fuse_inode_has_iomap(inode)) {
>  		WARN_ON(fi->iocachectr != 0);
>  		WARN_ON(!list_empty(&fi->write_files));
>  		WARN_ON(!list_empty(&fi->queued_writes));
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 3728933188f307..9be9ae3520003e 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include "fuse_i.h"
> +#include "fuse_iomap.h"
>  
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
> @@ -203,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
>  	 * io modes are not relevant with DAX and with server that does not
>  	 * implement open.
>  	 */
> -	if (FUSE_IS_DAX(inode) || !ff->args)
> +	if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
>  		return 0;
>  
>  	/*
> 
> 
