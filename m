Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC743DE450
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894280; cv=none; b=SuvZYu5aESZvVfx/5IM38tPLSt1vynaMQUIalZZ6NhQwlGAZZ7rBT8emYzV1+ysR3gF1lKlTLP4WNMtZj5Zze0V4Lo98Hpma3BbYidTkVPJRhEfAyXatBJM71BOk4Ks2CBWLnfzWxYRUJuYi5H3k7F/FfypVCJwXJ9mw0HEU6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894280; c=relaxed/simple;
	bh=7uwEgoN/XHp0rIWbNcCGqZwvOph2jltSomHy0ioIi/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH5CVwTgD+wUEXMRYxeakK2PBYL8uLVs8eIQfeUeUIKCHEoOUWHqeF0OVJ2Z8I+pHBmULpo16JsCgylX3yWgG2l7ZqA/LZ4KGbLqhAnhJi2xaPh59dQ7a9cDQ56DsjeM198aveticFy2u6V3af+yuFoTziAkonL8GN9FE7HbToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFWtNhMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFWtNhMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37D7C2BC9E;
	Mon, 30 Mar 2026 18:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774894279;
	bh=7uwEgoN/XHp0rIWbNcCGqZwvOph2jltSomHy0ioIi/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFWtNhMTcg40ZdvwiJCpHenZgIgyaFTrZh1uYEJY8b7EBn2Q4FPwnJvQXVqSFu4lc
	 Sk8i70lsQWqmnYFWP4P5rCwgZSVCqgRQFWUDK/jeT8pZNAeEc2TZYI0sicUyaNWFZv
	 wHcbT4WMhaRhQ9QYdKm3QXrG15noBlydVqYOGi2gCtxL73rBH7nQBrV1z6So1JFO5T
	 rvl0WkgAqtX9XFNBBdWw6HduIoPAdzxqbpFr9ooPHJJwGY8AOyCTnjfUZIMhDHlJOD
	 GOBwFe+b1gQ9ShVZmlrNgnSfdymK1oG9xN2WB5uVlImKRHy0vpvKsHIK8JJfAgs4S6
	 2lDLQd/vdt/FQ==
Date: Mon, 30 Mar 2026 11:11:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 11/25] Move 'struct mount_flags' to util.h
Message-ID: <20260330181117.GU6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-11-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-11-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:44PM +0100, Bernd Schubert wrote:
> We actually need these in fusermount.c and for the
> new mount API, which goes into its own file.
> 
> Also extend the struct with the extra safe field
> used by fusermount.c
> 
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> ---
>  include/fuse_mount_compat.h |  5 +++++
>  lib/mount.c                 | 39 --------------------------------
>  lib/mount_bsd.c             |  1 +
>  lib/mount_i_linux.h         |  4 ++--
>  lib/mount_util.c            | 54 ++++++++++++++++++++++++++++++++++++++++++++-
>  lib/mount_util.h            |  9 ++++++++
>  util/fusermount.c           | 34 ----------------------------
>  7 files changed, 70 insertions(+), 76 deletions(-)
> 
> diff --git a/include/fuse_mount_compat.h b/include/fuse_mount_compat.h
> index be8d576cf959fba7acb25440fafd43f7e973964e..1b0eb00c3eb79ad2d58a9e86ac2836d3f7d3b2fb 100644
> --- a/include/fuse_mount_compat.h
> +++ b/include/fuse_mount_compat.h
> @@ -11,6 +11,9 @@
>  #ifndef FUSE_MOUNT_COMPAT_H_
>  #define FUSE_MOUNT_COMPAT_H_
>  
> +#if !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__DragonFly__) && \
> +	!defined(__FreeBSD_kernel__)
> +
>  #include <sys/mount.h>
>  
>  /* Some libc don't define MS_*, so define them manually
> @@ -46,4 +49,6 @@
>  #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
>  #endif
>  
> +#endif /* BSD */
> +
>  #endif /* FUSE_MOUNT_COMPAT_H_ */
> diff --git a/lib/mount.c b/lib/mount.c
> index 899cd2d0a13a9332a564b10d1c22836fb2cd1710..43920a06ac03747595bde95441252e9cac77ce88 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -33,18 +33,6 @@
>  
>  #include "fuse_mount_compat.h"
>  
> -#ifdef __NetBSD__
> -#include <perfuse.h>
> -
> -#define MS_RDONLY	MNT_RDONLY
> -#define MS_NOSUID	MNT_NOSUID
> -#define MS_NODEV	MNT_NODEV
> -#define MS_NOEXEC	MNT_NOEXEC
> -#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
> -#define MS_NOATIME	MNT_NOATIME
> -#define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
> -#endif
> -
>  #define FUSERMOUNT_PROG		"fusermount3"
>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
> @@ -147,33 +135,6 @@ void fuse_mount_version(void)
>  			 FUSERMOUNT_PROG);
>  }
>  
> -struct mount_flags {
> -	const char *opt;
> -	unsigned long flag;
> -	int on;
> -};
> -
> -static const struct mount_flags mount_flags[] = {
> -	{"rw",	    MS_RDONLY,	    0},
> -	{"ro",	    MS_RDONLY,	    1},
> -	{"suid",    MS_NOSUID,	    0},
> -	{"nosuid",  MS_NOSUID,	    1},
> -	{"dev",	    MS_NODEV,	    0},
> -	{"nodev",   MS_NODEV,	    1},
> -	{"exec",    MS_NOEXEC,	    0},
> -	{"noexec",  MS_NOEXEC,	    1},
> -	{"async",   MS_SYNCHRONOUS, 0},
> -	{"sync",    MS_SYNCHRONOUS, 1},
> -	{"noatime", MS_NOATIME,	    1},
> -	{"nodiratime",	    MS_NODIRATIME,	1},
> -	{"norelatime",	    MS_RELATIME,	0},
> -	{"nostrictatime",   MS_STRICTATIME,	0},
> -	{"symfollow",	    MS_NOSYMFOLLOW,	0},
> -	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
> -	{"dirsync",	    MS_DIRSYNC,	    1},
> -	{NULL,	    0,		    0}
> -};
> -
>  unsigned int get_max_read(struct mount_opts *o)
>  {
>  	return o->max_read;
> diff --git a/lib/mount_bsd.c b/lib/mount_bsd.c
> index c5b831160f826c0e4620626a72c4b93427d18bab..09631932eff443d21743dd55dcd5345dd581227f 100644
> --- a/lib/mount_bsd.c
> +++ b/lib/mount_bsd.c
> @@ -16,6 +16,7 @@
>  #include "util.h"
>  
>  #include <sys/param.h>
> +#include <sys/mount.h>
>  #include "fuse_mount_compat.h"
>  
>  #include <sys/wait.h>
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> index 254b75151f35578ce22197776e6fa4aceb04150e..1bfc78b32dc4fd434870e4fff1a37e0c340d207e 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -10,7 +10,8 @@
>  #ifndef FUSE_MOUNT_I_LINUX_H_
>  #define FUSE_MOUNT_I_LINUX_H_
>  
> -/* Forward declaration for fuse_args */
> +#include <sys/mount.h>
> +
>  struct fuse_args;
>  
>  /* Mount options structure */
> @@ -28,5 +29,4 @@ struct mount_opts {
>  	unsigned int max_read;
>  };
>  
> -
>  #endif /* FUSE_MOUNT_I_LINUX_H_ */
> diff --git a/lib/mount_util.c b/lib/mount_util.c
> index a42a02a0b92f98778abb2c491cdc7a01260f56ee..9ff711023fcb41fe24f1de21aaf811cb1c12d25e 100644
> --- a/lib/mount_util.c
> +++ b/lib/mount_util.c
> @@ -34,9 +34,61 @@
>  #include <sys/param.h>
>  
>  #if defined(__NetBSD__) || defined(__FreeBSD__) || defined(__DragonFly__) || defined(__FreeBSD_kernel__)
> -#define umount2(mnt, flags) unmount(mnt, ((flags) == 2) ? MNT_FORCE : 0)
> +#include <sys/mount.h>
> +#ifdef __NetBSD__
> +#include <perfuse.h>
>  #endif
>  
> +#define umount2(mnt, flags) unmount(mnt, ((flags) == 2) ? MNT_FORCE : 0)
> +
> +#define MS_RDONLY	MNT_RDONLY
> +#define MS_NOSUID	MNT_NOSUID
> +#ifdef MNT_NODEV
> +#define MS_NODEV	MNT_NODEV
> +#else
> +#define MS_NODEV	0
> +#endif
> +#define MS_NOEXEC	MNT_NOEXEC
> +#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
> +#define MS_NOATIME	MNT_NOATIME
> +#define MS_NOSYMFOLLOW	0
> +#define MS_DIRSYNC	0
> +
> +/* BSD doesn't have these, define as 0 */
> +#ifndef MS_NODIRATIME
> +#define MS_NODIRATIME 0
> +#endif
> +#ifndef MS_RELATIME
> +#define MS_RELATIME 0
> +#endif
> +#ifndef MS_STRICTATIME
> +#define MS_STRICTATIME 0
> +#endif
> +
> +#endif /* BSD */
> +
> +/* XXX This table is duplicated in util/fusermount.c */

Doesn't this patch remove this from fusermount.c?  I think the comment
is wrong and can be deleted.

--D

> +const struct mount_flags mount_flags[] = {
> +	{"rw",	    MS_RDONLY,	    0, 1},
> +	{"ro",	    MS_RDONLY,	    1, 1},
> +	{"suid",    MS_NOSUID,	    0, 0},
> +	{"nosuid",  MS_NOSUID,	    1, 1},
> +	{"dev",	    MS_NODEV,	    0, 1},
> +	{"nodev",   MS_NODEV,	    1, 1},
> +	{"exec",    MS_NOEXEC,	    0, 1},
> +	{"noexec",  MS_NOEXEC,	    1, 1},
> +	{"async",   MS_SYNCHRONOUS, 0, 1},
> +	{"sync",    MS_SYNCHRONOUS, 1, 1},
> +	{"noatime", MS_NOATIME,	    1, 1},
> +	{"nodiratime",	    MS_NODIRATIME,	1, 1},
> +	{"norelatime",	    MS_RELATIME,	0, 1},
> +	{"nostrictatime",   MS_STRICTATIME,	0, 1},
> +	{"symfollow",	    MS_NOSYMFOLLOW,	0, 1},
> +	{"nosymfollow",	    MS_NOSYMFOLLOW,	1, 1},
> +	{"dirsync",	    MS_DIRSYNC,		1, 1},
> +	{NULL,	    0,		    0, 0}
> +};
> +
>  #ifdef IGNORE_MTAB
>  #define mtab_needs_update(mnt) 0
>  #else
> diff --git a/lib/mount_util.h b/lib/mount_util.h
> index 4688d00091f001b3ccd36b1ef3b7e799031ed773..e62052b626875abd6118b845de162d6c5c41857a 100644
> --- a/lib/mount_util.h
> +++ b/lib/mount_util.h
> @@ -9,6 +9,15 @@
>  #include <sys/types.h>
>  #include "mount_common_i.h" // IWYU pragma: keep
>  
> +/* Mount flags mapping structure */
> +struct mount_flags {
> +	const char *opt;
> +	unsigned long flag;
> +	int on;
> +	int safe; /* used by fusermount */
> +};
> +extern const struct mount_flags mount_flags[];
> +
>  int fuse_mnt_add_mount(const char *progname, const char *fsname,
>  		       const char *mnt, const char *type, const char *opts);
>  int fuse_mnt_remove_mount(const char *progname, const char *mnt);
> diff --git a/util/fusermount.c b/util/fusermount.c
> index f17b44f51142c682b339d0ce2287f7c00d644454..f66c4e8e0e809351384ec10cf50ba4d3d3a831b0 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -759,40 +759,6 @@ static int begins_with(const char *s, const char *beg)
>  		return 0;
>  }
>  
> -struct mount_flags {
> -	const char *opt;
> -	unsigned long flag;
> -	int on;
> -	int safe;
> -};
> -
> -static struct mount_flags mount_flags[] = {
> -	{"rw",	    MS_RDONLY,	    0, 1},
> -	{"ro",	    MS_RDONLY,	    1, 1},
> -	{"suid",    MS_NOSUID,	    0, 0},
> -	{"nosuid",  MS_NOSUID,	    1, 1},
> -	{"dev",	    MS_NODEV,	    0, 0},
> -	{"nodev",   MS_NODEV,	    1, 1},
> -	{"exec",    MS_NOEXEC,	    0, 1},
> -	{"noexec",  MS_NOEXEC,	    1, 1},
> -	{"async",   MS_SYNCHRONOUS, 0, 1},
> -	{"sync",    MS_SYNCHRONOUS, 1, 1},
> -	{"atime",   MS_NOATIME,	    0, 1},
> -	{"noatime", MS_NOATIME,	    1, 1},
> -	{"diratime",        MS_NODIRATIME,  0, 1},
> -	{"nodiratime",      MS_NODIRATIME,  1, 1},
> -	{"lazytime",        MS_LAZYTIME,    1, 1},
> -	{"nolazytime",      MS_LAZYTIME,    0, 1},
> -	{"relatime",        MS_RELATIME,    1, 1},
> -	{"norelatime",      MS_RELATIME,    0, 1},
> -	{"strictatime",     MS_STRICTATIME, 1, 1},
> -	{"nostrictatime",   MS_STRICTATIME, 0, 1},
> -	{"dirsync", MS_DIRSYNC,	    1, 1},
> -	{"symfollow",       MS_NOSYMFOLLOW, 0, 1},
> -	{"nosymfollow",     MS_NOSYMFOLLOW, 1, 1},
> -	{NULL,	    0,		    0, 0}
> -};
> -
>  static int find_mount_flag(const char *s, unsigned len, int *on, int *flag)
>  {
>  	int i;
> 
> -- 
> 2.43.0
> 
> 
