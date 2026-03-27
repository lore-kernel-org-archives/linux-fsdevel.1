Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1121E3DED
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582334; cv=none; b=esqoPaPQI9pp31S66YazFdGgLqmSb7MxZ3rF12YXr10oS4cpceihohAQKIIElfVTAsz5t4GwnalTido8pCoDUmQ5nm69UpGbh++4Nckm9Jg8EKSXm8cgoeEnVvu6mCGFsIhpmmzA7hBEJZL190IMg1fdj7/vAQ/NHcr2dCWpC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582334; c=relaxed/simple;
	bh=r2UhyUhJqupl3grF+zgPktb5SMmq1qNRngzAQT0JmjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/xO3PjgomQMl+dov+yCCupr3qT8FrlpirbeW8v6M2Za1V47qV00aDxcyzeTnoEjsdx6HcJggAEXGI8KVgtrUbEMhFil90+Mt39tsaj1m1ppdglsO0dzE2OwLW6y+gSntrVMAA6k8RTFOn1dpnu70m7BtkusYQBU3g3C4zgB5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKgLkOWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKgLkOWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49458C19423;
	Fri, 27 Mar 2026 03:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582334;
	bh=r2UhyUhJqupl3grF+zgPktb5SMmq1qNRngzAQT0JmjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKgLkOWWUV5mjch+rm0gO+OGGxpI4QbnOd/A3dIzJAy7jesUkvelfX19ITV++Y06K
	 +LiwZTz2cvX+cLo+Ks6HKzqdOzhmVgAo7MG9UzROq0vQDB0t2XqXVDy8Y64LcaTsCT
	 ViYIVoDbHvWEu44tKsJIOfAaJrko6Gjh8d/UTqrgwWSFrIxRYIxfuI0HHc42mQlHAT
	 13CI6nlKSJPe/l3HZ6unjQWP4oFEW+u8w0YiYxAmcA9ED9WNboIRVYwdn0bvuGjKcM
	 jcXU+mC1BQ7fYWyP4WuymP57WIaTlB/UKCmhmyQnlxL6hncQH5bHdRR+B7m7u+42KO
	 /4FQdj6CQhinA==
Date: Thu, 26 Mar 2026 20:32:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 18/25] fusermout: Remove the large read check
Message-ID: <20260327033213.GN6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-18-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-18-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:51PM +0100, Bernd Schubert wrote:
> <quote Darrick>
> Nobody's running 2.4 kernels
> anymore, right?
> </quote>
> 
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> ---
>  util/fusermount.c | 37 +------------------------------------
>  1 file changed, 1 insertion(+), 36 deletions(-)
> 
> diff --git a/util/fusermount.c b/util/fusermount.c
> index 8d7598998788f72ea05c2a065a88cb5efd61df35..254f24a98abf935846cfed754693cc1958c8d2ff 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -915,33 +915,6 @@ static void free_mount_params(struct mount_params *mp)
>  	free(mp->mnt_opts);
>  }
>  
> -/*
> - * Check if option is deprecated large_read.
> - *
> - * Returns true if the option should be skipped (large_read on kernel > 2.4),
> - * false otherwise (all other options or large_read on old kernels).
> - */
> -static bool check_large_read(const char *opt, unsigned int len)
> -{
> -	struct utsname utsname;
> -	unsigned int kmaj, kmin;
> -	int res;
> -
> -	if (!opt_eq(opt, len, "large_read"))
> -		return false;
> -
> -	res = uname(&utsname);
> -	if (res == 0 &&
> -	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
> -	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
> -		fprintf(stderr,
> -			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
> -			progname, kmaj, kmin);
> -		return true;
> -	}
> -	return false;
> -}
> -
>  /*
>   * Check if user has permission to use allow_other or allow_root options.
>   *
> @@ -1041,19 +1014,11 @@ static int prepare_mount(const char *opts, struct mount_params *mp)
>  			   !begins_with(s, "rootmode=") &&
>  			   !begins_with(s, "user_id=") &&
>  			   !begins_with(s, "group_id=")) {
> -			bool skip;
>  
>  			if (check_allow_permission(s, len) == -1)
>  				goto err;
>  
> -			skip = check_large_read(s, len);
> -
> -			/*
> -			 * Skip deprecated large_read to avoid passing it to
> -			 * kernel which would reject it as unknown option.
> -			 */
> -			if (!skip)
> -				process_generic_option(s, len, &mp->flags, &d);
> +			process_generic_option(s, len, &mp->flags, &d);

Er... we should still ignore large_read, right?  It's been defunct since
2.4, but there could be some script/fstab/whatever that still contains
the mount option.

--D

>  		}
>  		s += len;
>  		if (*s)
> 
> -- 
> 2.43.0
> 
> 
