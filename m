Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C731470459
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817079; cv=none; b=Aj1llhl6vssp04iLkg5ArlIuIa33yBGKcyTjFJd7ZUFifMpNBaOY1KgrofCCcVwb8Xa12AOYK1F1UYuCTymqQsoFyA1+guiH3jELLWOMTYcVZU723RrianQye07foGwo5p1/emjD4nUv1I8i6OmmDdKggA3e9nNM/IGnIf4XZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817079; c=relaxed/simple;
	bh=bZqHznnc6vw6mF8FrMNp002yRXTmhcPzvUFTmjLYfT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0IH701F8gv75eZBD8TAUqvAxx9km3/NssfGDyMIHgwKz1sJoN8NbKXwzYGOTEjAMcVEmwg+mxg14nT7k72lisWGYr1hXHKccbiAuqWiX9dtPylvtVaEEhOc/NnrGyj2ovsqWMHd3076pyY431Twg2NMT96cDYEZpFCqJzEqAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nK949Y3n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nK949Y3n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=K7Aeb1EqPNPxeMZD2pjfvJMEP/p6R5kd2OmQv2aIRuc=; b=nK949Y3nrGDjkv8QlxPhotECHd
	0ei16+jvDOgaLnkS2fgQ/8LssmLM8hV+LMlCGYr4Z7hmGqhYu/mDgqQMo/rxmGMh8qCBX0sp9UYB3
	s6PjrlnfP4vSPhGEWJZUmgMeS5CPnNnCXbZTmLVR7f5JxWfezjR0Yvt7WmMdG0GCUe8I92mPDoYWt
	BX+tNeUq4krKyor4XN4JvmFuHChEec5bBOMuK4Xts7/l4CzbgBX9XrL7oAid5EBNc2qrb+nxseTMS
	cQe1AAbJq4Qhogyn4mYQgX7jzfDF72otK/HkK4DoPxkIPyc4IVXkxbh7+LrWVDlTzcNKXnCt7HvzH
	iX1vVq2A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRZ-00000000ji5-1RW4;
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
Subject: [PATCH v4 09/14] mm: Check individual hugetlb pages for poison
Date: Thu, 23 Jul 2026 15:30:26 +0100
Message-ID: <20260723143034.175661-10-willy@infradead.org>
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
index 7c4652dd517a..9cde74320e48 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1090,6 +1090,8 @@ static inline bool PageHuge(const struct page *page)
 	return folio_test_hugetlb(page_folio(page));
 }
 
+bool hugetlb_unref_page_hwpoison(const struct page *page);
+
 /*
  * Check if a page is currently marked HWPoisoned.  This check is best
  * effort only and inherently racy: there is no way to synchronize with
@@ -1104,7 +1106,7 @@ static inline bool is_page_hwpoison(const struct page *page)
 		return true;
 	folio = page_folio(page);
 	if (folio_test_huge_poison(folio))
-		return true;
+		return hugetlb_unref_page_hwpoison(page);
 	/* In case we raced with hugetlb transferring flags */
 	return PageHWPoison(page);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5076ee5d4788..73ebbc935661 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1817,17 +1817,12 @@ struct raw_hwp_page {
 	struct page *page;
 };
 
-/*
- * Check if a given @page in a hugetlb folio is HWPOISON.
- */
-bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
+static bool precise_page_poisoned(const struct folio *folio,
+		const struct page *page)
 {
 	const struct llist_head *list = &folio->hugetlb_hwpoison;
 	const struct raw_hwp_page *p;
 
-	if (!folio_test_has_hwpoisoned(folio))
-		return false;
-
 	/*
 	 * When RawHwpUnreliable is set, kernel lost track of which pages
 	 * are HWPOISON. So return as if ALL pages are HWPOISONed.
@@ -1843,6 +1838,40 @@ bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
 	return false;
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
 	struct llist_node *head;
-- 
2.47.3

