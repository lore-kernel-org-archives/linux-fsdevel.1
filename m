Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D96531B00
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870407; cv=none; b=MoLF59GATqlxLNz/DS17ZHj1PHixPc7rclXg2RnL3CvEY6lTRHgv2fX9jQGiL8VN+cFLBVbh/6VQ7jjOMVS26Af8k7jIEVPoqsy7QVhOOWa7jmuyf2eri/E70+0i5kobBAcWUuxScYzE5i3OHCO85SA9IR0Q/063BVBxchPK47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870407; c=relaxed/simple;
	bh=TN7rGqqZ9OR376TXWS3MUze3xcTmiMRRJNOqSnu0G5Q=;
	h=Content-Type:Cc:Mime-Version:To:From:References:In-Reply-To:
	 Subject:Date:Message-Id; b=eqf1BM1NDwCwyo7+2QJZeesSlSX5YEgdVEhNv8dtu/SUESllZ2Pyn7ahMF2v2zqptU2R8OQpPijoPqrgcfM6SSjmtX5Tp8oesG6+RPRBkjWMNrbW3M+wE6/J7Uj9DFISjjYcz16OfH7oMVms67xNN/dmh1cSWgxaFRTMHzda+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BTzGz8RR; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BTzGz8RR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788870400; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=j33x67pAIPEvtU7LsKxL/lIGzZa4GlqosjlcpBVmf4g=;
 b=BTzGz8RRpWuVcr8EKWpkSwI3cIr99NYmZ3nn89gU413ahc8ehjOw08V+Ctpei92RK8e5U0
 +lCoenJSYb0IUJ+f7NOGcKNzEdWlseqvO/CfFadgb6EsQqwZKZEkmapPgauKmRgvftwHPt
 o/KsnN2Jelvh5RhE35FaQe9l9x3zNOvY6lIDpP6xtujwzbMjDIljn61dSWjZG9GIZIIriI
 9jdlcBfWwPidUOfTnnoFu9/BMgTcFyIIbEiHIh1Mqlg49kKJ7IYO7ylfM08M+AJMCNvwGH
 BVvFY/vlyg7EQA/XytrVBCh1RrcWPTXa0la9tML9scg29MD2gXaGOhpkYZ9glQ==
X-Lms-Return-Path: <lba+26a9ffefe+81d787+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, 
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>, 
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, 
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
In-Reply-To: <20260908122446.56708-1-lizhe.67@bytedance.com>
Subject: [PATCH 2/4] sched/numa: Add prctl controls for process mode
Date: Tue,  8 Sep 2026 20:24:44 +0800
Message-Id: <20260908122446.56708-3-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit

Expose the process automatic NUMA balancing mode through prctl().
PR_SET_NUMA_BALANCING accepts PR_NUMA_BALANCING_DISABLE to opt the whole
thread group out of future NUMA scanning and PR_NUMA_BALANCING_ENABLE to
allow it to participate again when global NUMA balancing and memory
policy permit it.

PR_GET_NUMA_BALANCING returns the configured process mode, not the
effective state after combining the global sysctl/static key and memory
policy restrictions. This keeps the ABI weak and predictable: a process
can observe and restore the value it configured, while administrators
retain kernel.numa_balancing as the top-level hard-off switch.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 include/uapi/linux/prctl.h |  6 ++++++
 kernel/sys.c               | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b6ec6f693719..5bc0a2a2a930 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -416,4 +416,10 @@ struct prctl_mm_map {
 # define PR_CFI_DISABLE		_BITUL(1)
 # define PR_CFI_LOCK		_BITUL(2)
 
+/* Per-process automatic NUMA balancing control */
+#define PR_SET_NUMA_BALANCING	82
+#define PR_GET_NUMA_BALANCING	83
+# define PR_NUMA_BALANCING_DISABLE	0
+# define PR_NUMA_BALANCING_ENABLE	1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 35b538ba843c..fb01841c0ce9 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -60,6 +60,7 @@
 #include <linux/sched/stat.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
 #include <linux/rcupdate.h>
@@ -2907,6 +2908,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
 			error = arch_prctl_lock_branch_landing_pad_state(me);
 		break;
+	case PR_SET_NUMA_BALANCING:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		if (arg2 != PR_NUMA_BALANCING_DISABLE &&
+		    arg2 != PR_NUMA_BALANCING_ENABLE)
+			return -EINVAL;
+		error = task_numa_balancing_set_current(arg2 ==
+							 PR_NUMA_BALANCING_ENABLE);
+		break;
+	case PR_GET_NUMA_BALANCING:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = task_numa_balancing_get_current();
+		if (error >= 0)
+			error = error ? PR_NUMA_BALANCING_ENABLE :
+				PR_NUMA_BALANCING_DISABLE;
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
-- 
2.20.1
