Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5D385D7D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878907; cv=none; b=PybpOjYJzszDnwS7XKf47p/QMXLVj2M+3vW8L/Rn03wxCTAP0LTtHhOhPNsA/cy1xXQRhlAeRfa65WzPApP/MOoFKDbY4Ps8S9BRgM//DyrphRwnvgX4YHVsnSezDWv8+oiwlgPyzfGx0+D81AKnCyedRsO+VpYxB2beYo+Y/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878907; c=relaxed/simple;
	bh=PjI0OhJSl/5PB11eJGelAcZelEuXgtMIOFIvqC8qWJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnkpEVmH674k1UHIkX2bN2x3NwjboYLNPEW0Qs7lFyGgPtY3FW0OQ0B9hV0oiq/L+DflmjnJ523DvCbv4MGLm4ZKgoyIFvlyStuyWx0AQtLXXqgao1fN9Opr8wuPfQFZwVw8f3oBh9JMosMok9Yb+WVIvN7VKiPcfvKqGHHvY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=qN8iUToH; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="qN8iUToH"
X-KPN-MessageId: cf3c0400-7e1a-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cf3c0400-7e1a-11f1-9e8e-005056999439;
	Sun, 12 Jul 2026 19:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=tXVBxS6hQiHr6/o2NcEDkVQ17EXP1uVe9M4uweG+T1o=;
	b=qN8iUToHjjyrw+K/KuWTUM+LNcuWCLDLBxYQnR+gut7X+YeDmXHoSgcHmsERJN60dAyh6qThwIht0
	 Kk+Qij4b3L6pxu0QURWJRMwGFmXnmBclBQq9pv9z7MJcvwXPZPudyu01IVopWJTYKXWy4kj2bftVyi
	 QOU7RYX4ovTbOMHuRd9CVs+2N2cPTPNqhnUuzI9W+fUhUbXfVhi+nMuwCl94jmCjQgUC5Z3W+Vl18I
	 4OO1Aj2nXQE1PtHgc6GddFMI02Eem3PtDqMZ26DeyLiJ8VgRY6DY3SzFgfJqZ4bC0GTzz9+Ltnhlxw
	 Q5fS+YRDpVXWKfr4KjTXehmvbar8l+w==
X-KPN-MID: 33|fVPvvCTUWInFwMEfjgqJhDWztQI1se/6UUqp/n1vkJ/dhi/EdfZV6tdjq3APKYu
 CwbF7BpvAn330OdYfs+T5JbvktTNOLed7D286B/8g99s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|DO70rQERG5wK1DcR/LTPDYYFY3+Ju/qshoAK7SIJY/MUr55HOGRet8v1s0pGvCQ
 HcoexFzFJ7MeRyIg8mUNQdg==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cf109cb7-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:55:03 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 10/10] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Sun, 12 Jul 2026 19:55:39 +0200
Message-ID: <20260712175539.1565444-11-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
References: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some tests for the new valid O_CREAT|O_DIRECTORY flag combination for
open*(2) to test compliance and to showcase its behaviour.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/open_o_creat_o_dir.c          | 201 ++++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 4 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index a78f894157de..d779a7945cf8 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+open_o_creat_o_dir
 dnotify_test
 devpts_pts
 fclog
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index a7ec2ba2dd83..b60950f8b15c 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+TEST_GEN_PROGS := open_o_creat_o_dir devpts_pts file_stressor anon_inode_test kernfs_test fclog
 TEST_GEN_PROGS += idmapped_tmpfile
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_dir.c b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
new file mode 100644
index 000000000000..0705205c1f92
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/stat.h>
+#include <errno.h>
+#include <limits.h>
+#include <fcntl.h>
+
+#include "kselftest_harness.h"
+#include "wrappers.h"
+
+#define openat_o_mkdir_checked_flags(dfd, pathname, flags) ({	\
+	struct stat __st;						\
+	int __fd = openat_o_mkdir(dfd, pathname, flags, S_IRWXU);	\
+	ASSERT_GE(__fd, 0);						\
+	ASSERT_EQ(fstat(__fd, &__st), 0);				\
+	EXPECT_TRUE(S_ISDIR(__st.st_mode));				\
+	__fd;								\
+})
+
+#define openat_o_mkdir_checked(dfd, pathname) \
+	openat_o_mkdir_checked_flags(dfd, pathname, 0)
+
+FIXTURE(open_o_creat_o_dir) {
+	char dirpath[PATH_MAX];
+	int dfd;
+};
+
+FIXTURE_SETUP(open_o_creat_o_dir)
+{
+	strcpy(self->dirpath, "/tmp/open_o_creat_o_dir_test.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dirpath), NULL);
+	self->dfd = open(self->dirpath, O_DIRECTORY);
+	ASSERT_GE(self->dfd, 0);
+}
+
+FIXTURE_TEARDOWN(open_o_creat_o_dir)
+{
+	close(self->dfd);
+	rmdir(self->dirpath);
+}
+
+/* Does open_o_creat_o_dir return a fd at all? */
+TEST_F(open_o_creat_o_dir, returns_fd)
+{
+	int fd = openat_o_mkdir_checked(self->dfd, "newdir");
+	EXPECT_EQ(close(fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "newdir", AT_REMOVEDIR), 0);
+}
+
+/* The fd must refer to the directory that was just created. */
+TEST_F(open_o_creat_o_dir, fd_is_created_dir)
+{
+	int fd;
+	struct stat st_via_fd, st_via_path;
+	char path[PATH_MAX];
+
+	fd = openat_o_mkdir_checked(self->dfd, "checkdir");
+
+	ASSERT_EQ(fstat(fd, &st_via_fd), 0);
+
+	snprintf(path, sizeof(path), "%s/checkdir", self->dirpath);
+	ASSERT_EQ(stat(path, &st_via_path), 0);
+
+	EXPECT_EQ(st_via_fd.st_ino, st_via_path.st_ino);
+	EXPECT_EQ(st_via_fd.st_dev, st_via_path.st_dev);
+
+	EXPECT_EQ(close(fd), 0);
+	EXPECT_EQ(rmdir(path), 0);
+}
+
+/* Missing parent component must fail with ENOENT. */
+TEST_F(open_o_creat_o_dir, enoent_missing_parent)
+{
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "nonexistent/child", 0, S_IRWXU), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/* An invalid dfd must fail with EBADF. */
+TEST_F(open_o_creat_o_dir, ebadf)
+{
+	EXPECT_EQ(openat_o_mkdir(FD_INVALID, "badfdir", 0, S_IRWXU), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
+/* A dfd that points to a file (not a directory) must fail with ENOTDIR. */
+TEST_F(open_o_creat_o_dir, enotdir_dfd)
+{
+	int file_fd;
+
+	file_fd = openat(self->dfd, "file",
+			 O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+
+	EXPECT_EQ(openat_o_mkdir(file_fd, "subdir", 0, S_IRWXU), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(close(file_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
+}
+
+/*
+ * O_EXCL together with O_CREAT|O_DIRECTORY should succeed if the target
+ * directory does not yet exist. After directory creation, repeating this
+ * call must fail with EEXIST.
+ */
+TEST_F(open_o_creat_o_dir, o_excl_eexist)
+{
+	int excldir_fd;
+
+	excldir_fd = openat_o_mkdir_checked_flags(self->dfd, "excldir", O_EXCL);
+
+	EXPECT_EQ(openat_o_mkdir(excldir_fd, ".", O_EXCL, S_IRWXU), -1);
+	EXPECT_EQ(errno, EEXIST);
+
+	EXPECT_EQ(close(excldir_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "excldir", AT_REMOVEDIR), 0);
+}
+
+/*
+ * O_CREAT|O_DIRECTORY on a path that already exists as a regular file
+ * must fail with ENOTDIR.
+ */
+TEST_F(open_o_creat_o_dir, existing_file_enotdir)
+{
+	int file_fd;
+
+	file_fd = openat(self->dfd, "regfile",
+			 O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+	EXPECT_EQ(close(file_fd), 0);
+
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "regfile", 0, S_IRWXU), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(unlinkat(self->dfd, "regfile", 0), 0);
+}
+
+/*
+ * O_CREAT|O_DIRECTORY combined with a writable access mode must be
+ * rejected: a directory cannot be opened for writing.
+ */
+TEST_F(open_o_creat_o_dir, rejects_writable_acc_mode)
+{
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "rdwrdir", O_RDWR, S_IRWXU), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+	/* Clean up if the kernel created the directory anyway. */
+	unlinkat(self->dfd, "rdwrdir", AT_REMOVEDIR);
+}
+
+/*
+ * openat(O_CREAT|O_DIRECTORY) with a trailing slash should work.
+ */
+TEST_F(open_o_creat_o_dir, trailing_slash)
+{
+	int fd = openat_o_mkdir_checked(self->dfd, "newdir/");
+	EXPECT_EQ(close(fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "newdir", AT_REMOVEDIR), 0);
+}
+
+/*
+ * openat(O_CREAT) with a trailing slash but without O_DIRECTORY
+ * must fail with EISDIR and must not create anything at the path.
+ */
+TEST_F(open_o_creat_o_dir, trailing_slash_no_o_dir)
+{
+	int fd;
+	struct stat st;
+
+	fd = openat(self->dfd, "trailing/", O_CREAT | O_WRONLY, S_IRWXU);
+	EXPECT_EQ(fd, -1);
+	EXPECT_EQ(errno, EISDIR);
+
+	EXPECT_EQ(fstatat(self->dfd, "trailing", &st, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	/* Best-effort cleanup in case the kernel left a file behind. */
+	if (fd >= 0)
+		close(fd);
+	unlinkat(self->dfd, "trailing", 0);
+}
+
+/*
+ * The returned fd must be usable as a dfd for further *at() calls.
+ */
+TEST_F(open_o_creat_o_dir, fd_usable_as_dfd)
+{
+	int parent_fd, child_fd;
+	char path[PATH_MAX];
+
+	parent_fd = openat_o_mkdir_checked(self->dfd, "parent");
+	child_fd = openat_o_mkdir_checked(parent_fd, "child");
+
+	EXPECT_EQ(close(child_fd), 0);
+	EXPECT_EQ(close(parent_fd), 0);
+
+	snprintf(path, sizeof(path), "%s/parent/child", self->dirpath);
+	EXPECT_EQ(rmdir(path), 0);
+	snprintf(path, sizeof(path), "%s/parent", self->dirpath);
+	EXPECT_EQ(rmdir(path), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
index 420ae4f908cf..abe5b85cebdc 100644
--- a/tools/testing/selftests/filesystems/wrappers.h
+++ b/tools/testing/selftests/filesystems/wrappers.h
@@ -13,6 +13,10 @@
 #define STATX_MNT_ID_UNIQUE 0x00004000U /* Want/got extended stx_mount_id */
 #endif
 
+#ifndef FD_INVALID
+#define FD_INVALID -10009
+#endif
+
 static inline int sys_fsopen(const char *fsname, unsigned int flags)
 {
 	return syscall(__NR_fsopen, fsname, flags);
@@ -105,4 +109,11 @@ static inline int sys_open_tree(int dfd, const char *filename, unsigned int flag
 	return syscall(__NR_open_tree, dfd, filename, flags);
 }
 
+static inline int openat_o_mkdir(int dfd, const char *pathname,
+				 unsigned int flags, mode_t mode)
+{
+	return syscall(__NR_openat, dfd, pathname,
+		       flags | O_DIRECTORY | O_CREAT, mode);
+}
+
 #endif
-- 
2.55.0

