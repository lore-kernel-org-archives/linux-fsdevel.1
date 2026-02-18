Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6E279DAB;
	Wed, 18 Feb 2026 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393229; cv=none; b=YXpY9pPWu76hucWURO0wkIr6fYlJbum/aPJ+J0KKkPa2iygZ6e/SQ3ObRgAG53cC17pkrYw251iR+GpAKdEDmf9wZloBleRvHRFYSzxx8autzxnxi+1/vUnPb1240jBEui2GkZ5owfL/Z/eGJqm1+5uQW3w8+YO1jLkX/B2wqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393229; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o14rXeStRMDuSjhuRgLfcIdDpAYDdRw5onDrSBSHe1pj4m0j1y0bvvfmS22sZ7fWs0QfDXuXSlzd6Bp7KWAVeRHeM/bKfbTbZA0yRc9hP+aPyZz7OM2tFMzID62aJRPZGWFzMPmpdyUv/0sD6Z6EyqSIke+K9DBKT6461RJP/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tt0nwSjM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tt0nwSjM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tt0nwSjMtedYdzGCQ5zHFVm9um
	IByaGHFymBAHbIPrb/hD+iMF5LrAWveAhyLZJrGwqhP9Cl2YmDypLqY0PPK8zwO/Nxwk/wkYze7gA
	bbnWPrdRUD4vm/WzbcGScN8L5fCYplqEHzTIbhCHhKqZvvuHumsNGfwBH2jE/yA+5lGwL9LciZ/T7
	GdrFLA/IZZSwE4M25uWxoNCiAbL5kBaQZxm7iwwxJyXSiO48RsQs03cuXXyS+NwdYkgumjWJEhPdl
	u84Vl2HMXn9oha7rEqKnp7ekSa/YEbyR2ficy2rzwSST4xclt/R8IfU6q90dGiEvELDmzILHDlSr3
	YrlMXJ6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaIV-00000009KRJ-0gbl;
	Wed, 18 Feb 2026 05:40:27 +0000
Date: Tue, 17 Feb 2026 21:40:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/3] f2fs: remove unnecessary ClearPageUptodate in
 f2fs_verify_cluster()
Message-ID: <aZVQyzy0R1AM8O-z@infradead.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
 <20260218010630.7407-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218010630.7407-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

