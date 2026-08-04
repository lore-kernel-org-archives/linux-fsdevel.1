Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B773603E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785806551; cv=none; b=Fo8kfpn8FibBR7tWJcAurfQByjs3NXzpKSh+Ff5qBDMAoya9PK7qt9Gf1JawFcp8KANO1vdkmRc5EflubHXLOYfdVd0dd7K9RVZ8+orwgrdMnfdA/LvnnNAtZp9tayQ63ZjVN4Wwjt63r/kp1lkjBKUqw268BkpRGAZUN0rs+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785806551; c=relaxed/simple;
	bh=qRqnXLyfzoi6U819BVmQMD9BvtRbcz9twZE+6VW4Arg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rfYJtsg/957dGQLxjVKUoxYhpr12UkUq8FCwH9d5m/vyDmZ6bYvw1vMdBxCKg4Eu5XxJ8TkR2FWr+mg47qOZLvgeq/u14eoYUDFUWDeTFREZYLCvzw60lHQ1EhTBilJDZc82zo4aKxwI3Fs7lCMHBIsFR5bTS2JO50JdnAC06P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a41f46d629so6371484b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 18:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785806548; x=1786411348;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qtCjnm/puTsZsa/2CwFjtGJb+lx6edEGVd7fXIrsF7U=;
        b=MITpPYRmKC76OrAoWUp94M7jeuV2pO+JSLW+G41S4IwJRBv2mOpNCgIc+k4Py31eYO
         2rH5L0XMmt2YxwZDzFrDBiIT1WkJOyaaSaVfCRJrpXMKIjrpeRFcarySpgfA0+ke6maj
         bC5uMkI9D8b/8uJPFesPeVMa+gWFKqfnugdMC5ui+1N/l8Z+/KorfyUUZQq/rZwkiOTU
         yz3OF+3AC84G2kkTvFPYSOspYiwtBdz7GmFocgYZXWo35JgrnCDVDrhDEhAlW+YLDKdq
         MeyL8fMkACqmLkPTnWWAAvfm5MD7d79Ys306FIYhbyIMQ3I7yS4yDqpSnIx72FpxW248
         RX6Q==
X-Gm-Message-State: AOJu0YzOrWXGuaASEk2Tdo4rAnqBJCsaDIwjo2hftUhSTCmCKDcj5d0D
	42bGoh1OI05TcnGbrWMK5qOOuRODQAR3xkSwRHfHqrbnDi1diSdpU3qWt8s/kRBjrrpcC2kLAKS
	c4MsvfKITGAmQeBQnBbKCfiGm/WEeUbfl09iVJ3cBVaI7XqXEo8AJJgILkfq+VA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c6:b0:4a3:4598:f390 with SMTP id
 5614622812f47-4af5e3d7eabmr18997623b6e.17.1785806548189; Mon, 03 Aug 2026
 18:22:28 -0700 (PDT)
Date: Mon, 03 Aug 2026 18:22:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a713ed4.d35e88fd.de8b.0007.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_copy_do
From: syzbot <syzbot+a036bdf7d7bad319e404@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92e3f6ef4ffb Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=117200d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a42e870a0b0ae0
dashboard link: https://syzkaller.appspot.com/bug?extid=a036bdf7d7bad319e404
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75ce25b4a6ef/disk-92e3f6ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14bda28d7d38/vmlinux-92e3f6ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/247283a18992/Image-92e3f6ef.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a036bdf7d7bad319e404@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in fuse_copy_do+0x1a0/0x38c fs/fuse/dev.c:-1
Read of size 64 at addr ffff0000cbe00888 by task syz.7.1148/9889

CPU: 1 UID: 0 PID: 9889 Comm: syz.7.1148 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/02/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x17c/0x1ac mm/kasan/generic.c:200
 __asan_memcpy+0x3c/0x84 mm/kasan/shadow.c:105
 fuse_copy_do+0x1a0/0x38c fs/fuse/dev.c:-1
 fuse_copy_one+0xc4/0x130 fs/fuse/dev.c:1215
 fuse_copy_args+0x2a8/0x398 fs/fuse/dev.c:1233
 fuse_dev_do_read+0xac8/0xfe8 fs/fuse/dev.c:1507
 fuse_dev_read+0x140/0x1c8 fs/fuse/dev.c:1586
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x498/0x8c8 fs/read_write.c:574
 ksys_read+0x12c/0x228 fs/read_write.c:717
 __do_sys_read fs/read_write.c:726 [inline]
 __se_sys_read fs/read_write.c:724 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:724
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

Allocated by task 9885:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2d4/0x624 mm/slub.c:5420
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 fuse_new_init fs/fuse/inode.c:1519 [inline]
 fuse_send_init+0x64/0x630 fs/fuse/inode.c:1579
 fuse_fill_super+0x100/0x124 fs/fuse/inode.c:1990
 vfs_get_super+0xb8/0x148 fs/super.c:1327
 get_tree_nodev+0x2c/0x3c fs/super.c:1346
 fuse_get_tree+0x240/0x324 fs/fuse/inode.c:2055
 vfs_get_tree+0x90/0x28c fs/super.c:1754
 fc_mount+0x24/0xac fs/namespace.c:1193
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x2a4/0x538 fs/namespace.c:3834
 path_mount+0x5f0/0xa88 fs/namespace.c:4154
 do_mount+0xe8/0x148 fs/namespace.c:4167
 __do_sys_mount fs/namespace.c:4383 [inline]
 __se_sys_mount fs/namespace.c:4360 [inline]
 __arm64_sys_mount+0x334/0x380 fs/namespace.c:4360
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

Freed by task 9885:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x188/0x690 mm/slub.c:6566
 process_init_reply+0xdc/0x1b30 fs/fuse/inode.c:1503
 fuse_send_init+0x378/0x630 fs/fuse/inode.c:1594
 fuse_fill_super+0x100/0x124 fs/fuse/inode.c:1990
 vfs_get_super+0xb8/0x148 fs/super.c:1327
 get_tree_nodev+0x2c/0x3c fs/super.c:1346
 fuse_get_tree+0x240/0x324 fs/fuse/inode.c:2055
 vfs_get_tree+0x90/0x28c fs/super.c:1754
 fc_mount+0x24/0xac fs/namespace.c:1193
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x2a4/0x538 fs/namespace.c:3834
 path_mount+0x5f0/0xa88 fs/namespace.c:4154
 do_mount+0xe8/0x148 fs/namespace.c:4167
 __do_sys_mount fs/namespace.c:4383 [inline]
 __se_sys_mount fs/namespace.c:4360 [inline]
 __arm64_sys_mount+0x334/0x380 fs/namespace.c:4360
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

The buggy address belongs to the object at ffff0000cbe00800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 136 bytes inside of
 freed 512-byte region [ffff0000cbe00800, ffff0000cbe00a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10be00
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0001c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0001c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 05ffc00000000002 fffffdffc32f8001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000cbe00780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000cbe00800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000cbe00880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff0000cbe00900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000cbe00980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
