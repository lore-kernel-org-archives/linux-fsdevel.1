Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF13A641E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787867; cv=none; b=gka+ir0JrtKa4AIPKbsFyCGb5DkrW+BrKg+lKnp4pr43L7XsqvXXPVeTvnJyTefT6pbYIGl7dRY/++plCFIE4xF3pHB7qffmP6S31LADTHH6Ai/ecU85eN0PvWOYdmitQDXX1eQ3BjmxAc0PnoNRryJYl2UErGBzALarg2xvi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787867; c=relaxed/simple;
	bh=BnUDDmqGGn2hwtUxNqvEt+DKimT6gBrLrSsTTboPfFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O6UQbJA3BOp8Ot+dwI2+lCHf6ezLwRmZQ/SvsqqXivOJlSXN3iMMLfiHbyF055wHdFwDtH9HSA9w56fsdEQlZoFPJHEDjIQTfzxOyag0mWxwGYgI0AFuMe2SjsX29afbxBd90jn+4A195AscFnfF4xCyZpzyef179aC4KZnmj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=XWcTCPAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wlGzk47q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="XWcTCPAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wlGzk47q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 648877A0208;
	Tue, 17 Mar 2026 18:51:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 18:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773787864;
	 x=1773874264; bh=bKNPcFKUw9x/JByIT0IEWvD4lcRGFjxlYu359ctEDk0=; b=
	XWcTCPAayWUbrPNh32XsevBAZFGfqrK9v4PvrePkH8VnpKjkKWSx0cZF3aDxvNOI
	x5eD7LyvhV74JhI+0L+/mxgFWWVdCW2LWY/qfpnF5NyOmmzagPhLpWP0dfvKnxI2
	/SoiGedY0shncectdvEsxqQoAoJAdMjhz6DKtFCsykYXW4pdhO2Oz6m6qtag/9aA
	7ASQb1hufZj0YegFNGv80V+uT+vXTrNFkNVlPAW+1IN7yUjlY2tqLTS5M8M7BLs1
	Zbj+jqbRLkcfMlh4tL5ja9m5AkrDtxl2OPuf16ieYHxLT/KmGCteHEEuZUT6tlYn
	Ly67Ii+j+RQxaaJHHARy1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773787864; x=1773874264; bh=b
	KNPcFKUw9x/JByIT0IEWvD4lcRGFjxlYu359ctEDk0=; b=wlGzk47qj1jReNbQo
	vvu4tZfbxqVWU+OcyG6AsmUdVov32eYq/WgmKjE/zBNljQPbUXdhItieuHqSeqIO
	VkNPWmWLz3ebDamdV3LU/eIT7obcomXWLn6MugIo+gdpMhqel5XxCqTbCmZFtnmI
	wx4Zr9Vz1WbiuexZ4zxxC5DZGL7YqMv75KWK4Pu4NfkGj4mKFj4VXTCI+ICIYOqX
	sbzODcYYBSmAwqzF+47Lqwmb21QYm01ZDNQ4ng1HobHPfJxa0+wO2ib6xuBhFCY0
	iWPdElhHA3lYTelOW8kRgAyO4+7fCbY6GU7paJ3zXnISwLeLbcdMlcbqxezrvkqs
	YMOVw==
X-ME-Sender: <xms:19q5af_vBrrTtiJ-DHLR5Hx0SwaDz_KVS_Sr6LDay79Hx_BN84ipaw>
    <xme:19q5aRvpOqqKO9JGtPoPVgJLCpRvum3jCwEAwzE4QZbTofFJeoaCNRH7CCv9j4Coz
    SMzJmtFH6bhRsM_jPRNtpLFcYwb0FdQ6QtbrOELPhnCCwN5rA>
X-ME-Received: <xmr:19q5aap4sOupq8aLP6vB1NxuA348cCcwLwiTDW8vW01c12sjtbTuJjLV7unu5-r78LyuyNjmRfKXFdhtCB89Q5abZBbHdpYhthwpMPjCTkIaGVZ2Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepvdellefhuefghedugfefteeuffejgfethfeuleegueethfegffegueffteeh
    geetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:19q5aWllHrdzzJg-cfOtjmU-ZvdlQRotT7zjzeU9hfcZj-2ga3ny_w>
    <xmx:19q5aWwBoLu9Ls3lJyThft-5b37x0VkqhX6J0rAqVhSGb_MSbkfHIA>
    <xmx:19q5aWmOjzlWW6f84QjKjFNQ-K-dJoXJ9ktlo0D4_QoDJZcpLut4rA>
    <xmx:19q5aXercq7FZRVwPoH3mv51vakdbZf_XXs0-nf_TT00-02kvoIN3w>
    <xmx:2Nq5abXpplMDr53RBFeqqye259dljqhLj67X3GBacH3SzhFYMz5RefFe>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 18:51:03 -0400 (EDT)
Message-ID: <5448457d-4687-4f33-a8f4-fe0da0a2b24a@bsbernd.com>
Date: Tue, 17 Mar 2026 23:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] fuse: clean up device cloning
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-6-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260316165320.3245526-6-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 17:53, Miklos Szeredi wrote:
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
>  fs/fuse/dev.c    | 46 ++++++++++++++++++----------------------------
>  fs/fuse/fuse_i.h |  3 ---
>  fs/fuse/inode.c  |  1 -
>  3 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 4c926c9c4f39..3d6578fcb386 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2538,6 +2538,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  		struct fuse_pqueue *fpq = &fud->pq;
>  		LIST_HEAD(to_end);
>  		unsigned int i;
> +		bool last;
>  
>  		spin_lock(&fpq->lock);
>  		WARN_ON(!list_empty(&fpq->io));
> @@ -2547,14 +2548,16 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  
>  		fuse_dev_end_requests(&to_end);
>  
> +		spin_lock(&fc->lock);
> +		list_del(&fud->entry);
>  		/* Are we the last open device? */
> -		if (atomic_dec_and_test(&fc->dev_count)) {
> +		last = list_empty(&fc->devices);
> +		spin_unlock(&fc->lock);
> +
> +		if (last) {
>  			WARN_ON(fc->iq.fasync != NULL);
>  			fuse_abort_conn(fc);
>  		}
> -		spin_lock(&fc->lock);
> -		list_del(&fud->entry);
> -		spin_unlock(&fc->lock);
>  		fuse_conn_put(fc);
>  	}
>  	fuse_dev_put(fud);
> @@ -2573,24 +2576,10 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
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
> @@ -2603,17 +2592,18 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  	 * Check against file->f_op because CUSE
>  	 * uses the same ioctl handler.
>  	 */
> -	if (fd_file(f)->f_op == file->f_op)
> -		fud = __fuse_get_dev(fd_file(f));

Let's say there is crazy daemon with

thread-A tries to mount
thread-B closes the fd during the mount
thread-C does clone in parallel



> +	if (fd_file(f)->f_op != file->f_op)
> +		return -EINVAL;
>  
> -	res = -EINVAL;
> -	if (fud) {
> -		mutex_lock(&fuse_mutex);
> -		res = fuse_device_clone(fud->fc, file);

Won't this acceess an invalid fc?

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
> index 4a591a436324..77f1c7cf24d2 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -650,9 +650,6 @@ struct fuse_conn {
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
> index 314fb37f272f..7065614d02c9 100644
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


Thanks,
Bernd
