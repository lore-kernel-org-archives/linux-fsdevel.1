Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45443A7859;
	Tue,  7 Apr 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556614; cv=none; b=tcuUxZsG1LGYQit12MJkdYVhyfYZAQg1qTnemkOk5s32///hVUJlcRn2lbeooNzhBe37eZdjTMwCZiu5h7Jo7GRKuWN3886bzrAEQUVHvpKd6H7pFwjqAy5iluxVX5p3qBaVuILLjTYqcgXDTJWOrhft1W2scFjjF+kJfNmu4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556614; c=relaxed/simple;
	bh=uJwhrCZ5DVi1XGiVE85l7GZb0X3pCioNotmsUsRYefE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWbsEcabsA6uoQYmUyVKyVx9dwgv1RhzGprylvdSeOg337CN0aC08rSuJ1wTLpKWN/gm7Y5crkWdB4qKBfu96XEfUUE1TxU/DW/3ZyDxeMZN9akLOn7FAFHk3XEYG6qjaPBel5PZQS/R2YPzD/Vxh0lVmQLwPbG4okIP4TnSqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkumau9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkumau9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF52C116C6;
	Tue,  7 Apr 2026 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775556614;
	bh=uJwhrCZ5DVi1XGiVE85l7GZb0X3pCioNotmsUsRYefE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkumau9ZkicHGxV91qxYWjPubXMFULLZk3pPmXQ7EZvc6i+zLYpzG1V+ahiER9OHH
	 BR5AHjlnw6nKN9it8TN9PvZR63KdbXLwqng9rQ+UGRcVw8LeYS/qsFHwfRFzJQ54w+
	 tYI+dvFq5PhS+fszRDxi4GsTLjolDl+T59NdJz/T7VqPArV9p/+waErCWpJZP8A1qc
	 RqecKtM08KUOQRJihnsNRHncdPa1Th4gfCJZl3zKWr1gq/ZWljZIh3ouGYcehbBbto
	 r2v6KzKZTzc5eTJTEOjYLm1TxZ6Wrbof2WBXKtY+FurfLniwKd/dPAW4Tpqi7LJXhV
	 vGupcfnvlxl+g==
Date: Tue, 7 Apr 2026 11:10:05 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>, 
	Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <adTXtnJs_Rnl_pTD@lucifer>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer>
 <adOtS_q1MuFOawGM@lucifer>
 <adQFYAVGLqv6amZK@gsse-cloud1.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adQFYAVGLqv6amZK@gsse-cloud1.jf.intel.com>

On Mon, Apr 06, 2026 at 12:11:28PM -0700, Matthew Brost wrote:
> On Mon, Apr 06, 2026 at 01:56:49PM +0100, Lorenzo Stoakes (Oracle) wrote:
> > On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> > > I see John gave a tag (and he's great so that gives me confidence here),
> > > but we should really follow the procedure on this properly.
> >
> > Oh and just noticed Alastair also :) so that adds further confidence, so this is
> > really a point about cc/M signoff requirement going forwards.
>
> +1.
>
> Andrew did ACK this via DRM here [1].
>
> When we take external subsystem patches through DRM, our merge script
> requires ACKs from an external maintainer, as determined by
> get_maintainers.pl.
>
> I’m not sure what happened here, but it looks like Andrew’s ACK was lost
> on the patch, and somehow our merge tool allowed it to go in regardless.
> We will be more diligent going forward.

ACK on that... ack :), but please make sure to cc- at least the relevant
maintainers on these series going forwards also.

I realise mm has changed somewhat in its approach with this so forgiveable you
missed it :>) but - at least for me - reading mailing lists is just out due to
bandwidth limitations.

>
> Matt
>
> [1] https://patchwork.freedesktop.org/patch/703183/?series=161082&rev=3#comment_1294670
>
> >

Thanks, Lorenzo
