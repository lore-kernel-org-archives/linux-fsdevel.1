Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797315;
	b=m12BlywFWzjz2j9KsFw4I8gjb/qT0qWVWmvZEYHnvIT1ZA+I3MtEfQwR2D1cmsu5MD0U
	 RQ22TD/N2BqUtjv8Ct/O7lF9eq+WTAKev5xDy9/04Xo2aHmrx+AeagUm5Udnx+hW7sVMK
	 3CfPQOgPSkyuQ+3jXxrg/5IgfzwkpwF5spYzWM8MtG/cNFnsSGifBWRgWGZ4iRirYTcLD
	 rYYDLQflxazTNv7Y9EFurf0vwRe388qoFty0Ri3kKzGLM6+YGgmJA5j80SjTmPMTbmWUm
	 Guujm2hZd6gbRdVFfz65e9S/Tg36Dw/ffnU+AHSSfSSLXwUDYoC3aUrb7ROmHxehoKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797315;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B0IkSILmEXDD5SZITUdfDPnAIvH/qKn4TnRnHPUh0Ts=;
	b=FmRpCkHh28KfOx1ycF1qU6/B3o8aPl3zJfIthSoUgVr8Pp42bYsGQla6Ob4FuwdvmVRs
	 M3ANLPGgCwZRxnwPh5ZYaW5v1W5bZegbh8Jx0aM/blMM/8/yxSy5ECoA6HScbogQLNa7K
	 bv4HGIZTZ3Mlj7T5NqX3yLVW+ZmzhwoDwNp4AFusZUyx7YSSiVWklQyGnsQxTRPpUkbae
	 WBXIjc9ZHsXTaM73x/gyUYQ7cMtb06S+pIdm4OmprA6OjY38JUP/zf61HumvtOeiI/3jq
	 JLYKPr3j4zGDHLs/N5akcC6C3JZ4rsJDwzhUzvBT6+7HiiUsaIcULeQ8fN1VQEJfPnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDAkSE0r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D1606A33C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDAkSE0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323241F00A17;
	Wed,  4 Nov 2026 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797315;
	bh=B0IkSILmEXDD5SZITUdfDPnAIvH/qKn4TnRnHPUh0Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDAkSE0r0bCMeADhVieVZuLNlHVDkQd1mLuMqGggDincJ99lZouHuSKF5MJCoF6vE
	 Hcca3DlLynjJQbXJ5rVkuzcwWuI01YBVkFphvO1FKldru9HDDv6dATV3zEWNDlYf71
	 myoa8IgVePzw2k2dpuJ3NDe0tFLEC1ugkiRrGxYy/GLuvkDMv/JW8ImEOIlL0QBEj2
	 2VBVeXks6Mrc4uzaPXjrh9Iq+DBB206db4karTJNgM6ccPEgU5f7+BWTnCc72yYGUC
	 S3V8HbttvRfVP5dz4BQCS8FGYxVs3IKeH6Y3WZLUMXKrMjOL0k81+lanIOzTcUzF9T
	 tWWzZ6bCiwMdw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 09C571980052;
	Wed,  4 Nov 2026 08:01:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 04 Nov 2026 08:01:50 -0500
X-ME-Sender: <xms:uizrapVrclNr8_pL4FSy74YnbjY1cOXxoVoji7AAq7WbjE6ZHScs-g>
    <xme:uizrarHIgnlmMsisAjfoj2fK54I1TAh4dXp8-OUkFAl3w6198HxF8wbq76-hqWi2P
    RnIuUix8jFG1XbaYNBT4qmdljxK_-ceewb26SVeSYHD4MAEcawnTA>
X-ME-Received: <xmr:uizrauAHQ3OE4IfGOHvAMrb36jO459m0oSJP8_eCCD0pLL1XRoQpp93lL1s>
X-ME-Proxy-Cause: dmFkZTGhPc1Yg5t9Q8eRQaKCLT0heVoXQqf6h4uqMuRtXQYzheOI1jp47nBw26mcWoxz9A
    DH10HnpPYob7RxaCTf32YkHXSpJmh1hLC1IxxzXB90aJAI2wMnFT+nxhjDMKjWZ9Ablulj
    X6EGhbUdQWvr3vCsmIbyKlTdtYm8QJi2H9b42DzXiIRq27TGzwIAKeq7xgftm17WrW++J+
    RK/ZhBFKi/01LbyIuttpTNhw8T5nzUYT3/gbSIkELTYoQfWYa9TU1xDsUR8Sja7r663Vhq
    dT9Vb6Q8iqTkFCbamg7ObiOCckNJsrzr7UPmHz2jvO2iFJ92ew01ZxP0mcoMzU2JutwOgh
    Deo/g8HEwAnSd00+Sk/Osdm3LkGjObnA/8QcZNGNOZB+xfOYdGiUNVUf88aFswCacRCBmh
    hokiHdjKaDT29DPVI5Gwiwh/q+igH0C/vvAF0DQfDnNNnYvNgvu66w2jS7vOo6qH6K+7yt
    nAK3PvNPliSxNz0oqqpOCzOQhLaohJNb1Vx14bhmF4ydiadh2RekHpyLnGH/Zwua5u6R6F
    aDL/oG6RE6eKtnqYtU1aAOsrFBDA4f8uYS5E4pjAfQtiTgIi2w20lgAILHMHHRHj2bJ86f
    yYuNqEQjBPE6f07SQgmnAFPAvn5ztU/tCIiy0YSmAyRxyx7vxhdWM+6YJTRA
X-ME-Proxy: <xmx:uizrauWsdhQjR-9OfL5yBh0fuMvI4QvIKJQsf2XESph5E8vNwllxhg>
    <xmx:uizram6VeZZh4Bnkj3qhUglgOhGIgPmrg36SHv1dYfMuEZ53GQ2A_g>
    <xmx:uizranG5SDaFUpvrB5AjjHOQb0cf91fdKfanwlc24rB5wyrnvLAqZg>
    <xmx:uizrap1xHQ6bLsYSSBoA8Gn9N6eE4-tWrhS2g5H77XucroW0c3tfww>
    <xmx:uizrar3X2nODYMoj_NapJQRjucu3zlsBRVTFnIuPjVB7eHv2vx6qE6UK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:01:45 -0500 (EST)
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
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
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
	kernel-team@meta.com
Subject: [RFC PATCH v2 04/18] mm: count the pages waiting for a grace period
Date: Wed,  4 Nov 2026 13:01:00 +0000
Message-ID: <20261104130118.2507513-5-kas@kernel.org>
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

Deferred folios have refcount 0 and are not on the free lists, so no
counter shows them.  Memory that waits for a grace period is missing
from the free count and from every LRU count.

Count it per zone in NR_FREE_RCU_PAGES: nr_free_rcu in /proc/vmstat,
free_rcu in show_free_areas().  Preparation for freeing the waiting
pages sooner when they hold back memory that is needed.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/mmzone.h | 1 +
 mm/page_alloc.c        | 4 ++++
 mm/show_mem.c          | 9 ++++++---
 mm/vmstat.c            | 2 ++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 94f9c3ff5416..3336b9e5ee99 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -228,6 +228,7 @@ enum zone_stat_item {
 	NR_ZSPAGES,		/* allocated in zsmalloc */
 #endif
 	NR_FREE_CMA_PAGES,
+	NR_FREE_RCU_PAGES,	/* freed, waiting for an RCU grace period */
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	NR_UNACCEPTED,
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a371e92da273..15bb66e36304 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1348,6 +1348,8 @@ static void rcu_free_pages(struct list_head *list)
 
 	folio_batch_init(&fbatch);
 	list_for_each_entry_safe(folio, next, list, lru) {
+		mod_zone_page_state(folio_zone(folio), NR_FREE_RCU_PAGES,
+				    -folio_nr_pages(folio));
 		if (!folio_batch_add(&fbatch, folio)) {
 			free_unref_folios(&fbatch);
 			cond_resched_tasks_rcu_qs();
@@ -1375,9 +1377,11 @@ static void rcu_free_workfn(struct work_struct *work)
 static void rcu_free_defer(struct folio *folio)
 {
 	struct rcu_free_pcpu *r = raw_cpu_ptr(&rcu_free_pcpu);
+	struct zone *zone = folio_zone(folio);
 	unsigned long flags;
 
 	spin_lock_irqsave(&r->lock, flags);
+	__mod_zone_page_state(zone, NR_FREE_RCU_PAGES, folio_nr_pages(folio));
 	list_add_tail(&folio->lru, &r->pending);
 	rcu_free_start(r);
 	spin_unlock_irqrestore(&r->lock, flags);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index b938cbcd774a..0d3bddbda108 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -204,7 +204,7 @@ static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
 		" mapped:%lu shmem:%lu pagetables:%lu\n"
 		" sec_pagetables:%lu bounce:%lu\n"
 		" kernel_misc_reclaimable:%lu\n"
-		" free:%lu free_pcp:%lu free_cma:%lu\n",
+		" free:%lu free_pcp:%lu free_cma:%lu free_rcu:%lu\n",
 		global_node_page_state(NR_ACTIVE_ANON),
 		global_node_page_state(NR_INACTIVE_ANON),
 		global_node_page_state(NR_ISOLATED_ANON),
@@ -224,7 +224,8 @@ static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
 		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
 		global_zone_page_state(NR_FREE_PAGES),
 		free_pcp,
-		global_zone_page_state(NR_FREE_CMA_PAGES));
+		global_zone_page_state(NR_FREE_CMA_PAGES),
+		global_zone_page_state(NR_FREE_RCU_PAGES));
 
 	for_each_online_pgdat(pgdat) {
 		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
@@ -325,6 +326,7 @@ static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
 			" free_pcp:%lukB"
 			" local_pcp:%lukB"
 			" free_cma:%lukB"
+			" free_rcu:%lukB"
 			"\n",
 			zone->name,
 			K(zone_page_state(zone, NR_FREE_PAGES)),
@@ -351,7 +353,8 @@ static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
 			0UL,
 			K(free_pcp),
 			K((unsigned long)this_cpu_read(zone->per_cpu_pageset->count)),
-			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
+			K(zone_page_state(zone, NR_FREE_CMA_PAGES)),
+			K(zone_page_state(zone, NR_FREE_RCU_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 66ed017bde46..64068d73d6d2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1212,6 +1212,7 @@ const char * const vmstat_text[] = {
 	[I(NR_ZSPAGES)]				= "nr_zspages",
 #endif
 	[I(NR_FREE_CMA_PAGES)]			= "nr_free_cma",
+	[I(NR_FREE_RCU_PAGES)]			= "nr_free_rcu",
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	[I(NR_UNACCEPTED)]			= "nr_unaccepted",
 #endif
@@ -2023,6 +2024,7 @@ static int vmstat_refresh(const struct ctl_table *table, int write,
 		switch (i) {
 		case NR_ZONE_WRITE_PENDING:
 		case NR_FREE_CMA_PAGES:
+		case NR_FREE_RCU_PAGES:
 			continue;
 		}
 		val = atomic_long_read(&vm_zone_stat[i]);
-- 
2.54.0

