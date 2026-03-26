Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751253A7F55
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560924; cv=fail; b=LcKN35ZUiYSqKCe7P3fam51oljShJFUILPmtkPrHVWDp9051ndmkLcq58gfgpGy45AgqNvD5YuDCUzugWtjAWZtS65f3ToLYlyg3IvtOORjhJnJEZbVqbKGgTLbiTANvtHRBK2um8YZf6dLCAGN4XSmHN1jMz8RTNOvElJcluPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560924; c=relaxed/simple;
	bh=ko9XBt7Qc7Nu590SkCwX9WkTwEUSIo9aNAVaoni1BEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUy5nraQxA5JMlmVAVHyzDNrV6XNtXS+22R1Zf1KZqroAexMN/TUOz9Ob/TO3bztxzElfwewZTLcMZtufbAQgJ3FLXeghFV2hbC1LNJzwt8RiKWWyRBM6SFVvD0gkHGD2LxJ2nhFcO/sCD5aAbXX3Jm/UMU+kly1zAaMor5VRWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=B/7HMoNu; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="B/7HMoNu"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021133.outbound.protection.outlook.com [40.93.194.133]) by mx-outbound16-118.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNp0QuFdNd1505oh6hlZkvRV2i1wJLgKR53hqkSpIokY2Pr3jZEv1JrFhrqYHr0PkLbJ6SukUnsjdV6HtbiKmhHKHtIMF/imWI2o3GNd0OhxoHniTrihTEdCF2S8scvkya9eexiKm9AbR39jW2/J483Y+86kbyvOb57ALEa2Mqt5eyDZA+7cCtNyI+VQlQjiAJ/fkR5Oi1k2upQiwcLihnoUHvcqwkE13iQ+xfohLvLtULZT0NxYJgndAsiU7fFxGlBO5kA+dmm6X9jY3kpUOrSSvd+vfZwGHAz3/muCA7EjXpqG/0sbRxjIhQTp5JGjaxXg1fF8ile1memm0GFbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ac8oFaJ3+TUXGY9vXDf0Jn/tGIGgmHqh5QC/XluzhA=;
 b=quGmr+tZFMmIbspY7wSQmg598LUM6zfdj+sAjdoK1/rwJ9x/ZHoa7wnpXgiXCq7vcHJnzmrpU8+rxyOpZ9HOAp6wn4gYCnn5vuH1Ic1pG2XlgusTTgOzd3SOu6bPcWIAY61E0UYyf5V6RfzEF7E6v2FY836zUlPZQ9++ct2BqiPbv/4nIdwp3rTLkcDREGsR0ffvV/bDbmQPUceLOSHC0X1Gc6LjizdKeMTqkHhFlbpOZ8WgflOypxkZsuhMkuKIQRr4RFA4lJ56UyjVTBD8mS8iVdrd9sXyBoVJVObK96p5AZa7X7Tyg3CQgGNFF9x5am190lR5L2SO7YQfBARkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ac8oFaJ3+TUXGY9vXDf0Jn/tGIGgmHqh5QC/XluzhA=;
 b=B/7HMoNuKcw/DWFOe7qB6Q7kBbLYKXOAPDDKFc/bccLsucZpIJ+Hv/vtEYLUIGDjrqKwr6CSliK+9PSnaA/GZbcR3mZPGOWhcg9wKQkrHT9/easlDo45EkeNRmtn9mKlxI8aTnWTKLaX56+YFr3TRaYuQHj18TGMT0hzweyO1SI=
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by BY3PR19MB5060.namprd19.prod.outlook.com (2603:10b6:a03:363::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:08 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::5c) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 21:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 80C9A37B;
	Thu, 26 Mar 2026 21:35:05 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:47 +0100
Subject: [PATCH v2 14/25] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-fuse-init-before-mount-v2-14-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=11605;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=fKeTTVo2/4N6P74cPjOrJcMoy8kgmow5MI8pBg62+8M=;
 b=9O8u40bcGIEz4WarexOhvqSehZV22Kdp98N/4+0JD9FTzTIZRVcQbuTPSmxVKS3933V894rZ8
 Xgv2vaaA3fxA7D+B4rbwmatWLcBmS3GDzO7hqIyQuscdXo5rjnIhEUy
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY3PR19MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: e14ff557-6eb4-4f02-de87-08de8b7f8d52
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700016|19092799006|48200799018|376014|82310400026|22082099003|18002099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NsjxortsYDR2OlAsmGn1LK8LWMb7JFwY/Kd9RQ7srdyGWPIvXvDIJnWoPDXkz2NUydMmozuS6j16Lir6l9OZ9CMnfu+uyxKvdBuPlx0BGABddQLlMUImugDrjrlKvA3mGrfutSRyszpn0TN8JnmsvV/qJ6FhAA76M16aj7WNENzt5eAeplrl0MXc68VFoyl83e9QrE4p5Z+Lqf0KP4Bp3yCH/WF0uoMizRXgUzPXIyuEB7jHkNWl8P8a8SMBiC4ucPOI7fk0BBrni7npQrSz0TpJ5JYc8ptqGQ5MuBXyOqND/nfdF0rM/TR3Ce7TByxFN7y7Ne3yhrZK/DDhoQV1AGAYk/t/8wYElRKAWPwLuBbwiicEfp3OIaJrIEIpZHsXZupRhzgzelCQMB3AITd7Zg15O55v1B/O/Yg0hESvyblj14xtaBwujlcP6v0foMMluzmfSiu+RZfho0z6zu5l6R0jMWJ6GbZugW73vrZwq/PJqM2J41EnfpRDLhMaTZJbXNacskiWNKtP9XsyBH9IiSuaub51fSrxkR1Bcv3wtc5Qt+WSqSZdCvv0rF28mvTUvH2PO7Z+EX/JtnwVnMt36Q58OndTuEvDttVJW7UJnvnRRqE/7ZAA82aYLc/dERXn8tTBHpfTyjDHY5c/Ph3cHDMDO+/BMZ087VNMKhg0IenKAvHLaL6VuiuDyLeYtobdwEOD62rlGg7LoX3hEnMv8bw95fmWHJ9Tuojc7xtxpnguUV5JuLwvIl95kJfoOlxvJZ5WHkgbFUTDU68tRBSFTQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700016)(19092799006)(48200799018)(376014)(82310400026)(22082099003)(18002099003)(16102099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tFbiwq9m6NFVpxIQtt+/TJ7qzGkT7FH9ODWyf7Ph/CDdEcxuPmnTezHuXpchOF3NBLEOfk5dCzz+ZU/+S8Cwsa46KPKj3W4QcV7oWB6YO7e8mdr9Lnxvd0y0UlGHoZABdQtb1MsC4baaHahwlAqc873mp9Scw6Et4T+3fFOInj2hrV0H/1CquMPnBCLcfnwhFPOf6Jjfq1lfco+3RoisF62E2pKpsNbIgv/2Yl8PDAf0DivnQUoG4bkcKRu4NJCQMeeTGlFrRXw0xJezH6r9Q1uxy4hQlgBDgCfKMcEm7rbqdnLgT0/ZiYoP6bl2fbPrkICqkUDQX2qVNvHfi87wBg9dxliQtYkxpxsWcpMhskNcLBndpRw7Aq9961fwqVlJ3deLN212JAnHlLVZ+8mhye/cj5RtxzZrzESIstCMNyQS+sEfCX2Cl5YOvj9hGk7X
X-Exchange-RoutingPolicyChecked:
	YjIZsH4h9OfHReZL8AHH0C+IYzKOhJnk04cL5VonYpcRDWMmcuxwpbhdmca8WS0fGMTNeCHJHTtBjHEgZrBtkOlOJAUKGenITg8tsV2n8yWzSXvCJ5VVLfmFNvCW/uXrcMsNXCDCfosO+CWgk/ovWJhe+iDkQTETxLEltFyDI6pxyxQJy11QcYGZpAsaoRqAo22cc8BM1zQiOPWSXLnWO9kfmry8unsD5t4/vcPjbdycezH1AoRdJiVQ7L58PslH3MgV1EU/QWxL60NZ3YVzUC54IYwK/XwnWxdax9asaQr72Mv/6fAZCGwdyX9OQpZUm0ClzDI5X4IfjWPhzhP0Gw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zRGLJmJ7sH/AM7UhTFXF4mGvk4w8YEWvGg2JRjN+PyQDcyLXhI/aqaj5qcAKQD3Ak6N1d9Jh851h5jsvkDz3PjZvB245XdIKeyqoCNCEevvjCEOeT3sYWPQdecyUCmyn7AyNZvwmuZ6u2B+4vZesDS+T51o0eOGETyulbSTYuvGNvCT6SQAcOGetEfeLXfKJiceUhKao3LSpvnQJgpSPihg+XMc7XiOH1QGCz5hK7Z5vTwqjYW8vAeNO4xrV2sH0JcCYn7UUJxpkZOq7JKeqPwJbXrKPkepQFppjNhIroJRCdOobr/W9BgQcNVV28wiBAiz/tURjPb9xA8+kwMG34PR2qudynfzdLgDCX/XAAesN7tMYml9Kj2vap0Xet0mIatp1iwnKF1tvguoZD55/59rD7XjQIEVJqwDHw769kTCPnrsOvSfwnZXIWWwpvkZVoWbs2gTUZFzju94MXiaa+J3cCAa6EeM//fRB/9ncBiswSZDZe8hrQ9REHoxqNTnzkTyc1u48SvQ4/xA7J1V3Ot6GiYj40kIY8IsPG4U7hPWqF8j4w6caCoT7D1ml6LQgHz9GMVqP0SlZjgpR2yn0KOLrKgOMIBIHULTO3RQynmwOo8kvnfSp9KBHBcTd8o0UEjxel8UhoJt4KB7Wqro7Yg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:07.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e14ff557-6eb4-4f02-de87-08de8b7f8d52
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5060
X-BESS-ID: 1774560913-104214-9078-10345-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.93.194.133
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGRibGQGYGUNTMKNXC0CjZMs
	nE1Mjc2DLNxCDFzCTV2CApycDCLNkkRak2FgDoOmLLQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan18-240.us-east-2b.ess.aws.cudaops.com]
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
 include/fuse_daemonize.h |   7 ++
 include/fuse_lowlevel.h  |  12 +++
 lib/fuse_daemonize.c     |   6 ++
 lib/fuse_i.h             |  15 ++++
 lib/fuse_lowlevel.c      | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
 lib/mount.c              |   5 +-
 6 files changed, 230 insertions(+), 5 deletions(-)

diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
index c35dddd668b399535c53b44ab06c65fc0b3ddefa..6215e42c635ba5956cb23ba0832dfc291ab8dede 100644
--- a/include/fuse_daemonize.h
+++ b/include/fuse_daemonize.h
@@ -66,6 +66,13 @@ bool fuse_daemonize_is_active(void);
  */
 void fuse_daemonize_set_mounted(void);
 
+/**
+ * Check if daemonization is used.
+ *
+ * @return true if used, false otherwise
+ */
+bool fuse_daemonize_is_used(void);
+
 #ifdef __cplusplus
 }
 #endif
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
index 865acad7db56dbe5ed8a1bee52e7353627e89b75..97cfad7be879beacf69b020b7af78d512a224fd5 100644
--- a/lib/fuse_daemonize.c
+++ b/lib/fuse_daemonize.c
@@ -9,6 +9,7 @@
 #define _GNU_SOURCE
 
 #include "fuse_daemonize.h"
+#include "fuse_i.h"
 
 #include <fcntl.h>
 #include <poll.h>
@@ -290,3 +291,8 @@ void fuse_daemonize_set_mounted(void)
 {
 	daemonize.mounted = true;
 }
+
+bool fuse_daemonize_is_used(void)
+{
+	return daemonize.active;
+}
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705..164401e226eb727192a49e1cc7b38a75f031643b 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -112,6 +112,9 @@ struct fuse_session {
 
 	/* synchronous FUSE_INIT support */
 	bool want_sync_init;
+	pthread_t init_thread;
+	int init_error;
+	int init_wakeup_fd;
 
 	/* io_uring */
 	struct fuse_session_uring uring;
@@ -221,7 +224,11 @@ void fuse_chan_put(struct fuse_chan *ch);
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
@@ -255,6 +262,14 @@ int fuse_session_loop_mt_312(struct fuse_session *se, struct fuse_loop_config *c
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
index a7be40cbb012361ad664a9ced3d38042ba52c681..0dd10e0ed53508e4716703f2f82aa35ad853b247 100644
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
@@ -4402,6 +4403,170 @@ int fuse_session_custom_io_30(struct fuse_session *se,
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
+	while (true) {
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
+	int err, res;
+
+	if (!se->want_sync_init &&
+		(se->uring.enable && !fuse_daemonize_is_used())) {
+		if (se->debug)
+			fuse_log(FUSE_LOG_DEBUG,
+					"fuse: sync init not enabled\n");
+		return 0;
+	}
+
+	/* Try to enable synchronous FUSE_INIT */
+	res = ioctl(fd, FUSE_DEV_IOC_SYNC_INIT);
+	if (res) {
+		err = -errno;
+		if (err != ENOTTY) {
+			fuse_log(
+				FUSE_LOG_ERR,
+				"fuse: failed to enable sync init: %s\n",
+				strerror(errno));
+		} else {
+			/*
+			 * ENOTTY means kernel doesn't support sync init,not an
+			 * error
+			 */
+			if (se->debug)
+				fuse_log(
+					FUSE_LOG_DEBUG,
+					"fuse: kernel doesn't support sync init\n");
+			err = 0;
+		}
+		return err;
+	}
+
+	if (se->debug)
+		fuse_log(FUSE_LOG_DEBUG,
+				"fuse: synchronous FUSE_INIT enabled\n");
+
+	se->init_error = 0;
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
+	if (se->init_wakeup_fd == -1)
+		return 0;
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
+		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %s\n",
+			 strerror(-se->init_error));
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
 static int fuse_session_mount_new_api(struct fuse_session *se,
 				      const char *mountpoint)
 {
@@ -4426,6 +4591,15 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
 		goto err;
 	}
 
+	/*
+	 * Enable synchronous FUSE_INIT and start worker thread, sync init
+	 * failure is not an error
+	 */
+	se->fd = fd;
+	err = session_start_sync_init(se, fd);
+	if (err)
+		goto err;
+
 	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
 	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
 	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
@@ -4435,13 +4609,16 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
 
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
@@ -4451,8 +4628,8 @@ err:
 static int fuse_session_mount_new_api(struct fuse_session *se,
 				      const char *mountpoint)
 {
-	(void)se;
-	(void)mountpoint;
+	(void) se;
+	(void) mountpoint;
 
 	return -1;
 }
@@ -4826,3 +5003,10 @@ void fuse_session_stop_teardown_watchdog(void *data)
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
index e8c65363d36a56f483f82434f642e785da4d0341..f19817e2675713e988bb91fc658c52b36468462b 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -30,6 +30,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include "fuse_mount_compat.h"
 
@@ -522,8 +523,8 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
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

-- 
2.43.0

