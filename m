Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D072DB788
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724518; cv=none; b=MeHpLy5CGXw5ikNOHPT08zTiNrofJMjzAulWPVGotcEpVh51DPgDwqeU7xqGRuXEmQh1YZFEKdVrfNvbIaR5ofnjCoN7plm5QCbh/onLR6mP3sfRKw0Cp/tGp2EoDGAqxlh/zh4CFs6SLL8Nog2+byahHUuRCOCweKFrVpmDE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724518; c=relaxed/simple;
	bh=OKEp1WsvMQAR42RU/9N0TgIGMM5WOxOMIU4ao2T1z/M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ryGcAprLeusmruPAi+TmY/RGXrSGdHJjuTaJt18G1HM7zNGDFDczgfiErxggmCfYQatdgf9JhN/fCRtVUoEbRCXWE2E2/zyeRT6a3cnMGV/ttQjIfw/6qq5rhfeQmY770VVipYMFFNeuu2l9gKqgmFqN7dKR6rCSUAr0PWOZXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-43d1691d2f2so2336757fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 12:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724516; x=1782329316;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjupFcneIIto65XABs2p2/j0lXF0o0Kwnt7iCTYYUbQ=;
        b=auV403453yooVsAbOYIA+UUUtYcgudL2i4iv+qroVeliaBmxa3cAY566jv/QwuEysq
         dmBBJ3gNluJeckXKVpu0jaHx+qwttW5wMbzUz2sGtvn2cgnU2VqzUXh9fgv6CWc+02Rl
         sm/eO0laMxdtrrLLtOOLM+5dDluUfEY0zvvG0sFDYl+JjHJCBLFMU7+yY4QorKhX0Lm5
         5Fhslhs8hszAVtIDwPuDcO+/15dWMkYb6ugkTA4ln9sejqfO2bGgXP14TH8T55Ia0Fvk
         dpzbprG4Sd0HJ2HoADW5mgwf9vJ/w64YypCld/YknteS1TWiLSxOMdFlOyRt4V5EWKVC
         ataw==
X-Forwarded-Encrypted: i=1; AFNElJ/XlSYW7TIrJpL0qyeKDRz7jqiwFbqGCc/comSIDkvppnM3P9KQkn5u5zzm61HQyrNApIIkp2gVh+12QUA+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TFU7rwuKpIe1KKk2/rm8GJDZJVBGqYrdv01bVk6eINvYG2dF
	PA9C0tHP722Ibgbv/KSpuYc7XFIkrwQz3M3b/QpXRRbvm2/CWTOY3U/YWtg6zlKF/rzSTXToIpW
	h1NTXuF3eGZJ6z06z4m6HA+kL9pCZsdQcC5CLcJfl0uFsu5y77alPwdUrGFs=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:138e:b0:69e:3426:5b64 with SMTP id
 006d021491bc7-6a0c73f3580mr629365eaf.28.1781724516149; Wed, 17 Jun 2026
 12:28:36 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:28:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a32f564.9e11d3f7.246028.0002.GAE@google.com>
Subject: [syzbot] [fuse?] INFO: task hung in fuse_chan_send
From: syzbot <syzbot+a531d1b1fb0fa2a75a73@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c425609d6ac4 Add linux-next specific files for 20260612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1206c3b6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7a56b1e89b63439
dashboard link: https://syzkaller.appspot.com/bug?extid=a531d1b1fb0fa2a75a73
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163c04ae580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7fab9a8df61a/disk-c425609d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2577196651b/vmlinux-c425609d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/053557a7471e/bzImage-c425609d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a531d1b1fb0fa2a75a73@syzkaller.appspotmail.com

INFO: task syz.0.17:5995 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27344 pid:5995  tgid:5994  ppid:5839   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x1709/0x5530 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 request_wait_answer fs/fuse/dev.c:743 [inline]
 __fuse_request_send fs/fuse/dev.c:757 [inline]
 fuse_chan_send+0x1068/0x1ad0 fs/fuse/dev.c:833
 fuse_simple_request fs/fuse/fuse_i.h:1012 [inline]
 fuse_do_getattr+0x370/0x690 fs/fuse/dir.c:1505
 fuse_update_get_attr+0x600/0x1300 fs/fuse/dir.c:1562
 vfs_getattr_nosec+0x2e1/0x430 fs/stat.c:213
 vfs_statx_path+0x2b/0x230 fs/stat.c:299
 vfs_statx+0x12e/0x200 fs/stat.c:356
 vfs_fstatat+0x11b/0x170 fs/stat.c:373
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat fs/stat.c:532 [inline]
 __x64_sys_newfstatat+0x151/0x200 fs/stat.c:532
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0189d9ce59
RSP: 002b:00007f01893fe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00007f018a015fa0 RCX: 00007f0189d9ce59
RDX: 0000000000000000 RSI: 0000200000000500 RDI: ffffffffffffff9c
RBP: 00007f0189e32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f018a016038 R14: 00007f018a015fa0 R15: 00007ffef89eaea8
 </TASK>

Showing all locks held in the system:
10 locks held by ktimers/0/16:
 #0: ffffffff8de611a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #1: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #2: ffff8880b8626260 (&base->expiry_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #2: ffff8880b8626260 (&base->expiry_lock){+...}-{3:3}, at: timer_base_lock_expiry kernel/time/timer.c:1502 [inline]
 #2: ffff8880b8626260 (&base->expiry_lock){+...}-{3:3}, at: __run_timer_base+0x11a/0x9b0 kernel/time/timer.c:2384
 #3: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #3: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #4: ffffc90000157a80 ((&ndev->rs_timer)){+...}-{0:0}, at: expire_timers kernel/time/timer.c:1800 [inline]
 #4: ffffc90000157a80 ((&ndev->rs_timer)){+...}-{0:0}, at: __run_timers kernel/time/timer.c:2374 [inline]
 #4: ffffc90000157a80 ((&ndev->rs_timer)){+...}-{0:0}, at: __run_timer_base+0x683/0x9b0 kernel/time/timer.c:2386
 #5: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #6: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #6: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #6: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #6: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #7: ffffffff8de611a0 (local_bh){.+.+}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8de611a0 (local_bh){.+.+}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #7: ffffffff8de611a0 (local_bh){.+.+}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #7: ffffffff8de611a0 (local_bh){.+.+}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #8: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: debug_object_activate+0xa8/0x3a0 lib/debugobjects.c:873
 #9: ffff888037258af8 (&p->pi_lock){-...}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:572 [inline]
 #9: ffff888037258af8 (&p->pi_lock){-...}-{2:2}, at: try_to_wake_up+0x67/0x1430 kernel/sched/core.c:4292
1 lock held by khungtaskd/39:
 #0: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8dfcb040 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6777
2 locks held by getty/5363:
 #0: ffff8880365650a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cc62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x460/0x1360 drivers/tty/n_tty.c:2211

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 39 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:__find_rr_leaf+0x121/0x760 net/ipv6/route.c:840
Code: c0 33 c1 8d 48 c1 e8 03 48 89 44 24 70 4c 89 7c 24 38 4d 85 ff 74 4e 49 8d 9e 90 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 <84> c0 75 21 8b 1b 89 df 44 8b 64 24 4c 44 89 e6 e8 9a 71 e5 f7 44
RSP: 0018:ffffc90000157160 EFLAGS: 00000a02
RAX: 0000000000000000 RBX: ffff888036f70490 RCX: ffff88801d688000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: ffffc900001572b8 R08: 0000000000000000 R09: 0000000000000100
R10: ffffc90000157240 R11: fffff5200002ae4a R12: 1ffff1100783a48c
R13: dffffc0000000000 R14: ffff888036f70400 R15: ffffc900001573b8
FS:  0000000000000000(0000) GS:ffff888125ece000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559e696cf1f0 CR3: 000000002a2d2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 find_rr_leaf net/ipv6/route.c:892 [inline]
 rt6_select net/ipv6/route.c:936 [inline]
 fib6_table_lookup+0x3cb/0xb00 net/ipv6/route.c:2254
 ip6_pol_route+0x228/0x13e0 net/ipv6/route.c:2290
 pol_lookup_func include/net/ip6_fib.h:669 [inline]
 fib6_rule_lookup+0x563/0x740 net/ipv6/fib6_rules.c:123
 ip6_route_input_lookup net/ipv6/route.c:2359 [inline]
 ip6_route_input+0x78d/0xb20 net/ipv6/route.c:2662
 ip6_rcv_finish+0x141/0x280 net/ipv6/ip6_input.c:117
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6205 [inline]
 __netif_receive_skb net/core/dev.c:6318 [inline]
 process_backlog+0x3bf/0xc50 net/core/dev.c:6669
 __napi_poll+0xae/0x550 net/core/dev.c:7728
 napi_poll net/core/dev.c:7791 [inline]
 net_rx_action+0x621/0xd70 net/core/dev.c:7948
 handle_softirqs+0x1d9/0x6c0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1155
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
