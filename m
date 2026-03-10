Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D03043CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154489; cv=none; b=aBaJKytF0a492ObQty4h9rcAKxIeQbTnqzuxFrxVDpBiVXU6vmSIKof1lQhvOpXx0jVJZogxId9nmIIm03Rv+OMfAGegZddTflZ02hkhtAkWMEGmckM+h+XfF98nvhne68HDt+6tAddayaVDOCLhl58vUM9foKSjwYhIZh5WGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154489; c=relaxed/simple;
	bh=4laApc8NnGxTpddKFozyyVwqGUlAQh5OJ1FeFhbLxZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvfFeC24EIXQCYlnmmwmemBaSETqFABI+QQ6Aes3Gewclv5vh+Ke7XS3+WNXrSYB2e0xQo7Uunlrqp152GGJ/4x+gzj8CAV7zWfkdLLKJVQ2z5jPn0z5q05fPCJ9HSa8ZCqVxlW68HM+wMTa/Hwno1Uc+6vkiFbGwo+pwKjm7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LmrODPSV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LmrODPSV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGK3lb1Gl4HCpee4Gph+9eiHmaXQeXqY6khXIDpX7y0=;
	b=LmrODPSVrXpm2EmXagV1g0RUXMxioQTzpSwL5eNBUJ9rkDCjz6bNRfo8KV+CqZRbnHjE68
	I8WEXf5qsZGH5CDbqxlCSz2yMBlvWrR6/6lzTS3KHT+IOo4Pw70p5ooXE//x8R2klmN4qF
	c7PhpqQjMaabhHUGcyJnaSnjqP8H69o=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	ryan.roberts@arm.com,
	david@kernel.org
Cc: ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	rmclure@linux.ibm.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 2/4] mm: bypass mmap_miss heuristic for VM_EXEC readahead
Date: Tue, 10 Mar 2026 07:51:15 -0700
Message-ID: <20260310145406.3073394-3-usama.arif@linux.dev>
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
References: <20260310145406.3073394-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The mmap_miss counter in do_sync_mmap_readahead() tracks whether
readahead is useful for mmap'd file access. It is incremented by 1 on
every page cache miss in do_sync_mmap_readahead(), and decremented in
two places:

  - filemap_map_pages(): decremented by N for each of N pages
    successfully mapped via fault-around (pages found already in cache,
    evidence readahead was useful). Only pages not in the workingset
    count as hits.

  - do_async_mmap_readahead(): decremented by 1 when a page with
    PG_readahead is found in cache.

When the counter exceeds MMAP_LOTSAMISS (100), all readahead is
disabled, including the targeted VM_EXEC readahead [1] that requests
arch-preferred folio orders for contpte mapping.

On arm64 with 64K base pages, both decrement paths are inactive:

  1. filemap_map_pages() is never called because fault_around_pages
     (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
     requires fault_around_pages > 1. With only 1 page in the
     fault-around window, there is nothing "around" to map.

  2. do_async_mmap_readahead() never fires for exec mappings because
     exec readahead sets async_size = 0, so no PG_readahead markers
     are placed.

With no decrements, mmap_miss monotonically increases past
MMAP_LOTSAMISS after 100 page faults, disabling all subsequent
exec readahead.

Fix this by moving the VM_EXEC readahead block above the mmap_miss
check. The exec readahead path is targeted. It reads a single folio at
the fault location with async_size=0, not speculative prefetch, so the
mmap_miss heuristic designed to throttle wasteful speculative readahead
should not gate it. The page would need to be faulted in regardless,
the only question is at what order.

[1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/filemap.c | 72 ++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6cd7974d4adab..c064f31ecec5a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3331,6 +3331,37 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		}
 	}
 
+	if (vm_flags & VM_EXEC) {
+		/*
+		 * Allow arch to request a preferred minimum folio order for
+		 * executable memory. This can often be beneficial to
+		 * performance if (e.g.) arm64 can contpte-map the folio.
+		 * Executable memory rarely benefits from readahead, due to its
+		 * random access nature, so set async_size to 0.
+		 *
+		 * Limit to the boundaries of the VMA to avoid reading in any
+		 * pad that might exist between sections, which would be a waste
+		 * of memory.
+		 *
+		 * This is targeted readahead (one folio at the fault location),
+		 * not speculative prefetch, so bypass the mmap_miss heuristic
+		 * which would otherwise disable it after MMAP_LOTSAMISS faults.
+		 */
+		struct vm_area_struct *vma = vmf->vma;
+		unsigned long start = vma->vm_pgoff;
+		unsigned long end = start + vma_pages(vma);
+		unsigned long ra_end;
+
+		ra->order = exec_folio_order();
+		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
+		ra->start = max(ra->start, start);
+		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
+		ra_end = min(ra_end, end);
+		ra->size = ra_end - ra->start;
+		ra->async_size = 0;
+		goto do_readahead;
+	}
+
 	if (!(vm_flags & VM_SEQ_READ)) {
 		/* Avoid banging the cache line if not needed */
 		mmap_miss = READ_ONCE(ra->mmap_miss);
@@ -3361,40 +3392,15 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		return fpin;
 	}
 
-	if (vm_flags & VM_EXEC) {
-		/*
-		 * Allow arch to request a preferred minimum folio order for
-		 * executable memory. This can often be beneficial to
-		 * performance if (e.g.) arm64 can contpte-map the folio.
-		 * Executable memory rarely benefits from readahead, due to its
-		 * random access nature, so set async_size to 0.
-		 *
-		 * Limit to the boundaries of the VMA to avoid reading in any
-		 * pad that might exist between sections, which would be a waste
-		 * of memory.
-		 */
-		struct vm_area_struct *vma = vmf->vma;
-		unsigned long start = vma->vm_pgoff;
-		unsigned long end = start + vma_pages(vma);
-		unsigned long ra_end;
-
-		ra->order = exec_folio_order();
-		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
-		ra->start = max(ra->start, start);
-		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
-		ra_end = min(ra_end, end);
-		ra->size = ra_end - ra->start;
-		ra->async_size = 0;
-	} else {
-		/*
-		 * mmap read-around
-		 */
-		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
-		ra->size = ra->ra_pages;
-		ra->async_size = ra->ra_pages / 4;
-		ra->order = 0;
-	}
+	/*
+	 * mmap read-around
+	 */
+	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
+	ra->size = ra->ra_pages;
+	ra->async_size = ra->ra_pages / 4;
+	ra->order = 0;
 
+do_readahead:
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	ractl._index = ra->start;
 	page_cache_ra_order(&ractl, ra);
-- 
2.47.3

