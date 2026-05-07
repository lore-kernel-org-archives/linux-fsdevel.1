Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68276340281
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193585; cv=none; b=hORAxuE0GNIuwA2JMJWthNXmnmDQAPxWnNM2AKl1SphrSa2B3vwaKy+Xb8fYUAcdeZlWj6PMEx3eZxi3Yn5lH5w8iHvpaVZ0svhZnDbH2efwpiHBYTBt9ucbWFmweLRnfV9M1Jp4Dspg+xH192T3LLq1XkSIWqwig/Y6kj/JAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193585; c=relaxed/simple;
	bh=tRsmEE0G9wvhy/A8e11WpLQekVKvhLRGW8ZYXSxto7E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oLpUoxkvra2Lb9NeN1pin4skYwLcBaus+rDR9U0NWUve+IzNXuBypvGr+CyYrvSwwFrwgSVqAAx8ETkLrnA9/XUNEJHUc1fFeQrjq8IIfPD2FNn3qzAeXfLRPO7537sPnQAwWjzNJmNYJHYXEiNXZrrE/GIZTPRKUyxjbTliHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=N8pRgnxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDb5WNjl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="N8pRgnxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDb5WNjl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B15C7A005A;
	Thu,  7 May 2026 18:39:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 07 May 2026 18:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1778193582; x=1778279982; bh=zlbR8dkHqEMTxIm7Uy2X7OpPAgDZOaQOTi/
	kl7xwd2M=; b=N8pRgnxLNkvcE+3J4eom7AB57z9ozr7xNu33DJYuzC0T/yheJQX
	CLjYGAth9eFZW6hR5JJFmk4Rw9JBCFsynwsIdh67W/mBfPH54rJIi6/yK8E8kio0
	g7RbN2dyIAnQrohPL/Pz1Fw0l915ZER0Swk2cO3fuj3ftQuZXWkoD08EpmvWv0UB
	G+2IOBtdbiO23/Z78ZxU00BAF1Z7k5eeahfNljEIjSfqdpRxWG8kjnga9bhcbio8
	TTfV4XddCCBKcjD8Ju4xXNDGNu90/9hd7urxSB6GaP1bBQMHG0LMcIlAPnItjOKw
	dku/DiN4LTx02sDbmavH91qIAGUpcCI7LMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778193582; x=
	1778279982; bh=zlbR8dkHqEMTxIm7Uy2X7OpPAgDZOaQOTi/kl7xwd2M=; b=W
	Db5WNjlOu8mTPzPOmC+/WlAUFS94wZh7iHFLJU15ys6ekkq71WOdsdx0AYGOcz7w
	kvDwGSJrzwn47X+k9y+LpJLWOmFYx/2eknTc3aYfNi6evzkko05+7kglVNui9l/F
	IOh2QV8QMKtElZwrFUdPn6fPwgcSltEcyR7K94gjLQtuiP0mNfHVGfMmTWYpmVrp
	RICluE1Z71PZIFF7btYXS/g4lzMehByAQy1Nin7SBWkuHpW1dwwZZykCzNfIkEnw
	WOmo4AzvxoXWC0hGSBzBSwF80dItypM8nYzUKtefWnKA3PuZgDuJm1jNDtp6Z6OT
	6EFV5i27/GoD8hzLuInZw==
X-ME-Sender: <xms:rRT9aboYtjF1elwrXjx2vahxt4LAgXAcOyrBSghHamQRHMuR1tcitA>
    <xme:rRT9aboaOrVUNA2CJDCUbEvER3xcw5ngSnQ9_ysX8QyKLWQB98HWVUwgnDXaN5IJW
    HFJQs1tYyD-Wt5bhVcbS7V6hSpRftVm_6Bd8oAGqLmTRqHUqQs>
X-ME-Received: <xmr:rRT9aTDm-ODCKrqDgchFI1WvGiYb-pETlpc1gMOJLwI6Kr9aD6ia9Om4xqKJ0H82a7V9ikXflVAcohfPrfBZmNcLZKSnRAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudeuudetueevffehledtgeeftdetheejiedttdegudfhhfetgfekfeehhfduhedvnecu
    ffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnh
    hivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtiidprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghp
    thhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rRT9aRsze_83zOwFqrhnGUavH7GHVZ5WBMJqFYRfduPDudNNwhM7Wg>
    <xmx:rRT9aaLGvYeepkxiNSDDye_oVnbmTR7nAAtIaxyBrsB6H9e7d3yjiQ>
    <xmx:rRT9aQalE0g1iCs8bnT8UVkcZr2U1MI-Vq9a7T-u-V1RGsyXeRVysQ>
    <xmx:rRT9aUDrdqPGHrJ160lPBbJlTxK9qfj51e4JieOsi5AAg1vk13DpMg>
    <xmx:rhT9aWqOQib7eXmSkpWKGblwKHcgn9Ixyqkc7R9N4pounM7-yj2WJvbq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 18:39:38 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: paulmck@kernel.org
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Boqun Feng" <boqun@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Uladzislau Rezki" <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
In-reply-to: <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
  <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
  <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
  <20260505200501.GF3518998@ZenIV>  <afpj3FBrvHer0E6Y@pavilion.home>
  <20260505225028.GI3518998@ZenIV>
  <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
Date: Fri, 08 May 2026 08:39:35 +1000
Message-id: <177819357555.1474915.12171087837586376086@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 06 May 2026, paulmck@kernel.org wrote:
> On Tue, May 05, 2026 at 11:50:28PM +0100, Al Viro wrote:
> > On Tue, May 05, 2026 at 11:40:44PM +0200, Frederic Weisbecker wrote:
> >=20
> > > > FWIW, back in 2015 spin_lock() did *not* provide an RCU read-side cri=
tical
> > > > area, according to https://lwn.net/Articles/652156/; would be nice to=
 have
> > > > the history mentioned in D/RCU/whatisRCU.rst - at least to the level =
of
> > > > "once upon a time one *did* need an explicit rcu_read_lock() in addit=
ion
> > > > to spin_lock() - spin_lock() or preempt_disable() alone was not enoug=
h;
> > > > that has changed in <...>".
> > > >=20
> > > > I'm not familiar enough with that code for that kind of archaeology ;=
-/
> > > > Could somebody help with that?  Paul?
> > >=20
> > > That's quite outdated. Now preempt disabled, IRQs disabled, and spinloc=
ks
> > > are all implicit RCU read sides. On non RT spinlocks disable preemption=
 and
> > > on RT they call rcu_read_lock() internally.
> >=20
> > Out of curiosity, how much headache do bitlocks cause on RT?  I mean, they
> > are unconditionally disabling preemption, RT or no RT...
>=20
> Given the unconditional disabling of preemption, they would be about as
> bad for RT as are raw spinlocks.

But presumably if they ever became a measurable problem, someone could
create an RT-bitlock implementation I assume ?

NeilBrown
