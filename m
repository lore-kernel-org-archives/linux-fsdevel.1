Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616A3BF680
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751061; cv=none; b=gW/lKXkE4FcuQk3TNFAp08PbaFVPgakxyddne2imgrQMsAsa7GjrwH3927cfmwpghuq4jUgPw9zdIhgu0wCSrbF3W4opwPRVe+D6zY+syCpDnXdZ3QEGUfoknhALDrJVMWBo1rbNjz2DZQIVOtYh0MXgLAbEgEQffcUK/CTnfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751061; c=relaxed/simple;
	bh=bpOtc+MXYNtmeuMKfp934vhahNk2d3jwH1sq5qOtcY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfZwDa8f0ozdpAxs28OtFjvH7KTke+MHwARZ4LZmHhxnqot5wm+dRh4fvQHzfkdefvMGckelWdei1lVQPkzsVm++uYSFWnClPrQ52iF475BeXRUDbqrisgjF04Aq4e6appknm1ci2qE+2T6Gq6HOFEykoFnU06dTmXhblr/NUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mXet3mOm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1b2HKlJ2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mXet3mOm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1b2HKlJ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mXet3mOm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1b2HKlJ2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mXet3mOm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1b2HKlJ2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8499D5BDE0;
	Tue, 17 Mar 2026 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773751057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eY1zl1FrTNxKhKcYioUIv1lq9BF2D4MGMADQ2qx8hEs=;
	b=mXet3mOmrIlFJkdBZOY7AizzcPq0cL5ezBFu426Tu0nw3a02hTNanaRfoHWDSwm+8T2Zod
	0Im2Rqw5GmLYpurllhNexyWy30Tt/gP6xUo+TcvT9YfkT+9MUqfZmpi2zhUduhqt0w2p40
	iU3ZovOJJeW9f5nIuWLcjTwTDIdrN/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773751057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eY1zl1FrTNxKhKcYioUIv1lq9BF2D4MGMADQ2qx8hEs=;
	b=1b2HKlJ2b6zd8RpakXHEfiLXNlixO3L5Usq050B9GcNsPj85XfN1zNVL/NmaShmQ44E6QI
	EYS/PASg7gBYUoCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773751057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eY1zl1FrTNxKhKcYioUIv1lq9BF2D4MGMADQ2qx8hEs=;
	b=mXet3mOmrIlFJkdBZOY7AizzcPq0cL5ezBFu426Tu0nw3a02hTNanaRfoHWDSwm+8T2Zod
	0Im2Rqw5GmLYpurllhNexyWy30Tt/gP6xUo+TcvT9YfkT+9MUqfZmpi2zhUduhqt0w2p40
	iU3ZovOJJeW9f5nIuWLcjTwTDIdrN/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773751057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eY1zl1FrTNxKhKcYioUIv1lq9BF2D4MGMADQ2qx8hEs=;
	b=1b2HKlJ2b6zd8RpakXHEfiLXNlixO3L5Usq050B9GcNsPj85XfN1zNVL/NmaShmQ44E6QI
	EYS/PASg7gBYUoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73CC64273B;
	Tue, 17 Mar 2026 12:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dtI7HBFLuWmwCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 12:37:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2DEA9A0A5B; Tue, 17 Mar 2026 13:37:37 +0100 (CET)
Date: Tue, 17 Mar 2026 13:37:37 +0100
From: Jan Kara <jack@suse.cz>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: KCSAN: data-race in __remove_assoc_queue /
 mark_buffer_dirty_inode
Message-ID: <jbtv7oujv72i7lm2uctvpslevkfpascvxkpzwnicnleuv6lx3i@63bjxz7xlnrd>
References: <7852a82.6830.19cdbdeea92.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7852a82.6830.19cdbdeea92.Coremail.luckd0g@163.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 11-03-26 15:49:05, Jianzhou Zhao wrote:
> 
> 
> Subject: [BUG] fs/buffer: KCSAN: data-race in __remove_assoc_queue / mark_buffer_dirty_inode
> 
> Dear Maintainers,
> 
> We are writing to report a KCSAN-detected data race vulnerability within `fs/buffer.c`. This bug was found by our custom fuzzing tool, RacePilot. The race condition occurs when `__remove_assoc_queue` updates `bh->b_assoc_map` while `mark_buffer_dirty_inode` performs a lockless speculative read on the exact same variable before trying to acquire the associative lock. We observed this bug on the Linux kernel version 6.18.0-08691-g2061f18ad76e-dirty.
> 
> Call Trace & Context
> ==================================================================
> BUG: KCSAN: data-race in __remove_assoc_queue / mark_buffer_dirty_inode

This one is completely harmless and the code will do the right thing. So I
don't think any fix is needed here. At best we could annotate the read with
data_race to silence KCSAN but I have larger refactoring in progress in
this area so let's bother with such cosmetic things afterwards.

								Honza

> 
> write to 0xffff88802a6cc1f8 of 8 bytes by task 25093 on cpu 1:
>  __remove_assoc_queue+0xae/0xd0 fs/buffer.c:524
>  fsync_buffers_list+0x183/0x750 fs/buffer.c:823
>  sync_mapping_buffers+0x59/0x90 fs/buffer.c:585
>  fat_file_fsync+0xbb/0x100 fs/fat/file.c:195
>  vfs_fsync_range+0xe8/0x170 fs/sync.c:197
>  generic_write_sync include/linux/fs.h:2630 [inline]
>  generic_file_write_iter+0x1ee/0x210 mm/filemap.c:4494
>  new_sync_write fs/read_write.c:605 [inline]
>  vfs_write+0x78f/0x910 fs/read_write.c:701
>  ksys_write+0xbe/0x190 fs/read_write.c:753
>  __do_sys_write fs/read_write.c:764 [inline]
>  __se_sys_write fs/read_write.c:761 [inline]
>  __x64_sys_write+0x41/0x50 fs/read_write.c:761
>  x64_sys_call+0x1022/0x2030 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xae/0x2c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff88802a6cc1f8 of 8 bytes by task 25074 on cpu 0:
>  mark_buffer_dirty_inode+0x9c/0x250 fs/buffer.c:711
>  fat_mirror_bhs+0x280/0x3b0 fs/fat/fatent.c:417
>  fat_alloc_clusters+0xaed/0xb90 fs/fat/fatent.c:568
>  fat_add_cluster+0x34/0xc0 fs/fat/inode.c:111
>  __fat_get_block fs/fat/inode.c:159 [inline]
>  fat_get_block+0x3c4/0x550 fs/fat/inode.c:194
>  __block_write_begin_int+0x29e/0xcd0 fs/buffer.c:2186
>  block_write_begin+0x74/0xf0 fs/buffer.c:2297
>  cont_write_begin+0x402/0x5d0 fs/buffer.c:2635
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:233
>  generic_perform_write+0x13c/0x4c0 mm/filemap.c:4341
>  __generic_file_write_iter+0x117/0x130 mm/filemap.c:4464
>  generic_file_write_iter+0xa5/0x210 mm/filemap.c:4490
>  new_sync_write fs/read_write.c:605 [inline]
>  vfs_write+0x78f/0x910 fs/read_write.c:701
>  ksys_write+0xbe/0x190 fs/read_write.c:753
>  __do_sys_write fs/read_write.c:764 [inline]
>  __se_sys_write fs/read_write.c:761 [inline]
>  __x64_sys_write+0x41/0x50 fs/read_write.c:761
>  x64_sys_call+0x1022/0x2030 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xae/0x2c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0xffff88802a5fa008 -> 0x0000000000000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 25074 Comm: syz.2.1198 Not tainted 6.18.0-08691-g2061f18ad76e-dirty #44 PREEMPT(voluntary) 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> ==================================================================
> 
> Execution Flow & Code Context
> During a buffer fsync trigger (e.g. from `fat_file_fsync`), `fsync_buffers_list()` is responsible for looping over the inode's private buffer list. At the start of its loop, it isolates the buffer and calls `__remove_assoc_queue()`, which clears `bh->b_assoc_map` using a plain C store under `buffer_mapping->i_private_lock`:
> ```c
> // fs/buffer.c
> static void __remove_assoc_queue(struct buffer_head *bh)
> {
> 	list_del_init(&bh->b_assoc_buffers);
> 	WARN_ON(!bh->b_assoc_map);
> 	bh->b_assoc_map = NULL; // <-- Plain concurrent write
> }
> ```
> 
> Meanwhile, another process actively dirtying a buffer triggers `mark_buffer_dirty_inode()`. This function optimistically checks whether the buffer head is already associated with an inode mapping structure using a lockless peek at `bh->b_assoc_map`. If the map is unassigned, it acquires the target `i_private_lock` and updates it:
> ```c
> // fs/buffer.c
> void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
> {
> 	...
> 	if (!bh->b_assoc_map) { // <-- Lockless plain concurrent read
> 		spin_lock(&buffer_mapping->i_private_lock);
> 		list_move_tail(&bh->b_assoc_buffers, &mapping->i_private_list);
> 		bh->b_assoc_map = mapping;
> 		spin_unlock(&buffer_mapping->i_private_lock);
> 	}
> }
> ```
> 
> Root Cause Analysis
> A read-write KCSAN data race arises because `__remove_assoc_queue()` assigns `bh->b_assoc_map` while holding `i_private_lock` without employing any memory model volatile annotations. At the exact same snapshot, `mark_buffer_dirty_inode()` evaluates `if (!bh->b_assoc_map)` out of the lock domain to optimize out taking the spinlock for an already-associated buffer block. 
> Unfortunately, we were unable to generate a reproducer for this bug.
> 
> Potential Impact
> This data race is largely benign from a runtime control-flow perspective; the lack of association triggers a spinlock wait to assign the buffer, whereas an obsolete read evaluating to actual pointers skips the lock and skips the queue placement. If extreme read tearing or heavy compiler optimization happens, it could possibly lead to duplicate list inclusions or desynchronised buffer dirty associations, which could eventually yield missed buffers during `fsync` requests. However, triggering KCSAN logs adds extensive noise over expected logic.
> 
> Proposed Fix
> To align with the Linux Memory Model and inform KCSAN that this speculative read is intentional and expected (and to prevent compiler tearing optimisations), we should simply wrap the condition check in `mark_buffer_dirty_inode` using the `data_race()` macro. Furthermore, employing `WRITE_ONCE` in `__remove_assoc_queue` reinforces safety. 
> 
> ```diff
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -522,7 +522,7 @@ static void __remove_assoc_queue(struct buffer_head *bh)
>  {
>  	list_del_init(&bh->b_assoc_buffers);
>  	WARN_ON(!bh->b_assoc_map);
> -	bh->b_assoc_map = NULL;
> +	WRITE_ONCE(bh->b_assoc_map, NULL);
>  }
>  
>  int inode_has_buffers(struct inode *inode)
> @@ -712,7 +712,7 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
>  	} else {
>  		BUG_ON(mapping->i_private_data != buffer_mapping);
>  	}
> -	if (!bh->b_assoc_map) {
> +	if (!data_race(bh->b_assoc_map)) {
>  		spin_lock(&buffer_mapping->i_private_lock);
>  		list_move_tail(&bh->b_assoc_buffers, &mapping->i_private_list);
>  		bh->b_assoc_map = mapping;
> ```
> 
> We would be highly honored if this could be of any help.
> 
> Best regards,
> RacePilot Team
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
