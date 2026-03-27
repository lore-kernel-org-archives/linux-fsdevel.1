Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377036C0C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581884; cv=none; b=U4QEUlzu0CyRtjVG42Ola6lxH/Y1GdaNiUcLVkvcVs6kto35jPz3xZr4aT3TtFLU6zJytSbsc1z0FGok0//FWRi+ADLTfRAPQNek2LQfDjPiUfWQ9JjEIMJHF65lRdln/3zlocqZ1limjc8i8fYqnc+nBr53jTbWrdKrZGG0jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581884; c=relaxed/simple;
	bh=EI1J/YGrpgVJWWgT3DeHtzT9A+DesYC1EzFtkroSfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aadQMxKSkvuEuC8d6AYpmX4Umd+bYBBnHl13q5F9STV6WiRNClCb94Ox+ljMaggDDg14VaTaPnjlxChI82cUHJo/zzKzsiCkTGt1vySlFkIJFIpZgbgJRtsluKIEJEzlxSREunW1fqz+jJQhfN3MqABU/Hge9Wu1ox58qpqvhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWECOwk6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWECOwk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2209C116C6;
	Fri, 27 Mar 2026 03:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581883;
	bh=EI1J/YGrpgVJWWgT3DeHtzT9A+DesYC1EzFtkroSfZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWECOwk6vLm814acBVRrofg6RLvDnVvPLTrfkVOnmvUUhD5zhyVy7j+OSvM7wemLX
	 OkPfiU2XFNBoIS//4Il4QXUr8luwx4JJy3EmKhKAfPy3dO0M0uDYNmFyTLxEltCn88
	 PztiU/ZggDjFKZV/4YlrJCbVVb2+UYh9WYXZSpDy4yph58m2zuhJpD4bOpVttFfjCv
	 Juh17GnxXMjyN0SAxeJtK6DyjQar1+qZ4k7v/5rmuWYlzsv6wSAgLPC3eCakvMjO9s
	 rmq2z22eG+/JsGoGcG+uJZQCivhxpVfTezbvmqQwaOygkmWEerxdNt7nWj2P6lqK6H
	 7SScl5X2naJjw==
Date: Thu, 26 Mar 2026 20:24:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 09/25] Use asprintf() for fuse_mnt_build_{source,type}
Message-ID: <20260327032443.GL6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-9-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-9-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:42PM +0100, Bernd Schubert wrote:
> Simplify the code by using asprintf.
> 
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  lib/mount.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index fe353e2cc4579adb47473cac5db7d1bae2defb2c..68f9219d2b8beee51346b198ce826138b9528e73 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -754,32 +754,30 @@ char *fuse_mnt_build_source(const struct mount_opts *mo)
>  {
>  	const char *devname = fuse_mnt_get_devname();
>  	char *source;
> +	int ret;
>  
> -	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
> -			(mo->subtype ? strlen(mo->subtype) : 0) +
> -			strlen(devname) + 32);
> -	if (!source)
> +	ret = asprintf(&source, "%s",
> +		       mo->fsname ? mo->fsname :
> +				    (mo->subtype ? mo->subtype : devname));

That works, though I had been expecting something more like:

	if (mo->fsname)
		ret = asprintf(&source, "%s", mo->fsname);
	else if (mo->subtype)
		ret = asprintf(&source, "%s", mo->subtype);
	else
		ret = asprintf(&source, "%s", devname);
	return ret ? NULL : source;

Eh whatever :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	if (ret == -1)
>  		return NULL;
>  
> -	strcpy(source,
> -	       mo->fsname ? mo->fsname : (mo->subtype ? mo->subtype : devname));
> -
>  	return source;
>  }
>  
>  char *fuse_mnt_build_type(const struct mount_opts *mo)
>  {
>  	char *type;
> +	int ret;
>  
> -	type = malloc((mo->subtype ? strlen(mo->subtype) : 0) + 32);
> -	if (!type)
> +	if (mo->subtype)
> +		ret = asprintf(&type, "%s.%s", mo->blkdev ? "fuseblk" : "fuse",
> +			       mo->subtype);
> +	else
> +		ret = asprintf(&type, "%s", mo->blkdev ? "fuseblk" : "fuse");
> +
> +	if (ret == -1)
>  		return NULL;
>  
> -	strcpy(type, mo->blkdev ? "fuseblk" : "fuse");
> -	if (mo->subtype) {
> -		strcat(type, ".");
> -		strcat(type, mo->subtype);
> -	}
> -
>  	return type;
>  }
> 
> -- 
> 2.43.0
> 
> 
