Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570F38A73C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952790; cv=none; b=rG4r8OUYRp1qvVROkUhP1RvQ0emrARyJj0x4xITdoWzX5Q4yHaf3P/kMOLKX6NTwKE7o9GFxRiY1p1hN+ESOV1tIo1kcqTf07jwnRynTUmFUQkdssRvP3uf3fMi5Crw8Fo5oUo+o9yHlgDuAu4cV3QJpShgGNlMrUat+VgSWnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952790; c=relaxed/simple;
	bh=MBO03B/f0Frr2fol0qRFEmyVCDVtfT7VhndCi1a+oWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsdYdw7USjt/LuJL4EO2Hc9aBuftVBV5NqhBdRYh6vrmlNGBSPjQNsWjCPs2612uotzyKFkkGmfw9Q1aWyMpcp66yLmj3lg60Gg4zLE4+11fMH4XiNLj5sAgkQCdoglBVPoKubmq6Tpj6sucuWUp10RgrtEY7PNjbqM/tdwvmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OMslnKvm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMslnKvm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nIKZ5rJR78Kn2rpf1TUpOelTrfrESbwwBnKGcUB/zAA=; b=OMslnKvmAjDoKlhg6em2dj99WB
	AJXmAgy+mGNeh2s7JVGXQvRFFCHQFMXXWWYH8sU/FeR/uHsl4L36Q7ZYCIs8g0etBqKBYcC+vx8uC
	PdwTVUuTCZRIfnKw0HMeTvQFrcYeaXrpiqKE6aepLDP87VqZDY1WLRGdFNTvFNnvDF2sqMRKDYK+J
	xQMPQzjy539OKdwdHNTRo6U5dH1NI9V9CwRl9QwLhJkff2+uw6tKQ3meIt3ybwSWPRfLnfaVDxgz6
	um5VWIY3BhkaqpQX3NPuhTVV0EbFLM6k8kvcUGJtrifaxj322jiGDKzLMbCPSkOhVtTAklRh2nE5K
	lFQWOvVw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAq-0000000EQBK-2RU9;
	Mon, 08 Jun 2026 21:06:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/6] ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
Date: Mon,  8 Jun 2026 22:06:13 +0100
Message-ID: <20260608210618.3437216-4-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608210618.3437216-1-willy@infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes handle_bounds_compressed_page() on highmem memory
as page_address() does not work on memory which has been kmap_local(),
only on kmap() memory.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/compress.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index b279f38636d6..89067fecf5a0 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -108,16 +108,16 @@ static inline void handle_bounds_compressed_page(struct page *page,
 	loff_t pos = page_offset(page);
 
 	if ((pos >= initialized_size) && (initialized_size < i_size)) {
-		u8 *kp = page_address(page);
-		unsigned int kp_ofs;
+		size_t offset;
 
 		ntfs_debug("Zeroing page region outside initialized size.");
-		if (pos >= initialized_size) {
-			clear_page(kp);
-			return;
-		}
-		kp_ofs = initialized_size & ~PAGE_MASK;
-		memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
+		if (pos >= initialized_size)
+			offset = 0;
+		else
+			offset = offset_in_page(initialized_size);
+		zero_user_segment(page, offset, PAGE_SIZE);
+	} else {
+		flush_dcache_page(page);
 	}
 }
 
@@ -222,7 +222,6 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 				 */
 				handle_bounds_compressed_page(dp, i_size,
 						initialized_size);
-				flush_dcache_page(dp);
 				kunmap_local(page_address(dp));
 				SetPageUptodate(dp);
 				unlock_page(dp);
@@ -758,7 +757,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 				 */
 				handle_bounds_compressed_page(page, i_size,
 						initialized_size);
-				flush_dcache_page(page);
 				kunmap_local(page_address(page));
 				SetPageUptodate(page);
 				unlock_page(page);
-- 
2.47.3

