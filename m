Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40D3DEFE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896530; cv=none; b=qA8CYPHRaHt56sEEtNL/YRNbp2mfZ0j6I9sYH7ZrUieNlXW5ko7Nj125YmwQtolCfch8/YpQGEFyDWytp5Kelf+TzWqg+2BmgQkzJOIKWEubxLkYQAwnYDFj8BpYOjeSim+3A0gSb71DIJdLl6I1+S4LjVhKvVLhbps6ml0HIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896530; c=relaxed/simple;
	bh=huGjHsXcICWTGv+lr90IPusTUY/l3UGPnHaHzE+ggbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R64WDIQVoTWTBCYGDHKooohcpH/h6kKztZlWrw6O2FoCWafnogsQqaSI0wNTTvg7jKWQoYn5qSS+77gj7FIYxQ1L0OcPKQ7ECybUpAtd/t9/Pz4BLozMr1XWM6VnhKAYNZyYze9ERnzUqjRpyFbC3xzR4XxAyzXps3r1wxOK5Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNl3Kn1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNl3Kn1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F084C4CEF7;
	Mon, 30 Mar 2026 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774896529;
	bh=huGjHsXcICWTGv+lr90IPusTUY/l3UGPnHaHzE+ggbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNl3Kn1XkyUsJIMFMAHV8NdXzqfuh4Tc366DY1KcFX6ZA1+L9dtyTHc40qDE5t9JV
	 Z5sr7hXQ0N7MKBUPePV8oRWF4bQiHItg3+eRpGeF4Sv8ZXAPixL4dAnmgqQpL2SzJU
	 VkiwdTz8VneR8VmSvFNDpg7QLunTHH0G7LkyWRcRd78IQV0033ex6CutlMZ6TKf/9A
	 ioq10GixGv9vPZ0VkLT5t72mBFzvBjvtXyeHJD5jz+6KKIXrmCFg+euxNoveSkDB/F
	 xDJmK7ke1VknzC97Ze4GArw6C0bVFde7ngemkcHbnmLJMK+GJnUXqaB1hi0rM6VCtf
	 HhfnjNj9e7poQ==
Date: Mon, 30 Mar 2026 11:48:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 17/25] Split the fusermount do_mount function
Message-ID: <20260330184848.GZ6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-17-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-17-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:50PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> We will need new API and old API and need to pass the options to
> two different functions - factor out the option parsing.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

I like this splitting a loooong function into smaller pieces that are
easier to understand.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  util/fusermount.c | 298 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 205 insertions(+), 93 deletions(-)
> 
> diff --git a/util/fusermount.c b/util/fusermount.c
> index f66c4e8e0e809351384ec10cf50ba4d3d3a831b0..8d7598998788f72ea05c2a065a88cb5efd61df35 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -883,30 +883,132 @@ static int mount_notrunc(const char *source, const char *target,
>  	return mount(source, target, filesystemtype, mountflags, data);
>  }
>  
> +struct mount_params {
> +	/* Input parameters */
> +	int fd;                  /* /dev/fuse file descriptor */
> +	mode_t rootmode;         /* Root mode from stat */
> +	const char *dev;         /* Device path (/dev/fuse) */
>  
> -static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
> -		    int fd, const char *opts, const char *dev, char **sourcep,
> -		    char **mnt_optsp)
> +	/* Parsed mount options */
> +	unsigned long flags;     /* Mount flags (MS_NOSUID, etc.) */
> +	char *optbuf;           /* Kernel mount options buffer */
> +	char *fsname;           /* Filesystem name from options */
> +	char *subtype;          /* Subtype from options */
> +	int blkdev;             /* Block device flag */
> +
> +	/* Generated mount parameters */
> +	char *source;           /* Mount source string */
> +	char *type;             /* Filesystem type string */
> +	char *mnt_opts;         /* Mount table options */
> +
> +	/* Pointer for optbuf manipulation */
> +	char *optbuf_end;       /* Points to end of optbuf for sprintf */
> +};
> +
> +static void free_mount_params(struct mount_params *mp)
> +{
> +	free(mp->optbuf);
> +	free(mp->fsname);
> +	free(mp->subtype);
> +	free(mp->source);
> +	free(mp->type);
> +	free(mp->mnt_opts);
> +}
> +
> +/*
> + * Check if option is deprecated large_read.
> + *
> + * Returns true if the option should be skipped (large_read on kernel > 2.4),
> + * false otherwise (all other options or large_read on old kernels).
> + */
> +static bool check_large_read(const char *opt, unsigned int len)
> +{
> +	struct utsname utsname;
> +	unsigned int kmaj, kmin;
> +	int res;
> +
> +	if (!opt_eq(opt, len, "large_read"))
> +		return false;
> +
> +	res = uname(&utsname);
> +	if (res == 0 &&
> +	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
> +	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
> +		fprintf(stderr,
> +			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
> +			progname, kmaj, kmin);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * Check if user has permission to use allow_other or allow_root options.
> + *
> + * Returns -1 if permission denied, 0 if allowed or option is not
> + * allow_other/allow_root.
> + */
> +static int check_allow_permission(const char *opt, unsigned int len)
> +{
> +	if (getuid() != 0 && !user_allow_other &&
> +	    (opt_eq(opt, len, "allow_other") || opt_eq(opt, len, "allow_root"))) {
> +		fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n",
> +			progname, len, opt, FUSE_CONF);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Process generic mount option.
> + *
> + * Handles mount flags (ro, rw, suid, etc.), kernel options
> + * (default_permissions, allow_other, max_read, blksize), or exits on
> + * unknown options.
> + */
> +static int process_generic_option(const char *opt, unsigned int len,
> +				   unsigned long *flags, char **dest)
> +{
> +	int on;
> +	int flag;
> +
> +	if (find_mount_flag(opt, len, &on, &flag)) {
> +		if (on)
> +			*flags |= flag;
> +		else
> +			*flags &= ~flag;
> +		return 0;
> +	}
> +
> +	if (opt_eq(opt, len, "default_permissions") ||
> +	    opt_eq(opt, len, "allow_other") ||
> +	    begins_with(opt, "max_read=") ||
> +	    begins_with(opt, "blksize=")) {
> +		memcpy(*dest, opt, len);
> +		*dest += len;
> +		**dest = ',';
> +		(*dest)++;
> +		return 0;
> +	}
> +
> +	fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, opt);
> +	exit(1);
> +}
> +
> +static int prepare_mount(const char *opts, struct mount_params *mp)
>  {
>  	int res;
> -	int flags = MS_NOSUID | MS_NODEV;
> -	char *optbuf;
> -	char *mnt_opts = NULL;
>  	const char *s;
>  	char *d;
> -	char *fsname = NULL;
> -	char *subtype = NULL;
> -	char *source = NULL;
> -	char *type = NULL;
> -	int blkdev = 0;
>  
> -	optbuf = (char *) malloc(strlen(opts) + 128);
> -	if (!optbuf) {
> +	mp->flags = MS_NOSUID | MS_NODEV;
> +	mp->optbuf = (char *) malloc(strlen(opts) + 128);
> +	if (!mp->optbuf) {
>  		fprintf(stderr, "%s: failed to allocate memory\n", progname);
>  		return -1;
>  	}
>  
> -	for (s = opts, d = optbuf; *s;) {
> +	for (s = opts, d = mp->optbuf; *s;) {
>  		unsigned len;
>  		const char *fsname_str = "fsname=";
>  		const char *subtype_str = "subtype=";
> @@ -919,10 +1021,10 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>  				break;
>  		}
>  		if (begins_with(s, fsname_str)) {
> -			if (!get_string_opt(s, len, fsname_str, &fsname))
> +			if (!get_string_opt(s, len, fsname_str, &mp->fsname))
>  				goto err;
>  		} else if (begins_with(s, subtype_str)) {
> -			if (!get_string_opt(s, len, subtype_str, &subtype))
> +			if (!get_string_opt(s, len, subtype_str, &mp->subtype))
>  				goto err;
>  		} else if (opt_eq(s, len, "blkdev")) {
>  			if (getuid() != 0) {
> @@ -931,7 +1033,7 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>  					progname);
>  				goto err;
>  			}
> -			blkdev = 1;
> +			mp->blkdev = 1;
>  		} else if (opt_eq(s, len, "auto_unmount")) {
>  			auto_unmount = 1;
>  		} else if (!opt_eq(s, len, "nonempty") &&
> @@ -939,122 +1041,132 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>  			   !begins_with(s, "rootmode=") &&
>  			   !begins_with(s, "user_id=") &&
>  			   !begins_with(s, "group_id=")) {
> -			int on;
> -			int flag;
> -			int skip_option = 0;
> -			if (opt_eq(s, len, "large_read")) {
> -				struct utsname utsname;
> -				unsigned kmaj, kmin;
> -				res = uname(&utsname);
> -				if (res == 0 &&
> -				    sscanf(utsname.release, "%u.%u",
> -					   &kmaj, &kmin) == 2 &&
> -				    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
> -					fprintf(stderr, "%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n", progname, kmaj, kmin);
> -					skip_option = 1;
> -				}
> -			}
> -			if (getuid() != 0 && !user_allow_other &&
> -			    (opt_eq(s, len, "allow_other") ||
> -			     opt_eq(s, len, "allow_root"))) {
> -				fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n", progname, len, s, FUSE_CONF);
> +			bool skip;
> +
> +			if (check_allow_permission(s, len) == -1)
>  				goto err;
> -			}
> -			if (!skip_option) {
> -				if (find_mount_flag(s, len, &on, &flag)) {
> -					if (on)
> -						flags |= flag;
> -					else
> -						flags  &= ~flag;
> -				} else if (opt_eq(s, len, "default_permissions") ||
> -					   opt_eq(s, len, "allow_other") ||
> -					   begins_with(s, "max_read=") ||
> -					   begins_with(s, "blksize=")) {
> -					memcpy(d, s, len);
> -					d += len;
> -					*d++ = ',';
> -				} else {
> -					fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, s);
> -					exit(1);
> -				}
> -			}
> +
> +			skip = check_large_read(s, len);
> +
> +			/*
> +			 * Skip deprecated large_read to avoid passing it to
> +			 * kernel which would reject it as unknown option.
> +			 */
> +			if (!skip)
> +				process_generic_option(s, len, &mp->flags, &d);
>  		}
>  		s += len;
>  		if (*s)
>  			s++;
>  	}
>  	*d = '\0';
> -	res = get_mnt_opts(flags, optbuf, &mnt_opts);
> +	res = get_mnt_opts(mp->flags, mp->optbuf, &mp->mnt_opts);
>  	if (res == -1)
>  		goto err;
>  
> +	mp->optbuf_end = d;
> +
>  	sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
> -		fd, rootmode, getuid(), getgid());
> +		mp->fd, mp->rootmode, getuid(), getgid());
>  
> -	source = malloc((fsname ? strlen(fsname) : 0) +
> -			(subtype ? strlen(subtype) : 0) + strlen(dev) + 32);
> +	mp->source = malloc((mp->fsname ? strlen(mp->fsname) : 0) +
> +			(mp->subtype ? strlen(mp->subtype) : 0) + strlen(mp->dev) + 32);
>  
> -	type = malloc((subtype ? strlen(subtype) : 0) + 32);
> -	if (!type || !source) {
> +	mp->type = malloc((mp->subtype ? strlen(mp->subtype) : 0) + 32);
> +	if (!mp->type || !mp->source) {
>  		fprintf(stderr, "%s: failed to allocate memory\n", progname);
>  		goto err;
>  	}
>  
> -	if (subtype)
> -		sprintf(type, "%s.%s", blkdev ? "fuseblk" : "fuse", subtype);
> +	if (mp->subtype)
> +		sprintf(mp->type, "%s.%s", mp->blkdev ? "fuseblk" : "fuse", mp->subtype);
>  	else
> -		strcpy(type, blkdev ? "fuseblk" : "fuse");
> +		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
>  
> -	if (fsname)
> -		strcpy(source, fsname);
> +	if (mp->fsname)
> +		strcpy(mp->source, mp->fsname);
>  	else
> -		strcpy(source, subtype ? subtype : dev);
> +		strcpy(mp->source, mp->subtype ? mp->subtype : mp->dev);
>  
> -	res = mount_notrunc(source, mnt, type, flags, optbuf);
> -	if (res == -1 && errno == ENODEV && subtype) {
> +	return 0;
> +
> +err:
> +	free_mount_params(mp);
> +	return -1;
> +}
> +
> +/*
> + * Perform the actual mount operation using prepared parameters.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int perform_mount(const char *mnt, struct mount_params *mp)
> +{
> +	int res;
> +
> +	res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
> +	if (res == -1 && errno == ENODEV && mp->subtype) {
>  		/* Probably missing subtype support */
> -		strcpy(type, blkdev ? "fuseblk" : "fuse");
> -		if (fsname) {
> -			if (!blkdev)
> -				sprintf(source, "%s#%s", subtype, fsname);
> +		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
> +		if (mp->fsname) {
> +			if (!mp->blkdev)
> +				sprintf(mp->source, "%s#%s", mp->subtype, mp->fsname);
>  		} else {
> -			strcpy(source, type);
> +			strcpy(mp->source, mp->type);
>  		}
>  
> -		res = mount_notrunc(source, mnt, type, flags, optbuf);
> +		res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
>  	}
>  	if (res == -1 && errno == EINVAL) {
>  		/* It could be an old version not supporting group_id */
> -		sprintf(d, "fd=%i,rootmode=%o,user_id=%u",
> -			fd, rootmode, getuid());
> -		res = mount_notrunc(source, mnt, type, flags, optbuf);
> +		sprintf(mp->optbuf_end, "fd=%i,rootmode=%o,user_id=%u",
> +			mp->fd, mp->rootmode, getuid());
> +		res = mount_notrunc(mp->source, mnt, mp->type, mp->flags, mp->optbuf);
>  	}
>  	if (res == -1) {
>  		int errno_save = errno;
> -		if (blkdev && errno == ENODEV && !fuse_mnt_check_fuseblk())
> +		if (mp->blkdev && errno == ENODEV && !fuse_mnt_check_fuseblk())
>  			fprintf(stderr, "%s: 'fuseblk' support missing\n",
>  				progname);
>  		else
>  			fprintf(stderr, "%s: mount failed: %s\n", progname,
>  				strerror(errno_save));
> -		goto err;
> +		return -1;
>  	}
> -	*sourcep = source;
> -	*typep = type;
> -	*mnt_optsp = mnt_opts;
> -	free(fsname);
> -	free(optbuf);
>  
>  	return 0;
> +}
>  
> -err:
> -	free(fsname);
> -	free(subtype);
> -	free(source);
> -	free(type);
> -	free(mnt_opts);
> -	free(optbuf);
> -	return -1;
> +static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
> +		    int fd, const char *opts, const char *dev, char **sourcep,
> +		    char **mnt_optsp)
> +{
> +	struct mount_params mp = { .fd = fd }; /* implicit zero of other params */
> +	int res;
> +
> +	mp.rootmode = rootmode;
> +	mp.dev = dev;
> +
> +	res = prepare_mount(opts, &mp);
> +	if (res == -1)
> +		return -1;
> +
> +	res = perform_mount(mnt, &mp);
> +	if (res == -1) {
> +		free_mount_params(&mp);
> +		return -1;
> +	}
> +
> +	*sourcep = mp.source;
> +	*typep = mp.type;
> +	*mnt_optsp = mp.mnt_opts;
> +
> +	/* Free only the intermediate allocations, not the returned ones */
> +	free(mp.fsname);
> +	free(mp.subtype);
> +	free(mp.optbuf);
> +
> +	return 0;
>  }
>  
>  static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
> 
> -- 
> 2.43.0
> 
> 
