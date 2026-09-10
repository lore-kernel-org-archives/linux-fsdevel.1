Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C157D211;
	Thu, 10 Sep 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062077; cv=none; b=d6BDcH8/NyM11I+S6gve2kdRsjOfnjRZ/qL4BK+/iU5ZSa7aCa5YxBMuhTrJ/gB2Tosad2z/gahJ2l0eer/PCkb9hiAFNOLrkpvz01/KyQA3c/otEN/JeEwJGVvaHyehcGBpPOVrfBdwcj2vO2wbeGvkWgyH8z4iDENRnPkC9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062077; c=relaxed/simple;
	bh=W/pI4hTTfxyMkrIZX8ZwYEyYg5lb1ZUW7C0sBU/8BTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAszVYBawuEZQ35bkXdx+SFTVtpB9zmD1DiDuM1hI5dKDwROddfRBWGRDqCd4gQFZY/fsoyQqzqIHxNHfZNKLQ9BfCm+uwvbmErOHlsI3Z3an1P02LgjZ+SQtMdVifgQT9aKwQlsgD04TQOvZ0Bz+udL/21WE5RgF1CBhxCpaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrohzmoJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrohzmoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789062067; x=1820598067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/pI4hTTfxyMkrIZX8ZwYEyYg5lb1ZUW7C0sBU/8BTY=;
  b=IrohzmoJZPC8y92KEjL+tEAd2OyRMaNuGkZcfRabfsvwf+or972Zw/Rj
   dUCD9WI9Dq7Ai6kaaOn1bUlR8gCREIu6X7I23SLGTvpr62im8VRGbDIUZ
   MJB6c0BMeh/AyjHETs2eA1VBc1us1w3w6rmyLEV3KBrMOQva2nerxLnGk
   qenYsGoeXWH+1cDfYTCXhIYk63RH0dDI1HAtobSzZn8xN12h4qe/RHfGP
   FW08tmu5QlA7JTeRyH7IfL/ugSfSX/uasaELW6hzk91WABK5ifuG9Z4fn
   bpcyPp7pVa6IU0fmhPMqlR/ahPnqOhiFKfX02Qwzo/sWiKU+hS+hU5y77
   A==;
X-CSE-ConnectionGUID: dsQGJNWxSduMUUgXGuV3AA==
X-CSE-MsgGUID: 9f5mT+d6ScGJRH4LDQSVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89453844"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89453844"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 10:40:52 -0700
X-CSE-ConnectionGUID: 6uQBSPgeTyGTOUUc6ZJn3w==
X-CSE-MsgGUID: o7jgm3nbS5SyroIxV1zu3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="275222027"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2026 10:40:52 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	Ricardo Neri-Calderon <ricardo.neri-calderon@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] sched/cache: Introduce task_struct->sched_cache_grp
Date: Thu, 10 Sep 2026 10:46:12 -0700
Message-Id: <4532ec4fd5beb829bccb85822a19360fa4191fe6.1789061845.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1789061845.git.tim.c.chen@linux.intel.com>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sched_cache_grp pointer to task_struct so that scheduler code
can access the cache group directly via the task, without going
through mm->sched_cache_grp.  This decouples the scheduler's hot-path
accesses from the mm_struct.

Each task holds its own refcount on the sched_cache_group, separate
from the reference held by its mm_struct.  The reference is acquired
in copy_mm() (fork) and exec_mmap() (exec), and released in exit_mm().
This fixes use after free problem when accessing sched_cache_grp
in account_mm_sched() via mm as reported in
https://lore.kernel.org/lkml/apPb-Dr4nPYuHQOK@v4bel/

Convert all scheduler code in fair.c and exit.c to use
p->sched_cache_grp instead of p->mm->sched_cache_grp.

Add sched_cache_group_get() to kernel/sched/cache_sched.c.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/lkml/apPb-Dr4nPYuHQOK@v4bel/
Tested-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 fs/exec.c                  |  14 ++++
 include/linux/sched.h      |   3 +
 kernel/exit.c              |  26 +++++--
 kernel/fork.c              |  23 ++++++
 kernel/sched/cache_sched.c |  19 +++++
 kernel/sched/fair.c        | 142 +++++++++++++++++++++----------------
 kernel/sched/sched.h       |   3 +
 7 files changed, 164 insertions(+), 66 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..7a8a9954343e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -882,6 +882,20 @@ static int exec_mmap(struct linux_binprm *bprm)
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	tsk->mm = mm;
+#ifdef CONFIG_SCHED_CACHE
+	{
+		struct sched_cache_group *old_grp, *new_grp;
+
+		old_grp = rcu_dereference_protected(tsk->sched_cache_grp, true);
+
+		/* Acquire the reference before publishing the pointer. */
+		new_grp = sched_cache_group_get(mm->sched_cache_grp);
+
+		rcu_assign_pointer(tsk->sched_cache_grp, new_grp);
+		if (old_grp)
+			sched_cache_group_put(old_grp);
+	}
+#endif
 	mm_init_cid(mm, tsk);
 	exec_state = task_exec_state_replace(tsk, exec_state);
 	/*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1f254364f216..cab8e89b1462 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1434,6 +1434,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CACHE
 	struct callback_head		cache_work;
 	int				preferred_llc;
+	struct sched_cache_group __rcu	*sched_cache_grp;
 	/* 1: task was enqueued to its preferred LLC, 0 otherwise */
 	int				pref_llc_queued;
 #endif
@@ -2418,6 +2419,8 @@ struct sched_cache_group {
 } ____cacheline_aligned_in_smp;
 
 void sched_cache_group_put(struct sched_cache_group *grp);
+struct sched_cache_group *sched_cache_group_get(struct sched_cache_group *grp);
+struct sched_cache_group *task_cache_group_get(struct task_struct *p);
 
 #else
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 006edcc0c2c5..442535778ce1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -552,23 +552,25 @@ void mm_update_next_owner(struct mm_struct *mm)
  * Subtract the memory footprint of the current task from
  * mm.
  */
-static void exit_mm_sched_cache(struct mm_struct *mm)
+static void exit_mm_sched_cache(void)
 {
+	struct sched_cache_group *grp =
+		rcu_dereference_protected(current->sched_cache_grp, true);
 	unsigned long fp, sub;
 
-	if (!current->total_numa_faults)
+	if (!grp || !current->total_numa_faults)
 		return;
 	/*
 	 * No lock protection due to performance considerations.
 	 * Make sure the group footprint does not become
 	 * negative.
 	 */
-	fp = READ_ONCE(mm->sched_cache_grp->footprint);
+	fp = READ_ONCE(grp->footprint);
 	sub = min(fp, current->total_numa_faults);
-	WRITE_ONCE(mm->sched_cache_grp->footprint, fp - sub);
+	WRITE_ONCE(grp->footprint, fp - sub);
 }
 #else
-static inline void exit_mm_sched_cache(struct mm_struct *mm)
+static inline void exit_mm_sched_cache(void)
 {
 }
 #endif /* CONFIG_SCHED_CACHE CONFIG_NUMA_BALANCING */
@@ -585,7 +587,19 @@ static void exit_mm(void)
 	if (!mm)
 		return;
 
-	exit_mm_sched_cache(mm);
+	exit_mm_sched_cache();
+
+#ifdef CONFIG_SCHED_CACHE
+	{
+		struct sched_cache_group *grp =
+			rcu_dereference_protected(current->sched_cache_grp, true);
+
+		rcu_assign_pointer(current->sched_cache_grp, NULL);
+
+		if (grp)
+			sched_cache_group_put(grp);
+	}
+#endif
 
 	mmap_read_lock(mm);
 	mmgrab_lazy_tlb(mm);
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..2e79548cb7c1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1599,6 +1599,19 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 
 	tsk->mm = mm;
 	tsk->active_mm = mm;
+#ifdef CONFIG_SCHED_CACHE
+	{
+		/*
+		 * A task holds its own reference on the group, separate from
+		 * the reference held by its mm_struct. Acquire it before
+		 * publishing the pointer.
+		 */
+		struct sched_cache_group *grp =
+			sched_cache_group_get(mm->sched_cache_grp);
+
+		rcu_assign_pointer(tsk->sched_cache_grp, grp);
+	}
+#endif
 	return 0;
 }
 
@@ -2599,6 +2612,16 @@ __latent_entropy struct task_struct *copy_process(
 bad_fork_cleanup_namespaces:
 	exit_nsproxy_namespaces(p);
 bad_fork_cleanup_mm:
+#ifdef CONFIG_SCHED_CACHE
+	/*
+	 * copy_mm() took a task reference on the cache group; a failed fork
+	 * never reaches exit_mm(), so release it here to avoid leaking the
+	 * group and its per-CPU buffer.
+	 */
+	sched_cache_group_put(rcu_dereference_protected(p->sched_cache_grp, true));
+	RCU_INIT_POINTER(p->sched_cache_grp, NULL);
+#endif
+
 	if (p->mm) {
 		mm_clear_owner(p->mm, p);
 		mmput(p->mm);
diff --git a/kernel/sched/cache_sched.c b/kernel/sched/cache_sched.c
index d492df55f9d5..99d07e1e067c 100644
--- a/kernel/sched/cache_sched.c
+++ b/kernel/sched/cache_sched.c
@@ -1,6 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "sched.h"
 
+struct sched_cache_group *sched_cache_group_get(struct sched_cache_group *grp)
+{
+	/*
+	 * refcount_inc_not_zero() is the acquire primitive for lockless
+	 * (RCU) lookups; plain refcount_inc() would scribble the count if
+	 * it already reached zero. Return NULL in that case.
+	 */
+	if (grp && !refcount_inc_not_zero(&grp->refcnt))
+		grp = NULL;
+
+	return grp;
+}
+
+struct sched_cache_group *task_cache_group_get(struct task_struct *p)
+{
+	guard(rcu)();
+	return sched_cache_group_get(rcu_dereference(p->sched_cache_grp));
+}
+
 static void sched_cache_group_free_rcu(struct rcu_head *rcu)
 {
 	struct sched_cache_group *grp =
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b5a823f0a622..272dce2baf32 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1483,7 +1483,7 @@ static inline int get_sched_cache_scale(int mul)
 	return (1 + (tol - 1) * mul);
 }
 
-static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
+static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
 {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long llc, footprint;
@@ -1502,7 +1502,7 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
 		 * excluded.
 		 */
 		llc = sd->llc_bytes;
-		footprint = READ_ONCE(mm->sched_cache_grp->footprint);
+		footprint = READ_ONCE(grp->footprint);
 
 		/*
 		 * Scale the LLC size by 256*llc_aggr_tolerance
@@ -1531,7 +1531,7 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
 	return false;
 }
 
-static bool invalid_llc_nr(struct mm_struct *mm, struct task_struct *p,
+static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
 			   int cpu)
 {
 	int scale;
@@ -1547,7 +1547,7 @@ static bool invalid_llc_nr(struct mm_struct *mm, struct task_struct *p,
 	if (scale == INT_MAX)
 		return false;
 
-	return !fits_capacity((mm->sched_cache_grp->nr_running_avg * cpu_smt_num_threads),
+	return !fits_capacity((grp->nr_running_avg * cpu_smt_num_threads),
 			(scale * per_cpu(sd_llc_size, cpu)));
 }
 
@@ -1756,14 +1756,14 @@ static unsigned long fraction_mm_sched(struct rq *rq,
 	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
 }
 
-static int get_pref_llc(struct task_struct *p, struct mm_struct *mm)
+static int get_pref_llc(struct task_struct *p, struct sched_cache_group *grp)
 {
 	int mm_sched_llc = -1, mm_sched_cpu;
 
-	if (!mm)
+	if (!grp)
 		return -1;
 
-	mm_sched_cpu = READ_ONCE(mm->sched_cache_grp->cpu);
+	mm_sched_cpu = READ_ONCE(grp->cpu);
 	if (mm_sched_cpu != -1) {
 		mm_sched_llc = llc_id(mm_sched_cpu);
 
@@ -1793,8 +1793,8 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p);
 static inline
 void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 {
+	struct sched_cache_group *grp = rcu_dereference_all(p->sched_cache_grp);
 	struct sched_cache_time *pcpu_sched;
-	struct mm_struct *mm = p->mm;
 	int mm_sched_llc = -1;
 	unsigned long epoch;
 
@@ -1805,16 +1805,12 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 		return;
 	/*
 	 * init_task, kthreads and user thread created
-	 * by user_mode_thread() don't have mm.
-	 *
-	 * A kthread can temporarily adopt an mm via kthread_use_mm(),
-	 * so p->mm alone does not imply a user task.
+	 * by user_mode_thread() don't have a cache group.
 	 */
-	if (!mm || p->flags & PF_KTHREAD || !mm->sched_cache_grp ||
-	    !mm->sched_cache_grp->pcpu_sched)
+	if (!grp || p->flags & PF_KTHREAD || !grp->pcpu_sched)
 		return;
 
-	pcpu_sched = per_cpu_ptr(mm->sched_cache_grp->pcpu_sched, cpu_of(rq));
+	pcpu_sched = per_cpu_ptr(grp->pcpu_sched, cpu_of(rq));
 
 	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
 		__update_mm_sched(rq, pcpu_sched);
@@ -1827,14 +1823,14 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 * If this process hasn't hit task_cache_work() for a while invalidate
 	 * its preferred state.
 	 */
-	if ((long)(epoch - READ_ONCE(mm->sched_cache_grp->epoch)) > llc_epoch_affinity_timeout ||
-	    invalid_llc_nr(mm, p, cpu_of(rq)) ||
-	    exceed_llc_capacity(mm, cpu_of(rq))) {
-		if (READ_ONCE(mm->sched_cache_grp->cpu) != -1)
-			WRITE_ONCE(mm->sched_cache_grp->cpu, -1);
+	if ((long)(epoch - READ_ONCE(grp->epoch)) > llc_epoch_affinity_timeout ||
+	    invalid_llc_nr(grp, p, cpu_of(rq)) ||
+	    exceed_llc_capacity(grp, cpu_of(rq))) {
+		if (READ_ONCE(grp->cpu) != -1)
+			WRITE_ONCE(grp->cpu, -1);
 	}
 
-	mm_sched_llc = get_pref_llc(p, mm);
+	mm_sched_llc = get_pref_llc(p, grp);
 
 	/* task not on rq accounted later in account_entity_enqueue() */
 	if (task_running_on_cpu(rq->cpu, p) &&
@@ -1847,31 +1843,32 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 
 static void task_tick_cache(struct rq *rq, struct task_struct *p)
 {
+	struct sched_cache_group *grp = rcu_dereference_all(p->sched_cache_grp);
 	struct callback_head *work = &p->cache_work;
-	struct mm_struct *mm = p->mm;
 	unsigned long epoch;
 
 	if (!sched_cache_enabled())
 		return;
 
-	if (!mm || p->flags & PF_KTHREAD ||
-	    !mm->sched_cache_grp->pcpu_sched)
+	if (!grp || p->flags & PF_KTHREAD ||
+	    !grp->pcpu_sched)
 		return;
 
 	epoch = rq->cpu_epoch;
 	/* avoid moving backwards */
-	if (time_after_eq(mm->sched_cache_grp->epoch, epoch))
+	if (time_after_eq(grp->epoch, epoch))
 		return;
 
-	guard(raw_spinlock)(&mm->sched_cache_grp->lock);
+	guard(raw_spinlock)(&grp->lock);
 
 	if (work->next == work) {
 		task_work_add(p, work, TWA_RESUME);
-		WRITE_ONCE(mm->sched_cache_grp->epoch, epoch);
+		WRITE_ONCE(grp->epoch, epoch);
 	}
 }
 
-static void get_scan_cpumasks(cpumask_var_t cpus, struct task_struct *p)
+static void get_scan_cpumasks(cpumask_var_t cpus, struct task_struct *p,
+			      struct sched_cache_group *grp)
 {
 #ifdef CONFIG_NUMA_BALANCING
 	int cpu, curr_cpu, nid, pref_nid;
@@ -1879,7 +1876,7 @@ static void get_scan_cpumasks(cpumask_var_t cpus, struct task_struct *p)
 	if (!static_branch_likely(&sched_numa_balancing))
 		goto out;
 
-	cpu = READ_ONCE(p->mm->sched_cache_grp->cpu);
+	cpu = READ_ONCE(grp->cpu);
 	if (cpu != -1)
 		nid = cpu_to_node(cpu);
 	curr_cpu = task_cpu(p);
@@ -1940,9 +1937,7 @@ static void task_cache_work(struct callback_head *work)
 	unsigned long next_scan, now = jiffies;
 	struct task_struct *p = current, *cur;
 	unsigned long curr_m_a_occ = 0;
-	struct mm_struct *mm = p->mm;
 	unsigned long m_a_occ = 0;
-	cpumask_var_t cpus;
 
 	WARN_ON_ONCE(work != &p->cache_work);
 
@@ -1951,32 +1946,44 @@ static void task_cache_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
-	next_scan = READ_ONCE(mm->sched_cache_grp->next_scan);
+	/*
+	 * A reference makes sure grp is not released by others. The rcu
+	 * lock can not be held till after zalloc_cpumask_var() below,
+	 * because the latter might sleep.
+	 */
+	struct sched_cache_group *grp __free(sched_cache_group_put) =
+		task_cache_group_get(p);
+	if (!grp)
+		return;
+
+	next_scan = READ_ONCE(grp->next_scan);
 	if (time_before(now, next_scan))
 		return;
 
 	/* only 1 thread is allowed to scan */
-	if (!try_cmpxchg(&mm->sched_cache_grp->next_scan, &next_scan,
+	if (!try_cmpxchg(&grp->next_scan, &next_scan,
 			 now + max_t(unsigned long,
 				     READ_ONCE(llc_epoch_period), 1)))
 		return;
 
 	curr_cpu = task_cpu(p);
-	if (invalid_llc_nr(mm, p, curr_cpu) ||
-	    exceed_llc_capacity(mm, curr_cpu)) {
-		if (READ_ONCE(mm->sched_cache_grp->cpu) != -1)
-			WRITE_ONCE(mm->sched_cache_grp->cpu, -1);
+	if (invalid_llc_nr(grp, p, curr_cpu) ||
+	    exceed_llc_capacity(grp, curr_cpu)) {
+		if (READ_ONCE(grp->cpu) != -1)
+			WRITE_ONCE(grp->cpu, -1);
 
 		return;
 	}
 
+	cpumask_var_t cpus __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+
 	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
 		return;
 
 	scoped_guard (cpus_read_lock) {
 		guard(rcu)();
 
-		get_scan_cpumasks(cpus, p);
+		get_scan_cpumasks(cpus, p, grp);
 
 		for_each_cpu(cpu, cpus) {
 			/* XXX sched_cluster_active */
@@ -1988,8 +1995,6 @@ static void task_cache_work(struct callback_head *work)
 				continue;
 
 			for_each_cpu(i, sched_domain_span(sd)) {
-				struct sched_cache_group *grp = mm->sched_cache_grp;
-
 				occ = fraction_mm_sched(cpu_rq(i),
 							per_cpu_ptr(grp->pcpu_sched, i));
 				a_occ += occ;
@@ -1998,9 +2003,13 @@ static void task_cache_work(struct callback_head *work)
 					m_cpu = i;
 				}
 
+				/*
+				 * rcu_access_pointer() is used because the
+				 * pointer is only compared, never dereferenced.
+				 */
 				cur = rcu_dereference_all(cpu_rq(i)->curr);
 				if (cur && !(cur->flags & (PF_EXITING | PF_KTHREAD)) &&
-				    cur->mm == mm)
+				    rcu_access_pointer(cur->sched_cache_grp) == grp)
 					nr_running++;
 			}
 
@@ -2024,7 +2033,7 @@ static void task_cache_work(struct callback_head *work)
 				m_a_cpu = m_cpu;
 			}
 
-			if (llc_id(cpu) == llc_id(READ_ONCE(mm->sched_cache_grp->cpu)))
+			if (llc_id(cpu) == llc_id(READ_ONCE(grp->cpu)))
 				curr_m_a_occ = a_occ;
 
 			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
@@ -2042,11 +2051,10 @@ static void task_cache_work(struct callback_head *work)
 		 * 3. 2X is chosen based on test results, as it delivers
 		 *    the optimal performance gain so far.
 		 */
-		WRITE_ONCE(mm->sched_cache_grp->cpu, m_a_cpu);
+		WRITE_ONCE(grp->cpu, m_a_cpu);
 	}
 
-	update_avg_scale(&mm->sched_cache_grp->nr_running_avg, nr_running);
-	free_cpumask_var(cpus);
+	update_avg_scale(&grp->nr_running_avg, nr_running);
 }
 
 void init_sched_mm(struct task_struct *p)
@@ -2055,6 +2063,13 @@ void init_sched_mm(struct task_struct *p)
 
 	init_task_work(work, task_cache_work);
 	work->next = work;
+	/*
+	 * dup_task_struct() copies the parent's task_struct, including its
+	 * sched_cache_grp, for which the child holds no reference.  Clear it
+	 * here - before copy_mm() runs - so the child never carries a
+	 * borrowed pointer that the fork error path would put.
+	 */
+	RCU_INIT_POINTER(p->sched_cache_grp, NULL);
 	/*
 	 * Reset new task's preference to avoid
 	 * polluting account_llc_enqueue().
@@ -3853,10 +3868,9 @@ static void task_numa_placement(struct task_struct *p)
 			 * heuristic and occasional lost updates are tolerable.
 			 *
 			 * If a task exits, its corresponding footprint must
-			 * be subtracted from the mm->sched_cache_grp->footprint,
-			 * otherwise the mm->sched_cache_grp->footprint will not
-			 * converge: the exiting thread's footprint remains
-			 * unchanged/undecayed in mm->sched_cache_grp->footprint.
+			 * be subtracted from p->sched_cache_grp->footprint,
+			 * otherwise the footprint will not converge: the
+			 * exiting thread's footprint remains unchanged/undecayed.
 			 * See exit_mm().
 			 *
 			 * Lost updates and unsynchronized subtraction
@@ -3864,9 +3878,17 @@ static void task_numa_placement(struct task_struct *p)
 			 * go negative. Clamp to zero to prevent the
 			 * unsigned footprint from wrapping.
 			 */
-			new_fp = (long)READ_ONCE(p->mm->sched_cache_grp->footprint) + diff;
-			WRITE_ONCE(p->mm->sched_cache_grp->footprint,
-				   max(new_fp, 0L));
+			{
+				struct sched_cache_group *grp;
+
+				guard(rcu)();
+				grp = rcu_dereference(p->sched_cache_grp);
+
+				if (grp) {
+					new_fp = (long)READ_ONCE(grp->footprint) + diff;
+					WRITE_ONCE(grp->footprint, max(new_fp, 0L));
+				}
+			}
 #endif
 		}
 
@@ -10810,7 +10832,7 @@ static inline bool task_misfits_asym_cpu(struct lb_env *env, struct task_struct
 static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 					 struct task_struct *p)
 {
-	struct mm_struct *mm;
+	struct sched_cache_group *grp;
 	bool to_pref;
 	int cpu, src_cpu, dst_cpu;
 
@@ -10819,19 +10841,19 @@ static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 
 	src_cpu = env->src_cpu;
 	dst_cpu = env->dst_cpu;
-	mm = p->mm;
-	if (!mm || !mm->sched_cache_grp)
+	grp = rcu_dereference_all(p->sched_cache_grp);
+	if (!grp)
 		return mig_unrestricted;
 
-	cpu = READ_ONCE(mm->sched_cache_grp->cpu);
+	cpu = READ_ONCE(grp->cpu);
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
 
 	/* skip cache aware load balance for too many threads */
-	if (invalid_llc_nr(mm, p, dst_cpu) ||
-	    exceed_llc_capacity(mm, dst_cpu)) {
-		if (READ_ONCE(mm->sched_cache_grp->cpu) != -1)
-			WRITE_ONCE(mm->sched_cache_grp->cpu, -1);
+	if (invalid_llc_nr(grp, p, dst_cpu) ||
+	    exceed_llc_capacity(grp, dst_cpu)) {
+		if (READ_ONCE(grp->cpu) != -1)
+			WRITE_ONCE(grp->cpu, -1);
 		return mig_unrestricted;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..8b67af28a471 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4145,6 +4145,9 @@ static inline bool sched_cache_enabled(void)
 	return static_branch_unlikely(&sched_cache_active);
 }
 
+DEFINE_FREE(sched_cache_group_put, struct sched_cache_group *,
+	    sched_cache_group_put(_T));
+
 extern void sched_cache_active_set(void);
 
 #endif
-- 
2.32.0

