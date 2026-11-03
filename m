Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695048;
	b=ErPpH3T3MeSwvBYBHgjydlpGJ9T82hlBm0600sPAFiapqY4a4c51L0XtD8K2ISiTnZkO
	 r0DdBw1es7FfwapyH5t0jsHDfRKY68dFiOhHvQOMyyOMbcY6WhDuYiQMS4siw/npml5+O
	 Y84kNui2AB/otdBiQmj4zVAK/pvEk6KrKipTA5PuujpakZJeYuSxEE2ojUS6wZf/DGvsX
	 6D91GHagfDYzTOXDntG02m1W7IP+n4CX2UWvlPRwHYSBCWVWBYyNAYi/HDvNu2pytuyd8
	 iqnS736n7OUtxLEj6KQwX0pVJtwz2MY6vRcxtbDoAbo4RXF4j/0fZjuDUGouqFm4LRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695048;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=36ue9l0lxjyreF2KAgVZ/S2Q5NtWJdd1uqKRENrbVrc=;
	b=D8GRgWt9i9SmQ331kqbxdLcUfNeqiEIiPVHpWQU0LWUlttRtqybKACqO2s7VtQy4tvFM
	 SC2l8bQM6Uq7HcI143/hkjws5NiUwMe42ywfiBK1k67aJfIsVrR707Du7OEsJFfk6iU/0
	 WxqPAIc8xxzauuQc0WUyN20q7IPRb4aklTT4RWocey4bOyugib0KBLL3qLbbuFupA7Wpo
	 aostvQP9UAQxd6DNj2ZZniVaWItK8BGE9lMLU8qsRozJcFTnju8z/8XHvYRftg8dXyhRS
	 SvGlYNdCLGQMqujAGi0c7QVvogDklLZ1racmBbyvB2F7dNQj15p1XjEnfzyoOgQlX/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUwUm4Yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C7606A33E;
	Tue,  3 Nov 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUwUm4Yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1721F01802;
	Tue,  3 Nov 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695047;
	bh=36ue9l0lxjyreF2KAgVZ/S2Q5NtWJdd1uqKRENrbVrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aUwUm4YjE8yZ8DotXKncj8C+/v6y2l2qeBxMJD7QAKiAlCAfdY8kyLGH1ztvVMvyV
	 sdOVKjuU7ve7ffcYq0mLG5F+l8VjouhdEEMOdvnZO5hsmN4mmhxVpT2IDhB6T6hwm7
	 GHd5lNmqj6ppo+OChkh7KYRTE0/YRrlOiqkwS+oqX2ywjeNDN+iYPB04iugqbhlHtP
	 NiVapLY/XPLWd1zEevrTBvrSKCiyN3x8cWPqww4zT32H+TT2+Mn8oyWsYENsn5Fbc5
	 PhHT1uLMSfC8sCf6sVMyDL0ESyBMCEi4ercOoaNw5oxRvU+hEo+pr+laB7KB9zLawD
	 YH4mrIgI6UIew==
Date: Tue, 3 Nov 2026 08:37:19 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] mm: remove read_cache_page_gfp()
Message-ID: <aumdHgUtiQzkNzs6@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-7-e7280bdb31f6@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-page-wrappers-v1-7-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:12PM -0500, Tal Zussman wrote:
> There are no callers left. Point the comment on shmem_read_folio_gfp()
> at mapping_read_folio_gfp() instead.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h |  2 --
>  mm/filemap.c            | 23 -----------------------
>  mm/shmem.c              |  4 ++--
>  3 files changed, 2 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a92329805acd..305c99bad689 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -962,8 +962,6 @@ struct folio *mapping_read_folio_gfp(struct address_space *, pgoff_t index,
>  		gfp_t flags);
>  struct page *read_cache_page(struct address_space *, pgoff_t index,
>  		filler_t *filler, struct file *file);
> -extern struct page * read_cache_page_gfp(struct address_space *mapping,
> -				pgoff_t index, gfp_t gfp_mask);
>
>  static inline struct page *read_mapping_page(struct address_space *mapping,
>  				pgoff_t index, struct file *file)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1df776907140..2b724d9be94b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4258,29 +4258,6 @@ struct page *read_cache_page(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(read_cache_page);
>
> -/**
> - * read_cache_page_gfp - read into page cache, using specified page allocation flags.
> - * @mapping:	the page's address_space
> - * @index:	the page index
> - * @gfp:	the page allocator flags to use if allocating
> - *
> - * This is the same as "read_mapping_page(mapping, index, NULL)", but with
> - * any new page allocations done using the specified allocation flags.
> - *
> - * If the page does not get brought uptodate, return -EIO.
> - *
> - * The function expects mapping->invalidate_lock to be already held.
> - *
> - * Return: up to date page on success, ERR_PTR() on failure.
> - */
> -struct page *read_cache_page_gfp(struct address_space *mapping,
> -				pgoff_t index,
> -				gfp_t gfp)

Also eliminates this very weird line-wrapping... :)

> -{
> -	return do_read_cache_page(mapping, index, NULL, NULL, gfp);
> -}
> -EXPORT_SYMBOL(read_cache_page_gfp);
> -
>  /*
>   * Warn about a page cache invalidation failure during a direct I/O write.
>   */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index de838dbb4df8..16b1cc3d8ac5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -6190,9 +6190,9 @@ int shmem_zero_setup_desc(struct vm_area_desc *desc)
>   * @index:	the folio index
>   * @gfp:	the page allocator flags to use if allocating
>   *
> - * This behaves as a tmpfs "read_cache_page_gfp(mapping, index, gfp)",
> + * This behaves as a tmpfs "mapping_read_folio_gfp(mapping, index, gfp)",
>   * with any new page allocations done using the specified allocation flags.
> - * But read_cache_page_gfp() uses the ->read_folio() method: which does not
> + * But mapping_read_folio_gfp() uses the ->read_folio() method: which does not
>   * suit tmpfs, since it may have pages in swapcache, and needs to find those
>   * for itself; although drivers/gpu/drm i915 and ttm rely upon this support.
>   *
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
