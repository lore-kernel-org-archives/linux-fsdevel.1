Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F771B6D08
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871712; cv=none; b=BbHVpNaHifbfeGZcaIBxFcWwN8Q9sKEBOkFqbeIAnzUyDNTjef4onq+i5F0mBCKOsnZB+yyf3wpcU5Z8aTIiY0wrKE8K0j5XRWlKu0ac0TcwJgg09a1T1xUqxTGqs8miD2wONR3FdziC+oi6Ue+0nITp8WDDiVZrvj4osOQk1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871712; c=relaxed/simple;
	bh=xF0STBuODk7sadMJGVyZBECIfetLc6Qp1tv97ArVf8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfKFOWjGOeE2B72jz/fniXpl0zYD0ayI7XAidz82IxPc17h/zb48VSdgmkpxrskH3KCQMrQJ+qc5ipDMLgy97I0F8Nhf/QWT7+2Xv5Hk5SiSyNSmPR7fbHM4lcCZwbiHMK9J1A0+xJ+TIKZGVrCJ5a525lrbfNhn1mQ3m8bWdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gz2gPw6E; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gz2gPw6E"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779871705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rZVTgqYB2Y0kCgKB9vRLlwMkkN4Wxtg827MkQZc14Ks=;
	b=Gz2gPw6Eh0Z+3F8yGV9L9QEOx7iV/5P98QGpsIrSjiKcZc2ITXsxHWX5sYlLXIr7n+7/5NjPzQQh9kFAkdHsGH/dLGzTY7TCc4nqoC5NJX5mWR8NWm166fII5dIcaDOCIfaAuP3BuwJSu8qK8geyhaqHnMRqNq05jqwgy+HM75c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X3j9Eym_1779871703;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3j9Eym_1779871703 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 16:48:24 +0800
Message-ID: <59bd7e2d-7bce-4b75-a87b-31d442bae7f8@linux.alibaba.com>
Date: Wed, 27 May 2026 16:48:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] fuse: move fuse_uring_abort() from header to
 dev_uring.c
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-9-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-9-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Move fuse_uring_abort() out of the inline header definition and into
> dev_uring.c. This function calls several internal helpers (abort
> requests, stop queues) that are all defined in dev_uring.c so inlining
> it in the header unnecessarily exposes implementation details.
>
> This will make the subsequent commit that adds pinning capabilties for
> fuse buffers cleaner.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c   | 17 +++++++++++++++--
>  fs/fuse/dev_uring_i.h | 16 +---------------
>  2 files changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index a85acd9c2b71..cce8994241b7 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -129,7 +129,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
>  	fuse_dev_end_requests(&req_list);
>  }
>  
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring)
> +static void fuse_uring_abort_end_requests(struct fuse_ring *ring)
>  {
>  	int qid;
>  	struct fuse_ring_queue *queue;
> @@ -477,7 +477,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>  /*
>   * Stop the ring queues
>   */
> -void fuse_uring_stop_queues(struct fuse_ring *ring)
> +static void fuse_uring_stop_queues(struct fuse_ring *ring)
>  {
>  	int qid;
>  
> @@ -501,6 +501,19 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>  	}
>  }
>  
> +void fuse_uring_abort(struct fuse_conn *fc)
> +{
> +	struct fuse_ring *ring = fc->ring;
> +
> +	if (ring == NULL)
> +		return;
> +
> +	if (atomic_read(&ring->queue_refs) > 0) {
> +		fuse_uring_abort_end_requests(ring);
> +		fuse_uring_stop_queues(ring);
> +	}
> +}
> +
>  /*
>   * Handle IO_URING_F_CANCEL, typically should come on daemon termination.
>   *
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..349418db3374 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -137,27 +137,13 @@ struct fuse_ring {
>  
>  bool fuse_uring_enabled(void);
>  void fuse_uring_destruct(struct fuse_conn *fc);
> -void fuse_uring_stop_queues(struct fuse_ring *ring);
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring);
> +void fuse_uring_abort(struct fuse_conn *fc);
>  int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
>  bool fuse_uring_remove_pending_req(struct fuse_req *req);
>  bool fuse_uring_request_expired(struct fuse_conn *fc);
>  
> -static inline void fuse_uring_abort(struct fuse_conn *fc)
> -{
> -	struct fuse_ring *ring = fc->ring;
> -
> -	if (ring == NULL)
> -		return;
> -
> -	if (atomic_read(&ring->queue_refs) > 0) {
> -		fuse_uring_abort_end_requests(ring);
> -		fuse_uring_stop_queues(ring);
> -	}
> -}
> -
>  static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring = fc->ring;


