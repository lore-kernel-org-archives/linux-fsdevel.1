Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE212C534;
	Thu, 14 May 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796993; cv=none; b=K1BSsg6N3kWRoaSRt4XcmZaCgmVu0d2QyuHomArwRsvR0/VkUQA0u6Wjr5aBjzkqMyKOO9dY6/ND8J0AllIU428SJHZ0eF/um67s7ToSAFpr5sjvnc1cPnB66fzwU52mgc7VPYfPS/FQ4ugdg+j+vdnJqGhz5Jcha0YFiT+iiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796993; c=relaxed/simple;
	bh=TYoYlD+yD6WvPaGhylw3zTLT022I3VWRam42XwHCKR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoTCQ2Hfe07QNeNG2Bwlc0attV4vfVZ6mRutgtopc15uVY03wgXaL0nGuC7Hqci7uCc9/u3zbj4Bt/uXDK5ZtJ2pOcvwKwFB8ZaaDEhbAnFG13lF+ZzV1lcVrvg0rHQoFbO+3wCjqge/yTZpMyiOtuAv0ud87pKABte3A3Zxqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2HxbQJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2HxbQJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67862C2BCB3;
	Thu, 14 May 2026 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796993;
	bh=TYoYlD+yD6WvPaGhylw3zTLT022I3VWRam42XwHCKR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2HxbQJ+OA2pcGCrUJdkYwgi1X/PTFm/Zwr02xjHZ/AfQSDi33npiDqka5tHr7AD0
	 Mgib72FrPhKHb81gAPCOpPZ6JztV3Atc+Nl/s1dgAvqtm/M0wJJukad31bq2IAGBVN
	 mqBh+HTwALsf+Bkfwu1ys7w7hTjwfl1v/vpcN3DLBah+oI44l4lDp7dv9XidW7xr2Y
	 hgEpMorJA/r7u25KWxji4UpFxXM/Fv3sVf+vwl14TEj2W7j5HgXVOvpTT7Sb5JYwte
	 rOTNg/Hn/yWzl0rslJiBAP9mkgLJ1/c6CGqOU6SZMwSuLdH1W0XwbdWnETK54ORHUy
	 lqDO9gudW8/NA==
Date: Thu, 14 May 2026 15:16:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 5/9] fuse: cache atime when in iomap mode
Message-ID: <20260514221632.GK9544@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206595.4103309.11659424316192000821.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206595.4103309.11659424316192000821.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:34:22AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> When we're running in iomap mode, allow the kernel to cache the access
> timestamp to further reduce the number of roundtrips to the fuse server.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/dir.c        |    5 +++++
>  fs/fuse/fuse_iomap.c |    6 ++++++
>  fs/fuse/inode.c      |   11 ++++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 53fda7f63b11c8..61015e83888ee4 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2236,6 +2236,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
>  		inarg.ctime = inode_get_ctime_sec(inode);
>  		inarg.ctimensec = inode_get_ctime_nsec(inode);
>  	}
> +	if (fuse_inode_has_iomap(inode)) {
> +		inarg.valid |= FATTR_ATIME;
> +		inarg.atime = inode_get_atime_sec(inode);
> +		inarg.atimensec = inode_get_atime_nsec(inode);
> +	}
>  	if (ff) {
>  		inarg.valid |= FATTR_FH;
>  		inarg.fh = ff->fh;
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index a39370b97ca508..9278e2e399ba9b 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -1169,6 +1169,12 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
>  	if (attr->flags & FUSE_ATTR_ATOMIC)
>  		fuse_inode_set_atomic(inode);
>  
> +	/*
> +	 * iomap caches atime too, so we must load it from the fuse server
> +	 * at instantiation time.
> +	 */
> +	inode_set_atime(inode, attr->atime, attr->atimensec);
> +
>  	trace_fuse_iomap_init_inode(inode);
>  }
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index aa9f880b9a2ea6..1a09b9e1446919 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -266,7 +266,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
>  	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
>  
> -	inode_set_atime(inode, attr->atime, attr->atimensec);
> +	if (!(cache_mask & STATX_ATIME))
> +		inode_set_atime(inode, attr->atime, attr->atimensec);
>  	/* mtime from server may be stale due to local buffered write */
>  	if (!(cache_mask & STATX_MTIME)) {
>  		inode_set_mtime(inode, attr->mtime, attr->mtimensec);
> @@ -331,8 +332,12 @@ u32 fuse_get_cache_mask(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  
> -	if (S_ISREG(inode->i_mode) &&
> -	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +
> +	if (fuse_inode_has_iomap(inode))
> +		return STATX_MTIME | STATX_CTIME | STATX_ATIME | STATX_SIZE;
> +	if (fc->writeback_cache)

Every once in a blue moon I noticed that the atime falls behind the
ondisk ext4 filesystem in the stat output.  I *think* this is a result
of fuse_change_attributes_i not overwriting the supplied attr->atime
with whatever's in the inode.  I'll change that, and let's see if the
periodic fstests complaints go away.

--D

>  		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
>  
>  	return 0;
> 
> 
