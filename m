Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656A3A7F56
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560923; cv=fail; b=q4h5dHXYLTvL+fOB5knS+lZBS+zLlclnnNQ7WQ5OnBBBwopXpBMGvCpMWn8tN28N6+yuXJQuM109YEkn8hfhkEDTsefDjDiN1qsZ1D+2B9sqErX9mD5BqJgNAiww5gcCdKtMcR5xm7vdcwzhZ8wjwtcG/+MylgdFNk5EFXjpEOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560923; c=relaxed/simple;
	bh=0nUR0M2MOCQ9aJH3UahTQnrwKrFlPrxnjxWhzvPxFdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikWbuRAVma/r4AZiY6r5VidBNSev5GznNENtueJL+G741GHKzXDyaG7gxj8UDrWrDWAf9BLZA37kBPk+3/TLTe7WArCG9ad5Pe8rIjm5R8EEYlAr+SmtHD05OQjmS9Mauqui5U2/w9MSMiYZ7ek3mDZK52HMT3IJNTexDBzCVb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=bID2rzWh; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="bID2rzWh"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020088.outbound.protection.outlook.com [52.101.46.88]) by mx-outbound22-205.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V67+Nx7gp8I8g5r0qZ+JKfTq7ck0LK4elbvuZz36wmW7s4hBhnuXOJ2fsCFENFQZen+TbXhUFQtFtw2l5cvZy/XHpH3tdwS4BTdUAM3uWc53tUToYlLy4pb6uQh6py/wcsPMI61BValuo91n9IxfKG2kBfBFqQc6KpKpPLPMOUs6Bx2Kl6y8jHcPx/SyI3uNq7BokNR69htU8b62picTjy/K2Fxl+uP9btqtnKSYhq+XrF99wqOoJQhSpoWWq94R/QxZqDvpJUJRD3IDS1hKuBJuG5nSfm75Qu04HWiuiDtPU1uQI2aHaUeeuxO5Bb3WKwso75BjTLym7HNQY309Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxq7NvlmTAHoqj+5iZYkpf4rdCNTGLN16Hs1RKTijSQ=;
 b=HtGKi6YmEQb2AwVt1zgp6HYLE6Q6LY9A092PH6QDZVGq95iZTGP6OYGdspD01tA7UkBAL6/6yCZcaAbAxmIeOwjiFel0ApEGCVaoBhu5HN0RukOa976IU9nxGEt4saJAg3BqnSlXUORhnSKzg74FARA0yRJ/qGYVIH8wtTxL82JNFUttopwnBaTp4kh57+r14UnCjXiVMFhDIH5d44rX9eL/5tQpLIFnBcKecqwyxhlee/9vZdle3wrYFRUxtCae4tBrJsuHv9sS38ng0PtoiiD4qrRhdROv4ReuYuQiuy2zxbK7J+cKBZzb838u9exzJPYb7zN+RKTMaK5vbpmh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxq7NvlmTAHoqj+5iZYkpf4rdCNTGLN16Hs1RKTijSQ=;
 b=bID2rzWhsaA8SPp8x2ryYRo+6hlUTZwTO/R7xJQ36uTr/lAe9VN1B+oTO2Vjp6ExSH3w76cID/jpUMMm16/33OZGjPY3vLDzbwcvOl10qRcOrw12L0ay2RFZhzPTD/azWHX+HvX8zlo8expyDJHBe9B+IJ+Ls+JdusAuZe+zNU8=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by PH7PR19MB6657.namprd19.prod.outlook.com (2603:10b6:510:1ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:03 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::19) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Thu,
 26 Mar 2026 21:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Thu, 26 Mar 2026 21:35:00 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id CC30990C;
	Thu, 26 Mar 2026 21:34:59 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:41 +0100
Subject: [PATCH v2 08/25] Refactor mount code / move common functions to
 mount_util.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-8-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=10497;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=v7XyYQfMYHo7Fun8pxJWzEf8TnaPTJBB6ZuXQMMcmSI=;
 b=CYWEKJwyCtHMsPtKPD/De0hYh8/7ZHL3mWaIuxfdZZERswf0wlLwzhEdhKLla/sToeVPtasox
 X6MW6JkTZLqCRSb8i+jSyfNTy0RyT9e4fuPq86VocFEUkLBTdhOORNS
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH7PR19MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: a5aca020-23f8-4a6d-6a82-08de8b7f891a
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|19092799006|61400799027|376014|48200799018|18002099003|16102099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UdrMh9ed1kvD6WUqF3jQNKxsO2OFcAccdWSe0+ZxQvva2si6pr1hzER1drZ8w2dlttUbAmmokBtYvMezkAHQBBJk8XFvrfJTCKG3JAeWlLHOxC8chEdX/ts5i8cfOTIqSVFX2Z5fKUR723N4bh1/xXh/FkTdwgI86LUBV4+k+cE835wSrdknEPLAwvuN5ffpkPbf50+pQUMH5BpKSAWfrU/fxp/qdwGFDktV/k+ms7Vt0LtSfQWEUYQa9OYGi/5QVgTK+4tQUD+zluwDGcrj0kaZrlvOj6DPVjzbRCOc2/2G1uBYxANnFMRaCxxynUrxrKBKensz6hKdqTdhsMCf1VlCQcwqXNaYnyWYopm79hYKbiwvRDDGFVDi03QChUGCE+9wbJwCtfeQDVbqkOeCTiL2cc29KUr2JmlLwHPDQXPHxBW4bkshSrLmJ0jDVW97gosrYAYzGtSHCW2GZSfa8feHK2kD+B7ZnLxNMGED4pVeSHmrTwyzsjdWFZajS/aJOBD4lZ5nxZU2u6HmM/uJNTSZBA6SrGMEshMlV6k2ISebXEOtfNUbzfiL04W+2y1AgcJm96Yz37Uaj/kbndRFcpK/aN/sSOOHSm318XBLF0oFUZclnpz3FeW242q09u4GmJX+swu9rhMYYbn5g0dU8fKgs9ABbH/dZLWWg7BI5SU0WlwDt0U0QU2+xmNWXbCuLf6JpXDNd+5UZcykSK+Z8MNT88UgmLLQytxxwh15CWerB6cZvxRsOZOkuqQqdnkjjPAWlXycw9hJioF6qOkq5Q==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(19092799006)(61400799027)(376014)(48200799018)(18002099003)(16102099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UfnMbUj9piLuG6lpTDW8yYYqU/Rb5CNXT33T+sQV73uruX4SaLUBeztAkw0U69TZFbzIhZGCc55I8NzCvoHogg6Q8iOrOFMjzCqoXZoqe6PDLwEx8mXMGujB8quzMmYQgFCZIEhpQ7ATdV2EdcsSTZCEQVt2pd2QJVhUJaAdBrLqEOm2spz3ViGFu9eX32GJypDiDNcwZuz3ghh7IpPMTioJhnJ2IfzKES6w71V7i4jphaeWbJymXxYhlXneorIyDJLmSEBsU7bfMUKP3vG152Wng1Nigwmmnz+DHFthtVhZmdcIL48nSxJUcQpAn70HVeluhWMPn8L0+z/ATXKKdeRrqiAgl38iMT+LBgnhGR3QL1j5VtC3RJfEj1AwDsg3IpOYWbK/zl273HqBU7m1TooKullyrETdPy+2qLaRMcYCUxLi987oUYbMPLpg+O3F
X-Exchange-RoutingPolicyChecked:
	fzjEBQFMq2CYbOqV4mHhE9eAh296O/trgaWACEYhKRKtCH8sKuYyIqlrEGUhxjgejiVbSP1BMgttiQhcr2iSejZc7JaJMrNgZBq5FJj5Rz6Of7ma09On75tI9bUUnVmS0+fDArc5+fgfIPukXDrwsL9DvxR7AMCySuSYKJ6hEGokHGzd4c2k2ub8v+hzGr9a1h/V/kewlrRFb0QQ4rxks1pKUEoQdMRFwW0QtW6aJ5W5KwDFJk3jUpqbp1SnTG+g+a02PwBR9BGF6DTzm2aHtSCQUCuBkeN+pBSNWR2vWpkOBSjwx94mervfyJ8kdNkOE7SJE6EoJl2JTJYz15qt7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vn/8VSi7y+Gvi7QYlqXuwy7e3AYw5i5fjKBgmp26WjwPVuajT1nKeOTTg+33P7GIHMSoXjI0TSz5dAnQR17OdW5spTP5f0ph78u6hOqqMHV6E0VfvlAtgn5H7CczdJTzEb7Xv3vujOi6H3sitDvfRFjKdMPqQud03b2vHW9iS8H68pyx9CDP0d7a/jG1FNf/b52MBYcnZk7V73tuj3kmQOTYgXe+CA0IioH4QoRrkXTKliFEeKpdF/rlHrtgwR8fUObgxQpZrFG38TGxbYABsMzCASMNViPzMxknUSm8/Qq2G5BBCe0GTc6u73JX1HGJBdijurlhqIfjJICLvrC7Cr97kUpBNk4lbWjru5UT5TQGNNyKPMX8WIPWpsJN7hXKZBCuESqArQ99nReveySXTSq/ZIRhLKFZiFync5KrFtZ8r/PjnWWA8WDtj7yDG5fTTWgM4QW12j8Wom++rFcnrIVvZJ3TQEqITckUyQlDcbUEt0hsabyWIDIrjIkH13KnASvPll9s+DG5MDGwFueHqJnfJH5ICXcnuKWhSOZ1UN7LFnTYjWR0O/BcMReNsox+GZ0wyT2wjbo+96kGhPvYFs3/Yo+SAkddGnqq+W5I7o4XEjq2Hw+eqyULERAJx9ToFmGPdaKYNvLSPsvtY/rDDw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:00.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aca020-23f8-4a6d-6a82-08de8b7f891a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6657
X-BESS-ID: 1774560907-105837-9732-3006-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.46.88
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhuZmQGYGUNTU1DItycjI2N
	zSwiTFKNkgJck0Odk8xdwkzcDM2CjJQKk2FgCC/BB5QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan14-236.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Also create the new "mount_i.h", which is independent of the
the rest of libfuse.

This is preparation for the new mount API, which goes into a new file.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_i.h         | 10 ++----
 lib/mount.c          | 96 ++++++++++++++++++++++++++++------------------------
 lib/mount_bsd.c      |  1 +
 lib/mount_common_i.h | 31 +++++++++++++++++
 lib/mount_i_linux.h  | 32 ++++++++++++++++++
 lib/mount_util.c     | 24 +++++++++++++
 lib/mount_util.h     |  6 ++++
 7 files changed, 148 insertions(+), 52 deletions(-)

diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index a2438a15afdd3b5f62dd35bc3514f9f6853f00c3..6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -19,14 +19,15 @@
 #include <stdbool.h>
 #include <stdatomic.h>
 
+#ifndef MIN
 #define MIN(a, b) \
 ({									\
 	typeof(a) _a = (a);						\
 	typeof(b) _b = (b);						\
 	_a < _b ? _a : _b;						\
 })
+#endif
 
-struct mount_opts;
 struct fuse_ring_pool;
 
 struct fuse_req {
@@ -217,13 +218,8 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
  */
 void fuse_chan_put(struct fuse_chan *ch);
 
-/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
-#define FUSE_MOUNT_FALLBACK_NEEDED (-2)
-
-struct mount_opts *parse_mount_opts(struct fuse_args *args);
-void destroy_mount_opts(struct mount_opts *mo);
+/* Mount-related functions */
 void fuse_mount_version(void);
-unsigned get_max_read(struct mount_opts *o);
 void fuse_kern_unmount(const char *mountpoint, int fd);
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
 
diff --git a/lib/mount.c b/lib/mount.c
index dec9d52274c13536648cacef959789f472c5682c..fe353e2cc4579adb47473cac5db7d1bae2defb2c 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -16,6 +16,7 @@
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "mount_util.h"
+#include "mount_i_linux.h"
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -49,7 +50,6 @@
 #define FUSERMOUNT_PROG		"fusermount3"
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
-#define FUSE_KERN_DEVICE_ENV	"FUSE_KERN_DEVICE"
 
 #ifndef MS_DIRSYNC
 #define MS_DIRSYNC 128
@@ -65,20 +65,6 @@ enum {
 	KEY_RO,
 };
 
-struct mount_opts {
-	int allow_other;
-	int flags;
-	int auto_unmount;
-	int blkdev;
-	char *fsname;
-	char *subtype;
-	char *subtype_opt;
-	char *mtab_opts;
-	char *fusermount_opts;
-	char *kernel_opts;
-	unsigned max_read;
-};
-
 #define FUSE_MOUNT_OPT(t, p) { t, offsetof(struct mount_opts, p), 1 }
 
 static const struct fuse_opt fuse_mount_opts[] = {
@@ -197,7 +183,7 @@ static const struct mount_flags mount_flags[] = {
 	{NULL,	    0,		    0}
 };
 
-unsigned get_max_read(struct mount_opts *o)
+unsigned int get_max_read(struct mount_opts *o)
 {
 	return o->max_read;
 }
@@ -510,7 +496,7 @@ static int fuse_kern_mount_prepare(const char *mnt,
 				   struct mount_opts *mo)
 {
 	char tmp[128];
-	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
+	const char *devname = fuse_mnt_get_devname();
 	struct stat stbuf;
 	int fd;
 	int res;
@@ -563,35 +549,24 @@ out_close:
  * @mo: mount options
  * @mnt_opts: mount options to pass to the kernel
  *
- * Returns: 0 on success, -1 on failure, FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
+ * Returns: 0 on success, -1 on failure,
+ *          FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
  */
 static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 				  const char *mnt_opts)
 {
-	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
 	char *source = NULL;
 	char *type = NULL;
 	int res;
 
 	res = -ENOMEM;
-	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
-			(mo->subtype ? strlen(mo->subtype) : 0) +
-			strlen(devname) + 32);
-
-	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
+	source = fuse_mnt_build_source(mo);
+	type = fuse_mnt_build_type(mo);
 	if (!type || !source) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate memory\n");
 		goto out_close;
 	}
 
-	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
-	if (mo->subtype) {
-		strcat(type, ".");
-		strcat(type, mo->subtype);
-	}
-	strcpy(source,
-	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
-
 	res = mount(source, mnt, type, mo->flags, mo->kernel_opts);
 	if (res == -1 && errno == ENODEV && mo->subtype) {
 		/* Probably missing subtype support */
@@ -627,20 +602,10 @@ static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 		goto out_close;
 	}
 
-#ifndef IGNORE_MTAB
-	if (geteuid() == 0) {
-		char *newmnt = fuse_mnt_resolve_path("fuse", mnt);
-		res = -1;
-		if (!newmnt)
-			goto out_umount;
+	res = fuse_mnt_add_mount_helper(mnt, source, type, mnt_opts);
+	if (res == -1)
+		goto out_umount;
 
-		res = fuse_mnt_add_mount("fuse", source, newmnt, type,
-					 mnt_opts);
-		free(newmnt);
-		if (res == -1)
-			goto out_umount;
-	}
-#endif /* IGNORE_MTAB */
 	free(type);
 	free(source);
 
@@ -777,3 +742,44 @@ out:
 	free(mnt_opts);
 	return res;
 }
+
+const char *fuse_mnt_get_devname(void)
+{
+	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
+
+	return devname ? devname : "/dev/fuse";
+}
+
+char *fuse_mnt_build_source(const struct mount_opts *mo)
+{
+	const char *devname = fuse_mnt_get_devname();
+	char *source;
+
+	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
+			(mo->subtype ? strlen(mo->subtype) : 0) +
+			strlen(devname) + 32);
+	if (!source)
+		return NULL;
+
+	strcpy(source,
+	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
+
+	return source;
+}
+
+char *fuse_mnt_build_type(const struct mount_opts *mo)
+{
+	char *type;
+
+	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
+	if (!type)
+		return NULL;
+
+	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
+	if (mo->subtype) {
+		strcat(type, ".");
+		strcat(type, mo->subtype);
+	}
+
+	return type;
+}
diff --git a/lib/mount_bsd.c b/lib/mount_bsd.c
index c12ab322e7dc86d5c8d2f2abc6b71488e82523cf..c5b831160f826c0e4620626a72c4b93427d18bab 100644
--- a/lib/mount_bsd.c
+++ b/lib/mount_bsd.c
@@ -10,6 +10,7 @@
 
 #include "fuse_config.h"
 #include "fuse_i.h"
+#include "mount_common_i.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "util.h"
diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
new file mode 100644
index 0000000000000000000000000000000000000000..34f0f9893918a14c83a57a3212f80cfc96ed2e6d
--- /dev/null
+++ b/lib/mount_common_i.h
@@ -0,0 +1,31 @@
+/*
+ *  FUSE: Filesystem in Userspace
+ *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *                2026 Bernd Schubert <bernd@bsbernd.com>
+ *
+ *  This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file LGPL2.txt
+ */
+
+#ifndef FUSE_MOUNT_COMMON_I_H_
+#define FUSE_MOUNT_COMMON_I_H_
+
+/* Forward declaration for fuse_args */
+struct fuse_args;
+struct mount_opts;
+
+/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
+#define FUSE_MOUNT_FALLBACK_NEEDED (-2)
+
+/* Environment variable for FUSE kernel device */
+#define FUSE_KERN_DEVICE_ENV "FUSE_KERN_DEVICE"
+
+/* Mount options management functions */
+struct mount_opts *parse_mount_opts(struct fuse_args *args);
+void destroy_mount_opts(struct mount_opts *mo);
+unsigned int get_max_read(struct mount_opts *o);
+char *fuse_mnt_build_source(const struct mount_opts *mo);
+char *fuse_mnt_build_type(const struct mount_opts *mo);
+
+
+#endif /* FUSE_MOUNT_COMMON_I_H_ */
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
new file mode 100644
index 0000000000000000000000000000000000000000..254b75151f35578ce22197776e6fa4aceb04150e
--- /dev/null
+++ b/lib/mount_i_linux.h
@@ -0,0 +1,32 @@
+/*
+ *  FUSE: Filesystem in Userspace
+ *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *                2026 Bernd Schubert <bernd@bsbernd.com>
+ *
+ *  This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file LGPL2.txt
+ */
+
+#ifndef FUSE_MOUNT_I_LINUX_H_
+#define FUSE_MOUNT_I_LINUX_H_
+
+/* Forward declaration for fuse_args */
+struct fuse_args;
+
+/* Mount options structure */
+struct mount_opts {
+	int allow_other;
+	int flags;
+	int auto_unmount;
+	int blkdev;
+	char *fsname;
+	char *subtype;
+	char *subtype_opt;
+	char *mtab_opts;
+	char *fusermount_opts;
+	char *kernel_opts;
+	unsigned int max_read;
+};
+
+
+#endif /* FUSE_MOUNT_I_LINUX_H_ */
diff --git a/lib/mount_util.c b/lib/mount_util.c
index 8c0cdf72d978da68c95125964416b92668104924..a42a02a0b92f98778abb2c491cdc7a01260f56ee 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -375,3 +375,27 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint)
 
 	return -1;
 }
+
+int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
+			       const char *type, const char *mnt_opts)
+{
+#ifndef IGNORE_MTAB
+	if (geteuid() == 0) {
+		char *newmnt = fuse_mnt_resolve_path("fuse", mnt);
+		int res;
+
+		if (!newmnt)
+			return -1;
+
+		res = fuse_mnt_add_mount("fuse", source, newmnt, type,
+					 mnt_opts);
+		free(newmnt);
+		return res;
+	}
+#endif
+	(void)mnt;
+	(void)source;
+	(void)type;
+	(void)mnt_opts;
+	return 0;
+}
diff --git a/lib/mount_util.h b/lib/mount_util.h
index 9cb9077dd177381d712e34e7118bf73572142c6a..4688d00091f001b3ccd36b1ef3b7e799031ed773 100644
--- a/lib/mount_util.h
+++ b/lib/mount_util.h
@@ -7,6 +7,7 @@
 */
 
 #include <sys/types.h>
+#include "mount_common_i.h" // IWYU pragma: keep
 
 int fuse_mnt_add_mount(const char *progname, const char *fsname,
 		       const char *mnt, const char *type, const char *opts);
@@ -16,3 +17,8 @@ int fuse_mnt_umount(const char *progname, const char *abs_mnt,
 char *fuse_mnt_resolve_path(const char *progname, const char *orig);
 int fuse_mnt_check_fuseblk(void);
 int fuse_mnt_parse_fuse_fd(const char *mountpoint);
+
+/* Helper functions for mount operations */
+const char *fuse_mnt_get_devname(void);
+int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
+			       const char *type, const char *mnt_opts);

-- 
2.43.0

