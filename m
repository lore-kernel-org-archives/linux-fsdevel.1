Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FE3F8EC6
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729590; cv=none; b=WR7sUDjV2CXaN+y4//VjEM4CaVL48tJCNhvyYHzePvRgiuryng11AFP/+UbOU/m+DlmRQcDMgI7RbyN68E0qEaHyBrER5yTTLsykej2VvG1rAOM6W+aYgSM7K6OE1K+0AhY5BSm8QLCA0V5Y87ZzynQpeNrVShYtJd3CGZ/Xvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729590; c=relaxed/simple;
	bh=Uxz8G3cpP5NFMwFIcBNjIZRy7sf+iFJppBONmiLBw3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rckGp2H6rElNh5pIfoTb4jIK/DsLGqhX6gsHJpS1sDECCahC5tcWu34hLXrWxGR1UdBSqJqVjmWrxt/GVwWb4Y9sDSEUTxQfdajSnUC5HncfHy1awhVx5iLmO4h1eVM/GbKKyV9o7sy4bG+ad0XVWKghWfmaEElTaqStaMkAu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=opsE1clC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opsE1clC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PrUB6vSEpQtiIEIqxd4jDCqX5ozM/jacGmD0Nppw4k8=; b=opsE1clC7pnl9MKTWJLdXoWrth
	IGwj5Mu2QqVQ1qxs/b7bAUrfs176r/m3OYadaer3m/rkWHyp9wZy1vPVllyKWJAw9BoQRiLs85pV2
	sIiEtyqoBtaFQ2FC4JwB9q28nXnPoIevu5vV95gIC6YxsbBHbyBzuowqA1aV5VbgVFG3q48kWyOm5
	GyZ0wEfZ/4A70oKHmF4gzPzbOcAj64NgIp6EK654VFSi/NBB+rJqZzTcrrIwGpofiv+p3F5iURO6h
	qLeReOnQLjE+fifQCuojeAB93DJfkGtlwyOa4IlZ8yr13/vrJc07y1APO8NSA6lEWnF2mgUj0ThBT
	4DQSOvEw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxt-0000000HODS-3gEE;
	Mon, 25 May 2026 17:19:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/34] buffer: Remove submit_bh()
Date: Mon, 25 May 2026 18:19:24 +0100
Message-ID: <20260525171931.4144395-32-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525171931.4144395-1-willy@infradead.org>
References: <20260525171931.4144395-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No users are left; remove this API.  Also remove/fix comments mentioning
it, and end_bio_bh_io_sync() as it's now unused.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/trace/ftrace.rst |  4 ++--
 fs/buffer.c                    | 27 ++++++---------------------
 include/linux/buffer_head.h    |  3 +--
 mm/vmscan.c                    |  2 +-
 4 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index b9efb148a5c2..2ed1b96e440b 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1624,7 +1624,7 @@ function-trace, we get a much larger output::
    => blk_queue_bio
    => submit_bio_noacct
    => submit_bio
-   => submit_bh
+   => bh_submit
    => __ext3_get_inode_loc
    => ext3_iget
    => ext3_lookup
@@ -1909,7 +1909,7 @@ tracers.
    => blk_queue_bio
    => submit_bio_noacct
    => submit_bio
-   => submit_bh
+   => bh_submit
    => ext3_bread
    => ext3_dir_bread
    => htree_dirblock_to_tree
diff --git a/fs/buffer.c b/fs/buffer.c
index 60c2befb33a2..dc16900455eb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1177,14 +1177,6 @@ void __bforget(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(__bforget);
 
-static void end_bio_bh_io_sync(struct bio *bio)
-{
-	bool uptodate = bio->bi_status == BLK_STS_OK;
-	struct buffer_head *bh = bio_endio_bh(bio);
-
-	bh->b_end_io(bh, uptodate);
-}
-
 static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 				  gfp_t gfp_mask)
 {
@@ -1820,15 +1812,15 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
 
 /*
  * While block_write_full_folio is writing back the dirty buffers under
- * the page lock, whoever dirtied the buffers may decide to clean them
+ * the folio lock, whoever dirtied the buffers may decide to clean them
  * again at any time.  We handle that by only looking at the buffer
  * state inside lock_buffer().
  *
  * If block_write_full_folio() is called for regular writeback
- * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a page which has a
- * locked buffer.   This only can happen if someone has written the buffer
- * directly, with submit_bh().  At the address_space level PageWriteback
- * prevents this contention from occurring.
+ * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a folio which
+ * has a locked buffer.   This only can happen if someone has written
+ * the buffer directly, with bh_submit().  At the address_space level
+ * the folio writeback flag prevents this contention from occurring.
  *
  * If block_write_full_folio() is called with wbc->sync_mode ==
  * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
@@ -1945,7 +1937,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		/*
 		 * The folio was marked dirty, but the buffers were
 		 * clean.  Someone wrote them back by hand with
-		 * write_dirty_buffer/submit_bh.  A rare case.
+		 * write_dirty_buffer/bh_submit.  A rare case.
 		 */
 		folio_end_writeback(folio);
 
@@ -2791,13 +2783,6 @@ sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
 }
 EXPORT_SYMBOL(generic_block_bmap);
 
-void submit_bh(blk_opf_t opf, struct buffer_head *bh)
-{
-	BUG_ON(!bh->b_end_io);
-	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_bio_bh_io_sync);
-}
-EXPORT_SYMBOL(submit_bh);
-
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
 	lock_buffer(bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index c7566f21ba45..0aa81fa768a6 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -55,7 +55,7 @@ typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
  * is the bio, and buffer_heads are used for extracting block
  * mappings (via a get_block_t call), for tracking state within
  * a folio (via a folio_mapping) and for wrapping bio submission
- * for backward compatibility reasons (e.g. submit_bh).
+ * for backward compatibility reasons (e.g. bh_submit).
  */
 struct buffer_head {
 	unsigned long b_state;		/* buffer state bitmap (see above) */
@@ -244,7 +244,6 @@ void __lock_buffer(struct buffer_head *bh);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
-void submit_bh(blk_opf_t, struct buffer_head *);
 void bh_submit(struct buffer_head *, blk_opf_t, bio_end_io_t);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd1b1aa12581..67231d3189ef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1449,7 +1449,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * is possible for a folio to have the dirty flag set,
 		 * but it is actually clean (all its buffers are clean).
 		 * This happens if the buffers were written out directly,
-		 * with submit_bh(). ext3 will do this, as well as
+		 * with bh_submit(). ext3 will do this, as well as
 		 * the blockdev mapping.  filemap_release_folio() will
 		 * discover that cleanness and will drop the buffers
 		 * and mark the folio clean - it can be freed.
-- 
2.47.3

