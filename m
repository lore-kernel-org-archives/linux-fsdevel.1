Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483886;
	b=vQXDtJ4rQ4qHHz1xK/ppVnLC76Sefwyz0Q1XAjS3AVrB5G9fjvCrSmgJ2ubyQ/cno/Cr
	 Xc7HbhIt9ltXjTbNKca/8LZyuw+o3L16bb5LyX9VlI2TmDXwH29p1buOCMgIJZJ9Yk4HI
	 A6imaZXxgGZSWVdjLbCCYrR79WAr2ogOEIS3cddTC72lJoadtRkZ0NZ+GCs9Rltb48tYh
	 wLsuPoowVue/jwqDDLC8fqTB7g/2qRdb4uDWonAujKAz1s3ZvF4jv0/bEqi3/Sh1KC1wE
	 AEalUwZLRMzreKfUJeAejsrCUSzI9WVdKzTx5OT90HRFQo0OZf3wapG8Io34dljiG3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483886;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=29DfDf92HJiDUL83I37Z0UvfOScd+vQEdrJlJIoDRwA=;
	b=d/wfzwlfJxm2lkakAdlep7FhA9ijOLodtBvjUxcSY5f/C10Ton7a7/i0CxFkIXbAYnvB
	 KtAR8CP0AkKQQ9vHhdTjBJDAj6TU/NHkh4TRaKeI6MTKvJiVYtmMYCOUg/Ca3O6uTxKFR
	 qnJm1DpR647QdnkdUUf00okUppJMr4iiCARGI1kFQ6v8GNoW9DIniGYtZmAEgc6prx2OE
	 Fqz3v8D91AoX78ugQ8ccaD647HBrMypEbOvzX3JNT10HZNHHZOlm/faFphA1kcWXsftgl
	 IMzLPrQkKjVOJOIxRsOyIRX9+Mwly9c2tu/Mbd9PFcqTkljIc7p4ocrfRsUIYJL8AkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ku73Bd5y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04928606A31C;
	Thu, 12 Nov 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ku73Bd5y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B0C1F00A05;
	Thu, 12 Nov 2026 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483885;
	bh=29DfDf92HJiDUL83I37Z0UvfOScd+vQEdrJlJIoDRwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ku73Bd5yVw8b1EmirbB6jleUqSys9iYOVVK9yks/a5tGtyTHMJ0+fEGxF36zS0ytP
	 5EpOVVxk15XxPb/5DZS6vYUkekBPm8w6U5948DFvNmm1vf4EpMwk1mORPS7MHUWRLH
	 aKO93vIOStl3yHd146oBCCWPAdjvrKJg9/XlFy/Ab5+889DP/EIGy1J0E32/fZJpfu
	 RTJH8/jbs2rDwlbUmROAZqWeVx4/st8JltKaOOCATmPu7rG77dd9k2XA1WGPJPY/Zg
	 AKW9nE3UIc8YmGe+QVT3hnANsqYuVp3CS9r7ERYD8Gc9Np4g3yk+y02FZJCeCffOas
	 6iJFhsZyXnoSQ==
Date: Thu, 12 Nov 2026 11:44:34 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/12] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
Message-ID: <avWmiBbDYmy8MKiu@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:15PM -0500, Tal Zussman wrote:
> Without UFFD_FEATURE_EVENT_REMAP, the new VMA of an mremap() is not
> registered with userfaultfd: mremap_userfaultfd_prep() drops the context
> from it once the move succeeded. The uffd-wp bits, uffd-wp markers, and
> RWP PAGE_NONE entries in the new VMA must be cleared as well.
>
> However, move_ptes(), move_huge_pmd(), and move_huge_pte() clear them
> from each entry while moving it, before we know whether the move will
> succeed. If a page table allocation fails halfway through, mremap()
> moves the entries back into the old VMA, which is still registered,
> without their uffd state.
>
> Writes to a WP range are then no longer reported, and an RWP range
> becomes accessible without a fault. Nothing restores the protection
> afterwards. This requires a page table allocation to fail in the middle
> of mremap(), so it is rare.
>
> The uffd state must only be cleared once the move can no longer fail. To
> fix it, leave the entries alone during the move and clear the uffd state
> of the new VMA in mremap_userfaultfd_prep(), right before dropping the
> context, using userfaultfd_clear_ptes() like unregistering does. A
> failed move then puts the entries back as they were.
>
> This adds a second walk over the page tables of the new VMA, for VMAs
> registered for WP or RWP without UFFD_FEATURE_EVENT_REMAP.
>
> Like unregistering, userfaultfd_clear_ptes() also asks for the PTEs to
> be made writable again where that is safe (MM_CP_TRY_CHANGE_WRITABLE).
> The old code only cleared the uffd bit and left the PTE read-only. For
> private anonymous memory this saves the minor fault on the first write
> to each page that was protected.
>
> However, this adds spurious minor faults on shmem and hugetlb. When
> resolving, change_protection() rewrites every present entry in the range
> with vma->vm_page_prot, so a page that was writable and not protected is
> made read-only, and its first write after mremap() faults.
> UFFDIO_UNREGISTER and UFFDIO_WRITEPROTECT already behave this way and
> lead to the same spurious faults. This needs to be fixed in
> change_protection() and will be done in a separate change.
>
> The entries no longer need per-entry handling during the move, so drop
> uffd_supports_page_table_move(). Where the old and new addresses are
> suitably aligned, move_normal_pmd() and move_normal_pud() can move whole
> page tables of these VMAs again.
>
> clear_uffd_wp_pmd() has no users left, so remove it.

This reads a little schloppy, I wonder if it coudl be cut down a bit?

>
> Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
> Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

This LGTM and is secretly a cleanup which I love :) So:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/huge_memory.c | 25 -------------------------
>  mm/hugetlb.c     | 27 +--------------------------
>  mm/mremap.c      | 46 +---------------------------------------------
>  mm/userfaultfd.c |  1 +
>  4 files changed, 3 insertions(+), 96 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 09176b290f76..468a49041b95 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2616,18 +2616,6 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
>  	return pmd;
>  }
>
> -static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
> -{
> -	if (pmd_none(pmd))
> -		return pmd;
> -	if (pmd_present(pmd))
> -		pmd = pmd_clear_uffd(pmd);
> -	else
> -		pmd = pmd_swp_clear_uffd(pmd);
> -
> -	return pmd;
> -}
> -
>  bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
>  {
> @@ -2663,19 +2651,6 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>  		}
>  		pmd = move_soft_dirty_pmd(pmd);
> -		if (vma_has_uffd_without_event_remap(vma)) {
> -			/*
> -			 * See __copy_present_ptes(): normalise the RWP marker
> -			 * so the destination starts accessible instead of
> -			 * taking a numa-hinting fault on first access. Only the
> -			 * marker (protnone + uffd) needs it; leave other present
> -			 * PMDs in the VMA untouched.
> -			 */
> -			if (pmd_present(pmd) && userfaultfd_rwp(vma) &&
> -			    pmd_uffd(pmd))
> -				pmd = pmd_modify(pmd, vma->vm_page_prot);
> -			pmd = clear_uffd_wp_pmd(pmd);
> -		}
>  		set_pmd_at(mm, new_addr, new_pmd, pmd);
>  		if (force_flush)
>  			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cb2de24affdc..97bd29925476 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5168,7 +5168,6 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
>  			  unsigned long sz)
>  {
> -	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
>  	struct hstate *h = hstate_vma(vma);
>  	struct mm_struct *mm = vma->vm_mm;
>  	spinlock_t *src_ptl, *dst_ptl;
> @@ -5179,31 +5178,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  	double_pt_lock(dst_ptl, src_ptl);
>
>  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
> -
> -	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte)) {
> -		huge_pte_clear(mm, new_addr, dst_pte, sz);
> -	} else {
> -		if (need_clear_uffd_wp) {
> -			if (pte_present(pte)) {
> -				/*
> -				 * See __copy_present_ptes(): normalise the RWP
> -				 * marker so the destination starts accessible
> -				 * instead of taking a numa-hinting fault on
> -				 * first access. Only the marker (protnone + uffd)
> -				 * needs it; leave other present PTEs untouched.
> -				 */
> -				if (userfaultfd_rwp(vma) && huge_pte_uffd(pte)) {
> -					pte = huge_pte_modify(pte, vma->vm_page_prot);
> -					pte = arch_make_huge_pte(pte, huge_page_shift(h),
> -								 vma->vm_flags);
> -				}
> -				pte = huge_pte_clear_uffd(pte);
> -			} else {
> -				pte = pte_swp_clear_uffd(pte);
> -			}
> -		}
> -		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
> -	}
> +	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
>
>  	double_pt_unlock(dst_ptl, src_ptl);
>  }
> diff --git a/mm/mremap.c b/mm/mremap.c
> index fff0465f5e06..4564416a6994 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -198,7 +198,6 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
>  {
>  	struct vm_area_struct *vma = pmc->old;
> -	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
>  	struct mm_struct *mm = vma->vm_mm;
>  	pte_t *old_ptep, *new_ptep;
>  	pte_t old_pte, pte;
> @@ -290,27 +289,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
>  		pte = move_pte(pte, old_addr, new_addr);
>  		pte = move_soft_dirty_pte(pte);
> -
> -		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
> -			pte_clear(mm, new_addr, new_ptep);
> -		else {
> -			if (need_clear_uffd_wp) {
> -				if (pte_present(pte)) {
> -					/*
> -					 * See __copy_present_ptes(): normalise
> -					 * RWP PTEs so the destination starts
> -					 * accessible instead of taking a
> -					 * numa-hinting fault on first access.
> -					 */
> -					if (userfaultfd_rwp(vma) && pte_uffd(pte))
> -						pte = pte_modify(pte, vma->vm_page_prot);
> -					pte = pte_clear_uffd(pte);
> -				} else {
> -					pte = pte_swp_clear_uffd(pte);
> -				}
> -			}
> -			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
> -		}
> +		set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
>  	}
>
>  	lazy_mmu_mode_disable();
> @@ -334,25 +313,6 @@ static inline bool arch_supports_page_table_move(void)
>  }
>  #endif
>
> -static inline bool uffd_supports_page_table_move(struct pagetable_move_control *pmc)
> -{
> -	/*
> -	 * If we are moving a VMA that has uffd-wp registered but with
> -	 * remap events disabled (new VMA will not be registered with uffd), we
> -	 * need to ensure that the uffd-wp state is cleared from all pgtables.
> -	 * This means recursing into lower page tables in move_page_tables().
> -	 *
> -	 * We might get called with VMAs reversed when recovering from a
> -	 * failed page table move. In that case, the
> -	 * "old"-but-actually-"originally new" VMA during recovery will not have
> -	 * a uffd context. Recursing into lower page tables during the original
> -	 * move but not during the recovery move will cause trouble, because we
> -	 * run into already-existing page tables. So check both VMAs.
> -	 */
> -	return !vma_has_uffd_without_event_remap(pmc->old) &&
> -	       !vma_has_uffd_without_event_remap(pmc->new);
> -}
> -
>  #ifdef CONFIG_HAVE_MOVE_PMD
>  static bool move_normal_pmd(struct pagetable_move_control *pmc,
>  			pmd_t *old_pmd, pmd_t *new_pmd)
> @@ -365,8 +325,6 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
>
>  	if (!arch_supports_page_table_move())
>  		return false;
> -	if (!uffd_supports_page_table_move(pmc))
> -		return false;
>  	/*
>  	 * The destination pmd shouldn't be established, free_pgtables()
>  	 * should have released it.
> @@ -434,8 +392,6 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
>
>  	if (!arch_supports_page_table_move())
>  		return false;
> -	if (!uffd_supports_page_table_move(pmc))
> -		return false;
>  	/*
>  	 * The destination pud shouldn't be established, free_pgtables()
>  	 * should have released it.
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index ad9d243dc64b..bf42fabb5afd 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3161,6 +3161,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  		up_write(&ctx->map_changing_lock);
>  	} else {
>  		/* Drop uffd context if remap feature not enabled */
> +		userfaultfd_clear_ptes(vma, vma->vm_start, vma->vm_end);
>  		userfaultfd_reset_ctx(vma);
>  	}
>  }
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
