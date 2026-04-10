Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8B347BDB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815245; cv=none; b=AQMMEmdVdhV1YrJBW7fykYyY2GqYs6oU4HOspa3fbulvIM65tnXVrUdSLrfRm9wmS3gehni3QpbB8ysypIf+qQJ41P19SkH1A+1ya2NUmXl9W/Avjh7Z9ju2S0KdMp52w0fq1zR2GPiS2mDN/Y8lxzrdaacO5Mi5O7fvg4Lj118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815245; c=relaxed/simple;
	bh=mW8qLM9tI6iFufS7GkU2xhT7QOu/5773sxA8jLFKRBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A76UJpZd0Mn9b5U2yP6DftCHILazL+U8kWEYe2N4BbnRGzqw1lX16VUF14iWC/28/tmkX13XP9+PdSbKlyVRULxo5YEkVL3I7AY0ehytqAUSIhaXQP7oV1X0TkO3t2iY0TBX+dWvPYwwSbl8c1QeyrmzHCHbfrZAzadT8TtvWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YByLtiwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXhnDdlj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGqRXNQE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9uWVvbp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YByLtiwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXhnDdlj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGqRXNQE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9uWVvbp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12B046A7EA;
	Fri, 10 Apr 2026 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775815242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkfVDK9m2+79hoSwUpq2JOOIVAKK+qSsxl7RUf+4B3A=;
	b=YByLtiweH28ueinQh4cOraL1Tga5KFCAlFD5jqBnR3noOVyYgzvBvAj38lSQx9dpR5eSHZ
	HjqyvC5maBcHMVwWxrHo44no5mw73Ri00g7MiAWwtsyg6S5G/ZWtTGwr5c+kpT+NLeH0m/
	s7d3ZMoZjOFN6/jfmy71t8RwGBzoIfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775815242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkfVDK9m2+79hoSwUpq2JOOIVAKK+qSsxl7RUf+4B3A=;
	b=EXhnDdljyxynm7L8VIMO/zaek/RsmlohwURNe50heC8RI18nrkG3rL1UeAcIZ5mNf+EDJA
	+FrZewPx/VuCXkAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QGqRXNQE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K9uWVvbp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775815241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkfVDK9m2+79hoSwUpq2JOOIVAKK+qSsxl7RUf+4B3A=;
	b=QGqRXNQEqeQK54c+iWpzvuaPLbHea83I7jsnR2wyD7x3iyOEc8kS++hzUVTCXMGlMEdKMx
	WjQwFyc/CsLkiO6Om80jbut5dP38y+UHyWMhu50/1l/IhqAHvVEb9O5i8Ndln1oq41AQBt
	+14urth4otxagawg8WGYotjtzqjeh8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775815241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkfVDK9m2+79hoSwUpq2JOOIVAKK+qSsxl7RUf+4B3A=;
	b=K9uWVvbpHyrDD48RRwxvErv6aucdFyrETF3aNk/Je3GKGFCzAWBubta5L49rJlgVOLdU1V
	hDT+/sl2AAHtpvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 087DE4A0B2;
	Fri, 10 Apr 2026 10:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sywSAknK2GmMXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 10:00:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA687A0A81; Fri, 10 Apr 2026 12:00:40 +0200 (CEST)
Date: Fri, 10 Apr 2026 12:00:40 +0200
From: Jan Kara <jack@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <ialh7bznacamw6ogfwniawtz577t3xo2mqgcjaweashqhs3ijf@jebgxzy42zqd>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
 <20260409164834.GA3472346@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409164834.GA3472346@zen.localdomain>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,kvack.org,infradead.org,lists.linux-foundation.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 12B046A7EA

On Thu 09-04-26 09:48:34, Boris Burkov wrote:
> On Thu, Apr 09, 2026 at 02:57:47PM +0200, Amir Goldstein wrote:
> > On Thu, Apr 9, 2026 at 11:17 AM Jan Kara <jack@suse.cz> wrote:
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
> 
> One question that pops in my mind (which is similar to an issue you and
> Qu debugged with the btrfs metadata reclaim floor earlier this year) is:
> what if the hard to reclaim inodes are the *only* source of significant 
> reclaimable space?

Then we are effectively deadlocked on ENOMEM. That's why I think we'll have
to put some throttling on the creation of hard to reclaim inodes so that
they cannot grow out of control.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
