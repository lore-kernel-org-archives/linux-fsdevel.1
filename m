Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BF3FCB18
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989517; cv=none; b=MX7hNc2tP9IcERWpqbS/VFz9+IyO2M2NUlirXWXJyfI6BGZCVV0UTiFWxecQusRMeCyqYViIbcbYnEZE+AMtCjTDDHMUFATs+kp0QVwrHq01V3QvoCCAIOb5c7jfE+W7JSVfwZQUpaTtjD2s4xOFsocrCd4fzK7IFz83lc/m0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989517; c=relaxed/simple;
	bh=L05F5zGrxaI7W+NoeB5GQ8w/xrW8X4SJBTDVPriTM18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfWQ9+rV+4WDz9gS1Yvpa3lBQVTWbxKHdIbyj5SSab3vQA/lK7rqlsrgw3hsHOckNEOS4pWAen8usva87XY4mZ3IHRephkEXhz/XJ/gCw0q2i+d/MN68yubXnsI94STpqRFSUWw6YInJeMhlpbUTCQIAwDvmdE2tUChHVCo4sSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rWWARCo9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWWARCo9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Su+kF0gXujXLMwCe08rhb35W/m211nYtXnJL0EbGBj4=; b=rWWARCo97eCqFsuDdWJlY4zKCQ
	mbVMilpEoXKQp24gisWoqelgJ1m7cm+rK7lCZXE8TNDqpytrSwd8ADNoZwRe0kKqedEdaXZn4PMCm
	AROESGZfbQuGwbiyyI4+ZOXb3Nl89NyM0RlU3Usimt8v10iDax6hOvR/NborPO8t4lSHnKxFzVZ8q
	6yawVeXx/ZFWjJhTIiimGNiuMz03LgJor/8GlF7Al/SN5xfoFgBy3uQl7xs6fc9xxrTmuI2VZ6whU
	hHRQH5/QHT+FpmUoiwc0PRojjzTiGZ7FGM+ZrgWggBasHSkVEuHsbEb9TOkjL7COhUhwaju4/g2+5
	iJHgIiCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaG-00000004aYI-1PZZ;
	Thu, 28 May 2026 17:31:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/34] buffer: Add bh_end_read(), bh_end_write() and bh_end_async_write()
Date: Thu, 28 May 2026 18:31:17 +0100
Message-ID: <20260528173150.1093780-5-willy@infradead.org>
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

These are the bio_end_io_t versions of end_buffer_read_sync(),
end_buffer_write_sync() and end_buffer_async_write().  They do not
contain a put_bh() call as it is no longer necessary.

Also add the helper function bio_endio_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 89 ++++++++++++++++++++++++++++++++++---
 include/linux/buffer_head.h |  6 +++
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4dcce64ef006..e22a94afa385 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -129,6 +129,34 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
 			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
 }
 
+/**
+ * bio_endio_bh - Discard the bio used to submit a buffer.
+ * @bio: The bio.
+ * @bhp: Where to return the buffer_head.
+ *
+ * Call this in your bio_end_io handler to retrieve the buffer_head
+ * submitted in bh_submit().  If you did not call bh_submit(), do not
+ * call this function; it will return garbage.
+ *
+ * This function consumes the bio refcount which will probably free the
+ * bio.
+ *
+ * Return: True if the I/O succeeded.
+ */
+bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp)
+{
+	bool success = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio->bi_private;
+
+	if (unlikely(bio_flagged(bio, BIO_QUIET)))
+		set_bit(BH_Quiet, &bh->b_state);
+	bio_put(bio);
+
+	*bhp = bh;
+	return success;
+}
+EXPORT_SYMBOL(bio_endio_bh);
+
 /*
  * End-of-IO handler helper function which does not touch the bh after
  * unlocking it.
@@ -159,7 +187,22 @@ void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
-void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
+/**
+ * bh_end_read - I/O end handler for reads
+ * @bio: The bio being completed.
+ *
+ * Pass this function to bh_submit() if you're reading into the buffer,
+ * unless you need your own special I/O end handler.
+ */
+void bh_end_read(struct bio *bio)
+{
+	struct buffer_head *bh;
+	bool uptodate = bio_endio_bh(bio, &bh);
+	__end_buffer_read_notouch(bh, uptodate);
+}
+EXPORT_SYMBOL(bh_end_read);
+
+static void __end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
 		set_buffer_uptodate(bh);
@@ -169,10 +212,30 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
+}
+
+void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
+{
+	__end_buffer_write_sync(bh, uptodate);
 	put_bh(bh);
 }
 EXPORT_SYMBOL(end_buffer_write_sync);
 
+/**
+ * bh_end_write - I/O end handler for writes
+ * @bio: The bio being completed.
+ *
+ * Pass this function to bh_submit() if you're writing from the buffer,
+ * unless you need your own special I/O end handler.
+ */
+void bh_end_write(struct bio *bio)
+{
+	struct buffer_head *bh;
+	bool success = bio_endio_bh(bio, &bh);
+	__end_buffer_write_sync(bh, success);
+}
+EXPORT_SYMBOL(bh_end_write);
+
 static struct buffer_head *
 __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 {
@@ -416,6 +479,21 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 }
 
+/**
+ * bh_end_async_write - I/O end handler for async folio writes
+ * @bio: The bio being completed.
+ *
+ * Pass this function to bh_submit() if you're doing the equivalent of
+ * block_write_full_folio().
+ */
+void bh_end_async_write(struct bio *bio)
+{
+	struct buffer_head *bh;
+	bool success = bio_endio_bh(bio, &bh);
+	end_buffer_async_write(bh, success);
+}
+EXPORT_SYMBOL(bh_end_async_write);
+
 /*
  * If a page's buffers are under async readin (end_buffer_async_read
  * completion) then there is a possibility that another thread of
@@ -1150,13 +1228,10 @@ EXPORT_SYMBOL(__bforget);
 
 static void end_bio_bh_io_sync(struct bio *bio)
 {
-	struct buffer_head *bh = bio->bi_private;
-
-	if (unlikely(bio_flagged(bio, BIO_QUIET)))
-		set_bit(BH_Quiet, &bh->b_state);
+	struct buffer_head *bh;
+	bool uptodate = bio_endio_bh(bio, &bh);
 
-	bh->b_end_io(bh, !bio->bi_status);
-	bio_put(bio);
+	bh->b_end_io(bh, uptodate);
 }
 
 static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d59980e4adda..b0a31a90fa79 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -204,6 +204,12 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
+bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp);
+
+/* Completion routines suitable for passing to bh_submit() */
+void bh_end_read(struct bio *bio);
+void bh_end_write(struct bio *bio);
+void bh_end_async_write(struct bio *bio);
 
 /* Things to do with metadata buffers list */
 void mmb_mark_buffer_dirty(struct buffer_head *bh, struct mapping_metadata_bhs *mmb);
-- 
2.47.3

