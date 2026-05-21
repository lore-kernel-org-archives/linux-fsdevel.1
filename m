Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8A156661;
	Thu, 21 May 2026 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324920; cv=none; b=nQ8o3h/uY/w3YMke1LInDXXIqddCZ72grEAkOT82o53so3/nbyZoIoxaIgTkkuGaeXQYjSfUG6qAZl8tGpRD0R+Om6iag8xXxHZtJlEYX5SRrAC4R/myeeH456Tj9l5SwUEYoaRt7IBFtR85wnukNwClF8kXIPGXL+yq/ayOgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324920; c=relaxed/simple;
	bh=bjmEflaZ/4mWa+GRntV7vVAMgmQWfigdQp7L7IM5o7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFfNU9B6BSq8iZNVgIs/dx1ppAjnrlDpMSSBQVel9AtI8K2+N0ppXq0+fSFTI+DipGMpARPGGYeGYUhdF+SSJ8IdNT+IQfx4Yyih1gAMAUUdWtP7VH4XV4VS4WYt/ppK6iMzAbLMj7q50Mjg7Y2iIcEyexBZkjgnak0mFMiNoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=JzGPkHUx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mz+Dw3om; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="JzGPkHUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mz+Dw3om"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07BFA14000A9;
	Wed, 20 May 2026 20:55:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 20:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779324917;
	 x=1779411317; bh=44MW/rOj+MFrSGBt+EzsxsPYNMCU8m6kMxuoxevzaRs=; b=
	JzGPkHUxPTb9JwXWH9bSsY8j8FFyzwxK9l6mZKrCDGX70rNoIyx4Senu4ugrD+xi
	9PSCZNe+0q/siF7ZQ2ani7rP0scgmCNrVGhoaXDG80AJ3DQwwFXTLbsBVXw1EEJc
	0V6D7J0VIfIUf1fUOjbisMyLTFwvZjCbaxZrecHoGTdXR0N8/sq25kfwCPd/kEZl
	mKo+7ub41WU2jgkuJ8hweQY9twUwj/PL9X9BP3AGR00bMSMp2qBwbu39EnHIKqZR
	TQ3EnG8ig3wZ7QNgq08aGLuYcmzrbVvK/3mkFE5Q9JqsSdPlx8W5iU5Y7JN7HNfy
	nsCPeRJ1QwRzTD6ebaYjfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779324917; x=
	1779411317; bh=44MW/rOj+MFrSGBt+EzsxsPYNMCU8m6kMxuoxevzaRs=; b=m
	z+Dw3om5JfZfrIeUcEBhl1ORKGyGjjvZXhlVp8rqV5T8kYsJz7q0LACVeLOsD9CZ
	301PdCFFmjeA74YhYJMF4JFJ2XtnipXsf2iYKsOylrq/a1lQe+O1Y2ESTjJcTIBF
	q/CcMuNnW234F6Q/rZo91nPvXxNCa7rV2slrqVmtDKgJHo9CmCF//StDtOkzQau1
	atpoCY7ja7fZg7IGS81dfR9VYENZW/H7NveWx5AiKa3RojTH7c8n8fatEuJHC1XV
	RdM1HaCicCo/1M+pZJEyz0ZChWOJaw/MATNYui1DQOMnrjHlG3vuaJNtpQ5jkrfm
	RV4/w9E4xtSmEeHZu/2yg==
X-ME-Sender: <xms:9FcOajZpgIZNuwgof8698inl44K89_XmbQcxtu1AybHfxguVvOAnLQ>
    <xme:9FcOanmXe6XEuZ44xGCrM18ZyvNnA_YO9Q6TFO9PVo1Ll1Pq5GQrjWQoxHwBuiAgs
    nlHGlW2X8aHo-5PFHqxxSoEIymhVJ9qp3lpr76GBmAdNnmz>
X-ME-Received: <xmr:9FcOapW8rDDHBdNUGx4w5vmHuCOQS_avLan3T96o8AXx72Cbu0z6ZDRAFfE8rTZ2FnDQXU-4WUSo8AgJ22ryLvcAxpUMYMVM2z-0hkuZvN5oaCw0eVcAjtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnheptd
    dugfehtddugfefgfdtjeeguddttdevfeehtedvfeeufefggffgvdeileetffegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    grtghksehsuhhsvgdrtgiipdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdp
    rhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdrtghomhdprhgtphhtthhope
    hmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheptghorhgsvghtsehlfihn
    rdhnvghtpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9FcOapJodJjyKCJ6xE1-t4pTzPgbMIIN92OlaOLnghw_m_aCE6hwfw>
    <xmx:9FcOaptFl2QRJkiBJu-6pWYixXRhw7mX9qRQkA7ltLd5ltilTRyCGQ>
    <xmx:9FcOau1ktpKeYykc0HwhbMQfU84q0IK1YiryrxH4Fe9fkcaXvreusg>
    <xmx:9FcOahN4jSkl969C2RO7PLwBr_u0FkAKBccg3wLnk0XoRpOGh4E3uw>
    <xmx:9VcOahV4iboYScAVmwU6Ljd2mUUQEoL7F0ayNHDxd0hme9kYFpHQfCuH>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 20:55:11 -0400 (EDT)
Message-ID: <0c8fc005-e485-494a-8598-07b617c87b62@themaw.net>
Date: Thu, 21 May 2026 08:55:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>,
 Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
 <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
 <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net>
 <yk2hem4zwinm4glenpc74to7sm5kyriksgwn6mxh7t4saotiba@7zik7jcnbs5m>
 <b320ff9a-7f6f-44c3-940f-33f79cc5569f@themaw.net>
 <fglq7n2brxwdsu7and6nt6xpgdziua754yzgxkmd33pmk6tor4@noxa5ajva7wg>
 <27a5593e-ffb8-4471-996f-7983bac0b1ab@themaw.net>
 <CAOQ4uxg-7Tsb0GWF4LN3iFBaY7uGxR5_7PwBF+GfMWtCdfi4xw@mail.gmail.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <CAOQ4uxg-7Tsb0GWF4LN3iFBaY7uGxR5_7PwBF+GfMWtCdfi4xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20/5/26 17:43, Amir Goldstein wrote:
> On Wed, May 20, 2026 at 9:16 AM Ian Kent <raven@themaw.net> wrote:
>> On 19/5/26 17:12, Jan Kara wrote:
>>> On Mon 18-05-26 21:39:13, Ian Kent wrote:
>>>> On 18/5/26 16:19, Jan Kara wrote:
>>>>> Hi Ian,
>>>>>
>>>>> On Mon 18-05-26 10:55:43, Ian Kent wrote:
>>>>>> On 18/5/26 07:55, NeilBrown wrote:
>>>>>>> On Fri, 15 May 2026, Horst Birthelmer wrote:
>>>>>>> According to the email you linked, a problem arises when a directory has
>>>>>>> a great many negative children.  Code which walks the list of children
>>>>>>> (such as fsnotify) while holding a lock can suffer unpredictable delays
>>>>>>> and result in long lock-hold times.  So maybe a limit on negative
>>>>>>> dentries for any parent is what we really want.  That would be clumsy to
>>>>>>> implement I imagine.
>>>>>> But the notion of dropping the dentry in ->d_delete() on last dput() is
>>>>>> simple enough but did see regressions (the only other place in the VFS
>>>>>> besides dentry_kill() that the inode is unlinked from the dentry on
>>>>>> dput()). I wonder if the regression was related to the test itself
>>>>>> deliberately recreating deleted files and if that really is normal
>>>>>> behaviour. By itself that should prevent almost all negative dentries
>>>>>> being retained. Although file systems could do this as well (think XFS
>>>>>> inode recycling) it should be reasonable to require it be left to the
>>>>>> VFS.
>>>>>>
>>>>>> But even that's not enough given that, in my case, there would still be
>>>>>> around 4 million dentries in the LRU cache and in fsnotify there are
>>>>>> directory child traversals holding the parent i_lock "spinlock" that are
>>>>>> going to cause problems.
>>>>> Do you mean there are very many positive children of a directory?
>>>> Didn't quantify that.
>>>>
>>>> The symptom is the "Spinlock held for more than ... seconds" occurring in
>>>> the log. So there are certainly a lot of children in the list, but it's
>>>> an assumption the ratio of positive to negative entries is roughly the
>>>> same as the overall ratio in the dcache.
>>> OK, but that's not necessarily true. I have seen these complaints from the
>>> kernel but in all the cases I remember it was due to negative dentries
>>> accumultating in a particular directory. There are certain apps such as
>>> ElasticSearch which really do like creating huge amounts of negative
>>> dentries in one directory - they use hashes as filenames and use directory
>>> lookup instead of a DB table lookup and lookup lots of non-existent keys...
>> Umm ... that's a good point, I hadn't paid much attention to ENOENT result
>>
>> lookups, I'll need to check on the like cycle of those, I think they do get
>>
>> hashed. That has to be the other source of negative dentries that I've
>>
>> neglected ...
>>
> Yes, it has been claimed that some real life workloads create a lot of those.
>
> If we can keep those at the tail of the children list, it will be best
> for the fsnotify
> iteration, which only cares about positive dentries.
>
>>>>>> so why is this traversal even retained in fsnotify?
>>>>> Not sure which traversal you mean but if you set watch on a parent, you
>>>>> have to walk all children to set PARENT_WATCHED flag so that you don't miss
>>>>> events on children...
>>>> Yes, that traversal is what I'm questioning ... again thanks.
>>>>
>>>> I think the function name is still fsnotify_set_children_dentry_flags()
>>>> in recent kernels, the subject of commit 172e422ffea2 I mentioned above.
>>> OK, thanks.
>>>
>>>> When you say miss events are you saying that accessing the parent dentry to
>>>> work out if the child needs to respond to an event is quite expensive in the
>>>> overall event processing context, that might make more sense to me ... or do
>>>> I completely not yet understand the reasoning behind the need for the flag?
>>> Close but not quite. The cost is the overhead of dget_parent() in
>>> fsnotify_parent() which is often a couple of cache cold loads and atomic
>>> instructions to find out we don't need to send any event for the current
>>> write(2) or read(2) call. It gets worse if there are many IOs happening to
>>> dentries in the same directory from multiple CPUs because instead of
>>> cache-cold loads you get a cacheline contention on the parent.
>>>
>>>>>>> But what if we move dentries to the end of the list when they become
>>>>>>> negative, and to the start of the list when they become positive?  Then
>>>>>>> code which walks the child list could simply abort on the first
>>>>>>> negative.
>>>>>>>
>>>>>>> I doubt that would be quite as easy as it sounds, but it would at least
>>>>>>> be more focused on the observed symptom rather than some whole-system
>>>>>>> number which only vaguely correlates with the observed symptom.
>>>>>>>
>>>>>>> Maybe a completely different approach: change children-walking code to
>>>>>>> drop and retake the lock (with appropriate validation) periodically.
>>>>>>> What too would address the specific symptom.
>>>>>> Another good question.
>>>>>>
>>>>>> I have assumed that dropping and re-taking the lock cannot be done but
>>>>>> this is a question I would like answered as well. Dropping and re-taking
>>>>>> lock would require, as Miklos pointed out to me off-list, recording the
>>>>>> list position with say a cursor, introducing unwanted complexity when it
>>>>>> would be better to accept the cost of a single extra access to the parent
>>>>>> flags (which I assume is one reason to set the flag in the child).
>>>>> The parent access is actually more expensive than you might think. Based on
>>>>> experience with past fsnotify related performance regression I expect some
>>>>> 20% performance hit for small tmpfs writes if you add unconditional parent
>>>>> access to the write path.
>>>> That sounds like a lot for what should be a memory access of an already in
>>>> memory structure since the parent must be accessed to traverse the list of
>>>> child entries. I clearly don't fully understand the implications of what
>>>> I'm saying but there has been mention of another context ...
>>> Parent dentry is of course in memory but often cache cold - you don't need
>>> the parent to do e.g. write(2) to an already open file. You seem to be
>>> somewhat confused about the child dentry list traversal (or maybe I'm
>>> misunderstanding) - that happens only when placing the notification mark
>>> but definitely not for each IO operation.
>> LOL, confusion is a pretty common state of mind for me!
>>
>>
>> I do get your point though and I am confusing the traversal with other
>>
>> operations. I think this answers the question I've been asking (maybe
>>
>> that wasn't obvious) about the reason for the traversal (ie. the reason
>>
>> to maintain a flag in the child).
>>
>>
>> While I have looked at the code here I haven't absorbed it and I
>>
>> definitely don't understand it, your continued patience is appreciated
>>
>> and will be beneficial when I get time to look at it a bit closer. I
>>
>> do still need to use a notifications mechanism to match up with Miklos's
>>
>> statmount implementation to get the full benefit of that in user space,
>>
>> if I ever get a chance to work on that again.
>>
>>
>> So it sounds like it would be worth while considering a traversal that's
>>
>> based on taking a reference on each dentry rather than a spinlock for
>>
>> the duration. It would be tricky though, for obvious reasons, like
>>
>> children added during the traversal, added overhead of getting the next
>>
>> entry reference, etc.
> Didn't look closely, but it feels like RCU traversal should be
> possible if entries are added to the tail, or to the END_OF_POSITIVE
> location.
>
> When we discussed the "negavites at tail" at LSFMM
> it was said that managing the transitions positive<->negative
> would be challenging, but I don't know that anyone tried to look closer at this.

I guess that should be straight forward as long as it's done at the point of

transition except if it's done by a filesystem instead of the VFS (maybe 
require

a helper be used ...). Might be a bit harder for dentries that don't 
transition

(ie. ENOENT lookups that start out and stay negative) might escape the 
needed

handling.


>
> At least for fsnotify, positive->negative transition is not a problem
> w.r.t skipping entry and observing entry twice during positive iteration.
>
> If negative->positive transitions inserts at END_OF_POSITIVE
> location, then should be fine as well?
>
> Iterators that need to iterate all children can do this under lock.

Only catch there is the number of positive children might be large as well.


>
> Does that make sense?

Yep, the notion of a cursor is a good idea.


Nevertheless the challenge is to identify dentries that should be discarded

rather than kept at final dput() in addition to what we already have in 
dout()

but there doesn't seem to be anything sensible to add to those checks.


On a different note another possibility to identify candidates to discard on

traversals might be a ttl, basically an extension of the referenced 
flag. The

dentry d_time field could be used for that but only for negative 
dentries since,

IIRC, nfs uses that dentry field.


But now I'm not sure I'm making sense as a couple of your comments sound 
like

they refer to a discussion I'm not aware of, ;)


Ian

