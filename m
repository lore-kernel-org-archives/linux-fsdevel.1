Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E282AEE1
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037310; cv=none; b=TlVrYbFumX3c1Mu+9UKIdWZIPIf10lWZ7yAoeP0/Wj0lUgptNxEaOQhPUZUi2cXdIAtDc2B4aBMT8n/QWbnPX3HUvCBZY5oLZm+DoB4nlW7/MocJzZ9XsHgWEVEU9EExSgtkJmaKnbgHTl89K4JFbkP56IEMD0CfNWGhWr8dVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037310; c=relaxed/simple;
	bh=Q5b2vDnrWvxa8fgYAV+5OAdf+m0McEfeV+rZI17SqXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZUmB5gLgafUqYtLRxbrPzBB68S/m3uPh1wrCas3wbTbuuF8eHxiy+RFd4+a4M/Fc/qF+aCDQov9SW0twPnfm5nvbeYOKamwOBTz3jX9r2I8gsG/wci6znRGvfCuZIDYMwP6hDRDZhptuvAeFeRCeEZcSqZedAJ7KQZjVBgO3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lEuCi0My; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lEuCi0My"
X-KPN-MessageId: 16ee921e-5212-11f1-8ff5-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 16ee921e-5212-11f1-8ff5-005056999439;
	Sun, 17 May 2026 19:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=B2vH4wU8b83ahNNtbdzq0IBxSbbn5nfHyUNzFF92VOM=;
	b=lEuCi0MyJte8DyaxTAcTJXNk26o76iCAPobQ81Rm9WUGddZu2D4B1W5lVlMgDEC24v+couBDwKzD7
	 8kp6Hq/HW92gZMxoGBUMpcVX/E/snpy8ozLW1j4HaU8n9qJqNblKW1Qvz+7MUlWcf/sYXPo5YIHWZn
	 6SwjIllvs8MGrbELSNCcw+Q6vtJvLL19IuyFIODRGQa/orsW60xAKPih4e+qy/1jnNqdCYEuk3fc5V
	 Z0ytF7LVDvGpOUVEqOZeTn/PvnJ/VbTSVxmle+hx9ihlmuPvcUh/5lAb/7/13LLBDliGgeONBHSXQb
	 /8Tva71TNfju6lyoFyMQbrQE+gUdvsg==
X-KPN-MID: 33|GTnBt6VrL6+vNvCoybNYwJ8R/9AYcEhjoEecLEjNJNoFG6uuO4Ber7MJTytU1vY
 ouvi/0ja2BCxOMdGIetei2g==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SmvDfgtaGorFzD9qsUWiLuGkR620tVhJV4aHqlWvN9QLec+EuQXxKkH/MPhT8Ol
 g2YZ8w6eIJ7mYi3cR3sc8MA==
Received: from daedalus.home (unknown [178.227.141.161])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 16b86ab8-5212-11f1-abb2-00505699b758;
	Sun, 17 May 2026 19:01:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Subject: [RFC PATCH v3 2/2] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
Date: Sun, 17 May 2026 19:02:44 +0200
Message-ID: <20260517170244.1832119-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517170244.1832119-1-jkoolstra@xs4all.nl>
References: <20260517170244.1832119-1-jkoolstra@xs4all.nl>
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
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_directory.c    | 147 ++++++++++++++++++
 4 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_directory.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 64ac0dfa46b7..a6311d50947a 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+open_o_creat_o_directory
 dnotify_test
 devpts_pts
 fclog
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 85427d7f19b9..ca4ef31d0e48 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+CFLAGS += $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+TEST_GEN_PROGS := open_o_creat_o_directory devpts_pts file_stressor anon_inode_test kernfs_test fclog
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 551c4a0f395a..33ed59286a2d 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2025 SUSE LLC.
  */
 
+#include <fcntl.h>
 #include <assert.h>
 #include <errno.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_directory.c b/tools/testing/selftests/filesystems/open_o_creat_o_directory.c
new file mode 100644
index 000000000000..8b77ffebe1d3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_o_creat_o_directory.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <errno.h>
+#include <limits.h>
+#include <fcntl.h>
+
+#include "kselftest_harness.h"
+
+#define mkdirat_fd_checked_flags(dfd, pathname, flags) ({	\
+	struct stat __st;					\
+	int __fd = mkdirat_fd(dfd, pathname, S_IRWXU, flags);	\
+	ASSERT_GE(__fd, 0);					\
+	EXPECT_EQ(fstat(__fd, &__st), 0);			\
+	EXPECT_TRUE(S_ISDIR(__st.st_mode));			\
+	__fd;							\
+})
+
+#define mkdirat_fd_checked(dfd, pathname) \
+	mkdirat_fd_checked_flags(dfd, pathname, 0)
+
+static inline int mkdirat_fd(int dfd, const char *pathname, mode_t mode,
+                             unsigned int flags)
+{
+    return syscall(__NR_openat, dfd, pathname,
+                   flags | O_DIRECTORY | O_CREAT, mode);
+}
+
+FIXTURE(mkdirat_fd) {
+	char dirpath[PATH_MAX];
+	int dfd;
+};
+
+FIXTURE_SETUP(mkdirat_fd)
+{
+	snprintf(self->dirpath, sizeof(self->dirpath),
+		 "/tmp/mkdirat_fd_test.%d", getpid());
+	ASSERT_EQ(mkdir(self->dirpath, S_IRWXU), 0);
+
+	self->dfd = open(self->dirpath, O_DIRECTORY);
+	ASSERT_GE(self->dfd, 0);
+}
+
+FIXTURE_TEARDOWN(mkdirat_fd)
+{
+	close(self->dfd);
+	rmdir(self->dirpath);
+}
+
+/* Does mkdirat_fd return a fd at all */
+TEST_F(mkdirat_fd, returns_fd)
+{
+	int fd = mkdirat_fd_checked(self->dfd, "newdir");
+	EXPECT_EQ(close(fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "newdir", AT_REMOVEDIR), 0);
+}
+
+/* The fd must refer to the directory that was just created. */
+TEST_F(mkdirat_fd, fd_is_created_dir)
+{
+	int fd;
+	struct stat st_via_fd, st_via_path;
+	char path[PATH_MAX];
+
+	fd = mkdirat_fd_checked(self->dfd, "checkdir");
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
+
+/* Missing parent component must fail with ENOENT. */
+TEST_F(mkdirat_fd, enoent_missing_parent)
+{
+	EXPECT_EQ(mkdirat_fd(self->dfd, "nonexistent/child", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+/* An invalid dfd must fail with EBADF. */
+TEST_F(mkdirat_fd, ebadf)
+{
+	EXPECT_EQ(mkdirat_fd(-42, "badfdir", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
+/* A dfd that points to a file (not a directory) must fail with ENOTDIR. */
+TEST_F(mkdirat_fd, enotdir_dfd)
+{
+	int file_fd;
+
+	file_fd = openat(self->dfd, "file",
+			 O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(file_fd, 0);
+
+	EXPECT_EQ(mkdirat_fd(file_fd, "subdir", S_IRWXU, 0), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+
+	EXPECT_EQ(close(file_fd), 0);
+	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
+}
+
+/*
+ * O_EXCL together with O_CREAT|O_DIRECTORY must fail with EEXIST when
+ * the target directory already exists.
+ */
+TEST_F(mkdirat_fd, o_excl_eexist)
+{
+	int fd;
+
+	fd = mkdirat_fd_checked_flags(self->dfd, "excldir", O_EXCL);
+	EXPECT_EQ(close(fd), 0);
+
+	EXPECT_EQ(mkdirat_fd(self->dfd, "excldir", S_IRWXU, O_EXCL), -1);
+	EXPECT_EQ(errno, EEXIST);
+
+	EXPECT_EQ(unlinkat(self->dfd, "excldir", AT_REMOVEDIR), 0);
+}
+
+/*
+ * The returned fd must be usable as a dfd for further *at() calls.
+ */
+TEST_F(mkdirat_fd, fd_usable_as_dfd)
+{
+	int parent_fd, child_fd;
+
+	parent_fd = mkdirat_fd_checked(self->dfd, "parent");
+	child_fd = mkdirat_fd_checked(parent_fd, "child");
+
+	EXPECT_EQ(close(child_fd), 0);
+	EXPECT_EQ(close(parent_fd), 0);
+
+	char path[PATH_MAX];
+	snprintf(path, sizeof(path), "%s/parent/child", self->dirpath);
+	EXPECT_EQ(rmdir(path), 0);
+	snprintf(path, sizeof(path), "%s/parent", self->dirpath);
+	EXPECT_EQ(rmdir(path), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0

