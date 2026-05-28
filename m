Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869733FCB05
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989518; cv=none; b=ZVurslpIOyxOy6lKA432AbxUFW5DwqaIdDv7FMNlJyTvPB6VMvEb6zgEjLSVnm7W/aZX1DP1Kxwf5IXE1rvmt2qavSLZ1bzbgxhODkYkPEMarEdhcaRVmonoJrsgaF0q53vnpvDLp9H3ASENyvSptPPiwoUINPHoG5zWu/y5ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989518; c=relaxed/simple;
	bh=sWu79/Ldp4GZRCIwqnxWGI3J6zjwrhOKdMalFPWwJi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU2B3C4no6u8qgS+u3hbuMp7rHYMuJ0c9ut2Ocuc18Q+ns/o7UZBMud5MAEhhlxkKCCWpIByhNS+GhD8D7O0aWvJX0vIKZA/tgbeRciO6aGWx/lzy0y+VUM7k+8bfy2z4ydROguuQ5QDplRwF6z0PZzbA5HoSoPECgTKc4BDGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vE+Qjqr3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vE+Qjqr3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8vrXrzkw7auK4rniwyzr07O1MkAqbKy0xtNXF8roeFE=; b=vE+Qjqr35meac9PJCGEmF3LPcy
	k29soeeJ3CxCWyScoX7BYKXEbT3vSwf6BwJWnmhHNAl/CvY+M6j4x8w/KpV3nDzu8Im0qylNxi1aJ
	XN3TIEK2LjudzpeBeaQbEeaoFVDIUCprN/sfD5fGSTeKniFLajzuwyOJ6+qisSPUnDtF/gkwLwgMQ
	xLBIBETKbEOmgEX1J9/jGzJiH84A39jXnrUDWf2bbHZFxSE4JBtRm+4e4hOnpaE4TjMVPym1uRv7s
	sdiFq20uI/ivurd+b6g9ShNFoE6PfMr3vjxxmykU6LCnqmgQGuuypiMnhkviXH1RDWd0fjfO3ZhJU
	tUtuRWCA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaF-00000004aY2-39f7;
	Thu, 28 May 2026 17:31:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/34] buffer: Add bh_submit()
Date: Thu, 28 May 2026 18:31:15 +0100
Message-ID: <20260528173150.1093780-3-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528173150.1093780-1-willy@infradead.org>
References: <20260528173150.1093780-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bh_submit() takes a bio_end_io allowing users to avoid the indirect
function call through bh->b_end_io, and eventually allowing us to remove
bh->b_end_io.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 31 +++++++++++++++++++++++++++----
 include/linux/buffer_head.h |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d4e9a10d2a26..ea926963529e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1180,15 +1180,15 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
 }
 
-static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-		enum rw_hint write_hint, struct writeback_control *wbc)
+static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
+		enum rw_hint write_hint, struct writeback_control *wbc,
+		bio_end_io_t end_bio)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
 	struct bio *bio;
 
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
-	BUG_ON(!bh->b_end_io);
 	BUG_ON(buffer_delay(bh));
 	BUG_ON(buffer_unwritten(bh));
 
@@ -1213,7 +1213,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
 
-	bio->bi_end_io = end_bio_bh_io_sync;
+	bio->bi_end_io = end_bio;
 	bio->bi_private = bh;
 
 	/* Take care of bh's that straddle the end of the device */
@@ -1227,6 +1227,29 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	blk_crypto_submit_bio(bio);
 }
 
+static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
+			  enum rw_hint write_hint,
+			  struct writeback_control *wbc)
+{
+	BUG_ON(!bh->b_end_io);
+	__bh_submit(bh, opf, write_hint, wbc, end_bio_bh_io_sync);
+}
+
+/**
+ * bh_submit - Start I/O against a buffer head
+ * @bh: The buffer head to perform I/O on.
+ * @opf: Operation and flags for bio.
+ * @end_io: The routine to call when I/O has completed.
+ *
+ * If you need to do I/O on an individual bh (instead of allowing the
+ * page cache to do I/O on the folio that it is in), call this function.
+ */
+void bh_submit(struct buffer_head *bh, blk_opf_t opf, bio_end_io_t end_io)
+{
+	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_io);
+}
+EXPORT_SYMBOL(bh_submit);
+
 static struct buffer_head *__bread_slow(struct buffer_head *bh)
 {
 	lock_buffer(bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e4939e33b4b5..d59980e4adda 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -240,6 +240,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void submit_bh(blk_opf_t, struct buffer_head *);
+void bh_submit(struct buffer_head *, blk_opf_t, bio_end_io_t);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
-- 
2.47.3

