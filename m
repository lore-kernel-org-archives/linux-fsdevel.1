Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A83E3D96
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845360; cv=none; b=Mq/Do0GU2YC/znsFTjoLgKm+eDUX1uLTkw8/44EZMpcnW7MJQ8xnKo/2Y2+CgIzWEo2eNsmjqhO7R9gWlW9sx50DrA+ym78HMPbe2Blne06w0mWd8nO+PWDljRMM5QYSu9qh82JooPFj5j53x/Hppi0JgznuwKfq2tZrHdvWQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845360; c=relaxed/simple;
	bh=GZ6A4VMvj4irOyQ3zgofeSdKf4v6bwXkVVxRE4M+qqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxE8cToz4NTWQ4fXS4u9H62Kv+3hku0n6J3Zw992vrj8cFgRTiPPIplqT7wfHQIdIG9YQ2d+MxMRmyVrPNiaY4x9lDw58ssYp0gIdnr0OZ9y8E4nvH0ZFVw+IT2Z6hAkbwNIXzhdSCLAgwzBUJMz0qTtezgyQECu+6oTW6asfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u18grtz3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sGHaEjKp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z3C3/oGO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jiGaKDSG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u18grtz3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sGHaEjKp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z3C3/oGO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jiGaKDSG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F2D875A5E;
	Tue, 30 Jun 2026 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782845353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsCa3RNAA7O69TzyzAjIqux3S4SG5DUxACORIUg1Tps=;
	b=u18grtz3pS8lgC+oV44hYee4ph60d0uHjj8YpHsmry6VgI+x0kq3T2fuZP4bRfE/9+moId
	2yM3tRbHCeY7S+yOh/QFqU9frwiaBCAF+BbHZa+Mjm60/DumVICsGH1Snt9dmT4Yrjpxpa
	dgGbVerXbZtEde9ERY+7qThv2CQ/SaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782845353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsCa3RNAA7O69TzyzAjIqux3S4SG5DUxACORIUg1Tps=;
	b=sGHaEjKpAswitz0sN6p0SX8lABGDefKe7XkhW/8GofXp5HC/6bH8ou82rY8xbs9HQ/80BN
	cuiy28kOX0wwQHCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Z3C3/oGO";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jiGaKDSG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782845352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsCa3RNAA7O69TzyzAjIqux3S4SG5DUxACORIUg1Tps=;
	b=Z3C3/oGOkFrXPDFhBeNvjU+XahGABVHmMwB7O6+3VdWpwdTFJeFGNXGdpYQ2MS/8AiRmEu
	q9tQXxvhaPkRuTDqdeHQwq/5clXIrXNpVZksVsBbRawBZQeCd3/wZoF0cfH4GdyJkORW9v
	hJAbqXL/Vy7rQF7gBOdlo0jAXlFYbm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782845352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsCa3RNAA7O69TzyzAjIqux3S4SG5DUxACORIUg1Tps=;
	b=jiGaKDSGbHvY3ULrhwKR6U6k8KcrcXtV8IB5jf6I5QCDp273jpCjKtdEk6ZkHROCGRxe8z
	D+KaRiZZ7jMC1VBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A418C779A8;
	Tue, 30 Jun 2026 18:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 598rJKcPRGpBAwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 30 Jun 2026 18:49:11 +0000
Date: Tue, 30 Jun 2026 19:49:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Hagberg <ehagberg@janestreet.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akQO8JtTxmp89GS8@pedro-suse.lan>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQIIav_zaK6RmIC@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akQIIav_zaK6RmIC@pedro-suse.lan>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,janestreet.com:email,pedro-suse.lan:mid];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[janestreet.com:email,pedro-suse.lan:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9F2D875A5E
X-Spam-Score: -4.51

On Tue, Jun 30, 2026 at 07:31:07PM +0100, Pedro Falcato wrote:
> +CC some relevant THP folks
> Quick note, your email client's spacing seems to be all over the place, making
> this extremely hard to read.
> 
> On Tue, Jun 30, 2026 at 01:01:53PM -0400, Gregg Leventhal wrote:
> > Hello,
> > 
> > We (Gregg Leventhal <gleventhal@janestreet.com> and Eric Hagberg
> > 
> > <ehagberg@janestreet.com>) have a reproducible data-loss issue involving file
> > 
> > THPs and write-open, impacting filesystems that do not support
> > writable large folios.
> > 
> > 
> > Attached are:
> > 
> > 
> >   - thp_write_open_cancel_dirty_repro.c
> > 
> >   - thp-open-writeback-before-purge.patch
> > 
> > 
> > 
> > Summary
> > 
> > =======
> > 
> > 
> > On an affected 6.12 kernel with CONFIG_READ_ONLY_THP_FOR_FS=y, a file can
> > 
> > contain read-only file THPs installed by khugepaged / MADV_COLLAPSE. When that
> > 
> > same file is later opened for write, do_dentry_open() notices
> > 
> > filemap_nr_thps() and drops the page cache:
> > 
> > 
> >         /*
> > 
> >          * XXX: Huge page cache doesn't support writing yet. Drop all page
> > 
> >          * cache for this file before processing writes.
> > 
> >          */
> > 
> >         if (f->f_mode & FMODE_WRITE) {
> > 
> >                 if (filemap_nr_thps(inode->i_mapping)) {
> > 
> >                         struct address_space *mapping = inode->i_mapping;
> > 
> > 
> >                         filemap_invalidate_lock(inode->i_mapping);
> > 
> >                         unmap_mapping_range(mapping, 0, 0, 0);
> > 
> >                         truncate_inode_pages(mapping, 0);
> > 
> >                         filemap_invalidate_unlock(inode->i_mapping);
> > 
> >                 }
> > 
> >         }
> 
> Ugh, this is embarassing. So, good news: this code doesn't exist anymore
> in mainline! Bad news: it exists on every other upstream-stable-maintained
> release :|
> 
> FWIW I don't think your fix works, there's still a race there (what if
> you write and wait, then someone dirties a folio, then you truncate the
> pagecache? you lost data again.). I'm attaching a very quick WIP patch
> that I wrote against 6.12 LTS (again, this does not exist in mainline).
> I _think_ we want to go roughly in that direction, either here or in
> collapse file paths. There are still problems which are invasive and
> I haven't dealt with (GUP and other "temporary" folio releases being
> the main one). Some of these problems may simply make it so opening
> these files writable may fail (there is certainly, AFAIK, no way of
> waiting for GUP and other temporary folio holders).
> 
> We would probably be served with a custom loop that forcibly yanks
> only THPs out the pagecache, though. But that requires a bit more
> code for a stable-only issue...
> 
> Anyway, the patch is obviously ungood and uncromulent and is only
> here for a rough conversation starter. I don't think it works and
> it will probably never work. mapping invalidation is simply too
> best-effort for something that Just Needs(tm) to work.

Other idea: perhaps doing filemap_write_and_wait() after the nr_thps
increment in collapse_file() will Just Work and result in a _much_
simpler fix. And it avoids any weird forward-progress issues as no one can
write to folios at that point.

-- 
Pedro
