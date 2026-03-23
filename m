Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861826738B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287934; cv=fail; b=XGM7ne06/Lmmyn00DZ/BifyrA4vrlt+sF3VWKBZcGPCN+cexcCH+8HFiRs9iszR+Wa2Uole0jtx9aAQkOHCT6NLqDjH5zTUzq8H+RKXBxhelm3lKh7jbFuLYo7sOYWTtOWZKvyxMlfQgm4/DzcMNUp8Z0iUjWNREcs2OuuB+a5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287934; c=relaxed/simple;
	bh=BCbMsziT11uduVeHIvqcry2Kr5ChVQq9EHi/2FQHLcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAIvOVdvneH2RcpxfE1JPWT1i9o2ip/rA99fGEFP/Qdr5YrlX100Vr6A0wmDo8yt/ov//4HwLq2pifWJ2sOAkD9CX1tRMJsyM3dyjkljTkO3Zksu7Mm0uwRseeu1W5GMvwAj0idTJnsqzjnMpSBrbpBPfxZGuuTj3iGS4gelCRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=fDPxIYjC; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="fDPxIYjC"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022093.outbound.protection.outlook.com [40.107.209.93]) by mx-outbound23-82.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVkFZ8/SEdeZr1ypapjGbcKxS2l8JY6nDZmdaQXaZ2TdgmpuMhpBwWmajMhbxz+9hr0+Kef5vasLeM0fToSeGBe1GOUpbAJyUhT87TLjxjqe/romo6gxEbTSl8SLv6ZXWCepPnNoZNe6FPcx4kYhoAgkUC/MKBomPdf3/+zIaJfoESlLJJCC4H7yD4VxJYDHl3dDtvBoLk6OWYOHSv/GTvy9XLQTVVMcmAQQwiWNQeaUjy0DtDftFXWdRN1XVJ2p6lAPzqmibrC6ciuGQqDElWCThgbk2A89wGapKuTf/rf/kwPXnKLLgtEXcsowUxDV7YoMmj8t5Lx1QGFRhtiDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjAYgvaHs06TiPgi3X1TKObqXpLiaC9PQVZIgoYId2c=;
 b=lFuyPbNzxk9cPD+XQfzleKzmW0XVJCsqEqHtCBATmUspiXv/LQKVSb6GmjerLnFIImJOqz1Rmb4UKVF+AWGcotbeyW9vQ7/h2NYyaVtwS/+E3QaNGsiXmt88+6IbI9WxQDEL/LkoCq6mo4ZWFfTKqYYH3004RN1e1Oe+yYZVx9Nr7p1CbyJv6L5eeqEZHjz+JZEc+cqZwoLlBRlGIraYZ0d2fDQfbli8L2O0CTlBUG4mac0REdhjEEXaK55nxX9Rb1TzKkCPKvHUGTase5UJ4IraW59tAVw0n4alFBEVIiAvwldNqzT6JbboKf/AXK/KJpMfWOTdmnE8I1h9+KNnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjAYgvaHs06TiPgi3X1TKObqXpLiaC9PQVZIgoYId2c=;
 b=fDPxIYjCy4nCXqb4uM+cQX5BsCNonbdBlzKrYMocjKsoENvngWXKIOkt+hNbFCf8EA1uPBAWb4R0wlCSaV3ucGn+iTvwkbI4jrSoUaLXgmfojVrqB6g0pSf92KLJd+7IPTCUTjG8INQwfRTJ/6H6GmF9zsc6ZsF20p5duQczcuQ=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by DM4PR19MB7860.namprd19.prod.outlook.com (2603:10b6:8:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:19 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::4) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:18 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 387DB15C;
	Mon, 23 Mar 2026 17:45:15 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:07 +0100
Subject: [PATCH 12/19] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=12368;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=1rSR6fOHjaA19eUnaDGpIh7KW3dmcfHCE13c3+ZsuUM=;
 b=wJnEkdGTI/cCrPognCJxjVDBBl1OFoLN/G5bRxDJzh03ApM7NoCwPyp/EvQqEI7bAfY7zZuqM
 AX+0lrwVMDnCh0WFS1y+KHog5FBj6EAkMX3eukI4pbThKN3QFR6JZmD
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DM4PR19MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b87744-f301-4221-bcd7-08de8903f31e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|36860700016|61400799027|376014|48200799018|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	YnM8RBi2ckiZ/SuxfPEzi0b9373+Nx2/3Jr8o+lDSoWWyzUXNEmAzRs1dzyY5wnD/ISVXxbAzfP3Sxuul5iiB5dUIjXMpr/YIksIsPPf0OTTx1N8Ia7kwi0mqXMPe4T+xM9TLHs7nHkooMn0ORQ8EexOMRhD+7aVcNBeY0xygd6LhdHnannc8WbuSMuq58SGHukFlr8A7Awi/J42gEvN0qCfQiJtmEam+Dhk5fl1a2s4zP5xFFPmOUBScBnwJt+r9t0aZ7wklRWPG1o/2ZseBs0JW1MHYYEulD0CljCueKircrsL2dJVa9vbfbpQdzfeyxhFyIcr+Fe8DHVNRUc3zm6P6Z7zCg4Vib4i/sNX12kjy22sG4UZ3qP6p4TgfC6dFwjEq/xDXpUiffH5HzdJ4Z30+h7cDmxLyf1nUpcF5VfESQMYSILys1JuGgv6UcLWGiRsp4Akg6jpZ3v7qGQXUM9jF888rN1SJAFXzTjY+t5JVjPshFmOXSB+b9GOSnFDXAorRNJlOfqKG4T2Woz6RGt/AJ/YKCz/8RihlhvN/42XMyuWMlKnaDUESUyN0MpMjt5OPPsNhEFV1jSe3hlp/pikU75t8rtaaYqxsHBpVa3kQ9Ief6Tv8TTgEDMVtwltyZA95b7Il0QUtGoKUILxpOnSBO/6c1xMC1reUP5abyS8Pdg+hWivajqlhf7eFfGTZlFj+TAZ1Jh0c7z2f9/7KSR+bu9Gk+eZrsb7h8LWVIfFpnnRPJPozlZUV0n2MzLS+fE/uYM0fkkCPM8+PdhfQw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(36860700016)(61400799027)(376014)(48200799018)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1ayTGMx2n8ZmqcHIXs2KpZ6HRXOmNHU80cx9kuI2ESWdMaeT89NswdOtYPWny0OSnI/AiyNgWvVOip2LI14HPhjf72q6CxML+1msYRF3V2POW5oC3SwPTEWVx8qnOi4f0DeXTX0XT23bgADbT4vqDEUKj56vt7WB7cgecUo0B6lc1N+P0O5vwqqf03dVzQFpauo5zW5ufzoBlQ6A9Iszn0h64xoDquFfyINB0PWJQPsqkGQcvfo1c94HqQ/Zxd/EyjC/SOndQ4F3L5z6HBKtGK4bieqtEfr8fjK/a6oMAjb9UMHimVY6tmG6I2qyV6NmYQCqx3nUWgLTIRAaZVEpxj8OIR7om4gLSIQxdQQq7bWjASU0YOdxvZXahuj2gNp8kNVsb1Vh/p6FDx9XZYjj8mQy8Y6zOmJLnWpqt9YXknfRDuSgi6sEtIJM40BLc6AO
X-Exchange-RoutingPolicyChecked:
	Tbd511zSQgRNZu2tlGKy6+ztfWX0RHM469LWwRzkVuwKzKSN3/VCSTiExTdkxeIsNno/Fi0lobVCbz6TdE77kVDdL2BH/7dDds6JlWemdi1lY2hKf27nMxAaBZEu/ZRteP8HpDFmVtKybJOhrbobP0TBlDjKkyLH9BTquhTVk9eyMlXe1Ft9axkOAEqw7mn63uG1JBuNcyBWOULlUKOg0oa0o1urh7HfyMhlGts5LCQbTmOr1HPjw7spz0ouNDi2cRf259W2mnl4QbrL+ENlW592dEYPqrdxnIs7utskM5r7gbLvPpkur5Z2yuUjIY1ZwWYy0dAfCZ8Lyu7XTlmlcQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bUy3+Vau2Cw8oJO8UreLRvGMfiptg75Yp1zvztgnGjQJej+g//4xCaID1oIf5NCEyPRbZEeD8VwOqglGtmnPMXfKzD0uuO9KawNArS2eXHXfSrjczj6XxvFwMSjcEMSPST9esKwqe/I9/DZOBwU06N8goA3qQheaBvvod2p5m/hTisKUjgmE+dPmiDVdLLdnbzT7SPzqo5vYetZ+j4EaeF3GNeeBaBRhsfYjFJc8X2eSvOzS/s2Y1D5W5mW8hipwX3RDtMtU07C/XChF8keN/u7QpOONtUhuhGeVf8FUk1dwYHuPHScvuKuLqR+XW1i9PDShos50Uq4VJYqfzvtzYmyJ8G1lDawKzwuTCCOH27JyHTRb2TpLoEc4mhxDFk6/iV4b592wpy4VhrjvGLn2j/EfxXny/mayUEF5mRlaWv7TJe0VxmsROi1rssSsIDJ6DHYfZWUd+o68mDV7wt0mSA+OIDnH6utfSU1QvDvfZqbkyD3/d7+Go/r+MAceofxFjyachALO2CMf7qiMb9nnB7yiqkjLek3PgcOgdeqPNRaflDG2l7++nJVSBpGj1n8Yuyp+TlB6onbdRORHUU9WHKi6eatFuQkH98NKPk0gt9gWd75Kk/V8IzF10iJuPznCiA27aqWTW7eOrtWl8HFDgg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:18.7498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b87744-f301-4221-bcd7-08de8903f31e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7860
X-BESS-ID: 1774287927-105970-7690-27603-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.209.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGlpZmQGYGUNTSMNnAPDXJzC
	LFwNAk0SzV1NDUIjnV0NQ0zdLc1MLMTKk2FgDXCKQKQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan8-217.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Add synchronous FUSE_INIT processing during mount() to
enable early daemonization with proper error reporting
to the parent process.

A new mount thread is needed that handles FUSE_INIT and
possible other requests at mount time (like getxattr for selinux).
The kernel sends FUSE_INIT during the mount() syscall. Without a thread
to process it, mount() blocks forever.

Mount thread lifetime:
Created before mount() syscall in fuse_start_sync_init_worker()
Processes requests until se->mount_finished is set (after mount() returns)
Joined after successful mount in fuse_wait_sync_init_completion()
Cancelled if mount fails (direct → fusermount3 fallback)
Key changes:

Add init_thread, init_error, mount_finished to struct fuse_session
Use FUSE_DEV_IOC_SYNC_INIT ioctl for kernel support
Fall back to async FUSE_INIT if unsupported
Auto-enabled when fuse_daemonize_active() or via
fuse_session_want_sync_init()
Allows parent to report mount/init failures instead of
exiting immediately after fork.

Note: For now synchronous FUSE_INIT is only supported for privileged
mounts.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 include/fuse_lowlevel.h |  12 +++
 lib/fuse_daemonize.c    |   8 ++
 lib/fuse_i.h            |  16 ++++
 lib/fuse_lowlevel.c     | 192 ++++++++++++++++++++++++++++++++++++++++++++++--
 lib/mount.c             |   5 +-
 lib/mount_fsmount.c     |   5 +-
 6 files changed, 229 insertions(+), 9 deletions(-)

diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index ee0bd8d71d95e4d57ebb4873dca0f2b36e22a649..d8626f85bdaf497534cd2835a589e30f1f4e2466 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2429,6 +2429,18 @@ void fuse_session_process_buf(struct fuse_session *se,
  */
 int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
 
+/**
+ * Request synchronous FUSE_INIT, i.e. FUSE_INIT is handled by the
+ * kernel before mount is returned.
+ *
+ * As FUSE_INIT also starts io-uring ring threads, fork() must not be
+ * called after this if io-uring is enabled. Also see
+ * fuse_session_daemonize_start().
+ *
+ * This must be called before fuse_session_mount() to have any effect.
+ */
+void fuse_session_want_sync_init(struct fuse_session *se);
+
 /**
  * Check if the request is submitted through fuse-io-uring
  */
diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
index 5d191e7d737d04876d02ef6bd526061c003d2ab7..1a32ef74093f231091b4f541e5b9136bff72024f 100644
--- a/lib/fuse_daemonize.c
+++ b/lib/fuse_daemonize.c
@@ -9,6 +9,7 @@
 #define _GNU_SOURCE
 
 #include "fuse_daemonize.h"
+#include "fuse_i.h"
 
 #include <fcntl.h>
 #include <poll.h>
@@ -282,3 +283,10 @@ bool fuse_daemonize_active(void)
 
 	return dm != NULL && (dm->daemonized || dm->active);
 }
+
+bool fuse_daemonize_set(void)
+{
+	struct fuse_daemonize *dm = atomic_load(&daemonize);
+
+	return dm != NULL;
+}
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705..93ab7ac2fadf9395af70487c7626cc57c2948d56 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -112,6 +112,10 @@ struct fuse_session {
 
 	/* synchronous FUSE_INIT support */
 	bool want_sync_init;
+	pthread_t init_thread;
+	int init_error;
+	_Atomic bool terminate_mount_worker;
+	int init_wakeup_fd;
 
 	/* io_uring */
 	struct fuse_session_uring uring;
@@ -221,7 +225,11 @@ void fuse_chan_put(struct fuse_chan *ch);
 /* Mount-related functions */
 void fuse_mount_version(void);
 void fuse_kern_unmount(const char *mountpoint, int fd);
+int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp);
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
+int fuse_kern_mount_prepare(const char *mountpoint, struct mount_opts *mo);
+int fuse_kern_do_mount(const char *mountpoint, struct mount_opts *mo,
+		       const char *mnt_opts);
 
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
 			       int count);
@@ -255,6 +263,14 @@ int fuse_session_loop_mt_312(struct fuse_session *se, struct fuse_loop_config *c
  */
 int fuse_loop_cfg_verify(struct fuse_loop_config *config);
 
+/**
+ * Check if daemonization is set.
+ *
+ * @return true if set, false otherwise
+ */
+bool fuse_daemonize_set(void);
+
+
 
 /*
  * This can be changed dynamically on recent kernels through the
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 626233df20f49fa89cd9327f94340169d7061f75..b10def03f3666757d312f87f177a560483691d6f 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4230,6 +4230,7 @@ fuse_session_new_versioned(struct fuse_args *args,
 		goto out1;
 	}
 	se->fd = -1;
+	se->init_wakeup_fd = -1;
 	se->conn.max_write = FUSE_DEFAULT_MAX_PAGES_LIMIT * getpagesize();
 	se->bufsize = se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
 	se->conn.max_readahead = UINT_MAX;
@@ -4402,6 +4403,167 @@ int fuse_session_custom_io_30(struct fuse_session *se,
 }
 
 #if defined(HAVE_NEW_MOUNT_API)
+
+/* Worker thread for synchronous FUSE_INIT */
+static void *session_sync_init_worker(void *data)
+{
+	struct fuse_session *se = (struct fuse_session *)data;
+	struct fuse_buf fbuf = {
+		.mem = NULL,
+	};
+	struct pollfd pfds[2];
+	int res;
+
+	pfds[0].fd = se->fd;
+	pfds[0].events = POLLIN;
+	pfds[0].revents = 0;
+	pfds[1].fd = se->init_wakeup_fd;
+	pfds[1].events = POLLIN;
+	pfds[1].revents = 0;
+
+	/*
+	 * Process requests until mount completes. With SELinux there may be
+	 * additional requests (like getattr) after FUSE_INIT before mount
+	 * returns.
+	 */
+	while (!atomic_load(&se->terminate_mount_worker)) {
+		res = poll(pfds, 2, -1);
+		if (res == -1) {
+			if (errno == EINTR)
+				continue;
+			se->init_error = -errno;
+			break;
+		}
+
+		if (pfds[1].revents & POLLIN)
+			break;
+
+		if (pfds[0].revents & POLLIN) {
+			res = fuse_session_receive_buf_internal(se, &fbuf, NULL);
+			if (res == -EINTR)
+				continue;
+			if (res <= 0) {
+				se->init_error = res < 0 ? res : -EINVAL;
+				break;
+			}
+
+			fuse_session_process_buf_internal(se, &fbuf, NULL);
+		}
+	}
+
+	fuse_buf_free(&fbuf);
+	return NULL;
+}
+
+/* Enable synchronous FUSE_INIT and start worker thread */
+static int session_start_sync_init(struct fuse_session *se, int fd)
+{
+	int err;
+	int res;
+
+	if (!se->want_sync_init &&
+		(se->uring.enable && !fuse_daemonize_set())) {
+		if (se->debug)
+			fuse_log(FUSE_LOG_DEBUG,
+					"fuse: sync init not enabled\n");
+		return 0;
+	}
+
+	/* Try to enable synchronous FUSE_INIT */
+	res = ioctl(fd, FUSE_DEV_IOC_SYNC_INIT);
+	if (res) {
+		/* ENOTTY means kernel doesn't support sync init - not an error */
+		if (errno != ENOTTY) {
+			fuse_log(
+				FUSE_LOG_ERR,
+				"fuse: failed to enable sync init: %s\n",
+				strerror(errno));
+		} else if (se->debug) {
+			fuse_log(
+				FUSE_LOG_DEBUG,
+				"fuse: kernel doesn't support sync init\n");
+		}
+		return -ENOTTY;
+	}
+
+	if (se->debug)
+		fuse_log(FUSE_LOG_DEBUG,
+				"fuse: synchronous FUSE_INIT enabled\n");
+
+	se->init_error = 0;
+	se->terminate_mount_worker = false;
+
+	se->init_wakeup_fd = eventfd(0, EFD_CLOEXEC);
+	if (se->init_wakeup_fd == -1) {
+		fuse_log(
+			FUSE_LOG_ERR,
+			"fuse: failed to create eventfd for init worker: %s\n",
+			strerror(errno));
+		return -EIO;
+	}
+
+	err = pthread_create(&se->init_thread, NULL,
+				session_sync_init_worker, se);
+	if (err != 0) {
+		fuse_log(
+			FUSE_LOG_ERR,
+			"fuse: failed to create init worker thread: %s\n",
+			strerror(err));
+		close(se->init_wakeup_fd);
+		se->init_wakeup_fd = -1;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Wait for synchronous FUSE_INIT to complete */
+static int session_wait_sync_init_completion(struct fuse_session *se)
+{
+	void *retval;
+	int err;
+	uint64_t val = 1;
+
+	if (se->init_thread == 0)
+		return 0;
+
+	se->terminate_mount_worker = true;
+
+	if (se->init_wakeup_fd != -1) {
+		ssize_t res = write(se->init_wakeup_fd, &val, sizeof(val));
+
+		if (res != sizeof(val)) {
+			fuse_log(FUSE_LOG_ERR,
+				 "fuse: failed to signal init worker: %s\n",
+				 strerror(errno));
+		}
+	}
+
+	err = pthread_join(se->init_thread, &retval);
+	if (err != 0) {
+		fuse_log(FUSE_LOG_ERR, "fuse: failed to join init worker thread: %s\n",
+			 strerror(err));
+		return -1;
+	}
+
+	if (se->init_wakeup_fd != -1) {
+		close(se->init_wakeup_fd);
+		se->init_wakeup_fd = -1;
+	}
+
+	if (se->init_error != 0) {
+		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %d\n", se->init_error);
+		return -1;
+	}
+
+	if (fuse_session_exited(se)) {
+		fuse_log(FUSE_LOG_ERR, "FUSE_INIT failed: session exited\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 /* Only linux supports sync FUSE_INIT so far */
 static int fuse_session_mount_new_api(struct fuse_session *se,
 				      const char *mountpoint)
@@ -4414,8 +4576,7 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
 
 	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
 	if (res == -1) {
-		fuse_log(FUSE_LOG_ERR,
-			 "fuse: failed to get base mount options\n");
+		fuse_log(FUSE_LOG_ERR, "fuse: failed to get base mount options\n");
 		err = -EIO;
 		goto err;
 	}
@@ -4427,6 +4588,17 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
 		goto err;
 	}
 
+	/*
+	 * Enable synchronous FUSE_INIT and start worker thread, sync init
+	 * failure is not an error
+	 */
+	se->fd = fd;
+	err = session_start_sync_init(se, fd);
+	if (err) {
+		/* ENOTTY means kernel doesn't support sync init - not an error */
+		if (err != -ENOTTY)
+			goto err;
+	}
 	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
 	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
 	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
@@ -4436,13 +4608,16 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
 
 	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
 err:
-	if (err) {
+	if (err < 0) {
 		if (fd >= 0)
 			close(fd);
 		fd = -1;
 		se->fd = -1;
 		se->error = -errno;
 	}
+	/* Wait for synchronous FUSE_INIT to complete */
+	if (session_wait_sync_init_completion(se) < 0)
+		fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
 
 	free(mnt_opts);
 	free(mnt_opts_with_fd);
@@ -4452,8 +4627,8 @@ err:
 static int fuse_session_mount_new_api(struct fuse_session *se,
 				      const char *mountpoint)
 {
-	(void)se;
-	(void)mountpoint;
+	(void) se;
+	(void) mountpoint;
 
 	return -1;
 }
@@ -4825,3 +5000,10 @@ void fuse_session_stop_teardown_watchdog(void *data)
 	pthread_join(tt->thread_id, NULL);
 	fuse_tt_destruct(tt);
 }
+
+void fuse_session_want_sync_init(struct fuse_session *se)
+{
+	if (se == NULL)
+		return;
+	se->want_sync_init = true;
+}
diff --git a/lib/mount.c b/lib/mount.c
index 30fd4d2f9bbb84c817b2363b2075456acd1c1255..12df49d9109cf918cc41aa75c5fdf84231d4d5ff 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -30,6 +30,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include "fuse_mount_compat.h"
 
@@ -529,8 +530,8 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
  * Returns: 0 on success, -1 on failure,
  *          FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
  */
-static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
-				  const char *mnt_opts)
+int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
+		       const char *mnt_opts)
 {
 	char *source = NULL;
 	char *type = NULL;
diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index cba998bc60c783a5edc0c16570f7e5512b7f1253..f1fec790bb80f8815d485a068dc7efdff1746309 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -287,8 +287,9 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 	/* Try to open filesystem context */
 	fsfd = fsopen(type, FSOPEN_CLOEXEC);
 	if (fsfd == -1) {
-		fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
-			strerror(errno));
+		if (errno != EPERM)
+			fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
+				strerror(errno));
 		return -1;
 	}
 

-- 
2.43.0

