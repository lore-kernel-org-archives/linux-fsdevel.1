Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205460;
	b=hrESinawePWm/8QcA2GhM4ep/i/TVFOpbNZwu5yEvaZakjFB4hj/BucyFGdcPU46whBa
	 kvn0b7oByTveHjvBLp5uVPJCs2FD3DOna4YQvBOONZQkmdvE0aIUU8ozzQ266E78xQ71Q
	 /91odXAvoj35HeCN9nOczC4Yqmi5bp2SGdiWtlv/NVbu1hr9xM9Z1SP/6vd9YmTipkELq
	 zrgEQwqiel2JRL47P2axg44YS/HvmVZ0wvoM+kLcthI/CcRhewE4ZxqRiU/xSbvHR3U6L
	 JDrmJ38TMzRSBJJdXf+A5d5KtYwMEx7jKW43RtMW0J0Ka3/QYDrPcY4EcQXH7ZnSOsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205460;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7JucHh4NemfScMfrPhJyw1dabZHh3EJb7/JnZi+Juu0=;
	b=O/c0J4wQK4Xxbr7ihNxuvT3IyMO5cUQNkG1iLNpIPi/+sHUW1XVcYtUwlf/LHahd0vUN
	 m9/I4n0toIUzeXC8vZsKpRdhZ+jkSL+mRsHPGoYkg07UlmyasRQv5mprt6wUQ8C9cfNXh
	 4vawoF271BV3kTuMNSNmaxT87ROrC0B3evaKIXlcH9kYU//wiEJg5UpBpnCyRBZoQ1LX2
	 JfEbzcJw32fZoDjaZ96miSrhYKL7JrgjmlmCEsjXZ7VjMCDlUckfJvDx9v+DWAGyq4QUD
	 4yYx0+vUaAW2megtqotab08PaP7WZsfL45OR3MS0DGaAMSfr4ZoxLhFTyVPO2g+plLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S3BXY449;
	arc=none smtp.remote-ip=95.215.58.57
Received: from mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A6606A339
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C7A6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S3BXY449
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EFkCMdQsk2IlNAnlNkh23+CTmwpAtlDo9ZCNbrQC/NQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205457; v=1; x=1793810257;
 b=S3BXY449Lg9ZYZBXjxMMmXngORtIRlHGeQuArVLOda84qOxttRHnQBEzmWhb2E7fvg5b/96f
 vSf/xwK/AbEVfm0BfhD+NC7qWTWvK0elSPA7j8o1zMQcHcTN6ut8LyQUHF/uVIeDJsseHepKALp
 9P/jqLySiE+8hKBy5X3+8Wwg=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 62d9b73d9e458bf3;
	Wed, 28 Oct 2026 16:37:37 +0000
X-Mizu-Trace-ID: 62d9b73d9e458bf3
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 22/39] sysctl: refresh namespace IPC bounds per call
Date: Thu, 29 Oct 2026 00:35:01 +0800
Message-Id: <58dd9ba3bf6aab4977608238c0973d9ac2f03f72.1793204511.git.wen.yang@linux.dev>
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

Refresh IPC limits before validating namespace sysctl writes.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 ipc/ipc_sysctl.c | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index e02e2ea70907..29a1f442c503 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/limits.h>
 #include <linux/ipc.h>
 #include <linux/nsproxy.h>
 #include <linux/sysctl.h>
@@ -74,6 +73,15 @@ int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
 
+static int proc_ipc_mni(const struct ctl_table *table, int write,
+			void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(ipc_mni);
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static const struct ctl_table ipc_sysctls[] = {
 	{
 		.procname	= "shmmax",
@@ -98,9 +106,9 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ipc_mni,
+		.proc_handler	= proc_ipc_mni,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -108,8 +116,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "msgmax",
@@ -117,17 +125,17 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "msgmni",
 		.data		= &init_ipc_ns.msg_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ipc_mni,
+		.proc_handler	= proc_ipc_mni,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "auto_msgmni",
@@ -135,8 +143,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_auto_msgmni,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	=  "msgmnb",
@@ -144,8 +152,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "sem",
@@ -161,8 +169,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "msg_next_id",
@@ -170,8 +178,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "shm_next_id",
@@ -179,8 +187,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 #endif
 };
-- 
2.25.1

