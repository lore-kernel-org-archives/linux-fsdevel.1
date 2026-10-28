Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205486;
	b=TA7sg41jfNtCSoYDlj+BeQxRtRieMWjNPWl6noBwUsY25HSzivOzc17KUIwfKlHlUETb
	 nPnO+rxysqJLgLCxONTXDuBXse6kxkkxjHiOPAqEXrCrvenxsa4wNYCqsPGrBROCNuKrJ
	 LpVwo7Aagg56Ieo/Qd+jbtlXxeeLM59SQpn2jYSsR+9C344nJBwQr4AEycgWrFo2KsoP6
	 BFlfnZz8SDRMFpTUswEodjJ0iZv6y4mynlOv+yCC9QGde1y9Sqe1wR72WfeeIbXR/Yd1N
	 rxY86VgXuXx38XSbhXv58j1BbyhK6Wg03qjpw1uIVpJwmSI6zVcjfQbuWwCKQOkzS+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205486;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g6qIZZ0kwjetplccW2Tw279effYgAmQRtoorqX9PAQM=;
	b=cMkj4luIgoAZENAjHCNiQDPDSroszpeygid2DYcx5Qyluvk8FW8Jusb4Yc/0ewJulfgu
	 GfGPfeeRwRFM9RMONbKnW3Mq6VVjStdZvirs6zSNwi8jZINzuPLYEYSq67UibO8wTTab6
	 aKIkdsNCgTBzZUoxLbklcMbBo0Yn0yDyN+nkK9TtZYLphOcu1Byvwy4oRBuRBq92ztt5S
	 bgSE2Ojv5CBBUHhBJzcVp6TjD2GOyI0IvhZWdzisb8M3Z4yNqdnwh/+ZNyjC4fJLT5dXm
	 pfCItpndwTQn5SxflCQSMA53KVweHU/wTkZ2qekhFX8TNSuzvwL5x9hQzsU3ghKBddw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oKgbvM3N;
	arc=none smtp.remote-ip=91.218.175.65
Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026360A6F53
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7026360A6F53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oKgbvM3N
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FQTDZa9AS0xscMcx+hobeZxF5K53xkSfoNGBe/xWAx0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205483; v=1; x=1793810283;
 b=oKgbvM3NquZiXBtvN3/4Qy3uJ9NfGb/giXxLWtkqyJaFzJ4SPBFWtmcJdTc2ne86DIG5OHeu
 aTWNI8yVM7dcD3I8ziri8f1EntELmvrEbVtgzmvi5JWSGtO12wS2PH2ysuLOKnCTQRftbqdyQze
 TYl5+CUZIsN6dnd+h07fXp78=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2531a95dcbf76c45;
	Wed, 28 Oct 2026 16:38:03 +0000
X-Mizu-Trace-ID: 2531a95dcbf76c45
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 27/39] ipv4: preserve live and vector bounds with numeric sysctls
Date: Thu, 29 Oct 2026 00:35:06 +0800
Message-Id: <e46d16dd7da370a0b831895db51cab30fa15a3b2.1793204511.git.wen.yang@linux.dev>
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

Use numeric port and group limits and refresh TCP reordering bounds.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/ipv4/sysctl_net_ipv4.c | 334 +++++++++++++++++++------------------
 1 file changed, 169 insertions(+), 165 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 2ed9f59ea747..4226ce923534 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/sysctl.h>
-#include <linux/limits.h>
 #include <linux/seqlock.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -21,38 +20,6 @@
 #include <net/protocol.h>
 #include <net/netevent.h>
 
-static int tcp_retr1_max = 255;
-static int ip_local_port_range_min[] = { 1, 1 };
-static int ip_local_port_range_max[] = { 65535, 65535 };
-static int tcp_adv_win_scale_min = -31;
-static int tcp_adv_win_scale_max = 31;
-static int tcp_app_win_max = 31;
-static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
-static int tcp_min_snd_mss_max = 65535;
-static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
-static int ip_privileged_port_min;
-static int ip_privileged_port_max = 65535;
-static int ip_ttl_min = 1;
-static int ip_ttl_max = 255;
-static int tcp_syn_retries_min = 1;
-static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
-static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
-static unsigned long ip_ping_group_range_min[] = { 0, 0 };
-static unsigned long ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
-static u32 u32_max_div_HZ = UINT_MAX / HZ;
-static int one_day_secs = 24 * 3600;
-static u32 fib_multipath_hash_fields_all_mask __maybe_unused =
-	FIB_MULTIPATH_HASH_FIELD_ALL_MASK;
-static unsigned int tcp_child_ehash_entries_max = 16 * 1024 * 1024;
-static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
-static int tcp_plb_max_rounds = 31;
-static int tcp_plb_max_cong_thresh = 256;
-static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 5;
-static u32 icmp_errors_extension_mask_all =
-	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
-
-static int tcp_min_rcvbuf = 4096;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -80,8 +47,8 @@ static int ipv4_local_port_range(const struct ctl_table *table, int write,
 		.data = &range,
 		.maxlen = sizeof(range),
 		.mode = table->mode,
-		.extra1 = &ip_local_port_range_min,
-		.extra2 = &ip_local_port_range_max,
+		.min = 1,
+		.max = 65535,
 	};
 
 	inet_get_local_port_range(net, &range[0], &range[1]);
@@ -116,8 +83,8 @@ static int ipv4_privileged_ports(const struct ctl_table *table, int write,
 		.data = &pports,
 		.maxlen = sizeof(pports),
 		.mode = table->mode,
-		.extra1 = &ip_privileged_port_min,
-		.extra2 = &ip_privileged_port_max,
+		.min = 0,
+		.max = 65535,
 	};
 
 	pports = READ_ONCE(net->ipv4.sysctl_ip_prot_sock);
@@ -178,8 +145,8 @@ static int ipv4_ping_group_range(const struct ctl_table *table, int write,
 		.data = &urange,
 		.maxlen = sizeof(urange),
 		.mode = table->mode,
-		.extra1 = &ip_ping_group_range_min,
-		.extra2 = &ip_ping_group_range_max,
+		.min = 0,
+		.max = GID_T_MAX,
 	};
 
 	inet_get_ping_group_range_table(table, &low, &high);
@@ -530,6 +497,27 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
 
 #endif
 
+static int proc_tcp_reordering(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(table->data, struct net,
+				       ipv4.sysctl_tcp_reordering);
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(net->ipv4.sysctl_tcp_max_reordering);
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int proc_fib_sync_mem(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(sysctl_fib_sync_mem_min);
+	tmp.max = READ_ONCE(sysctl_fib_sync_mem_max);
+	return proc_douintvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table ipv4_table[] = {
 	{
 		.procname	= "tcp_max_orphans",
@@ -625,9 +613,9 @@ static struct ctl_table ipv4_table[] = {
 		.data		= &sysctl_fib_sync_mem,
 		.maxlen		= sizeof(sysctl_fib_sync_mem),
 		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= &sysctl_fib_sync_mem_min,
-		.extra2		= &sysctl_fib_sync_mem_max,
+		.proc_handler	= proc_fib_sync_mem,
+		.min		= 0,
+		.max		= UINT_MAX,
 	},
 };
 
@@ -645,8 +633,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "icmp_echo_enable_probe",
@@ -654,8 +642,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "icmp_echo_ignore_broadcasts",
@@ -663,8 +651,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "icmp_ignore_bogus_error_responses",
@@ -672,8 +660,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "icmp_errors_use_inbound_ifaddr",
@@ -681,8 +669,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "icmp_errors_extension_mask",
@@ -690,8 +678,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &icmp_errors_extension_mask_all,
+		.min		= 0,
+		.max		= GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0),
 	},
 	{
 		.procname	= "icmp_ratelimit",
@@ -713,7 +701,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "icmp_msgs_burst",
@@ -721,7 +710,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "ping_group_range",
@@ -737,8 +727,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	{
@@ -747,8 +737,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_ecn_mode_max,
+		.min		= 0,
+		.max		= 5,
 	},
 	{
 		.procname	= "tcp_ecn_option",
@@ -756,8 +746,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
+		.min		= 0,
+		.max		= 3,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
@@ -765,8 +755,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
+		.min		= 0,
+		.max		= 3,
 	},
 	{
 		.procname	= "tcp_ecn_fallback",
@@ -774,8 +764,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "ip_dynaddr",
@@ -801,8 +791,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.min           = 0,
-		.max           = U8_MAX,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname       = "tcp_early_demux",
@@ -810,8 +800,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.min           = 0,
-		.max           = U8_MAX,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname       = "nexthop_compat_mode",
@@ -819,8 +809,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "ip_default_ttl",
@@ -828,8 +818,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= &ip_ttl_min,
-		.extra2		= &ip_ttl_max,
+		.min		= 1,
+		.max		= 255,
 	},
 	{
 		.procname	= "ip_local_port_range",
@@ -876,8 +866,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler   = ipv4_fwd_update_priority,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "ip_nonlocal_bind",
@@ -894,8 +884,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "fwmark_reflect",
@@ -922,8 +912,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	{
@@ -948,8 +938,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_min_snd_mss_min,
-		.extra2		= &tcp_min_snd_mss_max,
+		.min		= TCP_MIN_SND_MSS,
+		.max		= 65535,
 	},
 	{
 		.procname	= "tcp_mtu_probe_floor",
@@ -957,8 +947,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_min_snd_mss_min,
-		.extra2		= &tcp_min_snd_mss_max,
+		.min		= TCP_MIN_SND_MSS,
+		.max		= 65535,
 	},
 	{
 		.procname	= "tcp_probe_threshold",
@@ -973,7 +963,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u32),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra2		= &u32_max_div_HZ,
+		.max		= UINT_MAX / HZ,
+		.min		= 0,
 	},
 	{
 		.procname	= "igmp_link_local_mcast_reports",
@@ -1005,7 +996,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 #endif
 	{
@@ -1056,8 +1048,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= &tcp_syn_retries_min,
-		.extra2		= &tcp_syn_retries_max
+		.min		= 1,
+		.max		= MAX_TCP_SYNCNT
 	},
 	{
 		.procname	= "tcp_synack_retries",
@@ -1085,17 +1077,17 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "tcp_reordering",
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &init_net.ipv4.sysctl_tcp_max_reordering,
+		.proc_handler	= proc_tcp_reordering,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "tcp_retries1",
@@ -1103,7 +1095,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra2		= &tcp_retr1_max
+		.max		= 255,
+		.min		= 0,
 	},
 	{
 		.procname	= "tcp_retries2",
@@ -1143,8 +1136,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "tcp_tw_reuse_delay",
@@ -1152,8 +1145,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &tcp_tw_reuse_delay_max,
+		.min		= 1,
+		.max		= TCP_PAWS_MSL * MSEC_PER_SEC,
 	},
 	{
 		.procname	= "tcp_max_syn_backlog",
@@ -1187,7 +1180,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_tfo_blackhole_detect_timeout,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	{
@@ -1196,8 +1190,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "fib_multipath_hash_policy",
@@ -1205,8 +1199,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_fib_multipath_hash_policy,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
+		.min		= 0,
+		.max		= 3,
 	},
 	{
 		.procname	= "fib_multipath_hash_fields",
@@ -1214,8 +1208,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u32),
 		.mode		= 0644,
 		.proc_handler	= proc_fib_multipath_hash_fields,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &fib_multipath_hash_fields_all_mask,
+		.min		= 1,
+		.max		= FIB_MULTIPATH_HASH_FIELD_ALL_MASK,
 	},
 	{
 		.procname	= "fib_multipath_hash_seed",
@@ -1223,6 +1217,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u32),
 		.mode		= 0644,
 		.proc_handler	= proc_fib_multipath_hash_seed,
+		.min		= 0,
+		.max		= UINT_MAX,
 	},
 #endif
 	{
@@ -1239,8 +1235,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	{
@@ -1276,8 +1272,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_FOUR,
+		.min		= 0,
+		.max		= 4,
 	},
 	{
 		.procname	= "tcp_recovery",
@@ -1294,8 +1290,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.min           = 0,
-		.max           = U8_MAX,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_slow_start_after_idle",
@@ -1357,7 +1353,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "tcp_dsack",
@@ -1374,8 +1371,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_app_win_max,
+		.min		= 0,
+		.max		= 31,
 	},
 	{
 		.procname	= "tcp_adv_win_scale",
@@ -1383,8 +1380,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_adv_win_scale_min,
-		.extra2		= &tcp_adv_win_scale_max,
+		.min		= (unsigned long)-31,
+		.max		= 31,
 	},
 	{
 		.procname	= "tcp_frto",
@@ -1410,8 +1407,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "tcp_moderate_rcvbuf",
@@ -1428,8 +1425,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "tcp_tso_win_divisor",
@@ -1469,7 +1466,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_tso_rtt_log",
@@ -1486,8 +1484,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_day_secs
+		.min		= 0,
+		.max		= 24 * 3600
 	},
 	{
 		.procname	= "tcp_autocorking",
@@ -1495,8 +1493,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "tcp_invalid_ratelimit",
@@ -1511,8 +1509,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
+		.min		= 0,
+		.max		= 1000,
 	},
 	{
 		.procname	= "tcp_pacing_ca_ratio",
@@ -1520,8 +1518,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
+		.min		= 0,
+		.max		= 1000,
 	},
 	{
 		.procname	= "tcp_wmem",
@@ -1529,7 +1527,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_wmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "tcp_rmem",
@@ -1537,7 +1536,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &tcp_min_rcvbuf,
+		.min		= 4096,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "tcp_comp_sack_delay_ns",
@@ -1554,8 +1554,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE_THOUSAND,
+		.min		= 1,
+		.max		= 1000,
 	},
 	{
 		.procname	= "tcp_comp_sack_slack_ns",
@@ -1572,7 +1572,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_backlog_ack_defer",
@@ -1580,8 +1581,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname       = "tcp_reflect_tos",
@@ -1589,8 +1590,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "tcp_ehash_entries",
@@ -1604,8 +1605,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_child_ehash_entries_max,
+		.min		= 0,
+		.max		= 16 * 1024 * 1024,
 	},
 	{
 		.procname	= "udp_hash_entries",
@@ -1619,8 +1620,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_child_hash_entries_max,
+		.min		= 0,
+		.max		= UDP_HTABLE_SIZE_MAX,
 	},
 	{
 		.procname	= "udp_rmem_min",
@@ -1628,7 +1629,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_rmem_min),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "udp_wmem_min",
@@ -1636,7 +1638,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_wmem_min),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "fib_notify_on_flag_change",
@@ -1644,8 +1647,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname       = "tcp_plb_enabled",
@@ -1653,8 +1656,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname       = "tcp_plb_idle_rehash_rounds",
@@ -1662,7 +1665,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.extra2		= &tcp_plb_max_rounds,
+		.max		= 31,
+		.min		= 0,
 	},
 	{
 		.procname       = "tcp_plb_rehash_rounds",
@@ -1670,7 +1674,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.extra2         = &tcp_plb_max_rounds,
+		.max		= 31,
+		.min		= 0,
 	},
 	{
 		.procname       = "tcp_plb_suspend_rto_sec",
@@ -1678,8 +1683,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
-		.min           = 0,
-		.max           = U8_MAX,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname       = "tcp_plb_cong_thresh",
@@ -1687,8 +1692,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = &tcp_plb_max_cong_thresh,
+		.min		= 0,
+		.max		= 256,
 	},
 	{
 		.procname	= "tcp_syn_linear_timeouts",
@@ -1696,8 +1701,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &tcp_syn_linear_timeouts_max,
+		.min		= 0,
+		.max		= MAX_TCP_SYNCNT,
 	},
 	{
 		.procname	= "tcp_shrink_window",
@@ -1705,8 +1710,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "tcp_pingpong_thresh",
@@ -1714,7 +1719,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_rto_min_us",
@@ -1722,7 +1728,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "tcp_rto_max_ms",
@@ -1730,8 +1737,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE_THOUSAND,
-		.extra2		= &tcp_rto_max_max,
+		.min		= 1000,
+		.max		= TCP_RTO_MAX_SEC * MSEC_PER_SEC,
 	},
 };
 
@@ -1757,9 +1764,6 @@ static const struct ctl_table *ipv4_net_table_dup(struct net *net)
 			 */
 			table[i].mode &= ~0222;
 		}
-		if (table[i].extra2 >= (void *)&init_net.ipv4 &&
-		    table[i].extra2 < (void *)(&init_net.ipv4 + 1))
-			table[i].extra2 += (void *)net - (void *)&init_net;
 	}
 	return table;
 }
-- 
2.25.1

