Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205440;
	b=bdqjWWLj6t1UjEvRYXO57Qnbktv//WbB10QWtiTspaCTX4jbKRRT/T4NjGA0mWvcOF3u
	 nO3mfTyeOLMOyqmS5NqIXYsjUxfQVgvd9QeFw342KNkHMklCL6OhVVi/AFh9brfVTRW+N
	 4yuFmeW3rmJWyglzaCVX2drVuogtdTPhJfc5wlv1V5n4vykjneCg5K5XlGA1NDx6pdzc0
	 937WM5ZdlfWUEKO5O6t7hNkZyDcRHG8QE0B+K1ponSqBV/B10h/QlcU+fvGWn+J4WQA+Y
	 FrcRt26a92A5b1/qTjmKa8kIIu99SeWW+7F/D++opTNCryti2w0FF2Xq/HEPRu5dCpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205440;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kh+vHNkri+QbxLJLxaBn+d7Y1wzAI4tdCDpnfVumtDM=;
	b=JdhDJl+V7eQ3buNpjUjMpVgE/8RmAyqfrr3VGYq71YoGd7YNooKRLNFtv6q8FwaAeSgd
	 iA2nwoT8mFqP6wtLjCFiNJh0HsHfps5o+eU2Oi9gZ8y1OepWlNi0JHj/GJpdlOxKf+mo1
	 k8vyaPIQndlB+ewkboIVELr0cvBfNcMk3+hwbgKEtz76gUQvFUZTt6PB/pK7hcZP5Qf/j
	 WRw/NxmumsA9SSjdZErGHlKFGB2qTFvx5fx2uFA3codQGlfaFm0q4eNn2wA3Jwz5Z28+f
	 RwEr3wwy14At5WNbdRnpWv4c2QmxKcZI+NzerdTNk/gsqEXEua62OUQFZpv+Ln6ajog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wUQQr3KL;
	arc=none smtp.remote-ip=95.215.58.42
Received: from mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1D60A2618
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B1D60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wUQQr3KL
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D1vdFsqxOOq7Wna1/I+YI4De5ZjxZOC5MEVqRI/ZwEQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205437; v=1; x=1793810237;
 b=wUQQr3KL+56YWEqYQqIfJcdSdQNcP8keMU+EEyuLdb1y4guHt9sBdpZCUZRMTEfZUwp5r4ua
 1zirkcKAu+Jyxu5PjUcmI4dN5PUoz/UTEQaqFtPTpeIaUvKF9lNiS2E9cpa9AYP/4dhvmgXLG3F
 K6T4DxlMQLeAYqH6M97vmWKs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 664d1e8e8c6eab8e;
	Wed, 28 Oct 2026 16:37:17 +0000
X-Mizu-Trace-ID: 664d1e8e8c6eab8e
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/39] sysctl: store remaining network sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:56 +0800
Message-Id: <94c09cca56e615ae216c75fc12582135d567d270.1793204511.git.wen.yang@linux.dev>
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

Replace remaining network bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/mptcp/ctrl.c         | 32 ++++++++++++-------------
 net/rds/ib_sysctl.c      | 24 ++++++++-----------
 net/rxrpc/sysctl.c       | 51 ++++++++++++++++------------------------
 net/smc/smc_sysctl.c     | 42 +++++++++++++--------------------
 net/tipc/sysctl.c        | 17 ++++++++------
 net/vmw_vsock/af_vsock.c |  4 ++--
 net/x25/sysctl_net_x25.c | 23 ++++++++----------
 7 files changed, 84 insertions(+), 109 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index e5a5995c5753..eb826a9b75da 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -20,7 +20,6 @@
 static int mptcp_pernet_id;
 
 #ifdef CONFIG_SYSCTL
-static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
 #endif
 
 struct mptcp_pernet {
@@ -288,8 +287,8 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		 * value, same as other sysctl or the 'net' tree.
 		 */
 		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
+		.min          = 0,
+		.max          = 1
 	},
 	{
 		.procname = "add_addr_timeout",
@@ -302,32 +301,32 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.maxlen = sizeof(u8),
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
+		.min          = 0,
+		.max          = 1
 	},
 	{
 		.procname = "allow_join_initial_addr_port",
 		.maxlen = sizeof(u8),
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
+		.min          = 0,
+		.max          = 1
 	},
 	{
 		.procname = "stale_loss_cnt",
 		.maxlen = sizeof(unsigned int),
 		.mode = 0644,
 		.proc_handler = proc_douintvec_minmax,
-		.min = 0,
-		.max = UINT_MAX,
+		.min          = 0,
+		.max          = UINT_MAX,
 	},
 	{
 		.procname = "pm_type",
 		.maxlen = sizeof(u8),
 		.mode = 0644,
 		.proc_handler = proc_pm_type,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = &mptcp_pm_type_max
+		.min          = 0,
+		.max          = __MPTCP_PM_TYPE_MAX
 	},
 	{
 		.procname = "scheduler",
@@ -352,15 +351,16 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.maxlen = sizeof(unsigned int),
 		.mode = 0644,
 		.proc_handler = proc_blackhole_detect_timeout,
-		.extra1 = SYSCTL_ZERO,
+		.min          = 0,
+		.max          = INT_MAX,
 	},
 	{
 		.procname = "syn_retrans_before_tcp_fallback",
 		.maxlen = sizeof(u8),
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
-		.min = 0,
-		.max = U8_MAX,
+		.min          = 0,
+		.max          = U8_MAX,
 	},
 	{
 		.procname = "path_manager",
@@ -379,8 +379,8 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.maxlen = sizeof(u8),
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = SYSCTL_ONE
+		.min          = 0,
+		.max          = 1
 	},
 };
 
diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index b7757f31001c..3b81e686123a 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -42,13 +42,7 @@ static struct ctl_table_header *rds_ib_sysctl_hdr;
 unsigned long rds_ib_sysctl_max_send_wr = RDS_IB_DEFAULT_SEND_WR;
 unsigned long rds_ib_sysctl_max_recv_wr = RDS_IB_DEFAULT_RECV_WR;
 unsigned long rds_ib_sysctl_max_recv_allocation = (128 * 1024 * 1024) / RDS_FRAG_SIZE;
-static unsigned long rds_ib_sysctl_max_wr_min = 1;
-/* hardware will fail CQ creation long before this */
-static unsigned long rds_ib_sysctl_max_wr_max = (u32)~0;
-
 unsigned long rds_ib_sysctl_max_unsig_wrs = 16;
-static unsigned long rds_ib_sysctl_max_unsig_wr_min = 1;
-static unsigned long rds_ib_sysctl_max_unsig_wr_max = 64;
 
 /*
  * This sysctl does nothing.
@@ -69,8 +63,9 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
-		.extra1		= &rds_ib_sysctl_max_wr_min,
-		.extra2		= &rds_ib_sysctl_max_wr_max,
+		.min		= 1,
+		/* Hardware will fail CQ creation long before this. */
+		.max		= (u32)~0,
 	},
 	{
 		.procname       = "max_recv_wr",
@@ -78,8 +73,9 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
-		.extra1		= &rds_ib_sysctl_max_wr_min,
-		.extra2		= &rds_ib_sysctl_max_wr_max,
+		.min		= 1,
+		/* Hardware will fail CQ creation long before this. */
+		.max		= (u32)~0,
 	},
 	{
 		.procname       = "max_unsignaled_wr",
@@ -87,8 +83,8 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
-		.extra1		= &rds_ib_sysctl_max_unsig_wr_min,
-		.extra2		= &rds_ib_sysctl_max_unsig_wr_max,
+		.min		= 1,
+		.max		= 64,
 	},
 	{
 		.procname       = "max_recv_allocation",
@@ -96,8 +92,8 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
-		.min           = 0,
-		.max           = ULONG_MAX,
+		.min            = 0,
+		.max            = ULONG_MAX,
 	},
 	{
 		.procname	= "flow_control",
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index 46a20cf4c402..ceac11eb1d97 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -11,18 +11,7 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
-static const unsigned int rxrpc_rx_mtu_min = 500;
-static const unsigned int rxrpc_jumbo_max = RXRPC_MAX_NR_JUMBO;
-static const unsigned int four = 4;
-static const unsigned int max_backlog = RXRPC_BACKLOG_MAX - 1;
-static const unsigned int n_65535 = 65535;
-static const unsigned int n_max_acks = 255;
-static const unsigned long one_ms = 1;
-static const unsigned long max_ms = 1000;
-static const unsigned long one_jiffy = 1;
-static const unsigned long max_jiffies = MAX_JIFFY_OFFSET;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
-static const unsigned long max_500 = 500;
 #endif
 
 /*
@@ -39,8 +28,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (void *)&one_ms,
-		.extra2		= (void *)&max_ms,
+		.min		= 1,
+		.max		= 1000,
 	},
 	{
 		.procname	= "idle_ack_delay",
@@ -48,8 +37,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (void *)&one_ms,
-		.extra2		= (void *)&max_ms,
+		.min		= 1,
+		.max		= 1000,
 	},
 	{
 		.procname	= "idle_conn_expiry",
@@ -57,8 +46,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
+		.min		= 1,
+		.max		= MAX_JIFFY_OFFSET,
 	},
 	{
 		.procname	= "idle_conn_fast_expiry",
@@ -66,8 +55,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
+		.min		= 1,
+		.max		= MAX_JIFFY_OFFSET,
 	},
 
 	/* Values used in milliseconds */
@@ -78,8 +67,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (void *)SYSCTL_LONG_ZERO,
-		.extra2		= (void *)&max_500,
+		.min		= 0,
+		.max		= 500,
 	},
 #endif
 
@@ -90,8 +79,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_65535,
+		.min		= 1,
+		.max		= 65535,
 	},
 	{
 		.procname	= "max_backlog",
@@ -99,8 +88,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&four,
-		.extra2		= (void *)&max_backlog,
+		.min		= 4,
+		.max		= RXRPC_BACKLOG_MAX - 1,
 	},
 	{
 		.procname	= "rx_window_size",
@@ -108,8 +97,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_max_acks,
+		.min		= 1,
+		.max		= 255,
 	},
 	{
 		.procname	= "rx_mtu",
@@ -117,8 +106,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&rxrpc_rx_mtu_min,
-		.extra2		= (void *)&n_65535,
+		.min		= 500,
+		.max		= 65535,
 	},
 	{
 		.procname	= "rx_jumbo_max",
@@ -126,8 +115,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&rxrpc_jumbo_max,
+		.min		= 1,
+		.max		= RXRPC_MAX_NR_JUMBO,
 	},
 };
 
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 09dad48337f6..2baa974496c4 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -21,18 +21,8 @@
 #include "smc_sysctl.h"
 #include "smc_hs_bpf.h"
 
-static int min_sndbuf = SMC_BUF_MIN_SIZE;
-static int min_rcvbuf = SMC_BUF_MIN_SIZE;
-static int max_sndbuf = INT_MAX / 2;
-static int max_rcvbuf = INT_MAX / 2;
 static const int net_smc_wmem_init = (64 * 1024);
 static const int net_smc_rmem_init = (64 * 1024);
-static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
-static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
-static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
-static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
-static unsigned int smcr_max_wr_min = 2;
-static unsigned int smcr_max_wr_max = 2048;
 
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
 static int smc_net_replace_smc_hs_ctrl(struct net *net, const char *name)
@@ -111,8 +101,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "smcr_testlink_time",
@@ -127,8 +117,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
-		.extra2		= &max_sndbuf,
+		.min		= SMC_BUF_MIN_SIZE,
+		.max		= INT_MAX / 2,
 	},
 	{
 		.procname	= "rmem",
@@ -136,8 +126,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
-		.extra2		= &max_rcvbuf,
+		.min		= SMC_BUF_MIN_SIZE,
+		.max		= INT_MAX / 2,
 	},
 	{
 		.procname	= "smcr_max_links_per_lgr",
@@ -145,8 +135,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &links_per_lgr_min,
-		.extra2		= &links_per_lgr_max,
+		.min		= SMC_LINKS_ADD_LNK_MIN,
+		.max		= SMC_LINKS_ADD_LNK_MAX,
 	},
 	{
 		.procname	= "smcr_max_conns_per_lgr",
@@ -154,8 +144,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &conns_per_lgr_min,
-		.extra2		= &conns_per_lgr_max,
+		.min		= SMC_CONN_PER_LGR_MIN,
+		.max		= SMC_CONN_PER_LGR_MAX,
 	},
 	{
 		.procname	= "limit_smc_hs",
@@ -163,8 +153,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "smcr_max_send_wr",
@@ -172,8 +162,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &smcr_max_wr_min,
-		.extra2		= &smcr_max_wr_max,
+		.min		= 2,
+		.max		= 2048,
 	},
 	{
 		.procname	= "smcr_max_recv_wr",
@@ -181,8 +171,8 @@ static const struct ctl_table smc_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &smcr_max_wr_min,
-		.extra2		= &smcr_max_wr_max,
+		.min		= 2,
+		.max		= 2048,
 	},
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
 	{
diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index 8352c790c8fe..446fb7d188bb 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -49,7 +49,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "named_timeout",
@@ -57,7 +58,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_named_timeout),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname       = "sk_filter",
@@ -65,8 +67,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen         = sizeof(sysctl_tipc_sk_filter),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
-		.min           = 0,
-		.max           = ULONG_MAX,
+		.min            = 0,
+		.max            = ULONG_MAX,
 	},
 #ifdef CONFIG_TIPC_CRYPTO
 	{
@@ -75,7 +77,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_max_tfms),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "key_exchange_enabled",
@@ -83,8 +86,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_key_exchange_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	{
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..f7c90c82c490 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -3038,8 +3038,8 @@ static const struct ctl_table vsock_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index 643f50874dfe..e5399a66d8d7 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -13,9 +13,6 @@
 #include <linux/init.h>
 #include <net/x25.h>
 
-static int min_timer[] = {   1 * HZ };
-static int max_timer[] = { 300 * HZ };
-
 static struct ctl_table_header *x25_table_header;
 
 static struct ctl_table x25_table[] = {
@@ -25,8 +22,8 @@ static struct ctl_table x25_table[] = {
 		.maxlen =	sizeof(int),
 		.mode =		0644,
 		.proc_handler =	proc_dointvec_minmax,
-		.extra1 =	&min_timer,
-		.extra2 =	&max_timer,
+		.min          =	HZ,
+		.max          =	300 * HZ,
 	},
 	{
 		.procname =	"call_request_timeout",
@@ -34,8 +31,8 @@ static struct ctl_table x25_table[] = {
 		.maxlen =	sizeof(int),
 		.mode =		0644,
 		.proc_handler =	proc_dointvec_minmax,
-		.extra1 =	&min_timer,
-		.extra2 =	&max_timer,
+		.min          =	HZ,
+		.max          =	300 * HZ,
 	},
 	{
 		.procname =	"reset_request_timeout",
@@ -43,8 +40,8 @@ static struct ctl_table x25_table[] = {
 		.maxlen =	sizeof(int),
 		.mode =		0644,
 		.proc_handler =	proc_dointvec_minmax,
-		.extra1 =	&min_timer,
-		.extra2 =	&max_timer,
+		.min          =	HZ,
+		.max          =	300 * HZ,
 	},
 	{
 		.procname =	"clear_request_timeout",
@@ -52,8 +49,8 @@ static struct ctl_table x25_table[] = {
 		.maxlen =	sizeof(int),
 		.mode =		0644,
 		.proc_handler =	proc_dointvec_minmax,
-		.extra1 =	&min_timer,
-		.extra2 =	&max_timer,
+		.min          =	HZ,
+		.max          =	300 * HZ,
 	},
 	{
 		.procname =	"acknowledgement_hold_back_timeout",
@@ -61,8 +58,8 @@ static struct ctl_table x25_table[] = {
 		.maxlen =	sizeof(int),
 		.mode =		0644,
 		.proc_handler =	proc_dointvec_minmax,
-		.extra1 =	&min_timer,
-		.extra2 =	&max_timer,
+		.min          =	HZ,
+		.max          =	300 * HZ,
 	},
 	{
 		.procname =	"x25_forward",
-- 
2.25.1

