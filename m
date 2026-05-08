Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CA363C48;
	Fri,  8 May 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283702; cv=none; b=LHqCbE5HcuRy0JUIW8Yme8jDxFmMpxsjB7yLCy6AiGSs/R0SmIidcE1jfNptwH2x1kVd0O3rhFtCSaHLdpMqhpSKXQ5wx8xthhzUZgZrIdmuNJuFx1gmt6TAeAt1TgREM1dGnN01oqpZSVvXUuW0PwPiDUt0V2gUQkKLxlEmFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283702; c=relaxed/simple;
	bh=0XcTxZHOTYsipFJkxusdF+VatAGshKRHvHMDLcUWtws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u436cjVMxWxhKYfg448EZZ/oJwhcTtHypTTGvg6OD++wS0yjWQlv/0urhAKygpjitgfywN1ZiO4HmaBqrAYnSOJn3Hglna8Kcu8qvorUYX5GnAu1hFyqWnByNJdHsVIGgO4++jdUVaTXSyjTtw0JG7ek0mlDFYF16hh6gufqYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uidAIF3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uidAIF3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB187C2BCB0;
	Fri,  8 May 2026 23:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283702;
	bh=0XcTxZHOTYsipFJkxusdF+VatAGshKRHvHMDLcUWtws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uidAIF3uiOT0wsM6iCOWzZ33FLj/CnhRYJtfcb1r+lYoek6HH7M9D6mb2Dj8tnjq3
	 80a3mcezr039JAxngdmUhs3TlXM4LKulhjhoEscT4nZZ3+XCuSIGkESKe3y/297e0O
	 JnqMYzg3Is/rcrStODQFX2PN9NHJCes6PPE8XYBAK5Q1v4rKqW66YxrZ2kxqnZUOMG
	 WIfQ1gHD/QGnqMXMur8bmz/HninRTxyA9Wt1lJTqbK9LNqfC+kBrDDGdcH4VN9QzXP
	 NhMjQpXdghbVNbjhBIx9d3Wp+NBwbL5VrXwYpOeLLGC4ceVFWadLvV4eVAz+sbTf2k
	 oo+vfkjSVwNAg==
Date: Fri, 8 May 2026 16:41:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: miklos@szeredi.hu, brauner@kernel.org, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20260508234141.GF2241589@frogsfrogsfrogs>
References: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs>
 <177747204350.4101605.17012857152206455463.stgit@frogsfrogsfrogs>
 <20260508090634.GA20688@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508090634.GA20688@lst.de>

On Fri, May 08, 2026 at 11:06:34AM +0200, Christoph Hellwig wrote:
> > +	/* Swapfiles must be backed by a block device */
> > +	if (!iomap->bdev)
> > +		return iomap_swapfile_fail(isi, "is not on a block device");
> > +
> > +	if (iter->pos == 0 && !isi->sis->bdev)
> > +		isi->sis->bdev = iomap->bdev;
> 
> My gut feeling is still that I'd rather have this in the caller than
> hidden in iomap.

The trouble here is that the iomap code requires that the caller sets
sis->bdev before calling iomap_swapfile_activate.  That works great for
XFS:

	/*
	 * Direct the swap code to the correct block device when this file
	 * sits on the RT device.
	 */
	sis->bdev = xfs_inode_buftarg(ip)->bt_bdev;

	return iomap_swapfile_activate(sis, swap_file, span,
			&xfs_read_iomap_ops);

But it doesn't work for fuse because fuse cannot know what the bdev for
block 0 is going to be without sending FUSE_IOMAP_BEGIN to the server.
iomap_swapfile_activate is already going to call fuse_iomap_begin to do
that, so we'd end up making an extra upcall just to set one pointer that
we could easily set later anyway.

> > +	/*
> > +	 * If this swapfile doesn't have a block device, reject this useless
> > +	 * swapfile to prevent confusion later on.
> > +	 */
> > +	if (sis->bdev == NULL) {
> 
> normal kernel style would be "if (!sis->bdev)"
> 
> > +		pr_warn(
> > + "swapon: No block device for swap file but usage pages?!\n");
> 
> Also non-XFS code tends to just put this onto the pr_warn line even
> if it is less readable (and XFS code tends to not do an empty space).

Ok.  I could change that message to something less confusing too:

"swapon: No block device for swap file but we configured swap pages?!\n"

--D
