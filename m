Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1E2931C1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854349; cv=none; b=TkFUKnmgvs/BXqM/HmMZaTxqBJxVw3lc6Hfq8f6QWZ8qhJueiVjGQn6mQGPyylF4vFObPErzr6XGSV15N9auVvhijnw+ZhtdXdeGnxxua8jHWc3lATfxkLzhBLIYmdDdYcylSeGvF3DJHIyMyYHmhbRQSQoFoFX4GRruwH0Jv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854349; c=relaxed/simple;
	bh=4/692jVhaggUhmvtIIN6uGkRPLtp/W/+oGInbi2RDH8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MQLlaTOLAuwfBRpMYC/stuIeycjSmWsmsXEZFtK7gQi9e66dLFVMCLaN4QAkXrnqlqqZHLc6CW5BTUjNnuL2Jx84KptzL28CHNNar6UGU3DANaKTi+1AQfM2tlvoHBMcjCWkC8AwoSDFcPqHBr8U/xSBQtg6hFgI88VuG+8sVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-49d4cb3ca23so1761277b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 17:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854346; x=1785459146;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyAxD37TWVSepR3ShluGEV8x/gxQ6NU2UhdFjb2C2gw=;
        b=ddi0Ldyi9Mm0gUsL9PLJR7F0KTbbzIaukGXKVixsSr4T/MigMmwgDOqELpRNpmjJ/q
         a2oHShN8NQ0cFZEWN0hUrZ74G0kueF03+T4HxRxcBvyq22DUHREaGPvNBAwpvBX4nEq+
         Gchb3bYgMpEsTq4S/96zoyjKxe3dhLDwFCdp3t6yN3x+sVHpWcKvBC+wAeOL6Tzy3dnA
         Dq6dRwsZeeSkVgparIkq0MTSs44PLTXgNYFz4Tiet7yDWyXd36VzjD+dURyAWbGnOCLI
         W2p88uOHPWur0Jo6a42GIQVbEpwmtqBWvOj3nSNaMHbiODsz7h4DQS8uJ9JfwG+omkpE
         SIAA==
X-Forwarded-Encrypted: i=1; AHgh+Rrymr3MZ0N6smZR7C6naTDJrjAkpRyFikYmjOlthuBc42lR9ypHcnt9ChakdyFDFXvODI1wtd2oYrPMROt3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj5+IKIKQfVKWVqjv4TMVpyps4fWZEsxX5IMCEX+10UDUvXWD
	u1+N4QV3tgwUMZPsicwySlvL9a3K0YEELpsNE1rSkVXprpHfvK2WMr8kFT0juTKgp8IjVL2Ahvp
	yxw/b64283TYnMPmMq0VrFpwh7++jJswrwXAa4kblHUGB4e7Qty1CQXEEzxc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2395:b0:4ab:26bc:3028 with SMTP id
 5614622812f47-4ab3526308cmr2778367b6e.3.1784854346345; Thu, 23 Jul 2026
 17:52:26 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:52:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a62b74a.dde6c935.cf6c8.0008.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_dev_do_read (2)
From: syzbot <syzbot+25e06c2622d48c699eed@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc2b5f627e8c Add linux-next specific files for 20260714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1426a2b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4e737f7aa7da317
dashboard link: https://syzkaller.appspot.com/bug?extid=25e06c2622d48c699eed
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d5593fe83f5/disk-cc2b5f62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1d68ced6112/vmlinux-cc2b5f62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84247e9683fa/bzImage-cc2b5f62.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25e06c2622d48c699eed@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in fuse_dev_do_read+0x11e9/0x1260 fs/fuse/dev.c:1608
Read of size 1 at addr ffff88805f9b2818 by task syz.4.60/5955

CPU: 0 UID: 0 PID: 5955 Comm: syz.4.60 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 fuse_dev_do_read+0x11e9/0x1260 fs/fuse/dev.c:1608
 fuse_dev_read+0x16a/0x200 fs/fuse/dev.c:1694
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x59e/0xa90 fs/read_write.c:574
 ksys_read+0x156/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f980f22e6ce
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f980d4c5f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f980d4c66c0 RCX: 00007f980f22e6ce
RDX: 0000000000002000 RSI: 0000200000004100 RDI: 0000000000000003
RBP: 00007f980f303eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000200000006d80 R14: 00007f980f4f5fa0 R15: 00007ffce2bcf0a8
 </TASK>

Allocated by task 5961:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3cd/0x670 mm/slub.c:5486
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 fuse_new_init fs/fuse/inode.c:1445 [inline]
 fuse_send_init+0x58/0x820 fs/fuse/inode.c:1506
 vfs_get_super fs/super.c:1399 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1418
 fuse_get_tree+0x29d/0x3b0 fs/fuse/inode.c:1899
 vfs_get_tree+0x92/0x2a0 fs/super.c:1941
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3777 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3853
 do_mount fs/namespace.c:4186 [inline]
 __do_sys_mount fs/namespace.c:4402 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4379
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5961:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2706 [inline]
 slab_free mm/slub.c:6388 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6703
 process_init_reply+0x174/0x21b0 fs/fuse/inode.c:1424
 fuse_send_init+0x506/0x820 fs/fuse/inode.c:1521
 vfs_get_super fs/super.c:1399 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1418
 fuse_get_tree+0x29d/0x3b0 fs/fuse/inode.c:1899
 vfs_get_tree+0x92/0x2a0 fs/super.c:1941
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3777 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3853
 do_mount fs/namespace.c:4186 [inline]
 __do_sys_mount fs/namespace.c:4402 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4379
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805f9b2800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 24 bytes inside of
 freed 512-byte region [ffff88805f9b2800, ffff88805f9b2a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88805f9b2400 pfn:0x5f9b0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff88813feaec80 ffffea0000a7b710 ffffea0000a15f10
raw: ffff88805f9b2400 000000080010000d 00000000f5000000 0000000000000000
head: 0080000000000240 ffff88813feaec80 ffffea0000a7b710 ffffea0000a15f10
head: ffff88805f9b2400 000000080010000d 00000000f5000000 0000000000000000
head: 0080000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5592, tgid 5592 (syz-executor), ts 88067380890
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
 __do_kmalloc_node mm/slub.c:5338 [inline]
 __kmalloc_noprof+0x543/0x790 mm/slub.c:5364
 _kmalloc_noprof include/linux/slab.h:973 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x149/0x890 net/ipv6/route.c:3833
 addrconf_f6i_alloc+0x38b/0x630 net/ipv6/route.c:4702
 fixup_permanent_addr net/ipv6/addrconf.c:3611 [inline]
 addrconf_permanent_addr+0x4ab/0xa30 net/ipv6/addrconf.c:3662
 addrconf_notify+0x864/0x1050 net/ipv6/addrconf.c:3729
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2292 [inline]
 call_netdevice_notifiers net/core/dev.c:2306 [inline]
 __dev_notify_flags+0x31e/0x510 net/core/dev.c:9805
 netif_change_flags+0xde/0x1b0 net/core/dev.c:9834
 do_setlink+0xdd6/0x4670 net/core/rtnetlink.c:3246
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88805f9b2700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805f9b2780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805f9b2800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88805f9b2880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805f9b2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
