Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29A35A3BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446392; cv=none; b=VSHVxUDoBSj8VmPX+yNnpL3VBDUaJt17YS7MH2jJhXTT9ZYpKDjIWT/1tAEH42UbhDoBkAaKzphaqepQ5khdN4I5EcCaKBuIGZNfi9QE0on+puCB+S3K8wxDhpdxkIya7pYc8LYtV7aeDYFjXACc+LLlQKj1EaZR8PGkHu724L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446392; c=relaxed/simple;
	bh=6DttKcg8hFwXw+3D+2rKmm3juBr7zD5MiDOKQs6/3Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD2BqSXsaPDVHazYGGP43tRN2lPc6eqd3/WAeAMK76wYNSCkpXps92Sw3VeSrU5ZNTCp6zREOJKKD/wKLmDC+h2JrGRbFKPC25MAtG5l1AiIkW6HOfqRF8hjnPYRa/mzNxrFkISTQdyIIVNvW47GoAUhzXcXqPMTc/eaXIqyA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elMH9oiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elMH9oiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC2AC19421;
	Fri, 13 Mar 2026 23:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773446391;
	bh=6DttKcg8hFwXw+3D+2rKmm3juBr7zD5MiDOKQs6/3Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elMH9oiN6p5pThR+ZK6fo9d5CT423uw3S2VA73+TgHlCyzFBnu167RFvSL477dEpZ
	 FkvyCdFYjQ9V7FyjdnAcmUc2r+66PQ721Sd7kKdvz0Btg0AOTpNRYjorZMqOe+aVo7
	 3tsXbrGjvKIOJDcrcqZYk9XhjgCpjkNaNG8/UTV7nZucblvf5pQfmRW4//rGRCEiSF
	 ansvOcCY4jBY8kGdvbTZPI2/yYW87NSUNzvxcbJPAR2tmb/Biwr4iqUdYmMAKdHQnS
	 XTQVCg0NI5or3Kc3s+wtLkIqNQAHia2BnIgOGX8hfWuMZBmnlC5IYOJcOVg64QqFBM
	 ZIY3w4v0Xy5tg==
Date: Fri, 13 Mar 2026 16:59:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 4/6] fuse: clean up device cloning
Message-ID: <20260313235951.GH1742010@frogsfrogsfrogs>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-5-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-5-mszeredi@redhat.com>

On Thu, Mar 12, 2026 at 08:40:02PM +0100, Miklos Szeredi wrote:
>  - fuse_mutex is not needed for device cloning, because fuse_dev_install()
>    uses cmpxcg() to set fud->fc, which prevents races between clone/mount
>    or clone/clone.  This makes the logic simpler
> 
>  - Drop fc->dev_count.  This is only used to check in release if the device
>    is the last clone, but checking list_empty(&fc->devices) is equivalent
>    after removing the released device from the list.  Removing the fuse_dev
>    before calling fuse_abort_conn() is okay, since the processing and io
>    lists are now empty for this device.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c    | 44 ++++++++++++++++----------------------------
>  fs/fuse/fuse_i.h |  3 ---
>  fs/fuse/inode.c  |  1 -
>  3 files changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3adf6bd38c9b..18cc844cf290 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2543,14 +2543,15 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  
>  		fuse_dev_end_requests(&to_end);
>  
> +		spin_lock(&fc->lock);
> +		list_del(&fud->entry);
> +		spin_unlock(&fc->lock);
> +
>  		/* Are we the last open device? */
> -		if (atomic_dec_and_test(&fc->dev_count)) {
> +		if (list_empty(&fc->devices)) {

If you have two threads closing their cloned fuse dev fds, can they both
see an empty list here and abort the connection?  I think they can, but
it's benign because the abort takes its own spinlock.

Aside from that question, this looks ok to me.

--D

>  			WARN_ON(fc->iq.fasync != NULL);
>  			fuse_abort_conn(fc);
>  		}
> -		spin_lock(&fc->lock);
> -		list_del(&fud->entry);
> -		spin_unlock(&fc->lock);
>  		fuse_conn_put(fc);
>  	}
>  	fuse_dev_put(fud);
> @@ -2569,24 +2570,10 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
>  	return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
>  }
>  
> -static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
> -{
> -	struct fuse_dev *new_fud = fuse_file_to_fud(new);
> -
> -	if (fuse_dev_fc_get(new_fud))
> -		return -EINVAL;
> -
> -	fuse_dev_install(new_fud, fc);
> -	atomic_inc(&fc->dev_count);
> -
> -	return 0;
> -}
> -
>  static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  {
> -	int res;
>  	int oldfd;
> -	struct fuse_dev *fud = NULL;
> +	struct fuse_dev *fud, *new_fud;
>  
>  	if (get_user(oldfd, argp))
>  		return -EFAULT;
> @@ -2599,17 +2586,18 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  	 * Check against file->f_op because CUSE
>  	 * uses the same ioctl handler.
>  	 */
> -	if (fd_file(f)->f_op == file->f_op)
> -		fud = __fuse_get_dev(fd_file(f));
> +	if (fd_file(f)->f_op != file->f_op)
> +		return -EINVAL;
>  
> -	res = -EINVAL;
> -	if (fud) {
> -		mutex_lock(&fuse_mutex);
> -		res = fuse_device_clone(fud->fc, file);
> -		mutex_unlock(&fuse_mutex);
> -	}
> +	fud = __fuse_get_dev(fd_file(f));
> +	if (!fud)
> +		return -EINVAL;
>  
> -	return res;
> +	new_fud = fuse_file_to_fud(file);
> +	if (!fuse_dev_install(new_fud, fud->fc))
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static long fuse_dev_ioctl_backing_open(struct file *file,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b77b384b0385..92576e28f8ac 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -647,9 +647,6 @@ struct fuse_conn {
>  	/** Refcount */
>  	refcount_t count;
>  
> -	/** Number of fuse_dev's */
> -	atomic_t dev_count;
> -
>  	/** Current epoch for up-to-date dentries */
>  	atomic_t epoch;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 45abcfec03a4..e42356d60f7a 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -995,7 +995,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	spin_lock_init(&fc->bg_lock);
>  	init_rwsem(&fc->killsb);
>  	refcount_set(&fc->count, 1);
> -	atomic_set(&fc->dev_count, 1);
>  	atomic_set(&fc->epoch, 1);
>  	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
>  	init_waitqueue_head(&fc->blocked_waitq);
> -- 
> 2.53.0
> 
> 
