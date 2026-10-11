Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6F33D6EE
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734193; cv=none; b=DHxxg8QPQ1hTwPTvpSZfEXzUw5T0uS1doH5lBeB6xJ0JK2+7gp5MCNIhYI09rOBlVVkR0078sCPmv+9ODqsrjNC4ApFyX3fvVgV77KqgbrB6qtyfWux3lZRefujs98v0V0QejPZwIu+L4COUjqkzboSlqJWlTTTB2DeFZXDCKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734193; c=relaxed/simple;
	bh=+gn+ndxtGSLImNIvdcew3mHwaOq7YLPrlQIoGs+MHM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dN5Hul0PfqW9vzBH2lqW5S9Qob6Z6v3iky0lpTOAqJS+P/p+OEjcLysFfl9rdKoIOZoQuM50kH2mSPRGTXyaNSrdosVmQ9w5AznHUZWDhjaKFgR3401n6POInTQYsKkjWarIt/u/IhbVwawnKGf16T3MDXBVbCGVDQTEhT9EDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmzfG3fE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmzfG3fE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC631F0089B;
	Sun, 11 Oct 2026 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734189;
	bh=wc3TT1LJ5qoTDjLjGzWGAHzjswClHeT/EjrPnKVyV9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MmzfG3fEWBIkkcLJUHDhnWQNGji81Rva7cMlNT2FrXYegsqothnPqohLZ1EckOnn0
	 VpandLxfpTWHTHaq1SNetkh49oPRWHG1UJpK2h8/O0R4pS72yAd5etK3BYzw9mtlYo
	 aeHt7RvaKSnybjWC4ehSEpee0vLwJLRdVhlocVHlfpC54XNf3IEXI+EtFNyV+Gbspq
	 yVhFHfUMXREwd8+YQCfuKOtmgSb12ReKFZpERGMo7gTOuAssPEJwL7j+vRiaaw5zjw
	 maPNX/pe6BFAUWUlsiFGZcfVcKxbW1JcKbGqnhMSKKHJhgdYjfl85xffS6fGzBMvXO
	 xFx+Q54CV/HTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:08 +0200
Subject: [PATCH 08/15] selftests/filesystems: add a test for failed block
 device freezes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-8-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+gn+ndxtGSLImNIvdcew3mHwaOq7YLPrlQIoGs+MHM8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjnWuF/Iw69Ses0xF9KlTiu84r4abOucK+L9VfRB
 VPNis3Pd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkmScjw56N694fVGh7VJg5
 7cWdtTuPhdRNX33/9Zty1s0WZg+eXF/I8D/q8KK24G01zs+KM+aKLlwucMVqquCyz7LtB6vPrDd
 S/cYHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test that a block device freeze whose sync fails doesn't leave the
filesystem frozen:

- mount ext4 read-only on a loop device
- leave a writeback error on the loop device with fail_make_request
- freeze the device through EXT4_IOC_SHUTDOWN
- the superblock isn't left frozen afterwards

The test needs root, loop devices, fail_make_request and mkfs.ext4.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/freeze/.gitignore        |   1 +
 .../testing/selftests/filesystems/freeze/Makefile  |   1 +
 .../filesystems/freeze/bdev_freeze_test.c          | 234 +++++++++++++++++++++
 tools/testing/selftests/filesystems/freeze/config  |   4 +
 4 files changed, 240 insertions(+)

diff --git a/tools/testing/selftests/filesystems/freeze/.gitignore b/tools/testing/selftests/filesystems/freeze/.gitignore
index 36fb6eaaf7eb..bc6fc0fbb2a0 100644
--- a/tools/testing/selftests/filesystems/freeze/.gitignore
+++ b/tools/testing/selftests/filesystems/freeze/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 quotactl_test
+bdev_freeze_test
diff --git a/tools/testing/selftests/filesystems/freeze/Makefile b/tools/testing/selftests/filesystems/freeze/Makefile
index f9e731412c56..53c8a373223f 100644
--- a/tools/testing/selftests/filesystems/freeze/Makefile
+++ b/tools/testing/selftests/filesystems/freeze/Makefile
@@ -3,5 +3,6 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 LOCAL_HDRS += loop_util.h
 
 TEST_GEN_PROGS := quotactl_test
+TEST_GEN_PROGS += bdev_freeze_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/freeze/bdev_freeze_test.c b/tools/testing/selftests/filesystems/freeze/bdev_freeze_test.c
new file mode 100644
index 000000000000..0a13111a85d3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/bdev_freeze_test.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A failed block device freeze must not leave the filesystem frozen.
+ *
+ * bdev_freeze() takes an error from the holder's ->freeze() to mean that
+ * nothing was frozen and drops bd_fsfreeze_count, so its callers (dm's
+ * lock_fs(), the filesystem shutdown ioctls) never call bdev_thaw().  Leave a
+ * writeback error on the block device's page cache and freeze the device
+ * through EXT4_IOC_SHUTDOWN: either the freeze succeeds, or the superblock
+ * must not stay frozen.  The filesystem is mounted read-only so that
+ * freeze_super() doesn't sync the device and consume the error itself.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/fs.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+#include "loop_util.h"
+
+#define IMG_SIZE (64 << 20)
+
+#ifndef EXT4_IOC_SHUTDOWN
+#define EXT4_IOC_SHUTDOWN _IOR('X', 125, uint32_t)
+#endif
+#ifndef EXT4_GOING_FLAGS_DEFAULT
+#define EXT4_GOING_FLAGS_DEFAULT 0x0
+#endif
+
+#define FMR "/sys/kernel/debug/fail_make_request"
+#define FMR_VAL_LEN 32
+
+/* Global fail_make_request settings that fail exactly the next bio. */
+static const struct {
+	const char *name;
+	const char *val;
+} fmr_attrs[] = {
+	{ "probability", "100" },
+	{ "interval", "1" },
+	{ "times", "1" },
+	{ "verbose", "0" },
+};
+
+FIXTURE(bdev_freeze) {
+	char dir[64];
+	char img[96];
+	char mnt[96];
+	char dev[32];
+	char fail[64];
+	/* the settings the test found, restored in the teardown */
+	char fmr[ARRAY_SIZE(fmr_attrs)][FMR_VAL_LEN];
+	int nr_fmr;
+	int loop;
+	int mntfd;
+};
+
+static int read_file(const char *path, char *buf, size_t size)
+{
+	ssize_t n;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	n = read(fd, buf, size - 1);
+	close(fd);
+	if (n <= 0)
+		return -1;
+	buf[n] = '\0';
+	return 0;
+}
+
+static int write_file(const char *path, const char *val)
+{
+	int fd, ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	ret = write(fd, val, strlen(val)) == (ssize_t)strlen(val) ? 0 : -1;
+	close(fd);
+	return ret;
+}
+
+static void bdev_freeze_cleanup(FIXTURE_DATA(bdev_freeze) *self)
+{
+	char path[128];
+
+	if (self->fail[0])
+		write_file(self->fail, "0");
+	for (int i = 0; i < self->nr_fmr; i++) {
+		snprintf(path, sizeof(path), FMR "/%s", fmr_attrs[i].name);
+		write_file(path, self->fmr[i]);
+	}
+	if (self->mntfd >= 0) {
+		/* don't leave a frozen superblock behind if the test failed */
+		ioctl(self->mntfd, FITHAW, 0);
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
+FIXTURE_SETUP(bdev_freeze)
+{
+	char cmd[160];
+	int fd, ret;
+
+	self->loop = -1;
+	self->mntfd = -1;
+	self->nr_fmr = 0;
+	self->fail[0] = '\0';
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+	if (access("/dev/loop-control", R_OK | W_OK))
+		SKIP(return, "test requires loop devices");
+	if (access(FMR "/probability", W_OK))
+		SKIP(return, "test requires CONFIG_FAIL_MAKE_REQUEST and debugfs");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->dir, sizeof(self->dir), "/tmp/bdev_freeze.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	snprintf(self->img, sizeof(self->img), "%s/img", self->dir);
+	snprintf(self->mnt, sizeof(self->mnt), "%s/mnt", self->dir);
+	/* The harness doesn't run the teardown when the setup fails. */
+	ASSERT_EQ(mkdir(self->mnt, 0700), 0)
+		bdev_freeze_cleanup(self);
+
+	fd = open(self->img, O_RDWR | O_CREAT | O_CLOEXEC, 0600);
+	ASSERT_GE(fd, 0)
+		bdev_freeze_cleanup(self);
+	ASSERT_EQ(ftruncate(fd, IMG_SIZE), 0)
+		bdev_freeze_cleanup(self);
+
+	snprintf(cmd, sizeof(cmd), "mkfs.ext4 -q -F %s >/dev/null 2>&1", self->img);
+	ret = system(cmd);
+	if (ret) {
+		close(fd);
+		bdev_freeze_cleanup(self);
+		SKIP(return, "mkfs.ext4 failed or is not available");
+	}
+
+	self->loop = loop_bind(fd);
+	close(fd);
+	if (loop_missing(self->loop)) {
+		bdev_freeze_cleanup(self);
+		SKIP(return, "test requires loop devices");
+	}
+	ASSERT_GE(self->loop, 0)
+		bdev_freeze_cleanup(self);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", self->loop);
+	snprintf(self->fail, sizeof(self->fail), "/sys/block/loop%d/make-it-fail", self->loop);
+
+	if (mount(self->dev, self->mnt, "ext4", MS_RDONLY, NULL)) {
+		if (errno == ENODEV) {
+			bdev_freeze_cleanup(self);
+			SKIP(return, "kernel lacks ext4");
+		}
+		ASSERT_EQ(errno, 0)
+			bdev_freeze_cleanup(self);
+	}
+	self->mntfd = open(self->mnt, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(self->mntfd, 0)
+		bdev_freeze_cleanup(self);
+}
+
+FIXTURE_TEARDOWN(bdev_freeze)
+{
+	bdev_freeze_cleanup(self);
+}
+
+TEST_F(bdev_freeze, sync_error_does_not_strand_freeze)
+{
+	uint32_t flags = EXT4_GOING_FLAGS_DEFAULT;
+	off_t off = IMG_SIZE - 4096;
+	char buf[4096], path[128];
+	int fd, ret, err;
+
+	/* Without bdev_allow_write_mounted the mount blocks writers. */
+	fd = open(self->dev, O_RDWR | O_CLOEXEC);
+	if (fd < 0 && errno == EBUSY)
+		SKIP(return, "writes to mounted block devices are blocked");
+	ASSERT_GE(fd, 0);
+
+	for (int i = 0; i < ARRAY_SIZE(fmr_attrs); i++) {
+		snprintf(path, sizeof(path), FMR "/%s", fmr_attrs[i].name);
+		ASSERT_EQ(read_file(path, self->fmr[i], sizeof(self->fmr[i])), 0);
+		self->nr_fmr = i + 1;
+		ASSERT_EQ(write_file(path, fmr_attrs[i].val), 0);
+	}
+
+	memset(buf, 0x5a, sizeof(buf));
+	ASSERT_EQ(pwrite(fd, buf, sizeof(buf), off), sizeof(buf));
+
+	/*
+	 * Start writeback of that page and let it fail.  Don't wait for it
+	 * with an error check: that would consume AS_EIO on the mapping.
+	 */
+	ASSERT_EQ(write_file(self->fail, "1"), 0);
+	ASSERT_EQ(sync_file_range(fd, off, sizeof(buf), SYNC_FILE_RANGE_WRITE), 0);
+	ASSERT_EQ(write_file(self->fail, "0"), 0);
+	/* The mount keeps the device open, so this close doesn't flush. */
+	close(fd);
+
+	/* bdev_freeze() -> fs_bdev_freeze() -> sync_blockdev() fails */
+	ret = ioctl(self->mntfd, EXT4_IOC_SHUTDOWN, &flags);
+	err = errno;
+	TH_LOG("EXT4_IOC_SHUTDOWN: %d (%s)", ret, ret ? strerror(err) : "ok");
+
+	/* FITHAW only succeeds on a frozen superblock. */
+	ret = ioctl(self->mntfd, FITHAW, 0);
+	ASSERT_NE(ret, 0)
+		TH_LOG("superblock left frozen after the block device freeze failed");
+	ASSERT_EQ(errno, EINVAL);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/freeze/config b/tools/testing/selftests/filesystems/freeze/config
index 5e0b39a87a05..09d86d9bc7d7 100644
--- a/tools/testing/selftests/filesystems/freeze/config
+++ b/tools/testing/selftests/filesystems/freeze/config
@@ -1,3 +1,7 @@
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_DEBUG_FS=y
 CONFIG_EXT4_FS=y
+CONFIG_FAIL_MAKE_REQUEST=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_QUOTA=y

-- 
2.53.0

