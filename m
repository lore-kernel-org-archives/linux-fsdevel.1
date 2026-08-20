Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA45381B0E;
	Thu, 20 Aug 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269403; cv=none; b=f0heiWHEkl6xb5LftYLJcnQf4Bdg90eCnO9kd+m3eqRmD4Hc7HH0+5Tzmgf6wJcjM+TnhCFivCAlE33j3V65JAb8xmnAPh4hLMuxoK6llN7CcTjK36Ogdluh8eC81CHguzUMlOKf2ka3LW4uvM4UeGeeD6btg37w1Nl2nuEqMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269403; c=relaxed/simple;
	bh=0A7thkjuiyK/YFMjhFUxIpcKTyHmlJw7pTIrNFF9NbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5ddyVzkshOL53jD0rQA4LYqn7O3BsY1/JVK0JCZQ9AV125tdLNA4kZKHutu/UlUAkz7E92cdPEaF2Mopuxgp7gNsbNAtAM+o9m4SybJCfZfJsF6HzzkLtjCetMD9MxJteJEUk8jLuBxQNn4uWqRy/7ewnyV7cjyt176apdCADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9XWG/UN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9XWG/UN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787269401; x=1818805401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0A7thkjuiyK/YFMjhFUxIpcKTyHmlJw7pTIrNFF9NbE=;
  b=h9XWG/UNei8odqLKx8R29D+rGvJCfAAve5SQhS+FKQym9xOHeLbh+FWI
   sBHhPgJXiFq9ThWfzpia7b16qj1TjoKAyiOAU495lonZpfAhCUEZq5qWd
   X1PB2QpzgZN44PItgk7Ibx4U7phlZ36Z9pC/PrsYARdrsKfTDR6R3EeFi
   jb1T+Iy2reqkG3NOSqMfh+13oHz5qcytX/4vLcMlZ01ZaB0LODmS9rDBN
   hyDV+ZsE9ElurSRWeBnAMPXzP/n7GrScftxikcMnhkTsW/Xoy7q/8p6jt
   m3Z//CIscTkENRGaeokV/ESX/vdzBeGfLXW1OPgmdLdbN33SqZFECw1ZP
   w==;
X-CSE-ConnectionGUID: Rokzgu8YS1qmqvpxuMgxPg==
X-CSE-MsgGUID: ckyoEToRTeeEQHVzWPK0BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="90334870"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="90334870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:43:20 -0700
X-CSE-ConnectionGUID: 7TQ9JYS6Q/+qIakNL1MDVA==
X-CSE-MsgGUID: XcWzl3TfReqjNS1BD0DdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264874120"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 16:43:18 -0700
From: Kris Pan <kris.pan@intel.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/locks: avoid allocation in fcntl_getlk() and fcntl_getlk64()
Date: Fri, 21 Aug 2026 07:40:02 +0800
Message-ID: <20260820234002.1938998-1-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fcntl_getlk() and fcntl_getlk64() allocate a struct file_lock from
filelock_cache on every call, adding kmem_cache alloc/free overhead to
the F_GETLK hot path.

This was introduced by commit 52306e882f77 ("fs/locks: Use allocation
rather than the stack in fcntl_getlk()") to save stack space, but struct
file_lock has since shrunk to 192 bytes (after the file_lock_core split),
so a stack allocation is fine.

Use locks_init_lock() to initialize a stack-allocated struct file_lock.
The fcntl() -> do_fcntl() -> fcntl_getlk() call chain has a combined
stack frame of under 500 bytes, well within even an 8KB stack.

On a Meteor Lake system, fcntl(F_GETLK) throughput improves from 11.0M
to 12.5M calls/sec (+13.6%), matching the ~11% regression reported by
the kernel test robot for stress-ng lockofd.

Fixes: 52306e882f77 ("fs/locks: Use allocation rather than the stack in fcntl_getlk()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/20171108072233.GA3816@intel.com/
Signed-off-by: Kris Pan <kris.pan@intel.com>
---
 fs/locks.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6e4ff7fcec053..12f8d569b7749 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2436,18 +2436,16 @@ static void posix_lock_to_flock64(struct flock64 *flock, struct file_lock *fl)
  */
 int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 {
-	struct file_lock *fl;
+	struct file_lock fl;
 	int error;
 
-	fl = locks_alloc_lock();
-	if (fl == NULL)
-		return -ENOMEM;
+	locks_init_lock(&fl);
 	error = -EINVAL;
 	if (cmd != F_OFD_GETLK && flock->l_type != F_RDLCK
 			&& flock->l_type != F_WRLCK)
 		goto out;
 
-	error = flock_to_posix_lock(filp, fl, flock);
+	error = flock_to_posix_lock(filp, &fl, flock);
 	if (error)
 		goto out;
 
@@ -2456,22 +2454,22 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		fl->c.flc_flags |= FL_OFDLCK;
-		fl->c.flc_owner = filp;
+		fl.c.flc_flags |= FL_OFDLCK;
+		fl.c.flc_owner = filp;
 	}
 
-	error = vfs_test_lock(filp, fl);
+	error = vfs_test_lock(filp, &fl);
 	if (error)
 		goto out;
 
-	flock->l_type = fl->c.flc_type;
-	if (fl->c.flc_type != F_UNLCK) {
-		error = posix_lock_to_flock(flock, fl);
+	flock->l_type = fl.c.flc_type;
+	if (fl.c.flc_type != F_UNLCK) {
+		error = posix_lock_to_flock(flock, &fl);
 		if (error)
 			goto out;
 	}
 out:
-	locks_free_lock(fl);
+	locks_release_private(&fl);
 	return error;
 }
 
@@ -2644,19 +2642,17 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
  */
 int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 {
-	struct file_lock *fl;
+	struct file_lock fl;
 	int error;
 
-	fl = locks_alloc_lock();
-	if (fl == NULL)
-		return -ENOMEM;
+	locks_init_lock(&fl);
 
 	error = -EINVAL;
 	if (cmd != F_OFD_GETLK && flock->l_type != F_RDLCK
 			&& flock->l_type != F_WRLCK)
 		goto out;
 
-	error = flock64_to_posix_lock(filp, fl, flock);
+	error = flock64_to_posix_lock(filp, &fl, flock);
 	if (error)
 		goto out;
 
@@ -2665,20 +2661,20 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		fl->c.flc_flags |= FL_OFDLCK;
-		fl->c.flc_owner = filp;
+		fl.c.flc_flags |= FL_OFDLCK;
+		fl.c.flc_owner = filp;
 	}
 
-	error = vfs_test_lock(filp, fl);
+	error = vfs_test_lock(filp, &fl);
 	if (error)
 		goto out;
 
-	flock->l_type = fl->c.flc_type;
-	if (fl->c.flc_type != F_UNLCK)
-		posix_lock_to_flock64(flock, fl);
+	flock->l_type = fl.c.flc_type;
+	if (fl.c.flc_type != F_UNLCK)
+		posix_lock_to_flock64(flock, &fl);
 
 out:
-	locks_free_lock(fl);
+	locks_release_private(&fl);
 	return error;
 }
 
-- 
2.43.0

