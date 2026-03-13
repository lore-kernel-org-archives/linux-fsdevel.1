Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF246385534
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440899; cv=none; b=otFn6Sqsmi2O5qfXOpeoYh49JrrJH0OqkS5OrOGGDLvq016myYyJQBx4q3fEet0v54XJ3Zj0UIkIOdSVxXjLG1e35xo6YxNyH1imTf7eqgUGZs5usdX7og/5gQcjb04zbU/LEeulVOLeOmfnKntEEOUwTsrczl4AINInhw62evk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440899; c=relaxed/simple;
	bh=9NJMqvjRhLcQDRH9AopjhtJ+XnX9CNCAGAz6BGlc46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHIOC4Mdl72OmItsGiKHqAXrQXRS/KHNXBXfnOAqaIYNeJhvLwrqPIe3+aF1+A69ZwhmfJmGu/Oe6hxR6hUgLuDsrxmd4UCQ9xU5LW/wUs4iEj0LirsS29IWKZyBzozFz1VQSAkKUh8t6b+yUq8oZArk/pI5ZlNq/e3Kmzi6tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXOffmzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXOffmzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A0EC19421;
	Fri, 13 Mar 2026 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773440899;
	bh=9NJMqvjRhLcQDRH9AopjhtJ+XnX9CNCAGAz6BGlc46Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXOffmzuVHYkFmCZ4j7M5lzgY6E/Z+VFSHqtfKa86i5Mh2S0/gQv77XCVOQGOzY2a
	 +mRNBzPDcXHWad55W3S5/PHMemJ4PXFkmeswfEPuBbe743sOgWds6d5KBymgmJcC6z
	 9Hszjm2Lafil5rPKMu6C62dMm/sbUbGllAY70HTs+KpU5UxPmQuzVgU9Y+K40v17GS
	 oohNPImJ5gt8z7jB+dLsMKEfKAi/b4r6xTEMFR8dqNqNOAJ9frBN9z4P5LoUG5JpFc
	 xzbThQgfxMdZPeLjM6quNCs1xGfYCLv9fjRARrwldJFxo/wo1G32GXgktUxPxlduoX
	 8b3/oYKBbJ2gw==
Date: Fri, 13 Mar 2026 15:28:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 2/6] fuse: add refcount to fuse_dev
Message-ID: <20260313222818.GF1742010@frogsfrogsfrogs>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-3-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-3-mszeredi@redhat.com>

On Thu, Mar 12, 2026 at 08:40:00PM +0100, Miklos Szeredi wrote:
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
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/cuse.c       |  2 +-
>  fs/fuse/dev.c        |  9 +++++++--
>  fs/fuse/fuse_dev_i.h | 11 ++++-------
>  fs/fuse/fuse_i.h     |  6 ++++--
>  fs/fuse/inode.c      | 43 +++++++++++++++++++++++++++++++++++--------
>  fs/fuse/virtio_fs.c  |  2 +-
>  6 files changed, 52 insertions(+), 21 deletions(-)
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
> index 4795e3d01b75..3adf6bd38c9b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2527,7 +2527,8 @@ void fuse_wait_aborted(struct fuse_conn *fc)
>  int fuse_dev_release(struct inode *inode, struct file *file)
>  {
>  	struct fuse_dev *fud = fuse_file_to_fud(file);
> -	struct fuse_conn *fc = fuse_dev_fc_get(fud);
> +	/* Pairs with cmpxchg() in fuse_dev_install() */
> +	struct fuse_conn *fc = xchg(&fud->fc, FUSE_DEV_FC_DISCONNECTED);

Humm.  The previous patch introduced code that does things based on the
null-ness of the return value of fuse_dev_fc_get().  I /think/ code like
this from fuse_device_clone:

	if (fuse_dev_fc_get(new_fud))
		return -EINVAL

is ok as long as you can't clone a disconnected fuse_dev file, right?
But then there's __fuse_get_dev, which does:

	struct fuse_dev *fud = fuse_file_to_fud(file);

	if (!fuse_dev_fc_get(fud))
		return NULL;
	return fud;

at which point a disconnected fud could in theory leak out to other
parts of fuse.  Is there something to prevent other code from
dereferencing fud->fc (which is 0x1) and blowing up?

I guess the answer might be that you've closed /dev/fuse so there aren't
going to be more requests coming in from userspace and all we're doing
is tearing down the fud?  But why not set fud->fc to NULL on
disconnection?

>  	if (fc) {

BTW, is there a chance that we can race here?  I think the answer is
'no' because only one thread can ->release the fuse device file, right?

>  		struct fuse_pqueue *fpq = &fud->pq;
> @@ -2547,8 +2548,12 @@ int fuse_dev_release(struct inode *inode, struct file *file)
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
> index 522b2012cd1f..9eae14ace73c 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -39,22 +39,19 @@ struct fuse_copy_state {
>  	} ring;
>  };
>  
> +/* fud->fc gets assigned to this value when /dev/fuse is closed */
> +#define FUSE_DEV_FC_DISCONNECTED ((struct fuse_conn *) 1)
> +
>  /*
>   * Lockless access is OK, because fud->fc is set once during mount and is valid
>   * until the file is released.
>   */
>  static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
>  {
> -	/* Pairs with smp_store_release() in fuse_dev_fc_set() */
> +	/* Pairs with xchg() in fuse_dev_install() */
>  	return smp_load_acquire(&fud->fc);
>  }
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
> index 739220d96b6f..66ec92f06497 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -576,6 +576,8 @@ struct fuse_pqueue {
>   * Fuse device instance
>   */
>  struct fuse_dev {
> +	refcount_t ref;
> +
>  	bool sync_init;
>  
>  	/** Fuse connection for this device */
> @@ -1341,8 +1343,8 @@ void fuse_conn_put(struct fuse_conn *fc);
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
> index 53663846db36..ba845092e7f2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1622,6 +1622,7 @@ struct fuse_dev *fuse_dev_alloc(void)
>  	if (!fud)
>  		return NULL;
>  
> +	refcount_set(&fud->ref, 1);
>  	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
>  	if (!pq) {
>  		kfree(fud);
> @@ -1635,12 +1636,32 @@ struct fuse_dev *fuse_dev_alloc(void)
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
> @@ -1657,11 +1678,15 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
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

AFAICT this is the only place in the whole patchset that even looks for
_DISCONNECTED, which makes me wonder even more what distinguishes it
from plain old NULL?

--D

>  		spin_lock(&fc->lock);
>  		list_del(&fud->entry);
>  		spin_unlock(&fc->lock);
> @@ -1671,7 +1696,7 @@ void fuse_dev_free(struct fuse_dev *fud)
>  	kfree(fud->pq.processing);
>  	kfree(fud);
>  }
> -EXPORT_SYMBOL_GPL(fuse_dev_free);
> +EXPORT_SYMBOL_GPL(fuse_dev_put);
>  
>  static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
>  				      const struct fuse_inode *fi)
> @@ -1900,8 +1925,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
> -- 
> 2.53.0
> 
> 
