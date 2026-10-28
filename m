Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205498;
	b=yG8WgtEuUxg2VggNQmatiNeaTynnK5MhtmT1e+B3sEevbnmprKfExS4XfkVHl8Ke/iQJ
	 LZDL+HNl3VlSaINGJLlnjbqyQqoEtQPr/aLxUMRESZR2aqGuzy0qo2t+l2fby0HNOuXF6
	 k4SREdl3efCaO/clR5CyXwaq+s/d3kR22sXYS8s1b+oHQu6K8fC5AegoDb+QhFXd6zcBR
	 FOw3gxUVmV7BN/9QQrIAIglIXf78dmrALMLXoxvNMnELRmiwcmUsB5G1PgRKOvH2/FIZL
	 ABg7Qw/380r9OxMl9s5hU1IbQ8ByAm5TxP5qiA9wYRr2MUuBlhsBxaRCbKtU4gPWdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205498;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/yPObRt5zVBAII9+ZZTUNXsR06tsFo0w7KfsGM1A88=;
	b=ULznV1ABy1Ztshri2CMtbuiCnPQ6DdyZKum8w9r0VR0dtFJcLKql9G2yEncRXelnEMNA
	 FxNklSDksyE4gIn6XZh++vTAKhMHD8IiU80+6OwZR+51TQKkEGwoKnknfcV2WGUJZ+0U1
	 bFUPpuHVcM9f6rEJog2XBnpPsAl5jpC85ng3RfTOP5N83HuyI6VEqJg9cIAFni7O5JNwb
	 7CYpj9XlQYm65E1Ied4FqPzupRAd+2opTFjfANt4ZKFChGWNyybj9zuVCvgMnGKPFdWgM
	 lF5C+icf0NLIwLMJv13+LgA/cjtBgeHj5fifovZmb3id9L/huAWCKuE5cGzDyZaNqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UQlbGC7Y;
	arc=none smtp.remote-ip=91.218.175.69
Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C449606A32E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C449606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UQlbGC7Y
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=320+BugzpC8voU+V1P5P2T6+2q3QIeNzL936J/xqo3k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205496; v=1; x=1793810296;
 b=UQlbGC7YfK68m611rqlIPH1AnvQCZocm4hPJc3/N8no2ltbQzuEfN2HwPRqH1/pP27u7YMsn
 5Cc7xMP6cD9bGI/mI2y1wvk3F+qFmFTeRJ19ytRaY2siZo8IQ0h7ulaDhQCL4Fwb4KFUk1KhjUn
 PME4FRp+c6lrwEnw5JiLsxlo=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f3ecffc990eefc09;
	Wed, 28 Oct 2026 16:38:16 +0000
X-Mizu-Trace-ID: f3ecffc990eefc09
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 29/39] neighbour: derive sysctl ownership independently of bounds
Date: Thu, 29 Oct 2026 00:35:08 +0800
Message-Id: <f3291a063bfa2506f6597c2e626303821148f423.1793204511.git.wen.yang@linux.dev>
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

Derive neighbour parameters from backing storage instead of extra pointers.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/net/neighbour.h |   3 ++
 net/core/neighbour.c    | 101 ++++++++++++++++++++++++----------------
 2 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 79a5a548a129..316e34e97fcc 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -420,6 +420,9 @@ void *neigh_seq_start(struct seq_file *, loff_t *, struct neigh_table *,
 void *neigh_seq_next(struct seq_file *, void *, loff_t *);
 void neigh_seq_stop(struct seq_file *, void *);
 
+/* For neighbour parameter entries, whose data points into parms->data. */
+struct neigh_parms *neigh_sysctl_parms(const struct ctl_table *ctl);
+
 int neigh_proc_dointvec(const struct ctl_table *ctl, int write,
 			void *buffer, size_t *lenp, loff_t *ppos);
 int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..ab2559500134 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3627,16 +3627,14 @@ void neigh_app_ns(struct neighbour *n)
 }
 
 #ifdef CONFIG_SYSCTL
-static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
-
 static int proc_unres_qlen(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int size, ret;
 	struct ctl_table tmp = *ctl;
 
-	tmp.extra1 = SYSCTL_ZERO;
-	tmp.extra2 = &unres_qlen_max;
+	tmp.min = 0;
+	tmp.max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
 	tmp.data = &size;
 
 	size = *(int *)ctl->data / SKB_TRUESIZE(ETH_FRAME_LEN);
@@ -3666,8 +3664,8 @@ static void neigh_copy_dflt_parms(struct net *net, struct neigh_parms *p,
 
 static void neigh_proc_update(const struct ctl_table *ctl, int write)
 {
-	struct net_device *dev = ctl->extra1;
-	struct neigh_parms *p = ctl->extra2;
+	struct neigh_parms *p = neigh_sysctl_parms(ctl);
+	struct net_device *dev = p->dev;
 	struct net *net = neigh_parms_net(p);
 	int index = (int *) ctl->data - p->data;
 
@@ -3688,8 +3686,8 @@ static int neigh_proc_dointvec_zero_intmax(const struct ctl_table *ctl, int writ
 	struct ctl_table tmp = *ctl;
 	int ret;
 
-	tmp.extra1 = SYSCTL_ZERO;
-	tmp.extra2 = SYSCTL_INT_MAX;
+	tmp.min = 0;
+	tmp.max = INT_MAX;
 
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	neigh_proc_update(ctl, write);
@@ -3700,13 +3698,10 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
 						   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp = *ctl;
-	int ret, min, max;
-
-	min = msecs_to_jiffies(NTBL_PARM_MS_MIN);
-	max = msecs_to_jiffies(NTBL_PARM_MS_MAX);
+	int ret;
 
-	tmp.extra1 = &min;
-	tmp.extra2 = &max;
+	tmp.min = msecs_to_jiffies(NTBL_PARM_MS_MIN);
+	tmp.max = msecs_to_jiffies(NTBL_PARM_MS_MAX);
 
 	ret = proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, lenp, ppos);
 	neigh_proc_update(ctl, write);
@@ -3764,7 +3759,7 @@ static int neigh_proc_base_reachable_time(const struct ctl_table *ctl, int write
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	struct neigh_parms *p = ctl->extra2;
+	struct neigh_parms *p = neigh_sysctl_parms(ctl);
 	int ret;
 
 	if (strcmp(ctl->procname, "base_reachable_time") == 0)
@@ -3784,35 +3779,31 @@ static int neigh_proc_base_reachable_time(const struct ctl_table *ctl, int write
 	return ret;
 }
 
-#define NEIGH_PARMS_DATA_OFFSET(index)	\
-	(&((struct neigh_parms *) 0)->data[index])
-
-#define NEIGH_SYSCTL_ENTRY(attr, data_attr, name, mval, proc) \
+#define NEIGH_SYSCTL_ENTRY(attr, name, mval, proc) \
 	[NEIGH_VAR_ ## attr] = { \
 		.procname	= name, \
-		.data		= NEIGH_PARMS_DATA_OFFSET(NEIGH_VAR_ ## data_attr), \
 		.maxlen		= sizeof(int), \
 		.mode		= mval, \
 		.proc_handler	= proc, \
 	}
 
 #define NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_zero_intmax)
+	NEIGH_SYSCTL_ENTRY(attr, name, 0644, neigh_proc_dointvec_zero_intmax)
 
 #define NEIGH_SYSCTL_JIFFIES_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_jiffies)
+	NEIGH_SYSCTL_ENTRY(attr, name, 0644, neigh_proc_dointvec_jiffies)
 
 #define NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_userhz_jiffies)
+	NEIGH_SYSCTL_ENTRY(attr, name, 0644, neigh_proc_dointvec_userhz_jiffies)
 
 #define NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, attr, name, 0644, neigh_proc_dointvec_ms_jiffies_positive)
+	NEIGH_SYSCTL_ENTRY(attr, name, 0644, neigh_proc_dointvec_ms_jiffies_positive)
 
-#define NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(attr, data_attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, data_attr, name, 0644, neigh_proc_dointvec_ms_jiffies)
+#define NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(attr, name) \
+	NEIGH_SYSCTL_ENTRY(attr, name, 0644, neigh_proc_dointvec_ms_jiffies)
 
-#define NEIGH_SYSCTL_UNRES_QLEN_REUSED_ENTRY(attr, data_attr, name) \
-	NEIGH_SYSCTL_ENTRY(attr, data_attr, name, 0644, neigh_proc_dointvec_unres_qlen)
+#define NEIGH_SYSCTL_UNRES_QLEN_REUSED_ENTRY(attr, name) \
+	NEIGH_SYSCTL_ENTRY(attr, name, 0644, neigh_proc_dointvec_unres_qlen)
 
 static struct neigh_sysctl_table {
 	struct ctl_table_header *sysctl_header;
@@ -3834,9 +3825,9 @@ static struct neigh_sysctl_table {
 		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(ANYCAST_DELAY, "anycast_delay"),
 		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(PROXY_DELAY, "proxy_delay"),
 		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(LOCKTIME, "locktime"),
-		NEIGH_SYSCTL_UNRES_QLEN_REUSED_ENTRY(QUEUE_LEN, QUEUE_LEN_BYTES, "unres_qlen"),
-		NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(RETRANS_TIME_MS, RETRANS_TIME, "retrans_time_ms"),
-		NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(BASE_REACHABLE_TIME_MS, BASE_REACHABLE_TIME, "base_reachable_time_ms"),
+		NEIGH_SYSCTL_UNRES_QLEN_REUSED_ENTRY(QUEUE_LEN, "unres_qlen"),
+		NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(RETRANS_TIME_MS, "retrans_time_ms"),
+		NEIGH_SYSCTL_MS_JIFFIES_REUSED_ENTRY(BASE_REACHABLE_TIME_MS, "base_reachable_time_ms"),
 		[NEIGH_VAR_GC_INTERVAL] = {
 			.procname	= "gc_interval",
 			.maxlen		= sizeof(int),
@@ -3847,29 +3838,61 @@ static struct neigh_sysctl_table {
 			.procname	= "gc_thresh1",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_INT_MAX,
+			.min		= 0,
+			.max		= INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		[NEIGH_VAR_GC_THRESH2] = {
 			.procname	= "gc_thresh2",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_INT_MAX,
+			.min		= 0,
+			.max		= INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		[NEIGH_VAR_GC_THRESH3] = {
 			.procname	= "gc_thresh3",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1		= SYSCTL_ZERO,
-			.extra2		= SYSCTL_INT_MAX,
+			.min		= 0,
+			.max		= INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 	},
 };
 
+static unsigned int neigh_sysctl_data_index(unsigned int index)
+{
+	switch (index) {
+	case NEIGH_VAR_QUEUE_LEN:
+		return NEIGH_VAR_QUEUE_LEN_BYTES;
+	case NEIGH_VAR_RETRANS_TIME_MS:
+		return NEIGH_VAR_RETRANS_TIME;
+	case NEIGH_VAR_BASE_REACHABLE_TIME_MS:
+		return NEIGH_VAR_BASE_REACHABLE_TIME;
+	default:
+		return index;
+	}
+}
+
+struct neigh_parms *neigh_sysctl_parms(const struct ctl_table *ctl)
+{
+	unsigned int i;
+
+	/* The aliases use the same storage as their non-millisecond entries.
+	 * Keep data pointing at that storage, including for ndisc handlers.
+	 */
+	for (i = 0; i < NEIGH_VAR_GC_INTERVAL; i++) {
+		if (!strcmp(ctl->procname,
+			    neigh_sysctl_template.neigh_vars[i].procname))
+			return (struct neigh_parms *)
+				((char *)ctl->data - offsetof(struct neigh_parms, data) -
+				 neigh_sysctl_data_index(i) * sizeof(int));
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(neigh_sysctl_parms);
+
 int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 			  proc_handler *handler)
 {
@@ -3885,9 +3908,7 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 		goto err;
 
 	for (i = 0; i < NEIGH_VAR_GC_INTERVAL; i++) {
-		t->neigh_vars[i].data += (long) p;
-		t->neigh_vars[i].extra1 = dev;
-		t->neigh_vars[i].extra2 = p;
+		t->neigh_vars[i].data = &p->data[neigh_sysctl_data_index(i)];
 	}
 
 	neigh_vars_size = ARRAY_SIZE(t->neigh_vars);
-- 
2.25.1

