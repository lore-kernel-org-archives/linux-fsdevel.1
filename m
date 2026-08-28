Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963103CA49C
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950476; cv=none; b=p0Ge/pfnq+XhguBC7LgugHqTBGjRPm/TXOKt8YEhnIxHRS4qINCyvPxKFKCQd9iSETw47wwkqc2r/JwH6ODlcMJs3a7+rW+pSqL/y9Gt1w/DPAi4/dUKGaAlqAXMb55vlULi+CITqfoAWTKjsVHAWDG4Cx1qfKtHe2cmYsI69MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950476; c=relaxed/simple;
	bh=I41XJk677ha6SQhTXqGTTvVL88GMAVX0LdmEXK6HvaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU+7XBOnkY+Ljy44liUiRMqK4OmZdVo2/uuPG2bZf5FaePj+K/LE7yLvyH0RBMvlH/DZu6yAF1i0BM99a87aaA/gg+b6dKbNtF0oQq/DGB6nIgiLXQgvYjdXMampl4zO95cQCr4Jo2TdYVDTy0tUe8uwjbOlPDr8RWMyOpp/+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RUzx8kJk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RUzx8kJk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=198rrRsIbvdydsGSFwZT3pBNGqhLLPFlXgRtGQn3Z5U=; b=RUzx8kJkdp/ghArBaIzZeMjWx6
	aE6piHPxQdttL6L99fDz4QszXzdW5m/WKsX8RHWdbx3aH9/R6SAq7uvckD3RPdYvREPT6cDT58+72
	ppr73K/iUjZSZfiUZKBOZ9Fp+gdCAtMwaCzXCHzT7PRoZSh32Ojdt6GEdkagoKS222uqxRsS9zDzl
	HpaxVJoyRzzjungObOOC59bb8rN9UinceQ6Ek6weMZWLx3XOfQjWAcYItqGwfM55QacWjn827jeVx
	A16izDdhRsy2uqTvZButo8SpJD3jnmRWE/LHjpSFVckV5TM9ekO1x7rQgjdkzu+Ly9P0NuzUjqQ6b
	K1uqxCtw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03aq-0000000FQsa-1HKo;
	Fri, 28 Aug 2026 20:54:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/6] buffer: Refer to folios in comments
Date: Fri, 28 Aug 2026 21:54:25 +0100
Message-ID: <20260828205429.3678204-6-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828205429.3678204-1-willy@infradead.org>
References: <20260828205429.3678204-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update some comments which mention pages to refer to folios instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 69 ++++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96bccff5688c..9b4e462903a1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -265,7 +265,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	/* we might be here because some of the buffers on this page are
+	/* we might be here because some of the buffers on this folio are
 	 * not mapped.  This is due to various races between
 	 * file io on the block device and getblk.  It gets dealt with
 	 * elsewhere, don't buffer_error if we had some unmapped buffers
@@ -311,7 +311,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	/*
 	 * Be _very_ careful from here on. Bad things can happen if
 	 * two buffer heads end IO at almost the same time and both
-	 * decide that the page is now completely done.
+	 * decide that the folio is now completely done.
 	 */
 	first = folio_buffers(folio);
 	spin_lock_irqsave(&first->b_uptodate_lock, flags);
@@ -694,7 +694,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 		} while (bh != head);
 	}
 	/*
-	 * Lock out page's memcg migration to keep PageDirty
+	 * Lock out folio's memcg migration to keep folio dirty flag
 	 * synchronized with per-memcg dirty page counters.
 	 */
 	newly_dirty = !folio_test_set_dirty(folio);
@@ -960,23 +960,23 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 }
 
 /*
- * The relationship between dirty buffers and dirty pages:
+ * The relationship between dirty buffers and dirty folios:
  *
- * Whenever a page has any dirty buffers, the page's dirty bit is set, and
- * the page is tagged dirty in the page cache.
+ * Whenever a folio has any dirty buffers, the folio's dirty flag is set, and
+ * the folio is tagged dirty in the page cache.
  *
  * At all times, the dirtiness of the buffers represents the dirtiness of
- * subsections of the page.  If the page has buffers, the page dirty bit is
+ * subsections of the folio.  If the folio has buffers, the folio dirty flag is
  * merely a hint about the true dirty state.
  *
- * When a page is set dirty in its entirety, all its buffers are marked dirty
- * (if the page has buffers).
+ * When a folio is set dirty in its entirety, all its buffers are marked dirty
+ * (if the folio has buffers).
  *
- * When a buffer is marked dirty, its page is dirtied, but the page's other
+ * When a buffer is marked dirty, its folio is dirtied, but the folio's other
  * buffers are not.
  *
  * Also.  When blockdev buffers are explicitly read with bread(), they
- * individually become uptodate.  But their backing page remains not
+ * individually become uptodate.  But their backing folio remains not
  * uptodate - even if all of its buffers are uptodate.  A subsequent
  * block_read_full_folio() against that folio will discover all the uptodate
  * buffers, will set the folio uptodate and will perform no I/O.
@@ -987,7 +987,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
  * @bh: the buffer_head to mark dirty
  *
  * mark_buffer_dirty() will set the dirty bit against the buffer, then set
- * its backing page dirty, then tag the page as dirty in the page cache
+ * its backing folio dirty, then tag the folio as dirty in the page cache
  * and then attach the address_space's inode to its superblock's dirty
  * inode list.
  *
@@ -1082,7 +1082,7 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 
 	/*
 	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
-	 * for a non-pagecache page.  fscrypt doesn't care about these.
+	 * for a non-pagecache folio.  fscrypt doesn't care about these.
 	 */
 	if (!mapping)
 		return;
@@ -1224,7 +1224,7 @@ static void bh_lru_install(struct buffer_head *bh)
 
 	/*
 	 * the refcount of buffer_head in bh_lru prevents dropping the
-	 * attached page(i.e., try_to_free_buffers) so it could cause
+	 * attached folio (i.e., try_to_free_buffers) so it could cause
 	 * failing page migration.
 	 * Skip putting upcoming bh into bh_lru until migration is done.
 	 */
@@ -1288,7 +1288,7 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * Perform a pagecache lookup for the matching buffer.  If it's there, refresh
  * it in the LRU and mark it as accessed.  If it is not present then return
  * NULL. Atomic context callers may also return NULL if the buffer is being
- * migrated; similarly the page is not marked accessed either.
+ * migrated; similarly the folio is not marked accessed either.
  */
 static struct buffer_head *
 find_get_block_common(struct block_device *bdev, sector_t block,
@@ -1297,7 +1297,7 @@ find_get_block_common(struct block_device *bdev, sector_t block,
 	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
 
 	if (bh == NULL) {
-		/* __find_get_block_slow will mark the page accessed */
+		/* __find_get_block_slow will mark the folio accessed */
 		bh = __find_get_block_slow(bdev, block, atomic);
 		if (bh)
 			bh_lru_install(bh);
@@ -1483,15 +1483,14 @@ void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 }
 EXPORT_SYMBOL(folio_set_bh);
 
-/*
- * Called when truncating a buffer on a page completely.
- */
-
 /* Bits that are cleared during an invalidate */
 #define BUFFER_FLAGS_DISCARD \
 	(1 << BH_Mapped | 1 << BH_New | 1 << BH_Req | \
 	 1 << BH_Delay | 1 << BH_Unwritten)
 
+/*
+ * Called when truncating a buffer on a folio completely.
+ */
 static void discard_buffer(struct buffer_head * bh)
 {
 	unsigned long b_state;
@@ -1716,7 +1715,7 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
  *
  * If block_write_full_folio() is called for regular writeback
  * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a folio which
- * has a locked buffer.   This only can happen if someone has written
+ * has a locked buffer.   This can only happen if someone has written
  * the buffer directly, with bh_submit().  At the address_space level
  * the folio writeback flag prevents this contention from occurring.
  *
@@ -2219,9 +2218,9 @@ int generic_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
 	/*
-	 * Don't mark the inode dirty under page lock. First, it unnecessarily
-	 * makes the holding time of page lock longer. Second, it forces lock
-	 * ordering of page lock and transaction start for journaling
+	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
+	 * makes the holding time of folio lock longer. Second, it forces lock
+	 * ordering of folio lock and transaction start for journaling
 	 * filesystems.
 	 */
 	if (i_size_changed)
@@ -2347,7 +2346,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		 * BH_Async_Read tells end_buffer_async_read() that this
 		 * buffer is not under async I/O.
 		 *
-		 * The folio comes unlocked when it has no locked
+		 * The folio is unlocked when it has no locked
 		 * buffer_async buffers left.
 		 *
 		 * The folio lock prevents anyone starting new async
@@ -2457,7 +2456,7 @@ static int cont_expand_zero(const struct kiocb *iocb,
 		}
 	}
 
-	/* page covers the boundary, find the boundary offset */
+	/* folio crosses the boundary, find the boundary offset */
 	if (index == curidx) {
 		zerofrom = curpos & ~PAGE_MASK;
 		/* if we will expand the thing last block will be filled */
@@ -2515,18 +2514,18 @@ EXPORT_SYMBOL(cont_write_begin);
 
 /*
  * block_page_mkwrite() is not allowed to change the file size as it gets
- * called from a page fault handler when a page is first dirtied. Hence we must
- * be careful to check for EOF conditions here. We set the page up correctly
- * for a written page which means we get ENOSPC checking when writing into
+ * called from a page fault handler when a folio is first dirtied. Hence we must
+ * be careful to check for EOF conditions here. We set the folio up correctly
+ * for a written folio which means we get ENOSPC checking when writing into
  * holes and correct delalloc and unwritten extent mapping on filesystems that
  * support these features.
  *
  * We are not allowed to take the i_rwsem here so we have to play games to
- * protect against truncate races as the page could now be beyond EOF.  Because
- * truncate writes the inode size before removing pages, once we have the
- * page lock we can determine safely if the page is beyond EOF. If it is not
- * beyond EOF, then the page is guaranteed safe against truncation until we
- * unlock the page.
+ * protect against truncate races as the folio could now be beyond EOF.  Because
+ * truncate writes the inode size before removing folios, once we have the
+ * folio lock we can determine safely if the folio is beyond EOF. If it is not
+ * beyond EOF, then the folio is guaranteed safe against truncation until we
+ * unlock the folio.
  *
  * Direct callers of this function should protect against filesystem freezing
  * using sb_start_pagefault() - sb_end_pagefault() functions.
@@ -2544,7 +2543,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 	size = i_size_read(inode);
 	if ((folio->mapping != inode->i_mapping) ||
 	    (folio_pos(folio) >= size)) {
-		/* We overload EFAULT to mean page got truncated */
+		/* We overload EFAULT to mean folio got truncated */
 		ret = -EFAULT;
 		goto out_unlock;
 	}
-- 
2.47.3

