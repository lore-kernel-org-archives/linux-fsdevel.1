Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFE3B775E;
	Mon, 20 Jul 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558410; cv=none; b=IaJnfGPFkGVXsHyXZ0FrmpzQXEP5ObjjYuDlDHjz2ZtzL+QxxiGser5LzIMFT7gVGPLiUjGbWrfKGR96t8VaSPNjo5D2FGGcTa7INeh79GP5zVFIJHLqdPvtinBHq+2JVRo24irZ27vKZ76Ly6Mx48qMzqWVtQ5oRpHnkxxLQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558410; c=relaxed/simple;
	bh=6oAdoFocXqlHeZgV/qOxR/hLOIfpXC9mc/vlgufhmIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riJ7ehHOdMTAOzdFieCcxOPRkSzbiWtUat5joIIZXILeGaVsl+MuTL04YQ9lvIIJlbe1c78Rtg5gqrMKkrmkqQ3adh2iQTdVlbB68jsYEPuKl3xp7Emc+535JTCbcIoVWkyYfLDhwz6kBBjVpBIWuKu9zjiMGjs/GNJtvPsYCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihkKAuBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihkKAuBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D781F000E9;
	Mon, 20 Jul 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784558402;
	bh=vPRgGgD5Et0gA2LrEPYq7BEyOk+lst4YqtYhmYPtoNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ihkKAuBsHS90mOQuGgSPwHFNdRwKJ74q8U3c/CMWBE2s7tVdfeNThLJI3CIWj9xG8
	 MuecEx7awVv57WZ0cr0OJC7lBeS3VhQnhbZP3bnQeB53Z0N58cAQGQL1DDynQaeDRt
	 zm2yIiuFyZHtYcPVhR84l6Gmi1/ve5WrxvU8pF90NFnC3By3dMRIYKsJwM4k5zS9X+
	 lDmNmaA+fejnRImm1m7lte/QNcQMcRXhElPF8/PUVrZ5N84weywzuIki9kqlUznLQo
	 vlXaEGgCVlTmTioqZ/22/Eev5tF+sMzA0WMwFaH4G33LmnIhEnQWSR6HxsBjMVv9kj
	 dUUQe+q23Rq9g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 20 Jul 2026 15:38:33 +0100
Subject: [PATCH v2 07/15] mm/rmap: track whether the page VMA mapped walk
 is anonymous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-b4-scalable-cow-virt-pgoff-v2-7-2d549757a76f@kernel.org>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3158; i=ljs@kernel.org;
 h=from:subject:message-id; bh=6oAdoFocXqlHeZgV/qOxR/hLOIfpXC9mc/vlgufhmIg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLijN7MlVZTvFEV9FD4T7j9bE93wWt67FlMDXFW6zebc
 f6P+JjbUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgInETGH4K/HdNCly34tnPbvu
 F7wNkver8spem5J6dMn1qTr3lpWL2TIyXPDf6vJ3WsUZ5Q2JZ6XCl24PS9DrPaHYwtE0K3Zr8+N
 1HAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Update the page_vma_mapped_walk structure to track whether the walk is over
an anonymous folio or not.

This is necessary in order to determine the correct VMA page
offset (virtual or not) in vma_address_end() ready for a subsequent change
which adjusts which page offset to use depending on this parameter, and
update the comment slightly.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/rmap.h |  2 ++
 mm/internal.h        | 13 ++++++++-----
 mm/rmap.c            |  2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)

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
index 73f90aaa979d..7ed8bde7890d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1079,22 +1079,25 @@ static inline unsigned long vma_anon_address(const struct vm_area_struct *vma,
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
index 5798427d007f..04b657eefb3c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1240,6 +1240,7 @@ static bool mapping_wrprotect_range_one(struct folio *folio,
 		.vma		= vma,
 		.address	= address,
 		.flags		= PVMW_SYNC,
+		.is_anon_walk   = false,
 	};
 
 	state->cleaned += page_vma_mkclean_one(&pvmw);
@@ -1317,6 +1318,7 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 		.pgoff		= pgoff,
 		.vma		= vma,
 		.flags		= PVMW_SYNC,
+		.is_anon_walk   = false,
 	};
 
 	if (invalid_mkclean_vma(vma, NULL))

-- 
2.55.0

