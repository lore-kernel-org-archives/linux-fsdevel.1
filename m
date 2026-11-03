Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694827;
	b=Mgop9o6h2TCuAOCAVdQ7ERV4PhJ7Vp0GPDq5Ql9iIv54yY33TlTzTKyfv3FECg/fF5ck
	 zCjA4hrcG9x/fAEClV5fZkdbHta5jgvNWc628mF+FZSUUY9lNXGUjr8+9i2zLlO3mTXvB
	 gBJfoO3A+HZ2H8ELJudPZWReJH+HL5TSnVlXrHaerAHuyB/9uGxb9KA79ziomioYwsRzl
	 ekpbjn3L8FJ62hyvJ0zE9cS4mpCWbVHT5QTviRKWFDjzn2D56+MzOElo81C+TYs5Rbu1X
	 B7RqQ1WWZXw7QwWe97gV0Jw2UjBOIqmdF9aYBGYchTOckuKD5doX8ASSYigl4gC79EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tfvXeQqavRG0qJSmkGBAVeLuElqbc+mhuty3br9tZ5Y=;
	b=0dvmNmMz2bXL8RynYP/dpufDukEphdWSgapC70gtrW32Q8K4rj4Ys2qI4fbDebe8DIn9
	 irydhYylRIO02fk5Kf5gMWVz+ZOQdFjKTkJJOYnVpN9Gddahr/Pk7F+nfhM0B5mvsILej
	 2aVnt1WqgrXZwkNEhVRlZmtGtH4NJdJA+J0H9Wm3xAT9h1jfPaXBkc1UsQj1qF+f8wuJ5
	 phx6h1AkoLqSgq3JqWxBdIPGrOYUhtLIbSExfJtIIjofCPsT9VrQPhxNEWVyOV912csH3
	 L5zbmdcjji9ieUn4i2KSo5129hc44aHbJAquOzbeVnuA1FhV5ij8v8eZnw2oZfR/FRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/GtuQdE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2360850A3;
	Tue,  3 Nov 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/GtuQdE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9787B1F00919;
	Tue,  3 Nov 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694827;
	bh=tfvXeQqavRG0qJSmkGBAVeLuElqbc+mhuty3br9tZ5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/GtuQdEQcRFugYP/2j1tR81r4z6KgErdVO1CFPNXSPKM43Yad13k32bTHv2iQxn/
	 X17EAqNAXwgz9XiHKAp0xSUPtRiy2QzOpzKlqhEEh8ddvarLKE2A1/f2hGPXeMug2W
	 THo2lYaveUaaIKe3lNeUqEzzCyaxDccwHdVcTIHNskQH8HLKFXg8adH6CfLvfspn9o
	 WjiJx0ZcXr9LDbW3oZXDXtVrndp+OlAO7xVoHiIB0WK+5+9OheInxmbqVqCmz6i29a
	 agyhx4CjdSE6EakD5C1zfbGuklXtRcN/VvcaIfk8syOXuSIATFUQvsOMu9CxP5Mn5r
	 8BH5LnwHocddA==
Date: Tue, 3 Nov 2026 08:33:39 +0000
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
Subject: Re: [PATCH 2/8] mm: remove end_page_writeback()
Message-ID: <aumcXM1XFURi5ycE@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-2-e7280bdb31f6@columbia.edu>
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
In-Reply-To: <20261102-page-wrappers-v1-2-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:07PM -0500, Tal Zussman wrote:
> There are no callers left. Update the two comments that still named
> it to refer to folio_end_writeback().
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h   | 1 -
>  include/linux/writeback.h | 2 +-
>  mm/folio-compat.c         | 6 ------
>  mm/migrate.c              | 2 +-
>  4 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c0f7c06dc6fd..692ce3867a1d 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1301,7 +1301,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
>  void folio_end_read(struct folio *folio, bool success);
>  void folio_wait_writeback(struct folio *folio);
>  int folio_wait_writeback_killable(struct folio *folio);
> -void end_page_writeback(struct page *page);
>  void folio_end_writeback(struct folio *folio);
>  void folio_end_writeback_no_dropbehind(struct folio *folio);
>  void folio_end_dropbehind(struct folio *folio);
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index b749a9a5a5ee..c50f404141b0 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -124,7 +124,7 @@ struct wb_domain {
>  	 * writeout speed.
>  	 *
>  	 * We do this by keeping a floating proportion between BDIs, based
> -	 * on page writeback completions [end_page_writeback()]. Those
> +	 * on page writeback completions [folio_end_writeback()]. Those
>  	 * devices that write out pages fastest will get the larger share,
>  	 * while the slower will get a smaller share.
>  	 *
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index f880110ac980..9f2cd0ebfbbd 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -17,12 +17,6 @@ void unlock_page(struct page *page)
>  }
>  EXPORT_SYMBOL(unlock_page);
>
> -void end_page_writeback(struct page *page)
> -{
> -	return folio_end_writeback(page_folio(page));
> -}
> -EXPORT_SYMBOL(end_page_writeback);
> -
>  void mark_page_accessed(struct page *page)
>  {
>  	folio_mark_accessed(page_folio(page));
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 94e8cd46c6db..953af633ec0d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -859,7 +859,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>
>  	/*
>  	 * PG_readahead shares the same bit with PG_reclaim.  The above
> -	 * end_page_writeback() may clear PG_readahead mistakenly, so set the
> +	 * folio_end_writeback() may clear PG_readahead mistakenly, so set the
>  	 * bit after that.
>  	 */
>  	if (folio_test_readahead(folio))
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
