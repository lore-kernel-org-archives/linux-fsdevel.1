Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0673C0604;
	Thu, 14 May 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797129; cv=none; b=nPAOfZBeUthVeZedKO4dFugZ1QLpgrw7VGeywMCINwcpVDmYzRhLueIaHXwpEqKFZqa/sfz/Fb/nmblgRyxK6ml8tpTkBlaWwvDep64bCch0LPDf1IwIUAoZ/uz+R5JQGFCGbs9YWffcoCcB4X0UqaexEuRUgvOYH5/Vbv973iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797129; c=relaxed/simple;
	bh=TtWIQYaTjtVFGkW6QswKJtPwJB2r9tBFC7UWZMl/fVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqX4zbS1BdXy5bUolFEmSCoHSkpL6UlO1uJxkdL3983YOuFzyOp2xwCjKpfCV3U/4IaW0Iq2RH+WUQTq0az/sBjFjLGj/oEKY5nxxLtyAI65BMIXGGU+DurzgeUrNGRzbfN6Lq2cpgCBeQEq5VHhl+/heQJrQuoi/fiN+1Yr3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fls9sQG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fls9sQG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E5C2BCB3;
	Thu, 14 May 2026 22:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797128;
	bh=TtWIQYaTjtVFGkW6QswKJtPwJB2r9tBFC7UWZMl/fVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fls9sQG3u8LzNgA1vwHTJCZOcnrYzQ4VYiBsxVmsOJp6tEhGkIxhEiD1D80tYtT9F
	 mjPipKwwXcG+6ODxL0Eupc1PxD6ZRt9Qv3vWeS7J/nbwMuplYp5WYdZRyByay+OpvA
	 ush191b9nDh/L5eiOojJVhYbn45/b0sFtKQ4cw30bcA5RSaBGdpMF19u6XwseeWoAV
	 SIsEaITynbcl3SNJc5nnOxMj/A5SjQZ6gGmJiwBr/TrGWblSWb8YHFoxtH4ruepMTN
	 4n8CdKBUva3GncJJ3it3zHFmb0LIARtcJzt4GDdIVdXHA3RnQSCjWyInDcUfqFH4gx
	 XSidtYySyyE8g==
Date: Thu, 14 May 2026 15:18:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
Message-ID: <20260514221847.GL9544@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206617.4103309.9491664333731079107.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206617.4103309.9491664333731079107.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:34:38AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Let the kernel handle killing the suid/sgid bits because the
> write/falloc/truncate/chown code already does this, and we don't have to
> worry about external modifications that are only visible to the fuse
> server (i.e. we're not a cluster fs).
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/dir.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 61015e83888ee4..e664a60200ee26 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2477,6 +2477,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>  	struct inode *inode = d_inode(entry);
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
> +	const bool is_iomap = fuse_inode_has_iomap(inode);
>  	int ret;
>  
>  	if (fuse_is_bad(inode))
> @@ -2485,15 +2486,19 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>  	if (!fuse_allow_current_process(get_fuse_conn(inode)))
>  		return -EACCES;
>  
> -	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
> +	if (!is_iomap &&
> +	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
>  		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
>  				    ATTR_MODE);
>  
>  		/*
>  		 * The only sane way to reliably kill suid/sgid is to do it in
> -		 * the userspace filesystem
> +		 * the userspace filesystem if this isn't an iomap file.  For
> +		 * iomap filesystems we let the kernel kill the setuid/setgid
> +		 * bits.
>  		 *
> -		 * This should be done on write(), truncate() and chown().
> +		 * This should be done on write(), truncate(), chown(), and
> +		 * fallocate().

FWIW Codex noticed that in iomap mode we still send FATTR_KILL_SUIDGID
even though we claim the kernel is supposedly handling the mode
stripping for us.  Granted I've been starting to suspect that some of
these file attribute related things ought to be gated on exclusive mode
and not iomap mode.  Will have to do a comprehensive review when I get
through the current round of bot complaints.

--D

>  		 */
>  		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
>  			/*
> 
> 
