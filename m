Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9304331EC0;
	Mon, 14 Sep 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371710; cv=none; b=iZXyzWqyGTpUHcqFZOqZGO4IB3S/nilpI5KksBE+f9ahN1eRbvU97HxnicCi5Jhbh/3tKPJUr9t6W3nuaXNFrDPmxT6P8Utkjm2gwgTwz7u6FoF2n33LAPWm4cavrA7vOD2Sv+JTFaqZL5ZLVCXj1gCB77T9A1vlwL0rDV8ttv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371710; c=relaxed/simple;
	bh=ht8/FRXAETsEd4KPkHqSgSvq92iODxU7+XfH9PRcdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4RQwf9g6TVftWe4iaUiba+iGEUSQ3YXX3FPDd9J7mz4zzDIdVUoDGZdyB7BUQt2Th4VtidhAPQkI5XeI+Qj4207Xg+ITUHYQxidOYI1sv19+pECSSQ4B0LWx2zuyYDDN9wwsDQJ7H8XZ0tK7e7X9kiXe8sYdnWjE57702O0Hig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QDsi3vq4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ssAYlhQB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tC6ipI+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oLSy3K5q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QDsi3vq4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ssAYlhQB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tC6ipI+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oLSy3K5q"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 538BF1F79C;
	Mon, 14 Sep 2026 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789371702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rrrR4P0V2oM3SBISC3miDX72YkqcrX041vhM2jZlFA=;
	b=QDsi3vq4psEoC2yKJfQZnleSS2pJNEucVoxCyMr2ppxz+ljF6JyYS4KJVlboyNzh3ClwUM
	+TYDOlov728UaVt0a/OdAQyZ4rYccWCJWEq2kGaqXn2upaPBJ6TgU0ViSQ1fEJsfUFp7Tp
	mKu+S5bcgsGPzAq4fd11uUzGdU1l7XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789371702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rrrR4P0V2oM3SBISC3miDX72YkqcrX041vhM2jZlFA=;
	b=ssAYlhQBpd8Zaj1B0+UA7Y4sMxpszvGajwjkH2/p1Yb2a8y8x0kpRjal3cXvhAQ2iAojSi
	EBH8kOAkzIp56DCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tC6ipI+1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oLSy3K5q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789371698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rrrR4P0V2oM3SBISC3miDX72YkqcrX041vhM2jZlFA=;
	b=tC6ipI+1yqeETm1nkFri4Q9FopEcj5W5buTT5dXH5vTS7tX/rt1QEroCLfsBNRgaGaI3kq
	ndqTMy2TliyKZUyVov+3Dn8DNEZqRppkJAyR6ZLPBaUzFWMFXBfVqv6ALUN/otGhs29FKE
	QXPxUt+hTcIzlNMe7k92+37NGIEofy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789371698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rrrR4P0V2oM3SBISC3miDX72YkqcrX041vhM2jZlFA=;
	b=oLSy3K5qVjHo13DTNgKTJ5T/2gRvY42xLYlFyMygGzj+G94vjE4T+JDZlJSkXiMAN/Eish
	g46k0kom05fLKqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A13913515;
	Mon, 14 Sep 2026 07:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8itBCjKlp2rGWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 07:41:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D9ABA079B; Mon, 14 Sep 2026 09:41:29 +0200 (CEST)
Date: Mon, 14 Sep 2026 09:41:29 +0200
From: Jan Kara <jack@suse.cz>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING in thaw_super_locked
Message-ID: <zl6u576no5nt44zfslopjeqpdohbdxe3wc6xi64pgimchky4wp@uryxferm7nw2>
References: <CA+0ovChM9=2RkQngMbBhyqiHn-f6bECUvocDvzbZm8AohRiVYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovChM9=2RkQngMbBhyqiHn-f6bECUvocDvzbZm8AohRiVYg@mail.gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 538BF1F79C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

Hello!

On Fri 11-09-26 08:51:25, Farhad Alemi wrote:
> We are reporting the following crash (reproducer attached):
> Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
> Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

I think this should be fixed by fe967191e585 ("fs: don't return -EINVAL for
successful nested thaw") in 7.3-rc3.

								Honza

> 
> [   50.331769][ T9500] sb->s_writers.freeze_kcount == 0
> [   50.331782][ T9500] WARNING: fs/super.c:2172 at
> thaw_super_locked+0x437/0x960, CPU#1: repro/9500
> [   50.337664][ T9500] Modules linked in:
> [   50.338411][ T9500] CPU: 1 UID: 0 PID: 9500 Comm: repro Not tainted
> 7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
> [   50.340359][ T9500] Hardware name: QEMU Standard PC (Q35 + ICH9,
> 2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> [   50.342404][ T9500] RIP: 0010:thaw_super_locked+0x437/0x960
> [   50.342962][ T9500] Code: ff 90 0f 0b 90 41 bf ea ff ff ff e9 7f 02
> 00 00 e8 be 5c 7b ff 90 0f 0b 90 41 bf ea ff ff ff e9 6b 02 00 00 e8
> aa 5c 7b ff 90 <0f> 0b 90 41 bf ea ff ff ff e9 57 02 00 00 e8 96 5c 7b
> ff 90 0f 0b
> [   50.344752][ T9500] RSP: 0018:ffffc90008eafa68 EFLAGS: 00010293
> [   50.345341][ T9500] RAX: ffffffff824c3fd6 RBX: ffff88810a876000
> RCX: ffff88802a25cc80
> [   50.346063][ T9500] RDX: 0000000000000000 RSI: 0000000000000000
> RDI: 0000000000000000
> [   50.346777][ T9500] RBP: ffff88810a876378 R08: ffff88810a87608f
> R09: 1ffff1102150ec11
> [   50.347500][ T9500] R10: dffffc0000000000 R11: ffffed102150ec12
> R12: 0000000000000001
> [   50.348223][ T9500] R13: 0000000000000000 R14: ffff88810a87637c
> R15: 0000000000000001
> [   50.348941][ T9500] FS:  00000000028c2400(0000)
> GS:ffff8881da588000(0000) knlGS:0000000000000000
> [   50.349778][ T9500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.350384][ T9500] CR2: 000055c32878aae0 CR3: 000000010adda000
> CR4: 0000000000752ef0
> [   50.351219][ T9500] PKRU: 55555554
> [   50.351570][ T9500] Call Trace:
> [   50.351913][ T9500]  <TASK>
> [   50.352195][ T9500]  filesystems_thaw_callback+0x1b8/0x2f0
> [   50.352713][ T9500]  __iterate_supers+0x2ce/0x420
> [   50.353193][ T9500]  ? __pfx_filesystems_thaw_callback+0x10/0x10
> [   50.353784][ T9500]  ? __pfx___iterate_supers+0x10/0x10
> [   50.354334][ T9500]  ? schedule+0x16e/0x2b0
> [   50.354806][ T9500]  pm_suspend+0x58c/0x760
> [   50.355245][ T9500]  state_store+0x206/0x290
> [   50.355693][ T9500]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   50.356209][ T9500]  kernfs_fop_write_iter+0x3af/0x540
> [   50.356698][ T9500]  vfs_write+0x61d/0xb90
> [   50.357098][ T9500]  ? __pfx_vfs_write+0x10/0x10
> [   50.357544][ T9500]  ? do_sys_openat2+0x14e/0x200
> [   50.357997][ T9500]  ? kmem_cache_free+0x182/0x650
> [   50.358460][ T9500]  ksys_write+0x150/0x270
> [   50.358866][ T9500]  ? __pfx_ksys_write+0x10/0x10
> [   50.359604][ T9500]  do_syscall_64+0x155/0x510
> [   50.360070][ T9500]  ? trace_irq_disable+0x3b/0x140
> [   50.360560][ T9500]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   50.361196][ T9500]  ? clear_bhb_loop+0x30/0x80
> [   50.361655][ T9500]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   50.362218][ T9500] RIP: 0033:0x42e806
> [   50.362588][ T9500] Code: 47 ba 04 00 00 00 48 c7 c0 f0 ff ff ff 64
> 89 10 48 c7 c2 ff ff ff ff c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48
> 8b 45 10 0f 05 <48> 89 c2 48 3d 00 f0 ff ff 77 0f c9 48 89 d0 c3 66 2e
> 0f 1f 84 00
> [   50.364338][ T9500] RSP: 002b:00007ffec5fbaa00 EFLAGS: 00000202
> ORIG_RAX: 0000000000000001
> [   50.365096][ T9500] RAX: ffffffffffffffda RBX: 0000000000000001
> RCX: 000000000042e806
> [   50.365817][ T9500] RDX: 0000000000000003 RSI: 00000000004880f9
> RDI: 0000000000000004
> [   50.366529][ T9500] RBP: 00007ffec5fbaa10 R08: 0000000000000000
> R09: 0000000000000000
> [   50.367283][ T9500] R10: 0000000000000000 R11: 0000000000000202
> R12: 00007ffec5fbaba8
> [   50.368042][ T9500] R13: 00007ffec5fbabb8 R14: 0000000000000002
> R15: 00000000004af120
> [   50.368775][ T9500]  </TASK>
> [   50.369071][ T9500] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [   50.369727][ T9500] CPU: 1 UID: 0 PID: 9500 Comm: repro Not tainted
> 7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
> [   50.370770][ T9500] Hardware name: QEMU Standard PC (Q35 + ICH9,
> 2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> [   50.371772][ T9500] Call Trace:
> [   50.372100][ T9500]  <TASK>
> [   50.372373][ T9500]  vpanic+0x56d/0xa60
> [   50.372745][ T9500]  ? __pfx__printk+0x10/0x10
> [   50.373177][ T9500]  ? __pfx_vpanic+0x10/0x10
> [   50.373593][ T9500]  ? is_bpf_text_address+0x292/0x2b0
> [   50.374086][ T9500]  ? is_bpf_text_address+0x26/0x2b0
> [   50.374586][ T9500]  panic+0xc5/0xd0
> [   50.374938][ T9500]  ? __pfx_panic+0x10/0x10
> [   50.375357][ T9500]  __warn+0x315/0x4c0
> [   50.375725][ T9500]  ? thaw_super_locked+0x437/0x960
> [   50.376198][ T9500]  ? thaw_super_locked+0x437/0x960
> [   50.376687][ T9500]  __report_bug+0x273/0x580
> [   50.377135][ T9500]  ? thaw_super_locked+0x437/0x960
> [   50.377628][ T9500]  ? __pfx___report_bug+0x10/0x10
> [   50.378137][ T9500]  ? thaw_super_locked+0x437/0x960
> [   50.378604][ T9500]  report_bug+0x16b/0x220
> [   50.379010][ T9500]  ? thaw_super_locked+0x437/0x960
> [   50.379479][ T9500]  ? thaw_super_locked+0x439/0x960
> [   50.379951][ T9500]  handle_bug+0x9c/0x200
> [   50.380350][ T9500]  exc_invalid_op+0x1a/0x50
> [   50.380870][ T9500]  asm_exc_invalid_op+0x1a/0x20
> [   50.381338][ T9500] RIP: 0010:thaw_super_locked+0x437/0x960
> [   50.381890][ T9500] Code: ff 90 0f 0b 90 41 bf ea ff ff ff e9 7f 02
> 00 00 e8 be 5c 7b ff 90 0f 0b 90 41 bf ea ff ff ff e9 6b 02 00 00 e8
> aa 5c 7b ff 90 <0f> 0b 90 41 bf ea ff ff ff e9 57 02 00 00 e8 96 5c 7b
> ff 90 0f 0b
> [   50.383638][ T9500] RSP: 0018:ffffc90008eafa68 EFLAGS: 00010293
> [   50.384194][ T9500] RAX: ffffffff824c3fd6 RBX: ffff88810a876000
> RCX: ffff88802a25cc80
> [   50.384929][ T9500] RDX: 0000000000000000 RSI: 0000000000000000
> RDI: 0000000000000000
> [   50.385692][ T9500] RBP: ffff88810a876378 R08: ffff88810a87608f
> R09: 1ffff1102150ec11
> [   50.386447][ T9500] R10: dffffc0000000000 R11: ffffed102150ec12
> R12: 0000000000000001
> [   50.387164][ T9500] R13: 0000000000000000 R14: ffff88810a87637c
> R15: 0000000000000001
> [   50.387916][ T9500]  ? thaw_super_locked+0x436/0x960
> [   50.388413][ T9500]  ? thaw_super_locked+0x436/0x960
> [   50.388920][ T9500]  filesystems_thaw_callback+0x1b8/0x2f0
> [   50.389463][ T9500]  __iterate_supers+0x2ce/0x420
> [   50.389916][ T9500]  ? __pfx_filesystems_thaw_callback+0x10/0x10
> [   50.390474][ T9500]  ? __pfx___iterate_supers+0x10/0x10
> [   50.391077][ T9500]  ? schedule+0x16e/0x2b0
> [   50.391503][ T9500]  pm_suspend+0x58c/0x760
> [   50.391933][ T9500]  state_store+0x206/0x290
> [   50.392346][ T9500]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   50.393100][ T9500]  kernfs_fop_write_iter+0x3af/0x540
> [   50.393612][ T9500]  vfs_write+0x61d/0xb90
> [   50.394039][ T9500]  ? __pfx_vfs_write+0x10/0x10
> [   50.394494][ T9500]  ? do_sys_openat2+0x14e/0x200
> [   50.394946][ T9500]  ? kmem_cache_free+0x182/0x650
> [   50.395406][ T9500]  ksys_write+0x150/0x270
> [   50.395808][ T9500]  ? __pfx_ksys_write+0x10/0x10
> [   50.396264][ T9500]  do_syscall_64+0x155/0x510
> [   50.396691][ T9500]  ? trace_irq_disable+0x3b/0x140
> [   50.397157][ T9500]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   50.397706][ T9500]  ? clear_bhb_loop+0x30/0x80
> [   50.398141][ T9500]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   50.398702][ T9500] RIP: 0033:0x42e806
> [   50.399085][ T9500] Code: 47 ba 04 00 00 00 48 c7 c0 f0 ff ff ff 64
> 89 10 48 c7 c2 ff ff ff ff c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48
> 8b 45 10 0f 05 <48> 89 c2 48 3d 00 f0 ff ff 77 0f c9 48 89 d0 c3 66 2e
> 0f 1f 84 00
> [   50.400946][ T9500] RSP: 002b:00007ffec5fbaa00 EFLAGS: 00000202
> ORIG_RAX: 0000000000000001
> [   50.401732][ T9500] RAX: ffffffffffffffda RBX: 0000000000000001
> RCX: 000000000042e806
> [   50.402465][ T9500] RDX: 0000000000000003 RSI: 00000000004880f9
> RDI: 0000000000000004
> [   50.403178][ T9500] RBP: 00007ffec5fbaa10 R08: 0000000000000000
> R09: 0000000000000000
> [   50.403894][ T9500] R10: 0000000000000000 R11: 0000000000000202
> R12: 00007ffec5fbaba8
> [   50.404618][ T9500] R13: 00007ffec5fbabb8 R14: 0000000000000002
> R15: 00000000004af120
> [   50.405337][ T9500]  </TASK>
> [   50.405933][ T9500] Kernel Offset: disabled
> [   50.406477][ T9500] Rebooting in 86400 seconds..
> 
> Regards,


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
