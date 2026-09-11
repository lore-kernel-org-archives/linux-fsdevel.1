Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9F44F57F
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113521; cv=none; b=aAcZKZ7U1BOv7P0/vtNDdWyBOB4THPHApfWtVdxCwn9JEq63kUhZOKqzVc/IJiR4UMcBwY6HcpZtt8CpZNlzzJiaqygfitG0m3oB/wcS1PuXScRG1tjk5dWv9/99/mgLS11A+IZH61PMVQ3f4RiAtiI0HOajgU9Aod7K+74arGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113521; c=relaxed/simple;
	bh=Go12g+R4uFq+BJOyGZXb1onOnQjq2C3kX1LePEwX1Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMn7dRke8enKKENPk/nU1LoCr6eoATWZ9AEpIrl1JVOEB+3TNA9ipL02BnaoJxr2AsiFHjKfFp0y3BwV/fcK8tyQ/bLGBbtjCmFkQf3yHUtBBL9Ad2+JBlDcwYvM0Zfpwuxr/8EV6tlqOXUl2d3Ivjz7t7YHXacAmJSIg/w0pPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bj8EgRl+; arc=none smtp.client-ip=91.218.175.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bj8EgRl+"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Go12g+R4uFq+BJOyGZXb1onOnQjq2C3kX1LePEwX1Iw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113516; v=1; x=1789718316;
 b=Bj8EgRl+yUSPOzc29VLralzzeQNOPClHk5ZjQDsT+8WDO0b4hdxrz2zyxSj9A72VbLcjf12r
 n0DLAty9h+j133Kae1CWnOeAlx1sUNceOQPjcyu7bvr2eF709R3VhNod36anUnfmnP51muMguJq
 ZITLOa+2orbHrdsZ8d2fcOq0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7120d82fe4ac0fd4;
	Fri, 11 Sep 2026 07:58:35 +0000
X-Mizu-Trace-ID: 7120d82fe4ac0fd4
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christian Brauner <brauner@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	tglx@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 01/15] sched: introduce for_each_process_rculock and for_each_thread_rculock
Date: Fri, 11 Sep 2026 15:57:46 +0800
Message-Id: <20260911075800.491472-2-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260911075800.491472-1-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Introduce for_each_process_rculock(), for_each_thread_rculock() and
for_each_process_thread_rculock() macros that acquire the RCU read
lock before the iteration starts and release it when the loop is left,
so that the RCU read-side critical section is scoped to the loop body
instead of an externally managed rcu_read_lock()/rcu_read_unlock()
pair.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Changes in v3:
  - Indent loop body to show scoped_guard scope (Lorenzo Stoakes)

Changes in v2:
  - Rename macros from *_rcu to *_rculock (Steven Rostedt, Thomas Gleixner)
  - Improve comment on for_each_process_thread_rculock() double loop
  - Change prefix from mm: to sched: (Michal Hocko)
 include/linux/sched/signal.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..ea23c7e9db33 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -663,6 +664,31 @@ extern bool current_is_single_threaded(void);
 #define for_each_process_thread(p, t)	\
 	for_each_process(p) for_each_thread(p, t)
 
+/*
+ * Variants of for_each_process(), for_each_thread() and
+ * for_each_process_thread() that automatically acquire and release the
+ * RCU read lock via scoped_guard(rcu).  The lock is held for the
+ * duration of the loop and released on exit, including via break,
+ * goto, or return.
+ */
+#define for_each_process_rculock(p) \
+	scoped_guard(rcu) \
+		for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+
+#define for_each_thread_rculock(p, t) \
+	scoped_guard(rcu) \
+		__for_each_thread((p)->signal, t)
+
+/*
+ * Double loop: 'break' only exits the inner for_each_thread() loop.
+ * Use 'goto' to exit both loops; the RCU read lock is released
+ * automatically when the scoped_guard scope is left.
+ */
+#define for_each_process_thread_rculock(p, t) \
+	scoped_guard(rcu) \
+		for_each_process(p) \
+			for_each_thread(p, t)
+
 typedef int (*proc_visitor)(struct task_struct *p, void *data);
 void walk_process_tree(struct task_struct *top, proc_visitor, void *);
 
-- 
2.25.1

