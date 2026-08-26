Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCBD47DFBE;
	Wed, 26 Aug 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773457; cv=none; b=ek8JMvLrzdi/xyS9xGnisbSR8awAHucODNrHXtl9Ki/gkRSkPCtS1vre7yF8eoO4x9M+HPft8eMsX0UO/L6avfcV9iblFc9WAq0v+iZu5zrtOkha5tTY+I4SOPo4upNbE7MxkQqfICo9jXCqZQprS91UnMemZ+6f7Ijo7XNORdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773457; c=relaxed/simple;
	bh=XyaUjk3OPNZt2ykSyegsvz1QfwnJTThsmXzCErGXaRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYdc83jJLPj5wihf/e16wBBATJvkBGYv6rThT9sYHAO8wv3ObBeqYwgMKqQisQ0cFY0T7iRUcCr1mXbGn+KMLomkr8lV0BwHCLnnP8vKS5Cmg0WXt6BA42vEK3pFyvsoLSCYBPDPxp5Iw2EZEitObWTy0JziYgPwM5RaqB4zEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZEO+pHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZEO+pHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE90E1F000E9;
	Wed, 26 Aug 2026 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773436;
	bh=8mAzh2742Tb+9907z2Y+kZo/SLu0uZx6UqeHEwhZoe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZEO+pHjg9069wfsKd2SpcsBpRpdqQkQ2DnoQhkYiXPvuC1eLSWQTNRKlBTXY54Xn
	 8a0waeWm0OLcRAplMphSkbRE5DnHrGdz71/GDR0zQzl7GjHnPTZWzjMzTTsahrDGg2
	 tHHbFuXrVZpUBIRjVz5DuYLzFhimaGlRPjORW3zTg3rdPuBo6P+ai3XVoLgtIhWfHA
	 wtu+e1jd60nVRTzn8eBrF7hkGknCbBVZxI8ot7AYvDajLhE4GiPWMNy6+a8Wbnxs6S
	 dSQxfT4g6/WvYw+nI4FY5xDSknj53xuAsIm753g7Xq5a9oBb/We5gVmbVGkf4a889C
	 S0U+okD/VJZVg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 24/30] sysctl: ipvs: use sysctl_field for per-net sysctls
Date: Wed, 26 Aug 2026 21:42:28 +0200
Message-ID: <3f2abc2bb21262a7aad00cd171bac7a8233f07d4.1787771905.git.legion@kernel.org>
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

IPVS still builds per-net sysctl tables by cloning ctl_table arrays and
then patching the copied entries with namespace-local data pointers,
modes, and handler context. The main table also depends on the entry
order matching the initialization code.

Use sysctl_field for the IPVS per-net sysctls instead. The sysctl
descriptors can stay static and const, while data pointers and
per-namespace modes are derived from the registration context.

This removes the per-net table copies from the IPVS control, LBLC, and
LBLCR sysctls, and drops the table pointers that only existed so the
cloned tables could be freed at namespace teardown.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/net/ip_vs.h              |   3 -
 net/netfilter/ipvs/ip_vs_ctl.c   | 533 +++++++++++++------------------
 net/netfilter/ipvs/ip_vs_lblc.c  |  49 ++-
 net/netfilter/ipvs/ip_vs_lblcr.c |  50 ++-
 4 files changed, 263 insertions(+), 372 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index a02e569813d2..e0833ab99f30 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1214,7 +1214,6 @@ struct netns_ipvs {
 
 	/* sys-ctl struct */
 	struct ctl_table_header	*sysctl_hdr;
-	struct ctl_table	*sysctl_tbl;
 #endif
 
 	/* sysctl variables */
@@ -1259,11 +1258,9 @@ struct netns_ipvs {
 	/* ip_vs_lblc */
 	int			sysctl_lblc_expiration;
 	struct ctl_table_header	*lblc_ctl_header;
-	struct ctl_table	*lblc_ctl_table;
 	/* ip_vs_lblcr */
 	int			sysctl_lblcr_expiration;
 	struct ctl_table_header	*lblcr_ctl_header;
-	struct ctl_table	*lblcr_ctl_table;
 	unsigned long		work_flags;	/* IP_VS_WORK_* flags */
 	/* ip_vs_est */
 	struct delayed_work	est_reload_work;/* Reload kthread tasks */
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index bd9cae44d214..e1db1146f343 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2320,10 +2320,9 @@ static int ip_vs_zero_all(struct netns_ipvs *ipvs)
 #ifdef CONFIG_SYSCTL
 
 static int
-proc_do_defense_mode(const struct ctl_table *table, int write,
-		     void *buffer, size_t *lenp, loff_t *ppos)
+__proc_do_defense_mode(struct netns_ipvs *ipvs, const struct ctl_table *table,
+		       int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val = *valp;
 	int rc;
@@ -2346,11 +2345,45 @@ proc_do_defense_mode(const struct ctl_table *table, int write,
 	return rc;
 }
 
+static int
+proc_do_drop_entry(const struct ctl_table *table, int write,
+		   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct netns_ipvs *ipvs;
+
+	ipvs = container_of(table->data, struct netns_ipvs,
+			    sysctl_drop_entry);
+	return __proc_do_defense_mode(ipvs, table, write, buffer, lenp, ppos);
+}
+
+static int
+proc_do_drop_packet(const struct ctl_table *table, int write,
+		    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct netns_ipvs *ipvs;
+
+	ipvs = container_of(table->data, struct netns_ipvs,
+			    sysctl_drop_packet);
+	return __proc_do_defense_mode(ipvs, table, write, buffer, lenp, ppos);
+}
+
+static int
+proc_do_secure_tcp(const struct ctl_table *table, int write,
+		   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct netns_ipvs *ipvs;
+
+	ipvs = container_of(table->data, struct netns_ipvs,
+			    sysctl_secure_tcp);
+	return __proc_do_defense_mode(ipvs, table, write, buffer, lenp, ppos);
+}
+
 static int
 proc_do_sync_threshold(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
+	struct netns_ipvs *ipvs = container_of(table->data, struct netns_ipvs,
+					       sysctl_sync_threshold);
 	int *valp = table->data;
 	int val[2];
 	int rc;
@@ -2401,7 +2434,8 @@ proc_do_sync_ports(const struct ctl_table *table, int write,
 static int ipvs_proc_est_cpumask_set(const struct ctl_table *table,
 				     void *buffer)
 {
-	struct netns_ipvs *ipvs = table->extra2;
+	struct netns_ipvs *ipvs = container_of(table->data, struct netns_ipvs,
+					       sysctl_est_cpulist);
 	cpumask_var_t *valp = table->data;
 	cpumask_var_t newmask;
 	int ret;
@@ -2440,7 +2474,8 @@ static int ipvs_proc_est_cpumask_set(const struct ctl_table *table,
 static int ipvs_proc_est_cpumask_get(const struct ctl_table *table,
 				     void *buffer, size_t size)
 {
-	struct netns_ipvs *ipvs = table->extra2;
+	struct netns_ipvs *ipvs = container_of(table->data, struct netns_ipvs,
+					       sysctl_est_cpulist);
 	cpumask_var_t *valp = table->data;
 	struct cpumask *mask;
 	int ret;
@@ -2491,8 +2526,8 @@ static int ipvs_proc_est_cpulist(const struct ctl_table *table, int write,
 static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs;
 	int val = *valp;
 	int ret;
 
@@ -2502,6 +2537,7 @@ static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 		.mode = table->mode,
 	};
 
+	ipvs = container_of(table->data, struct netns_ipvs, sysctl_est_nice);
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
 		if (val < MIN_NICE || val > MAX_NICE) {
@@ -2521,8 +2557,8 @@ static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 static int ipvs_proc_run_estimation(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs;
 	int val = *valp;
 	int ret;
 
@@ -2532,6 +2568,8 @@ static int ipvs_proc_run_estimation(const struct ctl_table *table, int write,
 		.mode = table->mode,
 	};
 
+	ipvs = container_of(table->data, struct netns_ipvs,
+			    sysctl_run_estimation);
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
 		mutex_lock(&ipvs->est_mutex);
@@ -2547,8 +2585,8 @@ static int ipvs_proc_run_estimation(const struct ctl_table *table, int write,
 static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs;
 	int val = *valp;
 	int ret;
 
@@ -2557,6 +2595,8 @@ static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 		.maxlen = sizeof(int),
 	};
 
+	ipvs = container_of(table->data, struct netns_ipvs,
+			    sysctl_conn_lfactor);
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
 		if (val < -8 || val > 8) {
@@ -2574,8 +2614,8 @@ static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 static int ipvs_proc_svc_lfactor(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs;
 	int val = *valp;
 	int ret;
 
@@ -2584,6 +2624,8 @@ static int ipvs_proc_svc_lfactor(const struct ctl_table *table, int write,
 		.maxlen = sizeof(int),
 	};
 
+	ipvs = container_of(table->data, struct netns_ipvs,
+			    sysctl_svc_lfactor);
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
 		if (val < -8 || val > 8) {
@@ -2604,216 +2646,181 @@ static int ipvs_proc_svc_lfactor(const struct ctl_table *table, int write,
 	return ret;
 }
 
+#define IPVS_DATA(type, member)						\
+static type *ip_vs_ ## member ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &net_ipvs(ctx->ns.net_ns)->member;			\
+}
+
+#define IPVS_CUSTOM_DATA(member)					\
+static void *ip_vs_ ## member ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &net_ipvs(ctx->ns.net_ns)->member;			\
+}
+
+IPVS_DATA(int, sysctl_amemthresh)
+IPVS_DATA(int, sysctl_am_droprate)
+IPVS_CUSTOM_DATA(sysctl_drop_entry)
+IPVS_CUSTOM_DATA(sysctl_drop_packet)
+#ifdef CONFIG_IP_VS_NFCT
+IPVS_DATA(int, sysctl_conntrack)
+#endif
+IPVS_CUSTOM_DATA(sysctl_secure_tcp)
+IPVS_DATA(int, sysctl_snat_reroute)
+IPVS_DATA(int, sysctl_sync_ver)
+IPVS_CUSTOM_DATA(sysctl_sync_ports)
+IPVS_DATA(int, sysctl_sync_persist_mode)
+IPVS_DATA(unsigned long, sysctl_sync_qlen_max)
+IPVS_DATA(int, sysctl_sync_sock_size)
+IPVS_DATA(int, sysctl_cache_bypass)
+IPVS_DATA(int, sysctl_expire_nodest_conn)
+IPVS_DATA(int, sysctl_sloppy_tcp)
+IPVS_DATA(int, sysctl_sloppy_sctp)
+IPVS_DATA(int, sysctl_expire_quiescent_template)
+IPVS_CUSTOM_DATA(sysctl_sync_threshold)
+IPVS_CUSTOM_DATA(sysctl_sync_refresh_period)
+IPVS_DATA(int, sysctl_sync_retries)
+IPVS_DATA(int, sysctl_nat_icmp_send)
+IPVS_DATA(int, sysctl_pmtu_disc)
+IPVS_DATA(int, sysctl_backup_only)
+IPVS_DATA(int, sysctl_conn_reuse_mode)
+IPVS_DATA(int, sysctl_schedule_icmp)
+IPVS_DATA(int, sysctl_ignore_tunneled)
+IPVS_CUSTOM_DATA(sysctl_run_estimation)
+IPVS_CUSTOM_DATA(sysctl_est_cpulist)
+IPVS_CUSTOM_DATA(sysctl_est_nice)
+IPVS_CUSTOM_DATA(sysctl_conn_lfactor)
+IPVS_CUSTOM_DATA(sysctl_svc_lfactor)
+
+#undef IPVS_DATA
+#undef IPVS_CUSTOM_DATA
+
+#ifdef CONFIG_IP_VS_DEBUG
+static int *ip_vs_debug_level_data(const struct sysctl_context *ctx)
+{
+	return &sysctl_ip_vs_debug_level;
+}
+#endif
+
+static umode_t ip_vs_unpriv_sysctl_mode(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns->user_ns != &init_user_ns ? 0444 : 0644;
+}
+
+#ifdef CONFIG_IP_VS_DEBUG
+static umode_t ip_vs_debug_level_mode(const struct sysctl_context *ctx)
+{
+	return net_eq(ctx->ns.net_ns, &init_net) ? 0644 : 0444;
+}
+#endif
+
+#define IPVS_FIELD_INT_MODE(_procname, _data, _mode_fn)		\
+	{								\
+		.procname	= (_procname),				\
+		.mode		= 0644,					\
+		.mode_fn	= (_mode_fn),				\
+		.type		= SYSCTL_FIELD_INT,			\
+		.ctl_int	= { .data = (_data) },			\
+	}
+
+#define IPVS_FIELD_ULONG_MODE(_procname, _data, _mode_fn)	\
+	{								\
+		.procname	= (_procname),				\
+		.mode		= 0644,					\
+		.mode_fn	= (_mode_fn),				\
+		.type		= SYSCTL_FIELD_ULONG,			\
+		.ctl_ulong	= { .data = (_data) },			\
+	}
+
 /*
  *	IPVS sysctl table (under the /proc/sys/net/ipv4/vs/)
- *	Do not change order or insert new entries without
- *	align with netns init in ip_vs_control_net_init()
  */
-
-static struct ctl_table vs_vars[] = {
-	{
-		.procname	= "amemthresh",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "am_droprate",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "drop_entry",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_do_defense_mode,
-	},
-	{
-		.procname	= "drop_packet",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_do_defense_mode,
-	},
+static const struct sysctl_field vs_vars[] = {
+	SYSCTL_FIELD_INT("amemthresh", 0644, ip_vs_sysctl_amemthresh_data),
+	SYSCTL_FIELD_INT("am_droprate", 0644, ip_vs_sysctl_am_droprate_data),
+	SYSCTL_FIELD_CUSTOM("drop_entry", 0644, sizeof(int),
+			 ip_vs_sysctl_drop_entry_data, proc_do_drop_entry),
+	SYSCTL_FIELD_CUSTOM("drop_packet", 0644, sizeof(int),
+			 ip_vs_sysctl_drop_packet_data, proc_do_drop_packet),
 #ifdef CONFIG_IP_VS_NFCT
-	{
-		.procname	= "conntrack",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
+	SYSCTL_FIELD_INT("conntrack", 0644, ip_vs_sysctl_conntrack_data),
 #endif
-	{
-		.procname	= "secure_tcp",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_do_defense_mode,
-	},
-	{
-		.procname	= "snat_reroute",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		.procname	= "sync_version",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "sync_ports",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_do_sync_ports,
-	},
-	{
-		.procname	= "sync_persist_mode",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sync_qlen_max",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "sync_sock_size",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "cache_bypass",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "expire_nodest_conn",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sloppy_tcp",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sloppy_sctp",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "expire_quiescent_template",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sync_threshold",
-		.maxlen		=
-			sizeof(((struct netns_ipvs *)0)->sysctl_sync_threshold),
-		.mode		= 0644,
-		.proc_handler	= proc_do_sync_threshold,
-	},
-	{
-		.procname	= "sync_refresh_period",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "sync_retries",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
-	},
-	{
-		.procname	= "nat_icmp_send",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "pmtu_disc",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "backup_only",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "conn_reuse_mode",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "schedule_icmp",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "ignore_tunneled",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "run_estimation",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= ipvs_proc_run_estimation,
-	},
-	{
-		.procname	= "est_cpulist",
-		.maxlen		= NR_CPUS,	/* unused */
-		.mode		= 0644,
-		.proc_handler	= ipvs_proc_est_cpulist,
-	},
-	{
-		.procname	= "est_nice",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= ipvs_proc_est_nice,
-	},
-	{
-		.procname	= "conn_lfactor",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= ipvs_proc_conn_lfactor,
-	},
-	{
-		.procname	= "svc_lfactor",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= ipvs_proc_svc_lfactor,
-	},
+	SYSCTL_FIELD_CUSTOM("secure_tcp", 0644, sizeof(int),
+			 ip_vs_sysctl_secure_tcp_data, proc_do_secure_tcp),
+	SYSCTL_FIELD_INT("snat_reroute", 0644,
+		      ip_vs_sysctl_snat_reroute_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("sync_version", 0644,
+				    ip_vs_sysctl_sync_ver_data,
+				    SYSCTL_ZERO, SYSCTL_ONE),
+	SYSCTL_FIELD_CUSTOM("sync_ports", 0644, sizeof(int),
+			 ip_vs_sysctl_sync_ports_data, proc_do_sync_ports),
+	SYSCTL_FIELD_INT("sync_persist_mode", 0644,
+		      ip_vs_sysctl_sync_persist_mode_data),
+	IPVS_FIELD_ULONG_MODE("sync_qlen_max",
+			      ip_vs_sysctl_sync_qlen_max_data,
+			      ip_vs_unpriv_sysctl_mode),
+	IPVS_FIELD_INT_MODE("sync_sock_size",
+			    ip_vs_sysctl_sync_sock_size_data,
+			    ip_vs_unpriv_sysctl_mode),
+	SYSCTL_FIELD_INT("cache_bypass", 0644, ip_vs_sysctl_cache_bypass_data),
+	SYSCTL_FIELD_INT("expire_nodest_conn", 0644,
+		      ip_vs_sysctl_expire_nodest_conn_data),
+	SYSCTL_FIELD_INT("sloppy_tcp", 0644, ip_vs_sysctl_sloppy_tcp_data),
+	SYSCTL_FIELD_INT("sloppy_sctp", 0644, ip_vs_sysctl_sloppy_sctp_data),
+	SYSCTL_FIELD_INT("expire_quiescent_template", 0644,
+		      ip_vs_sysctl_expire_quiescent_template_data),
+	SYSCTL_FIELD_CUSTOM("sync_threshold", 0644,
+			 sizeof(((struct netns_ipvs *)0)->sysctl_sync_threshold),
+			 ip_vs_sysctl_sync_threshold_data,
+			 proc_do_sync_threshold),
+	SYSCTL_FIELD_CUSTOM("sync_refresh_period", 0644, sizeof(unsigned int),
+			 ip_vs_sysctl_sync_refresh_period_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("sync_retries", 0644,
+				    ip_vs_sysctl_sync_retries_data,
+				    SYSCTL_ZERO, SYSCTL_THREE),
+	SYSCTL_FIELD_INT("nat_icmp_send", 0644,
+		      ip_vs_sysctl_nat_icmp_send_data),
+	SYSCTL_FIELD_INT("pmtu_disc", 0644, ip_vs_sysctl_pmtu_disc_data),
+	SYSCTL_FIELD_INT("backup_only", 0644, ip_vs_sysctl_backup_only_data),
+	SYSCTL_FIELD_INT("conn_reuse_mode", 0644,
+		      ip_vs_sysctl_conn_reuse_mode_data),
+	SYSCTL_FIELD_INT("schedule_icmp", 0644,
+		      ip_vs_sysctl_schedule_icmp_data),
+	SYSCTL_FIELD_INT("ignore_tunneled", 0644,
+		      ip_vs_sysctl_ignore_tunneled_data),
+	SYSCTL_FIELD_CUSTOM_MODE("run_estimation", 0644,
+			      ip_vs_unpriv_sysctl_mode,
+			      sizeof(int),
+			      ip_vs_sysctl_run_estimation_data,
+			      ipvs_proc_run_estimation),
+	SYSCTL_FIELD_CUSTOM_MODE("est_cpulist", 0644,
+			      ip_vs_unpriv_sysctl_mode,
+			      NR_CPUS,
+			      ip_vs_sysctl_est_cpulist_data,
+			      ipvs_proc_est_cpulist),
+	SYSCTL_FIELD_CUSTOM_MODE("est_nice", 0644,
+			      ip_vs_unpriv_sysctl_mode,
+			      sizeof(int),
+			      ip_vs_sysctl_est_nice_data,
+			      ipvs_proc_est_nice),
+	SYSCTL_FIELD_CUSTOM_MODE("conn_lfactor", 0644,
+			      ip_vs_unpriv_sysctl_mode,
+			      sizeof(int),
+			      ip_vs_sysctl_conn_lfactor_data,
+			      ipvs_proc_conn_lfactor),
+	SYSCTL_FIELD_CUSTOM_MODE("svc_lfactor", 0644,
+			      ip_vs_unpriv_sysctl_mode,
+			      sizeof(int),
+			      ip_vs_sysctl_svc_lfactor_data,
+			      ipvs_proc_svc_lfactor),
 #ifdef CONFIG_IP_VS_DEBUG
-	{
-		.procname	= "debug_level",
-		.data		= &sysctl_ip_vs_debug_level,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
+	IPVS_FIELD_INT_MODE("debug_level", ip_vs_debug_level_data,
+			    ip_vs_debug_level_mode),
 #endif
 };
+#undef IPVS_FIELD_INT_MODE
+#undef IPVS_FIELD_ULONG_MODE
 
 #endif
 
@@ -4946,11 +4953,10 @@ static void ip_vs_genl_unregister(void)
 #ifdef CONFIG_SYSCTL
 static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 {
-	struct net *net = ipvs->net;
-	struct ctl_table *tbl;
-	int idx, ret;
-	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
-	bool unpriv = net->user_ns != &init_user_ns;
+	struct sysctl_context ctx = {
+		.ns.net_ns = ipvs->net,
+	};
+	int ret;
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
@@ -4961,109 +4967,28 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 			  expire_nodest_conn_handler);
 	ipvs->est_stopped = 0;
 
-	if (!net_eq(net, &init_net)) {
-		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
-		if (tbl == NULL)
-			return -ENOMEM;
-	} else
-		tbl = vs_vars;
 	/* Initialize sysctl defaults */
-	for (idx = 0; idx < ARRAY_SIZE(vs_vars); idx++) {
-		if (tbl[idx].proc_handler == proc_do_defense_mode)
-			tbl[idx].extra2 = ipvs;
-	}
-	idx = 0;
 	ipvs->sysctl_amemthresh = 1024;
-	tbl[idx++].data = &ipvs->sysctl_amemthresh;
 	ipvs->sysctl_am_droprate = 10;
-	tbl[idx++].data = &ipvs->sysctl_am_droprate;
-	tbl[idx++].data = &ipvs->sysctl_drop_entry;
-	tbl[idx++].data = &ipvs->sysctl_drop_packet;
-#ifdef CONFIG_IP_VS_NFCT
-	tbl[idx++].data = &ipvs->sysctl_conntrack;
-#endif
-	tbl[idx++].data = &ipvs->sysctl_secure_tcp;
 	ipvs->sysctl_snat_reroute = 1;
-	tbl[idx++].data = &ipvs->sysctl_snat_reroute;
 	ipvs->sysctl_sync_ver = 1;
-	tbl[idx++].data = &ipvs->sysctl_sync_ver;
 	ipvs->sysctl_sync_ports = 1;
-	tbl[idx++].data = &ipvs->sysctl_sync_ports;
-	tbl[idx++].data = &ipvs->sysctl_sync_persist_mode;
-
 	ipvs->sysctl_sync_qlen_max = nr_free_buffer_pages() / 32;
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx++].data = &ipvs->sysctl_sync_qlen_max;
-
 	ipvs->sysctl_sync_sock_size = 0;
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx++].data = &ipvs->sysctl_sync_sock_size;
-
-	tbl[idx++].data = &ipvs->sysctl_cache_bypass;
-	tbl[idx++].data = &ipvs->sysctl_expire_nodest_conn;
-	tbl[idx++].data = &ipvs->sysctl_sloppy_tcp;
-	tbl[idx++].data = &ipvs->sysctl_sloppy_sctp;
-	tbl[idx++].data = &ipvs->sysctl_expire_quiescent_template;
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
-	tbl[idx].data = &ipvs->sysctl_sync_threshold;
-	tbl[idx].extra2 = ipvs;
-	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
-	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
 	ipvs->sysctl_sync_retries = clamp_t(int, DEFAULT_SYNC_RETRIES, 0, 3);
-	tbl[idx++].data = &ipvs->sysctl_sync_retries;
-	tbl[idx++].data = &ipvs->sysctl_nat_icmp_send;
 	ipvs->sysctl_pmtu_disc = 1;
-	tbl[idx++].data = &ipvs->sysctl_pmtu_disc;
-	tbl[idx++].data = &ipvs->sysctl_backup_only;
 	ipvs->sysctl_conn_reuse_mode = 1;
-	tbl[idx++].data = &ipvs->sysctl_conn_reuse_mode;
-	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
-	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
-
 	ipvs->sysctl_run_estimation = 1;
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
-	tbl[idx++].data = &ipvs->sysctl_run_estimation;
-
 	ipvs->est_cpulist_valid = 0;
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
-	tbl[idx++].data = &ipvs->sysctl_est_cpulist;
-
 	ipvs->sysctl_est_nice = IPVS_EST_NICE;
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
-	tbl[idx++].data = &ipvs->sysctl_est_nice;
 
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
-	tbl[idx++].data = &ipvs->sysctl_conn_lfactor;
-
-	if (unpriv)
-		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
-	tbl[idx++].data = &ipvs->sysctl_svc_lfactor;
-
-#ifdef CONFIG_IP_VS_DEBUG
-	/* Global sysctls must be ro in non-init netns */
-	if (!net_eq(net, &init_net))
-		tbl[idx++].mode = 0444;
-#endif
-
-	ret = -ENOMEM;
-	ipvs->sysctl_hdr = register_net_sysctl_sz(net, "net/ipv4/vs", tbl,
-						  ctl_table_size);
+	ipvs->sysctl_hdr = register_sysctl_fields(&ipvs->net->sysctls, "net/ipv4/vs",
+						  vs_vars, &ctx);
 	if (!ipvs->sysctl_hdr)
-		goto err;
-	ipvs->sysctl_tbl = tbl;
+		return -ENOMEM;
 
 	ret = ip_vs_start_estimator(ipvs, &ipvs->tot_stats->s);
 	if (ret < 0)
@@ -5077,15 +5002,11 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 
 err:
 	unregister_net_sysctl_table(ipvs->sysctl_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(tbl);
 	return ret;
 }
 
 static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
 {
-	struct net *net = ipvs->net;
-
 	cancel_delayed_work_sync(&ipvs->expire_nodest_conn_work);
 	cancel_delayed_work_sync(&ipvs->defense_work);
 	cancel_work_sync(&ipvs->defense_work.work);
@@ -5102,8 +5023,6 @@ static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
 	if (ipvs->est_cpulist_valid)
 		free_cpumask_var(ipvs->sysctl_est_cpulist);
 
-	if (!net_eq(net, &init_net))
-		kfree(ipvs->sysctl_tbl);
 }
 
 #else
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 15ccb2b2fa1f..55a50f6511fe 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -114,14 +114,14 @@ struct ip_vs_lblc_table {
  *      IPVS LBLC sysctl table
  */
 #ifdef CONFIG_SYSCTL
-static struct ctl_table vs_vars_table[] = {
-	{
-		.procname	= "lblc_expiration",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+static void *ip_vs_lblc_expiration_data(const struct sysctl_context *ctx)
+{
+	return &net_ipvs(ctx->ns.net_ns)->sysctl_lblc_expiration;
+}
+
+static const struct sysctl_field vs_vars_table[] = {
+	SYSCTL_FIELD_CUSTOM("lblc_expiration", 0644, sizeof(int),
+			 ip_vs_lblc_expiration_data, proc_dointvec_jiffies),
 };
 #endif
 
@@ -548,36 +548,26 @@ static struct ip_vs_scheduler ip_vs_lblc_scheduler = {
 #ifdef CONFIG_SYSCTL
 static int __net_init __ip_vs_lblc_init(struct net *net)
 {
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct netns_ipvs *ipvs = net_ipvs(net);
-	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
 
 	if (!ipvs)
 		return -ENOENT;
 
-	if (!net_eq(net, &init_net)) {
-		ipvs->lblc_ctl_table = kmemdup(vs_vars_table,
-						sizeof(vs_vars_table),
-						GFP_KERNEL);
-		if (ipvs->lblc_ctl_table == NULL)
-			return -ENOMEM;
+	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
 
+	if (!net_eq(net, &init_net)) {
 		/* Don't export sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns)
-			vars_table_size = 0;
+			return 0;
+	}
 
-	} else
-		ipvs->lblc_ctl_table = vs_vars_table;
-	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
-	ipvs->lblc_ctl_table[0].data = &ipvs->sysctl_lblc_expiration;
-
-	ipvs->lblc_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
-						       ipvs->lblc_ctl_table,
-						       vars_table_size);
-	if (!ipvs->lblc_ctl_header) {
-		if (!net_eq(net, &init_net))
-			kfree(ipvs->lblc_ctl_table);
+	ipvs->lblc_ctl_header = register_sysctl_fields(&net->sysctls, "net/ipv4/vs",
+						       vs_vars_table, &ctx);
+	if (!ipvs->lblc_ctl_header)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -587,9 +577,6 @@ static void __net_exit __ip_vs_lblc_exit(struct net *net)
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
 	unregister_net_sysctl_table(ipvs->lblc_ctl_header);
-
-	if (!net_eq(net, &init_net))
-		kfree(ipvs->lblc_ctl_table);
 }
 
 #else
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index c90ea897c3f7..285e720244a0 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -285,14 +285,14 @@ struct ip_vs_lblcr_table {
  *      IPVS LBLCR sysctl table
  */
 
-static struct ctl_table vs_vars_table[] = {
-	{
-		.procname	= "lblcr_expiration",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+static void *ip_vs_lblcr_expiration_data(const struct sysctl_context *ctx)
+{
+	return &net_ipvs(ctx->ns.net_ns)->sysctl_lblcr_expiration;
+}
+
+static const struct sysctl_field vs_vars_table[] = {
+	SYSCTL_FIELD_CUSTOM("lblcr_expiration", 0644, sizeof(int),
+			 ip_vs_lblcr_expiration_data, proc_dointvec_jiffies),
 };
 #endif
 
@@ -734,36 +734,27 @@ static struct ip_vs_scheduler ip_vs_lblcr_scheduler =
 #ifdef CONFIG_SYSCTL
 static int __net_init __ip_vs_lblcr_init(struct net *net)
 {
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct netns_ipvs *ipvs = net_ipvs(net);
-	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
 
 	if (!ipvs)
 		return -ENOENT;
 
-	if (!net_eq(net, &init_net)) {
-		ipvs->lblcr_ctl_table = kmemdup(vs_vars_table,
-						sizeof(vs_vars_table),
-						GFP_KERNEL);
-		if (ipvs->lblcr_ctl_table == NULL)
-			return -ENOMEM;
+	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
 
+	if (!net_eq(net, &init_net)) {
 		/* Don't export sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns)
-			vars_table_size = 0;
-	} else
-		ipvs->lblcr_ctl_table = vs_vars_table;
-	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
-	ipvs->lblcr_ctl_table[0].data = &ipvs->sysctl_lblcr_expiration;
-
-	ipvs->lblcr_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
-							ipvs->lblcr_ctl_table,
-							vars_table_size);
-	if (!ipvs->lblcr_ctl_header) {
-		if (!net_eq(net, &init_net))
-			kfree(ipvs->lblcr_ctl_table);
-		return -ENOMEM;
+			return 0;
 	}
 
+	ipvs->lblcr_ctl_header = register_sysctl_fields(&net->sysctls, "net/ipv4/vs",
+							vs_vars_table, &ctx);
+	if (!ipvs->lblcr_ctl_header)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -772,9 +763,6 @@ static void __net_exit __ip_vs_lblcr_exit(struct net *net)
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
 	unregister_net_sysctl_table(ipvs->lblcr_ctl_header);
-
-	if (!net_eq(net, &init_net))
-		kfree(ipvs->lblcr_ctl_table);
 }
 
 #else
-- 
2.55.0

