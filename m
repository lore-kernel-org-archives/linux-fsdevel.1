Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608293;
	b=JBSrUAvO9y0BruLWmV2qqm6cqAWqGjBeUTO+xeQCe8+Azt60Veg89teCiGLWf8YX3BOt
	 8Y2/S7dGKICIDz4UPTPn/R22GNhUgBY6zSAEWjXAfVd8O82dnKyYzd+EgwnP12JFScBFn
	 mBlekhRpM6iiVlOugqH/UEN3JQpiPcDPhihbCGlIv+zhcX5bwGsqXLGBWudayL/niRuz7
	 qaYk0Ox032X7mq2vb2bTGF/j4+iZS3qe6EJxoijFN8cT2L11wpZJs/LvLeUY3Em0b912N
	 QBjCVMN/ItBVwirMJVXg/Iy8Ne921HgAyWOHCKHu6n3s9wb3nA6C6c+pqmHNEIy3g4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608293;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EM9v7lx+Ly0ln/7bCidqbWhjZnISr5hSFtK9NQhxA0o=;
	b=R+Zk7upHK3znnI1vgiCSdZVrdzbiDAM69aLqRF/nYn0WHIbJ5pc0YJIL7Z3obJNw+QFn
	 54q0w4aiDhdgRIau+E8GGVhD/uJWtu3G/1/R3OAQOwHY3TTk44mGSiHV26muS2X0A4aKr
	 UKlPTagLJh+Qoul+YT93tczltC/wNwO9EQWb4cOF3oaxGWs6kLOLAZB9xJKB8biY0Qa3H
	 rxYQvUYsWJ6pLUOUcRquRoVVm3GyruwNrfzJ2i2kKCh2jLKwjYyPgxf/XLMw2STll8UUH
	 4qFGmXYpqbTBrPFyNR6op1+4kxAZyqhwhzy8s7n1KOAXnX94K7Udr2290k78iPWSTSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsIpo6cM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3645606A337
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsIpo6cM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600C51F000EE;
	Wed, 25 Nov 2026 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608293;
	bh=EM9v7lx+Ly0ln/7bCidqbWhjZnISr5hSFtK9NQhxA0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KsIpo6cMlGRiGJerDd1u3CfK5Zh2MR0gwVPAI5fMcrYXTkT9U4kd2yUJuw70tqIpL
	 CZwBzPp3x6fuTG3thEsXQEFlLzxuhzb7jNZJGD9t98Dh3o4LF6N6Ql49lqbRBQUlhI
	 E0o9J1c7E8Bnlf4W6Ve2WcWkxNvuFfC33kDniylpVaPLdotT37H6UbNHX6QYkbhHGO
	 7mFyYxtlZk3IgMmDJ3kc5la4VL8JyMmWtUKaf2kfIgGnUlSi1GfPQonxaOSQ3/2o4M
	 5h8uqOZLt23gKfYXDlZ5iP9uOhg94vEBGh5ORkEQG5YNvYmdaV0DkSwhtNKQoTRiuM
	 XffwJg2QD9wZg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 25 Nov 2026 13:04:28 +0100
Subject: [PATCH 2/2] selftests/filesystems: test multigrain timestamps of
 tmpfs directories
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-work-libfs-mgtime-v1-2-8022a81d0b9e@kernel.org>
References: <20261125-work-libfs-mgtime-v1-0-8022a81d0b9e@kernel.org>
In-Reply-To: <20261125-work-libfs-mgtime-v1-0-8022a81d0b9e@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=8363; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oWzQq168cMvkxrBQInUReMgd6PIkNsXH84TA6eRFVgs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSznbuzO/ihWfSZnb92Hb+lIjvt/P1Hzz/F/YgWvacbW
 T1fUa/nbkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBENA4z/K877cS0nittulrD
 lbCQ39cn+X9/v+V5z/5HCd8NmNxkPa8zMlzYWPbmL3OeiENYc6S/SS87O1txUpuMF/ukJr3Lfg3
 TWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Check that a tmpfs directory whose timestamps were queried shows a new
ctime and mtime after:

- creating a file or a directory
- link(), unlink() and rmdir()
- a rename, a rename over a file or an empty directory, and
  RENAME_EXCHANGE

Each case is tried a hundred times right after the directory changed so
that most tries land in the same coarse clock tick.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/.gitignore    |   1 +
 tools/testing/selftests/filesystems/Makefile      |   1 +
 tools/testing/selftests/filesystems/mgtime_test.c | 244 ++++++++++++++++++++++
 3 files changed, 246 insertions(+)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index cf79000e4092a..091095198a855 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -4,6 +4,7 @@ devpts_pts
 fclog
 anon_inode_test
 kernfs_test
+mgtime_test
 idmapped_tmpfile
 ustat_test
 rw_hint_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index fbd5c27505ef5..1474b05874dc2 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -4,6 +4,7 @@ CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := devpts_pts anon_inode_test kernfs_test fclog ustat_test rw_hint_test
 TEST_GEN_PROGS += idmapped_tmpfile
 TEST_GEN_PROGS_EXTENDED := dnotify_test
+TEST_GEN_PROGS += mgtime_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/filesystems/mgtime_test.c b/tools/testing/selftests/filesystems/mgtime_test.c
new file mode 100644
index 0000000000000..21b5f41c3e99f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mgtime_test.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tmpfs uses multigrain timestamps: once the timestamps of a directory
+ * have been queried, the next change to the directory must show a new
+ * ctime and mtime, even within the same coarse clock tick.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <linux/magic.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+/*
+ * Each try changes the directory right before querying it, so nearly
+ * every try lands in the same coarse clock tick as that change. A single
+ * one that shows no new timestamp fails the test, so a hundred tries
+ * leave no realistic chance for a broken kernel to pass.
+ */
+#define NR_TRIES 100
+
+enum dir_op {
+	OP_CREATE,
+	OP_MKDIR,
+	OP_LINK,
+	OP_UNLINK,
+	OP_RMDIR,
+	OP_RENAME,
+	OP_RENAME_OVER_FILE,
+	OP_RENAME_OVER_DIR,
+	OP_RENAME_EXCHANGE,
+};
+
+FIXTURE(mgtime) {
+	int root;
+};
+
+FIXTURE_VARIANT(mgtime) {
+	enum dir_op op;
+	/* Take the renamed entry from another directory. */
+	bool other_dir;
+};
+
+FIXTURE_VARIANT_ADD(mgtime, create) {
+	.op = OP_CREATE,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, mkdir) {
+	.op = OP_MKDIR,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, link) {
+	.op = OP_LINK,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, unlink) {
+	.op = OP_UNLINK,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, rmdir) {
+	.op = OP_RMDIR,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, rename_other_dir) {
+	.op = OP_RENAME,
+	.other_dir = true,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, rename_over_file) {
+	.op = OP_RENAME_OVER_FILE,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, rename_over_file_other_dir) {
+	.op = OP_RENAME_OVER_FILE,
+	.other_dir = true,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, rename_over_dir_other_dir) {
+	.op = OP_RENAME_OVER_DIR,
+	.other_dir = true,
+};
+
+FIXTURE_VARIANT_ADD(mgtime, rename_exchange_other_dir) {
+	.op = OP_RENAME_EXCHANGE,
+	.other_dir = true,
+};
+
+FIXTURE_SETUP(mgtime)
+{
+	struct statfs sfs;
+	int fsfd;
+
+	fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+	if (fsfd < 0 && errno == EPERM)
+		SKIP(return, "mounting tmpfs requires CAP_SYS_ADMIN");
+	ASSERT_GE(fsfd, 0);
+	ASSERT_EQ(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	self->root = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(self->root, 0);
+	ASSERT_EQ(close(fsfd), 0);
+
+	/* Without CONFIG_SHMEM tmpfs is ramfs, which has no multigrain timestamps. */
+	ASSERT_EQ(fstatfs(self->root, &sfs), 0);
+	if (sfs.f_type != TMPFS_MAGIC)
+		SKIP(return, "tmpfs is ramfs without CONFIG_SHMEM");
+}
+
+FIXTURE_TEARDOWN(mgtime)
+{
+	close(self->root);
+}
+
+/* Create a file without taking its status. */
+static int create_file(int dfd, const char *name)
+{
+	int fd;
+
+	fd = openat(dfd, name, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC, 0644);
+	if (fd < 0)
+		return -1;
+	return close(fd);
+}
+
+static int remove_all(int root)
+{
+	static const char *const files[] = {
+		"dir/victim", "dir/new", "dir/link", "src/new",
+	};
+	static const char *const dirs[] = {
+		"dir/victim", "dir/new", "src/new", "dir", "src",
+	};
+
+	for (size_t i = 0; i < sizeof(files) / sizeof(files[0]); i++)
+		if (unlinkat(root, files[i], 0) && errno != ENOENT &&
+		    errno != EISDIR)
+			return -1;
+	for (size_t i = 0; i < sizeof(dirs) / sizeof(dirs[0]); i++)
+		if (unlinkat(root, dirs[i], AT_REMOVEDIR) && errno != ENOENT &&
+		    errno != ENOTDIR)
+			return -1;
+	return 0;
+}
+
+/* Build what the operation needs, changing "dir" last. */
+static int prepare(int root, enum dir_op op, bool other_dir)
+{
+	const char *from = other_dir ? "src/new" : "dir/new";
+
+	if (mkdirat(root, "src", 0755) || mkdirat(root, "dir", 0755))
+		return -1;
+
+	switch (op) {
+	case OP_CREATE:
+	case OP_MKDIR:
+	case OP_LINK:
+	case OP_UNLINK:
+		return create_file(root, "dir/victim");
+	case OP_RMDIR:
+		return mkdirat(root, "dir/victim", 0755);
+	case OP_RENAME:
+	case OP_RENAME_OVER_FILE:
+	case OP_RENAME_EXCHANGE:
+		if (create_file(root, from))
+			return -1;
+		return create_file(root, "dir/victim");
+	case OP_RENAME_OVER_DIR:
+		if (mkdirat(root, from, 0755))
+			return -1;
+		return mkdirat(root, "dir/victim", 0755);
+	}
+	return -1;
+}
+
+static int change(int root, enum dir_op op, bool other_dir)
+{
+	const char *from = other_dir ? "src/new" : "dir/new";
+
+	switch (op) {
+	case OP_CREATE:
+		return create_file(root, "dir/new");
+	case OP_MKDIR:
+		return mkdirat(root, "dir/new", 0755);
+	case OP_LINK:
+		return linkat(root, "dir/victim", root, "dir/link", 0);
+	case OP_UNLINK:
+		return unlinkat(root, "dir/victim", 0);
+	case OP_RMDIR:
+		return unlinkat(root, "dir/victim", AT_REMOVEDIR);
+	case OP_RENAME:
+		return renameat(root, from, root, "dir/new");
+	case OP_RENAME_OVER_FILE:
+	case OP_RENAME_OVER_DIR:
+		return renameat(root, from, root, "dir/victim");
+	case OP_RENAME_EXCHANGE:
+		return renameat2(root, from, root, "dir/victim", RENAME_EXCHANGE);
+	}
+	return -1;
+}
+
+static bool same_time(const struct statx_timestamp *a,
+		      const struct statx_timestamp *b)
+{
+	return a->tv_sec == b->tv_sec && a->tv_nsec == b->tv_nsec;
+}
+
+TEST_F(mgtime, parent_times_change)
+{
+	for (int i = 0; i < NR_TRIES; i++) {
+		struct statx before, after;
+		int dfd;
+
+		ASSERT_EQ(prepare(self->root, variant->op, variant->other_dir), 0);
+		dfd = openat(self->root, "dir", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		ASSERT_GE(dfd, 0);
+
+		/* Querying the timestamps asks for a visible next change. */
+		ASSERT_EQ(statx(dfd, "", AT_EMPTY_PATH,
+				STATX_CTIME | STATX_MTIME, &before), 0);
+		ASSERT_EQ(change(self->root, variant->op, variant->other_dir), 0);
+		ASSERT_EQ(statx(dfd, "", AT_EMPTY_PATH,
+				STATX_CTIME | STATX_MTIME, &after), 0);
+
+		ASSERT_FALSE(same_time(&before.stx_ctime, &after.stx_ctime))
+			TH_LOG("try %d: ctime stayed at %lld.%09u", i,
+			       (long long)before.stx_ctime.tv_sec,
+			       before.stx_ctime.tv_nsec);
+		ASSERT_FALSE(same_time(&before.stx_mtime, &after.stx_mtime))
+			TH_LOG("try %d: mtime stayed at %lld.%09u", i,
+			       (long long)before.stx_mtime.tv_sec,
+			       before.stx_mtime.tv_nsec);
+
+		ASSERT_EQ(close(dfd), 0);
+		ASSERT_EQ(remove_all(self->root), 0);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

