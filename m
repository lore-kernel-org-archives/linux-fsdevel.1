Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118728E0;
	Thu,  9 Apr 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713238; cv=none; b=AB+rVhsokJAQQRUmqsqxB3H7QDwbsyrTNUw9JmPfohjuRx7xxxLS7Zxb4RACfjyJmNWhUmJDrVI/WB3apsu8e1ixYw6u8MOOaBqhi6/vSgfP8vSc0tmitZ0lT9FFqSCXSQ8nvaXLqh046BMEHPJc9ReNZdx+ExKIpFUxXjuwwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713238; c=relaxed/simple;
	bh=K9TjD/MsPW01zaPmlWER6fuIgkrg6/E9lVBvroMZ6vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8Q99xz6MyCgUGhs5V9T5rOWFJZMnTy/zZqJP9lZ5+WqLx5iKuSN6zPU4z0U+X5Eq/5Og94DbdZhlvBabZ50EbbSn0QAutK1yH278NjGgp54lmj41nEq+M1/OibUnZ8MmXOsHVtlb401KDzlDPaJYqTI+UlXnnM5GnJXsqZDTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4edJFwxs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4edJFwxs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o0ScfNlJGSA2uAJMI4ulU1pLyWdBug8Lf8guz+qT7sY=; b=4edJFwxsbyJkPqyn1XaMjCDdSC
	FlJdc1layEXP+v7Bc2DUT78tlL2tMpEQhzr+g6u7TDB1lpdV4g2ptYtaNmR0IxILvz7kv4ix348K1
	uNyP3t9DRWiyviPTTydvWMvAMXtodrCA9szonPWUyLmrJTF2zQ/O6koGmwppKavXVt0HE5ZsWy91N
	vqSKoWtyS0HwFYqXcu345tgJGIeqvR0MlM9eOUGlttvMcq9nnZ8c7LmlKHquJloOJMU7S4CIoNFPg
	cxwyYH4tgGgBWNt8y9CmG1B2vkuN98d9XXsUKAnLFzbvg8I9PwHtYf0gNE0QXt4LUi7Nui/3cTqwq
	WmfrJCWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAi7u-00000009jBY-0Up6;
	Thu, 09 Apr 2026 05:40:26 +0000
Date: Wed, 8 Apr 2026 22:40:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] f2fs: do not support mmap write for large folio
Message-ID: <adc7yo1_sr_eeV33@infradead.org>
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaasm42rLxRY2GN@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

[adding back fsdevel and mm to the discussion]

On Wed, Apr 08, 2026 at 06:13:06PM +0000, Jaegeuk Kim wrote:
> Let's check mmap writes onto the large folio, since we don't support writing
> large folios.

What does this fix?  As state in the previous round of discussion f2fs
only support large folios for immutable files, how do you get ->mkwrite
called for them.

The only way I can think of that is when clearing the immutable flag,
but simply rejecting writes with SIGBUS after that seems like it's
breaking the expected API, and I don't see handling for normal writes
after that either.
