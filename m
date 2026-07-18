Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D652DB794;
	Sat, 18 Jul 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784367517; cv=none; b=CctYxBp306eNoqkClvfGM3frIaVVFI1jB9pdLOjv41x5cMT5LFqjd0g73UwdDlHiIw0FPc64Gs79LhW1vqhIXgDTlwoXT5LBNMhHugGCW+pWo1pZdLNm10DuRdRUx/3etyLUoENHakpK/uL0I+RfZ4k2qq8gwRwM6gru7eiP+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784367517; c=relaxed/simple;
	bh=Qe2Fxah14LGu4dBIHuSah3xiD1bYpX7Ih6N7sodC16Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWjfRfmST2IHZYZGLOLDnyZCTrMBHwDmSqc0n1TQIJTUXNkxifkwV4pgUq/E5Doi0n7VcAKWJ3KfxpYqqt+iEO+ZZ2A+XkddwzCVgRjpK+YVuc2NS8xUTYPblf0bIVAoh48v/Ob7F8H+LESnfzm6cuoARZtxCByU7G0YqXhQzdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 943683E83F;
	Sat, 18 Jul 2026 09:38:30 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
Date: Sat, 18 Jul 2026 11:36:39 +0200
Message-ID: <20260718093723.153324-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718093723.153324-1-alex@ghiti.fr>
References: <20260718093723.153324-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTGcSX6vKILToVNLKv1WVPr1SLvH8b57oTAO36Gk4UblSlEX77LNjuus2BGSuIvHmZSDj1TAAMWrqX7a9ejMqnV2sgjNpYBgRTOUDhHor/NZgx2haNGmPfXI+/8Of3s5OTjnrXd8cA5uRa0uZD5Zhvc9KKuHCjh/O1uiaj+MAvlwvi8geUDxVqCCbrlKBuWwENz68kowJ0XX4rv2LjHoK5nnw076u9td5NYgNN5IAmYT65mIXMNzcc9vBow3LjNztLEJOuaPxpZ41t1oee+ZYYtUtrHAmHR7xNQJ19JIsGn3ybuJbGsigcBoqzqvMe8U3+ndawTRVAzvm31EIyHRupvEbwxNbkeg3qeOvMA60SZF2VvCZif4C/08OnstATEDWYzSlsct8OzpJfCcqUbYU6e2PcXcymysMo+Q9083MG9iFOCvYolxfBHiUfYsvzwY6v382EHsRu+MASnfiw843kqxisCfYaHuV4Mek1pSreeG21svdQUH9o8oK9ti1zM+7oag99/uvcUEdMW6qUdGDSRTFEnxl0dr0TlJzQrckb2D6ecSgEP77wPA+ibYElCtqHQPB0o4xHdeV9Mm7+mdg9S64GLW3oYjcO1//vzcUC1d1Tg0hwiYAVrx2BKOSjGFEAwoOLA2Bu6CF5n0G1mLS/yA3EO0Ab0cs/4zLg3yZ+yFcg
X-GND-State: clean

When zswap writes an entry back, it allocates a swap cache folio,
decompresses the entry into it and writes it out. That folio is cold by
construction, but it is currently left on the LRU for page reclaim to find
and free later. This wastes a reclaim scan and keeps cold memory resident
longer than necessary.

For synchronous-IO swap devices writeback completes in the calling context,
so the folio can be freed right after the write rather than left behind; do
that. Because it is freed directly rather than through reclaim, it is
allocated off the LRU: dropping the last reference on a folio still on the
LRU would trip the free-time page-flag checks. A folio that a concurrent
swapin has meanwhile claimed is left in place and reclaimed as usual.

Asynchronous and filesystem-backed swap complete writeback in interrupt
context, where the folio cannot be freed; they are handled in a later
change.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/swap.h       |  3 ++-
 mm/swap_state.c | 17 +++++++++++------
 mm/zswap.c      | 36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 77d2d14eda42..c617e5a0257f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -306,7 +306,8 @@ void *swap_cache_get_shadow(swp_entry_t entry);
 void swap_cache_del_folio(struct folio *folio);
 struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
 				     unsigned long orders, struct vm_fault *vmf,
-				     struct mempolicy *mpol, pgoff_t ilx);
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool skip_lru);
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 9c3a5cf99778..048efc7ca612 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -403,7 +403,8 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 					swp_entry_t targ_entry, gfp_t gfp,
 					unsigned int order, struct vm_fault *vmf,
-					struct mempolicy *mpol, pgoff_t ilx)
+					struct mempolicy *mpol, pgoff_t ilx,
+					bool skip_lru)
 {
 	int err;
 	swp_entry_t entry;
@@ -484,7 +485,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 
 	/* Caller will initiate read into locked new_folio */
-	folio_add_lru(folio);
+	if (!skip_lru)
+		folio_add_lru(folio);
 	return folio;
 }
 
@@ -507,7 +509,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
  */
 struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
 				     unsigned long orders, struct vm_fault *vmf,
-				     struct mempolicy *mpol, pgoff_t ilx)
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool skip_lru)
 {
 	int order, err;
 	struct folio *ret;
@@ -522,7 +525,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
 
 	do {
 		ret = __swap_cache_alloc(ci, targ_entry, gfp, order,
-					 vmf, mpol, ilx);
+					 vmf, mpol, ilx, skip_lru);
 		if (!IS_ERR(ret))
 			break;
 		err = PTR_ERR(ret);
@@ -643,7 +646,8 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			return folio;
-		folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
+		folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx,
+					       false);
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR_OR_NULL(folio))
@@ -683,7 +687,8 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			return folio;
-		folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
+		folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx,
+					       false);
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR(folio))
diff --git a/mm/zswap.c b/mm/zswap.c
index 761cd699e0a3..3c494c5a671c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -972,6 +972,30 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 /*********************************
 * writeback code
 **********************************/
+static void zswap_writeback_free_folio(struct folio *folio)
+{
+	folio_lock(folio);
+
+	/* The folio was allocated off the LRU and nothing re-adds it here. */
+	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
+
+	/*
+	 * Gate remove_mapping() on folio_test_swapcache(): a racing swapin may
+	 * have freed the swap slot (folio_free_swap()) and dropped the folio from
+	 * the cache, and remove_mapping() must not run on a non-swapcache folio
+	 * (it would trip __remove_mapping()'s mapping == folio_mapping() check).
+	 */
+	if (folio_test_swapcache(folio) &&
+	    remove_mapping(swap_address_space(folio->swap), folio))
+		goto out;
+
+	/* Raced: the folio is now owned by the swapin; put it back on the LRU. */
+	folio_add_lru(folio);
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
 /*
  * Attempts to free an entry by adding a folio to the swap cache,
  * decompressing the entry data into the folio, and issuing a
@@ -992,16 +1016,18 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	struct swap_info_struct *si;
+	bool sync;
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
 	if (!si)
 		return -EEXIST;
+	sync = data_race(si->flags & SWP_SYNCHRONOUS_IO);
 
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
-				       NO_INTERLEAVE_INDEX);
+				       NO_INTERLEAVE_INDEX, sync);
 	put_swap_device(si);
 
 	/*
@@ -1046,11 +1072,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	folio_mark_uptodate(folio);
 
 	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	if (!sync)
+		folio_set_reclaim(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, NULL);
 
+	if (sync) {
+		zswap_writeback_free_folio(folio);
+		return 0;
+	}
+
 out:
 	if (ret) {
 		swap_cache_del_folio(folio);
-- 
2.53.0-Meta

