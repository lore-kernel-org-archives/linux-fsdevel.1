Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB532F749
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381914; cv=none; b=IQbZ5+h436Tazsry1+q1YcTr6SHs4KIK2r61/CfuFzltdjDdHhU9C/ghtw8Ozo7W26gb3X87NfpXUr6rFdJh3i3I6NF5oiT5p12Y7fyzBx0dMblPuF6bBC2UIrJwjnsYcYExBkn4bakEVSHBTJdTRb5Lo9BI7MtHHmhM1TE62dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381914; c=relaxed/simple;
	bh=Gr0EURGRLvnv28/HS5q7loeINuX1bjwxPP2NheRmMuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd98qws93s2aK6nIe5qXEIUkmohh83v+vBuugtkCtnm/CCjvDDnhlENYv17Julyyq8XKlUB7ntkMHh6j53D9OaK26d7YyTSqOuBnRPJZsaifZ7qQOpzAy7S+ZETi42r4LpwFrZQrLBaWUwmohnTwmRrYSEZ6BcndSKNbwDa0MOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiVbcLuK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiVbcLuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F166C2BC9E;
	Tue, 24 Mar 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381914;
	bh=Gr0EURGRLvnv28/HS5q7loeINuX1bjwxPP2NheRmMuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiVbcLuKkvU9JjQ+SbROgEDMfvGPlSx1VU3bp1UAhsnLt5thzcaWuz8B6UMCQFkmE
	 OSy/Yf00r84+48sacPCUzhsf87LppUcRe7IAkrSIlTd2FMnb+K6+Po3HZRs3JWpO0/
	 OdIey9opa8wmixIqoDApSOFvfuiAeXUwK+jHyb14PIzzUHCuzOPtfjIg7lxZT/0Nvx
	 BKvZR1qjPTY7u1mjVp5YlmYteUas2hnLzXFLe2gIav6Ej/Nswj44SAq9IVzM3W7bK2
	 Yhl/iVllsTrsvRZ63+42FzWTfvqJvQOeiezl/w7MHRr0Jt7iOcOd65aZgYrUvK+xBw
	 Oq4wDm7KCCXzQ==
Date: Tue, 24 Mar 2026 12:51:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 18/19] New mount API: Filter out "user="
Message-ID: <20260324195153.GU6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-18-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-18-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:13PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This gets added in the fusermount process and kernel then fails
> the mount.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  lib/mount_fsmount.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> index f1fec790bb80f8815d485a068dc7efdff1746309..76c14cf9a22465160fc6b206ca9b6c9e7300adba 100644
> --- a/lib/mount_fsmount.c
> +++ b/lib/mount_fsmount.c
> @@ -218,6 +218,16 @@ static int is_mount_attr_opt(const char *opt)
>  	       strcmp(opt, "symfollow") == 0;
>  }
>  
> +/**
> + * Check if an option is a mount table option (not passed to fsconfig)
> + */
> +static int is_mtab_only_opt(const char *opt)
> +{
> +	/* These options are for /run/mount/utab only, not for the kernel */
> +	return strncmp(opt, "user=", 5) == 0 ||
> +	       strcmp(opt, "rw") == 0;

Oh, so these are added to the mount options string by get_mnt_opts
and now they need to be pulled out so they aren't passed to fsconfig?
How'd they get into the argument list in the first place?

--D

> +}
> +
>  /*
>   * Parse kernel options string and apply via fsconfig
>   * Options are comma-separated key=value pairs
> @@ -241,7 +251,8 @@ static int apply_mount_opts(int fsfd, const char *opts)
>  	opt = strtok_r(opts_copy, ",", &saveptr);
>  	while (opt) {
>  		/* Skip mount attributes - they're handled by fsmount(), not fsconfig() */
> -		if (!is_mount_attr_opt(opt)) {
> +		/* Skip mtab-only options - they're for /run/mount/utab, not kernel */
> +		if (!is_mount_attr_opt(opt) && !is_mtab_only_opt(opt)) {
>  			res = apply_opt_key_value(fsfd, opt);
>  			if (res < 0) {
>  				free(opts_copy);
> 
> -- 
> 2.43.0
> 
> 
