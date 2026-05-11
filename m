Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CA3FE64E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508716; cv=none; b=DTcwjPOm9HcYbyj/FuglJiO6TtCHK0NPTfaIeh8A17GEdwgH84KRbTePVkJnx6m4xhCvVO8EckitxoL4v9NCM3iAdVF257pIzxKpOJfaOGSQoJG7nZ5HsrN2CC/A+w7+QkOCA6EzPyzBUFCs88d5kDywNwP30tinXSTmoMcC524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508716; c=relaxed/simple;
	bh=thgqoM0O3d7OMJRx4nWQrXXEAyOR839e88t0qcquqGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OSGQAcI04fJYhuUVIozpohsUzA/cJmLMx0KTVNx7VzgLLHykdcRbxxus4LehRyjHDxQ46swcKZFFbRL3Q3Up3NecYPIx2fhf07Ssf18/uEqsB5fXhKUHIQZvz9N3aSdsMNG1WzOtH9bd6UB9wAztbdTCjrl/GR858oSz6kG/CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxyW9CRg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxyW9CRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862EEC2BCB0;
	Mon, 11 May 2026 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508715;
	bh=thgqoM0O3d7OMJRx4nWQrXXEAyOR839e88t0qcquqGY=;
	h=From:To:Cc:Subject:Date:From;
	b=UxyW9CRgJlUgYSiS3tyRQLX5MIKDgn/2L7kuouyAwv8SB2HChhOP2YMRdD4I/rrz1
	 tQMPvgl6B5oNqcjuIv/p6o6IAi4qdIsjBtdBx2ZKeVLYOmWf+1D0wmO0IJftIVBfPh
	 Z780RmQnNWe73kcq93OWZFUz1iuWpMuyF0kuP9ZLSllmqJKiAtJiKYpSRaMhyfid0k
	 pfCAxBWZN4Spfpc2B3Y1iEyjzRKoxcAbCrnFjobnly67nlDeMajDirU7dqUXfc4F4V
	 cYF7i0c/p2rA5TFGDpiIGJsowZQSGSxFPgl7/b4sDWQpif9p5m957HF74qN10SSch1
	 stDJL8vEbB8HA==
From: Namjae Jeon <linkinjeon@kernel.org>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: willy@infradead.org,
	xiang@kernel.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH RESEND] iomap: remove over-strict inline data boundary check
Date: Mon, 11 May 2026 23:11:51 +0900
Message-Id: <20260511141151.6021-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current iomap_inline_data_valid() check ensures that inline data
does not cross a PAGE_SIZE boundary. However, this is an unnecessarily
strict constraint. If a filesystem provides a valid iomap::inline_data
pointer and iomap::length, we should trust that the caller has mapped
sufficient memory for the range, even if it spans across page boundaries.
Removing this check allows filesystems to point directly to their
internal data structures without forced page-alignment or additional
redundant allocations. This remove iomap_inline_data_valid() and
its callers in buffered and direct I/O paths.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/iomap/buffered-io.c |  1 -
 fs/iomap/direct-io.c   |  3 ---
 include/linux/iomap.h  | 10 ----------
 3 files changed, 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7b648421a70..c4c5bddcbe3a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1058,7 +1058,6 @@ static bool iomap_write_end_inline(const struct iomap_iter *iter,
 	void *addr;
 
 	WARN_ON_ONCE(!folio_test_uptodate(folio));
-	BUG_ON(!iomap_inline_data_valid(iomap));
 
 	if (WARN_ON_ONCE(!iomap->inline_data))
 		return false;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b0a6549b3848..a4459c5abb07 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -603,9 +603,6 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	if (WARN_ON_ONCE(!inline_data))
 		return -EIO;
 
-	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
-		return -EIO;
-
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = iomi->inode->i_size;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 531f9ebdeeae..c758a8e865ed 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -142,16 +142,6 @@ static inline void *iomap_inline_data(const struct iomap *iomap, loff_t pos)
 	return iomap->inline_data + pos - iomap->offset;
 }
 
-/*
- * Check if the mapping's length is within the valid range for inline data.
- * This is used to guard against accessing data beyond the page inline_data
- * points at.
- */
-static inline bool iomap_inline_data_valid(const struct iomap *iomap)
-{
-	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
-}
-
 /*
  * When get_folio succeeds, put_folio will always be called to do any
  * cleanup work necessary.  put_folio is responsible for unlocking and putting
-- 
2.25.1

