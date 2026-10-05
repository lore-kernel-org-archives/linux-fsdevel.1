Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F471475337
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194746; cv=none; b=Sp0NXDVmqGypgstk3fc4UASRzY/Ptg2f3cf04DhyfCqJP/YGnGFcGpvY5U7Rt4zn+hK3V8l/pPqiW97qgalJxfaO1rRzlc3cD/QHDd4FrtioKn8HVHc06oAFFX6P8jy7EjOMHJYatlbpCA/smVJpgCIkZGces6qHeE67aNFVlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194746; c=relaxed/simple;
	bh=pt8EOmenPl9ApBNZ8oSEUTdi2YIRRY8WqPdn+RvYSWk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iB/Un3oLi8TwKHzZqgNY8Ej1bpZ8awu46TOXzdxIPsivOaL3/py625pUz8Ld8sY1O88HVqXcKwXhRFv6YlvaYCv/bxgW0iXIfyR90Hr7cChGvczCEn6iGE+aK5i4jftec0qtuj7JMRbC0paA1qbQS7l2CwxzxSWOlymyJPSxjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4eb0b989f0eso2803766b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 03:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194742; x=1791799542;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxRAgRCn0djyme+/P9KKlTJtsN6YIDbfEo4rgZVD75A=;
        b=Hh3xds6lB7lMvgK2SZzr1/xFgq7o0qsPE2WExccIwY5vnhVYvdy/galRddtdQ0zoyG
         3RUWQXXgc4CemgLMjloPZo/7z5Sl8b5q1R6+JzboHhrgGRPqTlQrS9kl0rojUKudRXz6
         dJnyUBD2tWM5fR9nU4GhBMKr0DkjlxhZyuAmt/36qTIygDrXP+86/vbjNn0VJg9OdMfF
         A+HtBoMT7aHvqW0z+153MjMrQ7DIWf4n+WfTY7xS7Qysb44h1m5Z3XYmkZKDt+tuapFz
         5Jnh/cxuH/s7QHXvshMAtaEnpc0E3OmlHh8RyPu/wB8UhnHGBJpGXClUZj6oOVwu/rvr
         9bGA==
X-Forwarded-Encrypted: i=1; AKwUvBxNw/rS+Y4tAwWrY0AyEAzEudhyTKqP+H2Y9MwK9DQL002/+Fa6oQM9Pdyw1rPVNVrJjQ9faK3PSUn1FOwk@vger.kernel.org
X-Gm-Message-State: AFuF++kBPBYwRQZ85TnyAf7nkRONbFIAFfetgtJs/t+N4LzhQcvJVFRM
	VnAytFbBCNC8e6kBSaAJhqMS89+BuduF1T+gPWp3bjrOohxdqzcK1aAwym8vhfJMtXwnKrdtrZH
	KDE3P6PbPoUTK1C9u2U0qo1aoiO6YwrbNfeOSWbluSKSfHZPYfgFLU6lt31w=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4444:b0:495:f8a5:8797 with SMTP id
 5614622812f47-4f2fc48a50fmr10409344b6e.0.1791194741975; Mon, 05 Oct 2026
 03:05:41 -0700 (PDT)
Date: Mon, 05 Oct 2026 03:05:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac37675.63a243ec.3d2de0.0000.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] INFO: rcu detected stall in kswapd (4)
From: syzbot <syzbot+f886305df0acc6fa097a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, david@kernel.org, 
	hannes@cmpxchg.org, kasong@tencent.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, weixugc@google.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    551c722f4080 Merge tag 'rtc-7.3-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13398725580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b924f079099ba6e
dashboard link: https://syzkaller.appspot.com/bug?extid=f886305df0acc6fa097a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b98725580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-551c722f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c3bdf9d33a9b/vmlinux-551c722f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a4322b07d54a/bzImage-551c722f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f886305df0acc6fa097a@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P5719/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=57681, q=371 ncpus=1)
task:syz.2.25        state:R  running task     stack:26616 pid:5719  tgid:5719  ppid:5420   task_flags:0x400040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7463
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:201 [inline]
 _raw_spin_unlock+0x41/0x50 kernel/locking/spinlock.c:213
 spin_unlock include/linux/spinlock.h:401 [inline]
 do_wp_page+0x769/0x4b80 mm/memory.c:4467
 handle_pte_fault mm/memory.c:6582 [inline]
 __handle_mm_fault mm/memory.c:6707 [inline]
 handle_mm_fault+0x15d7/0x3750 mm/memory.c:6876
 do_user_addr_fault+0xa4f/0x1340 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0033:0x7f0879a66723
RSP: 002b:00007ffde218fc10 EFLAGS: 00010246
RAX: 00007f0879e25fa0 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 00007f0879e26038 RDI: 0000000000000000
RBP: 00007f0879e25fb0 R08: 0000000000000000 R09: 00007f0879e26038
R10: 0000000000000003 R11: 0000000000000000 R12: 00007f0879e25fa0
R13: 0000200000000000 R14: 00007ffde218fc88 R15: 00007f0879e25fa0
 </TASK>
rcu: rcu_preempt kthread starved for 3418 jiffies! g57681 f0x0 RCU_GP_WAIT_FQS(5) ->state=R ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27496 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7463
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:211 [inline]
 _raw_spin_unlock_irqrestore+0x76/0x80 kernel/locking/spinlock.c:221
 debug_object_free+0x294/0x340 lib/debugobjects.c:1038
 schedule_timeout+0x162/0x2c0 kernel/time/sleep_timeout.c:103
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2122
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2330
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 80 Comm: kswapd1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:finish_task_switch+0x413/0xc60 kernel/sched/core.c:5384
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 b7 5f 55 0a e8 d2 3b 3a 00 fb 4c 8b 65 c8 <49> 8d bc 24 18 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc90000e97600 EFLAGS: 00000202
RAX: 0000000000076e43 RBX: ffff88801fc3c8e0 RCX: 8000000000000001
RDX: 0000000000000000 RSI: ffffffff8e419dcf RDI: ffffffff8c6dcd80
RBP: ffffc90000e97650 R08: ffffffff907a877f R09: 1ffffffff20f50ef
R10: dffffc0000000000 R11: fffffbfff20f50f0 R12: ffff8880317aa580
R13: ffff88801fc3c8a8 R14: dffffc0000000000 R15: 1ffff11003f8791c
FS:  0000000000000000(0000) GS:ffff88808c2bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f31591ac0 CR3: 000000004374b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5536 [inline]
 __schedule+0x17e3/0x58f0 kernel/sched/core.c:7284
 preempt_schedule_irq+0x4b/0x90 kernel/sched/core.c:7606
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:539 [inline]
 irqentry_exit+0x14f/0x910 kernel/entry/common.c:167
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__might_resched+0x144/0x4c0 kernel/sched/core.c:9229
Code: d0 02 00 00 41 f6 45 00 02 75 21 4d 8d ae 38 0b 00 00 4c 89 e8 48 c1 e8 03 0f b6 04 28 84 c0 0f 85 cd 02 00 00 41 83 7d 00 00 <74> 7e 48 c7 c0 80 3c 7a 90 48 c1 e8 03 0f b6 04 28 84 c0 0f 85 45
RSP: 0018:ffffc90000e97980 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000046
RDX: 0000000000000000 RSI: ffffffff8e6a36ef RDI: ffffffff8c6dcd80
RBP: dffffc0000000000 R08: ffffffff907a877f R09: 1ffffffff20f50ef
R10: dffffc0000000000 R11: fffffbfff20f50f0 R12: ffff8880317aaa44
R13: ffff8880317ab0b8 R14: ffff8880317aa580 R15: 1ffff110062f5548
 kthread_freezable_should_stop+0x23/0x180 kernel/kthread.c:199
 kswapd+0x7af/0x32c0 mm/vmscan.c:7535
 kthread+0x38b/0x480 kernel/kthread.c:436
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
