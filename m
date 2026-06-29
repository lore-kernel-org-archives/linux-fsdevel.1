Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BB425CCE;
	Mon, 29 Jun 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745462; cv=none; b=ootDjJ6FoUGeTrmxHHBrZRL6QJsaARFKorAdoS5g7PsL7fWV3TipI0c6HTChPSe3wPwxO/hiJqrFq/G3fJFdPypmTjKtT8IjZR5lr3OWfB4qGBt/QoHYPg/ktUVxzli0KZQemYQPWUlCnmPsP7RDBwgZIapvTXcVCTgNRw08q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745462; c=relaxed/simple;
	bh=waH9LghRDw1m5ftv5cUG64IGpq0YuJ8V9i30VSS/8Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocbZNKt+QYbJlqvMPuxdZqdzLGYb3zoA1PU17P4c4iBKHGrhFfvcZiglEtApirP0ZIwbYpO8UKw//BsY1Uxg0tmyrQlSn99ZHaMKEBnFW+TzobVjfLVuxPde3ywOMHzlPL4evVWa2uc0O5wp5pITJTl/8CUEWvZLe8VfrxMv3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUPtlzEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUPtlzEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C15E1F00A3D;
	Mon, 29 Jun 2026 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745461;
	bh=IQuOZwRRSLgdq/8aIs43CiqhUZHBoxvkbrFwRYFQ2B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUPtlzEKm/rkK6U+RL4o276C7CM2BimGalFca5bTDLE9z/wmgRZXass49O8oTQFHY
	 2KPBHFB1eeyPaLTY3yF3uCC324cMvlFBKDH6sFS+gtSHrhSWPjZChqeERZxNdtcabl
	 zMz+DfH+0Nh9+eojzTPBFkhNvZ99WcGVAlnr3492c26LktU4aUB3Ny9RZV2lHFDMHP
	 xPvgub2UUsQYVWdpclSUlc5izTcgxx+p6XqNIIrCLfEGBKj3ea2gK5V+iCcqysOW+0
	 r8Ls9jiToShkehH/mh2L1XdNB9gtAo+LXRheGe92dPtnMxNI47ugeLviDGLw+YUgl9
	 VaKLRv269RGcA==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 07/10] mm/rmap: track whether the page VMA mapped walk is anonymous
Date: Mon, 29 Jun 2026 16:03:47 +0100
Message-ID: <903a8f049fc04e82feba3fcb8b2b9b911551d275.1782745153.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782745153.git.ljs@kernel.org>
References: <cover.1782745153.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the page_vma_mapped_walk structure to track whether the walk is over
an anonymous folio or not.

This is necessary in order to determine the correct VMA page
offset (virtual or not) in vma_address_end() ready for a subsequent change
which adjusts which page offset to use depending on this parameter, and
update the comment slightly.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/rmap.h |  2 ++
 mm/internal.h        | 13 ++++++++-----
 mm/rmap.c            |  3 +++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8dc0871e5f00..a48ae9575bd2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -871,6 +871,7 @@ struct page_vma_mapped_walk {
 	pte_t *pte;
 	spinlock_t *ptl;
 	unsigned int flags;
+	bool is_anon_walk;
 };
 
 #define DEFINE_FOLIO_VMA_WALK(name, _folio, _vma, _address, _flags)	\
@@ -881,6 +882,7 @@ struct page_vma_mapped_walk {
 		.vma = _vma,						\
 		.address = _address,					\
 		.flags = _flags,					\
+		.is_anon_walk = folio_test_anon(_folio),		\
 	}
 
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
diff --git a/mm/internal.h b/mm/internal.h
index f1e7e6256b4c..120957a7850c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1298,22 +1298,25 @@ static inline unsigned long vma_anon_address(const struct vm_area_struct *vma,
 }
 
 /*
- * Then at what user virtual address will none of the range be found in vma?
+ * At what user virtual address will none of the range be found in vma?
  * Assumes that vma_address() already returned a good starting address.
  */
 static inline unsigned long vma_address_end(struct page_vma_mapped_walk *pvmw)
 {
-	struct vm_area_struct *vma = pvmw->vma;
-	pgoff_t pgoff;
+	const struct vm_area_struct *vma = pvmw->vma;
+	const pgoff_t pgoff = pvmw->pgoff;
+	pgoff_t pgoff_vma_start;
 	unsigned long address;
+	pgoff_t pgoff_end;
 
 	/* Common case, plus ->pgoff is invalid for KSM */
 	if (pvmw->nr_pages == 1)
 		return pvmw->address + PAGE_SIZE;
 
-	pgoff = pvmw->pgoff + pvmw->nr_pages;
+	pgoff_vma_start = vma_start_pgoff(vma);
+	pgoff_end = pgoff + pvmw->nr_pages;
 	address = vma->vm_start +
-		((pgoff - vma_start_pgoff(vma)) << PAGE_SHIFT);
+		((pgoff_end - pgoff_vma_start) << PAGE_SHIFT);
 	/* Check for address beyond vma (or wrapped through 0?) */
 	if (address < vma->vm_start || address > vma->vm_end)
 		address = vma->vm_end;
diff --git a/mm/rmap.c b/mm/rmap.c
index 0bdb65852222..a3e926a708b1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1240,8 +1240,10 @@ static bool mapping_wrprotect_range_one(struct folio *folio,
 		.vma		= vma,
 		.address	= address,
 		.flags		= PVMW_SYNC,
+		.is_anon_walk   = false,
 	};
 
+	VM_WARN_ON_ONCE(folio_test_anon(folio));
 	state->cleaned += page_vma_mkclean_one(&pvmw);
 
 	return true;
@@ -1317,6 +1319,7 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 		.pgoff		= pgoff,
 		.vma		= vma,
 		.flags		= PVMW_SYNC,
+		.is_anon_walk   = false,
 	};
 
 	if (invalid_mkclean_vma(vma, NULL))
-- 
2.54.0

