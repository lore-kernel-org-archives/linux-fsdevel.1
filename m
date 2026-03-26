Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CB3A7835
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560925; cv=fail; b=sLMU/sqas6RhupeekNzRywwxg847LRtadfZXnYbdZ819JvsaPfmGodTehv9YKvu5EcmpIq4mIkDN1qz9q9c/RCB2/cdmKB5CBgQrTt+hMdbeZyjZ1VolwpFD3PVwHtSuLHlGRtqCZDDzxNMnTaww1SMi90oof4QMHGJvFHb3gQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560925; c=relaxed/simple;
	bh=IyKpR1bJox4+dYysx4GavpqIYWop075ZnOJjCBK23aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjiPI91Gwy2eRzpc0PwWbWLf2OdM0T2NcX3a+lGW6hSvOmOctybKMlUhNXjIpb/E/vkNx9Vb9b8SmbrNSaFDtyZB90EqQo4XfUC37+5XwCE1yNlOIBf4hYZwJjjQGkUMvqqAGeQQ4OxnErgfYH6Cp2wOodS88rwOACoLhmgZdHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=fJaJPaQQ; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="fJaJPaQQ"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021129.outbound.protection.outlook.com [52.101.57.129]) by mx-outbound45-1.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liVKuAvdcx3SOcccQiZ6GalFthZI2wAWdmpUyR6NPMEXSt9VPfFiLlp/r1eYRLvhiLK2gXN0XJtub5/5XDgtNBuNyiZovcvoOabRRrnivy+ZOP/jn+51iMKL7yLnyw4c8zK9aFY2w8x24PhzAA97d4VHJKclE5T3pQBhTxAI+UhqcUiejlYVwt7ucGxofIdu2I6f+u2t/gkx5yDtN4Mk4Tyr+k5x9G95CPz5wQ5D8CN+wRvyaKKrmG4duzTepMCdnizce5E1MU8qlsC1hlHIGsud3fBu/2WLN3JOZNwzPpdTotAAuMaoykxbQjG13HhhPBVqopO0CSj39I71ZJ/HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT53HTApMbiNziDfkv1F9Pb4sIBiKOiAj0Qn8r0WacU=;
 b=XuhORSIEDgeOdFxU8WoEFcMz0KcPNGl3NjrqrXDUWXUWmZcYxf9eDIc4z/7zD8/oBzCOfMbtpR0W0he79AQwNMymNDaCNnoQEPJeeunv8v6X5M3iPyWjjG6SV2zBYRG4pG/1YL18fLdIlddCs6WLnDXLswZvcpXz7cl0nmomZaXBOjkNRNSOdMPKoP6+KNC/qY/zmSJM3i5zSvaQMBsFIAPCNsWmvwHsTTcjdAOf7WX2PU6AdHt6vdKjrlklaRKtJNcWVm1Q+Z0LiNghVkbJNQ5JK3pjfM7eGL0Nf/jwNIb6Yn+Yx+3Zw4YzNwCO8ciTbOOb/n+fPzmIR/4ioPICKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT53HTApMbiNziDfkv1F9Pb4sIBiKOiAj0Qn8r0WacU=;
 b=fJaJPaQQY2AbGlZFNS03XRYxjPv9i1AiXNSPKPyEKdM1hH0+7C4W518jUJ1rHgKndjpRJvtFkOACU8chEUKfIen1UkEoykAO/HnsTbTTQnArEoiZhXh8OlZ7UE6G4MvAbcl1SMgOVLAZVBGrRgsXrkT5WuukBDfTF9uV4tPU32c=
Received: from PH8PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:2cf::7)
 by LV2PR19MB5984.namprd19.prod.outlook.com (2603:10b6:408:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Thu, 26 Mar
 2026 21:35:08 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::76) by PH8PR07CA0039.outlook.office365.com
 (2603:10b6:510:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 21:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id A69BD55;
	Thu, 26 Mar 2026 21:35:02 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:44 +0100
Subject: [PATCH v2 11/25] Move 'struct mount_flags' to util.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-11-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=8056;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=IyKpR1bJox4+dYysx4GavpqIYWop075ZnOJjCBK23aw=;
 b=DR4KhxTapWW9glCIHEVoITSdR4L8zs8vGyQ80efC/+/TaO8YoKHXnsXkhA9G/eS/hIt3IiaFK
 4Z/sGEdrMU7ALjxUWP0S8jujwCHozkWRDGhKa41Ld0B1Dpr41hiOmKH
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV2PR19MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: b624f7b3-6fce-4884-db3d-08de8b7f8cec
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|48200799018|36860700016|19092799006|22082099003|16102099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dz/QT2UC/Q8GZnu5AzkSCGb3Vm96s4zWf1jzE9qxZtecGQmUHgiwYEd/h2ie1tl2nMHUH3V5nUfOBbINATtMjY44Ni1tdXUIQSv4rdg6nUMjhHikHHEYw/VLJNNYtTGRQtq+fKolx2IdS7+HsFaJdDzDmViz5UypUAUswk9mubGe/2Mt7mCBwcUja52l4NBTyNYr9HSBzxZsHUm9OA3Nx05rKpMeL8kqnHobaGtlFw4uuqHJtdrZoBtPkXIhtQuqj3Rf30YhunJIuKGkxfijHgfKaEaU7Xb2pgDoVOTHq7JN7GRCFhd/uV+SC6IzVY3Owe2EMFKZaHuP4yZW/bAYdFdwkHzuvxXgkJiw8Rf1LdJpb25DYJoLN4xnYPEssEalP4bL9sag9hzajeqYpDqtbGWk/dTjdle/ZAV/4KMDwgXbFwMq2bo1agBlxw8jPHaTYV2MpVvF0WFdHrTs8gcNaRbJZl0pjDaGq35eXEUUiSfYN0mLlix+g553DgP+fdowaC9iDXMaQHCkGlv5ExFvw0Oko1gI3WKwIKzvgzL7cw9ISyIDBMnKnDAcCU6fX4B67D5+oheHgeg6bX0i+h/BGZEd9B2qad1Nen+x9LAAUkXHPkekrGuYx1U2b57dh0mmTYT7KmweynhRGOXBy0P8+e1qHA45UKfYV2vkwAQ5q4vim/zETnxT7ly8EIGL7ZVfqgG2fOSo4WXVZdsYpVrYNOhdiulGAZOc2zj6ueqTBHwLyywyYonSfDgaZIVhNSwft0Vs1XQbBQ8bA2GMj+v2Zw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(48200799018)(36860700016)(19092799006)(22082099003)(16102099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gqKqVWOmGfFyG5jwXoWchB4ajWsIeO8MwcJ430D2Ds8U8ygej1u0x9+y4lxNLLBSgUwRir3yTQg0xY4yD0Coz+TsM6tfPiSJcXBT2lCWkzdYmNeWHndoPBOY3uWwybTE3AD5dxu260+Dss5XWyojZgAOh4ygaw5UpLumojYMkPXVJ14lie6OA0zQs+rdiZRJijI17QC0HkcevLYbIrUkgxiFq7RgyACekNtAeSR2diO5EdGnB4Bw1LHQ/cTarT/mz7/8j4uxp8t2i+OvEouG03X/SX9xTzobdcFK+5NV3yrA6AZl+1nw7Gn0WQNtwgSB1YZjL8qQKYvPMTr6hVP9j4MapbdUboecY5QjHachAHHyRvpN2uB+DrdixR3LftYJUnhVrAhqnBo79ly45UzyL6OOW9johD87nqUrfOoLN87frIupPzvfH5NxBOvqUTad
X-Exchange-RoutingPolicyChecked:
	WaZ+PAKbYlykoxhfunO2Rur8W0EVawkMYkKvSgV2lyJhh7DMpLKLCL+yXoNyS3P9qPZZCBfjBddZgXlU9s9GxBeY6Lb/nwehDeHSNY0DTmzD9+4J84CxDpB4EQ0HljLk048VHNdIwprNVFc+sf6oOMlm1WTImQy0h6EX9ROZ7nZ8JnFEmyFdv5h1fQJMxHmjReQqXeOZfAewlo9aRB5HmK3XFcOxwaFOh5ywFdDDZcswuo+2PJ/xaVxQkOuA/9CO2THjK6XJejAw6JEak2MuZcGJ0IJgbkrQ6mL4fbpZJAQqv4TZcfV2zcX3PRWX/h2UiQL6RS7NwjVyDEbZK0FU8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BYUR//tNBQ/9zR7McOBii4KHoVxK8b3lkUNuFUry7VxF69pWZ+OYbrscG7YupAhqhAYYp7wsmdgfLRWJQvi4AdlQdWo2OirntA92WuDulpkpPVZNk20PKU1qpzgDvKbKtCpLmOpU2Pj/IfvE7A3GTwkq/UKV/jW+DCpKiKBkYP0vFwqXK7lfUyVpdwo5rZO9zd1jDVPcPq4RjifFImIybVBvFkI3EK2Of+FxmsvJ62XDQbl0cnSTGzPQqAHnJ9quQ1o/U/ty/LJELMI0M0dLH5vaQDtXrEtCO09qAYNFmDLlkvJ7HhNB4MSs5LU7ndWr9u8ApTt8P9VXkh2NN7P1yrrNzFaqyXLjeyoc8YkFIFwYaSKMPja1yoa9hnKI/6upJnvTcNfSJfaHqB1pRecIiiaS8FszURrxBliyHpmkmsA5nkt3FSDzPRqi0ey9ZWeu/e0IJOpNWB09wwC5vWJ8H41H88EAnOj+qqYLwFTERFsaUa7W05nZcrHp8ZP4LVE4GbsVxGDhVg4tU5yc+/Rl/L2ZdYSbT2K93r3gqu7lYVJqAe4sd/KK8S+sY8HlUahslmQ/+clqZmIHG+FysXLol/iMB5GxXJmPZFpFbPQ1bcG/G+c1t4ABEVPoc9f2fAc35oZywJtCypOJhYoASxaOkw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:07.4108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b624f7b3-6fce-4884-db3d-08de8b7f8cec
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5984
X-BESS-ID: 1774560916-111521-4067-1357-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.57.129
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubmlqZAVgZQMDXZzNg8ySjZ0s
	AwKTUx2cIkxdjQItko1dzYKMUyycJcqTYWAHNfmVtBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan20-234.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

We actually need these in fusermount.c and for the
new mount API, which goes into its own file.

Also extend the struct with the extra safe field
used by fusermount.c

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 include/fuse_mount_compat.h |  5 +++++
 lib/mount.c                 | 39 --------------------------------
 lib/mount_bsd.c             |  1 +
 lib/mount_i_linux.h         |  4 ++--
 lib/mount_util.c            | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/mount_util.h            |  9 ++++++++
 util/fusermount.c           | 34 ----------------------------
 7 files changed, 70 insertions(+), 76 deletions(-)

diff --git a/include/fuse_mount_compat.h b/include/fuse_mount_compat.h
index be8d576cf959fba7acb25440fafd43f7e973964e..1b0eb00c3eb79ad2d58a9e86ac2836d3f7d3b2fb 100644
--- a/include/fuse_mount_compat.h
+++ b/include/fuse_mount_compat.h
@@ -11,6 +11,9 @@
 #ifndef FUSE_MOUNT_COMPAT_H_
 #define FUSE_MOUNT_COMPAT_H_
 
+#if !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__DragonFly__) && \
+	!defined(__FreeBSD_kernel__)
+
 #include <sys/mount.h>
 
 /* Some libc don't define MS_*, so define them manually
@@ -46,4 +49,6 @@
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
 #endif
 
+#endif /* BSD */
+
 #endif /* FUSE_MOUNT_COMPAT_H_ */
diff --git a/lib/mount.c b/lib/mount.c
index 899cd2d0a13a9332a564b10d1c22836fb2cd1710..43920a06ac03747595bde95441252e9cac77ce88 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -33,18 +33,6 @@
 
 #include "fuse_mount_compat.h"
 
-#ifdef __NetBSD__
-#include <perfuse.h>
-
-#define MS_RDONLY	MNT_RDONLY
-#define MS_NOSUID	MNT_NOSUID
-#define MS_NODEV	MNT_NODEV
-#define MS_NOEXEC	MNT_NOEXEC
-#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
-#define MS_NOATIME	MNT_NOATIME
-#define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
-#endif
-
 #define FUSERMOUNT_PROG		"fusermount3"
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
@@ -147,33 +135,6 @@ void fuse_mount_version(void)
 			 FUSERMOUNT_PROG);
 }
 
-struct mount_flags {
-	const char *opt;
-	unsigned long flag;
-	int on;
-};
-
-static const struct mount_flags mount_flags[] = {
-	{"rw",	    MS_RDONLY,	    0},
-	{"ro",	    MS_RDONLY,	    1},
-	{"suid",    MS_NOSUID,	    0},
-	{"nosuid",  MS_NOSUID,	    1},
-	{"dev",	    MS_NODEV,	    0},
-	{"nodev",   MS_NODEV,	    1},
-	{"exec",    MS_NOEXEC,	    0},
-	{"noexec",  MS_NOEXEC,	    1},
-	{"async",   MS_SYNCHRONOUS, 0},
-	{"sync",    MS_SYNCHRONOUS, 1},
-	{"noatime", MS_NOATIME,	    1},
-	{"nodiratime",	    MS_NODIRATIME,	1},
-	{"norelatime",	    MS_RELATIME,	0},
-	{"nostrictatime",   MS_STRICTATIME,	0},
-	{"symfollow",	    MS_NOSYMFOLLOW,	0},
-	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
-	{"dirsync",	    MS_DIRSYNC,	    1},
-	{NULL,	    0,		    0}
-};
-
 unsigned int get_max_read(struct mount_opts *o)
 {
 	return o->max_read;
diff --git a/lib/mount_bsd.c b/lib/mount_bsd.c
index c5b831160f826c0e4620626a72c4b93427d18bab..09631932eff443d21743dd55dcd5345dd581227f 100644
--- a/lib/mount_bsd.c
+++ b/lib/mount_bsd.c
@@ -16,6 +16,7 @@
 #include "util.h"
 
 #include <sys/param.h>
+#include <sys/mount.h>
 #include "fuse_mount_compat.h"
 
 #include <sys/wait.h>
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index 254b75151f35578ce22197776e6fa4aceb04150e..1bfc78b32dc4fd434870e4fff1a37e0c340d207e 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -10,7 +10,8 @@
 #ifndef FUSE_MOUNT_I_LINUX_H_
 #define FUSE_MOUNT_I_LINUX_H_
 
-/* Forward declaration for fuse_args */
+#include <sys/mount.h>
+
 struct fuse_args;
 
 /* Mount options structure */
@@ -28,5 +29,4 @@ struct mount_opts {
 	unsigned int max_read;
 };
 
-
 #endif /* FUSE_MOUNT_I_LINUX_H_ */
diff --git a/lib/mount_util.c b/lib/mount_util.c
index a42a02a0b92f98778abb2c491cdc7a01260f56ee..9ff711023fcb41fe24f1de21aaf811cb1c12d25e 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -34,9 +34,61 @@
 #include <sys/param.h>
 
 #if defined(__NetBSD__) || defined(__FreeBSD__) || defined(__DragonFly__) || defined(__FreeBSD_kernel__)
-#define umount2(mnt, flags) unmount(mnt, ((flags) == 2) ? MNT_FORCE : 0)
+#include <sys/mount.h>
+#ifdef __NetBSD__
+#include <perfuse.h>
 #endif
 
+#define umount2(mnt, flags) unmount(mnt, ((flags) == 2) ? MNT_FORCE : 0)
+
+#define MS_RDONLY	MNT_RDONLY
+#define MS_NOSUID	MNT_NOSUID
+#ifdef MNT_NODEV
+#define MS_NODEV	MNT_NODEV
+#else
+#define MS_NODEV	0
+#endif
+#define MS_NOEXEC	MNT_NOEXEC
+#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
+#define MS_NOATIME	MNT_NOATIME
+#define MS_NOSYMFOLLOW	0
+#define MS_DIRSYNC	0
+
+/* BSD doesn't have these, define as 0 */
+#ifndef MS_NODIRATIME
+#define MS_NODIRATIME 0
+#endif
+#ifndef MS_RELATIME
+#define MS_RELATIME 0
+#endif
+#ifndef MS_STRICTATIME
+#define MS_STRICTATIME 0
+#endif
+
+#endif /* BSD */
+
+/* XXX This table is duplicated in util/fusermount.c */
+const struct mount_flags mount_flags[] = {
+	{"rw",	    MS_RDONLY,	    0, 1},
+	{"ro",	    MS_RDONLY,	    1, 1},
+	{"suid",    MS_NOSUID,	    0, 0},
+	{"nosuid",  MS_NOSUID,	    1, 1},
+	{"dev",	    MS_NODEV,	    0, 1},
+	{"nodev",   MS_NODEV,	    1, 1},
+	{"exec",    MS_NOEXEC,	    0, 1},
+	{"noexec",  MS_NOEXEC,	    1, 1},
+	{"async",   MS_SYNCHRONOUS, 0, 1},
+	{"sync",    MS_SYNCHRONOUS, 1, 1},
+	{"noatime", MS_NOATIME,	    1, 1},
+	{"nodiratime",	    MS_NODIRATIME,	1, 1},
+	{"norelatime",	    MS_RELATIME,	0, 1},
+	{"nostrictatime",   MS_STRICTATIME,	0, 1},
+	{"symfollow",	    MS_NOSYMFOLLOW,	0, 1},
+	{"nosymfollow",	    MS_NOSYMFOLLOW,	1, 1},
+	{"dirsync",	    MS_DIRSYNC,		1, 1},
+	{NULL,	    0,		    0, 0}
+};
+
 #ifdef IGNORE_MTAB
 #define mtab_needs_update(mnt) 0
 #else
diff --git a/lib/mount_util.h b/lib/mount_util.h
index 4688d00091f001b3ccd36b1ef3b7e799031ed773..e62052b626875abd6118b845de162d6c5c41857a 100644
--- a/lib/mount_util.h
+++ b/lib/mount_util.h
@@ -9,6 +9,15 @@
 #include <sys/types.h>
 #include "mount_common_i.h" // IWYU pragma: keep
 
+/* Mount flags mapping structure */
+struct mount_flags {
+	const char *opt;
+	unsigned long flag;
+	int on;
+	int safe; /* used by fusermount */
+};
+extern const struct mount_flags mount_flags[];
+
 int fuse_mnt_add_mount(const char *progname, const char *fsname,
 		       const char *mnt, const char *type, const char *opts);
 int fuse_mnt_remove_mount(const char *progname, const char *mnt);
diff --git a/util/fusermount.c b/util/fusermount.c
index f17b44f51142c682b339d0ce2287f7c00d644454..f66c4e8e0e809351384ec10cf50ba4d3d3a831b0 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -759,40 +759,6 @@ static int begins_with(const char *s, const char *beg)
 		return 0;
 }
 
-struct mount_flags {
-	const char *opt;
-	unsigned long flag;
-	int on;
-	int safe;
-};
-
-static struct mount_flags mount_flags[] = {
-	{"rw",	    MS_RDONLY,	    0, 1},
-	{"ro",	    MS_RDONLY,	    1, 1},
-	{"suid",    MS_NOSUID,	    0, 0},
-	{"nosuid",  MS_NOSUID,	    1, 1},
-	{"dev",	    MS_NODEV,	    0, 0},
-	{"nodev",   MS_NODEV,	    1, 1},
-	{"exec",    MS_NOEXEC,	    0, 1},
-	{"noexec",  MS_NOEXEC,	    1, 1},
-	{"async",   MS_SYNCHRONOUS, 0, 1},
-	{"sync",    MS_SYNCHRONOUS, 1, 1},
-	{"atime",   MS_NOATIME,	    0, 1},
-	{"noatime", MS_NOATIME,	    1, 1},
-	{"diratime",        MS_NODIRATIME,  0, 1},
-	{"nodiratime",      MS_NODIRATIME,  1, 1},
-	{"lazytime",        MS_LAZYTIME,    1, 1},
-	{"nolazytime",      MS_LAZYTIME,    0, 1},
-	{"relatime",        MS_RELATIME,    1, 1},
-	{"norelatime",      MS_RELATIME,    0, 1},
-	{"strictatime",     MS_STRICTATIME, 1, 1},
-	{"nostrictatime",   MS_STRICTATIME, 0, 1},
-	{"dirsync", MS_DIRSYNC,	    1, 1},
-	{"symfollow",       MS_NOSYMFOLLOW, 0, 1},
-	{"nosymfollow",     MS_NOSYMFOLLOW, 1, 1},
-	{NULL,	    0,		    0, 0}
-};
-
 static int find_mount_flag(const char *s, unsigned len, int *on, int *flag)
 {
 	int i;

-- 
2.43.0

