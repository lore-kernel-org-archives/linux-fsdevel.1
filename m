Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205469;
	b=zgcRVepuXUBKVMkfQ+z73zeIJhBCHpOyo9a0xfur+wfAfrKpFr4rKv2w+s+cEC59ZN5z
	 HC3BJ3Kcn3eZIRdRVRuril8qjL+IEdH+MI9GNQPHNkyzZ7cdfetXme5lcUIEOYPlftWn+
	 /dw2zfBxBHejYCGrjxJOX1M1mbMkm4HuVJX5UVJD6BpbMagfUoyv3ZoRRcqnPtp953xjZ
	 bOGGq47w98bE7H5WXR4hTrSMF1/oq83igUAR58q0cLPTv2YjC9pX15U3/zWWgu14rT+s3
	 JYBsrpqkErgs7Dj5ko/q0I34sTHOwgXCbFDkgnjpO4HmgyKjWo180L0+I+a5At+u1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205469;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SmZHdJwA0nTVD4grXEA4LqGJNLaI+aWn1kdnnfhjo+Y=;
	b=tKzzBryN6QPx1EhVK1h3WyMcD4yo6iP6eC28Ylr4FdCn78jfp4ZoJ8e0U4xi0pxyQ3Vm
	 UPGoXhtw+byOS59IHckvDB3ubv1a51mxFHWxN61U7SMlb8gIEC3PNPQq+MjkO65kK0THd
	 MLMLgSdZpAjLxiqLZgpg4YF+4IOzINICkTLmqLdP21rCJfI11+ARRHJCCo//gZ9bXQYMq
	 bPZoqIVsen6qGaDOhk6wacTU0CQvJNCqLNe/sMQvvtyCD9h0G9WdjZsZb3of3TbL1oXSk
	 wuOZ6NxMyaPT6CxsQNn5JI+ofWFo/hPLTbPGIBhcVzROvi3k7/O+EEhxLHNu1yb7TQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I23JiWKT;
	arc=none smtp.remote-ip=91.218.175.60
Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CA60A3807
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5CA60A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I23JiWKT
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rcJjShQ6Rwi265pTCdrAfCG+yQUnwPiDdCgX68/XHjY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205467; v=1; x=1793810267;
 b=I23JiWKTEUWf1+6SqtW0zqXhbhGyKWFMG13NrPD/3Xn05KVBz2fe36TxBfugO06lXicQoRho
 PEFAn9nHUNyY42KWekPoGgcLbLZrQgaZx5Jc+LzeBtweoxyb5RiPA4RLJr13hL4Ew2CeF2Yf4e8
 cwX4dtJo/aZ94nxAtrG7wQhY=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9c7125b63677d464;
	Wed, 28 Oct 2026 16:37:47 +0000
X-Mizu-Trace-ID: 9c7125b63677d464
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 24/39] net: refresh core sysctl limits without bound pointers
Date: Thu, 29 Oct 2026 00:35:03 +0800
Message-Id: <c8afbf52fbf9467eb2110a88d8c917ff30422be8.1793204511.git.wen.yang@linux.dev>
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

Refresh core network limits before validating sysctl writes.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/sysctl_net_core.c | 118 ++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 53 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 473c162736d6..1721e63240c9 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -32,12 +32,6 @@
 #include "dev.h"
 #include "net-sysfs.h"
 
-static int int_3600 = 3600;
-static int min_sndbuf = SOCK_MIN_SNDBUF;
-static int min_rcvbuf = SOCK_MIN_RCVBUF;
-static int max_skb_frags = MAX_SKB_FRAGS;
-static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
-static int netdev_budget_usecs_min = 2 * USEC_PER_SEC / HZ;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
@@ -146,7 +140,7 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 	struct ctl_table tmp = {
 		.data = &size,
 		.maxlen = sizeof(size),
-		.mode = table->mode
+		.mode = table->mode,
 	};
 	void *tofree = NULL;
 	int ret, i;
@@ -384,8 +378,8 @@ static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int wr
 					   loff_t *ppos)
 {
 	int ret, jit_enable = *(int *)table->data;
-	int min = *(int *)table->extra1;
-	int max = *(int *)table->extra2;
+	int min = (int)table->min;
+	int max = (int)table->max;
 	struct ctl_table tmp = *table;
 
 	if (write && !capable(CAP_SYS_ADMIN))
@@ -426,10 +420,13 @@ static int
 proc_dolongvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ctl_table tmp = *table;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.max = (unsigned long)READ_ONCE(bpf_jit_limit_max);
+	return proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
 }
 #endif
 
@@ -440,7 +437,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_mem_pcpu_rsv,
+		.min		= SK_MEMORY_PCPU_RESERVE,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "dev_weight",
@@ -448,7 +446,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
-		.extra1         = SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "dev_weight_rx_bias",
@@ -456,7 +455,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
-		.extra1         = SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "dev_weight_tx_bias",
@@ -464,7 +464,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
-		.extra1         = SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "netdev_max_backlog",
@@ -495,11 +496,11 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= 1,
 # else
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 # endif
 	},
 # ifdef CONFIG_HAVE_EBPF_JIT
@@ -509,8 +510,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "bpf_jit_kallsyms",
@@ -518,8 +519,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 # endif
 	{
@@ -528,8 +529,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0600,
 		.proc_handler	= proc_dolongvec_minmax_bpf_restricted,
-		.extra1		= SYSCTL_LONG_ONE,
-		.extra2		= &bpf_jit_limit_max,
+		.min		= 1,
+		.max		= ULONG_MAX,
 	},
 #endif
 	{
@@ -582,7 +583,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "busy_read",
@@ -590,7 +592,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 #endif
 #ifdef CONFIG_NET_SCHED
@@ -621,8 +624,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &max_skb_frags,
+		.min		= 1,
+		.max		= MAX_SKB_FRAGS,
 	},
 	{
 		.procname	= "netdev_budget_usecs",
@@ -630,7 +633,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &netdev_budget_usecs_min,
+		.min		= 2 * USEC_PER_SEC / HZ,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "fb_tunnels_only_for_init_net",
@@ -638,8 +642,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "devconf_inherit_init_net",
@@ -647,8 +651,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
+		.min		= 0,
+		.max		= 3,
 	},
 	{
 		.procname	= "high_order_alloc_disable",
@@ -663,7 +667,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "netdev_unregister_timeout_secs",
@@ -671,8 +676,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &int_3600,
+		.min		= 1,
+		.max		= 3600,
 	},
 	{
 		.procname	= "skb_defer_max",
@@ -680,7 +685,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_skb_defer_max,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "neigh_inherit_init_net",
@@ -688,8 +694,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
@@ -707,24 +713,26 @@ static const struct ctl_table netns_core_table[] = {
 		.data		= &init_net.core.sysctl_somaxconn,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.extra1		= SYSCTL_ZERO,
-		.proc_handler	= proc_dointvec_minmax
+		.min		= 0,
+		.proc_handler	= proc_dointvec_minmax,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "optmem_max",
 		.data		= &init_net.core.sysctl_optmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.extra1		= SYSCTL_ZERO,
-		.proc_handler	= proc_dointvec_minmax
+		.min		= 0,
+		.proc_handler	= proc_dointvec_minmax,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "txrehash",
 		.data		= &init_net.core.sysctl_txrehash,
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
 	{
@@ -740,8 +748,8 @@ static const struct ctl_table netns_core_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "bypass_prot_mem",
@@ -749,8 +757,8 @@ static const struct ctl_table netns_core_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
@@ -761,7 +769,8 @@ static const struct ctl_table netns_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
+		.min		= SOCK_MIN_SNDBUF,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "rmem_max",
@@ -769,7 +778,8 @@ static const struct ctl_table netns_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
+		.min		= SOCK_MIN_RCVBUF,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "wmem_default",
@@ -777,7 +787,8 @@ static const struct ctl_table netns_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
+		.min		= SOCK_MIN_SNDBUF,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "rmem_default",
@@ -785,7 +796,8 @@ static const struct ctl_table netns_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
+		.min		= SOCK_MIN_RCVBUF,
+		.max		= INT_MAX,
 	},
 };
 
-- 
2.25.1

