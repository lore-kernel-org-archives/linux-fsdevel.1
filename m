Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878793E5A19
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747356; cv=none; b=gNNDuh3oTyH4g06KN/rkMEORLIPenf47C9GY6fdGOipwD7lQCOaGcPRNExMmOPm69HSGaCCY9yDl/Ax2rPODdIjhqBnhGOxDJUidFaL5dI196fJLKUYXhLvVAAjt0hALdu5CXzXdBbAlKFlCyFVjKCIs2yep+UTuzgXnFmJjAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747356; c=relaxed/simple;
	bh=Pf/vRGtY47BgZSahJUAla8d1PiWv5EXFP0OQZKeH8V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQDI9EeXM6zTDLwV6LF5jIh6NV78hMOS52n4Dfgsh00zzEPYgIRYz+yDU41fkXuvNzFjATOvsoOvP599tGdl5Gbek1IqM2Zwg/BJyXhjvJ9drYPViqnR2avhmXvz3lVFxHlrPyEB4pVeGb5gTiLCJ9WN5iL8XwPiH7dMUp8ILWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZMZ96+MK; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZMZ96+MK"
X-KPN-MessageId: 36607c5e-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 36607c5e-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ec62ArFLan74w7nj3jyWahMZq+7Vg/0iXEt+aO1wcBA=;
	b=ZMZ96+MKEBTdtpCQPFlkRQ7/x3lwW5aGcZFnP9BJqAw3TpUYqb78PWWcm2YwJQma4XYV64ljeZ1Mw
	 a3wBqLxXTvAIrcgNB4Zsue9UbzIiJ1/XyF+kkHHXXSRkNRW/lO0j+Yf3h1P50qOBNOF2ZqDbQJOcu0
	 OqsWI8hV/tshawFtHi+F8obN7M8/fd1ScwGAPVlpvZ6U03RXnpSAsSmo0HSatv3YJaZvZIjXHLTsSV
	 yBzspAk5xHg8F/78EqB1UxaQsrGf1uSZW+ASFE66hYGZQqbajlDiuvpRJD5JBpEgu5SY7wTA87hKmd
	 7393GcwHP2AoyJIjABf4ioyMm5CcAmQ==
X-KPN-MID: 33|CcJ1og84/eIYxNDFiuYrG8pCTx1SwkLcNTim2lw5L4AzC9rPnkfkrP1Z2veM19H
 ZeUU6JST5JUXdidFQTPdxmMXw2Rl6ijsFLdJfVfriUYQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|At7/DuvyII+6HZPZhfUCDFCpEgupviASvJz1VlDOi8cdJP5z66stPiLEMPipmWD
 TSgZdtv+WApaxyThSARwnwQ==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 362b6611-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:52 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 14/14] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Mon, 29 Jun 2026 17:36:30 +0200
Message-ID: <20260629153630.2158649-15-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
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
 .../filesystems/open_o_creat_o_dir.c          | 197 ++++++++++++++++++
 3 files changed, 199 insertions(+), 1 deletion(-)
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
index 85427d7f19b9..645c52d2d4de 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+TEST_GEN_PROGS := open_o_creat_o_dir devpts_pts file_stressor anon_inode_test kernfs_test fclog
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_dir.c b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
new file mode 100644
index 000000000000..df3cdbae2c85
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
+	EXPECT_EQ(errno, ENOTDIR);
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

