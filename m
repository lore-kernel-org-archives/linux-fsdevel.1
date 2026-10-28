Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205507;
	b=H/xMqKCZlHDv1vvDuGBGvf7YkY0gbvnvduAEPpKeZQZHUtAVdnq7K8QlDZb7t3N2KQin
	 0zWBSeMf2+OtRtD3VKBT1OQ1gVcmyMim1QfJQyjrTk9GHV7hprT2MV2WCmo0XjORPIIew
	 uIr3AUHV2YpmawD2BBly/PURWY5c+lkMaH7IkS8AHNZmWiuPGKF74cgMctrKKcO+6KF41
	 Y14ptoNyMyHcNGRENhtUKuZfmQH+CsRi2RWbnjUeb9uKdQweONh0bn//stAuHWRyIL+PZ
	 Ev789HA2o3cIEGQMptGJEFcHUELc6jriyiwciB1Ig2DdGIjjoi2FoyWmyDOfkahhbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205507;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UR+r9FlzPsFPVtY8AORq1NV2Ubx3UGLO4YtlHVqa3K0=;
	b=AZX7LdfPxghu3/M8TH8K4R6dckw2VbrwpnFbT4cdtY8pDOEqkvLdd1NfElCjacydaaHF
	 xkPebEkmnUuDnkEH/G9iT7i0KssQ82Jxbpbba3kdVyLpRStRJwt20KTOsh37sThmzIOMZ
	 iZt9x3Lti+Q3EkjZ+swkuZrZmRaWWoqorELrUYS4dT6XjiIumycSlTQdozcoGWKugTMts
	 VjTMC7aEnD3szG0UoBaTUkbSPUNSaOa5n7+WmmP7G+vXOmtTxif4xbGvMT0IMjxtpvK7E
	 2mCauDgvi6nYu2kEtfwQqsV3jYQKqxrri/dySFxTj+85/4c11hCdLWzAV6UhR0xraiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Q/FLiHeS";
	arc=none smtp.remote-ip=95.215.58.102
Received: from mta1.migadu.com (out-102.mta1.migadu.com [95.215.58.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB860A5BD7
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAB860A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q/FLiHeS
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LYBNUReCCUDUaeqdplvNuxhjvq9OJQtMc2jcLJ4HIDU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205505; v=1; x=1793810305;
 b=Q/FLiHeSYscSQ/MuA5zaVvmj1klcpRRSvqRWSmX65b8+qW6/YTbsxM0pbLgwZyNbbeu6epXZ
 AMXMdckfChTBeHzmRe9FJki5bhqdHoTOn8zDf8OfNh1RFCWSfj52l3oHLEOKCjtAOXuNTOnJokq
 vOXaktJq3YuVPquXq73l2Lsw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 12a88832c338d040;
	Wed, 28 Oct 2026 16:38:25 +0000
X-Mizu-Trace-ID: 12a88832c338d040
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 31/39] ipvs: derive sysctl ownership from numeric storage
Date: Thu, 29 Oct 2026 00:35:10 +0800
Message-Id: <36ed716eb067114083b25e360443624ad2a63261.1793204511.git.wen.yang@linux.dev>
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

Derive IPVS ownership from each sysctl field instead of extra pointers.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 156 +++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 68 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 6c29a901d139..ed8e641da2ae 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -16,7 +16,6 @@
 #define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
-#include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/capability.h>
@@ -2375,6 +2374,8 @@ proc_do_conn_max(const struct ctl_table *table, int write,
 		 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_conn_max);
 	/* We can not use *valp to check if new value is provided, use INT_MIN
 	 * for this because different admins change different limits.
 	 */
@@ -2382,14 +2383,13 @@ proc_do_conn_max(const struct ctl_table *table, int write,
 	int val = write ? unset : READ_ONCE(*valp);
 	int rc;
 
-	const struct ctl_table tmp = {
-		.data = &val,
-		.maxlen = sizeof(int),
-	};
+	struct ctl_table tmp = *table;
+
+	tmp.data = &val;
+	tmp.maxlen = sizeof(val);
 
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write && !rc && val != unset) {
-		struct netns_ipvs *ipvs = table->extra2;
 		bool priv = capable(CAP_NET_ADMIN);
 		int max;
 
@@ -2410,19 +2410,17 @@ proc_do_conn_max(const struct ctl_table *table, int write,
 }
 
 static int
-proc_do_defense_mode(const struct ctl_table *table, int write,
-		     void *buffer, size_t *lenp, loff_t *ppos)
+proc_do_defense_mode(struct netns_ipvs *ipvs, const struct ctl_table *table,
+		     int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val = *valp;
 	int rc;
 
-	struct ctl_table tmp = {
-		.data = &val,
-		.maxlen = sizeof(int),
-		.mode = table->mode,
-	};
+	struct ctl_table tmp = *table;
+
+	tmp.data = &val;
+	tmp.maxlen = sizeof(val);
 
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write && (*valp != val)) {
@@ -2436,19 +2434,49 @@ proc_do_defense_mode(const struct ctl_table *table, int write,
 	return rc;
 }
 
+static int proc_do_drop_entry(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_drop_entry);
+
+	return proc_do_defense_mode(ipvs, table, write, buffer, lenp, ppos);
+}
+
+static int proc_do_drop_packet(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_drop_packet);
+
+	return proc_do_defense_mode(ipvs, table, write, buffer, lenp, ppos);
+}
+
+static int proc_do_secure_tcp(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_secure_tcp);
+
+	return proc_do_defense_mode(ipvs, table, write, buffer, lenp, ppos);
+}
+
 static int
 proc_do_sync_threshold(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
-	int *valp = table->data;
+	int (*valp)[2] = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_sync_threshold);
 	int val[2];
 	int rc;
-	struct ctl_table tmp = {
-		.data = &val,
-		.maxlen = table->maxlen,
-		.mode = table->mode,
-	};
+	struct ctl_table tmp = *table;
+
+	tmp.data = val;
+	tmp.maxlen = sizeof(val);
 
 	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
@@ -2475,11 +2503,10 @@ proc_do_sync_ports(const struct ctl_table *table, int write,
 	int val = *valp;
 	int rc;
 
-	struct ctl_table tmp = {
-		.data = &val,
-		.maxlen = sizeof(int),
-		.mode = table->mode,
-	};
+	struct ctl_table tmp = *table;
+
+	tmp.data = &val;
+	tmp.maxlen = sizeof(val);
 
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write && (*valp != val)) {
@@ -2494,8 +2521,9 @@ proc_do_sync_ports(const struct ctl_table *table, int write,
 static int ipvs_proc_est_cpumask_set(const struct ctl_table *table,
 				     void *buffer)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	cpumask_var_t *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_est_cpulist);
 	cpumask_var_t newmask;
 	int ret;
 
@@ -2533,8 +2561,9 @@ static int ipvs_proc_est_cpumask_set(const struct ctl_table *table,
 static int ipvs_proc_est_cpumask_get(const struct ctl_table *table,
 				     void *buffer, size_t size)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	cpumask_var_t *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_est_cpulist);
 	struct cpumask *mask;
 	int ret;
 
@@ -2584,16 +2613,16 @@ static int ipvs_proc_est_cpulist(const struct ctl_table *table, int write,
 static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_est_nice);
 	int val = *valp;
 	int ret;
 
-	struct ctl_table tmp_table = {
-		.data = &val,
-		.maxlen = sizeof(int),
-		.mode = table->mode,
-	};
+	struct ctl_table tmp_table = *table;
+
+	tmp_table.data = &val;
+	tmp_table.maxlen = sizeof(val);
 
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
@@ -2614,16 +2643,16 @@ static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 static int ipvs_proc_run_estimation(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_run_estimation);
 	int val = *valp;
 	int ret;
 
-	struct ctl_table tmp_table = {
-		.data = &val,
-		.maxlen = sizeof(int),
-		.mode = table->mode,
-	};
+	struct ctl_table tmp_table = *table;
+
+	tmp_table.data = &val;
+	tmp_table.maxlen = sizeof(val);
 
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
@@ -2640,15 +2669,16 @@ static int ipvs_proc_run_estimation(const struct ctl_table *table, int write,
 static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_conn_lfactor);
 	int val = *valp;
 	int ret;
 
-	struct ctl_table tmp_table = {
-		.data = &val,
-		.maxlen = sizeof(int),
-	};
+	struct ctl_table tmp_table = *table;
+
+	tmp_table.data = &val;
+	tmp_table.maxlen = sizeof(val);
 
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
@@ -2667,15 +2697,16 @@ static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 static int ipvs_proc_svc_lfactor(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
+	struct netns_ipvs *ipvs = container_of(valp, struct netns_ipvs,
+					    sysctl_svc_lfactor);
 	int val = *valp;
 	int ret;
 
-	struct ctl_table tmp_table = {
-		.data = &val,
-		.maxlen = sizeof(int),
-	};
+	struct ctl_table tmp_table = *table;
+
+	tmp_table.data = &val;
+	tmp_table.maxlen = sizeof(val);
 
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (write && ret >= 0) {
@@ -2726,13 +2757,13 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "drop_entry",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_do_defense_mode,
+		.proc_handler	= proc_do_drop_entry,
 	},
 	{
 		.procname	= "drop_packet",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_do_defense_mode,
+		.proc_handler	= proc_do_drop_packet,
 	},
 #ifdef CONFIG_IP_VS_NFCT
 	{
@@ -2746,7 +2777,7 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "secure_tcp",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_do_defense_mode,
+		.proc_handler	= proc_do_secure_tcp,
 	},
 	{
 		.procname	= "snat_reroute",
@@ -2759,8 +2790,8 @@ static struct ctl_table vs_vars[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "sync_ports",
@@ -2836,8 +2867,8 @@ static struct ctl_table vs_vars[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
+		.min		= 0,
+		.max		= 3,
 	},
 	{
 		.procname	= "nat_icmp_send",
@@ -5071,10 +5102,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
-	for (idx = 0; idx < ARRAY_SIZE(vs_vars); idx++) {
-		if (tbl[idx].proc_handler == proc_do_defense_mode)
-			tbl[idx].extra2 = ipvs;
-	}
 	idx = 0;
 	ipvs->sysctl_amemthresh = 1024;
 	tbl[idx++].data = &ipvs->sysctl_amemthresh;
@@ -5085,7 +5112,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->conn_max_limit = net_eq(net, &init_net) ? IP_VS_CONN_MAX :
 			       READ_ONCE(*(int *)vs_vars[idx].data);
 	ipvs->sysctl_conn_max = ipvs->conn_max_limit;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_conn_max;
 
 	tbl[idx++].data = &ipvs->sysctl_drop_entry;
@@ -5120,7 +5146,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
@@ -5138,29 +5163,24 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_run_estimation = 1;
 	if (unpriv)
 		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
 
 	ipvs->est_cpulist_valid = 0;
 	if (unpriv)
 		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_est_cpulist;
 
 	ipvs->sysctl_est_nice = IPVS_EST_NICE;
 	if (unpriv)
 		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_est_nice;
 
 	if (unpriv)
 		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_conn_lfactor;
 
 	if (unpriv)
 		tbl[idx].mode = 0444;
-	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_svc_lfactor;
 
 #ifdef CONFIG_IP_VS_DEBUG
-- 
2.25.1

