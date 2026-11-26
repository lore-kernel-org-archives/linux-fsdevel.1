Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693276;
	b=Xz3ZH0oDudp/MJOpeFZ3nJOGfrX630jMmFLrIGeiopG882W6kMmVgamWEE2bkN3Uf12l
	 ykt3iHjeM7NG5NiKmnbiYe0Y9laoCXdCdjJMP3pJKUly5KFdOPNOdGMZiP36dz/DJwaP2
	 Ftwyn+/MpvKjVlEqFGeNbcmnpYz2RQfWgYngZGKSX3r6NJgpRgx1WwxVEOE53zxiC3rL9
	 GYK5b4g4pmqgMrPZ+K0I57/nxsG9yWS7kegAnF1P4+/zXcmM6GU6wb+nxOz4utD97LwzO
	 Y3/8MSyKgJ0xm8GTFsTAM3NrWogsi9vssBHuGhMTiN9YXU4iiGo+1wmQ/T5jDRLRiTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693276;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aspoYAJjlG/SinBd3ZyrEb/HtxoYu3xjnfbAcn612Mg=;
	b=HSKTATCSZOHKzRIPanKavMVXA/aq3c38kAkVp9ZeO6k7YnJvve4UiV9UGNdleKxMLjZ2
	 YPXQFNNsTRhj8tvjMYRFWBL4RAXJptz2FbbdEHU3o0LbKO9frXwuFwuZPdsIqt1zCpDXq
	 PlMsRCkOGzCYeuZne24ulPpAa14MSCkUQ/YzYS6RKniIilqXwDotGvdjYuY1RhKYPJN3C
	 kj9qcAxeEeeicgPjCJwSV8A9k+KUHQXiQWjaLIYckgriM3s/wdEJr8TBtRjxFYgu9d5oQ
	 3KtBCyT4CGdO+vJ3T0JMcshdGmXuPaf1UkeO2Fl0LmkXI7HnDmyUbGA0XcC4nfzssGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cU3XX6Ag;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EC606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cU3XX6Ag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848D31F000D3;
	Thu, 26 Nov 2026 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693275;
	bh=aspoYAJjlG/SinBd3ZyrEb/HtxoYu3xjnfbAcn612Mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cU3XX6AgPtpfN0qlRUnSOLd+ouc44djHaet+4yXD3Oiz8GN4LNNgfYak357pOt0ea
	 hZgsu+4nIrKgDeYFXSvvRvdP+5GbpczLbv0et5UAnlKML5kzjCXULaEkfQ+WOCKV9E
	 V4Pws1NJhFPq2Cukh6SgkFQTd8bkZwoOX8b37kWgRRRV6TihnaexISaYpOcKbWrFGT
	 NUsdhJhiLY5G7QjXgJlVFJpIoyPVBhXe3I6lkRkzdbcTW5IOz9iE6DiIAbidLuD8t+
	 qLY1pMwOTiR/To/0VLWZJhE42f0UdaC1I7uCd3nTI+VKh1OIC9a71hHPCpd9Zlt6XH
	 KaMeu6J+LKmOw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 12:40:34 +0100
Subject: [PATCH 2/2] selftests/filesystems: check that ephemeral procfs
 files can be bind-mounted
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-work-mount-cant_mount-v1-2-781d911a32e1@kernel.org>
References: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
In-Reply-To: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=10279; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rP5RKQCFYJTLUgYCgClhcAgMIqo3Vgt2N6gl3Apla34=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzSF3qjfn2fG+k4hfdY8LrhJklN857kMotK9m/6pDlP
 ElN83/VHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpXMfI8Pln6hxNJ5bAWnmv
 /ET2Gd4H2/NYV59L735zb62FRDRXPSPDikU+Jcc/R3SwdvJ05q9W73wn+DN46lXOXyWpMQ8TKx3
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Check that the ephemeral procfs files can be the source of a mount but
can't be mounted on:

- bind mounts of fd, fdinfo and net files, including over /proc/self/exe
  as libpathrs does
- open_tree() and move_mount() of an fdinfo file
- moving a mount of an fdinfo file from a slave to its master
- mounting on top of an fdinfo file
- moving an fdinfo file beneath a mount
- a propagated copy that would end up beneath a mount in a slave
- the same after a peer got its copy

The last four have to keep failing with ENOENT.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +-
 .../filesystems/mount_cycle/procfs_source_test.c   | 283 +++++++++++++++++++++
 3 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
index 30f7dd071bcbb..514e7295abb4b 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -6,3 +6,4 @@ mount_cover_test
 locked_handle_test
 nsfs_rbind_loop_test
 overmount_ns_file_test
+procfs_source_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
index fbe8c5e19d424..a2afe7090556a 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := loop_cycle_test unmounted_tree_test overmount_reparent_test mount_cover_test locked_handle_test
-TEST_GEN_PROGS += nsfs_rbind_loop_test overmount_ns_file_test
+TEST_GEN_PROGS += nsfs_rbind_loop_test overmount_ns_file_test procfs_source_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/filesystems/mount_cycle/procfs_source_test.c b/tools/testing/selftests/filesystems/mount_cycle/procfs_source_test.c
new file mode 100644
index 0000000000000..ece21f22e589e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/procfs_source_test.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The files in /proc/<pid>/fd, /proc/<pid>/fdinfo and below /proc/<pid>/net
+ * can't be mounted on but they can be bind-mounted elsewhere.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+
+#include "../wrappers.h"
+#include "../../kselftest_harness.h"
+
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 0x00000200
+#endif
+
+#define DIR_LEN 64
+#define PATH_LEN 128
+
+/* Open the procfs file itself, not the file it refers to. */
+static int open_entry(const char *dir, int fd)
+{
+	char path[PATH_LEN];
+
+	snprintf(path, sizeof(path), "/proc/self/%s/%d", dir, fd);
+	return open(path, O_PATH | O_NOFOLLOW | O_CLOEXEC);
+}
+
+static int bind_entry(int pfd, const char *target)
+{
+	char src[PATH_LEN];
+
+	snprintf(src, sizeof(src), "/proc/self/fd/%d", pfd);
+	return mount(src, target, NULL, MS_BIND, NULL);
+}
+
+/* An fdinfo file starts with the position of the file. */
+static bool is_fdinfo(const char *path)
+{
+	char buf[5] = {};
+	int fd;
+	bool ret;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+	ret = read(fd, buf, 4) == 4 && !strcmp(buf, "pos:");
+	close(fd);
+	return ret;
+}
+
+/* A shared tmpfs on @dir/a with a slave on @dir/b, both showing a file f. */
+static int setup_slave(const char *dir, char *af, char *bf)
+{
+	char a[PATH_LEN], b[PATH_LEN];
+
+	snprintf(a, sizeof(a), "%s/a", dir);
+	snprintf(b, sizeof(b), "%s/b", dir);
+	snprintf(af, PATH_LEN, "%s/a/f", dir);
+	snprintf(bf, PATH_LEN, "%s/b/f", dir);
+	if (mkdir(a, 0755) || mkdir(b, 0755) ||
+	    mount("tmpfs", a, "tmpfs", 0, NULL) ||
+	    mount(NULL, a, NULL, MS_SHARED, NULL) ||
+	    mount(a, b, NULL, MS_BIND, NULL) ||
+	    mount(NULL, b, NULL, MS_SLAVE, NULL))
+		return -1;
+	return mknod(af, S_IFREG | 0644, 0);
+}
+
+FIXTURE(procfs_source) {
+	char dir[DIR_LEN];
+	char file[PATH_LEN];
+	int fd;
+};
+
+FIXTURE_SETUP(procfs_source)
+{
+	if (geteuid())
+		SKIP(return, "test requires root");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	snprintf(self->dir, sizeof(self->dir), "/tmp/procfs_source.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
+	snprintf(self->file, sizeof(self->file), "%s/file", self->dir);
+	self->fd = open(self->file, O_RDWR | O_CREAT | O_CLOEXEC, 0644);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(procfs_source)
+{
+	umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+TEST_F(procfs_source, bind_fd)
+{
+	struct stat st;
+	int pfd;
+
+	pfd = open_entry("fd", self->fd);
+	ASSERT_GE(pfd, 0);
+	ASSERT_EQ(bind_entry(pfd, self->file), 0);
+	ASSERT_EQ(lstat(self->file, &st), 0);
+	ASSERT_TRUE(S_ISLNK(st.st_mode));
+	close(pfd);
+}
+
+TEST_F(procfs_source, bind_fdinfo)
+{
+	int pfd;
+
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	ASSERT_EQ(bind_entry(pfd, self->file), 0);
+	ASSERT_TRUE(is_fdinfo(self->file));
+	close(pfd);
+}
+
+/* An entry below /proc/<pid>/net can't be mounted on either. */
+TEST_F(procfs_source, bind_net)
+{
+	char buf[7] = {};
+	int fd;
+
+	if (access("/proc/self/net/dev", F_OK))
+		SKIP(return, "no /proc/self/net/dev");
+	ASSERT_EQ(mount("/proc/self/net/dev", self->file, NULL, MS_BIND, NULL), 0);
+	fd = open(self->file, O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(read(fd, buf, 6), 6);
+	ASSERT_STREQ(buf, "Inter-");
+	close(fd);
+}
+
+/* What libpathrs does to test that it notices overmounts in procfs. */
+TEST_F(procfs_source, bind_fd_on_exe)
+{
+	char target[PATH_LEN];
+	int pfd, exe;
+
+	exe = open("/proc/self/exe", O_PATH | O_NOFOLLOW | O_CLOEXEC);
+	ASSERT_GE(exe, 0);
+	pfd = open_entry("fd", self->fd);
+	ASSERT_GE(pfd, 0);
+	snprintf(target, sizeof(target), "/proc/self/fd/%d", exe);
+	ASSERT_EQ(bind_entry(pfd, target), 0);
+	close(pfd);
+	close(exe);
+}
+
+TEST_F(procfs_source, open_tree_fdinfo)
+{
+	int pfd, tfd;
+
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	tfd = sys_open_tree(pfd, "", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
+	ASSERT_GE(tfd, 0);
+	ASSERT_EQ(sys_move_mount(tfd, "", AT_FDCWD, self->file, MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_TRUE(is_fdinfo(self->file));
+	close(tfd);
+	close(pfd);
+}
+
+TEST_F(procfs_source, no_mount_on_fdinfo)
+{
+	char target[PATH_LEN];
+	int pfd;
+
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	snprintf(target, sizeof(target), "/proc/self/fd/%d", pfd);
+	ASSERT_NE(mount(self->file, target, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(errno, ENOENT);
+	close(pfd);
+}
+
+/* Moving beneath would put the existing mount on top of the fdinfo file. */
+TEST_F(procfs_source, no_tuck_beneath_fdinfo)
+{
+	char other[PATH_LEN];
+	int pfd, tfd;
+
+	snprintf(other, sizeof(other), "%s/other", self->dir);
+	ASSERT_EQ(mknod(other, S_IFREG | 0644, 0), 0);
+	ASSERT_EQ(mount(other, self->file, NULL, MS_BIND, NULL), 0);
+
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	tfd = sys_open_tree(pfd, "", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
+	ASSERT_GE(tfd, 0);
+	ASSERT_NE(sys_move_mount(tfd, "", AT_FDCWD, self->file,
+				 MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH), 0);
+	ASSERT_EQ(errno, ENOENT);
+	ASSERT_FALSE(is_fdinfo(self->file));
+	ASSERT_EQ(umount2(self->file, 0), 0);
+	ASSERT_NE(umount2(self->file, 0), 0);
+	close(tfd);
+	close(pfd);
+}
+
+/* A copy in a slave would be tucked beneath the slave's own mount. */
+TEST_F(procfs_source, no_tuck_beneath_fdinfo_copy)
+{
+	char af[PATH_LEN], bf[PATH_LEN];
+	int pfd;
+
+	ASSERT_EQ(setup_slave(self->dir, af, bf), 0);
+	ASSERT_EQ(mount(self->file, bf, NULL, MS_BIND, NULL), 0);
+
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	ASSERT_NE(bind_entry(pfd, af), 0);
+	ASSERT_EQ(errno, ENOENT);
+	ASSERT_FALSE(is_fdinfo(af));
+
+	/* Without the mount in the slave the copy goes there. */
+	ASSERT_EQ(umount2(bf, 0), 0);
+	ASSERT_EQ(bind_entry(pfd, af), 0);
+	ASSERT_TRUE(is_fdinfo(af));
+	ASSERT_TRUE(is_fdinfo(bf));
+	close(pfd);
+}
+
+/* A peer gets its copy before the copy for the slave fails. */
+TEST_F(procfs_source, no_tuck_beneath_fdinfo_after_peer)
+{
+	char af[PATH_LEN], bf[PATH_LEN], a[PATH_LEN], c[PATH_LEN], cf[PATH_LEN];
+	int pfd;
+
+	ASSERT_EQ(setup_slave(self->dir, af, bf), 0);
+	snprintf(a, sizeof(a), "%s/a", self->dir);
+	snprintf(c, sizeof(c), "%s/c", self->dir);
+	snprintf(cf, sizeof(cf), "%s/c/f", self->dir);
+	ASSERT_EQ(mkdir(c, 0755), 0);
+	ASSERT_EQ(mount(a, c, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(self->file, bf, NULL, MS_BIND, NULL), 0);
+
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	ASSERT_NE(bind_entry(pfd, af), 0);
+	ASSERT_EQ(errno, ENOENT);
+	ASSERT_FALSE(is_fdinfo(af));
+	ASSERT_FALSE(is_fdinfo(cf));
+
+	ASSERT_EQ(umount2(bf, 0), 0);
+	ASSERT_EQ(bind_entry(pfd, af), 0);
+	ASSERT_TRUE(is_fdinfo(af));
+	ASSERT_TRUE(is_fdinfo(bf));
+	ASSERT_TRUE(is_fdinfo(cf));
+	close(pfd);
+}
+
+/* Moved off a slave, its copy goes where the mount came from. */
+TEST_F(procfs_source, move_fdinfo_off_slave)
+{
+	char af[PATH_LEN], bf[PATH_LEN];
+	int pfd;
+
+	ASSERT_EQ(setup_slave(self->dir, af, bf), 0);
+	pfd = open_entry("fdinfo", self->fd);
+	ASSERT_GE(pfd, 0);
+	ASSERT_EQ(bind_entry(pfd, bf), 0);
+	ASSERT_EQ(mount(bf, af, NULL, MS_MOVE, NULL), 0);
+	ASSERT_TRUE(is_fdinfo(af));
+	ASSERT_TRUE(is_fdinfo(bf));
+	/* only the copy is left in the slave */
+	ASSERT_EQ(umount2(bf, 0), 0);
+	ASSERT_FALSE(is_fdinfo(bf));
+	close(pfd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

