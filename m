Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC037F74C;
	Mon, 27 Jul 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163192; cv=none; b=Y5/rkA3tci8zHAQ/ORHsRuJckynEZnK6vFMkP65ASCXPorSlpr2NT9z74YX4KCbr8STgO3A8t+bPqnMwm7JlJIhyb2TSWCJOUt1dyIhHgFANWGp+PAT1xxqV+Jxcvmwe7Txd0XycLVbxvRQ6H+TjpLL2EXDM7awVoxvtiiO5Z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163192; c=relaxed/simple;
	bh=aolK1f0v+zIumJIo0brIvWfiLLTfBJtofsNqQvfUfr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKTL5AKxQ0QxT1AVwZKK9UlIGPu+bIdgX9I0RvXdGLAaHv8lGQIm2amIk1TBL4L5eb9I+f9MXf7WcqUEsy2BN3IHyy5n8I3KLl31iZJUOxT65/IuSxhwjgKYYG7Om1YFs1a24u9Iz0TITX2F7+tVKb2GdJ2zaC6/CGdD0TSXLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71DB83ECAD;
	Mon, 27 Jul 2026 14:39:37 +0000 (UTC)
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
Date: Mon, 27 Jul 2026 16:36:10 +0200
Message-ID: <20260727143618.1582318-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727143618.1582318-1-alex@ghiti.fr>
References: <20260727143618.1582318-1-alex@ghiti.fr>
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
X-GND-Cause: dmFkZTE7fibksNbJ3BOPnuN4Nsp88JE+K7RxOzk//d8PXn4eGwwzNRopmgacf9wdZP1FVJNsGkZaiN7AN5bOrR7qSakeWc8nuEap5EWa2ZnV5XTxWyo6l/L9KMOjbg3oYCIpjk/wrnCi73w1cvWd/B4bKa+w5zyL4ghzVsNHUZpsMvg+ktmJKOrWWhrP1Slqgoo4TZkH99qCcm5wkVzbpgftjBONSalOFmKbeprIf6As9Id4IofJoPezPZJQV6t2xOW9zx3J0cuO7UavDCX5itas0MEP556/OzTQUUYubf7KpDxIqRiSWdBkwfjTjuH2Xk9m6YG5QjInKDeKMzCAWss1DBZBCFDp2FuOE9r1TFEjqHhJrMDkbWuUDzCRt/lx5wS03tI9SJ7Uz09fc+noHP9O4ONu0YtadWNA8JNCesxyTtz+kRCZCji97pi/dYSfWR+h2Agjt8ayGsSfX2aRd8Yi/bb+khe6ANGK/R21tkBxbm4gVQIuG5UN+W9D+sBPwHwcKRAqescazJ504sWwqDS/x/TX8Ijiu/rcKt4hZA7dHrKikRV4qadZrRkcFi++WGLFD2ySAfPn8kejStxi6YrxNsncfxf5v8KKTbAw7YcN/zHs2FhFvuOloHxQ75mYIz3yPSzcAOA9r18Bk9mrXoDiZ+PmxareTZCmSxkk+VJg78QWJA

zswap writeback decompresses an entry into a fresh swap cache folio and
writes it back. The folio is cold by construction, yet it is left on the
LRU for reclaim to find and free later, wasting a reclaim scan and keeping
cold memory resident longer than necessary.

Allocate the folio off the LRU and drop it as soon as writeback completes:
mark it PG_dropbehind so the swap dropbehind path frees it once writeback
ends. Synchronous-IO devices complete writeback in this context, so there
the folio is dropped inline instead.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/zswap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8163e6c5f76c..e37828e02938 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -992,6 +992,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	struct swap_info_struct *si;
+	bool sync;
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
@@ -999,6 +1000,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (!si)
 		return -EEXIST;
 
+	sync = data_race(si->flags & SWP_SYNCHRONOUS_IO);
+
 	mpol = get_task_policy(current);
 	folio = __swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
 					 NO_INTERLEAVE_INDEX);
@@ -1013,7 +1016,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 */
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	folio_add_lru(folio);
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
@@ -1046,12 +1048,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	if (!sync)
+		folio_set_dropbehind(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, NULL);
 
+	if (sync) {
+		swap_dropbehind_free_one_folio(folio);
+		return 0;
+	}
+
 out:
 	if (ret) {
 		swap_cache_del_folio(folio);
-- 
2.53.0-Meta

