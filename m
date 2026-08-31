Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD641A50B
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182523; cv=none; b=j2t0mH4N8DaSJTr4OV11lg2pHlc7WbT4d03EUCvfa0pvlgsruXpDxE0vImXJXkwAdenW4TZXj/sYKL6gA786DtLB8LoC3X7HJsAByfeeP8BFRi2H5fC2mukXfnZA+Aal8WkMYojI5pAwq2/G8dg3yN+Hxp0jOo+nnkWlzsCL8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182523; c=relaxed/simple;
	bh=b+6A06xIxiI9P6WZmWzQOSwRybyMtIOtIN0VfGbfMTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9kx53T3qlGzIXMTDvm4dx0zklMOw2cQFywoYWEHaDR3BMpLVYM6rJ96mgXVFIa3eQ3gryvzclGYrQkg2kohZ9L25X3SGtD3fg3NB3kG/YTcS98yojMVYMYqPIxtRRzv493QlJjvJ4D6CQ6zI5N63YFFfielgeDheFIhINVOM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jDOXJKGF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WjyhZCS6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0z9qVwIN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AWZaiIqx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jDOXJKGF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WjyhZCS6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0z9qVwIN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AWZaiIqx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65E3F1F7C3;
	Mon, 31 Aug 2026 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788182515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GONtC77qWyt7qMbDdp2ME8JLmNZFn2I4YULdSq40S70=;
	b=jDOXJKGFknCLD+BPS1mktqRZsnR9yMo2jHwuBfOY4gSD8veD08bN+fy6WMsohdVJcpehyB
	bK5UmWfV2oszU7wJDDI/DhgqGsICl+Yb0tYtMfWrXC9e5QApf2XHxoGxW9KzkV3+cJTBgg
	G/FNn1C0DEuv6RYngHy2HcO7geMc9hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788182515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GONtC77qWyt7qMbDdp2ME8JLmNZFn2I4YULdSq40S70=;
	b=WjyhZCS6QMBdRwNzDKK6LXSw8NfjeJR8nSQYCD8wV3nCWxo/z7zOCaSlgZM3uzIpFGnBTP
	eLtZ5B8nXXOqM6Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0z9qVwIN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AWZaiIqx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788182511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GONtC77qWyt7qMbDdp2ME8JLmNZFn2I4YULdSq40S70=;
	b=0z9qVwINTYUJ+NHWZ0hNHciSprIYu1Is0HS1Dzhk2i7sEbNkL3O/miSoV59sZFGVD05oB9
	+TfajRS8xyhBVzWW94iHf6/m/sDwPYPJDZftgNGdqr98z9MJtAFn5npMxjCCvDo8x/twIu
	EpMH+8NNVHXVXtWWQqLizXp97Tbz77E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788182511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GONtC77qWyt7qMbDdp2ME8JLmNZFn2I4YULdSq40S70=;
	b=AWZaiIqx5P6kekKqWe5H8/BFxADJStAfZO5UYncv5/fz1tF+Q9fsvvbrs8uHvu8okn99ud
	thVNqGgzNiJvNfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C370E13682;
	Mon, 31 Aug 2026 13:21:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GB27K+5/lWpiOgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 31 Aug 2026 13:21:50 +0000
Date: Mon, 31 Aug 2026 14:21:48 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Matthew Wilcox <willy@infradead.org>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	vdubeyko@coreweave.com
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
Message-ID: <apV-epG6dtc71Fgt@pedro-suse>
References: <20260826225614.486112-1-slava@dubeyko.com>
 <ao9_az3JPNhHooMl@casper.infradead.org>
 <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
 <apCQPaalWMaB5D-p@pedro-suse.lan>
 <a7b30d5e625da9cbb4a888e31a81df03d37ce91e.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b30d5e625da9cbb4a888e31a81df03d37ce91e.camel@dubeyko.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 65E3F1F7C3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On Fri, Aug 28, 2026 at 02:52:22PM -0700, Viacheslav Dubeyko wrote:
> On Thu, 2026-08-27 at 20:35 +0100, Pedro Falcato wrote:
> > On Thu, Aug 27, 2026 at 11:35:12AM -0700, Viacheslav Dubeyko wrote:
> > > On Thu, 2026-08-27 at 01:06 +0100, Matthew Wilcox wrote:
> > > > On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko
> > > > wrote:
> > > > > Christoph Hellwig has detected that taking the page lock around
> > > > > the kmap/modify/kunmap section is not enough on its own:
> > > > > writeback drops the page lock before the write actually
> > > > > completes,
> > > > > so a mutator that only waits on the lock can still start
> > > > > rewriting
> > > > > a page whose old contents are still in flight to the device.
> > > > > Mark the allocation file's mapping with
> > > > > mapping_set_stable_writes()
> > > > > and call folio_wait_stable() right after taking the page lock
> > > > > in
> > > > > both functions, so a mutator also waits out any writeback that
> > > > > was
> > > > > already in progress when it acquired the lock.
> > > > 
> > > > Why would you indirect through the stable mechanism rather than
> > > > just
> > > > calling folio_wait_writeback() directly?
> > > 
> > > The HFS+ allocation file (block bitmap) is represented by sbi-
> > > > alloc_file inode and mapping represents the block bitmap space.
> > > > If one
> > > thread is calling hfsplus_block_allocate() or hfsplus_block_free(),
> > > then it tries to modify the content of folios/pages in this
> > > mapping.
> > > But writeback could happen in the background in another thread. It
> > > sounds like "folio's contents to stay unchanged while writeback is
> > > in
> > > progress". This is why folio_wait_stable() was suggested. Do you
> > > mean
> > > that it is not exactly correct approach? Do you think that
> > 
> > Why do you want to do this? It's definitely unusual for filesystems
> > (AFAIK)?
> > It sounds like you're trying to guarantee some sort of consistency in
> > your
> > writes, without journaling, but I can't tell exactly why.
> > 
> > (FWIW, if you're trying to do this for metadata consistency reasons,
> > I
> > really don't think this works, because not only do you not know if
> > data
> > hits the disk, but you also don't know if other writes (e.g inodes)
> > hit
> > the disk, etc)
> 
> The sbi->alloc_file [1] is not regular inode. It is embedded into a
> superblock structure the special inode for representing metadata:
> 
> struct hfsplus_sb_info {
> <skipped>
> 	struct inode *alloc_file;
> <skipped>
> };
> 
> This inode participates in metadata operations only:
> hfsplus_block_allocate(), hfsplus_block_free(). If this inode is marked
> as dirty, then hfsplus_file_fsync() [2], hfsplus_sync_fs() [3] can
> call:
> 
>  filemap_write_and_wait(sbi->alloc_file->i_mapping)
> 
> And this call could take place concurrently with
> hfsplus_block_allocate(), hfsplus_block_free(). The main goal of
> folio_wait_stable() or folio_wait_writeback() is to prevent the
> allocate or free methods from accessing memory page until it under
> writeback.

Why is that a problem? Racing writeback is fine for most block devices
(those that aren't have bdev_stable_writes(), thus just doing folio_wait_stable()
should work, I think)

> writes.
> 
> But if you believe that the whole approach of managing Allocation File
> is implemented in wrong way many years ago, then you are welcomed top
> implement it in right way. :)

Oh. I don't think that's wrong. I'm just trying to understand why you think
excluding against writeback unconditionally is the right thing to do.

-- 
Pedro
