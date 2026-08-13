Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8167367B6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592520; cv=none; b=ksOBCBRGKuUzJzFNeKsj789r11XZtXpC74aDX9DR6yArrpIWRQlCIQb/QuYcOw0HGJH1qMc+8stGwMQ2an/BY5fGs63F9IL/2lr8MNjG19JsiV8SB5miE6xIsUi8kLSpNwtp+WQkzvV5s2VdgMiVnPO8Hq/ZK47Lp+yKMfwo590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592520; c=relaxed/simple;
	bh=rkICQp9vai9NhJqSMqAdid4nZbPtr66Y+KDEbBSYtZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkCs+n+astAeWMRHTURIPxUhPXj6J+x4Gz+xQFZUuQ0yESZegd4kjZ9hmPQbkNYT9OREi4MxHqYqpMifmA88fg/ioSZwOCo1rRCqDtUxI3sAKzbVMN/+UPD45a8+SpVxG1Uk75yjPYgw/2JGbFkuSQEeKULVhbqRzKuMNhunotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DHjqdKEV; arc=none smtp.client-ip=91.218.175.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DHjqdKEV"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rkICQp9vai9NhJqSMqAdid4nZbPtr66Y+KDEbBSYtZg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786592516; v=1; x=1787197316;
 b=DHjqdKEVIWLXNLenYKgaK5V4em6jWRfUh4Kejj5UjBOEwXFLK9chPMKBXBDyUkulHC+Th24o
 odZSje321jBuqFSq42CteSi3OnkcxDSlcsG5tVT08TmHDhbmX+HKeM1BU4DTUOYHq9NoEpwiL+8
 524rZiOQX7n4r0uR01aSpSLE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 013549756ecb3f54;
	Thu, 13 Aug 2026 03:41:56 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: clm@fb.com,
	dsterba@suse.com
Cc: josef@toxicpanda.com,
	brauner@kernel.org,
	sforshee@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] btrfs: use mount idmap for defrag permission check
Date: Thu, 13 Aug 2026 11:41:46 +0800
Message-ID: <20260813034146.1207640-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

btrfs_ioctl_defrag() checks MAY_WRITE with nop_mnt_idmap, which skips
the mount idmap.  On an idmapped mount the owner comparison then uses
the caller's fsuid against the raw on-disk uid, dropping the mapping.
Every other permission/owner check in btrfs ioctl uses
file_mnt_idmap(file) (e.g. :1152, :1310, :1946); this one missed it.

Switch to file_mnt_idmap(file).  It equals nop_mnt_idmap on a normal
mount, and the check stays behind !capable(CAP_SYS_ADMIN), so only
unprivileged callers on idmapped btrfs change.  The RO-fd note in the
comment above is about the file descriptor, not this inode check, and
is unaffected.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 72bc9d4f7708..607329dedd50 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2458,7 +2458,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		 * running and allows defrag on files open in read-only mode.
 		 */
 		if (!capable(CAP_SYS_ADMIN) &&
-		    inode_permission(&nop_mnt_idmap, inode, MAY_WRITE)) {
+		    inode_permission(file_mnt_idmap(file), inode, MAY_WRITE)) {
 			ret = -EPERM;
 			goto out;
 		}
-- 
2.43.0

