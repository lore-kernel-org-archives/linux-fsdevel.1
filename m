Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71F23A566
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287935; cv=fail; b=PU/DzjPEGAke6rGwt4NhW59GuKi/wgAqXa3JxuoxkTrtSlzoX/hi6dEXJbOMe8XneDMDcoYDqhJnc7ZRnhVUVBn1No7fyysM5iUyKx4N1AlAzIMUb05/3s9rXJH7YNXLKzC1WN0U6ujD8vsFnMJ4d31AVbrrh49BpTHfFigutK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287935; c=relaxed/simple;
	bh=cXZ44B9+qvImed15gqA2JWyLi3KpObs8UP+ZZQ5VGFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBKDeimU1o1tIb9NtYhrO5dTYdnQ5miPgAk1bg6Uh7BtQTU1h/otrx278DtwHMlpW17u+zazCevpiXE8LXfIA+dBP2OyioYRpsSa3AxdQzd3DlzzEbVK2TVC1sCEtTNyu9mVfddta3Pg2Z0LdHIZ7GzWrPs0FuGwyJtFl+U53NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=yN+w7W4N; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="yN+w7W4N"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020074.outbound.protection.outlook.com [40.93.198.74]) by mx-outbound-ea46-43.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+yuy41WSCki3vUVszCviMkIXq5Wd5MXGmRX7vrPUMRI1V5gJGjs8VNIAWRPJmPfS9O9o2cvLOkRc9clM9NrJh8dSY1XkZesDD2GEgfexACVxZQR7Oe9HIVZlR/mIPYqksjOKQ3TsLvTH3QccfZNXVGIBocnQIA2Z3330ZmBOgXUMvhld8/wlBkRKQOpflWImpSDing/mGQVB459pXj6gHoJ2m7kmAwmuUwSU8/Nrk5zvMzDhovOl5A6Fojm9ZGaSNjxOX1N5f1khTJ/hUqFCb81wlQ5I0jbPYYs7vA/G1NYQXFF5TO4pMt7xDDApXfJwDDYy7Qcy8ZZTKtCaqqgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjPb6aF64C61by3jTW1Ef/h/IYQY2Xa0psJ1K0PLi7Y=;
 b=RLEPzSS7hvK5gixWkB/RryRu7djh6FoEoSQrCGajYydl5n8HQd3xrfEZqZO+HeQxu9O+ZB6irI0FQrodR+Ug2bAxfGHT+N381aSEdHad1OK2zhI6Pn2u4wLX4WiaLgRzA1XfgUNi1iTd6gB3HOdk9muuo6cxJYU1MGu8UPrmRD6ejn1nmsvPlOPt+qO5Ew2AYtMRGqzTArmG9KiLpkULknEtzjHbagPjfCYQjriMUGhKVGiGFJYxb/GtNxDVZUvNYBKf+LyLJ9LE6yP4vLNEGlNX1Eu4sYLv6nv3k41xEoE4b1c0nT8o6O20R1vei6AdAUb1JPPxrfT+Te2oqQXczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjPb6aF64C61by3jTW1Ef/h/IYQY2Xa0psJ1K0PLi7Y=;
 b=yN+w7W4NSW3zrRyi++QZsFLUFrG/qS467iInUfNKNLAF48xqnEFvc4WEAZ1EahEKqOAOtnn03s3TMI0K8GUZXi3hBy5btzSYJbTEQf73YEzbRCc0QtKqu5NiL97QsUxZZXV2x/ohzXpjEOvr/3suzJt0IkWGImuHQrjPqz5Wr4A=
Received: from CH3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::16)
 by DM6PR19MB3868.namprd19.prod.outlook.com (2603:10b6:5:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:10 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::8e) by CH3P220CA0014.outlook.office365.com
 (2603:10b6:610:1e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:10 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id AD4A95EA;
	Mon, 23 Mar 2026 17:45:06 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:44:58 +0100
Subject: [PATCH 03/19] checkpatch.pl: Add _Atomic to $Attribute patttern
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-3-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=842;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=USgHX7xoXSztxriDm7ubJXvt8RBKsyaNz37Q+j4iWvU=;
 b=G+IX2jGvU8IYNEbHAmBTNfeajsyzRMgvTo5Bbj8TT5nHCrOC+cfHGlXPp8O2KIooklnHYP2IG
 +KIEqK1ggylCG9bfEiWpoBc40f/wstGg/aEoZudph7iVJZetYJ7U/dv
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DM6PR19MB3868:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eca8dce-0dd1-4ef0-017e-08de8903edcf
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|19092799006|82310400026|36860700016|376014|48200799018|16102099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GSf18Z+k+P8F6S2wtnvSn5y38S2FpRKPZSpyDScpbbvMvNUj2V03UqCZWmtiFImiPAmTqfKU0anrZNFM6U31tDL6v6yYDxayJVvmXUcUcapeJbbQcyIrlIbQ0GN2WzoTiLhDxBplCck3fTb2OIMBnk4IXJFlTi21jQ4r4FZSb7K7amBa6EvkfkTKn82Iae6XWqCKvNCcuctjhy8PRn1dGMfSFoD1rtFNqn5cVkLCB+HpT4wvXMdoOo3oR3fZGoKZx7IrLckdyy6UFge86ozuzICVM22vE57+GhjlkuEaQpB5SEGNLIQHbw50wa2++V3k8yz3qCy+JiUIQNNBHlQLutIg5uRFyX/7ZSIsuGjlkS901AbHnA9lLD+SFTDOhqs1dyn5LARJUNL91ogFYTR4kR4tUqGryu6pbrkQ2GCw5ptdM44wTmWHqlZdfdMk0pbBl58ATwsW9wB6r/y6eiuP+IKlaw1XXa+O1AGivjbnF9mtzQSAGkORdHS+4IRctDNwLDDxaiHqcdSwhtPieXuUwiTPnMwVlZiTtg+svAsi69hs+ud/QaJb/dOMTzaW89qhv5aznoXRFnOLPR0Ip9jIpnADEPOyiQzeOh+tBerayizQPpcwN+kTnmizEbEM3+Z2iAhRfa7kWEo8XbDudiI5uIEl0/dXZ9i4PDZKgPx9uhy354iRfUCdmJcVmxOfi2oxotykuvZjyHcl4K9aiEGc3TEQXd9aPlShQ/6Wo7XsW7MrbNDGfBgvKUE0QRjmeUWUt2vqCizNqwF7nUuex/RFvA==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(19092799006)(82310400026)(36860700016)(376014)(48200799018)(16102099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WAp5V9RNoAF1Aej2CcwVd4NH25NCcuV4RyUl6OJOx9EFxRqIByQqJE25PABo6f2ssaMLYQC5mQyxuXhE32SoRWwW2OLndoMB1CnKRf7yBJeZojtru8His33VT+pSWkPNCpWgqLzPwjMimXfSdxDS6AUFg/l87R5NbWmpoV4sfB192HpMhlTUK1/MLhMo6kOJIUvUYIeWkog3KsWFh4FRwhgTVznsFGFsu4H5SzC2eJzTUMQ0MMf41wkMkdNX+7kIVEXvabdSP1Y+9Ji5NjJrXz1peBYcolhKVr2nGKH/EdoaEVgmJiSXIMFDBsWIzptP12e/q7+Yr9e1cqUwFU9D9nc72GvcWlOh4QeC0wy8p04sVu6l15KT1VKeY2rA+6ONEkOczQqGsRVF92QVl7mrzXUSNi6kV4BstVmE4SH4mTu5I6KhCYYxJQxYxVbWeTnK
X-Exchange-RoutingPolicyChecked:
	kRCALrI6aNhZjdh5MT9LjzPA78lUOaDenAn0YwBGQ3dOFRXayoAFCxyHivOWD6VyHzeUzdm1tMAtU13SpDEnwGEIezuuujnWGuM4VlRDaTZXHJ4lnLkrxHDHhv4kNeL1QC6ZHsQx+sp46IWp9MD6ZqpTyMTxOMBQ+UZBvXd5QSPCyZGZmOYh0ugDe2wvUOGnmm9pvy46JvSQp8xnzgYKjMLiB9U2kIDtuOU2OZVc1C/9yOrTtgKcxlQAeia8yFTD4Bdti/kQRZHjObZgsgVCoU/9T3eHc8kUVXgNEYYP4HsPz26nNgqdEjOq1Aqrm9Q7rIMVSU7Awvcj0AwlIzsv+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nCYXxZcyyloZ2Kh8QUmOpytBsnvqtFF40ndDjFI0Beijgk0jocDd+xLmyL8A+bj1rFDAvKO1rgj7wYKQ6XJ4IoNnF7RqYsHCs3BhdDK3yeGNEBzEwevwraBDjL8OIrmrRQHPYd899SGjAIldtuVQs1c3adGbKnqAhlPnK1SLDNuVc01sW+ypZkVZ3VyEG1BH0IuHAbaLiJrcl2SZIdqvBXPFjPyKdpmcKHvU1943b6zVne1UqfljmbY7aIcagJw4wrqJ1rHa2pRDN1DGX5vw66HcHQN4dCbjZMER41qL2KHSDVhvfn1l1jndNxrKXEXUDX7U/ymxikHgQeCKZVK6tOBH5lRvj3OVR2ib+2qJDyLivZA6UEi8jwdYk61Nh/9BjMWzdwVPoYpHGC2LCFt2ykK0IKR52MwlYzoz0I9PmRGEtlc12hZq1CvkrPe8cp6dGeZZ1qgg85YhmmlIMPjVEy4HZ+2hOpd1lyHLRc13ID1gMtynLb2NaLsMm8BLewdtITyhkUY9jrfOCIlpyJWFUJW9rr57QvHKl5WxKfnHuRAu3GbhTBExLGuhTx63GECSvxudJ2oY9LxS7lIglAhIz2TbIxWWIWartq3U4A+7Hxd5VD0LOCi2K8Ow2LCtAHlEYJkYOkEUYRmUrc0ih1Nleg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:10.0078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca8dce-0dd1-4ef0-017e-08de8903edcf
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3868
X-BESS-ID: 1774287914-111819-30694-8099-1
X-BESS-VER: 2019.3_20260319.1851
X-BESS-Apparent-Source-IP: 40.93.198.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVham5kBGBlAsJdHIzNQg0dDc1M
	IoKcXMwjjZ0tDcPDnFPDHJxCzZOFmpNhYAYC13dkAAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan23-39.us-east-2b.ess.aws.cudaops.com]
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

