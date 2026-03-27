Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D6ECA45
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574718; cv=none; b=jgo3NK1Q2TWgdi7HTCM6WP9KVvaMFpZdSKIYXSl+5/ozgl8ybGbf7Q2wXqKnx6bsI7gFy90pFu7Emy3k9wsrYu2VF01MRHYmUhgQG0jIdYuXvdxHNdIYoeqXa8YanIzglwglEUl+t1Bfb0dIoBBI5SwVTsgqdqMHoDjRx9I0QPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574718; c=relaxed/simple;
	bh=aXWaJpZZ+XvoXkKXKsZzt8qAwSu8JSbBlMGAcUKhm/Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj9GZhhpnZqebds8gO6ApqAqBx4mRRXXanviTMZvq9H5KAQecIP61M9V7zhu2q+crc+ju2hWxHELL+01gc2QWWLAYe27Svk40dlaw3jX8x9815IS00F3U9708HtbkAImJUdcHh4OOLjqIz1Cke8K9wzLt3Y4jHBL6Mhs87qzPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU1bl6n9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU1bl6n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2ECC116C6;
	Fri, 27 Mar 2026 01:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574718;
	bh=aXWaJpZZ+XvoXkKXKsZzt8qAwSu8JSbBlMGAcUKhm/Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dU1bl6n9iO1tG2nEsddL2/YFhHN/t1AtW4QZMe4gkdY+c3VJYnPdjGePTRLlx0e4E
	 sBrcEmYtt8Cc/pDn8+g31wq/9rjjRh41szRqc46D/ZXtbv9kwudAv9UuMuqpL2Ym4v
	 /nBHZOL9MVzckEE+lTK2dB1GpVAgqWop275PFT7EXo8N82ht3SAUkQYmSOPAIBJreB
	 oJZDiWhE9HiBk+OAxNpi6npOZcDlGJ7OxjtXiKNaem4kw5QPKMCiGrYarlYEErie6H
	 MqstesybO9vyE/lRvgrUiFDAHWtj9HV228UxOhEO1mzoDDqf7x1PGrgbZbzhCjlxaK
	 KzYCHqtQWC/Hw==
Date: Thu, 26 Mar 2026 18:25:17 -0700
Subject: [PATCH 02/17] mount_service: add systemd/inetd socket service
 mounting helper
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463153.1008428.10871096687728734372.stgit@frogsfrogsfrogs>
In-Reply-To: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a mount helper program that can start a fuse server that runs as
a socket-based systemd service, and a new libfuse module to wrap all the
details of communicating between the mount helper and the containerized
fuse server.

This enables untrusted ext4 mounts via systemd service containers, which
avoids the problem of malicious filesystems compromising the integrity
of the running kernel through memory corruption.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service.h                      |  215 +++++
 include/fuse_service_priv.h                 |  127 +++
 lib/mount_common_i.h                        |    3 
 util/mount_service.h                        |   32 +
 .github/workflows/abicheck.yml              |    2 
 .github/workflows/abicheck_prev_release.yml |    2 
 .github/workflows/pr-ci.yml                 |    2 
 doc/fuservicemount3.8                       |   24 +
 doc/meson.build                             |    3 
 include/meson.build                         |    4 
 lib/fuse_service.c                          |  989 +++++++++++++++++++++++++
 lib/fuse_service_stub.c                     |   96 ++
 lib/fuse_versionscript                      |   16 
 lib/helper.c                                |   53 +
 lib/meson.build                             |   16 
 lib/mount.c                                 |   12 
 meson.build                                 |   29 +
 meson_options.txt                           |    6 
 util/fuservicemount.c                       |   18 
 util/meson.build                            |    9 
 util/mount_service.c                        | 1088 +++++++++++++++++++++++++++
 21 files changed, 2741 insertions(+), 5 deletions(-)
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c


diff --git a/include/fuse_service.h b/include/fuse_service.h
new file mode 100644
index 00000000000000..f0a4e63b2f11a7
--- /dev/null
+++ b/include/fuse_service.h
@@ -0,0 +1,215 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt.
+ */
+#ifndef FUSE_SERVICE_H_
+#define FUSE_SERVICE_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
+
+struct fuse_service;
+
+/**
+ * Accept a socket created by mount.service for information exchange.
+ *
+ * @param sfp pointer to pointer to a service context.  The pointer will always
+ *            be initialized by this function; use fuse_service_accepted to
+ *            find out if the fuse server is actually running as a service.
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_accept(struct fuse_service **sfp);
+
+/**
+ * Has the fuse server accepted a service context?
+ *
+ * @param sf service context
+ * @return true if it has, false if not
+ */
+static inline bool fuse_service_accepted(struct fuse_service *sf)
+{
+	return sf != NULL;
+}
+
+/**
+ * Will the mount service helper accept the allow_other option?
+ *
+ * @param sf service context
+ * @return true if it has, false if not
+ */
+bool fuse_service_can_allow_other(struct fuse_service *sf);
+
+/**
+ * Release all resources associated with the service context.
+ *
+ * @param sfp service context
+ */
+void fuse_service_release(struct fuse_service *sf);
+
+/**
+ * Destroy a service context and release all resources
+ *
+ * @param sfp pointer to pointer to a service context
+ */
+void fuse_service_destroy(struct fuse_service **sfp);
+
+/**
+ * Append the command line arguments from the mount service helper to an
+ * existing fuse_args structure.  The fuse_args should have been initialized
+ * with the argc and argv passed to main().
+ *
+ * @param sfp service context
+ * @param args arguments to modify (input+output)
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_append_args(struct fuse_service *sf, struct fuse_args *args);
+
+/**
+ * Generate the effective fuse server command line from the args structure.
+ * The args structure should be the outcome from fuse_service_append_args.
+ * The resulting string is suitable for setproctitle and must be freed by the
+ * callre.
+ *
+ * @param argc argument count passed to main()
+ * @param argv argument vector passed to main()
+ * @param args fuse args structure
+ * @return effective command line string, or NULL
+ */
+char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args);
+
+struct fuse_cmdline_opts;
+
+/**
+ * Utility function to parse common options for simple file systems
+ * using the low-level API. A help text that describes the available
+ * options can be printed with `fuse_cmdline_help`. A single
+ * non-option argument is treated as the mountpoint. Multiple
+ * non-option arguments will result in an error.
+ *
+ * If neither -o subtype= or -o fsname= options are given, a new
+ * subtype option will be added and set to the basename of the program
+ * (the fsname will remain unset, and then defaults to "fuse").
+ *
+ * Known options will be removed from *args*, unknown options will
+ * remain. The mountpoint will not be checked here; that is the job of
+ * mount.service.
+ *
+ * @param args argument vector (input+output)
+ * @param opts output argument for parsed options
+ * @return 0 on success, -1 on failure
+ */
+int fuse_service_parse_cmdline_opts(struct fuse_args *args,
+				    struct fuse_cmdline_opts *opts);
+
+/**
+ * Ask the mount.service helper to open a file on behalf of the fuse server.
+ *
+ * @param sf service context
+ * @param path the path to file
+ * @param open_flags O_ flags
+ * @param create_mode mode with which to create the file
+ * @param request_flags set of FUSE_SERVICE_REQUEST_* flags
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_request_file(struct fuse_service *sf, const char *path,
+			      int open_flags, mode_t create_mode,
+			      unsigned int request_flags);
+
+/**
+ * Ask the mount.service helper to open a block device on behalf of the fuse
+ * server.
+ *
+ * @param sf service context
+ * @param path the path to file
+ * @param open_flags O_ flags
+ * @param create_mode mode with which to create the file
+ * @param request_flags set of FUSE_SERVICE_REQUEST_* flags
+ * @param block_size set the block device block size to this value
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
+				  int open_flags, mode_t create_mode,
+				  unsigned int request_flags,
+				  unsigned int block_size);
+
+/**
+ * Receive a file previously requested.
+ *
+ * @param sf service context
+ * @param path to file
+ * @fdp pointer to file descriptor, which will be set a non-negative file
+ *      descriptor value on success, or negative errno on failure
+ * @return 0 on success, or negative errno on socket communication failure
+ */
+int fuse_service_receive_file(struct fuse_service *sf,
+			      const char *path, int *fdp);
+
+/**
+ * Prevent the mount.service server from sending us any more open files.
+ *
+ * @param sf service context
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_finish_file_requests(struct fuse_service *sf);
+
+/**
+ * Require that the filesystem mount point have the expected file format
+ * (S_IFDIR/S_IFREG).  Can be overridden when calling
+ * fuse_service_session_mount.
+ *
+ * @param sf service context
+ * @param expected_fmt expected mode (S_IFDIR/S_IFREG) for mount point, or 0
+ *                     to skip checks
+ */
+void fuse_service_expect_mount_mode(struct fuse_service *sf,
+				    mode_t expected_fmt);
+
+/**
+ * Bind a FUSE file system to the fuse session inside a fuse service process,
+ * then ask the mount.service helper to mount the filesystem for us.  The fuse
+ * client will begin sending requests to the fuse server immediately after
+ * this.
+ *
+ * @param sf service context
+ * @param se fuse session
+ * @param expected_fmt expected mode (S_IFDIR/S_IFREG) for mount point, or 0
+ *                     to skip checks
+ * @param opts command line options
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
+			       mode_t expected_fmt,
+			       struct fuse_cmdline_opts *opts);
+
+/**
+ * Bid farewell to the mount.service helper.  It is still necessary to call
+ * fuse_service_destroy after this.
+ *
+ * @param sf service context
+ * @param exitcode fuse server process exit status
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_send_goodbye(struct fuse_service *sf, int exitcode);
+
+/**
+ * Exit routine for a fuse server running as a systemd service.
+ *
+ * @param ret 0 for success, nonzero for service failure.
+ * @return a value to be passed to exit() or returned from main
+ */
+int fuse_service_exit(int ret);
+
+#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* FUSE_SERVICE_H_ */
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
new file mode 100644
index 00000000000000..d1fdd6221b5268
--- /dev/null
+++ b/include/fuse_service_priv.h
@@ -0,0 +1,127 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt.
+ */
+#ifndef FUSE_SERVICE_PRIV_H_
+#define FUSE_SERVICE_PRIV_H_
+
+/* All numeric fields are network order (big-endian) when going across the socket */
+
+struct fuse_service_memfd_arg {
+	uint32_t pos;
+	uint32_t len;
+};
+
+struct fuse_service_memfd_argv {
+	uint32_t magic;
+	uint32_t argc;
+};
+
+#define FUSE_SERVICE_ARGS_MAGIC		0x41524753	/* ARGS */
+
+/* mount.service sends a hello to the server and it replies */
+#define FUSE_SERVICE_HELLO_CMD		0x53414654	/* SAFT */
+#define FUSE_SERVICE_HELLO_REPLY	0x4c415354	/* LAST */
+
+/* fuse servers send commands to mount.service */
+#define FUSE_SERVICE_OPEN_CMD		0x4f50454e	/* OPEN */
+#define FUSE_SERVICE_OPEN_BDEV_CMD	0x42444556	/* BDEV */
+#define FUSE_SERVICE_FSOPEN_CMD		0x54595045	/* TYPE */
+#define FUSE_SERVICE_SOURCE_CMD		0x4e414d45	/* NAME */
+#define FUSE_SERVICE_MNTOPTS_CMD	0x4f505453	/* OPTS */
+#define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
+#define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
+#define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
+
+/* mount.service sends replies to the fuse server */
+#define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
+#define FUSE_SERVICE_SIMPLE_REPLY	0x5245504c	/* REPL */
+
+struct fuse_service_packet {
+	uint32_t magic;			/* FUSE_SERVICE_*_{CMD,REPLY} */
+};
+
+#define FUSE_SERVICE_PROTO	(1)
+#define FUSE_SERVICE_MIN_PROTO	(1)
+#define FUSE_SERVICE_MAX_PROTO	(1)
+
+#define FUSE_SERVICE_FLAG_ALLOW_OTHER	(1U << 0)
+
+#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER)
+
+struct fuse_service_hello {
+	struct fuse_service_packet p;
+	uint16_t min_version;
+	uint16_t max_version;
+	uint32_t flags;
+};
+
+struct fuse_service_hello_reply {
+	struct fuse_service_packet p;
+	uint16_t version;
+};
+
+struct fuse_service_simple_reply {
+	struct fuse_service_packet p;
+	uint32_t error;			/* positive errno */
+};
+
+struct fuse_service_requested_file {
+	struct fuse_service_packet p;
+	uint32_t error;			/* positive errno */
+	char path[];
+};
+
+static inline size_t sizeof_fuse_service_requested_file(size_t pathlen)
+{
+	return sizeof(struct fuse_service_requested_file) + pathlen + 1;
+}
+
+#define FUSE_SERVICE_OPEN_FLAGS		(0)
+
+struct fuse_service_open_command {
+	struct fuse_service_packet p;
+	uint32_t open_flags;
+	uint32_t create_mode;
+	uint32_t request_flags;
+	uint32_t block_size;
+	char path[];
+};
+
+static inline size_t sizeof_fuse_service_open_command(size_t pathlen)
+{
+	return sizeof(struct fuse_service_open_command) + pathlen + 1;
+}
+
+struct fuse_service_string_command {
+	struct fuse_service_packet p;
+	char value[];
+};
+
+static inline size_t sizeof_fuse_service_string_command(size_t len)
+{
+	return sizeof(struct fuse_service_string_command) + len + 1;
+}
+
+struct fuse_service_bye_command {
+	struct fuse_service_packet p;
+	uint32_t exitcode;
+};
+
+struct fuse_service_mount_command {
+	struct fuse_service_packet p;
+	uint32_t ms_flags;
+	uint16_t expected_fmt;
+};
+
+int fuse_parse_cmdline_service(struct fuse_args *args,
+				 struct fuse_cmdline_opts *opts);
+
+#define FUSE_SERVICE_ARGV	"argv"
+#define FUSE_SERVICE_FUSEDEV	"fusedev"
+
+#endif /* FUSE_SERVICE_PRIV_H_ */
diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
index 6bcb055ff1c23f..631dff3e6f8aaf 100644
--- a/lib/mount_common_i.h
+++ b/lib/mount_common_i.h
@@ -14,5 +14,8 @@ struct mount_opts;
 
 char *fuse_mnt_build_source(const struct mount_opts *mo);
 char *fuse_mnt_build_type(const struct mount_opts *mo);
+char *fuse_mnt_kernel_opts(const struct mount_opts *mo);
+unsigned int fuse_mnt_flags(const struct mount_opts *mo);
+
 
 #endif /* FUSE_MOUNT_COMMON_I_H_ */
diff --git a/util/mount_service.h b/util/mount_service.h
new file mode 100644
index 00000000000000..2b670c5569aa88
--- /dev/null
+++ b/util/mount_service.h
@@ -0,0 +1,32 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * This program can be distributed under the terms of the GNU GPLv2.
+ * See the file GPL2.txt.
+ */
+#ifndef MOUNT_SERVICE_H_
+#define MOUNT_SERVICE_H_
+
+/**
+ * Connect to a fuse service socket and try to mount the filesystem as
+ * specified with the CLI arguments.
+ *
+ * @argc argument count
+ * @argv vector of argument strings
+ * @return EXIT_SUCCESS for success, EXIT_FAILURE if mount fails
+ */
+int mount_service_main(int argc, char *argv[]);
+
+/**
+ * Return the fuse filesystem subtype from a full fuse filesystem type
+ * specification.  IOWs, fuse.Y -> Y; fuseblk.Z -> Z; or A -> A.  The returned
+ * pointer is within the caller's string.
+ *
+ * @param fstype full fuse filesystem type
+ * @return fuse subtype
+ */
+const char *mount_service_subtype(const char *fstype);
+
+#endif /* MOUNT_SERVICE_H_ */
diff --git a/.github/workflows/abicheck.yml b/.github/workflows/abicheck.yml
index b4bcdad08bd4b7..872d0455cffd93 100644
--- a/.github/workflows/abicheck.yml
+++ b/.github/workflows/abicheck.yml
@@ -26,7 +26,7 @@ jobs:
         if: runner.os == 'Linux'
         run: |
           sudo apt-get update
-          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev
+          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev libsystemd-dev systemd-dev
 
       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
         with:
diff --git a/.github/workflows/abicheck_prev_release.yml b/.github/workflows/abicheck_prev_release.yml
index d619806613deb9..8545b3a85776ef 100644
--- a/.github/workflows/abicheck_prev_release.yml
+++ b/.github/workflows/abicheck_prev_release.yml
@@ -26,7 +26,7 @@ jobs:
         if: runner.os == 'Linux'
         run: |
           sudo apt-get update
-          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev
+          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev libsystemd-dev systemd-dev
 
       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
         with:
diff --git a/.github/workflows/pr-ci.yml b/.github/workflows/pr-ci.yml
index 9f7bef9f1c0d24..0cd8c741544e7d 100644
--- a/.github/workflows/pr-ci.yml
+++ b/.github/workflows/pr-ci.yml
@@ -32,7 +32,7 @@ jobs:
           sudo apt-get install -y clang doxygen gcc gcc-10 gcc-9 valgrind \
             gcc-multilib g++-multilib libc6-dev-i386 \
             libpcap0.8-dev:i386 libudev-dev:i386 pkg-config:i386 \
-            liburing-dev libnuma-dev
+            liburing-dev libnuma-dev libsystemd-dev systemd-dev
       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
       - uses: actions/setup-python@v6
         with:
diff --git a/doc/fuservicemount3.8 b/doc/fuservicemount3.8
new file mode 100644
index 00000000000000..e45d6a89c8b81a
--- /dev/null
+++ b/doc/fuservicemount3.8
@@ -0,0 +1,24 @@
+.TH fuservicemount3 "8"
+.SH NAME
+fuservicemount3 \- mount a FUSE filesystem that runs as a system socket service
+.SH SYNOPSIS
+.B fuservicemount3
+.B source
+.B mountpoint
+.BI -t " fstype"
+[
+.I options
+]
+.SH DESCRIPTION
+Mount a filesystem using a FUSE server that runs as a socket service.
+These servers can be contained using the platform's service management
+framework.
+.SH "AUTHORS"
+.LP
+The author of the fuse socket service code is Darrick J. Wong <djwong@kernel.org>.
+Debian GNU/Linux distribution.
+.SH SEE ALSO
+.BR fusermount3 (1)
+.BR fusermount (1)
+.BR mount (8)
+.BR fuse (4)
diff --git a/doc/meson.build b/doc/meson.build
index db3e0b26f71975..c105cf3471fdf4 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -2,3 +2,6 @@ if not platform.endswith('bsd') and platform != 'dragonfly'
   install_man('fusermount3.1', 'mount.fuse3.8')
 endif
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  install_man('fuservicemount3.8')
+endif
diff --git a/include/meson.build b/include/meson.build
index bf671977a5a6a9..da51180f87eea2 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -1,4 +1,8 @@
 libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
 	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  libfuse_headers += [ 'fuse_service.h' ]
+endif
+
 install_headers(libfuse_headers, subdir: 'fuse3')
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
new file mode 100644
index 00000000000000..795453693da09b
--- /dev/null
+++ b/lib/fuse_service.c
@@ -0,0 +1,989 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * Library functions to support fuse servers that can be run as "safe" systemd
+ * containers.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt
+ */
+
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <systemd/sd-daemon.h>
+#include <arpa/inet.h>
+
+#include "fuse_config.h"
+#include "fuse_i.h"
+#include "fuse_service_priv.h"
+#include "fuse_service.h"
+#include "mount_common_i.h"
+
+struct fuse_service {
+	/* expected file format of the mount point */
+	mode_t expected_fmt;
+
+	/* socket fd */
+	int sockfd;
+
+	/* /dev/fuse device */
+	int fusedevfd;
+
+	/* memfd for cli arguments */
+	int argvfd;
+
+	/* do we own fusedevfd? */
+	bool owns_fusedevfd;
+
+	/* can we use allow_other? */
+	bool allow_other;
+};
+
+static int __recv_fd(int sockfd, struct fuse_service_requested_file *buf,
+		     ssize_t bufsize, int *fdp)
+{
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = bufsize,
+	};
+	union {
+		struct cmsghdr cmsghdr;
+		char control[CMSG_SPACE(sizeof(int))];
+	} cmsgu;
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgu.control,
+		.msg_controllen = sizeof(cmsgu.control),
+	};
+	struct cmsghdr *cmsg;
+	ssize_t size;
+
+	memset(&cmsgu, 0, sizeof(cmsgu));
+
+	size = recvmsg(sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service file reply: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (size > bufsize ||
+	    size < offsetof(struct fuse_service_requested_file, path)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: wrong service file reply size %zd, expected %zd\n",
+			 size, bufsize);
+		return -EBADMSG;
+	}
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!cmsg) {
+		/* no control message means mount.service sent us an error */
+		return 0;
+	}
+	if (cmsg->cmsg_len != CMSG_LEN(sizeof(int))) {
+		fuse_log(FUSE_LOG_ERR,
+			 "fuse: wrong service file reply control data size %zd, expected %zd\n",
+			 cmsg->cmsg_len, CMSG_LEN(sizeof(int)));
+		return -EBADMSG;
+	}
+	if (cmsg->cmsg_level != SOL_SOCKET || cmsg->cmsg_type != SCM_RIGHTS) {
+		fuse_log(FUSE_LOG_ERR,
+"fuse: wrong service file reply control data level %d type %d, expected %d and %d\n",
+			 cmsg->cmsg_level, cmsg->cmsg_type, SOL_SOCKET,
+			 SCM_RIGHTS);
+		return -EBADMSG;
+	}
+
+	memcpy(fdp, (int *)CMSG_DATA(cmsg), sizeof(int));
+	return 0;
+}
+
+static int recv_requested_file(int sockfd, const char *path, int *fdp)
+{
+	struct fuse_service_requested_file *req;
+	const size_t req_sz = sizeof_fuse_service_requested_file(strlen(path));
+	int fd = -ENOENT;
+	int ret;
+
+	*fdp = -ENOENT;
+
+	req = calloc(1, req_sz + 1);
+	if (!req) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: alloc service file reply: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	ret = __recv_fd(sockfd, req, req_sz, &fd);
+	if (ret)
+		goto out_req;
+
+	if (req->p.magic != ntohl(FUSE_SERVICE_OPEN_REPLY)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service file reply contains wrong magic!\n");
+		ret = -EBADMSG;
+		goto out_close;
+	}
+	if (strcmp(req->path, path)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: `%s': not the requested service file, got `%s'\n",
+			 path, req->path);
+		ret = -EBADMSG;
+		goto out_close;
+	}
+
+	if (req->error) {
+		*fdp = -ntohl(req->error);
+		goto out_close;
+	}
+
+	if (fd == -ENOENT)
+		fuse_log(FUSE_LOG_ERR, "fuse: did not receive `%s' but no error?\n",
+			 path);
+
+	*fdp = fd;
+	goto out_req;
+
+out_close:
+	close(fd);
+out_req:
+	free(req);
+	return ret;
+}
+
+int fuse_service_receive_file(struct fuse_service *sf, const char *path,
+			      int *fdp)
+{
+	return recv_requested_file(sf->sockfd, path, fdp);
+}
+
+#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(0)
+
+static int fuse_service_request_path(struct fuse_service *sf, const char *path,
+				     mode_t expected_fmt, int open_flags,
+				     mode_t create_mode,
+				     unsigned int request_flags,
+				     unsigned int block_size)
+{
+	struct iovec iov = {
+		.iov_len = sizeof_fuse_service_open_command(strlen(path)),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	struct fuse_service_open_command *cmd;
+	ssize_t size;
+	unsigned int rqflags = 0;
+	int ret;
+
+	if (request_flags & ~FUSE_SERVICE_REQUEST_FILE_FLAGS) {
+		fuse_log(FUSE_LOG_ERR, "fuse: invalid fuse service file request flags 0x%x\n",
+			 request_flags);
+		return -EINVAL;
+	}
+
+	cmd = calloc(1, iov.iov_len);
+	if (!cmd) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: alloc service file request: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (S_ISBLK(expected_fmt)) {
+		cmd->p.magic = htonl(FUSE_SERVICE_OPEN_BDEV_CMD);
+		cmd->block_size = htonl(block_size);
+	} else {
+		cmd->p.magic = htonl(FUSE_SERVICE_OPEN_CMD);
+	}
+	cmd->open_flags = htonl(open_flags);
+	cmd->create_mode = htonl(create_mode);
+	cmd->request_flags = htonl(rqflags);
+	strcpy(cmd->path, path);
+	iov.iov_base = cmd;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: request service file: %s\n",
+			 strerror(error));
+		ret = -error;
+		goto out_free;
+	}
+
+	ret = 0;
+out_free:
+	free(cmd);
+	return ret;
+}
+
+int fuse_service_request_file(struct fuse_service *sf, const char *path,
+			      int open_flags, mode_t create_mode,
+			      unsigned int request_flags)
+{
+	return fuse_service_request_path(sf, path, S_IFREG, open_flags,
+					 create_mode, request_flags, 0);
+}
+
+int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
+				  int open_flags, mode_t create_mode,
+				  unsigned int request_flags,
+				  unsigned int block_size)
+{
+	return fuse_service_request_path(sf, path, S_IFBLK, open_flags,
+					 create_mode, request_flags,
+					 block_size);
+}
+
+int fuse_service_send_goodbye(struct fuse_service *sf, int exitcode)
+{
+	struct fuse_service_bye_command c = {
+		.p.magic = htonl(FUSE_SERVICE_BYE_CMD),
+		.exitcode = htonl(exitcode),
+	};
+	struct iovec iov = {
+		.iov_base = &c,
+		.iov_len = sizeof(c),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	/* already gone? */
+	if (sf->sockfd < 0)
+		return 0;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: send service goodbye: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	shutdown(sf->sockfd, SHUT_RDWR);
+	close(sf->sockfd);
+	sf->sockfd = -1;
+	return 0;
+}
+
+static int find_socket_fd(void)
+{
+	struct stat statbuf;
+	struct sockaddr_un urk;
+	char *listen_fds;
+	socklen_t urklen = sizeof(urk);
+	int nr_fds;
+	int ret;
+
+	/*
+	 * No environment variable means we're not running as a system socket
+	 * service, so we'll back out without logging anything.
+	 */
+	listen_fds = getenv("LISTEN_FDS");
+	if (!listen_fds)
+		return -ENOENT;
+
+	nr_fds = atoi(listen_fds);
+	if (nr_fds != 1) {
+		fuse_log(FUSE_LOG_ERR, "fuse: can only handle 1 service socket, got %d.\n",
+			 nr_fds);
+		return -E2BIG;
+	}
+
+	ret = fstat(SD_LISTEN_FDS_START, &statbuf);
+	if (ret) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service socket: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	if (!S_ISSOCK(statbuf.st_mode)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: expected service fd %d to be a socket\n",
+				SD_LISTEN_FDS_START);
+		return -ENOTSOCK;
+	}
+
+	ret = getsockname(SD_LISTEN_FDS_START, &urk, &urklen);
+	if (ret < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service socket family: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	if (ret > 0 || urk.sun_family != AF_UNIX) {
+		/*
+		 * If getsockname wanted to return more data than fits in a
+		 * sockaddr_un, then it's obviously not an AF_UNIX socket.
+		 *
+		 * If it filled the buffer exactly but the family isn't AF_UNIX
+		 * then we also return false.
+		 */
+		fuse_log(FUSE_LOG_ERR, "fuse: service socket is not AF_UNIX\n");
+		return -EAFNOSUPPORT;
+	}
+
+	return SD_LISTEN_FDS_START;
+}
+
+static int negotiate_hello(struct fuse_service *sf)
+{
+	struct fuse_service_hello hello = { };
+	struct fuse_service_hello_reply reply = {
+		.p.magic = htonl(FUSE_SERVICE_HELLO_REPLY),
+		.version = htons(FUSE_SERVICE_PROTO),
+	};
+	struct iovec iov = {
+		.iov_base = &hello,
+		.iov_len = sizeof(hello),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	uint64_t flags;
+	ssize_t size;
+
+	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: receive service hello: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (size != sizeof(hello)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: wrong service hello size %zd, expected %zd\n",
+			 size, sizeof(hello));
+		return -EBADMSG;
+	}
+
+	if (hello.p.magic != ntohl(FUSE_SERVICE_HELLO_CMD)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service server did not send hello command\n");
+		return -EBADMSG;
+	}
+
+	if (ntohs(hello.min_version) < FUSE_SERVICE_MIN_PROTO) {
+		fuse_log(FUSE_LOG_ERR, "fuse: unsupported min service protocol version %u\n",
+			ntohs(hello.min_version));
+		return -EOPNOTSUPP;
+	}
+
+	if (ntohs(hello.max_version) > FUSE_SERVICE_MAX_PROTO) {
+		fuse_log(FUSE_LOG_ERR, "fuse: unsupported max service protocol version %u\n",
+			ntohs(hello.min_version));
+		return -EOPNOTSUPP;
+	}
+
+	flags = ntohl(hello.flags);
+	if (flags & FUSE_SERVICE_FLAG_ALLOW_OTHER)
+		sf->allow_other = true;
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service hello reply: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	return 0;
+}
+
+int fuse_service_accept(struct fuse_service **sfp)
+{
+	struct fuse_service *sf;
+	int ret = 0;
+
+	*sfp = NULL;
+
+	sf = calloc(1, sizeof(struct fuse_service));
+	if (!sf) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service alloc: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	/* Find the socket that connects us to mount.service */
+	ret = find_socket_fd();
+	if (ret == -ENOENT) {
+		/*
+		 * No socket found, so we're not running as a service.  Don't
+		 * fail the request, but leave *sfp set to NULL.
+		 */
+		ret = 0;
+		goto out_sf;
+	}
+	if (ret < 0)
+		goto out_sf;
+	sf->sockfd = ret;
+
+	ret = negotiate_hello(sf);
+	if (ret)
+		goto out_sf;
+
+	/* Receive the two critical sockets */
+	ret = recv_requested_file(sf->sockfd, FUSE_SERVICE_ARGV, &sf->argvfd);
+	if (ret < 0)
+		goto out_sockfd;
+	if (sf->argvfd < 0) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service mount options file: %s\n",
+			 strerror(-sf->argvfd));
+		ret = sf->argvfd;
+		goto out_sockfd;
+	}
+
+	ret = recv_requested_file(sf->sockfd, FUSE_SERVICE_FUSEDEV,
+				  &sf->fusedevfd);
+	if (ret < 0)
+		goto out_argvfd;
+	if (sf->fusedevfd < 0) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service fuse device: %s\n",
+			 strerror(-sf->argvfd));
+		ret = sf->argvfd;
+		goto out_argvfd;
+	}
+
+	sf->owns_fusedevfd = true;
+	*sfp = sf;
+	return 0;
+
+out_argvfd:
+	close(sf->argvfd);
+out_sockfd:
+	shutdown(sf->sockfd, SHUT_RDWR);
+	close(sf->sockfd);
+out_sf:
+	free(sf);
+	return ret;
+}
+
+bool fuse_service_can_allow_other(struct fuse_service *sf)
+{
+	return sf->allow_other;
+}
+
+int fuse_service_append_args(struct fuse_service *sf,
+			     struct fuse_args *existing_args)
+{
+	struct fuse_service_memfd_argv memfd_args = { };
+	struct fuse_args new_args = {
+		.allocated = 1,
+	};
+	char *str = NULL;
+	off_t memfd_pos = 0;
+	ssize_t received;
+	unsigned int i;
+	int ret;
+
+	/* Figure out how many arguments we're getting from the mount helper. */
+	received = pread(sf->argvfd, &memfd_args, sizeof(memfd_args), 0);
+	if (received < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service args file: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (received < sizeof(memfd_args)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service args file length unreadable\n");
+		return -EBADMSG;
+	}
+	if (ntohl(memfd_args.magic) != FUSE_SERVICE_ARGS_MAGIC) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service args file corrupt\n");
+		return -EBADMSG;
+	}
+	memfd_args.magic = ntohl(memfd_args.magic);
+	memfd_args.argc = ntohl(memfd_args.argc);
+	memfd_pos += sizeof(memfd_args);
+
+	/* Allocate a new array of argv string pointers */
+	new_args.argv = calloc(memfd_args.argc + existing_args->argc,
+			       sizeof(char *));
+	if (!new_args.argv) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service new args: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	/*
+	 * Copy the fuse server's CLI arguments.  We'll leave new_args.argv[0]
+	 * unset for now, because we'll set it in the next step with the fstype
+	 * that the mount helper sent us.
+	 */
+	new_args.argc++;
+	for (i = 1; i < existing_args->argc; i++) {
+		if (existing_args->allocated) {
+			new_args.argv[new_args.argc] = existing_args->argv[i];
+			existing_args->argv[i] = NULL;
+		} else {
+			char *dup = strdup(existing_args->argv[i]);
+
+			if (!dup) {
+				int error = errno;
+
+				fuse_log(FUSE_LOG_ERR,
+					 "fuse: service duplicate existing args: %s\n",
+					 strerror(error));
+				ret = -error;
+				goto out_new_args;
+			}
+
+			new_args.argv[new_args.argc] = dup;
+		}
+
+		new_args.argc++;
+	}
+
+	/* Copy the rest of the arguments from the helper */
+	for (i = 0; i < memfd_args.argc; i++) {
+		struct fuse_service_memfd_arg memfd_arg = { };
+
+		/* Read argv iovec */
+		received = pread(sf->argvfd, &memfd_arg, sizeof(memfd_arg),
+				 memfd_pos);
+		if (received < 0) {
+			int error = errno;
+
+			fuse_log(FUSE_LOG_ERR, "fuse: service args file iovec read: %s\n",
+				 strerror(error));
+			ret = -error;
+			goto out_new_args;
+		}
+		if (received < sizeof(struct fuse_service_memfd_arg)) {
+			fuse_log(FUSE_LOG_ERR,
+				 "fuse: service args file argv[%u] iovec short read %zd",
+				 i, received);
+			ret = -EBADMSG;
+			goto out_new_args;
+		}
+		memfd_arg.pos = ntohl(memfd_arg.pos);
+		memfd_arg.len = ntohl(memfd_arg.len);
+		memfd_pos += sizeof(memfd_arg);
+
+		/* read arg string from file */
+		str = calloc(1, memfd_arg.len + 1);
+		if (!str) {
+			int error = errno;
+
+			fuse_log(FUSE_LOG_ERR, "fuse: service arg alloc: %s\n",
+				 strerror(error));
+			ret = -error;
+			goto out_new_args;
+		}
+
+		received = pread(sf->argvfd, str, memfd_arg.len, memfd_arg.pos);
+		if (received < 0) {
+			int error = errno;
+
+			fuse_log(FUSE_LOG_ERR, "fuse: service args file read: %s\n",
+				 strerror(error));
+			ret = -error;
+			goto out_str;
+		}
+		if (received < memfd_arg.len) {
+			fuse_log(FUSE_LOG_ERR, "fuse: service args file argv[%u] short read %zd",
+				 i, received);
+			ret = -EBADMSG;
+			goto out_str;
+		}
+
+		/* move string into the args structure */
+		if (i == 0) {
+			/* the first argument is the fs type */
+			new_args.argv[0] = str;
+		} else {
+			new_args.argv[new_args.argc] = str;
+			new_args.argc++;
+		}
+		str = NULL;
+	}
+
+	/* drop existing args, move new args to existing args */
+	fuse_opt_free_args(existing_args);
+	memcpy(existing_args, &new_args, sizeof(*existing_args));
+
+	close(sf->argvfd);
+	sf->argvfd = -1;
+
+	return 0;
+
+out_str:
+	free(str);
+out_new_args:
+	fuse_opt_free_args(&new_args);
+	return ret;
+}
+
+#ifdef SO_PASSRIGHTS
+int fuse_service_finish_file_requests(struct fuse_service *sf)
+{
+	int zero = 0;
+	int ret;
+
+	/*
+	 * Don't let a malicious mount helper send us more fds.  If the kernel
+	 * doesn't know about this new(ish) option that's ok, we'll trust the
+	 * servicemount helper.
+	 */
+	ret = setsockopt(sf->sockfd, SOL_SOCKET, SO_PASSRIGHTS, &zero,
+			 sizeof(zero));
+	if (ret && errno == ENOPROTOOPT)
+		ret = 0;
+	if (ret) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: disabling fd passing: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	return 0;
+}
+#else
+int fuse_service_finish_file_requests(struct fuse_service *sf)
+{
+	(void)sf;
+	return 0;
+}
+#endif
+
+static int send_string(struct fuse_service *sf, uint32_t command,
+		       const char *value, int *error)
+{
+	struct fuse_service_simple_reply reply = { };
+	struct iovec iov = {
+		.iov_len = sizeof_fuse_service_string_command(strlen(value)),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	struct fuse_service_string_command *cmd;
+	ssize_t size;
+
+	cmd = malloc(iov.iov_len);
+	if (!cmd) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: alloc service string send: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	cmd->p.magic = ntohl(command);
+	strcpy(cmd->value, value);
+	iov.iov_base = cmd;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: send service string: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	free(cmd);
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service string reply: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (size != sizeof(reply)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: wrong service string reply size %zd, expected %zd\n",
+			size, sizeof(reply));
+		return -EBADMSG;
+	}
+
+	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service string reply contains wrong magic!\n");
+		return -EBADMSG;
+	}
+
+	*error = ntohl(reply.error);
+	return 0;
+}
+
+static int send_mount(struct fuse_service *sf, unsigned int ms_flags,
+		      mode_t expected_fmt, int *error)
+{
+	struct fuse_service_simple_reply reply = { };
+	struct fuse_service_mount_command c = {
+		.p.magic = htonl(FUSE_SERVICE_MOUNT_CMD),
+		.ms_flags = htonl(ms_flags),
+		.expected_fmt = htons(expected_fmt),
+	};
+	struct iovec iov = {
+		.iov_base = &c,
+		.iov_len = sizeof(c),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: send service mount command: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: service mount reply: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (size != sizeof(reply)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: wrong service mount reply size %zd, expected %zd\n",
+			size, sizeof(reply));
+		return -EBADMSG;
+	}
+
+	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service mount reply contains wrong magic!\n");
+		return -EBADMSG;
+	}
+
+	*error = ntohl(reply.error);
+	return 0;
+}
+
+void fuse_service_expect_mount_mode(struct fuse_service *sf,
+				    mode_t expected_fmt)
+{
+	sf->expected_fmt = expected_fmt;
+}
+
+int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
+			       mode_t expected_fmt,
+			       struct fuse_cmdline_opts *opts)
+{
+	char *fstype = fuse_mnt_build_type(se->mo);
+	char *source = fuse_mnt_build_source(se->mo);
+	char *mntopts = fuse_mnt_kernel_opts(se->mo);
+	char path[32];
+	int ret;
+	int error;
+
+	if (!fstype || !source) {
+		fuse_log(FUSE_LOG_ERR, "fuse: cannot allocate service strings\n");
+		ret = -ENOMEM;
+		goto out_strings;
+	}
+
+	if (!expected_fmt)
+		expected_fmt = sf->expected_fmt;
+
+	/* The fuse session takes the fusedev fd if this succeeds */
+	snprintf(path, sizeof(path), "/dev/fd/%d", sf->fusedevfd);
+	errno = 0;
+	ret = fuse_session_mount(se, path);
+	if (ret) {
+		/* Try to return richer errors than fuse_session_mount's -1 */
+		ret = errno ? -errno : -EINVAL;
+		goto out_strings;
+	}
+	sf->owns_fusedevfd = false;
+
+	ret = send_string(sf, FUSE_SERVICE_FSOPEN_CMD, fstype, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service fsopen: %s\n",
+			 strerror(error));
+		ret = -error;
+		goto out_strings;
+	}
+
+	ret = send_string(sf, FUSE_SERVICE_SOURCE_CMD, source, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service fs source: %s\n",
+			 strerror(error));
+		ret = -error;
+		goto out_strings;
+	}
+
+	ret = send_string(sf, FUSE_SERVICE_MNTPT_CMD, opts->mountpoint, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service fs mountpoint: %s\n",
+			 strerror(error));
+		ret = -error;
+		goto out_strings;
+	}
+
+	if (mntopts) {
+		ret = send_string(sf, FUSE_SERVICE_MNTOPTS_CMD, mntopts,
+				  &error);
+		if (ret)
+			goto out_strings;
+		if (error) {
+			fuse_log(FUSE_LOG_ERR, "fuse: service fs mount options: %s\n",
+				 strerror(error));
+			ret = -error;
+			goto out_strings;
+		}
+	}
+
+	ret = send_mount(sf, fuse_mnt_flags(se->mo), expected_fmt, &error);
+	if (ret)
+		goto out_strings;
+	if (error) {
+		fuse_log(FUSE_LOG_ERR, "fuse: service mount: %s\n",
+			 strerror(error));
+		ret = -error;
+		goto out_strings;
+	}
+
+	/*
+	 * foreground mode is needed so that systemd actually tracks the
+	 * service correctly and doesn't try to kill it; and so that
+	 * stdout/stderr don't get zapped
+	 */
+	opts->foreground = 1;
+
+out_strings:
+	free(mntopts);
+	free(source);
+	free(fstype);
+	return ret;
+}
+
+void fuse_service_release(struct fuse_service *sf)
+{
+	if (sf->owns_fusedevfd)
+		close(sf->fusedevfd);
+	sf->owns_fusedevfd = false;
+	sf->fusedevfd = -1;
+	close(sf->argvfd);
+	sf->argvfd = -1;
+	shutdown(sf->sockfd, SHUT_RDWR);
+	close(sf->sockfd);
+	sf->sockfd = -1;
+}
+
+void fuse_service_destroy(struct fuse_service **sfp)
+{
+	struct fuse_service *sf = *sfp;
+
+	if (sf) {
+		fuse_service_release(*sfp);
+		free(sf);
+	}
+
+	*sfp = NULL;
+}
+
+char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args)
+{
+	char *p, *dst;
+	size_t len = 1;
+	ssize_t ret;
+	char *argv0;
+	unsigned int i;
+
+	/* Try to preserve argv[0] */
+	if (argc > 0)
+		argv0 = argv[0];
+	else if (args->argc > 0)
+		argv0 = args->argv[0];
+	else
+		return NULL;
+
+	/* Pick up the alleged fstype from args->argv[0] */
+	if (args->argc == 0)
+		return NULL;
+
+	len += strlen(argv0) + 1;
+	len += 3; /* " -t" */
+	for (i = 0; i < args->argc; i++)
+		len += strlen(args->argv[i]) + 1;
+
+	p = malloc(len);
+	if (!p)
+		return NULL;
+	dst = p;
+
+	/* Format: argv0 -t alleged_fstype [all other options...] */
+	ret = sprintf(dst, "%s -t", argv0);
+	dst += ret;
+	for (i = 0; i < args->argc; i++) {
+		ret = sprintf(dst, " %s", args->argv[i]);
+		dst += ret;
+	}
+
+	return p;
+}
+
+int fuse_service_parse_cmdline_opts(struct fuse_args *args,
+				    struct fuse_cmdline_opts *opts)
+{
+	return fuse_parse_cmdline_service(args, opts);
+}
+
+int fuse_service_exit(int ret)
+{
+	/*
+	 * We have to sleep 2 seconds here because journald uses the pid to
+	 * connect our log messages to the systemd service.  This is critical
+	 * for capturing all the log messages if the service fails, because
+	 * failure analysis tools use the service name to gather log messages
+	 * for reporting.
+	 */
+	sleep(2);
+
+	/*
+	 * If we're being run as a service, the return code must fit the LSB
+	 * init script action error guidelines, which is to say that we
+	 * compress all errors to 1 ("generic or unspecified error", LSB 5.0
+	 * section 22.2) and hope the admin will scan the log for what actually
+	 * happened.
+	 */
+	return ret != 0 ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
new file mode 100644
index 00000000000000..bb816844c033f0
--- /dev/null
+++ b/lib/fuse_service_stub.c
@@ -0,0 +1,96 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * Stub functions for platforms where we cannot have fuse servers run as "safe"
+ * systemd containers.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt
+ */
+
+/* we don't use any parameters at all */
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+
+#define _GNU_SOURCE
+#include <errno.h>
+
+#include "fuse_config.h"
+#include "fuse_i.h"
+#include "fuse_service.h"
+
+int fuse_service_receive_file(struct fuse_service *sf, const char *path,
+			      int *fdp)
+{
+	return -EOPNOTSUPP;
+}
+
+int fuse_service_request_file(struct fuse_service *sf, const char *path,
+			      int open_flags, mode_t create_mode,
+			      unsigned int request_flags)
+{
+	return -EOPNOTSUPP;
+}
+
+int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
+				  int open_flags, mode_t create_mode,
+				  unsigned int request_flags,
+				  unsigned int block_size)
+{
+	return -EOPNOTSUPP;
+}
+
+int fuse_service_send_goodbye(struct fuse_service *sf, int error)
+{
+	return -EOPNOTSUPP;
+}
+
+int fuse_service_accept(struct fuse_service **sfp)
+{
+	*sfp = NULL;
+	return -EOPNOTSUPP;
+}
+
+int fuse_service_append_args(struct fuse_service *sf,
+			     struct fuse_args *existing_args)
+{
+	return -EOPNOTSUPP;
+}
+
+int fuse_service_finish_file_requests(struct fuse_service *sf)
+{
+	return -EOPNOTSUPP;
+}
+
+void fuse_service_expect_mount_mode(struct fuse_service *sf,
+				    mode_t expected_fmt)
+{
+}
+
+int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
+			       mode_t expected_fmt,
+			       struct fuse_cmdline_opts *opts)
+{
+	return -EOPNOTSUPP;
+}
+
+void fuse_service_release(struct fuse_service *sf)
+{
+}
+
+void fuse_service_destroy(struct fuse_service **sfp)
+{
+	*sfp = NULL;
+}
+
+int fuse_service_parse_cmdline_opts(struct fuse_args *args,
+				    struct fuse_cmdline_opts *opts)
+{
+	return -1;
+}
+
+int fuse_service_exit(int ret)
+{
+	return ret;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index cce09610316f4b..1fc73f417f90a0 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -227,6 +227,22 @@ FUSE_3.19 {
 		fuse_session_start_teardown_watchdog;
 		fuse_session_stop_teardown_watchdog;
 		fuse_lowlevel_notify_prune;
+
+		fuse_service_accept;
+		fuse_service_append_args;
+		fuse_service_can_allow_other;
+		fuse_service_cmdline;
+		fuse_service_destroy;
+		fuse_service_exit;
+		fuse_service_expect_mount_mode;
+		fuse_service_finish_file_requests;
+		fuse_service_parse_cmdline_opts;
+		fuse_service_receive_file;
+		fuse_service_release;
+		fuse_service_request_file;
+		fuse_service_request_blockdev;
+		fuse_service_send_goodbye;
+		fuse_service_session_mount;
 } FUSE_3.18;
 
 # Local Variables:
diff --git a/lib/helper.c b/lib/helper.c
index 5c13b93a473181..533526273207d5 100644
--- a/lib/helper.c
+++ b/lib/helper.c
@@ -26,6 +26,11 @@
 #include <errno.h>
 #include <sys/param.h>
 
+#ifdef HAVE_SERVICEMOUNT
+# include <linux/types.h>
+# include "fuse_service_priv.h"
+#endif
+
 #define FUSE_HELPER_OPT(t, p) \
 	{ t, offsetof(struct fuse_cmdline_opts, p), 1 }
 
@@ -174,6 +179,27 @@ static int fuse_helper_opt_proc(void *data, const char *arg, int key,
 	}
 }
 
+#ifdef HAVE_SERVICEMOUNT
+static int fuse_helper_opt_proc_service(void *data, const char *arg, int key,
+					struct fuse_args *outargs)
+{
+	(void) outargs;
+	struct fuse_cmdline_opts *opts = data;
+
+	switch (key) {
+	case FUSE_OPT_KEY_NONOPT:
+		if (!opts->mountpoint)
+			return fuse_opt_add_opt(&opts->mountpoint, arg);
+
+		fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
+		return -1;
+	default:
+		/* Pass through unknown options */
+		return 1;
+	}
+}
+#endif
+
 /* Under FreeBSD, there is no subtype option so this
    function actually sets the fsname */
 static int add_default_subtype(const char *progname, struct fuse_args *args)
@@ -228,6 +254,33 @@ int fuse_parse_cmdline_312(struct fuse_args *args,
 	return 0;
 }
 
+#ifdef HAVE_SERVICEMOUNT
+int fuse_parse_cmdline_service(struct fuse_args *args,
+			       struct fuse_cmdline_opts *opts)
+{
+	memset(opts, 0, sizeof(struct fuse_cmdline_opts));
+
+	opts->max_idle_threads = UINT_MAX; /* new default in fuse version 3.12 */
+	opts->max_threads = 10;
+
+	if (fuse_opt_parse(args, opts, fuse_helper_opts,
+			   fuse_helper_opt_proc_service) == -1)
+		return -1;
+
+	/*
+	 * *Linux*: if neither -o subtype nor -o fsname are specified,
+	 * set subtype to program's basename.
+	 * *FreeBSD*: if fsname is not specified, set to program's
+	 * basename.
+	 */
+	if (!opts->nodefault_subtype)
+		if (add_default_subtype(args->argv[0], args) == -1)
+			return -1;
+
+	return 0;
+}
+#endif
+
 /**
  * struct fuse_cmdline_opts got extended in libfuse-3.12
  */
diff --git a/lib/meson.build b/lib/meson.build
index fcd95741c9d374..7ff5c91e0da702 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -10,6 +10,12 @@ else
    libfuse_sources += [ 'mount_bsd.c' ]
 endif
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  libfuse_sources += [ 'fuse_service.c' ]
+else
+  libfuse_sources += [ 'fuse_service_stub.c' ]
+endif
+
 deps = [ thread_dep ]
 if private_cfg.get('HAVE_ICONV')
    libfuse_sources += [ 'modules/iconv.c' ]
@@ -49,18 +55,24 @@ libfuse = library('fuse3',
                   dependencies: deps,
                   install: true,
                   link_depends: 'fuse_versionscript',
-                  c_args: [ '-DFUSE_USE_VERSION=317',
+                  c_args: [ '-DFUSE_USE_VERSION=319',
                             '-DFUSERMOUNT_DIR="@0@"'.format(fusermount_path) ],
                   link_args: ['-Wl,--version-script,' + meson.current_source_dir()
                               + '/fuse_versionscript' ])
 
+vars = []
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  service_socket_dir = private_cfg.get_unquoted('FUSE_SERVICE_SOCKET_DIR', '')
+  vars += ['service_socket_dir=' + service_socket_dir]
+endif
 pkg = import('pkgconfig')
 pkg.generate(libraries: [ libfuse, '-lpthread' ],
              libraries_private: '-ldl',
              version: meson.project_version(),
              name: 'fuse3',
              description: 'Filesystem in Userspace',
-             subdirs: 'fuse3')
+             subdirs: 'fuse3',
+             variables: vars)
 
 libfuse_dep = declare_dependency(include_directories: include_dirs,
                                  link_with: libfuse, dependencies: deps)
diff --git a/lib/mount.c b/lib/mount.c
index 6cf98a0769ba8c..2018172ae570f0 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -750,3 +750,15 @@ char *fuse_mnt_build_type(const struct mount_opts *mo)
 
 	return type;
 }
+
+char *fuse_mnt_kernel_opts(const struct mount_opts *mo)
+{
+	if (mo->kernel_opts)
+		return strdup(mo->kernel_opts);
+	return NULL;
+}
+
+unsigned int fuse_mnt_flags(const struct mount_opts *mo)
+{
+	return mo->flags;
+}
diff --git a/meson.build b/meson.build
index 80c5f1dc0bd356..d6ba8740effd5c 100644
--- a/meson.build
+++ b/meson.build
@@ -69,6 +69,11 @@ args_default = [ '-D_GNU_SOURCE' ]
 #
 private_cfg = configuration_data()
 private_cfg.set_quoted('PACKAGE_VERSION', meson.project_version())
+service_socket_dir = get_option('service-socket-dir')
+if service_socket_dir == ''
+  service_socket_dir = '/run/filesystems'
+endif
+private_cfg.set_quoted('FUSE_SERVICE_SOCKET_DIR', service_socket_dir)
 
 # Test for presence of some functions
 test_funcs = [ 'fork', 'fstatat', 'openat', 'readlinkat', 'pipe2',
@@ -118,6 +123,13 @@ special_funcs = {
 	    return -1;
 	  }
 	}
+    ''',
+    'systemd_headers': '''
+	#include <systemd/sd-daemon.h>
+
+	int main(int argc, char *argv[]) {
+          return SD_LISTEN_FDS_START;
+	}
     '''
 }
 
@@ -180,6 +192,23 @@ if get_option('enable-io-uring') and liburing.found() and libnuma.found()
    endif
 endif
 
+# Check for systemd support
+systemd_system_unit_dir = get_option('systemdsystemunitdir')
+if systemd_system_unit_dir == ''
+  systemd = dependency('systemd', required: false)
+  if systemd.found()
+     systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
+  endif
+endif
+
+if systemd_system_unit_dir == '' or private_cfg.get('HAVE_SYSTEMD_HEADERS', false) == false
+  warning('systemd service support will not be built')
+else
+  private_cfg.set_quoted('SYSTEMD_SYSTEM_UNIT_DIR', systemd_system_unit_dir)
+  private_cfg.set('HAVE_SYSTEMD', true)
+  private_cfg.set('HAVE_SERVICEMOUNT', true)
+endif
+
 #
 # Compiler configuration
 #
diff --git a/meson_options.txt b/meson_options.txt
index c1f8fe69467184..95655a0d64895c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -27,3 +27,9 @@ option('enable-usdt', type : 'boolean', value : false,
 
 option('enable-io-uring', type: 'boolean', value: true,
        description: 'Enable fuse-over-io-uring support')
+
+option('service-socket-dir', type : 'string', value : '',
+       description: 'Where to install fuse server sockets (if empty, /run/filesystems)')
+
+option('systemdsystemunitdir', type : 'string', value : '',
+       description: 'Where to install systemd unit files (if empty, query pkg-config(1))')
diff --git a/util/fuservicemount.c b/util/fuservicemount.c
new file mode 100644
index 00000000000000..9c694a4290f94e
--- /dev/null
+++ b/util/fuservicemount.c
@@ -0,0 +1,18 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * This program can be distributed under the terms of the GNU GPLv2.
+ * See the file GPL2.txt.
+ *
+ * This program wraps the mounting of FUSE filesystems that run in systemd
+ */
+#define _GNU_SOURCE
+#include "fuse_config.h"
+#include "mount_service.h"
+
+int main(int argc, char *argv[])
+{
+	return mount_service_main(argc, argv);
+}
diff --git a/util/meson.build b/util/meson.build
index 0e4b1cce95377e..403fc68ef67ae8 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -6,6 +6,15 @@ executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c
            install_dir: get_option('bindir'),
            c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
 
+if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c'],
+             include_directories: include_dirs,
+             link_with: [ libfuse ],
+             install: true,
+             install_dir: get_option('sbindir'),
+             c_args: '-DFUSE_USE_VERSION=317')
+endif
+
 executable('mount.fuse3', ['mount.fuse.c'],
            include_directories: include_dirs,
            link_with: [ libfuse ],
diff --git a/util/mount_service.c b/util/mount_service.c
new file mode 100644
index 00000000000000..ae078e537dc560
--- /dev/null
+++ b/util/mount_service.c
@@ -0,0 +1,1088 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026 Oracle.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * This program can be distributed under the terms of the GNU GPLv2.
+ * See the file GPL2.txt.
+ *
+ * This program does the mounting of FUSE filesystems that run in systemd
+ */
+#define _GNU_SOURCE
+#include "fuse_config.h"
+#include <stdint.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include <stdbool.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <arpa/inet.h>
+
+#include "mount_util.h"
+#include "util.h"
+#include "fuse_i.h"
+#include "fuse_service_priv.h"
+#include "mount_service.h"
+
+struct mount_service {
+	/* prefix for printing error messages */
+	const char *msgtag;
+
+	/* alleged fuse subtype based on -t cli argument */
+	const char *subtype;
+
+	/* full fuse filesystem type we give to mount() */
+	char *fstype;
+
+	/* source argument to mount() */
+	char *source;
+
+	/* target argument (aka mountpoint) to mount() */
+	char *mountpoint;
+
+	/* mountpoint that we pass to mount() */
+	const char *real_mountpoint;
+
+	/* mount options */
+	char *mntopts;
+
+	/* socket fd */
+	int sockfd;
+
+	/* /dev/fuse device */
+	int fusedevfd;
+
+	/* memfd for cli arguments */
+	int argvfd;
+
+	/* O_PATH fd for mount point */
+	int mountfd;
+};
+
+/* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
+const char *mount_service_subtype(const char *fstype)
+{
+	char *period = strrchr(fstype, '.');
+
+	if (period)
+		return period + 1;
+
+	return fstype;
+}
+
+static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
+{
+	char *fstype = NULL;
+	int i;
+
+	mo->sockfd = -1;
+	mo->argvfd = -1;
+	mo->fusedevfd = -1;
+	mo->mountfd = -1;
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
+			fstype = argv[i + 1];
+			break;
+		}
+	}
+	if (!fstype) {
+		fprintf(stderr, "%s: cannot determine filesystem type.\n",
+			mo->msgtag);
+		return -1;
+	}
+
+	mo->subtype = mount_service_subtype(fstype);
+	return 0;
+}
+
+#ifdef SO_PASSRIGHTS
+static int try_drop_passrights(struct mount_service *mo, int sockfd)
+{
+	int zero = 0;
+	int ret;
+
+	/*
+	 * Don't let a malicious mount helper send us any fds.  We don't trust
+	 * the fuse server not to pollute our fd namespace, so we'll end now.
+	 */
+	ret = setsockopt(sockfd, SOL_SOCKET, SO_PASSRIGHTS, &zero,
+			 sizeof(zero));
+	if (ret) {
+		fprintf(stderr, "%s: disabling fd passing: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+#else
+# define try_drop_passrights(...)	(0)
+#endif
+
+static int mount_service_connect(struct mount_service *mo)
+{
+	struct sockaddr_un name = {
+		.sun_family = AF_UNIX,
+	};
+	int sockfd;
+	ssize_t written;
+	int ret;
+
+	written = snprintf(name.sun_path, sizeof(name.sun_path),
+			FUSE_SERVICE_SOCKET_DIR "/%s", mo->subtype);
+	if (written > sizeof(name.sun_path)) {
+		fprintf(stderr, "%s: filesystem type name `%s' is too long.\n",
+			mo->msgtag, mo->subtype);
+		return -1;
+	}
+
+	sockfd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (sockfd < 0) {
+		fprintf(stderr, "%s: opening %s service socket: %s\n",
+			mo->msgtag, mo->subtype, strerror(errno));
+		return -1;
+	}
+
+	ret = connect(sockfd, (const struct sockaddr *)&name, sizeof(name));
+	if (ret) {
+		if (errno == ENOENT)
+			fprintf(stderr, "%s: no safe filesystem driver for %s available.\n",
+				mo->msgtag, mo->subtype);
+		else
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, name.sun_path, strerror(errno));
+		goto out;
+	}
+
+	ret = try_drop_passrights(mo, sockfd);
+	if (ret)
+		goto out;
+
+	mo->sockfd = sockfd;
+	return 0;
+out:
+	close(sockfd);
+	return -1;
+}
+
+static int mount_service_send_hello(struct mount_service *mo)
+{
+	struct fuse_service_hello hello = {
+		.p.magic = htonl(FUSE_SERVICE_HELLO_CMD),
+		.min_version = htons(FUSE_SERVICE_MIN_PROTO),
+		.max_version = htons(FUSE_SERVICE_MAX_PROTO),
+	};
+	struct fuse_service_hello_reply reply = { };
+	struct iovec iov = {
+		.iov_base = &hello,
+		.iov_len = sizeof(hello),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	if (getuid() == 0)
+		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
+
+	size = sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		fprintf(stderr, "%s: send hello: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+
+	iov.iov_base = &reply;
+	iov.iov_len = sizeof(reply);
+
+	size = recvmsg(mo->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		fprintf(stderr, "%s: hello reply: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	if (size != sizeof(reply)) {
+		fprintf(stderr, "%s: wrong hello reply size %zd, expected %zd\n",
+			mo->msgtag, size, sizeof(reply));
+		return -1;
+	}
+
+	if (reply.p.magic != ntohl(FUSE_SERVICE_HELLO_REPLY)) {
+		fprintf(stderr, "%s: %s service server did not reply to hello\n",
+			mo->msgtag, mo->subtype);
+		return -1;
+	}
+
+	if (ntohs(reply.version) < FUSE_SERVICE_MIN_PROTO ||
+	    ntohs(reply.version) > FUSE_SERVICE_MAX_PROTO) {
+		fprintf(stderr, "%s: unsupported protocol version %u\n",
+			mo->msgtag, ntohs(reply.version));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int mount_service_capture_arg(struct mount_service *mo,
+				     struct fuse_service_memfd_argv *args,
+				     const char *string, off_t *array_pos,
+				     off_t *string_pos)
+{
+	const size_t string_len = strlen(string) + 1;
+	struct fuse_service_memfd_arg arg = {
+		.pos = htonl(*string_pos),
+		.len = htonl(string_len),
+	};
+	ssize_t written;
+
+	written = pwrite(mo->argvfd, string, string_len, *string_pos);
+	if (written < 0) {
+		fprintf(stderr, "%s: memfd argv write: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	if (written < string_len) {
+		fprintf(stderr, "%s: memfd argv[%u] wrote %zd, expected %zd\n",
+			mo->msgtag, args->argc, written, string_len);
+		return -1;
+	}
+
+	written = pwrite(mo->argvfd, &arg, sizeof(arg), *array_pos);
+	if (written < 0) {
+		fprintf(stderr, "%s: memfd arg write: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	if (written < sizeof(arg)) {
+		fprintf(stderr, "%s: memfd arg[%u] wrote %zd, expected %zd\n",
+			mo->msgtag, args->argc, written, sizeof(arg));
+		return -1;
+	}
+
+	args->argc++;
+	*string_pos += string_len;
+	*array_pos += sizeof(arg);
+
+	return 0;
+}
+
+static int mount_service_capture_args(struct mount_service *mo, int argc,
+				      char *argv[])
+{
+	struct fuse_service_memfd_argv args = {
+		.magic = htonl(FUSE_SERVICE_ARGS_MAGIC),
+	};
+	off_t array_pos = sizeof(struct fuse_service_memfd_argv);
+	off_t string_pos = array_pos +
+			(argc * sizeof(struct fuse_service_memfd_arg));
+	ssize_t written;
+	int i;
+	int ret;
+
+	if (argc < 0) {
+		fprintf(stderr, "%s: argc cannot be negative\n",
+			mo->msgtag);
+		return -1;
+	}
+
+	/*
+	 * Create the memfd in which we'll stash arguments, and set the write
+	 * pointer for the names.
+	 */
+	mo->argvfd = memfd_create("fuse service argv", MFD_CLOEXEC);
+	if (mo->argvfd < 0) {
+		fprintf(stderr, "%s: argvfd create: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * Write the alleged subtype as if it were argv[0], then write the rest
+	 * of the argv arguments.
+	 */
+	ret = mount_service_capture_arg(mo, &args, mo->subtype, &array_pos,
+					&string_pos);
+	if (ret)
+		return ret;
+
+	for (i = 1; i < argc; i++) {
+		/* skip the -t(ype) argument */
+		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
+			i++;
+			continue;
+		}
+
+		ret = mount_service_capture_arg(mo, &args, argv[i],
+						&array_pos, &string_pos);
+		if (ret)
+			return ret;
+	}
+
+	/* Now write the header */
+	args.argc = htonl(args.argc);
+	written = pwrite(mo->argvfd, &args, sizeof(args), 0);
+	if (written < 0) {
+		fprintf(stderr, "%s: memfd argv write: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	if (written < sizeof(args)) {
+		fprintf(stderr, "%s: memfd argv wrote %zd, expected %zd\n",
+			mo->msgtag, written, sizeof(args));
+		return -1;
+	}
+
+	return 0;
+}
+
+static ssize_t __send_fd(int sockfd, struct fuse_service_requested_file *req,
+			 size_t req_sz, int fd)
+{
+	union {
+		struct cmsghdr cmsghdr;
+		char control[CMSG_SPACE(sizeof(int))];
+	} cmsgu;
+	struct iovec iov = {
+		.iov_base = req,
+		.iov_len = req_sz,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgu.control,
+		.msg_controllen = sizeof(cmsgu.control),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	if (!cmsg) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	memset(&cmsgu, 0, sizeof(cmsgu));
+	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+
+	*((int *)CMSG_DATA(cmsg)) = fd;
+
+	return sendmsg(sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+}
+
+static int mount_service_send_file(struct mount_service *mo,
+				   const char *path, int fd)
+{
+	struct fuse_service_requested_file *req;
+	const size_t req_sz =
+			sizeof_fuse_service_requested_file(strlen(path));
+	ssize_t written;
+	int ret = 0;
+
+	req = malloc(req_sz);
+	if (!req) {
+		fprintf(stderr, "%s: alloc send file reply: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	req->p.magic = htonl(FUSE_SERVICE_OPEN_REPLY);
+	req->error = 0;
+	strcpy(req->path, path);
+
+	written = __send_fd(mo->sockfd, req, req_sz, fd);
+	if (written < 0) {
+		fprintf(stderr, "%s: send file reply: %s\n",
+			mo->msgtag, strerror(errno));
+		ret = -1;
+		goto out_req;
+	}
+	if (written < req_sz) {
+		fprintf(stderr, "%s: send file reply wrote %zd, expected %zd\n",
+			mo->msgtag, written, req_sz);
+		ret = -1;
+		goto out_req;
+	}
+
+out_req:
+	free(req);
+	return ret;
+}
+
+static ssize_t __send_packet(int sockfd, void *buf, ssize_t buflen)
+{
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = buflen,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+
+	return sendmsg(sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+}
+
+static int mount_service_send_file_error(struct mount_service *mo, int error,
+					 const char *path)
+{
+	struct fuse_service_requested_file *req;
+	const size_t req_sz =
+			sizeof_fuse_service_requested_file(strlen(path));
+	ssize_t written;
+	int ret = 0;
+
+	req = malloc(req_sz);
+	if (!req) {
+		fprintf(stderr, "%s: alloc send file error: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	req->p.magic = htonl(FUSE_SERVICE_OPEN_REPLY);
+	req->error = htonl(error);
+	strcpy(req->path, path);
+
+	written = __send_packet(mo->sockfd, req, req_sz);
+	if (written < 0) {
+		fprintf(stderr, "%s: send file error: %s\n",
+			mo->msgtag, strerror(errno));
+		ret = -1;
+		goto out_req;
+	}
+	if (written < req_sz) {
+		fprintf(stderr, "%s: send file error wrote %zd, expected %zd\n",
+			mo->msgtag, written, req_sz);
+		ret = -1;
+		goto out_req;
+	}
+
+out_req:
+	free(req);
+	return ret;
+}
+
+static int mount_service_send_required_files(struct mount_service *mo,
+					     const char *fusedev)
+{
+	int ret;
+
+	mo->fusedevfd = open(fusedev, O_RDWR | O_CLOEXEC);
+	if (mo->fusedevfd < 0) {
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, fusedev, strerror(errno));
+		return -1;
+	}
+
+	ret = mount_service_send_file(mo, FUSE_SERVICE_ARGV, mo->argvfd);
+	if (ret)
+		goto out_fusedevfd;
+
+	return mount_service_send_file(mo, FUSE_SERVICE_FUSEDEV,
+				       mo->fusedevfd);
+
+out_fusedevfd:
+	close(mo->fusedevfd);
+	mo->fusedevfd = -1;
+	return ret;
+}
+
+static int mount_service_receive_command(struct mount_service *mo,
+					 struct fuse_service_packet **commandp)
+{
+	struct iovec iov = {
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	struct fuse_service_packet *command;
+	ssize_t size;
+
+	size = recvmsg(mo->sockfd, &msg, MSG_PEEK | MSG_TRUNC);
+	if (size < 0) {
+		fprintf(stderr, "%s: peek service command: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	if (size == 0) {
+		/* fuse server probably exited early */
+		fprintf(stderr, "%s: fuse server exited without saying goodbye!\n",
+			mo->msgtag);
+		return -1;
+	}
+	if (size < sizeof(struct fuse_service_packet)) {
+		fprintf(stderr, "%s: wrong command packet size %zd, expected at least %zd\n",
+			mo->msgtag, size, sizeof(struct fuse_service_packet));
+		return -1;
+	}
+
+	command = calloc(1, size + 1);
+	if (!command) {
+		fprintf(stderr, "%s: alloc service command: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+	iov.iov_base = command;
+	iov.iov_len = size;
+
+	size = recvmsg(mo->sockfd, &msg, MSG_TRUNC);
+	if (size < 0) {
+		fprintf(stderr, "%s: receive service command: %s\n",
+			mo->msgtag, strerror(errno));
+		free(command);
+		return -1;
+	}
+	if (size != iov.iov_len) {
+		fprintf(stderr, "%s: wrong service command size %zd, expected %zd\n",
+			mo->msgtag,
+			size, iov.iov_len);
+		free(command);
+		return -1;
+	}
+
+	*commandp = command;
+	return 0;
+}
+
+static int mount_service_send_reply(struct mount_service *mo, int error)
+{
+	struct fuse_service_simple_reply reply = {
+		.p.magic = htonl(FUSE_SERVICE_SIMPLE_REPLY),
+		.error = htonl(error),
+	};
+	struct iovec iov = {
+		.iov_base = &reply,
+		.iov_len = sizeof(reply),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t size;
+
+	size = sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
+	if (size < 0) {
+		fprintf(stderr, "%s: send service reply: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int prepare_bdev(struct mount_service *mo,
+			struct fuse_service_open_command *oc, int fd)
+{
+	struct stat statbuf;
+	int block_size;
+	int ret;
+
+	ret = fstat(fd, &statbuf);
+	if (ret) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, oc->path, strerror(error));
+		return -error;
+	}
+
+	if (!S_ISBLK(statbuf.st_mode)) {
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, oc->path, strerror(ENOTBLK));
+		return -ENOTBLK;
+	}
+
+	if (!oc->block_size)
+		return 0;
+	block_size = ntohl(oc->block_size);
+
+	ret = ioctl(fd, BLKBSZSET, &block_size);
+	if (ret) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, oc->path, strerror(error));
+		return -error;
+	}
+
+	return 0;
+}
+
+static int mount_service_handle_open_path(struct mount_service *mo,
+					  mode_t expected_fmt,
+					  struct fuse_service_packet *p)
+{
+	struct fuse_service_open_command *oc =
+			container_of(p, struct fuse_service_open_command, p);
+	uint32_t request_flags = ntohl(oc->request_flags);
+	int ret;
+	int fd;
+
+	if (request_flags & ~FUSE_SERVICE_OPEN_FLAGS)
+		return mount_service_send_file_error(mo, EINVAL, oc->path);
+
+	fd = open(oc->path, ntohl(oc->open_flags), ntohl(oc->create_mode));
+	if (fd < 0) {
+		int error = errno;
+
+		/*
+		 * Don't print a busy device error report because the
+		 * filesystem might decide to retry.
+		 */
+		if (error != EBUSY)
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, oc->path, strerror(error));
+		return mount_service_send_file_error(mo, error, oc->path);
+	}
+
+	if (S_ISBLK(expected_fmt)) {
+		ret = prepare_bdev(mo, oc, fd);
+		if (ret < 0) {
+			close(fd);
+			return mount_service_send_file_error(mo, -ret,
+							     oc->path);
+		}
+	}
+
+	ret = mount_service_send_file(mo, oc->path, fd);
+	close(fd);
+	return ret;
+}
+
+static int mount_service_handle_open_cmd(struct mount_service *mo,
+					 struct fuse_service_packet *p)
+{
+	return mount_service_handle_open_path(mo, 0, p);
+}
+
+static int mount_service_handle_open_bdev_cmd(struct mount_service *mo,
+					      struct fuse_service_packet *p)
+{
+	return mount_service_handle_open_path(mo, S_IFBLK, p);
+}
+
+static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
+					   const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	if (mo->fstype) {
+		fprintf(stderr, "%s: fstype respecified!\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	mo->fstype = strdup(oc->value);
+	if (!mo->fstype) {
+		int error = errno;
+
+		fprintf(stderr, "%s: alloc fstype string: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int mount_service_handle_source_cmd(struct mount_service *mo,
+					   const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	if (mo->source) {
+		fprintf(stderr, "%s: source respecified!\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	mo->source = strdup(oc->value);
+	if (!mo->source) {
+		int error = errno;
+
+		fprintf(stderr, "%s: alloc source string: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
+					    const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	if (mo->mntopts) {
+		fprintf(stderr, "%s: mount options respecified!\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	mo->mntopts = strdup(oc->value);
+	if (!mo->mntopts) {
+		int error = errno;
+
+		fprintf(stderr, "%s: alloc mount options string: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
+					       const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+	int ret;
+
+	if (mo->mountpoint) {
+		fprintf(stderr, "%s: mount point respecified!\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+#ifdef O_PATH
+	mo->mountfd = open(oc->value, O_PATH);
+	if (mo->mountfd < 0) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, oc->value, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+#else
+	mo->mountfd = -1;
+#endif
+
+	mo->mountpoint = strdup(oc->value);
+	if (!mo->mountpoint) {
+		int error = errno;
+
+		fprintf(stderr, "%s: alloc mount point string: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+	mo->real_mountpoint = mo->mountpoint;
+
+	ret = chdir(oc->value);
+	if (ret) {
+		if (errno != ENOTDIR) {
+			int error = errno;
+
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, oc->value, strerror(error));
+			return mount_service_send_reply(mo, error);
+		}
+
+		/* not a directory */
+	} else {
+		/*
+		 * Now that we're sitting on the mountpoint directory, we can
+		 * pass "." to mount() and avoid races with directory tree
+		 * mutations.
+		 */
+		mo->real_mountpoint = ".";
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static inline int format_libfuse_mntopts(char *buf, size_t bufsz,
+					 const struct mount_service *mo,
+					 const struct stat *statbuf)
+{
+	if (mo->mntopts)
+		return snprintf(buf, bufsz,
+				"%s,fd=%i,rootmode=%o,user_id=%u,group_id=%u",
+				mo->mntopts, mo->fusedevfd,
+				statbuf->st_mode & S_IFMT,
+				getuid(), getgid());
+
+	return snprintf(buf, bufsz,
+			"fd=%i,rootmode=%o,user_id=%u,group_id=%u",
+			mo->fusedevfd, statbuf->st_mode & S_IFMT,
+			getuid(), getgid());
+}
+
+static int mount_service_regular_mount(struct mount_service *mo,
+				       struct fuse_service_mount_command *oc,
+				       struct stat *stbuf)
+{
+	char *realmopts;
+	const char *mntpt;
+	char buf[32];
+	int ret;
+
+	/* Compute the amount of buffer space needed for the mount options */
+	ret = format_libfuse_mntopts(NULL, 0, mo, stbuf);
+	if (ret < 0) {
+		int error = errno;
+
+		fprintf(stderr, "%s: mount option preformatting: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	realmopts = malloc(ret + 1);
+	if (!realmopts) {
+		int error = errno;
+
+		fprintf(stderr, "%s: alloc real mount options string: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	ret = format_libfuse_mntopts(realmopts, ret + 1, mo, stbuf);
+	if (ret < 0) {
+		int error = errno;
+
+		free(realmopts);
+		fprintf(stderr, "%s: mount options formatting: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	if (mo->mountfd >= 0) {
+		snprintf(buf, sizeof(buf), "/dev/fd/%d", mo->mountfd);
+		mntpt = buf;
+	} else {
+		mntpt = mo->real_mountpoint;
+	}
+	ret = mount(mo->source, mntpt, mo->fstype, ntohl(oc->ms_flags),
+		    realmopts);
+	free(realmopts);
+	if (ret) {
+		int error = errno;
+
+		fprintf(stderr, "%s: mount: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
+static int mount_service_handle_mount_cmd(struct mount_service *mo,
+					  struct fuse_service_packet *p)
+{
+	struct stat stbuf;
+	struct fuse_service_mount_command *oc =
+			container_of(p, struct fuse_service_mount_command, p);
+	int ret;
+
+	if (!mo->fstype) {
+		fprintf(stderr, "%s: missing mount type parameter\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	if (!mo->source) {
+		fprintf(stderr, "%s: missing mount source parameter\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	if (!mo->mountpoint) {
+		fprintf(stderr, "%s: missing mount point parameter\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	/*
+	 * Make sure we can access the mountpoint and that it's either a
+	 * directory or a regular file.  Linux can handle mounting atop special
+	 * files, but we don't care to do such crazy things.
+	 */
+	if (mo->mountfd >= 0)
+		ret = fstat(mo->mountfd, &stbuf);
+	else
+		ret = stat(mo->mountpoint, &stbuf);
+	if (ret < 0) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, mo->mountpoint, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	if (!S_ISDIR(stbuf.st_mode) && !S_ISREG(stbuf.st_mode)) {
+		fprintf(stderr, "%s: %s: Must be a regular file or directory\n",
+			mo->msgtag, mo->mountpoint);
+		return mount_service_send_reply(mo, EACCES);
+	}
+
+	/* Make sure the mountpoint type matches what the caller wanted */
+	switch (ntohs(oc->expected_fmt)) {
+	case S_IFDIR:
+		if (!S_ISDIR(stbuf.st_mode)) {
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, mo->mountpoint, strerror(ENOTDIR));
+			return mount_service_send_reply(mo, ENOTDIR);
+		}
+		break;
+	case S_IFREG:
+		if (!S_ISREG(stbuf.st_mode)) {
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, mo->mountpoint, strerror(EISDIR));
+			return mount_service_send_reply(mo, EISDIR);
+		}
+		break;
+	case 0:
+		/* don't care */
+		break;
+	default:
+		fprintf(stderr, "%s: %s: Weird expected format 0%o\n",
+			mo->msgtag, mo->mountpoint, ntohs(oc->expected_fmt));
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	return mount_service_regular_mount(mo, oc, &stbuf);
+}
+
+static int mount_service_handle_bye_cmd(struct mount_service *mo,
+					struct fuse_service_packet *p)
+{
+	struct fuse_service_bye_command *bc =
+			container_of(p, struct fuse_service_bye_command, p);
+	int ret = ntohl(bc->exitcode);
+
+	if (ret)
+		fprintf(stderr, "%s: fuse server failed mount, check dmesg/logs for details.\n",
+			mo->msgtag);
+
+	return ret;
+}
+
+static void mount_service_destroy(struct mount_service *mo)
+{
+	close(mo->mountfd);
+	close(mo->fusedevfd);
+	close(mo->argvfd);
+	shutdown(mo->sockfd, SHUT_RDWR);
+	close(mo->sockfd);
+
+	free(mo->source);
+	free(mo->mountpoint);
+	free(mo->mntopts);
+	free(mo->fstype);
+
+	memset(mo, 0, sizeof(*mo));
+	mo->sockfd = -1;
+	mo->argvfd = -1;
+	mo->fusedevfd = -1;
+	mo->mountfd = -1;
+}
+
+int mount_service_main(int argc, char *argv[])
+{
+	const char *fusedev = fuse_mnt_get_devname();
+	struct mount_service mo = { };
+	bool running = true;
+	int ret;
+
+	if (argc < 3 || !strcmp(argv[1], "--help")) {
+		printf("Usage: %s source mountpoint -t type [-o options]\n",
+				argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	if (argc > 0 && argv[0])
+		mo.msgtag = argv[0];
+	else
+		mo.msgtag = "mount.service";
+
+	ret = mount_service_init(&mo, argc, argv);
+	if (ret)
+		return EXIT_FAILURE;
+
+	ret = mount_service_connect(&mo);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	ret = mount_service_send_hello(&mo);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	ret = mount_service_capture_args(&mo, argc, argv);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	ret = mount_service_send_required_files(&mo, fusedev);
+	if (ret) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	while (running) {
+		struct fuse_service_packet *p = NULL;
+
+		ret = mount_service_receive_command(&mo, &p);
+		if (ret) {
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		switch (ntohl(p->magic)) {
+		case FUSE_SERVICE_OPEN_CMD:
+			ret = mount_service_handle_open_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_OPEN_BDEV_CMD:
+			ret = mount_service_handle_open_bdev_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_FSOPEN_CMD:
+			ret = mount_service_handle_fsopen_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_SOURCE_CMD:
+			ret = mount_service_handle_source_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_MNTOPTS_CMD:
+			ret = mount_service_handle_mntopts_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_MNTPT_CMD:
+			ret = mount_service_handle_mountpoint_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_MOUNT_CMD:
+			ret = mount_service_handle_mount_cmd(&mo, p);
+			break;
+		case FUSE_SERVICE_BYE_CMD:
+			ret = mount_service_handle_bye_cmd(&mo, p);
+			free(p);
+			goto out;
+		default:
+			fprintf(stderr, "%s: unrecognized packet 0x%x\n",
+				mo.msgtag, ntohl(p->magic));
+			ret = EXIT_FAILURE;
+			break;
+		}
+		free(p);
+
+		if (ret) {
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+	}
+
+	ret = EXIT_SUCCESS;
+out:
+	mount_service_destroy(&mo);
+	return ret;
+}

