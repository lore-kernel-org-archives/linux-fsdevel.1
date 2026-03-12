Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5473603C1;
	Thu, 12 Mar 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327434; cv=none; b=aEPfoAHlHfbWQ9OpGTleM5JV/KAugxNKa9ZtcvWgsbZTk6K1jnxQRzblSXMZyksLCyZZrvJGgbjinEDcBlVrnTAtpwXsB1keGp2PC53OiNHzbrODWR1HhRnqoYmfJD/h9lGG0Spb3WCVUtO07ExwBJyEuxY9ey/Sks4CzE3cb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327434; c=relaxed/simple;
	bh=FOqsqm9jHQdypVxCQKGykY4jiYV2S56n/OhvKcOzcJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ljj5nkIiD/1n64eRLfxNU3AOWUs3i2RvDWDpzKM7ElU7HhH3R385FJNI/baAPWNIcn3O43EwX4nrRY2Cgw5Lm+Ej6CjHxthAXyuTH4pg3Svus3QiwU+OpLLLnFfvSELgx2yAdWyVQPAkQcG7SaE5uRMBXgbasdJjoKVdZRNwQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XrvcFSXl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrvcFSXl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bFnXarLOOV8tXoOEpaAN0S3rKmLPL8YRDeLT2VLUcrw=; b=XrvcFSXlR7xBx1ooV9r9jcYEps
	KhUJ+nWXwHqRzDxu6udA5EPTXsQ+eU515pDQEOjZnpsQSDYu3tOenvsRhTlbHUuI5dOTDtGcATnjO
	M00PbvKNsYkSyqXsMa1T8lrQ6gs39rc5DiCed30CCNpjrLVo9CkzVIoOcTEIlnXQmOA9cgvSADMBk
	ZJb8aOUH+mABtTdVx/xADur4muUvOrNaMW14mroZNM/yv5sfhhQ53vSYpmgsOVJrtMP3sXLnzjPFK
	enb3fp5eB3A7vNEd3BofWUBBitNVGBwMuPaeb3MYPkQrcC9RwXdIwJu60j8+VO5ONSSHtFK5RZwuN
	d9XusPpA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0hTE-0000000BU84-2uRc;
	Thu, 12 Mar 2026 14:57:04 +0000
Date: Thu, 12 Mar 2026 14:57:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Timber <dxdt@dev.snart.me>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Message-ID: <abLUQECuMuxHNXjZ@casper.infradead.org>
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>

On Thu, Mar 12, 2026 at 11:02:29PM +0900, David Timber wrote:
> On 3/12/26 12:23, Matthew Wilcox wrote:
> > We already have two interfaces for this on Linux.  One is SEEK_HOLE /
> > SEEK_DATA and the other is fiemap (Documentation/filesystems/fiemap.rst)
> > Why are both of these interfaces unsuitable?
> https://lore.kernel.org/linux-fsdevel/cf6c2b08-b7ff-4f70-95f4-cdb12ef5a666@dev.snart.me/
> 
> Because exFAT is not a sparse file system. The VDL is only a shorthand
> for fast cluster allocation without writing actual data to them. In
> other words, the range between the VDL and isize is not actually a hole.
> The blocks in the range are actually allocated, filled with garbage data
> on the disk. The kernel has to be careful not to return it to userspace,
> which is something Linux kernel actually does.

Uh, no it's not.  If you try to read from the file at positions mapped
to those blocks, Linux will return zeroes.

You seem to be under the impression that SEEK_HOLE only finds blocks
which have not been allocated.  That's not the behaviour of any
filesystem whch uses iomap.  Look:

static int iomap_seek_hole_iter(struct iomap_iter *iter,
                loff_t *hole_pos)
{
        loff_t length = iomap_length(iter);

        switch (iter->iomap.type) {
        case IOMAP_UNWRITTEN:
                *hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
                                iter->pos, iter->pos + length, SEEK_HOLE);
                if (*hole_pos == iter->pos + length)
                        return iomap_iter_advance(iter, length);
                return 0;
        case IOMAP_HOLE:
                *hole_pos = iter->pos;
                return 0;

Yes, if there's literally a hole, that counts as a hole, but what you're
talking about is an unwritten extent.  And that counts as a hole
*unless* we've written to the page cache covering the hole.

