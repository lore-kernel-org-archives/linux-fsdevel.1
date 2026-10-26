Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043611;
	b=qzKoEqzuz9CIXmtBuFAA9USz1PlxIEuulzBEeBcgkkyxMFLGxRTcIwFB/2Xsat0RGe6n
	 Ee1XIyKEaa9dTU0iqkJVYrkIeF8mHHZgeSR/uOv06+0WbGyBNOanYryDexzasEMIx7eDp
	 /0Hu2o1/oOD5T3warOcHRaixncQpuxMdnKkp9b++KDKpZSPoTSM4RZQUNEygv0a3Y3GRs
	 E3lqBnvEcPVC7IMe7ZJiS7tMVAZTJzVagwF0+M0HlzjArm2pKEcLdzQSt46CyecDDB6wl
	 j9wUI7RjmSHOwbl3+kIKalH2NCbP5YM2I41vsYLW6W3IYc1YnJ0ku96wp2wXUQtJt9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ffTkvk1rfJfkBRMi2MyNyvy85ELVUN80pjUBdv6nFjQ=;
	b=q0Q8ON1tH5WDuP6ztHIg8wMCgb3O37oPsyTIGc4o3di5n3bH9KSfoFTdPQ2SwgCVP6E3
	 WDvRAqxoTK55kPvyy5poraXx4PLoZIMp5JSSKDAAHKNlQREYsky0aOVBFArs/7WSnYJRh
	 0nMV4bJmCIwU/nb6jpogiBE0fs5PuDSAyGe7vdNu8oP84XsR15AzV6A5p3x0Z4OxbI0NQ
	 UgPpWwL0pxthB5wLQbl708JdJ7h48TR6Qi76D37GngTZDC2/B8ksiug/6r1PXcJK+zCRZ
	 46ZJz7RqHsY7zHiLvadBqhDed3MC82bjqV+7F4vs32hGuNmOpdyVi4I8SHBPtTbaOsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgaP1jU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B7606A31A;
	Mon, 26 Oct 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgaP1jU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A871F01825;
	Mon, 26 Oct 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793043611;
	bh=ffTkvk1rfJfkBRMi2MyNyvy85ELVUN80pjUBdv6nFjQ=;
	h=From:To:Cc:Subject:Date;
	b=XgaP1jU+fEN5sj227lCA0SM9/qpJGUvQKwKiGM3vBlDlz+4CpL3cY1yrj077URtNj
	 KXhYyjqSQJychUZoMfLqhca1sze7H8ryzKN8mWOFQbdTCRzEUcUG2tAuSGiRioWmPl
	 UNwjjnjMLuhh6+JI/9zY4kbkIzrLIioAihjS4SOPMNnLquYfPMZ6tMNbo7D+w/Qdpc
	 Y7uUUz+SDsKcRxTluzAlwFW/Fy3NEui+vf+4qXwgscaf4ef0Jl8ZhMhwFPKPUAfafQ
	 0Qv8+TsieREg7fX41hB1unf2am5U5TnkepZG3fLzGXWW9zyduaCv/fdtTcsmJHibQ5
	 T6el0LjF7+ixw==
From: Sasha Levin <sashal@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests/fuse: add the missing symlink caching test
Date: Mon, 26 Oct 2026 15:40:08 -0400
Message-ID: <20261026194008.274349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e14f079d7a0 ("selftests/fuse: add fuse symlink caching test")
registered fuse_symlink_cache_test in the fuse selftest Makefile and
.gitignore, but the test source was not part of the applied commit, so
building the fuse selftests fails:

  make[1]: *** No rule to make target 'fuse_symlink_cache_test.c', needed by '.../fuse_symlink_cache_test'.

Add fuse_symlink_cache_test.c as posted in Luis Henriques's v5
submission. The test serves a file and a symlink to it from a libfuse
low-level filesystem, resolves the symlink 100 times, and counts the
readlink requests that reach the server: one when FUSE_CAP_CACHE_SYMLINKS
is set during FUSE_INIT, and all 100 when it is not.

Fixes: 3e14f079d7a0 ("selftests/fuse: add fuse symlink caching test")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202610170822.oEJ1Autq-lkp@intel.com/
Link: https://lore.kernel.org/r/20261001164916.15311-8-luis@igalia.com
Originally-by: Luis Henriques <luis@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
As with e64a46aefc01 ("selftests/fuse: add the missing FUSE_HAS_SYNCFS
privilege test"), the new file in the posted patch is not in the applied
commit; the other files did land.

 .../fuse/fuse_symlink_cache_test.c            | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_test.c

diff --git a/tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_test.c b/tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_test.c
new file mode 100644
index 0000000000000..7b53734995736
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_test.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple filesystem to test FUSE symlink cache
+ *
+ * This is a simple FUSE filesystem that contains two objects: a file named
+ * 'file' and a symlink to that file named 'link'.  If symlink caching is
+ * disabled (i.e. FUSE_CAP_CACHE_SYMLINKS is reset during FUSE_INIT), whenever
+ * the ->readlink() is executed to resolve 'link' a counter will be incremented.
+ *
+ * If symlink caching is enabled (i.e. FUSE_CAP_CACHE_SYMLINKS is set during
+ * FUSE_INIT), resolving a symlink will only call into user-space the first
+ * time.
+ */
+
+#define FUSE_USE_VERSION 31
+
+#include <stdio.h>
+#include <fuse_lowlevel.h>
+
+#include "kselftest_harness.h"
+
+#include "fuse_common.h"
+
+#define FILENAME "file"
+#define FILE_INO 42
+
+#define LINKNAME "link"
+#define LINK_INO 43
+
+#define TIMEOUT	86400.0f
+
+struct test_state {
+	pthread_mutex_t lock;
+	int readlink_counter;
+	bool cache;
+} test_state = {
+	.lock = PTHREAD_MUTEX_INITIALIZER,
+};
+
+static void fs_init(void *userdata, struct fuse_conn_info *conn)
+{
+	pthread_mutex_lock(&test_state.lock);
+	if (test_state.cache)
+		fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
+	else
+		fuse_unset_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
+	pthread_mutex_unlock(&test_state.lock);
+}
+
+static void fs_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
+{
+	struct fuse_entry_param e = {};
+
+	if (parent != FUSE_ROOT_ID ||
+	    (strcmp(name, FILENAME) != 0 && strcmp(name, LINKNAME) != 0)) {
+		fuse_reply_err(req, ENOENT);
+		return;
+	}
+
+	if (!strcmp(name, FILENAME)) {
+		e.ino = FILE_INO;
+		e.attr.st_mode = S_IFREG | 0444;
+		e.attr.st_nlink = 2;
+	} else if (!strcmp(name, LINKNAME)) {
+		e.ino = LINK_INO;
+		e.attr.st_mode = S_IFLNK | 0444;
+		e.attr.st_nlink = 1;
+		e.attr.st_size = strlen(FILENAME);
+	}
+	e.attr_timeout = TIMEOUT;
+	e.entry_timeout = TIMEOUT;
+
+	fuse_reply_entry(req, &e);
+}
+
+static void fs_readlink(fuse_req_t req, fuse_ino_t ino)
+{
+	char buf[PATH_MAX];
+	size_t sz = strlen(FILENAME);
+
+	if (ino != LINK_INO) {
+		fuse_reply_err(req, ENOENT);
+		return;
+	}
+
+	memcpy(buf, FILENAME, sz);
+	buf[sz] = '\0';
+	pthread_mutex_lock(&test_state.lock);
+	test_state.readlink_counter++;
+	pthread_mutex_unlock(&test_state.lock);
+
+	fuse_reply_readlink(req, buf);
+}
+
+static const struct fuse_lowlevel_ops fs_ops = {
+	.init           = fs_init,
+	.lookup		= fs_lookup,
+	.readlink	= fs_readlink,
+};
+
+FIXTURE(symlink_cache)
+{
+	struct fuse_common_ctx ctx;
+};
+FIXTURE_VARIANT(symlink_cache)
+{
+	const bool cache;
+};
+FIXTURE_VARIANT_ADD(symlink_cache, symlinks_nocache)
+{
+	/* Variant with symlink cache disabled */
+	.cache = false,
+};
+FIXTURE_VARIANT_ADD(symlink_cache, symlinks_cache)
+{
+	/* Variant with symlink cache enabled */
+	.cache = true,
+};
+
+FIXTURE_SETUP(symlink_cache)
+{
+	char err[MAX_ERR_MSG];
+
+	pthread_mutex_lock(&test_state.lock);
+	test_state.readlink_counter = 0;
+	test_state.cache = variant->cache;
+	pthread_mutex_unlock(&test_state.lock);
+
+	if (fs_setup(&fs_ops, &self->ctx, err))
+		SKIP(return, err);
+}
+
+FIXTURE_TEARDOWN(symlink_cache)
+{
+	fs_teardown(&self->ctx);
+}
+
+TEST_F(symlink_cache, test_symlink_cache)
+{
+	char pathname[PATH_MAX];
+	char buf[PATH_MAX];
+	ssize_t sz;
+	int counter;
+	int i;
+
+	sprintf(pathname, "%s/%s", self->ctx.mountpoint, LINKNAME);
+	for (i = 0; i < 100; i++) {
+		sz = readlink(pathname, buf, PATH_MAX);
+		ASSERT_NE(sz, -1);
+	}
+	pthread_mutex_lock(&test_state.lock);
+	counter = test_state.readlink_counter;
+	pthread_mutex_unlock(&test_state.lock);
+
+	if (variant->cache) {
+		ASSERT_EQ(counter, 1);
+	} else {
+		ASSERT_EQ(counter, 100);
+	}
+}
+
+TEST_HARNESS_MAIN

base-commit: 9b1da7b4a4e197072e630c3b85d4100a399752ff
-- 
2.53.0

