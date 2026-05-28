Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18163F99E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987423; cv=none; b=B5i1NRkRxDaXDjX8mqq/B2PlRx56T4zyKgoFeJLx26ZI5ynU5znyyZ/X0jdKMkTFQrqoe8BEhkrL4YXxIWqd/prS2PV3EKaUVXq3KrcbcyVBFfSBiG+4kWEzhmP71xLDdkOIzukjoYNhWxy74W5n3D3bI4chIJyu1FrDbft8FW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987423; c=relaxed/simple;
	bh=nchSZcWiZNsD+EJPHIFlg8AoNpxuco8BrZvdYOqELYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOCEV+/TRQlhyJEQDsZYb6w2OKUi69vpx6uvPeZxsHOFKj+pYIJ6bOExBcEZm+zm3cSD9NlbV1DiMTipbA5bPQUCILsnQ0GWm3MLkH/l807R+iY6gWcJY+7cu6KhHZVkd+0UYj9y0TqHCtFlicuCGV8ujerFV6rDH91es2VkaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BZZc/ms8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BZZc/ms8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779987419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPlFnYwCWz7+rdxCNeqNN0vuzrC3LBz56c9GLgbIR0Y=;
	b=BZZc/ms8dlyybEyEd97Qc3TtKn6BE7b3CTiqFTmXtlHzcU6PuSRN1DFtW97UC0epSY2v62
	F/XbJ1L0eo71OfYpoHTrPzv+yekeKLqrRmKFVwJyvhS9Fw1HV/CiygSLi8uiixVbvT++py
	UNXt8ater3KcJQTVMfd4V8UF9Q+Yv6c=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam R. Howlett <liam@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
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
Subject: [PATCH v6 2/2] mm: use mapping_max_folio_order() for force_thp_readahead order
Date: Thu, 28 May 2026 09:55:20 -0700
Message-ID: <20260528165635.2068012-3-usama.arif@linux.dev>
In-Reply-To: <20260528165635.2068012-1-usama.arif@linux.dev>
References: <20260528165635.2068012-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The force_thp_readahead path in do_sync_mmap_readahead() is gated on
HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always requests
HPAGE_PMD_ORDER / HPAGE_PMD_NR. On configurations where HPAGE_PMD_ORDER
exceeds MAX_PAGECACHE_ORDER, notably arm64 with a 64K base page size,
VM_HUGEPAGE mappings cannot use this path and fall back to the non-forced
mmap readahead path even when the mapping supports useful large folios.

Keep the existing PMD-sized behavior when HPAGE_PMD_ORDER fits in the
page cache. When it does not, enable forced readahead for mappings that
support large folios and request an order capped by both
mapping_max_folio_order(mapping) and 2MB.

2MB is chosen as the cap because it matches the PMD size on x86_64
and on arm64 with 4K or 16K base pages, so the size/memory-pressure
tradeoff for folios of that size is already well understood. On arm64
with a 64K base page size, 2MB is also the contiguous-PTE (contpte)
block size, so the resulting folios coalesce into a single TLB entry
and reduce TLB pressure on the readahead path.

The final allocation order may still be clamped by page_cache_ra_order()
to the mapping and request geometry, but this gives VM_HUGEPAGE mappings
on such configurations a large-folio readahead request instead of
dropping back to base-page readahead.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/filemap.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a16b33e0fc71..bfb891d9da1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3312,14 +3312,23 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	vm_flags_t vm_flags = vmf->vma->vm_flags;
 	bool force_thp_readahead = false;
+	unsigned int thp_order = 0;
 	unsigned short mmap_miss;
 
 	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
 
 	/* Use the readahead code, even if readahead is disabled */
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
-		force_thp_readahead = true;
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
+		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
+			force_thp_readahead = true;
+			thp_order = HPAGE_PMD_ORDER;
+		} else if (mapping_large_folio_support(mapping)) {
+			force_thp_readahead = true;
+			thp_order = min_t(unsigned int,
+					  mapping_max_folio_order(mapping),
+					  get_order(SZ_2M));
+		}
+	}
 
 	if (!force_thp_readahead) {
 		/*
@@ -3354,17 +3363,19 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 
 	if (force_thp_readahead) {
+		unsigned long folio_nr_pages = 1UL << thp_order;
+
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
-		ra->size = HPAGE_PMD_NR;
+		ractl._index &= ~(folio_nr_pages - 1);
+		ra->size = folio_nr_pages;
 		/*
-		 * Fetch two PMD folios, so we get the chance to actually
+		 * Fetch two folios so we get the chance to actually
 		 * readahead, unless we've been told not to.
 		 */
 		if (!(vm_flags & VM_RAND_READ))
 			ra->size *= 2;
-		ra->async_size = HPAGE_PMD_NR;
-		ra->order = HPAGE_PMD_ORDER;
+		ra->async_size = folio_nr_pages;
+		ra->order = thp_order;
 		page_cache_ra_order(&ractl, ra);
 		return fpin;
 	}
-- 
2.52.0

