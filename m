Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C535F193
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289918; cv=fail; b=RicwwRn2Q0Ra3KMRo+R9xC3aUf6bz6Bi+IPekjsGyHXWS2uBhugQZUcoDx1c50hntHKlcR9RO6eFiQNihVVYK/ov/zQ9BXN+AJgp/fuEGTThIZQfFlPgng6KDTAPhXWIkIpSsC4XoND1K/5Jw4YYRUA3D/kfAcmTaU0Yg/Y5MqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289918; c=relaxed/simple;
	bh=ruOXnHq/uYLYnHelfLqP53JTx7saVFPaBdzPp8HRrA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXkdBE88TzmcaEhBetmmS/Cn0/DHKBbkSgh5GIW6Ie1EjsuhSxYnNmoZeLMewUy2/3hVlixxrABcQzPgyOdbMS3WexPLpOpp0wQE4Tdrj80DmxT768KxE2fKNsq87Qtzc/q1VapG8uyrrzssTV3pE76hIrV7H5LWkMFmzSyrp1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=t1FVEGzI; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="t1FVEGzI"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020124.outbound.protection.outlook.com [52.101.85.124]) by mx-outbound10-146.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5kqtEWa7j3yKc0SLwNsodZtpAoJCkMmKepGkmHn1W/sUjxdxqMT5MzqIEsbPRIYB6SDE78pDYrRvmx8rvqAZw9MoiP2TFaqIIJUUv1Hmiun5vSj2c/7KT4BJl9iAfYJ2oYRUpJyN1BuZqwPxbOZCPvufxOYQSD2T0fQK6ajKKapTcwnR3+l2AGS2iT3e7D//ib51MTM6HRAtyjO3EIhhCIiVlHDN4LwLFfxmS3HEt1z3F5zWEJi42/sq9z/sZvsEdzwvudShji4Ni9kk6eJ/O1JUnibOwD1z/S3nPLo+60f8/RDV3U3TVon3JdX3S99FP4/UlHRfGPtVIj4UGhzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsN52GYhwtkaNwiRafgA/AGmZYEUYxgab0Ghgd9eJUk=;
 b=ZHNyAK2TlbMFGCXP32qzwJ2S1Tr9c4ZYjzCC3Z8FdOxyWij/RTKa+dmGc1lMY/yexECmNGcjgXOFdOj/ByvFFdJUKZDGItbtzfZ0UxHUFZhbHtej5mtepYi8UyeOc9/Ppf79FSm4kzhgo3m8Kv3qlWqbLhIBDKyxSP/UNoZmFcmO7v5soyepUdy7ZxYhMH6d1FOZWBmMvdSK4kgrAJvMxA+QiUDqNZ2wjIQjgTh5mtu3VP6TVlmjDQQFWES9siC3ifHTgo7WFJTdg6XCfUk0LNnVAhdGBsqVVnoqvaLnlJSF6h8JOSP8l0+DEK46JNiXy9LUImiBK4D0JpeQKN5eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsN52GYhwtkaNwiRafgA/AGmZYEUYxgab0Ghgd9eJUk=;
 b=t1FVEGzIsbaAZUocx6zVqSIX128EAtdd5h6v+RV9C4MsBc0vG+whR3FYOwrCsu6dYFn+MBUjzxfo6tyysT9OYZPH5WDbjJEtp6ZZ/yGN4VTrTUXL9OAbWbOyrg6JRJSp1y+FVmSWhQntd0d1CGIX0Ap4+UMEVVCGX5hSWOok4Lo=
Received: from BN1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:408:e2::15)
 by SN7PR19MB7067.namprd19.prod.outlook.com (2603:10b6:806:2ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 23 Mar
 2026 17:45:22 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::c9) by BN1PR13CA0010.outlook.office365.com
 (2603:10b6:408:e2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Mon, 23 Mar 2026 17:45:22 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 04B0615C;
	Mon, 23 Mar 2026 17:45:18 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:11 +0100
Subject: [PATCH 16/19] fusermount: Refactor extract_x_options
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-16-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=5068;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=AT1RFkolkPivc1xmghNxwwobf4C00N7haQhOcKF8Z9U=;
 b=guFHxyGYiTHuhGQG7+hyiWXh16KVu/Qu/yVsdhcvqUfiT1fWMRBkP0Rqhy48Qz7Hqyf4rkSe8
 QcgM1NFW3WPCvdq7nhLkFzG3scIToQUaGbwIuhvdHQ6p5UeA8OX534I
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SN7PR19MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe416a6-2e1a-4ea9-9d5b-08de8903f550
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|48200799018|82310400026|61400799027|19092799006|376014|22082099003|16102099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 Thahfl1/+DwmV4CQ2q6Ll4Tjp+IIbKl+YXfCMfMOa91ZeEZUA4eO8tdeAyZOrT8oemQp9kq2q0BjspTk6kyTv9GI5o0kyPCUASohTvv01ufRHxZhbpTCcKyam/t/MAtW/d8aI2zQUQR8M1Ov3c0q6gXyRyfVeOxDCI6RKNJlHUSUmjR2a91EefXt1nkW/zm1Iux9En+oN2mk+xXKcyut1zoa5EM7Nwh/atdbZCYqp19dk9cODFp7x3Q5y9G5IVg//OqI7c8HIahFxPT/hA9ANxRe3gYv2zRdqLAJdurosp1DT9x4HZGYKaY4k2KAhdc94uK0LdAdPebynQti3UMmc+mP9FPfURCLwFuy3Pc11AlcQpN7omRRxlnc3B5ce9Agf/Ujdso8miO7H1l3Gbe8SWPbyWB6rz82I38034RHTEvYHT0bj9p/7oxOTpVzzWQduLk95Zf0ELUFkkKr/PGpfBN13gddAz2OPoEtPT9vTrlPMhA63Cxe9ItJkFAxO4yl8l+CYks1bk6q3CY8lWTNaD1By9iK8ys3TbO4ZKTpm9xycKxmyilVd31MrrOPbNpKUc87pXuYorC1UekM58BrTKXRtRjJPAdWrRvdvz3to0SecpSGZvtC8YYgcHzDUEu5yYmvAn+Bfm4yA22ZKDMw+BiChWN/tRFI75GEeAAhz4YxXALSEKqxx8kpi8zwoK72U68pCmNthvzYC9Secenr5g3kZUKyQkbEFZPWdETtAGQcmsg9JyVY9GUbGMix/QlDo0Y+BsAyGlmE1NzHRFQ55w==
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(48200799018)(82310400026)(61400799027)(19092799006)(376014)(22082099003)(16102099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 ve4zckSGeWQhjHN75Ygx2nJ+LT3ffiaD7z5xj1Fc2XNTijXLE7hBw1TrA7+5gNMsZ4tcBYucUKlBn79qqNaKcRMLcIMnlvLy+pVZwXGJkOX0aDccDO8A45pO9n+cQaXpC1vZxwtlW+kCQd6l2H8pumtdJ+orMDKkcD6TL6gDKtIgk+HyxllYKzDb44QwDwCUdLneXtIorcKBEc3i9jTCG6Y2Eqq1Ynbn6tpwAJBJj8gVvCNCKmMJAm31QAgW7Ip41/U3f4o++pRLnRSzXLu1xck9jejTiYxyt4TTp1+Obo95Il7UEfjV1jiZVmWq0osLOH9VmJrTDofA87aFNzBqdjmjDrsxZ2GKsnDAh2HL2yJpkHfz9EkCH/tf9YCeIu1PKCpBxZUX0vmlXIg7xkFkRc+q9CU8TssqQ+wmAs4mFBUnTroBRboYeBdQYG1oftOJ
X-Exchange-RoutingPolicyChecked:
 Q5ojcKdtE00xNbytKdBMtSKBuz+R3ZURv61nORxHN7PmxHsysVhwELGk2YhlusBNOYqPjw5GBCNdthxSJRUrUqaytVpS2eWuWGOdOaBqunx5vF5RN+peEeYO0HqkFDVnq/HQ4FI8opBtp+GCgWOUcYing/DER1JN2bqlChEFJc/YB+cPSRdYLcu7PotP+SSST9vzCrFwHEGMw6fQGpdx7MykZtgW1GM3FFoeoPgjmzasFPrepQVzwu0Z3lwe8797WbRnFGsnC+u5cax6TFmF1cZDGQhdWzwE6a9p1oKtOcQCWT2z31f+LYlaJUFQsMuecME1/wAv4CdFVmSR+/b0Uw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 6Ft1UufsfAfTFBT17cwtSdsS9CVzykTxBpUaYosepfAzWobw7iCzlc1jGCRZ3hXnSLA/aU7rEDUR4TJgNWj8pmEWCC8eaTXnekrMQxs5YgJGKwL6ucGiY8aPXEV9/G5RIJOt5B+8G3mceWGToMYWHsbF8sZTRsS9H+C4vsk65g1sqpGHu1SZakdeG5D7JwLG8BGX4B4M+Au2VbFiqMCRBcav1JKxhgluEONwaSy9dMqVrcYet3e9DMfc5DgzrCFcIcq7pf6z3uIQHgwy1bcadozIsdTuGNl5vAJx3rLePRcMa0QjqpMo/851YdGrya8uejJThhgJgqrcvKgldXiasDriUxko5FTS3r64hvlHt35JgVg+hdooKe1/eVTXRiuSjY7UNNzFUK60SvLDoBeZDZJqx4Kil5U0l0OZc4sUHnvIytu6R44I+O3RB+qZRM8RXTAgPmJFGKUuiCaQN0/Ztl2lpqm8ELWH8kEvorVV7omY+EDOaHqZ2gLGwQB6xess3rIX2Vxn8fQ1AsEPsf1ZzVduWyrkXbssrhdaA1f8JG9Jn4gBEf4UjbWLELWuWxu96ZKHz7NXBjhuarc4q6RFqaIffdxXms33pNPbkxBkRM8HlfVJH4ScONweUkScOWeajoVzV+l0Q2xXWgMbpStNYw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:22.5399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe416a6-2e1a-4ea9-9d5b-08de8903f550
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7067
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289905-102706-7694-26105-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.85.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaWpsZAVgZQMM08NSU1ycw0xc
	jCMtUwKcnCxMIsxTwtxcgwLcUkNc1YqTYWAFYLlpdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan23-59.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Just to make it better readable.

Also add a NULL check for *regular_opts and *x_prefixed_opts,
there will be multiple callers in an upcoming commit and
it becomes harder to track that no caller has an error.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 util/fusermount.c | 58 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/util/fusermount.c b/util/fusermount.c
index ecf509bb80d5cd129f6e582f1ec666502c55603a..80b42a594e89cdc2f43824f5e274892522fd8cce 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -112,22 +112,31 @@ static struct mntent *GETMNTENT(FILE *stream)
 
 /*
  * Take a ',' separated option string and extract "x-" options
+ * @original: The original option string
+ * @regular_opts: The regular options
+ * @x_prefixed_opts: The "x-" options
  */
-static int extract_x_options(const char *original, char **non_x_opts,
-			     char **x_opts)
+static int extract_x_options(const char *original, char **regular_opts,
+			     char **x_prefixed_opts)
 {
 	size_t orig_len;
 	const char *opt, *opt_end;
 
 	orig_len = strlen(original) + 1;
 
-	*non_x_opts = calloc(1, orig_len);
-	*x_opts    = calloc(1, orig_len);
+	if (*regular_opts != NULL || *x_prefixed_opts != NULL) {
+		fprintf(stderr, "%s: regular_opts or x_prefixed_opts not NULL\n",
+			__func__);
+		return -EINVAL;
+	}
 
-	size_t non_x_opts_len = orig_len;
-	size_t x_opts_len = orig_len;
+	*regular_opts = calloc(1, orig_len);
+	*x_prefixed_opts    = calloc(1, orig_len);
 
-	if (*non_x_opts == NULL || *x_opts == NULL) {
+	size_t regular_opts_len = orig_len;
+	size_t x_prefixed_opts_len = orig_len;
+
+	if (*regular_opts == NULL || *x_prefixed_opts == NULL) {
 		fprintf(stderr, "%s: Failed to allocate %zuB.\n",
 			__func__, orig_len);
 		return -ENOMEM;
@@ -143,16 +152,16 @@ static int extract_x_options(const char *original, char **non_x_opts,
 		size_t opt_len = opt_end - opt;
 		size_t opt_len_left = orig_len - (opt - original);
 		size_t buf_len;
-		bool is_x_opts;
+		bool is_x_prefixed_opts;
 
 		if (strncmp(opt, "x-", MIN(2, opt_len_left)) == 0) {
-			buf_len = x_opts_len;
-			is_x_opts = true;
-			opt_buf = *x_opts;
+			buf_len = x_prefixed_opts_len;
+			is_x_prefixed_opts = true;
+			opt_buf = *x_prefixed_opts;
 		} else {
-			buf_len = non_x_opts_len;
-			is_x_opts = false;
-			opt_buf = *non_x_opts;
+			buf_len = regular_opts_len;
+			is_x_prefixed_opts = false;
+			opt_buf = *regular_opts;
 		}
 
 		if (buf_len < orig_len) {
@@ -163,7 +172,8 @@ static int extract_x_options(const char *original, char **non_x_opts,
 		/* omits ',' */
 		if ((ssize_t)(buf_len - opt_len) < 0) {
 			/* This would be a bug */
-			fprintf(stderr, "%s: no buf space left in copy, orig='%s'\n",
+			fprintf(stderr,
+				"%s: no buf space left in copy, orig='%s'\n",
 				__func__, original);
 			return -EIO;
 		}
@@ -171,10 +181,10 @@ static int extract_x_options(const char *original, char **non_x_opts,
 		strncat(opt_buf, opt, opt_end - opt);
 		buf_len -= opt_len;
 
-		if (is_x_opts)
-			x_opts_len = buf_len;
+		if (is_x_prefixed_opts)
+			x_prefixed_opts_len = buf_len;
 		else
-			non_x_opts_len = buf_len;
+			regular_opts_len = buf_len;
 	}
 
 	return 0;
@@ -1379,7 +1389,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 	const char *real_mnt = mnt;
 	int mountpoint_fd = -1;
 	char *do_mount_opts = NULL;
-	char *x_opts = NULL;
+	char *x_prefixed_opts = NULL;
 
 	fd = open_fuse_device(dev);
 	if (fd == -1)
@@ -1397,7 +1407,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 	}
 
 	// Extract any options starting with "x-"
-	res= extract_x_options(opts, &do_mount_opts, &x_opts);
+	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
 	if (res)
 		goto fail_close_fd;
 
@@ -1420,14 +1430,14 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 	}
 
 	if (geteuid() == 0) {
-		if (x_opts && strlen(x_opts) > 0) {
+		if (x_prefixed_opts && strlen(x_prefixed_opts) > 0) {
 			/*
 			 * Add back the options starting with "x-" to opts from
 			 * do_mount. +2 for ',' and '\0'
 			 */
 			size_t mnt_opts_len = strlen(mnt_opts);
 			size_t x_mnt_opts_len =  mnt_opts_len+
-						 strlen(x_opts) + 2;
+						 strlen(x_prefixed_opts) + 2;
 			char *x_mnt_opts = calloc(1, x_mnt_opts_len);
 
 			if (mnt_opts_len) {
@@ -1435,7 +1445,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 				strncat(x_mnt_opts, ",", 2);
 			}
 
-			strncat(x_mnt_opts, x_opts,
+			strncat(x_mnt_opts, x_prefixed_opts,
 				x_mnt_opts_len - mnt_opts_len - 2);
 
 			free(mnt_opts);
@@ -1452,7 +1462,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 out_free:
 	free(source);
 	free(mnt_opts);
-	free(x_opts);
+	free(x_prefixed_opts);
 	free(do_mount_opts);
 
 	return fd;

-- 
2.43.0

