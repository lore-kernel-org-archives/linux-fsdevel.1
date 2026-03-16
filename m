Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D023DEAE1;
	Mon, 16 Mar 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686340; cv=fail; b=QEZZv/7yTOXh+HxWs/HlsSvqJSNnzNxU8EmBxO5mQrJSoDhqLVbjpdC0x8LmCGzu5959qv7N6ptn0mDMdrT3mVMW5OaJzG9Q1L1H42VVmbvlP3K7GBcj0W/xnq4umYbxkfqcP+X/V6tLHCPiQZMWZ8I1pBHynGs968Y2HqYkpPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686340; c=relaxed/simple;
	bh=xErZl/7MYMQAu16PMo4WwmSO0E5/ad00plgeo2bkJfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=da8544uk50aZHxKdEpowYpmR499zyK8uSwiEXUFiuskGgPjb3k15w6n1K0bi8zj54kvvAQb2yV98stzP7BKOAeDAlJ+I//7yI1DdrCTUen9xt21m/XZftmZE5o4GB6Gx48XEcWQSmm2UxkhgZnztegx34E2VYjmqBTsBa/dUub4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r/NVM/pU; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r/NVM/pU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oewd1xaaMNP8zr8s5k6aZ+sBHzUOapxq5sjSK9Gfgk69kfEkLqXcySh7GUSIDiHvM2OX5bWWfHaDA+0rNELtAuFnDMt8Ie6iSB2BoC5g3yx9C2hYcC1+FgQfVwtgK39eFwYDJxDQSu1+kz5ZzTlLpXDcgJggjACqSHykj22GnbEaXwKDocjcFIxKqmwvdcYRlcilzJ3/xCFQiPLcT+Xa+V/pnqNLzKH6cacTRN5tfHCpKh2CxXxaLUbNI5Mko8x6BAovhHjlJCYU1y3RBd3lBCsWOLaSdlNBHoqikf9N3slpdo5L4LrOu6mkpVYZxAYncOiQceBDi/jo0Ev1ZjVNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbfvG+GTETNQmj4KaChLcxI7agsM7eSo3bOj1zRsKyw=;
 b=Uslk6E/mHnjbjuaVpWLHbllzhLUBF/WLFu7zjZMlpogQDQT2EnjzISwiQIoXmll5yDaRYsUKF+Fk9fI1nvWZCZ5E0kwR0i7NNJ1t0BfE7tukULg5h4+jnkNZjYb0SE9Sm1S0oJ8gZDsz55lABStHayL4KfpfO/dWc7+uGaQDP4iD0cpCcSpEV5cQl4dmTo+oumD76Q/2x30iSG72dYSfrWxSY+poZtm1UzYBjktHo72xOsikQjajqk9Y+OawGsZw6Y7nZ194MtDwK15bM8FeGPnOSX87tYouSvpppN/eTrahD4Dhsk79L4ndvEMuzsKhsBCVDCy4a9NCoTnRUmRkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbfvG+GTETNQmj4KaChLcxI7agsM7eSo3bOj1zRsKyw=;
 b=r/NVM/pURudhuuobf3yiE2oCLCqta5wSvuIdseUTm6LHs4m97kVIyTv+1KzNLsfPtQSWpKzRNZnJK50DS57XKVwiYKl0c1O2z7mv/43hXmwRRH6wV+kiDv9EEIDMBp0JPUlrlLM+J7VvmeIsyUdmHwIGonlJqJT0WzrQdOZIEk4=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.17; Mon, 16 Mar 2026 18:38:56 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::13) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 18:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:38:56 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:38:55 -0500
From: David Francis <David.Francis@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
	<linux-fsdevel@vger.kernel.org>, David Francis <David.Francis@amd.com>
Subject: [RFC PATCH] fdinfo: Option for public fdinfo
Date: Mon, 16 Mar 2026 14:38:28 -0400
Message-ID: <20260316183828.3354343-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4e3a24-4703-45d7-1383-08de838b47c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xHPI531cCvHEGUklYSOmhO1P/RaW2Q0V6H8NiZAbLXEWn/AvnV23LxEm8aNW6aCfqHEynB2ZlXUNRgUy9VwNH5pVJn4lBllOa2kh/LFH/DtJzfx0wsJJUuHC2Bi4V91N8ScNi5exfSIh1F09PwJIyQ4FdEymdbHZm53jA27fpmI2WRVv2F3E9MnFUwA5H4B0yPAERJz/vxSh3uCbo9I9HkdJK887qr60NlcvXb7/6/LVSxMPdYLmgsm7ndQwhKy2xodjHpfGGrJbt6T9eK1EZJDezRmBWGeZIWcb6wI+odGXKrxehjhhW8rUxyYQ1K3kvKjxbSEeGXZtWLhcGnqUSTMH4hHA2rulTCN9KSeN80j+cjg0SPN+tjZwluM/wIf6a/LHnhjQu53dpwbwQd2YVThUVjiCZUSpG2neUtE23v7W3+kMOPi1UNBAgRG7kj1hfyKIo2DPBY2KUrGacyEeElrOYGcu46Mi0tpltmjjb5Uo/mhlqwpV/2KdQnIkqCCV3jgbxYLmDTj0a9J+brZKXy05laNzogwHmiwvsR7uASIbE5Z/g8TfOxQPLyNjCfjTWUlJrOtCtcsa1zF0WFgRA4h1QsddrbwEcl0FyOChtKcGega1brrGTa7D6zpn6cdgKJ91n+V0kk9QjVk4Z3h7R2wjG8F5PCE8yfsrCe62zD+75sepsZd7p6V1tr85qrA6YpQkwmxAr+Ks1neH1lz03KrroklbzKAUiuMXpwCUCfnVhRqSHHlGcTU1ukF4eToRPcFqfE1uyIE8FCFcW0VqiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JmCRRuSn502UdJgv/VuM05+izfHQemTMam7iDEXJaKEgCnydQ26NB763dPqfpKytEuGIUhiBf+i7aSi2a3FCWqo8FGXqq05rwoC2AQO+Mr4T7Lzrqm9JONFnq/yFYN6ddJwvihQpmbFF7BdcpIxxzHS2EI+H/3BdZ4i2SGWjv88BDX+LJRC5EfJY+IEFbtyjvB5UoMuIjtulmV68nojGfP17ZXub2UinlcUcS0WJD/1byfgQGc/L+joliPQ05pvNBlhFnrrecUhOgmpFRHowFlC1qC/CSHi528zUP4fasHyTwUFkpEqf0uSnMCJFvPta6SC1sG98zcOb0tplRvT8Oup5EA/pAuHzQpYecCvdFX4nAlVfyECsNr/umSikNMcVbO5pL1G9ahzUcdikv15KdtpI56IwYm2L8TvLLzNQbAvPNLpxSftLFeAQoMnbyhg1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:38:56.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e3a24-4703-45d7-1383-08de838b47c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

We want some GPU information to be publicly available to all
processes for basic system-wide profiling (think GPU versions
of top).

This information is available in fdinfo and not easily exposed
by other interfaces.

Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
for that file available to read for processes without ptrace
permissions.

Note that this makes public how many files each process has open,
and what their fds are.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 fs/proc/fd.c                            | 24 ++++++++++++++++++++++--
 include/linux/fs.h                      |  2 ++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03814a23eb54..89eabeee5836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3022,7 +3022,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = drm_show_fdinfo,
 #endif
-	.fop_flags = FOP_UNSIGNED_OFFSET,
+	.fop_flags = FOP_UNSIGNED_OFFSET | FOP_PUBLIC_FDINFO,
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 9eeccff49b2a..e48854f6a28d 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -86,13 +86,34 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
 				  int mask)
 {
 	bool allowed = false;
+	struct file *file = NULL;
+	struct files_struct *files = NULL;
 	struct task_struct *task = get_proc_task(inode);
 
 	if (!task)
 		return -ESRCH;
 
-	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+	task_lock(task);
+	files = task->files;
+	if (files) {
+		unsigned int fd = proc_fd(inode);
+
+		spin_lock(&files->file_lock);
+		file = files_lookup_fd_locked(files, fd);
+		if (file)
+			get_file(file);
+		spin_unlock(&files->file_lock);
+	}
+	task_unlock(task);
+
+	if (file)
+		allowed = file->f_op->fop_flags & FOP_PUBLIC_FDINFO;
+
+	if (!allowed)
+		allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+
 	put_task_struct(task);
+	fput(file);
 
 	if (!allowed)
 		return -EACCES;
@@ -401,7 +422,6 @@ static int proc_fdinfo_iterate(struct file *file, struct dir_context *ctx)
 
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
-	.permission	= proc_fdinfo_permission,
 	.setattr	= proc_setattr,
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd3b57cfadee..0444086868d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2327,6 +2327,8 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+/* fdinfo readable without ptrace access */
+#define FOP_PUBLIC_FDINFO	((__force fop_flags_t)(1 << 8))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
-- 
2.34.1

