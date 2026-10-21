Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578518;
	b=mGjf67VfkpSqW3wHYWf6YFyxTyqIRLoVlYd6H1jc9Rz9X43N82Ll+dNtvacv2zK1Xfql
	 TSdo6CikvWr9huQkOb26hGu10A9H+SLHic463exeGHfG1fMYavvJIHzAGtep4Z3tIQ9Er
	 jYQMcbsM0crEeDOWmjGsthtthjRkrRiAmzkmnBIkY6fC+ot6T7loFhrfbVW9mhAzphUXd
	 QK/oexw92MIBlsw0q4pRcVgzMzi8wBpcoar6zlmuEdzVOMIkeTvCHZIDVOUoF7EbsQBWp
	 XykwfaU/INtQbWcplEffZ8RCQybDOaLEqukqqwTKKVWh+GEhp1m0I2Z1BOw80rcOj/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578518;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=TTOT2RHpdTNw/iL/eyTILsE04DtZ3hMxAYiwMsVpaqg=;
	b=p84kUZIzk7gzU886OjiG2Z9cBOGxYhyPuA5KwL7U5xvpUeE5YmnQlJyghBVlHB7HQjOn
	 8h7y/5beC8XDWQkuM/4LFSe4CT/lIV9TFnJhryuqV2YVDz/gUs/pdZHWzyjkHEbZg5dQ8
	 IzaVMq60qCqWyiDlkC6WYg22/Yh6pcwBoodMqAMFD2X2YW2PW909b8vw/GEwrVnhb7ZRY
	 Xl1CM1l78wiolOoYGTLNbK5Y2LmSPbp8lUskODgsGsXBVp5vmWfGun0Ag2LcO7fH8QmMZ
	 u3s5v+7NufD7QV8iDxe6L+YAej8AZiykxQHVacyusLiYhbncJpm6vN9HncB5/0A6wmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=keKxA3eM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lY8Ea6t1;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88987606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88987606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=keKxA3eM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lY8Ea6t1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B36E81D0007C
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 06:28:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 06:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1792578511; x=1792664911; bh=TTOT2RHpdTNw/iL/eyTILsE04DtZ3hMxAYi
	wMsVpaqg=; b=keKxA3eMvcD+mXNBpy4nSavhe/j4T9hKLqyhZ29lb/Q7PAveh7G
	RLnMr/5n+ZTBUk/9+5HU3qOn8TK54Fqh7sj+mFM2RlrFX3PR/vlf53zAL1fg7nv4
	q8kQiObjTjZ/lL+mhm7sJTk50fgwu1u6iqqXQ4YCnc6d71rNMGk7GY7GqNvjrUEe
	NpBkOeASSxcP6DQ74PDew0nfEdqfM0toCYXnfEvchgUN8GkBdH6c2WmGuQb17cps
	QhWvQp60aIFd1WdnpJEcs4o0tdHe2oe2GqkmUDLKk30JZ2SLTc5mgguDKeaeQvk+
	aJ5UrUdQZ8WyyK1PZ+CsiwfM0DOz2iSOnLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792578511; x=
	1792664911; bh=TTOT2RHpdTNw/iL/eyTILsE04DtZ3hMxAYiwMsVpaqg=; b=l
	Y8Ea6t181/RsG2QLGlV1LuJOFgTCECBBTIXRp0ZiNJ59udaZhyP4SzeyTTFKjBtE
	OSDjqcYvC9w6dNtsZ8j2gTYY5pbUFd9gEsFcs3hGvAXZQ7y1KNfWdZlzPx3a1dSF
	oVN+cE6HQSWBWgUXtm19NH2FRTVnyGYvHy6rmMDRkooV9Sr6icZC6kjG3K5k80w+
	kqEbr8FkXJPjyr+5PDlWe1nTlUoDgsThHBrOZu4ShxWBNm+aYoVOd5IFdJ/tFCxG
	c4E6DEgpqYdShqcjmwfvpMAYJt3tYyiC/BmzoiWr4rVWz49Rkt4HKug/uPObNGCQ
	A8CihKAKaIYnUFFDNTEOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792578511; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:kOGhIrBl1WWrKk9T5liS8qWnKATrNIQGN2dur+bYKy38IV+
	csH1C/TX4DXwrTu5mLQQg0kMV684QRc+Aunjk+VCEPkJmccWOCCflbYIBljTPh2s
	QAS3sPoeEY9UIh0An1RnWh4VvsPRGe1cMV+oYi3bPfXGCbfCxeJZbUomzvRqIUnc
	hnOoDOG/ceWvLw3F9MUCOvfNJmginjPPvCU6NWP4MzcONziXWEjHOtcvTGnOrHyO
	oehNH3GJ5WwPJhwRur0Vb5R7g+nBQtl4hCgTzMsC6ocsi8SxKCWao9D0oWLqTx3O
	yi7GpLtrmdDc8jXXsmnnr8xW6sRI34wa6vvIEUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:UBUAD6Qk2BxrzMWX35FlLANF0lEAxH+02kfEewzu/CU=:e0dXa1NlVGzzFYHfts24LsyDelKD5zggPEW+9apv6r0=;
X-ME-Sender: <xms:zpPYar6ojw6njOjahzNcz3NqO1uQIe3WGFMSDps99zmNsBSdW6edsQ>
    <xme:zpPYajdtocpyITF5WwVFBkmN_kLRug-QQQguyXyCps6WaHTR6fM1eObX4t924fkhM
    awX9Bn0d846WTgToftLX3PqNq-vm9emBF32JIORY8a7aTJOv44>
X-ME-Received: <xmr:zpPYamG_rDaN7F5D_ATk2HuwzX08-oYYWEvVjtXxaNOzc3pyy8NVskKCx0g3fgnxb0i04LsnyzvdBYrrxTDuZTXTh4je0P0>
X-ME-Proxy-Cause: dmFkZTFf2LA/vJzIlKR7wQaDQy4m/7RZVCQrYJ1mUXlvFwTZkRrW23YBcuVJwGe2F78y2S
    Oyq27n6nvC01YpiTo30OJjip71O8GACLUrJIMbZ+xsvapE4RJgh3jzg4G27EPsqHieDH73
    rF3IgUKweWhvK2M+TsPybMcIEnvGyir4Sm/jSbDvafWYAO7AV48Pl3aywwGYQU80IlLBWS
    N4cwZXJG1fZYJrydXu+7iHncfUEtdkdCvUsUFNiRaPxg5+TGB2cFElbYx2yeAfnd4BiDhT
    DkhvU1j6WAis1hfat9QbIEmUPq7WbPo/PhM2cLiikgKM2q/OSl0jmTXTGYjtZrFOZbdPBc
    hZUVuS1nwfOU+DbN5mTsw3oYMfpSBJcFpm6jnQenKyORZAsgpH7G9bVHc66A5hyz9J7iXK
    6me4l/PLQwc0bi2g+H6XAxZNZdSE5eaApYd12KagBbwnPezmszF90FXvq6oPhCnHjmKQXP
    Q/izCHtVrYDEkXJ5KwpfD5FZZrGZkmnjWK7olT4MTNHQ8n3AaA0oC0j8ZsOVhfCAih3mmP
    mxVYKnkjVGa2FUbk47oIgxw1bqBoNWSKCsrKVywNEJ6Nwx1ocKvv+4xBAWvZ35redTNBNz
    IJH+nHbKLgaLkh45XIeGxT+62tdaumpTxMOmh9RB7eEJoHXzq5zNf7zDNX8A
X-ME-Proxy: <xmx:zpPYasRXdxQsA-c07navvw2J9MYwBwddE26qkfm2YFyyRiabRlJUXw>
    <xmx:zpPYakam2lE-LAA_Ioyl1b3tcqYe_AAF-lAO8m1imW50p1FKrmVYfA>
    <xmx:zpPYav1lpVn7Iuo8q9SaP5y7DwY7Zfr9FaQv533ag4qbDAgzOtjrWg>
    <xmx:zpPYavq2UPnt0YUh21lZC5golbunisWKrL_nTKBxZA_JIyGcuhsUPA>
    <xmx:z5PYatwuZT2Pe4kdDxFpMOeboRGv8hcWLqMV71MeKI1yIIL8sZR8fyuP>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:28:28 -0400 (EDT)
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
In-reply-to: <20261021-hinbekommen-angedacht-bahnanlagen-d832186d3a71@brauner>
References: <20260926001011.401824-1-neilb@ownmail.net>
  <20261021-hinbekommen-angedacht-bahnanlagen-d832186d3a71@brauner>
Date: Wed, 21 Oct 2026 21:28:24 +1100
Message-id: <179257850450.1724252.1685434539612383422@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 21 Oct 2026, Christian Brauner wrote:
> On Sat, Sep 26, 2026 at 10:01:17AM +1000, NeilBrown wrote:
> > I am working on changes to directory locking.  The medium term goal is
> > to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
> > can be run unlocked, and consequently cannot be called when ->i_rwsem is
> > held.
> >=20
> > The requires:
> >  1/ the d_alloc_parallel() not be called while i_rwsem is held.  NFS does
> >     this in a few places. New interfaces d_alloc_trylock() and d_duplicat=
e()
> >     are now available and can be used instead.
> >=20
> >  2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
> >     unlocked d_alloc_parallel() would then be able to create a new
> >     dentry with the same name.  In particular d_rehash() must be phased
> >     out as it won't be safe.  Various techiniques are used to avoid the
> >     need for d_drop(), particularly that d_splice_alias() is now able to
> >     splice a hashed alias.
> >=20
> > Further, the first two patches here fixes bugs that I found while
> > developing and reviewing these changes.
> >=20
> > The patches depend on patches recently added to the vfs tree.  I would
> > prefer these land in that tree too with an Acked-by or similar from NFS
> > maintainers.
>=20
> I'm happy to take them. I just need an Ack from the nfs people.
>=20

You have an Ack from Anna for v2.

https://lore.kernel.org/all/68919e69-d97b-47a4-8695-8021f24f119c@app.fastmail=
.com/

Thanks,
NeilBrown
