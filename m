Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7043B489
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029936; cv=none; b=F9e75iFgC3EDIpbtqM68+gdteWxrJx3qs8RCOK6KWZIRjydbXH4FT0UoIQlMOLXTksCmo/Nqo7Lf05jtdo1/NsH4My/+lkJ+J20gdJV/2C0E2mUZWwsAPlupw9JVJEbLkqhBvLdwwz3Str8h5imY+P9NsNJOz/jONKHkQ++lFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029936; c=relaxed/simple;
	bh=6oQkl62RtF7lAlAPxGmjbzsWFibMlNtsWBTmD4p/uXw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XRRCseygUmZLhHYm11MM9gbqUlABoRyrt8cN3lJlxjfNRuEd9tO9KFJ8oZGuz+pzVVOanCHrSgUJ/sLgcrlZRkEcOKc+6pIwHy9YxwtawxxDskM9xrhzSpHR4jvR3xIkjT3V+BQKnXaL0IBU7DestxxuEgyrgRYTV7oaKwtA1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4959c49e054so1336245b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 08:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029933; x=1786634733;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGUFs4UFQbjf9UT51v7FgnZvfQefS3Pb3MFaIbMi/hI=;
        b=fX/ilL0eiZi2G1WUEwY0aqVH3T6Hm5fonnwI1imh9HsxMdAzGPQpQ/A+wSgrOGZN+w
         SsrW+KWwCaPRIca3jnRSOSVf/Ofneqckp+5/jrsBD5ywQpdhShJHafIHQFjbIZ/CmULN
         AoJKjFn3eYJ0JxkI6roiCbU7iBvOS1nIMdoAXVzL9qugkH3a9XUktIG6jeVAVHyXByIH
         JcM+BTBsYpo34+htsJ/aXqXmxAJvz4eC1iIeGNoRhp3JGiPfGePkYWPPFYk/cnTkn20o
         sY95AA+rPbTQ0gKWYZYm/afCPgZjUqYDWYMq1xlqZXaTf5FFGwSfHHES1nLtFcf/EBvW
         Yd0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrA2SE0qUBOn87a+PZQJHLjGkpF5jope6IZvUEAlGard7JNGAqC5Up5OAB3sh+l+tNtC2bJG9/Y2njA3jmV@vger.kernel.org
X-Gm-Message-State: AOJu0YxTR48Duyc6NreKe8ZpZ5ez0dNCiTnWq3ts5tSl/0zzswqvpeBx
	pArlVwizkC4h36F098RDF9yiRRdTufYRPsJ5MWjHGIj7vldGoL/zF4wJkxGUJb9uKWih4V4WvIP
	rm4jszZR2FvSsWFDbBXTt+kOu3wzi2GZa22fVLOVCVCZCF+xnDZKrmCF5OtM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a24:b0:4af:741c:f60d with SMTP id
 5614622812f47-4afade361d1mr7875038b6e.13.1786029933155; Thu, 06 Aug 2026
 08:25:33 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:25:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74a76d.ec7c9571.3ac9bb.0056.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in sysfs_emit
From: syzbot <syzbot+302b9b575a06733ff60c@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144f9bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=302b9b575a06733ff60c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bf3ffd710de/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/770c0a63a80c/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c54f9393cb03/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+302b9b575a06733ff60c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:648 [inline]
BUG: KASAN: slab-use-after-free in string+0x216/0x2d0 lib/vsprintf.c:730
Read of size 1 at addr ffff888051fda758 by task udevd/7464

CPU: 0 UID: 0 PID: 7464 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 string_nocheck lib/vsprintf.c:648 [inline]
 string+0x216/0x2d0 lib/vsprintf.c:730
 vsnprintf+0x74a/0xef0 lib/vsprintf.c:2945
 vscnprintf+0x41/0x90 lib/vsprintf.c:3014
 sysfs_emit+0x10e/0x180 fs/sysfs/file.c:761
 input_dev_show_name+0x58/0x70 drivers/input/input.c:1282
 dev_attr_show+0x58/0xc0 drivers/base/core.c:2487
 sysfs_kf_seq_show+0x331/0x490 fs/sysfs/file.c:65
 seq_read_iter+0x463/0xca0 fs/seq_file.c:231
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x595/0xa80 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe991ca7407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffc9989ac00 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fe9924aa880 RCX: 00007fe991ca7407
RDX: 0000000000001000 RSI: 00007ffc9989b0e0 RDI: 0000000000000008
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000562578d85a20
R13: 00007ffc9989ace0 R14: 00007ffc9989b0e0 R15: 0000562548648bcc
 </TASK>

Allocated by task 10:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x32d/0x660 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 redrat3_dev_probe+0x477/0x2570 drivers/media/rc/redrat3.c:1023
 usb_probe_interface+0x653/0xc60 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_new_device+0x99d/0x1620 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5953
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 10:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6692
 redrat3_delete drivers/media/rc/redrat3.c:466 [inline]
 redrat3_dev_probe+0x1bf4/0x2570 drivers/media/rc/redrat3.c:1124
 usb_probe_interface+0x653/0xc60 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_new_device+0x99d/0x1620 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5953
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888051fda000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1880 bytes inside of
 freed 2048-byte region [ffff888051fda000, ffff888051fda800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x51fd8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b002000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b002000 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1094, tgid 1094 (kworker/u8:7), ts 96851722653, free_ts 25791140797
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_node_track_caller_noprof+0x557/0x730 mm/slub.c:5471
 kmalloc_reserve net/core/skbuff.c:637 [inline]
 __alloc_skb+0x2bd/0x7a0 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 mld_newpack+0x165/0xcb0 net/ipv6/mcast.c:1789
 add_grhead net/ipv6/mcast.c:1900 [inline]
 add_grec+0x119f/0x19d0 net/ipv6/mcast.c:2039
 mld_send_initial_cr+0x288/0x550 net/ipv6/mcast.c:2284
 ipv6_mc_dad_complete+0x87/0x410 net/ipv6/mcast.c:2295
 addrconf_dad_completed+0x8af/0xe60 net/ipv6/addrconf.c:4375
 addrconf_dad_work+0xcf8/0x15c0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x960/0xa60 mm/page_alloc.c:1451
 __free_contig_range_common+0x174/0x340 mm/page_alloc.c:6897
 destroy_args+0x4e5/0x570 mm/debug_vm_pgtable.c:993
 debug_vm_pgtable+0x3f8/0x410 mm/debug_vm_pgtable.c:1368
 do_one_initcall+0x250/0x870 init/main.c:1347
 do_initcall_level+0x10a/0x1a0 init/main.c:1409
 do_initcalls+0x59/0xa0 init/main.c:1425
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
 kernel_init+0x1d/0x1d0 init/main.c:1548
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888051fda600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888051fda680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888051fda700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888051fda780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888051fda800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
