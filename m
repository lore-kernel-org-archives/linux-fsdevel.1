Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C43BC665
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289930; cv=fail; b=OvnkWZtRu7fC+ySo8BzUPbIfLILBjRNY7bYtofsxilj5uDDE72s3b3C1Y/+lZM9VbOkeo8FWjUREmnII9+t47o4ufnjanh3GPWsYAcRfvYUOX43VMumIWtixXnlj4jOFbS1z01zcB2OVy8nzt2dTxnNogF28KobVYTqZZAh5gWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289930; c=relaxed/simple;
	bh=N6qSp6SCw0B4SGnJcXYJl7YnYUfyWBIs3/TR8y8Ad7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/OsZ8vfNYh0xcRt5hA5TWyP0/J96bobfvh/FNeQFn1sd1fRGACMCfVsZABBldxADgJSQjDNaXjFkQeEY7CK5HFaP8hpUPzNi96+m410BNUFUyVBARGcYQAon5DLyfsgaBA99Vdt/YdMtwOTbcCgM4Px1KUBVkTjwokF54pm+h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=bSbJkIPM; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="bSbJkIPM"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022120.outbound.protection.outlook.com [40.107.209.120]) by mx-outbound43-62.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSxW3UKF6uZifdQvY2iUyg9xvHwr2zTAfC3P5q4rqlNaUyb/cp/pZDCehOv2SR5au2El7sqo+MmudLqKyA5h+eLRvwmto71DKNpxp6N9R0ou1VbQJtA2VNSfQuBRSTDeZwNreNF6S6jb7LqPA/RiXrXiWs8fTEPeypC0T3arcU55GXh6fXIkcwdvbbvct9ftuVIIxXEoX94w/EPuwiSyFLRu2nrubnDtW+W1Na/Ydk/HxyzE2v+rxQLNjG+DYpAnlnAFZPbJKhIH/36kadSA1PzlRF6pnh2BQS2dD/AITHBzEvkJv29yv8TzwZrRJ+EMNJ7ll7zEMvCamDBClLxoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVM3TYfm7iBEhp5V8An3P6mBSZHSpfBl/nk/hA2nMKs=;
 b=Raa3zfRPwUMCazeYmABSAdeQlEs0DnpvMbVaYgjLSZSjDEwPCPSiFIq5hlDi7Zih6SS8I1TmOYASNFZ50VS+d2iv7zsPpRtO76PKYQjwe4LLeK31467PvOII6HFy1efMGR8p/yNm7UJeDZAB0ZHO6+V38SzWHk/zr6cdY5F+oVhJwcRre/zcLiLzuQmS43ujEMTU6lYusKDvlXaDSfHdnA/uhrYZLxuwJZIsdkF44v63UyTAzGXK9u+r7NH3dxo1sXXNCu1n5vaywfMvq5hYprQiTYnHsZlmS17H4v/Nit+vOPjYxNdDbgnvOhZSx0q2tU9BLjTGenBoJbomIsb4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVM3TYfm7iBEhp5V8An3P6mBSZHSpfBl/nk/hA2nMKs=;
 b=bSbJkIPMi3cOqx/x6Z+1OM+VkAo5bvXgfcorBoNgCH6CHnZFFgyDiHmzWwzItgOudUR98m64bNQeQHfVtdGgcKRl1jEphVb3da5s6SyN2wii9tQ0WMhK8agll4tGbpuUHPlaT+k+kBzA3c1GrpXxMub+A1YdrIzD8H68fVXnfyw=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by DM6PR19MB4122.namprd19.prod.outlook.com (2603:10b6:5:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:26 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::b3) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 17:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:24 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id DE7742C7;
	Mon, 23 Mar 2026 17:45:20 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:13 +0100
Subject: [PATCH 18/19] New mount API: Filter out "user="
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-18-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=1443;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=3CAtOt+qc2XgaFp90Ndl4Ne4a9a+PwKr77uKFLdqPO8=;
 b=ghOxKZuFvbhnajnO/tn4daiGEHSIxwqtiEeYNrGZdcFNjzhvDV8eQLqsHHgOkLvGOL4kCmiff
 ZiG0fL131DFCiZTqvvkgux7cdGv2pyUTqWgKHusOpe/GjKK4VjzLR2W
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DM6PR19MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 082df095-3987-4957-0776-08de8903f679
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|48200799018|61400799027|36860700016|19092799006|82310400026|376014|22082099003|56012099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
 gwn1eianJ9hqOuqWmg6FTgPKt0fISDLWrP9SlvX3rYVOUETg9n2oRFtJJ7datMmkzwr6cXj+fn+hMvviREzJWvq1F3q2lNNirAeWQ6k3nqcdJOP9xmRc8oqhC8m8QDh/52uoQ0gNiiBdX+/8e7skcz4oRlqlXmSNZWEb+JFoH0QdcLz3Bmr7SKfylna86k6JKTDrmtbi+SgGOULdryp9SU2aPox9WrsnSTqQ21DORYVeTiWhfI3K6GGJVrVoJI99zGWtIoQ38qvfSHXoupZ7XeFS5hws1HaCMwFuN/PLchfBUDCufWEsLKvgC9qnI1/8vjZ2AhkjNSw5G/jHa0EWBdJdrv5K2qQeUUZWh1XfN6LBdmFLGUY/dZjoL+KESFas4x2GFhQ5L5V0cpTPD8h3LIYDh4GH/JRGF/Fhey8xRXBHbHUEUGI+NGakVsPyPbTF1aG+Oj2vLmFmBbmis6KADv91+BKQaTIEkCqCAy24o8oyWjm7bo7a3EYcMLHJUBHv9B+Iu3G6ljMlTlyVCy4F5kT391b5HN+melFmPQxefyLaBBG5P+fpPWDCj3412qPt/WGkHIwK3xVvx5+MA8cJlxsyzr8bw/up1OkSr/+OaJPn8fF5AcAUNqE2lDT9V1ayS/cBQcTQFuF8DaI6cuBcVmKbiAo6+jNCmphx4OR3z/myuiJ9O2iMKlYtUNqEDdOjJmU8S2s11/wGJGCkklnhe8v2SL1aMW4iGAqePM1xPEYXNLBTH8rOaLc+roCQY+BFgd5uWny2AnhiMj0TH/yukg==
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(61400799027)(36860700016)(19092799006)(82310400026)(376014)(22082099003)(56012099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 zqxcwkdmiaJUJKUoHZ60hvxDVqSrzcUW/uC6NpxoEJk/Nr4PeMh7jL7VYLFQUQFTtNVxgxV2IxPn99J/O0RuGS7sLUhgm4kRHWJDmlW5j4ARhoUc/kj+0M0kA1C0/3t84boCIiFgtY3UQxlK4wnLLoQMXycJ7gTX+/BQdx+1sKXQAdydodkVzHxv7Q/MTvDkdBL9i2pjNKuqCQY++wPeV5FWdfsNm1Q5R8F6zjmQjnLcoOczZ8Kpr5uNCuftUxzt4v4NvgZTTzvZQHwEI31sP2nNCH0EvxfXpZbQy5V1rzMhpojpDVOY/zEpxQcxyZmou6lO4kPDvgYzmsNEwo97SMR4lrgddYSsjkCcvUqPOOK28GgX8nBqYaUTNofnLwg6L7sPFhAOs0hog676JI7PnG/h4OmmSFnMGxSIcqQ/fdvBhCZtG/7oYkHsXHUezu3E
X-Exchange-RoutingPolicyChecked:
 azqYAyG51z34pYueg/XjREYFEkoAokbGdpj20kGf+EUqvNujsMXtk8flwMV+CvB1eDzrKoGesNLlhuAXnl4t9rfwqe4zE9qXTb6mGh/vGvS1OZYv7+s9JO6E8BDkbCoUaFFiKkxOnHQR4UrLBOj3GLMzve06lqeG3HekPxbTsDIxEwdr7YUDi14xpSCo5uV3vAmqRxKjwziTRAJmb0CUZb5RMz1Hk3oZQ7GCmo4yAFx9SsHPxYmYvFm02AUetdLNW0BRWpST9i67hnG4eMTDY+m2zYiKcmkEBa6IN9TrJmjJpihSLJoShNdWNqCbFC5/JtGof9wnJPHFFJdh2MrKxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 TmLkNTaUnZGJn6xPvngpZDYhZw/coY3idjzHN3rg8NonSW463ihEVyZiEQ5N+YjsEGXW36LgRd/TMIJbYJexFIZlK+pfCHnN2YP9gIeOhlOIyfTUAJ5TwMwC1BCcdJexeWYoBumWUSoEB9TxD/h2cq0zMrP0lSW7PKGdF8X11tjNBNIZYa4Kmr5pc3WTZenMXA8vejPlBR5SHoT72VSGJO/m7e314lcNTbY4dbXKo5Fylj/BkKBDSInJNWp+xsrj0fRVjwtA4/8zaOwl5aESApw978YbefFtnngCxZXSUNSj2rddwqNPeVfko8FeFSNWX01t4j/+V7EevEOSooJMRj6HUT+ANsVuCvpBqF7zzm1vzxQ/p/R2hpoT5IHYCRnc41DkiCxHs2GY1Pby+uYTohuwaAWYmNfz8C8QNSAWakSREdICXTb+TXaUyXNKrJ0+aybD0rG4k1flyZxstw8nb/B/O6cd0cELUkdwJqL0vGLIe2zJ50hFHQA36ZHnm8Cf+YQ4S3Y8RDKgBclOqceMN9mjFFr0cxI67JRKsU5R3EpgMmnVOjcoNv8C8eS6ZH4BfadWIXUhV5HZAbXN1Ai2oWdhtRHtVgxUSaGD2PlVYRiYfmo5unBYvVWR/oOsCqGuQe/c1AgcJTQ1UDP/Wz0SXg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:24.4730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082df095-3987-4957-0776-08de8903f679
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4122
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289923-111070-1175-8971-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.209.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmJiZAVgZQ0NLCxDQt0TzVLN
	HSIi3ROMnQwMjSwMzCzNQiMcXEOM1QqTYWAJbi641BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan22-34.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This gets added in the fusermount process and kernel then fails
the mount.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount_fsmount.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index f1fec790bb80f8815d485a068dc7efdff1746309..76c14cf9a22465160fc6b206ca9b6c9e7300adba 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -218,6 +218,16 @@ static int is_mount_attr_opt(const char *opt)
 	       strcmp(opt, "symfollow") == 0;
 }
 
+/**
+ * Check if an option is a mount table option (not passed to fsconfig)
+ */
+static int is_mtab_only_opt(const char *opt)
+{
+	/* These options are for /run/mount/utab only, not for the kernel */
+	return strncmp(opt, "user=", 5) == 0 ||
+	       strcmp(opt, "rw") == 0;
+}
+
 /*
  * Parse kernel options string and apply via fsconfig
  * Options are comma-separated key=value pairs
@@ -241,7 +251,8 @@ static int apply_mount_opts(int fsfd, const char *opts)
 	opt = strtok_r(opts_copy, ",", &saveptr);
 	while (opt) {
 		/* Skip mount attributes - they're handled by fsmount(), not fsconfig() */
-		if (!is_mount_attr_opt(opt)) {
+		/* Skip mtab-only options - they're for /run/mount/utab, not kernel */
+		if (!is_mount_attr_opt(opt) && !is_mtab_only_opt(opt)) {
 			res = apply_opt_key_value(fsfd, opt);
 			if (res < 0) {
 				free(opts_copy);

-- 
2.43.0

