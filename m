Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF73F23D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645764; cv=none; b=BTnHkphWrqSMuEIrxb104Id4N/+jPsD0UWtdbLDgkorE9knjyTwwKokDhTQUe0mN2Z9cP2GR4PqmV9DXYgslOeKQCsglx7IT36SB46YnXPfqtFP2cShmrZrBjCQ+RzHfP3+C9Zpwt75GKXlwUo4UHeLUnme9LZDfDjVFL0Jg+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645764; c=relaxed/simple;
	bh=T3oOy9BOxRaYhJLCrNuJk1xfDuPQS3hc2MlWWkF9aJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b64jfBz0ArA8FUde5jdbZChMncA/k2Tron8cQhg+FOFiXKrmpqAGbVAaJPD4p5WHw4PGcBgtVvKeNEX6qqQS0Ks2S0wQItwKZpYDMb6+lM4NyWB4WLyE3upOeutYQrrwN7DhJVvj4k/bmzYrPNU5Qtv0F7RWs+ekjx2tnT03UEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kupuz9WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kupuz9WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB261F00898;
	Thu, 17 Sep 2026 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789645762;
	bh=4lk0dyrp0mscty+FiT5flx3KZhfNUlxXUKac8BbnF5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kupuz9WW8av7+ckJfRceGKdT0SqwmR718Vjuta7a2O91FpB6L99GwbRCUdQ8GUbG2
	 YT0X3G1R7rFG6mAUiVRnAiwWDun47WCITbALhd0HNG0hyRwVppTF9NOZAhnHNp1y4k
	 RfUj5SNLruM9lWVWJ8DYqDmgHkiV6fXa2fo2GmfFgnVg1JwshpxTzCTFKcyPqoBW+Q
	 ZNqkxogpVlnz7rb2c6xloxv8lP9w6cSPUvhZxYwcNQHH+c4e7WDbLJGO5+RdK/LtQM
	 XcRFDdBhkwPPL0sDiaHlr68mIdr1tEBfPU+ExOuEG1jsW6Cw2oQIg7u9lp9xyl5S/+
	 AGg/THQpMyZYw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 13:49:03 +0200
Subject: [PATCH 1/2] Revert "selftests/filesystems: add mntns cleanup test"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-put_mnt_ns-revert-v1-1-34d9b8679e68@kernel.org>
References: <20260917-work-put_mnt_ns-revert-v1-0-34d9b8679e68@kernel.org>
In-Reply-To: <20260917-work-put_mnt_ns-revert-v1-0-34d9b8679e68@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: "To: Alexander Viro" <viro@zeniv.linux.org.uk>, 
 "To: Jan Kara" <jack@suse.cz>, "To: Noah Orlando" <Noah.Orlando@deshaw.com>, 
 Michael Vogt <michael@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3710; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T3oOy9BOxRaYhJLCrNuJk1xfDuPQS3hc2MlWWkF9aJI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStvrwncN+RSxYCkeEzenKLc8RPl1jrXb5ZrHYvQvyqF
 PuLvjLfjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkURjP84QmO4bzfLmp/gath
 o+PMrofzG46Xn2SO5X509HrUrT9STYwMt7dGVb243nxcnsF+Wrd06Rln/nQt7a3azpO483+8OrG
 TEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This reverts commit 3452eecbcc954ef859b7d19309c121a78d6d0e31.

The test checks that the mounts of a destroyed mount namespace stay
connected. The commit that made them stay connected is reverted next
because it leaks superblocks and loop devices, so drop the test with it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |  1 -
 .../selftests/filesystems/mntns_cleanup/.gitignore |  2 -
 .../selftests/filesystems/mntns_cleanup/Makefile   |  6 ---
 .../filesystems/mntns_cleanup/mntns_cleanup_test.c | 58 ----------------------
 4 files changed, 67 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d960626750e..31b278db2692 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -46,7 +46,6 @@ TARGETS += filesystems/move_mount
 TARGETS += filesystems/empty_mntns
 TARGETS += filesystems/fsmount_ns
 TARGETS += filesystems/fscontext_ns
-TARGETS += filesystems/mntns_cleanup
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/mntns_cleanup/.gitignore b/tools/testing/selftests/filesystems/mntns_cleanup/.gitignore
deleted file mode 100644
index 493fbcf8d9ec..000000000000
--- a/tools/testing/selftests/filesystems/mntns_cleanup/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-mntns_cleanup_test
diff --git a/tools/testing/selftests/filesystems/mntns_cleanup/Makefile b/tools/testing/selftests/filesystems/mntns_cleanup/Makefile
deleted file mode 100644
index 0e09e7030a5c..000000000000
--- a/tools/testing/selftests/filesystems/mntns_cleanup/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := mntns_cleanup_test
-
-CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
-
-include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/mntns_cleanup/mntns_cleanup_test.c b/tools/testing/selftests/filesystems/mntns_cleanup/mntns_cleanup_test.c
deleted file mode 100644
index 5209712568b1..000000000000
--- a/tools/testing/selftests/filesystems/mntns_cleanup/mntns_cleanup_test.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-#include <errno.h>
-#include <fcntl.h>
-#include <sched.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
-#include "../../kselftest_harness.h"
-
-FIXTURE(mntns_cleanup) {
-};
-
-FIXTURE_SETUP(mntns_cleanup)
-{
-	if (geteuid() != 0)
-		SKIP(return, "test requires CAP_SYS_ADMIN");
-
-	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
-	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
-
-	rmdir("/mnt_dir");
-	ASSERT_EQ(mkdir("/mnt_dir", 0755), 0);
-	ASSERT_EQ(mount("tmpfs", "/mnt_dir", "tmpfs", 0, NULL), 0);
-	ASSERT_EQ(mkdir("/mnt_dir/hidden", 0755), 0);
-	ASSERT_EQ(mkdir("/mnt_dir/hidden/secret", 0755), 0);
-	ASSERT_EQ(mount("tmpfs", "/mnt_dir/hidden", "tmpfs", 0, NULL), 0);
-}
-
-FIXTURE_TEARDOWN(mntns_cleanup)
-{
-}
-
-/* Mounts must stay connected when a mount namespace is cleaned up. */
-TEST_F(mntns_cleanup, keeps_mounts_connected)
-{
-	int fd, sfd, err;
-
-	fd = open("/mnt_dir", O_PATH | O_DIRECTORY | O_CLOEXEC);
-	ASSERT_GE(fd, 0);
-
-	/* Destroy the namespace; the fd keeps /mnt_dir alive. */
-	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
-
-	sfd = openat(fd, "hidden/secret", O_RDONLY);
-	err = errno;
-	if (sfd >= 0)
-		close(sfd);
-	close(fd);
-
-	ASSERT_LT(sfd, 0)
-		TH_LOG("mount namespace teardown revealed what the overmount covered");
-	ASSERT_EQ(err, ENOENT);
-}
-
-TEST_HARNESS_MAIN

-- 
2.53.0

