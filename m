Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497A3C1F26;
	Wed, 26 Aug 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741259; cv=none; b=RrRb2J1gh25d2TcxMwX6q/zisA3yo2GUhLYFpUL764Xw94jFDzEUOZ2h/KzsMgrEvTlCxNJwINpHKnRW1HEWVFnYgNeTcscNuS5kSVInwlZvN7M5a3BCF+EiMO8UE9/8ws+gOf8SeJoHfE6Nk7Buao8yAxefjuFp0bkrmnz2qEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741259; c=relaxed/simple;
	bh=R0Jc5G8dbVSvocONbaEU81JeHaeFHc3batHC8Wrep4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIqP/ZpdteUpHkjtDIQ4Ks55gH4iv0LdRi+HrmlqtCNtIMrWu+0l12ZHkRg1W6/ShC9WV0i+m848W1wl5+Xx5rctyBVlW6dOJRoQv1fO3qhPs2LzJ7hkcOim8vHaM4yiRMeBni6UXsb8qzJmalgy/vY1lsT9Q1G7jqGFV59R6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rP5bBYGT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rP5bBYGT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=40yjb18p74u31dH41pR2d6raPKWYVY5/NV+YejrNyBI=; b=rP5bBYGT53gxV2WXVSpR3zFmxa
	ELa/gyO1K0krlMqyWtt8O6nSgXL3sLm7kSpM8R29gydhvZkaTP8vLi1bn0taO7zf8FrK5zIALFEy3
	P977ZGSVA1h5anPmCSkn8w9PQWwXcwWHwxVxzRn5Xe82YkLWdpxKJuiPVUqBfqIhOu376YvHNdEwt
	sWTJmPLY7m+jHOLLIORaWGPeZnOONsqecPIuyXGoMoL+O+u0kQpE6odzJv2F09JVxz4acd6+LJ3/y
	frkxKqWQxX6RVvyjIK6JRQfnGKn63d5ctZCQrcN9Wx2WLvgatAbt5kb8ESG0/xzejtZRl1ZN9L+km
	eq5OdP4A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzBAB-00FA0j-2b;
	Wed, 26 Aug 2026 10:47:24 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 26 Aug 2026 03:47:02 -0700
Subject: [PATCH 1/4] selftests/configfs: add tests for the userspace
 interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-config_selftest-v1-1-e364b07e91ac@debian.org>
References: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
In-Reply-To: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
To: Shuah Khan <shuah@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 gustavold@gmail.com, linux-fsdevel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 vasilisalmpanis@gmail.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=11481; i=leitao@debian.org;
 h=from:subject:message-id; bh=R0Jc5G8dbVSvocONbaEU81JeHaeFHc3batHC8Wrep4k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjsQzDCy2sakmpk0wqGkMBTibVO9MaXpSq2B+p
 PpuL6FK1ZmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao7EMwAKCRA1o5Of/Hh3
 baZ9D/9Kq2wYSDLkK9s/9XbOm6E6g5+hDqhAAGb0lYBRedKUVbCdmmy1Hb0NKHDrRBl6CIu5/n+
 GkNlRce1//HYareA8FVuKsYvFQuUspDkVuoflmEuv6P5u31hcVQK3vFhaOrOrzCuG38SF52QK7a
 UEGo8EXfFqArIS1b0uMxey9XQrlQRZgYcf6IjxTVxiLwa43MQk19wKDrJbn72ocnR4EtWfINHXe
 oNepkcWwSdABRfhQpUEmd1Sf23L9GAw6z+UdX04JCaIQV5SEsjUbKKZY/OIgDlYh8nIjRupCj9K
 vBLJ7AGu7ttzvOygdMrbAhGahgCexR0JXvvf+hHxKgrg1i7LvxxZh4pWQbdEQE0BpO2k/koyndK
 QF6k86K+Ab7EFiltHdlWtQvpZu2clh3DDI6zIXAtDQu3xL16J8/XDRIZmG7M8O7Ap8IEBzo8Oi/
 8mQ1N7YoxX8FwP+7UGofNPi9qAvM7POokrd8vkII6P5A5JGdPAbq97mXShImAX1DRT1gDcY/Ajs
 38bDNmFXdSx2hZJQjFGHH+FCyt94fm6hrmleNLT58MdkgOP8nC4TOuMMBz70s4JSC0HG60JsOR5
 kCQGz4u5caECYpNd9DRWg4Py7vFkyYykY7f3DeOuqSETm0lSoF+sXaoVfjZvEOveZHmZWwKRYfy
 tEy82Ii/O8QIefw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

configfs has no selftest coverage.  Its userspace ABI is entirely
mkdir/rmdir/read/write on attribute files, and the error each of those
returns is part of the contract.

Add tests driving the subsystems samples/configfs registers, each in its
own mount namespace on a private configfs mount.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/configfs/.gitignore      |   2 +
 .../selftests/filesystems/configfs/Makefile        |   8 +
 .../testing/selftests/filesystems/configfs/config  |   5 +
 .../selftests/filesystems/configfs/configfs_test.c | 338 +++++++++++++++++++++
 6 files changed, 355 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe10d29b7657b..69aea9931b774 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6604,6 +6604,7 @@ S:	Supported
 F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	samples/configfs/
+F:	tools/testing/selftests/filesystems/configfs/
 
 CONFIGFS [RUST]
 M:	Andreas Hindborg <a.hindborg@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d960626750e3..b328a235f1295 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -34,6 +34,7 @@ TARGETS += exec
 TARGETS += fchmodat2
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
+TARGETS += filesystems/configfs
 TARGETS += filesystems/epoll
 TARGETS += filesystems/failfs
 TARGETS += filesystems/fat
diff --git a/tools/testing/selftests/filesystems/configfs/.gitignore b/tools/testing/selftests/filesystems/configfs/.gitignore
new file mode 100644
index 0000000000000..accfb6bb48268
--- /dev/null
+++ b/tools/testing/selftests/filesystems/configfs/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+configfs_test
diff --git a/tools/testing/selftests/filesystems/configfs/Makefile b/tools/testing/selftests/filesystems/configfs/Makefile
new file mode 100644
index 0000000000000..359296356c831
--- /dev/null
+++ b/tools/testing/selftests/filesystems/configfs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+# Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+
+CFLAGS += -Wall -Werror
+TEST_GEN_PROGS := configfs_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/configfs/config b/tools/testing/selftests/filesystems/configfs/config
new file mode 100644
index 0000000000000..5ea17df535b3f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/configfs/config
@@ -0,0 +1,5 @@
+CONFIG_CONFIGFS_FS=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_SAMPLES=y
+CONFIG_SAMPLE_CONFIGFS=m
diff --git a/tools/testing/selftests/filesystems/configfs/configfs_test.c b/tools/testing/selftests/filesystems/configfs/configfs_test.c
new file mode 100644
index 0000000000000..072d0dcf3f96b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/configfs/configfs_test.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Exercise the configfs userspace interface through the three subsystems
+ * registered by samples/configfs.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+ * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+/* Private to fs/configfs/mount.c. */
+#define CONFIGFS_MAGIC		0x62656570
+
+#define SAMPLE_MODULE		"configfs_sample"
+
+#define CHILDLESS		"01-childless"
+#define SIMPLE			"02-simple-children"
+#define GROUPS			"03-group-children"
+
+#define ITEM_A			SIMPLE "/kselftest-a"
+#define ITEM_B			SIMPLE "/kselftest-b"
+#define GROUP			GROUPS "/kselftest-group"
+#define GROUP_ITEM		GROUP "/kselftest-a"
+
+/* Deepest first, so one pass empties the tree. */
+static const char * const test_dirs[] = {
+	GROUP_ITEM,
+	GROUP,
+	ITEM_A,
+	ITEM_B,
+};
+
+static void drop_test_dirs(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(test_dirs); i++)
+		rmdir(test_dirs[i]);
+}
+
+static ssize_t read_attr(const char *path, char *buf, size_t len)
+{
+	ssize_t ret;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	ret = read(fd, buf, len - 1);
+	close(fd);
+	if (ret < 0)
+		return -1;
+
+	buf[ret] = '\0';
+	return ret;
+}
+
+static ssize_t write_attr(const char *path, const char *val)
+{
+	ssize_t ret;
+	int fd, err;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -1;
+
+	ret = write(fd, val, strlen(val));
+	err = errno;
+	close(fd);
+	errno = err;
+
+	return ret;
+}
+
+FIXTURE(configfs) {
+	char mnt[sizeof(P_tmpdir "/configfs_XXXXXX")];
+	bool mounted;
+};
+
+FIXTURE_SETUP(configfs)
+{
+	char tmpl[] = P_tmpdir "/configfs_XXXXXX";
+
+	if (geteuid())
+		SKIP(return, "need root to load modules and mount configfs");
+
+	ASSERT_EQ(system("modprobe -q " SAMPLE_MODULE), 0)
+		TH_LOG(SAMPLE_MODULE " missing, is CONFIG_SAMPLE_CONFIGFS=m?");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	ASSERT_NE(mkdtemp(tmpl), NULL);
+	strcpy(self->mnt, tmpl);
+
+	ASSERT_EQ(mount("configfs", self->mnt, "configfs", 0, NULL), 0);
+	ASSERT_EQ(chdir(self->mnt), 0);
+	self->mounted = true;
+
+	/* configfs items outlive the mount, so a killed run leaves some. */
+	drop_test_dirs();
+}
+
+FIXTURE_TEARDOWN(configfs)
+{
+	if (self->mounted) {
+		drop_test_dirs();
+		EXPECT_EQ(chdir("/"), 0);
+		EXPECT_EQ(umount2(self->mnt, MNT_DETACH), 0);
+	}
+
+	if (self->mnt[0])
+		EXPECT_EQ(rmdir(self->mnt), 0);
+}
+
+TEST_F(configfs, mount_and_subsystems)
+{
+	const char * const subsys[] = { CHILDLESS, SIMPLE, GROUPS };
+	struct statfs sfs;
+	struct stat st;
+	size_t i;
+
+	ASSERT_EQ(statfs(".", &sfs), 0);
+	EXPECT_EQ(sfs.f_type, CONFIGFS_MAGIC);
+
+	for (i = 0; i < ARRAY_SIZE(subsys); i++) {
+		ASSERT_EQ(stat(subsys[i], &st), 0)
+			TH_LOG("%s is missing", subsys[i]);
+		EXPECT_TRUE(S_ISDIR(st.st_mode));
+	}
+}
+
+TEST_F(configfs, mkdir_at_root)
+{
+	/* The root has no ->mkdir(); only subsystems register there. */
+	ASSERT_EQ(mkdir("kselftest-root", 0755), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, rmdir_subsystem)
+{
+	ASSERT_EQ(rmdir(CHILDLESS), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, mkdir_without_group_ops)
+{
+	/* 01-childless has attributes but no ->make_item()/->make_group(). */
+	ASSERT_EQ(mkdir(CHILDLESS "/kselftest-a", 0755), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, attr_store_and_show)
+{
+	char buf[64];
+
+	ASSERT_GT(write_attr(CHILDLESS "/storeme", "42"), 0);
+	ASSERT_GT(read_attr(CHILDLESS "/storeme", buf, sizeof(buf)), 0);
+	EXPECT_STREQ(buf, "42\n");
+}
+
+TEST_F(configfs, attr_store_rejects_garbage)
+{
+	ASSERT_EQ(write_attr(CHILDLESS "/storeme", "not-a-number"), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(configfs, attr_show_runs_on_every_open)
+{
+	char first[64], second[64];
+
+	/* 01-childless/showme increments the value it just returned. */
+	ASSERT_GT(read_attr(CHILDLESS "/showme", first, sizeof(first)), 0);
+	ASSERT_GT(read_attr(CHILDLESS "/showme", second, sizeof(second)), 0);
+	EXPECT_EQ(atoi(second), atoi(first) + 1);
+}
+
+TEST_F(configfs, attr_read_only)
+{
+	ASSERT_EQ(open(CHILDLESS "/description", O_WRONLY), -1);
+	EXPECT_EQ(errno, EACCES);
+}
+
+TEST_F(configfs, attr_unlink)
+{
+	/* ->unlink() only accepts the symlinks configfs itself created. */
+	ASSERT_EQ(unlink(CHILDLESS "/storeme"), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, attr_read_length)
+{
+	char buf[8192];
+	struct stat st;
+	ssize_t n;
+	int fd;
+
+	fd = open(CHILDLESS "/description", O_RDONLY);
+	ASSERT_GE(fd, 0);
+
+	/* Attributes report a page, whatever ->show() ends up producing. */
+	ASSERT_EQ(fstat(fd, &st), 0);
+	EXPECT_EQ(st.st_size, sysconf(_SC_PAGESIZE));
+
+	n = read(fd, buf, sizeof(buf));
+	ASSERT_GT(n, 0);
+	EXPECT_LT(n, st.st_size);
+	EXPECT_EQ(read(fd, buf, sizeof(buf)), 0);
+
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST_F(configfs, attr_write_is_not_incremental)
+{
+	char buf[64];
+	int fd;
+
+	/*
+	 * Every write hands the whole buffer to ->store() and the file
+	 * position is ignored, so the second write replaces the first.
+	 */
+	fd = open(CHILDLESS "/storeme", O_WRONLY);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, "1", 1), 1);
+	ASSERT_EQ(write(fd, "2", 1), 1);
+	EXPECT_EQ(close(fd), 0);
+
+	ASSERT_GT(read_attr(CHILDLESS "/storeme", buf, sizeof(buf)), 0);
+	EXPECT_STREQ(buf, "2\n");
+}
+
+TEST_F(configfs, item_create_and_drop)
+{
+	struct stat st;
+
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	EXPECT_EQ(stat(ITEM_A "/storeme", &st), 0);
+
+	/* The item carries its own attributes, not the subsystem's. */
+	ASSERT_EQ(stat(ITEM_A "/description", &st), -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	ASSERT_EQ(rmdir(ITEM_A), 0);
+	ASSERT_EQ(stat(ITEM_A, &st), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+TEST_F(configfs, item_create_twice)
+{
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(mkdir(ITEM_A, 0755), -1);
+	EXPECT_EQ(errno, EEXIST);
+}
+
+TEST_F(configfs, item_has_no_children)
+{
+	/* ->make_item() produces an item, so it cannot nest. */
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(mkdir(ITEM_A "/kselftest-b", 0755), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, item_attrs_are_private)
+{
+	char buf[64];
+
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(mkdir(ITEM_B, 0755), 0);
+
+	ASSERT_GT(write_attr(ITEM_A "/storeme", "11"), 0);
+	ASSERT_GT(write_attr(ITEM_B "/storeme", "22"), 0);
+
+	ASSERT_GT(read_attr(ITEM_A "/storeme", buf, sizeof(buf)), 0);
+	EXPECT_STREQ(buf, "11\n");
+	ASSERT_GT(read_attr(ITEM_B "/storeme", buf, sizeof(buf)), 0);
+	EXPECT_STREQ(buf, "22\n");
+}
+
+TEST_F(configfs, group_create_and_drop)
+{
+	struct stat st;
+
+	/* 03-group-children hands out groups that take items of their own. */
+	ASSERT_EQ(mkdir(GROUP, 0755), 0);
+	EXPECT_EQ(stat(GROUP "/description", &st), 0);
+
+	ASSERT_EQ(mkdir(GROUP_ITEM, 0755), 0);
+	EXPECT_EQ(stat(GROUP_ITEM "/storeme", &st), 0);
+
+	ASSERT_EQ(rmdir(GROUP), -1);
+	EXPECT_EQ(errno, ENOTEMPTY);
+
+	ASSERT_EQ(rmdir(GROUP_ITEM), 0);
+	ASSERT_EQ(rmdir(GROUP), 0);
+}
+
+TEST_F(configfs, rename_item)
+{
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(rename(ITEM_A, ITEM_B), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, symlink_without_allow_link)
+{
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(symlink(ITEM_A, SIMPLE "/kselftest-link"), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, module_pinned_by_item)
+{
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+
+	/* mkdir() pins both the subsystem's module and the new item's. */
+	ASSERT_EQ(syscall(__NR_delete_module, SAMPLE_MODULE, O_NONBLOCK), -1);
+	if (errno == ENOSYS)
+		SKIP(return, "kernel built without CONFIG_MODULE_UNLOAD");
+	EXPECT_EQ(errno, EWOULDBLOCK);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0-Meta

