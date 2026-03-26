Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A6401A21;
	Thu, 26 Mar 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537989; cv=none; b=pfD5YdSgI8DXPkB6mV/fndxqnTjRfkpGPbQMDZOC+5H77O0Q910lkYl0KjwjCTGKnRRX1fUXDVhuL7EHgDKgGPr8e6bRkzGUzGDum0RnWjDUAFjoHIX0tRidYxEmy85DnEognHZukkhneSxH2EFMtEr51J31hCADLXjexHHj84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537989; c=relaxed/simple;
	bh=mVmQ4buamL9CufMYhH3RJiqIFXt5FPMGBc9kQiDFzL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxst6H546655MtwNq548oj1cW+jBOazsTCdpf9Cu2z7SCaLbM7OIijzHM0MKPSISm+D83CedKULm+oa27ro97Drkors77rcxffeKmmn3xj7KBofID4Zga26mEIOeuE9mqo6X8aa+kCfQFaufDVV59drTHycDXy70rtmZb/dyVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=VD1R1scN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mzQhX6G1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="VD1R1scN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mzQhX6G1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DD86A1D0022D;
	Thu, 26 Mar 2026 11:13:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 11:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774537982;
	 x=1774624382; bh=Ou/96cucP7nN9/BE7ApXhQ8dISR5e2nvQDHb0Dapnrg=; b=
	VD1R1scNswk7O7i6jn0LctkP7yHfyhQe3BARZasy9NdFtYTh0Z802CVdU3OYQI0a
	28vqMnhGWwdXXs8brxOQxBJxhDXXYfBWyUdL6uImGaPr1X7EZEN/1EnYcAMk3ihW
	O0VfU2lUPOwJGj0DoP6NthGkUeWbK2iSZ/quCgiVAV7vg35D06GwcMoz2bpBkn/U
	m0tY9sWcld5USRg1NXRdEBQAhBwXusTfu02yGz/tSBjWMJONxOILzuZJCMKx4nRh
	inQvkfjjYpiZJEELr06etk31sR32M01iZFuxhzNEmcNpzVVRJF51r9K8ZbdMHi2z
	UiJbFA+MGxkDaNCkYkOIFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774537982; x=
	1774624382; bh=Ou/96cucP7nN9/BE7ApXhQ8dISR5e2nvQDHb0Dapnrg=; b=m
	zQhX6G1aG7+/YhgswTypqJVciZDm3vtqgWZIH3kjfabc65z+8BbKfYzaoKh0ZGEY
	Qs+UFAbrVFh8GLu19fvmJNGovZQ7jiT0Eglm72M3JF2DZvV27ZfpzUlWaHmfBoHy
	5b68ztNebkuddaLtbAtjJ6FXmYx4wWUVM4hHfKXXjQfdwLttB2CHcBmj/tqir+Zm
	xd+Nf5AfKMpGxbcrGoYhnuPVibcHOwazBDLfwD2agidwVKBAuvlsgBjg2VM6+SYT
	jXcPHfJqKB+qZAK8P80TLkvPaea9wcXj4xVFradDsdZzC5jCwi/Y7mc0DVISdIkL
	bTDBq/y4Y9PuZmeKWyTkg==
X-ME-Sender: <xms:_kzFaWFyE3NcEuPU8wRL2J5g2P_Y6ReTNx46QGOwjtz4VD4kk_gTcg>
    <xme:_kzFaQpJZOu9cB5YwCRDMCeryc8MQhbyCe5zu2dLKMbLd1ngPxWtYQEfjLIP-eg-k
    UoSqIFSTJ5SdY8OLlTUknVp5EDgp05yH4Qsj6DNPBTRqX7VvJUz5g>
X-ME-Received: <xmr:_kzFaXbk_7p_DUqoSH0aLC4neBdAIas8VtZAK6ZqgkH23_R25hxjr1VfVkmWFBBczndXaZWq05QCi0PWzwENjjadqpj6MhX2TRzKzJFrKYKveFHszQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdrtghomhdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghirhhthhgvlh
    hmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:_kzFaRVpLganWSdBBYuj0bOIlysUdye30mmDxjzoWXTDAOsRqOdUQw>
    <xmx:_kzFaY8SkHe1IjBPxbGjoGc8C3h57WAs-uZMQtVeNqTk3dri5XjpqA>
    <xmx:_kzFaS9lpnVeD6IkszANKv8Ph1acVsD4Uw99TOYnxYTEr1QbGH6usQ>
    <xmx:_kzFaQQrWYvBbNK6D528slndJrcTjjpcYdvMP_Ha4sJR_svYXBc-2Q>
    <xmx:_kzFaSMj_XQkYKSMFGAc_ly8l6QkgRetWxbYZ5dQGQtC_qYb39Hyz8iP>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 11:13:01 -0400 (EDT)
Message-ID: <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
Date: Thu, 26 Mar 2026 16:13:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Christian Brauner <brauner@kernel.org>
Cc: Horst Birthelmer <horst@birthelmer.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
 <20260326-reorganisation-bemessen-c6643edcf629@brauner>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260326-reorganisation-bemessen-c6643edcf629@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/26 15:26, Christian Brauner wrote:
> On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
>>
>>
>> On 3/18/26 14:43, Horst Birthelmer wrote:
>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
>>>
>>> Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
>>> invalidation can arrive while an inode is being initialized, causing
>>> the invalidation to be lost.
>>>
>>> Add a waitqueue to make fuse_reverse_inval_inode() wait when it
>>> encounters an inode with attr_version == 0 (still initializing).
>>> When fuse_change_attributes_common() completes initialization, it
>>> wakes waiting threads.
>>>
>>> This ensures invalidations are properly serialized with inode
>>> initialization, maintaining cache coherency.
>>>
>>> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
>>> ---
>>>  fs/fuse/fuse_i.h | 3 +++
>>>  fs/fuse/inode.c  | 8 ++++++++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 7f16049387d15e869db4be23a93605098588eda9..1be611472eee276371b3bde1a55257c1116cfedd 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -945,6 +945,9 @@ struct fuse_conn {
>>>  	/** Version counter for attribute changes */
>>>  	atomic64_t attr_version;
>>>  
>>> +	/** Waitqueue for attr_version initialization */
>>> +	wait_queue_head_t attr_version_waitq;
>>> +
>>>  	/** Version counter for evict inode */
>>>  	atomic64_t evict_ctr;
>>>  
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index e57b8af06be93ecc29c58864a9c9e99c68e3283b..c6e7e50d80c0edaea57d9342869eaf811786e342 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -246,6 +246,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>>>  		set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
>>>  
>>>  	fi->attr_version = atomic64_inc_return(&fc->attr_version);
>>> +	wake_up_all(&fc->attr_version_waitq);
>>>  	fi->i_time = attr_valid;


While I'm looking at this again, wouldn't it make sense to make this
conditional? Because we wake this queue on every attr change for every
inode. And the conditional in fuse_iget() based on I_NEW?



Thanks,
Bernd
