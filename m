Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1463CB8EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622888; cv=none; b=YNCHsESxzp1zImeaAFQBhrSuhufJaM4UwvnWuNsQaC92qQPZ2p8JImizsTJoTOgiifVpuXCY2ITmdMAK9pxqWHkg2/Hzi2Cr2YDTvoTW7jgMfrKpInIXWBbIqCuVYsVrBw/W3PFoPOHOQh2HTJQy4spM7xLijg2bQf6P0fHMOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622888; c=relaxed/simple;
	bh=9WAzHTALJ9fHjhH+L3WrCG5mmVi7yodlUzSs9knJuls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAeSsJKZQIa0XPbg+WIUe7jAR48vijHwFPyqxdWXONwRj7ewgIb5X63/dp/+D0slHuF3xTvHhIkTAiF5s23BGXtI5hFcuxAxjie59JhQWtGqdbgKJQuiikelROcnhb8UuJpEOJd/BROQ/oa1ELw3TOOOQH0t8kmT70GRf/H8ymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hwNFxlOW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwNFxlOW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JsiSeJx1/eVlqX100B02CqOARqMzp4czdyZ8GjzU008=; b=hwNFxlOWUTcTafiTn2yLRDZTdH
	USF5KKVKIjPGtRbAquHdNxr8SVinhl7DP1CUxyQlBVCAN4+JgJCFSu+/jcbdkoq95iTLbWv7y5W6q
	uwCxsNBRSnDryG4qNcWD0tmwtB8BFPAt7HtmCKQ/sVFFo38vemhxHcy/hKrDnsAADczJvoRXF7Prt
	kMVzqYO2j6pH7GDrtoif4jNEoHFjVIyY1h7S/A9SzONSp3Uqujksv3iwCGJNB2LoPWOz8iDbJIHxE
	eGgN/J3hJ5AGPZnJj8T/A55vtDjsCo2SdpEGSg8oP3W5ptFJP2IX0HnRPOCkMMcQR9T3qCnVAjqCV
	BTAq2K2g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtmg-00000005OhF-2GEc;
	Thu, 09 Jul 2026 18:47:42 +0000
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
Subject: [PATCH v2 03/10] filemap: Remove checks in mapping_set_folio_order_range()
Date: Thu,  9 Jul 2026 19:47:31 +0100
Message-ID: <20260709184740.1286561-4-willy@infradead.org>
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

These checks make it impossible to use mapping_set_folio_order_range()
in hugetlb.  They add very little value and can simply be removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..d0c9aecaa4ac 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -405,29 +405,18 @@ static inline size_t mapping_max_folio_size_supported(void)
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
  * Context: This should not be called while the inode is active as it
  * is non-atomic.
  */
 static inline void mapping_set_folio_order_range(struct address_space *mapping,
-						 unsigned int min,
-						 unsigned int max)
+		unsigned int min, unsigned int max)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		return;
-
-	if (min > MAX_PAGECACHE_ORDER)
-		min = MAX_PAGECACHE_ORDER;
-
-	if (max > MAX_PAGECACHE_ORDER)
-		max = MAX_PAGECACHE_ORDER;
-
 	if (max < min)
 		max = min;
 
-- 
2.47.3

