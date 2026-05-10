Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA44A23;
	Sun, 10 May 2026 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436857; cv=none; b=allpTb4/jlk9PHgkDzOTs1aRASrpafnkv/PjdQX3/bcWm3uqyyUJwxqymHTyaIXFNnnZCLDoJ9oTCXlqqAZQBwA72yO2aNI7hmUa/fwAQiB0pIFH+j4+FwIl3K3UhevQwF4UATcdFsSyHqLta98X7MFcP68K6DGXK5IOQuykeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436857; c=relaxed/simple;
	bh=PhetAfllKMyfPzAWtny4iIUqDcs3Fb1MfLNV88/vFXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNnHnstzWep7vl/I+UtLZY7o+aXGbrDJj4QDIeKY5bbx5uH6t+ZNbRVsEHGBgLt6B4THX2nxGrDpMnvQIsg8HK4hsjAGjKB0bubpRaqEdIbKek6tl91SqCqqUOAXyrNacSdjr5MeOr1dLXSafgHU/ulyzJJTRh8UADz9RU9ATL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GgKCXiRQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GgKCXiRQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W7DQ/vYvARfFdJB/8x28wyGNzuZPqszRQWFPsJhFTXk=; b=GgKCXiRQMDX1z0icy8zy7crt/O
	htvqNd1Iy3SJ9eIdtoLcJ1HUdlhue0sYkt9FLhXehrPrkAyAUap77KeCVYaxTTZmOq0mMeDBbhwgu
	G2gtj8NDrO/+r0vYE78ttuIJfDPifSvvVvWwtgqoBQoRv82QDRLMuVcmeW8HETTgBfxMnU9wb0A/u
	kibGr0Yc6VHdh+P12gU5t2aMuyvxrmGo4aKeLVTh7ovag8Eh81ftT9HayNLGIyCAGY1/5SVRFqi0X
	Sw+ztLChK4995aHcOb/no7zNbwzPuMP2HX+arpl7hbnXpYaZTMWliJoMWRAi8u3Khjyq+cr4QBxOm
	OWSa5BFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wM8fB-000000078hx-0W3t;
	Sun, 10 May 2026 18:14:01 +0000
Date: Sun, 10 May 2026 19:14:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: fujunjie <fujunjie1@qq.com>, David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/fadvise: avoid remote LRU drain for mapped folio
 failures
Message-ID: <agDK6PkESVR5OOYn@casper.infradead.org>
References: <tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com>
 <20260508163549.40a7f3c8c4286a553855b02e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508163549.40a7f3c8c4286a553855b02e@linux-foundation.org>

On Fri, May 08, 2026 at 04:35:49PM -0700, Andrew Morton wrote:
> On Wed,  6 May 2026 11:23:59 +0000 fujunjie <fujunjie1@qq.com> wrote:
> 
> > generic_fadvise(POSIX_FADV_DONTNEED) drains the local LRU batch and
> > then tries to invalidate the requested page-cache range. If any folio
> > could not be evicted, it assumes that a remote per-cpu LRU batch might
> > be pinning the folio, calls lru_add_drain_all(), and walks the mapping
> > again.
> > 
> > ...
> > 
> > Teach the folio eviction path to report whether a failure hit the
> > existing refcount check on a clean, unmapped folio. Only request the
> > global drain for that case. This preserves the existing fallback for
> > failures that a remote LRU drain can plausibly fix, while avoiding it
> > for failure reasons that a remote drain is not expected to resolve.
> > 
> 
> Thanks.  AI reviw asked one question:
> 	https://sashiko.dev/#/patchset/tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com

That's a pretty poor quality review.

My question is why we do this bizarre thing of switching between an
unsigned long and a bool pointer.

I would also avoid creating __mapping_evict_folio() and do the test for
folio_mapped() in mapping_try_invalidate().  It all feels a bit weird
(both this patch and the original code), and probably needs a lot more
thought, which I'm not in a position to do right now.
