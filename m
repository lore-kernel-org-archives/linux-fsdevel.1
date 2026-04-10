Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C423890F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816078; cv=none; b=FrB3W2qfrIzgru0hvGfzb81WKUI/1utF2RzW4V79F3996LTjnAT6ORpSuuNIzdpodMAQBta9JFtvweaw3TasHSwGHiz7fuZPMVqerd2j6nRu3MNwrCsBitMawne3ixDzCvo4onPmStj7vEMCeno4NKp7Y9rMlXhg3DutrN4U7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816078; c=relaxed/simple;
	bh=9+W9e3fX4vpfor6d/qnm6lJjVwztxDI24fBqgbz0xBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOnUGsxYRLKmo4y7ElvyXp3x5BWKKBa/kLjiNN4zhH7JQJBporsug8GDZxUmskUxkXkxkRxGlyxYkFKnFOq0SrdxClbGKWid2ZVbn1ySFOhSlKCa7ud7HLqLqnxpp3rQQHjD1AS6xnqRaxKupWZrO0yCgJRwDPCU6vEOLLibf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Whk/T0Jt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3pE0V1G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtfrm//R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2tjeK36; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Whk/T0Jt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3pE0V1G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtfrm//R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2tjeK36"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4E5E6A7ED;
	Fri, 10 Apr 2026 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775816075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB+RnV89/37CNFnIW/6jx4C9HcTENMZLB0o6vivbJHw=;
	b=Whk/T0Jt2kL8zZgd28b5/dawxDtyeXnbtKt4/yU9/6KIxlzSXJMkZ6w/68PyhrrUpLsIwV
	wHEhjMdRgAmU7EHhv14P2taRd9ynHatQkoUp0TlxBli0H7l4CKil3zbN32/UcuUcuq+TZn
	qlGO0UG3qokgjFy7GbZlWbrn1hJ9Tyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775816075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB+RnV89/37CNFnIW/6jx4C9HcTENMZLB0o6vivbJHw=;
	b=d3pE0V1Geu7hKi5JAB081R15zdWg9sR9NP71WaZqPXZ1SOZCU8thSD1aixFqQR/hI4e+o+
	wgg5rZ3VveMs1zCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xtfrm//R";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B2tjeK36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775816074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB+RnV89/37CNFnIW/6jx4C9HcTENMZLB0o6vivbJHw=;
	b=xtfrm//RBCmhKmhb2JcJBTBBFXYMehTnUgRzoARP6NJiYC8AajGsCvh+tUA0yRAfg8HwFy
	aBajCyKACffeA1N6oVhuFqHTMsJWRnWzkwTvAFpVPYu6c+aYiA9uDTf29LwazLHbV3HqHv
	2x3EdvfkcrXw2n+Pi+7SJURkXtN+83Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775816074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB+RnV89/37CNFnIW/6jx4C9HcTENMZLB0o6vivbJHw=;
	b=B2tjeK36uzy73fkyWsRDAew4RvcL1qPmpRF6iSlRw+N0hkPEe7jJD5YbmUhh3J9VEY2zQ6
	wfxfP816p13khQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA4254A0B2;
	Fri, 10 Apr 2026 10:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DJzLYrN2GlcagAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 10:14:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BD09A0A81; Fri, 10 Apr 2026 12:14:30 +0200 (CEST)
Date: Fri, 10 Apr 2026 12:14:30 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <cvoy3vexgyxgyqghchpybluuvi4dvicbyjdodab5afqlmxe2yf@vgpzcmu6upri>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <20260410-anonym-freigaben-186946cb50e3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-anonym-freigaben-186946cb50e3@brauner>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: D4E5E6A7ED
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Hello!

On Fri 10-04-26 11:23:26, Christian Brauner wrote:
> On Thu, Apr 09, 2026 at 11:16:44AM +0200, Jan Kara wrote:
> > This is a recurring topic Matthew has been kicking forward for the last
> > year so let me maybe offer a fs-person point of view on the problem and
> > possible solutions. The problem is very simple: When a filesystem (ext4,
> > btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform a
> > complex cleanup - like trimming of preallocated blocks beyond end of file,
> > making sure journalling machinery is done with the inode, etc.. This may
> > require reading metadata into memory which requires memory allocations and
> > as inode eviction cannot fail, these are effectively GFP_NOFAIL
> > allocations (and there are other reasons why it would be very difficult to
> > make some of these required allocations in the filesystems failable).
> > 
> > GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
> > trigger warnings - and for a good reason as forward progress isn't
> > guaranteed. Also it leaves a bad taste that we are performing sometimes
> > rather long running operations blocking on IO from reclaim context thus
> > stalling reclaim for substantial amount of time to free 1k worth of slab
> > cache.
> > 
> > I have been mulling over possible solutions since I don't think each
> > filesystem should be inventing a complex inode lifetime management scheme
> > as XFS has invented to solve these issues. Here's what I think we could do:
> > 
> > 1) Filesystems will be required to mark inodes that have non-trivial
> > cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> > whatever :)). Usually I expect this to happen on first inode modification
> > or so. This will require some per-fs work but it shouldn't be that
> > difficult and filesystems can be adapted one-by-one as they decide to
> > address these warnings from reclaim.
> > 
> > 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> > kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> > performance reasons. I expect this to be a significant portion of inodes
> > on average and in particular for some workloads which scan a lot of inodes
> > (find through the whole fs or similar) the efficiency of inode reclaim is
> > one of the determining factors for their performance.
> > 
> > 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> > per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
> > to process them.
> 
> I like this approach.
> 
> > 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> > inode, doing the hard work.
> > 
> > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > and they can work on freeing memory needed for freeing of hard to reclaim
> > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > they should really be addressed.
> > 
> > One possible concern is that s_hard_reclaim_inodes list could grow out of
> > control for some workloads (in particular because there could be multiple
> > CPUs generating hard to reclaim inodes while the cleanup would be
> > single-threaded). This could be addressed by tracking number of inodes in
> 
> Hm, I don't know with WQ_UNBOUND is that really a concern?

I planned to have a single work item processing the inodes which means
single CPU cleaning the list even with WQ_UNBOUND. And MM folks tend to be
cautious about these pathological scenarios where all your reclaimable
memory is filled with hard to reclaim objects (dirty pages are prime
example we have solved long ago but dirty / hard to reclaim inodes aren't
really different). I'm definitely open to postponing the throttling part
for later if people are willing to try.

> > that list and if it grows over some limit, we could start throttling
> > processes when setting I_RECLAIM_HARD inode flag.
> > 
> > There's also a simpler approach to this problem but with more radical
> > changes to behavior. For example getting rid of inode LRU completely -
> > inodes without dentries referencing them anymore should be rare and it
> > isn't very useful to cache them. So we can always drop inodes on last
> > iput() (as we currently do for example for unlinked inodes). But I have a
> > nagging feeling that somebody is depending on inode LRU somewhere - I'd
> > like poll the collective knowledge of what could possibly go wrong here :)
> 
> I still think we should try this - for the reduced maintenance cost
> alone. Imagine living in a world where there aren't 2 different LRUs
> constantly battling for review attention..
> 
> I'm split here but depending on the size of the actual work needed to
> make this happen we should at least be open to try this.

I'd love to but as Jeff points out, at least NFS depends on inode LRU today
so we'd have to come up with some way to avoid purging all files from NFS
directory from cache on revalidate events. And I don't see a simple
solution for that...

								Honza
--
Jan Kara <jack@suse.com>
SUSE Labs, CR
