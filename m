Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABE477E2E;
	Wed, 26 Aug 2026 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773443; cv=none; b=rOZA39W4fAqb+RdGMw2d/H7yZ5fkNCnfRv4pdj8VJBVtkERA62N5IvE5bwReTkeijvV72Unc6/8+dMMei6fAO6Idw5GOWutdFqFmmqEjAO/Es6FrwJli4f0Fn7Wp4PGd96TyFKRVOtNN//STMxvSDx9mHfEwWuK3SgItwWuDB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773443; c=relaxed/simple;
	bh=ZeYh2Kyhr6n9jrgW3E6nUggo223eDqYRftBMhkXvGF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UA+40XLv8Fi6NrRiDD/cJo4kYePgsjowZfXIPHgM1TweFtwoLzV5P8xkIbIoQw+0a7Y6eg94N7nantoScWbyMXcd8CWIpeg2NL4C/07aHEDbMCLqoJLH3/dWByXUGZKFrUjkaUGGVwy/MSLtwFLN16ZHHdu4Ua7q4MAAPBhOWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MojPgYbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MojPgYbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6611F00AC4;
	Wed, 26 Aug 2026 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773424;
	bh=NhMdWGiO7w3/+4YdNmFWkV/x4oxWwJS4j0OcPW5vQKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MojPgYbm7KNhuPTFBs8MCxqaF8FyGREWVa+JQQ8+4VA/zkK8Ftcsu+eELhJ2DahZx
	 6qorQnzdFWHnD6BpteuU9aCEqu0Q50NAV66KgBr5GkcnKrtuhBLLJBXfIXt+MQ34Oy
	 HFDunqhjdMFFYhX89yDtToH1uuHQ4DupIVT98ecVibe3Cl4OK7elGMPoXFS3yWbW8H
	 PoUeKaTBh+Z1bIRsPttNQPy4kYwzxIxEuQoYdvKOLN9DVOelkGPbKUdIutyO7pn6n6
	 TvG8S1hTtu32YhAcUcREiKUzKofUSkual6CbrYktcXysuxNtuuZsKr4/rfLppSi28v
	 33hlvH3mAkWvQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 18/30] sysctl: net: use sysctl_field in core IPv6 sysctls
Date: Wed, 26 Aug 2026 21:42:22 +0200
Message-ID: <e10a1f7d819dde0bfa5931479f28ce6e4cc2b158.1787771905.git.legion@kernel.org>
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

The core IPv6, route and ICMP sysctl tables are per-netns, but they
currently get there by cloning ctl_table arrays and patching each data
pointer after allocation. That keeps writable table copies around for
every net namespace and makes the code depend on table indexes staying
in sync with the patch-up code.

Describe these tables with sysctl_field instead. The data pointers are
now derived from the registration context, so the tables can stay static
and const while still resolving to the right net namespace.

Keep the few non-standard handlers as custom fields. The route flush
handler now derives the net namespace from its data pointer instead of
using extra1, and the multipath and wide IOAM handlers keep their limits
inside the handler-local ctl_table copy.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/net/ipv6.h         |   6 +-
 net/ipv6/icmp.c            | 127 ++++++---------
 net/ipv6/route.c           | 173 ++++++++------------
 net/ipv6/sysctl_net_ipv6.c | 322 ++++++++++++-------------------------
 4 files changed, 224 insertions(+), 404 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 1dec81faff28..08ede58aabfb 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1207,10 +1207,8 @@ static inline int snmp6_unregister_dev(struct inet6_dev *idev) { return 0; }
 #endif
 
 #ifdef CONFIG_SYSCTL
-struct ctl_table *ipv6_icmp_sysctl_init(struct net *net);
-size_t ipv6_icmp_sysctl_table_size(void);
-struct ctl_table *ipv6_route_sysctl_init(struct net *net);
-size_t ipv6_route_sysctl_table_size(struct net *net);
+int ipv6_icmp_sysctl_register(struct sysctl_context *ctx);
+int ipv6_route_sysctl_register(struct sysctl_context *ctx);
 int ipv6_sysctl_register(void);
 void ipv6_sysctl_unregister(void);
 #endif
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index efb23807a026..8fd0dc035ccd 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1371,87 +1371,62 @@ EXPORT_SYMBOL(icmpv6_err_convert);
 
 #ifdef CONFIG_SYSCTL
 
-static u32 icmpv6_errors_extension_mask_all =
+static unsigned int icmpv6_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-static struct ctl_table ipv6_icmp_table_template[] = {
-	{
-		.procname	= "ratelimit",
-		.data		= &init_net.ipv6.sysctl.icmpv6_time,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "echo_ignore_all",
-		.data		= &init_net.ipv6.sysctl.icmpv6_echo_ignore_all,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler = proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "echo_ignore_multicast",
-		.data		= &init_net.ipv6.sysctl.icmpv6_echo_ignore_multicast,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler = proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "echo_ignore_anycast",
-		.data		= &init_net.ipv6.sysctl.icmpv6_echo_ignore_anycast,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler = proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ratemask",
-		.data		= &init_net.ipv6.sysctl.icmpv6_ratemask_ptr,
-		.maxlen		= ICMPV6_MSG_MAX + 1,
-		.mode		= 0644,
-		.proc_handler = proc_do_large_bitmap,
-	},
-	{
-		.procname	= "error_anycast_as_unicast",
-		.data		= &init_net.ipv6.sysctl.icmpv6_error_anycast_as_unicast,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "errors_extension_mask",
-		.data		= &init_net.ipv6.sysctl.icmpv6_errors_extension_mask,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &icmpv6_errors_extension_mask_all,
-	},
-};
+#define IPV6_ICMP_DATA(type, name, field)				\
+static type *ipv6_icmp_##name##_data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->ipv6.sysctl.field;			\
+}
 
-struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
-{
-	struct ctl_table *table;
-
-	table = kmemdup(ipv6_icmp_table_template,
-			sizeof(ipv6_icmp_table_template),
-			GFP_KERNEL);
-
-	if (table) {
-		table[0].data = &net->ipv6.sysctl.icmpv6_time;
-		table[1].data = &net->ipv6.sysctl.icmpv6_echo_ignore_all;
-		table[2].data = &net->ipv6.sysctl.icmpv6_echo_ignore_multicast;
-		table[3].data = &net->ipv6.sysctl.icmpv6_echo_ignore_anycast;
-		table[4].data = &net->ipv6.sysctl.icmpv6_ratemask_ptr;
-		table[5].data = &net->ipv6.sysctl.icmpv6_error_anycast_as_unicast;
-		table[6].data = &net->ipv6.sysctl.icmpv6_errors_extension_mask;
-	}
-	return table;
+#define IPV6_ICMP_CUSTOM_DATA(name, field)				\
+static void *ipv6_icmp_##name##_data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->ipv6.sysctl.field;			\
 }
 
-size_t ipv6_icmp_sysctl_table_size(void)
+IPV6_ICMP_CUSTOM_DATA(ratelimit, icmpv6_time)
+IPV6_ICMP_DATA(u8, echo_ignore_all, icmpv6_echo_ignore_all)
+IPV6_ICMP_DATA(u8, echo_ignore_multicast, icmpv6_echo_ignore_multicast)
+IPV6_ICMP_DATA(u8, echo_ignore_anycast, icmpv6_echo_ignore_anycast)
+IPV6_ICMP_CUSTOM_DATA(ratemask, icmpv6_ratemask_ptr)
+IPV6_ICMP_DATA(u8, error_anycast_as_unicast,
+	       icmpv6_error_anycast_as_unicast)
+IPV6_ICMP_DATA(u8, errors_extension_mask,
+	       icmpv6_errors_extension_mask)
+
+static const struct sysctl_field ipv6_icmp_table[] = {
+	SYSCTL_FIELD_CUSTOM("ratelimit", 0644, sizeof(int),
+			 ipv6_icmp_ratelimit_data, proc_dointvec_ms_jiffies),
+	SYSCTL_FIELD_U8("echo_ignore_all", 0644,
+		     ipv6_icmp_echo_ignore_all_data),
+	SYSCTL_FIELD_U8("echo_ignore_multicast", 0644,
+		     ipv6_icmp_echo_ignore_multicast_data),
+	SYSCTL_FIELD_U8("echo_ignore_anycast", 0644,
+		     ipv6_icmp_echo_ignore_anycast_data),
+	SYSCTL_FIELD_CUSTOM("ratemask", 0644, ICMPV6_MSG_MAX + 1,
+			 ipv6_icmp_ratemask_data, proc_do_large_bitmap),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("error_anycast_as_unicast", 0644,
+				   ipv6_icmp_error_anycast_as_unicast_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("errors_extension_mask", 0644,
+				   ipv6_icmp_errors_extension_mask_data,
+				   SYSCTL_UINT_ZERO,
+				   &icmpv6_errors_extension_mask_all),
+};
+
+int ipv6_icmp_sysctl_register(struct sysctl_context *ctx)
 {
-	return ARRAY_SIZE(ipv6_icmp_table_template);
+	struct ctl_table_header *hdr;
+
+	hdr = register_sysctl_fields(&ctx->ns.net_ns->sysctls, "net/ipv6/icmp",
+				     ipv6_icmp_table, ctx);
+	if (!hdr)
+		return -ENOMEM;
+
+	ctx->ns.net_ns->ipv6.sysctl.icmp_hdr = hdr;
+
+	return 0;
 }
 #endif
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b106e5fef9cb..4861972d6bd3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6539,127 +6539,82 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 	if (ret)
 		return ret;
 
-	net = (struct net *)ctl->extra1;
+	net = container_of(ctl->data, struct net, ipv6.sysctl.flush_delay);
 	delay = READ_ONCE(net->ipv6.sysctl.flush_delay);
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
 
-static struct ctl_table ipv6_route_table_template[] = {
-	{
-		.procname	=	"max_size",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_max_size,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
-	},
-	{
-		.procname	=	"gc_thresh",
-		.data		=	&ip6_dst_ops_template.gc_thresh,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
-	},
-	{
-		.procname	=	"flush",
-		.data		=	&init_net.ipv6.sysctl.flush_delay,
-		.maxlen		=	sizeof(int),
-		.mode		=	0200,
-		.proc_handler	=	ipv6_sysctl_rtcache_flush
-	},
-	{
-		.procname	=	"gc_min_interval",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_min_interval,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec_jiffies,
-	},
-	{
-		.procname	=	"gc_timeout",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_timeout,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec_jiffies,
-	},
-	{
-		.procname	=	"gc_interval",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_interval,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec_jiffies,
-	},
-	{
-		.procname	=	"gc_elasticity",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
-	},
-	{
-		.procname	=	"mtu_expires",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_mtu_expires,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec_jiffies,
-	},
-	{
-		.procname	=	"min_adv_mss",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_min_advmss,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
-	},
-	{
-		.procname	=	"gc_min_interval_ms",
-		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_min_interval,
-		.maxlen		=	sizeof(int),
-		.mode		=	0644,
-		.proc_handler	=	proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	=	"skip_notify_on_dev_down",
-		.data		=	&init_net.ipv6.sysctl.skip_notify_on_dev_down,
-		.maxlen		=	sizeof(u8),
-		.mode		=	0644,
-		.proc_handler	=	proc_dou8vec_minmax,
-		.extra1		=	SYSCTL_ZERO,
-		.extra2		=	SYSCTL_ONE,
-	},
+#define IPV6_ROUTE_DATA(type, name, field)				\
+static type *ipv6_route_##name##_data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->ipv6.sysctl.field;			\
+}
+
+#define IPV6_ROUTE_CUSTOM_DATA(name, field)				\
+static void *ipv6_route_##name##_data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->ipv6.sysctl.field;			\
+}
+
+IPV6_ROUTE_DATA(int, max_size, ip6_rt_max_size)
+IPV6_ROUTE_DATA(int, gc_elasticity, ip6_rt_gc_elasticity)
+IPV6_ROUTE_DATA(int, min_adv_mss, ip6_rt_min_advmss)
+IPV6_ROUTE_DATA(u8, skip_notify_on_dev_down, skip_notify_on_dev_down)
+IPV6_ROUTE_CUSTOM_DATA(flush, flush_delay)
+IPV6_ROUTE_CUSTOM_DATA(gc_min_interval, ip6_rt_gc_min_interval)
+IPV6_ROUTE_CUSTOM_DATA(gc_timeout, ip6_rt_gc_timeout)
+IPV6_ROUTE_CUSTOM_DATA(gc_interval, ip6_rt_gc_interval)
+IPV6_ROUTE_CUSTOM_DATA(mtu_expires, ip6_rt_mtu_expires)
+
+static int *ipv6_route_gc_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv6.ip6_dst_ops.gc_thresh;
+}
+
+static const struct sysctl_field ipv6_route_table[] = {
+	SYSCTL_FIELD_INT("max_size", 0644, ipv6_route_max_size_data),
+	SYSCTL_FIELD_INT("gc_thresh", 0644, ipv6_route_gc_thresh_data),
+	SYSCTL_FIELD_CUSTOM("flush", 0200, sizeof(int), ipv6_route_flush_data,
+			 ipv6_sysctl_rtcache_flush),
+	SYSCTL_FIELD_CUSTOM("gc_min_interval", 0644, sizeof(int),
+			 ipv6_route_gc_min_interval_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("gc_timeout", 0644, sizeof(int),
+			 ipv6_route_gc_timeout_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("gc_interval", 0644, sizeof(int),
+			 ipv6_route_gc_interval_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_INT("gc_elasticity", 0644,
+		      ipv6_route_gc_elasticity_data),
+	SYSCTL_FIELD_CUSTOM("mtu_expires", 0644, sizeof(int),
+			 ipv6_route_mtu_expires_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_INT("min_adv_mss", 0644, ipv6_route_min_adv_mss_data),
+	SYSCTL_FIELD_CUSTOM("gc_min_interval_ms", 0644, sizeof(int),
+			 ipv6_route_gc_min_interval_data,
+			 proc_dointvec_ms_jiffies),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("skip_notify_on_dev_down", 0644,
+				   ipv6_route_skip_notify_on_dev_down_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
 };
 
-struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
+int ipv6_route_sysctl_register(struct sysctl_context *ctx)
 {
-	struct ctl_table *table;
-
-	table = kmemdup(ipv6_route_table_template,
-			sizeof(ipv6_route_table_template),
-			GFP_KERNEL);
+	struct ctl_table_header *hdr;
+	size_t table_size = ARRAY_SIZE(ipv6_route_table);
 
-	if (table) {
-		table[0].data = &net->ipv6.sysctl.ip6_rt_max_size;
-		table[1].data = &net->ipv6.ip6_dst_ops.gc_thresh;
-		table[2].data = &net->ipv6.sysctl.flush_delay;
-		table[2].extra1 = net;
-		table[3].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
-		table[4].data = &net->ipv6.sysctl.ip6_rt_gc_timeout;
-		table[5].data = &net->ipv6.sysctl.ip6_rt_gc_interval;
-		table[6].data = &net->ipv6.sysctl.ip6_rt_gc_elasticity;
-		table[7].data = &net->ipv6.sysctl.ip6_rt_mtu_expires;
-		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
-		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
-		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
-	}
+	/* Don't export sysctls to unprivileged users */
+	if (ctx->ns.net_ns->user_ns != &init_user_ns)
+		table_size = 1;
 
-	return table;
-}
+	hdr = __register_sysctl_fields(&ctx->ns.net_ns->sysctls, "net/ipv6/route",
+				       ipv6_route_table, table_size,
+				       ctx, sizeof(*ctx));
+	if (!hdr)
+		return -ENOMEM;
 
-size_t ipv6_route_sysctl_table_size(struct net *net)
-{
-	/* Don't export sysctls to unprivileged users */
-	if (net->user_ns != &init_user_ns)
-		return 1;
+	ctx->ns.net_ns->ipv6.sysctl.route_hdr = hdr;
 
-	return ARRAY_SIZE(ipv6_route_table_template);
+	return 0;
 }
 #endif
 
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index d2cd33e2698d..45485ead8048 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -10,7 +10,6 @@
 #include <linux/sysctl.h>
 #include <linux/in6.h>
 #include <linux/ipv6.h>
-#include <linux/slab.h>
 #include <linux/export.h>
 #include <net/ndisc.h>
 #include <net/ipv6.h>
@@ -24,21 +23,24 @@
 #include <linux/ioam6.h>
 
 static int flowlabel_reflect_max = 0x7;
-static int auto_flowlabels_max = IP6_AUTO_FLOW_LABEL_MAX;
-static u32 rt6_multipath_hash_fields_all_mask =
+static unsigned int auto_flowlabels_max = IP6_AUTO_FLOW_LABEL_MAX;
+static unsigned int rt6_multipath_hash_fields_all_mask =
 	FIB_MULTIPATH_HASH_FIELD_ALL_MASK;
-static u32 ioam6_id_max = IOAM6_DEFAULT_ID;
+static unsigned int ioam6_id_max = IOAM6_DEFAULT_ID;
 static u64 ioam6_id_wide_max = IOAM6_DEFAULT_ID_WIDE;
 
 static int proc_rt6_multipath_hash_policy(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ctl_table tmp = *table;
 	struct net *net;
 	int ret;
 
 	net = container_of(table->data, struct net,
 			   ipv6.sysctl.multipath_hash_policy);
-	ret = proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_UINT_ZERO;
+	tmp.extra2 = SYSCTL_UINT_THREE;
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		call_netevent_notifiers(NETEVENT_IPV6_MPATH_HASH_UPDATE, net);
 
@@ -49,170 +51,103 @@ static int
 proc_rt6_multipath_hash_fields(const struct ctl_table *table, int write, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
+	struct ctl_table tmp = *table;
 	struct net *net;
 	int ret;
 
 	net = container_of(table->data, struct net,
 			   ipv6.sysctl.multipath_hash_fields);
-	ret = proc_douintvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_UINT_ONE;
+	tmp.extra2 = &rt6_multipath_hash_fields_all_mask;
+	ret = proc_douintvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		call_netevent_notifiers(NETEVENT_IPV6_MPATH_HASH_UPDATE, net);
 
 	return ret;
 }
 
-static struct ctl_table ipv6_table_template[] = {
-	{
-		.procname	= "bindv6only",
-		.data		= &init_net.ipv6.sysctl.bindv6only,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "anycast_src_echo_reply",
-		.data		= &init_net.ipv6.sysctl.anycast_src_echo_reply,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "flowlabel_consistency",
-		.data		= &init_net.ipv6.sysctl.flowlabel_consistency,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "auto_flowlabels",
-		.data		= &init_net.ipv6.sysctl.auto_flowlabels,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra2		= &auto_flowlabels_max
-	},
-	{
-		.procname	= "fwmark_reflect",
-		.data		= &init_net.ipv6.sysctl.fwmark_reflect,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "idgen_retries",
-		.data		= &init_net.ipv6.sysctl.idgen_retries,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "idgen_delay",
-		.data		= &init_net.ipv6.sysctl.idgen_delay,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "flowlabel_state_ranges",
-		.data		= &init_net.ipv6.sysctl.flowlabel_state_ranges,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_nonlocal_bind",
-		.data		= &init_net.ipv6.sysctl.ip_nonlocal_bind,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "flowlabel_reflect",
-		.data		= &init_net.ipv6.sysctl.flowlabel_reflect,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &flowlabel_reflect_max,
-	},
-	{
-		.procname	= "max_dst_opts_number",
-		.data		= &init_net.ipv6.sysctl.max_dst_opts_cnt,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "max_hbh_opts_number",
-		.data		= &init_net.ipv6.sysctl.max_hbh_opts_cnt,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "max_dst_opts_length",
-		.data		= &init_net.ipv6.sysctl.max_dst_opts_len,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "max_hbh_length",
-		.data		= &init_net.ipv6.sysctl.max_hbh_opts_len,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "fib_multipath_hash_policy",
-		.data		= &init_net.ipv6.sysctl.multipath_hash_policy,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler   = proc_rt6_multipath_hash_policy,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
-	},
-	{
-		.procname	= "fib_multipath_hash_fields",
-		.data		= &init_net.ipv6.sysctl.multipath_hash_fields,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_rt6_multipath_hash_fields,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &rt6_multipath_hash_fields_all_mask,
-	},
-	{
-		.procname	= "seg6_flowlabel",
-		.data		= &init_net.ipv6.sysctl.seg6_flowlabel,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "fib_notify_on_flag_change",
-		.data		= &init_net.ipv6.sysctl.fib_notify_on_flag_change,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_TWO,
-	},
-	{
-		.procname	= "ioam6_id",
-		.data		= &init_net.ipv6.sysctl.ioam6_id,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra2		= &ioam6_id_max,
-	},
-	{
-		.procname	= "ioam6_id_wide",
-		.data		= &init_net.ipv6.sysctl.ioam6_id_wide,
-		.maxlen		= sizeof(u64),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra2		= &ioam6_id_wide_max,
-	},
+#define IPV6_SYSCTL_DATA(type, name, field)				\
+static type *ipv6_##name##_data(const struct sysctl_context *ctx)		\
+{									\
+	return &ctx->ns.net_ns->ipv6.sysctl.field;			\
+}
+
+#define IPV6_SYSCTL_CUSTOM_DATA(name, field)				\
+static void *ipv6_##name##_data(const struct sysctl_context *ctx)		\
+{									\
+	return &ctx->ns.net_ns->ipv6.sysctl.field;			\
+}
+
+IPV6_SYSCTL_DATA(u8, bindv6only, bindv6only)
+IPV6_SYSCTL_DATA(u8, anycast_src_echo_reply, anycast_src_echo_reply)
+IPV6_SYSCTL_DATA(u8, flowlabel_consistency, flowlabel_consistency)
+IPV6_SYSCTL_DATA(u8, auto_flowlabels, auto_flowlabels)
+IPV6_SYSCTL_DATA(u8, fwmark_reflect, fwmark_reflect)
+IPV6_SYSCTL_DATA(int, idgen_retries, idgen_retries)
+IPV6_SYSCTL_CUSTOM_DATA(idgen_delay, idgen_delay)
+IPV6_SYSCTL_DATA(u8, flowlabel_state_ranges, flowlabel_state_ranges)
+IPV6_SYSCTL_DATA(u8, ip_nonlocal_bind, ip_nonlocal_bind)
+IPV6_SYSCTL_DATA(int, flowlabel_reflect, flowlabel_reflect)
+IPV6_SYSCTL_DATA(int, max_dst_opts_number, max_dst_opts_cnt)
+IPV6_SYSCTL_DATA(int, max_hbh_opts_number, max_hbh_opts_cnt)
+IPV6_SYSCTL_DATA(int, max_dst_opts_length, max_dst_opts_len)
+IPV6_SYSCTL_DATA(int, max_hbh_length, max_hbh_opts_len)
+IPV6_SYSCTL_CUSTOM_DATA(fib_multipath_hash_policy, multipath_hash_policy)
+IPV6_SYSCTL_CUSTOM_DATA(fib_multipath_hash_fields, multipath_hash_fields)
+IPV6_SYSCTL_DATA(int, seg6_flowlabel, seg6_flowlabel)
+IPV6_SYSCTL_DATA(u8, fib_notify_on_flag_change, fib_notify_on_flag_change)
+IPV6_SYSCTL_DATA(unsigned int, ioam6_id, ioam6_id)
+IPV6_SYSCTL_CUSTOM_DATA(ioam6_id_wide, ioam6_id_wide)
+
+static int proc_ioam6_id_wide(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.extra2 = &ioam6_id_wide_max;
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static const struct sysctl_field ipv6_table[] = {
+	SYSCTL_FIELD_U8("bindv6only", 0644, ipv6_bindv6only_data),
+	SYSCTL_FIELD_U8("anycast_src_echo_reply", 0644,
+		     ipv6_anycast_src_echo_reply_data),
+	SYSCTL_FIELD_U8("flowlabel_consistency", 0644,
+		     ipv6_flowlabel_consistency_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("auto_flowlabels", 0644,
+				   ipv6_auto_flowlabels_data, NULL,
+				   &auto_flowlabels_max),
+	SYSCTL_FIELD_U8("fwmark_reflect", 0644, ipv6_fwmark_reflect_data),
+	SYSCTL_FIELD_INT("idgen_retries", 0644, ipv6_idgen_retries_data),
+	SYSCTL_FIELD_CUSTOM("idgen_delay", 0644, sizeof(int),
+			 ipv6_idgen_delay_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_U8("flowlabel_state_ranges", 0644,
+		     ipv6_flowlabel_state_ranges_data),
+	SYSCTL_FIELD_U8("ip_nonlocal_bind", 0644, ipv6_ip_nonlocal_bind_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("flowlabel_reflect", 0644,
+				    ipv6_flowlabel_reflect_data,
+				    SYSCTL_ZERO, &flowlabel_reflect_max),
+	SYSCTL_FIELD_INT("max_dst_opts_number", 0644,
+		      ipv6_max_dst_opts_number_data),
+	SYSCTL_FIELD_INT("max_hbh_opts_number", 0644,
+		      ipv6_max_hbh_opts_number_data),
+	SYSCTL_FIELD_INT("max_dst_opts_length", 0644,
+		      ipv6_max_dst_opts_length_data),
+	SYSCTL_FIELD_INT("max_hbh_length", 0644, ipv6_max_hbh_length_data),
+	SYSCTL_FIELD_CUSTOM("fib_multipath_hash_policy", 0644, sizeof(u8),
+			 ipv6_fib_multipath_hash_policy_data,
+			 proc_rt6_multipath_hash_policy),
+	SYSCTL_FIELD_CUSTOM("fib_multipath_hash_fields", 0644, sizeof(u32),
+			 ipv6_fib_multipath_hash_fields_data,
+			 proc_rt6_multipath_hash_fields),
+	SYSCTL_FIELD_INT("seg6_flowlabel", 0644, ipv6_seg6_flowlabel_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("fib_notify_on_flag_change", 0644,
+				   ipv6_fib_notify_on_flag_change_data,
+				   SYSCTL_UINT_ZERO, SYSCTL_UINT_TWO),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("ioam6_id", 0644, ipv6_ioam6_id_data,
+				     NULL, &ioam6_id_max),
+	SYSCTL_FIELD_CUSTOM("ioam6_id_wide", 0644, sizeof(u64),
+			 ipv6_ioam6_id_wide_data, proc_ioam6_id_wide),
 };
 
 static struct ctl_table ipv6_rotable[] = {
@@ -251,81 +186,38 @@ static struct ctl_table ipv6_rotable[] = {
 
 static int __net_init ipv6_sysctl_net_init(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(ipv6_table_template);
-	struct ctl_table *ipv6_table;
-	struct ctl_table *ipv6_route_table;
-	struct ctl_table *ipv6_icmp_table;
-	int err, i;
-
-	err = -ENOMEM;
-	ipv6_table = kmemdup(ipv6_table_template, sizeof(ipv6_table_template),
-			     GFP_KERNEL);
-	if (!ipv6_table)
-		goto out;
-	/* Update the variables to point into the current struct net */
-	for (i = 0; i < table_size; i++)
-		ipv6_table[i].data += (void *)net - (void *)&init_net;
-
-	ipv6_route_table = ipv6_route_sysctl_init(net);
-	if (!ipv6_route_table)
-		goto out_ipv6_table;
-
-	ipv6_icmp_table = ipv6_icmp_sysctl_init(net);
-	if (!ipv6_icmp_table)
-		goto out_ipv6_route_table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
+	int err = -ENOMEM;
 
-	net->ipv6.sysctl.hdr = register_net_sysctl_sz(net, "net/ipv6",
-						      ipv6_table, table_size);
+	net->ipv6.sysctl.hdr = register_sysctl_fields(&net->sysctls, "net/ipv6",
+						      ipv6_table, &ctx);
 	if (!net->ipv6.sysctl.hdr)
-		goto out_ipv6_icmp_table;
+		goto out;
 
-	net->ipv6.sysctl.route_hdr = register_net_sysctl_sz(net,
-							    "net/ipv6/route",
-							    ipv6_route_table,
-							    ipv6_route_sysctl_table_size(net));
-	if (!net->ipv6.sysctl.route_hdr)
-		goto out_unregister_ipv6_table;
+	err = ipv6_route_sysctl_register(&ctx);
+	if (err)
+		goto out_err;
 
-	net->ipv6.sysctl.icmp_hdr = register_net_sysctl_sz(net,
-							   "net/ipv6/icmp",
-							   ipv6_icmp_table,
-							   ipv6_icmp_sysctl_table_size());
-	if (!net->ipv6.sysctl.icmp_hdr)
-		goto out_unregister_route_table;
+	err = ipv6_icmp_sysctl_register(&ctx);
+	if (err)
+		goto out_err;
 
 	err = 0;
 out:
 	return err;
-out_unregister_route_table:
+out_err:
 	unregister_net_sysctl_table(net->ipv6.sysctl.route_hdr);
-out_unregister_ipv6_table:
 	unregister_net_sysctl_table(net->ipv6.sysctl.hdr);
-out_ipv6_icmp_table:
-	kfree(ipv6_icmp_table);
-out_ipv6_route_table:
-	kfree(ipv6_route_table);
-out_ipv6_table:
-	kfree(ipv6_table);
 	goto out;
 }
 
 static void __net_exit ipv6_sysctl_net_exit(struct net *net)
 {
-	const struct ctl_table *ipv6_table;
-	const struct ctl_table *ipv6_route_table;
-	const struct ctl_table *ipv6_icmp_table;
-
-	ipv6_table = net->ipv6.sysctl.hdr->ctl_table_arg;
-	ipv6_route_table = net->ipv6.sysctl.route_hdr->ctl_table_arg;
-	ipv6_icmp_table = net->ipv6.sysctl.icmp_hdr->ctl_table_arg;
-
 	unregister_net_sysctl_table(net->ipv6.sysctl.icmp_hdr);
 	unregister_net_sysctl_table(net->ipv6.sysctl.route_hdr);
 	unregister_net_sysctl_table(net->ipv6.sysctl.hdr);
-
-	kfree(ipv6_table);
-	kfree(ipv6_route_table);
-	kfree(ipv6_icmp_table);
 }
 
 static struct pernet_operations ipv6_sysctl_net_ops = {
-- 
2.55.0

