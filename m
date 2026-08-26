Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269147F780;
	Wed, 26 Aug 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773457; cv=none; b=epErsUc3BsLt78kaR4Xteg0GTQ2ExSzo2xC2lL3kedvnhPjkBzAnwfW5Q0rnVNSBaTVZEDZHOUlnOn7k61jPcBCtlvF0bSrQX1W0644V+pWFU69n5i7CAL736TTphoC/nXh+RAAQbc9Qasxk/cX5TiQ77i+g2FS6mDyLPmY+4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773457; c=relaxed/simple;
	bh=d2so68bVIFipyZBeMw3JC9oX/ShWngDiL4JFDyef8Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQU4WLBD/ct3JDRcybM0HTnOLp02jLxhg/oOolfMpPmKQrqTjuxf6FmoQ0uIbX81Fij+Q8eKwqBsCxV+pdXzMmxzJIyB+/G7mBiKqM6EyRpoZF+9Q2OHTmqL6ImT7ZHhCwwii3gwBsExVN3FOzf11u+WNhipGVr6xKh8fImQKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogcw2IQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogcw2IQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D41F00A3E;
	Wed, 26 Aug 2026 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773434;
	bh=3dCeakxEj/kXFpogCWdAdAy9o7EXGFafsnftz97Z6Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ogcw2IQCG7qqIeM46vJNq9XzzrOlidnvdayABX836359DEF0umYBJx3DQCCx2eT2m
	 9Teck5v/Z1IQrDPy0nLx8r4n0aN1ogdWdpzCGkcWTUl2hNv2FE77d7ErkxGhwuYdvV
	 IkN5r2sHcLE3ES3QP/BKAgG188gG10aoN6LInGzOsGw79vKFB8zerEiJysYzijXrzN
	 rNzkzgbXqPaZJpMQObuegkwisyQ2D785OFlC+Y1lTbp6Nu/0SyP8EHBcRJtVCp0iyA
	 h2bWz1gMzrK/YpZttGtG1nIXJrSqYedZ7MkCUp/Tu9YrCsTOdCzNz8d5WC41MOyteG
	 FXwzPdDbXtxaA==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 23/30] sysctl: netfilter: use sysctl_field for per-net sysctls
Date: Wed, 26 Aug 2026 21:42:27 +0200
Message-ID: <fc1e677be34bdae3592a0b806986048405dfdc79.1787771905.git.legion@kernel.org>
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

Netfilter still clones several sysctl tables for each network namespace
so the registration code can patch data pointers, modes, and namespace
context into the copied ctl_table entries. This keeps the tables
writable and ties the setup code to the exact table layout.

Use sysctl_field for the per-net conntrack, nf_log, and lwtunnel sysctls
instead. The table descriptions can stay static and const while the
effective ctl_table entries are derived from the registration context.

This removes the per-net table copies and the unregister-time frees, and
avoids the conntrack index patch-up helpers that had to stay in sync
with the ctl_table layout.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/netfilter/nf_conntrack_standalone.c | 743 ++++++++++--------------
 net/netfilter/nf_hooks_lwtunnel.c       |  40 +-
 net/netfilter/nf_log.c                  |  90 +--
 3 files changed, 369 insertions(+), 504 deletions(-)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index be2953c7d702..94a5353fcb93 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -581,345 +581,344 @@ nf_conntrack_log_invalid_sysctl(const struct ctl_table *table, int write,
 }
 
 static struct ctl_table_header *nf_ct_netfilter_header;
+static unsigned int nf_ct_max_limit = INT_MAX;
+
+static umode_t nf_ct_global_sysctl_mode(const struct sysctl_context *ctx)
+{
+	return net_eq(ctx->ns.net_ns, &init_net) ? 0644 : 0444;
+}
+
+static unsigned int *nf_ct_max_data(const struct sysctl_context *ctx)
+{
+	return &nf_conntrack_max;
+}
+
+static void *nf_ct_count_data(const struct sysctl_context *ctx)
+{
+	struct nf_conntrack_net *cnet = nf_ct_pernet(ctx->ns.net_ns);
+
+	return &cnet->count;
+}
+
+static void *nf_ct_buckets_data(const struct sysctl_context *ctx)
+{
+	return &nf_conntrack_htable_size_user;
+}
+
+static u8 *nf_ct_checksum_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ct.sysctl_checksum;
+}
+
+static void *nf_ct_log_invalid_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ct.sysctl_log_invalid;
+}
+
+static unsigned int *nf_ct_expect_max_data(const struct sysctl_context *ctx)
+{
+	return &nf_ct_expect_max;
+}
+
+static u8 *nf_ct_acct_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ct.sysctl_acct;
+}
 
-enum nf_ct_sysctl_index {
-	NF_SYSCTL_CT_MAX,
-	NF_SYSCTL_CT_COUNT,
-	NF_SYSCTL_CT_BUCKETS,
-	NF_SYSCTL_CT_CHECKSUM,
-	NF_SYSCTL_CT_LOG_INVALID,
-	NF_SYSCTL_CT_EXPECT_MAX,
-	NF_SYSCTL_CT_ACCT,
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-	NF_SYSCTL_CT_EVENTS,
+static u8 *nf_ct_events_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ct.sysctl_events;
+}
 #endif
+
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
-	NF_SYSCTL_CT_TIMESTAMP,
+static u8 *nf_ct_timestamp_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ct.sysctl_tstamp;
+}
 #endif
-	NF_SYSCTL_CT_PROTO_TIMEOUT_GENERIC,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_SYN_SENT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_SYN_RECV,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_ESTABLISHED,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_FIN_WAIT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_CLOSE_WAIT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_LAST_ACK,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_TIME_WAIT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_CLOSE,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_RETRANS,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_UNACK,
+
+static void *nf_ct_generic_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_generic_pernet(ctx->ns.net_ns)->timeout;
+}
+
+#define NF_CT_TCP_TIMEOUT_DATA(name, state)				\
+static void *nf_ct_tcp_timeout_ ## name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	struct nf_tcp_net *tn = nf_tcp_pernet(ctx->ns.net_ns);		\
+	return &tn->timeouts[TCP_CONNTRACK_ ## state];			\
+}
+
+NF_CT_TCP_TIMEOUT_DATA(syn_sent, SYN_SENT)
+NF_CT_TCP_TIMEOUT_DATA(syn_recv, SYN_RECV)
+NF_CT_TCP_TIMEOUT_DATA(established, ESTABLISHED)
+NF_CT_TCP_TIMEOUT_DATA(fin_wait, FIN_WAIT)
+NF_CT_TCP_TIMEOUT_DATA(close_wait, CLOSE_WAIT)
+NF_CT_TCP_TIMEOUT_DATA(last_ack, LAST_ACK)
+NF_CT_TCP_TIMEOUT_DATA(time_wait, TIME_WAIT)
+NF_CT_TCP_TIMEOUT_DATA(close, CLOSE)
+NF_CT_TCP_TIMEOUT_DATA(retrans, RETRANS)
+NF_CT_TCP_TIMEOUT_DATA(unack, UNACK)
+#undef NF_CT_TCP_TIMEOUT_DATA
+
 #if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
-	NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_OFFLOAD,
+static void *nf_ct_tcp_offload_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_tcp_pernet(ctx->ns.net_ns)->offload_timeout;
+}
 #endif
-	NF_SYSCTL_CT_PROTO_TCP_LOOSE,
-	NF_SYSCTL_CT_PROTO_TCP_LIBERAL,
-	NF_SYSCTL_CT_PROTO_TCP_IGNORE_INVALID_RST,
-	NF_SYSCTL_CT_PROTO_TCP_MAX_RETRANS,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_UDP,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_UDP_STREAM,
+
+#define NF_CT_TCP_U8_DATA(name, field)					\
+static u8 *nf_ct_tcp_ ## name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &nf_tcp_pernet(ctx->ns.net_ns)->field;			\
+}
+
+NF_CT_TCP_U8_DATA(loose, tcp_loose)
+NF_CT_TCP_U8_DATA(liberal, tcp_be_liberal)
+NF_CT_TCP_U8_DATA(ignore_invalid_rst, tcp_ignore_invalid_rst)
+NF_CT_TCP_U8_DATA(max_retrans, tcp_max_retrans)
+#undef NF_CT_TCP_U8_DATA
+
+static void *nf_ct_udp_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_udp_pernet(ctx->ns.net_ns)->timeouts[UDP_CT_UNREPLIED];
+}
+
+static void *nf_ct_udp_stream_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_udp_pernet(ctx->ns.net_ns)->timeouts[UDP_CT_REPLIED];
+}
+
 #if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
-	NF_SYSCTL_CT_PROTO_TIMEOUT_UDP_OFFLOAD,
+static void *nf_ct_udp_offload_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_udp_pernet(ctx->ns.net_ns)->offload_timeout;
+}
 #endif
-	NF_SYSCTL_CT_PROTO_TIMEOUT_ICMP,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_ICMPV6,
+
+static void *nf_ct_icmp_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_icmp_pernet(ctx->ns.net_ns)->timeout;
+}
+
+static void *nf_ct_icmpv6_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_icmpv6_pernet(ctx->ns.net_ns)->timeout;
+}
+
 #ifdef CONFIG_NF_CT_PROTO_SCTP
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_CLOSED,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_COOKIE_WAIT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_COOKIE_ECHOED,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_ESTABLISHED,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_SENT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_RECD,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_ACK_SENT,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_HEARTBEAT_SENT,
+#define NF_CT_SCTP_TIMEOUT_DATA(name, state)				\
+static void *nf_ct_sctp_timeout_ ## name ## _data(const struct sysctl_context *ctx) \
+{									\
+	struct nf_sctp_net *sn = nf_sctp_pernet(ctx->ns.net_ns);	\
+	return &sn->timeouts[SCTP_CONNTRACK_ ## state];			\
+}
+
+NF_CT_SCTP_TIMEOUT_DATA(closed, CLOSED)
+NF_CT_SCTP_TIMEOUT_DATA(cookie_wait, COOKIE_WAIT)
+NF_CT_SCTP_TIMEOUT_DATA(cookie_echoed, COOKIE_ECHOED)
+NF_CT_SCTP_TIMEOUT_DATA(established, ESTABLISHED)
+NF_CT_SCTP_TIMEOUT_DATA(shutdown_sent, SHUTDOWN_SENT)
+NF_CT_SCTP_TIMEOUT_DATA(shutdown_recd, SHUTDOWN_RECD)
+NF_CT_SCTP_TIMEOUT_DATA(shutdown_ack_sent, SHUTDOWN_ACK_SENT)
+NF_CT_SCTP_TIMEOUT_DATA(heartbeat_sent, HEARTBEAT_SENT)
+#undef NF_CT_SCTP_TIMEOUT_DATA
 #endif
+
 #ifdef CONFIG_NF_CT_PROTO_GRE
-	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM,
+static void *nf_ct_gre_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_gre_pernet(ctx->ns.net_ns)->timeouts[GRE_CT_UNREPLIED];
+}
+
+static void *nf_ct_gre_stream_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_gre_pernet(ctx->ns.net_ns)->timeouts[GRE_CT_REPLIED];
+}
 #endif
 
-	NF_SYSCTL_CT_LAST_SYSCTL,
-};
+#define NF_CT_GLOBAL_UINT_MINMAX(_procname, _data)			\
+	{								\
+		.procname	= (_procname),				\
+		.mode		= 0644,					\
+		.mode_fn	= nf_ct_global_sysctl_mode,		\
+		.type		= SYSCTL_FIELD_STATIC_UINT_MINMAX,		\
+		.ctl_static_uint = {					\
+			.data		= (_data),			\
+			.min_value	= SYSCTL_UINT_ONE,		\
+			.max_value	= &nf_ct_max_limit,		\
+		},							\
+	}
 
-static struct ctl_table nf_ct_sysctl_table[] = {
-	[NF_SYSCTL_CT_MAX] = {
-		.procname	= "nf_conntrack_max",
-		.data		= &nf_conntrack_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	[NF_SYSCTL_CT_COUNT] = {
-		.procname	= "nf_conntrack_count",
-		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
-	[NF_SYSCTL_CT_BUCKETS] = {
-		.procname       = "nf_conntrack_buckets",
-		.data           = &nf_conntrack_htable_size_user,
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler   = nf_conntrack_hash_sysctl,
-	},
-	[NF_SYSCTL_CT_CHECKSUM] = {
-		.procname	= "nf_conntrack_checksum",
-		.data		= &init_net.ct.sysctl_checksum,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
-	},
-	[NF_SYSCTL_CT_LOG_INVALID] = {
-		.procname	= "nf_conntrack_log_invalid",
-		.data		= &init_net.ct.sysctl_log_invalid,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= nf_conntrack_log_invalid_sysctl,
-	},
-	[NF_SYSCTL_CT_EXPECT_MAX] = {
-		.procname	= "nf_conntrack_expect_max",
-		.data		= &nf_ct_expect_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	[NF_SYSCTL_CT_ACCT] = {
-		.procname	= "nf_conntrack_acct",
-		.data		= &init_net.ct.sysctl_acct,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
-	},
+static const struct sysctl_field nf_ct_sysctl_table[] = {
+	NF_CT_GLOBAL_UINT_MINMAX("nf_conntrack_max", nf_ct_max_data),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_count", 0444, sizeof(int),
+			 nf_ct_count_data, proc_dointvec),
+	SYSCTL_FIELD_CUSTOM_MODE("nf_conntrack_buckets", 0644,
+			      nf_ct_global_sysctl_mode,
+			      sizeof(unsigned int),
+			      nf_ct_buckets_data,
+			      nf_conntrack_hash_sysctl),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_checksum", 0644,
+				   nf_ct_checksum_data, SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_log_invalid", 0644, sizeof(u8),
+			 nf_ct_log_invalid_data,
+			 nf_conntrack_log_invalid_sysctl),
+	NF_CT_GLOBAL_UINT_MINMAX("nf_conntrack_expect_max",
+				 nf_ct_expect_max_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_acct", 0644,
+				   nf_ct_acct_data, SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_ONE),
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-	[NF_SYSCTL_CT_EVENTS] = {
-		.procname	= "nf_conntrack_events",
-		.data		= &init_net.ct.sysctl_events,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_events", 0644,
+				   nf_ct_events_data, SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_TWO),
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
-	[NF_SYSCTL_CT_TIMESTAMP] = {
-		.procname	= "nf_conntrack_timestamp",
-		.data		= &init_net.ct.sysctl_tstamp,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
-	},
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_timestamp", 0644,
+				   nf_ct_timestamp_data,
+				   SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_ONE),
 #endif
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_GENERIC] = {
-		.procname	= "nf_conntrack_generic_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_SYN_SENT] = {
-		.procname	= "nf_conntrack_tcp_timeout_syn_sent",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_SYN_RECV] = {
-		.procname	= "nf_conntrack_tcp_timeout_syn_recv",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_ESTABLISHED] = {
-		.procname	= "nf_conntrack_tcp_timeout_established",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_FIN_WAIT] = {
-		.procname	= "nf_conntrack_tcp_timeout_fin_wait",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_CLOSE_WAIT] = {
-		.procname	= "nf_conntrack_tcp_timeout_close_wait",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_LAST_ACK] = {
-		.procname	= "nf_conntrack_tcp_timeout_last_ack",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_TIME_WAIT] = {
-		.procname	= "nf_conntrack_tcp_timeout_time_wait",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_CLOSE] = {
-		.procname	= "nf_conntrack_tcp_timeout_close",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_RETRANS] = {
-		.procname	= "nf_conntrack_tcp_timeout_max_retrans",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_UNACK] = {
-		.procname	= "nf_conntrack_tcp_timeout_unacknowledged",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_generic_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_generic_timeout_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_syn_sent", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_syn_sent_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_syn_recv", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_syn_recv_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_established", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_established_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_fin_wait", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_fin_wait_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_close_wait", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_close_wait_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_last_ack", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_last_ack_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_time_wait", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_time_wait_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_close", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_close_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_max_retrans", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_retrans_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_tcp_timeout_unacknowledged", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_timeout_unack_data,
+			 proc_dointvec_jiffies),
 #if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_OFFLOAD] = {
-		.procname	= "nf_flowtable_tcp_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_CUSTOM("nf_flowtable_tcp_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_tcp_offload_timeout_data,
+			 proc_dointvec_jiffies),
 #endif
-	[NF_SYSCTL_CT_PROTO_TCP_LOOSE] = {
-		.procname	= "nf_conntrack_tcp_loose",
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
-	},
-	[NF_SYSCTL_CT_PROTO_TCP_LIBERAL] = {
-		.procname       = "nf_conntrack_tcp_be_liberal",
-		.maxlen		= sizeof(u8),
-		.mode           = 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
-	},
-	[NF_SYSCTL_CT_PROTO_TCP_IGNORE_INVALID_RST] = {
-		.procname	= "nf_conntrack_tcp_ignore_invalid_rst",
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	[NF_SYSCTL_CT_PROTO_TCP_MAX_RETRANS] = {
-		.procname	= "nf_conntrack_tcp_max_retrans",
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP] = {
-		.procname	= "nf_conntrack_udp_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP_STREAM] = {
-		.procname	= "nf_conntrack_udp_timeout_stream",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_tcp_loose", 0644,
+				   nf_ct_tcp_loose_data,
+				   SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_tcp_be_liberal",
+				   0644, nf_ct_tcp_liberal_data,
+				   SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nf_conntrack_tcp_ignore_invalid_rst",
+				   0644,
+				   nf_ct_tcp_ignore_invalid_rst_data,
+				   SYSCTL_UINT_ZERO,
+				   SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_U8("nf_conntrack_tcp_max_retrans", 0644,
+			     nf_ct_tcp_max_retrans_data),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_udp_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_udp_timeout_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_udp_timeout_stream", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_udp_stream_timeout_data,
+			 proc_dointvec_jiffies),
 #if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP_OFFLOAD] = {
-		.procname	= "nf_flowtable_udp_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_CUSTOM("nf_flowtable_udp_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_udp_offload_timeout_data,
+			 proc_dointvec_jiffies),
 #endif
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_ICMP] = {
-		.procname	= "nf_conntrack_icmp_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_ICMPV6] = {
-		.procname	= "nf_conntrack_icmpv6_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_icmp_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_icmp_timeout_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_icmpv6_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_icmpv6_timeout_data,
+			 proc_dointvec_jiffies),
 #ifdef CONFIG_NF_CT_PROTO_SCTP
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_CLOSED] = {
-		.procname	= "nf_conntrack_sctp_timeout_closed",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_COOKIE_WAIT] = {
-		.procname	= "nf_conntrack_sctp_timeout_cookie_wait",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_COOKIE_ECHOED] = {
-		.procname	= "nf_conntrack_sctp_timeout_cookie_echoed",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_ESTABLISHED] = {
-		.procname	= "nf_conntrack_sctp_timeout_established",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_SENT] = {
-		.procname	= "nf_conntrack_sctp_timeout_shutdown_sent",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_RECD] = {
-		.procname	= "nf_conntrack_sctp_timeout_shutdown_recd",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_ACK_SENT] = {
-		.procname	= "nf_conntrack_sctp_timeout_shutdown_ack_sent",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_HEARTBEAT_SENT] = {
-		.procname	= "nf_conntrack_sctp_timeout_heartbeat_sent",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_closed", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_sctp_timeout_closed_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_cookie_wait", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_sctp_timeout_cookie_wait_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_cookie_echoed",
+			 0644, sizeof(unsigned int),
+			 nf_ct_sctp_timeout_cookie_echoed_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_established",
+			 0644, sizeof(unsigned int),
+			 nf_ct_sctp_timeout_established_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_shutdown_sent",
+			 0644, sizeof(unsigned int),
+			 nf_ct_sctp_timeout_shutdown_sent_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_shutdown_recd",
+			 0644, sizeof(unsigned int),
+			 nf_ct_sctp_timeout_shutdown_recd_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_shutdown_ack_sent",
+			 0644, sizeof(unsigned int),
+			 nf_ct_sctp_timeout_shutdown_ack_sent_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_sctp_timeout_heartbeat_sent",
+			 0644, sizeof(unsigned int),
+			 nf_ct_sctp_timeout_heartbeat_sent_data,
+			 proc_dointvec_jiffies),
 #endif
 #ifdef CONFIG_NF_CT_PROTO_GRE
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_GRE] = {
-		.procname       = "nf_conntrack_gre_timeout",
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM] = {
-		.procname       = "nf_conntrack_gre_timeout_stream",
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_jiffies,
-	},
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_gre_timeout", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_gre_timeout_data,
+			 proc_dointvec_jiffies),
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_gre_timeout_stream", 0644,
+			 sizeof(unsigned int),
+			 nf_ct_gre_stream_timeout_data,
+			 proc_dointvec_jiffies),
 #endif
 };
 
+#undef NF_CT_GLOBAL_UINT_MINMAX
+
 static struct ctl_table nf_ct_netfilter_table[] = {
 	{
 		.procname	= "nf_conntrack_max",
@@ -932,138 +931,26 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 	},
 };
 
-static void nf_conntrack_standalone_init_tcp_sysctl(struct net *net,
-						    struct ctl_table *table)
-{
-	struct nf_tcp_net *tn = nf_tcp_pernet(net);
-
-#define XASSIGN(XNAME, tn) \
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_ ## XNAME].data = \
-			&(tn)->timeouts[TCP_CONNTRACK_ ## XNAME]
-
-	XASSIGN(SYN_SENT, tn);
-	XASSIGN(SYN_RECV, tn);
-	XASSIGN(ESTABLISHED, tn);
-	XASSIGN(FIN_WAIT, tn);
-	XASSIGN(CLOSE_WAIT, tn);
-	XASSIGN(LAST_ACK, tn);
-	XASSIGN(TIME_WAIT, tn);
-	XASSIGN(CLOSE, tn);
-	XASSIGN(RETRANS, tn);
-	XASSIGN(UNACK, tn);
-#undef XASSIGN
-#define XASSIGN(XNAME, rval) \
-	table[NF_SYSCTL_CT_PROTO_TCP_ ## XNAME].data = (rval)
-
-	XASSIGN(LOOSE, &tn->tcp_loose);
-	XASSIGN(LIBERAL, &tn->tcp_be_liberal);
-	XASSIGN(MAX_RETRANS, &tn->tcp_max_retrans);
-	XASSIGN(IGNORE_INVALID_RST, &tn->tcp_ignore_invalid_rst);
-#undef XASSIGN
-
-#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_TCP_OFFLOAD].data = &tn->offload_timeout;
-#endif
-
-}
-
-static void nf_conntrack_standalone_init_sctp_sysctl(struct net *net,
-						     struct ctl_table *table)
-{
-#ifdef CONFIG_NF_CT_PROTO_SCTP
-	struct nf_sctp_net *sn = nf_sctp_pernet(net);
-
-#define XASSIGN(XNAME, sn) \
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_ ## XNAME].data = \
-			&(sn)->timeouts[SCTP_CONNTRACK_ ## XNAME]
-
-	XASSIGN(CLOSED, sn);
-	XASSIGN(COOKIE_WAIT, sn);
-	XASSIGN(COOKIE_ECHOED, sn);
-	XASSIGN(ESTABLISHED, sn);
-	XASSIGN(SHUTDOWN_SENT, sn);
-	XASSIGN(SHUTDOWN_RECD, sn);
-	XASSIGN(SHUTDOWN_ACK_SENT, sn);
-	XASSIGN(HEARTBEAT_SENT, sn);
-#undef XASSIGN
-#endif
-}
-
-static void nf_conntrack_standalone_init_gre_sysctl(struct net *net,
-						    struct ctl_table *table)
-{
-#ifdef CONFIG_NF_CT_PROTO_GRE
-	struct nf_gre_net *gn = nf_gre_pernet(net);
-
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_GRE].data = &gn->timeouts[GRE_CT_UNREPLIED];
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM].data = &gn->timeouts[GRE_CT_REPLIED];
-#endif
-}
-
 static int nf_conntrack_standalone_init_sysctl(struct net *net)
 {
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
-	struct nf_udp_net *un = nf_udp_pernet(net);
-	struct ctl_table *table;
-
-	BUILD_BUG_ON(ARRAY_SIZE(nf_ct_sysctl_table) != NF_SYSCTL_CT_LAST_SYSCTL);
-
-	table = kmemdup(nf_ct_sysctl_table, sizeof(nf_ct_sysctl_table),
-			GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
 
-	table[NF_SYSCTL_CT_COUNT].data = &cnet->count;
-	table[NF_SYSCTL_CT_CHECKSUM].data = &net->ct.sysctl_checksum;
-	table[NF_SYSCTL_CT_LOG_INVALID].data = &net->ct.sysctl_log_invalid;
-	table[NF_SYSCTL_CT_ACCT].data = &net->ct.sysctl_acct;
-#ifdef CONFIG_NF_CONNTRACK_EVENTS
-	table[NF_SYSCTL_CT_EVENTS].data = &net->ct.sysctl_events;
-#endif
-#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
-	table[NF_SYSCTL_CT_TIMESTAMP].data = &net->ct.sysctl_tstamp;
-#endif
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_GENERIC].data = &nf_generic_pernet(net)->timeout;
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_ICMP].data = &nf_icmp_pernet(net)->timeout;
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_ICMPV6].data = &nf_icmpv6_pernet(net)->timeout;
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP].data = &un->timeouts[UDP_CT_UNREPLIED];
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP_STREAM].data = &un->timeouts[UDP_CT_REPLIED];
-#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP_OFFLOAD].data = &un->offload_timeout;
-#endif
-
-	nf_conntrack_standalone_init_tcp_sysctl(net, table);
-	nf_conntrack_standalone_init_sctp_sysctl(net, table);
-	nf_conntrack_standalone_init_gre_sysctl(net, table);
-
-	/* Don't allow non-init_net ns to alter global sysctls */
-	if (!net_eq(&init_net, net)) {
-		table[NF_SYSCTL_CT_MAX].mode = 0444;
-		table[NF_SYSCTL_CT_EXPECT_MAX].mode = 0444;
-		table[NF_SYSCTL_CT_BUCKETS].mode = 0444;
-	}
-
-	cnet->sysctl_header = register_net_sysctl_sz(net, "net/netfilter",
-						     table,
-						     ARRAY_SIZE(nf_ct_sysctl_table));
+	cnet->sysctl_header = register_sysctl_fields(&net->sysctls, "net/netfilter",
+						     nf_ct_sysctl_table, &ctx);
 	if (!cnet->sysctl_header)
-		goto out_unregister_netfilter;
+		return -ENOMEM;
 
 	return 0;
-
-out_unregister_netfilter:
-	kfree(table);
-	return -ENOMEM;
 }
 
 static void nf_conntrack_standalone_fini_sysctl(struct net *net)
 {
 	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
-	const struct ctl_table *table;
 
-	table = cnet->sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(cnet->sysctl_header);
-	kfree(table);
 }
 #else
 static int nf_conntrack_standalone_init_sysctl(struct net *net)
diff --git a/net/netfilter/nf_hooks_lwtunnel.c b/net/netfilter/nf_hooks_lwtunnel.c
index 2d890dd04ff8..7c7730dd107c 100644
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -54,53 +54,31 @@ int nf_hooks_lwtunnel_sysctl_handler(const struct ctl_table *table, int write,
 }
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_sysctl_handler);
 
-static struct ctl_table nf_lwtunnel_sysctl_table[] = {
-	{
-		.procname	= "nf_hooks_lwtunnel",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
-	},
+static const struct sysctl_field nf_lwtunnel_sysctl_table[] = {
+	SYSCTL_FIELD_CUSTOM("nf_hooks_lwtunnel", 0644, sizeof(int), NULL,
+			 nf_hooks_lwtunnel_sysctl_handler),
 };
 
 static int __net_init nf_lwtunnel_net_init(struct net *net)
 {
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct ctl_table_header *hdr;
-	struct ctl_table *table;
-
-	table = nf_lwtunnel_sysctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(nf_lwtunnel_sysctl_table,
-				sizeof(nf_lwtunnel_sysctl_table),
-				GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-	}
 
-	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
-				     ARRAY_SIZE(nf_lwtunnel_sysctl_table));
+	hdr = register_sysctl_fields(&net->sysctls, "net/netfilter",
+				     nf_lwtunnel_sysctl_table, &ctx);
 	if (!hdr)
-		goto err_reg;
+		return -ENOMEM;
 
 	net->nf.nf_lwtnl_dir_header = hdr;
 
 	return 0;
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void __net_exit nf_lwtunnel_net_exit(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->nf.nf_lwtnl_dir_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->nf.nf_lwtnl_dir_header);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 
 static struct pernet_operations nf_lwtunnel_net_ops = {
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index f4d80654dfe6..4dc29d355152 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -420,8 +420,6 @@ static const struct seq_operations nflog_seq_ops = {
 #endif /* PROC_FS */
 
 #ifdef CONFIG_SYSCTL
-static char nf_log_sysctl_fnames[NFPROTO_NUMPROTO-NFPROTO_UNSPEC][3];
-static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO];
 static struct ctl_table_header *nf_log_sysctl_fhdr;
 
 static struct ctl_table nf_log_sysctl_ftable[] = {
@@ -438,10 +436,14 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	const struct nf_logger *logger;
+	unsigned int tindex;
 	char buf[NFLOGGER_NAME_LEN];
 	int r = 0;
-	int tindex = (unsigned long)table->extra1;
-	struct net *net = table->extra2;
+	struct net *net = table->data;
+
+	r = kstrtouint(table->procname, 10, &tindex);
+	if (WARN_ON_ONCE(r || tindex >= NFPROTO_NUMPROTO))
+		return -EINVAL;
 
 	if (write) {
 		struct ctl_table tmp = *table;
@@ -484,68 +486,66 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 	return r;
 }
 
+static void *nf_log_net_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+#define NF_LOG_SYSCTL_FIELD(id)						\
+	[id] = SYSCTL_FIELD_CUSTOM(#id, 0644, NFLOGGER_NAME_LEN,	\
+				nf_log_net_data, nf_log_proc_dostring)
+
+static const struct sysctl_field nf_log_sysctl_table[] = {
+	NF_LOG_SYSCTL_FIELD(0),
+	NF_LOG_SYSCTL_FIELD(1),
+	NF_LOG_SYSCTL_FIELD(2),
+	NF_LOG_SYSCTL_FIELD(3),
+	NF_LOG_SYSCTL_FIELD(4),
+	NF_LOG_SYSCTL_FIELD(5),
+	NF_LOG_SYSCTL_FIELD(6),
+	NF_LOG_SYSCTL_FIELD(7),
+	NF_LOG_SYSCTL_FIELD(8),
+	NF_LOG_SYSCTL_FIELD(9),
+	NF_LOG_SYSCTL_FIELD(10),
+};
+#undef NF_LOG_SYSCTL_FIELD
+
 static int netfilter_log_sysctl_init(struct net *net)
 {
-	int i;
-	struct ctl_table *table;
-
-	table = nf_log_sysctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(nf_log_sysctl_table,
-				 sizeof(nf_log_sysctl_table),
-				 GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-	} else {
-		for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++) {
-			snprintf(nf_log_sysctl_fnames[i],
-				 3, "%d", i);
-			nf_log_sysctl_table[i].procname	=
-				nf_log_sysctl_fnames[i];
-			nf_log_sysctl_table[i].maxlen = NFLOGGER_NAME_LEN;
-			nf_log_sysctl_table[i].mode = 0644;
-			nf_log_sysctl_table[i].proc_handler =
-				nf_log_proc_dostring;
-			nf_log_sysctl_table[i].extra1 =
-				(void *)(unsigned long) i;
-		}
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
+	struct ctl_table_header *hdr;
+
+	BUILD_BUG_ON(ARRAY_SIZE(nf_log_sysctl_table) != NFPROTO_NUMPROTO);
+
+	if (net_eq(net, &init_net)) {
 		nf_log_sysctl_fhdr = register_net_sysctl(net, "net/netfilter",
 							 nf_log_sysctl_ftable);
 		if (!nf_log_sysctl_fhdr)
 			goto err_freg;
 	}
 
-	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++)
-		table[i].extra2 = net;
-
-	net->nf.nf_log_dir_header = register_net_sysctl_sz(net,
-							   "net/netfilter/nf_log",
-							   table,
-							   ARRAY_SIZE(nf_log_sysctl_table));
-	if (!net->nf.nf_log_dir_header)
+	hdr = register_sysctl_fields(&net->sysctls, "net/netfilter/nf_log",
+				     nf_log_sysctl_table, &ctx);
+	if (!hdr)
 		goto err_reg;
 
+	net->nf.nf_log_dir_header = hdr;
+
 	return 0;
 
 err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-	else
+	if (net_eq(net, &init_net))
 		unregister_net_sysctl_table(nf_log_sysctl_fhdr);
 err_freg:
-err_alloc:
 	return -ENOMEM;
 }
 
 static void netfilter_log_sysctl_exit(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->nf.nf_log_dir_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
-	if (!net_eq(net, &init_net))
-		kfree(table);
-	else
+	if (net_eq(net, &init_net))
 		unregister_net_sysctl_table(nf_log_sysctl_fhdr);
 }
 #else
-- 
2.55.0

