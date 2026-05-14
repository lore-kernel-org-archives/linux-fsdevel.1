Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D053CBE79;
	Thu, 14 May 2026 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795071; cv=none; b=FR6pc6NaShGdPIsk1edDeE5QgHuNfgmwww4ZF0Jxf+UwXhtenG5YovmTSZXy4XCE9ZeQ3XWUOBT/UGCuiv+nfaGo4K4wE/6jNd0aBG3Jb2kK/OM42IxdD1ho0WTqxENwEOKHiLJZzXYylqWV6Y5C198nCEHxjOQz/CHbneYgoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795071; c=relaxed/simple;
	bh=Bw4Uldxs72IIEkU2xSYd+EFDgTYgX/yZRTMhnpX7auk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRSykSqZjor2S7ytrgOtrshK5zcIRe5uL+stK0WlP8q017e4jJo/Ejki39SQLOflIFQmePN7ofJ8pVHr+tj1XmYGWzZ9ZumSAFqmRuySqn+LUmX0ZPAsJZdRTTQ2Q2CmiF97nave9CJ97GQgmu0b7mM2hrl2/ShPAVo4t7cmuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOJSy87X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOJSy87X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E83C2BCB3;
	Thu, 14 May 2026 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778795071;
	bh=Bw4Uldxs72IIEkU2xSYd+EFDgTYgX/yZRTMhnpX7auk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOJSy87XOtcsEhFlMHA1yCmmC9c4zFgAjJdkaW+Tw/IaPEr/vYazFnQ8byQqa5VU0
	 q9FknfRfFAkgFFYGRFlLpqQtzwrW9hPb88Cm6N1Zv4Og+8ANkYC19oJCVBs8f64Adl
	 rO4VR6K4RY4J4/UabAaArOf42FfU3gKFaqLrzM/hAHyHB0T0uN4J7rU7V7mUYClvmV
	 3LKssQKXhRvoq2p8teyek6ymANxQ3tow+kau6sbXl+bltsTI7tee4Qj9vzutTBNuCi
	 6MxKacnT12SAUQHXoyUbQ3sunykKlzGExrNN+1yoghIYcZhbVwmcrE8qn3MavGVrgN
	 //2SEjRzLWlSw==
Date: Thu, 14 May 2026 14:44:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 2/9] fuse: force a ctime update after a fileattr_set call
 when in iomap mode
Message-ID: <20260514214430.GH9544@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206531.4103309.3952036264187137944.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206531.4103309.3952036264187137944.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:33:36AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In iomap mode, the kernel is in charge of driving ctime updates to
> the fuse server and ignores updates coming from the fuse server.
> Therefore, when someone calls fileattr_set to change file attributes, we
> must force a ctime update.
> 
> Found by generic/277.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/ioctl.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> 
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index fdc175e93f7474..07529db21fb781 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -546,8 +546,13 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
>  	struct fuse_file *ff;
>  	unsigned int flags = fa->flags;
>  	struct fsxattr xfa;
> +	struct file_kattr old_ma = { };
> +	bool is_wb = (fuse_get_cache_mask(inode) & STATX_CTIME);
>  	int err;
>  
> +	if (is_wb)
> +		vfs_fileattr_get(dentry, &old_ma);
> +
>  	ff = fuse_priv_ioctl_prepare(inode);
>  	if (IS_ERR(ff))
>  		return PTR_ERR(ff);
> @@ -571,6 +576,12 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
>  
>  cleanup:
>  	fuse_priv_ioctl_cleanup(inode, ff);
> +	/*
> +	 * If we cache ctime updates and the fileattr changed, then force a
> +	 * ctime update.
> +	 */
> +	if (is_wb && memcmp(&old_ma, fa, sizeof(old_ma)))

The ctime update should only happen if there's no error.  Oops.

--D

> +		fuse_update_ctime(inode);
>  
>  	return err;
>  }
> 
> 
