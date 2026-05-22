Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07337D11D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479310; cv=none; b=MvvRc6PRMBLVwQAWEUPKHmrwvV8a9Sum2+WM2FecZHJyV1pbpBln39cdRtlGVxfemeAFLfWxMG2T/qcFvZWDAp7qOP1HghqUgEKkBXbiFBJ2dNaqN6R3FGlMTtLL2nryUkV/TrPlGiZuqNq1yTlZaWts+Sxnb1Q1j1FkaEZZG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479310; c=relaxed/simple;
	bh=K1QJPH6hcqdQ5aXTWd1AntEI8d/ebwx3snazPL1qmYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TVxQeXMV7qlAAd+4f2ILjue5A0Rwq0svrdm5RLP69K7CephQ5G9Rwt6daJrzV9bDbsei7SIiXi87DkceaINino4PD+at+jiRePi84Zdjlmc5XSvbbcPjkn9Z6+mG83fE7WlAmE7DRfaJASEppXjt3k485i4WDzGsCdobPVKCa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69d6b83bec7so3011324eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 12:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779479308; x=1780084108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qP5huJ0PDdYYGJkpRgGhCP5+QCYCVzv2WG0wvbiYHgA=;
        b=jrP7fZMTRqSgyVNwYh1MEnhxRTjr+OtunAvZEvjMCMS+ZlYCBBXR1Qdga1bzRrQaZp
         qlKwwTU7K0mWQFLl7tLZX9wubtnkBkusPW+7Wsz+BJurZPZmTiVZqL+w/JaAiGpxh75z
         3NJ6YcdkOk3F78328rvrNldYuTNEJezK0keDiPUYGrgnREsjSWyJnrcS6QlXkfviu85E
         N/wyUaPoyc/Dntx/2NJydGLaV/ngO84zxSWwt3/BCT1GOX/Mfmn/r64wS+m326WwtdqO
         KNvClg91y0kZbfXFLerXtabGEUD5I1iF6a5y+9UPz8lztwGGMOmf1h6l3TC/2Q7NujCp
         6c/g==
X-Forwarded-Encrypted: i=1; AFNElJ9Ow9KR9EVbKv+Ld04w2cvTU4sJR4O6vbDyX+fuz8KDR2WBjll12vSjFs+gMecoCoSCKQQEtLD/wXQJelGK@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUQgnjXyD3FWs36/5EXstiCXPtnjk5xabBLXRzOwh667AxUEm
	ncPwbkHk1pRoT8FW9B6n4D7bJE6nCWdnmFi2/a42DkLgaAzvAoD+VGK03QteeNUG50f5PPZqrKQ
	x0VTnlJLbREcowZtSlQn/mKsa0Z9Pzl7FCac0yL+zBBJF10eiaCO1d28ijec=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160b:b0:694:8cb0:4efb with SMTP id
 006d021491bc7-69d7eb32e3fmr2493446eaf.8.1779479307848; Fri, 22 May 2026
 12:48:27 -0700 (PDT)
Date: Fri, 22 May 2026 12:48:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a10b30b.050a0220.19f61f.0003.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in reverse_path_check_proc
From: syzbot <syzbot+e70e1b6cba8714543f7c@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80dd246accce Add linux-next specific files for 20260518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=113cba73980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a0b5969e136a632
dashboard link: https://syzkaller.appspot.com/bug?extid=e70e1b6cba8714543f7c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dc9fba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bffcc8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e187606d6dc/disk-80dd246a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96a72e613393/vmlinux-80dd246a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2905548782c/bzImage-80dd246a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e70e1b6cba8714543f7c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in reverse_path_check_proc+0x5b/0x240 fs/eventpoll.c:1663
Read of size 8 at addr ffff88803777f7e0 by task syz.3.20/6001


CPU: 0 UID: 0 PID: 6001 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 reverse_path_check_proc+0x5b/0x240 fs/eventpoll.c:1663
 reverse_path_check fs/eventpoll.c:1692 [inline]
 ep_insert+0xc6c/0x1820 fs/eventpoll.c:1881
 do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f96281fce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f962783d028 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007f9628476090 RCX: 00007f96281fce59
RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000006
RBP: 00007f9628292d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000600 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9628476128 R14: 00007f9628476090 R15: 00007ffcab0f8478
 </TASK>

Allocated by task 5997:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4583 [inline]
 slab_alloc_node mm/slub.c:4912 [inline]
 kmem_cache_alloc_noprof+0x33b/0x680 mm/slub.c:4919
 ep_attach_file fs/eventpoll.c:1751 [inline]
 ep_register_epitem fs/eventpoll.c:1833 [inline]
 ep_insert+0x512/0x1820 fs/eventpoll.c:1876
 do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5997:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6284 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6411
 eventpoll_release_file+0xc2/0x240 fs/eventpoll.c:1386
 eventpoll_release include/linux/eventpoll.h:61 [inline]
 __fput+0x83c/0xa70 fs/file_table.c:501
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xf3/0x4d0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803777f7e0
 which belongs to the cache ep_head of size 16
The buggy address is located 0 bytes inside of
 freed 16-byte region [ffff88803777f7e0, ffff88803777f7f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88803777f280 pfn:0x3777f
memcg:ffff88802b46c801
flags: 0x80000000000200(workingset|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000200 ffff888140ae73c0 ffffea0000e3c510 ffffea0000d70e90
raw: ffff88803777f280 0000000800800024 00000000f5000000 ffff88802b46c801
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4987, tgid 4987 (udevd), ts 71313648267, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1873
 prep_new_page mm/page_alloc.c:1881 [inline]
 get_page_from_freelist+0x27d6/0x2850 mm/page_alloc.c:3954
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5297
 alloc_slab_page mm/slub.c:3289 [inline]
 allocate_slab+0x74/0x5e0 mm/slub.c:3404
 new_slab mm/slub.c:3447 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7226
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4665
 alloc_from_pcs mm/slub.c:4763 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 kmem_cache_alloc_noprof+0x433/0x680 mm/slub.c:4919
 ep_attach_file fs/eventpoll.c:1751 [inline]
 ep_register_epitem fs/eventpoll.c:1833 [inline]
 ep_insert+0x512/0x1820 fs/eventpoll.c:1876
 do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803777f680: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff88803777f700: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
>ffff88803777f780: 00 00 fc fc fa fb fc fc 00 00 fc fc fa fb fc fc
                                                       ^
 ffff88803777f800: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff88803777f880: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
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
