Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685E3A874C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560924; cv=fail; b=rCtEVXvPhJCTSuF75PvlubkhqNzKwBVsmyp1nG9hvnUC/XkKn9tT9fbQ9R2fF+EbTuTE2MVv6lY/6+NSyUM/frwtcbmgzmVklLbP/T1z2kn6WlMEIW1lCZ8bdSoBHHxwYYrQ5UGsyMd2GNdhZ4dcOfoOR6GLmOQu9XD0kLTwD0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560924; c=relaxed/simple;
	bh=tvPsFTwKP1yQayoyr11Osred7TO29ppi5VWpFJNTNwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TX3DnZMh9WdM0de2WAjTkiwXTLY3mcR6ExhvfZv98aSekoTbH4dVsfeif6yOqrNay4X8wjysEcXu4u2EXwDN7r4Rx1Ywfm6U2CxG0p+xXikWxeystxHMsGFnD6pQmapSVusRCkYdnjVCqgxR/9OdeCsvXhVehH90P5E3vxILptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=cCEVHqmM; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="cCEVHqmM"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022102.outbound.protection.outlook.com [40.107.209.102]) by mx-outbound20-201.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpQ9+uho1xSJj6Hee4WdnDn6LlEoq8PjfyxShTeQoFbIQb0cRqeMrJLJR3lUgPENkgjxwTy/nKTedu8JjPGI9paWgKBx5DguQR36iox1WkThj26rftzVhAnwlbVdJSARz4s6BAYo1//2skrrW8tG7wbwsZyTC5md6GmqdgRcapMPHXFY0qLUaZz4SRJ3MNmE+hnlsjcElaNY2JucAqTx0Tp1SV7xGjVimIw8JI3gH1YJo5EuXhoncxUhpe8UydulGoMX/YgsGC7e0zhVe7KSzEm+r8Ky5BOsjSx9NimVeXTnQTOjqe1szGmmKVNaeTffAEI5s/Dx4236j5nHfB4C+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k93J1QTMbnsqmANInijHYF3B7zDCFfPCeMH0AgkT0TA=;
 b=gdcIBAWOHbYXyZagzLEHb/z5PNrMwSy1VpfPAKeGGElVvV/tUh/q5NjT4AH4u+hdhVt9JiEXwO+UGDpzQwpsl70YmADEiVL9zMVFNtrL9NxV6R7w+jai7OZ+BS7jDSHGVarY4X6ld9mMHWjRhy2mtMlXegAdoUdzMCDCSGmM7Drkk2+kMHvcK4tXMDvf+SvxBxFXyplPEqEBtwzvqfF54T4tvwp6QUCihLd8+IuKsrYX9yOcE3mOKaKV+Lsxj/wkaQDQtrl1PaPqNJOO+GhGNppOn6PuWNrq5hn5KihLJeXpJ5GmULfCrlnSHFK2R2raIP0yl5PfKRVPGLOSMjBAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k93J1QTMbnsqmANInijHYF3B7zDCFfPCeMH0AgkT0TA=;
 b=cCEVHqmMTLxflwDeYjQLYfCQ6kWIxjGZOY8ZfKJgiS1ObZVMTg5414HXFcMeImCt4FiYQk1ukddwqvsdwFj29uED4U9q/K1jWkmWlFVyojY2l5m6MHiS/tKELVS/MlDT2Oam6duoB7/aH/A4MefC2Npit8HdGyo5KxJcPRSgegg=
Received: from IA1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::9)
 by DS0PR19MB7394.namprd19.prod.outlook.com (2603:10b6:8:141::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:11 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:464:cafe::85) by IA1P220CA0018.outlook.office365.com
 (2603:10b6:208:464::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Thu,
 26 Mar 2026 21:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:10 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 4F5D955;
	Thu, 26 Mar 2026 21:35:09 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:51 +0100
Subject: [PATCH v2 18/25] fusermout: Remove the large read check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-18-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=2073;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=tvPsFTwKP1yQayoyr11Osred7TO29ppi5VWpFJNTNwE=;
 b=dgGGW22apMzzw/XqB5DH7I7p5o1dabUyDhEiAWNoizgBUfkVCcQK8lUtqb+TAQgMhDs9sx8GQ
 97q3thTihz8C55rNgC6W8ahLMtlamRfUBepcpMozN7Vhypqa8rZVnLi
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS0PR19MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c72c69-0fe8-4cda-f5e3-08de8b7f8eb7
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|48200799018|36860700016|19092799006|22082099003|16102099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rPxqq6JCldyv/Pxmy6aJKRoioAK07qkjIi5szWGn7xlGl5K/4iVCKGTLnqiCqS3PK5B/V5aFrMeM42wvPiPxiqUrudTgFjo1jke5w9D4vYzRVaKRk/jPHMMAInzpEAxD2BWKRJ8JebMEa5uF9GkE99HmEIwthDcBrJVUDB1R33aKXaVd+ObHrI/JTK1PCVlGn45UXWZT9YDpaV0v4Bxd10apvVNusrAhuXTmlfcqE/eB0iAfOE6wVzay99VXtjnYPlEEdXaoGgC/XlHX7DsC2xF3BIHYkleULJeFls12Pa9AWvVkDRyji9rcEq5P/jZLpkFbwmqaUt9Q19jNrdRAazAWdcIJz7EIH5+TTXI5xE7YrgbxNf/fpkfmu9ji6RpilTtARWg7zUySZHWd3QYa+6K9LkSCvysyDO2x3w8yOfX4MEMcXxZkdWkWrf7Ar+SoK46Nei6/uq2tysLYl1YCd0I3Q+WLw/kiJJHVzo4IthtqCmApG+anVmvgGBA+xeyZWe/AxyrSDUN/phf7DUakQ8NCp5MyQKmxZVGHTneI8AH1ggOvZO/mlMiCHROyd8QCpdeZk2FaAkgvHex9Fr0Hdba2IYltT1g0zIWSghMPfL1SqifotXMOg0+IruB3LN78bq8vj4S8IGIoX0vmJOXKC0nwKFY5W3lI56kEdNJyBTvqgegHq0EwIxnOxRE3YEJtNTCtum1+O5Ij1QXtkFWCA3bUGvigTmkW1gLD4hBN6Z/+op0567IsOyxINMsxObyclC9PzH5XtUMA/UD9oq3Wyw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(48200799018)(36860700016)(19092799006)(22082099003)(16102099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wTmI8yNLVs0hQJqGRJwf4W1MR9fOvVWuYgUKYDWHkeHvVFxdqgy1VNdwKgYKMUG99Jv1UNPANsnZY83v9AIuf65b1zA1njgYVZ+9CsRK3ScVk9ZHm07Go54YbnlhULvb9yXkLdbuPnSdlBPANcEAdCJViC/E1ZWGwPxPSMj5HiFibDzmgmiBvU6hDoYU+1sZzqR3fLvXtTbwgjNEZfH9IhHrysXtd4lD3WuaOdlswqvbbCeQ3ybtRgyhJpjtV4WnjygqV9ifXjfOSf2D3deUGWhnlbZBxlSLGs73j0lRPje+C4QTnPw/bjjA5kpgPYBZR0VOwsWElMxUvpCLXJlcSDrewRCXdUjXP+gzRNEyWYR8H3MqWCKqYLO+irQiQHmgx7a+iuFCQ7UQXKxtPihxWwjf6ocuDA7C/+RWnV7aHyFHQ3XQyHNS1BqgLzB990+A
X-Exchange-RoutingPolicyChecked:
	JNinXhQoYiZLq2brFScTjr+rDsY9MDx/GprfWlit5DvLfsMbAFNksc+PiELedwRrmB5onBjTNP0nL6Fa22c3QSB0dPfwvxby7FyaN8GVfuFtTrdm/X42BgYNyw5rano5VwRuJLMq1MH7FWr/lzpH7gT/PmKKsjGKXlDXMB998s+UgpNrjiBjdC5CENiu6ay8wNNWRsPaJZwKhzrM+xIE9Qsonby7Iacid/9M4100/0w6M/2QNPnSz7Ot09CVe1HO0rju5GSKGHdIMH1ToYUv3oZQozOQG4SZf7saiJ/6YocWpd3IRSag/j+vMxgO5QOQJNJywxM1c6RdxnTSQP1t4g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RnUvwxXKxLI4dUcEgLX1ZuEwppZWtZyOyTyOry8m6PFPszlTHxXMwjRyqogm13YgfH8IDcMQhRm7dgat4GRCoQsd3pVYVv/Joj1O+I/WMzzh6l5QSs70wMoyHkAHwErqcTQM4jpPF0z3vpanYU4tdKXCrlPanqsS6ygjJ9yBpMrRmTwF58gjN3k85lT2GNQ3czZQ+p8qMPJD3mVrZ8aLkchuyMxizR31QvjFI4vldQNsG2DWN79hONPuh2IpsargZ6W2OOSwz7w+mEoYiqbQf5ZAPPNc+Og6hrWRMjrcDWBZav2XlFXjM2PwTWXw/Ca66XbSunBCEgqn1CSEWJOpVx5lge0Q714W08C0cwmqOf9Lcigryo8Wwxx/QBROr43VsyZwD1hrZWXHR8ddWdujnJzOrKnosz2HPPrcy2WpQ7VnhP2DFanPgOB2yS8cQS3OUU44UlUYr+yu9X8WzIwvhxTih+aJuTqFUMVSLq31/4FnITfUy5igwPVRmlxbrZQpZ43YaTmRREaTHeliJ8+C8ZhpXYB/hLy5StlkBzQa83GYuE+SgCGxeCNcBu0rE+bUkCsIRh7k3qtwecJqf0+FMSg+mx8HVOA6Vv7FC8mJeC/34Nhecg7cYnTOrCKXzQ3NFGFDCcGC0L96E2PP/eh1xw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:10.3375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c72c69-0fe8-4cda-f5e3-08de8b7f8eb7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7394
X-BESS-ID: 1774560915-105321-7672-3080-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.107.209.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGBoZAVgZQMNkyOc3I2NAoxc
	AsMcXEwiIp2cwozTLZMNkyxdjc0tRcqTYWAMQPG/RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan16-242.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

<quote Darrick>
Nobody's running 2.4 kernels
anymore, right?
</quote>

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 util/fusermount.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/util/fusermount.c b/util/fusermount.c
index 8d7598998788f72ea05c2a065a88cb5efd61df35..254f24a98abf935846cfed754693cc1958c8d2ff 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -915,33 +915,6 @@ static void free_mount_params(struct mount_params *mp)
 	free(mp->mnt_opts);
 }
 
-/*
- * Check if option is deprecated large_read.
- *
- * Returns true if the option should be skipped (large_read on kernel > 2.4),
- * false otherwise (all other options or large_read on old kernels).
- */
-static bool check_large_read(const char *opt, unsigned int len)
-{
-	struct utsname utsname;
-	unsigned int kmaj, kmin;
-	int res;
-
-	if (!opt_eq(opt, len, "large_read"))
-		return false;
-
-	res = uname(&utsname);
-	if (res == 0 &&
-	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
-	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
-		fprintf(stderr,
-			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
-			progname, kmaj, kmin);
-		return true;
-	}
-	return false;
-}
-
 /*
  * Check if user has permission to use allow_other or allow_root options.
  *
@@ -1041,19 +1014,11 @@ static int prepare_mount(const char *opts, struct mount_params *mp)
 			   !begins_with(s, "rootmode=") &&
 			   !begins_with(s, "user_id=") &&
 			   !begins_with(s, "group_id=")) {
-			bool skip;
 
 			if (check_allow_permission(s, len) == -1)
 				goto err;
 
-			skip = check_large_read(s, len);
-
-			/*
-			 * Skip deprecated large_read to avoid passing it to
-			 * kernel which would reject it as unknown option.
-			 */
-			if (!skip)
-				process_generic_option(s, len, &mp->flags, &d);
+			process_generic_option(s, len, &mp->flags, &d);
 		}
 		s += len;
 		if (*s)

-- 
2.43.0

