Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CE50C285
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870348; cv=none; b=qxzIo7ox/1XpXFQ5ruItE7zXCAkzlbUH9lUckeoeIh9tKLOrJkAew/h6tuT5FmDboDEoUmXbzJMQ+aqL+smA2CSCWDppMTYEFqlungjvtrD9aGPV3P24wQG/XumxaQkDiuOO3IKLpfoPBQb5yjM6W5HU5xR7FkapOtfFXi2MpUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870348; c=relaxed/simple;
	bh=X/fkF1SFtCNVDJowkuYq6PZDajpIxcE8K0KswN79NLs=;
	h=In-Reply-To:To:Subject:Message-Id:References:Content-Type:Cc:
	 Mime-Version:From:Date; b=gCgNfYnNfdeh716zY9wHMvhq23Z2anmw5atYuCFkvMVHqou6DpV8wAdNvidJN2UAw+b7nSZ6VzrLcStvW/KVxcaljqFdVZ4DdVCQsM2QSrBKKJnktKaDoJTLMtuxiwnQ0aBCuA8tUfdtG4rbnshj/MpeOv70y1wf8XClqEEqGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dxc+0Xm9; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dxc+0Xm9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788870341; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qPzNpzKQioeyUDiUtPms+YsQd8M8xXBqCK2wxk7y+0Q=;
 b=dxc+0Xm92DCAsFOsZmu3eMCbtdLyzdcl35YtKK9eWwhgzTetFUFCUeFjHP7a4hUtcKl18g
 aS1FFBIrGM2D5Cw0KsVzfnqmQCz94z3c10w/oo1q616AM44o8Pl2EuFtRY+q4hadPnQ4dK
 QWpvXxIijU07pV0fAxqHraaMI7IkifB/qddVdPscJRZUxCCDwghuPy3YLo4yTKj87120tA
 LP/XwttVTlwx+9I06hSxWUGg8Nq16Jz1ggx0mzBI/8VTTFhgcfGEZFLyPYSo00byuJPExc
 fNPKSJpJu52HAwGUXdHq2Kb/E/KI7TCtEsi5cADNZLz+2sRhh/GN6OseIkNMbw==
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a9ffec3+8ef725+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260908122446.56708-1-lizhe.67@bytedance.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, 
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>, 
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, 
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>
Subject: [PATCH 1/4] sched/numa: Track per-process automatic NUMA balancing mode
Message-Id: <20260908122446.56708-2-lizhe.67@bytedance.com>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Tue,  8 Sep 2026 20:24:43 +0800

Add the internal process mode and scheduler hooks for per-process
automatic NUMA balancing control. Any thread in a thread group can change
the mode, and the change applies to the whole thread group. Fork
inherits the parent process mode, CLONE_THREAD shares it, and exec
preserves it. A process mode of enable only allows the process to
participate when the global sysctl/static key is enabled and memory
policy allows NUMA balancing.

Disabling the process mode stops new periodic NUMA scan scheduling and
excludes the process from NUMA locality scheduler accounting.
Already-installed NUMA hinting PTEs, queued scan work, and other NUMA
state are not actively cleared; they drain or age out naturally as the
disabled state takes effect. This keeps the slow-path ABI simple and
avoids expensive address-space surgery.

The configured process mode lives in signal_struct. A separate
numa_balancing_sched_enabled field in task_struct is only a scheduler
snapshot used by NUMA hot paths and runqueue accounting. It is not part
of the userspace-visible process mode. The fork path initializes both
pieces of state under current->sighand->siglock before the new task is
published. The mode update path serializes concurrent updates, changes
the signal mode under siglock, updates the calling task immediately, and
then walks the remaining thread list under tasklist_lock to update the
rest under sched_change. This keeps rq->nr_numa_running and
rq->nr_preferred_running in sync without adding extra hot-path locking.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 include/linux/sched.h                |  6 +++++
 include/linux/sched/numa_balancing.h | 37 ++++++++++++++++++++++++++
 include/linux/sched/signal.h         |  8 ++++++
 init/init_task.c                     |  4 +++
 kernel/fork.c                        |  8 ++++++
 kernel/sched/core.c                  | 39 ++++++++++++++++++++++++++++
 kernel/sched/fair.c                  | 36 ++++++++++++++++++++++---
 7 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..7f1932658d24 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1382,6 +1382,12 @@ struct task_struct {
 	short				pref_node_fork;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
+	/*
+	 * Scheduler snapshot of signal_struct::numa_balancing_enabled. It is
+	 * updated with sched_change for runqueue NUMA accounting; the
+	 * user-visible process mode lives in signal_struct.
+	 */
+	bool				numa_balancing_sched_enabled;
 	int				numa_scan_seq;
 	unsigned int			numa_scan_period;
 	unsigned int			numa_scan_period_max;
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 52b22c5c396d..bc413aae5915 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 
 #define TNF_MIGRATED	0x01
 #define TNF_NO_GROUP	0x02
@@ -30,6 +31,22 @@ extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
+static inline bool task_numa_sched_snapshot_enabled(struct task_struct *p)
+{
+	return READ_ONCE(p->numa_balancing_sched_enabled);
+}
+
+static inline bool task_numa_process_mode_enabled(struct task_struct *p)
+{
+	return READ_ONCE(p->signal->numa_balancing_enabled);
+}
+
+int task_numa_balancing_set_current(bool enabled);
+
+static inline int task_numa_balancing_get_current(void)
+{
+	return task_numa_process_mode_enabled(current);
+}
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu);
 #else
@@ -47,6 +64,26 @@ static inline void set_numabalancing_state(bool enabled)
 static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
+
+static inline bool task_numa_sched_snapshot_enabled(struct task_struct *p)
+{
+	return false;
+}
+
+static inline bool task_numa_process_mode_enabled(struct task_struct *p)
+{
+	return false;
+}
+
+static inline int task_numa_balancing_set_current(bool enabled)
+{
+	return -EINVAL;
+}
+
+static inline int task_numa_balancing_get_current(void)
+{
+	return -EINVAL;
+}
 static inline bool should_numa_migrate_memory(struct task_struct *p,
 				struct folio *folio, int src_nid, int dst_cpu)
 {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..fdc03c016cfe 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -179,6 +179,14 @@ struct signal_struct {
 
 #ifdef CONFIG_SCHED_AUTOGROUP
 	struct autogroup *autogroup;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	/*
+	 * Thread-group automatic NUMA balancing mode configured through prctl().
+	 * Scheduler hot paths use task_struct::numa_balancing_sched_enabled as
+	 * their per-task runqueue accounting snapshot.
+	 */
+	bool numa_balancing_enabled;
 #endif
 	/*
 	 * Cumulative resource counters for dead threads in the group,
diff --git a/init/init_task.c b/init/init_task.c
index adb207cd987c..835bb3f7a17e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -40,6 +40,9 @@ static struct signal_struct init_signals = {
 	.cputimer		= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	.numa_balancing_enabled = true,
 #endif
 	INIT_CPU_TIMERS(init_signals)
 	.pids = {
@@ -224,6 +227,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.vtime.state	= VTIME_SYS,
 #endif
 #ifdef CONFIG_NUMA_BALANCING
+	.numa_balancing_sched_enabled = true,
 	.numa_preferred_nid = NUMA_NO_NODE,
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..aff64d75c77f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2496,6 +2496,14 @@ __latent_entropy struct task_struct *copy_process(
 
 	/* No more failure paths after this point. */
 
+#ifdef CONFIG_NUMA_BALANCING
+	p->numa_balancing_sched_enabled =
+		READ_ONCE(current->signal->numa_balancing_enabled);
+	if (!(clone_flags & CLONE_THREAD))
+		p->signal->numa_balancing_enabled =
+			p->numa_balancing_sched_enabled;
+#endif
+
 	/*
 	 * Copy seccomp details explicitly here, in case they were changed
 	 * before holding sighand lock.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f78275192036..ba8b22f3ffa5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/sched/loadavg.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/rseq_api.h>
 #include <linux/sched/rt.h>
@@ -603,6 +604,8 @@ int task_llc(const struct task_struct *p)
  *				p->se.load, p->rt_priority,
  *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
  *  - sched_setnuma():		p->numa_preferred_nid
+ *  - task_numa_balancing_set_current():	p->signal->numa_balancing_enabled,
+ *					p->numa_balancing_sched_enabled
  *  - sched_move_task():	p->sched_task_group
  *  - uclamp_update_active()	p->uclamp*
  *
@@ -8407,6 +8410,42 @@ void sched_setnuma(struct task_struct *p, int nid)
 	scoped_guard (sched_change, p, DEQUEUE_SAVE)
 		p->numa_preferred_nid = nid;
 }
+
+static void sched_numa_balancing_change_task(struct task_struct *p, bool enabled)
+{
+	guard(task_rq_lock)(p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+		WRITE_ONCE(p->numa_balancing_sched_enabled, enabled);
+}
+
+int task_numa_balancing_set_current(bool enabled)
+{
+	static DEFINE_MUTEX(task_numa_balancing_mutex);
+	struct task_struct *t;
+	unsigned long flags;
+	bool old_enabled;
+
+	guard(mutex)(&task_numa_balancing_mutex);
+
+	if (WARN_ON_ONCE(!lock_task_sighand(current, &flags)))
+		return -ESRCH;
+
+	old_enabled = current->signal->numa_balancing_enabled;
+	if (old_enabled != enabled)
+		WRITE_ONCE(current->signal->numa_balancing_enabled, enabled);
+
+	unlock_task_sighand(current, &flags);
+
+	if (old_enabled != enabled) {
+		sched_numa_balancing_change_task(current, enabled);
+		read_lock(&tasklist_lock);
+		for_other_threads(current, t)
+			sched_numa_balancing_change_task(t, enabled);
+		read_unlock(&tasklist_lock);
+	}
+
+	return 0;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dff37059faf..7dfe275a4bc4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -38,6 +38,7 @@
 #include <linux/sched/cond_resched.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/prio.h>
 #include <linux/static_call.h>
@@ -1712,6 +1713,7 @@ static int get_pref_llc(struct task_struct *p, struct mm_struct *mm)
 		 * conflict only exists for a short period of time.
 		 */
 		if (static_branch_likely(&sched_numa_balancing) &&
+		    task_numa_sched_snapshot_enabled(p) &&
 		    p->numa_preferred_nid >= 0 &&
 		    cpu_to_node(mm_sched_cpu) != p->numa_preferred_nid)
 			mm_sched_llc = -1;
@@ -1808,6 +1810,9 @@ static void get_scan_cpumasks(cpumask_var_t cpus, struct task_struct *p)
 	if (!static_branch_likely(&sched_numa_balancing))
 		goto out;
 
+	if (!task_numa_sched_snapshot_enabled(p))
+		goto out;
+
 	cpu = READ_ONCE(p->mm->sc_stat.cpu);
 	if (cpu != -1)
 		nid = cpu_to_node(cpu);
@@ -2387,14 +2392,22 @@ static unsigned int task_scan_max(struct task_struct *p)
 
 static void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
-	rq->nr_numa_running += (p->numa_preferred_nid != NUMA_NO_NODE);
-	rq->nr_preferred_running += (p->numa_preferred_nid == task_node(p));
+	bool enabled = task_numa_sched_snapshot_enabled(p);
+
+	rq->nr_numa_running += enabled &&
+				 p->numa_preferred_nid != NUMA_NO_NODE;
+	rq->nr_preferred_running += enabled &&
+				     p->numa_preferred_nid == task_node(p);
 }
 
 static void account_numa_dequeue(struct rq *rq, struct task_struct *p)
 {
-	rq->nr_numa_running -= (p->numa_preferred_nid != NUMA_NO_NODE);
-	rq->nr_preferred_running -= (p->numa_preferred_nid == task_node(p));
+	bool enabled = task_numa_sched_snapshot_enabled(p);
+
+	rq->nr_numa_running -= enabled &&
+				 p->numa_preferred_nid != NUMA_NO_NODE;
+	rq->nr_preferred_running -= enabled &&
+				     p->numa_preferred_nid == task_node(p);
 }
 
 /* Shared or private faults. */
@@ -3085,6 +3098,9 @@ static bool task_numa_compare(struct task_numa_env *env,
 			goto unlock;
 	}
 
+	if (!task_numa_sched_snapshot_enabled(cur))
+		goto unlock;
+
 	/* Skip this swap candidate if cannot move to the source cpu. */
 	if (!cpumask_test_cpu(env->src_cpu, cur->cpus_ptr))
 		goto unlock;
@@ -3992,6 +4008,9 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	if (!static_branch_likely(&sched_numa_balancing))
 		return;
 
+	if (!task_numa_sched_snapshot_enabled(p))
+		return;
+
 	/* for example, ksmd faulting in a user's mm */
 	if (!p->mm)
 		return;
@@ -4436,6 +4455,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
+	if (!task_numa_sched_snapshot_enabled(curr))
+		return;
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
@@ -4463,6 +4485,9 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	if (!static_branch_likely(&sched_numa_balancing))
 		return;
 
+	if (!task_numa_sched_snapshot_enabled(p))
+		return;
+
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
 		return;
 
@@ -10475,6 +10500,9 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	if (!static_branch_likely(&sched_numa_balancing))
 		return 0;
 
+	if (!task_numa_sched_snapshot_enabled(p))
+		return 0;
+
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
 		return 0;
 
-- 
2.20.1
