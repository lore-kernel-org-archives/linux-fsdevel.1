Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF837C11B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341994; cv=none; b=dnDYEvrRhol4UV+aCyUfZS4O1Gpqf2ECL/fi9kMU5pHzjrpxHfUE9DIBnYQw8P7O4CUNWEqzzP+YHlm+WphT1WT8fJDEb+lnbaGvPwPMABwUx9+hmGIF336AasOxzshvgRaTa5TuyEMyucv1JCK27pCR3cJDGFfXFzwoIk21c0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341994; c=relaxed/simple;
	bh=0Q8QnvWlWToVCJHp26HZCnqXs+krxcGHFW5T8+kBAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaruJ9y+cmMgSnHW7/S21763wz1T9bWG+1xhpvF5ikXBdlGTT6G5oS/zyLhjgkcUNiIZkV2ontn/WlY28ByfpYxTneEBF7yYXNINyKIYL8eZ4na+c0FWSh3qIuelVHXrLzXsJyBYzxU8BRLnTBErD2CXJNFbNDVMnha9Ruxo7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DpG1jwm2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DpG1jwm2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HuAHwFgxQTl/6u/qT6//YvieKzXrnJyvSaoUGnMavJo=; b=DpG1jwm2UYMqqHqXLHMEKJ5M4b
	wwlvLajwdRr2b1i8oK2RYr6lfgH3sbxBVgHtCeGNaEenq4xz8rdDes15Tst8xrV25t+7aMHBWbxTG
	OnvOU6c3JPKgx3fql1s3iT5wlzulqA3jM7ByKV9r7a5U6vLxhaJSZUdK013rpUBhbVJLX4hQI4kJD
	ri0XZmBDGdHxycjTF5b7CzbASEpFOmu4KtJAQmhf3Eq1nqdw5Sw7Z5MbJZ882jEG2v6qH1jQwCAA1
	Swd6yC7+cF+/JF/nWE1syl0Cy8cfq4FNudpg+V2Soytrvahj4IVWPdxYOlhfXW1XDKp9jLXd0OiEf
	iHwIfF5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8HM-00000000dEY-0Bv4;
	Mon, 01 Jun 2026 19:26:28 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 2/3] ntfs: Remove references to page->__folio_index
Date: Mon,  1 Jun 2026 20:26:21 +0100
Message-ID: <20260601192626.150804-3-willy@infradead.org>
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

Pages don't have indexes, folios have indexes.  Correct this in
ntfs_read_compressed_block() and also remove a use of page->mapping
while I'm in here.  Also convert the calls to unlock_page() and
flush_dcache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 495e90fa3348 (ntfs: update attrib operations)
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 143f362a42f5..096e00b967d7 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -456,14 +456,14 @@ int ntfs_read_compressed_block(struct folio *folio)
 	struct page *page = &folio->page;
 	loff_t i_size;
 	s64 initialized_size;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct ntfs_inode *ni = NTFS_I(mapping->host);
 	struct ntfs_volume *vol = ni->vol;
 	struct super_block *sb = vol->sb;
 	struct runlist_element *rl;
 	unsigned long flags;
 	u8 *cb, *cb_pos, *cb_end;
-	unsigned long offset, index = page->__folio_index;
+	unsigned long offset, index = folio->index;
 	u32 cb_size = ni->itype.compressed.block_size;
 	u64 cb_size_mask = cb_size - 1UL;
 	s64 vcn;
@@ -812,14 +812,16 @@ int ntfs_read_compressed_block(struct folio *folio)
 	for (cur_page = 0; cur_page < max_page; cur_page++) {
 		page = pages[cur_page];
 		if (page) {
+			struct folio *folio = page_folio(page);
+
 			ntfs_error(vol->sb,
 				"Still have pages left! Terminating them with extreme prejudice.  Inode 0x%llx, page index 0x%lx.",
-				ni->mft_no, page->__folio_index);
-			flush_dcache_page(page);
+				ni->mft_no, folio->index);
+			flush_dcache_folio(folio);
 			kunmap_local(page_address(page));
-			unlock_page(page);
+			folio_unlock(folio);
 			if (cur_page != xpage)
-				put_page(page);
+				folio_put(folio);
 			pages[cur_page] = NULL;
 		}
 	}
-- 
2.47.3

