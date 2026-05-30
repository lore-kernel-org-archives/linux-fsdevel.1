Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE23A7590
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139073; cv=none; b=q23h/fInu6OxrkLORs4iwuapw0dTV6mGd9H/g5/cd49mP3qf4X7fPaqGqT/6kypjIlmFewtTvRW9agd1UbIf2SGH4q3eUz+5W0TyaDBUDqu+ogJjIzNIwx5rnJO9snmjbj2AIb6GAtqb+Ok3a/Jexcvd0ORta5ZmYyFQPgaIHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139073; c=relaxed/simple;
	bh=fPFmUQ1sGZ0nKa25qqUlabVRM6NCAzwUV7H1v0cyQwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx3nYYwr09mqH1/SPggGuLnzkKTz6rNUUak5jqR3yaSw15sjwJ6K+X3MtyvqUfGQrX1p+Vtn0+fynhKb8ZIQiB4jrj/Vu45p/ogGbgK+irWgxIJh5CfbOFdpj2yNMgWNHpTKz5y8/Baekoyq+ykbWC6MPcCF7+HiZoOzlQjzjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rGi+ciVz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dt7qtgJ/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bu03kCQx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CCv9MuTP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rGi+ciVz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dt7qtgJ/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bu03kCQx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CCv9MuTP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5021675A8;
	Sat, 30 May 2026 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780139070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOqpZzhiypjkSjrTc901aMpJIxANgaa/dRvn0XHreaY=;
	b=rGi+ciVzFXy0v94+Z2JHu82uTWijRYcpLsPfGIPZpLh/CefmmDemLNglT9PEqGHkL5BZe3
	J4jupzRRF6slBxfI9bVM0GzB0rPuMJ+WRQbruASkVjGvRjep44I+/BSHAXrz4xwu/GGnLG
	5ccRzxrjKoiT4Q+2zw8OlnH5wEuuvrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780139070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOqpZzhiypjkSjrTc901aMpJIxANgaa/dRvn0XHreaY=;
	b=Dt7qtgJ/z5imaa5TP1kVu4zneekNzJ2wYXVqgGtLWcx6+uSySN5hNdJG8e/21BJneMlFZf
	hu9aQ/WcDYTBhvCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780139068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOqpZzhiypjkSjrTc901aMpJIxANgaa/dRvn0XHreaY=;
	b=bu03kCQx2HWoglXaRsZvmEoVyKSUHiXzxmdK8JjwLV1QF2BVKrrUb4j+9WY/MxPGYeCwbB
	WGI1VWK2XvWZVZO01tycLta3Foh7KCbXwMEZvWiVj31GDUmY0MOIM1FzRaaKvtccrKKd40
	Hvyg1DL1J62AiPrZoBqWBzsPF90YTKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780139068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOqpZzhiypjkSjrTc901aMpJIxANgaa/dRvn0XHreaY=;
	b=CCv9MuTPam7mBwgsb7S2/3y6uip2bpOwVGQYcRUmp4zSLdrJCZjvSSjZK8cenyW6H1VkXj
	bcZuyKe669ZPGYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8049779A7;
	Sat, 30 May 2026 11:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v+izNDzEGmrAGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:04:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73103A0EBD; Sat, 30 May 2026 13:04:13 +0200 (CEST)
Date: Sat, 30 May 2026 13:04:13 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, fuse-devel <fuse-devel@lists.linux.dev>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
 <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
 <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Thu 28-05-26 15:11:18, Joanne Koong wrote:
> On Thu, May 28, 2026 at 5:34 AM Jan Kara <jack@suse.cz> wrote:
> > > I think this is also going to be a problem for cgroups with large
> > > folios since they also, as I understand it, are constrained with a
> > > limited / tight dirty budget. I ran some initial benchmarks with
> > > cgroup memory constraints on NVMe and saw similar instability (a
> > > single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> > > 15 ms without the cgroup, with the balance_dirty_pages() throttling
> > > oscillating rather than settling near the set point).
> >
> > Ok, so this is more folios (819) than my 512 gut feeling estimate :) What
> > was the write throughput of the NVMe drive? The high drive throughput also
> > requires more dirty data to keep the drive saturated so that writeback
> > throughput doesn't oscilate too much.
> 
> The write throughput of the NVMe drive I was using was around ~1.1
> Gb/s (measured by running direct I/O). I think with the 1.6GB dirty
> budget, the math for that ends up being that the device drains it in
> ~1.5 secs. The performance I was seeing with the initial cgroup
> benchmarks was with 4k pages (no large folios enabled) on btrfs.

OK, you might want to experiment with some other filesystem (I suggest xfs
or ext4) as well. Btrfs writeback behavior is a bit special with its data
checksum computations etc. and thus latency of starting writeback. It could
contribute to the erratic behavior with the relatively low dirty limits.

> > > I think this problem gets untenable for random writes with large
> > > folios, since dirtying just a few bytes will charge the whole folio
> > > size to the dirty budget. I have a patchset from last year for adding
> > > more granular dirty/writeback tracking [3], I'm going to pick this
> > > series back up. I think it will be useful generically, not just for
> > > fuse.
> > >
> > > For getting this to work on fuse servers with strictlimiting, I think
> > > the next steps are to
> > > a) as Jan had suggested in [1], come up with some heuristic to
> > > constrain the max order supported for large folios for these fuse
> > > servers if they're running with the writeback cache enabled
> > > b) benchmark ^ and if there are still regressions, then we should
> > > probably just turn large folios off for these servers
> >
> > Yes, as we briefly discussed at LSF, picking proper max folio order is
> > useful not only for dirty throttling but also for memory reclaim in
> > general in memory-constrained environments. Strictlimit is just one of the
> > cases where the limit is very small and so the problems with the memory
> > overhead of larger folios become very apparent.
> >
> > So although we may decide for a FUSE specific heuristic setting the maximum
> > folio order, you properly point out memory limited memcgs will see similar
> > issues so I think a more general solution for selecting sensible max order
> > would be better.
> 
> This sounds great. I'll run some more benchmarks to get more data and
> then come up with a general solution and submit that as an rfc.
> 
> > > c) add the granular writeback/dirty accounting for large folios
> >
> > As Miklos pointed out and I think we've discussed that also last year since
> > the full folio is pinned in memory by a single dirty fs block (or whatever
> > is going to be your unit), finer grained accounting alone doesn't help you
> > with the narrow limits. We'd also have to add logic to decide about
> > splitting large folios.
> 
> If I'm inferring this right (and please let me know if I"m not), it
> seems like it would be extremely useful to get the infrastructure
> working better for splitting file-backed large folios. That seems like
> the proper long-term solution if I'm understanding it correctly (eg
> instead of capping the folio order statically across the board, larger
> folios can be used until there's memory pressure that splits it or if
> at write time we detect the dirty budget is tight, that will allow the
> clean parts to be reclaimable and reduce memory pressure and
> throttling)?
> 
> From what I see in __folio_split() in mm/huge_memory.c, it's not
> currently possible to split dirty file-backed folios (eg
> iomap_release_folio() will not release the folio if any part of it is
> dirty), but I think we can get this working in the iomap layer for
> supporting the per-folio dirty/uptodate state tracking for the split
> folio instead of rejecting the release. Iomap already tracks which
> subfolios are dirty vs not, so we have the information upfront as well
> about how to split the dirty folio optimally. Do you think this would
> be useful to get working?

I don't think people have reached concensus on what would be the best way
to address the issues with coarse granularity of large folios (even within
myself I haven't quite decided about the best solution :)). So we are just
experimenting and seeing what could work and what not. Limiting maximum
folio order is kind of a dumb solution but it is relatively easy to
implement and might be good enough.

Splitting of folios is definitely more complicated, requires support from
filesystems, can fail for various reasons (folio is pinned, you need to
allocate memory to split a folio, ...), and is generally more expensive.
So tuning that properly and making it work reliably under various
conditions is an order of magnitude harder task and I think at this point
you'd have a hard time justifying all the complexity without showing why
the dumb solution isn't good enough... So we might get to splitting folios
at some point in some shape or form I don't think we're there yet.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
