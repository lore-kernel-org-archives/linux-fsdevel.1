Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5233E377
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814229; cv=none; b=iASGBNP9Y8bZYIy8GXredO3mjknECUEt2mZuZaZ2ERJ5bwvxt/Kc0CkqDK/mxT1pc9m3AdqsIaR6VZnEbruwXg7/8Lbu+Gu2nCXI1ncDE6jNkRzwxrt++xk5kJFD8+ZSunv0gV6jPzxrBstvikBx/eFRlb+OI/7q8TV2JuyhrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814229; c=relaxed/simple;
	bh=cJjZMoYTGr6xRlLbkPSubCyzXYZW9Ra0I1ischpiLsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cymcvjdTUaoPe7MojwXCm4dBO6fclJ5isFyG3vSlEIR/WvCFDG1APucFeeY1neh3kIin9Xg4JVTUhl74qC1Ow0lo4DrwqLZH5LvDEUjBpxTYZRV3tClaCGu1ChZHH7GCQL20ANoaeQF6h1k/35fgO8Knk25HiwDrEdvEUBndZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtNaBOLy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n7kK1FXc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtNaBOLy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n7kK1FXc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtNaBOLy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n7kK1FXc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtNaBOLy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n7kK1FXc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 474625BCF0;
	Fri, 10 Apr 2026 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775814220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQWqa1s/8lhEUAwETf6ZaQiJm59dpP90K55kIlu9W1o=;
	b=xtNaBOLyPvEKzmF0bWvTTiidvQRvBU6e0DOguykkx1cJBs3H3A/B0mQIGtCOtYdtLcjMvO
	OUSmaZrMO4t5APA3crw7P63vfl1fGBEN6Ux6vjzqBLKc+Ya5R6ToiGtslKUbFsLJ+jVbDs
	jbjPXqAsmfO94d/1CluSnpnp1UYjGO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775814220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQWqa1s/8lhEUAwETf6ZaQiJm59dpP90K55kIlu9W1o=;
	b=n7kK1FXcQuF8d6r+mgyBcPCAmS4ZjvheU0tdpA+tmGtfnIze7sE52xkTufir8acvqUauLO
	W9HDeTwCbAdXcPBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xtNaBOLy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n7kK1FXc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775814220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQWqa1s/8lhEUAwETf6ZaQiJm59dpP90K55kIlu9W1o=;
	b=xtNaBOLyPvEKzmF0bWvTTiidvQRvBU6e0DOguykkx1cJBs3H3A/B0mQIGtCOtYdtLcjMvO
	OUSmaZrMO4t5APA3crw7P63vfl1fGBEN6Ux6vjzqBLKc+Ya5R6ToiGtslKUbFsLJ+jVbDs
	jbjPXqAsmfO94d/1CluSnpnp1UYjGO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775814220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQWqa1s/8lhEUAwETf6ZaQiJm59dpP90K55kIlu9W1o=;
	b=n7kK1FXcQuF8d6r+mgyBcPCAmS4ZjvheU0tdpA+tmGtfnIze7sE52xkTufir8acvqUauLO
	W9HDeTwCbAdXcPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B35DF4A0B2;
	Fri, 10 Apr 2026 09:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QfDDK0vG2GmgSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 09:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 064DCA0A81; Fri, 10 Apr 2026 11:43:34 +0200 (CEST)
Date: Fri, 10 Apr 2026 11:43:33 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <vpgymg4vq7fv2iebfjebxbufjvo2yre64lcwjgsbyivu2pxmpp@zhjplhrjayc5>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <20260409161258.GU6202@frogsfrogsfrogs>
 <c18f8189b755c13064f51d93bfcaddb15300f9f8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18f8189b755c13064f51d93bfcaddb15300f9f8.camel@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 474625BCF0
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-04-26 13:37:17, Jeff Layton wrote:
> On Thu, 2026-04-09 at 09:12 -0700, Darrick J. Wong wrote:
> > On Thu, Apr 09, 2026 at 11:16:44AM +0200, Jan Kara wrote:
> > > Hello!
> > > 
> > > This is a recurring topic Matthew has been kicking forward for the last
> > > year so let me maybe offer a fs-person point of view on the problem and
> > > possible solutions. The problem is very simple: When a filesystem (ext4,
> > > btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform a
> > > complex cleanup - like trimming of preallocated blocks beyond end of file,
> > > making sure journalling machinery is done with the inode, etc.. This may
> > > require reading metadata into memory which requires memory allocations and
> > > as inode eviction cannot fail, these are effectively GFP_NOFAIL
> > > allocations (and there are other reasons why it would be very difficult to
> > > make some of these required allocations in the filesystems failable).
> > > 
> > > GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
> > > trigger warnings - and for a good reason as forward progress isn't
> > > guaranteed. Also it leaves a bad taste that we are performing sometimes
> > > rather long running operations blocking on IO from reclaim context thus
> > > stalling reclaim for substantial amount of time to free 1k worth of slab
> > > cache.
> > > 
> > > I have been mulling over possible solutions since I don't think each
> > > filesystem should be inventing a complex inode lifetime management scheme
> > > as XFS has invented to solve these issues. Here's what I think we could do:
> > > 
> > > 1) Filesystems will be required to mark inodes that have non-trivial
> > > cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> > > whatever :)). Usually I expect this to happen on first inode modification
> > > or so. This will require some per-fs work but it shouldn't be that
> > > difficult and filesystems can be adapted one-by-one as they decide to
> > > address these warnings from reclaim.
> > > 
> > > 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> > > kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> > > performance reasons. I expect this to be a significant portion of inodes
> > > on average and in particular for some workloads which scan a lot of inodes
> > > (find through the whole fs or similar) the efficiency of inode reclaim is
> > > one of the determining factors for their performance.
> > > 
> > > 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> > > per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
> > > to process them.
> > > 
> > > 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> > > inode, doing the hard work.
> > > 
> > > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > > and they can work on freeing memory needed for freeing of hard to reclaim
> > > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > > they should really be addressed.
> > 
> > This more or less sounds fine to me.
> > 
> > > One possible concern is that s_hard_reclaim_inodes list could grow out of
> > > control for some workloads (in particular because there could be multiple
> > > CPUs generating hard to reclaim inodes while the cleanup would be
> > > single-threaded). This could be addressed by tracking number of inodes in
> > > that list and if it grows over some limit, we could start throttling
> > > processes when setting I_RECLAIM_HARD inode flag.
> > 
> > <nod> XFS does that, see xfs_inodegc_want_flush_work in
> > xfs_inodegc_queue.
> > 
> > > There's also a simpler approach to this problem but with more radical
> > > changes to behavior. For example getting rid of inode LRU completely -
> > > inodes without dentries referencing them anymore should be rare and it
> > > isn't very useful to cache them. So we can always drop inodes on last
> > > iput() (as we currently do for example for unlinked inodes). But I have a
> > > nagging feeling that somebody is depending on inode LRU somewhere - I'd
> > > like poll the collective knowledge of what could possibly go wrong here :)
> > 
> > NFS, possibly? ;)
> > 
> 
> NFS indeed.
> 
> Bear in mind that the NFS may fail d_revalidate checks on child
> dentries when a parent directory is changed on the server. I imagine
> some workloads might see a performance hit if a large file's dentry has
> to be discarded and looked back up because we suddenly threw away a
> bunch of useful data in the pagecache.

Thanks for filling in details! I was having vague memories that NFS was
relying on inodes with 0 refcount not getting immediately evicted. I'll
keep that in mind when thinking about solutions.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
