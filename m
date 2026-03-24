Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F74A32
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310815; cv=none; b=T2lS776XazFWFDTdi/Nf+4Gh6v7SUdFDB8p9dnkk3BPBJa0Eur24zu75DEcYWQURu62UqPZrGSn895zI5+lmsE68wo8UvwQh0izyZAR0ptVoD7OlohN6IWuiLr2GbbuMk6kTGjLltaOkUJ/DEBBPCFJyb1mloWQMS4qkv4FHUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310815; c=relaxed/simple;
	bh=BOl2YQdZ68c+LZjvc3YtWKMzAyQiEJbammLoLtpRnXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2zTIIHCVQ3ulBIHCfxXc5fhvnyCsWzr6ECYDy/vcyOMdydCfNnmxrOoTwkoETKAW/A+a+PgIBXb902zOu0EF7Rj1HDw82W6UoyLyMqsgwcgJmzy+gH67diDUs0G2IfgmZgmrB5par31lLht42P+mhqnJy8ZD28VFekAUp4chdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anKVhUsN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anKVhUsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1300C4CEF7;
	Tue, 24 Mar 2026 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310814;
	bh=BOl2YQdZ68c+LZjvc3YtWKMzAyQiEJbammLoLtpRnXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anKVhUsNaW2WuHCCkE3miJEqAQ86ig056kP5sSGa9R5biOrFdTuS1gIrsiVg6IbG9
	 zhbYD3nF8UgU6v4OfFO3tcw9zVdZw+U6yeeCdyC4MGwFkb/SaPUgy19Ddyhz0vYj6z
	 tz63JJoYRGJkBaj1E3DggdGXfeF97WqXOE2GuMTsIp2szJfxt9AEU5kw8mAG2FxUi2
	 R55Dg0+YahN6+0YK+MVjopnGk620UeTYHTYja9rFQhUliu/nnBWisz4DYYr0UU+ssg
	 kdKMTnr8+j0tcmxX59Fu1XxepPyRzAfo4MjcbVEyPS3EWvDdmlWS5AI7p/beW/8K7B
	 yGKVvfZTcW5ww==
Date: Mon, 23 Mar 2026 17:06:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 14/19] Move more generic mount code to mount_util.{c,h}
Message-ID: <20260324000654.GO6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-14-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-14-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:09PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This is to allow fusermount to use the code from mount_fsmount.c.
> I.e. avoid code dup and add just re-use the new linux api mount
> functions from that file for fusermount.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  lib/mount.c          |  7 -------
>  lib/mount_common_i.h |  2 --
>  lib/mount_i_linux.h  |  3 ++-
>  lib/mount_util.c     | 10 ++++++++++
>  lib/mount_util.h     |  5 +++++
>  5 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index 12df49d9109cf918cc41aa75c5fdf84231d4d5ff..263b05051c236458b830c40181bce7f494803800 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -720,13 +720,6 @@ out:
>  	return res;
>  }
>  
> -const char *fuse_mnt_get_devname(void)
> -{
> -	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
> -
> -	return devname ? devname : "/dev/fuse";
> -}
> -
>  char *fuse_mnt_build_source(const struct mount_opts *mo)
>  {
>  	const char *devname = fuse_mnt_get_devname();
> diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
> index d27d2aa624ae3806c61a0fe382c2d024080c9bb3..b015e8f98d46980891216e93358aae9f7836d156 100644
> --- a/lib/mount_common_i.h
> +++ b/lib/mount_common_i.h
> @@ -24,8 +24,6 @@ struct mount_opts;
>  struct mount_opts *parse_mount_opts(struct fuse_args *args);
>  void destroy_mount_opts(struct mount_opts *mo);
>  unsigned int get_max_read(struct mount_opts *o);
> -char *fuse_mnt_build_source(const struct mount_opts *mo);
> -char *fuse_mnt_build_type(const struct mount_opts *mo);
>  
>  
>  #endif /* FUSE_MOUNT_COMMON_I_H_ */
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> index 52eab9e650c055142feec329264f82c2b08be0d5..867105019fa57576682091d1a650302f31e450b3 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -74,6 +74,7 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>  
>  int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>  			 const char *mnt_opts);
> -
> +char *fuse_mnt_build_source(const struct mount_opts *mo);
> +char *fuse_mnt_build_type(const struct mount_opts *mo);

These are linux-only things?  I thought they applied to BSD too and
should go in mount_util.h...

>  #endif /* FUSE_MOUNT_I_H_ */

...but I'm now terribly confused, is mount_i_linux.h just the symbols
needed to build on Linux, or to build anywhere?

> diff --git a/lib/mount_util.c b/lib/mount_util.c
> index a42a02a0b92f98778abb2c491cdc7a01260f56ee..6a7908cb74b429a1ffd811678cfd39c35093b265 100644
> --- a/lib/mount_util.c
> +++ b/lib/mount_util.c
> @@ -10,6 +10,9 @@
>  
>  #include "fuse_config.h"
>  #include "mount_util.h"
> +#ifdef __linux__
> +#include "mount_i_linux.h"
> +#endif
>  
>  #include <stdio.h>
>  #include <unistd.h>
> @@ -399,3 +402,10 @@ int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
>  	(void)mnt_opts;
>  	return 0;
>  }
> +
> +const char *fuse_mnt_get_devname(void)
> +{
> +	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
> +
> +	return devname ? devname : "/dev/fuse";
> +}
> diff --git a/lib/mount_util.h b/lib/mount_util.h
> index 4688d00091f001b3ccd36b1ef3b7e799031ed773..00397943a46a58e640d15b0c0531e5bc6e76006b 100644
> --- a/lib/mount_util.h
> +++ b/lib/mount_util.h
> @@ -6,6 +6,9 @@
>    See the file LGPL2.txt.
>  */
>  
> +#ifndef FUSE_MOUNT_UTIL_H_
> +#define FUSE_MOUNT_UTIL_H_

This is a positive development, at least :)

--D

> +
>  #include <sys/types.h>
>  #include "mount_common_i.h" // IWYU pragma: keep
>  
> @@ -22,3 +25,5 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint);
>  const char *fuse_mnt_get_devname(void);
>  int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
>  			       const char *type, const char *mnt_opts);
> +
> +#endif /* FUSE_MOUNT_UTIL_H_ */
> 
> -- 
> 2.43.0
> 
> 
