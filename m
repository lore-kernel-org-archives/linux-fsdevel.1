Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205502;
	b=q9IU1jG3/3LcjNnUXaBHwtRCfnl9n4ZKuoTtw3sCgp2rsrcZF30CBQDqAIKgFRsqwInf
	 hEu1AUp0+984Bg1AmJrJppUlC9BvKUjMfV7tpuc6H7F/7PqoExrjgcdakqlF4hJfrsyOj
	 NWKY8Q+iDiC54JhuVsWN2Eq9kdpmxx9dEKLdb2sBbMb/nk9o3jnMWJrG0S0V0LXj6jB9B
	 cUMEt9CsJU60YZRvIHPgGe5Dm1N3ePnZZqcKFjyRO0lnHgwGkb0jPgj8BSePEANjvYPqU
	 eb7bqwyw0hbHwn0z1LgcJil6c5Rrk0RG90j1ev7kmS/k3iwLEVXeHO2+5N9kA2X3KZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205502;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QGArUT0tYGqT6YpydoYlJ3J+4QE7Uvu2XIwCsSd8nE4=;
	b=Ts4QB0ddg+RHRNLW66+S28wGW983VwtNPgt0vaPUsM74H6YkPpjknfBw4+JfYJ8iUfIm
	 5andqbmjnTNHzhZUdw4UA3nb/bVwAmTzkg81W0EgYQX/k8tB0aai6f/H6+fHJqYOA5rRD
	 Q1OAstiUDw9bTRYKT0+e0PWcxG0KLr2ozgUg7T1R3bxgEGQiVZ2PB+1p2C94ytbNR0Irv
	 jwgYmqimGex1UJKsOw6nbGgpt6oVIeBmFwUgoa5wxkuREIQE2ymuR9biCYlf/QeVa7B7y
	 Y+1wo6e0GiYg7ttVcg7uxV3+g4lWLhrKL97AcvzbHLlqysGDoqmJDRR700OjhIjTx6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qNJSLDz6;
	arc=none smtp.remote-ip=91.218.175.70
Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F57606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F57606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qNJSLDz6
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=27zSEHPuQERMClX+jU67GXwkoLuufAbqKoD2Al414wI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205500; v=1; x=1793810300;
 b=qNJSLDz655jCfhUG36dzGU1EGoTewfamDF3lHinCYTMM9fCxjzVl0RknX6uA3ZP6I4fn04Lb
 FdhrJ4yMDqqWgQvJu5MA3zEqB8eDUhf877PXGe1ygw4h49sWEVA6jD76B73kdZdXe+KYSVGQZgN
 Qdln1pXRzAhnub12XGtL7mQw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 907abfd7274dda42;
	Wed, 28 Oct 2026 16:38:20 +0000
X-Mizu-Trace-ID: 907abfd7274dda42
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 30/39] net: resolve sysctl owners from their backing data
Date: Thu, 29 Oct 2026 00:35:09 +0800
Message-Id: <6fa0af34670abb09406ad3703e893b5757380cbc.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
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

Derive network owners from backing storage and remove extra-pointer use.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/net/vrf.c  | 20 +++++++------------
 net/ipv4/route.c   |  8 ++++----
 net/ipv6/ndisc.c   |  3 ++-
 net/ipv6/route.c   | 11 ++++++-----
 net/mpls/af_mpls.c | 49 ++++++++++++++++------------------------------
 5 files changed, 36 insertions(+), 55 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 79d433f49f80..993cc2d120fd 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1826,22 +1826,17 @@ static int vrf_strict_mode_change(struct vrf_map *vmap, bool new_mode)
 static int vrf_shared_table_handler(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = (struct net *)table->extra1;
+	struct net *net = table->data;
 	struct vrf_map *vmap = netns_vrf_map(net);
 	int proc_strict_mode = 0;
-	struct ctl_table tmp = {
-		.procname	= table->procname,
-		.data		= &proc_strict_mode,
-		.maxlen		= sizeof(int),
-		.mode		= table->mode,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	};
+	struct ctl_table tmp = *table;
 	int ret;
 
 	if (!write)
 		proc_strict_mode = vrf_strict_mode(vmap);
 
+	tmp.data = &proc_strict_mode;
+	tmp.maxlen = sizeof(proc_strict_mode);
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 
 	if (write && ret == 0)
@@ -1857,8 +1852,8 @@ static const struct ctl_table vrf_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= vrf_shared_table_handler,
-		/* set by the vrf_netns_init */
-		.extra1		= NULL,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
@@ -1870,8 +1865,7 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 	if (!table)
 		return -ENOMEM;
 
-	/* init the extra1 parameter with the reference to current netns */
-	table[0].extra1 = net;
+	table[0].data = net;
 
 	nn_vrf->ctl_hdr = register_net_sysctl_sz(net, "net/vrf", table,
 						 ARRAY_SIZE(vrf_table));
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 595a3b7f1783..b4c415f720b2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3507,12 +3507,11 @@ void ip_rt_multicast_event(struct in_device *in_dev)
 static int ip_rt_gc_interval __read_mostly  = 60 * HZ;
 static int ip_rt_gc_min_interval __read_mostly	= HZ / 2;
 static int ip_rt_gc_elasticity __read_mostly	= 8;
-static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 
 static int ipv4_sysctl_rtcache_flush(const struct ctl_table *__ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = (struct net *)__ctl->extra1;
+	struct net *net = __ctl->data;
 
 	if (write) {
 		rt_cache_flush(net);
@@ -3627,7 +3626,8 @@ static struct ctl_table ipv4_route_netns_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = &ip_min_valid_pmtu,
+		.min            = IPV4_MIN_MTU,
+		.max            = INT_MAX,
 	},
 	{
 		.procname       = "mtu_expires",
@@ -3670,7 +3670,7 @@ static __net_init int sysctl_route_net_init(struct net *net)
 		for (i = 1; i < table_size; i++)
 			tbl[i].data += (void *)net - (void *)&init_net;
 	}
-	tbl[0].extra1 = net;
+	tbl[0].data = net;
 
 	net->ipv4.route_hdr = register_net_sysctl_sz(net, "net/ipv4/route",
 						     tbl, table_size);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 0ed1a619372b..956220ad0cf8 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1956,7 +1956,8 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 int ndisc_ifinfo_sysctl_change(const struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	struct net_device *dev = ctl->extra1;
+	struct neigh_parms *p = neigh_sysctl_parms(ctl);
+	struct net_device *dev = p->dev;
 	struct inet6_dev *idev;
 	int ret;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4f83..a6925e9750e0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6563,9 +6563,12 @@ static int rt6_stats_seq_show(struct seq_file *seq, void *v)
 static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net;
+	int *valp = ctl->data;
+	struct net *net = container_of(valp, struct net,
+				       ipv6.sysctl.flush_delay);
 	int delay;
 	int ret;
+
 	if (!write)
 		return -EINVAL;
 
@@ -6573,7 +6576,6 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 	if (ret)
 		return ret;
 
-	net = (struct net *)ctl->extra1;
 	delay = READ_ONCE(net->ipv6.sysctl.flush_delay);
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
@@ -6656,8 +6658,8 @@ static const struct ctl_table ipv6_route_table_template[] = {
 		.maxlen		=	sizeof(u8),
 		.mode		=	0644,
 		.proc_handler	=	proc_dou8vec_minmax,
-		.extra1		=	SYSCTL_ZERO,
-		.extra2		=	SYSCTL_ONE,
+		.min		=	0,
+		.max		=	1,
 	},
 };
 
@@ -6673,7 +6675,6 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
 		table[0].data = &net->ipv6.sysctl.ip6_rt_max_size;
 		table[1].data = &net->ipv6.ip6_dst_ops.gc_thresh;
 		table[2].data = &net->ipv6.sysctl.flush_delay;
-		table[2].extra1 = net;
 		table[3].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
 		table[4].data = &net->ipv6.sysctl.ip6_rt_gc_timeout;
 		table[5].data = &net->ipv6.sysctl.ip6_rt_gc_interval;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ad4ad6f2001a..b8df02173d7a 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -37,9 +37,6 @@
 
 #define MPLS_NEIGH_TABLE_UNSPEC (NEIGH_LINK_TABLE + 1)
 
-static int label_limit = (1 << 20) - 1;
-static int ttl_max = 255;
-
 #if IS_ENABLED(CONFIG_NET_IP_TUNNEL)
 static size_t ipgre_mpls_encap_hlen(struct ip_tunnel_encap *e)
 {
@@ -1397,21 +1394,15 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int oval = *(int *)ctl->data;
+	int *valp = ctl->data;
+	struct mpls_dev *mdev = container_of(valp, struct mpls_dev,
+					   input_enabled);
+	int oval = *valp;
 	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 
-	if (write) {
-		struct mpls_dev *mdev = ctl->extra1;
-		int i = (int *)ctl->data - (int *)mdev;
-		struct net *net = ctl->extra2;
-		int val = *(int *)ctl->data;
-
-		if (i == offsetof(struct mpls_dev, input_enabled) &&
-		    val != oval) {
-			mpls_netconf_notify_devconf(net, RTM_NEWNETCONF,
-						    NETCONFA_INPUT, mdev);
-		}
-	}
+	if (write && *valp != oval)
+		mpls_netconf_notify_devconf(dev_net(mdev->dev), RTM_NEWNETCONF,
+					    NETCONFA_INPUT, mdev);
 
 	return ret;
 }
@@ -1442,11 +1433,8 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 	/* Table data contains only offsets relative to the base of
 	 * the mdev at this point, so make them absolute.
 	 */
-	for (i = 0; i < table_size; i++) {
+	for (i = 0; i < table_size; i++)
 		table[i].data = (char *)mdev + (uintptr_t)table[i].data;
-		table[i].extra1 = mdev;
-		table[i].extra2 = net;
-	}
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
@@ -2694,15 +2682,10 @@ static int mpls_platform_labels(const struct ctl_table *table, int write,
 	struct net *net = table->data;
 	int platform_labels = net->mpls.platform_labels;
 	int ret;
-	struct ctl_table tmp = {
-		.procname	= table->procname,
-		.data		= &platform_labels,
-		.maxlen		= sizeof(int),
-		.mode		= table->mode,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &label_limit,
-	};
+	struct ctl_table tmp = *table;
 
+	tmp.data = &platform_labels;
+	tmp.maxlen = sizeof(platform_labels);
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 
 	if (write && ret == 0)
@@ -2721,6 +2704,8 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= mpls_platform_labels,
+		.min		= 0,
+		.max		= (1 << 20) - 1,
 	},
 	{
 		.procname	= "ip_ttl_propagate",
@@ -2728,8 +2713,8 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "default_ttl",
@@ -2737,8 +2722,8 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &ttl_max,
+		.min		= 1,
+		.max		= 255,
 	},
 };
 
-- 
2.25.1

