Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023F4FD792;
	Fri, 18 Sep 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744225; cv=none; b=buSQxXVw35n1OsgfC76NO7Vb6N8BlX2/WL0KLeV+uBDW/KihOhWVSJkqxNmp/2uycPFxMg8x/lvJPXH6LjnLiogwlgQh/Id/nnd0nKNHoJvfBA8I1zEb1ahYw1+iSdBdN+1yf15PQgXTvBHFz+S59vB3PLSMfnQB9B3VFJjZobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744225; c=relaxed/simple;
	bh=mWu+AEMLYvGfRFR8F0TFvo8ZNVTVcCWjOGAjZXoOLBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNk7iTkmoOZqo1yScoH0069L2mzm4uJrY/qX2bPaYWHWxHqaNc2wVoRMT7KYXN94Ubkj4uDRTMhkp8ggIIkZ/oLxJT8gTRPeEoX711Kwj/fFDjTb5B+LV1l/2wW6PcsZhSp88THUEIpQxrKsZjD0JznAvcZ6FM1+POwfDH4wRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2ignRxx1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ignRxx1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pigyfpo0c1aVrmJnybrJ9uNhK/AYTW+OYDc7D94U1SQ=; b=2ignRxx1sH6Iz076AyfHB7MzcK
	2d13/LXDgr1rtdtIFrHfgaiQikVbU1kiwS9biom0VFEUQSaqR+uU4cFNCdKGeRG1ErxLTettDRWen
	e8EWHlWP97/ehDrb7emuMCFQ8FpW08MfBAUu/XFa5KxrsMlqT/Q/RF5ininmVS/xYu6vNaZAwfYRk
	FqOgXO4P7j09GzWSEVWaWEToBBpJt+orqof4gzOhocTZX4qtzn8tLEn1XGTbCT0B8Bz5P2JFoQUUX
	wA9vWdyAfu7jv+fSxDI75J/ouWkT9mtDPxgfhjxpy2D5fVkgIwbsfmEsYnZEYsE3A84e32/+xvB9A
	Zz3t77/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aEF-0000000Eq0W-3IgN;
	Fri, 18 Sep 2026 15:10:19 +0000
Date: Fri, 18 Sep 2026 08:10:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk, hch@infradead.org
Subject: Re: [PATCH v4 3/3] minix: finish wiring in iomap functions
Message-ID: <aq1UW699LW2pxvHU@infradead.org>
References: <cover.1787770110.git.jbingham@gmail.com>
 <668bd5f317e3bf8eaee0254ca79e595395b6e332.1787770110.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668bd5f317e3bf8eaee0254ca79e595395b6e332.1787770110.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 26, 2026 at 02:41:57PM -0700, Jeremy Bingham wrote:
> Wire in the new iomap functionality in one pass. Per Christoph Hellwig's
> feedback, there are no longer direct I/O operations. Without that, only
> write_iter in minix_file_operations needs a custom function. That and
> exporting minix_setattr for minix_symlink_inode_operations are the only
> changes in file.c.

Commit history just goes into the cover letter.  In genral you don't
need to enumerate all low-level changes either.  Explain the high-level
change, what motivated it, and anything that looks a bit unusual and
unexpected for that high-level change.

Note that you probably want to merge this into the previous patch
adding the actual iomap ops instead of leaving them dangling between
thet two patches.

> +	ret = iomap_file_buffered_write(iocb, from, ops,
> +			NULL, NULL);

The two NULL still fit onto the previous line:

	ret = iomap_file_buffered_write(iocb, from, ops, NULL, NULL);

> +
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +
> +unlock:
> +	inode_unlock(inode);

For most file systems we try to have the generic_write_sync outside
the inode lock to not do the expensive sync with the inode locked.
generic_file_write_iter also doesn't have the inode locked, so you
should probably sync after dropping the lock here as swell.

> +int minix_setattr(struct mnt_idmap *idmap,
>  			 struct dentry *dentry, struct iattr *attr)

Odd formatting again.  The typical style would be:

int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
		struct iattr *attr)

> +static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
> +	struct folio *folio, u64 pos, unsigned int len, u64 end_pos)

Two-tab indents please:

static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
		struct folio *folio, u64 pos, unsigned int len, u64 end_pos)
> +{
> +	int error;
> +
> +	if (pos < wpc->iomap.offset ||
> +			pos >= wpc->iomap.offset + wpc->iomap.length) {

	if (pos < wpc->iomap.offset ||
	    pos >= wpc->iomap.offset + wpc->iomap.length) {


> +		if (INODE_VERSION(wpc->inode) == MINIX_V1)
> +			error = V1_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
> +				&wpc->iomap, NULL);
> +		else
> +			error = V2_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
> +				&wpc->iomap, NULL);

Overly long lines.  These should hopefully go away for free with the
common iomap_ops.

> -static int minix_writepages(struct address_space *mapping,
> +/* The old minix_writepages, preserved for directory operations. */
> +static int minix_block_writepages(struct address_space *mapping,

minix_dir_writepages?

If you're looking for another project, we could probably also have
a iomap version of the directories in pagecache used by minix, ext2
and co eventually.

>  static const struct address_space_operations minix_aops = {
> -	.dirty_folio	= block_dirty_folio,
> -	.invalidate_folio = block_invalidate_folio,
> +	.dirty_folio	= iomap_dirty_folio,
> +	.invalidate_folio = iomap_invalidate_folio,
>  	.read_folio = minix_read_folio,
> +	.readahead = minix_readahead,
>  	.writepages = minix_writepages,
> +	.migrate_folio = filemap_migrate_folio,
> +	.is_partially_uptodate = iomap_is_partially_uptodate,
> +	.release_folio = iomap_release_folio,
> +	.error_remove_folio = generic_error_remove_folio,
> +};

Maybe use tabs to align the initializers if you touch most of them
anyway?

> +	/* Depending on whether the inode being truncated is a directory or not,
> +	 * we need to either call iomap_truncate_page or block_truncate_page.
> +	 */

The kernel coding style would be:

	/*
	 * Depending on whether the inode being truncated is a directory or not,
	 * we need to either call iomap_truncate_page or block_truncate_page.
	 */

> +	err = iomap_symlink_write(inode, symname, i, minix_iomap_ops_ver(inode), NULL, NULL);

Overly long line.

