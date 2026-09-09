Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01A525A9B;
	Wed,  9 Sep 2026 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950599; cv=none; b=lSmMv0fIPVaWrfxm1yRHJM2K8Cz/kIjGxIOdmmiAjA6fbWyCSLJias8lBb2GxA5V69/6zZfe+feO8aItqi0WhnvN3VhjkigCtXRNuEX/4tQ4NGYpNNwh3KwpXYJLBSlkbE4NcsDV5i8t6n0rWRmrqK5/uL9lrF5Sr6yzInf1i6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950599; c=relaxed/simple;
	bh=ljH4PmcbMqpxzI86GDJjrCdMsccf/UZG0sz37cuLEAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYelDyWn8NwkOu+E2r4Wgq+hY11V83zylXqiCudkm69+uhr+YnaQA0xtR5iYn/k8vzZ0MUJO0BLl0hA1T/cTtSkQvNBpDZ2NCigDpQFoZrXz91+Ps4sycbNhDC93De7zoFIp5d+/Yz1ZnS8Vo8gi1H51YIbZeH1gPbJPj9xJzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBfKKfcS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBfKKfcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BE31F00A3E;
	Wed,  9 Sep 2026 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950596;
	bh=XPk7U7FG+rJ3Spd9W56GP3BfliuT1Dhikqca+FPI3jM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gBfKKfcSwtz7fRRp+OG5YaWqyypP5uDJpv4SeOjej1Zpz5t8acWvcA4pek3bxDvs8
	 AZuKOTn7PKQFQYXcPx4Z3SM+OmqJwjCyGyBmnzDfz/nfxKKLQYLGDoADL7f0rProos
	 MUaUCV7oqlKuXx37mHInL0HQgyIu6rBT81xMZ5b4ntfNr45kj24d8mhN+PXGFWUWZ+
	 6M2PUVrEtHopUFmVUaCK6TmEDxVtc2aMm1lX1kYgRSdYBPOKc0aBGDKbmBELa+jC3W
	 iCpjRT88ZjF5yNNlgt556bdD3eYUlH6q1RRX0PMrQR1BYPhGIediWGa7h5JHsC8Q8+
	 yhj1rSVZ/kZ3A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 12:43:00 +0200
Subject: [PATCH v2 01/10] pid: add helpers to operate on a struct pid array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-unix-passpidfd-v2-1-7bd342abb2d1@kernel.org>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6917; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ljH4PmcbMqpxzI86GDJjrCdMsccf/UZG0sz37cuLEAk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQttLCeJpP6rWy5QruasBfDBdtl69M3T3zDmjYn/PZsE
 ef8pXklHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ1M7wv9TfZ25uve/Ng6Y2
 a3Y3XlpVv9C8+g5b/Rx9Pf6VV07yHWJk6Pqv/ce0Y/dzV+9/846HxaUu2ZKV6+EkfcOy70jHvph
 qTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're about to extend af_unix sockets and coredump code with the ability
to hand out thread-specific pidfds. Add a few simple helpers that allow
to operate on multiple struct pids up to PIDTYPE_MAX with automatic
bounds checking.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/pidfs.c                            | 16 +++++++++++
 include/linux/pid.h                   | 53 +++++++++++++++++++++++++++++++++++
 include/linux/pid_types.h             |  8 ++++++
 include/linux/pidfs.h                 |  5 ++++
 include/linux/sched/signal.h          | 18 ++++++++++++
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 6 files changed, 101 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a6a643f15d08..586af2e5811c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1070,6 +1070,22 @@ int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp)
 	return 0;
 }
 
+/* Register the pids up to pid type @last of @pids in pidfs. */
+int __pidfs_register_pids(struct pid *const *pids, enum pid_type last)
+{
+	if (WARN_ON_ONCE(last >= PIDTYPE_MAX))
+		return -EINVAL;
+
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++) {
+		int ret = pidfs_register_pid(pids[type]);
+
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return 0;
+}
+
 static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 					 struct dentry *dentry)
 {
diff --git a/include/linux/pid.h b/include/linux/pid.h
index ddaef0bbc8ba..87635d0cc1f7 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/minmax.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -92,6 +95,56 @@ static inline struct pid *get_pid(struct pid *pid)
 }
 
 extern void put_pid(struct pid *pid);
+
+/*
+ * Helpers for arrays of struct pid indexed by pid type declared with
+ * DECLARE_PIDS(). The array covers PIDTYPE_PID up to the pid type it
+ * was declared with and the helpers take that bound from the array.
+ */
+static inline void __get_pids(struct pid **dst, struct pid *const *src,
+			      enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		dst[type] = get_pid(src[type]);
+}
+
+static inline void __put_pids(struct pid **pids, enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++) {
+		put_pid(pids[type]);
+		pids[type] = NULL;
+	}
+}
+
+static inline void __swap_pids(struct pid **a, struct pid **b,
+			       enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		swap(a[type], b[type]);
+}
+
+static inline bool __pids_equal(struct pid *const *a, struct pid *const *b,
+				enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		if (a[type] != b[type])
+			return false;
+	return true;
+}
+
+/* The last pid type an array declared with DECLARE_PIDS() covers. */
+#define pids_last(pids)							\
+	((enum pid_type)(ARRAY_SIZE(pids) - 1 +				\
+			 BUILD_BUG_ON_ZERO(ARRAY_SIZE(pids) > PIDTYPE_MAX)))
+
+#define __pids_last2(a, b)						\
+	(pids_last(a) + BUILD_BUG_ON_ZERO(ARRAY_SIZE(a) != ARRAY_SIZE(b)))
+
+#define get_pids(dst, src)	__get_pids(dst, src, __pids_last2(dst, src))
+#define put_pids(pids)		__put_pids(pids, pids_last(pids))
+#define swap_pids(a, b)		__swap_pids(a, b, __pids_last2(a, b))
+#define pids_equal(a, b)	__pids_equal(a, b, __pids_last2(a, b))
+
 extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
 static inline bool pid_has_task(struct pid *pid, enum pid_type type)
 {
diff --git a/include/linux/pid_types.h b/include/linux/pid_types.h
index c2aee1d91dcf..3302690a2a28 100644
--- a/include/linux/pid_types.h
+++ b/include/linux/pid_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_PID_TYPES_H
 #define _LINUX_PID_TYPES_H
 
+#include <linux/build_bug.h>
+
 enum pid_type {
 	PIDTYPE_PID,
 	PIDTYPE_TGID,
@@ -10,6 +12,12 @@ enum pid_type {
 	PIDTYPE_MAX,
 };
 
+struct pid;
+
+/* An array of struct pid indexed by pid type, PIDTYPE_PID up to @last. */
+#define DECLARE_PIDS(name, last)					\
+	struct pid *name[(last) + 1 + BUILD_BUG_ON_ZERO((last) >= PIDTYPE_MAX)]
+
 struct pid_namespace;
 extern struct pid_namespace init_pid_ns;
 
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 0abf7da9ab23..3c1e82f1a369 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_FS_H
 
 #include <linux/gfp_types.h>
+#include <linux/pid.h>
 
 struct coredump_params;
 
@@ -32,5 +33,9 @@ static inline int pidfs_register_pid(struct pid *pid)
 }
 
 void pidfs_free_pid(struct pid *pid);
+int __pidfs_register_pids(struct pid *const *pids, enum pid_type last);
+
+/* Register the pids of an array declared with DECLARE_PIDS(). */
+#define pidfs_register_pids(pids)	__pidfs_register_pids(pids, pids_last(pids))
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..9444b47789a0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -677,6 +677,24 @@ struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
 	return pid;
 }
 
+/* Fill @pids with the pid types of @task up to @last, without references. */
+static inline void __task_pids(struct pid **pids, enum pid_type last,
+			       struct task_struct *task)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		pids[type] = task_pid_type(task, type);
+}
+
+static inline void __get_task_pids(struct pid **pids, enum pid_type last,
+				   struct task_struct *task)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		pids[type] = get_pid(task_pid_type(task, type));
+}
+
+#define task_pids(pids, task)		__task_pids(pids, pids_last(pids), task)
+#define get_task_pids(pids, task)	__get_task_pids(pids, pids_last(pids), task)
+
 static inline struct pid *task_tgid(struct task_struct *task)
 {
 	return task->signal->pids[PIDTYPE_TGID];
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..e792785a15ec 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -45,6 +45,7 @@ class CTransforms:
         (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) - 1)]"),
         (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
         (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
+        (CMatch("DECLARE_PIDS"), r"struct pid *\1[(\2) + 1]"),
         (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
         (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
         (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),

-- 
2.53.0

