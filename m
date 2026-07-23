Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D94471D06
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817061; cv=none; b=SJwUY4jNraSrDDF6Y8nmSawi0cqnvAjcNlXJUlI6wySnX2AE1WpQBK1LFwRKO/4Y+S2ZdVrPAjuk7Jku/aHsvj20XXvBBUTgnmDX6vp5x+60Z/rfLLdGM8OmS1hOLCOVJfrUrU9WWUukc9ePkiJbBtP+kU2hX4yrasYgKJzUbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817061; c=relaxed/simple;
	bh=fdyMdbDVwCReFR8NG0YtcfO8P4cfEt4nSVkANRKaK64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efgJVCsSyTOpSXbocwVUbPSWap1/w6zMbKA+ofASfIe0XJDL1xHiHUUwigl3NFwdnanrXGdIr3csmroMeyT5PO0ua5+7my1JzKHEc0SGVPX1Xcp9fttxLAoJusJZaDizQ2syZASLjf81l9zoVuytgfv4hZ8GHRQq2CMrQaOL7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RF0dAL5x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RF0dAL5x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pWzDgbDHh//kjXI/UxyCil9pIzMkVEMEYobg48le8fA=; b=RF0dAL5xzCgBVp2cK1G93xF2Qt
	nwnm/gIfwlF586XfPkjlxdKVuiRoe3O1I8BSXvIZ/LzoLkkJQewcaB6ztYIf9D0sd7SClqep+jfga
	CF0A5lxFBiUAqGUdmS3liGX9CuVbepfguCGZFf/fEKuM51dyw7jmBTwnx9mIEZ9aFZ2o3pPycKhWa
	G/rc8OsHfnGH2dz2PfTXpb3zC2PxfdCIKhBHzaXMHxcFBeL4cd/MOaVG9s6Yx08/OWyX7s5lwN9MO
	CJQd6FpH1EiWmG0CsVty6fHCjAAwknbM5m6BX3OsNt0LGnkz9ELTZ6mK2oiiVXMOfvs7wrwg0arR/
	XRORdQ9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRZ-00000000jhz-00cA;
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
Subject: [PATCH v4 06/14] memory-failure: Remove raw_hwp_list_head()
Date: Thu, 23 Jul 2026 15:30:23 +0100
Message-ID: <20260723143034.175661-7-willy@infradead.org>
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

There's no need to hide the llist_head; we can just declare it
directly in struct folio and do away with raw_hwp_list_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h |  4 ++--
 mm/memory-failure.c      | 19 +++++--------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..d7a9b0d8bbdf 100644
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
+			struct llist_head hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_3;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3615ced0a11b..18691c905ac9 100644
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

