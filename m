Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33C3A8724
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560927; cv=fail; b=O08QnJYcf7Z5R/c1ZFi9KwEjRTLUODWU0jBkl4QW0gvgw/T56ZF9J0PpZ7UONWMH5YW0lasbYc4jYOxZ9q7D9WblyypC53oPjjq6i2PTzkVI9omBCkJs0p71ImkDGWkIGUH4WrbsTM4BbW11uhIDQBNPPrUKETzBwU08Sr1qXpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560927; c=relaxed/simple;
	bh=Mg6JZpWQyGaSLnzJJ3hFlXkxQYb16Ouy4EoHWIjBGf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poadD8b4ejm97qAKNUoVoFiHO9SRGXAqvbN6ai7cwhkRytP7HXa5LGioo9eqtQBsk3liPpBACuSElzUnJe/uKdStwSsAdRAGFgM82az9scKYaR51NQQZpAWM7w7EtUZeUtn4XOv9SPJmPW4lH+LtvXTkM12SLLq5LmwpCAMalLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=n4k124oY; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="n4k124oY"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128]) by mx-outbound19-44.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwYNPYHahvmOcjDBVfQaaFGUje1vxwBNHlQtvJmrS8iWhDhJ+RD+gBLYTp2xsTkP5F7zmr+Y1l9tlOewHfXs1Q3Y6D6/2nRgw3zI0s0XSX5PsZsAV84f0E6f1SrwW1yKd4CCowxVJfN+D35zRernKOt6SerDvyccuXVQ7pQQMnO4LCluRZHZBBY0MYMZmnl1jS9hU2ae9h7yUOCUAXQjb14oyDwGNIQLy52OGLwU51LB3Rl0izFLbKTapzhshuKDEWqjOyBucJu8jyapDkMtspjvWW8xWJX/bN/Pe42oBmc3yc1lpD+SOwJtZBkhADAolNOCk8K1KQBuLPLk1R+eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ6cfkAPJzFlE7vihSkiVcQ+tBpjCF7/junZ1aYIhcc=;
 b=W50aiqH66gTEaWOpe9dB6Fytv/oYOSNZb94h0vxvWoL2CFLuS78sYX9WcYaztZuRfmIJFY4cxOsewzFYeel5EjlBa28SyeawIOmue7DZUlnD5dzrv06xXVH6UHTCFFBXYSk6eBFitLX+ycxgxkq9tY3lPi0twv4EQSt/2xmZ1P3GbDCqSC9lfbsJGLGBG9UPtf4LdoYVUnaAcDzoUygq25Df+vX0di+bZjlRVoOmYjyHIZiccm3wMxmXcS3h+/qVGGYDgh+unm8GWrPN5u1YnNjFhbY1twP4KLNYhaUtey+dATMXEl44klI0ikVaRMjAq8iN9HwncnODGa+FjAA4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ6cfkAPJzFlE7vihSkiVcQ+tBpjCF7/junZ1aYIhcc=;
 b=n4k124oYE85BD4VFwZmhYjk8gBXNQTN2WhKmpIbtz3WOY+fCcBBSBx0j+keB6MqIZug/95OX4npC7KH4ZwTLYwpkgq1KPfveDqekAUQtHFAJXWIiQysj0BiPy0xRGlbBH1Y9ZEA5tcti/NQocF0wsCLqAF96pMXDVXRVWf/5vj0=
Received: from SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34)
 by MW3PR19MB4268.namprd19.prod.outlook.com (2603:10b6:303:4f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 26 Mar
 2026 21:35:15 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::1f) by SJ0PR05CA0119.outlook.office365.com
 (2603:10b6:a03:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 21:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:15 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 0FFD9179;
	Thu, 26 Mar 2026 21:35:13 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:56 +0100
Subject: [PATCH v2 23/25] Move fuse_mnt_build_{source,type} to mount_util.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-23-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560892; l=7418;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=Mg6JZpWQyGaSLnzJJ3hFlXkxQYb16Ouy4EoHWIjBGf8=;
 b=qTAzihfBGym9QJfw1CXTyKi4ErjcK77YBM7KoO3wHav7WS39UWBPznzOTABgsGhzCS9Ro/Heo
 3RXnfEldDcNAqcY6FNLGhJAsTCSM62inNjdZpwO+mTEkiE6Bjkio3o+
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MW3PR19MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: c1352005-831e-4c5a-f405-08de8b7f917d
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|48200799018|36860700016|61400799027|376014|18002099003|56012099003|16102099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IaPpLK8C6CVcNDv01psCWzprSh/TVKbNWR4Q84GpSWrtibcaSREtcfugWkf9Q4bicQEfB02i+IeAQzRsuPf5efLHnLaS07uO34CY0F3tnrKv+NC20i9oVRcbGen13hpNWKZuUcLkUHRiaO1SHH0jun9A8CWGjBFFYz0OMnp5GY+sAbaoQemU2t8TgqNrv3icN7S9GkMGsIDBFsXjYWmRcLTOn4APs6fcIP2HJ21XGroEXBQr8NgUeXbwMkpy1m38GFmvYyWMCqa7jDZLQbZdBOaAM+Jx8jGJZu/qTMDFCVo0kriN+muc7MNU2SVwvclF7XGLSOnlDvEm6t6ei4UolsG6/OhCNvtYwxBjPBNQQFAgRPAqdUXlemL3MUCcfd6QkSbjIkiqLwOyQi84/l0VicVulG1AHftjhqPYBMGdUZNRRq2JJhEA16/HbhaKtrz5cZUDU6T9ca3ef3UOheAJqVbh6Cq1u+tDiQ7xMPCSUeUjhjg77CqQbHBBhvyTeYbmO8UDgfWMXXssg3T2/beCux1/dM3jQpIWd7uw5hY324mP9gbp8regSGXb5kBHyUip9rnZ8gxmS+cyVPSgH4H/+DsizREtLeS6X/5I38hpkEr5ddk5dDztvlYyArI5fHbPVgp1uGXwt4SNmamH22Xs9XZm1vITne4GJzzBy6zAx4Oz9V5pcTNm0DVs09cgwhcKD4Q/Yni8tEPEqIQPLOZdseC4uHn23MjeD6PVLc9cNQqaBCDQDf0YSbXwF/GQPlVfYaLd5gtcYRtxI6Vh19lRNA==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(48200799018)(36860700016)(61400799027)(376014)(18002099003)(56012099003)(16102099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yHDIUJqHvp32NV+6aDWaAnvOm9NrlDOskUc5+0Hwxyyj4dNVttjvvMSls5tEGxMxX8xQXiOduoNZXzTrbARAvvElpKw6u+JNHJAvBLdozdGO4b7DnaFXEZU5MwsL/TVSOVY+N3FI3BznewIdqs+qi6RsqJw6tWnhkqE5xvG1JhdMlvZMHOtynV1AMBAsyncVn665bgAMwMpLtvYKM1zGd/aqsEV/HT/FRHeMRCrfTB0mxtgjH4ZC1xaWpIKcxcSiYEzyM/wBevB1PMax6d79WNS9gw+e0BnnLL73uxWlH5OeZkPqqhci8W4mmIAUbiVa9DdN5xRfplvZuY5j+JRgmfR700kAKAfQnHvxNci4a8aP+ugSW2MO80gRs6VMdhRfnzgiZnF4D66DBeub35rdPB4BlfTAmOy8b84Lvpj5Z9+Si8tkuAOkrO06BaYeZCC6
X-Exchange-RoutingPolicyChecked:
	YonOZ0IyH2OqsPQRzTu0n9x65tmJdfNPlJgW55lgqEQ4l8kqhM5yT2EGLKSUjZHM7fr/NMWcr38WRxPykP/uF5AyboXwZrjA2kMYo9RGd8xLCRC9hAKRUz/QeN81+jXrc3zSIzwA53meWyJmC+Av0o3gIVPUr/ukK+FWFHaPsYXH+QhrBOWh30Ey3NS9OWfcaHM5v6/uPeOHaYLoZ3zvU0de0SwgWRsxzxuj5vci7pOmEoMUSPIpY9ukYQVzC1R2b7NA7IBFye7AOt5VyP34u5rriZLxxfdJS5+PiMJ4oYcN1bQ/20Ic2V842kbLL7lp48U3ejASOCCsSsKk/hICng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4sV9LW+olpmGGkmPgvN8rBBUvlz8oViW2LAOZCSRgYLz6S8ZNFsOiI5lK/XgqgV6bBGAbfmaFaKmkrlnlGTLt1+n26aN4Ye14/W/EjnGRkc0Fy0gd5JPaZ/1bsuD+4xL7Wb9mTrZhqd6KL2FhX1Xp7klUnBp2YvKRMjWNdA/lPgI7mKX1oMW0ZmwB2OBJO0d2NbkycKleHsHm/ntv+umNraXt5/pv7AkPXVUbqecHTLX1QHxYBmswQ7ecdNu9b1VTS6++Vvb70vcINGftb5v6XBgqmgfwNtGpE3GuCFSilbw1a/NNtEmUJ0R5Y4neST02eJGrJ29RFYPIJhhp1ZVYPzyJmNVabR/AJRVncWkvzRWddShZPjCr/vSeXpsxh37VeI5s0/OAamz27GXNWW7VeFN3m2dcSEtC3AavDwr8mJO7IzqAfXeRKIQHdd60p1W0oNYqb1JJE83Ujprq/TnugzFkUO7leNSI4eSCFwtpCj/7//77nPU13EPwhjgct7vAy0lSogl0r71x5wy6URfH3znrCI3ByJSm0W5t8P/PB5Cf/Qje8oiyBBaTGWhXtPGrEv1j60zAXDAg1mB5O0jDH9TOtn6quEWGvhJOdnC/GfpAtN52KHelkdZksAgHN6NbhLV5EQraM46WGKKzhXjkg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:15.0278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1352005-831e-4c5a-f405-08de8b7f917d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4268
X-BESS-ID: 1774560918-104908-7702-14696-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.43.128
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuaGFgZAVgZQMDnFwiTJ0iQxNc
	UyzdjcNC3J3MQkxcg01TTV3DAlycJEqTYWAIhLTK5BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan23-161.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Also make it more generic and avoid taking struct mount_opts
as parameter.

mount_fsmount.c and fusermount.c use these functions now.

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 lib/mount.c         | 37 +++----------------------------------
 lib/mount_fsmount.c | 29 ++++++++++++-----------------
 lib/mount_i_linux.h |  2 --
 lib/mount_util.c    | 31 +++++++++++++++++++++++++++++++
 lib/mount_util.h    |  5 +++++
 util/fusermount.c   | 16 ++--------------
 6 files changed, 53 insertions(+), 67 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index f0d12525310a9ad239c0f447af60bd49b105a091..1e82adc8621da150e1ee61e8253b261a33625260 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -651,10 +651,11 @@ int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 	char *source = NULL;
 	char *type = NULL;
 	int res;
+	const char *devname = fuse_mnt_get_devname();
 
 	res = -ENOMEM;
-	source = fuse_mnt_build_source(mo);
-	type = fuse_mnt_build_type(mo);
+	source = fuse_mnt_build_source(mo->fsname, mo->subtype, devname);
+	type = fuse_mnt_build_type(mo->blkdev, mo->subtype);
 	if (!type || !source) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate memory\n");
 		goto out_close;
@@ -834,35 +835,3 @@ out:
 	free(mnt_opts);
 	return res;
 }
-
-char *fuse_mnt_build_source(const struct mount_opts *mo)
-{
-	const char *devname = fuse_mnt_get_devname();
-	char *source;
-	int ret;
-
-	ret = asprintf(&source, "%s",
-		       mo->fsname ? mo->fsname :
-				    (mo->subtype ? mo->subtype : devname));
-	if (ret == -1)
-		return NULL;
-
-	return source;
-}
-
-char *fuse_mnt_build_type(const struct mount_opts *mo)
-{
-	char *type;
-	int ret;
-
-	if (mo->subtype)
-		ret = asprintf(&type, "%s.%s", mo->blkdev ? "fuseblk" : "fuse",
-			       mo->subtype);
-	else
-		ret = asprintf(&type, "%s", mo->blkdev ? "fuseblk" : "fuse");
-
-	if (ret == -1)
-		return NULL;
-
-	return type;
-}
diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index f42ae97faedaf2420d97e701a22725d4293e4853..57355db89f907e0dbd910ead4ea39005ec26c44d 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -329,15 +329,21 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 		      const char *source_dev, const char *kernel_opts,
 		      const char *mnt_opts)
 {
-	const char *type;
+	char *type = NULL;
 	char *source = NULL;
 	int fsfd = -1;
 	int mntfd = -1;
 	int err, res;
 	unsigned long mount_attrs;
 
-	/* Determine filesystem type */
-	type = blkdev ? "fuseblk" : "fuse";
+	/* Build type and source strings */
+	type = fuse_mnt_build_type(blkdev, subtype);
+	source = fuse_mnt_build_source(fsname, subtype, source_dev);
+	err = -ENOMEM;
+	if (!type || !source) {
+		fprintf(stderr, "fuse: failed to allocate memory\n");
+		goto out_free;
+	}
 
 	/* Try to open filesystem context */
 	fsfd = fsopen(type, FSOPEN_CLOEXEC);
@@ -345,21 +351,9 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 		if (errno != EPERM)
 			fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
 				strerror(errno));
-		return -1;
+		goto out_free;
 	}
 
-	/* Build source string */
-	source = malloc((fsname ? strlen(fsname) : 0) +
-			(subtype ? strlen(subtype) : 0) +
-			strlen(source_dev) + 32);
-	err = -ENOMEM;
-	if (!source) {
-		fprintf(stderr, "fuse: failed to allocate memory\n");
-		goto out_close_fsfd;
-	}
-
-	strcpy(source, fsname ? fsname : (subtype ? subtype : source_dev));
-
 	/* Configure source */
 	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
 	if (res == -1) {
@@ -439,6 +433,7 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 
 	close(mntfd);
 	free(source);
+	free(type);
 	return 0;
 
 out_umount:
@@ -458,7 +453,7 @@ out_close_mntfd:
 		close(mntfd);
 out_free:
 	free(source);
-out_close_fsfd:
+	free(type);
 	if (fsfd != -1)
 		close(fsfd);
 	errno = -err;
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index ae98296a334a2aa39c4f3e5c3e4e3c136ae38cd3..8fc27b958eab3141ab852a7cb5098febd484e04f 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -41,8 +41,6 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
 			 const char *mnt_opts);
 
-char *fuse_mnt_build_source(const struct mount_opts *mo);
-char *fuse_mnt_build_type(const struct mount_opts *mo);
 int mount_fusermount_obtain_fd(const char *mountpoint,
 					   struct mount_opts *mo,
 					   const char *opts, int *sock_fd_out,
diff --git a/lib/mount_util.c b/lib/mount_util.c
index b6b75e60874ae9b2ec0c96f2a62b4ec1943a2a00..8cb0ce999e0df498c6777daf2bba6f47f12d7eee 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -461,3 +461,34 @@ const char *fuse_mnt_get_devname(void)
 
 	return devname ? devname : "/dev/fuse";
 }
+
+char *fuse_mnt_build_source(const char *fsname, const char *subtype,
+			     const char *devname)
+{
+	char *source;
+	int ret;
+
+	ret = asprintf(&source, "%s",
+		       fsname ? fsname : (subtype ? subtype : devname));
+	if (ret == -1)
+		return NULL;
+
+	return source;
+}
+
+char *fuse_mnt_build_type(int blkdev, const char *subtype)
+{
+	char *type;
+	int ret;
+
+	if (subtype)
+		ret = asprintf(&type, "%s.%s", blkdev ? "fuseblk" : "fuse",
+			       subtype);
+	else
+		ret = asprintf(&type, "%s", blkdev ? "fuseblk" : "fuse");
+
+	if (ret == -1)
+		return NULL;
+
+	return type;
+}
diff --git a/lib/mount_util.h b/lib/mount_util.h
index b83db556d5fdb4bd8dd5e1750c8d11faf7373d82..5ba428a1f96df0dda21c0aadd936c022c4bb751c 100644
--- a/lib/mount_util.h
+++ b/lib/mount_util.h
@@ -35,4 +35,9 @@ const char *fuse_mnt_get_devname(void);
 int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
 			       const char *type, const char *mnt_opts);
 
+/* Build source and type strings for mounting */
+char *fuse_mnt_build_source(const char *fsname, const char *subtype,
+			     const char *devname);
+char *fuse_mnt_build_type(int blkdev, const char *subtype);
+
 #endif /* FUSE_MOUNT_UTIL_H_ */
diff --git a/util/fusermount.c b/util/fusermount.c
index bf442416c83d6da3f80eca5c9814df29f61bec56..6d3ad4b300ba6266778fc23f35fa6f4fc929ff3f 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -1048,25 +1048,13 @@ static int prepare_mount(const char *opts, struct mount_params *mp)
 	sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
 		mp->fd, mp->rootmode, getuid(), getgid());
 
-	mp->source = malloc((mp->fsname ? strlen(mp->fsname) : 0) +
-			(mp->subtype ? strlen(mp->subtype) : 0) + strlen(mp->dev) + 32);
-
-	mp->type = malloc((mp->subtype ? strlen(mp->subtype) : 0) + 32);
+	mp->source = fuse_mnt_build_source(mp->fsname, mp->subtype, mp->dev);
+	mp->type = fuse_mnt_build_type(mp->blkdev, mp->subtype);
 	if (!mp->type || !mp->source) {
 		fprintf(stderr, "%s: failed to allocate memory\n", progname);
 		goto err;
 	}
 
-	if (mp->subtype)
-		sprintf(mp->type, "%s.%s", mp->blkdev ? "fuseblk" : "fuse", mp->subtype);
-	else
-		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
-
-	if (mp->fsname)
-		strcpy(mp->source, mp->fsname);
-	else
-		strcpy(mp->source, mp->subtype ? mp->subtype : mp->dev);
-
 	return 0;
 
 err:

-- 
2.43.0

