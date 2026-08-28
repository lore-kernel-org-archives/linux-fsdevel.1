Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442741E1A3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950026; cv=none; b=gTRBT95hadIvYXvJ7JyKOFprXZ+VGP0Rgvbou7BbRnklculRBdFgvQKjlrDOh3ZyFjH64gLpoqqQMpHOAVwbWkEED8oyW0fQzVD5Po+BGozfdcrgDmjSJm5vk0txExOQdHzkEL33NnB7hPRw5uTXRusKmdmRyFgHhomKtdtKC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950026; c=relaxed/simple;
	bh=jw1zK65TKRQJP8eOh9E0kwc9EJhcXRyeNrSBVIBcJtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAlPZgE5EXzKXIr3bTWkq2ed9fP95Xm8yQ5771FfgZRuJgvk6hvSKay8tBfIbr6R6VOLWfDyymLmF2zV05frBrMzuyGqzEhRhLglgkcpCdlXTGO85gQeD2rZsBzDanA+RvJxTJT/dD39FKteegpyseakul9a2N12izX/7lRqEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BUIzDhvY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUIzDhvY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PtqzTRkNWugJou735jXQZjPD0o3q2aYJkUK+shX8UNs=; b=BUIzDhvYo/cVJ0Qoh3+y4zeBWB
	aMLxxECg752jzZHuN/zhUiyOv4kDzGD3DsvoKcvUG8HkuVYW7ybVNLQtEvAd6FuD8KfQ+C6ZLXnYW
	ZWa+4KhOVcwwC1zk6SSm473x4870HydGSu04N9kHnOTHEhtLwtsvx06fSY64GX9aTHuj5hy4hMSbG
	Hz4PjGy+khFWIsuG6E2m/J88Z61Fyyx9eMJ/0vXhTm636xTIFPoqtxKGxtAqMEefcX5FdQ8JUe0za
	k3Riqf5r7KicFDhC27ZnEAFCg0J9GfTZq8NvSfdnHySTCR4Bmmr49fKi0c1V/08iwBVP9jYZneh7u
	frT6qfrw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03TT-0000000FQQq-2hY7;
	Fri, 28 Aug 2026 20:46:55 +0000
Date: Fri, 28 Aug 2026 21:46:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, vdubeyko@coreweave.com
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
Message-ID: <apHzv2PKif3n8rWq@casper.infradead.org>
References: <20260826225614.486112-1-slava@dubeyko.com>
 <ao9_az3JPNhHooMl@casper.infradead.org>
 <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>

On Thu, Aug 27, 2026 at 11:35:12AM -0700, Viacheslav Dubeyko wrote:
> On Thu, 2026-08-27 at 01:06 +0100, Matthew Wilcox wrote:
> > On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko wrote:
> > > Christoph Hellwig has detected that taking the page lock around
> > > the kmap/modify/kunmap section is not enough on its own:
> > > writeback drops the page lock before the write actually completes,
> > > so a mutator that only waits on the lock can still start rewriting
> > > a page whose old contents are still in flight to the device.
> > > Mark the allocation file's mapping with mapping_set_stable_writes()
> > > and call folio_wait_stable() right after taking the page lock in
> > > both functions, so a mutator also waits out any writeback that was
> > > already in progress when it acquired the lock.
> > 
> > Why would you indirect through the stable mechanism rather than just
> > calling folio_wait_writeback() directly?
> 
> The HFS+ allocation file (block bitmap) is represented by sbi-
> >alloc_file inode and mapping represents the block bitmap space. If one
> thread is calling hfsplus_block_allocate() or hfsplus_block_free(),
> then it tries to modify the content of folios/pages in this mapping.
> But writeback could happen in the background in another thread. It
> sounds like "folio's contents to stay unchanged while writeback is in
> progress". This is why folio_wait_stable() was suggested. Do you mean
> that it is not exactly correct approach? Do you think that
> folio_wait_writeback() is better approach?

I haven't looked at this in detail, but folio_wait_stable() is "if the
mapping needs stable pages, thn wait".  You know that you need stable
pages, so you can just call folio_wait_writeback() directly.
