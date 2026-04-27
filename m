Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C36325490;
	Mon, 27 Apr 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302271; cv=none; b=doR6W7ZlhmXc4U9Aec981t6rgIbEFDbjKXKJS0IwYcFQ1dYUJ16tODpl+SQnF52QT349cZAnRMRAQ2k5zYZCIhMVDGLEJn3OdnVJiIUkxBQ5xSO8kIHzSyT66DrZJnBce7Lt5odtAapySY6+EE8XRENPL5j1C1nFdF7Uzte/68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302271; c=relaxed/simple;
	bh=Lzq2J/AH6kazKUDXwtWZcPhs2U0QjCMJanWSXZLwJE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3b4Nh8CouuCnOFiphXPtQ3K6o9Hpe3GXokpfs+aHUWBXQ4X/OpXCpIXdX96qlCka6m6jI4ldF1RJLFhNxSQZxK5J2bDA4j7DoDker7pSUSGQBYcbo0T793OBLYkUDTfXZg9uZYakwXxtw8eolTOXf1ZzjEWtxh0JHm4HEsYz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW7nd/yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW7nd/yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A731EC19425;
	Mon, 27 Apr 2026 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302270;
	bh=Lzq2J/AH6kazKUDXwtWZcPhs2U0QjCMJanWSXZLwJE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lW7nd/yDLYJkPzC7h1wepnEo3gJPjTXFdZlPWz368JXlfJVXgkeqSLbB+frlUzHuE
	 5WBmnAfCY76HLKSRb+gYDJ4U9y9Nrwcg/V2WoeeZTsQqroTw5P+8/H2HZoQtAGNWi0
	 UKSSstb9LhdfypUunHa8Qis9AKz+kk/QYL4tmL4pCfNmdUaBtGbQu6q/5kfP7+v1xl
	 pCB2AIaQJ2JPklhpVTzKsJspTuXzI+wW1ufNwMf6/1pM11jm9HF+JdfPeOmDnxvIOV
	 OBQlsQJfEDlJvAY4XgdxnXawTmMqE15xHXMM0aEGLKgX828e/4YGTPgE3B6jTL98me
	 qMg4jlmAEIYUg==
Date: Mon, 27 Apr 2026 08:04:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	miklos@szeredi.hu, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 12/13] example/service: create a sample systemd service
 for a high-level fuse server
Message-ID: <20260427150430.GM7739@frogsfrogsfrogs>
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <177689988756.3820166.5462739027142309789.stgit@frogsfrogsfrogs>
 <59c194c0-3ea8-4c04-acb8-5e664545ce1c@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c194c0-3ea8-4c04-acb8-5e664545ce1c@bsbernd.com>

On Sun, Apr 26, 2026 at 11:04:35PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/23/26 01:22, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a simple high-level fuse server that can be run as a systemd
> > service.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  example/single_file.h        |   38 ++++++
> >  example/meson.build          |    6 +
> >  example/service_hl.c         |  224 +++++++++++++++++++++++++++++++++++
> >  example/service_hl.socket.in |   15 ++
> >  example/service_hl@.service  |  102 ++++++++++++++++
> >  example/service_ll.c         |    1 
> >  example/single_file.c        |  271 +++++++++++++++++++++++++++++++++++++++---
> >  7 files changed, 640 insertions(+), 17 deletions(-)
> >  create mode 100644 example/service_hl.c
> >  create mode 100644 example/service_hl.socket.in
> >  create mode 100644 example/service_hl@.service
> > 
> > 
> > diff --git a/example/single_file.h b/example/single_file.h
> > index d8a91adbf875ef..86edb51afb3384 100644
> > --- a/example/single_file.h
> > +++ b/example/single_file.h
> > @@ -124,6 +124,7 @@ ssize_t single_file_pread(char *buf, size_t count, off_t pos);
> >  
> >  /* low-level fuse operation handlers */
> >  
> > +#ifdef USE_SINGLE_FILE_LL_API
> >  bool is_single_file_child(fuse_ino_t parent, const char *name);
> >  bool is_single_file_ino(fuse_ino_t ino);
> >  
> > @@ -149,5 +150,42 @@ void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
> >  
> >  int reply_buf_limited(fuse_req_t req, const char *buf, size_t bufsize,
> >  		      off_t off, size_t maxsize);
> > +#endif
> > +
> > +/* high-level fuse operation handlers */
> > +
> > +#ifdef USE_SINGLE_FILE_HL_API
> > +bool is_single_open_file_path(const struct fuse_file_info *fi, const char *name);
> > +
> > +int single_file_hl_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> > +			   off_t offset, struct fuse_file_info *fi,
> > +			   enum fuse_readdir_flags flags);
> > +
> > +int single_file_hl_statfs(const char *path, struct statvfs *buf);
> > +
> > +int single_file_hl_statx(const char *path, int statx_flags, int statx_mask,
> > +			 struct statx *stx, struct fuse_file_info *fi);
> > +
> > +int single_file_hl_getattr(const char *path, struct stat *stbuf,
> > +			   struct fuse_file_info *fi);
> > +int single_file_hl_chmod(const char *path, mode_t mode,
> > +			 struct fuse_file_info *fi);
> > +int single_file_hl_utimens(const char *path, const struct timespec ctv[2],
> > +			   struct fuse_file_info *fi);
> > +int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
> > +			 struct fuse_file_info *fi);
> > +int single_file_hl_truncate(const char *path, off_t len,
> > +			    struct fuse_file_info *fi);
> > +
> > +int single_file_hl_opendir(const char *path, struct fuse_file_info *fi);
> > +int single_file_hl_open(const char *path, struct fuse_file_info *fi);
> > +
> > +int single_file_hl_fsync(const char *path, int datasync,
> > +			 struct fuse_file_info *fi);
> > +#endif
> > +
> > +#if !defined(USE_SINGLE_FILE_LL_API) && !defined(USE_SINGLE_FILE_HL_API)
> > +# warning USE_SINGLE_FILE_[HL]L_API not defined!
> > +#endif
> >  
> >  #endif /* FUSE_SINGLE_FILE_H_ */
> > diff --git a/example/meson.build b/example/meson.build
> > index e948f6ba74fdfa..19a383f7cd2c74 100644
> > --- a/example/meson.build
> > +++ b/example/meson.build
> > @@ -19,6 +19,12 @@ if platform.endswith('linux')
> >      configure_file(input: 'service_ll.socket.in',
> >                     output: 'service_ll.socket',
> >                     configuration: private_cfg)
> > +
> > +    single_file_examples += [ 'service_hl' ]
> > +    configure_file(input: 'service_hl.socket.in',
> > +                   output: 'service_hl.socket',
> > +                   configuration: private_cfg)
> > +
> >  endif
> >  
> >  threaded_examples = [ 'notify_inval_inode',
> > diff --git a/example/service_hl.c b/example/service_hl.c
> > new file mode 100644
> > index 00000000000000..9c4f3ae7a6cf3c
> > --- /dev/null
> > +++ b/example/service_hl.c
> > @@ -0,0 +1,224 @@
> > +/*
> > + * FUSE: Filesystem in Userspace
> > + * Copyright (C) 2026 Oracle.
> > + *
> > + * This program can be distributed under the terms of the GNU GPLv2.
> > + * See the file GPL2.txt.
> > + */
> > +
> > +/** @file
> > + *
> > + * minimal example filesystem using high-level API and systemd service api
> > + *
> > + * Compile with:
> > + *
> > + *     gcc -Wall single_file.c service_hl.c `pkg-config fuse3 --cflags --libs` -o service_hl
> > + *
> > + * Note: If the pkg-config command fails due to the absence of the fuse3.pc
> > + *     file, you should configure the path to the fuse3.pc file in the
> > + *     PKG_CONFIG_PATH variable.
> > + *
> > + * Change the ExecStart line in service_hl@.service:
> > + *
> > + *     ExecStart=/path/to/service_hl
> > + *
> > + * to point to the actual path of the service_hl binary.
> > + *
> > + * Finally, install the service_hl@.service and service_hl.socket files to the
> > + * systemd service directory, usually /run/systemd/system.
> > + *
> > + * ## Source code ##
> > + * \include service_hl.c
> > + * \include service_hl.socket
> > + * \include service_hl@.service
> > + * \include single_file.c
> > + * \include single_file.h
> > + */
> > +
> > +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 19)
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include <fuse.h>
> > +#include <fuse_service.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <assert.h>
> > +#include <pthread.h>
> > +#include <stddef.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/stat.h>
> > +#include <linux/fs.h>
> > +#include <linux/stat.h>
> > +#define USE_SINGLE_FILE_HL_API
> > +#include "single_file.h"
> > +
> > +struct service_hl {
> > +	char *device;
> > +	struct fuse_service *service;
> > +
> > +	/* really booleans */
> > +	int debug;
> > +};
> > +
> > +static struct service_hl hl = { };
> > +
> > +static void *service_hl_init(struct fuse_conn_info *conn,
> > +			struct fuse_config *cfg)
> > +{
> > +	(void) conn;
> > +	cfg->kernel_cache = 1;
> > +
> > +	return NULL;
> > +}
> > +
> > +static int service_hl_read(const char *path, char *buf, size_t count,
> > +			   off_t pos, struct fuse_file_info *fi)
> > +{
> > +	if (!is_single_open_file_path(fi, path))
> > +		return -EIO;
> > +
> > +	if (hl.debug)
> > +		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
> > +			__func__,
> > +			(unsigned long long)pos,
> > +			(unsigned long long)count);
> > +
> > +	if (!single_file.allow_dio && fi->direct_io)
> > +		return -ENOSYS;
> > +
> > +	single_file_check_read(pos, &count);
> > +
> > +	if (!count)
> > +		return 0;
> > +
> > +	return single_file_pread(buf, count, pos);
> > +}
> > +
> > +static int service_hl_write(const char *path, const char *buf, size_t count,
> > +			    off_t pos, struct fuse_file_info *fi)
> > +{
> > +	int ret;
> > +
> > +	if (!is_single_open_file_path(fi, path))
> > +		return -EIO;
> > +
> > +	if (hl.debug)
> > +		fprintf(stderr, "%s: pos 0x%llx count 0x%llx\n",
> > +			__func__,
> > +			(unsigned long long)pos,
> > +			(unsigned long long)count);
> > +
> > +	if (!single_file.allow_dio && fi->direct_io)
> > +		return -ENOSYS;
> > +
> > +	ret = single_file_check_write(pos, &count);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!count)
> > +		return 0;
> > +
> > +	return single_file_pwrite(buf, count, pos);
> > +}
> > +
> > +static const struct fuse_operations service_hl_oper = {
> > +	.getattr	= single_file_hl_getattr,
> > +	.readdir	= single_file_hl_readdir,
> > +	.open		= single_file_hl_open,
> > +	.opendir	= single_file_hl_opendir,
> > +	.statfs		= single_file_hl_statfs,
> > +	.chmod		= single_file_hl_chmod,
> > +	.utimens	= single_file_hl_utimens,
> > +	.fsync		= single_file_hl_fsync,
> > +	.chown		= single_file_hl_chown,
> > +	.truncate	= single_file_hl_truncate,
> > +	.statx		= single_file_hl_statx,
> > +
> > +	.init		= service_hl_init,
> > +	.read		= service_hl_read,
> > +	.write		= service_hl_write,
> > +};
> > +
> > +#define SERVICE_HL_OPT(t, p, v) { t, offsetof(struct service_hl, p), v }
> > +
> > +static struct fuse_opt service_hl_opts[] = {
> > +	SERVICE_HL_OPT("debug",		debug,			1),
> > +	SINGLE_FILE_OPT_KEYS,
> > +	FUSE_OPT_END
> > +};
> > +
> > +static int service_hl_opt_proc(void *data, const char *arg, int key,
> > +			       struct fuse_args *outargs)
> > +{
> > +	int ret = single_file_opt_proc(data, arg, key, outargs);
> > +
> > +	if (ret < 1)
> > +		return ret;
> > +
> > +	switch (key) {
> > +	case FUSE_OPT_KEY_NONOPT:
> > +		if (!hl.device) {
> > +			hl.device = strdup(arg);
> > +			return 0;
> > +		}
> > +		return 1;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
> > +	int ret = 1;
> > +
> > +	if (fuse_service_accept(&hl.service))
> > +		goto err_args;
> > +
> > +	if (!fuse_service_accepted(hl.service))
> > +		goto err_args;
> > +
> > +	if (fuse_service_append_args(hl.service, &args))
> > +		goto err_service;
> > +
> > +	if (fuse_opt_parse(&args, &hl, service_hl_opts, service_hl_opt_proc))
> > +		goto err_service;
> > +
> > +	if (!hl.device) {
> > +		printf("usage: %s [options] <device> <mountpoint>\n", argv[0]);
> > +		printf("       %s --help\n", argv[0]);
> > +		goto err_service;
> > +	}
> > +
> > +	if (single_file_service_open(hl.service, hl.device))
> > +		goto err_service;
> > +
> > +	if (fuse_service_finish_file_requests(hl.service))
> > +		goto err_singlefile;
> > +
> > +	if (single_file_configure(hl.device, NULL))
> > +		goto err_singlefile;
> > +
> > +	fuse_service_expect_mount_format(hl.service, S_IFDIR);
> > +
> > +	ret = fuse_service_main(hl.service, &args, &service_hl_oper, NULL);
> > +
> > +err_singlefile:
> > +	single_file_close();
> > +err_service:
> > +	free(hl.device);
> > +	fuse_service_send_goodbye(hl.service, ret);
> > +	fuse_service_destroy(&hl.service);
> > +err_args:
> > +	fuse_opt_free_args(&args);
> > +	return fuse_service_exit(ret);
> > +}
> > diff --git a/example/service_hl.socket.in b/example/service_hl.socket.in
> > new file mode 100644
> > index 00000000000000..46035d6c315b8d
> > --- /dev/null
> > +++ b/example/service_hl.socket.in
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Oracle.  All Rights Reserved.
> > +# Author: Darrick J. Wong <djwong@kernel.org>
> > +[Unit]
> > +Description=Socket for service_hl Service
> > +
> > +[Socket]
> > +ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/service_hl
> > +Accept=yes
> > +SocketMode=@FUSE_SERVICE_SOCKET_PERMS@
> > +RemoveOnStop=yes
> > +
> > +[Install]
> > +WantedBy=sockets.target
> > diff --git a/example/service_hl@.service b/example/service_hl@.service
> > new file mode 100644
> > index 00000000000000..883b9c649cbc90
> > --- /dev/null
> > +++ b/example/service_hl@.service
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Oracle.  All Rights Reserved.
> > +# Author: Darrick J. Wong <djwong@kernel.org>
> > +[Unit]
> > +Description=service_hl Sample Fuse Service
> > +
> > +# Don't leave failed units behind, systemd does not clean them up!
> > +CollectMode=inactive-or-failed
> > +
> > +[Service]
> > +Type=exec
> > +ExecStart=/path/to/service_hl
> > +
> > +# Try to capture core dumps
> > +LimitCORE=infinity
> > +
> > +SyslogIdentifier=%N
> > +
> > +# No realtime CPU scheduling
> > +RestrictRealtime=true
> > +
> > +# Don't let us see anything in the regular system, and don't run as root
> > +DynamicUser=true
> > +ProtectSystem=strict
> > +ProtectHome=true
> > +PrivateTmp=true
> > +PrivateDevices=true
> > +PrivateUsers=true
> > +
> > +# No network access
> > +PrivateNetwork=true
> > +ProtectHostname=true
> > +RestrictAddressFamilies=none
> > +IPAddressDeny=any
> > +
> > +# Don't let the program mess with the kernel configuration at all
> > +ProtectKernelLogs=true
> > +ProtectKernelModules=true
> > +ProtectKernelTunables=true
> > +ProtectControlGroups=true
> > +ProtectProc=invisible
> > +RestrictNamespaces=true
> > +RestrictFileSystems=
> > +
> > +# Hide everything in /proc, even /proc/mounts
> > +ProcSubset=pid
> > +
> > +# Only allow the default personality Linux
> > +LockPersonality=true
> > +
> > +# No writable memory pages
> > +MemoryDenyWriteExecute=true
> > +
> > +# Don't let our mounts leak out to the host
> > +PrivateMounts=true
> > +
> > +# Restrict system calls to the native arch and only enough to get things going
> > +SystemCallArchitectures=native
> > +SystemCallFilter=@system-service
> > +SystemCallFilter=~@privileged
> > +SystemCallFilter=~@resources
> > +
> > +SystemCallFilter=~@clock
> > +SystemCallFilter=~@cpu-emulation
> > +SystemCallFilter=~@debug
> > +SystemCallFilter=~@module
> > +SystemCallFilter=~@reboot
> > +SystemCallFilter=~@swap
> > +
> > +SystemCallFilter=~@mount
> > +
> > +# libfuse io_uring wants to pin cores and memory
> > +SystemCallFilter=mbind
> > +SystemCallFilter=sched_setaffinity
> > +
> > +# Leave a breadcrumb if we get whacked by the system call filter
> > +SystemCallErrorNumber=EL3RST
> > +
> > +# Log to the kernel dmesg, just like an in-kernel filesystem driver
> > +StandardOutput=append:/dev/ttyprintk
> > +StandardError=append:/dev/ttyprintk
> > +
> > +# Run with no capabilities at all
> > +CapabilityBoundingSet=
> > +AmbientCapabilities=
> > +NoNewPrivileges=true
> > +
> > +# We don't create files
> > +UMask=7777
> > +
> > +# No access to hardware /dev files at all
> > +ProtectClock=true
> > +DevicePolicy=closed
> > +
> > +# Don't mess with set[ug]id anything.
> > +RestrictSUIDSGID=true
> > +
> > +# Don't let OOM kills of processes in this containment group kill the whole
> > +# service, because we don't want filesystem drivers to go down.
> > +OOMPolicy=continue
> > +OOMScoreAdjust=-1000
> > diff --git a/example/service_ll.c b/example/service_ll.c
> > index 704b0a89972501..8958a221e09a66 100644
> > --- a/example/service_ll.c
> > +++ b/example/service_ll.c
> > @@ -51,6 +51,7 @@
> >  #include <unistd.h>
> >  #include <assert.h>
> >  #include <pthread.h>
> > +#define USE_SINGLE_FILE_LL_API
> >  #include "single_file.h"
> >  
> >  struct service_ll {
> > diff --git a/example/single_file.c b/example/single_file.c
> > index 5ed1fb5a318a37..187cc397d26117 100644
> > --- a/example/single_file.c
> > +++ b/example/single_file.c
> > @@ -23,7 +23,10 @@
> >  #define FUSE_USE_VERSION (FUSE_MAKE_VERSION(3, 19))
> >  
> >  #include "fuse_lowlevel.h"
> > +#include "fuse.h"
> >  #include "fuse_service.h"
> > +#define USE_SINGLE_FILE_LL_API
> > +#define USE_SINGLE_FILE_HL_API
> >  #include "single_file.h"
> >  
> >  #define min(x, y) ((x) < (y) ? (x) : (y))
> > @@ -56,6 +59,23 @@ struct single_file single_file = {
> >  	.lock = PTHREAD_MUTEX_INITIALIZER,
> >  };
> >  
> > +static fuse_ino_t single_file_path_to_ino(const char *path)
> > +{
> > +	if (strcmp(path, "/") == 0)
> > +		return FUSE_ROOT_ID;
> > +	if (strcmp(path + 1, single_file_name) == 0)
> > +		return SINGLE_FILE_INO;
> > +	return 0;
> > +}
> > +
> > +static fuse_ino_t single_open_file_path_to_ino(const struct fuse_file_info *fi,
> > +					       const char *path)
> > +{
> > +	if (fi)
> > +		return fi->fh;
> > +	return single_file_path_to_ino(path);
> > +}
> > +
> >  static void dirbuf_add(fuse_req_t req, struct dirbuf *b, const char *name,
> >  		       fuse_ino_t ino)
> >  {
> > @@ -91,6 +111,13 @@ bool is_single_file_ino(fuse_ino_t ino)
> >  	return ino == SINGLE_FILE_INO;
> >  }
> >  
> > +bool is_single_open_file_path(const struct fuse_file_info *fi, const char *name)
> > +{
> > +	if (fi)
> > +		return is_single_file_ino(fi->fh);
> > +	return name[0] == '/' && strcmp(name + 1, single_file_name) == 0;
> > +}
> > +
> >  void single_file_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
> >  			    off_t off, struct fuse_file_info *fi)
> >  {
> > @@ -117,6 +144,37 @@ void single_file_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
> >  	free(b.p);
> >  }
> >  
> > +int single_file_hl_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> > +			   off_t offset, struct fuse_file_info *fi,
> > +			   enum fuse_readdir_flags flags)
> > +{
> > +	struct stat stbuf;
> > +	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
> > +
> > +	memset(&stbuf, 0, sizeof(stbuf));
> > +
> > +	(void) offset;
> > +	(void) flags;
> > +
> > +	switch (ino) {
> > +	case FUSE_ROOT_ID:
> > +		break;
> > +	case SINGLE_FILE_INO:
> > +		return -ENOTDIR;
> > +	default:
> > +		return -ENOENT;
> > +	}
> > +
> > +	stbuf.st_ino = FUSE_ROOT_ID;
> > +	filler(buf, ".", &stbuf, 0, FUSE_FILL_DIR_DEFAULTS);
> > +	filler(buf, "..", &stbuf, 0, FUSE_FILL_DIR_DEFAULTS);
> > +
> > +	stbuf.st_ino = SINGLE_FILE_INO;
> > +	filler(buf, single_file_name, &stbuf, 0, FUSE_FILL_DIR_DEFAULTS);
> > +
> > +	return 0;
> > +}
> > +
> >  static bool sf_stat(fuse_ino_t ino, struct single_file_stat *llstat)
> >  {
> >  	struct fuse_entry_param *entry = &llstat->entry;
> > @@ -235,40 +293,74 @@ void single_file_ll_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
> >  	else
> >  		fuse_reply_statx(req, 0, &stx, 0.0);
> >  }
> > +
> > +int single_file_hl_statx(const char *path, int statx_flags, int statx_mask,
> > +			 struct statx *stx, struct fuse_file_info *fi)
> > +{
> 
> bschubert2@imesrv6 build>ninja
> [55/102] Compiling C object example/service_ll.p/single_file.c.o
> ../example/single_file.c:297:48: warning: unused parameter 'statx_flags'
> [-Wunused-parameter]
>   297 | int single_file_hl_statx(const char *path, int statx_flags, int
> statx_mask,
>       |                                                ^
> 1 warning generated.
> [56/102] Compiling C object example/service_hl.p/single_file.c.o
> ../example/single_file.c:297:48: warning: unused parameter 'statx_flags'
> [-Wunused-parameter]
>   297 | int single_file_hl_statx(const char *path, int statx_flags, int
> statx_mask,
>       |                                                ^
> 1 warning generated.
> [102/102] Linking target example/passthrough_hp
> 
> And CI tests run with -Werror - fails here.

Ah, I forgot to (void)statx_flags here.  How about I make it do
something useful instead:

   if ((statx_flags & AT_STATX_FORCE_SYNC) && is_single_file_ino(ino) &&
       single_file.backing_fd >= 0) {
            int ret = fsync(single_file.backing_fd);

            if (ret)
                 return -errno;
   }

(both ll and hl versions)

Oh, bah, when I copied extra warnings CFLAGS from xfsprogs I neglected
to invert -Wno-unused-parameter, that's why we keep having these
exchanges.  Sorry about that. :(

--D

> > +	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
> > +	bool filled;
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +
> > +	pthread_mutex_lock(&single_file.lock);
> > +	filled = sf_statx(ino, statx_mask, stx);
> > +	pthread_mutex_unlock(&single_file.lock);
> > +
> > +	return filled ? 0 : -ENOENT;
> > +}
> >  #else
> >  void single_file_ll_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
> >  			  struct fuse_file_info *fi)
> >  {
> >  	fuse_reply_err(req, ENOSYS);
> >  }
> > +
> > +int single_file_hl_statx(const char *path, int statx_flags, int statx_mask,
> > +			 struct statx *stx, struct fuse_file_info *fi)
> > +{
> > +	return -ENOSYS;
> > +}
> >  #endif /* STATX_BASIC_STATS */
> >  
> > +static void single_file_statfs(struct statvfs *buf)
> > +{
> > +	pthread_mutex_lock(&single_file.lock);
> > +	buf->f_bsize = single_file.blocksize;
> > +	buf->f_frsize = 0;
> > +
> > +	buf->f_blocks = single_file.blocks;
> > +	buf->f_bfree = 0;
> > +	buf->f_bavail = 0;
> > +	buf->f_files = 1;
> > +	buf->f_ffree = 0;
> > +	buf->f_favail = 0;
> > +	buf->f_fsid = 0x50C00L;
> > +	buf->f_flag = 0;
> > +	if (single_file.ro)
> > +		buf->f_flag |= ST_RDONLY;
> > +	buf->f_namemax = 255;
> > +	pthread_mutex_unlock(&single_file.lock);
> > +}
> > +
> >  void single_file_ll_statfs(fuse_req_t req, fuse_ino_t ino)
> >  {
> >  	struct statvfs buf;
> >  
> >  	(void)ino;
> >  
> > -	pthread_mutex_lock(&single_file.lock);
> > -	buf.f_bsize = single_file.blocksize;
> > -	buf.f_frsize = 0;
> > -
> > -	buf.f_blocks = single_file.blocks;
> > -	buf.f_bfree = 0;
> > -	buf.f_bavail = 0;
> > -	buf.f_files = 1;
> > -	buf.f_ffree = 0;
> > -	buf.f_favail = 0;
> > -	buf.f_fsid = 0x50C00L;
> > -	buf.f_flag = 0;
> > -	if (single_file.ro)
> > -		buf.f_flag |= ST_RDONLY;
> > -	buf.f_namemax = 255;
> > -	pthread_mutex_unlock(&single_file.lock);
> > -
> > +	single_file_statfs(&buf);
> >  	fuse_reply_statfs(req, &buf);
> >  }
> >  
> > +int single_file_hl_statfs(const char *path, struct statvfs *buf)
> > +{
> > +	(void)path;
> > +
> > +	single_file_statfs(buf);
> > +	return 0;
> > +}
> > +
> >  void single_file_ll_getattr(fuse_req_t req, fuse_ino_t ino,
> >  			    struct fuse_file_info *fi)
> >  {
> > @@ -288,6 +380,28 @@ void single_file_ll_getattr(fuse_req_t req, fuse_ino_t ino,
> >  				llstat.entry.attr_timeout);
> >  }
> >  
> > +int single_file_hl_getattr(const char *path, struct stat *stbuf,
> > +			   struct fuse_file_info *fi)
> > +{
> > +	struct single_file_stat llstat;
> > +	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
> > +	bool filled;
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +
> > +	memset(&llstat, 0, sizeof(llstat));
> > +	pthread_mutex_lock(&single_file.lock);
> > +	filled = sf_stat(ino, &llstat);
> > +	pthread_mutex_unlock(&single_file.lock);
> > +
> > +	if (!filled)
> > +		return -ENOENT;
> > +
> > +	memcpy(stbuf, &llstat.entry.attr, sizeof(*stbuf));
> > +	return 0;
> > +}
> > +
> >  static void get_now(struct timespec *now)
> >  {
> >  #ifdef CLOCK_REALTIME
> > @@ -342,6 +456,81 @@ void single_file_ll_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
> >  	fuse_reply_err(req, EPERM);
> >  }
> >  
> > +int single_file_hl_chmod(const char *path, mode_t mode,
> > +			 struct fuse_file_info *fi)
> > +{
> > +	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +	if (ino != SINGLE_FILE_INO)
> > +		return -EPERM;
> > +	if (single_file.ro)
> > +		return -EPERM;
> > +
> > +	pthread_mutex_lock(&single_file.lock);
> > +	single_file.mode = (single_file.mode & S_IFMT) | (mode & ~S_IFMT);
> > +	pthread_mutex_unlock(&single_file.lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void set_time(const struct timespec *ctv, struct timespec *tv)
> > +{
> > +	switch (ctv->tv_nsec) {
> > +	case UTIME_OMIT:
> > +		return;
> > +	case UTIME_NOW:
> > +		get_now(tv);
> > +		break;
> > +	default:
> > +		memcpy(tv, ctv, sizeof(*tv));
> > +		break;
> > +	}
> > +}
> > +
> > +int single_file_hl_utimens(const char *path, const struct timespec ctv[2],
> > +			   struct fuse_file_info *fi)
> > +{
> > +	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +	if (ino != SINGLE_FILE_INO)
> > +		return -EPERM;
> > +	if (single_file.ro)
> > +		return -EPERM;
> > +
> > +	pthread_mutex_lock(&single_file.lock);
> > +	set_time(&ctv[0], &single_file.atime);
> > +	set_time(&ctv[1], &single_file.mtime);
> > +	get_now(&single_file.ctime);
> > +	pthread_mutex_unlock(&single_file.lock);
> > +
> > +	return 0;
> > +}
> > +
> > +int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
> > +			 struct fuse_file_info *fi)
> > +{
> > +	(void)path;
> > +	(void)owner;
> > +	(void)group;
> > +	(void)fi;
> > +
> > +	return -EPERM;
> > +}
> > +
> > +int single_file_hl_truncate(const char *path, off_t len,
> > +			    struct fuse_file_info *fi)
> > +{
> > +	(void)path;
> > +	(void)len;
> > +	(void)fi;
> > +
> > +	return -EPERM;
> > +}
> > +
> >  void single_file_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
> >  {
> >  	struct single_file_stat llstat;
> > @@ -373,6 +562,34 @@ void single_file_ll_open(fuse_req_t req, fuse_ino_t ino,
> >  		fuse_reply_open(req, fi);
> >  }
> >  
> > +int single_file_hl_opendir(const char *path, struct fuse_file_info *fi)
> > +{
> > +	fuse_ino_t ino = single_file_path_to_ino(path);
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +	if (ino == SINGLE_FILE_INO)
> > +		return -ENOTDIR;
> > +
> > +	fi->fh = ino;
> > +	return 0;
> > +}
> > +
> > +int single_file_hl_open(const char *path, struct fuse_file_info *fi)
> > +{
> > +	fuse_ino_t ino = single_file_path_to_ino(path);
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +	if (ino != SINGLE_FILE_INO)
> > +		return -EISDIR;
> > +	if (single_file.ro && (fi->flags & O_ACCMODE) != O_RDONLY)
> > +		return -EROFS;
> > +
> > +	fi->fh = ino;
> > +	return 0;
> > +}
> > +
> >  void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
> >  			  struct fuse_file_info *fi)
> >  {
> > @@ -390,6 +607,26 @@ void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
> >  	fuse_reply_err(req, ret);
> >  }
> >  
> > +int single_file_hl_fsync(const char *path, int datasync,
> > +			 struct fuse_file_info *fi)
> > +{
> > +	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
> > +
> > +	(void)datasync;
> > +
> > +	if (!ino)
> > +		return -ENOENT;
> > +
> > +	if (ino == SINGLE_FILE_INO) {
> > +		int ret = fsync(single_file.backing_fd);
> > +
> > +		if (ret)
> > +			return -errno;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  unsigned long long parse_num_blocks(const char *arg, int log_block_size)
> >  {
> >  	char *p;
> > 
> > 
> 
> 
