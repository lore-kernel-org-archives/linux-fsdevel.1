Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086937756B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560920; cv=fail; b=eckol5Tlrqwqgv0L+cFBi/eM3dGDPgjRryyBL+c1TLT38MSTU1R7gjSn5E3ft+zkHAgdYUeOzDWU8BjIq/DH4Wa3RLV3yXjo4m95YVT+tSxw3X2i0BzeoTcBGGQgTvelOHLClbfbB8NbSMGgwH8WN7KNpiMFelYq/TeXe2I9QQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560920; c=relaxed/simple;
	bh=RMixzQV+p22yFQX5BhhqgsYSjAkdFPnbXogKYsLaYXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJm66gjV6pZwKTZnA9QOxdNx9UM+OuJvMSknF+6bqyl1B3eMpJdWz17g4mJfN1J3VnRvdoAclA8fzDKotwqfErg8CGIfaB8H5PHtsa+4LuVNOuHnG5ugBZgtKQ1A5tZb94I77K5tDRuIsjWuky4vPzPGuJkzMsP+THRqELdv3xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=nY2OZTDe; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="nY2OZTDe"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021108.outbound.protection.outlook.com [52.101.57.108]) by mx-outbound20-201.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unaXtroncdRO9AtUQEJP9jS4jQ2XshL6nwWm7PyaG9LtYydPQSdAHQXEBYrJiyeK1u+Ec4hGYi+M4mkqu3xCcVW6POS/uQeQmy+7bIEe2ZEBeHnywnYsgQqK3tLE+WJAgtXJ2A5EMLxACgwxTT458je2q4lmSpsQLQlHK37kzdSBEMeMrZsNJZpjLmRgXYjIVtnJqpdEYEaB+A3fmaUwB7kBcBrEqYGvVguOV2NSQab73H+5rwYWLuYLHV/1+m+KD8hHBX0novh/CNN3wuZo0CqIHExk4vjBj6INU8kJuH3fP8Brp1DclXeacwC3Lh+kyd7Rechdlj+UJVVOsBj/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDSNGNKFuyD3s99nmGHHgOXlhmyH6j2MxOJtWQy2psE=;
 b=CTvyrQn+C9ww1NiMK+RK6CHUIjwp/k2iJi2kyZ3BdR85POvkEMvX7PBsSF8J9A5QbCRv55yTqBtuu64uZbK3bFdiqAiFXJxo9+nu+MIg1GLI3/BgPenqoNhAuNRHz4HkMGNwlkaIL9zxvgj1CRMKtRWIAFNNcW9lVsTM0vfSNmdFyFpJZa+HzKcXR9aF3Q9T2uqIEHKr63MNT9BLKWY1AkIffpO9sRPBsnFaOMG3vNTalnpZt7fDaXJq/ewGfBk3/2jUN+4SMuOQLvVAIRhT9Y3SMxzyUEjyPUsZ4qoUSgFBMXof94YglcOWMb+nbwRdGH4ZfBUdaJaijlVLXPQ2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDSNGNKFuyD3s99nmGHHgOXlhmyH6j2MxOJtWQy2psE=;
 b=nY2OZTDeaMPLOatFds+nO3eBe6k4YRqD4MJ5KJtkSeFfDK9CGzH50aT1Q1c8niFo6eccFtdDGlN7vESEWQajU1sZG5YkFPagomj3EN8Io/xbuya+6Lml39tptEWghxzMxq3I3gMn7ngwvQVYK81JwNDpcaimstgJNF78gq4nE+A=
Received: from BN0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:e8::8)
 by IA4PR19MB9140.namprd19.prod.outlook.com (2603:10b6:208:54f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:00 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::30) by BN0PR04CA0033.outlook.office365.com
 (2603:10b6:408:e8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Thu, 26 Mar 2026 21:34:59 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D954F8FD;
	Thu, 26 Mar 2026 21:34:58 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:40 +0100
Subject: [PATCH v2 07/25] Add FUSE_MOUNT_FALLBACK_NEEDED define for -2
 mount errors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-7-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=2065;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=qV1kvV8DIm67vl36ErlbJta+maPI6Nv+Oeo1VAMPcUY=;
 b=N8x2g64ULePPIX1n6HnZ5oeelhIyGt9W1itc1YwM7NUQ0Gzmx7YLj40ZUYznPiVThmB+Zh681
 eCPr1Uoy778D9IKNy/Z4Rroq4ps/KhJgh5V51a0nhueDB+uxUehM9Fs
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|IA4PR19MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ad3086-9fe8-46a0-1676-08de8b7f887e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|19092799006|82310400026|48200799018|376014|36860700016|16102099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YCtuINxaiMVgxDntOrab942dwmvF14H40JE1nM6xVeBNlQATQ9G+6OFA0k963w2D5xMZeDgCcJtKwICEPuIkSvs6BPcocqpAV/oSuP5sbWT6Gy0fEjt66RqyHypNs/mqBGu3/MVDeDur5mTFuw4lT5U+RYOkPWQTc6RRmnY05LTlHjGoyeIV7my0xzi3JYz0Ab/o8sEih6rmnUn8h7p0nUVbHCp0pQ+Y7LFHx8DodcZLCfuTph6vG6IwyxeQmhrtlCBNcZQOJ/ErzGDxay+nduSCs1iPycOzBQpgWZWDzg488uKekW5X8CrYJAPbn9xYni5mvHit4QRjD/VVFHOf4z/LOB8lP/Jmwmu+LG8rgU66RDIvVdBGnevfcbEtQAmUJosI2LdU5pdws8PlkCkMTrM3zgUxMrGW2NmMJM7GNzvLRCw+Jbk79eDPuZAQtTXmBH3Kadf+UNp4ACN5kIAOTKPgHiC3JB4GNKwRHimI8hPzDNgBlDkthZHSzxS/WGrIBBhCCsV5q16ZlpV0sX2QpAnmnCmONxeOC5rc1go31IN49vU75Mt1wdfLmxH/8eMBsE5E0ZS3kmeFxjtJKEubVx95MlWmVQWiUrH6FyKjmR1cDsJoX7THhKgR0EbN72oxFOqUXryhdzWblnKGihJQwFIHs6c9zXU/ViMCjMC4ZLgwR+bo2GfNFNdP7dZrVpd5Gc5Vyc61kFgZWY5ICRBJPBwPvpvDJ29njxGNCSw54d3iVn30q8KIc11KrgpGig6/65y+bG9WK1bDmtB+FHOs0A==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(19092799006)(82310400026)(48200799018)(376014)(36860700016)(16102099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VYTwYhpYoIm33oH3E5DZcAFVqjHDtfDQU/zCWThUvwb9/1/cVrd9CUo09MQf+2S0SEloQYjzKdBDAi3UFB+7ipGKP8p2bJFpRMGD7vo08AK6R5EhRRfqZwGnp7VA2fgZbIKV77bCyadWJOrnwdpOlfkYbAKSVJ7tkwWenl9ADvIONhwHfWu35TTmh93D5WVPab3AEYFNO+oo5kxemWL1/6yvEbg80ONsdZvTQFC07JMr27XwTVh6Of9gIkZQR7Dljf/1oCIdZ8LbWoH1zHEcXw3OoEspDCGJuMQirnexuzyj9wXZT2MeCclrDTnpyEHE7OdY6ZdRgqooJHKp2egzHlSBBZoh6mfu9motGtz16taYGc46WIEZyAOANXsk1Y+SVrGuRvtfCLxS0P6WMDXSm+SMZVjzA4IHi0oPza3zlWo/TT2fqrOwHzyHdiCcABRm
X-Exchange-RoutingPolicyChecked:
	RmAOU5pSPE6Q0d2NQU/uvi4Jja6M8yIeCrCjm7skRQ9pWyKzdzhwOa10PEXj2Ff3z7R9NvnDr8TZ+ZQP/uLtnYcEN5GPwvEZ+IH3zUURgdYdRMVDjtdUZHJetyyXJkXxudsNcTIBZHo0WN7y05RrGJHe02YUdeGPu0bkoc7r3cjpne116+vjMb9gqTS7w4SS7iwVVnS6TYryzNkgpAgVv5hQA5USO/yt1CIXAQLxJpFVkAzoXXkmSXDUJSg3RhkP8L6nEdLSzY1GiBgX+ruocRL+oidE0hFAlroyzV7eVPlDe9jwvJH+22pH2IjRo+s1G+WZKw4D0wvJdqx7ON42jQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LavmDmaVkkHxcQi4JgtFchxI5ecjJk3IGriR70oq53e0jdnZkzrjOcyHehoHto8fDo7BxqZ6xeIaMytUj0y4yKjZ/G8LNAyZzCntmOvo/egc2+k4KLRL+PLxpWEY76YOIcNOWFMxtvKLG2S/yRVsZ4l4HA/2eBT3+tuAdu5Av4D4as5iS6WJLS/9xpJOs5vOaFCs86IW3xG2PAv8QcS8d43qApcnZpfmBE2ixpUemeBUv0Hb8rgleeswEQqv8ofkGjEa0jQiuMbW2emAeU2bG2FJFhzhR+g+LjEHxHxB+Lca25P4jTG0Y5F4fum340Gxx6S2Gq8aa91DuOLTz+glrVTfH4GxJso4hUSQtLwuFy9rr3ZPHoHkTaKKAD7sLwjx9oCoGXKr1PzxQ88h4LWqnRSKbqhgGAZOyusmlWd9Mp+ry49CJfcff52OhcD9sGLMTCS9R1AG/VqhFXF+5L4GXxwi2BWSAIrXxEashdUV57CiEInQQzRafOF4Rv6SsxV3uYVDhnNIvsXh8/xACq9aEp+ayIllR9ByynwJi9P1SkvoVJLOh5Dy5PmgjWnVvcWlNO4F6tJoeR2Pr2MOFqjTSIys8PPThqQ/2G1kgDGJl3P6lx0DmEGsjzqzwo+Vffsdw2Sa1J/LmIRrQfd8SyEofA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:59.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ad3086-9fe8-46a0-1676-08de8b7f887e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR19MB9140
X-BESS-ID: 1774560902-105321-7668-3031-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.57.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGpkZAVgZQ0CAtMTU51SDVKM
	k00czMMjnR0sLAwCjFMC3VwMwgxTJRqTYWADpWtrBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan22-90.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Magic numbers in the code are not good - we better use a define.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/fuse_i.h | 3 +++
 lib/mount.c  | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 9e3c5dc5021e210a2778e975a37ab609af324010..a2438a15afdd3b5f62dd35bc3514f9f6853f00c3 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -217,6 +217,9 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
  */
 void fuse_chan_put(struct fuse_chan *ch);
 
+/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
+#define FUSE_MOUNT_FALLBACK_NEEDED (-2)
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

