Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E25274B32
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776390990; cv=none; b=RCqLFRE5qAjTxQq/C6oZmbUubFrhqnetDC5uP8RHnbkW8P9b6H1H0dXofz2XuUBqyR7hbDDwFEfx1ZBcCm+8ts+Kcm/Q8/Ynx7sftMQXWE1yKKqk4tHMRmJGteS87qvY3F7zRiJ5taMipm/qNbjQ3MBzvmNlIm1D8Ytj0qBOs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776390990; c=relaxed/simple;
	bh=KSSBaItgMn5b9Qwd8CC1RrhcoYbEb3pFn3AOwrE0W24=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W2PO464NWL7GP/lUaCY6Huqc1Uo9vEgaHdXOYqCukmp8xBbi5GwqF4skZGlLNeqwDuVKPb+GuJsX3/uJvFoEmXv9ixE+nU+xMairiwFRZJPELl3wqyAuPTN6r5YzdcnLZOP3pAxTrYVXlWU7LL5BSHvOE3uSHjJM/upk5jag40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-68d5974b947so554049eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 18:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776390988; x=1776995788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCxuCub1D7ttXCG7zWQTsc584W2Cjv1TTg9VDU9y5R8=;
        b=mp4lhJ/VNrP1Cad6jDHFfV1BBXbK6bb9QISRV9y0CqRO6geoBOWlXevFz49+RWRFza
         Ras/MVpIhlsFff+sb1Pob4vYhlQ7yEDZqD0blq2Gjh4k6QnAudKbgaVeMxsJ8uaxpjS/
         Vcre5i600FQlt2tZlBBr/KImqDP4dipWMtiKt+oz/ZoJITNo0Zs6APfUkVqwNmx2/iFn
         Xc2bSRL2TLb3cV3S4notfll/VizK2GDsJQAMNie+P4YaBgFdrXXcSf5W0nP0NJUIb3EX
         MMj0PSjea/0UHwAqHa3V0Kz1v79PSV4DRhfCXVKBCsaGd19AW+6EQtoTBXnu06Eb5pBV
         Rg+g==
X-Gm-Message-State: AOJu0YxgFuV8IHcecdxEdhQwCu0hPufbdUKnCQRA322uOh5dubdjkenB
	pPSZ2/Nf0ivT3XSG+5N+dDVuv94Bl4mXava3T53lA8TJ762Nsq5iemleEoMcdleCvYnzi13dC6g
	4w58RZQGSp0eN+ijlMizFKc3gWt7HT9fJ9ugrsjvvn4hW5p3FQ/YYpb/3Csba1w==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3108:b0:68b:990a:8eb3 with SMTP id
 006d021491bc7-69462ef238cmr526743eaf.34.1776390988084; Thu, 16 Apr 2026
 18:56:28 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:56:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e1934c.a70a0220.7229.0010.GAE@google.com>
Subject: [syzbot] [fuse?] INFO: task hung in fuse_conn_destroy (2)
From: syzbot <syzbot+eede1fb91fb15bbbd5f2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1c7cc4904160 Add linux-next specific files for 20260413
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=174dd8ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5ee3699e4b6706d
dashboard link: https://syzkaller.appspot.com/bug?extid=eede1fb91fb15bbbd5f2
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13997b02580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a304ce580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4627c340a79d/disk-1c7cc490.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1c9e5b70193/vmlinux-1c7cc490.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c2cc41fa3d8/bzImage-1c7cc490.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eede1fb91fb15bbbd5f2@syzkaller.appspotmail.com

INFO: task syz-executor:5986 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22464 pid:5986  tgid:5986  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5387 [inline]
 __schedule+0x169e/0x54f0 kernel/sched/core.c:7188
 __schedule_loop kernel/sched/core.c:7267 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7282
 fuse_chan_wait_aborted+0x15b/0x250 fs/fuse/dev.c:2212
 fuse_conn_destroy+0x1e7/0x3e0 fs/fuse/inode.c:1969
 fuse_sb_destroy fs/fuse/inode.c:1988 [inline]
 fuse_kill_sb_anon+0x1ef/0x270 fs/fuse/inode.c:2001
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae40e2da57
RSP: 002b:00007ffd60ecf0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fae40ec2048 RCX: 00007fae40e2da57
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd60ecf1a0
RBP: 00007ffd60ecf1a0 R08: 00007ffd60ed01a0 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd60ed0230
R13: 00007fae40ec2048 R14: 000000000002a4a8 R15: 00007ffd60ed0270
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8e3c80c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e3c80c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e3c80c0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6777
2 locks held by kworker/u8:5/144:
 #0: ffff88803379c138 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3280 [inline]
 #0: ffff88803379c138 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_scheduled_works+0xa2e/0x1910 kernel/workqueue.c:3399
 #1: ffffc90003907c40 ((work_completion)(&(&bat_priv->dat.work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3281 [inline]
 #1: ffffc90003907c40 ((work_completion)(&(&bat_priv->dat.work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa69/0x1910 kernel/workqueue.c:3399
2 locks held by getty/5578:
 #0: ffff88803278d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cbe2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13a0 drivers/tty/n_tty.c:2211
4 locks held by kworker/u9:2/5947:
 #0: ffff888056aab138 ((wq_completion)hci2#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3280 [inline]
 #0: ffff888056aab138 ((wq_completion)hci2#2){+.+.}-{0:0}, at: process_scheduled_works+0xa2e/0x1910 kernel/workqueue.c:3399
 #1: ffffc90003dd7c40 ((work_completion)(&(&conn->disc_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3281 [inline]
 #1: ffffc90003dd7c40 ((work_completion)(&(&conn->disc_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa69/0x1910 kernel/workqueue.c:3399
 #2: ffff88801157c870 (&hdev->unregister_lock){+.+.}-{4:4}, at: hci_cmd_sync_submit+0x3f/0x2b0 net/bluetooth/hci_sync.c:708
 #3: ffffffff8e50c0f0 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #3: ffffffff8e50c0f0 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0x27/0x60 include/linux/srcu.h:294
1 lock held by syz-executor/5986:
 #0: ffff8880365ea0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff8880365ea0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff8880365ea0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6108:
 #0: ffff88804d0b20d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88804d0b20d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff88804d0b20d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6129:
 #0: ffff88802e6300d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88802e6300d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff88802e6300d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6151:
 #0: ffff888039c9c0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888039c9c0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff888039c9c0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6175:
 #0: ffff888032fe00d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888032fe00d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff888032fe00d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6208:
 #0: ffff88805ea080d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88805ea080d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff88805ea080d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6236:
 #0: ffff8880396d60d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff8880396d60d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff8880396d60d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
1 lock held by syz-executor/6264:
 #0: ffff88803865c0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88803865c0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff88803865c0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
3 locks held by kworker/0:7/6290:
 #0: ffff88813ff5e538 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3280 [inline]
 #0: ffff88813ff5e538 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0xa2e/0x1910 kernel/workqueue.c:3399
 #1: ffffc90004617c40 ((work_completion)(&(&gc_work->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3281 [inline]
 #1: ffffc90004617c40 ((work_completion)(&(&gc_work->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa69/0x1910 kernel/workqueue.c:3399
 #2: ffffffff8e3c80c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8e3c80c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e3c80c0 (rcu_read_lock){....}-{1:3}, at: gc_worker+0x265/0x12e0 net/netfilter/nf_conntrack_core.c:1543
1 lock held by syz-executor/6300:
 #0: ffff888035c5a0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888035c5a0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff888035c5a0d0 (&type->s_umount_key#55){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 39 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd3/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5947 Comm: kworker/u9:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: hci2 hci_conn_timeout
RIP: 0010:__bfs kernel/locking/lockdep.c:1817 [inline]
RIP: 0010:__bfs_backwards kernel/locking/lockdep.c:1862 [inline]
RIP: 0010:check_irq_usage kernel/locking/lockdep.c:2798 [inline]
RIP: 0010:check_prev_add kernel/locking/lockdep.c:3171 [inline]
RIP: 0010:check_prevs_add kernel/locking/lockdep.c:3286 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3910 [inline]
RIP: 0010:__lock_acquire+0x197b/0x2cf0 kernel/locking/lockdep.c:5239
Code: 14 25 ff 0f 00 00 39 05 cf 55 22 12 73 06 89 05 c7 55 22 12 48 8b 02 48 89 df 4c 39 e8 0f 84 2c fe ff ff 4c 89 60 30 48 8b 00 <4c> 39 e8 75 f4 48 89 df e9 18 fe ff ff 48 89 fb 48 c7 c7 d0 53 29
RSP: 0018:ffffc90003dd7260 EFLAGS: 00000002
RAX: ffffffff964d7b78 RBX: 00000000000003cd RCX: 0000000000000069
RDX: ffffffff964d2078 RSI: ffff888027a98cc0 RDI: 00000000000003cd
RBP: 6fe64282abbcb09d R08: ffffc90003dd7228 R09: 0000000000000020
R10: 0000000000000100 R11: ffffffff81a12310 R12: ffffffff964db308
R13: ffffffff9367ab48 R14: ffff888027a98000 R15: 0000000000000068
FS:  0000000000000000(0000) GS:ffff888125a6b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd66e1ed84 CR3: 000000000e1b6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 seqcount_lockdep_reader_access+0x55/0x100 include/linux/seqlock.h:73
 ktime_get+0x45/0x220 kernel/time/timekeeping.c:965
 clockevents_program_event+0x290/0x5f0 kernel/time/clockevents.c:360
 hrtimer_rearm kernel/time/hrtimer.c:2039 [inline]
 __hrtimer_rearm_deferred+0x273/0x460 kernel/time/hrtimer.c:2059
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [inline]
 irqentry_exit+0x14f/0x680 kernel/entry/common.c:164
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x47/0x80 kernel/locking/spinlock.c:198
Code: f7 e8 4d 96 5d f6 f7 c3 00 02 00 00 74 05 e8 50 42 89 f6 9c 58 a9 00 02 00 00 75 27 f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 94 25 50 f6 65 8b 05 6d 74 77 07 85 c0 74 18 5b 41 5e e9 11 3c
RSP: 0018:ffffc90003dd76a8 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000246 RCX: 0000000080000001
RDX: 0000000000000007 RSI: ffffffff8d99491e RDI: 0000000000000001
RBP: ffffc90003dd77b0 R08: ffffffff8fcf0bf7 R09: 1ffffffff1f9e17e
R10: dffffc0000000000 R11: fffffbfff1f9e17f R12: dffffc0000000000
R13: 1ffff920007baee0 R14: ffff8880b8642d40 R15: ffff8880b8642d40
 unlock_rt_mutex_safe kernel/locking/rtmutex.c:350 [inline]
 rt_mutex_slowunlock+0x4a7/0x8b0 kernel/locking/rtmutex.c:1463
 spin_unlock include/linux/spinlock_rt.h:109 [inline]
 __free_frozen_pages+0x825/0x10f0 mm/page_alloc.c:2973
 __slab_free+0x252/0x2a0 mm/slub.c:5608
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x22/0xb0 mm/kasan/common.c:406
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 hci_cmd_sync_submit+0xcb/0x2b0 net/bluetooth/hci_sync.c:714
 hci_abort_conn+0x1f5/0x380 net/bluetooth/hci_conn.c:3123
 process_one_work kernel/workqueue.c:3308 [inline]
 process_scheduled_works+0xb68/0x1910 kernel/workqueue.c:3399
 worker_thread+0xa90/0x1040 kernel/workqueue.c:3485
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
