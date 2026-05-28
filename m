Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E53FF1D9
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989523; cv=none; b=RVozrhqRMSbV6nzYTmutQ6Oo9nJ/DD0Bgtd/HeHH9+sP9SLqYSn1zWw2qwjb190IXaE0uJ157H7U9kUpocXGgXLOtC1vdNp2VJIHzOKYbIAj9IcE3vAthq4MDZZDl+SNIWDRZfrAfCxpKsjlHKhZzLHgLXMfk704FyC4Rzlz3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989523; c=relaxed/simple;
	bh=stEh505biN28uWf3KDCW3G7MpaEM0WkDwJrRuZ2IHeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amWyffLWWlN/SIeC0q6+plx17CJZ/CraDt/qRMeeVPdTWm1psDyYROhRn9do2qfa4ZjgzF8IylNnI4dZKD6v2XdRQKGfMxLeSxYVOemUzu0QZ969QN1qdxWz3M30p19d5XCbWHdGy8lCUXXdveUPOs9H65zlxeBZ9oLxCqGaxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gW7TR9ce; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gW7TR9ce"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=icY8XnTWA652obgB1qQfuxH6nYGuRx7lUvFwdPVbl2A=; b=gW7TR9ceZBQqU0bLY4O4ijHJrw
	SQVF5Pwn/GhsOiz3YuDCfXf/EzA7+2knzbQoQhOQDeRM6IjgfEowokTYWhsAOg4xMjm3NAnabAg/l
	WhmxwdWu33BAK25V6TNZLabSxdS/U8Dbt1T22S0gD19wplknJhWFWjGtZTAx4LUjds/107l0V3gwe
	00UkEyTgdi7fKuofYf5oD1HjqpWvaeyWyTXHNgX0Lv2dIUhVFQCO0TTz63W8Hvwib/ZPO3zv1hirf
	bljBN6BKvdug8OLZ7tX1g0Cj8V44K54iLlXaSaKpvHP3XQzVRpCDxwdUMzAeg9SznvG0YlK73gtmO
	+V4szhIw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaN-00000004abu-0fmc;
	Thu, 28 May 2026 17:31:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 33/34] buffer: Change calling convention for end_buffer_read_sync()
Date: Thu, 28 May 2026 18:31:46 +0100
Message-ID: <20260528173150.1093780-34-willy@infradead.org>
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

Unify end_buffer_read_sync() and __end_buffer_read_notouch()
by requiring the caller put the refcount on the buffer.  The only caller
is in the gfs2_meta_read() path, and there we can put the refcount
after locking the buffer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c       | 28 +++++++++-------------------
 fs/gfs2/meta_io.c |  2 +-
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ccda92920175..db604c0e54d4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -157,15 +157,15 @@ bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp)
 }
 EXPORT_SYMBOL(bio_endio_bh);
 
-/*
- * End-of-IO handler helper function which does not touch the bh after
- * unlocking it.
- * Note: unlock_buffer() sort-of does touch the bh after unlocking it, but
- * a race there is benign: unlock_buffer() only use the bh's address for
- * hashing after unlocking the buffer, so it doesn't actually touch the bh
- * itself.
+/**
+ * end_buffer_read_sync - Handle buffer reads finishing
+ * @bh: The buffer.
+ * @uptodate: True if the read was successful.
+ *
+ * If a buffer is read through a mechanism that isn't bh_submit(), you
+ * can call this function to finish the read.
  */
-static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
+void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
 		set_buffer_uptodate(bh);
@@ -175,16 +175,6 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
 	}
 	unlock_buffer(bh);
 }
-
-/*
- * Default synchronous end-of-IO handler..  Just mark it up-to-date and
- * unlock the buffer.
- */
-void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
-{
-	put_bh(bh);
-	__end_buffer_read_notouch(bh, uptodate);
-}
 EXPORT_SYMBOL(end_buffer_read_sync);
 
 /**
@@ -198,7 +188,7 @@ void bh_end_read(struct bio *bio)
 {
 	struct buffer_head *bh;
 	bool uptodate = bio_endio_bh(bio, &bh);
-	__end_buffer_read_notouch(bh, uptodate);
+	end_buffer_read_sync(bh, uptodate);
 }
 EXPORT_SYMBOL(bh_end_read);
 
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 4895bb010cfb..a87cfbf0df38 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -286,10 +286,10 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		lock_buffer(bh);
 		if (buffer_uptodate(bh)) {
 			unlock_buffer(bh);
-			brelse(bh);
 		} else {
 			bhs[num++] = bh;
 		}
+		brelse(bh);
 	}
 
 	gfs2_submit_bhs(REQ_OP_READ | REQ_META | REQ_PRIO, bhs, num);
-- 
2.47.3

