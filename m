Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD4481256;
	Tue, 25 Aug 2026 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666147; cv=none; b=bWg5ILejZNpg4IQEHvEfoygqjHrdg3XtEtAe22ztJkklrLYOFQEookNOhzm9lluPA9pFudsnTaTxV4vyKQyVYVBxTGFC2lv3g596LtkHoD5WbWaDZ1U3CTLuj2gs2lY/fqgevejN3EVMGjGpTDP5trMapp6n8xeF1o4Qmkh0dRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666147; c=relaxed/simple;
	bh=0/WeIqBfPKwCqAW+ElrQnm7JI/vBCWEn6IMLIr1sMYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcwqLhswbuAJElkP/OViKvjMxYyUcj07N0h+0gd35LHG9OhCaCcYfVv6bK0exHX1gmk1ZgV4a6VL6u8UQXGLjlOkMmK7IN6pnvq+aOK+7/RAkn0aWVqBXqv/N7ubaWDBI2eDXRgC3EHFd1TeJ/3+JI+np+ACB6TPK15tjZEoNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CF8C3EC48;
	Tue, 25 Aug 2026 13:55:33 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v4 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
Date: Tue, 25 Aug 2026 15:52:07 +0200
Message-ID: <20260825135209.3135169-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825135209.3135169-1-alex@ghiti.fr>
References: <20260825135209.3135169-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTGiHDiWlfQ5ccxBZewsSasowgl6gtfYlDY1PWykUS63s55gMKk5eyoNcDBuK/u7C54COj+K24nRLBNKdyIK2RQTz0Gd7w2H9vLC2370zE+Ddl7i6a/AXnrEXG/Z0BlNEt/8xyMeSW6zBiRZZwvjEQff7MVGCDEPhCRkLbIwEbRTVuxjo/fEYI5R/+1hgmHojmsu8cW0sWOxX9UVZyxkZFjKfn8+jU4byiXlitSGcdBMjxKaqXvJ5iTQAfdm2MFjYyiM9uE53CRdiBRxdil8ElrlmgLmGYOBnqlq0fAMw7kI3FGQeaxVI5JUrPkWhh338+VpDFe89mQ4tcVzXfaSQ8hzO/SV91Cb7MrhV04BuJgiTggGt7Zdy76v+v7di5V0F2GWJCgToIeVaHv/Py1bQ3X7vOAU0B8xrylrXT48j2SQPSTKdpB92XGLcGraHgdEQU91N+ZEkWE0EcFcwWBVjG4UlvtEJ4g3dezAkjFWFHIeOOTWEYYxW6p9quP8zM5YnvsxNCuS9As6YAZcXNMc7qGf3JBHypUwMfNT4exbp8J3xkukcZHG/XNc5XQ7kT1Japjehyh81GsvvoqgbA+JKIPd8DFZWoCTLWUfe7Xjox8gz9Pj2o95Ze/TDPs3/QoqVyZjPFEADf8hZRx/ISlGVw/W3F88XplLHYxgWA1CMdOnDQ
X-GND-State: clean

zswap writeback decompresses an entry into a fresh swap cache folio and
writes it back. The folio is cold by construction, yet it is left on the
LRU for reclaim to find and free later, wasting a reclaim scan and keeping
cold memory resident longer than necessary.

Allocate the folio off the LRU and mark it PG_dropbehind so the swap
dropbehind path frees it from the swap cache once writeback completes.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/zswap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8163e6c5f76c..d16822a516e8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1013,7 +1013,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 */
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	folio_add_lru(folio);
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
@@ -1046,12 +1045,26 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	folio_set_dropbehind(folio);
+
+	/*
+	 * Drop our reference before starting writeback so the swap cache holds
+	 * the only one: the drop in folio_end_writeback() needs that for
+	 * remove_mapping_reclaim() to succeed, otherwise the folio is handed
+	 * back to reclaim instead.
+	 *
+	 * Nothing can free the folio in the meantime: we hold the folio lock
+	 * until writeback starts, PG_writeback then blocks swap cache removal,
+	 * and folio_end_writeback() takes its own reference before clearing
+	 * PG_writeback and donates it to the drop.
+	 */
+	folio_put(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, NULL);
 
+	return 0;
+
 out:
 	if (ret) {
 		swap_cache_del_folio(folio);
-- 
2.53.0-Meta

