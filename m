Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330AA1917FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785632; cv=none; b=sNeu8gZd2ONDwWetVHWNWYCJJc8X2hDiI5DfhtinrNO0vV/Q2EXNrhJxsyE0p3oSDtVI8W1Gr+QLFFKp9m21N+N1Uk5re8im7fAUASGUUVKxHAUrTmW2EpmYdUVsATLwqkakQovsjCpy+/j6T4TgtY4Z9tfxkayjjaVkTpV5ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785632; c=relaxed/simple;
	bh=CDsjQ6YolTl4SUyfNXvcRuYPD/f1CzuZvllOmwTy2VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uBqlvOvzTFSxm2mO12rrbKgOhhxtWcOQhDFrEEDutDpJgylvSOK31O54Qu5j/IOkluvqr61fRJ4QWKF8gAPn9DsbvxFaRONWgh8/21776awQSR+UCsbmh63pyJTLrHnW84FYB3MKjf3MwWFpZjbo05HmKUFpCi6myTjoAn9nAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UAb5Yniu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fi0AYlOs; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UAb5Yniu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fi0AYlOs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 804397A01C3;
	Tue, 17 Mar 2026 18:13:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 18:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773785630;
	 x=1773872030; bh=mvXLhjQ4p9C7NX23p4tS55fYaYUd/nci7i/quWqQPlc=; b=
	UAb5YniuA6+Nm4E5bEzy7X0OcGl+h5FB6TvVzGag5vGG0HN5f7ttWaeC6+KR1okF
	2gBDtz2tmOll4z9w1a8vp/qxjGncl2gwgSpFnXyCTFY5gVk3x2Ar8O2sX+M2C28c
	PEj99gCdMJHVw9jDb+/ieouDMgAFx5rsngsVkWvD83FsKSLli3C0Rfio20jZ9k/F
	6OkIpJNSWU9L8bFafgow6rJe3xx9cQI3PLV5rP+Ss9BqWRyrNUvpvzexzx272OXG
	UZZwf7aiZUfH6gInSuM2dEwHO5TBo9ENyx0nBWQnbkfz/6KSrD9G/LGOAkRFoJrq
	ImdpjYMBI7/ka/3QZCFMpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773785630; x=1773872030; bh=m
	vXLhjQ4p9C7NX23p4tS55fYaYUd/nci7i/quWqQPlc=; b=fi0AYlOsG8DUvELAI
	6zPXTEIyoxNG55B7lgtTX5cLdQM78HDn7BlChe+mvmC/I66I1BMrxAa9U4+s2Xw/
	FIZJdSd3ZXjZt0xzIgvRmsGTosH81BOcKe4BrWOLsrn96KIRvWG3lsLAjZvfwp1x
	sVC/JMtEx3NrUL7swHvyVx7uGRcw0y4JW0oa0wR1HqM99MpBbO4eD8KzTC6voyeu
	bOCYycBDXjBuns/fTu0O5CSsAvGPYjI6KZeoX3qJOksqpAU0NzlTkhCqQxrarlT2
	KIMpoR+1dNUYuEWu4ZhVz1iKyWZy7VUTVJGGOj+ItLP3AcYTm9mda9AlfhanJDC6
	IQ7Aw==
X-ME-Sender: <xms:HtK5aaFHVaYYYmgP_HGEbbheC_QLXx0whJj5z3wF9OgRayjdfWrX-A>
    <xme:HtK5aRXFqe9MZBTIzxhpxo_NHtdkwa_WW0OpNY_zhhZyYe3Q6btd_xbDJN9p6xhah
    TYUEQb8Uj9zDjH0Ow3PlND-DzlNTdbZ1iwvqFprq3Cqq4Qpj30Yeg>
X-ME-Received: <xmr:HtK5aRy-_qu1KDrcyhXPfXGS8zMvLvVI3qw1VwmygQOEnpHPmNiLX029EHLkVhZ-AVW4sF__6f001UytxpPT-FS_ioULZlLL7_G6mASmZw8DNalG3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepvdellefhuefghedugfefteeuffejgfethfeuleegueethfegffegueffteeh
    geetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HtK5afNi7svE7KE4JsdA7KIbpYCdy60hyOf3GZDWMIQUTrQMMDbZLA>
    <xmx:HtK5aS7xMN0OHN3raHoyqH8hFp4ooTnDJ2Twek1UcIwW33Oz5FUwLg>
    <xmx:HtK5aQPwhf4rlC50RfJnztr-AvpalomndZdUOmOGoaA-Ra1hXnrsqw>
    <xmx:HtK5aQmWAm25m5cF5y_ana-lbFCw3p1nJV0J68FuZ8G7qn-B0V1m9Q>
    <xmx:HtK5aVe683pfx1ufJ8OKsoJgJldXeBsnzTr0083sTY8Gq9M2jRvhqE_a>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 18:13:49 -0400 (EDT)
Message-ID: <671ace3d-bac5-4024-9e14-62262244949c@bsbernd.com>
Date: Tue, 17 Mar 2026 23:13:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] fuse: add refcount to fuse_dev
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-4-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260316165320.3245526-4-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 17:53, Miklos Szeredi wrote:
> This will make it possible to grab the fuse_dev and subsequently release
> the file that it came from.
> 
> In the above case, fud->fc will be set to FUSE_DEV_FC_DISCONNECTED to
> indicate that this is no longer a functional device.
> 
> When trying to assign an fc to such a disconnected fuse_dev, the fc is set
> to the disconnected state.
> 
> Use atomic operations xchg() and cmpxchg() to prevent races.

So the actual motivation is in fuse_fill_super_common() which checks if
the file descriptor got closed during the mount? I.e. one thread mounts
and another thread closes the fd for the mount?

> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/cuse.c       |  2 +-
>  fs/fuse/dev.c        |  9 +++++++--
>  fs/fuse/fuse_dev_i.h | 15 ++++++++-------
>  fs/fuse/fuse_i.h     |  7 +++++--
>  fs/fuse/inode.c      | 44 ++++++++++++++++++++++++++++++++++++--------
>  fs/fuse/virtio_fs.c  |  2 +-
>  6 files changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
> index dfcb98a654d8..174333633471 100644
> --- a/fs/fuse/cuse.c
> +++ b/fs/fuse/cuse.c
> @@ -527,7 +527,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
>  	cc->fc.initialized = 1;
>  	rc = cuse_send_init(cc);
>  	if (rc) {
> -		fuse_dev_free(fud);
> +		fuse_dev_put(fud);
>  		return rc;
>  	}
>  	file->private_data = fud;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index fe453634897b..4c926c9c4f39 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2531,7 +2531,8 @@ void fuse_wait_aborted(struct fuse_conn *fc)
>  int fuse_dev_release(struct inode *inode, struct file *file)
>  {
>  	struct fuse_dev *fud = fuse_file_to_fud(file);
> -	struct fuse_conn *fc = fuse_dev_fc_get(fud);
> +	/* Pairs with cmpxchg() in fuse_dev_install() */
> +	struct fuse_conn *fc = xchg(&fud->fc, FUSE_DEV_FC_DISCONNECTED);
>  
>  	if (fc) {
>  		struct fuse_pqueue *fpq = &fud->pq;
> @@ -2551,8 +2552,12 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  			WARN_ON(fc->iq.fasync != NULL);
>  			fuse_abort_conn(fc);
>  		}
> +		spin_lock(&fc->lock);
> +		list_del(&fud->entry);
> +		spin_unlock(&fc->lock);
> +		fuse_conn_put(fc);
>  	}
> -	fuse_dev_free(fud);
> +	fuse_dev_put(fud);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_release);
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 522b2012cd1f..910f883cd090 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -39,22 +39,23 @@ struct fuse_copy_state {
>  	} ring;
>  };
>  
> +/* fud->fc gets assigned to this value when /dev/fuse is closed */
> +#define FUSE_DEV_FC_DISCONNECTED ((struct fuse_conn *) 1)

Hmm, these things always give me a headache, because now all callers
need to check for FUSE_DEV_FC_DISCONNECTED? Main protection is then vfs,
which disallows device release when there are competing operations?


> +
>  /*
>   * Lockless access is OK, because fud->fc is set once during mount and is valid
>   * until the file is released.
> + *
> + * fud->fc is set to FUSE_DEV_FC_DISCONNECTED only after the containing file is
> + * released, so result is safe to dereference in most cases.  Exceptions are:
> + * fuse_dev_put() and fuse_fill_super_common().
>   */
>  static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
>  {
> -	/* Pairs with smp_store_release() in fuse_dev_fc_set() */
> +	/* Pairs with xchg() in fuse_dev_install() */
>  	return smp_load_acquire(&fud->fc);
>  }

Minor nit: Pairs with cmpxchg?

>  
> -static inline void fuse_dev_fc_set(struct fuse_dev *fud, struct fuse_conn *fc)
> -{
> -	/* Pairs with smp_load_acquire() in fuse_dev_fc_get() */
> -	smp_store_release(&fud->fc, fc);
> -}
> -
>  static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
>  {
>  	return file->private_data;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 94b49384a2f7..230201dc3f90 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -577,6 +577,9 @@ struct fuse_pqueue {
>   * Fuse device instance
>   */
>  struct fuse_dev {
> +	/** Reference count of this object */
> +	refcount_t ref;
> +
>  	/** Issue FUSE_INIT synchronously */
>  	bool sync_init;
>  
> @@ -1343,8 +1346,8 @@ void fuse_conn_put(struct fuse_conn *fc);
>  
>  struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
>  struct fuse_dev *fuse_dev_alloc(void);
> -void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
> -void fuse_dev_free(struct fuse_dev *fud);
> +bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
> +void fuse_dev_put(struct fuse_dev *fud);
>  int fuse_send_init(struct fuse_mount *fm);
>  
>  /**
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index c2d1184d5ba5..0e848e3a13c2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1623,6 +1623,7 @@ struct fuse_dev *fuse_dev_alloc(void)
>  	if (!fud)
>  		return NULL;
>  
> +	refcount_set(&fud->ref, 1);
>  	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
>  	if (!pq) {
>  		kfree(fud);
> @@ -1636,12 +1637,32 @@ struct fuse_dev *fuse_dev_alloc(void)
>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_alloc);
>  
> -void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
> +bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
>  {
> -	fuse_dev_fc_set(fud, fuse_conn_get(fc));
> +	struct fuse_conn *old_fc;
> +
> +	fuse_conn_get(fc);
>  	spin_lock(&fc->lock);
> +	/*
> +	 * Pairs with:
> +	 *  - xchg() in fuse_dev_release()
> +	 *  - smp_load_acquire() in fuse_dev_fc_get()
> +	 */
> +	old_fc = cmpxchg(&fud->fc, NULL, fc);
> +	if (old_fc) {
> +		/*
> +		 * failed to set fud->fc because
> +		 *  - it was already set to a different fc
> +		 *  - it was set to disconneted
> +		 */
> +		spin_unlock(&fc->lock);
> +		fuse_conn_put(fc);
> +		return false;
> +	}
>  	list_add_tail(&fud->entry, &fc->devices);
>  	spin_unlock(&fc->lock);
> +
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_install);
>  
> @@ -1658,11 +1679,16 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)

Shouldn't all callers, i.e. also  fuse_dev_alloc_install() and
fuse_device_clone() check for success?


>  }
>  EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
>  
> -void fuse_dev_free(struct fuse_dev *fud)
> +void fuse_dev_put(struct fuse_dev *fud)
>  {
> -	struct fuse_conn *fc = fuse_dev_fc_get(fud);
> +	struct fuse_conn *fc;
>  
> -	if (fc) {
> +	if (!refcount_dec_and_test(&fud->ref))
> +		return;
> +
> +	fc = fuse_dev_fc_get(fud);
> +	if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
> +		/* This is the virtiofs case (fuse_dev_release() not called) */
>  		spin_lock(&fc->lock);
>  		list_del(&fud->entry);
>  		spin_unlock(&fc->lock);
> @@ -1672,7 +1698,7 @@ void fuse_dev_free(struct fuse_dev *fud)
>  	kfree(fud->pq.processing);
>  	kfree(fud);
>  }
> -EXPORT_SYMBOL_GPL(fuse_dev_free);
> +EXPORT_SYMBOL_GPL(fuse_dev_put);
>  
>  static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
>  				      const struct fuse_inode *fi)
> @@ -1901,8 +1927,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	list_add_tail(&fc->entry, &fuse_conn_list);
>  	sb->s_root = root_dentry;
>  	if (fud) {
> -		fuse_dev_install(fud, fc);
> -		wake_up_all(&fuse_dev_waitq);
> +		if (!fuse_dev_install(fud, fc))
> +			fc->connected = 0; /* device file got closed */
> +		else
> +			wake_up_all(&fuse_dev_waitq);
>  	}
>  	mutex_unlock(&fuse_mutex);
>  	return 0;
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index f685916754ad..12300651a0f1 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -486,7 +486,7 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
>  		if (!fsvq->fud)
>  			continue;
>  
> -		fuse_dev_free(fsvq->fud);
> +		fuse_dev_put(fsvq->fud);
>  		fsvq->fud = NULL;
>  	}
>  }

Thanks,
Bernd
