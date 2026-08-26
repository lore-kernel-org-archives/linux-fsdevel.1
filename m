Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC57479861;
	Wed, 26 Aug 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773466; cv=none; b=eNB70cOfLx5a1H9RVHCmEN3n4YhMo9GB25rMPVsjn060rHn5XQZVai0asygGEdxWL3xQT8io9B1gZzCzFvR9PbIuDaUxAm0bI4KBpbwyj3isfsN0lG1haDxmHPdAQIHKEUBgu23lPyyte/tuys4Fzuoe6LX7iv20x7J+ssvV4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773466; c=relaxed/simple;
	bh=VOU67u7mEDsxx2aOB55kk3MnNKDJP7BakR1snktUOKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Flhfq1xCIYuuGnzfvuTjND7I5kS0bec4ZmDdA0k0sGDsnKgpoqhPbfEGHyYDo7LDDjbuZo/1EqxLJ65ArGExy0AAS0mswryeiCFYb0JfrVOH/gZr6yrJTCpVjeKW3uo/UDD4wOR7GLEiQsJqfCsRnwgIzfgcaYQOXf60MkUpJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNNeR9Ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNNeR9Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ADC1F01558;
	Wed, 26 Aug 2026 19:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773445;
	bh=fkdr6fVtQEltHyj6bFsRkPXhH4VQAzMSlpUVMgjeGLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNNeR9Icn0j3qZDDTTambabAsdK+mXB/mUGIO2NC8gL0tQLi/2/uLh8TL4vAYY5sz
	 +nZddlZGnZaVGf+MCamFXgqHF2/6gblSzVRLHGKwJ+TM0fqs6JraUPLmTrHH3C54jX
	 p6kvu9OVGtDfwvTu8Qzo5nncdVhCl6VP4UPJnW476TzZP3+NFuFOMGDDItnVtttQnU
	 uwio1xCzGctvzyAYOPVLGueCE2ihAMxklR5m6PKYI2Q/XBBOoHkQHhxOZMZzUqDLyb
	 PAtXj8YKF6l88CF2ptZc5gjjKVi57Iiuv+TJpk1qZxcbIOr8grX8oAMtDVfIdNHDcU
	 DB7ZubWpjtNKw==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 27/30] sysctl: net: use sysctl_field in IPv4 devconf sysctls
Date: Wed, 26 Aug 2026 21:42:31 +0200
Message-ID: <f09f0dec4c6958a9e9806040bbe07968c1a54adf.1787771905.git.legion@kernel.org>
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

IPv4 devconf clones its sysctl tables for each registered devconf so the
registration path can rewrite data pointers and attach the matching
network namespace through extra2. The copied tables then have to stay
alive until unregistration only so they can be freed.

Allow sysctl_field custom entries to derive extra1 and extra2 from the
registration context, and use that in devinet. This keeps the devconf
sysctl descriptors static and const while preserving the existing
handlers' view of data, extra1 and extra2.

The per-net ip_forward entry uses the same context path, so it no longer
needs a one-entry table copy either.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ipv4/devinet.c | 258 ++++++++++++++++++++++++---------------------
 1 file changed, 140 insertions(+), 118 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 58fe7cb69545..69b4b720a0e2 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2613,15 +2613,44 @@ static int ipv4_doint_and_flush(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
-#define DEVINET_SYSCTL_ENTRY(attr, name, mval, proc) \
-	{ \
-		.procname	= name, \
-		.data		= ipv4_devconf.data + \
-				  IPV4_DEVCONF_ ## attr - 1, \
-		.maxlen		= sizeof(int), \
-		.mode		= mval, \
-		.proc_handler	= proc, \
-		.extra1		= &ipv4_devconf, \
+struct devinet_ctl_context {
+	struct sysctl_context context;
+	struct ipv4_devconf *devconf;
+};
+
+#define DEVINET_DATA(attr)						\
+static void *devinet_ ## attr ## _data(const struct sysctl_context *ctx)	\
+{									\
+	const struct devinet_ctl_context *devinet_ctx =                 \
+		container_of(ctx, struct devinet_ctl_context, context); \
+	return &devinet_ctx->devconf->data[IPV4_DEVCONF_ ## attr - 1];  \
+}
+
+static void *devinet_conf_data(const struct sysctl_context *ctx)
+{
+	const struct devinet_ctl_context *devinet_ctx =
+		container_of(ctx, struct devinet_ctl_context, context);
+
+	return devinet_ctx->devconf;
+}
+
+static void *devinet_net_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+#define DEVINET_SYSCTL_ENTRY(attr, name, mval, proc)			\
+	{								\
+		.procname	= name,					\
+		.mode		= mval,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= proc,				\
+			.data		= devinet_ ## attr ## _data,	\
+			.extra1		= devinet_conf_data,		\
+			.extra2		= devinet_net_data,		\
+			.maxlen		= sizeof(int),			\
+		},							\
 	}
 
 #define DEVINET_SYSCTL_RW_ENTRY(attr, name) \
@@ -2636,104 +2665,118 @@ static int ipv4_doint_and_flush(const struct ctl_table *ctl, int write,
 #define DEVINET_SYSCTL_FLUSHING_ENTRY(attr, name) \
 	DEVINET_SYSCTL_COMPLEX_ENTRY(attr, name, ipv4_doint_and_flush)
 
-static struct devinet_sysctl_table {
-	struct ctl_table_header *sysctl_header;
-	struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
-} devinet_sysctl = {
-	.devinet_vars = {
-		DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
-					     devinet_sysctl_forward),
-		DEVINET_SYSCTL_RO_ENTRY(MC_FORWARDING, "mc_forwarding"),
-		DEVINET_SYSCTL_RW_ENTRY(BC_FORWARDING, "bc_forwarding"),
-
-		DEVINET_SYSCTL_RW_ENTRY(ACCEPT_REDIRECTS, "accept_redirects"),
-		DEVINET_SYSCTL_RW_ENTRY(SECURE_REDIRECTS, "secure_redirects"),
-		DEVINET_SYSCTL_RW_ENTRY(SHARED_MEDIA, "shared_media"),
-		DEVINET_SYSCTL_RW_ENTRY(RP_FILTER, "rp_filter"),
-		DEVINET_SYSCTL_RW_ENTRY(SEND_REDIRECTS, "send_redirects"),
-		DEVINET_SYSCTL_RW_ENTRY(ACCEPT_SOURCE_ROUTE,
-					"accept_source_route"),
-		DEVINET_SYSCTL_RW_ENTRY(ACCEPT_LOCAL, "accept_local"),
-		DEVINET_SYSCTL_RW_ENTRY(SRC_VMARK, "src_valid_mark"),
-		DEVINET_SYSCTL_RW_ENTRY(PROXY_ARP, "proxy_arp"),
-		DEVINET_SYSCTL_RW_ENTRY(MEDIUM_ID, "medium_id"),
-		DEVINET_SYSCTL_RW_ENTRY(BOOTP_RELAY, "bootp_relay"),
-		DEVINET_SYSCTL_RW_ENTRY(LOG_MARTIANS, "log_martians"),
-		DEVINET_SYSCTL_RW_ENTRY(TAG, "tag"),
-		DEVINET_SYSCTL_RW_ENTRY(ARPFILTER, "arp_filter"),
-		DEVINET_SYSCTL_RW_ENTRY(ARP_ANNOUNCE, "arp_announce"),
-		DEVINET_SYSCTL_RW_ENTRY(ARP_IGNORE, "arp_ignore"),
-		DEVINET_SYSCTL_RW_ENTRY(ARP_ACCEPT, "arp_accept"),
-		DEVINET_SYSCTL_RW_ENTRY(ARP_NOTIFY, "arp_notify"),
-		DEVINET_SYSCTL_RW_ENTRY(ARP_EVICT_NOCARRIER,
-					"arp_evict_nocarrier"),
-		DEVINET_SYSCTL_RW_ENTRY(PROXY_ARP_PVLAN, "proxy_arp_pvlan"),
-		DEVINET_SYSCTL_RW_ENTRY(FORCE_IGMP_VERSION,
-					"force_igmp_version"),
-		DEVINET_SYSCTL_RW_ENTRY(IGMPV2_UNSOLICITED_REPORT_INTERVAL,
-					"igmpv2_unsolicited_report_interval"),
-		DEVINET_SYSCTL_RW_ENTRY(IGMPV3_UNSOLICITED_REPORT_INTERVAL,
-					"igmpv3_unsolicited_report_interval"),
-		DEVINET_SYSCTL_RW_ENTRY(IGNORE_ROUTES_WITH_LINKDOWN,
-					"ignore_routes_with_linkdown"),
-		DEVINET_SYSCTL_RW_ENTRY(DROP_GRATUITOUS_ARP,
-					"drop_gratuitous_arp"),
-
-		DEVINET_SYSCTL_FLUSHING_ENTRY(NOXFRM, "disable_xfrm"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(NOPOLICY, "disable_policy"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(PROMOTE_SECONDARIES,
-					      "promote_secondaries"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(ROUTE_LOCALNET,
-					      "route_localnet"),
-		DEVINET_SYSCTL_FLUSHING_ENTRY(DROP_UNICAST_IN_L2_MULTICAST,
-					      "drop_unicast_in_l2_multicast"),
-	},
+DEVINET_DATA(FORWARDING)
+DEVINET_DATA(MC_FORWARDING)
+DEVINET_DATA(BC_FORWARDING)
+DEVINET_DATA(ACCEPT_REDIRECTS)
+DEVINET_DATA(SECURE_REDIRECTS)
+DEVINET_DATA(SHARED_MEDIA)
+DEVINET_DATA(RP_FILTER)
+DEVINET_DATA(SEND_REDIRECTS)
+DEVINET_DATA(ACCEPT_SOURCE_ROUTE)
+DEVINET_DATA(ACCEPT_LOCAL)
+DEVINET_DATA(SRC_VMARK)
+DEVINET_DATA(PROXY_ARP)
+DEVINET_DATA(MEDIUM_ID)
+DEVINET_DATA(BOOTP_RELAY)
+DEVINET_DATA(LOG_MARTIANS)
+DEVINET_DATA(TAG)
+DEVINET_DATA(ARPFILTER)
+DEVINET_DATA(ARP_ANNOUNCE)
+DEVINET_DATA(ARP_IGNORE)
+DEVINET_DATA(ARP_ACCEPT)
+DEVINET_DATA(ARP_NOTIFY)
+DEVINET_DATA(ARP_EVICT_NOCARRIER)
+DEVINET_DATA(PROXY_ARP_PVLAN)
+DEVINET_DATA(FORCE_IGMP_VERSION)
+DEVINET_DATA(IGMPV2_UNSOLICITED_REPORT_INTERVAL)
+DEVINET_DATA(IGMPV3_UNSOLICITED_REPORT_INTERVAL)
+DEVINET_DATA(IGNORE_ROUTES_WITH_LINKDOWN)
+DEVINET_DATA(DROP_GRATUITOUS_ARP)
+DEVINET_DATA(NOXFRM)
+DEVINET_DATA(NOPOLICY)
+DEVINET_DATA(PROMOTE_SECONDARIES)
+DEVINET_DATA(ROUTE_LOCALNET)
+DEVINET_DATA(DROP_UNICAST_IN_L2_MULTICAST)
+
+static const struct sysctl_field devinet_sysctls[] = {
+	DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
+				     devinet_sysctl_forward),
+	DEVINET_SYSCTL_RO_ENTRY(MC_FORWARDING, "mc_forwarding"),
+	DEVINET_SYSCTL_RW_ENTRY(BC_FORWARDING, "bc_forwarding"),
+	DEVINET_SYSCTL_RW_ENTRY(ACCEPT_REDIRECTS, "accept_redirects"),
+	DEVINET_SYSCTL_RW_ENTRY(SECURE_REDIRECTS, "secure_redirects"),
+	DEVINET_SYSCTL_RW_ENTRY(SHARED_MEDIA, "shared_media"),
+	DEVINET_SYSCTL_RW_ENTRY(RP_FILTER, "rp_filter"),
+	DEVINET_SYSCTL_RW_ENTRY(SEND_REDIRECTS, "send_redirects"),
+	DEVINET_SYSCTL_RW_ENTRY(ACCEPT_SOURCE_ROUTE,
+				"accept_source_route"),
+	DEVINET_SYSCTL_RW_ENTRY(ACCEPT_LOCAL, "accept_local"),
+	DEVINET_SYSCTL_RW_ENTRY(SRC_VMARK, "src_valid_mark"),
+	DEVINET_SYSCTL_RW_ENTRY(PROXY_ARP, "proxy_arp"),
+	DEVINET_SYSCTL_RW_ENTRY(MEDIUM_ID, "medium_id"),
+	DEVINET_SYSCTL_RW_ENTRY(BOOTP_RELAY, "bootp_relay"),
+	DEVINET_SYSCTL_RW_ENTRY(LOG_MARTIANS, "log_martians"),
+	DEVINET_SYSCTL_RW_ENTRY(TAG, "tag"),
+	DEVINET_SYSCTL_RW_ENTRY(ARPFILTER, "arp_filter"),
+	DEVINET_SYSCTL_RW_ENTRY(ARP_ANNOUNCE, "arp_announce"),
+	DEVINET_SYSCTL_RW_ENTRY(ARP_IGNORE, "arp_ignore"),
+	DEVINET_SYSCTL_RW_ENTRY(ARP_ACCEPT, "arp_accept"),
+	DEVINET_SYSCTL_RW_ENTRY(ARP_NOTIFY, "arp_notify"),
+	DEVINET_SYSCTL_RW_ENTRY(ARP_EVICT_NOCARRIER,
+				"arp_evict_nocarrier"),
+	DEVINET_SYSCTL_RW_ENTRY(PROXY_ARP_PVLAN, "proxy_arp_pvlan"),
+	DEVINET_SYSCTL_RW_ENTRY(FORCE_IGMP_VERSION,
+				"force_igmp_version"),
+	DEVINET_SYSCTL_RW_ENTRY(IGMPV2_UNSOLICITED_REPORT_INTERVAL,
+				"igmpv2_unsolicited_report_interval"),
+	DEVINET_SYSCTL_RW_ENTRY(IGMPV3_UNSOLICITED_REPORT_INTERVAL,
+				"igmpv3_unsolicited_report_interval"),
+	DEVINET_SYSCTL_RW_ENTRY(IGNORE_ROUTES_WITH_LINKDOWN,
+				"ignore_routes_with_linkdown"),
+	DEVINET_SYSCTL_RW_ENTRY(DROP_GRATUITOUS_ARP,
+				"drop_gratuitous_arp"),
+	DEVINET_SYSCTL_FLUSHING_ENTRY(NOXFRM, "disable_xfrm"),
+	DEVINET_SYSCTL_FLUSHING_ENTRY(NOPOLICY, "disable_policy"),
+	DEVINET_SYSCTL_FLUSHING_ENTRY(PROMOTE_SECONDARIES,
+				      "promote_secondaries"),
+	DEVINET_SYSCTL_FLUSHING_ENTRY(ROUTE_LOCALNET,
+				      "route_localnet"),
+	DEVINET_SYSCTL_FLUSHING_ENTRY(DROP_UNICAST_IN_L2_MULTICAST,
+				      "drop_unicast_in_l2_multicast"),
 };
 
 static int __devinet_sysctl_register(struct net *net, char *dev_name,
 				     int ifindex, struct ipv4_devconf *p)
 {
-	int i;
-	struct devinet_sysctl_table *t;
+	struct ctl_table_header *hdr;
+	struct devinet_ctl_context ctx = {
+		.context.ns.net_ns = net,
+		.devconf = p,
+	};
 	char path[sizeof("net/ipv4/conf/") + IFNAMSIZ];
 
-	t = kmemdup(&devinet_sysctl, sizeof(*t), GFP_KERNEL_ACCOUNT);
-	if (!t)
-		goto out;
-
-	for (i = 0; i < ARRAY_SIZE(t->devinet_vars); i++) {
-		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
-		t->devinet_vars[i].extra1 = p;
-		t->devinet_vars[i].extra2 = net;
-	}
-
 	snprintf(path, sizeof(path), "net/ipv4/conf/%s", dev_name);
 
-	t->sysctl_header = register_net_sysctl(net, path, t->devinet_vars);
-	if (!t->sysctl_header)
-		goto free;
+	hdr = register_sysctl_fields_ctx(&net->sysctls, path, devinet_sysctls, &ctx);
+	if (!hdr)
+		return -ENOMEM;
 
-	p->sysctl = t;
+	p->sysctl = hdr;
 
 	inet_netconf_notify_devconf(net, RTM_NEWNETCONF, NETCONFA_ALL,
 				    ifindex, p);
 	return 0;
-
-free:
-	kfree(t);
-out:
-	return -ENOMEM;
 }
 
 static void __devinet_sysctl_unregister(struct net *net,
 					struct ipv4_devconf *cnf, int ifindex)
 {
-	struct devinet_sysctl_table *t = cnf->sysctl;
+	struct ctl_table_header *hdr = cnf->sysctl;
 
-	if (t) {
+	if (hdr) {
 		cnf->sysctl = NULL;
-		unregister_net_sysctl_table(t->sysctl_header);
-		kfree(t);
+		unregister_net_sysctl_table(hdr);
 	}
 
 	inet_netconf_notify_devconf(net, RTM_DELNETCONF, 0, ifindex, NULL);
@@ -2764,17 +2807,9 @@ static void devinet_sysctl_unregister(struct in_device *idev)
 	neigh_sysctl_unregister(idev->arp_parms);
 }
 
-static struct ctl_table ctl_forward_entry[] = {
-	{
-		.procname	= "ip_forward",
-		.data		= &ipv4_devconf.data[
-					IPV4_DEVCONF_FORWARDING - 1],
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= devinet_sysctl_forward,
-		.extra1		= &ipv4_devconf,
-		.extra2		= &init_net,
-	},
+static const struct sysctl_field ctl_forward_entry[] = {
+	DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "ip_forward",
+				     devinet_sysctl_forward),
 };
 #endif
 
@@ -2782,7 +2817,7 @@ static __net_init int devinet_init_net(struct net *net)
 {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *forw_hdr;
-	struct ctl_table *tbl;
+	struct devinet_ctl_context forw_ctx;
 #endif
 	struct ipv4_devconf *all, *dflt;
 	int err;
@@ -2802,16 +2837,6 @@ static __net_init int devinet_init_net(struct net *net)
 	if (!dflt)
 		goto err_alloc_dflt;
 
-#ifdef CONFIG_SYSCTL
-	tbl = kmemdup(ctl_forward_entry, sizeof(ctl_forward_entry), GFP_KERNEL);
-	if (!tbl)
-		goto err_alloc_ctl;
-
-	tbl[0].data = &all->data[IPV4_DEVCONF_FORWARDING - 1];
-	tbl[0].extra1 = all;
-	tbl[0].extra2 = net;
-#endif
-
 	if (!net_eq(net, &init_net)) {
 		switch (net_inherit_devconf()) {
 		case 3:
@@ -2847,10 +2872,15 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_reg_dflt;
 
 	err = -ENOMEM;
-	forw_hdr = register_net_sysctl_sz(net, "net/ipv4", tbl,
-					  ARRAY_SIZE(ctl_forward_entry));
+	forw_ctx = (struct devinet_ctl_context) {
+		.context.ns.net_ns = net,
+		.devconf = all,
+	};
+	forw_hdr = register_sysctl_fields_ctx(&net->sysctls, "net/ipv4",
+					      ctl_forward_entry, &forw_ctx);
 	if (!forw_hdr)
 		goto err_reg_ctl;
+
 	net->ipv4.forw_hdr = forw_hdr;
 #endif
 
@@ -2869,8 +2899,6 @@ static __net_init int devinet_init_net(struct net *net)
 err_reg_dflt:
 	__devinet_sysctl_unregister(net, all, NETCONFA_IFINDEX_ALL);
 err_reg_all:
-	kfree(tbl);
-err_alloc_ctl:
 #endif
 	kfree(dflt);
 err_alloc_dflt:
@@ -2883,20 +2911,14 @@ static __net_init int devinet_init_net(struct net *net)
 
 static __net_exit void devinet_exit_net(struct net *net)
 {
-#ifdef CONFIG_SYSCTL
-	const struct ctl_table *tbl;
-#endif
-
 	cancel_delayed_work_sync(&net->ipv4.addr_chk_work);
 
 #ifdef CONFIG_SYSCTL
-	tbl = net->ipv4.forw_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.forw_hdr);
 	__devinet_sysctl_unregister(net, net->ipv4.devconf_dflt,
 				    NETCONFA_IFINDEX_DEFAULT);
 	__devinet_sysctl_unregister(net, net->ipv4.devconf_all,
 				    NETCONFA_IFINDEX_ALL);
-	kfree(tbl);
 #endif
 	kfree(net->ipv4.devconf_dflt);
 	kfree(net->ipv4.devconf_all);
-- 
2.55.0

