Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797321;
	b=u0HbfBZPfXJH9Mlq0Jpp94mTqKhilyFg6PEw9ifp5wZBCewtUMmMnb8YNk6NTVRypkaI
	 ccjBPqmxCL7SSCr6xf1OaWtdqc0hQYf3D5pDsfxpCef0Zybc7EfPi47jbqO2CxZQ+kDpm
	 BL4316OyXLj/bFRDZkhWhXZtxqpna1VskbULOcFqLkz6jCdq88b9NdTt0JQAVySx0YatW
	 uNsV9cEYWK71IwZswQJk+xId9eJtTBToYObH3Co5KHveLg0CVRqDgZXJYDbVVTi9f8/12
	 +msXcQLeYZhsXwFHibxRgzgYJVllraGmLiWjCYIT6c7XPtHi48dVj1FnMaAErjEdEmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797321;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EupeGjRb75MNjqEgPTABdH073sRIqN74C/YN1OkBtlU=;
	b=flWks/WyEqVoVBJRV2BQiBEkDsOCvUaP+U4llBEA0frIccjCJZua4g5RojlMc9BJz3gy
	 8gdljMLKXQy9oELkt7cY6WnVhrjMt9X038WNG2+LtV13z3aDUvW6r3UqES9Rqcjq4833o
	 Z77D8kld0DjY61ttUMixbg0ziRwzxvciV255UHLBtjcpXoAe29tbSAM4omshnhSBPZIuc
	 NxoGLGo60ZzervIh15twvAxFfXESU/bzqsFaU+tHI+jr5vIffa+41qrboqPa+tQkSMRht
	 HoO/32bAt0Wt6USExAeGkOLiBZpeVNWV9Oezig9Fe5WVVLZR6+snAbdXCE69KsbdIrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tiqu6w4H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05898606A339;
	Wed,  4 Nov 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tiqu6w4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3502D1F00A1E;
	Wed,  4 Nov 2026 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797320;
	bh=EupeGjRb75MNjqEgPTABdH073sRIqN74C/YN1OkBtlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tiqu6w4HyQD0fH007XSLvLB9qWrosZvCEY3ZWDJKeGLUjuXAtS1oLIi4qmi/Dr8gY
	 SzElxiJUPf4pwT2v4t8sIIXS7SgJRNA+kv0zyX3mCHqA0DY6wkFn/zt2D9R6fU+uCa
	 AHzqtpbXno89S+HMbiZF1YNN3oV+bskHH7ldsxKE04qEWzyJuTwkzzsi5Uj6v0uPGU
	 DhYBInXs8UgT/pA5O13Ir9/zQGTd2/E+1/r+MgNpA+yJOaGfE9UNamvayORTPmqRar
	 4KLN3HI4LDeXp20Akgp+LQZagkWb5eZivWb+5CIYspUtuOkj18Lz2wU8fGr5Z87URq
	 QYxh/TDwJ26WA==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.ams.internal (Postfix) with ESMTP id 068801980054;
	Wed,  4 Nov 2026 08:01:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 04 Nov 2026 08:01:56 -0500
X-ME-Sender: <xms:wCzrahdthJvf1Ksum-_Trp8E6coKAxuCeB6IpomqWfxapiUoBJWE5A>
    <xme:wCzrakcwdmtbXYDC67eyln7xSJlJd-Fk6GnZ9Zndu8UCQULChDA1wcmYpHojDtVEj
    zDkvSRbLYxDo2RstfujLCvGgw0IfQc2nabXpZclfi5xPXVYeIvjZiqz>
X-ME-Received: <xmr:wCzratKncigBZZvftdPOQJ-w8MwSWip1FAn66dkUrelfm4a0NJrenzdFh7E>
X-ME-Proxy-Cause: dmFkZTFnMVB3J0HiCMx6jd1ELkzwNAjOB9sD3KKCO8Jh/oTQ2Wxy6relTg3O6gfcv7zM8M
    eTaBBuPFg+E7mcCmv32cVM60oGUW0vtD9PJs4Ggt7A8bSf27wgs/KbqZqYfysoNXSdfbJS
    uDN7pVQSluWZA8VAvimLABcpSfkA5Kk7vwjK4BTKWKiq6LQVLKTvO/5cCJzpn2MdnsR4Gs
    3XNsuUp3QPqjZDwfKGFhSVnz4zjhEFM8/KpnhFq8S5iPznJUgdAC48w2fdW3UFtgvONs2A
    P0nLgc7yVVbOklaJM9xm5GgvEFD86ZNlCansaxJabR5MXldQB057xIEdz06tdKFYngb4r6
    G+UsDQ8RoUEfwRFYCcgXZGmnO8bRlAFd9ivdJD7kH1u+35w44vSrx6fzQbENhgIMfqzwRv
    y103X+1y8Y1omQ4/orDSeUB14FYTxpaO7MgOntu+XnRFFgjr2x/sZTdSvKm1UVOWD3iL8t
    smhf/pUSJHFb359EyOyIfD4W/y/Ztlc8QQo+lbWNlEaOUp+6LtMs4AR+uOnWSGjYMES5J+
    hGh1GKH33JTIh2hknuLoxlUuXaUH/HdViIRSTheoESlSaLUu1QF1Fe0OBDGpbSz40zAgEW
    q7hj+iz0lzPjKf+48632T9H4mq/jOmhbZdaVpIlg0J5gSLat6+eEo0kF+ZBQ
X-ME-Proxy: <xmx:wCzraqo8984EblIZFpMYeQwZrKKi39ATyzYmaocEQtZVs4hHOaQA6g>
    <xmx:wCzrauUelk1k-fkToUOIfp93dI7ZcXHE8B4euseiv6qnZVvAffK-EA>
    <xmx:wCzragb4IT_qOxG1giJNnbn2Tb2wLghdAE0vUcDe5-Sp_XZRry8_og>
    <xmx:wCzrans4VIdvZ90oO7iLNkxp4hXwtjwnrHxsve1TIFYB_Vghx8FGdQ>
    <xmx:wCzravrT2ceR5eRMuUZhXtUDUoR411Qyamn9bn_W0XIBterIIsPk_Dr_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:01:51 -0500 (EST)
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
Subject: [RFC PATCH v2 05/18] mm: expedite the grace period when a CPU has many deferred frees
Date: Wed,  4 Nov 2026 13:01:01 +0000
Message-ID: <20261104130118.2507513-6-kas@kernel.org>
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

A deferred folio waits one to two grace periods on its CPU's list, where
the page allocator cannot use it.  A CPU that frees many flagged folios
at once, for example when a file is truncated, can hold a lot of memory
there.

When more than 4 MiB is pending on a CPU, a work takes both of the CPU's
lists and frees them after an expedited grace period.  That grace period
starts after the take, so it covers every reader that found one of the
folios.  The task that frees them does not wait.

An expedited grace period interrupts every CPU, so keep it for when the
memory matters.  That is when the zone is below its high watermark, or
when the pages waiting in it are more than an eighth of its free pages.
The watermark alone comes too late for a bulk free.  A truncate or
fadvise(POSIX_FADV_DONTNEED) of a hot range defers all of it while the
zone still has memory.  When the readers that refill the range then run
short, nothing is freed that would check again.

With rcu_normal, the expedited grace period is a normal one.

pgfree_rcu_expedite in /proc/vmstat counts the expedite runs that freed
something.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: take both lists, expedite only when the memory matters, rewrote
 the changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/vm_event_item.h |  2 +-
 mm/page_alloc.c               | 61 ++++++++++++++++++++++++++++++++++-
 mm/vmstat.c                   |  1 +
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index cbe849701653..45527fa7d0c1 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -36,7 +36,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(ALLOCSTALL)
 		FOR_ALL_ZONES(PGSCAN_SKIP)
 		PGFREE, PGACTIVATE, PGDEACTIVATE, PGLAZYFREE,
-		PGFREE_RCU,
+		PGFREE_RCU, PGFREE_RCU_EXPEDITE,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
 		PGREUSE,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15bb66e36304..a9058d414f92 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1313,6 +1313,8 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
+#define RCU_FREE_EXPEDITE	(SZ_4M >> PAGE_SHIFT)
+
 /*
  * Each CPU has at most one grace period in flight (@queued), covering
  * @batch.  Folios freed meanwhile wait on @pending for the next one.
@@ -1322,7 +1324,9 @@ struct rcu_free_pcpu {
 	bool queued;
 	struct list_head pending;
 	struct list_head batch;
+	unsigned long nr_pending;
 	struct rcu_work rwork;
+	struct work_struct expedite;
 };
 
 static DEFINE_PER_CPU(struct rcu_free_pcpu, rcu_free_pcpu);
@@ -1337,17 +1341,29 @@ static void rcu_free_start(struct rcu_free_pcpu *r)
 		return;
 
 	list_splice_init(&r->pending, &r->batch);
+	r->nr_pending = 0;
 	r->queued = true;
 	WARN_ON_ONCE(!queue_rcu_work(rcu_free_wq, &r->rwork));
 }
 
-static void rcu_free_pages(struct list_head *list)
+static void rcu_free_take(struct rcu_free_pcpu *r, struct list_head *list)
+{
+	lockdep_assert_held(&r->lock);
+
+	list_splice_tail_init(&r->batch, list);
+	list_splice_tail_init(&r->pending, list);
+	r->nr_pending = 0;
+}
+
+static unsigned long rcu_free_pages(struct list_head *list)
 {
 	struct folio_batch fbatch;
 	struct folio *folio, *next;
+	unsigned long nr = 0;
 
 	folio_batch_init(&fbatch);
 	list_for_each_entry_safe(folio, next, list, lru) {
+		nr += folio_nr_pages(folio);
 		mod_zone_page_state(folio_zone(folio), NR_FREE_RCU_PAGES,
 				    -folio_nr_pages(folio));
 		if (!folio_batch_add(&fbatch, folio)) {
@@ -1357,6 +1373,17 @@ static void rcu_free_pages(struct list_head *list)
 	}
 	if (folio_batch_count(&fbatch))
 		free_unref_folios(&fbatch);
+	return nr;
+}
+
+/* Free what rcu_free_take() took: the grace period starts after that */
+static unsigned long rcu_free_flush(struct list_head *list)
+{
+	if (list_empty(list))
+		return 0;
+
+	synchronize_rcu_expedited();
+	return rcu_free_pages(list);
 }
 
 static void rcu_free_workfn(struct work_struct *work)
@@ -1374,17 +1401,48 @@ static void rcu_free_workfn(struct work_struct *work)
 	rcu_free_pages(&done);
 }
 
+static void rcu_free_expedite_workfn(struct work_struct *work)
+{
+	struct rcu_free_pcpu *r = container_of(work, struct rcu_free_pcpu,
+					       expedite);
+	LIST_HEAD(list);
+
+	spin_lock_irq(&r->lock);
+	rcu_free_take(r, &list);
+	spin_unlock_irq(&r->lock);
+
+	if (rcu_free_flush(&list))
+		count_vm_event(PGFREE_RCU_EXPEDITE);
+}
+
 static void rcu_free_defer(struct folio *folio)
 {
 	struct rcu_free_pcpu *r = raw_cpu_ptr(&rcu_free_pcpu);
 	struct zone *zone = folio_zone(folio);
+	unsigned long free, waiting;
 	unsigned long flags;
 
 	spin_lock_irqsave(&r->lock, flags);
 	__mod_zone_page_state(zone, NR_FREE_RCU_PAGES, folio_nr_pages(folio));
 	list_add_tail(&folio->lru, &r->pending);
+	r->nr_pending += folio_nr_pages(folio);
 	rcu_free_start(r);
 	spin_unlock_irqrestore(&r->lock, flags);
+
+	/* Unlocked: a stale count delays the expedite by one free */
+	if (data_race(r->nr_pending) <= RCU_FREE_EXPEDITE ||
+	    work_pending(&r->expedite))
+		return;
+
+	/*
+	 * An expedited grace period interrupts every CPU: only while the
+	 * zone is short of memory, or while more than an eighth of what it
+	 * has free waits here.
+	 */
+	free = zone_page_state(zone, NR_FREE_PAGES);
+	waiting = zone_page_state(zone, NR_FREE_RCU_PAGES);
+	if (free < high_wmark_pages(zone) || waiting > free / 8)
+		queue_work(rcu_free_wq, &r->expedite);
 }
 
 static void __init rcu_free_init(void)
@@ -1404,6 +1462,7 @@ static void __init rcu_free_init(void)
 		INIT_LIST_HEAD(&r->pending);
 		INIT_LIST_HEAD(&r->batch);
 		INIT_RCU_WORK(&r->rwork, rcu_free_workfn);
+		INIT_WORK(&r->expedite, rcu_free_expedite_workfn);
 	}
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 64068d73d6d2..aa7280b5e69c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1345,6 +1345,7 @@ const char * const vmstat_text[] = {
 	[I(PGDEACTIVATE)]			= "pgdeactivate",
 	[I(PGLAZYFREE)]				= "pglazyfree",
 	[I(PGFREE_RCU)]				= "pgfree_rcu",
+	[I(PGFREE_RCU_EXPEDITE)]		= "pgfree_rcu_expedite",
 
 	[I(PGFAULT)]				= "pgfault",
 	[I(PGMAJFAULT)]				= "pgmajfault",
-- 
2.54.0

