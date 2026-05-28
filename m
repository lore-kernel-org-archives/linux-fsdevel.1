Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33F340402
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989520; cv=none; b=H4NFaBPXcCKo3Gt6aMX6fGuyu5MNFXheB4bFHu6J0p376MI3o6pB2VwTiEhm+6jSxXVpdMArxTl5i3ctaTTKunIeAz4+m8KlGcWbpz78eSU3924ubCt37fgksiB2Ny8gNsr+iNj6LhgXs4f6MIX5xkBr4XcJpTkeSqtlsb846+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989520; c=relaxed/simple;
	bh=NPZ/6QKiiPdguhnVXb+tpwY0gk+KE+7P/3LMoVpLoR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgGobPwfnsTUG3wCApkMfNfrwcwVOCDelOgsAr2aWTC8JCFT8GcyYlzzBEwwBrX3E4lkRZ7dpU64ffOdPZ7wH4jv36WIeoX0xHKpeCQeKGjhBrFeRiu3gIM6bCp+mpB0F3BgfSwOf/v+UO5IpVsV3mVuw24JqqXcxa/V1afjb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XTDUkuR4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XTDUkuR4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=voEt7RdgoeFrH6QiC1oPMRLEWMqjEHrdp0lO9kPkymQ=; b=XTDUkuR4SEKx8bt2WgeZ25Hgqm
	uJ2xk4yUeEcavrxrLEqZcElkadyYHi/oolFX4+JoE86vwm7n9OVN0TFR6SL6a5wj9sT02OZGGcqO9
	7ZifrZeTVoDPWPJqS8Nl2gd0PICNNxTnHGYyyRnE2b8uvfJPiaTwZSDKGQ/IipXgUm5PQiBG9tqnb
	r+ffAEdRN2vAYbapRJSEyKSHy6jJmtd4cJzYQEfFfpYBHWMXm069CjLkCC6sO6k5kSiutxx781Apz
	6ONa9NCuo0Os/gLP9rQll2C8/qVtNuWKawYRx1N0CS0mARrRIXR/MCp5Xy1k0OxgOa+it0LZ7on6C
	Qq7H2xSw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaI-00000004aZI-0SyX;
	Thu, 28 May 2026 17:31:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/34] buffer: Convert __block_write_full_folio to __bh_submit()
Date: Thu, 28 May 2026 18:31:24 +0100
Message-ID: <20260528173150.1093780-12-willy@infradead.org>
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

Avoid an extra indirect function call by using __bh_submit() instead
of submit_bh_wbc().  Since there is only one caller of submit_bh_wbc()
left, inline it into submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b668a73d48ec..50bcef50a4a4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1271,14 +1271,6 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 	blk_crypto_submit_bio(bio);
 }
 
-static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  enum rw_hint write_hint,
-			  struct writeback_control *wbc)
-{
-	BUG_ON(!bh->b_end_io);
-	__bh_submit(bh, opf, write_hint, wbc, end_bio_bh_io_sync);
-}
-
 /**
  * bh_submit - Start I/O against a buffer head
  * @bh: The buffer head to perform I/O on.
@@ -1945,7 +1937,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			mark_buffer_async_write(bh);
+			set_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1961,8 +1953,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
-				      inode->i_write_hint, wbc);
+			__bh_submit(bh, REQ_OP_WRITE | write_flags,
+					inode->i_write_hint, wbc,
+					bh_end_async_write);
 			nr_underway++;
 		}
 		bh = next;
@@ -1999,7 +1992,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		if (buffer_mapped(bh) && buffer_dirty(bh) &&
 		    !buffer_delay(bh)) {
 			lock_buffer(bh);
-			mark_buffer_async_write(bh);
+			set_buffer_async_write(bh);
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -2015,8 +2008,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
-				      inode->i_write_hint, wbc);
+			__bh_submit(bh, REQ_OP_WRITE | write_flags,
+					inode->i_write_hint, wbc,
+					bh_end_async_write);
 			nr_underway++;
 		}
 		bh = next;
@@ -2822,7 +2816,8 @@ EXPORT_SYMBOL(generic_block_bmap);
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
+	BUG_ON(!bh->b_end_io);
+	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_bio_bh_io_sync);
 }
 EXPORT_SYMBOL(submit_bh);
 
-- 
2.47.3

