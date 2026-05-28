Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B53FC5A3;
	Thu, 28 May 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989522; cv=none; b=kq+BC/9J5PhN/kYQbf9YNUgrTUxE6RWZnweiPGA0ubdzW2dM6KnfwXf6Ut2XUTKRkuoQdXn7syau/djIFiXTL1ZdkgPAtVr37jar8dlkbJNxAKMYzXAlRD5DYOHcL+L1SSbwDXJA5q5cnXSNyj1g7bm1h9aVrp1fe8SSHkwtSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989522; c=relaxed/simple;
	bh=y98+UG7zAiqdE94eqIT0UkI3R70v1REUs1rLk61DZNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhRVUBBu51rzUPKWdlcrn5obdpvdaU9zr1ZaCpvgKmmsgCz89MIFF852efC74LmoLwR43Pb9cX9gqowXBWFAC0APKrNRIqd2hacU1MZ7p9W28jrNSmbCN0F6ydWpC4HzDJkN4EyT141fzYs1KBUrqxHrSBCpG+ZxBDUzPycNHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WCjbIgJy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCjbIgJy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gzABKBvksYBHX69eiAu6uLnxq1MQST0Jqov+xVNGFw0=; b=WCjbIgJyhhgxuloCFp9cO+2aTF
	0Xe4WTkB9H3UFynE/xfa5edxl74xbvb42jclGKCP7FQVJgnu5fIszhLK6CN/67GiLe2fDrFdq4CC2
	iBhaMmFgfAAXqhjCONalauGSdOOQD6Xuiwxa8fKTgJ6C73ysZfWSFNm2rqvsJ/5fORIP/L2XrSIIe
	lKZzoXd6p0B4sooF9/TrWRf+mX9SUAJpojBz0nWEPbuelbYnQim7HlKgMGFhBcrui3P9retXZk9PO
	pmzPntUktBaNRV0b6TBkwFbjJpjqxSyi74K37a7dYf8V8NFBUJHD5V9vVusKNhzevsTg977U1LaWj
	nU/Wqv6A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaK-00000004aag-3sxI;
	Thu, 28 May 2026 17:31:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH v2 25/34] gfs2: Convert gfs2_aspace_write_folio to bh_submit()
Date: Thu, 28 May 2026 18:31:38 +0100
Message-ID: <20260528173150.1093780-26-willy@infradead.org>
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

