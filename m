Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797297;
	b=zFOY/xbqHmgQJZitKS2Eh7Is0WDmg4dsyn0wuGE96TBDkkPIptx/qzNJadrKmlZubChI
	 ndci1CMKM+2fHjr9xhni1gZKkRSBq5K7oRksx8QHH0vxtiD2DrcArOdSGYp+ADCXpp0m2
	 gp3DX1hK318O2VKOHaXsTjlNnrmwKBw5nCWnC1nnYar7MfTOw7Qz81r76niOYREfy7K6f
	 Ra5Ygy28xNwgt0kNMWKFi1cZEQQtj2gfc3HfABW+EAbPi1L5DwpEgzUX/mAbAzidPeCOa
	 ED5zgdSMOB5BtkFkVIXp1vgZP8uvPYe56KE7nQV8pOGEE3+E1qVqJRiwZ+GKucG5+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797297;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R6Rfwa2eXU8GjwfNAOM4D1Li2Qxj0vjGvYHOqbKiyzU=;
	b=K8vGyYFGDUnnLXlDx4R7RjBfXiNhDYvBZApWkDkaISyFB6fu0H0QHQPkbdMIbtfxqkp0
	 ptLi8D2dSV3kGCQuMQxY7iJ04EIF69T654VePzbBdqjEVdiX4bkskg3ekfSYTL45cvcTb
	 FySJVha/amQs1koUQxlDj5jP0ZlXbKIh2aDujy8wzwVDIqawHZrrf69qIh89CGeI2K4lC
	 N26zNjL26FubZjLKTcOigV1hNBBPD4jCG/lmfP0HcmBUGzlJp0BNfnJypjp031X5k6KUP
	 9//JKTDBDNH8VSSxBp51IX61R8FaHgaz5QPN2JSCROuUGrAiARfMuOJJmprCoGY/tFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgXzOJBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2014606A32C;
	Wed,  4 Nov 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgXzOJBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5A71F00A1D;
	Wed,  4 Nov 2026 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797296;
	bh=R6Rfwa2eXU8GjwfNAOM4D1Li2Qxj0vjGvYHOqbKiyzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GgXzOJBBeQyScVuWtHrefPzEMbrKzxfBqTyIjMOG/mhruwZzfSqJHlR026GqDJOv5
	 tSl3h3dgn+JtbN+Z9xScexyr28AUtN85suiTDVN9rDLR976JIbC+kqxlbKijf1uFNd
	 T147j+MbsT7pIszJLBSYZ9sRklA/SGIorJOs3fsSNGHEtzpgc5KmAxkSG33QsK+d8X
	 DRz4JDgZZZe027DWMT6y/zA/xpWUvy/oif5IxhGwiUgXUNW37Vcv5PZvbD5v0GKjdX
	 nO2dAafUrUbPTxXfbbWRJ4jr0i4r0xfnbrIQVAhjxFco6fxWMS2yoRntQMRt8xbzk4
	 zBdy6X72kQINQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id C4DFE1980054;
	Wed,  4 Nov 2026 08:01:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 04 Nov 2026 08:01:32 -0500
X-ME-Sender: <xms:qCzrapgBAPoJ8pQUM0P8Mqo9aaz9RnphQC_FifzmLg1ZECvMb3cd1w>
    <xme:qCzrajRRbHLbArmyYQWwbQZNy3a_lBm3M-wkGABBgqSIoM3OThuI8GU08Oq_-m-TK
    FkuQyXgZgZQGOn4H-PIAsbD5jwh-mz5X00gQN69YY3QM7RWEF1Y4GY>
X-ME-Received: <xmr:qCzraruaTyHVIW0hXmWv5ATvnjIAYja2FCTvPjK1j8Cg0Ktdu0N5gqk8G6g>
X-ME-Proxy-Cause: dmFkZTGcnWxWNdwzviArTqwO8SleswujEAoF3G5cAnzgWuj9VIXYzVn8L/YtSSoCVpDQCx
    AFAjkaMBKJDECegKseyQPi3BoJ2ULdzgEWHQh0kOOdV3qcZ96T5qYw8zvnYBduU6y+7gOl
    ju1hRqdfaUd029Zpq0M1QKVfvNYpVJXA03mIXM/FVYF2n1TVZdGxcwDBil6kVRafbiJtv0
    QuPNDwYksKVrYzT4QGS7HIxmz8ayVgiPQk5G9zoQji1nSBMTr/zV+0QH6w0a9BT4L54N+d
    cRhB7KhKgiZgmWNJc1G8l9d+gvjQ75B75nEIsy2loqzEXGvtqjUcmfJ5UhZu2fDzNX4Rjl
    vnpZ4QeNny1QYnKMwB6gIM5QdzBGfcdgkYwYw+Bd78cBJEycD5qxJfJeQdpg02UO6MFr40
    PuY5XFiV7j0UW88sAt7cVQOghCnk79NSUeG1j0WKpx0Mw9prXYAYm1V0h1acJiumLArIrN
    mqx28zKBZoQ/E0LHnYiWzd+lkMd7Xn3pBBZPzESYN2WUpKtd17mym+QTAdYju4n//gph3P
    toiWPpq4aPHfz/aQwFM4rVAZlItMOXPrI16hwJKwepRZMIp0sImFQ2artJEN6PVJR+abOP
    ohuF6ItSRUxXG8WHN3IdWlXQvu/ptYaWQol/h8hv0fjZLoqUz/jnShf7hzKQ
X-ME-Proxy: <xmx:qCzrat__E0Q-VFSBJ_57yOnyLjQS07Sht7mFFF8K6nXa9V8d_Nraug>
    <xmx:qCzranbaEu2fiRO46API7Y48dHJxr-52LO66K5PjvIupzfMOBJinzA>
    <xmx:qCzrasMabt9tFQQYYmW0EXHBVSGNyCTaMwWC62U9qmNLRI6F_tqtqw>
    <xmx:qCzravTQMBsu1sE_3MZD8H5EujKgDFuwIilvNu_XlsEwbOOVPQsPlw>
    <xmx:qCzran91T2sW8RPcdv2Z0-BFlsotCy4zl61kgfFRXDzODKdgauNa3eVg>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:01:27 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Harry Yoo <harry@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC PATCH v2 01/18] mm: free PG_rcu_free folios only after an RCU grace period
Date: Wed,  4 Nov 2026 13:00:57 +0000
Message-ID: <20261104130118.2507513-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104130118.2507513-1-kas@kernel.org>
References: <20261104130118.2507513-1-kas@kernel.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Reading a page cache folio without taking a reference would keep CPUs
that read the same file from bouncing its refcount.  But without a
reference the folio can be freed, and its memory reused, while the
reader copies from it.

Add PG_rcu_free: the free of a folio with the flag waits for an RCU
grace period.  A reader that saw the flag under rcu_read_lock(), and
then still found the folio where it looked, can read it until
rcu_read_unlock().  A split copies the flag, as such a reader may still
be reading the new folios.

The folios wait on per-CPU lists, one grace period in flight per CPU:
call_rcu() per folio would queue a callback for every folio of a
truncated file.  A work, which can reschedule, frees each batch.
Reclaim depends on these frees, so the workqueue is WQ_MEM_RECLAIM.

The flag is 64-bit only (CONFIG_PAGE_RCU_FREE): page flags are scarce
on 32-bit, and the contention this avoids is a problem of large
machines.  It is off on PREEMPT_RT, where expedited grace periods are
normal ones, so the waiting pages cannot be freed quickly when memory
runs short.

pgfree_rcu in /proc/vmstat counts the deferred pages.  Nothing sets the
flag yet.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: rework for flagging at read time, 64-bit only and not PREEMPT_RT,
 shorter comments and changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/page-flags.h     |  21 +++++++
 include/linux/vm_event_item.h  |   1 +
 include/trace/events/mmflags.h |   7 +++
 mm/Kconfig                     |  15 +++++
 mm/huge_memory.c               |   1 +
 mm/memory-failure.c            |   4 ++
 mm/page_alloc.c                | 105 +++++++++++++++++++++++++++++++++
 mm/vmstat.c                    |   1 +
 8 files changed, 155 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7a863572adce..a1e52a1f8a52 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -111,6 +111,9 @@ enum pageflags {
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
 	PG_dropbehind,		/* drop pages on IO completion */
+#ifdef CONFIG_PAGE_RCU_FREE
+	PG_rcu_free,		/* free only after an RCU grace period */
+#endif
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -602,6 +605,24 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(dropbehind, FOLIO_HEAD_PAGE)
 	__FOLIO_SET_FLAG(dropbehind, FOLIO_HEAD_PAGE)
 
+/*
+ * A lockless lookup that sees PG_rcu_free and then still finds the folio
+ * where it looked may read it until rcu_read_unlock().  Set under a
+ * reference, cleared only by the free.  Not for hugetlb or
+ * free_pages_nolock().
+ */
+#ifdef CONFIG_PAGE_RCU_FREE
+FOLIO_TEST_FLAG(rcu_free, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_SET_FLAG(rcu_free, FOLIO_HEAD_PAGE)
+	__FOLIO_CLEAR_FLAG(rcu_free, FOLIO_HEAD_PAGE)
+#define __PG_RCU_FREE (1UL << PG_rcu_free)
+#else
+FOLIO_TEST_FLAG_FALSE(rcu_free)
+	FOLIO_TEST_SET_FLAG_FALSE(rcu_free)
+	__FOLIO_CLEAR_FLAG_NOOP(rcu_free)
+#define __PG_RCU_FREE 0
+#endif
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 2628ccda076a..cbe849701653 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -36,6 +36,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(ALLOCSTALL)
 		FOR_ALL_ZONES(PGSCAN_SKIP)
 		PGFREE, PGACTIVATE, PGDEACTIVATE, PGLAZYFREE,
+		PGFREE_RCU,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
 		PGREUSE,
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 935893e5ea53..47c3411a75e8 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -117,6 +117,12 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 #define IF_HAVE_PG_IDLE(_name)
 #endif
 
+#ifdef CONFIG_PAGE_RCU_FREE
+#define IF_HAVE_PG_RCU_FREE(_name) ,{1UL << PG_##_name, __stringify(_name)}
+#else
+#define IF_HAVE_PG_RCU_FREE(_name)
+#endif
+
 #ifdef CONFIG_ARCH_USES_PG_ARCH_2
 #define IF_HAVE_PG_ARCH_2(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
@@ -152,6 +158,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable),					\
 	DEF_PAGEFLAG_NAME(dropbehind)					\
+IF_HAVE_PG_RCU_FREE(rcu_free)						\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
diff --git a/mm/Kconfig b/mm/Kconfig
index 604c58199acb..6e5341b0bf64 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -718,6 +718,21 @@ config PCP_BATCH_SCALE_MAX
 	  latency.  This option sets the upper limit of scale factor to limit
 	  the maximum latency.
 
+config PAGE_RCU_FREE
+	def_bool y
+	depends on 64BIT
+	depends on !PREEMPT_RT
+	help
+	  Reads from the page cache can copy from folios that are read
+	  again and again without taking a reference on them, so small
+	  reads of one file from many CPUs do not contend on the folio's
+	  reference count.  The cost is that memory freed from such
+	  folios becomes reusable only after an RCU grace period.
+
+	  64-bit only: it takes a page flag, and those are scarce on
+	  32-bit.  Not on PREEMPT_RT, where expedited grace periods are
+	  normal ones, so freeing the waiting pages on demand would stall.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a..25082949a4ca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3743,6 +3743,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 #endif
 				 (1L << PG_dirty) |
 				 (1L << PG_dropbehind) |
+				 __PG_RCU_FREE |
 				 LRU_GEN_MASK | LRU_REFS_MASK));
 
 		new_folio->mapping = folio->mapping;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba..7dde7c3c9a0c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -211,6 +211,10 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 			return false;
 	}
 
+	/* The free of a hwpoisoned page is not deferred: wait for readers */
+	if (release && folio_test_rcu_free(page_folio(page)))
+		synchronize_rcu();
+
 	SetPageHWPoison(page);
 	if (release)
 		put_page(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..a371e92da273 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1313,6 +1313,96 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
+/*
+ * Each CPU has at most one grace period in flight (@queued), covering
+ * @batch.  Folios freed meanwhile wait on @pending for the next one.
+ */
+struct rcu_free_pcpu {
+	spinlock_t lock;
+	bool queued;
+	struct list_head pending;
+	struct list_head batch;
+	struct rcu_work rwork;
+};
+
+static DEFINE_PER_CPU(struct rcu_free_pcpu, rcu_free_pcpu);
+
+static struct workqueue_struct *rcu_free_wq __ro_after_init;
+
+static void rcu_free_start(struct rcu_free_pcpu *r)
+{
+	lockdep_assert_held(&r->lock);
+
+	if (r->queued || list_empty(&r->pending))
+		return;
+
+	list_splice_init(&r->pending, &r->batch);
+	r->queued = true;
+	WARN_ON_ONCE(!queue_rcu_work(rcu_free_wq, &r->rwork));
+}
+
+static void rcu_free_pages(struct list_head *list)
+{
+	struct folio_batch fbatch;
+	struct folio *folio, *next;
+
+	folio_batch_init(&fbatch);
+	list_for_each_entry_safe(folio, next, list, lru) {
+		if (!folio_batch_add(&fbatch, folio)) {
+			free_unref_folios(&fbatch);
+			cond_resched_tasks_rcu_qs();
+		}
+	}
+	if (folio_batch_count(&fbatch))
+		free_unref_folios(&fbatch);
+}
+
+static void rcu_free_workfn(struct work_struct *work)
+{
+	struct rcu_free_pcpu *r = container_of(to_rcu_work(work),
+					       struct rcu_free_pcpu, rwork);
+	LIST_HEAD(done);
+
+	spin_lock_irq(&r->lock);
+	list_splice_init(&r->batch, &done);
+	r->queued = false;
+	rcu_free_start(r);
+	spin_unlock_irq(&r->lock);
+
+	rcu_free_pages(&done);
+}
+
+static void rcu_free_defer(struct folio *folio)
+{
+	struct rcu_free_pcpu *r = raw_cpu_ptr(&rcu_free_pcpu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
+	list_add_tail(&folio->lru, &r->pending);
+	rcu_free_start(r);
+	spin_unlock_irqrestore(&r->lock, flags);
+}
+
+static void __init rcu_free_init(void)
+{
+	int cpu;
+
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+		return;
+
+	rcu_free_wq = alloc_workqueue("rcu_free",
+				      WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_free_pcpu *r = per_cpu_ptr(&rcu_free_pcpu, cpu);
+
+		spin_lock_init(&r->lock);
+		INIT_LIST_HEAD(&r->pending);
+		INIT_LIST_HEAD(&r->batch);
+		INIT_RCU_WORK(&r->rwork, rcu_free_workfn);
+	}
+}
+
 static __always_inline bool __free_pages_prepare(struct page *page,
 		unsigned int order, fpi_t fpi_flags)
 {
@@ -1327,6 +1417,19 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	/*
+	 * Not for a hwpoisoned order-0 page: it never reaches the allocator,
+	 * and page_handle_poison() takes a reference right after this free.
+	 */
+	if (unlikely(folio_test_rcu_free(folio)) &&
+	    !(PageHWPoison(page) && !order)) {
+		VM_WARN_ON_ONCE(fpi_flags & FPI_NOLOCK);
+		__folio_clear_rcu_free(folio);
+		count_vm_events(PGFREE_RCU, 1 << order);
+		rcu_free_defer(folio);
+		return false;
+	}
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
@@ -6401,6 +6504,8 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+
+	rcu_free_init();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index cb57714539fb..66ed017bde46 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1343,6 +1343,7 @@ const char * const vmstat_text[] = {
 	[I(PGACTIVATE)]				= "pgactivate",
 	[I(PGDEACTIVATE)]			= "pgdeactivate",
 	[I(PGLAZYFREE)]				= "pglazyfree",
+	[I(PGFREE_RCU)]				= "pgfree_rcu",
 
 	[I(PGFAULT)]				= "pgfault",
 	[I(PGMAJFAULT)]				= "pgmajfault",
-- 
2.54.0

