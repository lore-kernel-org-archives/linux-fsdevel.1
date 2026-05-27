Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA6212F89
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860555; cv=none; b=F08bqqyaxaB2ME4b6ZwudESdbqGyPXEkBpIxcE+GttG0qHFXMpmkaaL+Tpq34adPwcdjk0sEei+Jv3+UFWGzWQ5yr+axWiVIq3XG9e8dmvEVcILTVWo3/fKYM0Qag4PQW91op+VkeCUzWk6+RjwuTFPHOO2rov6TXrtx/8WzFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860555; c=relaxed/simple;
	bh=iAdtTw3CWKjIAtG/NzFKpjGj9zJ1NPonCZPaJqkMleI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ku13N1hRw/W7WzOIfLPoZzq0gDXVvEY6uX/j/js0CfazHkUQKaNp97Wu+XTT/JgCCRzIlTcvggOyZSqevUMG7ZA6Bg3RjdUW7EAzeHD3oieOU3FZaVYD/v93j2xF4br4ghtLpiABY839vt0vHrrvKfOS+7q8V6YQTgTLokMViX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CcO4QA9e; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CcO4QA9e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779860549; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DvZK4dK1qZpRudNGWICsq2qqW9VyC1vwVBsmVQ2uAXM=;
	b=CcO4QA9eoyHIeHpLpSGGuhIOAHTe++LEY34+9HwarnsXHi/2tAmfI7vXopMQu6fhVrDkFA8xH5zOxpUwy4xkd4ydmLBoNafC2rix5qkE1sP6oiF6xuYn1xRplFVPnbyZl298v3Aa/T5JIhxaQZ9bRHgfU+GwybkMaK24I3imdDk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3iLoVx_1779860548;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3iLoVx_1779860548 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 13:42:28 +0800
Message-ID: <87405014-2d50-4ce3-8cb1-6cd2b73f6f5f@linux.alibaba.com>
Date: Wed, 27 May 2026 13:42:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] fuse: refactor io-uring header copying to ring
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-3-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Move header copying to ring logic into a new copy_header_to_ring()
> function. This makes the copy_to_user() logic more clear and centralizes
> error handling / rate-limited logging.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Looks good to me.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 54436d3fda4d..5fc8ca330595 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -575,6 +575,18 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
>  	return err;
>  }
>  
> +static __always_inline int copy_header_to_ring(void __user *ring,
> +					       const void *header,
> +					       size_t header_size)
> +{
> +	if (copy_to_user(ring, header, header_size)) {
> +		pr_info_ratelimited("Copying header to ring failed.\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  				     struct fuse_req *req,
>  				     struct fuse_ring_ent *ent)
> @@ -637,13 +649,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  		 * Some op code have that as zero size.
>  		 */
>  		if (args->in_args[0].size > 0) {
> -			err = copy_to_user(&ent->headers->op_in, in_args->value,
> -					   in_args->size);
> -			if (err) {
> -				pr_info_ratelimited(
> -					"Copying the header failed.\n");
> -				return -EFAULT;
> -			}
> +			err = copy_header_to_ring(&ent->headers->op_in,
> +						  in_args->value,
> +						  in_args->size);
> +			if (err)
> +				return err;
>  		}
>  		in_args++;
>  		num_args--;
> @@ -659,9 +669,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  	}
>  
>  	ent_in_out.payload_sz = cs.ring.copied_sz;
> -	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
> -			   sizeof(ent_in_out));
> -	return err ? -EFAULT : 0;
> +	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
> +				   sizeof(ent_in_out));
>  }
>  
>  static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
> @@ -690,14 +699,8 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  	}
>  
>  	/* copy fuse_in_header */
> -	err = copy_to_user(&ent->headers->in_out, &req->in.h,
> -			   sizeof(req->in.h));
> -	if (err) {
> -		err = -EFAULT;
> -		return err;
> -	}
> -
> -	return 0;
> +	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
> +				   sizeof(req->in.h));
>  }
>  
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,


