Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1B3C0A0E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899524; cv=none; b=ojjXPV3S0TM4Gg/IINekyrq00Jt9O6gq/HwKnyaUDlCE8HahxFe6owVptOSpNA+CyE7cHRc5c8vf7bZKzEwk06M7T+7e2xzaWUdJf3HQQchMDsV2iyz3CxYXuGMk073kVUQPFEuQfJ3JgoWQB5tXOebW9+E6X+KcJ/nCPwrk+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899524; c=relaxed/simple;
	bh=Z+3SUyfLtJ9uaSSeqmcPvzz/npVSq4erIVFYNEqWL6o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oUXyf7us29ufgcXa7vYDjapSYRn6dcxEuwoaNqqy01U28CpdYcnIg+gAQA+P4puRQBx/KNPOidAtV5NEA3Se2qLi7sKNKLZ1IIC9g41cl6ta3DyEg37vvnNzXz1BnqKG+LfMEcbvqiRrQW8mrB8EgLuJ/qfvd2pfDIFF5y0JvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nJb3XapS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZk92ecb; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nJb3XapS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZk92ecb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 58F2BEC010E;
	Tue,  4 Aug 2026 23:12:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 23:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1785899521; x=1785985921; bh=YSfFQXn1IUAsClFrN+tSNyam+Ovhv4pylgz
	SwJab4Nw=; b=nJb3XapS5mqWIVazfAeC3jGSwWMLw6Ei6lAFgYaAk19f+0ugV0Y
	S1N4ZjoaEKwkkt6zVXavYiMv6sgm0yFWDourxac5XTASzSqweXP7fLsjvv6emgzp
	CXdXcQy4WPzgklBdjG7bF8Fij4SbxfD/R3U+kU0VBnz6q2I3LfHAMUkOm5Kmz4bs
	Qxv8GpffwLtHeQZ0kItueHEhFLNM8pEzFsYGIZW0vcX8KEguQOQCHUT+r5lMgX+V
	ZQE+v03kKo79v1rz4PN2L6y3/YNySlv7CxN6Pp8o/F66Mht4YWQfeH7qD58frGoB
	D3VKGVSj0fnVjsuI3wZ59DyU2cDwano08Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785899521; x=
	1785985921; bh=YSfFQXn1IUAsClFrN+tSNyam+Ovhv4pylgzSwJab4Nw=; b=B
	Zk92ecbY0l49+dh2kjeQaeo2bS/rdX/wdemXHBE6DB5wqvwPXZMMnM3JYeuWtSJ2
	TyFczYtPhr0CZiEMPr2pKr0iNduJqAWlGnvhxSzwtO8CgAup2TNHhUMQLJkc0M72
	Wzdm1v+YI3Gyfz9LKsXJdyTwNzHWc7FBrLobxgjp2iQgVegOC2+7WQ/uPA9X5XCy
	LW2JPgWqd0Zj9INlXyVs6ukk2hDhKFxrIdxLOWFIyi//T3cnXVMwfAczJRk9Stpb
	YPdm74cTeLyMEdLLZY1+AMRzZvcPoahSWNjgQyiOmzT5/CFumA0ay91pO+SFbfA0
	5tvZ4py8ygMGz1vW6EF1g==
X-ME-Sender: <xms:AapyapashzBGkVpkWzjZzXYJusJK9nPQC_wsDziZTP6ubjJfsVeygg>
    <xme:AapyalxTBkUxmyxJ_KNhjAvGJ322_oGoEsAqM5OI2GQJdvPHEqVRlsICP4fJ3Til7
    3xawnhFZTbFHKBGGvuyUJV9kBivuVYY4LFaLcFeu-A5vm6WOKI>
X-ME-Received: <xmr:AapyasIMk848rHAsK_EHqOf-bbt-Tynt3nzOgMmQMaZ9OxGpoIPfKpmteV71FueMyw>
X-ME-Proxy-Cause: dmFkZTE52qhVbP4ZpZMPcAFBiWd1tx1VQ0En2FUqxpbX8S22BDOpOvZAilVpOLd960X8jA
    +6GpdpVLTjlZVY28avD+NXWDhb9a8u54pfM4YpD10aXVeb3kz5o5anbbvFpUggkK1ShTjC
    LfCaN0aZh25L5kAlG16/opduHRG47+DA6pA4vZ7T0Hc3H9HZAx4ZWYPcHPA9XKIxVAGu0l
    0YyQtCegnEMTm1g9h4nkcturaqYm3m4SGhbsmHF21fOnzB61kuL4hrhqZe0giuE1m4tZjO
    3zta9zIYmUR6jEjZi9qFvxeV2xcHwgzY/h+eJmvTYbd75HDB5jtultdBxPnJ1RGw6ubJLB
    HlxQlmUi5349FWBPkJMO3U9fd33IdemfstnKfwJNu4sgIyVtioWpsy+RUQgJ5XOnAJ9Scb
    IycE0RmFqtkMT8PL4CuxUlWPgiUKsiZk3FjdBPEgRfazNg6EHLIP9lSzUaI3pqfYDC4FcW
    g1GBjdajflsJvFHPveQTRvcr9DUem4RcW3Yeujj3ZLpghlZZEtuW5GJHRmkhSvMPt+mJEK
    UaaB67W/VOJAJ20yKrM24bBuVpk1W4/CBIRAl2e9oDktcL/zPG1YTmJgaALgfYKzL6h+hC
    jpEWOb50i20LjVvtH1jRZf7V9VADRc5o/QY8r+KRVSpzgBoRFNmAWZx3Bmrg
X-ME-Proxy: <xmx:AapyanpN_bNiWbP3DNSS-MI7eEvRCPyFT1RIfBEYfSOXf73txJEoyA>
    <xmx:AapyajLDjvTLnY-J6CC3vF_CXenZLn64pM0Qgki7V7kZJYlJjaWlWw>
    <xmx:AapyakTFVecfUod4-taJzAKhrVWbnIK0tFEDCPPpBATrW1azFNayLA>
    <xmx:AapyaqtvbGWEzEYlqgOHo3RoISKvOeBmm22pRTjkv7-lriUYd3nZ0w>
    <xmx:AapyarRbHqjjSuXgNF973ypM-NfNAWLopVPDhFUssSYJfQRKWrauzX92>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 23:11:59 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] VFS: prepare for changes to directory locking
In-reply-to: <20260723015330.3093207-1-neilb@ownmail.net>
References: <20260723015330.3093207-1-neilb@ownmail.net>
Date: Wed, 05 Aug 2026 13:11:55 +1000
Message-id: <178589951580.3252194.4525601427061509874@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 23 Jul 2026, NeilBrown wrote:
> Thanks a lot to Christian for the review.  I have address all this
> issues found.

Hi,
 has anyone had a chance to review?  Is there any change this could land
 in the next -rc1 ??

Thanks,
NeilBrown


>=20
> Original intro, slightly modified:
>=20
> These patches are part of some prep work to allow changes to directory
> locking.
> The short term goal is to invert the locking order between d_alloc_parallel=
()=20
> and inode_lock() so that d_alloc_parallel() can (only) be called without
> holding inode_lock().  This particularly requires filesystems not to use=20
> d_drop() in the middle of an operation, which particularly requires the d_s=
plice_alias()
> change.
>=20
> As it will require d_alloc_parallel() to NOT be called under the inode
> lock, d_alloc_trylock() is added which CAN be used when failure is safe
> (dcache priming in readdir).
>=20
> Once these land upstream I can submit patches to various filesystems to
> make use of them.  Then when filesystems are ready I can continue the
> VFS changes.
>=20
> Thanks,
> NeilBrown
>=20
>=20
>  [PATCH v2 1/4] VFS: fix various typos in documentation for
>  [PATCH v2 2/4] VFS: enhance d_splice_alias() to handle hashed
>  [PATCH v2 3/4] VFS: introduce d_alloc_trylock()
>  [PATCH v2 4/4] VFS: add d_duplicate()
>=20
>=20

