Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3071B86C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289948; cv=fail; b=tvTTYkUURSNVsYCTOCiCMSGywWvN8ECIU4t7VfYMDoMj/BdXnQeDOhC2uAdm5+Bx4muunfUH+CIQAMFDgJBwwA5q4nY4aIPN2/Wikz/l0HaokP6KPyXd7QLq4xbLU56YZVUpg+i+rNIMd8oSmoNh2hUs1gMzMxZqu/86DpqFG0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289948; c=relaxed/simple;
	bh=6up9IitQ0ex1yoT8pPAkh+2N3IUM0nVNxbLMImuKXeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEY44ca1VKvXYTtPyCn1aVxgIu99hqZbltLEpTQ2/85vmujgmjn2HwnHEknGyK34AqPWwUR8HgQB+Pl3a6FuMuI07AHe5wYTLPeNt7+ta+ZfWhypiQKvr2zm5TEzGpTPN3tRP715SoR99HmcoZtkS75TsCrUXuS8t5tgD7chn1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=TmHB/Rtz; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="TmHB/Rtz"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023072.outbound.protection.outlook.com [40.107.201.72]) by mx-outbound15-129.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh7VecbtCNU6gsHlTBA73lrViljeZeUi4Z4rSJKSG5Jaz1fylqpwNKpHtX+Knbm30ebfmSrGhh396yopCz0PqxwViW3uqA85eg8AgmEFl+NnDFLclgZ6aq1VZR6tWnsTBGg/2zyfYePnOfYMKbxFHbJI+hhqJEoGMNOe6iZFznrBQV1GJ30WgYOKDAwsSIpQTqCW7SrB30WytFbdEkXz00TCN4pRdMtcRzVtUZzSAB0sK3qed2sISAFRcxyZOAxW39rq+GYCTsgGNxEn+q6lJbwLPVR9BW93jO19eltD3E4wLviNsgu+bPCm4X5IkGBafFta4OSWGd23YHGY8U7zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJ0tw+hPqc8tjDTP1aby/37gU2f0lhd/EqIXz+I+TYg=;
 b=X6afzA7EtJxxmpk5o2SrXWaPsQjGWMlSDwVfR6f7DcamwaLRq5t7T+n6MsuTaAVxTNJ7DKGOpfGiAieJ9cLyDULAsKOHYcbjGiCVPPAWZp1WephnSdYahMctWBPG03jhmTp77Uw5QKRL+Jlc+agU9AFL7+OOcyQBzC3iJZ19xBiEqJFiPT/Kg74EqDAXzt+7D0iL0hj5DWEszXetBPaMe7JPkdfgnfe4LybGFK/ee2adknr33rH1CMEN6q5QxMnykJTuQYldsG6NeSJDuOffd1hskXOHzi2ubvrmTACOoxy3b/caYiYDbo+1URv/sIfaByZVBPzm7G/Y+D8nKTiPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJ0tw+hPqc8tjDTP1aby/37gU2f0lhd/EqIXz+I+TYg=;
 b=TmHB/RtzY4tfZxC20xaO46Ohsl7qjte7IIPuj9zXaGtst95yvPuOSPJuYDxaCIhaIgvRGKckoEJLTWiXvKgU/lWJjhp0QKe1CL4Cvl2ZsfU69eyAl4cAiAe+8jTGxJnG3uP7rUy9x5BLwi9w9OM8/JGCe8ReLPqNuNzXVmU24qU=
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by LV8PR19MB8445.namprd19.prod.outlook.com (2603:10b6:408:1ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:16 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::43) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:15 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5FE55B7;
	Mon, 23 Mar 2026 17:45:12 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:04 +0100
Subject: [PATCH 09/19] Move mount flags to mount_i.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-9-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=4675;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=ykP/xoYLli1hQ6WwdbT0JdyQQWz23VvQaSJV1n+j9iQ=;
 b=p65khlhKtREDRHDXupXN3UZYRLHc9Pw0mIK2RsoPNLf3OxBlq0N397I2vou1sPRLR5oXqEfBf
 i3wfxGsJbzvAdDEYsTNrzKbpcrMze8rIOmFpskIoGDXsRp4MC7JK2oO
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|LV8PR19MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fdbc40-e7d3-4fe0-1662-08de8903f13c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|48200799018|61400799027|376014|82310400026|19092799006|22082099003|16102099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 3WerkPbh9hoqJ98Da0sn5Ps82lt3iFU4vnuAu2KWxifcSI06QdySFgCheiv3m6iShos07WWN8Vg2Lxgo9MJOOEaIxmnPniOxDIthxL04+D17E6/77pKUxgRwjnj8GOqpGxA1jFkFUKYETM79jyaqFQW4scdJnHTWRowZ+hLqPK/LvdaKX4wBAw0Dd6CZgR5Lga6Zyt9G2qFCJgDMNQ064eK6w6m03A5HWdTFdrSXPwQY1dDBLBmjczDWFm6Ei6VqMHUADM2aWw/3juwqLipObG1YezZ2uOb0d8RjEA+Rqs3PsjWUfOE2CBz2o6auzb8Lk5MRlyEIq/42hdzMAGGlsvVZn+mMq6pW1Nc0EXlU+YkAB7xGoIbIjjlb9miwCJpbYWWQUTqsaa3Whup3UYrmjKsfgkqu/SrfAyq/pTifTyCO13ApkqHaR5Bd8ZHmckn5C0RB0e9HL2mFnBz9prm5TlxbMvnNzcSqpz/MCgLTzxtSPsvcGBICj2S30u3b14pnAZ+BnSvkzeCf3LyTQw9kRvhilsREV4XXAT9s2/aBz7/MhoDrN1uwuYdsmem+XDzOvmYY+7zeGiaZIslkPNn2paEh0O3+Hrzj/gBNctRQ2LVeCCweGW3lWHBWOdIprWltf2bFAYSHh/sZGKkzeGGU28wtnNyiRCieGvGrm+XUrBCeGK8YLR/sRV69RvkGz8FQv5+zoEca3ib1ue5FVS9tzAkgDpf+sVQPi6QPT8wRHEVvcmx/mlYPmcSkBHDaNX985xfI1V1lwoDaMPjxl5uf6A==
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(48200799018)(61400799027)(376014)(82310400026)(19092799006)(22082099003)(16102099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 nu6lJHvKrsSl0M9uNmTX7EX0F/5RfWLkNRspjX48m+MtZmhE27m/RwoErPzp3c9D0enRW/knW2GYnxGE69tEVDixgo13zAEh6qEi8Lr+rXGQMWGBOn2a7kQCok8mIH5MYih07EHhUPAyzasLIsLRRrE4/+0s5Bonup0+M8Dqapcdix8bntWxO/p2TTSnYEiX0eLJso1PZJ9CvO01UxyM32Cq1yhHpPZwpu3er7FFHsr3LA9aOCH676UAiltXb3NUblmmFztYInAo+8VliY9OtOgfitLiDlQnrcUPUabosnhRYwMFPyNxGusBgJZN8FnmnOi3jRD4sb3OWZgzrBfTG8N5SHEu1VCULpbq7eHBNATV2T8lVY6qZ5Lavk5ZCdcB1nb7rvbehpUDwtLkhrjXWM0Y0jf4blIdyLnlIUBwjWVQf0W1qKzd1xNzTeUc7EXE
X-Exchange-RoutingPolicyChecked:
 l1ryZoQm+UsGJr0bQoK2Fz8Lzvuf7K4+bRbMVIvcVh9Vk6OXTat3Qojl8MwQ1sGpvLvYvQuoXs7aml7LUA0gS4SHZs9xlPJIs0ON9rEAWmIDpYm02F7yI3k+/jfeYSvXbCXQXWR7/ssCQPRbU1bJgwZWupxFPSLruaMH/TTZRNXOjCHF9shMswvKRImmSl3SgbSP1vJezciTfs3IdNnnjNwCbu1Stai/U4e1p37xCz5jl22Y6PiTnj4uRqWK/gkSYdjF+0hCySAFLa1sRRJFQhfO0ofR40yNniOq7sXZIXm9kn6tVWvo8Mx8fG2DUa50rkF/rdgf/+ttnpAtSUrAEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 UuEKEbgvAOMVOmBmHYJlzUJvX1TJHlvsnOOIYaJ9Y3uFf4qPiJA/1nNaGh1eBIEPQGNmUYWZOtssbkHk+21k54rTISgCB+OIHWzikULxbgFObKawlzu5WgFAhMtQYk5Dsuff7yMUZrs2UHCVMnQroRFAIdcI3mn/8puudmkupLjgVPZx9JsTFtcOjuwMtmY1s6aXz5Zay7H0PjaBdrErqVXSpYd8pEwr8C5ixGGVySwRAh3FsX++nb+FdpjPZqU71gKA0gdiR1mGD9PHbrAKVvH7x8XraUyV+5KJFZ5LwPzEMXRvJJVpGoeMcLaWCUsH65Cll+lQmzz302560apLsV7HNexQxl1/M8q6MR3DIXnjVYCpvLibpCZBS8OUhMjd9Ki/NL20V4ML10xVtBBqO3x0mr0q0Gxj0rugjlmZQ3LvGg61hol1+uZ7H5D4kyu+N6WM6dE5asfkec+NZtszC/3b2Gr5vCRuosRMurq6pQPfCSWEf5E1Cg3Tb5AwkxuyKqvY81lM41BzGZarJrOR9+/wT/1+VyPeU8+E/gfxwwqtVFDgTB06Ya6LvY8yQI3IRE30c9iH4MhJJkPsV6ukO48eMTvknfcUF9zp9xsJ4MHap6ixwZmjxdku0G9BI1CMYwFgHTmKsq0o8RxgAUNUvg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:15.6939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fdbc40-e7d3-4fe0-1662-08de8903f13c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8445
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289939-103969-6342-3728-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.201.72
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViampiZAVgZQMDEl2TLRJC0l0d
	zIyMg8ySzV1MA4JSnN2DwxzcDAwCJNqTYWAOr9oA9BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan13-38.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This is preparation work for the new mount API, which goes into
its own file.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount.c         | 59 ++++++++---------------------------------------------
 lib/mount_i_linux.h | 35 ++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 52 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index fe353e2cc4579adb47473cac5db7d1bae2defb2c..b3ee9ba4c0a74c1d0d55f916e7046e064f8468b0 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -34,16 +34,6 @@
 #include "fuse_mount_compat.h"
 
 #ifdef __NetBSD__
-#include <perfuse.h>
-
-#define MS_RDONLY	MNT_RDONLY
-#define MS_NOSUID	MNT_NOSUID
-#define MS_NODEV	MNT_NODEV
-#define MS_NOEXEC	MNT_NOEXEC
-#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
-#define MS_NOATIME	MNT_NOATIME
-#define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
-
 #define umount2(mnt, flags) unmount(mnt, (flags == 2) ? MNT_FORCE : 0)
 #endif
 
@@ -51,10 +41,6 @@
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
 
-#ifndef MS_DIRSYNC
-#define MS_DIRSYNC 128
-#endif
-
 enum {
 	KEY_KERN_FLAG,
 	KEY_KERN_OPT,
@@ -154,35 +140,6 @@ void fuse_mount_version(void)
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
-#ifndef __NetBSD__
-	{"dirsync", MS_DIRSYNC,	    1},
-#endif
-	{NULL,	    0,		    0}
-};
-
 unsigned int get_max_read(struct mount_opts *o)
 {
 	return o->max_read;
@@ -192,13 +149,13 @@ static void set_mount_flag(const char *s, int *flags)
 {
 	int i;
 
-	for (i = 0; mount_flags[i].opt != NULL; i++) {
-		const char *opt = mount_flags[i].opt;
+	for (i = 0; fuse_mount_flags[i].opt != NULL; i++) {
+		const char *opt = fuse_mount_flags[i].opt;
 		if (strcmp(opt, s) == 0) {
-			if (mount_flags[i].on)
-				*flags |= mount_flags[i].flag;
+			if (fuse_mount_flags[i].on)
+				*flags |= fuse_mount_flags[i].flag;
 			else
-				*flags &= ~mount_flags[i].flag;
+				*flags &= ~fuse_mount_flags[i].flag;
 			return;
 		}
 	}
@@ -645,9 +602,9 @@ static int get_mnt_flag_opts(char **mnt_optsp, int flags)
 	if (!(flags & MS_RDONLY) && fuse_opt_add_opt(mnt_optsp, "rw") == -1)
 		return -1;
 
-	for (i = 0; mount_flags[i].opt != NULL; i++) {
-		if (mount_flags[i].on && (flags & mount_flags[i].flag) &&
-		    fuse_opt_add_opt(mnt_optsp, mount_flags[i].opt) == -1)
+	for (i = 0; fuse_mount_flags[i].opt != NULL; i++) {
+		if (fuse_mount_flags[i].on && (flags & fuse_mount_flags[i].flag) &&
+		    fuse_opt_add_opt(mnt_optsp, fuse_mount_flags[i].opt) == -1)
 			return -1;
 	}
 	return 0;
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index abcd1b08012feedef6b4c8961b55ac847a27496a..c0de6228fce5a4d9070cc246ec76222b66de56fb 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -10,7 +10,8 @@
 #ifndef FUSE_MOUNT_I_H_
 #define FUSE_MOUNT_I_H_
 
-/* Forward declaration for fuse_args */
+#include <sys/mount.h>
+
 struct fuse_args;
 
 /* Mount options structure */
@@ -28,5 +29,37 @@ struct mount_opts {
 	unsigned int max_read;
 };
 
+/* Mount flags mapping structure */
+struct mount_flags {
+	const char *opt;
+	unsigned long flag;
+	int on;
+};
+
+/* Mount flags table */
+static const struct mount_flags fuse_mount_flags[] = {
+	{"rw",			MS_RDONLY,      0},
+	{"ro",			MS_RDONLY,      1},
+	{"suid",		MS_NOSUID,      0},
+	{"nosuid",		MS_NOSUID,      1},
+	{"dev",			MS_NODEV,       0},
+	{"nodev",		MS_NODEV,       1},
+	{"exec",		MS_NOEXEC,      0},
+	{"noexec",		MS_NOEXEC,      1},
+	{"async",		MS_SYNCHRONOUS, 0},
+	{"sync",		MS_SYNCHRONOUS, 1},
+	{"noatime",		MS_NOATIME,     1},
+	{"nodiratime",		MS_NODIRATIME,  1},
+	{"norelatime",		MS_RELATIME,    0},
+	{"nostrictatime",	MS_STRICTATIME, 0},
+	{"symfollow",		MS_NOSYMFOLLOW, 0},
+	{"nosymfollow",		MS_NOSYMFOLLOW, 1},
+#ifndef __NetBSD__
+	{"dirsync", MS_DIRSYNC,     1},
+#endif
+	{NULL,      0,          0}
+};
+
+
 
 #endif /* FUSE_MOUNT_I_H_ */

-- 
2.43.0

