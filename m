Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B242E8ED;
	Mon, 20 Jul 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558393; cv=none; b=Vv5w/Dxl6K0sEq6wxeVL7aesG6tmCo5FeDgPbyifQJLycHjyu6CLSgHnZltzj27EEvgi37SJgRqu17fRSmT+PyLyDhm7bmuWhMrlEe156Vtlpow4QjbZq+9r9utIiuA3ZOpL+NB4MloPVWC7yOreazwvENrpjLqALlp7tfONUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558393; c=relaxed/simple;
	bh=wV4Xs9C/oteickrPVjPK0/HJqNh07r+G5RYKSasgEQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKGAKv8Xb/vqe3yncG8mC79WifmqhRIWlW3ax4iiI3uCSDzjk84X2+1Gm9M1ryjAjprUztS1kNZPRDc087It51jU2n8h2HIj17Iqwtk+3/+JHIyoOLpKeTsarSgfjnvrsh9vXEa1dGNHoKyxWrKvhBTS37guB/cy214uSsQgqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq3UG1mo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq3UG1mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674D71F000E9;
	Mon, 20 Jul 2026 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784558384;
	bh=hWH16RMl+8FexBLFh6ScXidqQvRnE14iA6MdxcccmsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pq3UG1moZojHMbiBRt7zmy3/ar2QOsaqtfcAbqhe4lV/OXg3Awo0NcvaauPsPO41Q
	 vtct8I1EyrHcQ2an97w3N+gtDfyLQOzNOZR+TJJHBvfpT8CDAPnQbTyXU0mFI/b+H6
	 rSKvZJRhlVnsU2wzTWsufuG9CLpAuiHrY2bMeTHkauZH4sv4xqec32RlQq9v/5eBwC
	 6nCX7mxafanhj+uBGN0QEbJMXsjR38UU5vu9QmKCnN+JbeqaMjyMdxmu9Lqr+ZQvkz
	 o6QRYNCO2a2D1peFfo8RCra0KGRAFyWR5s6PogI3P3AoL4Ebg/XNxxV6yYaqdZ78i/
	 TkqJxv7IL9Pog==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 20 Jul 2026 15:38:31 +0100
Subject: [PATCH v2 05/15] mm: introduce and use vma_filebacked_address()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-b4-scalable-cow-virt-pgoff-v2-5-2d549757a76f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4889; i=ljs@kernel.org;
 h=from:subject:message-id; bh=wV4Xs9C/oteickrPVjPK0/HJqNh07r+G5RYKSasgEQI=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLijN6U3rdteNSjXlwcseHZtlt8JYcydp+ss14kPXGuM
 WPy25rgjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEwk0Y+RYVKBT8/pDWfy67f/
 sEuyfOi194q50dN778Ir954ze8m3RpyR4YX37LrI6T2CEzL/eWw6Kdmd6hsz/2e7fPCiPwxSy7O
 XsgIA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

In cases where we know that the VMA is file-backed, use
vma_filebacked_address() rather than vma_address().

This lays the foundation for using the virtual page offset for anonymous
VMAs via vma_anon_address().

Also add an assert to ensure that the VMA whose address is required is not
anonymous.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/internal.h        | 18 ++++++++++++++++++
 mm/memory-failure.c  |  4 ++--
 mm/page_vma_mapped.c |  6 +++++-
 mm/rmap.c            | 10 ++++++----
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 04acfeffa066..73f90aaa979d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1025,6 +1025,24 @@ static inline unsigned long __vma_address(const struct vm_area_struct *vma,
 	return address;
 }
 
+/**
+ * vma_filebacked_address - Find the virtual address a file-backed page range is
+ * mapped at.
+ * @vma: The vma which maps this object.
+ * @pgoff: The page offset within its object.
+ * @nr_pages: The number of pages to consider.
+ *
+ * Returns: If any page in this range is mapped by this VMA, return the first
+ * address where any of these pages appear.  Otherwise, return -EFAULT.
+ */
+static inline unsigned long vma_filebacked_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff, unsigned long nr_pages)
+{
+	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
+
+	return __vma_address(vma, pgoff, vma_start_pgoff(vma), nr_pages);
+}
+
 /**
  * vma_address - Find the virtual address a page range is mapped at.
  * @vma: The vma which maps this object.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index aaf14608b30e..a8b03e2920ba 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -620,7 +620,7 @@ static void add_to_kill_fsdax(struct task_struct *tsk, const struct page *p,
 			      struct vm_area_struct *vma,
 			      struct list_head *to_kill, pgoff_t pgoff)
 {
-	unsigned long addr = vma_address(vma, pgoff, 1);
+	unsigned long addr = vma_filebacked_address(vma, pgoff, 1);
 	__add_to_kill(tsk, p, vma, to_kill, addr);
 }
 
@@ -2265,7 +2265,7 @@ static void add_to_kill_pgoff(struct task_struct *tsk,
 	}
 
 	/* Check for pgoff not backed by struct page */
-	tk->addr = vma_address(vma, pgoff, 1);
+	tk->addr = vma_filebacked_address(vma, pgoff, 1);
 	tk->size_shift = PAGE_SHIFT;
 
 	if (tk->addr == -EFAULT)
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index d7670ba4147b..081e483cc7bf 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -356,6 +356,7 @@ unsigned long page_mapped_in_vma(const struct page *page,
 		struct vm_area_struct *vma)
 {
 	const struct folio *folio = page_folio(page);
+	const pgoff_t pgoff = page_pgoff(folio, page);
 	struct page_vma_mapped_walk pvmw = {
 		.pfn = page_to_pfn(page),
 		.nr_pages = 1,
@@ -363,7 +364,10 @@ unsigned long page_mapped_in_vma(const struct page *page,
 		.flags = PVMW_SYNC,
 	};
 
-	pvmw.address = vma_address(vma, page_pgoff(folio, page), 1);
+	if (folio_test_anon(folio))
+		pvmw.address = vma_address(vma, pgoff, 1);
+	else
+		pvmw.address = vma_filebacked_address(vma, pgoff, 1);
 	if (pvmw.address == -EFAULT)
 		goto out;
 	if (!page_vma_mapped_walk(&pvmw))
diff --git a/mm/rmap.c b/mm/rmap.c
index ad820fe86f7d..5798427d007f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -865,14 +865,15 @@ unsigned long page_address_in_vma(const struct folio *folio,
 		if (!vma->anon_vma || !anon_vma ||
 		    vma->anon_vma->root != anon_vma->root)
 			return -EFAULT;
+		/* KSM folios don't reach here because of the !anon_vma check */
+		return vma_address(vma, page_pgoff(folio, page), 1);
 	} else if (!vma->vm_file) {
 		return -EFAULT;
 	} else if (vma->vm_file->f_mapping != folio->mapping) {
 		return -EFAULT;
 	}
 
-	/* KSM folios don't reach here because of the !anon_vma check */
-	return vma_address(vma, page_pgoff(folio, page), 1);
+	return vma_filebacked_address(vma, page_pgoff(folio, page), 1);
 }
 
 /*
@@ -1321,7 +1322,7 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 	if (invalid_mkclean_vma(vma, NULL))
 		return 0;
 
-	pvmw.address = vma_address(vma, pgoff, nr_pages);
+	pvmw.address = vma_filebacked_address(vma, pgoff, nr_pages);
 	VM_BUG_ON_VMA(pvmw.address == -EFAULT, vma);
 
 	return page_vma_mkclean_one(&pvmw);
@@ -3100,7 +3101,8 @@ static void __rmap_walk_file(struct folio *folio, struct address_space *mapping,
 	}
 lookup:
 	mapping_rmap_tree_foreach(vma, mapping, pgoff_start, pgoff_end) {
-		unsigned long address = vma_address(vma, pgoff_start, nr_pages);
+		unsigned long address = vma_filebacked_address(vma, pgoff_start,
+							       nr_pages);
 
 		VM_BUG_ON_VMA(address == -EFAULT, vma);
 		cond_resched();

-- 
2.55.0

