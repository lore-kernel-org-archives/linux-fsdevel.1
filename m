Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D33FD955
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989523; cv=none; b=UU4IoRuznkttxG24/uDq9iPLSZl7XjibXWOmhh47QlFMT7sz2+5Xt/xKXlrW2q+/q3QYPwOjuhmDEB5K94bTeafWY7I0/A63qj+l4yvLH9mVlGgieP4hwtRWCaR4+bx6se8sxUKD9VYixwqTUSiKripHZydFoRDTlq97lVViTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989523; c=relaxed/simple;
	bh=AGiI3giCG7RxRRjQJhOT4T1RQbvOywWdHeAJTz9aAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+bIOsKGV00ZP4th1l7UTCq7+wWo4OqWiTCzS2XOpFhlzaIZyIAg0oXP6KByVAltcoA4LwFypcS3Oa1RaWqnEfZjUu2u++iqF0ZzNNY2+OR70gOFDCie381zR+iqFOer+QzY3wWg3nofO4zChv4KoNYXqYQKZlILIg1Akflf0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f5+Pyw6F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5+Pyw6F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=M+31+ZmvrmTI55uT5a4C6YGgiZcxhxPk5y63+RUgwWY=; b=f5+Pyw6FvR17CYj4EpIO8dLhwo
	bRERhraOZXKfKIuqNf86BkvrnQI8eiZ3P1wS8KddCl1HszwLKSUUGgPoNyRHixBq3KsL2JMumIJik
	9VfAEbG+RE5aag6TgtN16VQ+DDcQB2URFmPSg4aCkBu61tGjYRbItwgNnlxiLxNHlQprt3hhaE2E/
	HxDRUfiWmgXkHMECay89+ujpNNRdoGJX4g6vAWWyvffGNZBAwVP1ia/LlR+JkLXeAryNgTbcjd92d
	VrHlB+SojW++2cI+8k+yxmJVF6igL3ew0SnZeXu6K+HM21VMFAXbCTJ7pA97SLuzcVBB6WZKiPr0O
	nym/a7tg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaN-00000004ac4-1jhO;
	Thu, 28 May 2026 17:31:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 34/34] buffer: Remove end_buffer_write_sync()
Date: Thu, 28 May 2026 18:31:47 +0100
Message-ID: <20260528173150.1093780-35-willy@infradead.org>
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

It has no callers left, so delete it.  Inline __end_buffer_write_sync()
into bh_end_write().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 29 +++++++++--------------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index db604c0e54d4..7ed8dd77d221 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -192,25 +192,6 @@ void bh_end_read(struct bio *bio)
 }
 EXPORT_SYMBOL(bh_end_read);
 
-static void __end_buffer_write_sync(struct buffer_head *bh, int uptodate)
-{
-	if (uptodate) {
-		set_buffer_uptodate(bh);
-	} else {
-		buffer_io_error(bh, ", lost sync page write");
-		mark_buffer_write_io_error(bh);
-		clear_buffer_uptodate(bh);
-	}
-	unlock_buffer(bh);
-}
-
-void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
-{
-	__end_buffer_write_sync(bh, uptodate);
-	put_bh(bh);
-}
-EXPORT_SYMBOL(end_buffer_write_sync);
-
 /**
  * bh_end_write - I/O end handler for writes
  * @bio: The bio being completed.
@@ -222,7 +203,15 @@ void bh_end_write(struct bio *bio)
 {
 	struct buffer_head *bh;
 	bool success = bio_endio_bh(bio, &bh);
-	__end_buffer_write_sync(bh, success);
+
+	if (success) {
+		set_buffer_uptodate(bh);
+	} else {
+		buffer_io_error(bh, ", lost sync page write");
+		mark_buffer_write_io_error(bh);
+		clear_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 }
 EXPORT_SYMBOL(bh_end_write);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 1ee56c9f2327..8b23bc9a244c 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -201,7 +201,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size);
 struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
-void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp);
 
 /* Completion routines suitable for passing to bh_submit() */
-- 
2.47.3

