Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF046D548;
	Fri, 11 Sep 2026 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129036; cv=none; b=TrVD8DgRID5tUJ2aTz9XLaP/BzS1/SolUYF3R0e2xrauP7NMA65Ia/SHIMjWbVsdwPm7zsz77RymMvvv/n0hmvgih54KrDprskq/tHNp4uMwIOjQeujUuuhJvoaIcfZqVPpzDzpMOqv6dFjkZJUfgKLZw6OkLqOhl5/1OVR4IcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129036; c=relaxed/simple;
	bh=hgG4ex11E74cUjRpihO9PAt9otkIlr4zzhbWOYoUoiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idaZjo0ucuV2m9hOjO7Ezj8aI0/iapRYKV6EOk4v2cxrIIvShfUraP/IqetudE1E8kV7VRsV8Vcf6dH4jfXcQ72hsTczwcjONkC9k8iNYHQ7ZGizft1f61TogTQWrERb1wnwWJb9cYVzCu4XIXEwb9QLT5CnC8c8ufJYac3q8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F311F3EE2F;
	Fri, 11 Sep 2026 12:17:02 +0000 (UTC)
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
	Tal Zussman <tz2294@columbia.edu>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v5 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
Date: Fri, 11 Sep 2026 14:13:30 +0200
Message-ID: <20260911121341.178028-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911121341.178028-1-alex@ghiti.fr>
References: <20260911121341.178028-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGjfH5CE7EP1PUuoeu/l2HFd6FdF++hpOgW9bG6M/BTM9F3kapSlk9U7ADtn6kKTISwel0dj9XMJHazyTDJbuCGf1+V6dtQFmMVDsz/j6U8zJS5UWFxlLhlncEBXEX9YRxi/C/PDeW/pyF/LEG1lC35hb8/T6rd2drmQXNcsrOJKh3DWo1SZ4dO8uSsp8GEYnEzEJX5QWflCLS80+j+zqwa+6xD+CuZg9bY1SF9yIU/qkfoyyWDW3JGDJ+aEoJjjp0rdWhKxA6l0J4myGoeFOAENCEQex0bOWMMxHXz5RPKc2sXHCvtKxjhZn7rZZwnhvVGcaI9kZTf2hXpEZopWDbcmhuI+lkgO1VZkGtngqreNfPmyf09XQyJBcekrXeysSX6w+3lqnF8NI/Sss5Y9CLV3j4zFIVtAvlLtHyzjI01JS4lDYoffcBQM7HP0VdS8IKursJsgKwnxu844P8/eGsX7PaeaSHiuGSsUeJrNPKAHUlC5OIcapVTLWGKEdCVdnt4Poaya2cUHRSJJfNVtdy8HPTF8ZTFiplDr9GK5+OWkhuRKiGPKtsY5bCnmQ65H5rYfs2ZF82vh/9baR+n6C7HASFm0sLmnUyyJsJbrU2U6AtoFd2H8ZiO43+6SsmE/N8qdn+EU909sSEeMIJHFlxk/nhu4blmsYlbO56LUzZtDw

zswap writeback decompresses an entry into a fresh swap cache folio and
writes it back. The folio is cold by construction, yet it is left on the
LRU for reclaim to find and free later, wasting a reclaim scan and keeping
cold memory resident longer than necessary.

Allocate the folio off the LRU and mark it PG_dropbehind so the swap
dropbehind path frees it from the swap cache once writeback completes.

__swap_cache_alloc_folio() evaluates a refault on the new folio, and
workingset_refault() sets PG_active when it looks recent. Until now
folio_add_lru() consumed that flag and __page_cache_release() cleared it
once the folio left the LRU. This folio never reaches the LRU, so nothing
would clear PG_active and the folio would be freed with a
PAGE_FLAGS_CHECK_AT_FREE flag set, tripping bad_page() under
CONFIG_DEBUG_VM. Clear it after allocation.

That is a workaround: the refault should not be evaluated on a writeback
buffer at all. A fix for that is on the mailing list [1].

Link: https://lore.kernel.org/linux-mm/20260911092012.92399-1-alex@ghiti.fr/ [1]
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/zswap.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0d2efe21f18a..dc8425d6b21e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1014,7 +1014,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 */
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	folio_add_lru(folio);
+
+	folio_clear_active(folio);
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
@@ -1028,12 +1029,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	tree = swap_zswap_tree(swpentry);
 	if (entry != xa_load(tree, offset)) {
 		ret = -ENOMEM;
-		goto out;
+		goto err;
 	}
 
 	if (!zswap_decompress(entry, folio)) {
 		ret = -EIO;
-		goto out;
+		goto err;
 	}
 
 	xa_erase(tree, offset);
@@ -1047,18 +1048,30 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	folio_set_dropbehind(folio);
+
+	/*
+	 * Drop our reference before starting writeback so the swap cache holds
+	 * the only one: the drop in folio_end_writeback() needs that for
+	 * remove_mapping_set_shadow() to succeed, otherwise the folio is
+	 * handed back to reclaim instead.
+	 *
+	 * Nothing can free the folio in the meantime: we hold the folio lock
+	 * until writeback starts, PG_writeback then blocks swap cache removal,
+	 * and folio_end_writeback() takes its own reference before clearing
+	 * PG_writeback and donates it to the drop.
+	 */
+	folio_put(folio);
 
 	/* start writeback */
 	__swap_writepage(&ctx, folio);
 	swap_write_submit(&ctx);
 
-out:
-	if (ret) {
-		swap_cache_del_folio(folio);
-		folio_unlock(folio);
-	}
+	return 0;
+
+err:
+	swap_cache_del_folio(folio);
+	folio_unlock(folio);
 	folio_put(folio);
 	return ret;
 }
-- 
2.53.0-Meta

