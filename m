Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79937D122
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305368; cv=none; b=mlcbyD8Ncs9wkpSHRqT4pltI5yLHZ5uvOruDn71usqtyKZOZn0rf5Fq1H95nVsPoMugdpVnL0q+ji/rHMe8QzlJws0mQ+qvKWnHsR2LJvdxzBOZlk0GTWgv5fiI0DRA7pS8JaNlUQCSlWG2HyZYG4EpvkX9i/ucjgtTjqkZ99go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305368; c=relaxed/simple;
	bh=cqDTK4YiNnz4tACq/2etx4m2QCOenCbYklrUsXgRnow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJzkQZZfTiPPH90isMftoaupip0wQmpuRf40vRCrSh9z2zyDgn/dHLgeWepSnOcz1aBVlxQpt4dJpbFsy50yU0Ac9HFutL4YF1zHa81vGlwWKoGi8O94Iso7Uf1cZaoIEG1JY68M1onRkeUZBa/qRVPpn4XRBHzCCJrrRjG6KUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB6jKup6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB6jKup6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B92DC4CEF7;
	Mon, 23 Mar 2026 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774305368;
	bh=cqDTK4YiNnz4tACq/2etx4m2QCOenCbYklrUsXgRnow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IB6jKup6Pk4aPdvoEeiXfAz21/U21rJbkDZTDe2XeHOP9+FJsfb/wgpuf0OTUFBDT
	 qY7lLIsyh3QV52PpsPSUSYbS2NTLSCQCzDrSZzf/ZW8rkLsEpPrLWjEEHyhzp6BKWd
	 AgW3M1orgQkOquff/4v9FC/zYwJWKP/HL/Vdum6pJp/QBw7QwWl9E39BJJAdjaVDmb
	 tscfmuxmMmwyezW/Su3fnM0KEGp9KrENaIyQwiCTh5tDonBOwwnghXg4tth/2meTke
	 +o7f2QGNUKFUvPxCY2CNwOTAnvdpxk9G1Ze1cqiwqi5IdMuFcSbHFAPq9lyr7k04al
	 DXjjBz5epNT7Q==
Date: Mon, 23 Mar 2026 15:36:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 07/19] Add FUSE_MOUNT_FALLBACK_NEEDED define for -2 mount
 errors
Message-ID: <20260323223607.GI6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-7-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-7-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:02PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Magic numbers in the code are not good - we better use a define.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  lib/fuse_i.h | 3 +++
>  lib/mount.c  | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 9e3c5dc5021e210a2778e975a37ab609af324010..b4c1d3eef41010287f6c9555ec0b2442d904d192 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -217,6 +217,9 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
>   */
>  void fuse_chan_put(struct fuse_chan *ch);
>  
> +/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
> +#define FUSE_MOUNT_FALLBACK_NEEDED -2

...and you might want to put that in parentheses to avoid weird
interactions elsewhere.  Or maybe just make fuse_kern_do_mount return an
enum so that callers have to handle FUSE_MOUNT_{OK,FAIL,FALLBACK} and
can do so via switch statements?

--D

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
