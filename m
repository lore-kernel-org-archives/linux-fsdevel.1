Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425012;
	b=qNV+ce3txgMer8WFgVfLVmK1A99S1rdjrhsiTGjSLEDyVRUDbzAwF/o05fozHnb8mOgV
	 EakCnJrKxb3+abzDcIXEMuk9UBcY68wiHtkjRrl5J033fN2zuc1t1bRRk0JFZwCM76FJK
	 QKDIt/XXklr8pZxbXhJ9e0Y/Zr+COxqpAUVCAxS52UPG70oPkrdNX1+EZHLnt/ge1Pg2l
	 odeam9hgCOOnHQbhCoIXKGMlC+ZaOZ+DNrPsabQRb0bpDTPX/2EySxzmJGNT9JaQlB7ZK
	 qEDtHuP86v/Py0qG2eb/YN/Q73jpxo5ZVUYuppvVlwF088KJe+mwmqV6FWGR8XJ+ipA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425012;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JIYW0lKY8r5WbgU97oH0sqdYNOmLWzVfRBL2C79VgiY=;
	b=4aK+OlqFL6x4G+w1BdsIhbwi5QBMtCReeJb5ORIhYo1ve0bxHxtBWrhzC/4uuwXK2WNh
	 N/2mFTR/gpO5KLJnGbZEQEFoX8FAnXTX1B0+XkogiIX767dVppLJlUaXow5vF2q6Lz0z0
	 hzl6xLI0sKhgG238LGQHF+ENTAtHdJXD+3+kRh6S4QSOs7P/znGEN3U0pAWBedlg17H72
	 2Uwxs7pUFuALeplRhhK4JZvcXGs65ZiFs5tMRnqXtzp0ek1NkE5Un0ic8utY+6X5O53Z0
	 8xB/2tFjoJMX2so6yLqmQRASIqqaPmNPFYmJX2qCQfl1Bbb9OEIKbaY2eFt1ggAmOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx1HNWF1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A1609A56D;
	Mon, 19 Oct 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx1HNWF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860E81F000C5;
	Mon, 19 Oct 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425012;
	bh=JIYW0lKY8r5WbgU97oH0sqdYNOmLWzVfRBL2C79VgiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jx1HNWF1oMMxGluyBqqBqzTdscsUv1oSirtCGJkaATrjma4oNhzoT90r5ghtoiksK
	 ghN/z3t+IdFfZX06aCJrUJCYkvd0i7zCC7Hxz8gr4MnmCJ6XR6nlmel4YxRm9lCgD9
	 RJ29h4hwQY67AdSs9nyAJC0pkiilVZ71hT12Xap7t3AdX1jA1buleN7UQXeOH5mgma
	 KFLYBNKWr3E1OxsRxSWdwJ9m3Udh/yVN/mJtG0HslcMMrbtjqEKikp7Jne7jX2tbTt
	 zcMizsJ2euZ7i2lZrT3iOkyY2zuLlLhcDhxLzZuRA6GIQ2Qcs62/RZ3hv9ok2dFJgb
	 MeM0pkGGFn3Ig==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5C68E1980047;
	Mon, 19 Oct 2026 11:50:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 11:50:08 -0400
X-ME-Sender: <xms:KzzWaq2lTI6dLRfP62uXpQXMn8_acHRa54NMXdgTD-WoThywbrSZng>
    <xme:KzzWaiUM1eukMYRUhELWiDlsX76CyWwwqpiBCcQzGIeO5cTVXpuFqHmy9BV8vsR0C
    WMowq0G623oHJIwuahUxFyUtOd-kqIwYkCr7JlcDCcYlkEbQJOVHQNp>
X-ME-Received: <xmr:KzzWali5Bz8kXGXrP0nbvODy2zgeQyZ6Baw6DyzchOg375U0aFlZ9XHLdjA>
X-ME-Proxy-Cause: dmFkZTFpjrG+2jfVBfklNRE95oThC60xlhUtv5sioyJrfpDDHbEB/2cXkTI411oJriXTLs
    N7RLfOUdBbmoibSFu4zT/f1BKPPyxkEYUp5eDeafGhPQjcnfJv/29ZtYwE6q77Fr7A6zQu
    C94bEu3EPqJJ50fLC5xP9PtYZOq3sS+jMfKkgkZFNUAdZxkDiyHArLijwBk9MwzijLWdvR
    4raSXvkSyIGvp9XYd2doZUGuEANzDQejgJzzg3ARZCjBL2yZfXIvLZCg0AMujDeTHEemYv
    cvWt94P7AS+P1mtikHZvyS9eAaK3Fy2/TwDlvaPXULPDsZK9f0sj0aca+uCBBoNs4d3uh7
    RoQzewG/TY6u0dk9M/RDUi+4K1yv+yK67j7jmtVzymHX894+Uihg0lcvs6emCinqbM6wyi
    +gUxb773pqkq1jVVcdmSvAhK/XxD/KPCg7Hxilx6E+9oYQ5WMSaJWUvVlcniwS0w+KhrFB
    aoikZIMYd0Nt7GpLtgtIaE3vQKln+pJStVB0vtonatrWvsHTRAgHwTcxLdOTPe/K6HQPJR
    iuTIfSH64MefXniZjMOLCO5Col3kGmDlFai90qTMVtRjt8vCPwHCFc3lid8qi/aWvaM4wi
    UDelk5nM3XO9TE5wjafiWBoWVJEtmtWZsXCTxgC48VOvrEqJLpl2xs9xf8yA
X-ME-Proxy: <xmx:KzzWargWtrUdbQgWlyLvDyj2Sh9WS2ythi6pZMOd2Wsvz6_ZhGhiIg>
    <xmx:KzzWatuKqS1ChJwAImpgrQb5jS0sXRsqBayf8up18aNXoL3EpLm9UA>
    <xmx:KzzWasTzLfXJWgsa7vWNhOzbf8t3G4NQleJe7kFJZjBlXivczFykRg>
    <xmx:KzzWamEcw6XHsPbckM2mv5_oUhFq5uFaBjpv_Uw7xLhjwfQtNPdSeg>
    <xmx:KzzWauiA2en7YXSRag6_TQGTMYyPKCsLXaQw5TAYPN6_31Ex2FRtRRgv>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:02 -0400 (EDT)
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
Subject: [RFC PATCH 07/18] mm: free the pages waiting for a grace period before isolation fails
Date: Mon, 19 Oct 2026 16:49:00 +0100
Message-ID: <20261019154913.1765974-8-kas@kernel.org>
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

alloc_contig_range() and offline_pages() migrate the folios out of a
range and then check with test_pages_isolated() that every page is free.
A migrated folio that had PG_rcu_free waits for a grace period after its
free, so the check fails.  alloc_contig_range() returns -EBUSY, and a
CMA or gigantic page allocation can fail; offline_pages() retries until
the grace period ends.

When the check fails and the zone has pages waiting, free them first.
alloc_contig_range() then finds the start of the free range again, as
the freed folio can merge with a free buddy below it.
offline_pages() does so only after a pass that migrated folios: an
offline stuck on a busy page would otherwise start an expedited grace
period on every retry.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory_hotplug.c |  7 +++++++
 mm/page_alloc.c     | 28 +++++++++++++++++++++++++++-
 mm/page_alloc.h     |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 226ab9cb078a..a8f0c95627ee 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1967,6 +1967,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		.nid = NUMA_NO_NODE,
 	};
 	unsigned long flags;
+	bool migrated;
 	char *reason;
 	int ret;
 	unsigned long normal_pages = 0;
@@ -2050,6 +2051,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	do {
 		pfn = start_pfn;
+		migrated = false;
 		do {
 			/*
 			 * Historically we always checked for any signal and
@@ -2071,6 +2073,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 				 * out
 				 */
 				do_migrate_range(pfn, end_pfn);
+				migrated = true;
 			}
 		} while (!ret);
 
@@ -2092,6 +2095,10 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 		ret = test_pages_isolated(start_pfn, end_pfn,
 					  PB_ISOLATE_MODE_MEM_OFFLINE);
+		/* What this pass migrated can wait for a grace period */
+		if (ret && migrated &&
+		    zone_page_state_snapshot(zone, NR_FREE_RCU_PAGES))
+			rcu_free_sync();
 
 	} while (ret);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bec9128d80db..e63628e64cbb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1468,6 +1468,23 @@ static void rcu_free_drain(void)
 	mutex_unlock(&lock);
 }
 
+/* Free every waiting folio, including those a work took off the lists */
+void rcu_free_sync(void)
+{
+	int cpu;
+
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+		return;
+
+	rcu_free_drain();
+	for_each_possible_cpu(cpu) {
+		struct rcu_free_pcpu *r = per_cpu_ptr(&rcu_free_pcpu, cpu);
+
+		flush_work(&r->rwork.work);
+		flush_work(&r->expedite);
+	}
+}
+
 static void __init rcu_free_init(void)
 {
 	int cpu;
@@ -7632,7 +7649,16 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	outer_start = find_large_buddy(start);
 
 	/* Make sure the range is really isolated. */
-	if (test_pages_isolated(outer_start, end, mode)) {
+	ret = test_pages_isolated(outer_start, end, mode);
+	if (ret && zone_page_state_snapshot(cc.zone, NR_FREE_RCU_PAGES)) {
+		rcu_free_sync();
+
+		/* A freed folio can merge with a free buddy below start */
+		outer_start = find_large_buddy(start);
+		ret = test_pages_isolated(outer_start, end, mode);
+	}
+
+	if (ret) {
 		ret = -EBUSY;
 		goto done;
 	}
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59..f9e200581e2f 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -235,6 +235,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
+void rcu_free_sync(void);
 
 #ifdef CONFIG_NUMA
 struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
-- 
2.54.0

