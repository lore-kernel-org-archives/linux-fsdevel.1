Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BD3A7840
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560921; cv=fail; b=EBahnde4dkGvZ6dA2BNFjTb9LBfmKb7H6mwDjIIxwjN8oXByKgx4CxqNDlNBTeuZY69FMNU28r0rsq60RQPWXizXZPUbHgxuD4JkOpPQgvwO/8IR6n2CHB6f9hCqQxTSV7IE3XlbCyM6jfDzbJphqE/G0lQ2Bb+nm0oZn+JELwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560921; c=relaxed/simple;
	bh=tc529IdATPew4l+Ue9/dT0u+fUr0QC7iXLnnbxNKheE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Swo/HI1ENyVIOI/p7oKfDVY0DxAUt84OyMEsDIRGSJuuMaduvV/QE+mmXeuEdnjQrin53+bLq7zyC9TqaWcsUphALA9LKt3fYVwVyab4phrrYP5kkvOe/cErec0GGuLyBSRwioWqS7LXY3LkWvNmAt0Z6qwd/rmfK0BS1vnzOjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=ahmaFdYf; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="ahmaFdYf"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133]) by mx-outbound46-7.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgeK8I92sGS+daIFkYqTRjFb48MKQVhFZ5m59sy0ulXxLX2oCdLZUmxvsqlDHnptDsrvDBEoelANdsDIVreuKD+zHLakyzRXuxVPbIjudoJ/iIFZ1dtnsxEcxUw7W2Tqs/FX2FlLdLTcVKnSy6DCeSXjUcZ8tWhcQmVkrQmOd80aH6fE4RNFflHFrqxdf9fAu49BddkUZkrbAm3R/b1avibxx0KH319hEEMjnZIMSRmJgvAaKpL7xMxS/Wz6jxyt/Ia7QgjaWqKx6Bf1GszEfXd7FGv7QW44kG2kevSoqloJz2hcQa+lZqoX+l72yNVu4l5JIqhaRwN62dKwcEZrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yATDLKIsBigXbWowSqsM3RIZ0zCOijzvH74UDPyeO7I=;
 b=cfpHHidd2HGBEnvZY7vZzKL3Q9OMzGAvQlbJ+uWA61UCckdJAeg63TF9fjBusP+nTFwQW6TslF89pDmye60SiOiZc/NkZW3u7b18MQkn92XCAQmI0Oda5Y9q5ETr/JgwXQmu1IcTG/cmwG71zDo5M6qcMzrBOq9EU452/f/MsT/gK+XJehPeMMxsrwGXMsGECv1XO+6+IIVCiCab/4M4xEyPvUu0kxeR8pCTw167VVf5KcEzLzTWBUWAH9XrurVG1vzgnAKa4390qtxMTPcrpGo9l5xLhto9iDL6qY/87r/HpmnT3j1dFTRnaUFhKNvi9EGRvyRsJEcPJG8rauI8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yATDLKIsBigXbWowSqsM3RIZ0zCOijzvH74UDPyeO7I=;
 b=ahmaFdYfomCLFEHtcQJfENto3RLmwfBEVYZO8HcdH5P+yA7hj6+9cOa31aLmhDnPexMLanIdqk3Xvv495U4D0wbeza68GxPRoyPowvo5pRb2vT4qKfc+IpdTBIP4ePlRuH/aWCrPo2VQpakALSAobfF+9ZQ18ZeO8tvGpK2+s7k=
Received: from BLAPR03CA0093.namprd03.prod.outlook.com (2603:10b6:208:32a::8)
 by PH0PR19MB7357.namprd19.prod.outlook.com (2603:10b6:510:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:34:55 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::93) by BLAPR03CA0093.outlook.office365.com
 (2603:10b6:208:32a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 21:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:34:55 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 25C199BA;
	Thu, 26 Mar 2026 21:34:54 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:35 +0100
Subject: [PATCH v2 02/25] Add 'STRCPY' to the checkpatch ignore option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-2-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=1467;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=n4SRGqx/UGama0W2OQ/4miC2P8JZ77BJGEjZ9gi2QSI=;
 b=+anqutIO9vxD5QbTvoL1RTzBQWl8ZRRqz2aOhhOEKx5kGTdn9JUzvsZYYpdU3tu9HQLl8wWaR
 IVEF1IJrCmTBnCh4011y4IC9ZtBtR7v5TrsUenvOoYyCDRkAEBoXshI
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH0PR19MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f40795d-9681-4c80-ac43-08de8b7f85b7
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|82310400026|376014|36860700016|61400799027|19092799006|56012099003|22082099003|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1BIcSyKbgy/R7mAOcQamPKgsr+9xusOPYvJezdnWvOldM365Jj1IIQVzTpWsOqtHIRJ8rGqouI9CsWDxqydJaZvapvGf2B0Uz77PlcwEekK5twe2jl7IGehOr3B6H5svJPmtnoMV651n/XPuaNoc8/sEPiUFOSuIypbfYPqCk8MDIM04sfjENwMfEb2nnhT1/pFdzesT6r7D4zmSKcAKovAjRTiCflPS+4bvHhZUiy2yIzMCDk+DCyvgSxs9ocqGz6RG76a1Qtc1taL7NqP3AEIpWoXD4s/oN/L54hTl6TfE50zrZIVRUNN83jZPZahyeOJbWGnEp3NDGwQSibcnHZPfwMilIMa2dN89tLHoZvyNPgBz9Z8EWentsCHLrKHPucCoSR5eo5h4cT70nsW7VnKY6Ww97T6VlehvQqfmef8uUy491Y1sDE8KFZ3bNKWVhnZiy1MtjhkoD6SZe5ZmAxcZnGigunPx0KG8hZkde5mNa/4Q+YSrUoRYuDW3/kT3f42hp4yIL5XMHP9BqDUrtZPW6/jReUDUVYrdm75fc6ttMyqEiLRSCW7aEe+o5V5kRqMhZoaG4tO8Rv6GwCtx/CzJ3/fWr5LVevsFNDVXCYoxfDgy129MtNs5vsJlfNb/WbjIMwQDd0OQLHfWmx0gMh/h5pIWNw13dQwKXSeJPkodyBKWZgpBCFDs0ujFpjD29+3eOQCmLdwTzjaJdKjoSpMsCBrF7lNLu7SAKHnlxv671M0izujnptMAcVMUo0q2IXrGMhXvvnP9dCZ3VSQmIg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(82310400026)(376014)(36860700016)(61400799027)(19092799006)(56012099003)(22082099003)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZqBvhY6xTXP8ehnLweSQbGGEx7eQxwZ7iYtXYdgPqxOX6dMa6nn6rCNKPFwwKKXnQMP6+0TpXFYGIPZrw20TdrU8Aey3s+qknqDC5FisTip7msiRu18XiZ1ub6SxDvQw3dYjLy9Ifu2+Z+H+6jhpksZT5azJSPA532bjOCC7Cy1eDm6sfiJEH6mLsWd1l0zi2pgb6k5pEjEWQBQXFRP3NXI1P+QkwFhcHoJ1/YN0ptTBoTusNB1W1gyiZ3WJroPq6EfmYSQWarHgVG71fD4ozRds4Sn66XguQp8lcYVC1qxmvSb+72ir4XBlkaEyF5YpPgSoka3J6xzhkSUr6CpPt9ceOeP59xmY4KKw6w8mLMCwWbcaZWJvLqIoL42WbkagQEtYGGqImEj4n7OJ/3YvXTykJpY8PbAx9PHmU0Lqk6ROMH48ifuxKyi5c7+wk5HR
X-Exchange-RoutingPolicyChecked:
	v+oWby5aH00Dx/6UYEn3K/xod0vNGZDzjnVs+Cs0K0rPYiUlI03S60uSR8InDtwwiQlwcUtbZIXUU1hQ8GYqqv2BGZqT3mbOZGq1NI8lqUUUUFbtg4q/6LtxobkS/9jZdZuE33G20zpoL6nlYmmiesFR/ab8oHQC/UJlw09Y/rXtKusQjftPxeXqcXIYnDORJkHMq3+etrgVEW2+uQ/xrGJai8Mv/gA7VwXm2nO3QiFhpvEa00kuxhsx6KiwDQRBYBTCSU08zwyOwg1oYAo3QH1J//fbKixY5KgXymyMgZaPDIsK0BXt+VB3KSt6T0bbjii3fcR/40bWpoQ0x7JHqg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ISp3QBA5hh4langcl6yg8gjdB41cgY6/J6mipxw8FIeWlZmYp8Z5h+ZmfUoIiscHtxkv2Fq3/yY7PqpW/H29rAzCHMfutHsVrCqxOHJwl2B3q4sZC2I75l0BId/eTumgaWbJGpQ44Cet6BmhW5ODxD+ymrv3iDJRIReWYP5ihcMV/xAsTJ37ah5qIu3b2vO5LwQyb4HqFySh063JGK2raAGJti2f2PG89R3XAnM7a2hTJuzv0LKu2RggRHy+Rsfrbb7F12/gOkbjBGpOkpBov0I62IcgORXmNGB6WllSugCy4FX4tb1Jp4Tn0iiHUjC9HEXCj4B+ZycV/kiETFvOadnZVGKfbGg3fvqcYCv/unorU3rWxAgX0vPcw05kC3NK5WbvMVZMu+hj/wI0U5x0FWTQv9NzB1RccKwQuk9m8XK7qonfulC+9T9Xodmxv7R/90juyBGiycBt7ki7Eug3OWrCVKq1v0uyTXlSyob0TvbTfJNYVFZFZR1y3vSD++dfwwCQY2/9burs1zntCTiEnjOnitj8QnnK3t56Zi4bHY9qVMuIQw3+5DPLFszhwfI1BEGdfTKFjnFO6e5Qkeij06n4RMZUoqHG+RDJbdBeUYp07CfMX6atH6ASU1DJGlkfVxIY3Ey/QUkAoNTrEvsoUg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:55.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f40795d-9681-4c80-ac43-08de8b7f85b7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7357
X-BESS-ID: 1774560899-111783-8941-11127-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.62.133
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFqZAVgZQ0MLEMjXFPMXYJD
	XZ1MjY1NDExDIlzTg11dLMzMTMwNhUqTYWANVFBntBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan14-148.us-east-2a.ess.aws.cudaops.com]
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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

