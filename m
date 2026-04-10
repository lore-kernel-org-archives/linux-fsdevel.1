Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082412D7D27
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814863; cv=none; b=n5kLMmuwpy8G+E2VRR2Pv5xkmTo4w5+8xYd7/RgeWlSLOtw/wNrONfqkmH8tfSXzDGFjYUUlU0JkoNDVnP3icZVeIUXhC+1cvnBH3v5F83zudA+ZJFRGGT4vhq9djCP6viPljXmhP+8KZIGKygf/hII3+NgvRdU4o78DxTdJ/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814863; c=relaxed/simple;
	bh=15UQ7aemxIw0SaZ5trW13gXBJWrendK7oNuyol9ukOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdYcDXYccePB+yR8wmEfdYTpkF+ZWpcL5/MSiuRu3+cIMHWBZeKVMZqeGpM19ws1Ytnmy2HPiC2BE1Uen5mZH6G6iRizkMOksONvupqkq2h81882N/aMapbz+OoqkS8zhLaH7i5KX9RsP2SWvQk6tjnD+gD+zcV5XgO5P5xBeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsgz0iiV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nk6WwlQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsgz0iiV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nk6WwlQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsgz0iiV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nk6WwlQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsgz0iiV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nk6WwlQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25CE16A7E6;
	Fri, 10 Apr 2026 09:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775814858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJVJtqdZtgjjDlnux/SZN8q+EWMmf2snhFNTfIvRit0=;
	b=wsgz0iiVTIRu9hvCj+hTeOoO5aWRvJlLqgUYI1GktvxpU8dqjZHQK8G7mK3dT+L7IPs19E
	uh2NL6cRjkXR8kk3zdq22ozAT0FB9XQRD9Uk0iwdsWZ8TH0+4LpnJLfp0ugnK/veGPdF4t
	959iXA2/RZ7OaKeVXw3o+DS5Lb/KtB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775814858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJVJtqdZtgjjDlnux/SZN8q+EWMmf2snhFNTfIvRit0=;
	b=4nk6WwlQVRkFFBCY4spoKL+G4+fqAmXABFGfS+YgSgQN2uodtsQy623QKp8qQMQeF0qa7A
	1BcK7usAWYiDvJAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wsgz0iiV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4nk6WwlQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775814858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJVJtqdZtgjjDlnux/SZN8q+EWMmf2snhFNTfIvRit0=;
	b=wsgz0iiVTIRu9hvCj+hTeOoO5aWRvJlLqgUYI1GktvxpU8dqjZHQK8G7mK3dT+L7IPs19E
	uh2NL6cRjkXR8kk3zdq22ozAT0FB9XQRD9Uk0iwdsWZ8TH0+4LpnJLfp0ugnK/veGPdF4t
	959iXA2/RZ7OaKeVXw3o+DS5Lb/KtB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775814858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJVJtqdZtgjjDlnux/SZN8q+EWMmf2snhFNTfIvRit0=;
	b=4nk6WwlQVRkFFBCY4spoKL+G4+fqAmXABFGfS+YgSgQN2uodtsQy623QKp8qQMQeF0qa7A
	1BcK7usAWYiDvJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C4D74A0B2;
	Fri, 10 Apr 2026 09:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HSDeBsnI2GnSVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 09:54:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA47BA0A81; Fri, 10 Apr 2026 11:54:16 +0200 (CEST)
Date: Fri, 10 Apr 2026 11:54:16 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, Boris Burkov <boris@bur.io>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <cjuhfxstjtxcsygpnrxuyo7el23we6c3eaetaohuq62uat6iwk@yqdxghgf4vpc>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Queue-Id: 25CE16A7E6
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-04-26 14:57:47, Amir Goldstein wrote:
> On Thu, Apr 9, 2026 at 11:17 AM Jan Kara <jack@suse.cz> wrote:
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
> >
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
> >
> > In the session I'd like to discuss if people see some problems with these
> > approaches, what they'd prefer etc.
> 
> Is this expected to be a FS+MM session or only FS+Matthew?

I was thinking of FS+MM but if MM gets too crowded, we could do with MM +
Matthew. I think the problem lies mostly in fs land but it's good to get
some vetting from MM people that we aren't bending slab reclaim assumptions
too much...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
