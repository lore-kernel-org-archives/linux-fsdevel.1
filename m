Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50747D92D;
	Wed, 26 Aug 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773436; cv=none; b=BogAkaOPREfaX7/o1+NQwh8PILKGF+51JqVERyGY/st/96gZ+BX7nIasZrw+u8zVabvWHUoScx/IuCx66g1SyOGl6wpZ0rhL3/EIm0TspmgXC/+8Y3I6Onc3j80q7yQytbmsYX3AkfUiICMB63xX3JRG3om5kZ1ZB44QpE1T3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773436; c=relaxed/simple;
	bh=DoHlu0xutMxVPK6LoL6tUPhLRL4Cw+eeRcZo1duk+RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv5tCSN1h6rkCAZBjlJELzve3h5fL6N4VAMEKZp4QPo1CGORV/JLsW65ZeD2lVkB9vtgElWSbRWMllNFP/aIJIEDk+FmRmjUoWo3+/V4lJjbNvusyuV4j0Q3DkqEkyiApwiB8+eEIa/NHVnhc9DQdd2DJbZA76g/i+UY89rYHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlUr9Pti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlUr9Pti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5091F00A3D;
	Wed, 26 Aug 2026 19:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773419;
	bh=4gz+97P0/XuukTP+p4wNJbzrSZtAHNytbTFlb2BPGuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GlUr9PtisGPlibimv+WZ1HLFryukjg+sGbS0UHVPzEj2ThQ0Rd1H4GwWpyahUZ7nv
	 dBul2C9LdYwla8MHr9LKARoU65BoR+3vwdnSIZg8U9yuOgbh5rvZnHqv0yu4uoFPlT
	 axcUuOls1/tzTX6XkiFMxkHi9RcJh4hHp/rC4ufgXvilZD/XY4VFcZdSK3ijbTrrlp
	 hSfN0VSAT47vo+ob23AfAwyZ+oVnlTMrNFq2T802iAcorvyLLMvyzZoKwHelF53gyZ
	 27xLqbgssMoQGILaeH7u46gm7BfH+mFvnvAmq2ehOYbxr2UMMZoPloY3jST4xgPhsE
	 alIsE8JA3yN3w==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 16/30] sysctl: net: use sysctl_field in MPTCP sysctls
Date: Wed, 26 Aug 2026 21:42:20 +0200
Message-ID: <51ceb37be6b9ce95858f64117920922e0af7b39b.1787771905.git.legion@kernel.org>
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

The MPTCP sysctl table is cloned for every non-init network namespace
only to bind the entries to that namespace's pernet state. The cloned
table is then patched by index, which makes the registration path depend
on the table layout staying in sync with the data pointer assignments.

Use sysctl_field descriptors so the data pointers are derived from the
registration context. Keep the special min/max handling inside the
custom handlers that need it, and leave read-only informational entries
without data pointers.

This keeps the table const and removes the per-net allocation, pointer
patching, and free path.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/mptcp/ctrl.c | 205 ++++++++++++++++++-----------------------------
 1 file changed, 76 insertions(+), 129 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d96130e49942..31bde3e2eb28 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,7 +19,7 @@
 static int mptcp_pernet_id;
 
 #ifdef CONFIG_SYSCTL
-static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
+static unsigned int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
 #endif
 
 struct mptcp_pernet {
@@ -172,9 +172,12 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 	struct mptcp_pernet *pernet = container_of(table->data,
 						   struct mptcp_pernet,
 						   blackhole_timeout);
+	struct ctl_table tmp = *table;
 	int ret;
 
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_ZERO;
+
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		atomic_set(&pernet->active_disable_times, 0);
 
@@ -236,9 +239,13 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
 	struct mptcp_pernet *pernet = container_of(ctl->data,
 						   struct mptcp_pernet,
 						   pm_type);
+	struct ctl_table tmp = *ctl;
 	int ret;
 
-	ret = proc_dou8vec_minmax(ctl, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_UINT_ZERO;
+	tmp.extra2 = &mptcp_pm_type_max;
+
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
 		u8 pm_type = READ_ONCE(*(u8 *)ctl->data);
 		char *pm_name = "";
@@ -271,148 +278,88 @@ static int proc_available_path_managers(const struct ctl_table *ctl,
 	return ret;
 }
 
-static struct ctl_table mptcp_sysctl_table[] = {
-	{
-		.procname = "enabled",
-		.maxlen = sizeof(u8),
-		.mode = 0644,
-		/* users with CAP_NET_ADMIN or root (not and) can change this
-		 * value, same as other sysctl or the 'net' tree.
-		 */
-		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
-	},
-	{
-		.procname = "add_addr_timeout",
-		.maxlen = sizeof(unsigned int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_jiffies,
-	},
-	{
-		.procname = "checksum_enabled",
-		.maxlen = sizeof(u8),
-		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
-	},
-	{
-		.procname = "allow_join_initial_addr_port",
-		.maxlen = sizeof(u8),
-		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
-	},
-	{
-		.procname = "stale_loss_cnt",
-		.maxlen = sizeof(unsigned int),
-		.mode = 0644,
-		.proc_handler = proc_douintvec_minmax,
-	},
-	{
-		.procname = "pm_type",
-		.maxlen = sizeof(u8),
-		.mode = 0644,
-		.proc_handler = proc_pm_type,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = &mptcp_pm_type_max
-	},
-	{
-		.procname = "scheduler",
-		.maxlen	= MPTCP_SCHED_NAME_MAX,
-		.mode = 0644,
-		.proc_handler = proc_scheduler,
-	},
-	{
-		.procname = "available_schedulers",
-		.maxlen	= MPTCP_SCHED_BUF_MAX,
-		.mode = 0444,
-		.proc_handler = proc_available_schedulers,
-	},
-	{
-		.procname = "close_timeout",
-		.maxlen = sizeof(unsigned int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_jiffies,
-	},
-	{
-		.procname = "blackhole_timeout",
-		.maxlen = sizeof(unsigned int),
-		.mode = 0644,
-		.proc_handler = proc_blackhole_detect_timeout,
-		.extra1 = SYSCTL_ZERO,
-	},
-	{
-		.procname = "syn_retrans_before_tcp_fallback",
-		.maxlen = sizeof(u8),
-		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
-	},
-	{
-		.procname = "path_manager",
-		.maxlen	= MPTCP_PM_NAME_MAX,
-		.mode = 0644,
-		.proc_handler = proc_path_manager,
-	},
-	{
-		.procname = "available_path_managers",
-		.maxlen	= MPTCP_PM_BUF_MAX,
-		.mode = 0444,
-		.proc_handler = proc_available_path_managers,
-	},
+#define MPTCP_DATA(type, field)						\
+static type *mptcp_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &mptcp_get_pernet(ctx->ns.net_ns)->field;		\
+}
+
+#define MPTCP_CUSTOM_DATA(field)					\
+static void *mptcp_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &mptcp_get_pernet(ctx->ns.net_ns)->field;		\
+}
+
+static u8 *mptcp_enabled_data(const struct sysctl_context *ctx)
+{
+	return &mptcp_get_pernet(ctx->ns.net_ns)->mptcp_enabled;
+}
+
+MPTCP_CUSTOM_DATA(add_addr_timeout)
+MPTCP_DATA(u8, checksum_enabled)
+MPTCP_DATA(u8, allow_join_initial_addr_port)
+MPTCP_DATA(unsigned int, stale_loss_cnt)
+MPTCP_CUSTOM_DATA(pm_type)
+MPTCP_CUSTOM_DATA(scheduler)
+MPTCP_CUSTOM_DATA(close_timeout)
+MPTCP_CUSTOM_DATA(blackhole_timeout)
+MPTCP_DATA(u8, syn_retrans_before_tcp_fallback)
+MPTCP_CUSTOM_DATA(path_manager)
+
+static const struct sysctl_field mptcp_sysctl_table[] = {
+	/* users with CAP_NET_ADMIN or root (not and) can change this
+	 * value, same as other sysctl or the 'net' tree.
+	 */
+	SYSCTL_FIELD_STATIC_U8_MINMAX("enabled", 0644, mptcp_enabled_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM("add_addr_timeout", 0644, sizeof(unsigned int),
+			 mptcp_add_addr_timeout_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("checksum_enabled", 0644,
+				   mptcp_checksum_enabled_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("allow_join_initial_addr_port", 0644,
+				   mptcp_allow_join_initial_addr_port_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_UINT("stale_loss_cnt", 0644, mptcp_stale_loss_cnt_data),
+	SYSCTL_FIELD_CUSTOM("pm_type", 0644, sizeof(u8),
+			 mptcp_pm_type_data, proc_pm_type),
+	SYSCTL_FIELD_CUSTOM("scheduler", 0644, MPTCP_SCHED_NAME_MAX,
+			 mptcp_scheduler_data, proc_scheduler),
+	SYSCTL_FIELD_CUSTOM("available_schedulers", 0444, MPTCP_SCHED_BUF_MAX,
+			 NULL, proc_available_schedulers),
+	SYSCTL_FIELD_CUSTOM("close_timeout", 0644, sizeof(unsigned int),
+			 mptcp_close_timeout_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("blackhole_timeout", 0644, sizeof(unsigned int),
+			 mptcp_blackhole_timeout_data,
+			 proc_blackhole_detect_timeout),
+	SYSCTL_FIELD_U8("syn_retrans_before_tcp_fallback", 0644,
+		     mptcp_syn_retrans_before_tcp_fallback_data),
+	SYSCTL_FIELD_CUSTOM("path_manager", 0644, MPTCP_PM_NAME_MAX,
+			 mptcp_path_manager_data, proc_path_manager),
+	SYSCTL_FIELD_CUSTOM("available_path_managers", 0444, MPTCP_PM_BUF_MAX,
+			 NULL, proc_available_path_managers),
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 {
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct ctl_table_header *hdr;
-	struct ctl_table *table;
-
-	table = mptcp_sysctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(mptcp_sysctl_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-	}
 
-	table[0].data = &pernet->mptcp_enabled;
-	table[1].data = &pernet->add_addr_timeout;
-	table[2].data = &pernet->checksum_enabled;
-	table[3].data = &pernet->allow_join_initial_addr_port;
-	table[4].data = &pernet->stale_loss_cnt;
-	table[5].data = &pernet->pm_type;
-	table[6].data = &pernet->scheduler;
-	/* table[7] is for available_schedulers which is read-only info */
-	table[8].data = &pernet->close_timeout;
-	table[9].data = &pernet->blackhole_timeout;
-	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
-	table[11].data = &pernet->path_manager;
-	/* table[12] is for available_path_managers which is read-only info */
-
-	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
-				     ARRAY_SIZE(mptcp_sysctl_table));
+	hdr = register_sysctl_fields(&net->sysctls, MPTCP_SYSCTL_PATH,
+				     mptcp_sysctl_table, &ctx);
 	if (!hdr)
-		goto err_reg;
+		return -ENOMEM;
 
 	pernet->ctl_table_hdr = hdr;
 
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
 {
-	const struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
-
 	unregister_net_sysctl_table(pernet->ctl_table_hdr);
-
-	kfree(table);
 }
 
 #else
-- 
2.55.0

