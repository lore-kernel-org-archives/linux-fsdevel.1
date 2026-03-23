Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BD3BE65C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287938; cv=fail; b=CPVG0pEHX9SafmD6r/UELgXtTcVn658Om+Sd+WizEEfhCFiArsxup6Po8H85hMvAwPS8vZlxl/+V0TuSfO1OEMlc3osN9OPNF30ySiFzl834kdBGfBRcvbgksMBmNC4s+MXxZmXrAk4DqwFQbT9EVPo/MOieH30h7LYSm+SWcqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287938; c=relaxed/simple;
	bh=oYgjnS+VXL32AF0LJsLZrf3hOCEXQBfCmHwV5ROs3XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcXLFbkHf1zQsot4fQaSOUx5pefODaCOasM8x/1yygG6otrRBcwTsFiJxQ+5CnMvTkf7gvSZd7SevS9kPWfDcmq/cI+TcapzJWKnAgj3uCp+aCOnI4f5K2vf9OQQ5c+3FTdTLZsex1bkDErxVm5v4Q7w26rsWIhGtzscdvRYmVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=b6gqaI5h; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="b6gqaI5h"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021142.outbound.protection.outlook.com [40.107.208.142]) by mx-outbound44-128.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpPK4b7Pv46DkpWkUdPxmd91Nxct13CKjodBiZNv++5RR0Mbp59BdCz4IC/yPpVP+2iIPtIjAOcfFyvRzXxO4LRtPodu2ctp58MvsOGjx0d1AfWhguXetSa/I/TzMHhNrBV6cRCKMaauk1h//ToVY1hq2gyxaSUyh/oSIVf6xGe+2ueOLOvFfr1w1NPSdLmK57K9HTv9sZHYSPm3MuPCczUwEeezRbbf+ub46mwytCy7iUCxPact5gDSlnbeyNy+tdEkTvP9If9m3uv3igI8wizLyGDoEmn8LSAFxDNpmm9ucbXlOB1GYMb5KklGrP/gi2pCzi9hzyCC7zQQZv0qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8P5+FjWsK5LurLCNwAAKlKHxt1OhWLwds6cpsFUfmA=;
 b=x04Qai347wM6avykSQE+WBH/RD51Xh9061GBi2G3AhacyHcS1r6sCpc6yGZ9LA7Tw0OlePjek1IVDI71oRbnyLUUZOBLJbzKcYDzgjcoeWqbuQAhgG3Rsii+d0cSVv5+C1MBIZaCP0qCc1m3ar8q5vactDU5f93o/pMem783MTPuwq7YjYQrbmOfwsHGLSQjhwYMPykaRb0T53Hw3qj71jZnGhbfbcb30aqOUZbMYrwhudXtTdViOZIgYOho2J/sJEVxNwUMwBxLgE5+0/ufVqchMAkXrMgztatV6kPH5Rfv1NxK27BYDUnm8iH3VrV8KOi9Mr4vDg+tVl1p3RvcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8P5+FjWsK5LurLCNwAAKlKHxt1OhWLwds6cpsFUfmA=;
 b=b6gqaI5hiRNJUKYkGJKmQK2AUTNryBoe68FIOkoMNApWwkcQOylytSJYKCqfpJTNed6FBthtDiYlfY0yJdq5eCPyWmh9GZPPfA1UccLkd7VBTlyA8C7T/m1qRQA9GilgLiYGXj+6ApWL+O//BqSB/cLd/MgJ/h74Ymo4Y5uStn4=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by SA0PR19MB4384.namprd19.prod.outlook.com (2603:10b6:806:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 17:45:18 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::d8) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Mon, 23 Mar 2026 17:45:17 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 452B4B7;
	Mon, 23 Mar 2026 17:45:14 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:06 +0100
Subject: [PATCH 11/19] Add support for the new linux mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-11-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=18760;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=mLW0rdp3jDrPoT1iFvKDvhOAFc9DGREw1bArhX3ibBA=;
 b=1/hG0TdwlFvbmiPD4uzJKGUmFrPQJfw4DlfoCbg06HzUNbEGwmDCzs/ZIjHFVF8l41rrJmeXy
 UPV8iAC9+KhCkKWWRICLSZ+eAmEKEJyMmB3+kkJWaX4SslN45iXUIwF
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA0PR19MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: f62f5483-7104-4063-4a33-08de8903f27e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|19092799006|376014|36860700016|61400799027|82310400026|13003099007|16102099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zaee3Hsnw8/OOv2gAMJBsCJqbSiI0pyIyctP+d5h9sHPzpmZ8xXyBBEfz4djCmeooT5AGTPKKTlsq/9LcexwZdUvMCsxfhzb2xBd6wMMS2WSUuwoTOcsHYasTNUrPnGi38fuoTGtY2oKKYhFFYONq0p0cCwonNED4HK1q0Cw59qauMfLmpjJcfNAf4n27hRcf1Iuj1rpM1lkT9WmEBwE7sq5Q3duTuUXq8VeYya//cJ6PPIlHKUuKotjguXw44OnjfaXP5ShdfJ9OYDMVoa4nWyF6u1PQTJ4hMwurdmWY45iKjXAT0fvGJicS7ElQOAS39LW9Jtlzp3zM/GWbtjKi5oRNh0oR2XxNylIcRC2t3oV3QPcvZ9iTKyOa5luRordAyF0S0FCwgx8ncu6O27A0LVItf+41/ZXPbUhx4g346djFwuaCl9fO2d7QXqVllgZLD8DEdHV5rwx6NXG3BhnzwJ+YEAbmHWqm1J3Oy1W5dVddcJisS80g/Mxy2gYVIsOd5kOW4Qj48YdEJIaBo/wnwmr5SnZp05jRdXrHaqE9C3z0vS6ahImOWGVQUPVfn0a/G1ISddUnnD1uZFIDEW/wpbyb3N14v/3hu2e6qE5x6RCLVp0rLsdq9MGPK+YssZpu0b6cmTYiTpLovkocJWVDrfaWUqGsBUVhulhK2YlLpvFA92nHGUlVDNpka0+RrJQMxFddJCGfSWhaSuHbL50sw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(19092799006)(376014)(36860700016)(61400799027)(82310400026)(13003099007)(16102099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4DyVa70+GDzBids8VbiOgpnJs763Vx2SwuJfaxkuDXCYUpQeAPiOfCEdQSMISIJ5tubdZ/xcngCZNLMKb/IuHtfYLCIqbamYyuL2H6uCA9BCHwnGhsfE8YBQrGC5hhcpbynGeYYsDMa+vIgQdJm3FJFGCggHb5IviRSnUezY4JateIiqWscSMPAjEYQctZc/oy/M7mWqhdXUWUb7RwhJi4uLiCY5uKhFFyVb4/R30eoBFiDhrdeU+lZ4IsCiQefRH0IY2z5Eub6afeQZ7V/hSC1rZQiAEzH2Fnl1ewZlZfLPKVzkH2gvi5pcKx5vuoMvbF3JeUpdz+4+55f/8wnGiZzOp5K3VWI4pxj3GY0ktBhA3sunG2Wf066/rqSFSXR3XXTv04p23OiWwL8hwqLEUXmmaHwtc/GQh4+kDtD2iMfya0a3UnCLWgpiwwl/wE/Y
X-Exchange-RoutingPolicyChecked:
	fibmrFEgkT2GFlOPAGDArOn7ZqbA2JBPWOpBgG3GwgNogSsu2tLzrQlJcXhr/SJpbkRwuRlpfZdxXt4k12qfb1jAsLHCI+b5KhY+LKCE5kNpEmAXyR2T8AKFqcgum7xrvIIMYBAxmgpm7yqHdzONf4wircv2F9ZEqzAAKs+9Z3vOvDC5mIGjfIVih941Lq6Yzu7uouu5pL5VBajrPHTLESfWwUq8pDNfGlO/mJba8zgr6ZE5yfJZ7LP663vvzNdziAOqzf3UfW726Gm+WsjtvybX7gQXKG5PnhhYGgTIva+1FmUg8JYtzB6dJV+CxzRUwW48LCf84INwQbob3yk76A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZlifnma4cAxKT1J29WBupWhmwZuNyBUuD5MLLGqhxv03hEnupr+OXS+PnuJ6EkgfudpB7cKrpKMjwIGu+i41hWBEGtcmW4omA8nkYfHG71OYgHyQdTwfYMpDlIwFjsVwmQJM2EHzYRTYqFs1myo7mFPWbuyfgWlPDId9uYn8w2329bi8rLRfcirCW5bb80qB7DxdJ60WnekbycQn+pTlBFJeCaEDh03Pac+Bk1P7h1bojYT6vASvQfQlmwyEwnSWmHl/BX6pxopILXaSH5WKUPEsFICUeXOvJd+kjA7HBCIw/WgrSwoJT/G9CvnZFRFZRgpoIBgDKFgzyTGqMnuTli8y3EB+OYJbbE3+SOpA0ZvV0lisMo0MVsnuThb7+CeQ+ibw6PbCqLwZ2WR8zA0o2LL0kyV66TCuwBbZKvtWgGUt7fAAUJqGw/QNpQ+VOZiZhxllfmUsn9y4VxJlaoxLL0pEtMNyeM0EJmoS2X9RDkSBfFqua14bI4Vy5kkddIa1J8JsfKGNICffyXFh8y6Lysn1hGIOdAxjlU/yWZkiHtb9Y50l1RXCttEYJeofp7k1a1lNRbE5AlFXjzYMAfKxF2zWNHV2gIqfndaWNN6G8SLgzB2Kcu64LnLMM6kAMl8htTFz3fvYhGCDByxrQurSA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:17.8052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62f5483-7104-4063-4a33-08de8903f27e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4384
X-BESS-ID: 1774287924-111392-15718-7420-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.208.142
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWhkbmQGYGUNTcPC3R0DDZ0D
	TVItHA2MIozczEzMgs0QIkaGFoYqlUGwsAP2F6y0IAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan12-119.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

So far only supported for fuse_session_mount(), which is called
from high and low level API, but not yet supported for
fuse_open_channel(), which used for privilege drop through
mount.fuse. Main goal for the new API is support for synchronous
FUSE_INIT and I don't think that is going to work with
fuse_open_channel(). At least not with io-uring support as long
as it is started from FUSE_INIT.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/fuse_lowlevel.c |  75 +++++++++-
 lib/meson.build     |   3 +
 lib/mount.c         |  27 +++-
 lib/mount_fsmount.c | 405 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/mount_i_linux.h |  14 ++
 meson.build         |  19 ++-
 6 files changed, 535 insertions(+), 8 deletions(-)

diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4a1c7c4c02a05706e077a7ea89fab3c81bfe22cd..626233df20f49fa89cd9327f94340169d7061f75 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -20,6 +20,9 @@
 #include "util.h"
 #include "fuse_uring_i.h"
 #include "fuse_daemonize.h"
+#if defined(__linux__)
+#include "mount_i_linux.h"
+#endif
 
 #include <pthread.h>
 #include <stdatomic.h>
@@ -4398,6 +4401,64 @@ int fuse_session_custom_io_30(struct fuse_session *se,
 			offsetof(struct fuse_custom_io, clone_fd), fd);
 }
 
+#if defined(HAVE_NEW_MOUNT_API)
+/* Only linux supports sync FUSE_INIT so far */
+static int fuse_session_mount_new_api(struct fuse_session *se,
+				      const char *mountpoint)
+{
+	int fd = -1;
+	int res, err;
+	char *mnt_opts = NULL;
+	char *mnt_opts_with_fd = NULL;
+	char fd_opt[32];
+
+	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
+	if (res == -1) {
+		fuse_log(FUSE_LOG_ERR,
+			 "fuse: failed to get base mount options\n");
+		err = -EIO;
+		goto err;
+	}
+
+	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
+	if (fd == -1) {
+		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
+		err = -EIO;
+		goto err;
+	}
+
+	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
+	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
+	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
+err:
+	if (err) {
+		if (fd >= 0)
+			close(fd);
+		fd = -1;
+		se->fd = -1;
+		se->error = -errno;
+	}
+
+	free(mnt_opts);
+	free(mnt_opts_with_fd);
+	return fd;
+}
+#else
+static int fuse_session_mount_new_api(struct fuse_session *se,
+				      const char *mountpoint)
+{
+	(void)se;
+	(void)mountpoint;
+
+	return -1;
+}
+#endif
+
 int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 {
 	int fd;
@@ -4425,6 +4486,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 			close(fd);
 	} while (fd >= 0 && fd <= 2);
 
+	/* Open channel */
+
 	/*
 	 * To allow FUSE daemons to run without privileges, the caller may open
 	 * /dev/fuse before launching the file system and pass on the file
@@ -4443,10 +4506,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 		return 0;
 	}
 
-	/* Open channel */
+	/* new linux mount api */
+	fd = fuse_session_mount_new_api(se, mountpoint);
+	if (fd >= 0)
+		goto out;
+
+	/* fall back to old API */
+	se->error = 0; /* reset error of new api */
 	fd = fuse_kern_mount(mountpoint, se->mo);
-	if (fd == -1)
+	if (fd < 0)
 		goto error_out;
+
+out:
 	se->fd = fd;
 
 	/* Save mountpoint */
diff --git a/lib/meson.build b/lib/meson.build
index 5bd449ebffe7c9229df904d647d990c6c47f80b5..5fd738a589c5aba97a738d5eedbf0f9962e4adfc 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -7,6 +7,9 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
 
 if host_machine.system().startswith('linux')
    libfuse_sources += [ 'mount.c' ]
+   if private_cfg.get('HAVE_NEW_MOUNT_API', false)
+      libfuse_sources += [ 'mount_fsmount.c' ]
+   endif
 else
    libfuse_sources += [ 'mount_bsd.c' ]
 endif
diff --git a/lib/mount.c b/lib/mount.c
index b3ee9ba4c0a74c1d0d55f916e7046e064f8468b0..30fd4d2f9bbb84c817b2363b2075456acd1c1255 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -449,8 +449,8 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 #define O_CLOEXEC 0
 #endif
 
-static int fuse_kern_mount_prepare(const char *mnt,
-				   struct mount_opts *mo)
+int fuse_kern_mount_prepare(const char *mnt,
+			    struct mount_opts *mo)
 {
 	char tmp[128];
 	const char *devname = fuse_mnt_get_devname();
@@ -500,6 +500,26 @@ out_close:
 	return -1;
 }
 
+#if defined(HAVE_NEW_MOUNT_API)
+/**
+ * Wrapper for fuse_kern_fsmount that accepts struct mount_opts
+ * @mnt: mountpoint
+ * @mo: mount options
+ * @mnt_opts: mount options to pass to the kernel
+ *
+ * Returns: 0 on success, -1 on failure with errno set
+ */
+int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
+			 const char *mnt_opts)
+{
+	const char *devname = fuse_mnt_get_devname();
+
+	return fuse_kern_fsmount(mnt, mo->flags, mo->blkdev, mo->fsname,
+				 mo->subtype, devname, mo->kernel_opts,
+				 mnt_opts);
+}
+#endif
+
 /**
  * Complete the mount operation with an already-opened fd
  * @mnt: mountpoint
@@ -643,8 +663,7 @@ void destroy_mount_opts(struct mount_opts *mo)
 	free(mo);
 }
 
-static int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo,
-					     char **mnt_optsp)
+int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp)
 {
 	if (get_mnt_flag_opts(mnt_optsp, mo->flags) == -1)
 		return -1;
diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
new file mode 100644
index 0000000000000000000000000000000000000000..cba998bc60c783a5edc0c16570f7e5512b7f1253
--- /dev/null
+++ b/lib/mount_fsmount.c
@@ -0,0 +1,405 @@
+/*
+ *  FUSE: Filesystem in Userspace
+ *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *                2026 Bernd Schubert <bernd@bsbernd.com>
+ *
+ * New Linux mount API (fsopen/fsconfig/fsmount/move_mount) support.
+ *
+ *  This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file LGPL2.txt.
+ */
+
+#define _GNU_SOURCE
+
+#include "fuse_config.h"
+#include "fuse_misc.h"
+#include "mount_util.h"
+#include "mount_i_linux.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/mount.h>
+#include <sys/syscall.h>
+
+/* Mount attribute flags for fsmount() - from linux/mount.h */
+#ifndef MOUNT_ATTR_RDONLY
+#define MOUNT_ATTR_RDONLY       0x00000001
+#endif
+#ifndef MOUNT_ATTR_NOSUID
+#define MOUNT_ATTR_NOSUID       0x00000002
+#endif
+#ifndef MOUNT_ATTR_NODEV
+#define MOUNT_ATTR_NODEV        0x00000004
+#endif
+#ifndef MOUNT_ATTR_NOEXEC
+#define MOUNT_ATTR_NOEXEC       0x00000008
+#endif
+#ifndef MOUNT_ATTR__ATIME
+#define MOUNT_ATTR__ATIME       0x00000070
+#endif
+#ifndef MOUNT_ATTR_RELATIME
+#define MOUNT_ATTR_RELATIME     0x00000000
+#endif
+#ifndef MOUNT_ATTR_NOATIME
+#define MOUNT_ATTR_NOATIME      0x00000010
+#endif
+#ifndef MOUNT_ATTR_STRICTATIME
+#define MOUNT_ATTR_STRICTATIME  0x00000020
+#endif
+#ifndef MOUNT_ATTR_NODIRATIME
+#define MOUNT_ATTR_NODIRATIME   0x00000080
+#endif
+#ifndef MOUNT_ATTR_NOSYMFOLLOW
+#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
+#endif
+
+/*
+ * Convert MS_* mount flags to MOUNT_ATTR_* mount attributes.
+ * These flags are passed to fsmount(), not fsconfig().
+ * Mount attributes control mount-point level behavior.
+ */
+static unsigned long ms_flags_to_mount_attrs(unsigned long flags)
+{
+	unsigned long attrs = 0;
+
+	if (flags & MS_NOSUID)
+		attrs |= MOUNT_ATTR_NOSUID;
+	if (flags & MS_NODEV)
+		attrs |= MOUNT_ATTR_NODEV;
+	if (flags & MS_NOEXEC)
+		attrs |= MOUNT_ATTR_NOEXEC;
+	if (flags & MS_NOATIME)
+		attrs |= MOUNT_ATTR_NOATIME;
+	else if (flags & MS_RELATIME)
+		attrs |= MOUNT_ATTR_RELATIME;
+	else if (flags & MS_STRICTATIME)
+		attrs |= MOUNT_ATTR_STRICTATIME;
+	if (flags & MS_NODIRATIME)
+		attrs |= MOUNT_ATTR_NODIRATIME;
+	if (flags & MS_NOSYMFOLLOW)
+		attrs |= MOUNT_ATTR_NOSYMFOLLOW;
+
+	return attrs;
+}
+
+/*
+ * Apply VFS superblock flags to the filesystem context.
+ * Only handles flags that are filesystem parameters (ro, sync, dirsync).
+ * Mount attributes (nosuid, nodev, etc.) are handled separately via fsmount().
+ */
+static int apply_mount_flags(int fsfd, unsigned long flags)
+{
+	int res;
+
+	/* Handle read-only flag */
+	if (flags & MS_RDONLY) {
+		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+		if (res == -1) {
+			fprintf(stderr,
+				"fuse: fsconfig SET_FLAG ro failed: %s\n",
+				strerror(errno));
+			return -errno;
+		}
+	}
+
+	/* Handle sync flag */
+	if (flags & MS_SYNCHRONOUS) {
+		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, "sync", NULL, 0);
+		if (res == -1) {
+			fprintf(stderr,
+				"fuse: fsconfig SET_FLAG sync failed: %s\n",
+				strerror(errno));
+			return -errno;
+		}
+	}
+
+#ifndef __NetBSD__
+	/* Handle dirsync flag */
+	if (flags & MS_DIRSYNC) {
+		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, "dirsync", NULL, 0);
+		if (res == -1) {
+			fprintf(stderr,
+				"fuse: fsconfig SET_FLAG dirsync failed: %s\n",
+				strerror(errno));
+			return -errno;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+static int apply_opt_fd(int fsfd, const char *value)
+{
+	int res;
+
+	/* The fd parameter is a u32 value, not a file descriptor to pass */
+	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "fd", value, 0);
+	if (res == -1) {
+		fprintf(stderr, "fuse: fsconfig SET_STRING fd=%s failed: %s\n",
+			value, strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
+
+static int apply_opt_string(int fsfd, const char *key, const char *value)
+{
+	int res;
+
+	res = fsconfig(fsfd, FSCONFIG_SET_STRING, key, value, 0);
+	if (res == -1) {
+		fprintf(stderr,
+			"fuse: fsconfig SET_STRING %s=%s failed: %s\n",
+			key, value, strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
+
+static int apply_opt_flag(int fsfd, const char *opt)
+{
+	int res;
+
+	res = fsconfig(fsfd, FSCONFIG_SET_FLAG, opt, NULL, 0);
+	if (res == -1) {
+		fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed: %s\n",
+			opt, strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
+
+static int apply_opt_key_value(int fsfd, char *opt)
+{
+	char *eq;
+	const char *key;
+	const char *value;
+
+	eq = strchr(opt, '=');
+	if (!eq)
+		return apply_opt_flag(fsfd, opt);
+
+	*eq = '\0';
+	key = opt;
+	value = eq + 1;
+
+	if (strcmp(key, "fd") == 0)
+		return apply_opt_fd(fsfd, value);
+
+	return apply_opt_string(fsfd, key, value);
+}
+
+/**
+ * Check if an option is a mount attribute (handled by fsmount, not fsconfig)
+ */
+static int is_mount_attr_opt(const char *opt)
+{
+	/* These options are mount attributes passed to fsmount(), not fsconfig() */
+	return strcmp(opt, "nosuid") == 0 ||
+	       strcmp(opt, "suid") == 0 ||
+	       strcmp(opt, "nodev") == 0 ||
+	       strcmp(opt, "dev") == 0 ||
+	       strcmp(opt, "noexec") == 0 ||
+	       strcmp(opt, "exec") == 0 ||
+	       strcmp(opt, "noatime") == 0 ||
+	       strcmp(opt, "atime") == 0 ||
+	       strcmp(opt, "nodiratime") == 0 ||
+	       strcmp(opt, "diratime") == 0 ||
+	       strcmp(opt, "relatime") == 0 ||
+	       strcmp(opt, "norelatime") == 0 ||
+	       strcmp(opt, "strictatime") == 0 ||
+	       strcmp(opt, "nostrictatime") == 0 ||
+	       strcmp(opt, "nosymfollow") == 0 ||
+	       strcmp(opt, "symfollow") == 0;
+}
+
+/*
+ * Parse kernel options string and apply via fsconfig
+ * Options are comma-separated key=value pairs
+ */
+static int apply_mount_opts(int fsfd, const char *opts)
+{
+	char *opts_copy;
+	char *opt;
+	char *saveptr;
+	int res;
+
+	if (!opts || !*opts)
+		return 0;
+
+	opts_copy = strdup(opts);
+	if (!opts_copy) {
+		fprintf(stderr, "fuse: failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	opt = strtok_r(opts_copy, ",", &saveptr);
+	while (opt) {
+		/* Skip mount attributes - they're handled by fsmount(), not fsconfig() */
+		if (!is_mount_attr_opt(opt)) {
+			res = apply_opt_key_value(fsfd, opt);
+			if (res < 0) {
+				free(opts_copy);
+				return res;
+			}
+		}
+		opt = strtok_r(NULL, ",", &saveptr);
+	}
+
+	free(opts_copy);
+	return 0;
+}
+
+
+/**
+ * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
+ * @mnt: mountpoint
+ * @flags: mount flags (MS_NOSUID, MS_NODEV, etc.)
+ * @blkdev: 1 for fuseblk, 0 for fuse
+ * @fsname: filesystem name (or NULL)
+ * @subtype: filesystem subtype (or NULL)
+ * @source_dev: device name for building source string
+ * @kernel_opts: kernel mount options string
+ * @mnt_opts: additional mount options to pass to the kernel
+ *
+ * Returns: 0 on success, -1 on failure with errno set
+ */
+int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
+		      const char *fsname, const char *subtype,
+		      const char *source_dev, const char *kernel_opts,
+		      const char *mnt_opts)
+{
+	const char *type;
+	char *source = NULL;
+	int fsfd = -1;
+	int mntfd = -1;
+	int err, res;
+	unsigned long mount_attrs;
+
+	/* Determine filesystem type */
+	type = blkdev ? "fuseblk" : "fuse";
+
+	/* Try to open filesystem context */
+	fsfd = fsopen(type, FSOPEN_CLOEXEC);
+	if (fsfd == -1) {
+		fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
+			strerror(errno));
+		return -1;
+	}
+
+	/* Build source string */
+	source = malloc((fsname ? strlen(fsname) : 0) +
+			(subtype ? strlen(subtype) : 0) +
+			strlen(source_dev) + 32);
+	err = -ENOMEM;
+	if (!source) {
+		fprintf(stderr, "fuse: failed to allocate memory\n");
+		goto out_close_fsfd;
+	}
+
+	strcpy(source, fsname ? fsname : (subtype ? subtype : source_dev));
+
+	/* Configure source */
+	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
+	if (res == -1) {
+		err = -errno;
+		fprintf(stderr, "fuse: fsconfig source failed: %s\n",
+			strerror(errno));
+		goto out_free;
+	}
+
+	/* Apply VFS superblock flags (ro, sync, dirsync) */
+	err = apply_mount_flags(fsfd, flags);
+	if (err < 0) {
+		fprintf(stderr, "fuse: failed to apply mount flags\n");
+		goto out_free;
+	}
+
+	/* Apply kernel options */
+	err = apply_mount_opts(fsfd, kernel_opts);
+	if (err < 0) {
+		fprintf(stderr,
+			"fuse: failed to apply kernel options '%s'\n",
+			kernel_opts);
+		goto out_free;
+	}
+
+	/* Apply additional mount options */
+	err = apply_mount_opts(fsfd, mnt_opts);
+	if (err < 0) {
+		fprintf(stderr,
+			"fuse: failed to apply additional mount options '%s'\n",
+			mnt_opts);
+		goto out_free;
+	}
+
+	/* Create the filesystem instance */
+	res = fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (res == -1) {
+		err = -errno;
+		fprintf(stderr, "fuse: fsconfig CREATE failed: %s\n",
+			strerror(errno));
+		goto out_free;
+	}
+
+	/* Convert MS_* flags to MOUNT_ATTR_* for fsmount() */
+	mount_attrs = ms_flags_to_mount_attrs(flags);
+
+	/* Create mount object with mount attributes */
+	mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs);
+	if (mntfd == -1) {
+		err = -errno;
+		fprintf(stderr, "fuse: fsmount failed: %s\n",
+			strerror(errno));
+		goto out_free;
+	}
+
+	close(fsfd);
+	fsfd = -1;
+
+	/* Attach to mount point */
+	if (move_mount(mntfd, "", AT_FDCWD, mnt, MOVE_MOUNT_F_EMPTY_PATH) ==
+	    -1) {
+		err = -errno;
+		fprintf(stderr, "fuse: move_mount failed: %s\n",
+			strerror(errno));
+		goto out_close_mntfd;
+	}
+
+	err = fuse_mnt_add_mount_helper(mnt, source, type, mnt_opts);
+	if (err == -1)
+		goto out_umount;
+
+	close(mntfd);
+	free(source);
+	return 0;
+
+out_umount:
+	{
+		/* race free umount */
+		char fd_path[64];
+
+		snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", mntfd);
+		if (umount2(fd_path, MNT_DETACH) == -1 && errno != EINVAL) {
+			fprintf(stderr,
+				"fuse: cleanup umount failed: %s\n",
+				strerror(errno));
+		}
+	}
+out_close_mntfd:
+	if (mntfd != -1)
+		close(mntfd);
+out_free:
+	free(source);
+out_close_fsfd:
+	if (fsfd != -1)
+		close(fsfd);
+	errno = -err;
+	return -1;
+}
+
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index c0de6228fce5a4d9070cc246ec76222b66de56fb..52eab9e650c055142feec329264f82c2b08be0d5 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -60,6 +60,20 @@ static const struct mount_flags fuse_mount_flags[] = {
 	{NULL,      0,          0}
 };
 
+int fuse_kern_mount_prepare(const char *mnt, struct mount_opts *mo);
+
+int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp);
+
+int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
+		      const char *fsname, const char *subtype,
+		      const char *source_dev, const char *kernel_opts,
+		      const char *mnt_opts);
+
+int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
+			 const char *mnt_opts);
+
+int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
+			 const char *mnt_opts);
 
 
 #endif /* FUSE_MOUNT_I_H_ */
diff --git a/meson.build b/meson.build
index 80c5f1dc0bd3565c11ad3084dac08e28dab611dc..465a7bbfd14fe9c45897f197ef37db76079d20ee 100644
--- a/meson.build
+++ b/meson.build
@@ -30,7 +30,7 @@ if platform == 'darwin'
         'https://www.fuse-t.org/ instead')
 elif platform == 'cygwin' or platform == 'windows'
   error('libfuse does not support Windows.\n' +
-        'Take a look at http://www.secfs.net/winfsp/ instead')       
+        'Take a look at http://www.secfs.net/winfsp/ instead')
 endif
 
 cc = meson.get_compiler('c')
@@ -118,6 +118,21 @@ special_funcs = {
 	    return -1;
 	  }
 	}
+    ''',
+    'new_mount_api': '''
+	#define _GNU_SOURCE
+	#include <sys/mount.h>
+	#include <linux/mount.h>
+	#include <unistd.h>
+	#include <fcntl.h>
+
+	int main(void) {
+	    int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
+	    int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
+	    int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	    res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+	    return 0;
+	}
     '''
 }
 
@@ -308,7 +323,7 @@ configure_file(output: 'libfuse_config.h',
 include_dirs = include_directories('include', 'lib', '.')
 
 # Common dependencies
-thread_dep = dependency('threads') 
+thread_dep = dependency('threads')
 
 #
 # Read build files from sub-directories

-- 
2.43.0

