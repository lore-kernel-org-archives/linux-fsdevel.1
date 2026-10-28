Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205433;
	b=SYFCnqkGVFxjHfjYF/Za4X/yInUXG2ToT+JRezDyOM4nXC+Sm/K6TDLZM2o20pLptecc
	 PgfR3cDKpcof9yeA5zI2/xkvzdYlURxcTabgmM9gDK0v1wbNMNBMwS3Hvp/v9Sryyt1eB
	 NUE3hLUrJaKULJW9acZtL515d3UEPmriVVDQh2zCN2XM5pTT2VOa/0fdJUD3T6XBJooAn
	 6v25AinpTdul6fhnzEoBMBcd431GXHkHTxVS/dDCP7Q00fpGE1QB1PKx9QWCsmBfbcjiN
	 UF99jKPceh0BGbC+eMjWEUMzRznY5qrxlWF0Z3/8rnN0pqqfdRT2jJtImW4yWOJ0WYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205433;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yIBbdyH3VXoz5kksRGrcB3iYEpjFONN2X88/N729b7w=;
	b=Sv7nqiqhdsZ9+7m6Li5bGl14IiUFcmfASnpoe9H5z8lwN/KMBIK6X95SGAWMQcpEEILA
	 PQUUFLHpt5tgHiAeO/M9bPrxTnD0rQ2qmQ+KDXJsl3Kp6PvPIWdN21NSTEmgKAQaU/0Qz
	 j4XivtAd1V8tRwoo1LwZGQYy9q/fztbkriKhg/83oY20f5zBR62Y4F0gsB0Cw40/tvTdc
	 SQ3EXHF5RPeG3JyxENek1/x45I9s6FXQMgvtSH9vtfpCzYDrXtY0Sb72STQVR+/qfI15X
	 fV1MvDHilVMlS+H6Ipp54BChhzTyzbs1j0WnIYsvY1WUNnq10KbDRZWSQ+R3fHHQvow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TY5pnjQW;
	arc=none smtp.remote-ip=91.218.175.41
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D460A2601
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488D460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TY5pnjQW
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EL4wI9r36SXGoiLZdY7tMjUY+kK/UAknqR7XBHxJ+cI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205431; v=1; x=1793810231;
 b=TY5pnjQWSIAFfWo3gOrHT9B8tGeQ7aVgHuFoIfDUfq8Qbb7F1vWh5vKG/OB16DdM5q96yY3d
 pdMnPM9uW7Gj3RPByAK7CNdGdiy1k5rdaCbaqq997FLzL7wzWJQEUkvuaL0XqyTpUgU7kYjPGx6
 eVEA1TYZPQ6Y+dqS2utLEC6M=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 092b8aa10bf1cf43;
	Wed, 28 Oct 2026 16:37:11 +0000
X-Mizu-Trace-ID: 092b8aa10bf1cf43
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/39] sysctl: store RPC sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:55 +0800
Message-Id: <72a22bf4aae7f5732f4ec2da349a84326e0a3bee.1793204511.git.wen.yang@linux.dev>
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

Replace RPC bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/sunrpc/xprtrdma/svc_rdma.c  | 39 ++++++++++++++-------------------
 net/sunrpc/xprtrdma/transport.c | 27 +++++++++--------------
 net/sunrpc/xprtsock.c           | 26 +++++++++-------------
 3 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f67f0612b1a9..0ba54bf6bc7c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -53,17 +53,10 @@
 
 /* RPC/RDMA parameters */
 unsigned int svcrdma_ord = 16;	/* historical default */
-static unsigned int min_ord = 1;
-static unsigned int max_ord = 255;
 unsigned int svcrdma_max_requests = RPCRDMA_MAX_REQUESTS;
 unsigned int svcrdma_max_bc_requests = RPCRDMA_MAX_BC_REQUESTS;
-static unsigned int min_max_requests = 4;
-static unsigned int max_max_requests = 16384;
 unsigned int svcrdma_max_req_size = RPCRDMA_DEF_INLINE_THRESH;
-static unsigned int min_max_inline = RPCRDMA_DEF_INLINE_THRESH;
-static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
 static unsigned int svcrdma_stat_unused;
-static unsigned int zero;
 
 struct percpu_counter svcrdma_stat_read;
 struct percpu_counter svcrdma_stat_recv;
@@ -114,8 +107,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_max_requests,
-		.extra2		= &max_max_requests
+		.min		= 4,
+		.max		= 16384
 	},
 	{
 		.procname	= "max_req_size",
@@ -123,8 +116,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_max_inline,
-		.extra2		= &max_max_inline
+		.min		= RPCRDMA_DEF_INLINE_THRESH,
+		.max		= RPCRDMA_MAX_INLINE_THRESH
 	},
 	{
 		.procname	= "max_outbound_read_requests",
@@ -132,8 +125,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_ord,
-		.extra2		= &max_ord,
+		.min		= 1,
+		.max		= 255,
 	},
 
 	{
@@ -170,8 +163,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.min		= 0,
+		.max		= 0,
 	},
 	{
 		.procname	= "rdma_stat_rq_poll",
@@ -179,8 +172,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.min		= 0,
+		.max		= 0,
 	},
 	{
 		.procname	= "rdma_stat_rq_prod",
@@ -188,8 +181,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.min		= 0,
+		.max		= 0,
 	},
 	{
 		.procname	= "rdma_stat_sq_poll",
@@ -197,8 +190,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.min		= 0,
+		.max		= 0,
 	},
 	{
 		.procname	= "rdma_stat_sq_prod",
@@ -206,8 +199,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.min		= 0,
+		.max		= 0,
 	},
 };
 
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index d4e6746d8ecd..ef84dde20228 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -73,13 +73,6 @@ static struct xprt_class xprt_rdma;
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 
-static unsigned int min_slot_table_size = RPCRDMA_MIN_SLOT_TABLE;
-static unsigned int max_slot_table_size = RPCRDMA_MAX_SLOT_TABLE;
-static unsigned int min_inline_size = RPCRDMA_MIN_INLINE;
-static unsigned int max_inline_size = RPCRDMA_MAX_INLINE;
-static unsigned int max_padding = PAGE_SIZE;
-static unsigned int min_memreg = RPCRDMA_BOUNCEBUFFERS;
-static unsigned int max_memreg = RPCRDMA_LAST - 1;
 static unsigned int dummy;
 
 static struct ctl_table_header *sunrpc_table_header;
@@ -91,8 +84,8 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_slot_table_size,
-		.extra2		= &max_slot_table_size
+		.min		= RPCRDMA_MIN_SLOT_TABLE,
+		.max		= RPCRDMA_MAX_SLOT_TABLE
 	},
 	{
 		.procname	= "rdma_max_inline_read",
@@ -100,8 +93,8 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_inline_size,
-		.extra2		= &max_inline_size,
+		.min		= RPCRDMA_MIN_INLINE,
+		.max		= RPCRDMA_MAX_INLINE,
 	},
 	{
 		.procname	= "rdma_max_inline_write",
@@ -109,8 +102,8 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_inline_size,
-		.extra2		= &max_inline_size,
+		.min		= RPCRDMA_MIN_INLINE,
+		.max		= RPCRDMA_MAX_INLINE,
 	},
 	{
 		.procname	= "rdma_inline_write_padding",
@@ -118,8 +111,8 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &max_padding,
+		.min		= 0,
+		.max		= PAGE_SIZE,
 	},
 	{
 		.procname	= "rdma_memreg_strategy",
@@ -127,8 +120,8 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_memreg,
-		.extra2		= &max_memreg,
+		.min		= RPCRDMA_BOUNCEBUFFERS,
+		.max		= RPCRDMA_LAST - 1,
 	},
 	{
 		.procname	= "rdma_pad_optimize",
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 59e36f206ccf..a15f54bf2b3c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -88,12 +88,6 @@ static unsigned int xs_tcp_fin_timeout __read_mostly = XS_TCP_LINGER_TO;
  * someone else's file names!
  */
 
-static unsigned int min_slot_table_size = RPC_MIN_SLOT_TABLE;
-static unsigned int max_slot_table_size = RPC_MAX_SLOT_TABLE;
-static unsigned int max_tcp_slot_table_limit = RPC_MAX_SLOT_TABLE_LIMIT;
-static unsigned int xprt_min_resvport_limit = RPC_MIN_RESVPORT;
-static unsigned int xprt_max_resvport_limit = RPC_MAX_RESVPORT;
-
 static struct ctl_table_header *sunrpc_table_header;
 
 static struct xprt_class xs_local_transport;
@@ -113,8 +107,8 @@ static struct ctl_table xs_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_slot_table_size,
-		.extra2		= &max_slot_table_size
+		.min		= RPC_MIN_SLOT_TABLE,
+		.max		= RPC_MAX_SLOT_TABLE
 	},
 	{
 		.procname	= "tcp_slot_table_entries",
@@ -122,8 +116,8 @@ static struct ctl_table xs_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_slot_table_size,
-		.extra2		= &max_slot_table_size
+		.min		= RPC_MIN_SLOT_TABLE,
+		.max		= RPC_MAX_SLOT_TABLE
 	},
 	{
 		.procname	= "tcp_max_slot_table_entries",
@@ -131,8 +125,8 @@ static struct ctl_table xs_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_slot_table_size,
-		.extra2		= &max_tcp_slot_table_limit
+		.min		= RPC_MIN_SLOT_TABLE,
+		.max		= RPC_MAX_SLOT_TABLE_LIMIT
 	},
 	{
 		.procname	= "min_resvport",
@@ -140,8 +134,8 @@ static struct ctl_table xs_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xprt_min_resvport_limit,
-		.extra2		= &xprt_max_resvport_limit
+		.min		= RPC_MIN_RESVPORT,
+		.max		= RPC_MAX_RESVPORT
 	},
 	{
 		.procname	= "max_resvport",
@@ -149,8 +143,8 @@ static struct ctl_table xs_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xprt_min_resvport_limit,
-		.extra2		= &xprt_max_resvport_limit
+		.min		= RPC_MIN_RESVPORT,
+		.max		= RPC_MAX_RESVPORT
 	},
 	{
 		.procname	= "tcp_fin_timeout",
-- 
2.25.1

