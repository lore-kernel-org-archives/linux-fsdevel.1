Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3B3CF02C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011350; cv=none; b=u4Bel/9iACc/jo/U80mzz5ENZ4F+5Z22fymndXjjGkwADzdhMPO/6xqUDMtLf/GN7Lj98xWpXK4FrD48P+/m545+q9MLY3+NAGCRGENWO6nd87IwjWHhQ/iVppUKf6yVwMKEOLP8ZPGkTyA6D29gX06xs2GKIiuSyfhpb/TpQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011350; c=relaxed/simple;
	bh=o/cAr7n0MC+NVVVX6dfW2cTfDGKeaxI/JreYgNvb15E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba8zoPBDjmQ20B/Ih1H7pq8YQElbHs/Rw+9X6mrNkZ+5foTx8ou4TrM7qYJuni3m6lPPOwKlrSxnNXz/gvPLKO570+MHL2sG4gEaupGLN3DeOuYFlC2DYvwuVqua9BEdv4uAyL8uxfjTrGkl+3sk/EPhby/FQVFEu7yCOke933o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ZMVSAzCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GM41qvNz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ZMVSAzCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GM41qvNz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F809EC00D4;
	Tue,  5 May 2026 16:02:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 05 May 2026 16:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778011347;
	 x=1778097747; bh=LoirpClyky8S8tuRpSnlDGXDkBfXFThbkKlmwY4Ps4E=; b=
	ZMVSAzCi5NQ98kVTeok5hA9yR4prbAN57Vj/Ux3lVGtAlx+r2YnX07am5khhpWox
	xRt2UO1k7zm2V7Oil84EYf/3LNAGGnZ2wJfYtV94t4/a8OhuM93OUDe3zznlTQGe
	ul+96Kd1dPOoTzD48BORyV4MIKsspT8/D+YPAdYg/r/9PFtBTms2T0xcRRxEbhBp
	qdMHAt2MZHNdrZyxRItkCfJzcee1WryTul54sa8/LXAe5gO6u06AfkVtuOOGC3uT
	YC8xAr+d20Ba2TpPAAmcaStQ1eDQO7xwKwjbEmF+/xQHHV+iCpdC7Q5Bpkr/HKyP
	vCZiHlXN4IzTJ8qDPMfY9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778011347; x=
	1778097747; bh=LoirpClyky8S8tuRpSnlDGXDkBfXFThbkKlmwY4Ps4E=; b=G
	M41qvNztcCa9BMRR6/H1+ModPhXk8PMnDoF/MHwrlrHjDy/gBsJz0ATABMDwNrvg
	w+TUKJsKNr8ni5CL7u61wmXtkOV6BIe7RDZD0X7YKtNAbRpJ7pNisjQhiaYyyln/
	SoqZWjSTrmlm92/HBMxbIvdAnaExhQHcOOOrHo3vaWranpMmA1GYfDbWacRDfcWm
	az1cWdHeFKSoozaGK9+PsVcl8gIVLZn4m13sGS3cmo7Ku4GEnYmvK2QrWa0PnubU
	OCcfpb4lqBWO4hbfWozveTseZf2UyOH6Z04xR4g2kq4KX6lvwSzSi2Hcd1OoM/Or
	Sst8izaBUC2qhndRedFeA==
X-ME-Sender: <xms:0kz6aRe-QvDOl8teLAq-MU4rU0CEOH6byXzm_2sYWbemAkXym3D8Uw>
    <xme:0kz6aYgJVVaVA8oj-Lkx2zblEvip8gYhzCBMtH2vW0Zjtdyf08-9XAyxO6XWKz05M
    rl60tG2zLioDdtNCRGeGo_4ymr0rawwHT5Rjs3ZHV30Lybsd-vs>
X-ME-Received: <xmr:0kz6aRwOm0hUOHnvx_odPi_rzLtH0DYze_yx8U92qTfh_nPO0uUIxEcmXmlMNeE6NkSKL9IJfSpTHI2uB_S1zToUBHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddviedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0kz6acNIshGEPmdaWYmfRx8y3KnCOxtV39rhqfcBOpEZH2bSq8Wjmg>
    <xmx:0kz6aaWjFPL0rSccgXNmkdE4pHVmu3gbCQC6OjXM7gQdYPjgcnBUjw>
    <xmx:0kz6aY3vuY5gpnFbVBGhFof8TxczspTHvVoYUC_sA1lsgQQAmpXryA>
    <xmx:0kz6aQqJo9mJ9hbsEJlYGpFg_vhbYn1TpyJLINqkM9DO-PF5d6zVMA>
    <xmx:00z6acGbCA6QjENs9Kw3Vj1PRJT94hnmQsJSAZ-UxX03dnGPoEyH9UNE>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 16:02:22 -0400 (EDT)
Message-ID: <0de919e0-7d90-4fad-bf93-656bfd28ad7d@bsbernd.com>
Date: Tue, 5 May 2026 22:02:18 +0200
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
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260505164428.GC7739@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 18:44, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> fuse2fs calls fuse_main, then starts threads from ->init.  It doesn't
> call fuse_daemonize_early_start because I haven't ported it to use any
> of the new APIs.  I don't have io_uring enabled for fuse on my dev box.
> 
> fuse_main calls fuse_session_mount calls fuse_session_mount_new_api
> calls session_start_sync_init.  At the start of the function,
> se->want_sync_init, se->uring.enable, and daemonize.active are all
> false.  The first branch is not taken, so we call FUSE_DEV_IOC_SYNC_INIT
> and enable sync_init even though the user didn't ask for that and didn't
> prepare for it either.
> 
> FUSE_DEV_IOC_SYNC_INIT succeeds, so we send the synchronous FUSE_INIT
> from mount, which calls fuse2fs' init() method.  That starts the
> background threads and returns.  Upon return to the kernel, the mount()
> now succeeds, and the next thing that fuse_main does is call
> fuse_daemonize().  Since we didn't call fuse_daemonize_early_start, the
> daemonize forks the process and the threads die with the parent.
> 
> If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
> maintain compatibility with older fuse servers that only support
> asynchronous FUSE_INIT.
> 
> Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v1.1: improve commit message, refine logging logic
> ---
>  lib/fuse_lowlevel.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 0e16845d2f14ff..83158d02bb8827 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -4475,9 +4475,21 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
>  {
>  	int err, res;
>  
> -	if (!se->want_sync_init &&
> -		(se->uring.enable && !fuse_daemonize_is_used())) {
> -		if (se->debug)
> +	if (!se->want_sync_init) {
> +		/*
> +		 * SYNC_INIT is required for io_uring to initialize without
> +		 * deadlocking the kernel if the fuse server crashes.
> +		 *
> +		 * !fuse_daemonize_is_used implies the fuse server doesn't know
> +		 * about any of the SYNC_INIT APIs, so we don't enable sync
> +		 * init or generate log messages.
> +		 */
> +		if (se->uring.enable)
> +			fuse_log(FUSE_LOG_DEBUG,
> +					"fuse: io_uring broken with async init\n");

So want_sync_init is not enabled and it still logs this? Note that
default libfuse does not have a way to set log levels.

> +		else if (!fuse_daemonize_is_used())
> +			; /* empty */

Unless I misread it, it would still go into the return 0?

> +		else if (se->debug)
>  			fuse_log(FUSE_LOG_DEBUG,
>  					"fuse: sync init not enabled\n");

And now every time a log message here.

>  		return 0;

Why can't we change it to

if (!fuse_daemonize_is_used() && !want_sync_init)
       return 0;


If someone uses then new mount API, that someone has also tested sync
init. At best we could change want_sync_init to an integer so that a
daemon could disable sync init.
For testing I'm probably also going to add an env variable that allows
to disable sync init.

Btw, during the meetings I had asked AI to write tests for sync init,
looks like "ro" doesn't work yet. AI had created patch to fix that, but
I don't apply either the test nor the fix yet, need to carefully read
through it, but need to do something else before going to bed.


Thanks,
Bernd

