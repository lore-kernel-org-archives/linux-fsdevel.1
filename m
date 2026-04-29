Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCD30DEB2;
	Wed, 29 Apr 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474093; cv=none; b=UhlNEZNiL371YjbREuprakLep1y15ff5/ITa6tB5RllLSa6tCJ74ooFGm8/goKp5Q/jEfydZtfxdsL6kvwpiwUszz5XsMVSobY9bz9qP0q0szRK9+qM24VS9SQIFyFK9n7FNwKgbRHvvtExiEZ4j8kr4wgIf5KT/mqXYBR0FqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474093; c=relaxed/simple;
	bh=C4oRA+a9auVj2Lcmh2tAtxFD8Te62e+GCWtKP/VSICI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak12TOmV/KjXekXvw2wemLjoXiToCY5oor3T1gdXlTG6ojsu6aGhiHv5dAHCFQYf/0bW+rl9u955Ahpdg15c2HWnOyxz+iYMYf4P9re6QKwvdfq1hNgOJ2yQMjA3q881V/5mjiMM1HzvGU7trS+3UcgZIFJPTnPddrOnawuJTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4EZfYio; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4EZfYio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC1EC2BCC4;
	Wed, 29 Apr 2026 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474092;
	bh=C4oRA+a9auVj2Lcmh2tAtxFD8Te62e+GCWtKP/VSICI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=O4EZfYioH3uJwzeRReTa8oxNMJaLMJDjKwomaN61G/hKfdY1vtnyydAaOIJFacLgP
	 c12qu0E1YAzHQFp8EXFP3HjEQiUuPtFs2PjeRjBBQPBuVqa/H0xNenruZjYZuxIZXk
	 hRGga1WTw95aE0o9jh4V98pP7usdaMi28TTqo60TaqQ3GfgkpychGHXS67wkOPVSBN
	 syAtLZkQzHNMklFBx/vNbAo2/17PwnSveG/24CMjPpSD64eQ0OHkvsLhoyDz4/PXOJ
	 O4x9WF1+ByjC6YAbrIzUAh4LQsVSNsS/MRX9kQPUXGRdWiE5F22ius4nXYifK/KUJ1
	 TcreKVsnrYx4w==
Date: Wed, 29 Apr 2026 07:48:12 -0700
Subject: [PATCH 4/7] example/iomap_inline_ll: create a simple server to test
 inlinedata
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212949.4106066.1636493356110068891.stgit@frogsfrogsfrogs>
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

Create another example iomap fuse server to test inline data handling.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h     |    1 
 example/iomap_inline_ll.c |  367 +++++++++++++++++++++++++++++++++++++++++++++
 example/meson.build       |    2 
 example/single_file.c     |   26 ++-
 4 files changed, 389 insertions(+), 7 deletions(-)
 create mode 100644 example/iomap_inline_ll.c


diff --git a/example/single_file.h b/example/single_file.h
index 76f2cd6eb80529..90696a4d5a626a 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -58,6 +58,7 @@ struct single_file {
 	bool sync;
 	bool require_bdev;
 	bool uses_iomap;
+	bool fixed_size;
 
 	int awu_min, awu_max;
 	unsigned int blocksize;
diff --git a/example/iomap_inline_ll.c b/example/iomap_inline_ll.c
new file mode 100644
index 00000000000000..bed9855b72a27e
--- /dev/null
+++ b/example/iomap_inline_ll.c
@@ -0,0 +1,367 @@
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
+ * minimal example inlinedata iomap filesystem using low-level API
+ *
+ * Compile with:
+ *
+ *     gcc -Wall single_file.c iomap_inline_ll.c `pkg-config fuse3 --cflags --libs` \
+ *         -o iomap_inline_ll
+ *
+ * Note: If the pkg-config command fails due to the absence of the fuse3.pc
+ *     file, you should configure the path to the fuse3.pc file in the
+ *     PKG_CONFIG_PATH variable.
+ *
+ * ## Source code ##
+ * \include iomap_inline_ll.c
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
+#define max(x, y) ((x) > (y) ? (x) : (y))
+
+struct ioinline_ll {
+	struct fuse_session *se;
+
+	char *filedata;
+
+	/* really booleans */
+	int debug;
+};
+
+static struct ioinline_ll ll = { };
+
+static uint64_t ioinline_ll_calc_bfree(void)
+{
+	return single_file.isize == 0;
+}
+
+static void ioinline_ll_init(void *userdata, struct fuse_conn_info *conn)
+{
+	(void)userdata;
+
+	if (fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		single_file.uses_iomap = true;
+	conn->time_gran = 1;
+}
+
+static void ioinline_ll_iomap_config(fuse_req_t req,
+				     const struct fuse_iomap_config_params *p,
+				     size_t psize)
+{
+	struct fuse_iomap_config cfg = { };
+
+	(void)p;
+	(void)psize;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg.s_blocksize = single_file.blocksize;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg.s_maxbytes = single_file.blocksize;
+
+	fuse_reply_iomap_config(req, &cfg);
+}
+
+static int ioinline_begin_report(off_t pos, uint64_t count, uint32_t opflags,
+				 struct fuse_file_iomap *read)
+{
+	(void)pos;
+	(void)count;
+	(void)opflags;
+
+	read->offset = 0;
+	read->length = single_file.blocksize;
+	read->addr = FUSE_IOMAP_NULL_ADDR;
+	read->type = FUSE_IOMAP_TYPE_INLINE;
+
+	return 0;
+}
+
+static int ioinline_begin_read(off_t pos, uint64_t count, uint32_t opflags,
+			       struct fuse_file_iomap *read)
+{
+	return ioinline_begin_report(pos, count, opflags, read);
+}
+
+static int ioinline_begin_write(off_t pos, uint64_t count, uint32_t opflags,
+				struct fuse_file_iomap *read)
+{
+	return ioinline_begin_report(pos, count, opflags, read);
+}
+
+static void ioinline_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
+				    uint64_t dontcare, off_t pos,
+				    uint64_t count, uint32_t opflags)
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
+		ret = ioinline_begin_report(pos, count, opflags, &read);
+	else if (fuse_iomap_is_write(opflags))
+		ret = ioinline_begin_write(pos, count, opflags, &read);
+	else
+		ret = ioinline_begin_read(pos, count, opflags, &read);
+	if (ret)
+		goto out_unlock;
+
+	if (ll.debug)
+		fprintf(stderr,
+"%s: offset 0x%llx length 0x%llx type %u dev %u addr 0x%llx flags 0x%x\n",
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
+		printf("made bad mapping at pos %llu\n",
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
+static void ioinline_ll_read(fuse_req_t req, fuse_ino_t ino, size_t count,
+			     off_t pos, struct fuse_file_info *fp)
+{
+	int ret = 0;
+
+	(void)fp;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count);
+
+out_reply:
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_buf(req, ll.filedata + pos, count);
+}
+
+static void ioinline_ll_write(fuse_req_t req, fuse_ino_t ino, const char *buf,
+			      size_t count, off_t pos,
+			      struct fuse_file_info *fp)
+{
+	int ret = 0;
+
+	(void)fp;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count);
+
+	pthread_mutex_lock(&single_file.lock);
+	memcpy(ll.filedata + pos, buf, count);
+	single_file.isize = max(single_file.isize, pos + count);
+	pthread_mutex_unlock(&single_file.lock);
+
+out_reply:
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_write(req, count);
+}
+
+static const struct fuse_lowlevel_ops ioinline_ll_oper = {
+	.lookup		= single_file_ll_lookup,
+	.getattr	= single_file_ll_getattr,
+	.setattr	= single_file_ll_setattr,
+	.readdir	= single_file_ll_readdir,
+	.open		= single_file_ll_open,
+	.statfs		= single_file_ll_statfs,
+	.statx		= single_file_ll_statx,
+
+	.init		= ioinline_ll_init,
+	.iomap_config	= ioinline_ll_iomap_config,
+	.iomap_begin	= ioinline_ll_iomap_begin,
+	.read		= ioinline_ll_read,
+	.write		= ioinline_ll_write,
+};
+
+#define IOMAP_LL_OPT(t, p, v) { t, offsetof(struct ioinline_ll, p), v }
+
+static struct fuse_opt ioinline_ll_opts[] = {
+	IOMAP_LL_OPT("debug",		debug,			1),
+	SINGLE_FILE_OPT_KEYS,
+	FUSE_OPT_END
+};
+
+static int ioinline_ll_opt_proc(void *data, const char *arg,
+				int key, struct fuse_args *outargs)
+{
+	return single_file_opt_proc(data, arg, key, outargs);
+}
+
+static const struct single_file_ops fops = {
+	.calc_bfree		= ioinline_ll_calc_bfree,
+};
+
+int main(int argc, char *argv[])
+{
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+	struct fuse_cmdline_opts opts = { };
+	int ret = 1;
+
+	single_file.fixed_size = false;
+
+	if (fuse_opt_parse(&args, &ll, ioinline_ll_opts, ioinline_ll_opt_proc))
+		goto err_args;
+
+	if (fuse_parse_cmdline(&args, &opts))
+		goto err_args;
+
+	if (opts.show_help) {
+		printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
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
+	if (!opts.mountpoint) {
+		printf("usage: %s [options] <mountpoint>\n", argv[0]);
+		printf("       %s --help\n", argv[0]);
+		goto err_strings;
+	}
+
+	if (single_file_configure_simple("inline", &fops))
+		goto err_strings;
+
+	ll.filedata = malloc(single_file.blocksize);
+	if (!ll.filedata) {
+		perror("memory");
+		goto err_singlefile;
+	}
+	memset(ll.filedata, 0x58, single_file.blocksize);
+	single_file.blocks = 1;
+
+	ll.se = fuse_session_new(&args, &ioinline_ll_oper,
+				 sizeof(ioinline_ll_oper), NULL);
+	if (ll.se == NULL)
+		goto err_filedata;
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
+err_filedata:
+	free(ll.filedata);
+err_singlefile:
+	single_file_close();
+err_strings:
+	free(opts.mountpoint);
+err_args:
+	fuse_opt_free_args(&args);
+	return ret ? 1 : 0;
+}
diff --git a/example/meson.build b/example/meson.build
index 16eb256d7125d6..24fdcb23cb58f2 100644
--- a/example/meson.build
+++ b/example/meson.build
@@ -31,7 +31,7 @@ if platform.endswith('linux')
                    output: 'service_hl.socket',
                    configuration: private_cfg)
 
-    single_file_examples += [ 'iomap_ll' ]
+    single_file_examples += [ 'iomap_ll', 'iomap_inline_ll' ]
 endif
 
 threaded_examples = [ 'notify_inval_inode',
diff --git a/example/single_file.c b/example/single_file.c
index 401bdf7afae6c8..1d66157a8c637c 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -67,6 +67,7 @@ struct single_file single_file = {
 	.file_fd = -1,
 	.mode = S_IFREG | 0444,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
+	.fixed_size = true,
 };
 
 static fuse_ino_t single_file_path_to_ino(const char *path)
@@ -478,8 +479,9 @@ void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 
 	if (ino != SINGLE_FILE_INO)
 		goto deny;
-	if (to_set & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID |
-		      FUSE_SET_ATTR_SIZE))
+	if (to_set & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID))
+		goto deny;
+	if ((to_set & FUSE_SET_ATTR_SIZE) && single_file.fixed_size)
 		goto deny;
 	if (single_file.ro)
 		goto deny;
@@ -504,6 +506,8 @@ void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 	}
 	if (to_set & FUSE_SET_ATTR_CTIME)
 		single_file.ctime = now;
+	if (to_set & FUSE_SET_ATTR_SIZE)
+		single_file.isize = attr->st_size;
 	pthread_mutex_unlock(&single_file.lock);
 
 	single_file_ll_getattr(req, ino, fi);
@@ -581,11 +585,18 @@ int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
 int single_file_hl_truncate(const char *path, off_t len,
 			    struct fuse_file_info *fi)
 {
-	(void)path;
-	(void)len;
-	(void)fi;
+	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
 
-	return -EPERM;
+	if (ino != SINGLE_FILE_INO)
+		return -EPERM;
+	if (single_file.fixed_size)
+		return -EPERM;
+
+	pthread_mutex_lock(&single_file.lock);
+	single_file.isize = len;
+	pthread_mutex_unlock(&single_file.lock);
+
+	return 0;
 }
 
 void single_file_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
@@ -852,6 +863,9 @@ int single_file_service_open(struct fuse_service *sf, const char *path)
 
 int single_file_check_write(off_t pos, size_t *count)
 {
+	if (!single_file.fixed_size)
+		return 0;
+
 	if (pos >= single_file.isize)
 		return -EFBIG;
 

