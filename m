Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF02D837C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374726; cv=none; b=AhO+YHDLajOjaB5LT12Jwu8KqpiUAgs5IsCOZyQ639E8fGx7y0CGTabuPdoMsvew+cXYYUqfLmqFTMpw8JwdGvr5if673oxZOze2sYA4NMSrLtWRnHF2hmZyXp9xVswLkIKzgupg8EdTU015Ntpdje6OKrgdQ0lkRCjNouHMgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374726; c=relaxed/simple;
	bh=EaEJUICJMZghMgfZCdo87EzcA/vqAgCiMD965v0YvmY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uhjkqCbXpmvwf4bI//6k5xs951hXMys4COZr5qn7fN6TuPhdS0MuKLLlBBD0de2abyYfS8Kxc52ss9K6jkg13aD4cH02yzuHhO/QWv23XoAHWIdAb9JjIHphIIhRhg1VukPDbDt76kZViX5+XxDxFIHZdBtzFvzG7HqvB42TKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-495f637105eso2009805b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 18:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785374723; x=1785979523;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwlAByPDYK9BJ1s1xJI3jXCwX9g3TaWyFZ/4z0rbMWg=;
        b=oxfXUMq6+BIKENHZd8rXs+6cxqpkumkLbt9sSNYaU8Zk1/+2flEhBTmjmP3JxqXrn1
         EBVkwFrMHaEEtOdZMtUBOrzh4LT6tHfaHMQIEkv1mthfu9mBtG4iQTFnuxLWhoYW05og
         08p3THdX8S8CNiITZf7OqUB2CXke1eJkk2Cth2AqLfYTroSkrR/xDHt5h0IJifUpIEav
         ihXHe958P9C2CvQc6IdZXIpyOeAMtxATb6FxTOmk1oAhG5FWpjMiU3HMuLy+FFk41DEF
         ZfWSx1Laj8PEfXI2GRFd0ndDg0chaQ9riUpbvk6O5Plc//4pWfXN5j2tlCj9tqs2jbuS
         V9yg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7neSMNwbO0QfSVJmpOvtj1DlvjJJ2n0XDWaLaiBfC4ma72iQ7hnqeu/NXgcmNV2emrjgE3k+pFwsOfJxi@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj8hWBEUUxZcXjP/35HVxlALsKfKOruE0LpYLbMiVNEw5D80j
	/7Pte7CX63w/6a7zdM3LRCz42LyZMHiNkab+Y6+4nZvr9NPj47vF9itlzCDBFzcy3QOggixPqgd
	son+Me7DdMdYU0ZV4XAHXWjlPcnXpXPGpKdfZSno2WO/KHaWxkneEvGMsrnA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:191c:b0:4a3:26e5:cc02 with SMTP id
 5614622812f47-4ad8775780bmr605917b6e.10.1785374723694; Wed, 29 Jul 2026
 18:25:23 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6aa803.57649fcc.360844.000c.GAE@google.com>
Subject: [syzbot] [fs?] inconsistent lock state in rht_lock
From: syzbot <syzbot+2fb31ade2d0e920fea9a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0ce37745d4bf Merge tag 'block-7.2-20260724' of git://git.k..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=145c3fde580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb31ade2d0e920fea9a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d872ea580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aea499580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/570b0c02ea7a/disk-0ce37745.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b5239f2d447/vmlinux-0ce37745.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbc5fdc8b45c/bzImage-0ce37745.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fb31ade2d0e920fea9a@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
syzkaller #0 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
syz.2.555/6556 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff88807fed6838 (rhashtable_bucket){..-.}-{0:0}, at: rht_lock+0x8b/0x180 include/linux/rhashtable.h:331
{INITIAL USE} state was registered at:
  lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
  rht_lock+0xa3/0x180 include/linux/rhashtable.h:331
  __rhashtable_insert_fast include/linux/rhashtable.h:784 [inline]
  rhashtable_insert_fast include/linux/rhashtable.h:887 [inline]
  pidfs_add_pid+0x325/0xc50 fs/pidfs.c:178
  alloc_pid+0xe7a/0x1310 kernel/pid.c:338
  copy_process+0x20ea/0x4390 kernel/fork.c:2305
  kernel_clone+0x2d7/0x940 kernel/fork.c:2748
  user_mode_thread+0x110/0x180 kernel/fork.c:2824
  rest_init+0x23/0x300 init/main.c:682
  start_kernel+0x392/0x3e0 init/main.c:1175
  x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
  x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
  common_startup_64+0x13e/0x157
irq event stamp: 1488
hardirqs last  enabled at (1487): [<ffffffff8bd0ce38>] irqentry_exit_to_kernel_mode_after_preempt include/linux/irq-entry-common.h:507 [inline]
hardirqs last  enabled at (1487): [<ffffffff8bd0ce38>] irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:542 [inline]
hardirqs last  enabled at (1487): [<ffffffff8bd0ce38>] irqentry_exit+0x218/0x8f0 kernel/entry/common.c:167
hardirqs last disabled at (1488): [<ffffffff8bd082f0>] exc_debug_kernel+0x60/0x140 arch/x86/kernel/traps.c:1235
softirqs last  enabled at (1442): [<ffffffff81d9b01f>] bpf_prog_load+0x166f/0x1c00 kernel/bpf/syscall.c:3223
softirqs last disabled at (1440): [<ffffffff81d742ec>] spin_lock_bh include/linux/spinlock.h:348 [inline]
softirqs last disabled at (1440): [<ffffffff81d742ec>] bpf_ksym_add+0x2c/0x340 kernel/bpf/core.c:641

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rhashtable_bucket);
  <Interrupt>
    lock(rhashtable_bucket);

 *** DEADLOCK ***

no locks held by syz.2.555/6556.

stack backtrace:
CPU: 1 UID: 0 PID: 6556 Comm: syz.2.555 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <#DB>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_usage_bug+0x28b/0x2e0 kernel/locking/lockdep.c:4042
 lock_acquire+0x1cc/0x350 kernel/locking/lockdep.c:5859
 rht_lock+0xa3/0x180 include/linux/rhashtable.h:331
 __rhashtable_remove_fast_one include/linux/rhashtable.h:1065 [inline]
 __rhashtable_remove_fast include/linux/rhashtable.h:1146 [inline]
 rhashtable_remove_fast include/linux/rhashtable.h:1175 [inline]
 rhtab_delete_elem+0x404/0x1b30 kernel/bpf/hashtab.c:2954
 rhtab_map_delete_elem+0xe2/0x190 kernel/bpf/hashtab.c:2985
 bpf_prog_a4f1e23443ac9f8e+0x4e/0x56
 bpf_dispatcher_nop_func include/linux/bpf.h:1454 [inline]
 __bpf_prog_run include/linux/filter.h:724 [inline]
 bpf_prog_run include/linux/filter.h:731 [inline]
 bpf_overflow_handler kernel/events/core.c:10671 [inline]
 __perf_event_overflow+0x3b9/0xea0 kernel/events/core.c:10770
 perf_swevent_overflow kernel/events/core.c:10911 [inline]
 perf_swevent_event+0x439/0x810 kernel/events/core.c:-1
 perf_bp_event+0x318/0x430 kernel/events/core.c:11812
 hw_breakpoint_handler arch/x86/kernel/hw_breakpoint.c:556 [inline]
 hw_breakpoint_exceptions_notify+0x243/0x680 arch/x86/kernel/hw_breakpoint.c:587
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 notify_die+0x144/0x1a0 kernel/notifier.c:588
 notify_debug+0x2e/0x50 arch/x86/kernel/traps.c:1210
 exc_debug_kernel+0xb1/0x140 arch/x86/kernel/traps.c:1272
 asm_exc_debug+0x1e/0x40 arch/x86/include/asm/idtentry.h:631
RIP: 0010:rep_movs_alternative+0x4a/0xa0 arch/x86/lib/copy_user_64.S:74
Code: 61 04 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 c3 cc cc cc cc 48 8b 06 48 89 07 48 8d 47 08 48 83 e0 f8 48
RSP: 0018:ffffc900036efc18 EFLAGS: 00050246
RAX: 00007ffffffff001 RBX: 0000000000000040 RCX: 000000000000003d
RDX: 0000000000000001 RSI: 0000200000000303 RDI: ffffc900036efd53
RBP: ffffc900036efea0 R08: ffffc900036efd8f R09: 1ffff920006ddfb1
R10: dffffc0000000000 R11: fffff520006ddfb2 R12: 1ffff920006ddf94
R13: ffffc900036efd50 R14: ffffc900036efd50 R15: 0000200000000300
 </#DB>
 <TASK>
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:185 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:222 [inline]
 copy_from_bpfptr_offset include/linux/bpfptr.h:53 [inline]
 copy_from_bpfptr include/linux/bpfptr.h:59 [inline]
 __sys_bpf+0x2e7/0xd90 kernel/bpf/syscall.c:6370
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6534
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f55c159de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0f3ce588 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f55c1825fa0 RCX: 00007f55c159de99
RDX: 0000000000000040 RSI: 0000200000000300 RDI: 0000000000000010
RBP: 00007f55c1633eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f55c1825fac R14: 00007f55c1825fa0 R15: 00007f55c1825fa0
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	04 00                	add    $0x0,%al
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00
   c:	0f 1f 00             	nopl   (%rax)
   f:	48 8b 06             	mov    (%rsi),%rax
  12:	48 89 07             	mov    %rax,(%rdi)
  15:	48 83 c6 08          	add    $0x8,%rsi
  19:	48 83 c7 08          	add    $0x8,%rdi
  1d:	83 e9 08             	sub    $0x8,%ecx
  20:	74 db                	je     0xfffffffd
  22:	83 f9 08             	cmp    $0x8,%ecx
  25:	73 e8                	jae    0xf
  27:	eb c5                	jmp    0xffffffee
* 29:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	48 8b 06             	mov    (%rsi),%rax
  33:	48 89 07             	mov    %rax,(%rdi)
  36:	48 8d 47 08          	lea    0x8(%rdi),%rax
  3a:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  3e:	48                   	rex.W


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
