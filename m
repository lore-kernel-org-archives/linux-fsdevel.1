Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFE4A3E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759421; cv=none; b=UmncYOKNXkgJm+MD2hISMlmTP2G4iNedPxhFt49zIPDm2jl/1/oQO+BCIpZ6upHhRNmKUp5o4YBtl4ZQ0vvBQK/pgljrnK7KMueEqY1v4MpiZiJNfOqY10fA8aBNhw1gF7fZin0q59lMzGOUPUKNUDMGU6O9H54z6sRQcQs7nQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759421; c=relaxed/simple;
	bh=poWvt2mYdrlsJZfzq8F3W4cI/hKurn4fukrpx0V0TnI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I+49Q+PdfvuYzN+APhtQzy6jALw1ZGMuM0khV3sDT+01gmFimlEaFm7SX6QcGrbEoEedE3VxSlU9dyHzy2PVoJaEWiBFhVQr4zAWZrgD3tM9UkRzAJauaZV5fLvxRtLDnJ35EeWwLJ0F2jzHMK5giKRWefy64WG68eJDtMVzb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-68582ad07ffso1082559eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 11:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759419; x=1776364219;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9LavM2DJhLt+W+Io2Ddjpl5OjwLUli7TuamqtHNNgM=;
        b=cI+qOHdirKHIEur0xwbqP89JAknsHZNfOfNUYWtDnK0qZKkmWlbIKhXMyhZ850pTUH
         iXmDl+s5BKb9NGJnJIS3Ace+ab0NMODVPtvP+GLmApU5LSZwz4eW+6+yz0BeECWIluUX
         BGxj1jEZJ4pCTUomwGgO7jcJchTxNpmsrbDc/CcIgckdE88t7DxjPAPPq/YqPo+drazY
         q/ABEclHwGqpfNklfTSjlUw6p5/Iac0wbjJT1eGy1mE+MgxULRsppBhPGUbIX/3IIRjc
         jrIaXIBNcwSE9Jr0k/VM3OqyHA+2YjITFbVslRix0iO3SaIilMDpu5nkHkrdUeenqClb
         Qa6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtNo2Vh+K60akVPm+eVO73DWhbZMCnLzP2XSEViHKIXtNjvIWjFLKVsw7RK6HGN6gKAIPursHQqwe3G1VV@vger.kernel.org
X-Gm-Message-State: AOJu0YxbL89dSUyMFYw8Txk1NnPrMA1Y0VHCtnYYVW7w5IR2+gFx9xha
	o+7qtHZVgKTlPKslD91TB3FR24Ni8JBD8N5zVTMhAgp32qn343H0klbKyYLY36pXsjPWzSIaU3j
	lPiIgJcaYaz1n3sPb8EJVjoifw4sHhSroESCxfvorKTg/c510rR1D8vmMqzI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:20a:b0:688:29ff:2dd8 with SMTP id
 006d021491bc7-68be7cee982mr96766eaf.41.1775759419434; Thu, 09 Apr 2026
 11:30:19 -0700 (PDT)
Date: Thu, 09 Apr 2026 11:30:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d7f03b.050a0220.3030df.001b.GAE@google.com>
Subject: [syzbot] [fuse?] BUG: scheduling while atomic in __synchronize_srcu
From: syzbot <syzbot+12b178b7c756664d2518@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7f87a5ea75f0 Merge tag 'hid-for-linus-2026040801' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12439316580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d08886358f27e8c
dashboard link: https://syzkaller.appspot.com/bug?extid=12b178b7c756664d2518
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1461aeba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c85e06580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-7f87a5ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28f02ff1720d/vmlinux-7f87a5ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d30b9e8505e/Image-7f87a5ea.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12b178b7c756664d2518@syzkaller.appspotmail.com

BUG: scheduling while atomic: syz.1.49/3699/0x00000002
Modules linked in:
CPU: 1 UID: 0 PID: 3699 Comm: syz.1.49 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace arch/arm64/kernel/stacktrace.c:498 [inline] (C)
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x60/0x80 lib/dump_stack.c:120
 dump_stack+0x18/0x24 lib/dump_stack.c:129
 __schedule_bug+0x54/0x78 kernel/sched/core.c:5847
 schedule_debug kernel/sched/core.c:5874 [inline]
 __schedule+0x858/0xd84 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x34/0x114 kernel/sched/core.c:7008
 schedule_timeout+0xd4/0x110 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x78/0x160 kernel/sched/completion.c:153
 __synchronize_srcu+0x90/0xd0 kernel/rcu/srcutree.c:1496
 synchronize_srcu_expedited+0x24/0x40 kernel/rcu/srcutree.c:1521
 kvm_set_irq_routing+0x204/0x294 virt/kvm/irqchip.c:225
 kvm_vgic_setup_default_irq_routing+0x78/0xc0 arch/arm64/kvm/vgic/vgic-irqfd.c:153
 vgic_init+0x1ac/0x268 arch/arm64/kvm/vgic/vgic-init.c:421
 vgic_lazy_init+0x54/0x6c arch/arm64/kvm/vgic/vgic-init.c:550
 kvm_vgic_inject_irq+0x30/0x12c arch/arm64/kvm/vgic/vgic.c:520
 kvm_timer_update_irq+0x68/0x7c arch/arm64/kvm/arch_timer.c:450
 kvm_timer_vcpu_reset+0xd8/0x1e0 arch/arm64/kvm/arch_timer.c:1036
 kvm_reset_vcpu+0x194/0x360 arch/arm64/kvm/reset.c:268
 kvm_vcpu_set_target arch/arm64/kvm/arm.c:1632 [inline]
 kvm_arch_vcpu_ioctl_vcpu_init arch/arm64/kvm/arm.c:1652 [inline]
 kvm_arch_vcpu_ioctl+0x2e4/0x8c8 arch/arm64/kvm/arm.c:1773
 kvm_vcpu_ioctl+0x4ac/0x8f4 virt/kvm/kvm_main.c:4653
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0xac/0x104 fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x104 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x124 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xf0 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
BUG: scheduling while atomic: syz.1.49/3699/0x00000000
Modules linked in:
CPU: 1 UID: 0 PID: 3699 Comm: syz.1.49 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace arch/arm64/kernel/stacktrace.c:498 [inline] (C)
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x60/0x80 lib/dump_stack.c:120
 dump_stack+0x18/0x24 lib/dump_stack.c:129
 __schedule_bug+0x54/0x78 kernel/sched/core.c:5847
 schedule_debug kernel/sched/core.c:5874 [inline]
 __schedule+0x858/0xd84 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x34/0x114 kernel/sched/core.c:7008
 futex_do_wait kernel/futex/waitwake.c:358 [inline]
 __futex_wait+0xf0/0x178 kernel/futex/waitwake.c:687
 futex_wait+0x88/0x118 kernel/futex/waitwake.c:715
 do_futex+0xf8/0x1a0 kernel/futex/syscalls.c:130
 __do_sys_futex kernel/futex/syscalls.c:207 [inline]
 __se_sys_futex kernel/futex/syscalls.c:188 [inline]
 __arm64_sys_futex+0xfc/0x1a0 kernel/futex/syscalls.c:188
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x104 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x124 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xf0 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
psi: inconsistent task state! task=30:pr/ttyAMA-1 cpu=1 psi_flags=14 clear=0 set=10


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
