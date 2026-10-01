Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F938333C;
	Thu,  1 Oct 2026 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816437; cv=none; b=Y34I7pxDHp5ozw1mg+bADStECmZOnkZTzNEIJdjrIu0B9rpeeavSiXRwXbF13iNgt4CHO+xr3J0T2J6Dfl/z9ovoUYdihfKQwtV6fMr4Cd5Nk8/pu/K+dg2l/5Bl08RisKe4pkquXDNTb92lYA4zgd8y0V50Kr1hcQvHcoqspjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816437; c=relaxed/simple;
	bh=zcYKqYXkGZepib97Gcn3q7+lD63QZeO9TLJgzGhL+eI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C8gqM3K675CqFkQU10/p2cPVRoepybTibVLbRSZRBb+nTdhh5v/G7R3+zQMRtdJf5HnLkywrj3q4S07Bgk00n7H6Sjp6WtIP4bYy6lL/nHNfmUqZEvvtnKZNaZEyvkO6uTXWe+l44qlOg7s35TRpw95hajSeXZH5RgdFIkdQPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=U+TY0PLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l5QfdAkl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="U+TY0PLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l5QfdAkl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A35A414000E9;
	Wed, 30 Sep 2026 21:00:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 21:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790816432; x=1790902832; bh=rDLuCjt9UmJtQ+S8KqwRJ3F5z+++KsERpOC
	1NwMqUYU=; b=U+TY0PLtXTy5crh14ANJk6O3+LVvo3Y3POHHMBx4Rd8QAVIOSw+
	8JjMRipyuUly3T9wquFhhbMv5VhlxCSONhWZ2bAj+Gz053xxXZ7LASDEAga1UAyL
	B4AZRRXilqMi/NiGWkEU0JHThfc26R6rvqln0piAlcodwd6uMm+uIM0cDNZ2TrZ1
	5aZ3zCcH2E3e5PqtPHREjutLZ0ITz8ZIOjkvMzkzhV8lDPxfpCW+LMxr+NNrLiFE
	rcVi2mrSFke7yx7uvwr0oyE01a5l1DjU9vSJvKLO0M7T01ot3pRUeNXVQ9BLkBGP
	X/9OSYcSp6LrEf1JMOD4+BcaU5HS/yixtPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790816432; x=
	1790902832; bh=rDLuCjt9UmJtQ+S8KqwRJ3F5z+++KsERpOC1NwMqUYU=; b=l
	5QfdAklZPPT/cvIShtU4+frNI6L8dX+S/79Cm8T28J3sa4WfUpc9zdrBukLzn/Bc
	yYFLTHPNJpMGnCdYdqtDY8TZz4LtfXKIzlByyTtm4YBJXotHu4vE5T9hG4OSovzK
	dIS1ubPRJMjJLOKnZhSqdVzQXN+TocMaBa4pLzHEBUNcxuQF6dTQ4wV5OPGC1ea6
	pIIXYLczfzLo/8eriGMEoI/mo7y/fIPrNmXP7oAscIJMnnYPzcPD6avISurjNokE
	0yI8FL+IG16OMN79DAR3HhquFA1d8AUDfRIjcirWgaq7O/eZrveCA40dSYpPzGc6
	oJRHiB20zo+ymotO3A2Vg==
X-ME-Sender: <xms:sLC9ampi_XStXBmGzvGwJlifbZuD6qkJ0Vlpti8xhKI8CQQj-YZ45g>
    <xme:sLC9ahMK0pPNcrFCLNgm6mvTHWQztSGr-m7ngMdkRk9vafsHNAnZrRU2-xBYecV-g
    NdGp3k0kbIrnV_bpGylEK41NuMaHXZDV7WGoBdF53XehN3DQjU>
X-ME-Received: <xmr:sLC9avqUpdzNM9jxktIBTA7LUffUvlTwn5xHQYHAr5SsFA69POTZ3b_k5m7maCcHP5N88P66_kVPLiRoZVgvpZWXrxDL4I4>
X-ME-Proxy-Cause: dmFkZTFfLuaJZ5O/pGqqdwevqBOTM8Y5OvdzSzISGxNljqZf4VQ6rO6OSVWP13lQHuz8IL
    0t7kRInDLldPhc6cPJzxCvVBt8Xjc3TSXUFGlpB9QzPVIw3yBcHA4G0Qe0HTCZTxq242jj
    YD2gYcfgOXd2gE3CgZwQ5nCv5Q57aYxzu6poTTaQsyxEicaCogKWiDTFuhhCB1Au68BH4P
    RL1JG4H/J28WYp18lDft3s5xMoUCK7nPXg4CZI1ZDV+XEzQPFFTmv4n3wPY7FwS8bS7EFk
    TK6aD1NDgXxW9oNPLWHS5i45BP/IFTU8yhOs8Zp4txHZI8x59SHmYgTc+vRqVK4LWuyEJn
    hff7CrecyTjm/GwTrgmuSQns+k39nL+KUiBTpx4/rGVJaVE/wrkmG/iZVa8Z/KwzFYcplZ
    wuQLfbx+wvjLJvT36GbpF29V/FBVCcUKovgONAB0akxE2DWEEv9XASVknJUkOScvQsJ7aR
    qjhcYm+DMdhCelnFQPxXfUdfD+0hGyZfSfyhh5kqlL08vu6qXoiwRUv+evnVSsxop4faQG
    eugqyInz2yDJu2xPZEMgM4l5kCKuJHuOQNaDcBX+U5DcpHAoz6ptcpqUg9Y0g2kgqxdC/n
    IhzRXCDQTLIo0UMF8glXMR7onROHRuuQ3mQpNqrCpKXWXKItqbR4Hbk1Gkhg
X-ME-Proxy: <xmx:sLC9assLRglPnOrQU5OC2VeLdqbKtzsbrigt-6FSNIrKsn7S_DbuFQ>
    <xmx:sLC9am0_rSbdn1GJ74tmO5coje3Ub4AxARv7FR2UriD3rKZ_rC4Gfg>
    <xmx:sLC9avFmPvZfBbdQKrIdpA10Cgyih2BQjCa0KpDqUSKRyRkFyUipQw>
    <xmx:sLC9apvD-mCEnq5vI0KHEQ1s2z3Q9Ik9SbuL8HdFcOmKCAFdl678qA>
    <xmx:sLC9ag8nuel9FZJkIYJgsJesayG_V9OksmVxO5HgP3ALfqMPkAlK6zuO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 21:00:29 -0400 (EDT)
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
 "Jeff Layton" <jlayton@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <1755972037.791960.1790810730535@kpc.webmail.kpnmail.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
  <20260913185016.523376-8-jkoolstra@xs4all.nl>
  <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
  <178972607557.207413.4312278359822083538@noble.neil.brown.name>
  <178977609418.207413.15011378414000392029@noble.neil.brown.name>
  <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
  <179072013439.37859.465558431050704411@noble.neil.brown.name>
  <1315372552.791055.1790807597593@kpc.webmail.kpnmail.nl>
  <179080897361.37859.5844379463485936668@noble.neil.brown.name>
  <1755972037.791960.1790810730535@kpc.webmail.kpnmail.nl>
Date: Thu, 01 Oct 2026 11:00:25 +1000
Message-id: <179081642552.37859.15689377825373435277@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 01 Oct 2026, Jori Koolstra wrote:
> > Op 30-09-2026 18:56 EDT schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > On Thu, 01 Oct 2026, Jori Koolstra wrote:
> > >=20
> > > Err, *derp*, what a stupid suggestion of mine.
> > >=20
> > > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > > > remain a -EINVAL on any filesystem which doesn't completely support
> > > > the functionality.
> > > >=20
> > >=20
> > > I don't think that works for the reason I just wrote in my email to Ami=
r:
> > > it would make lookup dependent on the dentry cache. If it's in-cache, y=
ou get
> > > your dir, otherwise suddenly -EINVAL.
> > >=20
> > > > To do that we need some way to detect kernfs and tracefs.  I think
> > > > the only way we can do that is to make some change to those two
> > > > filesystems.
> > > > Maybe a new  SB_I_ flag in sb->s_iflags would be ok in the short term.
> > > >=20
> > >=20
> > > We can just implement atomic_open() for kernfs/tracefs, do a lookup the=
re,
> > > and if negative with O_CREAT return maybe -ENOENT (or really we need a =
new
> > > error that says "the requested create could not be serviced," like -ENO=
CREATE,
> > > or whatever). And if it is positive we do finish_no_open().
> > >=20
> > > It's a bit of a hack because it does not really have anything to do with
> > > atomicity, but it does short-circuit the mkdir call in lookup_open(). I=
 guess
> > > that would work. Maybe I am confused, but wasn't that what you proposed=
 here
> > > earlier?
> >=20
> > Yes, it is what I proposed earlier.  But I think it would require more
> > review and probably make it unrealistic to land this cycle.  But I'm not
> > thinking it is unlikely to be ready this cycle any way.
> >=20
>=20
> Not unlikely, so likely that is :)
>=20
> > I'm now wondering if we should keep ->atomic_open out of the loop and
> > always use ->mkdir to create a directory.
> > Based on your justification you probably always want O_EXCL and I would
> > be inclined to require that.
> >=20
>=20
> I wanted it to work as regular O_CREAT, so no forced O_EXCL per se.

Why?  The whole point is atomicity, and without O_EXCL there is no
atomicity.
I guess it doesn't hurt to not require O_EXCL, but it is just another
combination to test...

>=20
> > So if the dentry is in-lookup we call ->atomic_open(O_DIRECTORY).  If
> > that succeeds - good.  If it reports ENOENT or a negative dentry, then
>=20
> Can ->atomic_open() return a negative dentry?

No reason why not.  It is mapped to  -ENOENT

			if (unlikely(d_is_negative(dentry)))
				error =3D -ENOENT;

I'm in favour of ->atomic_open() calling finish_no_open() is all
no-error cases where it didn't do something about opening the file.
But I don't object to an explicit -ENOENT return.

>=20
> > we cal ->mkdir.  If that succeeds with a positive dentry, we call
> > through to call ->open.
> > If ->mkdir succeeds with a negative dentry - we have the problem of
> > kernfs and tracefs.  I'm leaning towards fixing those to do the lookup.
>=20
> Yes, I follow this. But we do need to ask their maintainers then why that
> was chosen. Plus, we need to ban negative dentry returns also for future
> fses, which may be limiting.

Odds a good that there wasn' a specific reason why leaving the dentry
negative was chosen.  I think the better question is "do you have a
problem with this patch" where the patch does a lookup.

Putting a WARN_ON(d_really_is_negative()) somewhere in vfs_mkdir would be
easy enough. I cannot imagine it really being a burden for any fs.  If
that does happen were can solve the problem then.  Being prepared of all
possible eventuality is a no-win proposition.  I've tried - I gave up.

>=20
> >=20
> > I don't think any filesystems *can* combine mkdir with open, so not
> > using ->atomic_open for the mkdir doesn't actually lose anything.
> >=20
>=20
> Yeah, I don't quite understand the specifics of this as I am not familiar
> with NFS and the likes. I presume because of things like network traffic
> ->atomic_open() was needed as a single call into the underlying fs. But
> I have no idea why or why not that would make sense for directories. If
> we do it the way you suggest now, we can get rid of all the O_CREAT strippi=
ng

->atomic_open was created specifically for NFSv4 which has a combined
lookup/create/open request.  You can do everything with a combination of
->lookup and (exclusive) ->create (providing create returns a
non-negative dentry) and ->truncate and open.  Using ->atomic_open means
fewer round-trips to the server so less latency.

NFS doesn't have a concept of "open" for directories.  CIFS probably
does.  FUSE probably doesn't but could possibly add one.
But directories are not opened nearly as often as files, so combining
things isn't so important.  And O_TRUNC is not meaningful for
directories so that is one fewer thing that could be combined.

NeilBrown

