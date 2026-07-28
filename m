Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DB448392
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248141; cv=none; b=Yrzg5hGBPVLVEmjf3TPDeWv0SSTgZvUmpB1oyw9eH5L+U7OTK6dD0o4ocYIBr57xTxtpgGXDU8SnvNqFN9FdtcvaVQK3lzEDfPxefKCLfj8GQ+mMkVqv8YBYKQm+jLcbJUMXu+YRy5tg102vRaGp2D3BNHEYd8VKSkAC8vveWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248141; c=relaxed/simple;
	bh=9rh6njKEo3Kjz/ULaqDIFlWzJTM8F1lyc3EB4rgem1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OM7ltKOIwhZB1qt/+8iQgrMY+Fn+V35rGjH+NQPctZ72o30qOm3t7F7TbrXW84yVgpmgyOqxXxZ8hRvjif52yO5R2IUKekmbjHPvBD7rZWsVZpctXv7RMiFMnXP4e/XiYykGibba/mrrYvnXKSCkptFHr6vKa7dC3otEBAIvpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a7de733fa9so4687581b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 07:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248138; x=1785852938;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEd97b/49sGlZ6IySzD/8ow9TZAY8G0+eLrb3JFwIbg=;
        b=l5pP5/ntypaTJP128FFA3sVyYsd8doDei3V+ZWQcDeHiCqouIocAR8/DB1VoOY+U5T
         2PwTHB7y/SM9q9gzyFhlyesTrRqiyo8xLGbNByYEpHh+WTizyLy7c71sRH0lFlR0GfuY
         LHqW+9ZTeSMq1qiDE71BPlc8yssUGoUkk9ZrgeBpBdelnQk71pHIEXb5G5UKLLDISHbB
         lk3zo/GuctcblN+Vqx6eZf9YeDKwtAuy886Xi7DlHlqgbSa6wbSItiUX6O7+r1Xfmq5d
         nJWf0dndAtOwaqJoNUd798Qw5mmkwYxuV/iuXz2b3MCygPc4ALJcd9WZ3gA3ARCRpL7g
         NxaA==
X-Forwarded-Encrypted: i=1; AHgh+Rog1wMo3NkXFsycj9sPzSrvqnyvTOfEbqr8h3LWE00+P3i0k6PTfoRfYE15woYBP6C/yjIdlEYo7SsIfQAI@vger.kernel.org
X-Gm-Message-State: AOJu0YwjufiU6UXtSMqkUUfLGN1Lrxpg/k+SsIMap272jNuoqJFDeuQf
	mzN22nlrKBww44fTeabZk8QYieggCAAC66xwAEQ5vN5/fihuX1Dc4tA1uJuyvxjWP7cN3ZHqcl9
	nwsR+lHESj0La/jpCaxpg06PirEs83CDa3GKzpp8Cb6+Yh+6WFLY4cvWV7ZA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1446:b0:495:feaa:9e39 with SMTP id
 5614622812f47-4ad5b942f71mr1474809b6e.6.1785248138541; Tue, 28 Jul 2026
 07:15:38 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:15:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a68b98a.4c659fcc.19cd90.0026.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in configfs_dirent_is_ready
From: syzbot <syzbot+8358d1f3d9c15bdf1c9a@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc2b5f627e8c Add linux-next specific files for 20260714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134ee6b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2290ccbf984c524f
dashboard link: https://syzkaller.appspot.com/bug?extid=8358d1f3d9c15bdf1c9a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138ec6b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e27746580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6836f8efb1da/disk-cc2b5f62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0109d3477cc7/vmlinux-cc2b5f62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2e49e350bbf/bzImage-cc2b5f62.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8358d1f3d9c15bdf1c9a@syzkaller.appspotmail.com

Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
==================================================================
BUG: KASAN: slab-use-after-free in configfs_dirent_is_ready+0x6d/0x70 fs/configfs/dir.c:363
Read of size 4 at addr ffff888042fc4038 by task syz.3.78/6037

CPU: 0 UID: 0 PID: 6037 Comm: syz.3.78 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 configfs_dirent_is_ready+0x6d/0x70 fs/configfs/dir.c:363
 create_link fs/configfs/symlink.c:85 [inline]
 configfs_symlink+0x616/0x1030 fs/configfs/symlink.c:199
 vfs_symlink+0x18b/0x330 fs/namei.c:5654
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5679
 __do_sys_symlinkat fs/namei.c:5699 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5694
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6fdb4cde99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf02e68f8 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f6fdb755fa0 RCX: 00007f6fdb4cde99
RDX: 0000200000000300 RSI: ffffffffffffff9c RDI: 0000200000000200
RBP: 00007f6fdb563eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6fdb755fac R14: 00007f6fdb755fa0 R15: 00007f6fdb755fa0
 </TASK>

Allocated by task 6037:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4608 [inline]
 slab_alloc_node mm/slub.c:4921 [inline]
 kmem_cache_alloc_noprof+0x358/0x680 mm/slub.c:4935
 configfs_new_dirent+0x59/0x470 fs/configfs/dir.c:193
 configfs_make_dirent fs/configfs/dir.c:259 [inline]
 configfs_create_dir fs/configfs/dir.c:304 [inline]
 configfs_attach_item+0xa1/0xd60 fs/configfs/dir.c:863
 configfs_attach_group+0x2a/0x370 fs/configfs/dir.c:898
 configfs_mkdir+0x6f0/0x9e0 fs/configfs/dir.c:1423
 vfs_mkdir+0x408/0x620 fs/namei.c:5270
 filename_mkdirat+0x289/0x520 fs/namei.c:5303
 __do_sys_mkdirat fs/namei.c:5324 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5321
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6036:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2706 [inline]
 slab_free mm/slub.c:6388 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6515
 release_configfs_dirent fs/configfs/configfs_internal.h:139 [inline]
 configfs_put fs/configfs/configfs_internal.h:156 [inline]
 configfs_d_iput+0x209/0x270 fs/configfs/dir.c:63
 d_delete_notify include/linux/fsnotify.h:379 [inline]
 vfs_rmdir+0x24a/0x6b0 fs/namei.c:5388
 filename_rmdir+0x292/0x520 fs/namei.c:5432
 __do_sys_rmdir fs/namei.c:5455 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5452
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888042fc4000
 which belongs to the cache configfs_dir_cache of size 96
The buggy address is located 56 bytes inside of
 freed 96-byte region [ffff888042fc4000, ffff888042fc4060)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42fc4
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88801f69f780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6024, tgid 6024 (syz.1.68), ts 137140557127
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
 kmem_cache_alloc_noprof+0x455/0x680 mm/slub.c:4935
 configfs_new_dirent+0x59/0x470 fs/configfs/dir.c:193
 configfs_make_dirent+0x35/0x160 fs/configfs/dir.c:259
 configfs_create_file+0xe3/0x130 fs/configfs/file.c:454
 populate_attrs fs/configfs/dir.c:640 [inline]
 configfs_attach_item+0x8df/0xd60 fs/configfs/dir.c:865
 configfs_attach_group+0x2a/0x370 fs/configfs/dir.c:898
 create_default_group+0x87/0x180 fs/configfs/dir.c:720
 populate_groups fs/configfs/dir.c:741 [inline]
 configfs_attach_group+0x169/0x370 fs/configfs/dir.c:914
 configfs_mkdir+0x6f0/0x9e0 fs/configfs/dir.c:1423
 vfs_mkdir+0x408/0x620 fs/namei.c:5270
page last free pid 5732 tgid 5732 ts 137112389589 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x1185/0x1270 mm/page_alloc.c:2962
 ___free_pages_bulk mm/kasan/shadow.c:333 [inline]
 __kasan_populate_vmalloc_do mm/kasan/shadow.c:385 [inline]
 __kasan_populate_vmalloc+0x12d/0x1c0 mm/kasan/shadow.c:424
 kasan_populate_vmalloc include/linux/kasan.h:580 [inline]
 alloc_vmap_area+0xd1a/0x1420 mm/vmalloc.c:2176
 __get_vm_area_node+0x1f2/0x300 mm/vmalloc.c:3279
 __vmalloc_node_range_noprof+0x34e/0x1560 mm/vmalloc.c:4211
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4312
 alloc_thread_stack_node kernel/fork.c:359 [inline]
 dup_task_struct+0x2a0/0x8e0 kernel/fork.c:929
 copy_process+0x820/0x43f0 kernel/fork.c:2132
 kernel_clone+0x2d7/0x940 kernel/fork.c:2765
 __do_sys_clone kernel/fork.c:2907 [inline]
 __se_sys_clone kernel/fork.c:2891 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2891
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888042fc3f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888042fc3f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff888042fc4000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                        ^
 ffff888042fc4080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888042fc4100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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
