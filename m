Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD343F7886
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729589; cv=none; b=ZqOpVG4b+T9jKhDcxzw65OzOsVC3Ovhhi3/h+FpvqRiri9S/8FNznmUjxcg/J1b9krrANx5IvW6m0GuQT4lcoYhODCanUDDIacH2qVXXJR42WVYsau/GNj5wz+nVL1Ny2gBjAOyjOYiL7md44yWKzle0yZFbE8KnrTl0EbtHX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729589; c=relaxed/simple;
	bh=APoxX+Rg+HVwywZfmYOTsAKnx5MODoE2V7a0rXgRUqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD+PC8Twi3qfn38wTH6990hZFNlvGi5kwg+X+QLRogBlnZRAJcBbp2B9BvPDKoQD7A4FnEeu52catB+9a15nfjJ1trFbQREl7n8eKeSlutuPi7gSFoKwKUstRX1YSwtIcDDaDbOXzHwClGb7otdsLUGbOiOhJcB+OfRiKAAwTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W2LnLqmn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2LnLqmn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=m9GZHmUKPomSCGUx5AAIBgEmEbae1tbf7uRgL6Cl5sk=; b=W2LnLqmnpTqeCCh1FhUFDNdBoK
	xnwHFCy2DrUNjj8mQk63Ktl89KMRYNC7zPn7BMRkrvQquiRpRIzE98J+2ReCN4UrkLnCKu5UCKfvP
	zM9TCEull0daKSLDNriwXe6n+7IKpxmXn1ATWCUYM7DRpu2X9j1YANNS4OY40yHe98pxvS1YAAFUY
	4RLbreINOzyYkRMpvvsIWHJlItReJWubsO0pI/QNtQeL+Nr27ZFX4n6StuSXel7vOzi0Ezd1ygVMv
	iKz1A7Tim5qoECDXPweYJP1j/ODGEGJGPswqb/UfCwTJaZ+dG7aDi5NHC1oaFUsxAp7b9iXi9nFPC
	3771IOcw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxs-0000000HOCn-3HdS;
	Mon, 25 May 2026 17:19:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/34] buffer: Remove mark_buffer_async_write()
Date: Mon, 25 May 2026 18:19:19 +0100
Message-ID: <20260525171931.4144395-27-willy@infradead.org>
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

There are no more callers of this function, so delete it.
end_buffer_async_write() then has only one caller left, so
inline it into bh_end_async_write().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 38 ++++++++++++-------------------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9199ac5d6154..60c2befb33a2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -428,12 +428,19 @@ static void bh_end_async_read(struct bio *bio)
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
+	bool success = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio_endio_bh(bio);
 	unsigned long flags;
 	struct buffer_head *first;
 	struct buffer_head *tmp;
@@ -442,7 +449,7 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	BUG_ON(!buffer_async_write(bh));
 
 	folio = bh->b_folio;
-	if (uptodate) {
+	if (success) {
 		set_buffer_uptodate(bh);
 	} else {
 		buffer_io_error(bh, ", lost async page write");
@@ -470,29 +477,8 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
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
-	bool success = bio->bi_status == BLK_STS_OK;
-	struct buffer_head *bh = bio_endio_bh(bio);
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
index e1594d30639b..c7566f21ba45 100644
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

