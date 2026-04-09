Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4D221F39;
	Thu,  9 Apr 2026 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696382; cv=none; b=q+dfcVKhyFmhONjEHSJZpf3ROMCnSLdgjOIlT/riqKJSVHN+2lX5OdEP823fIC/dVtWjX0lMJbQ1nhZp/txa/a3WyTu7gGylqt4OmyBmSxxWNsB/l9kU3AJXNDdHtvLajtHh8nASURd4kpZSo69FVbwGVb03QNvcgqjB47hjo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696382; c=relaxed/simple;
	bh=tx4WU+vBZaXvi3en+0ajgfjGbaPrtnmMPuHfeLYIAkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMqClVS0ML+9w2B67On+OfBM7usgQmG6gcYdCmsTrL9cK9xNmREDCEOydvXilSFCfJxR/3XzYygWyqmRPDqfx70NKBIx/I/SGiZVT3mW4uc02sa9ynhA2sLf4321cMm1kqVh1bMtH3UzQ3aZAPMCPfuqy2U86yKlWS3HQRVQazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=R5B7Zfve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ouw2Du7+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="R5B7Zfve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ouw2Du7+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 558D91D0020F;
	Wed,  8 Apr 2026 20:59:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Apr 2026 20:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775696378;
	 x=1775782778; bh=tx4WU+vBZaXvi3en+0ajgfjGbaPrtnmMPuHfeLYIAkM=; b=
	R5B7ZfvezNBklL7kTCMY3/csfknd8Mx7TF/MolkhHMpBLbKc5pfpJrvRkaiCVADi
	L5s+ReIUumHIafiJWNESfUVcHHem1E7Bpf+473dFhWY51nNw9P+CuSUaFs4yTIoO
	AXz1nPwXi/xIVPy+A3k2E8C7LMqTMorJU4inYsd+mztWtaSPA5GihxWt3VSVLTVf
	RqdHlWvqU6yYoh0yaqiCDqZUCrbNklNK0rHBfSweeyj39ENQPiGA08cJkrpkCpBe
	FtO1ermhZgGNGFdPNYZ2pNZo4r85TrIK5fLS90+vnHKMsKV1q+edeNt7AduEhPhb
	67EKLTQ5VKgFAbf5kL3f7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775696378; x=
	1775782778; bh=tx4WU+vBZaXvi3en+0ajgfjGbaPrtnmMPuHfeLYIAkM=; b=o
	uw2Du7+N+nzzR8F22zlLcRsPCvRUat++r5/USbNOBcU/rvbrFif/ALS70BpN+Lk4
	ELVUT7eFRNsRp9CjZjRVa6iKbFveOJAouIEraBbgWEVtdQLXmh4qr3YKOkaFRZkp
	bdqhRdyO55GT4Llyz3CoZwb0s0JXCGe9WUxl1hJj2wVu9eDH2k3X5R1LlNV9nFDS
	pRkCFJfOW9e5qm08UkVNwUhhDQhNdDVgUXrFCEzno30X2CbilTxamcwfp++6zenn
	uZKASmfQnIxBMybqq8ccXMR4GkcqBSqlDlOrq/Tryw69J/qxKY/TrthJb7AVVtkG
	OFHa7A7QpocCYxVJrCHYw==
X-ME-Sender: <xms:-fnWaYl7DfWk0Jg8BpBI3pViklab7d1ykHMpzCVg-LXRQjd1xkja5w>
    <xme:-fnWaYQisVeqW_NEBQSwL0tEoylX3m438yC2cjKpOVDkBzziJWuMYyMo3fFQg3gjK
    bhxH4ESyCjKG0aLwpMLBKYk5RMuJPIwKXjoE48vKx-QWmPT>
X-ME-Received: <xmr:-fnWaWa6ASbEsLIVkUZVQ1dUp_VLcbkO-q5Lb6Xa2XKRehMBj7Hk0_8N7pie-Rra1az5BHO0_EEbp_CheoDhWtTpQz9y4mnDEWjJR5E5duUFExbI-62wuoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvhedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedtud
    fghedtudfgfefgtdejgedutddtveefheetvdefueefgffggfdvieelteffgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhrtghpthhtohepfhhsohhr
    vghnshhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrggvshhhihhnsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:-fnWaQ_RzVwGX0a_-3uqx6Zg2SYJNVxozBkHz0EAXTQ7DpScCzbi-w>
    <xmx:-fnWaQmI9EMpY6RpyIgz2aNK-KHSpujZRxLnIEYniZ82bWox3eREAQ>
    <xmx:-fnWaVZhVYteAVbgGBs1jcJvbwX6keGJ3PQi2aDu2v0Ju4I0r4B1GQ>
    <xmx:-fnWaYM9Z2z4Pg4dnu9dvXLdyP15EDYo6lJriearFiCtjDk-ds_y0g>
    <xmx:-vnWaeqC4RiZB3QTsobzjWohuzFnUGKUIkWgUCErwgPx4E7jBc3WxATY>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:59:31 -0400 (EDT)
Message-ID: <762d0200-2043-490a-86a1-f5c3db216515@themaw.net>
Date: Thu, 9 Apr 2026 08:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>,
 Jay Shin <jaeshin@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>,
 Waiman Long <longman@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Wangkai <wangkai86@huawei.com>, Colin Walters <walters@verbum.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <d8e591a1-d105-408f-b794-48573e1aa2fd@themaw.net>
 <20260407-frieden-girlanden-7b761912b2b1@brauner>
 <06760176-fb65-4fd8-b127-28b25d449b1f@themaw.net>
 <g72jlphxouvfml5ewxrvbo4u6drhue3pnsawoywhnvitnga3sd@rvi4wfep2az5>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <g72jlphxouvfml5ewxrvbo4u6drhue3pnsawoywhnvitnga3sd@rvi4wfep2az5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/4/26 18:17, Jan Kara wrote:
> On Tue 07-04-26 20:41:08, Ian Kent wrote:
>> On 7/4/26 18:35, Christian Brauner wrote:
>>> On Wed, Apr 01, 2026 at 10:10:55AM +0800, Ian Kent wrote:
>>>> On 31/3/26 17:39, Christian Brauner wrote:
>>>>> On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
>>>>>> If there's a very large number of children present in a directory dentry
>>>>>> then the benifit from retaining stale child dentries for re-use can
>>>>>> become ineffective. Even hashed lookup can become ineffective as hash
>>>>>> chains grow, time taken to umount a file system can increase a lot, as
>>>>>> well as child dentry traversals resulting in lock held too long log
>>>>>> messages.
>>>>> Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")
>>>> I'm pretty sure I saw that earlier on but had forgotten about it when I
>>>>
>>>> reviewed the bug this time around. It is essentially 681ce8623567 ("vfs:
>>>>
>>>> Delete the associated dentry when deleting a file") with opt-in of course.
>>>>
>>>>
>>>>> This patch introduces the concept conditionally, where the associated
>>>>> dentry is deleted only when the user explicitly opts for it during file
>>>>> removal. A new sysctl fs.automated_deletion_of_dentry is added for this
>>>>> purpose. Its default value is set to 0.
>>>> I meant to update Documentation/admin-guide/sysctl/fs.rst to also say that
>>>>
>>>> setting dir-stale-max to 0 disables it. I also get the impression you might
>>>>
>>>> feel better about this if the default was 0 as well.
>>>>
>>>>
>>>> The thing that I don't much like with the d_delete() approach is that it
>>>>
>>>> fails to cater for files that have been closed and are otherwise unused
>>>>
>>>> who's dentries make there way to the LRU eventually resulting in the bad
>>>>
>>>> behaviour being discussed.
>>>>
>>>>
>>>>> I have no massive objections to your approach. It feels a bit hacky tbh
>>>>> as it seems to degrade performance for new workloads in favor old
>>>>> workloads. The LRU should sort this out though.
>>>> My aim was to improve performance so I'm a bit puzzled by the comment.
>>>>
>>>>
>>>> The problem is the sheer number of dentry objects and the consequences
>>>>
>>>> of that. Hash table chains growing will affect performance, umounting
>>>>
>>>> the mount will take ages, and there are cases of child dentry traversals
>>>>
>>>> in the VFS. Once you get a large number of stale dentries that necessarily
>>>>
>>>> need to stay linked into the structures to get the benefit of caching your
>>>>
>>>> exposed to this problem.
>>>>
>>>>
>>>> The LRU mechanism is so far unable to cope with this.
>>> I meant when when you start limiting the number of negative dentries and
>>> start to not accumulate more that some workload was relying on this. It
>>> was just a theoretical musing. That initial "delete on unlink" thing led
>>> to regressions for a bunch of workloads when we did it unconditionally
>>> initially.
>> Yes, I did take that on board.
>>
>> It's trivial to initially disable it with a doc update describng this.
>>
>> But this only works (gets accepted) if people think it's worth while and
>>
>> I'm not sure my proposed case is convincing enough.

Thanks for the input Jan.


> I think we definitely need to find a way to manage negative dentries (and
> possibly all dentries) better. It is coming up several times each year that
> people have issues with negative dentries accumulating too much and they
> hit issues in various places.

Indeed, that's precisely why I've been thinking about it.


>
> I don't particularly like your solution because it effectively stops
> caching new dentries for the parent and old ones stay while, as Christian
> suggested, we'd prefer to prune older dentries first. Also usually the
> problem is with negative dentries while you approach treats negative and
> positive dentries in the same way which could be a problem for some cases.
> But with this second objection I'm less sure so take that mostly as a
> preference :).

Maybe I'm not paying attention but I didn't "get" the new vs. old notion

from previous discussion even though I was thinking the same thing. So good,

you've fixed that, ;)


The second thing you mention is a bit more subtle so I'll need to look again

at the dput() handling for the last reference of a dentry.


>
> The problem is how to efficiently prune older children dentries without
> slowing down fast paths or growing struct dentry...

The notion here is the best way to do that is to work out some way to

identify dentries that should be discarded rather than kept (on the

LRU) at final dput.


Very large directories have obvious performance overheads. Such as once

the hash bucket queue lengths grow past a certain ratio of buckets to

queue length (can't remember what ratio I saw in user space autofs when

I had this same problem) d_lookup*() will suffer and the benefit of

retaining a dentry will go away regardless of dentry age. Nevertheless

oldest first is an excellent approach, I'll continue thinking about how

to do that.


Thanks, Ian

