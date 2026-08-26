Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074647125F;
	Wed, 26 Aug 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773421; cv=none; b=ED6Gq7mVAX0uYve6EQ3Gw8Z571lgYuV6Frl0NTmAt8zSSatJqymRzXTnyfzGi83Hsec1rKvPTAsSvdNU2na57T1mEsvv3hwDiWrxjF+llIUG+lALSvHWcGCuRoQhWkHgKDlWu8kAV8ZqfFeah2MTuvHk9wskvrOBHTkrK57nQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773421; c=relaxed/simple;
	bh=+d/wiZUkiJw/g+SkPLWGFW/Guj73XwPifLiw2g5FT8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd4cvn0URlzeSrCNPiMvzWNOmV5wU/wM7NFtBW4Mz2DjU6HVsl6wiFU4uL+xMmInIdBan++lM21ZCPRA1uSwVS0VwHJ33ZVHVn+JP8jUNz8L+Pcd+CP6YhX+EBhvV6qGfrjrH578+izYf9V1bvZIS5kh2hprUjivtw+J2jRslUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REaDQSVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REaDQSVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC071F00ADE;
	Wed, 26 Aug 2026 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773401;
	bh=yuA7VwNGMKx6b8SUsXihZyr2KwCQZU0LeLsojz6FFjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=REaDQSVuwcC73XqO2eZR/ZZ8Un5DOLYAH0qz4eytxa9U60LgpHb3JgKjYaw8rpJ8Z
	 GLUafzrZV74G0Ka7YceoJZ03TDkXiD10KiW8JomiJwjyB/WkrNuvAfp5SBSGSbWnry
	 vuHhyprlTTnV/2JBU2l96b9PPrCKVlDlIiIJjddMBwkDyGcbhqXYcuaLjKnTv0iwPj
	 hxSkmwP8pajTVVkIdbgjd1nUI8bqP5fYC8GEnr9MeoGdKRlnvF0dNoc869tRYESB44
	 Bf+ENX4DNgnlM15i/L7V7zBBtP/9kWB9A9DxD4e8Fr2LGtfNEqzzYvo9Z/0pIohmaX
	 D4rl5gHAae8Zg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 11/30] sysctl: net: use sysctl_field in IPv4 sysctls
Date: Wed, 26 Aug 2026 21:42:15 +0200
Message-ID: <9e664370c04724734465fd1cc000a022834b4db9.1787771905.git.legion@kernel.org>
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

The per-net IPv4 sysctl table is cloned for every network namespace so
that data pointers can be rebound from init_net to the namespace being
registered. The table is otherwise static, and the clone also relies on
mutating selected ctl_table entries before registration.

Use sysctl_field descriptors for the per-net IPv4 sysctls instead. The
data pointers are derived from the registration context, so the table
can stay const and the per-net ctl_table allocation, offset patching,
and free path are no longer needed.

Keep the global IPv4 sysctl table on ctl_table, since it is registered
only for init_net and is not part of the per-net clone path.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ipv4/sysctl_net_ipv4.c | 1622 +++++++++++++-----------------------
 1 file changed, 559 insertions(+), 1063 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index d8bdb1bdbff1..75860e7f272e 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -20,22 +20,22 @@
 #include <net/protocol.h>
 #include <net/netevent.h>
 
-static int tcp_retr1_max = 255;
+static unsigned int tcp_retr1_max = 255;
 static int ip_local_port_range_min[] = { 1, 1 };
 static int ip_local_port_range_max[] = { 65535, 65535 };
 static int tcp_adv_win_scale_min = -31;
 static int tcp_adv_win_scale_max = 31;
-static int tcp_app_win_max = 31;
+static unsigned int tcp_app_win_max = 31;
 static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
 static int tcp_min_snd_mss_max = 65535;
 static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
 static int ip_privileged_port_min;
 static int ip_privileged_port_max = 65535;
-static int ip_ttl_min = 1;
-static int ip_ttl_max = 255;
-static int tcp_syn_retries_min = 1;
-static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
-static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
+static unsigned int ip_ttl_min = 1;
+static unsigned int ip_ttl_max = 255;
+static unsigned int tcp_syn_retries_min = 1;
+static unsigned int tcp_syn_retries_max = MAX_TCP_SYNCNT;
+static unsigned int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
 static unsigned long ip_ping_group_range_min[] = { 0, 0 };
 static unsigned long ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
 static u32 u32_max_div_HZ = UINT_MAX / HZ;
@@ -44,11 +44,11 @@ static u32 fib_multipath_hash_fields_all_mask __maybe_unused =
 	FIB_MULTIPATH_HASH_FIELD_ALL_MASK;
 static unsigned int tcp_child_ehash_entries_max = 16 * 1024 * 1024;
 static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
-static int tcp_plb_max_rounds = 31;
+static unsigned int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 5;
-static u32 icmp_errors_extension_mask_all =
+static unsigned int tcp_ecn_mode_max = 5;
+static unsigned int icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
 /* obsolete */
@@ -203,11 +203,16 @@ static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
+	struct ctl_table tmp;
 	int ret;
 
 	net = container_of(table->data, struct net,
 			   ipv4.sysctl_ip_fwd_update_priority);
-	ret = proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
+	tmp = *table;
+	tmp.extra1 = SYSCTL_UINT_ZERO;
+	tmp.extra2 = SYSCTL_UINT_ONE;
+
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		call_netevent_notifiers(NETEVENT_IPV4_FWD_UPDATE_PRIORITY_UPDATE,
 					net);
@@ -365,15 +370,28 @@ static int proc_tfo_blackhole_detect_timeout(const struct ctl_table *table,
 {
 	struct net *net = container_of(table->data, struct net,
 	    ipv4.sysctl_tcp_fastopen_blackhole_timeout);
+	struct ctl_table tmp = *table;
 	int ret;
 
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_ZERO;
+
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		atomic_set(&net->ipv4.tfo_active_disable_times, 0);
 
 	return ret;
 }
 
+static int proc_dointvec_minmax_one(const struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.extra1 = SYSCTL_ONE;
+
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static int proc_tcp_available_ulp(const struct ctl_table *ctl,
 				  int write, void *buffer, size_t *lenp,
 				  loff_t *ppos)
@@ -445,9 +463,13 @@ static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int wri
 {
 	struct net *net = container_of(table->data, struct net,
 	    ipv4.sysctl_fib_multipath_hash_policy);
+	struct ctl_table tmp = *table;
 	int ret;
 
-	ret = proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_UINT_ZERO;
+	tmp.extra2 = SYSCTL_UINT_THREE;
+
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		call_netevent_notifiers(NETEVENT_IPV4_MPATH_HASH_UPDATE, net);
 
@@ -459,11 +481,15 @@ static int proc_fib_multipath_hash_fields(const struct ctl_table *table, int wri
 					  loff_t *ppos)
 {
 	struct net *net;
+	struct ctl_table tmp = *table;
 	int ret;
 
 	net = container_of(table->data, struct net,
 			   ipv4.sysctl_fib_multipath_hash_fields);
-	ret = proc_douintvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.extra1 = SYSCTL_ONE;
+	tmp.extra2 = &fib_multipath_hash_fields_all_mask;
+
+	ret = proc_douintvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (write && ret == 0)
 		call_netevent_notifiers(NETEVENT_IPV4_MPATH_HASH_UPDATE, net);
 
@@ -624,1065 +650,543 @@ static struct ctl_table ipv4_table[] = {
 	},
 };
 
-static struct ctl_table ipv4_net_table[] = {
-	{
-		.procname	= "tcp_max_tw_buckets",
-		.data		= &init_net.ipv4.tcp_death_row.sysctl_max_tw_buckets,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "icmp_echo_ignore_all",
-		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_echo_enable_probe",
-		.data		= &init_net.ipv4.sysctl_icmp_echo_enable_probe,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_echo_ignore_broadcasts",
-		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_ignore_bogus_error_responses",
-		.data		= &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_errors_use_inbound_ifaddr",
-		.data		= &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_errors_extension_mask",
-		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &icmp_errors_extension_mask_all,
-	},
-	{
-		.procname	= "icmp_ratelimit",
-		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "icmp_ratemask",
-		.data		= &init_net.ipv4.sysctl_icmp_ratemask,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "icmp_msgs_per_sec",
-		.data		= &init_net.ipv4.sysctl_icmp_msgs_per_sec,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "icmp_msgs_burst",
-		.data		= &init_net.ipv4.sysctl_icmp_msgs_burst,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "ping_group_range",
-		.data		= &init_net.ipv4.ping_group_range.range,
-		.maxlen		= sizeof(gid_t)*2,
-		.mode		= 0644,
-		.proc_handler	= ipv4_ping_group_range,
-	},
+static umode_t ipv4_init_net_writable_mode(const struct sysctl_context *ctx)
+{
+	return net_eq(ctx->ns.net_ns, &init_net) ? 0644 : 0444;
+}
+
+static void *ipv4_netns_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+#define IPV4_DATA(type, name, field)					\
+static type *ipv4_ ## name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->ipv4.field;				\
+}
+
+#define IPV4_SYSCTL_DATA(type, name)	IPV4_DATA(type, name, sysctl_ ## name)
+
+IPV4_DATA(int, tcp_max_tw_buckets, tcp_death_row.sysctl_max_tw_buckets)
+IPV4_DATA(void, ping_group_range, ping_group_range.range)
+IPV4_DATA(void, ip_local_reserved_ports, sysctl_local_reserved_ports)
+IPV4_DATA(u8, ip_forward_use_pmtu, sysctl_ip_fwd_use_pmtu)
+IPV4_DATA(void, ip_forward_update_priority, sysctl_ip_fwd_update_priority)
+IPV4_DATA(u8, igmp_link_local_mcast_reports, sysctl_igmp_llm_reports)
+IPV4_DATA(void, tcp_congestion_control, tcp_congestion_control)
+IPV4_DATA(int, tcp_max_syn_backlog, sysctl_max_syn_backlog)
+IPV4_DATA(void, tcp_fastopen_key, sysctl_tcp_fastopen)
+IPV4_DATA(void, tcp_fastopen_blackhole_timeout_sec, sysctl_tcp_fastopen_blackhole_timeout)
+IPV4_DATA(void, ip_unprivileged_port_start, sysctl_ip_prot_sock)
+IPV4_DATA(u8, tcp_no_metrics_save, sysctl_tcp_nometrics_save)
+IPV4_DATA(void, tcp_ehash_entries, sysctl_tcp_child_ehash_entries)
+IPV4_DATA(void, udp_hash_entries, sysctl_udp_child_hash_entries)
+
+IPV4_SYSCTL_DATA(u8, icmp_echo_ignore_all)
+IPV4_SYSCTL_DATA(u8, icmp_echo_enable_probe)
+IPV4_SYSCTL_DATA(u8, icmp_echo_ignore_broadcasts)
+IPV4_SYSCTL_DATA(u8, icmp_ignore_bogus_error_responses)
+IPV4_SYSCTL_DATA(u8, icmp_errors_use_inbound_ifaddr)
+IPV4_SYSCTL_DATA(u8, icmp_errors_extension_mask)
+IPV4_SYSCTL_DATA(void, icmp_ratelimit)
+IPV4_SYSCTL_DATA(int, icmp_ratemask)
+IPV4_SYSCTL_DATA(int, icmp_msgs_per_sec)
+IPV4_SYSCTL_DATA(int, icmp_msgs_burst)
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	{
-		.procname	= "raw_l3mdev_accept",
-		.data		= &init_net.ipv4.sysctl_raw_l3mdev_accept,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+IPV4_SYSCTL_DATA(u8, raw_l3mdev_accept)
 #endif
-	{
-		.procname	= "tcp_ecn",
-		.data		= &init_net.ipv4.sysctl_tcp_ecn,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_ecn_mode_max,
-	},
-	{
-		.procname	= "tcp_ecn_option",
-		.data		= &init_net.ipv4.sysctl_tcp_ecn_option,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
-	},
-	{
-		.procname	= "tcp_ecn_option_beacon",
-		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
-	},
-	{
-		.procname	= "tcp_ecn_fallback",
-		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "ip_dynaddr",
-		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_early_demux",
-		.data		= &init_net.ipv4.sysctl_ip_early_demux,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname       = "udp_early_demux",
-		.data           = &init_net.ipv4.sysctl_udp_early_demux,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-	},
-	{
-		.procname       = "tcp_early_demux",
-		.data           = &init_net.ipv4.sysctl_tcp_early_demux,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-	},
-	{
-		.procname       = "nexthop_compat_mode",
-		.data           = &init_net.ipv4.sysctl_nexthop_compat_mode,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "ip_default_ttl",
-		.data		= &init_net.ipv4.sysctl_ip_default_ttl,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= &ip_ttl_min,
-		.extra2		= &ip_ttl_max,
-	},
-	{
-		.procname	= "ip_local_port_range",
-		.maxlen		= 0,
-		.data		= &init_net,
-		.mode		= 0644,
-		.proc_handler	= ipv4_local_port_range,
-	},
-	{
-		.procname	= "ip_local_port_step_width",
-		.maxlen		= sizeof(u32),
-		.data		= &init_net.ipv4.sysctl_ip_local_port_step_width,
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec,
-	},
-	{
-		.procname	= "ip_local_reserved_ports",
-		.data		= &init_net.ipv4.sysctl_local_reserved_ports,
-		.maxlen		= 65536,
-		.mode		= 0644,
-		.proc_handler	= proc_do_large_bitmap,
-	},
-	{
-		.procname	= "ip_no_pmtu_disc",
-		.data		= &init_net.ipv4.sysctl_ip_no_pmtu_disc,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_forward_use_pmtu",
-		.data		= &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_forward_update_priority",
-		.data		= &init_net.ipv4.sysctl_ip_fwd_update_priority,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler   = ipv4_fwd_update_priority,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "ip_nonlocal_bind",
-		.data		= &init_net.ipv4.sysctl_ip_nonlocal_bind,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_autobind_reuse",
-		.data		= &init_net.ipv4.sysctl_ip_autobind_reuse,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-	{
-		.procname	= "fwmark_reflect",
-		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_fwmark_accept",
-		.data		= &init_net.ipv4.sysctl_tcp_fwmark_accept,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
+IPV4_SYSCTL_DATA(u8, tcp_ecn)
+IPV4_SYSCTL_DATA(u8, tcp_ecn_option)
+IPV4_SYSCTL_DATA(u8, tcp_ecn_option_beacon)
+IPV4_SYSCTL_DATA(u8, tcp_ecn_fallback)
+IPV4_SYSCTL_DATA(u8, ip_dynaddr)
+IPV4_SYSCTL_DATA(u8, ip_early_demux)
+IPV4_SYSCTL_DATA(u8, udp_early_demux)
+IPV4_SYSCTL_DATA(u8, tcp_early_demux)
+IPV4_SYSCTL_DATA(u8, nexthop_compat_mode)
+IPV4_SYSCTL_DATA(u8, ip_default_ttl)
+IPV4_SYSCTL_DATA(unsigned int, ip_local_port_step_width)
+IPV4_SYSCTL_DATA(u8, ip_no_pmtu_disc)
+IPV4_SYSCTL_DATA(u8, ip_nonlocal_bind)
+IPV4_SYSCTL_DATA(u8, ip_autobind_reuse)
+IPV4_SYSCTL_DATA(u8, fwmark_reflect)
+IPV4_SYSCTL_DATA(u8, tcp_fwmark_accept)
+IPV4_SYSCTL_DATA(u8, tcp_mtu_probing)
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	{
-		.procname	= "tcp_l3mdev_accept",
-		.data		= &init_net.ipv4.sysctl_tcp_l3mdev_accept,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+IPV4_SYSCTL_DATA(u8, tcp_l3mdev_accept)
 #endif
-	{
-		.procname	= "tcp_mtu_probing",
-		.data		= &init_net.ipv4.sysctl_tcp_mtu_probing,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_base_mss",
-		.data		= &init_net.ipv4.sysctl_tcp_base_mss,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "tcp_min_snd_mss",
-		.data		= &init_net.ipv4.sysctl_tcp_min_snd_mss,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_min_snd_mss_min,
-		.extra2		= &tcp_min_snd_mss_max,
-	},
-	{
-		.procname	= "tcp_mtu_probe_floor",
-		.data		= &init_net.ipv4.sysctl_tcp_mtu_probe_floor,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_min_snd_mss_min,
-		.extra2		= &tcp_min_snd_mss_max,
-	},
-	{
-		.procname	= "tcp_probe_threshold",
-		.data		= &init_net.ipv4.sysctl_tcp_probe_threshold,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "tcp_probe_interval",
-		.data		= &init_net.ipv4.sysctl_tcp_probe_interval,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra2		= &u32_max_div_HZ,
-	},
-	{
-		.procname	= "igmp_link_local_mcast_reports",
-		.data		= &init_net.ipv4.sysctl_igmp_llm_reports,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "igmp_max_memberships",
-		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "igmp_max_msf",
-		.data		= &init_net.ipv4.sysctl_igmp_max_msf,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
+IPV4_SYSCTL_DATA(int, tcp_base_mss)
+IPV4_SYSCTL_DATA(int, tcp_min_snd_mss)
+IPV4_SYSCTL_DATA(int, tcp_mtu_probe_floor)
+IPV4_SYSCTL_DATA(int, tcp_probe_threshold)
+IPV4_SYSCTL_DATA(unsigned int, tcp_probe_interval)
+IPV4_SYSCTL_DATA(int, igmp_max_memberships)
+IPV4_SYSCTL_DATA(int, igmp_max_msf)
 #ifdef CONFIG_IP_MULTICAST
-	{
-		.procname	= "igmp_qrv",
-		.data		= &init_net.ipv4.sysctl_igmp_qrv,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
-	},
+IPV4_SYSCTL_DATA(int, igmp_qrv)
 #endif
-	{
-		.procname	= "tcp_congestion_control",
-		.data		= &init_net.ipv4.tcp_congestion_control,
-		.mode		= 0644,
-		.maxlen		= TCP_CA_NAME_MAX,
-		.proc_handler	= proc_tcp_congestion_control,
-	},
-	{
-		.procname	= "tcp_available_congestion_control",
-		.maxlen		= TCP_CA_BUF_MAX,
-		.mode		= 0444,
-		.proc_handler   = proc_tcp_available_congestion_control,
-	},
-	{
-		.procname	= "tcp_allowed_congestion_control",
-		.maxlen		= TCP_CA_BUF_MAX,
-		.mode		= 0644,
-		.proc_handler   = proc_allowed_congestion_control,
-	},
-	{
-		.procname	= "tcp_keepalive_time",
-		.data		= &init_net.ipv4.sysctl_tcp_keepalive_time,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "tcp_keepalive_probes",
-		.data		= &init_net.ipv4.sysctl_tcp_keepalive_probes,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_keepalive_intvl",
-		.data		= &init_net.ipv4.sysctl_tcp_keepalive_intvl,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "tcp_syn_retries",
-		.data		= &init_net.ipv4.sysctl_tcp_syn_retries,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= &tcp_syn_retries_min,
-		.extra2		= &tcp_syn_retries_max
-	},
-	{
-		.procname	= "tcp_synack_retries",
-		.data		= &init_net.ipv4.sysctl_tcp_synack_retries,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
+IPV4_SYSCTL_DATA(void, tcp_keepalive_time)
+IPV4_SYSCTL_DATA(u8, tcp_keepalive_probes)
+IPV4_SYSCTL_DATA(void, tcp_keepalive_intvl)
+IPV4_SYSCTL_DATA(u8, tcp_syn_retries)
+IPV4_SYSCTL_DATA(u8, tcp_synack_retries)
 #ifdef CONFIG_SYN_COOKIES
-	{
-		.procname	= "tcp_syncookies",
-		.data		= &init_net.ipv4.sysctl_tcp_syncookies,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
+IPV4_SYSCTL_DATA(u8, tcp_syncookies)
 #endif
-	{
-		.procname	= "tcp_migrate_req",
-		.data		= &init_net.ipv4.sysctl_tcp_migrate_req,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "tcp_reordering",
-		.data		= &init_net.ipv4.sysctl_tcp_reordering,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "tcp_retries1",
-		.data		= &init_net.ipv4.sysctl_tcp_retries1,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra2		= &tcp_retr1_max
-	},
-	{
-		.procname	= "tcp_retries2",
-		.data		= &init_net.ipv4.sysctl_tcp_retries2,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_orphan_retries",
-		.data		= &init_net.ipv4.sysctl_tcp_orphan_retries,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_fin_timeout",
-		.data		= &init_net.ipv4.sysctl_tcp_fin_timeout,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "tcp_notsent_lowat",
-		.data		= &init_net.ipv4.sysctl_tcp_notsent_lowat,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec,
-	},
-	{
-		.procname	= "tcp_tw_reuse",
-		.data		= &init_net.ipv4.sysctl_tcp_tw_reuse,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "tcp_tw_reuse_delay",
-		.data		= &init_net.ipv4.sysctl_tcp_tw_reuse_delay,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &tcp_tw_reuse_delay_max,
-	},
-	{
-		.procname	= "tcp_max_syn_backlog",
-		.data		= &init_net.ipv4.sysctl_max_syn_backlog,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "tcp_fastopen",
-		.data		= &init_net.ipv4.sysctl_tcp_fastopen,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "tcp_fastopen_key",
-		.mode		= 0600,
-		.data		= &init_net.ipv4.sysctl_tcp_fastopen,
-		/* maxlen to print the list of keys in hex (*2), with dashes
-		 * separating doublewords and a comma in between keys.
-		 */
-		.maxlen		= ((TCP_FASTOPEN_KEY_LENGTH *
-				   2 * TCP_FASTOPEN_KEY_MAX) +
-				   (TCP_FASTOPEN_KEY_MAX * 5)),
-		.proc_handler	= proc_tcp_fastopen_key,
-	},
-	{
-		.procname	= "tcp_fastopen_blackhole_timeout_sec",
-		.data		= &init_net.ipv4.sysctl_tcp_fastopen_blackhole_timeout,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_tfo_blackhole_detect_timeout,
-		.extra1		= SYSCTL_ZERO,
-	},
+IPV4_SYSCTL_DATA(u8, tcp_migrate_req)
+IPV4_SYSCTL_DATA(int, tcp_reordering)
+IPV4_SYSCTL_DATA(u8, tcp_retries1)
+IPV4_SYSCTL_DATA(u8, tcp_retries2)
+IPV4_SYSCTL_DATA(u8, tcp_orphan_retries)
+IPV4_SYSCTL_DATA(void, tcp_fin_timeout)
+IPV4_SYSCTL_DATA(unsigned int, tcp_notsent_lowat)
+IPV4_SYSCTL_DATA(u8, tcp_tw_reuse)
+IPV4_SYSCTL_DATA(unsigned int, tcp_tw_reuse_delay)
+IPV4_SYSCTL_DATA(int, tcp_fastopen)
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-	{
-		.procname	= "fib_multipath_use_neigh",
-		.data		= &init_net.ipv4.sysctl_fib_multipath_use_neigh,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "fib_multipath_hash_policy",
-		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_policy,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_fib_multipath_hash_policy,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
-	},
-	{
-		.procname	= "fib_multipath_hash_fields",
-		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_fields,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_fib_multipath_hash_fields,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &fib_multipath_hash_fields_all_mask,
-	},
-	{
-		.procname	= "fib_multipath_hash_seed",
-		.data		= &init_net,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_fib_multipath_hash_seed,
-	},
+IPV4_SYSCTL_DATA(u8, fib_multipath_use_neigh)
+IPV4_SYSCTL_DATA(void, fib_multipath_hash_policy)
+IPV4_SYSCTL_DATA(void, fib_multipath_hash_fields)
 #endif
-	{
-		.procname	= "ip_unprivileged_port_start",
-		.maxlen		= sizeof(int),
-		.data		= &init_net.ipv4.sysctl_ip_prot_sock,
-		.mode		= 0644,
-		.proc_handler	= ipv4_privileged_ports,
-	},
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	{
-		.procname	= "udp_l3mdev_accept",
-		.data		= &init_net.ipv4.sysctl_udp_l3mdev_accept,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+IPV4_SYSCTL_DATA(u8, udp_l3mdev_accept)
 #endif
-	{
-		.procname	= "tcp_sack",
-		.data		= &init_net.ipv4.sysctl_tcp_sack,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_window_scaling",
-		.data		= &init_net.ipv4.sysctl_tcp_window_scaling,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_timestamps",
-		.data		= &init_net.ipv4.sysctl_tcp_timestamps,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_early_retrans",
-		.data		= &init_net.ipv4.sysctl_tcp_early_retrans,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_FOUR,
-	},
-	{
-		.procname	= "tcp_recovery",
-		.data		= &init_net.ipv4.sysctl_tcp_recovery,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname       = "tcp_thin_linear_timeouts",
-		.data           = &init_net.ipv4.sysctl_tcp_thin_linear_timeouts,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_slow_start_after_idle",
-		.data		= &init_net.ipv4.sysctl_tcp_slow_start_after_idle,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_retrans_collapse",
-		.data		= &init_net.ipv4.sysctl_tcp_retrans_collapse,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_stdurg",
-		.data		= &init_net.ipv4.sysctl_tcp_stdurg,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_rfc1337",
-		.data		= &init_net.ipv4.sysctl_tcp_rfc1337,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_abort_on_overflow",
-		.data		= &init_net.ipv4.sysctl_tcp_abort_on_overflow,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_fack",
-		.data		= &init_net.ipv4.sysctl_tcp_fack,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_max_reordering",
-		.data		= &init_net.ipv4.sysctl_tcp_max_reordering,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "tcp_dsack",
-		.data		= &init_net.ipv4.sysctl_tcp_dsack,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_app_win",
-		.data		= &init_net.ipv4.sysctl_tcp_app_win,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_app_win_max,
-	},
-	{
-		.procname	= "tcp_adv_win_scale",
-		.data		= &init_net.ipv4.sysctl_tcp_adv_win_scale,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_adv_win_scale_min,
-		.extra2		= &tcp_adv_win_scale_max,
-	},
-	{
-		.procname	= "tcp_frto",
-		.data		= &init_net.ipv4.sysctl_tcp_frto,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_no_metrics_save",
-		.data		= &init_net.ipv4.sysctl_tcp_nometrics_save,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_no_ssthresh_metrics_save",
-		.data		= &init_net.ipv4.sysctl_tcp_no_ssthresh_metrics_save,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_moderate_rcvbuf",
-		.data		= &init_net.ipv4.sysctl_tcp_moderate_rcvbuf,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_rcvbuf_low_rtt",
-		.data		= &init_net.ipv4.sysctl_tcp_rcvbuf_low_rtt,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "tcp_tso_win_divisor",
-		.data		= &init_net.ipv4.sysctl_tcp_tso_win_divisor,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_workaround_signed_windows",
-		.data		= &init_net.ipv4.sysctl_tcp_workaround_signed_windows,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_limit_output_bytes",
-		.data		= &init_net.ipv4.sysctl_tcp_limit_output_bytes,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "tcp_challenge_ack_limit",
-		.data		= &init_net.ipv4.sysctl_tcp_challenge_ack_limit,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "tcp_min_tso_segs",
-		.data		= &init_net.ipv4.sysctl_tcp_min_tso_segs,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_tso_rtt_log",
-		.data		= &init_net.ipv4.sysctl_tcp_tso_rtt_log,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "tcp_min_rtt_wlen",
-		.data		= &init_net.ipv4.sysctl_tcp_min_rtt_wlen,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_day_secs
-	},
-	{
-		.procname	= "tcp_autocorking",
-		.data		= &init_net.ipv4.sysctl_tcp_autocorking,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_invalid_ratelimit",
-		.data		= &init_net.ipv4.sysctl_tcp_invalid_ratelimit,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "tcp_pacing_ss_ratio",
-		.data		= &init_net.ipv4.sysctl_tcp_pacing_ss_ratio,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
-	},
-	{
-		.procname	= "tcp_pacing_ca_ratio",
-		.data		= &init_net.ipv4.sysctl_tcp_pacing_ca_ratio,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
-	},
-	{
-		.procname	= "tcp_wmem",
-		.data		= &init_net.ipv4.sysctl_tcp_wmem,
-		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_wmem),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_rmem",
-		.data		= &init_net.ipv4.sysctl_tcp_rmem,
-		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_comp_sack_delay_ns",
-		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_delay_ns,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "tcp_comp_sack_rtt_percent",
-		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_rtt_percent,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE_THOUSAND,
-	},
-	{
-		.procname	= "tcp_comp_sack_slack_ns",
-		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_slack_ns,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "tcp_comp_sack_nr",
-		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_nr,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "tcp_backlog_ack_defer",
-		.data		= &init_net.ipv4.sysctl_tcp_backlog_ack_defer,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname       = "tcp_reflect_tos",
-		.data           = &init_net.ipv4.sysctl_tcp_reflect_tos,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_ehash_entries",
-		.data		= &init_net.ipv4.sysctl_tcp_child_ehash_entries,
-		.mode		= 0444,
-		.proc_handler	= proc_tcp_ehash_entries,
-	},
-	{
-		.procname	= "tcp_child_ehash_entries",
-		.data		= &init_net.ipv4.sysctl_tcp_child_ehash_entries,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_child_ehash_entries_max,
-	},
-	{
-		.procname	= "udp_hash_entries",
-		.data		= &init_net.ipv4.sysctl_udp_child_hash_entries,
-		.mode		= 0444,
-		.proc_handler	= proc_udp_hash_entries,
-	},
-	{
-		.procname	= "udp_child_hash_entries",
-		.data		= &init_net.ipv4.sysctl_udp_child_hash_entries,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_child_hash_entries_max,
-	},
-	{
-		.procname	= "udp_rmem_min",
-		.data		= &init_net.ipv4.sysctl_udp_rmem_min,
-		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_rmem_min),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
-	},
-	{
-		.procname	= "udp_wmem_min",
-		.data		= &init_net.ipv4.sysctl_udp_wmem_min,
-		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_wmem_min),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
-	},
-	{
-		.procname	= "fib_notify_on_flag_change",
-		.data		= &init_net.ipv4.sysctl_fib_notify_on_flag_change,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname       = "tcp_plb_enabled",
-		.data           = &init_net.ipv4.sysctl_tcp_plb_enabled,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-	{
-		.procname       = "tcp_plb_idle_rehash_rounds",
-		.data           = &init_net.ipv4.sysctl_tcp_plb_idle_rehash_rounds,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-		.extra2		= &tcp_plb_max_rounds,
-	},
-	{
-		.procname       = "tcp_plb_rehash_rounds",
-		.data           = &init_net.ipv4.sysctl_tcp_plb_rehash_rounds,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-		.extra2         = &tcp_plb_max_rounds,
-	},
-	{
-		.procname       = "tcp_plb_suspend_rto_sec",
-		.data           = &init_net.ipv4.sysctl_tcp_plb_suspend_rto_sec,
-		.maxlen         = sizeof(u8),
-		.mode           = 0644,
-		.proc_handler   = proc_dou8vec_minmax,
-	},
-	{
-		.procname       = "tcp_plb_cong_thresh",
-		.data           = &init_net.ipv4.sysctl_tcp_plb_cong_thresh,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = &tcp_plb_max_cong_thresh,
-	},
-	{
-		.procname	= "tcp_syn_linear_timeouts",
-		.data		= &init_net.ipv4.sysctl_tcp_syn_linear_timeouts,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_syn_linear_timeouts_max,
-	},
-	{
-		.procname	= "tcp_shrink_window",
-		.data		= &init_net.ipv4.sysctl_tcp_shrink_window,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_pingpong_thresh",
-		.data		= &init_net.ipv4.sysctl_tcp_pingpong_thresh,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_rto_min_us",
-		.data		= &init_net.ipv4.sysctl_tcp_rto_min_us,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "tcp_rto_max_ms",
-		.data		= &init_net.ipv4.sysctl_tcp_rto_max_ms,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE_THOUSAND,
-		.extra2		= &tcp_rto_max_max,
-	},
+IPV4_SYSCTL_DATA(u8, tcp_sack)
+IPV4_SYSCTL_DATA(u8, tcp_window_scaling)
+IPV4_SYSCTL_DATA(u8, tcp_timestamps)
+IPV4_SYSCTL_DATA(u8, tcp_early_retrans)
+IPV4_SYSCTL_DATA(u8, tcp_recovery)
+IPV4_SYSCTL_DATA(u8, tcp_thin_linear_timeouts)
+IPV4_SYSCTL_DATA(u8, tcp_slow_start_after_idle)
+IPV4_SYSCTL_DATA(u8, tcp_retrans_collapse)
+IPV4_SYSCTL_DATA(u8, tcp_stdurg)
+IPV4_SYSCTL_DATA(u8, tcp_rfc1337)
+IPV4_SYSCTL_DATA(u8, tcp_abort_on_overflow)
+IPV4_SYSCTL_DATA(u8, tcp_fack)
+IPV4_SYSCTL_DATA(int, tcp_max_reordering)
+IPV4_SYSCTL_DATA(u8, tcp_dsack)
+IPV4_SYSCTL_DATA(u8, tcp_app_win)
+IPV4_SYSCTL_DATA(int, tcp_adv_win_scale)
+IPV4_SYSCTL_DATA(u8, tcp_frto)
+IPV4_SYSCTL_DATA(u8, tcp_no_ssthresh_metrics_save)
+IPV4_SYSCTL_DATA(u8, tcp_moderate_rcvbuf)
+IPV4_SYSCTL_DATA(int, tcp_rcvbuf_low_rtt)
+IPV4_SYSCTL_DATA(u8, tcp_tso_win_divisor)
+IPV4_SYSCTL_DATA(u8, tcp_workaround_signed_windows)
+IPV4_SYSCTL_DATA(int, tcp_limit_output_bytes)
+IPV4_SYSCTL_DATA(int, tcp_challenge_ack_limit)
+IPV4_SYSCTL_DATA(u8, tcp_min_tso_segs)
+IPV4_SYSCTL_DATA(u8, tcp_tso_rtt_log)
+IPV4_SYSCTL_DATA(int, tcp_min_rtt_wlen)
+IPV4_SYSCTL_DATA(u8, tcp_autocorking)
+IPV4_SYSCTL_DATA(void, tcp_invalid_ratelimit)
+IPV4_SYSCTL_DATA(int, tcp_pacing_ss_ratio)
+IPV4_SYSCTL_DATA(int, tcp_pacing_ca_ratio)
+IPV4_SYSCTL_DATA(void, tcp_wmem)
+IPV4_SYSCTL_DATA(void, tcp_rmem)
+IPV4_SYSCTL_DATA(unsigned long, tcp_comp_sack_delay_ns)
+IPV4_SYSCTL_DATA(int, tcp_comp_sack_rtt_percent)
+IPV4_SYSCTL_DATA(unsigned long, tcp_comp_sack_slack_ns)
+IPV4_SYSCTL_DATA(u8, tcp_comp_sack_nr)
+IPV4_SYSCTL_DATA(u8, tcp_backlog_ack_defer)
+IPV4_SYSCTL_DATA(u8, tcp_reflect_tos)
+IPV4_SYSCTL_DATA(unsigned int, tcp_child_ehash_entries)
+IPV4_SYSCTL_DATA(unsigned int, udp_child_hash_entries)
+IPV4_SYSCTL_DATA(int, udp_rmem_min)
+IPV4_SYSCTL_DATA(int, udp_wmem_min)
+IPV4_SYSCTL_DATA(u8, fib_notify_on_flag_change)
+IPV4_SYSCTL_DATA(u8, tcp_plb_enabled)
+IPV4_SYSCTL_DATA(u8, tcp_plb_idle_rehash_rounds)
+IPV4_SYSCTL_DATA(u8, tcp_plb_rehash_rounds)
+IPV4_SYSCTL_DATA(u8, tcp_plb_suspend_rto_sec)
+IPV4_SYSCTL_DATA(int, tcp_plb_cong_thresh)
+IPV4_SYSCTL_DATA(u8, tcp_syn_linear_timeouts)
+IPV4_SYSCTL_DATA(u8, tcp_shrink_window)
+IPV4_SYSCTL_DATA(u8, tcp_pingpong_thresh)
+IPV4_SYSCTL_DATA(int, tcp_rto_min_us)
+IPV4_SYSCTL_DATA(int, tcp_rto_max_ms)
+
+static const struct sysctl_field ipv4_net_table[] = {
+	SYSCTL_FIELD_INT("tcp_max_tw_buckets", 0644,
+			ipv4_tcp_max_tw_buckets_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("icmp_echo_ignore_all", 0644,
+			ipv4_icmp_echo_ignore_all_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("icmp_echo_enable_probe", 0644,
+			ipv4_icmp_echo_enable_probe_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("icmp_echo_ignore_broadcasts", 0644,
+			ipv4_icmp_echo_ignore_broadcasts_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("icmp_ignore_bogus_error_responses", 0644,
+			ipv4_icmp_ignore_bogus_error_responses_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("icmp_errors_use_inbound_ifaddr", 0644,
+			ipv4_icmp_errors_use_inbound_ifaddr_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("icmp_errors_extension_mask", 0644,
+			ipv4_icmp_errors_extension_mask_data,
+			SYSCTL_UINT_ZERO, &icmp_errors_extension_mask_all),
+	SYSCTL_FIELD_CUSTOM("icmp_ratelimit", 0644,
+			sizeof(int),
+			ipv4_icmp_ratelimit_data,
+			proc_dointvec_ms_jiffies),
+	SYSCTL_FIELD_INT("icmp_ratemask", 0644,
+			ipv4_icmp_ratemask_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("icmp_msgs_per_sec", 0644,
+			ipv4_icmp_msgs_per_sec_data,
+			SYSCTL_ZERO, NULL),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("icmp_msgs_burst", 0644,
+			ipv4_icmp_msgs_burst_data,
+			SYSCTL_ZERO, NULL),
+	SYSCTL_FIELD_CUSTOM("ping_group_range", 0644,
+			sizeof(gid_t) * 2,
+			ipv4_ping_group_range_data,
+			ipv4_ping_group_range),
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	SYSCTL_FIELD_STATIC_U8_MINMAX("raw_l3mdev_accept", 0644,
+			ipv4_raw_l3mdev_accept_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+#endif
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_ecn", 0644,
+			ipv4_tcp_ecn_data,
+			SYSCTL_UINT_ZERO, &tcp_ecn_mode_max),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_ecn_option", 0644,
+			ipv4_tcp_ecn_option_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_THREE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_ecn_option_beacon", 0644,
+			ipv4_tcp_ecn_option_beacon_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_THREE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_ecn_fallback", 0644,
+			ipv4_tcp_ecn_fallback_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_U8("ip_dynaddr", 0644,
+			ipv4_ip_dynaddr_data),
+	SYSCTL_FIELD_U8("ip_early_demux", 0644,
+			ipv4_ip_early_demux_data),
+	SYSCTL_FIELD_U8("udp_early_demux", 0644,
+			ipv4_udp_early_demux_data),
+	SYSCTL_FIELD_U8("tcp_early_demux", 0644,
+			ipv4_tcp_early_demux_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("nexthop_compat_mode", 0644,
+			ipv4_nexthop_compat_mode_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("ip_default_ttl", 0644,
+			ipv4_ip_default_ttl_data,
+			&ip_ttl_min, &ip_ttl_max),
+	SYSCTL_FIELD_CUSTOM("ip_local_port_range", 0644,
+			0,
+			ipv4_netns_data,
+			ipv4_local_port_range),
+	SYSCTL_FIELD_UINT("ip_local_port_step_width", 0644,
+			ipv4_ip_local_port_step_width_data),
+	SYSCTL_FIELD_CUSTOM("ip_local_reserved_ports", 0644,
+			65536,
+			ipv4_ip_local_reserved_ports_data,
+			proc_do_large_bitmap),
+	SYSCTL_FIELD_U8("ip_no_pmtu_disc", 0644,
+			ipv4_ip_no_pmtu_disc_data),
+	SYSCTL_FIELD_U8("ip_forward_use_pmtu", 0644,
+			ipv4_ip_forward_use_pmtu_data),
+	SYSCTL_FIELD_CUSTOM("ip_forward_update_priority", 0644,
+			sizeof(u8),
+			ipv4_ip_forward_update_priority_data,
+			ipv4_fwd_update_priority),
+	SYSCTL_FIELD_U8("ip_nonlocal_bind", 0644,
+			ipv4_ip_nonlocal_bind_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("ip_autobind_reuse", 0644,
+			ipv4_ip_autobind_reuse_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_U8("fwmark_reflect", 0644,
+			ipv4_fwmark_reflect_data),
+	SYSCTL_FIELD_U8("tcp_fwmark_accept", 0644,
+			ipv4_tcp_fwmark_accept_data),
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_l3mdev_accept", 0644,
+			ipv4_tcp_l3mdev_accept_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+#endif
+	SYSCTL_FIELD_U8("tcp_mtu_probing", 0644,
+			ipv4_tcp_mtu_probing_data),
+	SYSCTL_FIELD_INT("tcp_base_mss", 0644,
+			ipv4_tcp_base_mss_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_min_snd_mss", 0644,
+			ipv4_tcp_min_snd_mss_data,
+			&tcp_min_snd_mss_min, &tcp_min_snd_mss_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_mtu_probe_floor", 0644,
+			ipv4_tcp_mtu_probe_floor_data,
+			&tcp_min_snd_mss_min, &tcp_min_snd_mss_max),
+	SYSCTL_FIELD_INT("tcp_probe_threshold", 0644,
+			ipv4_tcp_probe_threshold_data),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("tcp_probe_interval", 0644,
+			ipv4_tcp_probe_interval_data,
+			NULL, &u32_max_div_HZ),
+	SYSCTL_FIELD_U8("igmp_link_local_mcast_reports", 0644,
+			ipv4_igmp_link_local_mcast_reports_data),
+	SYSCTL_FIELD_INT("igmp_max_memberships", 0644,
+			ipv4_igmp_max_memberships_data),
+	SYSCTL_FIELD_INT("igmp_max_msf", 0644,
+			ipv4_igmp_max_msf_data),
+#ifdef CONFIG_IP_MULTICAST
+	SYSCTL_FIELD_STATIC_INT_MINMAX("igmp_qrv", 0644,
+			ipv4_igmp_qrv_data,
+			SYSCTL_ONE, NULL),
+#endif
+	SYSCTL_FIELD_CUSTOM("tcp_congestion_control", 0644,
+			TCP_CA_NAME_MAX,
+			ipv4_tcp_congestion_control_data,
+			proc_tcp_congestion_control),
+	SYSCTL_FIELD_CUSTOM("tcp_available_congestion_control", 0444,
+			TCP_CA_BUF_MAX,
+			NULL,
+			proc_tcp_available_congestion_control),
+	SYSCTL_FIELD_CUSTOM_MODE("tcp_allowed_congestion_control", 0644,
+			ipv4_init_net_writable_mode, TCP_CA_BUF_MAX, NULL,
+			proc_allowed_congestion_control),
+	SYSCTL_FIELD_CUSTOM("tcp_keepalive_time", 0644,
+			sizeof(int),
+			ipv4_tcp_keepalive_time_data,
+			proc_dointvec_jiffies),
+	SYSCTL_FIELD_U8("tcp_keepalive_probes", 0644,
+			ipv4_tcp_keepalive_probes_data),
+	SYSCTL_FIELD_CUSTOM("tcp_keepalive_intvl", 0644,
+			sizeof(int),
+			ipv4_tcp_keepalive_intvl_data,
+			proc_dointvec_jiffies),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_syn_retries", 0644,
+			ipv4_tcp_syn_retries_data,
+			&tcp_syn_retries_min, &tcp_syn_retries_max),
+	SYSCTL_FIELD_U8("tcp_synack_retries", 0644,
+			ipv4_tcp_synack_retries_data),
+#ifdef CONFIG_SYN_COOKIES
+	SYSCTL_FIELD_U8("tcp_syncookies", 0644,
+			ipv4_tcp_syncookies_data),
+#endif
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_migrate_req", 0644,
+			ipv4_tcp_migrate_req_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_INT("tcp_reordering", 0644,
+			ipv4_tcp_reordering_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_retries1", 0644,
+			ipv4_tcp_retries1_data,
+			NULL, &tcp_retr1_max),
+	SYSCTL_FIELD_U8("tcp_retries2", 0644,
+			ipv4_tcp_retries2_data),
+	SYSCTL_FIELD_U8("tcp_orphan_retries", 0644,
+			ipv4_tcp_orphan_retries_data),
+	SYSCTL_FIELD_CUSTOM("tcp_fin_timeout", 0644,
+			sizeof(int),
+			ipv4_tcp_fin_timeout_data,
+			proc_dointvec_jiffies),
+	SYSCTL_FIELD_UINT("tcp_notsent_lowat", 0644,
+			ipv4_tcp_notsent_lowat_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_tw_reuse", 0644,
+			ipv4_tcp_tw_reuse_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_TWO),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("tcp_tw_reuse_delay", 0644,
+			ipv4_tcp_tw_reuse_delay_data,
+			SYSCTL_UINT_ONE, &tcp_tw_reuse_delay_max),
+	SYSCTL_FIELD_INT("tcp_max_syn_backlog", 0644,
+			ipv4_tcp_max_syn_backlog_data),
+	SYSCTL_FIELD_INT("tcp_fastopen", 0644,
+			ipv4_tcp_fastopen_data),
+	SYSCTL_FIELD_CUSTOM("tcp_fastopen_key", 0600,
+			((TCP_FASTOPEN_KEY_LENGTH * 2 * TCP_FASTOPEN_KEY_MAX) + (TCP_FASTOPEN_KEY_MAX * 5)),
+			ipv4_tcp_fastopen_key_data,
+			proc_tcp_fastopen_key),
+	SYSCTL_FIELD_CUSTOM("tcp_fastopen_blackhole_timeout_sec", 0644,
+			sizeof(int),
+			ipv4_tcp_fastopen_blackhole_timeout_sec_data,
+			proc_tfo_blackhole_detect_timeout),
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+	SYSCTL_FIELD_STATIC_U8_MINMAX("fib_multipath_use_neigh", 0644,
+			ipv4_fib_multipath_use_neigh_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM("fib_multipath_hash_policy", 0644,
+			sizeof(u8),
+			ipv4_fib_multipath_hash_policy_data,
+			proc_fib_multipath_hash_policy),
+	SYSCTL_FIELD_CUSTOM("fib_multipath_hash_fields", 0644,
+			sizeof(u32),
+			ipv4_fib_multipath_hash_fields_data,
+			proc_fib_multipath_hash_fields),
+	SYSCTL_FIELD_CUSTOM("fib_multipath_hash_seed", 0644,
+			sizeof(u32),
+			ipv4_netns_data,
+			proc_fib_multipath_hash_seed),
+#endif
+	SYSCTL_FIELD_CUSTOM("ip_unprivileged_port_start", 0644,
+			sizeof(int),
+			ipv4_ip_unprivileged_port_start_data,
+			ipv4_privileged_ports),
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	SYSCTL_FIELD_STATIC_U8_MINMAX("udp_l3mdev_accept", 0644,
+			ipv4_udp_l3mdev_accept_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+#endif
+	SYSCTL_FIELD_U8("tcp_sack", 0644,
+			ipv4_tcp_sack_data),
+	SYSCTL_FIELD_U8("tcp_window_scaling", 0644,
+			ipv4_tcp_window_scaling_data),
+	SYSCTL_FIELD_U8("tcp_timestamps", 0644,
+			ipv4_tcp_timestamps_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_early_retrans", 0644,
+			ipv4_tcp_early_retrans_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_FOUR),
+	SYSCTL_FIELD_U8("tcp_recovery", 0644,
+			ipv4_tcp_recovery_data),
+	SYSCTL_FIELD_U8("tcp_thin_linear_timeouts", 0644,
+			ipv4_tcp_thin_linear_timeouts_data),
+	SYSCTL_FIELD_U8("tcp_slow_start_after_idle", 0644,
+			ipv4_tcp_slow_start_after_idle_data),
+	SYSCTL_FIELD_U8("tcp_retrans_collapse", 0644,
+			ipv4_tcp_retrans_collapse_data),
+	SYSCTL_FIELD_U8("tcp_stdurg", 0644,
+			ipv4_tcp_stdurg_data),
+	SYSCTL_FIELD_U8("tcp_rfc1337", 0644,
+			ipv4_tcp_rfc1337_data),
+	SYSCTL_FIELD_U8("tcp_abort_on_overflow", 0644,
+			ipv4_tcp_abort_on_overflow_data),
+	SYSCTL_FIELD_U8("tcp_fack", 0644,
+			ipv4_tcp_fack_data),
+	SYSCTL_FIELD_INT("tcp_max_reordering", 0644,
+			ipv4_tcp_max_reordering_data),
+	SYSCTL_FIELD_U8("tcp_dsack", 0644,
+			ipv4_tcp_dsack_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_app_win", 0644,
+			ipv4_tcp_app_win_data,
+			SYSCTL_UINT_ZERO, &tcp_app_win_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_adv_win_scale", 0644,
+			ipv4_tcp_adv_win_scale_data,
+			&tcp_adv_win_scale_min, &tcp_adv_win_scale_max),
+	SYSCTL_FIELD_U8("tcp_frto", 0644,
+			ipv4_tcp_frto_data),
+	SYSCTL_FIELD_U8("tcp_no_metrics_save", 0644,
+			ipv4_tcp_no_metrics_save_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_no_ssthresh_metrics_save", 0644,
+			ipv4_tcp_no_ssthresh_metrics_save_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_U8("tcp_moderate_rcvbuf", 0644,
+			ipv4_tcp_moderate_rcvbuf_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_rcvbuf_low_rtt", 0644,
+			ipv4_tcp_rcvbuf_low_rtt_data,
+			SYSCTL_ZERO, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_U8("tcp_tso_win_divisor", 0644,
+			ipv4_tcp_tso_win_divisor_data),
+	SYSCTL_FIELD_U8("tcp_workaround_signed_windows", 0644,
+			ipv4_tcp_workaround_signed_windows_data),
+	SYSCTL_FIELD_INT("tcp_limit_output_bytes", 0644,
+			ipv4_tcp_limit_output_bytes_data),
+	SYSCTL_FIELD_INT("tcp_challenge_ack_limit", 0644,
+			ipv4_tcp_challenge_ack_limit_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_min_tso_segs", 0644,
+			ipv4_tcp_min_tso_segs_data,
+			SYSCTL_UINT_ONE, NULL),
+	SYSCTL_FIELD_U8("tcp_tso_rtt_log", 0644,
+			ipv4_tcp_tso_rtt_log_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_min_rtt_wlen", 0644,
+			ipv4_tcp_min_rtt_wlen_data,
+			SYSCTL_ZERO, &one_day_secs),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_autocorking", 0644,
+			ipv4_tcp_autocorking_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM("tcp_invalid_ratelimit", 0644,
+			sizeof(int),
+			ipv4_tcp_invalid_ratelimit_data,
+			proc_dointvec_ms_jiffies),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_pacing_ss_ratio", 0644,
+			ipv4_tcp_pacing_ss_ratio_data,
+			SYSCTL_ZERO, SYSCTL_ONE_THOUSAND),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_pacing_ca_ratio", 0644,
+			ipv4_tcp_pacing_ca_ratio_data,
+			SYSCTL_ZERO, SYSCTL_ONE_THOUSAND),
+	SYSCTL_FIELD_CUSTOM("tcp_wmem", 0644,
+			sizeof(init_net.ipv4.sysctl_tcp_wmem),
+			ipv4_tcp_wmem_data,
+			proc_dointvec_minmax_one),
+	SYSCTL_FIELD_CUSTOM("tcp_rmem", 0644,
+			sizeof(init_net.ipv4.sysctl_tcp_rmem),
+			ipv4_tcp_rmem_data,
+			proc_dointvec_minmax_one),
+	SYSCTL_FIELD_ULONG("tcp_comp_sack_delay_ns", 0644,
+			ipv4_tcp_comp_sack_delay_ns_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_comp_sack_rtt_percent", 0644,
+			ipv4_tcp_comp_sack_rtt_percent_data,
+			SYSCTL_ONE, SYSCTL_ONE_THOUSAND),
+	SYSCTL_FIELD_ULONG("tcp_comp_sack_slack_ns", 0644,
+			ipv4_tcp_comp_sack_slack_ns_data),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_comp_sack_nr", 0644,
+			ipv4_tcp_comp_sack_nr_data,
+			SYSCTL_UINT_ZERO, NULL),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_backlog_ack_defer", 0644,
+			ipv4_tcp_backlog_ack_defer_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_reflect_tos", 0644,
+			ipv4_tcp_reflect_tos_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_CUSTOM("tcp_ehash_entries", 0444,
+			0,
+			ipv4_tcp_ehash_entries_data,
+			proc_tcp_ehash_entries),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("tcp_child_ehash_entries", 0644,
+			ipv4_tcp_child_ehash_entries_data,
+			SYSCTL_UINT_ZERO, &tcp_child_ehash_entries_max),
+	SYSCTL_FIELD_CUSTOM("udp_hash_entries", 0444,
+			0,
+			ipv4_udp_hash_entries_data,
+			proc_udp_hash_entries),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("udp_child_hash_entries", 0644,
+			ipv4_udp_child_hash_entries_data,
+			SYSCTL_UINT_ZERO, &udp_child_hash_entries_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("udp_rmem_min", 0644,
+			ipv4_udp_rmem_min_data, SYSCTL_ONE, NULL),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("udp_wmem_min", 0644,
+			ipv4_udp_wmem_min_data, SYSCTL_ONE, NULL),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("fib_notify_on_flag_change", 0644,
+			ipv4_fib_notify_on_flag_change_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_TWO),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_plb_enabled", 0644,
+			ipv4_tcp_plb_enabled_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_plb_idle_rehash_rounds", 0644,
+			ipv4_tcp_plb_idle_rehash_rounds_data,
+			NULL, &tcp_plb_max_rounds),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_plb_rehash_rounds", 0644,
+			ipv4_tcp_plb_rehash_rounds_data,
+			NULL, &tcp_plb_max_rounds),
+	SYSCTL_FIELD_U8("tcp_plb_suspend_rto_sec", 0644,
+			ipv4_tcp_plb_suspend_rto_sec_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_plb_cong_thresh", 0644,
+			ipv4_tcp_plb_cong_thresh_data,
+			SYSCTL_ZERO, &tcp_plb_max_cong_thresh),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_syn_linear_timeouts", 0644,
+			ipv4_tcp_syn_linear_timeouts_data,
+			SYSCTL_UINT_ZERO, &tcp_syn_linear_timeouts_max),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_shrink_window", 0644,
+			ipv4_tcp_shrink_window_data,
+			SYSCTL_UINT_ZERO, SYSCTL_UINT_ONE),
+	SYSCTL_FIELD_STATIC_U8_MINMAX("tcp_pingpong_thresh", 0644,
+			ipv4_tcp_pingpong_thresh_data,
+			SYSCTL_UINT_ONE, NULL),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_rto_min_us", 0644,
+			ipv4_tcp_rto_min_us_data,
+			SYSCTL_ONE, NULL),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("tcp_rto_max_ms", 0644,
+			ipv4_tcp_rto_max_ms_data,
+			SYSCTL_ONE_THOUSAND, &tcp_rto_max_max),
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(ipv4_net_table);
-	struct ctl_table *table;
-
-	table = ipv4_net_table;
-	if (!net_eq(net, &init_net)) {
-		int i;
-
-		table = kmemdup(table, sizeof(ipv4_net_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-
-		for (i = 0; i < table_size; i++) {
-			if (table[i].data) {
-				/* Update the variables to point into
-				 * the current struct net
-				 */
-				table[i].data += (void *)net - (void *)&init_net;
-			} else {
-				/* Entries without data pointer are global;
-				 * Make them read-only in non-init_net ns
-				 */
-				table[i].mode &= ~0222;
-			}
-		}
-	}
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
-						    table_size);
+	net->ipv4.ipv4_hdr = register_sysctl_fields(&net->sysctls, "net/ipv4",
+						    ipv4_net_table, &ctx);
 	if (!net->ipv4.ipv4_hdr)
-		goto err_reg;
+		return -ENOMEM;
 
 	net->ipv4.sysctl_local_reserved_ports = kzalloc(65536 / 8, GFP_KERNEL);
 	if (!net->ipv4.sysctl_local_reserved_ports)
@@ -1694,21 +1198,13 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 
 err_ports:
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
 	return -ENOMEM;
 }
 
 static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
-	const struct ctl_table *table;
-
 	kfree(net->ipv4.sysctl_local_reserved_ports);
-	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
-	kfree(table);
 }
 
 static __net_initdata struct pernet_operations ipv4_sysctl_ops = {
-- 
2.55.0

