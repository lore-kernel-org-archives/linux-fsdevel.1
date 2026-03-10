Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2E3C3444
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160270; cv=none; b=QOdEqJOADNtydNs81WXGeESVuJEHa4Xxf4u/rwvHahkcbp/DXUQZdZ6sXk9Ieuy2qJfnIGhUarNH4rpJOhCYfunRMYkvqJfGqT698uetNEc1UvxAPmm6xiRmE7ehlJwRyhDQQi0ITBPFjAWixLM1R0TkCB5JjjzLnNKDBF1LkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160270; c=relaxed/simple;
	bh=PQTqoCJjk0lneizbIhGF9KlWzolB9bZPFJGUs9pvjS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oev6nk2AfGcy7lrJDpUXs23KXFs8/4FGkXZVPZDyBq+VwhsqFX+AP2Ejw3sPikrRkFJ58Ua4zm+nsqudHbA4HXM9pvwWKtuFgegrOS2pihgKuKi92EoTre53G9jpllvmYqJOs027f0rm3o+NY2bOVfBExcQ1jgLuI3QnfObaEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=MyFqa5+u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Au8cte4M; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="MyFqa5+u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Au8cte4M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 00E9BEC0B63;
	Tue, 10 Mar 2026 12:31:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 12:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1773160267;
	 x=1773246667; bh=nvawYitOGOJ+hGGJ6c/DLT5eQLrE7tR2r47BYSvk1CQ=; b=
	MyFqa5+u/FRT0KJ79XaLKjf/76x2r59QZAAGE1JCiu8LDjLaByPsV3s06oRYHhpO
	+Ay5tkkwnYa2qvGyeudy1mjAND2oSYfLPRykTxmC2NCbV8YZK9HsyPsrCeY92ASb
	0CZ21B2qRTAYEnAXxPaprkOMvraNTp4knwXD3uWVGZrUsFDLoOGjDtO0jplfkGFf
	gbIYKCgwvXxWM8b9DKJdltWXq0uuZX0ewvBkIUBRj/4QyU/oFFPprrAdYJM7MZDP
	KKDd0Msmyw0eNftVzALO/VjOLg7nKiN+8hv3JUYcqmdL8m3xBh8F6huJmSFb5drh
	vnJY4YQUWbK4KthG/TtoUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773160267; x=
	1773246667; bh=nvawYitOGOJ+hGGJ6c/DLT5eQLrE7tR2r47BYSvk1CQ=; b=A
	u8cte4Mv3K+FzfF8srB9Qh9JlPoctOVKDr58SeccxrHPJheUbA7uk9Dbt75DyjqL
	0+xDbi7oHchXVhv/jypz7Vwbr/wTAVlaviRZIWFw+7lCLudpgg5gvpji+XB1q6Xl
	hVHplVu3N1igW3yLAzaajSHhhdtr5l4P/DHrzZYE0JMzYg1KzzKRrfTAGSuHRdtN
	faoYVBChxXXLl4sewB3/EhJ1Bicg/+T4C0snqg/9WMJHKcKBHGS+RigpSVdX7gOp
	iePYDqOfNENZZhFuJCxNduI6wFS1RcjC2tlGpSe7JWXYKAQOsQulR8ley/5ZuBBg
	4gNmvz7qNM4gTfHh5N4JQ==
X-ME-Sender: <xms:S0ewaTdPCOqzHEerrA8aNQsXgzbfMV6f6mib1f04FjQgsa-Arh0D3A>
    <xme:S0ewaQocO4ecpQS5h-9aGprebeKS-cDz0TSQOzNwHmoFYVD3PgjPCpss4_T_AM8pN
    RfxrOyit4_eiYGmxe_NEuhUrrOosT7JJhLUBr9quIXW0Cii07sI>
X-ME-Received: <xmr:S0ewaZ70EWmLSjyOVv6tBDLRtpZKtVSSxAsBv-Ij5y_hSnuQlAFsbmsqi4Cjy1VxFr16olYeHwjGSFn_ttfCTffKCGvUfSHQ-owzc-qhty4LBvBtSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlihifrghngheskhihlhhinhhoshdrtghnpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S0ewaeqe3UxWxWLStE_6s4cmyaBsZi-0pTmQFha0V_gLzbHYPTmKGA>
    <xmx:S0ewaThhPK0KaCYjYuDc2uujCpoXrwN88-atNnXOAGSquvRUvZPq8Q>
    <xmx:S0ewaQI2PzwGOu0Ly-Xo8bpPROCxSDjujPZJN4yXcQYf6H2ONqvZFw>
    <xmx:S0ewabDUGmXwXpqKHy73qSKc5tpJ08yfYFgRzm-s66lxX2WMQywKJA>
    <xmx:S0ewaQel-_cav9rXPXTDD-70cEgphNx6ZcGrndzQkPMBbNbmvI5yJgzN>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 12:31:06 -0400 (EDT)
Message-ID: <eae6aa8a-9550-4c82-9b77-12642af62cff@bsbernd.com>
Date: Tue, 10 Mar 2026 17:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: rename confusing ring->max_payload_sz
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20260305123511.4222-1-liwang@kylinos.cn>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260305123511.4222-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/26 13:35, Li Wang wrote:
> In the fuse_uring_create_ring_ent function of dev_uring.c,
> when payload_size < ring->max_payload_sz, it reports an error,
> which is confusing because  ring->max_payload_sz feels like
> it should represent the allowed upper limit. Therefore, rename it
> to indicate the maximum possible payload size of the fuse requests.
> 
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev_uring.c   | 14 +++++++-------
>  fs/fuse/dev_uring_i.h |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 3a38b61aac26..9afa0c7cf92a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -229,7 +229,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  	struct fuse_ring *ring;
>  	size_t nr_queues = num_possible_cpus();
>  	struct fuse_ring *res = NULL;
> -	size_t max_payload_size;
> +	size_t max_req_payload_size;
>  
>  	ring = kzalloc_obj(*fc->ring, GFP_KERNEL_ACCOUNT);
>  	if (!ring)
> @@ -240,8 +240,8 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  	if (!ring->queues)
>  		goto out_err;
>  
> -	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
> -	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
> +	max_req_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
> +	max_req_payload_size = max(max_req_payload_size, fc->max_pages * PAGE_SIZE);
>  
>  	spin_lock(&fc->lock);
>  	if (fc->ring) {
> @@ -255,7 +255,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  
>  	ring->nr_queues = nr_queues;
>  	ring->fc = fc;
> -	ring->max_payload_sz = max_payload_size;
> +	ring->max_req_payload_sz = max_req_payload_size;
>  	smp_store_release(&fc->ring, ring);
>  
>  	spin_unlock(&fc->lock);
> @@ -590,7 +590,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	if (err)
>  		return -EFAULT;
>  
> -	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
> +	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_req_payload_sz,
>  			  &iter);
>  	if (err)
>  		return err;
> @@ -621,7 +621,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  		.commit_id = req->in.h.unique,
>  	};
>  
> -	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
> +	err = import_ubuf(ITER_DEST, ent->payload, ring->max_req_payload_sz, &iter);
>  	if (err) {
>  		pr_info_ratelimited("fuse: Import of user buffer failed\n");
>  		return err;
> @@ -1056,7 +1056,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  	}
>  
>  	payload_size = iov[1].iov_len;
> -	if (payload_size < ring->max_payload_sz) {
> +	if (payload_size < ring->max_req_payload_sz) {
>  		pr_info_ratelimited("Invalid req payload len %zu\n",
>  				    payload_size);
>  		return ERR_PTR(err);
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..544f7afb3866 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -112,8 +112,8 @@ struct fuse_ring {
>  	/* number of ring queues */
>  	size_t nr_queues;
>  
> -	/* maximum payload/arg size */
> -	size_t max_payload_sz;
> +	/* maximum request payload/arg size */
> +	size_t max_req_payload_sz;
>  
>  	struct fuse_ring_queue **queues;
>  

I don't have a strong opinion here, wouldn't be sufficient to update the
comment?


Thanks,
Bernd

