Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA212E718F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370777; cv=none; b=iqegSddqSxSfBWaDZa8YqDh+CownaHjHiNatlAcTJWR+FnpbwJJVJUFcMn3LvD8FX7Qr4WY0ff+wrvbiHBgFI1V3ZubsfliRftnUu1UvTBm9XYKVNmZTl4Jjpl2Nbhn7zSJvwTwONXqsp1ZSxL63oXuDNc0M552dBKsiesJ2LFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370777; c=relaxed/simple;
	bh=Q4WT6YRxZu8CcWhfQT1ZDFFCdveXI3C600fTKBFJAXw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LZfiGMAC66uP1pf2qalZl+PAA0hNgQXtD6I89WKPHDNMwNJvkQgUP1xdfwqp56yUJFC+q3OxQ5/GV0e69pvpp2yCW4cd4UTQE67+6I8YM/fX5dabPYOXmMNsEiVNcd3t+t3eGxZDOe1A1TNvZI8iR2obFoMmb6bVq9qm1ca1P+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49aa4525b82so1676207b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 17:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785370773; x=1785975573;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EYeMrf6nhehoafFqGOXCQOfES/Mrm/YmGqYpIY0kBI=;
        b=elYdHwQavI69NtQ5QpmSorNjxdxQMqO88InUFlHRku4Ssf+kCLwAUJOjAsbWGt4Vx+
         nv45xF1DvbapExiP0EL2lWDzmprKKOpVpQxjFhJnspqk/4je6qImLMIaH7uSQxWyASRH
         tzQfKnWLf2Tl6FSnRJ6XIvN5/mM126Dqjh3wCuBAiVVZ3VEDRBKSBz2G4KzLk29vQFws
         eQ/c6fWaGTdyjdh8QMktNQwsCXBbW90a5EVkr/JJWy85OFMYiTq8HhcC9WoLQ/g15oZ+
         JeRdC6UibpRRFiyIqUeVI+2lmvFMtnnSDVjtfpSt4RyEs3ISA/6MrKhg1E5zTp6lbEDG
         cH1g==
X-Forwarded-Encrypted: i=1; AHgh+Rr5VixfhuxoIEdWqCgVUhCy+j6GB1i+oZOTCVCLgPzqQjBs1fxg1AwBcaVqvYflXqhKh+p/GAzrK/k7NVS8@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1S2lqY1KKO5CHbkUFcut2Ey9jU6UJe/khhR14A5ydK0w9gJX
	gWvS+QqU75bX1CRe6dk5noiJE4TRVPHYyc5BUv+7rEsJ9BV0C/IHPEUUWcCzV+90TfuGMFEE3Fz
	y3qNVBGgoUKPjsch880zHHpDhV0a5TCNbi+MwZrZjKU6RtY7CcPm1KvV86Ik=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a3:b0:4a3:cea7:4ab4 with SMTP id
 5614622812f47-4ad877fc162mr460340b6e.14.1785370772827; Wed, 29 Jul 2026
 17:19:32 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:19:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6a9894.7eebbf3c.214d51.000c.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Write in config_item_get
From: syzbot <syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1220b1b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=6b16e3d085833cbf3e25
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121ea49e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1620b1b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3bff1d63ddf/disk-fc02acf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04efa97b7fb6/vmlinux-fc02acf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be724b7ea80c/bzImage-fc02acf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:283 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:366 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:383 [inline]
BUG: KASAN: slab-use-after-free in kref_get include/linux/kref.h:45 [inline]
BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90 fs/configfs/item.c:104
Write of size 4 at addr ffff888039f5201c by task syz.3.408/6784

CPU: 1 UID: 0 PID: 6784 Comm: syz.3.408 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:283 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 kref_get include/linux/kref.h:45 [inline]
 config_item_get+0x26/0x90 fs/configfs/item.c:104
 configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
 get_target fs/configfs/symlink.c:128 [inline]
 configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
 vfs_symlink+0x18b/0x330 fs/namei.c:5660
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5685
 __do_sys_symlinkat fs/namei.c:5705 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f98f891de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f98f7f7e028 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f98f8ba5fa0 RCX: 00007f98f891de99
RDX: 0000200000000340 RSI: ffffffffffffff9c RDI: 0000200000000300
RBP: 00007f98f89b3eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f98f8ba6038 R14: 00007f98f8ba5fa0 R15: 00007ffce9af1ce8
 </TASK>

Allocated by task 6785:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d2/0x6b0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 afunc_alloc_inst+0x4c/0x770 drivers/usb/gadget/function/f_uac2.c:2192
 try_get_usb_function_instance drivers/usb/gadget/functions.c:28 [inline]
 usb_get_function_instance+0xe3/0x2f0 drivers/usb/gadget/functions.c:44
 function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
 configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
 vfs_mkdir+0x402/0x620 fs/namei.c:5276
 filename_mkdirat+0x289/0x520 fs/namei.c:5309
 __do_sys_mkdirat fs/namei.c:5330 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888039f52000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 28 bytes inside of
 freed 2048-byte region [ffff888039f52000, ffff888039f52800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888039f50000 pfn:0x39f50
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff88813ffb2000 ffffea0000d6de10 ffffea0000f10610
raw: ffff888039f50000 0000000800080005 00000000f5000000 0000000000000000
head: 0080000000000240 ffff88813ffb2000 ffffea0000d6de10 ffffea0000f10610
head: ffff888039f50000 0000000800080005 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5743, tgid 5743 (syz-executor), ts 119768577290, free_ts 119599127308
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x262a/0x26a0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x330/0x690 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __kmalloc_cache_noprof+0x468/0x6b0 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 batadv_hardif_add_interface net/batman-adv/hard-interface.c:878 [inline]
 batadv_hard_if_event+0x282a/0x3530 net/batman-adv/hard-interface.c:1087
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 register_netdevice+0x18c0/0x1ed0 net/core/dev.c:11484
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1070 [inline]
 nsim_create+0xbe9/0x1160 drivers/net/netdevsim/netdev.c:1152
 __nsim_dev_port_add+0x7f8/0xcd0 drivers/net/netdevsim/dev.c:1509
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1570
 nsim_drv_probe+0x8d6/0xc00 drivers/net/netdevsim/dev.c:1731
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
page last free pid 5908 tgid 5908 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x10e7/0x11c0 mm/page_alloc.c:2950
 __slab_free+0x252/0x2a0 mm/slub.c:5741
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_noprof+0x355/0x650 mm/slub.c:4931
 vm_area_alloc+0x24/0x140 mm/vma_init.c:32
 __mmap_new_vma mm/vma.c:2547 [inline]
 __mmap_region mm/vma.c:2774 [inline]
 mmap_region+0x1263/0x2310 mm/vma.c:2860
 do_mmap+0xc1e/0x10b0 mm/mmap.c:560
 vm_mmap_pgoff+0x275/0x4e0 mm/util.c:581
 ksys_mmap_pgoff+0x4a6/0x720 mm/mmap.c:606
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888039f51f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888039f51f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888039f52000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888039f52080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039f52100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
