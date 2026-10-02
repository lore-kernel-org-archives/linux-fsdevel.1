Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338023E3158
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950485; cv=none; b=mZf5foHIaU+B7xM5WesvBJxVxhA/7LJ8zapg9E0zHHb8YMnEBMM6SHCy+Tx19xpgGwumne08AeLbRGQhUviKV+Obq/ZEqyAqxTLd1NCC3bV4HgP2eGrvP0gnszqzEirFsk0MA/B/0aa4jLbYZB4ENNE+NqqRCsPhb3HIDibrW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950485; c=relaxed/simple;
	bh=f/cNCgWmBoQbtISv3El0+k5hMm9sqxdF1nVbRw+UC5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2POkFsVI+FcgaHarXd9cUHzq2VPRu9C8edLHABwcV8VYCt2P/NKo0Yf9vvv4pJTikAfTeu+galElzychhuNZ7FeVIUvFOLIwJPZ7CtY+Sx5FWpkvc/tKUKaFfKgJmmRNSjeGgRvaY+ADw6RBjWvt56HzC16AYpW4jmSg49Kfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQpDbhNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQpDbhNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C06A1F00893;
	Fri,  2 Oct 2026 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950480;
	bh=wWj/oyTgBp2i6XIx4hPJslwcZLH0FdD56T816/5X5r8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YQpDbhNPvYnA/eq0AojPdnqi6taokWtFxCWxg4pQVDTg/a8MBaEYpSaILbYV87kAI
	 Dt9hwy4b+kcbb7wDsXdQ1Ix+myzoR1VNQYSizX3+U+qj5bcjkpauShRjoQcoYn5Ihv
	 G2NKRsRi5mUa+VG/M7tDCRi+DLwWJY62uWFkKenE514lzHhKt98zVXeuVRkR5agtdp
	 NjcgLR3ftCxsQo5jef2vMm+VOz9eY9vwbPu3VdVQxOpEWMQDpK2Yy8/MYsxc5juRXA
	 KYw/VAyirsnd4XS57EFpyhAUwhZviMzYX9ADMqVtJrt4aufMiyy3I5UCx1gpDoxndg
	 fSS9YKBU6wXpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 16:14:29 +0200
Subject: [PATCH 3/3] selftests/filesystems: test covered mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-cover-v1-3-232a8f52b43c@kernel.org>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
In-Reply-To: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=80389; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f/cNCgWmBoQbtISv3El0+k5hMm9sqxdF1nVbRw+UC5s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3+P28sfb/9lTTVmat/mVd/06I8H32tpVluvDqfLvK
 2M9lwf96ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIDzMjw/4DMa1hyjkprq1m
 Wx8qn7I47n+uSTTBaZv+5glCnwyuX2b4n8Jv+uUV01G9DfILGWbIpvdw5Btv3CP021z4iqvqvaz
 dTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that mount cycles are resolved and test that mount covers behave as
expected.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/mount_cycle/.gitignore   |    3 +
 .../selftests/filesystems/mount_cycle/Makefile     |    7 +-
 .../selftests/filesystems/mount_cycle/config       |   39 +
 .../filesystems/mount_cycle/locked_handle_test.c   |  377 +++++
 .../filesystems/mount_cycle/loop_cycle_test.c      | 1542 ++++++++++++++++++++
 .../filesystems/mount_cycle/mount_cover_test.c     |  565 +++++++
 .../selftests/filesystems/mount_cycle/settings     |    1 +
 7 files changed, 2533 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
index d11f5b720d5b..30f7dd071bcb 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+loop_cycle_test
 unmounted_tree_test
 overmount_reparent_test
+mount_cover_test
+locked_handle_test
 nsfs_rbind_loop_test
 overmount_ns_file_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
index 49a8402ca858..fbe8c5e19d42 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -1,7 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := unmounted_tree_test overmount_reparent_test
+TEST_GEN_PROGS := loop_cycle_test unmounted_tree_test overmount_reparent_test mount_cover_test locked_handle_test
 TEST_GEN_PROGS += nsfs_rbind_loop_test overmount_ns_file_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
+LOCAL_HDRS += ../readdir_hold.h
+
 include ../../lib.mk
+
+$(OUTPUT)/locked_handle_test: LDLIBS += -pthread
+$(OUTPUT)/mount_cover_test: LDLIBS += -pthread
diff --git a/tools/testing/selftests/filesystems/mount_cycle/config b/tools/testing/selftests/filesystems/mount_cycle/config
new file mode 100644
index 000000000000..3bd5ce46af74
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/config
@@ -0,0 +1,39 @@
+CONFIG_USER_NS=y
+CONFIG_TMPFS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_VFAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_MINIX_FS=y
+CONFIG_AUTOFS_FS=y
+CONFIG_ZRAM=y
+CONFIG_ZRAM_WRITEBACK=y
+CONFIG_KEYS=y
+CONFIG_ECRYPT_FS=y
+CONFIG_BINFMT_MISC=y
+CONFIG_FUSE_FS=y
+CONFIG_FUSE_PASSTHROUGH=y
+CONFIG_BLK_DEV_ZONED=y
+CONFIG_BLK_DEV_ZONED_LOOP=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_USB_STORAGE=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_DUMMY_HCD=y
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+CONFIG_MD_RAID1=y
+CONFIG_MD_BITMAP=y
+CONFIG_MD_BITMAP_FILE=y
+CONFIG_INOTIFY_USER=y
+CONFIG_DNOTIFY=y
+CONFIG_FANOTIFY=y
+CONFIG_FILE_LOCKING=y
+CONFIG_CRYPTO_AES=y
+CONFIG_USERFAULTFD=y
diff --git a/tools/testing/selftests/filesystems/mount_cycle/locked_handle_test.c b/tools/testing/selftests/filesystems/mount_cycle/locked_handle_test.c
new file mode 100644
index 000000000000..b21f43471e49
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/locked_handle_test.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * may_decode_fh() refuses a file handle below a mount with locked children
+ * to root in a user namespace. That has to hold while the mount is lazily
+ * unmounted and its children, the locked ones too, are taken off it.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#include "../../kselftest_harness.h"
+
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE		1
+#endif
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC	O_CLOEXEC
+#endif
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE		0x8000
+#endif
+
+#define DIR_LEN		64
+#define PATH_LEN	128
+
+#define ROUNDS		100	/* lazy umounts raced per test */
+#define RACERS		3	/* threads in open_by_handle_at() */
+#define EXTRA_MOUNTS	64	/* make umount_tree() hold mount_lock longer */
+#define MAX_DELAY_US	3000	/* before the umount */
+#define TAIL_US		2000	/* after it */
+
+struct handle {
+	struct file_handle fh;
+	unsigned char buf[MAX_HANDLE_SZ];
+};
+
+/* exit codes of the child */
+enum {
+	CHILD_OK,
+	CHILD_SETUP,
+	CHILD_DECODED,		/* decoded past a locked child */
+	CHILD_MOUNTED,		/* not refused while mounted */
+	CHILD_UNMOUNTED,	/* not refused once unmounted */
+	CHILD_ALLOWED,		/* refused where nothing is locked */
+	CHILD_NOUSERNS,		/* no user namespace to be had */
+};
+
+static int write_file(const char *path, const char *s)
+{
+	ssize_t n = -1;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd >= 0) {
+		n = write(fd, s, strlen(s));
+		close(fd);
+	}
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+/* Become root in a new user namespace with a private mount namespace. */
+static int enter_userns(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map[32];
+
+	prctl(PR_SET_DUMPABLE, 1);
+	/* EINVAL: no USER_NS, ENOSPC: user.max_user_namespaces is 0, EPERM: an LSM */
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+		return errno == EINVAL || errno == ENOSPC || errno == EPERM ?
+		       CHILD_NOUSERNS : CHILD_SETUP;
+	if (write_file("/proc/self/setgroups", "deny") && errno != ENOENT)
+		return CHILD_SETUP;
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map))
+		return CHILD_SETUP;
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map))
+		return CHILD_SETUP;
+	if (setgid(0) || setuid(0))
+		return CHILD_SETUP;
+	if (mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_SETUP;
+	return CHILD_OK;
+}
+
+static int get_handle(const char *path, struct handle *h)
+{
+	int mntid;
+
+	h->fh.handle_bytes = MAX_HANDLE_SZ;
+	return name_to_handle_at(AT_FDCWD, path, &h->fh, &mntid, 0);
+}
+
+static int decode(int dfd, struct handle *h)
+{
+	return open_by_handle_at(dfd, &h->fh, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+}
+
+struct race {
+	int dfd;
+	struct handle *h;
+	atomic_int go;
+	atomic_int stop;
+	atomic_int won;		/* the first decoded descriptor */
+};
+
+static void *racer(void *arg)
+{
+	struct race *r = arg;
+
+	while (!atomic_load(&r->go))
+		;
+	while (!atomic_load(&r->stop)) {
+		int none = -1;
+		int fd;
+
+		fd = decode(r->dfd, r->h);
+		if (fd < 0)
+			continue;
+		if (!atomic_compare_exchange_strong(&r->won, &none, fd))
+			close(fd);
+	}
+	return NULL;
+}
+
+/* stop the @n racers started so far and wait for them, they spin on @r */
+static void stop_racers(struct race *r, pthread_t *th, int n)
+{
+	int i;
+
+	atomic_store(&r->stop, 1);
+	atomic_store(&r->go, 1);	/* one still waiting for the start sees stop next */
+	for (i = 0; i < n; i++)
+		pthread_join(th[i], NULL);
+}
+
+/*
+ * Bind @h recursively at @w, or take a detached copy of it, and race
+ * open_by_handle_at() of @inner against the lazy umount. The decoded
+ * descriptor, if there was one, is left in @won.
+ */
+static int race_round(const char *h, const char *w, struct handle *inner,
+		      bool dissolve, int *won)
+{
+	struct race r = { .h = inner, .won = -1 };
+	pthread_t th[RACERS];
+	int treefd = -1, fd, i;
+
+	if (dissolve) {
+		treefd = syscall(__NR_open_tree, AT_FDCWD, h,
+				 OPEN_TREE_CLONE | AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+		if (treefd < 0)
+			return CHILD_SETUP;
+		/* an ordinary descriptor on the copy, treefd's close dissolves it */
+		r.dfd = openat(treefd, ".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	} else {
+		if (mount(h, w, NULL, MS_BIND | MS_REC, NULL))
+			return CHILD_SETUP;
+		r.dfd = open(w, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	}
+	if (r.dfd < 0)
+		return CHILD_SETUP;
+
+	fd = decode(r.dfd, inner);
+	if (fd >= 0 || errno != EPERM) {
+		if (fd >= 0)
+			close(fd);
+		return CHILD_MOUNTED;
+	}
+
+	for (i = 0; i < RACERS; i++) {
+		if (pthread_create(&th[i], NULL, racer, &r)) {
+			stop_racers(&r, th, i);
+			return CHILD_SETUP;
+		}
+	}
+	atomic_store(&r.go, 1);
+	usleep(rand() % MAX_DELAY_US);
+	if (dissolve)
+		close(treefd);
+	else if (umount2(w, MNT_DETACH)) {
+		stop_racers(&r, th, RACERS);
+		return CHILD_SETUP;
+	}
+	usleep(TAIL_US);
+	stop_racers(&r, th, RACERS);
+
+	fd = decode(r.dfd, inner);
+	if (fd >= 0) {
+		close(fd);
+		return CHILD_UNMOUNTED;
+	}
+	close(r.dfd);
+	*won = atomic_load(&r.won);
+	return CHILD_OK;
+}
+
+static int race_child(const char *h, const char *w, struct handle *inner,
+		      bool dissolve)
+{
+	int ret, won, i;
+
+	srand(getpid());
+	ret = enter_userns();
+	if (ret)
+		return ret;
+	for (i = 0; i < ROUNDS; i++) {
+		ret = race_round(h, w, inner, dissolve, &won);
+		if (ret)
+			return ret;
+		if (won >= 0)
+			return CHILD_DECODED;
+	}
+	return CHILD_OK;
+}
+
+/* a bind without locked children decodes while mounted and not after */
+static int allowed_child(const char *plain, const char *w, struct handle *h)
+{
+	int dfd, fd, ret;
+
+	ret = enter_userns();
+	if (ret)
+		return ret;
+	if (mount(plain, w, NULL, MS_BIND | MS_REC, NULL))
+		return CHILD_SETUP;
+	dfd = open(w, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (dfd < 0)
+		return CHILD_SETUP;
+	fd = decode(dfd, h);
+	if (fd < 0)
+		return CHILD_ALLOWED;
+	close(fd);
+	if (umount2(w, MNT_DETACH))
+		return CHILD_SETUP;
+	fd = decode(dfd, h);
+	if (fd >= 0) {
+		close(fd);
+		return CHILD_UNMOUNTED;
+	}
+	return errno == EPERM ? CHILD_OK : CHILD_UNMOUNTED;
+}
+
+FIXTURE(locked_handle) {
+	char base[DIR_LEN];
+	char h[PATH_LEN];		/* the tree with the covered directory */
+	char plain[PATH_LEN];		/* a tree with no mount in it */
+	char w[PATH_LEN];		/* where the child binds either */
+	struct handle inner;		/* h/top/secret/inner, covered */
+	struct handle uncovered;	/* plain/inner */
+};
+
+FIXTURE_SETUP(locked_handle)
+{
+	char p[PATH_LEN], e[PATH_LEN];
+	int i;
+
+	if (geteuid())
+		SKIP(return, "test requires root");
+
+	snprintf(self->base, sizeof(self->base), "/tmp/locked_handle.XXXXXX");
+	ASSERT_NE(mkdtemp(self->base), NULL);
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, NULL), 0);
+
+	snprintf(self->h, sizeof(self->h), "%s/h", self->base);
+	snprintf(self->plain, sizeof(self->plain), "%s/plain", self->base);
+	snprintf(self->w, sizeof(self->w), "%s/w", self->base);
+	ASSERT_EQ(mkdir(self->h, 0755), 0);
+	ASSERT_EQ(mkdir(self->plain, 0755), 0);
+	ASSERT_EQ(mkdir(self->w, 0755), 0);
+	snprintf(p, sizeof(p), "%s/plain/inner", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	ASSERT_EQ(get_handle(p, &self->uncovered), 0);
+
+	/* the handle is for this filesystem */
+	ASSERT_EQ(mount("tmpfs", self->h, "tmpfs", 0, NULL), 0);
+	snprintf(p, sizeof(p), "%s/h/top", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	snprintf(p, sizeof(p), "%s/h/top/secret", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	snprintf(p, sizeof(p), "%s/h/top/secret/inner", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	ASSERT_EQ(get_handle(p, &self->inner), 0);
+	snprintf(e, sizeof(e), "%s/h/empty", self->base);
+	ASSERT_EQ(mkdir(e, 0755), 0);
+
+	/* cover it, and some more so the umount takes longer */
+	snprintf(p, sizeof(p), "%s/h/top/secret", self->base);
+	ASSERT_EQ(mount("tmpfs", p, "tmpfs", 0, NULL), 0);
+	for (i = 0; i < EXTRA_MOUNTS; i++) {
+		snprintf(p, sizeof(p), "%s/h/c%d", self->base, i);
+		ASSERT_EQ(mkdir(p, 0755), 0);
+		ASSERT_EQ(mount(e, p, NULL, MS_BIND, NULL), 0);
+	}
+}
+
+FIXTURE_TEARDOWN(locked_handle)
+{
+	umount2(self->base, MNT_DETACH);
+	rmdir(self->base);
+}
+
+static int wait_child(pid_t pid)
+{
+	int status;
+
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+TEST_F(locked_handle, lazy_umount)
+{
+	pid_t pid;
+	int ret;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		_exit(race_child(self->h, self->w, &self->inner, false));
+	ret = wait_child(pid);
+	TH_LOG("child exit code %d", ret);
+	if (ret == CHILD_NOUSERNS)
+		SKIP(return, "no user namespaces");
+	EXPECT_EQ(ret, CHILD_OK);
+}
+
+TEST_F(locked_handle, dissolve)
+{
+	pid_t pid;
+	int ret;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		_exit(race_child(self->h, self->w, &self->inner, true));
+	ret = wait_child(pid);
+	TH_LOG("child exit code %d", ret);
+	if (ret == CHILD_NOUSERNS)
+		SKIP(return, "no user namespaces");
+	EXPECT_EQ(ret, CHILD_OK);
+}
+
+TEST_F(locked_handle, allowed_use)
+{
+	pid_t pid;
+	int ret;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		_exit(allowed_child(self->plain, self->w, &self->uncovered));
+	ret = wait_child(pid);
+	TH_LOG("child exit code %d", ret);
+	if (ret == CHILD_NOUSERNS)
+		SKIP(return, "no user namespaces");
+	EXPECT_EQ(ret, CHILD_OK);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
new file mode 100644
index 000000000000..6b4f5304c2e4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
@@ -0,0 +1,1542 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A mount that another namespace's rmdir detached, or that went down with
+ * the detached tree it was in when the tree's last fd was closed, keeps
+ * its submounts connected, and a connected submount is put by its
+ * parent's final mntput(). A submount whose filesystem keeps a file open
+ * on the parent then holds the parent's count above zero for good:
+ * nothing in userspace refers to either mount any more and nothing can
+ * release them. A loop device is the simplest such filesystem, its
+ * backing file sits on the parent.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <stdbool.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/fuse.h>
+#include <linux/keyctl.h>
+#include <linux/major.h>
+#include <linux/raid/md_u.h>
+#include <linux/raid/md_p.h>
+#include <linux/loop.h>
+#include <linux/magic.h>
+#include <sys/syscall.h>
+#include <sys/sysmacros.h>
+#include <sys/uio.h>
+
+#include "../wrappers.h"
+#include "../../kselftest_harness.h"
+
+#define IMAGE_SIZE	(1440 * 1024)
+#define SECTOR		512
+
+/*
+ * The tmpfs of the fixture. A directory of its own from mkdtemp(), so that
+ * the test needs no writable root directory and two instances don't take
+ * each other's mounts down.
+ */
+static char base[64];
+
+/* The configfs directory of the gadget, named after the test process. */
+static char gadget[96];
+
+/* A path below the base directory. Eight of them can be in use at a time. */
+static const char *at(const char *rel)
+{
+	static char buf[8][PATH_MAX];
+	static unsigned int next;
+	char *p = buf[next++ % 8];
+
+	snprintf(p, PATH_MAX, "%s/%s", base, rel);
+	return p;
+}
+
+/* A path below the gadget's configfs directory. */
+static const char *gat(const char *rel)
+{
+	static char buf[4][PATH_MAX];
+	static unsigned int next;
+	char *p = buf[next++ % 4];
+
+	snprintf(p, PATH_MAX, "%s%s", gadget, rel);
+	return p;
+}
+
+/* The loop devices this process has bound, to release them on every path. */
+#define MAX_LOOPS	4
+static int bound[MAX_LOOPS];
+static int nr_bound;
+
+/* What a child tells its parent: the loop devices it has bound, -1 for none. */
+struct report {
+	int n[2];
+};
+
+/* A blank FAT12 floppy image: boot sector, two FATs, an empty root directory. */
+static int write_fat12(int fd)
+{
+	struct stat st;
+	unsigned char sector[SECTOR] = {
+		0xeb, 0x3c, 0x90, 'M', 'S', 'W', 'I', 'N', '4', '.', '1',
+		[11] = 0x00, 0x02,	/* bytes per sector: 512 */
+		[13] = 1,		/* sectors per cluster */
+		[14] = 1, 0,		/* reserved sectors */
+		[16] = 2,		/* FATs */
+		[17] = 0xe0, 0x00,	/* root directory entries: 224 */
+		[19] = 0x40, 0x0b,	/* total sectors: 2880 */
+		[21] = 0xf0,		/* media descriptor */
+		[22] = 9, 0,		/* sectors per FAT */
+		[24] = 18, 0,		/* sectors per track */
+		[26] = 2, 0,		/* heads */
+		[38] = 0x29,		/* extended boot signature */
+		[39] = 0x12, 0x34, 0x56, 0x78,
+		[43] = 'N', 'O', ' ', 'N', 'A', 'M', 'E', ' ', ' ', ' ', ' ',
+		[54] = 'F', 'A', 'T', '1', '2', ' ', ' ', ' ',
+		[510] = 0x55, 0xaa,
+	};
+	unsigned char fat[SECTOR] = { 0xf0, 0xff, 0xff };
+
+	if (pwrite(fd, sector, SECTOR, 0) != SECTOR)
+		return -1;
+	/* the first FAT and the second one, one sector each is enough */
+	if (pwrite(fd, fat, SECTOR, 1 * SECTOR) != SECTOR ||
+	    pwrite(fd, fat, SECTOR, 10 * SECTOR) != SECTOR)
+		return -1;
+	if (fstat(fd, &st) || S_ISBLK(st.st_mode))
+		return 0;
+	return ftruncate(fd, IMAGE_SIZE);
+}
+
+/*
+ * A blank FAT12 image with 4 KiB sectors and @sectors of them, for a device
+ * with 4 KiB logical blocks (zram) or for a bigger image than a floppy.
+ */
+static int write_fat12_4k(int fd, unsigned int sectors)
+{
+	unsigned int fat_sectors = (sectors * 3 / 2 + 4095) / 4096;
+	unsigned char sector[4096] = {
+		0xeb, 0x3c, 0x90, 'M', 'S', 'W', 'I', 'N', '4', '.', '1',
+		[11] = 0x00, 0x10,	/* bytes per sector: 4096 */
+		[13] = 1,		/* sectors per cluster */
+		[14] = 1, 0,		/* reserved sectors */
+		[16] = 2,		/* FATs */
+		[17] = 128, 0,		/* root directory entries: one sector */
+		[19] = sectors & 0xff, sectors >> 8,
+		[21] = 0xf8,		/* media descriptor */
+		[22] = fat_sectors, 0,
+		[24] = 63, 0,		/* sectors per track */
+		[26] = 255, 0,		/* heads */
+		[38] = 0x29,		/* extended boot signature */
+		[39] = 0x12, 0x34, 0x56, 0x78,
+		[43] = 'N', 'O', ' ', 'N', 'A', 'M', 'E', ' ', ' ', ' ', ' ',
+		[54] = 'F', 'A', 'T', '1', '2', ' ', ' ', ' ',
+		[510] = 0x55, 0xaa,
+	};
+	unsigned char fat[4096] = { 0xf8, 0xff, 0xff };
+	struct stat st;
+
+	if (pwrite(fd, sector, sizeof(sector), 0) != sizeof(sector))
+		return -1;
+	if (pwrite(fd, fat, sizeof(fat), 1 * 4096) != sizeof(fat) ||
+	    pwrite(fd, fat, sizeof(fat), (1 + fat_sectors) * 4096) != sizeof(fat))
+		return -1;
+	if (fstat(fd, &st) || S_ISBLK(st.st_mode))
+		return 0;
+	return ftruncate(fd, (off_t)sectors * 4096);
+}
+
+#define MINIX_BLOCK	1024
+#define MINIX_BLOCKS	4096			/* a 4 MiB image */
+#define MINIX_INODES	512
+#define MINIX_ITABLE	(MINIX_INODES * 32 / MINIX_BLOCK)
+#define MINIX_FIRSTDATA	(2 + 1 + 1 + MINIX_ITABLE)	/* boot, super, imap, zmap, inodes */
+
+/*
+ * A blank minix v1 image, for the holders that need a FIFO or a device
+ * node on the dying mount, which vfat can't hold. Superblock in block 1,
+ * one block each for the inode and zone bitmaps, the inode table, and
+ * the root directory in the first data zone.
+ */
+static int write_minix(int fd)
+{
+	struct {
+		__u16 s_ninodes, s_nzones, s_imap_blocks, s_zmap_blocks;
+		__u16 s_firstdatazone, s_log_zone_size;
+		__u32 s_max_size;
+		__u16 s_magic, s_state;
+	} sb = {
+		.s_ninodes = MINIX_INODES,
+		.s_nzones = MINIX_BLOCKS,
+		.s_imap_blocks = 1,
+		.s_zmap_blocks = 1,
+		.s_firstdatazone = MINIX_FIRSTDATA,
+		.s_max_size = (7 + 512 + 512 * 512) * MINIX_BLOCK,
+		.s_magic = MINIX_SUPER_MAGIC,
+		.s_state = 1,		/* MINIX_VALID_FS */
+	};
+	struct {
+		__u16 i_mode, i_uid;
+		__u32 i_size, i_time;
+		__u8 i_gid, i_nlinks;
+		__u16 i_zone[9];
+	} root = {
+		.i_mode = S_IFDIR | 0755,
+		.i_size = 2 * 16,
+		.i_nlinks = 2,
+		.i_zone = { MINIX_FIRSTDATA },
+	};
+	unsigned char imap[MINIX_BLOCK], zmap[MINIX_BLOCK], dir[MINIX_BLOCK] = {};
+	int i;
+
+	/* bit 0 is reserved in both maps, the root inode and its zone are in use */
+	memset(imap, 0xff, sizeof(imap));
+	for (i = 2; i <= MINIX_INODES; i++)
+		imap[i / 8] &= ~(1 << (i % 8));
+	memset(zmap, 0xff, sizeof(zmap));
+	for (i = 2; i <= MINIX_BLOCKS - MINIX_FIRSTDATA; i++)
+		zmap[i / 8] &= ~(1 << (i % 8));
+	dir[0] = 1;
+	dir[2] = '.';
+	dir[16] = 1;
+	dir[18] = '.';
+	dir[19] = '.';
+
+	if (pwrite(fd, &sb, sizeof(sb), 1 * MINIX_BLOCK) != sizeof(sb) ||
+	    pwrite(fd, imap, sizeof(imap), 2 * MINIX_BLOCK) != sizeof(imap) ||
+	    pwrite(fd, zmap, sizeof(zmap), 3 * MINIX_BLOCK) != sizeof(zmap) ||
+	    pwrite(fd, &root, sizeof(root), 4 * MINIX_BLOCK) != sizeof(root) ||
+	    pwrite(fd, dir, sizeof(dir), MINIX_FIRSTDATA * MINIX_BLOCK) != sizeof(dir))
+		return -1;
+	return ftruncate(fd, (off_t)MINIX_BLOCKS * MINIX_BLOCK);
+}
+
+static int read_sysfs(const char *path, char *buf, size_t size)
+{
+	ssize_t n;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	n = read(fd, buf, size - 1);
+	close(fd);
+	if (n < 0)
+		return -1;
+	buf[n] = '\0';
+	return 0;
+}
+
+/* Is @dev the mount source of this line of mountinfo? loop1 is not loop10. */
+static bool line_has_source(const char *line, const char *dev)
+{
+	const char *sep, *src, *end;
+
+	sep = strstr(line, " - ");
+	if (!sep)
+		return false;
+	src = strchr(sep + 3, ' ');	/* skip the filesystem type */
+	if (!src)
+		return false;
+	src++;
+	end = strchr(src, ' ');
+	if (!end)
+		return false;
+	return (size_t)(end - src) == strlen(dev) && !strncmp(src, dev, end - src);
+}
+
+/*
+ * Does a mount namespace of a process that /proc shows have a mount of @dev?
+ * The mounts under test are in no namespace at this point on any kernel, so
+ * this only checks that the test got as far as it thinks.
+ */
+static bool mounted_anywhere(const char *dev)
+{
+	char path[PATH_MAX], line[4096];
+	struct dirent *de;
+	bool found = false;
+	DIR *proc;
+	FILE *f;
+
+	proc = opendir("/proc");
+	if (!proc)
+		return false;
+	while (!found && (de = readdir(proc))) {
+		if (de->d_name[0] < '0' || de->d_name[0] > '9')
+			continue;
+		snprintf(path, sizeof(path), "/proc/%s/mountinfo", de->d_name);
+		f = fopen(path, "re");
+		if (!f)
+			continue;
+		while (fgets(line, sizeof(line), f)) {
+			if (line_has_source(line, dev)) {
+				found = true;
+				break;
+			}
+		}
+		fclose(f);
+	}
+	closedir(proc);
+	return found;
+}
+
+/* Wait up to @ms milliseconds for the loop device to give up its backing file. */
+static bool loop_released(const char *sysfs, int ms)
+{
+	char buf[PATH_MAX];
+
+	for (; ms > 0; ms -= 100) {
+		if (read_sysfs(sysfs, buf, sizeof(buf)) < 0)
+			return errno == ENOENT;
+		usleep(100000);
+	}
+	return read_sysfs(sysfs, buf, sizeof(buf)) < 0 && errno == ENOENT;
+}
+
+/* Tell the loop device to give its file up, now or when its last user is gone. */
+static void loop_clear(int n)
+{
+	char dev[32];
+	int lfd;
+
+	if (n < 0)
+		return;
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	lfd = open(dev, O_RDWR);
+	if (lfd < 0)
+		return;
+	ioctl(lfd, LOOP_CLR_FD);
+	close(lfd);
+}
+
+FIXTURE(loop_cycle) {
+	char dev[32];		/* the loop device the child set up */
+	char sysfs[64];		/* its backing_file attribute */
+	int loops[MAX_LOOPS];	/* every loop device the case has bound */
+	int nr_loops;
+	bool gadget;		/* the gadget's configfs directory exists */
+};
+
+static void remember_loop(FIXTURE_DATA(loop_cycle) *self, int n)
+{
+	if (n >= 0 && self->nr_loops < MAX_LOOPS)
+		self->loops[self->nr_loops++] = n;
+}
+
+FIXTURE_SETUP(loop_cycle)
+{
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+	if (access("/dev/loop-control", R_OK | W_OK))
+		SKIP(return, "test requires loop devices");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(base, sizeof(base), "/tmp/loop_cycle.XXXXXX");
+	ASSERT_NE(mkdtemp(base), NULL);
+	/* a failed assertion in the setup does not run the teardown */
+	ASSERT_EQ(mount("tmpfs", base, "tmpfs", 0, NULL), 0)
+		rmdir(base);
+	snprintf(gadget, sizeof(gadget),
+		 "/sys/kernel/config/usb_gadget/kselftest_cycle_%d", getpid());
+	self->dev[0] = '\0';
+	self->nr_loops = 0;
+	self->gadget = false;
+}
+
+static int mount_configfs(void);
+static void gadget_remove(void);
+
+FIXTURE_TEARDOWN(loop_cycle)
+{
+	if (self->gadget)
+		gadget_remove();
+	/* whatever a failed assertion has left bound */
+	for (int i = 0; i < self->nr_loops; i++)
+		loop_clear(self->loops[i]);
+	umount2(base, MNT_DETACH);
+	rmdir(base);
+}
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,
+	CHILD_NS,		/* could not set up the namespace or the tmpfs */
+	CHILD_IMAGE,		/* could not write the image */
+	CHILD_LOOP,		/* could not set up the loop device */
+	CHILD_MOUNT,		/* could not mount it (vfat and msdos both refused) */
+	CHILD_PIPE,		/* the parent went away */
+	CHILD_HOLDER,		/* could not set the holder up below the mount */
+	CHILD_SKIP,		/* the kernel lacks what the holder needs */
+	CHILD_NOFS,		/* the kernel lacks the filesystem of the image */
+};
+
+/* Bind the loop device that LOOP_CTL_GET_FREE names to @ifd; the device number. */
+static int loop_bind_free(int ifd)
+{
+	int cfd, lfd, n;
+	char dev[32];
+
+	cfd = open("/dev/loop-control", O_RDWR);
+	if (cfd < 0)
+		return -1;
+	n = ioctl(cfd, LOOP_CTL_GET_FREE);
+	close(cfd);
+	if (n < 0)
+		return -1;
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	lfd = open(dev, O_RDWR);
+	if (lfd < 0)
+		return -1;
+	if (ioctl(lfd, LOOP_SET_FD, ifd))
+		n = -1;
+	close(lfd);
+	return n;
+}
+
+/*
+ * Bind a free loop device to the open image @ifd; the device number. The
+ * device is free when LOOP_CTL_GET_FREE names it and may be somebody else's
+ * a moment later, so try again when it is busy.
+ */
+static int loop_bind(int ifd)
+{
+	int n = -1;
+
+	for (int i = 0; i < 64 && n < 0; i++) {
+		n = loop_bind_free(ifd);
+		if (n < 0 && errno != EBUSY)
+			return -1;
+	}
+	if (n >= 0 && nr_bound < MAX_LOOPS)
+		bound[nr_bound++] = n;
+	return n;
+}
+
+/* Mount a FAT image, as vfat or as msdos; -1 with ENODEV if the kernel has neither. */
+static int mount_fat(const char *dev, const char *mp)
+{
+	int err;
+
+	if (!mount(dev, mp, "vfat", 0, NULL))
+		return 0;
+	err = errno;
+	if (!mount(dev, mp, "msdos", 0, NULL))
+		return 0;
+	if (err != ENODEV)
+		errno = err;
+	return -1;
+}
+
+/*
+ * A child that gives up has to take down what it has set up: nobody else
+ * knows about it. Unmount, then tell the loop devices to let go. The mounts
+ * are released after this process is gone and the devices follow them.
+ */
+static int child_fails(int ret)
+{
+	umount2(at("vol"), MNT_DETACH);
+	umount2(at("vol2"), MNT_DETACH);
+	umount2(at("p"), MNT_DETACH);
+	umount2(at("img"), MNT_DETACH);
+	for (int i = 0; i < nr_bound; i++)
+		loop_clear(bound[i]);
+	return ret;
+}
+
+/* Write an image to @img, bind a loop device to it and mount that at @mp; the device number. */
+static int loop_mount(const char *img, const char *mp)
+{
+	char dev[32];
+	int ifd, n;
+
+	ifd = open(img, O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (ifd < 0 || write_fat12(ifd))
+		return -CHILD_IMAGE;
+	n = loop_bind(ifd);
+	close(ifd);	/* the loop device holds the file from now on */
+	if (n < 0)
+		return -CHILD_LOOP;
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	if (mkdir(mp, 0755))
+		return -CHILD_MOUNT;
+	if (mount_fat(dev, mp))
+		return errno == ENODEV ? -CHILD_NOFS : -CHILD_MOUNT;
+	return n;
+}
+
+/*
+ * Two tmpfs mounts, each carrying the image of the loop mount below the
+ * other: the loop mount below vol has its image on vol2 and the other way
+ * round.
+ */
+static int crossed_child(int to_parent, int from_parent)
+{
+	struct report r;
+	char c;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_NS;
+	if (mkdir(at("vol"), 0755) || mount("tmpfs", at("vol"), "tmpfs", 0, NULL) ||
+	    mkdir(at("vol2"), 0755) || mount("tmpfs", at("vol2"), "tmpfs", 0, NULL))
+		return child_fails(CHILD_NS);
+	r.n[0] = loop_mount(at("vol2/img"), at("vol/mnt"));
+	if (r.n[0] < 0)
+		return child_fails(-r.n[0]);
+	r.n[1] = loop_mount(at("vol/img"), at("vol2/mnt"));
+	if (r.n[1] < 0)
+		return child_fails(-r.n[1]);
+	if (write(to_parent, &r, sizeof(r)) != sizeof(r))
+		return child_fails(CHILD_PIPE);
+	if (read(from_parent, &c, 1) != 1)
+		return child_fails(CHILD_PIPE);
+	return CHILD_OK;
+}
+
+/*
+ * In its own mount namespace the child mounts a tmpfs on vol,
+ * puts a filesystem image on it, binds a loop device to the image and
+ * mounts that loop device below. The loop device's backing file is a
+ * reference on the mount the image is on, held by the loop device, held
+ * by the mounted filesystem, held by the mount below.
+ */
+static int loop_child(int to_parent, int from_parent)
+{
+	struct report r = { { -1, -1 } };
+	char c;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_NS;
+	if (mkdir(at("vol"), 0755) || mount("tmpfs", at("vol"), "tmpfs", 0, NULL))
+		return child_fails(CHILD_NS);
+	r.n[0] = loop_mount(at("vol/img"), at("vol/mnt"));
+	if (r.n[0] < 0)
+		return child_fails(-r.n[0]);
+
+	if (write(to_parent, &r, sizeof(r)) != sizeof(r))
+		return child_fails(CHILD_PIPE);
+	/* keep the namespace alive while the parent removes the directory */
+	if (read(from_parent, &c, 1) != 1)
+		return child_fails(CHILD_PIPE);
+	return CHILD_OK;
+}
+
+/*
+ * The child did not report. Skip if the kernel lacks something, fail with
+ * what the child said otherwise. A child that a signal killed has failed.
+ */
+#define CHILD_GAVE_UP(pid) do {						\
+	int __status;							\
+									\
+	ASSERT_EQ(waitpid(pid, &__status, 0), pid);			\
+	if (WIFEXITED(__status) && WEXITSTATUS(__status) == CHILD_NOFS)	\
+		SKIP(return, "test requires the filesystem of the image (FAT or minix)"); \
+	if (WIFEXITED(__status) && WEXITSTATUS(__status) == CHILD_SKIP)	\
+		SKIP(return, "the kernel lacks what this holder needs"); \
+	ASSERT_TRUE(false)						\
+		TH_LOG("child failed to set up: %s %d",			\
+		       WIFEXITED(__status) ? "exit status" : "signal",	\
+		       WIFEXITED(__status) ? WEXITSTATUS(__status) : WTERMSIG(__status)); \
+} while (0)
+
+/* The child has to leave by itself and with nothing to complain about. */
+#define CHILD_LEFT(pid) do {						\
+	int __status;							\
+									\
+	ASSERT_EQ(waitpid(pid, &__status, 0), pid);			\
+	ASSERT_TRUE(WIFEXITED(__status));				\
+	ASSERT_EQ(WEXITSTATUS(__status), CHILD_OK);			\
+} while (0)
+
+/*
+ * An exclusive open of the device fails while a filesystem holds it, and
+ * the only filesystem that ever did is the one mounted below the dead
+ * mount. Give a release in flight a moment. Then the device must clear
+ * right away rather than only be marked for autoclear.
+ */
+static void assert_loop_released(struct __test_metadata *_metadata,
+				 FIXTURE_DATA(loop_cycle) *self)
+{
+	int lfd;
+
+	for (int i = 0; i < 20; i++) {
+		lfd = open(self->dev, O_RDONLY | O_EXCL);
+		if (lfd >= 0)
+			break;
+		usleep(100000);
+	}
+	EXPECT_GE(lfd, 0)
+		TH_LOG("%s is still held by the loop mount below the dead mount: nothing refers to either mount and nothing can release them",
+		       self->dev);
+	if (lfd >= 0)
+		close(lfd);
+
+	lfd = open(self->dev, O_RDWR);
+	ASSERT_GE(lfd, 0);
+	ASSERT_EQ(ioctl(lfd, LOOP_CLR_FD), 0);
+	close(lfd);
+	ASSERT_TRUE(loop_released(self->sysfs, 5000))
+		TH_LOG("%s kept its backing file after LOOP_CLR_FD: the filesystem on it is still mounted somewhere nobody can reach",
+		       self->dev);
+	/* somebody else may bind it from now on, so the teardown leaves it alone */
+	for (int i = 0; i < self->nr_loops; i++) {
+		char dev[32];
+
+		snprintf(dev, sizeof(dev), "/dev/loop%d", self->loops[i]);
+		if (!strcmp(dev, self->dev))
+			self->loops[i] = -1;
+	}
+}
+
+/*
+ * rmdir of vol from here, where it is not a mountpoint, detaches
+ * the child's tmpfs with the loop mount connected below it. Once the child
+ * is gone nothing refers to either mount. The loop device must then be
+ * free to give up its backing file, which only happens when the mounted
+ * filesystem below the detached tmpfs has been released.
+ */
+TEST_F(loop_cycle, detached_loop_mount_released)
+{
+	int to_parent[2], to_child[2];
+	struct report r = { { -1, -1 } };
+	char buf[PATH_MAX];
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(to_child), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		_exit(loop_child(to_parent[1], to_child[0]));
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+
+	if (read(to_parent[0], &r, sizeof(r)) != sizeof(r))
+		CHILD_GAVE_UP(pid);
+	remember_loop(self, r.n[0]);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", r.n[0]);
+	snprintf(self->sysfs, sizeof(self->sysfs), "/sys/block/loop%d/loop/backing_file", r.n[0]);
+	ASSERT_EQ(read_sysfs(self->sysfs, buf, sizeof(buf)), 0);
+	ASSERT_NE(strstr(buf, "/vol/img"), NULL);
+
+	/* not a mountpoint in this namespace, so the directory can go */
+	ASSERT_EQ(rmdir(at("vol")), 0);
+
+	/* the child leaves: its namespace and every reference it held are gone */
+	ASSERT_EQ(write(to_child[1], "", 1), 1);
+	CHILD_LEFT(pid);
+	close(to_parent[0]);
+	close(to_child[1]);
+
+	/* nothing can reach the two mounts any more */
+	ASSERT_EQ(access(at("vol"), F_OK), -1);
+	ASSERT_FALSE(mounted_anywhere(self->dev));
+
+	assert_loop_released(_metadata, self);
+}
+
+/*
+ * The same two mounts in a detached tree: a clone of vol from
+ * open_tree(), the image opened through the clone so that the loop device
+ * holds the clone, and the loop mount moved below the clone. The last
+ * close of the tree's fd dissolves the tree with the loop mount left
+ * connected below the dead clone, and nothing refers to either afterwards.
+ */
+TEST_F(loop_cycle, dissolved_tree_loop_mount_released)
+{
+	int tfd, ifd, fsfd, mfd, n;
+	char buf[PATH_MAX];
+
+	fsfd = sys_fsopen("vfat", 0);
+	if (fsfd < 0)
+		fsfd = sys_fsopen("msdos", 0);
+	if (fsfd < 0)
+		SKIP(return, "test requires a FAT filesystem");
+
+	ASSERT_EQ(mkdir(at("vol"), 0755), 0);
+	ASSERT_EQ(mount("tmpfs", at("vol"), "tmpfs", 0, NULL), 0);
+	tfd = sys_open_tree(AT_FDCWD, at("vol"), OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+
+	/* the image, opened through the clone: the loop device holds the clone */
+	ifd = openat(tfd, "img", O_RDWR | O_CREAT | O_EXCL, 0600);
+	ASSERT_GE(ifd, 0);
+	ASSERT_EQ(write_fat12(ifd), 0);
+	n = loop_bind(ifd);
+	close(ifd);
+	ASSERT_GE(n, 0);
+	remember_loop(self, n);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", n);
+	snprintf(self->sysfs, sizeof(self->sysfs), "/sys/block/loop%d/loop/backing_file", n);
+
+	/* the loop mount, moved below the clone */
+	ASSERT_EQ(mkdirat(tfd, "mnt", 0755), 0);
+	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", self->dev, 0), 0);
+	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	mfd = sys_fsmount(fsfd, 0, 0);
+	ASSERT_GE(mfd, 0);
+	close(fsfd);
+	ASSERT_EQ(sys_move_mount(mfd, "", tfd, "mnt", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	close(mfd);
+
+	ASSERT_EQ(read_sysfs(self->sysfs, buf, sizeof(buf)), 0);
+	ASSERT_NE(strstr(buf, "img"), NULL);
+
+	/* the last fd of the tree: both mounts die, the loop mount connected */
+	close(tfd);
+
+	/* nothing can reach the two mounts any more */
+	ASSERT_FALSE(mounted_anywhere(self->dev));
+
+	assert_loop_released(_metadata, self);
+}
+
+/*
+ * The cycle in two steps: rmdir of vol leaves the loop mount below it
+ * connected while its image's mount, vol2, is alive; then rmdir of vol2
+ * takes that one with the loop mount whose image is on the dead vol. Each
+ * dead mount now owns a loop mount whose filesystem pins the other.
+ */
+TEST_F(loop_cycle, crossed_images_released)
+{
+	int to_parent[2], to_child[2];
+	struct report r = { { -1, -1 } };
+	char sysfs[2][64], dev[2][32];
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(to_child), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		_exit(crossed_child(to_parent[1], to_child[0]));
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+
+	if (read(to_parent[0], &r, sizeof(r)) != sizeof(r))
+		CHILD_GAVE_UP(pid);
+	for (int i = 0; i < 2; i++) {
+		remember_loop(self, r.n[i]);
+		snprintf(dev[i], sizeof(dev[i]), "/dev/loop%d", r.n[i]);
+		snprintf(sysfs[i], sizeof(sysfs[i]), "/sys/block/loop%d/loop/backing_file", r.n[i]);
+	}
+
+	/* step one: the mount with the first loop mount below it goes */
+	ASSERT_EQ(rmdir(at("vol")), 0);
+
+	/* step two: the other one, with the loop mount whose image is on the first */
+	ASSERT_EQ(rmdir(at("vol2")), 0);
+
+	/* the child leaves: its namespace and every reference it held are gone */
+	ASSERT_EQ(write(to_child[1], "", 1), 1);
+	CHILD_LEFT(pid);
+	close(to_parent[0]);
+	close(to_child[1]);
+
+	/* nothing can reach the four mounts any more */
+	for (int i = 0; i < 2; i++) {
+		ASSERT_FALSE(mounted_anywhere(dev[i]));
+		strcpy(self->dev, dev[i]);
+		strcpy(self->sysfs, sysfs[i]);
+		assert_loop_released(_metadata, self);
+	}
+}
+
+/*
+ * The holders. Each keeps a file or a path on a mount P for as long as
+ * its own filesystem or device lives, and each has that filesystem or
+ * device mounted at C below P. Once another namespace's rmdir has
+ * detached P with C connected below it and the child is gone, P is owned
+ * by nobody, C by P, and P is kept by whatever the holder still holds.
+ *
+ * P is a loop mount so that its death can be observed: the loop device
+ * gives its backing file up when P's superblock goes. The image sits on
+ * a tmpfs next to P, not above it, so the loop device's own reference is
+ * not part of the picture.
+ */
+enum holder {
+	HOLDER_AUTOFS,		/* a FIFO on P as the daemon's pipe */
+	HOLDER_ZRAM,		/* a device node on P as the writeback device */
+	HOLDER_ECRYPTFS,	/* a directory on P as the lower directory */
+	HOLDER_BINFMT_MISC,	/* an executable on P as an 'F' interpreter */
+	HOLDER_FUSE,		/* a file on P as a passthrough backing file */
+	HOLDER_ZLOOP,		/* a directory on P for the zone files */
+	HOLDER_GADGET,		/* a file on P as a mass storage LUN, over dummy_hcd */
+	HOLDER_MD,		/* a file on P as an array's bitmap file */
+};
+
+#define HOLDER_IMG	at("img/p.img")
+#define HOLDER_MNT	at("p")
+#define HOLDER_BELOW	at("p/c")
+
+static int write_file(const char *path, const char *s)
+{
+	int fd = open(path, O_WRONLY);
+	ssize_t n;
+
+	if (fd < 0)
+		return -1;
+	n = write(fd, s, strlen(s));
+	close(fd);
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+/* Bind a free loop device to @img; the device number. */
+static int loop_attach(const char *img)
+{
+	int ifd, n;
+
+	ifd = open(img, O_RDWR);
+	if (ifd < 0)
+		return -1;
+	n = loop_bind(ifd);
+	close(ifd);
+	return n;
+}
+
+static int holder_autofs(void)
+{
+	char opts[64];
+	int pfd;
+
+	if (mkfifo(at("p/pipe"), 0600))
+		return CHILD_HOLDER;
+	pfd = open(at("p/pipe"), O_RDWR);
+	if (pfd < 0)
+		return CHILD_HOLDER;
+	snprintf(opts, sizeof(opts), "fd=%d,minproto=5,maxproto=5", pfd);
+	if (mount("autofs", HOLDER_BELOW, "autofs", 0, opts))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+	close(pfd);	/* the mount keeps its own */
+	return CHILD_OK;
+}
+
+/*
+ * zram's writeback device has to be a block device node, and that node has
+ * to be on P. Point it at a second loop device.
+ */
+static void zram_reset(void);
+
+static int holder_zram(void)
+{
+	char dev[32], buf[64];
+	struct stat st;
+	int fd, n;
+
+	if (access("/sys/block/zram0/backing_dev", W_OK))
+		return CHILD_SKIP;
+	/* somebody else's device, leave it alone */
+	if (read_sysfs("/sys/block/zram0/initstate", buf, sizeof(buf)) || buf[0] != '0')
+		return CHILD_SKIP;
+	fd = open(at("img/wb.img"), O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (fd < 0 || ftruncate(fd, IMAGE_SIZE))
+		return CHILD_HOLDER;
+	close(fd);
+	n = loop_attach(at("img/wb.img"));
+	if (n < 0)
+		return CHILD_HOLDER;
+	/* the minor is not the number of the device when loop has partitions */
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	if (stat(dev, &st) || mknod(at("p/wbdev"), S_IFBLK | 0600, st.st_rdev))
+		return CHILD_HOLDER;
+	if (write_file("/sys/block/zram0/backing_dev", at("p/wbdev")))
+		return CHILD_HOLDER;
+	snprintf(buf, sizeof(buf), "%d", 4 * 1024 * 1024);
+	if (write_file("/sys/block/zram0/disksize", buf))
+		goto undo;
+	fd = open("/dev/zram0", O_RDWR);
+	if (fd < 0)
+		goto undo;
+	n = write_fat12_4k(fd, 1024);	/* zram has 4 KiB blocks */
+	close(fd);	/* the reset in undo is refused while the device is open */
+	if (n)
+		goto undo;
+	if (mount_fat("/dev/zram0", HOLDER_BELOW)) {
+		n = errno == ENODEV ? CHILD_NOFS : CHILD_HOLDER;
+		zram_reset();
+		return n;
+	}
+	return CHILD_OK;
+undo:
+	zram_reset();
+	return CHILD_HOLDER;
+}
+
+/* Is @alg in /proc/crypto? A module is listed once a request has loaded it. */
+static bool crypto_has(const char *alg)
+{
+	char line[256], name[64];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/crypto", "r");
+	if (!f)
+		return true;	/* no way to tell, assume it is */
+	while (!found && fgets(line, sizeof(line), f))
+		found = sscanf(line, "name : %63s", name) == 1 && !strcmp(name, alg);
+	fclose(f);
+	return found;
+}
+
+/* The kernel's auth token layout, which userspace has to match byte for byte. */
+struct ecryptfs_auth_tok {
+	__u16 version;
+	__u16 token_type;
+	__u32 flags;
+	struct {
+		__u32 flags, encrypted_key_size, decrypted_key_size;
+		__u8 encrypted_key[512], decrypted_key[64];
+	} session_key;
+	__u8 reserved[32];
+	struct {
+		__u32 password_bytes;
+		__s32 hash_algo;
+		__u32 hash_iterations, session_key_encryption_key_bytes, flags;
+		__u8 session_key_encryption_key[64];
+		__u8 signature[17];
+		__u8 salt[8];
+	} password;
+} __attribute__((packed));
+
+#define ECRYPTFS_SIG	"0123456789abcdef"
+
+static int holder_ecryptfs(void)
+{
+	struct ecryptfs_auth_tok tok = {
+		.version = 0x0004,
+		.token_type = 0,		/* ECRYPTFS_PASSWORD */
+		.password.session_key_encryption_key_bytes = 16,
+		.password.flags = 0x02,		/* ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET */
+		.password.signature = ECRYPTFS_SIG,
+	};
+
+	/* a session keyring of this child's own, so that the key goes with it */
+	if (syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL) < 0)
+		return errno == ENOSYS ? CHILD_SKIP : CHILD_HOLDER;
+	if (syscall(__NR_add_key, "user", ECRYPTFS_SIG, &tok, sizeof(tok),
+		    KEY_SPEC_SESSION_KEYRING) < 0)
+		return CHILD_HOLDER;
+	if (mkdir(at("p/lower"), 0755))
+		return CHILD_HOLDER;
+	if (mount(at("p/lower"), HOLDER_BELOW, "ecryptfs", 0,
+		  "ecryptfs_sig=" ECRYPTFS_SIG ",ecryptfs_cipher=aes,ecryptfs_key_bytes=16")) {
+		/* EINVAL without the cipher; a module is loaded by the attempt */
+		if (errno == ENODEV || (errno == EINVAL && !crypto_has("aes")))
+			return CHILD_SKIP;
+		return CHILD_HOLDER;
+	}
+	return CHILD_OK;
+}
+
+/*
+ * binfmt_misc instances are per user namespace, so the mount below P is
+ * made from a new one, which gets a copy of P.
+ */
+static int holder_binfmt_misc(void)
+{
+	static const char interp[] = "#!/bin/true\n";
+	char reg[PATH_MAX];
+	int out;
+
+	/* 'F' opens the interpreter at registration, nothing runs it here */
+	out = open(at("p/interp"), O_WRONLY | O_CREAT | O_EXCL, 0755);
+	if (out < 0 || write(out, interp, sizeof(interp) - 1) != sizeof(interp) - 1)
+		return CHILD_HOLDER;
+	close(out);
+
+	/* ENOSPC: user.max_user_namespaces is 0, EPERM: an LSM says no */
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS)) {
+		if (errno == EINVAL || errno == ENOSPC || errno == EPERM)
+			return CHILD_SKIP;
+		return CHILD_HOLDER;
+	}
+	if (write_file("/proc/self/setgroups", "deny") ||
+	    write_file("/proc/self/uid_map", "0 0 1") ||
+	    write_file("/proc/self/gid_map", "0 0 1"))
+		return CHILD_HOLDER;
+	if (mount("binfmt_misc", HOLDER_BELOW, "binfmt_misc", 0, NULL))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+	snprintf(reg, sizeof(reg), ":cycle:E::cyc::%s:F", at("p/interp"));
+	if (write_file(at("p/c/register"), reg))
+		return CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+/*
+ * A fuse server that only ever answers FUSE_INIT, with passthrough on, and
+ * then registers a file on P as a backing file. The registration alone
+ * makes the fuse superblock hold the file.
+ */
+static int holder_fuse(void)
+{
+	struct fuse_backing_map map = {};
+	struct fuse_in_header *ih;
+	struct fuse_init_out init = {
+		.major = FUSE_KERNEL_VERSION,
+		.minor = FUSE_KERNEL_MINOR_VERSION,
+		.flags = FUSE_INIT_EXT,
+		.flags2 = FUSE_PASSTHROUGH >> 32,
+		.max_write = 4096,
+		.max_stack_depth = 1,
+	};
+	struct fuse_out_header oh = { .len = sizeof(oh) + sizeof(init) };
+	struct iovec iov[2] = { { &oh, sizeof(oh) }, { &init, sizeof(init) } };
+	char opts[64], buf[8192];
+	int ffd, bfd;
+	ssize_t n;
+
+	bfd = open(at("p/backing"), O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (bfd < 0)
+		return CHILD_HOLDER;
+	ffd = open("/dev/fuse", O_RDWR);
+	if (ffd < 0)
+		return CHILD_SKIP;
+	snprintf(opts, sizeof(opts), "fd=%d,rootmode=40000,user_id=0,group_id=0", ffd);
+	if (mount("fuse", HOLDER_BELOW, "fuse", 0, opts))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+
+	n = read(ffd, buf, sizeof(buf));
+	ih = (void *)buf;
+	if (n < (ssize_t)sizeof(*ih) || ih->opcode != FUSE_INIT)
+		return CHILD_HOLDER;
+	oh.unique = ih->unique;
+	if (writev(ffd, iov, 2) != (ssize_t)oh.len)
+		return CHILD_HOLDER;
+
+	map.fd = bfd;
+	if (ioctl(ffd, FUSE_DEV_IOC_BACKING_OPEN, &map) < 0) {
+		/* EOPNOTSUPP: no FUSE_PASSTHROUGH, ENOTTY: no such ioctl */
+		if (errno == EPERM || errno == EOPNOTSUPP || errno == ENOTTY)
+			return CHILD_SKIP;
+		return CHILD_HOLDER;
+	}
+	close(bfd);	/* the connection keeps its own */
+	return CHILD_OK;	/* ffd stays open until the child exits */
+}
+
+/* Wait for a device node the kernel is about to create. */
+static int open_when_there(const char *dev, int flags, int ms)
+{
+	int fd;
+
+	for (; ms > 0; ms -= 100) {
+		fd = open(dev, flags);
+		if (fd >= 0)
+			return fd;
+		usleep(100000);
+	}
+	return -1;
+}
+
+/*
+ * zloop keeps every zone file open. One conventional zone is enough for a
+ * FAT image, the sequential one stays empty.
+ */
+static int holder_zloop(void)
+{
+	char cmd[PATH_MAX];
+	int fd, ret = CHILD_HOLDER;
+
+	if (access("/dev/zloop-control", W_OK))
+		return CHILD_SKIP;
+	/* somebody else's device, leave it alone */
+	if (!access("/sys/block/zloop0", F_OK))
+		return CHILD_SKIP;
+	if (mkdir(at("p/zl"), 0755) || mkdir(at("p/zl/0"), 0755))
+		return CHILD_HOLDER;
+	snprintf(cmd, sizeof(cmd),
+		 "add id=0,capacity_mb=8,zone_size_mb=4,conv_zones=1,base_dir=%s",
+		 at("p/zl"));
+	if (write_file("/dev/zloop-control", cmd))
+		return CHILD_HOLDER;
+	fd = open_when_there("/dev/zloop0", O_RDWR, 5000);
+	if (fd < 0 || write_fat12_4k(fd, 1024))	/* 4 KiB blocks, like P */
+		goto undo;
+	close(fd);
+	fd = -1;
+	if (mount_fat("/dev/zloop0", HOLDER_BELOW)) {
+		ret = errno == ENODEV ? CHILD_NOFS : CHILD_HOLDER;
+		goto undo;
+	}
+	return CHILD_OK;
+undo:
+	if (fd >= 0)
+		close(fd);
+	write_file("/dev/zloop-control", "remove id=0");
+	return ret;
+}
+
+static int mount_configfs(void)
+{
+	if (access("/sys/kernel/config", F_OK))
+		return -1;
+	if (mount("configfs", "/sys/kernel/config", "configfs", 0, NULL) && errno != EBUSY)
+		return -1;
+	return 0;
+}
+
+/* Take the gadget out of configfs again, in the reverse order of its creation. */
+static void gadget_remove(void)
+{
+	if (mount_configfs())
+		return;
+	write_file(gat("/functions/mass_storage.0/lun.0/file"), "\n");
+	write_file(gat("/UDC"), "\n");
+	unlink(gat("/configs/c.1/mass_storage.0"));
+	rmdir(gat("/configs/c.1/strings/0x409"));
+	rmdir(gat("/configs/c.1"));
+	rmdir(gat("/functions/mass_storage.0"));
+	rmdir(gat("/strings/0x409"));
+	rmdir(gat(""));
+}
+
+/* The disk usb-storage created for the gadget, by the LUN's inquiry string. */
+static int find_gadget_disk(char *dev, size_t len, int ms)
+{
+	char path[PATH_MAX], model[64];
+	struct dirent *de;
+	DIR *d;
+
+	for (; ms > 0; ms -= 100, usleep(100000)) {
+		d = opendir("/sys/block");
+		if (!d)
+			return -1;
+		while ((de = readdir(d))) {
+			if (strncmp(de->d_name, "sd", 2))
+				continue;
+			snprintf(path, sizeof(path), "/sys/block/%s/device/model", de->d_name);
+			if (read_sysfs(path, model, sizeof(model)) ||
+			    strncmp(model, "File-Stor Gadget", 16))
+				continue;
+			snprintf(dev, len, "/dev/%s", de->d_name);
+			closedir(d);
+			return 0;
+		}
+		closedir(d);
+	}
+	return -1;
+}
+
+/*
+ * A mass storage gadget bound to the dummy UDC, so that this kernel is
+ * also the USB host that sees the LUN as a SCSI disk. sd locks the
+ * medium on open, which is what keeps the LUN's file from being ejected.
+ */
+#define GADGET_STEP(x) do {						\
+	if (x) {							\
+		fprintf(stderr, "gadget: %s failed: %s\n", #x, strerror(errno)); \
+		gadget_remove();					\
+		return CHILD_HOLDER;					\
+	}								\
+} while (0)
+
+static int holder_gadget(void)
+{
+	char dev[PATH_MAX];
+	int fd;
+
+	if (mount_configfs())
+		return CHILD_SKIP;
+	if (access("/sys/kernel/config/usb_gadget", F_OK) ||
+	    access("/sys/class/udc/dummy_udc.0", F_OK))
+		return CHILD_SKIP;
+
+	fd = open(at("p/lun.img"), O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (fd < 0 || write_fat12(fd))
+		return CHILD_HOLDER;
+	close(fd);
+
+	GADGET_STEP(mkdir(gat(""), 0755));
+	GADGET_STEP(write_file(gat("/idVendor"), "0x1d6b"));
+	GADGET_STEP(write_file(gat("/idProduct"), "0x0104"));
+	GADGET_STEP(mkdir(gat("/strings/0x409"), 0755));
+	GADGET_STEP(write_file(gat("/strings/0x409/serialnumber"), "1"));
+	GADGET_STEP(write_file(gat("/strings/0x409/manufacturer"), "kselftest"));
+	GADGET_STEP(write_file(gat("/strings/0x409/product"), "cycle"));
+	GADGET_STEP(mkdir(gat("/configs/c.1"), 0755));
+	GADGET_STEP(mkdir(gat("/configs/c.1/strings/0x409"), 0755));
+	GADGET_STEP(write_file(gat("/configs/c.1/strings/0x409/configuration"), "c"));
+	GADGET_STEP(mkdir(gat("/functions/mass_storage.0"), 0755));
+	GADGET_STEP(write_file(gat("/functions/mass_storage.0/lun.0/removable"), "1"));
+	GADGET_STEP(write_file(gat("/functions/mass_storage.0/lun.0/file"), at("p/lun.img")));
+	GADGET_STEP(symlink(gat("/functions/mass_storage.0"), gat("/configs/c.1/mass_storage.0")));
+	/* EBUSY: the controller is somebody else's, leave it alone */
+	if (write_file(gat("/UDC"), "dummy_udc.0")) {
+		fd = errno == EBUSY ? CHILD_SKIP : CHILD_HOLDER;
+		gadget_remove();
+		return fd;
+	}
+
+	/* usb-storage waits a second before it scans the device */
+	if (find_gadget_disk(dev, sizeof(dev), 15000)) {
+		/* without usb-storage and sd the LUN never shows up as a disk */
+		fd = (access("/sys/bus/usb/drivers/usb-storage", F_OK) ||
+		      access("/sys/bus/scsi/drivers/sd", F_OK)) ? CHILD_SKIP : CHILD_HOLDER;
+		gadget_remove();
+		return fd;
+	}
+	fd = open_when_there(dev, O_RDONLY, 5000);
+	GADGET_STEP(fd < 0);
+	close(fd);
+	if (mount_fat(dev, HOLDER_BELOW)) {
+		fd = errno == ENODEV ? CHILD_NOFS : CHILD_HOLDER;
+		gadget_remove();
+		return fd;
+	}
+	return CHILD_OK;
+}
+
+#define BITMAP_MAGIC	0x6d746962
+
+/*
+ * A RAID1 of one loop device, not persistent, with its bitmap in a file
+ * on P. The bitmap file needs a superblock the kernel accepts; sync_size,
+ * uuid and events are not looked at for a non-persistent array.
+ */
+static int holder_md(void)
+{
+	struct {
+		__u32 magic, version;
+		__u8 uuid[16];
+		__u64 events, events_cleared, sync_size;
+		__u32 state, chunksize, daemon_sleep, write_behind;
+	} bsb = {
+		.magic = BITMAP_MAGIC,
+		.version = 4,
+		.chunksize = 64 * 1024,
+		.daemon_sleep = 5,
+	};
+	mdu_array_info_t info = {
+		.level = 1,
+		.raid_disks = 1,
+		.size = 8 * 1024,		/* KiB */
+		.not_persistent = 1,
+	};
+	mdu_disk_info_t disk = {
+		.major = 7,
+		.state = (1 << MD_DISK_ACTIVE) | (1 << MD_DISK_SYNC),
+	};
+	int fd, mdfd, bfd, n, ret = CHILD_HOLDER;
+	char dev[32], buf[4096];
+	struct stat st;
+
+	fd = open(at("img/md.img"), O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (fd < 0 || ftruncate(fd, 8 * 1024 * 1024))
+		return CHILD_HOLDER;
+	close(fd);
+	n = loop_attach(at("img/md.img"));
+	if (n < 0)
+		return CHILD_HOLDER;
+	/* the minor is not the number of the device when loop has partitions */
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	if (stat(dev, &st))
+		return CHILD_HOLDER;
+	disk.major = major(st.st_rdev);
+	disk.minor = minor(st.st_rdev);
+
+	bfd = open(at("p/bitmap"), O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (bfd < 0 || write(bfd, &bsb, sizeof(bsb)) != sizeof(bsb) || ftruncate(bfd, 4096))
+		return CHILD_HOLDER;
+
+	if (read_sysfs("/proc/mdstat", buf, sizeof(buf))) {
+		fprintf(stderr, "md: no /proc/mdstat\n");
+		return CHILD_SKIP;
+	}
+	if (!strstr(buf, "[raid1]")) {
+		fprintf(stderr, "md: no raid1 personality: %s\n", buf);
+		return CHILD_SKIP;
+	}
+	/* a node of our own: /dev may not have one and is not ours to change */
+	if (mknod(at("img/md0"), S_IFBLK | 0600, makedev(MD_MAJOR, 0)))
+		return CHILD_HOLDER;
+	mdfd = open(at("img/md0"), O_RDWR);
+	if (mdfd < 0)
+		return CHILD_SKIP;
+	/* somebody else's array: SET_ARRAY_INFO would say EINVAL, not EBUSY */
+	if (!read_sysfs("/sys/block/md0/md/array_state", buf, sizeof(buf)) &&
+	    strncmp(buf, "clear", 5)) {
+		fprintf(stderr, "md: md0 is in use: %s", buf);
+		close(mdfd);
+		return CHILD_SKIP;
+	}
+	/* the bitmap ops are only installed once a bitmap type is chosen */
+	write_file("/sys/block/md0/md/bitmap_type", "bitmap");
+	/* EBUSY: somebody else's array, leave it alone */
+	if (ioctl(mdfd, SET_ARRAY_INFO, &info))
+		return errno == EBUSY ? CHILD_SKIP : CHILD_HOLDER;
+	/* the array is ours from here on and has to be stopped on every path */
+	if (ioctl(mdfd, ADD_NEW_DISK, &disk))
+		goto undo;
+	/* attach the bitmap file before the array runs, the way mdadm does */
+	if (ioctl(mdfd, SET_BITMAP_FILE, bfd)) {
+		fprintf(stderr, "md: SET_BITMAP_FILE: %s\n", strerror(errno));
+		if (errno == EINVAL)
+			ret = CHILD_SKIP;
+		goto undo;
+	}
+	close(bfd);	/* the array keeps its own */
+	if (ioctl(mdfd, RUN_ARRAY, NULL)) {
+		fprintf(stderr, "md: RUN_ARRAY: %s\n", strerror(errno));
+		goto undo;
+	}
+	if (write_fat12(mdfd))
+		goto undo;
+	close(mdfd);
+	if (mount_fat(at("img/md0"), HOLDER_BELOW)) {
+		ret = errno == ENODEV ? CHILD_NOFS : CHILD_HOLDER;
+		mdfd = open(at("img/md0"), O_RDWR);
+		goto undo;
+	}
+	return CHILD_OK;
+undo:
+	if (mdfd >= 0) {
+		ioctl(mdfd, STOP_ARRAY);
+		close(mdfd);
+	}
+	return ret;
+}
+
+/*
+ * A device keeps its file for as long as it is configured, so once nothing
+ * below the dead mount is left the device has to be told to let go. With
+ * the cycle unbroken C's filesystem still holds the device and every one
+ * of these refuses.
+ */
+static int holder_let_go_once(enum holder holder)
+{
+	int fd, ret;
+
+	switch (holder) {
+	case HOLDER_ZRAM:
+		return write_file("/sys/block/zram0/reset", "1");
+	case HOLDER_ZLOOP:
+		return write_file("/dev/zloop-control", "remove id=0");
+	case HOLDER_GADGET:
+		if (mount_configfs())
+			return -1;
+		/* a zero-length write is a no-op for configfs; a newline ejects */
+		return write_file(gat("/functions/mass_storage.0/lun.0/file"), "\n");
+	case HOLDER_MD:
+		fd = open(at("img/md0"), O_RDONLY);
+		if (fd < 0) {
+			/* the child's node went with its tmpfs */
+			mknod(at("md0"), S_IFBLK | 0600, makedev(MD_MAJOR, 0));
+			fd = open(at("md0"), O_RDONLY);
+		}
+		if (fd < 0)
+			return -1;
+		ret = ioctl(fd, STOP_ARRAY);
+		close(fd);
+		return ret;
+	default:
+		return 0;
+	}
+}
+
+static void zram_reset(void)
+{
+	holder_let_go_once(HOLDER_ZRAM);
+}
+
+/*
+ * In its own mount namespace the child puts the image on a tmpfs next to
+ * P, mounts P from a loop device, and sets the holder up with its own
+ * filesystem or device mounted at C below P.
+ */
+static int holder_child(int to_parent, int from_parent, enum holder holder)
+{
+	bool fifo = holder == HOLDER_AUTOFS || holder == HOLDER_ZRAM;
+	/* room for a 4 MiB zone file or a floppy image on P */
+	bool big = holder == HOLDER_ZLOOP || holder == HOLDER_GADGET;
+	struct report r = { { -1, -1 } };
+	char dev[32], c;
+	int ifd, n, ret;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_NS;
+	if (mkdir(at("img"), 0755) || mount("tmpfs", at("img"), "tmpfs", 0, NULL))
+		return child_fails(CHILD_NS);
+
+	ifd = open(HOLDER_IMG, O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (ifd < 0 || (fifo ? write_minix(ifd) :
+			big ? write_fat12_4k(ifd, 3072) : write_fat12(ifd)))
+		return child_fails(CHILD_IMAGE);
+	close(ifd);
+	n = loop_attach(HOLDER_IMG);
+	if (n < 0)
+		return child_fails(CHILD_LOOP);
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	if (mkdir(HOLDER_MNT, 0755))
+		return child_fails(CHILD_MOUNT);
+	if (fifo ? mount(dev, HOLDER_MNT, "minix", 0, NULL) : mount_fat(dev, HOLDER_MNT))
+		return child_fails(errno == ENODEV ? CHILD_NOFS : CHILD_MOUNT);
+	if (mkdir(HOLDER_BELOW, 0755))
+		return child_fails(CHILD_MOUNT);
+
+	switch (holder) {
+	case HOLDER_AUTOFS:
+		ret = holder_autofs();
+		break;
+	case HOLDER_ZRAM:
+		ret = holder_zram();
+		break;
+	case HOLDER_ECRYPTFS:
+		ret = holder_ecryptfs();
+		break;
+	case HOLDER_BINFMT_MISC:
+		ret = holder_binfmt_misc();
+		break;
+	case HOLDER_FUSE:
+		ret = holder_fuse();
+		break;
+	case HOLDER_ZLOOP:
+		ret = holder_zloop();
+		break;
+	case HOLDER_GADGET:
+		ret = holder_gadget();
+		break;
+	case HOLDER_MD:
+		ret = holder_md();
+		break;
+	default:
+		ret = CHILD_HOLDER;
+	}
+	if (ret != CHILD_OK)
+		return child_fails(ret);
+
+	/* P's device first, then the one the holder has bound for itself */
+	r.n[0] = n;
+	if (nr_bound > 1)
+		r.n[1] = bound[1];
+	if (write(to_parent, &r, sizeof(r)) != sizeof(r) ||
+	    read(from_parent, &c, 1) != 1) {
+		/* the parent went away and will not tell the devices to let go */
+		umount2(HOLDER_BELOW, MNT_DETACH);
+		for (int i = 0; i < 50 && holder_let_go_once(holder); i++)
+			usleep(100000);
+		if (holder == HOLDER_GADGET)
+			gadget_remove();
+		return child_fails(CHILD_PIPE);
+	}
+	return CHILD_OK;
+}
+
+/*
+ * The release of C's filesystem may still be in flight when the child is
+ * gone, and a device that is still held refuses to let go, so try for a
+ * while. With the cycle unbroken it refuses for good.
+ */
+static void holder_let_go(enum holder holder)
+{
+	for (int i = 0; i < 50; i++) {
+		if (!holder_let_go_once(holder))
+			return;
+		usleep(100000);
+	}
+}
+
+/*
+ * rmdir of p from here, where it is a plain directory, detaches
+ * P in the child's namespace with C connected below it. Once the child is
+ * gone the holder's file on P is the only thing left that refers to P,
+ * and it is dropped only when C's filesystem dies, which waits for P.
+ * The loop device backing P tells whether that resolved.
+ */
+static void holder_cycle(struct __test_metadata *_metadata,
+			 FIXTURE_DATA(loop_cycle) *self, enum holder holder)
+{
+	struct report r = { { -1, -1 } };
+	int to_parent[2], from_parent[2];
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(from_parent), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(from_parent[1]);
+		_exit(holder_child(to_parent[1], from_parent[0], holder));
+	}
+	close(to_parent[1]);
+	close(from_parent[0]);
+
+	if (read(to_parent[0], &r, sizeof(r)) != sizeof(r))
+		CHILD_GAVE_UP(pid);
+	self->gadget = holder == HOLDER_GADGET;
+	remember_loop(self, r.n[0]);
+	remember_loop(self, r.n[1]);
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", r.n[0]);
+	snprintf(self->sysfs, sizeof(self->sysfs), "/sys/block/loop%d/loop/backing_file", r.n[0]);
+
+	ASSERT_EQ(rmdir(HOLDER_MNT), 0);
+	ASSERT_EQ(write(from_parent[1], "x", 1), 1);
+	CHILD_LEFT(pid);
+	close(to_parent[0]);
+	close(from_parent[1]);
+
+	holder_let_go(holder);
+	assert_loop_released(_metadata, self);
+	/* the teardown takes the gadget and the holder's own loop device away */
+}
+
+TEST_F(loop_cycle, autofs_pipe_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_AUTOFS);
+}
+
+TEST_F(loop_cycle, zram_writeback_node_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_ZRAM);
+}
+
+TEST_F(loop_cycle, ecryptfs_lower_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_ECRYPTFS);
+}
+
+TEST_F(loop_cycle, binfmt_misc_interpreter_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_BINFMT_MISC);
+}
+
+TEST_F(loop_cycle, fuse_backing_file_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_FUSE);
+}
+
+TEST_F(loop_cycle, zloop_zone_files_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_ZLOOP);
+}
+
+/* up to 15 s for the disk to show up and 12 s for a device that is held */
+TEST_F_TIMEOUT(loop_cycle, mass_storage_lun_on_dead_mount_released, 120)
+{
+	holder_cycle(_metadata, self, HOLDER_GADGET);
+}
+
+TEST_F(loop_cycle, md_bitmap_file_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_MD);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/mount_cycle/mount_cover_test.c b/tools/testing/selftests/filesystems/mount_cycle/mount_cover_test.c
new file mode 100644
index 000000000000..e3092454ae68
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/mount_cover_test.c
@@ -0,0 +1,565 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An unmounted mount that would have stayed attached to its unmounted parent
+ * leaves a cover behind instead. A lookup on the parent at the mountpoint
+ * finds knullfs: an empty read-only directory that is shared by every cover
+ * and every kernel thread, so it can't be watched or locked and nothing can
+ * be mounted on it. The mount itself is a root from then on. Where a file
+ * was mounted, the stand-in is an empty regular file of the same instance.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/fanotify.h>
+#include <sys/file.h>
+#include <sys/inotify.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+#include <sys/syscall.h>
+#include <sys/vfs.h>
+#include <sys/wait.h>
+
+#include "../../kselftest_harness.h"
+#include "../readdir_hold.h"
+
+#ifndef NULL_FS_MAGIC
+#define NULL_FS_MAGIC 0x4E554C4C
+#endif
+
+#ifndef TMPFS_MAGIC
+#define TMPFS_MAGIC 0x01021994
+#endif
+
+#ifndef F_SETDELEG
+#define F_SETDELEG	(F_SETLEASE + 16)
+#endif
+
+/* struct delegation of <linux/fcntl.h>, which doesn't mix with <fcntl.h> */
+struct delegation_req {
+	uint32_t d_flags;
+	uint16_t d_type;
+	uint16_t __pad;
+};
+
+#define DIR_LEN 64
+#define PATH_LEN 128
+
+/* what the parent asks the child to do */
+#define CMD_RMDIR	'r'
+#define CMD_CLOSE_T	't'
+#define CMD_QUIT	'q'
+
+static int write_file(const char *path, const char *s)
+{
+	ssize_t n = -1;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd >= 0) {
+		n = write(fd, s, strlen(s));
+		close(fd);
+	}
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+static int touch(const char *path)
+{
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (fd < 0)
+		return -1;
+	close(fd);
+	return 0;
+}
+
+/* Become root in a new user namespace with a private mount namespace. */
+static int enter_userns(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map[32];
+
+	prctl(PR_SET_DUMPABLE, 1);
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+		return -1;
+	if (write_file("/proc/self/setgroups", "deny") && errno != ENOENT)
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map))
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map))
+		return -1;
+	if (setgid(0) || setuid(0))
+		return -1;
+	return mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+}
+
+/*
+ * The child mounts P on @base/p, C on P/covered and the file P/src on P/file
+ * in a mount namespace of its own, binds P a second time at @base/q and hands
+ * out descriptors on P and on C. rmdir() of @base/p from here unmounts P
+ * together with C and the file bind. P and C are held by the descriptors and
+ * the unmounted children leave their covers behind. On request the child
+ * removes C's mountpoint through the bind.
+ *
+ * It also mounts T on @base/t with a child on T/covered, binds T at @base/u
+ * with a second child on the same dentry and hands out descriptors on T and
+ * U. rmdir() of both from here leaves two covers on one mountpoint. On request
+ * the child lets go of T.
+ */
+static int cover_child(const char *base, int to_parent, int from_parent)
+{
+	char p[PATH_LEN], c[PATH_LEN], q[PATH_LEN], qc[PATH_LEN];
+	char f[PATH_LEN], src[PATH_LEN], t[PATH_LEN], u[PATH_LEN], tc[PATH_LEN];
+	int fds[4], ret;
+	char cmd;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return 1;
+	snprintf(p, sizeof(p), "%s/p", base);
+	if (mkdir(p, 0755) || mount("tmpfs", p, "tmpfs", 0, NULL))
+		return 2;
+	snprintf(c, sizeof(c), "%s/p/covered", base);
+	if (mkdir(c, 0755) || mount("tmpfs", c, "tmpfs", 0, NULL))
+		return 3;
+	snprintf(f, sizeof(f), "%s/p/file", base);
+	snprintf(src, sizeof(src), "%s/p/src", base);
+	if (touch(src) || touch(f) || mount(src, f, NULL, MS_BIND, NULL))
+		return 4;
+	snprintf(q, sizeof(q), "%s/q", base);
+	if (mkdir(q, 0755) || mount(p, q, NULL, MS_BIND, NULL))
+		return 5;
+	snprintf(t, sizeof(t), "%s/t", base);
+	if (mkdir(t, 0755) || mount("tmpfs", t, "tmpfs", 0, NULL))
+		return 6;
+	snprintf(tc, sizeof(tc), "%s/t/covered", base);
+	if (mkdir(tc, 0755) || mount("tmpfs", tc, "tmpfs", 0, NULL))
+		return 7;
+	snprintf(u, sizeof(u), "%s/u", base);
+	if (mkdir(u, 0755) || mount(t, u, NULL, MS_BIND, NULL))
+		return 8;
+	snprintf(tc, sizeof(tc), "%s/u/covered", base);
+	if (mount("tmpfs", tc, "tmpfs", 0, NULL))
+		return 9;
+	fds[0] = open(p, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	fds[1] = open(c, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	fds[2] = open(t, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	fds[3] = open(u, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	if (fds[0] < 0 || fds[1] < 0 || fds[2] < 0 || fds[3] < 0)
+		return 10;
+	if (write(to_parent, fds, sizeof(fds)) != sizeof(fds))
+		return 11;
+
+	snprintf(qc, sizeof(qc), "%s/q/covered", base);
+	for (;;) {
+		if (read(from_parent, &cmd, 1) != 1)
+			return 12;
+		switch (cmd) {
+		case CMD_RMDIR:
+			ret = rmdir(qc) ? errno : 0;
+			if (write(to_parent, &ret, sizeof(ret)) != sizeof(ret))
+				return 13;
+			break;
+		case CMD_CLOSE_T:
+			ret = close(fds[2]) ? errno : 0;
+			if (write(to_parent, &ret, sizeof(ret)) != sizeof(ret))
+				return 13;
+			break;
+		case CMD_QUIT:
+			return 0;
+		default:
+			return 14;
+		}
+	}
+}
+
+FIXTURE(mount_cover) {
+	char base[DIR_LEN];
+	pid_t child;
+	int to_child;
+	int from_child;
+	int dfd;	/* P, unmounted, held */
+	int cfd;	/* C, unmounted, held */
+	int fd;		/* what a lookup on P finds at C's mountpoint */
+	int tfd;	/* T, unmounted, held */
+	int ufd;	/* U, a bind of T, unmounted, held */
+	int fan;	/* fanotify group from before the user namespace, or -1 */
+	struct readdir_hold hold;	/* likewise from before, uffd -1 without */
+};
+
+/*
+ * Everything the setup has made. The harness does not run the teardown
+ * when an assertion of the setup fails, so the setup calls this itself.
+ */
+static void cover_cleanup(FIXTURE_DATA(mount_cover) *self)
+{
+	char cmd = CMD_QUIT;
+	int status;
+
+	if (self->fd >= 0)
+		close(self->fd);
+	if (self->cfd >= 0)
+		close(self->cfd);
+	if (self->dfd >= 0)
+		close(self->dfd);
+	if (self->tfd >= 0)
+		close(self->tfd);
+	if (self->ufd >= 0)
+		close(self->ufd);
+	if (self->fan >= 0)
+		close(self->fan);
+	readdir_hold_destroy(&self->hold);
+	if (self->child > 0) {
+		if (write(self->to_child, &cmd, 1) != 1)
+			kill(self->child, SIGKILL);
+		waitpid(self->child, &status, 0);
+	}
+	if (self->to_child >= 0)
+		close(self->to_child);
+	if (self->from_child >= 0)
+		close(self->from_child);
+	umount2(self->base, MNT_DETACH);
+	rmdir(self->base);
+}
+
+static int same_file(int fd1, int fd2)
+{
+	struct stat st1, st2;
+
+	if (fstat(fd1, &st1) || fstat(fd2, &st2))
+		return 0;
+	return st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino;
+}
+
+FIXTURE_SETUP(mount_cover)
+{
+	int to_parent[2], to_child[2], fds[4], pidfd, status;
+	char dir[PATH_LEN];
+	struct statfs sf;
+
+	self->child = 0;
+	self->to_child = self->from_child = -1;
+	self->dfd = self->cfd = self->fd = self->tfd = self->ufd = -1;
+
+	/*
+	 * A group for plain events takes CAP_SYS_ADMIN in the initial user
+	 * namespace, so get one before that is gone. An inode mark can be
+	 * added to it from anywhere.
+	 */
+	self->fan = fanotify_init(FAN_CLASS_NOTIF | FAN_CLOEXEC, O_RDONLY);
+	/* same for the userfaultfd that holds a readdir in its fault */
+	readdir_hold_init(&self->hold);
+
+	snprintf(self->base, sizeof(self->base), "/tmp/mount_cover.XXXXXX");
+	ASSERT_NE(mkdtemp(self->base), NULL);
+	if (enter_userns()) {
+		cover_cleanup(self);
+		SKIP(return, "test requires user namespaces");
+	}
+	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, NULL), 0)
+		cover_cleanup(self);
+
+	snprintf(dir, sizeof(dir), "%s/p", self->base);
+	ASSERT_EQ(pipe(to_parent), 0)
+		cover_cleanup(self);
+	ASSERT_EQ(pipe(to_child), 0)
+		cover_cleanup(self);
+	self->child = fork();
+	ASSERT_GE(self->child, 0)
+		cover_cleanup(self);
+	if (self->child == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		_exit(cover_child(self->base, to_parent[1], to_child[0]));
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+	self->to_child = to_child[1];
+	self->from_child = to_parent[0];
+	if (read(self->from_child, fds, sizeof(fds)) != sizeof(fds)) {
+		pid_t pid = self->child;
+
+		waitpid(pid, &status, 0);
+		self->child = 0;
+		cover_cleanup(self);
+		ASSERT_TRUE(false)
+			TH_LOG("child failed to set up: %s %d",
+			       WIFEXITED(status) ? "step" : "signal",
+			       WIFEXITED(status) ? WEXITSTATUS(status) : WTERMSIG(status));
+	}
+
+	pidfd = syscall(__NR_pidfd_open, self->child, 0);
+	ASSERT_GE(pidfd, 0)
+		cover_cleanup(self);
+	self->dfd = syscall(__NR_pidfd_getfd, pidfd, fds[0], 0);
+	self->cfd = syscall(__NR_pidfd_getfd, pidfd, fds[1], 0);
+	self->tfd = syscall(__NR_pidfd_getfd, pidfd, fds[2], 0);
+	self->ufd = syscall(__NR_pidfd_getfd, pidfd, fds[3], 0);
+	close(pidfd);
+	ASSERT_GE(self->dfd, 0)
+		cover_cleanup(self);
+	ASSERT_GE(self->cfd, 0)
+		cover_cleanup(self);
+	ASSERT_GE(self->tfd, 0)
+		cover_cleanup(self);
+	ASSERT_GE(self->ufd, 0)
+		cover_cleanup(self);
+
+	/* unmounts P and C, C leaves its cover behind */
+	ASSERT_EQ(rmdir(dir), 0)
+		cover_cleanup(self);
+	/* unmounts T and U with their children, two covers on one mountpoint */
+	snprintf(dir, sizeof(dir), "%s/t", self->base);
+	ASSERT_EQ(rmdir(dir), 0)
+		cover_cleanup(self);
+	snprintf(dir, sizeof(dir), "%s/u", self->base);
+	ASSERT_EQ(rmdir(dir), 0)
+		cover_cleanup(self);
+
+	self->fd = openat(self->dfd, "covered", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(self->fd, 0)
+		cover_cleanup(self);
+	ASSERT_EQ(fstatfs(self->fd, &sf), 0)
+		cover_cleanup(self);
+	ASSERT_EQ(sf.f_type, NULL_FS_MAGIC)
+		cover_cleanup(self);
+}
+
+FIXTURE_TEARDOWN(mount_cover)
+{
+	cover_cleanup(self);
+}
+
+TEST_F(mount_cover, not_watchable)
+{
+	char p[PATH_LEN];
+	int ifd;
+
+	snprintf(p, sizeof(p), "/proc/self/fd/%d", self->fd);
+
+	ifd = inotify_init1(IN_CLOEXEC);
+	if (ifd < 0 && errno == ENOSYS) {
+		TH_LOG("no inotify in this kernel, skipping that part");
+	} else {
+		ASSERT_GE(ifd, 0);
+		EXPECT_EQ(inotify_add_watch(ifd, p, IN_OPEN), -1);
+		EXPECT_EQ(errno, EINVAL);
+		close(ifd);
+	}
+
+	/* dnotify ends up at the same place */
+	EXPECT_EQ(fcntl(self->fd, F_NOTIFY, DN_ACCESS), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	if (self->fan < 0) {
+		TH_LOG("no fanotify group without CAP_SYS_ADMIN in the initial user namespace, skipping the fanotify part");
+		return;
+	}
+	EXPECT_EQ(fanotify_mark(self->fan, FAN_MARK_ADD, FAN_OPEN, self->fd, NULL), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(mount_cover, not_lockable)
+{
+	struct flock fl = {
+		.l_type = F_RDLCK,
+		.l_whence = SEEK_SET,
+	};
+
+	EXPECT_EQ(flock(self->fd, LOCK_EX | LOCK_NB), -1);
+	EXPECT_EQ(errno, ENOLCK);
+	EXPECT_EQ(fcntl(self->fd, F_SETLK, &fl), -1);
+	EXPECT_EQ(errno, ENOLCK);
+	EXPECT_EQ(fcntl(self->fd, F_GETLK, &fl), -1);
+	EXPECT_EQ(errno, ENOLCK);
+}
+
+/* a lease is refused for the owner and for everybody else alike */
+TEST_F(mount_cover, not_leasable)
+{
+	struct delegation_req deleg = {
+		.d_type = F_RDLCK,
+	};
+
+	EXPECT_EQ(fcntl(self->fd, F_SETLEASE, F_RDLCK), -1);
+	EXPECT_TRUE(errno == EINVAL || errno == EACCES);
+	EXPECT_EQ(fcntl(self->fd, F_SETDELEG, &deleg), -1);
+	EXPECT_TRUE(errno == EINVAL || errno == EACCES);
+}
+
+TEST_F(mount_cover, not_mountable)
+{
+	char p[PATH_LEN];
+
+	snprintf(p, sizeof(p), "/proc/self/fd/%d", self->fd);
+	EXPECT_EQ(mount("tmpfs", p, "tmpfs", 0, NULL), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+TEST_F(mount_cover, read_only)
+{
+	struct statvfs sv;
+
+	EXPECT_EQ(mkdirat(self->fd, "x", 0755), -1);
+	EXPECT_EQ(errno, ENOENT);
+	EXPECT_EQ(fchmod(self->fd, 0777), -1);
+	EXPECT_EQ(errno, EROFS);
+	/* the immutable inode is checked before the read-only mount */
+	EXPECT_EQ(faccessat(self->fd, ".", W_OK, 0), -1);
+	EXPECT_EQ(errno, EPERM);
+	ASSERT_EQ(fstatvfs(self->fd, &sv), 0);
+	EXPECT_TRUE(sv.f_flag & ST_RDONLY);
+}
+
+/* the stand-in is a root of its own, ".." stays put */
+TEST_F(mount_cover, island)
+{
+	int fd;
+
+	fd = openat(self->fd, "..", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_TRUE(same_file(fd, self->fd));
+	close(fd);
+}
+
+/*
+ * C is alive for as long as the child holds it, but it can't be reached
+ * through P anymore and it's a root of its own as well.
+ */
+TEST_F(mount_cover, held_child_detached)
+{
+	struct statfs sf;
+	int fd;
+
+	ASSERT_EQ(fstatfs(self->cfd, &sf), 0);
+	EXPECT_EQ(sf.f_type, TMPFS_MAGIC);
+
+	fd = openat(self->cfd, "..", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_TRUE(same_file(fd, self->cfd));
+	close(fd);
+
+	fd = openat(self->dfd, "covered", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(fstatfs(fd, &sf), 0);
+	EXPECT_EQ(sf.f_type, NULL_FS_MAGIC);
+	close(fd);
+}
+
+/*
+ * The cover goes with its mountpoint: once the child has removed C's
+ * mountpoint through the bind of P, the name is gone from P as well.
+ * What was opened through the cover before stays open.
+ */
+TEST_F(mount_cover, cover_goes_with_mountpoint)
+{
+	char cmd = CMD_RMDIR;
+	struct statfs sf;
+	int ret;
+
+	ASSERT_EQ(write(self->to_child, &cmd, 1), 1);
+	ASSERT_EQ(read(self->from_child, &ret, sizeof(ret)), sizeof(ret));
+	ASSERT_EQ(ret, 0);
+
+	EXPECT_EQ(openat(self->dfd, "covered", O_RDONLY | O_DIRECTORY | O_CLOEXEC), -1);
+	EXPECT_EQ(errno, ENOENT);
+	ASSERT_EQ(fstatfs(self->fd, &sf), 0);
+	EXPECT_EQ(sf.f_type, NULL_FS_MAGIC);
+}
+
+/*
+ * A readdir of the stand-in holds nothing that others wait for: one holder
+ * sticks in the page fault of its buffer, and a create and a lookup of
+ * another come back meanwhile.
+ */
+TEST_F(mount_cover, readdir_blocks_nobody)
+{
+	bool stalled;
+
+	if (self->hold.uffd < 0)
+		SKIP(return, "test requires userfaultfd");
+	ASSERT_EQ(readdir_hold_check(&self->hold, self->fd, &stalled), 0);
+	EXPECT_FALSE(stalled);
+}
+
+/* where a file was mounted, the stand-in is an empty regular file */
+TEST_F(mount_cover, file_stand_in)
+{
+	char src[PATH_LEN], p[PATH_LEN];
+	struct statfs sf;
+	struct stat st;
+	char c;
+	int fd;
+
+	fd = openat(self->dfd, "file", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(fstat(fd, &st), 0);
+	EXPECT_TRUE(S_ISREG(st.st_mode));
+	ASSERT_EQ(fstatfs(fd, &sf), 0);
+	EXPECT_EQ(sf.f_type, NULL_FS_MAGIC);
+	/* the two stand-ins are two inodes */
+	EXPECT_FALSE(same_file(fd, self->fd));
+	EXPECT_EQ(read(fd, &c, 1), 0);
+	EXPECT_EQ(flock(fd, LOCK_EX | LOCK_NB), -1);
+	EXPECT_EQ(errno, ENOLCK);
+
+	snprintf(src, sizeof(src), "%s/src", self->base);
+	ASSERT_EQ(touch(src), 0);
+	snprintf(p, sizeof(p), "/proc/self/fd/%d", fd);
+	EXPECT_EQ(mount(src, p, NULL, MS_BIND, NULL), -1);
+	EXPECT_EQ(errno, ENOENT);
+	close(fd);
+
+	EXPECT_EQ(openat(self->dfd, "file", O_WRONLY | O_CLOEXEC), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_EQ(openat(self->dfd, "file", O_RDONLY | O_DIRECTORY | O_CLOEXEC), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+}
+
+/*
+ * Two unmounted parents left covers on the same dentry. A lookup on
+ * either finds a stand-in, and U's cover stays when T goes.
+ */
+TEST_F(mount_cover, shared_mountpoint)
+{
+	char cmd = CMD_CLOSE_T;
+	struct statfs sf;
+	int fd, ret;
+
+	fd = openat(self->tfd, "covered", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(fstatfs(fd, &sf), 0);
+	EXPECT_EQ(sf.f_type, NULL_FS_MAGIC);
+	close(fd);
+
+	fd = openat(self->ufd, "covered", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(fstatfs(fd, &sf), 0);
+	EXPECT_EQ(sf.f_type, NULL_FS_MAGIC);
+	close(fd);
+
+	/* the last references to T go, with T its cover */
+	ASSERT_EQ(write(self->to_child, &cmd, 1), 1);
+	ASSERT_EQ(read(self->from_child, &ret, sizeof(ret)), sizeof(ret));
+	ASSERT_EQ(ret, 0);
+	close(self->tfd);
+	self->tfd = -1;
+
+	fd = openat(self->ufd, "covered", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(fstatfs(fd, &sf), 0);
+	EXPECT_EQ(sf.f_type, NULL_FS_MAGIC);
+	close(fd);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/mount_cycle/settings b/tools/testing/selftests/filesystems/mount_cycle/settings
new file mode 100644
index 000000000000..694d70710ff0
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/settings
@@ -0,0 +1 @@
+timeout=300

-- 
2.53.0

