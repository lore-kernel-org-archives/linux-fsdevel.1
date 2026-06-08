Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568537998B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952791; cv=none; b=qmaegxgai/6wwBzk0eaqFPsiH5u6RSkfSsmiN4tyyK+e4EPwFyZk1rjBtxAMI0eOSMWBq1vhFin4HXYzLBAkxwd1BFOK7+Dd9xC/aUCbGCw2CfTpUuEgYXoxYtHimad6Fhj6O4rZ5jXEBYlouegXu0KdhKQdZrwruNMyiLFVy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952791; c=relaxed/simple;
	bh=dhghiB6TrikkjDcRejvS8ngDp14Jxl1GYV+do/R4sWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=furp3rQdsQKMmtCSHD+1PGGxdVM1N3tt+yqMxwzQExEg9y+xt0rrzLcuMUaRbFTxVvH6HyNf+CNdmEGQ9iWjuS0kyxGVRECzgTVuktUoXdTKLZemAmP+kLINfgL3fjGdZCEmlAySdvDWlR8c+sMatfCKChjX9GaY/d4LippiNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eYvcnt5S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eYvcnt5S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8+ZuF2r2Oud129G1tEYJnRmLJ02jsFWuNiWcn1m32OU=; b=eYvcnt5S6kwXMOOa4EbrcNpxle
	gFABR7F2zxEDFHd5pl+olcRm2361wFpKa7DvNpB4yF0EzJxk69XuVhapbTSPqrB2yPGsWWLotDIof
	f8fl/LXQku8tXoSP9AQdf1EmVkiFjRJqrvqIWEbijWc+GApzR4J0VXDf5hhhHLZePvZPNYJGFfX3i
	LfdfJE1XTPDG8rU/a4HMykfbmbfnEBJIPbKK6EXsVRAwV6Mz+1qCOyPA069Nc8Eex+43PH43YTlow
	Ly0TdX5enMacJ6GOVKRpLgThZAi9ch//suhsB3XdfCGxuS9/P3e0a4yGegVTVv4griv37n16k70pI
	Xe6srkNw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAq-0000000EQBS-3Ec6;
	Mon, 08 Jun 2026 21:06:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 4/6] ntfs: Remove references to page->__folio_index
Date: Mon,  8 Jun 2026 22:06:14 +0100
Message-ID: <20260608210618.3437216-5-willy@infradead.org>
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
index 89067fecf5a0..eae0339a8518 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -455,14 +455,14 @@ int ntfs_read_compressed_block(struct folio *folio)
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
@@ -811,14 +811,16 @@ int ntfs_read_compressed_block(struct folio *folio)
 	for (cur_page = 0; cur_page < max_page; cur_page++) {
 		page = pages[cur_page];
 		if (page) {
+			folio = page_folio(page);
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

