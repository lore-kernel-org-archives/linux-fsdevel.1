Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544836E473
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289951; cv=fail; b=f4P/bfhiKpZgfCLHyGiJipJ8oo/NN/wH/mK7b25EG7uk2sKNOgHPcgocTIRUT1tGLmZ76pA3XjQq7kQ6Tbe73bCJTG6x1wjthYM5RvinIp9ouO6utyXKcE6q9E6OeElkKVOtyvPZr+HENpmIEMmNd0YQrz6EPifs+udg9aOTQ4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289951; c=relaxed/simple;
	bh=w2WNSEgfTc/JvsjXZCMmnfeXwLodM4V4NiXxcw57bic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXRs/7I/sSTi4VXpA4tBRaKWtxORWwryXPqz3UVfycuGffY8li/xEAbfdGgWTOcNfPbEbKjzyHfuCaVoChUAG9qmAHMc7+xUSFsnNxM2yWCJi4IFbFwerg+r9Eps0iqIJcwcrxQ9Jr56DMoOrwsAi6em/CR3aMgio+Pz6Rxweig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=UqjsitUT; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="UqjsitUT"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020126.outbound.protection.outlook.com [52.101.193.126]) by mx-outbound13-233.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJjOegDCJa/vHVKHwsdhU7lqc2bBLfe/aKAsvO1hfo+naL36jk3iIFfjw/LC4+srdXDf6DCk87BHWw2145QhdgmG8VfAXg3DPz2hzpfJj5xZwiWfqalnR0//V6WZZxSJxe9GuNVOTnrhg1K3fj/SFwz9jJ1Shmwy0XNft6ru1Fyk42s/6wJAPoqUxzF3VK5qIxcj33KQOUjdKLt2K7Vwz4WTUKbpahS2uHD/6JPUTfdQzTefUXKDKhuILvdu4Jv3D5a+GF83cV+nGTyZBg/RH0144hKIM0I3I7QPDBiGuXcLJw5OOwCNeZsymMDi87di9MCD5wECdPEgqkBOzla3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynzJAsxjrUkS6bpup9o6Wiea/ZfwP/CR/GbmzBy6M58=;
 b=n/Rzhtn6NOMgbjmjBdjM4CCq+ObrilFI70WOSrg9Io74canIXgvkBjLrU7UCSx2XUYSIXbXvTGg572w2n6GhNnEooLUKdG3vkoYmxUdzIAyojcFoV4ZxNUWe72YDJI122mnmpd7zUxvKcT8jasY2nkuG+AD2zwLyvF2m+iyJaheg5rSMHZvM5E2rMEADUKKAsrgKpLZ4XoXXybTBaIdBjxXN63v37uLnQKjFDVjB3nBhJfM4p3LTAFYDXSqDQoorMYGdRGxe3js+h/xPRZSDd36zGxwjmclNDh46Ir7sOLd+JeDaZq2lTqHbm5SzUsaOMOaV8CAgPUN9IKHqdlrE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynzJAsxjrUkS6bpup9o6Wiea/ZfwP/CR/GbmzBy6M58=;
 b=UqjsitUTasCrjP8UNIzcWP3E2Unrf4rCNfRF3GQHE+NeACeaU+qJOr3e1QP6H/jvciash9WGG3caWxtCGK2V0qV/hL6A6n5Jmz2ZS5JBgFA13PCjomzgMJy7yd7DmMwMq7nBdzhSnFdROSpxwXzTx2bAEHRVnu+7E0GZEQd573g=
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by PH7PR19MB7553.namprd19.prod.outlook.com (2603:10b6:510:27c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:22 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::df) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:21 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 11FEEB7;
	Mon, 23 Mar 2026 17:45:17 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:10 +0100
Subject: [PATCH 15/19] Split the fusermount do_mount function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-15-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=11796;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=Ta5mjIeJDlHcE3ESDhGrSl1i5ZrPIYuUa5O6daNQMlI=;
 b=mAfSvBWfcIFVDjSug9+aGvnVClSP/oMK+4IsI8v4CRTwz43RLVvgPCdwkdyPYb6uK0ohu3CLv
 XaVZZ0aeJwIB+2lC9fiCITurJNFTjTM18mOJutoshvgS6ufMyEozGDo
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR19MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b82b3f-cb2c-49d9-ad5c-08de8903f4cd
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|48200799018|19092799006|36860700016|82310400026|376014|61400799027|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
 3bGRBGeP4QX0TYOGR9XZgk4C0wUp/nXLnCn5buRBn3Pw+Qu/t3J/DKWWFh5G9mNqzG2Hy3YP4W9FW4totb9+C0LjiBZBhLk9K/E+cZCv1X0D8wLUjzv6MlEE+cNZoAvjLq00xa+C3Xz9S8yqLkKh3/ao1PsegtuT/UumE1ZxO6Bb9nYH/RQopWu6mmJ4hVQeQWCeyW6zX+Yda6pBHyZwBMB0qY6V3Ch42nJBeUU+49uduhPIJFv5dMXlgyK6voTRBtDLmbV9f2zVIR7ahspo50bBCh+SSDI81qpChauPORtfvncBDAI//0YxX1Vk5MYuDJiFiX1zQzpIaP6Z33wrYLRB3Wo97XPWO7ab4DSvonpZsyZtJwdbJ/0XOW5YqToZQgnCzmTmi9oDTLxpWBKingWQ1JrJEh1to7/jgy1SU9tVgcl9EYdouROBvTHlOXkN6jr9zDrxiH9C/97GRkQOGs5JXfGEq3DA3+h9mPAMiC5f61/e+L36iMcDXDU7vhk+Ep6bbwK7qP1MqGiYbxeu7pLbRUi76S3VrtfsiZ4BjnifKBWFp+28lV9bNsEp8lGlzAKOdRJHz0fjFmlHhPCdFpsI6uPYIh63QC//B2U4lm0k2ztJIvBRpSAWa50Dx5NZKYD93MOq8v4l0v0P+7enFU8vS1cAjXLMAHdbZ6hogVvhxeJjzbx71p3nlntOi697kgdmLO7z/JzIhY8izwmKsYiQ14hTN0n/Aju90Tt1kcucZShK+LyHyVWI7JHgmHnDqRpOzyrpbMFl7h8a/DoG5Q==
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(19092799006)(36860700016)(82310400026)(376014)(61400799027)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 k4MrukysQyFTLDVI0K+atUFfF4Hj4dIQWb5S1+GWVZxvx2Q7u19b8E6RKjfMcccBqaSKZ9j0BZ0a5ircAcOa9h/IgMWblwUyD8r6PZX5je+oDoPvRBtwGd6dhyDOUt3Twpv7WSd/9y8A3cGE28ads+xLABm15wJ3vXoIMFKtz/VZ1B12JYn0ZrJhPWGUokV14+EtB2LANxUtcydMaqOFqUYriXpjY4e7rGh24Jb7+5LmnrCMTSoCBhzGwP+rYRj5thiz6zMkNQtT5xc8/0zkDm1Y4zvOi/dsT6vR3DhHLFc4QRSEKMLBCT9bCzwcQtjeYJYlYVmrXKsHJIZFyThLzCDEOf4tbf9FH67wdWlp1ePgERS4Z2LCFe7D1Eq68Y+ukSvCkop4cvnNVzYeO7p8mZ0ZSs8cwb8IeQUefI/ScpAf2zyIgFGhy4eqZ7tjk+UO
X-Exchange-RoutingPolicyChecked:
 IEE2tJgS1Y/KePTt69zYDttpSWaynDwUUbaVUOS1ctrp+KWuPQo92JTHbI86YReUTuI4SQXnNepzDSjXZPmVr73/H+cqwpbsadkd6okwjGzAKTjF4HgOMj6aFHPnT0WRyLesI+0JcQveR96yhrTqq4/hwfrnWotOXyzWLjpEWTLpE41F7fdoMKHrBJ69SXNNUau5E3MGaS8I/4eHHx60cxVQCceTzPJ3WbmTfHiQLUfHurT8c9TeXBCKQIzT+UC8SHOKS87EkdDq+6S5uQY8+LL2z4i3qw4OyVgN7CMcsbot3HvftJn2h+tWc3CSIfVyO6DDX6Idl6vKdcX66e1C8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 TZ7FvIxjWsiL7+GbeLZPCeHGbble/ZQyVw8A9FywwuR9aWQzOtNGVjcCcYuj7I8H8ZJFPoBRW3/yb5DKMRddz6SLdkEGLIByfLVImMBJq04g/fxJSsuKfkHPn7+vjmW2eGqTcKaHYTzI0IGlzA+Ybb+oEZyCogfK8/8HiIcT6VH/tkd00MFm8KIOgQhNOB+Tt883Lc0lmKbOVpIA/WYrRHElwPca+xiuTPpVmr40FN32fVMTwrgIxVcxzZr1KmQmt7IUGSPzL/CbgDqIxYbzHXgIGzrKbuaA4+vKxYSdRczrSi9KBKqlMLQJKBqNFeOBIdhC3ywn9IgCXHOGTxruSUkaKe0FFsRPdJqjsgWg5XcJGe+fb6wNzU2RAjL5TIOt/ttYvIGqZ9ZJNqkoTTtQh+RwVydQtgZZA3jRxUgnWi0Gzx4uIJMQoeIlcxZEKofUDoYSWPhRpHvQQS1apnKMm5kyeivIQkO1kfwQjy3FY943bXt9uj+h1DYDDve6Gej//ia8DTrIDtp0e00lFgnCbfBM7NkumpLQozvXOdbvqNpA+2XcWpIPXWZIuwB8+7k1toBLz/HXV+3QlPLbXFd6gfXGpHzaPokojm8JfBwGPgc0vws8BR/B30eoR2nMO909vRX5rMho9i5fjsbRFh3m0Q==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:21.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b82b3f-cb2c-49d9-ad5c-08de8903f4cd
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7553
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289938-103561-22271-12141-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.193.126
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGJiZmQGYGUNTCLM040djYOM
	XILCnR1MDMKCUp1dw8zdw0OTnR2NTCWKk2FgApl0O+QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan15-202.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

We will need new API and old API and need to pass the options to
two different functions - factor out the option parsing.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 util/fusermount.c | 298 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 205 insertions(+), 93 deletions(-)

diff --git a/util/fusermount.c b/util/fusermount.c
index f17b44f51142c682b339d0ce2287f7c00d644454..ecf509bb80d5cd129f6e582f1ec666502c55603a 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -917,30 +917,132 @@ static int mount_notrunc(const char *source, const char *target,
 	return mount(source, target, filesystemtype, mountflags, data);
 }
 
+struct mount_params {
+	/* Input parameters */
+	int fd;                  /* /dev/fuse file descriptor */
+	mode_t rootmode;         /* Root mode from stat */
+	const char *dev;         /* Device path (/dev/fuse) */
 
-static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
-		    int fd, const char *opts, const char *dev, char **sourcep,
-		    char **mnt_optsp)
+	/* Parsed mount options */
+	unsigned long flags;     /* Mount flags (MS_NOSUID, etc.) */
+	char *optbuf;           /* Kernel mount options buffer */
+	char *fsname;           /* Filesystem name from options */
+	char *subtype;          /* Subtype from options */
+	int blkdev;             /* Block device flag */
+
+	/* Generated mount parameters */
+	char *source;           /* Mount source string */
+	char *type;             /* Filesystem type string */
+	char *mnt_opts;         /* Mount table options */
+
+	/* Pointer for optbuf manipulation */
+	char *optbuf_end;       /* Points to end of optbuf for sprintf */
+};
+
+static void free_mount_params(struct mount_params *mp)
+{
+	free(mp->optbuf);
+	free(mp->fsname);
+	free(mp->subtype);
+	free(mp->source);
+	free(mp->type);
+	free(mp->mnt_opts);
+}
+
+/*
+ * Check if option is deprecated large_read.
+ *
+ * Returns true if the option should be skipped (large_read on kernel > 2.4),
+ * false otherwise (all other options or large_read on old kernels).
+ */
+static bool check_large_read(const char *opt, unsigned int len)
+{
+	struct utsname utsname;
+	unsigned int kmaj, kmin;
+	int res;
+
+	if (!opt_eq(opt, len, "large_read"))
+		return false;
+
+	res = uname(&utsname);
+	if (res == 0 &&
+	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
+	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
+		fprintf(stderr,
+			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
+			progname, kmaj, kmin);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Check if user has permission to use allow_other or allow_root options.
+ *
+ * Returns -1 if permission denied, 0 if allowed or option is not
+ * allow_other/allow_root.
+ */
+static int check_allow_permission(const char *opt, unsigned int len)
+{
+	if (getuid() != 0 && !user_allow_other &&
+	    (opt_eq(opt, len, "allow_other") || opt_eq(opt, len, "allow_root"))) {
+		fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n",
+			progname, len, opt, FUSE_CONF);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Process generic mount option.
+ *
+ * Handles mount flags (ro, rw, suid, etc.), kernel options
+ * (default_permissions, allow_other, max_read, blksize), or exits on
+ * unknown options.
+ */
+static int process_generic_option(const char *opt, unsigned int len,
+				   unsigned long *flags, char **dest)
+{
+	int on;
+	int flag;
+
+	if (find_mount_flag(opt, len, &on, &flag)) {
+		if (on)
+			*flags |= flag;
+		else
+			*flags &= ~flag;
+		return 0;
+	}
+
+	if (opt_eq(opt, len, "default_permissions") ||
+	    opt_eq(opt, len, "allow_other") ||
+	    begins_with(opt, "max_read=") ||
+	    begins_with(opt, "blksize=")) {
+		memcpy(*dest, opt, len);
+		*dest += len;
+		**dest = ',';
+		(*dest)++;
+		return 0;
+	}
+
+	fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, opt);
+	exit(1);
+}
+
+static int prepare_mount(const char *opts, struct mount_params *mp)
 {
 	int res;
-	int flags = MS_NOSUID | MS_NODEV;
-	char *optbuf;
-	char *mnt_opts = NULL;
 	const char *s;
 	char *d;
-	char *fsname = NULL;
-	char *subtype = NULL;
-	char *source = NULL;
-	char *type = NULL;
-	int blkdev = 0;
 
-	optbuf = (char *) malloc(strlen(opts) + 128);
-	if (!optbuf) {
+	mp->flags = MS_NOSUID | MS_NODEV;
+	mp->optbuf = (char *) malloc(strlen(opts) + 128);
+	if (!mp->optbuf) {
 		fprintf(stderr, "%s: failed to allocate memory\n", progname);
 		return -1;
 	}
 
-	for (s = opts, d = optbuf; *s;) {
+	for (s = opts, d = mp->optbuf; *s;) {
 		unsigned len;
 		const char *fsname_str = "fsname=";
 		const char *subtype_str = "subtype=";
@@ -953,10 +1055,10 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 				break;
 		}
 		if (begins_with(s, fsname_str)) {
-			if (!get_string_opt(s, len, fsname_str, &fsname))
+			if (!get_string_opt(s, len, fsname_str, &mp->fsname))
 				goto err;
 		} else if (begins_with(s, subtype_str)) {
-			if (!get_string_opt(s, len, subtype_str, &subtype))
+			if (!get_string_opt(s, len, subtype_str, &mp->subtype))
 				goto err;
 		} else if (opt_eq(s, len, "blkdev")) {
 			if (getuid() != 0) {
@@ -965,7 +1067,7 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 					progname);
 				goto err;
 			}
-			blkdev = 1;
+			mp->blkdev = 1;
 		} else if (opt_eq(s, len, "auto_unmount")) {
 			auto_unmount = 1;
 		} else if (!opt_eq(s, len, "nonempty") &&
@@ -973,122 +1075,132 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 			   !begins_with(s, "rootmode=") &&
 			   !begins_with(s, "user_id=") &&
 			   !begins_with(s, "group_id=")) {
-			int on;
-			int flag;
-			int skip_option = 0;
-			if (opt_eq(s, len, "large_read")) {
-				struct utsname utsname;
-				unsigned kmaj, kmin;
-				res = uname(&utsname);
-				if (res == 0 &&
-				    sscanf(utsname.release, "%u.%u",
-					   &kmaj, &kmin) == 2 &&
-				    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
-					fprintf(stderr, "%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n", progname, kmaj, kmin);
-					skip_option = 1;
-				}
-			}
-			if (getuid() != 0 && !user_allow_other &&
-			    (opt_eq(s, len, "allow_other") ||
-			     opt_eq(s, len, "allow_root"))) {
-				fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n", progname, len, s, FUSE_CONF);
+			bool skip;
+
+			if (check_allow_permission(s, len) == -1)
 				goto err;
-			}
-			if (!skip_option) {
-				if (find_mount_flag(s, len, &on, &flag)) {
-					if (on)
-						flags |= flag;
-					else
-						flags  &= ~flag;
-				} else if (opt_eq(s, len, "default_permissions") ||
-					   opt_eq(s, len, "allow_other") ||
-					   begins_with(s, "max_read=") ||
-					   begins_with(s, "blksize=")) {
-					memcpy(d, s, len);
-					d += len;
-					*d++ = ',';
-				} else {
-					fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, s);
-					exit(1);
-				}
-			}
+
+			skip = check_large_read(s, len);
+
+			/*
+			 * Skip deprecated large_read to avoid passing it to
+			 * kernel which would reject it as unknown option.
+			 */
+			if (!skip)
+				process_generic_option(s, len, &mp->flags, &d);
 		}
 		s += len;
 		if (*s)
 			s++;
 	}
 	*d = '\0';
-	res = get_mnt_opts(flags, optbuf, &mnt_opts);
+	res = get_mnt_opts(mp->flags, mp->optbuf, &mp->mnt_opts);
 	if (res == -1)
 		goto err;
 
+	mp->optbuf_end = d;
+
 	sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
-		fd, rootmode, getuid(), getgid());
+		mp->fd, mp->rootmode, getuid(), getgid());
 
-	source = malloc((fsname ? strlen(fsname) : 0) +
-			(subtype ? strlen(subtype) : 0) + strlen(dev) + 32);
+	mp->source = malloc((mp->fsname ? strlen(mp->fsname) : 0) +
+			(mp->subtype ? strlen(mp->subtype) : 0) + strlen(mp->dev) + 32);
 
-	type = malloc((subtype ? strlen(subtype) : 0) + 32);
-	if (!type || !source) {
+	mp->type = malloc((mp->subtype ? strlen(mp->subtype) : 0) + 32);
+	if (!mp->type || !mp->source) {
 		fprintf(stderr, "%s: failed to allocate memory\n", progname);
 		goto err;
 	}
 
-	if (subtype)
-		sprintf(type, "%s.%s", blkdev ? "fuseblk" : "fuse", subtype);
+	if (mp->subtype)
+		sprintf(mp->type, "%s.%s", mp->blkdev ? "fuseblk" : "fuse", mp->subtype);
 	else
-		strcpy(type, blkdev ? "fuseblk" : "fuse");
+		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
 
-	if (fsname)
-		strcpy(source, fsname);
+	if (mp->fsname)
+		strcpy(mp->source, mp->fsname);
 	else
-		strcpy(source, subtype ? subtype : dev);
+		strcpy(mp->source, mp->subtype ? mp->subtype : mp->dev);
 
-	res = mount_notrunc(source, mnt, type, flags, optbuf);
-	if (res == -1 && errno == ENODEV && subtype) {
+	return 0;
+
+err:
+	free_mount_params(mp);
+	return -1;
+}
+
+/*
+ * Perform the actual mount operation using prepared parameters.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int perform_mount(const char *mnt, struct mount_params *mp)
+{
+	int res;
+
+	res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
+	if (res == -1 && errno == ENODEV && mp->subtype) {
 		/* Probably missing subtype support */
-		strcpy(type, blkdev ? "fuseblk" : "fuse");
-		if (fsname) {
-			if (!blkdev)
-				sprintf(source, "%s#%s", subtype, fsname);
+		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
+		if (mp->fsname) {
+			if (!mp->blkdev)
+				sprintf(mp->source, "%s#%s", mp->subtype, mp->fsname);
 		} else {
-			strcpy(source, type);
+			strcpy(mp->source, mp->type);
 		}
 
-		res = mount_notrunc(source, mnt, type, flags, optbuf);
+		res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
 	}
 	if (res == -1 && errno == EINVAL) {
 		/* It could be an old version not supporting group_id */
-		sprintf(d, "fd=%i,rootmode=%o,user_id=%u",
-			fd, rootmode, getuid());
-		res = mount_notrunc(source, mnt, type, flags, optbuf);
+		sprintf(mp->optbuf_end, "fd=%i,rootmode=%o,user_id=%u",
+			mp->fd, mp->rootmode, getuid());
+		res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
 	}
 	if (res == -1) {
 		int errno_save = errno;
-		if (blkdev && errno == ENODEV && !fuse_mnt_check_fuseblk())
+		if (mp->blkdev && errno == ENODEV && !fuse_mnt_check_fuseblk())
 			fprintf(stderr, "%s: 'fuseblk' support missing\n",
 				progname);
 		else
 			fprintf(stderr, "%s: mount failed: %s\n", progname,
 				strerror(errno_save));
-		goto err;
+		return -1;
 	}
-	*sourcep = source;
-	*typep = type;
-	*mnt_optsp = mnt_opts;
-	free(fsname);
-	free(optbuf);
 
 	return 0;
+}
 
-err:
-	free(fsname);
-	free(subtype);
-	free(source);
-	free(type);
-	free(mnt_opts);
-	free(optbuf);
-	return -1;
+static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
+		    int fd, const char *opts, const char *dev, char **sourcep,
+		    char **mnt_optsp)
+{
+	struct mount_params mp = { .fd = fd }; /* implicit zero of other params */
+	int res;
+
+	mp.rootmode = rootmode;
+	mp.dev = dev;
+
+	res = prepare_mount(opts, &mp);
+	if (res == -1)
+		return -1;
+
+	res = perform_mount(mnt, &mp);
+	if (res == -1) {
+		free_mount_params(&mp);
+		return -1;
+	}
+
+	*sourcep = mp.source;
+	*typep = mp.type;
+	*mnt_optsp = mp.mnt_opts;
+
+	/* Free only the intermediate allocations, not the returned ones */
+	free(mp.fsname);
+	free(mp.subtype);
+	free(mp.optbuf);
+
+	return 0;
 }
 
 static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)

-- 
2.43.0

