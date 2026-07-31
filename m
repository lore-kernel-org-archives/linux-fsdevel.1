Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADC632;
	Fri, 31 Jul 2026 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488894; cv=none; b=m7DCKmG7rfAEEuj6TJH9hld6yKICcG3kgm2hoTXl9N4cYSYF2UznRryX0Cljc0fF0dUpgLmZARqFoYj8MrX3MObodYmaG5Lhacti9BFHtcPAlZzRjyBZQZg2xEn404vhFm3bxSTkyOQ87/LJBljo8GjJTuOVmMwnwDLEJE/0ziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488894; c=relaxed/simple;
	bh=ahQ78P0ay9z2l12/Wj0d/7zH0nMw0ofDjd/6A9YLnCw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=S18OA9EkXgHy3w4hOxIcJemELbJA5JhWamKhbZeWJ00tg1ra5yvz7KIqesdXahAVhi28mEhmjDnfndPjCHPydRNi1h/Ut04jUeWaq2WW2gY0B6vpgm+BCOOVe94sKVWrTNe1cnmL1TE1DzSL4CuWc9jpKMoDKNQwArnI6jC/U0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZK0jRoVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bRoJPZ4A; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZK0jRoVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bRoJPZ4A"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 329367A014D;
	Fri, 31 Jul 2026 05:08:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 05:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1785488892; x=1785575292; bh=kwvzQrnQmqCei1HPEzrxGu8kkBFd88QlBFW
	KDu/FsaY=; b=ZK0jRoVWnnNaDS8ZExNdSMkESfHixdZkm0d/57yCibsu7kccgvG
	2ayM2LyREqxQuX3/boN+XDQxsPKAMXBA0E/rWqAoqLcZA74aUZGCeRyvne3Ukp3Q
	wuPX+3rQgkTRHQlUrE9VGYXNG6PPEBzVhYtQnVlsAvFKh4kxicfe4a6Zhoc3ufLO
	BlEy5c4qd2GLAVwMhQzbQhk88nNpVv3EU0/jcnekmguAIpfZpSPht6ZQucvEtnNF
	WBKnAWBMbkctpnrybPIn4ABg0yUIRr/mwjH7j25gCZV7lElWXP907lNhDN1tnfkF
	fjvt4ZSXyQKRcR6RDTKTe8kOF65GbdVyVMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785488892; x=
	1785575292; bh=kwvzQrnQmqCei1HPEzrxGu8kkBFd88QlBFWKDu/FsaY=; b=b
	RoJPZ4AS1lfQTefQucSlq+tgSHM+4Ykkz0RlZYHaz+aRxzHTx1KPmbiVjAI+dKNx
	P3RDS4YjLBbsodq3ipqNwiRpvM67MAvV0DK6qr8651W+Jp3zj8f1/X46RICQnUzz
	tv0O4Sx29qxGoneK7YMTlORxx24OpEj6NylC2am4/eTxEimsHAAmul9xdknpwmpd
	iAUtTz8tu1muey90pwGdOqThSunpKPbTgCUS+1xevl/wP7ga94e9z3Cgke6yk/bu
	qSxCvlQ05vhv++cYqkTpDZYTR2JvFiDmlAA1A3RAgHT72G8OzBAyUBE0asqNhahJ
	DYmhrNImeEKBZHcqjGO3w==
X-ME-Sender: <xms:-2VsandLFsHM1Wd-svbFlAFSsqBdcGBHN52kxGa2eeUx5lFPd8pUeQ>
    <xme:-2VsavcPzQBx-_t50gwWhtLKexbzGDt4QeZkj7jVc_Am5XbNHyGnYB_X9wsMPSdzp
    mHhV2sVTi9D1K941emw7K-OTc7357AF_knBGY_NF8TcNKpCOA>
X-ME-Received: <xmr:-2VsaiySn2jlKZIMXzm3y0HueqJD-BAj4W0It3VvEv-al9m34SRXKkl96TbnR6I9pdCMt_IfBwJC_Mz-gtwQP_Pnf63nIXE>
X-ME-Proxy-Cause: dmFkZTEcRh68Pe70Jdr4otTzl1ZN4DBVUOxpbz1l8qHF+qQ4k6WRy4qyMXfET1j1le4uXT
    NCwxvfJcfPasejX/oS3i48bsYblPQ9YygF3JymSsYnVd6sYKdS9Eh4HVyWb7bQPOwgwpTj
    pblpAX/cV85syFtyUdVP+bQkAfeziK0zYyN7cVvcQ1qLjM7AjvSCG2Sxlsi2mqz8GDF7Ul
    hC/i1leUaIxyzqM1xdpAQ8/LE4p251dlCIOruTkaYe0+hkPdkrY5f84AndFeCQHGwhZNRh
    YLtFnhes8ibwEKckM4oqir5Lr38y+QdE9uEduKvNjKPeJO9bBpfHEanv2G/Kl2s6o9Kzms
    UGwb+vKdYKq5Ozd2RTC/lf1UevtS+KlXGtA6UNNg02FP/w2AlO8NDGyteQIljex/aF0LCZ
    F3mwnDQfRJ7ItL/zVau6PZL+/fZzpFSMiCdb2BTpzNUkyo+F3PW/heI34Xcoc0t1s9edXl
    SqA3j5JxF3jMHHBYIaX8dGm8/qGoefW0TXqbx1DTSSPDWEr+zlj6WY6Kd9DnQ0OfX70kFe
    Su8BoehRadgzu4PivGaLnVfQnmkXMVQ6KYa84hUJuryjIudW9gStluaNxsnAz6H4SOKtkm
    LsqjitardGC90Z4c59CtGStbsPCvGntj825/PlLRcDu7tytOyp7lNIi5kVIg
X-ME-Proxy: <xmx:-2Vsau8yhGCnVZlceeXKJt1lUBlnoPL6_ljYSGCRcVUXitYWoOYDxQ>
    <xmx:-2Vsaig-FVywMvfzIkCQOOLH_IcvqH2NwXYTrX-3mA2ZWiaeFCns-A>
    <xmx:-2VsatHGEJpPzs5KOjXNpuMTOPQkT_abK9PHbMl9_8IOX4gVIYtaiw>
    <xmx:-2Vsap_ISqYXewg1alnMR86dIGpeCaquON5hebxOC8Z1yrHytjN1xg>
    <xmx:_GVsahEXQEAypfg58UPcOPg3HXYcUlkd0EFmxkH-qyJmD0w0w2aCgvPO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 05:08:09 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 linux-kernel@vger.kernel.org,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 0/3] fs/namei.c: comment and coding style fixups
In-reply-to: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
Date: Fri, 31 Jul 2026 19:08:05 +1000
Message-id: <178548888566.3252194.860209231588124729@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 31 Jul 2026, Christian Brauner wrote:
> Neil,
> 
> Three comment and coding style fixups for your lookup_open() rework and
> Jori's audit series as they sit in vfs-7.3.lookup. No functional changes.

Thanks for doing that - looks good.  Feel free to add

Acked-by: NeilBrown <neil@brown.name>

if you like.

NeilBrown


> 
> * Update the comments above lookup_open(). It takes the parent inode lock
>   itself now but the comment still tells the caller to take it. A caller
>   following it deadlocks and the series added a second caller. The claim
>   that it returns 0 and updates @path goes as well, that one has been
>   wrong since v5.7.
> 
> * Give the return description of atomic_open() the colon that kernel-doc
>   needs. Without it the description is dropped and W=1 warns about it.
>   The summary line has to stand on its own line too, so the "from a
>   negative dentry" part moves into the body.
> 
> * Fix a space indented continuation line, three declarations without a
>   following blank line and a trailing */ on the last line of a block
>   comment.
> 
> Christian
> 
> ---
> Christian Brauner (3):
>       fs/namei.c: update stale comments in lookup_open()
>       fs/namei.c: fix kerneldoc of atomic_open() and vfs_lookup_open()
>       fs/namei.c: fix coding style in atomic_open() and lookup_open()
> 
>  fs/namei.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> ---
> base-commit: b2f1e6301efa4a80becdb0715416c3cbc693fbb4
> change-id: 20260731-work-lookup-fixes-73bd87cc2d24
> 
> 

