Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65636998C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528507; cv=none; b=pc8uU6n3nZddhxQium2oTcShpWQ0LIWESKdzEHmRlgDdZuj2jIc9mG+tgc0eH+YACSx37+oFRoHa12q7UWfq+NTq2f+q8AQhIuxn+9/dhZyRbbjuvlbvchbmKy520/GiXn5nsVHZgTevPvMQPJNbTTKcIzAi7TCUXCKjFd600qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528507; c=relaxed/simple;
	bh=uZAFDHCeEnnR7rCZ1KGIYL5shmaw9gCnfrVZ9Gxubhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9WyIvlCSqWC7+kCAaAuTTbGsqWG7rUftHq/Ce512Zr2UebyV2AYw+vZRO5cZodlYHlnaOrkOVtX+o+FNwH4Dliap4vXoQr59CL21pEk+3ujgf05G/T5uQepLmlH8L2tCvmHav1md2Sg2NuKTFAbbajIMcAXoIKjrWjqZaAIL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sbzhydkM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbzhydkM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ouvowIcM8jLtrmPgXBz2U3nMcb3XnRPv2XSwdzDzMKk=; b=sbzhydkMA/qQS9B/BefM2m8Eri
	oNaM2GVM3KoXp5QH4bmZSG+z3NqDS9wU4sSj6dMXpHJmvdLDajX4S+J/xBr8NoXtNwkC2Q1UPkDyd
	AIRkO4UsXA7bu6vihFc2mIRgck4Mm96RjqvpBZJAOmvn/rq5tGFvBlHGfxMPxNlwm7cvwfz7HQPiW
	oEs0gxs7Cm6iUFSlAyaVi6JWIC3ssTeTqKGRCZlZkXvpyH4jVo60IMiJnGoyiviz6KA+Zc0uRFISz
	0cN0VUmmrYkjwan22HQbwFd5ylyXre46jXrv8A1UQe0CH0vvWb4zheY6aPq0Li/TEwB5CR+UhkZIW
	WC0qGZjg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWX-00000002Pnj-2Jy3;
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
Subject: [PATCH v8 12/15] filemap: Remove checks in mapping_set_folio_order_range()
Date: Fri, 31 Jul 2026 21:07:57 +0100
Message-ID: <20260731200802.574821-13-willy@infradead.org>
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

These checks make it impossible to use mapping_set_folio_order_range()
in hugetlb.  They add very little value and can simply be removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..968b791cfd14 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -373,7 +373,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  * assumptions about maximum order if THP are disabled, but 8 seems like
  * a good order (that's 1MB if you're using 4kB pages)
  */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_LARGE_FOLIO
 #define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
 #else
 #define PREFERRED_MAX_PAGECACHE_ORDER	8
@@ -394,7 +394,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline size_t mapping_max_folio_size_supported(void)
 {
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (IS_ENABLED(CONFIG_LARGE_FOLIO))
 		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
 	return PAGE_SIZE;
 }
@@ -405,29 +405,23 @@ static inline size_t mapping_max_folio_size_supported(void)
  * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
  * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
  *
- * The filesystem should call this function in its inode constructor to
- * indicate which base size (min) and maximum size (max) of folio the VFS
- * can use to cache the contents of the file.  This should only be used
- * if the filesystem needs special handling of folio sizes (ie there is
- * something the core cannot know).
+ * The filesystem should call this function in its inode constructor
+ * to indicate which size folios can be used to cache the contents of
+ * the inode.  This should only be used if the filesystem needs special
+ * handling of folio sizes (ie there is something the core cannot know).
  * Do not tune it based on, eg, i_size.
  *
+ * hugetlb calls this with orders larger than MAX_PAGECACHE_ORDER.
+ * Normal filesystems should not do this.
+ *
  * Context: This should not be called while the inode is active as it
  * is non-atomic.
  */
 static inline void mapping_set_folio_order_range(struct address_space *mapping,
-						 unsigned int min,
-						 unsigned int max)
+		unsigned int min, unsigned int max)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (!IS_ENABLED(CONFIG_LARGE_FOLIO))
 		return;
-
-	if (min > MAX_PAGECACHE_ORDER)
-		min = MAX_PAGECACHE_ORDER;
-
-	if (max > MAX_PAGECACHE_ORDER)
-		max = MAX_PAGECACHE_ORDER;
-
 	if (max < min)
 		max = min;
 
@@ -460,7 +454,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 static inline unsigned int
 mapping_max_folio_order(const struct address_space *mapping)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (!IS_ENABLED(CONFIG_LARGE_FOLIO))
 		return 0;
 	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
 }
@@ -468,7 +462,7 @@ mapping_max_folio_order(const struct address_space *mapping)
 static inline unsigned int
 mapping_min_folio_order(const struct address_space *mapping)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (!IS_ENABLED(CONFIG_LARGE_FOLIO))
 		return 0;
 	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
@@ -524,7 +518,7 @@ static inline bool mapping_large_folio_support(const struct address_space *mappi
  *
  * Return: True if PMD-sized folios are supported, otherwise false.
  */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_LARGE_FOLIO
 static inline bool mapping_pmd_folio_support(const struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
-- 
2.47.3

