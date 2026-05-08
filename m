Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D227CCE0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263974; cv=none; b=dJsf3fKlOT7iN+v94geq2lUkZKl6+or2GFpoeSsst1WNJjBsMuUa+LKgsp1/7Xepcc6WScGEHsYicrYVTWUQKN6lUHM+fL2dVzql+eMpDfysn0jJ6YTB7XqmfCXPvrrk9M3EwxzHMiD5Lf21M91nGNNWsSycjXVr2nqZD8HhbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263974; c=relaxed/simple;
	bh=LC5XXTxDfGbmu5cYp7Av/M44Iq8J0sO6eFtx44JJjXY=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=WwDSMLTfbCJxkrpthugCet/ufscOZJ6jzumxToHDiEVddmDmpEKZDtzV035/6PP8Iwylve1vHPX+GVacSDyh6M+4ZiXzbs34m0PrlNRO9dwZq/iwlXiIeaveeZPXARHQaOpIqriM2m6KUHDxyC0AMisdi5QUmh/6QITz1t3h+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdeO6SLo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdeO6SLo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f5943ca81aso3655060eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778263972; x=1778868772; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyKGCYrU63Aq4NGiL04wV7gIZx0hsmStPfmXdP8BRuQ=;
        b=mdeO6SLo8ToclB67XHN+K4uH/Roqx+vU8ftchmmH512mHSnPARw8FhdsaZR5SsI/cz
         md1eEsTLw5/ixs4agpggZLbVJPCvi5PgeJQEb9+gYbsca7r0PHp2oZa9c7FuNP/M9bct
         YFQNqBx6uRbO+CGx0zPEzdpyiu7OJ1Q1VxXL9PEr2yaULO/WDR9ijDc28g7b6xdase69
         MdGuHI5runnU4ME4ficdPN2vPU4TSCqxxnaNt/3y8z346VPKS9Hi2ZHuJ3ieinuFRfJt
         Z0Lh9Zv+B5PdtGKqD7se+y+CMU3uT7ZMOaV9r1PXgtb5wr02tkv3zNJ7mNHtM1ypE0hw
         06zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263972; x=1778868772;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyKGCYrU63Aq4NGiL04wV7gIZx0hsmStPfmXdP8BRuQ=;
        b=dpI/HYcLg/NdmHfrzjQ3CzB2Tscp4g8fI2wVAndQrb0jvcezquP6ELiY60IyDlyPWv
         aX5zaSzDfuTQ2k+18L7lNXunsAmrlwEXEE9Yutx7ijrYPp4qnIZhNLYha9PJt30RqEqr
         rbiaVwHcc7T+0CKx4fZDohzTOmr2Mrl1J8VFOXK+5GElsO2nhUyfr7/r9MH+AZCqikEk
         RPgxi0u2CV9h51k+zt3QxTJHTLo0L2703IaGSpjcWVWU1G8gY1SHw/2vrPNaLf+TJbvS
         vMHE6/oPF+BNuGdvbFHkGeXh/hREXd9AXJE6ftZGByp1Nxn0W/j8M1Eh/hsi8Vt/XmBk
         OJ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/nibon37rlaG9iRMkzRP/wC5QLxThVoI5SonEbJrE8iZx+hFB7gJXY/JA0okEjGWDNddBYv0KZXrzuo0uC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wyJZytD6PUFZTtGTDO6DhQk0PJD8LZL/feJRQxi0PejRTyiq
	VsziTM5GUfFCuw+/tpmIBSnHdm+soRVynaROw+wx/NoCDw8MHm3v3bg1Qqy+Ekwd2gbEqPdqZW3
	83cAIIw==
X-Received: from dlbcj32.prod.google.com ([2002:a05:7022:69a0:b0:12c:b3eb:b31e])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e10:b0:12b:ec67:3523
 with SMTP id a92af1059eb24-1317d89653emr7226915c88.9.1778263971653; Fri, 08
 May 2026 11:12:51 -0700 (PDT)
Date: Fri,  8 May 2026 11:12:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508181237.670645-1-fmayle@google.com>
Subject: [PATCH] mm/readahead: no PG_readahead on EOF
From: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, 
	Frederick Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When readahead pulls in all the remaining pages for a file, setting the
readahead bit is counter productive. The async readahead it would
trigger would almost certainly be a no-op. Additionally, for mmap'd file
IO, the readahead bit limits the fault around [0], causing an extra
minor fault when the page is accessed.

This was discovered when looking at /sys/kernel/tracing/events/readahead
traces for a simple program. With the patch applied, fewer
page_cache_ra_unbounded calls are observed.

[1] do_fault_around calls filemap_map_pages, which finds eligible pages
    by calling next_uptodate_folio [2]. next_uptodate_folio skips pages
    with PG_readahead set [3].

Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3921-L3939 [2]
Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3721-L3722 [3]
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Frederick Mayle <fmayle@google.com>
---
 mm/readahead.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8c12b63ccd4a..784a3bde82be 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -329,8 +329,11 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 	if (index > end_index)
 		return;
 	/* Don't read past the page containing the last byte of the file */
-	if (nr_to_read > end_index - index)
+	if (nr_to_read > end_index - index) {
 		nr_to_read = end_index - index + 1;
+		/* We've reached the end, so don't set a readahead marker. */
+		lookahead_size = 0;
+	}
 
 	filemap_invalidate_lock_shared(mapping);
 	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
@@ -474,7 +477,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	pgoff_t index = start;
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit;
-	pgoff_t mark = index + ra->size - ra->async_size;
+	pgoff_t mark;
 	unsigned int nofs;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
@@ -488,7 +491,13 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	limit = min(limit, ractl->_max_index);
-	limit = min(limit, index + ra->size - 1);
+	if (limit > index + ra->size - 1) {
+		limit = index + ra->size - 1;
+		mark = index + ra->size - ra->async_size;
+	} else {
+		/* We've reached the end, so don't set a readahead marker. */
+		mark = ULONG_MAX;
+	}
 
 	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));

base-commit: 2d565cbaafd43b10b75da56e43e5db9852a56afd
-- 
2.54.0.563.g4f69b47b94-goog

