Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81923ABDB3;
	Tue, 18 Aug 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070891; cv=none; b=Lzr5rGbSx6RarlDiWgKMEfNhRs88GH3EGHsFQ+gGwBLf5CP6p7QAkvsvrzWRtE661ZkCzRlMRuYhoUMJmI95TEsWCHxGNzRR3NGZ7BLvyC8VjcEDx7xGP7eJ6egrzIevZg/0yjWJZk3xdS+mmkwLOwQdzCIPNlr6BnIVWS/ZRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070891; c=relaxed/simple;
	bh=qCcov4C+EJmz5RkzQZmLNoPEQhFkQhz6ypwDgh4r8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTVPZW4FCGpT5IVGJUBk2BybXvc3Sm3TMt3gJmbnoBuF4f7lINV4agsjqI896syI5Tp4YusKw2nAKWlEXDElY4t49NlZJx7NM0443UwhZc3721hOJ4gXnzKUN72SvUbwok5XCOSTqECYZtvljxvizVKm0nRc/0ESD0kLv3cB3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 143481F481;
	Tue, 18 Aug 2026 16:34:35 +0000 (UTC)
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on writeback completion
Date: Tue, 18 Aug 2026 18:31:59 +0200
Message-ID: <20260818163221.589352-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818163221.589352-1-alex@ghiti.fr>
References: <20260818163221.589352-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTFhwtGOHO/OC4b8xDhaenAw0ulkOus9FaFWHZYSGUVEHOu3uVHUJQDjV+J84J33ebDFlApYLH3YLEUqtWFmuQdSK1irj6MX1MBEbJLXzAQx7OObcE/toye+GUN3UEOmEvSmRNLLmpgVb+qXKjo52/AG6mFAh7FS744BvnTpNurRq3t6Hp8S0BAmC/gKyOBrbLNJozvfhAa3w3qU15mfEoNYHwE0OU5NKqOYfxUl3AOq79I2M2NeYOwJv2DcrCoGGhb/RilbXlq3sGiCkYnmrOYmu1bDDktDq70Sd5yAaOIv7w5aJ2t7nvcUB+FCfg2l/PUe7QukE+KWF1EEzPeHJ2btg9vlW+STU9yC5Cs3+QmYbozhoUFe+nbiPolMp2BTecDkYAIq8Dr/hRhfyNAix2PabZmNycCmH8UjorT7FxjvanfcDB3nioyaDKFBPdXgIzTVWkcJdo034m+JPXiYsATWDE7ueLpW5iKGr4TaXGWn4eSA+9VDjuchnMlHNUVFPV+HXSrwWJOOwhDpdtp8B0FaRp9bAaRUu6xH10huL+2jj4kFWVhvpJAKYcPB9o0YtDQFWuvwteRoK9h5eSEgdhKUEl30wNsPg41shBUrrvd3D/VGdbPhB/jHsckXzIK9fbbGtkLRLZa5XAfB+SqSKhWstNPkytd71T8FK/ooqzfHuQ
X-GND-State: clean

A PG_dropbehind folio is dropped from its cache once writeback completes
rather than left for reclaim to find later; this is implemented for file
folios in folio_end_dropbehind(). Extend it to swap cache folios.

The drop needs the folio and swap cluster locks and may sleep, but
writeback can complete in interrupt context, so defer the work to a
workqueue that runs once writeback has completed and frees the folios in
batches.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 fs/splice.c          |  2 +-
 include/linux/swap.h |  6 ++-
 mm/filemap.c         | 19 +++++++++
 mm/swap_state.c      | 94 ++++++++++++++++++++++++++++++++++++++++++++
 mm/truncate.c        |  2 +-
 mm/vmscan.c          | 13 ++++--
 6 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..79424bbee1b0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -90,7 +90,7 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 		 * If we succeeded in removing the mapping, set LRU flag
 		 * and return good.
 		 */
-		if (remove_mapping(mapping, folio)) {
+		if (remove_mapping(mapping, folio, false, NULL)) {
 			buf->flags |= PIPE_BUF_FLAG_LRU;
 			return true;
 		}
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6d72778e6cc3..25470634dd9d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -373,7 +373,8 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						unsigned long *nr_scanned);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
-long remove_mapping(struct address_space *mapping, struct folio *folio);
+long remove_mapping(struct address_space *mapping, struct folio *folio,
+		    bool reclaimed, struct mem_cgroup *target_memcg);
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
 extern int reclaim_register_node(struct node *node);
@@ -467,6 +468,8 @@ void swap_put_entries_direct(swp_entry_t entry, int nr);
  */
 bool folio_free_swap(struct folio *folio);
 
+void swap_writeback_dropbehind_folio(struct folio *folio);
+
 /* Allocate / free (hibernation) exclusive entries */
 swp_entry_t swap_alloc_hibernation_slot(int type);
 void swap_free_hibernation_slot(swp_entry_t entry);
@@ -477,6 +480,7 @@ static inline void put_swap_device(struct swap_info_struct *si)
 }
 
 #else /* CONFIG_SWAP */
+static inline void swap_writeback_dropbehind_folio(struct folio *folio) {}
 static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
 {
 	return NULL;
diff --git a/mm/filemap.c b/mm/filemap.c
index dc3a0e960b9f..aaffacdf5b1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1680,6 +1680,8 @@ EXPORT_SYMBOL_GPL(folio_end_writeback_no_dropbehind);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool swap_dropbehind;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1689,7 +1691,24 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+
+	/*
+	 * Dropbehind swap cache folios are off-LRU, so we must prevent a racing
+	 * swapin from removing the folio from the swap cache and keeping it
+	 * off-LRU: the writeback flag allows that. Afterwards a swapin may win
+	 * the race, but the folio is already queued and the worker puts it back
+	 * on the LRU in that case.
+	 */
+	swap_dropbehind = folio_test_swapcache(folio) &&
+			  folio_test_dropbehind(folio);
+
 	folio_end_writeback_no_dropbehind(folio);
+
+	if (swap_dropbehind) {
+		swap_writeback_dropbehind_folio(folio);
+		return;
+	}
+
 	folio_end_dropbehind(folio);
 	folio_put(folio);
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 90638a8d7232..b93dd607d24c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -16,6 +16,8 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/folio_batch.h>
+#include <linux/llist.h>
+#include <linux/workqueue.h>
 #include <linux/backing-dev.h>
 #include <linux/blkdev.h>
 #include <linux/migrate.h>
@@ -537,6 +539,98 @@ struct folio *__swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
 	return ret;
 }
 
+static DEFINE_PER_CPU(struct llist_head, swap_dropbehind_llist);
+
+static bool swap_dropbehind_drop_folio(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+	bool dropped = false;
+
+	folio_lock(folio);
+
+	/* The folio was allocated off the LRU and nothing re-adds it here. */
+	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	if (!mem_cgroup_tryget(memcg))
+		memcg = NULL;
+	rcu_read_unlock();
+
+	/*
+	 * Gate remove_mapping() on folio_test_swapcache(): a racing swapin may
+	 * have freed the swap slot (folio_free_swap()) and dropped the folio from
+	 * the cache, and remove_mapping() must not run on a non-swapcache folio
+	 * (it would trip __remove_mapping()'s mapping == folio_mapping() check).
+	 */
+	if (folio_test_swapcache(folio) && !folio_test_writeback(folio) &&
+	    remove_mapping(swap_address_space(folio->swap), folio, true, memcg)) {
+		dropped = true;
+	} else {
+		/* Raced: the folio is now owned by the swapin; put it back. */
+		folio_clear_dropbehind(folio);
+		folio_add_lru(folio);
+	}
+
+	mem_cgroup_put(memcg);
+
+	folio_unlock(folio);
+	if (!dropped)
+		folio_put(folio);
+	return dropped;
+}
+
+/**
+ * swap_dropbehind_free_batch_folio - free a dropbehind swap cache folio into a batch
+ * @folio: the off-LRU folio whose writeback has completed
+ * @fbatch: batch of folios to free, flushed when full
+ */
+static void swap_dropbehind_free_batch_folio(struct folio *folio,
+					     struct folio_batch *fbatch)
+{
+	if (swap_dropbehind_drop_folio(folio) && !folio_batch_add(fbatch, folio))
+		folios_put(fbatch);
+}
+
+static void swap_dropbehind_workfn(struct work_struct *work)
+{
+	struct folio_batch fbatch;
+	struct llist_node *pos, *next;
+	int cpu;
+
+	folio_batch_init(&fbatch);
+	for_each_possible_cpu(cpu) {
+		pos = llist_del_all(per_cpu_ptr(&swap_dropbehind_llist, cpu));
+		llist_for_each_safe(pos, next, pos) {
+			struct folio *folio = container_of((struct list_head *)pos,
+							   struct folio, lru);
+			swap_dropbehind_free_batch_folio(folio, &fbatch);
+		}
+	}
+	if (fbatch.nr)
+		folios_put(&fbatch);
+}
+
+static DECLARE_WORK(swap_dropbehind_work, swap_dropbehind_workfn);
+static struct workqueue_struct *swap_dropbehind_wq;
+
+void swap_writeback_dropbehind_folio(struct folio *folio)
+{
+	llist_add((struct llist_node *)&folio->lru,
+		  raw_cpu_ptr(&swap_dropbehind_llist));
+	queue_work(swap_dropbehind_wq, &swap_dropbehind_work);
+}
+
+static int __init swap_dropbehind_init(void)
+{
+	swap_dropbehind_wq = alloc_workqueue("swap_dropbehind",
+					     WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+	if (!swap_dropbehind_wq)
+		return -ENOMEM;
+	return 0;
+}
+core_initcall(swap_dropbehind_init);
+
 /*
  * If we are the only user, then try to free up the swap cache.
  *
diff --git a/mm/truncate.c b/mm/truncate.c
index b58ba940be47..37f7d8278c1c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -336,7 +336,7 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
 	if (!filemap_release_folio(folio, 0))
 		return 0;
 
-	return remove_mapping(mapping, folio);
+	return remove_mapping(mapping, folio, false, NULL);
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3f3ff25e561a..37b093c4628c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -789,17 +789,24 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
  * remove_mapping() - Attempt to remove a folio from its mapping.
  * @mapping: The address space.
  * @folio: The folio to remove.
+ * @reclaimed: Whether the folio is being reclaimed (record a shadow).
+ * @target_memcg: The memcg to charge the eviction shadow to when @reclaimed;
+ *                the caller must keep it alive across the call. Ignored (may
+ *                be NULL) when @reclaimed is false.
  *
  * If the folio is dirty, under writeback or if someone else has a ref
- * on it, removal will fail.
+ * on it, removal will fail. When @reclaimed is true, a workingset eviction
+ * shadow is stored (like page reclaim does) so that a later refault can be
+ * detected and the folio re-activated.
  * Return: The number of pages removed from the mapping.  0 if the folio
  * could not be removed.
  * Context: The caller should have a single refcount on the folio and
  * hold its lock.
  */
-long remove_mapping(struct address_space *mapping, struct folio *folio)
+long remove_mapping(struct address_space *mapping, struct folio *folio,
+		    bool reclaimed, struct mem_cgroup *target_memcg)
 {
-	if (__remove_mapping(mapping, folio, false, NULL)) {
+	if (__remove_mapping(mapping, folio, reclaimed, target_memcg)) {
 		/*
 		 * Unfreezing the refcount with 1 effectively
 		 * drops the pagecache ref for us without requiring another
-- 
2.53.0-Meta

