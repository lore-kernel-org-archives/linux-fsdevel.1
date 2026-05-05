Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496C3CF02C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966241; cv=none; b=ct5v1JlZt3Zd2Ch93gajgeEggYPMHqytmxisj1QKspEDMuzBqkL5kuPB7zoOmlfqc7/HWarf2Pxgs89sCSwYIzjPtAp0VuYxYALil/RbAsCyoc/9GA0xGiH6Lb9rbbgt7zqnKT0kKka94kG1ehdHhiMCE/AdkkHRn6Qb3NUZAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966241; c=relaxed/simple;
	bh=S15u2ghd07Hs8aWspJcili6WDv4THXWieTnaU5W515I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJ3tAkdv6RrS0Iapb8g6kYIjkW/n0Ik+Ajw4cDUD/ywhlEVjVJbqSkok51PiYJNv9u7ULHmZYgglDAgi1r8/IG3KT7SYEK8AkvzxqB9eO7YdO4SDpDGF0NQWaUeKvhTnPbKPEOFXnBckA7qC5hgRxqs0BL+Cl+MVVi0fDuW0jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=E5ZGsPSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4CE06ba; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="E5ZGsPSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4CE06ba"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9111EEC0180;
	Tue,  5 May 2026 03:30:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 03:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777966238;
	 x=1778052638; bh=ztCrO0TiNhKNN32MJW69ULpbucNxiimv9N9A3WLevX4=; b=
	E5ZGsPSPvPU17mY+y36rf/zgWnIGeSm9lZLmnlwK1IFmgeNIfHB+sFI/0hOn99ey
	/ixqddJNXQRq9gk9qukyfB/gpWZfyEAXKiOcxv+4BVpSte/HqeCqHJKMOxa2UyW2
	aSOAlFU9jybhX18aaciNq+PNMmc6v2+/VM1DtKXHfKB97mYjB5YgNrZqqlpQKuaK
	Ok6iMqskh63qUvI7mewRjBa06tA4ec1Mng1W0lAbQlbClNl4Ts4+Dl9KW1nV9+Sr
	VxWyk+LXu+HEhxAF5Dv/F9hlI0wcnPTO3KQKVwxp0GyYEKz71s9H1oa7JSaOJIUL
	23gcdt+NM5ghwfNmDalrug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777966238; x=
	1778052638; bh=ztCrO0TiNhKNN32MJW69ULpbucNxiimv9N9A3WLevX4=; b=L
	4CE06baYLsmBOR+LMR9KAxzrGngaqEG6CvFFVP2x5ZguysnrbstBSbEv0AZBy9mD
	XhsPP1Hs1ACkMJFiF8Y3I3xOAGxOdzEaeXrz/cFZDopOh5P1sd4q4Jsnn6zmARtm
	1/64JTJixZUdYJrvtW6Y5Zg+QOgW0vmOdtXiqHaxCdTxKADzsoDQH7onB8KMr7CA
	RKn9tMhEOoCOzng9jsMtYp4gn9RruLznyJUEeHTHz613Ncdlhdu+sVAjpq/NKxSz
	DPDe3inmBWuCBvBZehpsVGRT1Fc7CTPEKdg4hsTLqtjKjx8o2uGnIeSHl0W5lE/l
	YFOgQ+nuofEis44spkP9g==
X-ME-Sender: <xms:nZz5aUowSmn97Zj5ZVOrUvP3Jqf7zwsjan197g5b-tq9cQxnjv2MLw>
    <xme:nZz5aT97HhBMeSHf_sb7WjP3GrksVdGNSNCWYbkuUgrDI2VscWjHQjfv20Jq31LWO
    gnp6FEA-uTDOt34b9EPJImKT221UDVYHB3GeI5kwFmh9PHKiPM>
X-ME-Received: <xmr:nZz5aQfjPuazrpCZvm5rG7oHxoHdneGevVBKG-14drgakEFaiSfe_HjCepdOufQ8fF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:npz5adISY3SiT7blRUoP0vK-_gt91Jh3tINnmXLXeVEC7_Z0FMiQpQ>
    <xmx:npz5aQgmuBQaTuYNSZZF86sdmOdxPorQKrqqnDxpTInfrevsxtZ7Uw>
    <xmx:npz5abRlwUIr-SFcN78KGU0lCVaJYN2GvMqXdz2GCxnNhrjeKX7Jxg>
    <xmx:npz5aaXh6_J-CLrrTC5-oGB45x5oQI5S-kZdv_c44VqY930YLqUlpg>
    <xmx:npz5aUhdCaiUzTWlvOKv3AHW9UxnU8O9L5dSWTDVQ__BeH0LSc_yb9Di>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 03:30:36 -0400 (EDT)
Message-ID: <b023fe55-c8a5-40ed-be37-a21e1682b509@bsbernd.com>
Date: Tue, 5 May 2026 09:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] libfuse: don't use SYNC_INIT unless asked for
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 07:23, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
> maintain compatibility with older fuse servers that only support
> asynchronous FUSE_INIT.
> 
> Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  lib/fuse_lowlevel.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 0e16845d2f14ff..0a801132590079 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -4475,9 +4475,9 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
>  {
>  	int err, res;
>  
> -	if (!se->want_sync_init &&
> -		(se->uring.enable && !fuse_daemonize_is_used())) {
> -		if (se->debug)
> +	if (!se->want_sync_init) {
> +		/* SYNC_INIT is required for io_uring(?) */
> +		if ((se->uring.enable && !fuse_daemonize_is_used()) || se->debug)
>  			fuse_log(FUSE_LOG_DEBUG,
>  					"fuse: sync init not enabled\n");
>  		return 0;
> 

Hmm, but mounting is kind of a libuse internal part? If this is really
needed the commit message should mention the exact reason - what is the
issue with old fuse servers and sync init?


Thanks,
Bernd
