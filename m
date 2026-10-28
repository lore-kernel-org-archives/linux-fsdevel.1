Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205414;
	b=Dr5CNnUjZwGpphMAr66biMFgx752BA770ZY6RJpqW6TyxLaXu29Q/Gu8GmFidTU+ZIaw
	 Q7oNq442/IYSzKgEuqITfLr1j87EvZfcvZWaAWkhNXVlmEQjdmwaM7wBM6L6tWwvJdVMv
	 Y95lDckNOPaJp4f8Gd7o2v1U4lwxVa/0/8DTKn2mV257ggDNngi+F4Az/yqOOz9n/6JBQ
	 0EVgfgG3AHpBPc9vXrewlCRjUUnpB7bXZPZ7ytK3yPi3K33CWkxpnL3mqSCkWLr0NR1Ca
	 dw99B02/jectksVLcUmm1pP2HaIR7ULdMmZIwrG29B5heSwTojcWZ9zORUztghQEinA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205414;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FIl7ruf+LcsMNbrnPcp7XWAsLPsaVuVtnmfesGlH1vw=;
	b=jTSDOJznFpEB49hBpxjBMecmYc+oIhmAFYwBkg1Kwodgz9DL1C0jBw4DOKhY7M3fWBpu
	 Sp8KtAQX+fq7pj67UQOcBBCbJQD2kLsvXThfN4bp7uvJgqhm1JSSC4j9qemJ+hqEaKkiT
	 MFjBKpaUnFwmqLwrX/iPSNXeKdHNkZ3XHHyqK1A5v4FK28SQt1hYKs//nxLW8AEaczUiI
	 K7ZoTPYCrQwBcT3LqLcUzERmTd3iaJvPiiVCMC310toGpaGWyZISFXMNSp4wn8db4O9GG
	 gNpSF1uxlP+taAIg0lSWL5p64iLhOh08hSZax2/+cRPICNqvBm9MECd6zkwxuOg6t+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Njfn/BOF";
	arc=none smtp.remote-ip=95.215.58.18
Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B814606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B814606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Njfn/BOF
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zxGcKRrrv75Hp8kcNLMHNOX80IhvZgP3YbNGBHHnS8U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205411; v=1; x=1793810211;
 b=Njfn/BOFWHIevbMvlBffyOFOiUMeVX5kuwVxcp35KvVxei0xM/CFW/vJoXet58auqqDY07id
 rJd+E4oVWD2gB3DAo3U1oOzdjlYDgcK84pl+iRWkgbewT5QlXtO4XIGi4bji1H3dWJZPRHh5nLr
 rRld9Pm+s9kf+nrnSIkdCkBA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2affc4003a5a2fd4;
	Wed, 28 Oct 2026 16:36:51 +0000
X-Mizu-Trace-ID: 2affc4003a5a2fd4
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/39] sysctl: store kernel sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:51 +0800
Message-Id: <a64eb044ae56f475bea789944dc6e693c2216c38.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Replace kernel bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/bpf/syscall.c      |  8 ++++----
 kernel/delayacct.c        |  4 ++--
 kernel/events/callchain.c |  9 ++++-----
 kernel/events/core.c      |  7 ++++---
 kernel/hung_task.c        | 30 +++++++++++++++++-------------
 kernel/kexec_core.c       |  4 ++--
 kernel/kprobes.c          |  4 ++--
 kernel/kstack_erase.c     |  4 ++--
 kernel/module/main.c      |  4 ++--
 kernel/panic.c            | 13 +++++++++----
 kernel/printk/sysctl.c    | 22 ++++++++++------------
 kernel/rcu/tree_stall.h   |  9 +++++----
 kernel/sched/autogroup.c  |  4 ++--
 kernel/sched/core.c       |  8 ++++----
 kernel/sched/fair.c       |  6 ++++--
 kernel/sched/topology.c   |  4 ++--
 kernel/sys.c              |  8 ++++----
 kernel/time/timer.c       |  4 ++--
 kernel/ucount.c           |  7 ++-----
 kernel/watchdog.c         | 35 +++++++++++++++++------------------
 20 files changed, 100 insertions(+), 94 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 90bc7230afa8..8b079e220f00 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6764,8 +6764,8 @@ static int bpf_stats_handler(const struct ctl_table *table, int write,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
-		.extra2 = SYSCTL_ONE,
+		.min    = 0,
+		.max    = 1,
 	};
 
 	if (write && !capable(CAP_SYS_ADMIN))
@@ -6820,8 +6820,8 @@ static const struct ctl_table bpf_syscall_table[] = {
 		.maxlen		= sizeof(sysctl_unprivileged_bpf_disabled),
 		.mode		= 0644,
 		.proc_handler	= bpf_unpriv_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "bpf_stats_enabled",
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 479e860aff70..e942f118b5a8 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -82,8 +82,8 @@ static const struct ctl_table kern_delayacct_table[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = sysctl_delayacct,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min            = 0,
+		.max            = 1,
 	},
 };
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 9d24b6e0c91f..0990eb237834 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -22,7 +22,6 @@ struct callchain_cpus_entries {
 
 int sysctl_perf_event_max_stack __read_mostly = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack __read_mostly = PERF_MAX_CONTEXTS_PER_STACK;
-static const int six_hundred_forty_kb = 640 * 1024;
 
 static inline size_t perf_callchain_entry__sizeof(void)
 {
@@ -307,8 +306,8 @@ static const struct ctl_table callchain_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&six_hundred_forty_kb,
+		.min		= 0,
+		.max		= 640 * 1024,
 	},
 	{
 		.procname	= "perf_event_max_contexts_per_stack",
@@ -316,8 +315,8 @@ static const struct ctl_table callchain_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
+		.min		= 0,
+		.max		= 1000,
 	},
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..339a200f8b00 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -595,7 +595,8 @@ static const struct ctl_table events_core_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_sample_rate_handler,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "perf_cpu_time_max_percent",
@@ -603,8 +604,8 @@ static const struct ctl_table events_core_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
 		.mode		= 0644,
 		.proc_handler	= perf_cpu_time_max_percent_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	},
 };
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b8554aedc589..88e260d623ff 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/limits.h>
 #include <linux/cpu.h>
 #include <linux/nmi.h>
 #include <linux/init.h>
@@ -462,11 +463,6 @@ static int proc_dohung_task_warnings(const struct ctl_table *table, int write,
 	return ret;
 }
 
-/*
- * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
- * and hung_task_check_interval_secs
- */
-static const unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
 static const struct ctl_table hung_task_sysctls[] = {
 #ifdef CONFIG_SMP
 	{
@@ -475,8 +471,8 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif /* CONFIG_SMP */
 	{
@@ -485,8 +481,8 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "hung_task_check_count",
@@ -494,7 +490,8 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "hung_task_timeout_secs",
@@ -502,7 +499,9 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_dohung_task_timeout_secs,
-		.extra2		= (void *)&hung_task_timeout_max,
+		.min		= 0,
+		/* Keep the timeout's jiffies conversion within a signed long. */
+		.max		= LONG_MAX / HZ,
 	},
 	{
 		.procname	= "hung_task_check_interval_secs",
@@ -510,7 +509,9 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_dohung_task_timeout_secs,
-		.extra2		= (void *)&hung_task_timeout_max,
+		.min		= 0,
+		/* Keep the timeout's jiffies conversion within a signed long. */
+		.max		= LONG_MAX / HZ,
 	},
 	{
 		.procname	= "hung_task_warnings",
@@ -518,13 +519,16 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dohung_task_warnings,
-		.extra1		= SYSCTL_NEG_ONE,
+		.min		= (unsigned long)-1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "hung_task_detect_count",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_dohung_task_detect_count,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "hung_task_sys_info",
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f4a31565c447..618aa15f27f5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1097,8 +1097,8 @@ static const struct ctl_table kexec_core_sysctls[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= 1,
 	},
 	{
 		.procname	= "kexec_load_limit_panic",
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2441b9e39343..b098d6a7c89b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1242,8 +1242,8 @@ static const struct ctl_table kprobe_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_kprobes_optimization_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/kernel/kstack_erase.c b/kernel/kstack_erase.c
index d4449884084c..e44d6e626aec 100644
--- a/kernel/kstack_erase.c
+++ b/kernel/kstack_erase.c
@@ -52,8 +52,8 @@ static const struct ctl_table stackleak_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= stack_erasing_sysctl,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..7b101cb0d918 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -146,8 +146,8 @@ static const struct ctl_table module_sysctl_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= 1,
 	},
 };
 
diff --git a/kernel/panic.c b/kernel/panic.c
index b824b68fcb08..901322b1eacf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -10,6 +10,7 @@
  * to indicate a major problem.
  */
 #include <linux/debug_locks.h>
+#include <linux/limits.h>
 #include <linux/sched/debug.h>
 #include <linux/interrupt.h>
 #include <linux/kgdb.h>
@@ -148,8 +149,8 @@ static const struct ctl_table kern_panic_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min            = 0,
+		.max            = 1,
 	},
 #endif
 	{
@@ -157,6 +158,8 @@ static const struct ctl_table kern_panic_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_taint,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "panic",
@@ -178,6 +181,8 @@ static const struct ctl_table kern_panic_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= sysctl_panic_print_handler,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "panic_on_warn",
@@ -185,8 +190,8 @@ static const struct ctl_table kern_panic_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname       = "warn_limit",
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f15732e93c2e..79b1fc60aa91 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -8,10 +8,8 @@
 #include <linux/ratelimit.h>
 #include "internal.h"
 
-static const int ten_thousand = 10000;
-
-static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_range_sysadmin(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -47,8 +45,8 @@ static const struct ctl_table printk_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&ten_thousand,
+		.min		= 0,
+		.max		= 10000,
 	},
 	{
 		.procname	= "printk_devkmsg",
@@ -62,18 +60,18 @@ static const struct ctl_table printk_sysctls[] = {
 		.data		= &dmesg_restrict,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.proc_handler	= proc_dointvec_range_sysadmin,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "kptr_restrict",
 		.data		= &kptr_restrict,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.proc_handler	= proc_dointvec_range_sysadmin,
+		.min		= 0,
+		.max		= 2,
 	},
 };
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 803a56af3259..e5a230514a86 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/console.h>
+#include <linux/limits.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 #include <linux/smp.h>
@@ -29,8 +30,8 @@ static const struct ctl_table rcu_stall_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "max_rcu_stall_to_panic",
@@ -38,8 +39,8 @@ static const struct ctl_table rcu_stall_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index e380cf9372bb..3198fe47efb8 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -19,8 +19,8 @@ static const struct ctl_table sched_autogroup_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min            = 0,
+		.max            = 1,
 	},
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..293f4cc423ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4823,8 +4823,8 @@ static const struct ctl_table sched_core_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = sysctl_schedstats,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min            = 0,
+		.max            = 1,
 	},
 #endif /* CONFIG_SCHEDSTATS */
 #ifdef CONFIG_UCLAMP_TASK
@@ -4857,8 +4857,8 @@ static const struct ctl_table sched_core_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_FOUR,
+		.min		= 0,
+		.max		= 4,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfc982205b98..3956f35927bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -145,7 +145,8 @@ static const struct ctl_table sched_fair_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
+		.min            = 1,
+		.max            = INT_MAX,
 	},
 #endif
 #ifdef CONFIG_NUMA_BALANCING
@@ -155,7 +156,8 @@ static const struct ctl_table sched_fair_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 };
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 919d0fb00bd9..caaba36abdd4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -319,8 +319,8 @@ static const struct ctl_table sched_energy_aware_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = sched_energy_aware_handler,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min            = 0,
+		.max            = 1,
 	},
 };
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 755bfa5ccd92..676ffca63a05 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -188,8 +188,8 @@ static const struct ctl_table overflow_sysctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
+		.min		= 0,
+		.max		= 65535,
 	},
 	{
 		.procname	= "overflowgid",
@@ -197,8 +197,8 @@ static const struct ctl_table overflow_sysctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
+		.min		= 0,
+		.max		= 65535,
 	},
 };
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a3c4e20a4e36..8cb0c3cad455 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -309,8 +309,8 @@ static const struct ctl_table timer_sysctl[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= timer_migration_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/kernel/ucount.c b/kernel/ucount.c
index ec8b1445e287..8c7738f240ec 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -61,17 +61,14 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static long ue_zero = 0;
-static long ue_int_max = INT_MAX;
-
 #define UCOUNT_ENTRY(name)					\
 	{							\
 		.procname	= name,				\
 		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
 		.proc_handler	= proc_doulongvec_minmax,	\
-		.extra1		= &ue_zero,			\
-		.extra2		= &ue_int_max,			\
+		.min		= 0,				\
+		.max		= INT_MAX,			\
 	}
 static const struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 64da2e500144..f440522707ec 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) "watchdog: " fmt
 
 #include <linux/cpu.h>
+#include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
@@ -1213,8 +1214,6 @@ static int proc_watchdog_cpumask(const struct ctl_table *table, int write,
 	return err;
 }
 
-static const int sixty = 60;
-
 static const struct ctl_table watchdog_sysctls[] = {
 	{
 		.procname       = "watchdog",
@@ -1222,8 +1221,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "watchdog_thresh",
@@ -1231,8 +1230,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_watchdog_thresh,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&sixty,
+		.min		= 0,
+		.max		= 60,
 	},
 	{
 		.procname	= "watchdog_cpumask",
@@ -1248,8 +1247,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_soft_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "softlockup_panic",
@@ -1257,8 +1256,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "softlockup_sys_info",
@@ -1274,8 +1273,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -1286,8 +1285,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "hardlockup_sys_info",
@@ -1303,8 +1302,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -1314,8 +1313,8 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_nmi_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
-- 
2.25.1

