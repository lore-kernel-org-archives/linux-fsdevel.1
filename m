Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356D47F78C;
	Wed, 26 Aug 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773467; cv=none; b=luomKb/tWyxEYobC1agJBUoAVLdkcmCzn3Kt1RtIHQVWahjXtyRIg/XY33xlkcrnhNw2PuRSuSU/w3m1cJmXUDUpEkOS/j/2bYZyOttyEpYmQliWSX7FnGtDS8CCmuObSIQD9KNsCpWaTyOg3oiwlR9nc/mGe9JD74uf9LZqoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773467; c=relaxed/simple;
	bh=+G0N8gxtGfNxoEqDMjsjg5i3bgeBQMZv8vnZtnrkkIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L50jrbP7PJlUKmDUzdO61Ls/roF07WwNZ4JV7/IsEiwl5Zb0CjGF8ygLRejqJ/fb+evwMqiXUmznbHtY8YlAw+kZmQck9OhBEYokwpU34h0WDaVLRHgqZqGRaj57Xw/7IztThg8lFNUVIHQh1UX/W1FCkxaDWd9MuImmHwfzaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4Z6wtOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4Z6wtOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC8C1F00AC4;
	Wed, 26 Aug 2026 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773448;
	bh=3MfDszGBIPAp/GXxgUuPpfpih9wSgrGqjjUqdzTJxNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4Z6wtOfol19WxEE+MEuJfJYM22V7+xQH7WbBzz3K60oy1HG/XPEz1+8A/Gq16S2V
	 Id0VJ5ooqTy9bB1IGcKoaoIoKEU99vvpXWpVbYa+uLfh5kveKBjppxVivLyzn3F9Jh
	 mopDgtYHt2ppRx1OazZgVzMpGtAlwbeVHMB7ux12mCms2jPTUCXag0GqpRBZgoS8at
	 S4YoSFrS57THnTRwuZSq3lR7h2xyJQQ0/W30jvBiqJ1KMKYF30jSv8YmIgZpSo/TjQ
	 FUOa+VG6BZxxVfL0J27HdWXRFmNh/J2aJHAeZ77oftUILZzX3ZGpUfE3tH7c3SMSBm
	 Lzb3CN+etllNA==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 28/30] sysctl: net: use sysctl_field in IPv6 devconf sysctls
Date: Wed, 26 Aug 2026 21:42:32 +0200
Message-ID: <d9eccfb2bc575ed0ae81e5a5354ede799f46605e.1787771905.git.legion@kernel.org>
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

IPv6 devconf allocates a private sysctl table for each registered
devconf only so registration can rewrite data pointers and attach the
matching inet6_dev and net namespace through extra1 and extra2.

Use sysctl_field with an IPv6 devconf registration context instead. The
table descriptors can stay static and const, while custom handlers still
see the same data, extra1 and extra2 values they used before.

This removes the per-devconf sysctl table clone and the matching
unregister side free.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ipv6/addrconf.c | 746 +++++++++++++++-----------------------------
 1 file changed, 252 insertions(+), 494 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..a3bac460e7bd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6826,516 +6826,280 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 }
 
 static int minus_one = -1;
-static const int two_five_five = 255;
+static int two_five_five = 255;
 static u32 ioam6_if_id_max = U16_MAX;
 
-static const struct ctl_table addrconf_sysctl[] = {
-	{
-		.procname	= "forwarding",
-		.data		= &ipv6_devconf.forwarding,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_forward,
-	},
-	{
-		.procname	= "hop_limit",
-		.data		= &ipv6_devconf.hop_limit,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&two_five_five,
-	},
-	{
-		.procname	= "mtu",
-		.data		= &ipv6_devconf.mtu6,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_mtu,
-	},
-	{
-		.procname	= "accept_ra",
-		.data		= &ipv6_devconf.accept_ra,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "accept_redirects",
-		.data		= &ipv6_devconf.accept_redirects,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "autoconf",
-		.data		= &ipv6_devconf.autoconf,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "dad_transmits",
-		.data		= &ipv6_devconf.dad_transmits,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "router_solicitations",
-		.data		= &ipv6_devconf.rtr_solicits,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minus_one,
-	},
-	{
-		.procname	= "router_solicitation_interval",
-		.data		= &ipv6_devconf.rtr_solicit_interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "router_solicitation_max_interval",
-		.data		= &ipv6_devconf.rtr_solicit_max_interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "router_solicitation_delay",
-		.data		= &ipv6_devconf.rtr_solicit_delay,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "force_mld_version",
-		.data		= &ipv6_devconf.force_mld_version,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "mldv1_unsolicited_report_interval",
-		.data		=
-			&ipv6_devconf.mldv1_unsolicited_report_interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "mldv2_unsolicited_report_interval",
-		.data		=
-			&ipv6_devconf.mldv2_unsolicited_report_interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "use_tempaddr",
-		.data		= &ipv6_devconf.use_tempaddr,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "temp_valid_lft",
-		.data		= &ipv6_devconf.temp_valid_lft,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "temp_prefered_lft",
-		.data		= &ipv6_devconf.temp_prefered_lft,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname       = "regen_min_advance",
-		.data           = &ipv6_devconf.regen_min_advance,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-	{
-		.procname	= "regen_max_retry",
-		.data		= &ipv6_devconf.regen_max_retry,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "max_desync_factor",
-		.data		= &ipv6_devconf.max_desync_factor,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "max_addresses",
-		.data		= &ipv6_devconf.max_addresses,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "accept_ra_defrtr",
-		.data		= &ipv6_devconf.accept_ra_defrtr,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "ra_defrtr_metric",
-		.data		= &ipv6_devconf.ra_defrtr_metric,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-	},
-	{
-		.procname	= "accept_ra_min_hop_limit",
-		.data		= &ipv6_devconf.accept_ra_min_hop_limit,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "accept_ra_min_lft",
-		.data		= &ipv6_devconf.accept_ra_min_lft,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "accept_ra_pinfo",
-		.data		= &ipv6_devconf.accept_ra_pinfo,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "ra_honor_pio_life",
-		.data		= &ipv6_devconf.ra_honor_pio_life,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "ra_honor_pio_pflag",
-		.data		= &ipv6_devconf.ra_honor_pio_pflag,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+struct addrconf_ctl_context {
+	struct sysctl_context context;
+	struct ipv6_devconf *devconf;
+};
+
+#define ADDRCONF_DATA(type, field)						\
+static type *addrconf_ ## field ## _data(const struct sysctl_context *ctx)	\
+{										\
+	const struct addrconf_ctl_context *addrconf_ctx =			\
+		container_of(ctx, struct addrconf_ctl_context, context);	\
+	return &addrconf_ctx->devconf->field;					\
+}
+
+static void *addrconf_idev_data(const struct sysctl_context *ctx)
+{
+	const struct addrconf_ctl_context *addrconf_ctx =
+		container_of(ctx, struct addrconf_ctl_context, context);
+	struct ipv6_devconf *cnf = addrconf_ctx->devconf;
+	struct net *net = ctx->ns.net_ns;
+
+	if (cnf == net->ipv6.devconf_all || cnf == net->ipv6.devconf_dflt)
+		return NULL;
+
+	return container_of(cnf, struct inet6_dev, cnf);
+}
+
+static void *addrconf_net_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+#define ADDRCONF_CUSTOM_ENTRY(field, name, mval, len, proc)		\
+	{								\
+		.procname	= name,					\
+		.mode		= mval,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= proc,				\
+			.data		= addrconf_ ## field ## _data,	\
+			.extra1		= addrconf_idev_data,		\
+			.extra2		= addrconf_net_data,		\
+			.maxlen		= len,				\
+		},							\
+	}
+
+#define ADDRCONF_INT_ENTRY(field, name) \
+	SYSCTL_FIELD_INT(name, 0644, addrconf_ ## field ## _data)
+
+#define ADDRCONF_INT_RO_ENTRY(field, name) \
+	SYSCTL_FIELD_INT(name, 0444, addrconf_ ## field ## _data)
+
+#define ADDRCONF_INT_MINMAX_ENTRY(field, name, min, max) \
+	SYSCTL_FIELD_STATIC_INT_MINMAX(name, 0644, \
+				       addrconf_ ## field ## _data, min, max)
+
+#define ADDRCONF_UINT_ENTRY(field, name) \
+	SYSCTL_FIELD_UINT(name, 0644, addrconf_ ## field ## _data)
+
+#define ADDRCONF_UINT_MINMAX_ENTRY(field, name, min, max) \
+	SYSCTL_FIELD_STATIC_UINT_MINMAX(name, 0644, \
+				        addrconf_ ## field ## _data, min, max)
+
+#define ADDRCONF_U8_MINMAX_ENTRY(field, name, min, max) \
+	SYSCTL_FIELD_STATIC_U8_MINMAX(name, 0644, \
+				      addrconf_ ## field ## _data, min, max)
+
+ADDRCONF_DATA(void, forwarding)
+ADDRCONF_DATA(int, hop_limit)
+ADDRCONF_DATA(void, mtu6)
+ADDRCONF_DATA(int, accept_ra)
+ADDRCONF_DATA(int, accept_redirects)
+ADDRCONF_DATA(int, autoconf)
+ADDRCONF_DATA(int, dad_transmits)
+ADDRCONF_DATA(int, rtr_solicits)
+ADDRCONF_DATA(void, rtr_solicit_interval)
+ADDRCONF_DATA(void, rtr_solicit_max_interval)
+ADDRCONF_DATA(void, rtr_solicit_delay)
+ADDRCONF_DATA(int, force_mld_version)
+ADDRCONF_DATA(void, mldv1_unsolicited_report_interval)
+ADDRCONF_DATA(void, mldv2_unsolicited_report_interval)
+ADDRCONF_DATA(int, use_tempaddr)
+ADDRCONF_DATA(int, temp_valid_lft)
+ADDRCONF_DATA(int, temp_prefered_lft)
+ADDRCONF_DATA(int, regen_min_advance)
+ADDRCONF_DATA(int, regen_max_retry)
+ADDRCONF_DATA(int, max_desync_factor)
+ADDRCONF_DATA(int, max_addresses)
+ADDRCONF_DATA(int, accept_ra_defrtr)
+ADDRCONF_DATA(unsigned int, ra_defrtr_metric)
+ADDRCONF_DATA(int, accept_ra_min_hop_limit)
+ADDRCONF_DATA(int, accept_ra_min_lft)
+ADDRCONF_DATA(int, accept_ra_pinfo)
+ADDRCONF_DATA(u8, ra_honor_pio_life)
+ADDRCONF_DATA(u8, ra_honor_pio_pflag)
 #ifdef CONFIG_IPV6_ROUTER_PREF
-	{
-		.procname	= "accept_ra_rtr_pref",
-		.data		= &ipv6_devconf.accept_ra_rtr_pref,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "router_probe_interval",
-		.data		= &ipv6_devconf.rtr_probe_interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+ADDRCONF_DATA(int, accept_ra_rtr_pref)
+ADDRCONF_DATA(void, rtr_probe_interval)
 #ifdef CONFIG_IPV6_ROUTE_INFO
-	{
-		.procname	= "accept_ra_rt_info_min_plen",
-		.data		= &ipv6_devconf.accept_ra_rt_info_min_plen,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "accept_ra_rt_info_max_plen",
-		.data		= &ipv6_devconf.accept_ra_rt_info_max_plen,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
+ADDRCONF_DATA(int, accept_ra_rt_info_min_plen)
+ADDRCONF_DATA(int, accept_ra_rt_info_max_plen)
 #endif
 #endif
-	{
-		.procname	= "proxy_ndp",
-		.data		= &ipv6_devconf.proxy_ndp,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_proxy_ndp,
-	},
-	{
-		.procname	= "accept_source_route",
-		.data		= &ipv6_devconf.accept_source_route,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
+ADDRCONF_DATA(void, proxy_ndp)
+ADDRCONF_DATA(int, accept_source_route)
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-	{
-		.procname	= "optimistic_dad",
-		.data		= &ipv6_devconf.optimistic_dad,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler   = proc_dointvec,
-	},
-	{
-		.procname	= "use_optimistic",
-		.data		= &ipv6_devconf.use_optimistic,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
+ADDRCONF_DATA(int, optimistic_dad)
+ADDRCONF_DATA(int, use_optimistic)
 #endif
 #ifdef CONFIG_IPV6_MROUTE
-	{
-		.procname	= "mc_forwarding",
-		.data		= &ipv6_devconf.mc_forwarding,
-		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
+ADDRCONF_DATA(void, mc_forwarding)
 #endif
-	{
-		.procname	= "disable_ipv6",
-		.data		= &ipv6_devconf.disable_ipv6,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_disable,
-	},
-	{
-		.procname	= "accept_dad",
-		.data		= &ipv6_devconf.accept_dad,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "force_tllao",
-		.data		= &ipv6_devconf.force_tllao,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "ndisc_notify",
-		.data		= &ipv6_devconf.ndisc_notify,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "suppress_frag_ndisc",
-		.data		= &ipv6_devconf.suppress_frag_ndisc,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "accept_ra_from_local",
-		.data		= &ipv6_devconf.accept_ra_from_local,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "accept_ra_mtu",
-		.data		= &ipv6_devconf.accept_ra_mtu,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "stable_secret",
-		.data		= &ipv6_devconf.stable_secret,
-		.maxlen		= IPV6_MAX_STRLEN,
-		.mode		= 0600,
-		.proc_handler	= addrconf_sysctl_stable_secret,
-	},
-	{
-		.procname	= "use_oif_addrs_only",
-		.data		= &ipv6_devconf.use_oif_addrs_only,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "ignore_routes_with_linkdown",
-		.data		= &ipv6_devconf.ignore_routes_with_linkdown,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_ignore_routes_with_linkdown,
-	},
-	{
-		.procname	= "drop_unicast_in_l2_multicast",
-		.data		= &ipv6_devconf.drop_unicast_in_l2_multicast,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "drop_unsolicited_na",
-		.data		= &ipv6_devconf.drop_unsolicited_na,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "keep_addr_on_down",
-		.data		= &ipv6_devconf.keep_addr_on_down,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-
-	},
-	{
-		.procname	= "seg6_enabled",
-		.data		= &ipv6_devconf.seg6_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
+ADDRCONF_DATA(void, disable_ipv6)
+ADDRCONF_DATA(int, accept_dad)
+ADDRCONF_DATA(int, force_tllao)
+ADDRCONF_DATA(int, ndisc_notify)
+ADDRCONF_DATA(int, suppress_frag_ndisc)
+ADDRCONF_DATA(int, accept_ra_from_local)
+ADDRCONF_DATA(int, accept_ra_mtu)
+ADDRCONF_DATA(void, stable_secret)
+ADDRCONF_DATA(int, use_oif_addrs_only)
+ADDRCONF_DATA(void, ignore_routes_with_linkdown)
+ADDRCONF_DATA(int, drop_unicast_in_l2_multicast)
+ADDRCONF_DATA(int, drop_unsolicited_na)
+ADDRCONF_DATA(int, keep_addr_on_down)
+ADDRCONF_DATA(int, seg6_enabled)
 #ifdef CONFIG_IPV6_SEG6_HMAC
-	{
-		.procname	= "seg6_require_hmac",
-		.data		= &ipv6_devconf.seg6_require_hmac,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
+ADDRCONF_DATA(int, seg6_require_hmac)
 #endif
-	{
-		.procname       = "enhanced_dad",
-		.data           = &ipv6_devconf.enhanced_dad,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-	{
-		.procname	= "addr_gen_mode",
-		.data		= &ipv6_devconf.addr_gen_mode,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_addr_gen_mode,
-	},
-	{
-		.procname       = "disable_policy",
-		.data           = &ipv6_devconf.disable_policy,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = addrconf_sysctl_disable_policy,
-	},
-	{
-		.procname	= "ndisc_tclass",
-		.data		= &ipv6_devconf.ndisc_tclass,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)&two_five_five,
-	},
-	{
-		.procname	= "rpl_seg_enabled",
-		.data		= &ipv6_devconf.rpl_seg_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-	{
-		.procname	= "ioam6_enabled",
-		.data		= &ipv6_devconf.ioam6_enabled,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)SYSCTL_ONE,
-	},
-	{
-		.procname	= "ioam6_id",
-		.data		= &ipv6_devconf.ioam6_id,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)&ioam6_if_id_max,
-	},
-	{
-		.procname	= "ioam6_id_wide",
-		.data		= &ipv6_devconf.ioam6_id_wide,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec,
-	},
-	{
-		.procname	= "ndisc_evict_nocarrier",
-		.data		= &ipv6_devconf.ndisc_evict_nocarrier,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)SYSCTL_ONE,
-	},
-	{
-		.procname	= "accept_untracked_na",
-		.data		= &ipv6_devconf.accept_untracked_na,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "force_forwarding",
-		.data		= &ipv6_devconf.force_forwarding,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= addrconf_sysctl_force_forwarding,
-	},
+ADDRCONF_DATA(void, enhanced_dad)
+ADDRCONF_DATA(void, addr_gen_mode)
+ADDRCONF_DATA(void, disable_policy)
+ADDRCONF_DATA(int, ndisc_tclass)
+ADDRCONF_DATA(int, rpl_seg_enabled)
+ADDRCONF_DATA(u8, ioam6_enabled)
+ADDRCONF_DATA(unsigned int, ioam6_id)
+ADDRCONF_DATA(unsigned int, ioam6_id_wide)
+ADDRCONF_DATA(u8, ndisc_evict_nocarrier)
+ADDRCONF_DATA(int, accept_untracked_na)
+ADDRCONF_DATA(void, force_forwarding)
+
+static const struct sysctl_field addrconf_sysctl[] = {
+	ADDRCONF_CUSTOM_ENTRY(forwarding, "forwarding", 0644, sizeof(int),
+			      addrconf_sysctl_forward),
+	ADDRCONF_INT_MINMAX_ENTRY(hop_limit, "hop_limit", SYSCTL_ONE,
+				  &two_five_five),
+	ADDRCONF_CUSTOM_ENTRY(mtu6, "mtu", 0644, sizeof(int),
+			      addrconf_sysctl_mtu),
+	ADDRCONF_INT_ENTRY(accept_ra, "accept_ra"),
+	ADDRCONF_INT_ENTRY(accept_redirects, "accept_redirects"),
+	ADDRCONF_INT_ENTRY(autoconf, "autoconf"),
+	ADDRCONF_INT_ENTRY(dad_transmits, "dad_transmits"),
+	ADDRCONF_INT_MINMAX_ENTRY(rtr_solicits, "router_solicitations",
+				  &minus_one, NULL),
+	ADDRCONF_CUSTOM_ENTRY(rtr_solicit_interval,
+			      "router_solicitation_interval", 0644,
+			      sizeof(int), proc_dointvec_jiffies),
+	ADDRCONF_CUSTOM_ENTRY(rtr_solicit_max_interval,
+			      "router_solicitation_max_interval", 0644,
+			      sizeof(int), proc_dointvec_jiffies),
+	ADDRCONF_CUSTOM_ENTRY(rtr_solicit_delay,
+			      "router_solicitation_delay", 0644,
+			      sizeof(int), proc_dointvec_jiffies),
+	ADDRCONF_INT_ENTRY(force_mld_version, "force_mld_version"),
+	ADDRCONF_CUSTOM_ENTRY(mldv1_unsolicited_report_interval,
+			      "mldv1_unsolicited_report_interval", 0644,
+			      sizeof(int), proc_dointvec_ms_jiffies),
+	ADDRCONF_CUSTOM_ENTRY(mldv2_unsolicited_report_interval,
+			      "mldv2_unsolicited_report_interval", 0644,
+			      sizeof(int), proc_dointvec_ms_jiffies),
+	ADDRCONF_INT_ENTRY(use_tempaddr, "use_tempaddr"),
+	ADDRCONF_INT_ENTRY(temp_valid_lft, "temp_valid_lft"),
+	ADDRCONF_INT_ENTRY(temp_prefered_lft, "temp_prefered_lft"),
+	ADDRCONF_INT_ENTRY(regen_min_advance, "regen_min_advance"),
+	ADDRCONF_INT_ENTRY(regen_max_retry, "regen_max_retry"),
+	ADDRCONF_INT_ENTRY(max_desync_factor, "max_desync_factor"),
+	ADDRCONF_INT_ENTRY(max_addresses, "max_addresses"),
+	ADDRCONF_INT_ENTRY(accept_ra_defrtr, "accept_ra_defrtr"),
+	ADDRCONF_UINT_MINMAX_ENTRY(ra_defrtr_metric, "ra_defrtr_metric",
+				   SYSCTL_UINT_ONE, NULL),
+	ADDRCONF_INT_ENTRY(accept_ra_min_hop_limit,
+			 "accept_ra_min_hop_limit"),
+	ADDRCONF_INT_ENTRY(accept_ra_min_lft, "accept_ra_min_lft"),
+	ADDRCONF_INT_ENTRY(accept_ra_pinfo, "accept_ra_pinfo"),
+	ADDRCONF_U8_MINMAX_ENTRY(ra_honor_pio_life, "ra_honor_pio_life",
+				 SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	ADDRCONF_U8_MINMAX_ENTRY(ra_honor_pio_pflag, "ra_honor_pio_pflag",
+				 SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+#ifdef CONFIG_IPV6_ROUTER_PREF
+	ADDRCONF_INT_ENTRY(accept_ra_rtr_pref, "accept_ra_rtr_pref"),
+	ADDRCONF_CUSTOM_ENTRY(rtr_probe_interval, "router_probe_interval",
+			      0644, sizeof(int), proc_dointvec_jiffies),
+#ifdef CONFIG_IPV6_ROUTE_INFO
+	ADDRCONF_INT_ENTRY(accept_ra_rt_info_min_plen,
+			 "accept_ra_rt_info_min_plen"),
+	ADDRCONF_INT_ENTRY(accept_ra_rt_info_max_plen,
+			 "accept_ra_rt_info_max_plen"),
+#endif
+#endif
+	ADDRCONF_CUSTOM_ENTRY(proxy_ndp, "proxy_ndp", 0644, sizeof(int),
+			      addrconf_sysctl_proxy_ndp),
+	ADDRCONF_INT_ENTRY(accept_source_route, "accept_source_route"),
+#ifdef CONFIG_IPV6_OPTIMISTIC_DAD
+	ADDRCONF_INT_ENTRY(optimistic_dad, "optimistic_dad"),
+	ADDRCONF_INT_ENTRY(use_optimistic, "use_optimistic"),
+#endif
+#ifdef CONFIG_IPV6_MROUTE
+	ADDRCONF_CUSTOM_ENTRY(mc_forwarding, "mc_forwarding", 0444,
+			      sizeof(int), proc_dointvec),
+#endif
+	ADDRCONF_CUSTOM_ENTRY(disable_ipv6, "disable_ipv6", 0644,
+			      sizeof(int), addrconf_sysctl_disable),
+	ADDRCONF_INT_ENTRY(accept_dad, "accept_dad"),
+	ADDRCONF_INT_ENTRY(force_tllao, "force_tllao"),
+	ADDRCONF_INT_ENTRY(ndisc_notify, "ndisc_notify"),
+	ADDRCONF_INT_ENTRY(suppress_frag_ndisc, "suppress_frag_ndisc"),
+	ADDRCONF_INT_ENTRY(accept_ra_from_local, "accept_ra_from_local"),
+	ADDRCONF_INT_ENTRY(accept_ra_mtu, "accept_ra_mtu"),
+	ADDRCONF_CUSTOM_ENTRY(stable_secret, "stable_secret", 0600,
+			      IPV6_MAX_STRLEN, addrconf_sysctl_stable_secret),
+	ADDRCONF_INT_ENTRY(use_oif_addrs_only, "use_oif_addrs_only"),
+	ADDRCONF_CUSTOM_ENTRY(ignore_routes_with_linkdown,
+			      "ignore_routes_with_linkdown", 0644, sizeof(int),
+			      addrconf_sysctl_ignore_routes_with_linkdown),
+	ADDRCONF_INT_ENTRY(drop_unicast_in_l2_multicast,
+			 "drop_unicast_in_l2_multicast"),
+	ADDRCONF_INT_ENTRY(drop_unsolicited_na, "drop_unsolicited_na"),
+	ADDRCONF_INT_ENTRY(keep_addr_on_down, "keep_addr_on_down"),
+	ADDRCONF_INT_ENTRY(seg6_enabled, "seg6_enabled"),
+#ifdef CONFIG_IPV6_SEG6_HMAC
+	ADDRCONF_INT_ENTRY(seg6_require_hmac, "seg6_require_hmac"),
+#endif
+	ADDRCONF_CUSTOM_ENTRY(enhanced_dad, "enhanced_dad", 0644,
+			      sizeof(int), proc_dointvec),
+	ADDRCONF_CUSTOM_ENTRY(addr_gen_mode, "addr_gen_mode", 0644,
+			      sizeof(int), addrconf_sysctl_addr_gen_mode),
+	ADDRCONF_CUSTOM_ENTRY(disable_policy, "disable_policy", 0644,
+			      sizeof(int), addrconf_sysctl_disable_policy),
+	ADDRCONF_INT_MINMAX_ENTRY(ndisc_tclass, "ndisc_tclass",
+				  SYSCTL_ZERO, &two_five_five),
+	ADDRCONF_INT_MINMAX_ENTRY(rpl_seg_enabled, "rpl_seg_enabled",
+				  SYSCTL_ZERO, SYSCTL_ONE),
+	ADDRCONF_U8_MINMAX_ENTRY(ioam6_enabled, "ioam6_enabled",
+				 SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	ADDRCONF_UINT_MINMAX_ENTRY(ioam6_id, "ioam6_id",
+				   SYSCTL_UINT_ZERO, &ioam6_if_id_max),
+	ADDRCONF_UINT_ENTRY(ioam6_id_wide, "ioam6_id_wide"),
+	ADDRCONF_U8_MINMAX_ENTRY(ndisc_evict_nocarrier,
+				 "ndisc_evict_nocarrier", SYSCTL_UINT_ZERO,
+				 SYSCTL_UINT_ONE),
+	ADDRCONF_INT_MINMAX_ENTRY(accept_untracked_na, "accept_untracked_na",
+				  SYSCTL_ZERO, SYSCTL_TWO),
+	ADDRCONF_CUSTOM_ENTRY(force_forwarding, "force_forwarding", 0644,
+			      sizeof(int), addrconf_sysctl_force_forwarding),
 };
 
 static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 		struct inet6_dev *idev, struct ipv6_devconf *p)
 {
-	size_t table_size = ARRAY_SIZE(addrconf_sysctl);
-	int i, ifindex;
-	struct ctl_table *table;
+	struct addrconf_ctl_context ctx = {
+		.context.ns.net_ns = net,
+		.devconf = p,
+	};
+	int ifindex;
 	char path[sizeof("net/ipv6/conf/") + IFNAMSIZ];
 
-	table = kmemdup(addrconf_sysctl, sizeof(addrconf_sysctl), GFP_KERNEL_ACCOUNT);
-	if (!table)
-		goto out;
-
-	for (i = 0; i < table_size; i++) {
-		table[i].data += (char *)p - (char *)&ipv6_devconf;
-		/* If one of these is already set, then it is not safe to
-		 * overwrite either of them: this makes proc_dointvec_minmax
-		 * usable.
-		 */
-		if (!table[i].extra1 && !table[i].extra2) {
-			table[i].extra1 = idev; /* embedded; no ref */
-			table[i].extra2 = net;
-		}
-	}
-
 	snprintf(path, sizeof(path), "net/ipv6/conf/%s", dev_name);
 
-	p->sysctl_header = register_net_sysctl_sz(net, path, table,
-						  table_size);
+	p->sysctl_header = register_sysctl_fields_ctx(&net->sysctls, path,
+						      addrconf_sysctl, &ctx);
 	if (!p->sysctl_header)
-		goto free;
+		goto out;
 
 	if (!strcmp(dev_name, "all"))
 		ifindex = NETCONFA_IFINDEX_ALL;
@@ -7347,8 +7111,6 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 				     ifindex, p);
 	return 0;
 
-free:
-	kfree(table);
 out:
 	return -ENOBUFS;
 }
@@ -7356,15 +7118,11 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 static void __addrconf_sysctl_unregister(struct net *net,
 					 struct ipv6_devconf *p, int ifindex)
 {
-	const struct ctl_table *table;
-
 	if (!p->sysctl_header)
 		return;
 
-	table = p->sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(p->sysctl_header);
 	p->sysctl_header = NULL;
-	kfree(table);
 
 	inet6_netconf_notify_devconf(net, RTM_DELNETCONF, 0, ifindex, NULL);
 }
-- 
2.55.0

