Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CA371CE4;
	Mon, 13 Jul 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935856; cv=none; b=GKM5+66FKrPhyhmpnkpdLcsSHhfrbCUh5V5TdcaP0/+xIWmycrghFOvH5RsWJFDuPj5iKixoxIc4wLpl3AJdw9i4hZEkR0n5PIWJ8a70ZDlL3nen4zvQ8Kx3IrDPSsSW43Co2PLWdtC3m37EwpQxDsDuzlcvjZaPIcl6z3sAKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935856; c=relaxed/simple;
	bh=HU7TeuMVgbV+bx7qO5tyQsEIaj7T4gpOof/kc8bDtGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa++lukj4Lt3Q0f9/YwQyYDHzqEVVdS6xwGd+lmxkxhRTT6BVXeu6TorhMCZftu2wc/HHWWsye8+RE+OBDBSpkakHNQsv3U/lo4+03MH3sC0XJRjwSs7bRIxGMMkd+zZXenjS7bYvrBat1Di20Op9sP2LEE80xAKBmQfLFfQrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4F8f9da/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4F8f9da/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4UQmKcC3wtL3iE7sii5TPTF4Bqq8u0Th+N1o/5ctyRs=; b=4F8f9da/sn3HNKI9XxlifdMi7Z
	9cmxL81BTJ5ShFn5ThkU7Ij0WA1/tqRQt9fJK8O3uWpOWxL/cEJimVgf2S6FalzMaaw9Nqa+zcdXr
	GGwlEBhuS4+gCFdiSCZv4r25v6TI40bNB/sNtFcTgyH/ZUq6YiJ0SjvgGty745u3qixRsEmsEBkf9
	VqlI9a1FHWQkdwNVZuXdCNii8O0SBYRzn2M+/BtutQpLbnHRu7K2P83B02d7PhPnpyR+EWLoAeEAJ
	F2pqdq8Piq+qfMNiiu5fneJIC6XtefD2j0uuydflXxYs62qsYA3WlpcLmZiMSnqdpFa/sfg1Uo9QC
	4zZTPEJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDCv-00000008m41-34J6;
	Mon, 13 Jul 2026 09:44:13 +0000
Date: Mon, 13 Jul 2026 02:44:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 1/5] iomap: add iomap_symlink_write
Message-ID: <alSzbXMbr-fy9hwQ@infradead.org>
References: <cover.1783707063.git.jbingham@gmail.com>
 <570b47ec69233efcdde6644fc11bc5a8af6a9577.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570b47ec69233efcdde6644fc11bc5a8af6a9577.1783707063.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 11, 2026 at 01:59:05PM -0700, Jeremy Bingham wrote:
> Add a new iomap_symlink_write function as an iomap based equivalent to
> page_symlink found in fs/namei.c. This implementation was suggested by
> Darrick J. Wong, who also provided the initial implementation that I
> only needed to change slightly to get working.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> 
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>

No empty line between tags pleaase.

> +int iomap_symlink_write(struct inode *inode, const char *target, int len,
> +		const struct iomap_ops *ops,
> +		const struct iomap_write_ops *write_ops, void *private)

There is nothign symlink-specific in this code.  It's really just a
low-level write that doesn't need an iocb.

> +	while ((ret = iomap_iter(&iter, ops)) > 0)
> +		iter.status = iomap_write_iter(&iter, &iov, write_ops);
> +
> +	if (unlikely(iter.pos == 0))
> +		return ret;
> +
> +	mark_inode_dirty(inode);

And given that a normal write doesn't mark the inode dirty we should
probably leave this to the caller for consistency.

> +	return 0;

And maybe also return the length writtenn for consistency?  Or if we
avoid partial writes for some reason, return an error when they happen?

