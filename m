Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E83955E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740935; cv=none; b=JrdvYounoXFQNVbanQlmn9arE4+3dvOc3uyNr6w4xXBRgNBv1TKwT+ifi8awSA9WkL+le+5cAq3/kbAddqFk/RkwAKaYPFlatizrOkqt3uO6rt+0WkmTtDulJyJGGd2B8zz98QdonJJuDmYqbGMD//bC6JcWMXPLeS2g2gfh7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740935; c=relaxed/simple;
	bh=dn6SihIUPLWOfN26dYAPACiqQ49/1rU1058g0P6VrIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOaUTCPnBKHT8tAW7OsWx8jchO5zOokuneOna/JIx4C5NULtasiPqxfGxKXMmY2OLd0MA4T+fCc9pCkyTQ4pNmn/9iEZE+Ymei6Me2CcCq6n8Krh6d1aKK3NpF0P1oZowvuwm9CWU7ebG5kO0Xg7o2fI7GnFFTzpAU6QmJADETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=A0nJllXD; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="A0nJllXD"
X-KPN-MessageId: 547cd407-5878-11f1-8ff5-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 547cd407-5878-11f1-8ff5-005056999439;
	Mon, 25 May 2026 22:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=34ZFfcPo/wCV7rUgvNIeW6wK60MzzQzVDVItofBMs5I=;
	b=A0nJllXDs2kjwEpMg2XUVkB93NeqYGcH+hAeskuhHe+rKwcHxUYlAIjqmb16fn0NqrPda47BYblj0
	 5a7WVraHGU0Y9TAq60YKqLlijyETzPylLgqLw7i9mxhcs7kQiYtnfu670hL3EGmhPClIpUQ7h2CWBG
	 mHx4ZQrfcEy5BiBZbuQ9xRWKo9zW1aSermBxnc7I39+82r6VazDgfiLpWmTSmVyoC/UDHRRCUAF7sw
	 kkg0bhw3Zcd6Cy19KAZLfhYAYRXuhfJ3sLgnIwrEnlogVIYGl6SgMF5pHHyuATtzg3x2umdoJiSiQk
	 SN4XT+ApHN6ILjbA3gZQUmgmKnyoK7g==
X-KPN-MID: 33|PQvLkVrMS17QiaaIQwCRDxwfyj8uR7X9ssG9LxBI1oI7aCYFGoElyQOJQjiGBOW
 yInloYCjycSwh7TmIYYRV1RHiNKP/vVA1IRf60TvK7AQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6zVCsksfs4lBbdbUOMlEqFXNQYc8me1xfzBXuVERJHIhszEajPJXyhNwJBT3Ru3
 rlkAzqh/RivAxKuzVvPwn/w==
Received: from daedalus.home (unknown [178.227.141.192])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 543d1e46-5878-11f1-bffc-00505699772e;
	Mon, 25 May 2026 22:28:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Subject: [RFC PATCH v5 2/2] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Mon, 25 May 2026 22:29:37 +0200
Message-ID: <20260525202937.466497-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202937.466497-1-jkoolstra@xs4all.nl>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
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
 .../filesystems/open_o_creat_o_dir.c          | 197 ++++++++++++++++++
 4 files changed, 201 insertions(+), 2 deletions(-)
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
index 000000000000..03b5edcffeef
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
@@ -0,0 +1,197 @@
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
+	ASSERT_EQ(fstat(__fd, &__st), 0);				\
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

