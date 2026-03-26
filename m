Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853E3A75BA
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560930; cv=fail; b=ovJ+pslQ/29ppsYTKvwq67YZQmR/muCJH4I2zsKJrHwmr9a+14qUrjo4Tzae/xOEgRo8eVsZvxgqM7DIj2TCMJ6cc/6I2TdJNCRvUzVs7llY+5KBNAVx4z/Z76DrlKoIe6zZ9PzwHsdH6rpDfxezxkBoDRWvDomaf5Qrh642sAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560930; c=relaxed/simple;
	bh=l9v1M2x8Hjs+LKXGjxXH6zDv/9gqgo22Rxs27MgXIE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTrIoREh9UCUW1ziAsNU0tVOj6WGhaoSJz7WfpJxGYGfj7g7mXrMdp+8lU2tBRGSXWUIJSzBSXfketcW6MZDXdD6Ky1lPPl4e4ltdyhXVSM+yJNgIFcqpwwMQZIrzam3V1WkhO/KqmUXVUeGl+0OQ6RrZxAxG6+HvSdkoTVZSU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=vKabGNWW; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="vKabGNWW"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020125.outbound.protection.outlook.com [40.93.198.125]) by mx-outbound-ea9-161.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9b+lp18G6NpolLuHMBG4Pqn9rEVdmsWTOdyZBCGob/JFCSIsjOdNfdSC6V9G/1yaf5yHzapXpeDl6Ul8am/6v25wVloc/Iwt1AXgXTgMnrko9IGro5u0WT2PCPnCqE3/eftYrf7R/IGZTYV2UoAhpNPnDsOc2kX5UvlAKb6IPyn84d1fLd7gIaMAQaw4/XbuBX8kJEwwfq7JeRvNFbHP98x65NBmbYDntQk2DXMCXRb0jvMQL4qVdoradJgPtV0xOsHt3+etDI6gwfeBzfH4SGGSSLAo/UKUe4/z6s61tZnMtZ3RGy6pk2p95PqyXrFsu4JyjYiQuI0cALEG0Zx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyP4BRJcJB6x/LqWLLmGi28fYmlthZ1nymORZTNjwjM=;
 b=b7l58QlN4YYfBmJlllzxH9o95lXrzMpRfw4k5/7lFrBzz98dDpWdCUKMB/+TYwkHhJNckqJOtlagkO/colhsAn7Fx237F6K6friMfRv9UUmNAF/ucBjP7VRkL/D+Y1jr+rhAjZy6rKuznoVnNfuV7Tn//8bim1Gz35y0oJuDWfMXpnObYahj/9kz1NuxqATPG3mndcD2ufFvlKQwReHBs69OMHePp7qG+w18U98rz8Cdwxq8vNdnwWw4K7v0+4l/3KH+WiA/C2KLmKOKtG/5Fw8LYFl62q1wDIdM9/EjFYqidC+Ao13ndsCudAvU91GADCqYaeDwgKQemj7Xp76BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyP4BRJcJB6x/LqWLLmGi28fYmlthZ1nymORZTNjwjM=;
 b=vKabGNWWN3xUW8cvyfYU23lB1QjjiuUhkh35GYyJymsfD2eeoxSzNW+3HTu1AVL6fE+Ghj3lJeDzwUNcy+ZCofjX82y5pKJf+bYxl8S4g4oQaT2zey0E3+e44JqQwRoGs/nBJd2n7U+jk56chveBf/ClO0diUV1U8I8cX3y5Jjw=
Received: from PH7P220CA0059.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::23)
 by DM3PR19MB8307.namprd19.prod.outlook.com (2603:10b6:8:1ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:08 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::ac) by PH7P220CA0059.outlook.office365.com
 (2603:10b6:510:32b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:08 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 68B7211F4;
	Thu, 26 Mar 2026 21:35:07 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:49 +0100
Subject: [PATCH v2 16/25] Move more generic mount code to mount_util.{c,h}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-16-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=3498;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=yRV0YbL0tBifkK51pPD7WVS0aV+qj3v/Gt4hIiUWyV8=;
 b=aZCVYTRb/kVKXh0y7HUiEfxEq6a5pSr6nIH3xU+L1KjCw4odmLIQ3KNyK/Ri4M/H/Cxuv+Dke
 3aAYJuDFz8ICnmB0WP8P/ZCt4bgp9s1oCWcgWqzOIzth4PEHwn5zy81
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM3PR19MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 03dc47e4-a7c8-4f43-e012-08de8b7f8d59
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700016|376014|82310400026|48200799018|19092799006|16102099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hva31PNEko0Pw4XD50P036jWdoqwqcMDYRv1YiWFzJ11W1201yUnq3QiZ0HW+OFAIZkksc4bJYn9T8vwB8DSeDZ8r7J5wW42WTNXkEChebnxBTj/w9S8dUM0wRbe0QwHKOk9V7CX+t7IhMPR2tiTlcfiSbjAh7SbUiikcBzqk0ybmYrBBIKrs2tonJ0GDvRPYz/YoAE0DFbS/YcYF9pGFvCBZee2Kks5DwdXtFC0EGH3iKvl9xa9qzSnw5wDo1wi8vVKyHhpSi8b1U1C7+c98dp53/jq31Akyw21Yu8HINHjQcJjyo1PEW6NHAXpfx82/GjJgHcEer4dR1n7qo53vlQqQvxcqOSk3LrPVvOr0uXQvZRbR4jFsfhNxXFEtOg7rq0zKEtcAXm3IeC3fmh/5qHInji2SAn/FCXplnzauoEL82ray8mDsLwhI9PKBlKK3G12XyEcdjUmimwbBPfud+EGRQ9QJ80Oei6ZA0wGPuAynl/3fIojModz6iCo1J+ZNp7/Cyn2yp2Mo7xUeeAHIj5K3QwLJowdLvycD2yBdSTR0PFOiqnGqdMTexLrG6cJYrO3DKJ4FNOjh9k6sFB9NI6gBfQ9074LhsV4si0WU+SXUkfdth2Nuvn8fGpq3URVUbZ7pbuQ5IuBc0Jmmk4aMD4LycLm9Tf4n8xFsrvgcnamYtfvJoIgpIqank9Tc7w7vmwsCU4XOWKSnlvS7l4GegGEo/uOUIqS3sammNc3oJxBLI3Zknq5xGuX9l7FFfwJzGMSB+bec4279QXJYl7O/g==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700016)(376014)(82310400026)(48200799018)(19092799006)(16102099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KHnMEGBEsoxTZdTUEBeLn49TiTG8iL1i1u9qpe3V+Hq+oh9yrnLaK7MAcb4aStK8YOqXdwtcYlJ1x8txNie0/ebnEQdYqqV/sR1LWTQ125wgxYti86WRSSeHLZ2hmWjXF2s5LRydKhZ/jI3lqPowysZEKNEiQ4Z0zgv4AZaeYs1LKFJS0vYogSn/sJSFa1wBV30MQsLmY1iaDoaJH3THxC7Uz+p15EAEjiU4XKdml0VmdVHDHkX47nP1QpnukbQJ6FztjNWPVwEhUYUbrxrUekjYA7ipxq24KFLj4pLPwmIp6lqMvvVGcxLTRj+oeP2abJPSFD8b25Kb2uXPRN+jmnKGY5YfhPK/iwd57HxnzZgO+BgN3MZ6lQiMlPfyq83XkTi0KT8M1+E/XPYhY89I/g+1Tivzxj2sUFJJVJZSbd4L8YGHlvZU1Q5GoxRor9LW
X-Exchange-RoutingPolicyChecked:
	Cana0SN4o02RUXX+hGGLI2hhYkjckVgaOkbgcQl8wpCFMwI5YEE6n8eEBnCudFVrelGCTvLP/iLz0NzGKvOMqc8inmfzyDdtMRLJRUbMfSx0a2RPGrlbRlJPn//lrmyyG2sVan3jI5myej/zrvEsk4GRqEd8T1o4eXUsAV2dgkHhaSVFtUMbdQM1tvgxSlQHjISMcnZfJP7+yJLVk0Ir6pjINMCtO3OljEa/x28/5+qJHZJtdz2lPWbX7ZZhjuk+hSwM67C6gt68xYmyZ466YZpGx8jzECpVjsMsY5UjPXbnG+96MkLS6hbVXXhMNK9w1NO+mB9Cm17ZBq0UZcJmMw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K45+KA/WMyLtYP7ixkwjXxhOqVOemD+S7KzXIOGvBRoDdQiz/UZ75AJ9/WzWRKrt0vDV+JdysjMzHmufY30m8+shTV0IWcTevH0P1cG1Rv6jDQ+XQWCTMbH2MRam0sWbesHjXrM8fjCJBUuCYxl8wg1CqxEPO7sPaDeMlYGu++dA6Rls2Ks+vQBGLzgTdz36eHd2JlR2HD19STtKWNcefaxiEUNyklCmUvS8i6yrKZwMBnlQv/oTusLwMBqSQWclmY6E9tfTzwmm64YCT0AchZlN7ALb9rfOObaYl72+edeZiCUHse8VwZyYQnhJWbNKNb3FwW0A+UgnHhnYgyxGgKzdE+3ZuGkrd1F+1DDQJLGOUHnR4YLmppSJP4XdDGOedou8hhNjfpOz84D0Vm1G/uFQThOuZg+VcNj85Pr4kPwg/ueZ4JqJCAQU/RUHsWaPI6Aa2ZV0zwHYjY+aJP1AYl6ucbB86YEnh2RhJTXYSDCyoXpD2Z6FFAzbC7xtEoABKCllVBGvKd34Dlc9nEhlcYzlWnAbbYxjK9TdN9rtCo/UX7V87VsCopJ9LsKn/NPDk0bEQ6fd5l6zrlKY3QnVMp6merBrLzlJCWuSOho49AXO2JdtTDjSK3ajl8BIaYjAniKGPLD+bgP87R05NCxFkA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:08.1266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dc47e4-a7c8-4f43-e012-08de8b7f8d59
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8307
X-BESS-ID: 1774560915-102465-13023-4323-1
X-BESS-VER: 2019.3_20260325.1648
X-BESS-Apparent-Source-IP: 40.93.198.125
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYmxmZAVgZQMNnELNnc2NQoyS
	TFyMzCMCnJKNU42cDIMtEi1SjJyDhNqTYWAO9y845BAAAA
X-BESS-Outbound-Spam-Score: 4.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan15-154.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	2.50 BSF_SC0_MV0249         META: Custom rule MV0249 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.60 MARKETING_SUBJECT      META: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=4.10 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MV0249, BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This is to allow fusermount to use the code from mount_fsmount.c.
I.e. avoid code dup and add just re-use the new linux api mount
functions from that file for fusermount.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount.c          |  7 -------
 lib/mount_common_i.h |  2 --
 lib/mount_i_linux.h  |  4 ++--
 lib/mount_util.c     | 10 ++++++++++
 lib/mount_util.h     |  5 +++++
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index f19817e2675713e988bb91fc658c52b36468462b..408e9d36896048fc167e264c95b6f6e31d86679f 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -713,13 +713,6 @@ out:
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
index 34f0f9893918a14c83a57a3212f80cfc96ed2e6d..fc9ab443cc0cf6cf8438dd2ca486f6e37c8704e6 100644
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
index 34c7386715155e8640cac68c218a1e1062990ce6..597b380076fccc1d38fd4d0b9108fc92a1adfa62 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -41,6 +41,6 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
 			 const char *mnt_opts);
 
-int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
-			 const char *mnt_opts);
+char *fuse_mnt_build_source(const struct mount_opts *mo);
+char *fuse_mnt_build_type(const struct mount_opts *mo);
 #endif /* FUSE_MOUNT_I_LINUX_H_ */
diff --git a/lib/mount_util.c b/lib/mount_util.c
index 9ff711023fcb41fe24f1de21aaf811cb1c12d25e..b6b75e60874ae9b2ec0c96f2a62b4ec1943a2a00 100644
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
@@ -451,3 +454,10 @@ int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
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
index e62052b626875abd6118b845de162d6c5c41857a..b83db556d5fdb4bd8dd5e1750c8d11faf7373d82 100644
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
 
@@ -31,3 +34,5 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint);
 const char *fuse_mnt_get_devname(void);
 int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
 			       const char *type, const char *mnt_opts);
+
+#endif /* FUSE_MOUNT_UTIL_H_ */

-- 
2.43.0

