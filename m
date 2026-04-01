Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61141862;
	Wed,  1 Apr 2026 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010092; cv=none; b=iwnleSJ+lcB8s+NLytAB/yltDJzxtu9prMTtspv0iTiv5gZOuphJqpdeYgE20HFvxmefznnPGEDevUU4W/X/aXzavMPTbm+bn4Tw4HA8StKNdwphwUIJqkKEXk+gybiHwHaoHwogxvB8FYNHpcNv/gzmQdjePi0qCpdbtulQlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010092; c=relaxed/simple;
	bh=n/t69l86BcIMDKe8KBqT1rcAH43nt9mwaOLraFNky+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRx/qY6weLgEw/QBpZvtBGjTV1t0eCFhQWRjGknPYD/v7O+87YDkFOovsloinYZnTNBfHHoC0xiiKj2psobZwqdPjbbihpj9oDUAKZWSogDNxbS4sA7hbUQV9QsPxoeHs5VmCNnlerehbaw3+3xfLY0b9AgCIQUOVvzFBSrxbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=PijxlCLc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIMK4kDX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="PijxlCLc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIMK4kDX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 752C17A0285;
	Tue, 31 Mar 2026 22:21:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 22:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775010089;
	 x=1775096489; bh=ZQiDlU59ylYLrrdPyL3uIchHdABLzQL1cmxQSPkm+Kk=; b=
	PijxlCLc0/nhaqeTBfJS8o1zgvrKytJsOq5ykDl/Q2vQ0F2DXCpB2yzwU+l5/tJJ
	F1cs56fBu+fHQyITukvsuxUPIeobDuuTHvq2xMmlQDobxhnZ0G7OBYJE3RCcORMI
	HNy7buuuIkEETh7FiU1Fy9Lj4nOKKPS9Q6krfyGFwWI8jC+fczosefbAX9N5QIRV
	7Lua5fNCj/ad6yEvlX/X7Lsuek1/Gt73/T2FYm8CiLTPnGxMqzgWKyf+BAaHRPHt
	gp836OP5jgzA5G/1zxfIkRNO3nfyI7SrT7zroQGOWy1f5BCxtmnRJzwMEBBCqGb+
	U+p7raYpgLSz5nuhIiOEmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775010089; x=
	1775096489; bh=ZQiDlU59ylYLrrdPyL3uIchHdABLzQL1cmxQSPkm+Kk=; b=L
	IMK4kDXKtSw4o8W6sNnu4s36WVbbIU5Me2zomjsaPtdTySiZ//6qL5/aHpJQg+2U
	ybbi+RrIA13iE+iLaXb7Cj2LsS2toEIiVWcLVS2WcvVH09igvtvGcGUSYzGkJv4o
	IUvkkosv0uTRA3Qt6b4GRbBgPkgLYN82gGTvECGEBC0tvsQRvs13KPS3XiMebwqu
	q36ZkXKPHzHAnSwqeE4dO60OMEqR+nQTQs2ENmL86WN3mvbfC5lr2nCosfAbtoSe
	kmxmMrYtg1JzkklCQMloe12pOy28nr+dl2oz9WfexHZndYOz9F466GoldJfVKKNU
	WCATvlCSnZGnC4UVrq3wQ==
X-ME-Sender: <xms:KIHMaVOmm-GCVdC6HywnUkX1pMV81LtDKQlVNi9oCR-_a3qASkF4nw>
    <xme:KIHMaRWvnga1GOPAFbd7E49qPUBbkiUuNkGlNp4ZButdz7gdD7pn8ZJ5pU6j0lDfz
    SdpWvQKg1aaAOq03sBWdUwvugFqMjIONrgsV9NddsBXLeDfvg>
X-ME-Received: <xmr:KIHMacynONBJn38UeHClW4jIcIkC0pnc3febG1zTt6qvRXAkmCDnIoSC4ijIE9gK7kEkGoJmXoOnc8ghZJJFV1rBLJwEvr5qyCZJAgr3uWDrglrVAI14TU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfmvghn
    thcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfeekhf
    egieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvg
    hmrgifrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghlihgsrggsrgdrtghomhdprh
    gtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhr
    ohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhhikhhlohhsse
    hsiigvrhgvughirdhhuhdprhgtphhtthhopehsrghnuggvvghnsehsrghnuggvvghnrdhn
    vghtpdhrtghpthhtohepfhhsohhrvghnshhosehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehjrggvshhhihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhgrohgrrh
    drshhhrghosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KIHMaRM4KWOQ0EEPCja3o9SVkv9h8GLCD8ZsdwGFLzbMZsH-rRd38A>
    <xmx:KIHMaer3Hkso75N4tD3o8jXXWZxtGZHBaDJoJSzvJcvFdgPKaTzIIg>
    <xmx:KIHMaY-UJfTXQhJRuelhl5t8ORnd3U35aizoVpiB4CmoUHysUtkkBQ>
    <xmx:KIHMaU1dQmdQkhxJD8xDE5E8dWG3KGNu_ieNBrl_sN_jz0L9EC0JpQ>
    <xmx:KYHMaZ154FfdCQE-KonzeQSLAmf_OtoHD8YsN4vlfg682EoQ1TDVWcVg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 22:21:22 -0400 (EDT)
Message-ID: <24d86595-a1e8-4fc0-b4e4-7fc62d51049f@themaw.net>
Date: Wed, 1 Apr 2026 10:21:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Christian Brauner <brauner@kernel.org>
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
 <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>
 <d54d4791-dab3-4141-9665-091fc8918235@themaw.net>
 <b04c1c86-100e-467b-b104-7312c4dd0251@linux.alibaba.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <b04c1c86-100e-467b-b104-7312c4dd0251@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 09:47, Gao Xiang wrote:
>
>
> On 2026/4/1 09:38, Ian Kent wrote:
>> On 31/3/26 17:54, Gao Xiang wrote:
>>> Hi,
>>>
>>> On 2026/3/31 17:39, Christian Brauner wrote:
>>>> On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
>>>>> If there's a very large number of children present in a directory 
>>>>> dentry
>>>>> then the benifit from retaining stale child dentries for re-use can
>>>>> become ineffective. Even hashed lookup can become ineffective as hash
>>>>> chains grow, time taken to umount a file system can increase a 
>>>>> lot, as
>>>>> well as child dentry traversals resulting in lock held too long log
>>>>> messages.
>>>>
>>>> Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated 
>>>> deletion of dentry")
>>>>
>>>> This patch introduces the concept conditionally, where the associated
>>>> dentry is deleted only when the user explicitly opts for it during 
>>>> file
>>>> removal. A new sysctl fs.automated_deletion_of_dentry is added for 
>>>> this
>>>> purpose. Its default value is set to 0.
>>>>
>>>> I have no massive objections to your approach. It feels a bit hacky 
>>>> tbh
>>>> as it seems to degrade performance for new workloads in favor old
>>>> workloads. The LRU should sort this out though.
>>>
>>> JFYI, another issue we once observed on user workloads is that
>>>
>>> `d_lockref.count` can exceed `int` on very very large
>>> directories in reality (also combined with cached
>>> negative dentries).

Yeah, that's a problem for sure.

I hadn't considered such a large number of dentries so I wasn't

trying to resolve this case and I guess the change here would

only postpone the need to re-think dcache design which I suspect

is what would be needed.


Ian

>>
>> Ouch!
>>
>> So more than 2 Billion?
>
> We received some report.
>
>>
>> I suspect in that case you have much bigger problems than 7 or 8
>>
>> million dentries on the LRU list and linked into the directory.
>
> That shrinker seemed not to be triggered at all
> since the memory was abundant on those bare
> metals; I don't see how it cannot happen with
> enough memory and trigger negative lookups on
> a directory for example.
>
> However, it was a report quite few years ago, but
> I remembered it was a real user report
> (`d_lockref.count` overflowed).
>
> Thanks,
> Gao Xiang
>
>>
>>
>>>
>>> It can be a real overflow, this commit can help but it
>>> doesn't strictly resolve this, anyway.
>>>
>>> Thanks,
>>> Gao Xiang
>
