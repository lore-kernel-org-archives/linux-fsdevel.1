Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F737AA9C;
	Tue, 18 Aug 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070948; cv=none; b=rZ/aAqHFfcOKR2R31A0eFjZdKjUEpUGPaEk0t7mZg/yeZKC4sMyIE1Lp9wUdhTHqzMWxS1ilOUEpZtjMkn48aflknjh1VUBEPPFGZeoB9RfYdlpn6BCFjxFkpPQHHMngyWXOBkFSrbRAerwXbXWPDMXGdm7iirfc65x+r87elpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070948; c=relaxed/simple;
	bh=i7RXWzNjUM9mT8vzGnKbmsbVtAZDh7iC0K5565hU8r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXwZA47XZGYBFtpY3iLkilkYfb1ybbvuZm2hZjJh92bXOPoaaytaZTjA14TJa8ZrtkS58F94tgopRS+RtiyOyauxWWHZANeMEllARnlAQ869IcCjK11f44EsgGjhV/9om10kK7ba0v4aBiwgSQXj6fYLp2my1n0fkpN1/nnEHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B2C91F481;
	Tue, 18 Aug 2026 16:35:41 +0000 (UTC)
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
Subject: [PATCH v3 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
Date: Tue, 18 Aug 2026 18:32:00 +0200
Message-ID: <20260818163221.589352-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818163221.589352-1-alex@ghiti.fr>
References: <20260818163221.589352-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTFhwtGOHO/OC4b8xDhaenAw0ulkOus9FaFWHZYSGUVEHOu3uVHUJQDjV+J84J33ebDFlApYLH3YLEUqtWFmuQdSK1irj6MX1MBEbJLXzAQx7OObcE/toye+GUN3UEOmEvSmRNLLmpgVb+qXKjo52/AG6mFAh7FS744BvnTpNurRq3t6Hp8S0BAmC/gKyOBrbLNJozvfhAa3w3qU15mfEoNYHwE0OU5NKqOYfxUl3AOq79I2M2NeYOwJv2DcrCoGGhb/RilbXlq3sGiCkYnmrOYmu1bDDktDq70Sd5yAaOIv7w5aJ2t7nvcUB+FCfg2l/PUe7QukE+KWF1EEzPeHJ2btbH2uklxcsAHc2+w0VMrqR6xDiRElI6DRrpsWOkkaGoSXnbysFZsUX3cde6+iTR9TdURDhO5Dz+71lGBThShNuw7cx7eC8/LVDAaSkuzjJfwbuVNUfX78Td+1KWX2vrk2TXM7jp2l2LJyOBGmURp/nIXUzQfd0MGs5VzNfjfZNu5/v2B5mNddp0C9NJqKZM1RbZviCqUcmawUK5vCucJxdJwMF7gTSOkT+9RdHhtWTMflW/Ed9jUsEmepGn/1bwBoObLFITCtw2JENSdYFVnSdaAj8h1vWnEFcCwC+GJJUsDH3tvUwWWUe5h9eCPNDwBH+mLG8STCj7MWXXSnPbROxw
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
 mm/zswap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8163e6c5f76c..a35671e837f8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1013,7 +1013,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 */
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	folio_add_lru(folio);
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
@@ -1046,8 +1045,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	folio_set_dropbehind(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, NULL);
-- 
2.53.0-Meta

