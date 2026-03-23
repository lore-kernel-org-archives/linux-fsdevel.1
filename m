Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B43B19AC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290170; cv=none; b=KsyN1wcmmxztbGAK2LxZkNSl9BcJf2ZnFuMsWvylHU1ONafqENdGblhM0fnW5ZT6+p1WBiR0faGkiSqzJmBx2hzwGBqbkY4zbpge50DaXMU1RyVnO22SnSBeXJfPInH0UW8LsEVsvpP9HdWWc5/3hb5A8+3hA4OIbYrAzV//fF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290170; c=relaxed/simple;
	bh=q/yCnur7MYr1/WFvoHvVSmr4ENDQN0tWi9cDf4Czj64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVxM9nsqr+THmtFBuEta9XkPyGYHrK1emUdP7HhamShaG4wJAmYLWpqvRnzcmdnmIoA/+vDi7vUQ4yBFJl4++v4oGXh55O4lJI1yyaTeo4ry48cMGT1PFEGitTlHF1OSXThZuUr4KPugq6uKpm7SPOMMisSAgmyWEZVVisJjOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKS1VEEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKS1VEEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C87C4CEF7;
	Mon, 23 Mar 2026 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774290169;
	bh=q/yCnur7MYr1/WFvoHvVSmr4ENDQN0tWi9cDf4Czj64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKS1VEEA9ANALeJIDwv5yunlQbif63TLqwSHcoA7iGsFKK4ElRQdgDnmQbDyjRHqS
	 BiytF0UINFL15TP2ofHQFm/mU0JmmRP35CQRHuYvepA6ZpRQAVscI7E9CCujc9ryJK
	 u87M07h3PGwBCABBFxm/wZRkBBnm71C3QNNewV+d6Hk9WhAfmNLZqo4lPICVDfDgFA
	 3r2gjywhd9vFBpE348VBNB+FUug6pH1bAFYbGRfxY0JuCe9Y3p42pmhbXR41YcTzad
	 W1sBWOA1o3LferK00d3+6gJWkFbUlrEMM6OMOZpUpHwvkq0mIcvdMkYoyJj1dWYXsM
	 vHoRzIlVhaVpg==
Date: Mon, 23 Mar 2026 11:22:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v3 6/7] fuse: alloc pqueue before installing fc
Message-ID: <20260323182249.GC6202@frogsfrogsfrogs>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-7-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316165320.3245526-7-mszeredi@redhat.com>

On Mon, Mar 16, 2026 at 05:53:17PM +0100, Miklos Szeredi wrote:
> Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated on
> mount.  But now fuse_dev is allocated when opening /dev/fuse, even though
> the queues are not needed at that time.
> 
> Delay allocation of the pqueue (4k worth of list_head) just before mounting
> or cloning a device.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

I wonder if this is worth the extra complexity to defer a memory
allocation?  If the fuse server actually mount()s then we need the
pqueues, right?  How common is it for a fuse server to open the
/dev/fuse when the kernel is so low on memory that the open() would fail
with ENOMEM on account of the pqueue allocation?  And is it likely that
a lot of memory would be freed up by the time we get to mount/clone?

I suppose if you had a very slow mounting fuse server this could happen,
but now everyone has to understand that fud->pq.processing can be NULL.

--D

> ---
>  fs/fuse/dev.c       |  9 ++++++--
>  fs/fuse/dev_uring.c |  2 +-
>  fs/fuse/fuse_i.h    |  5 +++--
>  fs/fuse/inode.c     | 51 +++++++++++++++++++++++++++++----------------
>  fs/fuse/virtio_fs.c |  4 ++--
>  5 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3d6578fcb386..d18796b1010c 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1546,7 +1546,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  
>  static int fuse_dev_open(struct inode *inode, struct file *file)
>  {
> -	struct fuse_dev *fud = fuse_dev_alloc();
> +	struct fuse_dev *fud = fuse_dev_alloc(false);
>  
>  	if (!fud)
>  		return -ENOMEM;
> @@ -2580,6 +2580,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  {
>  	int oldfd;
>  	struct fuse_dev *fud, *new_fud;
> +	struct list_head *pq;
>  
>  	if (get_user(oldfd, argp))
>  		return -EFAULT;
> @@ -2599,8 +2600,12 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  	if (!fud)
>  		return -EINVAL;
>  
> +	pq = fuse_pqueue_alloc();
> +	if (!pq)
> +		return -ENOMEM;
> +
>  	new_fud = fuse_file_to_fud(file);
> -	if (!fuse_dev_install(new_fud, fud->fc))
> +	if (!fuse_dev_install(new_fud, fud->fc, pq))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 7b9822e8837b..fb4f21c871fb 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -277,7 +277,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  	queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
>  	if (!queue)
>  		return NULL;
> -	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> +	pq = fuse_pqueue_alloc();
>  	if (!pq) {
>  		kfree(queue);
>  		return NULL;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 77f1c7cf24d2..e22d65e5ecff 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1340,8 +1340,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  void fuse_conn_put(struct fuse_conn *fc);
>  
>  struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
> -struct fuse_dev *fuse_dev_alloc(void);
> -bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
> +struct list_head *fuse_pqueue_alloc(void);
> +struct fuse_dev *fuse_dev_alloc(bool alloc_pq);
> +bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc, struct list_head *pq);
>  void fuse_dev_put(struct fuse_dev *fud);
>  int fuse_send_init(struct fuse_mount *fm);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 7065614d02c9..f388d57fdd8f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -977,15 +977,22 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
>  
>  void fuse_pqueue_init(struct fuse_pqueue *fpq)
>  {
> -	unsigned int i;
> -
>  	spin_lock_init(&fpq->lock);
> -	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> -		INIT_LIST_HEAD(&fpq->processing[i]);
>  	INIT_LIST_HEAD(&fpq->io);
>  	fpq->connected = 1;
>  }
>  
> +struct list_head *fuse_pqueue_alloc(void)
> +{
> +	struct list_head *pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> +
> +	if (pq) {
> +		for (int i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> +			INIT_LIST_HEAD(&pq[i]);
> +	}
> +	return pq;
> +}
> +
>  void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  		    struct user_namespace *user_ns,
>  		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
> @@ -1633,33 +1640,38 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>  	return 0;
>  }
>  
> -struct fuse_dev *fuse_dev_alloc(void)
> +struct fuse_dev *fuse_dev_alloc(bool alloc_pq)
>  {
>  	struct fuse_dev *fud;
> -	struct list_head *pq;
> +	struct list_head *pq __free(kfree) = NULL;
> +
> +	if (alloc_pq) {
> +		pq = fuse_pqueue_alloc();
> +		if (!pq)
> +			return NULL;
> +	}
>  
>  	fud = kzalloc_obj(struct fuse_dev);
>  	if (!fud)
>  		return NULL;
>  
>  	refcount_set(&fud->ref, 1);
> -	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> -	if (!pq) {
> -		kfree(fud);
> -		return NULL;
> -	}
> -
> -	fud->pq.processing = pq;
> +	fud->pq.processing = no_free_ptr(pq);
>  	fuse_pqueue_init(&fud->pq);
>  
>  	return fud;
>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_alloc);
>  
> -bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
> +bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc, struct list_head *pq)
>  {
>  	struct fuse_conn *old_fc;
>  
> +	if (!pq)
> +		WARN_ON(!fud->pq.processing);
> +	else if (cmpxchg(&fud->pq.processing, NULL, pq))
> +		kfree(pq);
> +
>  	fuse_conn_get(fc);
>  	spin_lock(&fc->lock);
>  	/*
> @@ -1687,13 +1699,12 @@ EXPORT_SYMBOL_GPL(fuse_dev_install);
>  
>  struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
>  {
> -	struct fuse_dev *fud;
> +	struct fuse_dev *fud = fuse_dev_alloc(true);
>  
> -	fud = fuse_dev_alloc();
>  	if (!fud)
>  		return NULL;
>  
> -	fuse_dev_install(fud, fc);
> +	fuse_dev_install(fud, fc, NULL);
>  	return fud;
>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
> @@ -1871,10 +1882,14 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	struct fuse_dev *fud = ctx->fud;
>  	struct fuse_mount *fm = get_fuse_mount_super(sb);
>  	struct fuse_conn *fc = fm->fc;
> +	struct list_head *pq __free(kfree) = fuse_pqueue_alloc();
>  	struct inode *root;
>  	struct dentry *root_dentry;
>  	int err;
>  
> +	if (!pq)
> +		return -ENOMEM;
> +
>  	err = -EINVAL;
>  	if (sb->s_flags & SB_MANDLOCK)
>  		goto err;
> @@ -1946,7 +1961,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	list_add_tail(&fc->entry, &fuse_conn_list);
>  	sb->s_root = root_dentry;
>  	if (fud) {
> -		if (!fuse_dev_install(fud, fc))
> +		if (!fuse_dev_install(fud, fc, no_free_ptr(pq)))
>  			fc->connected = 0; /* device file got closed */
>  		else
>  			wake_up_all(&fuse_dev_waitq);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 12300651a0f1..cc6426992ecd 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1585,7 +1585,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>  	for (i = 0; i < fs->nvqs; i++) {
>  		struct virtio_fs_vq *fsvq = &fs->vqs[i];
>  
> -		fsvq->fud = fuse_dev_alloc();
> +		fsvq->fud = fuse_dev_alloc(true);
>  		if (!fsvq->fud)
>  			goto err_free_fuse_devs;
>  	}
> @@ -1606,7 +1606,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>  	for (i = 0; i < fs->nvqs; i++) {
>  		struct virtio_fs_vq *fsvq = &fs->vqs[i];
>  
> -		fuse_dev_install(fsvq->fud, fc);
> +		fuse_dev_install(fsvq->fud, fc, NULL);
>  	}
>  
>  	/* Previous unmount will stop all queues. Start these again */
> -- 
> 2.53.0
> 
> 
