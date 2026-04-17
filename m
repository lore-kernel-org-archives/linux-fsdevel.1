Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1A2264A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463392; cv=none; b=VXPTD5B148LrRzm6P3Byb7+ExZjG2yWvl6HfWyhlSIIpJj3YyylKM8Bbd1kkqDJRFSJ57iQYQLVo9HuF2D2lsLzUeL44R/02y/ZzaFeRmt9gpNxW/MunnfrDLi6ovDtK1C+YtRVpuHX99w8qCY2QwiH0xDPm7WlHpm9UabAPu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463392; c=relaxed/simple;
	bh=RCWph/XP1XMGL8UUdOw5k9H5flVdDt7pzg87VldlmXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQN/MXWQkq16AtFRqTtvrji07H5dEI7ZO5THuHRoDHWI1S34j1lISouU+Q+K95zSa4yEPT2BGN94Z50E0/5KII2Cs20eTd8C2UEMR/iifwYUlkSxaACetbPD/XQJuHuAzQ5pu9LGMcRHXBaEPMSMV9kGXxihSIJzQcrKWvgTUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDFpNMEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDFpNMEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B14C19425;
	Fri, 17 Apr 2026 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776463392;
	bh=RCWph/XP1XMGL8UUdOw5k9H5flVdDt7pzg87VldlmXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDFpNMEBD3owc5xc09Hmmv02J8y4RnAj2DX8RLbS5jo8uHg2pZI79AT7BI52YhBrj
	 t3Fo5GOBThN1K/rCQgX1O47YRN0aJIRDTAYX9vaL/iFA0X2gCXdYeT/SYmGgShTf0w
	 rxlLvC9vb/O9kr/WHPk4MrHMMQT0dLf8gctaAvjoE5iHRmKzTXK3SWodA2Hj8nY1ft
	 iXNF/4cNauqjqGCvUQdpJPTYcUTafPEV1pEB8hHM0W5F6sLpXbPrGoEVfTef/otTEQ
	 zg4S4SeoByOZKsFMfZ2N7I7QNXjXmipBxIODWIXmVPxlPnYWHR5dJb3JExwsux6nyf
	 Ad66VARidNp8w==
Date: Fri, 17 Apr 2026 15:03:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 04/13] mount_service: use the new mount api for the mount
 service
Message-ID: <20260417220311.GF7727@frogsfrogsfrogs>
References: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
 <177577270289.2064074.17391911422191661254.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177577270289.2064074.17391911422191661254.stgit@frogsfrogsfrogs>

On Thu, Apr 09, 2026 at 03:21:35PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Use the new fsopen/fsmount system calls to mount the filesystem so that
> we get somewhat better diagnostics if something gets screwed up.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  lib/fuse_i.h         |    3 
>  meson.build          |   15 ++
>  util/mount_service.c |  323 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 341 insertions(+)
> 
> 
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 0ca13d132585f6..1710a872e19c72 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -215,6 +215,9 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
>   */
>  void fuse_chan_put(struct fuse_chan *ch);
>  
> +/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
> +#define FUSE_MOUNT_FALLBACK_NEEDED (-2)
> +
>  struct mount_opts *parse_mount_opts(struct fuse_args *args);
>  void destroy_mount_opts(struct mount_opts *mo);
>  void fuse_mount_version(void);
> diff --git a/meson.build b/meson.build
> index 66425a0d4cc16f..c8326b79fcee8f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -135,6 +135,21 @@ special_funcs = {
>  	int main(int argc, char *argv[]) {
>            return SD_LISTEN_FDS_START;
>  	}
> +    ''',
> +    'new_mount_api': '''
> +       #define _GNU_SOURCE
> +       #include <sys/mount.h>
> +       #include <linux/mount.h>
> +       #include <unistd.h>
> +       #include <fcntl.h>
> +
> +       int main(void) {
> +           int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
> +           int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
> +           int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
> +           res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH);
> +           return 0;
> +       }
>      '''
>  }
>  
> diff --git a/util/mount_service.c b/util/mount_service.c
> index abe88a0710255b..246a95101e8d34 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -71,6 +71,9 @@ struct mount_service {
>  	/* fd for mount point */
>  	int mountfd;
>  
> +	/* fd for fsopen */
> +	int fsopenfd;
> +
>  	/* did we actually mount successfully? */
>  	bool mounted;
>  };
> @@ -94,6 +97,7 @@ static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
>  	mo->argvfd = -1;
>  	mo->fusedevfd = -1;
>  	mo->mountfd = -1;
> +	mo->fsopenfd = -1;
>  
>  	for (i = 0; i < argc; i++) {
>  		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
> @@ -710,6 +714,26 @@ static int mount_service_handle_open_bdev_cmd(struct mount_service *mo,
>  	return mount_service_open_path(mo, S_IFBLK, p, psz);
>  }
>  
> +#ifdef HAVE_NEW_MOUNT_API
> +static void try_fsopen(struct mount_service *mo,
> +		       struct fuse_service_string_command *oc)
> +{
> +	/*
> +	 * As of Linux 7.0 you can pass subtypes to fsopen, but the manpage for
> +	 * fsopen only says that you can pass any value of the second column of
> +	 * /proc/filesystems into fsopen.
> +	 */
> +	if (!strncmp(oc->value, "fuse.", 5))
> +		*(oc->value + 4) = 0;
> +	else if (!strncmp(oc->value, "fuseblk.", 8))
> +		*(oc->value + 7) = 0;
> +
> +	mo->fsopenfd = fsopen(oc->value, FSOPEN_CLOEXEC);
> +}
> +#else
> +# define try_fsopen(...)	((void)0)
> +#endif
> +
>  static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
>  					   const struct fuse_service_packet *p,
>  					   size_t psz)
> @@ -744,9 +768,45 @@ static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
>  		return mount_service_send_reply(mo, error);
>  	}
>  
> +	/* If this fails we fall back on mount(); oc->value is mutated */
> +	try_fsopen(mo, oc);
>  	return mount_service_send_reply(mo, 0);
>  }
>  
> +#ifdef HAVE_NEW_MOUNT_API
> +/* callers must preserve errno */
> +static void emit_fsconfig_messages(const struct mount_service *mo)
> +{
> +	uint8_t buf[BUFSIZ];
> +	ssize_t sz;
> +
> +	while ((sz = read(mo->fsopenfd, buf, sizeof(buf) - 1)) >= 1) {
> +		if (buf[sz - 1] == '\n')
> +			buf[--sz] = '\0';
> +		else
> +			buf[sz] = '\0';
> +
> +		if (!*buf)
> +			continue;
> +
> +		switch (buf[0]) {
> +		case 'e':
> +			fprintf(stderr, "Error: %s\n", buf + 2);
> +			break;
> +		case 'w':
> +			fprintf(stderr, "Warning: %s\n", buf + 2);
> +			break;
> +		case 'i':
> +			fprintf(stderr, "Info: %s\n", buf + 2);
> +			break;
> +		default:
> +			fprintf(stderr, " %s\n", buf);
> +			break;
> +		}
> +	}
> +}
> +#endif
> +
>  static int mount_service_handle_source_cmd(struct mount_service *mo,
>  					   const struct fuse_service_packet *p,
>  					   size_t psz)
> @@ -781,6 +841,21 @@ static int mount_service_handle_source_cmd(struct mount_service *mo,
>  		return mount_service_send_reply(mo, error);
>  	}
>  
> +#ifdef HAVE_NEW_MOUNT_API
> +	if (mo->fsopenfd >= 0) {
> +		int ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "source",
> +			       oc->value, 0);
> +		if (ret) {
> +			int error = errno;
> +
> +			fprintf(stderr, "%s: fsconfig source: %s\n",
> +				mo->msgtag, strerror(error));
> +			emit_fsconfig_messages(mo);
> +			return mount_service_send_reply(mo, error);
> +		}
> +	}
> +#endif
> +
>  	return mount_service_send_reply(mo, 0);
>  }
>  
> @@ -790,6 +865,8 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
>  {
>  	struct fuse_service_string_command *oc =
>  			container_of(p, struct fuse_service_string_command, p);
> +	char *tokstr = oc->value;
> +	char *tok, *savetok;
>  
>  	if (psz < sizeof_fuse_service_string_command(1)) {
>  		fprintf(stderr, "%s: mount options command too small\n",
> @@ -818,6 +895,45 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
>  		return mount_service_send_reply(mo, error);
>  	}
>  
> +	/* strtok_r mutates tokstr aka oc->value */
> +	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
> +		char *equals = strchr(tok, '=');
> +		char oldchar = 0;
> +
> +		if (equals) {
> +			oldchar = *equals;
> +			*equals = 0;
> +		}
> +
> +#ifdef HAVE_NEW_MOUNT_API
> +		if (mo->fsopenfd >= 0) {
> +			int ret;
> +
> +			if (equals)
> +				ret = fsconfig(mo->fsopenfd,
> +					       FSCONFIG_SET_STRING, tok,
> +					       equals + 1, 0);
> +			else
> +				ret = fsconfig(mo->fsopenfd,
> +					       FSCONFIG_SET_FLAG, tok,
> +					       NULL, 0);
> +			if (ret) {
> +				int error = errno;
> +
> +				fprintf(stderr, "%s: set mount option: %s\n",
> +					mo->msgtag, strerror(error));
> +				emit_fsconfig_messages(mo);
> +				return mount_service_send_reply(mo, error);
> +			}
> +		}
> +#endif
> +
> +		if (equals)
> +			*equals = oldchar;
> +
> +		tokstr = NULL;
> +	}
> +
>  	return mount_service_send_reply(mo, 0);
>  }
>  
> @@ -1028,6 +1144,205 @@ static int mount_service_regular_mount(struct mount_service *mo,
>  	return mount_service_send_reply(mo, 0);
>  }
>  
> +#ifdef HAVE_NEW_MOUNT_API
> +struct ms_to_mount_map {
> +	unsigned long ms_flag;
> +	unsigned int mount_attr_flag;
> +};
> +
> +static const struct ms_to_mount_map attrs[] = {
> +	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
> +	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
> +	{ MS_NODEV,		MOUNT_ATTR_NODEV },
> +	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
> +	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
> +	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
> +	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
> +	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
> +#ifdef MOUNT_ATTR_NOSYMFOLLOW
> +	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
> +#endif
> +	{ 0, 0 },
> +};
> +
> +static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
> +				 unsigned int *attr_flags,
> +				 unsigned long *leftover_ms_flags)
> +{
> +	const struct ms_to_mount_map *i;
> +	unsigned int ms_flags = ntohl(oc->ms_flags);
> +	unsigned int mount_attr_flags = 0;
> +
> +	for (i = attrs; i->ms_flag != 0; i++) {
> +		if (ms_flags & i->ms_flag)
> +			mount_attr_flags |= i->mount_attr_flag;
> +		ms_flags &= ~i->ms_flag;
> +	}
> +
> +	*leftover_ms_flags = ms_flags;
> +	*attr_flags = mount_attr_flags;
> +}
> +
> +struct ms_to_str_map {
> +	unsigned long ms_flag;
> +	const char *string;
> +};
> +
> +static const struct ms_to_str_map strflags[] = {
> +	{ MS_SYNCHRONOUS,	"sync" },
> +	{ MS_DIRSYNC,		"dirsync" },
> +	{ MS_LAZYTIME,		"lazytime" },
> +	{ 0, 0 },
> +};
> +
> +static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> +{
> +	const struct ms_to_str_map *i;
> +	int ret;
> +
> +	for (i = strflags; i->ms_flag != 0; i++) {
> +		if (!(ms_flags & i->ms_flag))
> +			continue;
> +
> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> +			       NULL, 0);
> +		if (ret) {
> +			int error = errno;
> +
> +			fprintf(stderr, "%s: set %s option: %s\n",
> +				mo->msgtag, i->string, strerror(error));
> +			emit_fsconfig_messages(mo);
> +
> +			errno = error;
> +			return -1;
> +		}
> +		ms_flags &= ~i->ms_flag;
> +	}
> +
> +	/*
> +	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
> +	 * or string flags!  Return a magic code so the caller will fall back
> +	 * to regular mount(2).
> +	 */
> +	if (ms_flags)
> +		return FUSE_MOUNT_FALLBACK_NEEDED;
> +
> +	return 0;
> +}
> +
> +static int mount_service_fsopen_mount(struct mount_service *mo,
> +				      struct fuse_service_mount_command *oc,
> +				      struct stat *stbuf)
> +{
> +	char tmp[64];
> +	char *dot;
> +	unsigned long ms_flags;
> +	unsigned int attr_flags;
> +	int mfd;
> +	int error;
> +	int ret;
> +
> +	get_mount_attr_flags(oc, &attr_flags, &ms_flags);
> +
> +	ret = set_ms_flags(mo, ms_flags);
> +	if (ret == FUSE_MOUNT_FALLBACK_NEEDED)
> +		return ret;
> +	if (ret) {
> +		error = errno;
> +		goto fail_mount;
> +	}
> +
> +	snprintf(tmp, sizeof(tmp), "%i", mo->fusedevfd);
> +	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "fd", tmp, 0);
> +	if (ret) {
> +		error = errno;
> +		fprintf(stderr, "%s: set fd option: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_fsconfig;
> +	}
> +
> +	snprintf(tmp, sizeof(tmp), "%o", stbuf->st_mode & S_IFMT);
> +	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "rootmode", tmp, 0);
> +	if (ret) {
> +		error = errno;
> +		fprintf(stderr, "%s: set rootmode option: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_fsconfig;
> +	}
> +
> +	snprintf(tmp, sizeof(tmp), "%u", getuid());
> +	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "user_id", tmp, 0);
> +	if (ret) {
> +		error = errno;
> +		fprintf(stderr, "%s: set user_id option: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_fsconfig;
> +	}
> +
> +	snprintf(tmp, sizeof(tmp), "%u", getgid());
> +	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "group_id", tmp, 0);
> +	if (ret) {
> +		error = errno;
> +		fprintf(stderr, "%s: set group_id option: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_fsconfig;
> +	}
> +
> +	dot = strchr(mo->fstype, '.');
> +	if (dot) {
> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "subtype",
> +			       dot + 1, 0);
> +		if (ret) {
> +			error = errno;
> +
> +			/* The subtype option came after fsopen */
> +			if (error == EINVAL)
> +				return FUSE_MOUNT_FALLBACK_NEEDED;
> +
> +			fprintf(stderr, "%s: set subtype option: %s\n",
> +				mo->msgtag, strerror(error));
> +			goto fail_fsconfig;
> +		}
> +	}

This string should be set first so we can avoid wasting time on
fsconfig() calls, in addition to using the @type parameter that was
pased in from fuservicemount instead of whatever string the fuse server
might have fed us.

--D

> +
> +	ret = fsconfig(mo->fsopenfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +	if (ret) {
> +		error = errno;
> +		fprintf(stderr, "%s: creating filesystem: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_fsconfig;
> +	}
> +
> +	mfd = fsmount(mo->fsopenfd, FSMOUNT_CLOEXEC, attr_flags);
> +	if (mfd < 0) {
> +		error = errno;
> +		fprintf(stderr, "%s: fsmount: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_fsconfig;
> +	}
> +
> +	ret = move_mount(mfd, "", mo->mountfd, "",
> +			 MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH);
> +	close(mfd);
> +	if (ret) {
> +		error = errno;
> +		fprintf(stderr, "%s: move_mount: %s\n",
> +			mo->msgtag, strerror(error));
> +		goto fail_mount;
> +	}
> +
> +	mo->mounted = true;
> +	return mount_service_send_reply(mo, 0);
> +
> +fail_fsconfig:
> +	emit_fsconfig_messages(mo);
> +fail_mount:
> +	return mount_service_send_reply(mo, error);
> +}
> +#else
> +# define mount_service_fsopen_mount(...)	(FUSE_MOUNT_FALLBACK_NEEDED)
> +#endif
> +
>  static int mount_service_handle_mount_cmd(struct mount_service *mo,
>  					  struct fuse_service_packet *p,
>  					  size_t psz)
> @@ -1100,6 +1415,12 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
>  		return mount_service_send_reply(mo, EINVAL);
>  	}
>  
> +	if (mo->fsopenfd >= 0) {
> +		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
> +		if (ret != FUSE_MOUNT_FALLBACK_NEEDED)
> +			return ret;
> +	}
> +
>  	return mount_service_regular_mount(mo, oc, &stbuf);
>  }
>  
> @@ -1179,6 +1500,7 @@ static void mount_service_destroy(struct mount_service *mo)
>  	close(mo->mountfd);
>  	close(mo->fusedevfd);
>  	close(mo->argvfd);
> +	close(mo->fsopenfd);
>  	shutdown(mo->sockfd, SHUT_RDWR);
>  	close(mo->sockfd);
>  
> @@ -1194,6 +1516,7 @@ static void mount_service_destroy(struct mount_service *mo)
>  	mo->argvfd = -1;
>  	mo->fusedevfd = -1;
>  	mo->mountfd = -1;
> +	mo->fsopenfd = -1;
>  }
>  
>  int mount_service_main(int argc, char *argv[])
> 
> 
