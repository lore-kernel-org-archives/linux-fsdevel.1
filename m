Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4C3BFE4A;
	Fri, 20 Mar 2026 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015467; cv=none; b=uodTIQRsIQFrET9LplCirotZK1hPfMfzLAydEK0pKDvZE05F3WaKF2+56OOa0IRbbX4KMwYeGzhWpqrrgDo+Kme2lBUubyI+lJSl7NPk2SzL/d9pbhK9PLlEQugLO4xKvWLmusblUWAigy0hpy/pZoPqfSjVaWeUp8HaDU+Slk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015467; c=relaxed/simple;
	bh=zJW6u6w2T7/WkKf6iH6BDYARJyZtDKZlGSLJhCRgkgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uniCrUb8YrDbBYHy0kKDmY7ysJYJPcXivPRpbXXyHNsPVbxYkP2ZjWj18u3pgAk4mlOooRj7usIoY+wpGbvPzUIWV86viDl1fK64zkWxJyejNyBpI0dPv1un1mrZVaY8QnmaWZWYyyjiXCb1wT5lhD4DodbAvoGkqcg0eMw9oNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UOWwV1ei; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UOWwV1ei"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774015460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bg+wTZEkY0kf0sA92ZnNvjbIS/cxmxsK6VabysMssIw=;
	b=UOWwV1ei1um1cuOFC9PdOQCvRRLKsVBN4K0Ll1G8u2AVglJDCgxKqLhFOdXHOVaxlsfvfZ
	7yNSwQJxSAd46q8NMvEGhxVLXcyla5Qs6T9q5288IU3yu0rFmAUpUzUZ9/qPY06VuZr8Za
	Rq2NH7wcPPgexNLEtLLO0lKQF2r8pig=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	ajd@linux.ibm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	wilts.infradead.org,
	linux-fsdevel@vger.kernel.l@kernel.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v2 2/4] mm: replace exec_folio_order() with generic preferred_exec_order()
Date: Fri, 20 Mar 2026 06:58:52 -0700
Message-ID: <20260320140315.979307-3-usama.arif@linux.dev>
In-Reply-To: <20260320140315.979307-1-usama.arif@linux.dev>
References: <20260320140315.979307-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the arch-specific exec_folio_order() hook with a generic
preferred_exec_order() that dynamically computes the readahead folio
order for executable memory. It targets min(PMD_ORDER, 2M) as the
maximum, which optimally gives the right answer for contpte (arm64),
PMD mapping (x86, arm64 4K), and architectures with smaller PMDs
(s390 1M). It adapts at runtime based on:

- VMA size: caps the order so folios fit within the mapping
- Memory pressure: steps down the order when the local node's free
  memory is below the high watermark for the requested order

This avoids over-allocating on memory-constrained systems while still
requesting the optimal order when memory is plentiful.

Since exec_folio_order() is no longer needed, remove the arm64
definition and the generic default from pgtable.h.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/arm64/include/asm/pgtable.h |  8 -----
 include/linux/pgtable.h          | 11 ------
 mm/filemap.c                     | 57 ++++++++++++++++++++++++++++----
 3 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b3e58735c49bd..b1e74940624d8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1599,14 +1599,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
  */
 #define arch_wants_old_prefaulted_pte	cpu_has_hw_af
 
-/*
- * Request exec memory is read into pagecache in at least 64K folios. This size
- * can be contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB
- * entry), and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base
- * pages are in use.
- */
-#define exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
-
 static inline bool pud_sect_supported(void)
 {
 	return PAGE_SIZE == SZ_4K;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a50df42a893fb..874333549eb3c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -577,17 +577,6 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif
 
-#ifndef exec_folio_order
-/*
- * Returns preferred minimum folio order for executable file-backed memory. Must
- * be in range [0, PMD_ORDER). Default to order-0.
- */
-static inline unsigned int exec_folio_order(void)
-{
-	return 0;
-}
-#endif
-
 #ifndef arch_check_zapped_pte
 static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
 					 pte_t pte)
diff --git a/mm/filemap.c b/mm/filemap.c
index 7d89c6b384cc4..aebfb78e487d7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3290,6 +3290,52 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 	return 1;
 }
 
+/*
+ * Compute the preferred folio order for executable memory readahead.
+ * Targets min(PMD_ORDER, 2M) as the maximum, which gives the
+ * optimal order for contpte (arm64), PMD mapping (x86, arm64 4K), and
+ * architectures with smaller PMDs (s390 1M). The 2M cap also avoids
+ * requesting excessively large folios on configurations where PMD_ORDER
+ * is much larger (32M on 16K pages, 512M on 64K pages), which would cause
+ * unnecessary memory pressure. Adapts at runtime based on:
+ *
+ * - VMA size: cap the order so folios fit within the mapping.
+ *
+ * - Memory pressure: step down the order when free memory on the local
+ *   node is below the high watermark for the requested order. This
+ *   avoids expensive reclaim or compaction to satisfy large folio
+ *   allocations when memory is tight.
+ */
+static unsigned int preferred_exec_order(struct vm_area_struct *vma)
+{
+	int order;
+	unsigned long vma_len = vma_pages(vma);
+	struct zone *zone;
+	gfp_t gfp;
+
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+
+	/* Cap at min(PMD_ORDER, 2M) */
+	order = min(HPAGE_PMD_ORDER, ilog2(SZ_2M >> PAGE_SHIFT));
+
+	/* Don't request folios larger than the VMA */
+	order = min(order, ilog2(vma_len));
+
+	/* Step down under memory pressure */
+	gfp = mapping_gfp_mask(vma->vm_file->f_mapping);
+	zone = first_zones_zonelist(node_zonelist(numa_node_id(), gfp),
+				    gfp_zone(gfp), NULL)->zone;
+	if (zone) {
+		while (order > 0 &&
+		       !zone_watermark_ok(zone, order,
+					  high_wmark_pages(zone), 0, 0))
+			order--;
+	}
+
+	return order;
+}
+
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
@@ -3363,11 +3409,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (vm_flags & VM_EXEC) {
 		/*
-		 * Allow arch to request a preferred minimum folio order for
-		 * executable memory. This can often be beneficial to
-		 * performance if (e.g.) arm64 can contpte-map the folio.
-		 * Executable memory rarely benefits from readahead, due to its
-		 * random access nature, so set async_size to 0.
+		 * Request a preferred folio order for executable memory,
+		 * dynamically adapted to VMA size and memory pressure.
+		 * Executable memory rarely benefits from speculative readahead
+		 * due to its random access nature, so set async_size to 0.
 		 *
 		 * Limit to the boundaries of the VMA to avoid reading in any
 		 * pad that might exist between sections, which would be a waste
@@ -3378,7 +3423,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		unsigned long end = start + vma_pages(vma);
 		unsigned long ra_end;
 
-		ra->order = exec_folio_order();
+		ra->order = preferred_exec_order(vma);
 		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
 		ra->start = max(ra->start, start);
 		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
-- 
2.52.0

