Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6883E3C4B;
	Mon,  4 May 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922097; cv=fail; b=bCXBeAyqCoS7YxsdEk9buj3QpXQOLLWDtecvEsM8mAiSiR/5WGfjPBi8fME88kPu7LhzHANkl5ZZBjERc9VzuDSgVjs2ENQtAUW8KAiOZY8wOk0TDnAwjs7epQgHyrNjtJOMj4ZobEu40gebmCpmDjBU6KAJ0ie07OAn9ngsWQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922097; c=relaxed/simple;
	bh=r0hQ5vYaUzYi3KTpoBzm29AEkm/x6IyIrVlU22DOa1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSAEOFuBFlGKYZ+Ss8Y/iVOhs7p4pzVbdoCbI9a3TdLVN6BqvjMElqw4zWZ94flHr5ebBLhJcIg4jhVzqqUH+AOe9FbdOznnojzwBMRFSyfpArF4oI/9Ah8ZYvkBtWJiVVOmTSEC23RW7f/fyULJKhVncLKKLMCrkYMn3lb5ZC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DC1fEVqu; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DC1fEVqu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drkAsiEsgwaZ3TWCFXhzCOotkGqzLPjGZ8ZvGrZ5Mwo3d03Twys2NPXtHYd+heesZ5vF2uFOQq0/PiZjDD0G7UKD/PPzjZ4LlCQoJsIKLlhyZxtW7Fpj8mqQMDcdU+qq1wcmXDlfpCpaTaFhhhXZL7OszvZo8RMmODmxgTFl0rIZbFv1eyWw55hZDbnor9ZE763HdBZmxpxd5wwxULcUi7LWxsxpuq3l5++z48ELhupjwrXJx9hDNizu5tkM/ZyoOWwf+fa1VZArHPhcthBNajWcI5OYOrq8SJAcV6bSe5sdrWzeeG6B1tOi2b+kQpWWtjUZN2Nppvy8iambQte6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IylxmGaCWXN3NNdNsgVD2NmzajvWDbyO7MIz3gWKSSo=;
 b=hlBdTMNLLUR9V1sIqxaC1iIU3ADF82ortPeHIXLGkw4TjITswYDqeBprNP6j3iGRHo2acO5vI1yS6AV+Y3aDSO3azgig6mXUXCYkBNjEbMtLS9lvcbcNb2B6C14W/x7Rwgg7tFFLfSKyXriHNGtDPZcUN8XkcYlzoR/EdKBmhlVCUMbXDZO3T7NrJ9ivYvn5VM279IIVCkMTDf99hfvXb6IaB8wqk7Dtyc0O18saIgOa8v7rQ1Fun6I7bJj4YP/NvkOLsW3jF/A3qnwmV44xizDVN7A3MR5n8LziFhups9452KFGcSEf9HoRwZcaN+twRmnU5SVGmVJHrqtejgBsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IylxmGaCWXN3NNdNsgVD2NmzajvWDbyO7MIz3gWKSSo=;
 b=DC1fEVquJw4TY+zTDqnN61ycdjnzosqGGa3s//Boqz6etP55SmYZQSpz8SI5YjGT/5Rf5QPwZshYU7dDo06Hz79FeZLx/nNJESWC10A8SOPSosmtEMfjnbDGDBvag2V6ucB7xD0/zp9d8JQftIKNWVLYugmgczrNVBUkZ1gzX7s=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 19:14:46 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::4a) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 19:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 19:14:45 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 14:14:42 -0500
From: David Francis <David.Francis@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, David Francis
	<David.Francis@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] fdinfo: Add fops flag to allow CAP_PERFMON to see fdinfo
Date: Mon, 4 May 2026 15:14:29 -0400
Message-ID: <20260504191429.1770840-1-David.Francis@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b954a3-a2dc-469a-7e06-08deaa116752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WZ6dHe5n18BPA4meJwe83n0tzz9l9gFRezf/hqzSg5yZZM0MwyOM6PQePbsvjrAUoHeBJ+5ctSnpPZLJBV9arxWiixNObI2Vc+9BMZGHouwt0WZkhOFb2NCs3o1dOPySebaAhpGSL3fUVy8lG+q1rjNhPTe3Di45+aV3rYidayuzdVDH3lhRGctPPizXaAs0X3G5YbcRX0cuEVCCCMf4A8zu0ycHFz9m5LBUSoTWJ+kCDtXBN//B9JSR7/LVOtUkFxOr2Ac8UrAW76Cu3eWZ15QIcvCKXT2fe11FPhPZ3jk8fNcafRSO4FdArVJAUgI++SLzkbT79UrUM3EDr19c8lQVPWUBRsPvqw2YG7MeTf3Gk93XFHVAQKLrAkmjBWFqW4SpioLrp5dCCYOnXHsbBkKr3Z30qp41pvqTbwdpSUeNGYynTv45vz43vTM8dG0T0Qyz9pxFaArXuVO07NIguO6o/eTPZYTiVq+aEppY/iCzhUN5vOFr8XItT9bb/QuUaBJnf+SBfs5kogUzDnySWVvyZISP6aEcbmIntlYbXSwLp0ZfvI9d2eOgv7jMfMFLcoQP00fQZ4JQQfssy3uvxUrq1YhNUBrnk46VTFZkwkYAFUb8/7EzvAxWAdFSty+t0SntRVPE62247smOMCQl3pIC7PhVAYrPChTuIjiWmvjoYRVWe60edJjFQ3RbqD+ZKnYu+oA6PCaekTci7eYdQ4jBdzyXrF2R2LyooPukaKM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xhI27s5RlNy1PyLxGx5h8ow6lgfcc0eDjMQ0VF+/aikbu/rrW5HendS6YyWKFw/fc6VEg/tO7sJIZZr5zJKotd26jVoJ9V87dZ/VLX8BrMIqKkxsmk2Z9anV5CY9jDFJexE/YEm+7Raiz3KdwRddL9ZRdwihGD1rCUCLeTplV+ca4lzG9U8xIPKIsoh2Ql29bwa8wyUhZ3VFWZHittU9DCO23Z7Z0NB7C33L2xWn6fUlm7mAMb/8eahhRG7wZ9O+CLPP7zxXWzzMgEmiZFg9jsAda1GGX++HYVw6tfVgkRy0Mxl1lW5o+Kkym6s8vLws1TT1ll1Ftc+EiCH05DZoMOH7CLxIlrIp6As+/k7+ap8S/HzdruSwWCktBhHgqNE5JSyFfwiZNminZHdWXqXj3OyJvZGclaDMBEKPdyPgN3x1Ewb45nZs3OiJ5TfwR79U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:14:45.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b954a3-a2dc-469a-7e06-08deaa116752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

We want some GPU information to be publicly available to all
processes for basic system-wide profiling (think GPU versions
of top).

This information is available in fdinfo and not easily exposed
by other interfaces.

Allow processes with CAP_PERFMON capability to
- read /proc/<pid>/fd
- follow symlinks in /proc/<pid>/fd, but only if that file has
new file operations flag FOP_PERFMON_FDINFO
- read /proc/<pid>/fdinfo
- read /proc/<pid>/fdinfo/<fd>, but only if that file has
FOP_PERFMON_FDINFO

Signed-off-by: David Francis <David.Francis@amd.com>
Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 fs/proc/base.c                          | 18 ++++++++++++++++
 fs/proc/fd.c                            | 28 ++++++++++++++++++++++++-
 include/linux/fs.h                      |  2 ++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03814a23eb54..d62f8b400258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3022,7 +3022,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = drm_show_fdinfo,
 #endif
-	.fop_flags = FOP_UNSIGNED_OFFSET,
+	.fop_flags = FOP_UNSIGNED_OFFSET | FOP_PERFMON_FDINFO,
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6299878e3d97..83182ff6b96d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -86,6 +86,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_parser.h>
 #include <linux/fs_struct.h>
+#include <linux/fdtable.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
@@ -716,6 +717,23 @@ static bool proc_fd_access_allowed(struct inode *inode)
 	task = get_proc_task(inode);
 	if (task) {
 		allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+		if (!allowed && capable(CAP_PERFMON)) {
+			struct files_struct *files;
+
+			task_lock(task);
+			files = task->files;
+			if (files) {
+				struct file *file;
+
+				spin_lock(&files->file_lock);
+				file = files_lookup_fd_locked(files,
+							      proc_fd(inode));
+				allowed = file && file->f_op->fop_flags &
+						  FOP_PERFMON_FDINFO;
+				spin_unlock(&files->file_lock);
+			}
+			task_unlock(task);
+		}
 		put_task_struct(task);
 	}
 	return allowed;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 9eeccff49b2a..89c1a205148a 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -86,12 +86,35 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
 				  int mask)
 {
 	bool allowed = false;
-	struct task_struct *task = get_proc_task(inode);
+	struct task_struct *task;
 
+	task = get_proc_task(inode);
 	if (!task)
 		return -ESRCH;
 
 	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+
+	if (!allowed && capable(CAP_PERFMON)) {
+		struct files_struct *files;
+
+		if (S_ISDIR(inode->i_mode)) {
+			allowed = true;
+		} else {
+			task_lock(task);
+			files = task->files;
+			if (files) {
+				struct file *file;
+
+				spin_lock(&files->file_lock);
+				file = files_lookup_fd_locked(files, proc_fd(inode));
+				allowed = file && file->f_op->fop_flags &
+						  FOP_PERFMON_FDINFO;
+				spin_unlock(&files->file_lock);
+			}
+			task_unlock(task);
+		}
+	}
+
 	put_task_struct(task);
 
 	if (!allowed)
@@ -338,6 +361,9 @@ int proc_fd_permission(struct mnt_idmap *idmap,
 	if (rv == 0)
 		return rv;
 
+	if (capable(CAP_PERFMON))
+		return 0;
+
 	rcu_read_lock();
 	p = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (p && same_thread_group(p, current))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd3b57cfadee..bc2826e1cc38 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2327,6 +2327,8 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+/* fdinfo readable with CAP_SYS_PERFMON */
+#define FOP_PERFMON_FDINFO	((__force fop_flags_t)(1 << 8))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
-- 
2.34.1

