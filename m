Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459791;
	b=fFIh+ktE3Sbm7EPr+HwRcnCyLhWT4zWkT6rcsfr/qLelcjjFLtUEh6WVAD2c9xXst80O
	 GmsDCLOJSJHFbhAyMc5LJcx7hgUUfxqPVkZczONC5jdlbJ0L+RqpDKbLKzpr32nxLHzhY
	 xEF1FK6zzAUv15gU71vZIoJ4c1KOoMpmcw057B4pbj30B+4gSCRaoPuc0GsfybLvpbmPv
	 i6nsn2IoiluC8OSu9WVErbDKXp+uYbovhY0+sfEi4o3lMikLCMa2qsLBf7f45o3r1YFXm
	 4znJuLYvgyf/VnLsTGJnSStIA46bkLwdnUoCBDqZp1UldAYV6fEgbv0FyGhwLNreIGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459791;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=4KxkXJ4nQz5KB2QlzezqufYuwFyMTZDhUK66xN2zGmU=;
	b=rimX4BdF4+4ngivxdu/T+9w0XOwfAZV31McTCNaWRQqCnu2AGfABcqx6py/GRg5qkbah
	 tUsE67OIJ84OVDkAzD5O5QVSsCNAwN83dXsNmtZIMaSkmesLiQdJgPC8V8/Mw/svvw+kp
	 tNHc/5FivHuFHEvhtxZRxfHlcoJiDtVzlUo8WmqQe8vyqbNsZ7m9fBqhUmqQx8AnNOld1
	 pVptbhLS/fdU5fPIXpJyFDgHfRrPdVfJco8ORJ4Vi/q0EnhMkHkFUBKavGq0vLV7dtpPY
	 m+FZ53PrMHmU6byNwE0q6jK6+GIhEqK/cjfVpOItiAAUJjX/t+RLwa84DZP7Vw36hqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=temperror header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=SVcKanoO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LRKN6rvs;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC0606A319
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 01:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EC0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=SVcKanoO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LRKN6rvs
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 956EC1D001F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 21:29:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 19 Oct 2026 21:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792459778;
	 x=1792546178; bh=4KxkXJ4nQz5KB2QlzezqufYuwFyMTZDhUK66xN2zGmU=; b=
	SVcKanoORputMS9MO8AZ+m9CLbuEiMGHUFhu8+iq4XrQnvlronqdcgOyYQgirLwt
	v+in1h9mrh5fqFtUjrWtripYx0aac65Ksu5psUX2IKyf3B/d7vc0QcXTvFHVJHcT
	0rIPT6+DfKAitRd6QNk/7WsSdvDKtF7o+SDYEaaqwaCi5Dfbmh334Krz9CKZria4
	gG4da+nk02euiIZa8epvSyBDlLq0tv8IcJqFpJB/kEWGNa+Fq5rERscXfkVJVsJX
	X1RQS616RedgX5XhcQI7e7Ljgh1WAOQbee1s2eNp+AkoP3QRPTiXMFbyuR0rSxim
	/LgokHKspJeMb9DPnix1sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792459778; x=
	1792546178; bh=4KxkXJ4nQz5KB2QlzezqufYuwFyMTZDhUK66xN2zGmU=; b=L
	RKN6rvsLGKJEPn1a+HKIUTjGlhoNcbwA62lUK9av8hrXG1OrxrS8TVICDfygnSQd
	ORlbI9T12cxNWDsefTeGTR7CWtbYzfPpLN/zYHquF96krWCXrZwgZMmdCISJrN6V
	Wr+Sd2KQS+eKDOpqGHi3BLeDx2o/3xINgW5BEpjrxCb649M3kGMpeSijzIou9NvO
	qte92R9ELwRViQbWxTihgoYQy+DAYefvnuWUGkqCgdtLCfDI4lvSCuxD9X5x43hb
	fN/Ajfi2Sa+s4qmoPQpZbHavTCgBKq7XO5UtkGyYh0Bqhv1mgpSZhG2aj1iOmT4Y
	3kIygFT01ZL7CWH03HjWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792459778; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:MkNtqSPG64RNE1ft+nit+0gxavUK3lHD9bb5ZczbZEYBASx
	PPjyaiyHjsylwO9hWnDUQRX+B0s9q2oRZ1CfMt6Pv5vqhEa1KBWN/ZKo19yfvitX
	tAoNSVHya1MrR53m1LCI4bTL2XXRvpAr7XLZO7YEilMzO0u4gnw9RLCmn0soxt5e
	pDjq9BlTPzapbDgHgFgRme6iccSZ2wynMMbvuDrF6B6KZVB80+F47127jeUgluE6
	mW8H+BpMyJdQzxlqFAtGY/HYQb+MgnLZWQVk6wdkZg5+iJ7EyexCH5LfynQsGhp6
	Eo8dsaeMntfwlE2IBUvDpCX8HdDA0RKuu4cn0CQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:EN79Ak7wVgDgTEBK9FL+qs89KwROzfndLX4I0+ZDfkM=:4KxkXJ4nQz5KB2QlzezqufYuwFyMTZDhUK66xN2zGmU=;
X-ME-Sender: <xms:AsTWasfqRNzjpJ9gg-BuufdKOj498BlH0X6g3r9grUPzdNfu2HdDHw>
    <xme:AsTWagyhbujE37DIweAPH5lxhqLuobr_SMLFa5nbRw--KwKvJowbkeZcjxho0VIBP
    5-7wc9FPicaf_guEh2MBjPiFw5ROU9fiB1EMgF9ImlMTwtMIw>
X-ME-Received: <xmr:AsTWahIv-cEu1JAuQp4CCCA3ULid1ETlPWBjhViiJpZ8RNkU9_MmdcOqC_RkgEfMz22jrlHzj4W8cn_I60b2I1U-qoTxLdH3AFrHV4xqRhiA01Pmop5fHbazr4c>
X-ME-Proxy-Cause: dmFkZTFI8fi4K3lVj+IvxJ7hiVFq2ywh9HFKS3KgmEYlO0KtXeRuLfVLPDQaPpNCmMQJrD
    jTOYDRQ0ay4fbW6Hmhhfrv9rHJFRKQG2ouOqai0SmVtSTJ7ZihZZIcueBPLfYhxyTyAZ7H
    WIr0nwr9SFuqPI/s6T/qRgUC0u7viODrwoTl8yxKgmUiyXDG6iz6EUtoccKCQCZQjVf5UK
    qULd6zOA5Yxch1zmcTRetUQ2dBn39VzrPe5NKPuzT9mmc5yHGpkQzl8vtRFgIhsD+aR7em
    9xoJ9fpRuaLYHBa4e8tnrc7ij5V1G/gxRVCwEHxdlaW9jQHZfx1ZQXIhTHqmYlGunLujOG
    ykvhB2kqnrfwDzbj//+M/ttIVx1KcuwEnG0vgxZhvRyd5VWVnOVdtI5uqSlcMzRlYCGAn5
    1/Uy5gyW4rbBATkWE0m/ZgcGrTpJZkn6OXgwqgN72yxRs3oRYPYbH32diAZAePFNnQNQ1I
    MuDRNVP/G1J14ijqS6WKW15DTCaNesy8teY/B8ZxH9HDsm1rQ2SXGv1OFyK060WZxErRq3
    Dz1MNiLWuP8lbrpW8xw4nbhf3j1D25iSDgYAQ9PCCPCAxp0+CbcBDbTwt+N/iiPPuvNbR7
    rUNESjLG+ifBz/3Iza+eUKvTdjnzkBIhcva39IkNsFEpY6YJCWLA/YHvWtOA
X-ME-Proxy: <xmx:AsTWaiHsh4W96KM4MtEEQSBrazKqucWCqF-OxgTrPCiBuFNqLZ9BYw>
    <xmx:AsTWat9f8cYv3xql7QW8tJNzaLxauiHYK3Va9qYltCCdS78wwxaoEQ>
    <xmx:AsTWaiLiHWa2rK6XDEttBDQcba2D7v5CnH_KBdQvLncbSX9-J2QLzg>
    <xmx:AsTWarvQQhATPAuMnKENsKPn7_dX7X6j2Vl4sO0PdpMUhVTUR8pwsA>
    <xmx:AsTWakxEawTDmazIV5bVgDu47kaeR4_P0Ga3H_eyp5IXDhIJrpUaUB0s>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 21:29:35 -0400 (EDT)
Message-ID: <d0bc6eaac2fc84cb43b569f49ee503057784b45c.camel@themaw.net>
Subject: Re: [PATCH v4 0/5] Fix easy bits of the negative dentry problem
From: Ian Kent <raven@themaw.net>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jake Edge	 <jake@lwn.net>
Date: Tue, 20 Oct 2026 09:29:31 +0800
In-Reply-To: <179237697885.1724252.11956785709205194840@noble.neil.brown.name>
References: <20261019000810.1837917-1-neilb@ownmail.net>
	  <f1c42d0bd125c6b1c39f1ebaee41340b5f6f03f6.camel@themaw.net>
	 <179237697885.1724252.11956785709205194840@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 13:29 +1100, NeilBrown wrote:
> On Mon, 19 Oct 2026, Ian Kent wrote:
>=20
> >=20
> > As is so often the case you've come up with an interesting and
> > useful
> > proposal, ;)
> >=20
> > Nothing stood to me out as problematic given the scope of the
> > series.
>=20
> Thanks :-)
>=20
>=20
> >=20
> > >=20
> > >=20
> > > =C2=A0[PATCH v4 1/5] VFS: don't count references through ->d_parent
> > > =C2=A0[PATCH v4 2/5] fsnotify: update children flags only when adding
> > > mask
> > > =C2=A0[PATCH v4 3/5] fsnotify: don't hold i_lock while walking
> > > d_children
> > > =C2=A0[PATCH v4 4/5] Add d_for_each_positive_child family of iterator=
s
> > > =C2=A0[PATCH v4 5/5] Use d_for_each_positive_child() in fsnotify.
> >=20
> > Did you have any thoughts on how to contain the number of negative
> > dentries, (perhaps) including directory entry counts, in an
> > intelligent
> > way (meaning "as you go" rather than "brute force" when needed)?
> >=20
> > A significant problem, particularly on systems that count their
> > memory
> > in TBs rather than GBs.
>=20
> I would need to understand *why* this is a significant problem, which
> as
> yet I don't.

I think there is something more needed to understand the problem.

The source of my concern was originally the traversal of the entire
list of child directory dentries in the notification code to set a
flag that depended on a parent dentry setting.

From the information I got (which is usually somewhat limited) it
was obvious the number of dentries was very large and there was a
large proportion of negative dentries. The obvious assumption is
that the implicated list traversal was causing the lock held too
long messages due to the number of entries. There was evidence in
the vmcore analysis the proportion negative dentries in the child
list was unusually large too, similar to the proportion of system
negative dentries.

I should be able to grab the vmcore again and get more details if
that would be useful to you.

While the unbounded accumulation of negative dentries has often
appeared to be a problem, and the case Miklos and I were looking
at implicated that, I also thought that traversing the entire list
of children to set a flag based on the parent dentry was not good
design. After mentioning that Jan replied (wrt. using the parent
dentry instead of setting a flag on the child) saying dget_parent()
was high overhead. I let that go even though I didn't understand
why dget_parent() was needed. Using dget_parent() would only ensure
the parent dentry didn't disappear from under you (it wouldn't
protect you from deletes or renames) but dentries are rcu managed
so an rcu_read_lock() should do the same.

So what am I saying, I'm saying that I think the list traversal
that was causing this particular problem can be eliminated. But
that doesn't do anything to come up with a mechanism to better
manage negative dentry accumulation which I think would be better
done as part of the dentry life cycle than as a shrink operation.
That's just my preference.

> Allocating things that don't get used much isn't intrinsically a
> problem.=C2=A0 We have a shrinker which will gradually removed them - or
> less
> gradually when memory is short.

But if there are Terabytes of memory it often doesn't become in
short supply.

This might be able to be better managed by updated or possibly
expanded settings based more on number of (negative) dentries
than memory size.

TBH I haven't looked at that aspect.

>=20
> But maybe shrinker activity itself is a problem?=C2=A0 Is that it?

Mostly only in so much as it not happening.

Problems with shrinker operation don't come up as much as they
used to so I don't see that as a problem myself.

>=20
> I think it could make sense to separate positive and negative
> dentries
> on the d_children list.=C2=A0 This is quite do-able, though there is a
> small
> cost when a dentry transitions from one to the other.

Not sure about that.

One thing a negative dentry needs to do is maintain it's
linkages in directories and such so it can be located on
lookup to effect caching benefit. So separate lists might
be cumbersome and possibly problematic.

>=20
> The only other thing I remember from the lwn article and the various
> other articles and emails it referenced, was something about poor LRU
> performance.=C2=A0 Lots of largely useless negative dentries push more
> useful
> positive dentries to the end of the LRU and we lose them too soon.
> I think that can be addressed by having separate LRUs for positive
> and
> negative dentries, and giving them different weights.=C2=A0 I think the
> cost of this would be tiny, but I'm not confident of the benefit.

Or maybe adding negative dentries to the end and positives to the
front might be simpler.

A ttl might be useful too, use it to discard stale entries as they
are encountered (although the discard policy would probably be
somewhat more involved taking into account positive vs. negatives
etc.).

This in line with my preference to mange these "on-the-go" so to
speak, not necessarily related to any functional parameter
improvement that might be possible.


Ian
