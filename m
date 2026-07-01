Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295763C6606
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943430; cv=none; b=RHIt92cSt4HIshc74Q/v1Z7+DfaUKnh5styaGnphBor6TkrY2odNQFSQ7ueBnFVY+w+I7rpHaxa6ZU9jvf+hnDMw18BM/Ss44fzbhQGH2xFIfzPyauqIuodTWu8UIXKDfExZBdLHeQwgPmh6kuV8XWNnoALrhh5uRVEuPm1JMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943430; c=relaxed/simple;
	bh=1rYzlkPKiIczgAYiOOJDQ6sU2iqvo/0OYVU/JY1IAs0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=r4wMcmk70d64nmCGbIrk3d2zLt9KUcofqQTpyinzhm9tfoN3NToNDvnI3Gs8C9SALOK0/FbE3qWiVFmSUEEScdo1gonz7H3oqGZJeMK7S8tRcxDMWlyffI3udCFTRrmv45EDWID+bWoC/NRkycHMrT5DRJidUhwuYycjAOpL/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dibZBgC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBXCXcZs; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dibZBgC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBXCXcZs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3894D1D000CC;
	Wed,  1 Jul 2026 18:03:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 18:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782943427; x=1783029827; bh=oYazdZ1QhU/FueJMM2YMIqtQK6RtyrEkgVp
	0AKREgY0=; b=dibZBgC1CXPl+xLY18JF60esvJaTPl6FcvHvOESHFaT3CmTNpCy
	57d6deIow8qrRk0BRqF3ymF0pt9PQDQINhLpvqm/C3cYggl0jkkk7Ua5zZeJocTl
	E8FZqdRTnH3Ely4TSoydKvOcqir5N4BYqpltrLYDHmGMGKdGmkPHEAqCXvl/lsXh
	QvYPDddwFeR4ioQXz7XixEj3Vj4CPuBqVpo4E3abjnCLBbXSDpf+AJFsY+iBGwUE
	YJoP7otQSVMB9hWLKGSz5CGhpmx56yiT+laAkF+uxxheiEjsVEbRaX1k0QwpkDja
	tCOebQCn3/mpQmK1mJqhPmLJQPKhYv2YWKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782943427; x=
	1783029827; bh=oYazdZ1QhU/FueJMM2YMIqtQK6RtyrEkgVp0AKREgY0=; b=S
	BXCXcZsQ8mqWvEYcQvXSTx2O0UvMHLEFuPWkeR7syoJjCWlVXDjSY0qMyQ0qKSs+
	tq/LYOm0E5PybDmxOXpFTvHDx0AMhA6/UAbXHxKpknLZmkzO/VF0haHCv9L05yMW
	55GQUg5Rw/3XwRi/EDIMDZF/m4+/8ZN7nXD3wiV9qU9emD6S0SFalFAVr+3C0sQQ
	TdFZb4P5PUoKDMXGJSW7OQTb4wUoYSKb5Trpdj7T1mY/scqPK1SDmvd475es7akz
	ltET7/XYWl4b0dCtcoQ7qrs1cfD0G1ijx5RXlWdIs/BuO3BMbcJj12F6sW6n98eo
	6Lx0juh0gIxKRtlClt0dw==
X-ME-Sender: <xms:wo5Fak7YyoOr2EpWFiY3UnTQFZ_1Hkh83INwL50u-j186lQuXQFu0A>
    <xme:wo5Fau2GmGvJzM6z7D3rciB4Z2zVklZj9suvCIb9TNCKBkSPAVEhqX6AZFptbfhQg
    Rn6LWZ0FNEuRUJkJe1RWdkb3WLXtg0f_4FbpIBmA-Ok6QqBcA>
X-ME-Received: <xmr:wo5FavCo3xciPo3oSpF5MCOqXpDBZsg9CYJr8GcAfXXh_8WGVMVXr0YFjM2R1HHufKRlai7QQfbprKhALj4RRUCXsS0gJ7U>
X-ME-Proxy-Cause: dmFkZTGNNjlDNQwxTrSOq5LJGXcPjCFyx0rimsssPzmbau5MBkJxc+ArKw9vhalwyJ/M0O
    TsItda3dTLpJWkEdIgdrMXu0FzomhPDHuPZD+VJgor3Ex+Z7CGrZBmUTictzbvZtOKo136
    8dL6ObbuEtTKAUTeLDbniYKD3zskCqrzJlTqVNKobzAYexVEdcc7QZyBySrkl6t2PFcpg1
    q3LSLrnr1mgWlam5SRrq60mimlUyPNKV0oRb4x9QBrEoRx6B3qXh5cNAYxVTFxFE17Y/LW
    8ahlO9lFFzs58eLdGpaLbC48F2aCTHEB0UxKb9cIWo+sutBvX+ca13pCO6pN5/bswSGFhC
    JBRYLDmg6rjo7Y1FX+X9Lr7p0QBvbUEFfEiCMjQyT04+mhkkCEJ+Sj8TlyDILScHVQDCCb
    o3QyvhzhxC10wC7U5LqcjJdrLj+WyHxRxS4rc9eaX+PJBr1CaY6qxfBQ+aArTwjWvVA98U
    kCqfQm7kUwDv9QbMhhTgi9fNfTqMLbmqUz0XOxT5KcbRrn/MtdZB9xoGfo6kDI2aD/EssB
    u7Qp3tm1LaaUvJA0l9LaMABpMLUpSQu1fbENT8ivhXC4zYp2ajfCKOLAYEXgV3QMdfHs/X
    XvczxKHNjUHVpPkwZXT7Iu1Y3tIALmkZ18CA/sfX+O4AayitrAiKNC12gG+Q
X-ME-Proxy: <xmx:wo5FapPPs_BqZl3_fUqsGDCdtfJO2f-gXQOhs_dEe1M0s2qsyGkegw>
    <xmx:wo5FakbOVCdHLSqjqilIHUn0aPFxizBnjBpFx_bFBTOHFpxiXal69Q>
    <xmx:wo5Faosn5LBmZWvho7tUAyUMHx3gKe1fmNmMT_FuT-8wYZmQuYBtXA>
    <xmx:wo5FamOHRbHOQKa4rUG10JcMqR6ku5V8UAP3st0aQCIc4yKiepbo_g>
    <xmx:w45FauXxKJqv6Lgy3SVAQtKtm9KZFlm7m9R1WHY9EOhQL1L_aASyH0zX>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:03:44 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Remove excl arg to ->create inode_operation
In-reply-to: <39244151.3680933.1782911540642@kpc.webmail.kpnmail.nl>
References: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
  <39244151.3680933.1782911540642@kpc.webmail.kpnmail.nl>
Date: Thu, 02 Jul 2026 08:03:40 +1000
Message-id: <178294342077.27465.955368983460781263@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 01 Jul 2026, Jori Koolstra wrote:
> > Op 01-07-2026 13:51 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > From: NeilBrown <neil@brown.name>
> >=20
> > The only time that 'false' is passed as the 'excl' arg to the ->create
> > inode_operation is in lookup_open() when ->atomic_open is not provided
> > by the parent directory.
> > *all* directory inode_operations which do not have ->atomic_open
> > completely ignore the 'excl' arg.
> >=20
> > Therefore we don't need the 'excl' arg.  Those few ->create operations
> > which pay attention to the arg are only ever called with a value of
> > 'true'.
> >=20
> > We remove that arg and change all ->create operations to behave as those
> > thhe arg were 'true'.
> >=20
>=20
> What was the intention originally of the excl argument? It reads like
> the vfs saying "hey, I intended this file create to be exclusive (because I
> did a lookup and no luck), do with that information whatever you want!" But
> then for the filesystems where this actually matters, because the locking i=
sn't
> local, we also have to deal with opening issues because of the O_CREAT path=
, so
> we need atomic_open() anyway. Is that the gist of how this came about?

Back in 2003 a 'struct nameidata*' arg was added to .create for NFSv3 so
it could make use of the exclusive-create functionality in the NFSv3
protocol.   This was long before ->atomic_open existed.
In Jun 2012 the 'nameidata' was replaced with the 'bool' that we see
today.
That same month ->atomic_open was added for NFSv4, fuse, cifs, ceph, 9p,
but NFSv3 didn't use it.
Then in 2024 I converted NFSv3 to use ->atomic_open (to make O_TRUNC
work properly).  This removed the last need for the 'excl' flag to
->create().

>=20
> Anyway, looks good, thanks, I'll rebase on the misc branch. I only see a st=
ale
> docstring in gfs2, other than that:
>=20
> Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
>=20

Thanks!

NeilBrown
