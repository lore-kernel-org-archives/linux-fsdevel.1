Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9943C1A
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789784138; cv=none; b=cpTWin5fKgoZ/ckwD28VxauwP7wwFRcVKXyl3ly/BB38kxfpqZiPgDJPCbNtArN7r4LO7/Ev4TN87cv6Rs8YFbAfvBURZWYpmiF09B19qZMKdhPV94Ufw76DC8t8iTfFB5b+rXWO1rYWyyPO8pRV5E39Ialny/70FYWWIzHG0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789784138; c=relaxed/simple;
	bh=Wy8+Pw1gQmFFBV9FC2byyz/R2RAkHytLCIqgfgJNq/8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m8fSHgRO6c4GRU+XPw+R2V9dUOEQH2wrj0J+O1lYom0IKUk2uodo8Zt+NdgWUIZpel/ilM22Co8C1XL25hlOmin/8BczjjEde7SUJYSmbxRQRbuFrj+C8ZQkSf4u+N2zJZsmonU9lcUC4czSUQWXrfw2ma9FjCX29Jcr9vk9XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f8.google.com with SMTP id 46e09a7af769-804d58d09e9so388633a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 19:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789784135; x=1790388935;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcNyjs+p1qdhWL9OvECznb7Rg039M9i00b1BFMLdAOY=;
        b=QYKDYmdw7vL/HfQMpYLFcgKdNhE87oSg3KCNcKEydfHPR0m8WSAA55s12308Tmcdt8
         LPWheFSVIh3bEQlim8yGKRv7NAx9D/4u5cesoAjgWRJmO1sTaO4wa/2HGHCCukTK71wB
         41Cgr4zCjX2akXxhnIyq+V6r0NwsAkb17QQSS8b170Kjig/2zEmKp4Ztky+X4kOBrRYA
         QLElVM4Pkmx0Vdfd0aIqtPlv+2/Am05BW1UMs3AWqkq/LjYgPZZrAWkcp70Q++vtVj9I
         z/hiyH4AhH0F73SjxcSzMLRXqCZo94EeNSCivKYSNffvnKe3Caq3yyKPtr3nyd42Cwti
         f72g==
X-Gm-Message-State: AFuF++n7rLD4d5Mze4hQCde+wllhb5mzNMSqqZTQsAtP7bGPLanq3FW3
	2Xz45AkUiLd/AbYKtjJCgVzFOnGrmz1vd8iHOxZEji431T0N7pUVCWn1oxUBGx4svm4wjRShJ+r
	l8/tOTdEb1gVKyc8YhSi/AwnChIl1mgH6Lax9Wm1QQbD8S8gpS8PicQ1tmmIK6A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2915:b0:6b7:46fa:16af with SMTP id
 006d021491bc7-6ca9d14e709mr3706311eaf.68.1789784135476; Fri, 18 Sep 2026
 19:15:35 -0700 (PDT)
Date: Fri, 18 Sep 2026 19:15:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aadf047.71f81b7d.15fa6d.0002.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in seq_printf
From: syzbot <syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3d85c669d09 Merge tag 'ksmbd-for-7.3-rc4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134fb7f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=bc6b37960b1d13f68f9f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca331c4b913d/disk-c3d85c66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f92fda9de386/vmlinux-c3d85c66.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cab83c4f0b39/bzImage-c3d85c66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:648 [inline]
BUG: KASAN: slab-use-after-free in string+0x471/0x4d0 lib/vsprintf.c:730
Read of size 1 at addr ffff88807ec60758 by task syz.2.6295/19648

CPU: 0 UID: 0 PID: 19648 Comm: syz.2.6295 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 string_nocheck lib/vsprintf.c:648 [inline]
 string+0x471/0x4d0 lib/vsprintf.c:730
 vsnprintf+0x422/0x1300 lib/vsprintf.c:2949
 seq_vprintf fs/seq_file.c:392 [inline]
 seq_printf+0x1a4/0x250 fs/seq_file.c:407
 input_devices_seq_show+0x1bf/0x1130 drivers/input/input.c:1178
 seq_read_iter+0xbce/0x1270 fs/seq_file.c:273
 seq_read+0x344/0x4d0 fs/seq_file.c:163
 pde_read fs/proc/inode.c:308 [inline]
 proc_reg_read+0x240/0x330 fs/proc/inode.c:320
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f585059e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5851388028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f5850825fa0 RCX: 00007f585059e159
RDX: 0000000000002020 RSI: 00002000000028c0 RDI: 0000000000000003
RBP: 00007f585063506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5850826038 R14: 00007f5850825fa0 R15: 00007fff7b0fc418
 </TASK>

Allocated by task 18319:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_noprof+0x32f/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 sk_prot_alloc+0x10b/0x2a0 net/core/sock.c:2252
 sk_alloc+0x36/0xe80 net/core/sock.c:2308
 __netlink_create+0x5e/0x2c0 net/netlink/af_netlink.c:627
 netlink_create+0x29b/0x610 net/netlink/af_netlink.c:685
 __sock_create+0x339/0x860 net/socket.c:1676
 sock_create net/socket.c:1734 [inline]
 __sys_socket_create net/socket.c:1771 [inline]
 __sys_socket+0x14d/0x260 net/socket.c:1818
 __do_sys_socket net/socket.c:1832 [inline]
 __se_sys_socket net/socket.c:1830 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1830
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5650:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6801
 sk_prot_free net/core/sock.c:2291 [inline]
 __sk_destruct+0x88c/0xab0 net/core/sock.c:2391
 sk_destruct+0xc8/0xf0 net/core/sock.c:2419
 __sk_free+0xf4/0x3e0 net/core/sock.c:2430
 sk_free+0x61/0x90 net/core/sock.c:2441
 deferred_put_nlk_sk+0xbe/0x110 net/netlink/af_netlink.c:715
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1260 kernel/rcu/tree.c:2919
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3181
 netlink_release+0xb3b/0x2000 net/netlink/af_netlink.c:797
 __sock_release+0xb3/0x260 net/socket.c:735
 sock_close+0x1c/0x30 net/socket.c:1526
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807ec60000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1880 bytes inside of
 freed 2048-byte region [ffff88807ec60000, ffff88807ec60800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88807ec63000 pfn:0x7ec60
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801c035000 ffffea0000ab6010 ffffea000091a410
raw: ffff88807ec63000 0000000000080006 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801c035000 ffffea0000ab6010 ffffea000091a410
head: ffff88807ec63000 0000000000080006 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 13, tgid 13 (kworker/u8:1), ts 67461498561
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_node_track_caller_noprof+0x6a8/0x870 mm/slub.c:5545
 kmalloc_reserve+0xe8/0x350 net/core/skbuff.c:637
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 inet6_ifinfo_notify+0x77/0x140 net/ipv6/addrconf.c:6216
 addrconf_notify+0xb54/0x1ba0 net/ipv6/addrconf.c:3796
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2275
 netif_state_change+0x165/0x380 net/core/dev.c:1625
 linkwatch_do_dev net/core/link_watch.c:186 [inline]
 linkwatch_do_dev+0xe0/0x120 net/core/link_watch.c:166
 __linkwatch_run_queue+0x3a9/0x900 net/core/link_watch.c:240
page last free pid 25 tgid 25 ts 67435951267 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 __kmalloc_cache_noprof+0x278/0x6d0 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x1573/0x6330 drivers/net/netdevsim/fib.c:1493
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88807ec60600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ec60680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807ec60700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807ec60780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ec60800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
