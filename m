Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205494;
	b=oLl9sJcw6QooZmMU3LmHuJvYkSg1Lc9FEi9LjbRvZEABgM2cftnlQu7pLJlIzvXeCMb0
	 LMhqstHFnhMVoymKRZafcomKKCSmdGXjeHqTHX+yq26H3V4zG8xhW00KlpILPfAW8qL3k
	 SK991YccxjOY5x3AlOKkyF2YCqAgolPj4Jw0ph5L+taIDj1OeqUwrW8ePd4V0PeGBELE5
	 2ishif58ijQz8vt1vBdzSLVG/6wszPizunuxk+9sHWhwmuK+m2dWMPeS1irkVsamBxj9O
	 gByslLwySMbyti4tKAus35apLzOsGcsFoNc6mbDecZUOWgoL+qsg05VSR+yjPyvA29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205494;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k45btPpoPPAfXP+T8H453Z0s1Gx2waUlVpnJY+SlxMw=;
	b=dwnkwIBSCtHV9bWD4waX9yi+1Nb4eeBN4Qo4bcGOFpN+DOVvmztEV600npif3STCOXu2
	 IBsAvG2pA3oMXQk35OXC42KEMNO8a2gNb5E7DzMMZVrM4f3RAR6QBhrWluFYNHi9tVhvU
	 nlwqchtKBgHJrZxZHMzxV+2JzSi7/g6FR1m3MtGttkLc7XcqzWntQosEZFmtrM9C6cFmJ
	 L49CZK4rChhDwjW6f6Ie5z0tfxCqRA4l/AarE9EekAJa/Ub5OTH3ZYmZ/D2HWKnlQQuEB
	 L9Nk7LSInEW/h2HIqfaqMdQ0NwgI9Gh7rl0MqTxenMpbasxRTN03+2pHgM6VJiE2k9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fokztu5J;
	arc=none smtp.remote-ip=91.218.175.68
Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD454606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD454606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fokztu5J
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3cURYU/aPwB24MzaGvmD0/Fj4ugDjHSMtf1DfSpb7k8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205491; v=1; x=1793810291;
 b=fokztu5JOc/IINlk2ijilmmGNep5adRAmseemb2OveMtNed9PQFecMdrcQ2EpgcwiafRsaif
 grZufJd5OM+PQCbCb5Dulk67x1CcjB5xLz505ETK8PO4iugz5Z1KH+F6SZLeqlsrfnyWQHA9rab
 ttdkQX0QPHHAk6rWmDm4tEtM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 84313478321dd2a5;
	Wed, 28 Oct 2026 16:38:11 +0000
X-Mizu-Trace-ID: 84313478321dd2a5
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 28/39] net: refresh fragment and remaining dynamic sysctl bounds
Date: Thu, 29 Oct 2026 00:35:07 +0800
Message-Id: <7f73097867aefe32de84aa588eb4f20866fb431c.1793204511.git.wen.yang@linux.dev>
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

Refresh fragment sibling thresholds and use numeric Phonet bounds.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/ieee802154/6lowpan/reassembly.c     | 27 +++++++++++++++++----
 net/ipv4/ip_fragment.c                  | 31 +++++++++++++++++++------
 net/ipv6/netfilter/nf_conntrack_reasm.c | 27 +++++++++++++++++----
 net/ipv6/reassembly.c                   | 27 +++++++++++++++++----
 net/phonet/sysctl.c                     |  6 ++---
 5 files changed, 92 insertions(+), 26 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index a2167f76ecc3..00b328378d19 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) "6LoWPAN: " fmt
 
 #include <linux/net.h>
-#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
@@ -327,12 +326,32 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 
 #ifdef CONFIG_SYSCTL
 
+static int lowpan_frags_high_thresh_handler(const struct ctl_table *table,
+					    int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, high_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(fqdir->low_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int lowpan_frags_low_thresh_handler(const struct ctl_table *table,
+					   int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, low_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(fqdir->high_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 	{
 		.procname	= "6lowpanfrag_high_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= lowpan_frags_high_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -340,7 +359,7 @@ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 		.procname	= "6lowpanfrag_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= lowpan_frags_low_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -385,9 +404,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 	}
 
 	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
-	table[0].extra1	= &ieee802154_lowpan->fqdir->low_thresh;
 	table[1].data	= &ieee802154_lowpan->fqdir->low_thresh;
-	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
 	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
 
 	hdr = register_net_sysctl_sz(net, "net/ieee802154/6lowpan", table,
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 75bc675e5579..c01df071240a 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -24,7 +24,6 @@
 #define pr_fmt(fmt) "IPv4: " fmt
 
 #include <linux/compiler.h>
-#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -544,14 +543,33 @@ struct sk_buff *ip_check_defrag(struct net *net, struct sk_buff *skb, u32 user)
 EXPORT_SYMBOL(ip_check_defrag);
 
 #ifdef CONFIG_SYSCTL
-static int dist_min;
+
+static int ip4_frags_high_thresh_handler(const struct ctl_table *table,
+					 int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, high_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(fqdir->low_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int ip4_frags_low_thresh_handler(const struct ctl_table *table,
+					int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, low_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(fqdir->high_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
 
 static struct ctl_table ip4_frags_ns_ctl_table[] = {
 	{
 		.procname	= "ipfrag_high_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= ip4_frags_high_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -559,7 +577,7 @@ static struct ctl_table ip4_frags_ns_ctl_table[] = {
 		.procname	= "ipfrag_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= ip4_frags_low_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -574,7 +592,8 @@ static struct ctl_table ip4_frags_ns_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &dist_min,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 };
 
@@ -603,9 +622,7 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 
 	}
 	table[0].data	= &net->ipv4.fqdir->high_thresh;
-	table[0].extra1	= &net->ipv4.fqdir->low_thresh;
 	table[1].data	= &net->ipv4.fqdir->low_thresh;
-	table[1].extra2	= &net->ipv4.fqdir->high_thresh;
 	table[2].data	= &net->ipv4.fqdir->timeout;
 	table[3].data	= &net->ipv4.fqdir->max_dist;
 
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 1f3ba85f6dca..4cb69dc14b11 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -13,7 +13,6 @@
 #define pr_fmt(fmt) "IPv6-nf: " fmt
 
 #include <linux/errno.h>
-#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/net.h>
@@ -44,6 +43,26 @@ static struct nft_ct_frag6_pernet *nf_frag_pernet(struct net *net)
 
 #ifdef CONFIG_SYSCTL
 
+static int nf_ct_frag6_high_thresh_handler(const struct ctl_table *table,
+					   int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, high_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(fqdir->low_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int nf_ct_frag6_low_thresh_handler(const struct ctl_table *table,
+					  int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, low_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(fqdir->high_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 	{
 		.procname	= "nf_conntrack_frag6_timeout",
@@ -55,7 +74,7 @@ static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 		.procname	= "nf_conntrack_frag6_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= nf_ct_frag6_low_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -63,7 +82,7 @@ static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 		.procname	= "nf_conntrack_frag6_high_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= nf_ct_frag6_high_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -87,9 +106,7 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
 
 	table[0].data	= &nf_frag->fqdir->timeout;
 	table[1].data	= &nf_frag->fqdir->low_thresh;
-	table[1].extra2	= &nf_frag->fqdir->high_thresh;
 	table[2].data	= &nf_frag->fqdir->high_thresh;
-	table[2].extra1	= &nf_frag->fqdir->low_thresh;
 
 	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
 				     ARRAY_SIZE(nf_ct_frag6_sysctl_table));
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 70c845385744..99b819f0cbf5 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -26,7 +26,6 @@
 #define pr_fmt(fmt) "IPv6: " fmt
 
 #include <linux/errno.h>
-#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/socket.h>
@@ -422,12 +421,32 @@ static const struct inet6_protocol frag_protocol = {
 
 #ifdef CONFIG_SYSCTL
 
+static int ip6_frags_high_thresh_handler(const struct ctl_table *table,
+					 int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, high_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(fqdir->low_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int ip6_frags_low_thresh_handler(const struct ctl_table *table,
+					int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct fqdir *fqdir = container_of(table->data, struct fqdir, low_thresh);
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(fqdir->high_thresh);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table ip6_frags_ns_ctl_table[] = {
 	{
 		.procname	= "ip6frag_high_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= ip6_frags_high_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -435,7 +454,7 @@ static struct ctl_table ip6_frags_ns_ctl_table[] = {
 		.procname	= "ip6frag_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= ip6_frags_low_thresh_handler,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -472,9 +491,7 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 
 	}
 	table[0].data	= &net->ipv6.fqdir->high_thresh;
-	table[0].extra1	= &net->ipv6.fqdir->low_thresh;
 	table[1].data	= &net->ipv6.fqdir->low_thresh;
-	table[1].extra2	= &net->ipv6.fqdir->high_thresh;
 	table[2].data	= &net->ipv6.fqdir->timeout;
 
 	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
diff --git a/net/phonet/sysctl.c b/net/phonet/sysctl.c
index 463a74a27d3e..fe2893b07e2a 100644
--- a/net/phonet/sysctl.c
+++ b/net/phonet/sysctl.c
@@ -22,8 +22,6 @@
 #define DYNAMIC_PORT_MAX	0x7f
 
 static DEFINE_SEQLOCK(local_port_range_lock);
-static int local_port_range_min[2] = {0, 0};
-static int local_port_range_max[2] = {1023, 1023};
 static int local_port_range[2] = {DYNAMIC_PORT_MIN, DYNAMIC_PORT_MAX};
 static struct ctl_table_header *phonet_table_hrd;
 
@@ -57,8 +55,8 @@ static int proc_local_port_range(const struct ctl_table *table, int write,
 		.data = &range,
 		.maxlen = sizeof(range),
 		.mode = table->mode,
-		.extra1 = &local_port_range_min,
-		.extra2 = &local_port_range_max,
+		.min = 0,
+		.max = 1023,
 	};
 
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
-- 
2.25.1

