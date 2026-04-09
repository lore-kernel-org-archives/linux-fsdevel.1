Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749238A733
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773243; cv=none; b=HLHM4TaKIoQbHMMsRcYsBxXObBKGhFXa3rVhrSVtYHawLjsI4HCVq6MpoaXCd8YOEiZ7PaQf8rQpwtn/jep2SvA2sMYyT4wrSLu6J3vkCnmhKUXT3/svitE79xbbF+CXHK5ssNssK6PprQ2lfeI8OmIo5XvnhGlsTB1qwqPErbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773243; c=relaxed/simple;
	bh=SDWUMLH3Il+4lRgio7/TbUw/JSYyoUWuyVJz3YFv+MY=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Rmod9n1efgfvMZnHNq5dSMve/1kwyDf3HaMrSRUu9lDfx2qlIL7GDixb0COtSjrygtcfTHYdAUEo/44xfWIHnq5kktwTe+WIAofXf3u0BU4R4UakIHv/7Vn8z0oP/744mG8d4kLdUVEM9CDwMEC7Xajo3hFQpvwfhSXohEBWxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwyBHAGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwyBHAGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FB4C4CEF7;
	Thu,  9 Apr 2026 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775773243;
	bh=SDWUMLH3Il+4lRgio7/TbUw/JSYyoUWuyVJz3YFv+MY=;
	h=Date:Subject:From:To:Cc:From;
	b=bwyBHAGSBJHGduNhSpc9ayArFRp1gcZI8PlDY3sGMGhrdXteRWinNbyiuvOQEB4mr
	 rAaVpb2JXSQ5+DrL49qDOfR1RMLZvu/OZi3r89F2jNRpXkYriLiQwbA4hEKRjpsNOC
	 GU1Uaaw5U38913lByw+8erPs9K5f1Q0aQNyUvS5joIg0VSg1qNJKAlxlJfJE0PU7C5
	 XdpajoAErcgCnmNMzXtPTVWJXwPOpG7C+ECp/Qn3wKqU5WiLtJUd23z+gS5QlzLpvM
	 8XCe3CRJJwg2s7Ux3epPc5ztkfXJMasHgICbfLbouLhS//HJW4DR/P38KdDRjsavMQ
	 S7tOUSWvT5w7g==
Date: Thu, 09 Apr 2026 15:20:42 -0700
Subject: [PATCHSET v4] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel's memory.

v4: fix a large number of security problems that only matter when the
    mount helper is being run as a setuid program; fix protocol
    byteswapping problems; add CLOEXEC to all files being traded
    back and forth; add an umount command; and strengthen mount socket
    protocol checks.
v3: refactor the sample code to reduce duplication; fix all the
    checkpatch complaints; examples actually build standalone;
    fuservicemount handles utab now; cleaned up meson feature detection;
    handle MS_ flags that don't translate to MOUNT_ATTR_*
v2: cleaned up error code handling and logging; add some example fuse
    service; fuservicemount3 can now be a setuid program to allow
    unprivileged userspace to fire up a contained filesystem driver.
    This could be opening Pandora's box...
v1: detach from fuse-iomap series

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * Refactor mount code / move common functions to mount_util.c
 * mount_service: add systemd/inetd socket service mounting helper
 * mount_service: create high level fuse helpers
 * mount_service: use the new mount api for the mount service
 * mount_service: update mtab after a successful mount
 * util: hoist the fuse.conf parsing and setuid mode enforcement code
 * util: fix checkpatch complaints in fuser_conf.[ch]
 * mount_service: enable unprivileged users in the same manner as fusermount
 * mount.fuse3: integrate systemd service startup
 * mount_service: allow installation as a setuid program
 * example/service_ll: create a sample systemd service fuse server
 * example/service: create a sample systemd service for a high-level fuse server
 * nullfs: support fuse systemd service mode
---
 example/single_file.h                            |  184 ++
 include/fuse.h                                   |   34 
 include/fuse_service.h                           |  243 +++
 include/fuse_service_priv.h                      |  134 ++
 lib/fuse_i.h                                     |    3 
 lib/mount_common_i.h                             |   22 
 lib/mount_util.h                                 |    8 
 lib/util.h                                       |   35 
 util/fuser_conf.h                                |   53 +
 util/mount_service.h                             |   47 +
 .github/workflows/install-ubuntu-dependencies.sh |   12 
 README.md                                        |    3 
 doc/fuservicemount3.8                            |   32 
 doc/meson.build                                  |    3 
 example/meson.build                              |   26 
 example/null.c                                   |   51 +
 example/null.socket.in                           |   15 
 example/null@.service                            |  102 +
 example/service_hl.c                             |  237 +++
 example/service_hl.socket.in                     |   15 
 example/service_hl@.service                      |  102 +
 example/service_ll.c                             |  309 ++++
 example/service_ll.socket.in                     |   15 
 example/service_ll@.service                      |  102 +
 example/single_file.c                            |  856 ++++++++++
 include/meson.build                              |    4 
 lib/fuse_service.c                               | 1114 +++++++++++++
 lib/fuse_service_stub.c                          |  106 +
 lib/fuse_versionscript                           |   18 
 lib/helper.c                                     |  176 ++
 lib/meson.build                                  |   17 
 lib/mount.c                                      |   72 +
 lib/mount_util.c                                 |    9 
 meson.build                                      |   53 +
 meson_options.txt                                |    9 
 test/ci-build.sh                                 |    7 
 util/fuser_conf.c                                |  369 ++++
 util/fusermount.c                                |  329 ----
 util/fuservicemount.c                            |   66 +
 util/install_helper.sh                           |    6 
 util/meson.build                                 |   24 
 util/mount.fuse.c                                |  135 +-
 util/mount_service.c                             | 1866 ++++++++++++++++++++++
 43 files changed, 6650 insertions(+), 373 deletions(-)
 create mode 100644 example/single_file.h
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 lib/mount_common_i.h
 create mode 100644 util/fuser_conf.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 example/null.socket.in
 create mode 100644 example/null@.service
 create mode 100644 example/service_hl.c
 create mode 100644 example/service_hl.socket.in
 create mode 100644 example/service_hl@.service
 create mode 100644 example/service_ll.c
 create mode 100644 example/service_ll.socket.in
 create mode 100644 example/service_ll@.service
 create mode 100644 example/single_file.c
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuser_conf.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c

The range diff from the 27 March posting is as follows:

 1:  7772a73135e655 !  1:  cc4c087e2ab537 Refactor mount code / move common functions to mount_util.c
    @@ lib/mount.c
      
      #ifndef MS_DIRSYNC
      #define MS_DIRSYNC 128
      #endif
      
      enum {
    -@@ lib/mount.c: static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
    +@@ lib/mount.c: static int fuse_mount_fusermount(const char *mountpoint, const struct mount_opts
      #endif
      
      static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
      			  const char *mnt_opts)
      {
      	char tmp[128];
    @@ lib/mount.c: int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
     +
     +	return type;
     +}
     
      ## lib/mount_util.c ##
     @@ lib/mount_util.c: int fuse_mnt_parse_fuse_fd(const char *mountpoint)
    - 	    len == strlen(mountpoint)) {
    - 		return fd;
    + 		}
    + 		return (int)fd;
      	}
      
      	return -1;
      }
     +
     +#define FUSE_KERN_DEVICE_ENV	"FUSE_KERN_DEVICE"
 2:  2a5e7f1feed3e8 !  2:  110783e2c1ba7d mount_service: add systemd/inetd socket service mounting helper
    @@ include/fuse_service.h (new)
     + * This program can be distributed under the terms of the GNU LGPLv2.
     + * See the file LGPL2.txt.
     + */
     +#ifndef FUSE_SERVICE_H_
     +#define FUSE_SERVICE_H_
     +
    ++/** @file
    ++ *
    ++ * Low level API
    ++ *
    ++ * IMPORTANT: you should define FUSE_USE_VERSION before including this
    ++ * header.  To use the newest API define it to 319 (recommended for any
    ++ * new application).
    ++ */
    ++
    ++#ifndef FUSE_USE_VERSION
    ++#error FUSE_USE_VERSION not defined
    ++#endif
    ++
    ++#include "fuse_common.h"
    ++
     +#ifdef __cplusplus
     +extern "C" {
     +#endif
     +
     +#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
     +
    @@ include/fuse_service.h (new)
     + * @return 0 on success, -1 on failure
     + */
     +int fuse_service_parse_cmdline_opts(struct fuse_args *args,
     +				    struct fuse_cmdline_opts *opts);
     +
     +/**
    ++ * Don't complain if this file cannot be opened.
    ++ */
    ++#define FUSE_SERVICE_REQUEST_FILE_QUIET		(1U << 0)
    ++
    ++/**
     + * Ask the mount.service helper to open a file on behalf of the fuse server.
     + *
     + * @param sf service context
     + * @param path the path to file
     + * @param open_flags O_ flags
     + * @param create_mode mode with which to create the file
    @@ include/fuse_service.h (new)
     + */
     +int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
     +			       mode_t expected_fmt,
     +			       struct fuse_cmdline_opts *opts);
     +
     +/**
    ++ * Ask the mount helper to unmount th e filesystem.
    ++ *
    ++ * @param sf service context
    ++ * @return 0 on success, or negative errno on failure
    ++ */
    ++int fuse_service_session_unmount(struct fuse_service *sf);
    ++
    ++/**
     + * Bid farewell to the mount.service helper.  It is still necessary to call
     + * fuse_service_destroy after this.
     + *
     + * @param sf service context
     + * @param exitcode fuse server process exit status
     + * @return 0 on success, or negative errno on failure
    @@ include/fuse_service_priv.h (new)
     +#define FUSE_SERVICE_OPEN_BDEV_CMD	0x42444556	/* BDEV */
     +#define FUSE_SERVICE_FSOPEN_CMD		0x54595045	/* TYPE */
     +#define FUSE_SERVICE_SOURCE_CMD		0x4e414d45	/* NAME */
     +#define FUSE_SERVICE_MNTOPTS_CMD	0x4f505453	/* OPTS */
     +#define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
     +#define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
    ++#define FUSE_SERVICE_UNMOUNT_CMD	0x554d4e54	/* UMNT */
     +#define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
     +
     +/* mount.service sends replies to the fuse server */
     +#define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
     +#define FUSE_SERVICE_SIMPLE_REPLY	0x5245504c	/* REPL */
     +
    @@ include/fuse_service_priv.h (new)
     +
     +static inline size_t sizeof_fuse_service_requested_file(size_t pathlen)
     +{
     +	return sizeof(struct fuse_service_requested_file) + pathlen + 1;
     +}
     +
    -+#define FUSE_SERVICE_OPEN_FLAGS		(0)
    ++#define FUSE_SERVICE_OPEN_QUIET		(1U << 0)
    ++#define FUSE_SERVICE_OPEN_FLAGS		(FUSE_SERVICE_OPEN_QUIET)
     +
     +struct fuse_service_open_command {
     +	struct fuse_service_packet p;
     +	uint32_t open_flags;
     +	uint32_t create_mode;
     +	uint32_t request_flags;
    @@ include/fuse_service_priv.h (new)
     +struct fuse_service_mount_command {
     +	struct fuse_service_packet p;
     +	uint32_t ms_flags;
     +	uint16_t expected_fmt;
     +};
     +
    ++struct fuse_service_unmount_command {
    ++	struct fuse_service_packet p;
    ++};
    ++
     +int fuse_parse_cmdline_service(struct fuse_args *args,
     +				 struct fuse_cmdline_opts *opts);
     +
     +#define FUSE_SERVICE_ARGV	"argv"
     +#define FUSE_SERVICE_FUSEDEV	"fusedev"
     +
    @@ util/mount_service.h (new)
     + * See the file GPL2.txt.
     + */
     +#ifndef MOUNT_SERVICE_H_
     +#define MOUNT_SERVICE_H_
     +
     +/**
    ++ * Magic value that means that we couldn't connect to the mount service,
    ++ * so the caller should try to fall back to traditional means.
    ++ */
    ++#define MOUNT_SERVICE_FALLBACK_NEEDED	(2)
    ++
    ++/**
     + * Connect to a fuse service socket and try to mount the filesystem as
     + * specified with the CLI arguments.
     + *
     + * @argc argument count
     + * @argv vector of argument strings
    -+ * @return EXIT_SUCCESS for success, EXIT_FAILURE if mount fails
    ++ * @return EXIT_SUCCESS for success, EXIT_FAILURE if mount fails, or 
    ++ *         MOUNT_SERVICE_FALLBACK_NEEDED if no service is available.
     + */
     +int mount_service_main(int argc, char *argv[]);
     +
     +/**
     + * Return the fuse filesystem subtype from a full fuse filesystem type
     + * specification.  IOWs, fuse.Y -> Y; fuseblk.Z -> Z; or A -> A.  The returned
    @@ util/mount_service.h (new)
     + * @return fuse subtype
     + */
     +const char *mount_service_subtype(const char *fstype);
     +
     +#endif /* MOUNT_SERVICE_H_ */
     
    - ## .github/workflows/abicheck.yml ##
    -@@ .github/workflows/abicheck.yml: jobs:
    + ## .github/workflows/install-ubuntu-dependencies.sh ##
    +@@ .github/workflows/install-ubuntu-dependencies.sh: install_full() {
    +         pkg-config:i386 \
    +         liburing-dev \
    +         libnuma-dev \
    +         meson \
    +         ninja-build \
    +         python3 \
    +-        python3-pip
    ++        python3-pip \
    ++        libsystemd-dev \
    ++        systemd-dev
      
    -     steps:
    -       - name: Install dependencies (Ubuntu)
    -         if: runner.os == 'Linux'
    -         run: |
    -           sudo apt-get update
    --          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev
    -+          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev libsystemd-dev systemd-dev
    +     echo "Installing Python test dependencies..."
    +     pip install -r requirements.txt
    + }
      
    -       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
    -         with:
    -           path: current
    + install_codechecker() {
    +@@ .github/workflows/install-ubuntu-dependencies.sh: install_abicheck() {
    +         gcc \
    +         liburing-dev \
    +         libnuma-dev \
    +         meson \
    +         ninja-build \
    +         python3 \
    +-        python3-pip
    ++        python3-pip \
    ++        libsystemd-dev \
    ++        systemd-dev
    + }
      
    -       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
    -
    - ## .github/workflows/abicheck_prev_release.yml ##
    -@@ .github/workflows/abicheck_prev_release.yml: jobs:
    + install_codeql() {
    +     echo "Installing CodeQL dependencies..."
    +     sudo apt-get update
    +     sudo apt-get install -y \
    +         meson \
    +         ninja-build \
    +         python3-pytest \
    +         liburing-dev \
    +-        libnuma-dev
    ++        libnuma-dev \
    ++        libsystemd-dev \
    ++        systemd-dev
    + }
      
    -     steps:
    -       - name: Install dependencies (Ubuntu)
    -         if: runner.os == 'Linux'
    -         run: |
    -           sudo apt-get update
    --          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev
    -+          sudo apt-get -y install abigail-tools clang gcc liburing-dev libnuma-dev libsystemd-dev systemd-dev
    - 
    -       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
    -         with:
    -           path: current
    -           fetch-depth: 0  # Fetch all history and tags
    - 
    -
    - ## .github/workflows/pr-ci.yml ##
    -@@ .github/workflows/pr-ci.yml: jobs:
    -         run: |
    -           sudo dpkg --add-architecture i386
    -           sudo apt-get update
    -           sudo apt-get install -y clang doxygen gcc gcc-10 gcc-9 valgrind \
    -             gcc-multilib g++-multilib libc6-dev-i386 \
    -             libpcap0.8-dev:i386 libudev-dev:i386 pkg-config:i386 \
    --            liburing-dev libnuma-dev
    -+            liburing-dev libnuma-dev libsystemd-dev systemd-dev
    -       - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
    -       - uses: actions/setup-python@v6
    -         with:
    -           python-version: '3.12'
    -       - run: pip install -r requirements.txt
    -       - run: test/ci-build.sh
    + install_cppcheck() {
    +     echo "Installing cppcheck..."
    +     sudo apt-get update
    +     sudo apt-get install -y cppcheck
     
      ## doc/fuservicemount3.8 (new) ##
     @@
     +.TH fuservicemount3 "8"
     +.SH NAME
     +fuservicemount3 \- mount a FUSE filesystem that runs as a system socket service
    @@ lib/fuse_service.c (new)
     +#include <sys/un.h>
     +#include <unistd.h>
     +#include <sys/stat.h>
     +#include <fcntl.h>
     +#include <systemd/sd-daemon.h>
     +#include <arpa/inet.h>
    ++#include <limits.h>
     +
     +#include "fuse_config.h"
     +#include "fuse_i.h"
     +#include "fuse_service_priv.h"
     +#include "fuse_service.h"
     +#include "mount_common_i.h"
    @@ lib/fuse_service.c (new)
     +	};
     +	struct cmsghdr *cmsg;
     +	ssize_t size;
     +
     +	memset(&cmsgu, 0, sizeof(cmsgu));
     +
    -+	size = recvmsg(sockfd, &msg, MSG_TRUNC);
    ++	size = recvmsg(sockfd, &msg, MSG_TRUNC | MSG_CMSG_CLOEXEC);
     +	if (size < 0) {
     +		int error = errno;
     +
     +		fuse_log(FUSE_LOG_ERR, "fuse: service file reply: %s\n",
     +			 strerror(error));
     +		return -error;
    @@ lib/fuse_service.c (new)
     +	}
     +
     +	ret = __recv_fd(sockfd, req, req_sz, &fd);
     +	if (ret)
     +		goto out_req;
     +
    -+	if (req->p.magic != ntohl(FUSE_SERVICE_OPEN_REPLY)) {
    ++	if (ntohl(req->p.magic) != FUSE_SERVICE_OPEN_REPLY) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: service file reply contains wrong magic!\n");
     +		ret = -EBADMSG;
     +		goto out_close;
     +	}
     +	if (strcmp(req->path, path)) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: `%s': not the requested service file, got `%s'\n",
    @@ lib/fuse_service.c (new)
     +int fuse_service_receive_file(struct fuse_service *sf, const char *path,
     +			      int *fdp)
     +{
     +	return recv_requested_file(sf->sockfd, path, fdp);
     +}
     +
    -+#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(0)
    ++#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(FUSE_SERVICE_REQUEST_FILE_QUIET)
     +
     +static int fuse_service_request_path(struct fuse_service *sf, const char *path,
     +				     mode_t expected_fmt, int open_flags,
     +				     mode_t create_mode,
     +				     unsigned int request_flags,
     +				     unsigned int block_size)
    @@ lib/fuse_service.c (new)
     +	if (request_flags & ~FUSE_SERVICE_REQUEST_FILE_FLAGS) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: invalid fuse service file request flags 0x%x\n",
     +			 request_flags);
     +		return -EINVAL;
     +	}
     +
    ++	if (request_flags & FUSE_SERVICE_REQUEST_FILE_QUIET)
    ++		rqflags |= FUSE_SERVICE_OPEN_QUIET;
    ++
     +	cmd = calloc(1, iov.iov_len);
     +	if (!cmd) {
     +		int error = errno;
     +
     +		fuse_log(FUSE_LOG_ERR, "fuse: alloc service file request: %s\n",
     +			 strerror(error));
    @@ lib/fuse_service.c (new)
     +	shutdown(sf->sockfd, SHUT_RDWR);
     +	close(sf->sockfd);
     +	sf->sockfd = -1;
     +	return 0;
     +}
     +
    -+static int find_socket_fd(void)
    ++static int count_listen_fds(void)
     +{
    -+	struct stat statbuf;
    -+	struct sockaddr_un urk;
     +	char *listen_fds;
    -+	socklen_t urklen = sizeof(urk);
    -+	int nr_fds;
    -+	int ret;
    ++	char *listen_pid;
    ++	char *p;
    ++	long l;
     +
     +	/*
    -+	 * No environment variable means we're not running as a system socket
    ++	 * No environment variables means we're not running as a system socket
     +	 * service, so we'll back out without logging anything.
     +	 */
     +	listen_fds = getenv("LISTEN_FDS");
    -+	if (!listen_fds)
    -+		return -ENOENT;
    ++	listen_pid = getenv("LISTEN_PID");
    ++	if (!listen_fds || !listen_pid)
    ++		return 0;
    ++
    ++	/*
    ++	 * LISTEN_PID is the pid of the process to which systemd thinks it gave
    ++	 * the socket fd.  Hopefully that's us.
    ++	 */
    ++	errno = 0;
    ++	l = strtol(listen_pid, &p, 10);
    ++	if (errno || *p != 0 || l != getpid())
    ++		return 0;
    ++
    ++	/*
    ++	 * LISTEN_FDS is the number of sockets that were opened in this
    ++	 * process.
    ++	 */
    ++	errno = 0;
    ++	l = strtol(listen_fds, &p, 10);
    ++	if (errno || *p != 0 || l > INT_MAX || l < 0)
    ++		return 0;
    ++
    ++	return l;
    ++}
    ++
    ++static int find_socket_fd(int nr_fds)
    ++{
    ++	struct stat statbuf;
    ++	struct sockaddr_un urk;
    ++	socklen_t urklen = sizeof(urk);
    ++	int ret;
     +
    -+	nr_fds = atoi(listen_fds);
     +	if (nr_fds != 1) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: can only handle 1 service socket, got %d.\n",
     +			 nr_fds);
     +		return -E2BIG;
     +	}
     +
    @@ lib/fuse_service.c (new)
     +	if (size != sizeof(hello)) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: wrong service hello size %zd, expected %zd\n",
     +			 size, sizeof(hello));
     +		return -EBADMSG;
     +	}
     +
    -+	if (hello.p.magic != ntohl(FUSE_SERVICE_HELLO_CMD)) {
    ++	if (ntohl(hello.p.magic) != FUSE_SERVICE_HELLO_CMD) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: service server did not send hello command\n");
     +		return -EBADMSG;
     +	}
     +
     +	if (ntohs(hello.min_version) < FUSE_SERVICE_MIN_PROTO) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: unsupported min service protocol version %u\n",
    @@ lib/fuse_service.c (new)
     +	return 0;
     +}
     +
     +int fuse_service_accept(struct fuse_service **sfp)
     +{
     +	struct fuse_service *sf;
    ++	int nr_fds;
    ++	int sockfd;
    ++	int flags;
     +	int ret = 0;
     +
     +	*sfp = NULL;
     +
    ++	nr_fds = count_listen_fds();
    ++	if (nr_fds == 0)
    ++		return 0;
    ++
    ++	/* Find the socket that connects us to mount.service */
    ++	sockfd = find_socket_fd(nr_fds);
    ++	if (sockfd < 0)
    ++		return sockfd;
    ++
    ++	flags = fcntl(sockfd, F_GETFD);
    ++	if (flags < 0) {
    ++		int error = errno;
    ++
    ++		fuse_log(FUSE_LOG_ERR, "fuse: service socket getfd: %s\n",
    ++			 strerror(error));
    ++		return -error;
    ++	}
    ++
    ++	if (!(flags & FD_CLOEXEC)) {
    ++		ret = fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
    ++		if (ret) {
    ++			int error = errno;
    ++
    ++			fuse_log(FUSE_LOG_ERR, "fuse: service socket set cloexec: %s\n",
    ++				 strerror(error));
    ++			return -error;
    ++		}
    ++	}
    ++
     +	sf = calloc(1, sizeof(struct fuse_service));
     +	if (!sf) {
     +		int error = errno;
     +
     +		fuse_log(FUSE_LOG_ERR, "fuse: service alloc: %s\n",
     +			 strerror(error));
     +		return -error;
     +	}
    -+
    -+	/* Find the socket that connects us to mount.service */
    -+	ret = find_socket_fd();
    -+	if (ret == -ENOENT) {
    -+		/*
    -+		 * No socket found, so we're not running as a service.  Don't
    -+		 * fail the request, but leave *sfp set to NULL.
    -+		 */
    -+		ret = 0;
    -+		goto out_sf;
    -+	}
    -+	if (ret < 0)
    -+		goto out_sf;
    -+	sf->sockfd = ret;
    ++	sf->sockfd = sockfd;
     +
     +	ret = negotiate_hello(sf);
     +	if (ret)
     +		goto out_sf;
     +
     +	/* Receive the two critical sockets */
    @@ lib/fuse_service.c (new)
     +	ret = recv_requested_file(sf->sockfd, FUSE_SERVICE_FUSEDEV,
     +				  &sf->fusedevfd);
     +	if (ret < 0)
     +		goto out_argvfd;
     +	if (sf->fusedevfd < 0) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: service fuse device: %s\n",
    -+			 strerror(-sf->argvfd));
    -+		ret = sf->argvfd;
    ++			 strerror(-sf->fusedevfd));
    ++		ret = sf->fusedevfd;
     +		goto out_argvfd;
     +	}
     +
     +	sf->owns_fusedevfd = true;
     +	*sfp = sf;
     +	return 0;
    @@ lib/fuse_service.c (new)
     +		return -EBADMSG;
     +	}
     +	if (ntohl(memfd_args.magic) != FUSE_SERVICE_ARGS_MAGIC) {
     +		fuse_log(FUSE_LOG_ERR, "fuse: service args file corrupt\n");
     +		return -EBADMSG;
     +	}
    -+	memfd_args.magic = ntohl(memfd_args.magic);
    -+	memfd_args.argc = ntohl(memfd_args.argc);
    ++	memfd_args.magic = htonl(memfd_args.magic);
    ++	memfd_args.argc = htonl(memfd_args.argc);
     +	memfd_pos += sizeof(memfd_args);
     +
     +	/* Allocate a new array of argv string pointers */
     +	new_args.argv = calloc(memfd_args.argc + existing_args->argc,
     +			       sizeof(char *));
     +	if (!new_args.argv) {
    @@ lib/fuse_service.c (new)
     +			fuse_log(FUSE_LOG_ERR,
     +				 "fuse: service args file argv[%u] iovec short read %zd",
     +				 i, received);
     +			ret = -EBADMSG;
     +			goto out_new_args;
     +		}
    -+		memfd_arg.pos = ntohl(memfd_arg.pos);
    -+		memfd_arg.len = ntohl(memfd_arg.len);
    ++		memfd_arg.pos = htonl(memfd_arg.pos);
    ++		memfd_arg.len = htonl(memfd_arg.len);
     +		memfd_pos += sizeof(memfd_arg);
     +
     +		/* read arg string from file */
     +		str = calloc(1, memfd_arg.len + 1);
     +		if (!str) {
     +			int error = errno;
    @@ lib/fuse_service.c (new)
     +		int error = errno;
     +
     +		fuse_log(FUSE_LOG_ERR, "fuse: alloc service string send: %s\n",
     +			 strerror(error));
     +		return -error;
     +	}
    -+	cmd->p.magic = ntohl(command);
    ++	cmd->p.magic = htonl(command);
     +	strcpy(cmd->value, value);
     +	iov.iov_base = cmd;
     +
     +	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
     +	if (size < 0) {
     +		int error = errno;
    @@ lib/fuse_service.c (new)
     +	free(mntopts);
     +	free(source);
     +	free(fstype);
     +	return ret;
     +}
     +
    ++int fuse_service_session_unmount(struct fuse_service *sf)
    ++{
    ++	struct fuse_service_simple_reply reply = { };
    ++	struct fuse_service_unmount_command c = {
    ++		.p.magic = htonl(FUSE_SERVICE_UNMOUNT_CMD),
    ++	};
    ++	struct iovec iov = {
    ++		.iov_base = &c,
    ++		.iov_len = sizeof(c),
    ++	};
    ++	struct msghdr msg = {
    ++		.msg_iov = &iov,
    ++		.msg_iovlen = 1,
    ++	};
    ++	ssize_t size;
    ++
    ++	/* already gone? */
    ++	if (sf->sockfd < 0)
    ++		return 0;
    ++
    ++	size = sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
    ++	if (size < 0) {
    ++		int error = errno;
    ++
    ++		fuse_log(FUSE_LOG_ERR, "fuse: send service unmount: %s\n",
    ++			 strerror(error));
    ++		return -error;
    ++	}
    ++
    ++	iov.iov_base = &reply;
    ++	iov.iov_len = sizeof(reply);
    ++	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
    ++	if (size < 0) {
    ++		int error = errno;
    ++
    ++		fuse_log(FUSE_LOG_ERR, "fuse: service unmount reply: %s\n",
    ++			 strerror(error));
    ++		return -error;
    ++	}
    ++	if (size != sizeof(reply)) {
    ++		fuse_log(FUSE_LOG_ERR, "fuse: wrong service unmount reply size %zd, expected %zd\n",
    ++			size, sizeof(reply));
    ++		return -EBADMSG;
    ++	}
    ++
    ++	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
    ++		fuse_log(FUSE_LOG_ERR, "fuse: service unmount reply contains wrong magic!\n");
    ++		return -EBADMSG;
    ++	}
    ++
    ++	if (reply.error) {
    ++		int error = ntohl(reply.error);
    ++
    ++		fuse_log(FUSE_LOG_ERR, "fuse: service unmount: %s\n",
    ++			 strerror(error));
    ++		return -error;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
     +void fuse_service_release(struct fuse_service *sf)
     +{
     +	if (sf->owns_fusedevfd)
     +		close(sf->fusedevfd);
     +	sf->owns_fusedevfd = false;
     +	sf->fusedevfd = -1;
    @@ lib/fuse_service_stub.c (new)
     +	return -EOPNOTSUPP;
     +}
     +
     +int fuse_service_accept(struct fuse_service **sfp)
     +{
     +	*sfp = NULL;
    -+	return -EOPNOTSUPP;
    ++	return 0;
     +}
     +
     +int fuse_service_append_args(struct fuse_service *sf,
     +			     struct fuse_args *existing_args)
     +{
     +	return -EOPNOTSUPP;
     +}
     +
    ++char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args)
    ++{
    ++	return NULL;
    ++}
    ++
     +int fuse_service_finish_file_requests(struct fuse_service *sf)
     +{
     +	return -EOPNOTSUPP;
     +}
     +
     +void fuse_service_expect_mount_mode(struct fuse_service *sf,
    @@ lib/fuse_service_stub.c (new)
     +			       mode_t expected_fmt,
     +			       struct fuse_cmdline_opts *opts)
     +{
     +	return -EOPNOTSUPP;
     +}
     +
    ++int fuse_service_session_unmount(struct fuse_service *sf)
    ++{
    ++	return -EOPNOTSUPP;
    ++}
    ++
     +void fuse_service_release(struct fuse_service *sf)
     +{
     +}
     +
     +void fuse_service_destroy(struct fuse_service **sfp)
     +{
    @@ lib/fuse_versionscript: FUSE_3.18 {
     +		fuse_service_receive_file;
     +		fuse_service_release;
     +		fuse_service_request_file;
     +		fuse_service_request_blockdev;
     +		fuse_service_send_goodbye;
     +		fuse_service_session_mount;
    ++		fuse_service_session_unmount;
      } FUSE_3.18;
      
      # Local Variables:
      # indent-tabs-mode: t
      # End:
     
    @@ lib/helper.c
      #define FUSE_HELPER_OPT(t, p) \
      	{ t, offsetof(struct fuse_cmdline_opts, p), 1 }
      
      static const struct fuse_opt fuse_helper_opts[] = {
      	FUSE_HELPER_OPT("-h",		show_help),
      	FUSE_HELPER_OPT("--help",	show_help),
    -@@ lib/helper.c: static int fuse_helper_opt_proc(void *data, const char *arg, int key,
    - 	default:
    - 		/* Pass through unknown options */
    - 		return 1;
    - 	}
    +@@ lib/helper.c: int fuse_parse_cmdline_312(struct fuse_args *args,
    + 		if (add_default_subtype(args->argv[0], args) == -1)
    + 			return -1;
    + 
    + 	return 0;
      }
      
     +#ifdef HAVE_SERVICEMOUNT
     +static int fuse_helper_opt_proc_service(void *data, const char *arg, int key,
     +					struct fuse_args *outargs)
     +{
    @@ lib/helper.c: static int fuse_helper_opt_proc(void *data, const char *arg, int k
     +		return -1;
     +	default:
     +		/* Pass through unknown options */
     +		return 1;
     +	}
     +}
    -+#endif
     +
    - /* Under FreeBSD, there is no subtype option so this
    -    function actually sets the fsname */
    - static int add_default_subtype(const char *progname, struct fuse_args *args)
    - {
    - 	int res;
    - 	char *subtype_opt;
    -@@ lib/helper.c: int fuse_parse_cmdline_312(struct fuse_args *args,
    - 		if (add_default_subtype(args->argv[0], args) == -1)
    - 			return -1;
    - 
    - 	return 0;
    - }
    - 
    -+#ifdef HAVE_SERVICEMOUNT
     +int fuse_parse_cmdline_service(struct fuse_args *args,
     +			       struct fuse_cmdline_opts *opts)
     +{
     +	memset(opts, 0, sizeof(struct fuse_cmdline_opts));
     +
     +	opts->max_idle_threads = UINT_MAX; /* new default in fuse version 3.12 */
    @@ lib/meson.build: libfuse = library('fuse3',
                                    + '/fuse_versionscript' ])
      
     +vars = []
     +if private_cfg.get('HAVE_SERVICEMOUNT', false)
     +  service_socket_dir = private_cfg.get_unquoted('FUSE_SERVICE_SOCKET_DIR', '')
     +  vars += ['service_socket_dir=' + service_socket_dir]
    ++  vars += ['service_socket_perms=' + service_socket_perms]
     +endif
      pkg = import('pkgconfig')
      pkg.generate(libraries: [ libfuse, '-lpthread' ],
                   libraries_private: '-ldl',
                   version: meson.project_version(),
                   name: 'fuse3',
    @@ meson.build: args_default = [ '-D_GNU_SOURCE' ]
      # Feature detection, only available at libfuse compilation time,
      # but not for application linking to libfuse.
      #
      private_cfg = configuration_data()
      private_cfg.set_quoted('PACKAGE_VERSION', meson.project_version())
     +service_socket_dir = get_option('service-socket-dir')
    ++service_socket_perms = get_option('service-socket-perms')
     +if service_socket_dir == ''
     +  service_socket_dir = '/run/filesystems'
     +endif
    ++if service_socket_perms == ''
    ++  service_socket_perms = '0220'
    ++endif
     +private_cfg.set_quoted('FUSE_SERVICE_SOCKET_DIR', service_socket_dir)
    ++private_cfg.set('FUSE_SERVICE_SOCKET_PERMS', service_socket_perms)
      
      # Test for presence of some functions
      test_funcs = [ 'fork', 'fstatat', 'openat', 'readlinkat', 'pipe2',
                     'splice', 'vmsplice', 'posix_fallocate', 'fdatasync',
                     'utimensat', 'copy_file_range', 'fallocate', 'fspacectl' ]
      foreach func : test_funcs
    @@ meson.build: if get_option('enable-io-uring') and liburing.found() and libnuma.f
                    dependencies: [liburing])
            private_cfg.set('HAVE_URING', true)
         endif
      endif
      
     +# Check for systemd support
    -+systemd_system_unit_dir = get_option('systemdsystemunitdir')
    ++systemd_system_unit_dir = get_option('systemd-system-unit-dir')
     +if systemd_system_unit_dir == ''
     +  systemd = dependency('systemd', required: false)
     +  if systemd.found()
     +     systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
     +  endif
     +endif
    @@ meson_options.txt: option('disable-libc-symbol-version', type : 'boolean', value
      option('enable-io-uring', type: 'boolean', value: true,
             description: 'Enable fuse-over-io-uring support')
     +
     +option('service-socket-dir', type : 'string', value : '',
     +       description: 'Where to install fuse server sockets (if empty, /run/filesystems)')
     +
    -+option('systemdsystemunitdir', type : 'string', value : '',
    ++option('service-socket-perms', type : 'string', value : '',
    ++       description: 'Default fuse server socket permissions (if empty, 0220)')
    ++
    ++option('systemd-system-unit-dir', type : 'string', value : '',
     +       description: 'Where to install systemd unit files (if empty, query pkg-config(1))')
     
      ## util/fuservicemount.c (new) ##
     @@
     +/*
     + * FUSE: Filesystem in Userspace
    @@ util/meson.build: fuseconf_path = join_paths(get_option('prefix'), get_option('s
     +if private_cfg.get('HAVE_SERVICEMOUNT', false)
     +  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c'],
     +             include_directories: include_dirs,
     +             link_with: [ libfuse ],
     +             install: true,
     +             install_dir: get_option('sbindir'),
    -+             c_args: '-DFUSE_USE_VERSION=317')
    ++             c_args: '-DFUSE_USE_VERSION=319')
     +endif
     +
      executable('mount.fuse3', ['mount.fuse.c'],
                 include_directories: include_dirs,
                 link_with: [ libfuse ],
                 install: true,
    @@ util/mount_service.c (new)
     + *
     + * This program does the mounting of FUSE filesystems that run in systemd
     + */
     +#define _GNU_SOURCE
     +#include "fuse_config.h"
     +#include <stdint.h>
    ++#include <string.h>
    ++#include <stdio.h>
    ++#include <stdlib.h>
    ++#include <unistd.h>
    ++#include <errno.h>
    ++#include <fcntl.h>
    ++#include <stdbool.h>
    ++#include <limits.h>
    ++#include <arpa/inet.h>
    ++#include <sys/socket.h>
    ++#include <sys/un.h>
     +#include <sys/mman.h>
    -+#include <string.h>
    -+#include <stdio.h>
    -+#include <stdlib.h>
    -+#include <unistd.h>
    -+#include <sys/socket.h>
    -+#include <sys/un.h>
    -+#include <errno.h>
    -+#include <fcntl.h>
     +#include <sys/mount.h>
    -+#include <stdbool.h>
    -+#include <limits.h>
     +#include <sys/stat.h>
    -+#include <arpa/inet.h>
    ++#include <sys/ioctl.h>
    ++#include <linux/fs.h>
     +
     +#include "mount_util.h"
     +#include "util.h"
     +#include "fuse_i.h"
     +#include "fuse_service_priv.h"
     +#include "mount_service.h"
    @@ util/mount_service.c (new)
     +	char *source;
     +
     +	/* target argument (aka mountpoint) to mount() */
     +	char *mountpoint;
     +
     +	/* mountpoint that we pass to mount() */
    -+	const char *real_mountpoint;
    ++	char *real_mountpoint;
    ++
    ++	/* resolved path to mountpoint that we use for mtab updates */
    ++	char *resv_mountpoint;
     +
     +	/* mount options */
     +	char *mntopts;
     +
     +	/* socket fd */
     +	int sockfd;
    @@ util/mount_service.c (new)
     +	/* /dev/fuse device */
     +	int fusedevfd;
     +
     +	/* memfd for cli arguments */
     +	int argvfd;
     +
    -+	/* O_PATH fd for mount point */
    ++	/* fd for mount point */
     +	int mountfd;
    ++
    ++	/* did we actually mount successfully? */
    ++	bool mounted;
     +};
     +
    -+/* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
    ++/* Filter out the subtype of the filesystem (e.g. fuse.Y[.Z] -> Y[.Z]) */
     +const char *mount_service_subtype(const char *fstype)
     +{
    -+	char *period = strrchr(fstype, '.');
    -+
    -+	if (period)
    -+		return period + 1;
    -+
    ++	if (!strncmp(fstype, "fuse.", 5))
    ++		return fstype + 5;
    ++	if (!strncmp(fstype, "fuseblk.", 8))
    ++		return fstype + 8;
     +	return fstype;
     +}
     +
     +static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
     +{
     +	char *fstype = NULL;
    @@ util/mount_service.c (new)
     +	int sockfd;
     +	ssize_t written;
     +	int ret;
     +
     +	written = snprintf(name.sun_path, sizeof(name.sun_path),
     +			FUSE_SERVICE_SOCKET_DIR "/%s", mo->subtype);
    -+	if (written > sizeof(name.sun_path)) {
    ++	if (written >= sizeof(name.sun_path)) {
     +		fprintf(stderr, "%s: filesystem type name `%s' is too long.\n",
     +			mo->msgtag, mo->subtype);
     +		return -1;
     +	}
     +
    -+	sockfd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
    ++	sockfd = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
     +	if (sockfd < 0) {
     +		fprintf(stderr, "%s: opening %s service socket: %s\n",
     +			mo->msgtag, mo->subtype, strerror(errno));
     +		return -1;
     +	}
     +
     +	ret = connect(sockfd, (const struct sockaddr *)&name, sizeof(name));
    ++	if (ret && (errno == ENOENT || errno == ECONNREFUSED)) {
    ++		fprintf(stderr, "%s: no safe filesystem driver for %s available.\n",
    ++			mo->msgtag, mo->subtype);
    ++		close(sockfd);
    ++		return MOUNT_SERVICE_FALLBACK_NEEDED;
    ++	}
     +	if (ret) {
    -+		if (errno == ENOENT)
    -+			fprintf(stderr, "%s: no safe filesystem driver for %s available.\n",
    -+				mo->msgtag, mo->subtype);
    -+		else
    -+			fprintf(stderr, "%s: %s: %s\n",
    -+				mo->msgtag, name.sun_path, strerror(errno));
    ++		fprintf(stderr, "%s: %s: %s\n",
    ++			mo->msgtag, name.sun_path, strerror(errno));
     +		goto out;
     +	}
     +
     +	ret = try_drop_passrights(mo, sockfd);
     +	if (ret)
     +		goto out;
    @@ util/mount_service.c (new)
     +	if (size != sizeof(reply)) {
     +		fprintf(stderr, "%s: wrong hello reply size %zd, expected %zd\n",
     +			mo->msgtag, size, sizeof(reply));
     +		return -1;
     +	}
     +
    -+	if (reply.p.magic != ntohl(FUSE_SERVICE_HELLO_REPLY)) {
    ++	if (ntohl(reply.p.magic) != FUSE_SERVICE_HELLO_REPLY) {
     +		fprintf(stderr, "%s: %s service server did not reply to hello\n",
     +			mo->msgtag, mo->subtype);
     +		return -1;
     +	}
     +
     +	if (ntohs(reply.version) < FUSE_SERVICE_MIN_PROTO ||
    @@ util/mount_service.c (new)
     +	}
     +
     +	ret = mount_service_send_file(mo, FUSE_SERVICE_ARGV, mo->argvfd);
     +	if (ret)
     +		goto out_fusedevfd;
     +
    ++	close(mo->argvfd);
    ++	mo->argvfd = -1;
    ++
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
    -+					 struct fuse_service_packet **commandp)
    ++					 struct fuse_service_packet **commandp,
    ++					 size_t *commandsz)
     +{
     +	struct iovec iov = {
     +	};
     +	struct msghdr msg = {
     +		.msg_iov = &iov,
     +		.msg_iovlen = 1,
    @@ util/mount_service.c (new)
     +	}
     +	if (size < sizeof(struct fuse_service_packet)) {
     +		fprintf(stderr, "%s: wrong command packet size %zd, expected at least %zd\n",
     +			mo->msgtag, size, sizeof(struct fuse_service_packet));
     +		return -1;
     +	}
    ++	if (size > 32768) {
    ++		fprintf(stderr, "%s: wrong command packet size %zd, expected less than %d\n",
    ++			mo->msgtag, size, 32768);
    ++		return -1;
    ++	}
     +
     +	command = calloc(1, size + 1);
     +	if (!command) {
     +		fprintf(stderr, "%s: alloc service command: %s\n",
     +			mo->msgtag, strerror(errno));
     +		return -1;
    @@ util/mount_service.c (new)
     +			size, iov.iov_len);
     +		free(command);
     +		return -1;
     +	}
     +
     +	*commandp = command;
    ++	*commandsz = size;
     +	return 0;
     +}
     +
     +static int mount_service_send_reply(struct mount_service *mo, int error)
     +{
     +	struct fuse_service_simple_reply reply = {
    @@ util/mount_service.c (new)
     +}
     +
     +static int prepare_bdev(struct mount_service *mo,
     +			struct fuse_service_open_command *oc, int fd)
     +{
     +	struct stat statbuf;
    -+	int block_size;
     +	int ret;
     +
     +	ret = fstat(fd, &statbuf);
     +	if (ret) {
     +		int error = errno;
     +
    @@ util/mount_service.c (new)
     +	if (!S_ISBLK(statbuf.st_mode)) {
     +		fprintf(stderr, "%s: %s: %s\n",
     +			mo->msgtag, oc->path, strerror(ENOTBLK));
     +		return -ENOTBLK;
     +	}
     +
    -+	if (!oc->block_size)
    -+		return 0;
    -+	block_size = ntohl(oc->block_size);
    ++	if (oc->block_size) {
    ++		int block_size = ntohl(oc->block_size);
     +
    -+	ret = ioctl(fd, BLKBSZSET, &block_size);
    -+	if (ret) {
    -+		int error = errno;
    ++		ret = ioctl(fd, BLKBSZSET, &block_size);
    ++		if (ret) {
    ++			int error = errno;
     +
    -+		fprintf(stderr, "%s: %s: %s\n",
    -+			mo->msgtag, oc->path, strerror(error));
    -+		return -error;
    ++			fprintf(stderr, "%s: %s: %s\n",
    ++				mo->msgtag, oc->path, strerror(error));
    ++			return -error;
    ++		}
     +	}
     +
     +	return 0;
     +}
     +
    -+static int mount_service_handle_open_path(struct mount_service *mo,
    -+					  mode_t expected_fmt,
    -+					  struct fuse_service_packet *p)
    ++static inline bool check_null_endbyte(const void *p, size_t psz)
    ++{
    ++	return *((const char *)p + psz - 1) == 0;
    ++}
    ++
    ++static int mount_service_open_path(struct mount_service *mo,
    ++				   mode_t expected_fmt,
    ++				   struct fuse_service_packet *p, size_t psz)
     +{
     +	struct fuse_service_open_command *oc =
     +			container_of(p, struct fuse_service_open_command, p);
    -+	uint32_t request_flags = ntohl(oc->request_flags);
    ++	uint32_t request_flags;
     +	int ret;
     +	int fd;
     +
    -+	if (request_flags & ~FUSE_SERVICE_OPEN_FLAGS)
    ++	if (psz < sizeof_fuse_service_open_command(1)) {
    ++		fprintf(stderr, "%s: open command too small\n",
    ++			mo->msgtag);
    ++		return mount_service_send_file_error(mo, EINVAL, "?");
    ++	}
    ++
    ++	if (!check_null_endbyte(p, psz)) {
    ++		fprintf(stderr, "%s: open command must be null terminated\n",
    ++			mo->msgtag);
    ++		return mount_service_send_file_error(mo, EINVAL, "?");
    ++	}
    ++
    ++	request_flags = ntohl(oc->request_flags);
    ++	if (request_flags & ~FUSE_SERVICE_OPEN_FLAGS) {
    ++		fprintf(stderr, "%s: open flags 0x%x not recognized\n",
    ++			mo->msgtag, request_flags & ~FUSE_SERVICE_OPEN_FLAGS);
     +		return mount_service_send_file_error(mo, EINVAL, oc->path);
    ++	}
     +
     +	fd = open(oc->path, ntohl(oc->open_flags), ntohl(oc->create_mode));
     +	if (fd < 0) {
     +		int error = errno;
     +
     +		/*
     +		 * Don't print a busy device error report because the
     +		 * filesystem might decide to retry.
     +		 */
    -+		if (error != EBUSY)
    ++		if (error != EBUSY && !(request_flags & FUSE_SERVICE_OPEN_QUIET))
     +			fprintf(stderr, "%s: %s: %s\n",
     +				mo->msgtag, oc->path, strerror(error));
     +		return mount_service_send_file_error(mo, error, oc->path);
     +	}
     +
     +	if (S_ISBLK(expected_fmt)) {
    @@ util/mount_service.c (new)
     +	ret = mount_service_send_file(mo, oc->path, fd);
     +	close(fd);
     +	return ret;
     +}
     +
     +static int mount_service_handle_open_cmd(struct mount_service *mo,
    -+					 struct fuse_service_packet *p)
    ++					 struct fuse_service_packet *p,
    ++					 size_t psz)
     +{
    -+	return mount_service_handle_open_path(mo, 0, p);
    ++	return mount_service_open_path(mo, 0, p, psz);
     +}
     +
     +static int mount_service_handle_open_bdev_cmd(struct mount_service *mo,
    -+					      struct fuse_service_packet *p)
    ++					      struct fuse_service_packet *p,
    ++					      size_t psz)
     +{
    -+	return mount_service_handle_open_path(mo, S_IFBLK, p);
    ++	return mount_service_open_path(mo, S_IFBLK, p, psz);
     +}
     +
     +static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
    -+					   const struct fuse_service_packet *p)
    ++					   const struct fuse_service_packet *p,
    ++					   size_t psz)
     +{
     +	struct fuse_service_string_command *oc =
     +			container_of(p, struct fuse_service_string_command, p);
     +
    ++	if (psz < sizeof_fuse_service_string_command(1)) {
    ++		fprintf(stderr, "%s: fsopen command too small\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	if (!check_null_endbyte(p, psz)) {
    ++		fprintf(stderr, "%s: fsopen command must be null terminated\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
     +	if (mo->fstype) {
     +		fprintf(stderr, "%s: fstype respecified!\n",
     +			mo->msgtag);
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
    @@ util/mount_service.c (new)
     +	}
     +
     +	return mount_service_send_reply(mo, 0);
     +}
     +
     +static int mount_service_handle_source_cmd(struct mount_service *mo,
    -+					   const struct fuse_service_packet *p)
    ++					   const struct fuse_service_packet *p,
    ++					   size_t psz)
     +{
     +	struct fuse_service_string_command *oc =
     +			container_of(p, struct fuse_service_string_command, p);
     +
    ++	if (psz < sizeof_fuse_service_string_command(1)) {
    ++		fprintf(stderr, "%s: source command too small\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	if (!check_null_endbyte(p, psz)) {
    ++		fprintf(stderr, "%s: source command must be null terminated\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
     +	if (mo->source) {
     +		fprintf(stderr, "%s: source respecified!\n",
     +			mo->msgtag);
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
    @@ util/mount_service.c (new)
     +	}
     +
     +	return mount_service_send_reply(mo, 0);
     +}
     +
     +static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
    -+					    const struct fuse_service_packet *p)
    ++					    const struct fuse_service_packet *p,
    ++					    size_t psz)
     +{
     +	struct fuse_service_string_command *oc =
     +			container_of(p, struct fuse_service_string_command, p);
     +
    ++	if (psz < sizeof_fuse_service_string_command(1)) {
    ++		fprintf(stderr, "%s: mount options command too small\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	if (!check_null_endbyte(p, psz)) {
    ++		fprintf(stderr, "%s: mount options command must be null terminated\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
     +	if (mo->mntopts) {
     +		fprintf(stderr, "%s: mount options respecified!\n",
     +			mo->msgtag);
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
    @@ util/mount_service.c (new)
     +		return mount_service_send_reply(mo, error);
     +	}
     +
     +	return mount_service_send_reply(mo, 0);
     +}
     +
    ++static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
    ++{
    ++	struct stat statbuf;
    ++	char *res_mntpt;
    ++	int mountfd = -1;
    ++	int error;
    ++	int ret;
    ++
    ++	/*
    ++	 * Open the alleged mountpoint, make sure it's a dir or a file.
    ++	 */
    ++	mountfd = open(mntpt, O_RDONLY | O_CLOEXEC);
    ++	if (mountfd < 0) {
    ++		error = errno;
    ++		fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mntpt,
    ++			strerror(error));
    ++		goto out_error;
    ++	}
    ++
    ++	ret = fstat(mountfd, &statbuf);
    ++	if (ret) {
    ++		error = errno;
    ++		fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mntpt,
    ++			strerror(error));
    ++		goto out_mountfd;
    ++	}
    ++
    ++	if (!S_ISDIR(statbuf.st_mode) && !S_ISREG(statbuf.st_mode)) {
    ++		error = EACCES;
    ++		fprintf(stderr, "%s: %s: Mount point must be directory or regular file.\n",
    ++			mo->msgtag, mntpt);
    ++		goto out_mountfd;
    ++	}
    ++
    ++	/*
    ++	 * Resolve the (possibly relative) mountpoint path before chdir'ing
    ++	 * onto it.
    ++	 */
    ++	res_mntpt = fuse_mnt_resolve_path(mo->msgtag, mntpt);
    ++	if (!res_mntpt) {
    ++		error = EACCES;
    ++		fprintf(stderr, "%s: %s: Could not resolve path to mount point.\n",
    ++			mo->msgtag, mntpt);
    ++		goto out_mountfd;
    ++	}
    ++
    ++	switch (statbuf.st_mode & S_IFMT) {
    ++	case S_IFREG:
    ++		/*
    ++		 * This is a regular file, so we point mount() at the open file
    ++		 * descriptor.
    ++		 */
    ++		asprintf(&mo->real_mountpoint, "/dev/fd/%d", mountfd);
    ++		break;
    ++	case S_IFDIR:
    ++		/*
    ++		 * Pin the mount so it can't go anywhere.  This only works for
    ++		 * directories, which is fortunately the common case.
    ++		 */
    ++		ret = fchdir(mountfd);
    ++		if (ret) {
    ++			error = errno;
    ++			fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mntpt,
    ++				strerror(error));
    ++			goto out_res_mntpt;
    ++		}
    ++
    ++		/*
    ++		 * Now that we're sitting on the mountpoint directory, we can
    ++		 * pass "." to mount() and avoid races with directory tree
    ++		 * mutations.
    ++		 */
    ++		mo->real_mountpoint = strdup(".");
    ++		break;
    ++	default:
    ++		/* Should never get here */
    ++		error = EINVAL;
    ++		goto out_res_mntpt;
    ++	}
    ++	if (!mo->real_mountpoint) {
    ++		error = ENOMEM;
    ++		fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mntpt,
    ++			strerror(error));
    ++		goto out_res_mntpt;
    ++	}
    ++
    ++	mo->mountpoint = mntpt;
    ++	mo->mountfd = mountfd;
    ++	mo->resv_mountpoint = res_mntpt;
    ++
    ++	return mount_service_send_reply(mo, 0);
    ++
    ++out_res_mntpt:
    ++	free(res_mntpt);
    ++out_mountfd:
    ++	close(mountfd);
    ++out_error:
    ++	free(mntpt);
    ++	return mount_service_send_reply(mo, error);
    ++}
    ++
     +static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
    -+					       const struct fuse_service_packet *p)
    ++					       const struct fuse_service_packet *p,
    ++					       size_t psz)
     +{
     +	struct fuse_service_string_command *oc =
     +			container_of(p, struct fuse_service_string_command, p);
    -+	int ret;
    ++	char *mntpt;
    ++
    ++	if (psz < sizeof_fuse_service_string_command(1)) {
    ++		fprintf(stderr, "%s: mount point command too small\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	if (!check_null_endbyte(p, psz)) {
    ++		fprintf(stderr, "%s: mount point command must be null terminated\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
     +
     +	if (mo->mountpoint) {
     +		fprintf(stderr, "%s: mount point respecified!\n",
     +			mo->msgtag);
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
    -+#ifdef O_PATH
    -+	mo->mountfd = open(oc->value, O_PATH);
    -+	if (mo->mountfd < 0) {
    -+		int error = errno;
    -+
    -+		fprintf(stderr, "%s: %s: %s\n",
    -+			mo->msgtag, oc->value, strerror(error));
    -+		return mount_service_send_reply(mo, error);
    -+	}
    -+#else
    -+	mo->mountfd = -1;
    -+#endif
    -+
    -+	mo->mountpoint = strdup(oc->value);
    -+	if (!mo->mountpoint) {
    ++	mntpt = strdup(oc->value);
    ++	if (!mntpt) {
     +		int error = errno;
     +
     +		fprintf(stderr, "%s: alloc mount point string: %s\n",
     +			mo->msgtag, strerror(error));
     +		return mount_service_send_reply(mo, error);
     +	}
    -+	mo->real_mountpoint = mo->mountpoint;
     +
    -+	ret = chdir(oc->value);
    -+	if (ret) {
    -+		if (errno != ENOTDIR) {
    -+			int error = errno;
    -+
    -+			fprintf(stderr, "%s: %s: %s\n",
    -+				mo->msgtag, oc->value, strerror(error));
    -+			return mount_service_send_reply(mo, error);
    -+		}
    -+
    -+		/* not a directory */
    -+	} else {
    -+		/*
    -+		 * Now that we're sitting on the mountpoint directory, we can
    -+		 * pass "." to mount() and avoid races with directory tree
    -+		 * mutations.
    -+		 */
    -+		mo->real_mountpoint = ".";
    -+	}
    -+
    -+	return mount_service_send_reply(mo, 0);
    ++	return attach_to_mountpoint(mo, mntpt);
     +}
     +
     +static inline int format_libfuse_mntopts(char *buf, size_t bufsz,
     +					 const struct mount_service *mo,
     +					 const struct stat *statbuf)
     +{
    @@ util/mount_service.c (new)
     +
     +static int mount_service_regular_mount(struct mount_service *mo,
     +				       struct fuse_service_mount_command *oc,
     +				       struct stat *stbuf)
     +{
     +	char *realmopts;
    -+	const char *mntpt;
    -+	char buf[32];
     +	int ret;
     +
     +	/* Compute the amount of buffer space needed for the mount options */
     +	ret = format_libfuse_mntopts(NULL, 0, mo, stbuf);
     +	if (ret < 0) {
     +		int error = errno;
    @@ util/mount_service.c (new)
     +		free(realmopts);
     +		fprintf(stderr, "%s: mount options formatting: %s\n",
     +			mo->msgtag, strerror(error));
     +		return mount_service_send_reply(mo, error);
     +	}
     +
    -+	if (mo->mountfd >= 0) {
    -+		snprintf(buf, sizeof(buf), "/dev/fd/%d", mo->mountfd);
    -+		mntpt = buf;
    -+	} else {
    -+		mntpt = mo->real_mountpoint;
    -+	}
    -+	ret = mount(mo->source, mntpt, mo->fstype, ntohl(oc->ms_flags),
    -+		    realmopts);
    ++	ret = mount(mo->source, mo->real_mountpoint, mo->fstype,
    ++		    ntohl(oc->ms_flags), realmopts);
     +	free(realmopts);
     +	if (ret) {
     +		int error = errno;
     +
     +		fprintf(stderr, "%s: mount: %s\n",
     +			mo->msgtag, strerror(error));
     +		return mount_service_send_reply(mo, error);
     +	}
     +
    ++	mo->mounted = true;
     +	return mount_service_send_reply(mo, 0);
     +}
     +
     +static int mount_service_handle_mount_cmd(struct mount_service *mo,
    -+					  struct fuse_service_packet *p)
    ++					  struct fuse_service_packet *p,
    ++					  size_t psz)
     +{
     +	struct stat stbuf;
     +	struct fuse_service_mount_command *oc =
     +			container_of(p, struct fuse_service_mount_command, p);
     +	int ret;
     +
    ++	if (psz != sizeof(struct fuse_service_mount_command)) {
    ++		fprintf(stderr, "%s: mount command wrong size\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
     +	if (!mo->fstype) {
     +		fprintf(stderr, "%s: missing mount type parameter\n",
     +			mo->msgtag);
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
    @@ util/mount_service.c (new)
     +
     +	/*
     +	 * Make sure we can access the mountpoint and that it's either a
     +	 * directory or a regular file.  Linux can handle mounting atop special
     +	 * files, but we don't care to do such crazy things.
     +	 */
    -+	if (mo->mountfd >= 0)
    -+		ret = fstat(mo->mountfd, &stbuf);
    -+	else
    -+		ret = stat(mo->mountpoint, &stbuf);
    ++	ret = fstat(mo->mountfd, &stbuf);
     +	if (ret < 0) {
     +		int error = errno;
     +
     +		fprintf(stderr, "%s: %s: %s\n",
     +			mo->msgtag, mo->mountpoint, strerror(error));
     +		return mount_service_send_reply(mo, error);
     +	}
     +
    -+	if (!S_ISDIR(stbuf.st_mode) && !S_ISREG(stbuf.st_mode)) {
    -+		fprintf(stderr, "%s: %s: Must be a regular file or directory\n",
    -+			mo->msgtag, mo->mountpoint);
    -+		return mount_service_send_reply(mo, EACCES);
    -+	}
    -+
     +	/* Make sure the mountpoint type matches what the caller wanted */
     +	switch (ntohs(oc->expected_fmt)) {
     +	case S_IFDIR:
     +		if (!S_ISDIR(stbuf.st_mode)) {
     +			fprintf(stderr, "%s: %s: %s\n",
     +				mo->msgtag, mo->mountpoint, strerror(ENOTDIR));
    @@ util/mount_service.c (new)
     +		}
     +		break;
     +	case 0:
     +		/* don't care */
     +		break;
     +	default:
    -+		fprintf(stderr, "%s: %s: Weird expected format 0%o\n",
    ++		fprintf(stderr, "%s: %s: weird expected format 0%o\n",
     +			mo->msgtag, mo->mountpoint, ntohs(oc->expected_fmt));
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
     +	return mount_service_regular_mount(mo, oc, &stbuf);
     +}
     +
    ++static int mount_service_handle_unmount_cmd(struct mount_service *mo,
    ++					    struct fuse_service_packet *p,
    ++					    size_t psz)
    ++{
    ++	int ret;
    ++
    ++	(void)p;
    ++
    ++	if (psz != sizeof(struct fuse_service_unmount_command)) {
    ++		fprintf(stderr, "%s: unmount command wrong size\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	if (!mo->mounted) {
    ++		fprintf(stderr, "%s: will not umount before successful mount!\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	ret = chdir("/");
    ++	if (ret) {
    ++		int error = errno;
    ++
    ++		fprintf(stderr, "%s: fuse server failed chdir: %s\n",
    ++			mo->msgtag, strerror(error));
    ++		return mount_service_send_reply(mo, error);
    ++	}
    ++
    ++	close(mo->mountfd);
    ++	mo->mountfd = -1;
    ++
    ++	/*
    ++	 * Try to unmount the resolved mountpoint, and hope that we're not the
    ++	 * victim of a race.
    ++	 */
    ++	ret = umount2(mo->resv_mountpoint, MNT_DETACH);
    ++	if (ret) {
    ++		int error = errno;
    ++
    ++		fprintf(stderr, "%s: fuse server failed unmount: %s\n",
    ++			mo->msgtag, strerror(error));
    ++		return mount_service_send_reply(mo, error);
    ++	}
    ++
    ++	mo->mounted = false;
    ++	return mount_service_send_reply(mo, 0);
    ++}
    ++
     +static int mount_service_handle_bye_cmd(struct mount_service *mo,
    -+					struct fuse_service_packet *p)
    ++					struct fuse_service_packet *p,
    ++					size_t psz)
     +{
     +	struct fuse_service_bye_command *bc =
     +			container_of(p, struct fuse_service_bye_command, p);
    -+	int ret = ntohl(bc->exitcode);
    ++	int ret;
     +
    ++	if (psz != sizeof(struct fuse_service_bye_command)) {
    ++		fprintf(stderr, "%s: bye command wrong size\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	ret = ntohl(bc->exitcode);
     +	if (ret)
     +		fprintf(stderr, "%s: fuse server failed mount, check dmesg/logs for details.\n",
     +			mo->msgtag);
     +
     +	return ret;
     +}
    @@ util/mount_service.c (new)
     +	close(mo->argvfd);
     +	shutdown(mo->sockfd, SHUT_RDWR);
     +	close(mo->sockfd);
     +
     +	free(mo->source);
     +	free(mo->mountpoint);
    ++	free(mo->real_mountpoint);
    ++	free(mo->resv_mountpoint);
     +	free(mo->mntopts);
     +	free(mo->fstype);
     +
     +	memset(mo, 0, sizeof(*mo));
     +	mo->sockfd = -1;
     +	mo->argvfd = -1;
    @@ util/mount_service.c (new)
     +
     +	ret = mount_service_init(&mo, argc, argv);
     +	if (ret)
     +		return EXIT_FAILURE;
     +
     +	ret = mount_service_connect(&mo);
    ++	if (ret == MOUNT_SERVICE_FALLBACK_NEEDED)
    ++		goto out;
     +	if (ret) {
     +		ret = EXIT_FAILURE;
     +		goto out;
     +	}
     +
     +	ret = mount_service_send_hello(&mo);
    @@ util/mount_service.c (new)
     +		ret = EXIT_FAILURE;
     +		goto out;
     +	}
     +
     +	while (running) {
     +		struct fuse_service_packet *p = NULL;
    ++		size_t sz;
     +
    -+		ret = mount_service_receive_command(&mo, &p);
    ++		ret = mount_service_receive_command(&mo, &p, &sz);
     +		if (ret) {
     +			ret = EXIT_FAILURE;
     +			goto out;
     +		}
     +
     +		switch (ntohl(p->magic)) {
     +		case FUSE_SERVICE_OPEN_CMD:
    -+			ret = mount_service_handle_open_cmd(&mo, p);
    ++			ret = mount_service_handle_open_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_OPEN_BDEV_CMD:
    -+			ret = mount_service_handle_open_bdev_cmd(&mo, p);
    ++			ret = mount_service_handle_open_bdev_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_FSOPEN_CMD:
    -+			ret = mount_service_handle_fsopen_cmd(&mo, p);
    ++			ret = mount_service_handle_fsopen_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_SOURCE_CMD:
    -+			ret = mount_service_handle_source_cmd(&mo, p);
    ++			ret = mount_service_handle_source_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_MNTOPTS_CMD:
    -+			ret = mount_service_handle_mntopts_cmd(&mo, p);
    ++			ret = mount_service_handle_mntopts_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_MNTPT_CMD:
    -+			ret = mount_service_handle_mountpoint_cmd(&mo, p);
    ++			ret = mount_service_handle_mountpoint_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_MOUNT_CMD:
    -+			ret = mount_service_handle_mount_cmd(&mo, p);
    ++			ret = mount_service_handle_mount_cmd(&mo, p, sz);
    ++			break;
    ++		case FUSE_SERVICE_UNMOUNT_CMD:
    ++			ret = mount_service_handle_unmount_cmd(&mo, p, sz);
     +			break;
     +		case FUSE_SERVICE_BYE_CMD:
    -+			ret = mount_service_handle_bye_cmd(&mo, p);
    ++			ret = mount_service_handle_bye_cmd(&mo, p, sz);
     +			free(p);
     +			goto out;
     +		default:
     +			fprintf(stderr, "%s: unrecognized packet 0x%x\n",
     +				mo.msgtag, ntohl(p->magic));
     +			ret = EXIT_FAILURE;
 3:  b15a7e75fc2067 <  -:  -------------- mount_service: create high level fuse helpers
 -:  -------------- >  3:  31c157f517bb31 mount_service: create high level fuse helpers
 4:  dfadaa6315ce03 !  4:  8b1af8ccf4b0bf mount_service: use the new mount api for the mount service
    @@ Commit message
     
         Use the new fsopen/fsmount system calls to mount the filesystem so that
         we get somewhat better diagnostics if something gets screwed up.
     
         Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
     
    + ## lib/fuse_i.h ##
    +@@ lib/fuse_i.h: struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
    +  * Drop counted reference to a channel
    +  *
    +  * @param ch the channel
    +  */
    + void fuse_chan_put(struct fuse_chan *ch);
    + 
    ++/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
    ++#define FUSE_MOUNT_FALLBACK_NEEDED (-2)
    ++
    + struct mount_opts *parse_mount_opts(struct fuse_args *args);
    + void destroy_mount_opts(struct mount_opts *mo);
    + void fuse_mount_version(void);
    + unsigned int get_max_read(const struct mount_opts *o);
    + void fuse_kern_unmount(const char *mountpoint, int fd);
    + int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
    +
      ## meson.build ##
     @@ meson.build: special_funcs = {
          'systemd_headers': '''
      	#include <systemd/sd-daemon.h>
      
      	int main(int argc, char *argv[]) {
    @@ meson.build: special_funcs = {
     +       #include <fcntl.h>
     +
     +       int main(void) {
     +           int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
     +           int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
     +           int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
    -+           res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
    ++           res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH);
     +           return 0;
     +       }
          '''
      }
      
      foreach name, code : special_funcs
          private_cfg.set('HAVE_' + name.to_upper(),
              cc.links(code, args: args_default,
     
      ## util/mount_service.c ##
     @@ util/mount_service.c: struct mount_service {
    - 
      	/* memfd for cli arguments */
      	int argvfd;
      
    - 	/* O_PATH fd for mount point */
    + 	/* fd for mount point */
      	int mountfd;
    -+
    + 
     +	/* fd for fsopen */
     +	int fsopenfd;
    ++
    + 	/* did we actually mount successfully? */
    + 	bool mounted;
      };
      
    - /* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
    + /* Filter out the subtype of the filesystem (e.g. fuse.Y[.Z] -> Y[.Z]) */
      const char *mount_service_subtype(const char *fstype)
    - {
    - 	char *period = strrchr(fstype, '.');
     @@ util/mount_service.c: static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
      	int i;
      
      	mo->sockfd = -1;
      	mo->argvfd = -1;
      	mo->fusedevfd = -1;
    @@ util/mount_service.c: static int mount_service_init(struct mount_service *mo, in
      
      	for (i = 0; i < argc; i++) {
      		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
      			fstype = argv[i + 1];
      			break;
      		}
    +@@ util/mount_service.c: static int mount_service_handle_open_bdev_cmd(struct mount_service *mo,
    + 					      struct fuse_service_packet *p,
    + 					      size_t psz)
    + {
    + 	return mount_service_open_path(mo, S_IFBLK, p, psz);
    + }
    + 
    ++#ifdef HAVE_NEW_MOUNT_API
    ++static void try_fsopen(struct mount_service *mo,
    ++		       struct fuse_service_string_command *oc)
    ++{
    ++	/*
    ++	 * As of Linux 7.0 you can pass subtypes to fsopen, but the manpage for
    ++	 * fsopen only says that you can pass any value of the second column of
    ++	 * /proc/filesystems into fsopen.
    ++	 */
    ++	if (!strncmp(oc->value, "fuse.", 5))
    ++		*(oc->value + 4) = 0;
    ++	else if (!strncmp(oc->value, "fuseblk.", 8))
    ++		*(oc->value + 7) = 0;
    ++
    ++	mo->fsopenfd = fsopen(oc->value, FSOPEN_CLOEXEC);
    ++}
    ++#else
    ++# define try_fsopen(...)	((void)0)
    ++#endif
    ++
    + static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
    + 					   const struct fuse_service_packet *p,
    + 					   size_t psz)
    + {
    + 	struct fuse_service_string_command *oc =
    + 			container_of(p, struct fuse_service_string_command, p);
     @@ util/mount_service.c: static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
      
      		fprintf(stderr, "%s: alloc fstype string: %s\n",
      			mo->msgtag, strerror(error));
      		return mount_service_send_reply(mo, error);
      	}
      
    -+#ifdef HAVE_NEW_MOUNT_API
    -+	/* If this fails we fall back on mount() */
    -+	mo->fsopenfd = fsopen(oc->value, FSOPEN_CLOEXEC);
    -+#endif
    -+
    ++	/* If this fails we fall back on mount(); oc->value is mutated */
    ++	try_fsopen(mo, oc);
      	return mount_service_send_reply(mo, 0);
      }
      
     +#ifdef HAVE_NEW_MOUNT_API
     +/* callers must preserve errno */
     +static void emit_fsconfig_messages(const struct mount_service *mo)
     +{
     +	uint8_t buf[BUFSIZ];
     +	ssize_t sz;
     +
    -+	while ((sz = read(mo->fsopenfd, buf, sizeof(buf) - 1)) != -1) {
    -+		if (sz <= 0)
    -+			continue;
    ++	while ((sz = read(mo->fsopenfd, buf, sizeof(buf) - 1)) >= 1) {
     +		if (buf[sz - 1] == '\n')
     +			buf[--sz] = '\0';
     +		else
     +			buf[sz] = '\0';
     +
     +		if (!*buf)
    @@ util/mount_service.c: static int mount_service_handle_fsopen_cmd(struct mount_se
     +		}
     +	}
     +}
     +#endif
     +
      static int mount_service_handle_source_cmd(struct mount_service *mo,
    - 					   const struct fuse_service_packet *p)
    + 					   const struct fuse_service_packet *p,
    + 					   size_t psz)
      {
      	struct fuse_service_string_command *oc =
      			container_of(p, struct fuse_service_string_command, p);
    - 
     @@ util/mount_service.c: static int mount_service_handle_source_cmd(struct mount_service *mo,
      
      		fprintf(stderr, "%s: alloc source string: %s\n",
      			mo->msgtag, strerror(error));
      		return mount_service_send_reply(mo, error);
      	}
    @@ util/mount_service.c: static int mount_service_handle_source_cmd(struct mount_se
     +#endif
     +
      	return mount_service_send_reply(mo, 0);
      }
      
      static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
    - 					    const struct fuse_service_packet *p)
    + 					    const struct fuse_service_packet *p,
    + 					    size_t psz)
      {
      	struct fuse_service_string_command *oc =
      			container_of(p, struct fuse_service_string_command, p);
     +	char *tokstr = oc->value;
     +	char *tok, *savetok;
      
    - 	if (mo->mntopts) {
    - 		fprintf(stderr, "%s: mount options respecified!\n",
    + 	if (psz < sizeof_fuse_service_string_command(1)) {
    + 		fprintf(stderr, "%s: mount options command too small\n",
      			mo->msgtag);
      		return mount_service_send_reply(mo, EINVAL);
      	}
     @@ util/mount_service.c: static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
      
      		fprintf(stderr, "%s: alloc mount options string: %s\n",
    @@ util/mount_service.c: static int mount_service_handle_mntopts_cmd(struct mount_s
     +		tokstr = NULL;
     +	}
     +
      	return mount_service_send_reply(mo, 0);
      }
      
    - static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
    - 					       const struct fuse_service_packet *p)
    + static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
      {
    + 	struct stat statbuf;
     @@ util/mount_service.c: static int mount_service_regular_mount(struct mount_service *mo,
    - 		return mount_service_send_reply(mo, error);
      	}
      
    + 	mo->mounted = true;
      	return mount_service_send_reply(mo, 0);
      }
      
     +#ifdef HAVE_NEW_MOUNT_API
     +struct ms_to_mount_map {
     +	unsigned long ms_flag;
    @@ util/mount_service.c: static int mount_service_regular_mount(struct mount_servic
     +
     +	/*
     +	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
     +	 * or string flags!  Return a magic code so the caller will fall back
     +	 * to regular mount(2).
     +	 */
    -+	return ms_flags ? -2 : 0;
    ++	if (ms_flags)
    ++		return FUSE_MOUNT_FALLBACK_NEEDED;
    ++
    ++	return 0;
     +}
     +
     +static int mount_service_fsopen_mount(struct mount_service *mo,
     +				      struct fuse_service_mount_command *oc,
     +				      struct stat *stbuf)
     +{
    @@ util/mount_service.c: static int mount_service_regular_mount(struct mount_servic
     +	int error;
     +	int ret;
     +
     +	get_mount_attr_flags(oc, &attr_flags, &ms_flags);
     +
     +	ret = set_ms_flags(mo, ms_flags);
    -+	if (ret == -2)
    ++	if (ret == FUSE_MOUNT_FALLBACK_NEEDED)
     +		return ret;
     +	if (ret) {
     +		error = errno;
     +		goto fail_mount;
     +	}
     +
    @@ util/mount_service.c: static int mount_service_regular_mount(struct mount_servic
     +	dot = strchr(mo->fstype, '.');
     +	if (dot) {
     +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "subtype",
     +			       dot + 1, 0);
     +		if (ret) {
     +			error = errno;
    ++
    ++			/* The subtype option came after fsopen */
    ++			if (error == EINVAL)
    ++				return FUSE_MOUNT_FALLBACK_NEEDED;
    ++
     +			fprintf(stderr, "%s: set subtype option: %s\n",
     +				mo->msgtag, strerror(error));
     +			goto fail_fsconfig;
     +		}
     +	}
     +
    @@ util/mount_service.c: static int mount_service_regular_mount(struct mount_servic
     +		error = errno;
     +		fprintf(stderr, "%s: move_mount: %s\n",
     +			mo->msgtag, strerror(error));
     +		goto fail_mount;
     +	}
     +
    ++	mo->mounted = true;
     +	return mount_service_send_reply(mo, 0);
     +
     +fail_fsconfig:
     +	emit_fsconfig_messages(mo);
     +fail_mount:
     +	return mount_service_send_reply(mo, error);
     +}
     +#else
    -+# define mount_service_fsopen_mount(...)	(-2)
    ++# define mount_service_fsopen_mount(...)	(FUSE_MOUNT_FALLBACK_NEEDED)
     +#endif
     +
      static int mount_service_handle_mount_cmd(struct mount_service *mo,
    - 					  struct fuse_service_packet *p)
    + 					  struct fuse_service_packet *p,
    + 					  size_t psz)
      {
      	struct stat stbuf;
      	struct fuse_service_mount_command *oc =
    - 			container_of(p, struct fuse_service_mount_command, p);
     @@ util/mount_service.c: static int mount_service_handle_mount_cmd(struct mount_service *mo,
      	default:
    - 		fprintf(stderr, "%s: %s: Weird expected format 0%o\n",
    + 		fprintf(stderr, "%s: %s: weird expected format 0%o\n",
      			mo->msgtag, mo->mountpoint, ntohs(oc->expected_fmt));
      		return mount_service_send_reply(mo, EINVAL);
      	}
      
     +	if (mo->fsopenfd >= 0) {
     +		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
    -+		if (ret != -2)
    ++		if (ret != FUSE_MOUNT_FALLBACK_NEEDED)
     +			return ret;
     +	}
     +
      	return mount_service_regular_mount(mo, oc, &stbuf);
      }
      
    - static int mount_service_handle_bye_cmd(struct mount_service *mo,
    - 					struct fuse_service_packet *p)
    - {
    + static int mount_service_handle_unmount_cmd(struct mount_service *mo,
    + 					    struct fuse_service_packet *p,
    + 					    size_t psz)
     @@ util/mount_service.c: static int mount_service_handle_bye_cmd(struct mount_service *mo,
      
      static void mount_service_destroy(struct mount_service *mo)
      {
      	close(mo->mountfd);
      	close(mo->fusedevfd);
    @@ util/mount_service.c: static int mount_service_handle_bye_cmd(struct mount_servi
     +	close(mo->fsopenfd);
      	shutdown(mo->sockfd, SHUT_RDWR);
      	close(mo->sockfd);
      
      	free(mo->source);
      	free(mo->mountpoint);
    - 	free(mo->mntopts);
    + 	free(mo->real_mountpoint);
     @@ util/mount_service.c: static void mount_service_destroy(struct mount_service *mo)
      
      	memset(mo, 0, sizeof(*mo));
      	mo->sockfd = -1;
      	mo->argvfd = -1;
      	mo->fusedevfd = -1;
 5:  14e93185778efa !  5:  3459dcf34974c7 mount_service: update mtab after a successful mount
    @@ Commit message
         the root filesystem.
     
         Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## include/fuse_service_priv.h ##
     @@ include/fuse_service_priv.h: struct fuse_service_memfd_argv {
    - #define FUSE_SERVICE_FSOPEN_CMD		0x54595045	/* TYPE */
      #define FUSE_SERVICE_SOURCE_CMD		0x4e414d45	/* NAME */
      #define FUSE_SERVICE_MNTOPTS_CMD	0x4f505453	/* OPTS */
      #define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
      #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
    + #define FUSE_SERVICE_UNMOUNT_CMD	0x554d4e54	/* UMNT */
      #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
     +#define FUSE_SERVICE_MTABOPTS_CMD	0x4d544142	/* MTAB */
      
      /* mount.service sends replies to the fuse server */
      #define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
      #define FUSE_SERVICE_SIMPLE_REPLY	0x5245504c	/* REPL */
    @@ lib/mount.c: char *fuse_mnt_kernel_opts(const struct mount_opts *mo)
      {
      	return mo->flags;
      }
     
      ## util/mount_service.c ##
     @@ util/mount_service.c: struct mount_service {
    - 	/* mountpoint that we pass to mount() */
    - 	const char *real_mountpoint;
    + 	/* resolved path to mountpoint that we use for mtab updates */
    + 	char *resv_mountpoint;
      
      	/* mount options */
      	char *mntopts;
      
     +	/* mtab options */
     +	char *mtabopts;
    @@ util/mount_service.c: static int mount_service_handle_mntopts_cmd(struct mount_s
      	}
      
      	return mount_service_send_reply(mo, 0);
      }
      
     +static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
    -+					     const struct fuse_service_packet *p)
    ++					     const struct fuse_service_packet *p,
    ++					     size_t psz)
     +{
     +	struct fuse_service_string_command *oc =
     +			container_of(p, struct fuse_service_string_command, p);
     +
    ++	if (psz < sizeof_fuse_service_string_command(1)) {
    ++		fprintf(stderr, "%s: mtab options command too small\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
    ++	if (!check_null_endbyte(p, psz)) {
    ++		fprintf(stderr, "%s: mtab options command must be null terminated\n",
    ++			mo->msgtag);
    ++		return mount_service_send_reply(mo, EINVAL);
    ++	}
    ++
     +	if (mo->mtabopts) {
     +		fprintf(stderr, "%s: mtab options respecified!\n",
     +			mo->msgtag);
     +		return mount_service_send_reply(mo, EINVAL);
     +	}
     +
    @@ util/mount_service.c: static int mount_service_handle_mntopts_cmd(struct mount_s
     +		return mount_service_send_reply(mo, error);
     +	}
     +
     +	return mount_service_send_reply(mo, 0);
     +}
     +
    - static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
    - 					       const struct fuse_service_packet *p)
    + static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
      {
    - 	struct fuse_service_string_command *oc =
    - 			container_of(p, struct fuse_service_string_command, p);
    - 	int ret;
    + 	struct stat statbuf;
    + 	char *res_mntpt;
    + 	int mountfd = -1;
    + 	int error;
     @@ util/mount_service.c: static int mount_service_regular_mount(struct mount_service *mo,
      
      		fprintf(stderr, "%s: mount: %s\n",
      			mo->msgtag, strerror(error));
      		return mount_service_send_reply(mo, error);
      	}
      
     +	/*
     +	 * The mount succeeded, so we send a positive reply even if the mtab
     +	 * update fails.
     +	 */
     +	if (mo->mtabopts)
    -+		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->mountpoint,
    ++		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->resv_mountpoint,
     +				   mo->fstype, mo->mtabopts);
     +
    + 	mo->mounted = true;
      	return mount_service_send_reply(mo, 0);
      }
      
      #ifdef HAVE_NEW_MOUNT_API
      struct ms_to_mount_map {
    - 	unsigned long ms_flag;
     @@ util/mount_service.c: static int mount_service_fsopen_mount(struct mount_service *mo,
      		error = errno;
      		fprintf(stderr, "%s: move_mount: %s\n",
      			mo->msgtag, strerror(error));
      		goto fail_mount;
      	}
      
     +	/*
     +	 * The mount succeeded, so we send a positive reply even if the mtab
     +	 * update fails.
     +	 */
     +	if (mo->mtabopts)
    -+		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->mountpoint,
    ++		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->resv_mountpoint,
     +				   mo->fstype, mo->mtabopts);
     +
    + 	mo->mounted = true;
      	return mount_service_send_reply(mo, 0);
      
      fail_fsconfig:
      	emit_fsconfig_messages(mo);
      fail_mount:
    - 	return mount_service_send_reply(mo, error);
    +@@ util/mount_service.c: static int mount_service_handle_unmount_cmd(struct mount_service *mo,
    + 
    + 		fprintf(stderr, "%s: fuse server failed unmount: %s\n",
    + 			mo->msgtag, strerror(error));
    + 		return mount_service_send_reply(mo, error);
    + 	}
    + 
    ++	/*
    ++	 * The unmount succeeded, so we send a positive reply even if the mtab
    ++	 * update fails.
    ++	 */
    ++	if (mo->mtabopts)
    ++		fuse_mnt_remove_mount(mo->msgtag, mo->resv_mountpoint);
    ++
    + 	mo->mounted = false;
    + 	return mount_service_send_reply(mo, 0);
    + }
    + 
    + static int mount_service_handle_bye_cmd(struct mount_service *mo,
    + 					struct fuse_service_packet *p,
     @@ util/mount_service.c: static void mount_service_destroy(struct mount_service *mo)
    - 	close(mo->fsopenfd);
    - 	shutdown(mo->sockfd, SHUT_RDWR);
      	close(mo->sockfd);
      
      	free(mo->source);
      	free(mo->mountpoint);
    + 	free(mo->real_mountpoint);
    + 	free(mo->resv_mountpoint);
     +	free(mo->mtabopts);
      	free(mo->mntopts);
      	free(mo->fstype);
      
      	memset(mo, 0, sizeof(*mo));
      	mo->sockfd = -1;
      	mo->argvfd = -1;
     @@ util/mount_service.c: int mount_service_main(int argc, char *argv[])
      		case FUSE_SERVICE_MNTOPTS_CMD:
    - 			ret = mount_service_handle_mntopts_cmd(&mo, p);
    + 			ret = mount_service_handle_mntopts_cmd(&mo, p, sz);
      			break;
      		case FUSE_SERVICE_MNTPT_CMD:
    - 			ret = mount_service_handle_mountpoint_cmd(&mo, p);
    + 			ret = mount_service_handle_mountpoint_cmd(&mo, p, sz);
      			break;
     +		case FUSE_SERVICE_MTABOPTS_CMD:
    -+			ret = mount_service_handle_mtabopts_cmd(&mo, p);
    ++			ret = mount_service_handle_mtabopts_cmd(&mo, p, sz);
     +			break;
      		case FUSE_SERVICE_MOUNT_CMD:
    - 			ret = mount_service_handle_mount_cmd(&mo, p);
    + 			ret = mount_service_handle_mount_cmd(&mo, p, sz);
    + 			break;
    + 		case FUSE_SERVICE_UNMOUNT_CMD:
    + 			ret = mount_service_handle_unmount_cmd(&mo, p, sz);
      			break;
    - 		case FUSE_SERVICE_BYE_CMD:
    - 			ret = mount_service_handle_bye_cmd(&mo, p);
    - 			free(p);
 6:  4834a22f31fca6 !  6:  3c8e031fd672ee util: hoist the fuse.conf parsing code
    @@
      ## Metadata ##
     Author: Darrick J. Wong <djwong@kernel.org>
     
      ## Commit message ##
    -    util: hoist the fuse.conf parsing code
    +    util: hoist the fuse.conf parsing and setuid mode enforcement code
     
         Move all the code that parses fuse.conf into a separate file in util/ so
    -    that fuservicemount can read the same file.  We'll add the limit
    -    enforcement in separate patches.
    +    that fuservicemount can read the same file, then add the security checks
    +    that occur when fusermount is trying to start up a filesystem but is not
    +    running as root.  We'll want that for fusermount in a moment.
     
         Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## util/fuser_conf.h (new) ##
     @@
     +/*
    @@ util/fuser_conf.h (new)
     + * This program can be distributed under the terms of the GNU LGPLv2.
     + * See the file LGPL2.txt.
     + */
     +#ifndef FUSER_CONF_H_
     +#define FUSER_CONF_H_
     +
    ++#include <sys/vfs.h>
    ++#include <sys/stat.h>
    ++
     +extern int user_allow_other;
     +extern int mount_max;
     +
     +void unescape(char *buf);
     +
     +#ifdef GETMNTENT_NEEDS_UNESCAPING
    ++#include <stdio.h>
    ++#include <mntent.h>
    ++
     +static inline struct mntent *GETMNTENT(FILE *stream)
     +{
     +	struct mntent *entp = getmntent(stream);
     +	if(entp != NULL) {
     +		unescape(entp->mnt_fsname);
     +		unescape(entp->mnt_dir);
    @@ util/fuser_conf.h (new)
     +#endif // GETMNTENT_NEEDS_UNESCAPING
     +
     +int count_fuse_fs(const char *progname);
     +
     +void read_conf(const char *progname);
     +
    ++void drop_privs(void);
    ++void restore_privs(void);
    ++
    ++int check_nonroot_mount_count(const char *progname);
    ++
    ++int check_nonroot_dir_access(const char *progname, const char *origmnt,
    ++			     const char *mnt, const struct stat *stbuf);
    ++
    ++int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf);
    ++
     +#endif /* FUSER_CONF_H_ */
     
      ## util/fuser_conf.c (new) ##
     @@
     +/*
     + * FUSE: Filesystem in Userspace
    @@ util/fuser_conf.c (new)
     +#include <ctype.h>
     +#include <stdio.h>
     +#include <stdlib.h>
     +#include <errno.h>
     +#include <mntent.h>
     +#include <unistd.h>
    ++#include <sys/fsuid.h>
     +
     +#if defined HAVE_LISTMOUNT
     +#include <linux/mount.h>
     +#include <syscall.h>
     +#include <stdint.h>
     +#endif
     +
     +int user_allow_other = 0;
     +int mount_max = 1000;
    ++static uid_t oldfsuid;
    ++static gid_t oldfsgid;
     +
     +// Older versions of musl libc don't unescape entries in /etc/mtab
     +
     +// unescapes octal sequences like \040 in-place
     +// That's ok, because unescaping can not extend the length of the string.
     +void unescape(char *buf)
    @@ util/fuser_conf.c (new)
     +	}
     +}
     +
     +#ifndef IGNORE_MTAB
     +static int count_fuse_fs_mtab(const char *progname)
     +{
    -+	struct mntent *entp;
    ++	const struct mntent *entp;
     +	int count = 0;
     +	const char *mtab = _PATH_MOUNTED;
     +	FILE *fp = setmntent(mtab, "r");
     +	if (fp == NULL) {
     +		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
     +			strerror(errno));
    @@ util/fuser_conf.c (new)
     +int count_fuse_fs(const char *progname)
     +{
     +	return count_fuse_fs_mtab(progname);
     +}
     +#endif /* HAVE_LISTMOUNT */
     +#else
    -+static int count_fuse_fs(const char *progname)
    ++int count_fuse_fs(const char *progname)
     +{
     +	return 0;
     +}
    -+#endif /* IGNORE_MTAB */
    ++#endif /* !IGNORE_MTAB */
     +
     +static void strip_line(char *line)
     +{
     +	char *s = strchr(line, '#');
     +	if (s != NULL)
     +		s[0] = '\0';
    @@ util/fuser_conf.c (new)
     +	s[1] = '\0';
     +	for (s = line; isspace((unsigned char) *s); s++);
     +	if (s != line)
     +		memmove(line, s, strlen(s)+1);
     +}
     +
    -+static void parse_line(const char *progname, char *line, int linenum)
    ++static void parse_line(const char *line, int linenum, const char *progname)
     +{
     +	int tmp;
     +	if (strcmp(line, "user_allow_other") == 0)
     +		user_allow_other = 1;
     +	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
     +		mount_max = tmp;
    @@ util/fuser_conf.c (new)
     +		char line[256];
     +		int isnewline = 1;
     +		while (fgets(line, sizeof(line), fp) != NULL) {
     +			if (isnewline) {
     +				if (line[strlen(line)-1] == '\n') {
     +					strip_line(line);
    -+					parse_line(progname, line, linenum);
    ++					parse_line(line, linenum, progname);
     +				} else {
     +					isnewline = 0;
     +				}
     +			} else if(line[strlen(line)-1] == '\n') {
     +				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
     +
    @@ util/fuser_conf.c (new)
     +			      errno != EOVERFLOW);
     +		fprintf(stderr, "%s: failed to open %s: %s\n",
     +			progname, FUSE_CONF, strerror(errno));
     +		if (fatal)
     +			exit(1);
     +	}
    ++}
    ++
    ++void drop_privs(void)
    ++{
    ++	if (getuid() != 0) {
    ++		oldfsuid = setfsuid(getuid());
    ++		oldfsgid = setfsgid(getgid());
    ++	}
    ++}
    ++
    ++void restore_privs(void)
    ++{
    ++	if (getuid() != 0) {
    ++		setfsuid(oldfsuid);
    ++		setfsgid(oldfsgid);
    ++	}
    ++}
    ++
    ++int check_nonroot_mount_count(const char *progname)
    ++{
    ++	if (mount_max == -1)
    ++		return 0;
    ++
    ++	int mount_count = count_fuse_fs(progname);
    ++
    ++	if (mount_count >= mount_max) {
    ++		fprintf(stderr,
    ++"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
    ++			progname, FUSE_CONF);
    ++		return -1;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
    ++int check_nonroot_dir_access(const char *progname, const char *origmnt,
    ++			     const char *mnt, const struct stat *stbuf)
    ++{
    ++	int res;
    ++
    ++	if ((stbuf->st_mode & S_ISVTX) && stbuf->st_uid != getuid()) {
    ++		fprintf(stderr, "%s: mountpoint %s not owned by user\n",
    ++			progname, origmnt);
    ++		return -1;
    ++	}
    ++
    ++	res = access(mnt, W_OK);
    ++	if (res == -1) {
    ++		fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
    ++			progname, origmnt);
    ++		return -1;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
    ++int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
    ++{
    ++	size_t i;
    ++
    ++	/* Do not permit mounting over anything in procfs - it has a couple
    ++	 * places to which we have "write access" without being supposed to be
    ++	 * able to just put anything we want there.
    ++	 * Luckily, without allow_other, we can't get other users to actually
    ++	 * use any fake information we try to put there anyway.
    ++	 * Use a whitelist to be safe. */
    ++
    ++	/* Define permitted filesystems for the mount target. This was
    ++	 * originally the same list as used by the ecryptfs mount helper
    ++	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
    ++	 * but got expanded as we found more filesystems that needed to be
    ++	 * overlaid. */
    ++	typeof(fs_buf->f_type) f_type_whitelist[] = {
    ++		0x61756673 /* AUFS_SUPER_MAGIC */,
    ++		0x00000187 /* AUTOFS_SUPER_MAGIC */,
    ++		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
    ++		0x9123683E /* BTRFS_SUPER_MAGIC */,
    ++		0x00C36400 /* CEPH_SUPER_MAGIC */,
    ++		0xFF534D42 /* CIFS_MAGIC_NUMBER */,
    ++		0x0000F15F /* ECRYPTFS_SUPER_MAGIC */,
    ++		0X2011BAB0 /* EXFAT_SUPER_MAGIC */,
    ++		0x0000EF53 /* EXT[234]_SUPER_MAGIC */,
    ++		0xF2F52010 /* F2FS_SUPER_MAGIC */,
    ++		0x65735546 /* FUSE_SUPER_MAGIC */,
    ++		0x01161970 /* GFS2_MAGIC */,
    ++		0x47504653 /* GPFS_SUPER_MAGIC */,
    ++		0x0000482b /* HFSPLUS_SUPER_MAGIC */,
    ++		0x000072B6 /* JFFS2_SUPER_MAGIC */,
    ++		0x3153464A /* JFS_SUPER_MAGIC */,
    ++		0x0BD00BD0 /* LL_SUPER_MAGIC */,
    ++		0X00004D44 /* MSDOS_SUPER_MAGIC */,
    ++		0x0000564C /* NCP_SUPER_MAGIC */,
    ++		0x00006969 /* NFS_SUPER_MAGIC */,
    ++		0x00003434 /* NILFS_SUPER_MAGIC */,
    ++		0x5346544E /* NTFS_SB_MAGIC */,
    ++		0x7366746E /* NTFS3_SUPER_MAGIC */,
    ++		0x5346414f /* OPENAFS_SUPER_MAGIC */,
    ++		0x794C7630 /* OVERLAYFS_SUPER_MAGIC */,
    ++		0xAAD7AAEA /* PANFS_SUPER_MAGIC */,
    ++		0x52654973 /* REISERFS_SUPER_MAGIC */,
    ++		0xFE534D42 /* SMB2_SUPER_MAGIC */,
    ++		0x73717368 /* SQUASHFS_MAGIC */,
    ++		0x01021994 /* TMPFS_MAGIC */,
    ++		0x24051905 /* UBIFS_SUPER_MAGIC */,
    ++		0x18031977 /* WEKAFS_SUPER_MAGIC */,
    ++#if __SIZEOF_LONG__ > 4
    ++		0x736675005346544e /* UFSD */,
    ++#endif
    ++		0x58465342 /* XFS_SB_MAGIC */,
    ++		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
    ++		0x858458f6 /* RAMFS_MAGIC */,
    ++	};
    ++	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
    ++		if (f_type_whitelist[i] == fs_buf->f_type)
    ++			return 0;
    ++	}
    ++
    ++	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
    ++		progname, (unsigned long)fs_buf->f_type);
    ++	return -1;
     +}
     
      ## util/fusermount.c ##
     @@
      /* This program does the mounting and unmounting of FUSE filesystems */
      
    @@ util/fusermount.c
      /*
       * Take a ',' separated option string and extract "x-" options
       */
      static int extract_x_options(const char *original, char **non_x_opts,
      			     char **x_opts)
      {
    +@@ util/fusermount.c: static const char *get_user_name(void)
    + 	else {
    + 		fprintf(stderr, "%s: could not determine username\n", progname);
    + 		return NULL;
    + 	}
    + }
    + 
    +-static uid_t oldfsuid;
    +-static gid_t oldfsgid;
    +-
    +-static void drop_privs(void)
    +-{
    +-	if (getuid() != 0) {
    +-		oldfsuid = setfsuid(getuid());
    +-		oldfsgid = setfsgid(getgid());
    +-	}
    +-}
    +-
    +-static void restore_privs(void)
    +-{
    +-	if (getuid() != 0) {
    +-		setfsuid(oldfsuid);
    +-		setfsgid(oldfsgid);
    +-	}
    +-}
    +-
    + #ifndef IGNORE_MTAB
    + /*
    +  * Make sure that /etc/mtab is checked and updated atomically
    +  */
    + static int lock_umount(void)
    + {
     @@ util/fusermount.c: static int unmount_fuse(const char *mnt, int quiet, int lazy)
    + 
      	res = unmount_fuse_locked(mnt, quiet, lazy);
      	unlock_umount(mtablock);
      
      	return res;
      }
    - 
    +-
     -static int count_fuse_fs_mtab(void)
     -{
    --	struct mntent *entp;
    +-	const struct mntent *entp;
     -	int count = 0;
     -	const char *mtab = _PATH_MOUNTED;
     -	FILE *fp = setmntent(mtab, "r");
     -	if (fp == NULL) {
     -		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
     -			strerror(errno));
    @@ util/fusermount.c: static int unmount_fuse(const char *mnt, int quiet, int lazy)
     -	s[1] = '\0';
     -	for (s = line; isspace((unsigned char) *s); s++);
     -	if (s != line)
     -		memmove(line, s, strlen(s)+1);
     -}
     -
    --static void parse_line(char *line, int linenum)
    +-static void parse_line(const char *line, int linenum)
     -{
     -	int tmp;
     -	if (strcmp(line, "user_allow_other") == 0)
     -		user_allow_other = 1;
     -	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
     -		mount_max = tmp;
    @@ util/fusermount.c: static int unmount_fuse(const char *mnt, int quiet, int lazy)
      static int begins_with(const char *s, const char *beg)
      {
      	if (strncmp(s, beg, strlen(beg)) == 0)
      		return 1;
      	else
      		return 0;
    +@@ util/fusermount.c: static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
    + static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
    + {
    + 	int res;
    + 	const char *mnt = *mntp;
    + 	const char *origmnt = mnt;
    + 	struct statfs fs_buf;
    +-	size_t i;
    + 
    + 	res = lstat(mnt, stbuf);
    + 	if (res == -1) {
    + 		fprintf(stderr, "%s: failed to access mountpoint %s: %s\n",
    + 			progname, mnt, strerror(errno));
    + 		return -1;
    +@@ util/fusermount.c: static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
    + 			fprintf(stderr,
    + 				"%s: failed to access mountpoint %s: %s\n",
    + 				progname, origmnt, strerror(errno));
    + 			return -1;
    + 		}
    + 
    +-		if ((stbuf->st_mode & S_ISVTX) && stbuf->st_uid != getuid()) {
    +-			fprintf(stderr, "%s: mountpoint %s not owned by user\n",
    +-				progname, origmnt);
    +-			return -1;
    +-		}
    +-
    +-		res = access(mnt, W_OK);
    +-		if (res == -1) {
    +-			fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
    +-				progname, origmnt);
    +-			return -1;
    +-		}
    ++		res = check_nonroot_dir_access(progname, origmnt, mnt, stbuf);
    ++		if (res)
    ++			return res;
    + 	} else if (S_ISREG(stbuf->st_mode)) {
    + 		static char procfile[256];
    + 		*mountpoint_fd = open(mnt, O_WRONLY);
    + 		if (*mountpoint_fd == -1) {
    + 			fprintf(stderr, "%s: failed to open %s: %s\n",
    + 				progname, mnt, strerror(errno));
    +@@ util/fusermount.c: static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
    + 		fprintf(stderr,
    + 			"%s: mountpoint %s is not a directory or a regular file\n",
    + 			progname, mnt);
    + 		return -1;
    + 	}
    + 
    +-	/* Do not permit mounting over anything in procfs - it has a couple
    +-	 * places to which we have "write access" without being supposed to be
    +-	 * able to just put anything we want there.
    +-	 * Luckily, without allow_other, we can't get other users to actually
    +-	 * use any fake information we try to put there anyway.
    +-	 * Use a whitelist to be safe. */
    + 	if (statfs(*mntp, &fs_buf)) {
    + 		fprintf(stderr, "%s: failed to access mountpoint %s: %s\n",
    + 			progname, mnt, strerror(errno));
    + 		return -1;
    + 	}
    + 
    +-	/* Define permitted filesystems for the mount target. This was
    +-	 * originally the same list as used by the ecryptfs mount helper
    +-	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
    +-	 * but got expanded as we found more filesystems that needed to be
    +-	 * overlaid. */
    +-	typeof(fs_buf.f_type) f_type_whitelist[] = {
    +-		0x61756673 /* AUFS_SUPER_MAGIC */,
    +-		0x00000187 /* AUTOFS_SUPER_MAGIC */,
    +-		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
    +-		0x9123683E /* BTRFS_SUPER_MAGIC */,
    +-		0x00C36400 /* CEPH_SUPER_MAGIC */,
    +-		0xFF534D42 /* CIFS_MAGIC_NUMBER */,
    +-		0x0000F15F /* ECRYPTFS_SUPER_MAGIC */,
    +-		0X2011BAB0 /* EXFAT_SUPER_MAGIC */,
    +-		0x0000EF53 /* EXT[234]_SUPER_MAGIC */,
    +-		0xF2F52010 /* F2FS_SUPER_MAGIC */,
    +-		0x65735546 /* FUSE_SUPER_MAGIC */,
    +-		0x01161970 /* GFS2_MAGIC */,
    +-		0x47504653 /* GPFS_SUPER_MAGIC */,
    +-		0x0000482b /* HFSPLUS_SUPER_MAGIC */,
    +-		0x000072B6 /* JFFS2_SUPER_MAGIC */,
    +-		0x3153464A /* JFS_SUPER_MAGIC */,
    +-		0x0BD00BD0 /* LL_SUPER_MAGIC */,
    +-		0X00004D44 /* MSDOS_SUPER_MAGIC */,
    +-		0x0000564C /* NCP_SUPER_MAGIC */,
    +-		0x00006969 /* NFS_SUPER_MAGIC */,
    +-		0x00003434 /* NILFS_SUPER_MAGIC */,
    +-		0x5346544E /* NTFS_SB_MAGIC */,
    +-		0x7366746E /* NTFS3_SUPER_MAGIC */,
    +-		0x5346414f /* OPENAFS_SUPER_MAGIC */,
    +-		0x794C7630 /* OVERLAYFS_SUPER_MAGIC */,
    +-		0xAAD7AAEA /* PANFS_SUPER_MAGIC */,
    +-		0x52654973 /* REISERFS_SUPER_MAGIC */,
    +-		0xFE534D42 /* SMB2_SUPER_MAGIC */,
    +-		0x73717368 /* SQUASHFS_MAGIC */,
    +-		0x01021994 /* TMPFS_MAGIC */,
    +-		0x24051905 /* UBIFS_SUPER_MAGIC */,
    +-		0x18031977 /* WEKAFS_SUPER_MAGIC */,
    +-#if __SIZEOF_LONG__ > 4
    +-		0x736675005346544e /* UFSD */,
    +-#endif
    +-		0x58465342 /* XFS_SB_MAGIC */,
    +-		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
    +-		0x858458f6 /* RAMFS_MAGIC */,
    +-	};
    +-	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
    +-		if (f_type_whitelist[i] == fs_buf.f_type)
    +-			return 0;
    +-	}
    +-
    +-	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
    +-		progname, (unsigned long)fs_buf.f_type);
    +-	return -1;
    ++	return check_nonroot_fstype(progname, &fs_buf);
    + }
    + 
    + static int open_fuse_device(const char *dev)
    + {
    + 	int fd;
    + 
     @@ util/fusermount.c: static int mount_fuse(const char *mnt, const char *opts, const char **type)
      
      	fd = open_fuse_device(dev);
      	if (fd == -1)
      		return -1;
      
      	drop_privs();
     -	read_conf();
     +	read_conf(progname);
      
    - 	if (getuid() != 0 && mount_max != -1) {
    +-	if (getuid() != 0 && mount_max != -1) {
     -		int mount_count = count_fuse_fs();
    -+		int mount_count = count_fuse_fs(progname);
    - 		if (mount_count >= mount_max) {
    - 			fprintf(stderr, "%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n", progname, FUSE_CONF);
    - 			goto fail_close_fd;
    - 		}
    - 	}
    +-		if (mount_count >= mount_max) {
    +-			fprintf(stderr, "%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n", progname, FUSE_CONF);
    +-			goto fail_close_fd;
    +-		}
    +-	}
    ++	if (getuid() != 0 && check_nonroot_mount_count(progname) != 0)
    ++		goto fail_close_fd;
    + 
    + 	// Extract any options starting with "x-"
    + 	res= extract_x_options(opts, &do_mount_opts, &x_opts);
    + 	if (res)
    + 		goto fail_close_fd;
      
     
      ## util/meson.build ##
     @@
      fuseconf_path = join_paths(get_option('prefix'), get_option('sysconfdir'), 'fuse.conf')
      
    @@ util/meson.build
     -  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c'],
     +  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c', 'fuser_conf.c'],
                   include_directories: include_dirs,
                   link_with: [ libfuse ],
                   install: true,
                   install_dir: get_option('sbindir'),
    --             c_args: '-DFUSE_USE_VERSION=317')
    -+             c_args: ['-DFUSE_USE_VERSION=317', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
    +-             c_args: '-DFUSE_USE_VERSION=319')
    ++             c_args: ['-DFUSE_USE_VERSION=319', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
      endif
      
      executable('mount.fuse3', ['mount.fuse.c'],
                 include_directories: include_dirs,
                 link_with: [ libfuse ],
                 install: true,
 7:  26e4b15e5741f8 !  7:  2405d43153ba4b util: fix checkpatch complaints in fuser_conf.[ch]
    @@ Commit message
     
         Fix the checkpatch complaints because we touched some code.
     
         Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## util/fuser_conf.h ##
    -@@ util/fuser_conf.h: extern int mount_max;
    - void unescape(char *buf);
    +@@ util/fuser_conf.h: void unescape(char *buf);
    + #include <stdio.h>
    + #include <mntent.h>
      
    - #ifdef GETMNTENT_NEEDS_UNESCAPING
      static inline struct mntent *GETMNTENT(FILE *stream)
      {
      	struct mntent *entp = getmntent(stream);
     -	if(entp != NULL) {
     +
     +	if (entp != NULL) {
    @@ util/fuser_conf.c
      #include <stdint.h>
      #endif
      
     -int user_allow_other = 0;
     +int user_allow_other;
      int mount_max = 1000;
    + static uid_t oldfsuid;
    + static gid_t oldfsgid;
      
      // Older versions of musl libc don't unescape entries in /etc/mtab
      
      // unescapes octal sequences like \040 in-place
      // That's ok, because unescaping can not extend the length of the string.
      void unescape(char *buf)
    @@ util/fuser_conf.c
      			src += 1;
      		} else {
      			*dest++ = '\\';
     @@ util/fuser_conf.c: void unescape(char *buf)
      static int count_fuse_fs_mtab(const char *progname)
      {
    - 	struct mntent *entp;
    + 	const struct mntent *entp;
      	int count = 0;
      	const char *mtab = _PATH_MOUNTED;
      	FILE *fp = setmntent(mtab, "r");
     +
      	if (fp == NULL) {
      		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
    @@ util/fuser_conf.c: void unescape(char *buf)
      	}
      	endmntent(fp);
      	return count;
      }
      
      #ifdef HAVE_LISTMOUNT
    -@@ util/fuser_conf.c: static int count_fuse_fs(const char *progname)
    +@@ util/fuser_conf.c: int count_fuse_fs(const char *progname)
      }
    - #endif /* IGNORE_MTAB */
    + #endif /* !IGNORE_MTAB */
      
      static void strip_line(char *line)
      {
      	char *s = strchr(line, '#');
     +
      	if (s != NULL)
    @@ util/fuser_conf.c: static int count_fuse_fs(const char *progname)
     +	for (s = line; isspace((unsigned char) *s); s++)
     +		; /* empty */
      	if (s != line)
      		memmove(line, s, strlen(s)+1);
      }
      
    - static void parse_line(const char *progname, char *line, int linenum)
    + static void parse_line(const char *line, int linenum, const char *progname)
      {
      	int tmp;
     +
      	if (strcmp(line, "user_allow_other") == 0)
      		user_allow_other = 1;
      	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
    @@ util/fuser_conf.c: static int count_fuse_fs(const char *progname)
      		int isnewline = 1;
     +
      		while (fgets(line, sizeof(line), fp) != NULL) {
      			if (isnewline) {
      				if (line[strlen(line)-1] == '\n') {
      					strip_line(line);
    - 					parse_line(progname, line, linenum);
    + 					parse_line(line, linenum, progname);
      				} else {
      					isnewline = 0;
      				}
     -			} else if(line[strlen(line)-1] == '\n') {
     -				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
     +			} else if (line[strlen(line)-1] == '\n') {
    @@ util/fuser_conf.c: static int count_fuse_fs(const char *progname)
      
      		}
      		if (ferror(fp)) {
      			fprintf(stderr, "%s: reading %s: read failed\n", progname, FUSE_CONF);
      			exit(1);
      		}
    +@@ util/fuser_conf.c: int check_nonroot_dir_access(const char *progname, const char *origmnt,
    + 		return -1;
    + 	}
    + 
    + 	return 0;
    + }
    + 
    ++#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
    ++
    + int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
    + {
    + 	size_t i;
    + 
    + 	/* Do not permit mounting over anything in procfs - it has a couple
    + 	 * places to which we have "write access" without being supposed to be
    + 	 * able to just put anything we want there.
    + 	 * Luckily, without allow_other, we can't get other users to actually
    + 	 * use any fake information we try to put there anyway.
    +-	 * Use a whitelist to be safe. */
    ++	 * Use a whitelist to be safe.
    ++	 */
    + 
    + 	/* Define permitted filesystems for the mount target. This was
    + 	 * originally the same list as used by the ecryptfs mount helper
    + 	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
    + 	 * but got expanded as we found more filesystems that needed to be
    +-	 * overlaid. */
    ++	 * overlaid.
    ++	 */
    + 	typeof(fs_buf->f_type) f_type_whitelist[] = {
    + 		0x61756673 /* AUFS_SUPER_MAGIC */,
    + 		0x00000187 /* AUTOFS_SUPER_MAGIC */,
    + 		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
    + 		0x9123683E /* BTRFS_SUPER_MAGIC */,
    + 		0x00C36400 /* CEPH_SUPER_MAGIC */,
    +@@ util/fuser_conf.c: int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
    + 		0x736675005346544e /* UFSD */,
    + #endif
    + 		0x58465342 /* XFS_SB_MAGIC */,
    + 		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
    + 		0x858458f6 /* RAMFS_MAGIC */,
    + 	};
    +-	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
    ++	for (i = 0; i < ARRAY_SIZE(f_type_whitelist); i++) {
    + 		if (f_type_whitelist[i] == fs_buf->f_type)
    + 			return 0;
    + 	}
    + 
    + 	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
    + 		progname, (unsigned long)fs_buf->f_type);
 8:  3f41f8303f02f9 <  -:  -------------- mount_service: read fuse.conf to enable allow_other for unprivileged mounts
 9:  c29554d5ecbe44 <  -:  -------------- util: hoist the other non-root user limits
10:  0b498783afacf2 <  -:  -------------- util: fix more checkpatch complaints in fuser_conf.[ch]
11:  3e3739ed798956 <  -:  -------------- mount_service: use over the other non-root user checks
 -:  -------------- >  8:  d2537b6030b04d mount_service: enable unprivileged users in the same manner as fusermount
12:  72a53f466688ae !  9:  b1a887475585ed mount.fuse3: integrate systemd service startup
    @@ doc/fuservicemount3.8: .SH NAME
      .LP
      The author of the fuse socket service code is Darrick J. Wong <djwong@kernel.org>.
      Debian GNU/Linux distribution.
      .SH SEE ALSO
      .BR fusermount3 (1)
     
    + ## meson.build ##
    +@@ meson.build: endif
    + private_cfg.set_quoted('FUSE_SERVICE_SOCKET_DIR', service_socket_dir)
    + private_cfg.set('FUSE_SERVICE_SOCKET_PERMS', service_socket_perms)
    + 
    + # Test for presence of some functions
    + test_funcs = [ 'fork', 'fstatat', 'openat', 'readlinkat', 'pipe2',
    +                'splice', 'vmsplice', 'posix_fallocate', 'fdatasync',
    +-               'utimensat', 'copy_file_range', 'fallocate', 'fspacectl' ]
    ++               'utimensat', 'copy_file_range', 'fallocate', 'fspacectl',
    ++               'faccessat' ]
    + foreach func : test_funcs
    +     private_cfg.set('HAVE_' + func.to_upper(),
    +         cc.has_function(func, prefix: include_default, args: args_default))
    + endforeach
    + 
    + # Special case checks that need custom code
    +
      ## util/fuservicemount.c ##
     @@
       * This program can be distributed under the terms of the GNU GPLv2.
       * See the file GPL2.txt.
       *
       * This program wraps the mounting of FUSE filesystems that run in systemd
    @@ util/meson.build: fuseconf_path = join_paths(get_option('prefix'), get_option('s
     +mount_service_sources = []
     +mount_service_cflags = []
      if private_cfg.get('HAVE_SERVICEMOUNT', false)
     -  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c', 'fuser_conf.c'],
     +  mount_service_sources += ['mount_service.c', '../lib/mount_util.c', 'fuser_conf.c']
     +  mount_service_cflags += ['-DFUSE_CONF="@0@"'.format(fuseconf_path)]
    ++  fuservicemount_path = join_paths(get_option('prefix'), get_option('sbindir'))
    ++  mount_service_cflags += ['-DFUSERVICEMOUNT_DIR="@0@"'.format(fuservicemount_path)]
     +  executable('fuservicemount3', ['fuservicemount.c'] + mount_service_sources,
                   include_directories: include_dirs,
                   link_with: [ libfuse ],
                   install: true,
                   install_dir: get_option('sbindir'),
    --             c_args: ['-DFUSE_USE_VERSION=317', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
    -+             c_args: ['-DFUSE_USE_VERSION=317'] + mount_service_cflags)
    +-             c_args: ['-DFUSE_USE_VERSION=319', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
    ++             c_args: ['-DFUSE_USE_VERSION=319'] + mount_service_cflags)
      endif
      
     -executable('mount.fuse3', ['mount.fuse.c'],
     +executable('mount.fuse3', ['mount.fuse.c'] + mount_service_sources,
                 include_directories: include_dirs,
                 link_with: [ libfuse ],
                 install: true,
                 install_dir: get_option('sbindir'),
     -           c_args: '-DFUSE_USE_VERSION=317')
    -+           c_args: ['-DFUSE_USE_VERSION=317'] + mount_service_cflags)
    ++           c_args: ['-DFUSE_USE_VERSION=319'] + mount_service_cflags)
      
      
      udevrulesdir = get_option('udevrulesdir')
      if udevrulesdir == ''
        udev = dependency('udev', required: false)
        if udev.found()
    @@ util/mount.fuse.c
      
      static char *progname;
      
      static char *xstrdup(const char *s)
      {
      	char *t = strdup(s);
    +@@ util/mount.fuse.c: static void drop_and_lock_capabilities(void)
    + 			progname, strerror(errno));
    + 		exit(1);
    + 	}
    + }
    + #endif
    + 
    ++#ifdef HAVE_SERVICEMOUNT
    ++#define FUSERVICEMOUNT_PROG	"fuservicemount3"
    ++
    ++static int try_service_main(char *argv0, char *type, char *source,
    ++			    const char *mountpoint, char *options)
    ++{
    ++	const char *full_path = FUSERVICEMOUNT_DIR "/" FUSERVICEMOUNT_PROG;
    ++	char **argv;
    ++	char dash_o[] = "-o";
    ++	char dash_t[] = "-t";
    ++	char *mntpt = strdup(mountpoint);
    ++	int argc = 5; /* argv[0], -t type, mountpoint, and trailing NULL */
    ++	int i = 0;
    ++	int ret;
    ++
    ++	if (!mount_service_present(type))
    ++		return MOUNT_SERVICE_FALLBACK_NEEDED;
    ++
    ++	if (!mntpt) {
    ++		perror("mountpoint allocation");
    ++		return -1;
    ++	}
    ++
    ++	if (source)
    ++		argc++;
    ++	if (options)
    ++		argc += 2;
    ++
    ++	argv = calloc(argc, sizeof(char *));
    ++	if (!argv) {
    ++		perror("argv allocation");
    ++		free(mntpt);
    ++		return -1;
    ++	}
    ++
    ++	argv[i++] = argv0;
    ++	if (source)
    ++		argv[i++] = source;
    ++	argv[i++] = mntpt;
    ++	argv[i++] = dash_t;
    ++	argv[i++] = type;
    ++	if (options) {
    ++		argv[i++] = dash_o;
    ++		argv[i++] = options;
    ++	}
    ++	argv[i] = 0;
    ++
    ++	if (getuid() != 0) {
    ++		/*
    ++		 * First try the install path, then a system install, just like
    ++		 * we do for fusermount.
    ++		 */
    ++		ret = execvp(full_path, argv);
    ++		if (ret)
    ++			ret = execvp(FUSERVICEMOUNT_PROG, argv);
    ++		if (ret) {
    ++			fprintf(stderr, "%s: could not start %s helper: %s\n",
    ++				argv[0], FUSERVICEMOUNT_PROG,
    ++				strerror(errno));
    ++			ret = MOUNT_SERVICE_FALLBACK_NEEDED;
    ++		}
    ++	} else {
    ++		/* We're root, just do the mount directly. */
    ++		ret = mount_service_main(argc - 1, argv);
    ++	}
    ++	free(argv);
    ++	free(mntpt);
    ++	return ret;
    ++}
    ++#endif
    ++
    + int main(int argc, char *argv[])
    + {
    + 	char *type = NULL;
    + 	char *source;
    + 	char *dup_source = NULL;
    + 	const char *mountpoint;
     @@ util/mount.fuse.c: int main(int argc, char *argv[])
      	if (!source[0])
      		source = NULL;
      
      	mountpoint = argv[2];
      
    @@ util/mount.fuse.c: int main(int argc, char *argv[])
     +		} else {
     +			fprintf(stderr, "%s: empty source\n", progname);
     +			exit(1);
     +		}
     +	}
     +
    -+#ifdef HAVE_SERVICEMOUNT
    -+	/*
    -+	 * Now that we know the desired filesystem type, see if we can find
    -+	 * a socket service implementing that.
    -+	 */
    -+	if (mount_service_present(type))
    -+		return mount_service_main(argc, argv);
    -+#endif
    -+
     +	for (i = 3; i < argc; i++) {
     +		if (strcmp(argv[i], "-v") == 0) {
     +			continue;
      		} else	if (strcmp(argv[i], "-o") == 0) {
      			char *opts;
    - 			char *opt;
    + 			const char *opt;
      			i++;
      			if (i == argc)
      				break;
     @@ util/mount.fuse.c: int main(int argc, char *argv[])
      
      	if (dev)
    @@ util/mount.fuse.c: int main(int argc, char *argv[])
      	if (setuid_name && setuid_name[0]) {
      #ifdef linux
      		if (drop_privileges) {
      			/*
      			 * Make securebits more permissive before calling
      			 * setuid(). Specifically, if SECBIT_KEEP_CAPS and
    +@@ util/mount.fuse.c: int main(int argc, char *argv[])
    + 
    + #ifdef linux
    + 	if (drop_privileges) {
    + 		drop_and_lock_capabilities();
    + 	}
    + #endif
    ++
    ++#ifdef HAVE_SERVICEMOUNT
    ++	/*
    ++	 * Now that we know the desired filesystem type, see if we can find
    ++	 * a socket service implementing that, if we haven't selected any weird
    ++	 * options that would prevent that.
    ++	 */
    ++	if (!pass_fuse_fd && !(setuid_name && setuid_name[0])) {
    ++		int ret = try_service_main(argv[0], type, source, mountpoint,
    ++					   options);
    ++		if (ret != MOUNT_SERVICE_FALLBACK_NEEDED)
    ++			return ret;
    ++	}
    ++#endif
    ++
    + 	add_arg(&command, type);
    + 	if (source)
    + 		add_arg(&command, source);
    + 	add_arg(&command, mountpoint);
    + 	if (options) {
    + 		add_arg(&command, "-o");
     
      ## util/mount_service.c ##
     @@ util/mount_service.c: int mount_service_main(int argc, char *argv[])
      
      	ret = EXIT_SUCCESS;
      out:
    @@ util/mount_service.c: int mount_service_main(int argc, char *argv[])
     +	if (ret)
     +		return false;
     +
     +	if (!S_ISSOCK(stbuf.st_mode))
     +		return false;
     +
    -+	ret = access(path, R_OK | W_OK);
    ++#ifdef HAVE_FACCESSAT
    ++	/*
    ++	 * Can we write to the service socket with the real uid?  This accounts
    ++	 * for setuid and ACLs on the socket.  Note that we connect() to the
    ++	 * socket having dropped setuid privileges.
    ++	 */
    ++	ret = faccessat(AT_FDCWD, path, W_OK, 0);
    ++#else
    ++	/* Can we write to the service socket with the real uid? */
    ++	ret = access(path, W_OK);
    ++#endif
     +	return ret == 0;
     +}
13:  e7903cbaf2b638 = 10:  9fe14e80a4d315 mount_service: allow installation as a setuid program
14:  442656a22e8045 ! 11:  2a66e8073f338e example/service_ll: create a sample systemd service fuse server
    @@ example/single_file.h (new)
     +	return (b / align) + m;
     +}
     +
     +struct single_file {
     +	int backing_fd;
     +
    -+	uint64_t isize;
    ++	int64_t isize;
     +	uint64_t blocks;
     +
     +	mode_t mode;
     +
     +	bool ro;
     +	bool allow_dio;
     +	bool sync;
    ++	bool require_bdev;
     +
     +	unsigned int blocksize;
     +
     +	struct timespec atime;
     +	struct timespec mtime;
     +
    @@ example/single_file.h (new)
     +	return fsb * single_file.blocksize;
     +}
     +
     +enum single_file_opt_keys {
     +	SINGLE_FILE_RO = 171717, /* how many options could we possibly have? */
     +	SINGLE_FILE_RW,
    ++	SINGLE_FILE_REQUIRE_BDEV,
     +	SINGLE_FILE_DIO,
     +	SINGLE_FILE_NODIO,
     +	SINGLE_FILE_SYNC,
     +	SINGLE_FILE_NOSYNC,
     +	SINGLE_FILE_SIZE,
     +	SINGLE_FILE_BLOCKSIZE,
    @@ example/single_file.h (new)
     +	SINGLE_FILE_NR_KEYS,
     +};
     +
     +#define SINGLE_FILE_OPT_KEYS \
     +	FUSE_OPT_KEY("ro",		SINGLE_FILE_RO), \
     +	FUSE_OPT_KEY("rw",		SINGLE_FILE_RW), \
    ++	FUSE_OPT_KEY("require_bdev",	SINGLE_FILE_REQUIRE_BDEV), \
     +	FUSE_OPT_KEY("dio",		SINGLE_FILE_DIO), \
     +	FUSE_OPT_KEY("nodio",		SINGLE_FILE_NODIO), \
     +	FUSE_OPT_KEY("sync",		SINGLE_FILE_SYNC), \
     +	FUSE_OPT_KEY("nosync",		SINGLE_FILE_NOSYNC), \
     +	FUSE_OPT_KEY("size=%s",		SINGLE_FILE_SIZE), \
     +	FUSE_OPT_KEY("blocksize=%s",	SINGLE_FILE_BLOCKSIZE)
    @@ example/single_file.h (new)
     +
     +unsigned long long parse_num_blocks(const char *arg, int log_block_size);
     +
     +struct fuse_service;
     +int single_file_service_open(struct fuse_service *sf, const char *path);
     +
    ++void single_file_check_read(off_t pos, size_t *count);
    ++int single_file_check_write(off_t pos, size_t *count);
    ++
     +int single_file_configure(const char *device, const char *filename);
     +int single_file_configure_simple(const char *filename);
     +void single_file_close(void);
     +
     +/* low-level fuse operation handlers */
     +
    @@ example/single_file.h (new)
     +
     +void single_file_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name);
     +void single_file_ll_open(fuse_req_t req, fuse_ino_t ino,
     +			 struct fuse_file_info *fi);
     +
     +void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
    -+			  struct fuse_file_info *fp);
    ++			  struct fuse_file_info *fi);
     +
     +int reply_buf_limited(fuse_req_t req, const char *buf, size_t bufsize,
     +		      off_t off, size_t maxsize);
     +
     +#endif /* FUSE_SINGLE_FILE_H_ */
     
    @@ example/service_ll.c (new)
     +	(void)userdata;
     +
     +	conn->time_gran = 1;
     +}
     +
     +static void service_ll_read(fuse_req_t req, fuse_ino_t ino, size_t count,
    -+			    off_t pos, struct fuse_file_info *fp)
    ++			    off_t pos, struct fuse_file_info *fi)
     +{
     +	void *buf = NULL;
     +	ssize_t got;
     +	int ret;
     +
     +	if (!is_single_file_ino(ino)) {
    @@ example/service_ll.c (new)
     +	if (ll.debug)
     +		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
     +			__func__,
     +			(unsigned long long)pos,
     +			(unsigned long long)count);
     +
    -+	if (!single_file.allow_dio && fp->direct_io) {
    ++	if (!single_file.allow_dio && fi->direct_io) {
     +		ret = ENOSYS;
     +		goto out_reply;
     +	}
     +
    ++	single_file_check_read(pos, &count);
    ++
    ++	if (!count) {
    ++		fuse_reply_buf(req, buf, 0);
    ++		return;
    ++	}
    ++
     +	buf = malloc(count);
     +	if (!buf) {
     +		ret = ENOMEM;
     +		goto out_reply;
     +	}
     +
     +	got = pread(single_file.backing_fd, buf, count, pos);
     +	if (got < 0) {
    -+		ret = -errno;
    ++		ret = errno;
     +		goto out_reply;
     +	}
     +
     +	fuse_reply_buf(req, buf, got);
     +	goto out_buf;
     +
    @@ example/service_ll.c (new)
     +out_buf:
     +	free(buf);
     +}
     +
     +static void service_ll_write(fuse_req_t req, fuse_ino_t ino, const char *buf,
     +			     size_t count, off_t pos,
    -+			     struct fuse_file_info *fp)
    ++			     struct fuse_file_info *fi)
     +{
     +	ssize_t got;
     +	int ret;
     +
     +	if (!is_single_file_ino(ino)) {
     +		ret = EIO;
    @@ example/service_ll.c (new)
     +	if (ll.debug)
     +		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
     +			__func__,
     +			(unsigned long long)pos,
     +			(unsigned long long)count);
     +
    -+	if (!single_file.allow_dio && fp->direct_io) {
    ++	if (!single_file.allow_dio && fi->direct_io) {
     +		ret = ENOSYS;
     +		goto out_reply;
     +	}
     +
    -+	if (pos >= single_file.isize) {
    -+		ret = EFBIG;
    ++	ret = -single_file_check_write(pos, &count);
    ++	if (ret)
     +		goto out_reply;
    -+	}
    -+
    -+	if (pos >= single_file.isize - count)
    -+		count = single_file.isize - pos;
     +
     +	got = pwrite(single_file.backing_fd, buf, count, pos);
     +	if (got < 0) {
    -+		ret = -errno;
    ++		ret = errno;
     +		goto out_reply;
     +	}
     +
     +	if (single_file.sync) {
     +		ret = fsync(single_file.backing_fd);
     +		if (ret < 0) {
    -+			ret = -errno;
    ++			ret = errno;
     +			goto out_reply;
     +		}
     +	}
     +
     +	fuse_reply_write(req, got);
     +	return;
    @@ example/service_ll.c (new)
     +	FUSE_OPT_END
     +};
     +
     +static int service_ll_opt_proc(void *data, const char *arg, int key,
     +				 struct fuse_args *outargs)
     +{
    -+	if (single_file_opt_proc(data, arg, key, outargs) == 0)
    -+		return 0;
    ++	int ret = single_file_opt_proc(data, arg, key, outargs);
    ++
    ++	if (ret < 1)
    ++		return ret;
     +
     +	switch (key) {
     +	case FUSE_OPT_KEY_NONOPT:
     +		if (!ll.device) {
     +			ll.device = strdup(arg);
     +			return 0;
    @@ example/service_ll.socket.in (new)
     +[Unit]
     +Description=Socket for service_ll Service
     +
     +[Socket]
     +ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/service_ll
     +Accept=yes
    -+SocketMode=0220
    ++SocketMode=@FUSE_SERVICE_SOCKET_PERMS@
     +RemoveOnStop=yes
     +
     +[Install]
     +WantedBy=sockets.target
     
      ## example/service_ll@.service (new) ##
    @@ example/single_file.c (new)
     +#include <errno.h>
     +#include <stdio.h>
     +#include <string.h>
     +#include <unistd.h>
     +#include <sys/ioctl.h>
     +#include <sys/stat.h>
    ++#ifdef __linux__
     +#include <linux/fs.h>
     +#include <linux/stat.h>
    ++#endif
     +
     +#define FUSE_USE_VERSION (FUSE_MAKE_VERSION(3, 19))
     +
     +#include "fuse_lowlevel.h"
     +#include "fuse_service.h"
     +#include "single_file.h"
    @@ example/single_file.c (new)
     +	return ino == SINGLE_FILE_INO;
     +}
     +
     +void single_file_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
     +			    off_t off, struct fuse_file_info *fi)
     +{
    ++	struct dirbuf b;
    ++
     +	(void) fi;
     +
    -+	if (ino != FUSE_ROOT_ID)
    ++	switch (ino) {
    ++	case FUSE_ROOT_ID:
    ++		break;
    ++	case SINGLE_FILE_INO:
     +		fuse_reply_err(req, ENOTDIR);
    -+	else {
    -+		struct dirbuf b;
    -+
    -+		memset(&b, 0, sizeof(b));
    -+		dirbuf_add(req, &b, ".", FUSE_ROOT_ID);
    -+		dirbuf_add(req, &b, "..", FUSE_ROOT_ID);
    -+		dirbuf_add(req, &b, single_file_name, SINGLE_FILE_INO);
    -+		reply_buf_limited(req, b.p, b.size, off, size);
    -+		free(b.p);
    ++		return;
    ++	default:
    ++		fuse_reply_err(req, ENOENT);
    ++		return;
     +	}
    ++
    ++	memset(&b, 0, sizeof(b));
    ++	dirbuf_add(req, &b, ".", FUSE_ROOT_ID);
    ++	dirbuf_add(req, &b, "..", FUSE_ROOT_ID);
    ++	dirbuf_add(req, &b, single_file_name, SINGLE_FILE_INO);
    ++	reply_buf_limited(req, b.p, b.size, off, size);
    ++	free(b.p);
     +}
     +
     +static bool sf_stat(fuse_ino_t ino, struct single_file_stat *llstat)
     +{
     +	struct fuse_entry_param *entry = &llstat->entry;
     +	struct stat *stbuf = &entry->attr;
    @@ example/single_file.c (new)
     +		fuse_reply_err(req, ENOENT);
     +	else
     +		fuse_reply_attr(req, &llstat.entry.attr,
     +				llstat.entry.attr_timeout);
     +}
     +
    ++static void get_now(struct timespec *now)
    ++{
    ++#ifdef CLOCK_REALTIME
    ++	if (!clock_gettime(CLOCK_REALTIME, now))
    ++		return;
    ++#endif
    ++
    ++	now->tv_sec = time(NULL);
    ++	now->tv_nsec = 0;
    ++}
    ++
     +void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
     +			    int to_set, struct fuse_file_info *fi)
     +{
    ++	struct timespec now;
    ++
    ++	if (ino != SINGLE_FILE_INO)
    ++		goto deny;
    ++	if (to_set & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID |
    ++		      FUSE_SET_ATTR_SIZE))
    ++		goto deny;
    ++
    ++	get_now(&now);
    ++
     +	pthread_mutex_lock(&single_file.lock);
     +	if (to_set & FUSE_SET_ATTR_MODE)
    -+		single_file.mode = attr->st_mode;
    -+	if (to_set & FUSE_SET_ATTR_ATIME)
    -+		single_file.atime = attr->st_atim;
    -+	if (to_set & FUSE_SET_ATTR_MTIME)
    -+		single_file.mtime = attr->st_mtim;
    ++		single_file.mode = (single_file.mode & S_IFMT) |
    ++				   (attr->st_mode & ~S_IFMT);
    ++	if (to_set & FUSE_SET_ATTR_ATIME) {
    ++		if (to_set & FUSE_SET_ATTR_ATIME_NOW)
    ++			single_file.atime = now;
    ++		else
    ++			single_file.atime = attr->st_atim;
    ++	}
    ++	if (to_set & FUSE_SET_ATTR_MTIME) {
    ++		if (to_set & FUSE_SET_ATTR_MTIME_NOW)
    ++			single_file.mtime = now;
    ++		else
    ++			single_file.mtime = attr->st_mtim;
    ++	}
     +	pthread_mutex_unlock(&single_file.lock);
     +
     +	single_file_ll_getattr(req, ino, fi);
    ++	return;
    ++deny:
    ++	fuse_reply_err(req, EPERM);
     +}
     +
     +void single_file_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
     +{
     +	struct single_file_stat llstat;
     +	bool filled;
    @@ example/single_file.c (new)
     +		fuse_reply_err(req, EACCES);
     +	else
     +		fuse_reply_open(req, fi);
     +}
     +
     +void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
    -+			  struct fuse_file_info *fp)
    ++			  struct fuse_file_info *fi)
     +{
     +	int ret = 0;
     +
     +	(void)datasync;
    -+	(void)fp;
    ++	(void)fi;
     +
     +	if (ino == SINGLE_FILE_INO) {
     +		ret = fsync(single_file.backing_fd);
     +		if (ret)
    -+			ret = -errno;
    ++			ret = errno;
     +	}
     +
     +	fuse_reply_err(req, ret);
     +}
     +
     +unsigned long long parse_num_blocks(const char *arg, int log_block_size)
    @@ example/single_file.c (new)
     +	}
     +	return num;
     +}
     +
     +static int single_file_set_blocksize(const char *arg)
     +{
    -+	single_file.blocksize = parse_num_blocks(arg, -1);
    -+	if (single_file.blocksize < 512 || single_file.blocksize > INT32_MAX ||
    -+	    (single_file.blocksize & (single_file.blocksize - 1)) != 0) {
    ++	unsigned long long l = parse_num_blocks(arg, -1);
    ++
    ++	if (l < 512 || l > INT32_MAX || (l & (l - 1)) != 0) {
     +		fprintf(stderr, "%s: block size must be power of two between 512 and 2G.\n",
     +			arg);
     +		return -1;
     +	}
     +
     +	/* do not pass through to libfuse */
    ++	single_file.blocksize = l;
     +	return 0;
     +}
     +
     +static int single_file_set_size(const char *arg)
     +{
    -+	single_file.isize = parse_num_blocks(arg, -1);
    -+	if (single_file.isize < 1 || (single_file.isize & 511) != 0) {
    ++	unsigned long long l = parse_num_blocks(arg, -1);
    ++
    ++	if (l < 1 || (l & 511) != 0 || l > INT64_MAX) {
     +		fprintf(stderr, "%s: size must be multiple of 512 and larger than zero.\n",
    -+			arg + 5);
    ++			arg);
     +		return -1;
     +	}
     +
     +	/* do not pass through to libfuse */
    ++	single_file.isize = l;
     +	return 0;
     +}
     +
     +int single_file_opt_proc(void *data, const char *arg, int key,
     +			 struct fuse_args *outargs)
     +{
     +	(void)data;
     +	(void)outargs;
     +
     +	switch (key) {
     +	case SINGLE_FILE_RO:
    ++		/* pass through to libfuse */
     +		single_file.ro = true;
    -+		return 0;
    ++		return 1;
     +	case SINGLE_FILE_RW:
    ++		/* pass through to libfuse */
     +		single_file.ro = false;
    ++		return 1;
    ++	case SINGLE_FILE_REQUIRE_BDEV:
    ++		single_file.require_bdev = true;
     +		return 0;
     +	case SINGLE_FILE_DIO:
     +		single_file.allow_dio = true;
     +		return 0;
     +	case SINGLE_FILE_NODIO:
     +		single_file.allow_dio = false;
    @@ example/single_file.c (new)
     +{
     +	int open_flags = single_file.ro ? O_RDONLY : O_RDWR;
     +	int fd;
     +	int ret;
     +
     +again:
    -+	if (single_file.blocksize)
    ++	if (single_file.require_bdev)
     +		ret = fuse_service_request_blockdev(sf, path,
     +						    open_flags | O_EXCL, 0, 0,
     +						    single_file.blocksize);
     +	else
     +		ret = fuse_service_request_file(sf, path, open_flags | O_EXCL,
     +						0, 0);
     +	if (ret)
     +		return ret;
     +
    ++	if (!single_file.ro && open_flags == O_RDONLY)
    ++		single_file.ro = true;
    ++
     +	ret = fuse_service_receive_file(sf, path, &fd);
     +	if (ret)
     +		return ret;
     +
     +	/* downgrade from rw to ro if necessary */
     +	if ((fd == -EPERM || fd == -EACCES) && open_flags == O_RDWR) {
    @@ example/single_file.c (new)
     +	}
     +
     +	single_file.backing_fd = fd;
     +	return 0;
     +}
     +
    ++int single_file_check_write(off_t pos, size_t *count)
    ++{
    ++	if (pos >= single_file.isize)
    ++		return -EFBIG;
    ++
    ++	if (*count > single_file.isize)
    ++		*count = single_file.isize;
    ++	if (pos >= single_file.isize - *count)
    ++		*count = single_file.isize - pos;
    ++
    ++	return 0;
    ++}
    ++
    ++void single_file_check_read(off_t pos, size_t *count)
    ++{
    ++	int ret = single_file_check_write(pos, count);
    ++
    ++	if (ret)
    ++		*count = 0;
    ++}
    ++
     +int single_file_configure(const char *device, const char *filename)
     +{
     +	struct stat statbuf;
     +	unsigned long long backing_size;
    ++	unsigned int proposed_blocksize;
     +	int lbasize;
     +	int ret;
     +
    -+	if (!single_file.blocksize)
    -+		single_file.blocksize = sysconf(_SC_PAGESIZE);
    -+
     +	ret = fstat(single_file.backing_fd, &statbuf);
     +	if (ret) {
     +		perror(device);
     +		return -1;
     +	}
     +	lbasize = statbuf.st_blksize;
    @@ example/single_file.c (new)
     +
     +	if (lbasize == 0) {
     +		fprintf(stderr, "%s: blocksize zero?\n", device);
     +		return -1;
     +	}
     +
    -+	if (lbasize > single_file.blocksize) {
    ++	proposed_blocksize = single_file.blocksize ? single_file.blocksize :
    ++						     sysconf(_SC_PAGESIZE);
    ++	if (lbasize > proposed_blocksize) {
     +		fprintf(stderr, "%s: lba size %u smaller than blocksize %u\n",
    -+			device, lbasize, single_file.blocksize);
    ++			device, lbasize, proposed_blocksize);
     +		return -1;
     +	}
     +
    -+	if (single_file.isize % single_file.blocksize > 0) {
    ++	if (single_file.isize % proposed_blocksize > 0) {
     +		fprintf(stderr, "%s: size parameter %llu not congruent with blocksize %u\n",
     +			device, (unsigned long long)single_file.isize,
    -+			single_file.blocksize);
    ++			proposed_blocksize);
     +		return -1;
     +	}
     +
     +	if (single_file.isize > backing_size) {
     +		fprintf(stderr, "%s: file size %llu smaller than size param %llu\n",
     +			device, backing_size,
     +			(unsigned long long)single_file.isize);
     +		return -1;
     +	}
     +
    ++	if (!single_file.blocksize)
    ++		single_file.blocksize = proposed_blocksize;
     +	if (!single_file.isize)
     +		single_file.isize = backing_size;
    ++
     +	single_file.isize = round_down(single_file.isize, single_file.blocksize);
     +	single_file.blocks = single_file.isize / single_file.blocksize;
     +
     +	return single_file_configure_simple(filename);
     +}
     +
    @@ example/single_file.c (new)
     +	if (single_file_name_set)
     +		free((void *)single_file_name);
     +	single_file_name_set = false;
     +}
     
      ## meson.build ##
    -@@ meson.build: args_default = [ '-D_GNU_SOURCE' ]
    - private_cfg = configuration_data()
    - private_cfg.set_quoted('PACKAGE_VERSION', meson.project_version())
    - service_socket_dir = get_option('service-socket-dir')
    +@@ meson.build: service_socket_perms = get_option('service-socket-perms')
      if service_socket_dir == ''
        service_socket_dir = '/run/filesystems'
      endif
    + if service_socket_perms == ''
    +   service_socket_perms = '0220'
    + endif
     +private_cfg.set('FUSE_SERVICE_SOCKET_DIR_RAW', service_socket_dir)
      private_cfg.set_quoted('FUSE_SERVICE_SOCKET_DIR', service_socket_dir)
    + private_cfg.set('FUSE_SERVICE_SOCKET_PERMS', service_socket_perms)
      
      # Test for presence of some functions
      test_funcs = [ 'fork', 'fstatat', 'openat', 'readlinkat', 'pipe2',
                     'splice', 'vmsplice', 'posix_fallocate', 'fdatasync',
    -                'utimensat', 'copy_file_range', 'fallocate', 'fspacectl' ]
    -@@ meson.build: special_funcs = {
    -            int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
    -            int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
    -            int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
    -            res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
    -            return 0;
    -        }
    -+    ''',
    -+    'linux_bdev_ioctls': '''
    -+       #define _GNU_SOURCE
    -+       #include <stddef.h>
    -+       #include <sys/ioctl.h>
    -+       #include <sys/stat.h>
    -+       #include <linux/fs.h>
    -+       #include <linux/stat.h>
    -+
    -+       int main(void) {
    -+           ioctl(-1, BLKSSZGET, 0);
    -+           ioctl(-1, BLKGETSIZE64, 0);
    -+           return 0;
    -+       }
    -     '''
    - }
    - 
    - foreach name, code : special_funcs
    -     private_cfg.set('HAVE_' + name.to_upper(),
    -         cc.links(code, args: args_default,
15:  778207a250dba7 ! 12:  e29aaa099e1192 example/service: create a sample systemd service for a high-level fuse server
    @@ Commit message
         Create a simple high-level fuse server that can be run as a systemd
         service.
     
         Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## example/single_file.h ##
    -@@ example/single_file.h: int single_file_service_open(struct fuse_service *sf, const char *path);
    +@@ example/single_file.h: int single_file_check_write(off_t pos, size_t *count);
      int single_file_configure(const char *device, const char *filename);
      int single_file_configure_simple(const char *filename);
      void single_file_close(void);
      
      /* low-level fuse operation handlers */
      
    @@ example/single_file.h: int single_file_service_open(struct fuse_service *sf, con
      void single_file_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
      				off_t off, struct fuse_file_info *fi);
      
     @@ example/single_file.h: void single_file_ll_open(fuse_req_t req, fuse_ino_t ino,
      
      void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
    - 			  struct fuse_file_info *fp);
    + 			  struct fuse_file_info *fi);
      
      int reply_buf_limited(fuse_req_t req, const char *buf, size_t bufsize,
      		      off_t off, size_t maxsize);
     +#endif
     +
     +/* high-level fuse operation handlers */
     +
     +#ifdef USE_SINGLE_FILE_HL_API
    -+bool is_single_file_path(const char *name);
    ++bool is_single_open_file_path(const struct fuse_file_info *fi, const char *name);
     +
     +int single_file_hl_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
     +			   off_t offset, struct fuse_file_info *fi,
     +			   enum fuse_readdir_flags flags);
     +
     +int single_file_hl_statfs(const char *path, struct statvfs *buf);
     +
     +int single_file_hl_getattr(const char *path, struct stat *stbuf,
     +			   struct fuse_file_info *fi);
     +int single_file_hl_chmod(const char *path, mode_t mode,
    -+			 struct fuse_file_info *fp);
    ++			 struct fuse_file_info *fi);
     +int single_file_hl_utimens(const char *path, const struct timespec ctv[2],
     +			   struct fuse_file_info *fi);
    ++int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
    ++			 struct fuse_file_info *fi);
    ++int single_file_hl_truncate(const char *path, off_t len,
    ++			    struct fuse_file_info *fi);
     +
    ++int single_file_hl_opendir(const char *path, struct fuse_file_info *fi);
     +int single_file_hl_open(const char *path, struct fuse_file_info *fi);
     +
     +int single_file_hl_fsync(const char *path, int datasync,
    -+			 struct fuse_file_info *fp);
    ++			 struct fuse_file_info *fi);
     +#endif
     +
     +#if !defined(USE_SINGLE_FILE_LL_API) && !defined(USE_SINGLE_FILE_HL_API)
     +# warning USE_SINGLE_FILE_[HL]L_API not defined!
     +#endif
      
    @@ example/service_hl.c (new)
     +	cfg->kernel_cache = 1;
     +
     +	return NULL;
     +}
     +
     +static int service_hl_read(const char *path, char *buf, size_t count,
    -+			   off_t pos, struct fuse_file_info *fp)
    ++			   off_t pos, struct fuse_file_info *fi)
     +{
     +	ssize_t got;
     +
    -+	(void)fp;
    -+
    -+	if (!is_single_file_path(path))
    ++	if (!is_single_open_file_path(fi, path))
     +		return -EIO;
     +
     +	if (hl.debug)
     +		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
     +			__func__,
     +			(unsigned long long)pos,
     +			(unsigned long long)count);
     +
    ++	if (!single_file.allow_dio && fi->direct_io)
    ++		return -ENOSYS;
    ++
    ++	single_file_check_read(pos, &count);
    ++
    ++	if (!count)
    ++		return 0;
    ++
     +	got = pread(single_file.backing_fd, buf, count, pos);
     +	if (got < 0)
     +		return -errno;
     +
     +	return got;
     +}
     +
     +static int service_hl_write(const char *path, const char *buf, size_t count,
    -+			    off_t pos, struct fuse_file_info *fp)
    ++			    off_t pos, struct fuse_file_info *fi)
     +{
     +	ssize_t got;
    ++	int ret;
     +
    -+	(void)fp;
    -+
    -+	if (!is_single_file_path(path))
    ++	if (!is_single_open_file_path(fi, path))
     +		return -EIO;
     +
     +	if (hl.debug)
     +		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
     +			__func__,
     +			(unsigned long long)pos,
     +			(unsigned long long)count);
     +
    -+	if (pos >= single_file.isize)
    -+		return -EFBIG;
    ++	if (!single_file.allow_dio && fi->direct_io)
    ++		return -ENOSYS;
     +
    -+	if (pos >= single_file.isize - count)
    -+		count = single_file.isize - pos;
    ++	ret = single_file_check_write(pos, &count);
    ++	if (ret < 0)
    ++		return ret;
     +
     +	got = pwrite(single_file.backing_fd, buf, count, pos);
     +	if (got < 0)
     +		return -errno;
     +
    ++	if (single_file.sync) {
    ++		ret = fsync(single_file.backing_fd);
    ++		if (ret < 0)
    ++			return -errno;
    ++	}
    ++
     +	return got;
     +}
     +
     +static const struct fuse_operations service_hl_oper = {
     +	.getattr	= single_file_hl_getattr,
     +	.readdir	= single_file_hl_readdir,
     +	.open		= single_file_hl_open,
    ++	.opendir	= single_file_hl_opendir,
     +	.statfs		= single_file_hl_statfs,
     +	.chmod		= single_file_hl_chmod,
     +	.utimens	= single_file_hl_utimens,
     +	.fsync		= single_file_hl_fsync,
    ++	.chown		= single_file_hl_chown,
    ++	.truncate	= single_file_hl_truncate,
     +
     +	.init		= service_hl_init,
     +	.read		= service_hl_read,
     +	.write		= service_hl_write,
     +};
     +
    @@ example/service_hl.c (new)
     +	FUSE_OPT_END
     +};
     +
     +static int service_hl_opt_proc(void *data, const char *arg, int key,
     +			       struct fuse_args *outargs)
     +{
    -+	(void)data;
    -+	(void)outargs;
    ++	int ret = single_file_opt_proc(data, arg, key, outargs);
    ++
    ++	if (ret < 1)
    ++		return ret;
     +
     +	switch (key) {
     +	case FUSE_OPT_KEY_NONOPT:
     +		if (!hl.device) {
     +			hl.device = strdup(arg);
     +			return 0;
    @@ example/service_hl.c (new)
     +
     +	if (single_file_configure(hl.device, NULL))
     +		goto err_singlefile;
     +
     +	fuse_service_expect_mount_mode(hl.service, S_IFDIR);
     +
    -+	ret = fuse_service_main(hl.service, args.argc, args.argv,
    -+				&service_hl_oper, NULL);
    ++	ret = fuse_service_main(hl.service, &args, &service_hl_oper, NULL);
     +
     +err_singlefile:
     +	single_file_close();
     +err_service:
     +	free(hl.device);
     +	fuse_service_send_goodbye(hl.service, ret);
    @@ example/service_hl.socket.in (new)
     +[Unit]
     +Description=Socket for service_hl Service
     +
     +[Socket]
     +ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/service_hl
     +Accept=yes
    -+SocketMode=0220
    ++SocketMode=@FUSE_SERVICE_SOCKET_PERMS@
     +RemoveOnStop=yes
     +
     +[Install]
     +WantedBy=sockets.target
     
      ## example/service_hl@.service (new) ##
    @@ example/service_ll.c
      	struct fuse_session *se;
      	char *device;
      	struct fuse_service *service;
     
      ## example/single_file.c ##
     @@
    - #include <linux/fs.h>
      #include <linux/stat.h>
    + #endif
      
      #define FUSE_USE_VERSION (FUSE_MAKE_VERSION(3, 19))
      
      #include "fuse_lowlevel.h"
     +#include "fuse.h"
      #include "fuse_service.h"
    @@ example/single_file.c: struct single_file single_file = {
     +	if (strcmp(path, "/") == 0)
     +		return FUSE_ROOT_ID;
     +	if (strcmp(path + 1, single_file_name) == 0)
     +		return SINGLE_FILE_INO;
     +	return 0;
     +}
    ++
    ++static fuse_ino_t single_open_file_path_to_ino(const struct fuse_file_info *fi,
    ++					       const char *path)
    ++{
    ++	if (fi)
    ++		return fi->fh;
    ++	return single_file_path_to_ino(path);
    ++}
     +
      static void dirbuf_add(fuse_req_t req, struct dirbuf *b, const char *name,
      		       fuse_ino_t ino)
      {
      	struct stat stbuf;
      	size_t oldsize = b->size;
    @@ example/single_file.c: bool is_single_file_child(fuse_ino_t parent, const char *
      
      bool is_single_file_ino(fuse_ino_t ino)
      {
      	return ino == SINGLE_FILE_INO;
      }
      
    -+bool is_single_file_path(const char *name)
    ++bool is_single_open_file_path(const struct fuse_file_info *fi, const char *name)
     +{
    ++	if (fi)
    ++		return is_single_file_ino(fi->fh);
     +	return name[0] == '/' && strcmp(name + 1, single_file_name) == 0;
     +}
     +
      void single_file_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
      			    off_t off, struct fuse_file_info *fi)
      {
    + 	struct dirbuf b;
    + 
      	(void) fi;
    - 
    - 	if (ino != FUSE_ROOT_ID)
     @@ example/single_file.c: void single_file_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
    - 		dirbuf_add(req, &b, single_file_name, SINGLE_FILE_INO);
    - 		reply_buf_limited(req, b.p, b.size, off, size);
    - 		free(b.p);
    - 	}
    + 	dirbuf_add(req, &b, "..", FUSE_ROOT_ID);
    + 	dirbuf_add(req, &b, single_file_name, SINGLE_FILE_INO);
    + 	reply_buf_limited(req, b.p, b.size, off, size);
    + 	free(b.p);
      }
      
     +int single_file_hl_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
     +			   off_t offset, struct fuse_file_info *fi,
     +			   enum fuse_readdir_flags flags)
     +{
     +	struct stat stbuf;
    -+	fuse_ino_t ino = single_file_path_to_ino(path);
    ++	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
     +
     +	memset(&stbuf, 0, sizeof(stbuf));
     +
     +	(void) offset;
    -+	(void) fi;
     +	(void) flags;
     +
    -+	if (!ino)
    -+		return -ENOENT;
    -+	if (ino != SINGLE_FILE_INO)
    ++	switch (ino) {
    ++	case FUSE_ROOT_ID:
    ++		break;
    ++	case SINGLE_FILE_INO:
     +		return -ENOTDIR;
    ++	default:
    ++		return -ENOENT;
    ++	}
     +
     +	stbuf.st_ino = FUSE_ROOT_ID;
     +	filler(buf, ".", &stbuf, 0, FUSE_FILL_DIR_DEFAULTS);
     +	filler(buf, "..", &stbuf, 0, FUSE_FILL_DIR_DEFAULTS);
     +
     +	stbuf.st_ino = SINGLE_FILE_INO;
    @@ example/single_file.c: void single_file_ll_getattr(fuse_req_t req, fuse_ino_t in
      }
      
     +int single_file_hl_getattr(const char *path, struct stat *stbuf,
     +			   struct fuse_file_info *fi)
     +{
     +	struct single_file_stat llstat;
    -+	fuse_ino_t ino = single_file_path_to_ino(path);
    ++	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
     +	bool filled;
     +
    -+	(void) fi;
    -+
     +	if (!ino)
     +		return -ENOENT;
     +
     +	memset(&llstat, 0, sizeof(llstat));
     +	pthread_mutex_lock(&single_file.lock);
     +	filled = sf_stat(ino, &llstat);
    @@ example/single_file.c: void single_file_ll_getattr(fuse_req_t req, fuse_ino_t in
     +		return -ENOENT;
     +
     +	memcpy(stbuf, &llstat.entry.attr, sizeof(*stbuf));
     +	return 0;
     +}
     +
    - void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
    - 			    int to_set, struct fuse_file_info *fi)
    + static void get_now(struct timespec *now)
      {
    - 	pthread_mutex_lock(&single_file.lock);
    - 	if (to_set & FUSE_SET_ATTR_MODE)
    - 		single_file.mode = attr->st_mode;
    + #ifdef CLOCK_REALTIME
    + 	if (!clock_gettime(CLOCK_REALTIME, now))
    + 		return;
    + #endif
     @@ example/single_file.c: void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
    - 		single_file.mtime = attr->st_mtim;
    - 	pthread_mutex_unlock(&single_file.lock);
    - 
      	single_file_ll_getattr(req, ino, fi);
    + 	return;
    + deny:
    + 	fuse_reply_err(req, EPERM);
      }
      
     +int single_file_hl_chmod(const char *path, mode_t mode,
    -+			 struct fuse_file_info *fp)
    ++			 struct fuse_file_info *fi)
     +{
    -+	fuse_ino_t ino = single_file_path_to_ino(path);
    -+
    -+	(void)fp;
    ++	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
     +
     +	if (!ino)
     +		return -ENOENT;
     +	if (ino != SINGLE_FILE_INO)
    -+		return 0;
    ++		return -EPERM;
     +
     +	pthread_mutex_lock(&single_file.lock);
    -+	single_file.mode = (single_file.mode & ~0xFFF) | (mode & 0xFFF);
    ++	single_file.mode = (single_file.mode & S_IFMT) | (mode & ~S_IFMT);
     +	pthread_mutex_unlock(&single_file.lock);
     +
     +	return 0;
     +}
     +
    ++static void set_time(const struct timespec *ctv, struct timespec *tv)
    ++{
    ++	switch (ctv->tv_nsec) {
    ++	case UTIME_OMIT:
    ++		return;
    ++	case UTIME_NOW:
    ++		get_now(tv);
    ++		break;
    ++	default:
    ++		memcpy(tv, ctv, sizeof(*tv));
    ++		break;
    ++	}
    ++}
    ++
     +int single_file_hl_utimens(const char *path, const struct timespec ctv[2],
     +			   struct fuse_file_info *fi)
     +{
    -+	fuse_ino_t ino = single_file_path_to_ino(path);
    -+
    -+	(void)fi;
    ++	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
     +
     +	if (!ino)
     +		return -ENOENT;
     +	if (ino != SINGLE_FILE_INO)
    -+		return 0;
    ++		return -EPERM;
     +
     +	pthread_mutex_lock(&single_file.lock);
    -+	single_file.atime = ctv[0];
    -+	single_file.mtime = ctv[1];
    ++	set_time(&ctv[0], &single_file.atime);
    ++	set_time(&ctv[1], &single_file.mtime);
     +	pthread_mutex_unlock(&single_file.lock);
     +
     +	return 0;
     +}
    ++
    ++int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
    ++			 struct fuse_file_info *fi)
    ++{
    ++	(void)path;
    ++	(void)owner;
    ++	(void)group;
    ++	(void)fi;
    ++
    ++	return -EPERM;
    ++}
    ++
    ++int single_file_hl_truncate(const char *path, off_t len,
    ++			    struct fuse_file_info *fi)
    ++{
    ++	(void)path;
    ++	(void)len;
    ++	(void)fi;
    ++
    ++	return -EPERM;
    ++}
     +
      void single_file_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
      {
      	struct single_file_stat llstat;
      	bool filled;
      
    @@ example/single_file.c: void single_file_ll_open(fuse_req_t req, fuse_ino_t ino,
      	else if (single_file.ro && (fi->flags & O_ACCMODE) != O_RDONLY)
      		fuse_reply_err(req, EACCES);
      	else
      		fuse_reply_open(req, fi);
      }
      
    ++int single_file_hl_opendir(const char *path, struct fuse_file_info *fi)
    ++{
    ++	fuse_ino_t ino = single_file_path_to_ino(path);
    ++
    ++	if (!ino)
    ++		return -ENOENT;
    ++	if (ino == SINGLE_FILE_INO)
    ++		return -ENOTDIR;
    ++
    ++	fi->fh = ino;
    ++	return 0;
    ++}
    ++
     +int single_file_hl_open(const char *path, struct fuse_file_info *fi)
     +{
     +	fuse_ino_t ino = single_file_path_to_ino(path);
     +
     +	if (!ino)
     +		return -ENOENT;
     +	if (ino != SINGLE_FILE_INO)
     +		return -EISDIR;
     +	if (single_file.ro && (fi->flags & O_ACCMODE) != O_RDONLY)
     +		return -EACCES;
     +
    ++	fi->fh = ino;
     +	return 0;
     +}
     +
      void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
    - 			  struct fuse_file_info *fp)
    + 			  struct fuse_file_info *fi)
      {
      	int ret = 0;
      
      	(void)datasync;
     @@ example/single_file.c: void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
    - 			ret = -errno;
    + 			ret = errno;
      	}
      
      	fuse_reply_err(req, ret);
      }
      
     +int single_file_hl_fsync(const char *path, int datasync,
    -+			 struct fuse_file_info *fp)
    ++			 struct fuse_file_info *fi)
     +{
    -+	fuse_ino_t ino = single_file_path_to_ino(path);
    ++	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
     +	int ret = 0;
     +
     +	(void)datasync;
    -+	(void)fp;
     +
     +	if (!ino)
     +		return -ENOENT;
     +
     +	if (ino == SINGLE_FILE_INO) {
     +		ret = fsync(single_file.backing_fd);
16:  e7491358b3afe5 <  -:  -------------- example/hello_ll: port to single-file common code
17:  77cd9cf9807a8f ! 13:  0db39a8f8844ff nullfs: support fuse systemd service mode
    @@ example/meson.build: if not platform.endswith('bsd') and platform != 'dragonfly'
          # According to Conrad Meyer <cem@freebsd.org>, FreeBSD doesn't
          # support mounting files, This is enforced in vfs_domount_first()
          # with the v_type != VDIR check.
          examples += [ 'null' ]
     +
     +    if platform.endswith('linux')
    -+        configure_file(input: 'nullfile.socket.in',
    -+                       output: 'nullfile.socket',
    ++        configure_file(input: 'null.socket.in',
    ++                       output: 'null.socket',
     +                       configuration: private_cfg)
     +    endif
      endif
      
    - single_file_examples = [ 'hello_ll' ]
    + single_file_examples = [ ]
      
      if platform.endswith('linux')
          single_file_examples += [ 'service_ll' ]
     
      ## example/null.c ##
     @@
    @@ example/null.c
       * Compile with:
       *
       *     gcc -Wall null.c `pkg-config fuse3 --cflags --libs` -o null
       *
     + * Change the ExecStart line in nullfile@.service:
     + *
    -+ *     ExecStart=/path/to/nullfile
    ++ *     ExecStart=/path/to/null
     + *
    -+ * to point to the actual path of the nullfile binary.
    ++ * to point to the actual path of the null binary.
     + *
    -+ * Finally, install the nullfile@.service and nullfile.socket files to the
    ++ * Finally, install the null@.service and null.socket files to the
     + * systemd service directory, usually /run/systemd/system.
     + *
       * ## Source code ##
       * \include passthrough_fh.c
       */
      
    @@ example/null.c
      #include <stdio.h>
      #include <stdlib.h>
      #include <string.h>
      #include <unistd.h>
      #include <time.h>
      #include <errno.h>
    + 
    ++static mode_t mode = 0644;
    ++
    + static int null_getattr(const char *path, struct stat *stbuf,
    + 			struct fuse_file_info *fi)
    + {
    + 	(void) fi;
    + 
    + 	if(strcmp(path, "/") != 0)
    + 		return -ENOENT;
    + 
    +-	stbuf->st_mode = S_IFREG | 0644;
    ++	stbuf->st_mode = S_IFREG | mode;
    + 	stbuf->st_nlink = 1;
    + 	stbuf->st_uid = getuid();
    + 	stbuf->st_gid = getgid();
    + 	stbuf->st_size = (1ULL << 32); /* 4G */
    + 	stbuf->st_blocks = 0;
    + 	stbuf->st_atime = stbuf->st_mtime = stbuf->st_ctime = time(NULL);
     @@ example/null.c: static const struct fuse_operations null_oper = {
    + 	.truncate	= null_truncate,
    + 	.open		= null_open,
    + 	.read		= null_read,
    + 	.write		= null_write,
    + };
      
    ++static int null_service(struct fuse_service *service, struct fuse_args *args)
    ++{
    ++	int ret = 1;
    ++
    ++	if (fuse_service_append_args(service, args))
    ++		goto err_service;
    ++
    ++	if (fuse_service_finish_file_requests(service))
    ++		goto err_service;
    ++
    ++	fuse_service_expect_mount_mode(service, S_IFREG);
    ++
    ++	/*
    ++	 * In non-service mode, we set up the file to be owned and writable
    ++	 * by the same user that starts the fuse server.  When running in a
    ++	 * container as a dynamic user, we just grant world write access.
    ++	 */
    ++	mode = 0666;
    ++	ret = fuse_service_main(service, args, &null_oper, NULL);
    ++
    ++err_service:
    ++	fuse_service_send_goodbye(service, ret);
    ++	fuse_service_destroy(&service);
    ++	fuse_opt_free_args(args);
    ++	return fuse_service_exit(ret);
    ++}
    ++
      int main(int argc, char *argv[])
      {
      	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
      	struct fuse_cmdline_opts opts;
      	struct stat stbuf;
     +	struct fuse_service *service = NULL;
    -+	int ret;
     +
     +	if (fuse_service_accept(&service) != 0)
     +		return 1;
     +
    -+	if (fuse_service_accepted(service)) {
    -+		if (fuse_service_append_args(service, &args) != 0)
    -+			return 1;
    -+		if (fuse_service_finish_file_requests(service) != 0)
    -+			return 1;
    -+
    -+		fuse_service_expect_mount_mode(service, S_IFREG);
    -+
    -+		ret = fuse_service_main(service, args.argc, args.argv,
    -+					&null_oper, NULL);
    -+
    -+		fuse_opt_free_args(&args);
    -+		return fuse_service_exit(ret);
    -+	}
    ++	if (fuse_service_accepted(service))
    ++		return null_service(service, &args);
      
      	if (fuse_parse_cmdline(&args, &opts) != 0)
      		return 1;
      	fuse_opt_free_args(&args);
      
      	if (!opts.mountpoint) {
     
    - ## example/nullfile.socket.in (new) ##
    + ## example/null.socket.in (new) ##
     @@
     +# SPDX-License-Identifier: GPL-2.0-or-later
     +#
     +# Copyright (C) 2026 Oracle.  All Rights Reserved.
     +# Author: Darrick J. Wong <djwong@kernel.org>
     +[Unit]
    -+Description=Socket for nullfile Service
    ++Description=Socket for null Service
     +
     +[Socket]
    -+ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/nullfile
    ++ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/null
     +Accept=yes
    -+SocketMode=0220
    ++SocketMode=@FUSE_SERVICE_SOCKET_PERMS@
     +RemoveOnStop=yes
     +
     +[Install]
     +WantedBy=sockets.target
     
    - ## example/nullfile@.service (new) ##
    + ## example/null@.service (new) ##
     @@
     +# SPDX-License-Identifier: GPL-2.0-or-later
     +#
     +# Copyright (C) 2026 Oracle.  All Rights Reserved.
     +# Author: Darrick J. Wong <djwong@kernel.org>
     +[Unit]
    -+Description=nullfile Sample Fuse Service
    ++Description=null Sample Fuse Service
     +
     +# Don't leave failed units behind, systemd does not clean them up!
     +CollectMode=inactive-or-failed
     +
     +[Service]
     +Type=exec
