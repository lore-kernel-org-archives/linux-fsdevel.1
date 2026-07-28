Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1E4756CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271467; cv=none; b=sg6e71PpfiC/2jCv34/kOQgAbSUwxHkg6J5WIglLi3tonoWiRxrE70AShIUg2MRSvdlv5aMHAXmC/q0p6js/CKIX0NWPpN3XEPr+deCEz3RuhG0kf7PvkTv+X/YCJ5tWwFsGKY68KdIw2RO+jGzKn0+sAlpF9fj7NwWRNNt9Efc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271467; c=relaxed/simple;
	bh=a7k+MKHePyDA/TOh9IuwrNhSDF1NygWwUm6QYgeKjgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+tG+nanioQDNHdzxz5zaUq6ShzZfnSKAEtsQMxt2KYwEmBC8rpJlHC9FM4jthbNmeWTOH+tpg/3xhn8m5HdcbJ59WdoHoEX04Ye8I4juTEICSxYEGGaaSZq6tQe7evO/lwOY3RMI4fAwIfMpn5fKdY0zg+8LtowfhZJuahnJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JpjIaAJJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JpjIaAJJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=a4PquJGep9XeLK1K+bYOdkYZpwLRUzc1gp+ascUjXRM=; b=JpjIaAJJWZPSMroUWGjplUBdLc
	mlP/uqIw0c+YKLKTfQlNOp2VyqngzoMhKkvTPE75Z2yzNCCK2xitJlZJjojJgB9OkWn0JfuUndGQ5
	iORept6TGYMsmpksrpVfbkcUYq8vCkcJu6yn3p+frhTz/6wmnmKu+3oj/mtxwUS9LNyy2WrTw0REM
	XX7UwLEMMFHUNxQWS2w05OM6V9THMfAfRe4nd9D0K8AKSQqI9rA5sSkHZkKLMozXngmOv+VMVoZYy
	yi/ZaawtM3LoZmHLLrvZbgmAFSrYJPFkGNCzTPEskksJcT8huas8Oa3fNAqiBHDjR5kdDvMGcX27x
	VS18wrMg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooep-0000000EFWd-0lbL;
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
Subject: [PATCH v7 05/13] hugetlb: Move poison to pages before clearing hugetlb page type
Date: Tue, 28 Jul 2026 21:43:57 +0100
Message-ID: <20260728204409.3396238-6-willy@infradead.org>
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

For is_page_hwpoison() to be reliable, we need to set the hwpoison
flag on each page before clearing the hugetlb flag.  Introduce
folio_clear_hugetlb() to make this easier.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/hugetlb.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cc8d98399913..47403d02be88 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1381,6 +1381,18 @@ static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask, int
 }
 #endif
 
+static void folio_clear_hugetlb(struct folio *folio)
+{
+	/*
+	 * Move HWPoison flag to each error page
+	 * which makes any healthy pages reusable.
+	 */
+	if (unlikely(folio_test_hwpoison(folio)))
+		folio_clear_hugetlb_hwpoison(folio);
+
+	__folio_clear_hugetlb(folio);
+}
+
 /*
  * Remove hugetlb folio from lists.
  * If vmemmap exists for the folio, clear the hugetlb flag so that the
@@ -1419,7 +1431,7 @@ void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	 * to tail struct pages.
 	 */
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
-		__folio_clear_hugetlb(folio);
+		folio_clear_hugetlb(folio);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1493,17 +1505,10 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	 */
 	if (folio_test_hugetlb(folio)) {
 		spin_lock_irq(&hugetlb_lock);
-		__folio_clear_hugetlb(folio);
+		folio_clear_hugetlb(folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Move PageHWPoison flag from head page to the raw error pages,
-	 * which makes any healthy subpages reusable.
-	 */
-	if (unlikely(folio_test_hwpoison(folio)))
-		folio_clear_hugetlb_hwpoison(folio);
-
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 	if (folio_test_hugetlb_cma(folio))
 		hugetlb_cma_free_frozen_folio(folio);
@@ -1595,7 +1600,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
 			list_del(&folio->lru);
 			spin_lock_irq(&hugetlb_lock);
-			__folio_clear_hugetlb(folio);
+			folio_clear_hugetlb(folio);
 			spin_unlock_irq(&hugetlb_lock);
 			update_and_free_hugetlb_folio(h, folio, false);
 			cond_resched();
@@ -1620,7 +1625,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 			} else {
 				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
-				__folio_clear_hugetlb(folio);
+				folio_clear_hugetlb(folio);
 				spin_unlock_irq(&hugetlb_lock);
 				update_and_free_hugetlb_folio(h, folio, false);
 				cond_resched();
@@ -1653,14 +1658,14 @@ static void update_and_free_pages_bulk(struct hstate *h,
 	 * should only be pages on the non_hvo_folios list.
 	 * Do note that the non_hvo_folios list could be empty.
 	 * Without HVO enabled, ret will be 0 and there is no need to call
-	 * __folio_clear_hugetlb as this was done previously.
+	 * folio_clear_hugetlb as this was done previously.
 	 */
 	VM_WARN_ON(!list_empty(folio_list));
 	VM_WARN_ON(ret < 0);
 	if (!list_empty(&non_hvo_folios) && ret) {
 		spin_lock_irq(&hugetlb_lock);
 		list_for_each_entry(folio, &non_hvo_folios, lru)
-			__folio_clear_hugetlb(folio);
+			folio_clear_hugetlb(folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-- 
2.47.3

