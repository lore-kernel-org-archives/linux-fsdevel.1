Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058C365A1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018348; cv=none; b=Jdr0mGrXGyK6ctslnkwistq8kT0IKe4bEEgCkar6lu7KuQXvtyg0P+E3y7wFAfkW8vsqcKvhrVkf2dDzXFchGJhvowrr42xnC7M68DUCaawd2JntcFeDPyvW02Egb3TQqWYfaPQGhY0t/8OFDQknwoJqK2T4IvGU1qSRtDCIrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018348; c=relaxed/simple;
	bh=YQ2lw3ozT9znAFucq7kVfNkA+Fw12aXAHdf6xlRG0cY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lbkd6iGy04NFxfU6ZyIAQThTDXOQ76DMkwYr+gWjm4VqPI+cfOjqLHNUHfzNzZ1n9eDyQBLzR5yiQiwSD7NsPIYlVyXluCt1ApCNIIithbKYzQSM8F25z/fZAsXI2L07tLx5T/aq23R97qGQr5ecJM9qugpaMrhPGr1icEL2hPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hX/Ze9kk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CexciFW0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hX/Ze9kk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CexciFW0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 90F1D1D000CD;
	Tue,  5 May 2026 17:59:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 17:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1778018344; x=1778104744; bh=cm13/f4bdtWJ/OyxZsvGO/rzF7XLjUC664p
	fTH4lRYg=; b=hX/Ze9kkTnAczBXB7AparI3VLOXLsPjSblyyJySUcQks+q5u/V+
	IxfKz1Z4Vg0ukrfcL+VKVZcSuFTJOzGpGSqdi1Yw8xRa9AZ+PmUZJXXeGgBAcf1N
	m2LWYiOxpYfh24jvWkzokAckiYKZFlnApGxpWx4P6+u6dzodekj5lgObg7d59oLF
	EMPW2h6AwW0JVpCTU5ZttODBuIMy4sGijPjDw5ekwiB2At1n8G6STcqpzKcIP2rf
	HKYpG5y6WvculA4TnFwyDhZcPuk36v+KJsVL9sssPeqI0WiM6reDWr6ZrVxGSIIj
	jHTX30zvPCnL+/LYVYx0DleKsY5yJrD7zLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778018344; x=
	1778104744; bh=cm13/f4bdtWJ/OyxZsvGO/rzF7XLjUC664pfTH4lRYg=; b=C
	exciFW0L4kvlJQzUd1I1qmrj2ro54EGIgd/MgpZji1rHIKFjsgRS2OK2pDqaaQ9v
	npKrq77+MDa9kdv0Qs9REDSb8SS09F6ictwlqQJtAvBD6S83atUq+rM2EQ4b608u
	rx7OMMTsLF30AUdbY8w2wif0EuG/4oT9bYOO11MsI7jL9Pd5b4BX3I0topFGKRff
	IcwgwsfW7FfxCepzUsG0IyqufPC2VoN9EpmcjiRmp4sr/XuihleQDHeVKfIN8w2k
	oFGqRfqFzvoOtpfhOWDvfgr1d624QBL2i2iRe8QRrrRFU8KDGLw20HsRcbIu/5TK
	PW0RZepIxCsWPvrKTRiHA==
X-ME-Sender: <xms:J2j6aeA_cEWyZ-I-s62eEvaxTkE3zGYEVUsp4vVnaaDyOQiGLG9Ktw>
    <xme:J2j6aRfMqpDxjR8syOzFsDI1C4Ie0030p2nH_hObXmBH9S9gjFQUFvhPRGFxqJG1A
    IHdLQo8znZR7XudCZNm8dMmVrBe95FrGQlH0BrE6Mg1z4sj4g>
X-ME-Received: <xmr:J2j6adLXgnn8uJh874Rg66q4GTZrUg5TqFg5qp_MWTiRp6COTDDDGIqu2eRQUybGkOqfsXrh89u4IalqsILf2RwLCwB4M8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesii
    gvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhush
    gvrdgtiidprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J2j6ac3RpVNJXqkI7s9gSJGaUrXOL1yj0R2FiPRUcbqg5vVZqp7nYw>
    <xmx:KGj6afjc1w_xPH6oxAGJ9RxplotOnN34N6tCVt8a7-XEphqGxLaeDg>
    <xmx:KGj6aVVV_VfNuCK92GKMCFA9IUydYoLqcYoxAs16UtL_CmUthjVWiw>
    <xmx:KGj6aWWCWdi2ZxgwFNx6EJXP5Mj-v4Hk_XqSwDtJ-UTZoLIDB1QFEw>
    <xmx:KGj6aSQ7ip0DuIyBk26tpcKK6UHDA9H9yTykd97Lp8XppZPUVcUv6wA7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 17:59:02 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
In-reply-to: <20260505142221.GD3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
  <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
  <177797133377.1474915.1770170197135589795@noble.neil.brown.name>
  <20260505142221.GD3518998@ZenIV>
Date: Wed, 06 May 2026 07:58:59 +1000
Message-id: <177801833914.1474915.11041706009072243778@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 06 May 2026, Al Viro wrote:
> On Tue, May 05, 2026 at 06:55:33PM +1000, NeilBrown wrote:
> > On Tue, 05 May 2026, Al Viro wrote:
> > > rcu_read_lock() scopes in dentry eviction machinery are too wide;
> > > worse, quite a few of the function involved are not neutral wrt
> > > that, making them harder to reason about.
> > >=20
> > > rcu_read_lock() scope is not the only thing establishing an
> > > RCU read-side critical area - spin_lock scope does the same and
> > > they can be mixed - the sequence
> >=20
> > Does it?  I can't find any document or code which supports that clain.
> > Could you provide a pointer?
>=20
> Documentation/RCU/whatisRCU.rst in the section on rcu_read_unlock().
>=20
> See the subthread back in April:
> https://lore.kernel.org/all/CAHk-=3DwjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrw=
svWdig@mail.gmail.com/
>=20
> including this, for example:
>=20
> https://lore.kernel.org/all/4e59837d-567b-4678-8a15-e933def32fcb@paulmck-la=
ptop/
>=20
> Basically, "if ain't true, RCU implementation has a bug that needs fixing"
>=20

Thanks - that helped a lot.  As you note elsewhere, things have changed
over the years.

NeilBrown
