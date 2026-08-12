Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA53806B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505851; cv=none; b=R5H0LvOq7TA0+ULmGmiXVDMwgYUn0ZxjVz2/hOLha+r5urVplCB3iePabGYHSMoAFl3dWh+IPefICpsfJBwNxoPUyg0MAVImGButL11KSsCnI9clOJDmgJWO1wP0GZB/rNP4xkAXh0Oqf7el9IeRKyU5rlsoLIedhTNLwi3FEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505851; c=relaxed/simple;
	bh=MIIv0xTsnqrlcOqyj+16SH2+uxr6/WmnsMqFNsm4JQQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N3L6tJXzefxU8VignIGxrALaTeZRF/+kdBApHjRlfhfBXsT5LU8pLiDNKANfqEsghx7oUZhFt/r2DUjde/g/CKhwhZ0g4iPshGip1ZyAsiIe4q1VVLIlsw3qIKzp3J8/m4O8UrKB+TbV3q137/CGaPSfZ0eu6FgQnNpCLO4NS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-4566537e644so558067fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 20:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786505849; x=1787110649;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChoZOIGRpaanleIA8dSnWFxb+ZH3l02iHTvKOEzop/Q=;
        b=C40tEeFoQq8AS4vmxdhO5FN03GVSF+Y/OupFJWrV/vLK26qRI+D5ndu73jYI4CSjlZ
         aoCsM6c1f0jb7D68SqjtuFIsGoupgbOhK6oHkAm99ouBGi8H9cNMl0L9kCLMLMinGIIW
         hS6wxY0mWh7FQZIFBcXaTOmc0KTYH3XH2Ig6L62vYF4TGR4e2LV7zi+G8cMY45/GGlkr
         w1qbPGJ04apPhMl4uBl2OGlFEdwsegWgcl5McLeDXH53QNL1Q92GO3UM7R9C7kff7O8G
         4lCQhGZEycyuOoa68jU4ZL2JHwrysXo0kHz1EUZqqheX1oHjQCbTYU69BEJXdA6Cw7Vf
         mr2A==
X-Forwarded-Encrypted: i=1; AHgh+RoOAXTbQo49r76RfUXDvacvEvIlkO93CDFEK36LMfrjHDSpyDcnZ5KwgX6ZiXMhTiycblVVMf+oCEzNpljf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ueGbNt88qD5S4XIfSdKofZfWB6pPjE5CeoI/pxHaQtwV1htx
	3gOoqwe/5z07lKLiWza1TN3YWGinwAirAGtMJIwTk8xH+ew4egW5FbqR08ZY9iKv0tG6BNotK77
	o1vWkehFBEGpFXPQ71bN+2nI6DRegd6kxGKpOL3DVpXpT59AuFXHKYDVzydo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61d:b0:6ae:a950:9fb4 with SMTP id
 006d021491bc7-6b0b2946de0mr1417619eaf.33.1786505848881; Tue, 11 Aug 2026
 20:37:28 -0700 (PDT)
Date: Tue, 11 Aug 2026 20:37:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7bea78.d5f0ebe7.22d851.0007.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_dev_do_write
From: syzbot <syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104a0e49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=d6540a3fa1626e11360d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf4c0f46390e/disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21802e5d4446/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c46db810c9d/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in fuse_dev_do_write+0xb54/0xbf0 fs/fuse/dev.c:1940
Read of size 2 at addr ffff88802990801b by task syz.6.1795/14368

CPU: 0 UID: 0 PID: 14368 Comm: syz.6.1795 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 fuse_dev_do_write+0xb54/0xbf0 fs/fuse/dev.c:1940
 fuse_dev_write+0x18c/0x230 fs/fuse/dev.c:1981
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f274015e90e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f27410d9f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f27410da6c0 RCX: 00007f274015e90e
RDX: 0000000000000050 RSI: 0000200000006100 RDI: 0000000000000005
RBP: 0000000000000068 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 0000200000006d80 R14: 00007f2740425fa0 R15: 00007ffc707d4e08
 </TASK>

Allocated by task 14378:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x32d/0x660 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 fuse_new_init fs/fuse/inode.c:1445 [inline]
 fuse_send_init+0x58/0x820 fs/fuse/inode.c:1506
 vfs_get_super fs/super.c:1273 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1292
 fuse_get_tree+0x29d/0x3b0 fs/fuse/inode.c:1899
 vfs_get_tree+0x92/0x2a0 fs/super.c:1700
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3765 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3841
 do_mount fs/namespace.c:4174 [inline]
 __do_sys_mount fs/namespace.c:4390 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 14378:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6692
 process_init_reply+0x174/0x21b0 fs/fuse/inode.c:1424
 fuse_send_init+0x506/0x820 fs/fuse/inode.c:1521
 vfs_get_super fs/super.c:1273 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1292
 fuse_get_tree+0x29d/0x3b0 fs/fuse/inode.c:1899
 vfs_get_tree+0x92/0x2a0 fs/super.c:1700
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3765 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3841
 do_mount fs/namespace.c:4174 [inline]
 __do_sys_mount fs/namespace.c:4390 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029908000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 27 bytes inside of
 freed 512-byte region [ffff888029908000, ffff888029908200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29908
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b001c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b001c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 11745940408, free_ts 11745170687
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
 __kmalloc_cache_noprof+0x3a7/0x660 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 device_private_init drivers/base/core.c:3602 [inline]
 device_add+0xb6/0xb80 drivers/base/core.c:3653
 workqueue_sysfs_register+0x12b/0x300 kernel/workqueue.c:7614
 __alloc_workqueue+0x1c75/0x2060 kernel/workqueue.c:5911
 alloc_workqueue_va kernel/workqueue.c:5946 [inline]
 alloc_workqueue_noprof+0xe3/0x210 kernel/workqueue.c:5962
 tty_register_driver+0x2f0/0xdf0 drivers/tty/tty_io.c:3451
 usb_serial_init+0x1e3/0x350 drivers/usb/serial/usb-serial.c:1339
 do_one_initcall+0x250/0x870 init/main.c:1347
 do_initcall_level+0x10a/0x1a0 init/main.c:1409
 do_initcalls+0x59/0xa0 init/main.c:1425
page last free pid 13 tgid 13 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xc1e/0xd10 mm/page_alloc.c:2950
 sbitmap_free include/linux/sbitmap.h:188 [inline]
 scsi_device_dev_release+0x5c8/0xee0 drivers/scsi/scsi_sysfs.c:481
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 scsi_probe_and_add_lun+0x31cb/0x4b10 drivers/scsi/scsi_scan.c:-1
 __scsi_scan_target+0x1f0/0xe10 drivers/scsi/scsi_scan.c:1797
 scsi_scan_channel drivers/scsi/scsi_scan.c:1885 [inline]
 scsi_scan_host_selected+0x3d3/0x7a0 drivers/scsi/scsi_scan.c:1914
 do_scsi_scan_host drivers/scsi/scsi_scan.c:2047 [inline]
 do_scan_async+0x10e/0x660 drivers/scsi/scsi_scan.c:2057
 async_run_entry_fn+0x9d/0x430 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888029907f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888029907f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888029908000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888029908080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029908100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
