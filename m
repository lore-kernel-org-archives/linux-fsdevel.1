Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA64A1387;
	Mon, 12 Oct 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819583; cv=none; b=FrjCPaVJNVwe+A10f/JkaBK4tFy1ECS8TX9QpFrcrV5stRA2z7HplM/IpJOJBa0te+wOVeNa8ytSfPdA1E9Oettak2hs/kdVC9GtwnWVzfO3TeeOSYRZordhqqmGkfrYJLTpYqk6a5siJMfj1wRUFTHWsX9Bd0zI80wdIFfFA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819583; c=relaxed/simple;
	bh=fc1f5aC2Db2YqGfi4qUt4V5QgjVjozSG+CmmEWJB/0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBmRstvx1hJQ7Igw+iMjQEyv74H4Ewe/fd6dQTUiK9f5DpOL+vgJGxg1FPDNV4udHrjJqZFIkVLat91X62Ry41jRO1YK0LsoC28efb1/p0U9c+iQvPiaGeKiUxD/ZQp/LZc0+p5oQ4XdYv72+LseDBObaQ9/x4+QADeVq6fZqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEzoMxkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEzoMxkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB701F0089B;
	Mon, 12 Oct 2026 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819581;
	bh=2Y84dx6/DEDUyumvhDjTbXRBlESBxVzguYDdel6P8MQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CEzoMxkW7ka67lI4rt0HUtLv2PPBLFMqErvq/tRszbu36ehRy7wYwP6FI45/tG1Pk
	 t9Z7hJJyWt1NAMbGg7xZR/4/YGqNHEh3EdQ6zFHkrVRoeZswfjJXZUlMSHnS1W9Uo2
	 M9SF8/HXzxL6pU3nSUeDicJEGeW0v6f258f24+U/041FNr47/qS4IQvWJsbk/IW93a
	 l8ZMtV0BqTkn2hz4FDnvnqhUzb3C6UppvPFejAfbr/XiR0OsyVj3T1HMGAjY4FlMkw
	 mf5vJ9HNBYnZ1vsOXOE76LhMzqwi98qT1X7VY47rUFX/8AovvZOaaXaA3fnk7F+obT
	 bRD1JeblDrAtg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:19 +0200
Subject: [PATCH 6/9] selftests/filesystems: check that unheld mounts are
 gone after umount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-6-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10198; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fc1f5aC2Db2YqGfi4qUt4V5QgjVjozSG+CmmEWJB/0Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a99y2juhHeN57/+jfJ3qGCp7JdlmFgYekb0V4mXx
 QNVhrjIjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInM6GJkeFP1otk9uF1QTbfl
 9dMFCRfOHvm7TMf+iLpz4kbfKVb+sxn+CoU1fbl5nlfd4dV6mVSxur2r/vEUeC6MzvWvCNH5K3O
 BDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the exclusive open of a loop device to check when the filesystem on
it is shut down:

- synchronous umount(2), before it returns
- lazy umount with nothing else holding the mount, before it returns
- lazy umount of a mount held by a file descriptor, by the last close()
- synchronous umount(2) of a held mount, refused
- death of a mount namespace, before its last task can be reaped

None of the tests wait or retry. They check what has happened by the
time the call returns.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +-
 .../filesystems/mount_cycle/unheld_umount_test.c   | 262 +++++++++++++++++++++
 3 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
index 30f7dd071bcb..7b9c4f79053c 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -6,3 +6,4 @@ mount_cover_test
 locked_handle_test
 nsfs_rbind_loop_test
 overmount_ns_file_test
+unheld_umount_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
index fbe8c5e19d42..333b7225d89e 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := loop_cycle_test unmounted_tree_test overmount_reparent_test mount_cover_test locked_handle_test
-TEST_GEN_PROGS += nsfs_rbind_loop_test overmount_ns_file_test
+TEST_GEN_PROGS += nsfs_rbind_loop_test overmount_ns_file_test unheld_umount_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/filesystems/mount_cycle/unheld_umount_test.c b/tools/testing/selftests/filesystems/mount_cycle/unheld_umount_test.c
new file mode 100644
index 000000000000..96e3db277e49
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/unheld_umount_test.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A mount that nothing else references is torn down before umount(2)
+ * returns, lazy or not, before the last close of the file that kept it
+ * alive returns, and before the task that took a mount namespace down
+ * with it can be reaped. A loop device shows when that has happened: the
+ * filesystem claims it, and an exclusive open of the device succeeds
+ * only once the filesystem has let go.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/loop.h>
+
+#include "../../kselftest_harness.h"
+
+#define IMAGE_SIZE	(1440 * 1024)
+#define SECTOR		512
+
+/* A blank FAT12 floppy image: boot sector, two FATs, an empty root directory. */
+static int write_fat12(int fd)
+{
+	unsigned char sector[SECTOR] = {
+		0xeb, 0x3c, 0x90, 'M', 'S', 'W', 'I', 'N', '4', '.', '1',
+		[11] = 0x00, 0x02,	/* bytes per sector: 512 */
+		[13] = 1,		/* sectors per cluster */
+		[14] = 1, 0,		/* reserved sectors */
+		[16] = 2,		/* FATs */
+		[17] = 0xe0, 0x00,	/* root directory entries: 224 */
+		[19] = 0x40, 0x0b,	/* total sectors: 2880 */
+		[21] = 0xf0,		/* media descriptor */
+		[22] = 9, 0,		/* sectors per FAT */
+		[24] = 18, 0,		/* sectors per track */
+		[26] = 2, 0,		/* heads */
+		[38] = 0x29,		/* extended boot signature */
+		[39] = 0x12, 0x34, 0x56, 0x78,
+		[43] = 'N', 'O', ' ', 'N', 'A', 'M', 'E', ' ', ' ', ' ', ' ',
+		[54] = 'F', 'A', 'T', '1', '2', ' ', ' ', ' ',
+		[510] = 0x55, 0xaa,
+	};
+	unsigned char fat[SECTOR] = { 0xf0, 0xff, 0xff };
+
+	if (pwrite(fd, sector, SECTOR, 0) != SECTOR)
+		return -1;
+	/* the first FAT and the second one, one sector each is enough */
+	if (pwrite(fd, fat, SECTOR, 1 * SECTOR) != SECTOR ||
+	    pwrite(fd, fat, SECTOR, 10 * SECTOR) != SECTOR)
+		return -1;
+	return ftruncate(fd, IMAGE_SIZE);
+}
+
+/* Bind a free loop device to the open image @ifd; the device number. */
+static int loop_bind(int ifd)
+{
+	int cfd, lfd, n;
+	char dev[32];
+
+	cfd = open("/dev/loop-control", O_RDWR);
+	if (cfd < 0)
+		return -1;
+	n = ioctl(cfd, LOOP_CTL_GET_FREE);
+	close(cfd);
+	if (n < 0)
+		return -1;
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	lfd = open(dev, O_RDWR);
+	if (lfd < 0)
+		return -1;
+	if (ioctl(lfd, LOOP_SET_FD, ifd))
+		n = -1;
+	close(lfd);
+	return n;
+}
+
+/* Mount the loop device at @mp: vfat, or msdos. */
+static int loop_mount(const char *dev, const char *mp)
+{
+	if (!mount(dev, mp, "vfat", 0, NULL))
+		return 0;
+	return mount(dev, mp, "msdos", 0, NULL);
+}
+
+/*
+ * An exclusive open of the device fails with EBUSY while a filesystem
+ * holds it. No retries: the point is that it has been let go by now.
+ */
+static bool loop_free(const char *dev)
+{
+	int lfd = open(dev, O_RDONLY | O_EXCL);
+
+	if (lfd < 0)
+		return false;
+	close(lfd);
+	return true;
+}
+
+/* Tell the loop device to let go of its image. */
+static void loop_clear(const char *dev)
+{
+	int lfd = open(dev, O_RDWR);
+
+	if (lfd >= 0) {
+		ioctl(lfd, LOOP_CLR_FD);
+		close(lfd);
+	}
+}
+
+FIXTURE(unheld_umount) {
+	char dir[64];
+	char mp[80];
+	char dev[32];
+};
+
+FIXTURE_SETUP(unheld_umount)
+{
+	char img[80];
+	int ifd, n;
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+	if (access("/dev/loop-control", R_OK | W_OK))
+		SKIP(return, "test requires loop devices");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->dir, sizeof(self->dir), "/tmp/unheld_umount.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
+
+	snprintf(img, sizeof(img), "%s/img", self->dir);
+	ifd = open(img, O_RDWR | O_CREAT | O_EXCL, 0600);
+	ASSERT_GE(ifd, 0);
+	ASSERT_EQ(write_fat12(ifd), 0);
+	n = loop_bind(ifd);
+	close(ifd);	/* the loop device holds the file from now on */
+	ASSERT_GE(n, 0);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", n);
+
+	snprintf(self->mp, sizeof(self->mp), "%s/mnt", self->dir);
+	ASSERT_EQ(mkdir(self->mp, 0755), 0);
+	/* the harness skips the teardown after a SKIP() here */
+	if (loop_mount(self->dev, self->mp)) {
+		loop_clear(self->dev);
+		SKIP(return, "test requires a FAT filesystem");
+	}
+	umount2(self->mp, 0);
+}
+
+FIXTURE_TEARDOWN(unheld_umount)
+{
+	umount2(self->mp, MNT_DETACH);
+	loop_clear(self->dev);
+	umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+/* A synchronous umount(2) returns with the filesystem shut down. */
+TEST_F(unheld_umount, sync_umount_releases_before_return)
+{
+	ASSERT_EQ(loop_mount(self->dev, self->mp), 0);
+	ASSERT_FALSE(loop_free(self->dev));
+	ASSERT_EQ(umount2(self->mp, 0), 0);
+	EXPECT_TRUE(loop_free(self->dev))
+		TH_LOG("%s is still claimed after umount(2) returned", self->dev);
+}
+
+/* So does a lazy one when nothing else references the mount. */
+TEST_F(unheld_umount, lazy_umount_idle_releases_before_return)
+{
+	ASSERT_EQ(loop_mount(self->dev, self->mp), 0);
+	ASSERT_FALSE(loop_free(self->dev));
+	ASSERT_EQ(umount2(self->mp, MNT_DETACH), 0);
+	EXPECT_TRUE(loop_free(self->dev))
+		TH_LOG("%s is still claimed after umount2(MNT_DETACH) returned", self->dev);
+}
+
+/*
+ * A lazy umount of a mount that a file descriptor holds leaves the
+ * filesystem alive; the close that drops the last reference shuts it
+ * down before it returns.
+ */
+TEST_F(unheld_umount, lazy_umount_held_releases_on_close)
+{
+	int fd;
+
+	ASSERT_EQ(loop_mount(self->dev, self->mp), 0);
+	fd = open(self->mp, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(umount2(self->mp, MNT_DETACH), 0);
+	EXPECT_FALSE(loop_free(self->dev))
+		TH_LOG("%s was released while a file on it was still open", self->dev);
+	ASSERT_EQ(close(fd), 0);
+	EXPECT_TRUE(loop_free(self->dev))
+		TH_LOG("%s is still claimed after the last file on it was closed", self->dev);
+}
+
+/* A synchronous umount(2) of a held mount is refused, nothing changes. */
+TEST_F(unheld_umount, sync_umount_held_refused)
+{
+	int fd;
+
+	ASSERT_EQ(loop_mount(self->dev, self->mp), 0);
+	fd = open(self->mp, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(umount2(self->mp, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_FALSE(loop_free(self->dev));
+	ASSERT_EQ(close(fd), 0);
+	ASSERT_EQ(umount2(self->mp, 0), 0);
+	EXPECT_TRUE(loop_free(self->dev));
+}
+
+/*
+ * The mounts of a mount namespace go with its last task: by the time
+ * that task can be reaped the filesystems it had mounted are shut down.
+ */
+TEST_F(unheld_umount, namespace_death_releases_before_reap)
+{
+	int status, to_parent[2], to_child[2];
+	pid_t pid;
+	char c;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(to_child), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		if (unshare(CLONE_NEWNS) || loop_mount(self->dev, self->mp))
+			_exit(1);
+		if (write(to_parent[1], "", 1) != 1)
+			_exit(2);
+		/* leave once the parent has looked, with the mount in place */
+		if (read(to_child[0], &c, 1) != 0)
+			_exit(3);
+		_exit(0);
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+	ASSERT_EQ(read(to_parent[0], &c, 1), 1);
+	EXPECT_FALSE(loop_free(self->dev))
+		TH_LOG("%s is not claimed by the child's mount", self->dev);
+	close(to_child[1]);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(status, 0);
+	close(to_parent[0]);
+	EXPECT_TRUE(loop_free(self->dev))
+		TH_LOG("%s is still claimed after the namespace's last task was reaped", self->dev);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

