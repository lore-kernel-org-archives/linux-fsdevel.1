Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3025C804
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212223; cv=none; b=RpLca6oc6l3qp1Dzvu7IAC1jUG3AHkk9ZmPW+F75kbIjpIMi6GHhfieHRDI3YA4EQecutx/Jf2miQKu8jgO178x+tBpHqfddEpG7R6A+SeIzx+joldSsw1SWnjwqpTXQYWh+KiVsE64uslGvKRI7836Sp8BiJy8HHKtsn7h2Wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212223; c=relaxed/simple;
	bh=SQfF1SlG+YKrLzMOWa5OdbaXN61l98ieLIvRa/Hm4bI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOkLgBZeSUsAR5VcoA8BZcG3NiqhP/B0EpV6jlHFT9X5Wr02qDAN0xTq3wRb1TWyqCISVRw2of9772ZogAidbHpSmnHpNaBvnHstq43acQ7lyxqMPvOid26eANvuICp7O2jPN5EdJPKHaUY7zCh+qzdEBapXHHhZX9C+unY72xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkDBQugO; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkDBQugO"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c15d4107068so625405566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784212219; x=1784817019; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYdU4t2+gE6AXuv8NtGQXs6INIroF6XnwJU0+W2hmSY=;
        b=KkDBQugO3XnwkHmZQCk2DyOSPMGhZjTNoRK4aDo4UaV92BRs63vjrRF1R8ti5g1yg6
         FACswK+K6Mb0CJakg+rE3KrG1f26dOG2ZkUP/zrphaxifDiaRcoiPsGIjJT4L6O5cpeZ
         gX3ZOoMoUzamZr+f2rfNcU5mGHwJOqnkKOFD7qe5QlR0Bh0IuHykHRmZwzX1ERJ0VaPB
         dodnLdHeREZ9bmBPgaA4TUCX/bIXbPeMSuVXx+5Vi8OZkJT6vEHetu9PTHlw8/3LmkpE
         YGXK+hc4ompFvYFmkRX/2BGTEX+L23pCXFdvyibbu6IBsm7p/4PDUeOmcdY/+cKryhZ2
         Oggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212219; x=1784817019;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYdU4t2+gE6AXuv8NtGQXs6INIroF6XnwJU0+W2hmSY=;
        b=pdMIj0G7dB94OPpPj0GNXBRARtVmqLe3hNedeGd0IrUrkMWlWpTlMTQyK+/1imm0P+
         DYnfM/dGz8rP3RhVAGXYeiU41sk3UNlobtM9zA//i9MKixh3WlP28wh84t3hurilt31c
         lOvy/L8a1XYqJqE+txS5qHPQpUFj8Ext9csbczV1gn1g3bdGu0eHm79w2ZbbyTXcpqmD
         lwvPV4XIwzqLwwWU5UoRANhQigCt4PtTHcB3sf90/iyN5zrqw4atEc+VoevX0DqyYAvq
         v0/JouFw8OFPGxHk+u7ov8WrwxwEtB054fKmrrtBwqt2OWmvALmeQz780vweX0vppdVR
         TQJA==
X-Forwarded-Encrypted: i=1; AHgh+RqJpv6bFYo7KxPy/16MjkcLkpxzdJFHBPmlR3OIXrYz8DkLv63M+aJZP9qu9kUp6Kzeacg4qYQ4DBjR4YMh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywscwz7qxPnfjD3GpDde5h9CeFL5LML+K2SLf3HUeA3lnobLqNt
	qRAuSNrgByGocpkHuBqz+E0YcH/mpNpv4xsxNMpyiD66bZ4ZB5xFVj18sVOgZIL/72zGq1DIgFD
	/jNOUK6T1HXA0NQ==
X-Received: from ejfz17.prod.google.com ([2002:a17:906:ad1:b0:c12:6e77:2fb7])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a710:b0:c12:6584:c1 with SMTP id a640c23a62f3a-c1667a6921dmr585573666b.40.1784212218007;
 Thu, 16 Jul 2026 07:30:18 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:30:11 +0000
In-Reply-To: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260716-folio-alloc-cleanups-v1-2-5363b8e92d33@google.com>
Subject: [PATCH 2/3] mm, treewide: replace __folio_alloc_node() with folio_alloc_node()
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Commit 5b584d2d22dca ("mm: remove __alloc_pages_node()") removed the __
variant of alloc_pages_node(), after users had been migrated off it,
since it just complicates the API (requiring users to handle
NUMA_NO_NODE, or risking hotplug bugs) for no real benefit.

This patch brings __folio_alloc_node() into line too for exactly the
same reasons (including the ulterior motive of freeing up the __ variant
for use as an internal API).

This time, it's done as a single patch because A) the users are fewer
and B) folio_alloc_node() does not already exist like
alloc_pages_node() did.

No functional change intended.

Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Link: https://lore.kernel.org/all/ed4572f4-0074-45c5-993d-7b6533eddc31@kernel.org/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/iommu/iommu-pages.c        |  9 +--------
 drivers/irqchip/irq-loongarch-ir.c |  4 ++--
 include/linux/gfp.h                | 12 +++---------
 mm/filemap.c                       |  2 +-
 mm/migrate.c                       |  2 +-
 mm/page_alloc.c                    | 17 +++++++++++++++--
 net/sunrpc/svc.c                   |  2 +-
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d85571..47e0759f0e0ae 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -56,14 +56,7 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
 	 */
 	order = get_order(size);
 
-	/*
-	 * __folio_alloc_node() does not handle NUMA_NO_NODE like
-	 * alloc_pages_node() did.
-	 */
-	if (nid == NUMA_NO_NODE)
-		nid = numa_mem_id();
-
-	folio = __folio_alloc_node(gfp | __GFP_ZERO, order, nid);
+	folio = folio_alloc_node(gfp | __GFP_ZERO, order, nid);
 	if (unlikely(!folio))
 		return NULL;
 
diff --git a/drivers/irqchip/irq-loongarch-ir.c b/drivers/irqchip/irq-loongarch-ir.c
index 21c649a89a706..427f7fd3cad42 100644
--- a/drivers/irqchip/irq-loongarch-ir.c
+++ b/drivers/irqchip/irq-loongarch-ir.c
@@ -384,7 +384,7 @@ static int redirect_table_init(struct redirect_desc *irde)
 	unsigned long *bitmap;
 	struct folio *folio;
 
-	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, IRD_TABLE_PAGE_ORDER, irde->node);
+	folio = folio_alloc_node(GFP_KERNEL | __GFP_ZERO, IRD_TABLE_PAGE_ORDER, irde->node);
 	if (!folio) {
 		pr_err("Node [%d] redirect table alloc pages failed!\n", irde->node);
 		return -ENOMEM;
@@ -410,7 +410,7 @@ static int redirect_queue_init(struct redirect_desc *irde)
 	struct redirect_queue *inv_queue = &irde->inv_queue;
 	struct folio *folio;
 
-	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, INV_QUEUE_PAGE_ORDER, irde->node);
+	folio = folio_alloc_node(GFP_KERNEL | __GFP_ZERO, INV_QUEUE_PAGE_ORDER, irde->node);
 	if (!folio) {
 		pr_err("Node [%d] invalid queue alloc pages failed!\n", irde->node);
 		return -ENOMEM;
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e4e974a6e5f90..572605d84e30e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -251,15 +251,9 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
 	dump_stack();
 }
 
-static inline
-struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
-{
-	warn_if_node_offline(nid, gfp);
+struct folio *folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid);
 
-	return __folio_alloc_noprof(gfp, order, nid, NULL);
-}
-
-#define  __folio_alloc_node(...)		alloc_hooks(__folio_alloc_node_noprof(__VA_ARGS__))
+#define  folio_alloc_node(...)		alloc_hooks(folio_alloc_node_noprof(__VA_ARGS__))
 
 /*
  * Allocate pages, preferring the node given as nid. When nid == NUMA_NO_NODE,
@@ -282,7 +276,7 @@ static inline struct page *alloc_pages_noprof(gfp_t gfp_mask, unsigned int order
 }
 static inline struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order)
 {
-	return __folio_alloc_node_noprof(gfp, order, numa_node_id());
+	return folio_alloc_node_noprof(gfp, order, numa_node_id());
 }
 static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 		struct vm_area_struct *vma, unsigned long addr)
diff --git a/mm/filemap.c b/mm/filemap.c
index 0dd8e2a15d746..1cf91970a6850 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1007,7 +1007,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			folio = __folio_alloc_node_noprof(gfp, order, n);
+			folio = folio_alloc_node_noprof(gfp, order, n);
 		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
 
 		return folio;
diff --git a/mm/migrate.c b/mm/migrate.c
index 222c8c15f782f..b7836b02f32db 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2682,7 +2682,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 			__GFP_NOWARN;
 		gfp &= ~__GFP_RECLAIM;
 	}
-	return __folio_alloc_node(gfp, order, nid);
+	return folio_alloc_node(gfp, order, nid);
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 37a3c1c00e169..86922270df157 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5435,12 +5435,25 @@ EXPORT_SYMBOL(alloc_pages_node_noprof);
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {
-	struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
-					preferred_nid, nodemask, ALLOC_DEFAULT);
+	struct page *page;
+
+	if (preferred_nid == NUMA_NO_NODE)
+		preferred_nid = numa_mem_id();
+
+	warn_if_node_offline(preferred_nid, gfp);
+
+	page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
+				    preferred_nid, nodemask, ALLOC_DEFAULT);
 	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(__folio_alloc_noprof);
 
+struct folio *folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
+{
+	return __folio_alloc_noprof(gfp, order, nid, NULL);
+}
+EXPORT_SYMBOL(folio_alloc_node_noprof);
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae9ec4bf34f72..74350a2e07036 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -711,7 +711,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
-	rqstp->rq_scratch_folio = __folio_alloc_node(GFP_KERNEL, 0, node);
+	rqstp->rq_scratch_folio = folio_alloc_node(GFP_KERNEL, 0, node);
 	if (!rqstp->rq_scratch_folio)
 		goto out_enomem;
 

-- 
2.54.0

