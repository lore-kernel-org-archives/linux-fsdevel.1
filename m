Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AF3A7F72
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560927; cv=fail; b=QSeBkhhGJjDYdz0HW2RPwVlM/gVK7zapuwPNGzF6ryg5R25oApv72QlHQsL+fErpvQdFeSjyoAcHh6Ekxcvdf8HF96fb9zn/bSugd19oj8l/lV5zUDaai1v/VN22kfjnZKZQltAeCUAxZau1IXb08zPPfB9TxSn3L0WNaa227Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560927; c=relaxed/simple;
	bh=Dpx4qcsXQrvm3LE1WmKFxArPEh3cBHRS0F4TbFxdbgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOAsqCWeP5qR/295YVKK0lLZUrRYnF93y0nuru/3nrDFCT8laGx0xa6VxCuzBFwLTZVNZ8pqq+77XGBW3gqECWCnkrnAJN/nzzSrqLts7xifZjYS2cfIclAjhqYt160hXmVLsiVVlIkd5o+qalBQ8Cp6YcXldVTrAj0CNY5Ag0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=zjtvq8+4; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="zjtvq8+4"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022098.outbound.protection.outlook.com [52.101.53.98]) by mx-outbound9-89.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFDTT8YXMPIjcDtJ4QhgbkPMY7RFFtB0SjGBWiEsGuyMswbYcWWAzSVs5C47xNM7SevRf8ivLtMOaHdCbWm31tS+uwjGp6AlFkLnmb3fVDY/eH4bYCU1umH8oZaRG9vdss9hbNWHrzQuChNX+ejTD+XL8oJZiSjRtMUpMXWMTA8z+mg8C6dAkzXV/eWvhYnAjDuhnnwmzPmiwJsM/rbuGf4g4i9e/JpFHL2XkAyzelHSxcVp3gZ2mrr7gcfJKrhSS5iA5UFPWkYvEsf32J6Ync3GINl0afBQo1MHxHBwwiqY/FQg8Fg6rkkpgLq1R2jI0ZPyg0wY2IGM+zZh2Vgqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNitHUjuGSW+rq+tsf/74lrEcaBX9IUyAlwRtMLf6NM=;
 b=cpjWBLa+OXjBsSoVJy80qtRW3bPcVNwVlq9Ur2Uisk2DgsR19NzZJW/aEw/Q/cWsdHP9ES2BcEnOKUaLs9tzMcnJ2LEUDOlILfZR/hOHoYWuaxBvvTEDsPWP46xprO3NdD/R87zzLyVqu90Ur/nuU/DNnBFgFo7zxyPwJo1axYoXnsAQyaKSnKSXK1gaX6UN1JWmlAjI+DcshHVILiVCjUWKjJTVW2pl25hPbmb1gd4lAqFxEHscylZA4WngvvZLb0z0DXaskMCzCdJHjvTRaFCuZMFs71SUwK3zZ6K/btyJ56kEFPrMhw4Hum/FtldcKpchfKAOrXRgKml1Nnfl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNitHUjuGSW+rq+tsf/74lrEcaBX9IUyAlwRtMLf6NM=;
 b=zjtvq8+4SbW7kP463zdBMscSfMFGUnOYEprl0FiECsXDPr945ceMPf7Cy8IDt/aiXCRKqDNuMV1SHZThLQeVQ35SsO44eIwD7OronYXl5EotcgtiAR07VQMxRdbiRMXRXUasmc6GtQmrWcNOTMHerYRUPdEC8R3Dgi6zi5JUBjM=
Received: from PH7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::13)
 by SA1PR19MB6944.namprd19.prod.outlook.com (2603:10b6:806:29c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:12 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::d7) by PH7P222CA0030.outlook.office365.com
 (2603:10b6:510:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:11 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 35BDC179;
	Thu, 26 Mar 2026 21:35:11 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:53 +0100
Subject: [PATCH v2 20/25] Make fusermount work bidirectional for sync init
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-20-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=9865;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=KS93GqBf+YOg6Ix8GsLOyZ6E16bt+rtAk0dm5oLYEbg=;
 b=/edHqNjO351caY91D7qyWtoauMfKqfUkZ5smYD0XnjVHlK7yuq6QV/8O+MUne2gdwi2UZlQOI
 sjzkBXTXgLUAFFFQ1ylW5PiP5geI9NotVtgufXomSPoyhqAr/y6foYr
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA1PR19MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: a6945293-ae85-4290-c1f3-08de8b7f8f96
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|48200799018|376014|82310400026|61400799027|19092799006|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	+GU2ZZZg9bM370exC6iNuuQ6jlaq5zKIqE+u1q2TDQsSWwVOYRU3j1zOD7WgB8HRL8Ih0w/BVJ1+jMnNMJZUAeBuhQM7NWB3lk6jCz//GkZcO44v4m8nMHIkydFNs/2wN8l9MxWfUnaZI+oiVFfSI3UWdbvFHuXAgyHn5Z4jbJBfrOtIQi9g/xhgtsanU8mgM6dBcioByeHU5nxIn0GRmgZndY3zLQHd8TJEwlV0CykoqiksTyf/REfLrZb7K9pVCzSLehLF94uGXE6R4I5GEgGH8NMWqGzzHFNNDEbEx4yEq5U+XwyeCXE3x17jtzQ47hRKB2ATPY40jpQAOXvzsyOyVYCEXJs1hm4Ih/5PVwpfHppRoDaHVG3IQZuqhlAVT10DcftejEgKAnB38sYiazd/oHXrq3RZ0sqOi1j+LN0THTg4eYuLL9bN1JiR1Ex3RYKbMKhc+SDYnfix/zCfg+cwNEo3ho3ViBhbIgUhM5FwLFhicMzIIMMf3W4CGqa/dH2wqERSMH/Bfl5wRcpfNp4nk640zDFeNGKSfeiZ+MBVP9k33rTZg5NS6M4PdZl70fuakmhkgfaxs45QMTCoqk1T4ZvXU1wYYNyD+EsSca88qclAFT5YVfhVD481xhXq/oDpNBu8ANeQrcI2HYXan6iVBycEUjoWA6fx7LOKdHDv/OxLY8kGZTfNQ0lffFl9zaqr/UOY4nAxdLc6HAh9wXJ8OqTB9QPFS4Njpi8gy7c6lXIaLt6Z9tF165fiM5fk5n53GeodbnWAgg+ph/LZ/Q==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(48200799018)(376014)(82310400026)(61400799027)(19092799006)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5g+AKiGripD+pFBpcBQFJa9x1hNLd7Evv0E2KadUBie22mFftxzXUsGusjIdjFFs+d0M9ms3HN0OFMdVASbBmvuvaZ89nnM8rxxeS45XaTsckxu8yUY7OvkGEolpg7tA7kL28bKgA6FeYSLoLHULVLKesxLO3zecmFtYQ4EOdURKRxqtenNfmhEAx+3Hk+iyRzuB8jiVroOO8rmNx44fxErldkoNXUOrNBWKRlnsRcduHRg3aTiJzqH3YRl8vBQzj0oIvS0XSeK6dzNYcGoLbgjNTiIu3EQfY10YJKucBt6mv0oz7HiEvW1k0u1akhVIkczXKV8EfyuMVGnLVMoCWbeKNVuu4EpQrqGMpauFLBJIQqBZw1O1/rbOMIRfs2OPAA7xHsxah4I4IGpCvG/MJncn6UFwdUV1MiaB2Q9RNX+slJa/h502NFRq9sO6ABAC
X-Exchange-RoutingPolicyChecked:
	Q3CjBYvTTVpPNKgpqsDwOKPQjngboRNQ/figQNK5h6Y0434lDWBIZUh60sV8J2TBCSKQPQjsFwU0T1b5YQogNhmRW6E/w2NyiTL0Hw1fgMNEe2Or2p+4GpHWZvfFyF19Ykawql7frLsjgvbl/5iTYvyXuE3Cp827cmCu7KA5RFkMV2wbXTl+uf7i2ac/ddzEV85yjHec4Uetp59qj0h623h4zr+vRoT0lXtktGQgUO0rJcoTyZe2JHUii4W7uSdeK48g/ATFThb0/qqS9Wwyk9ysAGdXB/hiNwOEU26TE0DtcWqjCxrrEi+Fqmf/Ca1ucP29JsnNue5nai4ausjgDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T8qZOY6S3CmNdRvMdmWkje52t8oeySDjELxRGAwXJjFCaKHnmihi5VlA9U1qJ4wAq2gACOVvgBxCn4zgmZpsZL4sfzDnkQJ/F2oIzooJa6VEsFFy0pbkz+MxE1J6ltbNrV+CpYWgWAv6Avfro281xbihnofjg8Bs7U3cPLOblFRyPvYPrPB1xuhUtaqjxdMw2gJ8+eX0D3ztIcACgTPwyNa+CkOkOkODd8Ip6KqYxFZlQQbhCA+GSDt7eATC4Hk5OuNBBieWooZApWSviVaLZtrqZBJn0ZR478q/PXDg5TKeAlvyRdkPxCEyDPpM/rL4Eu55sGCgSXDJYkCK0KksMGuKCtMytCRREFCmhNpsJmk9QYL6NxNyV+Z6I2w09KDpWYojG4uY+AmK/9ur6Pw0MadVUVgFiqCW0KLKmFKcSdbKFe+92GNU+r/WyMyG2EsEX4emJju1v/Z8tuTM99v/WIjnW539+AgQhPL0nnRzQybXQVE6zNRNYoDNeRyXT+UWjCxq1nasB/Avs3WepxccVCBz0tykiF3Zg40bnlvhGRq77RooquCwbI+z2ZKxgg2ptMm+GOd15J4MIYA6CKe9jxiVlOpY+Zh/ikpjtP9DUjtq9FMBQVYFE9M0rTquvH1DspRKbMp5MSizmTOmwfErdQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:11.8556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6945293-ae85-4290-c1f3-08de8b7f8f96
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6944
X-BESS-ID: 1774560918-102393-27906-4378-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.53.98
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpamhqZAVgZQ0NDAyCgt1dw4Mc
	UixdIkJdHCwCI10dgiNcXQyMjQOMVUqTYWAJ41rdxBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan20-22.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 util/fusermount.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 util/meson.build  |   2 +-
 2 files changed, 291 insertions(+), 13 deletions(-)

diff --git a/util/fusermount.c b/util/fusermount.c
index d42e16955f6d26f81e6d2a5acb040b1448e20b51..31bf959024ae0cd2a4e50974589bfab30a100b0a 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -11,6 +11,9 @@
 #include "fuse_config.h"
 #include "mount_util.h"
 #include "util.h"
+#if __linux__
+#include "mount_i_linux.h"
+#endif
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -923,6 +926,7 @@ static void free_mount_params(struct mount_params *mp)
 	free(mp->source);
 	free(mp->type);
 	free(mp->mnt_opts);
+	memset(mp, 0, sizeof(*mp));
 }
 
 /*
@@ -1309,6 +1313,171 @@ static int open_fuse_device(const char *dev)
 	return fd;
 }
 
+/*
+ * Context for split mount operation (sync-init mode)
+ */
+struct mount_context {
+	int fd;
+	const char *dev;
+	struct stat stbuf;
+	char *source;
+	char *mnt_opts;
+	char *x_opts;
+	const char *type;
+};
+
+/*
+ * Phase 1: Open device and prepare for mount (sync-init mode)
+ * Returns fd on success, -1 on failure
+ */
+static int mount_fuse_prepare(const char *mnt, const char *opts,
+			      struct mount_context *ctx)
+{
+	int res;
+	int mountpoint_fd = -1;
+	char *do_mount_opts = NULL;
+	const char *real_mnt = mnt;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;
+
+	ctx->fd = open_fuse_device(ctx->dev);
+	if (ctx->fd == -1)
+		return -1;
+
+	drop_privs();
+	read_conf();
+
+	if (getuid() != 0 && mount_max != -1) {
+		int mount_count = count_fuse_fs();
+
+		if (mount_count >= mount_max) {
+			fprintf(stderr,
+				"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
+				progname, FUSE_CONF);
+			goto fail_close_fd;
+		}
+	}
+
+	res = extract_x_options(opts, &do_mount_opts, &ctx->x_opts);
+	if (res)
+		goto fail_close_fd;
+
+	res = check_perm(&real_mnt, &ctx->stbuf, &mountpoint_fd);
+	restore_privs();
+
+	if (mountpoint_fd != -1)
+		close(mountpoint_fd);
+
+	if (res == -1)
+		goto fail_close_fd;
+
+	free(do_mount_opts);
+	return ctx->fd;
+
+fail_close_fd:
+	close(ctx->fd);
+	free(do_mount_opts);
+	free(ctx->x_opts);
+	ctx->fd = -1;
+	return -1;
+}
+
+#ifdef HAVE_NEW_MOUNT_API
+/*
+ * Phase 2: Perform the actual mount using new mount API (sync-init mode)
+ * Returns 0 on success, -1 on failure
+ */
+static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
+				     struct mount_context *ctx,
+				     const char **type)
+{
+	int res;
+	char *do_mount_opts = NULL;
+	char *x_prefixed_opts = NULL;
+	struct mount_params mp = {
+		.fd = ctx->fd,
+		.rootmode = ctx->stbuf.st_mode & S_IFMT,
+		.dev = ctx->dev,
+	};
+	char *final_mnt_opts = NULL;
+
+	/* Extract x-options */
+	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
+	if (res)
+		goto fail;
+
+	res = prepare_mount(do_mount_opts, &mp);
+	if (res == -1)
+		goto fail;
+
+	/* Merge x-options if running as root */
+	final_mnt_opts = mp.mnt_opts;
+	if (geteuid() == 0 && ctx->x_opts && strlen(ctx->x_opts) > 0) {
+		size_t mnt_opts_len = strlen(mp.mnt_opts);
+		size_t x_mnt_opts_len = mnt_opts_len + strlen(ctx->x_opts) + 2;
+		char *x_mnt_opts = calloc(1, x_mnt_opts_len);
+
+		if (!x_mnt_opts)
+			goto fail_free_params;
+
+		if (mnt_opts_len) {
+			strcpy(x_mnt_opts, mp.mnt_opts);
+			strncat(x_mnt_opts, ",", 2);
+		}
+		strncat(x_mnt_opts, ctx->x_opts,
+			x_mnt_opts_len - mnt_opts_len - 2);
+
+		final_mnt_opts = x_mnt_opts;
+	}
+
+	/* Use new mount API */
+	res = fuse_kern_fsmount(mnt, mp.flags, mp.blkdev,
+				mp.fsname, mp.subtype, ctx->dev,
+				mp.optbuf, final_mnt_opts);
+	if (res == -1)
+		goto fail_free_merged;
+
+	/* Change to root directory */
+	res = chdir("/");
+	if (res == -1) {
+		fprintf(stderr, "%s: failed to chdir to '/'\n", progname);
+		goto fail_free_merged;
+	}
+
+	/* Store results in context */
+	ctx->source = mp.source;
+	ctx->type = mp.type;
+	ctx->mnt_opts = final_mnt_opts;
+	*type = mp.type;
+
+	res = 0;
+
+	/* Only free what is not assigned to ctx */
+	free(mp.fsname);
+	free(mp.subtype);
+	free(mp.optbuf);
+	if (final_mnt_opts != mp.mnt_opts)
+		free(mp.mnt_opts);
+
+out:
+	free(do_mount_opts);
+	free(x_prefixed_opts);
+
+	return res;
+
+fail_free_merged:
+	if (final_mnt_opts != mp.mnt_opts)
+		free(final_mnt_opts);
+fail_free_params:
+	free_mount_params(&mp);
+fail:
+	res = -1;
+	goto out;
+}
+#endif /* HAVE_NEW_MOUNT_API */
+
+
 static int mount_fuse(const char *mnt, const char *opts, const char **type)
 {
 	int res;
@@ -1404,6 +1573,65 @@ fail_close_fd:
 	goto out_free;
 }
 
+/* Forward declarations for helper functions */
+static int send_fd(int sock_fd, int fd);
+static int wait_for_signal(int sock_fd);
+
+#ifdef HAVE_NEW_MOUNT_API
+/*
+ * Perform sync-init mount using new mount API
+ * Returns 0 on success, -1 on failure
+ */
+static int mount_fuse_sync_init(const char *mnt, const char *opts,
+				int cfd, const char **type)
+{
+	struct mount_context ctx;
+	int fd, res;
+	int32_t status, send_res;
+
+	/* Phase 1: Open device and prepare */
+	fd = mount_fuse_prepare(mnt, opts, &ctx);
+	if (fd == -1)
+		return -1;
+
+	/* Send fd to caller so it can start worker thread */
+	res = send_fd(cfd, fd);
+	if (res != 0) {
+		close(fd);
+		free(ctx.x_opts);
+		return -1;
+	}
+
+	/* Wait for caller to signal that worker thread is ready */
+	res = wait_for_signal(cfd);
+	if (res != 0) {
+		close(fd);
+		free(ctx.x_opts);
+		return -1;
+	}
+
+	/* Phase 2: Perform the actual mount using new API */
+	res = mount_fuse_finish_fsmount(mnt, opts, &ctx, type);
+
+	/* Send mount result back to caller (4-byte error code) */
+	status = (res == 0) ? 0 : -(int32_t)errno;
+	do {
+		send_res = send(cfd, &status, sizeof(status), 0);
+	} while (send_res == -1 && errno == EINTR);
+	if (send_res != sizeof(status)) {
+		fprintf(stderr, "%s: failed to send mount status: %s\n",
+			progname, strerror(errno));
+	}
+
+	close(fd);
+	free(ctx.source);
+	free(ctx.mnt_opts);
+	free(ctx.x_opts);
+
+	return res;
+}
+#endif /* HAVE_NEW_MOUNT_API */
+
 static int send_fd(int sock_fd, int fd)
 {
 	int retval;
@@ -1440,6 +1668,30 @@ static int send_fd(int sock_fd, int fd)
 	return 0;
 }
 
+/*
+ * Wait for a signal byte from the caller.
+ * Returns 0 on success, -1 on error.
+ */
+static int wait_for_signal(int sock_fd)
+{
+	char buf[1];
+	int res;
+
+	do {
+		res = recv(sock_fd, buf, sizeof(buf), 0);
+	} while (res == -1 && errno == EINTR);
+	if (res != 1) {
+		if (res == 0)
+			fprintf(stderr, "%s: connection closed while waiting for signal\n",
+				progname);
+		else
+			fprintf(stderr, "%s: error receiving signal: %s\n",
+				progname, strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
 /* Helper for should_auto_unmount
  *
  * fusermount typically has the s-bit set - initial open of `mnt` was as root
@@ -1631,6 +1883,7 @@ int main(int argc, char *argv[])
 	const char *opts = "";
 	const char *type = NULL;
 	int setup_auto_unmount_only = 0;
+	int sync_init_mode = 0;
 
 	static const struct option long_opts[] = {
 		{"unmount", no_argument, NULL, 'u'},
@@ -1643,6 +1896,7 @@ int main(int argc, char *argv[])
 		// They'ne meant for internal use by mount.c
 		{"auto-unmount", no_argument, NULL, 'U'},
 		{"comm-fd", required_argument, NULL, 'c'},
+		{"sync-init", no_argument, NULL, 'S'},
 		{0, 0, 0, 0}};
 
 	progname = strdup(argc > 0 ? argv[0] : "fusermount");
@@ -1677,6 +1931,9 @@ int main(int argc, char *argv[])
 		case 'c':
 			commfd = optarg;
 			break;
+		case 'S':
+			sync_init_mode = 1;
+			break;
 		case 'z':
 			lazy = 1;
 			break;
@@ -1754,21 +2011,42 @@ int main(int argc, char *argv[])
 	if (setup_auto_unmount_only)
 		goto wait_for_auto_unmount;
 
-	fd = mount_fuse(mnt, opts, &type);
-	if (fd == -1)
-		goto err_out;
+	if (sync_init_mode) {
+#ifdef HAVE_NEW_MOUNT_API
+		res = mount_fuse_sync_init(mnt, opts, cfd, &type);
+		if (res == -1)
+			goto err_out;
 
-	res = send_fd(cfd, fd);
-	if (res != 0) {
-		umount2(mnt, MNT_DETACH); /* lazy umount */
+		if (!auto_unmount) {
+			free(mnt);
+			free((void *) type);
+			return 0;
+		}
+		/* Continue to auto_unmount handling below */
+#else
+		fprintf(stderr, "%s: sync-init mode requires new mount API support\n",
+			progname);
+		fprintf(stderr, "%s: kernel or headers too old (need fsopen/fsmount)\n",
+			progname);
 		goto err_out;
-	}
-	close(fd);
+#endif
+	} else {
+		fd = mount_fuse(mnt, opts, &type);
+		if (fd == -1)
+			goto err_out;
 
-	if (!auto_unmount) {
-		free(mnt);
-		free((void*) type);
-		return 0;
+		res = send_fd(cfd, fd);
+		if (res != 0) {
+			umount2(mnt, MNT_DETACH); /* lazy umount */
+			goto err_out;
+		}
+		close(fd);
+
+		if (!auto_unmount) {
+			free(mnt);
+			free((void *) type);
+			return 0;
+		}
 	}
 
 wait_for_auto_unmount:
diff --git a/util/meson.build b/util/meson.build
index 0e4b1cce95377e73af7dc45655a7088315497ddb..731ef95488461ac21c21b1972a96d58b1187dc5a 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,6 +1,6 @@
 fuseconf_path = join_paths(get_option('prefix'), get_option('sysconfdir'), 'fuse.conf')
 
-executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c'],
+executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/mount_fsmount.c', '../lib/util.c'],
            include_directories: include_dirs,
            install: true,
            install_dir: get_option('bindir'),

-- 
2.43.0

