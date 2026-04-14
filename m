Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B135B631
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158187; cv=none; b=f4hhTa1vtDU1+mO+WznM0A/sfbL2qDEf0e5rTnJfQsWm3wyEmYQO5wnZvWKRzCTFoub6ByPJWPXJ0jb/W9drGikIMGEhl4Cv6r9ShUdJIvc3VucLizK8b88JcwLYgmWtEaXmdtMSE2WxRknP9htZPgzevtJzZdo+HGw07xFtZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158187; c=relaxed/simple;
	bh=nabJJ2tRSjgXsfVhjycDB6bNUKrgkKWj5cInp5QbIus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrNUvF813eYsciSQDSSOfh+n2+wL07YUfU3pcQDw9w1cJA5UGIE1s9q6jPKge0doqIyKoePvqVt8UxdAu3Tlw6YqNjq9zkvmlmM88pELj/iu+HeEpVhpiTYDc0tXjzCPYEQxGKu7HJm7dYBXBKqi9WNUPFXJZZm/I8b++uFZzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=buF2bIC9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="buF2bIC9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776158184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cl11sG7u/+NHktUdM96cUoh+7Wg6iuNjhJ6suVzR84k=;
	b=buF2bIC9KmRd4kn31/Rusxq2pS4W/UeA2oA4o3ZAcUXos0LYlUrzpsYxwtDnmudQT50ba5
	59iTe9p7v/FvolvAKJV66cbFhFktzN3bnXnbLv+bl1tgWVVyyd/HUkkn20vie8g7RIKo04
	xFd4cDpi6wgUFlos4LqRyj+2SluPsLU=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] mm/vmstat: remove unused __node_stat_* wrappers
Date: Tue, 14 Apr 2026 17:15:20 +0800
Message-ID: <20260414091527.2970844-4-ye.liu@linux.dev>
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

Replace the single call to __node_stat_mod_folio()
with node_stat_mod_folio(), and remove the dead inline __node_stat_*
wrapper definitions from include/linux/vmstat.h.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 include/linux/vmstat.h | 18 ------------------
 mm/page-writeback.c    |  2 +-
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf782..54da7d820f78 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -440,24 +440,6 @@ static inline void zone_stat_sub_folio(struct folio *folio,
 	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
 }
 
-static inline void __node_stat_mod_folio(struct folio *folio,
-		enum node_stat_item item, long nr)
-{
-	__mod_node_page_state(folio_pgdat(folio), item, nr);
-}
-
-static inline void __node_stat_add_folio(struct folio *folio,
-		enum node_stat_item item)
-{
-	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
-}
-
-static inline void __node_stat_sub_folio(struct folio *folio,
-		enum node_stat_item item)
-{
-	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
-}
-
 static inline void node_stat_mod_folio(struct folio *folio,
 		enum node_stat_item item, long nr)
 {
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6f9b7b081ab7..ed3301753e89 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2627,7 +2627,7 @@ static void folio_account_dirtied(struct folio *folio,
 
 		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
 		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
-		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
+		node_stat_mod_folio(folio, NR_DIRTIED, nr);
 		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
 		wb_stat_mod(wb, WB_DIRTIED, nr);
 		task_io_account_write(nr * PAGE_SIZE);
-- 
2.43.0

