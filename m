Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1449F139
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870427; cv=none; b=MoxPH0iqmR5O477Cqz3gsMcwuIeH8KuiTrYzoTtuuniL0Dx2YwcPGa+VZaGOkg3TXyzi/dGcAk0duwFfqtza7K3fgvOpdn0bHkpYXt/qR7btFFwlEAbJG3N9lp62xVy8/zg9VdA3y+JhVapTG6JuHzvwhZj9ZfeSammcIaZBu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870427; c=relaxed/simple;
	bh=I29Os0R0hyQ1NQTq5qpo5BNWrAZgpzaiFVdaMzzBGbQ=;
	h=Cc:Message-Id:To:From:References:Content-Type:Subject:Date:
	 Mime-Version:In-Reply-To; b=VugbT/L2V0SaROXRRDUNXGeWB+U/q61t4OQFumzwZGaq7sLQsg5uIMvfXOJ+PGt+UxN8qZI6W5b1VnOxNUGeuTI9nYwOPFpClv0msJ+j9yTdFs68nXNswPTISQk8zywzEqVFNqjcG/3ZQ+VhlCJNAVkUlABnGpFAjUFjWc77vO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J3hcc8Bm; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J3hcc8Bm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788870419; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jriAg666w9csUkbR5t2/Iux9iPMbescST4uj3QwAtRs=;
 b=J3hcc8BmK5S6Y4seMrz2INpE/yVxPA+sOjwKqZEdtHOvDvLB/Lp09uVrJ2Cu/PLXJSyhCv
 HU9SHP0rvKbwcWx7Nu5aF4346z5HKCBFSGXkIm/1WxxpzR6hgTfl+IE16r02ci8oR3MuHx
 HCb9pY4LGnnG9I8jNe/Kgx3IaYKTmIxQQBaBThu9bUrawshlp0Xn8cUkFz+jGT6lVR4mFM
 kPOkBszsQoYlMIE+UheWboEUFnuggDBAmdmu4rxF712/VY1OkKkDxBtaMPJIW1KZyuEU0y
 8nyyNluRPndUcaCZT0PJCcD6TOQLyCy1PMkmmozRVJiixW8GA151utI7ZffJaw==
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <lizhe.67@bytedance.com>
Message-Id: <20260908122446.56708-4-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, 
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>, 
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, 
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a9fff11+4e4e3f+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3/4] proc: Report process NUMA balancing mode
Date: Tue,  8 Sep 2026 20:24:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260908122446.56708-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

Add NumaB_mode to /proc/<pid>/status so users can inspect the configured
process automatic NUMA balancing mode without issuing a prctl() from the
target process.

The field reports the process mode as enabled or disabled when automatic
NUMA balancing is supported, and unsupported when the kernel is built
without CONFIG_NUMA_BALANCING. Effective behavior still depends on the
global numa_balancing sysctl and memory policy.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 fs/proc/array.c                      | 16 ++++++++++++++++
 include/linux/sched/numa_balancing.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index f6f75d206762..a27a6a57e8b2 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -425,6 +425,21 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+static inline void task_numa_balancing_status(struct seq_file *m,
+					      struct task_struct *task)
+{
+	seq_printf(m, "NumaB_mode:\t%s\n",
+		   task_numa_balancing_mode_name(task));
+}
+#else
+static inline void task_numa_balancing_status(struct seq_file *m,
+					      struct task_struct *task)
+{
+	seq_puts(m, "NumaB_mode:\tunsupported\n");
+}
+#endif
+
 static inline void task_untag_mask(struct seq_file *m, struct mm_struct *mm)
 {
 	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(mm));
@@ -453,6 +468,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 		task_untag_mask(m, mm);
 		mmput(mm);
 	}
+	task_numa_balancing_status(m, task);
 	task_sig(m, task);
 	task_cap(m, task);
 	task_seccomp(m, task);
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index bc413aae5915..69e79359fa22 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -47,6 +47,11 @@ static inline int task_numa_balancing_get_current(void)
 {
 	return task_numa_process_mode_enabled(current);
 }
+
+static inline const char *task_numa_balancing_mode_name(struct task_struct *p)
+{
+	return task_numa_process_mode_enabled(p) ? "enabled" : "disabled";
+}
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu);
 #else
-- 
2.20.1
