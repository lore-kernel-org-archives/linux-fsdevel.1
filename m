Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAE4DD3CD;
	Tue, 22 Sep 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073873; cv=none; b=J7yeFPy8/cXLsZ8nptKlsEBe+k5SJMXv0bHLp0hxlL0A++txoj5ct01XzyeeamKyECgBj2kqulQ8zXpjqaGlbAmrhKXxcEWwG15PF2qrCos8yeZ3w7r3P2rRWSkDMrBirFdOMZjCKeHgOpVdz/4W8EoYMWIw7daFAurQyH4BcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073873; c=relaxed/simple;
	bh=e8bCTfl75sUiv6EJjmndrDCNdaNR+PwKnj6BqYYrhTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYfh0oIH5OSXkqTL0KQMJmMU6KRxE6oS6hBK6SmFKtBI0qUM4cFWUm59lasemaGDYg7/brZc88FZOOXEA6G+82kBFlO0jBkxtfQnOFOutq8PE8OYCGQ3x53DnRfL2N8N4U6NFXgup4DzlQO3tvJmJC6kRs/9DZK+Zj3x2J5FQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBZGd/6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBZGd/6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6011F000FF;
	Tue, 22 Sep 2026 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790073871;
	bh=wcMQmIzokG2WkS3BH0QYMZ4QUKceHLHs78Bpc/jrgDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QBZGd/6FCctyGl6nuvfOSLD1AsLG3Ws3b+fcPdo0JRpQLvGY7pxGTi+2QkHI55Hih
	 c0haQuGfymCeP4oykSm3NNy/kdCXOU7EMZBEPmJ/7KiYgAhBNgMy5voxmeDJjND6/y
	 rWqG1ejFPtoXHDDX6Z4QX9es7B7b0fTZ6L41cTYlrKeRGd3WNxsMyQb1y/RllOsCYE
	 h5K2i+P01Y+ZWkklCk+0IL8/HYWIH1N/pbMK04f5GrqHJRav4g42tiVTrRurPo5vpb
	 5LFcikNvCD6Sm1zOxusE4hnApBjcG2dqPbHTd+7wdT7Y/RbhJImTCAw9D/0i9cXUFW
	 blcj4dPjKpcBA==
Date: Tue, 22 Sep 2026 11:44:20 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	liam@infradead.org, david@kernel.org, vbabka@kernel.org, jannh@google.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, baohua@kernel.org, youngjun.park@lge.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, chengming.zhou@linux.dev, 
	kunwu.chan@gmail.com, tz2294@columbia.edu, hch@lst.de, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback
 completion
Message-ID: <arJYmwKnEu-djZlK@gremlin>
References: <20260921152449.629486-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921152449.629486-1-alex@ghiti.fr>

On Mon, Sep 21, 2026 at 05:24:33PM +0200, Alexandre Ghiti wrote:
> On an asynchronous swap device MADV_PAGEOUT only marks the folio
> PG_reclaim and rotates it to the tail of the inactive list once its
> writeback completes, so the memory is not actually freed until a later
> reclaim scan removes the by then clean swap cache folio. Mark those
> folios dropbehind at isolation time instead and let folio_end_writeback()
> drop them from the swap cache as each write lands.

Please split out very large paragraphs like this. It's hard to read this.

You aren't giving any justification here you're saying 'X happens so don't do X
any more'.

Why? That should come FIRST.

>
> A dropbehind folio is dropped by whoever completes its writeback, so the

Ugh I really don't love 'dropbehind'. But I guess it's a thing then?

Can you explain what that is? This commit message isn't really teling me much.

> reference the submitter holds has to be released before the write is
> submitted. As reclaim does before freeing a folio, flush the pending TLB
> batch first.

Why do you do that? I don't care if something does something, _why_?

>
> Note that for dropbehind folios nr_reclaimed is now credited when the
> write is submitted rather than when the folio is actually freed, since the
> reclaimer never sees the folio again.

That sounds iffy...

If this is a change that you are actively doing don't say 'note that' as if it's
a fact that can't be avoided.

You are _choosing_ to make a change, justify it then say you did it.

>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
> This applies on top of "[PATCH v6 0/3] mm: zswap: free cold writeback folios
> promptly":
>
> https://lore.kernel.org/linux-mm/20260921151306.625134-1-alex@ghiti.fr/

Hmm, but you're targeting mm-unstable no?

>
>  mm/filemap.c |  7 +++++++
>  mm/madvise.c | 23 ++++++++++++++++++----
>  mm/page_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  mm/swap.h    |  2 ++
>  mm/vmscan.c  | 10 ++++++++++
>  mm/zswap.c   |  9 ++++-----

Why is this a core mm change which also changes madvise but you're changing
zswap too? This feels like it needs to be broken out into commits.

>  6 files changed, 95 insertions(+), 11 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e1f1bbe943ce..14fa96fca8b8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1630,6 +1630,13 @@ void folio_end_dropbehind(struct folio *folio)
>  	if (!folio_test_dropbehind(folio))
>  		return;
>
> +	/*
> +	 * PG_dropbehind could be set on an anonymous folio after
> +	 * folio_end_writeback() samples it (for example MADV_PAGEOUT).
> +	 */

I don't really feel this comment explains why you're exiting here? It's like you
randomly state a fact as a comment.

Something like 'do not end dropbehind for anon because < reason >' no?

> +	if (folio_test_anon(folio))
> +		return;
> +
>  	/*
>  	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
>  	 * but can happen if normal writeback just happens to find dirty folios
> diff --git a/mm/madvise.c b/mm/madvise.c
> index eeee82cf2b3f..63164f95720b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -359,6 +359,17 @@ static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
>  				     FPB_MERGE_YOUNG_DIRTY);
>  }
>
> +static void madvise_mark_dropbehind(struct folio *folio)
> +{
> +	/*
> +	 * A folio already under writeback is skipped: that writeback is not
> +	 * ours to hand over, so reclaim will put the folio back on the LRU
> +	 * while its completion could be dropping it at the same time.
> +	 */
> +	if (folio_test_anon(folio) && !folio_test_writeback(folio))
> +		folio_set_dropbehind(folio);
> +}
> +
>  static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
>  				struct mm_walk *walk)
> @@ -439,10 +450,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			folio_set_workingset(folio);
>  		if (pageout) {
>  			if (folio_isolate_lru(folio)) {
> -				if (folio_test_unevictable(folio))
> +				if (folio_test_unevictable(folio)) {
>  					folio_putback_lru(folio);
> -				else
> +				} else {
> +					madvise_mark_dropbehind(folio);
>  					list_add(&folio->lru, &folio_list);
> +				}
>  			}
>  		} else
>  			folio_deactivate(folio);
> @@ -554,10 +567,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			folio_set_workingset(folio);
>  		if (pageout) {
>  			if (folio_isolate_lru(folio)) {
> -				if (folio_test_unevictable(folio))
> +				if (folio_test_unevictable(folio)) {
>  					folio_putback_lru(folio);
> -				else
> +				} else {
> +					madvise_mark_dropbehind(folio);
>  					list_add(&folio->lru, &folio_list);
> +				}
>  			}

This existing code is utterly horrible can we maybe do some refactoring before
adding yet more functionality here?

I feel like the 'pay down technical debt first' take I had in THP is pretty
valid here also.

But also, yeah you DEFINITELY need to separate out patches here.


>  		} else
>  			folio_deactivate(folio);
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 52eae99de6e3..bf8238768cc9 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -26,9 +26,12 @@
>  #include <linux/delayacct.h>
>  #include <linux/zswap.h>
>  #include <linux/swap_ops.h>
> +#include "internal.h"
>  #include "swap.h"
>  #include "swap_table.h"
>
> +#include <trace/events/vmscan.h>
> +
>  int generic_swapfile_activate(struct swap_info_struct *sis,
>  				struct file *swap_file,
>  				sector_t *span)
> @@ -248,8 +251,19 @@ int swap_writeout(struct swap_io_ctx *ctx, struct folio *folio)
>  	}
>  	rcu_read_unlock();
>
> +	if (folio_test_dropbehind(folio)) {
> +		/*
> +		 * pageout() traces and accounts at its tail, which we can't do
> +		 * because dropbehind folios may already be freed by then.
> +		 */

I'm really confused by this comment.

You're in swap_writeout() but you're talking about pageout() and what they 'may'
be freed by then so you're tracing/accounting in more than one place which
sounds wrong?

This  at least needs to be clarified.

> +		trace_mm_vmscan_write_folio(folio);
> +		lruvec_stat_mod_folio(folio, NR_VMSCAN_WRITE,
> +				      folio_nr_pages(folio));
> +		ret = SWAP_WRITE_DROPBEHIND;

Not sure the comment explains why you're chaging the ret here?

> +	}
> +
>  	__swap_writepage(ctx, folio);
> -	return 0;
> +	return ret;
>  out_unlock:
>  	folio_unlock(folio);
>  	return ret;
> @@ -692,8 +706,45 @@ EXPORT_SYMBOL_GPL(swap_fs_activate);
>
>  void swap_write_submit(struct swap_io_ctx *ctx)
>  {
> -	if (!ctx->sio)
> +	struct swap_iocb *sio = ctx->sio;
> +	bool dropbehind = false;
> +	int p;
> +
> +	if (!sio)
>  		return;
> +
> +	for (p = 0; p < sio->nr_bvecs; p++) {
> +		if (folio_test_dropbehind(bvec_folio(&sio->bvecs[p]))) {
> +			dropbehind = true;
> +			break;
> +		}
> +	}
> +
> +	if (dropbehind) {
> +		/*
> +		 * A dropbehind folio is freed by the completion, not by the
> +		 * reclaimer, and freeing needs every deferred unmap flushed,
> +		 * not just the writable ones try_to_unmap_flush_dirty() covers
> +		 * before the IO.  The reclaimer flushes before it frees, but
> +		 * that is too late for a batch swap_add_folio() already
> +		 * submitted mid-loop.  A no-op once that flush has happened.
> +		 */

please use newlines to separate paragraphs :))

This is really hard to read, it's an LLM-like wall of text.

There's so much going on here.

- A dropbehind folio is freed by completion not by reclaimer

- Freeing needs every deferred unmap to be flushed (not only blah blah)

- Reclaimer flushes before it frees but then it's too late for blah blah

- This is somehow a no-op once a flush has happened.

Reading all that really makes me think that this solution isn't the right one,
instinctively? If you're having to juggle many many delicate things all at once
to justify some code that generally implies your design is wrong or at a wrong
granularity.

> +		try_to_unmap_flush();
> +
> +		/*
> +		 * Now that the TLB is clean, drop the submitter's reference:
> +		 * the swap cache then holds the only ones left, which is what
> +		 * __remove_mapping() expects when the completion drops the
> +		 * folio.  This has to happen before the write is submitted.
> +		 */
> +		for (p = 0; p < sio->nr_bvecs; p++) {
> +			struct folio *folio = bvec_folio(&sio->bvecs[p]);
> +
> +			if (folio_test_dropbehind(folio))
> +				folio_put(folio);
> +		}

Is it ok to iterate through a bvec folio and start fiddling with refrences like
this? What if your put frees the folio, is the bv->bv_page not now a dangling
pointer?

Also the comment for bvec_folio() makes me worry:

 * A bvec can contain non-folio memory, so this should only be called by
 * the creator of the bvec; drivers have no business looking at the owner
 * of the memory.  It may not even be the right interface for the caller
 * to use as a bvec can span multiple folios.  You may be better off using
 * something like bio_for_each_folio_all() which iterates over all folios.

Can each bvec span multiple folios? Why is bio_for_each_folio_all() not right
here?

> +	}
> +
>  	count_vm_events(NRSWPOUT, 1);
>  	ctx->sis->ops->submit_write(ctx);
>  	ctx->sio = NULL;
> diff --git a/mm/swap.h b/mm/swap.h
> index 8679cb61268e..81114ad9e44a 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -92,6 +92,8 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>  	return READ_ONCE(vm_swappiness);
>  }
>
> +#define SWAP_WRITE_DROPBEHIND	1
> +
>  #ifdef CONFIG_SWAP
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a02f942418d3..5435fa5111b3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -613,6 +613,8 @@ typedef enum {
>  	PAGE_SUCCESS,
>  	/* folio is clean and locked */
>  	PAGE_CLEAN,
> +	/* folio will be freed after writeback, do not touch */
> +	PAGE_DROPBEHIND,

Oh god, really? Do we have to add a whole new outcome possibility for CORE
reclaim logic just for this?

Ugh man.

>  } pageout_t;
>
>  /*
> @@ -659,6 +661,9 @@ static pageout_t pageout(struct swap_io_ctx *ctx, struct address_space *mapping,
>  	else
>  		res = swap_writeout(ctx, folio);
>
> +	if (res == SWAP_WRITE_DROPBEHIND)
> +		return PAGE_DROPBEHIND;
> +
>  	if (res < 0)
>  		handle_write_error(mapping, folio, res);
>  	if (res == AOP_WRITEPAGE_ACTIVATE) {
> @@ -1437,6 +1442,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  					nr_pages = 1;
>  				}
>  				goto activate_locked;
> +			case PAGE_DROPBEHIND:
> +				nr_reclaimed += nr_pages;
> +				continue;
>  			case PAGE_SUCCESS:
>  				if (nr_pages > 1 && !folio_test_large(folio)) {
>  					sc->nr_scanned -= (nr_pages - 1);
> @@ -2198,6 +2206,8 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>  	while (!list_empty(folio_list)) {
>  		folio = lru_to_folio(folio_list);
>  		list_del(&folio->lru);
> +		if (folio_test_anon(folio))
> +			folio_clear_dropbehind(folio);
>  		folio_putback_lru(folio);
>  	}
>  	trace_mm_vmscan_reclaim_pages(pgdat->node_id, sc.nr_scanned, nr_reclaimed, &stat);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index dc8425d6b21e..640936fe7464 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1051,17 +1051,16 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	folio_set_dropbehind(folio);
>
>  	/*
> -	 * Drop our reference before starting writeback so the swap cache holds
> -	 * the only one: the drop in folio_end_writeback() needs that for
> -	 * remove_mapping_set_shadow() to succeed, otherwise the folio is
> -	 * handed back to reclaim instead.
> +	 * Our reference is donated to swap_write_submit(), which drops it just
> +	 * before submitting so the swap cache holds the only one left: the drop
> +	 * in folio_end_writeback() needs that for remove_mapping_set_shadow()
> +	 * to succeed, otherwise the folio is handed back to reclaim instead.

This feels really conplicated.

My instinct with this change overall, though I'm not familiar with the
dropbehind code, is that thi

>  	 *
>  	 * Nothing can free the folio in the meantime: we hold the folio lock
>  	 * until writeback starts, PG_writeback then blocks swap cache removal,
>  	 * and folio_end_writeback() takes its own reference before clearing
>  	 * PG_writeback and donates it to the drop.
>  	 */

This comment is now a comment on...? Nothing?

> -	folio_put(folio);
>
>  	/* start writeback */
>  	__swap_writepage(&ctx, folio);
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
