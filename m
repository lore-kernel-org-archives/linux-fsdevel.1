Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA2395257
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334023; cv=none; b=qZfqTwtVOXmDxX7Eu7d+5S+08aAzrX2wWm7eY79/3feqjvBF6ylzG6F1lNiDJklpEHmK9/ZOt7KqPAhJAH6qafpQdEtfTJL/lXgBJry9yAaUbgC0Ug6woDyMzei4L9wdckc5cun+et1+Mxq764lXp6vazSS2hHn6iZMR5mrJzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334023; c=relaxed/simple;
	bh=R4yg9EHcKvSnUURGCoF7eGXhc1dS6xIDUx2x53PkZzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgOwgwFCyBJjYqgYroewNJZt/j+mwcm5YXLd4ofCxQZBXelAfF/7HTMXEtY1T7MrvzN3kNw24gHjfOyIjBQDvV5KuNFbTHW7Om/MtbeZ55nnP+99sqN5yz5x17MZYyvx4JZRgmjwjrdQw1RE8/+mUmfyORtzKsCnuZbPisf7wac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MXpXxFXa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGDlrHWQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MXpXxFXa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGDlrHWQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MXpXxFXa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGDlrHWQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MXpXxFXa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGDlrHWQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60D995BD0D;
	Thu, 16 Apr 2026 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776334020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EcHaRDCO2TcdZgOqKy9Dp05VXuFoot2xbmnN3s5lDQ=;
	b=MXpXxFXat3UOoSmGM/b3+Bgt9jmwiutz/pPbSew2EMc7ms0u/JXL7fKtg5GctcBNoncP60
	enSZz8B/16v3plAqj32IE1LkMgoRF6ZR5CP1yPdAUkGyEzz9BD65NKxMDaR74XGqMWf4XY
	iGVdy4jCZI0UhnHM5Q6acBsRNSA+wac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776334020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EcHaRDCO2TcdZgOqKy9Dp05VXuFoot2xbmnN3s5lDQ=;
	b=qGDlrHWQzMhEwBF6SinNUqWu99CbZzD4HorExPel7Ayutr2kcRZHGkl9Nw+LmKQK4J7Bts
	L93HHcJEZdJ8EkCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MXpXxFXa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qGDlrHWQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776334020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EcHaRDCO2TcdZgOqKy9Dp05VXuFoot2xbmnN3s5lDQ=;
	b=MXpXxFXat3UOoSmGM/b3+Bgt9jmwiutz/pPbSew2EMc7ms0u/JXL7fKtg5GctcBNoncP60
	enSZz8B/16v3plAqj32IE1LkMgoRF6ZR5CP1yPdAUkGyEzz9BD65NKxMDaR74XGqMWf4XY
	iGVdy4jCZI0UhnHM5Q6acBsRNSA+wac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776334020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EcHaRDCO2TcdZgOqKy9Dp05VXuFoot2xbmnN3s5lDQ=;
	b=qGDlrHWQzMhEwBF6SinNUqWu99CbZzD4HorExPel7Ayutr2kcRZHGkl9Nw+LmKQK4J7Bts
	L93HHcJEZdJ8EkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4980F4BEDD;
	Thu, 16 Apr 2026 10:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DbbtEcS04GnvEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Apr 2026 10:07:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04507A0B30; Thu, 16 Apr 2026 12:06:59 +0200 (CEST)
Date: Thu, 16 Apr 2026 12:06:59 +0200
From: Jan Kara <jack@suse.cz>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <i67kqas5wx2a25tzoleygwpeyunx6ovvf3t2e25yab3myxbazh@h7hctwxddhq4>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <ad1QfUWEPSCDUDYv@linux.dev>
 <z6m4h2yamlckbyzh2ey2ixa7t7s6hlzg5jcle4qyebkopkvujw@pcrzrkuycg4g>
 <ad_Eo7iQVT-HUkx1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_Eo7iQVT-HUkx1@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 60D995BD0D

On Wed 15-04-26 10:45:11, Shakeel Butt wrote:
> On Tue, Apr 14, 2026 at 11:15:48AM +0200, Jan Kara wrote:
> > > > I have been mulling over possible solutions since I don't think each
> > > > filesystem should be inventing a complex inode lifetime management scheme
> > > > as XFS has invented to solve these issues. Here's what I think we could do:
> > > > 
> > > > 1) Filesystems will be required to mark inodes that have non-trivial
> > > > cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> > > > whatever :)). Usually I expect this to happen on first inode modification
> > > > or so. This will require some per-fs work but it shouldn't be that
> > > > difficult and filesystems can be adapted one-by-one as they decide to
> > > > address these warnings from reclaim.
> > > > 
> > > > 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> > > > kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> > > > performance reasons. I expect this to be a significant portion of inodes
> > > > on average and in particular for some workloads which scan a lot of inodes
> > > > (find through the whole fs or similar) the efficiency of inode reclaim is
> > > > one of the determining factors for their performance.
> > > > 
> > > > 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> > > > per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
> > > > to process them.
> > > 
> > > This async worker is an interesting idea. I have been brain-storming for similar
> > > problems and I was going towards more kswapds or async/background reclaimers and
> > > such reclaimers can do more intensive cleanup work. Basically aim to avoid
> > > direct reclaimers as much as possible.
> > 
> > So similarly as we eventually moved direct page writeback from kswapd
> > reclaim, I think it makes sense to remove difficult inode reclaim from
> > kswapd as well. In particular because I think such separation makes it
> > clearer that while you do complex inode reclaim and allocate memory from
> > there, there's still kswapd that can free some memory for you to make
> > forward progress. And you better need to be sure that there's enough "easy
> > to free" memory to allow for forward progress of difficult reclaim.
> 
> Another important point that we need memory guarantee for forward progress of
> the difficult reclaim.

Yes, although I don't expect we can get it in a direct way (we have only
very vague idea how much memory is needed for reclaiming such inodes) but
just by making sure the amount of hard to reclaim inodes cannot grow too much.

> > > > 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> > > > inode, doing the hard work.
> > > > 
> > > > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > > > and they can work on freeing memory needed for freeing of hard to reclaim
> > > > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > > > they should really be addressed.
> > > > 
> > > > One possible concern is that s_hard_reclaim_inodes list could grow out of
> > > > control for some workloads (in particular because there could be multiple
> > > > CPUs generating hard to reclaim inodes while the cleanup would be
> > > > single-threaded).
> > > 
> > > Why single-threaded? What will be the issue to have multiple such workers
> > > doing independent cleanups? Also these workers will need memory
> > > guarantees as well (something like PF_MEMALLOC) to not cause their
> > > allocations stuck in reclaim.
> > 
> > Well, single-threaded isn't a requirement but in the beginning I plan to do
> > it like that for simplicity similarly as currently there's only one flush
> > work doing writeback (although we are just discussing moving to more for
> > that). Also the inode cleanup will contend on fs-wide resources such as
> > journal so although some scaling can bring you benefits it will be
> > difficult to scale beyond certain limits (again heavily fs dependent).
> 
> Difficult reclaim uses fs-wide resources (and locks) and thus we can not
> depend on it to be effective under extreme memory pressure, right?

Correct.

> Or do we want it to be reliable under extreme memory pressure where we
> will need to provide memory and cpu guarantees to it?

At least I don't have that expectation :)

> One more question, I assume it is fs-dependent but is it possible to avoid
> allocations (and thus reclaim) under fs-wide locks? One challenge/issue we at
> Meta are seeing is (btrfs) lock holders getting stuck in reclaim causing
> isolation issues.

I don't think it is practically feasible. Often before you acquire locks
and start working, you don't know how much memory you'll need. For simple
operations you can go with worst case estimates and preallocation before
acquiring locks (like we do e.g. with radix tree manipulations) but for
complex mutations of data structures involving journalling etc. it isn't
really practical anymore - too much code to execute, too many possibilities
to consider, too many interactions with other parts of the system.

I understand the priority inversion issues that are arising from this for
memcg reclaim. But I think the "measure now and punish later" model that is
used e.g. for dirty page throttling or blk-iocost throttling of metadata IO
is an approach which has much higher chances of success than trying to move
the allocations out of locks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
