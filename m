Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2E3A16A2
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560926; cv=fail; b=MdcbvVd0DraW38doKn3IlWtBNAYWnT666nKr3465j3zlto2WiV8i3E563C1v2T1DhVhwIDtFLnBKSlAFZzejEb3fo0KARNaC25AzBGzcB0n/sWWx5EPZRBoaHs5HKny0mt8cV69YhmFadBQZXr8L7+rPO22PyWLKPvkWkensJEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560926; c=relaxed/simple;
	bh=U9YrefuEi7+pXUss9rLG70iUtKJSAfzw7FKOGHFu/p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNLwBNXAxDK9MFF3zjsMBDM3tWfjeO4eRSH32WXMiHCMSM7Et5acdtvf3i90hX1E9AzShje+YGKjzBXwRj+RQ7h7kZgTzjqzhcv2K8Hyb6Ew4MTwXCUASO4jWZNrvn4cGEGQUt6vdK4/Wt20clO+vLvuak9nAjsXCJUUxrB4TfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=irrnRjZF; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="irrnRjZF"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022077.outbound.protection.outlook.com [52.101.43.77]) by mx-outbound14-3.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmS98PevZa4NmbiGfhb9UZvi8GzPqGbMNKq25HJ28AGW8/I0lA3sh5SZxWqYcT2TCLoUDCgzshTpV+CDMFyFfTqjYydlEp0G7uLzgR2xkckFNxiutevnmsOdZNG9zUNlsJz2yR5+NWTBG/TvGB1B+mg8XNzcsUyrtYbY3lnQbIf+gRp4QL8TLx7lLA8R0F8xTSJfEmbUc9EkF6XLIlEATPVO0JT1mxzT+V1sI4hy1uK11Z0I8pv3IKFSif3XBADEXnkWNBffQPfSwGnAq6hs7au2uJTm1g1Sh3Sn3zfMiYB6hcWyWXGLmv5Vy2SjnbU0GQ2LLDx/EVfptLWSuWpU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fdki+lwv0dIST7HPERp1mpvsX3Aaqjh24k/m4wGwU98=;
 b=Zugv949Ud9IK/QJQgD/gH48hDWeZDnbKmxEucgasnYoCzajn5+mmb1NA6eRndG9CtXKw0XZylStp+fIihT9rlyAgNN7nkdlcDCgOsesN6cF7IHkl7VsHIg8QdCoRm1oWr9VfAebrTD6mWvnhJ+UV4TjLrhsx6wRCywczJeIVRtdBIrOz3AvNNAGNF6kyuWRQub3nsrOdNQ5QL6UaLiDtE/icecJpUv95sUoZzMxc1HJt4tCU0kizPKtd1V49wCHPFtv8Fk2RaUGlXV6WDCa44ajZ6qVUyC+w8eNgJzRNarqikXgur0l6NpOVPoSH+7ysFf46nEYWePJx2lLrl5b14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fdki+lwv0dIST7HPERp1mpvsX3Aaqjh24k/m4wGwU98=;
 b=irrnRjZFimKUR7DFKvz866gizc0LwN+MQPksAK4SncmJ1mEhSAfNyM0E3r8oFrvMTXsU+jNPHiWyIGsHIexUUsEEoKLJbuVSrrKw8i79gSXastHPSjryYNcPEq7ab0ryva7+0RroS+YwscXPOmQRGbJEPA7+/pqWR4A6hlkYY3U=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by MN6PR19MB7989.namprd19.prod.outlook.com (2603:10b6:208:47e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Thu, 26 Mar
 2026 21:35:13 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c3) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 21:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 29BFA55;
	Thu, 26 Mar 2026 21:35:12 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:54 +0100
Subject: [PATCH v2 21/25] New mount API: Filter out "user="
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-21-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560892; l=1961;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=+CrvCti8fzLOna4DE5cTXEOAtA0hUxPkZq1xydbCjYc=;
 b=Khw/dDocK1Yr8QdATtP8HtOfEmSVpCX4iftSOJpVQAY1hMtIGL483nMbmwqQQM/Kb06tlcI6a
 FuOOe+VRcYPAMLVpuye5DoSC/LO0GLV9DtSQXyaaKdXO9JRWB/HCUdq
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN6PR19MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 824b2dda-d127-4f3a-1a5f-08de8b7f9035
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|48200799018|36860700016|19092799006|22082099003|16102099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J5pTI+3C0tiXm1k5H1dS2fmmsKkk5HjPx9uEVVs5nsuzu1BFFeVaHkksCuvGWkcS/6nthvPmX4yeFfkwkDSmu83u77YHoR3kKA0iCwkBtCpTcDzSTSLU78/CObC+D0eCCjus/+DoWVfvYOx+lRBrZHGwwexd7UQ3SA0M08E3p92x5a3PsHvaQ2GJF/xGHJqcIrF5W87szDo7M36gIKNcBxjr0XofdmRxVMOEIZGA0UBGCiWo/Ke9ewRl+8BIrEXoek6iR0Om5AgxftmIlXcsqDxUX8eF50T/7ty5vHuUtt2p3EUOtKaKjavdGLAYrhFum2zGvuT/tpkyGNvuDLhEd0JT+d6L209me+AVOGIIb/K2hOLmN7Lshgg6BjwUT8bfhVhpQhcLKhdbyjCGM57JN43NGgfa6SP7m3nn5KPWMXG9I1KYM+VhV83gL1i8guf44wD/mHwdHpjikhbv3i2b+4q5455+7Z8tIlDjSob4NlgNQDbz3XqOiBt6sWy/t9vSlWUe0KYfnq6z6LBSiTgjUUrAeFMEz4rYiiq0fE7laJcKEkHqMVdQTpibniC3AelrIXlZKIiLdBQyonaYGTxO7OJyxC+rhmAGoayoNMyRJbDP6C2YRiHWm6vjwxEqtJenrSe0r/u6HL8FoU11je6pj3fcqSoU1qGe7qaE+RHzDxuvpJpG+Mb1wh4S2vgOexrNKvUtb4GgVdTaes9cKFQ+GvEZ4bzWkUJm0aj7TyQVgAezcOBzngnbjXFwWtNUbKy+m3CryJRAQzwVDx34pTm4tw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(48200799018)(36860700016)(19092799006)(22082099003)(16102099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LgBAR2wV6R5AkvbVWWW1mIf4Jqd+TVWXfaGVqbuWDC8ZQF7EEfXvK/rioMi8DQlP//9h0zi5XFR0J4cC36drTIPKIMUM1NaikM88E0ypTIL+jACrqbNYg0cCM74S9DoJ9MeNI6t8F/icbqcMfdHzFTwoIFnKCxR7eSDOTc+vYqxQUZP5vPa1kJEsjrKIMgEv/JxlVfNYEaJ3ZJfzOLF+oLdc5O7VWOUZ24wdjHgpD4pBbO8fMh7siQcQxQoSWxFiui/pUUx3VwNWpXSJItQoskRlU0uJEuP3z/Fq7FHC1tgO53lro1RJVPWAbyk7QrO0/BeuAHFTERw8oUo3ZpGFLh/ufBvjCgqVhlFL6iyH8XlpiRPl5YsuIAp2qlvxP0K+ZFyuNGz26lCG6sAFCZuQSmTweBnCFhNAznssORvnBhnE2IZUSnztlB0E3YdCu0Lh
X-Exchange-RoutingPolicyChecked:
	IXtpfDSCgJLFOIzdvr9hHR/De2tytqo5RBE5A2/Qla2xdN3oahnI9HU2U8TSjC2JwIud7Pyc0AlvuOW6TptGqBt/aORAaboxZ5GtO7v0qFtpbcIPHGO0qdf0zB6zzdTUZC4Yxexub5ytUcZ8QWG5Mu1/Dujli1f4RDDJMPwt1bdVaSn/RhfvbdiB7xOwte1cOzWmwBTlcLU22/z5elMmY3oXU7MuM890e5EapcMVOwQ+uUFgZEYS5V5QGd5aM1wgxIxbdNDP0SGhiXAxtpXMHA2VvLO8TQtK/FAnlAR3pJaiRPzS4+vZSoHTCvGqzHWqgb0njjrsh/KGhRF4/mq1ng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mS9b5LclqmLg6Ie+AyKiloTUWZH597EutAMv5N4mV+k80VXxZnH7dwoUjsWAsXC3gn/xUsh8s9n0UFTXrmDTnwLU1R0yr3R30+d3lwH5xV2T/uafbKHPhZyV8hqX1tNQ4ttc3u6O5uHx4lfgbuYcCvmKWr3qSqB1tZt/+21YeQumB4CemtAdg1/oPUf6SLAi+C7Vghi/heXGyaReCgJfv7WKNC6NRVL/7VtVO1sd5NoiKMGJg1fuRDIWf2CwBTw9vPCTIL7Qj+mIik3qraC95ytVEubLJBxqJGtMjKX2W6uF/9z4sSLp5Hf/7MSwTE1V5rDi/KcjeUqDVJneB9smhnYg1zbZH561C7g7lZXauOH7UUbK3of1rUlU8Gzi/RgOxcMhXFb8jMxknSPUctAdx1UP2Vc2hnyA36kMm2WzP05yFH1aLStaWKTQyZNcQ+J/IXugXmcfOET0BGY3aJusrzHE5qh13h3mw0SFhEIsoPb8R/PJsxKS0PX4BHVyyxkFAwREBWY155McmiEN6m4FzQfPCUkIlv9P8P5qDMmj3C+E4bnMxj32M2nMQJw+FQLdakQZWkirFI/sOD+UbenZ5hAtg5wDIWQSSfBAkvUcpodSdWnvqOAFr+5IesPSwGD/eYzgj0w5L2wpVBllw3RuRg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:12.9167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824b2dda-d127-4f3a-1a5f-08de8b7f9035
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR19MB7989
X-BESS-ID: 1774560918-103587-9766-3052-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.43.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWpkZAVgZQMMnSNNncwMzSwM
	DC3DIt2TQtKdXMwNDUJCkxJSXJzMBMqTYWAFrDLepBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan10-224.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This gets added in the fusermount process and kernel then fails
the mount.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount_fsmount.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index fbe3647a8923828dba819458b815c21bbd2beaad..f42ae97faedaf2420d97e701a22725d4293e4853 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -248,6 +248,16 @@ static int is_mount_attr_opt(const char *opt)
 	       strcmp(opt, "symfollow") == 0;
 }
 
+/**
+ * Check if an option is a mount table option (not passed to fsconfig)
+ */
+static int is_mtab_only_opt(const char *opt)
+{
+	/* These options are for /run/mount/utab only, not for the kernel */
+	return strncmp(opt, "user=", 5) == 0 ||
+	       strcmp(opt, "rw") == 0;
+}
+
 /*
  * Parse kernel options string and apply via fsconfig
  * Options are comma-separated key=value pairs
@@ -275,6 +285,7 @@ static int apply_mount_opts(int fsfd, const char *opts)
 		 * not fsconfig().
 		 *
 		 * These string options (nosuid, nodev, etc.) are reconstructed
+		 * Skip mtab-only options - they're for /run/mount/utab, not kernel
 		 * from MS_* flags by get_mnt_flag_opts() in lib/mount.c and
 		 * get_mnt_opts() in util/fusermount.c. Both the library path
 		 * (via fuse_kern_mount_get_base_mnt_opts) and fusermount3 path
@@ -282,8 +293,10 @@ static int apply_mount_opts(int fsfd, const char *opts)
 		 * mnt_opts. They must be filtered here because they are mount
 		 * attributes (passed to fsmount via MOUNT_ATTR_*), not
 		 * filesystem parameters (which would be passed to fsconfig).
+		 *
+		 * Also skip mtab-only options - they're for /run/mount/utab, not kernel
 		 */
-		if (!is_mount_attr_opt(opt)) {
+		if (!is_mount_attr_opt(opt) && !is_mtab_only_opt(opt)) {
 			res = apply_opt_key_value(fsfd, opt);
 			if (res < 0) {
 				free(opts_copy);

-- 
2.43.0

