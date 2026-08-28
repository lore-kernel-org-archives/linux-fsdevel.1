Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE173B5306
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950475; cv=none; b=NKk/GlAn+eTqaz0e6A8sfmyzqxflVuQAbPlrO7rtdV68U9KO1fhzBhlxYyGpbWGkJOzPU9p2+ow4MtDDvwCG2DksMU/4C991Dec9fSnlKBSl4TCFzp8FBZWaMhe4NqJIC6ef34OB6zGGhHzKCjST2BamBq5Ho0phh1cdL30jWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950475; c=relaxed/simple;
	bh=ikAY/5+2MZTKBEyPpNaJhY3I/7ziJG0yJdGDMJ5o/4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnF9t307u3cOr67Hg+KkO0bRndU4fRPIqGPe4RdZRG/azhiRfrOV4So1/p29GcwZzzWjPxyIZfWIs1p08SixPfBq0lQNBV/xrYe/mSTImfrlH9qOtSNSq7hsHiVFGsH/jI1eKPpuIr1a/Au/4CGbPAvSbs4YFD4FiUqvdh4rN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oaUlBp8l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oaUlBp8l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IFsJ7xPi90Bo1598+VEerKbe2qaeu1QNJFroIcW0tig=; b=oaUlBp8lnY2DMrcxpPbb8OyOEW
	LRlczqWx1sUfKw+m9HyVq6SL87bcnud8CEXwXKKQqnENSm3fQG7626JBc2Cdj8w9IDlmbasaQsVhb
	An46A3sAw+rQ2p/Thh7RGwXWL2h/kenML26yyiT8G+3JAZoWcX4ZcmDUYSwiNkBEiLGYwwGOQie/h
	9+ZhsoDYvZw59iHTwuiLKPkOCMLpdGDwVty54d9M/WIcofQ/l0pvMf8T4dsw4OILTAN0sRpG3409p
	q1RU1UyYlud/hUF2DoYlaV+D8H8KwaOdyqA+xq8ySXgqWaJdano80ECzdoHqSg20WvwqtS0UvrxM6
	sYa3bWJA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03ap-0000000FQsI-2Wv0;
	Fri, 28 Aug 2026 20:54:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] buffer: Document sb_bread(), sb_bread_unmovable() and sb_breadahead()
Date: Fri, 28 Aug 2026 21:54:23 +0100
Message-ID: <20260828205429.3678204-4-willy@infradead.org>
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

Add kernel-doc for these three functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 50 ++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index fd2c7115c054..1d55f7770cad 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -338,20 +338,58 @@ static inline void bforget(struct buffer_head *bh)
 		__bforget(bh);
 }
 
-static inline struct buffer_head *
-sb_bread(struct super_block *sb, sector_t block)
+/**
+ * sb_bread - Read a block.
+ * @sb: The superblock to read from.
+ * @block: Block number in units of block size.
+ *
+ * Read a specified block, and return the buffer head that refers
+ * to it.  The memory is allocated from the movable area so that it can
+ * be migrated.  The returned buffer head has its refcount increased.
+ * The caller should call brelse() when it has finished with the buffer.
+ *
+ * Context: May sleep waiting for I/O.
+ * Return: NULL if the block was unreadable.
+ */
+static inline
+struct buffer_head *sb_bread(struct super_block *sb, sector_t block)
 {
 	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
 }
 
-static inline struct buffer_head *
-sb_bread_unmovable(struct super_block *sb, sector_t block)
+/**
+ * sb_bread_unmovable - Read a block.
+ * @sb: The superblock to read from.
+ * @block: Block number in units of block size.
+ *
+ * Read a specified block, and return the buffer head that refers to it.
+ * The memory is allocated from the unmovable area so that pointers into
+ * it remain valid after compaction runs.  The returned buffer head has
+ * its refcount increased.  The caller should call brelse() when it has
+ * finished with the buffer.
+ *
+ * Context: May sleep waiting for I/O.
+ * Return: NULL if the block was unreadable.
+ */
+static inline
+struct buffer_head *sb_bread_unmovable(struct super_block *sb, sector_t block)
 {
 	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
 }
 
-static inline void
-sb_breadahead(struct super_block *sb, sector_t block)
+/**
+ * sb_breadahead - Start readahead.
+ * @sb: Superblock identifying the block device.
+ * @block: The block to read.
+ *
+ * Read this block.  The I/O will be flagged as being readahead rather
+ * than immediate read, but (unlike the page cache), surrounding blocks
+ * will not be read.
+ *
+ * Context: May sleep in order to allocate memory.
+ */
+static inline
+void sb_breadahead(struct super_block *sb, sector_t block)
 {
 	__breadahead(sb->s_bdev, block, sb->s_blocksize);
 }
-- 
2.47.3

