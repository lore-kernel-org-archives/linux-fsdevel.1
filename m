Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845292;
	b=4/tKMwj8i9uYwvaIIyKn/IHWWLLPwur6aqmBXMgzW6CAHnYFeX2zA9EmQgpLo/xPY1CP
	 a3JHZnZYr2/JlQl+1UzqhpQxrHAb6MRJx3IacoyxTap4HYE3BqLHiyWm1MhYaW1BL9VIN
	 7yAc8L1RKv93eZo52GPFLa2/pbpKvgzTUptQsyEueJ0cT/+6bGwKwjH5FkRy+QqPGQdEx
	 oUKyfYuSoH5nXt9wkNOSVrN47QL+keqSsr6UBvbyIJVnGnBKJinB9t/2SNa7kx03H+jnw
	 +16HDj1zKIz37qTrfsFwmEwLtcBx6Agu2GHt10UkNcA+q6djwofm9Bl1W5vI6PvEMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845292;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i0PBsS7DlLuO05B4QOzG3Kcg+NIdoKBsITJNAsNJR20=;
	b=kb4oKHjUFLooztLAsb10ij5R0zS1ibR0wUfOx5beNIyE+EUL6rm4by/fCk7plhwhau+p
	 9Eg3CbcGnTVl1q7cquqUQloqbuWyjzBNW2GXXCI0b5tZim90VzMIcGRcI7GEkhTHy2QDa
	 OtEG+dBvwKzSzJPaL+d1TTfbqfJBh0eJO5mAcvNRG5yUHSiE8uJuEM30GCRf1lWq9RuHJ
	 qEqDwTKS+PMQburflSEo2xoEMNx++KumneAeuz39Af7jv/CkZa5My+kt46dgepuCoMyYE
	 vKBdkfbXZQPcXt8T8MhkPZMSj21MoBNHVziiUvbsg73P6SHvhQXLa17ldai/Dya9o+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bjd9a8vA;
	arc=none smtp.remote-ip=95.215.58.179
Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E913606A334
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E913606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bjd9a8vA
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NmH6pUEV0c0HULxLJ8R0i6TutGVJF8x88r2vjFiBdTI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845289; v=1; x=1795450089;
 b=bjd9a8vAV8Z5UzNxNV3DzJ7639wbk2BjcpGcLLGn6jcjEuKdzTyvtU2kDLo46SUuxQTURoyH
 /V0Qwe0JWCLa4hmWPo0Pj732TFfBNgaoSXTVoxAbW4oZJrZNHC1pJtHZJ81wkj1VTHG69Fxg24J
 NAzppj+/5WN3WysYFes1Xf9c=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9f8fde792c182d15;
	Mon, 16 Nov 2026 16:08:09 +0000
X-Mizu-Trace-ID: 9f8fde792c182d15
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/5] net/ipv4: embed device sysctl context using stride
Date: Tue, 17 Nov 2026 00:07:36 +0800
Message-Id: <977b6ed46efcc69d4c6df3b833ba4e36a46d29cb.1794844686.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794844686.git.wen.yang@linux.dev>
References: <cover.1794844686.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Embed struct ctl_table into struct devinet_sysctl_entry with devconf
and net pointers, and register devinet arrays using
register_net_sysctl_stride().

Both devinet_conf_proc() and devinet_sysctl_forward() recover their
context via container_of(ctl, struct devinet_sysctl_entry, ctl).  This
completely eliminates the need for 32 per-attribute wrapper functions
while avoiding any priv field in struct ctl_table.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/ipv4/devinet.c | 190 +++++++++++++++++++++++++--------------------
 1 file changed, 104 insertions(+), 86 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 1e9d988849c9..1692a597be18 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2555,17 +2555,25 @@ static int devinet_conf_ifindex(struct net *net, struct ipv4_devconf *cnf)
 	}
 }
 
+struct devinet_sysctl_entry {
+	struct ctl_table ctl;
+	struct ipv4_devconf *cnf;
+	struct net *net;
+};
+
 static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
+	const struct devinet_sysctl_entry *entry =
+		container_of(ctl, struct devinet_sysctl_entry, ctl);
 	int old_value = *(int *)ctl->data;
 	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 	int new_value = *(int *)ctl->data;
 
 	if (write) {
-		struct ipv4_devconf *cnf = ctl->extra1;
+		struct ipv4_devconf *cnf = entry->cnf;
 		int i = (int *)ctl->data - cnf->data;
-		struct net *net = ctl->extra2;
+		struct net *net = entry->net;
 		int ifindex;
 
 		/* These attributes are bypassing the tracking state,
@@ -2597,7 +2605,9 @@ static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = ctl->extra2;
+	const struct devinet_sysctl_entry *entry =
+		container_of(ctl, struct devinet_sysctl_entry, ctl);
+	struct net *net = entry->net;
 	int *valp = ctl->data;
 	int val = *valp;
 	int ret;
@@ -2617,7 +2627,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 			if (valp == &IPV4_DEVCONF_ALL(net, FORWARDING)) {
 				inet_forward_change(net);
 			} else {
-				struct ipv4_devconf *cnf = ctl->extra1;
+				struct ipv4_devconf *cnf = entry->cnf;
 				struct in_device *idev =
 					container_of(cnf, struct in_device, cnf);
 				if (*valp)
@@ -2641,13 +2651,14 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 
 #define DEVINET_SYSCTL_ENTRY(attr, name, mval, proc) \
 	{ \
-		.procname	= name, \
-		.data		= ipv4_devconf.data + \
-				  IPV4_DEVCONF_ ## attr - 1, \
-		.maxlen		= sizeof(int), \
-		.mode		= mval, \
-		.proc_handler	= proc, \
-		.extra1		= &ipv4_devconf, \
+		.ctl = { \
+			.procname	= name, \
+			.data		= ipv4_devconf.data + \
+					  IPV4_DEVCONF_ ## attr - 1, \
+			.maxlen		= sizeof(int), \
+			.mode		= mval, \
+			.proc_handler	= proc, \
+		}, \
 	}
 
 #define DEVINET_SYSCTL_RW_ENTRY(attr, name) \
@@ -2659,57 +2670,57 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 #define DEVINET_SYSCTL_COMPLEX_ENTRY(attr, name, proc) \
 	DEVINET_SYSCTL_ENTRY(attr, name, 0644, proc)
 
-static struct devinet_sysctl_table {
+static const struct devinet_sysctl_entry devinet_sysctl[IPV4_DEVCONF_MAX] = {
+	DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
+				     devinet_sysctl_forward),
+	DEVINET_SYSCTL_RO_ENTRY(MC_FORWARDING, "mc_forwarding"),
+	DEVINET_SYSCTL_RW_ENTRY(BC_FORWARDING, "bc_forwarding"),
+
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
+	DEVINET_SYSCTL_RW_ENTRY(NOXFRM, "disable_xfrm"),
+	DEVINET_SYSCTL_RW_ENTRY(NOPOLICY, "disable_policy"),
+	DEVINET_SYSCTL_RW_ENTRY(PROMOTE_SECONDARIES,
+				"promote_secondaries"),
+	DEVINET_SYSCTL_RW_ENTRY(ROUTE_LOCALNET,
+				"route_localnet"),
+	DEVINET_SYSCTL_RW_ENTRY(DROP_UNICAST_IN_L2_MULTICAST,
+				"drop_unicast_in_l2_multicast"),
+};
+
+struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
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
-		DEVINET_SYSCTL_RW_ENTRY(NOXFRM, "disable_xfrm"),
-		DEVINET_SYSCTL_RW_ENTRY(NOPOLICY, "disable_policy"),
-		DEVINET_SYSCTL_RW_ENTRY(PROMOTE_SECONDARIES,
-					"promote_secondaries"),
-		DEVINET_SYSCTL_RW_ENTRY(ROUTE_LOCALNET,
-					"route_localnet"),
-		DEVINET_SYSCTL_RW_ENTRY(DROP_UNICAST_IN_L2_MULTICAST,
-					"drop_unicast_in_l2_multicast"),
-	},
+	struct devinet_sysctl_entry entries[IPV4_DEVCONF_MAX];
 };
 
 static int __devinet_sysctl_register(struct net *net, char *dev_name,
@@ -2719,19 +2730,22 @@ static int __devinet_sysctl_register(struct net *net, char *dev_name,
 	struct devinet_sysctl_table *t;
 	char path[sizeof("net/ipv4/conf/") + IFNAMSIZ];
 
-	t = kmemdup(&devinet_sysctl, sizeof(*t), GFP_KERNEL_ACCOUNT);
+	t = kmemdup(&devinet_sysctl, sizeof(devinet_sysctl), GFP_KERNEL_ACCOUNT);
 	if (!t)
 		goto out;
 
-	for (i = 0; i < ARRAY_SIZE(t->devinet_vars); i++) {
-		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
-		t->devinet_vars[i].extra1 = p;
-		t->devinet_vars[i].extra2 = net;
+	for (i = 0; i < ARRAY_SIZE(t->entries); i++) {
+		t->entries[i].ctl.data += (char *)p - (char *)&ipv4_devconf;
+		t->entries[i].cnf = p;
+		t->entries[i].net = net;
 	}
 
 	snprintf(path, sizeof(path), "net/ipv4/conf/%s", dev_name);
 
-	t->sysctl_header = register_net_sysctl(net, path, t->devinet_vars);
+	t->sysctl_header = register_net_sysctl_stride(net, path,
+						      &t->entries[0].ctl,
+						      ARRAY_SIZE(t->entries),
+						      sizeof(t->entries[0]));
 	if (!t->sysctl_header)
 		goto free;
 
@@ -2786,16 +2800,16 @@ static void devinet_sysctl_unregister(struct in_device *idev)
 	neigh_sysctl_unregister(idev->arp_parms);
 }
 
-static const struct ctl_table ctl_forward_entry[] = {
+static const struct devinet_sysctl_entry ctl_forward_entry[] = {
 	{
-		.procname	= "ip_forward",
-		.data		= &ipv4_devconf.data[
-					IPV4_DEVCONF_FORWARDING - 1],
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= devinet_sysctl_forward,
-		.extra1		= &ipv4_devconf,
-		.extra2		= &init_net,
+		.ctl = {
+			.procname	= "ip_forward",
+			.data		= &ipv4_devconf.data[
+						IPV4_DEVCONF_FORWARDING - 1],
+			.maxlen		= sizeof(int),
+			.mode		= 0644,
+			.proc_handler	= devinet_sysctl_forward,
+		},
 	},
 };
 #endif
@@ -2804,7 +2818,7 @@ static __net_init int devinet_init_net(struct net *net)
 {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *forw_hdr;
-	struct ctl_table *tbl;
+	struct devinet_sysctl_entry *fwd_entry;
 #endif
 	struct ipv4_devconf *all, *dflt;
 	int err;
@@ -2825,13 +2839,13 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_alloc_dflt;
 
 #ifdef CONFIG_SYSCTL
-	tbl = kmemdup(ctl_forward_entry, sizeof(ctl_forward_entry), GFP_KERNEL);
-	if (!tbl)
+	fwd_entry = kmemdup(ctl_forward_entry, sizeof(ctl_forward_entry), GFP_KERNEL);
+	if (!fwd_entry)
 		goto err_alloc_ctl;
 
-	tbl[0].data = &all->data[IPV4_DEVCONF_FORWARDING - 1];
-	tbl[0].extra1 = all;
-	tbl[0].extra2 = net;
+	fwd_entry[0].ctl.data = &all->data[IPV4_DEVCONF_FORWARDING - 1];
+	fwd_entry[0].cnf = all;
+	fwd_entry[0].net = net;
 #endif
 
 	if (!net_eq(net, &init_net)) {
@@ -2869,8 +2883,10 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_reg_dflt;
 
 	err = -ENOMEM;
-	forw_hdr = register_net_sysctl_sz(net, "net/ipv4", tbl,
-					  ARRAY_SIZE(ctl_forward_entry));
+	forw_hdr = register_net_sysctl_stride(net, "net/ipv4",
+					      &fwd_entry[0].ctl,
+					      ARRAY_SIZE(ctl_forward_entry),
+					      sizeof(fwd_entry[0]));
 	if (!forw_hdr)
 		goto err_reg_ctl;
 	net->ipv4.forw_hdr = forw_hdr;
@@ -2891,7 +2907,7 @@ static __net_init int devinet_init_net(struct net *net)
 err_reg_dflt:
 	__devinet_sysctl_unregister(net, all, NETCONFA_IFINDEX_ALL);
 err_reg_all:
-	kfree(tbl);
+	kfree(fwd_entry);
 err_alloc_ctl:
 #endif
 	kfree(dflt);
@@ -2907,18 +2923,20 @@ static __net_exit void devinet_exit_net(struct net *net)
 {
 #ifdef CONFIG_SYSCTL
 	const struct ctl_table *tbl;
+	struct devinet_sysctl_entry *fwd;
 #endif
 
 	cancel_delayed_work_sync(&net->ipv4.addr_chk_work);
 
 #ifdef CONFIG_SYSCTL
 	tbl = net->ipv4.forw_hdr->ctl_table_arg;
+	fwd = container_of(tbl, struct devinet_sysctl_entry, ctl);
 	unregister_net_sysctl_table(net->ipv4.forw_hdr);
 	__devinet_sysctl_unregister(net, net->ipv4.devconf_dflt,
 				    NETCONFA_IFINDEX_DEFAULT);
 	__devinet_sysctl_unregister(net, net->ipv4.devconf_all,
 				    NETCONFA_IFINDEX_ALL);
-	kfree(tbl);
+	kfree(fwd);
 #endif
 	kfree(net->ipv4.devconf_dflt);
 	kfree(net->ipv4.devconf_all);
-- 
2.25.1

