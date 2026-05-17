Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CE2206A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979586; cv=none; b=DRJ3TQ0MFjY55G+sL09sn0GVKUpu8zMhFeO0WnfVROP/7ZOh0fY29lz9Erw35WEPbQG0pJHHz/vMVYNYPXtB9Xh2oW6uBggo7BHJQ3+Y6o+nMKPDnTKiE7nzTPWNZPpoo0VLwLci6F11lclGrD2oqk3ceke52K562R6I5mr8xxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979586; c=relaxed/simple;
	bh=D8/NjgtB5nAIqaf/au3FDHe/SYohBbS6eQF5gflFPfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkkVQZVNc/P9jsYY6DhT83xzrzmH4y2vMuaa9OA7IynyF+Ew5uz24G5OgX/gD045l+DcuWIqDRBwxWp2SoregA1c/o4n25Vf5NcjTsSeJXTZ0ykOMuzq1l1MqqVMlEt3FCICn8yzYPmtbMSJk4OqhvXp3w7vYre2vCbkIXVJPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H/qUIemu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H5ffgJTN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H/qUIemu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H5ffgJTN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H/qUIemu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H5ffgJTN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H/qUIemu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H5ffgJTN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F2A15C99A;
	Sun, 17 May 2026 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778979583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h86kkWgyYcudDsr22xFMuZPneeAXkcdGpM6QgUrvRVY=;
	b=H/qUIemucRVXOQUZonXUxnpIUeDwB0G7IpMCUx0pwEMlHAfRRnJTX8KNYz23+ZWEYeadzv
	DHE9xElP2w1BhnSP1gWqZ/xO+lKekdpbHVmm3MC3w3Y9iKX5Cv3QFnQxsaQmRIkCyqgUU/
	1FOb14pNe7+5S06oU1HGJ+GGKjLVqsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778979583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h86kkWgyYcudDsr22xFMuZPneeAXkcdGpM6QgUrvRVY=;
	b=H5ffgJTNzXdrdrNLOIGsRQCTSW0oQ/oqcqe7e1V3PRp/vcgG46qrn2pQMoM7kBrsyRbouZ
	z2YNKmoIH1FPwwCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778979583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h86kkWgyYcudDsr22xFMuZPneeAXkcdGpM6QgUrvRVY=;
	b=H/qUIemucRVXOQUZonXUxnpIUeDwB0G7IpMCUx0pwEMlHAfRRnJTX8KNYz23+ZWEYeadzv
	DHE9xElP2w1BhnSP1gWqZ/xO+lKekdpbHVmm3MC3w3Y9iKX5Cv3QFnQxsaQmRIkCyqgUU/
	1FOb14pNe7+5S06oU1HGJ+GGKjLVqsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778979583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h86kkWgyYcudDsr22xFMuZPneeAXkcdGpM6QgUrvRVY=;
	b=H5ffgJTNzXdrdrNLOIGsRQCTSW0oQ/oqcqe7e1V3PRp/vcgG46qrn2pQMoM7kBrsyRbouZ
	z2YNKmoIH1FPwwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3DC8593A8;
	Sun, 17 May 2026 00:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oO0JNP4SCWqAVwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sun, 17 May 2026 00:59:42 +0000
Date: Sun, 17 May 2026 01:59:41 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agkRpj4oU8TPgmTS@pedro-suse.lan>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <agj4mXKRVW44ZJ18@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agj4mXKRVW44ZJ18@casper.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,kvack.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Sun, May 17, 2026 at 12:07:05AM +0100, Matthew Wilcox wrote:
> On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > +static bool may_write_to_page(struct page *page, struct address_space **plast)
> > +{
> > +	struct folio *folio = page_folio(page);
> > +	struct address_space *mapping, *last = *plast;
> > +	struct inode *inode;
> > +	bool may = false;
> > +
> > +	if (!READ_ONCE(sysctl_splice_needs_write))
> > +		return true;
> > +	/*
> > +	 * Always fine to write to anon folios.
> > +	 */
> > +	if (folio_test_anon(folio))
> > +		return true;
> 
> What about KSM?  It's not something we've seen attacked yet, but it'd be
> pretty nasty to be able to change a KSM page in another process.

It's my understanding that only anon pages can be KSM'd, and KSM still keeps
the FOLIO_MAPPING_ANON bit set. So folio_test_anon() should still test true
for those.

> 
> I just got off a flight, so hopefully I'm semicoherent.
> 
> > +	mapping = READ_ONCE(folio->mapping);
> > +	WARN_ON((unsigned long) mapping & FOLIO_MAPPING_FLAGS);
> > +
> > +	/* If it is the same (locklessly), then LGTM, proceed. */
> > +	if (mapping == last)
> > +		return true;
> > +	/*
> > +	 * Else we have to recheck with the folio lock held, for mapping
> > +	 * stability. TODO: killable?
> 
> I wouldn't've thought that'd be necessary.  The folio can't be being
> read because it's mapped, and we won't map a folio until it's uptodate.

Makes sense, I'll avoid the trouble then.

> 
> > +	 */
> > +	folio_lock(folio);
> > +	mapping = folio_mapping(folio);
> 
> I think you're safe to just look at folio->mapping here.  You have a
> refcount on the folio so it can't be freed, and I'm not sure there's a
> way to transition from page cache folio to anon folio without taking a
> trip through the page allocator.

Yep, makes sense. I don't think there is either. The worst that can happen is
that the folio could be truncated out while we have a reference but not the lock.
I think I just used the helper for the sake of using the helper, so I'll replace
it with ->mapping.

> 
> > +	/* May have been truncated, etc */
> > +	if (!mapping)
> > +		goto out_lock;
> 
> typically we call this "out_unlock".

ACK

> 
> > +	inode = mapping->host;
> > +	may = inode_owner_or_capable(&nop_mnt_idmap, inode) ||
> > +	      inode_permission(&nop_mnt_idmap, inode, MAY_WRITE) == 0;
> > +	if (likely(may))
> > +		*plast = mapping;
> > +out_lock:
> > +	folio_unlock(folio);
> > +	return may;
> > +}
> 
> I don't have a problem with the idea, other than it's really sad we have
> to do this.

Indeed :/

-- 
Pedro
