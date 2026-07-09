Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2C3C1098
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622880; cv=none; b=AfdBL3f/VrXzEWg8pbmt7FIX+hwEoXvJtcAVAA1mX3lOCOcKVUbxYDD7uDN3j4ok2lKP+hmel9Xh8NvqtUYiyoLyfkOdqn4q6XBpgFSItx8nWGK+A2EBk/aJGMEyvHGDT6BHkAjVFd1u8WuFZ2NMZtZtq6H8C9uVBEZ8JgJKIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622880; c=relaxed/simple;
	bh=4UW+uEhoT+kLzpc7ecwpYrVADVfX1+fbpFb350TBm3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9VXbnCIAo7ARZe7RKlkp5HmhmN1DAAm3TsOy9UpnwJVwC5gbld/Ir3rMuz1OQ7fEoE/qhqjAUTu0KO1ef5fkDoYLyC2N+YO41FGL9/3ZoB5QcBzS+lJ8Dzsn9LV4nxfWRVtlvoQ3fZIEnC7+ewBlkYZjba012vgt8LLW5uuC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S4Tv8EGY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4Tv8EGY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PI1T4q5X682UwZ4EURsA+/ZoxJRVoodZbOrIQIJ/AVQ=; b=S4Tv8EGYY++NwAF0kQcSLoL7pl
	xpLZ+uLJ+mYVW+wldiNH1mumhaYiNq18TnXsgdn00W/sPi4z2fCK5BFyC9oy2ImTlRoJQjDVCWq12
	YrM8gLGbm43taDEpT/2SehGvMlcEfT37cCHY4EOIZm7l+Fl8eJlO+C3TyI8+kn7O1hD3LQCQDuPSl
	MH4712qCgzpmr92zpIAxIJqS+Q+N3Ot9qXR3dixU4xvysHFCw/m1DIYoQBySffGmp67h670cRaKus
	ZvW0iJwfhPpdG0ESw/lh1/lx1r8jJs6tH3R+mKFDxrnNaR/bkNFb80IVha5piCLK7XJmp6zX9TuDH
	6DJxB3Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtmg-00000005OhJ-3Fk9;
	Thu, 09 Jul 2026 18:47:42 +0000
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
	Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 05/10] memory-failure: Remove raw_hwp_list_head()
Date: Thu,  9 Jul 2026 19:47:33 +0100
Message-ID: <20260709184740.1286561-6-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709184740.1286561-1-willy@infradead.org>
References: <20260709184740.1286561-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to hide the llist_head; we can just declare it
directly in struct folio and do away with raw_hwp_list_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h |  4 ++--
 mm/memory-failure.c      | 19 +++++--------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..d46f81f94848 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,7 +387,7 @@ typedef unsigned short mm_id_t;
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
- * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
+ * @_hugetlb_hwpoison: Raw error pages, see struct raw_hwp_page.
  * @_deferred_list: Folios to be split under memory pressure.
  * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
  *
@@ -499,7 +499,7 @@ struct folio {
 			void *_hugetlb_subpool;
 			void *_hugetlb_cgroup;
 			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
+			struct llist_head hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_3;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..53063e2a1f97 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1810,21 +1810,15 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 
 /*
  * Struct raw_hwp_page represents information about "raw error page",
- * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
+ * constructing singly linked list from folio->hugetlb_hwpoison field.
  */
 struct raw_hwp_page {
 	struct llist_node node;
 	struct page *page;
 };
 
-static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
-{
-	return (struct llist_head *)&folio->_hugetlb_hwpoison;
-}
-
 bool is_raw_hwpoison_page_in_hugepage(struct page *page)
 {
-	struct llist_head *raw_hwp_head;
 	struct raw_hwp_page *p;
 	struct folio *folio = page_folio(page);
 	bool ret = false;
@@ -1844,8 +1838,7 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
 
 	mutex_lock(&mf_mutex);
 
-	raw_hwp_head = raw_hwp_list_head(folio);
-	llist_for_each_entry(p, raw_hwp_head->first, node) {
+	llist_for_each_entry(p, folio->hugetlb_hwpoison.first, node) {
 		if (page == p->page) {
 			ret = true;
 			break;
@@ -1863,7 +1856,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	struct raw_hwp_page *p, *next;
 	unsigned long count = 0;
 
-	head = llist_del_all(raw_hwp_list_head(folio));
+	head = llist_del_all(&folio->hugetlb_hwpoison);
 	llist_for_each_entry_safe(p, next, head, node) {
 		if (move_flag)
 			SetPageHWPoison(p->page);
@@ -1887,7 +1880,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
  */
 static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
-	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p;
 	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
@@ -1899,8 +1891,7 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return MF_HUGETLB_FOLIO_PRE_POISONED;
-	head = raw_hwp_list_head(folio);
-	llist_for_each_entry(p, head->first, node) {
+	llist_for_each_entry(p, folio->hugetlb_hwpoison.first, node) {
 		if (p->page == page)
 			return MF_HUGETLB_PAGE_PRE_POISONED;
 	}
@@ -1908,7 +1899,7 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 	raw_hwp = kmalloc_obj(struct raw_hwp_page, GFP_ATOMIC);
 	if (raw_hwp) {
 		raw_hwp->page = page;
-		llist_add(&raw_hwp->node, head);
+		llist_add(&raw_hwp->node, &folio->hugetlb_hwpoison);
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
-- 
2.47.3

