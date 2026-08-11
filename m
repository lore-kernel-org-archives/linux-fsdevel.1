Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B308421EF8
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448485; cv=pass; b=LI0k4SbszKxS0GbVRoo/0cg9YUgzHb48RhrtT/bN2mePxdVPjfWdL1A0ork4kbfgsxomf6A3dxrMLrlSpme1/9PstBQlz4ECWxg9Der6u+cHxwBfr4fzDeAhvy2uL5AXMcLkHjDs70Z+Pe54EFvsg1a1EOZB5Vw5ESiPZVdEtno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448485; c=relaxed/simple;
	bh=hzTgHF9d08is9w+V9nsLW49iAm3HBVkgSGdrCi3WiwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRjmpHxGijgfwZiMmYTS6J9L/hvHJHIdgEm0CsqSmgQ8ly/3P/bNEzAJaN4MzM/UOilSeQ0qp5gJ3/+oM3tIEoTl4rt3j65Z5tILX6WO5Ogsfe9CZ8Kx5MIYFg2gHV2y4rxoRXck4YaTVfG5EoiqLc1vUokyUn9VGAMB2njsIVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9vK3R5D; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9vK3R5D"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ee37dc91f5so1713904a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 04:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786448482; cv=none;
        d=google.com; s=arc-20260327;
        b=R1xDb3zUpCNgqCMRFUAOtlrV4jfMJrCV26VHX487vEh1Qwa0LDEs8eJNhuMu0I0z+G
         po0iACGMl8Fc3QpNebfE/GgwdGMKgql7sOuC7RiFG28jsYxo7gxCR65x1SXcb8Ye+YOD
         JeQoa3+MsWa8ERlDY4YJ+IEejYVFrGL3cqHFejBJudAUtdGVQRmT00wAgw2WmzwTPlCe
         WEKnUGpQ1CmbvqX4wjqD4mReqpPrEC6VBru/6blS+D+47Y96BRcoYHSeuR5js3tg440Y
         Caw6ojBcRUBzYRE0BkDOgzz7lvAHELD6XhVSb1DgdWj1Mq1mEZAH1yiBGSIljmqL9Rz4
         QGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HarlHs3JzDA/aPfRbDLTnFFB+dRZtDzPIHhxV2Lz20M=;
        fh=qlSp6lxBZsC9oGDOBtLOntRCvD+aSKqjpBhrFddE3zQ=;
        b=rhecNU9WqP/kuybuzzwaFOUOls31r6oUai439VjFTg5ZRxXA8LwHoU5vru1z7yKeK9
         SOQHKObBaVkXWIQMAzgE2bpoIIijbkVns1L9Z8F9VtJnSHqqPXaX9MPHytuYXhrBiscO
         lbW7zjwDNAwVbIMrUftdXBTo2BHpLpYGdUyvEZf5XBGWmEjjArOc0SZLqI3dBwy6hK1r
         fzoLrJelAPRLSkXUayqqyouUHvJY4cqgFA2yi8o6+rxUP/M7IJ6wwqWkdfqG1p5jotU3
         UtTxhpPgCUXP74SzucKTmQyj27j7wMZwBU1JTa/IGC+SH3tm6gyIJai5cUxYRkeS1zIH
         LFXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786448482; x=1787053282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HarlHs3JzDA/aPfRbDLTnFFB+dRZtDzPIHhxV2Lz20M=;
        b=G9vK3R5D0EpNx/TM/9UJFbKX9iiFrkj5tw4n5bl3lpaBn0Y9GvL3GKJGssb3+h7tgl
         OqX2PgE41e3g9Bc0Gy9GycdwRTpGVumCiA9wUATNKt52L+hmb5zsTj/8iyMQdyzuph3V
         0X8ZPjT3FEqr2cnMg6fJlpg+HJeqYv+/h4NkUgT39oWBHk9BiFUgSWQjaR+Z5j6JRcwr
         uK7xl/FhdyaJ+5r/A6NMejbaIrxOfo0fwnvC7zeZBDA7Nh7xr4lnIDCoadLea+9VrO34
         xX6WptuVvJjGY6ubfS7FvUM8seWJw/TQ0J/BYky2q3gp40CeoHW+e5T7bRNcL76uFwW3
         G+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448482; x=1787053282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HarlHs3JzDA/aPfRbDLTnFFB+dRZtDzPIHhxV2Lz20M=;
        b=Yd8Kw1cpYKVQpe4oE8iDAu1We1Fop9JQyE7k1dGRZdteMdH03r+5RwnRjgNf0k4KB6
         jh+71wqVQejd0tKMwUcRcSf9GgsLeybUYVIxMn6746H4rDHNb2vIKRXhoj1v1L28LVTz
         XqCb3ncKMjdPNl5mBE/8EpKjLajNp1xzKLP34Bu70LGhOG+R3jGtYPo6AgTf7+dkPFWr
         Q/vSrMs+nbgjNuJ9gPo2sAKny5cPYaP23Ad5k+d3glLcJ33NrMGofExtyN8jhg6hFFZl
         vGeJOt2OgntpqRZUFUw5ekCbcmHFa06bL32tGmaP884yw1LT74kZEhBv1DZUyECoOj8O
         wuYg==
X-Forwarded-Encrypted: i=1; AHgh+RrAC9u5LaHaSHpVEH5odrrzCj8u+7xVcC0+LbtS9Kobr929/0SlFVKLJlYDpypr+iL9ivMrH4XaK9jLIELX@vger.kernel.org
X-Gm-Message-State: AOJu0YzPx28EDoi70gf2EJbFnl/FXtdtNclpJ7bOutpbVnp5WTZMjik7
	hGiNiGCTiGjA9WkA3WN28brmc5bJjJlXRQzleIqFnI1uZUoKaLAWAXzKJW+IZT+ngEjEoakmBb6
	vvYa9rKLLCZlF8Xqr9BI0ebZP5KHDsrvGWdG1dqnC
X-Gm-Gg: AR+sD1171Yd4Gg1/DHc+uwYob9JIlFN7mPErl9RGgyAWw2GX6j6ObHLGfA6h0Dn/1/O
	BiRgHZGavaQ9U3ucvGw/AGnS3p52gNUnL21HkfqHFeXeIL+KhqUr4UFxJNHZIlpqdSrr4YD553S
	SDYzCc99ggvgCLMUrAiJkt7IIUAI+O2aOQsrb0duapVjCqq5dmAkxrUtSKLnEuj/2uCFsZXalbC
	G2LshNJJfVnJiatdvNxdADvyZVh3TF6KQXDmNZ6dVc2ypJQ23Esd+v3gwjLpfNxUgBLH8UrscPA
	oa+zekVaO2KMfJvyLZNGRaZot5esUtc6txAUbBHXGq54YGmiWnzlBTYF//S5YX8t8F5d6/u+J3S
	ez3MLianKftACCim9XOk7zolKQxU8RUreeFzPJaI5TFw5sS9LTGy2dZnCE/DooNo2ay7sd+oXSB
	GTA237ZJCnpfzKgLDwgVb2hNA=
X-Received: by 2002:a05:6830:67f8:b0:7e7:45f:ce3c with SMTP id
 46e09a7af769-7f3a830b8eamr1779384a34.14.1786448481678; Tue, 11 Aug 2026
 04:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <682ffdaa.a70a0220.253bc2.0061.GAE@google.com> <6a75a39e.01d0871a.3a0d52.0042.GAE@google.com>
 <20260811-schlecht-arkaden-spickzettel-0dfee4014102@brauner>
In-Reply-To: <20260811-schlecht-arkaden-spickzettel-0dfee4014102@brauner>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 11 Aug 2026 13:41:10 +0200
X-Gm-Features: AUfX_mzBu8CIDC9ZPCMtDgC0yVRojn8ttuv_kDfXYrQLl6jQlY65j0BQ_c5J44I
Message-ID: <CANp29Y70AJYhLqifEAw67vyw=UKPvPosu=1ELMi_daAY8xqyBw@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] [ext4?] INFO: task hung in sb_start_write (2)
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+b3fba2e269970207b61d@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 1:21=E2=80=AFPM 'Christian Brauner' via syzkaller-b=
ugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Aug 07, 2026 at 02:21:34AM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-1=
8-4..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1379cfb9580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D98da55a8827=
74dfe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db3fba2e269970=
207b61d
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e=
255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14b9d7b9580=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b3fba2e269970207b61d@syzkaller.appspotmail.com
> >
> > INFO: task syz-executor328:5959 blocked for more than 15 seconds.
> >       Not tainted syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:syz-executor328 state:D stack:28328 pid:5959  tgid:5959  ppid:5947=
   task_flags:0x400040 flags:0x00080000
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5510 [inline]
> >  __schedule+0x16dc/0x5500 kernel/sched/core.c:7234
> >  __schedule_loop kernel/sched/core.c:7311 [inline]
> >  schedule+0x164/0x2b0 kernel/sched/core.c:7326
> >  percpu_rwsem_wait+0x32d/0x4a0 kernel/locking/percpu-rwsem.c:164
> >  __percpu_down_read+0xf8/0x140 kernel/locking/percpu-rwsem.c:180
> >  percpu_down_read_internal include/linux/percpu-rwsem.h:67 [inline]
> >  percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
> >  __sb_start_write include/linux/fs/super.h:19 [inline]
> >  sb_start_write+0x18e/0x1c0 include/linux/fs/super.h:125
> >  mnt_want_write+0x41/0x90 fs/namespace.c:494
> >  do_tmpfile+0x6c/0x240 fs/namei.c:4817
> >  path_openat+0x3095/0x3850 fs/namei.c:4854
> >  do_file_open+0x23e/0x4a0 fs/namei.c:4892
> >  do_sys_openat2+0x115/0x200 fs/open.c:1368
> >  do_sys_open fs/open.c:1374 [inline]
> >  __do_sys_openat fs/open.c:1390 [inline]
> >  __se_sys_openat fs/open.c:1385 [inline]
> >  __x64_sys_openat+0x138/0x170 fs/open.c:1385
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f3fb490aaf7
> > RSP: 002b:00007fff7f2f6f10 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
> > RAX: ffffffffffffffda RBX: 0000555578a51400 RCX: 00007f3fb490aaf7
> > RDX: 0000000000410001 RSI: 00007f3fb494a764 RDI: ffffffffffffff9c
> > RBP: 00007f3fb494a764 R08: 0000000000000000 R09: 0000000000000000
> > R10: 00000000000001b6 R11: 0000000000000202 R12: 00007fff7f2f70d8
> > R13: 0000000000000002 R14: 00007f3fb4970c80 R15: 0000000000000002
> >  </TASK>
> >
> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/38:
> >  #0: ffffffff8e1c3000 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:300 [inline]
> >  #0: ffffffff8e1c3000 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock in=
clude/linux/rcupdate.h:840 [inline]
> >  #0: ffffffff8e1c3000 (rcu_read_lock){....}-{1:3}, at: debug_show_all_l=
ocks+0x2e/0x180 kernel/locking/lockdep.c:6775
> > 2 locks held by getty/5356:
> >  #0: ffff88803688d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_=
wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> >  #1: ffffc90003cc62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty=
_read+0x460/0x1360 drivers/tty/n_tty.c:2211
> > 1 lock held by syz-executor328/5959:
> >  #0: ffff888035a88500 (sb_writers#4){++++}-{0:0}, at: mnt_want_write+0x=
41/0x90 fs/namespace.c:494
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > NMI backtrace for cpu 1
> > CPU: 1 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT=
_{RT,(full)}
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/24/2026
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> >  nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
> >  nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
> >  trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
> >  __sys_info lib/sys_info.c:157 [inline]
> >  sys_info+0x135/0x170 lib/sys_info.c:165
> >  check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
> >  watchdog+0xfd7/0x1030 kernel/hung_task.c:561
> >  kthread+0x388/0x470 kernel/kthread.c:436
> >  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> > Sending NMI from CPU 1 to CPUs 0:
> > NMI backtrace for cpu 0
> > CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT_{=
RT,(full)}
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/24/2026
> > RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
> > Code: cb 6e 02 e9 13 cf 03 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90=
 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 44 24 00 fb f4 <c3> cc cc cc =
cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
> > RSP: 0018:ffffffff8de07de0 EFLAGS: 00000242
> > RAX: 000000000009a1e9 RBX: ffffffff81998590 RCX: 0000000080000001
> > RDX: 0000000000000001 RSI: ffffffff8d887e30 RDI: ffffffff8bca6d80
> > RBP: ffffffff8de07eb8 R08: ffff8880b8633d5b R09: 1ffff110170c67ab
> > R10: dffffc0000000000 R11: ffffed10170c67ac R12: 0000000000000000
> > R13: 1ffffffff1bdede8 R14: 1ffffffff1bc0fc4 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff888125c36000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000563216b981d0 CR3: 000000000dfb0000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  arch_safe_halt arch/x86/kernel/process.c:767 [inline]
> >  default_idle+0x9/0x20 arch/x86/kernel/process.c:768
> >  default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
> >  cpuidle_idle_call kernel/sched/idle.c:199 [inline]
> >  do_idle+0x2e0/0x540 kernel/sched/idle.c:355
> >  cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
> >  rest_init+0x2de/0x300 init/main.c:717
> >  start_kernel+0x392/0x3e0 init/main.c:1175
> >  x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
> >  x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
> >  common_startup_64+0x13e/0x157
> >  </TASK>
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
>
> The reproducer freezes the root filesystem with FIFREEZE and then opens
> O_TMPFILE on it from a child. Excellent. In addition to that it also
> lowers hung_task_timeout_secs to 15 before freezing and only thaws after
> 60 seconds... Nothing is stuck and the machine recovers.

Thanks for sharing the analysis!

>
> The older crashes look like the same thing. So the fuzzer freezes a
> filesystem and some other program writes to it. That also explains why
> there's only ever the one blocked task and nothing else in the system
> holding anything.
>
> So maybe gate that ioctl for syzkaller?

Normally, we prohibit using FIFREEZE during fuzzing, so the original
finding shouldn't have been caused by it.

But the C reproducer was indeed generated by an LLM, which was not
subject to such restrictions.
I've filed the issue and we'll find a way to address it.

>
> And the LLM thing that is attached to the report is wrong.
>
> #syz invalid
>

FWIW it's better to just keep such bugs open.
"syz invalid" indicates that the issue is a rare or already addressed
false positive and is no longer relevant. In this case, however,
syzbot keeps observing the crash daily, so it will try to re-report it
the next time it observes it.

Something like "#syz set prio: low" and/or "#syz set no-reminders"
would have been a better fit here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bug-labels

--=20
Aleksandr
