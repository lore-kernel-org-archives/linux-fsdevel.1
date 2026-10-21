Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618665;
	b=nqXOa0ygruWwF5pQETh/uRzaPavKCvZghRggdK/Y5X7n+PMTjvswTgwbbwAssV+k9ebS
	 r6Bx3Z57TNd2MwF+ArZEkSVbMTqpwCFlYK8Ps6aBrHLTYB9Ns8w1u6d/2Bc0N4YeMgxRK
	 Tp1YSgh6wBuz65LsLuE5HZoCDREZpwUfUHqUfvXYcr8cL7jRwKouHS14sZmnEij3zzgbc
	 rOLv1DnZCDukau0ZZYabZ/vglY3Y774xbhsNqskVNnh3TjDP/ZVWQhYBi300nRy90hK6L
	 6WkvTvFUwuhwf3JJH1r5ILVgY5nYEp9BDmxM0RpETYMh/W9guQuGNvVSQxAAQrxxuVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618665;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=T7utHoRRx7osD0ejadCFJpTV+meDX8D+w4m/Mx6cOec=;
	b=HpNFNi4hWtBvlkTrcJ1bjvnz/oKbJEYFZK+5ATWq1MzfYThCOfqaOUm7ry7BoNExgDMU
	 PeuCxERDvCecd7DJTWdfdikBx5q54Rr/lQ9l5IK3XR9NwCA4TVM9a6p2byLi686tjei8t
	 KT/+6JQpGBCsUNhasH1qDWSrK3aY/dRTXujc0o6/H7iAqZlfXuUV1UijAi3hzD5zB8Bcc
	 cSL36N7YqDFqkdJV5IdxBxz3pkf1txEJR4It/+44zS35bXFFHR/vGbBhnBofhSO5jHGaR
	 Vcjn6MZFytONHnf7BVcNOiGR+5l0HaaC5L7++tjUQt9uOvpW5q2tJmN1ibx2NwuKtmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=AM8d78MH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tQ7SMf1J;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF8606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 21:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37DF8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=AM8d78MH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tQ7SMf1J
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 011271400135
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 17:37:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 17:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1792618662; x=1792705062; bh=T7utHoRRx7osD0ejadCFJpTV+meDX8D+w4m
	/Mx6cOec=; b=AM8d78MHNaslCpEk+DqpQvsDvsVip7UdAMYU0C2Mm2GAadKm/C/
	puN1hFqNZ8ToTtv0Xu83GzdKD7kPyRFlOY4VhF0ItjbEp9jrpPoIJBY1PAI8kP/f
	QxEwLrFBszbGh4fTzuantiS+ZMFwdj5q89EePRdAcBfsYxUrPKnoPuFI7UgpfSho
	81Qf4+62/qZCXfAWR0ob1obIYbA8PHVGqlOmivvxK2QVZsbzi5Jf2WTSk6PFwau6
	VvrFmTcO/jqvN3UTGuufUm6YS8dl0uX0ttX6EX/EltHLnQqBMY6rVcj/jeuUlWzF
	K8Ih6fqVMy8tPZMctzKrlxPhrkME7hf9vlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792618662; x=
	1792705062; bh=T7utHoRRx7osD0ejadCFJpTV+meDX8D+w4m/Mx6cOec=; b=t
	Q7SMf1JzjfGFSgVWeKnvXhQd+wnP7oXWuRxmSenfloWbCcI6rK8t5wNjAO89WARr
	EVhFsl6Jf7CZtI3IIURQ5zKWV7nM07alOQwAggK7G+IlOkdTgbKzRsCqrKWDmL1u
	MN7u9ZrJ1j/J2Ne26gOovgk+BbTsMQgun5CJKnZzdxICx5NYeRLVRcXPzF/m6183
	nRntfifE4ot6a+2IQpaobaEtUBU9Q0IVAdpMGhK8dV0asedkD/afbnlToIXBejJZ
	q3MELtaDFRyTrwyB/Zo/NLmdBxblx2xcLG7eOBaWHQSfzqKHpTUDCnJmJgeJNX2v
	Xt2YSEAdlvoP6X/+710Ew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792618662; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:E49YfoaXELI5ZpIsuNO55Hls7GxENO12cjXHDmoKViKbWCO
	gjkRckGAvYEfgK/proT34vEKuWvLXyQscfwv4T9U23mMtjzsowdm1xsd9a7685xe
	QlJX70azfNZRCMOyg1WD9JXcsH04uwTcYAUgAqeKHDHsWkQqR0XKYvXnvnj1XvxG
	GQdf2oZemVCDc8w9X5JHVrMQyyQNsTMlzpnV/wVLnuqM06cJET9YYkmKgQJhBwLS
	iA80ovqPJvjxqXRSz4SvQl23aEeEDOh+dVpjK2BeOQOdo3NgAEBQHVgBCkzTSFEe
	Rw33pNPb2+FHox/yCazwT59pIxOnU2gTm8Do0CQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:Trn9IBMUM5WuXwYhWXjC58ddXbM9C2aXqfGg16gtTls=:LO4IsuRm60nEzgoGgs6tx2FaoYO8ptDiw2F5Kse1ayQ=;
X-ME-Sender: <xms:pjDZah9uPvFdDLny_AzeVP-4MncGAkYyQu3sdm_uvdPKQ7pbg-MNQg>
    <xme:pjDZaimSNrweXPc5sAFsJwYzvggWz5XPJvwb3PWCUgu7nzRKT-JT8dRHUqf_GlOAf
    q2fFFmOXbMRgJeLs2AMNucz_kcNsssyPKvWnc_Q1Gnl7YJwAR8>
X-ME-Received: <xmr:pjDZauzG5YPkCXLDT2DEDq1G2KPNkNQXpZpq-QgYgFf84mJJOqLyINoXX6kndeO4HkRfbwwjWqWAAEApEqqqKoNNWe9Be2I>
X-ME-Proxy-Cause: dmFkZTEPjmM+D7HB8Btlr1QETQPpTPB8vwCSqV5rGGHnWzPDDskexO8G67npieGeQ/ue0O
    GN4jlrsOPf841r8/wk28juJA8qidYKRr0HH9MuRb7aTvGZMVcg3hPQ6wkgya8b0WOG6yrH
    55UhZvmMjOTt/8XvE/kLEUWbw4WkpHde0L6OOE2vQ4lU5xbIxvkESkarj3DAcQXLX/JdLm
    tNfS8xssALkXHZ/sM+Tp5nXzNMRSMqCmCBfc55GoUz4CfmkzdsO6+5TQnPjIxnluqmwVgS
    4v9niiWilmvHGlvM3RqJg0zfBpfxjM6t5DvBvmapGYSj+aV6Z8cOWefcl/KmN4i2G1soZF
    Z30D+wwYDdtLGN3AbUybKZUgPn0ezPv/qsM4U5ZOjNV7zs67R5S6mi1MdJM9T9ztR0MSJk
    tx2RVqTGpkpqzs05vquDjYCf23YXUE8XUkmmXc+AGCP+CDcqT1koCGdY/kou2QmaMiy7lh
    4hJZnvPhcyel90zwtJ+vybO1EwrP3bST/0K8vpY9kM8RYREiftVA6PUTqCxe8KXXomht95
    M3g3KlImvq8D6i5Vkijpkk0glaetF5O7rZaB7/roH8uSDOB2CsP1QaVWZ2KwoFf5War7Fa
    NmS98gswJaUT3OemlU/2ybom/sMaqundwy2Fbxn2768zF94+xa/iNKFeu15g
X-ME-Proxy: <xmx:pjDZak7qnSQgRrvY_knWt5opLXyBLzqYL5cpMzeaVcs7bRCnAFvoHg>
    <xmx:pjDZamWNSC1SBTTOK2Y09W7ZzURkMvKcelJA9VKFZhXu3wlGqRy-vg>
    <xmx:pjDZakLuDy9MpHSHs0EUmCY1tlzbi7LtYqzk35ojOQ-NQV8Xwdk_Mg>
    <xmx:pjDZagule7J6TxtJCsJpEJdUtYmGxJhYq2g2hFrnn7PXycDXzYmGSw>
    <xmx:pjDZajt7Iekxn091581VjkF5CwD1E8w1inbCBdSMAXoJXNQzMZpqgwcX>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 17:37:40 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/9] nfs preparing for locking changes.
In-reply-to: <20261021-hochzeit-stuben-widrige-609e75b40a2d@brauner>
References: <20260926001011.401824-1-neilb@ownmail.net>
  <20261021-hinbekommen-angedacht-bahnanlagen-d832186d3a71@brauner>
  <179257850450.1724252.1685434539612383422@noble.neil.brown.name>
  <20261021-hochzeit-stuben-widrige-609e75b40a2d@brauner>
Date: Thu, 22 Oct 2026 08:37:36 +1100
Message-id: <179261865609.1724252.1255337466794802008@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 21 Oct 2026, Christian Brauner wrote:
> On Wed, Oct 21, 2026 at 09:28:24PM +1100, NeilBrown wrote:
> > On Wed, 21 Oct 2026, Christian Brauner wrote:
> > > On Sat, Sep 26, 2026 at 10:01:17AM +1000, NeilBrown wrote:
> > > > I am working on changes to directory locking.  The medium term goal is
> > > > to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
> > > > can be run unlocked, and consequently cannot be called when ->i_rwsem=
 is
> > > > held.
> > > >=20
> > > > The requires:
> > > >  1/ the d_alloc_parallel() not be called while i_rwsem is held.  NFS =
does
> > > >     this in a few places. New interfaces d_alloc_trylock() and d_dupl=
icate()
> > > >     are now available and can be used instead.
> > > >=20
> > > >  2/ a dentry must not be d_drop()ed while an operation is ongoing, as=
 an
> > > >     unlocked d_alloc_parallel() would then be able to create a new
> > > >     dentry with the same name.  In particular d_rehash() must be phas=
ed
> > > >     out as it won't be safe.  Various techiniques are used to avoid t=
he
> > > >     need for d_drop(), particularly that d_splice_alias() is now able=
 to
> > > >     splice a hashed alias.
> > > >=20
> > > > Further, the first two patches here fixes bugs that I found while
> > > > developing and reviewing these changes.
> > > >=20
> > > > The patches depend on patches recently added to the vfs tree.  I would
> > > > prefer these land in that tree too with an Acked-by or similar from N=
FS
> > > > maintainers.
> > >=20
> > > I'm happy to take them. I just need an Ack from the nfs people.
> > >=20
> >=20
> > You have an Ack from Anna for v2.
> >=20
> > https://lore.kernel.org/all/68919e69-d97b-47a4-8695-8021f24f119c@app.fast=
mail.com/
>=20
> Thanks! Catching up with mail after conferences and vacation.
> Note that Sashiko reports a couple of high severity bugs on this
> patchset.
>=20

I did look at those and think they are all false positives.  Let me
check...

Patch 1
  > Removing the acquire barrier when waiting for NFS_FSDATA_BLOCKED to
  > clear.
  This is safe because ->d_lock protects the important parts.
  The reading of stale directory attributes is simply not relevant to
  the waiting.

  The second part of the review is trying to find a problem that doesn't
  exist.  Maybe it thinks d_seq protects something that it doesn't.

Patch 3

  > Does this return 1 force the VFS to bypass caching and repeat lookup
  > allocations for waiting threads, leading to serialized network
  > requests?

  Yes, that is exactly what it does.  That is what it is intended to do.
  This change allows us to remove the other serialization :-)

Patch 5

   > Does removing d_drop() here expose the negative dentry to concurrent loc=
kless
   > lookups?

 Not really.  It is already exposed.  A concurrent lockless lookup will
 find a negative dentry just before this point.  It will find a positive
 one just after.  This makes sense because the object has just been created.

   > In nfs_add_or_obtain(), the negative dentry's verifier is updated shortly
   > after this point.=20

 Setting the dentry's verifier just stops a concurrent lookup from
 deciding it needs to do an over-the-wire lookup, and that is what we
 want as the kernel has all it needs to know.

 So there is no unexpected race here.

 > Is a d_drop() call missing when nfs_fhget() or d_splice_alias() fails?

 I think this one is valid. - BUG 1
 I wonder if d_splice_alias() should d_drop() on error if the dentry was
 hashed.  But it is probably best to fix this in nfs.

 > Does removing d_drop() here expose a valid-looking negative dentry to
 > concurrent lookups during atomic open?
 > Similar to nfs_add_or_obtain(), ...

 No, for the same reason as with nfs_add_or_obtain().


Patch 6

 > Does this relocation of d_drop() introduce a cache poisoning regression
 > when err is -EISDIR, -ENOTDIR, or -ELOOP?

  No it doesn't.

 > If a user calls open(O_CREAT) on an existing directory or symlink,
 > nfs_atomic_open() receives a cached negative dentry

  nfs_atomic_open() does not receive a cached negative dentry.
  With O_CREAT, the negative dentry will be invalidated - see earlier
  patch.
  Without O_CREAT, nfs_atomic_open() won't be called if negative is
  still cached.


Patch 8

 > Does this code leak the newly allocated sdentry?

 Yes it does.- BUG 2

Patch 9

 > In nfs_rename(), since d_duplicate() returns ERR_PTR(-ENOMEM) on failure
 > (e.g., under memory pressure) rather than NULL, does this allow an error
 > pointer to leak into subsequent operations instead of safely taking the
 > goto out path?

 Yes it does. BUG 3


So that is three bugs.  I'll re-spin.
Thanks,
NeilBrown
