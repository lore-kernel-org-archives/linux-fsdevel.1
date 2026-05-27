Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8BD397E89
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864626; cv=none; b=OaFpWecSaDkL2r26AXq3BtfCRihXLW6OYGwvwyIWKT6mgeTwZFRP6DGHs/ndZ3i2KQ9+ekUn5mG4booFq3IlRxWNPgncOmOlhPI/oEBkQ9Tn2qbLhjA4vaZ5XN9PMWazpilgZHnD220d9WbF+X4nYjhi5BWu7NlmtMQYWHnHT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864626; c=relaxed/simple;
	bh=ADPN6lgTLKGxNcIx0qBzQGdT6zeOkbOdu5Q+lqvI0O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGF420LP9rBH8yas2JUcQAWX9gNdL4CkwCaWgIb9kCTq7U7QEKEYKpt3wUlxaS1H1fisG+lbnKQag2pB0yvXceipS1QkBzbtkVizxBjxiqTWJXb/9dhcdyBogh8sV3R+fgOkyN0hAQV0W8zDMNR8+C8hkV5l9QeV6DRHAfU4Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ir5hFru0; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ir5hFru0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779864620; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GIS0oO7lD1ORTtkXKzbV7KJKy0Gq6EWiMoM18p/usCA=;
	b=Ir5hFru0LNNwJ0MC50n3nrlGJsHec7Y4dapjez2nxxloAdi7O2C/1VNuLObb+dsix5eo1DakL7bSEQWdd+1Y9yKE3WwSImJlMFTLlEW4yWjDG08eq3Wj6xQU5cp3gn2Mpb/kKRel4vTHdx74cAVQhIJ9CtPzG1qWq/7oxIACDmI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3ie4Xl_1779864618;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3ie4Xl_1779864618 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 14:50:19 +0800
Message-ID: <a3c55dc5-5373-4935-8f88-96430cbbf893@linux.alibaba.com>
Date: Wed, 27 May 2026 14:50:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] fuse: refactor io-uring header copying from ring
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-4-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Move header copying from ring logic into a new copy_header_from_ring()
> function. This makes the copy_from_user() logic more clear and
> centralizes error handling / rate-limited logging.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Looks good! Just two nits below.

Side note: since copy_from_user() returns the number of uncopied bytes,
this also fixes a latent path that could surface a positive errno to
userspace:

    fuse_uring_commit
      copy_from_user returns non-zero
      fuse_uring_req_end
        req->out.h.error = error

Either way, feel free to add:

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5fc8ca330595..86f9bb94b45a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -587,6 +587,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
>  	return 0;
>  }
>  
> +static __always_inline int copy_header_from_ring(void *header,
> +						 const void __user *ring,
> +						 size_t header_size)
> +{
> +	if (copy_from_user(header, ring, header_size)) {
> +		pr_info_ratelimited("Copying header from ring failed.\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  				     struct fuse_req *req,
>  				     struct fuse_ring_ent *ent)
> @@ -597,10 +609,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	int err;
>  	struct fuse_uring_ent_in_out ring_in_out;
>  
> -	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
> -			     sizeof(ring_in_out));
> +	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
> +				    sizeof(ring_in_out));
>  	if (err)
> -		return -EFAULT;
> +		return err;
>  
>  	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
>  			  &iter);
> @@ -794,10 +806,10 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>  	struct fuse_conn *fc = ring->fc;
>  	ssize_t err = 0;

Unnecessary initialization - plain "ssize_t err;" is enough.

>  
> -	err = copy_from_user(&req->out.h, &ent->headers->in_out,
> -			     sizeof(req->out.h));
> +	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
> +				    sizeof(req->out.h));
>  	if (err) {
> -		req->out.h.error = -EFAULT;
> +		req->out.h.error = err;
>  		goto out;
>  	}
>
The assignment to req->out.h.error here can be dropped -
fuse_request_end() will set it again from the 'error' argument.


Cheers,
Baokun

