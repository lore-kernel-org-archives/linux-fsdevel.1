Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425005;
	b=x4DthK7caMbxMkmAjkNuu5DIxwCg5Ds4iQaS9mfcaLctBC8wFlOxBXGGAuc7WLaKL7t6
	 G1DQcrSa/czpql3fjXad1vrzFIxbVX68+r3hKi8H+jJVFY6ByNQuN0e/c5+I0Js8wnZ6q
	 IYMmeeFgVWbdVUCns7pF1ImgOmo7eRe4YG4W3VaIjzaBT5HA24tjN1WztSJKt11UVHfA6
	 yw2vUkzbPzcjvArg802KELecEh+j3qxkHVH7wxulMcI7FWfbWb+SWoKEVocL42PjHHnAE
	 2nsNuEZlyRYViZ3blmA7h7SYhweQ+d1Q6s+qopvRYqhhxkxdpHvcViA8eESwIVuCdIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425005;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n+S/ugjb/OJ8R7PrPj5yXY/1bn/4OHkMP3wOgkiMBWs=;
	b=IbM5Zmool280QPNquGT77OUBG1LhZdMfFLqJ30L+O68VrhRPy5fJ3oUf8xMUZD5hxVCv
	 DoZjKb6k+o69BHhQDTY6v58SsQvfHoiKVK7hu4byyVt0j01oHmDgl1q1kzRrVl8ToNzTV
	 Dv2PGE7/N04XEcDFvJSCg4eOXQ/R2/Yi58j6xkARAItB/CDjoFE+JN6ot4+BlEds2VB/o
	 k6oHZNPxRiCMKvfTmck2LEnN/rFYFn2S5sLBA0eVy1s67lsntukWex6nHnRYljZhU8l9z
	 DGhaMx4HjNdX5tFaJcQU2l68ksKg3L+bQ5XUAtyMVUhMb4lVxLSMj/73MNFlG1BK3yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8LxZuuc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07E609A552;
	Mon, 19 Oct 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8LxZuuc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F61F000CB;
	Mon, 19 Oct 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425005;
	bh=n+S/ugjb/OJ8R7PrPj5yXY/1bn/4OHkMP3wOgkiMBWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8LxZuuclx4RHUS5jJjxSkOswRLlo5pjpQ9wupaEyFZ89DFiWI5oq+M9ZzjgAB5R1
	 WPcMXMgZzy1vi4i/u5ggPMYZkLowHSr74F/i92yHV0QEVfNmxhyg8G2NeUkQZt799w
	 feBYtEiHDm8syHRZsZGzw2kebSdhmFvt1+EMyEWvBGtehsIUQw+oa+wP7VGuomIw7Y
	 2bEWbG6aITVhZMmPQKe416GSU50vDxW5pvwPhZwh6VKxax2HyQVGDCYHLo0qyFn5Dn
	 uB7w65BUXz74SDKmQpLLGupvtAB6qxNXykZJ6azmmFMNxxmAOvK9eZbCPZmHmxrHPP
	 8j2EK1MsXYTSA==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.ams.internal (Postfix) with ESMTP id A05B3198003A;
	Mon, 19 Oct 2026 11:49:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 19 Oct 2026 11:50:01 -0400
X-ME-Sender: <xms:JTzWaopAIuIDyf2I74LXEv-XB9cVY8to4rbSy9ZZmVSfqR6AKR35Ag>
    <xme:JTzWagKTkPu3TQuZhTFQ0pY31niVDCx9HEIJNcWzTtu8xnox9YoMGBNc9j7643UPg
    64JwUP8kKO9d9WaRGEZT-L2-1BboOAlMUiAbWbr-15PWaoUnWkyggV7>
X-ME-Received: <xmr:JTzWal3ykveCNXQdPFRa5ZVVKd7BcXSNTlYTfQ0BKiesKt82pNTriG4lGtY>
X-ME-Proxy-Cause: dmFkZTFpjrG+2jfVBfklNRE95oThC60xlhUtv5sioyJrfpDDHbEB/2cXkTI411oJriXTLs
    N7RLfOUdBbmoibSFu4zT/f1BKPPyxkEYUp5eDeafGhPQjcnfJv/29ZtYwE6q77Fr7A6zQu
    C94bEu3EPqJJ50fLC5xP9PtYZOq3sS+jMfKkgkZFNUAdZxkDiyHArLijwBk9MwzijLWdvR
    4raSXvkSyIGvp9XYd2doZUGuEANzDQejgJzzg3ARZCjBL2yZfXIvLZCg0AMujDeTHEemYv
    cvWt94P7AS+P1mtikHZvyS9eAaK3Fy2/TwDlvaPXULPDsZK9f0sj0aca+uCBBoNs4d3uVo
    YdtzlwPs9YNSDvT8I3PUckOtBZwF77w7yengukH2a2sZdb3tiP6Qlt9T5excPi6bNA+J9g
    mqbobw5Mi702UDCjkOsfr5wroidnBhzWPbrlA+FCXpkk1xOe0/EVkUvBzzMoafJuBeCCLL
    WBPgNlBt2yek1h9VvQvgT19ztxgajydWWVggL5ja5MkU8lXwa1Ls+occorai2u4Q8LDn1P
    8mDhUG6AEuUB2cC14L0ld1brKkx1KVX6VyYLkLq4OMYy5fXiCB2XT9oTKPtorFOMkSTp2b
    he8TCnhUR6vRkWMBzCEpOD/1xv5Omsu8k9kWVo4e6H2Xrswc560yXC96kwaQ
X-ME-Proxy: <xmx:JTzWah7SZciXoDdIPr_MZb8C70JfG8HRwOh9031XvV3-l1ZMoQnJBw>
    <xmx:JTzWarOkSc0YPOKweoj6Gk8H_BneJzTgdHfoULE1UJS_dq_jlzagXw>
    <xmx:JTzWatI3M2QHX0XvNPEGidQgeEZdeE5HtYJGCvCl_qU9LrUzxxhW7g>
    <xmx:JTzWaupm7Od-1U0qODek8Ph3PRhfJ9-90Yvai0JtyCwnQy8v1fbzEw>
    <xmx:JTzWaoZ3WArj8sNRHixTlUdM0S7AD21SZyTwmLZB8Z5Ha7ZLKfsOH_d5>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:49:56 -0400 (EDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>,
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Harry Yoo <harry@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH 06/18] mm: free the pages waiting for a grace period before OOM
Date: Mon, 19 Oct 2026 16:48:59 +0100
Message-ID: <20261019154913.1765974-7-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019154913.1765974-1-kas@kernel.org>
References: <20261019154913.1765974-1-kas@kernel.org>
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

When reclaim fails, should_reclaim_retry() looks only at free and
reclaimable pages.  It can hand the allocation to the OOM killer while
enough memory is about to come back from the pages that wait for a
grace period.

Before should_reclaim_retry() gives up, free the waiting pages if they
would bring an eligible zone above its min watermark, and retry.  That
costs an expedited grace period, which is cheap next to the OOM killer.
The retries are bounded per no-progress streak, so a drain that does not
help still ends in an OOM kill.

pgfree_rcu_drain in /proc/vmstat counts the drains that freed something.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/vm_event_item.h |  2 +-
 mm/page_alloc.c               | 88 +++++++++++++++++++++++++++++++++--
 mm/vmstat.c                   |  1 +
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 45527fa7d0c1..7626a3e3a07a 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -36,7 +36,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(ALLOCSTALL)
 		FOR_ALL_ZONES(PGSCAN_SKIP)
 		PGFREE, PGACTIVATE, PGDEACTIVATE, PGLAZYFREE,
-		PGFREE_RCU, PGFREE_RCU_EXPEDITE,
+		PGFREE_RCU, PGFREE_RCU_EXPEDITE, PGFREE_RCU_DRAIN,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
 		PGREUSE,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a9058d414f92..bec9128d80db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1445,6 +1445,29 @@ static void rcu_free_defer(struct folio *folio)
 		queue_work(rcu_free_wq, &r->expedite);
 }
 
+/*
+ * Free what every CPU's lists hold.  A concurrent drain holds the lock
+ * until it has freed what it took.
+ */
+static void rcu_free_drain(void)
+{
+	static DEFINE_MUTEX(lock);
+	LIST_HEAD(list);
+	int cpu;
+
+	mutex_lock(&lock);
+	for_each_possible_cpu(cpu) {
+		struct rcu_free_pcpu *r = per_cpu_ptr(&rcu_free_pcpu, cpu);
+
+		spin_lock_irq(&r->lock);
+		rcu_free_take(r, &list);
+		spin_unlock_irq(&r->lock);
+	}
+	if (rcu_free_flush(&list))
+		count_vm_event(PGFREE_RCU_DRAIN);
+	mutex_unlock(&lock);
+}
+
 static void __init rcu_free_init(void)
 {
 	int cpu;
@@ -4792,6 +4815,52 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	return !!__gfp_pfmemalloc_flags(gfp_mask);
 }
 
+/*
+ * Reclaim is about to give up: if the pages waiting for a grace period
+ * would bring an eligible zone above its min watermark, free them and
+ * retry.  Not for a dying task, which frees memory by exiting.
+ */
+static bool rcu_free_wait(gfp_t gfp_mask, unsigned int order,
+			  struct alloc_context *ac, int alloc_flags,
+			  int *rcu_free_waits)
+{
+	struct zone *zone;
+	struct zoneref *z;
+
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+		return false;
+	if (tsk_is_oom_victim(current) || fatal_signal_pending(current))
+		return false;
+	if (*rcu_free_waits >= MAX_RECLAIM_RETRIES ||
+	    order > PAGE_ALLOC_COSTLY_ORDER)
+		return false;
+
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
+				ac->highest_zoneidx, ac->nodemask) {
+		unsigned long waiting, available;
+
+		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
+		    !__cpuset_zone_allowed(zone, gfp_mask))
+			continue;
+
+		waiting = zone_page_state_snapshot(zone, NR_FREE_RCU_PAGES);
+		if (!waiting)
+			continue;
+
+		available = waiting +
+			    zone_page_state_snapshot(zone, NR_FREE_PAGES);
+		if (__zone_watermark_ok(zone, order, min_wmark_pages(zone),
+					ac->highest_zoneidx, alloc_flags,
+					available)) {
+			(*rcu_free_waits)++;
+			rcu_free_drain();
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Checks whether it makes sense to retry the reclaim to make a forward progress
  * for the given allocation request.
@@ -4805,7 +4874,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 static inline bool
 should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		     struct alloc_context *ac, int alloc_flags,
-		     bool did_some_progress, int *no_progress_loops)
+		     bool did_some_progress, int *no_progress_loops,
+		     int *rcu_free_waits)
 {
 	struct zone *zone;
 	struct zoneref *z;
@@ -4816,10 +4886,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * their order will become available due to high fragmentation so
 	 * always increment the no progress counter for them
 	 */
-	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
+	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER) {
 		*no_progress_loops = 0;
-	else
+		*rcu_free_waits = 0;
+	} else {
 		(*no_progress_loops)++;
+	}
 
 	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
 		goto out;
@@ -4872,6 +4944,10 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	else
 		cond_resched();
 out:
+	if (!ret && rcu_free_wait(gfp_mask, order, ac, alloc_flags,
+				  rcu_free_waits))
+		return true;
+
 	/* Before OOM, exhaust highatomic_reserve */
 	if (!ret)
 		return unreserve_highatomic_pageblock(ac, true);
@@ -4961,6 +5037,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	enum compact_result compact_result;
 	int compaction_retries;
 	int no_progress_loops;
+	int rcu_free_waits;
 	unsigned int cpuset_mems_cookie;
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
@@ -4985,6 +5062,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
+	rcu_free_waits = 0;
 	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
@@ -5163,7 +5241,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto restart;
 
 	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
-				 did_some_progress > 0, &no_progress_loops))
+				 did_some_progress > 0, &no_progress_loops,
+				 &rcu_free_waits))
 		goto retry;
 
 	/*
@@ -5206,6 +5285,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* Retry as long as the OOM killer is making progress */
 	if (did_some_progress) {
 		no_progress_loops = 0;
+		rcu_free_waits = 0;
 		goto retry;
 	}
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index aa7280b5e69c..d994de1fd739 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1346,6 +1346,7 @@ const char * const vmstat_text[] = {
 	[I(PGLAZYFREE)]				= "pglazyfree",
 	[I(PGFREE_RCU)]				= "pgfree_rcu",
 	[I(PGFREE_RCU_EXPEDITE)]		= "pgfree_rcu_expedite",
+	[I(PGFREE_RCU_DRAIN)]			= "pgfree_rcu_drain",
 
 	[I(PGFAULT)]				= "pgfault",
 	[I(PGMAJFAULT)]				= "pgmajfault",
-- 
2.54.0

