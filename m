Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99C5733E;
	Wed, 29 Apr 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474046; cv=none; b=oEeGMutkHRQwi9Um24+f2c1ViVG9zhVeV1DYig3r9YO1EJ2gVXlc1GrrDtHJgRv0DBkzaibmy38L8fLYp9R8l/whHEhrpMVBD/tTliTLPJnqcDTMgXaqcmgPMOFAg9yCkFkn0xfBpyaHag3QvbG4J+4jzbLf4TwpE5e+qMAlbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474046; c=relaxed/simple;
	bh=ZaWctbhvmV8BXhImOIhVcUanCGuj9zyi9fB/1cL0iDM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6pTvx2TxC+daF/xCUOVnY00+1fMEDfH+jcxie9EFbC/vumLIekWnrL+UIVHFS4m4CdqTxO5+Szv9dTOajxb3/E/Szld/mbIIgNqUnc4a6+piErqXsi18QrKqrR//n3iLOI/eSym3mbXdz2jZUqi5F2bRa0cFV3jvV8NRkRBdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBkQOZMz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBkQOZMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3890C2BCC4;
	Wed, 29 Apr 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474046;
	bh=ZaWctbhvmV8BXhImOIhVcUanCGuj9zyi9fB/1cL0iDM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lBkQOZMzTFoDYn7yCB0y2B6ZOxXPyil/gbhJHZZLWrxaYbKfJl1rS0HG8h4j1fTnI
	 CMaLp4NgFvB8vG0HGDXzQT3jZomtJn03V0De+ufSea6FXX5Qq4ilM7jr9JJjihNcEU
	 yqpb7rPndCgsDC4ZnkFUgxI3DSTdg0pSxaJovPjJE+vOkADEjnd5zhRJZkVE/wheGX
	 D1Fj+mvZ66GsFqXp0ZHb+/1DJBW4SzOef4WWvNxVhV22nHICvd8xdOc93YIBkDAWM8
	 wmLRvcbv/BNEeBX2AC0GuqqMX+LOLOQo/75S304OKJpBD4Rmx3C0I6GF1u9wLV05mM
	 h8EbpWGWUB3yg==
Date: Wed, 29 Apr 2026 07:47:25 -0700
Subject: [PATCH 1/7] example/iomap_ll: create a simple iomap server
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212896.4106066.10011326514443586846.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
References: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a toy iomap fileserver as an example for how this all works.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h |    6 +
 example/iomap_ll.c    |  332 +++++++++++++++++++++++++++++++++++++++++++++++++
 example/meson.build   |    1 
 example/service_hl.c  |    2 
 example/service_ll.c  |    2 
 example/single_file.c |  105 +++++++++++++++
 6 files changed, 444 insertions(+), 4 deletions(-)
 create mode 100644 example/iomap_ll.c


diff --git a/example/single_file.h b/example/single_file.h
index 290dd6051ed6f5..a12389d69e33cc 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -45,6 +45,7 @@ static inline uint64_t howmany(uint64_t b, unsigned int align)
 }
 
 struct single_file {
+	int file_fd;
 	int backing_fd;
 
 	int64_t isize;
@@ -56,6 +57,7 @@ struct single_file {
 	bool allow_dio;
 	bool sync;
 	bool require_bdev;
+	bool uses_iomap;
 
 	unsigned int blocksize;
 
@@ -115,11 +117,13 @@ unsigned long long parse_num_blocks(const char *arg, int log_block_size);
 
 struct fuse_service;
 int single_file_service_open(struct fuse_service *sf, const char *path);
+int single_file_open(const char *path);
 
 void single_file_check_read(off_t pos, size_t *count);
 int single_file_check_write(off_t pos, size_t *count);
 
-int single_file_configure(const char *device, const char *filename);
+int single_file_configure(const char *device, mode_t expected_fmt,
+			  const char *filename);
 int single_file_configure_simple(const char *filename);
 void single_file_close(void);
 
diff --git a/example/iomap_ll.c b/example/iomap_ll.c
new file mode 100644
index 00000000000000..93199b80205c2d
--- /dev/null
+++ b/example/iomap_ll.c
@@ -0,0 +1,332 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2026 Oracle.
+ *
+ * This program can be distributed under the terms of the GNU GPLv2.
+ * See the file GPL2.txt.
+ */
+
+/** @file
+ *
+ * minimal example iomap filesystem using low-level API
+ *
+ * Compile with:
+ *
+ *     gcc -Wall single_file.c iomap_ll.c `pkg-config fuse3 --cflags --libs` -o iomap_ll
+ *
+ * Note: If the pkg-config command fails due to the absence of the fuse3.pc
+ *     file, you should configure the path to the fuse3.pc file in the
+ *     PKG_CONFIG_PATH variable.
+ *
+ * ## Source code ##
+ * \include iomap_ll.c
+ * \include single_file.c
+ * \include single_file.h
+ */
+
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 99)
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <fuse_lowlevel.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <assert.h>
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <linux/fs.h>
+#include <linux/stat.h>
+#define USE_SINGLE_FILE_LL_API
+#include "single_file.h"
+
+struct iomap_ll {
+	struct fuse_session *se;
+	char *device;
+
+	/* really booleans */
+	int debug;
+
+	int dev_index;
+};
+
+static struct iomap_ll ll = { };
+
+static void iomap_ll_init(void *userdata, struct fuse_conn_info *conn)
+{
+	(void)userdata;
+
+	if (fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		single_file.uses_iomap = true;
+	conn->time_gran = 1;
+}
+
+static int iomap_iomap_config_devices(void)
+{
+	int blocksize = single_file.blocksize;
+	int ret;
+
+	ll.dev_index = fuse_lowlevel_iomap_device_add(ll.se, single_file.backing_fd, 0);
+	if (ll.dev_index < 0) {
+		ret = -ll.dev_index;
+		printf("%s: cannot register iomap dev fd=%d: %s\n",
+		       ll.device, single_file.backing_fd, strerror(ret));
+		return ret;
+	}
+
+	ret = ioctl(single_file.backing_fd, BLKBSZSET, &blocksize);
+	if (ret) {
+		printf("%s: cannot set block size %u: %s\n",
+		       ll.device, single_file.blocksize, strerror(errno));
+		return errno;
+	}
+
+	return 0;
+}
+
+static void iomap_ll_iomap_config(fuse_req_t req,
+				  const struct fuse_iomap_config_params *p,
+				  size_t psize)
+{
+	struct fuse_iomap_config cfg = { };
+	int ret;
+
+	(void)p;
+	(void)psize;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg.s_blocksize = single_file.blocksize;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg.s_maxbytes = single_file.isize;
+
+	ret = iomap_iomap_config_devices();
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_iomap_config(req, &cfg);
+}
+
+static int iomap_begin_report(off_t pos, uint64_t count, uint32_t opflags,
+			      struct fuse_file_iomap *read)
+{
+	(void)pos;
+	(void)count;
+	(void)opflags;
+
+	read->offset = 0;
+	read->length = fsb_to_b(single_file.blocks);
+	read->addr = 0;
+	read->dev = ll.dev_index;
+	read->type = FUSE_IOMAP_TYPE_MAPPED;
+
+	return 0;
+}
+
+static int iomap_begin_read(off_t pos, uint64_t count, uint32_t opflags,
+			    struct fuse_file_iomap *read)
+{
+	return iomap_begin_report(pos, count, opflags, read);
+}
+
+static int iomap_begin_write(off_t pos, uint64_t count, uint32_t opflags,
+			     struct fuse_file_iomap *read)
+{
+	return iomap_begin_read(pos, count, opflags, read);
+}
+
+static void iomap_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
+				 uint64_t dontcare, off_t pos, uint64_t count,
+				 uint32_t opflags)
+{
+	struct fuse_file_iomap read;
+	int ret;
+
+	(void)dontcare;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr, "%s: pos 0x%llx count 0x%llx opflags 0x%x\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count,
+			opflags);
+
+	if (!single_file.allow_dio && (opflags & FUSE_IOMAP_OP_DIRECT)) {
+		ret = ENOSYS;
+		goto out_reply;
+	}
+
+	memset(&read, 0, sizeof(read));
+
+	pthread_mutex_lock(&single_file.lock);
+	if (opflags & FUSE_IOMAP_OP_REPORT)
+		ret = iomap_begin_report(pos, count, opflags, &read);
+	else if (fuse_iomap_is_write(opflags))
+		ret = iomap_begin_write(pos, count, opflags, &read);
+	else
+		ret = iomap_begin_read(pos, count, opflags, &read);
+	if (ret)
+		goto out_unlock;
+
+	if (ll.debug)
+		fprintf(stderr,
+			"%s: offset 0x%llx length 0x%llx type %u dev %u addr 0x%llx flags 0x%x\n",
+			__func__,
+			(unsigned long long)read.offset,
+			(unsigned long long)read.length,
+			read.type,
+			read.dev,
+			(unsigned long long)read.addr,
+			read.flags);
+
+	/* Not filling even the first byte will make the kernel unhappy. */
+	if (read.offset > pos || read.offset + read.length <= pos) {
+		printf("%s: made bad mapping at pos %llu\n", ll.device,
+		       (unsigned long long)pos);
+		ret = EIO;
+		goto out_unlock;
+	}
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_iomap_begin(req, &read, NULL);
+}
+
+static const struct fuse_lowlevel_ops iomap_ll_oper = {
+	.lookup		= single_file_ll_lookup,
+	.getattr	= single_file_ll_getattr,
+	.setattr	= single_file_ll_setattr,
+	.readdir	= single_file_ll_readdir,
+	.open		= single_file_ll_open,
+	.statfs		= single_file_ll_statfs,
+	.statx		= single_file_ll_statx,
+	.fsync		= single_file_ll_fsync,
+
+	.init		= iomap_ll_init,
+	.iomap_config	= iomap_ll_iomap_config,
+	.iomap_begin	= iomap_ll_iomap_begin,
+};
+
+#define IOMAP_LL_OPT(t, p, v) { t, offsetof(struct iomap_ll, p), v }
+
+static struct fuse_opt iomap_ll_opts[] = {
+	IOMAP_LL_OPT("debug",		debug,			1),
+	SINGLE_FILE_OPT_KEYS,
+	FUSE_OPT_END
+};
+
+static int iomap_ll_opt_proc(void *data, const char *arg,
+			    int key, struct fuse_args *outargs)
+{
+	if (single_file_opt_proc(data, arg, key, outargs) == 0)
+		return 0;
+
+	switch (key) {
+	case FUSE_OPT_KEY_NONOPT:
+		if (!ll.device) {
+			ll.device = strdup(arg);
+			return 0;
+		}
+		return 1;
+	}
+
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+	struct fuse_cmdline_opts opts = { };
+	int ret = 1;
+
+	if (fuse_opt_parse(&args, &ll, iomap_ll_opts, iomap_ll_opt_proc))
+		goto err_args;
+
+	if (fuse_parse_cmdline(&args, &opts))
+		goto err_args;
+
+	if (opts.show_help) {
+		printf("usage: %s [options] <device> <mountpoint>\n\n", argv[0]);
+		fuse_cmdline_help();
+		fuse_lowlevel_help();
+		ret = 0;
+		goto err_strings;
+	} else if (opts.show_version) {
+		printf("FUSE library version %s\n", fuse_pkgversion());
+		fuse_lowlevel_version();
+		ret = 0;
+		goto err_strings;
+	}
+
+	if (!opts.mountpoint || !ll.device) {
+		printf("usage: %s [options] <device> <mountpoint>\n", argv[0]);
+		printf("       %s --help\n", argv[0]);
+		goto err_strings;
+	}
+
+	if (single_file_open(ll.device))
+		goto err_strings;
+
+	if (single_file_configure(ll.device, S_IFBLK, "bdev"))
+		goto err_singlefile;
+
+	ll.se = fuse_session_new(&args, &iomap_ll_oper, sizeof(iomap_ll_oper),
+				 NULL);
+	if (ll.se == NULL)
+		goto err_singlefile;
+
+	if (fuse_set_signal_handlers(ll.se))
+		goto err_session;
+
+	if (fuse_session_mount(ll.se, opts.mountpoint))
+		goto err_signals;
+
+	fuse_daemonize(opts.foreground);
+
+	/* Block until ctrl+c or fusermount -u */
+	if (opts.singlethread) {
+		ret = fuse_session_loop(ll.se);
+	} else {
+		struct fuse_loop_config *config = fuse_loop_cfg_create();
+
+		if (!config) {
+			ret = 1;
+			goto err_mount;
+		}
+
+		fuse_loop_cfg_set_clone_fd(config, opts.clone_fd);
+		fuse_loop_cfg_set_max_threads(config, opts.max_threads);
+		ret = fuse_session_loop_mt(ll.se, config);
+		fuse_loop_cfg_destroy(config);
+	}
+
+err_mount:
+	fuse_session_unmount(ll.se);
+err_signals:
+	fuse_remove_signal_handlers(ll.se);
+err_session:
+	fuse_session_destroy(ll.se);
+err_singlefile:
+	single_file_close();
+err_strings:
+	free(opts.mountpoint);
+	free(ll.device);
+err_args:
+	fuse_opt_free_args(&args);
+	return ret ? 1 : 0;
+}
diff --git a/example/meson.build b/example/meson.build
index 45dbf26eb355a7..16eb256d7125d6 100644
--- a/example/meson.build
+++ b/example/meson.build
@@ -31,6 +31,7 @@ if platform.endswith('linux')
                    output: 'service_hl.socket',
                    configuration: private_cfg)
 
+    single_file_examples += [ 'iomap_ll' ]
 endif
 
 threaded_examples = [ 'notify_inval_inode',
diff --git a/example/service_hl.c b/example/service_hl.c
index ea041f670f2ec5..b270315e63e297 100644
--- a/example/service_hl.c
+++ b/example/service_hl.c
@@ -221,7 +221,7 @@ int main(int argc, char *argv[])
 	if (fuse_service_finish_file_requests(hl.service))
 		goto err_singlefile;
 
-	if (single_file_configure(hl.device, NULL))
+	if (single_file_configure(hl.device, 0, NULL))
 		goto err_singlefile;
 
 	fuse_service_expect_mount_format(hl.service, S_IFDIR);
diff --git a/example/service_ll.c b/example/service_ll.c
index 33a8bd48bc1215..f09e211ce6c393 100644
--- a/example/service_ll.c
+++ b/example/service_ll.c
@@ -274,7 +274,7 @@ int main(int argc, char *argv[])
 	if (fuse_service_finish_file_requests(ll.service))
 		goto err_singlefile;
 
-	if (single_file_configure(ll.device, NULL))
+	if (single_file_configure(ll.device, 0, NULL))
 		goto err_singlefile;
 
 	ll.se = fuse_session_new(&args, &service_ll_oper,
diff --git a/example/single_file.c b/example/single_file.c
index a962232d576e17..d4db4e90593cc7 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -29,6 +29,7 @@
 #include "fuse_lowlevel.h"
 #include "fuse.h"
 #include "fuse_service.h"
+#include "fuse_loopdev.h"
 #define USE_SINGLE_FILE_LL_API
 #define USE_SINGLE_FILE_HL_API
 #include "single_file.h"
@@ -48,6 +49,7 @@ struct dirbuf {
 
 struct single_file_stat {
 	struct fuse_entry_param entry;
+	unsigned int iflags;
 };
 
 #define SINGLE_FILE_INO		(FUSE_ROOT_ID + 1)
@@ -59,6 +61,7 @@ static struct timespec startup_time;
 struct single_file single_file = {
 	.backing_fd = -1,
 	.allow_dio = true,
+	.file_fd = -1,
 	.mode = S_IFREG | 0444,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 };
@@ -209,6 +212,14 @@ static bool sf_stat(fuse_ino_t ino, struct single_file_stat *llstat)
 	entry->entry_timeout = 0.0;
 	entry->ino = ino;
 
+	if (single_file.uses_iomap) {
+		llstat->iflags = FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
+		if (single_file.sync)
+			llstat->iflags |= FUSE_IFLAG_SYNC;
+		if (single_file.ro)
+			llstat->iflags |= FUSE_IFLAG_IMMUTABLE;
+	}
+
 	return true;
 }
 
@@ -396,6 +407,9 @@ void single_file_ll_getattr(fuse_req_t req, fuse_ino_t ino,
 	pthread_mutex_unlock(&single_file.lock);
 	if (!filled)
 		fuse_reply_err(req, ENOENT);
+	else if (single_file.uses_iomap)
+		fuse_reply_attr_iflags(req, &llstat.entry.attr, llstat.iflags,
+				       llstat.entry.attr_timeout);
 	else
 		fuse_reply_attr(req, &llstat.entry.attr,
 				llstat.entry.attr_timeout);
@@ -567,6 +581,8 @@ void single_file_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
 	pthread_mutex_unlock(&single_file.lock);
 	if (!filled)
 		fuse_reply_err(req, ENOENT);
+	else if (single_file.uses_iomap)
+		fuse_reply_entry_iflags(req, &llstat.entry, llstat.iflags);
 	else
 		fuse_reply_entry(req, &llstat.entry);
 }
@@ -756,6 +772,20 @@ int single_file_opt_proc(void *data, const char *arg, int key,
 	return 1;
 }
 
+int single_file_open(const char *path)
+{
+	const int open_flags = (single_file.ro ? O_RDONLY : O_RDWR) | O_EXCL;
+	int fd = open(path, open_flags);
+
+	if (fd < 0) {
+		perror(path);
+		return -1;
+	}
+
+	single_file.backing_fd = fd;
+	return 0;
+}
+
 int single_file_service_open(struct fuse_service *sf, const char *path)
 {
 	int open_flags = single_file.ro ? O_RDONLY : O_RDWR;
@@ -874,7 +904,51 @@ ssize_t single_file_pread(char *buf, size_t count, off_t pos)
 	return 0;
 }
 
-int single_file_configure(const char *device, const char *filename)
+static int check_fmt(mode_t expected_fmt, const struct stat *stbuf,
+		     const char *device)
+{
+	const char *type = NULL;
+
+	switch (expected_fmt) {
+	case S_IFREG:
+		type = "regular file";
+		break;
+	case S_IFDIR:
+		type = "directory";
+		break;
+	case S_IFLNK:
+		type = "symlink";
+		break;
+	case S_IFBLK:
+		type = "block device";
+		break;
+	case S_IFCHR:
+		type = "char device";
+		break;
+	case S_IFIFO:
+		type = "fifo";
+		break;
+	case S_IFSOCK:
+		type = "socket";
+		break;
+	case 0:
+		return 0;
+	default:
+		fprintf(stderr, "%s: unrecognized format 0o%o\n",
+			device, expected_fmt);
+		return -1;
+	}
+
+	if (expected_fmt != (stbuf->st_mode & S_IFMT)) {
+		fprintf(stderr, "%s: Not a %s\n", device, type);
+		return -1;
+	}
+
+	return 0;
+}
+
+int single_file_configure(const char *device, mode_t expected_fmt,
+			  const char *filename)
 {
 	struct stat stbuf;
 	unsigned long long backing_size;
@@ -887,9 +961,35 @@ int single_file_configure(const char *device, const char *filename)
 		perror(device);
 		return -1;
 	}
+
+	if (expected_fmt == S_IFBLK && !S_ISBLK(stbuf.st_mode)) {
+		int loop_fd = -1;
+
+		ret = fuse_loopdev_setup(single_file.backing_fd,
+					 (single_file.ro ? O_RDONLY : O_RDWR),
+					 device, 5, &loop_fd, NULL);
+		if (ret) {
+			fprintf(stderr, "%s: %s\n", device, strerror(-ret));
+			return -1;
+		}
+
+		single_file.file_fd = single_file.backing_fd;
+		single_file.backing_fd = loop_fd;
+
+		ret = fstat(single_file.backing_fd, &stbuf);
+		if (ret) {
+			perror(device);
+			return -1;
+		}
+	}
+
 	lbasize = stbuf.st_blksize;
 	backing_size = stbuf.st_size;
 
+	ret = check_fmt(expected_fmt, &stbuf, device);
+	if (ret)
+		return ret;
+
 	if (S_ISBLK(stbuf.st_mode)) {
 #ifdef BLKSSZGET
 		ret = ioctl(single_file.backing_fd, BLKSSZGET, &lbasize);
@@ -986,6 +1086,9 @@ void single_file_close(void)
 	close(single_file.backing_fd);
 	single_file.backing_fd = -1;
 
+	close(single_file.file_fd);
+	single_file.file_fd = -1;
+
 	if (single_file_name_set)
 		free((void *)single_file_name);
 	single_file_name_set = false;

