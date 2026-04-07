Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BA25F98A;
	Tue,  7 Apr 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565684; cv=none; b=tmu7l1OaxhCQFV9jfzEpiyoQck6JsN7OReRjWzjUoigO9up2MPOnzUkL+m8yE70uCbVH0WM+oXakV2LR9YvMM6+p1Lrj4hHGXr7RsHkQ3DOyhJg9m1LAOxxj8pKRzqj0bmc90TCgkrzi5UuUwvy+pXASOdpmjU9DW0HijGvy+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565684; c=relaxed/simple;
	bh=2f4DFJcav/jCD//uCDk3U991sm8tkfQP7NLtzeGT0+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVAGmm0CHHH8Jtpu2H5CeM8R4w0cbWmeYvpyxRAOTU765hObXpmtjo2IPTeQ1BWq4HvC00Sq7mMkGNDKXbnesbhCXKidLKRTuf621YD8qGrfFD+9Jwdz90nsdVEnAfkbKHU7Y2fGaPZ4SZWELsst6x9pzFtmF7vaCIU20bVd0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=lk6rubv6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u5rukjmB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="lk6rubv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u5rukjmB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FA8C7A00DE;
	Tue,  7 Apr 2026 08:41:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Apr 2026 08:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775565678;
	 x=1775652078; bh=2f4DFJcav/jCD//uCDk3U991sm8tkfQP7NLtzeGT0+8=; b=
	lk6rubv6CIa5lUqhaViAKqlFuA1FC0ZyMLCirtu1AMlcQAwCA9KgTPvHU1/jP0ri
	LwcKOSc3CFrFbO2ruKzzSuSC9KPdsk20kFZOigB2Vq86eGH7FIpLBkRHRXace1oD
	lLp2keJYhnYV48QjQGj7rC7X/0QOIX+qdLAAoy+mmmBN3sKp4U7wLMsL0ClT0TH4
	p181rsMvBLwLy0/mk35vZwwrJKbW6Umlr1PdAbLn41d3ltj4C+iUOojSd/8LH8MD
	70eBKololxLZPfXeznkNr0VTS2pYw3OXKGCyqKhNZD1Fz06mqkElxmjoI/Iuq/T3
	TWqXk932eNPd3pFULHnFcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775565678; x=
	1775652078; bh=2f4DFJcav/jCD//uCDk3U991sm8tkfQP7NLtzeGT0+8=; b=u
	5rukjmBHOV1BTJsGxgz+TzmwGoKEnNI6wWGIzZQJrVHf8SHSWzPFfcbrebRwrDU4
	/PqgwVkICNcybj4cwiWU1X7h4PzPRtmBclkboYPCdpOvfLOTK8N9RKvIHcyttaE0
	qK+/oI6dbNoz2VWmN4AANbx8g0PTS3M2c6z09uPK+HoTwGL+gS7bYtHnGOJGWhcX
	YspKhDENo+urBuGYSwisI0n7IZGQCh7WdA5m6gYqwno6gde1r0yr0vEoBa0ru60G
	IKYPyrFnyDlZwJaVoSu60g4kQ2SDEO446CSRFNlatOuwBuscIBDCCfo271cJpGYr
	NrLCdG6yCkhUggFsv+Znw==
X-ME-Sender: <xms:bfvUafw_YJqNR2vsOoFCfrAhz9lizgY-M8P69AZ_9LvstIBnvdD6Vg>
    <xme:bfvUaXsZcuyNuMYSZTbdGQrUBjF4kaKJO3qnAvPreHQb86ChI6J7FI9yBC4aBNNxM
    Mc0oxuRdQLmAhROEj_1EaEPWK-RHdRGPfE9Upl7us7AexYV>
X-ME-Received: <xmr:bfvUaZHLwLc9hYndsZTihnKKOCs8SDFu_zCW5IbReuV4IN2EnbvwS9SpLx-f--931NPBWByCPt_TM-oZu3jfo0lqopS8bdiPkWuD6cEAVXwhm3T8G3zbnzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedtud
    fghedtudfgfefgtdejgedutddtveefheetvdefueefgffggfdvieelteffgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvih
    hrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhhikhhlohhs
    sehsiigvrhgvughirdhhuhdprhgtphhtthhopehsrghnuggvvghnsehsrghnuggvvghnrd
    hnvghtpdhrtghpthhtohepfhhsohhrvghnshhosehrvgguhhgrthdrtghomhdprhgtphht
    thhopehjrggvshhhihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhrvhgrlh
    gusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhgrohgr
    rhdrshhhrghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:bfvUaV7CODJ-IYnRpYNv2IJ2TwK6AGmI0s5Cl62nq4M7jnZlgpnsrg>
    <xmx:bfvUaaxAHi69blrPAXcC59P9hKXVooW_iujumbLWRIcPn1zH47wcjA>
    <xmx:bfvUab1wP0v2YT9-DdGp52zBpg3WVDw_5EPKNbWdpGVTVZ6_Paa7ug>
    <xmx:bfvUaV5W2vGcHD2ihMrJsHnBPLalsRzDy_IPhCPzobKEkZVUyl2z0w>
    <xmx:bvvUaVGO4kEbDMOYEDhlBZBLThEJyrmgr9tSn-TdtFhLcH0YHURvse5U>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 08:41:11 -0400 (EDT)
Message-ID: <06760176-fb65-4fd8-b127-28b25d449b1f@themaw.net>
Date: Tue, 7 Apr 2026 20:41:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>,
 Jay Shin <jaeshin@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>,
 Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>,
 Colin Walters <walters@verbum.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <d8e591a1-d105-408f-b794-48573e1aa2fd@themaw.net>
 <20260407-frieden-girlanden-7b761912b2b1@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20260407-frieden-girlanden-7b761912b2b1@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/26 18:35, Christian Brauner wrote:
> On Wed, Apr 01, 2026 at 10:10:55AM +0800, Ian Kent wrote:
>> On 31/3/26 17:39, Christian Brauner wrote:
>>> On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
>>>> If there's a very large number of children present in a directory dentry
>>>> then the benifit from retaining stale child dentries for re-use can
>>>> become ineffective. Even hashed lookup can become ineffective as hash
>>>> chains grow, time taken to umount a file system can increase a lot, as
>>>> well as child dentry traversals resulting in lock held too long log
>>>> messages.
>>> Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")
>> I'm pretty sure I saw that earlier on but had forgotten about it when I
>>
>> reviewed the bug this time around. It is essentially 681ce8623567 ("vfs:
>>
>> Delete the associated dentry when deleting a file") with opt-in of course.
>>
>>
>>> This patch introduces the concept conditionally, where the associated
>>> dentry is deleted only when the user explicitly opts for it during file
>>> removal. A new sysctl fs.automated_deletion_of_dentry is added for this
>>> purpose. Its default value is set to 0.
>> I meant to update Documentation/admin-guide/sysctl/fs.rst to also say that
>>
>> setting dir-stale-max to 0 disables it. I also get the impression you might
>>
>> feel better about this if the default was 0 as well.
>>
>>
>> The thing that I don't much like with the d_delete() approach is that it
>>
>> fails to cater for files that have been closed and are otherwise unused
>>
>> who's dentries make there way to the LRU eventually resulting in the bad
>>
>> behaviour being discussed.
>>
>>
>>> I have no massive objections to your approach. It feels a bit hacky tbh
>>> as it seems to degrade performance for new workloads in favor old
>>> workloads. The LRU should sort this out though.
>> My aim was to improve performance so I'm a bit puzzled by the comment.
>>
>>
>> The problem is the sheer number of dentry objects and the consequences
>>
>> of that. Hash table chains growing will affect performance, umounting
>>
>> the mount will take ages, and there are cases of child dentry traversals
>>
>> in the VFS. Once you get a large number of stale dentries that necessarily
>>
>> need to stay linked into the structures to get the benefit of caching your
>>
>> exposed to this problem.
>>
>>
>> The LRU mechanism is so far unable to cope with this.
> I meant when when you start limiting the number of negative dentries and
> start to not accumulate more that some workload was relying on this. It
> was just a theoretical musing. That initial "delete on unlink" thing led
> to regressions for a bunch of workloads when we did it unconditionally
> initially.

Yes, I did take that on board.

It's trivial to initially disable it with a doc update describng this.


But this only works (gets accepted) if people think it's worth while and

I'm not sure my proposed case is convincing enough.


Ian

