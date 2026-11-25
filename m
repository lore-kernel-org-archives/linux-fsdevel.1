Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602437;
	b=g8CjsUhmd6eApwTpYYHozNo/iEN8xlFdUsctg4NQT3YXI/EG8o9LJasqYReT85T26VbO
	 QkwPn2SAtoSxppYG1mvu/QnwJOeQOGR3yscF5ZZ+Jn4zoYy5VaVLUjZdYFo5kNgIpy0Vd
	 yuwoS4ETfx6qeF1Qof4OoXkMRRtQ73HIEXeFER97jXS0euOYw5bo812+kxyN95zGNyqxQ
	 L3+B/UFlCSoK8KxSP+EjBVpXoJTZF8AO5HmztYVqZ3mlJnVzSTXY6IVO7BRgIgcsV9I0Q
	 ODJJZXKmrS8aBaD7ZGNO44o5IXcnRZHDe6+CSsKj3VS9UMjXijuc7J7fzcHnZPSsHdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602437;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yi2Mh4qGgUrfb1KNHncXhc4DVcRKA8dM9OvfbYYznGc=;
	b=L0lyzYBidgW1PRGKBhw66lx/MlQha1rmknqWLAePk86MNZdgBg2ixYDq61HHIBZswxCo
	 QupDwhhhTR3PrpGiiYY+CvQxBlx/UHpNhr+is6ea2IX+Z46CbkzKN+ODas/2nIqiBTAQ6
	 NYYeBGfXOK1eUs+GyEM4F011Fcm8kS4/7s8N/1RCkFHJtw/vncsQmepz1SSnu2aOfjF/5
	 iZfv63HQUyntAAYjgdRZyh+TVRX/x0v2enMxaocOwTlmIrj6lVRq3JZWEz2GKkz5mzYUt
	 2KYpqFYRdy0s76IdrRs3NLo8oX/4nnNxkYuyQGH/fWLIo3ZGuLyETVZzWLimepQ1ARA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCk2ER6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44008606A327;
	Wed, 25 Nov 2026 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCk2ER6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451931F000D1;
	Wed, 25 Nov 2026 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602436;
	bh=yi2Mh4qGgUrfb1KNHncXhc4DVcRKA8dM9OvfbYYznGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OCk2ER6XkLCkk17mMi826mBuFWsg+R0/BS806VKZ/rO3JTixwz4i1ShAlzFjZlSGt
	 44MubuP3ul6Ajw58CdprxJgRTn2/XZGeKOtgYdb/wTQLbRoZ3FRVrRXr5ZKjRpAdU7
	 SaqIXko4E7uhF0J9b4rW1H19Ix8n2pJ1e4jMNPD+uDjOV44fccPkO3FAgKJZeQxMTL
	 xDM2nklkrtAx2xlvWNiVaWwaE9Rekbj3Z4xAh7xj0JMAgNQK1Q8sLwJJtc11v5xhEb
	 yENP1LX6O55QW6qzjMJpysBsrgq4OoBC6HeUqKM964emewSZAO+CU4m/YAv3eWh2Xs
	 EH83MHkGMq3Vw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 25 Nov 2026 11:26:53 +0100
Subject: [PATCH 2/2] selftests/fuse: test listing directories with long
 names
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
Message-Id: <20261125-work-fuse-readdir-v1-2-44312add01a8@kernel.org>
References: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
In-Reply-To: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=6938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BmZOeRitj/oGPNxu99qaWuSWBqTXPMTrLoGM4ID88hI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzbf8dxyLbeDs3jfH536xV28pjSl5au87VZC85KF626
 2KHzeTajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMtGFkOPo10a7EdV2ildqv
 8J0TPpgF/vjYUTPzx8WmWRu+CT08nMTwvyxKTGdGbjPb8bBHihfdLnOWnirwCA959MFp08vLS6/
 +4QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test that lists a directory whose first entry has a name too long
for a one page READDIR or READDIRPLUS reply:

- READDIR with the shortest such name and with FUSE_NAME_MAX

- READDIRPLUS with the shortest such name and with FUSE_NAME_MAX

It starts out with a 4k getdents64() buffer, doubles it on EINVAL and
checks that both the long name and the entry after it show up.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../testing/selftests/filesystems/fuse/.gitignore  |   1 +
 tools/testing/selftests/filesystems/fuse/Makefile  |   2 +
 .../filesystems/fuse/fuse_readdir_long_name_test.c | 197 +++++++++++++++++++++
 3 files changed, 200 insertions(+)

diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
index 7c787313e69b6..cd5492659ffcf 100644
--- a/tools/testing/selftests/filesystems/fuse/.gitignore
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -6,3 +6,4 @@ write_extend_eof_test
 fuse_acl_cache_test
 fuse_symlink_cache_test
 fuse_readdir_cache_test
+fuse_readdir_long_name_test
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
index e3ae3acff1139..2e77b19d6d06a 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -7,6 +7,7 @@ TEST_GEN_PROGS += write_extend_eof_test
 TEST_GEN_PROGS += fuse_acl_cache_test
 TEST_GEN_PROGS += fuse_symlink_cache_test
 TEST_GEN_PROGS += fuse_readdir_cache_test
+TEST_GEN_PROGS += fuse_readdir_long_name_test
 TEST_GEN_FILES := fuse_mnt
 
 include ../../lib.mk
@@ -32,5 +33,6 @@ $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 $(OUTPUT)/fuse_acl_cache_test: fuse_common.c fuse_acl_cache_test.c
 $(OUTPUT)/fuse_symlink_cache_test: fuse_common.c fuse_symlink_cache_test.c
 $(OUTPUT)/fuse_readdir_cache_test: fuse_common.c fuse_readdir_cache_test.c
+$(OUTPUT)/fuse_readdir_long_name_test: fuse_common.c fuse_readdir_long_name_test.c
 
 EXTRA_CLEAN := fuse_common.o
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_readdir_long_name_test.c b/tools/testing/selftests/filesystems/fuse/fuse_readdir_long_name_test.c
new file mode 100644
index 0000000000000..6fd280cb3188e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_readdir_long_name_test.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * List a FUSE directory whose first entry has a name that doesn't fit
+ * into a single page of READDIR or READDIRPLUS reply, using a small
+ * getdents64() buffer, and check that no entry goes missing.
+ */
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+
+#include "kselftest_harness.h"
+
+#include "fuse_common.h"
+
+#define LONG_INO	2
+#define AFTER_INO	3
+#define AFTER_NAME	"after"
+#define FUSE_NAME_MAX	(PATH_MAX - 1)
+#define GETDENTS_MAX	65536
+
+struct linux_dirent64 {
+	uint64_t	d_ino;
+	int64_t		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[];
+};
+
+static char long_name[FUSE_NAME_MAX + 1];
+
+static void fs_getattr(fuse_req_t req, fuse_ino_t ino,
+		       struct fuse_file_info *fi)
+{
+	struct stat st = {};
+
+	if (ino != FUSE_ROOT_ID) {
+		fuse_reply_err(req, ENOENT);
+		return;
+	}
+	st.st_ino = ino;
+	st.st_mode = S_IFDIR | 0755;
+	st.st_nlink = 2;
+	fuse_reply_attr(req, &st, 0);
+}
+
+/* Whole entries from @off, as many as fit into @size. */
+static void fill_dir(fuse_req_t req, size_t size, off_t off, bool plus)
+{
+	char *buf = malloc(size);
+	size_t used = 0;
+
+	if (!buf) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	for (; off < 2; off++) {
+		const char *name = off ? AFTER_NAME : long_name;
+		struct fuse_entry_param e = {};
+		size_t len;
+
+		e.ino = off ? AFTER_INO : LONG_INO;
+		e.attr.st_ino = e.ino;
+		e.attr.st_mode = S_IFREG | 0444;
+		e.attr.st_nlink = 1;
+		if (plus)
+			len = fuse_add_direntry_plus(req, buf + used, size - used,
+						     name, &e, off + 1);
+		else
+			len = fuse_add_direntry(req, buf + used, size - used,
+						name, &e.attr, off + 1);
+		if (len > size - used)
+			break;
+		used += len;
+	}
+
+	fuse_reply_buf(req, buf, used);
+	free(buf);
+}
+
+static void fs_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
+		       off_t off, struct fuse_file_info *fi)
+{
+	fill_dir(req, size, off, false);
+}
+
+static void fs_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
+			   off_t off, struct fuse_file_info *fi)
+{
+	fill_dir(req, size, off, true);
+}
+
+static const struct fuse_lowlevel_ops fs_ops = {
+	.getattr	= fs_getattr,
+	.readdir	= fs_readdir,
+};
+
+static const struct fuse_lowlevel_ops fs_ops_plus = {
+	.getattr	= fs_getattr,
+	.readdir	= fs_readdir,
+	.readdirplus	= fs_readdirplus,
+};
+
+FIXTURE(readdir_long_name)
+{
+	struct fuse_common_ctx ctx;
+};
+
+FIXTURE_VARIANT(readdir_long_name)
+{
+	bool plus;
+	size_t name_len;
+};
+
+/* The shortest names whose entries don't fit into a 4k page, and the longest. */
+FIXTURE_VARIANT_ADD(readdir_long_name, readdir_4073)
+{
+	.plus = false,
+	.name_len = 4073,
+};
+FIXTURE_VARIANT_ADD(readdir_long_name, readdir_name_max)
+{
+	.plus = false,
+	.name_len = FUSE_NAME_MAX,
+};
+FIXTURE_VARIANT_ADD(readdir_long_name, readdirplus_3945)
+{
+	.plus = true,
+	.name_len = 3945,
+};
+FIXTURE_VARIANT_ADD(readdir_long_name, readdirplus_name_max)
+{
+	.plus = true,
+	.name_len = FUSE_NAME_MAX,
+};
+
+FIXTURE_SETUP(readdir_long_name)
+{
+	char err[MAX_ERR_MSG];
+
+	memset(long_name, 'L', variant->name_len);
+	long_name[variant->name_len] = '\0';
+
+	if (fs_setup(variant->plus ? &fs_ops_plus : &fs_ops, &self->ctx, err))
+		SKIP(return, "%s", err);
+}
+
+FIXTURE_TEARDOWN(readdir_long_name)
+{
+	fs_teardown(&self->ctx);
+}
+
+TEST_F(readdir_long_name, small_buffer)
+{
+	bool seen_long = false, seen_after = false;
+	size_t size = 4096;
+	char *buf = NULL;
+	int fd;
+
+	fd = open(self->ctx.mountpoint, O_RDONLY | O_DIRECTORY);
+	ASSERT_GE(fd, 0);
+
+	for (;;) {
+		long n;
+
+		buf = realloc(buf, size);
+		ASSERT_NE(buf, NULL);
+		n = syscall(SYS_getdents64, fd, buf, size);
+		/* The next entry doesn't fit, try again with more room. */
+		if (n < 0 && errno == EINVAL && size < GETDENTS_MAX) {
+			size *= 2;
+			continue;
+		}
+		ASSERT_GE(n, 0);
+		if (!n)
+			break;
+
+		for (long off = 0; off < n;) {
+			struct linux_dirent64 *d = (void *)(buf + off);
+
+			if (!strcmp(d->d_name, long_name))
+				seen_long = true;
+			else if (!strcmp(d->d_name, AFTER_NAME))
+				seen_after = true;
+			off += d->d_reclen;
+		}
+	}
+
+	free(buf);
+	close(fd);
+	EXPECT_TRUE(seen_long);
+	EXPECT_TRUE(seen_after);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

