Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39553371041
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239258; cv=none; b=mTnEoyN6oFputq4NuzqXZ/R6QwrFY0OcYtdxRHRP77Yw/htjMskzVh+1wzpBZe2yaC+c1gyySaHczgR9OLT0pbqdpa1wmYro78B616z8t+Z4CSajyvxgzmG4NMuOqRhXNMGMV8fktWWMYgx5wWzy9A0EYm3kppAaNhMpFBxnseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239258; c=relaxed/simple;
	bh=dg3ZaLQQ5iPEnRBM7P7O0Vfd0AamQZttwuLTaXPMgIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ze1Al/gZ81e2ZkUdsKWU8xup27FcO+9t57/27htKHBhJkbqamhzC3KNCFbWb0TYfq8b7h72muBCXhlBC31UAm+xsJRgfdS0Wauf6rpPEL4xknfFPaJaV5Q7B4a9l1jTorI5JsNXsvHjYPFsz4ZZ4mAvcOvYKT8BFUcr7OPTN3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNqavLtg; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNqavLtg"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so1527531f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791239255; x=1791844055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5SXfZIcVyEClMhDE1K+HuTBhEkNW/aofeMzBlGv0E5U=;
        b=KNqavLtgbyVUcPQc6+WDfvZqm5vltTl09dghZ2dUtFDyLAdeE0BJZ4l0HC40kKjZzD
         b7OCIxNw+i7ZHeeYiAooOB/j1fW5TVQavoS3W1md4MHtbSsaCf1mb1kYjLvqjciJx66q
         xfKWK1LEHrRfrbdlmliN4PEdvFa0NaYiLt0k2GcPeJFeddpiGOIUgDTE/oExKFxWrc6Y
         5m58MrmLyhsriID0D84lPh2+Y2bgR0etvJqqIi9Hu4H0eTJ9Y5hALghTrSZWv0/67ut3
         9DazMoX90kzdTaijt8dAej+t9Ofe889eqNpHBedrlgyDp8/DSYyMTJMsdf4rKUdhRnwd
         Xmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791239255; x=1791844055;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5SXfZIcVyEClMhDE1K+HuTBhEkNW/aofeMzBlGv0E5U=;
        b=fStZXz8KYOQ4up+0/l0ErVahkvo6kmwSaVYQ/X2ubnlpa5jrdzLICjT4zoe8U7t5Wd
         F1D72avSap/ItmNuxTMvAyokIvlYCS0tKpcHySXcKte3xybJUI9mVZaliTubvv8E4qeB
         wComEZFMRkxNom8IWcTjtSbKAvzmGcJkJEPrw45nnemWMVa7MpLNRLHV7E1YqyGPR95W
         v+iB6U11epm5dK/NDNRnVDKcKlCsRcfs8FzLJpyJBsSvXHcoJLyzX8CWY4BPGRTcCMoJ
         /ptm5Ptt3X2Fr+EVpVr2e8OoGvXTqJJMHMsZwaxHGbSdpmWvE/V5fM/PQZfqniVA2AfG
         Wy6w==
X-Forwarded-Encrypted: i=1; AKwUvBwYHRbOdZ95uabdR5alwB0DvKyYt6iK2+OcKJLD+PcIBD5K0xm1ujpikF5HBA/LJ6TomcDc5X0x+KZS+0Hw@vger.kernel.org
X-Gm-Message-State: AFuF++noT5s20S01AsAv4gnS14VIK4mKlEnqUaBOVJAmK25mXlYMkwHv
	cjzNmFjhuzjdgeP+vWsqWMHDXewrvCvi/XJVF18ETfnST90WBwWD3vr2
X-Gm-Gg: AYBFou2ZcvDlzSuc1almlX8jlaMrWwhDTTLoxd4z6pA/Qmq+O7b++NkWwpr7UHny8B9
	cK2W49VN665GDEu0shF1Ekvo1oUl7AnIidNMdWK0LDC+lVSJQ0iBoMzH9yGHrz+3nFb9VldkntI
	ZsYbAAlPS0reqg7evfQ4kwDXLT75Du3Gq+ZWFaHLDzdGuw8tTDeJO0e7SJz26BenqHddw5ukKNd
	CiRWA63Xm6BQWg7MT5+nhQJM3qWbd9pG3DOQC/r0sk+GjLI5QsHda4lhmtEKLyKrZ8Wa7eM7cgE
	zLcyRrLqgNv8Xj2rFs7OSElGUB/M5J+d27j+LRBF+gbkTxeyuWC1NN49JVhvfZbmwtK2r6K3Mx2
	PenWN/LAtukVkrt581CdVriK0UXHrBcvIJaH7pXEiCCW1pQ8cZMJNSonpuKQU/02mckU2A6ShRp
	9H4yYgJXcsxyBRUFHv0Xdq8qmuQNqC/rhsYt04AHONCZDQimxWnjp8ULvspb0DvcoTlRTuKLJ0W
	KV8M9q0KiTpNSOpds/CJI8isXgoZAuOr6HuS4qfJ8ut5cvuha6zlkKt
X-Received: by 2002:a05:600c:500d:b0:4a0:1fe2:d4f1 with SMTP id 5b1f17b1804b1-4a027598d25mr205495365e9.28.1791239255321;
        Mon, 05 Oct 2026 15:27:35 -0700 (PDT)
Received: from [127.0.0.1] (230-197.cgnat.interconnect.cz. [185.100.197.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178ca8127sm22346505e9.2.2026.10.05.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:27:34 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
Date: Tue, 06 Oct 2026 00:27:19 +0200
Subject: [PATCH] mm/fadvise: skip remote LRU drains for ineligible folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-fadvise-lru-drain-v1-1-1e8fcf785057@coreweave.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWM3QrCMAxGX2Xk2kA3qFNfRbxIm9QFXJUUf2Ds3
 c0ELw/f+c4CTUylwalbwOSlTe/Vod91kCeqV0FlZxjCsO9DiFiI3RK82RPZSCtyTGMcDzEfC4P
 /HiZFP7/m+eKcyPVkVPO0lf6BecYqb9xWWNcvcckmt4kAAAA=
X-Change-ID: 20261005-fadvise-lru-drain-d5b75785c9fd
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 fujunjie <fujunjie1@qq.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791239254; l=5993;
 i=sdimitropoulos@coreweave.com; s=20260302; h=from:subject:message-id;
 bh=xmcmt8qXwptEfsyFlOCeswfoPaIK18LLe7PFw9b7oko=;
 b=8JZENOLol5hUT5cGN3YqxX7QkVDB5zAe5dpkpMG2uXqc4lG2duh9g5NZhyWgANCUN8PrGIWJF
 4WgauIv7721BCMC2ZhtIV6uX6rMsh6Jpp5xaAPFxEMyagD6cFoqsg9h
X-Developer-Key: i=sdimitropoulos@coreweave.com; a=ed25519;
 pk=Qysvg7jaTIU0posaYFtqa5SKJlFwqzil4X0U1p1zo/g=

From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>

POSIX_FADV_DONTNEED retries invalidation after a global LRU drain whenever
mapping_try_invalidate() reports a failed eviction. This includes failures
for mapped, dirty or writeback folios, which dropping LRU batch references
cannot make evictable while those conditions persist.

Filter those failures in mapping_try_invalidate(), while the folio is still
locked and before deactivation can enqueue another batch reference. Leave
mapping_evict_folio() and its eviction safety checks unchanged.

Use a boolean retry flag instead of a failure count: generic_fadvise() only
needs to decide whether to drain and retry once. This remains a heuristic,
not a test for remote LRU references. Preserve the retry for other failures
on clean, unmapped folios, including failures from filemap_release_folio()
and remove_mapping(), rather than limiting it to the early refcount check.

This follows the problem identified in fujunjie's earlier proposal, with
the filtering kept in mapping_try_invalidate() and a conservative fallback
for other eviction failures.

Link: https://lkml.rescloud.iu.edu/2605.0/07547.html
Link: https://lkml.iu.edu/2605.1/03284.html
Link: https://lkml.iu.edu/2605.1/03732.html
Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
---
Tested baseline and patched kernels in QEMU on ext4, XFS and OverlayFS.
For clean mapped files on each filesystem, 32 POSIX_FADV_DONTNEED calls
produced 32 lru_add_drain_all() calls before the patch and none afterwards.
A separate dirty, unmapped test using ext4 data=journal showed the same
reduction.

Cross-CPU and mixed-range tests confirmed that clean, unmapped folios were
still evicted and the global-drain fallback remained available. Writeback
and concurrent pwrite/mmap/fadvise tests also passed, with file contents
verified after fsync, eviction and refault.

Skipping the retry can miss opportunistic eviction if a folio becomes
eligible immediately afterwards; POSIX_FADV_DONTNEED remains advisory.
---
 mm/fadvise.c  | 12 ++++++------
 mm/internal.h |  2 +-
 mm/truncate.c | 22 +++++++++++++---------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index b63fe2141..daf655846 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -141,7 +141,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		}
 
 		if (end_index >= start_index) {
-			unsigned long nr_failed = 0;
+			bool need_drain = false;
 
 			/*
 			 * It's common to FADV_DONTNEED right after
@@ -155,14 +155,14 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 			lru_add_drain();
 
 			mapping_try_invalidate(mapping, start_index, end_index,
-					&nr_failed);
+					&need_drain);
 
 			/*
-			 * The failures may be due to the folio being
-			 * in the LRU cache of a remote CPU. Drain all
-			 * caches and try again.
+			 * Clean, unmapped folios may still have references in
+			 * remote LRU batches. Drain and retry only if a failure
+			 * might be resolved by dropping those references.
 			 */
-			if (nr_failed) {
+			if (need_drain) {
 				lru_add_drain_all();
 				invalidate_mapping_pages(mapping, start_index,
 						end_index);
diff --git a/mm/internal.h b/mm/internal.h
index 0ca863f26..1637d4275 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -628,7 +628,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t lstart,
 		loff_t lend, pgoff_t *pstart, pgoff_t *pend);
 long mapping_evict_folio(struct address_space *mapping, struct folio *folio);
 unsigned long mapping_try_invalidate(struct address_space *mapping,
-		pgoff_t start, pgoff_t end, unsigned long *nr_failed);
+		pgoff_t start, pgoff_t end, bool *need_drain);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/truncate.c b/mm/truncate.c
index 5b1b13cf8..42b6a1b63 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -567,13 +567,14 @@ EXPORT_SYMBOL(truncate_inode_pages_final);
  * @mapping: the address_space which holds the folios to invalidate
  * @start: the offset 'from' which to invalidate
  * @end: the offset 'to' which to invalidate (inclusive)
- * @nr_failed: How many folio invalidations failed
+ * @need_drain: Optional flag, set if a remote LRU drain may help eviction
  *
- * This function is similar to invalidate_mapping_pages(), except that it
- * returns the number of folios which could not be evicted in @nr_failed.
+ * This function is similar to invalidate_mapping_pages(), except that it can
+ * indicate whether a remote LRU drain may allow a failed eviction to succeed.
+ * Callers using @need_drain must initialize it to false before the first call.
  */
 unsigned long mapping_try_invalidate(struct address_space *mapping,
-		pgoff_t start, pgoff_t end, unsigned long *nr_failed)
+		pgoff_t start, pgoff_t end, bool *need_drain)
 {
 	pgoff_t indices[FOLIO_BATCH_SIZE];
 	struct folio_batch fbatch;
@@ -599,17 +600,20 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			}
 
 			ret = mapping_evict_folio(mapping, folio);
+			/*
+			 * Draining LRU batches cannot unmap a folio or clean it.
+			 * Other failures may be due to remote batch references.
+			 */
+			if (!ret && need_drain && !folio_mapped(folio) &&
+			    !folio_test_dirty(folio) && !folio_test_writeback(folio))
+				*need_drain = true;
 			folio_unlock(folio);
 			/*
 			 * Invalidation is a hint that the folio is no longer
 			 * of interest and try to speed up its reclaim.
 			 */
-			if (!ret) {
+			if (!ret)
 				deactivate_file_folio(folio);
-				/* Likely in the lru cache of a remote CPU */
-				if (nr_failed)
-					(*nr_failed)++;
-			}
 			count += ret;
 		}
 

---
base-commit: 0aaec43576cd41474a8e90c919631c0c9fc88417
change-id: 20261005-fadvise-lru-drain-d5b75785c9fd

Best regards,
-- 
Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>

