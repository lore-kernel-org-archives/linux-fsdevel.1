Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF03F0AA9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527954; cv=none; b=aRQGXo7NDF4GVCTPOECqZ9Ko8aotPkqUFqvQVm/TbOrf3a/NDbXEXe+7ttzU+HLg2YttmWqrtH0Ymb9DzhEO189PhN27YagWJFIPzi7SBAaPGpUAfDjxP9s8LU4ZVoEmI/x22ehq5JckRzBzqXsUSLcGPeUNdIdTbNSmBSMiv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527954; c=relaxed/simple;
	bh=HWk3zLcYEFwp6U3bjVrecRGG3nHQCzM+XFRnic/K4xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2h0SlUP+G0Idt6pA7q+8ZZKqXMKXw24d5+L65RAC4WwuGedSVKW1epPAOnoHH5+t0PCJFRvUb9qsayhb8ZzUDn97s0zxVmdBmgGfjQbUPzuN6dHuHuctP7hrSMqqajgqlJRlbY4aXLf0fEbN0/YWbKuuMd65EQdhNOpVyydKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGW8DWHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGW8DWHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0501F000E9;
	Mon, 15 Jun 2026 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527952;
	bh=IxXBvtJGL8KRQIaHR112Ey64jdkNWH25PREWHBcjbMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SGW8DWHLE1+Fb5Ev+7AH0NsbTGJYYKorQE9egD5WvB38DXp8wXQD3hzFToJNlOnCc
	 GbIJdoOFWvWx0DSEk2y4mFmjzK1xmXN08UITstUn+fxh2VRjcQ2bUdP/7yryEQAVb1
	 /obvfuHkDCHGfgcJbT2lWDkJFRGVMvePxgXxi3bGw8jbe5YEYD7wBxAfdLjlbdUfwH
	 fN2VY+tS7XrU4YhC8j6Np2Fr2vEy2Vb5bk+ousrtwQr8+eiQ1VrOC5cwYRQlWmavcE
	 DC3ywM5R0W4TGGKq4RlKfnPsEp35HNlKhluS3TgNh7THQurKy0SUb2PphVTITVHBFY
	 WTRENOsS7ZVdA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 15 Jun 2026 14:52:19 +0200
Subject: [PATCH 2/2] selftests/filesystems: test O_TMPFILE creation on
 idmapped mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-work-idmapped-tmpfile-v1-2-754a94d81f83@kernel.org>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
In-Reply-To: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-f5839
X-Developer-Signature: v=1; a=openpgp-sha256; l=7073; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HWk3zLcYEFwp6U3bjVrecRGG3nHQCzM+XFRnic/K4xs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpf+2R4qkKlLG6I71y2txOo/iYHcYxry1kNvf8n73mR
 2Z/7+mfHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO58pKR4crL0BlKzQy+a6Rk
 1n645+E9qyW25t+Nfd+/XU70ncgxdxfD/3CLNft8pjQ1HZqhGr1XctqTqA1yt045uBU3z56zwV7
 uMQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a regression test for the fsuidgid_has_mapping() check in
vfs_tmpfile().  It idmaps a detached tmpfs mount so that the
caller-visible id range [0, 10000) maps onto the on-disk range
[10000, 20000) and checks that:

  - a caller whose fsuid/fsgid fall outside that range cannot create an
    O_TMPFILE through the mount and gets -EOVERFLOW instead of an inode
    owned by (uid_t)-1;

  - a mapped caller can create an O_TMPFILE, link it into the namespace,
    and the ownership round-trips through the mount idmap: it is reported
    as 0 through the mount and stored as 10000 on the underlying tmpfs.

The test runs entirely as root and uses setfsuid()/setfsgid() to become
the unmapped caller, so it needs no helper user.  The layer directory is
world-writable so that an unmapped caller still clears the directory
permission check and reaches the fsuidgid_has_mapping() test.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   4 +
 .../selftests/filesystems/idmapped_tmpfile.c       | 168 +++++++++++++++++++++
 3 files changed, 173 insertions(+)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 64ac0dfa46b7..a78f894157de 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -5,3 +5,4 @@ fclog
 file_stressor
 anon_inode_test
 kernfs_test
+idmapped_tmpfile
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 85427d7f19b9..a7ec2ba2dd83 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -2,6 +2,10 @@
 
 CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+TEST_GEN_PROGS += idmapped_tmpfile
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
+
+$(OUTPUT)/idmapped_tmpfile: LDLIBS += -lcap
+$(OUTPUT)/idmapped_tmpfile: utils.c
diff --git a/tools/testing/selftests/filesystems/idmapped_tmpfile.c b/tools/testing/selftests/filesystems/idmapped_tmpfile.c
new file mode 100644
index 000000000000..bc411ab8281e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/idmapped_tmpfile.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/fsuid.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#include <linux/mount.h>
+#include <linux/types.h>
+
+#include "kselftest_harness.h"
+#include "wrappers.h"
+#include "utils.h"
+
+/*
+ * The test mount maps caller-visible ids [0, MAP_RANGE) onto the on-disk range
+ * [MAP_HOST, MAP_HOST + MAP_RANGE).  An id outside [0, MAP_RANGE) therefore has
+ * no mapping in the mount and is not representable in the filesystem.
+ */
+#define MAP_HOST  10000
+#define MAP_RANGE 10000
+#define UNMAPPED  50000
+
+#ifndef MOUNT_ATTR_IDMAP
+#define MOUNT_ATTR_IDMAP 0x00100000
+#endif
+
+#ifndef __NR_mount_setattr
+#define __NR_mount_setattr 442
+#endif
+
+static inline int sys_mount_setattr(int dfd, const char *path,
+				    unsigned int flags,
+				    struct mount_attr *attr, size_t size)
+{
+	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+}
+
+/*
+ * Clone @path into a detached mount idmapped so that caller-visible ids
+ * [0, MAP_RANGE) map onto the on-disk ids [MAP_HOST, MAP_HOST + MAP_RANGE).
+ * Returns the mount fd, or -1 if idmapped mounts are not available.
+ */
+static int idmapped_clone(const char *path)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	int fd_tree, userns_fd, ret;
+
+	fd_tree = sys_open_tree(AT_FDCWD, path,
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (fd_tree < 0)
+		return -1;
+
+	userns_fd = get_userns_fd(MAP_HOST, 0, MAP_RANGE);
+	if (userns_fd < 0) {
+		close(fd_tree);
+		return -1;
+	}
+
+	attr.userns_fd = userns_fd;
+	ret = sys_mount_setattr(fd_tree, "", AT_EMPTY_PATH, &attr, sizeof(attr));
+	close(userns_fd);
+	if (ret) {
+		close(fd_tree);
+		return -1;
+	}
+
+	return fd_tree;
+}
+
+FIXTURE(idmapped_tmpfile) {
+	char dir[64];	/* non-idmapped path to the layer directory */
+};
+
+FIXTURE_SETUP(idmapped_tmpfile)
+{
+	/* Private mount namespace so test mounts need no cleanup. */
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+	ASSERT_EQ(sys_mount("tmpfs", "/tmp", "tmpfs", 0, NULL), 0);
+
+	snprintf(self->dir, sizeof(self->dir), "/tmp/d");
+	ASSERT_EQ(mkdir(self->dir, 0777), 0);
+	/* World-writable so an unmapped caller still passes permission(). */
+	ASSERT_EQ(chmod(self->dir, 0777), 0);
+}
+
+FIXTURE_TEARDOWN(idmapped_tmpfile)
+{
+}
+
+/*
+ * A caller whose fsuid/fsgid have no mapping in the idmapped mount must not be
+ * able to create an O_TMPFILE.  Without the check in vfs_tmpfile() the inode
+ * would be created owned by (uid_t)-1 and could then be linked into the
+ * namespace.
+ */
+TEST_F(idmapped_tmpfile, unmapped_caller_is_refused)
+{
+	int mfd, fd;
+
+	mfd = idmapped_clone(self->dir);
+	if (mfd < 0)
+		SKIP(return, "idmapped mounts not supported");
+
+	/* Become a caller outside the mount's [0, MAP_RANGE) range. */
+	setfsgid(UNMAPPED);
+	setfsuid(UNMAPPED);
+	ASSERT_EQ(setfsuid(-1), UNMAPPED);
+
+	fd = openat(mfd, ".", O_TMPFILE | O_WRONLY, 0644);
+	ASSERT_LT(fd, 0);
+	EXPECT_EQ(errno, EOVERFLOW);
+	if (fd >= 0)
+		close(fd);
+
+	EXPECT_EQ(close(mfd), 0);
+}
+
+/*
+ * A mapped caller can create an O_TMPFILE and link it into the namespace; the
+ * ownership round-trips through the mount idmap.  This is what makes refusing
+ * the unmapped case above necessary in the first place.
+ */
+TEST_F(idmapped_tmpfile, mapped_caller_creates_and_links)
+{
+	char path[PATH_MAX];
+	struct stat st;
+	int mfd, fd;
+
+	mfd = idmapped_clone(self->dir);
+	if (mfd < 0)
+		SKIP(return, "idmapped mounts not supported");
+
+	/* Caller is uid/gid 0, which maps to MAP_HOST through the mount. */
+	fd = openat(mfd, ".", O_TMPFILE | O_RDWR, 0600);
+	ASSERT_GE(fd, 0);
+
+	ASSERT_EQ(fstat(fd, &st), 0);
+	EXPECT_EQ(st.st_uid, 0);
+	EXPECT_EQ(st.st_gid, 0);
+
+	/* The tmpfile is linkable: splice it into the directory. */
+	ASSERT_EQ(linkat(fd, "", mfd, "linked", AT_EMPTY_PATH), 0);
+	EXPECT_EQ(close(fd), 0);
+
+	ASSERT_EQ(fstatat(mfd, "linked", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, 0);
+	EXPECT_EQ(st.st_gid, 0);
+
+	/* On the underlying, non-idmapped tmpfs it is stored as MAP_HOST. */
+	snprintf(path, sizeof(path), "%s/linked", self->dir);
+	ASSERT_EQ(stat(path, &st), 0);
+	EXPECT_EQ(st.st_uid, MAP_HOST);
+	EXPECT_EQ(st.st_gid, MAP_HOST);
+
+	EXPECT_EQ(close(mfd), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3

