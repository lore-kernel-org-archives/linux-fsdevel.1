Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2691FF7C7
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605666; cv=none; b=n5V7eulBKPSeW2/jNMkkHjcbpLc5iqw+xfhhg8jXRUh8h73Lg0149vUW1gXz4pquQm1hZ4sFLnPcKNDBX2AdDws3GXhX+utY6F5GUs1pfcls+/OB6GI8atAKYoNe+yb+gS1+ldTKaPlOOACkjOHhmfvy+Nl99BT5LsZuTFEH7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605666; c=relaxed/simple;
	bh=S4JlAxepB12KlauAT3Xk0Fvn2snYxb9AaLxmeGNfXfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3adwQtbWMj47ppUrYb+RoLLFWVS02v9fDVSdpL9/yL1YBaX2ay3+5OlJv7YIqCJYumnbGj7GIsOtU9XSg9tM0aB5GdscQwosoSN016oo5zqhsLD55QpAqdT8kgtXwL887ScEOtM5cwjCteKf1MRc860TJIMDYGNNLhrNApK4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxBfWzkg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxBfWzkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B641C116C6;
	Tue,  7 Apr 2026 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775605666;
	bh=S4JlAxepB12KlauAT3Xk0Fvn2snYxb9AaLxmeGNfXfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxBfWzkgby9NLyD6LY/FtS5X1ShVH0rcli6Vwr1b1AIE5eDnq00Pa4I4zkivDfvl0
	 SKWM9E0ijzUl+GueAQ95HfgaweoGvVhF3JfsW6CbGhP4aaTOPh2qpc8Q7mkOjj8H+P
	 rv0QQLzVtqzUfqTSuOzUBHp0I3dGXxKYAElBwKZt/ndEQWNGF4ifZdbfRxyzW2xeUc
	 vI4VVBQCH52bVsejKT3zXMEZuyPgmaPTia5y4gC2ogFb+4/D3A11uBlQvCtPOcdwZG
	 gpOb/Wty/hElBa2gARcKx0rCPri2XAXm2y3FW2giyhbSIyrhcQ7zIVNqYQjHfSegcx
	 sWowYhLngi7QA==
Date: Tue, 7 Apr 2026 16:47:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
	neal@gompa.dev, joannelkoong@gmail.com
Subject: Re: [PATCH 11/17] mount_service: use over the other non-root user
 checks
Message-ID: <20260407234745.GQ6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463316.1008428.211933150228152448.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177457463316.1008428.211933150228152448.stgit@frogsfrogsfrogs>

On Thu, Mar 26, 2026 at 06:27:38PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that we've hoisted the code that checks non-root fuse mounts to a
> common file, make fuservicemount obey them too.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Codex pointed out quite a few setuid related problems in this patch that
I wasn't aware of.  Good for it!

The first is that I needed to wrap all the system calls that involve
access and permission checks with drop_privs() and restore_privs().
That way an unprivileged user cannot connect to fuse server sockets,
files, fuse devices, call block device ioctls, or mount() to places that
the original unprivileged user cannot access.

It also mentioned that we ought to call fuse_mnt_resolve_path to make
sure that the path mount point can be resolved with the real uid of the
mount helper process; this was fortunate, because that was also key to
enabling unmount if the fuse server initialization fails early on.

--D

> ---
>  util/mount_service.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> 
> diff --git a/util/mount_service.c b/util/mount_service.c
> index 9f6feab902f89d..6e53447e1d65be 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -1224,6 +1224,30 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
>  # define mount_service_fsopen_mount(...)	(-2)
>  #endif
>  
> +static int check_nonroot_file_access(const struct mount_service *mo)
> +{
> +	char buf[32];
> +	char *mntpt;
> +	int fd;
> +
> +	if (mo->mountfd >= 0) {
> +		snprintf(buf, sizeof(buf), "/dev/fd/%d", mo->mountfd);
> +		mntpt = buf;
> +	} else {
> +		mntpt = mo->mountpoint;
> +	}
> +
> +	fd = open(mntpt, O_WRONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
> +			mo->msgtag, mo->mountpoint);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> +
>  static int mount_service_handle_mount_cmd(struct mount_service *mo,
>  					  struct fuse_service_packet *p)
>  {
> @@ -1298,6 +1322,44 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
>  		return mount_service_send_reply(mo, EINVAL);
>  	}
>  
> +	/*
> +	 * fuse.conf can limit the number of unprivileged fuse mounts.
> +	 * For unprivileged mounts (via setuid) we also require write access
> +	 * to the mountpoint, and we'll only accept certain underlying
> +	 * filesystems.
> +	 */
> +	if (getuid() != 0) {
> +		struct statfs fs_buf;
> +
> +		ret = check_nonroot_mount_count(mo->msgtag);
> +		if (ret)
> +			return mount_service_send_reply(mo, ENOMEM);
> +
> +		ret = fstatfs(mo->mountfd, &fs_buf);
> +		if (ret) {
> +			int error = errno;
> +
> +			fprintf(stderr, "%s: %s: %s\n",
> +				mo->msgtag, mo->mountpoint, strerror(error));
> +			return mount_service_send_reply(mo, error);
> +		}
> +
> +		drop_privs();
> +		if (S_ISDIR(stbuf.st_mode))
> +			ret = check_nonroot_dir_access(mo->msgtag,
> +						       mo->mountpoint,
> +						       mo->real_mountpoint,
> +						       &stbuf);
> +		else
> +			ret = check_nonroot_file_access(mo);
> +		if (!ret)
> +			ret = check_nonroot_fstype(mo->msgtag, &fs_buf);
> +		restore_privs();
> +
> +		if (ret)
> +			return mount_service_send_reply(mo, EPERM);
> +	}
> +
>  	if (mo->fsopenfd >= 0) {
>  		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
>  		if (ret != -2)
> 
> 
