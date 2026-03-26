Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B53328E6;
	Thu, 26 Mar 2026 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552490; cv=none; b=fTY9z5GQhnlXWOf5yZEflycOJUbfbq3OQjXxRWpH4J8trXMnhuMmNgAlgKrch3S2ZSUo++A4koQZRXW1T8Hlkldhq/V9WA9Zd55QOfjd6CULm2E2mNpVIH6xamgbDGxrKxYfjTxOR2Ef8IgfSLmreBuVY3YbdRnD7t3WTecjTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552490; c=relaxed/simple;
	bh=t2eDkTyMHKDuHdZYfjjKTndlqhKWWoG4nM243E+ZzCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRGCLis+Yn1BP/79HSfZLwpN6A8dGhvjT402Rk0tLDGIjTxJeqLQm6VDpzDvbAmLrobh5oRq1AD7yhB65yQ33O/MQ7J0zSoRJEl5ghluZDD/OAVjYqaoXSrod9ftjCSfZJ8aPelCS8hPZ2EhmzKdkoJ+yYHr3mhz3LHn88RJroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dFmdFcLp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHw8FbBP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dFmdFcLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHw8FbBP"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CC8414001B8;
	Thu, 26 Mar 2026 15:14:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Mar 2026 15:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774552487;
	 x=1774638887; bh=AZHfOEHn3YxuW5J2Q6FCZ3MHPiRB6dS20+LKG0o5/0w=; b=
	dFmdFcLp4iLXOh+e5zpzbXLKoXOAXHUmfroDVlfQjjHi8ggNahi4/5TIWnWFYGo7
	8xLb1hSVjiXG5GWtO2gTpbxNBEpBKYNB6vbxFqr1LEp6tovGkgP697z7IkrcpmL4
	nebtkuWzP5MdKsBcrDFmzEuYknJ0Dnb35gWIdNf97yO1SzqXrFuHDxDZBz87H2Nv
	akT6ftts4Y0aAR6CJxyuuEdb/LN4tOaRexkdvEU42j1DIDKbbNfegNw6MnvtUy01
	AqwCT2S0FK81GuBlJ3jvSac7Exppx9I3DqzazWfEc8F8ewfhOFXCbTYMP5xMXRQc
	fV7TtIsL9vnzCx8Ubd76Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774552487; x=
	1774638887; bh=AZHfOEHn3YxuW5J2Q6FCZ3MHPiRB6dS20+LKG0o5/0w=; b=F
	Hw8FbBPxNj6HadWnWBlGe/gGo7gacXjPqfxTFtXGhQOzVKSYj25alzwdbFMvR68B
	1mYoNNwWn/2Up0jGyUbVe6wARQZRBMfIfFW+QUNzO4dp2rPpK9yfxWm/UJ5sTOEC
	/w7Bsi7c3PHX67PzORjTSNWxE8xK5VaugCkYnX8+IaHdoslg6jfIYoSVhDB9atGD
	0uAZvsuYtq+YBW6Phs6yGKOIcX0v7P0n5XDTHDMwJ5we1i82q4sFlpwF70oRIWKi
	uznjlsXZuG29ls3ibWFVnzi+POKjPtP1hrDUpboxm9PgEFSCJCMB3VuafxOU6wPK
	l+3xiLcLrTMQmMQ5/BcOg==
X-ME-Sender: <xms:poXFacevBfZKjc9kI7AVloErx7H8F4eGYypSqrxP7Bn2msbKv8NRAQ>
    <xme:poXFaYO_te7TE01KpA6HwjdIfxz29WW8wZVcRt3JV02H1qp9sMSKX45kgxTAXBSH5
    WSEqXbemZntrK2giVFPjST5AG0NIn3HN_qOOHgD9hdJYvXCdcfB>
X-ME-Received: <xmr:poXFaULLdDyCu47ZvrijuzDW5YlIziqIdJLuYR0670kAT-CmAXNq_eGNzBhWVZAuWaHePmL4U-mt-kecEo-xDY-ldsEh_fO4KsD4zAgH7-D0wtAvEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdruggvpdhrtghpthht
    ohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhgsihhrthhhvghlmhgvrhesuggunhdrtghomh
X-ME-Proxy: <xmx:poXFaQLV5ynLUeHZ0xdUzeZzONrMyoyojwDQt7UNRjbTeijETvRbJA>
    <xmx:poXFaW7OsL0rTvNfqoFlqsAp5oFjeU1PsqKicm1yI1Dsh1cxw-A38Q>
    <xmx:poXFaSeZ2oGdZXRfK1DzsRmhMxn95PST46VE3sq51LAitNhhvmbWYQ>
    <xmx:poXFaZEUvjjCK0ijz9B7mkuz84DLFx4h8qsLRy7AJygIOpFZ_8aMRg>
    <xmx:p4XFaSVrrGhOMO3iGEUZCw7xsoCz0MW5Gc_einenrqc4qhyZr-FOfL0b>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 15:14:45 -0400 (EDT)
Message-ID: <daca8058-cec5-456d-8c15-cc6fa0d5468d@bsbernd.com>
Date: Thu, 26 Mar 2026 20:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Miklos Szeredi
 <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Horst Birthelmer <horst@birthelmer.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
 <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
 <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
 <acVUeX54PDFfApI2@fedora>
 <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>
 <acVxb0TSSUgHsK5T@fedora>
 <CAJnrk1ax2bK-FQXDEc=OGvYS7YvCvL3YsKWv1gmzwkS_QSz+fw@mail.gmail.com>
 <7b4e01e0-57ea-4bee-8f96-c17a9bf64d0b@bsbernd.com>
 <CAJnrk1ZYaHYXO=cjT_pHMqC4Z-+Uf=vVTYeBWG8fYs2JZkdXQw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZYaHYXO=cjT_pHMqC4Z-+Uf=vVTYeBWG8fYs2JZkdXQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/26 20:00, Joanne Koong wrote:
> On Thu, Mar 26, 2026 at 11:16 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>> On 3/26/26 19:00, Joanne Koong wrote:
>>> On Thu, Mar 26, 2026 at 10:54 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>
>>>> On Thu, Mar 26, 2026 at 09:43:00AM -0700, Joanne Koong wrote:
>>>>> On Thu, Mar 26, 2026 at 8:48 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>>>
>>>>>> On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
>>>>>>> On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3/26/26 15:26, Christian Brauner wrote:
>>>>>>>>> On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 3/18/26 14:43, Horst Birthelmer wrote:
>>>>>>>>>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
>>>>>>>
>>>>>>>>>>>     fi->attr_version = atomic64_inc_return(&fc->attr_version);
>>>>>>>>>>> +   wake_up_all(&fc->attr_version_waitq);
>>>>>>>>>>>     fi->i_time = attr_valid;
>>>>>>>>
>>>>>>>>
>>>>>>>> While I'm looking at this again, wouldn't it make sense to make this
>>>>>>>> conditional? Because we wake this queue on every attr change for every
>>>>>>>> inode. And the conditional in fuse_iget() based on I_NEW?
>>>>>>>
>>>>>>> Right, should only wake if fi->attr_version old value was zero.
>>>>>>>
>>>>>>> BTW I have a hunch that there are better solutions, but it's simple
>>>>>>> enough as a stopgap measure.
>>>>>>
>>>>>> OK, I'll send a new version.
>>>>>>
>>>>>> Just out of curiosity, what would be a better solution?
>>>>>
>>>>> I'm probably missing something here but why can't we just call the
>>>>>
>>>>>         fi = get_fuse_inode(inode);
>>>>>         spin_lock(&fi->lock);
>>>>>         fi->nlookup++;
>>>>>         spin_unlock(&fi->lock);
>>>>>         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
>>>>>                                  evict_ctr);
>>>>>
>>>>> logic before releasing the inode lock (the unlock_new_inode() call) in
>>>>> fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
>>>>> fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inode
>>>>> after the attributes initialization has finished.
>>>>>
>>>>> As I understand it, fuse_change_attributes_i() would be pretty
>>>>> straightforward / fast for I_NEW inodes, as it doesn't send any
>>>>> synchronous requests and for the I_NEW case the
>>>>> invalidate_inode_pages2() and truncate_pagecache() calls would get
>>>>> skipped. (truncate_pagecache() getting skipped because inode->i_size
>>>>> is already attr->size from fuse_init_inode(), so "oldsize !=
>>>>> attr->size" is never true; and invalidate_inode_pages2() getting
>>>>> skipped because "oldsize != attr->size" is never true and "if
>>>>> (!timespec64_equal(&old_mtime, &new_mtime))" is never true because
>>>>> fuse_init_inode() initialized the inode's mtime to attr->mtime).
>>>>
>>>> You understand the pretty well, I think.
>>>> The problem I have there is that fuse_change_attributes_i() takes
>>>> its own lock.
>>>> That would be a pretty big operation to split that function.
>>>
>>> I believe fuse_change_attribtues_i() takes the fi lock, not the inode
>>> lock, so this should be fine.
>>>
>>
>>
>> Ah, you want to update the attributes before unlock_new_inode()? The
>> risk I see is that I don't imediately see all code paths of
>> truncate_pagecache and invalidate_inode_pages2. Even if there is no
> 
> We never call into truncate_pagecache() or invalidate_inode_pages2()
> from fuse_change_attributes_i():
>  truncate_pagecache() is gated by oldsize != attr->size:
>     for I_NEW inodes, fuse_init_inode() sets inode->i_size to
> attr->size, which means "oldsize != attr->size" is alwyas going to be
> false
> 
>   invalidate_inode_pages2() is gated by oldsize != attr->size and
> "!timespec64_equal(&old_mtime, &new_mtime)" (where new_mtime  ses the
> mtime values from attr):
>     for I_NEW inodes, fuse_init_inode() calls inode_set_mtime(inode,
> attr->mtime, attr->mtimensec);, which means
> "!timespec64_equal(&old_mtime, &new_mtime)" is always going to be
> false
> 
>> issue right, who would easily notice the fuse behavior in the future.
>> I kind of agree with that method if the condition would be
>>
>>                 if (oldsize > attr->size) {
>>                         truncate_pagecache(inode, attr->size);
>>
>> and I don't understand why it is '!='. I.e. for a new inode oldsize
>> would be 0 - the condition would never trigger and my concern would
> 
> For a new inode, oldsize is attr->size, not 0. The condition never triggers.
> 
> fuse_iget() calls fuse_init_inode() (which sets inode->i_size to
> attr->size) before it calls fuse_change_attributes_i().


Yeah, I just see it, had missed that before. Your patch version sounds
good to me then.


Thanks,
Bernd
