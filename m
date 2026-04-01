Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBA3FA5FF;
	Wed,  1 Apr 2026 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044353; cv=none; b=VZl689HLmPp+nAP0ct85JtI/9Y8XFR4ylfwMmi5Bd2WA4kpRb+2nc1p/DI1pj6Zv6qmNgiiMAngE37hxow4d+oC7LA0E65vpOWFEbLq3dlZQv8CVFE30FPayY8x4SqIMjXBV+90QunYfb9/0ufcnxxownLajCXt6Zf2ux0vdzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044353; c=relaxed/simple;
	bh=WslNl4OiretUN9G2ceRIvTEpw6vvGoNs3kl6ksKQ9WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsV1/pV1DKnZr4hg/J0L+E5/MaTt1UD+F92dzc3BXiSN2I8wDUu9UoW+WcjtgXUT3OfEo2aCisYsKZD1SypqIi6A3jNA6jSqnMLG+6nWRibS7edBtGxDXO0ppF3NFPE4z79IyvH7c5SzhLwRW8HCIYzXnO9IjyXzfFvzbSOyI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=cc9690gJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RoDrPPin; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="cc9690gJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RoDrPPin"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 608E07A025A;
	Wed,  1 Apr 2026 07:52:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 01 Apr 2026 07:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775044350;
	 x=1775130750; bh=4eE6qChNxRd9aouHV3pr0aKXK5Kc8VfngYYUq9OsxXs=; b=
	cc9690gJxVDh5gH1h/WKxVHKqKhw4oYuuy9AZAqSOvtXaO3aFHQjJwv4vn1m9jgW
	3T8FYmKInwYUCN2q3ZJmJ6ZLcIeH5+XpS0k2tOFemMQgILkzkr5FGVmOLYpjYgBP
	uwg3BVLrigpKC9W0f96SvqLe2TNThvWG8BKZWv/lcGUPieqBWQQuxLfVzrLZAh0D
	cgu8EGNjceDv4sAPJloWi2LXWmJ99UXf/lVejskfqxthC0U69dNq+/SwDTeIi5Nh
	KjeYPMZ4xWPI5zRTqoycYee5Ghto/7XaGC/x5Xl71iWsRY2BkPo7yGzxAur0xXke
	tk2tHcKe2XjyGyxuV+mAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775044350; x=
	1775130750; bh=4eE6qChNxRd9aouHV3pr0aKXK5Kc8VfngYYUq9OsxXs=; b=R
	oDrPPinH64nfttbFc+aY+scJg/hGlvIihI8ZkA599FriCD38MrL3YK6bv5DXnudI
	wqAujoF+/omfbhswudoeOGMPK0HxYkgzau+DRR5OZlm0EisBV3Pm0lHGPIUZn6Vz
	hGzAzoiosXKPIDiWGXJfTXjsUlq3kUziFgVrSD7Ojzfq+weYWGw6926MRfaFZCJP
	60OMXcfyfjnqCjR2WTsJwNHPZJVEsjiQCBy+26y4N8OBbojTaHhNKN1DG5H8hxgH
	D8feAKMEOGJxbAB9Nso38vEZDkD7fTqNKJ1srFFGVPzVoGtC50hrhxlWnvNnd0Aq
	vjWRB1qdDPR5yPCyjq4Ag==
X-ME-Sender: <xms:_QbNaY_RBArmVDPAUm9Fg7DZ2jf3Ihny8RMS7Pxp0Rz7LipJhPwWgQ>
    <xme:_QbNaejBR6MFs096GJikCBUO7PVjrW2_Bp4cC9CDA8Mhqo0kq9vMZ6SOSJvrwIkjS
    H-_uiYHdAR2g4t67Lbpt02ArWf6BFIDZJVXcsSCLmAwetMZGshU>
X-ME-Received: <xmr:_QbNaYc15ZwrEz42RHKk7oug9oYPjMvBI5wol5dIl0ubYzAe02lUxHs65ICFC7BWmGT54kPQc_5PHj_MKomAdleou3Pnz6LdFuSjq0YOtI9dNH97NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueevudeu
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihifrghngheskhihlhhinhhoshdrtghnpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_QbNaVpiuXTQcnuDbacc8T6GsysLRqeXLIuTDXILFnwDA94H8O361Q>
    <xmx:_QbNadDPLoCSjenkLWiRjD9xpDt5GodXjOk6Bg3LUu_rC7HlpAAj1Q>
    <xmx:_QbNaSZCkLGzF7A3qVguwVhYUikVyECE7Z7RNxN-LzajPz8j0UXVtQ>
    <xmx:_QbNaQ7h9MdepIdYo8iQCCfPvI6fuISdtymEDSSW47YO-J8c4VENgQ>
    <xmx:_gbNaYfgWMOTDzPgwtXnRDZhl1bqMMpGIWlz3_kVNkhHnBuDTUTgkFYs>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 07:52:28 -0400 (EDT)
Message-ID: <04bfb0c9-a0fc-4825-8c81-8c90774a4bb1@bsbernd.com>
Date: Wed, 1 Apr 2026 11:52:28 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Send FORGET over io_uring when ring is ready
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401104008.8827-1-liwang@kylinos.cn>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260401104008.8827-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/26 10:40, Li Wang wrote:
> Once the FUSE io_uring is registered and marked ready, most request
> types are delivered through io_uring, while FORGET notifications were still
> queued with fuse_dev_queue_forget() and only consumed through the legacy
> path on /dev/fuse.
> 
> Deliver single FORGET operations through fuse_uring_queue_fuse_req() when
> the ring is ready. Otherwise, fall back to fuse_dev_queue_forget()
> so behavior matches the previous implementation.
> 
> Benefits:
> - While io-uring is active, the daemon can handle forgets in the same
>   commit/fetch loop as other opcodes instead of also draining a separate
>   /dev/fuse read path for forget traffic.
> - Reduces split-brain transport for high-volume forgets (eviction,
>   unmount) when the ring is already the primary channel, which simplifies
>   userspace and keeps teardown forgets on the same completion path as
>   other uring-backed work.
> - Reuses the same per-queue io-uring machinery and noreply/force request
>   setup (creds, FR_WAITING/FR_FORCE, etc.) already used for similar
>   kernel-initiated traffic.
> 
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dev_uring.c  |  2 +-
>  fs/fuse/fuse_dev_i.h |  4 +++
>  3 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index b212565a78cf..f58abc80fd7b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -665,6 +665,90 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
>  		__set_bit(FR_ASYNC, &req->flags);
>  }
>  
> +#ifdef CONFIG_FUSE_IO_URING
> +struct fuse_forget_uring_data {
> +	struct fuse_args args;
> +	struct fuse_forget_in inarg;
> +};
> +
> +static void fuse_forget_uring_free(struct fuse_mount *fm, struct fuse_args *args,
> +				   int error)
> +{
> +	struct fuse_forget_uring_data *d =
> +		container_of(args, struct fuse_forget_uring_data, args);
> +
> +	kfree(d);
> +}
> +
> +/*
> + * Send FUSE_FORGET through the io-uring ring when active; same payload as
> + * fuse_read_single_forget(), with userspace committing like any other request.
> + */
> +void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
> +				struct fuse_forget_link *forget)
> +{
> +	struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
> +	struct fuse_mount *fm;
> +	struct fuse_req *req;
> +	struct fuse_forget_uring_data *d;
> +
> +	if (!fuse_uring_ready(fc)) {
> +		fuse_dev_queue_forget(fiq, forget);
> +		return;
> +	}
> +
> +	down_read(&fc->killsb);
> +	if (list_empty(&fc->mounts)) {
> +		up_read(&fc->killsb);
> +		fuse_dev_queue_forget(fiq, forget);
> +		return;
> +	}
> +	fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
> +	up_read(&fc->killsb);
> +
> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		goto fallback;
> +
> +	atomic_inc(&fc->num_waiting);
> +	req = fuse_request_alloc(fm, GFP_KERNEL);
> +	if (!req) {
> +		kfree(d);
> +		fuse_drop_waiting(fc);
> +		goto fallback;
> +	}
> +
> +	memset(&d->args, 0, sizeof(d->args));
> +	d->inarg.nlookup = forget->forget_one.nlookup;
> +	d->args.opcode = FUSE_FORGET;
> +	d->args.nodeid = forget->forget_one.nodeid;
> +	d->args.in_numargs = 1;
> +	d->args.in_args[0].size = sizeof(d->inarg);
> +	d->args.in_args[0].value = &d->inarg;
> +	d->args.force = true;
> +	d->args.noreply = true;
> +	d->args.end = fuse_forget_uring_free;
> +
> +	kfree(forget);
> +
> +	fuse_force_creds(req);
> +	__set_bit(FR_WAITING, &req->flags);
> +	if (!d->args.abort_on_kill)
> +		__set_bit(FR_FORCE, &req->flags);
> +	fuse_adjust_compat(fc, &d->args);
> +	fuse_args_to_req(req, &d->args);
> +	req->in.h.len = sizeof(struct fuse_in_header) +
> +		fuse_len_args(req->args->in_numargs,
> +			      (struct fuse_arg *)req->args->in_args);
> +
> +	fuse_uring_queue_fuse_req(fiq, req);
> +	return;
> +
> +fallback:
> +	fuse_dev_queue_forget(fiq, forget);
> +}
> +#endif
> +
>  ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
>  			      struct fuse_mount *fm,
>  			      struct fuse_args *args)
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 7b9822e8837b..a96539ea400a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1360,7 +1360,7 @@ bool fuse_uring_remove_pending_req(struct fuse_req *req)
>  
>  static const struct fuse_iqueue_ops fuse_io_uring_ops = {
>  	/* should be send over io-uring as enhancement */
> -	.send_forget = fuse_dev_queue_forget,
> +	.send_forget = fuse_io_uring_send_forget,

I will check the other parts more thoroughly in the evening, but please
take a look into fuse_uring_register(), it also also overrides other
pointers at startup - I would like leave it here as it is, move the
function above into dev_uring.c and then update this part in dev_uring.c

static const struct fuse_iqueue_ops fuse_io_uring_ops = {
        /* should be send over io-uring as enhancement */
        .send_forget = fuse_dev_queue_forget,


Thanks,
Bernd
