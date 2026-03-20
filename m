Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70F36829D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018905; cv=none; b=kDKl7lFqP1qjFvSdaI+N3YokGVTJ7DVqe2rxIoETkKnk8MNjtKPAhYDddcLn67GqVQIg0UqHqwdDt9owidkb/NzWulLzRLVH7keBtJzJ7YOqowCiKYVFcLc1Ykb2molv8G/n/BVJaP6FK/J5olSWS8jm/u0f43Dv6O7nYIfJnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018905; c=relaxed/simple;
	bh=I609+wzctZPhxtyutSPjihea9zIvF+GlRKN5S9NKdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+S49GCZWqB5dW87ZHbbjBMTQDa+djpqIC3uyll/9BWSK26SniE6qo5deh1hLyNkxH1NPZRhbj7JZATTtxN8Mm8bbmFNO/aFFuXmliZ5qHKb4UoN0vO1ivLu57ToWMZCnVV290/fiDYSVKxbqsvDt6b2R2gNqL5xi7qtf+0GAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJ8hnGpU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3g7K35VI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DczczCBy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAOkVbES; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJ8hnGpU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3g7K35VI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DczczCBy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAOkVbES"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 715254D27B;
	Fri, 20 Mar 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774018902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKwF2DkGEAIHedD72ZImfHS+3XePDQdwe/OjI2d4fsk=;
	b=KJ8hnGpU3J7Y/BeD3H7P4bozUJUfXzHiAJpaEM6jexCXE6NHFaQQQ2rTMjf0+GS4fv983I
	vDqO0/LGKdvfVoCj/J+MefCe0U0QLNGRHDGNbArq/egOvHO5OrVKkkAi9gPOLh1/MzIy0H
	C4ECCTkGfoXXGZ88FgG4+0gdbsqZ/3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774018902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKwF2DkGEAIHedD72ZImfHS+3XePDQdwe/OjI2d4fsk=;
	b=3g7K35VIA1RdrQHczQIAZ69FvPdfsdPUXuB7Ja99wTp3wfv6+O+PvgIHVhm4IyN1YETqLD
	GhM1BY9YFqACSnBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774018901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKwF2DkGEAIHedD72ZImfHS+3XePDQdwe/OjI2d4fsk=;
	b=DczczCBy9V708jcL814HPHM8vyKckVhUx/wASXJA8n2Ql2SQWZyBAmopzq7dr0Xwqh4dma
	j2iieWwWI2P4IrtF7tj2Y8QByA2mPQJPV1vPgBcYGu96J++8ALuntX9tS22LhFeVJBaE0b
	oVJ/nfe3fDvafs87wiCn265ta457yn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774018901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKwF2DkGEAIHedD72ZImfHS+3XePDQdwe/OjI2d4fsk=;
	b=VAOkVbES2Rb3ZxDjwukk8zaFm/kkoSWCs8hPYIz2ExmtEV/TfQtOW9RDCjrHtSFl1DNibM
	6HO2LBn6A5vV1nCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67E7942868;
	Fri, 20 Mar 2026 15:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3JUGVVhvWlFXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 15:01:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2CFACA0A81; Fri, 20 Mar 2026 16:01:37 +0100 (CET)
Date: Fri, 20 Mar 2026 16:01:37 +0100
From: Jan Kara <jack@suse.cz>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: linux-kernel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 __bread_gfp
Message-ID: <uqmzsl6oedy6papq3nxkr5qpkjerezkjcrdbmxvrmnpr5cro4q@tza7vmpvuypg>
References: <3f2c9284.71e4.19cdbfaef3d.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2c9284.71e4.19cdbfaef3d.Coremail.luckd0g@163.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

Hello!

On Wed 11-03-26 16:19:41, Jianzhou Zhao wrote:
> Subject: [BUG] isofs: kernel NULL pointer dereference in __bread_gfp
> 
> Dear Maintainers,
> 
> We are writing to report a NULL pointer dereference vulnerability within the JFS/ISOFS mounting architecture. This bug was found by our custom fuzzing tool, RacePilot. The bug occurs because `isofs_fill_super()` initiates disk reads via `sb_bread()` immediately relying on the superblock's `s_bdev` block device map being valid, which triggers an immediate NULL pointer dereference inside the `__bread_gfp()` buffer logic if a corrupted/malformed mount request bypasses or fails basic block device bindings. We observed this bug on the Linux kernel version 6.18.0-08691-g2061f18ad76e-dirty.
> 
> Call Trace & Context
> ==================================================================
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 33da6067 P4D 33da6067 PUD 0 
> Oops: Oops: 0002 [#1] SMP NOPTI
> CPU: 1 UID: 0 PID: 12411 Comm: syz.8.1172 Not tainted 6.18.0-08691-g2061f18ad76e-dirty #50 PREEMPT(voluntary) 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> 
> Call Trace:
>  <TASK>
>  sb_bread include/linux/buffer_head.h:346 [inline]
>  isofs_fill_super+0x2ff/0x1900 fs/isofs/inode.c:632
>  get_tree_bdev_flags+0x256/0x370 fs/super.c:1699
>  get_tree_bdev+0x1f/0x30 fs/super.c:1722
>  isofs_get_tree+0x1c/0x30 fs/isofs/inode.c:1538
>  vfs_get_tree+0x51/0x1a0 fs/super.c:1759
>  fc_mount+0x1a/0x130 fs/namespace.c:1199
>  do_new_mount_fc fs/namespace.c:3636 [inline]
>  do_new_mount fs/namespace.c:3712 [inline]
>  path_mount+0x105c/0x1830 fs/namespace.c:4022
>  do_mount fs/namespace.c:4035 [inline]
>  __do_sys_mount fs/namespace.c:4224 [inline]
>  __se_sys_mount fs/namespace.c:4201 [inline]
>  __x64_sys_mount+0x1d7/0x210 fs/namespace.c:4201
>  ...
> ==================================================================

Hrm, OK.

> Root Cause Analysis
> A NULL pointer dereference takes place within the deepest buffer
> traversal locks. When fuzzy mounts present a dummy context, network
> stream, or loopback context absent of a strict block device assignment,
> `get_tree_bdev_flags` may pass down a partially mapped `super_block`
> containing `s->s_bdev == NULL`. The `isofs_fill_super()` code makes no
> defensive verification of `s->s_bdev` before executing
> `bdev_logical_block_size(s->s_bdev)` and `sb_bread(s, block)`, which
> ultimately cascades down to `__bread_gfp` attempting atomic flag
> acquisitions unconditionally against a zero-target address.

But this justification just doesn't make sense. When creating new
superblock setup_bdev_super() does set sb->s_bdev to non-NULL value. If
isofs_fill_super() called shortly afterwards got superblock with NULL
sb->s_bdev, it points to memory corruption or something similar going on.

> Unfortunately, we were unable to generate a reproducer for this bug.

And without a reproducer you never know. I'd say don't even bother with
reporting if you don't have a reliable reproducer of the crash, nobody is
going to have a look at it as it's mostly a waste of time.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
