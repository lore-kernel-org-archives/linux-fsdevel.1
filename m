Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675121E47CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311500; cv=none; b=A4FsFOVDEm/Goultit7TNsL/Bb7b4XcaNvWmaaapcdbddS2Mouwmf/XPRCINjNbNYikZIks6KFFMrjUpEAowv7zpGIVdOL8f2Px4PH8p9QzyOt+SlAR5V7ZdbzlwrB5KKCQAAPYekVCVxfJ+0MNDV3EBQReLK4/Did1B8/e6xYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311500; c=relaxed/simple;
	bh=seRwEqn6eW8MKidMja1vYDXNeMfYxRT3XKCgpVcYBMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y73MskrJA2qDoBmau7W7As7p5+GpLbJ0wqB21mGNOTMhIMYmJJZzLTftD9A9OmtXLFN9+wARz6tvt4QzcA5gXcdD1YXJZpe1/i6FRf+2DsKoZRurgQrkLFs/L3vMGq7im/q6SDIDPRoqxWOYAvlQQ4slB+II0CSyVmkJ+wT/t9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be7zuz9S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be7zuz9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43165C2BC9E;
	Tue, 24 Mar 2026 00:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311500;
	bh=seRwEqn6eW8MKidMja1vYDXNeMfYxRT3XKCgpVcYBMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=be7zuz9Sz/CYbhYabot3jrqc+1Ne4g9aVssuDKzlvmS0VIo1a1ahyUWCxfaIWjFOa
	 DGV7McH6lOxoWHrcotzkUo4oSQ17RgcOgDw4SRdmwYuiW53tfeET1ZX++FStvcFOYT
	 Pi3sl3aVBVZhaJvc5l7dXHEQ4jdjqh/s9Oqhi5AudiE1EMI288j+yLyAS0M3pzk/YC
	 U5njxUxApvyGh5Da/rM9w9BIUiLNmw/iXLR1rHd9Plt8Wg5uziH1/GWcUYyQWS2Q3z
	 bOiRqdcpOZm2nV9ziNuEWI2XHWtJWZSxeH0aGHcaXLXxj+GKoTW079hBV1w8V9wIKG
	 RuuwxeDJmchEw==
Date: Mon, 23 Mar 2026 17:18:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>, h@magnolia.djwong.org
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 16/19] fusermount: Refactor extract_x_options
Message-ID: <20260324001819.GQ6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-16-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-16-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:11PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Just to make it better readable.
> 
> Also add a NULL check for *regular_opts and *x_prefixed_opts,
> there will be multiple callers in an upcoming commit and
> it becomes harder to track that no caller has an error.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Looks fine to me.  I would've added the NULL checks as a separate patch,
but this series is already plenty long...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  util/fusermount.c | 58 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/util/fusermount.c b/util/fusermount.c
> index ecf509bb80d5cd129f6e582f1ec666502c55603a..80b42a594e89cdc2f43824f5e274892522fd8cce 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -112,22 +112,31 @@ static struct mntent *GETMNTENT(FILE *stream)
>  
>  /*
>   * Take a ',' separated option string and extract "x-" options
> + * @original: The original option string
> + * @regular_opts: The regular options
> + * @x_prefixed_opts: The "x-" options
>   */
> -static int extract_x_options(const char *original, char **non_x_opts,
> -			     char **x_opts)
> +static int extract_x_options(const char *original, char **regular_opts,
> +			     char **x_prefixed_opts)
>  {
>  	size_t orig_len;
>  	const char *opt, *opt_end;
>  
>  	orig_len = strlen(original) + 1;
>  
> -	*non_x_opts = calloc(1, orig_len);
> -	*x_opts    = calloc(1, orig_len);
> +	if (*regular_opts != NULL || *x_prefixed_opts != NULL) {
> +		fprintf(stderr, "%s: regular_opts or x_prefixed_opts not NULL\n",
> +			__func__);
> +		return -EINVAL;
> +	}
>  
> -	size_t non_x_opts_len = orig_len;
> -	size_t x_opts_len = orig_len;
> +	*regular_opts = calloc(1, orig_len);
> +	*x_prefixed_opts    = calloc(1, orig_len);
>  
> -	if (*non_x_opts == NULL || *x_opts == NULL) {
> +	size_t regular_opts_len = orig_len;
> +	size_t x_prefixed_opts_len = orig_len;
> +
> +	if (*regular_opts == NULL || *x_prefixed_opts == NULL) {
>  		fprintf(stderr, "%s: Failed to allocate %zuB.\n",
>  			__func__, orig_len);
>  		return -ENOMEM;
> @@ -143,16 +152,16 @@ static int extract_x_options(const char *original, char **non_x_opts,
>  		size_t opt_len = opt_end - opt;
>  		size_t opt_len_left = orig_len - (opt - original);
>  		size_t buf_len;
> -		bool is_x_opts;
> +		bool is_x_prefixed_opts;
>  
>  		if (strncmp(opt, "x-", MIN(2, opt_len_left)) == 0) {
> -			buf_len = x_opts_len;
> -			is_x_opts = true;
> -			opt_buf = *x_opts;
> +			buf_len = x_prefixed_opts_len;
> +			is_x_prefixed_opts = true;
> +			opt_buf = *x_prefixed_opts;
>  		} else {
> -			buf_len = non_x_opts_len;
> -			is_x_opts = false;
> -			opt_buf = *non_x_opts;
> +			buf_len = regular_opts_len;
> +			is_x_prefixed_opts = false;
> +			opt_buf = *regular_opts;
>  		}
>  
>  		if (buf_len < orig_len) {
> @@ -163,7 +172,8 @@ static int extract_x_options(const char *original, char **non_x_opts,
>  		/* omits ',' */
>  		if ((ssize_t)(buf_len - opt_len) < 0) {
>  			/* This would be a bug */
> -			fprintf(stderr, "%s: no buf space left in copy, orig='%s'\n",
> +			fprintf(stderr,
> +				"%s: no buf space left in copy, orig='%s'\n",
>  				__func__, original);
>  			return -EIO;
>  		}
> @@ -171,10 +181,10 @@ static int extract_x_options(const char *original, char **non_x_opts,
>  		strncat(opt_buf, opt, opt_end - opt);
>  		buf_len -= opt_len;
>  
> -		if (is_x_opts)
> -			x_opts_len = buf_len;
> +		if (is_x_prefixed_opts)
> +			x_prefixed_opts_len = buf_len;
>  		else
> -			non_x_opts_len = buf_len;
> +			regular_opts_len = buf_len;
>  	}
>  
>  	return 0;
> @@ -1379,7 +1389,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  	const char *real_mnt = mnt;
>  	int mountpoint_fd = -1;
>  	char *do_mount_opts = NULL;
> -	char *x_opts = NULL;
> +	char *x_prefixed_opts = NULL;
>  
>  	fd = open_fuse_device(dev);
>  	if (fd == -1)
> @@ -1397,7 +1407,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  	}
>  
>  	// Extract any options starting with "x-"
> -	res= extract_x_options(opts, &do_mount_opts, &x_opts);
> +	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
>  	if (res)
>  		goto fail_close_fd;
>  
> @@ -1420,14 +1430,14 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  	}
>  
>  	if (geteuid() == 0) {
> -		if (x_opts && strlen(x_opts) > 0) {
> +		if (x_prefixed_opts && strlen(x_prefixed_opts) > 0) {
>  			/*
>  			 * Add back the options starting with "x-" to opts from
>  			 * do_mount. +2 for ',' and '\0'
>  			 */
>  			size_t mnt_opts_len = strlen(mnt_opts);
>  			size_t x_mnt_opts_len =  mnt_opts_len+
> -						 strlen(x_opts) + 2;
> +						 strlen(x_prefixed_opts) + 2;
>  			char *x_mnt_opts = calloc(1, x_mnt_opts_len);
>  
>  			if (mnt_opts_len) {
> @@ -1435,7 +1445,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  				strncat(x_mnt_opts, ",", 2);
>  			}
>  
> -			strncat(x_mnt_opts, x_opts,
> +			strncat(x_mnt_opts, x_prefixed_opts,
>  				x_mnt_opts_len - mnt_opts_len - 2);
>  
>  			free(mnt_opts);
> @@ -1452,7 +1462,7 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  out_free:
>  	free(source);
>  	free(mnt_opts);
> -	free(x_opts);
> +	free(x_prefixed_opts);
>  	free(do_mount_opts);
>  
>  	return fd;
> 
> -- 
> 2.43.0
> 
> 
