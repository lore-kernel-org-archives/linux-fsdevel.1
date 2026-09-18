Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17430ACF0;
	Fri, 18 Sep 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740723; cv=none; b=dw09K4kxCco0PL3/Q3L68YB0IbfbabJEAvunm9gS15abV72VLlRSyzMG2A2s+Daf1kimZfyS4yhL20I9h0G159Y5QCIMekYybX7cEGVGjxY6KWenKpt8Cdne/l3NYAeajg6LYZFMu/eBnaNlGWxZI4VJDvqoseTOwjaIEK1egiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740723; c=relaxed/simple;
	bh=4lbu+lUwv2h7pPq9Ni2xAFVJgGIU26IjQvSl5kinP0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGycHzBXK40VcGo340O+n5aWTeu0waMK65KPa1OiiDTibif8NGeYYVSq4oBJKygy6+XRUqmGi7gBSIu3u2EY+TWPCRkqVa4Bdy2ULeMo1vsgd1zJ6fJgf9K+ogsCI8hZbxNYMBipALKQn6372he0nrkUKlIDX1eKkQ2rV+7cXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MFAyq4g2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFAyq4g2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7zpUXQYM3IC1SGJWSr4tMCIc0axKt/dfQzxPs2S33yI=; b=MFAyq4g2ymlShmuYjQIbBcSIfa
	BNej6XtEGp24e6Po8p7yzao5S64Rp27+Hp1OXW6/XsDOOAXcPlWN6tA9wtpWy8NhPYgHn1/BeWve4
	0dccChVw0XJDsw/gHGVw1XQeTSk90n6ECiq7oDQwQTKGyRveJ0TtFgx5n0kHmMlNUg+rhn+mWuvDI
	PIwhg+tBWz7oD3qekqBjF7byWLlziwdgcNpEGOnkdJzIUb4DKkixjZKkV1x/L+eo64ZT4I/Dhjc36
	r9NPMRNQAmk5fm0M+jtIdyyyH0x1nylr3kj2dvyfj4GtBAYLgqOsYk9mTfouebfoxAjAyQbFrSSzD
	Eq3P17Ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ZJo-0000000Efyw-2cdU;
	Fri, 18 Sep 2026 14:12:00 +0000
Date: Fri, 18 Sep 2026 07:12:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk, hch@infradead.org
Subject: Re: [PATCH v4 2/3] minix: add iomap functions and definitions
Message-ID: <aq1GsO6dkS747OEb@infradead.org>
References: <cover.1787770110.git.jbingham@gmail.com>
 <e7ab836149f814b04017905dca2e07a4c94078db.1787770110.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ab836149f814b04017905dca2e07a4c94078db.1787770110.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 26, 2026 at 02:41:56PM -0700, Jeremy Bingham wrote:
> This patch also wires iomap.c into itree_v1.c and itree_v2.c, similarly
> to how itree_common.c is included in those files, and exports version
> specific versions of minix_iomap_begin and iomap_ops.

Can we keep the iomap code out of this double build mess?  Just define
some low-level helper in it, but keep everything else in an only
once build iomap.c

> Also updates 'unsigned' to 'unsigned int' a few places that got picked
> up by checkpatch.pl.

If you want to do these cleanups please split them into a separate
patch.

> +++ b/fs/minix/iomap.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * iomap functions for minix.
> + */

Not really a very useful comment :)  OTOH this lacks a copyright
statement for your work.

> +static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)

This mostly does not need the iomap.  It basically returns a physical
block and a trystate of HOLE/FOUND/ALLOCATED.  If you change the
interface to that you can keep it in itree_common by directly morphing
the existing block lookup into that, or even do it as a prep patch,
which first refactors get_block to this interface, and then do the
iomap mapping on top of that, and in a place that only gets built
once.

> +/*
> + * minix_iomap_end ends up being a nop; since minix doesn't have any extents or
> + * transactions to worry about, there isn't anything to update here. The on-disk
> + * indirect blocks get dirtied in minix_iomap_begin.
> + */
> +static int minix_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> +	ssize_t written, unsigned int flags, struct iomap *iomap)
> +{
> +	return 0;
> +}

In which case we can just drop it.  Note that for the next version
against 7.3-rc should also move from the begin/end calls to the
single next one using the DEFINE_IOMAP_ITER_NEXT helper macro.

> -static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
> +static inline unsigned int minix_blocks_needed(unsigned int bits, unsigned int blocksize)

Overly long line.  I'd much rather generate the baseless checkpath.pl
complaint and leave the plain unsgineds in place.  There is absolutely
no technical downside in using that notation.

> +static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode *inode)
> +{
> +	return (INODE_VERSION(inode) == MINIX_V1) ?

No need for the braces.

