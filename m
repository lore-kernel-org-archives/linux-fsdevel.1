Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6523CAA59
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950476; cv=none; b=MUKxuFmw/TRfPWmS8IGlh3L082WAxEcYhfz60ZpopfBYtr7tFEA6uzanO3MY3hX4NgFxN4jCRNNIpyGIIbl1g0QqOnae5xuudhPY/cYDxkmKjCklV5dQhjOiUnUE7prNlH5cBLLzutHg98gS56dRSLnvUtq+z/E4aRNMdZx8PrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950476; c=relaxed/simple;
	bh=86H4wzZX9/nhAQ460Ru6iS+CGYic4jx/GZsJzKodGaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmn4yZk8eSx/hygQ3PbZhsqZef4YTdTcWc/Rp3HwQHqQn1FiSrfKTV4ybnFQUw7qj/fM0USbkO6R8R484d4RAxnpL5HuzWx8WNEVAIVuGGI5RiXX8Zd8kKM70QQHhkp55AjRDZYYDGT61e6AKjuVi6e8jgOaebNy9HvslxUoMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N8rx/NMk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8rx/NMk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Do5wktMLQv4gmEEZopkZ3xHu3RcWcUiLwMZP8AGo3zM=; b=N8rx/NMk7lYVx0QWjXl4CDvppe
	YORVDFjCK4Q7AKiy1dUewG9gnRgv8k4KeR+ocYEj7MY+T1xcmZUxjj/YSpQ8GVR3yGXiEP3DWqCXr
	4GLdmdup/6u0A5GVbdKD308hG9sm3xsE52ddaC3Vg1ACqhb9kocOQm63/xOdHE+VWxkx+kqVaPxGy
	RtVQeme+lQWWoJXj3FPkI5VUmZ9bv4vtZsrY6jQ0Mfy4s3dvNTbkW8cYiUkm2nRVJBICYunJrSVEA
	/Patf8x/ACH5hTHJCp5Ea5iNgK8zaOw3X8o52TFSIWLp7xFEh5+6i3a+XQAB0XWuXLQ0xQR1Bhmyj
	sI0E4fUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03aq-0000000FQsi-31KY;
	Fri, 28 Aug 2026 20:54:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] buffer: Rename label
Date: Fri, 28 Aug 2026 21:54:26 +0100
Message-ID: <20260828205429.3678204-7-willy@infradead.org>
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

We now unlock the folio, not the page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9b4e462903a1..c9342aeb8cdf 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1654,7 +1654,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 			/* Recheck when the folio is locked which pins bhs */
 			head = folio_buffers(folio);
 			if (!head)
-				goto unlock_page;
+				goto unlock_folio;
 			bh = head;
 			do {
 				if (!buffer_mapped(bh) || (bh->b_blocknr < block))
@@ -1667,7 +1667,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 next:
 				bh = bh->b_this_page;
 			} while (bh != head);
-unlock_page:
+unlock_folio:
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
-- 
2.47.3

