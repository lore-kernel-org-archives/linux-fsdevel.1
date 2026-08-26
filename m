Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329B47CA6E;
	Wed, 26 Aug 2026 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773468; cv=none; b=ckS1Il4z8efX0DETGhMVl+s4GzNEWswxykTtX6rh73NO61S83CohotRX48AuzWVkedhoT+kDxWLQivqzimlWBUN38bNSOW+Kt+9h2Wow30zpF43Tf9wBG/2iZLq0/YUUnxFwOTE5+cf8uTtPSS5gK8kM73o1z8OqW++PYArSpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773468; c=relaxed/simple;
	bh=2rrXCuW6NuSKqMYac/0DKvr3I/mtMZGxeah+pXkt8TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO9nYWdzY4wNcfJt4n0iLj0W8P8afGXtWvbpe8KWUAzeQYkcuIKZK3YOiS//CmBBMzIxLyCWVMlVjAwrFYUWm2U11b0Nn2YwxCbUqP234UZGeEHweZEeIMYLLEzY7hWbxCqGHMS0WtIftSXSFaGqxdQ7wphQbU6FEtLPhuHbW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ28nj/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ28nj/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B119A1F00ACF;
	Wed, 26 Aug 2026 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773426;
	bh=Tcs+C8F57TEgo9uadC/oL5HEXBs30NuN7wUPsR31MRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZ28nj/9+TiQYpPf+wrum0Cy9AWiMiX3xj14z14Cxgujw2ks2nAyEMl87pQYKgUVP
	 +wEQSOJATk1Sn1n7ETDtvWf95wIExb0ZFVobsTgxZYWNsQyOq4nWbO9aOT/+Fi2gVf
	 YisRZXbYrdP+8/bLmFC3Txs3rpf7zDMqjqQp32FrVhsqxpk1hUjYDaIQZq8a2Q4UCr
	 nX3ps7nlEg2yAUvvFK0EadJyS5OsixKRF7Ckpdwf+4IRME4nZYfZd7lg6IWOh8E5/J
	 wQrN6paVHiLzg1E0yreuIAIO/3ff0wluzqWM01F6RgapmZDyYB/bWgljqAyP7ft4ia
	 ExwOFvUYQJUGg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 19/30] sysctl: net: use sysctl_field in net core per-net sysctls
Date: Wed, 26 Aug 2026 21:42:23 +0200
Message-ID: <b73d88fa166b9b582f9c335133eb78dc2a6e5f1b.1787771905.git.legion@kernel.org>
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

The net core per-net sysctl table is cloned for every non-init network
namespace so that the per-net entries can be patched to point at the
current struct net and the global buffer limit entries can be made
read-only.

Describe the table with sysctl_field instead. The per-net entries now
derive their storage from the registration context, and the global
buffer limit entries keep their init-net-only write permission through
a mode callback.

This keeps the table static and const while preserving the existing
permission model.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/core/sysctl_net_core.c | 241 ++++++++++++++++++-------------------
 1 file changed, 116 insertions(+), 125 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..39b112a302c2 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -678,100 +678,118 @@ static struct ctl_table net_core_table[] = {
 	},
 };
 
-static struct ctl_table netns_core_table[] = {
+static umode_t netns_core_init_net_writable_mode(const struct sysctl_context *ctx)
+{
+	return net_eq(ctx->ns.net_ns, &init_net) ? 0644 : 0444;
+}
+
+#define NETNS_CORE_SYSCTL_DATA(type, name)				\
+static type *netns_core_##name##_data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->core.sysctl_##name;			\
+}
+
+#define NETNS_CORE_SYSCTL_CUSTOM_DATA(name)				\
+static void *netns_core_##name##_data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->core.sysctl_##name;			\
+}
+
+NETNS_CORE_SYSCTL_DATA(int, somaxconn)
+NETNS_CORE_SYSCTL_DATA(int, optmem_max)
+NETNS_CORE_SYSCTL_DATA(u8, txrehash)
+NETNS_CORE_SYSCTL_CUSTOM_DATA(txq_reselection)
+NETNS_CORE_SYSCTL_DATA(u8, bypass_prot_mem)
+
+static u8 *netns_core_tstamp_allow_data_value(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->core.sysctl_tstamp_allow_data;
+}
+
 #if IS_ENABLED(CONFIG_RPS)
-	{
-		.procname	= "rps_default_mask",
-		.data		= &init_net,
-		.mode		= 0644,
-		.proc_handler	= rps_default_mask_sysctl
-	},
+static void *netns_core_rps_default_mask_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
 #endif
-	{
-		.procname	= "somaxconn",
-		.data		= &init_net.core.sysctl_somaxconn,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.extra1		= SYSCTL_ZERO,
-		.proc_handler	= proc_dointvec_minmax
-	},
-	{
-		.procname	= "optmem_max",
-		.data		= &init_net.core.sysctl_optmem_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.extra1		= SYSCTL_ZERO,
-		.proc_handler	= proc_dointvec_minmax
-	},
-	{
-		.procname	= "txrehash",
-		.data		= &init_net.core.sysctl_txrehash,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "txq_reselection_ms",
-		.data		= &init_net.core.sysctl_txq_reselection,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "tstamp_allow_data",
-		.data		= &init_net.core.sysctl_tstamp_allow_data,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "bypass_prot_mem",
-		.data		= &init_net.core.sysctl_bypass_prot_mem,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	/* sysctl_core_net_init() will set the values after this
-	 * to readonly in network namespaces
-	 */
-	{
-		.procname	= "wmem_max",
-		.data		= &sysctl_wmem_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
-	},
-	{
-		.procname	= "rmem_max",
-		.data		= &sysctl_rmem_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
-	},
-	{
-		.procname	= "wmem_default",
-		.data		= &sysctl_wmem_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
-	},
-	{
-		.procname	= "rmem_default",
-		.data		= &sysctl_rmem_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
-	},
+
+static void *netns_core_sysctl_wmem_max_data(const struct sysctl_context *ctx)
+{
+	return &sysctl_wmem_max;
+}
+
+static void *netns_core_sysctl_rmem_max_data(const struct sysctl_context *ctx)
+{
+	return &sysctl_rmem_max;
+}
+
+static void *netns_core_sysctl_wmem_default_data(const struct sysctl_context *ctx)
+{
+	return &sysctl_wmem_default;
+}
+
+static void *netns_core_sysctl_rmem_default_data(const struct sysctl_context *ctx)
+{
+	return &sysctl_rmem_default;
+}
+
+static int proc_dointvec_minmax_sndbuf(const struct ctl_table *table, int write,
+				       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.extra1 = &min_sndbuf;
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int proc_dointvec_minmax_rcvbuf(const struct ctl_table *table, int write,
+				       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.extra1 = &min_rcvbuf;
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static const struct sysctl_field netns_core_table[] = {
+#if IS_ENABLED(CONFIG_RPS)
+	SYSCTL_FIELD_CUSTOM("rps_default_mask", 0644, 0,
+			 netns_core_rps_default_mask_data,
+			 rps_default_mask_sysctl),
+#endif
+	SYSCTL_FIELD_STATIC_INT_MINMAX("somaxconn", 0644,
+				    netns_core_somaxconn_data,
+				    SYSCTL_ZERO, NULL),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("optmem_max", 0644,
+				    netns_core_optmem_max_data,
+				    SYSCTL_ZERO, NULL),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("txrehash", 0644,
+				   netns_core_txrehash_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM("txq_reselection_ms", 0644, sizeof(int),
+			 netns_core_txq_reselection_data, proc_dointvec_ms_jiffies),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tstamp_allow_data", 0644,
+				   netns_core_tstamp_allow_data_value,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("bypass_prot_mem", 0644,
+				   netns_core_bypass_prot_mem_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM_MODE("wmem_max", 0644,
+			      netns_core_init_net_writable_mode, sizeof(int),
+			      netns_core_sysctl_wmem_max_data,
+			      proc_dointvec_minmax_sndbuf),
+	SYSCTL_FIELD_CUSTOM_MODE("rmem_max", 0644,
+			      netns_core_init_net_writable_mode, sizeof(int),
+			      netns_core_sysctl_rmem_max_data,
+			      proc_dointvec_minmax_rcvbuf),
+	SYSCTL_FIELD_CUSTOM_MODE("wmem_default", 0644,
+			      netns_core_init_net_writable_mode, sizeof(int),
+			      netns_core_sysctl_wmem_default_data,
+			      proc_dointvec_minmax_sndbuf),
+	SYSCTL_FIELD_CUSTOM_MODE("rmem_default", 0644,
+			      netns_core_init_net_writable_mode, sizeof(int),
+			      netns_core_sysctl_rmem_default_data,
+			      proc_dointvec_minmax_rcvbuf),
 };
 
 static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
@@ -789,50 +807,23 @@ __setup("fb_tunnels=", fb_tunnels_only_for_init_net_sysctl_setup);
 
 static __net_init int sysctl_core_net_init(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(netns_core_table);
-	struct ctl_table *tbl;
-
-	tbl = netns_core_table;
-	if (!net_eq(net, &init_net)) {
-		int i;
-		tbl = kmemdup(tbl, sizeof(netns_core_table), GFP_KERNEL);
-		if (tbl == NULL)
-			goto err_dup;
-
-		for (i = 0; i < table_size; ++i) {
-			if (tbl[i].data == &sysctl_wmem_max)
-				break;
-
-			tbl[i].data += (char *)net - (char *)&init_net;
-		}
-		for (; i < table_size; ++i)
-			tbl[i].mode &= ~0222;
-	}
-
-	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl, table_size);
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
+	net->core.sysctl_hdr = register_sysctl_fields(&net->sysctls, "net/core",
+						      netns_core_table, &ctx);
 	if (net->core.sysctl_hdr == NULL)
-		goto err_reg;
+		return -ENOMEM;
 
 	return 0;
-
-err_reg:
-	if (tbl != netns_core_table)
-		kfree(tbl);
-err_dup:
-	return -ENOMEM;
 }
 
 static __net_exit void sysctl_core_net_exit(struct net *net)
 {
-	const struct ctl_table *tbl;
-
-	tbl = net->core.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->core.sysctl_hdr);
-	BUG_ON(tbl == netns_core_table);
 #if IS_ENABLED(CONFIG_RPS)
 	kfree(net->core.rps_default_mask);
 #endif
-	kfree(tbl);
 }
 
 static __net_initdata struct pernet_operations sysctl_core_ops = {
-- 
2.55.0

