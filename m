Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C642E8C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176029; cv=none; b=safR30WD4Xs9+iA3A/keImf1XSv0SJvTJsc4jmicpYoBSMxftWLlIV2GT6HYfDV2tP0E0bL3tnLiYnO6zr4xsorNNS8uhbMt9VTmUGcYNu8IEo4ZSQ3fM9QlqW64DeEXiB2WP79fl3DgHrDwZuEr2ZzENtNSz5hWjOs5fsVhbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176029; c=relaxed/simple;
	bh=G2JbKVLLW7v9SoAa9NDhksY1Dle3DVzicLkYELESfnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHhQRelSsnO6Hj6AUJ7/119rKPdcy7IlZb/N83IotTmrGGiw64zqaCC9h1XnbL9oUQPpUetgQ1lYe/oxWxK+fEUj1ZR2fcUI709bkNRsyiSz6Obj/cSlE4/4salJVOBvdFJPOWjxhGtwMyh9fI2SZlP9hFrFk20K1fasSz4SCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gmn8AmlZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gmn8AmlZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rf132WtRmSzSxiFh5bl0EzlR496uNHjo/zfgkA9sYuM=; b=Gmn8AmlZF1G0Z2phJV6LnBq+6W
	acSIKwSHIa0QCTd2i/6D6LzG0c8wkTbo+Ay8M8x2MYUcnH7AW9gG53S5iW3qhFByU+eqvvZNwZkIf
	S2ls056TYoODRQHkB7datzcAub0LGKBkYwj1eAoigASGEwyc5txJwUcSf4ImjS5WAycBAoLkz17O/
	97vngmClSoljUVHntw9Scglvm0OSmgTiMt0WYE9RQQ60GdEl+7rphIZ4JfLxQvUniZtmaYbTHD7L5
	Jo15NPW3ocb+G/IQTpJ7uSJSTr6oo41Gq/XMMHcOF6W313uICGxOcqmGM1IUjljpu9y9CsakZoNxj
	eYATpAFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPpA-0000000BD7a-2DBz;
	Mon, 27 Jul 2026 18:13:12 +0000
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
Subject: [PATCH v6 07/12] mm: Check individual hugetlb pages for poison
Date: Mon, 27 Jul 2026 19:13:03 +0100
Message-ID: <20260727181310.2671972-8-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727181310.2671972-1-willy@infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, is_page_hwpoison() has returned true for the entire poisoned
hugetlb folio, but we can usually allow access to the pages which
aren't poisoned.  It's slightly tricky due to not having a reference
to the folio, but the hugetlb lock can save us here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  4 +++-
 mm/memory-failure.c        | 43 +++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4fab3fbfd430..ee026ba9b0b5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1094,6 +1094,8 @@ static inline bool PageHuge(const struct page *page)
 	return folio_test_hugetlb(page_folio(page));
 }
 
+bool hugetlb_unref_page_hwpoison(const struct page *page);
+
 /*
  * Check if a page is currently marked HWPoisoned.  This check is best
  * effort only and inherently racy: there is no way to synchronize with
@@ -1108,7 +1110,7 @@ static inline bool is_page_hwpoison(const struct page *page)
 		return true;
 	folio = page_folio(page);
 	if (folio_test_huge_poison(folio))
-		return true;
+		return hugetlb_unref_page_hwpoison(page);
 	/* In case we raced with hugetlb transferring flags */
 	return PageHWPoison(page);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e358f6a33d27..6ca7e1df7f73 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1820,17 +1820,12 @@ struct hwp_page {
 	struct page *page;
 };
 
-/*
- * Check if a given @page in a hugetlb folio is HWPOISON.
- */
-bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
+static bool precise_page_poisoned(const struct folio *folio,
+		const struct page *page)
 {
 	const struct hwp_page *p;
 	unsigned long flags;
 
-	if (!folio_test_has_hwpoisoned(folio))
-		return false;
-
 	spin_lock_irqsave(&hwp_page_lock, flags);
 
 	/*
@@ -1851,6 +1846,40 @@ bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
 	return p != NULL;
 }
 
+/*
+ * Check if a given @page in a hugetlb folio is HWPOISON.
+ */
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
+{
+	if (!folio_test_has_hwpoisoned(folio))
+		return false;
+
+	return precise_page_poisoned(folio, page);
+}
+
+/*
+ * We have no reference on the folio containing this page.
+ * The hugetlb_lock keeps hugetlb folios from being freed.
+ */
+bool hugetlb_unref_page_hwpoison(const struct page *page)
+{
+	const struct folio *folio;
+	unsigned long flags;
+	bool ret;
+
+	spin_lock_irqsave(&hugetlb_lock, flags);
+	folio = page_folio(page);
+	if (!folio_test_huge_poison(folio)) {
+		ret = PageHWPoison(page);
+		goto unlock;
+	}
+
+	ret = precise_page_poisoned(folio, page);
+unlock:
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
+	return ret;
+}
+
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
 	struct hwp_page *p, *next;
-- 
2.47.3

