Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC18389114
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980579; cv=none; b=rTGIwy8Wnu/GSI4LHy4cUoGgCKJ4inszBfcf6lsC8hjhuruTGs7bpcFdiXYUrpD5ZJLDtpGz8cXgfAu79tf+VzKZFf09fL4PpCmhtmmrKXEfFDHxxnElnxI3nwjVvucBAykR4SNzTujt+IE2R9h9zcdZ+br2TX1NPVnS14npUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980579; c=relaxed/simple;
	bh=hEzuw4pLuzwvPzdnd7w/hOpL5ecfc1KyLK2mbok/gRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psIL1bwbZc4EuFBcs/BjzKkR46a9fOE6rj2McvT5//q/wiBaxasU3QFdCJzkDQmM7g60slDExEtNb/vxEt3PWZwmaO9ff1iVHg68Ph5JqYIBLsIh1NEdQHks1S6VyZScgRBJoFlWWp2fGGnTjKRV/Em5/JlCNhT4XxLIyiLN5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUX4BgZb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUX4BgZb"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so934749a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980576; x=1784585376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lVdoiojYprlk9y5RonKrFJ06gG6DVGc3jz/gFaRGsjU=;
        b=UUX4BgZbWj+M9S/ni21KnFHjI4Brof7pJn9vQQK8HQ7LbeMS+TPLF5I9BdovaBsIY/
         V+uj2X3crtshf1kKu4Osh2SQGC6bSIGS0v6ANXC5/7ZH3em9m3icwSxejzDNP8XDAiUf
         s2t99DhvYWfmCUA7snihQIB1MKVw1KPil32Thhljcf+h7fJcxGmYlegN/G7HRWzCZORy
         +CpFcZO3HJDPs75XL858EIiu7l0WpK75v1AAU9SJrsUBjlOWrjcNRSxyvs891xoOd/HI
         jkAnYdsQLs3b5E4KHMK4RHuudPspY6XuT+Zl5Er196pQalB9rzmst6OVamB2XtOKyJ0B
         CHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980576; x=1784585376;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVdoiojYprlk9y5RonKrFJ06gG6DVGc3jz/gFaRGsjU=;
        b=hnNEbuBvZpscGlOkOTX5OGPCBnjvVhDeq8eJ6pSLgFY0XCzI066DRoe0ljMAd1M8WT
         mzagM5Y2dzshz5Kfo4cBQlInruFg3iY9kgJpbF3wP51cYdgw7htz6dADUe27GKQ7Expz
         2CpfF0jqXyxpqvvMW00/hvmjzJKKoTZ9pTqycqU56HgSPnBZgWgtRpP9YdudtdawYMAX
         nCMHi0WKZyKcZdzfCED5uEY+BSuF+q8KRmqEqXY9nFppg6LGrS42TIu0VJeC4Snh7c57
         hu9LRS1Y7Fddw7nuiSXln9nUhxIchMaBVmWkwGJ3TwAjQILH+BfjTgxGVhuVlXsKh9j7
         +FiA==
X-Gm-Message-State: AOJu0YyYKCz8jtwTYempRNC4YZ6D4Re5clUxQEulQ4woTAPW+fDjHHbA
	aLRy3aQIimCEgOSINw8Ibqe4TmyjyJl766yX5N9GOeeMqlSjwxg4bXFj
X-Gm-Gg: AfdE7ckqMrCMTIFXWaDZNpcHl3jSyQfkuSnQnSVFNOQ4ROsAl2LYFuvPTs3jlv+e/lc
	/BOIaVTLijQKA9Qd9v7CYLWce+D8d4WJS+J5BEpDFryAdYcb6Pr5nBp8RL2rm8xE7mUc+ASCO9e
	SssaBSrT7oF2NIUx/UGo/y+FsNhUAm9BcapqAs/3p5rbCcxlR3tp54Yq+Tneosb8dDVU5jcpYjm
	An/RIcaATLarwdylEiFH4u6HoKq132lp9G+br6ubIRE82eq3nUh/8VWnQeHw7WHqMb16ewwM3pz
	KwdHB2cYH0UO7CWX4a/OU/6yzjTYyp201gTQE9ojD52mgH5llxLARZUWI1Rm+EbynRumasYpdRe
	gWUnKAdsnVYM4sMMrxzAu/JkfATlQLjAj5IMIdwWoqwe/QxC5/V33xQo4Z4nHhUFMv4odaMtOZh
	dPvpzH3n03nnTHl+r3WkTD3e8dX84i9KliD/T9jg==
X-Received: by 2002:a05:6402:21cd:b0:69c:3966:fdae with SMTP id 4fb4d7f45d1cf-69c3967005emr6742533a12.2.1783980575740;
        Mon, 13 Jul 2026 15:09:35 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd288c93fsm460342a12.8.2026.07.13.15.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:09:35 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH 2/2] selftests/fuse: add ACL_DONT_CACHE regression test
Date: Tue, 14 Jul 2026 00:09:32 +0200
Message-ID: <20260713220932.413004-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713220932.413004-1-amir73il@gmail.com>
References: <20260713220932.413004-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test that reproduces the stale ACL bug fixed by:
  "fs: preserve ACL_DONT_CACHE state in forget_cached_acl()"

A FUSE mount that does not negotiate FUSE_POSIX_ACL initialises inodes
with i_acl = ACL_DONT_CACHE.  Before the fix, calling
forget_all_cached_acls() (e.g. from fuse_update_get_attr() on a
statx(AT_STATX_FORCE_SYNC)) would silently replace ACL_DONT_CACHE with
ACL_NOT_CACHED, enabling the kernel ACL cache.  A subsequent getxattr
would populate the cache, and because fuse_set_acl() skips
forget_all_cached_acls() for !fc->posix_acl, later ACL changes were
not visible to callers — getxattr returned stale data.

The test mounts a minimal libfuse3 lowlevel filesystem (no
FUSE_POSIX_ACL negotiated) and:
  1. Issues two getxattrs — both must reach the daemon, proving
     ACL_DONT_CACHE suppresses caching before any trigger.
  2. Calls statx(AT_STATX_FORCE_SYNC) to trigger forget_all_cached_acls().
  3. Issues another getxattr (populates the cache on a buggy kernel).
  4. Switches the daemon to a different-sized ACL (ACL_B).
  5. Issues a final getxattr — expects ACL_B (44 bytes) and daemon
     call count 4; a buggy kernel returns stale ACL_A (28 bytes).

fuse_acl_cache_test is only built when libfuse3 is detected via
pkg-config.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../selftests/filesystems/fuse/Makefile       |  10 +
 .../filesystems/fuse/fuse_acl_cache_test.c    | 348 ++++++++++++++++++
 2 files changed, 358 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c

diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
index 612aad69a93aa..f471414842750 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -5,6 +5,13 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 TEST_GEN_PROGS := fusectl_test
 TEST_GEN_FILES := fuse_mnt
 
+# fuse_acl_cache_test requires libfuse3; add it only when the library is present.
+ACL_CFLAGS := $(shell pkg-config fuse3 --cflags 2>/dev/null)
+ACL_LDLIBS := $(shell pkg-config fuse3 --libs 2>/dev/null)
+ifneq ($(ACL_CFLAGS),)
+TEST_GEN_PROGS += fuse_acl_cache_test
+endif
+
 include ../../lib.mk
 
 VAR_CFLAGS := $(shell pkg-config fuse --cflags 2>/dev/null)
@@ -19,3 +26,6 @@ endif
 
 $(OUTPUT)/fuse_mnt: CFLAGS += $(VAR_CFLAGS)
 $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
+
+$(OUTPUT)/fuse_acl_cache_test: CFLAGS += $(ACL_CFLAGS)
+$(OUTPUT)/fuse_acl_cache_test: LDLIBS += $(ACL_LDLIBS)
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c b/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
new file mode 100644
index 0000000000000..b2e5db8555040
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test: FUSE ACL caching bug triggered by AT_STATX_FORCE_SYNC
+ *
+ * A FUSE mount that does not negotiate FUSE_POSIX_ACL initialises every inode
+ * with i_acl = i_default_acl = ACL_DONT_CACHE.  When a fresh stat is needed
+ * (e.g. AT_STATX_FORCE_SYNC), fuse_update_get_attr() calls
+ * forget_all_cached_acls() before issuing FUSE_GETATTR.  On an unfixed kernel,
+ * __forget_cached_acl() replaces ACL_DONT_CACHE with ACL_NOT_CACHED,
+ * inadvertently enabling the kernel ACL cache for that inode.  The next
+ * getxattr populates the cache.  Because fuse_set_acl() skips
+ * forget_all_cached_acls() for !fc->posix_acl mounts, any subsequent change to
+ * the ACL leaves the stale kernel entry in place, and the next getxattr returns
+ * wrong data without ever reaching the FUSE daemon.
+ *
+ * Fix (fs/posix_acl.c): __forget_cached_acl() returns early when *p is
+ * ACL_DONT_CACHE, preserving the "never cache" invariant for the inode's
+ * lifetime.
+ *
+ * Test outline:
+ *  1. Mount a minimal FUSE fs (no FUSE_POSIX_ACL negotiated).
+ *  2. lgetxattr -> daemon called, ACL_A returned, NOT cached (ACL_DONT_CACHE).
+ *  3. statx(AT_STATX_FORCE_SYNC) -> forget_all_cached_acls() called.
+ *     Buggy:  ACL_DONT_CACHE -> ACL_NOT_CACHED (cache enabled).
+ *     Fixed:  ACL_DONT_CACHE preserved.
+ *  4. lgetxattr -> daemon called, ACL_A returned.
+ *     Buggy:  result now cached (ACL_NOT_CACHED -> cached).
+ *     Fixed:  result still not cached.
+ *  5. Daemon switches to ACL_B internally (different size).
+ *  6. lgetxattr -> should return ACL_B (44 bytes).
+ *     Buggy:  cache hit, returns stale ACL_A (28 bytes). FAIL.
+ *     Fixed:  no cache, daemon called, returns ACL_B (44 bytes). PASS.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#define FUSE_USE_VERSION 31
+#include <fuse_lowlevel.h>
+
+#include "kselftest_harness.h"
+
+/* ---- ACL binary encoding ------------------------------------------------ */
+/*
+ * POSIX ACL v2 xattr format (little-endian):
+ *   header: u32 version (= 0x00000002)
+ *   entry:  u16 tag | u16 perm | u32 id
+ *
+ * Entries must appear in tag-ascending order; named USER/GROUP entries
+ * require a MASK entry.  Both ACLs pass posix_acl_from_xattr() validation.
+ */
+
+/* ACL_A: 3 entries (USER_OBJ:rwx, GROUP_OBJ:r-x, OTHER:r-x) = 28 bytes */
+static const uint8_t acl_a[] = {
+	0x02, 0x00, 0x00, 0x00,                         /* v2 header      */
+	0x01, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* USER_OBJ  rwx  */
+	0x04, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* GROUP_OBJ r-x  */
+	0x20, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* OTHER     r-x  */
+};
+
+/*
+ * ACL_B: 5 entries — adds USER uid=1 and MASK = 44 bytes.
+ * A named USER entry requires a MASK; all tags in ascending order.
+ */
+static const uint8_t acl_b[] = {
+	0x02, 0x00, 0x00, 0x00,                         /* v2 header       */
+	0x01, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* USER_OBJ   rwx  */
+	0x02, 0x00, 0x07, 0x00, 0x01, 0x00, 0x00, 0x00, /* USER uid=1 rwx  */
+	0x04, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* GROUP_OBJ  r-x  */
+	0x10, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* MASK       rwx  */
+	0x20, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* OTHER      r-x  */
+};
+
+/* ---- Shared state (daemon thread <-> test thread) ----------------------- */
+
+#define FILE_INO  2
+#define FILE_NAME "testfile"
+
+struct daemon_state {
+	pthread_mutex_t lock;
+	const uint8_t  *acl;
+	size_t          acl_size;
+	int             getxattr_count;
+};
+
+/*
+ * Global: callbacks are stateless fns so we use a single global.
+ * Safe because only one test instance runs at a time.
+ */
+static struct daemon_state g_ds = {
+	.lock = PTHREAD_MUTEX_INITIALIZER,
+};
+
+/* ---- FUSE lowlevel callbacks -------------------------------------------- */
+
+static void fs_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
+{
+	if (parent != FUSE_ROOT_ID || strcmp(name, FILE_NAME)) {
+		fuse_reply_err(req, ENOENT);
+		return;
+	}
+	struct fuse_entry_param e = {};
+
+	/*
+	 * Long attr/entry timeouts so that normal stat() calls do not
+	 * expire and trigger forget_all_cached_acls() on their own;
+	 * only the explicit AT_STATX_FORCE_SYNC should trigger it.
+	 */
+	e.ino             = FILE_INO;
+	e.generation      = 1;
+	e.attr_timeout    = 10.0;
+	e.entry_timeout   = 10.0;
+	e.attr.st_ino     = FILE_INO;
+	e.attr.st_mode    = S_IFREG | 0644;
+	e.attr.st_nlink   = 1;
+	fuse_reply_entry(req, &e);
+}
+
+static void fs_getattr(fuse_req_t req, fuse_ino_t ino,
+		       struct fuse_file_info *fi)
+{
+	struct stat st = {};
+
+	(void)fi;
+	if (ino == FUSE_ROOT_ID) {
+		st.st_ino   = FUSE_ROOT_ID;
+		st.st_mode  = S_IFDIR | 0755;
+		st.st_nlink = 2;
+	} else if (ino == FILE_INO) {
+		st.st_ino   = FILE_INO;
+		st.st_mode  = S_IFREG | 0644;
+		st.st_nlink = 1;
+	} else {
+		fuse_reply_err(req, ENOENT);
+		return;
+	}
+	fuse_reply_attr(req, &st, 10);
+}
+
+static void fs_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
+			size_t size)
+{
+	if (ino != FILE_INO ||
+	    strcmp(name, "system.posix_acl_access") != 0) {
+		fuse_reply_err(req, ENODATA);
+		return;
+	}
+
+	pthread_mutex_lock(&g_ds.lock);
+	const uint8_t *acl      = g_ds.acl;
+	size_t         acl_size = g_ds.acl_size;
+	g_ds.getxattr_count++;
+	pthread_mutex_unlock(&g_ds.lock);
+
+	if (size == 0)
+		fuse_reply_xattr(req, acl_size);
+	else if (size < acl_size)
+		fuse_reply_err(req, ERANGE);
+	else
+		fuse_reply_buf(req, (const char *)acl, acl_size);
+}
+
+static const struct fuse_lowlevel_ops fs_ops = {
+	.lookup   = fs_lookup,
+	.getattr  = fs_getattr,
+	.getxattr = fs_getxattr,
+};
+
+/* ---- Daemon thread ------------------------------------------------------- */
+
+static void *run_daemon(void *arg)
+{
+	fuse_session_loop((struct fuse_session *)arg);
+	return NULL;
+}
+
+/* ---- kselftest harness --------------------------------------------------- */
+
+FIXTURE(acl_cache) {
+	struct fuse_session *se;
+	char                 mountpoint[PATH_MAX];
+	char                 file_path[PATH_MAX];
+	pthread_t            thread;
+};
+
+FIXTURE_SETUP(acl_cache)
+{
+	char *fuse_argv[] = { "fuse_acl_cache_test", NULL };
+	struct fuse_args args = FUSE_ARGS_INIT(1, fuse_argv);
+
+	g_ds.acl            = acl_a;
+	g_ds.acl_size       = sizeof(acl_a);
+	g_ds.getxattr_count = 0;
+
+	strcpy(self->mountpoint, "/tmp/acl_cache_test_XXXXXX");
+	if (!mkdtemp(self->mountpoint))
+		SKIP(return, "mkdtemp: %s", strerror(errno));
+
+	snprintf(self->file_path, sizeof(self->file_path),
+		 "%s/" FILE_NAME, self->mountpoint);
+
+	self->se = fuse_session_new(&args, &fs_ops, sizeof(fs_ops), NULL);
+	if (!self->se) {
+		rmdir(self->mountpoint);
+		SKIP(return, "fuse_session_new failed");
+	}
+
+	if (fuse_session_mount(self->se, self->mountpoint)) {
+		fuse_session_destroy(self->se);
+		rmdir(self->mountpoint);
+		SKIP(return, "fuse_session_mount failed "
+			     "(missing fusermount3 or insufficient privileges)");
+	}
+
+	if (pthread_create(&self->thread, NULL, run_daemon, self->se)) {
+		fuse_session_unmount(self->se);
+		fuse_session_destroy(self->se);
+		rmdir(self->mountpoint);
+		SKIP(return, "pthread_create: %s", strerror(errno));
+	}
+
+	fuse_opt_free_args(&args);
+}
+
+FIXTURE_TEARDOWN(acl_cache)
+{
+	fuse_session_exit(self->se);
+	fuse_session_unmount(self->se);
+	pthread_join(self->thread, NULL);
+	fuse_session_destroy(self->se);
+	rmdir(self->mountpoint);
+}
+
+static int do_force_statx(const char *path)
+{
+	struct statx stx;
+
+	return syscall(SYS_statx, AT_FDCWD, path,
+		       AT_STATX_FORCE_SYNC, STATX_BASIC_STATS, &stx);
+}
+
+TEST_F(acl_cache, stale_after_force_sync)
+{
+	char    buf[512];
+	ssize_t sz;
+	int     count;
+
+	/*
+	 * Step 1: two getxattr calls before any statx(FORCE_SYNC).
+	 * i_acl == ACL_DONT_CACHE.  __get_acl's cmpxchg(p, ACL_NOT_CACHED,
+	 * sentinel) finds *p != ACL_NOT_CACHED on every call, so the sentinel
+	 * is never placed and the result is never cached.  Both calls must
+	 * reach the daemon, proving ACL_DONT_CACHE suppresses caching.
+	 */
+	sz = lgetxattr(self->file_path, "system.posix_acl_access",
+		       buf, sizeof(buf));
+	ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
+
+	sz = lgetxattr(self->file_path, "system.posix_acl_access",
+		       buf, sizeof(buf));
+	ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
+
+	pthread_mutex_lock(&g_ds.lock);
+	count = g_ds.getxattr_count;
+	pthread_mutex_unlock(&g_ds.lock);
+
+	ASSERT_EQ(count, 2);
+	TH_LOG("step 1 OK: both pre-trigger getxattrs reached daemon (count=%d), "
+	       "ACL_DONT_CACHE is working", count);
+
+	/*
+	 * Step 2: statx(AT_STATX_FORCE_SYNC).
+	 * fuse_update_get_attr() calls forget_all_cached_acls() before sending
+	 * FUSE_GETATTR.
+	 *   Buggy kernel:  ACL_DONT_CACHE -> ACL_NOT_CACHED  (cache enabled)
+	 *   Fixed kernel:  ACL_DONT_CACHE preserved           (no effect)
+	 */
+	ASSERT_EQ(do_force_statx(self->file_path), 0);
+	TH_LOG("step 2 OK: statx(AT_STATX_FORCE_SYNC) succeeded");
+
+	/*
+	 * Step 3: getxattr — cache population attempt after the trigger.
+	 *   Buggy:  *p == ACL_NOT_CACHED -> sentinel placed -> fuse_get_inode_acl
+	 *           called -> ACL_A parsed and stored in the kernel cache.
+	 *   Fixed:  *p == ACL_DONT_CACHE -> sentinel placement skipped ->
+	 *           fuse_get_inode_acl called but result not cached.
+	 * Either way the correct ACL_A is returned here.
+	 */
+	sz = lgetxattr(self->file_path, "system.posix_acl_access",
+		       buf, sizeof(buf));
+	ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
+
+	pthread_mutex_lock(&g_ds.lock);
+	count = g_ds.getxattr_count;
+	pthread_mutex_unlock(&g_ds.lock);
+
+	ASSERT_EQ(count, 3);
+	TH_LOG("step 3 OK: post-trigger getxattr reached daemon (count=%d), "
+	       "returned correct ACL_A (%zd bytes)", count, sz);
+
+	/*
+	 * Step 4: switch daemon to ACL_B (different size: 44 vs 28 bytes).
+	 * Simulates an ACL change that fuse_set_acl() would NOT invalidate for
+	 * !fc->posix_acl mounts (it skips forget_all_cached_acls in that case).
+	 * On a fixed kernel the ACL was never cached, so this is moot.
+	 */
+	pthread_mutex_lock(&g_ds.lock);
+	g_ds.acl      = acl_b;
+	g_ds.acl_size = sizeof(acl_b);
+	pthread_mutex_unlock(&g_ds.lock);
+	TH_LOG("step 4: daemon switched to ACL_B (%zu bytes)", sizeof(acl_b));
+
+	/*
+	 * Step 5: getxattr — the decisive check.
+	 *   Buggy kernel:  cache hit -> stale ACL_A (28 bytes), count stays 3.
+	 *   Fixed kernel:  no cache -> daemon called -> ACL_B (44 bytes), count 4.
+	 */
+	sz = lgetxattr(self->file_path, "system.posix_acl_access",
+		       buf, sizeof(buf));
+
+	pthread_mutex_lock(&g_ds.lock);
+	count = g_ds.getxattr_count;
+	pthread_mutex_unlock(&g_ds.lock);
+
+	if (sz == (ssize_t)sizeof(acl_a))
+		TH_LOG("step 5 BUG: stale ACL_A (%zd bytes) from kernel cache "
+		       "(count=%d); ACL_DONT_CACHE corrupted by "
+		       "forget_all_cached_acls()", sz, count);
+	else
+		TH_LOG("step 5 OK: daemon reached (count=%d), "
+		       "fresh ACL_B (%zd bytes)", count, sz);
+
+	EXPECT_EQ(sz, (ssize_t)sizeof(acl_b));
+	EXPECT_EQ(count, 4);
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0

