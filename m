Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424992;
	b=EH7xfNyOTJ3ezS5QR+7ZqFqTACNW8WvJ+sTS6uPo/rutVUwilf14BLacAf/aYCBMJxEa
	 jKvHs+E2EscFwrXKBqnVTSqAnGIzWTya+gQk/eaToNV7tmOo2jdO44xPpTr0GX2RONBrT
	 g6QLROzT7LIE98XRuDZzzL0fi6CgvZJF8t6RjXKVDPH4m/bzx/3mH6DT9QveJksrrCytB
	 a3+w8oYV7SUM5BHk/H23LbdTlbTIZ6sLPhbapWWMx0L7F8gd/z8yWicegNvlUBpbNztCJ
	 zOtoC6OFV8plpGjZ5j/0ar6nVbLLKvwxI4iy2LYJfR+iRuZt8G0TNrDdr07urZW4Idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424992;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ed7Ai2/v+4UUMnde8ZmMAQuE9IFX/8DJI4RqAxylpU4=;
	b=r7VxW7KO3qhlHUPIrJIk3Hfpj4Q3jFCdCCMyATRj20mbm9IPckDifLEtN1NuRqRqbyN5
	 0ELZy0VCXxgRD749VRTumAMKNmCXRxb2YsobfYVjf+JrpjDdXIc0dKj3kAgu0yI758T48
	 rm03QZMBmf0yfa6BW26Rmp8byTcKP3VfN3xW8tod60Y4RNwZrrDd1c4M3K7mrtcLYiKrh
	 HLp7SWfgibgH3D//EWv06un3bzITFqO/TYzkUUyOYJWQEhvZbBlbIwgu7SpW0tuh/o2mD
	 Jk7NXQVYxgwfkvFIB9R7w70wopclIT9OKn2icbr5sy9QRnztIDAykD4hy29UF1ygmjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QATB7jCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB0606AFA0;
	Mon, 19 Oct 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QATB7jCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FE61F000C9;
	Mon, 19 Oct 2026 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424991;
	bh=Ed7Ai2/v+4UUMnde8ZmMAQuE9IFX/8DJI4RqAxylpU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QATB7jCZ9GC+p/xOCU4/r80jMnEHJ3IGAgM3NU+u6I3pBVOTcLCwE1dmSk0y0K1EJ
	 3r+krUEHzAFTZERtH9bIx2vMwuw8Rjs0tAXXx2bEOmBG54nohjew7NGXlmkMHCIh5l
	 IrnGDfwxl/S9N4c5eCqN14ObXaZ77/sHnzu6VfUJLIjSazs1rzLC6kR/JBZOGbsz8Q
	 HA7+Z6RetZhWrmrsxHCFmLBefoUo8+u/qmQoE0xAAfaOk5dOrKCDKb6WPJN/gkHJwv
	 zyrOsdKa5+pt3peyv3sTCP0h56PTzZhpr1qCjN0gCLTdNGX4CVX1yArKzydfYBDnMa
	 2OA6vxmjFVLIQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 273C5198003A;
	Mon, 19 Oct 2026 11:49:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Oct 2026 11:49:47 -0400
X-ME-Sender: <xms:FzzWantOCua-VDu9iB8EwtxWSoCGDpT96WqpNrlxnEn7UKNqTWK-wg>
    <xme:FzzWatv_Ju_rpZSEV57r6-hD_rA7nAgAiPM7uaYqTps1TgDveSu9w-sn32URKMhAQ
    fvjmRFZmTmXFRF5CDARGA7PUoPLwG_7fRz_2k63AUPETp4A3Kd-2ADF>
X-ME-Received: <xmr:FzzWatYBqskvnaMIj2tsnerI3l6B-PeSqJVOtjXksSDBg9GLrNbyWqvjywc>
X-ME-Proxy-Cause: dmFkZTESqR4vElUNfwe4Wb1kabMg9MdYUtHyNIvlHi5jfGRsEd0tjiYfzpqh5FemuLlMuA
    +QzWL/iolJzzDzQk8vzuoT2/u2xyL/YZG/CihU2eaSQe3uAw7YKu/Z/hQfgMIJpEQrBQkK
    hH3KJVpCmjg+gNXnnOIkdBMKpJa1pvTLqzuojrt68Uovke10kpOzVhZrNEf3d58NDgoR+6
    GBwzdAiHoLFFDGJo3/r+XBHeUTBbw+IeFaYdgC0j5JEQlKAOMB5I7tBUfVMuw5hMfUnXf2
    vE1DwOk7N/x2FbtU++Y3QX/1ODQhD5sTVGp3EMvK4jUTItTZrn4RBPsK+PhnbeHfl8JcGw
    mU66hr8sFGivOaQBw7U2atwUF2x3djrLkSB9Q3mnaguXHMvDkpm7rhqSFA0ohGFqfUUH1u
    dxHChWUAxw09NAyZDTfJM81AqrT9LU2Vh5Twlr1hurWQ1i4hXLhrWSLYZwnEQegkEOZsBW
    2ssW6OwYwuRhSe6+I65NTvx7Vr9rCb4mR/BhnMrDjmQO1o94/n4xqYxXyl9y9h78FGtvT7
    ndUWzFlFeeSkNndSFl40rBwl3kdQCD+HNz5+1/tpvq8eqN0/fc81tAtElmtYU/Zb+HGtUw
    CDw5XP+G/fbauiZeq64n2XnYIQyFVBZPncpoGy7aFOK5fl3W6hqS5IiGwv9Q
X-ME-Proxy: <xmx:FzzWal4oGKJQQJBEBE_yVeldJUaYWuKnhcJjbWSKmyDIBRA65HOEYA>
    <xmx:FzzWaokyTijrjl6aD7KDcLDxKUXbdkwf1NZJCVWkj1_eMiqH2txszw>
    <xmx:FzzWatqsVxRihyrJ4Jt5z8Lt5-RTgWqjFAgg6S6tYKJ9x5MJ-7wDQw>
    <xmx:FzzWar-uGBsOc8BtyYgrUS4o9fz3asXLU8t5GuWBuNrxzAZH8Zg85A>
    <xmx:FzzWau5GcTO7SpAEjdAlUNM67V5k3ysS3WfSFY9UICjkvvPSLfOddevA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:49:42 -0400 (EDT)
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
Subject: [RFC PATCH 04/18] mm: count the pages waiting for a grace period
Date: Mon, 19 Oct 2026 16:48:57 +0100
Message-ID: <20261019154913.1765974-5-kas@kernel.org>
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

Deferred folios have refcount 0 and are not on the free lists, so no
counter shows them.  Memory that waits for a grace period is missing
from the free count and from every LRU count.

Count it per zone in NR_FREE_RCU_PAGES: nr_free_rcu in /proc/vmstat,
free_rcu in show_free_areas().  Preparation for freeing the waiting
pages sooner when they hold back memory that is needed.

Assisted-by: LLM
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

