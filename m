Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A83B27FA;
	Sun, 30 Aug 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788093636; cv=none; b=Y/Q06qm0BoJTVKbFMklM7irqP13Jd3N5mi/Nn+hYgnS+9opkbHvvwTStAtG6W1l7vq/i1V9Y35SW+l6Y+pewlkHWP/Qywpn/bVWc/J0FaMQsYE0GUDU0El6UHPrbwkyjFf4WJzpabaNOjECyfbDrbMG7drddv3ljwbODMKjV8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788093636; c=relaxed/simple;
	bh=IdDJuaJEMaX+/zhA1A+Py/N84hA/ca1Tsd72WJpq67M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiL/ulPIeGAsUsWU3fiJ9OKZiME1Iv/Ocx/P5jVzQ+tEnuFTeie4Out+0+iHXQwxqrmNX0iVkY2v83rjoMObq2yUcwHflK+G4UoRNb2Cr69pm9lxWYQxzjljxyr+QHPvT/5HeG1aXRszhV2H8RprDYZsc7pdPZV6FBzkNLdCODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vi16hdNt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vi16hdNt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w2Yu37RyGHuTKU6LsWqjv/TrIzDjNCcF8SRXvGzqih4=; b=vi16hdNtyhciZcatyDKz3kgJy5
	J+WeKhMezb5Mt6ZiVsesV0t1vOTXKwUlQLOpI6X+1YqOQmFQKxWPjb00+rQBWKg6TQt//WfDabH0q
	GMvIrCLU3AZ3zOku2lPW9zwcccZAC7a/BVmo7wfMCae2+g3fOirlK3Auoor5CJRxWHUfthMht4AbA
	YPOh79MZLOSjAuDsq/cxjzBQMD8A2KSlYPdF7RhmVqPMsU/KinIFEGhVd3HYiH0A6xIgVd7S5dUfo
	pNfhUgBGgu4Z3CW+NoDoK02aZponE9o2wgNhkDNk+xNr1X4TAIGrBSyamNbnKNBRz1oKNomhZkQoH
	CQCCDpkg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0epe-00000000zXY-0Jv4;
	Sun, 30 Aug 2026 12:40:18 +0000
Date: Sun, 30 Aug 2026 13:40:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
	axboe@kernel.dk, trond.myklebust@hammerspace.com,
	tz2294@columbia.edu, chao@kernel.org, qiwenjie@xiaomi.com
Subject: Re: [PATCH] mm: filemap: skip dropbehind folios during fault-around
Message-ID: <apQksVlTvJY_0aTi@casper.infradead.org>
References: <4a4ac0b4accb50641f504f205663435047c4b26e.1788086386.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4ac0b4accb50641f504f205663435047c4b26e.1788086386.git.qiwenjie@xiaomi.com>

On Sun, Aug 30, 2026 at 07:48:45PM +0800, Wenjie Qi wrote:
> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> filemap_map_pages() maps uptodate folios speculatively without going
> through the normal filemap lookup that clears dropbehind. As a result,
> a neighboring dropbehind folio can acquire a PTE and the mapped-folio
> completion guard will retain it even if that PTE is never accessed.
> 
> Skip still-dropbehind folios in next_uptodate_folio(). If the skipped
> folio covers the fault address, do_read_fault() falls back to
> filemap_fault(), where the normal lookup clears dropbehind and updates
> WB_DONTCACHE_DIRTY accounting before mapping it. Speculative neighbors
> remain unmapped and can be discarded when I/O completes. Normal folios
> continue to use fault-around.
> 
> Dropbehind is folio-wide, so a fault into any subpage retains the whole
> large folio through the normal fault path.

I don't think we should do this.  Even if a folio is brought in through
fault-around, it still indicates some conflict between dropbehind and
another user, which indicates that the dropbehind hint was wrong.
