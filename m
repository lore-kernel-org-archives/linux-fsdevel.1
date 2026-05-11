Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4712C234E;
	Mon, 11 May 2026 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480324; cv=none; b=JYAD1Y2+5ggge7gUY8vGeDY7wtGD4JdD5QQqrIgXMzsO9tE3qI9glXGq1scqzBU59WMiy+Lyy1/DdHowIZyetWHxVHx1ILIuRqfX8uFQhiibF3ErrjnTT/Wdzvw/B+Iskt2WZLCKfZEC0FYJ5qZTuBmD3exz3WnM1BJfV909vqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480324; c=relaxed/simple;
	bh=ldnn6oROBSwn7sZyWXOXEQctYcul/8tLmR14HgbKNpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3mkC4Hun8xk7IwB67tflCCM+b+fHodFVbmiNPtKkUoYXtiQPTs/ECfO5Pd+vxjjT+rQHmIgYhPOBfcV6uhb7U0GGZJRaibDjZkUYsAmpacx4C5RxRzaLeHgoBl0P35nvcgLxrjoQZZ4W9nNy3gsb26JYu5L4B6chUax+9Nmi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yJJMCrzY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yJJMCrzY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QUzB0vtFO1H2OCGd0aM3xe8F77OrZDRCrHXJ9f+x6G4=; b=yJJMCrzYqeJoVQLb0lSpEthgie
	KJ4ISZY92D9rTQ6iWYUbeYHkrzIVeC8mEmH3+in2LVpBXpXZx7tl6STmTeoz88JhE4ITGPOKu9QrY
	Fknyl29GVPdGPjx9auYyna92ibWxC8OQsaqrdRDfcrP/52ATRkINSYeYm2l0nImlXvmr5rsIPh23P
	80mpZkrUwBZJsowKJyYkhUVWfbeV+JR7GSn2pz22RXEgZLm6sTRb+sGTQbfkchQZPteUO2j19xX1h
	OdpQCzKcAlm8Eny6EfZs+gnJJ/pmlMJemCUKyyCFt2QIqQV/BW2xDwYFJRNaTv7C9SOUdlAhJaHBD
	zs5xukSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMJyS-0000000CT8m-1XF5;
	Mon, 11 May 2026 06:18:40 +0000
Date: Sun, 10 May 2026 23:18:40 -0700
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
Message-ID: <agF0wJSFRAEcRP8M@infradead.org>
References: <af2kDfHe0B3LnvVm@infradead.org>
 <50668994-b6cf-4288-9ee2-0264bad2b271@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50668994-b6cf-4288-9ee2-0264bad2b271@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 08, 2026 at 05:10:21PM +0800, Gao Xiang wrote:
> On the one side, I hope if there could be some interface for
> such temporary usage rather than just one vfs_iter_read model.

As in a in-kernel mmap?  While not entirely impossible, the locking
model for that sounds horrible.

> > Now for reads it mostly works on the most common disk-based file systems,
> > but it does create lots of problem for slightly more complex ones like
> > network/clustered or synthetic file systems.  It also really breaks
> 
> Just out of curiousity, could you point out one specific path
> so I can look into that.

file system might require their own locking, e.g. cluster locks for
cluster file systems, and at least in the path direct page cache access
also caused problems with NFS data invalidation semantics.  Last but not
least ->read_folio has a file paramater that isn't really a file but a
file system specific cookie.  So calling this with something not managed
by the file system can cause problems as has caused crashes in the past,
although the offender at that time (the old smbfs) is now gone.

> But could we just fix this issue first for previous linux versions?

I just pointed out another issue.  You'll have to fix the credentials
either way.

