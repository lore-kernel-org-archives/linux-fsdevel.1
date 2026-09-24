Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758C3CD8BD;
	Thu, 24 Sep 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260457; cv=none; b=nqDlwKRYPElqejy5ogNv0Jexk/OoXs++ttXgDh1Hn6ZRCXZDJBMptYySxBglQSbNCr3AuOv4+NYZclP5WGTqDwRfP1W1wcJsSNFHWjxHz+HlWz4+krwq4mpPTWKil7gTrR3Hsg5UvOvB6FUc49bRP9Bmmw+uhHoc5wGCQLy7Zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260457; c=relaxed/simple;
	bh=e29ezvxC9hX4zQkzHds21fbEF45zhneWLsPqxIZU4JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNoZQ5Bf/77qCLFmk0/YJmEYlAGkZ/SPMWr1bv+pZRfG1zYBKAodmG2lYIYtAWBhrLgaSEXnrSPFGLS0upL/QGB1ZJ7nZ5tTDnL0mmLL1FOMOnIIVhiuPRoNJn02ny2zddMsTUBlzI4dEpyKW9DMTcm4Lk9KbGtSp8Yvh9bo1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUyqanJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUyqanJV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1A8C2BCFF;
	Thu, 24 Sep 2026 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790260457;
	bh=e29ezvxC9hX4zQkzHds21fbEF45zhneWLsPqxIZU4JE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jUyqanJV3Y+EGbfxWrzqau/UvJzCWfUedILeagpkuLvvIbm0i6xoJSeH4DOlGYRnE
	 tkmTnPAyMC6BDe3TjxdrRMfPIgHAVF+EwRucArXC8qkdXpiDzJ6ItRpY375f6JlyWU
	 0fGRWOv+YCImoFzanyDQ09LRtXU0I564un8bKyNXN0A7mEBOZ+LIC+/w1Fk8xtF0cW
	 0f/R++PmwGfkGBmGXH36Wjj9iI/VFd/S9qizVfK0bOY62+sJmuSNrqCdd03V9s16Ma
	 JybBDWLycWfYd9/6gNpoy5Wi3EnJVscVeqjA4PB1VdRirSaO6oo0iptQi59UUXSTky
	 YL6NkH8dCoB/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7159AC98324;
	Thu, 24 Sep 2026 14:34:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 24 Sep 2026 16:34:11 +0200
Subject: [PATCH RFC 3/4] ipc: Use sysctl context to register ipc namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-lklm-sysctl-headerctx-template-v1-3-b25e51c66ba7@kernel.org>
References: <20260924-lklm-sysctl-headerctx-template-v1-0-b25e51c66ba7@kernel.org>
In-Reply-To: <20260924-lklm-sysctl-headerctx-template-v1-0-b25e51c66ba7@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Serge Hallyn <serge@hallyn.com>, 
 "Eric W . Biederman" <ebiederm@xmission.com>, 
 Alexey Gladkov <legion@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6736;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=e29ezvxC9hX4zQkzHds21fbEF45zhneWLsPqxIZU4JE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGq1NOW0JPl0Px3kSFzIY8vBgQCdAYygEXAHx
 zYt7J9mBVD+84kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqtTTlAAoJELqXzVK3
 lkFPmf0L/1qioEmGrTruG0TECIJ96LOtrHmr8UAl0NXoNvCQMSNbKc0uQdnXzoDqo6CZ07OqP+Y
 t6W/eq0EfAzCySHtrL+cpEfC+SX1XaM11K9GISuKE4AWgDTc5Mxo/mtGBYeHu6v6j3QHXYTJ9Y7
 dXlsBQ/uPn6BxguSGD7mtIBcweGTrQbs89uE7oDJx+i2NekSdoChQAFeq4A48IPI8XZoBUyPsFV
 d7kCqzsw0ls26584jrkHkNYi0KIcKA4pjvE5Zif1hmaxwLNMEVZYK/haKEe33Cesxk6F16ETYjy
 JYSpajzWz5l7i+ryNaXTbXBiCgQNvTZ7fqYVoHGeBHmbLh+seQEoxaGtbbmIKYWBOU/dp9B6wqo
 jRoQkTJqbJTN+rmguYfRgyMB/bimhHGZKNnsjawsjZAHDDrTuB5j5eQpme8G6UW2pWw1uR579nS
 FaVrn/EsO7WP2yqlodFRhAoduCwNnkpDzjPU12hn+I0NOENTNwi//jVt3YCN6A8a2KdXGB1Mv/6
 LY=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Replace the ipc_sysctls array copy with a sysctl context kept in the
ctl_table_header. Flag each entry with CTL_TABLE_F_CTX_DATA to overlay
the ctl_table entry before calling the proc_handler. auto_msgmni is left
unflagged. Its NULL ->data is handled by its custom proc_handler.
proc_ipc_{dointvec_minmax_orphans,sem_dointvec} and ipc_permissions are
handed a resolved entry, so they keep seeing the namespace entry.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 ipc/ipc_sysctl.c | 68 +++++++++++++-------------------------------------------
 1 file changed, 16 insertions(+), 52 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d038d944257f60b3a35b72492c73c41774a73da4..5d73487bb81c027da1ec2b1fa18dfde8242a223f 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -13,7 +13,6 @@
 #include <linux/capability.h>
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
-#include <linux/slab.h>
 #include <linux/cred.h>
 #include "util.h"
 
@@ -79,6 +78,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
@@ -86,6 +86,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlall,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
@@ -93,6 +94,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
@@ -102,6 +104,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_rmid_forced,
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
@@ -111,6 +114,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.msg_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -120,6 +124,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.msg_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
@@ -138,6 +143,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.msg_ctlmnb,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -147,6 +153,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.sem_ctls,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_ipc_sem_dointvec,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -155,6 +162,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0444,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -164,6 +172,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0444,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -173,6 +182,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0444,
+		.flags		= CTL_TABLE_F_CTX_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -244,57 +254,15 @@ static struct ctl_table_root set_root = {
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = SYSCTL_CTX(ns, &init_ipc_ns);
 
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
+	ns->ipc_sysctls = __register_sysctl_table_ctx(&ns->ipc_set, "kernel",
+						      ipc_sysctls,
+						      ARRAY_SIZE(ipc_sysctls),
+						      &ctx);
 	if (!ns->ipc_sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->ipc_set);
 		return false;
 	}
@@ -304,12 +272,8 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
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
2.50.1


