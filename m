Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5F3A7593;
	Thu, 14 May 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796880; cv=none; b=HBCF1eIwqbq1XWIjlDsXKE6Sud+7feqEyHZ1XaEE4LJkMFq2n6Hx/7GoX8pEYPV+AwdRfI0x8+YnTlOLGfrRhmDT67ziaF45ZmQZhEYfkRQCQatFFheNf9n8XP8RQT/EhEAJoVodi7sEvgsAUwHSOJPa+70ou5fpQYrnMuwy3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796880; c=relaxed/simple;
	bh=AdFfM6B22fX6EjJtb1Gjbcrh9HyaZcjd70Tt6NhxZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7ue3tRBB5p0v5C5BatzVrhZAe8ue28n6hCG3mSj0ws6/wUYUQXSGKnUxx/+38ziSdPoiOmHF7K4LpfYtT7mIF7eCK8UamgHK5qiA4Vr2HL/pTS1ypDkJDRyzqVn//WO74ENaWmCz07oAFht8rV8vI7LB6itHchGQ4qmTC1m48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVVmr5oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVVmr5oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD4EC2BCC6;
	Thu, 14 May 2026 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796880;
	bh=AdFfM6B22fX6EjJtb1Gjbcrh9HyaZcjd70Tt6NhxZ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVVmr5oIcD5/nHKelBoRrdqSd8pRbyRx9p4MVvYDs7qF2PCsIWclJx1ZT7lkIvvD5
	 /Ashl/U7Hy9qhh5QQblhFJfhgRnSpu5/TI89ksMal7WMIwxwd46egMzeIw1lsBLEPr
	 4wvMW0GwZURWtT/+BejVJlRVqUi3RPJulHFcwx48nxNWXNw65RlY5nz76EuVUqHPf8
	 OfUVhQfe3LRa7597E6fNhEC/PbFuv/Os4KyiBQavaW7Qeak5XA03EIy7YudyQcJRXL
	 AMdFQ1HwbTVfP1yEjKnuJA93Q5GKTYrSee+RNswm73lgAitMKiXZiCnKu/BjhtpdKR
	 5LyQtc7WeBTww==
Date: Thu, 14 May 2026 15:14:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
Message-ID: <20260514221439.GJ9544@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206552.4103309.6736684975553576273.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206552.4103309.6736684975553576273.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:33:51AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> There are three inode flags (immutable, append, sync) that are enforced
> by the VFS.  Whenever we go around setting iflags, let's update the VFS
> state so that they actually work.  Make it so that the fuse server can
> set these three inode flags at load time and have the kernel advertise
> and enforce them.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |    1 +
>  include/uapi/linux/fuse.h |    8 +++++++
>  fs/fuse/dir.c             |    1 +
>  fs/fuse/inode.c           |    1 +
>  fs/fuse/ioctl.c           |   50 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 61 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 95b37f4660cc1d..3b38b98dc0096c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1651,6 +1651,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
>  int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
>  int fuse_fileattr_set(struct mnt_idmap *idmap,
>  		      struct dentry *dentry, struct file_kattr *fa);
> +void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
>  
>  /* iomode.c */
>  int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index b6fa828776b82f..bf8514a5ee27af 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -249,6 +249,8 @@
>   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
>   *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
>   *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
> + *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
> + *    attributes
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -606,12 +608,18 @@ struct fuse_file_lock {
>   * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
>   * FUSE_ATTR_IOMAP: Use iomap for this inode
>   * FUSE_ATTR_ATOMIC: Enable untorn writes
> + * FUSE_ATTR_SYNC: File writes are synchronous
> + * FUSE_ATTR_IMMUTABLE: File is immutable
> + * FUSE_ATTR_APPEND: File is append-only
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
>  #define FUSE_ATTR_DAX		(1 << 1)
>  #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
>  #define FUSE_ATTR_IOMAP		(1 << 3)
>  #define FUSE_ATTR_ATOMIC	(1 << 4)
> +#define FUSE_ATTR_SYNC		(1 << 5)
> +#define FUSE_ATTR_IMMUTABLE	(1 << 6)
> +#define FUSE_ATTR_APPEND	(1 << 7)
>  
>  /**
>   * Open flags
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 11898102adefe2..53fda7f63b11c8 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1450,6 +1450,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
>  		blkbits = inode->i_sb->s_blocksize_bits;
>  
>  	stat->blksize = 1 << blkbits;
> +	generic_fill_statx_attr(inode, stat);

Codex complains that I don't call generic_fill_statx_attr to fill in the
statx iflags from the VFS state inodes in fuse_update_get_attr if the
caller passes in a kstat object and we don't have to reload the
attributes from the server.  That might explain the sporadic stale flag
state when I run some stress tests on fileattr_set.

>  }
>  
>  static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2513ea108ff9a8..aa9f880b9a2ea6 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -544,6 +544,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>  			inode->i_flags |= S_NOCMTIME;
>  		inode->i_generation = generation;
>  		fuse_init_inode(inode, attr, fc);
> +		fuse_fileattr_init(inode, attr);
>  	} else if (fuse_stale_inode(inode, generation, attr)) {
>  		/* nodeid was reused, any I/O on the old inode should fail */
>  		fuse_make_bad(inode);
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 07529db21fb781..bd2caf191ce2e0 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -502,6 +502,53 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
>  	fuse_file_release(inode, ff, O_RDONLY, NULL, S_ISDIR(inode->i_mode));
>  }
>  
> +static inline void update_iflag(struct inode *inode, unsigned int iflag,
> +				bool set)
> +{
> +	if (set)
> +		inode->i_flags |= iflag;
> +	else
> +		inode->i_flags &= ~iflag;
> +}
> +
> +static void fuse_fileattr_update_inode(struct inode *inode,
> +				       const struct file_kattr *fa)
> +{
> +	unsigned int old_iflags = inode->i_flags;
> +
> +	if (!fuse_inode_is_exclusive(inode))
> +		return;
> +
> +	if (fa->flags_valid) {
> +		update_iflag(inode, S_SYNC, fa->flags & FS_SYNC_FL);
> +		update_iflag(inode, S_IMMUTABLE, fa->flags & FS_IMMUTABLE_FL);
> +		update_iflag(inode, S_APPEND, fa->flags & FS_APPEND_FL);
> +	} else if (fa->fsx_valid) {
> +		update_iflag(inode, S_SYNC, fa->fsx_xflags & FS_XFLAG_SYNC);
> +		update_iflag(inode, S_IMMUTABLE,
> +					fa->fsx_xflags & FS_XFLAG_IMMUTABLE);
> +		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
> +	}
> +
> +	if (old_iflags != inode->i_flags)
> +		fuse_invalidate_attr(inode);
> +}
> +
> +void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)

It also thinks that I should be calling this in
fuse_change_attributes_common if we're passed the root directory,
because the fuse server might think that IMMUTABLE applies to the
rootdir, but it won't get set (in the vfs) because we instantiate it
prior to FUSE_INIT and only call LOOKUP on it later.  I'd noticed
sporadic problems with immutable not being enforced on the rootdir; I
hope this is the esoteric reason why.

--D

> +{
> +	if (!fuse_inode_is_exclusive(inode))
> +		return;
> +
> +	if (attr->flags & FUSE_ATTR_SYNC)
> +		inode->i_flags |= S_SYNC;
> +
> +	if (attr->flags & FUSE_ATTR_IMMUTABLE)
> +		inode->i_flags |= S_IMMUTABLE;
> +
> +	if (attr->flags & FUSE_ATTR_APPEND)
> +		inode->i_flags |= S_APPEND;
> +}
> +
>  int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  {
>  	struct inode *inode = d_inode(dentry);
> @@ -572,7 +619,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
>  
>  		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
>  				      &xfa, sizeof(xfa));
> +		if (err)
> +			goto cleanup;
>  	}
> +	fuse_fileattr_update_inode(inode, fa);
>  
>  cleanup:
>  	fuse_priv_ioctl_cleanup(inode, ff);
> 
> 
