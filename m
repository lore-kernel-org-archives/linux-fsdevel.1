Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607E4FD292;
	Wed, 30 Sep 2026 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808988; cv=none; b=UsfzdiKk3lFfs1Aex7iusjlYLBnCvplIZHepvKcilq7rw+kUWadFUjP6M3fgNfr6VAsjFFMPLnQxE4am6VO0RU2cvTwJa32iwqZ8Pwn6yoGkKG0k6s5lwDKaZsSXsV12w1nuH7FgsXhFh1OXUT2NshejvRs7zxgNgGGXgTjRe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808988; c=relaxed/simple;
	bh=Fsu5NQlCxBS+INeuqKepH2CZidfHmTd7vBs1RMZCQTk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FQQEE8GpqK1m42a8EfwIRMtA22NEGIFhRrzFU9ObOBW5Yx5at9ekCTTD3BpOwU7SB9APLl7GSUKlFGnvJIBCmMh35xovmfIzKYs6Q6rtTP958P2l5kb87JsF/9vm5OTd1Gu1OYepPrzCkGN6P24CidSR72QA/EzI8UxjcQ42wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mpbZRaMD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZkSObmJI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mpbZRaMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkSObmJI"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 933277A0124;
	Wed, 30 Sep 2026 18:56:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 30 Sep 2026 18:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790808980; x=1790895380; bh=UpoYj5If8cvLtUMJRGujVMaeBwIGL4cxlFh
	zxGpn6ww=; b=mpbZRaMDk6FdoOIzGNqQfY5iGKAjxoibzn8fMYH4su7kHgvGnF4
	MQ2suVcDkjOCtS/NIisIghhXIk/VS4ht5S1AHWjoYP3QurzqfEJadqzVIFNBrinY
	2fSgk+kUqybrQTb5AAU8M3AD1F5LOjVtUkFadDGgGQmEKwK525UJ/X43zxi9veHk
	/cxvNR558mV1e+0hLlUBvObElkAyzRFdio10JxoNKcBr9pgYqQERyM/f+ZoTUWfy
	ilzgTeo0vvsz9pdnAgoxdTnymWDMo9/gwcV2926LBE8PD4tJFo2n1cccK2bVPjFP
	eFOZhZBpadGDjzOAeBqGwQN/5aRNqJf+swA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790808980; x=
	1790895380; bh=UpoYj5If8cvLtUMJRGujVMaeBwIGL4cxlFhzxGpn6ww=; b=Z
	kSObmJI6UhltOp4GP912pJvU2EriQtkQPKHDRR+t7a74bc0zZckDtQDZdqVDjkBp
	Wm3iuiAc+XqtP9lO+9SV6Z6ujPm7LQgdpKcrHtqhxzRIkR2UCKrx0Or3t0b2EN3A
	H8DeLY7nfdl+PwrTCyJ6nP2c6DgQyxXgeZ8TVMVJTOGbIl6PhcRuFJPdQCEfkwSZ
	FMuuSyA+Gifesni0qiJNaOJ7N/9P+dS6ZrvLuJ65g3wubpKu2WDZida7gCcUSnF6
	xNMiNT3qQ5gmxHVSRbMP/S3hFBSkUy8GVNm0wrNAovOPcSriH8DPdlFWsA7hD1My
	d99Qmu1nuoEzBfyt5znDg==
X-ME-Sender: <xms:k5O9avwZGjBPbmQ4oDkCod8NwU_WEs6l8ek8M-Zcourr9ZYo8rKzWg>
    <xme:k5O9ai-xa97JIewDMn_RZYWkF0wl8-UigdGABGopetW6cgm4cg0DwWl-1s6iQ0VFn
    jD7erlBh1-Js9-SG2c4tWL6NC57-m_hj01ohPDLxWBWuYLZOLI>
X-ME-Received: <xmr:k5O9alys077doyEhPIC4dm_km6ZqGVpGy3ZahYsqCTLFHjK3qzKxe_r6TIE-EInMEmrEOzQXHH30M_F0T_ZNQdhbF9d3Oz0>
X-ME-Proxy-Cause: dmFkZTF9pZpsQRro9bbxfUeX0oGPpCV+OHUrkNv07RPaSeyMHAQkylRq6LyQy7lX1/o2z0
    C1ZNCAEv88exUfVP/dXzUtZ6Ai5n7FKX5ehvunS/jit9tbaH0WlPkqJYvLyS2vUR6qRWtG
    RiYUaixqiZjqRjC03qlla8QfYBai/7YsoITL0RNcN6pDl5v5k6WoLR1oZCiuNVvlOWB2XW
    T0l7PZVUwBD349SClfD/reGYvOW5OEHkLMPAq3VyzESCjay0bEUqFogCuI3r663joaYIUr
    S6xHkRzhTqMf62f6kqBWCkH/hyxIaxWKMDlqUDV10pEGKUXOvZJgANLGAo/39fry7MRvWB
    /Hmn0io36sYTGQTdT4b7iFghaLTn0BwtEGLfLN40zqs+LvyFDglb6sujOoD4ixNGg1IZmk
    +8Ngx14GOa4iomAYIOF7FQpLCnWPF2+D/cJabLdRXwaCnwNwy9WzlPNazprh8wdfwqv+EJ
    HZqPfXOk0j2YRDg5nDCnCSc6jYhxGJoLHyQI4OJAXD94r2RnZgUWTVnPYPClPQtZrEEzFQ
    AysQI1TOi/HgkVLmYGaav0rHLOil1YQF5yfoETXkymvmuGiv1uU9l6jVL7tzbDwpA/rpmc
    83ifaB+ECqtugdiTkBBVcU4j3+JB34x/n+iKRR1MAlvodHhyUaf+8k0KOCHg
X-ME-Proxy: <xmx:k5O9airj6HVPv8FJMsRtDuyLu04WJP9k9G-gEY1O5vqp4i5i_c7BWA>
    <xmx:k5O9amrs-h_LMtkDfRMW2xOzQCtQN8XESsKq5MjuHJXSGySWWwFUyw>
    <xmx:k5O9aiBOtn_4dTDYVtwvjUj91ctDfHksdZ3HLlJj2CsjZ6EFEqEJ_w>
    <xmx:k5O9aksUwrIioGwkYvIJJARgnqFqjRPbyGvnQn6VJKeXt-EvlcCc-g>
    <xmx:lJO9aiVP0fmSZx4ClgwmLkkqH9buozOHCVBRzNuAPPZ5cgWW34HUvop3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 18:56:17 -0400 (EDT)
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
In-reply-to: <1315372552.791055.1790807597593@kpc.webmail.kpnmail.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
  <20260913185016.523376-8-jkoolstra@xs4all.nl>
  <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
  <178972607557.207413.4312278359822083538@noble.neil.brown.name>
  <178977609418.207413.15011378414000392029@noble.neil.brown.name>
  <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
  <179072013439.37859.465558431050704411@noble.neil.brown.name>
  <1315372552.791055.1790807597593@kpc.webmail.kpnmail.nl>
Date: Thu, 01 Oct 2026 08:56:13 +1000
Message-id: <179080897361.37859.5844379463485936668@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 01 Oct 2026, Jori Koolstra wrote:
> > Op 29-09-2026 18:15 EDT schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > On Tue, 29 Sep 2026, Jori Koolstra wrote:
> > > > Op 19-09-2026 02:01 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > >=20
> > > > >=20
> > > > > nfsd_create_locked() used to do that before vfs_mkdir() could retur=
n a
> > > > > dentry, but it doesn't any more.  The reason was because
> > > > > d_splice_alias() on might return a different dentry.=20
> > > > > In this case we want the same dentry, but we need to do a lookup on=
 it.
> > > > >=20
> > > > > I'd rather fix this in kernfs, but maybe that is a longer-term goal.
> > > > >=20
> > > > > The comment in kernfs_dop_revalidate() suggests the we should d_dro=
p()
> > > > > the negative dentry and d_alloc_parallel() a new one and ->lookup t=
hat.
> > > > > I'm not certain that is needed if we keep the parent locked, but we
> > > > > would need to be certain.
> > > > > We at least need to d_drop() the dentry before ->lookup as ->lookup
> > > > > cannot handle hashed dentries and a hashed-negative dentry is passed
> > > > > to ->mkdir.
> > > > >=20
> > > > > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ..=
..
> > > > > probably not.
> > > > >=20
> > > > > Summary: I think that if vfs_mkdir() returns NULL (success) but the
> > > > > dentry is negative, we need to d_drop() and call ->lookup with a big
> > > > > comment about kernfs.  But we need to double-check that this will d=
o the
> > > > > right thing with ->d_time (I think it will).
> > > > > We also need to think carefully about races with
> > > > > kernfs_dop_revalidate(), which could happen concurrently with the
> > > > > ->lookup.
> > > >=20
> > > > I've thought a bit more about this ...  I think that doing a lookup a=
fter
> > > > the vfs_mkdir() results in a negative is a bit ugly.  It assumes thin=
gs
> > > > about the fs that I would rather not assume.
> > > >=20
> > > > I would rather have the current proposed code check for a negative
> > > > dentry, and fail with -EIO or similar.
> > > >=20
> > >=20
> > > I just noticed that there's precedent for this in overlayfs in super.c:
> > >=20
> > > 		/* Weird filesystem returning with hashed negative (kernfs)? */
> > > 		err =3D -EINVAL;
> > > 		if (d_really_is_negative(work))
> > > 			goto out_dput;
> > >=20
> > > Shall we just do this for current kernel release, then we can add suppo=
rt
> > > later if wanted.
> > >=20
> > > (But let's do EOPNOTSUPP instead of EINVAL)
> > >=20
> > > What do you think?
> >=20
> > The problem with this approach is that open(.., O_CREAT|O_DIRECTORY)
> > might create the directory, then return -EOPNOTSUPP.  This is weird and
> > I'd rather it not be visible.
> >=20
>=20
> Err, *derp*, what a stupid suggestion of mine.
>=20
> > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > remain a -EINVAL on any filesystem which doesn't completely support
> > the functionality.
> >=20
>=20
> I don't think that works for the reason I just wrote in my email to Amir:
> it would make lookup dependent on the dentry cache. If it's in-cache, you g=
et
> your dir, otherwise suddenly -EINVAL.
>=20
> > To do that we need some way to detect kernfs and tracefs.  I think
> > the only way we can do that is to make some change to those two
> > filesystems.
> > Maybe a new  SB_I_ flag in sb->s_iflags would be ok in the short term.
> >=20
>=20
> We can just implement atomic_open() for kernfs/tracefs, do a lookup there,
> and if negative with O_CREAT return maybe -ENOENT (or really we need a new
> error that says "the requested create could not be serviced," like -ENOCREA=
TE,
> or whatever). And if it is positive we do finish_no_open().
>=20
> It's a bit of a hack because it does not really have anything to do with
> atomicity, but it does short-circuit the mkdir call in lookup_open(). I gue=
ss
> that would work. Maybe I am confused, but wasn't that what you proposed here
> earlier?

Yes, it is what I proposed earlier.  But I think it would require more
review and probably make it unrealistic to land this cycle.  But I'm not
thinking it is unlikely to be ready this cycle any way.

I'm now wondering if we should keep ->atomic_open out of the loop and
always use ->mkdir to create a directory.
Based on your justification you probably always want O_EXCL and I would
be inclined to require that.

So if the dentry is in-lookup we call ->atomic_open(O_DIRECTORY).  If
that succeeds - good.  If it reports ENOENT or a negative dentry, then
we cal ->mkdir.  If that succeeds with a positive dentry, we call
through to call ->open.
If ->mkdir succeeds with a negative dentry - we have the problem of
kernfs and tracefs.  I'm leaning towards fixing those to do the lookup.

I don't think any filesystems *can* combine mkdir with open, so not
using ->atomic_open for the mkdir doesn't actually lose anything.

NeilBrown
