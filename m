Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C627144B
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475940; cv=none; b=VpTNsWH8oHm5/VTDwtir5SsBPc7X6zgfW/gkKgTXczGmXIM1TaK2TwfTkzy2Udbz0fX25BAzAe71AYC/kRPeicD4HqAauOD+WKmqer+lcQw7wpY4YAq0E5uejruko58OuTdTAtTi9u7CAKEHmZOBGY9SQnUFzgZpVveTdhfpm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475940; c=relaxed/simple;
	bh=ozqgafmVTtOEvnZi3wxjZXVjv1AW4EGFhgeCujVqn8g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cvpET4oFSxQxsgLui2JHaLnMfabc0AudiraGZBvc/N9xuB6yEXcXSPHWYbe4Q98ApJRA/6OtBUwyGlmBngN3fjZdIv6psV3DiTgec/Q1yLfU9yOzPNwH+vonVo9cOEzq4wTFdnMru8qHmZ+2gTaGtgAp/5ykOnia+NI1q4YQpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69d6b83bec7so2970061eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 11:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475937; x=1780080737;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07ouaPImJ2zz2vE9eCvEYZY7TA2Yw5xcbZOF9q9UFlg=;
        b=L9xU5CxMjZjjNWpD6CwXfNL3DiYWilRJLgfozSTtTucoQS8mDUZP0ieAwIOxP3d8Yi
         JK4v1tuI1BxQCrZVe5uuuCypY+nq9ezqpeNABzyVTI7y4H9YADUjK0N1b+4mTKS7xW66
         gDv0b4Y1uNiqyZk4oPpFA377UmC3akDMLvqiZiENMQnsrWjMhZW41SUNyzZig1/VhZej
         Rx4XZ/0fQ06t03yn0X3o/SOmMXmN5R2C6he59+9urqwHlBvndMvQ9TLiYdLjzdmm7Ob4
         xZHn889t318Brb4gBx677+pk/WQOZJzt+EdiZlFu8ttjhjeVFFFoLqDBCLC+a8lBu9kz
         3fBQ==
X-Forwarded-Encrypted: i=1; AFNElJ80cgYAYyb2Z6Gejh/rY7XNoMR5LMPPYs7D0GJYKIN3RJm1BrmQ25Q4l+8+Xd11AOpyHMqWTqtyQz1PSq4k@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtWR3rW8YeQcWwLr2HsQDQGeiNGgdxcwoqlHEFi0sRwrcbN/+
	YO5pD4QrCwAZugBk+V+h6k/xTdW9+Wda8RUc51YIk5x6s3q11qM+GVp4OR2WLP3PySbDlWN78Wj
	X+na4nNGAT+RhFa6l8cUfOtgsqK14xOD2XcVn+YY9qwVQHgtIJoK5zJX1Hys=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:99a:b0:69b:3a3c:23d0 with SMTP id
 006d021491bc7-69d7ec6ab4cmr2581078eaf.34.1779475937416; Fri, 22 May 2026
 11:52:17 -0700 (PDT)
Date: Fri, 22 May 2026 11:52:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a10a5e1.050a0220.66ea1.0008.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in clear_tfile_check_list
From: syzbot <syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80dd246accce Add linux-next specific files for 20260518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ca9fba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a0b5969e136a632
dashboard link: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1598082e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ac6596580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e187606d6dc/disk-80dd246a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96a72e613393/vmlinux-80dd246a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2905548782c/bzImage-80dd246a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00007f129c6a5fa0 RCX: 00007f129c42ce59
RDX: 0000000000000005 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007ffeb1d5c4f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00002000000004c0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f129c6a5fac R14: 00007f129c6a5fa0 R15: 00007f129c6a5fa0
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
Read of size 8 at addr ffff88803f021568 by task syz.0.74/5985

CPU: 1 UID: 0 PID: 5985 Comm: syz.0.74 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
 do_epoll_ctl_file+0x8fd/0xed0 fs/eventpoll.c:-1
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f129c42ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb1d5c488 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007f129c6a5fa0 RCX: 00007f129c42ce59
RDX: 0000000000000005 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007ffeb1d5c4f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00002000000004c0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f129c6a5fac R14: 00007f129c6a5fa0 R15: 00007f129c6a5fa0
 </TASK>

Allocated by task 5985:
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

Freed by task 5985:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6284 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6411
 ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
 ep_insert+0x1372/0x1820 fs/eventpoll.c:-1
 do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803f021560
 which belongs to the cache ep_head of size 16
The buggy address is located 8 bytes inside of
 freed 16-byte region [ffff88803f021560, ffff88803f021570)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88803f0213e0 pfn:0x3f021
memcg:ffff88803d044001
flags: 0x80000000000200(workingset|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000200 ffff888140419c80 ffffea0000a5dc90 ffff888020ecdf88
raw: ffff88803f0213e0 0000000800800078 00000000f5000000 ffff88803d044001
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4982, tgid 4982 (udevd), ts 45918061529, free_ts 45769000837
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
page last free pid 21 tgid 21 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1420 [inline]
 __free_frozen_pages+0x1075/0x11b0 mm/page_alloc.c:2958
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:299
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core kernel/rcu/tree.c:2869 [inline]
 rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88803f021400: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff88803f021480: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>ffff88803f021500: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
                                                          ^
 ffff88803f021580: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff88803f021600: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
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
