Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255263EF0DD;
	Mon, 11 May 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507757; cv=none; b=P3aE/Ur2+s1xuPe2lr2O65n7cOQpoc8aLnRUCaJerbFnHBCfUQH/ksLuFReDmjvE6BX8yC7jEMeSfml8Xu7AVM6I5ka+ChVtiaIzE+lt+I0s99w1fhLw9oCKG8b8JCw3TrQYmiB3a5YvNdsh1ALGuotPoYbIcVS0IE9uKd2oEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507757; c=relaxed/simple;
	bh=vCrjaEbbcaXQl8iPMdr3msEDtU4yb0V793gKDfa6qT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMhe0mJCRd5I7TUEfxPuIUw89fUQ72OUDFiSlSOds3OfXU4lupihvNRIJh4asCzsSBfQp6++57Ep02Q0yaetiOpFb4PII3d/OSka0Tjbwxd6UD9S0QZVlM/w4+g03j2W7WfPDO9ClL839s9BHqKpCIBovA1YmAyu0z5WLtYWzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffskXTmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffskXTmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86929C2BCB0;
	Mon, 11 May 2026 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507756;
	bh=vCrjaEbbcaXQl8iPMdr3msEDtU4yb0V793gKDfa6qT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffskXTmcJLYHSEaRfczLiKCzIbafmSZoQ3WdX+0z7DR0//aX9q34DiE1IdR44akAN
	 3LF1/SKKAfBxFIBT/0X0HXIxdvOJCjlKX9kl94d3UHOr3ZHEnEvwyekYHIyNVpDmJR
	 s9lbfTkN+TAuiB0xBw9HVBMqoXhHcBuyGXylqdX8ry98XssfJEsg6H4RQddK7M4I1h
	 wpAYE5kNMf4s8pCCGkFFqGlf8NCPRNb6638CT0E8iNowT7tRVyVsdrwWZCIIv6sIjV
	 biql1ovncYMHiLn7OJGApwwuekgToUclyMFVayUzYOMhOdZ3gORo2+RDbQsxepDlf+
	 YQmUeP5KFDH4g==
Date: Mon, 11 May 2026 15:55:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: zhaoguohan@kylinos.cn
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: use current creds for backing files
Message-ID: <20260511-unkenntlich-umsetzen-85d81af991bc@brauner>
References: <20260510145437.321141-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260510145437.321141-1-zhaoguohan@kylinos.cn>

On Sun, May 10, 2026 at 10:54:37PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> FUSE backing files only need a stable snapshot of the current credentials
> for later backing-file I/O. prepare_creds() allocates a mutable copy and
> can fail, but this code never modifies or commits the result.
> 
> Use get_current_cred() instead and store it as a const pointer. This
> matches the rest of the backing-file helpers and avoids an unnecessary
> allocation and failure path.
> 
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---

Seems reasonable,
Acked-by: Christian Brauner <brauner@kernel.org>

>  fs/fuse/backing.c | 2 +-
>  fs/fuse/fuse_i.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index d95dfa48483f..8efb43b17c4d 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -118,7 +118,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>  		goto out_fput;
>  
>  	fb->file = file;
> -	fb->cred = prepare_creds();
> +	fb->cred = get_current_cred();
>  	refcount_set(&fb->count, 1);
>  
>  	res = fuse_backing_id_alloc(fc, fb);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 17423d4e3cfa..36041e405bf8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -106,7 +106,7 @@ struct fuse_submount_lookup {
>  /** Container for data related to mapping to backing file */
>  struct fuse_backing {
>  	struct file *file;
> -	struct cred *cred;
> +	const struct cred *cred;
>  
>  	/** refcount */
>  	refcount_t count;
> -- 
> 2.43.0
