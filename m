Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216924;
	b=srv7oJJpmHSJL2GdvSF0Io3LPoapaOU/is3h6eJtRs4Nd2iQuhdbxQ0igUK7pwgoVD5p
	 dtkiD7caHJw6psre30dA8lparUkFZvLClMAJPBdi2ZRA9FWuzd4ssm9/D99admQZDoIZU
	 vVwHZVlda2zrRl4T15NTI8bad/6HADLFOB35Pn0v+I4W1zx5QyIpT0U/V5D2VtTGkLYfq
	 uR1bMn4hgrwtLBedrAu8b1E+6NiNbWHylnus9TDp/koHOhKHMsSM6T2lBeP1oSYSxSkJ2
	 rjGXuBJrtLGAgsOfbM2ZNpueV8M3vcWHJdksiniJqfeWnpRnZuEZArc8gnOK5NuZiyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216924;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=WSit3TGT+Hu+nxHooiffR1vu/MdQOPAucNBeRLAD2WQ=;
	b=RrH3bVzSf5mPI+3TGKrN6bSR2Zdx93tnEf1pTxz5v/WUESoyz1SxEGqJOTUmnawBuZ+w
	 +xpSw8mpf53N9DX/+w0fZkVBILNJJ/8EZ9TEJFXXuRBfJcUVHqoaU8pLxi0t7T51XYK/j
	 lrrry3eHkKiKlNJdIbqvk9xeHf2YM62EBdKHLCUEj/FV2cm+CrEcdtjM1Mw7CphmTuJMr
	 Iwpz+T1BiaZKHIxR56inzDPgTDYZYMQ795aTYhpq9q98pT1M54Tmb1E7TxLVktiAPFC0V
	 H1z/QQXRTMSRxsX9W76wM/5YalQReO06Sx6I9jLyh9t5hOwhjyhLWXJCskkYssBiAMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EClSQMAE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ciNjkuEv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EClSQMAE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ciNjkuEv;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE0606A330;
	Mon,  9 Nov 2026 09:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AAE0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EClSQMAE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ciNjkuEv;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EClSQMAE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ciNjkuEv
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B34B21CAF;
	Mon,  9 Nov 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794216915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSit3TGT+Hu+nxHooiffR1vu/MdQOPAucNBeRLAD2WQ=;
	b=EClSQMAEvw+IcyaG1Qxrd+JZVZ43RLDOdxWR6aFLfofrzfYgW6+hmOuKeftCbpTdCqo2k4
	Vs6PultMnJzoxffGPO7kTUyhRl1XagJpkyQcE1oOSWa1RdTvsZ2VZZJkx7ERUf2LRicI5O
	Un5n5+YartxfeAV+EOnVaWODY+1+5Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794216915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSit3TGT+Hu+nxHooiffR1vu/MdQOPAucNBeRLAD2WQ=;
	b=ciNjkuEvdX6KzinecG4iHsckf3OwP+Xn8jfdrZX6SNOR2wAYwzP1uDEITs5+siMO+b+YqY
	+wpdDMvI732AZXBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EClSQMAE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ciNjkuEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794216915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSit3TGT+Hu+nxHooiffR1vu/MdQOPAucNBeRLAD2WQ=;
	b=EClSQMAEvw+IcyaG1Qxrd+JZVZ43RLDOdxWR6aFLfofrzfYgW6+hmOuKeftCbpTdCqo2k4
	Vs6PultMnJzoxffGPO7kTUyhRl1XagJpkyQcE1oOSWa1RdTvsZ2VZZJkx7ERUf2LRicI5O
	Un5n5+YartxfeAV+EOnVaWODY+1+5Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794216915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSit3TGT+Hu+nxHooiffR1vu/MdQOPAucNBeRLAD2WQ=;
	b=ciNjkuEvdX6KzinecG4iHsckf3OwP+Xn8jfdrZX6SNOR2wAYwzP1uDEITs5+siMO+b+YqY
	+wpdDMvI732AZXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F47C13302;
	Mon,  9 Nov 2026 09:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUYTO9KT8WqrMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 09:35:15 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 9ADB521D7C; Mon, 09 Nov 2026 10:35:14 +0100 (CET)
Date: Mon, 9 Nov 2026 10:35:14 +0100
From: Jan Kara <jack@suse.cz>
To: Seiji Nishikawa <snishika@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+181b8b439f5207144b16@syzkaller.appspotmail.com
Subject: Re: [PATCH] inotify: do not expose a zero mask while replacing a
 watch
Message-ID: <pitzz3qt6efds6xqkowtaybzwh5tsd2arn3en263qqccs5wb3s@rrky5c2aggkq>
References: <20261019230320.1855016-1-snishika@redhat.com>
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
In-Reply-To: <20261019230320.1855016-1-snishika@redhat.com>
X-Rspamd-Queue-Id: 4B34B21CAF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[181b8b439f5207144b16];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -11.51

On Tue 20-10-26 08:03:20, Seiji Nishikawa wrote:
> When inotify_add_watch() is called on an existing watch without
> IN_MASK_ADD, inotify_update_existing_watch() first sets mark->mask to 0
> and clears the inotify mark flags, and then sets the new bits. This is
> done under mark->lock, but event delivery reads mask and flags without
> that lock, in send_to_group(), fsnotify_iter_select_report_types(),
> fsnotify_ignore_mask(), fsnotify_handle_inode_event() and
> inotify_handle_inode_event().

Thanks for the report and the patch and I'm sorry for a delayed reply. I
agree the problem exists and it is a bit of a can of worms because the
lockless path on event delivery samples mask and flags multiple times and
can be getting different results each time it looks. Also there are more
place than you've identified that actually need similar kind of treatment
(both on the read and write side).

For example the problem can in principle affect fanotify as well (although
there we update the mask and flags with a simple read-modify-write
operation so the compiler would have to be actively trying to screw us for
it to be a practical problem). For ignore mask (in particular if
FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY is not set) things get even more
interesting because we clear the mask locklessly in send_to_group() and
that can obviously race with other ignore mask modification.

So I'm now thinking how to best address all of this...

								Honza


> So if an event comes in the middle of the update, a lockless reader of
> mark->mask can see 0 and drop the event, even when both the old mask
> and the new mask include the bit for that event. KCSAN reports this as
> a data race:
> 
> ==================================================================
> BUG: KCSAN: data-race in __se_sys_inotify_add_watch / fsnotify_handle_inode_event
> 
> write to 0xffff88811afe9be0 of 4 bytes by task 3651 on cpu 0:
>  inotify_update_existing_watch fs/notify/inotify/inotify_user.c:558 [inline]
>  inotify_update_watch fs/notify/inotify/inotify_user.c:632 [inline]
>  __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:769 [inline]
>  __se_sys_inotify_add_watch+0x2ea/0x720 fs/notify/inotify/inotify_user.c:717
>  __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user.c:717
>  x64_sys_call+0xa19/0x2550 arch/x86/include/generated/asm/syscalls_64.h:255
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x112/0x360 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff88811afe9be0 of 4 bytes by task 3653 on cpu 1:
>  fsnotify_handle_inode_event+0x18a/0x230 fs/notify/fsnotify.c:272
>  fsnotify_handle_event fs/notify/fsnotify.c:330 [inline]
>  send_to_group fs/notify/fsnotify.c:378 [inline]
>  fsnotify+0x16ae/0x1860 fs/notify/fsnotify.c:597
>  __fsnotify_parent+0x2f8/0x3a0 fs/notify/fsnotify.c:241
>  fsnotify_parent include/linux/fsnotify.h:96 [inline]
>  fsnotify_path include/linux/fsnotify.h:113 [inline]
>  fsnotify_file include/linux/fsnotify.h:127 [inline]
>  fsnotify_close include/linux/fsnotify.h:461 [inline]
>  __fput+0x1e2/0x630 fs/file_table.c:498
>  fput_close_sync+0xad/0x190 fs/file_table.c:617
>  __do_sys_close fs/open.c:1560 [inline]
>  __se_sys_close fs/open.c:1545 [inline]
>  __x64_sys_close+0x55/0xf0 fs/open.c:1545
>  x64_sys_call+0x812/0x2550 arch/x86/include/generated/asm/syscalls_64.h:4
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x112/0x360 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00002018 -> 0x00000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 3653 Comm: syz-executor126 Not tainted syzkaller #0 PREEMPT(lazy)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> ==================================================================
> 
> The old value 0x00002018 in the report is FS_UNMOUNT |
> FS_CLOSE_NOWRITE | FS_CLOSE_WRITE. The syzbot reproducer has one thread
> that calls inotify_add_watch() on a regular file in a loop, always with
> IN_CLOSE_WRITE | IN_CLOSE_NOWRITE and without IN_MASK_ADD, and another
> thread that opens and closes the same file. Calling inotify_add_watch()
> again on a watched file with the same mask is allowed, and it returns
> the same watch descriptor. But each such call still sets the mask to 0
> first, as described above, so the mask changes from 0x2018 to 0 and
> then back to 0x2018. The report shows the first thread (task 3651, in
> inotify_add_watch()) setting the mask to 0 while the second thread
> (task 3653, in close()) was reading it.
> 
> The same problem can happen to the IN_EXCL_UNLINK and IN_ONESHOT bits
> in mark->flags.
> 
> To check that events are really dropped, the dropped events were
> counted with bpftrace while the syzbot reproducer was running. The
> kernel is v7.3-rc7 built with the syzbot config plus CONFIG_KPROBES and
> CONFIG_KPROBE_EVENTS. The script counts the calls of
> fsnotify_handle_inode_event() that return without calling
> inotify_handle_inode_event(), that is, the events dropped there:
> 
> kprobe:fsnotify_handle_inode_event
> /comm == "repro" || comm == "repro_add"/
> {
> 	@calls = count();
> 	@pending[tid] = 1;
> }
> 
> kprobe:inotify_handle_inode_event
> /@pending[tid] == 1/
> {
> 	@passed = count();
> 	@pending[tid] = 0;
> }
> 
> kretprobe:fsnotify_handle_inode_event
> /@pending[tid] == 1/
> {
> 	@dropped = count();
> 	@pending[tid] = 0;
> }
> 
> With the reproducer built as "repro", 1551 of 213431 events were
> dropped in 5 seconds:
> 
> @calls: 213431
> @dropped: 1551
> @passed: 211880
> 
> With IN_MASK_ADD added to the inotify_add_watch() call in the
> reproducer, built as "repro_add", no events were dropped:
> 
> @calls: 195658
> @dropped: 0
> @passed: 195658
> 
> With this patch, no events were dropped with "repro", even without
> IN_MASK_ADD:
> 
> @calls: 337082
> @dropped: 0
> @passed: 337082
> 
> Commit 38035c04f586 ("inotify: move control flags from mask to mark
> flags") changed the call without IN_MASK_ADD to first clear the mask and
> the inotify flags, and then OR in the new bits with the same code as the
> IN_MASK_ADD case. The mask is cleared and set again under mark->lock,
> but the lockless readers do not take that lock, so they can see the
> zero mask after it is cleared and before the new bits are set, and
> drop events.
> 
> Write the new mask and flags to the mark with one WRITE_ONCE() each, so
> a lockless reader sees either the old value or the new value, never a
> zero mask in between. Also use READ_ONCE() in the lockless readers on
> the event delivery path, to pair with the WRITE_ONCE() and mark these
> reads as intentionally lockless.
> 
> Fixes: 38035c04f586 ("inotify: move control flags from mask to mark flags")
> Reported-by: syzbot+181b8b439f5207144b16@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=181b8b439f5207144b16
> Cc: stable@vger.kernel.org
> Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
> ---
>  fs/notify/fsnotify.c                 | 10 +++++-----
>  fs/notify/inotify/inotify_fsnotify.c |  2 +-
>  fs/notify/inotify/inotify_user.c     | 17 +++++++++++++----
>  include/linux/fsnotify_backend.h     |  4 ++--
>  4 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7e2f330fd283..4687ba54da01 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -264,12 +264,12 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
>  	if (WARN_ON_ONCE(!inode && !dir))
>  		return 0;
>  
> -	if ((inode_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
> +	if ((READ_ONCE(inode_mark->flags) & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
>  	    path && d_unlinked(path->dentry))
>  		return 0;
>  
>  	/* Check interest of this mark in case event was sent with two marks */
> -	if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
> +	if (!(mask & READ_ONCE(inode_mark->mask) & ALL_FSNOTIFY_EVENTS))
>  		return 0;
>  
>  	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
> @@ -349,7 +349,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  	/* clear ignored on inode modification */
>  	if (mask & FS_MODIFY) {
>  		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> -			if (!(mark->flags &
> +			if (!(READ_ONCE(mark->flags) &
>  			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
>  				mark->ignore_mask = 0;
>  		}
> @@ -358,7 +358,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  	/* Are any of the group marks interested in this event? */
>  	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
>  		group = mark->group;
> -		marks_mask |= mark->mask;
> +		marks_mask |= READ_ONCE(mark->mask);
>  		marks_ignore_mask |=
>  			fsnotify_effective_ignore_mask(mark, is_dir, type);
>  	}
> @@ -439,7 +439,7 @@ static bool fsnotify_iter_select_report_types(
>  			 * But is *this mark* watching children?
>  			 */
>  			if (type == FSNOTIFY_ITER_TYPE_PARENT &&
> -			    !(mark->mask & FS_EVENT_ON_CHILD) &&
> +			    !(READ_ONCE(mark->mask) & FS_EVENT_ON_CHILD) &&
>  			    !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
>  				continue;
>  
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index 7c326ec2e8a8..da506ef03a25 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -129,7 +129,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>  		fsnotify_destroy_event(group, fsn_event);
>  	}
>  
> -	if (inode_mark->flags & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
> +	if (READ_ONCE(inode_mark->flags) & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
>  		fsnotify_destroy_mark(inode_mark, group);
>  
>  	return 0;
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 5f19c24ec187..98a13699ee66 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -554,12 +554,21 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
>  
>  	spin_lock(&fsn_mark->lock);
> +	/*
> +	 * Event delivery reads mask and flags without mark->lock, so update
> +	 * each of them with a single store and never expose a partial value.
> +	 */
>  	if (replace) {
> -		fsn_mark->mask = 0;
> -		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
> +		WRITE_ONCE(fsn_mark->mask, inotify_arg_to_mask(inode, arg));
> +		WRITE_ONCE(fsn_mark->flags,
> +			   (fsn_mark->flags & ~INOTIFY_MARK_FLAGS) |
> +			   inotify_arg_to_flags(arg));
> +	} else {
> +		WRITE_ONCE(fsn_mark->mask,
> +			   fsn_mark->mask | inotify_arg_to_mask(inode, arg));
> +		WRITE_ONCE(fsn_mark->flags,
> +			   fsn_mark->flags | inotify_arg_to_flags(arg));
>  	}
> -	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
> -	fsn_mark->flags |= inotify_arg_to_flags(arg);
>  	spin_unlock(&fsn_mark->lock);
>  
>  	fsnotify_recalc_mask(fsn_mark->connector);
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index a6d5c1a89cff..5f0b94bfde8e 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -802,7 +802,7 @@ static inline __u32 fsnotify_ignore_mask(struct fsnotify_mark *mark)
>  	__u32 ignore_mask = mark->ignore_mask;
>  
>  	/* The event flags in ignore mask take effect */
> -	if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
> +	if (READ_ONCE(mark->flags) & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
>  		return ignore_mask;
>  
>  	/*
> @@ -812,7 +812,7 @@ static inline __u32 fsnotify_ignore_mask(struct fsnotify_mark *mark)
>  	 */
>  	ignore_mask |= FS_ISDIR;
>  	ignore_mask &= ~FS_EVENT_ON_CHILD;
> -	ignore_mask |= mark->mask & FS_EVENT_ON_CHILD;
> +	ignore_mask |= READ_ONCE(mark->mask) & FS_EVENT_ON_CHILD;
>  
>  	return ignore_mask;
>  }
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
