Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387A2D1913
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582368; cv=none; b=NbOUYOHdH/z1Nd3TZ9bQrx0ZkNZg0qFSVU0xizcZLHW1KALOshFhlezKFK+Rk8TMlQTKFC+xMluYxc3INM7NHOwWbeaGYCjiJdftRc2mwJ830eyEEThygHaYlVFQReINRvkpZWJMT5x4VqO71f1P6LuJ1xyJGI+6BmPfFQoIx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582368; c=relaxed/simple;
	bh=tUtYRyBiGHe6NQ0782pNjafaqelPmwEdb/Ij4K44aCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM0fvEQWmLktpA9YBjT9eEpAJ2OHVhuiqalSPlUqFQrLhHeeT3dW8tOhAs58+8uTAIl8D99Ku9PDRZDAbsh6NBRSsWRjfTNzfi/nE3LEVnZ1mGewrZwpytkXzmFMtMjGdjm5EutY3O+t8Tl3W0iuAY5CniY+TuW8O4C/Ks009gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2FH7C56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2FH7C56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973BC19423;
	Fri, 27 Mar 2026 03:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582368;
	bh=tUtYRyBiGHe6NQ0782pNjafaqelPmwEdb/Ij4K44aCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2FH7C56dVc//1/WASX8wWcpPeyskPVel9CEvQdevXnPlvnFnAAbLuDlaqAtmhZ5n
	 f9fU6KyMXnBpmKevRwZef4jC2F2+pDw+h2tywdkAbe1Lr0wbLiWJJEoM4APgvXDlU+
	 IJOWoN/h/6Bkbq6qUDVwmJLn8ITDDr41JOmnGwVLOqkRbgwZm1JQCRyZRLznU+ZR/w
	 CULBgqqKt7HLDAqcb51xwpQzun+/9M9lw79AtXCHCun9XTrRMgmRBaBXm2Eq0daem0
	 gA+6xoZvhTitBuXwRonFMAHWeA6FT5BsN7f7lIo6hjbtvcMPnJFsgT4dPEwj7GJhCI
	 QV5B8FVy2QYIw==
Date: Thu, 26 Mar 2026 20:32:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>, OM@magnolia.djwong.org
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 21/25] New mount API: Filter out "user="
Message-ID: <20260327033247.GO6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-21-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-21-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:54PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This gets added in the fusermount process and kernel then fails
> the mount.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Now that I've wrapped my head around the utab-only options I feel more
confident in saying

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/mount_fsmount.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> index fbe3647a8923828dba819458b815c21bbd2beaad..f42ae97faedaf2420d97e701a22725d4293e4853 100644
> --- a/lib/mount_fsmount.c
> +++ b/lib/mount_fsmount.c
> @@ -248,6 +248,16 @@ static int is_mount_attr_opt(const char *opt)
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
> +}
> +
>  /*
>   * Parse kernel options string and apply via fsconfig
>   * Options are comma-separated key=value pairs
> @@ -275,6 +285,7 @@ static int apply_mount_opts(int fsfd, const char *opts)
>  		 * not fsconfig().
>  		 *
>  		 * These string options (nosuid, nodev, etc.) are reconstructed
> +		 * Skip mtab-only options - they're for /run/mount/utab, not kernel
>  		 * from MS_* flags by get_mnt_flag_opts() in lib/mount.c and
>  		 * get_mnt_opts() in util/fusermount.c. Both the library path
>  		 * (via fuse_kern_mount_get_base_mnt_opts) and fusermount3 path
> @@ -282,8 +293,10 @@ static int apply_mount_opts(int fsfd, const char *opts)
>  		 * mnt_opts. They must be filtered here because they are mount
>  		 * attributes (passed to fsmount via MOUNT_ATTR_*), not
>  		 * filesystem parameters (which would be passed to fsconfig).
> +		 *
> +		 * Also skip mtab-only options - they're for /run/mount/utab, not kernel
>  		 */
> -		if (!is_mount_attr_opt(opt)) {
> +		if (!is_mount_attr_opt(opt) && !is_mtab_only_opt(opt)) {
>  			res = apply_opt_key_value(fsfd, opt);
>  			if (res < 0) {
>  				free(opts_copy);
> 
> -- 
> 2.43.0
> 
> 
