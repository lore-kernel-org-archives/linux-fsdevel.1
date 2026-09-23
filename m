Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E56472F9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201970; cv=none; b=mnrW34Ma7WMsUyDUqghbNi1n6Ku2gxhweU/snQTCkFORki9vAmK2DaBhGcRMNqb9blX46C8biv3TtmNbC5vsV4WCCx+OlM5J561AT17OOp+mOwGuf9/87oUcKOEIrwweXuZ5RjakN0lChBMJ4uhkaxO1W+S9WivFu+amXSZIrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201970; c=relaxed/simple;
	bh=8USQCztz4tZJBW3yaHJw17Mk2Y/Hhoir2b9wkoj28cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvZ1Eq9ISne3aR81Y6S/aDqNdZvw87a8sF6kioPlIkGRLzSQc7gMgR7yfY0dlDrgXoqkuFO0N32lI/XJGNrjXh0qmhTtjaux1ioDebnyS/QKYuXZPgEyG0POKz4LHdAyFjIp1gqZRypmv/xZJATEPsGwkeanqHUGFHUdrHggG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOkHOY6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOkHOY6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6027E1F000FF;
	Wed, 23 Sep 2026 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790201968;
	bh=JXmJ7Cnl5njb2uuROtAAjVGZOHkAqMKFPvcTRfQU/SE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BOkHOY6KEfi1LsRx/JlaUDRmbDWy2yqg1801IuBCn5NLJbbvnbMX5G7SZ8y4+UjqU
	 sT0KFblopM5m9ykNv5DECP96S7i98lXAbE0DSeJ0/n1itO2Dkd32CJ5V5aFcWnvPKf
	 7lrHRR5JhM3w7somgahsAqhqEreyt3fUNG3wCVY+otmPQYOi6Ol/WfpOIB2GXtFUPb
	 IkH9C6BiLbSwg3f72QdpIy0Xysf2cL1yaRpywSqd2YXvPtjjPHElHIwblQkNnTkZvd
	 bJhAxvL2oObonxpNel6h/2kcoRPoOUQg5jFmcW+S/2y61z2CVLxc0mmTHQod4XDc6q
	 kFHMltExnGLYA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Sep 2026 00:18:53 +0200
Subject: [PATCH RFC 4/6] selftests/filesystems: check that a loop mount
 below a dead mount is released
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-work-mount-knullfs-v1-4-ae89b29f7cb3@kernel.org>
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=14553; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8USQCztz4tZJBW3yaHJw17Mk2Y/Hhoir2b9wkoj28cQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtCUi+ac79XGSBwJZL88oXyJxOmaMrkf/ptuqGg1wuF
 1XbHsws6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIryaG/9WHDDs7lutM4UmY
 o5DAuCg8tXP/Rz3324+lA5tONrdJbmL4K+djF3LznNOmX5cVny2ycDZLWTd1bkxwbd8HVoFM/oP
 WrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A filesystem image on a mount and the loop device mounted below it: the
image pins the mount and the loop mount pins the image. Cover the two
ways the mount above dies with the loop mount left connected:

- rmdir of the mountpoint from another mount namespace

- the last close of a detached tree that holds both, with the image
  opened through the tree and the loop mount moved below it

Neither relies on the mount namespace itself going away, so both stay
valid once put_mnt_ns() disconnects the mounts of a dying namespace
again.

Check in both that no mount namespace shows the device afterwards, that
an exclusive open of the device succeeds, and that LOOP_CLR_FD gives the
backing file up rather than only arming autoclear.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/mount_cycle/.gitignore   |   2 +
 .../selftests/filesystems/mount_cycle/Makefile     |   6 +
 .../filesystems/mount_cycle/loop_cycle_test.c      | 377 +++++++++++++++++++++
 4 files changed, 386 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 273853937c25..fb3a85d6396d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -43,6 +43,7 @@ TARGETS += filesystems/open_tree_ns
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
+TARGETS += filesystems/mount_cycle
 TARGETS += filesystems/nsfs
 TARGETS += filesystems/fuse
 TARGETS += filesystems/move_mount
diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
new file mode 100644
index 000000000000..28c623ef4d9d
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+loop_cycle_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
new file mode 100644
index 000000000000..3becec29d69f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := loop_cycle_test
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
new file mode 100644
index 000000000000..67fc3e420c92
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A mount that another namespace's rmdir detached, or that went down with
+ * the detached tree it was in when the tree's last fd was closed, keeps
+ * its submounts connected, and a connected submount is put by its
+ * parent's final mntput(). A submount whose filesystem keeps a file open
+ * on the parent then holds the parent's count above zero for good:
+ * nothing in userspace refers to either mount any more and nothing can
+ * release them. A loop device is the simplest such filesystem, its
+ * backing file sits on the parent.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <stdbool.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/loop.h>
+
+#include "../wrappers.h"
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
+static int read_sysfs(const char *path, char *buf, size_t size)
+{
+	ssize_t n;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	n = read(fd, buf, size - 1);
+	close(fd);
+	if (n < 0)
+		return -1;
+	buf[n] = '\0';
+	return 0;
+}
+
+/* Does any mount namespace in the system show a mount of @dev? */
+static bool mounted_anywhere(const char *dev)
+{
+	char path[PATH_MAX], line[4096];
+	struct dirent *de;
+	bool found = false;
+	DIR *proc;
+	FILE *f;
+
+	proc = opendir("/proc");
+	if (!proc)
+		return false;
+	while (!found && (de = readdir(proc))) {
+		if (de->d_name[0] < '0' || de->d_name[0] > '9')
+			continue;
+		snprintf(path, sizeof(path), "/proc/%s/mountinfo", de->d_name);
+		f = fopen(path, "re");
+		if (!f)
+			continue;
+		while (fgets(line, sizeof(line), f)) {
+			if (strstr(line, dev)) {
+				found = true;
+				break;
+			}
+		}
+		fclose(f);
+	}
+	closedir(proc);
+	return found;
+}
+
+/* Wait up to @ms milliseconds for the loop device to give up its backing file. */
+static bool loop_released(const char *sysfs, int ms)
+{
+	char buf[PATH_MAX];
+
+	for (; ms > 0; ms -= 100) {
+		if (read_sysfs(sysfs, buf, sizeof(buf)) < 0)
+			return true;
+		usleep(100000);
+	}
+	return read_sysfs(sysfs, buf, sizeof(buf)) < 0;
+}
+
+FIXTURE(loop_cycle) {
+	char dev[32];		/* the loop device the child set up */
+	char sysfs[64];		/* its backing_file attribute */
+};
+
+FIXTURE_SETUP(loop_cycle)
+{
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+	if (access("/dev/loop-control", R_OK | W_OK))
+		SKIP(return, "test requires loop devices");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	rmdir("/mnt_dir");
+	ASSERT_EQ(mkdir("/mnt_dir", 0755), 0);
+	ASSERT_EQ(mount("tmpfs", "/mnt_dir", "tmpfs", 0, NULL), 0);
+	self->dev[0] = '\0';
+}
+
+FIXTURE_TEARDOWN(loop_cycle)
+{
+	umount2("/mnt_dir", MNT_DETACH);
+	rmdir("/mnt_dir");
+}
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,
+	CHILD_NS,		/* could not set up the namespace or the tmpfs */
+	CHILD_IMAGE,		/* could not write the image */
+	CHILD_LOOP,		/* could not set up the loop device */
+	CHILD_MOUNT,		/* could not mount it (vfat and msdos both refused) */
+	CHILD_PIPE,		/* the parent went away */
+};
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
+/* Write an image to @img, bind a loop device to it and mount that at @mp; the device number. */
+static int loop_mount(const char *img, const char *mp)
+{
+	char dev[32];
+	int ifd, n;
+
+	ifd = open(img, O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (ifd < 0 || write_fat12(ifd))
+		return -CHILD_IMAGE;
+	n = loop_bind(ifd);
+	close(ifd);	/* the loop device holds the file from now on */
+	if (n < 0)
+		return -CHILD_LOOP;
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	if (mkdir(mp, 0755))
+		return -CHILD_MOUNT;
+	if (mount(dev, mp, "vfat", 0, NULL) && mount(dev, mp, "msdos", 0, NULL))
+		return -CHILD_MOUNT;
+	return n;
+}
+
+/*
+ * In its own mount namespace the child mounts a tmpfs on /mnt_dir/vol,
+ * puts a filesystem image on it, binds a loop device to the image and
+ * mounts that loop device below. The loop device's backing file is a
+ * reference on the mount the image is on, held by the loop device, held
+ * by the mounted filesystem, held by the mount below.
+ */
+static int loop_child(int to_parent, int from_parent)
+{
+	char c;
+	int n;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_NS;
+	if (mkdir("/mnt_dir/vol", 0755) || mount("tmpfs", "/mnt_dir/vol", "tmpfs", 0, NULL))
+		return CHILD_NS;
+	n = loop_mount("/mnt_dir/vol/img", "/mnt_dir/vol/mnt");
+	if (n < 0)
+		return -n;
+
+	if (write(to_parent, &n, sizeof(n)) != sizeof(n))
+		return CHILD_PIPE;
+	/* keep the namespace alive while the parent removes the directory */
+	if (read(from_parent, &c, 1) != 1)
+		return CHILD_PIPE;
+	return CHILD_OK;
+}
+
+/*
+ * An exclusive open of the device fails while a filesystem holds it, and
+ * the only filesystem that ever did is the one mounted below the dead
+ * mount. Give a release in flight a moment. Then the device must clear
+ * right away rather than only be marked for autoclear.
+ */
+static void assert_loop_released(struct __test_metadata *_metadata,
+				 FIXTURE_DATA(loop_cycle) *self)
+{
+	int lfd;
+
+	for (int i = 0; i < 20; i++) {
+		lfd = open(self->dev, O_RDONLY | O_EXCL);
+		if (lfd >= 0)
+			break;
+		usleep(100000);
+	}
+	EXPECT_GE(lfd, 0)
+		TH_LOG("%s is still held by the loop mount below the dead mount: nothing refers to either mount and nothing can release them",
+		       self->dev);
+	if (lfd >= 0)
+		close(lfd);
+
+	lfd = open(self->dev, O_RDWR);
+	ASSERT_GE(lfd, 0);
+	ASSERT_EQ(ioctl(lfd, LOOP_CLR_FD), 0);
+	close(lfd);
+	ASSERT_TRUE(loop_released(self->sysfs, 5000))
+		TH_LOG("%s kept its backing file after LOOP_CLR_FD: the filesystem on it is still mounted somewhere nobody can reach",
+		       self->dev);
+}
+
+/*
+ * rmdir of /mnt_dir/vol from here, where it is not a mountpoint, detaches
+ * the child's tmpfs with the loop mount connected below it. Once the child
+ * is gone nothing refers to either mount. The loop device must then be
+ * free to give up its backing file, which only happens when the mounted
+ * filesystem below the detached tmpfs has been released.
+ */
+TEST_F(loop_cycle, detached_loop_mount_released)
+{
+	int to_parent[2], to_child[2];
+	char buf[PATH_MAX];
+	int status, n = -1;
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(to_child), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		_exit(loop_child(to_parent[1], to_child[0]));
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+
+	if (read(to_parent[0], &n, sizeof(n)) != sizeof(n)) {
+		waitpid(pid, &status, 0);
+		if (WIFEXITED(status) && WEXITSTATUS(status) == CHILD_MOUNT)
+			SKIP(return, "test requires a FAT filesystem");
+		ASSERT_EQ(status, 0);
+	}
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", n);
+	snprintf(self->sysfs, sizeof(self->sysfs), "/sys/block/loop%d/loop/backing_file", n);
+	ASSERT_EQ(read_sysfs(self->sysfs, buf, sizeof(buf)), 0);
+	ASSERT_NE(strstr(buf, "/mnt_dir/vol/img"), NULL);
+
+	/* not a mountpoint in this namespace, so the directory can go */
+	ASSERT_EQ(rmdir("/mnt_dir/vol"), 0);
+
+	/* the child leaves: its namespace and every reference it held are gone */
+	ASSERT_EQ(write(to_child[1], "", 1), 1);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(status, 0);
+	close(to_parent[0]);
+	close(to_child[1]);
+
+	/* nothing can reach the two mounts any more */
+	ASSERT_EQ(access("/mnt_dir/vol", F_OK), -1);
+	ASSERT_FALSE(mounted_anywhere(self->dev));
+
+	assert_loop_released(_metadata, self);
+}
+
+/*
+ * The same two mounts in a detached tree: a clone of /mnt_dir/vol from
+ * open_tree(), the image opened through the clone so that the loop device
+ * holds the clone, and the loop mount moved below the clone. The last
+ * close of the tree's fd dissolves the tree with the loop mount left
+ * connected below the dead clone, and nothing refers to either afterwards.
+ */
+TEST_F(loop_cycle, dissolved_tree_loop_mount_released)
+{
+	int tfd, ifd, fsfd, mfd, n;
+	char buf[PATH_MAX];
+
+	fsfd = sys_fsopen("vfat", 0);
+	if (fsfd < 0)
+		fsfd = sys_fsopen("msdos", 0);
+	if (fsfd < 0)
+		SKIP(return, "test requires a FAT filesystem");
+
+	ASSERT_EQ(mkdir("/mnt_dir/vol", 0755), 0);
+	ASSERT_EQ(mount("tmpfs", "/mnt_dir/vol", "tmpfs", 0, NULL), 0);
+	tfd = sys_open_tree(AT_FDCWD, "/mnt_dir/vol", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+
+	/* the image, opened through the clone: the loop device holds the clone */
+	ifd = openat(tfd, "img", O_RDWR | O_CREAT | O_EXCL, 0600);
+	ASSERT_GE(ifd, 0);
+	ASSERT_EQ(write_fat12(ifd), 0);
+	n = loop_bind(ifd);
+	close(ifd);
+	ASSERT_GE(n, 0);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", n);
+	snprintf(self->sysfs, sizeof(self->sysfs), "/sys/block/loop%d/loop/backing_file", n);
+
+	/* the loop mount, moved below the clone */
+	ASSERT_EQ(mkdirat(tfd, "mnt", 0755), 0);
+	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", self->dev, 0), 0);
+	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	mfd = sys_fsmount(fsfd, 0, 0);
+	ASSERT_GE(mfd, 0);
+	close(fsfd);
+	ASSERT_EQ(sys_move_mount(mfd, "", tfd, "mnt", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	close(mfd);
+
+	ASSERT_EQ(read_sysfs(self->sysfs, buf, sizeof(buf)), 0);
+	ASSERT_NE(strstr(buf, "img"), NULL);
+
+	/* the last fd of the tree: both mounts die, the loop mount connected */
+	close(tfd);
+
+	/* nothing can reach the two mounts any more */
+	ASSERT_FALSE(mounted_anywhere(self->dev));
+
+	assert_loop_released(_metadata, self);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

