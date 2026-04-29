Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45D34DCD2;
	Wed, 29 Apr 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473890; cv=none; b=XHOraMLaInQj0Po8zWHyzQoJj25tzxg9W25iCeySVlvsmk5o7WxYVJ3uVJqP3dtustvvidFqzGjBuLipbcUG8Nqf+m7nIgpz6j0p9w4vDckxc5CIX0k/SfLGKSA+bupeyzKmRlzOFM3QjlpqXYxY8LzXpXWT6fH1rn/JDIYfNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473890; c=relaxed/simple;
	bh=kbPxXpsYM55LDk3UUyiOcFmPtHfXv5byo2XaXwOj6UI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWC2H7JVRrG+F6n7ofw+ysgOEzNY5T7SfpCNm0kc7NxxraAjE7Tu1guRmku6S4ZHfKDe5JQ04DqtltvW1BjCjMlKjsoc6u94/18obwfatQNMZhOQAjYe/af7vTA9HCbY3oN7Rn4MkzY5caCu3TybJRDLnkb3AWFzyQKYtV6aIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBfOkRIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBfOkRIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8083C19425;
	Wed, 29 Apr 2026 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473889;
	bh=kbPxXpsYM55LDk3UUyiOcFmPtHfXv5byo2XaXwOj6UI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HBfOkRIu6O0c/pwbXivKQcmCoCv3RExjILz7nUkjhfsW6voQPOtrb00mA1bbMqfMK
	 nPvRIKQA0iVa4SJOwv2HHZpl012K2N6neqzdaRfDFYRRn7NcMYgoiLqVHeghMImVh2
	 YjEmZaUBWrwT31k+UnlpbjPqO1n4EjkHG8ieKt8A1Lr3XiVFFrZHt44If/5LzCA1vH
	 mEF9ArgFug+/n5tODd7O/j87w/i7MGnB4dw45Pa5GgOCZSsE4RRRBP1VeGdahVAY1b
	 w/PzroGxdGqDoHa5Br8nUeHgweewXUOs60d3xYYJWhpExgYQC1DMVckVQlBhEWVO3n
	 Dl1W3oJEeF68A==
Date: Wed, 29 Apr 2026 07:44:49 -0700
Subject: [PATCH 22/25] libfuse: create a helper to transform an open regular
 file into an open loopdev
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211961.4104686.8091769616825139501.stgit@frogsfrogsfrogs>
In-Reply-To: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a helper function to configure a loop device for an open regular
file fd, and then return an open fd to the loop device.  This will
enable the use of fuse+iomap file servers with filesystem image files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_loopdev.h |   29 +++
 include/meson.build    |    4 
 lib/fuse_loopdev.c     |  441 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript |    1 
 lib/meson.build        |    3 
 meson.build            |   11 +
 6 files changed, 488 insertions(+), 1 deletion(-)
 create mode 100644 include/fuse_loopdev.h
 create mode 100644 lib/fuse_loopdev.c


diff --git a/include/fuse_loopdev.h b/include/fuse_loopdev.h
new file mode 100644
index 00000000000000..aa536e2a0b3964
--- /dev/null
+++ b/include/fuse_loopdev.h
@@ -0,0 +1,29 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt.
+ */
+#ifndef FUSE_LOOPDEV_H_
+#define FUSE_LOOPDEV_H_
+
+/**
+ * If possible, set up a loop device for the given file fd.  Return the opened
+ * loop device fd and the path to the loop device.  The loop device will be
+ * removed when the last close() occurs.
+ *
+ * @param file_fd an open file
+ * @param open_flags O_* flags that were used to open file_fd
+ * @param path the path to the open regular file
+ * @param timeout spend this much time waiting to lock the file
+ * @param loop_fd set to an open fd to the new loop device or
+ *        -1 if setting up a loop device is not possible or appropriate
+ * @param loop_dev (optional) set to a pointer to the path to the loop device
+ * @return 0 for success, or negative errno on failure
+ */
+int fuse_loopdev_setup(int file_fd, int open_flags, const char *path,
+		       unsigned int timeout, int *loop_fd, char **loop_dev);
+
+#endif /* FUSE_LOOPDEV_H_ */
diff --git a/include/meson.build b/include/meson.build
index da51180f87eea2..60edd649f1784f 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -5,4 +5,8 @@ if private_cfg.get('HAVE_SERVICEMOUNT', false)
   libfuse_headers += [ 'fuse_service.h' ]
 endif
 
+if private_cfg.get('FUSE_LOOPDEV_ENABLED')
+  libfuse_headers += [ 'fuse_loopdev.h' ]
+endif
+
 install_headers(libfuse_headers, subdir: 'fuse3')
diff --git a/lib/fuse_loopdev.c b/lib/fuse_loopdev.c
new file mode 100644
index 00000000000000..6d7017277d9eaf
--- /dev/null
+++ b/lib/fuse_loopdev.c
@@ -0,0 +1,441 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * Library functions for handling loopback devices on linux.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt
+ */
+#define _GNU_SOURCE
+#include "fuse_config.h"
+#include "fuse_loopdev.h"
+
+#ifdef FUSE_LOOPDEV_ENABLED
+#include <stdint.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <dirent.h>
+#include <signal.h>
+#include <time.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/file.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <linux/loop.h>
+
+#include "fuse_log.h"
+
+#define _PATH_LOOPCTL		"/dev/loop-control"
+#define _PATH_SYS_BLOCK		"/sys/block"
+
+#ifdef STATX_SUBVOL
+# define STATX_SUBVOL_FLAG	STATX_SUBVOL
+#else
+# define STATX_SUBVOL_FLAG	0
+#endif
+
+static int lock_file(int fd, const char *path)
+{
+	int ret;
+
+	ret = flock(fd, LOCK_EX);
+	if (ret) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
+		return -error;
+	}
+
+	return 0;
+}
+
+static double gettime_monotonic(void)
+{
+#ifdef CLOCK_MONOTONIC
+	struct timespec ts;
+#endif
+	struct timeval tv;
+	static double fake_ret;
+	int ret;
+
+#ifdef CLOCK_MONOTONIC
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (ret == 0)
+		return ts.tv_sec + (ts.tv_nsec / 1000000000.0);
+#endif
+	ret = gettimeofday(&tv, NULL);
+	if (ret == 0)
+		return tv.tv_sec + (tv.tv_usec / 1000000.0);
+
+	fake_ret += 1.0;
+	return fake_ret;
+}
+
+static int lock_file_timeout(int fd, const char *path, unsigned int timeout)
+{
+	double deadline, now;
+	int ret;
+
+	now = gettime_monotonic();
+	deadline = now + timeout;
+
+	/* Use a tight sleeping loop here to avoid signal handlers */
+	while (now <= deadline) {
+		struct timespec sleepy = {
+			/* sleep 0.1s before trying again */
+			.tv_nsec = 100000000,
+		};
+		int error;
+
+		ret = flock(fd, LOCK_EX | LOCK_NB);
+		if (ret == 0)
+			return 0;
+
+		error = errno;
+
+		if (error != EWOULDBLOCK) {
+			fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path,
+				 strerror(error));
+			return -error;
+		}
+
+		nanosleep(&sleepy, NULL);
+
+		now = gettime_monotonic();
+	}
+
+	fuse_log(FUSE_LOG_DEBUG, "%s: could not lock file\n", path);
+	return -EWOULDBLOCK;
+}
+
+static int unlock_file(int fd, const char *path)
+{
+	int ret;
+
+	ret = flock(fd, LOCK_UN);
+	if (ret) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
+		return -error;
+	}
+
+	return 0;
+}
+
+static int want_loopdev(int file_fd, const char *path)
+{
+	struct stat stbuf;
+	int ret;
+
+	ret = fstat(file_fd, &stbuf);
+	if (ret < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: fstat failed: %s\n",
+			 path, strerror(error));
+		return -error;
+	}
+
+	/*
+	 * Keep quiet about block devices, the client can probably still read
+	 * and write that.
+	 */
+	if (S_ISBLK(stbuf.st_mode))
+		return 0;
+
+	ret = S_ISREG(stbuf.st_mode) && stbuf.st_size >= 512;
+	if (!ret)
+		fuse_log(FUSE_LOG_DEBUG,
+			 "%s: file not compatible with loop device\n", path);
+	return ret;
+}
+
+static int same_backing_file(int dir_fd, const char *name,
+			     const struct statx *file_stat)
+{
+	struct statx backing_stat;
+	char backing_name[NAME_MAX + 18 + 1];
+	char path[PATH_MAX + 1];
+	ssize_t bytes;
+	int fd;
+	int ret;
+
+	snprintf(backing_name, sizeof(backing_name), "%s/loop/backing_file",
+			name);
+
+	fd = openat(dir_fd, backing_name, O_RDONLY);
+	if (fd < 0) {
+		int error = errno;
+
+		/* unconfigured loop devices don't have backing_file attr */
+		if (error == ENOENT)
+			return 0;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", backing_name,
+			 strerror(error));
+		return -error;
+	}
+
+	bytes = pread(fd, path, sizeof(path) - 1, 0);
+	if (bytes < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", backing_name,
+			 strerror(error));
+		ret = -error;
+		goto out_backing;
+	} else if (bytes == 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: no path in backing file?\n",
+			 backing_name);
+		ret = -ENOENT;
+		goto out_backing;
+	}
+
+	if (path[bytes - 1] == '\n')
+		path[bytes - 1] = 0;
+
+	ret = statx(AT_FDCWD, path, 0, STATX_BASIC_STATS | STATX_SUBVOL_FLAG,
+			&backing_stat);
+	if (ret) {
+		int error = errno;
+
+		/*
+		 * backing file deleted, assume nobody's doing procfd
+		 * shenanigans
+		 */
+		if (error == ENOENT) {
+			ret = 0;
+			goto out_backing;
+		}
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
+		ret = -error;
+		goto out_backing;
+	}
+
+	/* different devices */
+	if (backing_stat.stx_dev_major != file_stat->stx_dev_major)
+		goto out_backing;
+	if (backing_stat.stx_dev_minor != file_stat->stx_dev_minor)
+		goto out_backing;
+
+	/* different inode number */
+	if (backing_stat.stx_ino != file_stat->stx_ino)
+		goto out_backing;
+
+#ifdef STATX_SUBVOL
+	/* different subvol (or subvol state) */
+	if ((backing_stat.stx_mask ^ file_stat->stx_mask) & STATX_SUBVOL)
+		goto out_backing;
+
+	if ((backing_stat.stx_mask & STATX_SUBVOL) &&
+	    backing_stat.stx_subvol != file_stat->stx_subvol)
+		goto out_backing;
+#endif
+
+	ret = 1;
+
+out_backing:
+	close(fd);
+	return ret;
+}
+
+static int has_existing_loopdev(int file_fd, const char *path)
+{
+	struct statx file_stat;
+	DIR *dir;
+	struct dirent *d;
+	int blockfd;
+	int ret;
+
+	ret = statx(file_fd, "", AT_EMPTY_PATH,
+		    STATX_BASIC_STATS | STATX_SUBVOL_FLAG, &file_stat);
+	if (ret) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
+		return -error;
+	}
+
+	dir = opendir(_PATH_SYS_BLOCK);
+	if (!dir) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_SYS_BLOCK,
+			 strerror(error));
+		return -error;
+	}
+
+	blockfd = dirfd(dir);
+
+	while ((d = readdir(dir)) != NULL) {
+		if (strcmp(d->d_name, ".") == 0 ||
+		    strcmp(d->d_name, "..") == 0 ||
+		    strncmp(d->d_name, "loop", 4) != 0)
+			continue;
+
+		ret = same_backing_file(blockfd, d->d_name, &file_stat);
+		if (ret != 0)
+			break;
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+static int open_loopdev(int file_fd, int open_flags, char *loopdev,
+			size_t loopdev_sz)
+{
+	struct loop_config lc = {
+		.info.lo_flags = LO_FLAGS_DIRECT_IO | LO_FLAGS_AUTOCLEAR,
+	};
+	int ctl_fd = -1;
+	int loop_fd = -1;
+	int loopno;
+	int ret;
+
+	if ((open_flags & O_ACCMODE) == O_RDONLY)
+		lc.info.lo_flags |= LO_FLAGS_READ_ONLY;
+
+	ctl_fd = open(_PATH_LOOPCTL, O_RDONLY);
+	if (ctl_fd < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_LOOPCTL,
+			 strerror(error));
+		return -error;
+	}
+
+	ret = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
+	if (ret < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_LOOPCTL,
+			 strerror(error));
+		ret = -error;
+		goto out_ctl;
+	}
+	loopno = ret;
+	snprintf(loopdev, loopdev_sz, "/dev/loop%d", loopno);
+
+	loop_fd = open(loopdev, open_flags);
+	if (loop_fd < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", loopdev, strerror(error));
+		ret = -error;
+		goto out_ctl;
+	}
+
+	lc.fd = file_fd;
+
+	ret = ioctl(loop_fd, LOOP_CONFIGURE, &lc);
+	if (ret < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", loopdev, strerror(error));
+		ret = -error;
+		goto out_loop;
+	}
+
+	close(ctl_fd);
+	return loop_fd;
+
+out_loop:
+	ioctl(ctl_fd, LOOP_CTL_REMOVE, loopno);
+	close(loop_fd);
+out_ctl:
+	close(ctl_fd);
+	return ret;
+}
+
+int fuse_loopdev_setup(int file_fd, int open_flags, const char *path,
+		       unsigned int timeout, int *loop_fd, char **loop_dev)
+{
+	char loopdev[PATH_MAX];
+	int loopfd = -1;
+	int ret;
+
+	*loop_fd = -1;
+	if (loop_dev)
+		*loop_dev = NULL;
+
+	if (timeout)
+		ret = lock_file_timeout(file_fd, path, timeout);
+	else
+		ret = lock_file(file_fd, path);
+	if (ret)
+		return ret;
+
+	ret = want_loopdev(file_fd, path);
+	if (ret <= 0)
+		goto out_unlock;
+
+	ret = has_existing_loopdev(file_fd, path);
+	if (ret < 0)
+		goto out_unlock;
+	if (ret == 1) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "%s: attached to another loop device\n", path);
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	loopfd = open_loopdev(file_fd, open_flags, loopdev, sizeof(loopdev));
+	if (loopfd < 0) {
+		ret = loopfd;
+		goto out_unlock;
+	}
+
+	ret = unlock_file(file_fd, path);
+	if (ret)
+		goto out_loop;
+
+	if (loop_dev) {
+		char *ldev = strdup(loopdev);
+
+		if (!ldev) {
+			ret = -ENOMEM;
+			goto out_loop;
+		}
+
+		*loop_fd = loopfd;
+		*loop_dev = ldev;
+	} else {
+		*loop_fd = loopfd;
+	}
+
+	return 0;
+
+out_loop:
+	close(loopfd);
+out_unlock:
+	unlock_file(file_fd, path);
+	return ret;
+}
+#else
+#include <stdlib.h>
+
+#include "util.h"
+
+int fuse_loopdev_setup(int file_fd FUSE_VAR_UNUSED,
+		       int open_flags FUSE_VAR_UNUSED,
+		       const char *path FUSE_VAR_UNUSED,
+		       unsigned int timeout FUSE_VAR_UNUSED,
+		       int *loop_fd, char **loop_dev)
+{
+	*loop_fd = -1;
+	if (loop_dev)
+		*loop_dev = NULL;
+	return 0;
+}
+#endif /* FUSE_LOOPDEV_ENABLED */
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 99dfe35eccc90a..b2357623a49ce6 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -268,6 +268,7 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_device_invalidate;
 		fuse_fs_iomap_device_invalidate;
 		fuse_lowlevel_disable_fsreclaim;
+		fuse_loopdev_setup;
 } FUSE_3.19;
 
 # Local Variables:
diff --git a/lib/meson.build b/lib/meson.build
index ff311d4002da0e..e708247a307ba4 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -2,7 +2,8 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
                    'fuse_lowlevel.c', 'fuse_misc.h', 'fuse_opt.c',
                    'fuse_signals.c', 'buffer.c', 'cuse_lowlevel.c',
                    'helper.c', 'modules/subdir.c', 'mount_util.c',
-                   'fuse_log.c', 'compat.c', 'util.c', 'util.h' ]
+                   'fuse_log.c', 'compat.c', 'util.c', 'util.h',
+                   'fuse_loopdev.c' ]
 
 if host_machine.system().startswith('linux')
    libfuse_sources += [ 'mount.c' ]
diff --git a/meson.build b/meson.build
index 9fa17d08c39b6b..09e77ce3987dcc 100644
--- a/meson.build
+++ b/meson.build
@@ -187,7 +187,18 @@ private_cfg.set('HAVE_STRUCT_STAT_ST_ATIMESPEC',
     cc.has_member('struct stat', 'st_atimespec',
                   prefix: include_default + '#include <sys/stat.h>',
                   args: args_default))
+private_cfg.set('HAVE_STRUCT_LOOP_CONFIG_INFO',
+    cc.has_member('struct loop_config', 'info',
+                  prefix: include_default + '#include <linux/loop.h>',
+                  args: args_default))
+private_cfg.set('HAVE_STATX_BASIC_STATS',
+    cc.has_member('struct statx', 'stx_ino',
+                  prefix: include_default + '#include <sys/stat.h>',
+                  args: args_default))
 
+private_cfg.set('FUSE_LOOPDEV_ENABLED', \
+    private_cfg.get('HAVE_STRUCT_LOOP_CONFIG_INFO') and \
+    private_cfg.get('HAVE_STATX_BASIC_STATS'))
 private_cfg.set('USDT_ENABLED', get_option('enable-usdt'))
 
 # Check for liburing with SQE128 support

