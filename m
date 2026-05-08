Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5D3385B9;
	Fri,  8 May 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230290; cv=none; b=DkMIKjwmm1Exr7stWPmwmrylE4esLmmmb2uVwuCB4U7k9LElPRRWdRnCGhMCsWRgiVxw7NJ0XGOqenaF+6dR5jMIuDxIpxC57zXIB9HRzHdLU4AcvoNwwPcnXGjh05DqieAectLBhJGCKzSGUcRTwwRjJoV3c0MflZYVaGFNaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230290; c=relaxed/simple;
	bh=4KZizOGDKRADdeA0gyJuseKtEXeL9KDBWJ8rhL3XRfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DdGEn6qmdGctWtwVrjCiE70dCIoWviOAwcKGsYAwpFsji4w/hU7Tg/FUNWT/yC2sFrz6eyVOsFBnLewJV4caIXMOETCVZIp6J8HE9UuW8EPoxsHBz7+aiFRMGYs8uKOufR4wOAZQwCBowuGotrvPY9WBQjD6BhNt/H8Uv6j+NBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zGAtW3//; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zGAtW3//"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=LcfSJZunpJtJqEAQxYYrvSXwL2YMHDgM2lPYeKjOS/Y=; b=zGAtW3//ALZeGoDiZcqA0NDin6
	Djhl0G/b1v95JdQYdY+8UY0Qce0/tg97AmeovmSQrLGCLvdi6XREyBiKgEuAv83Dzg9xrnHTnO9ne
	56RvF/4mgtWuJdMqJ1EZW+/LvWQFgA4WY1XPA7olVpJsbr4UF2wY6MbtGV9qcJ06tsuZ9unJcBF2s
	QPzjXmYs0qREEEouylVWhDDXyBaOYryXfesTRed2xSAMZ0vVMjzX2oNxNWWUXQE1VGt+Uo9+NUmpC
	rG0rtqV5cUwFCQQ1YKmzRbJGsZuHs6i2qzea/allFxjq0g74gqOp9hII0t9oBgggcgK9ljb6rJ2T5
	NkoetzMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGvd-000000062jx-1JiC;
	Fri, 08 May 2026 08:51:25 +0000
Date: Fri, 8 May 2026 01:51:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing
 metadata accesses
Message-ID: <af2kDfHe0B3LnvVm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
> Currently EROFS file-backed mount metadata is directly using underlay
> fs page cache, which is mainly used for composefs, etc. to avoid
> different EROFS instances have their own EROFS page cache for the
> same underlay backing file and avoid unnecessary copies into them.
> --- That is also what composefs once did in their codebase.
> 
> Since EROFS just read the underlayfs page cache and does _not_
> touch anything inside the underlay page cache itself, so I guess
> it's fine?

At the micro-level this does mean erofs needs to do the checks itself.
OTOH it means this whole scheme is completely broken.  The page cache
is owned by the file system, so erofs can't simply poke into it.

Now for reads it mostly works on the most common disk-based file systems,
but it does create lots of problem for slightly more complex ones like
network/clustered or synthetic file systems.  It also really breaks
layering, so we need to fix it.  Not sure what would be best, but I'd be
tempted to have a cross-instance cache maintained by erofs and filled
using in-kernel direct I/O.  IFF the page policies work great for you
that even could be a synthetic inode/mapping.

> On the other hand, we talked a bit commit f2fed441c69b ("loop:
> stop using vfs_iter_{read,write} for buffered I/O") in another
> private thread related to fanotify, which lacks proper
> rw_verify_area() as well, since it called into raw read/write
> iter methods instead of using the previous vfs_iter_{read,write}.

Note that this does not add the bypass, just extends it to both I/O
types.  But yes, this breaks fanotify.  We actually have quite a few
raw ->read_iter/->write_iter calls, so this might need more structured
treatment.

