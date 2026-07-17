Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA673AD534
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269896; cv=none; b=GVwNlw5c5nWaaQiA4oG604xCzMEKhsuBtFIogNiBKwkYrWA3ftHFh3Sa1OFWEKWDHF2vGRrYCRi8GRTwtcOJMZqeqIbQMbOixrFAUuSMmWW5YLUSLVg9woLWekKflWFa6IBg1nTZKN6Lv9+rMOxVY/eR1O48qWugrZ2V6bhHVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269896; c=relaxed/simple;
	bh=Svg2Y8wTOAGd6IPOnPBio+4QPIkpbi2qYQQnU1fR04c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyBwQeUTQjJvPW7PYmEuoazp9MX1eKXyq77k73FvpzSTgyKXN2y6xPXe3w5ioSUIRUX8/WKR3x1Lue/mmS1Hx9cWEXWDJHpyfFpzRJ1koPHNWMJECq3P5oFBX10/GLCvL+qUl3ZbblE4UIT/tJ+pLd6him8BetD/IKRsk7bXwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iAvO9NTL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iAvO9NTL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784269881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dtmAsjOZRbEJt8owf9zTbDLUylJSS4K6ysbF5XED/rI=;
	b=iAvO9NTLFOK4wGbutvHypW4H3LqgyMz7jH7ChYnLbA1a/WW3fuZGVu8gEBVzvQ/eEJ84MB
	MSCnUKkJxgUdDk1nIXK1SgnSg9+8ULO2/U3LtacoMyIdP9RbvNPJfbhl/aXdjrrHSK71Bg
	CxTdNRpZVLcyW4kVejoPPvf7RBpjkrk=
From: Ye Liu <ye.liu@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm/thp: expose deferred split folio memory usage in meminfo
Date: Fri, 17 Jul 2026 14:30:22 +0800
Message-ID: <20260717063025.168436-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Folios on the deferred split list hold physical memory that is
invisible in meminfo. When a THP becomes partially mapped, the
unmapped pages are removed from AnonPages but remain physically
allocated until the shrinker splits the folio. This creates a
memory accounting gap where used memory cannot be attributed to
any meminfo field.

Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
folios currently on the deferred_split_lru, updated via
mod_node_page_state() at all enqueue/dequeue points. The new field
DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
per-node /sys/devices/system/node/node*/meminfo.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 drivers/base/node.c    |  4 +++-
 fs/proc/meminfo.c      |  2 ++
 include/linux/mmzone.h |  1 +
 mm/huge_memory.c       | 24 +++++++++++++++++++++---
 mm/vmstat.c            |  1 +
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 3da91929ad4e..69463438300e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -519,6 +519,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d ShmemPmdMapped: %8lu kB\n"
 			     "Node %d FileHugePages:  %8lu kB\n"
 			     "Node %d FilePmdMapped:  %8lu kB\n"
+			     "Node %d DeferredSplitPages: %8lu kB\n"
 #endif
 #ifdef CONFIG_UNACCEPTED_MEMORY
 			     "Node %d Unaccepted:     %8lu kB\n"
@@ -553,7 +554,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
-			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
+			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED)),
+			     nid, K(node_page_state(pgdat, NR_DEFERRED_SPLIT_PAGES))
 #endif
 #ifdef CONFIG_UNACCEPTED_MEMORY
 			     ,
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b2813ff13cb2..76dbf51ad1e0 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -149,6 +149,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED));
+	show_val_kb(m, "DeferredSplitPages: ",
+		    global_node_page_state(NR_DEFERRED_SPLIT_PAGES));
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0507193b3ae3..1e75adb73d00 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -267,6 +267,7 @@ enum node_stat_item {
 	NR_FILE_THPS,
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	NR_DEFERRED_SPLIT_PAGES, /* THP/mTHP pages pending deferred split */
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c642bec967fa..1094b844675c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -77,6 +77,14 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
 static bool split_underused_thp = true;
 
+#define deferred_split_pages_add(folio) \
+	mod_node_page_state(NODE_DATA(folio_nid(folio)), \
+			    NR_DEFERRED_SPLIT_PAGES, folio_nr_pages(folio))
+
+#define deferred_split_pages_del(folio) \
+	mod_node_page_state(NODE_DATA(folio_nid(folio)), \
+			    NR_DEFERRED_SPLIT_PAGES, -folio_nr_pages(folio))
+
 static atomic_t huge_zero_refcount;
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
@@ -3913,8 +3921,10 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 		struct lruvec *lruvec;
 
 		if (dequeue_deferred) {
-			__list_lru_del(&deferred_split_lru, lru,
-				       &folio->_deferred_list, folio_nid(folio));
+			if (__list_lru_del(&deferred_split_lru, lru,
+					  &folio->_deferred_list, folio_nid(folio)) &&
+			    folio_test_partially_mapped(folio))
+				deferred_split_pages_del(folio);
 			if (folio_test_partially_mapped(folio)) {
 				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(old_order,
@@ -4415,6 +4425,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, &memcg, &flags);
 	if (__list_lru_del(&deferred_split_lru, lru, &folio->_deferred_list, nid)) {
 		if (folio_test_partially_mapped(folio)) {
+			deferred_split_pages_del(folio);
 			folio_clear_partially_mapped(folio);
 			mod_mthp_stat(folio_order(folio),
 				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
@@ -4473,6 +4484,8 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
 	}
 	__list_lru_add(&deferred_split_lru, lru, &folio->_deferred_list, nid, memcg);
+	if (partially_mapped)
+		deferred_split_pages_add(folio);
 	list_lru_unlock_irqrestore(lru, &flags);
 	rcu_read_unlock();
 }
@@ -4524,8 +4537,11 @@ static enum lru_status deferred_split_isolate(struct list_head *item,
 {
 	struct folio *folio = container_of(item, struct folio, _deferred_list);
 	struct list_head *freeable = cb_arg;
+	bool partially_mapped = folio_test_partially_mapped(folio);
 
 	if (folio_try_get(folio)) {
+		if (partially_mapped)
+			deferred_split_pages_del(folio);
 		list_lru_isolate_move(lru, item, freeable);
 		return LRU_REMOVED;
 	}
@@ -4535,7 +4551,8 @@ static enum lru_status deferred_split_isolate(struct list_head *item,
 	 * isolate: folio_unqueue_deferred_split() checks list_empty()
 	 * locklessly, so once removed the folio can be freed any time.
 	 */
-	if (folio_test_partially_mapped(folio)) {
+	if (partially_mapped) {
+		deferred_split_pages_del(folio);
 		folio_clear_partially_mapped(folio);
 		mod_mthp_stat(folio_order(folio),
 			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
@@ -4596,6 +4613,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 &folio->_deferred_list,
 					 folio_nid(folio),
 					 folio_memcg(folio));
+			deferred_split_pages_add(folio);
 			rcu_read_unlock();
 		}
 		folio_put(folio);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3b5cb1031f72..ba71cc3e4c30 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1248,6 +1248,7 @@ const char * const vmstat_text[] = {
 	[I(NR_FILE_THPS)]			= "nr_file_hugepages",
 	[I(NR_FILE_PMDMAPPED)]			= "nr_file_pmdmapped",
 	[I(NR_ANON_THPS)]			= "nr_anon_transparent_hugepages",
+	[I(NR_DEFERRED_SPLIT_PAGES)]		= "nr_deferred_split_pages",
 	[I(NR_VMSCAN_WRITE)]			= "nr_vmscan_write",
 	[I(NR_VMSCAN_IMMEDIATE)]		= "nr_vmscan_immediate_reclaim",
 	[I(NR_DIRTIED)]				= "nr_dirtied",
-- 
2.43.0

