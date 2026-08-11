Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932A1E3DDE
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407149; cv=none; b=HpzyiyH5Eo/S46RuS1NrBSfz9zIJcEwqfF9p0u6h8xF6jGnRzVDjHNO0/Zd76xHWi0ypjems118eBcmkO+vvq3+6E8PDTCeygitMVx73WPXaCA96Ko95ZQL6+H/FtGvPaA4xh/G/4dUdDsVYNj6um1jCs1/IPYiWCTVXCtS3IqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407149; c=relaxed/simple;
	bh=123IcB4NztDi49zrvLRaHwB8pVdf6Tcr5y4ZqCHn5Ns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GxfWa8QTiOTdNvX6IsIzgCozYC3vG43F+RPpt3HLSmXvfrx0anAaSvgLomGGLQxmPn3jVPBf7R7kap0IONwsHi0gMN78H2VIWTP53xP4rpgllT2MmnJQFU1pJHkoJmzBaUyAMhwa8wX3xvrGlDsOoPApJ2uLK+1xDtc/IgAPNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab4af22d09so2673259b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 17:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407146; x=1787011946;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSAHm/bZXok2btxi3dN3u/5Ahmbp+kzZbQ3xT8+awFY=;
        b=dfAj/hmiGmfI8ZtXVcq5Z0dLf2njMgg5gOGbRcWUawQ8JMMu7gut4KRG3jmstEHtsy
         JquW2byGL/NleeXfBh/zP4Wglvoqf0sy8uj8eYSIaMA8B3qIkiIfVdPJRraOUT+7J59v
         R4NrWf32o74qbrCQmmWl04OACGXs7zMRwbDFx/3MXqG+sjMR+F4fu6IBxPEAzII9Xec5
         QZ+nNjK52UNYiZN6T0kuY8N6z/24dl4C5+OMepYaLQoQtTwppmo7HyryAezwpRIoUK5O
         h0L588PaBpPlxuRP5Xh1JlHA+jhEJ4Lf62Pz6rSBjR0RKranSHNsaiPAG5+gLzcPKiPn
         Cx9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpBNnLSoHFf2tLqPAqiz3v07iTAeVB/xXFaOVrjhfmbpDd1M3s8OSCxsYJNt0K6SXTanY29iTufdFXMOJa7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qZh9pQ4SgTmqOQrMWvZ64abgSJdEKke2dRrPIUtbuoJWSM4L
	w/4UeKW7ne9ch4p/q1AL4JwB6L3pXwHFhFeBvARN7p68XVCSQBbbfA7dJpxsr5rnVgfZOmMJ/Zy
	5L2St71fDdllQegSVp8eiS1ZEFoQHWAuSqyEfpLtQJw4uX6wzQ1cy7aLEiZs=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a06:b0:4af:5d69:1cb4 with SMTP id
 5614622812f47-4b1ab975a97mr11697000b6e.15.1786407146513; Mon, 10 Aug 2026
 17:12:26 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a68ea.9c11d2ce.289b96.00f2.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] BUG: sleeping function called from invalid
 context in kvm_xen_set_evtchn_fast (2)
From: syzbot <syzbot+e42793f1299e53beb2ee@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc2b5f627e8c Add linux-next specific files for 20260714
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=128b7cc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2290ccbf984c524f
dashboard link: https://syzkaller.appspot.com/bug?extid=e42793f1299e53beb2ee
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138157b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127cf29e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6836f8efb1da/disk-cc2b5f62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0109d3477cc7/vmlinux-cc2b5f62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2e49e350bbf/bzImage-cc2b5f62.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e42793f1299e53beb2ee@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:248
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 5622, name: syz-executor363
preempt_count: 10000, expected: 0
RCU nest depth: 1, expected: 1
locks held by syz-executor363/5622: 4, last CPU#0:
 #0: ffff88804093d380 (&sb->s_type->i_mutex_key#8/2){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #0: ffff88804093d380 (&sb->s_type->i_mutex_key#8/2){+.+.}-{4:4}, at: __simple_recursive_removal+0x19a/0x520 fs/libfs.c:619
 #1: ffffffff8e53c398 (pin_fs_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffffffff8e53c398 (pin_fs_lock){+.+.}-{3:3}, at: simple_release_fs+0x2f/0xd0 fs/libfs.c:1120
 #2: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rtlock_slowlock_locked+0x2ab/0x3c20 kernel/locking/rtmutex.c:1874
 #3: ffff888038241b48 (&kvm->srcu){.?.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #3: ffff888038241b48 (&kvm->srcu){.?.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
 #3: ffff888038241b48 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xen_set_evtchn_fast+0x1be/0x990 arch/x86/kvm/xen.c:1827
irq event stamp: 13272
hardirqs last  enabled at (13271): [<ffffffff8b53b4b3>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:187 [inline]
hardirqs last  enabled at (13271): [<ffffffff8b53b4b3>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:206
hardirqs last disabled at (13272): [<ffffffff8b501aee>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1062
softirqs last  enabled at (6940): [<ffffffff81882fe0>] __local_bh_enable_ip+0x1a0/0x2b0 kernel/softirq.c:305
softirqs last disabled at (6932): [<ffffffff891cda09>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (6932): [<ffffffff891cda09>] __alloc_skb+0x189/0x7a0 net/core/skbuff.c:697
Preemption disabled at:
[<ffffffff81883b8e>] irq_enter_rcu+0x1e/0x1f0 kernel/softirq.c:668
CPU: 0 UID: 0 PID: 5622 Comm: syz-executor363 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9194
 rt_read_lock+0xa9/0x4b0 kernel/locking/spinlock_rt.c:248
 kvm_xen_set_evtchn_fast+0x1f4/0x990 arch/x86/kvm/xen.c:1829
 xen_timer_callback+0x109/0x220 arch/x86/kvm/xen.c:141
 __run_hrtimer kernel/time/hrtimer.c:2065 [inline]
 __hrtimer_run_queues+0x3a0/0xaf0 kernel/time/hrtimer.c:2122
 hrtimer_interrupt+0x44a/0x900 kernel/time/hrtimer.c:2241
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:rt_mutex_owner include/linux/rtmutex.h:52 [inline]
RIP: 0010:rtmutex_spin_on_owner kernel/locking/rtmutex.c:1504 [inline]
RIP: 0010:rtlock_slowlock_locked+0x34e5/0x3c20 kernel/locking/rtmutex.c:1893
Code: 80 3c 01 00 4c 8b b4 24 80 00 00 00 4c 8b 2c 24 74 08 4c 89 ef e8 db 0e df f6 48 8d 84 24 60 01 00 00 49 39 45 00 75 6c f3 90 <48> b8 00 00 00 00 00 fc ff df 48 8b 8c 24 a8 00 00 00 80 3c 01 00
RSP: 0018:ffffc90004e6f7a0 EFLAGS: 00000246
RAX: ffffc90004e6f900 RBX: 1ffff11006ff9bbe RCX: 1ffffffff1ca7871
RDX: 00000000e6b90d15 RSI: ffffffff8bcbd060 RDI: 0000000000000001
RBP: ffffc90004e6f9f0 R08: 1d00000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8e3c3880 R12: ffff888037fcddc0
R13: ffffffff8e53c388 R14: ffffffff8e53c390 R15: 1ffff11006ff9bba
 rtlock_slowlock kernel/locking/rtmutex.c:1922 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x165/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 simple_release_fs+0x2f/0xd0 fs/libfs.c:1120
 __simple_recursive_removal+0x215/0x520 fs/libfs.c:623
 debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:781
 kvm_destroy_vm_debugfs virt/kvm/kvm_main.c:988 [inline]
 kvm_destroy_vm virt/kvm/kvm_main.c:1261 [inline]
 kvm_put_kvm+0x147/0xae0 virt/kvm/kvm_main.c:1331
 kvm_vm_release+0x46/0x50 virt/kvm/kvm_main.c:1354
 __fput+0x42a/0xa80 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1009
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1161
 x64_sys_call+0x18bf/0x18c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f132ec60d05
Code: Unable to access opcode bytes at 0x7f132ec60cdb.
RSP: 002b:00007ffe413e3968 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f132ec60d05
RDX: 00000000000000e7 RSI: ffffffffffffffd8 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000009
R10: 0000000000000009 R11: 0000000000000202 R12: 0000000000000000
R13: 00007f132ecfa118 R14: 00007f132ecfc3c8 R15: 00007f132ecfc3e0
 </TASK>

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G        W          
-----------------------------
syz-executor363/5622 is trying to lock:
ffff888038241530 (&gpc->lock){....}-{3:3}, at: kvm_xen_set_evtchn_fast+0x1f4/0x990 arch/x86/kvm/xen.c:1829
other info that might help us debug this:
context-{2:2}
locks held by syz-executor363/5622: 4, last CPU#0:
 #0: ffff88804093d380 (&sb->s_type->i_mutex_key#8/2){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #0: ffff88804093d380 (&sb->s_type->i_mutex_key#8/2){+.+.}-{4:4}, at: __simple_recursive_removal+0x19a/0x520 fs/libfs.c:619
 #1: ffffffff8e53c398 (pin_fs_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffffffff8e53c398 (pin_fs_lock){+.+.}-{3:3}, at: simple_release_fs+0x2f/0xd0 fs/libfs.c:1120
 #2: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rtlock_slowlock_locked+0x2ab/0x3c20 kernel/locking/rtmutex.c:1874
 #3: ffff888038241b48 (&kvm->srcu){.?.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #3: ffff888038241b48 (&kvm->srcu){.?.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
 #3: ffff888038241b48 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xen_set_evtchn_fast+0x1be/0x990 arch/x86/kvm/xen.c:1827
stack backtrace:
CPU: 0 UID: 0 PID: 5622 Comm: syz-executor363 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4846 [inline]
 check_wait_context kernel/locking/lockdep.c:4918 [inline]
 __lock_acquire+0xef0/0x2e40 kernel/locking/lockdep.c:5204
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5906
 rt_read_lock+0xcc/0x4b0 kernel/locking/spinlock_rt.c:249
 kvm_xen_set_evtchn_fast+0x1f4/0x990 arch/x86/kvm/xen.c:1829
 xen_timer_callback+0x109/0x220 arch/x86/kvm/xen.c:141
 __run_hrtimer kernel/time/hrtimer.c:2065 [inline]
 __hrtimer_run_queues+0x3a0/0xaf0 kernel/time/hrtimer.c:2122
 hrtimer_interrupt+0x44a/0x900 kernel/time/hrtimer.c:2241
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:rt_mutex_owner include/linux/rtmutex.h:52 [inline]
RIP: 0010:rtmutex_spin_on_owner kernel/locking/rtmutex.c:1504 [inline]
RIP: 0010:rtlock_slowlock_locked+0x34e5/0x3c20 kernel/locking/rtmutex.c:1893
Code: 80 3c 01 00 4c 8b b4 24 80 00 00 00 4c 8b 2c 24 74 08 4c 89 ef e8 db 0e df f6 48 8d 84 24 60 01 00 00 49 39 45 00 75 6c f3 90 <48> b8 00 00 00 00 00 fc ff df 48 8b 8c 24 a8 00 00 00 80 3c 01 00
RSP: 0018:ffffc90004e6f7a0 EFLAGS: 00000246
RAX: ffffc90004e6f900 RBX: 1ffff11006ff9bbe RCX: 1ffffffff1ca7871
RDX: 00000000e6b90d15 RSI: ffffffff8bcbd060 RDI: 0000000000000001
RBP: ffffc90004e6f9f0 R08: 1d00000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8e3c3880 R12: ffff888037fcddc0
R13: ffffffff8e53c388 R14: ffffffff8e53c390 R15: 1ffff11006ff9bba
 rtlock_slowlock kernel/locking/rtmutex.c:1922 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x165/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 simple_release_fs+0x2f/0xd0 fs/libfs.c:1120
 __simple_recursive_removal+0x215/0x520 fs/libfs.c:623
 debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:781
 kvm_destroy_vm_debugfs virt/kvm/kvm_main.c:988 [inline]
 kvm_destroy_vm virt/kvm/kvm_main.c:1261 [inline]
 kvm_put_kvm+0x147/0xae0 virt/kvm/kvm_main.c:1331
 kvm_vm_release+0x46/0x50 virt/kvm/kvm_main.c:1354
 __fput+0x42a/0xa80 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1009
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1161
 x64_sys_call+0x18bf/0x18c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f132ec60d05
Code: Unable to access opcode bytes at 0x7f132ec60cdb.
RSP: 002b:00007ffe413e3968 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f132ec60d05
RDX: 00000000000000e7 RSI: ffffffffffffffd8 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000009
R10: 0000000000000009 R11: 0000000000000202 R12: 0000000000000000
R13: 00007f132ecfa118 R14: 00007f132ecfc3c8 R15: 00007f132ecfc3e0
 </TASK>
----------------
Code disassembly (best guess):
   0:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   4:	4c 8b b4 24 80 00 00 	mov    0x80(%rsp),%r14
   b:	00
   c:	4c 8b 2c 24          	mov    (%rsp),%r13
  10:	74 08                	je     0x1a
  12:	4c 89 ef             	mov    %r13,%rdi
  15:	e8 db 0e df f6       	call   0xf6df0ef5
  1a:	48 8d 84 24 60 01 00 	lea    0x160(%rsp),%rax
  21:	00
  22:	49 39 45 00          	cmp    %rax,0x0(%r13)
  26:	75 6c                	jne    0x94
  28:	f3 90                	pause
* 2a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax <-- trapping instruction
  31:	fc ff df
  34:	48 8b 8c 24 a8 00 00 	mov    0xa8(%rsp),%rcx
  3b:	00
  3c:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)


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
