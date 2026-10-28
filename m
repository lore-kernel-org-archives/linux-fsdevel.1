Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205482;
	b=f42ENgEKUs3eFUG41Q6ulkD4FKP68OCf3UM/KWfIqyQfKVd549TK2POJFl4M3uzPJthF
	 drcxtvrF6Q1XNaJ/4xEip8A+2DJtv/QwxXFtScCCdJjs/ekryDgw/0fycRIKXMX6Y0H6y
	 zExB60KyYKNxnRCP6SWOUMw8RvBLs0UkIeJD+RVI5HaHVq84qPunD1zETNlZc96UhcnHY
	 RLYNu5hx1U5umzqNChYPcN9jw8yIRAZY39XoA6Fx1VS3EfaFT7O6aE7WDCQWokCz4pW0F
	 iSrPh9zqqRDzsbHnvxYQXkfvSJBT0rrXdkiLGSBKDfgQvlY2zJAv/ql6E4PbgknwsQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205482;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FtclOtCgXooLIQRTp0FF9P3qGM8G8rDN9jAbEaUKu3U=;
	b=wePpDcT14evYEcoBBW3kQp/Ce0kUuc3fTZNPs0uXKDrNN86ZUymM6gq+u27SpvHp8izd
	 WxGLGmQvf037c90fEaG3/3mo8WZLdOnnilXHh4jEm8Ga9O2xDalgePvmIHMVVOatGSFeD
	 xD+uWLPp0RDE5ciZ1wI1hqoxskQqTUxSoWT0Ft1xTOPg8AvRMieYqipONU9EgMX0ITBTw
	 gITAxz3QKnJB3nffRhyV9SYeDPwIwY4LjyvEDkHapsDxoboabaN5KCF2SsA4FoqGwrbeD
	 YhAj5xPlH3szB512ppGjwKRyeUU3NaU0/9eWricrhNm/ctGL3xbx3FP06177BF75WzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K0G47Sfv;
	arc=none smtp.remote-ip=91.218.175.63
Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A6606A334
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF6A6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K0G47Sfv
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=50AmUTYZ8jpv5bLYpeu0x/rRQpvatmnLmi9j18Gept8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205480; v=1; x=1793810280;
 b=K0G47SfvSs9RF4AAfEXGsSpL6YPsl/Y032YTa6pAqf1h7nuCadsn5aGeB+OyJpiMmmz35EId
 pmOKV3uBWdH02WqLc/lbKwoDF2jHHvkVGdSwiudeP+kx4V4+rK7vG2tXLbCVLdzSYT4OqCDLR0C
 iITEU5+vPNOdMLLgrWWBsFm4=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d58c7c328c62d158;
	Wed, 28 Oct 2026 16:38:00 +0000
X-Mizu-Trace-ID: d58c7c328c62d158
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 26/39] rds: preserve live reconnect limits with numeric bounds
Date: Thu, 29 Oct 2026 00:35:05 +0800
Message-Id: <0c70ce4df6dfb6c149ac874691f97615f89c6bae.1793204511.git.wen.yang@linux.dev>
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

Refresh reconnect bounds while preserving jiffies conversion.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/rds/sysctl.c | 32 +++++++++++++++++++++++++-------
 net/rds/tcp.c    | 11 +++++------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index 025f518a4349..b32213b8ad96 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -39,7 +39,6 @@
 static struct ctl_table_header *rds_sysctl_reg_table;
 
 static unsigned long rds_sysctl_reconnect_min = 1;
-static unsigned long rds_sysctl_reconnect_max = ~0UL;
 
 unsigned long rds_sysctl_reconnect_min_jiffies;
 unsigned long rds_sysctl_reconnect_max_jiffies = HZ;
@@ -49,24 +48,43 @@ unsigned int  rds_sysctl_max_unacked_bytes = (16 << 20);
 
 unsigned int rds_sysctl_ping_enable = 1;
 
+static int rds_reconnect_min_handler(const struct ctl_table *table, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(rds_sysctl_reconnect_min);
+	tmp.max = READ_ONCE(rds_sysctl_reconnect_max_jiffies);
+	return proc_doulongvec_ms_jiffies_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int rds_reconnect_max_handler(const struct ctl_table *table, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.min = READ_ONCE(rds_sysctl_reconnect_min_jiffies);
+	return proc_doulongvec_ms_jiffies_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table rds_sysctl_rds_table[] = {
 	{
 		.procname       = "reconnect_min_delay_ms",
 		.data		= &rds_sysctl_reconnect_min_jiffies,
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
-		.proc_handler   = proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= &rds_sysctl_reconnect_min,
-		.extra2		= &rds_sysctl_reconnect_max_jiffies,
+		.proc_handler   = rds_reconnect_min_handler,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname       = "reconnect_max_delay_ms",
 		.data		= &rds_sysctl_reconnect_max_jiffies,
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
-		.proc_handler   = proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= &rds_sysctl_reconnect_min_jiffies,
-		.extra2		= &rds_sysctl_reconnect_max,
+		.proc_handler   = rds_reconnect_max_handler,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "max_unacked_packets",
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 774a71f88d37..4c1d1c3696b2 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -58,9 +58,6 @@ static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
 static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *fpos);
 
-static int rds_tcp_min_sndbuf = SOCK_MIN_SNDBUF;
-static int rds_tcp_min_rcvbuf = SOCK_MIN_RCVBUF;
-
 static struct ctl_table rds_tcp_sysctl_table[] = {
 #define	RDS_TCP_SNDBUF	0
 	{
@@ -69,7 +66,8 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = rds_tcp_sndbuf_handler,
-		.extra1		= &rds_tcp_min_sndbuf,
+		.min		= SOCK_MIN_SNDBUF,
+		.max		= INT_MAX,
 	},
 #define	RDS_TCP_RCVBUF	1
 	{
@@ -78,7 +76,8 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = rds_tcp_rcvbuf_handler,
-		.extra1		= &rds_tcp_min_rcvbuf,
+		.min		= SOCK_MIN_RCVBUF,
+		.max		= INT_MAX,
 	},
 };
 
@@ -764,7 +763,7 @@ static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
 	err = proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
 	if (err < 0) {
 		pr_warn("Invalid input. Must be >= %d\n",
-			*(int *)(ctl->extra1));
+			(int)ctl->min);
 		return err;
 	}
 
-- 
2.25.1

