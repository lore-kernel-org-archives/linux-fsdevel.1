Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DA34D382
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560908; cv=fail; b=IYpPO6DRjRSXndRaK4NmbAgSKckO1Gfdk43G3rPrBMfhLff8HeNLmEhrk405yESMVNd6B162oUdzz1BVGmhkpsRap7uY+oZrPEVLfN4rEIIqj8yieiS9mwkEX0aPi+GbECJcuuBdPfJ3p4Eb68Y7fcUjQcQKYK6TyMRsCC02mcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560908; c=relaxed/simple;
	bh=6nEHvB9GY0APVh7VYwSZeVdw0baxdGldv5ZoNrngnOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq2WBH2rljBDiq3ZuGc4azPc1bLV02vOlol39LZJZIYZGaEnmNT2kmCdjYrBEcIUiHVti5gtQpz3hOwP2wohKJ4WtIuVdY0fvKSin4Oo41GPcGef0oCjX3dXq2lVWyjPTW4fKBQYGC7jmTiAzD+/GQrvdtks7OvYz9e4EEhvTJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=vswhp8nU; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="vswhp8nU"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020132.outbound.protection.outlook.com [52.101.193.132]) by mx-outbound47-202.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5Ehm2tbO+BYgSdbrKYda7HOY3qQ2rlKH4mhs7TVdY2Cd5wog2L7DOHe2dbe0cbJOBthYRcb26TZyTM2KfDT4QZQGBIAI9lGfa8ZkmeCSpj1OalMGP6d6xqNuv5He/xpKSJPdcZ9OmGfWhcfegMB8nTNLqdqHnPz9QYmZDWRYuyUJOgXpFfBZ+Nw/gFl3Zt0OXUrobbN1DDdarjMW0NWcC/rWoav7kiQh8eeqZ1g2LDy9XH0Jlvxe7QRkkgTPirZ6SCLQ7n5bpyQHG9sbXY4JxNDB0XVc8xy4Obu4fnkRxKdsjMeuQ1RiLtGDsB7WZ9VsXTIFrLjkbzEL1b/DwzIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7hg8D+WmuyzZoAfZ0lj8jgvILub+G5Ab+lzjzs9Jsw=;
 b=dY5rRbUdG25sKGk5QVvMljWGbmrW/MpyG1vRFIAYyNRas0RgyXIpxEqfRTJmIaMsbsvFWGI9cL2wZrf0sfitEz3UtUrrjnRwFpfvy6ye7ibqgxjweO+bkB4vRYSGbuIUHmObJv4v1IctOmzT+Uqdhd6807Yfao/13/tBe8fv0v8OTXlI3lTsc1/hlgMJIvYPc7Nw3a4GGqV5NoPxelgcZYf1knMQr5qczuXoZYmCvT1vv6tHA1uSlofq2I17px9/l7oNtNTAW/zZ/kKdmHAmePvZFl5BEu8UPTNeYelKINAm7DCFnaO1Ljynxb2Nq4VyY4d6aSeR3u/b7v8rOShUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7hg8D+WmuyzZoAfZ0lj8jgvILub+G5Ab+lzjzs9Jsw=;
 b=vswhp8nUZbn6eSXgWIacfjPPF0h8CwjcJGulqm0iqkMl9N5NXRPxt+cS6DZpLG1cKNHw7hTbej+2JskICKuhBzBMkxqwA0v4BQhbKLIIEBaaZbkm56cJcR/zXzA74bGbkXBQnOFKRnZLGBpsDnv8QaGC6/mzbf7FcaDYX9Gdg28=
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by PH0PR19MB5196.namprd19.prod.outlook.com (2603:10b6:510:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:34:54 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::1d) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Thu, 26 Mar 2026 21:34:54 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 3347990C;
	Thu, 26 Mar 2026 21:34:53 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:34 +0100
Subject: [PATCH v2 01/25] ci-build: Add environment logging
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-1-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=1606;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=o3GdOWucvgNuWyuGcIEO4yjdXXGUyBim9YqaFF/L5PY=;
 b=Pl0ASfyCCZAKanFnL1TesybskU/dbOP4P5PaxutPEmjBGDzRC1l9+5zLofDd7noEy29z7Pkj7
 LOCcNbIYAqFAeoyzefJ6TETE+Cw+pG1ANltbdhplkgr9yiG8UIQ/p+a
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|PH0PR19MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ed1282-d2fc-408a-9306-08de8b7f8524
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|19092799006|61400799027|48200799018|22082099003|18002099003|56012099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	VrUM8QSnAr953J90tR+i1yFRB0nYP+WKwqC7QEMhjLyzBhcSM8idiqrGWvFEsJBzBbKysfxO55E8j0+Ql/mSF4SvlWKr+r1gGseq3x2zjwxYbL4rzru2I1CwnSV0lyeVCKx1CfAgrUoiobGbfGcjH1LUsDTb0YAjVtGLFQaDh7r6czLC11G9PKSPLooyt0E6ZEQUiD9S3XR8FpxaFXm0jvBZPfF0KqSvqOopgEajTD7+x2fXUTPBZBgd0EVoEXPxT5WzUQpm7QVVpgn/qAwfktmmNyTC9gZUhEMP/1Mz6n4qOyNBs7XGHQLR8xmkqHha4FYci+c6vgPp4FaB9DvX66KGgtSt4bO0P3kxxyhKB8Fj5D0XUu+5apdCdT+1ocQSMiKU6pqONYb0xSkbk+KZyqJd4hrAqA2+iDC76qyTOFLELCuAAnDTgBHh2/OornzxWF4gpOYL1aXO88m0mgdG3GNvNtYpYxSN1IdNTKoknlXxykGFH5RGBVQPbgQcGsT6MfEqcR4RKKW7AeQA/LYCJrVQCGsAK8VhvyoW9pBcmTF1XXWOZT3MdF3QIG9Uo2aU2zzcyc+EsEqBYF9QOhQei2tU4GYyKGW6ZWJf2J/U569dbp0ahZW1x1UY+ycpgniBwVvd1JJD3uHBsemLZwYdz+pQuZIKgBmONcyoKynNqbd64WhaTBdPRQSU9xKMdme0ZYWIQAV2K8GXYd67TVMh54Lyktd+NF9MA+Ka4jegLZOdK/jCQyhkqEMcf5JSR3jTsk1UZVOg/M2SLUZiUzx9tA==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(19092799006)(61400799027)(48200799018)(22082099003)(18002099003)(56012099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iGrQDKqiogMMg/4cNN4ld0jA3HPNSt4E7ZtAtI4vvnJGXANB9VDO8TLbzAgORgWum2roSNcssiJPpZ7X0Jrkfp6GYqsLi+qBNDFM5fBPV0ygGaEgdoa9ETeRx5aBlzDYhVT84mwIalEsxYArxC4Tmxm8CRrjQUeDT1/40sj4x6I/HDQagg4F99tGDXQrtqLVeJOkmRY015lJcZbfuy8jmU0d8pnnurKyA4Du/INhdqxVPNDrh+5Lhl4oUIbwICPJvogtbs5c1wVZZKyN0YPtXge7PIexSvzrmISL7cLZtNvBoAU91ESPwsdFT2FSPmrc44D9Q95FyY0XrU+yrnIeO1yKnC4HKG5SG1B1uWI2VbmO+PneKqEmPCr2EUKXFSKO1fAwyTZj5lZfyscg2Ki2WMlbXJXVCzbdRQ2COWJ1PgwqL9bshP5Wp4nFVIBU/6mj
X-Exchange-RoutingPolicyChecked:
	uQiZ7iVF7Isk1ABmkWhqgxQF1DezC5/yiK/iGgPYz4sEk+bNqLki2RuPqzSMg1zec7l34f7p4SrknPY0pIri3gDUXrjUn4fUh23dgt83zOqx0X3p9mTZEevgJUpZGSWSQWgaSYrPF87PU4ye49fHDgKO0hlOKJBv/veVZfv5Tf8GlePJ3J1jj6mgXGp4LjGbiBBN7quAWhaV2V5kT6MiFie9k2JhvjreX/3LtjoCV0/lCFeUXb7tDsemIwLKGj8S6iHPHhN/xkHV9Y1vxx8/u3Kr2zv6NttRC2MRl6rAQWt8h3BKqyRqrjcQDBrJTMv59Vogzx39xJpJL3chmF1uXg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qDL1DgNHxFYfbLSoE4OybxoWhl38Qb8FdBlYre1SXYmMIFSvTxbchlPxURjuy1HabdXC3kF7IDgIXDbzmzyYjSzEf3qsWJbfifNDy41HjltwDIs5YMyGtcLR34vSjznjEtQvGxkxf6w3PJWazBth+Erx3I6rg6rAjYLJVgR9WxCvN2bjkH9uPzPbD2zpaq0eAx14d0hZCFN9WWSR5C5csjw0x/DbgxrhdOaSp9dEd64jsJV2NqalK+q3nem7Y4uhGKY6tVPxrNROBtrrCeui8P0G3uaC5nTtqzEn2GEbg7RWHPSDPKrqjKcoXUNupWmYP53ZtY2kQXQIr91IdlDKtVJ/FgqOrgaoOFkvRdboCDOlOCdmr9aPe5mBLtOSjaGQnsxBkTnWUXylZmeC5QCFbgy2QjjMzW5KGWDhBUYHLRArpf53N4CFc5bgK9F+PTV7ca4MrRue6MRtsWl51c/G7xYGRRKsfUnXeX7dtQpLs7UQ2woVSew4vEAF9tExYNTjWQxWMTGdW6OCY9AhbV4LYEfwUjh3HEiCQDtVsd6b6gcPbmfNQRTRVKqdsLoQLNFU+XUiJ+o9mdX6A0jaPQQki1vgZeNu/RI494NPGmd4XmtXOMkVYXamozZIUFY6aez4nbVG8Xp9heXhiywTjS6gvA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:54.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed1282-d2fc-408a-9306-08de8b7f8524
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5196
X-BESS-ID: 1774560897-112234-7667-15176-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.193.132
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamluZAVgZQ0MgsOcXIwMTA3D
	Qt1dQs2cDIPDEl2dLAxCzNItHUKDFRqTYWADbU7wRBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan9-25.us-east-2a.ess.aws.cudaops.com]
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

