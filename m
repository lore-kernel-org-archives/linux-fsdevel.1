Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1B3F6C3C;
	Mon, 25 May 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729588; cv=none; b=jPSm/mZ40Bqr+KjNWYXFMzk+tbxSkaPmDp2Rj9pcU8FxwjI49hX3jqzY3scfmv85peqjsFllGurdrBKTt/uM1hXqTemYae7n5EFWsdnjf5PruMXWMvyUWaVdEcYZLVIeQC1+C5tfJSoLyfZSeXoi0xHabiolCPw0dQGTtlAUS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729588; c=relaxed/simple;
	bh=y98+UG7zAiqdE94eqIT0UkI3R70v1REUs1rLk61DZNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLGLD9VtJNmJR41z78PAoap1UAwXjsiV0f0+g2u3Q++Vtwht0bA0YV1BeeucZN/fgZSl8YkVuZUve02UTISoREjjk3ZLBmY5A+rm+PRnSp2upqugq/1bUxrxYZCUrMsFHK9knrMXZpfTbf83egkKUXVgJOjkIXJD9bGo2ktUm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hyxPsOnK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hyxPsOnK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gzABKBvksYBHX69eiAu6uLnxq1MQST0Jqov+xVNGFw0=; b=hyxPsOnKgFaLiV2ePPAh94m1m8
	FyWPfjUPEQsn1NhEXovX0qJdHtB2n6IRb4vu2wnImZsYdDava6ca12gypkUG0jcdtHipXFnzlOUgX
	hYMg64aLnc61nm772tUe7ok3U19MBWCjPp9wCCSXDTooXsn1lI0K2TVv0JvWpglQfU9Tyr8V00M2E
	1UOeLAmeVxXBGMstFY9MkwC6WwRE9oyBZHC8Dg+C46acJ83tTmbUA+PbgALnwLGXZ7kG8+jobRVyn
	FXttqSfdnmHZkLrPQCJrJu6zvmDORM5csS/ZMjCO2bZzvn2XA4UZJ92y83PBtwadZLq7P5811zHSe
	qve3Xv0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxs-0000000HOCf-2eLw;
	Mon, 25 May 2026 17:19:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 25/34] gfs2: Convert gfs2_aspace_write_folio to bh_submit()
Date: Mon, 25 May 2026 18:19:18 +0100
Message-ID: <20260525171931.4144395-26-willy@infradead.org>
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

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/meta_io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index df5f05054f6e..4895bb010cfb 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -59,7 +59,7 @@ static void gfs2_aspace_write_folio(struct folio *folio,
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			mark_buffer_async_write(bh);
+			set_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
 		}
@@ -75,7 +75,8 @@ static void gfs2_aspace_write_folio(struct folio *folio,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh(REQ_OP_WRITE | write_flags, bh);
+			bh_submit(bh, REQ_OP_WRITE | write_flags,
+					bh_end_async_write);
 			nr_underway++;
 		}
 		bh = next;
@@ -221,7 +222,7 @@ static void gfs2_meta_read_endio(struct bio *bio)
 
 /*
  * Submit several consecutive buffer head I/O requests as a single bio I/O
- * request.  (See submit_bh_wbc.)
+ * request.  (See bh_submit.)
  */
 static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 {
-- 
2.47.3

