Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62313FDC00
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123177; cv=none; b=SRx9kxaNSNdGad+ITv+GnLEnruYwilHll+kZFTW6o03KJ7nz0P0GrER3cOo/ZOM0rq9kBfR3TB4MQMNmhtMt3g5VHfTWshY3nJ/52Cwb9s8gWFP5tzElePoSWYcEfnPFTHE36JLA8ttE17pYXD8Bk89uF/hW/OjkebGGfLesJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123177; c=relaxed/simple;
	bh=cYXb9tzVz/VHufYzBiQa9Tgo040kolVK90OknxNhBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4RDytVyWPeU20mUnMjWmMOnZk6QvQDmhB0dFmY+GpkQoThRnGtL6mnesRShcUOqfrCY95D/EP0Sg/ylmeoiuOV8U7hv2rgEJC48ezcK48CClppDQcnn7F1gyaEA2y3I3KBZ9xsfb5CqRFPFXK3rz3x7OAXFliADiSY49bUBBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WSp2jWq/; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="WSp2jWq/"
X-KPN-MessageId: dbbda82e-52d9-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dbbda82e-52d9-11f1-96a9-005056abbe64;
	Mon, 18 May 2026 18:51:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=IH1gtlgWGlfJooKfwRoEN3A05j7btI9kUPmL/7nJ1hU=;
	b=WSp2jWq/YratPJVti/h4qKAUxHTZcQofTFTq7vPSNXOvCFLgEoxYV8bZDez6bJDEij+V++FHUaYDf
	 RGzx+URPw6wGFHniMkgkaY5CgZq/q4hpKXig7aUOnwJzEsyBwynMe1CTv760s7yTEGQkMw1ssOwrru
	 ZKDSBunqF2d3X6nrZdvKSyQmD+NT4yL+APBOcG03FjT6deFOeh5+eqhma30YLFfRXB7xoDZyJA6hNj
	 0FL7YZ4Bv23iOKCogEQyW9TM+SSe6kKAWxAmZGQPmPVtBUOK7+HoI9tVJoHGjAJFyE01/8/hJr49X8
	 DQT9D8iZrsd5FfUlMA+dir46HNglKYA==
X-KPN-MID: 33|KsEPqyqI5QpkqbUELhaT08E3/lo9wjExjUI+UXGg5hKU42q1aaiq0NzJqWZ9yfV
 7VKoOugOUfunloqgE9TSjxkyVyO0TuOY2uA7i2ERfvA0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|35KU9xZge9zr8SWwdDqZ1f3jyQnBlK3uMlbMwAYdTmSQKLx4hp0Wu4j4tJjq+AQ
 q39fl3IoN3rjsrWxx+B+Buw==
Received: from daedalus.home (unknown [178.227.141.244])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id db7dabd5-52d9-11f1-8011-005056ab7447;
	Mon, 18 May 2026 18:51:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jori.koolstra@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [RFC PATCH v4 2/2] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Mon, 18 May 2026 18:52:37 +0200
Message-ID: <20260518165237.2084042-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518165237.2084042-1-jkoolstra@xs4all.nl>
References: <20260518165237.2084042-1-jkoolstra@xs4all.nl>
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
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_dir.c          | 200 ++++++++++++++++++
 4 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 64ac0dfa46b7..f257b3ddb479 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+open_o_creat_o_dir
 dnotify_test
 devpts_pts
 fclog
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 85427d7f19b9..ec7f93b700d2 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+CFLAGS += $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+TEST_GEN_PROGS := open_o_creat_o_dir devpts_pts file_stressor anon_inode_test kernfs_test fclog
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 551c4a0f395a..33ed59286a2d 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2025 SUSE LLC.
  */
 
+#include <fcntl.h>
 #include <assert.h>
 #include <errno.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_dir.c b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
new file mode 100644
index 000000000000..96edca532e4c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <errno.h>
+#include <limits.h>
+#include <fcntl.h>
+
+#include "kselftest_harness.h"
+
+static inline int open_o_creat_o_dir(int dfd, const char *pathname,
+				     mode_t mode, unsigned int flags)
+{
+	return syscall(__NR_openat, dfd, pathname,
+		       flags | O_DIRECTORY | O_CREAT, mode);
+}
+
+#define open_o_creat_o_dir_checked_flags(dfd, pathname, flags) ({	\
+	struct stat __st;						\
+	int __fd = open_o_creat_o_dir(dfd, pathname, S_IRWXU, flags);	\
+	ASSERT_GE(__fd, 0);						\
+	EXPECT_EQ(fstat(__fd, &__st), 0);				\
+	EXPECT_TRUE(S_ISDIR(__st.st_mode));				\
+	__fd;								\
+})
+
+#define open_o_creat_o_dir_checked(dfd, pathname) \
+	open_o_creat_o_dir_checked_flags(dfd, pathname, 0)
+
+FIXTURE(open_o_creat_o_dir) {
+	char dirpath[PATH_MAX];
+	int dfd;
+};
+
+FIXTURE_SETUP(open_o_creat_o_dir)
+{
+	snprintf(self->dirpath, sizeof(self->dirpath),
+		 "/tmp/open_o_creat_o_dir_test.%d", getpid());
+	ASSERT_EQ(mkdir(self->dirpath, S_IRWXU), 0);
+
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
+	int fd = open_o_creat_o_dir_checked(self->dfd, "newdir");
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
+	fd = open_o_creat_o_dir_checked(self->dfd, "checkdir");
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
+	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "nonexistent/child", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/* An invalid dfd must fail with EBADF. */
+TEST_F(open_o_creat_o_dir, ebadf)
+{
+	EXPECT_EQ(open_o_creat_o_dir(-42, "badfdir", S_IRWXU, 0), -1);
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
+	EXPECT_EQ(open_o_creat_o_dir(file_fd, "subdir", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(close(file_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
+}
+
+/*
+ * O_EXCL together with O_CREAT|O_DIRECTORY must fail with EEXIST when
+ * the target directory already exists.
+ */
+TEST_F(open_o_creat_o_dir, o_excl_eexist)
+{
+	int fd;
+
+	fd = open_o_creat_o_dir_checked_flags(self->dfd, "excldir", O_EXCL);
+	EXPECT_EQ(close(fd), 0);
+
+	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "excldir", S_IRWXU, O_EXCL), -1);
+	EXPECT_EQ(errno, EEXIST);
+
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
+	struct stat st;
+
+	file_fd = openat(self->dfd, "regfile",
+			 O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+	EXPECT_EQ(close(file_fd), 0);
+
+	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "regfile", S_IRWXU, 0), -1);
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
+	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "rdwrdir", S_IRWXU, O_RDWR), -1);
+	EXPECT_EQ(errno, EISDIR);
+	/* Clean up if the kernel created the directory anyway. */
+	unlinkat(self->dfd, "rdwrdir", AT_REMOVEDIR);
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
+	parent_fd = open_o_creat_o_dir_checked(self->dfd, "parent");
+	child_fd = open_o_creat_o_dir_checked(parent_fd, "child");
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
-- 
2.54.0

