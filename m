Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4483CB8EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622891; cv=none; b=Ro9VaVFTgh8tfAoZmHpvd0Qfmk6jDZ0njyNPvM+hh7ebKBVAH8cdkGQi3oUpAsfXnwsBCU61IRt+/+HWIm4lwd4ERbdWIMSqGVlTErFstR6V0B79pGw3sgD4D2IuAUCPmATpuIl/0ooJTfCez2/dxMgN4s6jf6Uh9pjbLVirkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622891; c=relaxed/simple;
	bh=5+F/I53QaLWACOwZkIq4Agk/aCXKGxLjFiQHv1a+mOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWt1yEZR6fvT9DpzYqUlVSlaoG3KqCi5dWANkMe7hkLnMI3aQvTArxbf6IVnXTc7EamEyH73NxghnvTMYoxEEucjSYkQU4SPA7gbORuERGfO91EjAzVMmfxYWH0SvWpjOg/IFSSMmk5BU48SDt4crTw6iKMHRAl3kQc06L9IQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8BLG0jP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8BLG0jP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fBjegxxMfo8QzONw5chVSOjBUp3XLOtX+LW6eSxSxz4=; b=d8BLG0jPmzLw3dFray8Zg/jprv
	uh0nwOEossHMSdkj4yW+CZGvTLjeJkfdSD7WkRszCiSoZ5lmVHRQsvUnbh3Z9e57weTf/fMve6xlU
	hkI76Fva4ikvoQw8RPFG+NmIjxPvlWkxSoq56ToOU920mWkzoeH8zRTzSUG2YLBonhXLHgM2EPEVj
	Xg5s2v6AKLwUWC4HCGTQEElufkbERoPzdn9MdH71oz83Axwlmc0o50oVcpxiiPmw669rKb6N8ecFm
	NBw32A75BEmqwQPBs9Y3jUVOwAUs901l7/qXSXCUGHcN3blJ4BKsvAqoK+/7T1lTUaQA5dxejqrPH
	z5y1wbBg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtmh-00000005OhN-00xQ;
	Thu, 09 Jul 2026 18:47:43 +0000
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
Subject: [PATCH v2 07/10] mm: Handle hugetlb correctly in is_page_hwpoison()
Date: Thu,  9 Jul 2026 19:47:35 +0100
Message-ID: <20260709184740.1286561-8-willy@infradead.org>
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

Checking to see whether a page inside a hugetlb folio is hardware
poisoned is more complicated than I realised.  The correct logic was
in is_raw_hwpoison_page_in_hugepage().  Make is_page_hwpoison() the
official entry point for "is this page hwpoison", no matter what kind
of folio it belongs to.  Rename is_raw_hwpoison_page_in_hugepage() to
hugetlb_page_hwpoison(), and remove the attempt to handle non-hugetlb
folios from it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c       |  4 ++--
 include/linux/hugetlb.h    |  5 -----
 include/linux/page-flags.h | 24 +++++++++++++++++++-----
 mm/memory-failure.c        |  9 ++++-----
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1760df6f2709..725bb945a440 100644
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
index 18661a7cdb37..1878642e75ec 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1069,11 +1069,6 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
-/*
- * Check if a given raw @page in a hugepage is HWPOISON.
- */
-bool is_raw_hwpoison_page_in_hugepage(struct page *page);
-
 static inline unsigned long huge_page_mask_align(struct file *file)
 {
 	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4185a03a45cf..8e57c12a7301 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1068,6 +1068,9 @@ static inline bool PageHuge(const struct page *page)
 	return folio_test_hugetlb(page_folio(page));
 }
 
+#ifdef CONFIG_MEMORY_FAILURE
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
+
 /*
  * Check if a page is currently marked HWPoisoned. Note that this check is
  * best effort only and inherently racy: there is no way to synchronize with
@@ -1075,13 +1078,24 @@ static inline bool PageHuge(const struct page *page)
  */
 static inline bool is_page_hwpoison(const struct page *page)
 {
-	const struct folio *folio;
+	const struct folio *folio = page_folio(page);
+
+	if (folio_test_hugetlb(folio))
+		return hugetlb_page_hwpoison(folio, page);
+	return PageHWPoison(page);
+}
+#else
+static inline bool hugetlb_page_hwpoison(const struct folio *folio,
+		const struct page *page)
+{
+	return false;
+}
 
-	if (PageHWPoison(page))
-		return true;
-	folio = page_folio(page);
-	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
+static inline bool is_page_hwpoison(const struct page *page)
+{
+	return false;
 }
+#endif
 
 static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
 {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 353288cce1b2..58ab8166b7ec 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1817,18 +1817,17 @@ struct raw_hwp_page {
 	struct page *page;
 };
 
-bool is_raw_hwpoison_page_in_hugepage(struct page *page)
+/*
+ * Check if a given @page in a hugetlb folio is HWPOISON.
+ */
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
 {
 	struct raw_hwp_page *p;
-	struct folio *folio = page_folio(page);
 	bool ret = false;
 
 	if (!folio_test_hwpoison(folio))
 		return false;
 
-	if (!folio_test_hugetlb(folio))
-		return PageHWPoison(page);
-
 	/*
 	 * When RawHwpUnreliable is set, kernel lost track of which subpages
 	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
-- 
2.47.3

