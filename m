Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1023A16A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906642; cv=none; b=HPOO/Ck6xSeIsILEw76WC4UxDSRQrAkIzJscBSCvba55TejCEcUyZwm8uFb18yvWi/F0CLgHxhmfd3u7tI47b1my0YLjNGkuh9nmnvAPBwi29HM7R0IfE/8fOgwyM/pLBGiliSw8M7WhYWnSgoXkR9Du6ZA/qtYX7yCwwpcooSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906642; c=relaxed/simple;
	bh=4BRCrdXkFyC8UygvBG14XWTmXDX7YhKzkladihcjmMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msra1JfguupICBY+nYTsCIUG0LfwmX/5Nm9nFUKaickf0HYv1UcBzFyXgzsELzk2nklLac7RI9SaGk7pjphe3e81LejHIkCFtTVUbgFrxKBYjJqfHBD5GXWoCB6YGQzHBMj4GGl+FeZPpwQtNGJ1HLaUBqBbGOCliHY5a2kqFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGxJMx/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGxJMx/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AAFC4CEF7;
	Mon, 30 Mar 2026 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774906642;
	bh=4BRCrdXkFyC8UygvBG14XWTmXDX7YhKzkladihcjmMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGxJMx/3l/Nw4/p7+3C15AFNt+1Q268WWA1gQuK8dVYY3uyLS+wdHRbAh/NFRKnNz
	 Fuc5g8fxEZvakC+/ltXlM70vpv/mUls+rOLBueZoAqn2K31BLkG58rP02u1ZQVkShW
	 tXr7ctht8GTOo0HuWhx5NmB7+d+d6hLXr5aWCcuP7IKxEJTsXgPZFpv4/wFCpI4/mS
	 TkxhcAeT2zQaaHmhQH2zN5JwanklTbp8dagwXFX7ip3hplsHf+Wuk0PwXw/DbLAlea
	 jkJBiUCoaHRD7aiImDTrWvMzIi/0v4fcMdnH79PCeUsn99Pya2sLXXJGaikZjCBNiA
	 c/U6I/MwM3Xzw==
Date: Mon, 30 Mar 2026 14:37:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>
Subject: Re: [PATCH 02/17] mount_service: add systemd/inetd socket service
 mounting helper
Message-ID: <20260330213721.GG6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463153.1008428.10871096687728734372.stgit@frogsfrogsfrogs>
 <508e2a84-fe5e-4254-b4ce-ff6b400f5dc3@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508e2a84-fe5e-4254-b4ce-ff6b400f5dc3@ddn.com>

On Mon, Mar 30, 2026 at 08:44:21PM +0000, Bernd Schubert wrote:
> On 3/27/26 02:25, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a mount helper program that can start a fuse server that runs as
> > a socket-based systemd service, and a new libfuse module to wrap all the
> > details of communicating between the mount helper and the containerized
> > fuse server.
> > 
> > This enables untrusted ext4 mounts via systemd service containers, which
> > avoids the problem of malicious filesystems compromising the integrity
> > of the running kernel through memory corruption.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse_service.h                      |  215 +++++
> >  include/fuse_service_priv.h                 |  127 +++
> >  lib/mount_common_i.h                        |    3 
> >  util/mount_service.h                        |   32 +
> >  .github/workflows/abicheck.yml              |    2 
> >  .github/workflows/abicheck_prev_release.yml |    2 
> >  .github/workflows/pr-ci.yml                 |    2 
> >  doc/fuservicemount3.8                       |   24 +
> >  doc/meson.build                             |    3 
> >  include/meson.build                         |    4 
> >  lib/fuse_service.c                          |  989 +++++++++++++++++++++++++
> >  lib/fuse_service_stub.c                     |   96 ++
> >  lib/fuse_versionscript                      |   16 
> >  lib/helper.c                                |   53 +
> >  lib/meson.build                             |   16 
> >  lib/mount.c                                 |   12 
> >  meson.build                                 |   29 +
> >  meson_options.txt                           |    6 
> >  util/fuservicemount.c                       |   18 
> >  util/meson.build                            |    9 
> >  util/mount_service.c                        | 1088 +++++++++++++++++++++++++++
> >  21 files changed, 2741 insertions(+), 5 deletions(-)
> >  create mode 100644 include/fuse_service.h
> >  create mode 100644 include/fuse_service_priv.h
> >  create mode 100644 util/mount_service.h
> >  create mode 100644 doc/fuservicemount3.8
> >  create mode 100644 lib/fuse_service.c
> >  create mode 100644 lib/fuse_service_stub.c
> >  create mode 100644 util/fuservicemount.c
> >  create mode 100644 util/mount_service.c
> > 
> > 
> > diff --git a/include/fuse_service.h b/include/fuse_service.h
> > new file mode 100644
> > index 00000000000000..f0a4e63b2f11a7
> > --- /dev/null
> > +++ b/include/fuse_service.h
> > @@ -0,0 +1,215 @@
> > +/*
> > + * FUSE: Filesystem in Userspace
> > + * Copyright (C) 2025-2026 Oracle.
> > + * Author: Darrick J. Wong <djwong@kernel.org>
> > + *
> > + * This program can be distributed under the terms of the GNU LGPLv2.
> > + * See the file LGPL2.txt.
> > + */
> > +#ifndef FUSE_SERVICE_H_
> > +#define FUSE_SERVICE_H_
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
> > +
> > +struct fuse_service;
> > +
> > +/**
> > + * Accept a socket created by mount.service for information exchange.
> > + *
> > + * @param sfp pointer to pointer to a service context.  The pointer will always
> > + *            be initialized by this function; use fuse_service_accepted to
> > + *            find out if the fuse server is actually running as a service.
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_accept(struct fuse_service **sfp);
> > +
> > +/**
> > + * Has the fuse server accepted a service context?
> > + *
> > + * @param sf service context
> > + * @return true if it has, false if not
> > + */
> > +static inline bool fuse_service_accepted(struct fuse_service *sf)
> > +{
> > +	return sf != NULL;
> > +}
> > +
> > +/**
> > + * Will the mount service helper accept the allow_other option?
> > + *
> > + * @param sf service context
> > + * @return true if it has, false if not
> > + */
> > +bool fuse_service_can_allow_other(struct fuse_service *sf);
> > +
> > +/**
> > + * Release all resources associated with the service context.
> > + *
> > + * @param sfp service context
> > + */
> > +void fuse_service_release(struct fuse_service *sf);
> > +
> > +/**
> > + * Destroy a service context and release all resources
> > + *
> > + * @param sfp pointer to pointer to a service context
> > + */
> > +void fuse_service_destroy(struct fuse_service **sfp);
> > +
> > +/**
> > + * Append the command line arguments from the mount service helper to an
> > + * existing fuse_args structure.  The fuse_args should have been initialized
> > + * with the argc and argv passed to main().
> > + *
> > + * @param sfp service context
> > + * @param args arguments to modify (input+output)
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_append_args(struct fuse_service *sf, struct fuse_args *args);
> > +
> > +/**
> > + * Generate the effective fuse server command line from the args structure.
> > + * The args structure should be the outcome from fuse_service_append_args.
> > + * The resulting string is suitable for setproctitle and must be freed by the
> > + * callre.
> > + *
> > + * @param argc argument count passed to main()
> > + * @param argv argument vector passed to main()
> > + * @param args fuse args structure
> > + * @return effective command line string, or NULL
> > + */
> > +char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args);
> > +
> > +struct fuse_cmdline_opts;
> > +
> > +/**
> > + * Utility function to parse common options for simple file systems
> > + * using the low-level API. A help text that describes the available
> > + * options can be printed with `fuse_cmdline_help`. A single
> > + * non-option argument is treated as the mountpoint. Multiple
> > + * non-option arguments will result in an error.
> > + *
> > + * If neither -o subtype= or -o fsname= options are given, a new
> > + * subtype option will be added and set to the basename of the program
> > + * (the fsname will remain unset, and then defaults to "fuse").
> > + *
> > + * Known options will be removed from *args*, unknown options will
> > + * remain. The mountpoint will not be checked here; that is the job of
> > + * mount.service.
> > + *
> > + * @param args argument vector (input+output)
> > + * @param opts output argument for parsed options
> > + * @return 0 on success, -1 on failure
> > + */
> > +int fuse_service_parse_cmdline_opts(struct fuse_args *args,
> > +				    struct fuse_cmdline_opts *opts);
> > +
> > +/**
> > + * Ask the mount.service helper to open a file on behalf of the fuse server.
> > + *
> > + * @param sf service context
> > + * @param path the path to file
> > + * @param open_flags O_ flags
> > + * @param create_mode mode with which to create the file
> > + * @param request_flags set of FUSE_SERVICE_REQUEST_* flags
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_request_file(struct fuse_service *sf, const char *path,
> > +			      int open_flags, mode_t create_mode,
> > +			      unsigned int request_flags);
> > +
> > +/**
> > + * Ask the mount.service helper to open a block device on behalf of the fuse
> > + * server.
> > + *
> > + * @param sf service context
> > + * @param path the path to file
> > + * @param open_flags O_ flags
> > + * @param create_mode mode with which to create the file
> > + * @param request_flags set of FUSE_SERVICE_REQUEST_* flags
> > + * @param block_size set the block device block size to this value
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
> > +				  int open_flags, mode_t create_mode,
> > +				  unsigned int request_flags,
> > +				  unsigned int block_size);
> > +
> > +/**
> > + * Receive a file previously requested.
> > + *
> > + * @param sf service context
> > + * @param path to file
> > + * @fdp pointer to file descriptor, which will be set a non-negative file
> > + *      descriptor value on success, or negative errno on failure
> > + * @return 0 on success, or negative errno on socket communication failure
> > + */
> > +int fuse_service_receive_file(struct fuse_service *sf,
> > +			      const char *path, int *fdp);
> > +
> > +/**
> > + * Prevent the mount.service server from sending us any more open files.
> > + *
> > + * @param sf service context
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_finish_file_requests(struct fuse_service *sf);
> > +
> > +/**
> > + * Require that the filesystem mount point have the expected file format
> > + * (S_IFDIR/S_IFREG).  Can be overridden when calling
> > + * fuse_service_session_mount.
> > + *
> > + * @param sf service context
> > + * @param expected_fmt expected mode (S_IFDIR/S_IFREG) for mount point, or 0
> > + *                     to skip checks
> > + */
> > +void fuse_service_expect_mount_mode(struct fuse_service *sf,
> > +				    mode_t expected_fmt);
> > +
> > +/**
> > + * Bind a FUSE file system to the fuse session inside a fuse service process,
> > + * then ask the mount.service helper to mount the filesystem for us.  The fuse
> > + * client will begin sending requests to the fuse server immediately after
> > + * this.
> > + *
> > + * @param sf service context
> > + * @param se fuse session
> > + * @param expected_fmt expected mode (S_IFDIR/S_IFREG) for mount point, or 0
> > + *                     to skip checks
> > + * @param opts command line options
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
> > +			       mode_t expected_fmt,
> > +			       struct fuse_cmdline_opts *opts);
> > +
> > +/**
> > + * Bid farewell to the mount.service helper.  It is still necessary to call
> > + * fuse_service_destroy after this.
> > + *
> > + * @param sf service context
> > + * @param exitcode fuse server process exit status
> > + * @return 0 on success, or negative errno on failure
> > + */
> > +int fuse_service_send_goodbye(struct fuse_service *sf, int exitcode);
> > +
> > +/**
> > + * Exit routine for a fuse server running as a systemd service.
> > + *
> > + * @param ret 0 for success, nonzero for service failure.
> > + * @return a value to be passed to exit() or returned from main
> > + */
> > +int fuse_service_exit(int ret);
> > +
> > +#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +#endif /* FUSE_SERVICE_H_ */
> > diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
> > new file mode 100644
> > index 00000000000000..d1fdd6221b5268
> > --- /dev/null
> > +++ b/include/fuse_service_priv.h
> > @@ -0,0 +1,127 @@
> > +/*
> > + * FUSE: Filesystem in Userspace
> > + * Copyright (C) 2025-2026 Oracle.
> > + * Author: Darrick J. Wong <djwong@kernel.org>
> > + *
> > + * This program can be distributed under the terms of the GNU LGPLv2.
> > + * See the file LGPL2.txt.
> > + */
> > +#ifndef FUSE_SERVICE_PRIV_H_
> > +#define FUSE_SERVICE_PRIV_H_
> > +
> > +/* All numeric fields are network order (big-endian) when going across the socket */
> > +
> > +struct fuse_service_memfd_arg {
> > +	uint32_t pos;
> > +	uint32_t len;
> > +};
> > +
> > +struct fuse_service_memfd_argv {
> > +	uint32_t magic;
> > +	uint32_t argc;
> > +};
> > +
> > +#define FUSE_SERVICE_ARGS_MAGIC		0x41524753	/* ARGS */
> > +
> > +/* mount.service sends a hello to the server and it replies */
> > +#define FUSE_SERVICE_HELLO_CMD		0x53414654	/* SAFT */
> 
> What "SAFT" stand for? (The German meaning of the word is "juice" ;) ).

"SAFeTy", compressed.

--D

> 
> Thanks,
> Bernd
