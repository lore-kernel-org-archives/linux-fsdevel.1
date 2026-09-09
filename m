Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555E48E0C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947624; cv=none; b=hsT4SmW98HqeaDDvhKwpJsxTdw/P9ydOrVVnUzf+zXIUsAR+YWjKUZno2e/p1CLHJvGP9/KmmwFQneFS8tm1mS2Xi/5+PbxParOUXabuHSSP2LXz77ECX7NrbuoXu01Xx9jBs0DWhOWQ1qt4fydNQHzxjSnbtc1YManh3g2itrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947624; c=relaxed/simple;
	bh=FCbXp+9OF7RbrCuYxplGLnxtBxnCcxr/co7K/0ctoAQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G8emnabwHrm/YxgYoFK22UcnrxTvLK/9f/OyY55Ms+rwRuDh8yPkHYSfsGvGF0zq08ITX34t1LBgkPvw7J0C/AwUhTRKf6mZ/6Otxl2kTGvJPRpPrpmmnjaP+OYmXwja5vOPf0TLxFvqNjT22JIwh3YMigAEesxZ1K+uLNgKEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qV9pWXKk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qV9pWXKk"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso8573557b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947621; x=1789552421; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=klQabvPBSdHuFjYsQkDymGQq+sX0bqmcbAmBz8NKUgY=;
        b=qV9pWXKkkeoTOXcXrYSq6yrRF8zv3vV2DI+LJbqHMJrJEGV85gkZLMnIq6H9adxO8y
         px9Hf+Dzfh4pWk3cz9od2dc62JaPQhNr4UVagmyeDxFQJWDAH4MksRDnUzjCS0MDr4jK
         p5adWM6NvBq2+t5pz/JoQYzU43xWc0QHoL40EJV9fmY1GiCoig/hEUvNpb/MPVffe1eM
         xnL3U6fylG9yDPb6wLum6luwnE4gN0InBn1BP8d97Y/1wvYAgPk4z7Ek1smcWUZhC2Pv
         dHZZqjmY50HqCB6ZtT+sf/uPsI5MEehdBg/PzNYAuGDVZHJy+hUUxHPtgXDVeMxCpRCx
         uM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947621; x=1789552421;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=klQabvPBSdHuFjYsQkDymGQq+sX0bqmcbAmBz8NKUgY=;
        b=QV0c1B5WkYDoxvcOQW92geLSDLY/uzM4i+W+CpDdC6wa4IRZSgRI3ojtBJSCznHq+t
         kDmZ2j/f3m4wNo0EMLHClyJTUsoL3zHOxJ4vTjoXnbfmzzVc+uptlQVSnwyAKfzGJIJu
         A8zTvtJN2iiQcGBynDvVQ+WJYHSSYUSs1roa7824BfQdWxX/1KJ89W6o424z9TgoHfFS
         a6WjmhU7FIngllr5aNpiGeXoZHW+Wt2EO/g/TUsIQLswgjUPl3cvKQNNWMegAA89d1Y6
         pxMqnq59RxHMgjdYApWDn5CfVi4UUabHKnA+F4midVnjgtoVbWnNvq4wBAoG2cPgqdPs
         QOkg==
X-Forwarded-Encrypted: i=1; AKwUvBxTgkwMH5pJO9OEcK/iF9g7ULWREboW9qjTTUOShJUieG8+jGV31UraIQzL+Afu8OMgeqcPmz1Eoz3LIQTp@vger.kernel.org
X-Gm-Message-State: AFuF++nLrSTfsx2SJLREIWp5nTbqekm08mszjw1kxVd17BWzalmTZolV
	384+NimIoY4g+zeiHJst169jCqeMiiwUbsaiG9PNsQW7ZwvulmafQDAAhfsVaoGw7Q==
X-Gm-Gg: AYBFou03nXUEeiOczAy0Qe3bJrTSm3n1gFHMKwa+S+spOsrUh5MgcbcC+o6KojYBy+U
	m7NjcG8iHdjb2B40i0nZB99MvyAmOudVIdfFu0BHSycVeXHm3ye21JEwzXeOMj24GDdyt2+psd3
	SxiOTG+07nRAL+nmsl/XwbItg0rbJal7AsWSjFRAN6aeY5apXtlCoe7SAyQ9DSENSEx7fQIH+KS
	IqlSeapP8HqWcMBQZvtzT0kz0+nZzezfmIRJHdAPcE5k0QEF3yQ3k5595G6Z0QNSXcCEmIJn6YU
	qwSgnqUTMmnBq8ENOy7u9X+50Tzq5JYpIqFzBa6s9N1bPWh1f77DsN2P6UOpb9cIEe59iszS1jv
	uE8SqttnmOm25hjRjtsL1vbn/y8891cZbpG9+0HLDCMxONJ245xpY1oGYMS3yV4Vw5FOf4Aofn6
	H1bPSecE47rXKFQLCW5n8Ri7mayifGTERFNJqjrYZjSXSP1kgfLi7PNq2edf9C32UYMr5Yw3ryq
	AFIu3iUBs0Ckqlr4/f9V8rG4i7ci8x7mjcPW6DotHQZAz/OOHzG02SzlIY=
X-Received: by 2002:a05:690c:c0b:b0:81e:1b3c:9e4 with SMTP id 00721157ae682-87f23fe8f10mr27261477b3.14.1788947620263;
        Wed, 09 Sep 2026 02:53:40 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm108292997b3.38.2026.09.09.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:53:39 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:53:35 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 06/26] mm/fbatch: fbatch_drain_lazyfree(onstack fbatch)
 before ptl unlock
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <17e1a6c3-525b-1cc3-0731-349f0850e3ea@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Re-enable lazyfree batching for MADV_FREE. But it's not safe now to leave
potentially stale (then reused) folios in a per-cpu fbatch for lazyfree.
Instead, madvise_free_pte_range() keep an fbatch on its stack, and drain
it each time before dropping pagetable lock, while the folios are secure.

Ignore folio_may_be_lru_cached() and lru_cache_disabled(): limitations
irrelevant to this fbatch drained under spinlock (even if RT); though
in practice madvise_free_huge_pmd() does have to drain every time.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/huge_mm.h |  6 ++++--
 mm/folio.c              | 34 +++++++++++++++++++++-------------
 mm/huge_memory.c        |  6 ++++--
 mm/internal.h           |  3 ++-
 mm/madvise.c            |  9 +++++++--
 5 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c745f7ad2298..d50906327d1d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -24,9 +24,11 @@ static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif
 
-vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
+struct folio_batch;
 bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			   pmd_t *pmd, unsigned long addr, unsigned long next);
+			   pmd_t *pmd, unsigned long addr, unsigned long next,
+			   struct folio_batch *fbatch);
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
 bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma, pmd_t *pmd,
 		  unsigned long addr);
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma, pud_t *pud,
diff --git a/mm/folio.c b/mm/folio.c
index e743cd539b9e..a18d8ef6afd5 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -51,7 +51,6 @@ struct cpu_fbatches {
 	struct folio_batch lru_activate;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
-	struct folio_batch lru_lazyfree;
 	/* Protecting the following batches which require disabling interrupts */
 	local_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
@@ -194,8 +193,6 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
-			/* XXX Temporarily disable lazyfree batching */
-			fbatch == &cpu_fbatches.lru_lazyfree ||
 			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
@@ -585,10 +582,6 @@ void lru_add_drain_cpu(int cpu)
 	fbatch = &fbatches->lru_deactivate;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_deactivate);
-
-	fbatch = &fbatches->lru_lazyfree;
-	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_lazyfree);
 }
 
 /**
@@ -634,19 +627,35 @@ void folio_deactivate(struct folio *folio)
 
 /**
  * folio_mark_lazyfree - make an anon folio lazyfree
- * @folio: folio to deactivate
+ * @fbatch: batch to which folio will be added
+ * @folio: folio to be lazily freed
  *
- * folio_mark_lazyfree() moves @folio to the inactive file list.
- * This is done to accelerate the reclaim of @folio.
+ * folio_mark_lazyfree() moves @folio to the inactive file list
+ * via @fbatch. This is done to accelerate the reclaim of @folio.
  */
-void folio_mark_lazyfree(struct folio *folio)
+void folio_mark_lazyfree(struct folio_batch *fbatch, struct folio *folio)
 {
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
 	    !folio_test_lru(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_lazyfree);
+	if (!folio_batch_add(fbatch, folio))
+		folio_batch_move_lru(fbatch, lru_lazyfree);
+}
+
+/**
+ * fbatch_drain_lazyfree - drain the caller's folio batch
+ * @fbatch: batch of folios to be lazily freed
+ *
+ * Must be called before caller drops the page table lock: that is,
+ * before dropping the last certain reference to the folios in @fbatch.
+ * It would be very bad to lazyfree a folio after it was freed and reused.
+ */
+void fbatch_drain_lazyfree(struct folio_batch *fbatch)
+{
+	if (folio_batch_count(fbatch))
+		folio_batch_move_lru(fbatch, lru_lazyfree);
 }
 
 void lru_add_drain(void)
@@ -700,7 +709,6 @@ static bool cpu_needs_drain(unsigned int cpu)
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
-			 folio_batch_count(&fbatches->lru_lazyfree) ||
 			 need_mlock_drain(cpu)) ||
 		has_bh_in_lru(cpu, NULL);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7510d875433..abebd8a23e56 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2356,7 +2356,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
  * Otherwise, return false.
  */
 bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		pmd_t *pmd, unsigned long addr, unsigned long next)
+		pmd_t *pmd, unsigned long addr, unsigned long next,
+		struct folio_batch *fbatch)
 {
 	spinlock_t *ptl;
 	pmd_t orig_pmd;
@@ -2417,7 +2418,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	}
 
-	folio_mark_lazyfree(folio);
+	folio_mark_lazyfree(fbatch, folio);
+	fbatch_drain_lazyfree(fbatch);
 	ret = true;
 out:
 	spin_unlock(ptl);
diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..0d78406eb126 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -63,7 +63,8 @@ void lru_add_drain(void);
 void lru_add_drain_cpu(int cpu);
 void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
-void folio_mark_lazyfree(struct folio *folio);
+void folio_mark_lazyfree(struct folio_batch *fbatch, struct folio *folio);
+void fbatch_drain_lazyfree(struct folio_batch *fbatch);
 
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/madvise.c b/mm/madvise.c
index eeee82cf2b3f..b2eab519af19 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -27,6 +27,7 @@
 #include <linux/file.h>
 #include <linux/blk_plug.h>
 #include <linux/backing-dev.h>
+#include <linux/folio_batch.h>
 #include <linux/pagewalk.h>
 #include <linux/swap.h>
 #include <linux/leafops.h>
@@ -666,6 +667,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct mmu_gather *tlb = walk->private;
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
+	struct folio_batch fbatch;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
 	struct folio *folio;
@@ -673,9 +675,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long next;
 	int nr, max_nr;
 
+	folio_batch_init(&fbatch);
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
-		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
+		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next, &fbatch))
 			return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
@@ -733,6 +736,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 					continue;
 				folio_get(folio);
 				lazy_mmu_mode_disable();
+				fbatch_drain_lazyfree(&fbatch);
 				pte_unmap_unlock(start_pte, ptl);
 				start_pte = NULL;
 				err = split_folio(folio);
@@ -777,13 +781,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			clear_young_dirty_ptes(vma, addr, pte, nr, cydp_flags);
 			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
-		folio_mark_lazyfree(folio);
+		folio_mark_lazyfree(&fbatch, folio);
 	}
 
 	if (nr_swap)
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	if (start_pte) {
 		lazy_mmu_mode_disable();
+		fbatch_drain_lazyfree(&fbatch);
 		pte_unmap_unlock(start_pte, ptl);
 	}
 	cond_resched();
-- 
2.51.0

