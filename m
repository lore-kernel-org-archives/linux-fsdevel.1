Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08030C15E;
	Fri, 15 May 2026 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871734; cv=none; b=Ihzrb2//8GC71B0W8q6Tw3R23XA305zqT/LMelmU/kT6FN8KKpgq8483oaSDU+trnk+bbdtpkwTLOlgpLqjwY+6Un6H6jNXAgw2/Y7JiT2LBqfDJRmutocGsPhHqgddfmJJyhpqakvxmpTlKU0YM8lfyt9SQnR3nbu/OvlzvN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871734; c=relaxed/simple;
	bh=XNxmO6n6XeMbowCoUMJMpm79ib7wEOn6/9JcH+ReKzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9GC2UWlIPBCneFsAgKmNXtg46MLwjdMuEmb1wXxfIiBmiG2erqUxl5GRr9pqJr+9Srgr1a2SiyDDVFX8t7LjiwWLSSkAYV9iRFAkPoeXt2iRbXjLFTtKb+CqYKUuNNFZw/2JiXGikWhkoI9kdPISObIAqTm6ZwxU4L5b4wVo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9buQOa+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9buQOa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2F5C2BCB0;
	Fri, 15 May 2026 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778871734;
	bh=XNxmO6n6XeMbowCoUMJMpm79ib7wEOn6/9JcH+ReKzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9buQOa+gGuJHErdcQi2yDuhZ4vB7h3p5wlfVDrcpaabs2EPGGdDO1x+GFt7bZqM0
	 alY+P/D/2rg4Jls5qLo6n2zIKgbKxliMvfhC1dNlxmCllpR2aS4MDd2GWRyiZSbd4g
	 ylyze54zqC1/Qex9MMmnrDmxX5O6Hzv+S47ehqMiZO2ynCO7uHL0CyV0OIclCxDTm1
	 TLCgoV0Oco/SlWvripF+xfhHm8A/ww93A0/NmRswrR5kSJnvZqF7Rt09T8sLjbuE8A
	 h/JIgPmm/rfZXEDxQrcMDF4cQuStFbgMhEitiFAmENNhQ7YzU6Q3glkwPVp3ihLxVB
	 QVxaeYxnV0hfA==
Date: Fri, 15 May 2026 12:02:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Subject: Re: [PATCH 22/25] libfuse: create a helper to transform an open
 regular file into an open loopdev
Message-ID: <20260515190212.GX9544@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
 <177747211961.4104686.8091769616825139501.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747211961.4104686.8091769616825139501.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:44:49AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a helper function to configure a loop device for an open regular
> file fd, and then return an open fd to the loop device.  This will
> enable the use of fuse+iomap file servers with filesystem image files.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_loopdev.h |   29 +++
>  include/meson.build    |    4 
>  lib/fuse_loopdev.c     |  441 ++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/fuse_versionscript |    1 
>  lib/meson.build        |    3 
>  meson.build            |   11 +
>  6 files changed, 488 insertions(+), 1 deletion(-)
>  create mode 100644 include/fuse_loopdev.h
>  create mode 100644 lib/fuse_loopdev.c
> 
> 
> diff --git a/include/fuse_loopdev.h b/include/fuse_loopdev.h
> new file mode 100644
> index 00000000000000..aa536e2a0b3964
> --- /dev/null
> +++ b/include/fuse_loopdev.h
> @@ -0,0 +1,29 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2025-2026 Oracle.
> + * Author: Darrick J. Wong <djwong@kernel.org>
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file LGPL2.txt.
> + */
> +#ifndef FUSE_LOOPDEV_H_
> +#define FUSE_LOOPDEV_H_
> +

Codex complained about the lack of extern "C" { } wrapping in this
header file.

> +/**
> + * If possible, set up a loop device for the given file fd.  Return the opened
> + * loop device fd and the path to the loop device.  The loop device will be
> + * removed when the last close() occurs.
> + *
> + * @param file_fd an open file
> + * @param open_flags O_* flags that were used to open file_fd
> + * @param path the path to the open regular file
> + * @param timeout spend this much time waiting to lock the file
> + * @param loop_fd set to an open fd to the new loop device or
> + *        -1 if setting up a loop device is not possible or appropriate
> + * @param loop_dev (optional) set to a pointer to the path to the loop device
> + * @return 0 for success, or negative errno on failure
> + */
> +int fuse_loopdev_setup(int file_fd, int open_flags, const char *path,
> +		       unsigned int timeout, int *loop_fd, char **loop_dev);
> +
> +#endif /* FUSE_LOOPDEV_H_ */
> diff --git a/include/meson.build b/include/meson.build
> index da51180f87eea2..60edd649f1784f 100644
> --- a/include/meson.build
> +++ b/include/meson.build
> @@ -5,4 +5,8 @@ if private_cfg.get('HAVE_SERVICEMOUNT', false)
>    libfuse_headers += [ 'fuse_service.h' ]
>  endif
>  
> +if private_cfg.get('FUSE_LOOPDEV_ENABLED')
> +  libfuse_headers += [ 'fuse_loopdev.h' ]
> +endif
> +
>  install_headers(libfuse_headers, subdir: 'fuse3')
> diff --git a/lib/fuse_loopdev.c b/lib/fuse_loopdev.c
> new file mode 100644
> index 00000000000000..6d7017277d9eaf
> --- /dev/null
> +++ b/lib/fuse_loopdev.c
> @@ -0,0 +1,441 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2025-2026 Oracle.
> + * Author: Darrick J. Wong <djwong@kernel.org>
> + *
> + * Library functions for handling loopback devices on linux.
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file LGPL2.txt
> + */
> +#define _GNU_SOURCE
> +#include "fuse_config.h"
> +#include "fuse_loopdev.h"
> +
> +#ifdef FUSE_LOOPDEV_ENABLED
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <dirent.h>
> +#include <signal.h>
> +#include <time.h>
> +#include <sys/stat.h>
> +#include <sys/ioctl.h>
> +#include <sys/file.h>
> +#include <sys/types.h>
> +#include <sys/time.h>
> +#include <linux/loop.h>
> +
> +#include "fuse_log.h"
> +
> +#define _PATH_LOOPCTL		"/dev/loop-control"
> +#define _PATH_SYS_BLOCK		"/sys/block"
> +
> +#ifdef STATX_SUBVOL
> +# define STATX_SUBVOL_FLAG	STATX_SUBVOL
> +#else
> +# define STATX_SUBVOL_FLAG	0
> +#endif
> +
> +static int lock_file(int fd, const char *path)
> +{
> +	int ret;
> +
> +	ret = flock(fd, LOCK_EX);
> +	if (ret) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
> +		return -error;
> +	}
> +
> +	return 0;
> +}
> +
> +static double gettime_monotonic(void)
> +{
> +#ifdef CLOCK_MONOTONIC
> +	struct timespec ts;
> +#endif
> +	struct timeval tv;
> +	static double fake_ret;
> +	int ret;
> +
> +#ifdef CLOCK_MONOTONIC
> +	ret = clock_gettime(CLOCK_MONOTONIC, &ts);
> +	if (ret == 0)
> +		return ts.tv_sec + (ts.tv_nsec / 1000000000.0);
> +#endif
> +	ret = gettimeofday(&tv, NULL);
> +	if (ret == 0)
> +		return tv.tv_sec + (tv.tv_usec / 1000000.0);
> +
> +	fake_ret += 1.0;
> +	return fake_ret;
> +}
> +
> +static int lock_file_timeout(int fd, const char *path, unsigned int timeout)
> +{
> +	double deadline, now;
> +	int ret;
> +
> +	now = gettime_monotonic();
> +	deadline = now + timeout;
> +
> +	/* Use a tight sleeping loop here to avoid signal handlers */
> +	while (now <= deadline) {
> +		struct timespec sleepy = {
> +			/* sleep 0.1s before trying again */
> +			.tv_nsec = 100000000,
> +		};
> +		int error;
> +
> +		ret = flock(fd, LOCK_EX | LOCK_NB);
> +		if (ret == 0)
> +			return 0;
> +
> +		error = errno;
> +
> +		if (error != EWOULDBLOCK) {
> +			fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path,
> +				 strerror(error));
> +			return -error;
> +		}
> +
> +		nanosleep(&sleepy, NULL);
> +
> +		now = gettime_monotonic();
> +	}
> +
> +	fuse_log(FUSE_LOG_DEBUG, "%s: could not lock file\n", path);
> +	return -EWOULDBLOCK;
> +}
> +
> +static int unlock_file(int fd, const char *path)
> +{
> +	int ret;
> +
> +	ret = flock(fd, LOCK_UN);
> +	if (ret) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
> +		return -error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int want_loopdev(int file_fd, const char *path)
> +{
> +	struct stat stbuf;
> +	int ret;
> +
> +	ret = fstat(file_fd, &stbuf);
> +	if (ret < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: fstat failed: %s\n",
> +			 path, strerror(error));
> +		return -error;
> +	}
> +
> +	/*
> +	 * Keep quiet about block devices, the client can probably still read
> +	 * and write that.
> +	 */
> +	if (S_ISBLK(stbuf.st_mode))
> +		return 0;
> +
> +	ret = S_ISREG(stbuf.st_mode) && stbuf.st_size >= 512;
> +	if (!ret)
> +		fuse_log(FUSE_LOG_DEBUG,
> +			 "%s: file not compatible with loop device\n", path);
> +	return ret;
> +}
> +
> +static int same_backing_file(int dir_fd, const char *name,
> +			     const struct statx *file_stat)
> +{
> +	struct statx backing_stat;
> +	char backing_name[NAME_MAX + 18 + 1];
> +	char path[PATH_MAX + 1];
> +	ssize_t bytes;
> +	int fd;
> +	int ret;
> +
> +	snprintf(backing_name, sizeof(backing_name), "%s/loop/backing_file",
> +			name);
> +
> +	fd = openat(dir_fd, backing_name, O_RDONLY);
> +	if (fd < 0) {
> +		int error = errno;
> +
> +		/* unconfigured loop devices don't have backing_file attr */
> +		if (error == ENOENT)
> +			return 0;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", backing_name,
> +			 strerror(error));
> +		return -error;
> +	}
> +
> +	bytes = pread(fd, path, sizeof(path) - 1, 0);
> +	if (bytes < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", backing_name,
> +			 strerror(error));
> +		ret = -error;
> +		goto out_backing;
> +	} else if (bytes == 0) {
> +		fuse_log(FUSE_LOG_DEBUG, "%s: no path in backing file?\n",
> +			 backing_name);
> +		ret = -ENOENT;
> +		goto out_backing;
> +	}
> +
> +	if (path[bytes - 1] == '\n')
> +		path[bytes - 1] = 0;
> +
> +	ret = statx(AT_FDCWD, path, 0, STATX_BASIC_STATS | STATX_SUBVOL_FLAG,
> +			&backing_stat);
> +	if (ret) {
> +		int error = errno;
> +
> +		/*
> +		 * backing file deleted, assume nobody's doing procfd
> +		 * shenanigans
> +		 */
> +		if (error == ENOENT) {
> +			ret = 0;
> +			goto out_backing;
> +		}
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
> +		ret = -error;
> +		goto out_backing;
> +	}
> +
> +	/* different devices */
> +	if (backing_stat.stx_dev_major != file_stat->stx_dev_major)
> +		goto out_backing;
> +	if (backing_stat.stx_dev_minor != file_stat->stx_dev_minor)
> +		goto out_backing;
> +
> +	/* different inode number */
> +	if (backing_stat.stx_ino != file_stat->stx_ino)
> +		goto out_backing;
> +
> +#ifdef STATX_SUBVOL
> +	/* different subvol (or subvol state) */
> +	if ((backing_stat.stx_mask ^ file_stat->stx_mask) & STATX_SUBVOL)
> +		goto out_backing;
> +
> +	if ((backing_stat.stx_mask & STATX_SUBVOL) &&
> +	    backing_stat.stx_subvol != file_stat->stx_subvol)
> +		goto out_backing;
> +#endif
> +
> +	ret = 1;
> +
> +out_backing:
> +	close(fd);
> +	return ret;
> +}
> +
> +static int has_existing_loopdev(int file_fd, const char *path)
> +{
> +	struct statx file_stat;
> +	DIR *dir;
> +	struct dirent *d;
> +	int blockfd;
> +	int ret;
> +
> +	ret = statx(file_fd, "", AT_EMPTY_PATH,
> +		    STATX_BASIC_STATS | STATX_SUBVOL_FLAG, &file_stat);
> +	if (ret) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(error));
> +		return -error;
> +	}
> +
> +	dir = opendir(_PATH_SYS_BLOCK);
> +	if (!dir) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_SYS_BLOCK,
> +			 strerror(error));
> +		return -error;
> +	}
> +
> +	blockfd = dirfd(dir);
> +
> +	while ((d = readdir(dir)) != NULL) {
> +		if (strcmp(d->d_name, ".") == 0 ||
> +		    strcmp(d->d_name, "..") == 0 ||
> +		    strncmp(d->d_name, "loop", 4) != 0)
> +			continue;
> +
> +		ret = same_backing_file(blockfd, d->d_name, &file_stat);
> +		if (ret != 0)
> +			break;
> +	}
> +
> +	closedir(dir);
> +	return ret;
> +}
> +
> +static int open_loopdev(int file_fd, int open_flags, char *loopdev,
> +			size_t loopdev_sz)
> +{
> +	struct loop_config lc = {
> +		.info.lo_flags = LO_FLAGS_DIRECT_IO | LO_FLAGS_AUTOCLEAR,
> +	};
> +	int ctl_fd = -1;
> +	int loop_fd = -1;
> +	int loopno;
> +	int ret;
> +
> +	if ((open_flags & O_ACCMODE) == O_RDONLY)
> +		lc.info.lo_flags |= LO_FLAGS_READ_ONLY;
> +
> +	ctl_fd = open(_PATH_LOOPCTL, O_RDONLY);
> +	if (ctl_fd < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_LOOPCTL,
> +			 strerror(error));
> +		return -error;
> +	}
> +
> +	ret = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
> +	if (ret < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_LOOPCTL,
> +			 strerror(error));
> +		ret = -error;
> +		goto out_ctl;
> +	}
> +	loopno = ret;
> +	snprintf(loopdev, loopdev_sz, "/dev/loop%d", loopno);
> +
> +	loop_fd = open(loopdev, open_flags);
> +	if (loop_fd < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", loopdev, strerror(error));
> +		ret = -error;
> +		goto out_ctl;
> +	}
> +
> +	lc.fd = file_fd;
> +
> +	ret = ioctl(loop_fd, LOOP_CONFIGURE, &lc);
> +	if (ret < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", loopdev, strerror(error));
> +		ret = -error;
> +		goto out_loop;
> +	}
> +
> +	close(ctl_fd);
> +	return loop_fd;
> +
> +out_loop:
> +	ioctl(ctl_fd, LOOP_CTL_REMOVE, loopno);
> +	close(loop_fd);
> +out_ctl:
> +	close(ctl_fd);
> +	return ret;
> +}
> +
> +int fuse_loopdev_setup(int file_fd, int open_flags, const char *path,
> +		       unsigned int timeout, int *loop_fd, char **loop_dev)
> +{
> +	char loopdev[PATH_MAX];
> +	int loopfd = -1;
> +	int ret;
> +
> +	*loop_fd = -1;
> +	if (loop_dev)
> +		*loop_dev = NULL;

Also we should probably filter some bad flags from open_flags, such as
O_CREAT and O_TRUNC, since those don't make sense for an existing loop
device and we definitely don't want to create a /dev/loop/XXX node.

--D
