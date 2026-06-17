Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D947D931
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716118; cv=none; b=qdF/KCmylCBEbbRMIusrv+Ooc+0WGWq/J6BeUERzbm1aeNElRX9b0iJ6HNyTx2OQGpj714E8IZvzNg9Dc4r6czCIJPoZDzf2xxl3noGKywr6EFlTT3aGbG0Gqr+R70Rzw0mYddDtlBMRpsx6JK4NWbhcWouOPA+16Gelx6NpocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716118; c=relaxed/simple;
	bh=oqEQYa5UKsBNZF53dxO/SpvOcC5R9tbAEWXAG1qofOc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QMjYuLEq0WQCegt0Hr4pLPBYNbDwj3pnFgHqCKo8EwYXRuA1cfU63TBzd5AXwU5DR/d7RTzcPC5cC/OxfYltEh6CLT/0FDewuxYlxaE+QyGNyRa6uoi0ZKRmMWZCn60a6fbh6GXBop3xhMwH0EuCumaIYE2bWuYu5EzAczFZzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4867831a9a8so9276981b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 10:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716115; x=1782320915;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYqMD6Jp4vHWiwDDCBpokZ6fyqFr6PsqW0VcNi5JZA0=;
        b=nGd6VOdnAwoHPaW1ik35CEK+hJ0Ln4P4ooqH9lCKsg+uBJ7K9x/huN7mwBIRcbMt9c
         nHhjMSrYsHfA0kbTFRZxVLdf53ghaCJxmcRdqLyHsqYcL5x6NtQQDAN9BmBw4pnDq/g5
         hK6sBY5MIraqbEdqX1hzS5yoQ2q5OjU8n5PnlMNiJGvoM36dU41WbaDdtx1G8Goz+2OB
         azHu32lnDwvFQXARBuQvtbL1rmD4j5CZbZfUULQ4fcWJP6bQf5LcJa3dI0dUfIfhd76n
         74qExdOMnTIkaLI3cVuJZ4ZDnloZvYGW6Lmee3P6g8bkncpQoBqPs3R/xD0E9apDuOAJ
         CvKA==
X-Forwarded-Encrypted: i=1; AFNElJ/GlALGLE1Ut8KA//8emRwR+uOuL3RoZMcoYjNA76UHh0cX2VfjzjbQBv44qjffq7wcRg+yuEvGQVCQHu/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkCOtLvVvJCeKwvblFpUjx1BL8sl2Ip9TQNAC3XagyvTSe5cL
	HBV8ZxWCVN/CIUumrqB1X/BzO1LJLIO/qy7V5ORIs951+EimZv1EgoF4SgMqyavd7htOSXs6V9v
	b/SQOF2YtFEMDkEiCvxClPoOyR1piAnE0jrfzx2ZHAoc2yXnklnNVbtvEs3E=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:11cd:b0:487:4d4e:bcf3 with SMTP id
 5614622812f47-4894445b29bmr3525467b6e.9.1781716114720; Wed, 17 Jun 2026
 10:08:34 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:08:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in shrink_dcache_tree
From: syzbot <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c425609d6ac4 Add linux-next specific files for 20260612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12864986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7a56b1e89b63439
dashboard link: https://syzkaller.appspot.com/bug?extid=000c800a02097aaa10ed
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7fab9a8df61a/disk-c425609d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2577196651b/vmlinux-c425609d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/053557a7471e/bzImage-c425609d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff8880400e5570 by task syz-executor/5618

CPU: 0 UID: 0 PID: 5618 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
 spin_unlock include/linux/spinlock_rt.h:109 [inline]
 shrink_dcache_tree+0x30e/0x410 fs/dcache.c:1754
 vfs_rmdir+0x425/0x6b0 fs/namei.c:5381
 filename_rmdir+0x292/0x520 fs/namei.c:5434
 __do_sys_unlinkat fs/namei.c:5609 [inline]
 __se_sys_unlinkat+0x71/0x1a0 fs/namei.c:5602
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe005bdbf77
Code: 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef7890fe8 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007fe005bdbf77
RDX: 0000000000000200 RSI: 00007ffef7892130 RDI: 00000000ffffff9c
RBP: 00007fe005c721ca R08: 00000000000065c0 R09: 00000000ffffffff
R10: 0000000000000100 R11: 0000000000000207 R12: 00007ffef7892130
R13: 00007fe005c721ca R14: 0000000000022281 R15: 00007ffef7892170
 </TASK>

Allocated by task 6103:
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
 lookup_open fs/namei.c:4423 [inline]
 open_last_lookups fs/namei.c:4608 [inline]
 path_openat+0xbf0/0x3850 fs/namei.c:4856
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
 __fput+0x699/0xa80 fs/file_table.c:520
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1fa/0x730 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880400e54a0
 which belongs to the cache dentry of size 376
The buggy address is located 208 bytes inside of
 freed 376-byte region [ffff8880400e54a0, ffff8880400e5618)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x400e4
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888031f5da01
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88801be88500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800120012 00000000f5000000 ffff888031f5da01
head: 0080000000000040 ffff88801be88500 dead000000000100 dead000000000122
head: 0000000000000000 0000000800120012 00000000f5000000 ffff888031f5da01
head: 0080000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4988, tgid 4988 (udevd), ts 46901016481, free_ts 0
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
 d_alloc+0x4b/0x190 fs/dcache.c:1981
 lookup_one_qstr_excl+0xd8/0x360 fs/namei.c:1806
 __start_dirop fs/namei.c:2920 [inline]
 start_dirop fs/namei.c:2942 [inline]
 filename_create+0x20e/0x370 fs/namei.c:4951
 filename_symlinkat+0xf7/0x420 fs/namei.c:5675
 __do_sys_symlink fs/namei.c:5708 [inline]
 __se_sys_symlink+0x4d/0x2b0 fs/namei.c:5704
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880400e5400: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff8880400e5480: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
>ffff8880400e5500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff8880400e5580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880400e5600: fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00 00
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
