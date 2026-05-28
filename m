Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6126ED59
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989521; cv=none; b=Ns0XgwUYgoKlCgpmzhvZSRrj2yWILkI9hzA5DY8NRMGrfVrC3pebuTr+4JMt0Y1tAnJMaOpaR7UiMEqomXvw7NubdaC97cbhLtCKW9w5mWTybGw+lecwQuNEkmibk7g/eitfyNeV1XPx1yGQFf/bQW360+WNhDkEx2CMBRGs+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989521; c=relaxed/simple;
	bh=AS5Sno6vvGtOqSxZmvgh/8m1kYz7apmKkO49cndcsgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3qzIBDrApCH6JtUqV6yAmU5n1PQ0OgAZgeqDQHeM2mfH7/P/8Q33/gsCRf/QZ1S4ybKI+zW19JXAa2TaDm5iTJXlYYoru56VGY8kCvsUhWj5f/RmO1zBjNESVbk2AWIYJK5p+0pRAFdz0xksvnipsb5BajIQkjnewjEkkE/nf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+WDF8TP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+WDF8TP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dOV5Z9GhxbBmHuucpT+qJ0MWfy/gEQuJJPpXiaqUJm0=; b=X+WDF8TPFjFpd9Gn+4Ag2KVZYi
	/pS2T1laZS536K80JWjeLd8egHmQQCycOe51t0hX+c1IWUiBJ6U9JuLM6MoVROqporWwDKM5dQtIV
	WIcttyldq3hgUqURWw5dRlXawcpkynlQUB5Hb+smBdcAtvI8T0xKsB55ApJha65Ewaf/E1/QniQkw
	L12dHipJeJUhM5CDDRDMGtyGPK6vCoE6q4DNXvViMcJAssFup06lfBBlmZcwbUrzBR68ikDCxrs9/
	irsk3E3GHj+Jj+vVbTvbzOVsCJXXEvvejvWXc5alEylD39vDCYh+FCvan5Kuqenbsyfi7P/AUYE21
	2Ane8bSg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaL-00000004aas-1ehA;
	Thu, 28 May 2026 17:31:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 26/34] buffer: Remove mark_buffer_async_write()
Date: Thu, 28 May 2026 18:31:39 +0100
Message-ID: <20260528173150.1093780-27-willy@infradead.org>
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

There are no more callers of this function, so delete it.
end_buffer_async_write() then has only one caller left, so
inline it into bh_end_async_write().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 38 ++++++++++++-------------------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 50bcef50a4a4..d35f584a06f9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -438,12 +438,19 @@ static void bh_end_async_read(struct bio *bio)
 	end_buffer_async_read(bh, uptodate);
 }
 
-/*
- * Completion handler for block_write_full_folio() - folios which are unlocked
- * during I/O, and which have the writeback flag cleared upon I/O completion.
+/**
+ * bh_end_async_write - I/O end handler for async folio writes
+ * @bio: The bio being completed.
+ *
+ * Pass this function to bh_submit() if you're doing the equivalent of
+ * block_write_full_folio().  That is, the folio is unlocked, and will
+ * have its writeback flag cleared once all async write buffers have
+ * completed.
  */
-static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
+void bh_end_async_write(struct bio *bio)
 {
+	struct buffer_head *bh;
+	bool success = bio_endio_bh(bio, &bh);
 	unsigned long flags;
 	struct buffer_head *first;
 	struct buffer_head *tmp;
@@ -452,7 +459,7 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	BUG_ON(!buffer_async_write(bh));
 
 	folio = bh->b_folio;
-	if (uptodate) {
+	if (success) {
 		set_buffer_uptodate(bh);
 	} else {
 		buffer_io_error(bh, ", lost async page write");
@@ -480,29 +487,8 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 still_busy:
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 }
-
-/**
- * bh_end_async_write - I/O end handler for async folio writes
- * @bio: The bio being completed.
- *
- * Pass this function to bh_submit() if you're doing the equivalent of
- * block_write_full_folio().
- */
-void bh_end_async_write(struct bio *bio)
-{
-	struct buffer_head *bh;
-	bool success = bio_endio_bh(bio, &bh);
-	end_buffer_async_write(bh, success);
-}
 EXPORT_SYMBOL(bh_end_async_write);
 
-void mark_buffer_async_write(struct buffer_head *bh)
-{
-	bh->b_end_io = end_buffer_async_write;
-	set_buffer_async_write(bh);
-}
-EXPORT_SYMBOL(mark_buffer_async_write);
-
 
 /*
  * fs/buffer.c contains helper functions for buffer-backed address space's
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b0a31a90fa79..f0a9f3f05ac1 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -224,7 +224,6 @@ static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 	clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
 }
 
-void mark_buffer_async_write(struct buffer_head *bh);
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
-- 
2.47.3

