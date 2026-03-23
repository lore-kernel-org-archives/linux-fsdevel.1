Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777743C554E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287937; cv=fail; b=Q4hJ78Ilx/lSpNODz39+GMWHmoKdzq7MUBBeVhhokJP+/ymIRUr2E7nherxOePRvm0C1w7sRS1xe6xgRInNTc24T8IwaC9DvFSugBFV/l23XkMnQRrSvprtimZ2QRJHzRUvhp7zaMgKLE3Ppcuo0K3UDxpAv+IXLaGplp1N0Xjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287937; c=relaxed/simple;
	bh=c5rPBJI/JorI/pOQtuTDditvbz4sXujM9QF38ftdaXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeSbi/i31sRvFSMbD2uDgYSb19mw+rcp3cmKaRfcuhR7yicGdZcWFxtbMEiAQ8VwA9k4sg2jNVzZNE37LxcqgTTCCC5GHjiYyhRrGJVLCJ+QLRlqGJPJxsaqsFHCCwvqyf41qSWM4WXFU5wBzpZKKapVNbHwKe0SwrJgDT7wUdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=qAoLQILw; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="qAoLQILw"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023133.outbound.protection.outlook.com [40.107.201.133]) by mx-outbound18-164.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaJyYcKqxn3CJNvZjPclQo4qIOa9VWPn7ZbFcAFdEGcu6eFMaezt9u47RfK4ZFuwa+LLBH2gbkCjYP8zM1C+pC2kOHzMP55ENkgki47irIY1srWgH0ijnmFYk+q3hygXPvWs0oN4Sr8DFjewOfIXvUj+Frk5CjZHPUH/HeyvtXRnReMteohoagIE1AKlmZm4xHwNdT4ArWxFPg6whDM5UqPEQnRqGe+Femn05stulJuccY5UF+UXh7VeZ2eNf4pt4UzCphSSKzHYK63sF28rq1Gr7s+s23XeMVtdBcrQyDCpEJjpRZgVuyPUuHJRtUJY3Z1S+8m56m9bKTaBpPvBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzNA384GbLWe/3HPmqhawCsoNMuhBRhD48D3fywcbwU=;
 b=nL5FT1S+8om4b+n8hmpsF92mI+qYP1sNuIOgygvGkH9LNamkCI/AWOS/CpA6GCfKjOVP7LRrPCpt/CogJlZY42lAjeTRrzj3pGbIM2UxQgKHgEC2rnNSGioFZPI1SIIme0DI152ApISCZJ+aLWH6n7CwvehH9peSpoO2B1h78aI+bzbWQqYWAdUJKprMScMM++uJrk/+CJaXh56xxvkgt6qTOvLpNNvR+eUFnU8TlF73DUc7G9hjZWGJ8wQzqrxEUvC/i4PpLDv2nGlobdWSuAgkWnIZ4bGDdXOEO7bs9bZ8jyjp4ElRmLct5yc+jlgBgaGWWBP+MTl/ZZDAxz+hLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzNA384GbLWe/3HPmqhawCsoNMuhBRhD48D3fywcbwU=;
 b=qAoLQILwJ3D+QVE3M6IgR/ZZZgbLIPhjK+2quLENlvSWwcGzz9GCc71k09cOtGHksFG3q9BTFEgxzp5r/8wxGvPPnXAPJoepK+KxFrG/lQGK2Q+WC8BkofiEi4WEnep5cph7A7xg4l5d98fvxMqCOAfsJu4r6cAgh7EfK9bR/vI=
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by DM4PR19MB5788.namprd19.prod.outlook.com (2603:10b6:8:65::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.25; Mon, 23 Mar 2026 17:45:20 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::8a) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:19 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 2B22EB7;
	Mon, 23 Mar 2026 17:45:16 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:08 +0100
Subject: [PATCH 13/19] Add fuse_session_set_debug() to enable debug output
 without foreground
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-13-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=2084;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=XmztdZe2UDE57mfo3tOXF7/S/huaIf7h/64BwtQuosA=;
 b=y6jhYI54aHQMje7Ia9dO8i41EbLl4Rby6XxCCs2uFzKDXSw7vTxdPiEUVPVFnDqqIKa+n+Xsm
 ay4iVmSn+MXCloO9XkSeRmvtfROonm0kHq0p4+TMK2yOlHUAJ9WYPfh
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM4PR19MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e49cf3f-704b-4ad6-c68a-08de8903f39e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|48200799018|82310400026|61400799027|19092799006|16102099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5dPjPJA2SBDPvM39Fur7yzxe26fcBKjZC+0N8vBSoDdAjiiuHzGABjrOw6xZvNVsjkiwu225LnPLKty03D6bKg9Nr2Z3Qtp98xi3aMVEin4v2jLlweUTp2/NsHMr07XPFD9KjZFuy6v7KMgd8gv8UuF3FuKx+yWSzOJ0sVCyLU3gcTCFM9BR6okmRd/iehYl4xs+ltklqjO0go8rVyrnS520QnmXLYwD/UEFJODw6ikuNlwRoWmKwlNVaT1qERp6/376d41NX5kfUhv+KjRx+Fmcw2vadgy7HRMWmPruxN6TBnrAeAMVHBX70gVDZ2nQxbPHMWCmBKzoK3Udb9PDQowFnjmlel0t4dPwefq03V++79OaGP3C6dCnQU1zKybEF+HHVGBl37z5UeEbn0FkCMHsH8vnayVMHic8i1dPq4uUYOKnKZWYa9IFBI9TNmmjDZZqAXkbmCuIjOGYHYb5l3E/3vlWy/r4KCH3ClJJQ/osIzbHjDrO/I+kPMZBp5wjxBlRzKRffxlhqJ2sVH663t+4lus+Owdzq9bH0uS1Q7uG7CDcVxfjfJQJlc5wQ15BWb1ZnnKCFYozr6tcL5Toi9EYqfCU9ub7cv8CIqrz3KLEqlqB5DuvrMelPsJqFWaGPC9HKF0H6r+JDoHV0bITs6H2Rvuxb0HxVa+CbiZNfvgN61Fa7VrjdJ2w1VQLfD14jFtZUSiXd0Z+A5BxQvF8lZrK7WTgqfri5D1sVKo6I+PCiRTlW8GgXmL63Cw8q2AgkYRScTaRqJ7jSIKeOHRBag==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(48200799018)(82310400026)(61400799027)(19092799006)(16102099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sG67GObj3F4CcJS6k2aSzvRwlgQEle4gL+ids4oUM8oRlytxVaPBcgup+Cm/Xs1E+wjPnTnVLyv7KKCOPRq+6+AX+nSnDdMtGJJHwSzWyzMNfWzxOfMSpYb+9wP6gDU/rRPADFvwxULk0/R8u/AhFXAnl8DVs4kFNBLu3vnwusbgjPr+ebUTgBKMBH55rynF8bmmatJxKUM6QLARp++lbHTPaiaXOjIaH5HI8YO2tpm8C4qgscNSb/tWO4J4I8DGShLc8HlcdksxosJvoX08IfX6GCN9gakFC6Av4jJuLrhEtV6cfS6xRmGu/iBJkJrofIDsMkE/XIqyWMgEPkrBrtgy9kfpm8qmCwhlgLvaabSWC4g0umIWI9T4jChEYYWeSfTAM/ctXHTn72WWyT965TxDS7aBdzJEIaMoO28GuSbLhEtQE1bN8CZit+81RBp0
X-Exchange-RoutingPolicyChecked:
	OdozJvnCK7hDKkff+Ok+5ymIaPT2uwZdOq5HTVQRU9IdEyquafGaabEBu9aoqjS4YGY8QRx4tG7jSqeEH0p7o72rvKhbCwhBhTcn/Nhl1rGROlhpExrIVeO5EsHviCUBZhrtE6CtAKDvfFJA5TAaOvW/RgQ3yt8LfQbsRSoMIYK7UbpGnsYJLLcJ3Gbu8D6aZjgVH9UrY0cIBnmCHGu9v6aHgMPJko7PXXhKmMcbT5pHha8rWz9b8myJPZwd8tPQnPgMWVeThqumlqA4bqegeUUtmm19xCcI8/xndIFPJhVnAYwfjGA5tzffR7YK4gZrKHlpZS0wIRu4flBWPKmB5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EpG9RFAwA8u4k9N+WwFO1dPJbFbruVuym4saKLuVe1tXQ7cM05LWUG1abKrvablRcOllPm9eoyT/2OPlxAAvTSFjaIxzm91HF4u4UZwt8s0IbeV9/vxIM/tHv9sQHGndz59nSiQEYjndBnwkmlceCop0Vi6vkb8lUNKB7PR8xaoLau1P8XsBcHgaFPMkQsVL8jgBBIAAB9yqQuJAit5uuuxAOxtA6hyOST2S3Q4BBg+iGxuXKYBvr8qIcIYcvs+aTR1+qjzCS9DOuSdESSzMFi+g0xllazyMpRsWzsag5Dw97XbJLw7bS5tNmHU/E2AP08w6ngtEgH8v5BmrkitKtzF5DVEMqa1ZqI0MPmqBVSALjAZYsy74nH04BFozft4B1nS05bLKGkgUzeh4HAzGe5SaOArD/y8Fxb+BkhTfV04HGjAHf0ZNmFXMQxcfwnRLdHQG5+2mXaCGNmFNQcl1Eizn4MWXmaqYYTT2kgn0sdS/hs8K/1+veahDJZwlRpYgT1IX406mDHM6D6Fr8853RVaHZgUQYScJtL905ZEMb8aXNVsT5c2aZ5/eKgduK55OdmZoM9+KjYh1UiYrUT6eNia/6uT6LBVohVwA5TwjFhQ2iu6QTghNe1OEMwZFPN1tJWDg/OhInww8BLUuNFtzsg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:19.6958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e49cf3f-704b-4ad6-c68a-08de8903f39e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5788
X-BESS-ID: 1774287925-104772-7815-5144-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.201.133
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGZqZAVgZQ0MIkzcjMIsnCJN
	XMwszY1MLYyMgyycLUIDUpxTTVPNVEqTYWAFvRo8BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan15-241.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

One might want to print debug out in background mode, which the command
line parameter does not easily allow. Or one might want to enable and
disable at run time.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 include/fuse_lowlevel.h | 12 ++++++++++++
 lib/fuse_lowlevel.c     |  5 +++++
 lib/fuse_versionscript  |  1 +
 3 files changed, 18 insertions(+)

diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d8626f85bdaf497534cd2835a589e30f1f4e2466..d85929e291a77de8caad7d6b3d9ac5b092ce0e62 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2441,6 +2441,18 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
  */
 void fuse_session_want_sync_init(struct fuse_session *se);
 
+/**
+ * Enable debug output
+ *
+ * This allows to enable debug output without a command line parameter and
+ * without the enforcement of the command line parameter to run in foreground.
+ * The daemon needs to handle either fuse_log output via stderr, or
+ * redirection to its own logs or via syslog.
+ *
+ * @param se the session
+ */
+void fuse_session_set_debug(struct fuse_session *se);
+
 /**
  * Check if the request is submitted through fuse-io-uring
  */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index b10def03f3666757d312f87f177a560483691d6f..a7293a3898c37c3877eadf965d310ae2aa5cc2d1 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5007,3 +5007,8 @@ void fuse_session_want_sync_init(struct fuse_session *se)
 		return;
 	se->want_sync_init = true;
 }
+
+void fuse_session_set_debug(struct fuse_session *se)
+{
+	se->debug = 1;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index f1765d39e13bc9b1f53e625b9a091c5fa53f5afd..64bf75ac2cb252d066ac301be8fc024b59f903ac 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -230,6 +230,7 @@ FUSE_3.19 {
 		fuse_daemonize_start;
 		fuse_daemonize_signal;
 		fuse_daemonize_active;
+		fuse_session_set_debug;
 } FUSE_3.18;
 
 # Local Variables:

-- 
2.43.0

