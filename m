Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794761196;
	b=yokCX+APilqY5hZA9LthXEW6nX5ne8N8kFnt0F879PoAfZMlwhV6894UI0a7IuPgw58G
	 QnxdtMFrRfvMz4nKoHjlR9dRs0uhS22wWyGy2sd0BcYCiBt4EIIS/FcU0Er1CNVDpiD41
	 N0tZqPv9496OC+2GXqgW5ct/nOAKcxCKyWlOGhPmriu6wL06+nMV/GuE+Ss0b2rRRqG7l
	 PoGqS4QcaS1FqYlgPudmhPHnmir+samThNOg2egKbSkDLxyFVzyIXRQeLTkrY4fgqod2X
	 42pFMv8TljuRW4FnUANF4cvnljCeSmkUWNBwX5EibDyJAkcKxLKAOlwUJJVgDob/X1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761196;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=IigkRWKWr+odYFJBZzviN42v67VY7zEQS2aC4gMD2vM=;
	b=xOsHAeJSwmIFWqJhU3VcEss0oqYAma9MemXBXRhTGxXbhsCSynIFNXFYDU13TB1Vi+a1
	 m8599e1UNUVIWEfYY9eP5+tUifMOw7subEjd118qCN9BRa5TZFVxCE0hXfO3sDCvCHhy8
	 S80TtybVT9oPtsyczpC8DyZcvu5nnPjmNOmXgoa3qbwoHcGaPHWGpMbqZwCILvf8E0CII
	 9Jk9GDk0kHWO509r6Gp2Lx3ajzYAKQqlb3Pz6omUgMt/nEmS9OpQpuQJ9BToC+vlk0EDC
	 d9Cm/pFdfcR71Rdy2dfnwZK7V0yphpeooFPcTPP5QK4uAMy3FIqw34wj6QsXY/awsnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE058606A31E
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 16:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE058606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a7de733fa9so3372096b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 08:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794761195; x=1795365995;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IigkRWKWr+odYFJBZzviN42v67VY7zEQS2aC4gMD2vM=;
        b=ZBnyx26DHwuDck+bgyumwwtlDeK6+bTqw63qMEp2SYmxNnecvYuJeSIXOOYoJPLQxP
         HOAXZeYFEzc3UZA7koy/YAeg4dSvSzcGgftB69oOF45xhkkeBq/jtvpLM60ojIpvlSP4
         7KLK5H09raXSS+lpnc2buolr1z5h7S2FJDwRgjSexu/Iu2I9qSrQ4Dwu1/ayA4YbScUo
         RutqXpB4hcWx1RjJkrv0Yoqz+fQQbjNW+E8rgg3DFNCad9sTsJRmaKEod2BQqt4CziDH
         M7QQGZYqkWjWZZKx/3EjEMdCR3TQJRG7RSt3scC8+2RmDZRJVM0hYE8gTfXaUOjDmc6h
         Ir1g==
X-Forwarded-Encrypted: i=1; AL+hErH+bmI/yWHtJa1uz7TDN4Pij2qhf7qyixrtbj7zpA3nH9XDAxxtTrJUaApx24nEcIQEVJHRuzQjvXDysIM9@vger.kernel.org
X-Gm-Message-State: APuU4Z/DW6OFYG09grbnbsDP9QD8C5kudt4tU/zffmjcGWFmFnQWdSjL
	AJwnM5cktiREAtHVIrXkTR/6nSeAwQlAkES7yG8cVtyrDl/5s/CPa8KBZS1HXJjbhWaOoqYeV+g
	6njZ+3d+4z4TsGL5XQrwNEudzexorGN5w0FULHHtC3methwlcw0HmnuwRZ4w=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6809:211:10b0:571:7f0f:924a with SMTP id
 5614622812f47-5717f10b319mr3300396b6e.35.1794761195052; Sun, 15 Nov 2026
 08:46:35 -0800 (PST)
Date: Sun, 15 Nov 2026 08:46:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af9e1eb.920b2b3a.148c65.002f.GAE@google.com>
Subject: [syzbot] [fs?] [driver-core?] KASAN: slab-use-after-free Read in cdev_put
From: syzbot <syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2800868f6322 Merge tag 'sound-7.4-rc3' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1386fe4e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c210800cfc8f61e
dashboard link: https://syzkaller.appspot.com/bug?extid=667788430769ef9ddf25
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c4cb69580000

AI-generated root cause summary:
In posix_clock_register() (kernel/time/posix-clock.c), clk->dev and
clk->cdev.owner are assigned only after cdev_device_add(&clk->cdev, dev)
returns. As soon as cdev_add() executes inside cdev_device_add(), the character
device is live and can be opened by userspace. If posix_clock_open() runs in
this window while clk->dev is still NULL, get_device(clk->dev) is a no-op and
fails to acquire a reference on the device. When the file is later closed,
posix_clock_release() calls put_device(clk->dev) on the now-initialized pointer,
causing an unbalanced reference drop that prematurely frees the struct
ptp_clock; subsequent invocation of cdev_put(inode->i_cdev) in __fput() then
accesses the freed memory, causing a slab use-after-free.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=667788430769ef9ddf25

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com

=========================
==================================================================
BUG: KASAN: slab-use-after-free in cdev_put fs/char_dev.c:363 [inline]
BUG: KASAN: slab-use-after-free in cdev_put+0x58/0x60 fs/char_dev.c:360
Read of size 8 at addr ffff888043a4a090 by task syz-executor804/6199

CPU: 2 UID: 0 PID: 6199 Comm: syz-executor804 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 cdev_put fs/char_dev.c:363 [inline]
 cdev_put+0x58/0x60 fs/char_dev.c:360
 __fput+0x904/0xb50 fs/file_table.c:515
 fput_close_sync+0x118/0x250 fs/file_table.c:618
 filp_close_sync+0x75/0xa0 fs/open.c:1574
 close_files fs/file.c:572 [inline]
 put_files_struct fs/file.c:584 [inline]
 put_files_struct+0x1f7/0x390 fs/file.c:581
 switch_files_struct fs/file.c:598 [inline]
 exit_files+0x85/0xb0 fs/file.c:604
 do_exit+0x896/0x2a00 kernel/exit.c:977
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1123
 __do_sys_exit_group kernel/exit.c:1134 [inline]
 __se_sys_exit_group kernel/exit.c:1132 [inline]
 __ia32_sys_exit_group+0x3e/0x50 kernel/exit.c:1132
 ia32_sys_call+0x1a39/0x1a40 arch/x86/include/generated/asm/syscalls_32.h:253
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x14d/0x8e0 arch/x86/entry/syscall_32.c:286
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:311
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7e91fbc
Code: Unable to access opcode bytes at 0xf7e91f92.
RSP: 002b:00000000f5e85688 EFLAGS: 00000292 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000ffffffe8
RDX: 00000000000000fc RSI: 00000000f5e856d0 RDI: 00000000f5e856d0
RBP: 00000000f5e856d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 6126:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5680
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 ptp_clock_register+0x187/0x1780 drivers/ptp/ptp_clock.c:343
 ptp_vclock_register+0x51f/0xa10 drivers/ptp/ptp_vclock.c:256
 n_vclocks_store+0x1b1/0x600 drivers/ptp/ptp_sysfs.c:230
 dev_attr_store+0x58/0x80 drivers/base/core.c:2509
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:575 [inline]
 vfs_write+0x6af/0x1040 fs/read_write.c:667
 ksys_pwrite64+0x113/0x230 fs/read_write.c:774
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x16a/0x670 arch/x86/entry/syscall_32.c:170
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598

Freed by task 6199:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6923
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3886
 posix_clock_release+0xd5/0x150 kernel/time/posix-clock.c:142
 __fput+0x3fb/0xb50 fs/file_table.c:512
 fput_close_sync+0x118/0x250 fs/file_table.c:618
 filp_close_sync+0x75/0xa0 fs/open.c:1574
 close_files fs/file.c:572 [inline]
 put_files_struct fs/file.c:584 [inline]
 put_files_struct+0x1f7/0x390 fs/file.c:581
 switch_files_struct fs/file.c:598 [inline]
 exit_files+0x85/0xb0 fs/file.c:604
 do_exit+0x896/0x2a00 kernel/exit.c:977
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1123
 __do_sys_exit_group kernel/exit.c:1134 [inline]
 __se_sys_exit_group kernel/exit.c:1132 [inline]
 __ia32_sys_exit_group+0x3e/0x50 kernel/exit.c:1132
 ia32_sys_call+0x1a39/0x1a40 arch/x86/include/generated/asm/syscalls_32.h:253
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x14d/0x8e0 arch/x86/entry/syscall_32.c:286
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:311
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888043a4a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 144 bytes inside of
 freed 4096-byte region [ffff888043a4a000, ffff888043a4b000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43a48
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801d443040 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801d443040 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 04fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6143, tgid 6143 (udevd), ts 68631299502
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1860
 prep_new_page mm/page_alloc.c:1868 [inline]
 get_page_from_freelist+0xdae/0x2c80 mm/page_alloc.c:3950
 __alloc_frozen_pages_noprof+0x2ad/0x31e0 mm/page_alloc.c:5492
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab mm/slub.c:3499 [inline]
 new_slab+0xb1/0x6d0 mm/slub.c:3550
 refill_objects+0xe3/0x410 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __do_kmalloc_node mm/slub.c:5530 [inline]
 __kmalloc_noprof+0x677/0x840 mm/slub.c:5556
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 tomoyo_realpath_from_path+0xb6/0x690 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x276/0x460 security/tomoyo/file.c:827
 tomoyo_path_unlink+0x91/0xe0 security/tomoyo/tomoyo.c:162
 security_path_unlink+0x145/0x2b0 security/security.c:1498
 filename_unlinkat+0x316/0x770 fs/namei.c:5734
 __do_sys_unlink fs/namei.c:5772 [inline]
 __se_sys_unlink fs/namei.c:5769 [inline]
 __x64_sys_unlink+0x46/0x70 fs/namei.c:5769
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x780 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5200 tgid 5200 ts 68611259383 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x7b1/0x10f0 mm/page_alloc.c:2958
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:5033 [inline]
 kmem_cache_alloc_lru_noprof+0x265/0x6a0 mm/slub.c:5066
 shmem_alloc_inode+0x25/0x50 mm/shmem.c:5374
 alloc_inode+0x68/0x250 fs/inode.c:338
 new_inode+0x22/0x1c0 fs/inode.c:1192
 __shmem_get_inode mm/shmem.c:3285 [inline]
 shmem_get_inode+0x1e3/0xff0 mm/shmem.c:3361
 shmem_mknod+0x217/0x480 mm/shmem.c:4072
 lookup_open+0xd8a/0x19e0 fs/namei.c:4575
 open_last_lookups fs/namei.c:4774 [inline]
 path_openat+0xe75/0x23f0 fs/namei.c:5013
 do_file_open+0x20e/0x430 fs/namei.c:5045
 do_sys_openat2+0x163/0x1d0 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x780 arch/x86/entry/syscall_64.c:89

Memory state around the buggy address:
 ffff888043a49f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043a4a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888043a4a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888043a4a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043a4a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
