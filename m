Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BB517BCA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166508; cv=none; b=XOSvH5wshhWXGH1MoowFW6CnwpQn5YFu4cN9E4X+TAEQFdeKVZIT06mnLlgPSthaJGO2WYenKbaH0IRJrvcrOppNssApNZX9OtC4xLFi4ukcW/qkQDWO9qjNUrwHspmMiQK8dyMitVa3XIiHNxjZsXXjBB1w6Sy8GtDo4lPZfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166508; c=relaxed/simple;
	bh=Tllj0uKBjTmwCLOIn8ujqNdwypgrc+xehfrSBLZSX4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWGy+xOXQ18BY66J5/i+u+aHT+v9g96MNac4PN63BTSzZm59YFwixK9sHM23lqLNjicXU6KnOL95aKit78hS310uk5eSgNvcD9Yzbdg2Izyg9P2WJn7LQS3pVoDIJ3BGR7IOQY9688uIip1rdCtSp998sRmqu7J0lRzDOmWNXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9pUBM26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9pUBM26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8FA1F000FF;
	Wed, 23 Sep 2026 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166506;
	bh=WsvwqARQ8p2iLbGwJOdi0rtMWRzz7cxcE+UZNbz84zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b9pUBM26PmfbcN5ynAdlIZdrW9Xkb76wliPDJcYoT1bW8ZhqwsWeTjjK4Kt2YBS3m
	 eAYDhfLTH5oQPe5zhEnzrZ6tZrgqqXjIDD5h+AqB1YfVXMmg8e0a+GTk/ehac4p5fm
	 XemK52RNAzfHgcJcELEs7zQ3ycco1YNQ0z/KsWmUGIPxsLML3g7RObGPjStw9UmQxh
	 b+LPwkJk9G0PDgqzNdr4WdmJegJdqKb/DJw0m27bBixdFsMhaHP8dX8CP2I3+a241/
	 JYmBXJ+W8a51VCGCpiKm6PTlBDGfe+YoIL7MgQ/jUPgE5soKa3Kowqg1etTNm8s7B9
	 l4mIaKDUfHX+A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:58 +0200
Subject: [PATCH 6/8] selftests/filesystems: check that a busy propagated
 copy blocks a synchronous umount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-6-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=8062; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tllj0uKBjTmwCLOIn8ujqNdwypgrc+xehfrSBLZSX4M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnonvJ9BaEnZ8u2vjKZ6bnzVI9w+vfqjAFMTX1hrl
 e6CuXK5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhWMnwV45Bu3WWxOrdDDMC
 U7dfN4qKZNnsftKquKMzjNVwWf6ePYwMN1lSzSwsTavc5ieJKcqe27D836vtduWJ9ppT2mZ/iqn
 jBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A slave namespace moves an open_tree() copy of the shared tree beneath
the propagated copy of the victim and keeps the descriptor. Check that:

- umount(2) of the victim fails with EBUSY while the descriptor is open

- the moved tree is still attached in the slave namespace afterwards

- the umount succeeds once the descriptor is closed

The test needs CAP_SYS_ADMIN and skips otherwise.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../filesystems/umount_propagation/Makefile        |   6 +
 .../umount_propagation/umount_propagation_test.c   | 226 +++++++++++++++++++++
 3 files changed, 233 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a3df9a15ebb7..43d4a33afe71 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -51,6 +51,7 @@ TARGETS += filesystems/fsmount_ns
 TARGETS += filesystems/fscontext_ns
 TARGETS += filesystems/xattr
 TARGETS += filesystems/mntns_unbindable
+TARGETS += filesystems/umount_propagation
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/umount_propagation/Makefile b/tools/testing/selftests/filesystems/umount_propagation/Makefile
new file mode 100644
index 000000000000..fc0a0783018b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/umount_propagation/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := umount_propagation_test
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/umount_propagation/umount_propagation_test.c b/tools/testing/selftests/filesystems/umount_propagation/umount_propagation_test.c
new file mode 100644
index 000000000000..9e18d54dfb32
--- /dev/null
+++ b/tools/testing/selftests/filesystems/umount_propagation/umount_propagation_test.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A synchronous umount fails with EBUSY when a mount it would pull out by
+ * propagation is still in use.
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
+#include <linux/stat.h>
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
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH	0x00000004
+#endif
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH	0x00000200
+#endif
+#ifndef STATX_MNT_ID
+#define STATX_MNT_ID		0x00001000U
+#endif
+
+static int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+static int sys_move_mount(int from_dfd, const char *from_pathname,
+			  int to_dfd, const char *to_pathname,
+			  unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
+		       to_pathname, flags);
+}
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,
+	CHILD_UNSHARE,		/* could not set up the slave namespace */
+	CHILD_OPEN_TREE,	/* open_tree() failed */
+	CHILD_MOVE_MOUNT,	/* move_mount() failed */
+	CHILD_STATX,		/* statx() failed */
+	CHILD_PIPE,		/* the parent went away */
+};
+
+/* Messages between parent and child. */
+enum {
+	MSG_READY = 'r',	/* child: the copy is mounted and referenced */
+	MSG_CHECK = 'c',	/* parent: check that the copy is still attached */
+	MSG_ATTACHED = 'a',	/* child: it is */
+	MSG_DETACHED = 'd',	/* child: it is not */
+	MSG_CLOSE = 'x',	/* parent: drop the reference */
+	MSG_CLOSED = 'y',	/* child: dropped */
+	MSG_EXIT = 'e',		/* parent: done */
+};
+
+FIXTURE(umount_propagation)
+{
+	char base[64];
+	char victim[80];
+	bool mounted;
+};
+
+FIXTURE_SETUP(umount_propagation)
+{
+	self->mounted = false;
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->base, sizeof(self->base), "/tmp/umount_propagation.XXXXXX");
+	ASSERT_NE(mkdtemp(self->base), NULL);
+	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, NULL), 0);
+	self->mounted = true;
+	ASSERT_EQ(mount(NULL, self->base, NULL, MS_SHARED, NULL), 0);
+
+	snprintf(self->victim, sizeof(self->victim), "%s/victim", self->base);
+	ASSERT_EQ(mkdir(self->victim, 0755), 0);
+	ASSERT_EQ(mount("tmpfs", self->victim, "tmpfs", 0, NULL), 0);
+}
+
+FIXTURE_TEARDOWN(umount_propagation)
+{
+	if (self->mounted)
+		umount2(self->base, MNT_DETACH);
+	rmdir(self->base);
+}
+
+static int send_msg(int fd, char msg)
+{
+	return write(fd, &msg, 1) == 1 ? 0 : -1;
+}
+
+static char recv_msg(int fd)
+{
+	char msg;
+
+	if (read(fd, &msg, 1) != 1)
+		return 0;
+	return msg;
+}
+
+/* Is the mount with id @mnt_id attached in this mount namespace? */
+static bool mount_attached(__u64 mnt_id)
+{
+	char line[4096];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/self/mountinfo", "re");
+	if (!f)
+		return false;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (strtoull(line, NULL, 10) == mnt_id) {
+			found = true;
+			break;
+		}
+	}
+	fclose(f);
+	return found;
+}
+
+/*
+ * The slave namespace: take a detached copy of the shared tree and move it
+ * beneath the propagated copy of the victim, keeping the open_tree()
+ * descriptor as a reference on it.
+ */
+static int slave_child(const char *base, const char *victim, int to_parent,
+		       int from_parent)
+{
+	struct statx stx;
+	int fd;
+
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	if (mount("", "/", NULL, MS_REC | MS_SLAVE, NULL))
+		return CHILD_UNSHARE;
+
+	fd = sys_open_tree(AT_FDCWD, base,
+			   OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_RECURSIVE);
+	if (fd < 0)
+		return CHILD_OPEN_TREE;
+	if (sys_move_mount(fd, "", AT_FDCWD, victim,
+			   MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH))
+		return CHILD_MOVE_MOUNT;
+	if (statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID, &stx))
+		return CHILD_STATX;
+
+	if (send_msg(to_parent, MSG_READY) || recv_msg(from_parent) != MSG_CHECK)
+		return CHILD_PIPE;
+	if (send_msg(to_parent, mount_attached(stx.stx_mnt_id) ?
+				MSG_ATTACHED : MSG_DETACHED))
+		return CHILD_PIPE;
+
+	if (recv_msg(from_parent) != MSG_CLOSE)
+		return CHILD_PIPE;
+	close(fd);
+	if (send_msg(to_parent, MSG_CLOSED) || recv_msg(from_parent) != MSG_EXIT)
+		return CHILD_PIPE;
+	return CHILD_OK;
+}
+
+TEST_F(umount_propagation, busy_copy_pulled_out)
+{
+	int to_child[2], to_parent[2];
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_child), 0);
+	ASSERT_EQ(pipe(to_parent), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_child[1]);
+		close(to_parent[0]);
+		_exit(slave_child(self->base, self->victim, to_parent[1],
+				  to_child[0]));
+	}
+	close(to_child[0]);
+	close(to_parent[1]);
+
+	ASSERT_EQ(recv_msg(to_parent[0]), MSG_READY);
+
+	/* the copy in the slave namespace is in use */
+	ASSERT_EQ(umount2(self->victim, 0), -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	ASSERT_EQ(send_msg(to_child[1], MSG_CHECK), 0);
+	ASSERT_EQ(recv_msg(to_parent[0]), MSG_ATTACHED);
+
+	/* and once it is not, the umount goes through */
+	ASSERT_EQ(send_msg(to_child[1], MSG_CLOSE), 0);
+	ASSERT_EQ(recv_msg(to_parent[0]), MSG_CLOSED);
+	ASSERT_EQ(umount2(self->victim, 0), 0);
+
+	ASSERT_EQ(send_msg(to_child[1], MSG_EXIT), 0);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), CHILD_OK);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

