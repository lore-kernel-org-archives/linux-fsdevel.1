Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0A36894B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581660; cv=none; b=cHwV+S2IARC/mPIqTJqvOJeUgiNXnPtwPD21HuJCMu0cdgqYiELE9AENvG80GHRtJ65fux8YzR799Z3Dbmy31vVRvu5MNP0OXbNLtFAJa37Fo38KI2hOtffAy2ZKMLfpvUgP3S0pOhuW5VTEU6HD1ZRW5eXLM+Ar1NA2ZAkuBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581660; c=relaxed/simple;
	bh=z9tynRgSNYjEAk+tjMV/sy/gMQWqQii2+6RwSTTC4po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7Qftfw39mf4VBuVG60gH/42X0xeXb5cAHhF7WRsYP25tAI7Cag+bwL/VT0rFtCj1qfFTo+3ozHRq3NGu8+LYA/flbH6Tv1OGYyx8xnhYUfw4L8eqB/7yKeu+/fB/X2NWUdWLSjpQ6q/e/yHvke/jpsQ9Xc/zsG+a+A0oGSnthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxFyXXQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxFyXXQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73065C116C6;
	Fri, 27 Mar 2026 03:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581660;
	bh=z9tynRgSNYjEAk+tjMV/sy/gMQWqQii2+6RwSTTC4po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxFyXXQ5GuNrJyka+baBwRVLV9cVng9uN8en/0gBDbVcAmTkNQLMn3azZMDmeT/Rr
	 +gMUUClcF/7ftoAD8PQh4aF1EI4fj0Jo/fanm8B5u7f41S7frTvS9MApJVTSn2u3A8
	 HEh2BNhkVJ2xmw3DllKZq0xFL8lOAEW9DAgjE9DATxLeG/vbKFMpFVT2YW9NoDoAgx
	 KXPJcUbH2uxKlmExEyIvSBLTtYHlcRPxs1TQisXosR9fHIhZNCgTrGsUPSx/cgdL3A
	 sYnaRn5vgBTPY/WihRcnQQhJr6sFnl4Y1R2m9zgmgiZOXJ7N0dQLJuIjCL3MQeolZo
	 YnMRaHo17xtCQ==
Date: Thu, 26 Mar 2026 20:20:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 07/25] Add FUSE_MOUNT_FALLBACK_NEEDED define for -2
 mount errors
Message-ID: <20260327032059.GK6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-7-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-7-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:40PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Magic numbers in the code are not good - we better use a define.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Looks good now!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/fuse_i.h | 3 +++
>  lib/mount.c  | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 9e3c5dc5021e210a2778e975a37ab609af324010..a2438a15afdd3b5f62dd35bc3514f9f6853f00c3 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -217,6 +217,9 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
>   */
>  void fuse_chan_put(struct fuse_chan *ch);
>  
> +/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
> +#define FUSE_MOUNT_FALLBACK_NEEDED (-2)
> +
>  struct mount_opts *parse_mount_opts(struct fuse_args *args);
>  void destroy_mount_opts(struct mount_opts *mo);
>  void fuse_mount_version(void);
> diff --git a/lib/mount.c b/lib/mount.c
> index 6e404451cc9edc8e35434cc31f25612cfc4edca1..dec9d52274c13536648cacef959789f472c5682c 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -563,7 +563,7 @@ out_close:
>   * @mo: mount options
>   * @mnt_opts: mount options to pass to the kernel
>   *
> - * Returns: 0 on success, -1 on failure, -2 if fusermount should be used
> + * Returns: 0 on success, -1 on failure, FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
>   */
>  static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
>  				  const char *mnt_opts)
> @@ -611,7 +611,7 @@ static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
>  		 * case try falling back to fusermount3
>  		 */
>  		if (errno == EPERM) {
> -			res = -2;
> +			res = FUSE_MOUNT_FALLBACK_NEEDED;
>  		} else {
>  			int errno_save = errno;
>  			if (mo->blkdev && errno == ENODEV &&
> @@ -749,7 +749,7 @@ int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
>  			umount2(mountpoint, MNT_DETACH); /* lazy umount */
>  			res = -1;
>  		}
> -	} else if (res == -2) {
> +	} else if (res == FUSE_MOUNT_FALLBACK_NEEDED) {
>  		if (mo->fusermount_opts &&
>  		    fuse_opt_add_opt(&mnt_opts, mo->fusermount_opts) == -1)
>  			goto out;
> 
> -- 
> 2.43.0
> 
> 
