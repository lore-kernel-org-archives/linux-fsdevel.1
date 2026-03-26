Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C863A8741
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560928; cv=fail; b=FnQrnTR9fx2M9vhPPurw8VR2ccpoGJfHebyPD8Ozx1Q0z++/xxLGLb/1EozcqQ8Fs1zoZ+X6sxsk1u6DYns0FVtDJxSEOW4Cbxqf2bYR8n7NXrIcPKsIYA1L8II+/MZVQokBmYfNUuKTsfoLRqMPAKbrLVrbQhVPwukPVfpNaHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560928; c=relaxed/simple;
	bh=apI6lU8wAlJW7eTItssQiLYSgh9Lwq/O4u4AyjTvKZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nL4/MQ9pKEkPJVIZvOAuRlzAZA2EY4u1TkDZ2U8/m5vmx0YPSkrCVKwkqwt588vq6ISmY/NtVSZYVo0tt99vmej1Cks3WlkvkZR8Maep9sfbPGZj/qxpxdqsT7Hlxe0XsJPlz/ZQQ/b7CVNzRozzz/72wTrle0thX4cymFXopgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=lQstuv/m; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="lQstuv/m"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021138.outbound.protection.outlook.com [52.101.52.138]) by mx-outbound20-201.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P86UQP/ZBvOD/No6lCQN5zBkXa028MHm5JOKTkTPaFXxNkwFeMCzQT1/5I9C5Xf6TxZVqOLpnb6MeaMe9IQF9GWopXnkgu1ChjqLCgOeDcYFEAay5/ML8Nw8RREyALHEnO8h3+wE4ICtiJTqB6rd6BmXukfdQ/9TS+sGsUbdnoBGlkxp25I65wxt2lOWt/JJj1WyGHBmshwHhoZsga+hO4R5WslnNA7b3zHnn/PJbo8s+qobSSpy0yyDzRTzORxYOn1I2BlEbpaiLyE8zukBE+FzzKAkiKtO0TOtWYpxRDZADP2IyC9tTHWcaf1mFJUedc304wF1bJud+u8Bm7l9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz0GcXQQ69RSc3QAdu2qFHmjEU97KWjXCkvlw9E9XZc=;
 b=djukmf64IDMEEZ+wevTg4xv2aL9MEbEJHIcK0kIkW6BB4W9IzWPWsf7yMEMLFO0qG4lmEiZ2rwguJ89rZWdtf2Yjfjh6Fybh/nF3utmyJc1TpCubJFp5AYHT+R+X5WJ1wzTHN/cAg1oQmNUrHtcRQakluhBWX4sldMXiGXt4tBg6wxKJwnIcVAz3ZGMQ8IH6U9UT1vf1WvjNPQDJDHkgC305j38wqci3nvsTBl05o3xX/hZyAm+qSvM2Zuq2h3vNdh1R9fLApHBhz+FHxfDBfVOkyvKDVPLbxMqUsI2+kmF8kayGPAUvYD3kKmMSCuTBl36unj4R6JhPA86IPEYZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz0GcXQQ69RSc3QAdu2qFHmjEU97KWjXCkvlw9E9XZc=;
 b=lQstuv/mX59Pi6yUIzDx+S7cE/T60B8iGKdC67JvLiQhrGnw/EdyLaRYt+FkU6KcGJrYA4hS98ceWJhaZ526c8ukuml+VjRC92pzPUN1U7AEQfYtD08bayykw3jv6tSmALRAfVZ9mPChSL+uQzn5S070NPqVyR8Ebbiv5R++Vb8=
Received: from BL1PR13CA0103.namprd13.prod.outlook.com (2603:10b6:208:2b9::18)
 by PH8PR19MB7166.namprd19.prod.outlook.com (2603:10b6:510:216::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:12 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::1b) by BL1PR13CA0103.outlook.office365.com
 (2603:10b6:208:2b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 21:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:11 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 42DEE6F;
	Thu, 26 Mar 2026 21:35:10 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:52 +0100
Subject: [PATCH v2 19/25] fusermount: Refactor extract_x_options
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-19-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=5120;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=ak/tHrJlFL3rt4UUDWBRyTn2XMI9E15Ld6jSGcWWsYk=;
 b=5RuIMbOQerWPT4DyPBPL4cU5FrYIvCicaPKAuCSfb3DfMPThR04NryGoye3XpJnBLmr3zBHDl
 P7tc6YDqOYeAPL7D0nQ6UtNGEM1fchcz+Vuz28t5kLDWXPo+n7dZkGu
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH8PR19MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d09b01-f3ac-45bc-9e48-08de8b7f8f60
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|61400799027|36860700016|48200799018|376014|18002099003|16102099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y2Uaosfl2NczgsfDO9B/xdLYVpxjacdQIa+SAfyJgaOlMQ4X1R3seB1QHqjRUiA9bUfPHe70gMypTnJ8uLBljvD0mIyxuz3TJfiFG1nyi7XjJU7EsapePnHBVRRNK4C+2vJyY6UrMDrmY5UeUO44I55dNoWx82nwHD9wLxBDrRhgcp8G83Ptx2ukPrQjHDz0k+fGD4I4V/EGSJCUtt4Tm57wPeBi7lZk3JL3RCiIo1Gd3eGdww592ZZt1Aj86VWw/QwF/653z6Ljg07WsZdh10+0M/CXjXuS0/M5fcQpJKJBp8soF+aFhyAKadGn8TyYVGYNJeKRpOQwJHUwoPoabQu84KlXWvqwafuf+oDoXbW3ztqIjbl1ETo7HCn/m1qkMTrgHpUEOKEjmTRoK2OnabxGIrkNc20VO+xcZG8WSDFApFYJZHrQYu7YbZFm1Zr3r5nge4cH5AnhOlNVqSoEjb+VLxXvmB3o4TpXiGm0Go6evtqzkHxKD8cRMO+TQR0J8kaJeWtKmOxYOAiEVBZmCn3daVrZ6u+D5et/gRPkOSJiz3orLYWxQVDB3QJQwOwU14rBanPi6Sg3U9KWwPhdiG2NXnqdkOpM3tX5YNLhm493JdJjedDEHBpzezxbmWZ2wcsKfuqfggLrsg6VLBccEpxCL5NxNU9hUUjlxlzTxhourIlvpmU0LLa7Tr8sp46HJzjreCXON8xgKMGHnaiKBrHYumTV7mHGS6aLnQI6+Lw6QOR68bbBiTvLdOWcMkBJufGSKNy5yr79OruktexOog==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(61400799027)(36860700016)(48200799018)(376014)(18002099003)(16102099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	scciBTeOH+dwqEsgBMj4Ywqtf01FRATeDLjdMfaiaXKeOjKrWvDVJQkDmqtwYVKgYHquqGbk73up72sFx2iteo5kZYSOjJsUw4oMW5Lb+uZvvzK8mSJLy7nTA+oDbPoFLgp6JU2q+/WBBDM/IeRD3vDmj6l7ALUPO75AdkZfoatfX/RTamM0E2uBIeskVJxDcObUmvF92z8P8KcgivAwjRIiPfnW+ZkrMtVI0MbspMEPJ5T3lQGvMOOSaakGlxa9AwzoppgWHjkOUzITK1MmncoOFknBUkBCtCrn+gQ60sckNMhIvHUoQdsSq6bfLGSntAuBuJnxwzGVqCUR6CN8cqAHEJc/lMkHgkm2A6bvQG1LlT0wcI9qZ4ep3aEcnFRKkLXorZtdfHyMd7xi+CGNDTvtsgJoEbvv6Gci1N9P0/iZbnx4lzE+RjO8GXdst3cl
X-Exchange-RoutingPolicyChecked:
	Q37+IaD6mdUASjuk/5nAetxvhWnoNzo6DMGCZ+kVfJxE5qRenkf4cckGGvvQj0AUk4FdjO+cOv5uhxIQwvX/H+Eu2jy7qwVvaqiHeuvd7LFn7hFme3xUFsEX2Jm7NgVVQSG6+TRSbEi0JsqkKd0Xq5Oj15m6GTeZMCVPfHH45TvVd1a+u10mxiRbDfjq3TerFc0b22lUDEn06b1hfGI6rkYR1AOYJ34ah+Sgv/avCu5wpoM7an5+5pD9q/E9X2uVgg8Rf0u3cSd5wbvSPwo8yPiS65luUG2StHQaxRoxd1dixHD/bQ43zZsOsF92WOTfFVxPB1REy3n+1chBP5V3lQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qajKrUHhdGPZNOYjn0FvgmH5dT8IryhVrbp19cJp251Kh5EEfTH2B+dcfivFXRrZIfjcTBxd9wskE0WAKOIxKl95fnn+uBp0Xq8OeqJvSbJ6WMWvNm2OBUr7wrqxn+W0/VnJ4y18yGVWvcyWFDcLyoQnVs0eWFMjtc+ai2ESylHKuhN62sUdNEdamBlQsiWuNr87Kk0F05yMGaybGUBHw6TRWIFmyE8EpkaBfU8JiOgGH7OPdD/SkDb0qI0DJwIvKMRURrStysGgADJVLDBx4mcrXi3NKEvPgRM0dCfLV81buKtIEodvZG6OXgrmyNGKD+T88GnAXPlz9/XmpbIPtOH3I4mSn40QnJb5x9jWk+sfZ3CeviWKCTPuuja3UvoVyNop4+gcqbCT4/fy7qiNMlCprAV71t3F1q+SbAF5tV+oazasSrmgFUg68Ljbx/U+Hq+Z1FHmG/Jf5FD3jeJNrax015Zmz6JoaIhjHlwITxA/OZXcqMpt9nKdtl9S2sSB0OoLd20TWCQJGOlNn6l3vsccDRN72ZJ7+R0o/LOu5l7uERcoFDiI7uFv1I1qBvFcsWkGBFYmR+h2Jpx1p/zpYt/qno+wQrCtu01KcScArYGAkVmTX686p+u5tf0i4wfmiDlsZzHLZ6oX+qY+DnXBBw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:11.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d09b01-f3ac-45bc-9e48-08de8b7f8f60
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7166
X-BESS-ID: 1774560919-105321-9906-2956-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.52.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGBiZAVgZQMMkk0SAp1dws1d
	TE2CLJ0tjIzMjAMMnC0gjINkkzM1SqjQUAeqzGHEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan21-41.us-east-2b.ess.aws.cudaops.com]
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fusermount.c | 58 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/util/fusermount.c b/util/fusermount.c
index 254f24a98abf935846cfed754693cc1958c8d2ff..d42e16955f6d26f81e6d2a5acb040b1448e20b51 100644
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
@@ -1310,7 +1320,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 	const char *real_mnt = mnt;
 	int mountpoint_fd = -1;
 	char *do_mount_opts = NULL;
-	char *x_opts = NULL;
+	char *x_prefixed_opts = NULL;
 
 	fd = open_fuse_device(dev);
 	if (fd == -1)
@@ -1328,7 +1338,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 	}
 
 	// Extract any options starting with "x-"
-	res= extract_x_options(opts, &do_mount_opts, &x_opts);
+	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
 	if (res)
 		goto fail_close_fd;
 
@@ -1351,14 +1361,14 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
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
@@ -1366,7 +1376,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 				strncat(x_mnt_opts, ",", 2);
 			}
 
-			strncat(x_mnt_opts, x_opts,
+			strncat(x_mnt_opts, x_prefixed_opts,
 				x_mnt_opts_len - mnt_opts_len - 2);
 
 			free(mnt_opts);
@@ -1383,7 +1393,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 out_free:
 	free(source);
 	free(mnt_opts);
-	free(x_opts);
+	free(x_prefixed_opts);
 	free(do_mount_opts);
 
 	return fd;

-- 
2.43.0

