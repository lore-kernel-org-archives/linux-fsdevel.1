Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1853486427;
	Mon, 21 Sep 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988157; cv=none; b=XIX8dyjNwK6oR+UMrTpw0ETh0mATgSOsXqhDPUtMJ/rjoLYehQpcLg9weYGA68dQPgSOueFn589JBGqcZeCr1if/gNtW/fJksP2A+W6rd5cSTbfQKwMb7/5OCa3AVjnnz/M1IGwfCxvDCBTa3nrf8/v3jguK/mEclTj4E+CCxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988157; c=relaxed/simple;
	bh=GsVNMZg9klMMQQwBPxPcPZRAqDUCP94pkiLbCWUKh4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgRMKdGHH3iBjMS2NnuJHBSUwFjoZ3TTqKPtYFKnbGFmr0oAOK8lvuy35RX/qN7cSeVE3BeNduwEYvxXpe7itX4x3CtQGND0tixhtqDsygT8V/mLwSOOAanmyq4453ZyoSc0zWxmcmmdr9G2xgd4MQTGp0Hzqs1NuDhG6OLtWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaFUfDGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaFUfDGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99531F000FF;
	Mon, 21 Sep 2026 10:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988155;
	bh=ig+mKn9ccsLpFcuetfalV5LhPHmt64olnrUCcYh1dlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HaFUfDGNvkvFuetIzT6BIoRjbjjROYpSZVYJYNRKKqQ7Pb/KA9nBNRtZhA7PW0W6U
	 tLu0XMDK8wEt6ieR7PbtMvrWrm6HQ6TUo6R9cnVXRRA4A0mJioDrSxFM7y2b+iVgWw
	 Zudw8czLLerzgu3O4Rop5xGgXYbXuRKCNnatZv1BGVLRumXdBHrv6ddKo+wS6pnTd3
	 PgQ1dMh0DdZJjuXDMoBuEAXe5CbOgpSDCL3A5iCvdJgZdpbNExv8g62d7jOxi5pLUH
	 JKME1TS8Kzcuc3j8Y6m0H2gpKh1Gb9IcE2QEJ3mbwbldfhDG1QaePH/LOKjuOZT/4r
	 etjSFYlSBueqw==
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
Subject: [PATCH v2 6/6] sysctl: use typed fields for ucount limits
Date: Mon, 21 Sep 2026 12:54:53 +0200
Message-ID: <06aa655ff61a31a874b4eae682464055039f4953.1789987960.git.legion@kernel.org>
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

User namespace sysctl registration clones the entire ctl_table and
assigns ucount_max entries by table index. This allocates a table for
every user namespace and makes the data mapping depend on the descriptor
order.

Use typed field offsets to associate each entry explicitly with its
ucount_max element. The static descriptor array can then be shared by
all user namespaces without allocating or rewriting a ctl_table copy.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 kernel/ucount.c | 64 +++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index ec8b1445e287..9f71ddefd18e 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -64,34 +64,38 @@ static struct ctl_table_root set_root = {
 static long ue_zero = 0;
 static long ue_int_max = INT_MAX;
 
-#define UCOUNT_ENTRY(name)					\
+#define UCOUNT_ENTRY(name, ucount)				\
 	{							\
 		.procname	= name,				\
-		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
-		.proc_handler	= proc_doulongvec_minmax,	\
-		.extra1		= &ue_zero,			\
-		.extra2		= &ue_int_max,			\
+		.type		= SYSCTL_FIELD_LONG_MINMAX,	\
+		.data_offset	= SYSCTL_FIELD_LONG_OFFSET(struct user_namespace, \
+							   ucount_max[ucount]),   \
+		.long_limits	= {				\
+			.min	= &ue_zero,			\
+			.max	= &ue_int_max,			\
+		}						\
 	}
-static const struct ctl_table user_table[] = {
-	UCOUNT_ENTRY("max_user_namespaces"),
-	UCOUNT_ENTRY("max_pid_namespaces"),
-	UCOUNT_ENTRY("max_uts_namespaces"),
-	UCOUNT_ENTRY("max_ipc_namespaces"),
-	UCOUNT_ENTRY("max_net_namespaces"),
-	UCOUNT_ENTRY("max_mnt_namespaces"),
-	UCOUNT_ENTRY("max_cgroup_namespaces"),
-	UCOUNT_ENTRY("max_time_namespaces"),
+static const struct sysctl_field user_table[] = {
+	UCOUNT_ENTRY("max_user_namespaces",	UCOUNT_USER_NAMESPACES),
+	UCOUNT_ENTRY("max_pid_namespaces",	UCOUNT_PID_NAMESPACES),
+	UCOUNT_ENTRY("max_uts_namespaces",	UCOUNT_UTS_NAMESPACES),
+	UCOUNT_ENTRY("max_ipc_namespaces",	UCOUNT_IPC_NAMESPACES),
+	UCOUNT_ENTRY("max_net_namespaces",	UCOUNT_NET_NAMESPACES),
+	UCOUNT_ENTRY("max_mnt_namespaces",	UCOUNT_MNT_NAMESPACES),
+	UCOUNT_ENTRY("max_cgroup_namespaces",	UCOUNT_CGROUP_NAMESPACES),
+	UCOUNT_ENTRY("max_time_namespaces",	UCOUNT_TIME_NAMESPACES),
 #ifdef CONFIG_INOTIFY_USER
-	UCOUNT_ENTRY("max_inotify_instances"),
-	UCOUNT_ENTRY("max_inotify_watches"),
+	UCOUNT_ENTRY("max_inotify_instances",	UCOUNT_INOTIFY_INSTANCES),
+	UCOUNT_ENTRY("max_inotify_watches",	UCOUNT_INOTIFY_WATCHES),
 #endif
 #ifdef CONFIG_FANOTIFY
-	UCOUNT_ENTRY("max_fanotify_groups"),
-	UCOUNT_ENTRY("max_fanotify_marks"),
+	UCOUNT_ENTRY("max_fanotify_groups",	UCOUNT_FANOTIFY_GROUPS),
+	UCOUNT_ENTRY("max_fanotify_marks",	UCOUNT_FANOTIFY_MARKS),
 #endif
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
-	UCOUNT_ENTRY("max_binfmt_misc_interpreters"),
+	UCOUNT_ENTRY("max_binfmt_misc_interpreters",
+		     UCOUNT_BINFMT_MISC_INTERPRETERS),
 #endif
 };
 #endif /* CONFIG_SYSCTL */
@@ -99,21 +103,17 @@ static const struct ctl_table user_table[] = {
 bool setup_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
+		.type = SYSCTL_CONTEXT_USER_NS,
+		.object_size = sizeof(*ns),
+		.ns.user_ns = ns,
+	};
 
 	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS);
 	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
-	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
-	if (tbl) {
-		int i;
-		for (i = 0; i < UCOUNT_COUNTS; i++) {
-			tbl[i].data = &ns->ucount_max[i];
-		}
-		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl,
-						      ARRAY_SIZE(user_table));
-	}
+	ns->sysctls = register_sysctl_fields(&ns->set, "user",
+					     user_table, &ctx);
 	if (!ns->sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->set);
 		return false;
 	}
@@ -124,12 +124,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 void retire_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	const struct ctl_table *tbl;
-
-	tbl = ns->sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->sysctls);
 	retire_sysctl_set(&ns->set);
-	kfree(tbl);
 #endif
 }
 
-- 
2.55.0

