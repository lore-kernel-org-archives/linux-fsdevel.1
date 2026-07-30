Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE02347BD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375803; cv=none; b=bWpVKARZpmZ/f+lBTf/GDKBBnSXvz/RV3LBByYNO5Yj7HQpncbg7aHU9+qTlSl6hMG1KrBDGtJj/yhsT2hZxzlwgJqMs6C7GyJgCIPtv6i+CkPrtT4oMZwjxKd6KTDl98YA/Owwq5xNjhSKSkmoUctmB7r7gFepI4ZgykIz1Uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375803; c=relaxed/simple;
	bh=6L+H/BJXylAIfkCjijAly/26Lt/hjq7QWAzw97AOsvk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A6h1sDr/QLlgjAE8pBWWqA8eL24JPza2WU2QdMMU1ON38Ih9z9l4P5SZPh/5lixR2x0sVEfdT3ND3E5LhnoetUaYGWI2K0jQME02Y8hBbXzg5ZnI6dyIJmwJsZoiob5WreqNPpXfdcF6iKJN14CUtw1djJdXHzeDf9dje7dVza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4a49f09233dso981448b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 18:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785375801; x=1785980601;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMwylBy9MvOEsmAZ58lohSMC76sump4BuwkymLw3lAg=;
        b=kftBIXnV1i51CLI7KgRyxWS+vEullV3WiNYDSALFH/q7roSm/fFQUdBdKXNegLS/nD
         ZnqcqufFptSU28hGwXK/QgAX0w5I7nEEDNgVgsLA1+jAZhpR5vOcT0PbdEfLhvvA13dt
         sQ5knSNkd8ixx5SKzNna8RMV/8AHvl6FmJmdutr8aRtrXxmhGjj1EE7aEJY6QD22CJZv
         dTykBKqpvyeIrf2aIdqDt6jzRbws8vQ1uG6gV2EhXy3WetT6/zvYWnigjfsu0Xv/rCyv
         hy+wDdLR/L424gpCwwOqem1NggjhmpEGG4QXe/gvSYDd/mSHexMhP7NwNYEYvSog/Mr8
         qx/w==
X-Forwarded-Encrypted: i=1; AHgh+RraE3bYDDG3SYaWAA18eebxjWahXLGPAXcK5NunAuSDvO2va4rW668oKOSaLZazpzpN/dUjr8SRChDH1TOQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6h+MiRgqOd+avaYtx1OOfxW3Mg+GSrGoe8sOd+edc0jFrlEo1
	b3sMwm5UwsgYxd9a+kkjyEQQZ7FmSHbdde7dOrrOnsK1P2VCChjlsU+Y+f5s1HqqVJf2EsVceJQ
	39PhZPLTuHvmdJHkyhA+guKOiWY7hLL+kg4tUwyt8Q6wkLbRJ8OuOPmc2lVY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23c2:b0:495:5799:f4ae with SMTP id
 5614622812f47-4ad8789c213mr595658b6e.23.1785375800693; Wed, 29 Jul 2026
 18:43:20 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:43:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6aac38.79190830.3d7c75.0018.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in lookup_noperm_common
From: syzbot <syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc2b5f627e8c Add linux-next specific files for 20260714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a8649e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2290ccbf984c524f
dashboard link: https://syzkaller.appspot.com/bug?extid=23ad911c819b923238b7
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141917b1580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6836f8efb1da/disk-cc2b5f62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0109d3477cc7/vmlinux-cc2b5f62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2e49e350bbf/bzImage-cc2b5f62.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lookup_noperm_common+0x407/0x430 fs/namei.c:3106
Read of size 4 at addr ffff88803ef87810 by task syz.0.61/6090

CPU: 0 UID: 0 PID: 6090 Comm: syz.0.61 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 lookup_noperm_common+0x407/0x430 fs/namei.c:3106
 simple_start_creating+0x9c/0x110 fs/libfs.c:2302
 debugfs_start_creating+0xdb/0x1a0 fs/debugfs/inode.c:394
 debugfs_create_dir+0x24/0x350 fs/debugfs/inode.c:572
 i2c_device_probe+0x814/0xbf0 drivers/i2c/i2c-core-base.c:588
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 i2c_new_client_device+0xa29/0x1130 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x24b/0x530 drivers/i2c/i2c-core-base.c:1307
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f386433de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f386399e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f38645c5fa0 RCX: 00007f386433de99
RDX: 0000000000000011 RSI: 0000200000000a00 RDI: 0000000000000004
RBP: 00007f38643d3eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f38645c6038 R14: 00007f38645c5fa0 R15: 00007ffcb9098ee8
 </TASK>

Allocated by task 4981:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4608 [inline]
 slab_alloc_node mm/slub.c:4921 [inline]
 kmem_cache_alloc_lru_noprof+0x355/0x670 mm/slub.c:4954
 __d_alloc+0x37/0x6f0 fs/dcache.c:1902
 d_alloc+0x4b/0x190 fs/dcache.c:1981
 lookup_one_qstr_excl+0xd8/0x360 fs/namei.c:1806
 __start_dirop fs/namei.c:2920 [inline]
 start_dirop+0x5c/0x90 fs/namei.c:2942
 simple_start_creating+0xcc/0x110 fs/libfs.c:2305
 debugfs_start_creating+0xdb/0x1a0 fs/debugfs/inode.c:394
 debugfs_create_dir+0x24/0x350 fs/debugfs/inode.c:572
 i2c_register_adapter+0xc14/0x1400 drivers/i2c/i2c-core-base.c:1609
 i2c_tiny_usb_probe+0x461/0x5d0 drivers/i2c/busses/i2c-tiny-usb.c:265
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_new_device+0x98d/0x1610 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x28cf/0x4cf0 drivers/usb/core/hub.c:5953
 process_one_work+0xaaf/0x1480 kernel/workqueue.c:3379
 process_scheduled_works kernel/workqueue.c:3462 [inline]
 worker_thread+0xb05/0x10d0 kernel/workqueue.c:3543
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 21:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2706 [inline]
 slab_free mm/slub.c:6388 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6515
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
 debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:781
 i2c_del_adapter+0x229/0x430 drivers/i2c/i2c-core-base.c:1829
 i2c_tiny_usb_disconnect+0x49/0xd0 drivers/i2c/busses/i2c-tiny-usb.c:282
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3961
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5953
 process_one_work+0xaaf/0x1480 kernel/workqueue.c:3379
 process_scheduled_works kernel/workqueue.c:3462 [inline]
 worker_thread+0xb3c/0x10d0 kernel/workqueue.c:3543
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88803ef87810
 which belongs to the cache dentry of size 376
The buggy address is located 0 bytes inside of
 freed 376-byte region [ffff88803ef87810, ffff88803ef87988)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3ef86
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88801c6af500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800120012 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88801c6af500 dead000000000100 dead000000000122
head: 0000000000000000 0000000800120012 00000000f5000000 0000000000000000
head: 0080000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4972, tgid 4972 (udevd), ts 53075199244
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x264c/0x26c0 mm/page_alloc.c:3955
 __alloc_frozen_pages_noprof+0x222/0x5b0 mm/page_alloc.c:5394
 alloc_slab_page mm/slub.c:3295 [inline]
 allocate_slab+0x7c/0x5e0 mm/slub.c:3410
 new_slab mm/slub.c:3456 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7321
 refill_sheaf mm/slub.c:2833 [inline]
 __pcs_replace_empty_main+0x330/0x690 mm/slub.c:4699
 alloc_from_pcs mm/slub.c:4775 [inline]
 slab_alloc_node mm/slub.c:4909 [inline]
 kmem_cache_alloc_lru_noprof+0x44d/0x670 mm/slub.c:4954
 __d_alloc+0x37/0x6f0 fs/dcache.c:1902
 d_alloc_parallel+0xde/0x16c0 fs/dcache.c:2761
 lookup_open fs/namei.c:4418 [inline]
 open_last_lookups fs/namei.c:4602 [inline]
 path_openat+0xbf0/0x3850 fs/namei.c:4854
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803ef87700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803ef87780: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff88803ef87800: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88803ef87880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803ef87900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
