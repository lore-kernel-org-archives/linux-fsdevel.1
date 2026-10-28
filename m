Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205475;
	b=nDAxo7fg7xLp7auDFhIK1QOxyctdPyxjOZP1nW61yuwHknFHBmZAO7+vTH0I3VoSgw3b
	 4F3lV2X3wzdtgfCN1bH5U7sFJmucLmORde6LIyQqeHUhkQ8eJ4NLIPk9k1PfVMGftIG3i
	 vlveH7Y76qkCK+yCn+ucA+VzsD0IqQ+su/Assir85eIEdOUcf48HBn/Yz51Abkuf4+/B6
	 YNOImzgypU1CVpl7SkK4CpnSd32dTD/Jre5ZJjEJWfO/t4bBa8zzNUtmj0oBekrSo9+hp
	 /w+KO7eJfx9U5xGXlFLLrLttGZM7uk6Na94W88WbuysHjkp1OHTmmnc9B/Tq9t4RhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205475;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cl2t7SVAUrZmqKlh3Sp8PGzSC+Fx7V7iwRCFIpWeeaM=;
	b=zZBISjfiE4htW1iwf90MJrwIk0LvMtW9ryctnmWMMp/yv6akl6krt4rGygjyoEk/k8zV
	 xcnGkyL3+zk9KLZwowtpyuh/1eHUuaP2gtd4tTIKnD2EQ1zm2zNe9xmg6MYyO1MaJTpKo
	 8REgNOfHEuR/ri4fNqcwRnWVDPQ8ISRr/ka82S01rpgLAVVf97ADOu8PezpDogIsAxsie
	 v5ftYOnmkYrdkgsW6h0rTy1j3O1Cpwe/KL800/2UYuF0zbZ8rDojkeR3FFqYfsCtu36zq
	 qkrP8BloAR4jS7gkz2WaL1L3HlfpuI9KXWm870MzPTbURfHXa4bxo1s4HFauYBAO4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rdKu54TK;
	arc=none smtp.remote-ip=91.218.175.61
Received: from mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407E606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0407E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rdKu54TK
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FpgD1K+Km3cZHXQOSTl9x/RzWOaC/fXz6KDGkHxgMUk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205473; v=1; x=1793810273;
 b=rdKu54TK/BP8xRa1MesDrttEpw6MoOKrTxqin3i8gepOQW6qsZfDpWfrGmQHp+381Vd7Df92
 c3j1Ctr+OMkE5lc7tT+jYhlLWsFuGzBayoSPN7AP3MujrkVxVj+767S8C96mP9sXgkAr0VKSAfL
 5fP8EJnvdfq4v7E2CctxMmzQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 392cb107fee7f840;
	Wed, 28 Oct 2026 16:37:53 +0000
X-Mizu-Trace-ID: 392cb107fee7f840
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 25/39] sctp: resolve numeric ranges from the current namespace
Date: Thu, 29 Oct 2026 00:35:04 +0800
Message-Id: <c65dd020fae1cf48364130682a94a74ba4ed5740.1793204511.git.wen.yang@linux.dev>
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

Read sibling SCTP limits from the current namespace on each call.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/sctp/sysctl.c | 147 +++++++++++++++++++++++-----------------------
 1 file changed, 72 insertions(+), 75 deletions(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 59c6f22337ea..ed296f568887 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -24,25 +24,6 @@
 #include <net/sctp/structs.h>
 #include <net/sctp/sctp.h>
 #include <linux/sysctl.h>
-#include <linux/limits.h>
-
-static int timer_max = 86400000; /* ms in one day */
-static int sack_timer_min = 1;
-static int sack_timer_max = 500;
-static int addr_scope_max = SCTP_SCOPE_POLICY_MAX;
-static int rwnd_scale_max = 16;
-static int rto_alpha_min = 0;
-static int rto_beta_min = 0;
-static int rto_alpha_max = 1000;
-static int rto_beta_max = 1000;
-static int pf_expose_max = SCTP_PF_EXPOSE_MAX;
-static int ps_retrans_max = SCTP_PS_RETRANS_MAX;
-static int udp_port_max = 65535;
-
-static unsigned long max_autoclose_min = 0;
-static unsigned long max_autoclose_max =
-	(MAX_SCHEDULE_TIMEOUT / HZ > UINT_MAX)
-	? UINT_MAX : MAX_SCHEDULE_TIMEOUT / HZ;
 
 static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
@@ -50,6 +31,26 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write, void *buffer,
 				size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_pf_retrans(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(ctl->data, struct net, sctp.pf_retrans);
+	struct ctl_table tmp = *ctl;
+
+	tmp.max = (unsigned long)READ_ONCE(net->sctp.ps_retrans);
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int proc_sctp_do_ps_retrans(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(ctl->data, struct net, sctp.ps_retrans);
+	struct ctl_table tmp = *ctl;
+
+	tmp.min = (unsigned long)READ_ONCE(net->sctp.pf_retrans);
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write, void *buffer,
 				 size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
@@ -65,7 +66,7 @@ static struct ctl_table sctp_table[] = {
 		.data		= &sysctl_sctp_mem,
 		.maxlen		= sizeof(sysctl_sctp_mem),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax
+		.proc_handler	= proc_doulongvec_minmax,
 		.min		= 0,
 		.max		= ULONG_MAX,
 	},
@@ -102,8 +103,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_rto_min,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &init_net.sctp.rto_max
+		.min		= 1,
+		.max		= UINT_MAX,
 	},
 	[SCTP_RTO_MAX_IDX] =  {
 		.procname	= "rto_max",
@@ -111,26 +112,26 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_rto_max,
-		.extra1         = &init_net.sctp.rto_min,
-		.extra2         = &timer_max
+		.min		= 0,
+		.max		= 86400000,
 	},
 	[SCTP_PF_RETRANS_IDX] = {
 		.procname	= "pf_retrans",
 		.data		= &init_net.sctp.pf_retrans,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &init_net.sctp.ps_retrans,
+		.proc_handler	= proc_sctp_do_pf_retrans,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	[SCTP_PS_RETRANS_IDX] = {
 		.procname	= "ps_retrans",
 		.data		= &init_net.sctp.ps_retrans,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &init_net.sctp.pf_retrans,
-		.extra2		= &ps_retrans_max,
+		.proc_handler	= proc_sctp_do_ps_retrans,
+		.min		= (unsigned long)INT_MIN,
+		.max		= SCTP_PS_RETRANS_MAX,
 	},
 	{
 		.procname	= "rto_initial",
@@ -138,8 +139,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
+		.min		= 1,
+		.max		= 86400000
 	},
 	{
 		.procname	= "rto_alpha_exp_divisor",
@@ -147,8 +148,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_alpha_beta,
-		.extra1		= &rto_alpha_min,
-		.extra2		= &rto_alpha_max,
+		.min		= 0,
+		.max		= 1000,
 	},
 	{
 		.procname	= "rto_beta_exp_divisor",
@@ -156,8 +157,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_alpha_beta,
-		.extra1		= &rto_beta_min,
-		.extra2		= &rto_beta_max,
+		.min		= 0,
+		.max		= 1000,
 	},
 	{
 		.procname	= "max_burst",
@@ -165,8 +166,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "cookie_preserve_enable",
@@ -188,8 +189,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
+		.min		= 1,
+		.max		= 86400000
 	},
 	{
 		.procname	= "sack_timeout",
@@ -197,8 +198,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &sack_timer_min,
-		.extra2         = &sack_timer_max,
+		.min		= 1,
+		.max		= 500,
 	},
 	{
 		.procname	= "hb_interval",
@@ -206,8 +207,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
+		.min		= 1,
+		.max		= 86400000
 	},
 	{
 		.procname	= "association_max_retrans",
@@ -215,8 +216,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "path_max_retrans",
@@ -224,8 +225,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "max_init_retransmits",
@@ -233,8 +234,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "sndbuf_policy",
@@ -319,8 +320,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_udp_port,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_port_max,
+		.min		= 0,
+		.max		= 65535,
 	},
 	{
 		.procname	= "encap_port",
@@ -328,8 +329,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_port_max,
+		.min		= 0,
+		.max		= 65535,
 	},
 	{
 		.procname	= "addr_scope_policy",
@@ -337,8 +338,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &addr_scope_max,
+		.min		= 0,
+		.max		= SCTP_SCOPE_POLICY_MAX,
 	},
 	{
 		.procname	= "rwnd_update_shift",
@@ -346,8 +347,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &rwnd_scale_max,
+		.min		= 1,
+		.max		= 16,
 	},
 	{
 		.procname	= "max_autoclose",
@@ -355,8 +356,9 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
-		.extra1		= &max_autoclose_min,
-		.extra2		= &max_autoclose_max,
+		.min		= 0,
+		.max		= (MAX_SCHEDULE_TIMEOUT / HZ > UINT_MAX)
+				  ? UINT_MAX : MAX_SCHEDULE_TIMEOUT / HZ,
 	},
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	{
@@ -365,8 +367,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	{
@@ -382,8 +384,8 @@ static const struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &pf_expose_max,
+		.min		= 0,
+		.max		= SCTP_PF_EXPOSE_MAX,
 	},
 };
 
@@ -426,8 +428,8 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
-	unsigned int min = *(unsigned int *) ctl->extra1;
-	unsigned int max = *(unsigned int *) ctl->extra2;
+	unsigned int min = ctl->min;
+	unsigned int max = READ_ONCE(net->sctp.rto_max);
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -454,8 +456,8 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
-	unsigned int min = *(unsigned int *) ctl->extra1;
-	unsigned int max = *(unsigned int *) ctl->extra2;
+	unsigned int min = READ_ONCE(net->sctp.rto_min);
+	unsigned int max = ctl->max;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -523,8 +525,8 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.udp_port);
-	unsigned int min = *(unsigned int *)ctl->extra1;
-	unsigned int max = *(unsigned int *)ctl->extra2;
+	unsigned int min = ctl->min;
+	unsigned int max = ctl->max;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -602,11 +604,6 @@ int sctp_sysctl_net_register(struct net *net)
 	for (i = 0; i < table_size; i++)
 		table[i].data += (char *)(&net->sctp) - (char *)&init_net.sctp;
 
-	table[SCTP_RTO_MIN_IDX].extra2 = &net->sctp.rto_max;
-	table[SCTP_RTO_MAX_IDX].extra1 = &net->sctp.rto_min;
-	table[SCTP_PF_RETRANS_IDX].extra2 = &net->sctp.ps_retrans;
-	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
-
 	net->sctp.sysctl_header = register_net_sysctl_sz(net, "net/sctp",
 							 table, table_size);
 	if (net->sctp.sysctl_header == NULL) {
-- 
2.25.1

