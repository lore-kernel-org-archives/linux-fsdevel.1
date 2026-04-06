Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628726B75B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775441367; cv=none; b=FRAieb57WJeclNlnIWUOBFQJ18MBoxSO4j1qW2/hbXe4x/7kdE0743oySQosr/xliEZG4wFR+AFtJldqFnmO7pNF9kTpVRLNtq05fhCR+hykvF4FJtmUWEQbTjfPsJRhVtvyUkyI0+cDljHIMuY0qt0WqfSiIsrPOCqdUZMrcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775441367; c=relaxed/simple;
	bh=4wAq+0wlQEK4Cd37dilqiD78IWeqo76sFOJACyvafr0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b6pmG98AHKZPjMF8DJeb6ZTBmyRt1jL67zuMQM24d+ynIHYuZPswQedEJ9ZJtXndtzWldheBdj9vU0OOL2xy6CYVFHtsveUFOUQnM3uh+JzUMKc4J3oo7iOh/Y5sMHa8XT1sIQyX14lMszxHYXzcQA9Bpl6RKHmGUje1/n26lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hB3A5TDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGjxxvrx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hB3A5TDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGjxxvrx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 946DA140004E;
	Sun,  5 Apr 2026 22:09:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 05 Apr 2026 22:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1775441364; x=1775527764; bh=mKR8of6H9cNHsFQpLoqABPovrQX3aSdeI4C
	xsnR/vfw=; b=hB3A5TDjeB51PD4m22IKDgW5rmodmTUX9ZXj+IAH22Y2l1BZz9I
	iYgc7zVk8fLWCXN5Tb05iewfEcZcoD4V9/Pzie0jb/mvqOw4aa4Gjx9+S3Dl3Gmv
	EgfF8XKpKwx8Q5t2reQfKYGRNjAXkAj5cW1zLNrdxIaTqg3ZQphy85hSlhZ6XD6r
	/L8G2zuso8GXjwOjrgZMkvKl2RVYBG5BvFG3yGGB7Tv7c0FZVFNaMNRAsP+E+Kz/
	rgMBuDaAXCayoX7BDqgUF+UFfuJpWeL+9F8M5ZWgw3j68wQ1PLzW4B/3aqPkfjL1
	7HNdMQUE6+E1fRdWAlcyqwISzCAcorYr6rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775441364; x=
	1775527764; bh=mKR8of6H9cNHsFQpLoqABPovrQX3aSdeI4CxsnR/vfw=; b=l
	GjxxvrxagOvbGlmo8rqL9ShWWP6gEDO+BrcQFoRwTl3qH6bW7UbTinmezucc3IM1
	wgV46XttAomZjrgJ7mfd2howM7OIFnBrUut54dxzHIP8PyHz/CsYlhg107wN6EXH
	81szuA6mrSAKuTkMcv+ul3TcQD8DXB/xvsvkQfuICHFchFFklcgtNFM9FudUEU9u
	Hcz2/RN9poQ247PDoomfyJzBLWXEQt/oDdemCRWxWRHpwE5rlOdryJLsrVvjuJPB
	gBHpsP4etzEhjNASzovKdiFU765l//Ji8h7Px7Qqwp6ml4uvhY+FWzSuGrQHDbFE
	nLy180Z0uIGiV3qtmYO3w==
X-ME-Sender: <xms:1BXTaTF0edp_gmAHD9VOl0Hddi8M_hJXGLvnZIp9eMY81p1Y3xj4WQ>
    <xme:1BXTaUpq3lzIEDB3RgqVk0EskAefUAMYDhepEiNqgv4nBy8mcxrRqan2EShcPg9OC
    9ul4hpRtF_KlioXAbktT-Gtrw6hu8XKEYUTf0WQSd8rhOsU>
X-ME-Received: <xmr:1BXTaURw_mGB60AO2JA6Hvdf4XWMY9ZCL9kKMsH5TGGI6ylTSD_PxSwnpxgmd4mjLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduieeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1BXTaZPctHqQT7dxmwj-HvgQJ-HluAiwZxghgthJSMHICFcXDmwaCg>
    <xmx:1BXTafMEMMPdWMTBw-ykwvpE_YRPsZEdrAF59q7wh5kCxpXL9ZMPFQ>
    <xmx:1BXTaRvxsnIZ0kfIxuJ2eDYIdS3RRDZt41NWmYcym1-DBnfhaCIBWg>
    <xmx:1BXTaRVmFLSuOVp3_nCfRhrXaSOmndKan8_Bw61ZHNzJ5_yGwC4RCg>
    <xmx:1BXTaapIc2VNXv6nGyi1oeJehKbZ9kPU03QiC03p1mg5zGaKgAK7C39H>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 22:09:23 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: fs/dcache.c: bogus comment re LIST_POISON2 around __d_drop()
In-reply-to: <20260405190402.GV3836593@ZenIV>
References: <20260405190402.GV3836593@ZenIV>
Date: Mon, 06 Apr 2026 12:09:20 +1000
Message-id: <177544136061.1474915.4475662411738222301@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 06 Apr 2026, Al Viro wrote:
> [Caught while documenting ->d_hash uses]
> 
> The second line in
>  * ___d_drop doesn't mark dentry as "unhashed"
>  * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
> is incorrect; what ___d_drop() does is
> 	__hlist_bl_del()
> which never included poisoning - that's only done by hlist_bl_del()
> and we hadn't been using that since 2011, six years prior to
> ___d_drop() introduction.
> 
> 	I've missed that on review back then; the first line _is_
> true, so functionality is all right; it's just that LIST_POISON2
> reference there is confusing (and incorrect).
> 
> 	For now I'm dropping the following into a local branch;
> might or might not get combined with other changes in the area...
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 0c8faeee02e2..c9995545d8d7 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -604,7 +604,7 @@ EXPORT_SYMBOL(__d_drop);
>   * __d_drop requires dentry->d_lock
>   *
>   * ___d_drop doesn't mark dentry as "unhashed"
> - * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
> + * (dentry->d_hash.pprev will not be set to NULL).

It might be help to add *why* it doesn't.  Presumably this is an
optimisation for when the dentry will soon be added into a different
list.  There is no point setting pprev when it will soon be set to
something else while the lock is still held.
Do we know that the compiler won't work out this optimisation itself?

Maybe

    ___d_drop doesn't even mark the dentry as "unhashed"
    (dentry->d_hash.prev is unchanged).  This is optimal when
    the dentry will shortly be added to another list as in __d_move().

??

Thanks,
NeilBrown


>   */
>  void d_drop(struct dentry *dentry)
>  {
> 
> 

