Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A10425CED
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467089; cv=none; b=RKiukXiN4V8hGB27rwTjNOnQ9YmhzCjiTCTqcpWpiQzXcLVXDwplbcjpe6dyF5J1cnPUeP/LMUHUJuKzL5V2wQWovZC1Fre8YiAAnC0x4a6ATXTYwftJFEPvdjZGWKJisQVNHPX0h5Q8WCVZ3VfFRPjjFQExilOGgyE+pWVYmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467089; c=relaxed/simple;
	bh=ENFdwFzwYK4H1Gi0MXb2MaLiq1k0TD1SbF6GrUxaDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8EL7WlcVWafibnGyesbfeLt+FZgFVE7D9qJoDC5dRQsko6BoFF0voso84LBJWM1Uve9uFPBDtsRr2HZWF+wPNEX6lXqO+4MILMHGrLTRreoEuDcMjgZeN87VbXkPy8kX55R/SgNC9rksP8UE+I9R+CjFCPf0xppUCjpS21wi74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibg5Vx7A; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibg5Vx7A"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779467085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PicG0VGaxNfqAf+Vsr+MRf2Lg77IxoCYcktKo6m1Qck=;
	b=ibg5Vx7A+wVts3v0jvELrcgu35RAsfd9NMBDgdHVI2I4/3psC/DFKMs3uVXAeo8KquzM+C
	nx5ARqZbgApa9UptBR7iV3upH3Z43LfvtMI68/Pdozxl84IsBvqwCoQSWYDOgg+Xccwa0C
	8LNgGzd8ZjTQt+8DYDpl683S3yYyUwg=
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
Subject: [PATCH v5 2/2] mm: use mapping_max_folio_order() for force_thp_readahead order
Date: Fri, 22 May 2026 09:23:48 -0700
Message-ID: <20260522162422.3856502-3-usama.arif@linux.dev>
In-Reply-To: <20260522162422.3856502-1-usama.arif@linux.dev>
References: <20260522162422.3856502-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The force_thp_readahead path in do_sync_mmap_readahead() was gated on
the compile-time check HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and
always drove the readahead at HPAGE_PMD_ORDER / HPAGE_PMD_NR. On
configurations where HPAGE_PMD_ORDER exceeds MAX_PAGECACHE_ORDER --
notably arm64 with a 64K base page size, where HPAGE_PMD_ORDER is 13
(512MB) -- VM_HUGEPAGE mappings could never reach this path and fell
back to base-page readahead, even when the mapping itself could serve
usefully large folios well below the cap.

Widen the gate to

  min(HPAGE_PMD_ORDER, mapping_max_folio_order(mapping))
      <= MAX_PAGECACHE_ORDER

so force_thp_readahead engages whenever either order fits, and pick
ra->order accordingly:

  - HPAGE_PMD_ORDER when it fits (existing behaviour);
  - otherwise min(mapping_max_folio_order(mapping), get_order(SZ_2M)),
    capping the readahead folio at 2MB regardless of what the mapping
    advertises.

Size and align the readahead window from (1UL << ra->order) instead
of the hardcoded HPAGE_PMD_NR / HPAGE_PMD_ORDER so the chosen order
is honoured end-to-end.

On arm64 with a 64K base page size this lets VM_HUGEPAGE mappings get
large-folio readahead at the mapping's supported order (capped at
2MB) rather than dropping back to base pages. 2MB is also the size of
an arm64 contiguous-PTE (contpte) block on a 64K base, so the
resulting folios coalesce into a single TLB entry and reduce TLB
pressure on the readahead path.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/filemap.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f45a1b74870d..56fa715d66cd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3317,9 +3317,16 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
 
 	/* Use the readahead code, even if readahead is disabled */
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE) &&
+	    min(HPAGE_PMD_ORDER, mapping_max_folio_order(mapping)) <= MAX_PAGECACHE_ORDER) {
 		force_thp_readahead = true;
+		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
+			ra->order = HPAGE_PMD_ORDER;
+		else
+			ra->order = min_t(unsigned int,
+					  mapping_max_folio_order(mapping),
+					  get_order(SZ_2M));
+	}
 
 	if (!force_thp_readahead) {
 		/*
@@ -3354,17 +3361,18 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 
 	if (force_thp_readahead) {
+		unsigned long folio_nr_pages = 1UL << ra->order;
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
 		page_cache_ra_order(&ractl, ra);
 		return fpin;
 	}
-- 
2.52.0

