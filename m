Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D13A8736
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560924; cv=fail; b=IbXcOfQG/Ry5PQdyz9ePA+Ru/RwPjyHfFEvQmRv8OdmlI4xn2cfZrGtGn8wFw03Zgv9GY9ILorPhnlMaJGxgeDCZPTIYNoaylSmRkEophCVlu8H+RvnCRd7I+BVgfzD21q3DRo5dkkK9VZFEY+5+7EZy7P73MAYet1BpGhYOXFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560924; c=relaxed/simple;
	bh=tFI3Z2hPpyyVYnO06+CviL5BRgAXGKJw+XzDD7b35YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bvznx+GZ5KGeuFjJrw5NKf0892caqvdim5fTfRx4+Llpw/FAwNFj4iWMH1e8LtCCocyPFE7iWYfZlKObIa631/vgrO9zkx/7HQakVfXYbT6vOazSab6UhEo6rMTGeiyvclWHDe2F1Kurnka6Hfu4oPsd0bYMJImmCOFNE6Nn6Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=TjfKnW9Q; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="TjfKnW9Q"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020077.outbound.protection.outlook.com [52.101.56.77]) by mx-outbound20-156.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt8RcjObnyAQLnHI+yvhfkiZmLKuoioASjgYADtBCXfTocxgAO1l+/3vOLwoK8WMhV6QFgvjnAAbIM8DoVA0Ey01hzcxwBMd9PeNTO0dmjBoKiCcot1W6ydJgz3sHyAUES+6wskz87d/RRvIZ1l0gZ4LOP3jMyQlZhG8gwdWA+dKjOLJss3h61IqpuWxxnUM78b8qqO9wJ+DbXwMDYUmop9a5Mqml/jflnHG/rgFzE4JEdN6DDdLMYppPaQ9Mpi+XgRNgFcjLzJpEe/FCv2ehjKFyNG8/2VPtB7wIV5+E9OHofUuEInIASk5rHlHPNKeETnv80b+0nuBWYSjNMFuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmZ6ra4CgMhJ/P7g9Qt4sa3PD4TCY8AVUthdY2zN10k=;
 b=rv3ZTJVc65sd4SKS6NYDtxks2+fAcrlBo9s6eWLnsVuHoSpsqxjzBMBPA5lIqtvRwnm5hWtcCLHesmzmMFM7AUISSnVGoP/upvJLra7nCXBw/3GGl/jkbZ6Bix3h7ISnmrc2LRd47vJKPP24skTwGwMIButqeyOlL9tAnUjbSEEoy7IQV+5QsBxFNZDWG0vjbH9knYCKCoOHHqcnOo9AcTLVa0RwX5KSJStuWMe/WLSKXj5xhDQ0/KRDK5OB3wR52XD7DWwjqvDg3w3Lu6ST1STJjcpN5D1gFW7HqvIwNCi7Sbr+rwgaMA6w51zizagx2BhP5UpbYLOiPzpUSJDQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmZ6ra4CgMhJ/P7g9Qt4sa3PD4TCY8AVUthdY2zN10k=;
 b=TjfKnW9Q15EsJJdqRFblpBNQOoKB9kOaHbgvFeTzWd3y907bFB322vss6LveTyh/CLwozodOo5jKRgZQNU0Mk+U/qy9V74eqXbYOjHYT8znK8Q2Zzh5NbQan+B8cjLKIpM0wnqnIPu46HhxgbMQUMiJs/mgB5rOZfNjKeTqoIxU=
Received: from PH8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:510:2d2::17)
 by LV0PR19MB9209.namprd19.prod.outlook.com (2603:10b6:408:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 21:35:08 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::e3) by PH8PR15CA0014.outlook.office365.com
 (2603:10b6:510:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 749C8772;
	Thu, 26 Mar 2026 21:35:06 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:48 +0100
Subject: [PATCH v2 15/25] Add fuse_session_set_debug() to enable debug
 output without foreground
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-15-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=2139;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=7cbeN+blVPhZ9KYZeL/OIQI4LZDfve4xXwHHet6/0/Q=;
 b=paH+plwiTFOM53tmIArltCZXWP5Tv1u6EyEjZ1y9RCGP6kybyBdMSi4iwQnkgsH1nFm993aG+
 0bYaRPwldfQBUU5YislrcwymtKdl9nKpR01SwHwZKsB2npiJvCq1yXw
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|LV0PR19MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8f06c1-ed60-48af-0fef-08de8b7f8d1f
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|48200799018|82310400026|19092799006|36860700016|376014|18002099003|22082099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1Y6Yzrvng0XANaBp6IC9xMffna2E9wXHr77fTs0fEUOBct2RMZ9nNt+BbhQWBkj7nz5/bqHsu9lqW4KqOysU8MBBPu76iaE5c9aZXl/ocxpg7lcq90ZzznfbBxYkhcJD/Hw2R60RLD5VR5wJZn2zmuN0uPoCW0M6Awvo0Oc7NFJJpfVfUNeGTh4pv4LBh0mpjx/MPAMCYtCD07LOYDb9yk7xn46UdNYPjYkgV81usjy5Nl/rjopEnjvpzb2licnfDkbiBorldkt6wGs3jG4KOgVzPZq9O391M7DEnMRHuhIkfRjq4D7Cip5bYOFZJCzmY/hvAyk58Zh7LN/4Ap8StMMuzpKBm4VNRgYSZg9tEJyTJohSPJ0wlugqHG2IXlc/K/k2/fbBeX8NhFHhX72wKiPXaDPLYyqrsSWvi6jW8xG42LWN7qahrPUJbK4c7I6Jd2xVLi4gg5sqmFVovM5PEMaRGqXYevGuUznAr7nP6gfDhb/0BNSqvt76cp396eWYm2Ac0Zpxr45qPq2jZmOcWaZQ7FpMFAzOeQoekZ9s9k8hkqkWVGmggHpb8eYpDP6D3KLmuOSVV6ED/+dj0o8h7lkXJjLC5WVWRfFhLJf+/Yg8upXvUOnHqZgI0sQmfRUNSy0o4Yql2AMEIPXlQ5gsn7YcTrSEbGUOO6M4X+79Q6IBZjgRtmkB4mdRMtjt5RfbR/nksZQTmYbbEPqzSeZ4lk7qAn90TDTGtlBnxMYtWOO7rt2D5aDrHL7iJbMzI2ucnNAgklRVzHq7V3Dy9w9pLg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(48200799018)(82310400026)(19092799006)(36860700016)(376014)(18002099003)(22082099003)(16102099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fRwO5kzt8qACNs42vKTNytQGF/zpxXd8Df6B02BwT7EZHtR9o6COHdlIoZNhUdQgpdDriFSNVy3lcGsqE8qw7ADTAJzkhhm4FCVQjKt5OcEmsyjSSgGBzThRu7ld5HioYeSIFwfgg/eu5361o5/vk+3jNz2Bs6BQvwuSs2RMxRTa+yrOzuUekPxVmshojzR8wfN7wC1W/6wb6EsiASuF8FqroDsljsaDLfsg2MeSXRfeG/gk6jHo1VhPJ6mC+ilnPTMdsrUgXkIirMA+p5GCfbY/TXhjkRniC1qghMhX6CiyLlLrzmH6MbHnJqhRU9+VZqOEFXrjFoykIgTnu2Xb3s7ocxvORtkNfCW+mo9EdDxJ4PrtN80Bp1BLy+psJKXczS97OwkDP6gqXo4oQQzjifmnQJccAE6db4eivASsAX+8p9w6a2CrCJDhHy12nyaV
X-Exchange-RoutingPolicyChecked:
	ucwF9wAkGPBoAY3Nsig8nKat6z70ltY5kYLnGmviUQgZCrprcl1SxLFYuyXiXlaoHzTauJKpgZD+6vJtHyFGoVmbHXH6+4DezNvDXAkSGbHZB7XN1DCkYUeQ0NxjZOT/Qu62lWF5qpstDjFbU7Evf4YvQv9KoISKwfGWXVlY9FdPE8W7648P9M99/4Q3df2405uQWELoUOtz/qrkgMVsluoXSiSuDezN8qMk5k1A1a1v95BHmnfZVnhKj/hexoBRgTUgGJGCABVAUK0OKhmH0up1UsrO67O4SACkq8RmOWOYGlOksJX0grLYlCSVMRsAbpMGhHN8UO4idrTLOxj+aw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q6NfSkRoCn0HvCOvg3kv/gbd12VGwzLJ2HsW4mAZyyuosXgUDn5w3CVdHdwE0C8Snec8qm22OElSKYjb27pEulVBmWkPWb7xaoqqcLkaZ67u3zMP6YMj/3neXbXZWcU4BX5u/pJ1vKLsbhGFfmwvSgvIthBve9TP6IGt6CtN46buoLM2XziYKKUvFaGUUET8KiunVZ8/BpmnJhF4TUW6r4u8wZrEkEB4oahP2iRXzhJyA1ulktsP0RfFnxmEEL1l7J0jHZV97qEc5dDPfjxu79Ts8H7dA3t3pcRCb4zDeTxeD46bnzaxgPTE+wIEgf6qoYqEZ2MtDMTblJscXqlQEvixBWeY+UtCVPuB11P1f5Aep3IqilJYOqz40me8/ETnajY5ZYo8BEX1cL/IF+z5IJ/j4pfjWpdXZ/2wOYAOBbMwuSHa7lySuwNTX3JmcK+nqLy8muXY3foDWEwf7O+XlMfXk4jVIX3n8XqVIiX8Sm/yPqEg7ozkHbgflf9Dj1zIWuUNym5eYag9UlrJwf6dAqFjrwzUxxnWYP3c967l/Ox+3fkyut0eK6Kf5q+F85GAc/8ZRFIk9e8NnjcVE8UQZ0yeNAwubVJCwH/Qieq9kiyBcQ/FiNe/Ob/m9739BRZ4Yh/1Nc1qgsx/PzRb65W4lw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:07.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8f06c1-ed60-48af-0fef-08de8b7f8d1f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9209
X-BESS-ID: 1774560915-105276-9821-3012-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.56.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGhpZAVgZQ0CQp1TDNwMDC0s
	zILNHAwMjcJDUx0cLAJMncxNTA0CxNqTYWALxch61BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan19-106.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

One might want to print debug out in background mode, which the command
line parameter does not easily allow. Or one might want to enable and
disable at run time.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_lowlevel.h | 12 ++++++++++++
 lib/fuse_lowlevel.c     |  5 +++++
 lib/fuse_versionscript  |  1 +
 3 files changed, 18 insertions(+)

diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d8626f85bdaf497534cd2835a589e30f1f4e2466..d85929e291a77de8caad7d6b3d9ac5b092ce0e62 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2441,6 +2441,18 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
  */
 void fuse_session_want_sync_init(struct fuse_session *se);
 
+/**
+ * Enable debug output
+ *
+ * This allows to enable debug output without a command line parameter and
+ * without the enforcement of the command line parameter to run in foreground.
+ * The daemon needs to handle either fuse_log output via stderr, or
+ * redirection to its own logs or via syslog.
+ *
+ * @param se the session
+ */
+void fuse_session_set_debug(struct fuse_session *se);
+
 /**
  * Check if the request is submitted through fuse-io-uring
  */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0dd10e0ed53508e4716703f2f82aa35ad853b247..4445e134a7ff5be508306f74db9d9c56e3582070 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5010,3 +5010,8 @@ void fuse_session_want_sync_init(struct fuse_session *se)
 		return;
 	se->want_sync_init = true;
 }
+
+void fuse_session_set_debug(struct fuse_session *se)
+{
+	se->debug = 1;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index dc6ed0135fb8d82937c756c3fb04a7fcb48fe1f4..3e1ea641a8be58ae9f68319873d3db4cbb902d3b 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -231,6 +231,7 @@ FUSE_3.19 {
 		fuse_daemonize_success;
 		fuse_daemonize_fail;
 		fuse_daemonize_is_active;
+		fuse_session_set_debug;
 } FUSE_3.18;
 
 # Local Variables:

-- 
2.43.0

