Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C548989E
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528498; cv=none; b=r4h6HG2vfZ6xvehQoViTagEA/qtOCSjt0W6B9NY/9bDC2ZqEb6ATgNlzvwVZndxGDK0dBSRmQy3zByYprrAkJU0i53wO2ZfAs4WdhfvrTJKgaNmRu7W03gzBE50+ZPetfQrtC/fJ/Xlp/DStLM4h2VHw8Yvu2nzHhdKnNWfK3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528498; c=relaxed/simple;
	bh=gomsYaoNI02yCK7ViadX0Ci9ZZp1AgeJziDUJlxjdg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG/asJql7D5RF3VLURsCDSE/ByMf85V23bCkK5BcANkhGhwmBy2/nUhPlkPrZqN9BcQnsd0uc1DJHFVHiKgna24DidoR6+DmtvclfPnlvOmicj6fKZEWWriXl22SCls0jd0pPk2HicCU0wNMnotrtEwu3m/cKazgBXk7DGhGpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gQzW/MN0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQzW/MN0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tpbi7lKcbzTERg18/T6z9Nlhbo2QXLkGasNl6s9KsLg=; b=gQzW/MN0ar4blbV9S3CDmJvxz7
	GYOZxOHvNCS5IvcvaHBIl7XynkL3Qj5tuw8QwY1ggAUROMeJRJoStC2Xokn8bQ8VrwvCWtWwzJQ3p
	apB51GbndDPgHZJbl+n2xEm5I2mkb/x1EXn7ll1d0B2ZZau+DBCeGpOBQ0eLmVwYHGSOS0cR04hHR
	xf0LaRKD6Z+lHQmegLQnnit8uuI/ke3tzklOjiJX9lYP0VYyP0V3SaJk1pylJ0z5ALKpiks5TMS0X
	TZuB012ZUBYVIL3cnuhcvLtoj1RtqpwGM6MGTVcIwCRD+KrIJrwC9/4JwWfDunnigYrZQujURvqSm
	/eMiqXrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWX-00000002PnQ-1DWg;
	Fri, 31 Jul 2026 20:08:05 +0000
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
Subject: [PATCH v8 10/15] mm: Check individual hugetlb pages for poison
Date: Fri, 31 Jul 2026 21:07:55 +0100
Message-ID: <20260731200802.574821-11-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731200802.574821-1-willy@infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
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
index 437a2be6c58c..c0a402522c21 100644
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

