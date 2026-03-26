Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AD3A7F56
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560947; cv=fail; b=f7u3uES84Vte03yRimT0M5UdMXgxfE7cXEEe1/fBvx2+DUDU45oj6G3Axm1HMGgA70NtujDDl11WI1P8757hI+WDkyMC+OUKLoVGJig5r8FhqedYQjNWppsQKyaoi6BzZvyMswFpMaEs2OjHPMjEDnSQPO3wpVCdnHrYucsFsMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560947; c=relaxed/simple;
	bh=6ELNES6LKtGhjTZEgXQwU2jvN6Ilyhx+JMO4VFHjK2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBcTgU/0+iU86jvH87YEDik76YcD4z1rBkAZCVgza/hlEZJlWdpfvH6/BJEpHUDvEt0BMQbN3jTDYHwN5gzlOxcVeUxsyZ6HUNsVdB0pLk5cnvXkZtLd4MpvlDDHrgFawWs+7Noutn3BvgYknMCWNol92vFcqxHhfZHBrlbbRFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=F+EDrwR1; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="F+EDrwR1"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022084.outbound.protection.outlook.com [40.93.195.84]) by mx-outbound14-31.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huw6nNpUZ+JlEzEwrKE1Z+s7ZtYjOt0o7YbWzS0EWQJ8PXZjHoWjxSutDYphENKkeLDno6s/o7M86H6OD8Zu4UdsIIw6nyi+a5R0LCfCym6CetDVY/vjN/ESnDH0KpDnQJ4fHN6Tt2oXej2hMt+4+iyZSbh7vvll97iQWYxrB6+ObrkEGbxQRx7qDl+l/1Lq458mIY81wbHV+E8Bom0SzL2k2GtAbpyg315ruZFVO9yqupbVz0dgslaHs+s4HpB+xP2QVwCeq7CDYyfVaOmVB94ySsrfYphEQqATL97X4/DGVY4UzdAJfV/su8f8qnZoWVCVR6HVLTz/LwNfAlwbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B5NVVDh9ecyWQPKssthCxg423IEz2Fn7wArB1fBV7g=;
 b=hYH3Sg2cFVMgK1lM/jzHQSGUrcSehqB7jBI0xgM1aTg8JEjkDI1oUgRQO01/5fZe/JyFNekXmEqdSM6gvFL5givuFUHOT3dG7vdsn9+QFBY4Iq+tPSzpYRnTMXOe6nYIPDiHfz+zhID44lMLOgfqXy+PqWOvocMDKml9plekUY3nmKl7LkyFrzeHNRA6grALnidxjC3L3boi8QGVBNeX2lLkw18UvCn/VhuP/Zyuc8HmFr55S280zE+RAzWb13WcBz+hnL8X0DcDKeDQitLOrsA9wJz6Hcrmxvk3HEodq3YStpkKNStsskkr3gEPFx/XOP2bWGw/Ys3bTqbd4OYUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B5NVVDh9ecyWQPKssthCxg423IEz2Fn7wArB1fBV7g=;
 b=F+EDrwR1MDRznqITc9nb9MOWLhjBIvYhw5CoE/3JLGZlLbodkvmFUrvT0WgbZRTyGv7eZjd0Q9vje+ihBwU+LjwUAWS1Bc8RoPejk+Lsp//ZHXMExiblvZUqhm6tAg7lEhDJeOC3RnDItR1beqVsE/BegzPhzy/bZTnxVBWftOE=
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by LV8PR19MB8495.namprd19.prod.outlook.com (2603:10b6:408:206::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:35:16 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::f5) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Thu,
 26 Mar 2026 21:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:15 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 02E9A55;
	Thu, 26 Mar 2026 21:35:14 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:57 +0100
Subject: [PATCH v2 24/25] Add mount and daemonization README documents
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-fuse-init-before-mount-v2-24-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560892; l=32210;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=6ELNES6LKtGhjTZEgXQwU2jvN6Ilyhx+JMO4VFHjK2Y=;
 b=XdNB6clYVxtrQpIA9jyxRWRGD59hn3NDthjMmxtmiICZXIDkpKSottZVXYNhmHeiygrfJ8orj
 PO7FKeQNdm3CEDcfmQ2/VBeo3Xmg9/yb/KOCtBd1SHQ4Qq4kDYCjMQt
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV8PR19MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf944e0-4874-4857-1c11-08de8b7f9209
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700016|19092799006|48200799018|56012099003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4aYjUYfQfwcayr6m4lqsV6h2cakI0qXyxc8TU/4/iQF23ZRitTK0EkW/fN5SLux2mbMtUR+WVuSrQQFf96FCfTnsQiCBi4dNs+fDq6/++wfGZ8aIqv/7i0eWZbS7nWvzw0lA7KsvSmMZWWsI/lm7p76u7Af/Rx58FN9YAIEMuibMf8m5A2FP3wclYqjxKITOSgKTyNl5ZQT73LMYNuABioZ8wSVmnBpTxkZiqbpNsMIMqpQsZrevXUonuqekzOlMm9sMVtH3BjWfE/3TG9CEVUuqJfeljjDqj30iuaCZyGOhnnLQ/LJsphHqzUpc/vJtTCLRkL0KhHVlfZLR83oUhlPyjA3Zau4z733MYuZ/qwN1zwTY9x2nyYpkgapKWYbIOacXv82Jaldu7yPFR7Ctk+XyGHNsozzgp21mamFZcoOMmZSz1+127lKVFm8myiKnIfOLOiJTNTLCH7GtkQVD5kideg8lORcVy7502EnACKWuHS7Ec9oDg3lkRny6uNOs5fMdzjqRVJKABJW9FCah1gouefk2M0ynHu9pvq4XEbrJ7gmjFQ3FeHgpT9LltAPECpZRVlfGGF5H5X8egLgGXTADxiGDYI4Dv0Ar2Zcbn/pvdQxI8I62vgUDX/N7X6zgmplJw1M4NcJqPd5vzKA6l1OZ76dMclvSTiw6ujAVGEDh1rpP+73P0iLeA56yihNhkuVUH/JGM/6Z0Bv6ozc0K72IvQcfIsT118hYUli/8cAR3/wp+9tDApseCUiSDZCKJo1MJFHvT9xFDJDVQvKtow==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700016)(19092799006)(48200799018)(56012099003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6I6AraJvSAXHYk60rvZ+/qBOg7aQ3STGbzh5VIOxwGeSqvG1GtU+p1iZ7LXW29F/CHv7nTkhlyBYEo7SyXmYPb1JECQ4ttGkfHCnY5+WiLI60sOVMh8UdqmrQQ/LCivqXwPgrnkEDODtrXuF0y9dtRBiGKWzdSBrWVrOU8tj0Yesil6OaPYizms4NVC1CKSgsQuNwawE3XvPUZrxmNEcLgLmzjtluy61ISj1OtdNX4dkETj/ZlNolGzq4WOix4T9lzVcTRdMV58oXRtOL46PRmV5TdBwQAlTXEtANsz6Z6cUdIe4m4dseVGduFO+P5L7YBtVZMEcdJ0L5a7oi/Jpd1rLB0lq5cGz1VXuk3QuvEOimrSuIotazyTa3JYgcggZa8ovGwdADrBKkX3DiI3xRMgO5IYVfC9n4jkAvtE3BEQaj1H4zM+vjm5In7Iv6rOp
X-Exchange-RoutingPolicyChecked:
	lbBCXNgUtz3NwKwmesrIXoQiX6fc193qcRJN13yu9RWzw0jb7YiW7wpgPvqThKH5b1R2mcCBEKEh4egW9LBZ7wYaD9vBwAtAJEu6nIDdCqRRayqy+wbT62DAbo49YSYgDug+RxxRkczPA9GuNPbLsD3EZAFu60fAxeUjWEV2enjia4eLsB5SbsW8ahqc3CaJMnPeJwFZkSOMjeF8O8EqcunJuYqJv3HAzx5vcqus+grpq0HGnz0fK8JZatenChSX3/A1H0Y4cG9gRLd5IeVbwzqC+A/TBcnxypzRUcIcGmzIJggLrS2EffUj5u1xeEmsPMJM3V5h19pllaLtRSaT0A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+0aV2m7yKE9SCiJ1dlgiRPYDDDFf/RK+1qudf/2xXOm/fRzFRoMHS54G+LYk5u1E9evjCQL6hifiLgXh+od5TqFQb5Yj7DAnPcoWLLWZDe9W3rV3z2dIQqGzT3+1++zpdPVEKclalvaY0X6KZvVRAnsILQ6hWWS0wcg4uZUOSuN7Eq/cWxztyFa7ek2YH4CVo8HUke1av80RXQIQ7uSutXYrR2Iezx4wj1hdJZ6CmEp7P6YkMLiwN4UifAH54xvraaHGna1gYVF68No+kmJSIJFfJBtWbz70Kxor5O62TReXmR/gOCScJI/1iIg4YRfwjG6VYBFhMR++VGc3lmDR4YboP/jZRbXPMsLkhKTwWGzSVnIEM/Ray7xiRc5WqGI1+ibbxGrs7ChSrmZUlLBWlDC1BqMNbif07RM1p47TBP0BUCcZ+uUyeZ51IW2RHJfzV2moadCARvvoY4lxjbrgot7dHhpd2ayqgtg+86EZ2ZRw4I6mu6Wh6sgAv1geeizs5xTyGbuEVcllqXESWjhnplWvnLzXX1K3GSjLtAUrtJdFyhGYYYUN17Gwz0497pHa806Y6BPR+TwI9JyUyvdmrnO+J/yyknfxJi5AhJp7M5M9ngbvQwCgReRGwF2I2hvkItX5X8iy6ZuGwFXub5KiAw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:15.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf944e0-4874-4857-1c11-08de8b7f9209
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8495
X-BESS-ID: 1774560924-103615-7705-13421-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.93.195.84
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGxiamQGYGUNTI0sTE0sI8xd
	AgKdXQyNjUzMDIMNEcSJikWSSZGicr1cYCAPsoavBCAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan18-240.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

These are useful to

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 doc/README.daemonize  | 197 +++++++++++++++++++++++++++
 doc/README.fusermount | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/README.mount      |  86 ++++++++++++
 doc/README.sync-init  | 184 +++++++++++++++++++++++++
 4 files changed, 829 insertions(+)

diff --git a/doc/README.daemonize b/doc/README.daemonize
new file mode 100644
index 0000000000000000000000000000000000000000..7b56c33077f29edbd335a2778120d9b6db6022ad
--- /dev/null
+++ b/doc/README.daemonize
@@ -0,0 +1,197 @@
+FUSE Daemonization API
+======================
+
+This document describes the FUSE daemonization APIs, including the legacy
+fuse_daemonize() function and the new fuse_daemonize_start()/signal() API
+introduced in libfuse 3.19.
+
+
+Overview
+--------
+
+FUSE filesystems often need to run as background daemons. Daemonization
+involves forking the process, creating a new session, and redirecting
+standard file descriptors. The challenge is properly reporting initialization
+failures to the parent process.
+
+
+Old API: fuse_daemonize()
+--------------------------
+
+Function signature:
+    int fuse_daemonize(int foreground);
+
+Location: lib/helper.c
+
+This is the legacy daemonization API, primarily used with the high-level
+fuse_main() interface.
+
+Behavior:
+- If foreground=0: forks the process, creates a new Unix session,
+  redirects stdio
+- If foreground=1: only changes directory to "/"
+- Parent waits for a single byte on a pipe before exiting
+- Child writes completion byte immediately after redirecting stdio
+- Always changes directory to "/"
+
+Limitations:
+1. No failure reporting: The parent receives notification immediately after
+   fork/setsid, before any meaningful initialization (like mounting the
+   filesystem or starting threads).
+
+2. Timing constraint: Must be called AFTER fuse_session_mount() in existing
+   examples, because there's no way to report mount failures to the parent.
+
+3. Thread initialization: Cannot report failures from complex initialization
+   steps like:
+   - Starting worker threads
+   - Network connection setup
+   - RDMA memory registration
+   - Resource allocation
+
+4. FUSE_SYNC_INIT incompatibility: With the FUSE_SYNC_INIT feature, FUSE_INIT
+   happens at mount time and may start io_uring threads. This requires
+   daemonization BEFORE mount, which the old API cannot handle properly.
+
+Example usage (old API):
+    fuse = fuse_new(...);
+    fuse_mount(fuse, mountpoint);
+    fuse_daemonize(opts.foreground);  // After mount, can't report mount failure
+    fuse_set_signal_handlers(se);
+    fuse_session_loop(se);
+
+
+New API: fuse_daemonize_start() / fuse_daemonize_success() / fuse_daemonize_fail()
+---------------------------------------------------------------------------------
+
+Functions:
+    int fuse_daemonize_start(unsigned int flags);
+    void fuse_daemonize_success(void);
+    void fuse_daemonize_fail(void);
+    bool fuse_daemonize_active(void);
+
+Location: lib/fuse_daemonize.c, include/fuse_daemonize.h
+Available since: libfuse 3.19
+
+This new API solves the limitations of fuse_daemonize() by splitting
+daemonization into two phases:
+
+1.   fuse_daemonize_start() - Fork and setup, but parent waits
+2.1. fuse_daemonize_fail() - Signal failure to parent
+2.2  fuse_daenmize_success() - Signal startup to success to the parent
+     See below for an important detail.
+
+
+fuse_daemonize_start()
+----------------------
+
+Flags:
+- FUSE_DAEMONIZE_NO_CHDIR: Don't change directory to "/"
+- FUSE_DAEMONIZE_NO_BACKGROUND: Don't fork (foreground mode)
+
+Behavior:
+- Unless NO_BACKGROUND: forks the process
+- Parent waits for status signal from child
+- Child creates new session and continues
+- Unless NO_CHDIR: changes directory to "/"
+- Closes stdin immediately in child
+- Starts a watcher thread to detect parent death
+- Returns 0 in child on success, negative errno on error
+
+Parent death detection:
+- Uses a "death pipe" - parent keeps write end open
+- Child's watcher thread polls the read end
+- When parent dies, pipe gets POLLHUP and child exits
+- Prevents orphaned daemons if parent is killed
+
+
+fuse_daemonize_fail(int err)
+----------------------------
+
+Behavior:
+- Signals the parent about the provided error
+- Parent will exit with that error
+
+fuse_daemonize_success()
+------------------------
+- Signals the parent process with succes
+- On success: redirects stdout/stderr to /dev/null
+- Stops the parent watcher thread
+- Cleans up pipes and internal state
+- Safe to call multiple times
+- Safe to call even if fuse_daemonize_start() failed
+- *Important*: Should be called twice, once from ->init
+  (struct fuse_lowlevel_ops::init or for high level interface
+   struct fuse_operations::init) and after fuse_session_mount().
+  It will internally figure out which of these two calls will
+  actually signal the parent about success. Reason is that
+  sucess must only be signaled when the mount is complete and
+  that depends on if synchronous or asynchronous FUSE_INIT is
+  used. 
+
+
+fuse_daemonize_active()
+-----------------------
+
+Returns true if daemonization is active and waiting for signal.
+
+Used by the high-level fuse_main() to detect if the application already
+called the new API, avoiding double-daemonization.
+
+
+Example usage (new API):
+-------------------------
+
+    // Start daemonization BEFORE mount
+    unsigned int daemon_flags = 0;
+    if (foreground)
+        daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
+
+    if (fuse_daemonize_start(daemon_flags) != 0)
+        goto error;
+
+    // Complex initialization can fail and be reported
+    if (setup_threads() != 0)
+        goto error_signal;
+
+    if (setup_network() != 0)
+        goto error_signal;
+    // Mount can now fail and be reported to parent
+    if (fuse_session_mount(se, mountpoint) != 0)
+        goto error_signal;
+
+    // Signal success - parent exits with EXIT_SUCCESS
+    // This is typically done in the init() callback after FUSE_INIT
+    fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
+
+    // Run main loop
+    fuse_session_loop(se);
+
+    return 0;
+
+error_signal:
+    // Signal failure - parent exits with EXIT_FAILURE
+    fuse_daemonize_signal(FUSE_DAEMONIZE_FAILURE);
+error:
+    return 1;
+
+
+When to signal success
+----------------------
+
+The success signal should be sent after all critical initialization is
+complete. For FUSE filesystems, this is typically in the init() callback,
+after FUSE_INIT has been processed successfully.
+
+Example (from passthrough_hp.cc):
+    static void sfs_init(void *userdata, fuse_conn_info *conn) {
+        // ... initialization ...
+        fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
+    }
+
+This ensures the parent only exits after:
+- Mount succeeded
+- FUSE_INIT completed
+- All threads started
+- Filesystem is ready to serve requests
+
diff --git a/doc/README.fusermount b/doc/README.fusermount
new file mode 100644
index 0000000000000000000000000000000000000000..5b81651c8690aa25fef12db322af977c9cba1d31
--- /dev/null
+++ b/doc/README.fusermount
@@ -0,0 +1,362 @@
+Synchronous FUSE_INIT Protocol
+================================
+
+Overview
+--------
+
+The sync-init feature enables the FUSE library to start worker threads and
+perform initialization ioctl calls BEFORE the actual mount() syscall happens.
+This is required for the kernel's synchronous FUSE_INIT feature, where the
+mount() syscall blocks until the FUSE daemon processes the INIT request.
+
+Without this feature, there would be a deadlock:
+- mount() blocks waiting for INIT response
+- Worker threads can't start because mount() hasn't returned
+- INIT request can't be processed because worker threads aren't running
+
+
+Protocol Flow
+-------------
+
+Traditional mount flow:
+  1. Library calls fusermount3
+  2. fusermount3 opens /dev/fuse
+  3. fusermount3 performs mount() syscall
+  4. fusermount3 sends fd to library
+  5. Library starts worker threads
+  6. Worker threads process FUSE requests
+
+Sync-init mount flow:
+  1. Library calls fusermount3 with --sync-init flag
+  2. fusermount3 opens /dev/fuse
+  3. fusermount3 sends fd to library
+  4. Library receives fd
+  5. Library performs FUSE_DEV_IOC_SYNC_INIT ioctl
+  6. Library starts worker threads
+  7. Library sends "proceed" signal to fusermount3
+  8. fusermount3 performs mount() syscall (blocks until INIT completes)
+  9. Worker threads process INIT request
+  10. mount() syscall completes
+  11. fusermount3 exits
+
+
+Implementation Details
+----------------------
+
+Bidirectional Communication:
+  - Uses the existing unix socket (_FUSE_COMMFD environment variable)
+  - Simple 1-byte protocol for signaling
+  - Library signals fusermount3 when ready to proceed with mount
+
+fusermount3 Changes:
+  - New --sync-init command-line option
+  - Split mount operation into two phases:
+    * mount_fuse_prepare(): Opens device, prepares parameters
+    * mount_fuse_finish_fsmount(): Performs actual mount() syscall
+  - wait_for_signal(): Waits for library to signal readiness
+  - struct mount_context: Preserves state between phases
+
+Library Changes:
+  - fuse_session_mount_new_api(): Uses new protocol when available
+  - Sends "proceed" signal after worker thread is ready
+  - Handles both old and new mount protocols for compatibility
+
+
+Backward Compatibility
+----------------------
+
+The implementation maintains full backward compatibility:
+  - Old library + new fusermount3: Works (uses traditional flow)
+  - New library + old fusermount3: Falls back to traditional flow
+  - New library + new fusermount3: Uses sync-init flow when appropriate
+
+
+Error Handling
+--------------
+
+If any step fails during the sync-init flow:
+  - fusermount3 closes the fd and exits with error
+  - Library detects failure and cleans up
+  - No mount is left in inconsistent state
+
+Connection closure:
+  - If library closes socket before signaling, fusermount3 detects and exits
+  - If fusermount3 crashes, library detects closed socket
+
+
+Security Considerations
+-----------------------
+
+The sync-init protocol does not introduce new security concerns:
+  - Uses the same privilege separation as traditional mount
+  - Socket communication is already established and trusted
+  - No new privileged operations are added
+  - File descriptor passing uses existing SCM_RIGHTS mechanism
+
+
+Performance Impact
+------------------
+
+Minimal performance impact:
+  - One additional recv() call in fusermount3
+  - One additional send() call in library
+  - Total overhead: ~2 context switches
+  - Only affects mount time, not runtime performance
+
+
+Future Enhancements
+-------------------
+
+Potential improvements:
+  - Extended protocol for more complex initialization sequences
+  - Support for multiple worker threads coordination
+  - Enhanced error reporting through the socket
+  - Timeout mechanisms for detecting hung initialization
+
+
+ASCII Workflow Diagrams
+========================
+
+1. Traditional Mount Flow (without --sync-init, async INIT)
+------------------------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [mount() syscall]           |
+   |                           |------ mount -------->|
+   |                           |<----- success ------ | [mount returns immediately]
+   |                           |                      | [INIT queued in kernel]
+   |                      [send_fd(fd)]               |
+   |<------- fd --------------|                      |
+   |                           |                      |
+   |                      [fusermount3 exits]         |
+   |                                                  |
+   |  [start worker thread]                          |
+   |  [worker reads /dev/fuse]                       |
+   |---------------------------------------- read -->|
+   |<--------------------------------------- INIT ---| [dequeued from kernel]
+   |                                                  |
+   | OK: INIT was queued, worker reads it later      |
+   |     Works fine for async INIT                   |
+
+
+1b. Problem: Synchronous INIT without --sync-init
+--------------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [mount() syscall]           |
+   |                           |------ mount -------->|
+   |                           |                      | [mount BLOCKS waiting for INIT]
+   |                           | (BLOCKED)            | [needs worker to process INIT]
+   |                           |                      |
+   |  [waiting for fd...]      |                      |
+   |                           |                      |
+   |                           |                      |
+   | DEADLOCK: mount() waits for INIT response       |
+   |           but worker thread not started yet     |
+   |           because we're waiting for fd          |
+
+
+2. Sync-Init Mount Flow (with --sync-init)
+-------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |    with --sync-init       |                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [send_fd(fd)]               |
+   |<------- fd --------------|                      |
+   |                           |                      |
+   |                      [wait_for_signal()]         |
+   |                           | (BLOCKED)            |
+   |                           |                      |
+   |  [ioctl SYNC_INIT]        |                      |
+   |---------------------------------------- ioctl -->|
+   |                                                  |
+   |  [start worker thread]                          |
+   |  [worker ready]                                 |
+   |                           |                      |
+   |--- "proceed" signal ----->|                      |
+   |                      [signal received]           |
+   |                           |                      |
+   |                      [mount() syscall]           |
+   |                           |------ mount -------->|
+   |                           |                      | [mount blocks]
+   |                           |                      | [sends INIT]
+   |<------------------------------------------------ |
+   |                           |                      |
+   | [worker processes INIT]   |                      |
+   |------------------------------------------------->|
+   |                           |                      | [mount unblocks]
+   |                           |<----- success ------ |
+   |                           |                      |
+   |                      [fusermount3 exits]         |
+   |                                                  |
+   | SUCCESS: Worker ready before mount()            |
+   |          INIT processed synchronously           |
+
+
+3. Error Scenario: Library Crashes Before Signaling
+----------------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |    with --sync-init       |                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [send_fd(fd)]               |
+   |<------- fd --------------|                      |
+   |                           |                      |
+   |                      [wait_for_signal()]         |
+   |                           | (BLOCKED)            |
+   |                           |                      |
+   X  [library crashes]        |                      |
+   |                           |                      |
+   |                      [recv() returns 0]          |
+   |                      [socket closed]             |
+   |                           |                      |
+   |                      [cleanup and exit]          |
+   |                           X                      |
+   |                                                  |
+   | RESULT: Clean failure, no mount performed       |
+
+
+4. Detailed Function Call Flow
+-------------------------------
+
+Library (lib/fuse_lowlevel.c):
+fuse_session_mount_new_api()
+   |
+   +-- fuse_kern_mount_prepare()  [lib/mount.c]
+   |      |
+   |      +-- fuse_mount_fusermount()  [lib/mount_util.c]
+   |             |
+   |             +-- socketpair()  [create comm socket]
+   |             |
+   |             +-- fork()
+   |             |
+   |             +-- [child] execl("fusermount3", "--sync-init", ...)
+   |             |
+   |             +-- [parent] receive_fd()  <--- BLOCKS until fd arrives
+   |                    |
+   |                    +-- recvmsg(SCM_RIGHTS)
+   |                    |
+   |                    +-- return fd
+   |
+   +-- session_start_sync_init()  [lib/fuse_lowlevel.c]
+   |      |
+   |      +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
+   |      |
+   |      +-- pthread_create(worker_thread)
+   |      |
+   |      +-- return
+   |
+   +-- fuse_fusermount_proceed_mnt(socket)  [lib/mount.c] <--- NEW: Bidirectional handshake
+          |
+          +-- send(socket, "proceed", 1)  <--- Signal fusermount3 to proceed
+          |
+          +-- recv(socket, &status, 1)  <--- BLOCKS until mount result arrives
+          |      |
+          |      +-- [fusermount3 performs mount and sends status byte]
+          |
+          +-- if (status != 0) return -1  <--- Mount failed
+          |
+          +-- return 0  <--- Mount succeeded
+
+
+Utility (util/fusermount.c):
+fusermount3 main() with --sync-init
+   |
+   +-- mount_fuse_sync_init()  [util/fusermount.c]
+          |
+          +-- mount_fuse_prepare()  [util/fusermount.c]
+          |      |
+          |      +-- open("/dev/fuse")
+          |      |
+          |      +-- check_perm()  [util/fusermount.c]
+          |      |
+          |      +-- return fd
+          |
+          +-- send_fd(socket, fd)  [util/fusermount.c]
+          |      |
+          |      +-- sendmsg(SCM_RIGHTS)
+          |
+          +-- wait_for_signal(socket)  [util/fusermount.c] <--- BLOCKS until library signals
+          |      |
+          |      +-- recv(socket, buf, 1)
+          |      |
+          |      +-- return 0
+          |
+          +-- mount_fuse_finish_fsmount()  [util/fusermount.c]
+          |      |
+          |      +-- fuse_kern_fsmount()  [lib/mount_fsmount.c]
+          |      |      |
+          |      |      +-- fsopen("fuse", FSOPEN_CLOEXEC)
+          |      |      |      |
+          |      |      |      +-- [kernel creates filesystem context]
+          |      |      |
+          |      |      +-- fsconfig(fsfd, SET_STRING, "source", ...)
+          |      |      +-- fsconfig(fsfd, SET_STRING, "fd", fd_value, ...)
+          |      |      +-- fsconfig(fsfd, ...) [apply mount options]
+          |      |      +-- fsconfig(fsfd, CMD_CREATE, ...)
+          |      |      |
+          |      |      +-- fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs)
+          |      |      |      |
+          |      |      |      +-- [kernel sends FUSE_INIT here]
+          |      |      |      |
+          |      |      |      +-- [worker thread processes INIT]
+          |      |      |      |
+          |      |      |      +-- [fsmount returns mntfd]
+          |      |      |
+          |      |      +-- move_mount(mntfd, "", AT_FDCWD, target, ...)
+          |      |      |      |
+          |      |      |      +-- [attach mount to target directory]
+          |      |      |      |
+          |      |      |      +-- [no blocking - INIT already processed]
+          |      |      |
+          |      |      +-- add_mount()  [lib/mount_fsmount.c - update /etc/mtab]
+          |      |      |
+          |      |      +-- return 0 on success, -1 on failure
+          |      |
+          |      +-- if mount failed: return -1
+          |      +-- if mount succeeded: continue
+          |
+          +-- send_status_byte(socket)  [util/fusermount.c] <--- NEW: Send result to library
+          |      |
+          |      +-- status = (mount_result == 0) ? 0 : 1
+          |      +-- send(socket, &status, 1)
+          |      |
+          |      +-- return
+          |
+          +-- return 0
+
+
+Note: The new mount API (fsopen/fsconfig/fsmount/move_mount) is REQUIRED
+      for sync-init because fsmount() triggers FUSE_INIT before the mount
+      is attached. This allows the worker thread to process INIT before
+      move_mount() completes, preventing deadlock.
+      And also so we don't expose the directory tree to the mountns until we
+      know that FUSE_INIT didn't crash the server.
+
diff --git a/doc/README.mount b/doc/README.mount
new file mode 100644
index 0000000000000000000000000000000000000000..526382ad8a5f6b405a7cb1927b79bacd6c2c2c5c
--- /dev/null
+++ b/doc/README.mount
@@ -0,0 +1,86 @@
+FUSE Mount API Flowcharts
+=========================
+
+Old Mount API
+-------------
+
+fuse_kern_mount()
+  |
+  +-- fuse_mount_sys()
+  |     +-- Try direct mount → mount() syscall
+  |     +-- On EPERM: fuse_mount_fusermount()
+  |           +-- socketpair()
+  |           +-- spawn fusermount3 (no --sync-init)
+  |           +-- fusermount3: open /dev/fuse, mount(), send fd
+  |           +-- receive_fd() → return fd
+  |
+  +-- Worker threads started AFTER mount
+  └─> FUSE_INIT asynchronous (queued in kernel)
+
+
+New Mount API - Privileged Mount
+---------------------------------
+
+fuse_session_mount_new_api()
+  |
+  +-- fuse_kern_mount_prepare() → open /dev/fuse → fd
+  |
+  +-- session_start_sync_init(se, fd)
+  |     +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
+  |     +-- pthread_create(worker) → ready to process FUSE_INIT
+  |
+  +-- fuse_kern_fsmount_mo()
+  |     +-- fsopen/fsconfig/fsmount (BLOCKS until FUSE_INIT completes)
+  |     +-- Worker processes FUSE_INIT during fsmount()
+  |     +-- move_mount()
+  |
+  +-- session_wait_sync_init_completion(se) → pthread_join
+  └─> return fd
+
+
+New Mount API - EPERM Fallback (fusermount3 with sync-init)
+------------------------------------------------------------
+
+fuse_session_mount_new_api()
+  |
+  +-- fuse_kern_mount_prepare() → open /dev/fuse → fd1
+  |
+  +-- session_start_sync_init(se, fd1)
+  |     +-- ioctl(fd1, FUSE_DEV_IOC_SYNC_INIT)
+  |     +-- pthread_create(worker) → ready with fd1
+  |
+  +-- fuse_kern_fsmount_mo() → EPERM
+  |
+  +-- *** FALLBACK TO FUSERMOUNT3 WITH SYNC-INIT ***
+  |
+  +-- session_wait_sync_init_completion(se)
+  |     +-- pthread_cancel/join → terminate worker with wrong fd1
+  |
+  +-- close(fd1)
+  |
+  +-- fuse_mount_fusermount_sync_init()  [NEW]
+  |     +-- socketpair()
+  |     +-- spawn fusermount3 --sync-init
+  |     +-- fusermount3: open /dev/fuse → fd2, send fd2
+  |     +-- receive_fd() → fd2
+  |     +-- fusermount3 waits for signal
+  |     └─> return fd2, sock
+  |
+  +-- session_start_sync_init(se, fd2)
+  |     +-- ioctl(fd2, FUSE_DEV_IOC_SYNC_INIT)
+  |     +-- pthread_create(worker) → ready with fd2
+  |
+  +-- send_proceed_signal(sock)  [NEW]
+  |     +-- send(sock, "\0", 1) → signal fusermount3
+  |
+  +-- fusermount3: mount() (BLOCKS)
+  |     +-- Kernel sends FUSE_INIT to fd2
+  |     +-- Worker processes FUSE_INIT
+  |     +-- mount() returns
+  |
+  +-- close(sock)
+  |
+  +-- session_wait_sync_init_completion(se) → pthread_join
+  |
+  └─> return fd2
+
diff --git a/doc/README.sync-init b/doc/README.sync-init
new file mode 100644
index 0000000000000000000000000000000000000000..44e47a2eef2c45026abaa19562537eef37f256b9
--- /dev/null
+++ b/doc/README.sync-init
@@ -0,0 +1,184 @@
+FUSE Synchronous vs Asynchronous FUSE_INIT
+============================================
+
+This document explains the difference between asynchronous and synchronous
+FUSE_INIT processing, and when each mode is used.
+
+
+Overview
+--------
+
+FUSE_INIT is the initial handshake between the kernel FUSE module and the
+userspace filesystem daemon. During this handshake, the kernel and daemon
+negotiate capabilities, protocol version, and various feature flags.
+
+Asynchronous FUSE_INIT (Traditional Behavior)
+----------------------------------------------
+
+In the traditional asynchronous mode:
+
+1. mount() syscall completes and returns to caller
+2. Filesystem appears mounted to the system
+3. FUSE daemon starts worker threads
+4. Worker threads process FUSE_INIT request
+5. Filesystem becomes fully operational
+
+Timeline:
+    mount() -----> returns
+                   |
+                   v
+            FUSE_INIT sent
+                   |
+                   v
+            daemon processes FUSE_INIT
+                   |
+                   v
+            filesystem ready
+
+Limitations:
+
+1. **No early requests**: The kernel cannot send requests (like getxattr)
+   during the mount() syscall. This breaks SELinux, which needs to query
+   extended attributes on the root inode immediately upon mounting.
+
+2. **Daemonization timing**: With the old fuse_daemonize() API, the daemon
+   must call it AFTER mount, because there's no way to report mount failures
+   to the parent process if daemonization happens first.
+
+3. **No custom root inode**: The root inode ID is hardcoded to FUSE_ROOT_ID (1)
+   because FUSE_INIT hasn't been processed yet when the mount completes.
+
+4. **Thread startup after mount**: io_uring threads and other worker threads
+   can only start after mount() returns, not before.
+
+
+Synchronous FUSE_INIT (New Behavior)
+-------------------------------------
+
+Kernel support: Linux kernel commit dfb84c330794 (v6.18+)
+libfuse support: libfuse 3.19+
+
+In synchronous mode:
+
+1. FUSE daemon opens /dev/fuse
+2. Daemon calls ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
+3. Daemon starts worker thread
+4. Daemon calls mount() syscall
+5. Kernel sends FUSE_INIT during mount() - mount() blocks
+6. Worker thread processes FUSE_INIT while mount() is blocked
+7. Worker thread may process additional requests (getxattr, etc.)
+8. mount() syscall completes and returns
+9. Filesystem is fully operational
+
+Timeline:
+    open /dev/fuse
+         |
+         v
+    ioctl(FUSE_DEV_IOC_SYNC_INIT)
+         |
+         v
+    start worker thread
+         |
+         v
+    mount() -----> blocks
+         |         |
+         |         v
+         |    FUSE_INIT sent
+         |         |
+         |         v
+         |    worker processes FUSE_INIT
+         |         |
+         |         v
+         |    (possible getxattr, etc.)
+         |         |
+         +-------> returns
+                   |
+                   v
+            filesystem ready
+
+Advantages:
+
+1. **SELinux support**: The kernel can send getxattr requests during mount()
+   to query security labels on the root inode.
+
+2. **Early daemonization**: The daemon can fork BEFORE mount using the new
+   fuse_daemonize_start()/signal() API, and report mount failures to the
+   parent process.
+
+3. **Custom root inode**: The daemon can specify a custom root inode ID
+   during FUSE_INIT, before mount() completes.
+
+4. **Thread startup before mount**: io_uring threads and worker threads
+   start before mount(), ensuring they're ready to handle requests.
+
+5. **Better error reporting**: Mount failures and initialization errors
+   can be properly reported to the parent process when using the new
+   daemonization API.
+
+
+When Synchronous FUSE_INIT is Used
+-----------------------------------
+
+libfuse automatically enables synchronous FUSE_INIT when:
+
+1. The application calls fuse_session_want_sync_init(), OR
+2. The new daemonization API is used (fuse_daemonize_start() was called)
+
+Synchronous FUSE_INIT requires:
+- Kernel support (commit dfb84c330794 or later)
+- Worker thread started before mount()
+- ioctl(FUSE_DEV_IOC_SYNC_INIT) succeeds
+
+If the kernel doesn't support synchronous FUSE_INIT, libfuse automatically
+falls back to asynchronous mode.
+
+
+Implementation Details
+----------------------
+
+The synchronous FUSE_INIT implementation uses a worker thread:
+
+- **session_sync_init_worker()**: Thread function that polls /dev/fuse
+  and processes FUSE_INIT and any subsequent requests until mount completes.
+
+- **session_start_sync_init()**: Creates the worker thread before mount().
+  Calls ioctl(FUSE_DEV_IOC_SYNC_INIT) to enable kernel support.
+
+- **session_wait_sync_init_completion()**: Waits for the worker thread
+  to complete after mount() returns. Checks for errors.
+
+The worker thread processes requests in a loop until se->terminate_mount_worker
+is set, which happens after mount() completes successfully.
+
+
+Compatibility
+-------------
+
+Synchronous FUSE_INIT is fully backward compatible:
+
+- Old kernels: ioctl returns ENOTTY, libfuse falls back to async mode
+- Old applications: Continue to work with async FUSE_INIT
+- New applications on old kernels: Graceful fallback to async mode
+- New applications on new kernels: Automatic sync mode when appropriate
+
+
+Example: Enabling Synchronous FUSE_INIT
+----------------------------------------
+
+Explicit request:
+    struct fuse_session *se = fuse_session_new(...);
+    fuse_session_want_sync_init(se);
+    fuse_session_mount(se, mountpoint);
+
+Automatic (with new daemonization API):
+    fuse_daemonize_start(0);  // Triggers sync init automatically
+    fuse_session_mount(se, mountpoint);
+
+
+See Also
+--------
+
+- doc/README.daemonize - New daemonization API documentation
+- doc/README.fusermount - Synchronous FUSE_INIT protocol with fusermount3
+- doc/README.mount - Mount implementation details
+

-- 
2.43.0

