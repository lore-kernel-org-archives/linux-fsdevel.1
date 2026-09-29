Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C83E44F8;
	Tue, 29 Sep 2026 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720143; cv=none; b=oJ8xp8ifqDgMl4hDCGEtEWAK4KAjMo4K1cvFW62LATYmGLsEmIFr+oBhJuu69L2UiWc82tzTifzuCfRIEBw0gHZDb6aQkypNgIrXECbp+Dnx3RQzrYR/IYI3VDq/g0h7Orq7QqqNmVSQwFUFjEJZbkNWuHPwqPskBrWXQn2KCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720143; c=relaxed/simple;
	bh=lA8OIGpr+3IoFNeyfse31X5HT+AJVfGcyMWh/vW1LT0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=a3ELxzoSWV38ryPd+O719lnP5Ipa2+fbl1Utz1UmghTjb08D/ftHkZgKyWnOAzWKAQgJyUP+8JcmtEIujNGowfZR6vgUG7m0Km9kU0iFsQKltUrwQJCP5dWdooEXxz5LAB0cB0b+lJAmfvTYUZS3xeRTPfQOhk/yTJudTm6hq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=egL6wDpx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjMrI3GO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="egL6wDpx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjMrI3GO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 422F5EC03D1;
	Tue, 29 Sep 2026 18:15:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 29 Sep 2026 18:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790720141; x=1790806541; bh=ECZwRXFI7wxFvuUVQQBk9tWmQ4CQX/umKjr
	mqyu1z/A=; b=egL6wDpxYbbEaZ2Wu1NSMbYrtJszLskmRKFQc7Apn7ZwcVN+d2b
	7d/atozANqH6yHKOBjczc03tuU7xUFMO4WZ9CC9EfjgapzMFkOuxPJpbHNt2rUeq
	reX0Cz1tZei1ibrLtyZuriwJb/pabatPqq9UHqXRsC16maS9o5Kar77C3kHh56tX
	xBDW15NY11kKRLThDkYNXIZ1IatesyyVCIWutW2yWFdcbidsplyp6oGbOPhf26G+
	J46UyNaVdvUWxurBfzEGykChueIDu0lBMlB16Uqv/5p1NLzN9LOPNCov5iAOzkjG
	h6CIqrw9j15rvgdKYudIFChWrT6sJZy9lmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790720141; x=
	1790806541; bh=ECZwRXFI7wxFvuUVQQBk9tWmQ4CQX/umKjrmqyu1z/A=; b=J
	jMrI3GO/sP7zgRMSqyODMbjxD5lwdJnVwxnijglxgWUq8ckSs9vZyM9TmTEwTByg
	5Hs3DYXzIf+eBWunOD67TG5o9dwrzZkxpXM+a5rZyDaZgVqFq18U+h3FjcNFy2Me
	fT7AOVHrjxdAhYPGOFEY82tsEo8LDYqec7AVeLv263uKcYZsDXyy6Lc81tSUxrsk
	pKoCjqIwQTTI4EwcPL/Tw3Mc9VfJlGCbZrvHW+xfF5vkOd4LKaQ4EQaoB4Aa3PWP
	SJnjmxBMDdDu/teEzra1cWV/CwakEMzgkLF7J/vzBQyiNuVhFnoj8kdwNnSqOGJn
	aLEuUjlbZO7fXXncrpdCw==
X-ME-Sender: <xms:jDi8aq4U2CAFQbh-yk-WUXf8QfmRm2_hA1Jugr9Npd1QcnW5jdrtvQ>
    <xme:jDi8agcJyYp-LCWyMkiCvQDTymumBxyid4M_lW99eWpQGhvLJAd_Vs4rR_VhlZVyn
    DVoKxLcyR44flc-YFe06qTpnheS0C_AbCiCvTUNqKWh-nel3bs>
X-ME-Received: <xmr:jDi8at5az42ryhWom9BZVG4L8GPBEmzjXwq7tbWVtv1ccZ8nO-rJmz6rXeD946rk4h2lsp3vKJRlWkHUJ3bsdUcG42In7us>
X-ME-Proxy-Cause: dmFkZTE8marj7DVr8hg1dxlC9utcvKFkho3si1jq9DAv1zFhVKum0yYAwPlc3PrSQ2jgD4
    b5aTj2x/l8XyGdReNrwPtKAeEUtcZlsWCYt6f68RbEckrAiHLyLes3uBHOy1WFPKXioaGd
    2uXbprb6PKe+QKDMWlHyDbk94bTJ/o1eRm73JZ7+GGH+BPsYTMEdeb11OsWFFiJtz0ropY
    A5BJe+4UilyOJf2kQslC0vvWvvKItw7nCNKM3QCdpLFRvVK//KyRxOd1OaF6MLTzzKXk9K
    DYO8WEh+Y23Y95oi4bGvUDdYtD8x5VOgRxqf/RsAX7zpZMZUUOo8jcGJDBGTRAy1zQNMdZ
    /72w5NpzSUDnAtlCiyaXcmmHmQzNeZ8Cot1STLMho1mEOhPwTFNsNE0mHjpHwqjp1AfYcT
    p++ekDTpNjzK5vunCKjT442JOHxtvoT+sO22UzPODaTYChCAD7IRlIopghtQHNUXA7yf4N
    NRO1AYJnAiCMOupisgTl/iH/G5WpnXkvXwG0ExaR4yiL6HpCirnAUU4eY1k8nvoo+Vr/rP
    JiGYnp8ln18TYO7965wZ8OVr+BZbFg3Of3lFfqyjgbbRHRmivaZJHeCX6mk6WBIGqEoD8b
    hrMhHatjMqljiH06Vnk5iffMOgpe59XbfqYrQbx2atLtQ2kwUVVW9TP7wSFA
X-ME-Proxy: <xmx:jDi8at8lCiY0LfqOE1qMyp7kmhr1u8yMw07dEcZUc0Hms0l2ilWuHQ>
    <xmx:jDi8avFRCvgUjGMXEFaWqZ3BcMBD7SBO3NGRAnwoNe5Fak3-fAio1Q>
    <xmx:jDi8aiXhMUPCA4NGy6fajk7vV49cpL03WZJhxB9sT5EQS-DcWF9oxQ>
    <xmx:jDi8ar-DYKSmHeTXT_NYbTuvn46ZaTIjhBZ7b2RlOft5EdlX1DMlaw>
    <xmx:jTi8atwIepATOJfUFycg2qPMfoILpMnJVKlN4kolCjeMhCqxacL_7j6j>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 18:15:37 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
In-reply-to: <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
  <20260913185016.523376-8-jkoolstra@xs4all.nl>
  <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
  <178972607557.207413.4312278359822083538@noble.neil.brown.name>
  <178977609418.207413.15011378414000392029@noble.neil.brown.name>
  <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
Date: Wed, 30 Sep 2026 08:15:34 +1000
Message-id: <179072013439.37859.465558431050704411@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 29 Sep 2026, Jori Koolstra wrote:
> > Op 19-09-2026 02:01 CEST schreef NeilBrown <neilb@ownmail.net>:
> > 
> > > 
> > > nfsd_create_locked() used to do that before vfs_mkdir() could return a
> > > dentry, but it doesn't any more.  The reason was because
> > > d_splice_alias() on might return a different dentry. 
> > > In this case we want the same dentry, but we need to do a lookup on it.
> > > 
> > > I'd rather fix this in kernfs, but maybe that is a longer-term goal.
> > > 
> > > The comment in kernfs_dop_revalidate() suggests the we should d_drop()
> > > the negative dentry and d_alloc_parallel() a new one and ->lookup that.
> > > I'm not certain that is needed if we keep the parent locked, but we
> > > would need to be certain.
> > > We at least need to d_drop() the dentry before ->lookup as ->lookup
> > > cannot handle hashed dentries and a hashed-negative dentry is passed
> > > to ->mkdir.
> > > 
> > > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
> > > probably not.
> > > 
> > > Summary: I think that if vfs_mkdir() returns NULL (success) but the
> > > dentry is negative, we need to d_drop() and call ->lookup with a big
> > > comment about kernfs.  But we need to double-check that this will do the
> > > right thing with ->d_time (I think it will).
> > > We also need to think carefully about races with
> > > kernfs_dop_revalidate(), which could happen concurrently with the
> > > ->lookup.
> > 
> > I've thought a bit more about this ...  I think that doing a lookup after
> > the vfs_mkdir() results in a negative is a bit ugly.  It assumes things
> > about the fs that I would rather not assume.
> > 
> > I would rather have the current proposed code check for a negative
> > dentry, and fail with -EIO or similar.
> > 
> 
> I just noticed that there's precedent for this in overlayfs in super.c:
> 
> 		/* Weird filesystem returning with hashed negative (kernfs)? */
> 		err = -EINVAL;
> 		if (d_really_is_negative(work))
> 			goto out_dput;
> 
> Shall we just do this for current kernel release, then we can add support
> later if wanted.
> 
> (But let's do EOPNOTSUPP instead of EINVAL)
> 
> What do you think?

The problem with this approach is that open(.., O_CREAT|O_DIRECTORY)
might create the directory, then return -EOPNOTSUPP.  This is weird and
I'd rather it not be visible.

Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
remain a -EINVAL on any filesystem which doesn't completely support
the functionality.

To do that we need some way to detect kernfs and tracefs.  I think
the only way we can do that is to make some change to those two
filesystems.
Maybe a new  SB_I_ flag in sb->s_iflags would be ok in the short term.

NeilBrown


> 
> Thanks,
> Jori.
> 

