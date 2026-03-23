Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66F382363
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305255; cv=none; b=NMH2jwrQqvWrWDQIyoKYM7sk70KfzrRIfwNukuYH0idFf0MsBhL7uVb8qcJjpHoSO3+wS4aZ2nngvLEyzv5BrqmFmaqD1H62cSbtCYKduIWG18gWFMopEnJnEyO2jdXRZyOn2G0W6njaPs3q8mBGvgeDRtE1nJBVVyFcl5QH9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305255; c=relaxed/simple;
	bh=e+ZE0v1zZ1uZ/PQ1eMHCcNVd8v2NTN7EySUHW3JrPcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHFOYUFGGy6KW4Cck6k33gphdLT4Gm/eK27tlpZ90QWHFt/BTFaq3uF9hZGivtjY3JsV8qn+8frLpOGMREnsGAT+zsYzLYbDMh2MkD16JT2MgcEbvpmV5+0uuQRq27WOXqAlyXNbH69ILnEReLId6ZpSk6D7fr3mae/u+b4kmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTDYXTzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTDYXTzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFBEC4CEF7;
	Mon, 23 Mar 2026 22:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774305254;
	bh=e+ZE0v1zZ1uZ/PQ1eMHCcNVd8v2NTN7EySUHW3JrPcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTDYXTzPuJ3GLz3I7I8G6y8j79j22JzIR57iwicfoK02hn48A7o7/Nr9lXIbLt4rR
	 Sf34TXhA/fxwY97kELj9SpIcCVEog9ivJIpaLhSfD1p4/fhIIFTJ8sYj9y6A04Nc/n
	 P5CBfWwd16E1PnWQgNFBXH6vw3Zi71hUkHtyMwdNAa+4JX37inhMIgDHRYnxzDGrqX
	 G6j/iyrOn9atMtLEUH+tRj03Di+jY0NUgUv8lPWbLSPL3KigcLVJQxzSZTPKvdyl1y
	 nFDGqLbGkReS84loWhRaYJOQcFsVvQt8hvOsbC2unBXaeH4ZNJK4juvn3JJlLFjiAt
	 at3Wym2+l/eXA==
Date: Mon, 23 Mar 2026 15:34:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 06/19] mount.c: Split fuse_mount_sys to prepare
 privileged sync FUSE_INIT
Message-ID: <20260323223414.GH6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-6-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-6-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:01PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Synchronous FUSE_INIT needs to spawn a worker thread to handle
> FUSE_INIT before starting the mount. For that it needs to have
> the device file descriptor - this is preparation work and
> fuse_mount_sys() is split into fuse_kern_mount_prepare()
> and fuse_kern_do_mount().
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

This looks like a reasonable slice-and-dice, though it's a noisier
change with the whitespace rearranging that goes on in the new
fuse_kern_mount_prepare function.  Assuming that's checkpatch and
that you're ok with that,

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/mount.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index 398bf9e7a86743ac3c99f0cc2975e8db92346013..6e404451cc9edc8e35434cc31f25612cfc4edca1 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -506,13 +506,11 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>  #define O_CLOEXEC 0
>  #endif
>  
> -static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
> -			  const char *mnt_opts)
> +static int fuse_kern_mount_prepare(const char *mnt,
> +				   struct mount_opts *mo)
>  {
>  	char tmp[128];
>  	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
> -	char *source = NULL;
> -	char *type = NULL;
>  	struct stat stbuf;
>  	int fd;
>  	int res;
> @@ -524,32 +522,58 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
>  
>  	res = stat(mnt, &stbuf);
>  	if (res == -1) {
> -		fuse_log(FUSE_LOG_ERR, "fuse: failed to access mountpoint %s: %s\n",
> -			mnt, strerror(errno));
> +		fuse_log(FUSE_LOG_ERR,
> +			 "fuse: failed to access mountpoint %s: %s\n", mnt,
> +			 strerror(errno));
>  		return -1;
>  	}
>  
>  	fd = open(devname, O_RDWR | O_CLOEXEC);
>  	if (fd == -1) {
>  		if (errno == ENODEV || errno == ENOENT)
> -			fuse_log(FUSE_LOG_ERR,
> +			fuse_log(
> +				FUSE_LOG_ERR,
>  				"fuse: device %s not found. Kernel module not loaded?\n",
>  				devname);
>  		else
>  			fuse_log(FUSE_LOG_ERR, "fuse: failed to open %s: %s\n",
> -				devname, strerror(errno));
> +				 devname, strerror(errno));
>  		return -1;
>  	}
>  	if (!O_CLOEXEC)
>  		fcntl(fd, F_SETFD, FD_CLOEXEC);
>  
> -	snprintf(tmp, sizeof(tmp),  "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
> +	snprintf(tmp, sizeof(tmp), "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
>  		 fd, stbuf.st_mode & S_IFMT, getuid(), getgid());
>  
>  	res = fuse_opt_add_opt(&mo->kernel_opts, tmp);
>  	if (res == -1)
>  		goto out_close;
>  
> +	return fd;
> +
> +out_close:
> +	close(fd);
> +	return -1;
> +}
> +
> +/**
> + * Complete the mount operation with an already-opened fd
> + * @mnt: mountpoint
> + * @mo: mount options
> + * @mnt_opts: mount options to pass to the kernel
> + *
> + * Returns: 0 on success, -1 on failure, -2 if fusermount should be used
> + */
> +static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
> +				  const char *mnt_opts)
> +{
> +	const char *devname = getenv(FUSE_KERN_DEVICE_ENV) ?: "/dev/fuse";
> +	char *source = NULL;
> +	char *type = NULL;
> +	int res;
> +
> +	res = -ENOMEM;
>  	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
>  			(mo->subtype ? strlen(mo->subtype) : 0) +
>  			strlen(devname) + 32);
> @@ -593,10 +617,11 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
>  			if (mo->blkdev && errno == ENODEV &&
>  			    !fuse_mnt_check_fuseblk())
>  				fuse_log(FUSE_LOG_ERR,
> -					"fuse: 'fuseblk' support missing\n");
> +					 "fuse: 'fuseblk' support missing\n");
>  			else
> -				fuse_log(FUSE_LOG_ERR, "fuse: mount failed: %s\n",
> -					strerror(errno_save));
> +				fuse_log(FUSE_LOG_ERR,
> +					 "fuse: mount failed: %s\n",
> +					 strerror(errno_save));
>  		}
>  
>  		goto out_close;
> @@ -619,17 +644,35 @@ static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
>  	free(type);
>  	free(source);
>  
> -	return fd;
> +	return 0;
>  
>  out_umount:
>  	umount2(mnt, 2); /* lazy umount */
>  out_close:
>  	free(type);
>  	free(source);
> -	close(fd);
>  	return res;
>  }
>  
> +static int fuse_mount_sys(const char *mnt, struct mount_opts *mo,
> +				  const char *mnt_opts)
> +{
> +	int fd;
> +	int res;
> +
> +	fd = fuse_kern_mount_prepare(mnt, mo);
> +	if (fd == -1)
> +		return -1;
> +
> +	res = fuse_kern_do_mount(mnt, mo, mnt_opts);
> +	if (res) {
> +		close(fd);
> +		return res;
> +	}
> +
> +	return fd;
> +}
> +
>  static int get_mnt_flag_opts(char **mnt_optsp, int flags)
>  {
>  	int i;
> @@ -678,6 +721,17 @@ void destroy_mount_opts(struct mount_opts *mo)
>  	free(mo);
>  }
>  
> +static int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo,
> +					     char **mnt_optsp)
> +{
> +	if (get_mnt_flag_opts(mnt_optsp, mo->flags) == -1)
> +		return -1;
> +	if (mo->kernel_opts && fuse_opt_add_opt(mnt_optsp, mo->kernel_opts) == -1)
> +		return -1;
> +	if (mo->mtab_opts &&  fuse_opt_add_opt(mnt_optsp, mo->mtab_opts) == -1)
> +		return -1;
> +	return 0;
> +}
>  
>  int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
>  {
> @@ -685,11 +739,7 @@ int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
>  	char *mnt_opts = NULL;
>  
>  	res = -1;
> -	if (get_mnt_flag_opts(&mnt_opts, mo->flags) == -1)
> -		goto out;
> -	if (mo->kernel_opts && fuse_opt_add_opt(&mnt_opts, mo->kernel_opts) == -1)
> -		goto out;
> -	if (mo->mtab_opts &&  fuse_opt_add_opt(&mnt_opts, mo->mtab_opts) == -1)
> +	if (fuse_kern_mount_get_base_mnt_opts(mo, &mnt_opts) == -1)
>  		goto out;
>  
>  	res = fuse_mount_sys(mountpoint, mo, mnt_opts);
> 
> -- 
> 2.43.0
> 
> 
