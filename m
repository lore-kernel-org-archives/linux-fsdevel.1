Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71648A2A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007136; cv=none; b=pVnK4AXYVkNYrre+KCIWYBeNMC3Qm9NHWHM9V63Dfo8phccML5cuWKn1hlddU8/2mHwZXTeyeUWIcPsBB/NqZdWGyYA4jFIJlw7XX0NsvlSumeBBuKRJ6WdTKOri6sEmtCHr410f5rSqdIe6WJkL9wZqYLS0ekZ4yBryUPTPvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007136; c=relaxed/simple;
	bh=xZxnX2vpel88TD6wU7nQcStO79PLwWSKjo7zHQdMh7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1v3EPYPqoYERG29DEM3mJHXqU+7yncvqFxmafC8JzKmtbMi6RGBNp0lgSbCkhqiAWgQTeirJcuPabldf6RTCUvHNgEAk5mMmforcdixuWcqef86IbjHJCD8a4ZgTAZjo2e3euY9ZXcjmRwgR8CRSK7iwryMSrUyn+q8vY6sXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMCQ0QlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMCQ0QlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478911F000CB;
	Wed, 14 Oct 2026 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007130;
	bh=omChF9uJrgEzkud3FAoGqTNMOr3ea1JyFbE6iD9AJ2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iMCQ0QlV/rL5yVF3V0K0Tp5/rtkYMVncSKExQSI+JDZ9AzF4wPuhduUnBJUQIrxa5
	 mcYK/tEOZW4FigbytksWjc0hRjrrj/0/zRkexCkjPsswqyKIAl3PeAUtCbb1jdngAu
	 9PVvrh3gpP0tEeaQrZCFgF4bow3eCMS6eeY5VrwZ7Zry+Xg/e1Sy9hoZwlnNNi97ou
	 wOjJdvYc0Y43XYaaB9JY2IWqIzFdOtHvXPdgKiwmm3PwI6AX6Pu/+QX3HetxyqLYIA
	 z+JoIAv1Ev8RuMtHamP4aSccjm6eECAXlYEne127F8SzXPVtyJ7WJido85MBfeRkoh
	 GcCc3IRz5EswA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 14 Oct 2026 21:45:14 +0200
Subject: [PATCH 2/2] selftests/filesystems: test that a mntns file can't
 take over a lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-work-namei-locked-mnt_ns_file-v1-2-24035bd5d8e9@kernel.org>
References: <20261014-work-namei-locked-mnt_ns_file-v1-0-24035bd5d8e9@kernel.org>
In-Reply-To: <20261014-work-namei-locked-mnt_ns_file-v1-0-24035bd5d8e9@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neil@brown.name>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5184; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xZxnX2vpel88TD6wU7nQcStO79PLwWSKjo7zHQdMh7E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdv33h6wytnvy9kb42jUG5wQFPm+9tUtpfs9giK757n
 ZCgOVN/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESMvBkZFiRqXNsevWxdRVja
 HmuxIlPFmMcO5aIW1icq9Xb9+H79HMP/7JO661cEt+x+17OjYnfJ7L3+kypfCuzY/vjxKger5G5
 XDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a case to the locked mount test:

- a bind of the mount namespace file of a grandchild moved beneath a
  locked cover must fail with EINVAL
- a bind of an ordinary file beneath it takes the lock over, the old
  cover can go and the new one can't
- the file is still covered after unshare(CLONE_NEWNS)

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../umount_propagation/locked_mount_test.c         | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/filesystems/umount_propagation/locked_mount_test.c b/tools/testing/selftests/filesystems/umount_propagation/locked_mount_test.c
index 0799b2ba545d..e9b2b874dd16 100644
--- a/tools/testing/selftests/filesystems/umount_propagation/locked_mount_test.c
+++ b/tools/testing/selftests/filesystems/umount_propagation/locked_mount_test.c
@@ -9,6 +9,8 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
+#include <stdbool.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -27,6 +29,12 @@
 #ifndef MOVE_MOUNT_BENEATH
 #define MOVE_MOUNT_BENEATH	0x00000200
 #endif
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE		1
+#endif
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC	O_CLOEXEC
+#endif
 
 #define DIR_LEN		64
 #define PATH_LEN	192
@@ -120,6 +128,35 @@ static bool covered(const char *path)
 	return fd < 0;
 }
 
+/* What @path reads, "" if it can't be read. */
+static int read_word(const char *path, char *buf, size_t len)
+{
+	ssize_t n = 0;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd >= 0) {
+		n = read(fd, buf, len - 1);
+		close(fd);
+	}
+	buf[n > 0 ? n : 0] = 0;
+	return fd < 0 ? -1 : 0;
+}
+
+/* Put a clone of the mount at @src beneath the top mount at @where. */
+static int move_beneath(const char *src, const char *where)
+{
+	int fd, ret;
+
+	fd = syscall(__NR_open_tree, AT_FDCWD, src, OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	ret = syscall(__NR_move_mount, fd, "", AT_FDCWD, where,
+		      MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH);
+	close(fd);
+	return ret;
+}
+
 FIXTURE(locked_mount) {
 	char base[DIR_LEN];
 	bool tracing;		/* debugfs with the tracefs automount is there */
@@ -429,4 +466,89 @@ TEST_F(locked_mount, propagated_copy_keeps_the_cover_locked)
 	EXPECT_EQ(ret, CHILD_OK);
 }
 
+/*
+ * A mount of a mount namespace file is left out of the copy that
+ * unshare(CLONE_NEWNS) makes, together with everything mounted on it, so
+ * it can't take over the lock of a cover it is moved beneath. The child
+ * tries just that with the namespace file of a grandchild and gets EINVAL.
+ * A bind of an ordinary file takes the lock over, and the file is still
+ * covered in the next copy of the mount namespace.
+ */
+static int ns_file_child(const char *base)
+{
+	char secret[PATH_LEN], mine[PATH_LEN], nsfile[PATH_LEN], buf[32];
+	int ret = CHILD_OK, pfd[2];
+	pid_t pid;
+
+	snprintf(secret, sizeof(secret), "%s/P/secret", base);
+	snprintf(mine, sizeof(mine), "%s/mine", base);
+
+	if (enter_userns() || pipe(pfd))
+		return CHILD_SETUP;
+	/* the cover is locked */
+	if (!umount2(secret, 0) || errno != EINVAL)
+		return CHILD_STEP1;
+
+	/* a mount namespace newer than our own, so that a bind of it is allowed */
+	pid = fork();
+	if (pid < 0)
+		return CHILD_SETUP;
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNS) || send_byte(pfd[1]))
+			_exit(1);
+		pause();
+		_exit(0);
+	}
+	if (wait_byte(pfd[0]))
+		return CHILD_SETUP;
+	snprintf(nsfile, sizeof(nsfile), "/proc/%d/ns/mnt", pid);
+	if (!move_beneath(nsfile, secret) || errno != EINVAL)
+		ret = CHILD_STEP2;
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+	if (ret)
+		return ret;
+
+	/* an ordinary file beneath the cover takes the lock over */
+	if (move_beneath(mine, secret))
+		return CHILD_STEP3;
+	if (umount2(secret, 0))
+		return CHILD_STEP3;
+	if (!umount2(secret, 0) || errno != EINVAL)
+		return CHILD_STEP3;
+	/* and it is in the next copy of the namespace */
+	if (unshare(CLONE_NEWNS))
+		return CHILD_SETUP;
+	if (read_word(secret, buf, sizeof(buf)) || strcmp(buf, "mine"))
+		return CHILD_STEP4;
+	return CHILD_OK;
+}
+
+TEST_F(locked_mount, mount_namespace_file_cant_take_the_lock)
+{
+	char p[PATH_LEN], q[PATH_LEN];
+	pid_t pid;
+	int ret;
+
+	snprintf(p, sizeof(p), "%s/P", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	ASSERT_EQ(mount("tmpfs", p, "tmpfs", 0, "mode=0755"), 0);
+	snprintf(p, sizeof(p), "%s/P/secret", self->base);
+	ASSERT_EQ(create_file(p, "covered-by-root\n"), 0);
+	snprintf(q, sizeof(q), "%s/P/empty", self->base);
+	ASSERT_EQ(create_file(q, ""), 0);
+	/* the cover: an empty file over the secret */
+	ASSERT_EQ(mount(q, p, NULL, MS_BIND, NULL), 0);
+	snprintf(q, sizeof(q), "%s/mine", self->base);
+	ASSERT_EQ(create_file(q, "mine"), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		_exit(ns_file_child(self->base));
+	ret = wait_child(pid);
+	TH_LOG("child exit code %d", ret);
+	EXPECT_EQ(ret, CHILD_OK);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

