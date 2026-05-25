Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3212FF147
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729584; cv=none; b=ioyj69Sb30bn9E2jnBwC985VHAvyQllyVktbeCv1yQYikM89x0/A91/WaYWj78ICvwcjBDMIu+8kUiTU2gaIkjRE8csd/IeQ64c/KORu9AXrtrOYsZaf9Z6O1wBCW/8j4wMsMdmDxazs8341C8QMrU0zdz5/RkEInDVF1yfFGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729584; c=relaxed/simple;
	bh=U3NjTlycJNsbylHgNw44oEM6/ct5WncLjOk8yC32tSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXhBZvc+zeGtx3nHlkN4wqonhb/j6HXJ0v/WC5XQbH30DF3pEkUuUU8QPoV2PBzhCyhqHFnd1I6Zyfim4oE8/1tXTNwd4zbunxLrnckLJ8qX7Z2V9cUq/im0HhZR8ScX074CbD5JHYEsu4PW/9Hej04SNh0a+A30mUt3MS2KrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S8w0nsNp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8w0nsNp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WVV78cjIHWFQXvI/HVxI4RO6azFjpo6VxljSH5rWZ3E=; b=S8w0nsNprST9Ylz+zxOfIlo9x1
	MbxsEVaHwoZrxSpz/sXoxJ05ZJHzAvGJxmCetKWMdBkpPYUVgVMeO44Q6Vf03ZV2ar/TMqoEPFW8E
	w6EbhiCauhzvonjtX1rsro+9igedSkuHurHOVvo5s6lqLq5Qnd/09Wwo7rE19xo+mAmBxVfNIUDqJ
	BtVMAXN4aMqdgMrtNDRH9aKizjsBAgrjkIRvxLyfzfbKlVOOSawqdeDYNqp6oN3JoRfNSBq7m1ZOm
	LLjfJgHqlMdg3+tnZq5DJ2RoE3O8I3LM6thkSCDCW15hFX1CazxKVdqvLugVmcv/T9JZ4CLOXLsmU
	xq9Q9apw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxo-0000000HO9q-0ZVd;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/34] buffer: Add bh_end_read(), bh_end_write() and bh_end_async_write()
Date: Mon, 25 May 2026 18:18:57 +0100
Message-ID: <20260525171931.4144395-5-willy@infradead.org>
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

These are the bio versions of end_buffer_read_sync(),
end_buffer_write_sync() and end_buffer_async_write().
Also add the helper function bio_endio_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 77 ++++++++++++++++++++++++++++++++++---
 include/linux/buffer_head.h |  6 +++
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4dcce64ef006..84ba0d892267 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -129,6 +129,29 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
 			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
 }
 
+/**
+ * bio_endio_bh - Return the bh for a bio
+ * @bio: The bio
+ *
+ * Call this in your bio_end_io handler to retrieve the buffer_head
+ * submitted in bh_submit().  If you did not call bh_submit(), do not
+ * call this function; it will return garbage.
+ *
+ * This function consumes the bio refcount which will probably free the
+ * bio.  You should retrieve the bi_status before calling this.
+ */
+struct buffer_head *bio_endio_bh(struct bio *bio)
+{
+	struct buffer_head *bh = bio->bi_private;
+
+	if (unlikely(bio_flagged(bio, BIO_QUIET)))
+		set_bit(BH_Quiet, &bh->b_state);
+	bio_put(bio);
+
+	return bh;
+}
+EXPORT_SYMBOL(bio_endio_bh);
+
 /*
  * End-of-IO handler helper function which does not touch the bh after
  * unlocking it.
@@ -159,6 +182,21 @@ void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
+/**
+ * bh_end_read - I/O end handler for reads
+ * @bio: The bio being completed.
+ *
+ * Pass this function to bh_submit() if you're reading to the buffer,
+ * unless you need your own special I/O end handler.
+ */
+void bh_end_read(struct bio *bio)
+{
+	bool uptodate = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio_endio_bh(bio);
+	end_buffer_read_sync(bh, uptodate);
+}
+EXPORT_SYMBOL(bh_end_read);
+
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
@@ -173,6 +211,21 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
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
+	bool success = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio_endio_bh(bio);
+	end_buffer_write_sync(bh, success);
+}
+EXPORT_SYMBOL(bh_end_write);
+
 static struct buffer_head *
 __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 {
@@ -416,6 +469,21 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
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
+	bool success = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio_endio_bh(bio);
+	end_buffer_async_write(bh, success);
+}
+EXPORT_SYMBOL(bh_end_async_write);
+
 /*
  * If a page's buffers are under async readin (end_buffer_async_read
  * completion) then there is a possibility that another thread of
@@ -1150,13 +1218,10 @@ EXPORT_SYMBOL(__bforget);
 
 static void end_bio_bh_io_sync(struct bio *bio)
 {
-	struct buffer_head *bh = bio->bi_private;
+	bool uptodate = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio_endio_bh(bio);
 
-	if (unlikely(bio_flagged(bio, BIO_QUIET)))
-		set_bit(BH_Quiet, &bh->b_state);
-
-	bh->b_end_io(bh, !bio->bi_status);
-	bio_put(bio);
+	bh->b_end_io(bh, uptodate);
 }
 
 static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d59980e4adda..e1594d30639b 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -204,6 +204,12 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
+struct buffer_head *bio_endio_bh(struct bio *bio);
+
+/* Completion routines suitable for passing to bh_submit() */
+void bh_end_read(struct bio *bio);
+void bh_end_write(struct bio *bio);
+void bh_end_async_write(struct bio *bio);
 
 /* Things to do with metadata buffers list */
 void mmb_mark_buffer_dirty(struct buffer_head *bh, struct mapping_metadata_bhs *mmb);
-- 
2.47.3

