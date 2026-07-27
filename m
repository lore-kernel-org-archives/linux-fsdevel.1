Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770E380FD4
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176016; cv=none; b=Ha8jpX+F7DlG1FOuQvEdS15hVABjc6WLttVND+ZkuPOOLKVnGglgQqtTcwCiXPikA0mZ4IV98XBBUW1ljGApvUWGABOJKAju2fUg4W9ht0wsxaEaXobh2wTUT0H/oRIh+8+GFeku5hztkN9AWeuTljFc5nEK0B1PIddkbkMhYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176016; c=relaxed/simple;
	bh=/3nQgX48MjqQrEav0aZW8pRWcKgvDN0chLZXt97VuTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVF0UORd5QfC+I/17b0F2nkluAkPmGUe8Z0yS8hJJrm+CtuMiB2E7ZlOr+kn+czoZEbGensxLK7+weOJ77B6YVJUV2jZg00LJCmLMLTkBYyOFGX5J6vv62ZDnyy9g6e49uLpy1BFQrvJG5P7h4s3NsaZv4AQutiHC+sgSPeZ1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aEWhsY09; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aEWhsY09"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BLb28xcNVq7ejs1N0evQYAtnxGvoFOq0CBWGcdPFjMQ=; b=aEWhsY09vBt4mmFdDYd7baCymq
	EFIDxuvAdpXPGK2qO70j8w7RItxF32UhuKBeikDMkZeUfk8OpmtBMvCf7YP6kmIb3AD9SG1ImgaSK
	lsJ7trrVnnKUVSiq43cSWuoAT/6WJr+cW/9+XOasYBsQnaA2tZL9rKlzJQsAmtBkyq8okAi3wih8y
	j/bFsuTGqcOanDsSHn6t8RqNwWHezFGsbaAoaL/aGssIWne8o3Y6BKFu+AeOaFcv0/cNi1U6iYwtz
	TZzZWmYv4npngFcp4akboFKZkaMqOgNsZ15FbMtv1Jn3tyDp3kn32ciyV8uba2aV2tRkaZlX6rnrT
	TyJD4ycQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPp9-0000000BD7M-39v1;
	Mon, 27 Jul 2026 18:13:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v6 00/12] Use generic_file_read_iter() in hugetlbfs
Date: Mon, 27 Jul 2026 19:12:56 +0100
Message-ID: <20260727181310.2671972-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches are separated out from Jane's earlier series.
https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/

We need three things to use filemap_read_iter() instead of a hugetlbfs
specific read_iter: hwpoison handling, treating gaps in the pagecache as
holes, and having hugetlb set the folio size in the mapping.  hwopison
handling turned out to need a lot of prep work; the other two things
are fairly straightforward.

Sashiko complains that the implementation of AS_AUTHORITATIVE is
incomplete, but hugetlbfs doesn't use any of that functionality.
We'll add it when we need it, either when hugetlbfs uses it, or when we
convert shmem to use filemap.

v5 here:
https://lore.kernel.org/linux-mm/20260725160042.1557264-1-willy@infradead.org/

Changes from v5:
 - Move hugetlb_clear_poison() before folio_put() to fix a race that
   Sashiko pointed out.
 - Wrap failed get_hwpoison_page() path in hugetlb_lock to fix a race
   that Sashiko pointed out.
 - Reinstate handling of unpoisoning buddy pages that Sashiko pointed out.
 - Check the unreliable flag under the spinlock to fully fix the race
   that I was intending to fix.

Entire diff vs v5:
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 32f91935b210..6ca7e1df7f73 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1826,14 +1826,17 @@ static bool precise_page_poisoned(const struct folio *folio,
 	const struct hwp_page *p;
 	unsigned long flags;
 
+	spin_lock_irqsave(&hwp_page_lock, flags);
+
 	/*
 	 * When RawHwpUnreliable is set, kernel lost track of which pages
 	 * are HWPOISON. So return as if ALL pages are HWPOISONed.
 	 */
-	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio)) {
+		spin_unlock_irqrestore(&hwp_page_lock, flags);
 		return true;
+	}
 
-	spin_lock_irqsave(&hwp_page_lock, flags);
 	for (p = folio->hugetlb_hwpoison; p; p = p->next) {
 		if (page == p->page)
 			break;
@@ -2785,13 +2788,17 @@ int unpoison_memory(unsigned long pfn)
 
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
+		spin_lock_irq(&hugetlb_lock);
 		if (folio_test_hugetlb(folio)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
 			if (count == 0)
 				goto unlock_mutex;
 			ret = hugetlb_clear_poison(folio);
+		} else {
+			ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
 		}
+		spin_unlock_irq(&hugetlb_lock);
 	} else if (ghp < 0) {
 		if (ghp == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
@@ -2807,8 +2814,8 @@ int unpoison_memory(unsigned long pfn)
 			folio_put(folio);
 			goto unlock_mutex;
 		}
-		folio_put(folio);
 		ret = hugetlb_clear_poison(folio);
+		folio_put(folio);
 		if (!ret)
 			folio_put(folio);
 	} else {

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (10):
  memory-failure: Fix hardware poison check in unpoison_memory() again
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  guest_memfd: Use folio_has_hwpoisoned_page()
  hugetlb: Use the has_hwpoisoned flag
  mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
  mm: Check individual hugetlb pages for poison
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  filemap: Add support for authoritative mappings

 fs/Kconfig                 |   2 +-
 fs/hugetlbfs/inode.c       | 123 +++--------------------
 include/linux/hugetlb.h    |  24 ++---
 include/linux/mm_types.h   |   4 +-
 include/linux/page-flags.h |  63 ++++++++++--
 include/linux/pagemap.h    |  45 +++++----
 mm/Kconfig                 |   6 +-
 mm/filemap.c               |  51 +++++++++-
 mm/huge_memory.c           |   2 +-
 mm/hugetlb.c               |  16 +--
 mm/memory-failure.c        | 193 +++++++++++++++++++++++++------------
 mm/memory_hotplug.c        |   2 +-
 mm/rmap.c                  |  43 ++++++---
 mm/shmem.c                 |   2 +-
 mm/vmscan.c                |   2 +-
 virt/kvm/guest_memfd.c     |   2 +-
 16 files changed, 328 insertions(+), 252 deletions(-)

-- 
2.47.3

