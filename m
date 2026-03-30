Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD933BBC5
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895252; cv=none; b=ZS36VY22uF+dYVyB/Feo0qQixr5so/wQpIMXdp8iaZueQbTq2S/0TaLYn8gnUYa8JKN6tgIHH/eYjQboWY8ws4KhhWxO9Lzr8VX+T9KnaV7OH8RR3ONPuriWWbhsVYUlKge+atRR14nYxoL8/ylrotqOquVgQoIgW++XMmS4iUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895252; c=relaxed/simple;
	bh=AW5tiEsoYClNI3EOlJOKcbOMOOBfCvO0oEpyigjB1qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5LNnzjL3ClRKrZqc6wPOPOK173IU1EkESeLx4alhil9x0vSXvfsW7NyHbqA9rqu6F6wNP2WYyRNUy5SJ/k13pf7buBRy7GzcYpDlvf0mRgcdmR6FZFAtnxGkPkpmfQkeav2qs8ELUF9FhYUbRZKBUO4mkKi7gKuiEAu82fvdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5JsMVKu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5JsMVKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CB5C4CEF7;
	Mon, 30 Mar 2026 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774895252;
	bh=AW5tiEsoYClNI3EOlJOKcbOMOOBfCvO0oEpyigjB1qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5JsMVKuc9wlCjVvci22+9JokMpSZ6St7khOujG6NhXbMMuNJknz1/eRspymCjjHx
	 eralRMx1TOUnAu9FieREMfav03PxlNWthAcXiNHf8zJsdKfHQTxNRtHtnLeKzRSAmx
	 OQ6OyoMfesuUrsWNLMCNWKGkHVQxGvvnXm1ii0sRAQsvLhaVIRfIqIaXA2MqetJov8
	 S6Jsr3s3czShHvUyMhzqfJFDkO7dZFVZPvp2hKTa+SDX438Ux9avIP4i3R7NjJW2kk
	 QUuV3f1zBLpJ8FgXajTKu0meRbtxVUmI9qq9897ZipYXEhqV3TnKyGfR9QfXW/Uu9y
	 wjoRgU0y4wVzw==
Date: Mon, 30 Mar 2026 11:27:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 13/25] Add support for the new linux mount API
Message-ID: <20260330182731.GW6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-13-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-13-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:46PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> So far only supported for fuse_session_mount(), which is called
> from high and low level API, but not yet supported for
> fuse_open_channel(), which used for privilege drop through
> mount.fuse. Main goal for the new API is support for synchronous
> FUSE_INIT and I don't think that is going to work with
> fuse_open_channel(). At least not with io-uring support as long
> as it is started from FUSE_INIT.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  lib/fuse_lowlevel.c |  74 ++++++++-
>  lib/meson.build     |   3 +
>  lib/mount.c         |  27 +++-
>  lib/mount_fsmount.c | 454 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/mount_i_linux.h |  14 ++
>  meson.build         |  19 ++-
>  6 files changed, 583 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index ccff6a768f0b8c32469abda9405ff29623f3fff7..a7be40cbb012361ad664a9ced3d38042ba52c681 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -20,6 +20,9 @@
>  #include "util.h"
>  #include "fuse_uring_i.h"
>  #include "fuse_daemonize.h"
> +#if defined(__linux__)
> +#include "mount_i_linux.h"
> +#endif
>  
>  #include <pthread.h>
>  #include <stdatomic.h>
> @@ -4398,6 +4401,63 @@ int fuse_session_custom_io_30(struct fuse_session *se,
>  			offsetof(struct fuse_custom_io, clone_fd), fd);
>  }
>  
> +#if defined(HAVE_NEW_MOUNT_API)
> +static int fuse_session_mount_new_api(struct fuse_session *se,
> +				      const char *mountpoint)
> +{
> +	int fd = -1;
> +	int res, err;
> +	char *mnt_opts = NULL;
> +	char *mnt_opts_with_fd = NULL;
> +	char fd_opt[32];
> +
> +	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
> +	err = -EIO;
> +	if (res == -1) {
> +		fuse_log(FUSE_LOG_ERR,
> +			 "fuse: failed to get base mount options\n");
> +		goto err;
> +	}
> +
> +	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
> +	if (fd == -1) {
> +		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
> +		err = -EIO;
> +		goto err;
> +	}
> +
> +	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
> +	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
> +	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
> +		err = -ENOMEM;
> +		goto err;
> +	}
> +
> +	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
> +err:
> +	if (err) {
> +		if (fd >= 0)
> +			close(fd);
> +		fd = -1;
> +		se->fd = -1;
> +		se->error = -errno;
> +	}
> +
> +	free(mnt_opts);
> +	free(mnt_opts_with_fd);
> +	return fd;
> +}
> +#else
> +static int fuse_session_mount_new_api(struct fuse_session *se,
> +				      const char *mountpoint)
> +{
> +	(void)se;
> +	(void)mountpoint;
> +
> +	return -1;
> +}
> +#endif
> +
>  int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>  {
>  	int fd;
> @@ -4425,6 +4485,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>  			close(fd);
>  	} while (fd >= 0 && fd <= 2);
>  
> +	/* Open channel */
> +
>  	/*
>  	 * To allow FUSE daemons to run without privileges, the caller may open
>  	 * /dev/fuse before launching the file system and pass on the file
> @@ -4443,10 +4505,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>  		return 0;
>  	}
>  
> -	/* Open channel */
> +	/* new linux mount api */
> +	fd = fuse_session_mount_new_api(se, mountpoint);
> +	if (fd >= 0)
> +		goto out;
> +
> +	/* fall back to old API */
> +	se->error = 0; /* reset error of new api */
>  	fd = fuse_kern_mount(mountpoint, se->mo);
> -	if (fd == -1)
> +	if (fd < 0)
>  		goto error_out;
> +
> +out:
>  	se->fd = fd;
>  
>  	/* Save mountpoint */
> diff --git a/lib/meson.build b/lib/meson.build
> index 5bd449ebffe7c9229df904d647d990c6c47f80b5..5fd738a589c5aba97a738d5eedbf0f9962e4adfc 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -7,6 +7,9 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
>  
>  if host_machine.system().startswith('linux')
>     libfuse_sources += [ 'mount.c' ]
> +   if private_cfg.get('HAVE_NEW_MOUNT_API', false)
> +      libfuse_sources += [ 'mount_fsmount.c' ]
> +   endif
>  else
>     libfuse_sources += [ 'mount_bsd.c' ]
>  endif
> diff --git a/lib/mount.c b/lib/mount.c
> index 43920a06ac03747595bde95441252e9cac77ce88..e8c65363d36a56f483f82434f642e785da4d0341 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -442,8 +442,8 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>  #define O_CLOEXEC 0
>  #endif
>  
> -static int fuse_kern_mount_prepare(const char *mnt,
> -				   struct mount_opts *mo)
> +int fuse_kern_mount_prepare(const char *mnt,
> +			    struct mount_opts *mo)
>  {
>  	char tmp[128];
>  	const char *devname = fuse_mnt_get_devname();
> @@ -493,6 +493,26 @@ out_close:
>  	return -1;
>  }
>  
> +#if defined(HAVE_NEW_MOUNT_API)
> +/**
> + * Wrapper for fuse_kern_fsmount that accepts struct mount_opts
> + * @mnt: mountpoint
> + * @mo: mount options
> + * @mnt_opts: mount options to pass to the kernel
> + *
> + * Returns: 0 on success, -1 on failure with errno set
> + */
> +int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
> +			 const char *mnt_opts)
> +{
> +	const char *devname = fuse_mnt_get_devname();
> +
> +	return fuse_kern_fsmount(mnt, mo->flags, mo->blkdev, mo->fsname,
> +				 mo->subtype, devname, mo->kernel_opts,
> +				 mnt_opts);
> +}
> +#endif
> +
>  /**
>   * Complete the mount operation with an already-opened fd
>   * @mnt: mountpoint
> @@ -636,8 +656,7 @@ void destroy_mount_opts(struct mount_opts *mo)
>  	free(mo);
>  }
>  
> -static int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo,
> -					     char **mnt_optsp)
> +int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp)
>  {
>  	if (get_mnt_flag_opts(mnt_optsp, mo->flags) == -1)
>  		return -1;
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fbe3647a8923828dba819458b815c21bbd2beaad
> --- /dev/null
> +++ b/lib/mount_fsmount.c
> @@ -0,0 +1,454 @@
> +/*
> + *  FUSE: Filesystem in Userspace
> + *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> + *                2026 Bernd Schubert <bernd@bsbernd.com>
> + *
> + * New Linux mount API (fsopen/fsconfig/fsmount/move_mount) support.
> + *
> + *  This program can be distributed under the terms of the GNU LGPLv2.
> + *  See the file LGPL2.txt.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "fuse_config.h"
> +#include "fuse_misc.h"
> +#include "mount_util.h"
> +#include "mount_i_linux.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sys/mount.h>
> +#include <sys/syscall.h>
> +
> +/*
> + * Mount attribute flags for fsmount() - from linux/mount.h
> + * This file is only compiled conditionally when support for the new
> + * mount API is detected - only flags that were not in the initial linux
> + * commit introducing that API are defined here.
> + */
> +#ifndef MOUNT_ATTR_NOSYMFOLLOW
> +#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
> +#endif
> +
> +/*
> + * Convert MS_* mount flags to MOUNT_ATTR_* mount attributes.
> + * These flags are passed to fsmount(), not fsconfig().
> + * Mount attributes control mount-point level behavior.
> + */
> +static unsigned long ms_flags_to_mount_attrs(unsigned long flags)
> +{
> +	unsigned long attrs = 0;
> +
> +	if (flags & MS_NOSUID)
> +		attrs |= MOUNT_ATTR_NOSUID;
> +	if (flags & MS_NODEV)
> +		attrs |= MOUNT_ATTR_NODEV;
> +	if (flags & MS_NOEXEC)
> +		attrs |= MOUNT_ATTR_NOEXEC;
> +	if (flags & MS_NOATIME)
> +		attrs |= MOUNT_ATTR_NOATIME;
> +	else if (flags & MS_RELATIME)
> +		attrs |= MOUNT_ATTR_RELATIME;
> +	else if (flags & MS_STRICTATIME)
> +		attrs |= MOUNT_ATTR_STRICTATIME;
> +	if (flags & MS_NODIRATIME)
> +		attrs |= MOUNT_ATTR_NODIRATIME;
> +	if (flags & MS_NOSYMFOLLOW)
> +		attrs |= MOUNT_ATTR_NOSYMFOLLOW;
> +
> +	return attrs;
> +}
> +
> +/*
> + * Read and print kernel error messages from fsopen fd.
> + * The kernel can provide detailed error/warning/info messages via the
> + * filesystem context fd that are more informative than strerror(errno).
> + */
> +static void log_fsconfig_kmsg(int fd)
> +{
> +	char buf[4096];
> +	int err, sz = 0;
> +
> +	err = errno;
> +
> +	while ((sz = read(fd, buf, sizeof(buf) - 1)) != -1) {
> +		if (sz <= 0)
> +			continue;
> +		if (buf[sz - 1] == '\n')
> +			buf[--sz] = '\0';
> +		else
> +			buf[sz] = '\0';
> +
> +		if (!*buf)
> +			continue;
> +
> +		switch (buf[0]) {
> +		case 'e':
> +			fprintf(stderr, " Error: %s\n", buf + 2);
> +			break;
> +		case 'w':
> +			fprintf(stderr, " Warning: %s\n", buf + 2);
> +			break;
> +		case 'i':
> +			fprintf(stderr, " Info: %s\n", buf + 2);
> +			break;
> +		default:
> +			fprintf(stderr, " %s\n", buf);
> +			break;
> +		}
> +	}
> +
> +	errno = err;
> +}
> +
> +/*
> + * Apply VFS superblock flags to the filesystem context.
> + * Only handles flags that are filesystem parameters (ro, sync, dirsync).
> + * Mount attributes (nosuid, nodev, etc.) are handled separately via fsmount().
> + */
> +static int apply_mount_flags(int fsfd, unsigned long flags)
> +{
> +	int res, save_errno;
> +
> +	/* Handle read-only flag */
> +	if (flags & MS_RDONLY) {
> +		const char *flag = "ro";
> +
> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
> +		if (res == -1) {
> +			save_errno = errno;
> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
> +			log_fsconfig_kmsg(fsfd);
> +			return -save_errno;
> +		}
> +	}
> +
> +	/* Handle sync flag */
> +	if (flags & MS_SYNCHRONOUS) {
> +		const char *flag = "sync";
> +
> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
> +		if (res == -1) {
> +			save_errno = errno;
> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
> +			log_fsconfig_kmsg(fsfd);
> +			return -save_errno;
> +		}
> +	}
> +
> +#ifndef __NetBSD__

This is always true, right?  Only Linux has fsmount.

> +	/* Handle dirsync flag */
> +	if (flags & MS_DIRSYNC) {
> +		const char *flag = "dirsync";
> +
> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
> +		if (res == -1) {
> +			save_errno = errno;
> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
> +			log_fsconfig_kmsg(fsfd);
> +			return -save_errno;
> +		}
> +	}
> +#endif
> +
> +	return 0;

I did this a bit differently:


static const struct ms_to_str_map strflags[] = {
	{ MS_SYNCHRONOUS,	"sync" },
	{ MS_DIRSYNC,		"dirsync" },
	{ MS_LAZYTIME,		"lazytime" },
	{ 0, 0 },
};

static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
{
	const struct ms_to_str_map *i;
	int ret;

	for (i = strflags; i->ms_flag != 0; i++) {
		if (!(ms_flags & i->ms_flag))
			continue;

		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
			       NULL, 0);
		if (ret) {
			int error = errno;

			fprintf(stderr, "%s: set %s option: %s\n",
				mo->msgtag, i->string, strerror(error));
			emit_fsconfig_messages(mo);

			errno = error;
			return -1;
		}
		ms_flags &= ~i->ms_flag;
	}

	/*
	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
	 * or string flags!  Return a magic code so the caller will fall back
	 * to regular mount(2).
	 */
	return ms_flags ? -2 : 0;
}

That way you can always fall back to classic mount() instead of quietly
dropping an MS_ flag here if one ever gets added without a corresponding
MOUNT_ATTR_ flag.  AFAICT there aren't any that *would* get dropped and
you can verify via code inspection, but why not avoid the logic bomb?

> +}
> +
> +static int apply_opt_fd(int fsfd, const char *value)
> +{
> +	int res, save_errno;
> +
> +	/* The fd parameter is a u32 value, not a file descriptor to pass */
> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "fd", value, 0);
> +	if (res == -1) {
> +		save_errno = errno;
> +		fprintf(stderr, "fuse: fsconfig SET_STRING fd=%s failed:",
> +			value);
> +		log_fsconfig_kmsg(fsfd);
> +		return -save_errno;
> +	}
> +	return 0;
> +}
> +
> +static int apply_opt_string(int fsfd, const char *key, const char *value)
> +{
> +	int res, save_errno;
> +
> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, key, value, 0);
> +	save_errno = errno;
> +	if (res == -1) {
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr, "fuse: fsconfig SET_STRING %s=%s failed: ",
> +			key, value);
> +		return -save_errno;

I think this function should call fprintf and log_fsconfig_kmsg in the
same order as the other two apply_opt_* functions.

> +	}
> +	return 0;
> +}
> +
> +static int apply_opt_flag(int fsfd, const char *opt)
> +{
> +	int res, save_errno;
> +
> +	res = fsconfig(fsfd, FSCONFIG_SET_FLAG, opt, NULL, 0);
> +	if (res == -1) {
> +		save_errno = errno;
> +		fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", opt);
> +		log_fsconfig_kmsg(fsfd);
> +		return -save_errno;
> +	}
> +	return 0;
> +}
> +
> +static int apply_opt_key_value(int fsfd, char *opt)
> +{
> +	char *eq;
> +	const char *key;
> +	const char *value;
> +
> +	eq = strchr(opt, '=');
> +	if (!eq)
> +		return apply_opt_flag(fsfd, opt);
> +
> +	*eq = '\0';
> +	key = opt;
> +	value = eq + 1;
> +
> +	if (strcmp(key, "fd") == 0)
> +		return apply_opt_fd(fsfd, value);
> +
> +	return apply_opt_string(fsfd, key, value);
> +}
> +
> +/**
> + * Check if an option is a mount attribute (handled by fsmount, not fsconfig)
> + */
> +static int is_mount_attr_opt(const char *opt)
> +{
> +	/* These options are mount attributes passed to fsmount(), not fsconfig() */
> +	return strcmp(opt, "nosuid") == 0 ||
> +	       strcmp(opt, "suid") == 0 ||
> +	       strcmp(opt, "nodev") == 0 ||
> +	       strcmp(opt, "dev") == 0 ||
> +	       strcmp(opt, "noexec") == 0 ||
> +	       strcmp(opt, "exec") == 0 ||
> +	       strcmp(opt, "noatime") == 0 ||
> +	       strcmp(opt, "atime") == 0 ||
> +	       strcmp(opt, "nodiratime") == 0 ||
> +	       strcmp(opt, "diratime") == 0 ||
> +	       strcmp(opt, "relatime") == 0 ||
> +	       strcmp(opt, "norelatime") == 0 ||
> +	       strcmp(opt, "strictatime") == 0 ||
> +	       strcmp(opt, "nostrictatime") == 0 ||
> +	       strcmp(opt, "nosymfollow") == 0 ||
> +	       strcmp(opt, "symfollow") == 0;

/me wonders if this should be walking the mount_flags array instead of
opencoding the strings here?

--D

> +}
> +
> +/*
> + * Parse kernel options string and apply via fsconfig
> + * Options are comma-separated key=value pairs
> + */
> +static int apply_mount_opts(int fsfd, const char *opts)
> +{
> +	char *opts_copy;
> +	char *opt;
> +	char *saveptr;
> +	int res;
> +
> +	if (!opts || !*opts)
> +		return 0;
> +
> +	opts_copy = strdup(opts);
> +	if (!opts_copy) {
> +		fprintf(stderr, "fuse: failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	opt = strtok_r(opts_copy, ",", &saveptr);
> +	while (opt) {
> +		/*
> +		 * Skip mount attributes, they're handled by fsmount()
> +		 * not fsconfig().
> +		 *
> +		 * These string options (nosuid, nodev, etc.) are reconstructed
> +		 * from MS_* flags by get_mnt_flag_opts() in lib/mount.c and
> +		 * get_mnt_opts() in util/fusermount.c. Both the library path
> +		 * (via fuse_kern_mount_get_base_mnt_opts) and fusermount3 path
> +		 * rebuild these strings from the flags bitmask and pass them in
> +		 * mnt_opts. They must be filtered here because they are mount
> +		 * attributes (passed to fsmount via MOUNT_ATTR_*), not
> +		 * filesystem parameters (which would be passed to fsconfig).
> +		 */
> +		if (!is_mount_attr_opt(opt)) {
> +			res = apply_opt_key_value(fsfd, opt);
> +			if (res < 0) {
> +				free(opts_copy);
> +				return res;
> +			}
> +		}
> +		opt = strtok_r(NULL, ",", &saveptr);
> +	}
> +
> +	free(opts_copy);
> +	return 0;
> +}
> +
> +
> +/**
> + * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
> + * @mnt: mountpoint
> + * @flags: mount flags (MS_NOSUID, MS_NODEV, etc.)
> + * @blkdev: 1 for fuseblk, 0 for fuse
> + * @fsname: filesystem name (or NULL)
> + * @subtype: filesystem subtype (or NULL)
> + * @source_dev: device name for building source string
> + * @kernel_opts: kernel mount options string
> + * @mnt_opts: additional mount options to pass to the kernel
> + *
> + * Returns: 0 on success, -1 on failure with errno set
> + */
> +int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
> +		      const char *fsname, const char *subtype,
> +		      const char *source_dev, const char *kernel_opts,
> +		      const char *mnt_opts)
> +{
> +	const char *type;
> +	char *source = NULL;
> +	int fsfd = -1;
> +	int mntfd = -1;
> +	int err, res;
> +	unsigned long mount_attrs;
> +
> +	/* Determine filesystem type */
> +	type = blkdev ? "fuseblk" : "fuse";
> +
> +	/* Try to open filesystem context */
> +	fsfd = fsopen(type, FSOPEN_CLOEXEC);
> +	if (fsfd == -1) {
> +		if (errno != EPERM)
> +			fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
> +				strerror(errno));
> +		return -1;
> +	}
> +
> +	/* Build source string */
> +	source = malloc((fsname ? strlen(fsname) : 0) +
> +			(subtype ? strlen(subtype) : 0) +
> +			strlen(source_dev) + 32);
> +	err = -ENOMEM;
> +	if (!source) {
> +		fprintf(stderr, "fuse: failed to allocate memory\n");
> +		goto out_close_fsfd;
> +	}
> +
> +	strcpy(source, fsname ? fsname : (subtype ? subtype : source_dev));
> +
> +	/* Configure source */
> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
> +	if (res == -1) {
> +		err = -errno;
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr, "fuse: fsconfig source failed: %s\n",
> +			strerror(errno));
> +		goto out_free;
> +	}
> +
> +	/* Apply VFS superblock flags (ro, sync, dirsync) */
> +	err = apply_mount_flags(fsfd, flags);
> +	if (err < 0) {
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr, "fuse: failed to apply mount flags\n");
> +		goto out_free;
> +	}
> +
> +	/* Apply kernel options */
> +	err = apply_mount_opts(fsfd, kernel_opts);
> +	if (err < 0) {
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr,
> +			"fuse: failed to apply kernel options '%s'\n",
> +			kernel_opts);
> +		goto out_free;
> +	}
> +
> +	/* Apply additional mount options */
> +	err = apply_mount_opts(fsfd, mnt_opts);
> +	if (err < 0) {
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr,
> +			"fuse: failed to apply additional mount options '%s'\n",
> +			mnt_opts);
> +		goto out_free;
> +	}
> +
> +	/* Create the filesystem instance */
> +	res = fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +	if (res == -1) {
> +		err = -errno;
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr, "fuse: fsconfig CREATE failed: %s\n",
> +			strerror(errno));
> +		goto out_free;
> +	}
> +
> +	/* Convert MS_* flags to MOUNT_ATTR_* for fsmount() */
> +	mount_attrs = ms_flags_to_mount_attrs(flags);
> +
> +	/* Create mount object with mount attributes */
> +	mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs);
> +	if (mntfd == -1) {
> +		err = -errno;
> +		log_fsconfig_kmsg(fsfd);
> +		fprintf(stderr, "fuse: fsmount failed: %s\n",
> +			strerror(errno));
> +		goto out_free;
> +	}
> +
> +	close(fsfd);
> +	fsfd = -1;
> +
> +	/* Attach to mount point */
> +	if (move_mount(mntfd, "", AT_FDCWD, mnt, MOVE_MOUNT_F_EMPTY_PATH) ==
> +	    -1) {
> +		err = -errno;
> +		fprintf(stderr, "fuse: move_mount failed: %s\n",
> +			strerror(errno));
> +		goto out_close_mntfd;
> +	}
> +
> +	err = fuse_mnt_add_mount_helper(mnt, source, type, mnt_opts);
> +	if (err == -1)
> +		goto out_umount;
> +
> +	close(mntfd);
> +	free(source);
> +	return 0;
> +
> +out_umount:
> +	{
> +		/* race free umount */
> +		char fd_path[64];
> +
> +		snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", mntfd);
> +		if (umount2(fd_path, MNT_DETACH) == -1 && errno != EINVAL) {
> +			fprintf(stderr,
> +				"fuse: cleanup umount failed: %s\n",
> +				strerror(errno));
> +		}
> +	}
> +out_close_mntfd:
> +	if (mntfd != -1)
> +		close(mntfd);
> +out_free:
> +	free(source);
> +out_close_fsfd:
> +	if (fsfd != -1)
> +		close(fsfd);
> +	errno = -err;
> +	return -1;
> +}
> +
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> index 1bfc78b32dc4fd434870e4fff1a37e0c340d207e..34c7386715155e8640cac68c218a1e1062990ce6 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -29,4 +29,18 @@ struct mount_opts {
>  	unsigned int max_read;
>  };
>  
> +int fuse_kern_mount_prepare(const char *mnt, struct mount_opts *mo);
> +
> +int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp);
> +
> +int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
> +		      const char *fsname, const char *subtype,
> +		      const char *source_dev, const char *kernel_opts,
> +		      const char *mnt_opts);
> +
> +int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
> +			 const char *mnt_opts);
> +
> +int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
> +			 const char *mnt_opts);
>  #endif /* FUSE_MOUNT_I_LINUX_H_ */
> diff --git a/meson.build b/meson.build
> index 80c5f1dc0bd3565c11ad3084dac08e28dab611dc..465a7bbfd14fe9c45897f197ef37db76079d20ee 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -30,7 +30,7 @@ if platform == 'darwin'
>          'https://www.fuse-t.org/ instead')
>  elif platform == 'cygwin' or platform == 'windows'
>    error('libfuse does not support Windows.\n' +
> -        'Take a look at http://www.secfs.net/winfsp/ instead')       
> +        'Take a look at http://www.secfs.net/winfsp/ instead')
>  endif
>  
>  cc = meson.get_compiler('c')
> @@ -118,6 +118,21 @@ special_funcs = {
>  	    return -1;
>  	  }
>  	}
> +    ''',
> +    'new_mount_api': '''
> +	#define _GNU_SOURCE
> +	#include <sys/mount.h>
> +	#include <linux/mount.h>
> +	#include <unistd.h>
> +	#include <fcntl.h>
> +
> +	int main(void) {
> +	    int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
> +	    int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
> +	    int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
> +	    res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +	    return 0;
> +	}
>      '''
>  }
>  
> @@ -308,7 +323,7 @@ configure_file(output: 'libfuse_config.h',
>  include_dirs = include_directories('include', 'lib', '.')
>  
>  # Common dependencies
> -thread_dep = dependency('threads') 
> +thread_dep = dependency('threads')
>  
>  #
>  # Read build files from sub-directories
> 
> -- 
> 2.43.0
> 
> 
