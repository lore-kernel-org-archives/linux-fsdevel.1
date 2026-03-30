Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7936BCC3
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896422; cv=none; b=uIWnCio90HmXU5b/tTzg81HqhsrreHvW8mf6JtFyww3MIbNS0/1t6/efVltvuVjdtXNkcTdXFJD4oDnAAM7a7JiS87bTX8mCLXwWUqaYKxxEX8kV+uQDzJV88TewcTuG5worSa9rcOfTfInMOPGVqkWKaervT5K9y4HQcknxFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896422; c=relaxed/simple;
	bh=BOflS6e/lKzYduBAVPppg3UALhWiGrBXZG3bnM+eX+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ6F2gANv9nG3JMM2e5ZSxN4rfDKKPZl+uCYnKI1m75A5v+PDOY9Uhd3AyPRSe/LJBlx8TrlYFJ8Lh1GUdUDG54uCd6t9kaI+3/dhVRzgp7BNNILTAyttxWfyaxbZfY8t1pOACbBaHJPrkWtZ8xpx0wRzpYgd6G+J3/9Kl+tYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv5ynbf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv5ynbf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E692C4CEF7;
	Mon, 30 Mar 2026 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774896421;
	bh=BOflS6e/lKzYduBAVPppg3UALhWiGrBXZG3bnM+eX+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv5ynbf/o2iExfNeM8tj9TqlBcmP3mk8foHhLSrAUpo/tqhSDPJFWaoxebOFfjqZ2
	 5Q/83kEtobPplAPEn0ynigfEeiw/4A30IBMOSpepIa+DoNewwKt5+svEiOkzaK8g/X
	 jWy0CXSw/bfQuoy7vTvNmMKdA7N2jE3X8vk4f+jckd7F/m72jGDA+qmsoebIjcii78
	 2KF01TZYPWp4IxTxqfWsk6ukImgLRJKc945iimOXeZ3WSW3nryf+Q+Q6H1cbwIxp1Y
	 57VLTstLm7d+Y1QXEybKhsxqD2lhjh/v48r2nNYIe4MArg8PKjfI17+uxnwgbn1XKn
	 TcpdJ/EaJAXgw==
Date: Mon, 30 Mar 2026 11:47:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 16/25] Move more generic mount code to mount_util.{c,h}
Message-ID: <20260330184701.GY6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-16-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-16-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:49PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This is to allow fusermount to use the code from mount_fsmount.c.
> I.e. avoid code dup and add just re-use the new linux api mount
> functions from that file for fusermount.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Looks good!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/mount.c          |  7 -------
>  lib/mount_common_i.h |  2 --
>  lib/mount_i_linux.h  |  4 ++--
>  lib/mount_util.c     | 10 ++++++++++
>  lib/mount_util.h     |  5 +++++
>  5 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index f19817e2675713e988bb91fc658c52b36468462b..408e9d36896048fc167e264c95b6f6e31d86679f 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -713,13 +713,6 @@ out:
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
> index 34f0f9893918a14c83a57a3212f80cfc96ed2e6d..fc9ab443cc0cf6cf8438dd2ca486f6e37c8704e6 100644
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
> index 34c7386715155e8640cac68c218a1e1062990ce6..597b380076fccc1d38fd4d0b9108fc92a1adfa62 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -41,6 +41,6 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>  			 const char *mnt_opts);
>  
> -int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
> -			 const char *mnt_opts);
> +char *fuse_mnt_build_source(const struct mount_opts *mo);
> +char *fuse_mnt_build_type(const struct mount_opts *mo);
>  #endif /* FUSE_MOUNT_I_LINUX_H_ */
> diff --git a/lib/mount_util.c b/lib/mount_util.c
> index 9ff711023fcb41fe24f1de21aaf811cb1c12d25e..b6b75e60874ae9b2ec0c96f2a62b4ec1943a2a00 100644
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
> @@ -451,3 +454,10 @@ int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
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
> index e62052b626875abd6118b845de162d6c5c41857a..b83db556d5fdb4bd8dd5e1750c8d11faf7373d82 100644
> --- a/lib/mount_util.h
> +++ b/lib/mount_util.h
> @@ -6,6 +6,9 @@
>    See the file LGPL2.txt.
>  */
>  
> +#ifndef FUSE_MOUNT_UTIL_H_
> +#define FUSE_MOUNT_UTIL_H_
> +
>  #include <sys/types.h>
>  #include "mount_common_i.h" // IWYU pragma: keep
>  
> @@ -31,3 +34,5 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint);
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
