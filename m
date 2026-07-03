Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0830DEAC;
	Fri,  3 Jul 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058407; cv=none; b=EYnTqgMJzGBMqr8ZuILPsK3JN2SF2HX65SYLb4f73XGO5bhncazrFTKBVyWInMikzc+FdLbuqotc850HCfBjLooDecCtK5RoRCQHSvIVOuPfohWX2ioi/N0uZhUpHiRb6OpP6L0Nf7UNAJW5ygFtVCt1CI1U5KfswuMLSIee2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058407; c=relaxed/simple;
	bh=44a/x5neNBvJ2eZ2QffSZVSDPv21jf1NSzCZyuOnm0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WoXrCsKMbI9Rx7A9Q9nnl6Gnz3d6k0+6Dpv5IMRYkdlrWcsnFkbzgJbB6HfMP+kIU0uA/PMKomHAqWojz3slfHF19xh+JBurj59iQJ+Dj6ljeQEbi5p78nfwFoeldIMezOhJnm14Ja35rjh2bNFyEX2DHrDPAwWtbbcncNDbvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=5nzq+c4Z; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=15pMPZtm; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="5nzq+c4Z";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="15pMPZtm"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id BA0BC26F7664;
	Fri,  3 Jul 2026 14:51:26 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1783057887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9UNP8jNYEakHdt1Pgo229r/F1PeZtT2m9buIneR9Co=;
	b=5nzq+c4Z7Sj2hxyagOc1DVO5imb8tyYSlkffG87/RZDgzaZzsqrjlA74aMkuB1RYGyXqFL
	2+0XfZYETHsxj/EtBbxdfD8055QpYHiMLcYzvn2h1st79oH8+P8QKm8nvFIDyvOr1qpPMR
	LKxTjB7CgAgsKTQjgVppCLbNjW84Xemskz2mkTmeiL8v5h36ZhqveusfJ5x3UrTQYR2b6w
	cL7nXfja6FWQNBAGS2PicMXv+movva7pY/PkBakzFPONfFkKccmtQohcvlogTzR0e6gJpR
	D5yVZ1vtz2bXR/KFCE7EJIsGJpUfA6/n0qsOh/zqjOQT7W/v8XTar1SvUZcwEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1783057887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9UNP8jNYEakHdt1Pgo229r/F1PeZtT2m9buIneR9Co=;
	b=15pMPZtm+MHY5HpInlhXA6GsH78onPrr3YWJOGPAKsbosaWqz6uWQlETLjxvh3H2byStPZ
	y4kMQFHr9NZE7FDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 418B9E001AF;
	Fri, 03 Jul 2026 14:51:26 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 3929F22000FA; Fri, 03 Jul 2026 14:51:26 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: syzbot <syzbot+e9aa2f4bc3623d1be5cf@syzkaller.appspotmail.com>
Cc: linkinjeon@kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  sj1557.seo@samsung.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KCSAN: data-race in
 copy_folio_from_iter_atomic / fat12_ent_put (5)
In-Reply-To: <6a470719.6912059f.e0473.0007.GAE@google.com>
References: <6a470719.6912059f.e0473.0007.GAE@google.com>
Date: Fri, 03 Jul 2026 14:51:26 +0900
Message-ID: <87fr20sjs1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+e9aa2f4bc3623d1be5cf@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    665159e24674 Merge tag 'probes-fixes-v7.2-rc1' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1484b146580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
> dashboard link: https://syzkaller.appspot.com/bug?extid=e9aa2f4bc3623d1be5cf
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/31c1c90dee17/disk-665159e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d073e04a63f4/vmlinux-665159e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0421e67defd8/bzImage-665159e2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e9aa2f4bc3623d1be5cf@syzkaller.appspotmail.com

Quick look though, this looks like the temporary state that will be
fixed later. The loop copies from req buffer while fat modifying, but
fat is dirtied after this, and rewrite with complete data later.

Thanks.

> ==================================================================
> BUG: KCSAN: data-race in copy_folio_from_iter_atomic / fat12_ent_put
>
> write to 0xffff888121f76082 of 1 bytes by task 6014 on cpu 1:
>  fat12_ent_put+0x74/0x180 fs/fat/fatent.c:168
>  fat_alloc_clusters+0x55e/0xc40 fs/fat/fatent.c:508
>  fat_add_cluster fs/fat/inode.c:108 [inline]
>  __fat_get_block fs/fat/inode.c:155 [inline]
>  fat_get_block+0x252/0x5e0 fs/fat/inode.c:190
>  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2123
>  block_write_begin fs/buffer.c:2234 [inline]
>  cont_write_begin+0x5bf/0x920 fs/buffer.c:2596
>  fat_write_begin+0x52/0xe0 fs/fat/inode.c:230
>  cont_expand_zero fs/buffer.c:2524 [inline]
>  cont_write_begin+0x18d/0x920 fs/buffer.c:2586
>  fat_write_begin+0x52/0xe0 fs/fat/inode.c:230
>  generic_cont_expand_simple+0xb0/0x150 fs/buffer.c:2487
>  fat_cont_expand+0x3e/0x170 fs/fat/file.c:227
>  fat_fallocate+0x177/0x1c0 fs/fat/file.c:305
>  vfs_fallocate+0x3ac/0x400 fs/open.c:338
>  ksys_fallocate fs/open.c:362 [inline]
>  __do_sys_fallocate fs/open.c:367 [inline]
>  __se_sys_fallocate fs/open.c:365 [inline]
>  __x64_sys_fallocate+0x7a/0xd0 fs/open.c:365
>  x64_sys_call+0x298e/0x3020 arch/x86/include/generated/asm/syscalls_64.h:286
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888121f76000 of 512 bytes by task 49 on cpu 0:
>  memcpy_from_iter lib/iov_iter.c:85 [inline]
>  iterate_bvec include/linux/iov_iter.h:123 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
>  iterate_and_advance include/linux/iov_iter.h:330 [inline]
>  __copy_from_iter lib/iov_iter.c:261 [inline]
>  copy_folio_from_iter_atomic+0x728/0x10a0 lib/iov_iter.c:491
>  generic_perform_write+0x2c4/0x490 mm/filemap.c:4376
>  shmem_file_write_iter+0xc5/0xf0 mm/shmem.c:3414
>  lo_rw_aio+0x6a9/0x760 drivers/block/loop.c:-1
>  do_req_filebacked drivers/block/loop.c:-1 [inline]
>  loop_handle_cmd drivers/block/loop.c:1921 [inline]
>  loop_process_work+0x567/0xac0 drivers/block/loop.c:1956
>  loop_workfn+0x31/0x40 drivers/block/loop.c:1980
>  process_one_work kernel/workqueue.c:3322 [inline]
>  process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
>  worker_thread+0x569/0x750 kernel/workqueue.c:3486
>  kthread+0x221/0x270 kernel/kthread.c:436
>  ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 49 Comm: kworker/u8:3 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
> Workqueue: loop6 loop_workfn
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
