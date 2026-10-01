Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FC519E0B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863661; cv=none; b=mXLkYNNcVWIMtyKyUBQLQ7SjHatJQDBvteg0XTkK9zfuc7GixUm+Dn1jILhu6jeMXMXzszqL9dGDZ1JIC9IdS+ZYSMABTlZ5PsnyHN1efXVnT0Dg03qYWgTIomtoSuuY0P3Nb6NtvTvuixlpfsO+PDxcf1L2D1zenlomWY3QOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863661; c=relaxed/simple;
	bh=VQ68KoETTaTbq1W4z1Co0MYsBOlSnBJd0Lr1l+VIGDw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UjjM7lldQR+CHXFg8616JOhF0g+xCuKUcDjFET2YCZbHw4EZ6jMA2/IWKRXTrsRfSrPiYx15Sj1TrT6uXV8MAE2UtvnPgK3YLFM2N/m1w383A1mFX86Dmip5kvhk/SZizsAFDpMG4XILd1AcnKFkZXKOOL7KssTW5mPL8VAKJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=uRVKb8IQ; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uRVKb8IQ"
X-KPN-MessageId: 72bfe7b7-bda1-11f1-8f57-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 72bfe7b7-bda1-11f1-8f57-005056992ed3;
	Thu, 01 Oct 2026 16:07:33 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 72bf2264-bda1-11f1-a0a2-0050569981f5;
	Thu, 01 Oct 2026 16:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=ZgfxoLBnUQqnTXJgPuegUZqvtKWrrV2pWURmU7VkNFI=;
	b=uRVKb8IQVxsJKxqOQwLyElCcT3gLkpsbDsYd+nroZRaL+VgcM3cfZl6XhQayHlFY9KglOxCAMiLvZ
	 ih6KottRJjrnt1Rd0VbvgzycKjF2yz0JwNcu8FjvNC9Zl9vU7ZW2/80tXvF4ZRy2OdjnuKJvepF3TA
	 1TRUsqeJlAG2zw1gcRgyqJ+WfFUiVqexkBqXAJD7+IvBr8qL/esF9TQYC79QffNnvHRZvPbjdXJXkX
	 EUPYz6/JA29qwJk/5/ljBxmqaHUUWW28mItN13t/EDboS9Pcwl7zHvND75pmKkJXOLFj7MjIWmJPAh
	 qu2AeAkc1hgWB4JxFK1muuqg6qzdKFg==
X-KPN-MID: 33|hCqb9EvfgAsBlAelse5FgHWECay6opsKoaJd5aW5bcOteOeVQe6WztcfuJ/8eP6
 Va04y049QvnFp62VpHfww7ONXKaCW2xrMEXAfakqpBn8=
X-CMASSUN: 33|2T5y/5RfUaX/9zLBSWjTZv2zKk5K4+VHnIgFmlQNbszsj4xUYnuJQiNet8GXOuq
 UR2FGXlRFqr6HpEp/wSrCVQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 72b2fd8b-bda1-11f1-916a-005056995d6c;
	Thu, 01 Oct 2026 16:07:33 +0200 (CEST)
Date: Thu, 1 Oct 2026 16:07:33 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <592021678.912642.1790863653687@kpc.webmail.kpnmail.nl>
In-Reply-To: <179081642552.37859.15689377825373435277@noble.neil.brown.name>
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
 <179081642552.37859.15689377825373435277@noble.neil.brown.name>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 01-10-2026 03:00 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Thu, 01 Oct 2026, Jori Koolstra wrote:
> > > Op 30-09-2026 18:56 EDT schreef NeilBrown <neilb@ownmail.net>:
> > > 
> > >  
> > > On Thu, 01 Oct 2026, Jori Koolstra wrote:
> > > > 
> > > > Err, *derp*, what a stupid suggestion of mine.
> > > > 
> > > > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > > > > remain a -EINVAL on any filesystem which doesn't completely support
> > > > > the functionality.
> > > > > 
> > > > 
> > > > I don't think that works for the reason I just wrote in my email to Amir:
> > > > it would make lookup dependent on the dentry cache. If it's in-cache, you get
> > > > your dir, otherwise suddenly -EINVAL.
> > > > 
> > > > > To do that we need some way to detect kernfs and tracefs.  I think
> > > > > the only way we can do that is to make some change to those two
> > > > > filesystems.
> > > > > Maybe a new  SB_I_ flag in sb->s_iflags would be ok in the short term.
> > > > > 
> > > > 
> > > > We can just implement atomic_open() for kernfs/tracefs, do a lookup there,
> > > > and if negative with O_CREAT return maybe -ENOENT (or really we need a new
> > > > error that says "the requested create could not be serviced," like -ENOCREATE,
> > > > or whatever). And if it is positive we do finish_no_open().
> > > > 
> > > > It's a bit of a hack because it does not really have anything to do with
> > > > atomicity, but it does short-circuit the mkdir call in lookup_open(). I guess
> > > > that would work. Maybe I am confused, but wasn't that what you proposed here
> > > > earlier?
> > > 
> > > Yes, it is what I proposed earlier.  But I think it would require more
> > > review and probably make it unrealistic to land this cycle.  But I'm not
> > > thinking it is unlikely to be ready this cycle any way.
> > > 
> > 
> > Not unlikely, so likely that is :)
> > 
> > > I'm now wondering if we should keep ->atomic_open out of the loop and
> > > always use ->mkdir to create a directory.
> > > Based on your justification you probably always want O_EXCL and I would
> > > be inclined to require that.
> > > 
> > 
> > I wanted it to work as regular O_CREAT, so no forced O_EXCL per se.
> 
> Why?  The whole point is atomicity, and without O_EXCL there is no
> atomicity.
> I guess it doesn't hurt to not require O_EXCL, but it is just another
> combination to test...
> 

Let me rephrase your point: if you do an O_CREAT without O_EXCL you still
don't know whether it's your file because it might have been there already.
So the fact that you immediately get an fd still does not tell you everything.
Right?

But, at least you'll know it's a directory and you still save a syscall.
On the other hand, maybe that just breeds incorrect use, and if needed the
O_EXCL-less variant can always be added, so we might as well force its use
for now. Then again, it might be confusing to do open(O_CREAT|O_DIRECTORY)
and get an -EINVAL or -EEXISTS, given current O_CREAT semantics for regular
files.

> > 
> > > So if the dentry is in-lookup we call ->atomic_open(O_DIRECTORY).  If
> > > that succeeds - good.  If it reports ENOENT or a negative dentry, then
> > 
> > Can ->atomic_open() return a negative dentry?
> 
> No reason why not.  It is mapped to  -ENOENT
> 
> 			if (unlikely(d_is_negative(dentry)))
> 				error = -ENOENT;
> 
> I'm in favour of ->atomic_open() calling finish_no_open() is all
> no-error cases where it didn't do something about opening the file.
> But I don't object to an explicit -ENOENT return.
> 

I don't have LLM access right now: are there any ->atomic_open() implementations
currently that do return negative dentries? Seems to be a bit strange, just like
with ->mkdir(). What would be the purpose?

> > 
> > > we cal ->mkdir.  If that succeeds with a positive dentry, we call
> > > through to call ->open.
> > > If ->mkdir succeeds with a negative dentry - we have the problem of
> > > kernfs and tracefs.  I'm leaning towards fixing those to do the lookup.
> > 
> > Yes, I follow this. But we do need to ask their maintainers then why that
> > was chosen. Plus, we need to ban negative dentry returns also for future
> > fses, which may be limiting.
> 
> Odds a good that there wasn' a specific reason why leaving the dentry
> negative was chosen.  I think the better question is "do you have a
> problem with this patch" where the patch does a lookup.
> 
> Putting a WARN_ON(d_really_is_negative()) somewhere in vfs_mkdir would be
> easy enough. I cannot imagine it really being a burden for any fs.  If
> that does happen were can solve the problem then.  Being prepared of all
> possible eventuality is a no-win proposition.  I've tried - I gave up.
> 

Fair enough. I'll spin this idea up then, to add the lookup to kern/tracefs
->mkdir() and add that warning to vfs_mkdir(). And I'll CC those maintainers
on that version.

> > 
> > > 
> > > I don't think any filesystems *can* combine mkdir with open, so not
> > > using ->atomic_open for the mkdir doesn't actually lose anything.
> > > 
> > 
> > Yeah, I don't quite understand the specifics of this as I am not familiar
> > with NFS and the likes. I presume because of things like network traffic
> > ->atomic_open() was needed as a single call into the underlying fs. But
> > I have no idea why or why not that would make sense for directories. If
> > we do it the way you suggest now, we can get rid of all the O_CREAT stripping
> 
> ->atomic_open was created specifically for NFSv4 which has a combined
> lookup/create/open request.  You can do everything with a combination of
> ->lookup and (exclusive) ->create (providing create returns a
> non-negative dentry) and ->truncate and open.  Using ->atomic_open means
> fewer round-trips to the server so less latency.
> 
> NFS doesn't have a concept of "open" for directories.  CIFS probably
> does.  FUSE probably doesn't but could possibly add one.
> But directories are not opened nearly as often as files, so combining
> things isn't so important.  And O_TRUNC is not meaningful for
> directories so that is one fewer thing that could be combined.
> 

OK, if it isn't likely that any ->atomic_open() wants O_CREAT|O_DIRECTORY
support we can get rid of some of the complexity. Summarize:

1. use ->atomic_open(O_DIRECTORY) for lookup, no O_CREAT bit passed in.
2. if positive then done, otherwise (on -ENOENT) we call ->mkdir()
3. open that dentry in the regular way, WARN_ON negative dentry return

Best,
Jori.

PS. Maybe I asked already before (in case apologies), but will you be
at LPC?
