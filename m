Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175C3803DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897450; cv=none; b=oMJsKDW91s2EJGoYD1cDE5V2ISbv1yZnF56GV+G747QL6ELQhdsTtuY5tbYdN9zEHTv1c//6GCeozUOkm80TI/sV1RuxMI3Pl4dKSNVt7tM/VnzNOoJvKmVh/R3KmQCkkbvHxqqm5Ikw3ulW9pW5uxXI6KmltRzjaqsMW9dof/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897450; c=relaxed/simple;
	bh=Zwy564TpBXC4JJdnGNIbWqUKYdMDovFpkdWo1Savmgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/YWZd/ygnP0e64mP7znah2fqAgU28sCQmK5wGlgopyfHlVJCSb4F6GnTzcwRRQRcf3m3ZcCPU4972OMOpd140ig1JlvPEJcBxXEl+Rg9LKVDOup1ome9wqOYMNzCKcM4P0uNHrwnrkJoTmKFH2airbcboBlF7yTt6w7z8f4MMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4SIUAlY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4SIUAlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64093C4CEF7;
	Mon, 30 Mar 2026 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774897450;
	bh=Zwy564TpBXC4JJdnGNIbWqUKYdMDovFpkdWo1Savmgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4SIUAlYUEuoBJK82Yl2DM64sNVifvcCGrR8fRlxamPIb8Nq3wFjk1XDLVEawgdgg
	 KZBC72MzeVeFFaW++8A2dt/VIUT83MD/FAzSnVgHWujUjXKOBgfBnKtpHs7hjqVWzg
	 jEK2T7LmO3Imm02PIbWHhSWmoTK8IRXKp4PbrjiLGeQ6Xp7fVv+voUbTV/6cVmrZbu
	 w++E6OHPJIaMgUG7CFpF/iZbR9WS6oUYNTm24Xn7j40ZzBF0shp2RPvwJQ/Hnxywui
	 BbJRyYNQDHnuNtdJW7NOwdUu52oW2A0coGOwR2VshpVauX8+69nr2qpFJfkh048LX7
	 NOOfU50JLwnSQ==
Date: Mon, 30 Mar 2026 12:04:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 23/25] Move fuse_mnt_build_{source,type} to
 mount_util.c
Message-ID: <20260330190409.GB6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-23-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-23-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:56PM +0100, Bernd Schubert wrote:
> Also make it more generic and avoid taking struct mount_opts
> as parameter.
> 
> mount_fsmount.c and fusermount.c use these functions now.
> 
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>

Woot!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/mount.c         | 37 +++----------------------------------
>  lib/mount_fsmount.c | 29 ++++++++++++-----------------
>  lib/mount_i_linux.h |  2 --
>  lib/mount_util.c    | 31 +++++++++++++++++++++++++++++++
>  lib/mount_util.h    |  5 +++++
>  util/fusermount.c   | 16 ++--------------
>  6 files changed, 53 insertions(+), 67 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index f0d12525310a9ad239c0f447af60bd49b105a091..1e82adc8621da150e1ee61e8253b261a33625260 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -651,10 +651,11 @@ int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
>  	char *source = NULL;
>  	char *type = NULL;
>  	int res;
> +	const char *devname = fuse_mnt_get_devname();
>  
>  	res = -ENOMEM;
> -	source = fuse_mnt_build_source(mo);
> -	type = fuse_mnt_build_type(mo);
> +	source = fuse_mnt_build_source(mo->fsname, mo->subtype, devname);
> +	type = fuse_mnt_build_type(mo->blkdev, mo->subtype);
>  	if (!type || !source) {
>  		fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate memory\n");
>  		goto out_close;
> @@ -834,35 +835,3 @@ out:
>  	free(mnt_opts);
>  	return res;
>  }
> -
> -char *fuse_mnt_build_source(const struct mount_opts *mo)
> -{
> -	const char *devname = fuse_mnt_get_devname();
> -	char *source;
> -	int ret;
> -
> -	ret = asprintf(&source, "%s",
> -		       mo->fsname ? mo->fsname :
> -				    (mo->subtype ? mo->subtype : devname));
> -	if (ret == -1)
> -		return NULL;
> -
> -	return source;
> -}
> -
> -char *fuse_mnt_build_type(const struct mount_opts *mo)
> -{
> -	char *type;
> -	int ret;
> -
> -	if (mo->subtype)
> -		ret = asprintf(&type, "%s.%s", mo->blkdev ? "fuseblk" : "fuse",
> -			       mo->subtype);
> -	else
> -		ret = asprintf(&type, "%s", mo->blkdev ? "fuseblk" : "fuse");
> -
> -	if (ret == -1)
> -		return NULL;
> -
> -	return type;
> -}
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> index f42ae97faedaf2420d97e701a22725d4293e4853..57355db89f907e0dbd910ead4ea39005ec26c44d 100644
> --- a/lib/mount_fsmount.c
> +++ b/lib/mount_fsmount.c
> @@ -329,15 +329,21 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  		      const char *source_dev, const char *kernel_opts,
>  		      const char *mnt_opts)
>  {
> -	const char *type;
> +	char *type = NULL;
>  	char *source = NULL;
>  	int fsfd = -1;
>  	int mntfd = -1;
>  	int err, res;
>  	unsigned long mount_attrs;
>  
> -	/* Determine filesystem type */
> -	type = blkdev ? "fuseblk" : "fuse";
> +	/* Build type and source strings */
> +	type = fuse_mnt_build_type(blkdev, subtype);
> +	source = fuse_mnt_build_source(fsname, subtype, source_dev);
> +	err = -ENOMEM;
> +	if (!type || !source) {
> +		fprintf(stderr, "fuse: failed to allocate memory\n");
> +		goto out_free;
> +	}
>  
>  	/* Try to open filesystem context */
>  	fsfd = fsopen(type, FSOPEN_CLOEXEC);
> @@ -345,21 +351,9 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  		if (errno != EPERM)
>  			fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
>  				strerror(errno));
> -		return -1;
> +		goto out_free;
>  	}
>  
> -	/* Build source string */
> -	source = malloc((fsname ? strlen(fsname) : 0) +
> -			(subtype ? strlen(subtype) : 0) +
> -			strlen(source_dev) + 32);
> -	err = -ENOMEM;
> -	if (!source) {
> -		fprintf(stderr, "fuse: failed to allocate memory\n");
> -		goto out_close_fsfd;
> -	}
> -
> -	strcpy(source, fsname ? fsname : (subtype ? subtype : source_dev));
> -
>  	/* Configure source */
>  	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
>  	if (res == -1) {
> @@ -439,6 +433,7 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  
>  	close(mntfd);
>  	free(source);
> +	free(type);
>  	return 0;
>  
>  out_umount:
> @@ -458,7 +453,7 @@ out_close_mntfd:
>  		close(mntfd);
>  out_free:
>  	free(source);
> -out_close_fsfd:
> +	free(type);
>  	if (fsfd != -1)
>  		close(fsfd);
>  	errno = -err;
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> index ae98296a334a2aa39c4f3e5c3e4e3c136ae38cd3..8fc27b958eab3141ab852a7cb5098febd484e04f 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -41,8 +41,6 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>  			 const char *mnt_opts);
>  
> -char *fuse_mnt_build_source(const struct mount_opts *mo);
> -char *fuse_mnt_build_type(const struct mount_opts *mo);
>  int mount_fusermount_obtain_fd(const char *mountpoint,
>  					   struct mount_opts *mo,
>  					   const char *opts, int *sock_fd_out,
> diff --git a/lib/mount_util.c b/lib/mount_util.c
> index b6b75e60874ae9b2ec0c96f2a62b4ec1943a2a00..8cb0ce999e0df498c6777daf2bba6f47f12d7eee 100644
> --- a/lib/mount_util.c
> +++ b/lib/mount_util.c
> @@ -461,3 +461,34 @@ const char *fuse_mnt_get_devname(void)
>  
>  	return devname ? devname : "/dev/fuse";
>  }
> +
> +char *fuse_mnt_build_source(const char *fsname, const char *subtype,
> +			     const char *devname)
> +{
> +	char *source;
> +	int ret;
> +
> +	ret = asprintf(&source, "%s",
> +		       fsname ? fsname : (subtype ? subtype : devname));
> +	if (ret == -1)
> +		return NULL;
> +
> +	return source;
> +}
> +
> +char *fuse_mnt_build_type(int blkdev, const char *subtype)
> +{
> +	char *type;
> +	int ret;
> +
> +	if (subtype)
> +		ret = asprintf(&type, "%s.%s", blkdev ? "fuseblk" : "fuse",
> +			       subtype);
> +	else
> +		ret = asprintf(&type, "%s", blkdev ? "fuseblk" : "fuse");
> +
> +	if (ret == -1)
> +		return NULL;
> +
> +	return type;
> +}
> diff --git a/lib/mount_util.h b/lib/mount_util.h
> index b83db556d5fdb4bd8dd5e1750c8d11faf7373d82..5ba428a1f96df0dda21c0aadd936c022c4bb751c 100644
> --- a/lib/mount_util.h
> +++ b/lib/mount_util.h
> @@ -35,4 +35,9 @@ const char *fuse_mnt_get_devname(void);
>  int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
>  			       const char *type, const char *mnt_opts);
>  
> +/* Build source and type strings for mounting */
> +char *fuse_mnt_build_source(const char *fsname, const char *subtype,
> +			     const char *devname);
> +char *fuse_mnt_build_type(int blkdev, const char *subtype);
> +
>  #endif /* FUSE_MOUNT_UTIL_H_ */
> diff --git a/util/fusermount.c b/util/fusermount.c
> index bf442416c83d6da3f80eca5c9814df29f61bec56..6d3ad4b300ba6266778fc23f35fa6f4fc929ff3f 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -1048,25 +1048,13 @@ static int prepare_mount(const char *opts, struct mount_params *mp)
>  	sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
>  		mp->fd, mp->rootmode, getuid(), getgid());
>  
> -	mp->source = malloc((mp->fsname ? strlen(mp->fsname) : 0) +
> -			(mp->subtype ? strlen(mp->subtype) : 0) + strlen(mp->dev) + 32);
> -
> -	mp->type = malloc((mp->subtype ? strlen(mp->subtype) : 0) + 32);
> +	mp->source = fuse_mnt_build_source(mp->fsname, mp->subtype, mp->dev);
> +	mp->type = fuse_mnt_build_type(mp->blkdev, mp->subtype);
>  	if (!mp->type || !mp->source) {
>  		fprintf(stderr, "%s: failed to allocate memory\n", progname);
>  		goto err;
>  	}
>  
> -	if (mp->subtype)
> -		sprintf(mp->type, "%s.%s", mp->blkdev ? "fuseblk" : "fuse", mp->subtype);
> -	else
> -		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
> -
> -	if (mp->fsname)
> -		strcpy(mp->source, mp->fsname);
> -	else
> -		strcpy(mp->source, mp->subtype ? mp->subtype : mp->dev);
> -
>  	return 0;
>  
>  err:
> 
> -- 
> 2.43.0
> 
> 
