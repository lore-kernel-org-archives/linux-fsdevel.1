Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411537AA64
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162304; cv=none; b=Fb5q5PfCRId8XjABEJ98oPzrBvuPRRtLu2WeC/j8lftYnjgTAjTvwFBeMvp35n3X8rBkKRJ5Q+yXLttj47BRZ+Zfp1oviA2Onp1vUiLFssJo8pK4zUu/PLIfS5D1ixrjNf1EpvkrQd7VxCRLmxB/szKw+fWN7Q89UQdCQUIv8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162304; c=relaxed/simple;
	bh=FQrLHVXNY2UIZxBhrNCCq+m8uGfNQm3qeyu9e54soz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRxBHetG0/SIUlDlNc4MqKcMYJwybM1lxb0FG6eR3vgw5qfZZ5ePQILUoVm4KXySu6uIdr7NXUx7fmlMvGAp+LIUYXDtSoEUkRP0YxenfDvW6X6oSpbHFWKcUpymZ5kIE6zSXVMysjbWS5X00ZPWrHHfDGvuom2w34TG7WHdcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=muOIhU05; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o0LTqz7x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v/f1eOrv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7P1AFkb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="muOIhU05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o0LTqz7x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v/f1eOrv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7P1AFkb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C23AC41AC;
	Mon, 27 Jul 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785162297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NEej9yxbwqNeyJRKdDxX4yzkpqzdE4GTjlELfqM+AE=;
	b=muOIhU05Vyx8D/IX8/Nfgiu0ozp0I/ZgEOYtlc2VpIgCHmi67Q2nD6A+7UAEKGMO/hpOG2
	PZ/SReS0IhmJtxPxG3gYw0tHQ1etq+tZGfoB4dMF7pp0MGY3BrJ+B/WsP+qhUcZjXFgHvf
	4LKypA16rtWPNJ+bsoULSMsSsF2g31w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785162297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NEej9yxbwqNeyJRKdDxX4yzkpqzdE4GTjlELfqM+AE=;
	b=o0LTqz7xdCQMTDqRv50yt99cFBkSmnnObZvlAzhwGbEXo8mgiOWTcRNEVb16bBakUJinvb
	y1f9yXwErjsJhvCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785162292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NEej9yxbwqNeyJRKdDxX4yzkpqzdE4GTjlELfqM+AE=;
	b=v/f1eOrvJZtIHZ1Z5WYXgJnFnAMV4BEzT6YYxI0YHaXkxzk4TmHyp2lDCAncjI5F7WMwqW
	N9xFUrv5qr1uReB0Zak7ermgQrRdvINPd0fxYeWn5cwUDmu15ha3ThsBItaizDm49UELNT
	VSfXjAwFroBa0NCE5XGGgHrlVIuReZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785162292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NEej9yxbwqNeyJRKdDxX4yzkpqzdE4GTjlELfqM+AE=;
	b=X7P1AFkbCktbo/E4J19c6RdriBqZ1z42+9vcXvzVSn1u46DcabqJKVpvk358PS9wUKXR4b
	L110k4uzszIxuSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA8C3779C1;
	Mon, 27 Jul 2026 14:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCWGLTRqZ2q1PwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 14:24:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57F53A0BA1; Mon, 27 Jul 2026 16:24:52 +0200 (CEST)
Date: Mon, 27 Jul 2026 16:24:52 +0200
From: Jan Kara <jack@suse.cz>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ccc194101@163.com
Subject: Re: [PATCH] fs/super: fix emergency thaw double-unlock of s_umount
Message-ID: <lpo35g5mg2jihskca2odgocj6s6gijjicba22yk3cosmqlmdqy@b5hk7e6kjab2>
References: <20260721064140.152305-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721064140.152305-1-chenchangcheng@kylinos.cn>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 21-07-26 14:41:40, Chen Changcheng wrote:
> do_thaw_all() iterates over all superblocks via __iterate_supers()
> with SUPER_ITER_EXCL, which acquires s_umount exclusively before
> calling the callback and releases it afterwards. However, the
> callback do_thaw_all_callback() calls thaw_super_locked() which
> unconditionally releases s_umount on every code path. This results
> in a second unlock attempt in __iterate_supers() that corrupts the
> rwsem state, triggering a DEBUG_RWSEMS warning:
> 
> [  182.601148] sysrq: Emergency Thaw of all frozen filesystems
> [  182.601865] ------------[ cut here ]------------
> [  182.602375] DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff99b1011e5870, owner = 0x0, curr 0xffff99b101b06c80, list not empty
> [  182.603817] WARNING: kernel/locking/rwsem.c:1412 at up_write+0xa3/0x170, CPU#2: kworker/2:1/53
> [  182.604578] Modules linked in:
> [  182.604864] CPU: 2 UID: 0 PID: 53 Comm: kworker/2:1 Not tainted 7.2.0-rc4-00001-gbd3bd93ea98a-dirty #4 PREEMPT(lazy)
> [  182.605711] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1kylin1 04/01/2014
> [  182.606417] Workqueue: events do_thaw_all
> [  182.606750] RIP: 0010:up_write+0xaf/0x170
> [  182.607076] Code: 19 3a 92 48 0f 44 c2 48 8b 55 08 48 8b 55 00 4c 8b 45 08 48 8b 55 00 48 8d 3d ad 91 e0 01 48 8b 4d 20 50 48 c7 c6 f0 8c 26 92 <67> 48 0f b9 3a e8 d7 93 4e 00 58 eb 81 48 83 7f 18 00 48 c7 c2 8d
> [  182.608563] RSP: 0018:ffffb670001d7e08 EFLAGS: 00010246
> [  182.609007] RAX: ffffffff92349e8d RBX: 0000000000000000 RCX: ffff99b1011e5870
> [  182.609595] RDX: 0000000000000000 RSI: ffffffff92268cf0 RDI: ffffffff92914d10
> [  182.610283] RBP: ffff99b1011e5870 R08: 0000000000000000 R09: ffff99b101b06c80
> [  182.610847] R10: ffff99b10139a808 R11: fefefefefefefeff R12: 0000000000000000
> [  182.611414] R13: ffffffff90cf74d0 R14: 0000000000000000 R15: ffff99b1011e5800
> [  182.612009] FS:  0000000000000000(0000) GS:ffff99b1eaaee000(0000) knlGS:0000000000000000
> [  182.612670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  182.613146] CR2: 00000000005c631c CR3: 00000000013ee000 CR4: 00000000000006f0
> [  182.613722] Call Trace:
> [  182.613946]  <TASK>
> [  182.614130]  __iterate_supers+0x128/0x150
> [  182.614463]  do_thaw_all+0x1b/0x30
> [  182.614759]  process_scheduled_works+0xbb/0x3f0
> [  182.615150]  ? __pfx_worker_thread+0x10/0x10
> [  182.615499]  worker_thread+0x129/0x270
> [  182.615816]  ? __pfx_worker_thread+0x10/0x10
> [  182.616201]  kthread+0xe2/0x120
> [  182.616469]  ? __pfx_kthread+0x10/0x10
> [  182.616792]  ret_from_fork+0x15b/0x240
> [  182.617115]  ? __pfx_kthread+0x10/0x10
> [  182.617426]  ret_from_fork_asm+0x1a/0x30
> [  182.617761]  </TASK>
> [  182.617968] ---[ end trace 0000000000000000 ]---
> [  182.618412] Emergency Thaw complete
> 
> Fix this by switching to SUPER_ITER_UNLOCKED and acquiring s_umount
> in the callback via super_lock_excl() before calling
> thaw_super_locked(). This matches the locking pattern expected by
> thaw_super_locked() and eliminates the double unlock.
> 
> While at it, remove the dead 'return;' at the end of
> do_thaw_all_callback().
> 
> Fixes: b47e42d10e8c ("super: use common iterator (Part 2)")
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index a8fd61136aaf..70dcb07e7fa5 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1084,16 +1084,19 @@ void emergency_remount(void)
>  
>  static void do_thaw_all_callback(struct super_block *sb, void *unused)
>  {
> +	if (!super_lock_excl(sb))
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_BLOCK))
>  		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
>  			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
> +
>  	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
> -	return;
>  }
>  
>  static void do_thaw_all(struct work_struct *work)
>  {
> -	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_EXCL);
> +	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_UNLOCKED);
>  	kfree(work);
>  	printk(KERN_WARNING "Emergency Thaw complete\n");
>  }
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
