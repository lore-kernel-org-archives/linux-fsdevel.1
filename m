Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DE3382F4
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734185; cv=none; b=kUn1JPdOmoHG2dfPAYMAf4ml70U5J5SbBaur1QC1AYPcrjEQ1fzTwTpslRLAI+1iRjbMyaaU0gjuVZbHcQSmdA7523U9GwiJRPc+QwHhE6kUhbZPVkXvvJPtpNAHCNa2KoIL9MrcIXC6wHq3A3U1rwMCU3qR+nDnsC5JJ+b7eQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734185; c=relaxed/simple;
	bh=QGnK13dreF2UDfqppCA2M5Qhc+CKmi58sUkqjnG8+6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bS1AlVn0F7aUJNOFb6c8V4rabkuBdLoAVe4Ttx3gYxE5WtLLGsxILE1C0Kg56ccR0uPuo3p7cFcN5EQr68M5Af+MLWgmXqzOvBe6NIn7xHwBwEzqQdkIPdbaBbo5lVXeVzoLUIPSM4DGF1nMBvY+excvkDP3lreiSx/dkvdn9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB9yzFGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB9yzFGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0AC1F0089D;
	Sun, 11 Oct 2026 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734182;
	bh=B4JJf7xd6pAgzkFKK1GUCumyn1EaybkmMLzIFVch/XQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SB9yzFGc0AIG5wQLsEwapUBBTBtpAjbHwmqxvOKlAEmUboJ0UKIyRplZSvXk8ZdW1
	 +UftD/GvTaC4oP5CGVGwuykdS7AcCio/PqoaCslmJEjO1o1zAF1yIdKBvvesrNoSiC
	 +OPfe6OrQJw6D7AdftWcLrRqH5Pib87KQCrj4oFiWCcGb/w8XkmSKUsXi0j8+zc68A
	 eo3QdDT5NWG6Zuj+3A8m4ErSdsObmVQj2BRGGXH5ziuy1YDgy92gV4+omD8lUYHd2S
	 i06W4e2C37GZoupQmC5xAtOtT0t00iiXcCJLAagm2HkW83LwxK/mTAoaVZfXlQ0w0X
	 RfLatmNzJoiuA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:04 +0200
Subject: [PATCH 04/15] selftests/filesystems: add quotactl() tests for
 frozen superblocks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-4-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11261; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QGnK13dreF2UDfqppCA2M5Qhc+CKmi58sUkqjnG8+6Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jhbmOEv842FUboTJadFhLEyTKgzkvw4UXB3N5uoy
 6fImmD9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsTGNk+MhiHcTzp+RgBG+P
 LeNyNamPbf/KNvwomaqcIuTiN8cnj+E326mZ9xL5hTyXip52v/Gmp4Nj5dxdx9uYOo4kKP45sle
 DAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests for quotactl() waiting on a frozen superblock:

- a waiter on a frozen read-only superblock can be killed
- a waiter on a frozen read-write superblock can be killed
- the waiters are woken up when the superblock is thawed

The tests need root, loop devices and mkfs.ext4.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/freeze/.gitignore        |   2 +
 .../testing/selftests/filesystems/freeze/Makefile  |   7 +
 tools/testing/selftests/filesystems/freeze/config  |   3 +
 .../selftests/filesystems/freeze/loop_util.h       |  64 ++++++
 .../selftests/filesystems/freeze/quotactl_test.c   | 256 +++++++++++++++++++++
 6 files changed, 333 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc4fdb6f5337..a60778626c8c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -38,6 +38,7 @@ TARGETS += filesystems/epoll
 TARGETS += filesystems/eventfd
 TARGETS += filesystems/failfs
 TARGETS += filesystems/fat
+TARGETS += filesystems/freeze
 TARGETS += filesystems/openat2
 TARGETS += filesystems/open_tree_ns
 TARGETS += filesystems/overlayfs
diff --git a/tools/testing/selftests/filesystems/freeze/.gitignore b/tools/testing/selftests/filesystems/freeze/.gitignore
new file mode 100644
index 000000000000..36fb6eaaf7eb
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+quotactl_test
diff --git a/tools/testing/selftests/filesystems/freeze/Makefile b/tools/testing/selftests/filesystems/freeze/Makefile
new file mode 100644
index 000000000000..f9e731412c56
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+LOCAL_HDRS += loop_util.h
+
+TEST_GEN_PROGS := quotactl_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/freeze/config b/tools/testing/selftests/filesystems/freeze/config
new file mode 100644
index 000000000000..5e0b39a87a05
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/config
@@ -0,0 +1,3 @@
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_EXT4_FS=y
+CONFIG_QUOTA=y
diff --git a/tools/testing/selftests/filesystems/freeze/loop_util.h b/tools/testing/selftests/filesystems/freeze/loop_util.h
new file mode 100644
index 000000000000..fcea5be6030d
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/loop_util.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SELFTESTS_FILESYSTEMS_FREEZE_LOOP_UTIL_H
+#define __SELFTESTS_FILESYSTEMS_FREEZE_LOOP_UTIL_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/loop.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+/* How often to retry when somebody else binds the free device first. */
+#define LOOP_BIND_TRIES 64
+
+/* Bind a free loop device to @fd; its number or -errno. */
+static inline int loop_bind(int fd)
+{
+	for (int i = 0; i < LOOP_BIND_TRIES; i++) {
+		char dev[32];
+		int cfd, lfd, n, err;
+
+		cfd = open("/dev/loop-control", O_RDWR | O_CLOEXEC);
+		if (cfd < 0)
+			return -errno;
+		n = ioctl(cfd, LOOP_CTL_GET_FREE);
+		err = errno;
+		close(cfd);
+		if (n < 0)
+			return -err;
+		snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+		lfd = open(dev, O_RDWR | O_CLOEXEC);
+		if (lfd < 0)
+			return -errno;
+		err = ioctl(lfd, LOOP_SET_FD, fd) ? errno : 0;
+		close(lfd);
+		if (!err)
+			return n;
+		if (err != EBUSY)
+			return -err;
+	}
+	return -EBUSY;
+}
+
+/* Did loop_bind() fail because there are no loop device nodes or no driver? */
+static inline bool loop_missing(int ret)
+{
+	return ret == -ENOENT || ret == -ENODEV;
+}
+
+static inline void loop_clear(int n)
+{
+	char dev[32];
+	int fd;
+
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	fd = open(dev, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return;
+	ioctl(fd, LOOP_CLR_FD, 0);
+	close(fd);
+}
+
+#endif /* __SELFTESTS_FILESYSTEMS_FREEZE_LOOP_UTIL_H */
diff --git a/tools/testing/selftests/filesystems/freeze/quotactl_test.c b/tools/testing/selftests/filesystems/freeze/quotactl_test.c
new file mode 100644
index 000000000000..24772e531eb4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/quotactl_test.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * quotactl(2) on a frozen superblock.
+ *
+ * Commands that modify quota wait in quotactl_block() for a frozen
+ * superblock to be thawed. A read-only superblock is frozen without
+ * taking s_writers so that wait can't be built on sb_start_write(). Check
+ * that a caller waiting on a frozen read-only or read-write superblock can
+ * be killed and that it is woken up when the superblock is thawed.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/fs.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/quota.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+#include "loop_util.h"
+
+#define IMG_SIZE (64 << 20)
+#define POLL_MS 10
+/* How long the child gets to block in quotactl() or to go away. */
+#define WAIT_MS 3000
+
+FIXTURE(frozen) {
+	char dir[64];
+	char img[96];
+	char mnt[96];
+	char dev[32];
+	int loop;
+	int mntfd;
+	pid_t pid;
+	bool frozen;
+};
+
+FIXTURE_VARIANT(frozen) {
+	unsigned long flags;
+};
+
+FIXTURE_VARIANT_ADD(frozen, ro) {
+	.flags = MS_RDONLY,
+};
+
+FIXTURE_VARIANT_ADD(frozen, rw) {
+	.flags = 0,
+};
+
+/* Fork a child that calls quotactl(Q_SETQUOTA) on @dev and exits. */
+static pid_t quotactl_child(const char *dev)
+{
+	pid_t pid;
+
+	pid = fork();
+	if (pid == 0) {
+		struct if_dqblk dq = {};
+
+		quotactl(QCMD(Q_SETQUOTA, USRQUOTA), dev, 0, (void *)&dq);
+		_exit(0);
+	}
+	return pid;
+}
+
+/* Reap @pid within @ms milliseconds; true if it went away. */
+static bool reap(pid_t pid, int *status, int ms)
+{
+	struct timespec ts = { .tv_nsec = POLL_MS * 1000 * 1000 };
+
+	for (int i = 0; i < ms / POLL_MS; i++) {
+		pid_t ret = waitpid(pid, status, WNOHANG);
+
+		if (ret == pid)
+			return true;
+		if (ret < 0)
+			return false;
+		nanosleep(&ts, NULL);
+	}
+	return false;
+}
+
+/* Wait up to @ms milliseconds for @pid to sleep in the kernel. */
+static bool blocked(pid_t pid, int ms)
+{
+	struct timespec ts = { .tv_nsec = POLL_MS * 1000 * 1000 };
+	char path[64], buf[512], *p, state;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	for (int i = 0; i < ms / POLL_MS; i++) {
+		ssize_t n;
+		int fd;
+
+		fd = open(path, O_RDONLY | O_CLOEXEC);
+		if (fd < 0)
+			return false;
+		n = read(fd, buf, sizeof(buf) - 1);
+		close(fd);
+		if (n <= 0)
+			return false;
+		buf[n] = '\0';
+		/* "pid (comm) state ..." */
+		p = strrchr(buf, ')');
+		if (p && sscanf(p, ") %c", &state) == 1 &&
+		    (state == 'D' || state == 'S'))
+			return true;
+		nanosleep(&ts, NULL);
+	}
+	return false;
+}
+
+static void frozen_cleanup(FIXTURE_DATA(frozen) *self)
+{
+	int status;
+
+	if (self->pid > 0)
+		kill(self->pid, SIGKILL);
+	/* The thaw also lets a waiter go that ignored SIGKILL. */
+	if (self->frozen)
+		ioctl(self->mntfd, FITHAW, 0);
+	if (self->pid > 0)
+		reap(self->pid, &status, WAIT_MS);
+	if (self->mntfd >= 0) {
+		close(self->mntfd);
+		umount2(self->mnt, MNT_DETACH);
+	}
+	if (self->loop >= 0)
+		loop_clear(self->loop);
+	unlink(self->img);
+	rmdir(self->mnt);
+	rmdir(self->dir);
+}
+
+FIXTURE_SETUP(frozen)
+{
+	char cmd[160];
+	int fd, ret;
+
+	self->loop = -1;
+	self->mntfd = -1;
+	self->pid = -1;
+	self->frozen = false;
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+	if (access("/dev/loop-control", R_OK | W_OK))
+		SKIP(return, "test requires loop devices");
+	/* Without a device this fails with ENODEV, or ENOSYS without quotactl(). */
+	if (quotactl(QCMD(Q_GETINFO, USRQUOTA), NULL, 0, NULL) && errno == ENOSYS)
+		SKIP(return, "kernel lacks quotactl()");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->dir, sizeof(self->dir), "/tmp/freeze_quotactl.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	snprintf(self->img, sizeof(self->img), "%s/img", self->dir);
+	snprintf(self->mnt, sizeof(self->mnt), "%s/mnt", self->dir);
+	/* The harness doesn't run the teardown when the setup fails. */
+	ASSERT_EQ(mkdir(self->mnt, 0700), 0)
+		frozen_cleanup(self);
+
+	fd = open(self->img, O_RDWR | O_CREAT | O_CLOEXEC, 0600);
+	ASSERT_GE(fd, 0)
+		frozen_cleanup(self);
+	ASSERT_EQ(ftruncate(fd, IMG_SIZE), 0)
+		frozen_cleanup(self);
+
+	snprintf(cmd, sizeof(cmd), "mkfs.ext4 -q -F %s >/dev/null 2>&1", self->img);
+	ret = system(cmd);
+	if (ret) {
+		close(fd);
+		frozen_cleanup(self);
+		SKIP(return, "mkfs.ext4 failed or is not available");
+	}
+
+	self->loop = loop_bind(fd);
+	close(fd);
+	if (loop_missing(self->loop)) {
+		frozen_cleanup(self);
+		SKIP(return, "test requires loop devices");
+	}
+	ASSERT_GE(self->loop, 0)
+		frozen_cleanup(self);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", self->loop);
+
+	if (mount(self->dev, self->mnt, "ext4", variant->flags, NULL)) {
+		if (errno == ENODEV) {
+			frozen_cleanup(self);
+			SKIP(return, "kernel lacks ext4");
+		}
+		ASSERT_EQ(errno, 0)
+			frozen_cleanup(self);
+	}
+	self->mntfd = open(self->mnt, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(self->mntfd, 0)
+		frozen_cleanup(self);
+}
+
+FIXTURE_TEARDOWN(frozen)
+{
+	frozen_cleanup(self);
+}
+
+TEST_F(frozen, waiter_is_killable)
+{
+	int status;
+
+	ASSERT_EQ(ioctl(self->mntfd, FIFREEZE, 0), 0);
+	self->frozen = true;
+
+	self->pid = quotactl_child(self->dev);
+	ASSERT_GT(self->pid, 0);
+	ASSERT_TRUE(blocked(self->pid, WAIT_MS))
+		TH_LOG("quotactl() doesn't wait on a frozen superblock");
+
+	ASSERT_EQ(kill(self->pid, SIGKILL), 0);
+	ASSERT_TRUE(reap(self->pid, &status, WAIT_MS))
+		TH_LOG("quotactl() waiter survived SIGKILL on a frozen superblock");
+	self->pid = -1;
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+}
+
+TEST_F(frozen, waiter_wakes_on_thaw)
+{
+	int status;
+
+	ASSERT_EQ(ioctl(self->mntfd, FIFREEZE, 0), 0);
+	self->frozen = true;
+
+	self->pid = quotactl_child(self->dev);
+	ASSERT_GT(self->pid, 0);
+	ASSERT_TRUE(blocked(self->pid, WAIT_MS))
+		TH_LOG("quotactl() doesn't wait on a frozen superblock");
+
+	ASSERT_EQ(ioctl(self->mntfd, FITHAW, 0), 0);
+	self->frozen = false;
+
+	ASSERT_TRUE(reap(self->pid, &status, WAIT_MS))
+		TH_LOG("quotactl() waiter wasn't woken by the thaw");
+	self->pid = -1;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

