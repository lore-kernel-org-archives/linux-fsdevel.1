Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463637F746
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783354; cv=none; b=LG7SZ4+acatV1HROPkIC8/Bf8vcFfe3vYsIn62MdD2sknITDLKGdOIE24LIcgrCicJwUVKUsImYkaOEdT/wsxFXuzCgsGf8/LpjHnExRru1CLq5uVEpVCcauyxmgEyoq9gVnEMAHX3SsniqDRG3ZNbfb/g0143iAIBo2mCB1gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783354; c=relaxed/simple;
	bh=4tvc2wvh28d7grBnwZGeQ1MGi3Ejhg24+vjI+PsA0QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvOTGJDUIq0QMjSGNKFeuo2tiuerGYUn9Zx5kUG7dDQcrchbrxqMdwOMUEewCvDYGRfoGmmpucsoiNZGgv8+i1Xtk03U2EAQCCzGppZxeqFcdBx5vTOMQAThwPlcz9s1HvBdHf6ZCmrDH4MNDSrPpArItVjevn+VQ+iP47J2I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=TU2WuFUu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owYqscFt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="TU2WuFUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owYqscFt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F39E1D000BF;
	Tue, 17 Mar 2026 17:35:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 17:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773783350;
	 x=1773869750; bh=xmDIMj1wya9u3j10xeJO/WoqnTWBCtw7MB/3+ZygntU=; b=
	TU2WuFUu8f3K8DP98A7Sr+wAAa6EtClTy6kmpzfMuZAPvXYRZqsE2qzuGabnlkZz
	YcnNJMHes6u+shEoSruP5zYa0ltr6VxilTw+H0QYl0ei9giP1fQ5D4G82o2q7UXO
	A0FanIe6JJw38cwfIWntVO+xZzwNUhQThlmKRcfMX84KKoowAjX2jNcv4XD7C7qN
	wknA+Do+yAjErEkDumCaCM5XikztS4F2ZINL510eb+uNjR2yT7EjYqWihycpMmI4
	Hr0LMcFK/dnGzyF9jMi9BCtOCKdqOeRvNSUIjiOlzpgaqGufoNToA0nz419Yi9BP
	UQ+7ErrBHEy0Z+gbaFFC+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773783350; x=
	1773869750; bh=xmDIMj1wya9u3j10xeJO/WoqnTWBCtw7MB/3+ZygntU=; b=o
	wYqscFtsK6JoHetsoHcay5pdSVfYXS/H65LB7vBTwTrNOFbvmI1uJNcRh3mnX5WT
	EFbPAY3K96bB/7DxJDfsHC0akhnzAbg2rICZ2O7P5/0ag0U2kSqfqEEsbxz3QM/O
	0Wuh5StHJnVJPSX9RCnlKX2b+J1u/xtbzPugD79ESzaKxccAkExWdp2bGqDqQ9hZ
	jlNu9JjM8O4Egp0U3pMbddGDXD0cFpN3oslWuQTVemd3R5/SfY/2vF02lMjnn7y0
	oGdfxHYQUVYuq6mMmE1n6aD33H2dLrkqU14i/TTWMoQQcwgIogIY3wXKqolmBvZm
	GAUVtELY1qe8gPotsxx7g==
X-ME-Sender: <xms:Nsm5acg-3B2dcnoGUV2LvvJ8uIq76xnhA3nf-0zDauGyMGo7hWA3yg>
    <xme:Nsm5acdiYJkKBnJeM3sI_2HcbAReGlfM_QQ1jxTl9UYNJ0DXrQLYCWkGjvLhJidCV
    5KdbP2bHBiizndTO8melQgF2P2oXH-Rc9AuLoEDPGyFfhZXkYWCeg>
X-ME-Received: <xmr:Nsm5aRfhuryPYUROPOn0MWRCseYTK0m_6f1WYc63EC4SK2A8kbivtGQ2CddCuzXTCFonjHNHNvS8c7v40Now3cJ8ji3nfGq6-h10eGkjNJmZILNruw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Nsm5aW8Ey51xzU9-AbMgQttErrwGq7RWK_dFvIVQcM1O6zIuUAUUnQ>
    <xmx:Nsm5adkYIlh9rPAkLF1uoOJvAtpjY59XLpwjKnkYE2DIhX1969ubjw>
    <xmx:Nsm5aY8LdUkz8gbtE1DjdpwLZCrzxXe4n4UbNgN9_2CNzNUMVFn9iw>
    <xmx:Nsm5ablv34aS8FC4jtJmBO3SB00wGZLPnDYfZr9yW57m55RSxQflTA>
    <xmx:Nsm5aSOKWlezZnz5lGkBTBOdaFQukqZKN3GyVyAUZlQympKJtxUr6SfU>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 17:35:50 -0400 (EDT)
Message-ID: <55a31380-ac95-49c7-93b5-e5850fd23217@bsbernd.com>
Date: Tue, 17 Mar 2026 22:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] fuse: create fuse_dev on /dev/fuse open instead of
 mount
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-3-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260316165320.3245526-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 17:53, Miklos Szeredi wrote:
> Allocate struct fuse_dev when opening the device.  This means that unlike
> before, ->private_data is always set to a valid pointer.
> 
> The use of USE_DEV_SYNC_INIT magic pointer for the private_data is now
> replaced with a simple bool sync_init member.
> 
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
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/dev.c        | 47 +++++++++++++++++---------------------------
>  fs/fuse/fuse_dev_i.h | 33 +++++++++++++++++++++++--------
>  fs/fuse/fuse_i.h     |  6 +++---
>  fs/fuse/inode.c      | 35 +++++++++++----------------------
>  fs/fuse/virtio_fs.c  |  2 --
>  5 files changed, 57 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index f0631c48abef..fe453634897b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1546,32 +1546,24 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,

I have a question about fuse_dev_do_read(), is there any risk that the
compiler might re-order and put the

struct fuse_conn *fc = fud->fc;

before the "struct fuse_dev *fud = fuse_get_dev(file);" line in the
callers?  In order to be absolutely sure, wouldn't it make sense to have
a fuse_get_dev_fc() function, that also returns the fc that was acquired
anyway and then add this to fuse_dev_do_read()?


The other parts are a nice simplification, thank you Miklos!



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
> +	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud) != NULL);
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	fud = __fuse_get_dev(file);
> -	if (!fud)
> -		return ERR_PTR(-EPERM);
> -
>  	return fud;
>  }
>  
> @@ -2538,10 +2530,10 @@ void fuse_wait_aborted(struct fuse_conn *fc)
>  
>  int fuse_dev_release(struct inode *inode, struct file *file)
>  {
> -	struct fuse_dev *fud = __fuse_get_dev(file);
> +	struct fuse_dev *fud = fuse_file_to_fud(file);
> +	struct fuse_conn *fc = fuse_dev_fc_get(fud);
>  
> -	if (fud) {
> -		struct fuse_conn *fc = fud->fc;
> +	if (fc) {
>  		struct fuse_pqueue *fpq = &fud->pq;
>  		LIST_HEAD(to_end);
>  		unsigned int i;
> @@ -2559,8 +2551,8 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  			WARN_ON(fc->iq.fasync != NULL);
>  			fuse_abort_conn(fc);
>  		}
> -		fuse_dev_free(fud);
>  	}
> +	fuse_dev_free(fud);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_release);
> @@ -2578,16 +2570,12 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
>  
>  static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
>  {
> -	struct fuse_dev *fud;
> +	struct fuse_dev *new_fud = fuse_file_to_fud(new);
>  
> -	if (__fuse_get_dev(new))
> +	if (fuse_dev_fc_get(new_fud))
>  		return -EINVAL;
>  
> -	fud = fuse_dev_alloc_install(fc);
> -	if (!fud)
> -		return -ENOMEM;
> -
> -	new->private_data = fud;
> +	fuse_dev_install(new_fud, fc);
>  	atomic_inc(&fc->dev_count);
>  
>  	return 0;
> @@ -2661,10 +2649,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>  static long fuse_dev_ioctl_sync_init(struct file *file)
>  {
>  	int err = -EINVAL;
> +	struct fuse_dev *fud = fuse_file_to_fud(file);
>  
>  	mutex_lock(&fuse_mutex);
> -	if (!__fuse_get_dev(file)) {
> -		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
> +	if (!fuse_dev_fc_get(fud)) {
> +		fud->sync_init = true;
>  		err = 0;
>  	}
>  	mutex_unlock(&fuse_mutex);
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
>  
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
> index 23a241f18623..94b49384a2f7 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -577,6 +577,9 @@ struct fuse_pqueue {
>   * Fuse device instance
>   */
>  struct fuse_dev {
> +	/** Issue FUSE_INIT synchronously */
> +	bool sync_init;
> +
>  	/** Fuse connection for this device */
>  	struct fuse_conn *fc;
>  
> @@ -623,9 +626,6 @@ struct fuse_fs_context {
>  
>  	/* DAX device, may be NULL */
>  	struct dax_device *dax_dev;
> -
> -	/* fuse_dev pointer to fill in, should contain NULL on entry */
> -	void **fudptr;
>  };
>  
>  struct fuse_sync_bucket {
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 84f78fb89d35..c2d1184d5ba5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1638,7 +1638,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc);
>  
>  void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
>  {
> -	fud->fc = fuse_conn_get(fc);
> +	fuse_dev_fc_set(fud, fuse_conn_get(fc));
>  	spin_lock(&fc->lock);
>  	list_add_tail(&fud->entry, &fc->devices);
>  	spin_unlock(&fc->lock);
> @@ -1660,7 +1660,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
>  
>  void fuse_dev_free(struct fuse_dev *fud)
>  {
> -	struct fuse_conn *fc = fud->fc;
> +	struct fuse_conn *fc = fuse_dev_fc_get(fud);
>  
>  	if (fc) {
>  		spin_lock(&fc->lock);
> @@ -1823,7 +1823,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
>  
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  {
> -	struct fuse_dev *fud = NULL;
> +	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
>  	struct fuse_mount *fm = get_fuse_mount_super(sb);
>  	struct fuse_conn *fc = fm->fc;
>  	struct inode *root;
> @@ -1857,18 +1857,11 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
> @@ -1890,15 +1883,15 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
> @@ -1907,8 +1900,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
> @@ -1917,9 +1910,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>   err_unlock:
>  	mutex_unlock(&fuse_mutex);
>  	dput(root_dentry);
> - err_dev_free:
> -	if (fud)
> -		fuse_dev_free(fud);
>   err_free_dax:
>  	if (IS_ENABLED(CONFIG_FUSE_DAX))
>  		fuse_dax_conn_free(fc);
> @@ -1945,13 +1935,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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

