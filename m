Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01113CB2F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289881; cv=fail; b=jQ2qI4Gus43haYQ79GXNWzkla6SkTvEB9CWhpKgMoPJ75f6BT1udA3KBFXPIRYOsPsqW+pGsBR0cdsMZk8HYxobp3lIv/ajqCfYH063kHmtz+9NZmYCHAu9I0K7qzrm5ugx23G1RRibvsu90ai7tb+xJa3Ntf84JmdGXg3TLk4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289881; c=relaxed/simple;
	bh=6nEHvB9GY0APVh7VYwSZeVdw0baxdGldv5ZoNrngnOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGzZoXMTufdck39Nk1ji8VumodtGZz6QVfRZQQGvx8p0Oam8foF1vvW0fLn2q0IPg9CeqtnPdx2qf4JzVhLmzQxHlVCV5l6yRQKL3CCQOaKuJsDVLEGx3EVAed4YSDM1msyO3nHO3M7EbqeOCE8onsEli+KN8s0pt8nWXUahta8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=mG+dFDhY; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="mG+dFDhY"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021139.outbound.protection.outlook.com [52.101.62.139]) by mx-outbound13-233.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn045St/FAXsit+Dj57Oxg7kHRC4JhBaqbGgybEIugje+NwvRytAr4qPPA9KzsFmgdeZU05unr5r1WE81P07oZbYV61n4YMZ1d36gFBs+eMIi+8bXZXUx8q7dyurh6PNyHIksCqtGAxgtOVdFBTZtgOaLoe9aF9WATmiDIaNtybfAiMK0+DAH8xx7O98UZ4oCJ62SS4I9xVV9C5nmLqueTaASLUEtAP4opt37o8XHej/k31OB+mDamefB/EjGy0HJKl7xCqW3szpUBKOcfHVwSNXgiVlZiMRc5gPcFZVdVL21I8uOz253P5on/BCs2+2SaQ4Lg1sPb27EawS5+Kx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7hg8D+WmuyzZoAfZ0lj8jgvILub+G5Ab+lzjzs9Jsw=;
 b=SYLpPJXS0ChFKl7B8ApuW18UQtOFIq7eOZc9qs62gIAZsMDrlKkggENuUFFVAiz5Nfg4TBsTF2MVzpNGSB/TELfOJLcqrrH9FqaSyKqDety60p/pbFqTvMbp3NvtThqHx5xMV0w6yO2bU9odUhFboUGRYhIzD17uo6bmAt86f1qKAE74E+oF0ytPZu+/IOpDBiuvKXlad6QYkiDhQttxQ+9EBrJ9EXXXmrhr4YNO3viaYVW+odj9r8doPJHE82dhr/CFTkHzAsT/UXG8lqA6AaTYf4F3buQWpHA3NWb9M3zzLFu1JjQueH1xoZ4BdfRAzaWyk7isSvK0uZN2Utbpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7hg8D+WmuyzZoAfZ0lj8jgvILub+G5Ab+lzjzs9Jsw=;
 b=mG+dFDhYRsJXXnXNu/hdjKZi9RADRvFlTzuB58I0bWZBzqt26YzE56zir8EVLOUt943ZBE5z1VmwFSvOlNAEbqIHYjdRfE85nRTQMwH0iHu53vIvF6rXz5+G1wY4bPzWMMCToCUEuDNl10Gcz0+sHufjVwTmxeu2Dz14sXFJgxk=
Received: from CH2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:610:4d::23)
 by EA3PR19MB9254.namprd19.prod.outlook.com (2603:10b6:303:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:09 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::b6) by CH2PR19CA0013.outlook.office365.com
 (2603:10b6:610:4d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:08 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C6C5E15C;
	Mon, 23 Mar 2026 17:45:04 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:44:56 +0100
Subject: [PATCH 01/19] ci-build: Add environment logging
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-1-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=1606;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=o3GdOWucvgNuWyuGcIEO4yjdXXGUyBim9YqaFF/L5PY=;
 b=U/3Sl80/oNdv7DQi/UhauG9WPHmyTAqExQLBiKdj+aiBP1chnW46rjtjRQYQs+nikGwvg6DsM
 KquNxOotCKRCsqi6cJd7ixJoFBzGmFRKEvSyM5Ll+II8Thno09lGz3I
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|EA3PR19MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9cc581-1e25-4b9b-f17d-08de8903ed11
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700016|19092799006|48200799018|16102099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wXeBCkgV6b/HASmfkrLs4qQ+NNj3OYtg84k7wsz80Jp+8zLY9bQb5/W1wNTlBiR2GaUC2JJ7p5erfELXTkYAJs2VSa+V4dA6vTdgyIWuG0stHI4tUDHkNjOVXS8WTUihe/UosR20PBXEnnuD+xBdjnWb1D6GEwCG8JwSZim3E/a8Xd4/50cWuIcAk1oftCVrmuoVAXYews4Y8RhJnBFcY+f5chT8HEp/RPSQT7nP5I213lkJaQGUO9h+57b5CxNc7xExLlxbPRwOfTGUJmCsv8GG58lkPKNBOqB7FNq0URPEidZp9yd4Y7VrfHVcMKzcPYtD5YGxiqOKgBpAol1ntZak9GwCMgIwoQz/FpBrCwPeoPIXH21+Bgpx733II9Pas35VIWcgFoI8+IpIEBHq7M8R6sGex1ewxoEAPcTMaJNTgLcoVW5wZFsQzHOlAmcG4yqE1zRwMxih3MXTDX9VxI9Kk/mQTT5mv0l6/v7wgvDcxNnf4sUuAqBKgdCG3VgaPWNC/PNdV6CesP1c3oCFW4ZhUOxFV6QsgMatfH7KjHZGGS+n8MpEiDq3Pp2cF1aGY/vuexIN1khtYiGEakY+eHSv8gtgJFR11OUTPBqTRaaanlLoA5bkdm9bL3G4ERX4DfGsUGjwZMSCLfNu4ZnoWInKFFsQ+bobBh75U3Fy8J9nE+WpP6B3wNsxnj2TW1CHB77sfll7OWWat4fzotS7B+H3sHrdb3JeUH30JFyChrg5Gun14dJRjMB5rAz2GMMxHPXYBSNUJmMi+c5ASNk9rQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700016)(19092799006)(48200799018)(16102099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/h1UQtGe7/oNMZLIw0l21SXPi6EyIIdVXZ5aSiR+N1Ltzd8JZAwBuRmEL2BTdNAw+fXXICyRj1O01zX2sQ+3OI15K6Aol7edvmtxR962QHJDzFxihkHyapQaZV9B/iM7wgDyOoByc31Be0AFRTojTDFUtjJ2x/Yu/lyFdp0VeJUE/FerMxoIkUo5MHlRxMOQ7fitSbKkX0eIIX2DDHog/g/3U/iSHOx3+ucOR/WcOc7F7th4RTJSfYj+xEJ6Q1NvOHAMiRusL+fiJBQwNSTwdVrUyZZ6aCN/jHwBKYE6S4kCaFrqWBq9x9FOzGZeuigqigNhSdoqfVATsFPlEaIXZHfBsCURWy4hdFUfPCGFxt73LaBI1Knwaw1aN4ERnRNVbsSy/60eW93LLo46MvR4uvnfBiDxuz5+jaJq6rHGTHYpy1hNssAEnsxTrxe4Q8NE
X-Exchange-RoutingPolicyChecked:
	AgTtiIITQ1gGn6BE67AA/4S7f2JW8e5xfCfLm+/HzJkEWqge6XUjAvBGcj+bvePtSLqmJEO2dk5T4LCsnF7SdiUBCpNlGDFDlc2/zIIAZbdg4V0MH/HRsjqTgtSe/7tIuP4NkBsK37D2L1/5OUKMqJfJQYNTZ8CsyhFPoo/LIG5mWPLwkaSHk3SFT7IylB7HctZTQtjtqp0Rzc6XJKmeKnVTIEeCiitHIqlcdEXvTJ6uxE2NyAbIzDucJ/+bQRbP4+nFkmAs7I9i/lhChhLvGgvg/Isr5iMWtljBqPm9KjK0FbSlfKm6JV62mKTUnjb8azgrQyvh8tK1c1odRyl9Zw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0FaHeRARFkrPQlQX18PKdn7Pl0LUUdqPj5I1ECdhZQRUJSvJ/c9Ya4rdRIcj9U+QYlBLM7v7c1/IglyWU7e83HcLNMFY9QtxQqzfEcNWb48yEUR8dnimlZNDfIYnTOoT3FcM0vrjw1lnp/NXfzulS5KLClk0WV2XxuFCqFbzOIOvGo/qUxo0S6ymTFg+1dX44jFaBMMQAtYK4XATxhSiDsWasW5cuq+IIrrv0z55/mMuayiBJTyarjxgoh0NkuSB904fiQHBgbb2WBKNnk2vxubPLQBAw1FCg4VnFPN661yrJ9wvF7yZWGD71yxTfknOsx4UJjJ3s3DXLCv4CSJubTM7gsY/dXfZIBllYOCs25q7GVXOQNWeF4LBK0jIKV4oW/PfAx3F7B9vl5wqwuz/kxurCkeKrqxaz//A8q7QwBGnyfc7Z7AC8iAJA6++cxbzTJtd4Yc3IA5/BYr3RlaeMZpq6p+oZ93YRtDRPfmQXPKRKDWNP/jVhUzChnl3xxqmcK0UIAtQVYHa9bMA0IRI1qK488I+jbr21MZABs2DUx9NHiJMAoNcKuYn25DXeb9Q8MpVbYnx9IBZnYmk2G5j4dS62hOXzrrxAjJjoDVUDT42zecBqpO5e98ayIVTl3oO/XEUMPr/UvpH/1fc7bKtSA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:08.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9cc581-1e25-4b9b-f17d-08de8903ed11
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9254
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289872-103561-22267-12044-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.62.139
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamluZAVgZQ0MgsOcXIwMTA3D
	Qt1dQs2cDIPDEl2dLAxCzNItHUKDFRqTYWADbU7wRBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan8-255.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

It is very hard to see what exactly fails, as everything
is run from the same script.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 test/ci-build.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/test/ci-build.sh b/test/ci-build.sh
index 8b019a0b5e52c1af0eee510ede21785d584e8414..799f13b2911fac47b0bbb2d445ec22a6f40f065d 100755
--- a/test/ci-build.sh
+++ b/test/ci-build.sh
@@ -30,6 +30,20 @@ export LSAN_OPTIONS="suppressions=$(pwd)/lsan_suppress.txt"
 export ASAN_OPTIONS="detect_leaks=1"
 export CC
 
+log_env()
+{
+    echo "=== Environment ==="
+    echo "CC: ${CC}"
+    echo "CXX: ${CXX}"
+    echo "LSAN_OPTIONS: ${LSAN_OPTIONS}"
+    echo "ASAN_OPTIONS: ${ASAN_OPTIONS}"
+    echo "UBSAN_OPTIONS: ${UBSAN_OPTIONS}"
+    echo "FUSE_URING_ENABLE: ${FUSE_URING_ENABLE}"
+    echo "FUSE_URING_QUEUE_DEPTH: ${FUSE_URING_QUEUE_DEPTH}"
+    echo "Valgrind: ${TEST_WITH_VALGRIND}"
+    echo "==================="
+}
+
 non_sanitized_build()
 (
     echo "Standard build (without sanitizers)"
@@ -54,6 +68,7 @@ non_sanitized_build()
             build_opts=''
         fi
 
+        log_env
         meson setup -Dprefix=${PREFIX_DIR} -D werror=true ${build_opts} "${SOURCE_DIR}" || (cat meson-logs/meson-log.txt; false)
         ninja
         sudo env PATH=$PATH ninja install
@@ -79,6 +94,7 @@ sanitized_build()
 
     mkdir build-san; pushd build-san
 
+    log_env
     meson setup -Dprefix=${PREFIX_DIR} -D werror=true\
            "${SOURCE_DIR}" \
            || (cat meson-logs/meson-log.txt; false)

-- 
2.43.0

