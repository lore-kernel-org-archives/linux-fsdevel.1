Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD5477E40;
	Wed, 26 Aug 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773405; cv=none; b=RxKPArqmTcri8S+ZAtiUDSYWeowXCgZM42xahG2DFjAM6neTpXlZ3+sWldN2hGDD4WQyaasMk10VaXRwYcydjiqpCozT/Lk18oXUnDD+b/RIVtxSBOaU0jCIWxxBxbCDK3Sx7YlgaDbO1lRj6wq50XBPF9eLcRQvODDIV2MpOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773405; c=relaxed/simple;
	bh=Bcz1MZ8Q32vyBtyrN9pTh/NadkK8UTa59+jG2LM1st0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bni5xWGUmWHMZUIVN1LxzCXewC1hjUMV0ev8f76vBdGwabWXLEk73ZBPzlCXDZH6bGoHioakTMJLw0AmlOJ0Le4enLkiJ7KKD23JlorWoG0zK9Ab+Z7WzXM8ZVwZHLDtegEfn0nrWMiHh7DdgizEIYRQ5CRU3gadBHH1J4fBJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLsD/xI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLsD/xI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44471F00ACA;
	Wed, 26 Aug 2026 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773393;
	bh=rECxYtYGBnc9yFBMas7AiwdD+MFhzs7LutGnl1Pz+u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLsD/xI3TpHcgOPBXo6EERXFhnTjeVqdDAKQDbe0gX1nBQkrxleLfXx/0ozPXIihv
	 H7hoFtZ1n0J9BSjJcrkmZsQnoNxdovBWhvAkciw8Ss8pscxxdPRwNRwn2WNkMbPyql
	 HxqASh39eQBQEKlEOy4O1g/oPzQYXXPmMKXG9rU2tG3oM5ruiPof3vgHMdc/C+7rZX
	 mbJxVuo9z5pdimG6IqOn8S5WYHFpZw7DHQKz3wwUIfw7cw/yQvoDh5gF/2Xy6o+nSz
	 KbTKhM7pOQIitC6Gu2llzp2EJ+GoDAad9M23W9wRCHRXioy+DXn6TIDYRhhvJCM6EA
	 COumZawSi0jWw==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 07/30] sysctl: use sysctl_field in pid sysctls
Date: Wed, 26 Aug 2026 21:42:11 +0200
Message-ID: <5255613ea0a1a8fed8c1f1f53633fb5714328fc9.1787771905.git.legion@kernel.org>
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

The pid namespace sysctl registration allocates a private ctl_table copy
only to replace the static pid_max data pointer with the value from the
registered namespace. This keeps otherwise shared sysctl metadata
writable at registration time and requires per-namespace table lifetime
management.

Use a sysctl_field accessor to derive pid_max from the registration
context instead. The pid sysctl table can remain static and const, while
registration no longer needs to clone, patch and free a ctl_table array.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/sysctl.h |  2 ++
 kernel/pid.c           | 41 +++++++++++++----------------------------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e2831190e484..056d10f4ab3d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -39,6 +39,7 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 struct ipc_namespace;
+struct pid_namespace;
 struct user_namespace;
 
 /* Keep the same order as in fs/proc/proc_sysctl.c */
@@ -92,6 +93,7 @@ struct sysctl_context {
 	union {
 		struct user_namespace *user_ns;
 		struct ipc_namespace *ipc_ns;
+		struct pid_namespace *pid_ns;
 	} ns;
 };
 
diff --git a/kernel/pid.c b/kernel/pid.c
index fd5c2d4aa349..66991ee435fb 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -787,23 +787,15 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
 	return 0;
 }
 
-static const struct ctl_table pid_table[] = {
-	{
-		.procname	= "pid_max",
-		.data		= &init_pid_ns.pid_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &pid_max_min,
-		.extra2		= &pid_max_max,
-	},
+static int *pid_max_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.pid_ns->pid_max;
+}
+
+static const struct sysctl_field pid_table[] = {
+	SYSCTL_FIELD_STATIC_INT_MINMAX("pid_max", 0644, pid_max_data, &pid_max_min, &pid_max_max),
 #ifdef CONFIG_PROC_SYSCTL
-	{
-		.procname	= "cad_pid",
-		.maxlen		= sizeof(int),
-		.mode		= 0600,
-		.proc_handler	= proc_do_cad_pid,
-	},
+	SYSCTL_FIELD_CUSTOM("cad_pid", 0600, sizeof(int), NULL, proc_do_cad_pid),
 #endif
 };
 #endif
@@ -811,21 +803,18 @@ static const struct ctl_table pid_table[] = {
 int register_pidns_sysctls(struct pid_namespace *pidns)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
+		.ns.pid_ns = pidns,
+	};
 
 	setup_sysctl_set(&pidns->set, &pid_table_root, set_is_seen);
 
-	tbl = kmemdup(pid_table, sizeof(pid_table), GFP_KERNEL);
-	if (!tbl)
-		return -ENOMEM;
-	tbl->data = &pidns->pid_max;
 	pidns->pid_max = min(pid_max_max, max_t(int, pidns->pid_max,
 			     PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
 
-	pidns->sysctls = __register_sysctl_table(&pidns->set, "kernel", tbl,
-						 ARRAY_SIZE(pid_table));
+	pidns->sysctls = register_sysctl_fields(&pidns->set, "kernel",
+						pid_table, &ctx);
 	if (!pidns->sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&pidns->set);
 		return -ENOMEM;
 	}
@@ -836,12 +825,8 @@ int register_pidns_sysctls(struct pid_namespace *pidns)
 void unregister_pidns_sysctls(struct pid_namespace *pidns)
 {
 #ifdef CONFIG_SYSCTL
-	const struct ctl_table *tbl;
-
-	tbl = pidns->sysctls->ctl_table_arg;
 	unregister_sysctl_table(pidns->sysctls);
 	retire_sysctl_set(&pidns->set);
-	kfree(tbl);
 #endif
 }
 
-- 
2.55.0

