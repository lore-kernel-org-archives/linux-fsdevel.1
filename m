Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98749385D89
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377673; cv=pass; b=Qb3w6FCp5t6XxC4b+DbNQSc3gzZ8t+ttzDAyETicpZCegs6zW5NuamSUuMjAHrQ6A+Kt5pOItMC34RZoFJoT/+MU4xB8pyErwB2J0Dt6/s8kjWExsTTl248aCTdcDBkf/tORbFYHbLbyexL6ZGhvi4aBCUjwAuPjE40mFlpKXkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377673; c=relaxed/simple;
	bh=eDFPqV6ofey3WJpXaBIPeNf2hhbBL+5COCs/2z8Qy1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SrW2kKwCAIE72K2W4TivSvLzQ4nXKpVBVBd+PdSOsPWcprGu2lbrfU/XLp+zZruPSlHNVvgU6+Fi5WGpDOc8DNqNEUIkUKfxLYjnFdmLZxURMwgPK4X8V0xw5Upok5uikYYomZX0zcCxbw1XYQqvnZ6LHXfmsp5QI2LWRY4a/bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajfj9aVt; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajfj9aVt"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec450b950dso415409266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377670; cv=none;
        d=google.com; s=arc-20260327;
        b=E2qNpwTdpHcwn7fVNtw4zF+YuKfscxYbIpz/v85aguTNvyfypbK1SiJIoNDAajk/la
         cDlWcXU4UfvwOCZvzZiBOpkHhZD9L1DRiKNTFFxG0zVHtqyZc6vk9hityRrn7eydryXD
         +wcHEmcw5cbpco2OBJmJ39mr8xreMes2kN4KpdhwQ2T1IGqVoBpCneImQiF9UyzrqxUt
         z/WCSs9eOdA52svafA0k48KS6zaIcwhVQWiRCLn8TEEBQbltli5PUiIuZ7M8KOKhBcwm
         en4yUOaUPhxDOP07hESrCshcT7rae4fxRg37kIx4zaRk4Y4XlKOZnRfvuJGV/YKqydEu
         OyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KcnObFboHgAYd7OTM2x9vdxPwqkR3E3RbH1I45voOck=;
        fh=mtyohiAV1vqWpXS34KtzIOGsA3kcZujNftPsYjBP/Ko=;
        b=BlwihxseAl1zMinQUql78GUCFvF3mtWwJuqjmEyfrMT6ms39yRep8u7Npy97/mZPuS
         kB08lZ11GW2Di4ka5VLSr5W6U4D8GAuSoXEP+K8fcpxcN0VzfNnwFJ7w6qwsvJHqodUl
         aWsHrXt6gdEo9ObLoicXcAJGU/J3c2BDN8hUE0tOJDAJ7zToT3qObg2z89smvlRjqe3k
         ggKNEhdCa9WAkOXdYIxzVTRZtXgHjzYCcFg+1AZpbs2gFyiiI/NBBUnrl/obfXSbi+MA
         D2sgeaV/9+ThXwF2EEnyJ5Kd7jyNJUUv5z4jIgPp46cvs2aI6zsuCtSQ8AYmrgTmoj08
         VAQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377670; x=1782982470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KcnObFboHgAYd7OTM2x9vdxPwqkR3E3RbH1I45voOck=;
        b=Ajfj9aVtHqmAGhDQz9bz1ETE7Ls6B5WJyxwgtFGJFJUAhdhgfFUUKljCzGkhsetwWm
         iSoynvJPp22X8D1T3UN2lEnIsUVzOTypLnm1qZIOC2MjewtbmUUC03t7Pz72oqCOV4m+
         +KPrRKlj/Tlfk24RvhIuODUiFwfuUO83YbXuSl4ddDEU0bn418hsb+WsZF/dZ/Rc+WSN
         FqzvSth2lw/7h42c/EiF619ST8AWohBcZ1Zb1dW9Yt+3PsIcJX0H+kiVlNUEXcv8tImR
         BJmnXdMmyUSJbbG9qecD5ckHugTNLOEQ+ciG/rPZ65H2q2CnTh4DHk/pnxa5X7a32hN9
         LG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377670; x=1782982470;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcnObFboHgAYd7OTM2x9vdxPwqkR3E3RbH1I45voOck=;
        b=KFynX7u/9NzuyT+I0ptEJfzIJJ0c3NkuNxkFNbNY7Rk2IGfTIbCwsLHtpx15Fw/oar
         IuXEt8JQ0SPDIvuzI1BlqM5c7eYm+pU6NplmGOCPpIahqDh0xF1TK2cq664Sq2HEMmq8
         VTAA7oEahoe4FGqjWSLnqBMg4os/ggmiqt3BSblAjKDFSMx1ISHXAZfWPU7l1+7BHVIS
         k4STJ625Y1/i6gk6aYTH47SDNBYPEzAD9zighOx5I20QLYDFbia0GhsCh8VT6fe78mn1
         ZDOlC2admrDaFQ8yT0iBr4cBHdZ4dZiuvHZ4OZS/Pys2Tfp6r5n1Fdxs5POIk6AbxVig
         ULTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAtGq7MXLepqIWX+GyN5tDWC9HYDsK4Y/VEkFUnh1+XSyUpWFN7DF1f3G4qQ1hgJv1fofUWbPsA+GRWmoD@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMXp3CuT0MCFJEXmvTBKCSDXF7O+hEGWU8xxh/j0G42Fyugyy
	1cOOzLFUlKeopDNpNMfEYTJTj0QAxQxKElOLbruRNNeeM/DHJJFxOYJ0i9AlmKCJIUvBgxH3xjI
	O1r0PwHQGOBUG1x1ih98XBpwmf0vT6LA=
X-Gm-Gg: AfdE7clnuFVaO1BWuU7y3jfUQhx/V9lbW3R2IY9DjnWYN/+UIyEO61iHfJ3ZsmWqVvC
	gpY5CkJiWjtnMRjwEwa9Z93RUiG3RwwRYMd3/Snom/kJTT5odkVJ8ZKyn5Tp1DUOm8zGFmIA+n8
	7qw1jRU0oXRzG5ta44FueDW/Ip7OLVYlYF+3Y/p75h1JXve9gcqLA8VJ3tCe7Teg08vXZtQcnHm
	7wZ9DHEUEQLUGFr3Mm27CQKdcM5firUlCyfrv+hpCT6b7ZrRhv3fCRzgyRETPCEQ6IZokqjcA==
X-Received: by 2002:a17:907:398c:b0:c05:a926:c2aa with SMTP id
 a640c23a62f3a-c1205f3392dmr97530166b.37.1782377669248; Thu, 25 Jun 2026
 01:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 25 Jun 2026 16:53:49 +0800
X-Gm-Features: AVVi8CfQJOPpFW5AJhjZtNJTSDvDYN-XK5hPkm1ryIR7x_RBQj733x4Hi7CEdTg
Message-ID: <CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com>
Subject: [Linux Kernel Bug] INFO: task hung in hfsplus_write_inode
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, slava@dubeyko.com
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We are writing to report a task hung issue discovered in the hfsplus
subsystem with our modified syzkaller. This issue
is reproducible on the latest version of linux (v7.1, commit
8cd9520d35a6c38db6567e97dd93b1f11f185dc6). Below is the relevant part
of the kernel console log formatted by syz-symbolize and our root
cause analysis:

---
INFO: task kworker/u10:3:63 blocked for more than 147 seconds.
      Not tainted 7.1.0 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u10:3   state:D
 stack:22456 pid:63    tgid:63    ppid:2      task_flags:0x4208060
flags:0x00080000
Workqueue: writeback wb_workfn
 (flush-7:4)

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x177f/0x56c0 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7283
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7340
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x819/0x1680 kernel/locking/mutex.c:820
 hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
 write_inode fs/fs-writeback.c:1584 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1827
 writeback_sb_inodes+0x913/0x1910 fs/fs-writeback.c:2056
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2132
 wb_writeback+0x43f/0xae0 fs/fs-writeback.c:2243
 wb_check_old_data_flush fs/fs-writeback.c:2347 [inline]
 wb_do_writeback fs/fs-writeback.c:2400 [inline]
 wb_workfn+0xaf2/0xef0 fs/fs-writeback.c:2428
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3397
 worker_thread+0xa54/0xfc0 kernel/workqueue.c:3478
 kthread+0x38a/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u10:7:181 blocked for more than 149 seconds.
      Not tainted 7.1.0 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u10:7   state:D
 stack:23848 pid:181   tgid:181   ppid:2      task_flags:0x4208060
flags:0x00080000
Workqueue: writeback wb_workfn
 (flush-7:5)

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x177f/0x56c0 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7283
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7340
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x819/0x1680 kernel/locking/mutex.c:820
 hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
 write_inode fs/fs-writeback.c:1584 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1827
 writeback_sb_inodes+0x913/0x1910 fs/fs-writeback.c:2056
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2132
 wb_writeback+0x43f/0xae0 fs/fs-writeback.c:2243
 wb_check_old_data_flush fs/fs-writeback.c:2347 [inline]
 wb_do_writeback fs/fs-writeback.c:2400 [inline]
 wb_workfn+0xaf2/0xef0 fs/fs-writeback.c:2428
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3397
 worker_thread+0xa54/0xfc0 kernel/workqueue.c:3478
 kthread+0x38a/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u9:2:202 blocked for more than 150 seconds.
      Not tainted 7.1.0 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:2    state:D
 stack:22312 pid:202   tgid:202   ppid:2      task_flags:0x4208060
flags:0x00080000
Workqueue: writeback wb_workfn
 (flush-7:7)

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x177f/0x56c0 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7283
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7340
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x819/0x1680 kernel/locking/mutex.c:820
 hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
 write_inode fs/fs-writeback.c:1584 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1827
 writeback_sb_inodes+0x913/0x1910 fs/fs-writeback.c:2056
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2132
 wb_writeback+0x43f/0xae0 fs/fs-writeback.c:2243
 wb_check_old_data_flush fs/fs-writeback.c:2347 [inline]
 wb_do_writeback fs/fs-writeback.c:2400 [inline]
 wb_workfn+0xaf2/0xef0 fs/fs-writeback.c:2428
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3397
 worker_thread+0xa54/0xfc0 kernel/workqueue.c:3478
 kthread+0x38a/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u9:3:609 blocked for more than 150 seconds.
      Not tainted 7.1.0 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:3    state:D stack:24344 pid:609   tgid:609   ppid:2
   task_flags:0x4208060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x177f/0x56c0 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7283
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7340
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x819/0x1680 kernel/locking/mutex.c:820
 hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
 write_inode fs/fs-writeback.c:1584 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1827
 writeback_sb_inodes+0x913/0x1910 fs/fs-writeback.c:2056
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2132
 wb_writeback+0x43f/0xae0 fs/fs-writeback.c:2243
 wb_check_old_data_flush fs/fs-writeback.c:2347 [inline]
 wb_do_writeback fs/fs-writeback.c:2400 [inline]
 wb_workfn+0xaf2/0xef0 fs/fs-writeback.c:2428
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3397
 worker_thread+0xa54/0xfc0 kernel/workqueue.c:3478
 kthread+0x38a/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u9:5:1845 blocked for more than 151 seconds.
      Not tainted 7.1.0 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:5    state:D
 stack:26024 pid:1845  tgid:1845  ppid:2      task_flags:0x4208060
flags:0x00080000
Workqueue: writeback wb_workfn
 (flush-7:2)

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x177f/0x56c0 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7283
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7340
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x819/0x1680 kernel/locking/mutex.c:820
 hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
 write_inode fs/fs-writeback.c:1584 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1827
 writeback_sb_inodes+0x913/0x1910 fs/fs-writeback.c:2056
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2132
 wb_writeback+0x43f/0xae0 fs/fs-writeback.c:2243
 wb_check_old_data_flush fs/fs-writeback.c:2347 [inline]
 wb_do_writeback fs/fs-writeback.c:2400 [inline]
 wb_workfn+0xaf2/0xef0 fs/fs-writeback.c:2428
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3397
 worker_thread+0xa54/0xfc0 kernel/workqueue.c:3478
 kthread+0x38a/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:1/10:
 #0:
ffff88802b83b0e0 (
&rq->__lock
){-.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x31/0x150 kernel/sched/core.c:652
 #1:
ffff88802b824588
 (
psi_seq
){-.-.}-{0:0}
, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
4 locks held by kworker/u9:0/26:
 #0:
ffff888041ec7940
 (
(wq_completion)writeback
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3289 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1:
ffffc900004dfc40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3290 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2:
ffff8880213180d8
 (
&type->s_umount_key
#54
){.+.+}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3:
ffff88802a52c0a8
 (
&tree->tree_lock
){+.+.}-{4:4}
, at: hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
4 locks held by kworker/u9:1/34:
 #0:
ffff888041ec7940
 (
(wq_completion)writeback
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3289 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1:
ffffc9000056fc40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3290 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff88804746e0d8
 (
&type->s_umount_key
#54
){.+.+}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3:
ffff88801ff680a8
 (
&tree->tree_lock
){+.+.}-{4:4}
, at: hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
1 lock held by khungtaskd/35:
 #0:
ffffffff8e55cce0
 (
rcu_read_lock
){....}-{1:3}
, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u10:2/41:
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3289 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1:
ffffc900005dfc40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3290 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff88804e05c0d8 (&type->s_umount_key#54){.+.+}-{4:4}, at:
super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff888046b200a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 #3: ffff888046b200a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
4 locks held by kworker/u10:3/63:
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1: ffffc90001087c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc90001087c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff88804f1aa0d8 (&type->s_umount_key#54){.+.+}-{4:4}, at:
super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff888040ff20a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 #3: ffff888040ff20a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
4 locks held by kworker/u10:7/181:
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1: ffffc900022f7c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc900022f7c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff8880476b00d8 (&type->s_umount_key#54){.+.+}-{4:4}, at:
super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff88804f3ca0a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 #3: ffff88804f3ca0a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
4 locks held by kworker/u9:2/202:
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1: ffffc900023a7c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc900023a7c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff8880259480d8 (&type->s_umount_key#54){.+.+}-{4:4}, at:
super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff888020e000a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 #3: ffff888020e000a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
4 locks held by kworker/u9:3/609:
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1: ffffc90003907c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc90003907c40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff888024b6c0d8 (&type->s_umount_key#54){.+.+}-{4:4}, at:
super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff88801e4060a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 #3: ffff88801e4060a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
4 locks held by kworker/u9:5/1845:
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff888041ec7940 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3397
 #1: ffffc9000932fc40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc9000932fc40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3397
 #2: ffff888024c000d8 (&type->s_umount_key#54){.+.+}-{4:4}, at:
super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff88802353a0a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:156 [inline]
 #3: ffff88802353a0a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:185
6 locks held by syz-executor300/9385:
6 locks held by syz-executor300/9386:
7 locks held by syz-executor300/9389:
6 locks held by syz-executor300/9394:
6 locks held by syz-executor300/9399:
6 locks held by syz-executor300/9393:
6 locks held by syz-executor300/9398:
6 locks held by syz-executor300/9400:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 35 Comm: khungtaskd Not tainted 7.1.0 #2 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfdf/0x1040 kernel/hung_task.c:561
 kthread+0x38a/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9389 Comm: syz-executor300 Not tainted 7.1.0 #2 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2028 [inline]
RIP: 0010:vprintk_emit+0x2f4/0x550 kernel/printk/printk.c:2478
Code: 43 8e 31 f6 31 d2 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 9f ec
fc ff 48 83 c4 08 80 3d 84 e7 6a 18 00 0f 84 8b 00 00 00 f3 90 <80> 3d
75 e7 6a 18 00 0f 84 83 00 00 00 e8 1a f0 20 00 eb ea e8 13
RSP: 0018:ffffc9001104f520 EFLAGS: 00000093
RAX: ffffffff819a4dd6 RBX: ffffffff819a4d95 RCX: ffff888020565dc0
RDX: 0000000000000000 RSI: ffffffff8dd27add RDI: ffffffff8c089460
RBP: ffffc9001104f5d0 R08: 0000000000080000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff819a4d95 R12: 0000000000000065
R13: 0000000000000000 R14: 0000000000000200 R15: ffffffff8bc7ef20
FS:  00007f8333f8a6c0(0000) GS:ffff8880988c3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56f3c2c008 CR3: 00000000221af000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 _printk+0xcf/0x120 kernel/printk/printk.c:2504
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:60 [inline]
 hfsplus_bnode_dump+0x16b/0xa00 fs/hfsplus/bnode.c:362
 hfsplus_brec_remove+0x61c/0x700 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr+0x1d4/0x400 fs/hfsplus/attributes.c:339
 hfsplus_delete_all_attrs+0x1a8/0x330 fs/hfsplus/attributes.c:444
 hfsplus_delete_cat+0x967/0xe50 fs/hfsplus/catalog.c:427
 hfsplus_unlink+0x33f/0x910 fs/hfsplus/dir.c:406
 vfs_unlink+0x272/0x6d0 fs/namei.c:5508
 filename_unlinkat+0x3be/0x5f0 fs/namei.c:5578
 __do_sys_unlinkat fs/namei.c:5607 [inline]
 __se_sys_unlinkat+0x83/0x1a0 fs/namei.c:5599
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x184/0x5c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8333fbe15d
Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8333f8a208 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f833406ad48 RCX: 00007f8333fbe15d
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 00000000ffffff9c
RBP: 00007f833406ad40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 0000200000000000 R14: 0073756c70736668 R15: 0000200000000600
 </TASK>
---

Following is our root cause analysis, the analysis was assisted with
LLM, but may not be entirely accurate:

The root cause of this issue is that the crafted image corrupts HFS+
B-tree node record offset table. The node descriptor can contain an
on-disk `num_recs` value that does not fit in the node, and some
record offsets can point backwards or into the offset table itself.
Several HFS+ B-tree helpers trust these values too much.

Specifically:

1. `hfs_bnode_dump()` iterates over the on-disk record count without
first checking whether `(num_recs + 1) * sizeof(__be16)` can fit after
the node descriptor.  With a corrupt count, the local `off` value can
become negative and is then passed to `hfs_bnode_read_u16()`, whose
offset argument is unsigned.  This produces very large offsets and
repeatedly prints messages like:

hfsplus: requested invalid offset: NODE: id 1, type 0xff, height 1,
node_size 8192, offset 4294962872

2. hfs_brec_lenoff() computes the record length as next_off - off
without validating them.  On corrupt metadata this can underflow or
describe data that overlaps the offset table.

3. hfs_brec_keylen(), __hfs_brec_find(), hfs_brec_goto() and
hfs_brec_remove() can continue after an invalid/empty record
description, which lets the unlink path reach the bad dump/remove
logic.

As a result, the unlink path can spend a long time printing
invalid-offset errors while operating under HFS+ B-tree locks.  Other
writeback workers then block on &tree->tree_lock, and the hung-task
issue is triggered.

One potential fix is to reject malformed B-tree nodes and records earlier:
- validate num_recs against the node size before walking the record
offset table;
- reject record offsets that are unordered, unaligned, outside the
node, or overlapping the offset table;
- stop B-tree search/goto/remove paths when record length or key
length is invalid;
- avoid decrementing an already-zero leaf count on malformed nodes.

With the following patch, the reproducer no longer triggers the
`hfsplus: requested invalid offset` printk flood or the hung task
issue.

```
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..6ecb7e0442a0 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -112,11 +112,13 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
struct hfs_find_data *fd,
    b = 0;
    e = bnode->num_recs - 1;
    res = -ENOENT;
+   if (!bnode->num_recs)
+       return res;
    do {
        rec = (e + b) / 2;
        len = hfs_brec_lenoff(bnode, rec, &off);
        keylen = hfs_brec_keylen(bnode, rec);
-       if (keylen == 0) {
+       if (!len || !keylen || keylen >= len) {
            res = -EINVAL;
            goto fail;
        }
@@ -130,7 +132,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
struct hfs_find_data *fd,
    if (rec != e && e >= 0) {
        len = hfs_brec_lenoff(bnode, e, &off);
        keylen = hfs_brec_keylen(bnode, e);
-       if (keylen == 0) {
+       if (!len || !keylen || keylen >= len) {
            res = -EINVAL;
            goto fail;
        }
@@ -232,6 +234,10 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)

    bnode = fd->bnode;
    tree = bnode->tree;
+   if (!bnode->num_recs) {
+       res = -ENOENT;
+       goto out;
+   }

    if (cnt < 0) {
        cnt = -cnt;
@@ -274,7 +280,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)

    len = hfs_brec_lenoff(bnode, fd->record, &off);
    keylen = hfs_brec_keylen(bnode, fd->record);
-   if (keylen == 0) {
+   if (!len || !keylen || keylen >= len) {
        res = -EINVAL;
        goto out;
    }
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff..03fda4c17d84 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -350,15 +350,22 @@ void hfs_bnode_dump(struct hfs_bnode *node)
    struct hfs_bnode_desc desc;
    __be32 cnid;
    int i, off, key_off;
+   u16 num_recs;

    hfs_dbg("node %d\n", node->this);
    hfs_bnode_read(node, &desc, 0, sizeof(desc));
+   num_recs = be16_to_cpu(desc.num_recs);
    hfs_dbg("next %d, prev %d, type %d, height %d, num_recs %d\n",
        be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
-       desc.type, desc.height, be16_to_cpu(desc.num_recs));
+       desc.type, desc.height, num_recs);
+
+   if (!hfs_bnode_num_recs_valid(node, num_recs)) {
+       hfs_dbg("invalid num_recs %u\n", num_recs);
+       return;
+   }

    off = node->tree->node_size - 2;
-   for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
+   for (i = num_recs; i >= 0; off -= 2, i--) {
        key_off = hfs_bnode_read_u16(node, off);
        hfs_dbg(" key_off %d", key_off);
        if (i && node->type == HFS_NODE_INDEX) {
@@ -579,6 +586,9 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
*tree, u32 num)
        goto node_error;
    }

+   if (!hfs_bnode_num_recs_valid(node, node->num_recs))
+       goto node_error;
+
    rec_off = tree->node_size - 2;
    off = hfs_bnode_read_u16(node, rec_off);
    if (off != sizeof(struct hfs_bnode_desc))
@@ -588,6 +598,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
*tree, u32 num)
        next_off = hfs_bnode_read_u16(node, rec_off);
        if (next_off <= off ||
            next_off > tree->node_size ||
+           next_off > rec_off ||
            next_off & 1)
            goto node_error;
        entry_size = next_off - off;
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index e3df89284079..1b0053453a24 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -21,11 +21,26 @@ u16 hfs_brec_lenoff(struct hfs_bnode *node, u16
rec, u16 *off)
 {
    __be16 retval[2];
    u16 dataoff;
+   u16 next_off;
+
+   if (rec >= node->num_recs ||
+       !hfs_bnode_num_recs_valid(node, node->num_recs)) {
+       *off = 0;
+       return 0;
+   }

    dataoff = node->tree->node_size - (rec + 2) * 2;
    hfs_bnode_read(node, retval, dataoff, 4);
    *off = be16_to_cpu(retval[1]);
-   return be16_to_cpu(retval[0]) - *off;
+   next_off = be16_to_cpu(retval[0]);
+   if (*off < sizeof(struct hfs_bnode_desc) ||
+       *off & 1 ||
+       next_off <= *off ||
+       next_off > node->tree->node_size ||
+       next_off > dataoff ||
+       next_off & 1)
+       return 0;
+   return next_off - *off;
 }

 /* Get the length of the key from a keyed record */
@@ -35,6 +50,9 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)

    if (node->type != HFS_NODE_INDEX && node->type != HFS_NODE_LEAF)
        return 0;
+   if (rec >= node->num_recs ||
+       !hfs_bnode_num_recs_valid(node, node->num_recs))
+       return 0;

    if ((node->type == HFS_NODE_INDEX) &&
       !(node->tree->attributes & HFS_TREE_VARIDXKEYS) &&
@@ -43,7 +61,7 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
    } else {
        recoff = hfs_bnode_read_u16(node,
            node->tree->node_size - (rec + 1) * 2);
-       if (!recoff)
+       if (recoff < sizeof(struct hfs_bnode_desc) || recoff & 1)
            return 0;
        if (recoff > node->tree->node_size - 2) {
            pr_err("recoff %d too large\n", recoff);
@@ -185,10 +203,17 @@ int hfs_brec_remove(struct hfs_find_data *fd)
    tree = fd->tree;
    node = fd->bnode;
 again:
+   if (fd->record < 0 ||
+       fd->record >= node->num_recs ||
+       !hfs_bnode_num_recs_valid(node, node->num_recs))
+       return -EIO;
+
    rec_off = tree->node_size - (fd->record + 2) * 2;
    end_off = tree->node_size - (node->num_recs + 1) * 2;

    if (node->type == HFS_NODE_LEAF) {
+       if (!tree->leaf_count)
+           return -EIO;
        tree->leaf_count--;
        mark_inode_dirty(tree->inode);
    }
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c..5710add1650a 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -590,6 +590,24 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
    return is_valid;
 }

+static inline
+bool hfs_bnode_num_recs_valid(struct hfs_bnode *node, u16 num_recs)
+{
+   u32 node_size;
+   u32 offs_size;
+
+   if (!node || !node->tree)
+       return false;
+
+   node_size = node->tree->node_size;
+   if (node_size < sizeof(struct hfs_bnode_desc) + sizeof(__be16))
+       return false;
+
+   offs_size = ((u32)num_recs + 1) * sizeof(__be16);
+
+   return offs_size <= node_size - sizeof(struct hfs_bnode_desc);
+}
+
 static inline
 u32 check_and_correct_requested_length(struct hfs_bnode *node, u32
off, u32 len)
 {
```

If this solution is acceptable, we are happy to submit a patch.

The kernel console output, kernel config, syzkaller reproducer, and C
reproducer are also available at google drive:
https://drive.google.com/drive/folders/1jxQNoUg-phb14qPT6DnfC433dkkRwznj?usp=sharing

Please let me know if any further information is required.

Best Regards,
Jiaming Zhang
