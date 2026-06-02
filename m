Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7A1DED4C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417408; cv=none; b=lLjyKOOQ61nti+sz4g7go4yCpYMyMdc1uF+2i3WgjEuk6Y3/a+dul7ibVhiBPehauEvz0kuqbQyJtTLbh0IzraqMHg/7zVd3CPQX6biXPYFoTo5OLhfXqhECdpAIpuMhd8fyn7T7UtQmie6Fuyv28RMUTa58lfBM8UyOFAE+h4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417408; c=relaxed/simple;
	bh=KzesLpszfAALoA62pKh0QSuapaUTnTWVkXYwugsgRWY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ct9GzQiSfqTrDhjxgWkHcYU0aFFhWk2Y0lMgQhAA6UkR9yOtuGTWpThD+eEWQsz/ACuZqCLLx9XLWSlt7AiZReQUOJm9eL4j4DgXD6HBf7jta3AT12XnDnvr2orr9XCH4ee+yBmz7Bd2dyX1uUBkSQj0wtGekzGTX1QwpAMkWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-43d08878f48so3615870fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 09:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417406; x=1781022206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+cfd+ivxhMsjoBhmhDdDEOuzmPfKx6zjhO5omi8cds=;
        b=DI42uiOcvlidh+Bf+D5CE7Fav381vbYSLVHLqNk36m/gZqq+G476JRCNK/ExIhUZUB
         O19yOVhUfyJxTFV4/6+4HC21MfJULJz/yLew+LtEde/cneLtlkjnMcsFf0nTAavpS5t4
         PUGqDedjVKWPM0d7ZOXqiEM6OQO5o1w4d1zOgbeyrdDhX6lxtsFZrWFGAaYbbW7p5raO
         ZPOqkliVRAs6JzX8dpGgC6z4Bs6v4WZbSzp3UuMiOxvd9WllCyvoq9kRzz98ArFICH8n
         FIlJVZzU2+ZP0f0c5Q74Iwj8INpwCg8GCTt2hysKABqSjlzZBtrUdX3+IWaddhTBKP4U
         Ty+w==
X-Forwarded-Encrypted: i=1; AFNElJ93Gcen/d/s2oPbnh02m6YyoMyykm2RQq1QuK2JE15Ft6vDvnC5sw4pxSfko8PQhQj+iiqLIUGQrEf0/qg9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qf69M1+X8PsXw0zKEEMZVob+gW9zUGWzD/KWi73O+5OYDJst
	c9H+lXGmzLxhHHnwUu8B5Rv6cmB6Nz9gTqetZZRPev8uOMr5rd1DQIn0zGPeMyymyTQiOI0KxRj
	XeY4Cibkw3x0yNgthStqfifiEK31CG7ozfKrI6SFbBG32gSVJtL6buJmkgZ4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ddd3:0:b0:69d:fc7c:ecd9 with SMTP id
 006d021491bc7-69e46920acfmr194969eaf.10.1780417406503; Tue, 02 Jun 2026
 09:23:26 -0700 (PDT)
Date: Tue, 02 Jun 2026 09:23:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1f037e.3b158e77.2846f8.0848.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in filename_mkdirat
From: syzbot <syzbot+a552beb2a6a3428fc4a8@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8c2f9fdadee Merge tag 'for-7.1/hpfs-fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151aaac8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6200d9adbee6a664
dashboard link: https://syzkaller.appspot.com/bug?extid=a552beb2a6a3428fc4a8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/962d854a5f7d/disk-e8c2f9fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d265e5cb4395/vmlinux-e8c2f9fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc268c49a6f7/bzImage-e8c2f9fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a552beb2a6a3428fc4a8@syzkaller.appspotmail.com

FAT-fs (loop0): Invalid FSINFO signature: 0x41615252, 0x80417272 (sector = 1)
==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff88806293ae90 by task syz.0.240/7482

CPU: 1 UID: 0 PID: 7482 Comm: syz.0.240 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 rt_mutex_slowunlock+0xbf/0x8b0 kernel/locking/rtmutex.c:1426
 end_dirop fs/namei.c:2952 [inline]
 end_creating include/linux/namei.h:123 [inline]
 end_creating_path fs/namei.c:4990 [inline]
 filename_mkdirat+0x311/0x520 fs/namei.c:5299
 __do_sys_mkdirat fs/namei.c:5315 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ad209ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ad02f6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f0ad2315fa0 RCX: 00007f0ad209ce59
RDX: 0000000000000002 RSI: 00002000000004c0 RDI: 0000000000000005
RBP: 00007f0ad2132d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0ad2316038 R14: 00007f0ad2315fa0 R15: 00007ffc131430c8
 </TASK>

Allocated by task 7482:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_lru_noprof+0x33c/0x680 mm/slub.c:4918
 __d_alloc+0x37/0x6f0 fs/dcache.c:1807
 d_alloc+0x4b/0x190 fs/dcache.c:1886
 lookup_one_qstr_excl+0xd8/0x360 fs/namei.c:1801
 __start_dirop fs/namei.c:2916 [inline]
 start_dirop fs/namei.c:2938 [inline]
 filename_create+0x20e/0x370 fs/namei.c:4950
 filename_mkdirat+0xd2/0x520 fs/namei.c:5287
 __do_sys_mkdirat fs/namei.c:5315 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 28:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6378
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core kernel/rcu/tree.c:2869 [inline]
 rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 __dentry_kill+0x4a9/0x690 fs/dcache.c:737
 finish_dput+0xc9/0x480 fs/dcache.c:927
 path_put+0x39/0x60 fs/namei.c:717
 vfs_statx+0x138/0x200 fs/stat.c:357
 vfs_fstatat fs/stat.c:373 [inline]
 vfs_lstat include/linux/fs.h:3212 [inline]
 __do_sys_newlstat fs/stat.c:524 [inline]
 __se_sys_newlstat fs/stat.c:518 [inline]
 __x64_sys_newlstat+0x125/0x1e0 fs/stat.c:518
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88806293adc0
 which belongs to the cache dentry of size 376
The buggy address is located 208 bytes inside of
 freed 376-byte region [ffff88806293adc0, ffff88806293af38)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6293a
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88806293bef1
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88801b6e83c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800120012 00000000f5000000 ffff88806293bef1
head: 0080000000000040 ffff88801b6e83c0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800120012 00000000f5000000 ffff88806293bef1
head: 0080000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4965, tgid 4965 (udevd), ts 96191026007, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x27c8/0x2840 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 kmem_cache_alloc_lru_noprof+0x433/0x680 mm/slub.c:4918
 __d_alloc+0x37/0x6f0 fs/dcache.c:1807
 d_alloc_parallel+0xe6/0x1610 fs/dcache.c:2671
 __lookup_slow+0x152/0x440 fs/namei.c:1900
 lookup_slow+0x53/0x70 fs/namei.c:1932
 walk_component fs/namei.c:2278 [inline]
 lookup_last fs/namei.c:2785 [inline]
 path_lookupat+0x3f5/0x8c0 fs/namei.c:2809
 filename_lookup+0x256/0x5d0 fs/namei.c:2838
 vfs_statx+0xfc/0x200 fs/stat.c:353
 vfs_fstatat+0x11b/0x170 fs/stat.c:373
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat fs/stat.c:532 [inline]
 __x64_sys_newfstatat+0x151/0x200 fs/stat.c:532
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88806293ad80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88806293ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806293ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88806293af00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
 ffff88806293af80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
