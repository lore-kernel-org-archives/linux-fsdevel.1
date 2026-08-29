Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461040F8DF;
	Sat, 29 Aug 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020124; cv=none; b=CVTCqI5iIJiWX20Jb9m7URHUIGHNCDQjZz56a+7XQkjsFr1HSWxoXmh6JRokrHc0IV5jd+UOAcesGwQUKd5UFo2my2dJe+haDtduksTDlRxvqXzSZ2YrZOI7Tr83AV+cI3mJD15/M75Pc3mRaQLYlbz1+jIO5cUyYT5PsYIb/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020124; c=relaxed/simple;
	bh=+WWalNuyW7U/4ygeF8a9S8Dv9XaNd8LlFD7qHf5n7Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT4sHB19MWep+JSXVHurT3JFEwSmbHq/0uzUQtZZJvdL3MTsbLDpHDc9U7qd51hkQwbNDd9toKVBqu256Wd5j6zma1ztVcR+zvdhvL3OH3DqCO/jXwFRughLHQ9NBaKW+/4KU7/8vAOh0nT92WiEHv/ofuxN+aZhO2/zxnCwmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaHjMysD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaHjMysD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADBC1F00A3E;
	Sat, 29 Aug 2026 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788020118;
	bh=aKFFxrPu5mubRpKld+PYID5Em6FWmBOqPicRKRpPqyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LaHjMysDyNwRuDwcVLQDEiF9H2xSAyYY3VqoZdOdeiY0hI0pMbVSY+NL/gZW0qapC
	 Jay8vr9Gut3wtMKWoEOmrPnAMzvsQg4lQUQw1kfoQuRnpDjpuVDSUiBpBGsJBvtFKe
	 YsAUwoArsxsJKnbyMd1sHbNHSd+p4kFZ25kGjR0i3OT0IN/Tu0R3r8xPAJfviv4P16
	 ztOkNwN8WqyZHwv+exS7IgSurlkJYvtMDPnWxAxkW7EplPi6CtqedGnP3zR3rrvD3a
	 /FtaNk30cKVxUWf+E20K5H/sycsvLwRm9U8slkv7BT4rC/fhh4KQfuDALqufQKAHH0
	 klk/jYWi0rxlA==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/4] sysctl: ipc: use typed fields for IPC namespace sysctls
Date: Sat, 29 Aug 2026 18:14:45 +0200
Message-ID: <5cc85a6393923d96a431e5e9e9a2d416ac489c46.1788018958.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788018958.git.legion@kernel.org>
References: <cover.1788018958.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPC sysctl registration clones the table and rewrites data and limit
pointers for each namespace. This allocates a full ctl_table array per
namespace and ties the fixup loop to the table layout.

Describe the table with ctl_field offsets into ipc_namespace instead.
Keep the auto_msgmni entry data-less because its handler selects the
effective value itself. This removes the per-namespace table allocation
while preserving the existing handlers and limits.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 188 +++++++++++++++++++++--------------------------
 1 file changed, 82 insertions(+), 106 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 9b087ebeb643..f017b4109cc8 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -13,7 +13,6 @@
 #include <linux/capability.h>
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
-#include <linux/slab.h>
 #include <linux/cred.h>
 #include "util.h"
 
@@ -41,6 +40,8 @@ static int proc_ipc_auto_msgmni(const struct ctl_table *table, int write,
 
 	memcpy(&ipc_table, table, sizeof(ipc_table));
 	ipc_table.data = &dummy;
+	ipc_table.extra1 = SYSCTL_ZERO;
+	ipc_table.extra2 = SYSCTL_ONE;
 
 	if (write)
 		pr_info_once("writing to auto_msgmni has no effect");
@@ -72,110 +73,129 @@ static int proc_ipc_sem_dointvec(const struct ctl_table *table, int write,
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
+static unsigned int ipc_mni_max = IPCMNI;
+static unsigned int ipc_uint_max = INT_MAX;
 
-static const struct ctl_table ipc_sysctls[] = {
+static const struct sysctl_field ipc_sysctls[] = {
 	{
 		.procname	= "shmmax",
-		.data		= &init_ipc_ns.shm_ctlmax,
-		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.type		= SYSCTL_FIELD_SIZE_T,
+		.data_offset	= SYSCTL_FIELD_SIZE_T_OFFSET(struct ipc_namespace,
+							     shm_ctlmax),
 	},
 	{
 		.procname	= "shmall",
-		.data		= &init_ipc_ns.shm_ctlall,
-		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.type		= SYSCTL_FIELD_SIZE_T,
+		.data_offset	= SYSCTL_FIELD_SIZE_T_OFFSET(struct ipc_namespace,
+							     shm_ctlall),
 	},
 	{
 		.procname	= "shmmni",
-		.data		= &init_ipc_ns.shm_ctlmni,
-		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ipc_mni,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct ipc_namespace,
+							  shm_ctlmni),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= &ipc_mni,
+		},
 	},
 	{
 		.procname	= "shm_rmid_forced",
-		.data		= &init_ipc_ns.shm_rmid_forced,
-		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct ipc_namespace,
+							  shm_rmid_forced),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= SYSCTL_ONE,
+		},
 	},
 	{
 		.procname	= "msgmax",
-		.data		= &init_ipc_ns.msg_ctlmax,
-		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   msg_ctlmax),
+		.uint_limits = {
+			.min_value	= SYSCTL_UINT_ZERO,
+			.max_value	= &ipc_uint_max,
+		},
 	},
 	{
 		.procname	= "msgmni",
-		.data		= &init_ipc_ns.msg_ctlmni,
-		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ipc_mni,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   msg_ctlmni),
+		.uint_limits = {
+			.min_value	= SYSCTL_UINT_ZERO,
+			.max_value	= &ipc_mni_max,
+		},
 	},
 	{
 		.procname	= "auto_msgmni",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_NO_DATA,
 		.proc_handler	= proc_ipc_auto_msgmni,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.maxlen		= sizeof(int),
 	},
 	{
-		.procname	=  "msgmnb",
-		.data		= &init_ipc_ns.msg_ctlmnb,
-		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
+		.procname	= "msgmnb",
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   msg_ctlmnb),
+		.uint_limits = {
+			.min_value	= SYSCTL_UINT_ZERO,
+			.max_value	= &ipc_uint_max,
+		},
 	},
 	{
 		.procname	= "sem",
-		.data		= &init_ipc_ns.sem_ctls,
-		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_INT,
 		.proc_handler	= proc_ipc_sem_dointvec,
+		.maxlen		= 4 * sizeof(int),
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct ipc_namespace,
+							  sem_ctls[0]),
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
 		.procname	= "sem_next_id",
-		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct ipc_namespace,
+							  ids[IPC_SEM_IDS].next_id),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 	{
 		.procname	= "msg_next_id",
-		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct ipc_namespace,
+							  ids[IPC_MSG_IDS].next_id),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 	{
 		.procname	= "shm_next_id",
-		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct ipc_namespace,
+							  ids[IPC_SHM_IDS].next_id),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 #endif
 };
@@ -244,57 +264,16 @@ static struct ctl_table_root set_root = {
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
+		.type = SYSCTL_CONTEXT_IPC_NS,
+		.object_size = sizeof(*ns),
+		.ns.ipc_ns = ns,
+	};
 
 	setup_sysctl_set(&ns->ipc_set, &set_root, set_is_seen);
-
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
+	ns->ipc_sysctls =
+		register_sysctl_fields(&ns->ipc_set, "kernel", ipc_sysctls, &ctx);
 	if (!ns->ipc_sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->ipc_set);
 		return false;
 	}
@@ -304,12 +283,8 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
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
@@ -326,6 +301,7 @@ device_initcall(ipc_sysctl_init);
 static int __init ipc_mni_extend(char *str)
 {
 	ipc_mni = IPCMNI_EXTEND;
+	ipc_mni_max = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
 	ipc_min_cycle = IPCMNI_EXTEND_MIN_CYCLE;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
-- 
2.55.0

