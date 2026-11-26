Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731389;
	b=czVwVNQqEGZEhLDnJrsWFaCsa+F4aelaGuS+imacqHaRQfMHOqjjLxKNsv/LHaSJwlpd
	 6564KrCKTs5HhKXCB+mQWNZiDOZGVy+ncCsofI/KAp/WxYkT5US7DEHtIPNJmH0l6mZyi
	 lVFc0Xyd6WDDEz0cU2Nw+LOgOWNRE3P69+iVlWJWCGiaxNcBIjKkF8N/5EJkdGChHf0gD
	 +s81Ha342PCfluwLCoYJWIW9COSYwwo7TULBuvT1ACsqAoSdQXHV2UyDCSBW+B1q7YYdp
	 iIs0cexrPeI0F1gQRIvoSdNWROoQXx1oaX+cFvRyqxHpl96lGm/3vT2XBx2Dsm0+TjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731389;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lxf+atO5CT846VeZirj81d0TPA2UE63AhUeYAbVYr4U=;
	b=bgIB1Ohca8crdCp0rpD4GbDqkmOyiTjFCbyxiGMiTZxrc3RaG7T4PtkO1NcRHNSah2FB
	 KBLn5xSSDvNZieHvJayZFJ2wNNmOmAa1y6QRwUCo+r41dk7Jqn8NMnOGVkJmzYa/c/VTb
	 HYsUTTAXHxC1q8+Iz1FCJJw2kC1PZMUhv41q5P7b3svPI7ZJVbUIwq95dxBOZjff20DKq
	 9MeSdU4igydaMBBoFVK7HiLeUegh1TBccUPvDGc3gsLinZ3BWlKTi38rd0EeMm8Tv/mmR
	 xF0GVWi7h3fVFrlnHzYgik13qsma31vam9Y0soot0W+dWn/UsiL6hjf0jxZS4uWEhig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iavDgzHO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF88606A688;
	Thu, 26 Nov 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iavDgzHO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534CA1F0089C;
	Thu, 26 Nov 2026 22:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731389;
	bh=lxf+atO5CT846VeZirj81d0TPA2UE63AhUeYAbVYr4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iavDgzHOK+xJdbK+B1akK3j7HoNFBvkqPNhJ+3wDdijeopP7IayLfoZLRZZYHdSQy
	 +p6RC0dyCwknKUufEIYI4gInZPQVhzShH2eR+PR4h8dbtOqIAtnMh8lw5W1NnreHdx
	 MkxuuAbcL278jnEJxeyXNDjHqnAIHd9nSLGUoMKML/ONZH6ZJdQOzH+MFR1zj3e7OQ
	 10kI/8CxEplS3wFz2bI4sAZ0ouQxT7lu04jnb/0iuh09CEJ0eJ0LvTq5Fso8z++Y5c
	 7IuT7C6lJdVnl9C7ky4rKydBEx/Z87l++sHdVn4h4ig9qLcD1dL4VbYEGA056Cch8C
	 nBn1WCBgIYTeA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 23:15:34 +0100
Subject: [PATCH 4/4] selftests/filesystems: add FAT O_TMPFILE tests
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
Message-Id: <20261126-work-fat-tmpfile-v1-4-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
In-Reply-To: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=13739; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1C84xuoFEpZyAGN9jTq6d2huMJlwQZMSH7Mh9nTfWcA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzrN/kdOfUhQPTPCw5Elt8doR8KY8u1ZnZHWiqUJhx3
 lrk7tqHHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM53MrI8C5R4FDthOhXW9sa
 LP+EzPXkcC+M2N7671sw05yP/MLzfzD8Mw26sEhhmR3fiosOvVG/ms0kHx7I1OwJi586/XF/4ft
 oFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests for O_TMPFILE on vfat and msdos. run_fat_tests.sh runs them
on a vfat mount and on an msdos mount with the dots option. This tests
that:

- an O_TMPFILE can be linked into its own and into another directory
- data written before and after linkat() ends up in the named file
- O_EXCL keeps it from being linked
- it can't be linked twice, nor again after it was unlinked
- a failed linkat() leaves it linkable
- link(2) of a regular file still fails with EPERM
- linkat() to a temporary name plus rename() replaces a file
- closing an unnamed O_TMPFILE frees its clusters
- with dots a leading dot makes the linked file hidden

After the tests the image is unmounted, checked with fsck.vfat -n and
mounted again to compare a linked O_TMPFILE with a regular copy.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/fat/.gitignore |   1 +
 tools/testing/selftests/filesystems/fat/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fat/config     |   1 +
 .../selftests/filesystems/fat/run_fat_tests.sh     |  41 +++
 tools/testing/selftests/filesystems/fat/tmpfile.c  | 324 +++++++++++++++++++++
 5 files changed, 368 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/fat/.gitignore b/tools/testing/selftests/filesystems/fat/.gitignore
index b89920ed841cc..b541a20590e3f 100644
--- a/tools/testing/selftests/filesystems/fat/.gitignore
+++ b/tools/testing/selftests/filesystems/fat/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 rename_exchange
+tmpfile
diff --git a/tools/testing/selftests/filesystems/fat/Makefile b/tools/testing/selftests/filesystems/fat/Makefile
index 902033f6ef098..4f3fb279056a7 100644
--- a/tools/testing/selftests/filesystems/fat/Makefile
+++ b/tools/testing/selftests/filesystems/fat/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 TEST_PROGS := run_fat_tests.sh
-TEST_GEN_PROGS_EXTENDED := rename_exchange
+TEST_GEN_PROGS_EXTENDED := rename_exchange tmpfile
 CFLAGS += -O2 -g -Wall $(KHDR_INCLUDES)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/fat/config b/tools/testing/selftests/filesystems/fat/config
index 6cf95e787a17b..49ee111e2e379 100644
--- a/tools/testing/selftests/filesystems/fat/config
+++ b/tools/testing/selftests/filesystems/fat/config
@@ -1,2 +1,3 @@
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
index 0712c8d23fd7e..38be991a44db1 100755
--- a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
+++ b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
@@ -51,6 +51,15 @@ mount_image()
     sudo mount -o loop "${IMG_PATH}" "${MNT_PATH}"
 }
 
+mount_image_as()
+{
+    local fstype="$1"
+    local opts="$2"
+
+    mkdir -p "${MNT_PATH}"
+    sudo mount -t "${fstype}" -o "loop${opts:+,${opts}}" "${IMG_PATH}" "${MNT_PATH}"
+}
+
 rename_exchange_test()
 {
     local rename_exchange="${BASE_DIR}/rename_exchange"
@@ -86,11 +95,43 @@ unmount_image()
     sudo umount "${MNT_PATH}" &> /dev/null
 }
 
+tmpfile_test()
+{
+    local tmpfile="${BASE_DIR}/tmpfile"
+    local fstype="$1"
+    local opts="$2"
+    local dots=0
+
+    if [ "${opts}" = "dots" ]; then
+        dots=1
+    fi
+
+    create_loopback
+    mount_image_as "${fstype}" "${opts}"
+    sudo env FAT_MNT="${MNT_PATH}" FAT_DOTS="${dots}" "${tmpfile}"
+    unmount_image
+
+    # No clusters leaked by unnamed O_TMPFILEs, named ones are complete.
+    fsck.vfat -n "${IMG_PATH}" >/dev/null 2>&1
+
+    mount_image_as "${fstype}" "${opts}"
+    # Missing if the tests skipped because O_TMPFILE isn't supported.
+    if [ -e "${MNT_PATH}/regular.txt" ]; then
+        cmp "${MNT_PATH}/tmpfile.txt" "${MNT_PATH}/regular.txt" >/dev/null 2>&1
+        if [ "${dots}" -eq 1 ]; then
+            test -f "${MNT_PATH}/.hidden"
+        fi
+    fi
+    unmount_image
+}
+
 check_prereqs
 create_loopback
 mount_image
 rename_exchange_test
 rename_exchange_subdir_test
 unmount_image
+tmpfile_test vfat ""
+tmpfile_test msdos dots
 
 exit 0
diff --git a/tools/testing/selftests/filesystems/fat/tmpfile.c b/tools/testing/selftests/filesystems/fat/tmpfile.c
new file mode 100644
index 0000000000000..324660267d1b1
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/tmpfile.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * O_TMPFILE on vfat and msdos. run_fat_tests.sh mounts the image, passes the
+ * mount point in FAT_MNT and sets FAT_DOTS=1 for msdos mounted with "dots".
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+#include <unistd.h>
+#include <linux/msdos_fs.h>
+
+#include "../../kselftest_harness.h"
+
+/* Left behind for run_fat_tests.sh to check after a remount. */
+#define TMPFILE_NAME	"tmpfile.txt"
+#define REGULAR_NAME	"regular.txt"
+#define HIDDEN_NAME	".hidden"
+
+/* Clusters the space test writes. */
+#define SPACE_CLUSTERS	8
+
+/* Several clusters plus a partial one, a prime period so no two look alike. */
+#define PERSIST_SIZE	(3 * 4096 + 123)
+#define PERSIST_PERIOD	251
+
+static const char data[] = "written through an O_TMPFILE\n";
+static const char old_data[] = "old\n";
+
+static int open_tmpfile(int dir_fd, int flags)
+{
+	return openat(dir_fd, ".", O_TMPFILE | O_RDWR | O_CLOEXEC | flags, 0600);
+}
+
+static int link_tmpfile(int fd, int dir_fd, const char *name)
+{
+	return linkat(fd, "", dir_fd, name, AT_EMPTY_PATH);
+}
+
+static ssize_t read_file(int dir_fd, const char *name, char *buf, size_t size)
+{
+	ssize_t ret;
+	int fd;
+
+	fd = openat(dir_fd, name, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	ret = read(fd, buf, size);
+	close(fd);
+	return ret;
+}
+
+FIXTURE(tmpfile) {
+	int mnt_fd;
+	int dir_fd;
+};
+
+FIXTURE_SETUP(tmpfile)
+{
+	const char *mnt = getenv("FAT_MNT");
+	char name[16];
+	int fd;
+
+	if (!mnt)
+		SKIP(return, "FAT_MNT not set, run this from run_fat_tests.sh");
+
+	self->mnt_fd = open(mnt, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(self->mnt_fd, 0);
+
+	/* A fresh directory per test, short enough for an 8.3 name. */
+	snprintf(name, sizeof(name), "t%d", getpid());
+	ASSERT_EQ(mkdirat(self->mnt_fd, name, 0755), 0);
+	self->dir_fd = openat(self->mnt_fd, name,
+			      O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(self->dir_fd, 0);
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	if (fd < 0 && errno == EOPNOTSUPP)
+		SKIP(return, "O_TMPFILE not supported");
+	ASSERT_GE(fd, 0);
+	close(fd);
+}
+
+FIXTURE_TEARDOWN(tmpfile)
+{
+	close(self->dir_fd);
+	close(self->mnt_fd);
+}
+
+/* An O_TMPFILE gets a name and keeps what was written to it. */
+TEST_F(tmpfile, link)
+{
+	char buf[sizeof(data)];
+	struct stat st;
+	int fd;
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(fstat(fd, &st), 0);
+	ASSERT_EQ(st.st_nlink, 0);
+	ASSERT_EQ(write(fd, data, sizeof(data)), sizeof(data));
+
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "file"), 0);
+	ASSERT_EQ(fstat(fd, &st), 0);
+	ASSERT_EQ(st.st_nlink, 1);
+	ASSERT_EQ(st.st_size, sizeof(data));
+	ASSERT_EQ(close(fd), 0);
+
+	ASSERT_EQ(read_file(self->dir_fd, "file", buf, sizeof(buf)), sizeof(data));
+	ASSERT_EQ(memcmp(buf, data, sizeof(data)), 0);
+}
+
+/* The name can be in another directory than the one O_TMPFILE was given. */
+TEST_F(tmpfile, link_other_dir)
+{
+	char buf[sizeof(data)];
+	int fd, sub_fd;
+
+	ASSERT_EQ(mkdirat(self->dir_fd, "sub", 0755), 0);
+	sub_fd = openat(self->dir_fd, "sub", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(sub_fd, 0);
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, data, sizeof(data)), sizeof(data));
+	ASSERT_EQ(link_tmpfile(fd, sub_fd, "file"), 0);
+	ASSERT_EQ(close(fd), 0);
+
+	ASSERT_EQ(read_file(sub_fd, "file", buf, sizeof(buf)), sizeof(data));
+	ASSERT_EQ(memcmp(buf, data, sizeof(data)), 0);
+	close(sub_fd);
+}
+
+/* Data written after linkat() ends up in the named file too. */
+TEST_F(tmpfile, write_after_link)
+{
+	char buf[2 * sizeof(data)];
+	struct stat st;
+	int fd;
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, data, sizeof(data)), sizeof(data));
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "file"), 0);
+	ASSERT_EQ(write(fd, data, sizeof(data)), sizeof(data));
+	ASSERT_EQ(close(fd), 0);
+
+	ASSERT_EQ(fstatat(self->dir_fd, "file", &st, 0), 0);
+	ASSERT_EQ(st.st_size, sizeof(buf));
+	ASSERT_EQ(read_file(self->dir_fd, "file", buf, sizeof(buf)), sizeof(buf));
+	ASSERT_EQ(memcmp(buf, data, sizeof(data)), 0);
+	ASSERT_EQ(memcmp(buf + sizeof(data), data, sizeof(data)), 0);
+}
+
+/* O_EXCL keeps an O_TMPFILE from ever getting a name. */
+TEST_F(tmpfile, excl)
+{
+	int fd;
+
+	fd = open_tmpfile(self->dir_fd, O_EXCL);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "file"), -1);
+	ASSERT_EQ(errno, ENOENT);
+	close(fd);
+}
+
+/* Only the first name sticks. */
+TEST_F(tmpfile, link_twice)
+{
+	int fd;
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "first"), 0);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "second"), -1);
+	ASSERT_EQ(errno, EPERM);
+	ASSERT_EQ(faccessat(self->dir_fd, "second", F_OK, 0), -1);
+	ASSERT_EQ(errno, ENOENT);
+	close(fd);
+}
+
+/* Once named and unlinked it is a plain unlinked file. */
+TEST_F(tmpfile, relink_after_unlink)
+{
+	int fd;
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "file"), 0);
+	ASSERT_EQ(unlinkat(self->dir_fd, "file", 0), 0);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "file"), -1);
+	ASSERT_EQ(errno, ENOENT);
+	close(fd);
+}
+
+/* A failed linkat() leaves the O_TMPFILE linkable. */
+TEST_F(tmpfile, link_invalid_name)
+{
+	int fd;
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "bad*name"), -1);
+	ASSERT_EQ(errno, EINVAL);
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "file"), 0);
+	close(fd);
+}
+
+/* FAT still has no hard links. */
+TEST_F(tmpfile, hardlink)
+{
+	int fd;
+
+	fd = openat(self->dir_fd, "file", O_CREAT | O_EXCL | O_RDWR | O_CLOEXEC,
+		    0600);
+	ASSERT_GE(fd, 0);
+	close(fd);
+	ASSERT_EQ(linkat(self->dir_fd, "file", self->dir_fd, "link", 0), -1);
+	ASSERT_EQ(errno, EPERM);
+}
+
+/* Link under a temporary name and rename over the target, as systemd does. */
+TEST_F(tmpfile, replace)
+{
+	char buf[sizeof(data)];
+	int fd;
+
+	fd = openat(self->dir_fd, "target", O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
+		    0600);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, old_data, sizeof(old_data)), sizeof(old_data));
+	close(fd);
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, data, sizeof(data)), sizeof(data));
+	ASSERT_EQ(link_tmpfile(fd, self->dir_fd, "target.tmp"), 0);
+	ASSERT_EQ(renameat(self->dir_fd, "target.tmp", self->dir_fd, "target"), 0);
+	ASSERT_EQ(close(fd), 0);
+
+	ASSERT_EQ(read_file(self->dir_fd, "target", buf, sizeof(buf)), sizeof(data));
+	ASSERT_EQ(memcmp(buf, data, sizeof(data)), 0);
+}
+
+/* Closing an unnamed O_TMPFILE gives its clusters back. */
+TEST_F(tmpfile, space)
+{
+	struct statvfs before, during, after;
+	size_t len;
+	char *buf;
+	int fd;
+
+	ASSERT_EQ(fstatvfs(self->dir_fd, &before), 0);
+	len = SPACE_CLUSTERS * before.f_bsize;
+	buf = malloc(len);
+	ASSERT_NE(buf, NULL);
+	memset(buf, 'x', len);
+
+	fd = open_tmpfile(self->dir_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, buf, len), len);
+	ASSERT_EQ(fstatvfs(fd, &during), 0);
+	ASSERT_LE(during.f_bfree, before.f_bfree - SPACE_CLUSTERS);
+	ASSERT_EQ(close(fd), 0);
+
+	ASSERT_EQ(fstatvfs(self->dir_fd, &after), 0);
+	ASSERT_EQ(after.f_bfree, before.f_bfree);
+	free(buf);
+}
+
+/* A named O_TMPFILE and a regular copy, compared after a remount. */
+TEST_F(tmpfile, persist)
+{
+	char buf[PERSIST_SIZE];
+	size_t half = sizeof(buf) / 2;
+	size_t i;
+	int fd;
+
+	for (i = 0; i < sizeof(buf); i++)
+		buf[i] = i % PERSIST_PERIOD;
+
+	fd = openat(self->mnt_fd, REGULAR_NAME,
+		    O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC, 0644);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, buf, sizeof(buf)), sizeof(buf));
+	ASSERT_EQ(fsync(fd), 0);
+	ASSERT_EQ(close(fd), 0);
+
+	fd = open_tmpfile(self->mnt_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, buf, half), half);
+	ASSERT_EQ(link_tmpfile(fd, self->mnt_fd, TMPFILE_NAME), 0);
+	ASSERT_EQ(write(fd, buf + half, sizeof(buf) - half), sizeof(buf) - half);
+	ASSERT_EQ(fsync(fd), 0);
+	ASSERT_EQ(close(fd), 0);
+	ASSERT_EQ(fsync(self->mnt_fd), 0);
+}
+
+/* On msdos with "dots" a leading dot makes the named O_TMPFILE hidden. */
+TEST_F(tmpfile, hidden)
+{
+	const char *dots = getenv("FAT_DOTS");
+	__u32 attrs;
+	int fd;
+
+	if (!dots || strcmp(dots, "1"))
+		SKIP(return, "needs msdos mounted with the dots option");
+
+	fd = open_tmpfile(self->mnt_fd, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(link_tmpfile(fd, self->mnt_fd, HIDDEN_NAME), 0);
+	ASSERT_EQ(ioctl(fd, FAT_IOCTL_GET_ATTRIBUTES, &attrs), 0);
+	ASSERT_TRUE(attrs & ATTR_HIDDEN);
+	ASSERT_EQ(fsync(fd), 0);
+	ASSERT_EQ(close(fd), 0);
+	ASSERT_EQ(fsync(self->mnt_fd), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

