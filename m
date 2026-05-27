Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4735E1DA
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872449; cv=none; b=nj44GYz6GMy4qOTyJim1UXXtRcQI5uLEfzso+CKscAHnwKuAxS+BQ5GASYQDnTWcE7GJbZs/aNsfMLc6pud+Et9ZfdRfIqvd8PqbfMxa6GHJo9dwTfCF7gIbz10i4HwBNNolT4nS/hvB/+h1vIxY3fvOvxoWYSAV8hjzu0PmdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872449; c=relaxed/simple;
	bh=ajlFsEUXLx4V6nM4BI5aVb99piqw1XwZDoqgALOM2U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJbc49IwKO54l2P+VLYQt23njGrJRYcsre3IMsgRebwSEhBybzGgtt7AtimO8JCoO1KPEGc9lI+7Qlbm7e8zksIhJUJWCrh7oVh6lpUWzNvE8QEPAYXgCt+rm87rZbfOhFSkzJoY/MmXxw8Syu66HCizy9eX61TKfMdiCNHgSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eTOEGzMt; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eTOEGzMt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779872444; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sMY6Rme31SmSDRy+WVsrlqCKyOjgeZOye+Qe2jg9B40=;
	b=eTOEGzMtlcrJLEoDL/Ko5WWA+RSU7JVKXlw4M85a/qxRdpM58BiAiPYg7hh8mlXPT485eoUOeGEVGy5gdgjMfmTifk4eVVCiYk8wXg9UZcdKX1lUTHD+HJL8UJSPt8ZuvGaaiSv6z3ogoTSD32alCL7/3fTWAAZZkEmgHieAg7U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X3j8ZWI_1779872442;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3j8ZWI_1779872442 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 17:00:43 +0800
Message-ID: <244c7a0e-0a9f-4e56-a610-5a211e8c553a@linux.alibaba.com>
Date: Wed, 27 May 2026 17:00:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] fuse: rearrange io-uring iovec and ent
 allocation logic
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-10-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-10-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Move fuse_uring_get_iovec_from_sqe() to earlier in the file and
> move the allocation logic in fuse_uring_create_ring_ent() to the
> beginning of the function.
>
> There is no change in logic, this is done to make the subsequent commit
> that adds buffer rings easier to review.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Looks good.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/fuse/dev_uring.c | 78 ++++++++++++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 37 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index cce8994241b7..a061f175b3fd 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -277,6 +277,32 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  	return res;
>  }
>  
> +/*
> + * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
> + * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
> + */
> +static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
> +					 struct iovec iov[FUSE_URING_IOV_SEGS])
> +{
> +	struct iovec __user *uiov = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +	struct iov_iter iter;
> +	ssize_t ret;
> +
> +	if (sqe->len != FUSE_URING_IOV_SEGS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Direction for buffer access will actually be READ and WRITE,
> +	 * using write for the import should include READ access as well.
> +	 */
> +	ret = import_iovec(WRITE, uiov, FUSE_URING_IOV_SEGS,
> +			   FUSE_URING_IOV_SEGS, &iov, &iter);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  						       int qid)
>  {
> @@ -1076,32 +1102,6 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>  	}
>  }
>  
> -/*
> - * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
> - * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
> - */
> -static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
> -					 struct iovec iov[FUSE_URING_IOV_SEGS])
> -{
> -	struct iovec __user *uiov = u64_to_user_ptr(READ_ONCE(sqe->addr));
> -	struct iov_iter iter;
> -	ssize_t ret;
> -
> -	if (sqe->len != FUSE_URING_IOV_SEGS)
> -		return -EINVAL;
> -
> -	/*
> -	 * Direction for buffer access will actually be READ and WRITE,
> -	 * using write for the import should include READ access as well.
> -	 */
> -	ret = import_iovec(WRITE, uiov, FUSE_URING_IOV_SEGS,
> -			   FUSE_URING_IOV_SEGS, &iov, &iter);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
>  static struct fuse_ring_ent *
>  fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  			   struct fuse_ring_queue *queue)
> @@ -1112,40 +1112,44 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  	struct iovec *headers, *payload;
>  	int err;
>  
> +	ent = kzalloc_obj(*ent, GFP_KERNEL_ACCOUNT);
> +	if (!ent)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&ent->list);
> +
> +	ent->queue = queue;
> +
>  	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
>  	if (err) {
>  		pr_info_ratelimited("Failed to get iovec from sqe, err=%d\n",
>  				    err);
> -		return ERR_PTR(err);
> +		goto error;
>  	}
>  
>  	err = -EINVAL;
>  	headers = &iov[FUSE_URING_IOV_HEADERS];
>  	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
>  		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
> -		return ERR_PTR(err);
> +		goto error;
>  	}
>  
>  	payload = &iov[FUSE_URING_IOV_PAYLOAD];
>  	if (payload->iov_len < ring->max_payload_sz) {
>  		pr_info_ratelimited("Invalid req payload len %zu\n",
>  				    payload->iov_len);
> -		return ERR_PTR(err);
> +		goto error;
>  	}
>  
> -	err = -ENOMEM;
> -	ent = kzalloc_obj(*ent, GFP_KERNEL_ACCOUNT);
> -	if (!ent)
> -		return ERR_PTR(err);
> -
> -	INIT_LIST_HEAD(&ent->list);
> -
> -	ent->queue = queue;
>  	ent->headers = headers->iov_base;
>  	ent->payload = payload->iov_base;
>  
>  	atomic_inc(&ring->queue_refs);
>  	return ent;
> +
> +error:
> +	kfree(ent);
> +	return ERR_PTR(err);
>  }
>  
>  /*


