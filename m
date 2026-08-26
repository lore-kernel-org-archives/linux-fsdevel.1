Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FA47DD47;
	Wed, 26 Aug 2026 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773408; cv=none; b=C3GHmcjhbCz+DdFQDn/EoTEecoA4q/ala234CVYSWd2Jg4EtFEL/W0Fw2FKt2HCWz5qiWbXjnTjunBUJiprtfBfdGWk+R0iMbr5qpR5HZccAbFceGSj74xvj7bWiuQieZ2wes0wbQT9qxJlH9anFIPXL+NdkH+X/a1vnRX/bbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773408; c=relaxed/simple;
	bh=HNABkk8w6DpIGR3MHcrCBq+YONpFAG9yXymy4opj7ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5opW3VvJzeiC7Y/MX+KUl1XKYtjd1gQrZOCNfGi29IqNrsv/QyIqenhLZZVe0k1xt5Hj8MZzK5szu8c+VO4gfrxxujW5gkQgSmrDhugh7Y8rwbmCYMdvfqqVRWNQRD1DLrSHfdGKrPTG+ykrEqTiDN3HUlnOhSk7thDM6Bjj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2AK3m+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2AK3m+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D21F00AC4;
	Wed, 26 Aug 2026 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773389;
	bh=34ULa/WV01eHCjgQDCYkK3TTI4eKa2Mi+S9GjG+6eCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2AK3m+4Tck6ppoka/71CRnEvzrIPESwvLCRrHJUPJlKmDIJdzRZ5WA9DKFe2DzTx
	 NnRw2CdLiUYIDVIZ1ir76UgULdbf31BqQ0F0kvjmINED7a8bLwW/Z/teDsDmYIsKSw
	 +6gP0/JrcfMDFSvMZ2H1TmK61ka/Z9Uz1JgxdyTrseZGCiuwEyVj6ROI7VlY/HhDmR
	 9jOfGCAMlNCWlJuDIT/44T4M0j879w6C4fz5/MBTuxBOZrbajMT97bT4GiC9L0eEfk
	 9jHpdAnl9dqJ1R8jt+hy31B81R5nAjJzxFYtS2o7jjndO/kA1A8n00FYmiv3OEt+zM
	 17gdCLmptu6og==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 05/30] sysctl: ipc: use sysctl_field in mq_sysctl
Date: Wed, 26 Aug 2026 21:42:09 +0200
Message-ID: <5cce05451d54b17f5496dcc62de10009d2490fe4.1787771905.git.legion@kernel.org>
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

Convert mq_sysctls. The table can now share one static array across ipc
namespaces instead of allocating and rewriting a ctl_table copy for each
registration.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/sysctl.h |   2 +
 ipc/mq_sysctl.c        | 100 +++++++++--------------------------------
 2 files changed, 24 insertions(+), 78 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 3c7f2ffab334..e2831190e484 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -38,6 +38,7 @@ struct nsproxy;
 struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
+struct ipc_namespace;
 struct user_namespace;
 
 /* Keep the same order as in fs/proc/proc_sysctl.c */
@@ -90,6 +91,7 @@ typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
 struct sysctl_context {
 	union {
 		struct user_namespace *user_ns;
+		struct ipc_namespace *ipc_ns;
 	} ns;
 };
 
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 0dd12e1c9f53..54e59b9901dd 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -11,7 +11,6 @@
 
 #include <linux/stat.h>
 #include <linux/capability.h>
-#include <linux/slab.h>
 #include <linux/cred.h>
 
 static int msg_max_limit_min = MIN_MSGMAX;
@@ -20,50 +19,24 @@ static int msg_max_limit_max = HARD_MSGMAX;
 static int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
 static int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
 
-static const struct ctl_table mq_sysctls[] = {
-	{
-		.procname	= "queues_max",
-		.data		= &init_ipc_ns.mq_queues_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "msg_max",
-		.data		= &init_ipc_ns.mq_msg_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
-	},
-	{
-		.procname	= "msgsize_max",
-		.data		= &init_ipc_ns.mq_msgsize_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
-	},
-	{
-		.procname	= "msg_default",
-		.data		= &init_ipc_ns.mq_msg_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
-	},
-	{
-		.procname	= "msgsize_default",
-		.data		= &init_ipc_ns.mq_msgsize_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
-	},
+#define MQ_SYSCTL_DATA(name, member)				\
+static int *name ## _data(const struct sysctl_context *ctx)	\
+{								\
+	return &ctx->ns.ipc_ns->member;				\
+}
+
+MQ_SYSCTL_DATA(mq_queues_max, mq_queues_max);
+MQ_SYSCTL_DATA(mq_msg_max, mq_msg_max);
+MQ_SYSCTL_DATA(mq_msgsize_max, mq_msgsize_max);
+MQ_SYSCTL_DATA(mq_msg_default, mq_msg_default);
+MQ_SYSCTL_DATA(mq_msgsize_default, mq_msgsize_default);
+
+static const struct sysctl_field mq_sysctls[] = {
+	SYSCTL_FIELD_INT("queues_max", 0644, mq_queues_max_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("msg_max", 0644, mq_msg_max_data, &msg_max_limit_min, &msg_max_limit_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("msgsize_max", 0644, mq_msgsize_max_data, &msg_maxsize_limit_min, &msg_maxsize_limit_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("msg_default", 0644, mq_msg_default_data, &msg_max_limit_min, &msg_max_limit_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("msgsize_default", 0644, mq_msgsize_default_data, &msg_maxsize_limit_min, &msg_maxsize_limit_max),
 };
 
 static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
@@ -116,39 +89,14 @@ static struct ctl_table_root set_root = {
 
 bool setup_mq_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
+		.ns.ipc_ns = ns,
+	};
 
 	setup_sysctl_set(&ns->mq_set, &set_root, set_is_seen);
 
-	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
-	if (tbl) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(mq_sysctls); i++) {
-			if (tbl[i].data == &init_ipc_ns.mq_queues_max)
-				tbl[i].data = &ns->mq_queues_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msg_max)
-				tbl[i].data = &ns->mq_msg_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_max)
-				tbl[i].data = &ns->mq_msgsize_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msg_default)
-				tbl[i].data = &ns->mq_msg_default;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_default)
-				tbl[i].data = &ns->mq_msgsize_default;
-			else
-				tbl[i].data = NULL;
-		}
-
-		ns->mq_sysctls = __register_sysctl_table(&ns->mq_set,
-							 "fs/mqueue", tbl,
-							 ARRAY_SIZE(mq_sysctls));
-	}
+	ns->mq_sysctls = register_sysctl_fields(&ns->mq_set, "fs/mqueue", mq_sysctls, &ctx);
 	if (!ns->mq_sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->mq_set);
 		return false;
 	}
@@ -158,10 +106,6 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 
 void retire_mq_sysctls(struct ipc_namespace *ns)
 {
-	const struct ctl_table *tbl;
-
-	tbl = ns->mq_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->mq_sysctls);
 	retire_sysctl_set(&ns->mq_set);
-	kfree(tbl);
 }
-- 
2.55.0

