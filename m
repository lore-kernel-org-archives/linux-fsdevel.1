Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1B36EAAB;
	Wed,  1 Apr 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062785; cv=none; b=qubD5fXd4aie5Ciaewjd/FWAmxoMznV/pFtbmjkoPHX8royvHwb7mb1h6D4GTkP7fl9wxpK7cr7kO9uYYfuG2JkBhyeIrPA5al0+8DHc79PJppzr+50TQIE8OmvmDwteOMiYrE3vIdL4jgrTLyEcOIWDj0+Irv6fx1Slxf1uqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062785; c=relaxed/simple;
	bh=sOXQXfVo+PIfP/pMhZ5HYN8PGNJrvNwGw2/1ZVc+G30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU4r5Fqh3nQ9DRhhhGDrSRGjOxd2SFD5DmW7YXSK2olReRj7ZMYhQkCRPvRmycs8xEcZ0xkYh7NJKFogALvxEH+7UH0jmBMUHQvvh3qfVGJN/MoeqGWo90uX0B5+vmdjTOhRjvesm4vq3zzJD80i135omKV7Oe1gKNC+ZPAd8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=K+D4WLE5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4UAPmbO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="K+D4WLE5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4UAPmbO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A42197A0268;
	Wed,  1 Apr 2026 12:59:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Apr 2026 12:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775062782;
	 x=1775149182; bh=TFjuuEQKV0U/JpOeMZs/u4MbmKRSMbSnVZzSaOY8DT0=; b=
	K+D4WLE5RAXtDpLafPGDP7e2wPmKaqrlBdBK3N4zNUPLu4lWeaharWuYMQ+mfU7U
	mRtPFlwyevzZk7j76XKDbssoaKp6MYz5UewAa4pB9+ng74BmQ2FWQKb7EZA4Ixw+
	jrqzTR692x7U8dpWb8UfLZ2UBmKGyGinr6quyGKrdIaOFSM7iBNZC6VYwmvxgPZk
	v828FhjXLntaK1Jy6mPMTk90/l0kLaCCE3VKeGKJaPVZxTuMwkeph/1qJWbghPKq
	MXlTBbg35tse0Cvs/ooAIQpOflr4WfhqvSHy5JojLO52weabm7Iw34zDIOu0reAW
	+vrAWvPR2CL4yTbi6yJiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775062782; x=
	1775149182; bh=TFjuuEQKV0U/JpOeMZs/u4MbmKRSMbSnVZzSaOY8DT0=; b=S
	4UAPmbOoE8K0b5Xo+70wPJX5fHSiQgxXK+bilTMWSG2/JBn8vQw7+AQtCZVZvbf/
	CkE0Qzga9hFoNynZEloXLH2LdEqdhiWltOVVMWC+UryqmRlmrA6WuB1iqtoTGVHO
	lvbfrl+VSy+8x0GWZP0C979+dChd5ZGsHZ+Pith+dXtgMbIvQSXDNNgml7PDfTM7
	3GIEoDg1bZPu2Ug7zTld0Qwl5lyPU/AhOe8JzzX65wwmJQ4vMxtuePTUx8rVYvE3
	kka9YNNuHWnOPa2PjCIJonMdfBuhkXzdFvhbK/2nkG+TAIbsyMEbBy/nsO04n01S
	yhwCOYpwcPVwJLnXx0ObQ==
X-ME-Sender: <xms:_U7NaafPwSbG78ff_n_xjhuEVllIk454i_v-UrZQs27mQSUuNt5rMg>
    <xme:_U7NaRUxHxYjK-LIV0xpJ_QB6XahlDOrtXExa-oFZXWnVUyKmOJoaWW3JaeC-bwpX
    ob_pTdBQMxDihPPtrteieI4Dtqg8dsXwzMgXpq900Jx8Nx10vUeAw>
X-ME-Received: <xmr:_U7NaagdueqykHwVRD0LucirSM8bJsluxPZghL3AuRc4x9t7w-nkohQ97m06ekXRAlaYWHsBKvzLtRr8kXIWvfA-x8hjtbiG8xd_frRw6ToUulRIgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueevudeu
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdruggvpdhrtg
    hpthhtoheplhhifigrnhhgsehkhihlihhnohhsrdgtnhdprhgtphhtthhopehmihhklhho
    shesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_U7NaY_Yj55MSNjaxZRvW9Tm5rzwGYesL8l04LGdlcMtJNj7zBqTnA>
    <xmx:_U7NaUbwFF365obJnEcB5cvvIMFfDMWnvUfXekYLn8L25vjjei2SNA>
    <xmx:_U7NaX2MFO-q7KcyIBDRkkHDSo7jUig-Zmewryze22D7gWeSMZ0STQ>
    <xmx:_U7NafaOIQ_D9VzV54DIDyys69xfAw1xvrP6dZqH4jghFxfm4meFJA>
    <xmx:_k7NaZoHhsMqf5YIQSLaDevnBxvQrzLmTWUnTehev8mCEe29dN7UGWid>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 12:59:40 -0400 (EDT)
Message-ID: <b60fa328-e7ab-43fd-895a-d908f72b715c@bsbernd.com>
Date: Wed, 1 Apr 2026 18:59:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Send FORGET over io_uring when ring is ready
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401104008.8827-1-liwang@kylinos.cn>
 <04bfb0c9-a0fc-4825-8c81-8c90774a4bb1@bsbernd.com>
 <ac0f6eN4PFE98diI@fedora.fritz.box>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <ac0f6eN4PFE98diI@fedora.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/26 15:41, Horst Birthelmer wrote:
> On Wed, Apr 01, 2026 at 11:52:28AM +0000, Bernd Schubert wrote:
>>
>>
>> On 4/1/26 10:40, Li Wang wrote:
>>> Once the FUSE io_uring is registered and marked ready, most request
>>> types are delivered through io_uring, while FORGET notifications were still
>>> queued with fuse_dev_queue_forget() and only consumed through the legacy
>>> path on /dev/fuse.
>>>
>>> Deliver single FORGET operations through fuse_uring_queue_fuse_req() when
>>> the ring is ready. Otherwise, fall back to fuse_dev_queue_forget()
>>> so behavior matches the previous implementation.
>>>
>>> Benefits:
>>> - While io-uring is active, the daemon can handle forgets in the same
>>>   commit/fetch loop as other opcodes instead of also draining a separate
>>>   /dev/fuse read path for forget traffic.
>>> - Reduces split-brain transport for high-volume forgets (eviction,
>>>   unmount) when the ring is already the primary channel, which simplifies
>>>   userspace and keeps teardown forgets on the same completion path as
>>>   other uring-backed work.
>>> - Reuses the same per-queue io-uring machinery and noreply/force request
>>>   setup (creds, FR_WAITING/FR_FORCE, etc.) already used for similar
>>>   kernel-initiated traffic.
>>>
>>> Signed-off-by: Li Wang <liwang@kylinos.cn>
>>> ---
>>>  fs/fuse/dev.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++
>>>  fs/fuse/dev_uring.c  |  2 +-
>>>  fs/fuse/fuse_dev_i.h |  4 +++
>>>  3 files changed, 89 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index b212565a78cf..f58abc80fd7b 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -665,6 +665,90 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
>>>  		__set_bit(FR_ASYNC, &req->flags);
>>>  }
>>>  
>>> +#ifdef CONFIG_FUSE_IO_URING
>>> +struct fuse_forget_uring_data {
>>> +	struct fuse_args args;
>>> +	struct fuse_forget_in inarg;
>>> +};
>>> +
>>> +static void fuse_forget_uring_free(struct fuse_mount *fm, struct fuse_args *args,
>>> +				   int error)
>>> +{
>>> +	struct fuse_forget_uring_data *d =
>>> +		container_of(args, struct fuse_forget_uring_data, args);
>>> +
>>> +	kfree(d);
>>> +}
>>> +
>>> +/*
>>> + * Send FUSE_FORGET through the io-uring ring when active; same payload as
>>> + * fuse_read_single_forget(), with userspace committing like any other request.
>>> + */
>>> +void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
>>> +				struct fuse_forget_link *forget)
>>> +{
>>> +	struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
>>> +	struct fuse_mount *fm;
>>> +	struct fuse_req *req;
>>> +	struct fuse_forget_uring_data *d;
>>> +
>>> +	if (!fuse_uring_ready(fc)) {
>>> +		fuse_dev_queue_forget(fiq, forget);
>>> +		return;
>>> +	}
>>> +
>>> +	down_read(&fc->killsb);
>>> +	if (list_empty(&fc->mounts)) {
>>> +		up_read(&fc->killsb);
>>> +		fuse_dev_queue_forget(fiq, forget);
>>> +		return;
>>> +	}
>>> +	fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
>>> +	up_read(&fc->killsb);
>>> +
>>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>>> +	if (!d)
>>> +		goto fallback;
>>> +
>>> +	atomic_inc(&fc->num_waiting);
>>> +	req = fuse_request_alloc(fm, GFP_KERNEL);
>>> +	if (!req) {
>>> +		kfree(d);
>>> +		fuse_drop_waiting(fc);
>>> +		goto fallback;
>>> +	}
>>> +
>>> +	memset(&d->args, 0, sizeof(d->args));
>>> +	d->inarg.nlookup = forget->forget_one.nlookup;
>>> +	d->args.opcode = FUSE_FORGET;
>>> +	d->args.nodeid = forget->forget_one.nodeid;
>>> +	d->args.in_numargs = 1;
>>> +	d->args.in_args[0].size = sizeof(d->inarg);
>>> +	d->args.in_args[0].value = &d->inarg;
>>> +	d->args.force = true;
>>> +	d->args.noreply = true;
>>> +	d->args.end = fuse_forget_uring_free;
>>> +
>>> +	kfree(forget);
>>> +
>>> +	fuse_force_creds(req);
>>> +	__set_bit(FR_WAITING, &req->flags);
>>> +	if (!d->args.abort_on_kill)
>>> +		__set_bit(FR_FORCE, &req->flags);
>>> +	fuse_adjust_compat(fc, &d->args);
>>> +	fuse_args_to_req(req, &d->args);
>>> +	req->in.h.len = sizeof(struct fuse_in_header) +
>>> +		fuse_len_args(req->args->in_numargs,
>>> +			      (struct fuse_arg *)req->args->in_args);
>>> +
>>> +	fuse_uring_queue_fuse_req(fiq, req);
>>> +	return;
>>> +
>>> +fallback:
>>> +	fuse_dev_queue_forget(fiq, forget);
>>> +}
>>> +#endif
>>> +
>>>  ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
>>>  			      struct fuse_mount *fm,
>>>  			      struct fuse_args *args)
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 7b9822e8837b..a96539ea400a 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -1360,7 +1360,7 @@ bool fuse_uring_remove_pending_req(struct fuse_req *req)
>>>  
>>>  static const struct fuse_iqueue_ops fuse_io_uring_ops = {
>>>  	/* should be send over io-uring as enhancement */
>>> -	.send_forget = fuse_dev_queue_forget,
>>> +	.send_forget = fuse_io_uring_send_forget,
>>
>> I will check the other parts more thoroughly in the evening, but please
>> take a look into fuse_uring_register(), it also also overrides other
>> pointers at startup - I would like leave it here as it is, move the
>> function above into dev_uring.c and then update this part in dev_uring.c
>>
>> static const struct fuse_iqueue_ops fuse_io_uring_ops = {
>>         /* should be send over io-uring as enhancement */
>>         .send_forget = fuse_dev_queue_forget,
> 
> Hi Bernd,
> 
> I have never asked the question before, but now I'm a bit intrigued ...
> Why wasn't this not done before? Was it a performance thing?

Hi Horst,

never had a priority for me - I didn't consider it performance relevant.


Cheers,
Bernd
