Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE2220F49;
	Wed, 22 Apr 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868415; cv=none; b=imSw/OQRSkVBgspiHwB3YIRpNaTRKenAE1H5PC5XvG19XeqrDq4g3K5gqNu2MrRTeNWU+JBheK/MawQzyObIewB5bknDPBquvUp8iSLiWzlJW7eazmgPhrGsjsTNMu+j5o4/BosDAeRhTG6jobqd3145Hwyh6qKWbXZV9FffOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868415; c=relaxed/simple;
	bh=hTpKf3xXyqu5R/ARcPMIxpu1JOoZsLBh7xkCJYsdWEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPx0IUTwm+LU6Bx3AN9YkQ8BuVJwNjgdbc7nUPvnapNIV4/1NKuGNO91M7YbYixLfg6GXXzqIeCMVk0t0fmjdP0CAEUD0msFjgsLM+nJMCB16zXxg7JfNBwljrfbD5hOAXTbIgcODc1fyzPW9dN/p9IJvBj6JW3QUiRK7+U7IZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZZK0IVBB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZZK0IVBB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F+Mic/SuIy5jE7Cs5d0nYwwmG6gAVLo4UmfS6lXjfJk=; b=ZZK0IVBBkzzNHmf2oXAZHBfd5L
	GMVh4jPMjmial8/75ENyysGJDqnovGXwgs5zmyWxF4Jb4xBo5RhAUZfAvMTDFze4VsPpJqNXy/cY/
	JxgZTrcfrnD3PaFZviqTjUMMbtk6B3zKdkQMbdQCRKTfj8UYleAyWdRPmRhqbs0qKL3KdmOL+zRnp
	3E1h2T9BF3nMCkOhqulKtrLp0IMnFITsEv46iT9Mby91ohy1o/73/MwbmJYp/2XfNiek968auk4e8
	Ve/q9gNanLpoDQkgktvIx3W47beD/EIEaNtyrFD0DSCq/j9AdSck8uoM+oHIo8i8rNj/eCwKkZglu
	ilO2+z0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFYhx-00000006Bd8-3NUe;
	Wed, 22 Apr 2026 14:37:41 +0000
Date: Wed, 22 Apr 2026 15:37:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: use QSTR() instead of QSTR_INIT() in path_pts
Message-ID: <20260422143741.GJ3518998@ZenIV>
References: <20260422123002.99876-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422123002.99876-3-thorsten.blum@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 22, 2026 at 02:30:03PM +0200, Thorsten Blum wrote:
> Drop the hard-coded length argument and use the simpler QSTR().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..817bba800d7b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3617,7 +3617,7 @@ int path_pts(struct path *path)
>  	 */
>  	struct dentry *parent = dget_parent(path->dentry);
>  	struct dentry *child;
> -	struct qstr this = QSTR_INIT("pts", 3);
> +	struct qstr this = QSTR("pts");
>  
>  	if (unlikely(!path_connected(path->mnt, parent))) {
>  		dput(parent);

NAK.  Compound literal is an l-value, so let's just use it:
	child = d_hash_and_lookup(parent, &QSTR("pts"));
and to hell with the local variable.
