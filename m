Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A8316905;
	Tue, 22 Sep 2026 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037134; cv=none; b=ThFGQ8kfjY6Q9g6v1/SNrei4hRwjM6kbwHe0Q26ZykmG/9fx3HLBiENVFZJizd7pK3g4POu+27AhkKM6efm/Vsq55Pf/JqsIpEuUinAiD6F9HmeigdNmyaKL0mGILEuj1FgrFoCe03R3sdraRAzlrVCMLLy29dl2u5qYJrFPl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037134; c=relaxed/simple;
	bh=TLr+muP9IJPeDswlAwrJ9DVaMebbbJPEc9g+IiyTn3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPv0i8F1rOCveWF3GvgDtx+7CWxkwFatd2YyIyaHAk8v46wDB0j7QiNoXipJNsPkWRYSW50dkZC4kZjtFXLmSG7AcDfD2B4XJYw2u5yPDRXUv59Sc5GwRLm6uBeBhtIe/7Fwma8VNTWp4bKFF2fZhfPg83zI6ChSajXSaVi1XIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7aVy/LA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7aVy/LA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790037133; x=1821573133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TLr+muP9IJPeDswlAwrJ9DVaMebbbJPEc9g+IiyTn3Q=;
  b=K7aVy/LAJAY+dtrFY78rakivrFWttR/CDM02IsMCD/lZhT0p4G+LChp/
   rU5/ISy4/LzJLPk6t0nWgveznpHAK/q88XY4P/4TzJI6gh+Kzjh+nNKwu
   xmnfVtWYSUMiRoa9xyR+Dm/7CnR3F/W0hC0xiMTUtFtgh4tT0CxaQmG4M
   qf+eVQBpbOpLo1gGjim7IdZ1ga1JYs9khznrkNTpUStEiTLrg6woT7sEq
   DMSYZRLLHfycYhebm0pbDGdNuD9SCc0YXDmNJR2j78xyObJ34Ri5jYhp/
   INhQHapuGH9v2/XbQvjYtQjha76A+Hf7acIUF+T49X4v+l/2kZoQSwa7w
   A==;
X-CSE-ConnectionGUID: PMPX99m5TEaalj0Y3EO+gQ==
X-CSE-MsgGUID: RYUIYs9jQkGzBm2xVTjYpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90716634"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90716634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:32:12 -0700
X-CSE-ConnectionGUID: twlC2qkvS7CeVw4fkj5Ksw==
X-CSE-MsgGUID: bQa3l3LNTVy7qIDuPDoQrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277671820"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 17:32:10 -0700
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Kayra Cizmeci <kayracizmeci@gmail.com>,
	stable@kernel.org
Subject: [PATCH v2 1/6] sched/cache: Keep nr_pref_llc_running in the runnable domain
Date: Mon, 21 Sep 2026 17:37:22 -0700
Message-Id: <06af61afedac32e6477f57feb4d658f6c411c3af.1790035273.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1790035273.git.tim.c.chen@linux.intel.com>
References: <cover.1790035273.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alb_break_llc() decides whether to break LLC preference during active
load balance. It does so by testing that every runnable fair task on the
source rq prefers its LLC:

	env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable

But the two counters cover different sets. nr_pref_llc_running is updated
in account_llc_enqueue()/account_llc_dequeue(), next to cfs_rq->nr_queued,
so it follows queued tasks. h_nr_runnable is updated in set_delayed()/
clear_delayed() and drops delay-dequeued tasks.

So under DELAY_DEQUEUE, a preferring task that goes to sleep stays counted
in nr_pref_llc_running while h_nr_runnable falls. The equality then breaks,
alb_break_llc() returns false, and active balance is free to pull a task
off its preferred LLC. Active balance only moves runnable tasks, and this
is the only LLC check it consults: once the stopper runs, LBF_ACTIVE_LB
skips the per-task test in can_migrate_task(). The runnable set is the one
we want.

Fix it on the counter side. A task should be counted in
nr_pref_llc_running exactly while it is both queued on its preferred LLC
(pref_llc_queued) and runnable (!sched_delayed). Define that membership
once in task_pref_llc_runnable(), and adjust the counter only through
pref_llc_running_inc()/pref_llc_running_dec() from the four sites that
change either input: account_llc_enqueue(), account_llc_dequeue(),
set_delayed() and clear_delayed(). Gating every update on the same
predicate keeps the delay, wake and dequeue paths from double-counting
or underflowing; see the comments at those sites for the ordering.

nr_llc_running and sd->llc_counts are not touched and stay on queued
semantics.

Fixes: 714059f79ff0 ("sched/cache: Handle moving single tasks to/from their preferred LLC")
Reported-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Closes: https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@xiaomi.com/
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: stable@kernel.org #7.2.x
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 63 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5989b53adef..19765ee1af83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1551,6 +1551,28 @@ static bool invalid_llc_nr(struct mm_struct *mm, struct task_struct *p,
 			(scale * per_cpu(sd_llc_size, cpu)));
 }
 
+/*
+ * A task counts in nr_pref_llc_running while it is queued on its preferred
+ * LLC (pref_llc_queued) and runnable (!sched_delayed), keeping the counter in
+ * the runnable domain so alb_break_llc() can compare it with h_nr_runnable.
+ */
+static bool task_pref_llc_runnable(struct task_struct *p)
+{
+	return p->pref_llc_queued && !p->se.sched_delayed;
+}
+
+static void pref_llc_running_inc(struct rq *rq, struct task_struct *p)
+{
+	if (task_pref_llc_runnable(p))
+		rq->nr_pref_llc_running++;
+}
+
+static void pref_llc_running_dec(struct rq *rq, struct task_struct *p)
+{
+	if (task_pref_llc_runnable(p))
+		rq->nr_pref_llc_running--;
+}
+
 static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 {
 	int pref_llc, pref_llc_queued;
@@ -1562,7 +1584,6 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 
 	pref_llc_queued = (pref_llc == task_llc(p));
 	rq->nr_llc_running++;
-	rq->nr_pref_llc_running += pref_llc_queued;
 
 	/*
 	 * Record whether p is enqueued on its preferred
@@ -1580,6 +1601,9 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 	 */
 	p->pref_llc_queued = pref_llc_queued;
 
+	/* Skipped while delayed; clear_delayed() adds it back on wake. */
+	pref_llc_running_inc(rq, p);
+
 	sd = rcu_dereference_all(rq->sd);
 	if (sd && (unsigned int)pref_llc < sd->llc_max)
 		sd->llc_counts[pref_llc]++;
@@ -1596,7 +1620,12 @@ static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
 
 	rq->nr_llc_running--;
 	if (p->pref_llc_queued) {
-		rq->nr_pref_llc_running--;
+		/*
+		 * Skipped if still delayed (set_delayed() already removed it);
+		 * clearing pref_llc_queued below also stops clear_delayed()
+		 * from re-adding it.
+		 */
+		pref_llc_running_dec(rq, p);
 		/*
 		 * Update the status in case
 		 * other logic might query
@@ -2000,6 +2029,7 @@ void init_sched_mm(struct task_struct *p)
 	 * polluting account_llc_enqueue().
 	 */
 	p->preferred_llc = -1;
+	p->pref_llc_queued = 0;
 }
 
 #else /* CONFIG_SCHED_CACHE */
@@ -2021,6 +2051,10 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p) {}
 
 static void account_llc_dequeue(struct rq *rq, struct task_struct *p) {}
 
+static void pref_llc_running_inc(struct rq *rq, struct task_struct *p) {}
+
+static void pref_llc_running_dec(struct rq *rq, struct task_struct *p) {}
+
 #endif /* CONFIG_SCHED_CACHE */
 
 /*
@@ -6395,15 +6429,27 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
 static void set_delayed(struct sched_entity *se)
 {
-	se->sched_delayed = 1;
-
 	/*
 	 * Delayed se of cfs_rq have no tasks queued on them.
 	 * Do not adjust h_nr_runnable since __dequeue_task()
 	 * will account it for blocked tasks.
+	 *
+	 * This check can be removed because when flat pick
+	 * patches get merged as only task can get delayed,
+	 * same for clear_delayed().
 	 */
-	if (!entity_is_task(se))
+	if (!entity_is_task(se)) {
+		se->sched_delayed = 1;
 		return;
+	}
+
+	/*
+	 * Drop a task leaving the runnable set.
+	 * Needs to be called before sched_delayed is set.
+	 * clear_delayed() mirrors this after clearing the flag.
+	 */
+	pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
+	se->sched_delayed = 1;
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -6425,6 +6471,13 @@ static void clear_delayed(struct sched_entity *se)
 	if (!entity_is_task(se))
 		return;
 
+	/*
+	 * Re-add on wake, after sched_delayed is cleared. On a final delayed
+	 * dequeue account_llc_dequeue() already cleared pref_llc_queued, so
+	 * this does nothing.
+	 */
+	pref_llc_running_inc(rq_of(cfs_rq_of(se)), task_of(se));
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-- 
2.32.0

