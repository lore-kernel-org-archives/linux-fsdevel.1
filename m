Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0641E25F9;
	Wed, 29 Apr 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474140; cv=none; b=m5yln5otZwqmejxQ++JmiNbZFGGDbLVwqsMdTY/Kx+oERhcGajmr2kAgEdTOlytCiBpCgbKznlA9LHRFZI8KTOKdoS+Xw93MHsBJgUL7LxHgBE0p7GE5929eAa+Sd+RhvBPVhl/RrA9rZhBPa3fI7pAXKvqBiXny34IVq2zB7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474140; c=relaxed/simple;
	bh=/muQitrmSHZd3oxqqPMotBjmaZoBgfogXixMgrScUAU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAaF9OXOyKmMtTTn1AR0UckWz61Fe3L7nvCWQCxPLN6xK97WFG+UvQVna7ZN9OWdMI2fq1CqT2p8rAHXP+dvN9GIuA8wbwUB2IF/wnyuVyLeVheW8pcEHknA4zX3uwkPlm+cavpJntSBEswQ9plUVxJJ07IH7bFI4ujpP0LcpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrkxEdZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrkxEdZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B317DC19425;
	Wed, 29 Apr 2026 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474139;
	bh=/muQitrmSHZd3oxqqPMotBjmaZoBgfogXixMgrScUAU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UrkxEdZSOf5a/qJ0wNh9iMUpsdY2+f1tCbwCBROFVf48juPeBVC0q6JNHlzLsS9XX
	 882aqbcgRC6244SbhEvcFtJWiW9bvvf+Ie29xAz48TPSb4eDdEDArJC3ZwnyMmRVGD
	 JeYT1KzN+H78Z1khZIrWNW3/UlvG869YwKTB/1JrWu+bvjnNXId/2NpWDMddEXuIk4
	 jIG0tu02gk3jBFxXr24SIY2UTe8rvQNG9CJLEEKlVYBNw1hcTaLglSJKMaOl7HfXld
	 1Ae959VYDmv3i31plOT/HJdr0gr/CPdrymW8G6fTfvC5UjRcnechNlATRBhmvI1YXJ
	 RtaDkBAPX6BWQ==
Date: Wed, 29 Apr 2026 07:48:59 -0700
Subject: [PATCH 7/7] example/iomap_service_ll: create a sample systemd service
 fuse server
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213003.4106066.14060969262948225258.stgit@frogsfrogsfrogs>
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

Create a simple fuse server that can be run as a systemd service.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h              |    3 
 example/iomap_service_ll.c         |  377 ++++++++++++++++++++++++++++++++++++
 example/iomap_service_ll.socket.in |   15 +
 example/iomap_service_ll@.service  |  102 ++++++++++
 example/meson.build                |    7 +
 example/service_hl.c               |    2 
 example/service_ll.c               |    2 
 example/single_file.c              |    8 -
 8 files changed, 509 insertions(+), 7 deletions(-)
 create mode 100644 example/iomap_service_ll.c
 create mode 100644 example/iomap_service_ll.socket.in
 create mode 100644 example/iomap_service_ll@.service


diff --git a/example/single_file.h b/example/single_file.h
index 3ee9dd261352ba..edf8a424d02ec6 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -124,7 +124,8 @@ int single_file_opt_proc(void *data, const char *arg, int key,
 unsigned long long parse_num_blocks(const char *arg, int log_block_size);
 
 struct fuse_service;
-int single_file_service_open(struct fuse_service *sf, const char *path);
+int single_file_service_open(struct fuse_service *sf, const char *path,
+			     unsigned int request_flags);
 int single_file_open(const char *path);
 
 void single_file_check_read(off_t pos, size_t *count);
diff --git a/example/iomap_service_ll.c b/example/iomap_service_ll.c
new file mode 100644
index 00000000000000..c7b9e9c064a32d
--- /dev/null
+++ b/example/iomap_service_ll.c
@@ -0,0 +1,377 @@
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
+ * minimal example iomap filesystem using low-level API and systemd service api
+ *
+ * Compile with:
+ *
+ *     gcc -Wall single_file.c iomap_service_ll.c `pkg-config fuse3 --cflags --libs` \
+ *         -o iomap_service_ll
+ *
+ * Note: If the pkg-config command fails due to the absence of the fuse3.pc
+ *     file, you should configure the path to the fuse3.pc file in the
+ *     PKG_CONFIG_PATH variable.
+ *
+ * Change the ExecStart line in iomap_service_ll@.service:
+ *
+ *     ExecStart=/path/to/iomap_service_ll
+ *
+ * to point to the actual path of the iomap_service_ll binary.
+ *
+ * Finally, install the iomap_service_ll@.service and iomap_service_ll.socket files to the
+ * systemd service directory, usually /run/systemd/system.
+ *
+ * ## Source code ##
+ * \include iomap_service_ll.c
+ * \include iomap_service_ll.socket
+ * \include iomap_service_ll@.service
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
+#include <fuse_service.h>
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
+struct ioservice_ll {
+	struct fuse_session *se;
+	char *device;
+	struct fuse_service *service;
+
+	/* really booleans */
+	int debug;
+
+	int dev_index;
+};
+
+static struct ioservice_ll ll = { };
+
+static void ioservice_ll_init(void *userdata, struct fuse_conn_info *conn)
+{
+	(void)userdata;
+
+	if (fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		single_file.uses_iomap = true;
+	conn->time_gran = 1;
+}
+
+static int ioservice_iomap_config_devices(void)
+{
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
+	ret = fuse_lowlevel_iomap_set_blocksize(ll.se, ll.dev_index,
+						single_file.blocksize);
+	if (ret) {
+		printf("%s: cannot set block size %u: %s\n",
+		       ll.device, single_file.blocksize, strerror(errno));
+		return errno;
+	}
+
+	return 0;
+}
+
+static void ioservice_ll_iomap_config(fuse_req_t req,
+				      const struct fuse_iomap_config_params *p,
+				      size_t psize)
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
+	ret = ioservice_iomap_config_devices();
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_iomap_config(req, &cfg);
+}
+
+static int ioservice_begin_report(off_t pos, uint64_t count, uint32_t opflags,
+				  struct fuse_file_iomap *read)
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
+static int ioservice_begin_read(off_t pos, uint64_t count, uint32_t opflags,
+				struct fuse_file_iomap *read)
+{
+	return ioservice_begin_report(pos, count, opflags, read);
+}
+
+static int ioservice_begin_write(off_t pos, uint64_t count, uint32_t opflags,
+				 struct fuse_file_iomap *read)
+{
+	return ioservice_begin_read(pos, count, opflags, read);
+}
+
+static void ioservice_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
+				     uint64_t dontcare, off_t pos,
+				     uint64_t count, uint32_t opflags)
+{
+	struct fuse_file_iomap read;
+	int ret;
+
+	(void)dontcare;
+
+	if (ino != 2) {
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
+		ret = ioservice_begin_report(pos, count, opflags, &read);
+	else if (fuse_iomap_is_write(opflags))
+		ret = ioservice_begin_write(pos, count, opflags, &read);
+	else
+		ret = ioservice_begin_read(pos, count, opflags, &read);
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
+static const struct fuse_lowlevel_ops ioservice_ll_oper = {
+	.lookup		= single_file_ll_lookup,
+	.getattr	= single_file_ll_getattr,
+	.setattr	= single_file_ll_setattr,
+	.readdir	= single_file_ll_readdir,
+	.open		= single_file_ll_open,
+	.statfs		= single_file_ll_statfs,
+	.statx		= single_file_ll_statx,
+	.fsync		= single_file_ll_fsync,
+
+	.init		= ioservice_ll_init,
+	.iomap_config	= ioservice_ll_iomap_config,
+	.iomap_begin	= ioservice_ll_iomap_begin,
+};
+
+#define IOMAP_SERVICE_LL_OPT(t, p, v) { t, offsetof(struct ioservice_ll, p), v }
+
+static struct fuse_opt ioservice_ll_opts[] = {
+	IOMAP_SERVICE_LL_OPT("debug",		debug,			1),
+	SINGLE_FILE_OPT_KEYS,
+	FUSE_OPT_END
+};
+
+static int ioservice_ll_opt_proc(void *data, const char *arg, int key,
+				 struct fuse_args *outargs)
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
+	struct fuse_loop_config *config = NULL;
+	int error;
+	int ret = 1;
+
+	if (fuse_service_accept(&ll.service))
+		goto err_args;
+
+	if (!fuse_service_accepted(ll.service))
+		goto err_args;
+
+	if (fuse_service_append_args(ll.service, &args))
+		goto err_service;
+
+	if (fuse_opt_parse(&args, &ll, ioservice_ll_opts,
+			   ioservice_ll_opt_proc) != 0)
+		goto err_service;
+
+	if (fuse_service_parse_cmdline_opts(&args, &opts))
+		goto err_service;
+
+	if (opts.show_help) {
+		printf("usage: %s [options] <device> <mountpoint>\n\n", argv[0]);
+		fuse_cmdline_help();
+		fuse_lowlevel_help();
+		ret = 0;
+		goto err_service;
+	} else if (opts.show_version) {
+		printf("FUSE library version %s\n", fuse_pkgversion());
+		fuse_lowlevel_version();
+		ret = 0;
+		goto err_service;
+	}
+
+	if (!opts.mountpoint || !ll.device) {
+		printf("usage: %s [options] <device> <mountpoint>\n", argv[0]);
+		printf("       %s --help\n", argv[0]);
+		goto err_service;
+	}
+
+	if (single_file_service_open(ll.service, ll.device,
+				     FUSE_SERVICE_REQUEST_FILE_TRYLOOP))
+		goto err_service;
+
+	if (fuse_service_finish_file_requests(ll.service))
+		goto err_singlefile;
+
+	if (fuse_service_configure_iomap(ll.service, true, &error))
+		goto err_singlefile;
+	if (error) {
+		fprintf(stderr, "%s: mount helper could not enable iomap: %s\n",
+		       ll.device, strerror(error));
+		goto err_singlefile;
+	}
+
+	if (single_file_configure(ll.device, S_IFBLK, "svc_bdev", NULL))
+		goto err_singlefile;
+
+	ll.se = fuse_session_new(&args, &ioservice_ll_oper,
+				 sizeof(ioservice_ll_oper), NULL);
+	if (ll.se == NULL)
+		goto err_singlefile;
+
+	if (!opts.singlethread) {
+		config = fuse_loop_cfg_create();
+		if (!config) {
+			ret = 1;
+			goto err_session;
+		}
+	}
+
+	if (fuse_set_signal_handlers(ll.se))
+		goto err_loopcfg;
+
+	if (fuse_service_session_mount(ll.service, ll.se, S_IFDIR, &opts))
+		goto err_signals;
+
+	/* Block until ctrl+c or fusermount -u */
+	if (opts.singlethread) {
+		fuse_service_send_goodbye(ll.service, 0);
+		fuse_service_release(ll.service);
+
+		ret = fuse_session_loop(ll.se);
+	} else {
+		fuse_loop_cfg_set_clone_fd(config, opts.clone_fd);
+		fuse_loop_cfg_set_max_threads(config, opts.max_threads);
+
+		fuse_service_send_goodbye(ll.service, 0);
+		fuse_service_release(ll.service);
+
+		ret = fuse_session_loop_mt(ll.se, config);
+	}
+
+err_signals:
+	fuse_remove_signal_handlers(ll.se);
+err_loopcfg:
+	fuse_loop_cfg_destroy(config);
+err_session:
+	fuse_session_destroy(ll.se);
+err_singlefile:
+	single_file_close();
+err_service:
+	free(opts.mountpoint);
+	free(ll.device);
+	fuse_service_send_goodbye(ll.service, ret);
+	fuse_service_destroy(&ll.service);
+err_args:
+	fuse_opt_free_args(&args);
+	return fuse_service_exit(ret);
+}
diff --git a/example/iomap_service_ll.socket.in b/example/iomap_service_ll.socket.in
new file mode 100644
index 00000000000000..690064fa493522
--- /dev/null
+++ b/example/iomap_service_ll.socket.in
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Oracle.  All Rights Reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+[Unit]
+Description=Socket for iomap_service_ll Service
+
+[Socket]
+ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/iomap_service_ll
+Accept=yes
+SocketMode=@FUSE_SERVICE_SOCKET_PERMS@
+RemoveOnStop=yes
+
+[Install]
+WantedBy=sockets.target
diff --git a/example/iomap_service_ll@.service b/example/iomap_service_ll@.service
new file mode 100644
index 00000000000000..67d4a21acc89b4
--- /dev/null
+++ b/example/iomap_service_ll@.service
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Oracle.  All Rights Reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+[Unit]
+Description=iomap_service_ll Sample Fuse Service
+
+# Don't leave failed units behind, systemd does not clean them up!
+CollectMode=inactive-or-failed
+
+[Service]
+Type=exec
+ExecStart=/path/to/iomap_service_ll
+
+# Try to capture core dumps
+LimitCORE=infinity
+
+SyslogIdentifier=%N
+
+# No realtime CPU scheduling
+RestrictRealtime=true
+
+# Don't let us see anything in the regular system, and don't run as root
+DynamicUser=true
+ProtectSystem=strict
+ProtectHome=true
+PrivateTmp=true
+PrivateDevices=true
+PrivateUsers=true
+
+# No network access
+PrivateNetwork=true
+ProtectHostname=true
+RestrictAddressFamilies=none
+IPAddressDeny=any
+
+# Don't let the program mess with the kernel configuration at all
+ProtectKernelLogs=true
+ProtectKernelModules=true
+ProtectKernelTunables=true
+ProtectControlGroups=true
+ProtectProc=invisible
+RestrictNamespaces=true
+RestrictFileSystems=
+
+# Hide everything in /proc, even /proc/mounts
+ProcSubset=pid
+
+# Only allow the default personality Linux
+LockPersonality=true
+
+# No writable memory pages
+MemoryDenyWriteExecute=true
+
+# Don't let our mounts leak out to the host
+PrivateMounts=true
+
+# Restrict system calls to the native arch and only enough to get things going
+SystemCallArchitectures=native
+SystemCallFilter=@system-service
+SystemCallFilter=~@privileged
+SystemCallFilter=~@resources
+
+SystemCallFilter=~@clock
+SystemCallFilter=~@cpu-emulation
+SystemCallFilter=~@debug
+SystemCallFilter=~@module
+SystemCallFilter=~@reboot
+SystemCallFilter=~@swap
+
+SystemCallFilter=~@mount
+
+# libfuse io_uring wants to pin cores and memory
+SystemCallFilter=mbind
+SystemCallFilter=sched_setaffinity
+
+# Leave a breadcrumb if we get whacked by the system call filter
+SystemCallErrorNumber=EL3RST
+
+# Log to the kernel dmesg, just like an in-kernel filesystem driver
+StandardOutput=append:/dev/ttyprintk
+StandardError=append:/dev/ttyprintk
+
+# Run with no capabilities at all
+CapabilityBoundingSet=
+AmbientCapabilities=
+NoNewPrivileges=true
+
+# We don't create files
+UMask=7777
+
+# No access to hardware /dev files at all
+ProtectClock=true
+DevicePolicy=closed
+
+# Don't mess with set[ug]id anything.
+RestrictSUIDSGID=true
+
+# Don't let OOM kills of processes in this containment group kill the whole
+# service, because we don't want filesystem drivers to go down.
+OOMPolicy=continue
+OOMScoreAdjust=-1000
diff --git a/example/meson.build b/example/meson.build
index 6967a2ee370d4b..06af406d0c909a 100644
--- a/example/meson.build
+++ b/example/meson.build
@@ -31,7 +31,12 @@ if platform.endswith('linux')
                    output: 'service_hl.socket',
                    configuration: private_cfg)
 
-    single_file_examples += [ 'iomap_ll', 'iomap_inline_ll', 'iomap_ow_ll' ]
+    single_file_examples += [ 'iomap_ll', 'iomap_inline_ll', 'iomap_ow_ll',
+                  'iomap_service_ll']
+
+    configure_file(input: 'iomap_service_ll.socket.in',
+                   output: 'iomap_service_ll.socket',
+                   configuration: private_cfg)
 endif
 
 threaded_examples = [ 'notify_inval_inode',
diff --git a/example/service_hl.c b/example/service_hl.c
index db92dbb9b611b3..4964df411b0e23 100644
--- a/example/service_hl.c
+++ b/example/service_hl.c
@@ -215,7 +215,7 @@ int main(int argc, char *argv[])
 		goto err_service;
 	}
 
-	if (single_file_service_open(hl.service, hl.device))
+	if (single_file_service_open(hl.service, hl.device, 0))
 		goto err_service;
 
 	if (fuse_service_finish_file_requests(hl.service))
diff --git a/example/service_ll.c b/example/service_ll.c
index eb3d77c639f705..e7bed0deb69c11 100644
--- a/example/service_ll.c
+++ b/example/service_ll.c
@@ -268,7 +268,7 @@ int main(int argc, char *argv[])
 		goto err_service;
 	}
 
-	if (single_file_service_open(ll.service, ll.device))
+	if (single_file_service_open(ll.service, ll.device, 0))
 		goto err_service;
 
 	if (fuse_service_finish_file_requests(ll.service))
diff --git a/example/single_file.c b/example/single_file.c
index c4ac998a2c978b..49c3e857b130f8 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -823,7 +823,8 @@ int single_file_open(const char *path)
 	return 0;
 }
 
-int single_file_service_open(struct fuse_service *sf, const char *path)
+int single_file_service_open(struct fuse_service *sf, const char *path,
+			     unsigned int request_flags)
 {
 	int open_flags = single_file.ro ? O_RDONLY : O_RDWR;
 	int fd;
@@ -832,11 +833,12 @@ int single_file_service_open(struct fuse_service *sf, const char *path)
 again:
 	if (single_file.require_bdev)
 		ret = fuse_service_request_blockdev(sf, path,
-						    open_flags | O_EXCL, 0, 0,
+						    open_flags | O_EXCL, 0,
+						    request_flags,
 						    single_file.blocksize);
 	else
 		ret = fuse_service_request_file(sf, path, open_flags | O_EXCL,
-						0, 0);
+						0, request_flags);
 	if (ret)
 		return ret;
 

