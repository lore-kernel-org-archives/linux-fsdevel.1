Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B72384CCD
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721322; cv=none; b=hxS3PPNgfYsCl5y+XMt/izayDVUOYhz+a7qrA2VL+CLcTgEKA4W/dZDBJVsBL230FyE4QbRcMGgt4k9JKbzz/eQzD8dpfy0sgfwTbU85ieKOXJjCiDMt2BDreKbOrJYVYvD3S5wdIJhrtMyj1wOl2T82Z8+eHyJfT+h45BkeY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721322; c=relaxed/simple;
	bh=/YeHNthv94Okll9wkCScNqXPuFtcz9gNqGJLn3R0GNw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sJNpMSiZN8Y3m3539Jf6KRBjePMtXYmljsVPEFtaRu3LSwG/cQk4HTsbcZezbyfxRfAkcp8mvEl0JX9KE1j+ZPpnIDnKFaW+Bl3dyf6chaZIKcTzzfir4PNF8lUcdqrAkEQxPcmHzWLIT3Hqsryz3jUCXnO2M3LvE9O8+Fkzcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48638069322so171987b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 11:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781721319; x=1782326119;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMY5oSxOPeXdRet6NFi5fqq9RlclymJz97QQTJL1Lhw=;
        b=O1CLk0rLhxh4cXh80IxhW3Xm7lyJfOS8qyZbP/OHI+ao0GY5kgpnVOtzZ1v+oqX85b
         3mOMGxhUBAHA49JySUg7xNJWuXX7dMaO2gsa6bigk6ZpbS+/T8q0oSRieu1Tfs1HCvsi
         GQX/12HZuvqVrzba/4c69ovcf4N2myo096OxZfdxVjQH2eBXj7qsBsCST6/LA66l9yR1
         9MTnYpCWPiQp8X0UYPq4P/o/uGFP/fAsRu0Pwb47kqbp7OdGOxLm2hdXTw7WZiPr8f6c
         LP0/cUSScf9Lcs1QmIPHOBEOTGpz35tI7jiebc0qSJ7gPdsWxE+sVQNV3Bm8K8pLM5if
         AGgA==
X-Forwarded-Encrypted: i=1; AFNElJ/pyyxrhXGwGHacgR6ieR4jVCdRBF6AIW4rXvDOLu6B17/Ek3Ydxx65yHHBAUjxrTmPjPA4ThYfF3lfg8hp@vger.kernel.org
X-Gm-Message-State: AOJu0YwQp/HPte27uizScW7+uPyZfK/wnFCCcx7Erz+jMzlb3rnUVzFv
	SJEPYJhluqmH2s0NfXk+VFR9yfIIJJNji6RbBYA7Ld0Wzxf1qlyxucBfHE/yP84gPp86Hzrt6dT
	Um5IJr2Q+MhIQnxX+Ls85n4K4olhry24srsL8PSJSVkJoGlM7f+3+QtvJZaA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e8d4:10b0:487:28a2:9b8e with SMTP id
 5614622812f47-489444bd863mr2727806b6e.13.1781721319387; Wed, 17 Jun 2026
 11:35:19 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a32e8e7.9e4c924b.10726f.0023.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in debugfs_u32_get (2)
From: syzbot <syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    062871f1371b Merge tag 'pinctrl-v7.1-3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148da8ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e4d2284f2ffa41
dashboard link: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123143b6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d66ac4b1a707/disk-062871f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fb941439264/vmlinux-062871f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed65e46ebbc3/bzImage-062871f1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in debugfs_u32_get+0x65/0x80 fs/debugfs/file.c:657
Read of size 4 at addr ffff88807c8e5b00 by task syz.2.10230/16881

CPU: 0 UID: 0 PID: 16881 Comm: syz.2.10230 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 debugfs_u32_get+0x65/0x80 fs/debugfs/file.c:657
 simple_attr_read+0x16b/0x350 fs/libfs.c:1368
 debugfs_attr_read+0x74/0xb0 fs/debugfs/file.c:523
 vfs_read+0x1e4/0xb30 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa7fd79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe85aad168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fa7fda15fa0 RCX: 00007fa7fd79ce59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fa7fd832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa7fda15fac R14: 00007fa7fda15fa0 R15: 00007fa7fda15fa0
 </TASK>

Allocated by task 14078:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5296 [inline]
 __kvmalloc_node_noprof+0x360/0xa00 mm/slub.c:6833
 alloc_netdev_mqs+0xd7/0x1560 net/core/dev.c:12029
 nsim_create+0x94/0x1420 drivers/net/netdevsim/netdev.c:1133
 __nsim_dev_port_add+0x3ba/0x8f0 drivers/net/netdevsim/dev.c:1509
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1570 [inline]
 nsim_drv_probe+0xeb7/0x14b0 drivers/net/netdevsim/dev.c:1731
 call_driver_probe drivers/base/dd.c:631 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:709
 __driver_probe_device+0x22e/0x480 drivers/base/dd.c:871
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:901
 __device_attach_driver+0x1df/0x340 drivers/base/dd.c:1029
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1101
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x64/0x160 drivers/base/bus.c:613
 device_add+0x1210/0x1950 drivers/base/core.c:3706
 nsim_bus_dev_new drivers/net/netdevsim/bus.c:471 [inline]
 new_device_store+0x40b/0x700 drivers/net/netdevsim/bus.c:191
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 13:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x223/0x6c0 mm/slub.c:6566
 device_release+0xd2/0x270 drivers/base/core.c:2566
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3814
 free_netdev+0x5ef/0x8c0 net/core/dev.c:12223
 __nsim_dev_port_del+0x194/0x2b0 drivers/net/netdevsim/dev.c:1547
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1561 [inline]
 nsim_dev_reload_destroy+0x10a/0x4a0 drivers/net/netdevsim/dev.c:1785
 nsim_dev_reload_down+0x66/0xd0 drivers/net/netdevsim/dev.c:1038
 devlink_reload+0x1ae/0x7a0 net/devlink/dev.c:462
 devlink_pernet_pre_exit+0x247/0x370 net/devlink/core.c:560
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0xab0 net/core/net_namespace.c:234
 cleanup_net+0x499/0x920 net/core/net_namespace.c:702
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807c8e4000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 6912 bytes inside of
 freed 8192-byte region [ffff88807c8e4000, ffff88807c8e6000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c8e0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807c8e2011
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe47640 dead000000000100 dead000000000122
raw: 0000000000000000 0000400000020002 00000000f5000000 ffff88807c8e2011
head: 00fff00000000040 ffff88813fe47640 dead000000000100 dead000000000122
head: 0000000000000000 0000400000020002 00000000f5000000 ffff88807c8e2011
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5738, tgid 5738 (syz-executor), ts 350789534111, free_ts 350786879056
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x11a6/0x3410 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kvmalloc_node_noprof+0x7da/0xa00 mm/slub.c:6833
 alloc_netdev_mqs+0xd7/0x1560 net/core/dev.c:12029
 rtnl_create_link+0xc13/0xf80 net/core/rtnetlink.c:3672
 rtnl_newlink_create net/core/rtnetlink.c:3854 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3995 [inline]
 rtnl_newlink+0x13bd/0x2380 net/core/rtnetlink.c:4110
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6997
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2555
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1899
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x468/0x4b0 net/socket.c:2266
 __do_sys_sendto net/socket.c:2273 [inline]
 __se_sys_sendto net/socket.c:2269 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2269
page last free pid 5762 tgid 5762 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0x794/0x10a0 mm/page_alloc.c:2938
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 __kmalloc_cache_noprof+0x243/0x6f0 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 ref_tracker_alloc+0x190/0x590 lib/ref_tracker.c:270
 __netdev_tracker_alloc include/linux/netdevice.h:4471 [inline]
 netdev_hold include/linux/netdevice.h:4500 [inline]
 netdev_hold include/linux/netdevice.h:4495 [inline]
 netdev_queue_add_kobject net/core/net-sysfs.c:1979 [inline]
 netdev_queue_update_kobjects+0x2db/0x6f0 net/core/net-sysfs.c:2041
 register_queue_kobjects net/core/net-sysfs.c:2104 [inline]
 netdev_register_kobject+0x2b3/0x3d0 net/core/net-sysfs.c:2347
 register_netdevice+0x151c/0x24b0 net/core/dev.c:11423
 __ip_tunnel_create+0x52b/0x670 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x230/0x780 net/ipv4/ip_tunnel.c:1147
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:579
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234

Memory state around the buggy address:
 ffff88807c8e5a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c8e5a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c8e5b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807c8e5b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c8e5c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
