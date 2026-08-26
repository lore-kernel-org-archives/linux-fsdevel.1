Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED33CFF6F;
	Wed, 26 Aug 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773429; cv=none; b=Tm8rsKLAdg+Wv3R34k4okgM1VX094vShyZejvQ1Y50nw9S/97esY2I5Yqwvl9CXVcK3egavCTydocgprNmq0Ng14WMb3R5xUcp+4Otkk8bfN/fJ97K2149jkPGq2MubB2qbW0ztT6DBqhJdyWUueCMhKr3WpvaiaitmtVQZDShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773429; c=relaxed/simple;
	bh=2jm1PEbvrnCrvXvoHCMaogtCzXn9d/mF8w7nvFMKAMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYGt+ALwO9ffZkAlZ57xtYVXjK0NA2GwsW1E/w/MFJhym7/5YbajcTZvH2w3+or37Sx2DlaMpOGhL7x3/Si2jesiS/UmONPIuoDAN+8iOqf4LGD73GrdkXwbCl7nTKvdNGkQ5GgWSvj2KJL9Zt4Ras3gBMGmoOon+qlWQZcEjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQR4gLqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQR4gLqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E8C1F00A3E;
	Wed, 26 Aug 2026 19:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773391;
	bh=K2MbEjefMsVRnvZfgwxn042KKn+4gqz3aOEVdFT/NN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQR4gLqeFxJ1r9CmHQ1jsHUgp6A2fCFGEp+sNZNEi5VO3fwm00ZsH0odZdVIG4dzU
	 H38GOYfszmxJ9hxX8rkYrmVRZzJ2hG/yTyKSpE2qXX3jeEaqdYDOWHviFE/FymbUuL
	 hm+R0MjE2EYUwCeZ+VzKQ2hqTKa22H/S3ICG13wCIrUfb8p+jJ8jng4P9onSmo2hv8
	 g90frZM+ZW4DuLlBttMGIW+OT6RZ8SPG+zE337Zz14S/JfpL5Q8O+RB4ifzn1zGsMZ
	 C0VUaypFXJUqG1OnOFvQq15cX1BIRwiy7tTJGrtpxKkmCP6XNg3aiUDaADOiSs+V1/
	 tLZT8hQZU4mKg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 06/30] sysctl: ipc: use sysctl_field in ipc_sysctl
Date: Wed, 26 Aug 2026 21:42:10 +0200
Message-ID: <0cb8a970a3a832c58ae3f250f007ffa479310a33.1787771905.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787771905.git.legion@kernel.org>
References: <cover.1787771905.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPC clones its sysctl table for each namespace so registration can
rewrite data pointers from init_ipc_ns to the target namespace. The
cloned table then has to stay alive until namespace teardown only so it
can be freed after unregistering the sysctls.

Use sysctl_field to derive IPC namespace data from the registration
context instead. This keeps the sysctl descriptors static and const, and
removes the per-namespace table copy and unregister-time free.

Keep the IPC-specific handlers responsible for their own min/max bounds
so the conversion does not need to extend the generic custom field
interface.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 256 ++++++++++++++++++-----------------------------
 1 file changed, 98 insertions(+), 158 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 9b087ebeb643..7b85b0f5ef82 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -13,7 +13,6 @@
 #include <linux/capability.h>
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
-#include <linux/slab.h>
 #include <linux/cred.h>
 #include "util.h"
 
@@ -48,6 +47,10 @@ static int proc_ipc_auto_msgmni(const struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 
+int ipc_mni = IPCMNI;
+int ipc_mni_shift = IPCMNI_SHIFT;
+int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
+
 static int proc_ipc_sem_dointvec(const struct ctl_table *table, int write,
 	void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -69,117 +72,100 @@ static int proc_ipc_sem_dointvec(const struct ctl_table *table, int write,
 	return ret;
 }
 
-int ipc_mni = IPCMNI;
-int ipc_mni_shift = IPCMNI_SHIFT;
-int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
+#define IPC_DATA(type, field)						\
+static type *ipc_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.ipc_ns->field;					\
+}
+
+IPC_DATA(void, shm_ctlmax)
+IPC_DATA(void, shm_ctlall)
+IPC_DATA(int, shm_ctlmni)
+IPC_DATA(void, shm_rmid_forced)
+IPC_DATA(void, msg_ctlmax)
+IPC_DATA(void, msg_ctlmni)
+IPC_DATA(void, msg_ctlmnb)
+IPC_DATA(void, sem_ctls)
+
+#define IPC_LIMIT(name, value)						\
+static void *ipc_ ## name ## _limit(const struct sysctl_context *ctx)	\
+{									\
+	return value;							\
+}
+
+IPC_LIMIT(zero, SYSCTL_ZERO)
+IPC_LIMIT(one, SYSCTL_ONE)
+IPC_LIMIT(int_max, SYSCTL_INT_MAX)
+IPC_LIMIT(mni, &ipc_mni)
+
+#define IPC_FIELD_CUSTOM_MINMAX(_procname, _len, _data, _handler, _min, _max) \
+	{								\
+		.procname = (_procname),				\
+		.mode = 0644,						\
+		.type = SYSCTL_FIELD_CUSTOM,				\
+		.ctl_custom = {						\
+			.proc_handler = (_handler),			\
+			.maxlen = (_len),				\
+			.data = (_data),				\
+			.extra1 = (_min),				\
+			.extra2 = (_max),				\
+		},							\
+	}
 
-static const struct ctl_table ipc_sysctls[] = {
-	{
-		.procname	= "shmmax",
-		.data		= &init_ipc_ns.shm_ctlmax,
-		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "shmall",
-		.data		= &init_ipc_ns.shm_ctlall,
-		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "shmmni",
-		.data		= &init_ipc_ns.shm_ctlmni,
-		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ipc_mni,
-	},
-	{
-		.procname	= "shm_rmid_forced",
-		.data		= &init_ipc_ns.shm_rmid_forced,
-		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
-		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "msgmax",
-		.data		= &init_ipc_ns.msg_ctlmax,
-		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "msgmni",
-		.data		= &init_ipc_ns.msg_ctlmni,
-		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ipc_mni,
-	},
-	{
-		.procname	= "auto_msgmni",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_ipc_auto_msgmni,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	=  "msgmnb",
-		.data		= &init_ipc_ns.msg_ctlmnb,
-		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "sem",
-		.data		= &init_ipc_ns.sem_ctls,
-		.maxlen		= 4*sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_ipc_sem_dointvec,
-	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	{
-		.procname	= "sem_next_id",
-		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "msg_next_id",
-		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "shm_next_id",
-		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
+#define IPC_ID_NEXT_DATA(name, id)					\
+static int *ipc_ ## name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.ipc_ns->ids[id].next_id;			\
+}
+
+IPC_ID_NEXT_DATA(sem_next_id, IPC_SEM_IDS)
+IPC_ID_NEXT_DATA(msg_next_id, IPC_MSG_IDS)
+IPC_ID_NEXT_DATA(shm_next_id, IPC_SHM_IDS)
+#endif
+
+static const struct sysctl_field ipc_sysctls[] = {
+	SYSCTL_FIELD_CUSTOM("shmmax", 0644, sizeof(init_ipc_ns.shm_ctlmax),
+			 ipc_shm_ctlmax_data, proc_doulongvec_minmax),
+	SYSCTL_FIELD_CUSTOM("shmall", 0644, sizeof(init_ipc_ns.shm_ctlall),
+			 ipc_shm_ctlall_data, proc_doulongvec_minmax),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("shmmni", 0644, ipc_shm_ctlmni_data,
+				    SYSCTL_ZERO, &ipc_mni),
+	IPC_FIELD_CUSTOM_MINMAX("shm_rmid_forced",
+				sizeof(init_ipc_ns.shm_rmid_forced),
+				ipc_shm_rmid_forced_data,
+				proc_ipc_dointvec_minmax_orphans,
+				ipc_zero_limit, ipc_one_limit),
+	IPC_FIELD_CUSTOM_MINMAX("msgmax", sizeof(init_ipc_ns.msg_ctlmax),
+				ipc_msg_ctlmax_data, proc_dointvec_minmax,
+				ipc_zero_limit, ipc_int_max_limit),
+	IPC_FIELD_CUSTOM_MINMAX("msgmni", sizeof(init_ipc_ns.msg_ctlmni),
+				ipc_msg_ctlmni_data, proc_dointvec_minmax,
+				ipc_zero_limit, ipc_mni_limit),
+	IPC_FIELD_CUSTOM_MINMAX("auto_msgmni", sizeof(int), NULL,
+				proc_ipc_auto_msgmni,
+				ipc_zero_limit, ipc_one_limit),
+	IPC_FIELD_CUSTOM_MINMAX("msgmnb", sizeof(init_ipc_ns.msg_ctlmnb),
+				ipc_msg_ctlmnb_data, proc_dointvec_minmax,
+				ipc_zero_limit, ipc_int_max_limit),
+	SYSCTL_FIELD_CUSTOM("sem", 0644, 4 * sizeof(int), ipc_sem_ctls_data,
+			 proc_ipc_sem_dointvec),
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	SYSCTL_FIELD_STATIC_INT_MINMAX("sem_next_id", 0444,
+				    ipc_sem_next_id_data, SYSCTL_ZERO,
+				    SYSCTL_INT_MAX),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("msg_next_id", 0444,
+				    ipc_msg_next_id_data, SYSCTL_ZERO,
+				    SYSCTL_INT_MAX),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("shm_next_id", 0444,
+				    ipc_shm_next_id_data, SYSCTL_ZERO,
+				    SYSCTL_INT_MAX),
 #endif
 };
 
+#undef IPC_FIELD_CUSTOM_MINMAX
+#undef IPC_LIMIT
+
 static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
 {
 	return &current->nsproxy->ipc_ns->ipc_set;
@@ -244,57 +230,15 @@ static struct ctl_table_root set_root = {
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
+		.ns.ipc_ns = ns,
+	};
 
 	setup_sysctl_set(&ns->ipc_set, &set_root, set_is_seen);
 
-	tbl = kmemdup(ipc_sysctls, sizeof(ipc_sysctls), GFP_KERNEL);
-	if (tbl) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(ipc_sysctls); i++) {
-			if (tbl[i].data == &init_ipc_ns.shm_ctlmax)
-				tbl[i].data = &ns->shm_ctlmax;
-
-			else if (tbl[i].data == &init_ipc_ns.shm_ctlall)
-				tbl[i].data = &ns->shm_ctlall;
-
-			else if (tbl[i].data == &init_ipc_ns.shm_ctlmni)
-				tbl[i].data = &ns->shm_ctlmni;
-
-			else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced)
-				tbl[i].data = &ns->shm_rmid_forced;
-
-			else if (tbl[i].data == &init_ipc_ns.msg_ctlmax)
-				tbl[i].data = &ns->msg_ctlmax;
-
-			else if (tbl[i].data == &init_ipc_ns.msg_ctlmni)
-				tbl[i].data = &ns->msg_ctlmni;
-
-			else if (tbl[i].data == &init_ipc_ns.msg_ctlmnb)
-				tbl[i].data = &ns->msg_ctlmnb;
-
-			else if (tbl[i].data == &init_ipc_ns.sem_ctls)
-				tbl[i].data = &ns->sem_ctls;
-#ifdef CONFIG_CHECKPOINT_RESTORE
-			else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id)
-				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
-
-			else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id)
-				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
-
-			else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id)
-				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
-#endif
-			else
-				tbl[i].data = NULL;
-		}
-
-		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set, "kernel", tbl,
-							  ARRAY_SIZE(ipc_sysctls));
-	}
+	ns->ipc_sysctls = register_sysctl_fields(&ns->ipc_set, "kernel",
+						 ipc_sysctls, &ctx);
 	if (!ns->ipc_sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->ipc_set);
 		return false;
 	}
@@ -304,12 +248,8 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 void retire_ipc_sysctls(struct ipc_namespace *ns)
 {
-	const struct ctl_table *tbl;
-
-	tbl = ns->ipc_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->ipc_sysctls);
 	retire_sysctl_set(&ns->ipc_set);
-	kfree(tbl);
 }
 
 static int __init ipc_sysctl_init(void)
-- 
2.55.0

