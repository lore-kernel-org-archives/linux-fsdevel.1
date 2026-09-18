Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4ED4F3EA8;
	Fri, 18 Sep 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738781; cv=none; b=py45NHG3wRuaIqVwhGKgyznOihD/sLBDKLik8X5ld9PNmuN++6lwBCGIOMiMobPfdkzgLyP0DD0K6VIbvMbLxrqrAsBHFSt89JLyl725nDibGLTaaqLni+/QvSM456P9sMd//2vwU4OtckF9kRrulL1W96BiWfGvz9I7dWMTkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738781; c=relaxed/simple;
	bh=wFcWsLONtbUvs7sxc+0S1oVLrs8sf7OqU8z8dXRIRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFqC0au5PiU71f8Ssl/9TAAz0cbQ/BrIgI542HP1yRaSh6YxfAbiqkVM0NH6g2joxSm1gFLGACcNqjXuvbcuSAdNSIop+5mvsLV87z30QiOSiwvZYU239nAVqz2tcdAsuxDNH9pypHQXryYaQ02C/6qneDxR1iSxar0X+drVmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BBDC68BEB; Fri, 18 Sep 2026 15:39:35 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:39:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 6/7] hfsplus: introduce iomap-based file_operations
Message-ID: <20260918133935.GF18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-7-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-7-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 04:39:40PM -0700, Viacheslav Dubeyko wrote:
> This patch

Patch descriptions are not supposed to start with "this patch".
By the time this fets into git, it isn't a patch any more :)

> @@ -55,7 +58,6 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
>  	error = file_write_and_wait_range(file, start, end);
>  	if (error)
>  		return error;
> -	inode_lock(inode);
>  
>  	/*
>  	 * Sync inode metadata into the catalog and extent trees.
> @@ -114,15 +116,184 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
>  	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
>  		blkdev_issue_flush(inode->i_sb->s_bdev);
>  
> +	return error;
> +}

Changing fsync locking feels like something that should move
into a well-documented prep patch.

> +/*
> + * hfsplus_fallback_buffered_write() - fall back to buffered I/O for the

Pointless function name in the comment.

> + * tail of a write that iomap_dio_rw() could not perform directly
> + * (unaligned tail, or no blocks could be mapped without allocation
> + * outside the direct path).
> + */
> +static ssize_t hfsplus_fallback_buffered_write(struct kiocb *iocb,
> +						struct iov_iter *from)
> +{

Can this use direct_write_fallback()?

> +	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
> +	loff_t total_capacity;
> +	ssize_t ret;
> +	int err;
> +
> +	inode_lock(inode);
> +
> +	ret = generic_write_checks(iocb, iter);
> +	if (ret <= 0)
> +		goto unlock;
> +
> +	total_capacity = (loff_t)sbi->total_blocks << sbi->alloc_blksz_shift;
> +	if (iocb->ki_pos >= total_capacity) {

This is weird.  The total capacity should not matter for a write.

