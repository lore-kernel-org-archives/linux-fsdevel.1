Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334A3FE371
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804854; cv=none; b=BuxwDba4mrcigu7uou1H20fuw2lOtPe3ccgqf7UtXV9soUIjNCLyclUMor/tprnRjjGEYbIV3J1H8Dsr2dzsqZpyvgf3AtCneGWUZcmnI/CcoD0eOUgXYJYZKNn4E5zM4w379fcYB4x9L4m2KQKIKoLceN9CesOcAts1xlCy/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804854; c=relaxed/simple;
	bh=OwmLYEZCuHKe18daqP7WmvbRRqhqfso/ejQfXfF2CAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNVNgkHAwgFnuhE3QulpuvXLJSfN+/PZNgf/tK1QruvUi791QcIs6X6DG4vUguZ+EbG7W7p9pFj9/s7GOkIFW1k/LIW5V02zyGBYsDXQCMojivH+nLrAZzutLrElhcuhgbMx8zC4zJ1bE8Rl09TaYzLSOkh00UWlSA/E9HvvnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKChdlCK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WP343+IE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKChdlCK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WP343+IE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKChdlCK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WP343+IE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKChdlCK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WP343+IE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 139696B43C;
	Tue, 26 May 2026 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779804851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6pq7mzk8rDa4F1mBhamlz3pyk/MIS4amE39vNRXPM=;
	b=uKChdlCKQQ6v+gq+ibbh5cMuS/wybmtH2KcSezWr2Rij3M5WMic//ffVffC+H+Yc582SS2
	C6qgRkHKhIsJhwIZIJHFOTw76gegJTvToMZPU41YvjfwsyEGVVkrWJYSG9HTnWTfhbaM4l
	hujHi8A29MK7loCglDoVtUI8By+go74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779804851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6pq7mzk8rDa4F1mBhamlz3pyk/MIS4amE39vNRXPM=;
	b=WP343+IEAQcsH8w01xqJgSm3nQWx7qHkEBJfcAU/DIa9aJfBXmKjtvlKi5nH0Q+9AVmeSW
	IROd5pU1ZL683ADA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779804851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6pq7mzk8rDa4F1mBhamlz3pyk/MIS4amE39vNRXPM=;
	b=uKChdlCKQQ6v+gq+ibbh5cMuS/wybmtH2KcSezWr2Rij3M5WMic//ffVffC+H+Yc582SS2
	C6qgRkHKhIsJhwIZIJHFOTw76gegJTvToMZPU41YvjfwsyEGVVkrWJYSG9HTnWTfhbaM4l
	hujHi8A29MK7loCglDoVtUI8By+go74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779804851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6pq7mzk8rDa4F1mBhamlz3pyk/MIS4amE39vNRXPM=;
	b=WP343+IEAQcsH8w01xqJgSm3nQWx7qHkEBJfcAU/DIa9aJfBXmKjtvlKi5nH0Q+9AVmeSW
	IROd5pU1ZL683ADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F15C95A248;
	Tue, 26 May 2026 14:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HAvlOrKqFWqUIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 May 2026 14:14:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87A63A0EB6; Tue, 26 May 2026 16:14:06 +0200 (CEST)
Date: Tue, 26 May 2026 16:14:06 +0200
From: Jan Kara <jack@suse.cz>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Christian Brauner <christian@brauner.io>, 
	regressions@lists.linux.dev, Jan Kara <jack@suse.cz>
Subject: Re: Occasional 'WARNING: mm/backing-dev.c:636 at
 cgwb_release_workfn' when running mdadm
Message-ID: <mcm5gloab3zt5duszhtk4p472rsvmrhnesocg2n3kghqunwd5n@2izhebvb2gvo>
References: <CAMw=ZnSaVSzn1RGtiNRG+iNj8M1e12rZtA98i4jL8jYP5UyzWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnSaVSzn1RGtiNRG+iNj8M1e12rZtA98i4jL8jYP5UyzWg@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

Hi!

On Tue 26-05-26 13:01:11, Luca Boccassi wrote:
> Hi, I've been told to report this here.
> 
> In our CI test that runs some mdadm commands we occasionally (maybe 1
> in 100 runs, not reproducible manually) see the following kernel warn:
> 
> [ 15.769393] TEST-64-UDEV-STORAGE.sh[245]: + mdadm -v --stop /dev/md/mdparity
> [ 15.786033] ------------[ cut here ]------------
> [ 15.788632] !list_empty(&wb->b_attached)
> [ 15.788634] WARNING: mm/backing-dev.c:636 at

Thanks for report! Interesting. I haven't seen this yet but I suspect my
rework of cgwb inode switching (happened in 6.18) could be responsible for
this.

Since the 7.0.11 kernel we've got a couple of fixups to this code. In
particular 6689f01d6740 ("writeback: Fix use after free in
inode_switch_wbs_work_fn()") and now also fixes sitting in
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.2.writeback

Your script seems to be exercising mount/umount so the above fixes could
indeed be related to your problem. If you can run with a kernel built from
the above branch, it would be great if you can verify the problem got
indeed fixed.

								Honza

> cgwb_release_workfn+0x142/0x1f0, CPU#0: kworker/0:1/11
> [ 15.789235] Modules linked in: raid456 async_raid6_recov async_memcpy
> async_pq async_xor async_tx raid1 intel_rapl_msr intel_rapl_common
> kvm_amd ccp kvm joydev iTCO_wdt irqbypass mousedev intel_pmc_bxt
> ghash_clmulni_intel vfat i2c_i801 fat aesni_intel psmouse i2c_smbus
> intel_agp lpc_ich pcspkr i2c_mux virtio_balloon intel_gtt serio_raw
> mac_hid tun md_mod dm_mod qemu_fw_cfg vsock_loopback
> vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock
> virtio_rng
> [ 15.790846] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
> 7.0.10-arch1-1 #1 PREEMPT(full)
> b38726df0ec1c5aec6f05d4eab858505a5944d02
> [ 15.791457] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> Arch Linux 1.17.0-2-2 04/01/2014
> [ 15.791842] Workqueue: cgwb_release cgwb_release_workfn
> [ 15.792166] RIP: 0010:cgwb_release_workfn+0x142/0x1f0
> [ 15.792411] Code: f6 43 d8 01 75 2c 48 83 c4 08 48 89 df 48 c7 c6 00
> b2 a8 ba 5b 5d e9 0d 5d dc ff e8 f8 fd ff ff 48 8d 43 b8 48 39 43 b8
> 74 d6 <0f> 0b f6 43 d8 01 74 d4 0f 0b eb d0 48 89 04 24 e8 69 e6 db ff
> 48
> [ 15.793129] RSP: 0018:ffffccd280063e50 EFLAGS: 00010293
> [ 15.793401] RAX: ffff89eecbae4eb8 RBX: ffff89eecbae4f00 RCX: 0000000000000008
> [ 15.795755] RDX: ffff89eecbae4d80 RSI: 0000000000000202 RDI: ffff89eecae8a040
> [ 15.796172] RBP: ffff89eecae8a000 R08: 0000000000000001 R09: ffffccd28018e010
> [ 15.796560] R10: 0000000000000001 R11: fefefefefefefeff R12: ffff89ef3bc322c0
> [ 15.796889] R13: ffff89eec083c405 R14: 0000000000000000 R15: ffff89eecbae4f00
> [ 15.797298] FS: 0000000000000000(0000) GS:ffff89ef7e367000(0000)
> knlGS:0000000000000000
> [ 15.797637] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 15.797961] CR2: 000055cd8ab1d960 CR3: 0000000109878004 CR4: 0000000000370ef0
> [ 15.798319] Call Trace:
> [ 15.798454] <TASK>
> [ 15.798572] process_one_work+0x19c/0x3a0
> [ 15.798732] worker_thread+0x1b1/0x310
> [ 15.798896] ? __pfx_worker_thread+0x10/0x10
> [ 15.799164] kthread+0xe1/0x120
> [ 15.799330] ? __pfx_kthread+0x10/0x10
> [ 15.799536] ret_from_fork+0x2bc/0x350
> [ 15.799713] ? __pfx_kthread+0x10/0x10
> [ 15.800486] ret_from_fork_asm+0x1a/0x30
> [ 15.800666] </TASK>
> [ 15.800795] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [ 15.801089] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
> 7.0.10-arch1-1 #1 PREEMPT(full)
> b38726df0ec1c5aec6f05d4eab858505a5944d02
> [ 15.801553] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> Arch Linux 1.17.0-2-2 04/01/2014
> [ 15.801863] Workqueue: cgwb_release cgwb_release_workfn
> [ 15.802060] Call Trace:
> [ 15.802161] <TASK>
> [ 15.802264] dump_stack_lvl+0x5d/0x80
> [ 15.802440] vpanic+0x20a/0x410
> [ 15.802568] ? cgwb_release_workfn+0x142/0x1f0
> [ 15.802761] panic+0x6b/0x70
> [ 15.802905] check_panic_on_warn.cold+0xf/0x1e
> [ 15.803082] __warn.cold+0xa7/0x10c
> [ 15.803204] ? cgwb_release_workfn+0x142/0x1f0
> [ 15.803361] __report_bug+0x93/0x110
> [ 15.803492] ? cgwb_release_workfn+0x142/0x1f0
> [ 15.803681] ? cgwb_release_workfn+0x142/0x1f0
> [ 15.804541] report_bug+0x29/0x70
> [ 15.804701] handle_bug+0x167/0x360
> [ 15.804862] ? cgwb_release_workfn+0x142/0x1f0
> [ 15.805096] exc_invalid_op+0x1d/0x90
> [ 15.805255] asm_exc_invalid_op+0x1a/0x20
> [ 15.805449] RIP: 0010:cgwb_release_workfn+0x142/0x1f0
> [ 15.806398] Code: f6 43 d8 01 75 2c 48 83 c4 08 48 89 df 48 c7 c6 00
> b2 a8 ba 5b 5d e9 0d 5d dc ff e8 f8 fd ff ff 48 8d 43 b8 48 39 43 b8
> 74 d6 <0f> 0b f6 43 d8 01 74 d4 0f 0b eb d0 48 89 04 24 e8 69 e6 db ff
> 48
> [ 15.807217] RSP: 0018:ffffccd280063e50 EFLAGS: 00010293
> [ 15.808511] RAX: ffff89eecbae4eb8 RBX: ffff89eecbae4f00 RCX: 0000000000000008
> [ 15.808785] RDX: ffff89eecbae4d80 RSI: 0000000000000202 RDI: ffff89eecae8a040
> [ 15.809056] RBP: ffff89eecae8a000 R08: 0000000000000001 R09: ffffccd28018e010
> [ 15.809397] R10: 0000000000000001 R11: fefefefefefefeff R12: ffff89ef3bc322c0
> [ 15.809687] R13: ffff89eec083c405 R14: 0000000000000000 R15: ffff89eecbae4f00
> [ 15.809978] process_one_work+0x19c/0x3a0
> [ 15.810154] worker_thread+0x1b1/0x310
> [ 15.810325] ? __pfx_worker_thread+0x10/0x10
> [ 15.812450] kthread+0xe1/0x120
> [ 15.812594] ? __pfx_kthread+0x10/0x10
> [ 15.812738] ret_from_fork+0x2bc/0x350
> [ 15.812878] ? __pfx_kthread+0x10/0x10
> [ 15.813026] ret_from_fork_asm+0x1a/0x30
> [ 15.813179] </TASK>
> [ 15.813607] Kernel Offset: 0x39400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> I don't have hard data for when it started, but I don't think I've
> seen it for more than a couple of months tops. This one was on 7.0.10
> on Arch, but I think I've seen it on Rawhide too.
> 
> The test script that triggers it:
> https://github.com/systemd/systemd/blob/d096763827718083918244eb3b7796bf27876d56/test/units/TEST-64-UDEV-STORAGE.sh#L1191
> 
> Is this a known issue? Thanks
> 
> -- 
> Kind regards,
> Luca Boccassi
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
