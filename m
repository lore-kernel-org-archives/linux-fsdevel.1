Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C433689D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439507; cv=none; b=qJYAmgiScIb0rQ/ttMmYYyR8iAzAT963GgTUGH8YeVgVryifeixgQpn/Foqe+xSOVU0KaZ69o3rdK7uYcggCEBbzNIkZ2Wmrma9ZCNzW0HlMOkU+/CB9A0Y5nLONfCErtyeQNETzWfM3QD8UkOttY3sOxnaLgmgKnZ9ZTOQVxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439507; c=relaxed/simple;
	bh=A2NBlD4hMpQ3Le+Nhl5Thftcfpz52hEoDWMVefwcZpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM3+QmMQNU6p+58Ac4+l/UxcD7Gfh5TAqsrK9tANH4PhwyIeY4TcOQHYgT5THdpeYmBhvp/8Oc9N1Af7vbqIDkIuBHOaauet/x+NMJXYLuaBYcJrykJMejaF7nOkjitb2JVs1y8UoV/EtwXqm9ooSy2CvQb7G73e7+5xyIogTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEXChH9Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEXChH9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3BEC19421;
	Fri, 13 Mar 2026 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439507;
	bh=A2NBlD4hMpQ3Le+Nhl5Thftcfpz52hEoDWMVefwcZpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEXChH9QN+UkFxhP9VAg+v7hE5o0zI/2K6L3DGetf+yAjINLkT2/s8ZU3Cxcgh1Ea
	 F35ieVR/O0jslZ0q6qCfDOZFZYuORuQa7lB0YYo/XJRNuu5m2NxSxi921WtO6Pf+i+
	 3Kysgdbeb4pJtIULMz6en5JCcT6rwOR80U/tukr9nDQaB8plizJc63GdVaAGU7sJXE
	 KFSfE4IST57TpYKSDWV1ecEJBeUj9E67nPvvVKoyy0UTYvH7csQjml+y4GZm2743qF
	 Fyqh82+aTvEICmlPthOY1mp+DqaQhS30SOfUhNvA2ELBSqZA4M+rLjjSTVHLRUVifQ
	 70jAa9ojiaPag==
Date: Fri, 13 Mar 2026 15:05:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead
 of mount
Message-ID: <20260313220506.GE1742010@frogsfrogsfrogs>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-2-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-2-mszeredi@redhat.com>

On Thu, Mar 12, 2026 at 08:39:59PM +0100, Miklos Szeredi wrote:
> Allocate struct fuse_dev when opening the device.  This means that unlike
> before, ->private_data is always set to a valid pointer.
> 
> The use of USE_DEV_SYNC_INIT magic pointer for the private_data is now
> replaced with a simple bool sync_init member.

Oh thank goodness, this became less clean in the iomap patchset when it
came to add pre-approval for iomap. :)

> If sync INIT is not set, I/O on the device returns error before mount.
> Keep this behavior by checking for the ->fc member.  If fud->fc is set, the
> mount has succeeded.  Testing this used READ_ONCE(file->private_data) and
> smp_mb() to try and provide the necessary semantics.  Switch this to
> smp_store_release() and smp_load_acquire().
> 
> Setting fud->fc is protected by fuse_mutex, this is unchanged.
> 
> Will need this later so the /dev/fuse open file reference is not held
> during FSCONFIG_CMD_CREATE.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c        | 47 +++++++++++++++++---------------------------
>  fs/fuse/fuse_dev_i.h | 33 +++++++++++++++++++++++--------
>  fs/fuse/fuse_i.h     |  5 ++---
>  fs/fuse/inode.c      | 35 +++++++++++----------------------
>  fs/fuse/virtio_fs.c  |  2 --
>  5 files changed, 56 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2c16b94357d5..4795e3d01b75 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1542,32 +1542,24 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  
>  static int fuse_dev_open(struct inode *inode, struct file *file)
>  {
> -	/*
> -	 * The fuse device's file's private_data is used to hold
> -	 * the fuse_conn(ection) when it is mounted, and is used to
> -	 * keep track of whether the file has been mounted already.
> -	 */
> -	file->private_data = NULL;
> +	struct fuse_dev *fud = fuse_dev_alloc();
> +
> +	if (!fud)
> +		return -ENOMEM;
> +
> +	file->private_data = fud;
>  	return 0;
>  }
>  
>  struct fuse_dev *fuse_get_dev(struct file *file)
>  {
> -	struct fuse_dev *fud = __fuse_get_dev(file);
> +	struct fuse_dev *fud = fuse_file_to_fud(file);
>  	int err;
>  
> -	if (likely(fud))
> -		return fud;
> -
> -	err = wait_event_interruptible(fuse_dev_waitq,
> -				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
> +	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud));

Nit: Would it be clearer that we're waiting on a condition if this were
phrased as:

	err = wait_event_interruptible(fuse_dev_waitq,
			fuse_dev_fc_get(fud) != NULL);

?

>  	if (err)
>  		return ERR_PTR(err);
>  
> -	fud = __fuse_get_dev(file);
> -	if (!fud)
> -		return ERR_PTR(-EPERM);
> -
>  	return fud;
>  }

<snip>

> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 134bf44aff0d..522b2012cd1f 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -39,18 +39,35 @@ struct fuse_copy_state {
>  	} ring;
>  };
>  
> -#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
> -#define FUSE_DEV_PTR_MASK (~1UL)
> +/*
> + * Lockless access is OK, because fud->fc is set once during mount and is valid
> + * until the file is released.
> + */
> +static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
> +{
> +	/* Pairs with smp_store_release() in fuse_dev_fc_set() */
> +	return smp_load_acquire(&fud->fc);
> +}
> +
> +static inline void fuse_dev_fc_set(struct fuse_dev *fud, struct fuse_conn *fc)
> +{
> +	/* Pairs with smp_load_acquire() in fuse_dev_fc_get() */
> +	smp_store_release(&fud->fc, fc);
> +}
> +
> +static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
> +{
> +	return file->private_data;
> +}

/me is no expert on load-acquire/store-release, but I think this works.
We can't reorder code below the store-release, which means that if
anyone calling _fc_get actually sees a non-null fuse_conn, then the fuse
connection is fully initialized and ready to go, right?

>  static inline struct fuse_dev *__fuse_get_dev(struct file *file)
>  {
> -	/*
> -	 * Lockless access is OK, because file->private data is set
> -	 * once during mount and is valid until the file is released.
> -	 */
> -	struct fuse_dev *fud = READ_ONCE(file->private_data);
> +	struct fuse_dev *fud = fuse_file_to_fud(file);
> +
> +	if (!fuse_dev_fc_get(fud))
> +		return NULL;
>  
> -	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
> +	return fud;
>  }
>  
>  struct fuse_dev *fuse_get_dev(struct file *file);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..739220d96b6f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -576,6 +576,8 @@ struct fuse_pqueue {
>   * Fuse device instance
>   */
>  struct fuse_dev {
> +	bool sync_init;

Does this need a kerneldoc comment, since the other fields have one?
Granted the only thing I can think of is

	/** Issue FUSE_INIT synchronously */


> +
>  	/** Fuse connection for this device */
>  	struct fuse_conn *fc;
>  
> @@ -622,9 +624,6 @@ struct fuse_fs_context {
>  
>  	/* DAX device, may be NULL */
>  	struct dax_device *dax_dev;
> -
> -	/* fuse_dev pointer to fill in, should contain NULL on entry */
> -	void **fudptr;

I'm glad the fudptr goes away!

If I got the smp_store_release part right then
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  };
>  
>  struct fuse_sync_bucket {
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be9..53663846db36 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1637,7 +1637,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc);
>  
>  void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
>  {
> -	fud->fc = fuse_conn_get(fc);
> +	fuse_dev_fc_set(fud, fuse_conn_get(fc));
>  	spin_lock(&fc->lock);
>  	list_add_tail(&fud->entry, &fc->devices);
>  	spin_unlock(&fc->lock);
> @@ -1659,7 +1659,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
>  
>  void fuse_dev_free(struct fuse_dev *fud)
>  {
> -	struct fuse_conn *fc = fud->fc;
> +	struct fuse_conn *fc = fuse_dev_fc_get(fud);
>  
>  	if (fc) {
>  		spin_lock(&fc->lock);
> @@ -1822,7 +1822,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
>  
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  {
> -	struct fuse_dev *fud = NULL;
> +	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
>  	struct fuse_mount *fm = get_fuse_mount_super(sb);
>  	struct fuse_conn *fc = fm->fc;
>  	struct inode *root;
> @@ -1856,18 +1856,11 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  			goto err;
>  	}
>  
> -	if (ctx->fudptr) {
> -		err = -ENOMEM;
> -		fud = fuse_dev_alloc_install(fc);
> -		if (!fud)
> -			goto err_free_dax;
> -	}
> -
>  	fc->dev = sb->s_dev;
>  	fm->sb = sb;
>  	err = fuse_bdi_init(fc, sb);
>  	if (err)
> -		goto err_dev_free;
> +		goto err_free_dax;
>  
>  	/* Handle umasking inside the fuse code */
>  	if (sb->s_flags & SB_POSIXACL)
> @@ -1889,15 +1882,15 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	set_default_d_op(sb, &fuse_dentry_operations);
>  	root_dentry = d_make_root(root);
>  	if (!root_dentry)
> -		goto err_dev_free;
> +		goto err_free_dax;
>  
>  	mutex_lock(&fuse_mutex);
>  	err = -EINVAL;
> -	if (ctx->fudptr && *ctx->fudptr) {
> -		if (*ctx->fudptr == FUSE_DEV_SYNC_INIT)
> -			fc->sync_init = 1;
> -		else
> +	if (fud) {
> +		if (fuse_dev_fc_get(fud))
>  			goto err_unlock;
> +		if (fud->sync_init)
> +			fc->sync_init = 1;
>  	}
>  
>  	err = fuse_ctl_add_conn(fc);
> @@ -1906,8 +1899,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  
>  	list_add_tail(&fc->entry, &fuse_conn_list);
>  	sb->s_root = root_dentry;
> -	if (ctx->fudptr) {
> -		*ctx->fudptr = fud;
> +	if (fud) {
> +		fuse_dev_install(fud, fc);
>  		wake_up_all(&fuse_dev_waitq);
>  	}
>  	mutex_unlock(&fuse_mutex);
> @@ -1916,9 +1909,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>   err_unlock:
>  	mutex_unlock(&fuse_mutex);
>  	dput(root_dentry);
> - err_dev_free:
> -	if (fud)
> -		fuse_dev_free(fud);
>   err_free_dax:
>  	if (IS_ENABLED(CONFIG_FUSE_DAX))
>  		fuse_dax_conn_free(fc);
> @@ -1944,13 +1934,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
>  	if ((ctx->file->f_op != &fuse_dev_operations) ||
>  	    (ctx->file->f_cred->user_ns != sb->s_user_ns))
>  		return -EINVAL;
> -	ctx->fudptr = &ctx->file->private_data;
>  
>  	err = fuse_fill_super_common(sb, ctx);
>  	if (err)
>  		return err;
> -	/* file->private_data shall be visible on all CPUs after this */
> -	smp_mb();
>  
>  	fm = get_fuse_mount_super(sb);
>  
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 2f7485ffac52..f685916754ad 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1590,8 +1590,6 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>  			goto err_free_fuse_devs;
>  	}
>  
> -	/* virtiofs allocates and installs its own fuse devices */
> -	ctx->fudptr = NULL;
>  	if (ctx->dax_mode != FUSE_DAX_NEVER) {
>  		if (ctx->dax_mode == FUSE_DAX_ALWAYS && !fs->dax_dev) {
>  			err = -EINVAL;
> -- 
> 2.53.0
> 
> 
