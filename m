Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115463;
	b=HAeTwsRqQAoo+8diEwzl4OJSkPzbKs6eeNtTR6wsWJ3VMJ635Q2x/zFWASKWVUPHYb9I
	 WaoU5HrFceZ+4kORobVlHHGchVg+qinAEAYWkJRGXMINdvnpI55zn6F8ki5XPuXVMNeIS
	 uVTgJ/2GeXOTbFSZybTRY7013nCEoi7gxQYustvPTXKdirAumYY/HI4hDztfk76jk1mql
	 7SJRttC3F/A6/u81ChSyCEMyN83a4N8mWXXX4iatsDeXIN2NONS/GWpWhYpb8/vO4LJNE
	 yIueovLHVSIwy4ivGMCC3ht3wS78dziZVyRydArUlDrofGow/p3ZixLRPxO1dqCKuQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=OAM1BnXjz5B7co63t75PaiG5nkuDkTIhehOzyR5IT64=;
	b=iBHzQ3m8sYejEaUKrMtwKURZhfkD8Vzug7vmBBtqtYJfOCapFN+PzsfGNswmlZEb3tAm
	 IKOggSdIx82D1mlCpOuFkprLZ3E+ti8IMYuGCex/lTllKFs7ntUKwEyt9c9RgcBEljITf
	 zpugEqAwbVv0bWh7EAvv9U3Xvxf66mLiSaY99R7ddwpSzDI/guRCR3nHjZi/NLSzK5ERg
	 mPIiLeYL3lfZpyw8ojySd/+xyhT14i59ZU+c5oF57/vseoXdMhOiMVN7tir5SJLE7YTmU
	 QsAY7amgfPbJU64EnS3SkVw8FounWOD5UWaFWMiXyGglxdJD/ULMrarogzm2OOFYWoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DpLQ/mkp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FC606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E10FC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DpLQ/mkp
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3ac4f373d3bso31471821fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793115461; cv=none;
        d=google.com; s=arc-20260327;
        b=JfnYq8DWI/cv8DWYH9ZYdv1bGsN9QYr6ldXeb7UT1FkbCJoo46naFU7zC2m1/OF8Qu
         fNMz39/0iwoUMKTJEgKtTrB1lffxXhzWKFHARiCpuqTCuKimJS+xlF+R9X9G0D9dYTmV
         Zjuby7CifoF5nyFiB1gptd5ix2rdRTUvcgAOn9q/5qM5bEM/NBpejw+hUPLN1RmgLzUD
         laNziXGu5DaTlx2sjRaIYdVqnf7nt5ag+axnsxgaWtPzvMkGGJ6EcF4wQMjyBB/P3FwK
         0lPq9HVN0xc1pn00fIbQOoCymifS3OaqhjESUb0vumj8rayFjeCdvxDaP5ymvflJzo9p
         7qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OAM1BnXjz5B7co63t75PaiG5nkuDkTIhehOzyR5IT64=;
        fh=8/2RkjjkzAcZa0oaZuhWZ3dGEpgW/CEywtnBjYIi4uo=;
        b=Cd0ZBC0uUyI816Tiaqg+RCQLDL/DJHUkhLXDxqWGS5JilSTOHZw7LUSJoOVuBXZ+eM
         naU+swyEEjuHL827I/m0IVvIHpGCtms9f0iojfCmsy7R1tW4ytlXt2yd7hlKbZAHouYC
         5/DBzaA20Wl6UyTQJb6YMlpCMdZJNqH2OS/eaNwb2Y4I0AUNkxk68WdKUFK3Tr8vuVRW
         NBsh+/TAciyBig93g0oYSXy/u75t+Uh+Bu/+IwUkxPMQzjlskEThTMkt2ec9Ql9srEdE
         UUpA1LL/rb1PX0K1H7BFW2FonH6qkw8RJLhqkDD5YzfZO1/dbkdG12E687nzyeddb5XX
         vZdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793115461; x=1793720261; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAM1BnXjz5B7co63t75PaiG5nkuDkTIhehOzyR5IT64=;
        b=DpLQ/mkpJ4rJWOBtyRY05rVfzGeLcMLW2eUYsuynBcgA4Gxk70/fuBxiOkj6Ice0em
         YzlresyV/sZuDJLt51esF8fFAL6gi5ni63O/kVNcRbLiIwuccBHy33nD7qahd5vqXO6Q
         Y98LNO1/7KRb+jyIEQzaSmVcq0Xg/EUWkwqWLTZqx763D0TUI8ablbly9lhnEpbHRzBR
         7tVGrJTBFbsl82ArI/CL2vfzK1UIPefZGuZJIVwLuZbx76qlwapJGqmTjnUlSDZTnX9R
         LrJinth0FIsJFK1zcq1+HmKxnHa1kf6wc+J0kFJa0swC8Rv2WAw6bkYumWkY6EI6/tad
         62lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115461; x=1793720261;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OAM1BnXjz5B7co63t75PaiG5nkuDkTIhehOzyR5IT64=;
        b=c+aQv0gX0pG30IoNlaiim8Tn8t2frtV98W1zZNZxvdth4kvrxq+UBqFbS0qf8FMYOH
         K4ZVeq+1oQgrYnmdpMlEyB3Q+PypXOYxFzek/IPup/Q9VZ6uFRXgehSth400mGPxbNpp
         ENnJS1zCwiYBO5QCuLy7d85Yu3Lk4mjII3qh8EEiILrq1xNtP+LzvKBNEt9LaQnBKBK5
         OouSXz9zk/3c6qrk9svIC58FncofSd+PqxdA9Vy9EqiCJ00cj1iByor7c15REFzSn06N
         c6vCGR0lCz1+TrX4FDYwlQkpIIsl3FfKfWx+rLcetLsHWounenaI0UN+GgP6FMYedWju
         ECVg==
X-Forwarded-Encrypted: i=1; AKwUvBzlZfh7ZyRKKPmsLbH64SZOmcu2vzz4Z6EFM9Pjcy97hwD13y7qL5AIQ1nSQdhk4keCRDuJ+AcQzyLE0+RY@vger.kernel.org
X-Gm-Message-State: AFq9FYIdkod8CVS3wECRU5bnfYLQo3ZEv/7lJg8FFLs9BldIFLfNBIul
	VefCZliceV7mnf3JxRTN55pncRiUT4Y7buiJwalMXDxAuym9TCPC5TU+OFPET3+r/TjpeTmxrjv
	233SjBKBXK0s+BHyDdS/8JZFHK2QOJlRX3XFzIKOUelUZhdza8A==
X-Gm-Gg: AYBFou1urSvEwcU9rMbVqhkpfcGnY+M1aWMeknC9oU+Z/RcoKnrAg6gauvWmVydOWj+
	hbtVrYnePdFQ+sh1oxfghpRqQ8oceFNq2gwmgyqbTjKZ5ieKFtlyy8DzLQRYF8eFMekUN4f70HA
	0PaqcnKCJ7pONNNM6HXAAK01FgJa/OMiSSB810SxJ75yLEh0/XhQFJcZyiFw9Ugti6kzZBXdQyo
	bwberp7/VBJHOyiTeVJu2Ji7VBoIUy6mYt+/Uj1pRC++W8nMCNhsxUoLFWtTFw906deEYEyLU6t
	dchLY4m1LDB1Le/X7ZWBrQM9J5WskRRlXVnkevZAU9N9yai6PuiQTf9nxa/jcJ+TxsKPLuyLjom
	EQHVJp6m60WpREYKw015WLuzMhRjPQ3e+hBw=
X-Received: by 2002:a05:6512:31cf:b0:5bf:a6e9:4cc with SMTP id
 2adb3069b0e04-5bfb716e441mr3339718e87.1.1793115460664; Tue, 27 Oct 2026
 08:37:40 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Tue, 27 Oct 2026 23:37:28 +0800
X-Gm-Features: AclHuK__CKSeP7Mc8wC2_HztAGdz37Y4Di0KOmsvhiBwOPC8BtfqvM0Lsguqa6Y
Message-ID: <CAO-4RZ2ndsdZPmacvCwdVS+cYGSvMv8x6wK8kb5jPqyoUjhy-A@mail.gmail.com>
Subject: [BUG] gfs2: umount holds s_umount in gfs2_wait_glocks(), sync() hangs
 in __iterate_supers
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

I observed an "INFO: task hung in __iterate_supers" while fuzzing with
syzkaller. The report was first produced on Linux 7.1.3, reproduced on
7.2.11 (state-primed replay) and on 7.3.0 (the 159-program
state-construction sequence followed by
repro.prog). All
three kernels used the same KASAN/KCOV/fault-injection configuration; no GFS2
source changes.

The hang is a lock-wait chain. A task in sync()/ksys_sync() iterates
superblocks and blocks on the s_umount read lock in __iterate_supers() ->
super_lock(). The same s_umount is held exclusively by a task in
deactivate_super() running the GFS2 unmount path, which waits in
gfs2_wait_glocks() for sd_glock_disposal to reach zero. GFS2 logs
"1 glocks left after 61/122 seconds; still waiting", the glock does not go
away, and the hung-task watchdog panics at 143 s.

On 7.3.0 the sequence also causes a GFS2 withdraw after an invalid metadata
block in a deliberately corrupted image; a failslab failure in
gfs2_glock_get() from gfs2_create_inode() immediately precedes the withdraw.
I have not established whether the withdraw is required for the hang, or
whether the failed inode-creation/unmount path is the important part.

Environment
-----------
- Kernel A (original report): 7.1.3-kernsight-kasan #13 SMP PREEMPT_DYNAMIC
  (2026-10-13), x86_64, KASAN/KCOV. Source: Linux v7.1.3, commit
  113be0295f4f632d61f4e9c93322f70e2365f54d; tag
  linux-7.1.3-kernsight-kasan-v1. The saved tree is not a git checkout.
- Kernel B (reproduced 2026-10-20): 7.2.11-kernsight-kasan #1 SMP
  PREEMPT_DYNAMIC, x86_64. Source: Linux v7.2.11, commit
  8316c24ec1b77dba19ba072ca4fe251b36dc65d3, release tarball sha256
  fd0fc479f983a8c05313f13e9c36330fe6651cf725396748c40d5cd93fa1e6a4.
- Kernel C (reproduced 2026-10-27): 7.3.0-kernsight-kasan #1 SMP
  PREEMPT_DYNAMIC (2026-10-20), x86_64. Source: mainline Linux v7.3, commit
  091b06388b117fefdcb63336ac09956a4914b961, release tarball sha256
  87363c24f10e06321eb362765521094e94471f6bff8bce2d6b3e40f39f004953.
- Kernel configs (repository): kernel/kernel-7.1.3.config,
  kernel/kernel-7.2.11.config, kernel/kernel-7.3.config; source tags/commits
  and tarball checksums in kernel/SOURCES.md. For 7.2.11 and 7.3.0 only the
  kernel configuration was adapted (KASAN/KCOV and the KernSight collection
  config); no kernel source changes were made. For 7.1.3 no source diff is
  included.
- Guest: QEMU 6.2.0, 4 vCPU, 6 GiB, KVM, x86_64. A fresh VM per run.
- Syzkaller: revision 853b104bb454141a5b0fc0e4218ec78e9f34ffb1+ (2026-09-18).
  The "+" denotes local KernSight integration changes (seed ordering/state
  feedback: pkg/kernsight, prog/kernsight_*, syz-manager/kernsight_*,
  pkg/execbackend, snapshot support in vm/qemu). They do not change the gfs2
  syscall descriptions or the executor's fault-injection semantics.
- Kernel command line (same for the three kernels; see the repository):
  root=/dev/sda console=ttyS0 fstab=no rw earlyprintk=serial
net.ifnames=0 oops=panic panic_on_warn=1 panic=86400 hung_task_panic=1
softlockup_panic=1 nmi_watchdog=panic
sysctl.kernel.hung_task_all_cpu_backtrace=1
sysctl.kernel.panic_on_rcu_stall=1
sysctl.kernel.max_rcu_stall_to_panic=1 rcupdate.rcu_expedited=1
rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on
sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4
secretmem.enable=1 msr.allow_writes=off coredump_filter=0xffff
vsyscall=native kvm-intel.nested=1 spec_store_bypass_disable=prctl
nopcid vivid.n_devs=64
vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
netrom.nr_ndevs=32 rose.rose_ndevs=32 smp.csd_lock_timeout=100000
watchdog_thresh=55 workqueue.watchdog_thresh=140
sysctl.net.core.netdev_unregister_timeout_secs=140 dummy_hcd.num=16
max_loop=32 nbd.nbds_max=32 comedi.comedi_num_legacy_minors=4
kunit.autorun=0 vcan.echo=1
- Reproduction rates: 7.1.3: original report. 7.2.11: state-primed replay
  triggered the same report title and s_umount lock-wait pattern; the C
  conversion failed (C=false). 7.3.0: triggered with the 159-program
  state-construction sequence followed by repro.prog. I have not isolated the
  required subset or characterized stability with standalone control runs.

Reproduction on 7.3.0
---------------------
Fresh KVM guest; two steps in the same VM; do not reboot in between and keep
the VM running afterwards (the hung-task panic can appear after both commands
have returned, and the execprog may already have exited):

  scp syz-execprog syz-executor repro.kernsight.prog repro.prog root@guest:/tmp/
  ssh root@guest
  cd /tmp && chmod +x syz-execprog syz-executor
  # step 1: state construction (159 programs)
  ./syz-execprog -procs=1 -repeat=1 -disable=swap -executor
./syz-executor ./repro.kernsight.prog
  # step 2: crashing testcase, immediately afterwards
  ./syz-execprog -procs=1 -repeat=1 -disable=swap -executor
./syz-executor ./repro.prog

Execution settings: sandbox=none, threaded executor, procs=1, repeat=1, no
additional syzkaller features. repro.kernsight.prog is the state-construction
recipe (159 programs, ~14 MB including embedded filesystem images) replayed
one at a time in file order; repro.prog is the crashing testcase run on that
state. repro.prog alone does not reproduce reliably. The 7.2.11 run used the
same 159-program sequence followed by repro.prog.

The sequence contains fault-injection annotations. In the 7.3.0 run a
failslab failure is injected in gfs2_glock_get() from gfs2_create_inode();
the failing allocation and the subsequent withdraw are shown below. No
additional fail_nth/debugfs fault-injection configuration was required.

Observed on 7.3.0
-----------------
The gfs2 image is mounted read-write from a corrupt image. During an
openat()/create, gfs2 reports a duplicate quota-change identifier, then the
failslab failure, then an invalid metadata block and a withdraw:

  [ 293.521836][T13753] gfs2: fsid=syz:syz.0: Corruption found in
quota_change0file: duplicate identifier in slot 8637
  [ 293.574756][T13753] FAULT_INJECTION: forcing a failure.
  [ 293.574756][T13753] name failslab, interval 1, probability 0,
space 0, times 0
  [ 293.575588][T13753]  gfs2_glock_get+0xcfd/0x1240
  [ 293.575947][T13753]  gfs2_create_inode+0x1941/0x36b0
  [ 293.576701][T13753]  gfs2_atomic_open+0xbe/0x220
  ...
  [ 293.585337][T13753] gfs2: fsid=syz:syz.0: fatal: invalid metadata
block - bh = 2342 (bad magic number), function = gfs2_meta_buffer,
file = fs/gfs2/meta_io.c, line = 460
  [ 293.585388][T13753]  gfs2_withdraw+0xcb/0x1d0
  [ 293.585430][T13753]  gfs2_meta_buffer+0x384/0x3d0
  [ 293.585470][T13753]  gfs2_dirty_inode+0x5fa/0x800
  [ 293.585555][T13753]  __mark_inode_dirty+0x203/0x1690
  [ 293.585574][T13753]  gfs2_create_inode+0x27f9/0x36b0
  [ 293.586311][T13753] gfs2: fsid=syz:syz.0: about to withdraw this file system
  [ 298.641734][T10021] gfs2: fsid=syz:syz.0: file system withdrawn

About 63 seconds after the withdraw completed, the unmount task reports a
leftover quota data object:

  [ 361.670586][T12077] gfs2: fsid=syz:syz.0: 1 left-over quota data objects
  [ 423.109212][T12077] gfs2: fsid=syz:syz.0: 1 glocks left after 61
seconds; still waiting
  [ 484.549370][T12077] gfs2: fsid=syz:syz.0: 1 glocks left after 122
seconds; still waiting

khungtaskd then reports the sync() task and the lock handoff:

  [ 489.029328][   T43] INFO: task syz.6.106:15555 blocked for more
than 143 seconds.
  [ 489.029369][   T43]       Tainted: G             L
7.3.0-kernsight-kasan #1
  [ 489.029447][   T43] Call Trace:
  [ 489.029671][   T43]  schedule+0xec/0x2d0
  [ 489.029688][   T43]  schedule_preempt_disabled+0x18/0x30
  [ 489.029704][   T43]  rwsem_down_read_slowpath+0x597/0xc10
  [ 489.029790][   T43]  down_read+0xf4/0x4d0
  [ 489.029825][   T43]  super_lock+0x31b/0x3e0
  [ 489.029954][   T43]  __iterate_supers+0x377/0x460
  [ 489.030047][   T43]  ksys_sync+0x8c/0xf0
  [ 489.030118][   T43]  __do_sys_sync+0x13/0x20
  [ 489.030148][   T43]  do_syscall_64+0x12e/0x7a0
  [ 489.030257][   T43] Showing all locks held in the system:
  [ 489.030773][   T43] locks held by syz-executor/12077: 1, on CPU#2:
  [ 489.030782][   T43]  #0: ff11000111fe60e8
(&type->s_umount_key#70){++++}-{4:4}, at: deactivate_super+0xb1/0xd0
  [ 489.030886][   T43] locks held by syz.6.106/15555: 1, on CPU#3:
  [ 489.030894][   T43]  #0: ff11000111fe60e8
(&type->s_umount_key#70){++++}-{4:4}, at: super_lock+0x31b/0x3e0
  [ 489.033265][   T43] Kernel panic - not syncing: hung_task: blocked tasks

So the task holding s_umount at deactivate_super() is the same task
(T12077, syz-executor) that is waiting for the last glock in
gfs2_wait_glocks(). The sync() task remains blocked on s_umount, and
khungtaskd triggers a kernel panic because hung_task_panic=1.

7.1.3 and 7.2.11
----------------
On 7.1.3 the original report has the same lock handoff: the sync() task is in
__iterate_supers() -> super_lock(), and syz-executor/9333 holds s_umount at
deactivate_super(). Before that, gfs2 had logged:

  [ 1459.515662][ T9333] gfs2: fsid=syz:syz.0: 2 glocks left after 491
seconds; still waiting

In that log, several gfs2 mounts with the same fsid had failed earlier with
"sysfs: cannot create duplicate filename '/fs/gfs2/syz:syz'" and "error -17
adding sysfs files"; I do not know whether that is related.

On 7.2.11, state-primed replay successfully triggered
"INFO: task hung in __iterate_supers", with the same s_umount
lock-wait pattern. Standalone C reproducer conversion failed
(C=false).

The captured logs do not identify the filesystem holding the lock.
An identical GFS2 root cause across versions has not yet been
confirmed.

Analysis and questions
----------------------
__iterate_supers() (reachable from sync()) takes s_umount for each
superblock. deactivate_super() holds s_umount exclusively while
gfs2_kill_sb()/gfs2_put_super() runs, and gfs2_put_super() ends in
gfs2_wait_glocks(), which waits for sd_glock_disposal to reach zero and logs
"N glocks left ...; still waiting". If a glock reference survives the
withdraw/failed-create path, the unmount keeps s_umount while it waits, and
an unrelated sync() task trips the 143-second hung-task panic first.

The "1 left-over quota data objects" message suggests that quota references
from the same failed/withdrawn path also survive, so this may not be limited
to glocks.

I would appreciate help with the following:

1. Is a leftover glock (and quota object) expected after a withdraw or after
   a failed inode creation, or does this point to a glock/reference leak in
   the error path? In the 7.3.0 run the failing allocation is
   gfs2_glock_get() from gfs2_create_inode(), followed by a
   mark_inode_dirty() -> gfs2_dirty_inode() call and then the withdraw.

2. Is it intended that gfs2_wait_glocks() waits while holding s_umount
   exclusively? If the wait can legitimately exceed the hung-task timeout,
   should the wait be moved out of the s_umount critical section, or should
   the remaining glock be dumped earlier so the waiter can be identified?

3. Can you suggest a diagnostic patch that dumps the remaining glock when the
   60-second wait expires? I can run it on the reproducer; the panic happens
   at 143 seconds, so a dump at 61 seconds would still be captured.

4. Is the 7.1.3 duplicate-fsid mount failure a separate issue, or could it
   leave the same kind of lingering references?

I am happy to provide additional information and test proposed patches.

Materials
---------
The full programs, logs and reports are at:
  https://github.com/Zheng-zheng-codes/gfs2-iterate-supers-hang-repro

Contents:
  repro/repro.prog                  original syzkaller testcase (not
sufficient alone)
  repro/repro.kernsight.prog        159-program state-construction
sequence (7.2.11/7.3.0; ~14 MB)
  7.1.3/report0, 7.1.3/log0         original 7.1.3 hung-task report and full log
  7.1.3/machineInfo0, 7.1.3/description, 7.1.3/pre_state0
  7.2.11/repro.report, 7.2.11/repro.log   7.2.11 state-primed
reproduction (C=false)
  7.2.11/console-7.2.11.log                7.2.11 full batch/console log
  7.2.11/repro.kernsight.prog, 7.2.11/RESULT.md
  7.3/serial-7.3.log                full 7.3.0 console (contains the
report above)
  7.3/console-7.3.log, 7.3/cmdline-7.3.txt, 7.3/boot-info-7.3.txt
  7.3/RESULT-7.3.txt
  kernel/kernel-7.1.3.config, kernel/kernel-7.2.11.config,
kernel/kernel-7.3.config
  kernel/SOURCES.md
  reproduce.sh                      runs repro.kernsight.prog first,
then repro.prog
  README.md, verify.sh, MANIFEST.sha256

The kernel configs correspond to the three -kernsight-kasan builds used above
(KASAN/KCOV; gfs2 built in).

Best regards,
Zheng Zheng
