Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450343515C2;
	Fri, 11 Sep 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128908; cv=none; b=LdbtP1rXHz8eEMP8vnOqkgigJ3U258pj2m1RQW3JIMywOckDHbTGSibGlIGxS3jQrp3Ux+7gvP9q7I40UweVTw5G7hIbo1EJScI3+frCRCbqawM6lBHl13DxUwavVgbz2Vg5+C65jDiYWbms8sY6s8I2gTaDl7+5LYkpTsbqoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128908; c=relaxed/simple;
	bh=xe7RTnGJ07oHf8k2Dj/sAgJUe+EDTT6QFFlh85x6Crg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YS0rRQDC6bvi6LwCGzFOk4Za2W3iXqgfyioPVHIhgvncuFZ+h3VtRD6A1nPCSN3jUC30MYsCaGLK8i1y5qeUHo+7vPWKthr3co34HxqGmGiZyQBH+1bbMBo4jeGpT28acPBeeCgX9ugHdjTDG1MLXRBW5NNSyDcQWuP+qPfYEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBC853EE31;
	Fri, 11 Sep 2026 12:14:51 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Tal Zussman <tz2294@columbia.edu>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v5 1/3] mm: swap: move LRU insertion out of the swap cache allocator
Date: Fri, 11 Sep 2026 14:13:28 +0200
Message-ID: <20260911121341.178028-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911121341.178028-1-alex@ghiti.fr>
References: <20260911121341.178028-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEHRPri608QdqX6Uj/BbR+hiAEqvAJNom1pMUaPCDF92wYu3ptg6D8gDZW2m7AvuQwIR2KkJm7RAJk3qeVC81VqEBriyq2Xdjp0AkofstRRVIHILe7cZr6l7t4f+ZKKWwj7745VQLOUqBJD9XxbkV5akW9m/vZnNgm4vNpb9ydmOxvLDanCIkyPQkljOkGS/d6zP/hgl5t79Smmd9JlhTybu2Diwh+eRj0dOJKXMe8t0uExHKdrFvDVypESTLCitwfT3LQsgEesG/8CTTaCUNDOth3Vv6FT5jDyJo9k/tttrmUE3LC7BxoOrohdZXA7bWgJIy8/L4PoQV6JuGOeZNVrAydr/M/Unk1WMzvuPcjb4Hd4uk4M8iOuPTUmHhjU58cXIEjZeyJQlaRrUBY4zkTuVoehOKQUGCsV/ONEYVrKv39Wks4nHPDUS0ZmY3jXR5P9iw2byjlaTIr8qSHXgVNi5xOmkBeXJIaZiWXzFL2loFPw3GIhhYeAfYEAmy33dbUQ6iFfIo2XbUY2HE3oNuYwAZAODPAkv5Bhv/RITaIy5Y+VlE1InwPCj2LkbRYK3uzszINY0nDeIfQcwUcEpxtypI2L+HqLeS5xdm/9y3UY7NELZObB8MtI7hIjPwJZaDK6DL2EH80xTRXH1V0rF+eyEV92wcx2Y57t8IV5lQJk5g

This is a preparatory patch.

__swap_cache_alloc_folio() adds the new folio to the LRU itself, which
leaves its callers no way to act on the folio before it becomes visible
to reclaim.  Two users need exactly that:

 - moving the refault evaluation out of the swap cache folio allocation
   requires it to happen before folio_add_lru(): that consumes PG_active
   to file the folio on the inactive or the active list, and under MGLRU
   it also reads PG_workingset to pick the generation.  Setting either
   flag afterwards does not move the folio;

 - zswap writeback dropbehind needs the buffer folio to stay off the LRU
   entirely, as the per-CPU LRU batch would hold a reference on it and
   keep remove_mapping() from freeing it once writeback completes.

Defer the LRU insertion to the callers of __swap_cache_alloc_folio():
each of them adds the folio right after the allocation, so there is no
functional change intended.

Suggested-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/swap.h       |  6 +++---
 mm/swap_state.c | 20 ++++++++++++--------
 mm/swapfile.c   |  2 +-
 mm/zswap.c      |  5 +++--
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 90a551a88df6..8679cb61268e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -312,9 +312,9 @@ bool swap_cache_has_folio(swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
 void swap_cache_del_folio(struct folio *folio);
-struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
-				     unsigned long orders, struct vm_fault *vmf,
-				     struct mempolicy *mpol, pgoff_t ilx);
+struct folio *__swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
+				       unsigned long orders, struct vm_fault *vmf,
+				       struct mempolicy *mpol, pgoff_t ilx);
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f3961fdd857d..e5b7fa468ade 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -489,13 +489,11 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 
-	/* Caller will initiate read into locked new_folio */
-	folio_add_lru(folio);
 	return folio;
 }
 
 /**
- * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
+ * __swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
  * @targ_entry: swap entry indicating the target slot
  * @gfp: memory allocation flags
  * @orders: allocation orders, must be non zero
@@ -507,13 +505,17 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
  * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
  * @targ_entry must have a non-zero swap count (swapped out).
  *
+ * The returned folio is locked and is NOT on the LRU. The caller must either
+ * add it to the LRU with folio_add_lru() so page reclaim can find it, or free
+ * it directly once done; a folio left off the LRU is unreclaimable and leaks.
+ *
  * Context: Caller must protect the swap device with reference count or locks.
  * Return: Returns the folio if allocation succeeded and folio is in the swap
  * cache. Returns error code if failed due to race, OOM or invalid arguments.
  */
-struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
-				     unsigned long orders, struct vm_fault *vmf,
-				     struct mempolicy *mpol, pgoff_t ilx)
+struct folio *__swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
+				       unsigned long orders, struct vm_fault *vmf,
+				       struct mempolicy *mpol, pgoff_t ilx)
 {
 	int order, err;
 	struct folio *ret;
@@ -649,12 +651,13 @@ static struct folio *swap_cache_read_folio(struct swap_io_ctx *ctx,
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			return folio;
-		folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
+		folio = __swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR_OR_NULL(folio))
 		return NULL;
 
+	folio_add_lru(folio);
 	swap_read_folio(ctx, folio);
 	if (readahead) {
 		folio_set_readahead(folio);
@@ -690,12 +693,13 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			return folio;
-		folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
+		folio = __swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR(folio))
 		return folio;
 
+	folio_add_lru(folio);
 	swap_read_folio(&ctx, folio);
 	swap_read_submit(&ctx);
 	return folio;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 53bf01d5f7f1..d678a40fcaac 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1870,7 +1870,7 @@ void folio_put_swap(struct folio *folio, struct page *page)
  *   CPU1				CPU2
  *   do_swap_page()
  *     ...				swapoff+swapon
- *     swap_cache_alloc_folio()
+ *     __swap_cache_alloc_folio()
  *       // check swap_map
  *     // verify PTE not changed
  *
diff --git a/mm/zswap.c b/mm/zswap.c
index 37f34e406c8e..0d2efe21f18a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1001,8 +1001,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -EEXIST;
 
 	mpol = get_task_policy(current);
-	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
-				       NO_INTERLEAVE_INDEX);
+	folio = __swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
+					 NO_INTERLEAVE_INDEX);
 	put_swap_device(si);
 
 	/*
@@ -1014,6 +1014,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 */
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
+	folio_add_lru(folio);
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
-- 
2.53.0-Meta

