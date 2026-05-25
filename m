Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6983F8ED9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729591; cv=none; b=IiDDkaKnKaLz3ZiDbdCDqhN6Wi3BTyuSNmImN5s6wzD4h1fFxBIQjxA5BZavfrcMznh6IJJjavOswt6pjHtZCbAUIDdViO4acXtxSyZ9LnqIgSCati/Xn6zZ0zkn/a5P4GcW1vlVyXXCc9HKpEUSyRsMRypfQ2FdCzOjb9SyET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729591; c=relaxed/simple;
	bh=LE5UIFD/MXfENlB3JVA3QqxRts625zGi+CP0DevJfJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2OPqwjpkBzbcILV6RXDW//T7ifnJxtzbXM3l7tmWvKFCpiUPLfInaqKOSBzoVtMuGICOTTqxAVLTB1gp06fNs+qvlnRCpnwaTLDhhxElvAs2GOhlo4q7Fdl4DhQaM8GJ3h4pPqe7CQF83peOazDm+D87vHoZfQK7ezPDW2Sxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HimZDZ7k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HimZDZ7k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sluvMVx5bgy2v2/TBIj0C4AIzYBXNAkYC+cSTSZqR7Y=; b=HimZDZ7kjVZ9P4Asx1aVmqIphg
	TV18sB+MKJPkx3lCle5tFOg4LbiaZli8J/A7NA2PQlOfxVwOzKWihMaUPVR5as6Lg/ETaQjwBKDnY
	KOrtFFIX6pTbxNYuSSwyO4mjlkR3mz9MqjGkJPaAmHBYomCvyyhvXY/Q0UYImSmdFjBigSdwWOW3E
	HNJMawx1q9ZnzAEAdxxuDLbx0LXlCDJSESzhRHb/Yf+kjWGWfSPd6dGUAwFbNwoWHrM02mA6J/qgN
	oojyqkRMkvcJ3Nta8cQ0/xCFtoXv+z8Tbq7srsfiF5J+6QP1z4s50+S2f8iDQUSbKufQmpBxNN35T
	9I3sdwoA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxu-0000000HODa-0Dtb;
	Mon, 25 May 2026 17:19:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 32/34] buffer: Remove b_end_io
Date: Mon, 25 May 2026 18:19:25 +0100
Message-ID: <20260525171931.4144395-33-willy@infradead.org>
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
index dc16900455eb..f057d354b353 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -936,7 +936,6 @@ static sector_t folio_init_buffers(struct folio *folio,
 
 	do {
 		if (!buffer_mapped(bh)) {
-			bh->b_end_io = NULL;
 			bh->b_private = NULL;
 			bh->b_bdev = bdev;
 			bh->b_blocknr = block;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 0aa81fa768a6..634b0035d40a 100644
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

