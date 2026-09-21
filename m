Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34024825DD;
	Mon, 21 Sep 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988154; cv=none; b=k+wMKfIy32TGW8oTJKd5B1aUH19B5vKnhXf9SRnShWRP+srCooH7IMz9qaYFceagAi1TY/jjjt2SWXXbzQrMLvplghavvnodDUYcKLFwn24nyzJr5M1fnvcRYp43q5bxGD6eQ1A4EYHBFSxtcWxfuMgQG6m4fYwzc1bNR4qgYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988154; c=relaxed/simple;
	bh=zN8KBXsHg6a8ybZFtItrrB3nc8ZNrd5OBVHijjXA4ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lchVwcJasHXlIYDzedQzyZ0tYr8ERfTDDJl9pJGE4kt+PrJhEzyHXLek2QeoAFnpDmcmKd7FAZwBWsdG6wUAvyFojzAqYb4JeEn6g1kJ3JO+vMnX53ekYx9i8UCamrk2jpxhWdPlYhJ2fFo1Cal2sIjXT6Bu3T7GWFt/xs0eW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EijkETDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EijkETDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5339C1F00893;
	Mon, 21 Sep 2026 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988153;
	bh=8JtYJjScj9aKe5la7osjOS8VClOFtN73fAXQOk2DuXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EijkETDWjFBsQ17El8Pg2mKHFND5w7sLzA7brq//E2SyBz0cbamEZ515Hs/WSTtE7
	 VxeRFYvk8aAkwAQdItWfWtW6uAryeca2rPgq5U8lALWgMiNIOeB4BwbN0017Wc13uc
	 D8imSYV/uT0QoOxB6/WbOGA62Wm5EQ96OhMBAd/V8NK3gPInsXL36Yug9Ud+xPWEgk
	 alwfExz++N/3kChvjS0goxJDpX+xWqNzFYF+xKJWXuCyTPfuqmsnQuOVfTG/Kgp6+4
	 46dcZuBD/r5U6AjShRUeRZQCj8ZxtMwTMULb1ujzEwrWIhItJrryo5q7/9Op1p8MVm
	 abGraevpihTgA==
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/6] sysctl: mq: use typed fields for IPC namespace sysctls
Date: Mon, 21 Sep 2026 12:54:52 +0200
Message-ID: <7b9a5e7551f214b863b1b30559b7a4c50b44b248.1789987960.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789987960.git.legion@kernel.org>
References: <cover.1789987960.git.legion@kernel.org>
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
 ipc/mq_sysctl.c | 104 ++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 61 deletions(-)

diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 0dd12e1c9f53..0d57708e9ea7 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -14,55 +14,63 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 
-static int msg_max_limit_min = MIN_MSGMAX;
-static int msg_max_limit_max = HARD_MSGMAX;
+static unsigned int msg_max_limit_min = MIN_MSGMAX;
+static unsigned int msg_max_limit_max = HARD_MSGMAX;
 
-static int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
-static int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
+static unsigned int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
+static unsigned int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
 
-static const struct ctl_table mq_sysctls[] = {
+static const struct sysctl_field mq_sysctls[] = {
 	{
 		.procname	= "queues_max",
-		.data		= &init_ipc_ns.mq_queues_max,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_UINT,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   mq_queues_max),
 	},
 	{
 		.procname	= "msg_max",
-		.data		= &init_ipc_ns.mq_msg_max,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   mq_msg_max),
+		.uint_limits = {
+			.min	= &msg_max_limit_min,
+			.max	= &msg_max_limit_max,
+		},
 	},
 	{
 		.procname	= "msgsize_max",
-		.data		= &init_ipc_ns.mq_msgsize_max,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   mq_msgsize_max),
+		.uint_limits = {
+			.min	= &msg_maxsize_limit_min,
+			.max	= &msg_maxsize_limit_max,
+		},
 	},
 	{
 		.procname	= "msg_default",
-		.data		= &init_ipc_ns.mq_msg_default,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   mq_msg_default),
+		.uint_limits = {
+			.min	= &msg_max_limit_min,
+			.max	= &msg_max_limit_max,
+		},
 	},
 	{
 		.procname	= "msgsize_default",
-		.data		= &init_ipc_ns.mq_msgsize_default,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct ipc_namespace,
+							   mq_msgsize_default),
+		.uint_limits = {
+			.min	= &msg_maxsize_limit_min,
+			.max	= &msg_maxsize_limit_max,
+		},
 	},
 };
 
@@ -116,39 +124,17 @@ static struct ctl_table_root set_root = {
 
 bool setup_mq_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
+		.type = SYSCTL_CONTEXT_IPC_NS,
+		.object_size = sizeof(*ns),
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
+	ns->mq_sysctls = register_sysctl_fields(&ns->mq_set, "fs/mqueue",
+						mq_sysctls, &ctx);
 	if (!ns->mq_sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->mq_set);
 		return false;
 	}
@@ -158,10 +144,6 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 
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

