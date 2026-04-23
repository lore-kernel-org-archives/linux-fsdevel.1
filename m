Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F629BD8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980000; cv=none; b=Jy0qHgi6cIFPzmFupWTUQzL0f7Fz65ixWuj0/Sq4qX1zSdz9CD3HI26lbaiC6bUz95Fn5+dIQp3E6Lsq1tol0KirE8muuHwMCJT6z04hkaF8Bg+LCNiCgk1ZJ4e3e5WfKRgL4Sjv/JJdoD4234+vPvYGMsgHUldhRU+ITnR0ows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980000; c=relaxed/simple;
	bh=EttDQQNTmZQv1L53l5I14KSTEbbRnCJzauJpudvu+tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwpkX+WMGJ9xVuTT6NEVnyfMtt6jRENqgKveBArkbhQozRUSVUP9wzdMUFVhqzta8E7scM6kFA4v4IsTiMkDM0uIZdjOV34YVMjfhmxkHABt1+ANwXWGM51/uUEj7qXGANM6jOMxJJFSsSaAaCjK7IccGpTPz7EdZqWPU6I9PNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMmzrGwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMmzrGwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB1C2BCAF;
	Thu, 23 Apr 2026 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776980000;
	bh=EttDQQNTmZQv1L53l5I14KSTEbbRnCJzauJpudvu+tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMmzrGwiD2QZtkyv1qTYc6npzFEyK7BjXN8olyR9BpaAMBjnIcS4A9OEwtCDJwLWE
	 FKMMD9J/6uZAWhM1bJSW8ZmML5WAgnMPtnYR6rzvbV35VC8ID5pQU84YWf7HxX2nLA
	 eO0XI9jjr9mzCwYKWymTOQP7NwwpPDg7MMkXIgbY300iD/VTIxzXzac5XWwSpuSdRk
	 3DWDGl1FdnFC8dXzITEjGuXunhdhbXsGY6D3FxZpq/z8Rz/6pRCwLWRJ7gIfolS2cT
	 W8RS2g7bs0bJ0ixiCABZjrJPQKiDwxMm0RkyLl9xiuSEcOoQaHH9AdCppHIQbl89Aa
	 v+s8fkjoTfHSw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: brauner@kernel.org,
	djwong@kernel.org,
	hyc.lee@gmail.com
Cc: willy@infradead.org,
	xiang@kernel.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 1/2] iomap: remove over-strict inline data boundary check
Date: Fri, 24 Apr 2026 06:32:02 +0900
Message-Id: <20260423213203.5533-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260423213203.5533-1-linkinjeon@kernel.org>
References: <20260423213203.5533-1-linkinjeon@kernel.org>
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
index 2c5685adf3a9..52bfd6783417 100644
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

