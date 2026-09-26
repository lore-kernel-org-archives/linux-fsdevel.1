Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754B446852
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430323; cv=none; b=JT01CSido/de/JZDxSQ1A03+uKaFwWX+rDjRdGvjb2u0dE4IfcgNDqcSTJzXetZPaSsBarIaFhn3Z8XC2wIOv7qySnervvwBKwD9bYT0VLApf7im0DyzNCldVp9Y/ZaKcdrSuD4SMNi7IijATBnkJyFT62XHUm9poai/pQaI4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430323; c=relaxed/simple;
	bh=GJzVX5fH/Qovig74K7Ap5CVAs9YoCNbMq4g/GGfT9uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOCe5HEfPdrjyhbTQ6K7q3xmKwnWaVVVzFSG2MhrKE3VV7KR2u3tFq3bv/hipBKs6DZUAuf76hFRfaEaxF5z0M9+q4WBYwK6JRa2cSK8jJ0+Gt2bqyHb5ypic5IjtjZJQvYrBbwJXCZZH/OqMtj5by0K+uk7yDssaJFxDjaXJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLDdY09m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLDdY09m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3E91F00893;
	Sat, 26 Sep 2026 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430321;
	bh=VikPZ3F5HPy0J//IHud6vtlBbogH6Ruwm5xv8ql+1i8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VLDdY09mUQGS7CQmk6Ym/adZiw1pYrRSixhYXXpSQJYWG7h/Yt10f0xhI8eTzIvgk
	 teMUKUzHsek8AgrRhB7NsdXU5Cv9h33TkADvkkp2fvCBin3hlBYuHwIEyAPo5YBTex
	 RCLuxSOVAulQjGADBM9mJ+vID5nEZlM8Ic7k/76grT6TZ+mEootu9mxbxHw5ZqL5QF
	 XjYzvYDyA1mO8Ng+RzIoAHsrjf9KIoMiMMMAOXcHoFv4K3WFOmDwpbTR3cGFWee6Mw
	 ekFQKhNQ0fxWRZO5Gt2Z5giy2/HrmTml6izhqGgm+UhZmZHAsPxWuhBtGKktXF8sY4
	 yJKVyRMslaJ1Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:32 +0200
Subject: [PATCH 09/10] selftests/filesystems: check that an unmounted mount
 tree isn't walked
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-9-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=17654; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GJzVX5fH/Qovig74K7Ap5CVAs9YoCNbMq4g/GGfT9uA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxPdPfX2zUVc3nen7T7Cv9vwlN3Go19ONP89W1F++
 VBHdc21/x2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATWc3ByPAsqjn8c47OJ3fd
 hev+n95zNOaPxbIk4Zy5zxs4Lp+WE/nGyLDxcIas74Z+17U/gn47Hj14hsXzTOVGfqP5CVoBS6w
 8f/MBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add unmounted_tree_test:

- a detached nsfs or pidfs bind mount that a file descriptor keeps
  alive can't be copied recursively, a copy of the mount itself and
  a copy of a mounted one still work
- a detached tree with a child that was vacated behind it can't be
  copied recursively either
- a copy of a detached bind mount is an ordinary mount: unlinking its
  mountpoint from another mount namespace unmounts it
- mount_setattr() refuses to change the propagation of a detached
  tree and still allows it for the root of an anonymous mount
  namespace

Every case runs in a user and mount namespace of its own.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/mount_cycle/.gitignore   |   2 +
 .../selftests/filesystems/mount_cycle/Makefile     |   6 +
 .../filesystems/mount_cycle/unmounted_tree_test.c  | 484 +++++++++++++++++++++
 4 files changed, 493 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 43d4a33afe71..bc4fdb6f5337 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -43,6 +43,7 @@ TARGETS += filesystems/open_tree_ns
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
+TARGETS += filesystems/mount_cycle
 TARGETS += filesystems/nsfs
 TARGETS += filesystems/fuse
 TARGETS += filesystems/move_mount
diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
new file mode 100644
index 000000000000..7bdfe4268fb4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+unmounted_tree_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
new file mode 100644
index 000000000000..46a68ca234ba
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := unmounted_tree_test
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/mount_cycle/unmounted_tree_test.c b/tools/testing/selftests/filesystems/mount_cycle/unmounted_tree_test.c
new file mode 100644
index 000000000000..233f8ea92efc
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/unmounted_tree_test.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An unmounted mount tree that a file descriptor keeps alive is put and
+ * vacated behind the root's back, so nothing may walk it under
+ * namespace_sem: it can't be copied recursively and its propagation can't
+ * be changed. The mount at its root alone can still be copied and that copy
+ * is an ordinary mount.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/mount.h>
+
+#include "../wrappers.h"
+#include "../../kselftest_harness.h"
+
+#ifndef __NR_mount_setattr
+#define __NR_mount_setattr 442
+#endif
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#endif
+
+#define PATH_LEN	64
+
+static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
+				    struct mount_attr *attr, size_t size)
+{
+	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+}
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
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
+/* A private mount namespace of our own, all mounts private. */
+static int own_mntns(void)
+{
+	if (unshare(CLONE_NEWNS))
+		return -1;
+	return mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+}
+
+FIXTURE(unmounted_tree) {
+	char dir[PATH_LEN];
+};
+
+FIXTURE_SETUP(unmounted_tree)
+{
+	snprintf(self->dir, sizeof(self->dir), "/tmp/unmounted_tree.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	if (enter_userns()) {
+		rmdir(self->dir);
+		SKIP(return, "test requires user namespaces");
+	}
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
+}
+
+FIXTURE_TEARDOWN(unmounted_tree)
+{
+	umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+/* A recursive copy of the mount @fd refers to must fail with EINVAL. */
+static void assert_not_walked(struct __test_metadata *_metadata, int fd,
+			      const char *target)
+{
+	char link[PATH_LEN];
+	int tfd;
+
+	snprintf(link, sizeof(link), "/proc/self/fd/%d", fd);
+	EXPECT_EQ(mount(link, target, NULL, MS_BIND | MS_REC, NULL), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	tfd = sys_open_tree(fd, "", AT_EMPTY_PATH | AT_RECURSIVE | OPEN_TREE_CLONE |
+			    OPEN_TREE_CLOEXEC);
+	EXPECT_LT(tfd, 0);
+	EXPECT_EQ(errno, EINVAL);
+	if (tfd >= 0)
+		close(tfd);
+}
+
+/* The mount @fd refers to can be copied on its own and mounted on @target. */
+static void assert_root_copied(struct __test_metadata *_metadata, int fd,
+			       const char *target)
+{
+	int tfd;
+
+	tfd = sys_open_tree(fd, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+	ASSERT_EQ(sys_move_mount(tfd, "", AT_FDCWD, target, MOVE_MOUNT_F_EMPTY_PATH), 0);
+	close(tfd);
+	ASSERT_EQ(umount2(target, MNT_DETACH), 0);
+}
+
+/*
+ * A lazily unmounted bind mount of an nsfs file, kept alive by an fd, can't
+ * be copied recursively anymore. Copying the mount itself still works and
+ * so does copying a mounted bind mount of the same file.
+ */
+TEST_F(unmounted_tree, detached_nsfs_bind_not_walked)
+{
+	char x[PATH_LEN], y[PATH_LEN], z[PATH_LEN], link[PATH_LEN];
+	int fd, tfd;
+
+	snprintf(x, sizeof(x), "%s/x", self->dir);
+	snprintf(y, sizeof(y), "%s/y", self->dir);
+	snprintf(z, sizeof(z), "%s/z", self->dir);
+	ASSERT_EQ(touch(x), 0);
+	ASSERT_EQ(touch(y), 0);
+	ASSERT_EQ(touch(z), 0);
+
+	ASSERT_EQ(mount("/proc/self/ns/net", x, NULL, MS_BIND, NULL), 0);
+	fd = open(x, O_PATH | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(umount2(x, MNT_DETACH), 0);
+
+	assert_not_walked(_metadata, fd, y);
+
+	snprintf(link, sizeof(link), "/proc/self/fd/%d", fd);
+	ASSERT_EQ(mount(link, y, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(umount2(y, MNT_DETACH), 0);
+	assert_root_copied(_metadata, fd, y);
+	/* opening it is fine too */
+	tfd = sys_open_tree(fd, "", AT_EMPTY_PATH | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+	close(tfd);
+	close(fd);
+
+	ASSERT_EQ(mount("/proc/self/ns/net", y, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(y, z, NULL, MS_BIND | MS_REC, NULL), 0);
+	tfd = sys_open_tree(AT_FDCWD, y, AT_RECURSIVE | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+	close(tfd);
+}
+
+/* Bind-mount the pidfd @pidfd on @target the way pidfd_bind_mount does. */
+static int bind_pidfd(int pidfd, const char *target)
+{
+	int tfd, ret;
+
+	tfd = sys_open_tree(pidfd, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (tfd < 0)
+		return -1;
+	ret = sys_move_mount(tfd, "", AT_FDCWD, target, MOVE_MOUNT_F_EMPTY_PATH);
+	close(tfd);
+	return ret;
+}
+
+/* The same for a bind mount of a pidfd. */
+TEST_F(unmounted_tree, detached_pidfs_bind_not_walked)
+{
+	char x[PATH_LEN], y[PATH_LEN];
+	int pidfd, fd, tfd;
+
+	snprintf(x, sizeof(x), "%s/x", self->dir);
+	snprintf(y, sizeof(y), "%s/y", self->dir);
+	ASSERT_EQ(touch(x), 0);
+	ASSERT_EQ(touch(y), 0);
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(bind_pidfd(pidfd, x), 0);
+	fd = open(x, O_PATH | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(umount2(x, MNT_DETACH), 0);
+
+	assert_not_walked(_metadata, fd, y);
+	assert_root_copied(_metadata, fd, y);
+	close(fd);
+
+	ASSERT_EQ(bind_pidfd(pidfd, y), 0);
+	tfd = sys_open_tree(AT_FDCWD, y, AT_RECURSIVE | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+	close(tfd);
+	close(pidfd);
+}
+
+/* What a child in its own mount namespace reports back. */
+enum {
+	CHILD_OK,
+	CHILD_NS,		/* could not set up the mount namespace */
+	CHILD_MOUNT,		/* could not set up the mounts */
+	CHILD_PIPE,		/* the parent went away */
+	CHILD_WALKED,		/* the detached tree was copied recursively */
+	CHILD_ROOT_REFUSED,	/* the mount at its root wasn't copied */
+	CHILD_STILL_MOUNTED,	/* the copy survived the unlink of its mountpoint */
+	CHILD_ERRNO,		/* refused, but not with EINVAL */
+};
+
+static const char *child_reason(int code)
+{
+	static const char *const reasons[] = {
+		[CHILD_OK]		= "ok",
+		[CHILD_NS]		= "could not set up the mount namespace",
+		[CHILD_MOUNT]		= "could not set up the mounts",
+		[CHILD_PIPE]		= "the parent went away",
+		[CHILD_WALKED]		= "the detached tree was copied recursively",
+		[CHILD_ROOT_REFUSED]	= "the mount at its root wasn't copied",
+		[CHILD_STILL_MOUNTED]	= "the copy survived the unlink of its mountpoint",
+		[CHILD_ERRNO]		= "refused, but not with EINVAL",
+	};
+
+	if (code < 0 || code >= (int)(sizeof(reasons) / sizeof(reasons[0])))
+		return "child died";
+	return reasons[code];
+}
+
+struct child_args {
+	const char *x;		/* the nsfs bind mount goes here */
+	const char *s;		/* a file to bind on top of it */
+	const char *y;		/* a target to copy to */
+};
+
+/*
+ * Run @fn in a child in a mount namespace of its own. Once the child
+ * reports that its mounts are in place, unlink @victim here, where it is a
+ * plain file, and let the child carry on. Returns what the child reported.
+ */
+static int run_child(struct __test_metadata *_metadata,
+		     int (*fn)(const struct child_args *, int, int),
+		     const struct child_args *a, const char *victim)
+{
+	int to_parent[2], to_child[2], status;
+	pid_t pid;
+	char c;
+
+	if (pipe(to_parent) || pipe(to_child))
+		return -1;
+	pid = fork();
+	if (pid < 0)
+		return -1;
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		_exit(fn(a, to_parent[1], to_child[0]));
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+	if (read(to_parent[0], &c, 1) == 1) {
+		/* not a mountpoint in this namespace, so the file can go */
+		EXPECT_EQ(unlink(victim), 0);
+		EXPECT_EQ(write(to_child[1], "", 1), 1);
+	}
+	close(to_parent[0]);
+	close(to_child[1]);
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+/*
+ * An nsfs bind mount on @x, an fd on it and a bind mount of @s on top. Once
+ * the parent has unlinked @x underneath, the first mount is detached and the
+ * second one, which stayed attached to it, has been vacated. The tree may
+ * not be walked, the mount at its root may still be copied.
+ */
+static int vacant_child(const struct child_args *a, int to_parent, int from_parent)
+{
+	char link[PATH_LEN];
+	int fd, tfd;
+	char c;
+
+	if (own_mntns())
+		return CHILD_NS;
+	if (mount("/proc/self/ns/net", a->x, NULL, MS_BIND, NULL))
+		return CHILD_MOUNT;
+	fd = open(a->x, O_PATH | O_CLOEXEC);
+	if (fd < 0 || mount(a->s, a->x, NULL, MS_BIND, NULL))
+		return CHILD_MOUNT;
+
+	if (write(to_parent, "", 1) != 1 || read(from_parent, &c, 1) != 1)
+		return CHILD_PIPE;
+
+	tfd = sys_open_tree(fd, "", AT_EMPTY_PATH | AT_RECURSIVE | OPEN_TREE_CLONE |
+			    OPEN_TREE_CLOEXEC);
+	if (tfd >= 0) {
+		close(tfd);
+		return CHILD_WALKED;
+	}
+	if (errno != EINVAL)
+		return CHILD_ERRNO;
+	snprintf(link, sizeof(link), "/proc/self/fd/%d", fd);
+	if (!mount(link, a->y, NULL, MS_BIND | MS_REC, NULL))
+		return CHILD_WALKED;
+	if (errno != EINVAL)
+		return CHILD_ERRNO;
+
+	tfd = sys_open_tree(fd, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (tfd < 0)
+		return CHILD_ROOT_REFUSED;
+	close(tfd);
+	/* the last reference on the detached mount collects the vacant one */
+	close(fd);
+	return CHILD_OK;
+}
+
+/*
+ * unlink() of the child's mountpoint from here, where it is a plain file,
+ * detaches the child's nsfs bind mount with the mount on top left attached
+ * to it. The mount on top loses its last reference right there and is
+ * vacated. The child must not be able to walk that tree.
+ */
+TEST_F(unmounted_tree, vacant_child_not_copied)
+{
+	char x[PATH_LEN], s[PATH_LEN], y[PATH_LEN];
+	struct child_args a = { .x = x, .s = s, .y = y };
+	int ret;
+
+	snprintf(x, sizeof(x), "%s/x", self->dir);
+	snprintf(s, sizeof(s), "%s/s", self->dir);
+	snprintf(y, sizeof(y), "%s/y", self->dir);
+	ASSERT_EQ(touch(x), 0);
+	ASSERT_EQ(touch(s), 0);
+	ASSERT_EQ(touch(y), 0);
+
+	ret = run_child(_metadata, vacant_child, &a, x);
+	ASSERT_EQ(ret, CHILD_OK)
+		TH_LOG("child: %s", child_reason(ret));
+}
+
+/*
+ * An nsfs bind mount on @x, lazily unmounted but kept alive by an fd, and a
+ * copy of it on @y. That copy is a mount like any other: once the parent has
+ * unlinked @y underneath, it is unmounted and its attributes can't be changed
+ * anymore. A copy that took the flag along is only unhooked, stays in the
+ * namespace and still takes the change.
+ */
+static int ordinary_copy(const struct child_args *a, int to_parent, int from_parent)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_NOSUID,
+	};
+	char link[PATH_LEN];
+	int fd, fdy;
+	char c;
+
+	if (own_mntns())
+		return CHILD_NS;
+	if (mount("/proc/self/ns/net", a->x, NULL, MS_BIND, NULL))
+		return CHILD_MOUNT;
+	fd = open(a->x, O_PATH | O_CLOEXEC);
+	if (fd < 0 || umount2(a->x, MNT_DETACH))
+		return CHILD_MOUNT;
+	snprintf(link, sizeof(link), "/proc/self/fd/%d", fd);
+	if (mount(link, a->y, NULL, MS_BIND, NULL))
+		return CHILD_MOUNT;
+	fdy = open(a->y, O_PATH | O_CLOEXEC);
+	if (fdy < 0)
+		return CHILD_MOUNT;
+
+	if (write(to_parent, "", 1) != 1 || read(from_parent, &c, 1) != 1)
+		return CHILD_PIPE;
+
+	if (!sys_mount_setattr(fdy, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return CHILD_STILL_MOUNTED;
+	if (errno != EINVAL)
+		return CHILD_ERRNO;
+	close(fdy);
+	close(fd);
+	return CHILD_OK;
+}
+
+/*
+ * A copy of a detached nsfs bind mount must not take after its source and
+ * read as unmounted. unlink() of its mountpoint from here unmounts it like
+ * any other mount, so the child can't change its attributes anymore.
+ */
+TEST_F(unmounted_tree, copy_of_detached_bind_is_ordinary)
+{
+	char x[PATH_LEN], y[PATH_LEN];
+	struct child_args a = { .x = x, .y = y };
+	int ret;
+
+	snprintf(x, sizeof(x), "%s/x", self->dir);
+	snprintf(y, sizeof(y), "%s/y", self->dir);
+	ASSERT_EQ(touch(x), 0);
+	ASSERT_EQ(touch(y), 0);
+
+	ret = run_child(_metadata, ordinary_copy, &a, y);
+	ASSERT_EQ(ret, CHILD_OK)
+		TH_LOG("child: %s", child_reason(ret));
+}
+
+/*
+ * mount_setattr() may change the propagation of a detached tree while that
+ * tree is still the root of an anonymous mount namespace, but not once the
+ * tree has been dissolved and only a second fd keeps its root alive.
+ */
+TEST_F(unmounted_tree, detached_tree_setattr_refused)
+{
+	struct mount_attr attr = {
+		.propagation = MS_SHARED,
+	};
+	char a[PATH_LEN], b[PATH_LEN];
+	int tfd, fd;
+
+	snprintf(a, sizeof(a), "%s/a", self->dir);
+	snprintf(b, sizeof(b), "%s/a/b", self->dir);
+	ASSERT_EQ(mkdir(a, 0755), 0);
+	ASSERT_EQ(mount("tmpfs", a, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mkdir(b, 0755), 0);
+	ASSERT_EQ(mount("tmpfs", b, "tmpfs", 0, NULL), 0);
+
+	tfd = sys_open_tree(AT_FDCWD, self->dir, AT_RECURSIVE | OPEN_TREE_CLONE |
+			    OPEN_TREE_CLOEXEC);
+	ASSERT_GE(tfd, 0);
+	ASSERT_EQ(sys_mount_setattr(tfd, "", AT_EMPTY_PATH | AT_RECURSIVE, &attr, sizeof(attr)), 0);
+	attr.propagation = MS_PRIVATE;
+	ASSERT_EQ(sys_mount_setattr(tfd, "", AT_EMPTY_PATH | AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	/* a second reference on the root, then dissolve the tree */
+	fd = sys_open_tree(tfd, "", AT_EMPTY_PATH | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	close(tfd);
+
+	attr.propagation = MS_SHARED;
+	ASSERT_EQ(sys_mount_setattr(fd, "", AT_EMPTY_PATH | AT_RECURSIVE, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EINVAL);
+	attr.propagation = MS_PRIVATE;
+	ASSERT_EQ(sys_mount_setattr(fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EINVAL);
+	close(fd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

