Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB43CD8AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868486; cv=none; b=Hy2vjJID5j7EXJFFZ3zelMuJLqeTZKu6LO7N3Nqdtu9bdgq12EQ81pKCAdLu892lxECuIsnjGIlNGqcdQYcY/LwVdaL8XOzbahfPfIoIBC1IM6vQoBfXIY3UZM/bDYu+cUM/f+UMvfTnXMPl9/V0D4hKD8poVaDYCNH/QZiUatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868486; c=relaxed/simple;
	bh=babPemdtRbs/YFH6/6i8Wf5xeR/Xwm5FUjnFOVeOYts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrsuOkFiCZCA5OoCb0WWwwgmkbbfVZFR4zjvgDUmy1jcHqD+FwJlJ38lLYetg59YBA6maPBDo+7UeI5AiIStGNVD6EGFMb0m9ta2J3J/PGaC+9yOeWdixvPyUmVGTzIZUF0TImM0G3WSwPhJkCTNw5AGloX07+dZqWGy0IEYAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YsTdfw09; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YsTdfw09"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779868481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IHYNoIg2n66NIMX7y6DAVNRBVr43HOJ/Woi8RnHmmBM=;
	b=YsTdfw09joMhRdgcr9EW7GMljmx6JEQSFYmSEm5L0pAtMBiTPIr7krpbGasOwhbu2JDAvbN1dCUp1qvQqZXvr0n/7KGGcBnKrGgBB6Y7RykwNdaNKf88/B+G8Oclocq/xU9kCrAKz39hqNLBVL5+GsMwhOB5NwUV1e7svYit9LQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3ipCuR_1779868480;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3ipCuR_1779868480 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 15:54:40 +0800
Message-ID: <768a888f-6e3b-449c-8f39-c6032973b229@linux.alibaba.com>
Date: Wed, 27 May 2026 15:54:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] fuse: refactor setting up copy state for payload
 copying
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-6-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-6-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Add a new helper function setup_fuse_copy_state() to contain the logic
> for setting up the copy state for payload copying.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Looks good to me.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index cca795dd72e1..045394a7ae41 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -639,6 +639,27 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
>  	return 0;
>  }
>  
> +static int setup_fuse_copy_state(struct fuse_copy_state *cs,
> +				 struct fuse_ring *ring, struct fuse_req *req,
> +				 struct fuse_ring_ent *ent, int dir,
> +				 struct iov_iter *iter)
> +{
> +	int err;
> +
> +	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
> +	if (err) {
> +		pr_info_ratelimited("fuse: Import of user buffer failed\n");
> +		return err;
> +	}
> +
> +	fuse_copy_init(cs, dir == ITER_DEST, iter);
> +
> +	cs->is_uring = true;
> +	cs->req = req;
> +
> +	return 0;
> +}
> +
>  static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  				     struct fuse_req *req,
>  				     struct fuse_ring_ent *ent)
> @@ -654,15 +675,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	if (err)
>  		return err;
>  
> -	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
> -			  &iter);
> +	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
>  	if (err)
>  		return err;
>  
> -	fuse_copy_init(&cs, false, &iter);
> -	cs.is_uring = true;
> -	cs.req = req;
> -
>  	err = fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
>  	fuse_copy_finish(&cs);
>  	return err;
> @@ -685,15 +701,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  		.commit_id = req->in.h.unique,
>  	};
>  
> -	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
> -	if (err) {
> -		pr_info_ratelimited("fuse: Import of user buffer failed\n");
> +	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
> +	if (err)
>  		return err;
> -	}
> -
> -	fuse_copy_init(&cs, true, &iter);
> -	cs.is_uring = true;
> -	cs.req = req;
>  
>  	if (num_args > 0) {
>  		/*


