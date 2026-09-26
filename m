Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A649318BA8
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430324; cv=none; b=RpS9J0DiIdwG0QGydD4ILT7XtJ4rwJO7ev66tjk3lDVwD4nHV3no9R9kYEx//egvB05WCowzSGBFQ2UBiszkwWpTF5ssg+wBURcmnauDgQSybLOYqPhv7PS7/lry6eJFqrJAEv9PtnOURznyWPZwZUMJdV4fKgIZbtUUIJ58Ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430324; c=relaxed/simple;
	bh=82aH6Gu6+TalfKR+SYT/mZ+Jv5xWMRf/NFXB7mqDQXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBDk+5rAkWPyxlSE/hta5PAZiv22yFNh4HQu6wSsY5BOTNv6tY1P+5d2wfpRPYtUfaSYhx04GGY3l10Mjbp7Z/TZ7QtHivy+Du5lwxPQiG7YaY1nkkiTiNqDreBSRXlXrzdlYi3yksHNekgEiJs5Maz25q/WIhN4oNurueH/ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TinS6Cqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TinS6Cqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA61A1F000FF;
	Sat, 26 Sep 2026 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430323;
	bh=cwhClTsQK1Uuhxv6gjmbwNsw3ia/xn+TALRa8qahqR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TinS6Cqew2KUB3CNYSaTV43VpIAxX3W0fJTwPu/XZPyH6WihXL0b0nHMjaJzs00ug
	 u0aJUILEKhJfN5DUzURNlzEQOH90RTDABXfCMHG70l6kmsmMRaUhvKD333k5B+duyo
	 BIUZHUL68L1q2vehWce5WcRNXBOfD0y3GAtzPplhjIF4PoHhsjXVv+zLwWd8hAAa24
	 PVqv8G3ahuqwT4Q1EtADZ2JuY4vOhg/yxGrvbh7AOPmgiSF11aQnAOFxUWBuV4orxu
	 zTp86jaUDqFosLFPqfs+M7xFn5qX2nzsGuRTvuJ9Y3PVDpKwZZWNUzybUc8uyEjQAY
	 4gR8uUjkIRFYw==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:33 +0200
Subject: [PATCH 10/10] selftests/filesystems: check that a dead mount's
 overmount isn't followed
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-10-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7302; i=brauner@kernel.org;
 h=from:subject:message-id; bh=82aH6Gu6+TalfKR+SYT/mZ+Jv5xWMRf/NFXB7mqDQXw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxPdtEBZ+U1u0YuVc+4oqN9JeGnsf/Fau8aGR85vt
 wvOST4yp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi++8x/K+4Me+DW2iJybQF
 hy7cCvPYf4735KvCiZbqqqc8fkeI5hUzMhxp2pq1s+G800kN4cSrr/ekPNg2TVD50ExJF67rhfO
 3TuQHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add overmount_reparent_test:

- a mount that a file descriptor keeps alive after propagate_umount()
  reparented its overmount and unmounted it must not be walked into the
  freed overmount by move_mount(MOVE_MOUNT_BENEATH)

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +-
 .../mount_cycle/overmount_reparent_test.c          | 181 +++++++++++++++++++++
 3 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
index 7bdfe4268fb4..03ca95de7765 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 unmounted_tree_test
+overmount_reparent_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
index 46a68ca234ba..88271c82d1c1 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := unmounted_tree_test
+TEST_GEN_PROGS := unmounted_tree_test overmount_reparent_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/filesystems/mount_cycle/overmount_reparent_test.c b/tools/testing/selftests/filesystems/mount_cycle/overmount_reparent_test.c
new file mode 100644
index 000000000000..46a56b722f3e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/overmount_reparent_test.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * propagate_umount() slides a surviving overmount off a mount that is being
+ * unmounted and unmounts that mount right after. If a file descriptor keeps
+ * the unmounted mount alive its ->overmount is left pointing at the moved
+ * mount, which is freed on its own schedule. move_mount(MOVE_MOUNT_BENEATH)
+ * with such a file descriptor as the target walks ->overmount in
+ * topmost_overmount() before it checks that the target is still mounted and
+ * must not step into the freed mount.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#include "../wrappers.h"
+#include "../../kselftest_harness.h"
+
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 0x00000200
+#endif
+
+#ifndef FSCONFIG_CMD_CREATE
+#define FSCONFIG_CMD_CREATE 6
+#endif
+
+#define DIR_LEN 64
+#define PATH_LEN 128
+
+static int write_file(const char *path, const char *s)
+{
+	ssize_t n = -1;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd >= 0) {
+		n = write(fd, s, strlen(s));
+		close(fd);
+	}
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+/* Become root in a new user namespace with a private mount namespace. */
+static int enter_userns(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map[32];
+
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+		return -1;
+	if (write_file("/proc/self/setgroups", "deny") && errno != ENOENT)
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map))
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map))
+		return -1;
+	if (setgid(0) || setuid(0))
+		return -1;
+	return mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+}
+
+/* A detached tmpfs mount to serve as the source of a move. */
+static int detached_tmpfs(void)
+{
+	int sfd, mfd;
+
+	sfd = sys_fsopen("tmpfs", 0);
+	if (sfd < 0)
+		return -1;
+	if (sys_fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)) {
+		close(sfd);
+		return -1;
+	}
+	mfd = sys_fsmount(sfd, 0, 0);
+	close(sfd);
+	return mfd;
+}
+
+FIXTURE(overmount_reparent) {
+	char dir[DIR_LEN];
+};
+
+FIXTURE_SETUP(overmount_reparent)
+{
+	snprintf(self->dir, sizeof(self->dir), "/tmp/overmount_reparent.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	if (enter_userns()) {
+		rmdir(self->dir);
+		SKIP(return, "test requires user namespaces");
+	}
+}
+
+FIXTURE_TEARDOWN(overmount_reparent)
+{
+	char p[PATH_LEN];
+
+	snprintf(p, sizeof(p), "%s/b", self->dir);
+	umount2(p, MNT_DETACH);
+	snprintf(p, sizeof(p), "%s/a", self->dir);
+	umount2(p, MNT_DETACH);
+}
+
+/*
+ * A shared mount base_a is bind-mounted to base_b as its peer. A mount X on
+ * base_a/mp propagates a copy X_b onto base_b/mp. A file descriptor pins X_b,
+ * then X_b is made private and an overmount is stacked on its root.
+ *
+ * A lazy unmount of X propagates to X_b: X_b is committed to the unmount while
+ * its overmount survives, so propagate_umount() reparents the overmount onto
+ * base_b and unmounts X_b, which the file descriptor keeps alive. Unmounting
+ * the reparented overmount frees it. X_b->overmount now dangles unless
+ * mnt_change_mountpoint() reset it.
+ *
+ * move_mount(MOVE_MOUNT_BENEATH) through the file descriptor makes
+ * do_lock_mount() follow X_b->overmount in topmost_overmount() before it
+ * notices that X_b is no longer mounted. With the pointer reset the move fails
+ * cleanly with ENOENT; otherwise it reads the freed overmount.
+ */
+TEST_F(overmount_reparent, dead_overmount_holder_not_followed)
+{
+	char a[PATH_LEN], b[PATH_LEN], amp[PATH_LEN], bmp[PATH_LEN];
+	int fd, mfd, ret;
+
+	snprintf(a, sizeof(a), "%s/a", self->dir);
+	snprintf(b, sizeof(b), "%s/b", self->dir);
+	ASSERT_EQ(mkdir(a, 0755), 0);
+	ASSERT_EQ(mkdir(b, 0755), 0);
+
+	ASSERT_EQ(mount("tmpfs", a, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mount(NULL, a, NULL, MS_SHARED, NULL), 0);
+	ASSERT_EQ(mount(a, b, NULL, MS_BIND, NULL), 0);
+
+	snprintf(amp, sizeof(amp), "%s/a/mp", self->dir);
+	snprintf(bmp, sizeof(bmp), "%s/b/mp", self->dir);
+	/* base_a and base_b share one superblock, so this dir is in both. */
+	ASSERT_EQ(mkdir(amp, 0755), 0);
+
+	/* X on base_a/mp propagates a copy X_b onto base_b/mp. */
+	ASSERT_EQ(mount("tmpfs", amp, "tmpfs", 0, NULL), 0);
+
+	/* Pin X_b before anything is stacked on top of it. */
+	fd = open(bmp, O_PATH | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+
+	/* Keep the overmount local to X_b. */
+	ASSERT_EQ(mount(NULL, bmp, NULL, MS_PRIVATE, NULL), 0);
+
+	/* The overmount on X_b's root: X_b->overmount points at it. */
+	ASSERT_EQ(mount("tmpfs", bmp, "tmpfs", 0, NULL), 0);
+
+	/* Reparents the overmount onto base_b and unmounts X_b. */
+	ASSERT_EQ(umount2(amp, MNT_DETACH), 0);
+
+	/* Free the reparented overmount. */
+	ASSERT_EQ(umount2(bmp, MNT_DETACH), 0);
+	usleep(100000);
+
+	mfd = detached_tmpfs();
+	ASSERT_GE(mfd, 0);
+
+	ret = sys_move_mount(mfd, "", fd, "",
+			     MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH |
+			     MOVE_MOUNT_BENEATH);
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	close(mfd);
+	close(fd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

