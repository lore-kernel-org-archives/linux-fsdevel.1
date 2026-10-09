Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DE28315D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564929; cv=none; b=Qj7Gnx8vCHzRBnwNeT5oCusKGdDde7GO5eaWJWaTYgluY4/6h5zHogAbyms5PBUQPVRBNchvE8pGXFat8SRLbZIwKXucnVpxdW/cWHdigqZWWz+m/AumfqKcT8FvnBj2PNH5PNbn/nIdGyTtRG9G9obJ0r/jr4twrV8wDHWg9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564929; c=relaxed/simple;
	bh=82a91dJ8ksCrXs+DqBv0PnTZR7hB/CRFhn+IjCQD2Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCJmQ5scYPTHjxgpHTn6abwu4m6TFeJ/nuVFJ/JjPI9b95uI6ybj/n5otcVbKYhIAbaNQufb4Xby216Y5pQWn11rOA1oxYwrr2uBTRfotTAq+RRsf0B3LPhcmTMJ6J/1T6O4wpJtLm56Yn8TOzlqyPRCYkF1fMI/xl5gCM5quyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kypflZll; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kypflZll"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wC5Rz8I1WR8yDSD/uB/c6pVAn56Ir5mAe0LkNam/cuk=; b=kypflZlli3QYnFK0Lf2vTIlUqP
	mPacPVHNEeOi9Sw+ypgmxhxcanWW38ErOLjms9fPwmKTNiXEma3w2DOWBi20C5MUBE8/C85Hx3ru0
	obJck4VDsIfoUtqFxGg6OvHcQADeKpeoA3e0oIcRzPHCVc6+i6cBR1lMVjA8DgOz8cMEMBhJiHoXu
	tAp35CtwAFc+3+fNXpUPaq65uYqZXESVs30Jei0l4EVBh9fPTuFRs/woqTwg8w8vGEQromUX0wsR8
	lbjNvEI0gU4KPV9IVfZ0TpNuUdfpMrXS8Pn0A+BU+92Wfr9+CxiU70ncNAXBqqBnUDROj7muRLHgU
	r7IaPExA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDsO-0000000GDDX-35Ph;
	Fri, 09 Oct 2026 16:55:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Tal Zussman <tz2294@columbia.edu>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: [RFC PATCH 1/2] ramfs: Use filemap_add_folio() on nommu systems
Date: Fri,  9 Oct 2026 17:55:11 +0100
Message-ID: <20261009165518.3863950-2-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009165518.3863950-1-willy@infradead.org>
References: <20261009165518.3863950-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't send this upstream yet.

Need CONFIG_LARGE_FOLIO first.
Need to enable CONFIG_LARGE_FOLIO on nommu
Need to handle errors from folio_split()
---
 fs/ramfs/file-nommu.c | 53 ++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index fb471bf88ab7..92f33bc7a49c 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -61,8 +61,8 @@ const struct inode_operations ramfs_file_inode_operations = {
  */
 int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
 {
-	unsigned long npages, xpages, loop;
-	struct page *pages;
+	unsigned long npages;
+	struct folio *folio;
 	unsigned order;
 	void *data;
 	int ret;
@@ -82,49 +82,30 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
 
 	i_size_write(inode, newsize);
 
-	/* allocate enough contiguous pages to be able to satisfy the
-	 * request */
-	pages = alloc_pages(gfp, order);
-	if (!pages)
+	folio = folio_alloc(gfp, order);
+	if (!folio)
 		return -ENOMEM;
 
-	/* split the high-order page into an array of single pages */
-	xpages = 1UL << order;
-	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	split_page(pages, order);
-
-	/* trim off any pages we don't actually require */
-	for (loop = npages; loop < xpages; loop++)
-		__free_page(pages + loop);
+	ret = filemap_add_folio(inode->i_mapping, folio, 0, gfp);
+	if (ret < 0)
+		goto out;
 
 	/* clear the memory we allocated */
+	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	newsize = PAGE_SIZE * npages;
-	data = page_address(pages);
+	data = folio_address(folio);
 	memset(data, 0, newsize);
 
-	/* attach all the pages to the inode's address space */
-	for (loop = 0; loop < npages; loop++) {
-		struct page *page = pages + loop;
-
-		ret = add_to_page_cache_lru(page, inode->i_mapping, loop,
-					gfp);
-		if (ret < 0)
-			goto add_error;
-
-		/* prevent the page from being discarded on memory pressure */
-		SetPageDirty(page);
-		SetPageUptodate(page);
-
-		unlock_page(page);
-		put_page(page);
-	}
+	folio_mark_dirty(folio);
+	folio_mark_uptodate(folio);
 
-	return 0;
+	/* trim off any pages we don't actually require */
+	if (!is_power_of_2(npages))
+		folio_split(folio, 0, folio_page(folio, npages), NULL);
+	folio_unlock(folio);
 
-add_error:
-	while (loop < npages)
-		__free_page(pages + loop++);
+out:
+	folio_put(folio);
 	return ret;
 }
 
-- 
2.47.3

