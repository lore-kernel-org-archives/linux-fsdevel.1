Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E493BFE25
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158181; cv=none; b=Yb9HN2hkmC3dbONiiPxhLVCp78iS3M6kYaGSlPGytP22+u2LUufRa4nkmkIUEXvPzqG7Hjd228CJyocXfiMq7Umr9NsaQGqsx5Uwr1gSrj88vNZtclylS056pW2Jj84qPeKEgtcyTNIYy8hsie99V5JKycRBjwKU+Ba3OtiQgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158181; c=relaxed/simple;
	bh=nxTxVq6K3Bw2U0JDrr9AvYOfbWqH/rjUKDpf5OEqgXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkixfoBy2wkM5EltY+BjaiF6+lbAXli9hpUT2/2BjdNA+PX1MY+eB+EYW6ssDUJVdaXmLfjWe3gW5tUbu3VI/yUxDZa3YDjgivygd/4EusA4li/qdLj3LSpx6eo/rfLOnZOuKB1zVm0YPruugZ3okCPi2n5nMBorFGPNw+LZAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TX2kBkfH; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TX2kBkfH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776158177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Im9++lg/lpHN74Nk2FRmzX3snVH1LvwzoX73u95S3I=;
	b=TX2kBkfHAXl/AoJvsdawQlVCbbtFUOqmbqWwxcLAtHnvy8fCkD5glCD6qJF9rHwnYhySDH
	kjm51JNBzG2pEhhpUtjzdZZUioipbKBvZxZMy/tuFt3LOcA/Ykb9namQ677T6BvWiQ6goN
	2w1Wvh0FSYcZSJt1i/keRIly3WOEgbE=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] mm/vmstat: use zone_stat_add_folio/sub_folio for folio_nr_pages operations
Date: Tue, 14 Apr 2026 17:15:19 +0800
Message-ID: <20260414091527.2970844-3-ye.liu@linux.dev>
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

Replace zone_stat_mod_folio() calls that pass folio_nr_pages(folio) or
-folio_nr_pages(folio) as the third argument with the more concise
zone_stat_add_folio() and zone_stat_sub_folio() functions respectively.

This makes the code more readable and reduces the number of arguments
passed to these functions.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/mlock.c          | 4 ++--
 mm/page-writeback.c | 8 ++++----
 mm/page_alloc.c     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 8c227fefa2df..0cafcb2f4e8d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -249,7 +249,7 @@ void mlock_folio(struct folio *folio)
 	if (!folio_test_set_mlocked(folio)) {
 		int nr_pages = folio_nr_pages(folio);
 
-		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
+		zone_stat_add_folio(folio, NR_MLOCK);
 		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 
@@ -273,7 +273,7 @@ void mlock_new_folio(struct folio *folio)
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	folio_set_mlocked(folio);
 
-	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
+	zone_stat_add_folio(folio, NR_MLOCK);
 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 
 	folio_get(folio);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 87e9ea41313a..6f9b7b081ab7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2647,7 +2647,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 	long nr = folio_nr_pages(folio);
 
 	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+	zone_stat_sub_folio(folio, NR_ZONE_WRITE_PENDING);
 	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
 	task_io_account_cancelled_write(nr * PAGE_SIZE);
 }
@@ -2916,7 +2916,7 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 		if (folio_test_clear_dirty(folio)) {
 			long nr = folio_nr_pages(folio);
 			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
-			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+			zone_stat_sub_folio(folio, NR_ZONE_WRITE_PENDING);
 			wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
 			ret = true;
 		}
@@ -2980,7 +2980,7 @@ bool __folio_end_writeback(struct folio *folio)
 	}
 
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+	zone_stat_sub_folio(folio, NR_ZONE_WRITE_PENDING);
 	node_stat_add_folio(folio, NR_WRITTEN);
 
 	return ret;
@@ -3032,7 +3032,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	}
 
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
+	zone_stat_add_folio(folio, NR_ZONE_WRITE_PENDING);
 
 	access_ret = arch_make_folio_accessible(folio);
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65e205111553..a81ceb4181ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1327,7 +1327,7 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		long nr_pages = folio_nr_pages(folio);
 
 		__folio_clear_mlocked(folio);
-		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		zone_stat_sub_folio(folio, NR_MLOCK);
 		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
 	}
 
-- 
2.43.0

