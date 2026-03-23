Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19D35F193
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289959; cv=fail; b=Fdy1msc9y89uwp5iWlrMtcBuQaWIDOQg61qwLgJeLGCA5ol0UdkHegt7yzcRZgE+QzifN3FuuK+L9izHEma+U275Wh0XlidUK9lxUCWJ8gY/MdqLnA4ZB2e2Ncw8rt7qJHQ8yO2teoV7CoUNiQ7rdCDYwJsYpAGsy2tYp3Iftp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289959; c=relaxed/simple;
	bh=c9+1hQMTCrakHLqn5KJoccGaWcI+pICQ1cmrDhkAsUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdAhJiRQKaIuFoz4HkO1OX/CLS5h2KQUlLwuHJdIBncrmmp1Rtz7apu0GxkSXz6zSKT+2+1Bm4QZaBAfi4BjDVTZtyP1TvdXkL+LnB7Fbmq1T4G0d55XKb0DdkCV039HZLrGlyn3mYDENkdiq9+gyTAM4ijK7ORJg5a/1ceD0ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=LYpR+UP1; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="LYpR+UP1"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021130.outbound.protection.outlook.com [40.93.194.130]) by mx-outbound16-35.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUKtSblu2lwD8YNN2v/mYdXf52HCXAezuAVz9Xge4uW0e2Jvht2NaS3xOjVqgOdM5uV1kzU8h+wpIyNWDL+oBih6mtmz7pFuu0EGME01aBOp6Z9yB3aA5XnGhbvduaCmA2KfhJSUJnyyT4ZWSSDl31AOK8djfunwQLu4+QvIKPOCq7AQBRmCYRJNq8QG7AyFxIh4Fq0jYNK5YHJ+pUP3vCqRT5ZAmi8BHK5BN7DpJOoQgZ5OhdNGLMyiibWmqQ49oiLHwZlkraRpCkj28EIdXwatlJrV0wpPv2csR2yjrGRgM0OMXev5JO49z4sTvHEYMjmr5/w+gHbttElPoZLpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78EOvRjpatJcMJm4EIxwqLPhtPW4sVrsz57hhxcsZis=;
 b=SFnb35vRQIep9n4p6ll03zQbDRQZEiFUt4QDQu5xuJepr6GlK+WaDjKM5Sk/EBqoxL1dpKtk2qWVmJZoWkVBAycpSjOMheqzw/H6+yyPKTuzc2qBpeiEAUDxiL6Cw08sXhbW0B+mtxWGYCaAbOUJxM4kO7lyjbF4oP8RaZ5fcmsp6bG8GIaiboiCMc8KtDnDcZUgaFFztbjYFKOk2onRLKGxzJkF5uxPFQqdmYditsVUEqO0wxWTu1j3/1oXIceIBicp3Q/MPzEpCXTxbylEo4Na8bUzarSA2aDqmlsQIQ09+lRdz6Ivj73DD5hcbuvj6do5PGexiDIt0xKiSzhstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78EOvRjpatJcMJm4EIxwqLPhtPW4sVrsz57hhxcsZis=;
 b=LYpR+UP1z+CzgsfoqqiBPXaNwNYN/0/FRP9WlQ5s+CRcMNOgx86JxXOh+3QWmIGLBr6044N7TPTR/Ak9bwYvEx4LL0UkYIg+3VsND3P6l9too05S67ABEHbBdkV/52h+pEvvdwwJ92x7XQetsN2yx3qM7b92wWEE2qXJyilPn/M=
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by MN0PR19MB5923.namprd19.prod.outlook.com (2603:10b6:208:37e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:15 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::bd) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:14 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 6D4BE2C7;
	Mon, 23 Mar 2026 17:45:11 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:03 +0100
Subject: [PATCH 08/19] Refactor mount code / move common functions to
 mount_util.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-8-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=10423;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=QjoajITq5mzDRPuAqF+uMZhiKU+JlrA3GOrAot9VMQY=;
 b=ywZ6vLiI6mqgx8/dXECP0AFZosX5o6B2JLoSu7LVeSahs/r/SItLibWyzsA27xhKdOQYaYkEm
 /vT6bMvLvi4DV6mvP6IRim7i+d5l8RbidVMouHMxXHoKM7dc0hjb6Db
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MN0PR19MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b587cb7-576a-4345-5e61-08de8903f09a
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|19092799006|376014|36860700016|61400799027|48200799018|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
 3N3aWCwjHx5tswKGxVINpOfL3hMH2/kyO7fs99fzWaxyf8G8A8kvpZRHQNuEhRyIQ1FQ2HdlNuCHNk2ZZX8rK4IuAwF/ob7+z2m+BIsroHohk4pwZBtsgkSf0mVh16SNeJ62pdKxHYmHo7h0VFObZvI7CCv4oBWi9jEdEHBbuaCmNQ1f5FJ/1TgCGmjP+fpsa///66L9tBhgojVX0qQK0+TDcZeJ+gK6+M5t5RZUKxu4NIgZ8mPUud12hU9jBRuEJ+YU4CLDR9U2DeKFChDlGM6g8MGS7XGP36KTI058hpJRrACnvpXu2UUHT9VBupbNFsdKLV+2PI6W8u+OCN1igi71VYiYKYpFO5Ihbj0E+TpDF1EwnLCCPfFvr4rbxBFNpY+EWp6eQD5KcwBpvDs0SyW/GuVvLI3D/ENiCbD80b479LcsnMjZCYrocU+rBnliUGkk2cXaHPASc3tqaVyqhIxCDjrCcnpzHiyhNztpJc82gLIkMAlrUKNG2fndp+L6Xbc7jt1MwHBlO8JXaguvhSnkPSKFHWFVRP/tsJFFVO2hQxxjbZ62UvvydDvUgLzV77VojZlchQQXDMtA4+L2880cY/gmJtnEZWi8dzdi2SRa/5Ts9gLO06zp+NMWlMY0i9FZflXRc9m8vAlI6brzp13XSGYW+d2NxiaGtysvg/5uAYA/udjMTEM01RZ8VHg8QdeDAcIAyrn7+OUNRnRMmJm9fJ9Sx4w2nbOdOi0KneCrdxTcNgGEoJUUb/h0+J67fvFx0IE8qRyC9PhsmRp64A==
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(376014)(36860700016)(61400799027)(48200799018)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 ofBMXY++DUS+a0BFmaZcCwbKgRf41DUCQu5X/jsnBFMU/pYyGaPKGKlhKLiLX4WgZtBWTu81L0DGJVtOS+PChiM7pRdny7dtMNo3x5IsfG/n3Ljna0MfjL0j/ZMvWenjAIaRaqxaGSgJITCBfkgyraoSY2JKR4c2BoDyLnVfWveNYIf4PfaQGaz9uTbr67L6ecv51rDULx9F3+gNQ2PeBWcTypk9zXfQS9AGMlHmILVfD/803Sms6AOS8fsdK11tQhbrS93qQC7ANZfNIgFsmF5ShgDBI4XU00RK7AjXReQTNtl3RsUgM1o6ymtZ+XNpMVdXtt6jvUMsDUHT479LmrAdQcK+alSQUBsMGf/vbVrNtA9DzqdnjbC6Ef7C8InEPciOFx+I/8UL5oB7h9ce63a2aYRvJHpTAB38jF0tWKBNKZJpyKeZbUpaQq4vg6pt
X-Exchange-RoutingPolicyChecked:
 UDBJPxh28f2/R71W5zNJ29fP4DreUKI0vpkPs9OV3ievsyyuJc08tM5kNSbuMIiwHZGowStd/2L3aM7etnJWuYJMzm3gb+uWk99Ll0iHFZSx5cuGjZ9YFQZ0+L0bDxeY13ef8gOAa0ZTQEPfQplEAfUdnFSS8QmVXFEwFhok6r6oc1UFfUdjf4dQPLasivwQ3yfqFuNZ7I1znBrGMy4fhEl/Jxtv/5dC6wlhzyF8jM7tq/Cj38oHvdHi7RUgIZCyYC9ypXsJv8/iZ6QNuTw8aV6PD5FGoxpZAoG9bM3ekxt3JVbEfxZaizoYBcJeypQeEVUKKFbKdLL4zAHennf9ZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 qe5TpFl+DNBu72dtpJDcidPk1mouTxUerRYg6EwhpbUEY09fmMFnetEFjhaBt0bEiibxKiR3DrqnOUPbi5a73x2uyN8nhG5douABx8n++EpSjrilc7iA7senRWOq/WYZkCKt0cCtuJgNiMbCQpYRdwkyNjtLYNnrV4rDsOHfQELTH9OPnjEC9qxuQtREOdOmqviXOnwuOAhAn5wwU5Kkfd0EKjy4jbt9vfBvf000eG/8xx24cLAVvfLyep79jaCi93AShap2oAoW0HhFEm1vRj7fIRHtxxTgVkSd5LdJg+FC5ycp6B/FWK9Bi2mAPt0LsE7IXPnsZQy7yYxQg2uH1F9bKP2h7qjdjoKuWx6UW8TQxGJdZeIxurF0NKeb52wf1CZMnImqu4fwcZsPLoqm9B5B1nBroeEv3oYeFaRiBsXfmNZwJK5zfbXJnoYyMmpbzgKPq34mvDRxpF/jwylbLTVxdV7uPnHkH1RlDFJ2bDmcZO8Faj+4gEyDVs8kmvZLPICih+8i72hk/WOiOhERQRbRrH8vEFLVj2nMQLqvo62WZxl8oby2iXt7NEmtiztKLIEgtAhKqRSOTebzHMygtDxmLPbHQJAtXpsKTwy/b/5h8DOsZ5M4YAFKDGHc3GQlEcNTevHozI+lTfvy4tgYWw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:14.7202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b587cb7-576a-4345-5e61-08de8903f09a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5923
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289948-104131-3288-1662-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.93.194.130
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhgbGQGYGUDQlxcIwJckyzT
	Q1LcXYLMXY3NI8zczcwNDU2MQ0OcXSSKk2FgCU81MnQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan8-91.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Also create the new "mount_i.h", which is independent of the
the rest of libfuse.

This is preparation for the new mount API, which goes into a new file.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/fuse_i.h         | 10 ++----
 lib/mount.c          | 96 ++++++++++++++++++++++++++++------------------------
 lib/mount_bsd.c      |  1 +
 lib/mount_common_i.h | 31 +++++++++++++++++
 lib/mount_i_linux.h  | 32 ++++++++++++++++++
 lib/mount_util.c     | 24 +++++++++++++
 lib/mount_util.h     |  6 ++++
 7 files changed, 148 insertions(+), 52 deletions(-)

diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index b4c1d3eef41010287f6c9555ec0b2442d904d192..6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -19,14 +19,15 @@
 #include <stdbool.h>
 #include <stdatomic.h>
 
+#ifndef MIN
 #define MIN(a, b) \
 ({									\
 	typeof(a) _a = (a);						\
 	typeof(b) _b = (b);						\
 	_a < _b ? _a : _b;						\
 })
+#endif
 
-struct mount_opts;
 struct fuse_ring_pool;
 
 struct fuse_req {
@@ -217,13 +218,8 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
  */
 void fuse_chan_put(struct fuse_chan *ch);
 
-/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
-#define FUSE_MOUNT_FALLBACK_NEEDED -2
-
-struct mount_opts *parse_mount_opts(struct fuse_args *args);
-void destroy_mount_opts(struct mount_opts *mo);
+/* Mount-related functions */
 void fuse_mount_version(void);
-unsigned get_max_read(struct mount_opts *o);
 void fuse_kern_unmount(const char *mountpoint, int fd);
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
 
diff --git a/lib/mount.c b/lib/mount.c
index dec9d52274c13536648cacef959789f472c5682c..fe353e2cc4579adb47473cac5db7d1bae2defb2c 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -16,6 +16,7 @@
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "mount_util.h"
+#include "mount_i_linux.h"
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -49,7 +50,6 @@
 #define FUSERMOUNT_PROG		"fusermount3"
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
-#define FUSE_KERN_DEVICE_ENV	"FUSE_KERN_DEVICE"
 
 #ifndef MS_DIRSYNC
 #define MS_DIRSYNC 128
@@ -65,20 +65,6 @@ enum {
 	KEY_RO,
 };
 
-struct mount_opts {
-	int allow_other;
-	int flags;
-	int auto_unmount;
-	int blkdev;
-	char *fsname;
-	char *subtype;
-	char *subtype_opt;
-	char *mtab_opts;
-	char *fusermount_opts;
-	char *kernel_opts;
-	unsigned max_read;
-};
-
 #define FUSE_MOUNT_OPT(t, p) { t, offsetof(struct mount_opts, p), 1 }
 
 static const struct fuse_opt fuse_mount_opts[] = {
@@ -197,7 +183,7 @@ static const struct mount_flags mount_flags[] = {
 	{NULL,	    0,		    0}
 };
 
-unsigned get_max_read(struct mount_opts *o)
+unsigned int get_max_read(struct mount_opts *o)
 {
 	return o->max_read;
 }
@@ -510,7 +496,7 @@ static int fuse_kern_mount_prepare(const char *mnt,
 				   struct mount_opts *mo)
 {
 	char tmp[128];
-	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
+	const char *devname = fuse_mnt_get_devname();
 	struct stat stbuf;
 	int fd;
 	int res;
@@ -563,35 +549,24 @@ out_close:
  * @mo: mount options
  * @mnt_opts: mount options to pass to the kernel
  *
- * Returns: 0 on success, -1 on failure, FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
+ * Returns: 0 on success, -1 on failure,
+ *          FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
  */
 static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 				  const char *mnt_opts)
 {
-	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
 	char *source = NULL;
 	char *type = NULL;
 	int res;
 
 	res = -ENOMEM;
-	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
-			(mo->subtype ? strlen(mo->subtype) : 0) +
-			strlen(devname) + 32);
-
-	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
+	source = fuse_mnt_build_source(mo);
+	type = fuse_mnt_build_type(mo);
 	if (!type || !source) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate memory\n");
 		goto out_close;
 	}
 
-	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
-	if (mo->subtype) {
-		strcat(type, ".");
-		strcat(type, mo->subtype);
-	}
-	strcpy(source,
-	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
-
 	res = mount(source, mnt, type, mo->flags, mo->kernel_opts);
 	if (res == -1 && errno == ENODEV && mo->subtype) {
 		/* Probably missing subtype support */
@@ -627,20 +602,10 @@ static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
 		goto out_close;
 	}
 
-#ifndef IGNORE_MTAB
-	if (geteuid() == 0) {
-		char *newmnt = fuse_mnt_resolve_path("fuse", mnt);
-		res = -1;
-		if (!newmnt)
-			goto out_umount;
+	res = fuse_mnt_add_mount_helper(mnt, source, type, mnt_opts);
+	if (res == -1)
+		goto out_umount;
 
-		res = fuse_mnt_add_mount("fuse", source, newmnt, type,
-					 mnt_opts);
-		free(newmnt);
-		if (res == -1)
-			goto out_umount;
-	}
-#endif /* IGNORE_MTAB */
 	free(type);
 	free(source);
 
@@ -777,3 +742,44 @@ out:
 	free(mnt_opts);
 	return res;
 }
+
+const char *fuse_mnt_get_devname(void)
+{
+	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
+
+	return devname ? devname : "/dev/fuse";
+}
+
+char *fuse_mnt_build_source(const struct mount_opts *mo)
+{
+	const char *devname = fuse_mnt_get_devname();
+	char *source;
+
+	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
+			(mo->subtype ? strlen(mo->subtype) : 0) +
+			strlen(devname) + 32);
+	if (!source)
+		return NULL;
+
+	strcpy(source,
+	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
+
+	return source;
+}
+
+char *fuse_mnt_build_type(const struct mount_opts *mo)
+{
+	char *type;
+
+	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
+	if (!type)
+		return NULL;
+
+	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
+	if (mo->subtype) {
+		strcat(type, ".");
+		strcat(type, mo->subtype);
+	}
+
+	return type;
+}
diff --git a/lib/mount_bsd.c b/lib/mount_bsd.c
index c12ab322e7dc86d5c8d2f2abc6b71488e82523cf..c5b831160f826c0e4620626a72c4b93427d18bab 100644
--- a/lib/mount_bsd.c
+++ b/lib/mount_bsd.c
@@ -10,6 +10,7 @@
 
 #include "fuse_config.h"
 #include "fuse_i.h"
+#include "mount_common_i.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "util.h"
diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
new file mode 100644
index 0000000000000000000000000000000000000000..d27d2aa624ae3806c61a0fe382c2d024080c9bb3
--- /dev/null
+++ b/lib/mount_common_i.h
@@ -0,0 +1,31 @@
+/*
+ *  FUSE: Filesystem in Userspace
+ *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *                2026 Bernd Schubert <bernd@bsbernd.com>
+ *
+ *  This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file LGPL2.txt
+ */
+
+#ifndef FUSE_MOUNT_COMMON_I_H_
+#define FUSE_MOUNT_COMMON_I_H_
+
+/* Forward declaration for fuse_args */
+struct fuse_args;
+struct mount_opts;
+
+/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
+#define FUSE_MOUNT_FALLBACK_NEEDED -2
+
+/* Environment variable for FUSE kernel device */
+#define FUSE_KERN_DEVICE_ENV "FUSE_KERN_DEVICE"
+
+/* Mount options management functions */
+struct mount_opts *parse_mount_opts(struct fuse_args *args);
+void destroy_mount_opts(struct mount_opts *mo);
+unsigned int get_max_read(struct mount_opts *o);
+char *fuse_mnt_build_source(const struct mount_opts *mo);
+char *fuse_mnt_build_type(const struct mount_opts *mo);
+
+
+#endif /* FUSE_MOUNT_COMMON_I_H_ */
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
new file mode 100644
index 0000000000000000000000000000000000000000..abcd1b08012feedef6b4c8961b55ac847a27496a
--- /dev/null
+++ b/lib/mount_i_linux.h
@@ -0,0 +1,32 @@
+/*
+ *  FUSE: Filesystem in Userspace
+ *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *                2026 Bernd Schubert <bernd@bsbernd.com>
+ *
+ *  This program can be distributed under the terms of the GNU LGPLv2.
+ *  See the file LGPL2.txt
+ */
+
+#ifndef FUSE_MOUNT_I_H_
+#define FUSE_MOUNT_I_H_
+
+/* Forward declaration for fuse_args */
+struct fuse_args;
+
+/* Mount options structure */
+struct mount_opts {
+	int allow_other;
+	int flags;
+	int auto_unmount;
+	int blkdev;
+	char *fsname;
+	char *subtype;
+	char *subtype_opt;
+	char *mtab_opts;
+	char *fusermount_opts;
+	char *kernel_opts;
+	unsigned int max_read;
+};
+
+
+#endif /* FUSE_MOUNT_I_H_ */
diff --git a/lib/mount_util.c b/lib/mount_util.c
index 8c0cdf72d978da68c95125964416b92668104924..a42a02a0b92f98778abb2c491cdc7a01260f56ee 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -375,3 +375,27 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint)
 
 	return -1;
 }
+
+int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
+			       const char *type, const char *mnt_opts)
+{
+#ifndef IGNORE_MTAB
+	if (geteuid() == 0) {
+		char *newmnt = fuse_mnt_resolve_path("fuse", mnt);
+		int res;
+
+		if (!newmnt)
+			return -1;
+
+		res = fuse_mnt_add_mount("fuse", source, newmnt, type,
+					 mnt_opts);
+		free(newmnt);
+		return res;
+	}
+#endif
+	(void)mnt;
+	(void)source;
+	(void)type;
+	(void)mnt_opts;
+	return 0;
+}
diff --git a/lib/mount_util.h b/lib/mount_util.h
index 9cb9077dd177381d712e34e7118bf73572142c6a..4688d00091f001b3ccd36b1ef3b7e799031ed773 100644
--- a/lib/mount_util.h
+++ b/lib/mount_util.h
@@ -7,6 +7,7 @@
 */
 
 #include <sys/types.h>
+#include "mount_common_i.h" // IWYU pragma: keep
 
 int fuse_mnt_add_mount(const char *progname, const char *fsname,
 		       const char *mnt, const char *type, const char *opts);
@@ -16,3 +17,8 @@ int fuse_mnt_umount(const char *progname, const char *abs_mnt,
 char *fuse_mnt_resolve_path(const char *progname, const char *orig);
 int fuse_mnt_check_fuseblk(void);
 int fuse_mnt_parse_fuse_fd(const char *mountpoint);
+
+/* Helper functions for mount operations */
+const char *fuse_mnt_get_devname(void);
+int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
+			       const char *type, const char *mnt_opts);

-- 
2.43.0

