Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AF22759C;
	Mon, 30 Mar 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875387; cv=none; b=fnVpp23vc9tFruFkbgI2BoQVQN0Do9U3SvVqACe0KcVzfHlhHlvJ24aIcttltXMbVvUYPEjq+76JAI1biJZy1ztGsvFcU+o8H4hRf+QT9fERfNF0w0JNEtUvXgckyA/tnMffCJsW2+GMVnMsI7dLsGyGvkKd4b5tHxnOwAyaW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875387; c=relaxed/simple;
	bh=6ygHPqtkx+WIW1vY1X0c4Xv26izo6ebifmIKl8o+8oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEQ4hEIBI6drE8Jahiohov9dRglwNVOH2W1T/Z4BUkf8YcrDz6xK5QqkxH5OO0Y8c8KrcyNX9TNuxhj2pLD64KnXhw+0uDbBxAPFCzsAhTLoZjtq9IyhTwLjrDMftkJok+WATno2eOL0VUXC3tJEkABFwXoa4qweEQru00AaiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HIqM33CR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HIqM33CR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6ABb3mCmxINvfC74mwIx/aFMr/5W/YrJg7LRCk/iB4A=; b=HIqM33CROqAhISIXKTEGIZr+1O
	bfqwa7rBYHRXXoGMNNncKV7ZqE/BQVqqNEY1+Vb4vLrFrpdabkJVms6fUnwJr5c1yMrzTIJgWV0ZK
	DVffrdyimh2J265xgwjnUlEkVa9ZyAomWfYJ8bsS3b097CgBA8e568vhSyMBl2xIvtO8GHH8XQJuF
	7v6bhdX97EaFCxpQ/pFgL14hRrYowpHKUF4Vi0v2DaDbugPZsiwh7a3MNLMG9ODGO9r6TOjOPdn4c
	MOiUJ8nhTS2w3wDLH0/nHuIO5uPc1MYZHLHeyFhK5ECQN/DF0+yLRGlim+PAOoYcVwpAXSARgi+X+
	/r/DNaEA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7CA4-00000006gVN-2Qj0;
	Mon, 30 Mar 2026 12:56:08 +0000
Date: Mon, 30 Mar 2026 13:56:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: WANG Rui <r@hev.cc>
Cc: usama.arif@linux.dev, Liam.Howlett@oracle.com, ajd@linux.ibm.com,
	akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, brauner@kernel.org,
	catalin.marinas@arm.com, david@kernel.org, dev.jain@arm.com,
	jack@suse.cz, kees@kernel.org, kevin.brodsky@arm.com,
	lance.yang@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
	npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
	rppt@kernel.org, ryan.roberts@arm.com, surenb@google.com,
	vbabka@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Message-ID: <acpy6DLjPVXXzwJX@casper.infradead.org>
References: <0725ce97-b8a3-47c9-952f-7b512873cc35@linux.dev>
 <20260329043700.19355-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329043700.19355-1-r@hev.cc>

On Sun, Mar 29, 2026 at 12:37:00PM +0800, WANG Rui wrote:
> > mapping_max_folio_size() reflects what the page cache will actually
> > allocate for a given filesystem, since readahead caps folio allocation
> > at mapping_max_folio_order() (in page_cache_ra_order()). If btrfs
> > reports PAGE_SIZE, readahead won't allocate large folios for it, so
> > there are no large folios to coalesce PTEs for, aligning the binary
> > beyond that would only reduce ASLR entropy for no benefit.
> > 
> > I don't think we should over-align binaries on filesystems that can't
> > take advantage of it.
> 
> Ah, it looks like this might be overlooking another path that can create
> huge page mappings for read-only code segments: even when the filesystem
> (e.g. btrfs without experimental) didn't support large folios,
> READ_ONLY_THP_FOR_FS still allowed read-only file-backed code segments
> to be collapsed into huge page mappings via khugepaged.
> 
> As Wilcox pointed out, it may take quite some time for many filesystems
> to gain full large folio support? So what I'm trying to clarify is that
> using mapping_max_folio_size() on this path is not favorable for
> khugepaged-based optimizations.

Nono, that's not what I'm pointing out!  btrfs is simply not putting
in the effort to support large folios, and that needs to change.
READ_ONLY_THP_FOR_FS unnecessaily burdens the rest of the kernel.
It was a great hack for its time and paved the path for a lot of what
we have today, but it's time to remove it.
