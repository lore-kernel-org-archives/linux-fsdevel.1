Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0CC1B86C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289969; cv=fail; b=AptWhrJ1CQjtkD8FFhB244k6iDh6YEK4mvw9PsVZXIMn8/xZiKSsUuDUNI7I2YM6QJ9JkcoSRhBorWKWUaj/M0O4c2FIgLLeZtQRJVOzzrQ4gzhnYcdwYDVfUYP2rWw2RlaElmEm4ViZduf19w54XGP9c7U5Z+inp5M7HuQfN9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289969; c=relaxed/simple;
	bh=rikTe3tJPTua9cvqH4R7jit9Nun8gizl52rBgbrpWlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ge0HieR/zM1ZuDsrxDoXyOMukAE71lc8eSoq3HVLAfugKlYf3okbbRz6nErmJdayRNGiWfQli/oqqu2td5wfS16vNhiVc2S67TIJpMhXsJgWM442FDN1eU8526tdUzUhnJTQ0x3AgNcrwEXwt4ZFJy7x0hKek2JRd8xamLP9eNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=eKTBJ3TL; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="eKTBJ3TL"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021085.outbound.protection.outlook.com [52.101.62.85]) by mx-outbound10-216.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzzauNoBduQ38OJiJoNLxIWBAHAvxmHvIfr65fUv1VdO8esKAoLNQyH/l1nV5D59lr6jVxo9vEnCHf4iMrI7t8Nx31dx8NXHUHo/iuCalBkIwv+6vMp0EI5z/TTBYek08ZSI6w1aQ2p0bVlgj4FZ36OG5xk/EzRTRe9p3pvVhDaw03922ub5OgYRFlHXQL2l7ifeDPdzkjmhhzwfYhOlkdtSdfXyqpHwuHXFgXEz8nNEV9O2l5whIEyutnbBOxYfmV6D7y2ojrncideIGrxUAzYcrX7sPSLS1hAnabHkCFWvnHB256hgPVlbOy3nIK7wr5GDJOC5T1Ayh+4ufsXM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y13onmlN+wweRNpNdX0apnaaYxhtkDMX1Gm41XNnFVI=;
 b=uC1R/i/5DeJDV4bpTF4K91BERTA4RgNCAzta0cxJeY3cbkvZ1xTjXD0aej0a9SCQNrkxb3IXYyIxOvj6CO2oZus502q+0x2p8BqmAHwLqneHR1Niq3mDDc1fYWGnhDbyGgDdfepSQYwsh5QiNmJFmqOxQ7yl/X7vYVilKcyr0xiyvithm7EXxLtvXF/PCfwEURaJKz4XiG5FNPsXLbqfTfTGy3b0HgRLqX0YFNZSnpvx5DSvYcVW0KNJUNFdH6lVxRHcML3U+czAVIT+LNGVvMi2i9O/VrPmHl+2ptNhRZG6oN5ZLgxLKhI/JWdFkGR1+ZNBL/MV6oayX+/RlOzcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y13onmlN+wweRNpNdX0apnaaYxhtkDMX1Gm41XNnFVI=;
 b=eKTBJ3TLlx3iCNEhQa+mWWuURaEQtTWKu4G+bB2OBEm+u6/PbcM3MaVHzAkhicAMSE6AJ1QQC8T5+cAGHboo53HgN4m2oBASlj6sdg9NEEbDfZ7/wZ4smTxD86dG0s9Bai6nD/xBCbf1ePLGdD73SgFnwvJoNwckazbf8+pgKMI=
Received: from SN7PR04CA0070.namprd04.prod.outlook.com (2603:10b6:806:121::15)
 by IA4PR19MB9068.namprd19.prod.outlook.com (2603:10b6:208:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:14 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::69) by SN7PR04CA0070.outlook.office365.com
 (2603:10b6:806:121::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 17:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:13 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 799B315C;
	Mon, 23 Mar 2026 17:45:10 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:02 +0100
Subject: [PATCH 07/19] Add FUSE_MOUNT_FALLBACK_NEEDED define for -2 mount
 errors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-7-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=2063;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=pMUV/zOXWSR+38toNz0L9bvHSrrPTLhVtLRxZfpeVqw=;
 b=jJJk2h548S1lHrVXBiqFO8O+xth7TnBKQax1mKTFLeCxvu8eWJPg//DzTQIfmTge4HSNYfeEZ
 Dab/5K1IGCmCCkjVcP48+uKEdjpgtZ/RLEOaa6fdp0ipcyIF3YXbdQ1
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA4PR19MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1d8d1b-67c4-470e-ff90-08de8903f025
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700016|19092799006|48200799018|16102099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f3OQT4LuV6kv5hqLgPImytmCVu6Fbtldwu/YNeyxb6rHBafJhTs2dkQ8d4e5PkRNpjf9BCKDOlXBg7arzoZ7ct57fXffTm5UEA558eBDPdl2YsHbvN8/yQAfE6/NI6WuhDekQIS+ulQ4nwfx4zp8DxF410DKa7HreqtZK9WUIRAKeFKMpt8e6N2TxMnw61434omfINsbjn/9wvt2D6IHLBO7Z8G3XerpLNU+65GPlv2b3yVQlEjjCNtpMOIjP9AqwjJjaHjhW0S/rqMm9TOZIB55RvCatc1ytIk5f6ynmsrSIP7hPByZ37xiaH2685hMBTChJCawY+ds5v9SZLlGWUt0HCeDslPrY52Y654o5N5VbcwpuJeSOtm/RioGIANwkcEzlzOkLJPWKFSpjsnOJO+thlWyYgSItPViqSGRTPAxOedNKYgwQ+BzFFfHgSDCztLe4UK+RMr8quRR1HG6QDjDd3EReV/LJVYwBU52sssKHoCt2XzAhhppWM8uYIgP5uuaBWJdFvLKaEJAdg2ojuyNU55h1p2NT4FnQLyS8Z9aaAZcg5rBvxYI9PAYRwE8cE5CEcvfy6jtMuY8Z+hah8+Oa5e5YK0fr8U31AC1N8+BCd59gvEpFZL86buMHt/akKJr1zIAd5YNl1jNQOD2ffhYJ+dA/BghoSx5C6U20Y94hLbyNm+VqaB5uFOGU5jVvf2OBxqvyuPTE4Payuju/20VLThY/iudtr+sEmpd+AlLzsk2kHiorFvqFyEm3cZwOxpT8rzBqagVxbMNE4dLrQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700016)(19092799006)(48200799018)(16102099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	447mi9jOO63qGMjvQoPcG4DxlHBj9fig9NwChf8FEXNo0hEtx5YOsyGrG2otCldvdewpObscwo7YUkdAH81IXoBZp5Z0hPuZOPqQfBF52Rnxm2zXe4Qnh6/byK8YcS8NfnHoHfwzDwammpSwR+/dl/4gWFUFiCHzRAZOPdAMkiHIaSJfwPa5WdaylDBeA8mWFpx+Tnx1M6ndP1IU4vAFP1/2mcbjkuM96eDrZ2LgZ+knT5xAVS8yzFh045mipjDcMy4acM+uk3neDqugmMvuyE/IuDWJhjEqSsGgln13EkpAdsmtj+qK+q6qkDCfhAA2MO3LFze4fq+AVT5GqkVJxqal3iyuu2n2SwYLhvKaAaBvvdNksayuO0bPAhE+jCr6/z0eVN5qK6A/dwsvwqKaJlGPNT7HMumdqjht99KykQqRoCKNhdMKMsBbICt0/NHt
X-Exchange-RoutingPolicyChecked:
	GZzwuSfiKfM6jR6oHvZRhocRLXnx3C3/QTUXdxzSQOFFfxYl3RJ/Ww+2WNKTnTPLw7E3ReUS4HT74BJWtAI1UgisUCF4QNbtCUGIYSqwLi9sZpbOJx9VfV0fu9ew5U4pl+x2E1S+S3B+OBysy+OTU+cl9ZDFFpr5a+Q40ewVbKSasE0zCwipSWXrB7RGPiml/biEi5GyFwB5x56YHHliKfYR3pLrPU733o6srlfwANF6pOq7gKC9ex+qSjNhxNlS+dOS1lwnbsRvBWHrZzoO7rCTWYYY6mje64ThiXaX1iVG+UH72eLyimj9Uiyk8wLOQOcYuAraWcfHQLTWaz48Jw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qgFldpAL5vuvb8W5Z2Sxk/Ebm0iZZReAVHe+DFvcsmpEqLtnQaB0+jDjScBr5CIcL60At6LHs33slMvCwU+JYVB61HqCQvfry5Ku+OsMewc5rwQ9nGQRxX7YhfDkvtVqB01IyQ/MDmsyMG/PwMQVOt2txmtyRN4V+RN7/gW99C/a9d3bojCoczfoo89pzf2Wy/tBaQq3rPBB0za7BXj2OuXpb8YYmq4WXYMvlxZTsva3svlwxrDK+sEcjO/bb85z3g8rAl3DJGT0U85bPMzeywonVM+ZT50IZFGltpLjZM+h0s+5T9aZCjeb184/6CIxwcJKoD8tyaTxXVceMYxg34eL9/IEDYZwyKyKFFCYkKO7u1pSqZmGPpK/5yhLo7hXdElj3Y+/nnSox2G+snRLghenPrpHX7KPJVELkWf10dsJEv2Rcs+nL+kDjhiexonSOCbXDs0R2NlsnzK7PWnbjjzsfAf3jGY6cVooS0NFF/lGIeVQzT3fOSmv8bPTZHjToRYyHmh6q9eNHyiUO4O0AcX93GWtjdu+4kn0O+lYCwLrqrqBdpquRTDwPlxRxoA74Vb9ETYfFogh+50lf6ANZ+NzdTZNxi5IaMYltd47EL+VPiFb0wXZfZN/akyL9BLXv6KseDzWRvfVNapyZs0Cng==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:13.9280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1d8d1b-67c4-470e-ff90-08de8903f025
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR19MB9068
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289963-102776-8907-5478-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.62.85
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGpgZAVgZQ0Mg0KcnE1MLY2N
	DcxDDZMMkwOdUi0dwiNcnM0jLRPC1NqTYWACXxNaVBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan11-16.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Magic numbers in the code are not good - we better use a define.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/fuse_i.h | 3 +++
 lib/mount.c  | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 9e3c5dc5021e210a2778e975a37ab609af324010..b4c1d3eef41010287f6c9555ec0b2442d904d192 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -217,6 +217,9 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
  */
 void fuse_chan_put(struct fuse_chan *ch);
 
+/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
+#define FUSE_MOUNT_FALLBACK_NEEDED -2
+
 struct mount_opts *parse_mount_opts(struct fuse_args *args);
 void destroy_mount_opts(struct mount_opts *mo);
 void fuse_mount_version(void);
diff --git a/lib/mount.c b/lib/mount.c
index 6e404451cc9edc8e35434cc31f25612cfc4edca1..dec9d52274c13536648cacef959789f472c5682c 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -563,7 +563,7 @@ out_close:
  * @mo: mount options
  * @mnt_opts: mount options to pass to the kernel
  *
- * Returns: 0 on success, -1 on failure, -2 if fusermount should be used
+ * Returns: 0 on success, -1 on failure, FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
  */
 static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 				  const char *mnt_opts)
@@ -611,7 +611,7 @@ static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 		 * case try falling back to fusermount3
 		 */
 		if (errno == EPERM) {
-			res = -2;
+			res = FUSE_MOUNT_FALLBACK_NEEDED;
 		} else {
 			int errno_save = errno;
 			if (mo->blkdev && errno == ENODEV &&
@@ -749,7 +749,7 @@ int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
 			umount2(mountpoint, MNT_DETACH); /* lazy umount */
 			res = -1;
 		}
-	} else if (res == -2) {
+	} else if (res == FUSE_MOUNT_FALLBACK_NEEDED) {
 		if (mo->fusermount_opts &&
 		    fuse_opt_add_opt(&mnt_opts, mo->fusermount_opts) == -1)
 			goto out;

-- 
2.43.0

