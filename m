Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD563FF1D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989522; cv=none; b=QJQy2QTD3PZX9Mn9v0hroHRzoMaQd50MghYX7zhgCOy3gfQwMyLOv83NqdLS2t/vXJH+Eta1OBAm20ivp/n2UwAW0i9nv5DUigeX5D14vwCkQGCml36KFj02TR3De7eZ8sgS/R4aIiIPHPvpmyADRb3rwRAIqdV4rcmq832DkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989522; c=relaxed/simple;
	bh=J7FuKblTfvCzUBA86RWRJVW7lUej9GKEJdgjzX0glt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rql5qBcoUdS8xgEfcAABl8cnSXeoQG6z7x0gAMb+IlkR2os1q5qS1dA8e0UhyY2w3PG2yX/RU4b4j8n9OXx1+sY/pQQUyUJAJy7n6+ujSDhFM3ARNASMPAxAZZujrTmG+g3e/sdXulJ89OuM4pDVv3jgSgVnl5dQAX79J2CmozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GRQVHKp4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GRQVHKp4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bMTYWNPF9uwtdaK8iLHFyaQX3XKb7N44dbE9Vsjrkxo=; b=GRQVHKp4qdHOTOeMpYxpdOa48G
	+6BntKCrGW2P+jgl6HpdIBdq57KcUiAHXY51jpWucgX25l1K0R2MgHTtRgMu3j4e0SYUtUClhOGnk
	Q8Qro8jA+uLaATNM1EzuTgfx0EeW6PJLY8df9KIG/2syWay4xeRVtonv+DflqRbpNo0nKz7ktfSxc
	T+kQ586KF9WyqqQP2DKupvS6yT9cvo3IE4aYO+G8NtvdEzSnEmAu41fTKdouZTh8lAaA7uhfAqeM8
	nFiqYp9/WFNtlMHn7ogl5crMYKLJo4r3+w4NRln/hy+VC8xJc7Al3STlcE4N59hfNf9E1SkjusY8i
	Yapz3M+w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaM-00000004abk-3pd0;
	Thu, 28 May 2026 17:31:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 32/34] buffer: Remove b_end_io
Date: Thu, 28 May 2026 18:31:45 +0100
Message-ID: <20260528173150.1093780-33-willy@infradead.org>
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

This shrinks buffer_head by 8 bytes, letting us pack more buffer heads
per slab.  With a Debian config, it shrinks from 104 bytes to 96 bytes
which is 42 objects per 4KiB page rather than 39, a 7% reduction in the
amount of memory used.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 14 --------------
 drivers/md/raid5.h                    |  6 +++---
 fs/buffer.c                           |  1 -
 include/linux/buffer_head.h           |  4 +---
 4 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 8421ea21bd35..a27aca42fd85 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -416,20 +416,6 @@ lm_open_conflict	yes		no			no
 lm_breaker_timedout     yes             no                      no
 ======================	=============	=================	=========
 
-buffer_head
-===========
-
-prototypes::
-
-	void (*b_end_io)(struct buffer_head *bh, int uptodate);
-
-locking rules:
-
-called from interrupts. In other words, extreme care is needed here.
-bh is locked, but that's all warranties we have here. Currently only RAID1,
-highmem, fs/buffer.c, and fs/ntfs/aops.c are providing these. Block devices
-call this method upon the IO completion.
-
 block_device_operations
 =======================
 prototypes::
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 1c7b710fc9c1..1dfa60a41d91 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -38,7 +38,7 @@
  *  Clean -> Dirty  - on compute_parity to satisfy write/sync (RECONSTRUCT or RMW)
  *
  * The Want->Empty, Want->Clean, Dirty->Clean, transitions
- * all happen in b_end_io at interrupt time.
+ * all happen in end_io at interrupt time.
  * Each sets the Uptodate bit before releasing the Lock bit.
  * This leaves one multi-stage transition:
  *    Want->Dirty->Clean
@@ -64,7 +64,7 @@
  * together, but we are not guaranteed of that so we allow for more.
  *
  * If a buffer is on the read list when the associated cache buffer is
- * Uptodate, the data is copied into the read buffer and it's b_end_io
+ * Uptodate, the data is copied into the read buffer and it's end_io
  * routine is called.  This may happen in the end_request routine only
  * if the buffer has just successfully been read.  end_request should
  * remove the buffers from the list and then set the Uptodate bit on
@@ -76,7 +76,7 @@
  * into the cache buffer, which is then marked dirty, and moved onto a
  * third list, the written list (bh_written).  Once both the parity
  * block and the cached buffer are successfully written, any buffer on
- * a written list can be returned with b_end_io.
+ * a written list can be returned with end_io.
  *
  * The write list and read list both act as fifos.  The read list,
  * write list and written list are protected by the device_lock.
diff --git a/fs/buffer.c b/fs/buffer.c
index 3df0ea1a6342..ccda92920175 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -946,7 +946,6 @@ static sector_t folio_init_buffers(struct folio *folio,
 
 	do {
 		if (!buffer_mapped(bh)) {
-			bh->b_end_io = NULL;
 			bh->b_private = NULL;
 			bh->b_bdev = bdev;
 			bh->b_blocknr = block;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7629130d42c4..1ee56c9f2327 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -46,7 +46,6 @@ enum bh_state_bits {
 struct page;
 struct buffer_head;
 struct address_space;
-typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
 
 /*
  * Historically, a buffer_head was used to map a single block
@@ -70,8 +69,7 @@ struct buffer_head {
 	char *b_data;			/* pointer to data within the page */
 
 	struct block_device *b_bdev;
-	bh_end_io_t *b_end_io;		/* I/O completion */
- 	void *b_private;		/* reserved for b_end_io */
+	void *b_private;		/* reserved for bio_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
 	struct mapping_metadata_bhs *b_mmb; /* head of the list of metadata bhs
 					     * this buffer is associated with */
-- 
2.47.3

