Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7E3B3884
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289873; cv=fail; b=JLAVolENanxqxtuz190B3T3BeXlOc27t/sIFGr2gTT9dOMLOVPADYDyPIhHCKPJs91PLWomw456rtTOJOw93bSr4FN5q6wAAppfxRtfb0t2+BYJ3h9s3/gtYmXPL9gz8KZ983zTlfx+m4hoXcaN3gEqVW4dqZ9dYZTb9Tu7FenE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289873; c=relaxed/simple;
	bh=PqRqkawwd5CNUVYJ+7CoTrjQzLercIY5jh3d5P6Lpv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgAjz0QxRKb+MtEOIbleKeaVsSXgzauH3mu+YoPp6W8TcbraSewdRK9zgoeACIabRXPlQIonRdqtjVrVgGJyVekBlGlxafPG96GmCCroChIdfzBzLM6WhSLqu5Sawopv/jlkSCKeZCFdYdZV+O72f7ruqOJKUyJto3hlf04A5Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=K0WCPn+H; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="K0WCPn+H"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124]) by mx-outbound40-145.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nq454n9FZhvLb4yd0+51y2MR5G1n+QwQUfVqptU9jDDazmWIsSTeI1Yi4lAiglXv9oc9HwK0ZZin8CM5YhxWs7Z9SbqakNuz/FQq6t+FYnXJ67BNu1NbkVntRkxdrAcCOFG8zoCnQJHas69Jsl9lDdHRNb7EwCu89cNZdQcpl6jZrkd5CONQFJfftzcmkD/LVnqg6XBuN0zTiw2IlUnq4bWYt8j6ZWBhd4IqxH0dIvmsYz+nAyx2NQCHc6OWK0+pk8+Y7IKvJ9EUjo50ADuatGMn7pqfW0wbfrAnVs3VlA1b0KVhV43inZWNyAfN3i+ntnF+yx+efwe/2zd2KBAzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWDabdnw0wPVcsArbxnCjwaXQcnFZAoXjDVRmSpdiis=;
 b=qGilH2Y+FWxZiPoa6nAr8kAVud2dQbIJUwPrvJFWNRqOzNXRSEiquLEPnH6lWcFYahrVS9/x2aEwGY8KywsEVH4FLPY9LLV6qgDDMlwPgiW7cSlB0kvcpMrNtl4njuZNzhQRzDpW9gA19dORxfWSFrPPAJZqAd6Xa4jExR5u3z2xA7ud34AkO8DnmuGBPRobzRU2BhGEXwRfBXRl/L9h2IvPqC0DNbR4d2drhVeBu8DnEbi84gUhq5lWUktkckBh3kDdKLoxfOPoA+I6OGt7cCW+mTKHoTGasZXCWpFSDMUtu87/by1Md5dpeIkYLryXJJnZ8UCTyiUbLzHFpQKhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWDabdnw0wPVcsArbxnCjwaXQcnFZAoXjDVRmSpdiis=;
 b=K0WCPn+H8T6L9VWghnvZY1qmHITmJmG7qyniIMT/XYCKyOSJna5qlWzfq1SXsv30tvKxY87+5XzmtBg40ionEnjxT2pzGYKNrfES6lZ/VhZDLdTFSvjaBXDs80yRhzm9KpFtlLnWHVb5YswJzR2cvIAJoCw7GTmDcDVGHORiO0c=
Received: from BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25)
 by LV3PR19MB8345.namprd19.prod.outlook.com (2603:10b6:408:215::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:09 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::f3) by BL1PR13CA0290.outlook.office365.com
 (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:09 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BA41D2C7;
	Mon, 23 Mar 2026 17:45:05 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:44:57 +0100
Subject: [PATCH 02/19] Add 'STRCPY' to the checkpatch ignore option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-2-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=1415;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=69mD6uT2WlgAUHIryvr936JXn04sM4wsB8u1P2U9+Yg=;
 b=HL736sxwL4X3ZiMAwX0iU6XGUlMbqhTPIRheve6AoqhpFhHS99tzrHLmkSd7EdLnnf+/UujRY
 autuamvc84aBroX/XC/wLo1VkMFwm92DQczpA9Rteo+Cv5baGLNrF6H
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV3PR19MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7577f8-92f3-4c4a-74c0-08de8903ed6f
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|61400799027|82310400026|36860700016|19092799006|376014|18002099003|22082099003|56012099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	xXYOaGObpyRK9iXYtRFDj2DzqDa7GrBEdOaMtJRF33LQZUKlEo/shJsTU+YosU/YE5qKVmb8oB3Wfd2t5iTWSkeHF21Xyfaqsupm34RNc3JUx3NQWP05EHBrfSysP/agGACyQeCNoghX1OXnucun1/Sqhx4Ei0q59mZHWCc1JBcfO/sXUKZ74hCqdK32K90IQGebK2b0G7JuWCYtLFRzN9TwB9dhKP0HX3+lNTnfnig2V0fcv+stxam8OcdtC6rewCoHRMcvR/4fznudsFQVS1WCHUZaAtE741gXKNK6DVCfUzrWDx/LThiyRhleWryJO7ueCt5xTl8Bpg1ftV3mVekQKEpb3RmggysaH+G8TZRyT/oLBqqZoPzP2wqpebwN7NKPAhRF0fMUV07r1GB8uZFM0lPatqEe6eyzd89MdBLPvVoMKMKpWydrJOwrHskLngs9kMDUM9uU3to38f5jCTulpJA8rc17+UqSMyTLv61Ob9doA73caJGcFFfRNNtwTsxQUDJROfOjH9UZIB5pkdS1XiKHqYqfpZROjilDHeExIExGSftJtdnis0tjdQJaRpmTVwMxV8zj7B5425Q4PhsmOmAUol9cY+qhH8TV7L2OWJqdYCPxkdtIMD+tifFh8jbwch5m/0io7gFCzmE0dvcBo4HJXWFxjAEb8UwC0QXQcF2NLeEFlY47Oquq87mYyQGogDYX+qvJ1ZPr+lRyaUJvLPyar4GDRf5V6vFPbQ78nQiJ4mHb1knNKO6ekD7rV7/2mdNfIkwnBllQgtifEQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(61400799027)(82310400026)(36860700016)(19092799006)(376014)(18002099003)(22082099003)(56012099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fZuXeokHYt+GBXLGky/Hw6Qs2YL+H/fPC4USMtS6TCsU37sJFzts67BoHypbONZ/r2slHiU3M9rccFgcV3XBEgqUu+l2tmkEQrByivOiUFhdnNkUMEu407jkdtOXw9LgxCu2XFA5OSfWFgC5UAjOfbXYMX244bcOBpggrMR7ze6iCo755gmYYmTBWzAFvJLNPjfF1vRmubfe3yKJR1qkQFvovWIlFOQQ8d8lzBo8QZ3PIz5sbcOyGUuiBguSs9jkFqP6f3BQxE6ETTWDDmejziXYMQHU6NqThPOqwsnKWLV9tQmFyALqYdOSMFxo+OMGmiY7evl2EnSXESWpRmvI3M0Q5B5GCPIdjUmgwcJNf6ubVMU5tejVNkGqKeo35ZQaZsgi7JxLh7IKDq5Rco+BRBOaeL8iGA9Ow7UkHzsKKtkjNPH803leetJxMU/d4sqV
X-Exchange-RoutingPolicyChecked:
	Hg8qbIx6Vm/nYN63IvsOCw63ZOZs3tQGaKR+MKfkLgcL291KuDkjtS6nd684BrbyM0w+yOZ4E6Stk2yGZJQ89UsqeHSXAyzXuB/zUh8nX12tSjwpUkMNDWOpOgch6HJBC74RkRI2sWiSRy/9fq5YvLaIaYHCaXslKzv/VD/nj3ahatkcZBe9HEJvq7/bLurjwsLOnmhJkO8oYRUsMx0X6V3kJxnjgGWASjYh5ibWZqRYT2gVMBUGw4egnGUPZwlTBHni/VrYP6sQArIhbkobVeBfvDEzXgJzTP8YTCRNefNuBKpJj1MZAkqJ/w8mSRUeKAr+i9LVOX38wd0BhZThNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i1djnoNx2J6ZeppHVi1K1HYs3maNl1BUl5XiasJBsgLonCi6NyWxMZePMxbomInC3+0jF+odxpEztOorQpkHVDZ4qywhUrB2pFw3mYupa3u9idFseJb1z83rY+r/2mLxDQVlI1eheGxoqRQ/b3hm//9DsSInBgt965l08KZLoLxPGlfk+imE84Yorbx/eOo8FRtQyqxoQCACVBp96tcNgeHouYUsJk8I+3ecfAbbUOMRQG03mU8RNEqPSbTrVlbI89OyjaVs0XPTPah3r/rrYccAVuLSEyxoMs6y+pSyU7bSuIs6twCGpd4gsG5hRuaqWyB31SxG399FCAEBPBhpsqPVaqb3jXuCQBt0fPmV+G6VrZvd8hB9q/XrTO31NTJ9Uvs0RVp4GjiNwX88Vq//uu9E8gkCPpdkQIu11aSBLkZymFXv2o4k78v1EShUC5RaHEj+EKJ9sW8eyhFLaVkc/CSnrl60u0f3p+mz39lAcvccwjj1FnhcU2qmiCYDc2K19i7RUwEmYs2SZccQf1SpfBg5y+ZmYI9uU1qiDu+DDw7tEPZGn2rzeO12oO1XZUejoTU/Zp+g/sdEWefiBvAxjLc045AlJwVNTdJC2+4hDfr1e3JyRIRiHM2kaRcA5rakuvCi2IgqYumwI83ZtAF+pw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:09.3217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7577f8-92f3-4c4a-74c0-08de8903ed6f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8345
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289866-110385-595-9309-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.56.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmxiZAVgZQMNnAONHEJNXYKC
	3JLNnUyNgyKc0iJdHIyNQsLdU01dhcqTYWAKeQasFBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan21-33.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_SC1_TG070          META: Custom Rule TG070 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC1_TG070, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

checkpatch.pl is a kernel copy and the strcpy warning is not valid
for libfuse.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 .github/workflows/checkpatch.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/checkpatch.yml b/.github/workflows/checkpatch.yml
index 4a98c91cddeab686c782a1d34cd5d15f86f0b42d..8dead95b065bc81449a98fa7ea94fac7463d2334 100644
--- a/.github/workflows/checkpatch.yml
+++ b/.github/workflows/checkpatch.yml
@@ -35,7 +35,7 @@ jobs:
           fi
           subject=$(git log -1 --format=%s $commit)
           echo "Checking commit: $commit - $subject"
-          if ! ./checkpatch.pl --max-line-length=100 --no-tree --ignore MAINTAINERS,SPDX_LICENSE_TAG,COMMIT_MESSAGE,FILE_PATH_CHANGES,EMAIL_SUBJECT,AVOID_EXTERNS,GIT_COMMIT_ID,ENOSYS_SYSCALL,ENOSYS,FROM_SIGN_OFF_MISMATCH,QUOTED_COMMIT_ID,PREFER_ATTRIBUTE_ALWAYS_UNUSED,PREFER_DEFINED_ATTRIBUTE_MACRO  -g $commit; then
+          if ! ./checkpatch.pl --max-line-length=100 --no-tree --ignore MAINTAINERS,SPDX_LICENSE_TAG,COMMIT_MESSAGE,FILE_PATH_CHANGES,EMAIL_SUBJECT,AVOID_EXTERNS,GIT_COMMIT_ID,ENOSYS_SYSCALL,ENOSYS,FROM_SIGN_OFF_MISMATCH,QUOTED_COMMIT_ID,PREFER_ATTRIBUTE_ALWAYS_UNUSED,PREFER_DEFINED_ATTRIBUTE_MACRO,STRCPY  -g $commit; then
             echo "checkpatch.pl found issues in commit $commit - $subject"
             exit 1
           fi

-- 
2.43.0

