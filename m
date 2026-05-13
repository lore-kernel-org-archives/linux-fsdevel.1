Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF53B1034;
	Wed, 13 May 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707452; cv=none; b=CqPBLX3RcdK6s8wyMabie7rz+iJ2YZgOGXAqFYyYa/2FIqWwpL/4S3XrsROmm7w+xA0UvuLc0uqqdJ+m4Mb+cgZu7/qY+8HY+hlWkro4plnQGF68dfiIxmZ+bXz5iTDleOga8cFiiNFxRSlcYJjB82xV5b7NffjdjtzMOUjt0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707452; c=relaxed/simple;
	bh=ayi/NOaQHXPH3yBZXhDLPTYN4/A2wV53gbgrWn4OOp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy/W+8/eHcniypxfHbecxz+SjWMZ0CulAj0qAxZA8Pv+At+xmrugfjSqJHD2AZxq+FIlPEZltU8CUySd1aPu5It3qzSZdA6WQTcyED53InGe0QyGrYa/BmlK0qYbcxx7ArQ2GZ02mKvWKXph8RQCdCK7rgLo5nuELu88umWGByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyDArH7P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyDArH7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED67EC19425;
	Wed, 13 May 2026 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778707452;
	bh=ayi/NOaQHXPH3yBZXhDLPTYN4/A2wV53gbgrWn4OOp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyDArH7PZ3dcQQnGlgd36EtCmYX/ClNY+oQXqChHzYWrdjm0FX/VnA/vkEKP1u4AL
	 WuAAK/2SAFJQskxlVdIkswbAKgnPCFEXrBDp7d/tMwfjP5NWA8zNEZRWhbQvWS0kcm
	 HwfYIAfR49Mz0mmEXOXVf01Rv7wK9WccsiJxuDZw0YF6WvaFNXoBUbiBvvH3wL2Fg3
	 1jLVxrtiKosiYXcZqPlvcEtOCrZ23tgvnsjutaL6w5eC3zEvjewAXzYZfwE4NobVrD
	 tDAjk6yBjXI64skoQ7w2Et6AuZJAN4u8tYDNpP6ZJKWSrmCUZlNZGCByDj7i1ZWjQz
	 oNjd5K7x8GSeA==
Date: Wed, 13 May 2026 14:24:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 18/33] fuse: use an unrestricted backing device with
 iomap pagecache io
Message-ID: <20260513212411.GS9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205537.4101881.12951730049525918450.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205537.4101881.12951730049525918450.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:28:23AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> With iomap support turned on for the pagecache, the kernel issues
> writeback to directly to block devices and we no longer have to push all
> those pages through the fuse device to userspace.  Therefore, we don't
> need the tight dirty limits (~1M) that are used for regular fuse.  This
> dramatically increases the performance of fuse's pagecache IO.
> 
> A reviewer of this patch asked why we reset s_bdi to the noop bdi and
> call super_setup_bdi_name a second time, instead of simply clearing
> STRICTLIMIT and resetting the bdi max ratio.
> 
> That's sufficient to undo the effects of fuse_bdi_init, yes.  However
> the BDI gets created with the name "$major:$minor{-fuseblk}" and there
> are "management" scripts that try to tweak fuse BDIs for better
> performance.
> 
> I don't want some dumb script to mismanage a fuse-iomap filesystem
> because it can't tell the difference, so I create a new bdi with the
> name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
> gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
> here due to ENOMEM so ... I implemented this weird switcheroo code.
> 
> Also, userspace scripts such as udev rules can modify the bdi as soon as
> it appears in sysfs, so we can't run the fuse_bdi_init code in reverse
> and expect that will undo everything.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index 3136326bafb858..3c40a1e58017b3 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -718,6 +718,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
>  void fuse_iomap_mount(struct fuse_mount *fm)
>  {
>  	struct fuse_conn *fc = fm->fc;
> +	struct super_block *sb = fm->sb;
> +	struct backing_dev_info *old_bdi = sb->s_bdi;
> +	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
> +	int res;
> +
> +	/*
> +	 * sb->s_bdi points to the initial private bdi.  However, we want to
> +	 * redirect it to a new private bdi with default dirty and readahead
> +	 * settings because iomap writeback won't be pushing a ton of dirty
> +	 * data through the fuse device.  If this fails we fall back to the
> +	 * initial fuse bdi.

Codex points out that it's possible to create non-iomap regular file
inodes after we've set up this fuse.iomap bdi.  If that happens, the
non-iomap files won't be subject the strictlimit/max_ratio restrictions
imposed on non-iomap fuse filesystems.  I don't think this is a serious
concern because one has to have CAP_SYS_RAWIO privilege to enable iomap,
but I'll change this patch to put back the old behavior.

--D

> +	 */
> +	sb->s_bdi = &noop_backing_dev_info;
> +	res = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
> +				   MINOR(fc->dev), suffix);
> +	if (res) {
> +		sb->s_bdi = old_bdi;
> +	} else {
> +		bdi_unregister(old_bdi);
> +		bdi_put(old_bdi);
> +	}
>  
>  	/*
>  	 * Enable syncfs for iomap fuse servers so that we can send a final
> 
> 
