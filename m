Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA83246EB;
	Wed, 26 Aug 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773446; cv=none; b=Dyz3H4HNc6Ve+dbwTSH8ashQ49a9h2DGqlo5WTf5T5cRo7I8+Qp3WmSqAy79+WQpUJ9eBjT9fg9dDgM9gt219e/pXod5fehRf0tUURO4pkaiNgJ7y6k4eQrR1/3kry3v8otky+wcfw4EBg699tk3ozPB5OrkYoCVKmuBhePXcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773446; c=relaxed/simple;
	bh=bhyiv1Jkrrs54md0oyrqchRAs1u7SKnGU8jHhjrJGXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeY0GRo2Y9xQ2j8FHELQotgLqitxljQVRMAFv7c0CeYeQKDWLEtd1BZKCVwzzFkjRILNU4/rzUuQRCgCsfw+Tfeb0XAA3B1CVVxiimYqoZjQzML662RT38s5SN0pdGp+q1X9t29eET44GTjQ6mCyUdcULOZeFxpF+zjZsWH4a/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnVhaAsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnVhaAsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E0C1F00A3F;
	Wed, 26 Aug 2026 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773428;
	bh=y2ROpc4uD0rGfQMdAIMUYc6Gn/DfvJSYMhDkknCQjEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnVhaAshcJeRZlDnxb3EujIlvEtMVbKTJG+HVTKkgE5TWeA/zgi/+bGh7QzSN0XF9
	 J4O2Il7ZgJYk+bJR+EgGk5PJtVy8MDbeO3QCHhLuoQCyi7e4/4TRocu2qZuCU/gIAy
	 vXif2jUc8t6bEg+WaQFvYEAufCbJptSqWS4tzrCCkvFZLp2c+o4UbiKjW5YGduMNJi
	 Dj7jpQTocd188FLVtFCbb/cacz7+cL6TqDNTOsMYLj0KUpOkFGJXxW1u4pJ3DvALod
	 8ZLZ8GwirrizcsWXlaPLYC8rCm/d8Yd7BZQPZ3vwCBrwMpGQz4kJQAn9pQ/gy2S9m2
	 TsPYL5Syz0ljQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 20/30] sysctl: net: use sysctl_field in SMC sysctls
Date: Wed, 26 Aug 2026 21:42:24 +0200
Message-ID: <712a0838959576d866e15ecf2d6e3d235815f696.1787771905.git.legion@kernel.org>
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

SMC sysctls are per-net, but non-init network namespaces currently get
a private ctl_table copy only so each data pointer can be adjusted from
init_net to the target net namespace. The copied table is then kept
around solely for unregister time.

Use sysctl_field so the data pointers are derived from the registration
context instead. This keeps the SMC sysctl description static and const
while preserving the existing per-net behaviour and the optional
handshake-control inheritance.

While converting the table, handle limit_smc_hs through a bool-aware
custom handler. The old ctl_table entry described the bool storage as
an int and relied on the untyped sysctl interface to hide that mismatch.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/smc/smc_sysctl.c | 208 ++++++++++++++++++-------------------------
 1 file changed, 89 insertions(+), 119 deletions(-)

diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index b1efed546243..801bbd8773d3 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -97,112 +97,98 @@ static int proc_smc_hs_ctrl(const struct ctl_table *ctl, int write,
 }
 #endif /* CONFIG_SMC_HS_CTRL_BPF */
 
-static struct ctl_table smc_table[] = {
-	{
-		.procname       = "autocorking_size",
-		.data           = &init_net.smc.sysctl_autocorking_size,
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler	= proc_douintvec,
-	},
-	{
-		.procname	= "smcr_buf_type",
-		.data		= &init_net.smc.sysctl_smcr_buf_type,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "smcr_testlink_time",
-		.data		= &init_net.smc.sysctl_smcr_testlink_time,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "wmem",
-		.data		= &init_net.smc.sysctl_wmem,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
-		.extra2		= &max_sndbuf,
-	},
-	{
-		.procname	= "rmem",
-		.data		= &init_net.smc.sysctl_rmem,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
-		.extra2		= &max_rcvbuf,
-	},
-	{
-		.procname	= "smcr_max_links_per_lgr",
-		.data		= &init_net.smc.sysctl_max_links_per_lgr,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &links_per_lgr_min,
-		.extra2		= &links_per_lgr_max,
-	},
-	{
-		.procname	= "smcr_max_conns_per_lgr",
-		.data		= &init_net.smc.sysctl_max_conns_per_lgr,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &conns_per_lgr_min,
-		.extra2		= &conns_per_lgr_max,
-	},
-	{
-		.procname	= "limit_smc_hs",
-		.data		= &init_net.smc.limit_smc_hs,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "smcr_max_send_wr",
-		.data		= &init_net.smc.sysctl_smcr_max_send_wr,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &smcr_max_wr_min,
-		.extra2		= &smcr_max_wr_max,
-	},
-	{
-		.procname	= "smcr_max_recv_wr",
-		.data		= &init_net.smc.sysctl_smcr_max_recv_wr,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &smcr_max_wr_min,
-		.extra2		= &smcr_max_wr_max,
-	},
+#define SMC_SYSCTL_DATA(type, name)					\
+static type *smc_##name##_data(const struct sysctl_context *ctx)		\
+{									\
+	return &ctx->ns.net_ns->smc.sysctl_##name;			\
+}
+
+#define SMC_SYSCTL_CUSTOM_DATA(name)					\
+static void *smc_##name##_data(const struct sysctl_context *ctx)		\
+{									\
+	return &ctx->ns.net_ns->smc.sysctl_##name;			\
+}
+
+SMC_SYSCTL_DATA(unsigned int, autocorking_size)
+SMC_SYSCTL_DATA(unsigned int, smcr_buf_type)
+SMC_SYSCTL_CUSTOM_DATA(smcr_testlink_time)
+SMC_SYSCTL_DATA(int, wmem)
+SMC_SYSCTL_DATA(int, rmem)
+SMC_SYSCTL_DATA(int, max_links_per_lgr)
+SMC_SYSCTL_DATA(int, max_conns_per_lgr)
+SMC_SYSCTL_DATA(unsigned int, smcr_max_send_wr)
+SMC_SYSCTL_DATA(unsigned int, smcr_max_recv_wr)
+
+static void *smc_limit_smc_hs_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->smc.limit_smc_hs;
+}
+
+static int proc_smc_limit_smc_hs(const struct ctl_table *ctl, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	bool *limit_smc_hs = ctl->data;
+	struct ctl_table tmp = *ctl;
+	int val = READ_ONCE(*limit_smc_hs);
+	int ret;
+
+	tmp.data = &val;
+	tmp.maxlen = sizeof(val);
+	tmp.extra1 = SYSCTL_ZERO;
+	tmp.extra2 = SYSCTL_ONE;
+
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret)
+		WRITE_ONCE(*limit_smc_hs, val);
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
-	{
-		.procname	= "hs_ctrl",
-		.data		= &init_net.smc.hs_ctrl,
-		.mode		= 0644,
-		.maxlen		= SMC_HS_CTRL_NAME_MAX,
-		.proc_handler	= proc_smc_hs_ctrl,
-	},
-#endif /* CONFIG_SMC_HS_CTRL_BPF */
+static void *smc_hs_ctrl_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->smc.hs_ctrl;
+}
+#endif
+
+static const struct sysctl_field smc_table[] = {
+	SYSCTL_FIELD_UINT("autocorking_size", 0644, smc_autocorking_size_data),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("smcr_buf_type", 0644,
+				     smc_smcr_buf_type_data,
+				     SYSCTL_UINT_ZERO, SYSCTL_UINT_TWO),
+	SYSCTL_FIELD_CUSTOM("smcr_testlink_time", 0644, sizeof(int),
+			 smc_smcr_testlink_time_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("wmem", 0644, smc_wmem_data,
+				    &min_sndbuf, &max_sndbuf),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("rmem", 0644, smc_rmem_data,
+				    &min_rcvbuf, &max_rcvbuf),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("smcr_max_links_per_lgr", 0644,
+				    smc_max_links_per_lgr_data,
+				    &links_per_lgr_min, &links_per_lgr_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("smcr_max_conns_per_lgr", 0644,
+				    smc_max_conns_per_lgr_data,
+				    &conns_per_lgr_min, &conns_per_lgr_max),
+	SYSCTL_FIELD_CUSTOM("limit_smc_hs", 0644, sizeof(bool),
+			 smc_limit_smc_hs_data, proc_smc_limit_smc_hs),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("smcr_max_send_wr", 0644,
+				     smc_smcr_max_send_wr_data,
+				     &smcr_max_wr_min, &smcr_max_wr_max),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("smcr_max_recv_wr", 0644,
+				     smc_smcr_max_recv_wr_data,
+				     &smcr_max_wr_min, &smcr_max_wr_max),
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+	SYSCTL_FIELD_CUSTOM("hs_ctrl", 0644, SMC_HS_CTRL_NAME_MAX,
+			 smc_hs_ctrl_data, proc_smc_hs_ctrl),
+#endif
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(smc_table);
-	struct ctl_table *table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-	table = smc_table;
 	if (!net_eq(net, &init_net)) {
-		int i;
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
 		struct smc_hs_ctrl *ctrl;
 
@@ -213,19 +199,12 @@ int __net_init smc_sysctl_net_init(struct net *net)
 			rcu_assign_pointer(net->smc.hs_ctrl, ctrl);
 		rcu_read_unlock();
 #endif /* CONFIG_SMC_HS_CTRL_BPF */
-
-		table = kmemdup(table, sizeof(smc_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-
-		for (i = 0; i < table_size; i++)
-			table[i].data += (void *)net - (void *)&init_net;
 	}
 
-	net->smc.smc_hdr = register_net_sysctl_sz(net, "net/smc", table,
-						  table_size);
+	net->smc.smc_hdr = register_sysctl_fields(&net->sysctls, "net/smc",
+						  smc_table, &ctx);
 	if (!net->smc.smc_hdr)
-		goto err_reg;
+		goto err_alloc;
 
 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
 	net->smc.sysctl_smcr_buf_type = SMCR_PHYS_CONT_BUFS;
@@ -237,13 +216,10 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
 	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
 	/* disable handshake limitation by default */
-	net->smc.limit_smc_hs = 0;
+	net->smc.limit_smc_hs = false;
 
 	return 0;
 
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
 err_alloc:
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
 	smc_net_replace_smc_hs_ctrl(net, NULL);
@@ -253,14 +229,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 
 void __net_exit smc_sysctl_net_exit(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->smc.smc_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->smc.smc_hdr);
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
 	smc_net_replace_smc_hs_ctrl(net, NULL);
 #endif /* CONFIG_SMC_HS_CTRL_BPF */
-
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
-- 
2.55.0

