Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A83C1981
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158192; cv=none; b=kus77sD39o4C/Y+jXBhLiQ0+RwRK3Nmn0V28BL8HRrp67oXVBC/qGPqT4AiVmHB3lvuYlZpGiH0H7cVZxYGroFl/RWZ+ErNQJR5MlzhW8PlfIwhcqSy01EJ53h6BeoeUfPbqkWhccg/PW7yvqK5oa1e608O8P19SK4r9LFQGzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158192; c=relaxed/simple;
	bh=X9tUl1YJczEifAlFTO7a72YOYzVQxoefF/ZtAImlv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s02brDkT6MIB/ljozGKYYWlskO9SKw9746BlrgoF217GMBx/FLXMHUsE1TeqmBmCLD40Qc3Ej1ZU+4sLLvfHte5FNmS2CwN3LIDEPQ2krjIluAPPD3fy471Br0J7Nb99aCsWadCbKvnHt09BEWKWqQmC3CkZR+0FprvdJASn5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bSzUWx5M; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bSzUWx5M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776158189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUwHi+Ort/Ib9sz8toDLY7SUId44AzcYXWL5RjCYhJU=;
	b=bSzUWx5MKFC5mvcnmpsT84AJ0+or8OtzZQhWDdciCAm54q0oDl5GeX3RJt4OyFGfgCc24o
	2iASg8NQc6TZdX2Cv3v71/uzQMPOcxhw+UX82Q1AvjbKDb4M0bDETBoRQ52+iXhQspfRpI
	Xu11Is5OQ36tweOrFYfGq0vi1dUcZ3o=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] mm/vmstat: remove unused __zone_stat_* wrappers
Date: Tue, 14 Apr 2026 17:15:21 +0800
Message-ID: <20260414091527.2970844-5-ye.liu@linux.dev>
In-Reply-To: <20260414091527.2970844-1-ye.liu@linux.dev>
References: <20260414091527.2970844-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Replace the remaining __zone_stat_mod_folio() call with
zone_stat_mod_folio(), and remove the dead inline
__zone_stat_* wrappers definitions from include/linux/vmstat.h.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 include/linux/vmstat.h | 18 ------------------
 mm/mlock.c             |  2 +-
 mm/page-writeback.c    |  2 +-
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 54da7d820f78..009b80e3c048 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -404,24 +404,6 @@ static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_zonestat *pzstats) { }
 #endif		/* CONFIG_SMP */
 
-static inline void __zone_stat_mod_folio(struct folio *folio,
-		enum zone_stat_item item, long nr)
-{
-	__mod_zone_page_state(folio_zone(folio), item, nr);
-}
-
-static inline void __zone_stat_add_folio(struct folio *folio,
-		enum zone_stat_item item)
-{
-	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
-}
-
-static inline void __zone_stat_sub_folio(struct folio *folio,
-		enum zone_stat_item item)
-{
-	__mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
-}
-
 static inline void zone_stat_mod_folio(struct folio *folio,
 		enum zone_stat_item item, long nr)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index 0cafcb2f4e8d..654487063fbb 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -141,7 +141,7 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
 
 munlock:
 	if (folio_test_clear_mlocked(folio)) {
-		__zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
 		if (isolated || !folio_test_unevictable(folio))
 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 		else
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ed3301753e89..dc15d775761e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2626,7 +2626,7 @@ static void folio_account_dirtied(struct folio *folio,
 		wb = inode_to_wb(inode);
 
 		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
-		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
+		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 		node_stat_mod_folio(folio, NR_DIRTIED, nr);
 		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
 		wb_stat_mod(wb, WB_DIRTIED, nr);
-- 
2.43.0

