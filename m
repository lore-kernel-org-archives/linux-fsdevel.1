Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DB3A7F46
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560928; cv=fail; b=W+5/dbTUblBfH5sW2Ip3HmMncl29uS+WmnmFkLk1qTYqwZcy+7g4lBOqwVKMfcJL3Zyxpb0ILYwlj+sy0ekoKXnwsoFacrhU6O9KnoEAaT/3fICGQcylYDqiXj812dlycTIeIZGc4Siw4L2iaOIDpS5H1UMfnOFwCuOjquh8f00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560928; c=relaxed/simple;
	bh=MqCvl9bY2qTSlwbtemHTAmJoK6fIjt72Tm/RDD8b0g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8X7jjTl/twO56JUF8sIrh/LtxuRXbFWTAbK6vDB79msZTHR5R6ZwMNWEmRaTTP+WKzZ+GztZ56CBMqxVoJKjqJrL54SnzZ0NkTETeOEuLMUVDqXp00LYLmApMiXd7HRIsYs9DuIgLeaJ5R4t8BVhcmxr3EE6388sbN3sYhu4II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=OhUmfpSc; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="OhUmfpSc"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020080.outbound.protection.outlook.com [52.101.201.80]) by mx-outbound46-111.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guipU+EA5VkN7X9uXcJdH5spFA54FQ3AaxlDCuiwwPR3uLrjW58Cu6MzfncLxygkl8p8FG1BBTWC+9dIHYyToU4f/byhhu5LUSA/uhc9jTplsmWmDkcgTHkfbSBwN7Perf8RA+3rE3b867tMQpmlo/M8mJ4Ra/qIB2juXcreb/xvSJBZW+ddLrPRoxHd/BH9be08L8W99n4jWrPASmM5Ab78Jfgtn/VYHCstiVF//s0OLjhc8AqApFGTp8NtCMnEXY3lSuIunx7tO53qDQd2sFqtYLMXkRbkJyAz35aWUc5O62NRCO4OQPdGWUNzRTAfrcvMXO6zRXAh3m2JreB3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQID8BDtCyaAu4MQmadCI3T8egvMam+A7yf+amVSWeE=;
 b=X//RNYdqxnEQQV2/4iyidHod6VAaVDXuoYefs56Kvo1C3NtNW2qz7dmhqidRY0jHGKDsYv4fS+M2NgWLSe2OXMVCvBSwurIRUKpqVWqCRAw/FSb3TRAUMyBqrHYVBDctnZAYeoAJNyx7nioVxkNrEzJIIL2++SVp+s820pByL/kKnuFENwmSLtyHUypaWuU5TBScBRybfLGpjAFkcwYtTt7KEmYfWV5OOr/o35nPLd56a5DidqTw3XMZ9pBTkE4x8av9/z6BFVD06IRTRlkAzMwqTz2XnNd+KrC6zbJjM0/WtdattgV39kwrI3xmapGtBw/VVOFcvfJS+DrMao/RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQID8BDtCyaAu4MQmadCI3T8egvMam+A7yf+amVSWeE=;
 b=OhUmfpScON7ZKMJUe1gKdlXcNzZOGqXS1VNOplJd8EgdJvzCA20toIx9qwOl2Me5AJnspefQtau+4spMMrT6nHw0eBT0okxJFDR1vutsmuaavx+MTTCLeOvWbESnrWM58IXVo2Ddp6woeahGkrjLpVZdE0bW4QAI1ETzlb2oUNA=
Received: from BL0PR02CA0119.namprd02.prod.outlook.com (2603:10b6:208:35::24)
 by DM6PR19MB4229.namprd19.prod.outlook.com (2603:10b6:5:2ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:08 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::2a) by BL0PR02CA0119.outlook.office365.com
 (2603:10b6:208:35::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 8CBC3179;
	Thu, 26 Mar 2026 21:35:04 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:46 +0100
Subject: [PATCH v2 13/25] Add support for the new linux mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-13-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=20079;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=7nACFye8zw5Jkp4R6yB0IqcO8BbXv4aTgJe5pEQK5Zo=;
 b=p5r7BVQddgOuo568NlIVEBckzSgpVl+J52SQcPjUMS9tKzvAS4FW9aJpMOCv3DiebQ/nl46xI
 cgHblvCynzgAqBRt3C9oRLXQ+Kgry4CFoRBE+jJef0PD1jgEJtmH59Q
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM6PR19MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7871f1ed-4dc5-4137-11a3-08de8b7f8d47
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|19092799006|82310400026|48200799018|376014|36860700016|13003099007|16102099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gAP+uuEbbsFMddToZr9rWlNQxrMKWRmn3Ed0UmS3xjcDbqHbRgI98sRTtDit9Kr3KUD2U0nwYDLswAC/SO+fP7r19vRRyon9ToshpormRZ4PIaxT+eQaFOgn72Kam51MpJr3Q/XNNLu58iOYQZvyuus3ALHLQv21N/HQslCDtURn2NkRan9AhCZ9RofbR89ZdDL7BZVrf9k5SesjC4gv+GkuXPtcRaOFiIpggxCFD1CCu6WRhBbdqHdO3aZIiO1oW9/CbFHVX+yikGxn+5uhLn37XMpT/UFXED3ETEiwZgLnGMMqebqPHB16k0rDS2KfKmS9KkdsUn9sC+BenlOdQSP8350vb142LsLk1nEPGK38qWrXwBvJv2kdh8L1tW6ICjSTYzuHZcwkvJI11+nn9oowVbS9njYe3v8wVKscaU+dPfSvDg+GRPd+c76XHI6rw9ND8VPaUdmWGPslVOw8sg7Fei5k4Wjz+QojzS8ndIiDQh31e69rm0sl572Mif4xXYxagOQOtMWoc2UvkINy/kZBlEp5T+l0EnUhhXrSHxdCeq+bS/deVP6cb63byqARBUNlS7oQC8i4AbOjhWIDB4WbtYHS9JAuOvfwOyIJ0rdYKSQP4i6Gs7lK7h3/oVuOhk+GVNII5apHi63491mUoubnOHzJzskgrHnGdb5nFtqqAR4LTxtsgEx+YsEyaU7m8YZ4qokpIpBj3EWketZ8Iw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(19092799006)(82310400026)(48200799018)(376014)(36860700016)(13003099007)(16102099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NsQSbRWdc6is2DvpN9TdzVVCL8JWCCPZZizjiHmUPtBQEkePCG7oQmSweYNRU+fNu/0ghDZEjYgjvrS7+3ugAX2FEGFmFO2STswSA80vx2LwYpRNML6LZHhGt4lgXF2U/kx5OvfZJGSfHvECkAz4VmoBSQJnFaLCxtMC5PWot5QQ7tu5pne1/RmeTz6KxgsAoDwbmPlhZKXsQVGq91xxIJeOO1wFlcRSCe4y6yTrnXRlgp2lY0Shxw5xrP2w71ddt95FCa2LlFG+Tw++Oc7f7YilJiKye3HTxjtYROVO7vxJmB5T224bzxSAX2UqrhCOqkfNrn4OcoBrIlw+B5ngpF8OPfWcdj1Gf5I0K08QjWIdva3mi8QOyqubKOett/TjKfTKTzt1MXaSq9QnMLHL23ftJp3+fUsndjW4ksywVGA1AX9VLz3SMuVO58NlEVYh
X-Exchange-RoutingPolicyChecked:
	Mv8XFNJF7pTEAz+V+MQ4ZJ+/srf2bxMIbhuG3tnLUvgr19zIBV8CKRHOaNFgPuIOWtaZxlUR1g8+genW1zN8Mpu0pil9bfTmusVQVESmgBoDl1hpmGyav4ryUXTaZASkv7XOHyVPcZNxN5BOgTatowtY2eYHs4rok4SKtrTU2eG9zG2whGj2DceIm2m/udxrv3iHhOCKzM0hhMMq2ByVLdekpiYvJK0bDpFAhhK7kDT53gw9UWKaza86RRJrOFw9a0O0hZfC5IEJfx9SYDsK1hYRXIaiBvXSH8Z3ld1KWS0TDMz9rA9WTv75IpWw+CiRup0S0l0lmEFWsMgz5hvL5A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l53Wj5vbRHTRew1iHmqCSOJM070+0N5jK5RY8lKYI9+06aiWWw55LOhtEYl7L1A3yKKnG82rg4rVKyvruNZTmBCjq9MLfIUHgVEnPramaGZ532WC36KLo9fCuBX4uqru8k/it+VKFqypYIuBfq26yHpKC42o7PqRE6STRkCH6OweA1dunMmG1VNCSDgKgUDA/iokkIYK/ZuSFPIrbh6ZY4WUsBR8b55F+lJ+geFvKk2R0fTYd7GdxcO8ntIYmylArsQBntfiU5akBOUxZjgGUz6XaWxp+oK2/HSuB6lqZ35FgzHdqHZg0upnY3d0Wv6dTrhlOi2NWvuiV8ZGSittNNTACUM7ot7rGSVJy/DQ8aYZZOI6SBieQctANnAGOAv2zIpSwL7lWLml22/rAZj9qQ5PCLXu8C0Cq4o9zqKAxmtpgNkCC1o/UmNhL9Z8Llx3koXdc0BUiMo/vxpgFIb6wdBpgWLGeYNaUWcJHlONgSmXsp5NwwmZ1UIfGmT7kO25sQuZYeZiy8AqqDrSdm6MAtROp2bYPGjo5ywkZwZJhLmLa0A/M33525JRQLqFfACobHRI6zUc1eaPMFD0nmWLRKS8W2WJIOSDv1shJvHHVsSwc07BTMRcA9WHQDe2tR8RTu3MjPi4k8QwL9L76d/Qag==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:07.9309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7871f1ed-4dc5-4137-11a3-08de8b7f8d47
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4229
X-BESS-ID: 1774560914-111887-9658-13402-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.201.80
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWJgYGQGYGUDTNyMzYONEgxd
	QixdDC0CTJwtDAwjjVwNgo0SjN0tLQTKk2FgAPKi/uQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan8-67.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

So far only supported for fuse_session_mount(), which is called
from high and low level API, but not yet supported for
fuse_open_channel(), which used for privilege drop through
mount.fuse. Main goal for the new API is support for synchronous
FUSE_INIT and I don't think that is going to work with
fuse_open_channel(). At least not with io-uring support as long
as it is started from FUSE_INIT.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/fuse_lowlevel.c |  74 ++++++++-
 lib/meson.build     |   3 +
 lib/mount.c         |  27 +++-
 lib/mount_fsmount.c | 454 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/mount_i_linux.h |  14 ++
 meson.build         |  19 ++-
 6 files changed, 583 insertions(+), 8 deletions(-)

diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ccff6a768f0b8c32469abda9405ff29623f3fff7..a7be40cbb012361ad664a9ced3d38042ba52c681 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -20,6 +20,9 @@
 #include "util.h"
 #include "fuse_uring_i.h"
 #include "fuse_daemonize.h"
+#if defined(__linux__)
+#include "mount_i_linux.h"
+#endif
 
 #include <pthread.h>
 #include <stdatomic.h>
@@ -4398,6 +4401,63 @@ int fuse_session_custom_io_30(struct fuse_session *se,
 			offsetof(struct fuse_custom_io, clone_fd), fd);
 }
 
+#if defined(HAVE_NEW_MOUNT_API)
+static int fuse_session_mount_new_api(struct fuse_session *se,
+				      const char *mountpoint)
+{
+	int fd = -1;
+	int res, err;
+	char *mnt_opts = NULL;
+	char *mnt_opts_with_fd = NULL;
+	char fd_opt[32];
+
+	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
+	err = -EIO;
+	if (res == -1) {
+		fuse_log(FUSE_LOG_ERR,
+			 "fuse: failed to get base mount options\n");
+		goto err;
+	}
+
+	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
+	if (fd == -1) {
+		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
+		err = -EIO;
+		goto err;
+	}
+
+	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
+	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
+	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
+err:
+	if (err) {
+		if (fd >= 0)
+			close(fd);
+		fd = -1;
+		se->fd = -1;
+		se->error = -errno;
+	}
+
+	free(mnt_opts);
+	free(mnt_opts_with_fd);
+	return fd;
+}
+#else
+static int fuse_session_mount_new_api(struct fuse_session *se,
+				      const char *mountpoint)
+{
+	(void)se;
+	(void)mountpoint;
+
+	return -1;
+}
+#endif
+
 int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 {
 	int fd;
@@ -4425,6 +4485,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 			close(fd);
 	} while (fd >= 0 && fd <= 2);
 
+	/* Open channel */
+
 	/*
 	 * To allow FUSE daemons to run without privileges, the caller may open
 	 * /dev/fuse before launching the file system and pass on the file
@@ -4443,10 +4505,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 		return 0;
 	}
 
-	/* Open channel */
+	/* new linux mount api */
+	fd = fuse_session_mount_new_api(se, mountpoint);
+	if (fd >= 0)
+		goto out;
+
+	/* fall back to old API */
+	se->error = 0; /* reset error of new api */
 	fd = fuse_kern_mount(mountpoint, se->mo);
-	if (fd == -1)
+	if (fd < 0)
 		goto error_out;
+
+out:
 	se->fd = fd;
 
 	/* Save mountpoint */
diff --git a/lib/meson.build b/lib/meson.build
index 5bd449ebffe7c9229df904d647d990c6c47f80b5..5fd738a589c5aba97a738d5eedbf0f9962e4adfc 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -7,6 +7,9 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
 
 if host_machine.system().startswith('linux')
    libfuse_sources += [ 'mount.c' ]
+   if private_cfg.get('HAVE_NEW_MOUNT_API', false)
+      libfuse_sources += [ 'mount_fsmount.c' ]
+   endif
 else
    libfuse_sources += [ 'mount_bsd.c' ]
 endif
diff --git a/lib/mount.c b/lib/mount.c
index 43920a06ac03747595bde95441252e9cac77ce88..e8c65363d36a56f483f82434f642e785da4d0341 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -442,8 +442,8 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 #define O_CLOEXEC 0
 #endif
 
-static int fuse_kern_mount_prepare(const char *mnt,
-				   struct mount_opts *mo)
+int fuse_kern_mount_prepare(const char *mnt,
+			    struct mount_opts *mo)
 {
 	char tmp[128];
 	const char *devname = fuse_mnt_get_devname();
@@ -493,6 +493,26 @@ out_close:
 	return -1;
 }
 
+#if defined(HAVE_NEW_MOUNT_API)
+/**
+ * Wrapper for fuse_kern_fsmount that accepts struct mount_opts
+ * @mnt: mountpoint
+ * @mo: mount options
+ * @mnt_opts: mount options to pass to the kernel
+ *
+ * Returns: 0 on success, -1 on failure with errno set
+ */
+int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
+			 const char *mnt_opts)
+{
+	const char *devname = fuse_mnt_get_devname();
+
+	return fuse_kern_fsmount(mnt, mo->flags, mo->blkdev, mo->fsname,
+				 mo->subtype, devname, mo->kernel_opts,
+				 mnt_opts);
+}
+#endif
+
 /**
  * Complete the mount operation with an already-opened fd
  * @mnt: mountpoint
@@ -636,8 +656,7 @@ void destroy_mount_opts(struct mount_opts *mo)
 	free(mo);
 }
 
-static int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo,
-					     char **mnt_optsp)
+int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp)
 {
 	if (get_mnt_flag_opts(mnt_optsp, mo->flags) == -1)
 		return -1;
diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
new file mode 100644
index 0000000000000000000000000000000000000000..fbe3647a8923828dba819458b815c21bbd2beaad
--- /dev/null
+++ b/lib/mount_fsmount.c
@@ -0,0 +1,454 @@
+/*
+ *  FUSE: Filesystem in Userspace
+ *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *                2026 Bernd Schubert <bernd@bsbernd.com>
+ *
+ * New Linux mount API (fsopen/fsconfig/fsmount/move_mount) support.
+ *
+ *  This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file LGPL2.txt.
+ */
+
+#define _GNU_SOURCE
+
+#include "fuse_config.h"
+#include "fuse_misc.h"
+#include "mount_util.h"
+#include "mount_i_linux.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/mount.h>
+#include <sys/syscall.h>
+
+/*
+ * Mount attribute flags for fsmount() - from linux/mount.h
+ * This file is only compiled conditionally when support for the new
+ * mount API is detected - only flags that were not in the initial linux
+ * commit introducing that API are defined here.
+ */
+#ifndef MOUNT_ATTR_NOSYMFOLLOW
+#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
+#endif
+
+/*
+ * Convert MS_* mount flags to MOUNT_ATTR_* mount attributes.
+ * These flags are passed to fsmount(), not fsconfig().
+ * Mount attributes control mount-point level behavior.
+ */
+static unsigned long ms_flags_to_mount_attrs(unsigned long flags)
+{
+	unsigned long attrs = 0;
+
+	if (flags & MS_NOSUID)
+		attrs |= MOUNT_ATTR_NOSUID;
+	if (flags & MS_NODEV)
+		attrs |= MOUNT_ATTR_NODEV;
+	if (flags & MS_NOEXEC)
+		attrs |= MOUNT_ATTR_NOEXEC;
+	if (flags & MS_NOATIME)
+		attrs |= MOUNT_ATTR_NOATIME;
+	else if (flags & MS_RELATIME)
+		attrs |= MOUNT_ATTR_RELATIME;
+	else if (flags & MS_STRICTATIME)
+		attrs |= MOUNT_ATTR_STRICTATIME;
+	if (flags & MS_NODIRATIME)
+		attrs |= MOUNT_ATTR_NODIRATIME;
+	if (flags & MS_NOSYMFOLLOW)
+		attrs |= MOUNT_ATTR_NOSYMFOLLOW;
+
+	return attrs;
+}
+
+/*
+ * Read and print kernel error messages from fsopen fd.
+ * The kernel can provide detailed error/warning/info messages via the
+ * filesystem context fd that are more informative than strerror(errno).
+ */
+static void log_fsconfig_kmsg(int fd)
+{
+	char buf[4096];
+	int err, sz = 0;
+
+	err = errno;
+
+	while ((sz = read(fd, buf, sizeof(buf) - 1)) != -1) {
+		if (sz <= 0)
+			continue;
+		if (buf[sz - 1] == '\n')
+			buf[--sz] = '\0';
+		else
+			buf[sz] = '\0';
+
+		if (!*buf)
+			continue;
+
+		switch (buf[0]) {
+		case 'e':
+			fprintf(stderr, " Error: %s\n", buf + 2);
+			break;
+		case 'w':
+			fprintf(stderr, " Warning: %s\n", buf + 2);
+			break;
+		case 'i':
+			fprintf(stderr, " Info: %s\n", buf + 2);
+			break;
+		default:
+			fprintf(stderr, " %s\n", buf);
+			break;
+		}
+	}
+
+	errno = err;
+}
+
+/*
+ * Apply VFS superblock flags to the filesystem context.
+ * Only handles flags that are filesystem parameters (ro, sync, dirsync).
+ * Mount attributes (nosuid, nodev, etc.) are handled separately via fsmount().
+ */
+static int apply_mount_flags(int fsfd, unsigned long flags)
+{
+	int res, save_errno;
+
+	/* Handle read-only flag */
+	if (flags & MS_RDONLY) {
+		const char *flag = "ro";
+
+		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
+		if (res == -1) {
+			save_errno = errno;
+			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
+			log_fsconfig_kmsg(fsfd);
+			return -save_errno;
+		}
+	}
+
+	/* Handle sync flag */
+	if (flags & MS_SYNCHRONOUS) {
+		const char *flag = "sync";
+
+		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
+		if (res == -1) {
+			save_errno = errno;
+			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
+			log_fsconfig_kmsg(fsfd);
+			return -save_errno;
+		}
+	}
+
+#ifndef __NetBSD__
+	/* Handle dirsync flag */
+	if (flags & MS_DIRSYNC) {
+		const char *flag = "dirsync";
+
+		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
+		if (res == -1) {
+			save_errno = errno;
+			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
+			log_fsconfig_kmsg(fsfd);
+			return -save_errno;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+static int apply_opt_fd(int fsfd, const char *value)
+{
+	int res, save_errno;
+
+	/* The fd parameter is a u32 value, not a file descriptor to pass */
+	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "fd", value, 0);
+	if (res == -1) {
+		save_errno = errno;
+		fprintf(stderr, "fuse: fsconfig SET_STRING fd=%s failed:",
+			value);
+		log_fsconfig_kmsg(fsfd);
+		return -save_errno;
+	}
+	return 0;
+}
+
+static int apply_opt_string(int fsfd, const char *key, const char *value)
+{
+	int res, save_errno;
+
+	res = fsconfig(fsfd, FSCONFIG_SET_STRING, key, value, 0);
+	save_errno = errno;
+	if (res == -1) {
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr, "fuse: fsconfig SET_STRING %s=%s failed: ",
+			key, value);
+		return -save_errno;
+	}
+	return 0;
+}
+
+static int apply_opt_flag(int fsfd, const char *opt)
+{
+	int res, save_errno;
+
+	res = fsconfig(fsfd, FSCONFIG_SET_FLAG, opt, NULL, 0);
+	if (res == -1) {
+		save_errno = errno;
+		fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", opt);
+		log_fsconfig_kmsg(fsfd);
+		return -save_errno;
+	}
+	return 0;
+}
+
+static int apply_opt_key_value(int fsfd, char *opt)
+{
+	char *eq;
+	const char *key;
+	const char *value;
+
+	eq = strchr(opt, '=');
+	if (!eq)
+		return apply_opt_flag(fsfd, opt);
+
+	*eq = '\0';
+	key = opt;
+	value = eq + 1;
+
+	if (strcmp(key, "fd") == 0)
+		return apply_opt_fd(fsfd, value);
+
+	return apply_opt_string(fsfd, key, value);
+}
+
+/**
+ * Check if an option is a mount attribute (handled by fsmount, not fsconfig)
+ */
+static int is_mount_attr_opt(const char *opt)
+{
+	/* These options are mount attributes passed to fsmount(), not fsconfig() */
+	return strcmp(opt, "nosuid") == 0 ||
+	       strcmp(opt, "suid") == 0 ||
+	       strcmp(opt, "nodev") == 0 ||
+	       strcmp(opt, "dev") == 0 ||
+	       strcmp(opt, "noexec") == 0 ||
+	       strcmp(opt, "exec") == 0 ||
+	       strcmp(opt, "noatime") == 0 ||
+	       strcmp(opt, "atime") == 0 ||
+	       strcmp(opt, "nodiratime") == 0 ||
+	       strcmp(opt, "diratime") == 0 ||
+	       strcmp(opt, "relatime") == 0 ||
+	       strcmp(opt, "norelatime") == 0 ||
+	       strcmp(opt, "strictatime") == 0 ||
+	       strcmp(opt, "nostrictatime") == 0 ||
+	       strcmp(opt, "nosymfollow") == 0 ||
+	       strcmp(opt, "symfollow") == 0;
+}
+
+/*
+ * Parse kernel options string and apply via fsconfig
+ * Options are comma-separated key=value pairs
+ */
+static int apply_mount_opts(int fsfd, const char *opts)
+{
+	char *opts_copy;
+	char *opt;
+	char *saveptr;
+	int res;
+
+	if (!opts || !*opts)
+		return 0;
+
+	opts_copy = strdup(opts);
+	if (!opts_copy) {
+		fprintf(stderr, "fuse: failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	opt = strtok_r(opts_copy, ",", &saveptr);
+	while (opt) {
+		/*
+		 * Skip mount attributes, they're handled by fsmount()
+		 * not fsconfig().
+		 *
+		 * These string options (nosuid, nodev, etc.) are reconstructed
+		 * from MS_* flags by get_mnt_flag_opts() in lib/mount.c and
+		 * get_mnt_opts() in util/fusermount.c. Both the library path
+		 * (via fuse_kern_mount_get_base_mnt_opts) and fusermount3 path
+		 * rebuild these strings from the flags bitmask and pass them in
+		 * mnt_opts. They must be filtered here because they are mount
+		 * attributes (passed to fsmount via MOUNT_ATTR_*), not
+		 * filesystem parameters (which would be passed to fsconfig).
+		 */
+		if (!is_mount_attr_opt(opt)) {
+			res = apply_opt_key_value(fsfd, opt);
+			if (res < 0) {
+				free(opts_copy);
+				return res;
+			}
+		}
+		opt = strtok_r(NULL, ",", &saveptr);
+	}
+
+	free(opts_copy);
+	return 0;
+}
+
+
+/**
+ * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
+ * @mnt: mountpoint
+ * @flags: mount flags (MS_NOSUID, MS_NODEV, etc.)
+ * @blkdev: 1 for fuseblk, 0 for fuse
+ * @fsname: filesystem name (or NULL)
+ * @subtype: filesystem subtype (or NULL)
+ * @source_dev: device name for building source string
+ * @kernel_opts: kernel mount options string
+ * @mnt_opts: additional mount options to pass to the kernel
+ *
+ * Returns: 0 on success, -1 on failure with errno set
+ */
+int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
+		      const char *fsname, const char *subtype,
+		      const char *source_dev, const char *kernel_opts,
+		      const char *mnt_opts)
+{
+	const char *type;
+	char *source = NULL;
+	int fsfd = -1;
+	int mntfd = -1;
+	int err, res;
+	unsigned long mount_attrs;
+
+	/* Determine filesystem type */
+	type = blkdev ? "fuseblk" : "fuse";
+
+	/* Try to open filesystem context */
+	fsfd = fsopen(type, FSOPEN_CLOEXEC);
+	if (fsfd == -1) {
+		if (errno != EPERM)
+			fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
+				strerror(errno));
+		return -1;
+	}
+
+	/* Build source string */
+	source = malloc((fsname ? strlen(fsname) : 0) +
+			(subtype ? strlen(subtype) : 0) +
+			strlen(source_dev) + 32);
+	err = -ENOMEM;
+	if (!source) {
+		fprintf(stderr, "fuse: failed to allocate memory\n");
+		goto out_close_fsfd;
+	}
+
+	strcpy(source, fsname ? fsname : (subtype ? subtype : source_dev));
+
+	/* Configure source */
+	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
+	if (res == -1) {
+		err = -errno;
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr, "fuse: fsconfig source failed: %s\n",
+			strerror(errno));
+		goto out_free;
+	}
+
+	/* Apply VFS superblock flags (ro, sync, dirsync) */
+	err = apply_mount_flags(fsfd, flags);
+	if (err < 0) {
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr, "fuse: failed to apply mount flags\n");
+		goto out_free;
+	}
+
+	/* Apply kernel options */
+	err = apply_mount_opts(fsfd, kernel_opts);
+	if (err < 0) {
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr,
+			"fuse: failed to apply kernel options '%s'\n",
+			kernel_opts);
+		goto out_free;
+	}
+
+	/* Apply additional mount options */
+	err = apply_mount_opts(fsfd, mnt_opts);
+	if (err < 0) {
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr,
+			"fuse: failed to apply additional mount options '%s'\n",
+			mnt_opts);
+		goto out_free;
+	}
+
+	/* Create the filesystem instance */
+	res = fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (res == -1) {
+		err = -errno;
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr, "fuse: fsconfig CREATE failed: %s\n",
+			strerror(errno));
+		goto out_free;
+	}
+
+	/* Convert MS_* flags to MOUNT_ATTR_* for fsmount() */
+	mount_attrs = ms_flags_to_mount_attrs(flags);
+
+	/* Create mount object with mount attributes */
+	mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs);
+	if (mntfd == -1) {
+		err = -errno;
+		log_fsconfig_kmsg(fsfd);
+		fprintf(stderr, "fuse: fsmount failed: %s\n",
+			strerror(errno));
+		goto out_free;
+	}
+
+	close(fsfd);
+	fsfd = -1;
+
+	/* Attach to mount point */
+	if (move_mount(mntfd, "", AT_FDCWD, mnt, MOVE_MOUNT_F_EMPTY_PATH) ==
+	    -1) {
+		err = -errno;
+		fprintf(stderr, "fuse: move_mount failed: %s\n",
+			strerror(errno));
+		goto out_close_mntfd;
+	}
+
+	err = fuse_mnt_add_mount_helper(mnt, source, type, mnt_opts);
+	if (err == -1)
+		goto out_umount;
+
+	close(mntfd);
+	free(source);
+	return 0;
+
+out_umount:
+	{
+		/* race free umount */
+		char fd_path[64];
+
+		snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", mntfd);
+		if (umount2(fd_path, MNT_DETACH) == -1 && errno != EINVAL) {
+			fprintf(stderr,
+				"fuse: cleanup umount failed: %s\n",
+				strerror(errno));
+		}
+	}
+out_close_mntfd:
+	if (mntfd != -1)
+		close(mntfd);
+out_free:
+	free(source);
+out_close_fsfd:
+	if (fsfd != -1)
+		close(fsfd);
+	errno = -err;
+	return -1;
+}
+
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index 1bfc78b32dc4fd434870e4fff1a37e0c340d207e..34c7386715155e8640cac68c218a1e1062990ce6 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -29,4 +29,18 @@ struct mount_opts {
 	unsigned int max_read;
 };
 
+int fuse_kern_mount_prepare(const char *mnt, struct mount_opts *mo);
+
+int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp);
+
+int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
+		      const char *fsname, const char *subtype,
+		      const char *source_dev, const char *kernel_opts,
+		      const char *mnt_opts);
+
+int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
+			 const char *mnt_opts);
+
+int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
+			 const char *mnt_opts);
 #endif /* FUSE_MOUNT_I_LINUX_H_ */
diff --git a/meson.build b/meson.build
index 80c5f1dc0bd3565c11ad3084dac08e28dab611dc..465a7bbfd14fe9c45897f197ef37db76079d20ee 100644
--- a/meson.build
+++ b/meson.build
@@ -30,7 +30,7 @@ if platform == 'darwin'
         'https://www.fuse-t.org/ instead')
 elif platform == 'cygwin' or platform == 'windows'
   error('libfuse does not support Windows.\n' +
-        'Take a look at http://www.secfs.net/winfsp/ instead')       
+        'Take a look at http://www.secfs.net/winfsp/ instead')
 endif
 
 cc = meson.get_compiler('c')
@@ -118,6 +118,21 @@ special_funcs = {
 	    return -1;
 	  }
 	}
+    ''',
+    'new_mount_api': '''
+	#define _GNU_SOURCE
+	#include <sys/mount.h>
+	#include <linux/mount.h>
+	#include <unistd.h>
+	#include <fcntl.h>
+
+	int main(void) {
+	    int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
+	    int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
+	    int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	    res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+	    return 0;
+	}
     '''
 }
 
@@ -308,7 +323,7 @@ configure_file(output: 'libfuse_config.h',
 include_dirs = include_directories('include', 'lib', '.')
 
 # Common dependencies
-thread_dep = dependency('threads') 
+thread_dep = dependency('threads')
 
 #
 # Read build files from sub-directories

-- 
2.43.0

