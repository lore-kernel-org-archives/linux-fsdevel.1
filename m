Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47093537F1;
	Sun, 17 May 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779010970; cv=none; b=CNvvUZDTV9U8grNc2uMG+5y5rmwTrFzG4GrazF5EXHxPdp3rYGd7N2Q12SvAURRFAQk5BJf2U107GH7U6YXENcgNmdTbSNPOcBQ0qvClrUxEXfkSJqVSjuE9Iq62DJU6TEef1pkze4lMqFBaUEu1eosD4dfZ2zjZlrqMuvyjtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779010970; c=relaxed/simple;
	bh=Lg4+kXDk79K95N9DxPx/sDDeMzZxyj9ggaQo0suwydU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rilepzplPFN36kVQIqcme8XU12VaPPspkUQqDoAAl1Me+WP0YstiQnq5ay9yqL+TM+2uE69XhUIM8RTgBn9+vzysaqPlTUV9Mr1RyrVT8o3HgN8kXcgEXrk2Aolm99ytexs7ifrsejoLGyxSCXeVCEuEPnwWDa7CF8/2Rik6Mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (075-132-067-156.ip-addr.inexio.net [156.67.132.75])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 20DBCE0443;
	Sun, 17 May 2026 11:42:38 +0200 (CEST)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sun, 17 May 2026 11:42:37 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v2] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <agmK0xmOVL5TLxdy@fedora.fritz.box>
References: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
 <5afacskoalmd2u6s525dosvyrtr3j66ajd5m4p2ylymtlgytkz@excrdfpndx37>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afacskoalmd2u6s525dosvyrtr3j66ajd5m4p2ylymtlgytkz@excrdfpndx37>

On Sun, May 17, 2026 at 11:15:04AM +0200, Mateusz Guzik wrote:
> On Sat, May 16, 2026 at 04:52:54PM +0200, Horst Birthelmer wrote:
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > 
> > The dcache only shrinks under memory pressure, which is rarely reached
> > on machines with ample RAM, so cached negative dentries can accumulate
> > without bound.  Give administrators a soft cap they can set,
> > and a background worker that prefers negative dentries when reclaiming.
> > 
> > Two new sysctls under /proc/sys/fs/:
> > 
> >   dentry-limit             -- soft cap on nr_dentry.  0 (default)
> >                               disables the feature; behaviour is then
> >                               identical to before.
> >   dentry-limit-interval-ms -- pacing for the worker while still over
> >                               the cap.  Default 1000, minimum 1.
> > 
> > When the cap is exceeded, a delayed_work runs in two phases:
> > 
> >   1. iterate_supers() draining only negative dentries from every LRU.
> >      Positive entries are rotated past so the walk makes progress.
> >      DCACHE_REFERENCED is ignored here on purpose -- an admin-imposed
> >      cap should evict even hot negatives before any positive entry.
> >   2. If still over the cap, iterate_supers() again with the same
> >      isolate callback the memory-pressure shrinker uses.
> > 
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> > There was a discussion at LSFMM about servers with too many cached
> > negative dentries.
> > That gave me the idea to keep the dentries in general limited
> > if the system administrator needs it to.
> > 
> 
> I wrote about the negative entries problem here:
> 
> https://lore.kernel.org/linux-fsdevel/f7bp3ggliqbb7adyysonxgvo6zn76mo4unroagfcuu3bfghynu@7wkgqkfb5c43/#t
> 
> The mechanism as suggested here will end up evicting *useful* negative
> entries. Granted, they will be recreated soon enough so it's not a
> tragedy but it still is an avoidable perf loss.
> 
> What is needed in the long run is a mechanism which aggressively
> recycles stale negative entries and recognizes which ones should be
> saved for the time being.
> 
> Below some magic threshold you just allocate a new negative entry.
> 
> All new entries would get a grace period where they need to get hits and
> prove useful OR get whacked. If you are at or above the threshold and
> are allocating a new entry, you can whack the oldest negative one which
> did not make it.
> 
> This is just one idea, what is not up for debate is the discrepancy
> between small subset of negative entires with tons of hits vs the ones
> which get virtually no traffic at all.

I'm trying not to focus that much on the negative dentries since it has
no relevance for fuse, but was just a nice effect to solve that one, too,
and a bit of 'when you're at it' logic.
I'm more interested in throwing out the unused ones.

You are completely right in your analysis that this could remove fresh
and useful negative dentries.

> 
> Whatever the mechanism it will have to take advantage of it.
> 
> > This is somewhat related to [1] where it would address the same
> > symptoms but in a more unobtrusive way, by just garbage collecting
> > the negative and then the unused cache entries.
> > 
> > The other effect I have seen regarding this is that FUSE
> > will not forget inodes (no FORGET call to the FUSE server)
> > even after the latest reference has been closed until much later.
> > 
> > In a FUSE server that mirrors the kernel cached inodes in user space
> > because it has to keep a lot of private data for every node
> > this puts an unnecessarry memory strain on that userspace entity
> > especially if the memory is limited for its cgroup.
> 
> I don't know anything about how FUSE works. In this context I presume
> you have a mount point backed by FUSE and the problematic memory usage
> stems from inodes created against such a mount point.
> 

correct

> This would suggest you would be better served with a mechanism which
> allows userspace to cull some number of dentries for a given mount
> point, maybe even with an optional preference for negative entries if
> that's considered better for given fs. 
> 

As I mentioned in the other post, I kinda did this (not triggered by user
space, though, just by a limit negotiated during init with user space) 
just for fuse and was told that this kind of limit would be useful in vfs.

> Or to put it differently, I would look into exposing sb shrinkers to
> root instead of rolling with a global scan.

This would be a cool idea.

> 
> > +static enum lru_status dentry_lru_isolate_negative(struct list_head *item,
> > +		struct list_lru_one *lru, void *arg)
> > +{
> > +	struct list_head *freeable = arg;
> > +	struct dentry *dentry = container_of(item, struct dentry, d_lru);
> > +
> > +	if (!spin_trylock(&dentry->d_lock))
> > +		return LRU_SKIP;
> 
> If anything of the sort is to land, you definitely want to pre-check
> d_count and d_is_negative without the lock.

probably ... 
I still think that a lock held is a good indicator that we can just move on.

Thanks for your time,
Horst
