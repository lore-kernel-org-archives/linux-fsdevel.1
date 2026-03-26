Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B43AA50E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549344; cv=none; b=kMd9tCGxuyp2DaD9IBXoGvI0/hqGgUfryXPCNo/dRC4dtxiVAH+PK20xCoiPfjKM3SVPAvJKuqNT/m0EI2o7OoEQCcczdPQw3NINoTG2RB+a3fS4Tb5ii1o3uqB+vJnBrxevn6fdMdKSwvUgc4wQNlcFx3R8bT5r2IaMRr7PKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549344; c=relaxed/simple;
	bh=7GDMQnsnPoLWGO0jyZolzsyffqHnMOwYsKrrB0Q5dY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fINLl06AFDsC4SbgvF6j+4G4maQteDH7tNtfVkGTcSkLj0C/bwjkvAt/x7arhx4YKpT+U1x7pT1xhk4ye2W3Cbaf+kMrU2rfDN9os/x4UIGRSKbX14K8OEnnuC7qAS551dQuoAA0RlHl6agBA+pKU7J/oOR+g4oaCZ2N6ohg5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=a38YciZB; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="a38YciZB"
X-KPN-MessageId: ba3c5ee6-2940-11f1-969c-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ba3c5ee6-2940-11f1-969c-005056abbe64;
	Thu, 26 Mar 2026 19:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=5nu3UdauJ29h2bzMPERnJ63kfRsTimZQk9pvIOXzsnY=;
	b=a38YciZBqHqoR/6n4zfhX4LGMHKSSRHJ84cQgscBrG2266VFq7sDL1sGk9+Xq/4koH1Bts5zgyhvP
	 yiaTwN4cq39Dno5vLGnDBKIcHw/E1g2SbLzFHVlr9lHW/qjsW3MBDM7ymaRTG0UHuAkKplgwOZ0J8Q
	 M8gN+ZhGKLunbtj0GFY0uIfAyZbYBg6+IiKovYQqRDhZKOIqtxOdsu6nAdG0nUunhvwvl9DyAWm/ZO
	 zZmUsMZF9/jnEe1OMMTmAVdW3b7Uy4SqhYFANqGVAju5bbR8sKv50lih0RI5+rPRAomgVbY4tIGoNM
	 fNFkdHhpMD/k5EIhSrRvnGAcLZ7YGng==
X-KPN-MID: 33|fEixlRNAzOfcWYu3QC50nKXzfF679iyEnq9Cu/R73FKrdWkDDHso0414cbiJjOZ
 R6QZ2P6NXxzoIW0zUymzQSP2T+vWhMVVTxAG1WNlfB5o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dJea7vBc5Cc7atpH4h/V3ZvtU17dciA+6TiZRGg9Cj+ZmKDO5xMqKhCGZM92gs6
 Mub9GWmkqaLEguTh7Z/9Udw==
Received: from daedalus.home (unknown [178.231.230.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b994a0e8-2940-11f1-b8e8-005056ab7584;
	Thu, 26 Mar 2026 19:22:20 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>,
	Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 3/3] selftest: add tests for OPENAT2_EMPTY_PATH and allowed_upgrades
Date: Thu, 26 Mar 2026 19:20:14 +0100
Message-ID: <20260326182033.1809567-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for new openat2 flag OPENAT2_EMPTY_PATH and new open_how
field: allowed_upgrades.

Also, the current openat2 tests include a helper header file that
defines the necessary structs and constants to use openat2(2), such as
struct open_how. This may result in conflicting definitions when the
system header openat2.h is present as well.

So also add openat2.h generated by 'make headers' to the uapi header
files in ./tools/include and remove the helper file definitions of
the current openat2 selftests.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 tools/include/uapi/linux/openat2.h            |  53 ++++
 tools/testing/selftests/openat2/Makefile      |   4 +-
 tools/testing/selftests/openat2/helpers.c     |   2 +-
 tools/testing/selftests/openat2/helpers.h     |  40 +--
 .../testing/selftests/openat2/upgrade_test.c  | 242 ++++++++++++++++++
 5 files changed, 301 insertions(+), 40 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h
 create mode 100644 tools/testing/selftests/openat2/upgrade_test.c

diff --git a/tools/include/uapi/linux/openat2.h b/tools/include/uapi/linux/openat2.h
new file mode 100644
index 000000000000..fbbf5483dc9d
--- /dev/null
+++ b/tools/include/uapi/linux/openat2.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_OPENAT2_H
+#define _LINUX_OPENAT2_H
+
+#include <linux/types.h>
+
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	__u64 flags;
+	__u64 mode;
+	__u64 resolve;
+	__u64 allowed_upgrades;
+};
+
+/* how->allowed_upgrades flags for openat2(2). */
+#define DENY_UPGRADES		0x01
+#define READ_UPGRADABLE		(0x02 | DENY_UPGRADES)
+#define WRITE_UPGRADABLE	(0x04 | DENY_UPGRADES)
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+#define RESOLVE_CACHED		0x20 /* Only complete if resolution can be
+					completed through cached lookup. May
+					return -EAGAIN if that's not
+					possible. */
+
+/* openat2(2) exclusive flags are defined in the upper 32 bits of
+   open_how->flags  */
+#define OPENAT2_EMPTY_PATH	0x100000000 /* (1ULL << 32) */
+
+#endif /* _LINUX_OPENAT2_H */
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 185dc76ebb5f..cc6d4fad999c 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
-TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(TOOLS_INCLUDES)
+TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test upgrade_test
 
 # gcc requires -static-libasan in order to ensure that Address Sanitizer's
 # library is the first one loaded. However, clang already statically links the
diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
index 5074681ffdc9..b6533f0b1124 100644
--- a/tools/testing/selftests/openat2/helpers.c
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -98,7 +98,7 @@ void __attribute__((constructor)) init(void)
 	struct open_how how = {};
 	int fd;
 
-	BUILD_BUG_ON(sizeof(struct open_how) != OPEN_HOW_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct open_how) != OPEN_HOW_SIZE_VER1);
 
 	/* Check openat2(2) support. */
 	fd = sys_openat2(AT_FDCWD, ".", &how);
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 510e60602511..af94d8211b9f 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -14,6 +14,9 @@
 #include <linux/types.h>
 #include "kselftest.h"
 
+#define OPEN_HOW_SIZE_VER0 24
+#define OPEN_HOW_SIZE_VER1 32
+
 #define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
 #define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
 
@@ -24,45 +27,8 @@
 #define SYS_openat2 __NR_openat2
 #endif /* SYS_openat2 */
 
-/*
- * Arguments for how openat2(2) should open the target path. If @resolve is
- * zero, then openat2(2) operates very similarly to openat(2).
- *
- * However, unlike openat(2), unknown bits in @flags result in -EINVAL rather
- * than being silently ignored. @mode must be zero unless one of {O_CREAT,
- * O_TMPFILE} are set.
- *
- * @flags: O_* flags.
- * @mode: O_CREAT/O_TMPFILE file mode.
- * @resolve: RESOLVE_* flags.
- */
-struct open_how {
-	__u64 flags;
-	__u64 mode;
-	__u64 resolve;
-};
-
-#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
-#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
-
 bool needs_openat2(const struct open_how *how);
 
-#ifndef RESOLVE_IN_ROOT
-/* how->resolve flags for openat2(2). */
-#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
-					(includes bind-mounts). */
-#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
-					"magic-links". */
-#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
-					(implies OEXT_NO_MAGICLINKS) */
-#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
-					"..", symlinks, and absolute
-					paths which escape the dirfd. */
-#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
-					be scoped inside the dirfd
-					(similar to chroot(2)). */
-#endif /* RESOLVE_IN_ROOT */
-
 #define E_func(func, ...)						      \
 	do {								      \
 		errno = 0;						      \
diff --git a/tools/testing/selftests/openat2/upgrade_test.c b/tools/testing/selftests/openat2/upgrade_test.c
new file mode 100644
index 000000000000..489d9088d7ce
--- /dev/null
+++ b/tools/testing/selftests/openat2/upgrade_test.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define __SANE_USERSPACE_TYPES__
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "helpers.h"
+
+static int open_opath(const char *path, __u64 allowed_upgrades)
+{
+	struct open_how how = {
+		.flags = O_PATH,
+		.allowed_upgrades = allowed_upgrades,
+	};
+	int ret = raw_openat2(AT_FDCWD, path, &how, OPEN_HOW_SIZE_VER1);
+
+	if (ret < 0)
+		ksft_exit_fail_msg("open O_PATH: %s\n", strerror(errno));
+
+	return ret;
+}
+
+static int reopen_empty(int dfd, __u64 flags, bool fatal)
+{
+	struct open_how how = {
+		.flags = flags | OPENAT2_EMPTY_PATH,
+	};
+	int ret = raw_openat2(dfd, "", &how, OPEN_HOW_SIZE_VER1);
+
+	if (ret < 0 && fatal)
+		ksft_exit_fail_msg("open with OPENAT2_EMPTY_PATH: %s\n",
+				   strerror(errno));
+	return ret;
+}
+
+static int reopen_empty_opath(int dfd, __u64 allowed_upgrades)
+{
+	struct open_how how = {
+		.flags = O_PATH | OPENAT2_EMPTY_PATH,
+		.allowed_upgrades = allowed_upgrades,
+	};
+	int ret = raw_openat2(dfd, "", &how, OPEN_HOW_SIZE_VER1);
+
+	if (ret < 0)
+		ksft_exit_fail_msg("open O_PATH with OPENAT2_EMPTY_PATH: %s\n",
+				   strerror(errno));
+	return ret;
+}
+
+static int reopen_proc(int dfd, int flags, bool fatal)
+{
+	char path[64];
+	snprintf(path, sizeof(path), "/proc/self/fd/%d", dfd);
+	int ret = open(path, flags);
+
+	if (ret < 0 && fatal)
+		ksft_exit_fail_msg("open via procfs: %s\n", strerror(errno));
+
+	return ret;
+}
+
+static void check_success(const char *desc, int ret)
+{
+	if (ret >= 0) {
+		ksft_test_result_pass("%s\n", desc);
+		close(ret);
+	} else {
+		ksft_test_result_fail("%s: expected success, got %s\n",
+				      desc, strerror(errno));
+	}
+}
+
+static void check_failure(const char *desc, int ret, int expected_errno)
+{
+	if (ret < 0 && errno == expected_errno) {
+		ksft_test_result_pass("%s\n", desc);
+	} else if (ret >= 0) {
+		ksft_test_result_fail("%s: expected %s, got success\n",
+				      desc, strerror(expected_errno));
+		close(ret);
+	} else {
+		ksft_test_result_fail("%s: expected %s, got %s\n",
+				      desc, strerror(expected_errno),
+				      strerror(errno));
+	}
+}
+
+static void check(const char *desc, int ret, int expected_errno)
+{
+	if (!expected_errno) {
+		check_success(desc, ret);
+	} else {
+		check_failure(desc, ret, expected_errno);
+	}
+}
+
+#define NUM_TESTS 42
+
+int main(void)
+{
+	const char *path = "/tmp/upgrade_mask_test";
+	int fd, src;
+
+	ksft_print_header();
+
+	if (!openat2_supported)
+		ksft_exit_skip("openat2(2) not supported\n");
+
+	/* Check allowed_upgrades support */
+	{
+		struct open_how how = { .flags = O_PATH,
+					.allowed_upgrades = DENY_UPGRADES };
+		fd = raw_openat2(AT_FDCWD, "/", &how, sizeof(how));
+		if (fd < 0 && -fd == EINVAL)
+			ksft_exit_skip("allowed_upgrades not supported by kernel\n");
+		if (fd >= 0)
+			close(fd);
+	}
+
+	ksft_set_plan(NUM_TESTS);
+
+	fd = open(path, O_CREAT | O_WRONLY, 0644);
+	if (fd < 0)
+		ksft_exit_fail_msg("failed to create test file: %s\n",
+				   strerror(errno));
+	close(fd);
+
+	/* test 1: DENY_UPGRADES (deny all) */
+	src = open_opath(path, DENY_UPGRADES);
+	check("deny_all: use empty_path to reopen O_RDONLY", reopen_empty(src, O_RDONLY, false), EACCES);
+	check("deny_all: use empty_path to reopen O_WRONLY", reopen_empty(src, O_WRONLY, false), EACCES);
+	check("deny_all: use empty_path to reopen O_RDWR",   reopen_empty(src, O_RDWR,   false), EACCES);
+	check("deny_all: use procfs to reopen O_RDONLY",     reopen_proc(src, O_RDONLY,  false), EACCES);
+	check("deny_all: use procfs to reopen O_WRONLY",     reopen_proc(src, O_WRONLY,  false), EACCES);
+	check("deny_all: use procfs to reopen O_RDWR",       reopen_proc(src, O_RDWR,    false), EACCES);
+	close(src);
+
+	/* test 2: READ_UPGRADABLE */
+	src = open_opath(path, READ_UPGRADABLE);
+	check("read_only: use empty_path to reopen O_RDONLY", reopen_empty(src, O_RDONLY, false), 0);
+	check("read_only: use empty_path to reopen O_WRONLY", reopen_empty(src, O_WRONLY, false), EACCES);
+	check("read_only: use empty_path to reopen O_RDWR",   reopen_empty(src, O_RDWR,   false), EACCES);
+	check("read_only: use procfs to reopen O_RDONLY",     reopen_proc(src, O_RDONLY,  false), 0);
+	check("read_only: use procfs to reopen O_WRONLY",     reopen_proc(src, O_WRONLY,  false), EACCES);
+	check("read_only: use procfs to reopen O_RDWR",       reopen_proc(src, O_RDWR,    false), EACCES);
+	close(src);
+
+	/* test 3: WRITE_UPGRADABLE */
+	src = open_opath(path, WRITE_UPGRADABLE);
+	check("write_only: use empty_path to reopen O_RDONLY", reopen_empty(src, O_RDONLY, false), EACCES);
+	check("write_only: use empty_path to reopen O_WRONLY", reopen_empty(src, O_WRONLY, false), 0);
+	check("write_only: use empty_path to reopen O_RDWR",   reopen_empty(src, O_RDWR,   false), EACCES);
+	check("write_only: use procfs to reopen O_RDONLY",     reopen_proc(src, O_RDONLY,  false), EACCES);
+	check("write_only: use procfs to reopen O_WRONLY",     reopen_proc(src, O_WRONLY,  false), 0);
+	check("write_only: use procfs to reopen O_RDWR",       reopen_proc(src, O_RDWR,    false), EACCES);
+	close(src);
+
+	/* test 4: READ_UPGRADABLE | WRITE_UPGRADABLE */
+	src = open_opath(path, READ_UPGRADABLE | WRITE_UPGRADABLE);
+	check("allow_all: use empty_path to reopen O_RDONLY", reopen_empty(src, O_RDONLY, false), 0);
+	check("allow_all: use empty_path to reopen O_WRONLY", reopen_empty(src, O_WRONLY, false), 0);
+	check("allow_all: use empty_path to reopen O_RDWR",   reopen_empty(src, O_RDWR,   false), 0);
+	check("allow_all: use procfs to reopen O_RDONLY",     reopen_proc(src, O_RDONLY,  false), 0);
+	check("allow_all: use procfs to reopen O_WRONLY",     reopen_proc(src, O_WRONLY,  false), 0);
+	check("allow_all: use procfs to reopen O_RDWR",       reopen_proc(src, O_RDWR,    false), 0);
+	close(src);
+
+	/* test 5: VER0 open_how (allowed_upgrades absent, defaults to unrestricted) */
+	{
+		struct open_how how = { .flags = O_PATH };
+		src = raw_openat2(AT_FDCWD, path, &how, OPEN_HOW_SIZE_VER0);
+
+		check("ver0: use empty_path to reopen O_RDONLY", reopen_empty(src, O_RDONLY, false), 0);
+		check("ver0: use empty_path to reopen O_WRONLY", reopen_empty(src, O_WRONLY, false), 0);
+		check("ver0: use empty_path to reopen O_RDWR",   reopen_empty(src, O_RDWR,   false), 0);
+		check("ver0: use procfs to reopen O_RDONLY",     reopen_proc(src, O_RDONLY,  false), 0);
+		check("ver0: use procfs to reopen O_WRONLY",     reopen_proc(src, O_WRONLY,  false), 0);
+		check("ver0: use procfs to reopen O_RDWR",       reopen_proc(src, O_RDWR,    false), 0);
+		close(src);
+	}
+
+	/* test 6: invalid allowed_upgrades bit rejected */
+	{
+		struct open_how how = { .flags = O_PATH, .allowed_upgrades = (1ULL << 63) };
+		fd = raw_openat2(AT_FDCWD, path, &how, sizeof(how));
+		check("invalid: unknown bit in allowed_upgrades rejected with EINVAL", fd, EINVAL);
+	}
+
+	/* test 7: transitivity through OPENAT2_EMPTY_PATH reopen */
+	src = open_opath(path, READ_UPGRADABLE);
+	{
+		int mid = reopen_empty(src, O_RDONLY, true);
+		close(src);
+		check("transitive_empty: use procfs to reopen O_RDONLY", reopen_proc(mid, O_RDONLY, false), 0);
+		check("transitive_empty: use procfs to reopen O_WRONLY", reopen_proc(mid, O_WRONLY, false), EACCES);
+		check("transitive_empty: use procfs to reopen O_RDWR",   reopen_proc(mid, O_RDWR,   false), EACCES);
+		close(mid);
+	}
+
+	/* test 8: transitivity through procfs reopen */
+	src = open_opath(path, READ_UPGRADABLE);
+	{
+		int mid = reopen_proc(src, O_RDONLY, true);
+		close(src);
+		check("transitive_proc: use procfs to reopen O_RDONLY", reopen_empty(mid, O_RDONLY, false), 0);
+		check("transitive_proc: use procfs to reopen O_WRONLY", reopen_empty(mid, O_WRONLY, false), EACCES);
+		check("transitive_proc: use procfs to reopen O_RDWR",   reopen_empty(mid, O_RDWR,   false), EACCES);
+		close(mid);
+	}
+
+	/* test 9: narrowing via intermediate O_PATH reopen */
+	src = open_opath(path, READ_UPGRADABLE | WRITE_UPGRADABLE);
+	{
+		int mid = reopen_empty_opath(src, READ_UPGRADABLE);
+		close(src);
+		check("narrowing: use procfs to reopen O_RDONLY", reopen_proc(mid, O_RDONLY, false), 0);
+		check("narrowing: use procfs to reopen O_WRONLY", reopen_proc(mid, O_WRONLY, false), EACCES);
+		check("narrowing: use procfs to reopen O_RDWR",   reopen_proc(mid, O_RDWR,   false), EACCES);
+		close(mid);
+	}
+
+	/* test 10: three-level chain */
+	src = open_opath(path, READ_UPGRADABLE);
+	{
+		int mid = reopen_proc(src, O_RDONLY, true);
+		close(src);
+		int dst = reopen_proc(mid, O_RDONLY, true);
+		close(mid);
+		check("three_level: use procfs to reopen O_RDONLY", reopen_empty(dst, O_RDONLY, false), 0);
+		check("three_level: use procfs to reopen O_WRONLY", reopen_empty(dst, O_WRONLY, false), EACCES);
+		close(dst);
+	}
+
+	unlink(path);
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
-- 
2.53.0

