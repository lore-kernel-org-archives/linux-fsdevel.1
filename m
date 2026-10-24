Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877698;
	b=etLU38+AJSLepYvSOSdy/agcCuphCqupr17W5NE3/k2dVqUUPrDCO7LcvFsZa54TzYgy
	 KiTEG5+H2SHo4UExXuEpdOW/DihROYLc0x6FBRi8857MRj69hdHlTlnxjPMJjeZMDi0ap
	 IJCBvbPu1CP4gfpf16s0iFL0Fr+hzkesicQP5VaAxegqdaUoR/VB8YcEDhQPNx6w+681f
	 t0p+4aQ9rxzJxmQA+tRqPF4uswYdKliIerXf8mq3mbJY2JXoSi9wShBM8hrR1Lsc4Gj66
	 GkUfiZbjjs4H7nPiXtrK9Abinrbb/MLmC3bKWTABgvhwe6kV8mkDGAs2C8xk1dNKn6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877698;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7Vv0ieeF25gyZx6AsfUMaClvhTZtm8iBvenFR4FwkA=;
	b=cpI6M8s6etqxAKpDEOGW8PCnskdqUaQLiNpYzbSeTTrt7Sb1iBQkAknIvco1sBtObAr5
	 tSkg/7p4LvcjKKUUaRxw31kYNznE0LUUzRRLvaYX9osJCRJAEYrGQC8Veid8sjv3GWCtl
	 x3sirMippnTGJJpE02nNdWYh0dxngb88o1iwA7Ijycef+6FCbjGCI0yQZZjDroo8pHt/h
	 41odn3423WXvec0rrC8jqos36eWMuaPznM7FYQ6GoYyeIUGsBcKha4ATKIikD3ceynK3b
	 dqzuEeGMIsP7stLyImGRcIZl1lcxkVcSTW3GbRpDeYDiqWrLAQSE9uoSEJbFwPRSKMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=Alj5Te3N;
	arc=none smtp.remote-ip=195.121.94.185
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86560A263C
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A86560A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=Alj5Te3N
X-KPN-MessageId: bfecc699-cff2-11f1-9136-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bfecc699-cff2-11f1-9136-005056999439;
	Sat, 24 Oct 2026 23:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=r7Vv0ieeF25gyZx6AsfUMaClvhTZtm8iBvenFR4FwkA=;
	b=Alj5Te3NPWMlw61C0Dwnbw1ySS+rh9k3rKeAe3/7DfHBr/2jnvNMLvtyvsa4xr/XBaIzyHOmh37pC
	 eJFt90+chTWYlsS+Oc8uWEBaw1qO2hFCp8De//Q7nHMJ7ifQ7ld4jSyqFtYUKmOywv5pDBAMusfHZg
	 XIGKCYaJl6+cP881oDYDrOw4zCT0rIb2s9US27eEQbCvlQcQ8lH27pdYMPkgTcquLnetefi2hIn6fh
	 eVQUH/vYkxuAJhpCZIlMh/413Fjh25e1W+BqLzhPnu8MdN+jAvUCfKb62KAHhPz46Ewf4PHGUqNnNf
	 WugMUV9eoN3I94tPte2PnyyKZaJTQNg==
X-KPN-MID: 33|FjpL0HUep1z0zVQmwKAit4V9sNiVE1sVdl3QrYsHtMNwykDiJ6QI/YyURmGEC8f
 TDn2h0e0ClLHpWvJdmQie3mIThVzt+lXN3y5ana4TYUg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rnDTcfiTbZI90nIyzP46tHsz1/GFBV2UJvMM/JM1FBT4u1L2zifPdRC+dlUJcPa
 sDy09AsDOJnh1PXYQTbnR5g==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id bfaebb9f-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:53 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 12/12] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Sat, 24 Oct 2026 23:35:39 +0200
Message-ID: <20261024213539.1307600-13-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some tests for the new valid O_CREAT|O_DIRECTORY flag combination for
open*(2) to test compliance and to showcase its behaviour.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/open_o_creat_o_dir.c          | 346 ++++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 4 files changed, 359 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index cf79000e4092..8ccf7a5f9ec9 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+open_o_creat_o_dir
 dnotify_test
 devpts_pts
 fclog
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index fbd5c27505ef..004b946fd2e0 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts anon_inode_test kernfs_test fclog ustat_test rw_hint_test
+TEST_GEN_PROGS := devpts_pts anon_inode_test kernfs_test fclog ustat_test rw_hint_test open_o_creat_o_dir 
 TEST_GEN_PROGS += idmapped_tmpfile
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_dir.c b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
new file mode 100644
index 000000000000..93c0f4dea266
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/stat.h>
+#include <sys/vfs.h>
+#include <errno.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/magic.h>
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
+ * O_CREAT|O_DIRECTORY without O_EXCL must fail with EINVAL and must not
+ * create anything at the path.
+ */
+TEST_F(open_o_creat_o_dir, requires_o_excl)
+{
+	struct stat st;
+
+	EXPECT_EQ(openat(self->dfd, "noexcl", O_CREAT | O_DIRECTORY | O_RDONLY,
+			 S_IRWXU), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	EXPECT_EQ(fstatat(self->dfd, "noexcl", &st, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/*
+ * Once the directory exists, repeating O_CREAT|O_DIRECTORY|O_EXCL must
+ * fail with EEXIST.
+ */
+TEST_F(open_o_creat_o_dir, existing_dir_eexist)
+{
+	int excldir_fd;
+
+	excldir_fd = openat_o_mkdir_checked(self->dfd, "excldir");
+
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "excldir", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EEXIST);
+
+	EXPECT_EQ(close(excldir_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "excldir", AT_REMOVEDIR), 0);
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
+ * O_EXCL means a trailing symlink is never followed, so O_CREAT|O_DIRECTORY
+ * must refuse to create through a dangling one, and must not create
+ * anything at the symlink target.
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
+ * A trailing symlink is an existing entry, even if it resolves to a
+ * directory, so O_CREAT|O_DIRECTORY must fail with EEXIST.
+ */
+TEST_F(open_o_creat_o_dir, symlink_to_dir_eexist)
+{
+	ASSERT_EQ(mkdirat(self->dfd, "realdir", 0700), 0);
+	ASSERT_EQ(symlinkat("realdir", self->dfd, "dirlink"), 0);
+
+	EXPECT_EQ(openat_o_mkdir(self->dfd, "dirlink", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EEXIST);
+
+	EXPECT_EQ(unlinkat(self->dfd, "dirlink", 0), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "realdir", AT_REMOVEDIR), 0);
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
+/*
+ * Open the first of @paths that is a mounted filesystem of type @magic.
+ * Returns -1 if there is none.
+ */
+static int open_fs_root(const char *const *paths, long magic)
+{
+	for (; *paths; paths++) {
+		struct statfs sfs;
+		int fd;
+
+		fd = open(*paths, O_DIRECTORY | O_RDONLY);
+		if (fd < 0)
+			continue;
+		if (!fstatfs(fd, &sfs) && sfs.f_type == magic)
+			return fd;
+		close(fd);
+	}
+	return -1;
+}
+
+/*
+ * kernfs: O_CREAT|O_DIRECTORY on cgroup2 must create a cgroup and return a
+ * fd to that very cgroup.
+ */
+TEST(kernfs_cgroup2)
+{
+	static const char *const paths[] = {
+		"/sys/fs/cgroup", "/sys/fs/cgroup/unified", NULL
+	};
+	struct stat st_fd, st_path;
+	int root_fd, fd, procs_fd;
+	char name[64];
+
+	if (geteuid() != 0)
+		SKIP(return, "needs root to create a cgroup");
+	root_fd = open_fs_root(paths, CGROUP2_SUPER_MAGIC);
+	if (root_fd < 0)
+		SKIP(return, "cgroup2 is not mounted");
+
+	snprintf(name, sizeof(name), "open_o_creat_o_dir.%d", getpid());
+
+	fd = openat_o_mkdir_checked(root_fd, name);
+
+	/* The fd refers to the cgroup that is now visible at the name. */
+	ASSERT_EQ(fstat(fd, &st_fd), 0);
+	ASSERT_EQ(fstatat(root_fd, name, &st_path, 0), 0);
+	EXPECT_EQ(st_fd.st_ino, st_path.st_ino);
+	EXPECT_EQ(st_fd.st_dev, st_path.st_dev);
+
+	/* It is a populated cgroup, not just an empty directory. */
+	procs_fd = openat(fd, "cgroup.procs", O_RDONLY);
+	EXPECT_GE(procs_fd, 0);
+	if (procs_fd >= 0)
+		EXPECT_EQ(close(procs_fd), 0);
+
+	EXPECT_EQ(close(fd), 0);
+	EXPECT_EQ(unlinkat(root_fd, name, AT_REMOVEDIR), 0);
+	EXPECT_EQ(close(root_fd), 0);
+}
+
+/*
+ * tracefs sets SB_I_NO_ATOMIC_MKDIR: O_CREAT|O_DIRECTORY is refused with
+ * EOPNOTSUPP before any lookup, whether or not the name exists, and
+ * creates nothing.
+ */
+TEST(tracefs_eopnotsupp)
+{
+	static const char *const paths[] = {
+		"/sys/kernel/tracing", "/sys/kernel/debug/tracing", NULL
+	};
+	int tracing_fd, inst_fd;
+	char name[64];
+	struct stat st;
+
+	if (geteuid() != 0)
+		SKIP(return, "needs root to access tracefs");
+	tracing_fd = open_fs_root(paths, TRACEFS_MAGIC);
+	if (tracing_fd < 0)
+		SKIP(return, "tracefs is not mounted");
+	inst_fd = openat(tracing_fd, "instances", O_DIRECTORY | O_RDONLY);
+	if (inst_fd < 0) {
+		close(tracing_fd);
+		SKIP(return, "no tracefs instances directory");
+	}
+
+	snprintf(name, sizeof(name), "open_o_creat_o_dir.%d", getpid());
+
+	/* Nonexistent name, where mkdir(2) would create an instance */
+	EXPECT_EQ(openat_o_mkdir(inst_fd, name, O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(fstatat(inst_fd, name, &st, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	/* Existing name */
+	EXPECT_EQ(openat_o_mkdir(tracing_fd, "instances", O_RDONLY, S_IRWXU), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+
+	EXPECT_EQ(close(inst_fd), 0);
+	EXPECT_EQ(close(tracing_fd), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
index 420ae4f908cf..bc58bdb80063 100644
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
+		       flags | O_DIRECTORY | O_CREAT | O_EXCL, mode);
+}
+
 #endif
-- 
2.56.0

