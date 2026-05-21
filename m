Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE43B9DA6;
	Thu, 21 May 2026 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352665; cv=none; b=W3WMC05HfUiXmrJOF0oGoX32tJklVmODUnKUitdGL8xITDngdGLk0VA7KdAaSGePN6bDxDwJMNxW9BikaGT3eRluy1+qXunFECs++hxoYx7NgmfmlSEk2i8UnStzef6gJV5mIViDoEc66cuDMpNAVdZZxXwvjQ6LuHgH8ibIKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352665; c=relaxed/simple;
	bh=37Telx0kdny/9Dqsg1xQ6Ybqaso8SR5vj4yXRWRQsHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjIGDoHRWJq6d4fhrPXMM7oOG+/2CwqOjpjDiNrpgGFVCTopHgbGKCAGldMRsapl7WIkgnYlgr45q1iSvysDqCO4+mdekDZ+5rQ5W5mjUIEdtS5RkGUD8zxusPAfX3RMUcDgRoSiHwQFkYm+r9FEbCD3cLLZCu7VsOtYu0i6lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fd2LJfSI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUKViOfR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fd2LJfSI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUKViOfR"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779352650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKP6HnerjYp67jD5rKd+ICyVn/q5MCvXJfLOiwXj2+k=;
	b=fd2LJfSIHXLBVLtiO4Qf4iD9xKG4IrBFqKs1dPjoRFHHvwAM0Jh0OHEm/g1AR/guaZp51Y
	8m/t05RHoCEU5wXEuWjDtEESLWfqsYb9ZmxnTxCZ72U21eAKdjhM1yOeQlrB4NtIXMXYnN
	Vg99ehjQl7HknHLtpZSnbJ2e/vC5FI63ZYkv34fT+6jDDEz5KJPf4ZNFdftT4nxrsnT/hi
	KKl65dZpfufEh47Nl0O44jBMD90aVu3ujC8MNwsQy8pPnsHKJyCKYsji2vb6sLf8zaaU3V
	I5SKNMExMT8DTF7ozhUz/USgO9R1qe3IC1unytqK61P8Ek7dGkz5HLUVKnu9lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779352650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKP6HnerjYp67jD5rKd+ICyVn/q5MCvXJfLOiwXj2+k=;
	b=OUKViOfRVtuD6P838v7dTqdRUQMnOi+2e+yuSEsPkeWTV/d3/5uFSz/C/9/Kvs7sYUlKcj
	RZqHir1ruTONV8AA==
To: Bert Karwatzki <spasswolf@web.de>, Christian Brauner <brauner@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, mjguzik@gmail.com, adobriyan@gmail.com,
 jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
In-Reply-To: <20260520225245.2962-1-spasswolf@web.de>
References: <20260520225245.2962-1-spasswolf@web.de>
Date: Thu, 21 May 2026 10:37:29 +0200
Message-ID: <87h5o1w43a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bert!

On Thu, May 21 2026 at 00:52, Bert Karwatzki wrote:
> Since version next-20260518 (with PREEMPT_RT) I noticed that my debian stable/trixie system
> would sometimes hang when booting displaying the following error message. After about ~1min
> booting continues to a rescue shell where I could save the dmesg output (The output shown 
> here is not from next-20260519 but from a step in the bisection).
>
> [    2.900440] [    T709] ------------[ cut here ]------------
> [    2.900441] [    T709] Voluntary context switch within RCU read-side critical section!
> [    2.900441] [    T709] WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note_context_switch+0x2ac/0x460, CPU#4: systemd-fstab-g/709
> [    2.900447] [    T709] Modules linked in: efivarfs autofs4 ext4 mbcache jbd2 hid_generic usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched xhci_pci amdxcp drm_display_helper xhci_hcd drm_kms_helper ahci libahci drm libata usbcore nvme scsi_mod nvme_core igc video i2c_piix4 cec nvme_keyring i2c_smbus usb_common scsi_common crc16 nvme_auth wmi gpio_amdpt gpio_generic
> [    2.900456] [    T709] CPU: 4 UID: 0 PID: 709 Comm: systemd-fstab-g Not tainted 7.1.0-rc4-bisect-02057-g134bedf6b3e5 #452 PREEMPT_RT 
> [    2.900457] [    T709] Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> [    2.900458] [    T709] RIP: 0010:rcu_note_context_switch+0x2ac/0x460
> [    2.900459] [    T709] Code: ef e8 58 56 87 00 48 8b 55 28 b9 01 00 00 00 4c 89 ef c6 45 11 00 48 89 c6 e8 e0 99 ff ff e9 cd fd ff ff 48 8d 3d 84 8a de 00 <67> 48 0f b9 3a e9 89 fd ff ff a9 a0 20 00 00 0f 85 df 00 00 00 f6
> [    2.900460] [    T709] RSP: 0018:ffffb538c1e3fb98 EFLAGS: 00010002
> [    2.900461] [    T709] RAX: 0000000000000001 RBX: ffff9bd494a0db00 RCX: 0000000000000000
> [    2.900462] [    T709] RDX: 0000000000000000 RSI: ffffffffb27ad182 RDI: ffffffffb2d29400
> [    2.900462] [    T709] RBP: ffff9be33f326b00 R08: ffffeba64492bec0 R09: ffff9bd491ed1100
> [    2.900462] [    T709] R10: 0000000000000001 R11: ffffeba64492bec0 R12: 0000000000000000
> [    2.900462] [    T709] R13: 0000000000000000 R14: ffff9bd494a0db00 R15: ffffb538c1e3fcc0
> [    2.900463] [    T709] FS:  00007f0367aaf9c0(0000) GS:ffff9be38c475000(0000) knlGS:0000000000000000
> [    2.900464] [    T709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.900464] [    T709] CR2: 00007f082baae1d4 CR3: 0000000111ff2000 CR4: 0000000000f50ef0
> [    2.900464] [    T709] PKRU: 55555554
> [    2.900465] [    T709] Call Trace:
> [    2.900466] [    T709]  <TASK>
> [    2.900466] [    T709]  ? __schedule+0x78/0xe50
> [    2.900469] [    T709]  ? blk_finish_plug+0x23/0x40
> [    2.900472] [    T709]  ? read_pages+0x17f/0x210
> [    2.900474] [    T709]  ? schedule+0x22/0xd0
> [    2.900475] [    T709]  ? io_schedule+0x41/0x60
> [    2.900476] [    T709]  ? folio_wait_bit_common+0x10d/0x2f0
> [    2.900477] [    T709]  ? filemap_invalidate_unlock_two+0x40/0x40
> [    2.900478] [    T709]  ? filemap_fault+0x7a1/0xfc0
> [    2.900479] [    T709]  ? __do_fault+0x30/0x90
> [    2.900480] [    T709]  ? do_fault+0x3a9/0x5a0
> [    2.900481] [    T709]  ? __handle_mm_fault+0x2c6/0x3a0
> [    2.900482] [    T709]  ? handle_mm_fault+0xdc/0x2c0
> [    2.900483] [    T709]  ? do_user_addr_fault+0x1e2/0x5f0
> [    2.900485] [    T709]  ? exc_page_fault+0x49/0x70
> [    2.900486] [    T709]  ? asm_exc_page_fault+0x26/0x30
> [    2.900487] [    T709]  </TASK>

That's a user page fault, which means something (syscall or interrupt)
exited to user space with RCU read side held.

> With the good and bad commits this close I took a look at
> git log --oneline 43467cbc2260..eda8cb3fb0cb
> and found exactly one RCU related commit:
> dc651e25a6d2 ("fs: RCU-ify filesystems list")
>
> So I reverted the this commit in next-20260519 (to get a clean revert I needed to
> revert commit
> 36b3306779ea ("fs: cache the string generated by reading /proc/filesystems") first.
>
> $ git log --oneline
> c7321982a5d0 (HEAD -> rcu_critical_readside_bug) Revert "fs: RCU-ify filesystems list"
> 16ff8d6e7c28 Revert "fs: cache the string generated by reading /proc/filesystems"
> 6a50ba100ace (tag: next-20260519, origin/master, origin/HEAD, master) Add linux-next specific files for 20260519
>
> With these reverts next-20260519 boots 30 times in a row without error, so
> it appears that commit dc651e25a6d2 ("fs: RCU-ify filesystems list") causing the
> error.
>
> To see if this issue is PREEMPT_RT only I also tested next-20260519 *without* PREEMPT_RT
> and got a different bug at my first boot (the second boot worked, the third failed again)
>
> In the non-RT case there's no rescue shell so this error message is copied from a (bad) photo:
>
> [ 2.823291][ T510] BUG: scheduling while atomic: sytemd-hiberna/510
> [ 2.824837][ T504] /usr/lib/systemd/system-generators/systemd-hibernate-resume-generator terminated by signal SEGV
> BUG: scheduling while atomic: sytemd-hiberna/510
> Call Trace:
> dump_stack_lvl
> __schedule_bug.cold
> [...]
> asm_exc_page_fault
> Code: unable to access opcode bytes at 0x7f243337e216
>
> To see if the non-RT error is caused by the same commit as the RT error I tested
> next-20260519 with the reverts and *without* PREEMPT_RT. With the reverts there was
> no error in 20 boots. So the problem in the non-RT and RT case seem to be caused by
> the same commits.

Which is not surprising, though on a quick inspection of the commit in
question I can't see where it would leak the RCU read side.

Can you please enable lockdep? That should tell us what exits to user
space with RCU held and also where the RCU read side was acquired.

Btw, which compiler are you using?

Thanks,

        tglx
 
