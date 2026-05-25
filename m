Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2F299931
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729584; cv=none; b=Nl3AcQlLViO7Pd06nGDqybxI0+jG6o8qLNN1d7g1tqJh3M3PbmSmYir1uIkiCC8CwVgO0NvBzBwfeE1gaCngMmi6zy6iEtxZfc8KlN7mn4cYpbetC8bLBqdFz0H+TUyND+Fn+zBp04YwjVFvynsk3PZxfc4i4OYYZQcet+H/hII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729584; c=relaxed/simple;
	bh=eOOxuVrjyppwp60mUByWFnOmBz7CiK5u4Ed9uPGibG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL/M2Jftaqj4tr/K5PjT1CVS5ZT3pEOwi6gh5vptjhdaZrCKXBPyujd95XvmQrdOW0m+h360d6zCwIYbC2oa6uoJJ0hZxlQD9g8sRnR7YYW+9KicEJO6T4gs31jYvnEwgFSyBCWFnyuzeTQmhzvUrjqJszBBMbxq9OYAI3Gjhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k4rRxDTL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4rRxDTL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jXWZDYcsQnoLx/mlwqhIsOXkNaEdbrmj951OzmW2zgQ=; b=k4rRxDTLE1wQAG0gAiPz4/Ps1O
	brQpAcMM16sJOUpKhBRUbjlvVn63p9cR6BQrIEgTkYPpSnxIdrx03CJLwvLv2Squ1vq/k6alEo+f/
	9vNYMadeZaNVcd5PVnjhCq8jA3sRvpBikkUdPLxCi3uAyaVyS6HONtL9IWNzG8jB+QyP/HXbiyN9B
	ug7c+7ZdEgQpU9uFtVRhbhCao8Zo0W9AX1B0kYhsR9CmEGhXMWI8rmbxb1cRZxVe82XKCLdBooepw
	+NCrYK/UXkF6MrxA7fy0CTWjHkc6uQvIA53wCX1yvzzS+qrV/nkqA5CzMqzXQ7o8D1R2GFD1cjxA3
	KtBQt+Dg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxp-0000000HOAc-0mWr;
	Mon, 25 May 2026 17:19:41 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/34] buffer: Convert block_read_full_folio to bh_submit()
Date: Mon, 25 May 2026 18:19:03 +0100
Message-ID: <20260525171931.4144395-11-willy@infradead.org>
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

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().  Since mark_buffer_async_read() would collapse to a single
function call, inline it into block_read_full_folio() along with its
extensive comment.  Convert end_buffer_async_read_io() to
bh_end_async_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 65 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 44b14f0642f4..92500060d834 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -392,11 +392,13 @@ static void decrypt_bh(struct work_struct *work)
 }
 
 /*
- * I/O completion handler for block_read_full_folio() - pages
+ * I/O completion handler for block_read_full_folio() - folios
  * which come unlocked at the end of I/O.
  */
-static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
+static void bh_end_async_read(struct bio *bio)
 {
+	bool uptodate = bio->bi_status == BLK_STS_OK;
+	struct buffer_head *bh = bio_endio_bh(bio);
 	struct inode *inode = bh->b_folio->mapping->host;
 	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
 	struct fsverity_info *vi = NULL;
@@ -421,7 +423,7 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 			}
 			return;
 		}
-		uptodate = 0;
+		uptodate = false;
 	}
 	end_buffer_async_read(bh, uptodate);
 }
@@ -484,33 +486,6 @@ void bh_end_async_write(struct bio *bio)
 }
 EXPORT_SYMBOL(bh_end_async_write);
 
-/*
- * If a page's buffers are under async readin (end_buffer_async_read
- * completion) then there is a possibility that another thread of
- * control could lock one of the buffers after it has completed
- * but while some of the other buffers have not completed.  This
- * locked buffer would confuse end_buffer_async_read() into not unlocking
- * the page.  So the absence of BH_Async_Read tells end_buffer_async_read()
- * that this buffer is not under async I/O.
- *
- * The page comes unlocked when it has no locked buffer_async buffers
- * left.
- *
- * PageLocked prevents anyone starting new async I/O reads any of
- * the buffers.
- *
- * PageWriteback is used to prevent simultaneous writeout of the same
- * page.
- *
- * PageLocked prevents anyone from starting writeback of a page which is
- * under read I/O (PageWriteback is only ever set against a locked page).
- */
-static void mark_buffer_async_read(struct buffer_head *bh)
-{
-	bh->b_end_io = end_buffer_async_read_io;
-	set_buffer_async_read(bh);
-}
-
 void mark_buffer_async_write(struct buffer_head *bh)
 {
 	bh->b_end_io = end_buffer_async_write;
@@ -2488,9 +2463,33 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 			continue;
 		}
 
-		mark_buffer_async_read(bh);
+		/*
+		 * If a folio's buffers are under async readin
+		 * (end_buffer_async_read completion) then there is a
+		 * possibility that another thread of control could lock
+		 * one of the buffers after it has completed but while
+		 * some of the other buffers have not completed.  This
+		 * locked buffer would confuse end_buffer_async_read()
+		 * into not unlocking the folio.  So the absence of
+		 * BH_Async_Read tells end_buffer_async_read() that this
+		 * buffer is not under async I/O.
+		 *
+		 * The folio comes unlocked when it has no locked
+		 * buffer_async buffers left.
+		 *
+		 * The folio lock prevents anyone starting new async
+		 * I/O reads any of the buffers.
+		 *
+		 * The writeback flag is used to prevent simultaneous
+		 * writeout of the same folio.
+		 *
+		 * The folio lock prevents anyone from starting writeback
+		 * of a folio which is under read I/O (the writeback
+		 * flag is only ever set on a locked folio).
+		 */
+		set_buffer_async_read(bh);
 		if (prev)
-			submit_bh(REQ_OP_READ, prev);
+			bh_submit(prev, REQ_OP_READ, bh_end_async_read);
 		prev = bh;
 	} while (iblock++, (bh = bh->b_this_page) != head);
 
@@ -2504,7 +2503,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	 * in this folio.
 	 */
 	if (prev)
-		submit_bh(REQ_OP_READ, prev);
+		bh_submit(prev, REQ_OP_READ, bh_end_async_read);
 	else
 		folio_end_read(folio, !page_error);
 
-- 
2.47.3

