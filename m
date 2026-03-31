Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFF39E6F8;
	Tue, 31 Mar 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956219; cv=none; b=IAopahau/0TjK17/addB69PtNs7TVExthiyQp8yteEVfSYQh5oD+ZwdsY+Q9xy1s3yFDHj8Z7fQGzc8lRggPCtsw+i86sRsuk663/NUR0mWHHOVQkHjdEQ2oSWuAN0yITnfa7Q65yCAkmrZJnKXJXWRAkCXlWkl6ntaz34pSEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956219; c=relaxed/simple;
	bh=8jBs5TMEGs76aIt2ybPudRmQ3FFPX1V6HViXDRx5DOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys2DHJIVV9zrWUJlS1tfMF9mDEZ66lDFmIK0EyPsC8w3hAWN9uFqO8MwUAPOSWNHCi14AxGlpO0cAZdyyo1C5KYYlj1+KqibeqyargF+xswoVeQ5aJ4fs3mukkyUvp5jZ6WBzyUga11eLgY3O60W5W6fFL3tbn+swhFei8KRBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJSHDev7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJSHDev7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D18EC19423;
	Tue, 31 Mar 2026 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774956218;
	bh=8jBs5TMEGs76aIt2ybPudRmQ3FFPX1V6HViXDRx5DOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJSHDev7LDjhLCY+On+FgSjMxODhzdPxx2/XW3IdfJe/zsicbKQoXzn0OsK2CIiJ/
	 E7lMlKZZdlYtbW09SGvm/dHX3uTan3nDhcm9YPYotd5vUj9OABOqF3pgs3aNjwfPzp
	 S8HYSvqLov28o4SJd/mQ3DSXcloI4FPspDodbdufeUXdZo8vLV9r+vDNfzUGAGfXAa
	 5LA17+HYNLwsp60rSEmfgOw4uPO0aBRCWgcbbm0MFKbq6ogPXqqDM3vmTEroCOHuyE
	 shZzsgPVbbLH38wnsXvBh6wTE1ldvCLhZNsiWyalGJigB99DGzTiRjc1a6yuzmDF/N
	 pHQyViTkNdR2Q==
Date: Tue, 31 Mar 2026 13:23:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] fs: handle hypothetical filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
Message-ID: <20260331-ellbogen-wegrand-e98370e446e3@brauner>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
 <20260329172002.3557801-6-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329172002.3557801-6-mjguzik@gmail.com>

On Sun, Mar 29, 2026 at 07:20:00PM +0200, Mateusz Guzik wrote:
> f2fs and ntfs play games where they transitiong the refcount 0->1 and release
> the inode spinlock, allowing other threads to grab a ref of their own.
> They also return 0 in that case, making this problem harmless.
> 
> Should they start using the I_DONTCACHE machinery down the road while
> retaining the above, iput_final() will get a race where it can proceed
> to teardown an inode with references.
> 
> Future-proof it.
> 
> Developing better ->drop_inode and sanitizing all users is left as en
> exercise for the reader.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/inode.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 0050eca6d83f..a417abc64822 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1935,20 +1935,29 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = inode_generic_drop(inode);
>  
> -	if (!drop &&
> -	    !(inode_state_read(inode) & I_DONTCACHE) &&
> -	    (sb->s_flags & SB_ACTIVE)) {
> +	/*
> +	 * XXXCRAP: there are ->drop_inode hooks playing nasty games releasing the

Let's make that a "Note:" and remove that "XXXCRAP", please. The "nasty
games" is plenty meta commentary.

> +	 * spinlock and temporarily grabbing refs. This opens a possibility someone
> +	 * else will sneak in and grab a ref while it happens.
> +	 *
> +	 * If such a hook returns 0 (== don't drop) this happens to be harmless as long
> +	 * as the inode is not marked with I_DONTCACHE. Otherwise we are proceeding with
> +	 * teardown despite references being present.
> +	 *
> +	 * Damage-control the problem by including the count in the decision. However,
> +	 * assert no refs showed up if the hook decided to drop the inode.
> +	 */
> +	if (drop)
> +		VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
> +
> +	if (icount_read(inode) > 0 ||
> +	    (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
> +	    (sb->s_flags & SB_ACTIVE))) {
>  		__inode_lru_list_add(inode, true);
>  		spin_unlock(&inode->i_lock);
>  		return;
>  	}
>  
> -	/*
> -	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
> -	 * Note we only execute this if the verdict was to drop the inode.
> -	 */
> -	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
> -
>  	if (drop) {
>  		inode_state_set(inode, I_FREEING);
>  	} else {
> -- 
> 2.48.1
> 
