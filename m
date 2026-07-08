Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14012F5A29
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530116; cv=pass; b=pcwRmbuSYXLg6vuTm7NHGE7OX/Rbow93x17IQ9rvTjnMFUAOY2wdLFXGFvsbzdsowg51fs8S/qAeySNJcs+kido2F0NvQaVh0mTZ+Sb0uvz0au8FJ1LEPzToMMPJvrGlVP4O7pfOGWCGq6RkJ9YqM/K7OvqBKB7iypcxW2irQfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530116; c=relaxed/simple;
	bh=3XikqGZekPqJ6ZVCF+FYNDP92AGjrgI7XqJtdNwoZzY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lSfqUteBYpBklpiav6wl3Wx3febXh7k1yqA5AkzaHAxm6IjroQPmoyYreGc/wlT2+kO+wEutXVNM84St4tlaNZH9yZTdJNPEV4QJOWsAYhbH12/bo0a/ED5vy3dU8+mykkMFmXZ6TPCTeWpFFbhVYUDTnEd84VPAoF6KHx4j87A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9OChvjp; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9OChvjp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so1695945a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 10:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783530112; cv=none;
        d=google.com; s=arc-20260327;
        b=HQDn7a5cFEEAN1JA4bB707jjcITly10N9FYsl4Ef+Mif1SlDCdqGok6mjx5ReEhxuC
         0J5lKq86sPaKZRq0nCcIrE90RNd0NEz3NNJkVYtsY7+1j8mQIshj0k0oZPCpDjfi6Uvh
         QE3GSsWGCrybESypZcm/OAKfa0wVrmdm9VhiMMkYgmDWlEDFtIJkavMciFLoMJwx34T0
         1mg9OOBJzuPF0XnswlLs+2t5PYITCAlZZJwiEXbYw5CRLiGflb63m6lvbF4IxfkuRxra
         Ppyw8Os5GvxMmyzz+/txtH0r3pqwY38hRy1wnP45FE8WEcA+kLdErpfdUKz5qQC+L8fD
         WX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AwEq5u1dTiz17lutdaZaycCWHo7StiJ08c4t3BEtA2c=;
        fh=85WazRecJySCkfm76ZNOsiOHEIDAZOzcy5TZ6UgAhZQ=;
        b=c+HoejH/qeFJRdRlKe4oomzR+qQoyTvW1HKwuxDK2FV1VhqrPVBzd+qZNJHxfsPn8d
         5c/neJWR/YLjdYJmm6xqXqgEY6uElYGNgPDmEraz+1v8DsY/nPki6FyZ5tTMkwpz70lL
         gE4aY1julj6x8h1MF/amwWA3pl2vLbbp+WJzt1A06KpAA6voHfBTEmRSUGzdeZrjwDSd
         OZICVka+qslNIGxTS8k/aXUV0YxzHFbkmZB9PDoqv4VBPLk37IIyGvrjSNraLkzQ1rZi
         C+jBWwFxKTFsfxd2ad8yUQw+2M2lFMgeTg+DvinJVr0Tu/sEDESS+CBVemXnPalVxnQ4
         n8yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783530112; x=1784134912; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwEq5u1dTiz17lutdaZaycCWHo7StiJ08c4t3BEtA2c=;
        b=k9OChvjpEp0HRC9OAp/oZmn7iNx3DhidtbG6yGR2xdXO4iKwe+hI8/v5/rygB86GmW
         yj1qPfo14+wc3+5lJ4VQ8hwtZk3WjWVnj7fb/JKnhjDyS2DIVorSB0HNpuxibihGSskN
         SOxpP6UN5WJCHHws7d7B7BNWH6Gh5xPQpHhjWpZTYaJUUspAGaTmDmgrAIA67drXj1Ju
         RxhBs2+Y1lvOEL4M4p08WAStXcDQuM6fAQK00fxh98Noq+09w0Pqu8oQLsNozaEMJLDN
         mo4Nz5iWMiIW9ZcCH5fCRI1YTNw255Coak+iuOAB+y9EUVDhKZoavcp8+HmcuPMAO9k4
         CuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530112; x=1784134912;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AwEq5u1dTiz17lutdaZaycCWHo7StiJ08c4t3BEtA2c=;
        b=mYEyhYEAcT7iZ6FbT4N41jmYh1YE2E5ekNvz02FLADBwoOBMKg1i/A1miB3HKcQEN6
         4y6mm/wkur5HKH6P1vmHY6IS9C9aV4ZxnIAsXi+P5kHBSqwc9BYN4pqFrrR3xfRb0q+l
         ErcYnUv4IgrzcvvfO0E9yOFTIjkwP1Wt/dq7vq8es5RGxgldIToHEU+0P/qy6DVJHt/g
         01GYjRVDfll1wRRXHpQXEIhfQqDtTkL1s1g79g86cqcwnt3hR43fhvDYUijEnIO7pBfj
         AysHioJYykk3nVDFy7+U9mSaS4vjev0Vv2rYU4yWirBzS1OkpeF2i3cahZsRVlgJWZCY
         CIKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyQL0KESdDPOTfRvLWVzuzabe4Wkkav/L/KtacmNeIYaEfk0h7K0v2JGRBrcrDPst+33XeTMuoYNnvX5QB@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGSFFNfgFy4vExxJE8sycOTeeRc0yJfad7DhhcQbr4tOaTcUB
	IUlWdG2AjQeLcoOo62SgdM4gdDCcfo9SUfcjmbwi0KxVYw86RDzjqfVQWY4T7vdZ7HZPGYR4Xzq
	8dET/ZKBUjARaivpIaAaIbqrnGuqYkYE=
X-Gm-Gg: AfdE7clb1cBLD3h2qWxiSuKrsC5304vL1b3nrFUQcoGqoYol5rpaRMfOetUZW2GI6fo
	8Q5ljSI7pApsyQ4beNjUSuP5TdRmJgoDNOnq2frBNf//c1qTbohmA4G0la6NP4bnTqQGnN4wBKc
	rC9w2jD9VbZksyD268RT1gWoYn52UKkAJlWE4DEiKl3XAwe0LTMEmgBxi7qSoPjrvcu2UU67jm8
	K8DA3MjhwSu4fnxKEqUpVZuYkCYuk2VDUWZuwDESr9kKHcYHM++tt87Hgd/kLbkxVz7O+wNIYhA
	mJ/AHJ/EeQd+pJfCGFhdX+MEvVRy
X-Received: by 2002:a17:907:a286:b0:c12:34f0:49b9 with SMTP id
 a640c23a62f3a-c15ce12f619mr148830866b.60.1783530110917; Wed, 08 Jul 2026
 10:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 9 Jul 2026 01:01:12 +0800
X-Gm-Features: AVVi8CdaLSQkqFAqH_pJaOll3D8GL0BNO1uTtvjudIbjidYzbFT-v6PHDSkplP4
Message-ID: <CANypQFZTwjuh75s7dGm5nUXQ=1ko=cSS5AKEZpszbxyQo8w93Q@mail.gmail.com>
Subject: [Linux Kernel Bug] INFO: task hung in hfsplus_commit_superblock
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, slava@dubeyko.com
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	r772577952@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Linux kernel developers and maintainers,

I am reporting another HFS+ hung task issue reproduced on v7.2-rc2
(commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda). Below is the kernel
report:

```
INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Not tainted 7.2.0-rc2 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D
 stack:26840 pid:9     tgid:9     ppid:2      task_flags:0x4208060
flags:0x00080000
Workqueue: events_long delayed_sync_fs

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1743/0x54f0 kernel/sched/core.c:7234
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c0/0x1580 kernel/locking/mutex.c:821
 hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
 hfsplus_sync_fs+0x235/0x430 fs/hfsplus/super.c:276
 delayed_sync_fs+0x98/0xf0 fs/hfsplus/super.c:299
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3405
 manage_workers kernel/workqueue.c:3201 [inline]
 worker_thread+0x8a3/0xda0 kernel/workqueue.c:3461
 kthread+0x389/0x480 kernel/kthread.c:436
      Not tainted 7.2.0-rc2 #9
task:kworker/0:1     state:D stack:24136 pid:10    tgid:10    ppid:2
   task_flags:0x4208060 flags:0x00080000
 hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
 delayed_sync_fs+0x98/0xf0 fs/hfsplus/super.c:299
INFO: task kworker/1:0:24 blocked for more than 143 seconds.
      Not tainted 7.2.0-rc2 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x165/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 wb_check_old_data_flush fs/fs-writeback.c:2370 [inline]
 wb_do_writeback fs/fs-writeback.c:2449 [inline]
 wb_workfn+0xc34/0x1060 fs/fs-writeback.c:2477
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3405
 manage_workers kernel/workqueue.c:3201 [inline]
 worker_thread+0x8a3/0xda0 kernel/workqueue.c:3461
 kthread+0x389/0x480 kernel/kthread.c:436
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3405
 manage_workers kernel/workqueue.c:3201 [inline]
 worker_thread+0x8a3/0xda0 kernel/workqueue.c:3461
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x165/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c0/0x1580 kernel/locking/mutex.c:821
 hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
 hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
 write_inode fs/fs-writeback.c:1607 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1850
 writeback_sb_inodes+0x93f/0x1860 fs/fs-writeback.c:2082
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2155
 wb_check_old_data_flush fs/fs-writeback.c:2370 [inline]
 wb_do_writeback fs/fs-writeback.c:2449 [inline]
 wb_workfn+0xc34/0x1060 fs/fs-writeback.c:2477
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c0/0x1580 kernel/locking/mutex.c:821
 hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
 hfsplus_sync_fs+0x235/0x430 fs/hfsplus/super.c:276
 delayed_sync_fs+0x98/0xf0 fs/hfsplus/super.c:299
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3405
 manage_workers kernel/workqueue.c:3201 [inline]
 worker_thread+0x8a3/0xda0 kernel/workqueue.c:3461
 kthread+0x389/0x480 kernel/kthread.c:436
INFO: task kworker/u9:5:1104 blocked for more than 144 seconds.
      Not tainted 7.2.0-rc2 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:5    state:D stack:23672 pid:1104  tgid:1104  ppid:2
   task_flags:0x4208060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-7:2)
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1607 [inline]
 __writeback_single_inode+0x75a/0x10f0 fs/fs-writeback.c:1850
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2155
 wb_check_old_data_flush fs/fs-writeback.c:2370 [inline]
 wb_do_writeback fs/fs-writeback.c:2449 [inline]
 wb_workfn+0xc34/0x1060 fs/fs-writeback.c:2477
INFO: task kworker/1:3:5020 blocked for more than 144 seconds.
      Not tainted 7.2.0-rc2 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:26840 pid:5020  tgid:5020  ppid:2
   task_flags:0x4208060 flags:0x00080000
Workqueue: events_long delayed_sync_fs

Call Trace:
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x165/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c0/0x1580 kernel/locking/mutex.c:821
 hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
 hfsplus_sync_fs+0x235/0x430 fs/hfsplus/super.c:276
 delayed_sync_fs+0x98/0xf0 fs/hfsplus/super.c:299
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3405
 manage_workers kernel/workqueue.c:3201 [inline]
 worker_thread+0x8a3/0xda0 kernel/workqueue.c:3461
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task kworker/1:4:9514 blocked for more than 145 seconds.
      Not tainted 7.2.0-rc2 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3405
 manage_workers kernel/workqueue.c:3201 [inline]
 worker_thread+0x8a3/0xda0 kernel/workqueue.c:3461
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
3 locks held by kworker/0:0/9:
 #0:
ffff88801a46a940
 ((wq_completion)events_long
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc900001afc40
 (
(work_completion)(&(&sbi->sync_work)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff888020422188 (&sbi->vh_mutex){+.+.}-{4:4}, at:
hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
3 locks held by kworker/0:1/10:
 #0: ffff88801a46a940 ((wq_completion)events_long){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801a46a940 ((wq_completion)events_long){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1: ffffc900001bfc40
((work_completion)(&(&sbi->sync_work)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3298 [inline]
 #1: ffffc900001bfc40
((work_completion)(&(&sbi->sync_work)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2: ffff888020421188 (&sbi->vh_mutex
){+.+.}-{4:4}
, at: hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
3 locks held by kworker/1:0/24:
 #2:
ffff88804ebab988
 (
&sbi->vh_mutex
){+.+.}-{4:4}
, at: hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
4 locks held by kworker/u10:0/27:
 #0:
ffff888040ab9140
 (
(wq_completion)writeback
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffff88804b6c40d8
 (
&type->s_umount_key
#54
){++++}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3:
ffff88804ba860a8
 (
&tree->tree_lock
, at: hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
ffff888040ab9140
 (
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
ffffc9000051fc40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2: ffff888020ed20d8 (&type->s_umount_key
#54
){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3: ffff8880298620a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
 #3: ffff8880298620a8 (&tree->tree_lock){+.+.}-{4:4}, at:
hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
3 locks held by kworker/1:1/32:
ffff88801a46a940
 (
(wq_completion)events_long
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc9000053fc40
 (
(work_completion)(&(&sbi->sync_work)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804ebaf188
 (
&sbi->vh_mutex
){+.+.}-{4:4}
, at: hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
1 lock held by khungtaskd/34:
 #0:
ffffffff8e35a180 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire
include/linux/rcupdate.h:300 [inline]
ffffffff8e35a180 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:840 [inline]
ffffffff8e35a180 (rcu_read_lock){....}-{1:3}, at:
debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u10:1/36:
 #0:
 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work
kernel/workqueue.c:3297 [inline]
 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1: ffffc9000058fc40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3298 [inline]
 #1: ffffc9000058fc40
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff8880452240d8
 (
&type->s_umount_key
#54
){++++}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3:
ffff888045c880a8
 (
&tree->tree_lock
){+.+.}-{4:4}
, at: hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
4 locks held by kworker/u10:2/40:
 #0:
ffff888040ab9140
 (
(wq_completion)writeback
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc900005cfc40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804b00c0d8
 (
&type->s_umount_key
#54
){++++}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3:
ffff88804bade0a8 (
&tree->tree_lock
){+.+.}-{4:4}
, at: hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
4 locks held by kworker/u10:3/681:
 #0:
ffff888040ab9140
 (
(wq_completion)writeback){+.+.}-{0:0}, at: process_one_work
kernel/workqueue.c:3297 [inline]
(wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc90003f87c40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804a4980d8 (&type->s_umount_key
#54
){++++}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3:
ffff8880542940a8
 (
&tree->tree_lock
){+.+.}-{4:4}
, at: hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
4 locks held by kworker/u10:4/706:
 #0: ffff888040ab9140 ((wq_completion)writeback){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc900040b7c40
 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804370c0d8
 (
&type->s_umount_key
#54
){++++}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3:
ffff88804e22e0a8
 (
&tree->tree_lock
){+.+.}-{4:4}, at: hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
){+.+.}-{4:4}, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
3 locks held by kworker/1:2/890:
 #0:
ffff88801a46a940
 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work
kernel/workqueue.c:3297 [inline]
 ((wq_completion)events_long){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc9000616fc40
 (
(work_completion)(&(&sbi->sync_work)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804eba9188
 (
&sbi->vh_mutex
){+.+.}-{4:4}
, at: hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
4 locks held by kworker/u9:5/1104:
 #0:
ffff888040ab9140
 (
(wq_completion)writeback
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc90006d0fc40 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3298 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2: ffff88804b0260d8
 (
&type->s_umount_key#54
){++++}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3: ffff888043fbc0a8 (&tree->tree_lock
){+.+.}-{4:4}
, at: hfsplus_system_write_inode fs/hfsplus/super.c:154 [inline]
, at: hfsplus_write_inode+0x54a/0x760 fs/hfsplus/super.c:183
3 locks held by kworker/1:3/5020:
 #0:
ffff88801a46a940 ((wq_completion)events_long){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3297 [inline]
ffff88801a46a940 ((wq_completion)events_long){+.+.}-{0:0}, at:
process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc90004007c40
 (
(work_completion)(&(&sbi->sync_work)->work)
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3298 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804ebae988
 (&sbi->vh_mutex){+.+.}-{4:4}, at:
hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
11 locks held by syz-executor167/9458:
11 locks held by syz-executor167/9461:
6 locks held by syz-executor167/9462:
6 locks held by syz-executor167/9463:
11 locks held by syz-executor167/9465:
6 locks held by syz-executor167/9466:
6 locks held by syz-executor167/9467:
6 locks held by syz-executor167/9469:
3 locks held by kworker/1:4/9514:
 #0: ffff88801a46a940
 (
(wq_completion)events_long){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc90004427c40
 (
(work_completion)(&(&sbi->sync_work)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff88804ebaf988
 (
&sbi->vh_mutex
){+.+.}-{4:4}, at: hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206
3 locks held by kworker/1:6/9516:
 #0:
ffff88801a46a940
 (
(wq_completion)events_long
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3297 [inline]
, at: process_scheduled_works+0xa23/0x1840 kernel/workqueue.c:3405
 #1:
ffffc90004407c40
 (
(work_completion)(&(&sbi->sync_work)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3298 [inline]
, at: process_scheduled_works+0xa5e/0x1840 kernel/workqueue.c:3405
 #2:
ffff8880449bc188
 (
&sbi->vh_mutex
){+.+.}-{4:4}
, at: hfsplus_commit_superblock+0x8d/0xa40 fs/hfsplus/super.c:206

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 34 Comm: khungtaskd Not tainted 7.2.0-rc2 #9 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfdf/0x1040 kernel/hung_task.c:561
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9461 Comm: syz-executor167 Not tainted 7.2.0-rc2 #9
PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:format_decode+0xbbf/0xdb0 lib/vsprintf.c:-1
Code: 00 00 00 fc ff df e9 b5 f7 ff ff 89 d9 80 e1 07 38 c1 0f 8c bf
f7 ff ff be 04 00 00 00 48 89 df e8 16 b7 ae f6 e9 ad f7 ff ff <48> 8b
4c 24 18 80 e1 07 38 c1 0f 8c 13 f9 ff ff 48 8b 7c 24 18 e8
RSP: 0018:ffffc9000662ed70 EFLAGS: 00000206
RAX: 0000000000000005 RBX: ffffffff8ccdb7d1 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffff888024755dc0 R09: 0000000000000002
R10: 0000000000000025 R11: 0000000000000000 R12: 00000000000001b0
R13: 0000000000000008 R14: ffffffff8b8d8f49 R15: 000000000000006c
FS:  0000555557a3f380(0000) GS:ffff888098a57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557a406e4 CR3: 00000000239c4000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 vsnprintf+0xfa/0xea0 lib/vsprintf.c:2887
 sprintf+0xd9/0x120 lib/vsprintf.c:3112
 print_time kernel/printk/printk.c:1359 [inline]
 info_print_prefix+0x155/0x310 kernel/printk/printk.c:1385
 record_print_text+0x155/0x450 kernel/printk/printk.c:1434
 printk_get_next_message+0x266/0x7b0 kernel/printk/printk.c:3072
 console_emit_next_record kernel/printk/printk.c:3137 [inline]
 console_flush_one_record kernel/printk/printk.c:3269 [inline]
 console_flush_all+0x4fb/0xb00 kernel/printk/printk.c:3343
 __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
 console_unlock+0xc4/0x1a0 kernel/printk/printk.c:3413
 vprintk_emit+0x47b/0x550 kernel/printk/printk.c:2479
 _printk+0xcf/0x120 kernel/printk/printk.c:2504
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:62 [inline]
 hfsplus_bnode_dump+0x16b/0xa00 fs/hfsplus/bnode.c:364
 hfsplus_brec_remove+0x61c/0x700 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr+0x1d4/0x400 fs/hfsplus/attributes.c:339
 hfsplus_delete_all_attrs+0x1a8/0x330 fs/hfsplus/attributes.c:444
 hfsplus_delete_cat+0x833/0xd40 fs/hfsplus/catalog.c:416
 hfsplus_unlink+0x33f/0x910 fs/hfsplus/dir.c:400
 vfs_unlink+0x274/0x6c0 fs/namei.c:5515
 filename_unlinkat+0x3be/0x5f0 fs/namei.c:5585
 __do_sys_unlink fs/namei.c:5620 [inline]
 __se_sys_unlink+0x2e/0x140 fs/namei.c:5617
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x184/0x5c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f51444cb62b
Code: 77 05 c3 0f 1f 40 00 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff
ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 c0 ff ff ff f7 d8
RSP: 002b:00007ffcc3f96c68 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f51444cb62b
RDX: 00007ffcc3f96ca0 RSI: 00007ffcc3f96d30 RDI: 00007ffcc3f96d30
RBP: 00007ffcc3f96d30 R08: 0000000000000073 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffcc3f97e40
R13: 0000555557a48720 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>
```

The root cause appears to be same as the HFS+ hung task issue I reported before:

https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com/

Both reproducers use a crafted image with corrupted B-tree record
metadata. In both cases, the node record count and/or record offset
table can be invalid, and HFS+ B-tree helpers may consume those fields
before they are fully validated. This can make the code repeatedly
read invalid offsets and print "requested invalid offset" messages
while holding HFS+ B-tree state. Depending on which blocked worker is
reported first, the final report may be titled either
hfsplus_write_inode() or hfsplus_commit_superblock(), but both
symptoms come from the same corrupted B-tree metadata handling.

The v2 patch I sent for the previous report validates the shared
B-tree record metadata before B-tree walkers/removal paths use it:

https://lore.kernel.org/lkml/20260702082201.286288-2-r772577952@gmail.com/

so it can also prevent the hfsplus_commit_superblock() hung task from
triggering.

After applying the patch, the reproducer no longer triggers the target
hung task on my machine.

The v2 patch has been on the list for about a week. When you have
time, could you please take a look and let me know whether any changes
are needed?

The kernel console output, kernel config, syzkaller reproducer, and C
reproducer are available on Google Drive:
https://drive.google.com/drive/folders/1xXCV-dtDajsI0Az7BFLPUUkAi5kqEzUj?usp=sharing

Please let me know if any further information is required.

Best regards,
Jiaming Zhang
