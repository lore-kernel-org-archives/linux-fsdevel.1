Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E23939B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425188; cv=none; b=dTQ19djfeg0NznvHhN4Jj5hmDvhREjwqoOYgWtWFe/NrY2mGund+86wL67/gozN9GpyDeJ1feKL/+wCpTp1TVbWoCz0L9L0jRWlge7vMki/1xW3xDltpidvpl0T7dQn1EutK7GIXRH/bUerQwtUOFN/VYHLHQjJZsEnUzdkyCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425188; c=relaxed/simple;
	bh=DOz8bUGIyP/2sDAUIjvj130cItoZWJfbm4Is6QFuaw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as1H/7/NOOjwZtcJH2CJVkEL0Ii8vi5h6HkGq7LIUl+7jwNQWbqEtbO9BCptvTbLzfj1t4TqcYDZRhwdDaNo/1f6P5GbEwtyPfL31C+BjzKm9DsxlhBSLx/uM4cE2RhGC+dcpZ9k57zIvRsa6hulVDOMZNKcPBwXT8N5f3xuCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=DTQ8kK7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0YBNQEc9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="DTQ8kK7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0YBNQEc9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 302DCEC0209;
	Wed, 25 Mar 2026 03:53:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 03:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774425182;
	 x=1774511582; bh=zyciThlcvquAczhQof3/GdirOuxhwiRg82zrnnf6Snw=; b=
	DTQ8kK7osMz1+dt5oxICFUELgo62E8RSRceDCgBucxoXbvxY2Z4PgLqykZa5DMIS
	yashBcmf6vu1+WoK3QS6mJKfDRL1eEmEZIO1ZxDOfEJ6IJb6CVnKSV9csvKA1I+y
	zW5RBxBMO6eYu39l7Z+UldfPwYptGMdFM0eCq76jQZwFMIx74eatlBuaBJZMyf/9
	OL9hoyqHcI/FUglGt97EhkD9jlJ9bhp8HdXV6hdBIZt6EwLfgGsx/UM3bZauawqR
	fGrZ9UsTWfJJcrjfgO6lKthalzd1QwZiAdzJA7+wYRDTBOOQsQApjJo6Q3xMD/DQ
	Qn3Wy7sNersEvoSaMUUv1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774425182; x=
	1774511582; bh=zyciThlcvquAczhQof3/GdirOuxhwiRg82zrnnf6Snw=; b=0
	YBNQEc9IrIOeTPH/FQX+L+uRFtx3s5CLgMkJPeSpQi350UQWP4vL0g5SOQDP0S0e
	tX6LHANp7YXATIAGGfC29CGPcf1fMX89BcPOycPUH3+kCwQYPRVL87EVrriLhhob
	9wcU7klDIh7kv31tRFCLfgVQDwj+vvZliHmA3wQybWtzQBt9X5WzlsPF6St0kyPV
	50va7zMM+6Z3RZesA5yyQB+ErKMoGAVRw1K2K3zeN84ziPcq19mFK1+M1aHr7AqZ
	Zm4KbajYLqX8WzWVRLJmDeOHrkuaglCMUboar5l7FkqEidZzxlyggP3GPmbSx7is
	6N/IBVVv8duUd+rxJvmfA==
X-ME-Sender: <xms:XZTDaZKYgOplfP17p0gprbJlBjvcdgBUPmASZUyUopMdpsZMLubBhA>
    <xme:XZTDaY1j3Ztur652TYiDC2MPJv_UUOpmgXN1sdTw02jpk5cL7dxx8aY6ayqqfGwFc
    5CvRc5CwNPcFIrigm2Pg7jakenNpgVkrM_9s6CQGvwx0JSBndi3>
X-ME-Received: <xmr:XZTDabhrc5k4nuk7es2t93aoEEufaAnlpe6bT3GXYWqIYV0mVYgYtWO6toK5l7kBePGoE_we457g1D2k_kUREe-unnnU89xDV5j9q5aDQZKiF4in9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejffdutdeghfffgffgjeehteejueekieetieehveehteeuiefgieeuleek
    jeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgthhgvnhesuggunhdrtghomh
X-ME-Proxy: <xmx:XZTDaRWdecpkSqwa9SwRpwiM8S5oARR7x4mLt-5JYTyQatFbjQQ84g>
    <xmx:XZTDaSWPuuTc0UbNq1pRtzhuum2QLky5c-sZAdxrlO4tBpfGFRfKxA>
    <xmx:XZTDaZhPVpvE5ZZXwEtUmVJ5GfxRQViLOGlXzNm_kxrdFcZuEQvQTA>
    <xmx:XZTDaVbqau10nWGWCnZ-dYfFhBfCwCCj-m1iJcul65M4v4Yjref_LQ>
    <xmx:XpTDacN-kMCtYNz8j84BsSvzB4QHb-eKq2qvQIolhf2xZjXa3gVAhCVg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:53:00 -0400 (EDT)
Message-ID: <10748cf4-ac68-45d5-9d56-999f45fcf3b2@bsbernd.com>
Date: Wed, 25 Mar 2026 08:52:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
 Kevin Chen <kchen@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>
 <20260324000350.GM6202@frogsfrogsfrogs>
 <e0d7b5ee-ffef-45a4-8c39-84cd79342bae@ddn.com>
 <20260324225012.GY6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260324225012.GY6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/24/26 23:50, Darrick J. Wong wrote:
> On Tue, Mar 24, 2026 at 08:42:36PM +0000, Bernd Schubert wrote:
>> On 3/24/26 01:03, Darrick J. Wong wrote:
>>> On Mon, Mar 23, 2026 at 06:45:07PM +0100, Bernd Schubert wrote:
>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>>
>>>> Add synchronous FUSE_INIT processing during mount() to
>>>> enable early daemonization with proper error reporting
>>>> to the parent process.
>>>>
>>>> A new mount thread is needed that handles FUSE_INIT and
>>>> possible other requests at mount time (like getxattr for selinux).
>>>> The kernel sends FUSE_INIT during the mount() syscall. Without a thread
>>>> to process it, mount() blocks forever.
>>>>
>>>> Mount thread lifetime:
>>>> Created before mount() syscall in fuse_start_sync_init_worker()
>>>> Processes requests until se->mount_finished is set (after mount() returns)
>>>> Joined after successful mount in fuse_wait_sync_init_completion()
>>>> Cancelled if mount fails (direct → fusermount3 fallback)
>>>
>>> Hrmm, so the main thread (of the child process after daemonization)
>>> calls mount(), having started a child thread to read and process
>>> FUSE_INIT + any other mount-related fuse requests?
>>>
>>> Later I see an eventfd being used to signal this background thread that
>>> it should exit and (presumably) let the real request processing queues
>>> take over.  I'm curious why an eventfd here when pipes were used
>>> earlier?
>>
>> We cannot use eventfds for anything possibly used by BSD - which is
> 
> (Yeah, I was wondering about eventfd, but I don't know how quickly
> libfuse features get ported to BSD so for all I know it could be years
> until BSD gets SYNC_INIT.)
> 
>> fuse_daemonize_ and fusermount. So far sync-init is only in the new
>> mount API - linux only. We need to switch to a pipe if BSD ever gets that.
> 
> I wonder, are the socket communications between fusermount-libfuse
> considered external interface?  I'm assuming it's not, and you can
> change it as long as you don't break the other side?

I know that fusermount3 is also used by other userspace implementations
like https://github.com/cberner/fuser

I would need to go through that code to see how it interacts exactly
(had looked into a few months back, but don't remember the details
anymore - that were some readmes would be really helpful). My assumption
is that once we have a released interface in place we cannot easily
change it anymore.


Thanks,
Bernd
