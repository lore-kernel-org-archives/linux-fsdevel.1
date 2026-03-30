Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD962FDC57
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897396; cv=none; b=T+hdVHK69S5BVPmiJoiBDYM4TBFuZb23U9TrHHgqrXIYfwSGOiYzv5UYnRIycCyidOiJ8SCgpyKSBJ4rp5RylkIkgxrKWTa/Lzho91hJ7L1VW6clR6FB8ylqnVMLNnI9teyfNg3hGrLEekRxGzZTMetEOKBMYY+WiN47y2xlX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897396; c=relaxed/simple;
	bh=UDoYv/tIlGa0cFfM7kpzLPanr2HrrMzBgh/3CvFZtP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDSx9fT4JkpgxhIDcGG1++EE8V4Ya/3qbASTtpUdp369yt3LtgNMbsD22t5/xySCocSLCP8NnGDev4COtnl3K8uxuOhShLiBY0iQV/Io4mahfiddYo31hiKQ/gfsR9R/uYEi9D/B9WUU2Wl2ZJDp92+6AIm0QBkeALZeoruHis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGK0FyQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGK0FyQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59E2C4CEF7;
	Mon, 30 Mar 2026 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774897395;
	bh=UDoYv/tIlGa0cFfM7kpzLPanr2HrrMzBgh/3CvFZtP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGK0FyQIFCOpgH9pi0HqMv581q79cMTCeHRRl3rywWLc4qnRZ2qketI54tW+B5km6
	 5DtaZHCKCZuGxuQCFaPFrS1J8E6cgUwSbSpdJnPfUAGxiZ9OjxC2nMjTpVV+PnDkbk
	 BM8BOUYqPuq8eSCPbgbLwWhHyQOlbzTBPBpzWlZH9EQq8Zw2FjxnHWW9/m4p6HdoJZ
	 WhHZhyOVBZ7D3ZJXIuyMGa0W7eoicJ6A2+ZCHM982sH4p4j+ZZnDa5gRMhhJgVP0P3
	 QinWcnCA0duyvrsV2x9xE+YIcVNggFHQrMHQ4EaNTRRwLlPzxJfK7mMzdDKe/jAnqf
	 cIIz+33wpsu+w==
Date: Mon, 30 Mar 2026 12:03:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 20/25] Make fusermount work bidirectional for sync init
Message-ID: <20260330190315.GA6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-20-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-20-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:53PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  util/fusermount.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  util/meson.build  |   2 +-
>  2 files changed, 291 insertions(+), 13 deletions(-)
> 
> diff --git a/util/fusermount.c b/util/fusermount.c
> index d42e16955f6d26f81e6d2a5acb040b1448e20b51..31bf959024ae0cd2a4e50974589bfab30a100b0a 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -11,6 +11,9 @@
>  #include "fuse_config.h"
>  #include "mount_util.h"
>  #include "util.h"
> +#if __linux__
> +#include "mount_i_linux.h"
> +#endif
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -923,6 +926,7 @@ static void free_mount_params(struct mount_params *mp)
>  	free(mp->source);
>  	free(mp->type);
>  	free(mp->mnt_opts);
> +	memset(mp, 0, sizeof(*mp));
>  }
>  
>  /*
> @@ -1309,6 +1313,171 @@ static int open_fuse_device(const char *dev)
>  	return fd;
>  }
>  
> +/*
> + * Context for split mount operation (sync-init mode)
> + */
> +struct mount_context {
> +	int fd;
> +	const char *dev;
> +	struct stat stbuf;
> +	char *source;
> +	char *mnt_opts;
> +	char *x_opts;
> +	const char *type;
> +};
> +
> +/*
> + * Phase 1: Open device and prepare for mount (sync-init mode)
> + * Returns fd on success, -1 on failure
> + */
> +static int mount_fuse_prepare(const char *mnt, const char *opts,
> +			      struct mount_context *ctx)
> +{
> +	int res;
> +	int mountpoint_fd = -1;
> +	char *do_mount_opts = NULL;
> +	const char *real_mnt = mnt;
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +	ctx->dev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;

Should this use the helper to figure out the fuse device path?

> +
> +	ctx->fd = open_fuse_device(ctx->dev);
> +	if (ctx->fd == -1)
> +		return -1;
> +
> +	drop_privs();
> +	read_conf();
> +
> +	if (getuid() != 0 && mount_max != -1) {
> +		int mount_count = count_fuse_fs();
> +
> +		if (mount_count >= mount_max) {
> +			fprintf(stderr,
> +				"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
> +				progname, FUSE_CONF);
> +			goto fail_close_fd;
> +		}
> +	}
> +
> +	res = extract_x_options(opts, &do_mount_opts, &ctx->x_opts);
> +	if (res)
> +		goto fail_close_fd;
> +
> +	res = check_perm(&real_mnt, &ctx->stbuf, &mountpoint_fd);
> +	restore_privs();
> +
> +	if (mountpoint_fd != -1)
> +		close(mountpoint_fd);
> +
> +	if (res == -1)
> +		goto fail_close_fd;
> +
> +	free(do_mount_opts);
> +	return ctx->fd;
> +
> +fail_close_fd:
> +	close(ctx->fd);
> +	free(do_mount_opts);
> +	free(ctx->x_opts);
> +	ctx->fd = -1;
> +	return -1;
> +}
> +
> +#ifdef HAVE_NEW_MOUNT_API
> +/*
> + * Phase 2: Perform the actual mount using new mount API (sync-init mode)
> + * Returns 0 on success, -1 on failure
> + */
> +static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
> +				     struct mount_context *ctx,
> +				     const char **type)
> +{
> +	int res;
> +	char *do_mount_opts = NULL;
> +	char *x_prefixed_opts = NULL;
> +	struct mount_params mp = {
> +		.fd = ctx->fd,
> +		.rootmode = ctx->stbuf.st_mode & S_IFMT,
> +		.dev = ctx->dev,
> +	};
> +	char *final_mnt_opts = NULL;
> +
> +	/* Extract x-options */
> +	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);

Didn't we already extract_x_options() in phase 1?  Can we save
do_mount_opts in ctx instead of calling this twice?

> +	if (res)
> +		goto fail;
> +
> +	res = prepare_mount(do_mount_opts, &mp);
> +	if (res == -1)
> +		goto fail;
> +
> +	/* Merge x-options if running as root */
> +	final_mnt_opts = mp.mnt_opts;
> +	if (geteuid() == 0 && ctx->x_opts && strlen(ctx->x_opts) > 0) {
> +		size_t mnt_opts_len = strlen(mp.mnt_opts);
> +		size_t x_mnt_opts_len = mnt_opts_len + strlen(ctx->x_opts) + 2;
> +		char *x_mnt_opts = calloc(1, x_mnt_opts_len);
> +
> +		if (!x_mnt_opts)
> +			goto fail_free_params;
> +
> +		if (mnt_opts_len) {
> +			strcpy(x_mnt_opts, mp.mnt_opts);
> +			strncat(x_mnt_opts, ",", 2);
> +		}
> +		strncat(x_mnt_opts, ctx->x_opts,
> +			x_mnt_opts_len - mnt_opts_len - 2);

asprintf?

--D

> +
> +		final_mnt_opts = x_mnt_opts;
> +	}
> +
> +	/* Use new mount API */
> +	res = fuse_kern_fsmount(mnt, mp.flags, mp.blkdev,
> +				mp.fsname, mp.subtype, ctx->dev,
> +				mp.optbuf, final_mnt_opts);
> +	if (res == -1)
> +		goto fail_free_merged;
> +
> +	/* Change to root directory */
> +	res = chdir("/");
> +	if (res == -1) {
> +		fprintf(stderr, "%s: failed to chdir to '/'\n", progname);
> +		goto fail_free_merged;
> +	}
> +
> +	/* Store results in context */
> +	ctx->source = mp.source;
> +	ctx->type = mp.type;
> +	ctx->mnt_opts = final_mnt_opts;
> +	*type = mp.type;
> +
> +	res = 0;
> +
> +	/* Only free what is not assigned to ctx */
> +	free(mp.fsname);
> +	free(mp.subtype);
> +	free(mp.optbuf);
> +	if (final_mnt_opts != mp.mnt_opts)
> +		free(mp.mnt_opts);
> +
> +out:
> +	free(do_mount_opts);
> +	free(x_prefixed_opts);
> +
> +	return res;
> +
> +fail_free_merged:
> +	if (final_mnt_opts != mp.mnt_opts)
> +		free(final_mnt_opts);
> +fail_free_params:
> +	free_mount_params(&mp);
> +fail:
> +	res = -1;
> +	goto out;
> +}
> +#endif /* HAVE_NEW_MOUNT_API */
> +
> +
>  static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  {
>  	int res;
> @@ -1404,6 +1573,65 @@ fail_close_fd:
>  	goto out_free;
>  }
>  
> +/* Forward declarations for helper functions */
> +static int send_fd(int sock_fd, int fd);
> +static int wait_for_signal(int sock_fd);
> +
> +#ifdef HAVE_NEW_MOUNT_API
> +/*
> + * Perform sync-init mount using new mount API
> + * Returns 0 on success, -1 on failure
> + */
> +static int mount_fuse_sync_init(const char *mnt, const char *opts,
> +				int cfd, const char **type)
> +{
> +	struct mount_context ctx;
> +	int fd, res;
> +	int32_t status, send_res;
> +
> +	/* Phase 1: Open device and prepare */
> +	fd = mount_fuse_prepare(mnt, opts, &ctx);
> +	if (fd == -1)
> +		return -1;
> +
> +	/* Send fd to caller so it can start worker thread */
> +	res = send_fd(cfd, fd);
> +	if (res != 0) {
> +		close(fd);
> +		free(ctx.x_opts);
> +		return -1;
> +	}
> +
> +	/* Wait for caller to signal that worker thread is ready */
> +	res = wait_for_signal(cfd);
> +	if (res != 0) {
> +		close(fd);
> +		free(ctx.x_opts);
> +		return -1;
> +	}
> +
> +	/* Phase 2: Perform the actual mount using new API */
> +	res = mount_fuse_finish_fsmount(mnt, opts, &ctx, type);
> +
> +	/* Send mount result back to caller (4-byte error code) */
> +	status = (res == 0) ? 0 : -(int32_t)errno;
> +	do {
> +		send_res = send(cfd, &status, sizeof(status), 0);
> +	} while (send_res == -1 && errno == EINTR);
> +	if (send_res != sizeof(status)) {
> +		fprintf(stderr, "%s: failed to send mount status: %s\n",
> +			progname, strerror(errno));
> +	}
> +
> +	close(fd);
> +	free(ctx.source);
> +	free(ctx.mnt_opts);
> +	free(ctx.x_opts);
> +
> +	return res;
> +}
> +#endif /* HAVE_NEW_MOUNT_API */
> +
>  static int send_fd(int sock_fd, int fd)
>  {
>  	int retval;
> @@ -1440,6 +1668,30 @@ static int send_fd(int sock_fd, int fd)
>  	return 0;
>  }
>  
> +/*
> + * Wait for a signal byte from the caller.
> + * Returns 0 on success, -1 on error.
> + */
> +static int wait_for_signal(int sock_fd)
> +{
> +	char buf[1];
> +	int res;
> +
> +	do {
> +		res = recv(sock_fd, buf, sizeof(buf), 0);
> +	} while (res == -1 && errno == EINTR);
> +	if (res != 1) {
> +		if (res == 0)
> +			fprintf(stderr, "%s: connection closed while waiting for signal\n",
> +				progname);
> +		else
> +			fprintf(stderr, "%s: error receiving signal: %s\n",
> +				progname, strerror(errno));
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  /* Helper for should_auto_unmount
>   *
>   * fusermount typically has the s-bit set - initial open of `mnt` was as root
> @@ -1631,6 +1883,7 @@ int main(int argc, char *argv[])
>  	const char *opts = "";
>  	const char *type = NULL;
>  	int setup_auto_unmount_only = 0;
> +	int sync_init_mode = 0;
>  
>  	static const struct option long_opts[] = {
>  		{"unmount", no_argument, NULL, 'u'},
> @@ -1643,6 +1896,7 @@ int main(int argc, char *argv[])
>  		// They'ne meant for internal use by mount.c
>  		{"auto-unmount", no_argument, NULL, 'U'},
>  		{"comm-fd", required_argument, NULL, 'c'},
> +		{"sync-init", no_argument, NULL, 'S'},
>  		{0, 0, 0, 0}};
>  
>  	progname = strdup(argc > 0 ? argv[0] : "fusermount");
> @@ -1677,6 +1931,9 @@ int main(int argc, char *argv[])
>  		case 'c':
>  			commfd = optarg;
>  			break;
> +		case 'S':
> +			sync_init_mode = 1;
> +			break;
>  		case 'z':
>  			lazy = 1;
>  			break;
> @@ -1754,21 +2011,42 @@ int main(int argc, char *argv[])
>  	if (setup_auto_unmount_only)
>  		goto wait_for_auto_unmount;
>  
> -	fd = mount_fuse(mnt, opts, &type);
> -	if (fd == -1)
> -		goto err_out;
> +	if (sync_init_mode) {
> +#ifdef HAVE_NEW_MOUNT_API
> +		res = mount_fuse_sync_init(mnt, opts, cfd, &type);
> +		if (res == -1)
> +			goto err_out;
>  
> -	res = send_fd(cfd, fd);
> -	if (res != 0) {
> -		umount2(mnt, MNT_DETACH); /* lazy umount */
> +		if (!auto_unmount) {
> +			free(mnt);
> +			free((void *) type);
> +			return 0;
> +		}
> +		/* Continue to auto_unmount handling below */
> +#else
> +		fprintf(stderr, "%s: sync-init mode requires new mount API support\n",
> +			progname);
> +		fprintf(stderr, "%s: kernel or headers too old (need fsopen/fsmount)\n",
> +			progname);
>  		goto err_out;
> -	}
> -	close(fd);
> +#endif
> +	} else {
> +		fd = mount_fuse(mnt, opts, &type);
> +		if (fd == -1)
> +			goto err_out;
>  
> -	if (!auto_unmount) {
> -		free(mnt);
> -		free((void*) type);
> -		return 0;
> +		res = send_fd(cfd, fd);
> +		if (res != 0) {
> +			umount2(mnt, MNT_DETACH); /* lazy umount */
> +			goto err_out;
> +		}
> +		close(fd);
> +
> +		if (!auto_unmount) {
> +			free(mnt);
> +			free((void *) type);
> +			return 0;
> +		}
>  	}
>  
>  wait_for_auto_unmount:
> diff --git a/util/meson.build b/util/meson.build
> index 0e4b1cce95377e73af7dc45655a7088315497ddb..731ef95488461ac21c21b1972a96d58b1187dc5a 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -1,6 +1,6 @@
>  fuseconf_path = join_paths(get_option('prefix'), get_option('sysconfdir'), 'fuse.conf')
>  
> -executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c'],
> +executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/mount_fsmount.c', '../lib/util.c'],
>             include_directories: include_dirs,
>             install: true,
>             install_dir: get_option('bindir'),
> 
> -- 
> 2.43.0
> 
> 
