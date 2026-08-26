Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395547DD66;
	Wed, 26 Aug 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773410; cv=none; b=sZbIUNbi0NY3F7lUQwe16DyjHQgj5q/5K+rSra4wQ3I2XpTXGfv7PIN7la1hqOw3aTXryC8glitKZXSSruPe/aKEC6qwnXsSt/HzHTAd/A6QtrnnmQ5oLcHToMjT0RyvFO3Btj/loeJMyXCPrjY2ckI4ZjG7M4dOySi4iNCkws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773410; c=relaxed/simple;
	bh=hlF3IiCbxa+gP2wCtwdybCDR7Ef3UPXkyufLdWkDWdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjpIB56eoYBVM0+rHvkvNB0UoOHwDDW/KmkNZNQqN2ZnjuDiMMHEzd8MI7zDhgSISVAl6Nvl8joJVoErqdbWm/kyIYd4of/bLQOVkBEcbwtLj2qfaz1SO8jJkhOnnhJCHP8HRf3iaXolm+VBQXt2CO6wjC/MUAZUGPf8E2vTBuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPeoixw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPeoixw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC6C1F00A3D;
	Wed, 26 Aug 2026 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773399;
	bh=M6K+r7frbaQnKm1ff5EiWI0LXQEWbX4twanvB/wOqp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPeoixw/h+6am17lNpjYT3YBU934MSg5D7OTOR1OrrHz7hku6NTE9kmbolTBPeIIS
	 1eWKkLEi9An9fiHcw68nU4+Xxgfk1yy15f5lyNAho/90usdPcA9yaJEE63aYgyNnHm
	 be6Ao4Ek/xOygqZHJukDGnS/BNty4YBLyQL9d0BJLOW7WwISPqdBbi8NCTrxJDidPZ
	 OaFQBVaXZGdY9GICRWiqNAj4yAk0IL04MUugLfFy7uSxJQb2NHjItZHz6A965v1ibb
	 YTC1x70UvVjB/7Ja1zHaD86GOOCVAFa1HueiJWNn7HaY1Zzxe+nxwFUgdOInBRAELF
	 qOBVB4hbakW9Q==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 10/30] sysctl: net: use sysctl_field for simple IPv4 per-net sysctls
Date: Wed, 26 Aug 2026 21:42:14 +0200
Message-ID: <31743354726622a4fc1a77883ed37921f7057e52.1787771905.git.legion@kernel.org>
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

Several IPv4 sysctl tables are cloned per network namespace only to bind
entries to namespace-local storage. The tables themselves are otherwise
static, and some entries also use extra fields only to recover the
owning network namespace.

Use sysctl_field for the simple per-net IPv4 sysctls in xfrm4, IP
fragment handling, and route configuration. The data pointers are
derived from the registration context, so the descriptors can stay const
and the per-net ctl_table allocation and free paths are no longer
needed.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ipv4/ip_fragment.c  |  96 +++++++++++++++----------------------
 net/ipv4/route.c        | 102 ++++++++++++++++------------------------
 net/ipv4/xfrm4_policy.c |  52 ++++++--------------
 3 files changed, 92 insertions(+), 158 deletions(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 56b0f738d2f2..9d808ecf7b71 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -548,32 +548,37 @@ EXPORT_SYMBOL(ip_check_defrag);
 #ifdef CONFIG_SYSCTL
 static int dist_min;
 
-static struct ctl_table ip4_frags_ns_ctl_table[] = {
-	{
-		.procname	= "ipfrag_high_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "ipfrag_low_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "ipfrag_time",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "ipfrag_max_dist",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &dist_min,
-	},
+static unsigned long *ip4_frags_high_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv4.fqdir->high_thresh;
+}
+
+static unsigned long *ip4_frags_low_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv4.fqdir->low_thresh;
+}
+
+static int *ip4_frags_max_dist_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv4.fqdir->max_dist;
+}
+
+static void *ip4_frags_timeout_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv4.fqdir->timeout;
+}
+
+static const struct sysctl_field ip4_frags_ns_ctl_table[] = {
+	SYSCTL_FIELD_ULONG_MINMAX("ipfrag_high_thresh", 0644,
+			       ip4_frags_high_thresh_data,
+			       ip4_frags_low_thresh_data, NULL),
+	SYSCTL_FIELD_ULONG_MINMAX("ipfrag_low_thresh", 0644,
+			       ip4_frags_low_thresh_data,
+			       NULL, ip4_frags_high_thresh_data),
+	SYSCTL_FIELD_CUSTOM("ipfrag_time", 0644, sizeof(int),
+			 ip4_frags_timeout_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("ipfrag_max_dist", 0644,
+				    ip4_frags_max_dist_data, &dist_min, NULL),
 };
 
 /* secret interval has been deprecated */
@@ -590,45 +595,20 @@ static struct ctl_table ip4_frags_ctl_table[] = {
 
 static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 {
-	struct ctl_table *table;
-	struct ctl_table_header *hdr;
-
-	table = ip4_frags_ns_ctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(ip4_frags_ns_ctl_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-	}
-	table[0].data	= &net->ipv4.fqdir->high_thresh;
-	table[0].extra1	= &net->ipv4.fqdir->low_thresh;
-	table[1].data	= &net->ipv4.fqdir->low_thresh;
-	table[1].extra2	= &net->ipv4.fqdir->high_thresh;
-	table[2].data	= &net->ipv4.fqdir->timeout;
-	table[3].data	= &net->ipv4.fqdir->max_dist;
-
-	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
-				     ARRAY_SIZE(ip4_frags_ns_ctl_table));
-	if (!hdr)
-		goto err_reg;
-
-	net->ipv4.frags_hdr = hdr;
+	net->ipv4.frags_hdr = register_sysctl_fields(&net->sysctls, "net/ipv4",
+						     ip4_frags_ns_ctl_table, &ctx);
+	if (!net->ipv4.frags_hdr)
+		return -ENOMEM;
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void __net_exit ip4_frags_ns_ctl_unregister(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->ipv4.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.frags_hdr);
-	kfree(table);
 }
 
 static void __init ip4_frags_ctl_register(void)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3d62d45d84bd..7b64756e0ccf 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3471,7 +3471,7 @@ static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 static int ipv4_sysctl_rtcache_flush(const struct ctl_table *__ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = (struct net *)__ctl->extra1;
+	struct net *net = __ctl->data;
 
 	if (write) {
 		rt_cache_flush(net);
@@ -3573,85 +3573,63 @@ static struct ctl_table ipv4_route_table[] = {
 
 static const char ipv4_route_flush_procname[] = "flush";
 
-static struct ctl_table ipv4_route_netns_table[] = {
-	{
-		.procname	= ipv4_route_flush_procname,
-		.maxlen		= sizeof(int),
-		.mode		= 0200,
-		.proc_handler	= ipv4_sysctl_rtcache_flush,
-	},
-	{
-		.procname       = "min_pmtu",
-		.data           = &init_net.ipv4.ip_rt_min_pmtu,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = &ip_min_valid_pmtu,
-	},
-	{
-		.procname       = "mtu_expires",
-		.data           = &init_net.ipv4.ip_rt_mtu_expires,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_jiffies,
-	},
-	{
-		.procname   = "min_adv_mss",
-		.data       = &init_net.ipv4.ip_rt_min_advmss,
-		.maxlen     = sizeof(int),
-		.mode       = 0644,
-		.proc_handler   = proc_dointvec,
-	},
+#define IPV4_ROUTE_DATA(name)						\
+static int *ipv4_route_ ## name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->ipv4.name;				\
+}
+
+static void *ipv4_route_net_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+IPV4_ROUTE_DATA(ip_rt_min_pmtu)
+IPV4_ROUTE_DATA(ip_rt_min_advmss)
+
+static void *ipv4_route_ip_rt_mtu_expires_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv4.ip_rt_mtu_expires;
+}
+
+static const struct sysctl_field ipv4_route_netns_table[] = {
+	SYSCTL_FIELD_CUSTOM(ipv4_route_flush_procname, 0200, sizeof(int),
+			 ipv4_route_net_data, ipv4_sysctl_rtcache_flush),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("min_pmtu", 0644,
+				    ipv4_route_ip_rt_min_pmtu_data,
+				    &ip_min_valid_pmtu, NULL),
+	SYSCTL_FIELD_CUSTOM("mtu_expires", 0644, sizeof(int),
+			 ipv4_route_ip_rt_mtu_expires_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_INT("min_adv_mss", 0644, ipv4_route_ip_rt_min_advmss_data),
 };
 
 static __net_init int sysctl_route_net_init(struct net *net)
 {
-	struct ctl_table *tbl;
-	size_t table_size = ARRAY_SIZE(ipv4_route_netns_table);
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-	tbl = ipv4_route_netns_table;
 	if (!net_eq(net, &init_net)) {
-		int i;
-
-		tbl = kmemdup(tbl, sizeof(ipv4_route_netns_table), GFP_KERNEL);
-		if (!tbl)
-			goto err_dup;
-
 		/* Don't export non-whitelisted sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns) {
-			if (tbl[0].procname != ipv4_route_flush_procname)
-				table_size = 0;
+			if (ipv4_route_netns_table[0].procname !=
+			    ipv4_route_flush_procname)
+				return 0;
 		}
-
-		/* Update the variables to point into the current struct net
-		 * except for the first element flush
-		 */
-		for (i = 1; i < table_size; i++)
-			tbl[i].data += (void *)net - (void *)&init_net;
 	}
-	tbl[0].extra1 = net;
 
-	net->ipv4.route_hdr = register_net_sysctl_sz(net, "net/ipv4/route",
-						     tbl, table_size);
+	net->ipv4.route_hdr = register_sysctl_fields(&net->sysctls,
+						     "net/ipv4/route",
+						     ipv4_route_netns_table, &ctx);
 	if (!net->ipv4.route_hdr)
-		goto err_reg;
+		return -ENOMEM;
 	return 0;
-
-err_reg:
-	if (tbl != ipv4_route_netns_table)
-		kfree(tbl);
-err_dup:
-	return -ENOMEM;
 }
 
 static __net_exit void sysctl_route_net_exit(struct net *net)
 {
-	const struct ctl_table *tbl;
-
-	tbl = net->ipv4.route_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.route_hdr);
-	BUG_ON(tbl == ipv4_route_netns_table);
-	kfree(tbl);
 }
 
 static __net_initdata struct pernet_operations sysctl_route_ops = {
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 58faf1ddd2b1..be871b3ef3bd 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -141,56 +141,32 @@ static const struct xfrm_policy_afinfo xfrm4_policy_afinfo = {
 };
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table xfrm4_policy_table[] = {
-	{
-		.procname       = "xfrm4_gc_thresh",
-		.data           = &init_net.xfrm.xfrm4_dst_ops.gc_thresh,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
+static int *xfrm4_gc_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->xfrm.xfrm4_dst_ops.gc_thresh;
+}
+
+static const struct sysctl_field xfrm4_policy_table[] = {
+	SYSCTL_FIELD_INT("xfrm4_gc_thresh", 0644, xfrm4_gc_thresh_data),
 };
 
 static __net_init int xfrm4_net_sysctl_init(struct net *net)
 {
-	struct ctl_table *table;
-	struct ctl_table_header *hdr;
-
-	table = xfrm4_policy_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(xfrm4_policy_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-
-		table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
-	}
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
-				     ARRAY_SIZE(xfrm4_policy_table));
-	if (!hdr)
-		goto err_reg;
+	net->ipv4.xfrm4_hdr = register_sysctl_fields(&net->sysctls, "net/ipv4",
+						     xfrm4_policy_table, &ctx);
+	if (!net->ipv4.xfrm4_hdr)
+		return -ENOMEM;
 
-	net->ipv4.xfrm4_hdr = hdr;
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static __net_exit void xfrm4_net_sysctl_exit(struct net *net)
 {
-	const struct ctl_table *table;
-
-	if (!net->ipv4.xfrm4_hdr)
-		return;
-
-	table = net->ipv4.xfrm4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.xfrm4_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 #else /* CONFIG_SYSCTL */
 static inline int xfrm4_net_sysctl_init(struct net *net)
-- 
2.55.0

