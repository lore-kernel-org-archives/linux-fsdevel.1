Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07738237B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305931; cv=none; b=lOIvgOlsO4gtWoX1KiTuP6tVg++O+ntBCV9Y6xUVeG5qaoaS1WPdWGxA2DMa2NnmSnf6g5RbBPWVzRmMK6IVUl+2IFCHkLDtQLOqTodXwIwGZXenxrhyi064DSOubqNbrUfH+9Zy3HMNOUXXFcVLSX4/AoU6O2/TNadHrL6QbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305931; c=relaxed/simple;
	bh=ElFV7YL2mYhF81PBir21rPp2tuIoUIGXBqM2ev58jTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYxB04WOqzC73n+H2u+aFT15uxrbMBrjdBkPRvUoHN79LLIt7ckLckLxBvVY6pMw4ou6vrUvHTH09ZR5TF86R1GM0fdDR0+LQXKqnUqqRkom8VFB52mx7gd8wXC+TMjPLQhb3api///wFTQTz/QTq8zA76vFgh6FJ4ZHePhvviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqEQcxzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqEQcxzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81645C4CEF7;
	Mon, 23 Mar 2026 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774305930;
	bh=ElFV7YL2mYhF81PBir21rPp2tuIoUIGXBqM2ev58jTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqEQcxzfSKNE8KunY+ZKVx8n45kAtIk+1siFbGDfg2m2A2/8TIyf9uMeV0FsfdaLV
	 ESNGnYuvSdTQl+NyxEdATR3LLR1mL3kfnKZQCru32610QnvLRnai65x6MpJ+gbl6z1
	 iTffrnolzZ9MbcW6Vhh4WDuSdcm6vapYkvevS0OINRfsCxRSBjtJt/L1RzVKIaJ9tv
	 gLG9S/uusI3fhh0mWl5URd3VdxC5IaMy8mz1N7m/3cbcOg6JpsZrzP/GWYGMLvd/LH
	 0Lv27Y4X8Re0EMJ624qaj8DPbRqEu/qn8WVsg4XS71Ia9KC1wYl8SYu5QWpZcg/jm0
	 aS5gAdnIQMYoQ==
Date: Mon, 23 Mar 2026 15:45:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 09/19] Move mount flags to mount_i.h
Message-ID: <20260323224529.GK6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-9-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-9-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:04PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This is preparation work for the new mount API, which goes into
> its own file.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  lib/mount.c         | 59 ++++++++---------------------------------------------
>  lib/mount_i_linux.h | 35 ++++++++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 52 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index fe353e2cc4579adb47473cac5db7d1bae2defb2c..b3ee9ba4c0a74c1d0d55f916e7046e064f8468b0 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -34,16 +34,6 @@
>  #include "fuse_mount_compat.h"
>  
>  #ifdef __NetBSD__

Hopefully the rest of the bsd stuff can go in its own files too?

> -#include <perfuse.h>
> -
> -#define MS_RDONLY	MNT_RDONLY
> -#define MS_NOSUID	MNT_NOSUID
> -#define MS_NODEV	MNT_NODEV
> -#define MS_NOEXEC	MNT_NOEXEC
> -#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
> -#define MS_NOATIME	MNT_NOATIME
> -#define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
> -
>  #define umount2(mnt, flags) unmount(mnt, (flags == 2) ? MNT_FORCE : 0)
>  #endif
>  
> @@ -51,10 +41,6 @@
>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
>  
> -#ifndef MS_DIRSYNC
> -#define MS_DIRSYNC 128
> -#endif
> -
>  enum {
>  	KEY_KERN_FLAG,
>  	KEY_KERN_OPT,
> @@ -154,35 +140,6 @@ void fuse_mount_version(void)
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
> -#ifndef __NetBSD__
> -	{"dirsync", MS_DIRSYNC,	    1},
> -#endif
> -	{NULL,	    0,		    0}
> -};
> -
>  unsigned int get_max_read(struct mount_opts *o)
>  {
>  	return o->max_read;
> @@ -192,13 +149,13 @@ static void set_mount_flag(const char *s, int *flags)
>  {
>  	int i;
>  
> -	for (i = 0; mount_flags[i].opt != NULL; i++) {
> -		const char *opt = mount_flags[i].opt;
> +	for (i = 0; fuse_mount_flags[i].opt != NULL; i++) {
> +		const char *opt = fuse_mount_flags[i].opt;
>  		if (strcmp(opt, s) == 0) {
> -			if (mount_flags[i].on)
> -				*flags |= mount_flags[i].flag;
> +			if (fuse_mount_flags[i].on)
> +				*flags |= fuse_mount_flags[i].flag;
>  			else
> -				*flags &= ~mount_flags[i].flag;
> +				*flags &= ~fuse_mount_flags[i].flag;
>  			return;
>  		}
>  	}
> @@ -645,9 +602,9 @@ static int get_mnt_flag_opts(char **mnt_optsp, int flags)
>  	if (!(flags & MS_RDONLY) && fuse_opt_add_opt(mnt_optsp, "rw") == -1)
>  		return -1;
>  
> -	for (i = 0; mount_flags[i].opt != NULL; i++) {
> -		if (mount_flags[i].on && (flags & mount_flags[i].flag) &&
> -		    fuse_opt_add_opt(mnt_optsp, mount_flags[i].opt) == -1)
> +	for (i = 0; fuse_mount_flags[i].opt != NULL; i++) {
> +		if (fuse_mount_flags[i].on && (flags & fuse_mount_flags[i].flag) &&
> +		    fuse_opt_add_opt(mnt_optsp, fuse_mount_flags[i].opt) == -1)
>  			return -1;
>  	}
>  	return 0;
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> index abcd1b08012feedef6b4c8961b55ac847a27496a..c0de6228fce5a4d9070cc246ec76222b66de56fb 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -10,7 +10,8 @@
>  #ifndef FUSE_MOUNT_I_H_
>  #define FUSE_MOUNT_I_H_
>  
> -/* Forward declaration for fuse_args */
> +#include <sys/mount.h>
> +
>  struct fuse_args;
>  
>  /* Mount options structure */
> @@ -28,5 +29,37 @@ struct mount_opts {
>  	unsigned int max_read;
>  };
>  
> +/* Mount flags mapping structure */
> +struct mount_flags {
> +	const char *opt;
> +	unsigned long flag;
> +	int on;
> +};
> +
> +/* Mount flags table */
> +static const struct mount_flags fuse_mount_flags[] = {

Hmmm, doesn't this create a fuse_mount_flags[] in every single .o file
that #includes this header?  I'd have thought you'd want an extern
declaration here and a definition elsewhere?

> +	{"rw",			MS_RDONLY,      0},
> +	{"ro",			MS_RDONLY,      1},
> +	{"suid",		MS_NOSUID,      0},
> +	{"nosuid",		MS_NOSUID,      1},
> +	{"dev",			MS_NODEV,       0},
> +	{"nodev",		MS_NODEV,       1},
> +	{"exec",		MS_NOEXEC,      0},
> +	{"noexec",		MS_NOEXEC,      1},
> +	{"async",		MS_SYNCHRONOUS, 0},
> +	{"sync",		MS_SYNCHRONOUS, 1},
> +	{"noatime",		MS_NOATIME,     1},
> +	{"nodiratime",		MS_NODIRATIME,  1},
> +	{"norelatime",		MS_RELATIME,    0},
> +	{"nostrictatime",	MS_STRICTATIME, 0},
> +	{"symfollow",		MS_NOSYMFOLLOW, 0},
> +	{"nosymfollow",		MS_NOSYMFOLLOW, 1},
> +#ifndef __NetBSD__

When would we have __NetBSD__ defined on a Linux build?

Though I see no meson.build changes here, so I can't tell if
mount_i_linux.c only gets built on Linux or everywhere or ...?

--D

> +	{"dirsync", MS_DIRSYNC,     1},
> +#endif
> +	{NULL,      0,          0}
> +};
> +
> +
>  
>  #endif /* FUSE_MOUNT_I_H_ */
> 
> -- 
> 2.43.0
> 
> 
