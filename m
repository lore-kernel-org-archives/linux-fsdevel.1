Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E32D9787
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729584; cv=none; b=i900sc3Q65Po/NZ0BXtVWPXt8L25u692+Yzq9XPggZx+qGr8TcMDw1I2W1U3jMIM7wwIJ6p/UpbkhSRTbCdSML108maQBpeAZzUPU3xR8s80hLLA2URYPrcWv6+oY2b+K7IPptxYGkO2ykMCYsKsreAtp7C7WcWmEc+PvcjHhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729584; c=relaxed/simple;
	bh=aQiKgCbuloVxcamqM+fo7o+qXkAAyR7/QdYj239Rw1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTv+tMzE0FcqgTCk1EwM5t6nh8lyruWO2hUAsmhRU9rKfbMk0syrrOvn07jh8GY3uZAb6RnkrKvNOc+VTBD1eHnD6wi+zaZcJP5Fyc4/fiMDLEdBEbCdIoIoaL/gxil1Ue/njnXbfOyEoe1tE6yzizOfOlPevnmamGKx2Rx1piE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IBAUj/wD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBAUj/wD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eUjq74PHa7h6yuj+NJyoccO0FPLq1blYNj9lPyQz3UY=; b=IBAUj/wDkJTXpM1qgVp035PlKB
	RF35QN7WSze0/D8+f3cEzrl5X9HfjA4NrqXxks3K24lXzh14Wg68Ew1pYqGWR8RqjzLrFWb2seLVt
	1C014orEkKmrGC28SJ98PggEtRM0oHKnJaGyyVc9E+eY3SkoYGjNeb9ozO4HQUok+pEhNWzxZJbw5
	dAUJu/SW2c2ELCdw9jkuo0TZ/nOKtcGi9QD+2H/S7YXcg89E3xi2J2ualDqjVbeJTEW9HzRjgRfHi
	Kvx1HkEuvv3/l3qpjVkFe03fR7UJzbZAhQu5H3yYxXZm+PgtxauKDykQj+Ly9t9wAFAtm9nHskdUw
	L6JojyVg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxn-0000000HO9i-3qjM;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/34] buffer: Remove mark_buffer_async_write_endio()
Date: Mon, 25 May 2026 18:18:56 +0100
Message-ID: <20260525171931.4144395-4-willy@infradead.org>
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

All callers of mark_buffer_async_write_endio() pass
end_buffer_async_write, so we can inline mark_buffer_async_write_endio()
into mark_buffer_async_write() and just call that instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ea926963529e..4dcce64ef006 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -443,16 +443,10 @@ static void mark_buffer_async_read(struct buffer_head *bh)
 	set_buffer_async_read(bh);
 }
 
-static void mark_buffer_async_write_endio(struct buffer_head *bh,
-					  bh_end_io_t *handler)
-{
-	bh->b_end_io = handler;
-	set_buffer_async_write(bh);
-}
-
 void mark_buffer_async_write(struct buffer_head *bh)
 {
-	mark_buffer_async_write_endio(bh, end_buffer_async_write);
+	bh->b_end_io = end_buffer_async_write;
+	set_buffer_async_write(bh);
 }
 EXPORT_SYMBOL(mark_buffer_async_write);
 
@@ -1903,8 +1897,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			mark_buffer_async_write_endio(bh,
-				end_buffer_async_write);
+			mark_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1958,8 +1951,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		if (buffer_mapped(bh) && buffer_dirty(bh) &&
 		    !buffer_delay(bh)) {
 			lock_buffer(bh);
-			mark_buffer_async_write_endio(bh,
-				end_buffer_async_write);
+			mark_buffer_async_write(bh);
 		} else {
 			/*
 			 * The buffer may have been set dirty during
-- 
2.47.3

