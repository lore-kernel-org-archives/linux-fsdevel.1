Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A9369D79
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341998; cv=none; b=fiOed3DKguGCOurvLInQgqMGsPahYPrwE/hFAAhHRIqL+4httoiqMThUHt2NJR4E49F57Bc+SPAbMBZnLM/3Ul/iJCP43Kv3zwZJir8/jiYmn43CZ+Qt6y3biA1SEMAWYFxM8o1mG1cEsA2ywv24Uh5Jvdp5hZccOupAE1X4N14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341998; c=relaxed/simple;
	bh=K0llTqaCvJh1P5FB1H74ZzJfoCcY/MH4vWldsKQjxI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkhneTosrxl8MulwY/+dX9cgUlBAzsoW4dAP4JB6mEo65LNhftnRLKh/l2A3dgO7sX2sZXgrL4oEkUayBBw4QnRn09cdsb8N7ws39JJwyHhnFKALy/GCDMW7Vt68vQLvKXzN1yDyFzfZOjJvc/F9KZnIQHn1I15aNczSV2d+HDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RDwq7RFT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RDwq7RFT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xE7nz6y5yTk+D+hCyFyD22HvbRBiBxqKUhasX87Gfew=; b=RDwq7RFTQuC1k+DOq8Lb69tdOd
	It3yfTDUq6MHftcRJ0y0CM/kcAcBN1LoeyT6Fs/1d7EBEf+s40PkjQirRdP7Y0Sc4gxcx8a1a8w40
	5Tvk0UC7s/y9b+rqwMvSqoH2Q5yBVWMPhEFFcxS9qLa42aH5KC4MD3WbujrjSpglSVAqqXCp2ovj/
	iwviQBPhwSI98vIkze0RR4eJoSqUDTdrdtYHFgCAHzGPXkODf9wEmjCp5imlOqT/+MLoJ6QAAkMVF
	0kpz8spr488iIT+urQWV4MCaj0xmwJ/EBQiJmQOebw8G3zLoOX6UoQfw7crEbMvzf43pV0vz5mST6
	aengo4CA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8HL-00000000dEW-3wV8;
	Mon, 01 Jun 2026 19:26:27 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 1/3] ntfs: Correct use of folios in handle_bounds_compressed_page()
Date: Mon,  1 Jun 2026 20:26:20 +0100
Message-ID: <20260601192626.150804-2-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601192626.150804-1-willy@infradead.org>
References: <20260601192626.150804-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline zero_partial_compressed_page() into its one caller, remove accesses
to page->__folio_index, fix highmem (page_address() does not work with
kmap_local()), switch to using zero_user_segment() which includes the
call to flush_dcache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 495e90fa3348 (ntfs: update attrib operations)
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806b41ed..143f362a42f5 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -96,26 +96,6 @@ void free_compression_buffers(void)
 	mutex_unlock(&ntfs_cb_lock);
 }
 
-/*
- * zero_partial_compressed_page - zero out of bounds compressed page region
- * @page: page to zero
- * @initialized_size: initialized size of the attribute
- */
-static void zero_partial_compressed_page(struct page *page,
-		const s64 initialized_size)
-{
-	u8 *kp = page_address(page);
-	unsigned int kp_ofs;
-
-	ntfs_debug("Zeroing page region outside initialized size.");
-	if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
-		clear_page(kp);
-		return;
-	}
-	kp_ofs = initialized_size & ~PAGE_MASK;
-	memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
-}
-
 /*
  * handle_bounds_compressed_page - test for&handle out of bounds compressed page
  * @page: page to check and handle
@@ -125,9 +105,21 @@ static void zero_partial_compressed_page(struct page *page,
 static inline void handle_bounds_compressed_page(struct page *page,
 		const loff_t i_size, const s64 initialized_size)
 {
-	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
-			(initialized_size < i_size))
-		zero_partial_compressed_page(page, initialized_size);
+	const struct folio *folio = page_folio(page);
+	pgoff_t page_index = page_pgoff(folio, page);
+	size_t offset;
+
+	if ((page_index < (initialized_size >> PAGE_SHIFT)) ||
+			(initialized_size >= i_size))
+		return;
+
+	ntfs_debug("Zeroing page region outside initialized size.");
+	if (((loff_t)page_index << PAGE_SHIFT) >= initialized_size)
+		offset = 0;
+	else
+		offset = initialized_size & ~PAGE_MASK;
+
+	zero_user_segment(page, offset, PAGE_SIZE);
 }
 
 /*
@@ -231,7 +223,6 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 				 */
 				handle_bounds_compressed_page(dp, i_size,
 						initialized_size);
-				flush_dcache_page(dp);
 				kunmap_local(page_address(dp));
 				SetPageUptodate(dp);
 				unlock_page(dp);
@@ -767,7 +758,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 				 */
 				handle_bounds_compressed_page(page, i_size,
 						initialized_size);
-				flush_dcache_page(page);
 				kunmap_local(page_address(page));
 				SetPageUptodate(page);
 				unlock_page(page);
-- 
2.47.3

