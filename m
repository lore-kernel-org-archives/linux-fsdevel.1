Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1D4B1295;
	Fri,  2 Oct 2026 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949229; cv=none; b=NYZh5UyEp1Qqz/DhH66rTH1koYAQ7jK2+vlrNO9V2Dk46k4NUtGmbjj3iorhBObKjOfhnXluUl+p4NBcnZDn+lTKhnrrpgO26ueXQKWjuptn8GKYQeuqaxb6wnqqfXzoT1QLtAOzFi3TmaUmkJfrrckYfUFd+tKoTReFlnqYDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949229; c=relaxed/simple;
	bh=1Q+Q4LX/55IszJzTnpyMw8HwcyCJEI8wmAEaQd6Hw3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMTQizbri4bQctXsnMZm+GR9VfZXT8g/zLgL1CkuDtj7wILKj6g5Bp9woZlqBnLjYydG2mIgXmCGEJXCpSvVwSDMN/Ke26fP7h4YvBu46lwMlAnwKSQmbpLJV+HW0XSXmAsHBLlDVRMsvGnOESabLgdVMzE1QyiiUwjJAaSiw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc+YDWKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc+YDWKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF71F000FF;
	Fri,  2 Oct 2026 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949225;
	bh=kS2/p6jVyAPO88aU4C42WvPOIqLbp8GtoLHOKqYKK4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lc+YDWKlh+2q29QnnvWUi2s+rnJEsj/82EH91CXb64YuTxFu98Xru8dgyaQfgRPXl
	 4/WYsmDh6xS55FUWcO908ppOVJK9Sfg9zEmMxVeT8YR+gzp9Ci8rrS4TJvgsJXRWFv
	 mUDw2XrBEa1Pa7e/xV7EUoCFj623eOw6Jx/w1Wa9LDuwABcsY3sWqwauFBuTW/LJE7
	 RZOgZzAJK9z+NbP19F9s2pAUKN3xrFUEG289lGeyDjqJ7+swhjgwIFwwSdQK1q3W9R
	 OMncZDe7qVEVsgK/MoIKdFP3y62NJZTPnRV7EGWN5D3Z0FX42kADupG6RvBGoNbrBd
	 tRjuPWBDHaYCw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:35 +0200
Subject: [PATCH 04/21] selftests/filesystems: check that an immutable inode
 takes no write hint
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-4-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4803; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1Q+Q4LX/55IszJzTnpyMw8HwcyCJEI8wmAEaQd6Hw3E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x5xzLGifKsKh9iaGe7HPMWTHgTP51qz82uGaUj1W
 +NdfIclOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy5RwjQ8cX4aN8p0p/T3jL
 Pr9Y9PtnNvayjbIKM5rehc/b+rZ7ZSAjw9sU0cLwtUm3nPqjZnmea57/Z7NU8Cpz57IrxZclFS+
 95wcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Check that an immutable inode takes no write hint.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   2 +-
 tools/testing/selftests/filesystems/rw_hint_test.c | 129 +++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 9eb185fb2f9d..62f7b1c46649 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -7,3 +7,4 @@ anon_inode_test
 kernfs_test
 idmapped_tmpfile
 ustat_test
+rw_hint_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 03be337c1f35..93e2cc9123b0 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test rw_hint_test
 TEST_GEN_PROGS += idmapped_tmpfile
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
diff --git a/tools/testing/selftests/filesystems/rw_hint_test.c b/tools/testing/selftests/filesystems/rw_hint_test.c
new file mode 100644
index 000000000000..d1930f82f63b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/rw_hint_test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * F_SET_RW_HINT is refused on an immutable inode. Nothing is ever written
+ * to it and it may be shared with everybody, like a namespace file or the
+ * root of an empty mount namespace.
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
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include "../kselftest_harness.h"
+
+/* <linux/fs.h> and <linux/fcntl.h> don't mix with the libc headers */
+#ifndef FS_IOC_GETFLAGS
+#define FS_IOC_GETFLAGS		_IOR('f', 1, long)
+#define FS_IOC_SETFLAGS		_IOW('f', 2, long)
+#endif
+#ifndef FS_IMMUTABLE_FL
+#define FS_IMMUTABLE_FL		0x00000010
+#endif
+#ifndef F_LINUX_SPECIFIC_BASE
+#define F_LINUX_SPECIFIC_BASE	1024
+#endif
+#ifndef F_GET_RW_HINT
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+#endif
+#ifndef RWH_WRITE_LIFE_SHORT
+#define RWH_WRITE_LIFE_SHORT	2
+#endif
+#ifndef UNSHARE_EMPTY_MNTNS
+#define UNSHARE_EMPTY_MNTNS	0x00100000
+#endif
+
+static int set_hint(int fd, uint64_t hint)
+{
+	return fcntl(fd, F_SET_RW_HINT, &hint);
+}
+
+static long get_hint(int fd)
+{
+	uint64_t hint;
+
+	if (fcntl(fd, F_GET_RW_HINT, &hint))
+		return -1;
+	return hint;
+}
+
+TEST(immutable_file)
+{
+	char path[] = "/tmp/rw_hint.XXXXXX";
+	int fd, flags;
+
+	if (geteuid())
+		SKIP(return, "test requires root");
+
+	fd = mkstemp(path);
+	ASSERT_GE(fd, 0);
+	unlink(path);
+	ASSERT_EQ(set_hint(fd, RWH_WRITE_LIFE_SHORT), 0);
+	EXPECT_EQ(get_hint(fd), RWH_WRITE_LIFE_SHORT);
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags)) {
+		close(fd);
+		SKIP(return, "no file attributes on this filesystem");
+	}
+	flags |= FS_IMMUTABLE_FL;
+	ASSERT_EQ(ioctl(fd, FS_IOC_SETFLAGS, &flags), 0);
+	EXPECT_EQ(set_hint(fd, RWH_WRITE_LIFE_SHORT), -1);
+	EXPECT_EQ(errno, EPERM);
+	flags &= ~FS_IMMUTABLE_FL;
+	ASSERT_EQ(ioctl(fd, FS_IOC_SETFLAGS, &flags), 0);
+	EXPECT_EQ(set_hint(fd, RWH_WRITE_LIFE_SHORT), 0);
+	close(fd);
+}
+
+TEST(namespace_file)
+{
+	int fd;
+
+	if (geteuid())
+		SKIP(return, "test requires root");
+
+	fd = open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(set_hint(fd, RWH_WRITE_LIFE_SHORT), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(fd);
+}
+
+TEST(empty_mntns_root)
+{
+	int status;
+	pid_t pid;
+
+	if (geteuid())
+		SKIP(return, "test requires root");
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		int fd;
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(errno == EINVAL ? 100 : 1);
+		fd = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd < 0)
+			_exit(2);
+		if (set_hint(fd, RWH_WRITE_LIFE_SHORT) == 0)
+			_exit(3);
+		_exit(errno == EPERM ? 0 : 4);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) == 100)
+		SKIP(return, "UNSHARE_EMPTY_MNTNS not supported");
+	EXPECT_EQ(WEXITSTATUS(status), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

