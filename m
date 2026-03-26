Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7373A782F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560924; cv=fail; b=SnPRMKJkd0szmIZqQHPilxgYek1/Z47byF4u7Ewz+YTYV05S2kRyNE1qYpFLfJ1KI6y6yrAcqxuRTO3RV+qG0Pu6L8oPyv980pAAKlGDKlKwb2ILQ7vpyVZbWehro9GLhHVMoEOKOcnGpVvD+rmLPxLPUfdGK2jHbXtQqcXF33Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560924; c=relaxed/simple;
	bh=/DzLQC59DzJJBgSjW4c6VsjpKHWtAsnIENy9B1QQPpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBcTpfeJvsTzMyVStQlY+QiZ8BQlaxscCwaPLINoL6mfHM8AFi/Eg8XOI/u16S60l1kiuxyG2St6+bIe2W+iAylgb6KQh/q7K6VzfRYqgpoEBzHUenEbi236oT6JWFoRRRpVM4WKdPCfPPogXOvzZmcv1GvDhP1LEbRPzBy2o68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=dZg5pmbP; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="dZg5pmbP"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020133.outbound.protection.outlook.com [52.101.56.133]) by mx-outbound43-179.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vD63uDfhN2jrTFAQOLEG3Hw57K9lmL7U7n+4xAMECzlQWhwUsmr38BYw3qB9Emi1p5LrXYStS3gAXnAKfT2jyZk17pahP4HqzsLaQ6NNMcdq24+QHhU/CGMLeMwpJ3CUnuUkfdSRZfH5SRRLr8JytoB9d4NEso6txYdO2RdgHPF8xrMoL/gsn3OlU5eWKM+8pVhMX2SJ5bd5SHS2MoDP7qzqHpseTVlUr1ybFOaLJIrXf2urQHwU0aBa1o45rGFb4IcD4SaxqqdE5HFcjIYrLIBami1ltOHUtvO/wbFz5fN1CLaYzJGnxSr6xKDM9/7N7b9ItusFJo7Otc6wAcAuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZDP7nwaSSYRjgCToKxqP2IwX6pXR9FgCPML1hi7C6A=;
 b=TS77J4SkU4X/0vXgOnAX7KyX9YRS5i2ATqM6ltdPWToMb67ceNw+WSf5EGWwc3HKfG93MuVpvXoFFUE9XqES2T271W76/SU2F0YnU0evyxSXF4k2Xx+q8qesWjG/9OMlWoXkKP4lsbxe3sHigZZujiv00Gi0zJ2RVf+Cwy0KtTclmgk22ixS244WQ3V9IBjWAGCEqzWT2kZAQYJgkGgKiezJjMbuq5C4vS6M/4eW25EwtPARrVXA5LURHamhk119q7KTdSrQtZFnlVkcmwgXQWP2ldZvcASQfEPEktcf0z2wBBKt8qRfx6dOO/7JVecl0IWTR0E3/Z0BLX9Ct4Rw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZDP7nwaSSYRjgCToKxqP2IwX6pXR9FgCPML1hi7C6A=;
 b=dZg5pmbPDQx93U7o03WMozuGmMS1yKVkQau1vazUHYAFjTqnXbGeHPeeJ3yS0lJWyMGt29XzeZ08j/5BRsqoMYsn6eQom4+8TuX9ZQKw1EHUjV16cas2BsAnmvcPpOa2QU0/FrEe2l1m8WrzCyLjY5GXwksQb1AqDa1c4WBe+D8=
Received: from BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::23)
 by CH3PR19MB8162.namprd19.prod.outlook.com (2603:10b6:610:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:35:03 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::4e) by BL1P221CA0011.outlook.office365.com
 (2603:10b6:208:2c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 21:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:02 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id B327B9BA;
	Thu, 26 Mar 2026 21:35:01 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:43 +0100
Subject: [PATCH v2 10/25] lib/mount.c: Remove some BSD ifdefs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-10-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=2113;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=/DzLQC59DzJJBgSjW4c6VsjpKHWtAsnIENy9B1QQPpA=;
 b=xuI3F5ejwHu3i1YMTa+TGasZsurEWXOwrpz5LGlwnDRlbQRwh6dvfhQxUPqIbGRdTnb/f/9BZ
 sMImikr2dG4AVrtfK4im1HHTm6d1v3TE/T+fPvhuvT18NvC8jxPe2wT
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH3PR19MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: e69323bd-c751-4950-6285-08de8b7f8a2e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|376014|82310400026|61400799027|36860700016|19092799006|56012099003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	xZWlZaDJn3TR7myC9srQE1YSF/mkRGLug41SjJj8Aw22Rcf68uilGXLGNL5teM0n59+eYP1kUQGPXf+I/0NjpePiXIWS5mk1oRCd3U6iuj1KJTxLzY7JfXJV+hR20RhY3LZQbg44UIWOkhbcMOlIkkgAvXLl+o2Aw3qzIldPuzzgorVmY3ayi4Sv+wdh0sMhaFHtdpeiBHk0e/NGCm1qf3iBBiBGSMBxG1mQOi6mJdD498liXuml1T/o2zOr0OkFN5mh1EjMbY3DvFrJ62QTlVPaU+3axyeYsBaCVfwvn7MixIZIt35tdeHMidfqx6493OGI4YcBA+99PviS2q++f8OxypN3Nf2GYj9xZo413yjMrzcHn0TOtrG0gmc/elToI3Gl4uQT77cH0ZkSh6iPElshDQWb5XcO7kMo6H8V9LZxOOkKABPau6MUtz3ow5e+x0EmwYfVVn9sg3Aac2YVg6G/Obo/XOmDTJonj+wADHll5cFcn8ZCepEDWxRBFqZDfNE1RNdW5eYlNl7hDSSrhuQYHDaIDgXFOhoJYUBy/Czkwn8bv+Y0WtaVhN10Kxme0PMVvgYobDhXy8u3aMLsi1CMkPuLBXer9P2Q8KmmDjdAfOioIb5sJ1gkIYcAH8QEwzY8CQ+mn5OW8aPEg0Q9iWJi+08tGipFIpDdp/+Wmt4Hke58PMsSJuC+wtHcORFVuMVrbfxsq1tM2k4Tgiu2bjLpHLa3EMaIlmD80GkoEag+PHHbyNRfQO+QQxZuA8DfvigTc1mkZ3ZZxy4EZdz7zw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(376014)(82310400026)(61400799027)(36860700016)(19092799006)(56012099003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UytMpCjL+35eRuAx7++xc8yYojKioq4IkGFKHvDMy85F8sRS1NMACn7auVAA43ubBsUOKNqAbP/UlWrIYwrfBPrbGNQr3cKsR/Xki+2l2DNTLU7q8KOCR0//sgXzPMP9zVhsCRh9NvU8336jR894n6m/noq7UMPywwIVYj7F7GZXK8i8vHe/56CFZSf7wA8rodhYneN8m19gfFOpo5uw3XijoQIcV9i3LNlwt+LpxrXd6n2AaEqkgYgTGRUAqSztWqfm3Ufym+IYX5d84fZ7nsHPEf08SkHUvfxUvrA42iTE8byZQzoSInecNNDYj16fYAkRoO+ZOOf+9Uobz567bLmYbGxDHMRgxhfxXtY1yI6LCJ60+48aQdQhy7kNHrzQ1t3/Cn21ZANnxG405+mrwHqt0RlmpQqiJKZSTXz6di9efCwsonF6tcX9gaWgZEw9
X-Exchange-RoutingPolicyChecked:
	AAATBQY07B4vfT6sRs/YE3pHX0tQOEdzIDF/YNFJ6Be++q33DWqevER1zKtuJgZk0wbm7HHd2JaUUPvGksKV82XnWuFxTNDAckOU1D1WmYS24Fw4onk0wWA5xeEXQyI8xZeohKbVr65XRV/q/73v6G0Qudkd6VnCIexUmi0N02+O3rxhCLAGADphpH84OD85+wbuYoo/LRMrEQpQU1cUCNH1WC5N0puPiC/0bej74s4tjlEqBcGLnelGbot+kD1NhCGaXtVIaRso3muueOyHT45v3XHxAwdG2jKPc4KROiftJ652h7alDG/KObXuCp5yUP/ZsHh4hAvrhsoFAlrZ/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eMKR5yhCiyQpVymPaCQuJ67T9WXqF9KBRkhS9fN+6/wQDUmtZHpm4PDyL2tdMyKGdfFUxNjgE7YwNQOcJe9ebzWmoS/XDwf4KCH9912R9zU+0XOLRA1ewOGt61GOKEYdAMIAdAUcPE/zyj8X32X8czgI5ZV6j80ayjRq/V3gqn2j+qv2I7Iax85DZQAyXIDoV+jdL9kLDP+byU1G1JYrjeqp7eGkmbX4nGIKE+S3hiOBxsM0ayz+hANw4lxE1qsmSGj4Pc/Z+ZYCNHyT0DEUytCj8LIMVAcNrCCS1fDvMyEaXDtZxrK4yQMbrQ3bqxwivz0XKvJAmL8EIKO2Vy3e318w55IcO+foozcsD3j910VFkejniv2Fre8Ysmd30wM7iu58v19zekEWT59io4ONRuhkkJP26c5hmHPuMmAXK8/xVr3rGelqkTLGQvxfp5NtTLY6sy6S4lXVq9EO5q8qVNWa3sYajh8W34KRlVYuM8n5sud051k1a6XIHNbqMO1mUDA5E2cApRr42olxyvTdRTQq0a+vHBcNsVUHnTbWyVXPjZWD4x13BSggsKsWmiKICSPK7kporwQiniRVqUEtJ7jxSMbdG/55SBA+cFyDHW/iJVs8+pRQpJ3pqNXKTIfLO/7FAavIn1dVveYvn4dcDQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:02.7353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69323bd-c751-4950-6285-08de8b7f8a2e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8162
X-BESS-ID: 1774560911-111187-7708-3360-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.56.133
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGxuZAVgZQ0NjC2DA11SA12c
	zY2CQ52dLAOC05xTg1xcAg2cQgzTxNqTYWAGkF2LZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan20-194.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

BSD has its own mount_bsd.c, mount.c should be linux only.

Also remove MS_DIRSYNC defintion, which was introduced a long
time ago - all use cases of recent libfuse should have picked
it up.

Some ifdefs stay, as they will be moved in the next patch.

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index 68f9219d2b8beee51346b198ce826138b9528e73..899cd2d0a13a9332a564b10d1c22836fb2cd1710 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -43,27 +43,20 @@
 #define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
 #define MS_NOATIME	MNT_NOATIME
 #define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
-
-#define umount2(mnt, flags) unmount(mnt, (flags == 2) ? MNT_FORCE : 0)
 #endif
 
 #define FUSERMOUNT_PROG		"fusermount3"
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
 
-#ifndef MS_DIRSYNC
-#define MS_DIRSYNC 128
-#endif
-
-enum {
-	KEY_KERN_FLAG,
-	KEY_KERN_OPT,
-	KEY_FUSERMOUNT_OPT,
-	KEY_SUBTYPE_OPT,
-	KEY_MTAB_OPT,
-	KEY_ALLOW_OTHER,
-	KEY_RO,
-};
+	enum { KEY_KERN_FLAG,
+	       KEY_KERN_OPT,
+	       KEY_FUSERMOUNT_OPT,
+	       KEY_SUBTYPE_OPT,
+	       KEY_MTAB_OPT,
+	       KEY_ALLOW_OTHER,
+	       KEY_RO,
+	};
 
 #define FUSE_MOUNT_OPT(t, p) { t, offsetof(struct mount_opts, p), 1 }
 
@@ -177,9 +170,7 @@ static const struct mount_flags mount_flags[] = {
 	{"nostrictatime",   MS_STRICTATIME,	0},
 	{"symfollow",	    MS_NOSYMFOLLOW,	0},
 	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
-#ifndef __NetBSD__
-	{"dirsync", MS_DIRSYNC,	    1},
-#endif
+	{"dirsync",	    MS_DIRSYNC,	    1},
 	{NULL,	    0,		    0}
 };
 
@@ -264,8 +255,6 @@ static int receive_fd(int fd)
 	msg.msg_namelen = 0;
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
-	/* old BSD implementations should use msg_accrights instead of
-	 * msg_control; the interface is different. */
 	msg.msg_control = ccmsg;
 	msg.msg_controllen = sizeof(ccmsg);
 

-- 
2.43.0

