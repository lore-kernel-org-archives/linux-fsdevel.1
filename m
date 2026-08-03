Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863F33A715;
	Mon,  3 Aug 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769674; cv=none; b=Jdw395hIEm6igI5s1iw4HQmLNkEFtEHjaC7E/bH4XbutRzOZaWH5eFjLV2pxgd6uYlDHhRpOcDtlYKApJBZs8ZksK7tKRNb6w0M6AW+HjIIK1xTylnCyf70ZArWH5jIqo0kB+xJQ/+li6Jkj5z6fP3Zi1GdRWcE8CgmVXTbpr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769674; c=relaxed/simple;
	bh=Ko251mJv/SQcgstVdkYdop2Gk2wrmrPgyvD808/haAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU2QYXkOMrQkW38EiI63dD7eIhSoT14dxDCDbssAlTLqLnKoqGrgdplh1czWWE00sUByQoE798QI2U3im4oxS1eQjYCtY7E9vNPhZIJuCqtXVvGaZmmieXclHsjL2HfY+qAEnG4/59cMkVxAZ8X3+XYNUucD0nD3PNEH/rkK3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTE+/Up8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTE+/Up8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F21F000E9;
	Mon,  3 Aug 2026 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769673;
	bh=2T8dsYQ/yokvFm5Hvo97P6jloDB9Jam9qmoCjWPa3ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kTE+/Up8JVH3KqYp0V99R6t55UtaaF4Bc7Inu3jh3UFi/Y737TMAiYKJa88xngrEr
	 polOoaiwAbcv7tFVfJtN8xEPRkHNpQYwlXrhfaax/OjsrG7HnDN+PAgNfq4/DsO7MB
	 v953LXE8aEOhE2leCcJ5xkWy+eVEYGfNdUAyCyR14meMP+ZowKyYK0GWVvzmaRD66X
	 ArtIvBTLULpTgLUKJSE0SdAq5OTIzSy6K+HDGwlz+13KpDMZmSZV/6IqpO4zRJ2wEg
	 dExgwc6htXkMVcd9FN19bKEKTuZi0QBTqM9Qf7b2H/WD6Ts3jSOelXSAxREYW2TYd9
	 Noz9H8psSpAeQ==
Date: Mon, 3 Aug 2026 16:07:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Message-ID: <anCtxQE5hDUH5N6a@lucifer>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
 <am28pV2PEfHsi4p-@lucifer>
 <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>

On Mon, Aug 03, 2026 at 11:02:30AM -0400, Zi Yan wrote:
> On Sat Aug 1, 2026 at 5:36 AM EDT, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Jul 30, 2026 at 10:18:00PM -0400, Zi Yan wrote:
> >> During a pagecache folio split, an xarray node allocation can happen and
> >> needs to charge at folio's memcg instead of folio split invoker's memcg,
> >> because for example folio split can happen during reclaim and reclaim's
> >> active memcg might not be folio's memcg. Switch to folio's memcg at the
> >> beginning and switch back afterwards.
> >
> > I assume this is the only allocation? I guess in general it makes sense to have
> > the folio's memcg be active here regardless.
> >
> >>
> >> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
> >
> > Cc: stable?
>
> Like you said above, only xas_split_alloc() is affected. And we have not
> seen related workingset regression report (like what Johannes reported
> in commit 7b785645e8f13 ("mm: fix page cache convergence regression")).
> It might be OK to not backport.
>
> Johannes, what is your take on this?
>
> >
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >
> > Change seems reasonable overall.
> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> >> ---
> >>  mm/huge_memory.c | 20 ++++++++++++++++----
> >>  1 file changed, 16 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 04e8a6b553435..b9c2d8908e564 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -4063,34 +4063,42 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >>  	struct folio *end_folio = folio_next(folio);
> >>  	bool is_anon = folio_test_anon(folio);
> >> +	struct mem_cgroup *memcg, *old_memcg;
> >>  	struct address_space *mapping = NULL;
> >>  	struct anon_vma *anon_vma = NULL;
> >>  	int old_order = folio_order(folio);
> >>  	struct folio *new_folio, *next;
> >>  	int nr_shmem_dropped = 0;
> >>  	enum ttu_flags ttu_flags = 0;
> >> -	int ret;
> >>  	pgoff_t end = 0;
> >> +	int ret;
> >>
> >>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> >>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
> >>
> >>  	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
> >>  		ret = -EINVAL;
> >> -		goto out;
> >> +		goto out_no_memcg;
> >>  	}
> >>
> >>  	if (new_order >= old_order) {
> >>  		ret = -EINVAL;
> >> -		goto out;
> >> +		goto out_no_memcg;
> >>  	}
> >>
> >>  	ret = folio_check_splittable(folio, new_order, split_type);
> >>  	if (ret) {
> >>  		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
> >> -		goto out;
> >> +		goto out_no_memcg;
> >
> > This function really badly needs splitting up and probably some cleanup.h work :)
>
> You mean folio_check_splittable()? You want to move -EINVAL checks a
> separate one?

No __folio_split().

Comment about cleanup.h really was the whole pattern of goto xxx for various
levels of unwinding things.

But really I mean the folio splitting code in general, there's a lot of
massive-complicated-functions with a million things going on at once,
__folio_freeze_and_split_unmapped() is another.

Feels like we should really have this stuff in something like mm/folio.c anyway
too now that's renamed :)

>
> --
> Best Regards,
> Yan, Zi
>

--
Cheers, Lorenzo
