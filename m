Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37C3A873C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560925; cv=fail; b=NvGziKqYfBispiYblj4kqchd8+tTBfma0+lZoUJgcp3AIcv6ur4yCOS/ctQuwQWOpyJ8EmLfVIXU38XFCfq3zLoBbEW59+8u9GXBBlNTRLOZExjFMGkAcYh3jQEmAzsuKBN9r3m6AIRNMtTVBzL+RE1bk/ew0riJz0f42hP0yQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560925; c=relaxed/simple;
	bh=OfZwbKw30DM+sN1gL0L7nZfvDYPhg6C0kP0kSUcxymw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WykcqWupZ7W49uJm9aJzVO46uWBWLVserV/MmSwyBnOZypXiDW1bpkMMnh05tG/eIg7I+RCUNzw8x07U9E57ylgrS/DdV7aSwioWXcxhfMiygJn+qniybHcMUhxe59snRlaBlP9tPTMri6+sh6R5U/elAvvA+FfwWUPjnHD+j7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=Ee8CFraL; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="Ee8CFraL"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023106.outbound.protection.outlook.com [40.93.196.106]) by mx-outbound42-155.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT+J7M10ByXc/9mcd9/Mfo5GiAwpv5Lj1wFTJBucIewuoLgTbe0NiiuAJD09itXBcFYT6JfEUd2yP5b8m4R/J0X5m2W668CHr9ecwXcm7wbIbE4uRusbWoJHvFLX+1+vyHurvW4CzJ1vETp6Rfb1Vi9N/UFdJuz92zmoy13xkVWYzbyy9k4dMK5xbDXmMqACs1Mhpd9ao3er68sMXEW4KRsK3+G1ZgIpfMWWaqC+2SNf8qbX4JM8k5OSnTzWBkbQzdrDDlYbQ9Vsh9BPsGrTb6clUJ2s6B5rav2wATgkXiie872rdveGgiJSmKjRirW+OCOKvO3GU1ol8TZozZFLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPVCl7qsglJrzpbXSqaukBJ8g55u9iPUoLy426KYY+s=;
 b=lnXamZ6MYsENIDqomV/5Z0Go4v54Mb9UeXb6eOTJOn10OVrEmRAasJy2gPdclyjYGErnFdI6SeMd0ZUkTuOUtOKjDnJtcllck25zun7MjzlWOcqK8qG1hofuiiU97W/We0QYB0ad/r5TNNa/8NWC8IuzauhdaJfnrAiN37aghn5JNlFXlkIqtZ4PKUmaD4tX5tsFnNeeqAkwdxKknQObGmpblaCKnryPW5Udg5IuQ10ebE98Yvh0A7B1koW/YUFIXSMOvhp3GFhq83UIjXfNK3+yb9PzwYt0x97eeeV2cXxs5JQcqhOXXQKugWm89i7LEm6UA3dYI1LtPPyFAID+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPVCl7qsglJrzpbXSqaukBJ8g55u9iPUoLy426KYY+s=;
 b=Ee8CFraLPxifvWhayWVRrri45V0tRK+a0ovsHM9g1w+qoCVg9dat8Db7gmE//9YQlh7FTiToAmnXBKv8mL2ptuQOTyj7syayHIGttOfD/JrdpDKH/npURyDwX6xT0ULIImAhOsFK1cgLUkwCsilI95mnJ0HD4x+rOuqVYReuGqA=
Received: from SN7PR04CA0043.namprd04.prod.outlook.com (2603:10b6:806:120::18)
 by CO6PR19MB5385.namprd19.prod.outlook.com (2603:10b6:303:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:34:59 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::b6) by SN7PR04CA0043.outlook.office365.com
 (2603:10b6:806:120::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 21:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:34:58 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E63F190C;
	Thu, 26 Mar 2026 21:34:57 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:39 +0100
Subject: [PATCH v2 06/25] mount.c: Split fuse_mount_sys to prepare
 privileged sync FUSE_INIT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-6-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=5279;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=NwzfOJmZFCCheeJ5/41wMSxwDllE0bYvmCWLgk42dqE=;
 b=lYlk1bdQkO94DRh6abH04CA+oze9DRU/xlEk7pZg6pYOTqweLXBKjbyTo0XIfglMsJlSnr0Z9
 zitCEYHCuzaBy7CX/yPaYO6D8Xza9ZdmIxY5zTRcXca7EK/A7c/j9n6
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CO6PR19MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbc7a5e-fa3d-4c47-1fd8-08de8b7f87c5
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|19092799006|61400799027|48200799018|56012099003|16102099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HY9tKNo9s+NS36hTIWgfudXjj+hpLC7lSvOCPDERLy7ZQaHqmZwha3hr2Pa+qZFVLow4PS7NRFoEAoMVLbzImAlSA9EcT61ipR6VMzuMJYVskH9J5unv6XMhGLiefBvDLPviPHlf5lAqd8+YuWdEWkMql3QkYnavs/f0Qs542ZZ6+MpGgC8E2f278O46IYbSQlblSJX5I4ddV1twAZIW9St+MSm2oIzYbu51I19D94ugOp3WQjj9kXROePe8dMMhpmlVLFFqTiizxlHWnYKJ2J90oA8hApS/Nfn4ucL775B0Fv4Awjh1MZNXiMSLpbEomardrnaqJAgYzdT5y/56Dpf0j5ZnnjUXn47ZBT3EtnbimXYoLnRzgGcCCe2oLydjH0l0Z58hHPOi9aU1frB63yrbE5dGY186y5jXi4oDva6At39xNCUJFduZ2rYH9JydPiqH5USy0fCNLPrdFMyNUHgvrzdzkq6AyzUcj+w/6KLdPBB3uFzA97nKmoZ/0od07JIeIXta9k8h50+wQuxit2EUmf5WrHQ5tV9egIVuYaSxGNObqZnVNazg9juaFcQwd51KUoV0dbsfC1DjrKkvCSYVK5eLszzEsjEiLtF51K85x7axIjaGyCsPlccOTn6du3RfIbnGWyt1jqr9ZMPjSPHHAQPVSY+08q3CQSbv9HDQLKwS10cSyUx64d4EgNuShKaMLdWsuALR++NOGChNOLOfyk4qrrOwfHfQSL2QuYwm4PNvhEI6rLakom4sctr4bNftsPmNDobi8e/NJxNhZQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(19092799006)(61400799027)(48200799018)(56012099003)(16102099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fprPROqTTjOS7Ounk8zDt7/WxdtiN4jS7XCSIYyHwpvH/Yp4UYz17i/Oe15YO81ATIGw5iKDqwvM9WFbnYUUoIacUEZOavb+ygZaZDLPVirQ4InGuFz/bC9IlcgHEVKuZjLt5Ouft4CBzCq78Zk9XScO4JtlY2HgVvCa3pkOLZxiQbPLjfRq3GP4IewrlwUbUM+n6h4r7eTmNdkY2aw0yngblvdFHJSjKFGNVrHrTQUQ3wfrvJ+P4pBGxRU13dgOD0LGHoqvGcASSjq6YZgFp0BBVFVVnqpJKoKU5TDpFLOUFoz/WNtsvumJJxg4yNuIeiBFkCzcEcQx7AOLROGPD5mXStBOlFdgzi9uoNofM9Fgytfg8MLxoPnJMfhq3j9X5CZIjx9d/rWCIwwtMQIExs49qYVd/G4kYKLdH/hCBKvb8c/nkSLQpxWMGV3Kstg+
X-Exchange-RoutingPolicyChecked:
	Ee3WzpXYC+AR4x3+kDBWjUCZ0GBy2dIwcAwgSzaIyWp5Nu66jvQlcj9xV0c3qkDribeKDl5TF3GBEQowBdDQ5ss+ki50e3zNxqp3hNKqVXvnM4zgX6hHVzN5kED5kDqAsAUevDkUAF3f4VPkKzDhFbzlHm480e3C23W8JOtNFMe48QMyHzwLqQ/o7tVfUIH9jx67wdN7t4V4y4CzM46BNd4wrb4hPfTDQzzRNtTDgwUjYAnyd+zms4d41fNtgVxr0bhWAMhg6ZDchsR+MWLtyJTymMNSYktfkoZRpXW7PTrlr54HeKcaTGIzrZtKeExvbt2agCphOpOPt8Bw4tAiZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uchFYWhKm2BHd7rR2ABLA8jC2DyVsGCPTzIW5AoUcRXVRmszOXHnsP22K98KGkt7+Cl0p3RlB4fCwEvbY6+YINXeJbquu9FXup0cUBEL4Gertf74EnViEgx8OsjhYPBCdAIL8f6r5WExmG8SEiST1GwVz4DYlldXGJSGDds0Y2kMLaczfXhmAKi8ddVvf+o2ZH8ZFnfpXHGuYjFNu8vGt93dsSq2ildlP79kb6KexN8rdxmjNIJzjjHLUcDkZ09Qw65hGXW1HfqCU6yksNzwZy12ZVSJUD9nsPXsyviplgfpZ1iBxAYZAis1i72nx/fKb25U735Eg0m4iT6wt9bOzHvM6zWqhM3Vm+VnpzpQJTpAqt8aATNp5svaiTRfTg8wo1t0VrEYG5gcaCwKUesQrsdxVDcA10cgdGcs/Kyt3eaTn6UBVoCU+5OCui0iPoQart1kNDu0xNQOd/ON3T7pzK2vPwUhedBQV2c6CyQvvDNJIRHbybMhtuoBWSksE26irlwhcZP3WDYEoZfkBEFVG+/AjrPwLKYoq8B4ZWfo6HoGJHnHNqjfwWwMV6w81pG5iwhqkuRCVDHOwkLfuty+D97nkUaCODk82bZYxXMzgVgl7DrKT493XPDErsrHpOaaq5G4uB92iEPG60zEPtE+EA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:58.7278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbc7a5e-fa3d-4c47-1fd8-08de8b7f87c5
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5385
X-BESS-ID: 1774560909-110907-7678-20822-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.93.196.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaGxpZAVgZQ0DLZxDzN0NwwMc
	UsLdXMMs3cwtLQwig10dTCwjw5zcRcqTYWAH7oIGpBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan17-43.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Synchronous FUSE_INIT needs to spawn a worker thread to handle
FUSE_INIT before starting the mount. For that it needs to have
the device file descriptor - this is preparation work and
fuse_mount_sys() is split into fuse_kern_mount_prepare()
and fuse_kern_do_mount().

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 19 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index 398bf9e7a86743ac3c99f0cc2975e8db92346013..6e404451cc9edc8e35434cc31f25612cfc4edca1 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -506,13 +506,11 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 #define O_CLOEXEC 0
 #endif
 
-static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
-			  const char *mnt_opts)
+static int fuse_kern_mount_prepare(const char *mnt,
+				   struct mount_opts *mo)
 {
 	char tmp[128];
 	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
-	char *source = NULL;
-	char *type = NULL;
 	struct stat stbuf;
 	int fd;
 	int res;
@@ -524,32 +522,58 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
 
 	res = stat(mnt, &stbuf);
 	if (res == -1) {
-		fuse_log(FUSE_LOG_ERR, "fuse: failed to access mountpoint %s: %s\n",
-			mnt, strerror(errno));
+		fuse_log(FUSE_LOG_ERR,
+			 "fuse: failed to access mountpoint %s: %s\n", mnt,
+			 strerror(errno));
 		return -1;
 	}
 
 	fd = open(devname, O_RDWR | O_CLOEXEC);
 	if (fd == -1) {
 		if (errno == ENODEV || errno == ENOENT)
-			fuse_log(FUSE_LOG_ERR,
+			fuse_log(
+				FUSE_LOG_ERR,
 				"fuse: device %s not found. Kernel module not loaded?\n",
 				devname);
 		else
 			fuse_log(FUSE_LOG_ERR, "fuse: failed to open %s: %s\n",
-				devname, strerror(errno));
+				 devname, strerror(errno));
 		return -1;
 	}
 	if (!O_CLOEXEC)
 		fcntl(fd, F_SETFD, FD_CLOEXEC);
 
-	snprintf(tmp, sizeof(tmp),  "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
+	snprintf(tmp, sizeof(tmp), "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
 		 fd, stbuf.st_mode & S_IFMT, getuid(), getgid());
 
 	res = fuse_opt_add_opt(&mo->kernel_opts, tmp);
 	if (res == -1)
 		goto out_close;
 
+	return fd;
+
+out_close:
+	close(fd);
+	return -1;
+}
+
+/**
+ * Complete the mount operation with an already-opened fd
+ * @mnt: mountpoint
+ * @mo: mount options
+ * @mnt_opts: mount options to pass to the kernel
+ *
+ * Returns: 0 on success, -1 on failure, -2 if fusermount should be used
+ */
+static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
+				  const char *mnt_opts)
+{
+	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
+	char *source = NULL;
+	char *type = NULL;
+	int res;
+
+	res = -ENOMEM;
 	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
 			(mo->subtype ? strlen(mo->subtype) : 0) +
 			strlen(devname) + 32);
@@ -593,10 +617,11 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
 			if (mo->blkdev && errno == ENODEV &&
 			    !fuse_mnt_check_fuseblk())
 				fuse_log(FUSE_LOG_ERR,
-					"fuse: 'fuseblk' support missing\n");
+					 "fuse: 'fuseblk' support missing\n");
 			else
-				fuse_log(FUSE_LOG_ERR, "fuse: mount failed: %s\n",
-					strerror(errno_save));
+				fuse_log(FUSE_LOG_ERR,
+					 "fuse: mount failed: %s\n",
+					 strerror(errno_save));
 		}
 
 		goto out_close;
@@ -619,17 +644,35 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
 	free(type);
 	free(source);
 
-	return fd;
+	return 0;
 
 out_umount:
 	umount2(mnt, 2); /* lazy umount */
 out_close:
 	free(type);
 	free(source);
-	close(fd);
 	return res;
 }
 
+static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
+				  const char *mnt_opts)
+{
+	int fd;
+	int res;
+
+	fd = fuse_kern_mount_prepare(mnt, mo);
+	if (fd == -1)
+		return -1;
+
+	res = fuse_kern_do_mount(mnt, mo, mnt_opts);
+	if (res) {
+		close(fd);
+		return res;
+	}
+
+	return fd;
+}
+
 static int get_mnt_flag_opts(char **mnt_optsp, int flags)
 {
 	int i;
@@ -678,6 +721,17 @@ void destroy_mount_opts(struct mount_opts *mo)
 	free(mo);
 }
 
+static int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo,
+					     char **mnt_optsp)
+{
+	if (get_mnt_flag_opts(mnt_optsp, mo->flags) == -1)
+		return -1;
+	if (mo->kernel_opts && fuse_opt_add_opt(mnt_optsp, mo->kernel_opts) == -1)
+		return -1;
+	if (mo->mtab_opts &&  fuse_opt_add_opt(mnt_optsp, mo->mtab_opts) == -1)
+		return -1;
+	return 0;
+}
 
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
 {
@@ -685,11 +739,7 @@ int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
 	char *mnt_opts = NULL;
 
 	res = -1;
-	if (get_mnt_flag_opts(&mnt_opts, mo->flags) == -1)
-		goto out;
-	if (mo->kernel_opts && fuse_opt_add_opt(&mnt_opts, mo->kernel_opts) == -1)
-		goto out;
-	if (mo->mtab_opts &&  fuse_opt_add_opt(&mnt_opts, mo->mtab_opts) == -1)
+	if (fuse_kern_mount_get_base_mnt_opts(mo, &mnt_opts) == -1)
 		goto out;
 
 	res = fuse_mount_sys(mountpoint, mo, mnt_opts);

-- 
2.43.0

