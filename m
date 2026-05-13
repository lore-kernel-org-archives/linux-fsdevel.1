Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779F378D9B;
	Wed, 13 May 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710409; cv=none; b=MSmkE7mWjB6ZcSGppGkkOVVfOZ0GTF4T+CV2sXUGWs3AlphqmLdBGQvkuPHSVkoVswZcBs7LoZ2ouXaghLdP5nh2BebRyCL/IwyqQ6QLFawXHkz/kcDgYePSYkez0kaeAxmDeJaqXg4pnB8xFxW1UESVxoeQxehrHUKQmO3ip3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710409; c=relaxed/simple;
	bh=B5p+wUe5+MEqY5YvsSn+LwFSxycKyJf4LwHIf/z2Z+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw4j7MwbVCpEgQO44+FwHnB7ByjK1ijjI0maoiC2fDYmcMbHZX+kHzaH+9u26+81yO9v0IcSBJUtOo4Zum+3Z8UUak7yVJli3+Cgpxbsb8ryIzEfHH9ZvNm0M5CWz9/5TvN5iLoYMldG2iWAjpnAlDITRwTtdeLSdlT2IBtIkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ0BMxe3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ0BMxe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E19C19425;
	Wed, 13 May 2026 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778710409;
	bh=B5p+wUe5+MEqY5YvsSn+LwFSxycKyJf4LwHIf/z2Z+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQ0BMxe367NmViob4SOfl0wkI5vbFcSI8KnqFt/nKHkiC/1G+9Vt7TD6cdpHWtxc1
	 o4b5EIiLGWh21v7BfgTMBueJNkcWKg/mQYHDyJb6PPK8bVlfNNpIMrMprrNRzFmCFi
	 7LeOBi8X039OsJScRKAcT8v4Bbt8fUXbgw26E7Nd0l8NG/WgLU7XCZo+sT0cRarSh/
	 0fZxPVxaOdkE3yxm6nkLZGCSRv7x3DeaWnNhEUPQ0tErn8n0xDmJ98AXXejBl8hove
	 ki9tNV6Cj+QKigMMipCtwvJJwmSIMNoHsU4up1cSkg5NBu1IPL1q4NbNXcvqTUdeF1
	 qR6qKzw+4lpKQ==
Date: Wed, 13 May 2026 15:13:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 24/33] fuse: invalidate ranges of block devices being
 used for iomap
Message-ID: <20260513221328.GV9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205664.4101881.1577494548948279604.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205664.4101881.1577494548948279604.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:29:56AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make it easier to invalidate the page cache for a block device that is
> being used in conjunction with iomap.  This allows a fuse server to kill
> all cached data for a block that is being freed, so that block reuse
> doesn't result in file corruption.  Right now, the only way to do this
> is with fadvise, which ignores and doesn't wait for pages undergoing
> writeback.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.h      |    3 +++
>  include/uapi/linux/fuse.h |   16 ++++++++++++++++
>  fs/fuse/dev.c             |   27 +++++++++++++++++++++++++++
>  fs/fuse/fuse_iomap.c      |   41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index 17d0507a243b59..31d6f7b392771c 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -65,6 +65,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
>  
>  int fuse_dev_ioctl_iomap_support(struct file *file,
>  				 struct fuse_iomap_support __user *argp);
> +int fuse_iomap_dev_inval(struct fuse_conn *fc,
> +			 const struct fuse_iomap_dev_inval_out *arg);
>  
>  int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
>  #else
> @@ -92,6 +94,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
>  # define fuse_iomap_fallocate(...)		(-ENOSYS)
>  # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
>  # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
> +# define fuse_iomap_dev_inval(...)		(-ENOSYS)
>  # define fuse_iomap_fadvise			NULL
>  #endif /* CONFIG_FUSE_IOMAP */
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 33668d66e9c4b4..1ef7152306a24f 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -247,6 +247,7 @@
>   *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
>   *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
>   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
> + *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -701,6 +702,8 @@ enum fuse_notify_code {
>  	FUSE_NOTIFY_RESEND = 7,
>  	FUSE_NOTIFY_INC_EPOCH = 8,
>  	FUSE_NOTIFY_PRUNE = 9,
> +	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
> +	FUSE_NOTIFY_CODE_MAX,
>  };
>  
>  /* The read buffer is required to be at least 8k, but may be much larger */
> @@ -1491,4 +1494,17 @@ struct fuse_iomap_config_out {
>  	int64_t s_maxbytes;	/* max file size */
>  };
>  
> +struct fuse_range {
> +	uint64_t offset;
> +	uint64_t length;
> +};
> +
> +struct fuse_iomap_dev_inval_out {
> +	uint32_t dev;		/* device cookie */
> +	uint32_t reserved;	/* zero */
> +
> +	/* range of bdev pagecache to invalidate, in bytes */
> +	struct fuse_range range;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 75e1e3f8a4ddd1..9918911fe44855 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1848,6 +1848,30 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	return err;
>  }
>  
> +static int fuse_notify_iomap_dev_inval(struct fuse_conn *fc, unsigned int size,
> +				       struct fuse_copy_state *cs)
> +{
> +	struct fuse_iomap_dev_inval_out outarg;
> +	int err = -EINVAL;
> +
> +	if (size != sizeof(outarg))
> +		goto err;
> +
> +	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
> +	if (err)
> +		goto err;
> +	if (outarg.reserved) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +	fuse_copy_finish(cs);
> +
> +	return fuse_iomap_dev_inval(fc, &outarg);
> +err:
> +	fuse_copy_finish(cs);
> +	return err;
> +}
> +
>  struct fuse_retrieve_args {
>  	struct fuse_args_pages ap;
>  	struct fuse_notify_retrieve_in inarg;
> @@ -2138,6 +2162,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
>  	case FUSE_NOTIFY_PRUNE:
>  		return fuse_notify_prune(fc, size, cs);
>  
> +	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
> +		return fuse_notify_iomap_dev_inval(fc, size, cs);
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index ad7c526545776e..fe937529543b0c 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -2002,3 +2002,44 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
>  		inode_unlock_shared(inode);
>  	return ret;
>  }
> +
> +int fuse_iomap_dev_inval(struct fuse_conn *fc,
> +			 const struct fuse_iomap_dev_inval_out *arg)
> +{
> +	struct fuse_backing *fb;
> +	struct block_device *bdev;
> +	loff_t end;
> +	int ret = 0;
> +
> +	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
> +		return -EINVAL;
> +
> +	down_read(&fc->killsb);
> +	fb = fuse_backing_lookup(fc, &fuse_iomap_backing_ops, arg->dev);
> +	if (!fb) {
> +		ret = -ENODEV;
> +		goto out_killsb;
> +	}
> +	bdev = fb->bdev;
> +
> +	inode_lock(bdev->bd_mapping->host);
> +	filemap_invalidate_lock(bdev->bd_mapping);
> +
> +	if (check_add_overflow(arg->range.offset, arg->range.length, &end) ||

Codex complains here about weird behavior when length==0 -- if offset is
also 0, then it'll truncate the entire bdev pagecache.  If it's nonzero,
then it does nothing.

I think I'll just have it return 0 without doing any work in the
length==0 case.


> +	    arg->range.offset >= bdev_nr_bytes(bdev)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	end = min(end, bdev_nr_bytes(bdev));
> +	truncate_inode_pages_range(bdev->bd_mapping, arg->range.offset,
> +				   end - 1);

It also complains that truncate_inode_pages_range doesn't actually
truncate the pagecache for page-unaligned regions at the start and end
of the range.  This ioctl is intended for fuse servers that use the bdev
pagecache for metadata IO that have freed a block and want to make sure
that the kernel won't surreptitiously issue a writeback to that block
after (say) it gets allocated to file data and iomap writes the block.

I'll leave a comment documenting that motivation.

--D

> +
> +out_unlock:
> +	filemap_invalidate_unlock(bdev->bd_mapping);
> +	inode_unlock(bdev->bd_mapping->host);
> +	fuse_backing_put(fb);
> +out_killsb:
> +	up_read(&fc->killsb);
> +	return ret;
> +}
> 
> 
