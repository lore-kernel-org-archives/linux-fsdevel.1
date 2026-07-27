Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A353C3F69
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183539; cv=none; b=Yii4FsYxolZPP2BsfqMQ68GIKjCKQcJopz1v80ykSs6b2iZYkz0BZd8MIyE6x0WuivkNrFhH8b+oTSf/xBAUtRI0uv68SFT9cr6zHulYPnCxQhUNE4U3/Y/c9Y/E1wwQs8Ol6yiSrrfcQ73ntofpMP0OOaTZP0UlwgN8/glyHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183539; c=relaxed/simple;
	bh=bUiiuA6UETfPG91rQpZ4R4TI4mYJbQK83QG3buA9QBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ7eK/fMUWhR9weFMfSLgsEVNaEJKcVbMnMtW7FriJ0YJyhkXnQpO2inKgra6S6lvTtLJOrwN8/dbqa7b4FQzTr93/+QEsDHsGFanj+MxSPOScNDCzIv1D8hurKw5GcRi9FgtI+MXmVOImkNvk7Xn3/u2BGs2bkRwkjp7Adhj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gTrwE1rb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gTrwE1rb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ygkPJzP4i7m3xhcGa5HIHO57if4jnfOhcamPKPfP9O8=; b=gTrwE1rbXxCizQa00mpnkHjx80
	K+e568OeDJYyEjo0oyXnc3QcqY1Mm5XSGg+SKFj+w6Yt3bSWGMUvN1JhXnZhMa6m8oBJ2PIiT0Ti/
	/xtPdRB+s37Mepcu1fdnbIwedCsQ3WlRDvxvVAr0IU+clMlh75Ut+BwtEEYBfqjmCdxWKQoF1nYik
	RmlAvEdECEzWxYbL1DcKrfXOH47GCwKOh1MdPyamERizTcUgleHlqWp5yVSa8k3X2ynJeAzeQIIDh
	OZA3/8/kDOxNX/j0TFWKP7ODgMuWYL89iClfQkOukgA2kuLhwHkYQ+gdBhtNZlFzQ/LxXiH8177vQ
	xk0uXi+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRmf-0000000BO6a-12t3;
	Mon, 27 Jul 2026 20:18:45 +0000
Date: Mon, 27 Jul 2026 21:18:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v6 07/12] mm: Check individual hugetlb pages for poison
Message-ID: <ame9JVkltJCmSeu-@casper.infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-8-willy@infradead.org>

Sashiko:
> --- Patch [7]: [PATCH v6 07/12] mm: Check individual hugetlb pages for poison ---
> commit 576226d7d814aff0cfed4be691d0ccb82f1eb5c9
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> mm: Check individual hugetlb pages for poison
> 
> This commit modifies is_page_hwpoison() to check individual hugetlb pages
> for poison rather than returning true for the entire folio. It introduces
> hugetlb_unref_page_hwpoison() to safely evaluate the poison state using
> the hugetlb lock when the folio reference isn't held.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index e358f6a33d274..6ca7e1df7f735 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> 
> [ ... ]
> 
> > +/*
> > + * We have no reference on the folio containing this page.
> > + * The hugetlb_lock keeps hugetlb folios from being freed.
> > + */
> > +bool hugetlb_unref_page_hwpoison(const struct page *page)
> > +{
> > +	const struct folio *folio;
> > +	unsigned long flags;
> > +	bool ret;
> > +
> > +	spin_lock_irqsave(&hugetlb_lock, flags);
> > +	folio = page_folio(page);
> > +	if (!folio_test_huge_poison(folio)) {
> > +		ret = PageHWPoison(page);
> 
> This is a pre-existing issue, but does this create a TOCTOU race window with
> __update_and_free_hugetlb_folio()?
> 
> If a thread frees a poisoned hugetlb folio, it clears the PGTY_hugetlb type
> in __update_and_free_hugetlb_folio() under hugetlb_lock. After the lock is
> dropped, if another thread calls is_page_hwpoison(), it will evaluate
> folio_test_huge_poison() as false here and check PageHWPoison(page).
> 
> Since the freeing thread may not have reached folio_clear_hugetlb_hwpoison()
> to set PageHWPoison() yet, could this return false and cause an unprivileged
> or privileged PFN walker (like reading /proc/kcore) to access the page and
> trigger a Machine Check Exception?

Ohh ... Yes, look at that.

__update_and_free_hugetlb_folio() does:

        if (folio_test_hugetlb(folio)) {
                spin_lock_irq(&hugetlb_lock);
                __folio_clear_hugetlb(folio);
                spin_unlock_irq(&hugetlb_lock);
        }

        /*
         * Move HWPoison flag to each error page
         * which makes any healthy pages reusable.
         */
        if (unlikely(folio_test_has_hwpoisoned(folio)))
                folio_clear_hugetlb_hwpoison(folio);

We need to re-order these two.  I don't think we need to call
folio_clear_hugetlb_hwpoison() under the hugetlb_lock; I think the
ordering is sufficient.

Oh, I just found 5596d9e8b553.  These used to be in the other order.
Gah.  This is all horribly racy because memory-failure tries to do so
much without stabilising anything by getting a reference on the folio.

Fine, the easiest way to fix this is to put everything under the hugetlb
lock.

Also, why do we call folio_test_hugetlb()?  Obviously this is a hugetlb
folio.  Look at everything else we've done in this function.  It
made a certain amount of sense when it was introduced:

-       if (clear_dtor) {
+       if (folio_test_hugetlb(folio)) {
                spin_lock_irq(&hugetlb_lock);
                __clear_hugetlb_destructor(h, folio);
                spin_unlock_irq(&hugetlb_lock);

but now it just looks weird to me.

Oh.  Because we can clear hugetlb in remove_hugetlb_folio() unless
the hugetlb folio is HVO?  And ... similarly in other places.

OK.  So before we clear the hugetlb flag _anywhere_, we need to move the
hwpoison flag to the precise pages.  So let's do a helper function?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a557f7fa61a4..5be981064a26 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1370,6 +1370,26 @@ static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask, int
 }
 #endif
 
+static void folio_try_clear_hugetlb(struct folio *folio)
+{
+	/*
+	 * We can only clear the hugetlb flag after allocating vmemmap
+	 * pages.  Otherwise, someone (memory error handling) may try to write
+	 * to tail struct pages.
+	 */
+	if (folio_test_hugetlb_vmemmap_optimized(folio))
+		return;
+
+	/*
+	 * Move HWPoison flag to each error page
+	 * which makes any healthy pages reusable.
+	 */
+	if (unlikely(folio_test_has_hwpoisoned(folio)))
+		folio_clear_hugetlb_hwpoison(folio);
+
+	__folio_clear_hugetlb(folio);
+}
+
 /*
  * Remove hugetlb folio from lists.
  * If vmemmap exists for the folio, clear the hugetlb flag so that the
@@ -1402,13 +1422,7 @@ void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 		h->surplus_huge_pages_node[nid]--;
 	}
 
-	/*
-	 * We can only clear the hugetlb flag after allocating vmemmap
-	 * pages.  Otherwise, someone (memory error handling) may try to write
-	 * to tail struct pages.
-	 */
-	if (!folio_test_hugetlb_vmemmap_optimized(folio))
-		__folio_clear_hugetlb(folio);
+	folio_try_clear_hugetlb(folio);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1482,17 +1496,10 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	 */
 	if (folio_test_hugetlb(folio)) {
 		spin_lock_irq(&hugetlb_lock);
-		__folio_clear_hugetlb(folio);
+		folio_try_clear_hugetlb(folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Move HWPoison flag to each error page
-	 * which makes any healthy pages reusable.
-	 */
-	if (unlikely(folio_test_has_hwpoisoned(folio)))
-		folio_clear_hugetlb_hwpoison(folio);
-
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 	if (folio_test_hugetlb_cma(folio))
 		hugetlb_cma_free_frozen_folio(folio);
@@ -1584,7 +1591,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
 			list_del(&folio->lru);
 			spin_lock_irq(&hugetlb_lock);
-			__folio_clear_hugetlb(folio);
+			folio_try_clear_hugetlb(folio);
 			spin_unlock_irq(&hugetlb_lock);
 			update_and_free_hugetlb_folio(h, folio, false);
 			cond_resched();
@@ -1609,7 +1616,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 			} else {
 				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
-				__folio_clear_hugetlb(folio);
+				folio_try_clear_hugetlb(folio);
 				spin_unlock_irq(&hugetlb_lock);
 				update_and_free_hugetlb_folio(h, folio, false);
 				cond_resched();
@@ -1642,14 +1649,14 @@ static void update_and_free_pages_bulk(struct hstate *h,
 	 * should only be pages on the non_hvo_folios list.
 	 * Do note that the non_hvo_folios list could be empty.
 	 * Without HVO enabled, ret will be 0 and there is no need to call
-	 * __folio_clear_hugetlb as this was done previously.
+	 * folio_try_clear_hugetlb as this was done previously.
 	 */
 	VM_WARN_ON(!list_empty(folio_list));
 	VM_WARN_ON(ret < 0);
 	if (!list_empty(&non_hvo_folios) && ret) {
 		spin_lock_irq(&hugetlb_lock);
 		list_for_each_entry(folio, &non_hvo_folios, lru)
-			__folio_clear_hugetlb(folio);
+			folio_try_clear_hugetlb(folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 

