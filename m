Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1D39F190
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101921; cv=none; b=kcaGyKqdayAW102qkeXSJzAHtSzPxRpOu5+xbYclVBhAEseqbdU6WxPwXtCcRhhPttvUOwDFoHlO+sUa1VPUxfEHdOFsIKGZax/ug37VUH4Qj0tik2sVzEElMj+F4Bjhdp8npDW41wq+MaWH2qYJzhSN+KD66QeTJlhHVhCoSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101921; c=relaxed/simple;
	bh=nPaWLgyxMG7XSZ+BOOHlBYYOuctcqNir3sdBkm/jYCY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L+zIDRgBML48SIuGcCplhOg9sNl6Q1s/JwiJLfNvEpdO7+VGVPKZG40xOkfP0IVgnfuseJ3+/0eXGPzsJIfBi9+YpvG2DcH7V9I/Ex1WXZ33TEwIhYYCzuzfkI7L/2b6uTQs9ZhuXQO4Jf42p25tccZiISV4kA2L5oqftBYSeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so1625249fac.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 07:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101918; x=1788706718;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qxvwk/TwqCvron/Z2JUCofoPA/9R3UNI5aVovBkbXPY=;
        b=BwxUbvIeYXjfrYztI72smYJ8BlWkvORl4yWCItDohbT4ftYh1NCq+91VvJvh/mZf+U
         UP5VqzeqpIjI/q6Ir/rswrL98UQO/IAAmlZqQ6km0/the9cKiHUomKDSH6S+d44pC0V5
         zD0gSLQZeX/HS4VgyLBb3f1Ud3JS0VGI970SDXyW/tQ6AWhttxAM375y7cAaIrQl3TcI
         9K2THZ3wwSjSGwi8KrLHLxuV4hW9lZfNaowUrJ6Nk9gPS1i7PjV5j5dV9nxTht74VrTo
         ebrBaOwObQ8E/iMeOoMcPu/GNCzaPecIEjUdpq4jWTfSrU9q0jJKk+v6kNdq7bYO36oH
         0e4A==
X-Forwarded-Encrypted: i=1; AHgh+RpkitsCqCwWu83VDJUEc0MCpS0MqpgpODDGwAEBZl7gAbLKHZ2xcelviNi3WgR3/Ebq09tGCQgG2megpvpK@vger.kernel.org
X-Gm-Message-State: AFuF++lG7HCxMW0ogtm6ohnxkeYng6w/D6lXt3+pn5GLPfZFsZTJCuGl
	9irofjnEc/kAwAxWpP8jqcxo44pVCca1wqDaPuhYsg75Frr+qiRkiiBm4XXsEIMoyxK8COPj3Qu
	3C71KgnxMeUkXmPaFK9ckQiUH7h0H8+4CSe09hkWHjB86NXbgbp/daca4k9U=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3ee:b0:4b2:6ca6:9cd8 with SMTP id
 5614622812f47-4b397f53781mr22411140b6e.1.1788101918596; Sun, 30 Aug 2026
 07:58:38 -0700 (PDT)
Date: Sun, 30 Aug 2026 07:58:38 -0700
In-Reply-To: <6a926514.1d9ded08.62e62.00ff.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a94451e.1d9ded08.62e62.011d.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in __balance_push_cpu_stop
From: syzbot <syzbot+acf142088e0182172e58@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    08dbfad3f504 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154fb379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=acf142088e0182172e58
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c19379580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134fb379580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aa9167f616f/disk-08dbfad3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec932d59de3/vmlinux-08dbfad3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86e2243e886e/bzImage-08dbfad3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
migration/1/27 is trying to acquire lock:
ffff8880b8740998 (_T->lock){....}-{2:2}, at: rt_mutex_slowtrylock kernel/locking/rtmutex.c:1404 [inline]
ffff8880b8740998 (_T->lock){....}-{2:2}, at: __rt_spin_trylock kernel/locking/spinlock_rt.c:123 [inline]
ffff8880b8740998 (_T->lock){....}-{2:2}, at: rt_spin_trylock+0x56/0x2b0 kernel/locking/spinlock_rt.c:135

but task is already holding lock:
ffff88803cefe8c0 (&p->pi_lock){-...}-{2:2}, at: class_raw_spinlock_irq_constructor include/linux/spinlock.h:575 [inline]
ffff88803cefe8c0 (&p->pi_lock){-...}-{2:2}, at: __balance_push_cpu_stop+0x78/0x410 kernel/sched/core.c:8446

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&p->pi_lock){-...}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
       rtlock_slowlock_locked+0x1ec/0x3c20 kernel/locking/rtmutex.c:1874
       rtlock_slowlock kernel/locking/rtmutex.c:1922 [inline]
       rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
       __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
       rt_spin_lock+0x165/0x400 kernel/locking/spinlock_rt.c:57
       spin_lock include/linux/spinlock_rt.h:45 [inline]
       finish_wait+0xbe/0x1e0 kernel/sched/wait.c:395
       synchronize_rcu_expedited+0x63e/0x770 kernel/rcu/tree_exp.h:981
       srcu_readers_active_idx_check kernel/rcu/srcutree.c:538 [inline]
       try_check_zero+0x2c8/0x4c0 kernel/rcu/srcutree.c:1135
       srcu_advance_state kernel/rcu/srcutree.c:1827 [inline]
       process_srcu+0x148/0x16f0 kernel/rcu/srcutree.c:1954
       process_one_work kernel/workqueue.c:3387 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
       kthread+0x38b/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (_T->lock){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e40 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
       _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:181
       rt_mutex_slowtrylock kernel/locking/rtmutex.c:1404 [inline]
       __rt_spin_trylock kernel/locking/spinlock_rt.c:123 [inline]
       rt_spin_trylock+0x56/0x2b0 kernel/locking/spinlock_rt.c:135
       __kfree_rcu_sheaf+0xd3/0x620 mm/slub.c:6113
       kfree_rcu_sheaf mm/slab_common.c:1688 [inline]
       kvfree_call_rcu+0xa4/0x430 mm/slab_common.c:2037
       set_cpus_allowed_force+0x1bd/0x2a0 kernel/sched/core.c:2833
       cpuset_cpus_allowed_fallback+0x24a/0x370 kernel/cgroup/cpuset.c:4258
       select_fallback_rq+0x11e/0x200 kernel/sched/core.c:3589
       __balance_push_cpu_stop+0xa1/0x410 kernel/sched/core.c:8453
       cpu_stopper_thread+0x25e/0x3f0 kernel/stop_machine.c:510
       smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
       kthread+0x38b/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->pi_lock);
                               lock(_T->lock);
                               lock(&p->pi_lock);
  lock(_T->lock);

 *** DEADLOCK ***

locks held by migration/1/27: 2, last CPU#1:
 #0: ffff88803cefe8c0 (&p->pi_lock){-...}-{2:2}, at: class_raw_spinlock_irq_constructor include/linux/spinlock.h:575 [inline]
 #0: ffff88803cefe8c0 (&p->pi_lock){-...}-{2:2}, at: __balance_push_cpu_stop+0x78/0x410 kernel/sched/core.c:8446
 #1: ffffffff8e1c3ac0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8e1c3ac0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e1c3ac0 (rcu_read_lock){....}-{1:3}, at: cpuset_cpus_allowed_fallback+0x22/0x370 kernel/cgroup/cpuset.c:4255

stack backtrace:
CPU: 1 UID: 0 PID: 27 Comm: migration/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Stopper: __balance_push_cpu_stop+0x0/0x410 kernel/sched/sched.h:3965 <- balance_push+0x28d/0x4f0
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x15ff/0x2e40 kernel/locking/lockdep.c:5254
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:181
 rt_mutex_slowtrylock kernel/locking/rtmutex.c:1404 [inline]
 __rt_spin_trylock kernel/locking/spinlock_rt.c:123 [inline]
 rt_spin_trylock+0x56/0x2b0 kernel/locking/spinlock_rt.c:135
 __kfree_rcu_sheaf+0xd3/0x620 mm/slub.c:6113
 kfree_rcu_sheaf mm/slab_common.c:1688 [inline]
 kvfree_call_rcu+0xa4/0x430 mm/slab_common.c:2037
 set_cpus_allowed_force+0x1bd/0x2a0 kernel/sched/core.c:2833
 cpuset_cpus_allowed_fallback+0x24a/0x370 kernel/cgroup/cpuset.c:4258
 select_fallback_rq+0x11e/0x200 kernel/sched/core.c:3589
 __balance_push_cpu_stop+0xa1/0x410 kernel/sched/core.c:8453
 cpu_stopper_thread+0x25e/0x3f0 kernel/stop_machine.c:510
 smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
process 5610 (syz-executor350) no longer affine to cpu1


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
