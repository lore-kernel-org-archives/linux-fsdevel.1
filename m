Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A025C80E;
	Wed, 18 Feb 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393251; cv=none; b=taKE2w3OVFSpRfkK/bIVrs7bHJkeJ+Yqh5XQhfeM+hN1/SD4VcodcDPm9Z+pgFd1nfWmIHs5VurcdLZcRVCB38cKqzA3mksLZKbVu/U8kYsiwsG6Tfg3ZK24Qm/VdlKfwN73iYUjYV+nyI39E+7WMjLE6Touub0WtFTShqmK72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393251; c=relaxed/simple;
	bh=jKTwLmmNE8YyItmx9FlbGj07poz9kqlnynO1txn7cnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njO/FQwfMZb7UGDezsW3nfMeVm6XAtqPZFF4MYTCClotFbqa7tGEKmsh6wq3VeCVAXw1iNRxekBATILPvmTSnqE04UgdbuAAoL9rarHeoDOCVCir1pub+nVmU+e1BqMPrJzSohXAiyTUdLKYixTpVHu7R9QjxMk4IOinP4lSwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TRzAA7MB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TRzAA7MB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vZcLGGT7RIcWBjO5WUNd9ucsW2phzcUHaruHOPVxXoU=; b=TRzAA7MBV+J0XNOGesIyH5mwvl
	hSxqJ5Pge4JV+EZqomd1VkNA/RC0GVlaqhfOyhnwms1zrEShZSIZdbaz34cUn7qNLGy2ACMk6MA/5
	5eMANS284Ecab5q0cFvubc/ZP371qRy5oYDL0lhXOirwD6uhGCDOj4wgoo5p8u+j/3kOKW55a0FEv
	Qlvj9c6VL2Bzj1GEcUuho36xozFOQirwFXSv9pqxz8jYireSMrQO5NP0icfOQTX5hRix0HHBX6fV2
	E58j6t6/r2rI+H8pG0LTNtGsquh3XupgjaD+uogQFce0EcMKfmcGAeaPJAOuqfufpj6O9EF6J7T7F
	RkTTm1KQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaIr-00000009KTB-0PLd;
	Wed, 18 Feb 2026 05:40:49 +0000
Date: Tue, 17 Feb 2026 21:40:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/3] f2fs: make f2fs_verify_cluster() partially
 large-folio-aware
Message-ID: <aZVQ4TtxuVWZ3cAK@infradead.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
 <20260218010630.7407-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218010630.7407-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 17, 2026 at 05:06:29PM -0800, Eric Biggers wrote:
> f2fs_verify_cluster() is the only remaining caller of the
> non-large-folio-aware function fsverity_verify_page().   To unblock the
> removal of that function, change f2fs_verify_cluster() to verify the
> entire folio of each page and mark it up-to-date.
> 
> Note that this doesn't actually make f2fs_verify_cluster()
> large-folio-aware, as it is still passed an array of pages.  Currently,
> it's never called with large folios.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

