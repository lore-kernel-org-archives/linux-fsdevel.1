Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E399388396;
	Wed, 13 May 2026 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706316; cv=none; b=PwqgzwBgrE9oxbeCSmjZDnjRHAf56cWlR35G5dMm47KVLB4zgBeNbnv42aAi0O8qXmWRrmhKyASrkQ1nQ3FSbrB9p0D21csdXV942RgLl/3jjzQ6qEcwXXSGD/lkr9WaKCGfnu6l+LvehQ9H59SU+QCLiwrAEA3XGJuuj4h0xKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706316; c=relaxed/simple;
	bh=230EEzZ3+/tZF0zfb0WI6qGFlsRjBm2hSN/0sByav0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO5D9uix1xLZ4wkHJOhhIXOoPCqws3EsyF9m8QwbEZot7PqCJi0BIdigHA5L1Z3OhMyn3iEoy+wHEnny/0pd+gVjWPfQJk3v4H/ovNu1XSSyjCi73uBtKZgDvoywVAl36KMlNEuEuAPN0d3oE9HnrcMjBRa84wt4GYiyIyG3nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD+Qqvhg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD+Qqvhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321DBC19425;
	Wed, 13 May 2026 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778706316;
	bh=230EEzZ3+/tZF0zfb0WI6qGFlsRjBm2hSN/0sByav0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VD+QqvhgcYeGkPcz5h0O848Ycm3dTgUgKdKJ6AF62kHqCL/ZXeI3c1ocie8fnwLaB
	 Ym0HAhbE2no/u9G4b3fq52/1G7HtzDyAXvW3AcBXxuhHBqvzSvOThGk+dXy7uyUw8R
	 /fMmE5SgzjJfa7ghwZWcZakbjZaoKE0w8zwHjjtL8PREmJe0rqpzT/BFFOQA9vpLlh
	 sLsQOHytTT2Iw2Dr1HKbZ0J0Ky/xR9PW7KhVnM1jTBbMu4nP/ocAN8KrOtIj8Umleq
	 bQGf1Fpdg4R5+4TDJJV138eUf7ivOHrNF5NSzanlgJo4wFMagAyBM2rPHm/DYcr5+q
	 q/bxpTAO6Dp3w==
Date: Wed, 13 May 2026 14:05:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 21/33] fuse: query filesystem geometry when using iomap
Message-ID: <20260513210515.GR9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205600.4101881.17560882069181560838.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205600.4101881.17560882069181560838.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:29:09AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new upcall to the fuse server so that the kernel can request
> filesystem geometry bits when iomap mode is in use.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |    4 +
>  fs/fuse/fuse_iomap.h      |    6 +-
>  include/uapi/linux/fuse.h |   39 ++++++++++++
>  fs/fuse/fuse_iomap.c      |  147 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/inode.c           |   42 ++++++++++---
>  5 files changed, 227 insertions(+), 11 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 23212ca1b6871e..0d9ac3ff18eedf 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1036,6 +1036,9 @@ struct fuse_conn {
>  	struct fuse_ring *ring;
>  #endif
>  
> +	/** How many subsystems still need initialization? */
> +	atomic_t need_init;
> +
>  	/** Only used if the connection opts into request timeouts */
>  	struct {
>  		/* Worker for checking if any requests have timed out */
> @@ -1447,6 +1450,7 @@ struct fuse_dev *fuse_dev_alloc(void);
>  void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
>  void fuse_dev_put(struct fuse_dev *fud);
>  int fuse_send_init(struct fuse_mount *fm);
> +void fuse_finish_init(struct fuse_conn *fc, bool ok);
>  
>  /**
>   * Fill in superblock and initialize fuse connection
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index 9b17f4414dcca4..13b5c5c896f25a 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -21,7 +21,8 @@ static inline bool fuse_has_iomap(const struct inode *inode)
>  
>  extern const struct fuse_backing_ops fuse_iomap_backing_ops;
>  
> -void fuse_iomap_mount(struct fuse_mount *fm);
> +int fuse_iomap_mount(struct fuse_mount *fm);
> +void fuse_iomap_mount_async(struct fuse_mount *fm);
>  void fuse_iomap_unmount(struct fuse_mount *fm);
>  
>  void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr);
> @@ -67,7 +68,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
>  #else
>  # define fuse_iomap_enabled(...)		(false)
>  # define fuse_has_iomap(...)			(false)
> -# define fuse_iomap_mount(...)			((void)0)
> +# define fuse_iomap_mount(...)			(0)
> +# define fuse_iomap_mount_async(...)		((void)0)
>  # define fuse_iomap_unmount(...)		((void)0)
>  # define fuse_iomap_init_inode(...)		((void)0)
>  # define fuse_iomap_evict_inode(...)		((void)0)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index de9b56e6e8d250..33668d66e9c4b4 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -246,6 +246,7 @@
>   *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
>   *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
>   *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
> + *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -677,6 +678,7 @@ enum fuse_opcode {
>  	FUSE_STATX		= 52,
>  	FUSE_COPY_FILE_RANGE_64	= 53,
>  
> +	FUSE_IOMAP_CONFIG	= 4092,
>  	FUSE_IOMAP_IOEND	= 4093,
>  	FUSE_IOMAP_BEGIN	= 4094,
>  	FUSE_IOMAP_END		= 4095,
> @@ -1452,4 +1454,41 @@ struct fuse_iomap_ioend_out {
>  	uint64_t newsize;	/* new ondisk size */
>  };
>  
> +struct fuse_iomap_config_in {
> +	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
> +	int64_t maxbytes;	/* maximum supported file size */
> +	uint64_t padding[6];	/* zero */
> +};
> +
> +/* Which fields are set in fuse_iomap_config_out? */
> +#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
> +#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
> +#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
> +#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
> +#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
> +#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
> +
> +struct fuse_iomap_config_out {
> +	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
> +
> +	char s_id[32];		/* Informational name */
> +	char s_uuid[16];	/* UUID */
> +
> +	uint8_t s_uuid_len;	/* length of s_uuid */
> +
> +	uint8_t s_pad[3];	/* must be zeroes */
> +
> +	uint32_t s_blocksize;	/* fs block size */
> +	uint32_t s_max_links;	/* max hard links */
> +
> +	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
> +	uint32_t s_time_gran;
> +
> +	/* Time limits for c/m/atime in seconds */
> +	int64_t s_time_min;
> +	int64_t s_time_max;
> +
> +	int64_t s_maxbytes;	/* max file size */
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index f57e0317f7324e..cd74497ceb3f42 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -715,14 +715,103 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
>  	.post_open = fuse_iomap_post_open,
>  };
>  
> -void fuse_iomap_mount(struct fuse_mount *fm)
> +struct fuse_iomap_config_args {
> +	struct fuse_args args;
> +	struct fuse_iomap_config_in inarg;
> +	struct fuse_iomap_config_out outarg;
> +};
> +
> +#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_SID | \
> +			       FUSE_IOMAP_CONFIG_UUID | \
> +			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
> +			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
> +			       FUSE_IOMAP_CONFIG_TIME | \
> +			       FUSE_IOMAP_CONFIG_MAXBYTES)
> +
> +static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
> +				     const struct fuse_iomap_config_out *outarg)
>  {
> +	struct super_block *sb = fm->sb;
> +
> +	switch (error) {
> +	case 0:
> +		break;
> +	case -ENOSYS:
> +		return 0;
> +	default:
> +		return error;
> +	}
> +
> +	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
> +		return -EINVAL;
> +
> +	if (outarg->s_uuid_len > sizeof(outarg->s_uuid))
> +		return -EINVAL;
> +
> +	if (memchr_inv(outarg->s_pad, 0, sizeof(outarg->s_pad)))
> +		return -EINVAL;
> +
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE) {
> +		if (sb->s_bdev) {
> +#ifdef CONFIG_BLOCK
> +			if (!sb_set_blocksize(sb, outarg->s_blocksize))
> +				return -EINVAL;
> +#else
> +			/*
> +			 * XXX: how do we have a bdev filesystem without
> +			 * CONFIG_BLOCK???
> +			 */

I spent a while trying to figure out how this could actually happen.
After poking through a lot of macros and whatnot, I don't think it's
possible.  But we should have something here to catch this weird
situation:

	/*
	 * It's not possible to have a bdev filesystem without
	 * CONFIG_BLOCK, but we'll prevent this weird situation
	 * anyway.
	 */
	return -EINVAL;


> +			return -EINVAL;
> +#endif
> +		} else {
> +			sb->s_blocksize = outarg->s_blocksize;

Then I noticed that we need to validate that the block size is a power
of two and not egregiously large; blk_validate_block_size will probably
suffice for this purpose.

> +			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
> +		}
> +	}
> +
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_SID)
> +		memcpy(sb->s_id, outarg->s_id, sizeof(sb->s_id));

Codex pointed out that s_id is used as a zero-terminated string in
various places, so we need to avoid buffer overflows by ensuring that
the last byte is zero.

> +
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_UUID) {
> +		memcpy(&sb->s_uuid, outarg->s_uuid, outarg->s_uuid_len);
> +		sb->s_uuid_len = outarg->s_uuid_len;
> +	}
> +
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
> +		sb->s_max_links = outarg->s_max_links;
> +
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_TIME) {
> +		sb->s_time_gran = outarg->s_time_gran;

Codex also noted that we should constrain s_time_gran to be between 1ns
and 1s.

--D

> +		sb->s_time_min = outarg->s_time_min;
> +		sb->s_time_max = outarg->s_time_max;
> +	}
> +
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
> +		sb->s_maxbytes = outarg->s_maxbytes;
> +
> +	return 0;
> +}
> +
> +static void fuse_iomap_config_reply(struct fuse_mount *fm,
> +				    struct fuse_args *args, int error)
> +{
> +	struct fuse_iomap_config_args *ia =
> +		container_of(args, struct fuse_iomap_config_args, args);
>  	struct fuse_conn *fc = fm->fc;
>  	struct super_block *sb = fm->sb;
>  	struct backing_dev_info *old_bdi = sb->s_bdi;
>  	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
> +	bool ok = true;
>  	int res;
>  
> +	res = fuse_iomap_process_config(fm, error, &ia->outarg);
> +	if (res) {
> +		printk(KERN_ERR "%s: could not configure iomap, err=%d",
> +		       sb->s_id, res);
> +		ok = false;
> +		goto done;
> +	}
> +
>  	/*
>  	 * sb->s_bdi points to the initial private bdi.  However, we want to
>  	 * redirect it to a new private bdi with default dirty and readahead
> @@ -746,6 +835,62 @@ void fuse_iomap_mount(struct fuse_mount *fm)
>  	 * freeze/thaw properly.
>  	 */
>  	fc->sync_fs = true;
> +
> +done:
> +	kfree(ia);
> +	fuse_finish_init(fc, ok);
> +}
> +
> +static struct fuse_iomap_config_args *
> +fuse_iomap_new_mount(struct fuse_mount *fm)
> +{
> +	struct fuse_iomap_config_args *ia;
> +
> +	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
> +	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
> +	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
> +
> +	ia->args.opcode = FUSE_IOMAP_CONFIG;
> +	ia->args.nodeid = 0;
> +	ia->args.in_numargs = 1;
> +	ia->args.in_args[0].size = sizeof(ia->inarg);
> +	ia->args.in_args[0].value = &ia->inarg;
> +	ia->args.out_argvar = true;
> +	ia->args.out_numargs = 1;
> +	ia->args.out_args[0].size = sizeof(ia->outarg);
> +	ia->args.out_args[0].value = &ia->outarg;
> +	ia->args.force = true;
> +	ia->args.nocreds = true;
> +
> +	return ia;
> +}
> +
> +int fuse_iomap_mount(struct fuse_mount *fm)
> +{
> +	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
> +	int err;
> +
> +	ASSERT(fm->fc->sync_init);
> +
> +	err = fuse_simple_request(fm, &ia->args);
> +	/* Ignore size of iomap_config reply */
> +	if (err > 0)
> +		err = 0;
> +	fuse_iomap_config_reply(fm, &ia->args, err);
> +	return err;
> +}
> +
> +void fuse_iomap_mount_async(struct fuse_mount *fm)
> +{
> +	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
> +	int err;
> +
> +	ASSERT(!fm->fc->sync_init);
> +
> +	ia->args.end = fuse_iomap_config_reply;
> +	err = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
> +	if (err)
> +		fuse_iomap_config_reply(fm, &ia->args, -ENOTCONN);
>  }
>  
>  void fuse_iomap_unmount(struct fuse_mount *fm)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 23ca401a3e08e6..f6ec67a8eb86a2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1383,6 +1383,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  	struct fuse_init_out *arg = &ia->out;
>  	bool ok = true;
>  
> +	atomic_inc(&fc->need_init);
> +
>  	if (error || arg->major != FUSE_KERNEL_VERSION)
>  		ok = false;
>  	else {
> @@ -1529,9 +1531,6 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  
>  		init_server_timeout(fc, timeout);
>  
> -		if (fc->iomap)
> -			fuse_iomap_mount(fm);
> -
>  		fm->sb->s_bdi->ra_pages =
>  				min(fm->sb->s_bdi->ra_pages, ra_pages);
>  		fc->minor = arg->minor;
> @@ -1541,13 +1540,27 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  	}
>  	kfree(ia);
>  
> -	if (!ok) {
> +	if (!ok)
>  		fc->conn_init = 0;
> +
> +	if (ok && fc->iomap) {
> +		atomic_inc(&fc->need_init);
> +		if (!fc->sync_init)
> +			fuse_iomap_mount_async(fm);
> +	}
> +
> +	fuse_finish_init(fc, ok);
> +}
> +
> +void fuse_finish_init(struct fuse_conn *fc, bool ok)
> +{
> +	if (!ok)
>  		fc->conn_error = 1;
> -	}
>  
> -	fuse_set_initialized(fc);
> -	wake_up_all(&fc->blocked_waitq);
> +	if (atomic_dec_and_test(&fc->need_init)) {
> +		fuse_set_initialized(fc);
> +		wake_up_all(&fc->blocked_waitq);
> +	}
>  }
>  
>  static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
> @@ -2028,7 +2041,20 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
>  
>  	fm = get_fuse_mount_super(sb);
>  
> -	return fuse_send_init(fm);
> +	err = fuse_send_init(fm);
> +	if (err)
> +		return err;
> +
> +	if (fm->fc->conn_init && fm->fc->sync_init && fm->fc->iomap) {
> +		err = fuse_iomap_mount(fm);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (fm->fc->conn_error)
> +		return -EIO;
> +
> +	return 0;
>  }
>  
>  /*
> 
> 
