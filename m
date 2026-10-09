Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E32E7366
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564928; cv=none; b=uYTZBxKzuEPpU4XfdRRZtFjXbc0l6oMHFhgxmIp/0+81h0EXQ7qNCyq1N27+70DUgsZhXK17l8WgPfM6+MZhSwjl86Zha5rlk+unWnw1ydDyCQHOYk/x/2azYDTdRRXt2aK3ER6tUX4qBogwgZLevYnCpGC7YANSDtmsf8qee0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564928; c=relaxed/simple;
	bh=pcKsDn8oyXmtXKnbIMkck+bhLbiPyouSQmJVtOpIZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsEOCdGbfa/DHOY95yI14gMP4q8sIxfz2lG1SH2yyWHmTwTrOO9WUeDAWK4p2My4FpnafZ6h8LHEc/IacJE0ZSYtGtSHFR1lmxRdrWPqcpzQlwn6ZLS/ocKFypd8NuRFxGwTpj1qk0hZlXTPzsh/2ChZr2iXyV9v4YXXb49G6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oauoRI4N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oauoRI4N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AoLrYIs+uZdnBcxRlyRMY7u3KNMZ1TUqsOhaCJEqHdM=; b=oauoRI4N0hhJxGmx/jikCQ+6RJ
	0tOLYEl6b843Y7DFsLazkL2DjCN3vT9ak4F69LEkTo15dOob88O/CFWluL+BFs8KT6BeOscx+r5zw
	IkEozsyEbY5wQdBaIxWWMx9IFMIBXu0fs3Pr/w6IC63wDs+rSeWma8QxnzeLJiRx2Tp3jFco4TeQf
	pIbLFvDLx3OWK8vbyV4/qqn8HBd4GfWHB/AFNmXpBP6kj6G014rvblWrG/u41xCOoUI0ygugQP/77
	Pe9ieImqhuVNjOpukHaz35eOnAmatNtq5A3eJDWh0HEEYt4VKuwkk8nXYKe2mWU+so998q3AKmIIP
	I9Va/BMg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDsP-0000000GDDf-27Tf;
	Fri, 09 Oct 2026 16:55:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Tal Zussman <tz2294@columbia.edu>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: [RFC PATCH 2/2] mm: Remove add_to_page_cache_lru()
Date: Fri,  9 Oct 2026 17:55:12 +0100
Message-ID: <20261009165518.3863950-3-willy@infradead.org>
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

This compatibility function has no callers left; delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 2 --
 mm/folio-compat.c       | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0adfa6605653..42a4354352ca 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1343,8 +1343,6 @@ size_t fault_in_subpage_writeable(char __user *uaddr, size_t size);
 size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
 size_t fault_in_readable(const char __user *uaddr, size_t size);
 
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-		pgoff_t index, gfp_t gfp);
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
 void filemap_remove_folio(struct folio *folio);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 6212fdd6761a..054d76ff0917 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -67,13 +67,6 @@ bool redirty_page_for_writepage(struct writeback_control *wbc,
 }
 EXPORT_SYMBOL(redirty_page_for_writepage);
 
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-		pgoff_t index, gfp_t gfp)
-{
-	return filemap_add_folio(mapping, page_folio(page), index, gfp);
-}
-EXPORT_SYMBOL(add_to_page_cache_lru);
-
 noinline
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp)
-- 
2.47.3

