Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434C46D2BF;
	Wed, 26 Aug 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773405; cv=none; b=PyeDuLEKlg6LQEHbqNxMkrVyP8sNY/GuzejmnqtqaGC9o0eVmRiQW27ltoKa45AMrLZWF9nsnujGn33KxpvxcF7EL7D+hrv3736V+rOG2sdjj7omyJRHkOlBiNaabyvWUlxb6Am33MkR0BbTXMJNOxxgJiiwg3AhEfIfMjKKT/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773405; c=relaxed/simple;
	bh=Ab0msZaxi/TU6jUBj/FFMjRm6z0o9SC6ZJdCrR/cods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZWYM/wtItepMwcza828BNm5b0CR/VQzvcFZh0SZlVRVIAWPO9o8pVst+A4HVGlbhG7nxIP2H1bqjja7i32sb2VDNFLqynEG074kODRGeHAPZkMRtyssh9VisoLUfebmbA1G1CpprUzlf/oPRgwPsU7xyogHJrzsb5B2PvS7Eek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLGVyePq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLGVyePq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023B61F0155E;
	Wed, 26 Aug 2026 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773387;
	bh=Iz5OAe5CTnf/IpR1m7blz6RjHcYdlEsp0NHitnPRLzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLGVyePqXfpfxJ8ptpsJS792Aatz5zwP0TIDbuU6IYwCV3VZulOqcnc9u8RSDFUNk
	 R9tWJI+96mucrNrOxXrpJCacomkNTnPAT7oxzSDoK9C2MTYQse7F2VElpLqQlQ94HF
	 wi0vpMZdnoepR1GfPYbOksa170L7OvGP8vFIxkYyUfU3LZWv0JoN1eLSLWFVgriiwv
	 D1/IOzpST3w/CDCtRenCpqjZmKaEYeB+iEJmcdT91VwhkD/WKv0siXiMaHCrn6e4ih
	 egraj2+9WPEnjsBF8OIbru0CXJderj0HocIvx3MvyVGjTBK/GmK1crUiEP8vbUSiA5
	 IftCTvMyvsKlQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 04/30] sysctl: use sysctl_field in ucounts
Date: Wed, 26 Aug 2026 21:42:08 +0200
Message-ID: <fa4bde9bced5367d31525c59375a25e962385652.1787771905.git.legion@kernel.org>
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

Convert ucount sysctls. The table can now share one static array across
namespaces instead of allocating and rewriting a ctl_table copy for each
registration.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 kernel/ucount.c | 83 +++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index d6dc3e859f12..e16d858b663b 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -60,34 +60,48 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static long ue_zero = 0;
-static long ue_int_max = INT_MAX;
-
-#define UCOUNT_ENTRY(name)					\
-	{							\
-		.procname	= name,				\
-		.maxlen		= sizeof(long),			\
-		.mode		= 0644,				\
-		.proc_handler	= proc_doulongvec_minmax,	\
-		.extra1		= &ue_zero,			\
-		.extra2		= &ue_int_max,			\
-	}
-static const struct ctl_table user_table[] = {
-	UCOUNT_ENTRY("max_user_namespaces"),
-	UCOUNT_ENTRY("max_pid_namespaces"),
-	UCOUNT_ENTRY("max_uts_namespaces"),
-	UCOUNT_ENTRY("max_ipc_namespaces"),
-	UCOUNT_ENTRY("max_net_namespaces"),
-	UCOUNT_ENTRY("max_mnt_namespaces"),
-	UCOUNT_ENTRY("max_cgroup_namespaces"),
-	UCOUNT_ENTRY("max_time_namespaces"),
+static unsigned long ue_zero = 0;
+static unsigned long ue_int_max = INT_MAX;
+
+#define UCOUNT_DATA(name, type)						\
+static unsigned long *name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.user_ns->ucount_max[type];			\
+}
+
+UCOUNT_DATA(user_ns, UCOUNT_USER_NAMESPACES);
+UCOUNT_DATA(pid_ns, UCOUNT_PID_NAMESPACES);
+UCOUNT_DATA(uts_ns, UCOUNT_UTS_NAMESPACES);
+UCOUNT_DATA(ipc_ns, UCOUNT_IPC_NAMESPACES);
+UCOUNT_DATA(net_ns, UCOUNT_NET_NAMESPACES);
+UCOUNT_DATA(mnt_ns, UCOUNT_MNT_NAMESPACES);
+UCOUNT_DATA(cgroup_ns, UCOUNT_CGROUP_NAMESPACES);
+UCOUNT_DATA(time_ns, UCOUNT_TIME_NAMESPACES);
+#ifdef CONFIG_INOTIFY_USER
+UCOUNT_DATA(inotify_instances, UCOUNT_INOTIFY_INSTANCES);
+UCOUNT_DATA(inotify_watches, UCOUNT_INOTIFY_WATCHES);
+#endif
+#ifdef CONFIG_FANOTIFY
+UCOUNT_DATA(fanotify_groups, UCOUNT_FANOTIFY_GROUPS);
+UCOUNT_DATA(fanotify_marks, UCOUNT_FANOTIFY_MARKS);
+#endif
+
+static const struct sysctl_field user_table[] = {
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_user_namespaces", 0644, user_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_pid_namespaces", 0644, pid_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_uts_namespaces", 0644, uts_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_ipc_namespaces", 0644, ipc_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_net_namespaces", 0644, net_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_mnt_namespaces", 0644, mnt_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_cgroup_namespaces", 0644, cgroup_ns_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_time_namespaces", 0644, time_ns_data, &ue_zero, &ue_int_max),
 #ifdef CONFIG_INOTIFY_USER
-	UCOUNT_ENTRY("max_inotify_instances"),
-	UCOUNT_ENTRY("max_inotify_watches"),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_inotify_instances", 0644, inotify_instances_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_inotify_watches", 0644, inotify_watches_data, &ue_zero, &ue_int_max),
 #endif
 #ifdef CONFIG_FANOTIFY
-	UCOUNT_ENTRY("max_fanotify_groups"),
-	UCOUNT_ENTRY("max_fanotify_marks"),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_fanotify_groups", 0644, fanotify_groups_data, &ue_zero, &ue_int_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_fanotify_marks", 0644, fanotify_marks_data, &ue_zero, &ue_int_max),
 #endif
 };
 #endif /* CONFIG_SYSCTL */
@@ -95,21 +109,14 @@ static const struct ctl_table user_table[] = {
 bool setup_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	struct sysctl_context ctx = {
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
+	ns->sysctls = register_sysctl_fields(&ns->set, "user", user_table, &ctx);
 	if (!ns->sysctls) {
-		kfree(tbl);
 		retire_sysctl_set(&ns->set);
 		return false;
 	}
@@ -120,12 +127,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
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

