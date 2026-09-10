Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39659545DB8;
	Thu, 10 Sep 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062065; cv=none; b=MCuSxz68+gCq5L67J4U0W0q+MaDC0xtZieikhA8ffctVINLwQZvY2NUGEhufnJtFxStWxz/oUeFDH48GNMN7QQNErc/My3tta+zHA4qa122kp0Bp3AW7rTFfzLe5qRzF3mb6hMlO7FIzCXlMEXSIVtHRVH2poZSdLuBI7s1sWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062065; c=relaxed/simple;
	bh=xFCDOkvk2TofjVGFvEcPYHDr8qB7EOl4xYV+VmLtdNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqjL3qICAkX5G2r88QmDd86jpsXcpnzAH+inL74NKOXd4R7sAC4yCwOhzNgOyggbq3nW683yuoGmSh9S1Bc9YmOzbSQM+MTTkhvCSuHLaD6pjkobhSBOKz3H4T6H6A4FSASqE7vIFXpq4v/pjY/yXYZIdJuZOrQ7c+JKdPCZVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7TVETxk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7TVETxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789062057; x=1820598057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFCDOkvk2TofjVGFvEcPYHDr8qB7EOl4xYV+VmLtdNo=;
  b=D7TVETxkfzJHJ3PSU1LnkOuQiw6bHpYMwoflJv9pmQ3TlhEdcii7KPl7
   8mYkkvk1CIGO7WRg90GeQQfWKfHhGe7z/FObih0mjD9yBO/DZXnj2xwlt
   K6IvRgq0l5V31d4UMmIKNefIuM81kiSUi6sqBFmgtPpT79UqU64ENnMcp
   pYXVUOAtztYhu20i/0VE/oivHqjgMuR9I/3hwEUzLBpKc387w2P98w6hw
   9HNit/e4+JR0SSK6CfqhSn/VVzWcloWjm1y03ueuxI9lV4GQQSTaN/dUk
   JYlBPN4S3tb6udWDXTxdxkkrnmqbJY3gwbxpOEex4AAHzns3OS5Oh5mp1
   g==;
X-CSE-ConnectionGUID: OTTKg9IbQTWuG3TQLQQuJg==
X-CSE-MsgGUID: JeoGrdE5TNeg/9B3788QWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89453788"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89453788"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 10:40:50 -0700
X-CSE-ConnectionGUID: ikLY6dI3QV64wg6PT8UPgw==
X-CSE-MsgGUID: UanPt+boQNeAlNLKbJnhTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="275222012"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2026 10:40:50 -0700
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
Subject: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the runnable domain
Date: Thu, 10 Sep 2026 10:46:09 -0700
Message-Id: <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
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

Reported-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Closes: https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@xiaomi.com/
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 52 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5989b53adef..b1ef013b0342 100644
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
@@ -2021,6 +2050,10 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p) {}
 
 static void account_llc_dequeue(struct rq *rq, struct task_struct *p) {}
 
+static void pref_llc_running_inc(struct rq *rq, struct task_struct *p) {}
+
+static void pref_llc_running_dec(struct rq *rq, struct task_struct *p) {}
+
 #endif /* CONFIG_SCHED_CACHE */
 
 /*
@@ -6395,6 +6428,14 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
 static void set_delayed(struct sched_entity *se)
 {
+	/*
+	 * Drop a task leaving the runnable set. Must run before sched_delayed
+	 * is set, or task_pref_llc_runnable() would already exclude it;
+	 * clear_delayed() mirrors this after clearing the flag.
+	 */
+	if (entity_is_task(se))
+		pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
+
 	se->sched_delayed = 1;
 
 	/*
@@ -6425,6 +6466,13 @@ static void clear_delayed(struct sched_entity *se)
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

