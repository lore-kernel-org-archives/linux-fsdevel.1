Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DC3CAA53
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052540; cv=none; b=V7SSOs906IRV/HtG+xlRiqoSaXXUwN9qIY9RSvIZv0t4sfJKOqWempaHFjjZVWIPoEdFMoXBh4XQ1oB4uTZcffT6PU4Wklq7laYNRigfqTEj4zIi9A2QYpN8B89/EK07slUpNyZ7aDxz4ProNDV7vLYBsf2cN2cpzoSPQqOOdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052540; c=relaxed/simple;
	bh=pqK7oWLEt5BUBMP2OeeW5h1iU6AdlosnmZ2d/AQB2mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itmdu3AtIY9aBsvTWyS6juk15dnjxutGiPn7BXXV/I06q0CudLD7IYEvN/VexAmWcFn7xg5s3/gdpqhHuUNtmuJ34/huI81f8y/DRipnKqe2/tcks5Fr79tvUMBaBnr2ALbF2tKIpBfnPYg7ngio4h3YAC2YyWpWK2ppVpp/EIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MvLsoMlH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MvLsoMlH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qv8hFHlEbSof/OmPedBDHALVoDRrfi7Tqx+xXO2FeDw=; b=MvLsoMlHnZki0JJPUFMHeIUc80
	HbaiQjitjDKizF+8XvcHnVtnJ2Nt3J6seFhIw2Hor+r0tjykMd1iQIOVOZGLnuOBwUDuZeZObcuTd
	BUD/uXDOh/azpheb+Wuv8PiM8bZdYfE4X82TZI33OrlMWFz5cO4DDzOLe+x0JjDoeeX12VV+cA2Na
	tnCkhCO2K9lyb3N2l0iAsMyBDRfgVWTCuQN1im7MvAhunH8i01iMwL6VIcQNrZewbAqpVE4btqG+A
	zYqU9/Sp7VJfQpZX02bYSHP4kWBq0OOHJU8x6ekSf5OxNQoyC5ZAIEHylWIUhdvR2AXru2MONLGHs
	/0EM2Cqg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjhYh-0000000Fegc-1HIY;
	Tue, 14 Jul 2026 18:08:43 +0000
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
Subject: [PATCH v3 6/9] filemap: Remove checks in mapping_set_folio_order_range()
Date: Tue, 14 Jul 2026 19:08:36 +0100
Message-ID: <20260714180840.3731244-7-willy@infradead.org>
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

These checks make it impossible to use mapping_set_folio_order_range()
in hugetlb.  They add very little value and can simply be removed.
Use CONFIG_FILEMAP_LARGE_FOLIO to mean "do we support HUGETLB or THP".

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/Kconfig              |  1 +
 include/linux/pagemap.h | 34 ++++++++++++++--------------------
 mm/Kconfig              |  4 ++++
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index cf6ae64776e6..4922adf5bc85 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -272,6 +272,7 @@ endif # HUGETLBFS
 
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
+	select FILEMAP_LARGE_FOLIO
 	select XARRAY_MULTI
 
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..346b77fa95ef 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -373,7 +373,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  * assumptions about maximum order if THP are disabled, but 8 seems like
  * a good order (that's 1MB if you're using 4kB pages)
  */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_FILEMAP_LARGE_FOLIO
 #define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
 #else
 #define PREFERRED_MAX_PAGECACHE_ORDER	8
@@ -394,7 +394,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline size_t mapping_max_folio_size_supported(void)
 {
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (IS_ENABLED(CONFIG_FILEMAP_LARGE_FOLIO))
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
+	if (IS_ENABLED(CONFIG_FILEMAP_LARGE_FOLIO))
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
+	if (!IS_ENABLED(CONFIG_FILEMAP_LARGE_FOLIO))
 		return 0;
 	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
 }
@@ -468,7 +462,7 @@ mapping_max_folio_order(const struct address_space *mapping)
 static inline unsigned int
 mapping_min_folio_order(const struct address_space *mapping)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (!IS_ENABLED(CONFIG_FILEMAP_LARGE_FOLIO))
 		return 0;
 	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
@@ -524,7 +518,7 @@ static inline bool mapping_large_folio_support(const struct address_space *mappi
  *
  * Return: True if PMD-sized folios are supported, otherwise false.
  */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_FILEMAP_LARGE_FOLIO
 static inline bool mapping_pmd_folio_support(const struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
diff --git a/mm/Kconfig b/mm/Kconfig
index 9e0ca4824905..992e7ae0b2bf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -843,11 +843,15 @@ config PERSISTENT_HUGE_ZERO_FOLIO
 config MM_ID
 	def_bool n
 
+config FILEMAP_LARGE_FOLIO
+	def_bool n
+
 menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
 	select COMPACTION
 	select XARRAY_MULTI
+	select FILEMAP_LARGE_FOLIO
 	select MM_ID
 	help
 	  Transparent Hugepages allows the kernel to use huge pages and
-- 
2.47.3

