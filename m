Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205418;
	b=j/Iv8qcEXujz6OFtocwnnkDRAXwoz2V12UQvXT0UhzIqXJbFP/WJdvvhWqDZpwEKMF9e
	 9yvLmuGnkKagemRy8JRr4/mWFgHjLFokGlvvQHHUIqL6lHHtHKp63w5JpvfzvI88U2Qnm
	 vOC8HJlUxTlHIHi8zWNL24FO47g4qORK99KsaTYCgFFofcAqOcrrrcRhVxfBGutAVtodq
	 1u1t9m5QKSOjm+jwa8UJPVhHMzrXkibhbiNwZ79rgs6zy0i6jb2A22Bid1h6ed0IRgqM0
	 vxfM6n9jOYq7lCrlexJyZN+KNqiJSWWi1WLRL9qOREr1K/YiSz0d3NF5keB9zAVr8Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205418;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HIKq9RoG/3QITYMT9UVPtO28n54Bj7gh9835XsasMTI=;
	b=fcugmJXZuG0XrdiVCvedGNnBxVdB6jCE+I4SaqVIvgg+uC7AR24IveQG9ESoFv2HH/XJ
	 RefwNgmPHKt8EwBkmpvn7V3C46HJidCONlURCkGMXkETeGjR9uYGtSWv5CtTjDc6xrfUH
	 6DCgKJPdq+DRQHNbMnUbHWA4XhSL4FXWpDZzIbbmOJrlvQq0HehxQKQaJRRNYfqZsrxTF
	 Oh9IL8GYfQ84EbjsTQI3CjhUeTqCWpHH3TIKWjOqBmtaRrXiNQSRGRVoLQhhXjappqIq/
	 2RHln9ZK5a70w3Dd87c9YHJYgrli2lgI58/MEzwX/Jo2aDXhHkMyZADTbj5Zb2shCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jePRe8jc;
	arc=none smtp.remote-ip=91.218.175.30
Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B21606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B21606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jePRe8jc
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W5RDBdMaPaoiB0Xsoly4/NjS02lT8U6Dp0YqC/9dqmg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205416; v=1; x=1793810216;
 b=jePRe8jcpw4yBqR/B9JvwMGAG9rOYsWQXLsDL2qarj6VMdAOO7EwJ2Li8mobzkNbuCCPFeGP
 6Sqdc/Vunj2kUgAGRXl1wR3XoFcPy/U6migNYYJ1LyIzB0gVXF2vCsNH3GMBgKOfZnPQR+7K/vm
 +uZ3+7m+8gUSIOUbgcrh7MnQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 3b99eab4926558dc;
	Wed, 28 Oct 2026 16:36:56 +0000
X-Mizu-Trace-ID: 3b99eab4926558dc
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/39] sysctl: store memory-management sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:52 +0800
Message-Id: <3ecdfc9e008c95fc25b71d57d909549b19550eb6.1793204511.git.wen.yang@linux.dev>
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

Use numeric memory-management bounds, refreshing mmap limits at runtime.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 mm/compaction.c     | 19 ++++++++++---------
 mm/filemap.c        |  4 +++-
 mm/memory-failure.c | 16 ++++++++--------
 mm/mmap.c           | 28 +++++++++++++++++++++-------
 mm/nommu.c          |  4 +++-
 mm/oom_kill.c       |  4 ++--
 mm/page-writeback.c | 25 +++++++++++++------------
 mm/page_alloc.c     | 28 ++++++++++++++++------------
 mm/swap_state.c     |  5 ++---
 mm/userfaultfd.c    |  4 ++--
 mm/util.c           |  7 ++++---
 mm/vmscan.c         |  8 +++++---
 mm/vmstat.c         |  4 ++--
 13 files changed, 91 insertions(+), 65 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f1b2060eb201..6c3a3d08e42a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3296,8 +3296,9 @@ void __meminit kcompactd_stop(int nid)
 	}
 }
 
-static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_range_warn_RT_change(const struct ctl_table *table,
+					      int write, void *buffer,
+					      size_t *lenp, loff_t *ppos)
 {
 	int ret, old;
 
@@ -3329,8 +3330,8 @@ static const struct ctl_table vm_compaction[] = {
 		.maxlen		= sizeof(sysctl_compaction_proactiveness),
 		.mode		= 0644,
 		.proc_handler	= compaction_proactiveness_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	},
 	{
 		.procname	= "extfrag_threshold",
@@ -3338,17 +3339,17 @@ static const struct ctl_table vm_compaction[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
+		.min		= 0,
+		.max		= 1000,
 	},
 	{
 		.procname	= "compact_unevictable_allowed",
 		.data		= &sysctl_compact_unevictable_allowed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.proc_handler	= proc_dointvec_range_warn_RT_change,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..b465bfee3782 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -11,6 +11,7 @@
  * the NFS filesystem used to do this differently, for example)
  */
 #include <linux/export.h>
+#include <linux/limits.h>
 #include <linux/compiler.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
@@ -1086,7 +1087,8 @@ static const struct ctl_table filemap_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_page_lock_unfairness),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	}
 };
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b705f9f97f42..5c5c7ec329b7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -178,8 +178,8 @@ static const struct ctl_table memory_failure_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_early_kill),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "memory_failure_recovery",
@@ -187,8 +187,8 @@ static const struct ctl_table memory_failure_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_recovery),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "enable_soft_offline",
@@ -196,8 +196,8 @@ static const struct ctl_table memory_failure_table[] = {
 		.maxlen		= sizeof(sysctl_enable_soft_offline),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "panic_on_unrecoverable_memory_failure",
@@ -205,8 +205,8 @@ static const struct ctl_table memory_failure_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_unrecoverable_mf),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	}
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 148ba01c0373..bc1ad6431bf9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
@@ -1493,6 +1494,17 @@ struct vm_area_struct *_install_special_mapping(
 int sysctl_legacy_va_layout;
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
+static int mmap_rnd_bits_handler(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.max = mmap_rnd_bits_max;
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+#endif
+
 static const struct ctl_table mmap_table[] = {
 		{
 				.procname       = "max_map_count",
@@ -1500,7 +1512,8 @@ static const struct ctl_table mmap_table[] = {
 				.maxlen         = sizeof(sysctl_max_map_count),
 				.mode           = 0644,
 				.proc_handler   = proc_dointvec_minmax,
-				.extra1         = SYSCTL_ZERO,
+				.min            = 0,
+				.max            = INT_MAX,
 		},
 #if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
 		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
@@ -1510,7 +1523,8 @@ static const struct ctl_table mmap_table[] = {
 				.maxlen         = sizeof(sysctl_legacy_va_layout),
 				.mode           = 0644,
 				.proc_handler   = proc_dointvec_minmax,
-				.extra1         = SYSCTL_ZERO,
+				.min            = 0,
+				.max            = INT_MAX,
 		},
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
@@ -1519,9 +1533,9 @@ static const struct ctl_table mmap_table[] = {
 				.data           = &mmap_rnd_bits,
 				.maxlen         = sizeof(mmap_rnd_bits),
 				.mode           = 0600,
-				.proc_handler   = proc_dointvec_minmax,
-				.extra1         = (void *)&mmap_rnd_bits_min,
-				.extra2         = (void *)&mmap_rnd_bits_max,
+				.proc_handler   = mmap_rnd_bits_handler,
+				.min            = CONFIG_ARCH_MMAP_RND_BITS_MIN,
+				.max            = CONFIG_ARCH_MMAP_RND_BITS_MAX,
 		},
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
@@ -1531,8 +1545,8 @@ static const struct ctl_table mmap_table[] = {
 				.maxlen         = sizeof(mmap_rnd_compat_bits),
 				.mode           = 0600,
 				.proc_handler   = proc_dointvec_minmax,
-				.extra1         = (void *)&mmap_rnd_compat_bits_min,
-				.extra2         = (void *)&mmap_rnd_compat_bits_max,
+				.min            = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN,
+				.max            = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX,
 		},
 #endif
 };
diff --git a/mm/nommu.c b/mm/nommu.c
index bc87946e5cc2..3c1a7a9765a5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/export.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
 #include <linux/mman.h>
@@ -411,7 +412,8 @@ static const struct ctl_table nommu_table[] = {
 		.maxlen		= sizeof(sysctl_nr_trim_pages),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5d48bd862c27..6bb4e5a1b419 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -696,8 +696,8 @@ static const struct ctl_table vm_oom_kill_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_oom),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "oom_kill_allocating_task",
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0694ec4098f6..40fdc2d698d9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -2227,9 +2228,6 @@ static int laptop_mode_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
-/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
-static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
-
 static const struct ctl_table vm_page_writeback_sysctls[] = {
 	{
 		.procname   = "dirty_background_ratio",
@@ -2237,8 +2235,8 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen     = sizeof(dirty_background_ratio),
 		.mode       = 0644,
 		.proc_handler   = dirty_background_ratio_handler,
-		.extra1     = SYSCTL_ZERO,
-		.extra2     = SYSCTL_ONE_HUNDRED,
+		.min            = 0,
+		.max            = 100,
 	},
 	{
 		.procname   = "dirty_background_bytes",
@@ -2246,7 +2244,8 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen     = sizeof(dirty_background_bytes),
 		.mode       = 0644,
 		.proc_handler   = dirty_background_bytes_handler,
-		.extra1     = SYSCTL_LONG_ONE,
+		.min            = 1,
+		.max            = ULONG_MAX,
 	},
 	{
 		.procname   = "dirty_ratio",
@@ -2254,8 +2253,8 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen     = sizeof(vm_dirty_ratio),
 		.mode       = 0644,
 		.proc_handler   = dirty_ratio_handler,
-		.extra1     = SYSCTL_ZERO,
-		.extra2     = SYSCTL_ONE_HUNDRED,
+		.min            = 0,
+		.max            = 100,
 	},
 	{
 		.procname   = "dirty_bytes",
@@ -2263,7 +2262,8 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen     = sizeof(vm_dirty_bytes),
 		.mode       = 0644,
 		.proc_handler   = dirty_bytes_handler,
-		.extra1     = (void *)&dirty_bytes_min,
+		.min            = 2 * PAGE_SIZE,
+		.max            = ULONG_MAX,
 	},
 	{
 		.procname   = "dirty_writeback_centisecs",
@@ -2278,7 +2278,8 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen     = sizeof(dirty_expire_interval),
 		.mode       = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1     = SYSCTL_ZERO,
+		.min            = 0,
+		.max            = INT_MAX,
 	},
 #ifdef CONFIG_HIGHMEM
 	{
@@ -2287,8 +2288,8 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.maxlen		= sizeof(vm_highmem_is_dirtyable),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	{
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2b2855300217..956acbe7e5bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6933,7 +6933,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(min_free_kbytes),
 		.mode		= 0644,
 		.proc_handler	= min_free_kbytes_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "watermark_boost_factor",
@@ -6941,7 +6942,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(watermark_boost_factor),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "watermark_scale_factor",
@@ -6949,8 +6951,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(watermark_scale_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_THREE_THOUSAND,
+		.min		= 1,
+		.max		= 3000,
 	},
 	{
 		.procname	= "defrag_mode",
@@ -6958,8 +6960,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(defrag_mode),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "percpu_pagelist_high_fraction",
@@ -6967,7 +6969,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(percpu_pagelist_high_fraction),
 		.mode		= 0644,
 		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "lowmem_reserve_ratio",
@@ -6975,7 +6978,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_lowmem_reserve_ratio),
 		.mode		= 0644,
 		.proc_handler	= lowmem_reserve_ratio_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 #ifdef CONFIG_NUMA
 	{
@@ -6991,8 +6995,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_min_unmapped_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	},
 	{
 		.procname	= "min_slab_ratio",
@@ -7000,8 +7004,8 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_min_slab_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	},
 #endif
 };
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d9e36c505398..1097ba48b8b1 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -30,7 +30,6 @@
 
 /* Swap readahead cluster size, as a power of 2 pages. */
 static int page_cluster;
-static const int page_cluster_max = 31;
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
@@ -1071,8 +1070,8 @@ static const struct ctl_table swap_readahead_sysctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&page_cluster_max,
+		.min		= 0,
+		.max		= 31,
 	}
 };
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b71712edab4..f631a4e27aae 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2405,8 +2405,8 @@ static const struct ctl_table vm_userfaultfd_table[] = {
 		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 #endif
diff --git a/mm/util.c b/mm/util.c
index 2f2bc521868a..1460f47c10c5 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/mm.h>
-#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/compiler.h>
@@ -858,8 +857,8 @@ static const struct ctl_table util_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_overcommit_memory),
 		.mode		= 0644,
 		.proc_handler	= overcommit_policy_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "overcommit_ratio",
@@ -874,6 +873,8 @@ static const struct ctl_table util_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_overcommit_kbytes),
 		.mode		= 0644,
 		.proc_handler	= overcommit_kbytes_handler,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "user_reserve_kbytes",
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9959ca158ce8..48b7b373a76c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/mm.h>
+#include <linux/limits.h>
 #include <linux/sched/mm.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
@@ -7884,8 +7885,8 @@ static const struct ctl_table vmscan_sysctl_table[] = {
 		.maxlen		= sizeof(vm_swappiness),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO_HUNDRED,
+		.min		= 0,
+		.max		= 200,
 	},
 #ifdef CONFIG_NUMA
 	{
@@ -7894,7 +7895,8 @@ static const struct ctl_table vmscan_sysctl_table[] = {
 		.maxlen		= sizeof(node_reclaim_mode),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	}
 #endif
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a3e809c57f29..4d0a44624d16 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2279,8 +2279,8 @@ static const struct ctl_table vmstat_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 };
-- 
2.25.1

