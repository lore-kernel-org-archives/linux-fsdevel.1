Received: from mail-oi2-f3.google.com (mail-oi2-f3.google.com [74.125.231.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15337CD5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205353; cv=none; b=aI8gCe8dyozKq7C6VbQY2CGow+d4c5ktP2ZYBE7rAZdYiFL01f8R0JzbFrjgXSfvrFafUzyA9Kwjc1KU0R6eBh3iYKjrBcdmBZ2HidgOeV5kIWmYAgVgTQL3STSR0Op1FlxsVUSosWAWJGIaYeWIqzQgK2vMXft60yZNGtTmnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205353; c=relaxed/simple;
	bh=6FPriQiQSelGQ46tFScol6zEgsWejLFkDOyWUJTnayk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IicwYb9eDTAZ6D1AjSN74iYmnVvT1TEtuYgcriO2u5J7ehWrOdkz9qLw6OYIryrh2qbdg0Drc2nquN9/zUuLvC17X3rHrZnsbc3XsSZuG9PgL0WwxXkDjBcNIc1zwHfc/4xez+qj2yFiCiY3FdQa5ifnTNqjaG6No+zHedqjF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f3.google.com with SMTP id 5614622812f47-4b38a6e8c79so16458b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 12:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205350; x=1788810150;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hxHGJxiIx5AyktYPZsvFWBjPT3vrtzKHUb5kOBDWm28=;
        b=jgoUFsOrv9j6YC5wqDL2tM9K/HrC0OdDjKPo2SgUyQkK82okpiAE00tcd7nzQYIgRs
         nw49Dh0SB8pAWGyuHwn7k5Nng+RuZbNS8Sg39hFtQWFVsPJXWMwqHGUrMPaqRiFmJchQ
         uvHjaPRu/ygAeEsyCR7kunrQXRAYHP+nmdifV90jBqMRa7yS39oVUfzPkTI9cQuvlvMy
         1hjexAPtm22W1p5MrdA8ufOLBHngVxenrrq9NY4aPn00atsowU3hTgIySInHhElgZjwU
         Nb7RS0WNMTLCkJoaaw4TnX0XFcLYYT3P76SGaS3AkOmvDy1OXQk6C7zrlQybxkl26T4V
         Pxyw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0CvC2GPPYQ3y+Qod0kkVx1divIhfK6EFKxwzW2Q+MVA+QweaY//0JWUFNEn9hCWD2Tr4MgAQ8MgxaQV4A@vger.kernel.org
X-Gm-Message-State: AFuF++mvql/N9o3shd/2h9v7h00j1v1UDTKJBpjkJ4eLfDfHQHbm1ySp
	mQHw1f7qmw+oD7VPZVkjPPeTA0XcRIZH5i6YydDwDuic1JS7/DD5CL1K8MMjjdx/QsyF8ksMPne
	1AbJMvGrvf8z+h9KW4iiQOsvVagD10xBvHgJVVZGZSz34g+tC+irgRYzKdiA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a9:b0:4b3:79b0:8481 with SMTP id
 5614622812f47-4b3983537c2mr32626608b6e.19.1788205350164; Mon, 31 Aug 2026
 12:42:30 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:42:30 -0700
In-Reply-To: <6a74a76d.ec7c9571.3ac9bb.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a95d926.99925153.16bd3d.0005.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sysfs_emit
From: syzbot <syzbot+302b9b575a06733ff60c@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13ca3379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=302b9b575a06733ff60c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13caad9e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136de379580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/disk-f1b8fa82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmlinux-f1b8fa82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396/Image-f1b8fa82.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+302b9b575a06733ff60c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck+0xd8/0x140 lib/vsprintf.c:648
Read of size 1 at addr ffff0000d4016758 by task udevd/4787

CPU: 0 UID: 0 PID: 4787 Comm: udevd Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 string_nocheck+0xd8/0x140 lib/vsprintf.c:648
 string+0x8c/0xc8 lib/vsprintf.c:730
 vsnprintf+0x880/0xd10 lib/vsprintf.c:2945
 vscnprintf+0x6c/0xd4 lib/vsprintf.c:3014
 sysfs_emit+0x110/0x184 fs/sysfs/file.c:761
 input_dev_show_name+0x60/0x74 drivers/input/input.c:1282
 dev_attr_show+0x60/0xd0 drivers/base/core.c:2487
 sysfs_kf_seq_show+0x1e0/0x2fc fs/sysfs/file.c:65
 kernfs_seq_show+0xf0/0x130 fs/kernfs/file.c:216
 seq_read_iter+0x39c/0xbe8 fs/seq_file.c:231
 kernfs_fop_read_iter+0x13c/0x414 fs/kernfs/file.c:290
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x498/0x8c8 fs/read_write.c:574
 ksys_read+0x12c/0x228 fs/read_write.c:716
 __do_sys_read fs/read_write.c:725 [inline]
 __se_sys_read fs/read_write.c:723 [inline]
 __arm64_sys_read+0x84/0x98 fs/read_write.c:723
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

Allocated by task 4754:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e8/0x5ec mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 redrat3_dev_probe+0x3a4/0x1e90 drivers/media/rc/redrat3.c:1023
 usb_probe_interface+0x308/0x788 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x29c/0x800 drivers/base/dd.c:706
 __driver_probe_device+0x1e0/0x350 drivers/base/dd.c:868
 driver_probe_device+0x6c/0x19c drivers/base/dd.c:898
 __device_attach_driver+0x198/0x2f8 drivers/base/dd.c:1026
 bus_for_each_drv+0x144/0x1dc drivers/base/bus.c:500
 __device_attach+0x248/0x390 drivers/base/dd.c:1098
 device_initial_probe+0x90/0xc8 drivers/base/dd.c:1153
 bus_probe_device+0x58/0x120 drivers/base/bus.c:620
 device_add+0x6cc/0x9e0 drivers/base/core.c:3772
 usb_set_configuration+0x1184/0x158c drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8c/0x148 drivers/usb/core/generic.c:250
 usb_probe_device+0x114/0x2b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x29c/0x800 drivers/base/dd.c:706
 __driver_probe_device+0x1e0/0x350 drivers/base/dd.c:868
 driver_probe_device+0x6c/0x19c drivers/base/dd.c:898
 __device_attach_driver+0x198/0x2f8 drivers/base/dd.c:1026
 bus_for_each_drv+0x144/0x1dc drivers/base/bus.c:500
 __device_attach+0x248/0x390 drivers/base/dd.c:1098
 device_initial_probe+0x90/0xc8 drivers/base/dd.c:1153
 bus_probe_device+0x58/0x120 drivers/base/bus.c:620
 device_add+0x6cc/0x9e0 drivers/base/core.c:3772
 usb_new_device+0x9c4/0x11f8 drivers/usb/core/hub.c:2703
 hub_port_connect drivers/usb/core/hub.c:5575 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x1ef0/0x39fc drivers/usb/core/hub.c:5961
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838

Freed by task 4754:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x188/0x690 mm/slub.c:6692
 redrat3_delete drivers/media/rc/redrat3.c:466 [inline]
 redrat3_dev_probe+0x1008/0x1e90 drivers/media/rc/redrat3.c:1124
 usb_probe_interface+0x308/0x788 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x29c/0x800 drivers/base/dd.c:706
 __driver_probe_device+0x1e0/0x350 drivers/base/dd.c:868
 driver_probe_device+0x6c/0x19c drivers/base/dd.c:898
 __device_attach_driver+0x198/0x2f8 drivers/base/dd.c:1026
 bus_for_each_drv+0x144/0x1dc drivers/base/bus.c:500
 __device_attach+0x248/0x390 drivers/base/dd.c:1098
 device_initial_probe+0x90/0xc8 drivers/base/dd.c:1153
 bus_probe_device+0x58/0x120 drivers/base/bus.c:620
 device_add+0x6cc/0x9e0 drivers/base/core.c:3772
 usb_set_configuration+0x1184/0x158c drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8c/0x148 drivers/usb/core/generic.c:250
 usb_probe_device+0x114/0x2b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x29c/0x800 drivers/base/dd.c:706
 __driver_probe_device+0x1e0/0x350 drivers/base/dd.c:868
 driver_probe_device+0x6c/0x19c drivers/base/dd.c:898
 __device_attach_driver+0x198/0x2f8 drivers/base/dd.c:1026
 bus_for_each_drv+0x144/0x1dc drivers/base/bus.c:500
 __device_attach+0x248/0x390 drivers/base/dd.c:1098
 device_initial_probe+0x90/0xc8 drivers/base/dd.c:1153
 bus_probe_device+0x58/0x120 drivers/base/bus.c:620
 device_add+0x6cc/0x9e0 drivers/base/core.c:3772
 usb_new_device+0x9c4/0x11f8 drivers/usb/core/hub.c:2703
 hub_port_connect drivers/usb/core/hub.c:5575 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x1ef0/0x39fc drivers/usb/core/hub.c:5961
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838

The buggy address belongs to the object at ffff0000d4016000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1880 bytes inside of
 freed 2048-byte region [ffff0000d4016000, ffff0000d4016800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0000d4011000 pfn:0x114010
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000240 ffff0000c0002000 fffffdffc3830c10 fffffdffc3bffc10
raw: ffff0000d4011000 0000000800080005 00000000f5000000 0000000000000000
head: 05ffc00000000240 ffff0000c0002000 fffffdffc3830c10 fffffdffc3bffc10
head: ffff0000d4011000 0000000800080005 00000000f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc3500401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d4016600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d4016680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000d4016700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff0000d4016780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d4016800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
