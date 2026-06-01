Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3693DB30D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333716; cv=none; b=LPa7FTw+GWeroWqNHVlkkucd17tfGOl4kwtiqHALqz/bk9abp6EjGdroikoUzyN99jmSgnW9iF2UGYHjUPhMhFJOhd8G5V71VEDqaWqqkgiz4jIb96+hi1bAvKOEMH6mS7OGGVYlyor/+7RBlAy6k9v4T8vhrywKN4AnMeKxp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333716; c=relaxed/simple;
	bh=QFLRkUnU+Y1/YIpCZh358L1fHDey3azHXT8STo4Tb94=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ss4ue6U40FA/q6oseWXHpOW4ZxgTULZL1aTQKfSww5xIJH2QOH4FnZNb9S90tbY64DtCcl+DhS5IiAnwwLp+hJ5zeMe0cEmNUxOU0PXOwA9vG/OWzIPWxahRHXbZQeWD+Z23GbaxHra57t0CFD1akvodAOKmnb+mnbQdN0UQoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-43ccfdb9c48so2517395fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333714; x=1780938514;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlH0p4T75Rt//5cRGeE50uJwlcSwN7VahCpgFd7nuhg=;
        b=T6Yi4dKOzmCbQdsxnGGAa/EEzBL4fejQaozwMLecFzBCuqNoP+DVpUvEapZR4YfoIN
         6zYNj45L9pskTr2Bu3P7MDWvlKr2Kg5V+J+EPXOdHgcf3Wu/xpgLykc4i799cwKrk9bn
         dj+YaaR9KMbU6auNv8AU6UrfU64qtBrvWObkMHu73m7HTQLjyz4RrzpwR10632Pg/1ee
         72g3zlqytZULWpTVIefLFhFpKWVT7AW33qPJ8Efzoe5ahGhEij6YtmF3j7dDxkM0b8g1
         xvHHlD8TpG2P0sXQXJ/UR450HrO2WHnWGrfJ94HYkxAinK8YgEbQLiQccsco5oteTw0x
         dOEg==
X-Forwarded-Encrypted: i=1; AFNElJ++fWwW0scSzqfMI3K0V5j1r1ovcqYeMKA55pMW409fTnH1DsZxABT+tfOF/wtvrsxY3lsjBqEjNCRZVusG@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQ+9lqpVlZZnCPi4SZUpfVhmo9kgito3Ir+wi5DZcKsRLudFD
	ZKPOeu9ywi3w85ZTcpSIf1aWStlzja/uuz78Szx+6trMGFHZli1BtrBInXTvUiZc7UkTqMJv6hR
	koQCy1NtE0mc0/aApgvok2jDkcke3C2KSAw9nSoheVsRVCPpkQqdl6bNRjQY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1743:b0:69d:e6eb:ad37 with SMTP id
 006d021491bc7-69e103c1b62mr5174552eaf.34.1780333713775; Mon, 01 Jun 2026
 10:08:33 -0700 (PDT)
Date: Mon, 01 Jun 2026 10:08:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1dbc91.fbc46276.3c3783.0004.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in current_time
From: syzbot <syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb3f4b7426cf Merge tag 'nfsd-7.1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155429ec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=36e50496c8ac4bcde3f9
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109bb673980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1299f856580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-eb3f4b74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1406171f5cf6/vmlinux-eb3f4b74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19b8bb9b727a/bzImage-eb3f4b74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in is_mgtime include/linux/fs.h:2313 [inline]
BUG: KASAN: slab-use-after-free in current_time+0x354/0x3b0 fs/inode.c:2378
Read of size 2 at addr ffff8880407e4282 by task syz.0.661/9127

CPU: 3 UID: 0 PID: 9127 Comm: syz.0.661 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 is_mgtime include/linux/fs.h:2313 [inline]
 current_time+0x354/0x3b0 fs/inode.c:2378
 atime_needs_update+0x33f/0x6b0 fs/inode.c:2236
 pick_link+0x3b0/0x13c0 fs/namei.c:2040
 step_into_slowpath+0x9ba/0xf90 fs/namei.c:2123
 step_into fs/namei.c:2148 [inline]
 walk_component fs/namei.c:2284 [inline]
 link_path_walk+0xf28/0x1cc0 fs/namei.c:2652
 path_parentat fs/namei.c:2856 [inline]
 __filename_parentat+0x213/0x740 fs/namei.c:2880
 filename_parentat fs/namei.c:2898 [inline]
 filename_unlinkat+0xf7/0x730 fs/namei.c:5537
 __do_sys_unlinkat fs/namei.c:5597 [inline]
 __se_sys_unlinkat fs/namei.c:5589 [inline]
 __x64_sys_unlinkat+0xc0/0x130 fs/namei.c:5589
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2baad9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2babd0b028 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f2bab015fa0 RCX: 00007f2baad9ce59
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f2baae32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2bab016038 R14: 00007f2bab015fa0 R15: 00007ffdc75513d8
 </TASK>

Allocated by task 9127:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_lru_noprof+0x246/0x6e0 mm/slub.c:4918
 alloc_inode+0x183/0x250 fs/inode.c:347
 new_inode+0x22/0x1c0 fs/inode.c:1179
 bpf_get_inode kernel/bpf/inode.c:117 [inline]
 bpf_get_inode kernel/bpf/inode.c:102 [inline]
 bpf_symlink+0x69/0x240 kernel/bpf/inode.c:391
 vfs_symlink fs/namei.c:5643 [inline]
 vfs_symlink+0x178/0x4d0 fs/namei.c:5622
 filename_symlinkat+0x2a6/0x560 fs/namei.c:5668
 __do_sys_symlinkat fs/namei.c:5688 [inline]
 __se_sys_symlinkat fs/namei.c:5683 [inline]
 __x64_sys_symlinkat+0x9c/0xe0 fs/namei.c:5683
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9128:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6378
 destroy_inode+0xcb/0x1c0 fs/inode.c:394
 evict+0x599/0xad0 fs/inode.c:865
 iput_final fs/inode.c:1960 [inline]
 iput.part.0+0x605/0xf50 fs/inode.c:2009
 iput+0x35/0x40 fs/inode.c:1975
 filename_unlinkat+0x466/0x730 fs/namei.c:5572
 __do_sys_unlinkat fs/namei.c:5597 [inline]
 __se_sys_unlinkat fs/namei.c:5589 [inline]
 __x64_sys_unlinkat+0xc0/0x130 fs/namei.c:5589
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880407e4280
 which belongs to the cache inode_cache of size 1088
The buggy address is located 2 bytes inside of
 freed 1088-byte region [ffff8880407e4280, ffff8880407e46c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x407e0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880407e7b81
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801d6bc000 dead000000000100 dead000000000122
raw: 0000000000000000 00000008001a001a 00000000f5000000 ffff8880407e7b81
head: 00fff00000000040 ffff88801d6bc000 dead000000000100 dead000000000122
head: 0000000000000000 00000008001a001a 00000000f5000000 ffff8880407e7b81
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5773, tgid 5773 (syz-executor), ts 108002716269, free_ts 0
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
 kmem_cache_alloc_lru_noprof+0x485/0x6e0 mm/slub.c:4918
 alloc_inode+0x183/0x250 fs/inode.c:347
 iget_locked+0x1d9/0x6d0 fs/inode.c:1474
 kernfs_get_inode+0x46/0x470 fs/kernfs/inode.c:252
 kernfs_iop_lookup+0x1a7/0x2d0 fs/kernfs/dir.c:1274
 lookup_open.isra.0+0x631/0x11b0 fs/namei.c:4484
 open_last_lookups fs/namei.c:4611 [inline]
 path_openat+0xa98/0x31a0 fs/namei.c:4855
 do_file_open+0x20e/0x430 fs/namei.c:4887
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1364
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1381
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880407e4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880407e4200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880407e4280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880407e4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880407e4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
