Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1243519E16
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166501; cv=none; b=uz74TsSbCUgARMwl67kpbIt878rtaSqyomA/fsXs0rt6KXopz3BHMegmeju97q0Y9V2eC9HbumNRe6IPSSpXftd/lqNxzHG+ImCVP59tOsaMGRpFyO3Q8Dkj9xz2Ts/OgxLottmD0OSV5ciLErtg7s5sDiFZ5mRd/0bJj1a/OKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166501; c=relaxed/simple;
	bh=m0S9l+McXWICJxf57la+Zy01hmodehdgzaKkbfE7ND8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gbqwqvoqcwo3Mke8VHWjFSpZ4G3udzey8p8jXTvcW2RUzjBureqXLdRx/KzgekuDvuMzTp3kRgWP0nRJpVCbPQ3m1nWv1yNyQZlUqNanW5USu98LXSTsJVYUgYdWDqrRMfyxv+ViNf6JH12goRExUaXXuSwQJ8Vfp0AMsOTmnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CreyrOKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CreyrOKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AD81F000FF;
	Wed, 23 Sep 2026 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166499;
	bh=DsKWZ0NIOEP4+lbMtrcArbip23YAU3iGLjTAL2c4dFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CreyrOKTk0MJ9X0d9C/LKrit/hEEf1zr7cpZzJyhU4hECJX5vkukglHQGuJzDyS3E
	 AsbmnahsH5BcGetYTWYbdzmD/A56AB1sS/BT+y4PjgFCqHrnR7tQMy7PRnsO7tARjK
	 7+Bz2TMGVf2FSFZMci6yBLEqbOp3hX0uWUIYqmJNudZwUOVUnRAZTXhm4AXK0BdcLN
	 zAPfXCENHB/YC3w6I1b7BO4sEXTCrRwF9J9caIqtD1Q4BtvflJTSXg+etWergicV/P
	 gNn5fyJC9ZPFCQwC6xDT4yBSNufwjuO7zFza+YqiWbVSI2DE8KhFyEOOxMsoeNIQIp
	 qt/2FVLhV+WSg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:54 +0200
Subject: [PATCH 2/8] selftests/filesystems: check that a copied mount
 namespace keeps unbindable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-2-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=8098; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m0S9l+McXWICJxf57la+Zy01hmodehdgzaKkbfE7ND8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnpn+tOiuJN3Wq8wVCR9k19Wce/eYoNc9bX5AU9LE
 /WMM80cO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSp8Hwv17T2imtqEFm19yd
 cxKdLqV1uhx12beuhv1fq1jMU8FZ6xj+6b+3rHd48tJAJOFSW7W33LewltmBt+cxXUia7L7BZ+U
 5dgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make a tmpfs unbindable, copy the mount namespace and check from the
copy that:

- a bind of the mount fails with EINVAL

- a recursive bind fails as well

- open_tree(OPEN_TREE_CLONE) of it fails

- mountinfo still shows it as unbindable

- a copy of the copy refuses the bind too

The first case runs in the original namespace so the fixture stays
honest about what it set up.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../filesystems/mntns_unbindable/Makefile          |   6 +
 .../mntns_unbindable/mntns_unbindable_test.c       | 227 +++++++++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 273853937c25..a3df9a15ebb7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -50,6 +50,7 @@ TARGETS += filesystems/empty_mntns
 TARGETS += filesystems/fsmount_ns
 TARGETS += filesystems/fscontext_ns
 TARGETS += filesystems/xattr
+TARGETS += filesystems/mntns_unbindable
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/mntns_unbindable/Makefile b/tools/testing/selftests/filesystems/mntns_unbindable/Makefile
new file mode 100644
index 000000000000..33a311c5bd72
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mntns_unbindable/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := mntns_unbindable_test
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/mntns_unbindable/mntns_unbindable_test.c b/tools/testing/selftests/filesystems/mntns_unbindable/mntns_unbindable_test.c
new file mode 100644
index 000000000000..9aebc37cf74d
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mntns_unbindable/mntns_unbindable_test.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An unbindable mount stays unbindable in a cloned mount namespace.
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
+
+#include "../../kselftest_harness.h"
+
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE		1
+#endif
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC	O_CLOEXEC
+#endif
+
+static int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,		/* the operation failed with EINVAL as it must */
+	CHILD_ALLOWED,		/* the operation succeeded: the flag was lost */
+	CHILD_UNSHARE,		/* unshare(CLONE_NEWNS) failed */
+	CHILD_ERRNO,		/* the operation failed with some other errno */
+	CHILD_MOUNTINFO,	/* the mount was not found in mountinfo */
+};
+
+FIXTURE(mntns_unbindable)
+{
+	char base[64];
+	char src[80];
+	char dst[80];
+	bool mounted;
+};
+
+FIXTURE_SETUP(mntns_unbindable)
+{
+	self->mounted = false;
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->base, sizeof(self->base), "/tmp/mntns_unbindable.XXXXXX");
+	ASSERT_NE(mkdtemp(self->base), NULL);
+	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, NULL), 0);
+	self->mounted = true;
+
+	snprintf(self->src, sizeof(self->src), "%s/src", self->base);
+	snprintf(self->dst, sizeof(self->dst), "%s/dst", self->base);
+	ASSERT_EQ(mkdir(self->src, 0755), 0);
+	ASSERT_EQ(mkdir(self->dst, 0755), 0);
+
+	ASSERT_EQ(mount("tmpfs", self->src, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mount(NULL, self->src, NULL, MS_UNBINDABLE, NULL), 0);
+}
+
+FIXTURE_TEARDOWN(mntns_unbindable)
+{
+	if (self->mounted)
+		umount2(self->base, MNT_DETACH);
+	rmdir(self->base);
+}
+
+static int classify(int ret, int err)
+{
+	if (ret >= 0)
+		return CHILD_ALLOWED;
+	return err == EINVAL ? CHILD_OK : CHILD_ERRNO;
+}
+
+/* Is the mount on @mountpoint marked unbindable in /proc/self/mountinfo? */
+static int mountinfo_unbindable(const char *mountpoint)
+{
+	char line[4096];
+	FILE *f;
+	int ret = CHILD_MOUNTINFO;
+
+	f = fopen("/proc/self/mountinfo", "re");
+	if (!f)
+		return CHILD_ERRNO;
+
+	while (fgets(line, sizeof(line), f)) {
+		char *fields[6], *p = line, *opt;
+		int i;
+
+		for (i = 0; i < 6; i++) {
+			fields[i] = strsep(&p, " ");
+			if (!fields[i])
+				break;
+		}
+		if (i < 6 || strcmp(fields[4], mountpoint))
+			continue;
+
+		/* the optional fields, up to the "-" separator */
+		ret = CHILD_ALLOWED;
+		while ((opt = strsep(&p, " ")) && strcmp(opt, "-")) {
+			if (!strcmp(opt, "unbindable"))
+				ret = CHILD_OK;
+		}
+		break;
+	}
+	fclose(f);
+	return ret;
+}
+
+static int run_in_child(int (*fn)(const char *src, const char *dst),
+			const char *src, const char *dst)
+{
+	int status;
+	pid_t pid;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+	if (pid == 0)
+		_exit(fn(src, dst));
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+static int bind_after_clone(const char *src, const char *dst)
+{
+	int ret;
+
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	ret = mount(src, dst, NULL, MS_BIND, NULL);
+	return classify(ret, errno);
+}
+
+static int rbind_after_clone(const char *src, const char *dst)
+{
+	int ret;
+
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	ret = mount(src, dst, NULL, MS_BIND | MS_REC, NULL);
+	return classify(ret, errno);
+}
+
+static int open_tree_after_clone(const char *src, const char *dst)
+{
+	int ret;
+
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	ret = sys_open_tree(AT_FDCWD, src, OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	return classify(ret, errno);
+}
+
+static int mountinfo_after_clone(const char *src, const char *dst)
+{
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	return mountinfo_unbindable(src);
+}
+
+static int bind_after_two_clones(const char *src, const char *dst)
+{
+	int ret;
+
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	ret = mount(src, dst, NULL, MS_BIND, NULL);
+	return classify(ret, errno);
+}
+
+/* The namespace the mount was made unbindable in. */
+TEST_F(mntns_unbindable, refuses_bind)
+{
+	int ret = mount(self->src, self->dst, NULL, MS_BIND, NULL);
+
+	ASSERT_EQ(classify(ret, errno), CHILD_OK);
+	ASSERT_EQ(mountinfo_unbindable(self->src), CHILD_OK);
+}
+
+/* A copy of the namespace must not turn the mount bindable. */
+TEST_F(mntns_unbindable, refuses_bind_after_clone)
+{
+	ASSERT_EQ(run_in_child(bind_after_clone, self->src, self->dst), CHILD_OK)
+		TH_LOG("bind of an unbindable mount allowed in a copied mount namespace");
+}
+
+TEST_F(mntns_unbindable, refuses_rbind_after_clone)
+{
+	ASSERT_EQ(run_in_child(rbind_after_clone, self->src, self->dst), CHILD_OK)
+		TH_LOG("rbind of an unbindable mount allowed in a copied mount namespace");
+}
+
+TEST_F(mntns_unbindable, refuses_open_tree_after_clone)
+{
+	ASSERT_EQ(run_in_child(open_tree_after_clone, self->src, self->dst), CHILD_OK)
+		TH_LOG("OPEN_TREE_CLONE of an unbindable mount allowed in a copied mount namespace");
+}
+
+TEST_F(mntns_unbindable, mountinfo_after_clone)
+{
+	ASSERT_EQ(run_in_child(mountinfo_after_clone, self->src, self->dst), CHILD_OK)
+		TH_LOG("mountinfo does not show the mount as unbindable in a copied mount namespace");
+}
+
+TEST_F(mntns_unbindable, refuses_bind_after_two_clones)
+{
+	ASSERT_EQ(run_in_child(bind_after_two_clones, self->src, self->dst), CHILD_OK)
+		TH_LOG("bind of an unbindable mount allowed two mount namespace copies down");
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

