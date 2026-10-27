Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122263;
	b=pzro98yz/DhvENOPwR0gGATGvCKLmXqLl86SleNFBbmCBUTmCZyMyK7DOD6omm33yVBu
	 xqe+5BczohH81Rdn49RfoodCw95ENKdz2Y3vIsYWwBpUjSzLIIxpNrhgG21oQcTgvhKKH
	 14CXo0Ccx1KadUTR9im1fvhc0ypKiE2pMfv3SOluniUAZrrD3HDSSK06sNe6FBqYP3dlC
	 EBrmESku9hWZSk6owSayC6oxs+TTBaZ2j+0aNvE1jEooola6pTSaHeHzVf6GcuDuunmRU
	 PR4o/8Eu+ludzNhhLPQJ+Et2A1Q78M8etw06ANAzCgJ3wcZsyI+Eu84HG1oMlQKJEPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0FxSL0MdIFT3YqQ6rFC+3X+II8bjQEN1UeBYeSrjwsA=;
	b=npOa+sS8WSArzQi00ZsNKsoKNTFaKruaU/0sEKpVKl5ionHJO9wbDLjds2Oarylyi2cE
	 bg1QbM8awB/bmOW9+AfOgfbVcsrJpolkrYtNpulONfi+P+E1WuO7BB8oVmj39up8cfkl1
	 2X3qJ48SEKgCtaO/xWZRREuUCMfGwAnyhBaVwx7ZtVOnfwoH12BHUswybNemsLKouDA5K
	 RdqOhTiPmAsBqagvmzQBS7U60ZEZuWywIZ9tTVBSwyfCk/U7w2GReFnFlJ70VEYhjUxvJ
	 Uc9RSkWJudfgdcRI+e11KdlED7q01HMX5vJVUzF+ayaN0q645QshSqF/hhymD2+lJGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jreo/L3e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97543606A320;
	Tue, 27 Oct 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jreo/L3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BA31F01825;
	Tue, 27 Oct 2026 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122261;
	bh=0FxSL0MdIFT3YqQ6rFC+3X+II8bjQEN1UeBYeSrjwsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jreo/L3e5xwWTvSvRS206htvxymahCL0ryi4wO8XiG0exKfY8QEdWdab98t8wWAZV
	 WAOicGqJ6dUYBtdyE/Jxb1L0snF2sLRyi93Kz4l6jOWZZ+VKIeuOyoHXItffNbHN2K
	 PaQ9UYzd5TexHNoEkNOEYdiVzlxbJZrW6LFLGHQMYC6osGRwpGTT4R5qrL0VUiz/Ke
	 +2YmV9tF9GRkFFZAvbPB2sjJSGU4gz/ksw08mwaPzEQuLzi7izEhDNiTiKtuuU/yPv
	 Odh53wXbLHPEWPTzSPH1RxI7IUWHnSpMCUycOtz5VdRRUD7N+QBbkPDAVateqn1kCj
	 6DEC6HT5irkZw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: [PATCH 2/3] mm: allow freezing i_pages
Date: Tue, 27 Oct 2026 18:30:27 +0100
Message-ID: <20261027173031.763213-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027173031.763213-1-pratyush@kernel.org>
References: <20261027173031.763213-1-pratyush@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Live update preserves file-backed memory across kexec by serializing the
index -> folio relationship of the file's page cache. Once serialized, the
page cache must not change, otherwise the serialized data goes stale. memfd
preservation currently does this with a shmem-only flag that just blocks
size changes and fallocate. This leaves other paths that change the page
cache, like reclaim, migration, and THP split and collapse, unchecked. It
also can't be reused for hugetlb or guest_memfd preservation.

Add AS_FROZEN, a mapping flag that freezes the page cache. While it is
set, no folio can be added to, removed from, or replaced in the mapping.
Check it in the core paths that change i_pages and refuse the change
there. The flag is set and cleared under the i_pages lock.

Setting the flag can race with truncation or fallocate, causing them to
fail mid-way. The file systems must ensure that these operations don't
race with the flag setter.

The freezer must hold a reference to the inode until it is unfrozen.
This is because eviction will naturally result in changes to i_pages.
Evicting a frozen inode is a bug and will trigger a warning, but it
still frees the pages to avoid leaking memory.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 fs/inode.c              |  9 +++++++++
 include/linux/pagemap.h | 35 +++++++++++++++++++++++++++++++++++
 mm/filemap.c            |  7 +++++++
 mm/huge_memory.c        | 10 ++++++++++
 mm/khugepaged.c         | 12 ++++++++++++
 mm/migrate.c            | 14 ++++++++++++--
 mm/shmem.c              | 19 +++++++++++++++++++
 mm/truncate.c           | 16 +++++++++++++++-
 mm/vmscan.c             |  3 +++
 9 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a9d37be390a17..635083c42419f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/filelock.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/backing-dev.h>
 #include <linux/hash.h>
 #include <linux/swap.h>
@@ -818,6 +819,14 @@ static void evict(struct inode *inode)
 	inode_wait_for_writeback(inode);
 	spin_unlock(&inode->i_lock);
 
+	/*
+	 * Whoever froze the mapping must hold an inode reference until it is
+	 * unfrozen, so this should never happen. If it does, unfreeze it so
+	 * the final truncate does not leak folios.
+	 */
+	if (WARN_ON_ONCE(mapping_frozen(&inode->i_data)))
+		clear_bit(AS_FROZEN, &inode->i_data.flags);
+
 	if (op->evict_inode) {
 		op->evict_inode(inode);
 	} else {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 73af18a373670..9b9d0459f3992 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -209,6 +209,7 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
+	AS_FROZEN = 11,		/* index -> folio mapping must not change */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -344,6 +345,40 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
+/*
+ * A frozen mapping disallows any change to its i_pages: no folio can be added,
+ * removed, replaced (migration, swap out), split, or collapsed.
+ *
+ * Only the page cache is frozen, not the file. Operations that need to change
+ * the page cache fail with -EBUSY, e.g. a write or fault that needs to allocate
+ * a new folio. Others, like reading or writing (to pages already in i_pages),
+ * still work.
+ *
+ * Locking: the flag is flipped under the i_pages lock. The filesystem must
+ * ensure mapping_set_frozen() doesn't race with a truncate or fallocate, since
+ * those can fail if frozen mid-way.
+ *
+ * The mapping must be unfrozen before the inode is evicted.
+ */
+static inline void mapping_set_frozen(struct address_space *mapping)
+{
+	xa_lock_irq(&mapping->i_pages);
+	set_bit(AS_FROZEN, &mapping->flags);
+	xa_unlock_irq(&mapping->i_pages);
+}
+
+static inline void mapping_clear_frozen(struct address_space *mapping)
+{
+	xa_lock_irq(&mapping->i_pages);
+	clear_bit(AS_FROZEN, &mapping->flags);
+	xa_unlock_irq(&mapping->i_pages);
+}
+
+static inline bool mapping_frozen(const struct address_space *mapping)
+{
+	return test_bit(AS_FROZEN, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6..d040c69177f79 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -138,6 +138,7 @@ static void page_cache_delete(struct address_space *mapping,
 	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(mapping_frozen(mapping), folio);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
@@ -284,6 +285,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 	int i = 0;
 	struct folio *folio;
 
+	VM_WARN_ON_ONCE(mapping_frozen(mapping));
 	mapping_set_update(&xas, mapping);
 	xas_for_each(&xas, folio, ULONG_MAX) {
 		if (i >= folio_batch_count(fbatch))
@@ -826,6 +828,7 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 	mem_cgroup_replace_folio(old, new);
 
 	xas_lock_irq(&xas);
+	VM_WARN_ON_ONCE_FOLIO(mapping_frozen(mapping), old);
 	xas_store(&xas, new);
 
 	old->mapping = NULL;
@@ -873,6 +876,10 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		void *entry, *old = NULL;
 
 		xas_lock_irq(&xas);
+		if (unlikely(mapping_frozen(mapping))) {
+			xas_set_err(&xas, -EBUSY);
+			goto unlock;
+		}
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
 			if (!xa_is_value(entry)) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..06d2f71ec7498 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3948,6 +3948,10 @@ int folio_check_splittable(struct folio *folio, unsigned int new_order,
 	if (!folio->mapping && !is_anon)
 		return -EBUSY;
 
+	/* Splitting would change a frozen mapping. */
+	if (!folio_test_anon(folio) && mapping_frozen(folio->mapping))
+		return -EBUSY;
+
 	/* order-1 is not supported for anonymous THP. */
 	if (is_anon && new_order == 1)
 		return -EINVAL;
@@ -4186,6 +4190,12 @@ static int __folio_freeze_split_file(struct folio *folio,
 
 	xas_lock_irq(&xas);
 
+	/* Can't change a frozen mapping. */
+	if (mapping_frozen(mapping)) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
 	/*
 	 * Check if the folio is present in page cache.
 	 * We assume all tail are present too, if folio is there.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index da91762f6358f..5c78573f57c47 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2531,6 +2531,12 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		i_mmap_lock_read(mapping);
 		xas_lock_irq(&xas);
 
+		/* Can't collapse folios in a frozen mapping. */
+		if (mapping_frozen(mapping)) {
+			result = SCAN_FAIL;
+			goto immap_locked;
+		}
+
 		xas_set(&xas, start);
 		for (index = start; index < end; index++) {
 			if (!xas_next(&xas)) {
@@ -2582,6 +2588,12 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	} else {
 		xas_lock_irq(&xas);
+		/* Can't collapse folios in a frozen mapping. */
+		if (mapping_frozen(mapping)) {
+			xas_unlock_irq(&xas);
+			result = SCAN_FAIL;
+			goto rollback;
+		}
 	}
 
 	if (is_shmem) {
diff --git a/mm/migrate.c b/mm/migrate.c
index d649a6cfce6c0..6ce01871d72e3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -614,10 +614,16 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	oldzone = folio_zone(folio);
 	newzone = folio_zone(newfolio);
 
-	if (folio_test_swapcache(folio))
+	if (folio_test_swapcache(folio)) {
 		ci = swap_cluster_get_and_lock_irq(folio);
-	else
+	} else {
 		xas_lock_irq(&xas);
+		/* Can't replace folios in a frozen mapping. */
+		if (mapping_frozen(mapping)) {
+			xas_unlock_irq(&xas);
+			return -EBUSY;
+		}
+	}
 
 	if (!folio_ref_freeze(folio, expected_count)) {
 		if (ci)
@@ -750,6 +756,10 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 		return rc;
 
 	xas_lock_irq(&xas);
+	if (mapping_frozen(mapping)) {
+		xas_unlock_irq(&xas);
+		return -EBUSY;
+	}
 	if (!folio_ref_freeze(src, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
diff --git a/mm/shmem.c b/mm/shmem.c
index 13e0786436cda..6507b4246c8af 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1121,6 +1121,10 @@ int shmem_add_to_page_cache(struct folio *folio,
 	do {
 		iter = swap;
 		xas_lock_irq(&xas);
+		if (unlikely(mapping_frozen(mapping))) {
+			xas_set_err(&xas, -EBUSY);
+			goto unlock;
+		}
 		xas_for_each_conflict(&xas, entry) {
 			/*
 			 * The range must either be empty, or filled with
@@ -1345,6 +1349,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
 
+	/* Callers must not try to truncate a frozen mapping. */
+	if (WARN_ON_ONCE(mapping_frozen(mapping)))
+		return;
+
 	if (info->fallocend > start && info->fallocend <= end && !unfalloc)
 		info->fallocend = start;
 
@@ -1822,6 +1830,10 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 	if ((info->flags & SHMEM_F_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
+	/* Swapping out would replace the folio in a frozen mapping. */
+	if (mapping_frozen(mapping))
+		goto redirty;
+
 	if (!total_swap_pages)
 		goto redirty;
 
@@ -2483,6 +2495,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (softleaf_is_poison_marker(index_entry))
 		return -EIO;
 
+	/*
+	 * Swapping in would change the i_pages of a frozen mapping. A frozen
+	 * mapping should not have swap entries in the first place.
+	 */
+	if (unlikely(mapping_frozen(mapping)))
+		return -EBUSY;
+
 	si = get_swap_device(index_entry);
 	order = shmem_confirm_swap(mapping, index, index_entry);
 	if (IS_ERR_OR_NULL(si)) {
diff --git a/mm/truncate.c b/mm/truncate.c
index 733d2713a875a..6512f460a28e9 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -171,6 +171,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 {
 	if (folio->mapping != mapping)
 		return -EIO;
+	if (mapping_frozen(mapping))
+		return -EBUSY;
 
 	truncate_cleanup_folio(folio);
 	filemap_remove_folio(folio);
@@ -367,6 +369,8 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
 		return 0;
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
+	if (mapping_frozen(mapping))
+		return 0;
 	/* The refcount will be elevated if any page in the folio is mapped */
 	if (folio_ref_count(folio) >
 			folio_nr_pages(folio) + folio_has_private(folio) + 1)
@@ -419,6 +423,13 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	if (mapping_empty(mapping))
 		return;
 
+	/*
+	 * Callers must not try to truncate a frozen mapping. Filesystems that
+	 * support frozen mappings must refuse shrinking and hole punching
+	 * before getting here.
+	 */
+	if (WARN_ON_ONCE(mapping_frozen(mapping)))
+		return;
 	/*
 	 * 'start' and 'end' always covers the range of folios to be fully
 	 * truncated, with both boundaries aligned inwards to 1 << min_order.
@@ -668,6 +679,9 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
+	if (mapping_frozen(mapping))
+		return -EBUSY;
+
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 	BUG_ON(folio_mapped(folio));
@@ -682,7 +696,7 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
-	if (folio_test_dirty(folio))
+	if (folio_test_dirty(folio) || mapping_frozen(mapping))
 		goto failed;
 
 	BUG_ON(folio_has_private(folio));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9959ca158ce83..86ef233e8752e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -766,6 +766,9 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	} else {
 		spin_lock(&mapping->host->i_lock);
 		xa_lock_irq(&mapping->i_pages);
+		/* Can't remove folios from a frozen mapping. */
+		if (mapping_frozen(mapping))
+			goto cannot_free;
 	}
 
 	/*
-- 
2.56.0.307.g5fe7bd680c-goog

