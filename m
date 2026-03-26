Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9E3A7840
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560913; cv=fail; b=izo4nhiGsVft0bZ3185oPiY92BZBh4RXLzdVd9RKWuf270M/fWvT4anNsUR89PsDYPs75uskSCRuxmI+0y8d+qXGjVbAF92dx8z1Tx/qp0zTcE6CQUcSgXjTxOTEuahbUDYB5zY8ks2TGlUmLZNyGVfjZ+LevRrg9DqNB8/Irw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560913; c=relaxed/simple;
	bh=ACX9U+bTOiJ0VPLHJk5jzreJTIWhlsj7QlgSs5Bdle4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nri6rxk01IRtZ/kSgLybjpztXEeyJ5wdUuPnxMlzn0uTO9+EJt33NLMxOmAQmXM8RcmA1XGisCTgjLKTmdIDUZ5Y+89JxCq26J0Lhxkd/SRkG+SQ36aS6hTfB/FrFXpUik6FZumqeIHqARwtG0s+rESl1T3CjMJchduAOL8j0f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=vBzm7CMj; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="vBzm7CMj"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020075.outbound.protection.outlook.com [40.93.198.75]) by mx-outbound14-251.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPGY9chDoZ9SnDGQBiaN0FsTWFNNvMJhbSvxv7Rupzw+Bpx2tvCC7l375lP7jFMD3D9w2iZz3+YwGcKQ72MXoNhGaYqfQw3BshbCxYkPCimMiMAMc7VK+SKehSD8Q5CmrkeeIpbDwOkEMXCLBVmvsPBKJuup3ryUorgpxnST7P5rZqBsswy5erOjGuIoiP945fI2xDh732WDnHnibAh+xqedS6DBAb7HLteYAfjyb8aTnpTUFWK37rFqzUwFdeBJ2FC2ZXSUV6J8njy52h5YV1Qd0EhpQ+NJCcPl8vVD35WH5Am5g6P2/ZndAHIinYoWQ1LN7Z67X9We8Ld2/Qavow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI91b30sFeOPgZdO6wlyKe7ZvXh2GH2SmdmK9SHXems=;
 b=JRaLS3ztF/NUCqyEwQlysFm9Ld1ntGfUA7T7PeFaAlcSYvPiGt8BpbIX9yXfL6x69wIfdTClYCwgkO/mLPcDgHSe9Cc9YK4hGEpina6pA6xsjo6AXu9VDYVdz49uUYiRXySi8mRiK7IvNbsZKUsMslih/lgNOn+IBY1QGfk46YN+8UlQRRXkePaWP/3domwWxmXjfm5ALA+nW7t+aprsCLIi3w4ISnKxcfyJE5CzmFgFX5zLlAi2ozlWoUHkpGCGiB729JniCIKkoDLMk3gL1hCRlIYDSXoBVo2eVHXHfnoMHkWoGGZze2ysdm27UyXglSpg0c27HjaXmMCzLLEQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI91b30sFeOPgZdO6wlyKe7ZvXh2GH2SmdmK9SHXems=;
 b=vBzm7CMjOqnGxxrIw8GwdCcz7TLglWf0/TCPozYq8Q6Jy+7h1/w/HaF+2GCUr4tCS+NclzUCurDTCSBjBxdpt+Jd0lqHoFq7a8qPfnpfq0CXSpCPfT/x4SBWkhGPdVwsIJMdmGp7cPVmJrGb+Pb7L1ywn3UZrS0b4gXuIj+nTrk=
Received: from BN0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:e8::24)
 by SJ4PPF094C96A68.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a07) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 21:34:57 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::ce) by BN0PR04CA0049.outlook.office365.com
 (2603:10b6:408:e8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 21:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Thu, 26 Mar 2026 21:34:56 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 18CF990C;
	Thu, 26 Mar 2026 21:34:54 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:36 +0100
Subject: [PATCH v2 03/25] checkpatch.pl: Add _Atomic to $Attribute patttern
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-3-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=891;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=TA9yTqMRJZXCl8jVYkqJWwhXi+9H1lQ011nzleR0UfY=;
 b=liGrON9h2JU+vwpHho1Xl/nECiLj6vZo4MpRHFfGWncJH2UgUzH0IgWm0R/JNE1BzDoWt8Xh5
 E+6fH27KFf2C16oJnm6S3/KaTcwNIry+vuNJnpWeZrlkts+87DAV0r4
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|SJ4PPF094C96A68:EE_
X-MS-Office365-Filtering-Correlation-Id: c0eb250f-da65-4532-ac46-08de8b7f863c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|48200799018|19092799006|61400799027|22082099003|16102099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cYqSJDASiDPy35kl7g8vt27q+Luq0BR2drxqn+sIeoZd+FbCH+/8WD+tWbwo3h3qglhqe+zy8lMhuD6CiAJJkHO8sRWK4AINCxlwJ9hhx5uXELXPYxChP4tBZQLmBR2ufjmhZ/3IA0zJQoZC0qD6h+qFIXJuSRt/iM3cC1M4SLQJfd7I4mroR+Xtb8aj2+hl8r0HHWFtKlrT9dewkacNfS+amk7E6JDUNHEmmw2vtE3PPi12xOwGZjg0amUJHVNcqyj9nxGHGFn7C0yLtZPSg4UrAoziQrDobsko2pOhUE0iPrCeXlcbcoX3vlScRZ1Lr8wxchhfN4KfiJwO7sCugH33LbrjS1Vs0Vwdmu7Xu8hSzkBnNjJjtkcnOlNb6a5R96gNsT+SoxEp7xS/3b28jT/EjA61e6lICHHL9bG0ZKSdPY1l//w3SSMj8jKeDD34lwPwokJft0NhjMZezR/8N3Gg9aaffX8Tp6McGC0rLRzNmLSMFDgdHIUV3XEscgQ/kJp4/L/cwPvPQ/n68Dd39vyF1Ey6YPSYW+GRrDs70ntq87j6fdGb9xVQA79qO6qkIB21W4tgL4kwQ06zTPV3NxF+9CCJFAEYaynQXFhN3PZX3e2lgXLf2kDgnJVHd5IdiwiHZ0mQaX68CjF7GDS/mUR5XQZeZP71+8hu/HGUnr2+WWxt9IheTMsal/E9bDTushA6n0Rb90uhETErum1RVusp1QIeRF6yb7Hhrj0t37jHqnfuwWWDUqvcz7lO0huiojOWHamDE15/GbW9Ra16LQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(48200799018)(19092799006)(61400799027)(22082099003)(16102099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WiUq79kETO0Hjq8/TXyeThyDSyVfkMeAKv6hTZo1ofE0Izeb0MRREy0V4qMBbi319vsh/ZYaq+PQRL66MrB8dDVAJaXiPYBkC4QqYwm0a5H9BJrb+ZsephhLTX/3IcqPpoFc+fVpy8D6l4xzsIsAgw0rRhlDEwrOMYoRwMYkPG8fI1PDhQgLQlNvvF97nPOaa6d9cwrfOmz3DFoJf7fOh8dm6+k1SravPiO7cqlPPA0ml5FFi48anLQ8XfZS8UGywXSJUoRtwxIRtrXKSp4ru6Pzvkvz5BIJr9BnMEC058NTXOuOu3CTEax86JyLOXyX7hXOpvK4d7ebcF3bkD87Q91PVz1yXzidQvW7+/pHW3e7pm13S5r3rRCov0OBLAUniknBflZIbhlPe86U4Po1qabiwMfn6sixdm+GeEC8Okw+igY4GY/r6sXo/+Z2iJUg
X-Exchange-RoutingPolicyChecked:
	Efv1N4UU2DGqqfRtCkC+wUk7maqUTeuk9dG2i9vs6VL2WvhH3Qk6H5EmpEsQt66zP9nTXTp/1gL3fpKKskmq/Zk3Uh5JRWvE5Wpuq/96UfXHQqQra6zuAhC0YzjfenzlL0zyaN0Rvm1WVbPwhm2FryjmI/GeGkA2ywh/BbwU1XGho2hMo4K1ZkA090UHjI8z0A8ExpwUcpwgTrOFVKJZ1eVADzYFdVkU2kpht2CZEi6S+PSSAtnoUPHKl5FFESI+g2Bw4rCN1JPi+XAVucdxdLpZ7z4jn/2X3G1GysXPUPWSvsucWSSudje50TLWT27a+0fHz8dxnopRGPwbkl9L1Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LkkmmTvuvFRobvHUZryimKrxSadlNf31+sWlE9T/YL3uQNHyh9+kzGtv+y+ApIbefnrtgxfCMoM9LeYUP+B5sIHTUABJ4fCySQN9cRBcnoHdNpMuIW8ww9AZtNh342Emcurbi9WNNl9NaxZTqbwBk7BxIBv8+zjPVXyY8LN4VRWEZycRNBWKZUCBufE+NJ7gsx3dJHyDNKTyTFI1MzGTbozNsjS4SI7wzXbaq/F0OOWAzH4SetEs94cKAU+Rhmtr60MHrO+QxkeDKrSb8B6ZOqy9hDYJ93Wbvz96sKjG5dyFujFUIP6M6uWeATS8vrKFzQCqGNWsZ43KDX26fxkPMYxHzuZcBUlvMRQX9jbsHW1NaI1ZFGwtLg5ugKds63phQkndCgejCn7FN3eXiehhSGudJmHWTTTXtNAPVnEkcjfzN2HvoRDsEkF8SCPq2PepumYFsPhXur/D6m1HjpjyjJ+lRGdozkRmoJosbnYowPG2Y6kqjF4Ny2LAt5l4J8qtLgGQkjXs7gRpXpSD2LWOb1tlbDcC1xXReMIPetQNx3v/6XV5Q3n39nEu/eiTZ5gnHKS8sIuX3ja8/9lfHClo5ELW4II+vC/LqU2PmINRGtNDD5TIRhKY91ChNo5yx0ZaIaKR+D9RYPYU3wlh9kxCMg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:56.1027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0eb250f-da65-4532-ac46-08de8b7f863c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF094C96A68
X-BESS-ID: 1774560900-103835-7683-3087-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.93.198.75
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYGpkBGBlDMMs3QzCw5KdEoLT
	UxNSnJwsAyLdUgycLYzNDSMCXVNFmpNhYAVphWG0AAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan23-86.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

WARNING: Missing a blank line after declarations
+       int init_error;
+       _Atomic bool terminate_mount_worker;

This change should go to linux upstream.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkpatch.pl b/checkpatch.pl
index 9eed3683ad76caffbbb2418e5dbea7551d374406..2d44e0e6edac303731c7637de00ed35d7b1dfcb7 100755
--- a/checkpatch.pl
+++ b/checkpatch.pl
@@ -520,7 +520,8 @@ our $Attribute	= qr{
 			____cacheline_aligned_in_smp|
 			____cacheline_internodealigned_in_smp|
 			__weak|
-			__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)
+			__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)|
+			_Atomic
 		  }x;
 our $Modifier;
 our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};

-- 
2.43.0

