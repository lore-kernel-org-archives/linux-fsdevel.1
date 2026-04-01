Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5231327F;
	Wed,  1 Apr 2026 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009470; cv=none; b=iYUhZ1JyWeRX3Xa5+8W/8BzJTTzQGc/5xoacom8S+wsO6/mPg1j4YnRC4Nb23d5onML2HgH/4sF1a5YToZCanbnLlF0WZyIQaunXHJF1rCgznossywKLYirV43LdAfEJjmJ9TyDQbQuoP5GsqkOdXwxx4gWuBXT9ysn2RNtdDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009470; c=relaxed/simple;
	bh=Y+gOxLQWZdNyfBdTxCTMimC9ewzSwHnBB4rZi6jDPwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkbFFjVQfYiV73aQBepxn1e1dor/HwxYnbAIQyN7FaMuNrOAiNGLh0O3z3IUBYZQBjAPgML66/ZFsKH1d7sU0x2inf0YPteOyKq8wiLxg8ugNsx8F79LtpE9daJRs11PPYTaUH6CqqTqPQ6v4hTe/FzHhV3aZjNbEoHBZtG4h3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=AndXt4+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kjFctQCP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="AndXt4+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjFctQCP"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1AD57A0267;
	Tue, 31 Mar 2026 22:11:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 31 Mar 2026 22:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775009464;
	 x=1775095864; bh=DhB07Ldr9QR5AamCoFYmgttxJw5BJ5nBPZE8DDCmEgs=; b=
	AndXt4+CZvjdYEJ7P5qG5x2iAHLf9Nfj7aTnORrpFUU8x6Ogg9PzavaKPqCwqDix
	GvwDrkeSvU1aB+fxwxh+zo4oxWHPr6aFw2Nn6iwS7Y5I4xw2pMY/Z6GhAjAklBrl
	fju6XXFF2cttW8pkVb7LZsIPN5rtFm67rswe0xZxVoi4Y7rV7sQ3SPWtKNqaEUcl
	t+yPCTvjfelzKgi91mknMs+ilv9FiVJG0ulVGoeQU5TW47a47KLd4tAeuz2/O4yM
	VYC7lN4JOhNNxnqVtWciOHIiyLX2Mt+D6w/czMbRWsxDkjQD8XSmH1HOx/asr6Cp
	4NaonzbhBsufSFng8PGdYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775009464; x=
	1775095864; bh=DhB07Ldr9QR5AamCoFYmgttxJw5BJ5nBPZE8DDCmEgs=; b=k
	jFctQCPr3KrxBBOkZ8CZeB0m+yBuWhCiJq643jlkHmQc606BXRlHkFPT278GSU2J
	cj68toMv2t9ihCZAO6Uck8DGB5fBYG3eSsZS4JfYdblMhMh//JjwGKXnHne2Nw/b
	pEDq1/5U56BEUEJXCPQW6w/87av1aY1tN5eyA6N0NYjI8Ung+HQi3CYVpn6ZGCfg
	raujp0J2OhpagidsOK/L6dLPH/PnEFauyGZQnzRFIWbjs024Pbo7D3Zj9zWA2N6h
	4zDFZntQEPRnkPRBbBgCicBiqpEbLLoO/QkbkX2cfNHrW1WAf0TtxkkuLddqkPqx
	KA8OjV04k8TLcwiKtjTSQ==
X-ME-Sender: <xms:t37MaUJ4HfCQgUQSmpjuacwaGEg1glCJybFx6spiYWqjTAczRE0s4w>
    <xme:t37MaUnzGQMLiNspS-cIr4SxAhozkNzP7WNNoTJTZf4NXDZRpMxCibVKOGnTICjha
    ikJXEk92WEMvWZP6qc9hwibbFfPeEcXil7iKlU568VzPDo1>
X-ME-Received: <xmr:t37MaUecz5gLeLLsmWuRvf4b3LJdtiffSykTBfkxHtpUuoUKs1uA950IJDmVKE8090wqpFdCr-WhqWjGGDKqiNVWQraMiwGrUrKTc4tavkGE4LOcwhxZcGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghnucfmvghn
    thcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnheptddugf
    ehtddugfefgfdtjeeguddttdevfeehtedvfeeufefggffgvdeileetffegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvg
    hmrgifrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirh
    hoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehmihhklhhoshes
    shiivghrvgguihdrhhhupdhrtghpthhtohepshgrnhguvggvnhesshgrnhguvggvnhdrnh
    gvthdprhgtphhtthhopehfshhorhgvnhhsohesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepjhgrvghshhhinhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhorhhvrghlug
    hssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlrghorghr
    rdhshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtii
X-ME-Proxy: <xmx:t37Madwj05AhBk9II2u-xF_cGV5bhlT9bCkLl19j-AK63nMpo9UvZQ>
    <xmx:t37MaVL3mE2YVYNfkKNgUn3lxGnNDDUmIkG4s2j9UX2J0jYAzgR4uw>
    <xmx:t37MaWtZoEfE_0eBTOf9ELOBR-Bdewnx1GBso5jNV50Xl33OohOsXg>
    <xmx:t37MaXS8kdzJc1trZf-oYVW8HA6GBFApYYYdDq-DegHSkEvpdbPVpQ>
    <xmx:uH7Maf_u5CsYmw1-u2e5oOuhnVE7IfKHiJ1953QcL_MvYCGESM1C6APt>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 22:10:57 -0400 (EDT)
Message-ID: <d8e591a1-d105-408f-b794-48573e1aa2fd@themaw.net>
Date: Wed, 1 Apr 2026 10:10:55 +0800
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
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20260331-engste-raushalten-f66cd264ce77@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/3/26 17:39, Christian Brauner wrote:
> On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
>> If there's a very large number of children present in a directory dentry
>> then the benifit from retaining stale child dentries for re-use can
>> become ineffective. Even hashed lookup can become ineffective as hash
>> chains grow, time taken to umount a file system can increase a lot, as
>> well as child dentry traversals resulting in lock held too long log
>> messages.
> Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")

I'm pretty sure I saw that earlier on but had forgotten about it when I

reviewed the bug this time around. It is essentially 681ce8623567 ("vfs:

Delete the associated dentry when deleting a file") with opt-in of course.


>
> This patch introduces the concept conditionally, where the associated
> dentry is deleted only when the user explicitly opts for it during file
> removal. A new sysctl fs.automated_deletion_of_dentry is added for this
> purpose. Its default value is set to 0.

I meant to update Documentation/admin-guide/sysctl/fs.rst to also say that

setting dir-stale-max to 0 disables it. I also get the impression you might

feel better about this if the default was 0 as well.


The thing that I don't much like with the d_delete() approach is that it

fails to cater for files that have been closed and are otherwise unused

who's dentries make there way to the LRU eventually resulting in the bad

behaviour being discussed.


>
> I have no massive objections to your approach. It feels a bit hacky tbh
> as it seems to degrade performance for new workloads in favor old
> workloads. The LRU should sort this out though.

My aim was to improve performance so I'm a bit puzzled by the comment.


The problem is the sheer number of dentry objects and the consequences

of that. Hash table chains growing will affect performance, umounting

the mount will take ages, and there are cases of child dentry traversals

in the VFS. Once you get a large number of stale dentries that necessarily

need to stay linked into the structures to get the benefit of caching your

exposed to this problem.


The LRU mechanism is so far unable to cope with this.


Ian

>
>> But when a directory dentry has a very large number of children the
>> parent dentry reference count is dominated by the contribution of its
>> children. So it makes sense to not retain dentries if the parent
>> reference count is large.
>>
>> Setting some large high water mark (eg. 500000) over which dentries
>> are discarded instead of retained on final dput() would help a lot
>> by preventing dentry caching contributing to the problem.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>   Documentation/admin-guide/sysctl/fs.rst |  7 +++++++
>>   fs/dcache.c                             | 28 +++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
>> index 9b7f65c3efd8..7649254f2d0d 100644
>> --- a/Documentation/admin-guide/sysctl/fs.rst
>> +++ b/Documentation/admin-guide/sysctl/fs.rst
>> @@ -75,6 +75,13 @@ negative dentries which do not map to any files. Instead,
>>   they help speeding up rejection of non-existing files provided
>>   by the users.
>>   
>> +dir-stale-max
>> +-------------
>> +
>> +Used to limit the number of stale child dentries retained in a
>> +directory before the benifit of caching the dentry is negated by
>> +the cost of traversing hash buckets during lookups or enumerating
>> +the directory children. Initially set to 500000.
>>   
>>   file-max & file-nr
>>   ------------------
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 7ba1801d8132..298b4c3b1493 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -86,6 +86,14 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
>>   
>>   EXPORT_SYMBOL(rename_lock);
>>   
>> +static long dsm_zero = 0;
>> +static long dsm_max = ULONG_MAX/2;
>> +
>> +/* Highwater mark for number of stale entries in a directory (loosely
>> + * measured by parent dentry reference count).
>> + */
>> +static unsigned long dir_stale_max __read_mostly = 500000;
>> +
>>   static struct kmem_cache *__dentry_cache __ro_after_init;
>>   #define dentry_cache runtime_const_ptr(__dentry_cache)
>>   
>> @@ -216,6 +224,15 @@ static const struct ctl_table fs_dcache_sysctls[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   		.extra2		= SYSCTL_ONE,
>>   	},
>> +	{
>> +		.procname	= "dir-stale-max",
>> +		.data		= &dir_stale_max,
>> +		.maxlen		= sizeof(dir_stale_max),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_doulongvec_minmax,
>> +		.extra1		= &dsm_zero,
>> +		.extra2		= &dsm_max,
>> +	},
>>   };
>>   
>>   static const struct ctl_table vm_dcache_sysctls[] = {
>> @@ -768,6 +785,17 @@ static inline bool retain_dentry(struct dentry *dentry, bool locked)
>>   	if (unlikely(d_flags & DCACHE_DONTCACHE))
>>   		return false;
>>   
>> +	if (dir_stale_max) {
>> +		unsigned long p_count;
>> +
>> +		// If the parent reference count is higher than some large value
>> +		// its dominated by the contribution of its children so there's
>> +		// no benefit caching the dentry over re-allocating it.
>> +		p_count = READ_ONCE(dentry->d_parent->d_lockref.count);
>> +		if (unlikely(p_count > dir_stale_max))
>> +			return false;
>> +	}
>> +
>>   	// At this point it looks like we ought to keep it.  We also might
>>   	// need to do something - put it on LRU if it wasn't there already
>>   	// and mark it referenced if it was on LRU, but not marked yet.
>> -- 
>> 2.53.0
>>
