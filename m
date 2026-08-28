Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679E358D27
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950475; cv=none; b=jBwlN2AY97gLHs+WaIAXmorn+Uy+cBYBQqd//QxiFNVCl99mfj8CONVA9hGjK4HI0A61TXVuZfPqMVoMXzKz1gg8orlMQL/LaxSqOIU8UEF0qUv//k1yjqB5NLqDpf1WmJrn7V/RhX8vWYPGFWa5ZpHm9OcPg2fRzj2a/5NBZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950475; c=relaxed/simple;
	bh=PJad5zXQUgnFRFRJmmsDthBAWAVrSI3l1TH/2gc3NUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWldmacM6zBfuFGkN/2t8K6vAJPhnqrnYdZ6PZewC4Kix7URjenSmwWztSiqbpM6YPWT1yjiJ26KznJNNe+ECUYFFt8qVsZo65xQ4TL0Le+BZDul+fc37cjfnQytADXoRfLSegQfc+qCJuJ9C4a4tzaaJZ7mRaXCJ9pgFkhyz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fg7Nc6F2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fg7Nc6F2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4crquprkbsA/DnTuL1hXmSbMrZzW0zoRxNFaIH0LYcc=; b=fg7Nc6F2X7QBo2ZvvT3Wa8YBXF
	ubue1nbbixB6ScCZAFBlGJ3PE8iktMNUPCC89L6lq54Sl4yh9SRA/yy3pqRPhVN34PxhCumGFqewu
	spsn7h4cQANAQxpXWpbaU954NPPR98KCR4WDnoBEA4hVzfQbjo/tVc/QNbNyC28aFu0SGi3/9v+GR
	npOVaNcSLupkL6H1bMQEFs3OqQ5eGzYsvPw/LfTNllirGRuoKq/6wdM1y22Vd74DLClIiYvSEBZn6
	EqtMaU9S8SYgZ1cgFXAIML4S4T4Nt7ramZKGG/HRc/o9vWfNcIgT40q6NYgZiT2UAH9zKLf3Ym7Dm
	iYQJh6Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03ap-0000000FQs9-0xpy;
	Fri, 28 Aug 2026 20:54:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] fs: Remove references to mark_buffer_dirty_inode()
Date: Fri, 28 Aug 2026 21:54:22 +0100
Message-ID: <20260828205429.3678204-3-willy@infradead.org>
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

Complete the removal of mark_buffer_dirty_inode() by changing all
references to it in the documentation to refer to mmb_mark_buffer_dirty()
instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/porting.rst | 2 +-
 fs/buffer.c                           | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 60880eb0c49d..de96b6745600 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -348,7 +348,7 @@ simply of return 1.  Note that all actual eviction work is done by caller after
 As before, clear_inode() must be called exactly once on each call of
 ->evict_inode() (as it used to be for each call of ->delete_inode()).  Unlike
 before, if you are using inode-associated metadata buffers (i.e.
-mark_buffer_dirty_inode()), it's your responsibility to call
+mmb_mark_buffer_dirty()), it's your responsibility to call
 invalidate_inode_buffers() before clear_inode().
 
 NOTE: checking i_nlink in the beginning of ->write_inode() and bailing out
diff --git a/fs/buffer.c b/fs/buffer.c
index 90ea52af042a..daf851ea9824 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -520,8 +520,8 @@ EXPORT_SYMBOL_GPL(mmb_has_buffers);
  *
  * Do this in two main stages: first we copy dirty buffers to a
  * temporary inode list, queueing the writes as we go. Then we clean
- * up, waiting for those writes to complete. mark_buffer_dirty_inode()
- * doesn't touch b_assoc_buffers list if b_mmb is not NULL so we are sure the
+ * up, waiting for those writes to complete. mmb_mark_buffer_dirty()
+ * doesn't touch b_assoc_buffers list if b_mmb is set so we are sure the
  * buffer stays on our list until IO completes (at which point it can be
  * reaped).
  */
@@ -542,7 +542,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
 		bh = BH_ENTRY(mmb->list.next);
 		WARN_ON_ONCE(bh->b_mmb != mmb);
 		__remove_assoc_queue(mmb, bh);
-		/* Avoid race with mark_buffer_dirty_inode() which does
+		/* Avoid race with mmb_mark_buffer_dirty() which does
 		 * a lockless check and we rely on seeing the dirty bit */
 		smp_mb();
 		if (buffer_dirty(bh) || buffer_locked(bh)) {
@@ -580,7 +580,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
 		bh = BH_ENTRY(tmp.prev);
 		get_bh(bh);
 		__remove_assoc_queue(mmb, bh);
-		/* Avoid race with mark_buffer_dirty_inode() which does
+		/* Avoid race with mmb_mark_buffer_dirty() which does
 		 * a lockless check and we rely on seeing the dirty bit */
 		smp_mb();
 		if (buffer_dirty(bh)) {
-- 
2.47.3

