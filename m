Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44903128AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052550; cv=none; b=ILRkoOxLNlzkK4JYJG1d9j9I8wGQOmkO6bse9Si4m8YCLgOso8gEzodkowiQIAwV7aKskCdfCFuVwG1e/hdJxR30oLT/gqBUtNrygiKKhJBMm8TQ43c7luKOE3MWVJ8PteseSvQjk+LH6plRaur1wLr3yqMKgj1jJom379qyLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052550; c=relaxed/simple;
	bh=N2TRtcGzi7r2B03KZiy2/lqWM2e+qCtHN9TAETpR5lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktJf1SPWtKvXxsYXjedvdokZ058kwwTXtcwHbuDdEtQDnI5+LD1+uj5U/ndvoviNHGQW8InrRA58rVaUZx4vMiSJRw0j/czP4bJlBnNEHuc9gg+llFCQZ74dBJvBvoyEvr5KJBj1vMfXVPhPSJIzAgeMqHXNliPAFcHrgc5WvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2SjIS/F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2SjIS/F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jBc0BLjnLxBj6be7rNfjSxMRe0katow/KmWRC7YugX8=; b=E2SjIS/FvUT+BiHx43vzMhtiFJ
	rxjDCErkqp1IDOTaSikDI9P98JYpeQh2WbqD8yawTHcphgmHnotMFL5lmwl8TG5eCh4PTV/3L3CBh
	3+QWh4DU6OuhYV87DK+8IqwMBVemWKJqEH59/hX/mgs7mI3pwCpxGpQvcAUJFuCdoALRFhruq0y5r
	5qvN14qMGp5avEnPHKLrsUELqJ4pNSPROwgmCmUOLf5NnKoPEa2PEgHp4j9k4jnJSUMuGyw8Fbdd8
	oqabvLo6HqIfir8YExe2ZLeWRUQgdmuICGMX4ohAVt8ZBphyP4Y91CfDF8Lkr32oB8FLQqVrJEEZW
	fzMOUTFA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjhYg-0000000FegU-3qiK;
	Tue, 14 Jul 2026 18:08:42 +0000
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
Subject: [PATCH v3 3/9] memory-failure: Track hugetlb poison in a hash table
Date: Tue, 14 Jul 2026 19:08:33 +0100
Message-ID: <20260714180840.3731244-4-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714180840.3731244-1-willy@infradead.org>
References: <20260714180840.3731244-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With HVO, we cannot track per-page hwpoison as the struct pages are no
longer there.  Instead, they were being tracked in a linked list
anchored in the folio.  Unfortunately, we need to be able to determine
whether pages are hwpoison without holding a reference to the folio and
there's no way to atomically check whether a folio is hugetlb and get
the list of hwpoison pages.

Switch to a global hashtable of hwpoison pages which is only queried
when the folio indicates that it has pages in that hashtable.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h |  2 --
 mm/memory-failure.c      | 71 +++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..ed5c0829ff56 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,7 +387,6 @@ typedef unsigned short mm_id_t;
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
- * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
  * @_deferred_list: Folios to be split under memory pressure.
  * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
  *
@@ -499,7 +498,6 @@ struct folio {
 			void *_hugetlb_subpool;
 			void *_hugetlb_cgroup;
 			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_3;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..490aed0b25b4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -43,6 +43,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/dax.h>
+#include <linux/hashtable.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
 #include <linux/export.h>
@@ -1808,24 +1809,18 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 
 #ifdef CONFIG_HUGETLB_PAGE
 
-/*
- * Struct raw_hwp_page represents information about "raw error page",
- * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
- */
-struct raw_hwp_page {
-	struct llist_node node;
+/* Protects hugetlb_hwpoison list */
+static DEFINE_SPINLOCK(htlb_hwpoison_lock);
+static DEFINE_HASHTABLE(htlb_hwpoison, 5);
+
+struct hwp_page {
+	struct hlist_node node;
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
-	struct raw_hwp_page *p;
+	struct hwp_page *p;
 	struct folio *folio = page_folio(page);
 	bool ret = false;
 
@@ -1842,36 +1837,39 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return true;
 
-	mutex_lock(&mf_mutex);
+	spin_lock(&htlb_hwpoison_lock);
 
-	raw_hwp_head = raw_hwp_list_head(folio);
-	llist_for_each_entry(p, raw_hwp_head->first, node) {
+	hash_for_each_possible(htlb_hwpoison, p, node, (unsigned long)page) {
 		if (page == p->page) {
 			ret = true;
 			break;
 		}
 	}
 
-	mutex_unlock(&mf_mutex);
+	spin_unlock(&htlb_hwpoison_lock);
 
 	return ret;
 }
 
-static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
+static unsigned long __folio_free_hwp(struct folio *folio, bool move_flag)
 {
-	struct llist_node *head;
-	struct raw_hwp_page *p, *next;
+	int b;
+	struct hwp_page *p;
+	struct hlist_node *tmp;
 	unsigned long count = 0;
 
-	head = llist_del_all(raw_hwp_list_head(folio));
-	llist_for_each_entry_safe(p, next, head, node) {
+	hash_for_each_safe(htlb_hwpoison, b, tmp, p, node) {
+		if (page_folio(p->page) != folio)
+			continue;
 		if (move_flag)
 			SetPageHWPoison(p->page);
 		else
 			num_poisoned_pages_sub(page_to_pfn(p->page), 1);
+		hash_del(&p->node);
 		kfree(p);
 		count++;
 	}
+
 	return count;
 }
 
@@ -1887,9 +1885,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
  */
 static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
-	struct llist_head *head;
-	struct raw_hwp_page *raw_hwp;
-	struct raw_hwp_page *p;
+	struct hwp_page *p;
 	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
@@ -1899,16 +1895,18 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return MF_HUGETLB_FOLIO_PRE_POISONED;
-	head = raw_hwp_list_head(folio);
-	llist_for_each_entry(p, head->first, node) {
-		if (p->page == page)
+	spin_lock(&htlb_hwpoison_lock);
+	hash_for_each_possible(htlb_hwpoison, p, node, (unsigned long)page) {
+		if (p->page == page) {
+			spin_unlock(&htlb_hwpoison_lock);
 			return MF_HUGETLB_PAGE_PRE_POISONED;
+		}
 	}
 
-	raw_hwp = kmalloc_obj(struct raw_hwp_page, GFP_ATOMIC);
-	if (raw_hwp) {
-		raw_hwp->page = page;
-		llist_add(&raw_hwp->node, head);
+	p = kmalloc_obj(struct hwp_page, GFP_ATOMIC);
+	if (p) {
+		p->page = page;
+		hash_add(htlb_hwpoison, &p->node, (unsigned long)page);
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
@@ -1920,13 +1918,15 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 		 * Once hugetlb_raw_hwp_unreliable is set, raw_hwp_page is not
 		 * used any more, so free it.
 		 */
-		__folio_free_raw_hwp(folio, false);
+		__folio_free_hwp(folio, false);
 	}
+	spin_unlock(&htlb_hwpoison_lock);
 	return ret;
 }
 
 static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
+	unsigned long count;
 	/*
 	 * hugetlb_vmemmap_optimized hugepages can't be freed because struct
 	 * pages for tail pages are required but they don't exist.
@@ -1941,7 +1941,10 @@ static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return 0;
 
-	return __folio_free_raw_hwp(folio, move_flag);
+	spin_lock(&htlb_hwpoison_lock);
+	count = __folio_free_hwp(folio, move_flag);
+	spin_unlock(&htlb_hwpoison_lock);
+	return count;
 }
 
 void folio_clear_hugetlb_hwpoison(struct folio *folio)
-- 
2.47.3

