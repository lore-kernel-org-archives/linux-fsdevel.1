Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918135F8AF
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278572; cv=none; b=np4qH/R8UWcqxY5XNWxSe6fpuIn/9GplCWoEyYx+FAdoNiHFfSslqPvznMpuDRtxJm/od5GMb20zH+lYQSf30LKsHYooDoJrIhkfrynoJWIyWbFlO/ifQGn0MeXXavPTF7uv0uDuJ7d5jHkS+i608dStqauFZ+wj/qy0pycbp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278572; c=relaxed/simple;
	bh=XjyS92S0VapFobohq557H9lH+lDGYvPnVszpqaZ4Ub8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKz/63cz/bnM9kLZaXg+m1U15SwWTjRpNIAoTHs2VIZMG5mURNL7Zp6Bx30Mrx1Op755tv5dXtD5dh2Pv3mNmpROUtXbXYUMcQzt/ID4ZCwjkXtoMXGQKBC8W0WHNktBAL4T1/xgPRKnMxk30gt6Op0vzcA2/l+Sc4Vp0f2/qOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FYvJjHjQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FYvJjHjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C121BC19423;
	Thu,  5 Feb 2026 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770278572;
	bh=XjyS92S0VapFobohq557H9lH+lDGYvPnVszpqaZ4Ub8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYvJjHjQ0hJOTh3LzmoZJRESURjTFqTaF2qFxb9jThZ0vDCOz2SWnxDomZsJTmLwZ
	 gXGJ5pv4DcFNnloFS0GQ+CQLt4eNA5KVrdnfqYS/FmJzrnJKRPfTfPQjTY56vegr0g
	 AXXQ91WpAMiSEVcTSZ1jQKVZkmgXLaOzvLrPB9fw=
Date: Thu, 5 Feb 2026 09:02:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH][RFC] rust_binderfs: fix a dentry leak (regression from
 tree-in-dcache conversion)
Message-ID: <2026020533-covenant-overstuff-ea0f@gregkh>
References: <20260205074342.GR3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205074342.GR3183987@ZenIV>

On Thu, Feb 05, 2026 at 07:43:42AM +0000, Al Viro wrote:
> [just realized that this one had been sitting in #fixes without being
> posted - sorry]
> 
> Parallel to binderfs patches - 02da8d2c0965 "binderfs_binder_ctl_create():
> kill a bogus check" and the bit of b89aa544821d "convert binderfs" that
> got lost when making 4433d8e25d73 "convert rust_binderfs"; the former is
> a cleanup, the latter is about marking /binder-control persistent, so that
> it would be taken out on umount.
> 
> Fixes: 4433d8e25d73 ("convert rust_binderfs")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/android/binder/rust_binderfs.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
> index c69026df775c..e36011e89116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -391,12 +391,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
>  	if (!device)
>  		return -ENOMEM;
>  
> -	/* If we have already created a binder-control node, return. */
> -	if (info->control_dentry) {
> -		ret = 0;
> -		goto out;
> -	}
> -
>  	ret = -ENOMEM;
>  	inode = new_inode(sb);
>  	if (!inode)
> @@ -431,7 +425,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
>  
>  	inode->i_private = device;
>  	info->control_dentry = dentry;
> -	d_add(dentry, inode);
> +	d_make_persistent(dentry, inode);
> +	dput(dentry);
>  
>  	return 0;
>  
> -- 
> 2.47.3
> 

Nice!  Want me to take this in my tree, or are you going to send this to
Linus before -final happens?

thanks,

greg k-h
