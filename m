Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0724A07C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872147; cv=none; b=S4BlGz4nBoq2j+aQPi8MlI2TwO9Rie86ZA+CaW3l14/Ue5WRt1ORNnK6JjVZ/pNXz45xdCVaFzHebV2miPocmGIFlHoRk0ggUSSloZKWsAXVPaxFA5jXpyBfMkthLF3wN68sPA/cMgbJHyBiFiOvI4VuH/n1bcYXHsfg1ayWo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872147; c=relaxed/simple;
	bh=hu2S17IXHPvHFfW70HuDIsB8azjljNnI//MBV4audms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPflRq4N0TtvU7FuSgVsGFZeNqvw6KDORF72ZYZAA8Lzv+8Z1U2J1dJdTWiJLM9zzSZulGC+e9ZdP2FdnSreDXUvhHzvXd/AqZqHrUvcsRw4tjP3WfTIaNbeyB2p2D2/AGo7hjiS4EGvaPigcXAgB36bsMU+0TO0UZ41cELYt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=MoVarxpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=069Ck4vx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="MoVarxpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="069Ck4vx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C7053EC0139;
	Wed, 18 Mar 2026 18:15:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 18:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773872144;
	 x=1773958544; bh=CaZ1yMO/RWHhvM9Yh9KjJzoedTtyj4AWWTLS/xeBZM4=; b=
	MoVarxpljsLH6RWLJYaMZjhMuAVk1b9WMBnrWkFeOiX1c1rlQwnLsxT/OsaYFnJZ
	CmetnxIJf7u20f6tdlINZ1vOjGkCnG1simShhM66n+IaU84wrFS1JbdAYH097VEa
	hybZdn0KZ4ErLDfQmNdVwl+OawRKqMBBtPvzZ/Z+ZU5KdPeS3+XxOgoO3Pu+/vMj
	hCsGZAz5oHVZCtTNlNyN9QZe/+FhaRjpceMyEsu6c59r39+rOtx2a29IvU1x7LCo
	8hdOFWyFSSlKI6sNlj4aPLukgK9NgP5wKpB3o32u42X8GkIkBjLRhPqgLWGxKrC3
	dYgzO1iq/nTokZWuYC0RzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773872144; x=
	1773958544; bh=CaZ1yMO/RWHhvM9Yh9KjJzoedTtyj4AWWTLS/xeBZM4=; b=0
	69Ck4vx6nHIg4YYUuqwXYRqMuk51ArnC7rgwXgs01csy04uyEGVpN55d0NKEnIl3
	zdGXgCw45AdPgwps46egIDiP9iX0hJA/B08Eugj/8KheZOw4pCkRpOqban4+zOsZ
	DUG07bnREUutDdYN/UfeLmdGwEZz5HES1SBoKvdkm2KYmLKrnT43EJu4yTRByj4f
	Tn8LNuaC3i/G979f9Me6EFDGRviR0wlDW2SuaZJv8FegW6OF108zFmOxaoyEUeo+
	fFLKDhfHyP4nQmvZ+zdlqG4/eZWGYeRHpT/mgT27BpwnxtK1iMhO6h/MUi4B3ld9
	u1uEqvFtjyuNJnNcaA8iQ==
X-ME-Sender: <xms:ECS7aeGaQD-Qb5tI95QAmFc6Ku4mfx5RPEoSU0zzADZhsZZVTytnsw>
    <xme:ECS7aTBZhdY9e7nev9o-zSwN-MvXUjW3BUAJjXVhS4eERncWMSzG2g7dZby90ZjbQ
    nFgN0aiDkzdLxNPAeMhMe9uy0pJhKqxBy9qQ-1qxXa7SwTlVaXF>
X-ME-Received: <xmr:ECS7aR9060XuAezNueBYMuqkKj8Gf0kZET0jr8xJjQ2PpztDWun1Ebwd01z0cVMWy6c_R7EjorQszMw-qnqU5VRaT-jvZS3JQGHdw1hjptzbiSnLAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeetiefgkefgteegledvjeeiueehfffhjeekjefgheejjeejgeeuudehgfel
    geevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    segsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuhdprhgtphhtthhopehmshiivghrvgguihesrhgvughhrght
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehktghhvghnseguughnrdgtohhm
X-ME-Proxy: <xmx:ECS7afC6FSJecKPgkgtvipLqIgaoTS6mUtMsz_h7ix678Jr-F6iAEQ>
    <xmx:ECS7aWQH6uRKWKEIZ03YCD2fLS_XghcN2DyYnSUuXLmSMhh9OWqt3Q>
    <xmx:ECS7aWscqdHbtH4nzeFedIEIXWojtKiadKyvKqi2dMl13jaTbU_RGg>
    <xmx:ECS7aS2yNT93r8ARvcJIpBeGhnhfBeTMt8la--fz5MF1C978VRKqiQ>
    <xmx:ECS7afc7VOlcEC_TbmeLEmqcDqldgs9g3uAMCt0m79Ajt8ssvK9s2rYZ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 18:15:43 -0400 (EDT)
Message-ID: <3397736e-611c-48ed-896d-8bb31be5cdcd@bsbernd.com>
Date: Wed, 18 Mar 2026 23:15:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>,
 linux-fsdevel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-4-mszeredi@redhat.com>
 <20260313230934.GG1742010@frogsfrogsfrogs>
 <CAJfpeguqNU_Q62vDS6nL_w3wBtGU8osE4d9pRFKFMVq-ATRFMw@mail.gmail.com>
 <20260317233913.GS6069@frogsfrogsfrogs>
 <CAJnrk1Z4ntEKfDrvsUJLoTP2tfvUo9Sth1ogUqN+5dxP3p+y_g@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1Z4ntEKfDrvsUJLoTP2tfvUo9Sth1ogUqN+5dxP3p+y_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/18/26 00:49, Joanne Koong wrote:
> On Tue, Mar 17, 2026 at 4:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Mon, Mar 16, 2026 at 12:29:53PM +0100, Miklos Szeredi wrote:
>>> On Sat, 14 Mar 2026 at 00:09, Darrick J. Wong <djwong@kernel.org> wrote:
>>>>
>>>> Perhaps my broader question is, what /does/ happen if a fuse server
>>>> thread starts processing a request and crashes out before replying?  I
>>>> guess that means the request is never completed, but in the case of
>>>> !(synchronous FUSE_INIT) we'd just see the whole server terminate, which
>>>> would then release the fuse dev fd?
>>>
>>> Right.
>>
>> (I forget, what was the purpose of synchronous FUSE_INIT?)
> 
> "FUSE_INIT has always been asynchronous with mount.  That means that the
> server processed this request after the mount syscall returned.
> 
> This means that FUSE_INIT can't supply the root inode's ID, hence it
> currently has a hardcoded value.  There are other limitations such as not
> being able to perform getxattr during mount, which is needed by selinux."
> 
> from https://lore.kernel.org/linux-fsdevel/20250827110004.584582-1-mszeredi@redhat.com/

Hi Joanne,

the libfuse work for sync FUSE_INIT and selinux support is here

https://github.com/libfuse/libfuse/pull/1367

I think Kevin had already tested that selinux works, so far I have only
tested the basic mount. Currently doing more refactoring so that
fusermount link to the new lib/mount_fsmount.c.
Should be done by tomorrow (will send out new reduced queue io-uring
patches once I'm through and then eventually work on letting the
application own the rings instead of libfuse - tight plan till the end
of the month ;) ).


Thanks,
Bernd
