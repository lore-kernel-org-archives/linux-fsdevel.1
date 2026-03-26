Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11E248883;
	Thu, 26 Mar 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549013; cv=none; b=l4eHEDhlV9s0pw8jTaiGy4f9AvxBqOL42/xSdxh9o0MYGC0YW0IE5MkO5K3EQ8AjY68jxR/mgqAfa6qllVxNB9AXx8Qq2lgn6e45vCYZQVtdM/2hYORiK1jWV5Jfi8c5SOD5iz6zdjC0e8zayMovNIB9xmhYAbW6yEOMksLw8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549013; c=relaxed/simple;
	bh=Co07kNQ22wGpat/ybCmxNqkYC9Ig7z1pczXey6HjyiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mykvbp6yLWveLpobHt2eOLf7Q1RwcE1x/u37b4qzKi9pYKyG3eN7Lz7uqvkENa7OAY8wI0h+x2qoboCXuyt/ZEbit+GkfWxB7RFPWkIJ38PPqa0dtVC0mxqUa6x1mWsHV2T71ogoqJHs+L3ORbA097pZjdthSdL9SqIJvMNSaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=G89Ob72X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDSN2Qdm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="G89Ob72X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDSN2Qdm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 370B1EC0289;
	Thu, 26 Mar 2026 14:16:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 14:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774549011;
	 x=1774635411; bh=X0BHQuLvnfpn2uvEgNG50TWFwO+dJeySb0Z0nX2jm6Y=; b=
	G89Ob72X7dlYl3IrcPTYLjFsdDI9ANfEo12B/4+yXKXRPINFhcx56Kg+WnAmVxTE
	11XdsUIREpEQDqZoGUnLzYe5J+KybvVXjr8Xpgx3QaSRtD0bfvJib/P5b/T3S2mz
	YNek3KzR1L/AAWo0HWmqYEN+s0Ea67pmWmn+y0ws9ZZj2kYDjOl7yAM7LLHEPevN
	cv0lkCubQGkDVvFZVtDhb+6sG7Ru5pwCPp8pYADogwgjKh6SKVVK56Q8cIpTwNjq
	AiZlidNmZE01kSnRUl8ENBLjAwut77jFSN6jR2dMyze9NmGJMjenPZtWUHOGYvBW
	eb89AEOvWyc1Pnz7sTnutw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774549011; x=
	1774635411; bh=X0BHQuLvnfpn2uvEgNG50TWFwO+dJeySb0Z0nX2jm6Y=; b=H
	DSN2Qdm7mGbo6dEZYk/0HxRwU/PwD3hKTWtKBLcVNIPKNvOTDB0ThH0cugSzbCv3
	Y8AYM+YmXanbP61BOBjnQDBvhI3NR2X7/PmgJxMidhRhDvjPIGbnG3juAlOJzsFy
	HHoCE6Ftm7mtLkTFChHMYnMYTIdcIiwQwyXjl1jgRchftTB5l3zeAMifAvV04Ivu
	sT9+ASob9W00S6LMHgteRiSApJpqUdok5N2NoOONOSOVUIlIzYpciHCkL107sqm+
	I+NLQz4dPcn5quryEj+fln2NcqLyXZnqCzFb9kCVRWxavFFyWOwO9lLZJKs3vK4f
	NiX02qLAQ6QQxsvcBpQOQ==
X-ME-Sender: <xms:EnjFaSo3JCPQXwikjkCcFHA_CYACoL-tDNybpPyqM5gOAipvGnHUaw>
    <xme:EnjFaapWnDt6XzltHdy8OuHomZrejyPCRxqq0E-qmn_h6sI1RzQB_hXwHhaheT7sZ
    m84T_qPbxEgwalfHMPjuP61XcI07HsEUfubJtfhVdHYgbzVD2lo>
X-ME-Received: <xmr:EnjFad0wZFAcusOQXKxEkXhPjU5GNKvBL-O-3HzTiKYhYCR4htpmcZDmoymVprdWXkcXM0s1nGpWUZ3UHuO96DdNpA0L6fIAN2JYF3URwXtyksgK3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdektdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:EnjFaQFaA9ELJ_KW1zApaS7NvdGneUyB0Gf-xDpIsrE3UnI7fVwPvg>
    <xmx:EnjFaQGJ-VrbgoDsecMDNAEs12WOytO5AfOgX8DC8J1yR6DG4ofSig>
    <xmx:EnjFab4b9kowTHHE92g4sQiQvJ8nFpWQGd28NyZJZxqbbjtvSUBrWQ>
    <xmx:EnjFadxY_OU3oy9sgsQ1jRIrHwbYB_x4-LrKO_j5agjfqu0K_n8kWQ>
    <xmx:E3jFaZgQW9qBLn1KUwrAHzsuYw2-iY3gABlyu4Xnfn4NwzVaOrGEqj3a>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 14:16:49 -0400 (EDT)
Message-ID: <7b4e01e0-57ea-4bee-8f96-c17a9bf64d0b@bsbernd.com>
Date: Thu, 26 Mar 2026 19:16:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Joanne Koong <joannelkoong@gmail.com>,
 Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner
 <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
 <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
 <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
 <acVUeX54PDFfApI2@fedora>
 <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>
 <acVxb0TSSUgHsK5T@fedora>
 <CAJnrk1ax2bK-FQXDEc=OGvYS7YvCvL3YsKWv1gmzwkS_QSz+fw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ax2bK-FQXDEc=OGvYS7YvCvL3YsKWv1gmzwkS_QSz+fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/26 19:00, Joanne Koong wrote:
> On Thu, Mar 26, 2026 at 10:54 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>
>> On Thu, Mar 26, 2026 at 09:43:00AM -0700, Joanne Koong wrote:
>>> On Thu, Mar 26, 2026 at 8:48 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>
>>>> On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
>>>>> On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 3/26/26 15:26, Christian Brauner wrote:
>>>>>>> On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3/18/26 14:43, Horst Birthelmer wrote:
>>>>>>>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
>>>>>
>>>>>>>>>     fi->attr_version = atomic64_inc_return(&fc->attr_version);
>>>>>>>>> +   wake_up_all(&fc->attr_version_waitq);
>>>>>>>>>     fi->i_time = attr_valid;
>>>>>>
>>>>>>
>>>>>> While I'm looking at this again, wouldn't it make sense to make this
>>>>>> conditional? Because we wake this queue on every attr change for every
>>>>>> inode. And the conditional in fuse_iget() based on I_NEW?
>>>>>
>>>>> Right, should only wake if fi->attr_version old value was zero.
>>>>>
>>>>> BTW I have a hunch that there are better solutions, but it's simple
>>>>> enough as a stopgap measure.
>>>>
>>>> OK, I'll send a new version.
>>>>
>>>> Just out of curiosity, what would be a better solution?
>>>
>>> I'm probably missing something here but why can't we just call the
>>>
>>>         fi = get_fuse_inode(inode);
>>>         spin_lock(&fi->lock);
>>>         fi->nlookup++;
>>>         spin_unlock(&fi->lock);
>>>         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
>>>                                  evict_ctr);
>>>
>>> logic before releasing the inode lock (the unlock_new_inode() call) in
>>> fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
>>> fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inode
>>> after the attributes initialization has finished.
>>>
>>> As I understand it, fuse_change_attributes_i() would be pretty
>>> straightforward / fast for I_NEW inodes, as it doesn't send any
>>> synchronous requests and for the I_NEW case the
>>> invalidate_inode_pages2() and truncate_pagecache() calls would get
>>> skipped. (truncate_pagecache() getting skipped because inode->i_size
>>> is already attr->size from fuse_init_inode(), so "oldsize !=
>>> attr->size" is never true; and invalidate_inode_pages2() getting
>>> skipped because "oldsize != attr->size" is never true and "if
>>> (!timespec64_equal(&old_mtime, &new_mtime))" is never true because
>>> fuse_init_inode() initialized the inode's mtime to attr->mtime).
>>
>> You understand the pretty well, I think.
>> The problem I have there is that fuse_change_attributes_i() takes
>> its own lock.
>> That would be a pretty big operation to split that function.
> 
> I believe fuse_change_attribtues_i() takes the fi lock, not the inode
> lock, so this should be fine.
> 


Ah, you want to update the attributes before unlock_new_inode()? The
risk I see is that I don't imediately see all code paths of
truncate_pagecache and invalidate_inode_pages2. Even if there is no
issue right, who would easily notice the fuse behavior in the future.
I kind of agree with that method if the condition would be

		if (oldsize > attr->size) {
			truncate_pagecache(inode, attr->size);

and I don't understand why it is '!='. I.e. for a new inode oldsize
would be 0 - the condition would never trigger and my concern would
never be true.

Thanks,
Bernd

