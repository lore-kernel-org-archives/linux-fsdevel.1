Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3692175A91
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781568747; cv=none; b=d6xWobbuAvSWiUh9GupfHnhI6++y8UXUuyzNKjIV660TxcDrPf8zaH46+gw8VZYK6yzLhp6WULaJldkMCiEEZOxLFKjI4QLf16vFz4ryZjHwoFuOKq5EJZMmB9kZjrlfFP3Aa28pxFOOEFffkJpB+Bg7G3IywrDPVN0q1e1ZekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781568747; c=relaxed/simple;
	bh=Q7/mRFxy0q8T21qT1e99U8/wb/jMv4L428XKzb/1++A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=no+34LCEmHk0B3PA7n/U2N+lBBY5nhHX0Z7AIgvEdwhs0tXBiHECjCPZiK04Ps5aQsHTugpxpE76111z2+XdxBiVxh6I6yI5M4XrmcHxbqytlX9Eyt9jrQmkz5HSzGToDtYQQ8jFC+OIQqQxl1a5L2bxNixftAt0ZzNnRX8qmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4863a0c3105so6581266b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 17:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781568744; x=1782173544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fFvbAhvGTJqgNXDel7BChR7iY0CTU5FL9l+rJRxn8A=;
        b=nZLI5SudKPhnf0nH5/ThtOj3xsWDQVoJ/3heMSsBpsPZ7JKfgjv0PY4zW7p1X4J0IW
         l5MrObdIxoLZFZ7n72Nf6rTCTeokwGSMYwZGE+jlgqKm/WIPeEGf0LLHJybhnPP45v1g
         ODjX+JjXKcD/jni2Z/3GYtkM9IQusUeyIAwx5FamhKaDOL5lOk/Bw8N7LGV9amAK+Qxr
         pB8RK8hrR5ic0C1PXipzLPERF/UbZJ6XNn/kCByktZ8/W3S3lWJ/MKavclxAI2wS9OAK
         U9sk7ng29/1/C7wthz0iSaRUQfZYixrF8vTGk+uASneaFjyNQqp1yueTwU9enb3n80ay
         OuPg==
X-Gm-Message-State: AOJu0YwAAxUtiGtX/F/OfkzA4bj9oB8CkvIkAi2PLv17zQYvLQCR2dHm
	xtQO9isZ1+YuRBPfslJWUqwtH3l6bFo8MyG8Fk2xCEMT75kAocW6MvsQhdSJIvGAC2kXgH23S0I
	/KqRWm714nhHmWOotfu7ybC/gtOFObEQarcrOLQM87bkJUxzJZ6ECP/veMM0c4Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3023:b0:467:1f38:bc1a with SMTP id
 5614622812f47-4884c0b95f7mr1032047b6e.7.1781568743905; Mon, 15 Jun 2026
 17:12:23 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:12:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3094e7.428ffe26.258b27.0171.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in dentry_kill
From: syzbot <syzbot+e514d3879b0ce2a189f1@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c425609d6ac4 Add linux-next specific files for 20260612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6f8ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7a56b1e89b63439
dashboard link: https://syzkaller.appspot.com/bug?extid=e514d3879b0ce2a189f1
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7fab9a8df61a/disk-c425609d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2577196651b/vmlinux-c425609d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/053557a7471e/bzImage-c425609d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e514d3879b0ce2a189f1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff888029bc58e0 by task syz-executor/13794

CPU: 1 UID: 0 PID: 13794 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5844
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 rt_mutex_slowunlock+0xbf/0xa20 kernel/locking/rtmutex.c:1430
 dentry_kill+0x520/0x880 fs/dcache.c:-1
 shrink_kill fs/dcache.c:1275 [inline]
 shrink_dentry_list+0x20c/0x320 fs/dcache.c:1292
 shrink_dcache_tree+0xe7/0x410 fs/dcache.c:1725
 shrink_dcache_parent fs/dcache.c:1767 [inline]
 d_invalidate+0xde/0x260 fs/dcache.c:1870
 proc_invalidate_siblings_dcache+0x3d3/0x6c0 fs/proc/inode.c:142
 release_task+0x11c8/0x16c0 kernel/exit.c:291
 wait_task_zombie kernel/exit.c:1309 [inline]
 wait_consider_task+0x197d/0x2df0 kernel/exit.c:1536
 do_wait_thread kernel/exit.c:1599 [inline]
 __do_wait+0x14b/0x720 kernel/exit.c:1717
 do_wait+0x1e7/0x510 kernel/exit.c:1751
 kernel_wait4+0x232/0x2b0 kernel/exit.c:1910
 __do_sys_wait4 kernel/exit.c:1938 [inline]
 __se_sys_wait4 kernel/exit.c:1934 [inline]
 __x64_sys_wait4+0x166/0x240 kernel/exit.c:1934
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff38ee8d68e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007fff40829ad8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000555593968500 RCX: 00007ff38ee8d68e
RDX: 0000000040000001 RSI: 00007fff40829b7c RDI: ffffffffffffffff
RBP: 00007fff40829b7c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001388
R13: 00000000000927c0 R14: 0000000000193c5e R15: 00007fff40829bd0
 </TASK>

Allocated by task 23590:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4610 [inline]
 slab_alloc_node mm/slub.c:4943 [inline]
 kmem_cache_alloc_lru_noprof+0x347/0x6a0 mm/slub.c:4976
 __d_alloc+0x37/0x6f0 fs/dcache.c:1902
 d_alloc_parallel+0xde/0x16c0 fs/dcache.c:2761
 __lookup_slow+0x82/0x2f0 fs/namei.c:1904
 lookup_slow+0x53/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 link_path_walk+0x12a5/0x1910 fs/namei.c:2653
 path_openat+0x23c/0x3850 fs/namei.c:4855
 do_file_open+0x23e/0x4a0 fs/namei.c:4888
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 29:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2703 [inline]
 slab_free mm/slub.c:6402 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6529
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core kernel/rcu/tree.c:2897 [inline]
 rcu_cpu_kthread+0x950/0x1480 kernel/rcu/tree.c:2985
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3159 [inline]
 call_rcu+0xee/0x8b0 kernel/rcu/tree.c:3279
 dentry_kill+0x4d3/0x880 fs/dcache.c:845
 finish_dput+0x1a/0x260 fs/dcache.c:1001
 proc_invalidate_siblings_dcache+0x3db/0x6c0 fs/proc/inode.c:143
 release_task+0x11c8/0x16c0 kernel/exit.c:291
 exit_notify kernel/exit.c:805 [inline]
 do_exit+0x168c/0x2360 kernel/exit.c:1016
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1147
 get_signal+0x121b/0x12c0 kernel/signal.c:3038
 arch_do_signal_or_restart+0xbb/0x860 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x104/0x730 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029bc5810
 which belongs to the cache dentry of size 376
The buggy address is located 208 bytes inside of
 freed 376-byte region [ffff888029bc5810, ffff888029bc5988)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29bc4
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802c443d01
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88801be88500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800120012 00000000f5000000 ffff88802c443d01
head: 0080000000000040 ffff88801be88500 dead000000000100 dead000000000122
head: 0000000000000000 0000000800120012 00000000f5000000 ffff88802c443d01
head: 0080000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4974, tgid 4974 (udevd), ts 43549004452, free_ts 31788091603
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x2639/0x26b0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3406
 new_slab mm/slub.c:3452 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7335
 refill_sheaf mm/slub.c:2830 [inline]
 __pcs_replace_empty_main+0x330/0x690 mm/slub.c:4701
 alloc_from_pcs mm/slub.c:4799 [inline]
 slab_alloc_node mm/slub.c:4931 [inline]
 kmem_cache_alloc_lru_noprof+0x45e/0x6a0 mm/slub.c:4976
 __d_alloc+0x37/0x6f0 fs/dcache.c:1902
 d_alloc_parallel+0xde/0x16c0 fs/dcache.c:2761
 __lookup_slow+0x82/0x2f0 fs/namei.c:1904
 lookup_slow+0x53/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 lookup_last fs/namei.c:2789 [inline]
 path_lookupat+0x3f5/0x8c0 fs/namei.c:2813
 filename_lookup+0x265/0x5d0 fs/namei.c:2842
 do_faccessat+0x632/0xdc0 fs/open.c:488
 __do_sys_faccessat2 fs/open.c:542 [inline]
 __se_sys_faccessat2 fs/open.c:539 [inline]
 __x64_sys_faccessat2+0x9a/0xb0 fs/open.c:539
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
page last free pid 4977 tgid 4977 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x10de/0x11c0 mm/page_alloc.c:2950
 __slab_free+0x252/0x2a0 mm/slub.c:5764
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4610 [inline]
 slab_alloc_node mm/slub.c:4943 [inline]
 kmem_cache_alloc_noprof+0x348/0x6b0 mm/slub.c:4957
 alloc_filename fs/namei.c:147 [inline]
 do_getname+0x2e/0x250 fs/namei.c:187
 class_filename_flags_constructor include/linux/fs.h:2561 [inline]
 do_sys_openat2+0xcc/0x200 fs/open.c:1367
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888029bc5780: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff888029bc5800: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029bc5880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888029bc5900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029bc5980: fb fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
