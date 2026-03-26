Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9D3A873D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560925; cv=fail; b=qmRRqC7iHM0/YqtAsLbm3yr06Uc7J4BuH6o1hqsRYr6hkqz+uzHyNHH6EZwbGuq7gDYPYaf8oekwoLqE7GUNi8dbzto8Ob0Rp4P364AQvx9bTdsZE/k36TdhkvPNjNrNZzpfTfGej3eYKISE6mKjFydPr5WWcSznKabjpxvTKH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560925; c=relaxed/simple;
	bh=u4duyJ1tgKYntsb+Prqw7ixyqBDv3TqeXjRxGkvOuKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/vStdX0tGQc+Hm7TRlDUftqPEDZyhLG6d5Yi1MaTHgfpz/CyMdZxgZbk4sFR6Sre1uvrU7hqcFXajJwD87Ld5NSUqeqlTO3yb4LvvUcgiHC7+bARNABHyTOWK94sHSvET8D5gEK27d9ZD5hzQqVYAyB/DCvzQGPsrHbZFw/8s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=XdmQ0tkX; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="XdmQ0tkX"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022136.outbound.protection.outlook.com [52.101.43.136]) by mx-outbound19-44.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC0ll92ksbDjm6UNTbuHM/EcyedseAHfQEVJ+nJP2tALb9xzfKmvQenOpgMAV+TWrpSawqTywKAuUwLoaWc0SwNLLaPisNVFnB9TffnBm2K8ieuxcfeZPxamERxqAbPsHRetH9+cwY7Z0A2FztKy5pdQuQlaX0Bnb1Yhzl91IGdGwHRD2AcsrSS6qpSErG9asGHVR87b+3D1vs9sGG+HPW8GNq1RpVg1aJvlbbjMtbVoXBL2rEcTiUj9XEfKxasow8Qjg7LpEH6bwPPwFKSYPoVRXmC9OPiNsTpIjez39Y6IGNQ2S0Pzmi6sJJJIuVgSywqf6ZA0bk0qCPWOF408sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbaTUGKGobk7kjTdUGGDVhfSM/DiYsYWEro7cdaG0vk=;
 b=PiTuLAw8f33icTF9mhPTfQ7BHLoyLuUD+1FFEUgArfv6dhIsAwpEdh00KIbYjkNTYQpdr35pH8lWH0y+m5pGbnCf8nktpr2CAtsbXryMBUbwRNZziIeyJqGqnSSgLgR2dW7XGM/WN8kjwNfXftq1RttKLF49ARbQzz1qLbB5m7CadpvWBgamvQjJRnTVD2EAOBs/YDH11hSMNbwKqKSV3EQ31lgRoi2yQARqBt/T5cNvSgi6Xv96KjluR5ck07Gbo8FfEyHU4YQD4y1hhx2Bwze9ahxbekC/BcquUslOqb+Ok1OPZ9NBiPDPmoUUYug2rao3eFlLeUjiToC3ownHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbaTUGKGobk7kjTdUGGDVhfSM/DiYsYWEro7cdaG0vk=;
 b=XdmQ0tkXmGHDXXo5+Pw3gzsykR+IpMhTeRQM8lPWvSXS4DLkcMA2+07tiYrtwOMyLJjRWMQqPvwviKVfT+x9fOpDSv3BAix7/UsojzO44SSRyZDVHQOSA/vqpHBYzhXe1vKJWWCvJuWLTBZnsxZOWnPj4f4aDbzGRIa54Cmj0vo=
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by CY5PR19MB6217.namprd19.prod.outlook.com (2603:10b6:930:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 26 Mar
 2026 21:35:02 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::e) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:01 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BF4168FD;
	Thu, 26 Mar 2026 21:35:00 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:42 +0100
Subject: [PATCH v2 09/25] Use asprintf() for fuse_mnt_build_{source,type}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-9-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=1588;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=u4duyJ1tgKYntsb+Prqw7ixyqBDv3TqeXjRxGkvOuKA=;
 b=jgMCGu+8Mp+biaj9pnzAFruZOYMZlLNnkIj40tH+s5aaCniBLsDtOxq1rJMXyHlgXiZDWD7/Y
 hkZvggNX8fXCSc8zMGjiKz14a1Q7BULDoN4KPSkG8APTOl1eF825LfT
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY5PR19MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: ee308fe3-7abb-4b34-7a2e-08de8b7f895e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|48200799018|19092799006|376014|82310400026|36860700016|56012099003|16102099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XYimgKZqUeIXpzypJx98UUVsWKAAiydXNgj985hqaGy5bafDk6Q0patYxyTySlnRJlepuTLDysbSQlviyYhmnENw+4hj8EIlej10fL5X3GS7tnTygEbTgn2mPN86A7aqnwAlJ+73Sttgdr1ruQHVWGQELYLToBWTx6G0wD8T64SNbKvfBEzUuOZibwv3+CGf0XZ4MGcgngc9mYsDpNKM2jNm9kNyIYCZAfhJvXxVcKmzbtn6ENxJ6e58Ppw7du4xaN15ZXl4WbxsRL+ZOaHWSjjq/mG7+71DLGWYA8pZFaYEF1SNOR6YPLYoSmLLWDPDtQiCfaZTKO/GHxYxvUFnddjcIjngv8xV3SqRCblCLGPvZjHEfgW2zKpjvxpKGcPPZDJ5NvSRJlHRINDeqoTV5mpdSUW5Z7Ef2K6tZNqDdJhbJCwH9rFWNMfdRukNRtkboqX2XdprXUHK+8Fpy9f3D23EA9m2n3q+l7AYZym7dkvbgcYERgQ7m4LWSB6nhRa+V1a5KD9/nv88Cr7OTSTXwcbK449YjpqQOz2P7fC33yllWspMwT8emDy7K/+kjbMcrUnV4vh/Pa+JMrMUPMIrKXHMJVwDz34L3JeLn3Kr0HcoLy9IttWto8vvTWvTT6FUwqylaqxrmuIB0ptYnZ9PwFdfX2IR9vg/PGko7xRK089TPj4yBua5bDX7mkOSpT+XG7Q4U3YNEK1EBh9DIcGB9i6k6gQo8t37yHZeCluUXQXHLHqXAoQoQjxSbWL1ZkfYFm4zqSLy6uHaYXGloI3TOw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(48200799018)(19092799006)(376014)(82310400026)(36860700016)(56012099003)(16102099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LVauY/P6EXJoBlZH/pQXWIRQwXeIPrNmGk20QKA+DZGs2HSCOwViwWTT4Xwxy7JQOD/68QEnvSkKVsCh6YF7vnBwJ+5hOJWZPKN7v6PC7EIDqWaVzrgiEPwg5kdsQ4+sI4xUKkWSaWyo/q88TX5SiuKb91tR1C+mdIo6dHMKftwo4YJpkhnrXgNaqrEFeaOCl0MIXYntZoF0dshkX+9x/NMt6QoCFhG57yzcvnMwh0o6DMRIG20j2o/JClNbG3A1KujBDaw6QP/LUIgXwiMNrbYo4ggaZ37BHlZ3Iwib/4li8BG44LAN6OFcYjHTR6+/RlBis1gKHfjzFFagxqwMXHmoen/n/miyXVjW9BVafNb3oI+awu5908/1Lg9yEuIxJwKTiTbVQH5Z366ByJpuvTbGuH9ZRFdUayp7i8EwA66oWQvArOpyL3BjtmXcs8Qe
X-Exchange-RoutingPolicyChecked:
	Sw0BndNX62Z4XKzWQhDiBC7BtVcfIgGDvUCyzyv5gn8JTGfl4VDYnQOb8eq1/+RK7Ffw9p8rT3FkqhTRBGqTNBAUzFvtIqEVn1sjw+U2QbPmH6tOlKxHCLyS6GZQMVYkMYFI9LKwd/mCmxz7tq72RmuQ8vseNPtygpA6u6NK/t0HniNukjTEQaYuKEfFs4kzI6vcKHqaDDL2e694K8GSFeWbuFqCJGx2YHfsR2KHgy3hnHthqegduV+FKZ/yMKGDTHsA8DMY6azj1sGGUUEBXH/5twMQXZ/ghxVOJMNHjTTMAj+HshwQyCVdNhsokIurpryHiNwqIkP7mPKc/XWm1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f72+qcXJ8Ikwtz3c0vwqox4TFEvxGR1lhXykXZnYqD2710uC/s32bmMAMmjBy4lmCiTPdrf3VzQmArBGykhAkE6h0QTqn1UsF5ypD5kWxviopx5M9Z8+QSKaspcXALM4zkokKHnZI3RCfeAVKpuQhEEJu9Nm5JA7G0xrJgHPZ+VBxeRRtz0jozaZuHZP4lC6IHCEoRF7SEdTYJUjrW1YUjdBk5XZLYmQni26Fqj0yQHa5fJ3i+s71unLBV5mOA+w58M57LrYn+YJev2OzJxj2Ywzn/lek9m8wPaItGpp4axWFg0hfEYBPHxNTjijdyu4hMDPJWLqNw0SSzm1yy0dc5aINVlDaXU7/++ykXDeEA5xQ4LH8LRuCOvng3jYDW6dufCTM1qX/YlkSmLHfcHAWcKk4T3VAEv/TaiKaAIOUHKxklxED6FliXoRXErl7puSKm8LB3CNnicXPhwk2mfuTC7Kg55KNGXojK4qh9G4AadnyglzWa7w+KjT8VlGkkYkb6ywlvWCG3sAA6OJqrsL4YRt8nxGuyRK1SNOyZxzfKcp7SQ5yuNC3ko99gnMGFCo4RQYrx53+QwcHmzMADwVISbcSmI5xI7IZUsx3t/ch6iZxzbJqyDuhedAJF4DRLlmXUlVGWuP5rFBmukuhaub5Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:01.4469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee308fe3-7abb-4b34-7a2e-08de8b7f895e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6217
X-BESS-ID: 1774560905-104908-7702-14667-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.43.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamRhZAVgZQ0Ngs1dwyMdki2c
	AsxSTV0tzIyDgt2TDJPM3AwMjE1MRcqTYWANfjXvlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan14-20.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Simplify the code by using asprintf.

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/mount.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/lib/mount.c b/lib/mount.c
index fe353e2cc4579adb47473cac5db7d1bae2defb2c..68f9219d2b8beee51346b198ce826138b9528e73 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -754,32 +754,30 @@ char *fuse_mnt_build_source(const struct mount_opts *mo)
 {
 	const char *devname = fuse_mnt_get_devname();
 	char *source;
+	int ret;
 
-	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
-			(mo->subtype ? strlen(mo->subtype) : 0) +
-			strlen(devname) + 32);
-	if (!source)
+	ret = asprintf(&source, "%s",
+		       mo->fsname ? mo->fsname :
+				    (mo->subtype ? mo->subtype : devname));
+	if (ret == -1)
 		return NULL;
 
-	strcpy(source,
-	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
-
 	return source;
 }
 
 char *fuse_mnt_build_type(const struct mount_opts *mo)
 {
 	char *type;
+	int ret;
 
-	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
-	if (!type)
+	if (mo->subtype)
+		ret = asprintf(&type, "%s.%s", mo->blkdev ? "fuseblk" : "fuse",
+			       mo->subtype);
+	else
+		ret = asprintf(&type, "%s", mo->blkdev ? "fuseblk" : "fuse");
+
+	if (ret == -1)
 		return NULL;
 
-	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
-	if (mo->subtype) {
-		strcat(type, ".");
-		strcat(type, mo->subtype);
-	}
-
 	return type;
 }

-- 
2.43.0

