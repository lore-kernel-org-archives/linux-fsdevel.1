Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F213822A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305653; cv=none; b=vBmMTw7mSjrp7ZzZ73M7zRLJcmD+AljigJBTIVO4CiTn2sQUfNrsPmlV/oldq4lPLpSkk2mDOrnB5YJ0exY0LZiEOxZ93yxY7idmrjZJF6CfKV/Ja+k0wkO12/iDPAnfBG18NZ6vUj+hdLJFfkHZxUdrab6063WHaf2asmRnjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305653; c=relaxed/simple;
	bh=IaK4t2f294e7mkhjTURZKVAFIBvBU8Eqol4MciU24Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyqDLOsLejAQsTFfykGJVzw3cZMMaULgVaVUAijsIunpzmQTdOTWIBU8c9plUbM7HsjDtau0PRpwXe3o57TLTP5Kf2US9h2Fr/50bDenz+O4eyi4IDnll/oSdmphvk0axXcJ4fnd26Oajg0ZRD74dDiACRVLi0fvo9hPBdUqa5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhhKkXkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhhKkXkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49321C4CEF7;
	Mon, 23 Mar 2026 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774305653;
	bh=IaK4t2f294e7mkhjTURZKVAFIBvBU8Eqol4MciU24Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhhKkXkbiUgzcVQLeKY7uX2rhku1c+jM7FVFxo6Rh3ZIStL1veg+UdaRXu2wE1sI1
	 WJ4oCNi+bIQCvywHQRdNGMH3TG0XasslkVRKb82bd3qt/HdhJ4xF8PY93TkDW24PCK
	 nLRmY+5SjfstE0oS41gFI+DVi3AaEdtDdjUJ00nBPYKk9BBbHe9HLvyvDrZUVNVvUk
	 8/gDW9OniBbCF+YeoSM/ae6gXUzi6MnFWrqRzYPYwOb69V08H0POF6y9ackvXF6R72
	 K77S3sIteW6MMZgAwQVT5vw7FWU/btToA8K79QT+KXSFvzH0biIQIEsfYscE95hgeY
	 JVdmXKLlXUOcg==
Date: Mon, 23 Mar 2026 15:40:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 08/19] Refactor mount code / move common functions to
 mount_util.c
Message-ID: <20260323224052.GJ6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-8-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-8-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:03PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Also create the new "mount_i.h", which is independent of the
> the rest of libfuse.
> 
> This is preparation for the new mount API, which goes into a new file.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Hey, I want to use some of these new helpers too! :)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Can we use asprintf for fuse_mnt_build_{source,type} though?

--D

> ---
>  lib/fuse_i.h         | 10 ++----
>  lib/mount.c          | 96 ++++++++++++++++++++++++++++------------------------
>  lib/mount_bsd.c      |  1 +
>  lib/mount_common_i.h | 31 +++++++++++++++++
>  lib/mount_i_linux.h  | 32 ++++++++++++++++++
>  lib/mount_util.c     | 24 +++++++++++++
>  lib/mount_util.h     |  6 ++++
>  7 files changed, 148 insertions(+), 52 deletions(-)
> 
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index b4c1d3eef41010287f6c9555ec0b2442d904d192..6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -19,14 +19,15 @@
>  #include <stdbool.h>
>  #include <stdatomic.h>
>  
> +#ifndef MIN
>  #define MIN(a, b) \
>  ({									\
>  	typeof(a) _a = (a);						\
>  	typeof(b) _b = (b);						\
>  	_a < _b ? _a : _b;						\
>  })
> +#endif
>  
> -struct mount_opts;
>  struct fuse_ring_pool;
>  
>  struct fuse_req {
> @@ -217,13 +218,8 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
>   */
>  void fuse_chan_put(struct fuse_chan *ch);
>  
> -/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
> -#define FUSE_MOUNT_FALLBACK_NEEDED -2
> -
> -struct mount_opts *parse_mount_opts(struct fuse_args *args);
> -void destroy_mount_opts(struct mount_opts *mo);
> +/* Mount-related functions */
>  void fuse_mount_version(void);
> -unsigned get_max_read(struct mount_opts *o);
>  void fuse_kern_unmount(const char *mountpoint, int fd);
>  int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
>  
> diff --git a/lib/mount.c b/lib/mount.c
> index dec9d52274c13536648cacef959789f472c5682c..fe353e2cc4579adb47473cac5db7d1bae2defb2c 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -16,6 +16,7 @@
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
>  #include "mount_util.h"
> +#include "mount_i_linux.h"
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -49,7 +50,6 @@
>  #define FUSERMOUNT_PROG		"fusermount3"
>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
> -#define FUSE_KERN_DEVICE_ENV	"FUSE_KERN_DEVICE"
>  
>  #ifndef MS_DIRSYNC
>  #define MS_DIRSYNC 128
> @@ -65,20 +65,6 @@ enum {
>  	KEY_RO,
>  };
>  
> -struct mount_opts {
> -	int allow_other;
> -	int flags;
> -	int auto_unmount;
> -	int blkdev;
> -	char *fsname;
> -	char *subtype;
> -	char *subtype_opt;
> -	char *mtab_opts;
> -	char *fusermount_opts;
> -	char *kernel_opts;
> -	unsigned max_read;
> -};
> -
>  #define FUSE_MOUNT_OPT(t, p) { t, offsetof(struct mount_opts, p), 1 }
>  
>  static const struct fuse_opt fuse_mount_opts[] = {
> @@ -197,7 +183,7 @@ static const struct mount_flags mount_flags[] = {
>  	{NULL,	    0,		    0}
>  };
>  
> -unsigned get_max_read(struct mount_opts *o)
> +unsigned int get_max_read(struct mount_opts *o)
>  {
>  	return o->max_read;
>  }
> @@ -510,7 +496,7 @@ static int fuse_kern_mount_prepare(const char *mnt,
>  				   struct mount_opts *mo)
>  {
>  	char tmp[128];
> -	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
> +	const char *devname = fuse_mnt_get_devname();
>  	struct stat stbuf;
>  	int fd;
>  	int res;
> @@ -563,35 +549,24 @@ out_close:
>   * @mo: mount options
>   * @mnt_opts: mount options to pass to the kernel
>   *
> - * Returns: 0 on success, -1 on failure, FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
> + * Returns: 0 on success, -1 on failure,
> + *          FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
>   */
>  static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
>  				  const char *mnt_opts)
>  {
> -	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
>  	char *source = NULL;
>  	char *type = NULL;
>  	int res;
>  
>  	res = -ENOMEM;
> -	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
> -			(mo->subtype ? strlen(mo->subtype) : 0) +
> -			strlen(devname) + 32);
> -
> -	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
> +	source = fuse_mnt_build_source(mo);
> +	type = fuse_mnt_build_type(mo);
>  	if (!type || !source) {
>  		fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate memory\n");
>  		goto out_close;
>  	}
>  
> -	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
> -	if (mo->subtype) {
> -		strcat(type, ".");
> -		strcat(type, mo->subtype);
> -	}
> -	strcpy(source,
> -	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
> -
>  	res = mount(source, mnt, type, mo->flags, mo->kernel_opts);
>  	if (res == -1 && errno == ENODEV && mo->subtype) {
>  		/* Probably missing subtype support */
> @@ -627,20 +602,10 @@ static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
>  		goto out_close;
>  	}
>  
> -#ifndef IGNORE_MTAB
> -	if (geteuid() == 0) {
> -		char *newmnt = fuse_mnt_resolve_path("fuse", mnt);
> -		res = -1;
> -		if (!newmnt)
> -			goto out_umount;
> +	res = fuse_mnt_add_mount_helper(mnt, source, type, mnt_opts);
> +	if (res == -1)
> +		goto out_umount;
>  
> -		res = fuse_mnt_add_mount("fuse", source, newmnt, type,
> -					 mnt_opts);
> -		free(newmnt);
> -		if (res == -1)
> -			goto out_umount;
> -	}
> -#endif /* IGNORE_MTAB */
>  	free(type);
>  	free(source);
>  
> @@ -777,3 +742,44 @@ out:
>  	free(mnt_opts);
>  	return res;
>  }
> +
> +const char *fuse_mnt_get_devname(void)
> +{
> +	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
> +
> +	return devname ? devname : "/dev/fuse";
> +}
> +
> +char *fuse_mnt_build_source(const struct mount_opts *mo)
> +{
> +	const char *devname = fuse_mnt_get_devname();
> +	char *source;
> +
> +	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
> +			(mo->subtype ? strlen(mo->subtype) : 0) +
> +			strlen(devname) + 32);
> +	if (!source)
> +		return NULL;
> +
> +	strcpy(source,
> +	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
> +
> +	return source;
> +}
> +
> +char *fuse_mnt_build_type(const struct mount_opts *mo)
> +{
> +	char *type;
> +
> +	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
> +	if (!type)
> +		return NULL;
> +
> +	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
> +	if (mo->subtype) {
> +		strcat(type, ".");
> +		strcat(type, mo->subtype);
> +	}
> +
> +	return type;
> +}
> diff --git a/lib/mount_bsd.c b/lib/mount_bsd.c
> index c12ab322e7dc86d5c8d2f2abc6b71488e82523cf..c5b831160f826c0e4620626a72c4b93427d18bab 100644
> --- a/lib/mount_bsd.c
> +++ b/lib/mount_bsd.c
> @@ -10,6 +10,7 @@
>  
>  #include "fuse_config.h"
>  #include "fuse_i.h"
> +#include "mount_common_i.h"
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
>  #include "util.h"
> diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..d27d2aa624ae3806c61a0fe382c2d024080c9bb3
> --- /dev/null
> +++ b/lib/mount_common_i.h
> @@ -0,0 +1,31 @@
> +/*
> + *  FUSE: Filesystem in Userspace
> + *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> + *                2026 Bernd Schubert <bernd@bsbernd.com>
> + *
> + *  This program can be distributed under the terms of the GNU LGPLv2.
> + *  See the file LGPL2.txt
> + */
> +
> +#ifndef FUSE_MOUNT_COMMON_I_H_
> +#define FUSE_MOUNT_COMMON_I_H_
> +
> +/* Forward declaration for fuse_args */
> +struct fuse_args;
> +struct mount_opts;
> +
> +/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
> +#define FUSE_MOUNT_FALLBACK_NEEDED -2
> +
> +/* Environment variable for FUSE kernel device */
> +#define FUSE_KERN_DEVICE_ENV "FUSE_KERN_DEVICE"
> +
> +/* Mount options management functions */
> +struct mount_opts *parse_mount_opts(struct fuse_args *args);
> +void destroy_mount_opts(struct mount_opts *mo);
> +unsigned int get_max_read(struct mount_opts *o);
> +char *fuse_mnt_build_source(const struct mount_opts *mo);
> +char *fuse_mnt_build_type(const struct mount_opts *mo);
> +
> +
> +#endif /* FUSE_MOUNT_COMMON_I_H_ */
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..abcd1b08012feedef6b4c8961b55ac847a27496a
> --- /dev/null
> +++ b/lib/mount_i_linux.h
> @@ -0,0 +1,32 @@
> +/*
> + *  FUSE: Filesystem in Userspace
> + *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> + *                2026 Bernd Schubert <bernd@bsbernd.com>
> + *
> + *  This program can be distributed under the terms of the GNU LGPLv2.
> + *  See the file LGPL2.txt
> + */
> +
> +#ifndef FUSE_MOUNT_I_H_
> +#define FUSE_MOUNT_I_H_
> +
> +/* Forward declaration for fuse_args */
> +struct fuse_args;
> +
> +/* Mount options structure */
> +struct mount_opts {
> +	int allow_other;
> +	int flags;
> +	int auto_unmount;
> +	int blkdev;
> +	char *fsname;
> +	char *subtype;
> +	char *subtype_opt;
> +	char *mtab_opts;
> +	char *fusermount_opts;
> +	char *kernel_opts;
> +	unsigned int max_read;
> +};
> +
> +
> +#endif /* FUSE_MOUNT_I_H_ */
> diff --git a/lib/mount_util.c b/lib/mount_util.c
> index 8c0cdf72d978da68c95125964416b92668104924..a42a02a0b92f98778abb2c491cdc7a01260f56ee 100644
> --- a/lib/mount_util.c
> +++ b/lib/mount_util.c
> @@ -375,3 +375,27 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint)
>  
>  	return -1;
>  }
> +
> +int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
> +			       const char *type, const char *mnt_opts)
> +{
> +#ifndef IGNORE_MTAB
> +	if (geteuid() == 0) {
> +		char *newmnt = fuse_mnt_resolve_path("fuse", mnt);
> +		int res;
> +
> +		if (!newmnt)
> +			return -1;
> +
> +		res = fuse_mnt_add_mount("fuse", source, newmnt, type,
> +					 mnt_opts);
> +		free(newmnt);
> +		return res;
> +	}
> +#endif
> +	(void)mnt;
> +	(void)source;
> +	(void)type;
> +	(void)mnt_opts;
> +	return 0;
> +}
> diff --git a/lib/mount_util.h b/lib/mount_util.h
> index 9cb9077dd177381d712e34e7118bf73572142c6a..4688d00091f001b3ccd36b1ef3b7e799031ed773 100644
> --- a/lib/mount_util.h
> +++ b/lib/mount_util.h
> @@ -7,6 +7,7 @@
>  */
>  
>  #include <sys/types.h>
> +#include "mount_common_i.h" // IWYU pragma: keep
>  
>  int fuse_mnt_add_mount(const char *progname, const char *fsname,
>  		       const char *mnt, const char *type, const char *opts);
> @@ -16,3 +17,8 @@ int fuse_mnt_umount(const char *progname, const char *abs_mnt,
>  char *fuse_mnt_resolve_path(const char *progname, const char *orig);
>  int fuse_mnt_check_fuseblk(void);
>  int fuse_mnt_parse_fuse_fd(const char *mountpoint);
> +
> +/* Helper functions for mount operations */
> +const char *fuse_mnt_get_devname(void);
> +int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
> +			       const char *type, const char *mnt_opts);
> 
> -- 
> 2.43.0
> 
> 
