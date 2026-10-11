Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD482868B5
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734195; cv=none; b=su7v7Mh4c3XVoVH5DZPaZ9eYJUgmWAROs+91NEvcvrrJZlOM/hti6gvgrLfYydKOd7dWPL9MTgPhd/Q0TxBnEyuUQm7RiFq8wIjb3JhSXjrk+DEfgsjEKHH+grA5JHH+AQqrfjqTCS7E8bir4wSP4MFBJp842cK+2m5OsUCO/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734195; c=relaxed/simple;
	bh=DGwJWwZ3WWzSqNMo7MJOE/E7EdqBFc5dlf6HP3laI2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzdTJwkFtVRS39h6fRQaqe7FwXKVRq1ECPJy5epLq6bNUtaacdwynM9OQ+eGakXWpHHn6wsPMEUuzGCPmNBRzLmxjzByJdrrzndI7Qt5XhKLTLMR+klNBqIL3w8Q2Dz+XciVyaRpz6bFeu48oiRvIyeIi/A1K2aWfcob/ZMTPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEys+aUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEys+aUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0081F0089E;
	Sun, 11 Oct 2026 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734193;
	bh=2cqsdIFsxS9SDHUf7JLX5+CcoGUL1R1pZAGMOGtSi24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UEys+aUyl6SXjjJsEyPwQhmpLlnXEumK18jQr7TPQAXm2QxWurHQu9TFsYLg0Bg+7
	 nNtmijfQR/mNIUuSdFjl0eoX+QhQqyJs/IiibpT0GxgFSx6jHbZd9Pvw9ciVh/OlFy
	 yCjn0TqdrjEqOQvO63tG9+OH68CL8ruAv2im2irIMFDr+mJcHAUhma+VIHqjAQcz7F
	 nQoQ4IBBg6UFIdV1cIIm0UjHF78Q7fAMNOIbrUK6wXahtQt6grE6bQXeND6X1GrfU0
	 qR8dkNLvDYrQxOulTuvJLr37IXcI1pmENIOe/T7sLJWeDsgu+TmSVuVHygvgfFMlGj
	 /CGggVN/oqzLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:10 +0200
Subject: [PATCH 10/15] selftests/filesystems: add a test for thawing behind
 a device freeze
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-10-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9776; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DGwJWwZ3WWzSqNMo7MJOE/E7EdqBFc5dlf6HP3laI2M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjn+LO/q6+ULL/73uL1PraAuyxCxToWYTXZ0+xFi
 qQYCw94dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEOp+RYUu/4u/a/SIHNUss
 Cu+55y6sYnSbPOvh7u7ZG6YaqLypu8bI0L1kbkvC+pxt01P8/jKEOlzkuNoxTblH9EbaRXcjpo6
 LDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test for a filesystem that is thawed while device-mapper holds a
freeze on it:

- mount ext4 read-only on a dm-linear device
- suspend the device with lockfs
- FITHAW the filesystem
- resume the device
- the device can be mounted again after the umount

The test needs root, loop devices, device-mapper and mkfs.ext4.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/freeze/.gitignore        |   1 +
 .../testing/selftests/filesystems/freeze/Makefile  |   2 +-
 .../selftests/filesystems/freeze/bdev_thaw_test.c  | 251 +++++++++++++++++++++
 tools/testing/selftests/filesystems/freeze/config  |   2 +
 4 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/freeze/.gitignore b/tools/testing/selftests/filesystems/freeze/.gitignore
index bc6fc0fbb2a0..28f1fe73f19b 100644
--- a/tools/testing/selftests/filesystems/freeze/.gitignore
+++ b/tools/testing/selftests/filesystems/freeze/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 quotactl_test
 bdev_freeze_test
+bdev_thaw_test
diff --git a/tools/testing/selftests/filesystems/freeze/Makefile b/tools/testing/selftests/filesystems/freeze/Makefile
index 53c8a373223f..acd246e1b14b 100644
--- a/tools/testing/selftests/filesystems/freeze/Makefile
+++ b/tools/testing/selftests/filesystems/freeze/Makefile
@@ -3,6 +3,6 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 LOCAL_HDRS += loop_util.h
 
 TEST_GEN_PROGS := quotactl_test
-TEST_GEN_PROGS += bdev_freeze_test
+TEST_GEN_PROGS += bdev_freeze_test bdev_thaw_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/freeze/bdev_thaw_test.c b/tools/testing/selftests/filesystems/freeze/bdev_thaw_test.c
new file mode 100644
index 000000000000..9bb21293093c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/freeze/bdev_thaw_test.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Thawing a superblock behind the block layer's back.
+ *
+ * A device-mapper suspend freezes the filesystem on the device through
+ * bdev_freeze() with the same userspace holder FIFREEZE uses, so FITHAW can
+ * drop that freeze while the device is still suspended. The resume then
+ * finds nothing left to thaw. Check that it still thaws the device so that
+ * it can be mounted again afterwards. The filesystem is mounted read-only
+ * so the freeze and the thaw don't need to write to the suspended device.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/dm-ioctl.h>
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
+#include <sys/sysmacros.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+#include "loop_util.h"
+
+#define IMG_SIZE (64 << 20)
+
+FIXTURE(bdev_thaw) {
+	char dir[64];
+	char img[96];
+	char mnt[96];
+	char node[96];
+	char name[32];
+	int loop;
+	int mntfd;
+	bool tmpfs;
+	bool dm;
+	bool suspended;
+	bool mounted;
+};
+
+static int dm_ioctl(unsigned long cmd, const char *name, uint32_t flags, dev_t *dev)
+{
+	struct dm_ioctl dmi = {
+		.version = { DM_VERSION_MAJOR, 0, 0 },
+		.data_size = sizeof(dmi),
+		.data_start = sizeof(dmi),
+		.flags = flags,
+	};
+	int fd, ret = 0;
+
+	strncpy(dmi.name, name, sizeof(dmi.name) - 1);
+	fd = open("/dev/mapper/control", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+	if (ioctl(fd, cmd, &dmi))
+		ret = -errno;
+	else if (dev)
+		*dev = makedev((dmi.dev >> 8) & 0xfff,
+			       (dmi.dev & 0xff) | ((dmi.dev >> 12) & 0xfff00));
+	close(fd);
+	return ret;
+}
+
+/* Remove @name now, or on its last close if udev still has it open. */
+static int dm_remove(const char *name)
+{
+	return dm_ioctl(DM_DEV_REMOVE, name, DM_DEFERRED_REMOVE, NULL);
+}
+
+/* Create @name as a linear mapping of all of @backing and make it live. */
+static int dm_create_linear(const char *name, dev_t backing, uint64_t sectors,
+			    dev_t *dev)
+{
+	struct {
+		struct dm_ioctl dmi;
+		struct dm_target_spec spec;
+		char params[64];
+	} __attribute__((aligned(8))) t = {};
+	int fd, ret;
+
+	ret = dm_ioctl(DM_DEV_CREATE, name, 0, NULL);
+	if (ret)
+		return ret;
+
+	t.dmi.version[0] = DM_VERSION_MAJOR;
+	t.dmi.data_size = sizeof(t);
+	t.dmi.data_start = sizeof(t.dmi);
+	t.dmi.target_count = 1;
+	strncpy(t.dmi.name, name, sizeof(t.dmi.name) - 1);
+	t.spec.length = sectors;
+	strcpy(t.spec.target_type, "linear");
+	snprintf(t.params, sizeof(t.params), "%u:%u 0", major(backing), minor(backing));
+
+	fd = open("/dev/mapper/control", O_RDWR | O_CLOEXEC);
+	if (fd >= 0) {
+		ret = ioctl(fd, DM_TABLE_LOAD, &t) ? -errno : 0;
+		close(fd);
+	} else {
+		ret = -errno;
+	}
+	/* Resuming makes the loaded table live. */
+	if (!ret)
+		ret = dm_ioctl(DM_DEV_SUSPEND, name, 0, dev);
+	if (ret)
+		dm_remove(name);
+	return ret;
+}
+
+static void bdev_thaw_cleanup(FIXTURE_DATA(bdev_thaw) *self)
+{
+	if (self->suspended)
+		dm_ioctl(DM_DEV_SUSPEND, self->name, 0, NULL);
+	if (self->mntfd >= 0)
+		close(self->mntfd);
+	if (self->mounted)
+		umount2(self->mnt, MNT_DETACH);
+	if (self->dm)
+		dm_remove(self->name);
+	if (self->loop >= 0)
+		loop_clear(self->loop);
+	unlink(self->node);
+	unlink(self->img);
+	rmdir(self->mnt);
+	if (self->tmpfs)
+		umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+FIXTURE_SETUP(bdev_thaw)
+{
+	char cmd[160], dev[32];
+	struct stat st;
+	dev_t dmdev;
+	int fd, ret;
+
+	self->loop = -1;
+	self->mntfd = -1;
+	self->tmpfs = false;
+	self->dm = false;
+	self->suspended = false;
+	self->mounted = false;
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+	if (access("/dev/loop-control", R_OK | W_OK))
+		SKIP(return, "test requires loop devices");
+	if (access("/dev/mapper/control", R_OK | W_OK))
+		SKIP(return, "test requires device-mapper");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->dir, sizeof(self->dir), "/tmp/bdev_thaw.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	/* /tmp may be mounted nodev, the dm node needs a tmpfs of our own. */
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", MS_NOSUID | MS_NOEXEC, NULL), 0)
+		rmdir(self->dir);
+	self->tmpfs = true;
+	snprintf(self->img, sizeof(self->img), "%s/img", self->dir);
+	snprintf(self->mnt, sizeof(self->mnt), "%s/mnt", self->dir);
+	snprintf(self->node, sizeof(self->node), "%s/dm", self->dir);
+	snprintf(self->name, sizeof(self->name), "bdev_thaw_%d", getpid());
+	/* The harness doesn't run the teardown when the setup fails. */
+	ASSERT_EQ(mkdir(self->mnt, 0700), 0)
+		bdev_thaw_cleanup(self);
+
+	fd = open(self->img, O_RDWR | O_CREAT | O_CLOEXEC, 0600);
+	ASSERT_GE(fd, 0)
+		bdev_thaw_cleanup(self);
+	ASSERT_EQ(ftruncate(fd, IMG_SIZE), 0)
+		bdev_thaw_cleanup(self);
+
+	snprintf(cmd, sizeof(cmd), "mkfs.ext4 -q -F %s >/dev/null 2>&1", self->img);
+	ret = system(cmd);
+	if (ret) {
+		close(fd);
+		bdev_thaw_cleanup(self);
+		SKIP(return, "mkfs.ext4 failed or is not available");
+	}
+
+	self->loop = loop_bind(fd);
+	close(fd);
+	if (loop_missing(self->loop)) {
+		bdev_thaw_cleanup(self);
+		SKIP(return, "test requires loop devices");
+	}
+	ASSERT_GE(self->loop, 0)
+		bdev_thaw_cleanup(self);
+	snprintf(dev, sizeof(dev), "/dev/loop%d", self->loop);
+	ASSERT_EQ(stat(dev, &st), 0)
+		bdev_thaw_cleanup(self);
+
+	ASSERT_EQ(dm_create_linear(self->name, st.st_rdev, IMG_SIZE >> 9, &dmdev), 0)
+		bdev_thaw_cleanup(self);
+	self->dm = true;
+	ASSERT_EQ(mknod(self->node, S_IFBLK | 0600, dmdev), 0)
+		bdev_thaw_cleanup(self);
+
+	if (mount(self->node, self->mnt, "ext4", MS_RDONLY, NULL)) {
+		if (errno == ENODEV) {
+			bdev_thaw_cleanup(self);
+			SKIP(return, "kernel lacks ext4");
+		}
+		ASSERT_EQ(errno, 0)
+			bdev_thaw_cleanup(self);
+	}
+	self->mounted = true;
+	self->mntfd = open(self->mnt, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(self->mntfd, 0)
+		bdev_thaw_cleanup(self);
+}
+
+FIXTURE_TEARDOWN(bdev_thaw)
+{
+	bdev_thaw_cleanup(self);
+}
+
+TEST_F(bdev_thaw, fithaw_during_dm_suspend)
+{
+	/* A suspend with lockfs freezes the filesystem through bdev_freeze(). */
+	ASSERT_EQ(dm_ioctl(DM_DEV_SUSPEND, self->name, DM_SUSPEND_FLAG, NULL), 0);
+	self->suspended = true;
+
+	/* FITHAW drops the freeze the suspend holds. */
+	if (ioctl(self->mntfd, FITHAW, 0)) {
+		ASSERT_EQ(errno, EINVAL);
+		SKIP(return, "FITHAW doesn't drop a device-mapper freeze");
+	}
+
+	/* The resume's bdev_thaw() finds nothing left to thaw. */
+	ASSERT_EQ(dm_ioctl(DM_DEV_SUSPEND, self->name, 0, NULL), 0);
+	self->suspended = false;
+
+	close(self->mntfd);
+	self->mntfd = -1;
+	ASSERT_EQ(umount2(self->mnt, 0), 0);
+	self->mounted = false;
+
+	ASSERT_EQ(mount(self->node, self->mnt, "ext4", MS_RDONLY, NULL), 0)
+		TH_LOG("device still frozen after the resume: %s", strerror(errno));
+	self->mounted = true;
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/freeze/config b/tools/testing/selftests/filesystems/freeze/config
index 09d86d9bc7d7..d03720cda9a9 100644
--- a/tools/testing/selftests/filesystems/freeze/config
+++ b/tools/testing/selftests/filesystems/freeze/config
@@ -1,7 +1,9 @@
+CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_DEBUG_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_FAIL_MAKE_REQUEST=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_MD=y
 CONFIG_QUOTA=y

-- 
2.53.0

