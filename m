Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952883FB7E0
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325393; cv=none; b=pssI+N6yQ0kIz+ftAeuSe7MSIbp3zDqJzaEohhpwrA7Rg/x4tMKSMe02VngsE4m/fofz/br0WS7CdalfavZfctrEvWU/UpiubFqLNruF/QNOeJjEE1PdOzKeatvhF3TrlkTBTgd4L7/yanHQ5XjDJxuPeU55syv0L5y8UHCmVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325393; c=relaxed/simple;
	bh=gj8FpkHlNchhad14rh8EiQmkgwFXQ7brK5SW03B67jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT6bR2S3bs+R7DUMDd0TYPcFW8eipLgV7PdecJEX3wzjXbGAn0oJrIzF0dvJLlAk8B4ZXmfFD7pgVQazodEOqDJVJZMi5Bgu/WZYgClT7E77wQ7lMAxZRwq2eV+8G0f3GfPcPpAfBKbBVpmUdHossXtkbL2TRk36Cz+9yDyWrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=YgI9kZ/K; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="YgI9kZ/K"
X-KPN-MessageId: e3c6b669-afa3-11f1-83b4-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e3c6b669-afa3-11f1-83b4-005056ab378f;
	Sun, 13 Sep 2026 20:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=1IpoTYMP5XRS0Wf6GLJilFPg/98gMh0ulmw5TiujizI=;
	b=YgI9kZ/KoM+R3qGqyCTf3RLqmocCUA9WRPMH69B4uU4xnHTagYqSjKaFOTdROFxn6DH/gCi1ZaZht
	 Np8eo9LM0+QoBK3+2gXplT5UYbhNtDwMIEYxaI5tPi/lI5ahh61vxgitrEjL/7q453MNBKSBP2bPfd
	 AYXeN1jA8djzPVs3coAm0o4g+x6pwRQnE5+snGTGBSyW/tL6ShurKoXgsKcEMroG/VKSxhhnteqOHb
	 zIrBadalXDxdF0NXzm+R0otBuvPN1Qfqo6UJ+zV67QKj1tJg5KnaFM4IN/rk+Mvj4ywbLiZ3DdCJO3
	 sY9Vyqwu6mjhqBvXNB4n1s6kpu2jwJg==
X-KPN-MID: 33|ldoESv9g3OVOzxiIcxj7sWh6WP0D2bmUBHncWy/7ao0bf0otTwKKD7tla01awFw
 NMPCMGxK1ATK23pEgWCu2ZbsfGP1MIvHSzdL/Ekqm6Kg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|lsZE0lg7Soh+BV+Erg8/LCoEAP3VSULJbzBQQIYRlOoJlh/i2hHyIQC3hRFabKG
 qAOSmDNiGYr0SFP+HZJCyJQ==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e38b5477-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 12/12] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Sun, 13 Sep 2026 20:50:16 +0200
Message-ID: <20260913185016.523376-13-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
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
 .../filesystems/open_o_creat_o_dir.c          | 296 ++++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 4 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 9eb185fb2f9d..01c588d4c84f 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+open_o_creat_o_dir
 dnotify_test
 devpts_pts
 fclog
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 03be337c1f35..0959bd26875a 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test
+TEST_GEN_PROGS := open_o_creat_o_dir devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test
 TEST_GEN_PROGS += idmapped_tmpfile
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_dir.c b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
new file mode 100644
index 000000000000..538a7f7c5803
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
@@ -0,0 +1,296 @@
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
+	openat_o_mkdir_checked_flags(dfd, pathname, O_RDONLY)
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
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "nonexistent/child", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/* An invalid dfd must fail with EBADF. */
+TEST_F(open_o_creat_o_dir, ebadf)
+{
+	EXPECT_EQ(openat_o_mkdir(FD_INVALID, "badfdir", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
+/* A dfd that points to a file (not a directory) must fail with ENOTDIR. */
+TEST_F(open_o_creat_o_dir, enotdir_dfd)
+{
+	int file_fd;
+
+	file_fd = openat(self->dfd, "file",
+			 O_CREAT | O_RDONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+
+	EXPECT_EQ(openat_o_mkdir(file_fd, "subdir", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(close(file_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
+}
+
+/*
+ * O_EXCL together with O_CREAT|O_DIRECTORY should succeed if the target
+ * directory does not yet exist. After directory creation, repeating this
+ * call must fail with EEXIST, but should succeed if the O_EXCL is dropped.
+ */
+TEST_F(open_o_creat_o_dir, o_excl_eexist)
+{
+	int excldir_fd;
+
+	excldir_fd = openat_o_mkdir_checked_flags(self->dfd, "excldir", O_EXCL);
+
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "excldir", O_EXCL, S_IRWXU), -1);
+	EXPECT_EQ(errno, EEXIST);
+
+	int excldir_reopen_fd = openat_o_mkdir_checked(self->dfd, "excldir");
+
+	EXPECT_EQ(close(excldir_reopen_fd), 0);
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
+			 O_CREAT | O_RDONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+	EXPECT_EQ(close(file_fd), 0);
+
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "regfile", O_RDONLY, S_IRWXU), -1);
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
+	fd = openat(self->dfd, "trailing/", O_CREAT | O_RDONLY, S_IRWXU);
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
+/*
+ * O_CREAT|O_DIRECTORY must refuse to create through a dangling trailing
+ * symlink, and must not create anything at the symlink target.
+ */
+TEST_F(open_o_creat_o_dir, dangling_symlink_eexist)
+{
+	struct stat st;
+
+	ASSERT_EQ(symlinkat("danglink_target", self->dfd, "danglink"), 0);
+
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "danglink", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EEXIST);
+
+	/* Nothing must have been created at the target. */
+	EXPECT_EQ(fstatat(self->dfd, "danglink_target", &st, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	EXPECT_EQ(unlinkat(self->dfd, "danglink", 0), 0);
+}
+
+/*
+ * A trailing symlink that resolves to an existing directory must still open.
+ */
+TEST_F(open_o_creat_o_dir, symlink_not_dangling_ok)
+{
+	int fd;
+
+	ASSERT_EQ(mkdirat(self->dfd, "realdir", 0700), 0);
+	ASSERT_EQ(symlinkat("realdir", self->dfd, "dirlink"), 0);
+
+	/* Trailing symlink resolving to an existing directory. */
+	fd = openat_o_mkdir_checked(self->dfd, "dirlink");
+	EXPECT_EQ(close(fd), 0);
+
+	EXPECT_EQ(unlinkat(self->dfd, "dirlink", 0), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "realdir", AT_REMOVEDIR), 0);
+}
+
+/*
+ * An O_CREAT|O_DIRECTORY open of an existing directory owned by someone else,
+ * inside a sticky world-writable directory, must be refused.
+ */
+TEST_F(open_o_creat_o_dir, sticky_dir_eacces)
+{
+	int sticky_fd, fd;
+
+	if (geteuid() != 0)
+		SKIP(return, "needs root for fchownat");
+
+	ASSERT_EQ(mkdirat(self->dfd, "sticky", 01777), 0);
+	ASSERT_EQ(fchmodat(self->dfd, "sticky", 01777, 0), 0);
+	sticky_fd = openat(self->dfd, "sticky", O_DIRECTORY | O_RDONLY);
+	ASSERT_GE(sticky_fd, 0);
+
+	ASSERT_EQ(mkdirat(sticky_fd, "otherdir", 0700), 0);
+	if (fchownat(sticky_fd, "otherdir", 1, 1, 0)) {
+		int err = errno;
+
+		unlinkat(sticky_fd, "otherdir", AT_REMOVEDIR);
+		close(sticky_fd);
+		unlinkat(self->dfd, "sticky", AT_REMOVEDIR);
+		SKIP(return, "cannot chown to uid 1: %s", strerror(err));
+	}
+
+	EXPECT_EQ(openat_o_mkdir(sticky_fd, "otherdir", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EACCES);
+
+	/* Without O_CREAT the very same open must still succeed. */
+	fd = openat(sticky_fd, "otherdir", O_DIRECTORY | O_RDONLY);
+	EXPECT_GE(fd, 0);
+	if (fd >= 0) {
+		EXPECT_EQ(close(fd), 0);
+	}
+
+	EXPECT_EQ(unlinkat(sticky_fd, "otherdir", AT_REMOVEDIR), 0);
+	EXPECT_EQ(close(sticky_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "sticky", AT_REMOVEDIR), 0);
+}
+
+/*
+ * O_TMPFILE is encoded as __O_TMPFILE|O_DIRECTORY.  Now that O_CREAT is no
+ * longer rejected alongside O_DIRECTORY, O_TMPFILE|O_CREAT must still be
+ * rejected explicitly so that it cannot create a persistent file on kernels
+ * that predate O_TMPFILE.
+ */
+TEST_F(open_o_creat_o_dir, tmpfile_with_o_creat_einval)
+{
+	EXPECT_EQ(openat(self->dfd, ".", O_TMPFILE | O_CREAT | O_RDWR, S_IRWXU),
+		  -1);
+	EXPECT_EQ(errno, EINVAL);
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

