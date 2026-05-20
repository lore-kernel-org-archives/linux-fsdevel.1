Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B82C158A;
	Wed, 20 May 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261391; cv=none; b=dYJU2563+0Nx1rHpyEvPhn4GMBW1Rz1Rwu2zs4WQCDLyKYHSHVKdivEZhtXnFgr/Jd0nVER8AHXAEWi5CvL1mAImuol37V0j5PO7Kf3JvUjd4X9pEzlg1x5yUWA+E4rFpxpiCeDrlDEZ+72v19cMLp+c11peFIwMc4sdVMM1btU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261391; c=relaxed/simple;
	bh=hvsGGCP+PIu29jATQJuWFBPCl6eRoVP1pHoMNul/pc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NviQLnRRqppvTSITEmvwaV3+6M4DyJD5/fGCRZMUEGS5LijDTm9z9tYmvnfn9Vi6+ZUs8jcvYLJOzFBCQmmkUhlbhqxsxqgHHfmnm4LeEsifr9thi9tq/F5QMJmTNbfJLr7nBH+4gkF4ZeNMIAy+8WdFtyH2bkav57pQB5wIJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=iyk1+pV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ogt8dQC1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="iyk1+pV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ogt8dQC1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74FE67A010F;
	Wed, 20 May 2026 03:16:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 20 May 2026 03:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779261387;
	 x=1779347787; bh=nhXjvElrvKrDTWdkQ6UTfpQksXw+a5dSKTmQdegN2Ww=; b=
	iyk1+pV3yKgGPOaYJoM8OOVtPjQqOxQHFbXB5ksv01yGBDz9MYB3UTQViTw7CviZ
	wSzM+X5YMFr9icSB2JBwcsTxlImAoVPMn+ECioITABaYEtOnxCVb+tlHZilo3o6M
	9KiqpFrLzw6F3hBxZbtl3W09+8SyEtFHDfkZcgFw2o6jVTYSF03js9s3bWPjMoxF
	QDAmuuyGpjhWCDJ/zI+XmUffA98WdHv/6pgCxVsw+QyLe50+Z4W6Ja97vJQQqwQu
	v933BfLKu4G11JLjRdJ+SjeK4W2DlDas6xMSlCSSUVMdq+JaNNDAU7ybrccA9ZCc
	DlRUQL9RQrZYg4auplgVAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779261387; x=
	1779347787; bh=nhXjvElrvKrDTWdkQ6UTfpQksXw+a5dSKTmQdegN2Ww=; b=O
	gt8dQC1rePvMxOlg3oCxYCzJH8ymOn1fE8oLGiBVZMaIXTSBUwt75gka9ZOkosvD
	xthNnV4ldLKaQKPZ7j61nWk7jqD74Fq5S6NkOrfvD0WhomuO5/Dta3z0sCGJECj0
	69uZttH0rcaxN0bDFJhkm5EhbEmJktDBsVJq5pZvS9dvLtYU6xdXvUrz4Pp72XDx
	BjIK6Dv7kojEIkOcQe1B4Cis1UwNj3AWrWl5rF6Jth0fGOwHKln8BKVI9O2+Gg+P
	ofqtrVBzOWAObAsaVekp+OX5mUiwZ0HBBMn/74s19i7eIp0Z8DjDlnKE6mtM/Wot
	IDrlvsMtJermGd5ZnrPbQ==
X-ME-Sender: <xms:yV8NajG1bSeW4NnTfMxLZqbZAexYSRnkIMb-h6xqSmviAOUz6nzU7A>
    <xme:yV8NalhzLBIpvUuCNAEJ0UR3o1ywD_2ll42don7vq44v7R0GeEzh9VBK3CaPEvEyn
    TrbplnZWG_ew7A1JEVuue7nEtnka7I__N1YNtqasR3EYj-q>
X-ME-Received: <xmr:yV8Naoi0GHEKskKu_h-N1xkA9Bmy59zAsJKAxvo7TX-Wrzm04S0Yucr8urfURbEKZaClD2_y1K-5dzJHjuB7ByrxybFosAPcS5ytqErM-un8cwgBDYUsokg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnheptd
    dugfehtddugfefgfdtjeeguddttdevfeehtedvfeeufefggffgvdeileetffegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepnhgvihhlsegsrh
    hofihnrdhnrghmvgdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdrtgho
    mhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheptghorhgsvghtsehlfihn
    rdhnvghtpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yV8NaglNNVWd8IYwZLT_b03vi_BiO5sTpjBr7mXM9CzUXw4qk281GA>
    <xmx:yV8NakZ2r98cosb95Sak3NbWNmpy-Lk4JQkROnrCtiJyhtWE74ZcdA>
    <xmx:yV8Nary_YN8oPXPNCstu2oh5UCGRgJFNP4FnxU77eneOvL-4RGm9LA>
    <xmx:yV8NajYcgBQ6DPsxbdNMySRNibpKKfGWAHHNaXZM_N37MrZntCpEnA>
    <xmx:y18NaiDhyn_bS5xp1DLdVFvyERPmaAOznPyw0shayLck794PzfeTGif8>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 03:16:21 -0400 (EDT)
Message-ID: <27a5593e-ffb8-4471-996f-7983bac0b1ab@themaw.net>
Date: Wed, 20 May 2026 15:16:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Horst Birthelmer <horst@birthelmer.com>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
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
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <fglq7n2brxwdsu7and6nt6xpgdziua754yzgxkmd33pmk6tor4@noxa5ajva7wg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/5/26 17:12, Jan Kara wrote:
> On Mon 18-05-26 21:39:13, Ian Kent wrote:
>> On 18/5/26 16:19, Jan Kara wrote:
>>> Hi Ian,
>>>
>>> On Mon 18-05-26 10:55:43, Ian Kent wrote:
>>>> On 18/5/26 07:55, NeilBrown wrote:
>>>>> On Fri, 15 May 2026, Horst Birthelmer wrote:
>>>>> According to the email you linked, a problem arises when a directory has
>>>>> a great many negative children.  Code which walks the list of children
>>>>> (such as fsnotify) while holding a lock can suffer unpredictable delays
>>>>> and result in long lock-hold times.  So maybe a limit on negative
>>>>> dentries for any parent is what we really want.  That would be clumsy to
>>>>> implement I imagine.
>>>> But the notion of dropping the dentry in ->d_delete() on last dput() is
>>>> simple enough but did see regressions (the only other place in the VFS
>>>> besides dentry_kill() that the inode is unlinked from the dentry on
>>>> dput()). I wonder if the regression was related to the test itself
>>>> deliberately recreating deleted files and if that really is normal
>>>> behaviour. By itself that should prevent almost all negative dentries
>>>> being retained. Although file systems could do this as well (think XFS
>>>> inode recycling) it should be reasonable to require it be left to the
>>>> VFS.
>>>>
>>>> But even that's not enough given that, in my case, there would still be
>>>> around 4 million dentries in the LRU cache and in fsnotify there are
>>>> directory child traversals holding the parent i_lock "spinlock" that are
>>>> going to cause problems.
>>> Do you mean there are very many positive children of a directory?
>> Didn't quantify that.
>>
>> The symptom is the "Spinlock held for more than ... seconds" occurring in
>> the log. So there are certainly a lot of children in the list, but it's
>> an assumption the ratio of positive to negative entries is roughly the
>> same as the overall ratio in the dcache.
> OK, but that's not necessarily true. I have seen these complaints from the
> kernel but in all the cases I remember it was due to negative dentries
> accumultating in a particular directory. There are certain apps such as
> ElasticSearch which really do like creating huge amounts of negative
> dentries in one directory - they use hashes as filenames and use directory
> lookup instead of a DB table lookup and lookup lots of non-existent keys...

Umm ... that's a good point, I hadn't paid much attention to ENOENT result

lookups, I'll need to check on the like cycle of those, I think they do get

hashed. That has to be the other source of negative dentries that I've

neglected ...

>
>>>> so why is this traversal even retained in fsnotify?
>>> Not sure which traversal you mean but if you set watch on a parent, you
>>> have to walk all children to set PARENT_WATCHED flag so that you don't miss
>>> events on children...
>> Yes, that traversal is what I'm questioning ... again thanks.
>>
>> I think the function name is still fsnotify_set_children_dentry_flags()
>> in recent kernels, the subject of commit 172e422ffea2 I mentioned above.
> OK, thanks.
>
>> When you say miss events are you saying that accessing the parent dentry to
>> work out if the child needs to respond to an event is quite expensive in the
>> overall event processing context, that might make more sense to me ... or do
>> I completely not yet understand the reasoning behind the need for the flag?
> Close but not quite. The cost is the overhead of dget_parent() in
> fsnotify_parent() which is often a couple of cache cold loads and atomic
> instructions to find out we don't need to send any event for the current
> write(2) or read(2) call. It gets worse if there are many IOs happening to
> dentries in the same directory from multiple CPUs because instead of
> cache-cold loads you get a cacheline contention on the parent.
>
>>>>> But what if we move dentries to the end of the list when they become
>>>>> negative, and to the start of the list when they become positive?  Then
>>>>> code which walks the child list could simply abort on the first
>>>>> negative.
>>>>>
>>>>> I doubt that would be quite as easy as it sounds, but it would at least
>>>>> be more focused on the observed symptom rather than some whole-system
>>>>> number which only vaguely correlates with the observed symptom.
>>>>>
>>>>> Maybe a completely different approach: change children-walking code to
>>>>> drop and retake the lock (with appropriate validation) periodically.
>>>>> What too would address the specific symptom.
>>>> Another good question.
>>>>
>>>> I have assumed that dropping and re-taking the lock cannot be done but
>>>> this is a question I would like answered as well. Dropping and re-taking
>>>> lock would require, as Miklos pointed out to me off-list, recording the
>>>> list position with say a cursor, introducing unwanted complexity when it
>>>> would be better to accept the cost of a single extra access to the parent
>>>> flags (which I assume is one reason to set the flag in the child).
>>> The parent access is actually more expensive than you might think. Based on
>>> experience with past fsnotify related performance regression I expect some
>>> 20% performance hit for small tmpfs writes if you add unconditional parent
>>> access to the write path.
>> That sounds like a lot for what should be a memory access of an already in
>> memory structure since the parent must be accessed to traverse the list of
>> child entries. I clearly don't fully understand the implications of what
>> I'm saying but there has been mention of another context ...
> Parent dentry is of course in memory but often cache cold - you don't need
> the parent to do e.g. write(2) to an already open file. You seem to be
> somewhat confused about the child dentry list traversal (or maybe I'm
> misunderstanding) - that happens only when placing the notification mark
> but definitely not for each IO operation.

LOL, confusion is a pretty common state of mind for me!


I do get your point though and I am confusing the traversal with other

operations. I think this answers the question I've been asking (maybe

that wasn't obvious) about the reason for the traversal (ie. the reason

to maintain a flag in the child).


While I have looked at the code here I haven't absorbed it and I

definitely don't understand it, your continued patience is appreciated

and will be beneficial when I get time to look at it a bit closer. I

do still need to use a notifications mechanism to match up with Miklos's

statmount implementation to get the full benefit of that in user space,

if I ever get a chance to work on that again.


So it sounds like it would be worth while considering a traversal that's

based on taking a reference on each dentry rather than a spinlock for

the duration. It would be tricky though, for obvious reasons, like

children added during the traversal, added overhead of getting the next

entry reference, etc.


Ian

