Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEE4908DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271487; cv=none; b=dwMEwWVCNjNriS7YWv0IEUQQG+ZGAKFTeiNuGn/xMTG93y5xdFPkpDRuLraSBdSHsNba2LoCEjJAskuLLM3s2X7TDs0unw2SNeiGIv00jShY95lRcSgLwFifsrvE9EAb4dlYil/dh2oFj8fMdPGJFvE/xXpfmG2UamuJK6N9PfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271487; c=relaxed/simple;
	bh=ky9BcNrTQmgvnHSmZ8kEqcae4MCQcLows4S5tMRxY4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J07ujhAgf0v0aXMx/NwK3iYcgnWDsPbr3pJdzq/O04sfWEukGDSCyi6qGIH4H8C9//4rKxvcjHFSn39989u84USt+eV5hDH70Zhf+sl1B8r7fqUGnfEtucx4Bn+YWqWf31IkUtxfQ+kybp0u7AceE3oTGWeT0Rv4uLWHi8SCThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s5QYp6Yu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5QYp6Yu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AOaRJ24DEqH0RO/tTZ5gHGKvtUC1B5aShvKQInsts7M=; b=s5QYp6YuvpFLszQOM51zVcZ43z
	rtfFuMv0q5OUsuPe6r4qQjlm/D6AOmMvLphsSx+16oKBL2TvDjvH4E08s6xejXtPtsnHBkOsvqSSN
	TR/GONKeNcX6WE/KinCInuwOc9qviy1tJ/xvjwbxFnJUwKKie9j+nXONxZ+xj8Oo1bpBx12d3tjti
	E/ls25QIHXR61wabAYILJipe10ZB9akM5ANl8VEQrXTz081V5ZQG1uOUfN58QrIVtnPoPcXxfThkk
	d0sMM6CwLJyYjnzgRRruJaN2e876+IqIJavj+Rke9nLobcGLGmPdHCfE3vE1LaHsc8A8pqlzJcZ+E
	ZUI6sDdg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooep-0000000EFWi-2oEg;
	Tue, 28 Jul 2026 20:44:11 +0000
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
Subject: [PATCH v7 07/13] mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
Date: Tue, 28 Jul 2026 21:43:59 +0100
Message-ID: <20260728204409.3396238-8-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728204409.3396238-1-willy@infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sleeping in this kind of predicate is unexpected.  Add a new spinlock
to protect access to the list, and turn it into a normal singly linked
list now that it doesn't need to be a lockless list.

Rename is_raw_hwpoison_page_in_hugepage() to hugetlb_page_hwpoison()
and make it take the folio (since the callers naturally have the folio).
Also remove the handling of non-hugetlb folios and make the arguments
const.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c     |   4 +-
 include/linux/hugetlb.h  |   5 +-
 include/linux/mm_types.h |   4 +-
 mm/memory-failure.c      | 101 ++++++++++++++++++++++-----------------
 4 files changed, 61 insertions(+), 53 deletions(-)

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
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..86a2d0fee557 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,7 +387,7 @@ typedef unsigned short mm_id_t;
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
- * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
+ * @hugetlb_hwpoison: List of pages with hwpoison.
  * @_deferred_list: Folios to be split under memory pressure.
  * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
  *
@@ -499,7 +499,7 @@ struct folio {
 			void *_hugetlb_subpool;
 			void *_hugetlb_cgroup;
 			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
+			struct hwp_page *hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_3;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fda6698e5e0f..30470f8ea590 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1808,63 +1808,60 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 
 #ifdef CONFIG_HUGETLB_PAGE
 
+/* Protects all lists of hwp_pages */
+static DEFINE_SPINLOCK(hwp_page_lock);
+
 /*
- * Struct raw_hwp_page represents information about "raw error page",
- * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
+ * hwp_page represents information about "error page",
+ * constructing singly linked list from folio->hugetlb_hwpoison field.
  */
-struct raw_hwp_page {
-	struct llist_node node;
+struct hwp_page {
+	struct hwp_page *next;
 	struct page *page;
 };
 
-static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
-{
-	return (struct llist_head *)&folio->_hugetlb_hwpoison;
-}
-
-bool is_raw_hwpoison_page_in_hugepage(struct page *page)
+/*
+ * Check if a given @page in a hugetlb folio is HWPOISON.
+ */
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
 {
-	struct llist_head *raw_hwp_head;
-	struct raw_hwp_page *p;
-	struct folio *folio = page_folio(page);
-	bool ret = false;
+	const struct hwp_page *p;
+	unsigned long flags;
 
 	if (!folio_test_has_hwpoisoned(folio))
 		return false;
 
-	if (!folio_test_hugetlb(folio))
-		return PageHWPoison(page);
+	spin_lock_irqsave(&hwp_page_lock, flags);
 
 	/*
-	 * When RawHwpUnreliable is set, kernel lost track of which subpages
-	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
+	 * When RawHwpUnreliable is set, kernel lost track of which pages
+	 * are HWPOISON. So return as if ALL pages are HWPOISONed.
 	 */
-	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio)) {
+		spin_unlock_irqrestore(&hwp_page_lock, flags);
 		return true;
+	}
 
-	mutex_lock(&mf_mutex);
-
-	raw_hwp_head = raw_hwp_list_head(folio);
-	llist_for_each_entry(p, raw_hwp_head->first, node) {
-		if (page == p->page) {
-			ret = true;
+	for (p = folio->hugetlb_hwpoison; p; p = p->next) {
+		if (page == p->page)
 			break;
-		}
 	}
+	spin_unlock_irqrestore(&hwp_page_lock, flags);
 
-	mutex_unlock(&mf_mutex);
-
-	return ret;
+	return p != NULL;
 }
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
-	struct llist_node *head;
-	struct raw_hwp_page *p, *next;
+	struct hwp_page *p, *next;
 	unsigned long count = 0;
 
-	head = llist_del_all(raw_hwp_list_head(folio));
-	llist_for_each_entry_safe(p, next, head, node) {
+	next = folio->hugetlb_hwpoison;
+	folio->hugetlb_hwpoison = NULL;
+
+	while (next) {
+		p = next;
+		next = p->next;
 		if (move_flag)
 			SetPageHWPoison(p->page);
 		else
@@ -1905,9 +1902,8 @@ static inline int hugetlb_clear_poison(struct folio *folio)
  */
 static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
-	struct llist_head *head;
-	struct raw_hwp_page *raw_hwp;
-	struct raw_hwp_page *p;
+	struct hwp_page *p;
+	unsigned long flags;
 	int ret = hugetlb_set_poison(folio);
 
 	/*
@@ -1917,16 +1913,23 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return MF_HUGETLB_FOLIO_PRE_POISONED;
-	head = raw_hwp_list_head(folio);
-	llist_for_each_entry(p, head->first, node) {
+
+	spin_lock_irqsave(&hwp_page_lock, flags);
+	for (p = folio->hugetlb_hwpoison; p; p = p->next) {
 		if (p->page == page)
-			return MF_HUGETLB_PAGE_PRE_POISONED;
+			break;
 	}
 
-	raw_hwp = kmalloc_obj(struct raw_hwp_page, GFP_ATOMIC);
-	if (raw_hwp) {
-		raw_hwp->page = page;
-		llist_add(&raw_hwp->node, head);
+	if (p) {
+		spin_unlock_irqrestore(&hwp_page_lock, flags);
+		return MF_HUGETLB_PAGE_PRE_POISONED;
+	}
+
+	p = kmalloc_obj(*p, GFP_ATOMIC);
+	if (p) {
+		p->page = page;
+		p->next = folio->hugetlb_hwpoison;
+		folio->hugetlb_hwpoison = p;
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
@@ -1935,16 +1938,20 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 		 */
 		folio_set_hugetlb_raw_hwp_unreliable(folio);
 		/*
-		 * Once hugetlb_raw_hwp_unreliable is set, raw_hwp_page is not
+		 * Once hugetlb_raw_hwp_unreliable is set, hwp_page is not
 		 * used any more, so free it.
 		 */
 		__folio_free_raw_hwp(folio, false);
 	}
+	spin_unlock_irqrestore(&hwp_page_lock, flags);
 	return ret;
 }
 
 static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
+	unsigned long count;
+	unsigned long flags;
+
 	/*
 	 * hugetlb_vmemmap_optimized hugepages can't be freed because struct
 	 * pages for tail pages are required but they don't exist.
@@ -1959,7 +1966,11 @@ static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return 0;
 
-	return __folio_free_raw_hwp(folio, move_flag);
+	spin_lock_irqsave(&hwp_page_lock, flags);
+	count = __folio_free_raw_hwp(folio, move_flag);
+	spin_unlock_irqrestore(&hwp_page_lock, flags);
+
+	return count;
 }
 
 void folio_clear_hugetlb_hwpoison(struct folio *folio)
-- 
2.47.3

