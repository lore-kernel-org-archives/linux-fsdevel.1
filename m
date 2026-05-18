Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E8365A03;
	Mon, 18 May 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111565; cv=none; b=azV0JiVk7mXuR6Yj3vUq3DPVuC/aqTogjuwEDlAuPTmHQq4z6sduHx0jU7X1H/c6Asat50y2S0VqanTdaBLYEYJ1sXV2NvsUfzPgEYET+BzcSffDR9ceYJqg3gzYCRSAnHXRImANxwrdRyTkEmYZzxSPmwhDo8JjS8nrwCUbtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111565; c=relaxed/simple;
	bh=Ax0WKjvnrLQYP+WN6gDmkVHQuFNsuMDV+mcdRnhjdQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAG5I729ebcA2nXpJHSN2dOAW2NVPVj2vj+ta7znXvR56GeoMbGqxu7h1fHyuY9ll3tc8HtYlOd3qAO8wXoTU+UyePX4yP3edtPbafqTwAcOM74DDk9bfmwZf5BqLlWfoXDgUGYBDp0bBo7rWM+ARWX7edTjem25OB+SN0n3ECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=C46c/tY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HEjO6jHG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="C46c/tY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HEjO6jHG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60459140012F;
	Mon, 18 May 2026 09:39:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 18 May 2026 09:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779111562;
	 x=1779197962; bh=Jh4Jy85DHtL5Dofgf2VoGwuUEUWluDXNfww3p4oIvZM=; b=
	C46c/tY4t71h2TNRmI6Shz8J3un8T2lc0hbThhnvbqcZpoaZvOp7dlkJzoKSnDw9
	54dvjZzrk5Nh/cScjZulesJi6DQw9KMCAI3J0e8S5sIGx1lWSk+6rFDLpk4MVuaw
	6pXEnCS+txscyidCWqiSjGCSzS2Gyt/MDaZeiHVzvdRZcAQVCopskLk4rBbcGc9Q
	Q6KQwG+BeZAqFyINNWsuYhJHO67NO1wc+G8B1yTlgMkbDFRDxBNz2nRjoM6ZKRpX
	PP2z6J+UAC98iaEW6kJb45/djkfr9d5KzKdMf/N0/vuWzXNx6sBG9rHUeGsE0QeV
	+y4dUd5JxJOjWJGcvIPYzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779111562; x=
	1779197962; bh=Jh4Jy85DHtL5Dofgf2VoGwuUEUWluDXNfww3p4oIvZM=; b=H
	EjO6jHGub4ILoCd9bD+TeimLHtCCuZt1DgFhZA07qq/CC8+bco0n3AisOd3HWMkt
	xUn9BF1icCDVdrR1S4hEdWrmrXrj/hK4xdB/yiTwWAp+0bjj4UiwaM8o8UsB4v8Z
	GMj+zRfTXELYWqwGuuOeUpPP5ATTo/4W3NQ7g4vKeBf665FdZQHxdsyGMvcyi+ER
	PpGrtoYtgUxS+6BqMD8U4a7ncMoB3gowhi044X0ru2HkTHxWkjB1a5W4NoE7SI4c
	wMpi0wFJGwH0j+6H+6UaXGDGr7hlcH0rlNHpkuOSiuHJyGDHsO2d4uZ5xWFTFzDB
	nW0+9DsVHskNNTuyaUi8w==
X-ME-Sender: <xms:iRYLasepmOYDs3idU5FMfeirAs88sKlwXxqq72WKvoj2OUOBNQcs_Q>
    <xme:iRYLajZbfZ0NjP77PIIGSSkWyiLKquAQQmHzWwrxeJCBgh52i2xsP1U8XI_EuWufR
    xuvg1kp__3c8NsR622ljlD6-YtHlFeIH3Zoid5qI2oR-Dkh>
X-ME-Received: <xmr:iRYLag7ihLeUzohNsNvNBxdRc2mrMM-Y3kAJha1sntqGhTtPkXIxlnxF_X0uABL76janE3DMkoxqZfbezKCtrQabc5dW1U_1CJm1lscXSP4c20RbhIZA44k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeltdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:iRYLahcTs63l5hDDUDJp-RO67-wOweTT-PzDSPM2beOSNLkjNmug7Q>
    <xmx:iRYLajxeFUZWWhINJRURD9GbIob8Bgs6VWC1nJA7LmqmLf1UwmYFdA>
    <xmx:iRYLanqH8zGncV0MsoW_965l4du3Zf44kgc54yzpKdaNwrWO4jfyPQ>
    <xmx:iRYLahzcmwNI_fY3Lusgu5VMjJpZLKkA2ks18PmhxyVPvSIiPeU8jw>
    <xmx:ihYLar43V63O2qxIZtAWTLoKu8uWBeFxhHCPYLQ0L_iChaCBFLN1WkIw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 09:39:16 -0400 (EDT)
Message-ID: <b320ff9a-7f6f-44c3-940f-33f79cc5569f@themaw.net>
Date: Mon, 18 May 2026 21:39:13 +0800
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
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <yk2hem4zwinm4glenpc74to7sm5kyriksgwn6mxh7t4saotiba@7zik7jcnbs5m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/5/26 16:19, Jan Kara wrote:
> Hi Ian,
>
> On Mon 18-05-26 10:55:43, Ian Kent wrote:
>> On 18/5/26 07:55, NeilBrown wrote:
>>> On Fri, 15 May 2026, Horst Birthelmer wrote:
>>> According to the email you linked, a problem arises when a directory has
>>> a great many negative children.  Code which walks the list of children
>>> (such as fsnotify) while holding a lock can suffer unpredictable delays
>>> and result in long lock-hold times.  So maybe a limit on negative
>>> dentries for any parent is what we really want.  That would be clumsy to
>>> implement I imagine.
>> But the notion of dropping the dentry in ->d_delete() on last dput() is
>> simple enough but did see regressions (the only other place in the VFS
>> besides dentry_kill() that the inode is unlinked from the dentry on
>> dput()). I wonder if the regression was related to the test itself
>> deliberately recreating deleted files and if that really is normal
>> behaviour. By itself that should prevent almost all negative dentries
>> being retained. Although file systems could do this as well (think XFS
>> inode recycling) it should be reasonable to require it be left to the
>> VFS.
>>
>> But even that's not enough given that, in my case, there would still be
>> around 4 million dentries in the LRU cache and in fsnotify there are
>> directory child traversals holding the parent i_lock "spinlock" that are
>> going to cause problems.
> Do you mean there are very many positive children of a directory?

Didn't quantify that.


The symptom is the "Spinlock held for more than ... seconds" occurring

in the log. So there are certainly a lot of children in the list, but

it's an assumption the ratio of positive to negative entries is roughly

the same as the overall ratio in the dcache.


>
>> That's all that much more puzzling when I see things like commit
>> 172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily") which looks
>> like it implies the child flag depends entirely on the parent state (what
>> am I missing Amir?)
> PARENT_WATCHED dentry flags (as the name suggests) are only caching the
> information whether the parent has notification marks receiving events from
> the child. So yes, the flag fully depends on the parent state.

Ok, this is something I was after, I will keep looking at the fsnotify

code since there is something to find, thanks for that.


>
>> so why is this traversal even retained in fsnotify?
> Not sure which traversal you mean but if you set watch on a parent, you
> have to walk all children to set PARENT_WATCHED flag so that you don't miss
> events on children...

Yes, that traversal is what I'm questioning ... again thanks.


I think the function name is still fsnotify_set_children_dentry_flags() in

recent kernels, the subject of commit 172e422ffea2 I mentioned above.


When you say miss events are you saying that accessing the parent dentry to

work out if the child needs to respond to an event is quite expensive in the

overall event processing context, that might make more sense to me ... or do

I completely not yet understand the reasoning behind the need for the flag?


>
>>> But what if we move dentries to the end of the list when they become
>>> negative, and to the start of the list when they become positive?  Then
>>> code which walks the child list could simply abort on the first
>>> negative.
>>>
>>> I doubt that would be quite as easy as it sounds, but it would at least
>>> be more focused on the observed symptom rather than some whole-system
>>> number which only vaguely correlates with the observed symptom.
>>>
>>> Maybe a completely different approach: change children-walking code to
>>> drop and retake the lock (with appropriate validation) periodically.
>>> What too would address the specific symptom.
>> Another good question.
>>
>> I have assumed that dropping and re-taking the lock cannot be done but
>> this is a question I would like answered as well. Dropping and re-taking
>> lock would require, as Miklos pointed out to me off-list, recording the
>> list position with say a cursor, introducing unwanted complexity when it
>> would be better to accept the cost of a single extra access to the parent
>> flags (which I assume is one reason to set the flag in the child).
> The parent access is actually more expensive than you might think. Based on
> experience with past fsnotify related performance regression I expect some
> 20% performance hit for small tmpfs writes if you add unconditional parent
> access to the write path.

That sounds like a lot for what should be a memory access of an already in

memory structure since the parent must be accessed to traverse the list of

child entries. I clearly don't fully understand the implications of what

I'm saying but there has been mention of another context ...


Nevertheless more useful information, ;)


Thanks again,

Ian

