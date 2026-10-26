Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020099;
	b=t7kF8ObXs2VYijTjiMdtF2PH8nhEWr9pYulTFuHg30OMjfL0vQ17PGAo5FwiWZPq/0u5
	 Mb3E8ViE2TaTx9Wj2chXOJazQeqyZ8DiP745C4lWqylX7IjFXS9q+peUlTUkHKTo2zcZv
	 wj9TFv1bvV0vAvUoHrYbgclAXGph4GGiMwrpGnkUWpK/q9JzHmVLraOhoU14vmBKrV0Nw
	 S0GiiY3gOpTaRL3oxaME04PfdiHa/R0xy107nv6f5eV2rWepqFKXYjuv0cyYwuuuOCM57
	 1yIrSU3l/mbqnm09r5a9WBWptlcYH2K14vC8w29lUBJzj/LfnX16+936J2jAYz5scIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020099;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=/LaJPNgoMxQGKTEoJPunrzJNT9OGNjl3wT3+JfDy8Hg=;
	b=Sccc1Ye/daaCBeMqfi5+WMXODSCxaMKIuVW26av2W8uwBf6ll67UiOCi4X4Amsjefca4
	 92+6kcoudjs0MNcDxW3WDoyTZC6wHKTi3lEVdmfPrrMWryugjiv/KCa/NeeMisYsi0ZEm
	 kp5SRBzmrzBUNWakBoCtj6Ofqvta6A8X/o04ivK+2OGrXmXwyHJlfGY7VVGqMWdfc+maw
	 1c3aKMt9IEwOs7zwC7j9eicgCJEEtYK8Dle7y10QhbJudkEYegOe1g4NNhqLkIrFYc/br
	 Je/3LrFmooK3mLdME12Kl8keFF+eOHn/pmK75kvoESj9LT2uRkkggTsatpOMVWTrgpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="qelMB/Bj";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DQqv8XHd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="qelMB/Bj";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DQqv8XHd;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9B606A31A;
	Mon, 26 Oct 2026 13:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qelMB/Bj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DQqv8XHd;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qelMB/Bj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DQqv8XHd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C34F11F461;
	Mon, 26 Oct 2026 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793020096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LaJPNgoMxQGKTEoJPunrzJNT9OGNjl3wT3+JfDy8Hg=;
	b=qelMB/BjFqgvBS9P67zjljz5Wws2dZUqmlkIhVigU025OG7xbEOxO/aUr8LR0pJ/gDOoe3
	W2flsV0wedLYw7sbrt5eyJ0RVRjs42T6t/hjeu5v5KE1JO6TJEQ52OK7Zk9cIYfPO8BPcn
	PqtpXX6ISIhgl6StiyqFj884id5bZLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793020096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LaJPNgoMxQGKTEoJPunrzJNT9OGNjl3wT3+JfDy8Hg=;
	b=DQqv8XHd7HzpJlYdj0mmdtWpp4P1dANZjsxxD7uRLKcapc5xxTgEn+x/I1wEPMqRG6XPwx
	12GSjdEpXKpjylDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qelMB/Bj";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DQqv8XHd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793020096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LaJPNgoMxQGKTEoJPunrzJNT9OGNjl3wT3+JfDy8Hg=;
	b=qelMB/BjFqgvBS9P67zjljz5Wws2dZUqmlkIhVigU025OG7xbEOxO/aUr8LR0pJ/gDOoe3
	W2flsV0wedLYw7sbrt5eyJ0RVRjs42T6t/hjeu5v5KE1JO6TJEQ52OK7Zk9cIYfPO8BPcn
	PqtpXX6ISIhgl6StiyqFj884id5bZLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793020096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LaJPNgoMxQGKTEoJPunrzJNT9OGNjl3wT3+JfDy8Hg=;
	b=DQqv8XHd7HzpJlYdj0mmdtWpp4P1dANZjsxxD7uRLKcapc5xxTgEn+x/I1wEPMqRG6XPwx
	12GSjdEpXKpjylDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A6913408;
	Mon, 26 Oct 2026 13:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CtXvG8BQ32qwYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 13:08:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2597DA1419; Mon, 26 Oct 2026 14:08:12 +0100 (CET)
Date: Mon, 26 Oct 2026 14:08:12 +0100
From: Jan Kara <jack@suse.cz>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: jack@suse.cz, brauner@kernel.org, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, aurelien.desbrieres@gmail.com
Subject: Re: mmb_sync: b_mmb NULL window races mmb_mark_buffer_dirty
Message-ID: <q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3>
References: <20261024170609.125348-1-aurelien@hackers.camp>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024170609.125348-1-aurelien@hackers.camp>
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,infradead.org,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C34F11F461

Hi!

On Sat 24-10-26 19:06:09, Aurelien DESBRIERES wrote:
> While measuring beamfs on vfs.all (2c3ba1f1cb41, on v7.3-rc7) we hit a
> list corruption in fs/buffer.c that I think is a window in mmb_sync()
> rather than anything specific to our filesystem, so here it is with
> the trace. beamfs was attaching buffers that several inodes share
> (bitmap blocks, parity regions) to the allocating inode's
> i_metadata_bhs, so the same buffer_head moved from one inode's list to
> another's. We have since given those buffers a list of their own and
> the problem is gone on our side; the window remains.

Well, yes, mmb code is all built on the assumption that each buffer has at
most one inode with which it can be tracked. If the filesystem tries to
attach it to more than one inode, all bets are off and we give no
guarantees what happens. I guess we should add an assertion to
mmb_mark_buffer_dirty() for that to warn about buggy filesystem code early.

So what you did - handling shared buffers separately - is the right fix for
the problem you were hitting.

								Honza

> The window
> 
> mmb_sync() does, under mmb_A->lock:
> 
> 	__remove_assoc_queue(mmb, bh);	/* list_del_init, b_mmb = NULL */
> 	smp_mb();
> 	if (buffer_dirty(bh) || buffer_locked(bh)) {
> 		list_add(&bh->b_assoc_buffers, &tmp);
> 		bh->b_mmb = mmb;
> 
> Between the NULL store and the restore, mmb_mark_buffer_dirty(bh, mmb_B)
> on another CPU sees !bh->b_mmb, takes mmb_B->lock (a different lock),
> its cmpxchg(&bh->b_mmb, NULL, mmb_B) succeeds, and list_move_tail()
> writes bh->b_assoc_buffers while CPU A's list_add() does the same.
> The second loop of mmb_sync() has the same shape (remove, then
> list_add back to mmb->list when still dirty).
> 
> The old mark_buffer_dirty_inode() took the bdev mapping's
> i_private_lock, shared by every inode of the device, so the two
> writers could not overlap. A per-mmb lock protects a buffer that
> belongs to one mmb for life; it does not protect the moment a buffer
> changes hands. The comment above the cmpxchg says it is there for a
> corrupted filesystem with multiply claimed blocks, and the kernel-doc
> says the buffer is added "if it is not already on a list": that is
> exactly the case the window lets through, so a corrupted ext2, fat,
> minix or udf volume in which two inodes claim one indirect block
> should be able to reach it as well, given an fsync on one inode while
> the other dirties the buffer.
> 
> What it does when it hits
> 
> With CONFIG_DEBUG_LIST, __list_del_entry_valid_or_report() refuses the
> del, list_del_init() does nothing, and the first loop of mmb_sync()
> is `while (!list_empty(&mmb->list))` on a list whose head never
> leaves: the CPU spins holding mmb->lock. We lost the node to it
> (soft lockup from 48 s up, then kmemleak and the OOM killer).
> 
>   list_del corruption. next->prev should be ffffa26a6e8d4820, but was ffffa26a63804190. (next=ffffa26a432e1238)
>   WARNING: /lib/list_debug.c:65 at __list_del_entry_valid_or_report+0xf6/0x110, CPU#0: dbench/16440
>   CPU: 0 UID: 0 PID: 16440 Comm: dbench Not tainted 7.3.0-rc7 #1 PREEMPT(lazy)
>   Call Trace:
>    __remove_assoc_queue+0x20/0x80
>    mmb_sync+0xba/0x300
>    beamfs_write_inode+0x45/0x190
>    __writeback_single_inode+0x480/0x630
>    writeback_single_inode+0x11d/0x4d0
>    sync_inode_metadata+0x46/0x70
>    simple_fsync_noflush+0x55/0x90
>    simple_fsync+0x16/0x40
>    do_fsync+0x50/0xc0
>    __x64_sys_fsync+0x13/0x20
>   [...]
>   rcu: INFO: rcu_preempt self-detected stall on CPU
>   RIP: 0010:mmb_sync+0xc0/0x300
>   [...]
>   watchdog: BUG: soft lockup - CPU#0 stuck for 48s! [dbench:16440]
>   watchdog: BUG: soft lockup - CPU#0 stuck for 413s! [dbench:16440]
> 
> xfstests generic/241 (dbench) on a 4-CPU x86_64 guest, kernel vfs.all
> at 2c3ba1f1cb41 with CONFIG_DEBUG_LIST, PROVE_LOCKING and kmemleak.
> 
> A thought, not a patch
> 
> The NULL is observable only because the buffer is unlinked and then
> relinked. Keeping b_mmb set while the buffer merely moves between
> mmb->list and tmp (list_move() instead of __remove_assoc_queue() plus
> list_add(), clearing b_mmb only when the buffer is actually dropped as
> clean and unlocked) would leave mmb_mark_buffer_dirty() nothing to
> race with inside mmb_sync(); the lockless check would then see either
> the old mmb or none, never a transient NULL on a buffer that is about
> to come back. I have not written or tested that, and you know what
> else looks at b_mmb.
> 
> If a fix is wanted, we can run it against the module as it was before
> our change, on the same guest: that is where the race showed, and the
> same test passes 24 of 24 trials with the shared buffers on one list.
> 
> Aurelien
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
