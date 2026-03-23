Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1942C3255
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287936; cv=fail; b=Lu5O5thD3LhNIPVaHKofvpbdKTP2MxlgyO6VLD2dBEfh1wFGBe0aN601K3kt5FXi670bCTR8bgNXQ70unx+AqsJIgmYcU7oQpWLJXZJW7e9sxO3v6F6Sj4p8ipCx0M6H5mE64NjyWu9qT2a/DCArCWyCr+fhf1JLRYSaVpLXSCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287936; c=relaxed/simple;
	bh=NIsVr8I5F0tP8tKfCorSSQRQJNirE5B7nLyzGDmcrfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQQV5q9C4dUpxNHwmUF+RagNhCV1NoQnFYjAVfBL/jf4yZTtJC5njlXLuSDuL2uHR66ocDjg7xU+zrIgQTcV0ZyGR90UfUGJ6sHJfkCJ0TF7wKsaSiVnM0lRbVHyFoyXl6YOBN47SI56/DwqXEaDv7YQPqKjkSA/WRbQaSiVT4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=XaWe+DTP; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="XaWe+DTP"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020115.outbound.protection.outlook.com [52.101.85.115]) by mx-outbound46-190.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNe9JKHZT77pJ1rmbiaX/OLsb+K6SHqhvlq9I5jIs7ZJehekBMRtpOYv64X8iwD9/4eIYcwJ4WU4B8fJhOt7BidoGFRFP4fbroVINSJJ+MYBETgFkt4jNnYTpW26y861PCXNZ2sKVrktvZWBK5TPlePVd7JSjhWo2HNuhOYB97/bx3SJleP70bbJQQT0Y7OWCucdoFVabs03KwyMYHs9UmvV9qu6irYEXm8FkdBMa9cLpWyQiZf3XZSw+vTjhGiap+nabtka5r5UocFiHXWBnMf+WHWgytny5bjHlLLgFxZp+vUpFxc6B3exFD/4ork8aZ9TQ1X6iYYsWmw4MBUEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE8GTgd+RXxonp+H2yU1qxeNvtXPvNhKfyQ1cP7h8Yc=;
 b=Hcwsw6fPo6/ooU76U/mkc+jiqyKJB4Nc9AL+lPkOnNvgz4YKmMJYGqWWgCZY3IByDRbDB7ffuCKwnNPLtip8Qb73/KiVNstbV9GY45We3E+KciJcvz28+xV32xAiguF+y5IaLuiFJNM0piwoqHl2s8PI8N74A/qkGtlFIE05Oe27Sj7sde6gTpAJyHDkWexlgoE8kx+KXffsfvimJkhwWOq6I958RO8JY8B6Owea2t8K95fAy09E38DM7dmrx5V2ca7CfNc2KqEfdzEefCfC1MRtaGM6YizStPeSgNhNhAjZR9ki3oK0ChojmXG/eZEElND5lAn3n8uaRmlufpSmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE8GTgd+RXxonp+H2yU1qxeNvtXPvNhKfyQ1cP7h8Yc=;
 b=XaWe+DTPPHRJ+NI0dEX9hixDQiT6skWiYX+pWQSojESV1gpl9OsjMEFgUlqiVt83ryrJtKUvchP5ba2lqC2lfF6fgE5JUtPs4Pe41BhaSHY49OuRBNdzWEzSNI3sQVgak9x1Q5xtPf7YfXAfI2V26anCEDIrMcsE6aRIoq9Kw6U=
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by SA0PR19MB4572.namprd19.prod.outlook.com (2603:10b6:806:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Mon, 23 Mar
 2026 17:45:13 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::89) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:13 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 849682C7;
	Mon, 23 Mar 2026 17:45:09 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:01 +0100
Subject: [PATCH 06/19] mount.c: Split fuse_mount_sys to prepare privileged
 sync FUSE_INIT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-6-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=5227;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=L7SMtBpwyE2CMiDZhXQJDH5dSI8klRpEt1u4h8I11qU=;
 b=dlT4+MLAc4jHuQD0FbC/3CJNk2wF6oxl+dDv+wESdmlSoT+Id2otsxtZsTmv11KnqYLTqvqIR
 eAT31f4F18UC1TZeAa9a1ny0rokRsa4WUbhBClvvGYZrWWG7gS8qSRR
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA0PR19MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4b4bf1-fe7e-4bd5-3301-08de8903efa8
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|48200799018|61400799027|82310400026|376014|36860700016|56012099003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	sDzraOr8uE0u27GYUxom0+/iAomqhPwiUBxPM9oquESUYGksuArrZyJ3yawEiM/3XGJ+O9+0b7rnchLK5G/dqo/7edWi9oyx+uhXTtG3NoA0es89OEBDZxVJP7E9BdhLMmT0RgAGJAdEKtCkIUu1+min6RU0T6Y+uGSiODB7SrNskcMi/gLIsQZZJjDzdBphuaW9AzB/NjiNwNFdt+v7lveJb2Cianqm1WcJ5mQmA7rN7PD0jbx5X1Ou5r//E3Malp27wfcxzb/RWFdI5IuOItOxu7c868ch0CPEH9FTRCdYnJAmf7fcwmn9Z1uJ+BHZeTtP2N/GQqbkQoTzZ0o+SImPzKukTDi3K/5iuVGH5CJuIYjrbhQOBTsq6OlCOvHmE5hhZOh8Xn6AxwCHLyp6EwPo6wwB/r1m7CR5esHP1tnThikhILl3A7LSI5MnFs0MPW9XWUXAmE/1WUON0U9wd+4Ke+Pfs+p5mD+7Hbn/8iEKTEFHPIQPEkwQ9zCmcvQo3lRD6cpVtShqnRUDhKLM7onXhefO/q0TUok9epta52IJBvlHqstY1qXT0MHPLnBTcywO6SugbQlWiFtSKHzYLciyWAKWqX4fw+H8NPvpoCC4XjuxvF4x5uarC+yuDfsff2jbnOTkV695544vRXKXzCSD20BGjUlU7QVdWOfzKlq3BAQAIoxLhTrwOBtVLKiqoayfLpsXz2tFC8WPll4j/uwaBMwU/YjwXvALEz5lA9CLW2WLxE4PGnfiISomA7bLBl0CzSdZDaRAoSMv4WDPGA==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(48200799018)(61400799027)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jWiKym6qkvoFNO7EbETCXgo3YisEdT4XACph1wJe2eL5RhmTLKQBZjbWuGz9BoFHWuOkNMS8tS/hvlw0VxMkZWIYEGWd6WZFh7wLq23ng4FyGhUqxGbj/eW5xLhhuJQoHlriIH5cXfhqy0IpHtEI6QIzCtykcjDEbo/3NLbShm5G04jW7jmuFDMOMQ1a8bBCxcQNtKeUTDtuWx+NyeABLu6PXfBHLC7dREI3Rq4HGO+VdkuTI2CRVxiFvCz3LBRHBkmdUzmHXmkQ2lt8bq/SQ2QT4IP1tivltp2uxjnqywQhz2dlbho94m2CEqHTsQ3fSsKz/DdiXwhi0CoTNsygOp1xUykJEfzCdfOJJ5QdSq98UN8vcOc1cKGkPVOBMOZtCqABSZZP6NEKvdzPsS6DKC3F0EZyLHQLltyvps7NaA3jkkAyqD+4+vx5uXOfaLu3
X-Exchange-RoutingPolicyChecked:
	NUiQ8G6Wk7PMmKMY10+gZm5dS+bU9Q+qkAbLMTnr9aaVBRV7U+DMyETFZwdVj7Ff16EMfZ/o0DH1CSl5aelEzPPSL4B9w19yhh3KAYUh44lRJetVRiwBz//9sPtsfdT6+9QmZrr2bWP8DJYC1O2S3zlhW/nmDJuI99pgFD0HDq3jIaZB4GDKh5tkXt9PesdXwu+SMdP+crPFPtdBWx3Gs5PwKJ+fRa97PjxMh4ocevhQDicv7ebHyClFkGhzOcB2TaxLXjeRKNgwV0HIkVI2LBO3yRHMn6zsChaTgT4CAOU0uXENGqdcmpyhMv5IKGwsJQXZ5ulupiuQj9d+zAihcw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TefBUPOFUMX2jRAB8nljxUB0LGN3dB75dAfzyOPqhi73D1POHwXrTXPl6tr2CjwP+th5e3rnYN9nTV5EkyOQ7Z6Gwzz3AsgS/WI0j94Xn8VGGZ/ccCME/yQOZRT3l/ssRCH1LqnUUg0NaXm1kn4cruzYQVl4rm0AlDrqNxHq1pE/Mzh/6ifDOKG0g1dxPJ+QNqx2PBvN9WookEpq2z8QobzrDRBWxU6hJSuiba0I3WmNTiSyh4AqXAhuKec55m5ht+hxDky3UwjWUdJvsvKI3ugSbE9942bo8ALXCyNnkaYM5B6L7An1yLLx96Ksmtr+H2nrB6cJPh1ehFIrj6mKXq8mTQo0JflrTnUnL372lBbJ1ChYUf9TuYJG80oinnUkIIkOKmcb3/HX+qetJM6cuTtiUeM1eX2eij657qwuH2VHFIiK940uez2xxKK3M7VeT61n3WXeTEQmmrdfK7eM+Ui4wfJhXkki/2JzqMbYy9cs7IJJK5qXTLIdxNrb8xi7qWQqXop9jNPektrmk+qPa0d8pRXTWjmqfWV+xsgGrdKuNO9XU2RNMSu+IwZ7scKVO3qyD9VlJA0gsDxPrsd7dm59B07v/Y1Tvqiglc9anw+/04w8fi/Cf2SWq8OM4VjjWdf5Kyb7zLu80TUY7iPiLg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:13.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b4bf1-fe7e-4bd5-3301-08de8903efa8
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4572
X-BESS-ID: 1774287916-111966-7716-27688-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.85.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGFhZAVgZQ0MDILMUiMSXR0i
	TRxNTcwiTFxNDC0jI1JSnJzDLRINFMqTYWANwI+iJBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan15-232.us-east-2a.ess.aws.cudaops.com]
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

