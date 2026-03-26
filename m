Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FD3A7F5D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560925; cv=fail; b=HYt72j/R/by3CwL2cGKF/r0TxA8zssF8MNr3iyyFozhBShO9/IBGyHsEsOJRKRytNmH1L+5QHk4TYdgOE0jqrae1SFOrqc6iGvlRhvt+r7mOr6CsAvInG4TtOPsn8qsq4yxSzPfUQlXe/GBoER/AkCuJtMY5R2kQwZ58sTPC6Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560925; c=relaxed/simple;
	bh=Qx8HFTzqpmXQBCxTPOMfCdMxSLvYvr6CbFxKf5OI/Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQfdBYWNncakEnWgy5zyOnP5vzX1fdJO9EYEb7R4Bev2/fy1B76Qz1T6o/7kWSvsWkXgg+VcWUQOjrZwyqBIIRmaTx/s7Hts/FgZ1e5QD8PysO0FZYkYvLh3y/9k40H1H8ySIdmL59k9Ws/LwAt+X3DLfX8VypwjCZ+KW086nY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=SBfmefao; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="SBfmefao"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021139.outbound.protection.outlook.com [40.93.194.139]) by mx-outbound45-1.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbShM+vbiik4v8YYQnm9NykfxKScQwGF0StP9Hc7oRdK3pkm68ua8iQ5mMGx1UE90413gkhSKcW6coXgxSn9iQPQsHEQXHIYew1qAsYv2u+bfxBncIs9tS+Lb0Kqcpk0ijy2LB0Pff/u9H7vuqyM9UjqRVLxiqnlCAd9Zj/FgiBAFg3AuR68MnxxH1QBD3NB0p05ntluer5c8gCeZuCVt1oXW8sqI38130LL7yevJyfHIJs/7E7t0LcuHqZo44ph9YsW6Yrix2TBOcIVVt1/NL2q2LKlL78xph+jyj1Q+VjNlD+ette/D+4Rx+9+NN8BVa/CHkQrkP0eHXelloiJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ/3POYpUl8+4qQ/UhXNlIZRK5q0mybg354zRyuktGA=;
 b=SZFHLtU6sf4GCj3FDeFYrSNTWmtJX77GlnuEb/MsZIgAQRtbnAzxsQy2LhZsY054wmzNBFIxneidWYwD+6E7K7anVMVoIXatajUdEaZjT45iJyT9QHfJ4AC+vl8Hvg6ygM7PjNvuVokccYWxtvt5MdAziHhOGxXbkXmYDxbGp0yrfBKTsLdJgjPE+dz9tQ1/+d+mlS0XxX9wn+ImMKgmnAVANeHpJXW43i//5EAhEIV+YmhDAe+aCibm0EcnDWZcjpapmEcr01JzTUNBTnRVNT+mliyt/Rn2sIW67V6/EYnhRKmQIjCdq8aNw5fkeWpb7qrzbiv4yv+UWxS8O8Z02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ/3POYpUl8+4qQ/UhXNlIZRK5q0mybg354zRyuktGA=;
 b=SBfmefaoLPC7G/gq4TxVSyfPeelnguhRTNlEqwhYmmWopf7hKBdsOTVi11Qp6zp/3BfecL8x8UNwbKjQl742Ju7FB+Co1a8s9qhIWzMHRGp7LcjF/uGNF4JI3i8kKpdf1k5wiIVAnuBnjB/BNnIRFdy9Dmn43b4xrGTT/mbmY3U=
Received: from SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::31)
 by SA1PR19MB5245.namprd19.prod.outlook.com (2603:10b6:806:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:34:57 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::48) by SA1P222CA0003.outlook.office365.com
 (2603:10b6:806:22c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:34:56 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 0C0DB8FD;
	Thu, 26 Mar 2026 21:34:55 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:37 +0100
Subject: [PATCH v2 04/25] Add a new daemonize API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-4-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=17814;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=Qx8HFTzqpmXQBCxTPOMfCdMxSLvYvr6CbFxKf5OI/Kc=;
 b=2XOo30yt/j3fa796ThL59EeakaB4ZJ0erICFxUSBcp43FFGH17MIeYRK6sH+djXI+Vvp5TINW
 I+SQ048NDTZB3pgjnWCDERtdhNGa+s6rZfHVr+2ou9oqA6oY3i8JTEy
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SA1PR19MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 353c1be3-196d-473c-2669-08de8b7f86ab
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700016|19092799006|48200799018|56012099003|22082099003|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Or+JvAVa4z16+QaaIAMK1nxno4MGHAs3r7tBYnEeRH8BkCjPeeh2JRS7rP/AwOzixwgM+UKYM+WSfFYUoWnFtEbj9YET7aIyi5As/Als+T1SKT/ukjb88y4zYFSYLgPM/coTqS8nygM9o35jvaS2FfIYZRouCfLj9r8K3A4SZTcDAswX4Ya72e/maVubg9LnbpruEiuTFA370tzSm3OwMpYB1VH38UmT1yNartahMFAlFy7vJAnwuQxFFKd+z4zmVSWqzMnhACzziAaCpTTEkEZQpYMgEdgELGRYQWUIiEskIydNouDeSNuR6b4eQWBQ37/KmAOKXGR7gufK5kCtMasn6Dq/yfAtdrEP00F8rHyedmCwlXEOADPaHGJvB6aMNjNYJWLRUTXLyUymPqLjRtDZzxLcxXhJe86VuZi305b7ErKX19tuTlTfAd5FihT5x6W1raHbOMPSbsO/ARdoPGMspxbKbmEcfwj6iTWkgSx/IkB8eyATRomMH95mmHXL/Dqc7OEwzZwMZp40cfUoULKQRNuhMbpt1e1Z2qRCrubYGVVpZKEgdH8gAMqqLZrvGlo2/0BNFApuyKEsnG7Dlhe13NVsxLrHYDICPbHJaETrsPAFPmXGVL8/Jf6bmcuC3t7kiVmlUJOzcrg6NdunxklnT/yYUBXHPq6B2EcQzo8dMMMH78xg30/kvnFgBkceA3Z/AwEcC91IYaQao0MgsoneK3ZL/rlvs92xLzJQ3Vr6gaz1iv/mzer+PmfBJJJP+lKw50H2oncUtfIg5SKWJw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700016)(19092799006)(48200799018)(56012099003)(22082099003)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sXb/p2jYD674sD/etg+DNitE9IGftAZFcyFX6FqstldE/wk9aZ03gzztkeaXKyb2SHnEBpMVulZJLZVCyN3DOQ621Skp+xOI+Xv13XwqadLq+E+Cp8faAGWL1s56mQ/kYgnvszXcm73DUlPYS8qPVg6qiUshSX7fgjV6mdqRod4O1XaZOkfuX0TUm+4bJW99wqGDc+hpVaLoPY/AljpoKYqhoLRN4HzTrpqt3EmLE1x3ZbotRquWT413WTZqQBgJF1o2C3k9ZOUuRA6xrYoJYjcT78toy1dDPioHvabHBZZkT8AIWr6qP+RDklNJQDvVZIidJw7JX/rjp2dH4mRRN4ozCu/PdzZZoS9N1a5D1HF1STPvZLOpsb5tZf8bime0ZlpDD16Q0xQ1IgVz6mBJkH/WXadvN+haW3hIcTT/tKNstZTKDMb0wrL4m7HwaB/p
X-Exchange-RoutingPolicyChecked:
	BY27xC79QuQTewShqOSGKanNXPABdCJezXbxAc+YfqRPo4VA+2RY1JP+bKxrntcE6xpefPuj9SUPgGcwRcv/HjUXdSE/m3sWLpOzRtGj7W4oIW753oOYZVE+wjcpvXQ/cL90CHqnDwhUcjQe2Nyt6/bi1HyVvcD5iDUNsYn8dvoC5yXGz7VCpgtiL5uaxvG4nzvugkOReDY6e9Z/eKeBEQ0pncP3ZYRZ4ImSzlGiDGiTleaQ9ARfOs/4fQZZR53JJ2IsLCYmjH2/hKpZgluVHxkjQ1j27LoxT4tkfGSY1/kIBeeQIV/aXeeroESo01SS/ZK1G/UoIbJjnakTH0ilEg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RAk7NEUP9gZX17MPXiOHuxphKut5s39TFQfBPjMzPjiXS2oKWaVfMJeP0FqKm00U9ylmp6v0LSxIYRPwkDjLProVWoQv5LEhf+ZVXWvxFgNy8aKia4ZNr/HUi0ukB2EX1+UssVjEbFnsIoZJ9iV07OoCYRFMF/563oRYaK3V7Kr3IL5E7PQaKnHpMxvbs52gVssGhMBT/2QA0Q4pLc2ePmsTgsi2zbV9fDNDGQA62IHCeWvXxw4BPRatUHSAEWyVMj+/JkvU6SW1Z61d8UwGFpkozMJgZ8fgr0MLpw3o9JQfk109TQJKINAB1adNJ/o0t2/JxE1eOYkWDAd6uY6ORwgVfIAjMBgz4U+cJYnP5siJREBwUsWN5l+s7xiawm9RPRD5hctK2FanFJ/3Gy5VuwZ2Qkf5NmXtLOzz/9yTt2bv/3Iptpx+m1Id8D+QUoVjlRvS8B7DcufKH59WJOEb4H6tRHTxgVFNtsasH3KpwXC/RlliFEZIhcZNLKNi9rMHEbgJ0Hw3YAi7HlJ1Zl4juahJrc5TaL+WnJBcNYmua6pSjwmzBc0c1gX2f4LYMmswnfhpXTCuI1bHoIbFiWmJt03TiFqVa4y7pDKYZnyoSH4ci5piMz36HL4CJSLF7Xqlt9LTiBnz9OFQKIOo1s1xAQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:56.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353c1be3-196d-473c-2669-08de8b7f86ab
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5245
X-BESS-ID: 1774560902-111521-4064-1327-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.93.194.139
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmhhaGQGYGUNTE3MQszTjZxM
	TQyCgpJSUp2cDYwsDcMDHN2DzJOMU4Sak2FgBdOkPSQgAAAA==
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan13-90.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Existing example/ file systems do the fuse_daemonize() after
fuse_session_mount() - i.e. after the mount point is already
established. Though, these example/ daemons do not start
extra threads and do not need network initialization either.

fuse_daemonize() also does not allow to return notification
from the forked child to the parent.

Complex fuse file system daemons often want the order of
1) fork - parent watches, child does the work

Child:
    2) start extra threads and system initialization (like network
       connection and RDMA memory registration) from the fork child.
    3) Start the fuse session after everything else succeeded

Parent:
    Report child initialization success or failure

A new API is introduced to overcome the limitations of
fuse_daemonize()

fuse_daemonize_start() - fork, but foreground process does not
terminate yet and watches the background.

fuse_daemonize_success() / fuse_daemonize_fail() - background
daemon signals to the foreground process success or failure.

fuse_daemonize_active() - helper function for the high level
interface, which needs to handle both APIs. fuse_daemonize()
is called within fuse_main(), which now needs to know if the caller
actually already used the new API itself.

The object 'struct fuse_daemonize *' is allocated dynamically
and stored a global variable in fuse_daemonize.c, because
- high level fuse_main_real_versioned() needs to know
if already daemonized
- high level daemons do not have access to struct fuse_session
- FUSE_SYNC_INIT in later commits can only be done if the new
API (or a file system internal) daemonization is used.

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 example/passthrough_hp.cc   |  18 ++-
 include/fuse_daemonize.h    |  74 +++++++++++
 include/meson.build         |   3 +-
 lib/fuse_daemonize.c        | 292 ++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_i.h                |   4 +-
 lib/fuse_lowlevel.c         |   3 +
 lib/fuse_versionscript      |   4 +
 lib/helper.c                |  13 +-
 lib/meson.build             |   3 +-
 test/test_want_conversion.c |   1 +
 10 files changed, 404 insertions(+), 11 deletions(-)

diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
index 9f795c5546ee8312e1393c5b8fcebfd77724fb49..bad435077697e8832cf5a5195c17f2f873f2dfe6 100644
--- a/example/passthrough_hp.cc
+++ b/example/passthrough_hp.cc
@@ -55,6 +55,7 @@
 #include <errno.h>
 #include <ftw.h>
 #include <fuse_lowlevel.h>
+#include <fuse_daemonize.h>
 #include <inttypes.h>
 #include <string.h>
 #include <sys/file.h>
@@ -243,6 +244,9 @@ static void sfs_init(void *userdata, fuse_conn_info *conn)
 
 	/* Try a large IO by default */
 	conn->max_write = 4 * 1024 * 1024;
+
+	/* Signal successful init to parent */
+	fuse_daemonize_success();
 }
 
 static void sfs_getattr(fuse_req_t req, fuse_ino_t ino, fuse_file_info *fi)
@@ -1580,6 +1584,7 @@ int main(int argc, char *argv[])
 {
 	struct fuse_loop_config *loop_config = NULL;
 	void *teardown_watchog = NULL;
+	unsigned int daemon_flags = 0;
 
 	// Parse command line options
 	auto options{ parse_options(argc, argv) };
@@ -1638,10 +1643,14 @@ int main(int argc, char *argv[])
 
 	fuse_loop_cfg_set_clone_fd(loop_config, fs.clone_fd);
 
-	if (fuse_session_mount(se, argv[2]) != 0)
+	/* Start daemonization before mount so parent can report mount failure */
+	if (fs.foreground)
+		daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
+	if (fuse_daemonize_start(daemon_flags) != 0)
 		goto err_out3;
 
-	fuse_daemonize(fs.foreground);
+	if (fuse_session_mount(se, argv[2]) != 0)
+		goto err_out4;
 
 	if (!fs.foreground)
 		fuse_log_enable_syslog("passthrough-hp", LOG_PID | LOG_CONS,
@@ -1650,7 +1659,7 @@ int main(int argc, char *argv[])
 	teardown_watchog = fuse_session_start_teardown_watchdog(
 		se, fs.root.stop_timeout_secs, NULL, NULL);
 	if (teardown_watchog == NULL)
-		goto err_out3;
+		goto err_out4;
 
 	if (options.count("single"))
 		ret = fuse_session_loop(se);
@@ -1659,6 +1668,9 @@ int main(int argc, char *argv[])
 
 	fuse_session_unmount(se);
 
+err_out4:
+	if (fuse_daemonize_is_active())
+		fuse_daemonize_fail(ret);
 err_out3:
 	fuse_remove_signal_handlers(se);
 err_out2:
diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
new file mode 100644
index 0000000000000000000000000000000000000000..c35dddd668b399535c53b44ab06c65fc0b3ddefa
--- /dev/null
+++ b/include/fuse_daemonize.h
@@ -0,0 +1,74 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ *
+ */
+
+#ifndef FUSE_DAEMONIZE_H_
+#define FUSE_DAEMONIZE_H_
+
+#include <stdint.h>
+#include <stdbool.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Flags for fuse_daemonize_start()
+ */
+#define FUSE_DAEMONIZE_NO_CHDIR      (1 << 0)
+#define FUSE_DAEMONIZE_NO_BACKGROUND (1 << 1)
+
+/**
+ * Start daemonization process.
+ *
+ * Unless FUSE_DAEMONIZE_NO_BACKGROUND is set, this forks the process.
+ * The parent waits for a signal from the child via fuse_daemonize_success()
+ * or fuse_daemonize_fail().
+ * The child returns from this call and continues setup.
+ *
+ * Unless FUSE_DAEMONIZE_NO_CHDIR is set, changes directory to "/".
+ *
+ * Must be called before fuse_session_mount().
+ *
+ * @param flags combination of FUSE_DAEMONIZE_* flags
+ * @return 0 on success, negative errno on error
+ */
+int fuse_daemonize_start(unsigned int flags);
+
+/**
+ * Signal daemonization success to parent and cleanup.
+ */
+void fuse_daemonize_success(void);
+
+/**
+ * Signal daemonization failure to parent and cleanup.
+ *
+ * @param err error code to pass to parent
+ */
+void fuse_daemonize_fail(int err);
+
+/**
+ * Check if daemonization is active and waiting for signal.
+ *
+ * @return true if active, false otherwise
+ */
+bool fuse_daemonize_is_active(void);
+
+/**
+ * Set mounted flag.
+ *
+ * Called from fuse_session_mount().
+ */
+void fuse_daemonize_set_mounted(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* FUSE_DAEMONIZE_H_ */
+
diff --git a/include/meson.build b/include/meson.build
index bf671977a5a6a9142bd67aceabd8a919e3d968d0..cfbaf52ac5d84369e92948c631e2fcfdd04ac2eb 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -1,4 +1,5 @@
 libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
-	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
+	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h',
+	            'fuse_daemonize.h' ]
 
 install_headers(libfuse_headers, subdir: 'fuse3')
diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
new file mode 100644
index 0000000000000000000000000000000000000000..865acad7db56dbe5ed8a1bee52e7353627e89b75
--- /dev/null
+++ b/lib/fuse_daemonize.c
@@ -0,0 +1,292 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
+
+#define _GNU_SOURCE
+
+#include "fuse_daemonize.h"
+
+#include <fcntl.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <errno.h>
+
+/**
+ * Status values for fuse_daemonize_success() and fuse_daemonize_fail()
+ */
+#define FUSE_DAEMONIZE_SUCCESS 0
+#define FUSE_DAEMONIZE_FAILURE 1
+
+/* Private/internal data  */
+struct fuse_daemonize {
+	unsigned int flags;
+	int signal_pipe_wr;	/* write end for signaling parent */
+	int death_pipe_rd;	/* read end, POLLHUP when parent dies */
+	int stop_pipe_rd;	/* read end for stop signal */
+	int stop_pipe_wr;	/* write end for stop signal */
+	pthread_t watcher;
+	bool watcher_started;
+	_Atomic bool active;
+	_Atomic bool daemonized;
+	_Atomic bool mounted;
+};
+
+/* Global daemonization object pointer */
+static struct fuse_daemonize daemonize = {
+	.signal_pipe_wr = -1,
+	.death_pipe_rd = -1,
+	.stop_pipe_rd = -1,
+	.stop_pipe_wr = -1,
+};
+
+/* Watcher thread: polls for parent death or stop signal */
+static void *parent_watcher_thread(void *arg)
+{
+	struct fuse_daemonize *di = arg;
+	struct pollfd pfd[2];
+
+	pfd[0].fd = di->death_pipe_rd;
+	pfd[0].events = POLLIN;
+	pfd[1].fd = di->stop_pipe_rd;
+	pfd[1].events = POLLIN;
+
+	while (1) {
+		int rc = poll(pfd, 2, -1);
+
+		if (rc < 0)
+			continue;
+
+		/* Parent died - death pipe write end closed */
+		if (pfd[0].revents & (POLLHUP | POLLERR))
+			_exit(EXIT_FAILURE);
+
+		/* Stop signal received */
+		if (pfd[1].revents & POLLIN)
+			break;
+	}
+	return NULL;
+}
+
+static int start_parent_watcher(struct fuse_daemonize *daemonize)
+{
+	int rc;
+
+	rc = pthread_create(&daemonize->watcher, NULL, parent_watcher_thread,
+			    daemonize);
+	if (rc != 0) {
+		fprintf(stderr, "fuse_daemonize: pthread_create: %s\n",
+			strerror(rc));
+		return -rc;
+	}
+	daemonize->watcher_started = true;
+	return 0;
+}
+
+static void stop_parent_watcher(struct fuse_daemonize *daemonize)
+{
+	char byte = 0;
+
+	if (daemonize && daemonize->watcher_started) {
+		/* Signal watcher to stop */
+		if (write(daemonize->stop_pipe_wr, &byte, 1) != 1)
+			perror("fuse_daemonize: stop write");
+		pthread_join(daemonize->watcher, NULL);
+		daemonize->watcher_started = false;
+	}
+}
+
+static int daemonize_child(struct fuse_daemonize *daemonize)
+{
+	int stop_pipe[2], err = 0;
+
+	if (pipe(stop_pipe) == -1) {
+		err = -errno;
+		perror("fuse_daemonize_start: stop pipe");
+		return err;
+	}
+	daemonize->stop_pipe_rd = stop_pipe[0];
+	daemonize->stop_pipe_wr = stop_pipe[1];
+
+	if (setsid() == -1) {
+		err = -errno;
+		perror("fuse_daemonize_start: setsid");
+		goto err_close_stop;
+	}
+
+	/* Close stdin immediately */
+	int nullfd = open("/dev/null", O_RDWR, 0);
+
+	if (nullfd != -1) {
+		(void)dup2(nullfd, 0);
+		if (nullfd > 0)
+			close(nullfd);
+	}
+
+	/* Start watcher thread to detect parent death */
+	err = start_parent_watcher(daemonize);
+	if (err)
+		goto err_close_stop;
+
+	daemonize->daemonized = true;
+	return 0;
+
+err_close_stop:
+	close(daemonize->stop_pipe_rd);
+	close(daemonize->stop_pipe_wr);
+	return err;
+}
+
+/* Fork and daemonize. Returns 0 in child, never returns in parent. */
+static int do_daemonize(struct fuse_daemonize *daemonize)
+{
+	int signal_pipe[2], death_pipe[2], err;
+
+	if (pipe(signal_pipe) == -1) {
+		err = -errno;
+		perror("fuse_daemonize_start: signal pipe");
+		return err;
+	}
+
+	if (pipe(death_pipe) == -1) {
+		err = -errno;
+		perror("fuse_daemonize_start: death pipe");
+		close(signal_pipe[0]);
+		close(signal_pipe[1]);
+		return err;
+	}
+
+	switch (fork()) {
+	case -1:
+		err = -errno;
+		perror("fuse_daemonize_start: fork");
+		close(signal_pipe[0]);
+		close(signal_pipe[1]);
+		close(death_pipe[0]);
+		close(death_pipe[1]);
+		return err;
+
+	case 0:
+		/* Child: signal write end, death read end */
+		close(signal_pipe[0]);
+		close(death_pipe[1]);
+		daemonize->signal_pipe_wr = signal_pipe[1];
+		daemonize->death_pipe_rd = death_pipe[0];
+		return daemonize_child(daemonize);
+
+	default: {
+		/* Parent: signal read end, death write end (kept open) */
+		int status;
+		ssize_t res;
+
+		close(signal_pipe[1]);
+		close(death_pipe[0]);
+
+		res = read(signal_pipe[0], &status, sizeof(status));
+		close(signal_pipe[0]);
+		close(death_pipe[1]);
+
+		if (res != sizeof(status))
+			_exit(EXIT_FAILURE);
+		_exit(status);
+	}
+	}
+}
+
+int fuse_daemonize_start(unsigned int flags)
+{
+	struct fuse_daemonize *dm = &daemonize;
+	int err = 0;
+
+	dm->flags = flags;
+	dm->signal_pipe_wr = -1;
+	dm->death_pipe_rd = -1;
+	dm->stop_pipe_rd = -1;
+	dm->stop_pipe_wr = -1;
+	dm->active = true;
+
+	if (!(flags & FUSE_DAEMONIZE_NO_CHDIR))
+		(void)chdir("/");
+
+	if (!(flags & FUSE_DAEMONIZE_NO_BACKGROUND))
+		err = do_daemonize(dm);
+
+	return err;
+}
+
+static void close_if_valid(int *fd)
+{
+	if (*fd != -1) {
+		close(*fd);
+		*fd = -1;
+	}
+}
+
+static void fuse_daemonize_signal(int status)
+{
+	struct fuse_daemonize *dm = &daemonize;
+	int rc;
+
+	/* Warn because there might be races */
+	if (status == FUSE_DAEMONIZE_SUCCESS && !dm->mounted)
+		fprintf(stderr, "fuse daemonize success without being mounted\n");
+
+	dm->active = false;
+
+	/* Stop watcher before signaling - parent will exit after this */
+	stop_parent_watcher(dm);
+
+	/* Signal status to parent */
+	if (dm->signal_pipe_wr != -1) {
+		rc = write(dm->signal_pipe_wr, &status, sizeof(status));
+		if (rc != sizeof(status))
+			fprintf(stderr, "%s: write failed\n", __func__);
+	}
+
+	/* Redirect stdout/stderr to /dev/null on success */
+	if (status == FUSE_DAEMONIZE_SUCCESS && dm->daemonized) {
+		int nullfd = open("/dev/null", O_RDWR, 0);
+
+		if (nullfd != -1) {
+			(void)dup2(nullfd, 1);
+			(void)dup2(nullfd, 2);
+			if (nullfd > 2)
+				close(nullfd);
+		}
+	}
+
+	close_if_valid(&dm->signal_pipe_wr);
+	close_if_valid(&dm->death_pipe_rd);
+	close_if_valid(&dm->stop_pipe_rd);
+	close_if_valid(&dm->stop_pipe_wr);
+}
+
+void fuse_daemonize_success(void)
+{
+	fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
+}
+
+void fuse_daemonize_fail(int err)
+{
+	fuse_daemonize_signal(err);
+}
+
+bool fuse_daemonize_is_active(void)
+{
+	return daemonize.daemonized || daemonize.active;
+}
+
+void fuse_daemonize_set_mounted(void)
+{
+	daemonize.mounted = true;
+}
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 65d2f68f7f30918a3c3ee4d473796cb013428a8f..9e3c5dc5021e210a2778e975a37ab609af324010 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -17,7 +17,6 @@
 #include <semaphore.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <errno.h>
 #include <stdatomic.h>
 
 #define MIN(a, b) \
@@ -110,6 +109,9 @@ struct fuse_session {
 	/* true if reading requests from /dev/fuse are handled internally */
 	bool buf_reallocable;
 
+	/* synchronous FUSE_INIT support */
+	bool want_sync_init;
+
 	/* io_uring */
 	struct fuse_session_uring uring;
 
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 3234f0ce3b246a4c2c40dc0757177de91b6608b2..ccff6a768f0b8c32469abda9405ff29623f3fff7 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -19,6 +19,7 @@
 #include "mount_util.h"
 #include "util.h"
 #include "fuse_uring_i.h"
+#include "fuse_daemonize.h"
 
 #include <pthread.h>
 #include <stdatomic.h>
@@ -4451,6 +4452,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 	/* Save mountpoint */
 	se->mountpoint = mountpoint;
 
+	fuse_daemonize_set_mounted();
+
 	return 0;
 
 error_out:
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index cce09610316f4b0b1d6836dd0e63686342b70037..dc6ed0135fb8d82937c756c3fb04a7fcb48fe1f4 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -227,6 +227,10 @@ FUSE_3.19 {
 		fuse_session_start_teardown_watchdog;
 		fuse_session_stop_teardown_watchdog;
 		fuse_lowlevel_notify_prune;
+		fuse_daemonize_start;
+		fuse_daemonize_success;
+		fuse_daemonize_fail;
+		fuse_daemonize_is_active;
 } FUSE_3.18;
 
 # Local Variables:
diff --git a/lib/helper.c b/lib/helper.c
index 5c13b93a473181f027eba01e0bfefd78875ede3e..35285be19aa0cc390a432d16701b9eefa16ec12a 100644
--- a/lib/helper.c
+++ b/lib/helper.c
@@ -15,6 +15,7 @@
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "fuse_lowlevel.h"
+#include "fuse_daemonize.h"
 #include "mount_util.h"
 
 #include <stdio.h>
@@ -352,17 +353,19 @@ int fuse_main_real_versioned(int argc, char *argv[],
 		goto out1;
 	}
 
+	struct fuse_session *se = fuse_get_session(fuse);
 	if (fuse_mount(fuse,opts.mountpoint) != 0) {
 		res = 4;
 		goto out2;
 	}
 
-	if (fuse_daemonize(opts.foreground) != 0) {
-		res = 5;
-		goto out3;
+	if (!fuse_daemonize_is_active()) {
+		/* Avoid daemonizing if we are already daemonized by the newer API */
+		if (fuse_daemonize(opts.foreground) != 0) {
+			res = 5;
+			goto out3;
+		}
 	}
-
-	struct fuse_session *se = fuse_get_session(fuse);
 	if (fuse_set_signal_handlers(se) != 0) {
 		res = 6;
 		goto out3;
diff --git a/lib/meson.build b/lib/meson.build
index fcd95741c9d3748fa01d9ec52b417aca66745f26..5bd449ebffe7c9229df904d647d990c6c47f80b5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -2,7 +2,8 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
                    'fuse_lowlevel.c', 'fuse_misc.h', 'fuse_opt.c',
                    'fuse_signals.c', 'buffer.c', 'cuse_lowlevel.c',
                    'helper.c', 'modules/subdir.c', 'mount_util.c',
-                   'fuse_log.c', 'compat.c', 'util.c', 'util.h' ]
+                   'fuse_log.c', 'compat.c', 'util.c', 'util.h',
+                   'fuse_daemonize.c' ]
 
 if host_machine.system().startswith('linux')
    libfuse_sources += [ 'mount.c' ]
diff --git a/test/test_want_conversion.c b/test/test_want_conversion.c
index db731edbfe1be8230ae16b422f798603b4a3bb82..48e6dd2dc6084425a0462bba000563c6083160be 100644
--- a/test/test_want_conversion.c
+++ b/test/test_want_conversion.c
@@ -8,6 +8,7 @@
 #include <inttypes.h>
 #include <stdbool.h>
 #include <err.h>
+#include <errno.h>
 
 static void print_conn_info(const char *prefix, struct fuse_conn_info *conn)
 {

-- 
2.43.0

