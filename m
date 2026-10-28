Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205426;
	b=YrvKXIP3syL0G0egMzHvokT1hbLA81bjjbff6L83+8jzTscSNmPse1q9U8YaJVAGb6jN
	 vlGAyiHAA7VoMSvEbKhpvQOVsUWmjK1dgaGxiM69uXmhP70BXlAaFvlqtGZ2rOkgASFyo
	 V2MlMfnmPCa8lxNeudI+U62bd0Ltn+ciBZXlHMq3JSc+kzkdZ/4acjm80rMOE7tarRoFp
	 UilA+poeHqZlBcy/c1L6bCnkP3gFbmYx+rbKjim7NwGnPtYy0eaK4zMNiMAx6MzJvZNIC
	 dL+w1xI5epjjoK906YTJP+TvqUcCYJWn4lwg84Ox4L+9w8YG4EPmCtb/BGsNpCfAXvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205426;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IeKCWYqKtpgcUC5RjMP5MhUXklCYoTSB6U5/g/mI5U0=;
	b=BLIFy0ove/JWNT3pk0SxZCbXFSre1FNOreucCyCWVmTcEhQIOn3GllSUnfxNW2MJLXVa
	 uaNQsmt8lsQ9ZsofObcsXH62oXUKcySn9aw8l2UwDKXAPYKmJx8Oq9EfFrxqq81OSHr1o
	 0YR2B0KfgxlI+jvdMcSPwVfVJ3hgQ2N9oC+k7LS9GnaGAlvYuDojBfMmFa//b4jcqsLJk
	 7ML401tN81nruF44ByiKfB8R1Zryxy2EltcEN6puR+jjal1Dm6M3s3m9UbDsnUlILjCXy
	 tKROBsILPb6JI/AMc7EulW0Q/w7BvJlBmb+DQWKuET1q4D66hzqnEnbopK9Vh4+94Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mrodQFGh;
	arc=none smtp.remote-ip=95.215.58.30
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020B606A33E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C020B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mrodQFGh
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rwAk+4Aqr+h4kiwUztmmplnKDDREVPn5UXbfGAbBQ20=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205423; v=1; x=1793810223;
 b=mrodQFGhEoANrDKmpR/KNb3DqXnucAx0Aae+cMqDDhwXMZKWMeiTGk5u2HilJUzMzErI+MxO
 bmp7v71FI3B+M7a1Ah6xUw3ZnzGAhNago7mZ1TQKzXyGlE4X9Sy4V9khDns74HWKBNssjWj1SSH
 t90Wt4kgmOo7cCgK86hVnieY=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 78de5ec23f4d5cb7;
	Wed, 28 Oct 2026 16:37:03 +0000
X-Mizu-Trace-ID: 78de5ec23f4d5cb7
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/39] sysctl: store netfilter scalar sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:54 +0800
Message-Id: <364fcbdb84cf987c945fdda85f90198d9ca61bf9.1793204511.git.wen.yang@linux.dev>
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

Replace netfilter bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/netfilter/nf_conntrack_standalone.c | 42 +++++++++++++------------
 net/netfilter/nf_hooks_lwtunnel.c       |  4 +--
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 561db3aecada..65f0c3ab3f2b 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -647,8 +647,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	[NF_SYSCTL_CT_COUNT] = {
 		.procname	= "nf_conntrack_count",
@@ -669,8 +669,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	[NF_SYSCTL_CT_LOG_INVALID] = {
 		.procname	= "nf_conntrack_log_invalid",
@@ -678,6 +678,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= nf_conntrack_log_invalid_sysctl,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	[NF_SYSCTL_CT_EXPECT_MAX] = {
 		.procname	= "nf_conntrack_expect_max",
@@ -685,8 +687,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 	[NF_SYSCTL_CT_ACCT] = {
 		.procname	= "nf_conntrack_acct",
@@ -694,8 +696,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
 	[NF_SYSCTL_CT_EVENTS] = {
@@ -704,8 +706,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
@@ -715,8 +717,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #endif
 	[NF_SYSCTL_CT_PROTO_TIMEOUT_GENERIC] = {
@@ -798,24 +800,24 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	[NF_SYSCTL_CT_PROTO_TCP_LIBERAL] = {
 		.procname       = "nf_conntrack_tcp_be_liberal",
 		.maxlen		= sizeof(u8),
 		.mode           = 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	[NF_SYSCTL_CT_PROTO_TCP_IGNORE_INVALID_RST] = {
 		.procname	= "nf_conntrack_tcp_ignore_invalid_rst",
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	[NF_SYSCTL_CT_PROTO_TCP_MAX_RETRANS] = {
 		.procname	= "nf_conntrack_tcp_max_retrans",
@@ -930,8 +932,8 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/net/netfilter/nf_hooks_lwtunnel.c b/net/netfilter/nf_hooks_lwtunnel.c
index 40c6fce14a63..93339b735dbb 100644
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -37,8 +37,8 @@ int nf_hooks_lwtunnel_sysctl_handler(const struct ctl_table *table, int write,
 		.data = &proc_nf_hooks_lwtunnel_enabled,
 		.maxlen = sizeof(int),
 		.mode = table->mode,
-		.extra1 = SYSCTL_ZERO,
-		.extra2 = SYSCTL_ONE,
+		.min    = 0,
+		.max    = 1,
 	};
 	int ret;
 
-- 
2.25.1

