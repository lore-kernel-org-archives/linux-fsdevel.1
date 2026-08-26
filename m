Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F23479885;
	Wed, 26 Aug 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773478; cv=none; b=W+vDYaV2xhqCX7fcPjwT/3Dg+AO6mSyRfQWyRqhUFJRPYPWSbCYUbq416PKBXQzu9UCcr8JA9HiEIXEZ1gl6uh4xIGHT/cOA3CaL8ZsEdDDp4VcABTQtDDvgbmLKxuhpwPqD39swFdTDSQhRCwqESNwa3ZvS0IEkyDBJaaqe860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773478; c=relaxed/simple;
	bh=oBiBYjq5I1RlxUHn4ia6SBi8QQ75UswGKKYMU60eD/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhxUJ4xLDSZhb8JOZqL5nbQSs7iSM6y25V594CQg5JaUbbYrmKTxoJWXpAKSfVsRVgDGlaS4Jaj1Rx3mjdPeRW5542+2zyqKaF3pfniV+pKZAO7lOPSE1vCRVHDDH89V+4vpkKUOXbS5DFglTWh7x7t+GSrgKhcBpZHieT6d/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD33z0/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD33z0/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12AA1F00A3F;
	Wed, 26 Aug 2026 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773450;
	bh=TSQw9PZ3dz8TfucbU7kdJA8Zf+4EZtMyb+ChpOGjEe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bD33z0/fOfJqwrh5pikQnBX9FIwr+jPJn6bMis7oJeOiRsWD/xt8d8yEe8k3MnP6H
	 V2XBelmt2nAko144U2z8go7FrZl2APR0oIqvp7K3N9Rd8OkBjyOR8ABUFhA7He05d1
	 B/3OOhr5BBkJ21tcFrJeKlz5YTEWdDsgH72Vg8r+92LZxFCMGhth8OPTJj649LJFIt
	 KbVWFzrF0QNAZuvA3Q7PrqY7ntJnkkIbfuL1hmkZNlY3bQW2M7tLPpBDXNBaNIY3Xu
	 cK9MEUvvHGNQnpuHZswCIrvvZqELHtkAxxxOL8TkWujtPqaCU7Dl+2sQB/KhhGzUKM
	 NGDGde5/pH/6w==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 29/30] sysctl: net: use sysctl_field in neighbour sysctls
Date: Wed, 26 Aug 2026 21:42:33 +0200
Message-ID: <1bea46e9d7b9f895de1414100576ede002b65362.1787771905.git.legion@kernel.org>
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

Neighbour sysctl registration clones the template table so it can
rewrite data pointers, attach the net device and neigh_parms through
extra1 and extra2, and override a few IPv6 NDISC handlers.

Use sysctl_field with a neigh_parms registration context instead. The
sysctl descriptors can stay static and const, while accessors provide
the same data, extra1 and extra2 values to the existing handlers.

Keep the NDISC handler selection local to neighbour sysctls by storing
the optional handler in neigh_parms and using fixed wrapper handlers for
the affected entries. This avoids cloning the sysctl table while
preserving the old IPv6 notification behavior.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/net/neighbour.h |   1 +
 net/core/neighbour.c    | 329 ++++++++++++++++++++++++----------------
 2 files changed, 202 insertions(+), 128 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc..73b6c7017264 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -78,6 +78,7 @@ struct neigh_parms {
 	struct neigh_table *tbl;
 
 	void	*sysctl_table;
+	proc_handler *sysctl_handler;
 
 	int dead;
 	refcount_t refcnt;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5d9216016507..6eb74b0d59b2 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1779,6 +1779,7 @@ struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 		p->dev = dev;
 		write_pnet(&p->net, net);
 		p->sysctl_table = NULL;
+		p->sysctl_handler = NULL;
 
 		if (ops->ndo_neigh_setup && ops->ndo_neigh_setup(dev, p)) {
 			netdev_put(dev, &p->dev_tracker);
@@ -3762,148 +3763,220 @@ static int neigh_proc_base_reachable_time(const struct ctl_table *ctl, int write
 	return ret;
 }
 
-#define NEIGH_PARMS_DATA_OFFSET(index)	\
-	(&((struct neigh_parms *) 0)->data[index])
+struct neigh_ctl_context {
+	struct sysctl_context context;
+	struct neigh_parms *parms;
+};
+
+#define NEIGH_PARMS_DATA(attr, data_attr)				\
+static void *neigh_ ## attr ## _data(const struct sysctl_context *ctx)	\
+{									\
+	const struct neigh_ctl_context *neigh_ctx =			\
+		container_of(ctx, struct neigh_ctl_context, context);	\
+	return &neigh_ctx->parms->data[NEIGH_VAR_ ## data_attr];	\
+}
+
+#define NEIGH_TABLE_DATA(type, attr, field)				\
+static type *neigh_ ## attr ## _data(const struct sysctl_context *ctx)	\
+{									\
+	const struct neigh_ctl_context *neigh_ctx =			\
+		container_of(ctx, struct neigh_ctl_context, context);	\
+	return &neigh_ctx->parms->tbl->field;				\
+}
+
+static void *neigh_dev_data(const struct sysctl_context *ctx)
+{
+	const struct neigh_ctl_context *neigh_ctx =
+		container_of(ctx, struct neigh_ctl_context, context);
+
+	return neigh_ctx->parms->dev;
+}
+
+static void *neigh_parms_data(const struct sysctl_context *ctx)
+{
+	const struct neigh_ctl_context *neigh_ctx =
+		container_of(ctx, struct neigh_ctl_context, context);
+
+	return neigh_ctx->parms;
+}
+
+static void *neigh_handler_data(const struct sysctl_context *ctx)
+{
+	const struct neigh_ctl_context *neigh_ctx =
+		container_of(ctx, struct neigh_ctl_context, context);
+
+	return neigh_ctx->parms->sysctl_handler;
+}
+
+static int neigh_proc_call_handler(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos,
+				   proc_handler *fallback)
+{
+	proc_handler *handler = ctl->extra1;
+
+	if (handler) {
+		struct neigh_parms *p = ctl->extra2;
+		struct ctl_table tmp = *ctl;
+
+		tmp.extra1 = p->dev;
+		tmp.extra2 = p;
+		return handler(&tmp, write, buffer, lenp, ppos);
+	}
+
+	return fallback(ctl, write, buffer, lenp, ppos);
+}
 
-#define NEIGH_SYSCTL_ENTRY(attr, data_attr, name, mval, proc) \
-	[NEIGH_VAR_ ## attr] = { \
-		.procname	= name, \
-		.data		= NEIGH_PARMS_DATA_OFFSET(NEIGH_VAR_ ## data_attr), \
-		.maxlen		= sizeof(int), \
-		.mode		= mval, \
-		.proc_handler	= proc, \
+static int neigh_proc_retrans_time(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return neigh_proc_call_handler(ctl, write, buffer, lenp, ppos,
+				       neigh_proc_dointvec_userhz_jiffies);
+}
+
+static int neigh_proc_retrans_time_ms(const struct ctl_table *ctl, int write,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return neigh_proc_call_handler(ctl, write, buffer, lenp, ppos,
+				       neigh_proc_dointvec_ms_jiffies);
+}
+
+static int neigh_proc_base_reachable_time_handler(const struct ctl_table *ctl,
+						  int write, void *buffer,
+						  size_t *lenp, loff_t *ppos)
+{
+	return neigh_proc_call_handler(ctl, write, buffer, lenp, ppos,
+				       neigh_proc_base_reachable_time);
+}
+
+#define NEIGH_SYSCTL_ENTRY(attr, name, proc)				\
+	[NEIGH_VAR_ ## attr] = {					\
+		.procname	= name,					\
+		.mode		= 0644,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= proc,				\
+			.data		= neigh_ ## attr ## _data,	\
+			.extra1		= neigh_dev_data,		\
+			.extra2		= neigh_parms_data,		\
+			.maxlen		= sizeof(int),			\
+		},							\
+	}
+
+#define NEIGH_SYSCTL_HANDLER_ENTRY(attr, name, proc)			\
+	[NEIGH_VAR_ ## attr] = {					\
+		.procname	= name,					\
+		.mode		= 0644,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= proc,				\
+			.data		= neigh_ ## attr ## _data,	\
+			.extra1		= neigh_handler_data,		\
+			.extra2		= neigh_parms_data,		\
+			.maxlen		= sizeof(int),			\
+		},							\
 	}
 
 #define NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_zero_intmax)
+	NEIGH_SYSCTL_ENTRY(attr, name, neigh_proc_dointvec_zero_intmax)
 
 #define NEIGH_SYSCTL_JIFFIES_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_jiffies)
+	NEIGH_SYSCTL_ENTRY(attr, name, neigh_proc_dointvec_jiffies)
 
 #define NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_userhz_jiffies)
+	NEIGH_SYSCTL_ENTRY(attr, name, neigh_proc_dointvec_userhz_jiffies)
 
 #define NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_ms_jiffies_positive)
-
-#define NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(attr, data_attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, data_attr, name, 0644, neigh_proc_dointvec_ms_jiffies)
-
-#define NEIGH_SYSCTL_UNRES_QLEN_REUSED_ENTRY(attr, data_attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, data_attr, name, 0644, neigh_proc_dointvec_unres_qlen)
-
-static struct neigh_sysctl_table {
-	struct ctl_table_header *sysctl_header;
-	struct ctl_table neigh_vars[NEIGH_VAR_MAX];
-} neigh_sysctl_template __read_mostly = {
-	.neigh_vars = {
-		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_PROBES, "mcast_solicit"),
-		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(UCAST_PROBES, "ucast_solicit"),
-		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(APP_PROBES, "app_solicit"),
-		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_REPROBES, "mcast_resolicit"),
-		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(RETRANS_TIME, "retrans_time"),
-		NEIGH_SYSCTL_JIFFIES_ENTRY(BASE_REACHABLE_TIME, "base_reachable_time"),
-		NEIGH_SYSCTL_JIFFIES_ENTRY(DELAY_PROBE_TIME, "delay_first_probe_time"),
-		NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(INTERVAL_PROBE_TIME_MS,
-						       "interval_probe_time_ms"),
-		NEIGH_SYSCTL_JIFFIES_ENTRY(GC_STALETIME, "gc_stale_time"),
-		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(QUEUE_LEN_BYTES, "unres_qlen_bytes"),
-		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(PROXY_QLEN, "proxy_qlen"),
-		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(ANYCAST_DELAY, "anycast_delay"),
-		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(PROXY_DELAY, "proxy_delay"),
-		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(LOCKTIME, "locktime"),
-		NEIGH_SYSCTL_UNRES_QLEN_REUSED_ENTRY(QUEUE_LEN, QUEUE_LEN_BYTES, "unres_qlen"),
-		NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(RETRANS_TIME_MS, RETRANS_TIME, "retrans_time_ms"),
-		NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(BASE_REACHABLE_TIME_MS, BASE_REACHABLE_TIME, "base_reachable_time_ms"),
-		[NEIGH_VAR_GC_INTERVAL] = {
-			.procname	= "gc_interval",
-			.maxlen		= sizeof(int),
-			.mode		= 0644,
-			.proc_handler	= proc_dointvec_jiffies,
-		},
-		[NEIGH_VAR_GC_THRESH1] = {
-			.procname	= "gc_thresh1",
-			.maxlen		= sizeof(int),
-			.mode		= 0644,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_INT_MAX,
-			.proc_handler	= proc_dointvec_minmax,
-		},
-		[NEIGH_VAR_GC_THRESH2] = {
-			.procname	= "gc_thresh2",
-			.maxlen		= sizeof(int),
-			.mode		= 0644,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_INT_MAX,
-			.proc_handler	= proc_dointvec_minmax,
-		},
-		[NEIGH_VAR_GC_THRESH3] = {
-			.procname	= "gc_thresh3",
-			.maxlen		= sizeof(int),
-			.mode		= 0644,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_INT_MAX,
-			.proc_handler	= proc_dointvec_minmax,
-		},
-	},
+	NEIGH_SYSCTL_ENTRY(attr, name, neigh_proc_dointvec_ms_jiffies_positive)
+
+#define NEIGH_SYSCTL_MS_JIFFIES_ENTRY(attr, name) \
+	NEIGH_SYSCTL_ENTRY(attr, name, neigh_proc_dointvec_ms_jiffies)
+
+#define NEIGH_SYSCTL_UNRES_QLEN_ENTRY(attr, name) \
+	NEIGH_SYSCTL_ENTRY(attr, name, neigh_proc_dointvec_unres_qlen)
+
+NEIGH_PARMS_DATA(MCAST_PROBES, MCAST_PROBES)
+NEIGH_PARMS_DATA(UCAST_PROBES, UCAST_PROBES)
+NEIGH_PARMS_DATA(APP_PROBES, APP_PROBES)
+NEIGH_PARMS_DATA(MCAST_REPROBES, MCAST_REPROBES)
+NEIGH_PARMS_DATA(RETRANS_TIME, RETRANS_TIME)
+NEIGH_PARMS_DATA(BASE_REACHABLE_TIME, BASE_REACHABLE_TIME)
+NEIGH_PARMS_DATA(DELAY_PROBE_TIME, DELAY_PROBE_TIME)
+NEIGH_PARMS_DATA(INTERVAL_PROBE_TIME_MS, INTERVAL_PROBE_TIME_MS)
+NEIGH_PARMS_DATA(GC_STALETIME, GC_STALETIME)
+NEIGH_PARMS_DATA(QUEUE_LEN_BYTES, QUEUE_LEN_BYTES)
+NEIGH_PARMS_DATA(PROXY_QLEN, PROXY_QLEN)
+NEIGH_PARMS_DATA(ANYCAST_DELAY, ANYCAST_DELAY)
+NEIGH_PARMS_DATA(PROXY_DELAY, PROXY_DELAY)
+NEIGH_PARMS_DATA(LOCKTIME, LOCKTIME)
+NEIGH_PARMS_DATA(QUEUE_LEN, QUEUE_LEN_BYTES)
+NEIGH_PARMS_DATA(RETRANS_TIME_MS, RETRANS_TIME)
+NEIGH_PARMS_DATA(BASE_REACHABLE_TIME_MS, BASE_REACHABLE_TIME)
+NEIGH_TABLE_DATA(void, GC_INTERVAL, gc_interval)
+NEIGH_TABLE_DATA(int, GC_THRESH1, gc_thresh1)
+NEIGH_TABLE_DATA(int, GC_THRESH2, gc_thresh2)
+NEIGH_TABLE_DATA(int, GC_THRESH3, gc_thresh3)
+
+static const struct sysctl_field neigh_sysctl_table[] = {
+	NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_PROBES, "mcast_solicit"),
+	NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(UCAST_PROBES, "ucast_solicit"),
+	NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(APP_PROBES, "app_solicit"),
+	NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_REPROBES, "mcast_resolicit"),
+	NEIGH_SYSCTL_HANDLER_ENTRY(RETRANS_TIME, "retrans_time",
+				   neigh_proc_retrans_time),
+	NEIGH_SYSCTL_HANDLER_ENTRY(BASE_REACHABLE_TIME, "base_reachable_time",
+				   neigh_proc_base_reachable_time_handler),
+	NEIGH_SYSCTL_JIFFIES_ENTRY(DELAY_PROBE_TIME, "delay_first_probe_time"),
+	NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(INTERVAL_PROBE_TIME_MS,
+					       "interval_probe_time_ms"),
+	NEIGH_SYSCTL_JIFFIES_ENTRY(GC_STALETIME, "gc_stale_time"),
+	NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(QUEUE_LEN_BYTES, "unres_qlen_bytes"),
+	NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(PROXY_QLEN, "proxy_qlen"),
+	NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(ANYCAST_DELAY, "anycast_delay"),
+	NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(PROXY_DELAY, "proxy_delay"),
+	NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(LOCKTIME, "locktime"),
+	NEIGH_SYSCTL_UNRES_QLEN_ENTRY(QUEUE_LEN, "unres_qlen"),
+	NEIGH_SYSCTL_HANDLER_ENTRY(RETRANS_TIME_MS, "retrans_time_ms",
+				   neigh_proc_retrans_time_ms),
+	NEIGH_SYSCTL_HANDLER_ENTRY(BASE_REACHABLE_TIME_MS,
+				   "base_reachable_time_ms",
+				   neigh_proc_base_reachable_time_handler),
+	SYSCTL_FIELD_CUSTOM("gc_interval", 0644, sizeof(int),
+			 neigh_GC_INTERVAL_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("gc_thresh1", 0644,
+				    neigh_GC_THRESH1_data,
+				    SYSCTL_ZERO, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("gc_thresh2", 0644,
+				    neigh_GC_THRESH2_data,
+				    SYSCTL_ZERO, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("gc_thresh3", 0644,
+				    neigh_GC_THRESH3_data,
+				    SYSCTL_ZERO, SYSCTL_INT_MAX),
 };
 
+#define NEIGH_SYSCTL_DEFAULT_COUNT	4
+
 int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 			  proc_handler *handler)
 {
-	int i;
-	struct neigh_sysctl_table *t;
+	struct ctl_table_header *hdr;
+	struct net *net = neigh_parms_net(p);
+	struct neigh_ctl_context ctx = {
+		.context.ns.net_ns = net,
+		.parms = p,
+	};
 	const char *dev_name_source;
 	char neigh_path[ sizeof("net//neigh/") + IFNAMSIZ + IFNAMSIZ ];
 	char *p_name;
 	size_t neigh_vars_size;
 
-	t = kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT);
-	if (!t)
-		goto err;
-
-	for (i = 0; i < NEIGH_VAR_GC_INTERVAL; i++) {
-		t->neigh_vars[i].data += (long) p;
-		t->neigh_vars[i].extra1 = dev;
-		t->neigh_vars[i].extra2 = p;
-	}
+	p->sysctl_handler = handler;
 
-	neigh_vars_size = ARRAY_SIZE(t->neigh_vars);
+	neigh_vars_size = ARRAY_SIZE(neigh_sysctl_table);
 	if (dev) {
 		dev_name_source = dev->name;
-		/* Terminate the table early */
-		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS + 1;
+		neigh_vars_size -= NEIGH_SYSCTL_DEFAULT_COUNT;
 	} else {
-		struct neigh_table *tbl = p->tbl;
 		dev_name_source = "default";
-		t->neigh_vars[NEIGH_VAR_GC_INTERVAL].data = &tbl->gc_interval;
-		t->neigh_vars[NEIGH_VAR_GC_THRESH1].data = &tbl->gc_thresh1;
-		t->neigh_vars[NEIGH_VAR_GC_THRESH2].data = &tbl->gc_thresh2;
-		t->neigh_vars[NEIGH_VAR_GC_THRESH3].data = &tbl->gc_thresh3;
-	}
-
-	if (handler) {
-		/* RetransTime */
-		t->neigh_vars[NEIGH_VAR_RETRANS_TIME].proc_handler = handler;
-		/* ReachableTime */
-		t->neigh_vars[NEIGH_VAR_BASE_REACHABLE_TIME].proc_handler = handler;
-		/* RetransTime (in milliseconds)*/
-		t->neigh_vars[NEIGH_VAR_RETRANS_TIME_MS].proc_handler = handler;
-		/* ReachableTime (in milliseconds) */
-		t->neigh_vars[NEIGH_VAR_BASE_REACHABLE_TIME_MS].proc_handler = handler;
-	} else {
-		/* Those handlers will update p->reachable_time after
-		 * base_reachable_time(_ms) is set to ensure the new timer starts being
-		 * applied after the next neighbour update instead of waiting for
-		 * neigh_periodic_work to update its value (can be multiple minutes)
-		 * So any handler that replaces them should do this as well
-		 */
-		/* ReachableTime */
-		t->neigh_vars[NEIGH_VAR_BASE_REACHABLE_TIME].proc_handler =
-			neigh_proc_base_reachable_time;
-		/* ReachableTime (in milliseconds) */
-		t->neigh_vars[NEIGH_VAR_BASE_REACHABLE_TIME_MS].proc_handler =
-			neigh_proc_base_reachable_time;
 	}
 
 	switch (neigh_parms_family(p)) {
@@ -3919,18 +3992,17 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 
 	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
 		p_name, dev_name_source);
-	t->sysctl_header = register_net_sysctl_sz(neigh_parms_net(p),
-						  neigh_path, t->neigh_vars,
-						  neigh_vars_size);
-	if (!t->sysctl_header)
-		goto free;
+	hdr = __register_sysctl_fields(&net->sysctls, neigh_path,
+				       neigh_sysctl_table, neigh_vars_size,
+				       &ctx.context, sizeof(ctx));
+	if (!hdr)
+		goto err;
 
-	p->sysctl_table = t;
+	p->sysctl_table = hdr;
 	return 0;
 
-free:
-	kfree(t);
 err:
+	p->sysctl_handler = NULL;
 	return -ENOBUFS;
 }
 EXPORT_SYMBOL(neigh_sysctl_register);
@@ -3938,10 +4010,11 @@ EXPORT_SYMBOL(neigh_sysctl_register);
 void neigh_sysctl_unregister(struct neigh_parms *p)
 {
 	if (p->sysctl_table) {
-		struct neigh_sysctl_table *t = p->sysctl_table;
+		struct ctl_table_header *hdr = p->sysctl_table;
+
 		p->sysctl_table = NULL;
-		unregister_net_sysctl_table(t->sysctl_header);
-		kfree(t);
+		p->sysctl_handler = NULL;
+		unregister_net_sysctl_table(hdr);
 	}
 }
 EXPORT_SYMBOL(neigh_sysctl_unregister);
-- 
2.55.0

