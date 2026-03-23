Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AB332906
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289983; cv=fail; b=dOz7db+5j2IpFvP7rXH8pEcnSqXLasqPfSDV4WTOdrjkCtsqyYIxNDBdWn7TZ4B19GZsyvtFnlN1ZCrRUISb+9shaTREuy4d8uEPUmfg1AEOFm0qeOsg5r059DUeTpBEUBdu9g3KCH1W23OJ1jXwuMByRG+agXM92d8K06PvYz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289983; c=relaxed/simple;
	bh=ghp9zhS4Lv6FBS3ak8G8Ajcr9d0I7Q1JIZ0NqBIdbow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udAJRkedc9wUFxvSOfAADN1Sg3H5kw8VoFfZ8tcQC5BSb3Wg1GEuOhUMdNVlAhGj4v43uNkEu3yEVlZKRkeZMhM6nkm/BhkDRa9wW1YTJpppOYy2I5wHJRXwhFmeQPl6GJYTFzW1d3cRlav+gnxsvhz9vdWKXK5nYyMfsv/rdTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=HHvVE8JB; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="HHvVE8JB"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020130.outbound.protection.outlook.com [52.101.201.130]) by mx-outbound43-191.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 18:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlAFgqeE2wEqGEKmZOxusz2y2hOOFKMEwioZqA4ldJN6cHGMHOT/mHWVFYLLTN055cRTxXM2kqxFk7gJqkmPC85+fjOTWYWUtHmARhzj3zd2Z8fblATmwJO7JGa+yQLbSHDaWrr5tofcy1R+BGH7r+3l3f3VtLQFNrGpgHjS9wu6lnGo/7Je8T4Zh7PfHXipFuxamKgU7Cj2nVekuAaHbJ30G7kLxCWbX5PgYo2KLZKt4zDHyGzTb6c96O9OP7skADwFF5gr4C45DmcUIMHp0I5dCtfbZngBFwoIa9a067YM6Kzz1+N6leqYmJigGU+YjKwmMwy2h3AbcwBcVpHYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwUdgBc5sQqMLG/qssJsxrWPk0lTzt4FBb1iWh7+5sA=;
 b=lFYKQSMkS1+N5mjprLBl7Xc94AFZHW3sSVeoVUUKoAx/cpL5c7ycqYiJU7Phbc4uARgqrQt5nL3Yi3qKW5W6hyXPFi+ugQLKrBgNwgxecluUs+hB4b+zTse1+yTZF/mZUzRuWb9kpt+S+R3Pqtp5T0Ys/MU9qbmip0duHVGcBZfl5Z+XhqsR2LVKRzXLrV/uTxp3JKxQqnqoE6P5XLZXLDYmXzT0BGdpGgt2mdq8J0KTi9j66c06ULBnhsnZJ0MFAxPfXL3gv67ryEJsbLmAFNpoVPa4rkRauJDiWDPh/uEK6rVyIkau3RVXQny0jonYIPytnm46EAQ3AdXNTSgfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwUdgBc5sQqMLG/qssJsxrWPk0lTzt4FBb1iWh7+5sA=;
 b=HHvVE8JB5Edho0RdDvbap/Co/vwgWSZ+s+Q/lzTzlqeOSw+Vw2W4+sa5tDSKswaCkGNWDIoImYczNIMgMJ5ygsHZZTxCK/mZTiQa4riEhAbFr7CcaVR8Lr8VTvaBJEUudTrSIxe6HPjHKhJ95BIgHCyBh2Sh5EG1olkBjAv5Efw=
Received: from BN9PR03CA0587.namprd03.prod.outlook.com (2603:10b6:408:10d::22)
 by DS2PR19MB9196.namprd19.prod.outlook.com (2603:10b6:8:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:26 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::26) by BN9PR03CA0587.outlook.office365.com
 (2603:10b6:408:10d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:25 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D0BE1B7;
	Mon, 23 Mar 2026 17:45:21 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Mon, 23 Mar 2026 18:45:14 +0100
Subject: [PATCH 19/19] Add support for sync-init of unprivileged daemons
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260323-fuse-init-before-mount-v1-19-a52d3040af69@bsbernd.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287906; l=20959;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=m170WKNmsuhBuyM+hp6cCPUHyM54X+txlXWR6CYMSX4=;
 b=2eDGq61oPs2zAy6Upq7gDeA1dUzYDuYIztOKVfx1AOMhEW6nTZx2pyeBCWWBjr3utBUXQjy/j
 ltBseOHwLg9BwnDzjI+q3cQJgJb7zKrjqMmOHhR1CHmIlpJvb3QSC0x
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS2PR19MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1200d8-7d29-4275-3734-08de8903f701
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|61400799027|82310400026|19092799006|36860700016|376014|16102099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oiqmigNgWFXQTscysnC774xC5xVxZkqu4yPVkhdwhLagi0Lqlwm+oNKlEhjjY8wYTdi7cWlnwoHiupIqcrzjLKSFvXkgDCU+nWx3ovg7VaP2pflBXltdoOhPIK/0Y+ahP+cu+1atXgB1YWN8x/CjuIZIXZeZNA0lA/SUhuaFn8NiLPKRtT1uDmnY11mKGnQj0nROkgSwvrF7fgySnptBVwe3KBD1k1h+ARwdDXRWpm3au+ZU50laKUvtWQkIDrALUtYqAK7rGNxGZqSUNkMBgW6FMJJ2gBVXDe5DKL0hzkRJaJlXNytIvnIi/AQZZi+YbvUTokcAQszqT8qflUpNyeo4CGI1wdrNwjN2rWRIopSECBqLuEy0VT49Mr313xob0E8FziRh7PGg1eectbvIwERIYwOQXPTcsnTwx2pmLmHRRVNYeFUc1xeY1H1dZHZjXcHPNs0Q7+ih3F05lLOqhQKJRsUaih8X6nUqHdgBovgm+w8VYHSpoa2IPBdi33Fe4q7M7pVc9TP+u4IFLaKJ60q5Wt0PSMkVbpaoTvNTJI3iQTEIlF8kyX78upk4ojMVeX7pTB99ynWqrjIkwOnSKRTfT7FENouz3wQgWXwOLelqvTEHPwmUkB0GvFs0hl6vbwUIwEOpWY7bsxmsudU0PAh5egJp/JGWFbfiUNi5zMOYu33C1+mQGfsbJRdil/dg46d7yklf3QOV7PrsHW0aJa1/16rOZZcx07mAmZZFNa+9Tv9mubLdMATlVql0hm9Vii7QJ1WDgm+EVKWqkBItGg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(61400799027)(82310400026)(19092799006)(36860700016)(376014)(16102099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fuIbx52rQv46ugtueB7dUvZ50jQBnbnsQC7PBJTlAe1gRn9Yd0mtbiBDcumR6v1kP7Ww375Aqkc+KnQKVgT0pVxdlcKAbqxXwzHQvAzJENMrXIbPGvwaxuhltE6KnTCtgIivw199FySXYpedDDeT0rZYfKrOAu3Mjs/Y1cqn/feTyRZ9Djf6iVbx8DoXzSQU4K07/i4EoYbadjHcFz319HHQAXYIC7j51CzOjgHuwkAMQkDQCkFKXKU1egrrO47BzfJxKYZ6+v9VTnv9kqcyRHcXMbF8N8CKyAorEHPImcvP828oQAxk1xsO/zt7sEL07uw5WO4oQ38Xh3/mdS29WbrFUUOosc8C+FnP0CH9Skj54UhbDPJW4ouPVyeLJeMsQCAkmrg28ZOexnjs1CZI7CDEw0mQnEs4DDwxxLtASbQSHzHV9VxhvJrsJIanm5d9
X-Exchange-RoutingPolicyChecked:
	t/nSaTYTjQLpYFGB2aoBmI3K0AsFHMZUh0q2HSLLe9RcYc6+GKilQdyzZsA6v3k7/lPDiQRRZfK9VfkUQPo5T8AF9kYRtDdw4CnQmRsfODqs7CTyj26yMdKWzzgzBQ1JWKGnWsPxTqFWwVr1toYBTNVZqtNjKHlTu5ow/wGB7fXemv8Iau44ol4IHr1fFfohua3joksYN0f1lkAQyjrJQlzQTyD21QCoUM3QXn46avajwpmuud7ai+rIiVe62eniOzYcB7rPFThUfoVNkv5iuv8FUXF1S8QH3YU/tCyh3bsg/9VY428ACPY8sAu6MSbdJilOq4sR/cEXy/ccZ3omGA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YwWBLTxwnZNjGeVDb69a0ZUDSGm3F4HNLr+uc7lpfMjtqiffYsRiu4yGewxjV+hodibz8B56obqCo5epcRG81plpRSZv0S7ktSWIDOHeVt/yWmjNFgWhLdKD5HC1wbA2YYwFJy97L5IbHO0/8UC9d15Jc45LJ07NvbM48m92Xtr2wlCCQs/9d1tvTo9eEPf50iNHttwsomwsNMl7cfXuYmr3+GzNiIVF6no9DJgy8i7F160uyTfqNX2yV6f6Rkc1L8H91Zhz8ODsiMKQ1Zj6vmVpc4re1w6eD0k5Cid0SKs6Vvqe5Mj8+jOG2Wk+wYJCab78ul5labR0fVN/GmRQa3IeEYt9ksj0aqFtcIBlt4icjjAfGdp5HTONjzurnSDzKhx4ComWWhhdRM+C2TlRyKxpIqNiVGwi+Feaw7sqCFBq9aXhGAoOtD0H8w3hWP8Q1EPLIcWtP9pVdV2yR6+SYHlnWMvZ3aIy6nFo14yJR4FYucMo/YwinQW/4qSpbopwCmocGmahAyuvlHJP0kyXmAUmV3iogukt2hSGJcYgfd16qhQpGAA/HTfSUCKMhW6s25P8LbIM9GI0tBxRy61G3JZWuDtCUWeW51qdHqbGU1NbzQ5tEGHZXgyPAcvXU1E5CQrq9Qb3cmOt1fgZr6C3gA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:25.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1200d8-7d29-4275-3734-08de8903f701
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9196
X-OriginatorOrg: ddn.com
X-BESS-ID: 1774289973-111199-9488-8114-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 52.101.201.130
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGxgYGQGYGUDQx0cIiydQi1d
	zU0sjYwtjYyMLczDQx1SLNNNUo2cjIRKk2FgC4EqajQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan20-32.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Bernd Schubert <bschubert@ddn.com>

This makes use of the bidirectional fusermount. Added is
doc/README.mount, which explains the new bidirectional
communication with fusermount.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 doc/README.mount     |  86 ++++++++++++++++++++++++
 doc/README.sync-init | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c  | 115 ++++++++++++++++++++++++++------
 lib/mount.c          | 126 ++++++++++++++++++++++++++++++++++-
 lib/mount_i_linux.h  |   7 ++
 util/fusermount.c    |   2 -
 6 files changed, 494 insertions(+), 26 deletions(-)

diff --git a/doc/README.mount b/doc/README.mount
new file mode 100644
index 0000000000000000000000000000000000000000..526382ad8a5f6b405a7cb1927b79bacd6c2c2c5c
--- /dev/null
+++ b/doc/README.mount
@@ -0,0 +1,86 @@
+FUSE Mount API Flowcharts
+=========================
+
+Old Mount API
+-------------
+
+fuse_kern_mount()
+  |
+  +-- fuse_mount_sys()
+  |     +-- Try direct mount → mount() syscall
+  |     +-- On EPERM: fuse_mount_fusermount()
+  |           +-- socketpair()
+  |           +-- spawn fusermount3 (no --sync-init)
+  |           +-- fusermount3: open /dev/fuse, mount(), send fd
+  |           +-- receive_fd() → return fd
+  |
+  +-- Worker threads started AFTER mount
+  └─> FUSE_INIT asynchronous (queued in kernel)
+
+
+New Mount API - Privileged Mount
+---------------------------------
+
+fuse_session_mount_new_api()
+  |
+  +-- fuse_kern_mount_prepare() → open /dev/fuse → fd
+  |
+  +-- session_start_sync_init(se, fd)
+  |     +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
+  |     +-- pthread_create(worker) → ready to process FUSE_INIT
+  |
+  +-- fuse_kern_fsmount_mo()
+  |     +-- fsopen/fsconfig/fsmount (BLOCKS until FUSE_INIT completes)
+  |     +-- Worker processes FUSE_INIT during fsmount()
+  |     +-- move_mount()
+  |
+  +-- session_wait_sync_init_completion(se) → pthread_join
+  └─> return fd
+
+
+New Mount API - EPERM Fallback (fusermount3 with sync-init)
+------------------------------------------------------------
+
+fuse_session_mount_new_api()
+  |
+  +-- fuse_kern_mount_prepare() → open /dev/fuse → fd1
+  |
+  +-- session_start_sync_init(se, fd1)
+  |     +-- ioctl(fd1, FUSE_DEV_IOC_SYNC_INIT)
+  |     +-- pthread_create(worker) → ready with fd1
+  |
+  +-- fuse_kern_fsmount_mo() → EPERM
+  |
+  +-- *** FALLBACK TO FUSERMOUNT3 WITH SYNC-INIT ***
+  |
+  +-- session_wait_sync_init_completion(se)
+  |     +-- pthread_cancel/join → terminate worker with wrong fd1
+  |
+  +-- close(fd1)
+  |
+  +-- fuse_mount_fusermount_sync_init()  [NEW]
+  |     +-- socketpair()
+  |     +-- spawn fusermount3 --sync-init
+  |     +-- fusermount3: open /dev/fuse → fd2, send fd2
+  |     +-- receive_fd() → fd2
+  |     +-- fusermount3 waits for signal
+  |     └─> return fd2, sock
+  |
+  +-- session_start_sync_init(se, fd2)
+  |     +-- ioctl(fd2, FUSE_DEV_IOC_SYNC_INIT)
+  |     +-- pthread_create(worker) → ready with fd2
+  |
+  +-- send_proceed_signal(sock)  [NEW]
+  |     +-- send(sock, "\0", 1) → signal fusermount3
+  |
+  +-- fusermount3: mount() (BLOCKS)
+  |     +-- Kernel sends FUSE_INIT to fd2
+  |     +-- Worker processes FUSE_INIT
+  |     +-- mount() returns
+  |
+  +-- close(sock)
+  |
+  +-- session_wait_sync_init_completion(se) → pthread_join
+  |
+  └─> return fd2
+
diff --git a/doc/README.sync-init b/doc/README.sync-init
new file mode 100644
index 0000000000000000000000000000000000000000..44e47a2eef2c45026abaa19562537eef37f256b9
--- /dev/null
+++ b/doc/README.sync-init
@@ -0,0 +1,184 @@
+FUSE Synchronous vs Asynchronous FUSE_INIT
+============================================
+
+This document explains the difference between asynchronous and synchronous
+FUSE_INIT processing, and when each mode is used.
+
+
+Overview
+--------
+
+FUSE_INIT is the initial handshake between the kernel FUSE module and the
+userspace filesystem daemon. During this handshake, the kernel and daemon
+negotiate capabilities, protocol version, and various feature flags.
+
+Asynchronous FUSE_INIT (Traditional Behavior)
+----------------------------------------------
+
+In the traditional asynchronous mode:
+
+1. mount() syscall completes and returns to caller
+2. Filesystem appears mounted to the system
+3. FUSE daemon starts worker threads
+4. Worker threads process FUSE_INIT request
+5. Filesystem becomes fully operational
+
+Timeline:
+    mount() -----> returns
+                   |
+                   v
+            FUSE_INIT sent
+                   |
+                   v
+            daemon processes FUSE_INIT
+                   |
+                   v
+            filesystem ready
+
+Limitations:
+
+1. **No early requests**: The kernel cannot send requests (like getxattr)
+   during the mount() syscall. This breaks SELinux, which needs to query
+   extended attributes on the root inode immediately upon mounting.
+
+2. **Daemonization timing**: With the old fuse_daemonize() API, the daemon
+   must call it AFTER mount, because there's no way to report mount failures
+   to the parent process if daemonization happens first.
+
+3. **No custom root inode**: The root inode ID is hardcoded to FUSE_ROOT_ID (1)
+   because FUSE_INIT hasn't been processed yet when the mount completes.
+
+4. **Thread startup after mount**: io_uring threads and other worker threads
+   can only start after mount() returns, not before.
+
+
+Synchronous FUSE_INIT (New Behavior)
+-------------------------------------
+
+Kernel support: Linux kernel commit dfb84c330794 (v6.18+)
+libfuse support: libfuse 3.19+
+
+In synchronous mode:
+
+1. FUSE daemon opens /dev/fuse
+2. Daemon calls ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
+3. Daemon starts worker thread
+4. Daemon calls mount() syscall
+5. Kernel sends FUSE_INIT during mount() - mount() blocks
+6. Worker thread processes FUSE_INIT while mount() is blocked
+7. Worker thread may process additional requests (getxattr, etc.)
+8. mount() syscall completes and returns
+9. Filesystem is fully operational
+
+Timeline:
+    open /dev/fuse
+         |
+         v
+    ioctl(FUSE_DEV_IOC_SYNC_INIT)
+         |
+         v
+    start worker thread
+         |
+         v
+    mount() -----> blocks
+         |         |
+         |         v
+         |    FUSE_INIT sent
+         |         |
+         |         v
+         |    worker processes FUSE_INIT
+         |         |
+         |         v
+         |    (possible getxattr, etc.)
+         |         |
+         +-------> returns
+                   |
+                   v
+            filesystem ready
+
+Advantages:
+
+1. **SELinux support**: The kernel can send getxattr requests during mount()
+   to query security labels on the root inode.
+
+2. **Early daemonization**: The daemon can fork BEFORE mount using the new
+   fuse_daemonize_start()/signal() API, and report mount failures to the
+   parent process.
+
+3. **Custom root inode**: The daemon can specify a custom root inode ID
+   during FUSE_INIT, before mount() completes.
+
+4. **Thread startup before mount**: io_uring threads and worker threads
+   start before mount(), ensuring they're ready to handle requests.
+
+5. **Better error reporting**: Mount failures and initialization errors
+   can be properly reported to the parent process when using the new
+   daemonization API.
+
+
+When Synchronous FUSE_INIT is Used
+-----------------------------------
+
+libfuse automatically enables synchronous FUSE_INIT when:
+
+1. The application calls fuse_session_want_sync_init(), OR
+2. The new daemonization API is used (fuse_daemonize_start() was called)
+
+Synchronous FUSE_INIT requires:
+- Kernel support (commit dfb84c330794 or later)
+- Worker thread started before mount()
+- ioctl(FUSE_DEV_IOC_SYNC_INIT) succeeds
+
+If the kernel doesn't support synchronous FUSE_INIT, libfuse automatically
+falls back to asynchronous mode.
+
+
+Implementation Details
+----------------------
+
+The synchronous FUSE_INIT implementation uses a worker thread:
+
+- **session_sync_init_worker()**: Thread function that polls /dev/fuse
+  and processes FUSE_INIT and any subsequent requests until mount completes.
+
+- **session_start_sync_init()**: Creates the worker thread before mount().
+  Calls ioctl(FUSE_DEV_IOC_SYNC_INIT) to enable kernel support.
+
+- **session_wait_sync_init_completion()**: Waits for the worker thread
+  to complete after mount() returns. Checks for errors.
+
+The worker thread processes requests in a loop until se->terminate_mount_worker
+is set, which happens after mount() completes successfully.
+
+
+Compatibility
+-------------
+
+Synchronous FUSE_INIT is fully backward compatible:
+
+- Old kernels: ioctl returns ENOTTY, libfuse falls back to async mode
+- Old applications: Continue to work with async FUSE_INIT
+- New applications on old kernels: Graceful fallback to async mode
+- New applications on new kernels: Automatic sync mode when appropriate
+
+
+Example: Enabling Synchronous FUSE_INIT
+----------------------------------------
+
+Explicit request:
+    struct fuse_session *se = fuse_session_new(...);
+    fuse_session_want_sync_init(se);
+    fuse_session_mount(se, mountpoint);
+
+Automatic (with new daemonization API):
+    fuse_daemonize_start(0);  // Triggers sync init automatically
+    fuse_session_mount(se, mountpoint);
+
+
+See Also
+--------
+
+- doc/README.daemonize - New daemonization API documentation
+- doc/README.fusermount - Synchronous FUSE_INIT protocol with fusermount3
+- doc/README.mount - Mount implementation details
+
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index a7293a3898c37c3877eadf965d310ae2aa5cc2d1..da966217ed841744a20bee60de8ae615d1015b47 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -41,6 +41,7 @@
 #include <assert.h>
 #include <sys/file.h>
 #include <sys/ioctl.h>
+#include <sys/wait.h>
 #include <stdalign.h>
 #include <poll.h>
 
@@ -4551,6 +4552,8 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
 		se->init_wakeup_fd = -1;
 	}
 
+	se->init_thread = 0;
+
 	if (se->init_error != 0) {
 		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %d\n", se->init_error);
 		return -1;
@@ -4564,56 +4567,125 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
 	return 0;
 }
 
-/* Only linux supports sync FUSE_INIT so far */
+/*
+ * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
+ * Sync-init is only supported with the new API, as the mount might hang
+ * in case of daemon crash during FUSE_INIT. That also means once the sync init
+ * ioctl succeed fallback is not allowed anymore.
+ * Returns: fd on success, -1 on failure
+ */
 static int fuse_session_mount_new_api(struct fuse_session *se,
-				      const char *mountpoint)
+				      const char *mountpoint, bool *fall_back)
 {
 	int fd = -1;
+	int sock_fd = -1;
+	pid_t fusermount_pid = -1;
 	int res, err;
 	char *mnt_opts = NULL;
 	char *mnt_opts_with_fd = NULL;
 	char fd_opt[32];
 
 	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
+	err = -EIO;
 	if (res == -1) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to get base mount options\n");
-		err = -EIO;
 		goto err;
 	}
 
 	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
 	if (fd == -1) {
 		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
-		err = -EIO;
 		goto err;
 	}
 
-	/*
-	 * Enable synchronous FUSE_INIT and start worker thread, sync init
-	 * failure is not an error
-	 */
+	*fall_back = true;
 	se->fd = fd;
 	err = session_start_sync_init(se, fd);
 	if (err) {
 		/* ENOTTY means kernel doesn't support sync init - not an error */
 		if (err != -ENOTTY)
 			goto err;
+	} else {
+		*fall_back = false;
 	}
+
+
 	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
+	err = -ENOMEM;
 	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
 	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
-		err = -ENOMEM;
 		goto err;
 	}
 
+	/* Try to mount directly */
 	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
+
+	/* If mount failed with EPERM, fall back to fusermount3 with sync-init */
+	if (err < 0 && errno == EPERM) {
+		if (se->debug)
+			fuse_log(FUSE_LOG_DEBUG,
+				 "fuse: privileged mount failed with EPERM, falling back to fusermount3\n");
+
+		/* Terminate worker thread with wrong fd */
+		if (session_wait_sync_init_completion(se) < 0)
+			fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
+
+		/* Close the privileged fd */
+		close(fd);
+		fd = -1;
+		se->fd = -1;
+
+		/* Call fusermount3 with --sync-init */
+		err = -ENOTSUP;
+		fd = mount_fusermount_obtain_fd(mountpoint, se->mo, mnt_opts,
+						&sock_fd, &fusermount_pid);
+		if (fd < 0) {
+			fuse_log(
+				FUSE_LOG_ERR,
+				"fuse: fusermount3 sync-init failed\n");
+			goto err;
+		}
+
+		/* Start worker thread with correct fd from fusermount3 */
+		se->fd = fd;
+		err = session_start_sync_init(se, fd);
+		if (err) {
+			if (err != -ENOTTY) {
+				fuse_log(
+					FUSE_LOG_ERR,
+					"fuse: failed to start sync init worker\n");
+				goto err_with_sock;
+			}
+		} else {
+			*fall_back = false;
+		}
+
+		/* Send proceed signal and wait for mount result */
+		err = fuse_fusermount_proceed_mnt(sock_fd);
+		if (err < 0) {
+			err = -EIO;
+			goto err_with_sock;
+		}
+	} else if (err < 0) {
+		/* Mount failed with non-EPERM error, bail out */
+		goto err;
+	}
+
+err_with_sock:
+	if (sock_fd >= 0) {
+		close(sock_fd);
+		/* Reap fusermount3 child process to prevent zombie */
+		if (fusermount_pid > 0)
+			waitpid(fusermount_pid, NULL, 0);
+	}
 err:
 	if (err < 0) {
+		/* Close fd first to unblock worker thread */
 		if (fd >= 0)
 			close(fd);
 		fd = -1;
 		se->fd = -1;
-		se->error = -errno;
+		se->error = err;
 	}
 	/* Wait for synchronous FUSE_INIT to complete */
 	if (session_wait_sync_init_completion(se) < 0)
@@ -4625,10 +4697,11 @@ err:
 }
 #else
 static int fuse_session_mount_new_api(struct fuse_session *se,
-				      const char *mountpoint)
+				      const char *mountpoint, bool *fall_back)
 {
 	(void) se;
 	(void) mountpoint;
+	(void) fall_back;
 
 	return -1;
 }
@@ -4638,6 +4711,7 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 {
 	int fd;
 	char *mountpoint;
+	bool fall_back;
 
 	if (_mountpoint == NULL) {
 		fuse_log(FUSE_LOG_ERR, "Invalid null-ptr mountpoint!\n");
@@ -4681,21 +4755,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 		return 0;
 	}
 
-	/* new linux mount api */
-	fd = fuse_session_mount_new_api(se, mountpoint);
-	if (fd >= 0)
-		goto out;
+	/* new linux mount api (and sync init) */
+	fd = fuse_session_mount_new_api(se, mountpoint, &fall_back);
 
 	/* fall back to old API */
-	se->error = 0; /* reset error of new api */
-	fd = fuse_kern_mount(mountpoint, se->mo);
-	if (fd < 0)
-		goto error_out;
+	if (fall_back && fd < 0) {
+		se->error = 0; /* reset error of new api */
+		fd = fuse_kern_mount(mountpoint, se->mo);
+		if (fd < 0)
+			goto error_out;
+	}
 
-out:
 	se->fd = fd;
-
-	/* Save mountpoint */
 	se->mountpoint = mountpoint;
 
 	return 0;
diff --git a/lib/mount.c b/lib/mount.c
index 263b05051c236458b830c40181bce7f494803800..985938ea0be3e1affad19adad527a31ac2ca6034 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -41,6 +41,7 @@
 #define FUSERMOUNT_PROG		"fusermount3"
 #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
 #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
+#define ARG_FD_ENTRY_SIZE	30
 
 enum {
 	KEY_KERN_FLAG,
@@ -313,7 +314,7 @@ static int setup_auto_unmount(const char *mountpoint, int quiet)
 		return -1;
 	}
 
-	char arg_fd_entry[30];
+	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
 	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
 	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
 	/*
@@ -386,7 +387,7 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 		return -1;
 	}
 
-	char arg_fd_entry[30];
+	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
 	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
 	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
 	/*
@@ -446,6 +447,127 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
 	return fd;
 }
 
+/*
+ * Mount using fusermount3 with --sync-init flag for bidirectional fd exchange
+ * Used by new mount API when privileged mount fails with EPERM
+ *
+ * Returns: fd on success, -1 on failure
+ * On success, *sock_fd_out contains the socket fd for signaling fusermount3
+ */
+int mount_fusermount_obtain_fd(const char *mountpoint, struct mount_opts *mo,
+			       const char *opts, int *sock_fd_out,
+			       pid_t *pid_out)
+{
+	int fds[2];
+	pid_t pid;
+	int res;
+	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
+	posix_spawn_file_actions_t action;
+	int fd, status;
+
+	(void)mo;
+
+	if (!mountpoint) {
+		fuse_log(FUSE_LOG_ERR, "fuse: missing mountpoint parameter\n");
+		return -1;
+	}
+
+	res = socketpair(PF_UNIX, SOCK_STREAM, 0, fds);
+	if (res == -1) {
+		fuse_log(FUSE_LOG_ERR, "Running %s: socketpair() failed: %s\n",
+			 FUSERMOUNT_PROG, strerror(errno));
+		return -1;
+	}
+
+	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
+	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
+	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[1]);
+	setenv(FUSE_COMMFD2_ENV, arg_fd_entry, 1);
+
+	char const *const argv[] = {
+		FUSERMOUNT_PROG,
+		"--sync-init",
+		"-o", opts ? opts : "",
+		"--",
+		mountpoint,
+		NULL,
+	};
+
+	posix_spawn_file_actions_init(&action);
+	posix_spawn_file_actions_addclose(&action, fds[1]);
+	status = fusermount_posix_spawn(&action, argv, &pid);
+	posix_spawn_file_actions_destroy(&action);
+
+	if (status != 0) {
+		close(fds[0]);
+		close(fds[1]);
+		return -1;
+	}
+
+	close(fds[0]);
+
+	fd = receive_fd(fds[1]);
+	if (fd < 0) {
+		close(fds[1]);
+		waitpid(pid, NULL, 0);
+		return -1;
+	}
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+	/* Return socket fd for later signaling */
+	*sock_fd_out = fds[1];
+	*pid_out = pid;
+
+	return fd;
+}
+
+/*
+ * Send proceed signal to fusermount3 and wait for mount result
+ * Returns: 0 on success, -1 on failure
+ */
+int fuse_fusermount_proceed_mnt(int sock_fd)
+{
+	char buf = '\0';
+	ssize_t res;
+
+	/* Send proceed signal */
+	do {
+		res = send(sock_fd, &buf, 1, 0);
+	} while (res == -1 && errno == EINTR);
+
+	if (res != 1) {
+		fuse_log(FUSE_LOG_ERR, "fuse: failed to send proceed signal: %s\n",
+			 strerror(errno));
+		return -1;
+	}
+
+	/* Wait for mount result from fusermount3 (4-byte error code) */
+	int32_t status;
+
+	do {
+		res = recv(sock_fd, &status, sizeof(status), 0);
+	} while (res == -1 && errno == EINTR);
+
+	if (res != sizeof(status)) {
+		if (res == 0)
+			fuse_log(FUSE_LOG_ERR, "fuse: fusermount3 closed connection\n");
+		else
+			fuse_log(FUSE_LOG_ERR, "fuse: failed to receive mount status: %s\n",
+				 strerror(errno));
+		return -1;
+	}
+
+	if (status != 0) {
+		if (status != -EPERM)
+			fuse_log(FUSE_LOG_ERR, "fuse: fusermount3 mount failed: %s\n",
+				 strerror(-status));
+		return -1;
+	}
+
+	return 0;
+}
+
 #ifndef O_CLOEXEC
 #define O_CLOEXEC 0
 #endif
diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
index 867105019fa57576682091d1a650302f31e450b3..2a3386443afa73a508454124332527c35a184398 100644
--- a/lib/mount_i_linux.h
+++ b/lib/mount_i_linux.h
@@ -76,5 +76,12 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
 			 const char *mnt_opts);
 char *fuse_mnt_build_source(const struct mount_opts *mo);
 char *fuse_mnt_build_type(const struct mount_opts *mo);
+int mount_fusermount_obtain_fd(const char *mountpoint,
+					   struct mount_opts *mo,
+					   const char *opts, int *sock_fd_out,
+					   pid_t *pid_out);
+
+int fuse_fusermount_proceed_mnt(int sock_fd);
+
 
 #endif /* FUSE_MOUNT_I_H_ */
diff --git a/util/fusermount.c b/util/fusermount.c
index 808b4afd89ceb49273c944d43bffe5033e27549b..e6d973687bb4eef0d7e6626a1028cc32dd177e89 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -1397,7 +1397,6 @@ struct mount_context {
 	char *source;
 	char *mnt_opts;
 	char *x_opts;
-	const char *type;
 };
 
 /*
@@ -1521,7 +1520,6 @@ static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
 
 	/* Store results in context */
 	ctx->source = mp.source;
-	ctx->type = mp.type;
 	ctx->mnt_opts = final_mnt_opts;
 	*type = mp.type;
 

-- 
2.43.0

