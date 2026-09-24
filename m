Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1744E655;
	Thu, 24 Sep 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243599; cv=none; b=RymmTjh0c5xbCxK2R7RAVBnKDg+6ZtQBNYJmslblS02W83AptzvJUavh9BIY6GLC8PNZSJRyiUnWGjru4SUzzBY5BOaGlqgyD4irPaxUhIkPejmpSYUnHJM//m0eE8tQotltWOcGhF+E/OTEG2c6YfDtZjm8F1hwznR4G1bAWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243599; c=relaxed/simple;
	bh=sPvIqqiWtLmfc6ErKi9GH1J5tWYpjjEbXoftcYlUFoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4UKH8X9T6p08WK4wtxlUmiRWiChWojNOpFJFK/A75653GyF23j9uFKZ6kq7rZcpeFHDefvqwpnmj5i3uhV/bFYXBlrEC0DHclJ7civESChiQ9cmDw+efDujz371LAgkBoRpv8ZRg6JZ/VD+OZu7Y0KYvg4JhS11pfTnbPsK2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OmCGSrzT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJIUnDFG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfFtejpv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yRELnrdM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OmCGSrzT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJIUnDFG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfFtejpv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yRELnrdM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B77220085;
	Thu, 24 Sep 2026 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790243576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW/01UYA2/+neWjdTd89el29ZEI2I1pCyls3/+dcHWM=;
	b=OmCGSrzTOUTEICkTDiNwNf90fi0Zsp+KkVcf5hDXZGK+QFpEh4C+1cnhxxnIZObLUolhxY
	NwabShn19MpXPvx8T+oKzkdbzmO3/GKKbrQOHTlDaPk1ebgpAb777XpR4SmmoRnJndV+sq
	dJbZ6mdBG2gAXG0vlut3l7jUt51Q6gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790243576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW/01UYA2/+neWjdTd89el29ZEI2I1pCyls3/+dcHWM=;
	b=PJIUnDFGVo/PSy8sI1kbO1Mxdd+m61pWTAqWBnH+iMdyM3ROLh214EI4nGKFVlq93vXIP3
	zGilbwKIsPFk0AAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790243572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW/01UYA2/+neWjdTd89el29ZEI2I1pCyls3/+dcHWM=;
	b=VfFtejpvt4v2Sl8T+qmDufsfXJwvoNy2F6Szv6oi1Boh8F0LvBEKkm5n0JQzvvtNlj7aEi
	mOc7v4ix89eHa41m6H9p1wgOlsndmqDxYWkKC9oRAoyosJnfdzqbZnlaDPOwanyEkG16Zd
	C7mrUE80E3Wo5Sa9Jua7e5HrAu1cJUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790243572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW/01UYA2/+neWjdTd89el29ZEI2I1pCyls3/+dcHWM=;
	b=yRELnrdM7ZHNqYGqvsJJo2Q2PSQfHZD9IqzOJde1urQ0qkcCJqUDg5rRcSv+I45A5tsKuG
	gp8i+f8Fdu9gBJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF59A13668;
	Thu, 24 Sep 2026 09:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DkwiLvPytGrAOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 09:52:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68B36A132E; Thu, 24 Sep 2026 11:52:51 +0200 (CEST)
Date: Thu, 24 Sep 2026 11:52:51 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/gfs2: prevent premature evict in prune_icache_sb
Message-ID: <v6c2tacifzt7e46fmlathfn5lgf54ae2qliq33ydhqkeudqnxc@r7dsaeww4yav>
References: <20260921211712.1563575-1-agruenba@redhat.com>
 <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
 <CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO

On Wed 23-09-26 23:01:52, Andreas Gruenbacher wrote:
> On Tue, Sep 22, 2026 at 1:22 PM Jan Kara <jack@suse.cz> wrote:
> > Hello Andreas!
> >
> > On Mon 21-09-26 23:17:11, Andreas Gruenbacher wrote:
> > > Introduce a new I_NOPRUNE i_state flag for preventing prune_icache_sb()
> > > from pruning specific inodes.
> > >
> > > prune_icache_sb() prunes clean inodes under memory pressure ("direct
> > > reclaim").  An inode is considered clean when none of the i_state flags
> > > are set; the assumption is that evicting inodes that don't have any
> > > i_state flags set will be fairly cheap.
> > >
> > > Unfortunately, on gfs2, inodes can be clean in the sense that they won't
> > > require writing back to disk, but they may still have outstanding
> > > revokes (as indicated by the GLF_LFLUSH inode glock flag).  To evict one
> > > of those inodes, those outstanding revokes need to be written out first.
> > >
> > > This requires flushing the log, which is already an expensive operation.
> > > When in data=ordered mode, all the ordered data needs to be written out
> > > before the log can be flushed, which makes things even worse.
> > >
> > > As previously discussed [*], we are currently also running into the
> > > following warning in iomap_writepages() when flushing ordered data:
> > >
> > >     /*
> > >      * Writeback from reclaim context should never happen except in the case
> > >      * of a VM regression so warn about it and refuse to write the data.
> > >      */
> > >     if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) ==
> > >                     PF_MEMALLOC))
> > >             return -EIO;
> > >
> > > So we need to prevent prune_icache_sb() from evicting inodes that have
> > > any outstanding revokes.  This patch achieves that by introducing a new
> > > I_NOPRUNE i_state flag.  When that new flag (or any other flag) is set,
> > > prune_icache_sb() will skip those inodes.
> > >
> > > In the filesystem code, we set and clear the I_NOPRUNE flag in sync with
> > > the GLF_LFLUSH inode glock flag.
> > >
> > > An alternative approach might be to allow filesystems to refuse evicting
> > > inodes that prune_icache_sb() has already selected.  This could be
> > > achieved by changing the ->evict_inode super operation to return a
> > > lru_status code or similar.  prune_icache_sb() would then have to
> > > resurrect inodes that were already marked I_FREEING and put them back
> > > onto the lru list.  This approach doesn't seem obviously better than
> > > introducing I_NOPRUNE, so I haven't pursued this any further.
> >
> > So for situations like this I've written a patch set to allow filesystem
> > to mark inode for deferred reclaim (from a workqueue) [1]. Would that work
> > for you? It will definitely solve your problems with warnings in memory
> > allocator.
> >
> > I don't want to have two different mechanisms for the same issue so if my
> > solution doesn't quite work for you, let's discuss how to make it better
> > :).
> 
> thanks, this would solve some of my problems. In the gfs2 case, inodes
> are only in "deferred reclaim" state for a while (while they have
> outstanding revokes) before becoming directly reclaimable again. So
> I'd also need a way to clear the I_DEFER_RECLAIM flag again.

Well, that's kind of the case for other filesystems as well. But since
deferred reclaim is relatively cheap my current thinking was that if
somebody did something expensive to the inode like allocating blocks
(that's what triggers this for ext4, not sure what exactly triggers the
state for GFS2), then we can afford also the additional small cost of
offloading the reclaim to a workqueue (regardless whether it is really
needed at the time reclaim actually happens). We just don't want to
unconditionally offload because if someone is just statting millions of
inodes on some filesystem, he's basically bound by the speed of reclaim on
sufficiently fast storage and the additional delay of reclaim and the cost
of offloading would become visible.

> The I_DEFER_RECLAIM flag setting and clearing code would be racy and
> ugly though, so I'm wondering if we can change the ->evict_inode()
> super operation to return a DIRECT / DEFERRED status code instead. The
> filesystem could then look at the filesystem-internal state and return
> how to proceed with the inode. For example, fs2_evict_inode() would
> probably request a DEFERED evict when GLF_LFLUSH is set, PF_MEMALLOC
> is set, and PF_KSWAPD is not set.

Right, but I really want filesystems to mess with process reclaim flags as
little as possible because that smells with layering violation and
generally tends to be fragile. In some code paths such as iput_final()
or evict_inodes() I really prefer to be sure that the filesystem just frees
the inode without having to check details of all the implementations making
sure they don't do something stupid and offload when they shouldn't.

So if we do something like this, I'd probably prefer explicit flag to
->evict() telling that offloading is possible and in that case filesystem
can return special value meaning it requests offloading and prune_icache()
would handle that.

Another problem I see with this scheme is that VFS is completely oblivious
to the number of inodes for which reclaim will be deferred and so there's
no chance for throttling places that create such inodes when the reclaim is
getting overloaded.

So overall I'd prefer we avoid all this complexity at least until we have a
real-world case where the performance impact of unnecessary offloading is
visible.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
