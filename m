Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D53CE0A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188445; cv=none; b=hRMyKcL6JkyGMfc92qRgnDhTUbuPxzWTs11Bsj9TMj+fMBOCiE4CxH46n+4WxJHzhuOzgOVPLKSErz7kvJS3z/gvgsus9cfjHWpHxJ6H1KsONkttaC6cZPiYW/iWPRH4NATMl9f23wrzR2wiigaUO3Jk0scN3XVexuZDwS+EW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188445; c=relaxed/simple;
	bh=jP9GlLnCfTYsTc0ZkWUQwN3VvlU1JTrOkIKH6mpiI5o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PHjZrI6Eq+c9gaJNHAVtO0B45ot2n/4dxHbyN9NKG/59PdPBsAgm6mPFEnRiXY0Z13FCA8AGagp7X5mwR7QKgxN3zEc6m9aRpU+nUptvtrsK8SEBc/LKPNOK20qyHXSF6bjhvC9lZyg9Q17VIXGdz+43aEEE0Vs4W8E8aEIT+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-823d73ffca1so442036a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 15:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792188442; x=1792793242;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRX6nE7l1sdJons8idrt7SBnfPjXDg2HfzlJNzfEMOc=;
        b=kRSfECbGFAvSOrSeOPRjQvCS8WDZMjSiZPlyBIQvNF0gsM7IeTjBuYTqR9/lArvmE7
         Cbo0o4BDxVaHh3hTXAaou2SGBEK0ZR2tWf5iK/E0CQlxVwJX8HOfmALw1qRjhlNWYcEw
         6KtUrrv+JN5LFq25PNqG9RpsRiObRpX5arWAL2ytMn93XWDq+50Dv1x4LeAL6EO/c6J+
         4P68LXs4x5p137WBk3ps37TrtMz5HZMAk908+pr1AHLxYYUBa8vgL7EmvCLctN0KfEcQ
         ST5BZBkIT+Df35HXZsXrohgN3duEtXKXxWPyvIairA1xxuTgUCmHRXSjLwaSryDMkyc3
         eOdQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5ZPv4p6m32LSlIPQVfKaGFIZq99r/Y2k8KFNRec94wfW8NTHizbipWgSP43R6Va6z7/lzNEDigOFB+8Pk@vger.kernel.org
X-Gm-Message-State: AFq9FYIXYyT8lCXiD6344RtsGgMGrJ77FivwldD2x6D38ohHbmICG2zD
	WOFc4yz/Y1efCARuWQwF3vQMIRfqUTnqqrAMrAUVA84eCLFfP6+dPVdbcYdZ+DqNQfMLs+4+bVQ
	FYwkHLwEg7kOigPW8JNfHKPzlo/cP66Q7d/E96pF0Ym0qbr+bm/tsnmGupYc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:444b:b0:4f5:eaac:517a with SMTP id
 5614622812f47-53cc22e2983mr832664b6e.1.1792188442403; Fri, 16 Oct 2026
 15:07:22 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:07:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad2a01a.6814cce4.34c49f.0013.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Write in config_item_put
From: syzbot <syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f2f7eeef8b0 Merge tag 'soc-fixes-7.3-3' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d4a69c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b38d39c45202f4fa
dashboard link: https://syzkaller.appspot.com/bug?extid=63336d70e1af377d7388
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15490031580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4a69c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3699c762a33/disk-2f2f7eee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/911702ec7630/vmlinux-2f2f7eee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e76f95f5acb/bzImage-2f2f7eee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:389 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:432 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:450 [inline]
BUG: KASAN: slab-use-after-free in kref_put include/linux/kref.h:64 [inline]
BUG: KASAN: slab-use-after-free in config_item_put+0x26/0x90 fs/configfs/item.c:149
Write of size 4 at addr ffff88803b6444b4 by task syz-executor324/5709

CPU: 1 UID: 0 PID: 5709 Comm: syz-executor324 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:389 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 kref_put include/linux/kref.h:64 [inline]
 config_item_put+0x26/0x90 fs/configfs/item.c:149
 configfs_symlink+0x6be/0x11d0 fs/configfs/symlink.c:225
 vfs_symlink+0x18b/0x330 fs/namei.c:5823
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5848
 __do_sys_symlinkat fs/namei.c:5868 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5863
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08b938f639
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff52171fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00312f7374726f70 RCX: 00007f08b938f639
RDX: 0000200000000480 RSI: 00000000ffffff9c RDI: 0000200000000440
RBP: 00000000000f4240 R08: 0000000000000009 R09: 0000000000000009
R10: 0000000000000009 R11: 0000000000000246 R12: 0000000000027904
R13: 00007fff52171fbc R14: 00007fff52171fd0 R15: 00007fff52171fc0
 </TASK>

Allocated by task 5712:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 nvmet_ports_make+0xe6/0xf00 drivers/nvme/target/configfs.c:2054
 configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
 vfs_mkdir+0x408/0x620 fs/namei.c:5439
 filename_mkdirat+0x289/0x520 fs/namei.c:5472
 __do_sys_mkdir fs/namei.c:5499 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5496
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5712:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6802
 config_item_cleanup fs/configfs/item.c:128 [inline]
 config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
 configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1580
 vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5544
 filename_rmdir+0x292/0x520 fs/namei.c:5601
 __do_sys_rmdir fs/namei.c:5624 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5621
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803b644000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1204 bytes inside of
 freed 4096-byte region [ffff88803b644000, ffff88803b645000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3b640
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ffbf140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ffbf140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4964, tgid 4964 (udevd), ts 37671613888
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2591/0x2600 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x230/0x5c0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x339/0x690 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x54b/0x790 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 tomoyo_realpath_from_path+0xef/0x640 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x229/0x470 security/tomoyo/file.c:776
 security_file_open+0xa9/0x240 security/security.c:2739
 do_dentry_open+0x4be/0x1420 fs/open.c:973
 vfs_open+0x3b/0x350 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1448/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
page last free pid 4965 tgid 4965 ts 37659265486 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xf8e/0x1070 mm/page_alloc.c:2962
 __slab_free+0x250/0x2a0 mm/slub.c:5823
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 __kmalloc_cache_noprof+0x353/0x680 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 kernfs_fop_open+0x3a7/0xcf0 fs/kernfs/file.c:634
 do_dentry_open+0x849/0x1420 fs/open.c:996
 vfs_open+0x3b/0x350 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1448/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803b644380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803b644400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803b644480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88803b644500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803b644580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
