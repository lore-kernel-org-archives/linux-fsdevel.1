Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEA20C461;
	Wed, 22 Apr 2026 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861058; cv=none; b=OckJx4BfwtOpq1Dh1F5KQbYb69YyyS/54icw9V7zSS9Iow0KfoFBfNpYYLm5Twj98eBhZQpkDzaPtES1bD5Dg+ZRT+ZWwhI/nIbrHhrSF57xilKM6lBWcDvIGNRtvFhATRYCkE/24SvL3WQLEC6r6SdA4M6utDj+wZkSc++LT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861058; c=relaxed/simple;
	bh=Cb5vYjLfSvx3asSS3fuy/PS3bzjoX56AGFOQo4VX1fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJQfiKnvP48jGeppKI4905CkD7/ikQ36LpkdBIriwofFh0MJOfG41OZFIEbMM/t4sWxOCvRFdoMk6V5UfNb30ss/gFrGn/4C822DRdZDuMMYRLws4X4O60S/00dhC+09Wl5DfSpkha7OwIyy3ZBcbJwHlX1TuKfTtyyMUe703sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V6YwThkO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6YwThkO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HR0UyK/31h18NRfVg/xbPHrrMlhCbADOJ5J0G4KLAtc=; b=V6YwThkO5mpdkuaVfYJxPlVFx/
	dWtOXdGaDBoTt/LI2JxZMFt+YG+bFPXedYLa2PTo+pecMddTiAIpbHvCR9p6eNnIW+a9UzYQWXRav
	oIg0fRFBKqUPpTxWi3lTRlvMcbOczQPPLal4pLlSPF9f5Q2X6yE/VOOdK2yCPEYGoeylveHLbZJOy
	pLr8ptEX07CFHipvBuFjfdeUPsNhXGhhZB4pYQmfzUpVDOXJddYWu50zdP1OFijpkPODsseDlOlhy
	JJ9qMuPiZTvWCxnpdMaTaaGe/1LLORiQCqE9vdIsAdKUegekx8v5u5WhdYkZlvUXaL6GjiP+SBJXo
	PnlPmcnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFWjA-0000000Bjpp-11dj;
	Wed, 22 Apr 2026 12:30:48 +0000
Date: Wed, 22 Apr 2026 13:30:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Frederick Mayle <fmayle@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Suren Baghdasaryan <surenb@google.com>, android-mm@google.com,
	kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
Message-ID: <aei_d5KMKmLhMx3S@casper.infradead.org>
References: <20260422005608.342028-1-fmayle@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422005608.342028-1-fmayle@google.com>

On Tue, Apr 21, 2026 at 05:56:07PM -0700, Frederick Mayle wrote:
> When a file mapping covers a strict subset of a file, an access to the
> mapping can trigger readahead of file pages outside the mapped region.
> Readahead is meant to prefetch pages likely to be accessed soon, but
> these pages aren't accessible via the same means, so it fair to say we
> don't have a good indicator they'll be accessed soon. Take an ELF file
> for example: An access to the end of a program's read-only segment isn't
> a sign that nearby file contents will be accessed next (they are likely
> to be mapped discontiguously, or not at all). The pressure from loading
> these pages into the cache can evict more useful pages.

The problem is that we might (for example) use mprotect() to mark a
portion of the file as being unmodifiable, but nevertheless still want
to prefetch through it (since it will be read, just not written).  I'm
sure this solves your problem, but I'm not sure it covers all use cases.
