Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20D390C86
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262872; cv=none; b=q/SGEGRUYPFSt0w8bAtkSNaakoU92YaV7ib/rJ5UI1PTFSDjLIbIbjmcNNGvyc6EyaiQyiK50uPHzOhXuo4gt4QaFY9gVnnIWPNI3cep1UKHt1KbZUjFhb0GGA4qR9Dy5ZClpEUa6S1YrL7zJtR/fNsaN3YUZ5MViVblqDkwwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262872; c=relaxed/simple;
	bh=0nupO1xQw76RBeRg+97+Z3L+9fhCGCUWWGXHQ5csXH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+1BW/B7fzmmKf+eaXL47+wBYCBHjZhS21PwaE3gKir8ynwiE3DZVk7m+b8jdn8LbwtcasecG9vhMLTVu+B0QPQXCySzrcJTkHc6ybAKZbdYhGe0Fq5IkGVxzxDCMwGnCrxVOC6+Ealdq2xWinUJ5yZ9ARqVpsn5AKP4AP91Bo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uh9FrYGB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smn6tA+A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uh9FrYGB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smn6tA+A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uh9FrYGB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smn6tA+A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uh9FrYGB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smn6tA+A"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D58034D2A4;
	Mon, 23 Mar 2026 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774262868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RliYgQJC8jQUhkPteaeL8ZeUHX19DiNVUvaChowf08U=;
	b=uh9FrYGBkxG4m2NSz3fJmo1Oyc+toviFsNlJ5KFZmjTPa6Cw4M7pQ7oDK0q8cZeHwuGFMD
	iLUIqwoo6RhsD/q1jNSM09aLtv+8r7wRsTpUgEVO0h17y4ykFJCEyNaOrj99wjvNCS9V+N
	1Gqe4iQUv45obzUx9DVHZbEEr0VoUFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774262868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RliYgQJC8jQUhkPteaeL8ZeUHX19DiNVUvaChowf08U=;
	b=smn6tA+AL3m340ugt/KV6xLX/8KgpJN8+2karVG1eldOuAF6Gz/4XIJ2A9lOe3+PQQ794j
	+oxrXxhNxqjT3MBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uh9FrYGB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=smn6tA+A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774262868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RliYgQJC8jQUhkPteaeL8ZeUHX19DiNVUvaChowf08U=;
	b=uh9FrYGBkxG4m2NSz3fJmo1Oyc+toviFsNlJ5KFZmjTPa6Cw4M7pQ7oDK0q8cZeHwuGFMD
	iLUIqwoo6RhsD/q1jNSM09aLtv+8r7wRsTpUgEVO0h17y4ykFJCEyNaOrj99wjvNCS9V+N
	1Gqe4iQUv45obzUx9DVHZbEEr0VoUFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774262868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RliYgQJC8jQUhkPteaeL8ZeUHX19DiNVUvaChowf08U=;
	b=smn6tA+AL3m340ugt/KV6xLX/8KgpJN8+2karVG1eldOuAF6Gz/4XIJ2A9lOe3+PQQ794j
	+oxrXxhNxqjT3MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2642A4382D;
	Mon, 23 Mar 2026 10:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q3kPBlQawWk3NQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 23 Mar 2026 10:47:48 +0000
Date: Mon, 23 Mar 2026 10:47:46 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Abhishek Kumar <abhishek_sts8@yahoo.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH] mm: fix data race in __filemap_remove_folio /
 folio_mapping
Message-ID: <zomsk45mkrop54w4iijusollwafixqul6zrgzczghenrpyodgg@bgo77hcidmko>
References: <20260322190319.85301-1-abhishek_sts8.ref@yahoo.com>
 <20260322190319.85301-1-abhishek_sts8@yahoo.com>
 <acC6P6ULWgxKXFiK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acC6P6ULWgxKXFiK@casper.infradead.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[yahoo.com,linux-foundation.org,kvack.org,vger.kernel.org,syzkaller.appspotmail.com,google.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[606f94dfeaaa45124c90];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D58034D2A4

On Mon, Mar 23, 2026 at 03:57:51AM +0000, Matthew Wilcox wrote:
> On Mon, Mar 23, 2026 at 12:33:19AM +0530, Abhishek Kumar wrote:
> > KCSAN reports a data race between page_cache_delete() and
> > folio_mapping():
> > 
> >   page_cache_delete() performs a plain store to folio->mapping:
> >     folio->mapping = NULL;
> > 
> >   folio_mapping() performs a plain load from folio->mapping:
> >     mapping = folio->mapping;
> > 
> > page_cache_delete() is called from the truncation path under the i_pages
> > xarray lock,
> 
> That's not relevant.  The important lock for maintaining folio->mapping
> is the folio lock (see the VM_BUG_ON_FOLIO line in page_cache_delete()).

Not only that, but holding invalidate_lock or i_rwsem can implicitly make
the folios stable by excluding out truncation.

> At a minimum, this changelog needs to be fixed because there's already
> too much confusion around the locking rules.
> 
> > while folio_mapping() is called from the reclaim path
> > (evict_folios -> folio_evictable -> folio_mapping) under only
> > rcu_read_lock() without the xarray lock.
> 
> Umm.  First up, this is MGLRU-only code, right?  Adding the so-called
> maintainers.
> 
> Second ... I'm really unsure how we want to handle this generally.
> This could be quite the game of whack-a-mole; we have many, many places
> in the kernel which dereference folio->mapping without holding a lock.
> 
> Perhaps they are all fine; but 12 of the 455 references to
> folio->mapping currently have READ_ONCE attached.  That's a lot of code
> to audit.

Yes, and a lot of these just aren't trivial to prove 100% correct. e.g:

fs/ext2/dir.c:

static void ext2_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
{               
        struct address_space *mapping = folio->mapping;

Racey?

int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
                struct folio *folio, struct inode *inode, bool update_times)
{
        loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
        unsigned len = ext2_rec_len_from_disk(de->rec_len);
        int err;

        folio_lock(folio); 

Maybe not, but we don't revalidate folio->mapping after the lock. Racey?

Then you look at the ext2_set_link() callers and it is rename, which holds
i_rwsem. This plus the reload in filemap_get_entry() should make it sufficient
(and excludes against reclaim whacking the folio).

But there are other callers of ext2_commit_chunk(), etc, and ext2 is by far
one of the simpler filesystems out there :)

> 
> > The race is benign since the reclaim path tolerates stale values --
> > reading a stale non-NULL mapping simply results in a suboptimal eviction
> > decision.  However, the plain accesses risk store/load tearing and allow
> > the compiler to perform harmful optimizations (merging, elision, or
> > fission of the accesses).
> 
> I think the bigger problem is reloading.  As I understand it, this code:
> 
> 	struct address_space *m = folio->mapping;
> 
> 	if (m && m->flags)
> 
> could end up loading 'm' twice, once before the setting to NULL and once
> after.  That's more plausible than deciding to load byte-by-byte, or
> whatever else these "merging, elision, or fission" words mean.
> 
> > Fix this by using WRITE_ONCE() in page_cache_delete() and READ_ONCE()
> > in folio_mapping() to prevent compiler misbehavior and silence the KCSAN
> > report.
> 
> Just to be clear, I don't object to the patch itself, I'm just scared
> of the consequences.  And the locking comment above needs to be fixed.
> But please wait a few days for discussion to play out.

IMHO this looks fine, particularly as folio_mapping() is practically
mm-internal (but there are some other users in fs/, for some reason).
And shouldn't be problematic as AIUI KCSAN will still report WRITE_ONCE+plain read
or READ_ONCE+plain write races.

-- 
Pedro
