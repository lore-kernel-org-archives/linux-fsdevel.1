Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BC32D43C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246336; cv=none; b=YP94C1DCNKBJL78XMHGZiB006FWu0G3pHAAtWmsv1FPnGbd67Oi2nWLXw5rNhBB4N02qT6ubmMFBLuqX6DZs7yk1EU6N3jBjtWo5YEq2Vvt/Zn5D8ySgiwj6LrbkoD1S9Pgm25JwTxGGU4cdnrKcKvlGZPkCCCGXlEQ/n037SGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246336; c=relaxed/simple;
	bh=2QHJqOoT8AV/66UcHAf4gzR/WPXbNxYUA88MeqJE24A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPhQFgaMg2uDp+JwLSoR5rb5Fce7wmr2uhchyZqRzFg7kRfoOA4x9IO58DhJ38gfyDWPeIvF3lqigY/5RLfMm82nZFcPOmB5b91ZQMuJ81Dwu07rdDb0lvA0zq7p96c2ZZ84RXdyNTCuwz0JouNbMM7A60hEYKDrLZeXc8zXucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=pyRrEA2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rFeXDrRk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="pyRrEA2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFeXDrRk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30A4C7A0068;
	Wed, 15 Apr 2026 05:45:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 05:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776246334;
	 x=1776332734; bh=ojlm7Gaz1TX0XVXvl8OjUHS9q2Dq9y2hs0cLBnTz+d8=; b=
	pyRrEA2i70udW6rTdV8LDBvV1ePr9gkGK4d4nWoP9ODUgd2n51CVCSKIXD84leTu
	GqyxBmfI8thylh4vZuIeZgV7G/M4CkqwKBa+tSGA5qv4aoHHZ7hZcT4ayWU+eqZa
	7ixXj7twaAdlJtik4MOCO7wsSKpeT9buKEMHRgrg+zb2jsWAB3PgDg8nqIy5xRbY
	iqh1tuIzlCkmDdjRWtS++iXdbnOunmQn7+ywJkZ6zKME+YosX7WlIazWUIlfi8bB
	Pn4025PfD+ffAlkvLSmYVYQFC6VdSXz2iSKzj8zNiFJBth1spWRUUQyaS758gMSi
	vcwVK+Kg9AlpBX6o7dUIFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776246334; x=
	1776332734; bh=ojlm7Gaz1TX0XVXvl8OjUHS9q2Dq9y2hs0cLBnTz+d8=; b=r
	FeXDrRkzh7ZULDq8qc9GE26xPXek5fJaLKncAOLc603By9akOZQDaQs4EWEoK3oR
	l4/3JDUGBA3cktf8MLV1ve/hVzJSe2cfYpyc/DS8nMK/Kk5smiE6oxLj9tA019JB
	+Sc7YH/LVw+znik77HfCgDCHFLfb3W3MTEEXuIpFw/hXUBXkr1945YdoodCyaain
	PAXcltQbyfvtR3emMMauMk7u7CBM5IdDorxa0NOQ9gous2vFbcOzlHfbvTAzI4Ud
	Cfs2dMpssfk6jpeQiArff8R1cTHQktOCKN086YaGZ+YJV731EhKQc9NCa7S50Hd8
	9vxoARcW9FY4qq17zhM7g==
X-ME-Sender: <xms:PV7faSxvpAt3uE81lR25vnCHZlIKNXcZbpJ0kIhEj0DzU10b-IFyBw>
    <xme:PV7faVSeo7gGVJOgrJN_fq4dolyxQ7IcO679dyu2Yl7GtwTOi6Jt5fYwDopdK7m9p
    gafEZtLzQllJrcOCmCYX6pjKsi4e8xVXHWKcjLwa3pjPYN8UoLm>
X-ME-Received: <xmr:PV7faZXvQ9npIUHa-djXRUdAZ8XsU0FxQLASsx0UUdtguWlK9-1Jfto_09Be3ltJodoNOk6RZSRrZXUwL2QNb6UBe7XIPGaVXX4XLxiFHoXs54nLeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegr
    gigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PV7faXbuqHfPhQPPWuoiPrGnoWfKaDncQP_YycEC_Q56cCAVLbdDig>
    <xmx:PV7faf3BNI_8ubDfUqCzDN5Ia_SpaQ217W8EGVZVglPHmxHUwu5kWw>
    <xmx:PV7faZg0kukDrCTm8WYAFmFrmtBkwDvZPc3vPfAuPEj3OkQCYK-L_w>
    <xmx:PV7faTYIjKKA-n2SmWOFEoQLAtqHKWASVJHZSACQqW2jFAoFq0yytg>
    <xmx:Pl7faWs7sIXnn3xqJXJtyQG8EWpQ1jrXZC3SkeuZ-5jRUK8qIr0wmX-w>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 05:45:32 -0400 (EDT)
Message-ID: <3b5f8117-c111-43f8-b2cb-f49963470295@bsbernd.com>
Date: Wed, 15 Apr 2026 11:45:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] fuse: rearrange io-uring iovec and ent
 allocation logic
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-10-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260402162840.2989717-10-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Move fuse_uring_get_iovec_from_sqe() to earlier in the file and
> move the allocation logic in fuse_uring_create_ring_ent() to the
> beginning of the function.
> 
> There is no change in logic, this is done to make the subsequent commit
> that adds buffer rings easier to review.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
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

Hmm, goal was to first do the checks and then to allocate, but if the
change is useful for future commits, fine with me.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>


