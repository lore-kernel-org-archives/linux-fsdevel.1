Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654618DB01
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603498; cv=none; b=k+co6ZzmkeqOsshueRfgBa8oBlUPgkv6Zobb1yKmVTctSioKKnV/Yndi8KKy/FCHDK67iuJUDMmuu/2IAtLn44qg552O10P1cbLTy9A9rkORboI1AtnbQVIdB3qNx7XR67a0A8wFYXMhUkNYnnl7lhz2rtFmrW/UeopRpzPGVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603498; c=relaxed/simple;
	bh=MRBUFILJKumdsZaEAyAB3kQWWs1X6A2YWH1oV7Eba8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4sRc3ZS2RmiHR12B9h9Sulv58o9rvtGEpvOxRZ+EV26WmWsLQZ0Q135Y7rVSNuwqs4NX1+76NIddoS6vmRcYKf3WK4GqGqoj6hbotMgANaESXPcMWXPd/m88R8CgSuVTaWRw86ETUflI//0LkvtFeLA+XcJd27ssPPLf7ty2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pT6pGEy9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pT6pGEy9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SIiLtMs4lFBzyUl7bXYr+rHge8z24z1y02ZKkAxdE34=; b=pT6pGEy9B/KmFPdkcPv/7byZ60
	q+06SOtrN+FUK0b2YWrWtXJydW6w5AD/8Z++8wR453TI1HAmIkqGhzfqsa1bTK1iR5vVxHH6PyqtC
	NMWpOHzvHUf7GGvye/Y6vnSAzKDpKbmTcI++7pwp3uCHtVQcJPEsYUForfPe6ZohH4cZ5h2pky95J
	qJqCiIXNtoC4iydFcAoL2Pkm4AiEMAFvhSaHt790qyviyageiSk+Yn0/5nqQGIREclasCHsTiwGPf
	UqYJw1ogoHlO+ReEVB7C78pSxkh+Mt1jOFPIKVTqZXNqrZJ0Bx3qqURXtSgGqXMaCbmhFF+EtKoXv
	h+ZDsMtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wybKK-00000007lzg-0wG9;
	Mon, 24 Aug 2026 20:31:28 +0000
Date: Mon, 24 Aug 2026 21:31:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Kiryl Shutsemau <kas@kernel.org>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
Message-ID: <aoyqIBz1EoY0R8qw@casper.infradead.org>
References: <20251117224701.1279139-1-ackerleytng@google.com>
 <20260824194755.216000-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824194755.216000-1-iprintercanon@gmail.com>

On Mon, Aug 24, 2026 at 10:47:55PM +0300, Artem Lytkin wrote:
> I'm asking because there is a second user for it that has nothing to do
> with guest_memfd. On arm64 with 64K pages HPAGE_PMD_ORDER is 13 and
> MAX_XAS_ORDER is 11, so MAX_PAGECACHE_ORDER clamps to 11 and shmem never
> offers a PMD order. MADV_COLLAPSE on tmpfs returns -EINVAL there, and
> huge=always hands out order-11 folios at best, so ShmemPmdMapped never
> leaves zero. Every other page cache file system tops out at order 11 as
> well, which is 128M and not PMD-mappable. pagemap.h admits it outright:
> "xas_split_alloc() does not support arbitrary orders. This implies no
> 512MB THP on ARM64 with 64KB base page size." Kiryl's khugepaged
> selftest series skips the shmem and file cases altogether for exactly
> this reason, and on 6 August he confirmed in that thread that uniform
> splits still go through xas_split_alloc(), so xas_try_split() on its
> own does not lift the cap.

But why would you want it?  With 64KiB pages on arm64, you need 512MiB
for a PMD-sized page, and that's just too big for current hardware.
What's your bandwidth?  40GB per DIMM?  With 8 DIMMs, that's an
aggregate of 320GB bandwidth, so that restricts you to 640 page faults
per second.  That's too few for almost all workloads.

The page allocator also isn't great at doing order-13 allocations.

Since arm64 does support 2MiB TLBs, even with a 512MiB PMD size, I'm
not sure there's a huge performance win waiting for you on the other
side of all this work.

IOW is this driven by a real need, or just some completionist thing?

> That case needs two new levels of nodes rather than one: 130 nodes,
> 73 KiB, a long way from the 1G to 4K split Matthew was worried about.
> Raising MAX_XAS_ORDER to 3 * XA_CHUNK_SHIFT - 1 covers it, and
> MAX_PAGECACHE_ORDER stays min()'d with HPAGE_PMD_ORDER, so no page cache
> caller can ask for the order-17 worst case that cap admits.

130 nodes is still a lot to ask the slab allocator for!  With 64KiB
pages it's not too bad -- you get 112 per page.  But still ...

