Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066E282F05
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866940; cv=none; b=eWs96PmENCRHbMFZRSqYqJdROM/PutBfxfOQ/Y3rYFX0PSXZqXMNOvkqCgRbwnXk+YczjEts5I08TDgDEyLsyXNNs7QLs//nbuMqwmxytYF6In5FDGHf45eMJN5hA0os1W5a9Ym/3rDT5FD8jtv/WRnWypaWgBuWN6lAb57TZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866940; c=relaxed/simple;
	bh=eeg6dcKyyKVOFChWAP6G4KjdhNiMCoUqDSQQ4D38vro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPmLwjcrtiGl9GsCDw5Q42UCeugYwweXZDymBv7u8zMuHo2Iu7QHnzPaD0dmCoWeJk+sJHpB5OeUiNGI7bTo4pMru2LhHPa8cYe7KCjBfHkhyEgT9F8xdR2Aum2moRdODrjdVPckgKGSyvKfoxBE2ms43PwQa+ySFty7c/z7VxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c4KvKnDX; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c4KvKnDX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779866934; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gKoUHEpj/VBk6dx8EAPy0zj6e5RI4YjlR3Ekv2jWjaI=;
	b=c4KvKnDX6K1kpqsC1/L6klZ2GjY/tmYIbBBulLwYN8hSJiYHyFLxYdFdHJerGtQS4U6VdQwQ1Iy1DdxTgqAxqqQErY3SeaIO/etPML1tA8WViwemdyppDx2/rteuFCdjnGC0rRDXHJM02FSUHONBQcV0enhq8LJsmOslsbBEZws=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3ioJAT_1779866933;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3ioJAT_1779866933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 15:28:53 +0800
Message-ID: <e527915c-f34e-4699-8a5c-4716c4095398@linux.alibaba.com>
Date: Wed, 27 May 2026 15:28:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] fuse: use enum types for header copying
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-5-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Use enum types to identify which part of the header needs to be copied.
> This improves the interface and will simplify both kernel-space and
> user-space header addresses copying when buffer rings are added.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Looks good, feel free to add:

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c | 66 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 53 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 86f9bb94b45a..cca795dd72e1 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -31,6 +31,15 @@ struct fuse_uring_pdu {
>  
>  static const struct fuse_iqueue_ops fuse_io_uring_ops;
>  
> +enum fuse_uring_header_type {
> +	/* struct fuse_in_header / struct fuse_out_header */
> +	FUSE_URING_HEADER_IN_OUT,
> +	/* per op code header */
> +	FUSE_URING_HEADER_OP,
> +	/* struct fuse_uring_ent_in_out header */
> +	FUSE_URING_HEADER_RING_ENT,
> +};
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -575,10 +584,33 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
>  	return err;
>  }
>  
> -static __always_inline int copy_header_to_ring(void __user *ring,
> -					       const void *header,
> -					       size_t header_size)
> +static int ring_header_type_offset(enum fuse_uring_header_type type)
>  {
> +	switch (type) {
> +	case FUSE_URING_HEADER_IN_OUT:
> +		return 0;
> +	case FUSE_URING_HEADER_OP:
> +		return offsetof(struct fuse_uring_req_header, op_in);
> +	case FUSE_URING_HEADER_RING_ENT:
> +		return offsetof(struct fuse_uring_req_header, ring_ent_in_out);
> +	default:
> +		WARN_ONCE(1, "Invalid header type: %d\n", type);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int copy_header_to_ring(struct fuse_ring_ent *ent,
> +			       enum fuse_uring_header_type type,
> +			       const void *header, size_t header_size)
> +{
> +	int offset = ring_header_type_offset(type);
> +	void __user *ring;
> +
> +	if (offset < 0)
> +		return offset;
> +
> +	ring = (void __user *)ent->headers + offset;
> +
>  	if (copy_to_user(ring, header, header_size)) {
>  		pr_info_ratelimited("Copying header to ring failed.\n");
>  		return -EFAULT;
> @@ -587,10 +619,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
>  	return 0;
>  }
>  
> -static __always_inline int copy_header_from_ring(void *header,
> -						 const void __user *ring,
> -						 size_t header_size)
> +static int copy_header_from_ring(struct fuse_ring_ent *ent,
> +				 enum fuse_uring_header_type type, void *header,
> +				 size_t header_size)
>  {
> +	int offset = ring_header_type_offset(type);
> +	const void __user *ring;
> +
> +	if (offset < 0)
> +		return offset;
> +
> +	ring = (void __user *)ent->headers + offset;
> +
>  	if (copy_from_user(header, ring, header_size)) {
>  		pr_info_ratelimited("Copying header from ring failed.\n");
>  		return -EFAULT;
> @@ -609,8 +649,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	int err;
>  	struct fuse_uring_ent_in_out ring_in_out;
>  
> -	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
> -				    sizeof(ring_in_out));
> +	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
> +				    &ring_in_out, sizeof(ring_in_out));
>  	if (err)
>  		return err;
>  
> @@ -661,7 +701,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  		 * Some op code have that as zero size.
>  		 */
>  		if (args->in_args[0].size > 0) {
> -			err = copy_header_to_ring(&ent->headers->op_in,
> +			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
>  						  in_args->value,
>  						  in_args->size);
>  			if (err)
> @@ -681,8 +721,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  	}
>  
>  	ent_in_out.payload_sz = cs.ring.copied_sz;
> -	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
> -				   sizeof(ent_in_out));
> +	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
> +				   &ent_in_out, sizeof(ent_in_out));
>  }
>  
>  static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
> @@ -711,7 +751,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  	}
>  
>  	/* copy fuse_in_header */
> -	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
> +	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
>  				   sizeof(req->in.h));
>  }
>  
> @@ -806,7 +846,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>  	struct fuse_conn *fc = ring->fc;
>  	ssize_t err = 0;
>  
> -	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
> +	err = copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
>  				    sizeof(req->out.h));
>  	if (err) {
>  		req->out.h.error = err;


