Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F63358B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287936; cv=fail; b=iJXCCEHx9RzWt2LZiLySjkffq368YpOt6L48ddqUHop/jvvfAWmT8rf0smv0YMVGzhSg2GMPlELMDFe5j3U0yXxXDObMhYBAO3AW44v1iG/zdvkaTYrJim5e3gYoQ2KPyzdvai3jQqrMmdOrVBFLESI4OH26QadePbsFEd8Mrb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287936; c=relaxed/simple;
	bh=7CKLKe7Su+ND9y1AFiIy+jsXWJ/XiYIV6IrPU2RSj8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZs60y4wiJpZSHHPBBJ6bnxQqsXakOqePUkVXQLn/zgdCJ+o4EIcxXfDRnhLKG4DgpyfTlVCrWjMWQ6FuyftdehXvUy+qMpe86R6HjfoWlGnqPZMKiAkXpvB+A9QM+OWqmBZiI0EaIqR5SuseA4/73I+ZsFnzp7JopusMneqY7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=I8xKvs2j; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="I8xKvs2j"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023121.outbound.protection.outlook.com [40.107.201.121]) by mx-outbound22-226.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLSde7dV5crWM7ioG9ND4bpJB9t8IBgCEVWfzoXjQ7ep+YHYeK7EGPmCmLBeMKA35mEqw9alALJ+C2DmOvoYASLjZ9aklzTDnO/w7Y8u0I7JPht33EjU9GHjcIxb5CpFSZWq0i5DvGw/wSS/3zZqjvbvAVs7snM76V81pdxGC2tgkcqUhNuDrH6EhVLjgT7DDvntR2YmU9+6iKhBLD0uhrm/Pn+g6GmJB2mBQc4ep3HOWlY8p9VYqYpkFwOyEf+9utK8H66NvZzEYfiv3vsIt8yP0sV0yWh/kkIMQ7JAlUgR880fXrHerKuBwW+iOa0gTC617XqDkH2ZE3h/Q8ElIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YceOgo9Y/si3sCiWY07eAh+lAVBrVbHCetibpzdVW8=;
 b=LIt4S9M+5s8gy8fwGe/Biopm6P6dQv1IBSv2BvIvfjwWhffyOfI2wkfDEeYB5g+mus76o7Sa9dkThrb3GLS4rIiaTPOAx0mb3Lrc60axBq51BhKmkqouNlKbnKRpr11xpyRC3iLvwgIqz5e9hyuwB5G6ggKAMEMNzSOL13dW1ffIQ35flVyYttAbWp+Z4M6CaBYo4vQMbayY+207jTX1dFJv9KJ5cBVdbMXgtEhF4FeD+Nt6ZyuJnPzFf5JjKmYADNEVsZEG3uSwU4dFYptOjsibAWdz40SpLdYniE7Tkolxbtku+gnMCmZ7Y8yiQQPpoql0KBqiWIBolK3EnK90qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YceOgo9Y/si3sCiWY07eAh+lAVBrVbHCetibpzdVW8=;
 b=I8xKvs2jrCx7vQJmSZCI75q/BaKigpd+3Ll0tCVilxvFzue8DmB2rJAuqwKN0/SVj2+W7VaDk29D7BHVQCrCSn90kLtITJYNLf+rH3x9jWUnhYLnNbz9RF1LfoIa5UCAhh/3XGbx4zXl75KPHlSlsQJpTtMFNg2c0ZrllzL7wQ8=
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by SA1PR19MB997371.namprd19.prod.outlook.com (2603:10b6:806:4c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:21 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::d6) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 17:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:20 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 1ED7915C;
	Mon, 23 Mar 2026 17:45:17 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:09 +0100
Subject: [PATCH 14/19] Move more generic mount code to mount_util.{c,h}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-14-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=3394;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=fyrK2IHtAsiP9RrUBBuxi0yikOX427U1fVoTLEAic2A=;
 b=f6yuK+KYJRw7el6utUlE9h8phsC74d3TLZus1L58Ss5rtKCvFUsbkU3u+Uo9hquRpTzvAqm1w
 y0JpnNi0pJpA2hLFsw+pkLZJmTqXZ8aOJ2e8dRTFAauR4ez8eg4Cw9U
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA1PR19MB997371:EE_
X-MS-Office365-Filtering-Correlation-Id: 9394c8e0-6528-4664-f6e8-08de8903f430
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|61400799027|19092799006|82310400026|376014|36860700016|16102099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wbocEWtPQ9t5KkMgLIt8rfw8yn784xvtYf5xq5ImiZB4TjNxwfSKzFRQzgScaXtlEwso2vyVNRkzBPDSpCFZ7CLSkOFdZ75D1u+c9Alts7yRYr/BvwOJKOIJTxPMKhJhZz8VyDXQrJHWXMmx0DI9DfJQE/PliXxIN+fX2TB5f69unj8uRlyBSuSI/0K/G/wh15e6cm5x0ezLi8pK14fweX+qEa4g559pxmviMFyOptBweKwtEetn5xNtMwD2z5SYprVvkUAPfn+Pj+aMGcOfEQBvndIo0a7VJOpldj98d5LRj2p7ydY/cjLCLeJuLo7Hr+E0odw2c2JQFk91z8cfFjGo7Pp0dKygxLZVt2C/uLblfRxU4T6PE443rg4WVl+8cMAPBt9YZO3kdrOEBWH9I4Udqllm+g3vocXn3W3UYluhNfUXZPwRFd0FDd3ZrV9iRuW2MKGdqtnZYn+fj2WcdMf9hNYczQTWQ+pQA3c6YIz6NK8j1xPPDQuH45sIi/XhUZMEVHEXrtAFv1xPVL7v5cwMUYWTaFioIFoQmTu/GpukUWPGri4W5MsE1/YIihycCx7S7VbJWf56JXSZoAeUqfknYL5GekHVAucBqVdCwaGBlZ5jWNdQw9ZDknQtVxd2stxEu0w1jsVraMaq2kIEWzpiOgw2ZdwP9Iz9PtiH+KMu1s7uXywrR9OeIijpwQReO1iQvZheCjExYPd/Ev8KInnH3VL0nnGZSvGf922KkJQQWmLHLyVJCfZFv1YWz2OIdb0DYV007FjG3eY9fh6QgQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(61400799027)(19092799006)(82310400026)(376014)(36860700016)(16102099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y7G2rqJSH3gcyEEqnAQItgNazF7oq/iv48BPoCajYb45uYbZEvJ8tonBfdtDnzmEc0EFlwURXSqZYQGBHBP88KYq8qDdHHLQ3JT9akk21q3+J8CBPyexlW7+vRCq3raeXVKouzhyV78iV+g/Rw6ZssHuR80XvrlvQfAtBmfRslbRQtY1HOK01Huu/jh3Tvv8VA+jpnkT44kYD/Na5xFnP6V2VWCtNKiDhazeJXcdvW6IF5T3JhY/wsSmxJ8wi+CylJ1rxl/u/O7cA6fx135Vo4VuFUuw8If7FuIuIPJ62ImikCOGBgZF+DGm1jmnMR+DwnCdbaQIlgrxJjb+8gBlRx0OQ/qQp8k+UY8L0fekq8Ckw0Yay0SlaUR2M/ek4KCQ6DUw2o+A4wIDMdNhCaMLxenacJporsdkWgPUlcf5I/P37EiuNwpDLlS5aaYXFp0x
X-Exchange-RoutingPolicyChecked:
	ar2EtQHzHg5gYBuxJ+e8rGaaPnsflA0L1WB/eTYsd+e+wqNy2zu1MLUd7v/fXcFt9AawVQCme1Rj0vsWMsp9beETGoiwcbsj3HJBqGo66Eca70VYgmsxHCItknag+OjG3oEmDHICFrvfd/YhZBdJ2KVjZxs3AYmupn4fCtzyN9zDflemaDZeHwmpV5eoY9vy3nW1g6CjvwGBwK3ncOtT41m1jNVdRZqQy9aGlFPBycPsOln0l0S0hTgy2YQLyRbPvlfh7Zw7i0KFEh3wRuWj5Wy5NFakUszUvTlBrtH/d3mjCETkBFG+odoknyVTuaJZGIuQ34eufYfqihD/pkVM3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aI6dCgGZ02UuE/zRuapCcC3jq6cG/2otPMXf9tnA1lovg+2AhGlcwxxEAWpW3TZ1ONuGe3nu5lymzCi4Np5xxgQmS3rXRbYale81wUgc4+FiVgdfV+FMbeOkyU63KVGGnAVRogPRWJhmQ2JvDcsjxKWPUsAQIHhcsza6FbFY8hxGfSvMpkXrcBH6AFFrZOOn7epoJTPsSesTuxjatW5KVfunSbC2YvP7iOP9hpEsVM6Wsl4YMwiI8ZUBGEqP/B1arYIBeiH42y0SbOZVyhlmKkzcLdFq74MLI8nixTThEJPyowIaVw93Fk3L9Ut1GUzRddGJyWoTMdbNqC8KIaCruTDbNU3xs+RFaxvvB6xurQRsRifeXWb3ELrjlR2GIRXaazPtNh4XS1RlNrBDZLPriBe55JQey6L8qe48n0MwQZpsmK33gQHiL5ZrvLCTuoBdtOlpLS1kVMucU644RWvgB9XAOOMdpv73MmDBVaQUfhex2jRt/hRbAjiGv6Zx98E3G1yEYOc5RWB+hkGRgdj39ZzWbG2nVFHGaM6TtMvETi4XAh6qFc3omavLp30FU7oyRS7S6hMQKZRhGctjtBwJbYP1H4SPcmwQxofxnOj+NHs/a8SkXXPDBdrdX4jyGSGBNFihXtLpdaQ0NjxIlJI5iw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:20.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394c8e0-6528-4664-f6e8-08de8903f430
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB997371
X-BESS-ID: 1774287924-105858-7677-5147-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.201.121
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGxkZAVgZQ0Dgl2cgoLdHC3N
	LAwMzUyDg5Kc04zSw5NcnAKM3c0ihFqTYWANCWo6xBAAAA
X-BESS-Outbound-Spam-Score: 3.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan21-242.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	2.50 BSF_SC0_MV0249         META: Custom rule MV0249 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.60 MARKETING_SUBJECT      META: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=3.60 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MV0249, BSF_RULE7568M, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This is to allow fusermount to use the code from mount_fsmount.c.
I.e. avoid code dup and add just re-use the new linux api mount
functions from that file for fusermount.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount.c          |  7 -------
 lib/mount_common_i.h |  2 --
 lib/mount_i_linux.h  |  3 ++-
 lib/mount_util.c     | 10 ++++++++++
 lib/mount_util.h     |  5 +++++
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index 12df49d9109cf918cc41aa75c5fdf84231d4d5ff..263b05051c236458b830c40181bce7f494803800 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -720,13 +720,6 @@ out:
 	return res;
 }
 
-const char *fuse_mnt_get_devname(void)
-{
-	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
-
-	return devname ? devname : "/dev/fuse";
-}
-
 char *fuse_mnt_build_source(const struct mount_opts *mo)
 {
 	const char *devname = fuse_mnt_get_devname();
diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
index d27d2aa624ae3806c61a0fe382c2d024080c9bb3..b015e8f98d46980891216e93358aae9f7836d156 100644
--- a/lib/mount_common_i.h
+++ b/lib/mount_common_i.h
@@ -24,8 +24,6 @@ struct mount_opts;
 struct mount_opts *parse_mount_opts(struct fuse_args *args);
 void destroy_mount_opts(struct mount_opts *mo);
 unsigned int get_max_read(struct mount_opts *o);
-char *fuse_mnt_build_source(const struct mount_opts *mo);
-char *fuse_mnt_build_type(const struct mount_opts *mo);
 
 
 #endif /* FUSE_MOUNT_COMMON_I_H_ */
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index 52eab9e650c055142feec329264f82c2b08be0d5..867105019fa57576682091d1a650302f31e450b3 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -74,6 +74,7 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
 
 int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
 			 const char *mnt_opts);
-
+char *fuse_mnt_build_source(const struct mount_opts *mo);
+char *fuse_mnt_build_type(const struct mount_opts *mo);
 
 #endif /* FUSE_MOUNT_I_H_ */
diff --git a/lib/mount_util.c b/lib/mount_util.c
index a42a02a0b92f98778abb2c491cdc7a01260f56ee..6a7908cb74b429a1ffd811678cfd39c35093b265 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -10,6 +10,9 @@
 
 #include "fuse_config.h"
 #include "mount_util.h"
+#ifdef __linux__
+#include "mount_i_linux.h"
+#endif
 
 #include <stdio.h>
 #include <unistd.h>
@@ -399,3 +402,10 @@ int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
 	(void)mnt_opts;
 	return 0;
 }
+
+const char *fuse_mnt_get_devname(void)
+{
+	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
+
+	return devname ? devname : "/dev/fuse";
+}
diff --git a/lib/mount_util.h b/lib/mount_util.h
index 4688d00091f001b3ccd36b1ef3b7e799031ed773..00397943a46a58e640d15b0c0531e5bc6e76006b 100644
--- a/lib/mount_util.h
+++ b/lib/mount_util.h
@@ -6,6 +6,9 @@
   See the file LGPL2.txt.
 */
 
+#ifndef FUSE_MOUNT_UTIL_H_
+#define FUSE_MOUNT_UTIL_H_
+
 #include <sys/types.h>
 #include "mount_common_i.h" // IWYU pragma: keep
 
@@ -22,3 +25,5 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint);
 const char *fuse_mnt_get_devname(void);
 int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
 			       const char *type, const char *mnt_opts);
+
+#endif /* FUSE_MOUNT_UTIL_H_ */

-- 
2.43.0

