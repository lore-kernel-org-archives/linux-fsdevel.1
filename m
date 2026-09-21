Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF904BB272;
	Mon, 21 Sep 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004301; cv=none; b=si/8R66MNJ2HtXztXcHR9118n5L3CG4xM/fFeIkIo8DGYNEZ8NvJBj9g9jhCvIvqKs6NvM3B7iFUTY3nzVNt2EQAXOwB5XJPfF0hbY4G0PmorJp/MFq/U/GGbtdUu+iBYVz8b5jCSJpzYi0HIqCbVZ4rwI567xLP9pyRzNo31aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004301; c=relaxed/simple;
	bh=FU91mVWvx2dInXL96JKcP487FkJkGpF9GdL9XhZhdZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzN3TGnY9VRO+3DE9ctXKdk0igfiO3jxPGqdie/1Cg3YveotGRvaEUP3cO4SuFztrZbOeEv9Z2fTL8QNdhUNvsR9o85nRUSiMH0zFITUw+XHre5/3DfVEM4lC/TBU0IM5E+6IDh6bX+ttpaxmogClm6Xezb/P9utX/c2LuY73fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F7773EDB6;
	Mon, 21 Sep 2026 15:24:51 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	liam@infradead.org,
	ljs@kernel.org,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	yosry@kernel.org,
	chengming.zhou@linux.dev,
	kunwu.chan@gmail.com,
	tz2294@columbia.edu,
	hch@lst.de,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
Date: Mon, 21 Sep 2026 17:24:33 +0200
Message-ID: <20260921152449.629486-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGJ0K/8e2Pztp+j2sY+ScsUkCHOW/yXvnc8RSSzpo2y7MSWBAdHH95jj7iY86IG3StSez5iGs7YBgB3H839XNyDnjW9zfMdmBkAKsASsvMhaLCmTi1AoeUnuwtG9zlqupdPYX+HawcgSm+JGIpnjCfGFBjvtLDn71zscY4rO8DWFgKDvVTpDKQQiP2J2hPdRCUiJ/zh1RIu+t22boYe0C6TNAvzTG+LsxJUOKCWUUuD2klfWozBAaYw5r8xQzoa6tJ5bmIDwEq+T5TBqqZjBFfBsK44AgPHHgTvaK8WTi7jgX5q7ZWiGPXUO4tU5ZOxX5+wULeE0Aft9rDHh5fQfgW+MdI6EzMCWnFZ+OE+cx7Iw8H7rDbuPMBm2uneJoPvZqxs3FlpdPORsdUK06Edbu5HTggLWH6kFza+POdqZVRwEgUVGKFVamC61XNbu+tQV8Gtzjr/zPBWXZnb3S1Zw0/qdwiWWoOh/i83Spb4MycZLMmVpzFmOJddpil+2FS0WZPIcsQEMmsAJIJbPs66kaDz6/3IUfu0hoDQq4JZZ2zfW9TR4aCetC9YO1wuc4V5Q+fkauY8VZ0+X46MHqwYuo10VcfHqQuwipvbN9YzyGPqaU8p4M3q61GdlTFewpKjDKO9iKhJHoV01XPBf/iiRKg5EAPZ72ju2kOUdvc/kT9OTw

On an asynchronous swap device MADV_PAGEOUT only marks the folio
PG_reclaim and rotates it to the tail of the inactive list once its
writeback completes, so the memory is not actually freed until a later
reclaim scan removes the by then clean swap cache folio. Mark those
folios dropbehind at isolation time instead and let folio_end_writeback()
drop them from the swap cache as each write lands.

A dropbehind folio is dropped by whoever completes its writeback, so the
reference the submitter holds has to be released before the write is
submitted. As reclaim does before freeing a folio, flush the pending TLB
batch first.

Note that for dropbehind folios nr_reclaimed is now credited when the
write is submitted rather than when the folio is actually freed, since the
reclaimer never sees the folio again.

Suggested-by: Barry Song <baohua@kernel.org>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
This applies on top of "[PATCH v6 0/3] mm: zswap: free cold writeback folios
promptly":

https://lore.kernel.org/linux-mm/20260921151306.625134-1-alex@ghiti.fr/

 mm/filemap.c |  7 +++++++
 mm/madvise.c | 23 ++++++++++++++++++----
 mm/page_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/swap.h    |  2 ++
 mm/vmscan.c  | 10 ++++++++++
 mm/zswap.c   |  9 ++++-----
 6 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e1f1bbe943ce..14fa96fca8b8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1630,6 +1630,13 @@ void folio_end_dropbehind(struct folio *folio)
 	if (!folio_test_dropbehind(folio))
 		return;
 
+	/*
+	 * PG_dropbehind could be set on an anonymous folio after
+	 * folio_end_writeback() samples it (for example MADV_PAGEOUT).
+	 */
+	if (folio_test_anon(folio))
+		return;
+
 	/*
 	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
 	 * but can happen if normal writeback just happens to find dirty folios
diff --git a/mm/madvise.c b/mm/madvise.c
index eeee82cf2b3f..63164f95720b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -359,6 +359,17 @@ static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
 				     FPB_MERGE_YOUNG_DIRTY);
 }
 
+static void madvise_mark_dropbehind(struct folio *folio)
+{
+	/*
+	 * A folio already under writeback is skipped: that writeback is not
+	 * ours to hand over, so reclaim will put the folio back on the LRU
+	 * while its completion could be dropping it at the same time.
+	 */
+	if (folio_test_anon(folio) && !folio_test_writeback(folio))
+		folio_set_dropbehind(folio);
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -439,10 +450,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			folio_set_workingset(folio);
 		if (pageout) {
 			if (folio_isolate_lru(folio)) {
-				if (folio_test_unevictable(folio))
+				if (folio_test_unevictable(folio)) {
 					folio_putback_lru(folio);
-				else
+				} else {
+					madvise_mark_dropbehind(folio);
 					list_add(&folio->lru, &folio_list);
+				}
 			}
 		} else
 			folio_deactivate(folio);
@@ -554,10 +567,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			folio_set_workingset(folio);
 		if (pageout) {
 			if (folio_isolate_lru(folio)) {
-				if (folio_test_unevictable(folio))
+				if (folio_test_unevictable(folio)) {
 					folio_putback_lru(folio);
-				else
+				} else {
+					madvise_mark_dropbehind(folio);
 					list_add(&folio->lru, &folio_list);
+				}
 			}
 		} else
 			folio_deactivate(folio);
diff --git a/mm/page_io.c b/mm/page_io.c
index 52eae99de6e3..bf8238768cc9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,9 +26,12 @@
 #include <linux/delayacct.h>
 #include <linux/zswap.h>
 #include <linux/swap_ops.h>
+#include "internal.h"
 #include "swap.h"
 #include "swap_table.h"
 
+#include <trace/events/vmscan.h>
+
 int generic_swapfile_activate(struct swap_info_struct *sis,
 				struct file *swap_file,
 				sector_t *span)
@@ -248,8 +251,19 @@ int swap_writeout(struct swap_io_ctx *ctx, struct folio *folio)
 	}
 	rcu_read_unlock();
 
+	if (folio_test_dropbehind(folio)) {
+		/*
+		 * pageout() traces and accounts at its tail, which we can't do
+		 * because dropbehind folios may already be freed by then.
+		 */
+		trace_mm_vmscan_write_folio(folio);
+		lruvec_stat_mod_folio(folio, NR_VMSCAN_WRITE,
+				      folio_nr_pages(folio));
+		ret = SWAP_WRITE_DROPBEHIND;
+	}
+
 	__swap_writepage(ctx, folio);
-	return 0;
+	return ret;
 out_unlock:
 	folio_unlock(folio);
 	return ret;
@@ -692,8 +706,45 @@ EXPORT_SYMBOL_GPL(swap_fs_activate);
 
 void swap_write_submit(struct swap_io_ctx *ctx)
 {
-	if (!ctx->sio)
+	struct swap_iocb *sio = ctx->sio;
+	bool dropbehind = false;
+	int p;
+
+	if (!sio)
 		return;
+
+	for (p = 0; p < sio->nr_bvecs; p++) {
+		if (folio_test_dropbehind(bvec_folio(&sio->bvecs[p]))) {
+			dropbehind = true;
+			break;
+		}
+	}
+
+	if (dropbehind) {
+		/*
+		 * A dropbehind folio is freed by the completion, not by the
+		 * reclaimer, and freeing needs every deferred unmap flushed,
+		 * not just the writable ones try_to_unmap_flush_dirty() covers
+		 * before the IO.  The reclaimer flushes before it frees, but
+		 * that is too late for a batch swap_add_folio() already
+		 * submitted mid-loop.  A no-op once that flush has happened.
+		 */
+		try_to_unmap_flush();
+
+		/*
+		 * Now that the TLB is clean, drop the submitter's reference:
+		 * the swap cache then holds the only ones left, which is what
+		 * __remove_mapping() expects when the completion drops the
+		 * folio.  This has to happen before the write is submitted.
+		 */
+		for (p = 0; p < sio->nr_bvecs; p++) {
+			struct folio *folio = bvec_folio(&sio->bvecs[p]);
+
+			if (folio_test_dropbehind(folio))
+				folio_put(folio);
+		}
+	}
+
 	count_vm_events(NRSWPOUT, 1);
 	ctx->sis->ops->submit_write(ctx);
 	ctx->sio = NULL;
diff --git a/mm/swap.h b/mm/swap.h
index 8679cb61268e..81114ad9e44a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -92,6 +92,8 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 	return READ_ONCE(vm_swappiness);
 }
 
+#define SWAP_WRITE_DROPBEHIND	1
+
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a02f942418d3..5435fa5111b3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -613,6 +613,8 @@ typedef enum {
 	PAGE_SUCCESS,
 	/* folio is clean and locked */
 	PAGE_CLEAN,
+	/* folio will be freed after writeback, do not touch */
+	PAGE_DROPBEHIND,
 } pageout_t;
 
 /*
@@ -659,6 +661,9 @@ static pageout_t pageout(struct swap_io_ctx *ctx, struct address_space *mapping,
 	else
 		res = swap_writeout(ctx, folio);
 
+	if (res == SWAP_WRITE_DROPBEHIND)
+		return PAGE_DROPBEHIND;
+
 	if (res < 0)
 		handle_write_error(mapping, folio, res);
 	if (res == AOP_WRITEPAGE_ACTIVATE) {
@@ -1437,6 +1442,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					nr_pages = 1;
 				}
 				goto activate_locked;
+			case PAGE_DROPBEHIND:
+				nr_reclaimed += nr_pages;
+				continue;
 			case PAGE_SUCCESS:
 				if (nr_pages > 1 && !folio_test_large(folio)) {
 					sc->nr_scanned -= (nr_pages - 1);
@@ -2198,6 +2206,8 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
+		if (folio_test_anon(folio))
+			folio_clear_dropbehind(folio);
 		folio_putback_lru(folio);
 	}
 	trace_mm_vmscan_reclaim_pages(pgdat->node_id, sc.nr_scanned, nr_reclaimed, &stat);
diff --git a/mm/zswap.c b/mm/zswap.c
index dc8425d6b21e..640936fe7464 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1051,17 +1051,16 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	folio_set_dropbehind(folio);
 
 	/*
-	 * Drop our reference before starting writeback so the swap cache holds
-	 * the only one: the drop in folio_end_writeback() needs that for
-	 * remove_mapping_set_shadow() to succeed, otherwise the folio is
-	 * handed back to reclaim instead.
+	 * Our reference is donated to swap_write_submit(), which drops it just
+	 * before submitting so the swap cache holds the only one left: the drop
+	 * in folio_end_writeback() needs that for remove_mapping_set_shadow()
+	 * to succeed, otherwise the folio is handed back to reclaim instead.
 	 *
 	 * Nothing can free the folio in the meantime: we hold the folio lock
 	 * until writeback starts, PG_writeback then blocks swap cache removal,
 	 * and folio_end_writeback() takes its own reference before clearing
 	 * PG_writeback and donates it to the drop.
 	 */
-	folio_put(folio);
 
 	/* start writeback */
 	__swap_writepage(&ctx, folio);
-- 
2.53.0-Meta

