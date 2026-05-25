Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA355B21A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729585; cv=none; b=JQTyl6AKcMhzAfOIqjrrxT9FBl2PQk0EYu9y8rxcV1R6SQx067k1usM0zbL8MtLPZ5uvBX0kFxZ9Iwlc5hT7nBpmkPfH9GqDDShAnf67t/d4xwDh/RWuApqXuwXBEAxaEme7rtKT2O987Tl5Z7nCi1KUTF4WhEDNNZnCVE2/Swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729585; c=relaxed/simple;
	bh=Hdh7aXwujOdgFfQ6m6PwYa/KBAlDtL5vBwNtucyQicc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTlz+Qw+tnqHBAMzbazMr2ze4E1g0egYLq+QSmAPemYqUgX2IKlX9jBax3q971wjI6N6Y3tWcsNjKwtDexWtNtIZbSfHMUD9BIAbELaF2WXN6QyXSZfWG1eh3L3t4jmMb/NyHWgR1PeL+inrSPLgkIm47eISf3SdkSwvkOLM1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V7a26Bbc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V7a26Bbc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HFhU6qp482cshSlp+TIchXRDayebLucMr2x5Fb9wWAE=; b=V7a26BbcqvMCvVDzsx04tv58Si
	TIVGdxRyY5jjUp4M4pc7sBOoNU34Lfgbi36Om7wvJ4O6dhPYqHDvUChnYN9yc43bAZUTsO9ecO2MH
	BAIs4YrnLOgOtuczNwz2PJtLMmQzwrLDN1nGQ5by+OGPVQnBXAcBo4t40/WYKFuO6Ve8G33A7oLVW
	34tUn/EmUXMdtE+dlFfb7V/YSTDGSf3EVzxvmrnqkngA+n4SYo6m1qq24JrWtpBt0FEdt2BetTelD
	VQygxdyAhCxJzsJ6jHBbTp4ptRXzRgpAdjZA6sAQPdLvin+a9a1bdk2skyxmQAcuPC5015d3mqm0n
	WQLeAZpg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxp-0000000HOAk-1Z3k;
	Mon, 25 May 2026 17:19:41 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/34] buffer: Convert __block_write_full_folio to __bh_submit()
Date: Mon, 25 May 2026 18:19:04 +0100
Message-ID: <20260525171931.4144395-12-willy@infradead.org>
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

Avoid an extra indirect function call by using __bh_submit() instead
of submit_bh_wbc().  Since there is only one caller of submit_bh_wbc()
left, inline it into submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 92500060d834..9199ac5d6154 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1261,14 +1261,6 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
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
@@ -1936,7 +1928,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			mark_buffer_async_write(bh);
+			set_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1952,8 +1944,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
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
@@ -1990,7 +1983,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		if (buffer_mapped(bh) && buffer_dirty(bh) &&
 		    !buffer_delay(bh)) {
 			lock_buffer(bh);
-			mark_buffer_async_write(bh);
+			set_buffer_async_write(bh);
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -2006,8 +1999,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
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
@@ -2813,7 +2807,8 @@ EXPORT_SYMBOL(generic_block_bmap);
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
+	BUG_ON(!bh->b_end_io);
+	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_bio_bh_io_sync);
 }
 EXPORT_SYMBOL(submit_bh);
 
-- 
2.47.3

