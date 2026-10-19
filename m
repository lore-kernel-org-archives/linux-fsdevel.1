Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425078;
	b=4W0wOYVfoLQJEQt5fg0aQ+4Klo1d/LSXLkhkjSFq3EM6Hn1jtUHIsmS510XZaYRw2H0b
	 3UHxjlk7jXpM7Kv9fvBrlSbxMjXDyiA1S8cTo8FYxo6vgWxNxkXrnyrf6FHsoYfZOgKzI
	 x+RfnI6TOblnW24CEegJpOrMsRP1EBmB7UBZS4JsVwgjn0xVSobLdvKeMtzJ2N5m3qpv3
	 oekrFxJggF8as+3YqD2uPE2QNj0f+uDj0bB8AbML9IcCZ7imwAiplialMxFCRyMx1MGVP
	 dx8OpAxxLcaQLRrAIxAJxblSvJU2RAFEKicE3CTtBaZ/yJ0OMD9CotqRSU7gLLOkmlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425078;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RERAHv0f1FeePlwah3UOiQF6OoFt+Qe2xFbGw7JJygo=;
	b=PEdfRrP8J1Qxt67iC6lGCkA6cL7ejafdBGu55YFTCG6740nQsmbldp0fyedF/9wTkegR
	 STDRf/onb8nvL78P7CSMrA/6p8jBETKF2jGzyDHRD1WuK6jkzkWjApOuallVnzFrkk978
	 iTKkmZvyjbcmJt79LlgF9ACIgDzw/2U3aUd2/o0nYqvB2Yw6hysT++pybGpRge0CGYNO3
	 Ep+NI2mh/3K1KKRvGBEL31ISA985DdGXHn8snXU7bo0NHM8eT9mG0jLl/vilk8plwpjwD
	 VJFynwdG3FX5/IPqbv6z8FnY0FbWa1RRWF3i4URxol5t2Xsu4sqgbjruwE9ZQxdxnYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVp17WTC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D949606AF90;
	Mon, 19 Oct 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVp17WTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE301F000C5;
	Mon, 19 Oct 2026 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425077;
	bh=RERAHv0f1FeePlwah3UOiQF6OoFt+Qe2xFbGw7JJygo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVp17WTCGZq1k14qldmi5JzpY/g+CyF4VKgrTVccRfl4i4T06O4NRb7VgWzbFI/zH
	 myiQPWXgAHhVc/CRY9fcIMY0ieQAlF++fp8YkfMO5I/l3wK4UdPQi66Ae4ehsu3D/l
	 15hQ0zTglAow9EhdIGcjgb6DgAclapoSG16+yhqqtHyze+et0L33PYl0tiWns81tlx
	 gMZsbl3S/iL9/AMIGDBfQ9HHcc6whsZ0+Yo+eQd6UbXDtQWgzhRb8R7GlTvLqY77Qv
	 7+uAWWHUK7jwT6WCYtUVSLOw8lekOYHOuruFM10Sq9Oj6HSMWmr3+HjepFXBa0tXEi
	 nx9AzOMP6qdRg==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id 04F7D1980047;
	Mon, 19 Oct 2026 11:51:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 19 Oct 2026 11:51:14 -0400
X-ME-Sender: <xms:bTzWauYf77b2W8v-ONgvv6tBwE6NoKdZSEkBkYHJqcPo40VbIYXRJg>
    <xme:bTzWampMXk1TOFKrPxxCPCHMsjSIyuLDQlLiGsthTxHTArBOHqc1JkHkcsaGxulQm
    cBMxFljtMnH86CQeObQ0VgC8fSi-MEoqlb7nvtLz0tcDEderdOhNCoZ>
X-ME-Received: <xmr:bTzWarkU0iu4xNCwOwWKTc69RXpeXsmkeLVBpM1dyx7FGggWT_hgfZd2jE4>
X-ME-Proxy-Cause: dmFkZTGFA7RcREpaZWsLyw0Mr0XLVEScxscceCzrzQCctey9GkLKywZksIPHQL++5Ez1l4
    8ZtK4uQQ55DP6KC6KY2Tq4MmUijTRf9wNpB+eBiDYQyyOrNdkCvLnyLRoWmHqIJi9QgC5s
    a05lQI5Z36HZWoOti16iaeg1yeaoNWQf/xGUk9VWOqtF6qbSZNTrI+y5DzMoADYW/WYpe6
    xi0sGgMnsbIx31el0gfeshdIZno0srcJI8ohhNflL/0R7FrINqZHMwN5cb6lyav8SgTLVW
    L8jKHwxa2hVAuYmQV812wpYXni4+G+KXXKip3711Z5uNAji8ERrYRXaOa0gQ3V/ELjwdMB
    DY6RU5nX4lcmyZdq4kUuM+SZbr4DMh70PPeGkUpDgnX4Opf3mcxVPJ3HgHr4XJ/Sk5tPy7
    8xkCP9KYYUIlOnoYhtjVR3wPGHzGSuWnUPEZbh6vSNUWpd9lY+9iEhBZe7K6FJUPkMT8gq
    6W7cpQ3gxgFCXjGoNwpbmy2ccVtcSyoNpgIHVodlO0k+HOn8cFjzadooNdrrWVeM+CdYcC
    HTGsHHA9WhN6V4Ey1PUvmL6yOlYHbYD6AQv6Dda/+zzOicvimkllzttVSDEHTLijtjuhHY
    lrffnLRpPewMkqkSl+5MIOwX6fRCrGvVBPPSbjlkDw0USvz1zHci4cNsdx5w
X-ME-Proxy: <xmx:bTzWagUlZLE8_5n-leBaCMpdZtiH17ti9ud2JQXG7Iv4xXaN86sfPw>
    <xmx:bTzWaqTPmqzj0zd5QafpeTE_Gg6Iz9pm9MJbu2d4U60TPGMGj25SiQ>
    <xmx:bTzWalnTAH31iWgwwIeBXAmkWFSm6sXTO7Le86pRvTw6DhHFU-JNOQ>
    <xmx:bTzWatIsyEJwAp-U_A3J1RFiuZXKTu-D-F7y4RJCSUgwUb1L61uiXA>
    <xmx:bTzWagUH83c72LL_fasXLLGuHazhJcM_vSOt1AfzvS2oGYKaGjRR7xW5>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:51:08 -0400 (EDT)
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
Subject: [RFC PATCH 17/18] mm/shmem: read without folio references
Date: Mon, 19 Oct 2026 16:49:10 +0100
Message-ID: <20261019154913.1765974-18-kas@kernel.org>
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

shmem_file_read_iter() takes a reference on every folio it reads, so
small reads of one tmpfs file from many CPUs bounce the folio's
refcount.

Copy with filemap_read_rcu() first, and continue with the existing loop
where it stops.  Holes, swap entries and fallocated folios that are not
uptodate all end the copy.  So does a hwpoisoned page, which shmem keeps
in the page cache and reports with -EIO.

This drops the folio lock as well as the reference.  shmem_get_folio()
held it only for the lookup, and the copy ran after folio_unlock(), so a
read was never atomic against a write or a hole punch.  Now a read also
does not wait for one that holds the lock, as filemap_read() does not.

shmem does no readahead, and on its folios the PG_readahead bit is
PG_reclaim, which drop_caches can leave set on dirty tmpfs folios.  Do
not let it end the copy there.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c  |  7 ++++---
 mm/internal.h |  2 ++
 mm/shmem.c    | 11 +++++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4b5b7ba78f39..cde7bc68b32d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2837,9 +2837,10 @@ static void filemap_end_dropbehind_read(struct folio *folio)
 static bool filemap_read_rcu_can_copy(struct folio *folio, pgoff_t index,
 				      pgoff_t last_index)
 {
-	if (!folio_test_uptodate(folio))
+	if (!folio_test_uptodate(folio) || folio_test_dropbehind(folio))
 		return false;
-	if (folio_test_readahead(folio) || folio_test_dropbehind(folio))
+	/* shmem does no readahead: there the bit is PG_reclaim */
+	if (folio_test_readahead(folio) && !folio_test_swapbacked(folio))
 		return false;
 	/* memory_failure() waits only for readers that got past this */
 	if (folio_contain_hwpoisoned_page(folio))
@@ -3017,7 +3018,7 @@ static bool filemap_read_rcu_batch(struct kiocb *iocb, struct iov_iter *iter,
  * Copy from the page cache without folio references, in batches, and
  * return how much was copied.  The slow path reads the rest.
  */
-static size_t filemap_read_rcu(struct kiocb *iocb, struct iov_iter *iter,
+size_t filemap_read_rcu(struct kiocb *iocb, struct iov_iter *iter,
 		loff_t last_pos)
 {
 	/* The page the previous read ended in; ULONG_MAX if none */
diff --git a/mm/internal.h b/mm/internal.h
index 18391dc50418..ae9a4e511c82 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1249,6 +1249,8 @@ struct migration_target_control {
 size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 			      struct folio *folio, loff_t fpos, size_t size);
 void filemap_read_accessed(struct folio *folio, loff_t pos, loff_t last_pos);
+size_t filemap_read_rcu(struct kiocb *iocb, struct iov_iter *iter,
+			loff_t last_pos);
 
 static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 43ddb50974a5..e6c18e745f81 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3313,7 +3313,14 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	pgoff_t index;
 	unsigned long offset;
 	int error = 0;
-	ssize_t retval = 0;
+	ssize_t retval;
+
+	retval = filemap_read_rcu(iocb, to, last_pos);
+	if (retval) {
+		last_pos = iocb->ki_pos;
+		if (!iov_iter_count(to))
+			goto out;
+	}
 
 	for (;;) {
 		struct folio *folio = NULL;
@@ -3417,7 +3424,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		cond_resched();
 	}
-
+out:
 	file_accessed(file);
 	/* Readers sharing the file would bounce the line for nothing */
 	if (file->f_ra.prev_pos != last_pos)
-- 
2.54.0

