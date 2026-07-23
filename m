Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555147606A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817078; cv=none; b=JKTF9J64FmhdK3qEX6uT1t+9jFoUo2moRaOp5Dk6DXRJWnOyXyMEpvPIEtVL5YzI2FWyqXM3eIP8azC2avz7HAbSuBKQIDuAL8TwRg1/16Vu8qI8sbWGWjpcZDKZwfSURDz3yJKxN4/N0HT0LxP+PUBa5Kog1bXed+PPPpIQuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817078; c=relaxed/simple;
	bh=6+uX+a9r0N4fW/3cXrFvphrYmEVwwDV3kwp2kIqW5lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EciGJEeilaaWLgXah25/XdsJnRTNtwcK9dvfsEIt5FHusSjwTfHUzLZmIdy0fpNrnS1Pddd89iGHpBtyQlnYDSY+pTmZv0bXTLEtrtWt1aMvArHjYLK9NBDI8R3eRL5diKUEhjCYz5WhorIEGCjVCbx3onGgeCfvNO/DzVpZSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DLxTvzNj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DLxTvzNj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2SPT3MXbDM1jP3sj5ZSZX30ECFfsAUAa+GQfYoFtxLo=; b=DLxTvzNj+O88TIlVYBut4qM66+
	Ogk0LZNay7eLUxNAl7nnZC2h6WiitVApkb1pbFaab6fhpulR9/D9wkAmi4lzwU94tnLYB1qhyuZFR
	1+JvB5iATzSNdbI5K9OzEGtY5FlLAqm2JiNmDFdEYvuzE49WIE8MGLHabV1DKSqtLFmlNfUqitGYG
	saK8IZ9wRXJyYMcL8KpyX/au+Ifs5L/lLDplp9VDbChr01t/iALBJ7r2M9eZVkBVcoUJQ+GaoOwi7
	0yjfDZr3EiMuloqQtENv3ew13rhfWK7yleultzFlrHMd+1dyz3Oaj7ykEp7KbWobBSHlowsXNSwcM
	y+zV91fQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRZ-00000000ji3-0uja;
	Thu, 23 Jul 2026 14:30:37 +0000
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
Subject: [PATCH v4 08/14] mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
Date: Thu, 23 Jul 2026 15:30:25 +0100
Message-ID: <20260723143034.175661-9-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143034.175661-1-willy@infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need the mutex to check the list, as long as we use READ_ONCE()
to access the list head.  Updates only add to the head of the list, so
we can miss new entries, but not old ones.  It's perfectly acceptable
to miss new entries as callers cannot tell which order the add and check
executed in anyway.

Rename is_raw_hwpoison_page_in_hugepage() to hugetlb_page_hwpoison()
and make it take the folio (since the callers naturally have the folio).
Also remove the handling of non-hugetlb folios and make the arguments
const.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c    |  4 ++--
 include/linux/hugetlb.h |  5 +----
 mm/memory-failure.c     | 31 ++++++++++++-------------------
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index fbac554886c3..dbca3f713bbf 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -198,7 +198,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 	struct page *page = folio_page(folio, offset / PAGE_SIZE);
 	size_t safe_bytes;
 
-	if (is_raw_hwpoison_page_in_hugepage(page))
+	if (hugetlb_page_hwpoison(folio, page))
 		return 0;
 	/* Safe to read the remaining bytes in this page. */
 	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
@@ -206,7 +206,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 
 	/* Check each remaining page as long as we are not done yet. */
 	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
-		if (is_raw_hwpoison_page_in_hugepage(page))
+		if (hugetlb_page_hwpoison(folio, page))
 			break;
 
 	return min(safe_bytes, bytes);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 18661a7cdb37..325f0404a7eb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1069,10 +1069,7 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
-/*
- * Check if a given raw @page in a hugepage is HWPOISON.
- */
-bool is_raw_hwpoison_page_in_hugepage(struct page *page);
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
 
 static inline unsigned long huge_page_mask_align(struct file *file)
 {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4200deab2c3c..5076ee5d4788 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1817,37 +1817,30 @@ struct raw_hwp_page {
 	struct page *page;
 };
 
-bool is_raw_hwpoison_page_in_hugepage(struct page *page)
+/*
+ * Check if a given @page in a hugetlb folio is HWPOISON.
+ */
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
 {
-	struct raw_hwp_page *p;
-	struct folio *folio = page_folio(page);
-	bool ret = false;
+	const struct llist_head *list = &folio->hugetlb_hwpoison;
+	const struct raw_hwp_page *p;
 
 	if (!folio_test_has_hwpoisoned(folio))
 		return false;
 
-	if (!folio_test_hugetlb(folio))
-		return PageHWPoison(page);
-
 	/*
-	 * When RawHwpUnreliable is set, kernel lost track of which subpages
-	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
+	 * When RawHwpUnreliable is set, kernel lost track of which pages
+	 * are HWPOISON. So return as if ALL pages are HWPOISONed.
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return true;
 
-	mutex_lock(&mf_mutex);
-
-	llist_for_each_entry(p, folio->hugetlb_hwpoison.first, node) {
-		if (page == p->page) {
-			ret = true;
-			break;
-		}
+	llist_for_each_entry(p, READ_ONCE(list->first), node) {
+		if (page == p->page)
+			return true;
 	}
 
-	mutex_unlock(&mf_mutex);
-
-	return ret;
+	return false;
 }
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
-- 
2.47.3

