Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5F1E376C
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447012; cv=none; b=Zqm65BhoMJaNE4r8MKWSACytzfZwbo3ygKGm9pPXZ1BmlmcSt71KHbdl7u85ULove5I+CtsmiVF/wGEFIUwgfL2e2bUMAc+xd20380Eb8OB4BGbHSLH7neab6RR0o9inn4bDQFKiZrUU++NA+3VQlXiFNquX4rNIkbSgkkfQpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447012; c=relaxed/simple;
	bh=HGkcfuzNAGSub25gSFivbL1ImgUmG4g+QayS0Xo25n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTJqIxtPxb0SlB56pS9y0+bO61MFGYEIbHHxwSFRk+e3v+4d35kqYZSd+VSqklXHpBmBTz23vrWzyDixxOG0G0kicIne8IMfZMHDrvl0IGzLHX3cxVJODj+yryeS4k7w9b8a3yf1AazEG1FvgQ0AQ4KI3ZRoMqrtiCl5SunPDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6JyEvcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6JyEvcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B759AC19421;
	Sat, 14 Mar 2026 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773447011;
	bh=HGkcfuzNAGSub25gSFivbL1ImgUmG4g+QayS0Xo25n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6JyEvcPgSgHFu8B+HqFHheWRjX/gfRp/48Ngq8pGQNpI5KJJMAU7rfSS44MTrFHa
	 u4urAEOxZ6SZxlm/ivBKc6UlYfBGp2KFBsr5N8RCGbmGlFbJksTTfWRbjqg/+KrRyd
	 jb5YeVl6l7vdPTis1qIxwWhnH2fOg6/mfVWkSv5slNuogwKstH0iIKph2safo0Jqro
	 /XKRnHcLESijtABdQYYM4By9ub4KDbk4KCTH7avBFeI1sqHdAxNUTUWHcl96irllk9
	 46KiiRqBh0Rxw4nrVRZANhTXlaH9RtfCRqK/w5MADTpH4If0ZcjxBc3XgGjwhnh3/y
	 8ym0XChZ0SSDQ==
Date: Fri, 13 Mar 2026 17:10:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 6/6] fuse: support FSCONFIG_SET_FD for "fd" option
Message-ID: <20260314001011.GI1742010@frogsfrogsfrogs>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-7-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-7-mszeredi@redhat.com>

On Thu, Mar 12, 2026 at 08:40:04PM +0100, Miklos Szeredi wrote:
> This is not only cleaner to use in userspace (no need to sprintf the fd to
> a string) but also allows userspace to detect that the devfd can be closed
> after the fsconfig call.

Heh, I was just about to reply to the previous revision with "hey, have
you thought about converting to fsparam_fd?" :)

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Looks fine to me -- the fuse dev file points to a fud, and the the fud
won't outlast the fd so the fget/fput look right to me.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/inode.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f951f8d69e47..5608ed5ba000 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -788,7 +788,7 @@ enum {
>  
>  static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_string	("source",		OPT_SOURCE),
> -	fsparam_u32	("fd",			OPT_FD),
> +	fsparam_fd	("fd",			OPT_FD),
>  	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
>  	fsparam_uid	("user_id",		OPT_USER_ID),
>  	fsparam_gid	("group_id",		OPT_GROUP_ID),
> @@ -800,9 +800,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	{}
>  };
>  
> -static int fuse_opt_fd(struct fs_context *fsc, int fd)
> +static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
>  {
> -	struct file *file __free(fput) = fget(fd);
>  	struct fuse_fs_context *ctx = fsc->fs_private;
>  
>  	if (file->f_op != &fuse_dev_operations)
> @@ -859,7 +858,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		return 0;
>  
>  	case OPT_FD:
> -		return fuse_opt_fd(fsc, result.uint_32);
> +		if (param->type == fs_value_is_file)
> +			return fuse_opt_fd(fsc, param->file);
> +
> +		struct file *file __free(fput) = fget(result.uint_32);
> +		return fuse_opt_fd(fsc, file);
>  
>  	case OPT_ROOTMODE:
>  		if (!fuse_valid_type(result.uint_32))
> -- 
> 2.53.0
> 
> 
