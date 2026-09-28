Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC436A352
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587658; cv=none; b=Awlgl8J+QmBopCMbs7OncoX0gViEdfNueMIji2MUYb/3chrL8P1fwzqvlJATKzQs11/U0fpTqbvIaCEYM+L7VWHTUsX6OtVS7hyYRFbhfP4VnZ4W5scsfN4qw8fb5NFd1yDygRGDS0FQ2poQoghbAfUuVjhoi40pUmY/MAnGHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587658; c=relaxed/simple;
	bh=sPq6ow05ESSsLkx19oSJQ6lCxDIUpbRp5B6NmdQYWZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvxltUCRfZUNsXYcXWG90gPoKjqHApbJdeX8faW303fizhFfFVBBaP+LfN/qbL+nSeP485GpFSrLA3n2RnsSIxX24vr4fR5973dShUbOPODxDcOl0b750mHs0z18w8ZFSsInSVQftJmC2P/4ksM1SE/L7igs0aZ+PldoZJBvLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=M2rg+7v4; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="M2rg+7v4"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac62c88c7cso2132759a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587655; x=1791192455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etDmoveWN7n86f77dzpOEQHS7hrjEasSaits5Qio3p0=;
        b=M2rg+7v41lsFtxbRWTkciCHNQ2B+E1IRpcY2SuUIqLMbKqA3pho7aj0MWmbcGD1W8g
         iaesJmZkbO6fqFvHR6svUJ0ESUmnDQnDIGectY4oaZaVwaA3Ikhf1UE7rNSt4bLAEH2f
         Iqce5vsggtB8u064JLdIPWhoipMFKd49o8mu1cMHx5UFus6tU/HrR4OlHWtHbPIaj50+
         cVIp14T834wrK8uMWKCvOCGslo9sJmBX9pRxPIOE1E2x/2d4ZETo6t6jYHClPlAgcWVS
         2L+5C/3+59piAvc8p3tX9vBw0ceZqYg7M93OQ6D82H4nB+qT0w/pdP/TOukS0UG/vf7O
         wSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587655; x=1791192455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etDmoveWN7n86f77dzpOEQHS7hrjEasSaits5Qio3p0=;
        b=hg0aFZRqjZV0Fl1G1zs9OFDMn2G7dOKasyylDqDNXtfbyIDcuK4+hu3Xr+w8+RtNBW
         oulhw0edPQoNDMmGTw9hf3C3oE7SWAkwItsE625wFUNXsdEQ641yBD6JMXvjGrsvLIc0
         CZSUsXhm4SQU9ZVY91caRfDj82m08q6g2vvrGK5BveTCZNCzxsccAUxYqEMthokKHmut
         U3PkYW+pK5bniD3PP3v3Z9ShWp1jF53pwf1BsF3xJ4YDd75G/sDA/K+r2CdOa5vLSoHX
         6Qp0sY2gQh/RCIuB4yYc7NZ5UZuEETs7semNPZChhe4t9TqBScsLzAPP6tzPpn70g+qE
         gU3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwIrd/H6ERxFYXiHPFmvZUHh+KqeFQpjaNY0r5G4tVaIaiMuRsLJHwPI38T9Ujgurhywrke7uctanWlsEDp@vger.kernel.org
X-Gm-Message-State: AFuF++mdbyiZZlcNT9PzAJVsvs9M3e7zP8z1X6r9mvIOsuq8rtDegfwT
	wT53HzKdUt4CXDR+oJWoQeYtCFbP8sZwKaY0DwPgSaUPSXqLgrYdtghfLzU7J8CfCJrM
X-Gm-Gg: AYBFou0SNMg77YKyu2YOnEVKsyeLfhS8viDTswXrwmIRPA3ixNBA4l4YU7Nh0+gIPL4
	LmkcF/wsQVw+jl+XAQCmNzM4DhuFM8kOOueheTYRyyTT6Jg5AxjEtMbpNWLeLMcq6ts+DGn59lL
	oyxX11A4tYFU21OD32JLPylM2g5emceJJUDz6eTe1ld5bZqHEM3w8m+a38vzahPuHf8KR6GBsLR
	3QwgrMwGoVSaMHc4FRIwDmAcZGEZqwHV3Sdh6eowJz5lUypp48/5bgVyB6L01d0U0UXmnCX2uAl
	P2lOB7jz3EVSYFQ5kg43phBSKcJ2keJiI2qf/V+T4sYLdcj5cBkWuMhOHeoFm9puL2gNRb9OwYJ
	f8D97nz0cR6HMzf9nx3G3gb7hG713Ss4dIAsR5Z2+G6bU+w6W+84g6X2EXpmjOkKkP6pGGhMAkF
	R9gIWzOKA2YlDFHHfD/WjrKfi0G3EzegKOuxCNaRNIOYXiEHM8Rej0jOxtE/snWpf2EHBO/9YA5
	I9ENto9xmkdv9L4wSC8+Cxh2fRXbmEJwzaiGgNYcw==
X-Received: by 2002:a17:907:1c93:b0:c2d:c03d:acaa with SMTP id a640c23a62f3a-c2dec6f6cd3mr9550666b.22.1790587654498;
        Mon, 28 Sep 2026 02:27:34 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:34 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:08 +0200
Subject: [PATCH v3 01/10] pid: add helpers to operate on a struct pid array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-1-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

We're about to extend af_unix sockets and coredump code with the ability
to hand out thread-specific pidfds. Add a few simple helpers that allow
to operate on multiple struct pids up to PIDTYPE_MAX with automatic
bounds checking.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
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
index d45a5476b97d..3149cdb976c6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -674,6 +674,24 @@ struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
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
2.55.0

