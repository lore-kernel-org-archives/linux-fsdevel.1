Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F7305663
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729590; cv=none; b=dWt6SwwjY5c6mJ1JHUtBzjLHtFSV1d4IoEtWRvjMpSS8SURWwC9mNot+IYBnidw4IaRw5OOJKQOkrjmwhRS01Eud1ohQWB5HG9KbtHyQmx/+gzNPC6RDeC34eWWAgixoBfF2b09zt/oxoQvROv8dZK7yRexj1L7UXuqLJFkD8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729590; c=relaxed/simple;
	bh=FAg4+MaUeeJSUJuGZDyn0Xd48APsjnqCY1oixc0Qvmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeQQRiQyJCdn2qWC0WIE7VSbl09WYtU9DwfO8msG8zUjAqPe719/LvAT976NmxJsCs86qhWRgIKO9GXO+0kh/KJfCo3njh0ne5W6CVU+S8jUzWdWRthuyVRK6Q1VScRk2W+fNocyPlgVBDz8Em31ozR0TBMeVYFsWRhSrzD3UMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VdSmRDO/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdSmRDO/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=u4ey2MMh0244itAGnbfwGhBd3iDJ0/y98HvyFqN+1xA=; b=VdSmRDO/mHJ/h3Cv4wNOcN8Kq8
	IJxUmX2cdv8qEMGqjbi/1JYpBUCCwCh08alRJ+/oTfpXxx/zwYYN15em6oW3KwI/oWgjEpzVNryLP
	d0XKMTmP9iQdWDOlIEXgEOO3TUxCpUEyIuz6pj1e3rpILQWpZhEFB+H6S7RdaYfX+RQZEVrQ8HYxk
	fLYOOP5pbqHkqk3Wyl3a3rEFGFOtjpj2lYWKtu459w8JepcVWBTYHvU/BNfyDiNs7GPry3SyGn9an
	JciEDU3nvOdgLptXxOHCjrkjuiSvWqrq8Vls4WgxKYaDuK0KFyjjcCXitWJem11poCMMRxmxvcFCK
	mFufE5tw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxu-0000000HODq-1eon;
	Mon, 25 May 2026 17:19:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 34/34] buffer: Remove end_buffer_write_sync()
Date: Mon, 25 May 2026 18:19:27 +0100
Message-ID: <20260525171931.4144395-35-willy@infradead.org>
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

It has one caller left, so inline it into bh_end_write().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 25 ++++++++++---------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 623a09ade8c7..d60b4e2ae68f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -187,20 +187,6 @@ void bh_end_read(struct bio *bio)
 }
 EXPORT_SYMBOL(bh_end_read);
 
-void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
-{
-	if (uptodate) {
-		set_buffer_uptodate(bh);
-	} else {
-		buffer_io_error(bh, ", lost sync page write");
-		mark_buffer_write_io_error(bh);
-		clear_buffer_uptodate(bh);
-	}
-	unlock_buffer(bh);
-	put_bh(bh);
-}
-EXPORT_SYMBOL(end_buffer_write_sync);
-
 /**
  * bh_end_write - I/O end handler for writes
  * @bio: The bio being completed.
@@ -212,7 +198,16 @@ void bh_end_write(struct bio *bio)
 {
 	bool success = bio->bi_status == BLK_STS_OK;
 	struct buffer_head *bh = bio_endio_bh(bio);
-	end_buffer_write_sync(bh, success);
+
+	if (success) {
+		set_buffer_uptodate(bh);
+	} else {
+		buffer_io_error(bh, ", lost sync page write");
+		mark_buffer_write_io_error(bh);
+		clear_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
+	put_bh(bh);
 }
 EXPORT_SYMBOL(bh_end_write);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 634b0035d40a..37038d44a9e3 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -201,7 +201,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size);
 struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
-void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 struct buffer_head *bio_endio_bh(struct bio *bio);
 
 /* Completion routines suitable for passing to bh_submit() */
-- 
2.47.3

