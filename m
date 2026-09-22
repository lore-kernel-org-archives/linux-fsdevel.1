Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193931E824;
	Tue, 22 Sep 2026 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037135; cv=none; b=uD2x7PTda8UbC2DEc2iVTtz8mLF4pH0P6Tv7MdrgGsJe45VpTAF2MekTwxwWJM5F6YlbVVd8dskAV4Xlj33m2ti/++PTaM+7tdhK62BgU2/82MuoPNXkM5f/nX/0Smc4m2KUu8pSw4UOd6BH/tBxkT8L7lIahMzCS3P5PL5RPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037135; c=relaxed/simple;
	bh=3SNad8cSGX/yLWI8E3JE9cy9dkKCeA1Qu3xf/C4B2+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvySleftWDs8uPNxhl+iAR3lukcKRVk2KuTe6vB7BM67/tTJPcpXgU2xiY1eK827oGuu3t06s2hcIpYYTNjnXeaw2u+TqgmxPfGZBg2wilYUcNykHBiMl1ZZxMtWvFdvheBXThd6tI57ll6EWkv0SK2IoYOIBj0qJZSzoOWM80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp8cMHpM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mp8cMHpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790037134; x=1821573134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SNad8cSGX/yLWI8E3JE9cy9dkKCeA1Qu3xf/C4B2+Q=;
  b=mp8cMHpMPkuFeW8D2S78kLhkxTVDMdV7YGOM0IUbizQmBh8yp17gsqxG
   xQ4bCO7fCs7Cbhp8taQxTVM78s+vLgPP+lDrzID9sRvqQR2FXehZs49D6
   vmtyxTduULowF4YMOrHBIrViKtW3PUW2SmpCvUpjMaMOhrW5jCPuvnYl/
   8G6gzqWpJrWD2O2KJ3O06UugNx8DTX56ZaaDRhZPcz3jkgdBfH1s3K1Bh
   KPJh5ep2lmWUwS9oQ7PNlhHA6m+WiIqp9819w1AVt6+H11Q/cw3FxQF00
   ViYFlKFU2yWYYnvFLukk9Gp8uk13jXycE5Oi79AMbkkvtCsA09vXat0F5
   w==;
X-CSE-ConnectionGUID: QBPprYNYS8ichcCwp4eANA==
X-CSE-MsgGUID: Vb/KKmTWSLOqJhsE6zmTdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90716655"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90716655"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:32:13 -0700
X-CSE-ConnectionGUID: 4p7YC+7bQ++tsxep43jVwA==
X-CSE-MsgGUID: xD69XWy0QB2tetf9x/f/Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277671840"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 17:32:12 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Lu Wang <wanglu.priv@gmail.com>,
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
	Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v2 2/6] sched/cache: Honor migrate_llc_task semantics in active load balance
Date: Mon, 21 Sep 2026 17:37:23 -0700
Message-Id: <cb39f64a17fc2b76097264aaec74a2d6dfff4315.1790035273.git.tim.c.chen@linux.intel.com>
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

From: Lu Wang <wanglu.priv@gmail.com>

CAS introduced the migrate_llc_task migration type to direct tasks
toward their preferred LLC, but its semantics can be lost when passive
load balance falls back to active load balance. This may allow ALB to
select a candidate whose preferred LLC does not match the destination,
moving it away from its preferred LLC.

Example scenario:

src_rq has two runnable tasks, p1 and p2. p1 prefers dst_rq (dst_llc),
while p2 prefers src_rq (src_llc). In this case, migrate_llc_task is
set because src_rq has at least one task, p1, that wants to migrate to
dst_rq. In ALB, can_migrate_task() finds p2 and returns true for it,
thus moving p2 out of its preferred LLC.

Solution:

The CPU stopper in ALB constructs a fresh lb_env that does not inherit
migration_type from the passive load-balance pass. Two approaches are
possible:

(a) Add a new member to struct rq so ALB can inherit migrate_llc_task
    from the passive LB that triggered it.

(b) Define a new flag LBF_ACTIVE_LB_LLC and select the stopper callback
    at kick time to preserve the migration semantics across the
    asynchronous boundary.

We choose (b) because it avoids passing migration_type through the
stopper, which would affect the meaning of migration_type for
delayed-dequeue tasks.

Fixes: e4c9a4cb244a ("sched/cache: Add migrate_llc_task migration type for cache-aware balancing")
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lu Wang <wanglu.priv@gmail.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Cc: stable@kernel.org #7.2.x
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 57 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19765ee1af83..6f1939d17e9e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10453,6 +10453,7 @@ enum migration_type {
 #define LBF_SOME_PINNED	0x08
 #define LBF_ACTIVE_LB	0x10
 #define LBF_LLC_PINNED	0x20
+#define LBF_ACTIVE_LB_LLC	0x40
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -10871,6 +10872,21 @@ alb_break_llc(struct lb_env *env)
 	return false;
 }
 
+/*
+ * Returns true if p's preferred LLC does not match the destination CPU
+ * under migrate_llc_task semantics. Passive LB passes migrate_llc_task
+ * in env->migration_type, while active LB carries LBF_ACTIVE_LB_LLC in
+ * env->flags to avoid overwriting env->migration_type.
+ */
+static inline bool
+migrate_llc_task_wrong_dst(struct task_struct *p, struct lb_env *env)
+{
+	return sched_cache_enabled() &&
+	       (env->migration_type == migrate_llc_task ||
+		env->flags & LBF_ACTIVE_LB_LLC) &&
+	       READ_ONCE(p->preferred_llc) != llc_id(env->dst_cpu);
+}
+
 /*
  * Check if migrating task p from env->src_cpu to
  * env->dst_cpu breaks LLC localiy.
@@ -10899,8 +10915,7 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 	 * run on env->dst_cpu, skip the tasks do not prefer
 	 * env->dst_cpu, and find the one that prefers.
 	 */
-	if (env->migration_type == migrate_llc_task &&
-	    READ_ONCE(p->preferred_llc) != llc_id(env->dst_cpu))
+	if (migrate_llc_task_wrong_dst(p, env))
 		return true;
 
 	if (can_migrate_llc_task(env, p) != mig_forbid)
@@ -10922,6 +10937,12 @@ alb_break_llc(struct lb_env *env)
 	return false;
 }
 
+static inline bool
+migrate_llc_task_wrong_dst(struct task_struct *p, struct lb_env *env)
+{
+	return false;
+}
+
 static inline bool
 migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 {
@@ -11021,7 +11042,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * 4) too many balance attempts have failed.
 	 */
 	if (env->flags & LBF_ACTIVE_LB)
-		return 1;
+		return !migrate_llc_task_wrong_dst(p, env);
 
 	degrades = migrate_degrades_locality(p, env);
 	if (!degrades) {
@@ -13420,6 +13441,20 @@ static int need_active_balance(struct lb_env *env)
 }
 
 static int active_load_balance_cpu_stop(void *data);
+static int active_load_balance_llc_cpu_stop(void *data);
+
+/*
+ * migration_type is checked elsewhere to decide migration policy, so
+ * it shouldn't be repurposed just to flag an LLC-directed active
+ * balance across the stopper. Pick the callback here instead.
+ */
+static inline cpu_stop_fn_t alb_stop_fn(struct lb_env *env)
+{
+	if (env->migration_type == migrate_llc_task)
+		return active_load_balance_llc_cpu_stop;
+
+	return active_load_balance_cpu_stop;
+}
 
 static int should_we_balance(struct lb_env *env)
 {
@@ -13765,7 +13800,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	}
 	if (active_balance) {
 		stop_one_cpu_nowait(cpu_of(busiest),
-				    active_load_balance_cpu_stop, busiest,
+				    alb_stop_fn(&env), busiest,
 				    &busiest->active_balance_work);
 	}
 	preempt_enable();
@@ -13870,7 +13905,7 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
  * least 1 task to be running on each physical CPU where possible, and
  * avoids physical / logical imbalances.
  */
-static int active_load_balance_cpu_stop(void *data)
+static int __active_load_balance_cpu_stop(void *data, unsigned int lb_flags)
 {
 	struct rq *busiest_rq = data;
 	int busiest_cpu = cpu_of(busiest_rq);
@@ -13920,7 +13955,7 @@ static int active_load_balance_cpu_stop(void *data)
 			.src_cpu	= busiest_rq->cpu,
 			.src_rq		= busiest_rq,
 			.idle		= CPU_IDLE,
-			.flags		= LBF_ACTIVE_LB,
+			.flags		= LBF_ACTIVE_LB | lb_flags,
 		};
 
 		schedstat_inc(sd->alb_count);
@@ -13948,6 +13983,16 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
+static int active_load_balance_cpu_stop(void *data)
+{
+	return __active_load_balance_cpu_stop(data, 0);
+}
+
+static int active_load_balance_llc_cpu_stop(void *data)
+{
+	return __active_load_balance_cpu_stop(data, LBF_ACTIVE_LB_LLC);
+}
+
 /*
  * Scale the max sched_balance_rq interval with the number of CPUs in the system.
  * This trades load-balance latency on larger machines for less cross talk.
-- 
2.32.0

