Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3037F8D6
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020175; cv=none; b=PMA7dqJPr9+USqgZjnw0TqJ8XTWyMNJFgZVw+p6gxA6wYkN+qUhi1/3Q9teK9/Ofxt3wpWh+4ckK2Nah7NCm5ESU6KG7kiHDMR2SlbmFjQmxEuXqJeUV4l7MUf/EOypKoZ6mqAkoP9swydmYe5J7EdjcAfd0E4p508jULvFJrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020175; c=relaxed/simple;
	bh=7j3g1mEPyGqkkM/SiUjZNciPuhua1XoUhKuAuqlHCg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDJtFo+CXOZFybBizHccVFnsL2DiMOqkIrXZYgTaBqB6atIRGfownJ4JDZw9nkQUEcLNYb7OPUFf4RSM7YGEJMqH+6lgwY0BsBpbuE/ON6jYYlt9PPfJOoAPfbVg+/HsP9aTvS3BD8zbPq2jrg5nI7ZFm4fPceVDxex7D6MHrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=l0QXk1p5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elLImcjM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="l0QXk1p5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elLImcjM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36F16140014B;
	Tue,  5 May 2026 18:29:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 05 May 2026 18:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778020170;
	 x=1778106570; bh=s7upVM/4ir3b76qMqLnm1Zby5L8rIMJT1uZ9dfLnHH4=; b=
	l0QXk1p5CeKaYF1BLgnc4q97usI3bj6g12UiZ17GeHuI/XQ1xtu0ZD3d8lbEcU7g
	WrDixz//lVSP6srpafgvUEsi86TCZeRRV1LO3Cif55ykeQ+g94Dfj7tn1QFdHXPA
	YnlbdjAYOiBcMCrzApYaRcS8z8UmMX6ym5YOoBSLwKRFsXkGOAMar9LY22PPtRMM
	Vg4DLy/tryJ0up4kruC85PrS/UIJ1y1A4j+iMLwqT8bV0Sv1k2oTamamvzJ/k8kh
	stB5O9Yyo9RKn3TtLhgqvxha0iec5vcFlq3tkLHwh7EaSsZsxFznlHFZq0yN/VYn
	WYZEeF8689hXJb9etFOS5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778020170; x=
	1778106570; bh=s7upVM/4ir3b76qMqLnm1Zby5L8rIMJT1uZ9dfLnHH4=; b=e
	lLImcjM1azMX8cuN515x3LFcfd0cMg6TICWYuIUEVh4QqSn6d7Ei2pmTMHpYg2oL
	lbdmXHqL2sIOuYKySowPYPiv+LzcbMcgNm2ga2WS2vjtIVRdX0cOjNpTzcjeKmDM
	JbuMsLG1V9w7+EoQtx96LtEug5ZtA+vHBjlJxwa4c7nrTgwCsrGiawUrhMDPuTtJ
	MrbEaT12S1j3IG+38MQHOKYoClfEKb7MFwTF4WUBceroGm6+Ye9ioIgXfzxFyzSF
	jUSarQMqfMLPxHenNwg6ruudqNYuZD7vyVlLTg3Qj8dMN5gdr4cJG7FoMLWQGHkQ
	VJOyeGm2T26KXQs4VASyA==
X-ME-Sender: <xms:SW_6aZCn5gw01vpgYgUqsN8Vi0MRmBszJ8GofTEa4c54nerPXi-n2w>
    <xme:SW_6aQ0obvW5CTjZ1fcxmQy_AEB3s06YiA3171dk2lGmtZFd9qw1lu2ytLWalno8k
    T-Soo256if9P4XdERfgcggJR-92W-kMpMgUUhM_mZ13XIhBt_c>
X-ME-Received: <xmr:SW_6ab2KVBDWIg8kBgpi4hR-fTXAWFCZiz_Avw3xVvguYxItcS3vkrHTSbJbMnQgCLTxJag1WxSasenKH3Tmdq3hyG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhu
X-ME-Proxy: <xmx:SW_6aVD_EEQg3LxOkMMzWh8qk66LqkJclXgv2nrm3Ey8G1j8VDgQNw>
    <xmx:SW_6aa4LZwzHDabOTBwXdYG6HwvoKRl0kICNITbtvthL2U6acDchTQ>
    <xmx:SW_6aWJRlIN480i_8At7Oq4C1OWt62pb9WwUoxNB7qJMXKtEFrO1Yg>
    <xmx:SW_6abuO4DQR1r-IungLvvOnxbNsBKnALofjZLDfeUIBQzulvh4Bfg>
    <xmx:Sm_6aQTDNT_0QEhw8VulGAYqJIUPPA0Cw7W3HuLOJn7VmGQ3suDrsBEW>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 18:29:25 -0400 (EDT)
Message-ID: <f6487818-2c34-4650-a71c-43bae9415578@bsbernd.com>
Date: Wed, 6 May 2026 00:29:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1.1 1/2] libfuse: don't use SYNC_INIT unless asked for
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
 <20260505164428.GC7739@frogsfrogsfrogs>
 <0de919e0-7d90-4fad-bf93-656bfd28ad7d@bsbernd.com>
 <20260505220816.GS7765@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260505220816.GS7765@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 00:08, Darrick J. Wong wrote:
> On Tue, May 05, 2026 at 10:02:18PM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/5/26 18:44, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> fuse2fs calls fuse_main, then starts threads from ->init.  It doesn't
>>> call fuse_daemonize_early_start because I haven't ported it to use any
>>> of the new APIs.  I don't have io_uring enabled for fuse on my dev box.
>>>
>>> fuse_main calls fuse_session_mount calls fuse_session_mount_new_api
>>> calls session_start_sync_init.  At the start of the function,
>>> se->want_sync_init, se->uring.enable, and daemonize.active are all
>>> false.  The first branch is not taken, so we call FUSE_DEV_IOC_SYNC_INIT
>>> and enable sync_init even though the user didn't ask for that and didn't
>>> prepare for it either.
>>>
>>> FUSE_DEV_IOC_SYNC_INIT succeeds, so we send the synchronous FUSE_INIT
>>> from mount, which calls fuse2fs' init() method.  That starts the
>>> background threads and returns.  Upon return to the kernel, the mount()
>>> now succeeds, and the next thing that fuse_main does is call
>>> fuse_daemonize().  Since we didn't call fuse_daemonize_early_start, the
>>> daemonize forks the process and the threads die with the parent.
>>>
>>> If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
>>> maintain compatibility with older fuse servers that only support
>>> asynchronous FUSE_INIT.
>>>
>>> Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
>>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>>> ---
>>> v1.1: improve commit message, refine logging logic
>>> ---
>>>  lib/fuse_lowlevel.c |   18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>>> index 0e16845d2f14ff..83158d02bb8827 100644
>>> --- a/lib/fuse_lowlevel.c
>>> +++ b/lib/fuse_lowlevel.c
>>> @@ -4475,9 +4475,21 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
>>>  {
>>>  	int err, res;
>>>  
>>> -	if (!se->want_sync_init &&
>>> -		(se->uring.enable && !fuse_daemonize_is_used())) {
>>> -		if (se->debug)
>>> +	if (!se->want_sync_init) {
>>> +		/*
>>> +		 * SYNC_INIT is required for io_uring to initialize without
>>> +		 * deadlocking the kernel if the fuse server crashes.
>>> +		 *
>>> +		 * !fuse_daemonize_is_used implies the fuse server doesn't know
>>> +		 * about any of the SYNC_INIT APIs, so we don't enable sync
>>> +		 * init or generate log messages.
>>> +		 */
>>> +		if (se->uring.enable)
>>> +			fuse_log(FUSE_LOG_DEBUG,
>>> +					"fuse: io_uring broken with async init\n");
>>
>> So want_sync_init is not enabled and it still logs this? Note that
>> default libfuse does not have a way to set log levels.
> 
> I'm not 

I need to work on libfuse log level setting, the current way doesn't
distinguish between log levels. But given all the other things to do and
given daemons I had been working with have their own logging system,
this always had a very low prio for me.

> 
>>> +		else if (!fuse_daemonize_is_used())
>>> +			; /* empty */
>>
>> Unless I misread it, it would still go into the return 0?
> 
> Correct.
> 
>>> +		else if (se->debug)
>>>  			fuse_log(FUSE_LOG_DEBUG,
>>>  					"fuse: sync init not enabled\n");
>>
>> And now every time a log message here.
> 
> Only if you enable debug mode.

Ah right.

> 
>>>  		return 0;
>>
>> Why can't we change it to
>>
>> if (!fuse_daemonize_is_used() && !want_sync_init)
>>        return 0;
> 
> That works for me.

Let's do that with another variable and also env to disable sync init
and new mount api.

> 
>> If someone uses then new mount API, that someone has also tested sync
>> init.
> 
> I'm confused by this statement.

I'm deeply sorry, I wanted to write "If someone uses the new daemonize
API, that someone ...". Oh well, that wold only be true for kernels that
have sync init.


> 
> In this early bailout case (fuse server did not call
> fuse_daemonize_early_start or fuse_session_want_sync_init) we return 0
> without actually setting SYNC_INIT, correct?
> 
> Next, fuse_session_mount_new_api calls fuse_kern_fsmount_mo and libfuse
> proceeds to mount with the new mount API.  The kernel uses the old async
> init code, because nobody told it to do a synchronous init.
> 
> That sequence works fine, and I can prove it by strace'ing fuse2fs
> startup.  The new mount API is used, but FUSE_INIT isn't seen by fuse2fs
> until after the fuse_daemonize() call and the event loop gets set up.
> 
> In other words, fuse2fs uses the new mount API and does not use sync
> init.  I think the correct statement is the inverse:
> 
>     If someone uses sync_init, that someone has also tested the new
>     mount API.
> 
> My understanding of where we are right now is:
> 
> 1. If a fuse server starts up the new daemonize code or sets
>    want_sync_init, it will get SYNC_INIT.
> 
>    (I'm not sure what it means if they set want_sync_init and try to
>    use the old daemonize code)
> 
> 2. If it does neither of those things, it will not get SYNC_INIT.
> 
> In both cases we try the new fsmount().  If the fsmount API fails, then
> we fall back to the classic mount().
> 
> Is that correct?
> 
>> At best we could change want_sync_init to an integer so that a
>> daemon could disable sync init.
>> For testing I'm probably also going to add an env variable that allows
>> to disable sync init.
> 
> <shrug> That sounds ok to me.
> 
>> Btw, during the meetings I had asked AI to write tests for sync init,
>> looks like "ro" doesn't work yet. AI had created patch to fix that, but
>> I don't apply either the test nor the fix yet, need to carefully read
>> through it, but need to do something else before going to bed.
> 
> Oh, yeah, mount_flags[] needs to have:
> 
> {"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},
> {"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},
> 
> Sorry I missed that in the review.  I also missed that mount_service.c
> should be ported to use mount_flags[].

Thanks, I need to read through the docs again. I think we update
mount_service.c after merging your series.


Thanks,\Bernd

