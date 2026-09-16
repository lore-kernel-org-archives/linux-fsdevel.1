Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05B4AAC5E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573361; cv=none; b=GzBT8QeiJAg1oRi38EFBUrU44yEkjG8yj9omoA9tII1VmvMq8QhyinpPjMKJ39sg9FSK92XvDf1JAJvYkiDuSy2sBGcjvtqGIm7pfYYo6PVq36uSQ2G1c0RDbp0/Aw8dXlNpYewAoONMy8fHWF2ZhZFkTZsfaB2KYGnwJbW6cJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573361; c=relaxed/simple;
	bh=XtmNImX/5FFc4CPa3TkcFLuow3ei5FAnQFXOvKUJGgo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BDA96A0vrOgCliKwUtmDFYPqNdHhU/xmHcKFB9GdspJm8DjTpUYlBYRYbBUQdiIH6q0vtp9+BMtmDxkttrUYJ4Uv1d9FJQt+tTNB8fR4+vxQLLBwB0/META6EWTf1Njq762uKP+IWhvV8EtBqaDnuUW9JoWJyJUgIwJsXrKzbGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-47bbb846425so1772151fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 08:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573352; x=1790178152;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2Zr4D0P2DeY6uNjMgX/DVjNBdFFmJKnYEDUbNUQ4bU=;
        b=PizOB5940U2v3+Rekf2DaXlWdsWzAnlaWdv/DPHbmnn/dfYDH3dmndGhzhvt87/y5B
         fyuXnhhWyaTI3eo9LAwHorqbojaUpIczCfNZDgJMlaxo4TyWb06rfNEDXZIJ5t8EgYA3
         d/F/rL8u0jrH7BSoz94+8PAT0p9fDIKGTPm0STp88ObbTrRGKHkLlqsckrSl7ftn/1cC
         sIg2XyDNGRoBcZfyu2E0R+ueLDPW+epLs3u21rnwX5L1K6lqs55fPlaE/geXVuV6qOWm
         2RG7BbQisGyK9TNajiMVxGroC/TzgT1L3nQMZ8Uov5lKMfaQJE2naZneW94nyvUD73Qk
         71pA==
X-Gm-Message-State: AFuF++kX9XTP04T7QsoZeGcPLUrHVMEpx6+zteua7pUEfeKHlFtDXs8f
	bRe3Wrx9LnW0yeaOlNRgEqDpXGWLlXgkjMGbJSQ8zQEWvxEW/E++r2T3D1E58GPwtws7W4L4Fej
	1gyyBILVoR43ybS8H4Wdm4HNkerbTnRU/+jmvvUPbJdPn9rsxgGxHTWTdNlVoIQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a9:b0:4c2:c244:72f9 with SMTP id
 5614622812f47-4ca4bc74850mr4051592b6e.24.1789573352646; Wed, 16 Sep 2026
 08:42:32 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:42:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaab8e8.bbedf9ee.1860ea.0004.GAE@google.com>
Subject: [syzbot] [fs?] INFO: task hung in d_alloc_parallel (4)
From: syzbot <syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    704340f1cd0d Merge tag 'x86_urgent_for_7.3-rc4' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1585685e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=e8ebfecec06a009dd2d3
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1385685e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144248c9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1f812f889ad/disk-704340f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa4ccae83ac/vmlinux-704340f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f86a50bf181/bzImage-704340f1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f097ea8b67eb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com

INFO: task syz-executor239:5636 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor239 state:D stack:28744 pid:5636  tgid:5633  ppid:5632   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x16d9/0x5700 kernel/sched/core.c:7277
 __schedule_loop kernel/sched/core.c:7354 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7369
 d_wait_lookup fs/dcache.c:2754 [inline]
 d_alloc_parallel+0xd13/0x16c0 fs/dcache.c:2839
 __lookup_slow+0x82/0x2f0 fs/namei.c:1904
 lookup_slow+0x53/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 link_path_walk+0xd2a/0x1910 fs/namei.c:2656
 path_parentat fs/namei.c:2860 [inline]
 __filename_parentat+0x287/0x6f0 fs/namei.c:2884
 filename_parentat fs/namei.c:2902 [inline]
 filename_create+0xd9/0x370 fs/namei.c:5073
 filename_mkdirat+0xd2/0x520 fs/namei.c:5436
 __do_sys_mkdirat fs/namei.c:5464 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5461
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3765e43349
RSP: 002b:00007f3765def1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f3765eeae38 RCX: 00007f3765e43349
RDX: 00000000000001c0 RSI: 0000200000000640 RDI: 00000000ffffff9c
RBP: 00007f3765eeae30 R08: 00007f3765def6c0 R09: 35203a6b63617473
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000640
R13: 0030656c69662f2e R14: 0000200000000280 R15: 0000200000000540
 </TASK>

Showing all locks held in the system:
locks held by khungtaskd/37: 1, last CPU#0:
 #0: ffffffff8e1c3c80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8e1c3c80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1c3c80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by kworker/u8:7/1023: 2, on CPU#0:
 #0: ffff88813ff64138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88813ff64138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88813ff64138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88813ff64138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90005277c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90005277c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90005277c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90005277c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by getty/5350: 2, on CPU#1:
 #0: ffff888036d190a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900044d62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x460/0x1360 drivers/tty/n_tty.c:2211
locks held by syz-executor239/5635: 1, last CPU#1:
 #0: ffff888045d8bda0 (&type->i_mutex_dir_key#6){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:1039 [inline]
 #0: ffff888045d8bda0 (&type->i_mutex_dir_key#6){.+.+}-{4:4}, at: lookup_open+0x237/0x1a60 fs/namei.c:4460
locks held by syz-executor239/5636: 1, on CPU#0:
 #0: ffff888045d8bda0 (&type->i_mutex_dir_key#6){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:1039 [inline]
 #0: ffff888045d8bda0 (&type->i_mutex_dir_key#6){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1935

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 37 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/08/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5635 Comm: syz-executor239 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/08/2026
RIP: 0010:__might_sleep+0x31/0xf0 kernel/sched/core.c:9174
Code: 41 56 41 55 41 54 53 50 49 bf 00 00 00 00 00 fc ff df 65 48 8b 1d 87 17 0f 11 4c 8d 73 18 4c 89 f0 48 c1 e8 03 42 0f b6 04 38 <84> c0 0f 85 81 00 00 00 41 8b 2e 85 ed 74 2f 48 81 c3 90 18 00 00
RSP: 0018:ffffc90004c5f678 EFLAGS: 00000a02
RAX: 0000000000000000 RBX: ffff88801df83e80 RCX: ffff88801df83e80
RDX: 0000000000000000 RSI: 0000000000000142 RDI: ffffffff8d908f18
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff94000154819 R12: 0000000000000400
R13: 0000000000000400 R14: ffff88801df83e98 R15: dffffc0000000000
FS:  00007f3765e106c0(0000) GS:ffff888125ccb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd25a71f52 CR3: 000000002ec1a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 might_alloc include/linux/sched/mm.h:322 [inline]
 bdev_getblk+0xce/0x6e0 fs/buffer.c:1342
 __bread_gfp+0x89/0x380 fs/buffer.c:1400
 sb_bread include/linux/buffer_head.h:344 [inline]
 romfs_blk_strcmp fs/romfs/storage.c:175 [inline]
 romfs_dev_strcmp+0x3f8/0x790 fs/romfs/storage.c:284
 romfs_lookup+0x232/0x3f0 fs/romfs/super.c:234
 lookup_open+0x9eb/0x1a60 fs/namei.c:4528
 open_last_lookups fs/namei.c:4767 [inline]
 path_openat+0x67c/0x1d60 fs/namei.c:4997
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3765e43349
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3765e101d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3765eeae28 RCX: 00007f3765e43349
RDX: 0000000000000000 RSI: 0000200000000540 RDI: 00000000ffffff9c
RBP: 00007f3765eeae20 R08: 35203a6b63617473 R09: 35203a6b63617473
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000640
R13: 0030656c69662f2e R14: 0000200000000280 R15: 0000200000000540
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
