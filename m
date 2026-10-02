Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1764B7A37;
	Fri,  2 Oct 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949244; cv=none; b=D8pDCO8xh03hH0pJTWL/8SiW7md9+ZGdXbsvt+Q8nTSLa4//aetY8uRl104fJbOkP/WbYzR12NYjlieln/bz28cJmZuDv5RtB5nMNbQNoOdae+souyib2ipSWzDZUyMNA5qH7urfLumq7Na7OhgYnEFyiBIMYWYL06FBAty+89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949244; c=relaxed/simple;
	bh=smqG1rdhN4yml4qsQaZF1MOXWSNsbuhuLiOm4TCb4Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSiBRcBBMB0iZ7VuMbhDbLHByGhOlJVh6lH4LEMJn2GIWLE6IJtiPsdYRQFBZ8L2kXWYQVyuF2NFHzfCyvS2K5I7EZvvZtMtB/eMDyh0wYUdRJyxuCNU5RogZF/VNj5GY09qPHIXmDjPWHd5ZYRrH5bkAHCQaBOT1RMkr2J7xUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhFGiySv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhFGiySv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8951F00893;
	Fri,  2 Oct 2026 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949243;
	bh=WofcxhoN+cY7M23AhhbaDERav8OB8FMw1NsclYq6ysg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nhFGiySvW7Qtqe1tQyZ4aQipvC8+d+R0NjTqYYK2n94E188KQKZW117M1QdlsnI9W
	 IifAvnNMWyJsG8Sn2uIGosOWJJsF3l92MO/SIJE/tP/fIsolTR74HjI09fSkYhnDnz
	 I+Gc5zGr9ondtmBtBjfZJxCisLZXpTN7UzyalGZR40VaUb+8AZk+4GCIKb52zCrUS6
	 9lnRvCXCEFv1FdMo5gYhDLCAKKw3jPyYC440zj2FVMC2MzOhl8ALIwQhAXzH4WqYkn
	 2f8qgHzjOSBnmFhjRPo5AisLNUEV0qvrwlGkpv53d2l1BEmzEBlzQDaXOCHXRqpi9a
	 QQi6c1XCSVY1w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:42 +0200
Subject: [PATCH 11/21] selftests/filesystems: check the atime of the empty
 mount namespace root
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-11-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4806; i=brauner@kernel.org;
 h=from:subject:message-id; bh=smqG1rdhN4yml4qsQaZF1MOXWSNsbuhuLiOm4TCb4Ms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x75eGKJ0x2JPTIHrdr+LNsVMullF+v2xLOJhm1LO
 je8ERKZ11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRdYqMDDM99mz69eG+VtLW
 E7zrDHZHMv+Vva4WtUavln/SQpUVVVcZ/qm9/j//dvbT4Je7C4QeizXorLbennLxKtsqq3nRE5h
 XK7MAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No access time updates for immutable nullfs.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/empty_mntns/.gitignore   |   1 +
 .../selftests/filesystems/empty_mntns/Makefile     |   2 +-
 .../filesystems/empty_mntns/nullfs_atime_test.c    | 129 +++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/.gitignore b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
index 32125b3eaa80..8ea166068d6b 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/.gitignore
+++ b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
@@ -3,3 +3,4 @@ clone3_empty_mntns_test
 empty_mntns_test
 overmount_chroot_test
 internal_sb_reconfigure_test
+nullfs_atime_test
diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
index b64818b962ca..4b2ea6acec1c 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/Makefile
+++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test clone3_empty_mntns_test
-TEST_GEN_PROGS += internal_sb_reconfigure_test
+TEST_GEN_PROGS += internal_sb_reconfigure_test nullfs_atime_test
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/filesystems/empty_mntns/nullfs_atime_test.c b/tools/testing/selftests/filesystems/empty_mntns/nullfs_atime_test.c
new file mode 100644
index 000000000000..51e34f3c4f54
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/nullfs_atime_test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The root of every empty mount namespace is the same nullfs inode. A read
+ * of it by one user must not change the access time another user sees.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include "../../kselftest_harness.h"
+
+#ifndef UNSHARE_EMPTY_MNTNS
+#define UNSHARE_EMPTY_MNTNS	0x00100000
+#endif
+
+enum {
+	CHILD_OK,
+	CHILD_UNSUPPORTED,
+	CHILD_SETUP,
+	CHILD_CHANGED,
+};
+
+static int wait_byte(int fd)
+{
+	char c;
+
+	return read(fd, &c, 1) == 1 ? 0 : -1;
+}
+
+static int send_byte(int fd)
+{
+	return write(fd, "x", 1) == 1 ? 0 : -1;
+}
+
+static int empty_mntns(void)
+{
+	if (!unshare(UNSHARE_EMPTY_MNTNS))
+		return 0;
+	return errno == EINVAL ? CHILD_UNSUPPORTED : CHILD_SETUP;
+}
+
+/* the watcher: stats its root before and after the reader read its own */
+static int watcher(int to_reader, int from_reader)
+{
+	struct stat before, after;
+	int ret;
+
+	ret = empty_mntns();
+	if (ret)
+		return ret;
+	if (stat("/", &before))
+		return CHILD_SETUP;
+	if (send_byte(to_reader) || wait_byte(from_reader))
+		return CHILD_SETUP;
+	if (stat("/", &after))
+		return CHILD_SETUP;
+	if (before.st_atim.tv_sec != after.st_atim.tv_sec ||
+	    before.st_atim.tv_nsec != after.st_atim.tv_nsec)
+		return CHILD_CHANGED;
+	return CHILD_OK;
+}
+
+/* the reader: lists its own root, which is the same inode */
+static int reader(int to_watcher, int from_watcher)
+{
+	struct dirent *de;
+	DIR *d;
+	int ret;
+
+	ret = empty_mntns();
+	if (ret)
+		return ret;
+	if (wait_byte(from_watcher))
+		return CHILD_SETUP;
+	d = opendir("/");
+	if (!d)
+		return CHILD_SETUP;
+	while ((de = readdir(d)))
+		;
+	closedir(d);
+	return send_byte(to_watcher) ? CHILD_SETUP : CHILD_OK;
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
+TEST(empty_mntns_root_atime)
+{
+	int to_reader[2], to_watcher[2], w, r;
+	pid_t watcher_pid, reader_pid;
+
+	if (geteuid())
+		SKIP(return, "test requires root");
+	ASSERT_EQ(pipe(to_reader), 0);
+	ASSERT_EQ(pipe(to_watcher), 0);
+
+	watcher_pid = fork();
+	ASSERT_GE(watcher_pid, 0);
+	if (watcher_pid == 0)
+		_exit(watcher(to_reader[1], to_watcher[0]));
+	reader_pid = fork();
+	ASSERT_GE(reader_pid, 0);
+	if (reader_pid == 0)
+		_exit(reader(to_watcher[1], to_reader[0]));
+
+	r = wait_child(reader_pid);
+	w = wait_child(watcher_pid);
+	if (r == CHILD_UNSUPPORTED || w == CHILD_UNSUPPORTED)
+		SKIP(return, "UNSHARE_EMPTY_MNTNS not supported");
+	EXPECT_EQ(r, CHILD_OK);
+	EXPECT_EQ(w, CHILD_OK)
+		TH_LOG("the access time of the root changed while this namespace did nothing");
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

