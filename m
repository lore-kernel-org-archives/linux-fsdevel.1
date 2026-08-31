Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763593A7852
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211992; cv=none; b=BJGb8qbM6fyRfZPlJHntWps+/dg8zvsPxBjhXBT2vZFaAo4gIVNCpfNorC7GyYTUVC0CQzpMNu5n24XV9AsLnswWjxPxZMqMQPhMJID9wNcpv79r1BTNlyXY6L0iUedXHkK06vGORqxhZR8jXOq6hTPEt9xaIpMPihyYdUeNccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211992; c=relaxed/simple;
	bh=YdL0s1ebj/Wq/kTp7Cmn4F420jUDw9S1aOdG3BkWBys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nhKO+mxmFgwRGfJfwa69QjkJfX175o07sEwlLRntTfeqmhdyzGpubwM4xq5nwuOPlwud7OqaRSuGzOWo/r1d4KadR262QgFhUXo2+bvEybHgSoPCpM50de50tg18caxE1x53G4Hb487zGqFgsSLNPlBtkYPUFo7w04LZTciYC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiHWHt9X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiHWHt9X"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so130098b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211990; x=1788816790; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWPvAnFlFBZe94+YEZeQLMoXJG2Yt4uB4t9syIQupx8=;
        b=iiHWHt9XDAlTEb/P37bEfoua9G3quokX01tZtZ/9m5bkyAPuZAm3V6SZXV9K/HGKQF
         J9knff29h9cBOJWFaRFsl6BJYYfSEHjmqHJh7lX8aMX0Josmk2LvIfA7xcIF+BRvgJpC
         05e1NEuV9L1HbxdE/wK9XjtGktJ8S7YuH1+ETwDPyZHORRGkO9zBf8x+Mm1AZCeVAhdB
         qaHr5Sc9l9DbXqAO3HSU8Qg4ffml++teyGLOYtGrsI1lrSnyDdsf+HKRdoEcOW14WCBn
         Bv37SySbodrSAf74AGVl2xxys9IJ7V7ux1atNA527TJRd0cmLTVT5IYB2v2k1CpehvoV
         QMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211990; x=1788816790;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mWPvAnFlFBZe94+YEZeQLMoXJG2Yt4uB4t9syIQupx8=;
        b=IDfeV55XZhoXL8iSrZnktnB7+gxgpmCP1aeChLzXgBf7Ra0HnCXlaNn/2wiV5NW81+
         4Ir0uagL0wEwPofK3Yn4Nqu+Gr5cRAaCwDIhj96QPiqu4ZV+jtrPxOBq39H2P4Zhxx4k
         1BfEB58KDZn/Cq8NGBrtU2SLn7MAWURlMpyUkMa2oEyb9muQ/+X/ae15gp+Rm+d/ss18
         hxBSieZt8xhXmQzQ5NmbWJ5rcsObG0sTX3SnA0yCmYuxYMvC6fhad9sn2lWvyD3zLvew
         OrFVIIo0DbxGl6wk/+ZhFZk3vQCLIYc1dP1b+7IvmJNcW6IGzOyOb1Df6fhFRht8Leac
         AZ5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJ8Pj6lH9VeKAgnsZCk8tPdtlgfEawyHr3/jEEE4gxhnAFLVIxKWJfhBkILkhlGWmwn7pxyHP/k4L8UWYY@vger.kernel.org
X-Gm-Message-State: AFuF++nboTYqlWFL8myizJozl22vog8BIL6+vp+tynXAQ0wHHH8MKf0H
	KhMEu/9tAJWGsTJ6tnGjvf2S6/WHPrVhlpb4Nn8e/pgqI/r/QY72zi9p
X-Gm-Gg: AR+sD13UT3B6P0resTG3gDM2RM7sfw7KaZ2CSktJp9UObjVEpkISK6fpMIV2Nofniqb
	wA/iLwQ4HIsVa/GqSD+SA0inLNv5XKZ5j0NtNDDVnVhbxvyz0OnQmQVt77rL+eQRI4e7+BkUE6v
	1xr46DgbgZxI48PIl9/1Ym43hjOLDO6Er4pEoJ1D2qb2wUI6y64nZKr6t02PB43ey9DMw38gsyU
	cpQ6+QaSolmdl8jJNrKO1rCd6qhqorEXj3Fdr/pFBT7WEfwU7/Cty5SjmgfbEiRGwXH0EeWXDgm
	lMmcGw4DzKLOj8v9T8dmtpCaK8bkL6wpWejWplhfyeH/14M8/v8pptLw4deUQWNew1Xepy8l5e+
	x+tu2D4Ev7/A5RfS5O5iT3Eu3i2q1jbx5tZnt1cL4Pl0a5jQeD7zOhTY5kPH16ImvRsfG8ZAmP3
	FHU+YGCfJCAWURzA/K1pkBVdTdMfPdWGIA4x3E0Dmz/T8JQFYRFxv1ByMAhIgV6RIj0M9QqSJeF
	UhFjtU=
X-Received: by 2002:a05:6a00:194a:b0:847:9267:2104 with SMTP id d2e1a72fcca58-85629a24448mr43230958b3a.12.1788211989656;
        Mon, 31 Aug 2026 14:33:09 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be5ca747csm77296b3a.5.2026.08.31.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:33:09 -0700 (PDT)
Date: Tue, 1 Sep 2026 06:33:02 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] sched/cache: Fix use-after-free of the mm replaced by exec
Message-ID: <apXzDjnvOm9GfTLK@v4bel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When the waker cannot use the wakelist, ttwu_queue() takes the target rq
lock and goes down into update_curr(). If the target rq belongs to another
CPU, the task handed to account_mm_sched() is the one running on that CPU,
not the task being woken.

account_mm_sched() reads p->mm and updates mm->sc_stat. Nothing keeps that
mm alive. The rq lock and rq->cpu_epoch_lock it holds have nothing to do
with the lifetime of the mm.

If that task happens to be in execve(), exec_mmap() points tsk->mm and
tsk->active_mm at the new mm, and exec_mm_put_old() from setup_new_exec()
drops the old one. free_bprm() does the same when exec fails. On the way
from mmput() down to __mmdrop(), mm_destroy_sched() calls free_percpu() on
sc_stat.pcpu_sched and free_mm() returns the mm_struct.

Whoever already read the old pointer keeps using it. It adds to runtime in
the freed per-cpu area and reads sc_stat in the freed mm_struct. Depending
on the condition it also writes sc_stat.cpu. That is a use-after-free.

Commit 9f23469401b0 ("sched/cache: Fix potential NULL mm pointer access")
changed the remaining p->mm dereference to the local variable, and said the
active_mm reference keeps the structure allocated. That holds for the other
paths that detach an mm, since they take an mmgrab_lazy_tlb() reference.
exec reassigns active_mm to the new mm as well, so that reference is gone.
What is left is the mm_users reference in bprm->old_mm, and dropping it is
the free.

             CPU0                                CPU1

                                    write(pipe)
                                      try_to_wake_up()
                                        ttwu_queue()      // takes rq0 lock
                                          enqueue_task_fair()
                                            update_curr()
                                              update_se()
                                                account_mm_sched()
                                                  mm = rq0->curr->mm
                                                        // old mm
  execve()
    exec_mmap()                       // tsk->mm = new mm
    setup_new_exec()
      exec_mm_put_old()
        mmput() -> ... -> __mmdrop()
          mm_destroy_sched()          // free_percpu()
          free_mm()
                                                  read mm->sc_stat.epoch
                                                        // use-after-free

KASAN log:

  BUG: KASAN: slab-use-after-free in update_se+0xe6e/0xf70
  Read of size 8 at addr ffff8880093cad10 by task sc-direct-set/80
  ...
  Call Trace:
   update_se+0xe6e/0xf70
   update_curr.isra.0+0x28/0x380
   enqueue_task_fair+0xb58/0x3560
   enqueue_task+0x70/0x170
   ttwu_do_activate+0xeb/0x590
   try_to_wake_up+0x79b/0x14f0
   autoremove_wake_function+0x16/0x150
   __wake_up_common+0xed/0x160
   __wake_up_sync_key+0x36/0x50
   anon_pipe_write+0xa62/0x1830
   vfs_write+0xa4f/0xcf0
   ksys_write+0x17c/0x1c0
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  ...
  Freed by task 1:
   kmem_cache_free+0xba/0x3b0
   setup_new_exec+0x2c4/0x3d0
   load_elf_binary+0x435/0x4740
   bprm_execve+0x6d2/0x1290
   do_execveat_common.isra.0+0x3a3/0x580
   __x64_sys_execve+0x8e/0xc0
  ...
  The buggy address belongs to the object at ffff8880093cab80
   which belongs to the cache mm_struct of size 1688
  The buggy address is located 400 bytes inside of
   freed 1688-byte region [ffff8880093cab80, ffff8880093cb218)

Wait for an RCU grace period before the old mm is dropped.
account_mm_sched() runs with the rq lock held, so preemption is disabled
there and that section is an RCU read-side critical section. A reader that
already holds the old pointer finishes before the grace period ends, and
the store to tsk->mm precedes the wait, so a reader that starts afterwards
observes the new mm.

Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Drop an unrelated hunk that slipped into v1.
- Use synchronize_rcu() instead of cycling the rq lock, which covers
  every reader that runs with preemption disabled.
- v1: https://lore.kernel.org/all/apPb-Dr4nPYuHQOK@v4bel/
---
 fs/exec.c             |  1 +
 include/linux/sched.h |  4 ++++
 kernel/sched/fair.c   | 12 ++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e65..6194c388079805 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -916,6 +916,7 @@ static void exec_mm_put_old(struct mm_struct *old_mm)
 {
 	setmax_mm_hiwater_rss(&current->signal->maxrss, old_mm);
 	mm_update_next_owner(old_mm);
+	sched_cache_exec_done();
 	mmput(old_mm);
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cca9..6ae31bffe049e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2415,10 +2415,14 @@ struct sched_cache_stat {
 	int cpu;
 } ____cacheline_aligned_in_smp;
 
+void sched_cache_exec_done(void);
+
 #else
 
 struct sched_cache_stat { };
 
+static inline void sched_cache_exec_done(void) { }
+
 #endif
 
 #ifndef MODULE
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dff37059faf70..a3d0185717f7b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1989,6 +1989,18 @@ void init_sched_mm(struct task_struct *p)
 	p->preferred_llc = -1;
 }
 
+/* exec() has switched to the new mm and is about to drop the old one. */
+void sched_cache_exec_done(void)
+{
+	/*
+	 * account_mm_sched() dereferences rq->curr->mm with the rq lock held,
+	 * so a remote CPU can still be using the old mm. That section runs with
+	 * preemption disabled and is therefore an RCU read-side critical
+	 * section, so wait for a grace period before the mm goes away.
+	 */
+	synchronize_rcu();
+}
+
 #else /* CONFIG_SCHED_CACHE */
 
 static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
-- 
2.43.0

