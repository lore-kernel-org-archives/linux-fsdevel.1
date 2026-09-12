Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6B34252D
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218751; cv=none; b=nHGZqDX/m6hwZZb2xUXpMSMcJGuarYC3FY+fkUjvbKDBFwDxbG1QAY2M7JGZnboGYlIcuZHDt3vjLviJzT542yoBGTo6OCIwRpdw7/JYzDlVn7HQkyCjH3Low62azSLsgNydx76n6rgluBViOZ2SKUdSGK9AyqMeCBAAFTj2nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218751; c=relaxed/simple;
	bh=pf8vft2OCRXfyVBhB/1xms9mjJbuVLOVRj6rx1v/t3o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MBCsv3ZfejCsWETvGcscENhST+aAj9llvn9ZQFUR1L+90EEuckWIgyB8cperLoTHnxWO3csRF1VRFm6IzJfyBor0DDBe9PNKn9QJzmWZuzoDI4JPNmJUt4uHdzY5WkAEDXBgZzl+keWbkVENjlvtxZCzghRI64V2tqaP/CKvOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6c037476275so1240397eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218748; x=1789823548;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OOOHAReRcyjsStR8QbdtPKY9OMu0/G8QzfemZB555nw=;
        b=OWuzXkp7vztZubEk/hAFsfxVSctngbibIYSSrYlGjQcUBd+T7EiHGXD7/TgNDe1t3i
         4b5NThJnWRmwFHjw3j9eOb419C6fnzF1Qr3wn4h4Z5ryCS/KznVopQUgxN7jCS/ftKgf
         xWXq1P+ak9Ly3AIpxJ+JCDv0C5FtENvb7irjBaFIC8mcW6jflw5Cz2GCLKOBQ3C/OSJe
         HDRSQaEVSGjjwo9WdWl+GEKsxbDMHSdRsESH87V0xYh05SsVJ5Vsvx7T4XaHAq5uz+Et
         xy3UoSuo+fEAs8LDeYN8dnaRnOVIAurmNHu9YdSsa4lqQrLLO2OdSCknHk/txvobO1hv
         0lkQ==
X-Forwarded-Encrypted: i=1; AKwUvBynPCTXZrwm+p3nSY9Fz7aRsQcluF4NA9Y+p0G3BR2e4+B1gV6byYpbFh0BM01NJQZlc82NXtZQw4Jte+rH@vger.kernel.org
X-Gm-Message-State: AFuF++l26BD7VWqwAIFQApb9ZvXCSr4YQxR7ROjqpQlI0DfXS6dGC9C9
	PB9TN9E+02FY6BPKV3RABC5go15hHcvtMTHJtHyngw6kNTLOZa8XEpe2D2T3OUcIY8Gc+ubvtnJ
	AWwAeyvDPAw8JEjYNO8vjvuepUufevbaGGHbdUwnJH0kH/QNwi3oz4idScVM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2083:b0:6c2:3441:9b03 with SMTP id
 006d021491bc7-6c24ceaf609mr1530618eaf.21.1789218748306; Sat, 12 Sep 2026
 06:12:28 -0700 (PDT)
Date: Sat, 12 Sep 2026 06:12:28 -0700
In-Reply-To: <6aa178fc.f2639fcc.29487d.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa54fbc.f2639fcc.29487d.003d.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
From: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5225b8eec4c9 mailmap: update entry for Jens Axboe
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104c82d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144c82d1580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com

block2mtd: error: cannot open device /tmp/ovl_bug_7ivaQs/merged/nonexistent
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor469/6041 is trying to acquire lock:
ffff888024d8c460 (sb_writers#6){.+.+}-{0:0}, at: ovl_create_object+0x130/0x3b0 fs/overlayfs/dir.c:705

but task is already holding lock:
ffff88805802a7a8 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff88805802a7a8 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: lookup_open+0xb13/0x1990 fs/namei.c:4458

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       inode_lock_shared include/linux/fs.h:1039 [inline]
       lookup_slow+0x42/0x70 fs/namei.c:1935
       walk_component fs/namei.c:2282 [inline]
       lookup_last fs/namei.c:2789 [inline]
       path_lookupat+0x5e8/0xc40 fs/namei.c:2813
       filename_lookup+0x202/0x590 fs/namei.c:2842
       kern_path+0x37/0x50 fs/namei.c:3036
       lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
       bdev_file_open_by_path+0x82/0x330 block/bdev.c:1123
       add_device drivers/mtd/devices/block2mtd.c:279 [inline]
       block2mtd_setup2.isra.0+0x2ee/0xbd0 drivers/mtd/devices/block2mtd.c:459
       block2mtd_setup+0xbd/0xd0 drivers/mtd/devices/block2mtd.c:476
       param_attr_store+0x199/0x300 kernel/params.c:591
       module_attr_store+0x58/0x80 kernel/params.c:906
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (param_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       kernel_param_lock kernel/params.c:604 [inline]
       param_attr_store+0xec/0x300 kernel/params.c:589
       module_attr_store+0x58/0x80 kernel/params.c:906
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&of->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
       iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pipe->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       pipe_lock fs/pipe.c:91 [inline]
       pipe_lock+0x69/0x80 fs/pipe.c:88
       iter_file_splice_write+0x1fd/0x10b0 fs/splice.c:682
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#6){.+.+}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       mnt_want_write+0x6f/0x420 fs/namespace.c:494
       ovl_create_object+0x130/0x3b0 fs/overlayfs/dir.c:705
       lookup_open+0x1255/0x1990 fs/namei.c:4567
       open_last_lookups fs/namei.c:4767 [inline]
       path_openat+0xa2c/0x2440 fs/namei.c:4997
       do_file_open+0x20e/0x430 fs/namei.c:5029
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_writers#6 --> param_lock --> &ovl_i_mutex_dir_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]);
                               lock(param_lock);
                               lock(&ovl_i_mutex_dir_key[depth]);
  rlock(sb_writers#6);

 *** DEADLOCK ***

locks held by syz-executor469/6041: 2, last CPU#2:
 #0: ffff88802a68c460 (sb_writers#13){.+.+}-{0:0}, at: lookup_open+0x150/0x1990 fs/namei.c:4451
 #1: ffff88805802a7a8 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #1: ffff88805802a7a8 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: lookup_open+0xb13/0x1990 fs/namei.c:4458

stack backtrace:
CPU: 2 UID: 0 PID: 6041 Comm: syz-executor469 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_write include/linux/fs/super.h:125 [inline]
 mnt_want_write+0x6f/0x420 fs/namespace.c:494
 ovl_create_object+0x130/0x3b0 fs/overlayfs/dir.c:705
 lookup_open+0x1255/0x1990 fs/namei.c:4567
 open_last_lookups fs/namei.c:4767 [inline]
 path_openat+0xa2c/0x2440 fs/namei.c:4997
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fadca23e437
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff380044d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055555dddf400 RCX: 00007fadca23e437
RDX: 0000000000000042 RSI: 00007fadca277192 RDI: ffffffffffffff9c
RBP: 00007fadca2770fe R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001a4 R11: 0000000000000202 R12: 000055555dde1770
R13: 0000000000000026 R14: 00007fff380045a0 R15: 0000000000000002
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
