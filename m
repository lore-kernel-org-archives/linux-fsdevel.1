Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C2259CB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289963; cv=fail; b=ZxWxEUtgoUxm6bBc5owCs+qqgXbt5iT6dqoagmcbcN9gme9nmqW5iSNJ8HIqOjJBas8sEgg7l58M60W/VYPwLYoTb8b0QLSvuHxtCprMQ6fW85BjlMAtgTr79eXtLW5je4ZDjYvF+96OUiKfIkqulaTuaX850L5tvvRLrWJx1ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289963; c=relaxed/simple;
	bh=NTl52ng6JXiuZsLGwhe3GnFFijHwtwbpvxiaOF2oeXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucTLnHs+KaWrQZ8Sis3V8U9IUUSeW0ez1KxTay6FHFMjvMjF1fvayUgcFO6jAc88PfzAW4di+i+4eyHhu0kBw5wqEkv0ONhMrMmz1irL4v9fvMm8N7YP2JCyUqSofys6sjntDsDh5uRZoSzUWp9HUEAsh4t/VaqjlFpm7q3l9+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=mgIf6WYS; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="mgIf6WYS"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022111.outbound.protection.outlook.com [52.101.48.111]) by mx-outbound18-254.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaSKV3XhmbjM+EAZCxwTXbnr9uq3mI88ADKNYoGh3kuxR4tGJIDx1GpTd/o1BwPpWIoUDMTBozZ0dHafI64/U4wWrM5J3aGIeG7cL0Q/m0kvE3SjU/tQ9cFULjgZxvBqTpKZqZLX5WDWgmfp13yk1Zz/3fJhLdLpzb/KEIPnPxQArOXJRd5HQYV6J715ErK3z8eQg10Yz2YDlcHmEb/WVMZliClrCUjG7zu0R9XzNpJlLwHtvMWqFlD+/EarFmxTtV8GexK8+PEj6nTemqH97Q4YzB20ubbY7BK511w8wJKP8MeEG2qThx9xkQmqAU9tgzozdjUDiCbQrTIqaHPxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zs0N3Am0aOq28bR8H9KdUO6bhWorcubZkqxbyW/1ck=;
 b=c+p4v0draBE/a3cjk92PlRou12bcw+hxzITWx/LzEFoungMbKMCMbkWekZSzgdWcxWCs7RCg4lugRFt9uCXYBJsBvGVkhYAMBQSAwHChwoeiEN9fBu+9SJFsYmEKnbXIunJN/qcaez4x3zKdByK/ufR/bv6Tr+JVK6QgYJxQqZQ2lwvh6NXpKYvC9AqDLbzpGM/YKsTxo9VFqDZ2TcXc1fPb/QFupnaMi96xLMjdyz47GYrqqZbQHpHArWeL5+SW4vZHhtAwRsOrxXoyWcWsXnrwy5Sn0Diw063qNpjiXg//m4SFBiHf9h+svblrsTZhOoKALFYQjxqx66va7htnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zs0N3Am0aOq28bR8H9KdUO6bhWorcubZkqxbyW/1ck=;
 b=mgIf6WYSV45kxNyvTE2gaA/1BAg7U2+3KCNkq4ET52ljbYqMwDc8BKeOH5vbdr5IYCFsvvgfoLGd3J+M2jnHCvwaE5U5yKi9bmcNKHXFIFqC9OMdfpVBb3CFcS8CcyGof4QqLbfiHhrmzzKTFVYs59iU5CV9oLARSbr3Wab/nSw=
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by LV2PR19MB997329.namprd19.prod.outlook.com (2603:10b6:408:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:23 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::2c) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0
 via Frontend Transport; Mon, 23 Mar 2026 17:45:23 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EB29DB7;
	Mon, 23 Mar 2026 17:45:19 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:12 +0100
Subject: [PATCH 17/19] Make fusermount work bidirectional for sync init
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuse-init-before-mount-v1-17-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=25863;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=X06scZ4rX7r5KnWDHadCrrWOmvgEFGBHQs8mwva02xc=;
 b=Bn/jxMSzpa54ju2eUAXXQWlyhU8HOoqG2DNiD1BbxHnQairbcKRDxCMUJh7g7sDr26AWZpcvB
 G8BAo3e8ZfDAezQZbKR4LWfTlCew9apHGIxmYuAQiCUJSRiMg9UvQwm
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|LV2PR19MB997329:EE_
X-MS-Office365-Filtering-Correlation-Id: e74e235b-fb30-4d53-c898-08de8903f5e1
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|36860700016|61400799027|376014|48200799018|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	gvtB/dGLAjSwkQbkhLHf0mZV4YTAPG8DllE1KkctqbbJZjwSnLOkKTLGQr5/urqOtnElCORH4v2vThgTOsO7DTwaLqejOnjctPsoG9ZPv18B59t8hadTgYF/c6nWq8GGs8cd63pQEtZrUujyRxa4S1OqFK4eQa/ndyqwFu3Zfw4gwX5Lrprj64rKlCOmh+BkQynL2Wi8ozeweT0oLql8YBL2h6geJEqWGCQn1d/0ONE9gfZQlIv9c435FWHfELZhC1vOEuP1d6L7BAY7RQRNxYiiahDAJedqPFP30WEzPizkGf5Fwts4nXazwM29TwD1ngEHySG2OIQKS7eNoC3Xe7Y4CV+aFC58ik76LaXVmQqbqXBvLyMVRqCKN8Jl/cdgwxGo4NXGcSIrtSuBrDDAWotmcZH0IbGg+vRHjIShOU4IHUa54N0rfPruQz2zIjepurmkhCCaLFVDGjE18t+bwbIafA8bWJu+Ol4ojdeELvSzdtwOtElCnnD/o3kl3Rm0Sn80EuSwJDZ/GLq9yWmoo/uJRgn6vf6us2quMaz3Fz5+3bvcgui08xPowhquG6DvPkwoBxRGh+PLzathi5bXLt1+mKM9oKUm4l4+/nRtWtI/mWyCVHAp8f7opXEOQSBDid7HbEKGn11qe3ThtWxzst7gQW1pRtMdjqwMqu/5zadH8TGkhj7aGaSPxtlc+WrSB4X+CuvtEcCKDAjYTu7+hBBqst5eq0eAXdsc/yg79vlv5FlHZAMmx6ZcuhGwhB5l
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(36860700016)(61400799027)(376014)(48200799018)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b/AadaVTmTBqw39y1gv2Ha8iBhMDcvo9nhLTl8jMW6lTNMi807ir6gC301NepKJDVxECJyzQnywu5ljEg7VHuJ8RYHNPJXAgiPABkWdpHl5PXCXwTKdpmmssrIYUnS1gPgAtsG7H6emdkS4P83vtw7PTCKWePhgnipGXICAfU1NVE+xTwO6eRskzB2hk9FMk1M+Gapn/AJeqTY72S4xXWNJtj57engV7ZLYhZjuviUOoBFreyLHBjpIe7/hfy4WR7F1CSWWya3eKVzI23vxlSEnxaruOdidIA/tbohsRJW2MTsIANnb2av0xT9qDq0F3WKDQMNb1sRtxPj1RyNCkT4OPeA3++Le1V4xZmDbJw3mJC7HemYs8R/+XYPfzYjScCjCZlMnIrmEc6DSlMZNdVHxcGMEgPXuVyMKqzexND4sJE7oVZtUHUekx8+346GVw
X-Exchange-RoutingPolicyChecked:
	KJY9RG+qLkXe/VaGCFsgMUUmkVLK4P1KSO0JjbR+LFjQBFV820R4bVc9jAqn/PxiMAtlE7rWAFVgUO33rj3UogHZzN9W33jSP1o+RvW6aWnAFatHeudew01mHRmKyBbT3CYCnNTyTOMIVM3oFRkm6is/whDMe2HHI1GyHvw8lXZfY1QY8dgO/HQTgxhfDHQNtvffgnDqFbslajIxJCSPnqyr1mZxy9ObUrkayB1ifGgHGLjcK/aef1gKKRGWjyi0xgLfE/P1sA7WdDVdh2lqJyxJFpAHVVX2FXDZJTDLJ27Nm0APOwnMT5ZxCNMIEW85Zg+k6TZc544oBPsXtamFUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5P8zhF3HVbYdTSwCocvN5CfRAdN4wmPwV+EiZCxLvJSBjBUH8v1H0DPewH4fZv59hHmMp0H1zimDVOQEYV7SKgib87WN1LyohKCiw2I+CfVqrgxI0DwpNo8c7GK9xFF/Frz6kDxEML1+1zMaZaLMmAYHCfUs8L33ak9w9fN1DErKZSoZ90o1RkjlLu8uIN3Ao45oS6jMznzyOouomEdjUNJ2Vq1BlmUgaN7Igw+rXd/cpjoeSKhqwo+N7ZDwuWfpJbKD2vJB+j6a/smK2VE685enJXYszsOyfZ+JTOW7g21GQvA5f13smmi3AmhnOt9H2B2Fh7HTQJAYuew34g1cf12Hu4yaqxvqSKnUmaxqYtj9uPptetssrsgoHD4HY4jcoRcE6YedDF7NiDHPCts1WOoDOldNVfFhnxwd8PhccD+AS0O/ZqXZZUJi3ktlJatwTbnldipabiRq6i6+FSqoincRqL8FQcPf7M56SOwxFCdv+bnVv7F/wPux+jl1G2y0J3SMBMy7PEIbOtY5Cuak5vg1M9ztcaDr2JN7nnu47W56tHA9cf1yQfc4gjQ5AJ5hJOonOI70EIu+myTSpgfE6RZLhLybJqDCYRSd0BWgtFtCIvfUCi5PjLTj3fSQettyDye1S+YAiNOy3lN/qfaFJA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:23.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74e235b-fb30-4d53-c898-08de8903f5e1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB997329
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289951-104862-11443-1849-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.48.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkamhsaWQGYGUNTczMTYwsQy2c
	gs2SjV1DI51dTYwMTczMDSyMzUGCioVBsLACyDdRlCAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan16-208.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 doc/README.fusermount | 359 ++++++++++++++++++++++++++++++++++++++++++++++++++
 util/fusermount.c     | 317 ++++++++++++++++++++++++++++++++++++++++++--
 util/meson.build      |   2 +-
 3 files changed, 665 insertions(+), 13 deletions(-)

diff --git a/doc/README.fusermount b/doc/README.fusermount
new file mode 100644
index 0000000000000000000000000000000000000000..54a3bac4f58964a4ed312d6f6bc15606fed1e647
--- /dev/null
+++ b/doc/README.fusermount
@@ -0,0 +1,359 @@
+Synchronous FUSE_INIT Protocol
+================================
+
+Overview
+--------
+
+The sync-init feature enables the FUSE library to start worker threads and
+perform initialization ioctl calls BEFORE the actual mount() syscall happens.
+This is required for the kernel's synchronous FUSE_INIT feature, where the
+mount() syscall blocks until the FUSE daemon processes the INIT request.
+
+Without this feature, there would be a deadlock:
+- mount() blocks waiting for INIT response
+- Worker threads can't start because mount() hasn't returned
+- INIT request can't be processed because worker threads aren't running
+
+
+Protocol Flow
+-------------
+
+Traditional mount flow:
+  1. Library calls fusermount3
+  2. fusermount3 opens /dev/fuse
+  3. fusermount3 performs mount() syscall
+  4. fusermount3 sends fd to library
+  5. Library starts worker threads
+  6. Worker threads process FUSE requests
+
+Sync-init mount flow:
+  1. Library calls fusermount3 with --sync-init flag
+  2. fusermount3 opens /dev/fuse
+  3. fusermount3 sends fd to library
+  4. Library receives fd
+  5. Library performs FUSE_DEV_IOC_SYNC_INIT ioctl
+  6. Library starts worker threads
+  7. Library sends "proceed" signal to fusermount3
+  8. fusermount3 performs mount() syscall (blocks until INIT completes)
+  9. Worker threads process INIT request
+  10. mount() syscall completes
+  11. fusermount3 exits
+
+
+Implementation Details
+----------------------
+
+Bidirectional Communication:
+  - Uses the existing unix socket (_FUSE_COMMFD environment variable)
+  - Simple 1-byte protocol for signaling
+  - Library signals fusermount3 when ready to proceed with mount
+
+fusermount3 Changes:
+  - New --sync-init command-line option
+  - Split mount operation into two phases:
+    * mount_fuse_prepare(): Opens device, prepares parameters
+    * mount_fuse_finish_fsmount(): Performs actual mount() syscall
+  - wait_for_signal(): Waits for library to signal readiness
+  - struct mount_context: Preserves state between phases
+
+Library Changes:
+  - fuse_session_mount_new_api(): Uses new protocol when available
+  - Sends "proceed" signal after worker thread is ready
+  - Handles both old and new mount protocols for compatibility
+
+
+Backward Compatibility
+----------------------
+
+The implementation maintains full backward compatibility:
+  - Old library + new fusermount3: Works (uses traditional flow)
+  - New library + old fusermount3: Falls back to traditional flow
+  - New library + new fusermount3: Uses sync-init flow when appropriate
+
+
+Error Handling
+--------------
+
+If any step fails during the sync-init flow:
+  - fusermount3 closes the fd and exits with error
+  - Library detects failure and cleans up
+  - No mount is left in inconsistent state
+
+Connection closure:
+  - If library closes socket before signaling, fusermount3 detects and exits
+  - If fusermount3 crashes, library detects closed socket
+
+
+Security Considerations
+-----------------------
+
+The sync-init protocol does not introduce new security concerns:
+  - Uses the same privilege separation as traditional mount
+  - Socket communication is already established and trusted
+  - No new privileged operations are added
+  - File descriptor passing uses existing SCM_RIGHTS mechanism
+
+
+Performance Impact
+------------------
+
+Minimal performance impact:
+  - One additional recv() call in fusermount3
+  - One additional send() call in library
+  - Total overhead: ~2 context switches
+  - Only affects mount time, not runtime performance
+
+
+Future Enhancements
+-------------------
+
+Potential improvements:
+  - Extended protocol for more complex initialization sequences
+  - Support for multiple worker threads coordination
+  - Enhanced error reporting through the socket
+  - Timeout mechanisms for detecting hung initialization
+
+
+ASCII Workflow Diagrams
+========================
+
+1. Traditional Mount Flow (without --sync-init, async INIT)
+------------------------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [mount() syscall]           |
+   |                           |------ mount -------->|
+   |                           |<----- success ------ | [mount returns immediately]
+   |                           |                      | [INIT queued in kernel]
+   |                      [send_fd(fd)]               |
+   |<------- fd --------------|                      |
+   |                           |                      |
+   |                      [fusermount3 exits]         |
+   |                                                  |
+   |  [start worker thread]                          |
+   |  [worker reads /dev/fuse]                       |
+   |---------------------------------------- read -->|
+   |<--------------------------------------- INIT ---| [dequeued from kernel]
+   |                                                  |
+   | OK: INIT was queued, worker reads it later      |
+   |     Works fine for async INIT                   |
+
+
+1b. Problem: Synchronous INIT without --sync-init
+--------------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [mount() syscall]           |
+   |                           |------ mount -------->|
+   |                           |                      | [mount BLOCKS waiting for INIT]
+   |                           | (BLOCKED)            | [needs worker to process INIT]
+   |                           |                      |
+   |  [waiting for fd...]      |                      |
+   |                           |                      |
+   |                           |                      |
+   | DEADLOCK: mount() waits for INIT response       |
+   |           but worker thread not started yet     |
+   |           because we're waiting for fd          |
+
+
+2. Sync-Init Mount Flow (with --sync-init)
+-------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |    with --sync-init       |                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [send_fd(fd)]               |
+   |<------- fd --------------|                      |
+   |                           |                      |
+   |                      [wait_for_signal()]         |
+   |                           | (BLOCKED)            |
+   |                           |                      |
+   |  [ioctl SYNC_INIT]        |                      |
+   |---------------------------------------- ioctl -->|
+   |                                                  |
+   |  [start worker thread]                          |
+   |  [worker ready]                                 |
+   |                           |                      |
+   |--- "proceed" signal ----->|                      |
+   |                      [signal received]           |
+   |                           |                      |
+   |                      [mount() syscall]           |
+   |                           |------ mount -------->|
+   |                           |                      | [mount blocks]
+   |                           |                      | [sends INIT]
+   |<------------------------------------------------ |
+   |                           |                      |
+   | [worker processes INIT]   |                      |
+   |------------------------------------------------->|
+   |                           |                      | [mount unblocks]
+   |                           |<----- success ------ |
+   |                           |                      |
+   |                      [fusermount3 exits]         |
+   |                                                  |
+   | SUCCESS: Worker ready before mount()            |
+   |          INIT processed synchronously           |
+
+
+3. Error Scenario: Library Crashes Before Signaling
+----------------------------------------------------
+
+Library                   fusermount3              Kernel
+   |                           |                      |
+   |--- spawn fusermount3 ---->|                      |
+   |    with --sync-init       |                      |
+   |                           |                      |
+   |                      [open /dev/fuse]            |
+   |                           |------- open -------->|
+   |                           |<------ fd ---------- |
+   |                           |                      |
+   |                      [send_fd(fd)]               |
+   |<------- fd --------------|                      |
+   |                           |                      |
+   |                      [wait_for_signal()]         |
+   |                           | (BLOCKED)            |
+   |                           |                      |
+   X  [library crashes]        |                      |
+   |                           |                      |
+   |                      [recv() returns 0]          |
+   |                      [socket closed]             |
+   |                           |                      |
+   |                      [cleanup and exit]          |
+   |                           X                      |
+   |                                                  |
+   | RESULT: Clean failure, no mount performed       |
+
+
+4. Detailed Function Call Flow
+-------------------------------
+
+Library (lib/fuse_lowlevel.c):
+fuse_session_mount_new_api()
+   |
+   +-- fuse_kern_mount_prepare()  [lib/mount.c]
+   |      |
+   |      +-- fuse_mount_fusermount()  [lib/mount_util.c]
+   |             |
+   |             +-- socketpair()  [create comm socket]
+   |             |
+   |             +-- fork()
+   |             |
+   |             +-- [child] execl("fusermount3", "--sync-init", ...)
+   |             |
+   |             +-- [parent] receive_fd()  <--- BLOCKS until fd arrives
+   |                    |
+   |                    +-- recvmsg(SCM_RIGHTS)
+   |                    |
+   |                    +-- return fd
+   |
+   +-- session_start_sync_init()  [lib/fuse_lowlevel.c]
+   |      |
+   |      +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
+   |      |
+   |      +-- pthread_create(worker_thread)
+   |      |
+   |      +-- return
+   |
+   +-- fuse_fusermount_proceed_mnt(socket)  [lib/mount.c] <--- NEW: Bidirectional handshake
+          |
+          +-- send(socket, "proceed", 1)  <--- Signal fusermount3 to proceed
+          |
+          +-- recv(socket, &status, 1)  <--- BLOCKS until mount result arrives
+          |      |
+          |      +-- [fusermount3 performs mount and sends status byte]
+          |
+          +-- if (status != 0) return -1  <--- Mount failed
+          |
+          +-- return 0  <--- Mount succeeded
+
+
+Utility (util/fusermount.c):
+fusermount3 main() with --sync-init
+   |
+   +-- mount_fuse_sync_init()  [util/fusermount.c]
+          |
+          +-- mount_fuse_prepare()  [util/fusermount.c]
+          |      |
+          |      +-- open("/dev/fuse")
+          |      |
+          |      +-- check_perm()  [util/fusermount.c]
+          |      |
+          |      +-- return fd
+          |
+          +-- send_fd(socket, fd)  [util/fusermount.c]
+          |      |
+          |      +-- sendmsg(SCM_RIGHTS)
+          |
+          +-- wait_for_signal(socket)  [util/fusermount.c] <--- BLOCKS until library signals
+          |      |
+          |      +-- recv(socket, buf, 1)
+          |      |
+          |      +-- return 0
+          |
+          +-- mount_fuse_finish_fsmount()  [util/fusermount.c]
+          |      |
+          |      +-- fuse_kern_fsmount()  [lib/mount_fsmount.c]
+          |      |      |
+          |      |      +-- fsopen("fuse", FSOPEN_CLOEXEC)
+          |      |      |      |
+          |      |      |      +-- [kernel creates filesystem context]
+          |      |      |
+          |      |      +-- fsconfig(fsfd, SET_STRING, "source", ...)
+          |      |      +-- fsconfig(fsfd, SET_STRING, "fd", fd_value, ...)
+          |      |      +-- fsconfig(fsfd, ...) [apply mount options]
+          |      |      +-- fsconfig(fsfd, CMD_CREATE, ...)
+          |      |      |
+          |      |      +-- fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs)
+          |      |      |      |
+          |      |      |      +-- [kernel sends FUSE_INIT here]
+          |      |      |      |
+          |      |      |      +-- [worker thread processes INIT]
+          |      |      |      |
+          |      |      |      +-- [fsmount returns mntfd]
+          |      |      |
+          |      |      +-- move_mount(mntfd, "", AT_FDCWD, target, ...)
+          |      |      |      |
+          |      |      |      +-- [attach mount to target directory]
+          |      |      |      |
+          |      |      |      +-- [no blocking - INIT already processed]
+          |      |      |
+          |      |      +-- add_mount()  [lib/mount_fsmount.c - update /etc/mtab]
+          |      |      |
+          |      |      +-- return 0 on success, -1 on failure
+          |      |
+          |      +-- if mount failed: return -1
+          |      +-- if mount succeeded: continue
+          |
+          +-- send_status_byte(socket)  [util/fusermount.c] <--- NEW: Send result to library
+          |      |
+          |      +-- status = (mount_result == 0) ? 0 : 1
+          |      +-- send(socket, &status, 1)
+          |      |
+          |      +-- return
+          |
+          +-- return 0
+
+
+Note: The new mount API (fsopen/fsconfig/fsmount/move_mount) is REQUIRED
+      for sync-init because fsmount() triggers FUSE_INIT before the mount
+      is attached. This allows the worker thread to process INIT before
+      move_mount() completes, preventing deadlock.
diff --git a/util/fusermount.c b/util/fusermount.c
index 80b42a594e89cdc2f43824f5e274892522fd8cce..808b4afd89ceb49273c944d43bffe5033e27549b 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -957,6 +957,7 @@ static void free_mount_params(struct mount_params *mp)
 	free(mp->source);
 	free(mp->type);
 	free(mp->mnt_opts);
+	memset(mp, 0, sizeof(*mp));
 }
 
 /*
@@ -1378,6 +1379,179 @@ static int open_fuse_device(const char *dev)
 	return fd;
 }
 
+#ifdef HAVE_NEW_MOUNT_API
+/* Forward declaration from lib/mount_fsmount.c */
+int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
+		      const char *fsname, const char *subtype,
+		      const char *source_dev, const char *kernel_opts,
+		      const char *mnt_opts);
+#endif
+
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
+	struct mount_params mp = { .fd = ctx->fd };
+	char *final_mnt_opts = NULL;
+
+	/* Extract x-options */
+	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
+	if (res)
+		goto fail;
+
+	/* Prepare mount parameters */
+	mp.rootmode = ctx->stbuf.st_mode & S_IFMT;
+	mp.dev = ctx->dev;
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
@@ -1473,6 +1647,75 @@ fail_close_fd:
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
+	if (res == -1) {
+		close(fd);
+		free(ctx.source);
+		free(ctx.mnt_opts);
+		free(ctx.x_opts);
+		return -1;
+	}
+
+	close(fd);
+
+	/* Cleanup */
+	free(ctx.source);
+	free(ctx.mnt_opts);
+	free(ctx.x_opts);
+
+	return 0;
+}
+#endif /* HAVE_NEW_MOUNT_API */
+
 static int send_fd(int sock_fd, int fd)
 {
 	int retval;
@@ -1509,6 +1752,30 @@ static int send_fd(int sock_fd, int fd)
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
@@ -1700,6 +1967,7 @@ int main(int argc, char *argv[])
 	const char *opts = "";
 	const char *type = NULL;
 	int setup_auto_unmount_only = 0;
+	int sync_init_mode = 0;
 
 	static const struct option long_opts[] = {
 		{"unmount", no_argument, NULL, 'u'},
@@ -1712,6 +1980,7 @@ int main(int argc, char *argv[])
 		// They'ne meant for internal use by mount.c
 		{"auto-unmount", no_argument, NULL, 'U'},
 		{"comm-fd", required_argument, NULL, 'c'},
+		{"sync-init", no_argument, NULL, 'S'},
 		{0, 0, 0, 0}};
 
 	progname = strdup(argc > 0 ? argv[0] : "fusermount");
@@ -1746,6 +2015,9 @@ int main(int argc, char *argv[])
 		case 'c':
 			commfd = optarg;
 			break;
+		case 'S':
+			sync_init_mode = 1;
+			break;
 		case 'z':
 			lazy = 1;
 			break;
@@ -1823,21 +2095,42 @@ int main(int argc, char *argv[])
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

