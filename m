Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F5382F0C;
	Wed,  5 Aug 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920575; cv=none; b=Gdi3px2Es0F+J/aEUzuti7a+SLBdy+vnucZUzO4tj4mfAOTMHu+Ma+7NF90+9C7CWJbPg1ts4IK2A5E1sJyIJVW3vrVPsGSL3GI5FPWUgN/puhHTcHqSZPvTcKZGpZTc2KIDOE09rT+bnNu1kRRjlEbOPzhM+A054rog+mgPIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920575; c=relaxed/simple;
	bh=Zo0vAXWEVufs5MOBKv2sR8Dcrtepcq6hf/X0qwr7AzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzI9pAZWuIrVKbqBL0CIQZlM4by4qMGobRYz1Dr3VRvtckPCU1WrQhM0aTX6g/RJ97nUWdVspeBC+G/yX+qE8PDmM3mAD3+ARsf8MZGmNR8mf7iYhhDUbre3ajsPoFHNNILlhHEPqAlXAE6W+P1F/a9t4n9p5tEuYi2RIdR1LZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbk0d4Ai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbk0d4Ai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6223F1F000E9;
	Wed,  5 Aug 2026 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920574;
	bh=DgUrRaLpxOH3ntUG5C+r2jZs0iCEzrHMP112JlOYgdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fbk0d4Ai1zF/PGXaiBJQGtW2oxIUYnp9HEblf0k8GtwWk5+okgt6pTJdRNX7dYjOJ
	 fkNqkG540pwyGbtf5TaLzFfmBB7hsNgsZP5SCQtl/qq22iIycL8aw6UWCxPdSJUMk+
	 B6u34hQxfcxzPi2aCanJ7nKbfDLFkBxOkQFwT+L0c8yN7KPsBXdxJhzVGkCW5G6Ief
	 iSSI8N0DPeoFCMmwk7hurdH0//lJJRpi23UeVr+DaDP4aNgIYfJZSkU5svn0XZN97v
	 L+TtkcLIHa3zYYr34b2cxCZtY4XHUzeKawfDYk97rQVIxlZ6ithQvVpEXvvwvh1e4Z
	 MPUIB/mEo+ijg==
Date: Wed, 5 Aug 2026 10:02:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 08/15] mm: introduce and use linear_folio_page_index()
Message-ID: <anL8EawRefur2cc2@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-8-e8ecfefea812@kernel.org>
 <0d9f3040-825d-49af-9d07-1e7945dd3e9d@kernel.org>
 <anCdkHNmG5K43E6l@lucifer>
 <784eab3a-2b37-476c-a6fc-7fb6e27b6c66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784eab3a-2b37-476c-a6fc-7fb6e27b6c66@kernel.org>

On Wed, Aug 05, 2026 at 09:26:59AM +0200, David Hildenbrand (Arm) wrote:
> On 8/3/26 16:30, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 01:27:09PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> >>> This function is, for now, a placeholder; it will be used in future to
> >>> determine whether to use the anonymous page index or not, based on whether
> >>> the folio is anonymous or not.
> >>>
> >>> Currently it simply wraps linear_page_index(), so this does not change
> >>> behaviour.
> >>>
> >>> We update callers that will, once the change is introduced to track
> >>> anonymous folios by anonymous page offset if MAP_PRIVATE file-backed, need
> >>> to determine which index to use based on folio type.
> >>>
> >>> No functional change intended.
> >>>
> >>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >>> ---
> >>>  include/linux/pagemap.h | 18 ++++++++++++++++++
> >>>  mm/huge_memory.c        |  3 ++-
> >>>  mm/migrate.c            |  6 ++++--
> >>>  mm/userfaultfd.c        |  6 ++++--
> >>>  4 files changed, 28 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> >>> index 259177544b03..6eb8d811ba4c 100644
> >>> --- a/include/linux/pagemap.h
> >>> +++ b/include/linux/pagemap.h
> >>> @@ -1143,6 +1143,24 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
> >>>  	return pgoff;
> >>>  }
> >>>
> >>> +/**
> >>> + * linear_folio_page_index() - Determine the absolute page offset of
> >>> + * @address within @vma from @folio.
> >>> + * @folio: The folio whose linear page index is sought.
> >>> + * @vma: The VMA in which @address resides.
> >>> + * @address: The address whose absolute page offset is required.
> >>> + *
> >>> + * For compatibility, currently identical to linear_page_index().
> >>> + *
> >>> + * Returns: The absolute page offset of @address within @vma.
> >>> + */
> >>> +static inline pgoff_t linear_folio_page_index(const struct folio *folio,
> >>> +					      const struct vm_area_struct *vma,
> >>> +					      const unsigned long address)
> >>> +{
> >>> +	return linear_page_index(vma, address);
> >>> +}
> >>
> >>
> >> I found this to be rather confusing, given that we now have a "folio" helper that
> >> receives a folio and a "page" helper that doesn't receive a page ...
> >
> > This is just to avoid having to duplicate the if (folio_test_anon()) { ... }
> > else { ... } stuff.
> >
> > Agreed it's a bit confusing!
> >
> > Really you are figuring things out from (vma, address) - 'what is the correct
> > page offset based on the VMA'.
> >
> > And yeah it seems migrate can do it via PFN as you suggest, it really is
> > just trying to find the page offset in the folio.
> >
> > But...
> >
> >>
> >> I guess the problem is the "page" in "linear_page_index", as it
> >> reminds of legacy page->index.
> >>
> >>
> >> I wonder if it would be better to have a linear_folio_index() and
> >> force that address points at the start of the folio.
> >>
> >> Looking below, this is exactly what we want for all except one case:
> >
> > ...I don't think this is true.
> >
> > The uffd code uses this too in move_present_ptes():
> >
> > 		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
> > 							   dst_addr);
> >
> > And it's now _updating_ the source folio index to the offset in the destination
> > VMA, so it doesn't even relate to the source folio's offset at all?
> >
> > (move_swap_pte() calls linear_folio_page_index() but obviously has to be
> > anon, so that can just use linear_anon_page_index() there instead, will
> > update.)
> >
> > With your change we can just eliminate the linear_folio_page_index()
> > function and open-code the uffd case.
>
> The would be even better!
>
> >
> > It's a bit of a special case anyway and is neatly the one place where you
> > actually don't know if it's anon or file-backed (well anon or shmem
> > specifically I think).
> >
> >>
> >>
> >>>  		/* pgoff is invalid for ksm pages, but they are never large */
> >>> -		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> >>> -			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
> >>> +		if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
> >>> +			idx += linear_folio_page_index(folio, vma, pvmw.address);
> >>> +			idx -= pvmw.pgoff;
> >>> +		}
> >>>  		new = folio_page(folio, idx);
> >>
> >> I think we could avoid this index work entirely by using the pfn, which is much
> >> clearer to me, and similar to how we handle it during other rmap operations.
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 222c8c15f782f..686351d353203 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -362,17 +362,12 @@ static bool remove_migration_pte(struct folio *folio,
> >>                 struct page *new;
> >>                 unsigned long idx = 0;
> >>
> >> -               /* pgoff is invalid for ksm pages, but they are never large */
> >> -               if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> >> -                       idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
> >> -               new = folio_page(folio, idx);
> >> -
> >>  #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
> >>                 /* PMD-mapped THP migration entry */
> >>                 if (!pvmw.pte) {
> >>                         VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
> >>                                         !folio_test_pmd_mappable(folio), folio);
> >> -                       remove_migration_pmd(&pvmw, new);
> >> +                       remove_migration_pmd(&pvmw, folio_page(folio, idx));
> >
> > I think we'd need the idx code below to go above where the idx code is now
> > as otherwise this will be incorrect right?
> >
> > But then again, if it's a PMD softleaf it'd have to be aligned right, so
> > couldn't we just update that function to be passed a folio instead and
> > avoid the idx here at all?
>
> Right, that's what I mentioned below
>
> "remove_migration_pmd() will work for now. Later it should just receive the folio
> and do the same thing through softleaf_from_pmd() -> softleaf_to_pfn().
>
> >
> >>                         continue;
> >>                 }
> >>  #endif
> >> @@ -385,10 +380,14 @@ static bool remove_migration_pte(struct folio *folio,
> >>                     try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
> >>                         continue;
> >>
> >> +               entry = softleaf_from_pte(old_pte);
> >> +               if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> >> +                       idx = softleaf_to_pfn(entry) - folio_pfn(rmap_walk_arg->folio);
> >
> > Could actually be softleaf_to_pfn(entry) - pvmw.pfn even?
>
> Given that DEFINE_FOLIO_VMA_WALK() sets
>
> 	.pfn = folio_pfn(_folio);
>
> I think so.
>
> >
> >> +               new = folio_page(folio, idx);
> >> +
> >>                 folio_get(folio);
> >>                 pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
> >>
> >> -               entry = softleaf_from_pte(old_pte);
> >>                 if (!softleaf_is_migration_young(entry))
> >>                         pte = pte_mkold(pte);
> >>                 if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entr
> >>
> >>
> >> remove_migration_pmd() will work for now. Later it should just receive the folio
> >> and do the same thing through softleaf_from_pmd() -> softleaf_to_pfn().
> >
> > Ah you already addressed it. But since this would move the idx code above,
> > I think I should just change it to accept a folio instead?
> >
> > Or for less churn &folio->page...
> Right, whatever you prefer.

Awesome will do all that on respin :)

Thanks for the review, this is actually really improving the series :>)

>
>
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
