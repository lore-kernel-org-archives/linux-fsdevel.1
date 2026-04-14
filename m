Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993A3BFE41
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158158; cv=none; b=BXTE2drb1ZN3hM9j6HJ7LiTWRn5WPBrt4t3xmB76nEeRb8FqFlfg+vz2XSWh6NN+F5oBDiV4o5eVtxe3jPxEG8J9iuNh1XWSDC87Nb2scpP0U2zQpmQw5IHWJKp7CsL3KLuWmcpO8q8g7h4W4GynjwoCHU+gdj1Tfov7NDAeogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158158; c=relaxed/simple;
	bh=K8P1+KBHc+2Brb7jd9vVx9bEJy3IVdesa93SIenGNC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFcuNopoD8HyppaGmSjEATas3JlFieRETNUKvITEzZqCPVV6tgHzIvOW+SDd0T8GYR2UOvdunKgDK5r+zOFIrzrpN/x89yy+UQnvObcwH9k9ABz1/tROhxOZCpjo3IUYOo6tm0GVNx+Uwodpw9gmVx3Bz4414iO+LSYaya2qL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3AzqO70q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJCXY0I7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3AzqO70q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJCXY0I7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3AzqO70q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJCXY0I7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3AzqO70q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJCXY0I7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98C565BE6A;
	Tue, 14 Apr 2026 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776158152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtgz2wrDJhkuXG38j1ADf8IY18XzGB4DzMJAkz28Fo=;
	b=3AzqO70q24e73+3GcjxpExM+cs8Mnttr50jC6b9PHfCsWbgQHsNxjHmmymnpK+IiZ/Hh+6
	b0fuYYX3zYWUGLb+CZH8IujlysqgvwiJ2hcDCVIl9k566rtCShCsQ+jXTFyofTSzfXHh4B
	IQjIwzl6IRLQrhCrweUE3v7Bk2WQJHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776158152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtgz2wrDJhkuXG38j1ADf8IY18XzGB4DzMJAkz28Fo=;
	b=XJCXY0I7SdP6EMWKNAUdYFDP/2DbqGiGS632GDZHfypQmo2JyrzAe68mUfT7Esh5B6GlZS
	6k+KueWAxC7mIRCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3AzqO70q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XJCXY0I7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776158152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtgz2wrDJhkuXG38j1ADf8IY18XzGB4DzMJAkz28Fo=;
	b=3AzqO70q24e73+3GcjxpExM+cs8Mnttr50jC6b9PHfCsWbgQHsNxjHmmymnpK+IiZ/Hh+6
	b0fuYYX3zYWUGLb+CZH8IujlysqgvwiJ2hcDCVIl9k566rtCShCsQ+jXTFyofTSzfXHh4B
	IQjIwzl6IRLQrhCrweUE3v7Bk2WQJHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776158152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtgz2wrDJhkuXG38j1ADf8IY18XzGB4DzMJAkz28Fo=;
	b=XJCXY0I7SdP6EMWKNAUdYFDP/2DbqGiGS632GDZHfypQmo2JyrzAe68mUfT7Esh5B6GlZS
	6k+KueWAxC7mIRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 817E34B382;
	Tue, 14 Apr 2026 09:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5+TH8gF3mk9QgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Apr 2026 09:15:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A484A0B66; Tue, 14 Apr 2026 11:15:48 +0200 (CEST)
Date: Tue, 14 Apr 2026 11:15:48 +0200
From: Jan Kara <jack@suse.cz>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <z6m4h2yamlckbyzh2ey2ixa7t7s6hlzg5jcle4qyebkopkvujw@pcrzrkuycg4g>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <ad1QfUWEPSCDUDYv@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1QfUWEPSCDUDYv@linux.dev>
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 98C565BE6A
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Hi Shakeel!

On Mon 13-04-26 14:23:13, Shakeel Butt wrote:
> On Thu, Apr 09, 2026 at 11:16:44AM +0200, Jan Kara wrote:
> > Hello!
> > 
> > This is a recurring topic Matthew has been kicking forward for the last
> > year so let me maybe offer a fs-person point of view on the problem and
> > possible solutions. The problem is very simple: When a filesystem (ext4,
> > btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform a
> > complex cleanup - like trimming of preallocated blocks beyond end of file,
> > making sure journalling machinery is done with the inode, etc.. This may
> > require reading metadata into memory which requires memory allocations and
> 
> Some of these allocations may have __GFP_ACCOUNT flag as well, right? Also are
> these just slab allocations or can be page allocations as well? And does the
> caller holds shared locks while performing these allocations?

Yes, some of these allocations may be __GFP_ACCOUNT - e.g. if we end up in
fs/buffer.c: grow_dev_folio() which needs to allocate folio to load
metadata into and allocate buffer_heads underlying that folio.

Regarding shared locks - it is fs dependent. I cannot currently remember
where __GFP_ACCOUNT allocation would be done under some wide-scale lock but
I cannot also completely rule that out. Definitely there are allocations
without __GFP_ACCOUNT under fs-wide locks.

> > as inode eviction cannot fail, these are effectively GFP_NOFAIL
> > allocations (and there are other reasons why it would be very difficult to
> > make some of these required allocations in the filesystems failable).
> > 
> > GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
> > trigger warnings 
> 
> I assume these are the PF_MEMALLOC + GFP_NOFAIL warnings, right?

Yes.

> > - and for a good reason as forward progress isn't
> > guaranteed. Also it leaves a bad taste that we are performing sometimes
> > rather long running operations blocking on IO from reclaim context thus
> > stalling reclaim for substantial amount of time to free 1k worth of slab
> > cache.
> 
> Agreed, particularly in the multi-tenant and overcommitted environments where
> unrelated direct reclaimers have to spend their CPU time to cleaup/freeup
> memory from others.
> 
> BTW I think kswapd doing such hard work is fine.
> 
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
> This async worker is an interesting idea. I have been brain-storming for similar
> problems and I was going towards more kswapds or async/background reclaimers and
> such reclaimers can do more intensive cleanup work. Basically aim to avoid
> direct reclaimers as much as possible.

So similarly as we eventually moved direct page writeback from kswapd
reclaim, I think it makes sense to remove difficult inode reclaim from
kswapd as well. In particular because I think such separation makes it
clearer that while you do complex inode reclaim and allocate memory from
there, there's still kswapd that can free some memory for you to make
forward progress. And you better need to be sure that there's enough "easy
to free" memory to allow for forward progress of difficult reclaim.

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
> > single-threaded).
> 
> Why single-threaded? What will be the issue to have multiple such workers
> doing independent cleanups? Also these workers will need memory
> guarantees as well (something like PF_MEMALLOC) to not cause their
> allocations stuck in reclaim.

Well, single-threaded isn't a requirement but in the beginning I plan to do
it like that for simplicity similarly as currently there's only one flush
work doing writeback (although we are just discussing moving to more for
that). Also the inode cleanup will contend on fs-wide resources such as
journal so although some scaling can bring you benefits it will be
difficult to scale beyond certain limits (again heavily fs dependent).

> > This could be addressed by tracking number of inodes in
> > that list and if it grows over some limit, we could start throttling
> > processes when setting I_RECLAIM_HARD inode flag.
> 
> I assume you are thinking of this specific limit as similar to the dirty
> memory limits we already have, right?

Yes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
