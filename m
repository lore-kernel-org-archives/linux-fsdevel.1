Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425065;
	b=LR5SpWkl37spbVQFIuA8Wuujw6SwpWuUc+dfsqr9MEK18e2ax6tCrX1LkowpYCrcbO07
	 fUUKQSLisuy4PX5MWXSPEuQaEXWmB3cG4y3WCtUnvxQkZLUpjRwmiAAQ9gmyKY1MaPoJU
	 FmR9gTaQJJuN3uS78uEQjOSJdLBDTWJKzPqLTBrSu2deglRHJt7kQ1jpPcyAXUVeSDWYz
	 /GqT6VdDpG0oFx/pv1TOsY0jW8Rj3ORonSAa3o7ch8tr40TPqWa5Q5+dIC1ZXaq4EZAyU
	 MtUV6juv80MMNpBwe+jj3N+qjc8GQHabcvd6bu2HGhcbQQQ61Lc7ajDtSS1ntOWGlMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425065;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U8qRbxVMl9WjIylP4uF+PXHiNMFQO2d35UvAtzhx6sE=;
	b=hyBYgLnRQ+qA8c6HA/TbEdx/o3DKX2eDE0GUDBUP7ZrBazNr8CA0lUfWGWL/QOVzXsIu
	 xn83Nncqa8LbeWMLp2h/UoCLxosDD0gWoNawmAVZQBe2R1N3aS+hWARRuSXRm9kn6rrh1
	 24xYFeu7SQN+P3bT95xShXOcLYF9lYeLieTn3t03rKw8RQ3lhDoUXwIAOxifSqUHiQWXG
	 zbQjXpiiu1XgbxeyPaVzGgPCsFO1xZRs0P7Iu/yn+Cwc55YtWPUjSFLnf5wwI0lfJ7z3Q
	 VUtfv9iaytWwVkzBQbKMlGESgTanTcVLSM0Ucj26J+LM9UYJncX7/HHvM2NdSSZLEPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnAdu6ZD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90060A5BDA;
	Mon, 19 Oct 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnAdu6ZD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A21F000C5;
	Mon, 19 Oct 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425064;
	bh=U8qRbxVMl9WjIylP4uF+PXHiNMFQO2d35UvAtzhx6sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nnAdu6ZDFXBdBB4gNzu8Ggd9cR086mqfbYPXaOtCZTT8AewjP2nANp/ydyY5jtgP3
	 Z57ob+GY9oaERS+XRn3+HIoxExEhcT1J3mzGfXs/JW+EO1AUcDUgdCiCEVEgnsd0YV
	 UN8T64V5hc6rYE60h4FKs1NtrOuCpFTzO5WPynNhV2TsVpl//3dzIRBuqbIidDhgnG
	 uTtcE/OnhiIQb0yPnidHxRcKDZJyVcfrCWb/Sg2ltRHH5r6R1c/nPclrEXZ3rdjtX9
	 78pGC6YYYJyufyvgo7BQy3rbT3T2Hzg0cdPu06K4BREN+lFY/M608mMivwQxg7scKb
	 X+qc33EovSEbQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 1D1F2198004A;
	Mon, 19 Oct 2026 11:50:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 11:51:01 -0400
X-ME-Sender: <xms:YDzWavEfAzDHlbtkw43VHg8TgjhQJAnw1Jjqwece4I3M6InZ-xI0ug>
    <xme:YDzWajRvf9T-pZcLgW2VfcFdhAhsfvQAlVJ-ZmMYXZvghP4XJepVTjFWi3swHcItr
    0x-uN_A_buNRbTB-eqHjn77IPWSTwV0pC00iqlGLEpNCYH5_LZAQTqX>
X-ME-Received: <xmr:YDzWamQt4lUKxuM6mWiRPGQrl3ABRPx4XoY_U5iQ-jLjf99c2A4HLMs4orA>
X-ME-Proxy-Cause: dmFkZTEKM7cQ34PANJkOaDpnT+IXyH0pLg7IoM6i34Jbx05genX6Ndq2TdcGNb9654u2H8
    41WED7y/zjj5LaonH0VFTkPtnxIjhuRVEkvuk8kM9rm/ofB3Z9Tg4QxquxaJFHbDWQqeu/
    Vblnly/EuZwo3Wz9CpGJqqgTrStLmT9zjqH9hVTJAPs00+uZifgMXlnluxpV6wuH9uu7MT
    BObPpnz8l78pdcpT4Vufdwi//iHA9W9CmvvMWThM1WI/4eq4v7bHyLxAHLcqSlwPUMMG0k
    NFb5bNvmq2vpdgPX6RraAkdwYnZfp8UPDvRR9XmyDlbwFnPxU3uIs+BDzqJ7Yv2QnX71lk
    SqTihz8KrnAWYbCEV29gvySR44BJOhM620UDi7RgBFyzLt2FX77tl1bIEBd8zUsl2vqnNF
    nFaX7oJnw9jzl4Im4TmEN0FGPZ+hsD/Hpjbxq0aPtS9IEAD2eUm0nsjguUdSMoJhg0gvJg
    WclWlsxxO7a/TyCOSLZLOk2ezO+K1Pjj6gnvCHiC4xJ7A/NLQkpZIIyLZ6fIYskJfVezB1
    JTKjUjaYrzuI6H1hc1SKjxsKl3ECQXuoGoOaFfx3Txr+D8UvGA/dyqgPe86Zmx4yohNOZO
    g36OTZ7vqw89oUDxbVcG9dYAawcjetiW5em9S+Vas4yhNDrb4krv/lDYi4Bw
X-ME-Proxy: <xmx:YDzWahe6XQtR_czawTECLRbTlkQV8_F02JYYhKqCjvzBSiDbaJX0rQ>
    <xmx:YDzWalD4pdBDtl5ELDDJ1MH7xTird3kdsSn7mgvb21I_dMwrV2TdMQ>
    <xmx:YDzWav3TAoXK8KuPEM4LtTdnNSIUwL795qFfbdo06m35H3kNVyw5Aw>
    <xmx:YDzWalTWwMKpKrOa4fbMkkJAU3XstDwNk42O7fO9r5q-YYmBFZV0Sw>
    <xmx:YDzWakSweUIpfOdYnD9vJqMIMKktN7bTZdMldlEqsQh6COpyGDSZyMsZ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:55 -0400 (EDT)
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
Subject: [RFC PATCH 15/18] mm/filemap: read large folios without folio references
Date: Mon, 19 Oct 2026 16:49:08 +0100
Message-ID: <20261019154913.1765974-16-kas@kernel.org>
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

A large folio is in all the slots of its range or in none.  Once the
slot of the last page to copy holds it too, the pages in between are
this folio's: copy them after one lookup.  The folio's size is read
without a reference and only picks the page to check; a split after the
check copies PG_rcu_free to the new folios.

Copy page by page with _copy_to_iter(): the hardened usercopy check of
copy_to_iter() reads the folio's order, which a split can change.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 55fc471c0489..ace6b1fd6b9e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2843,9 +2843,6 @@ static bool filemap_read_rcu_can_copy(struct folio *folio, pgoff_t index,
 	/* memory_failure() waits only for readers that got past this */
 	if (folio_contain_hwpoisoned_page(folio))
 		return false;
-	/* One reference covers all of a large folio's pages */
-	if (folio_test_large(folio))
-		return false;
 
 	/*
 	 * The slow path does not call folio_mark_accessed() on the folio that
@@ -2899,6 +2896,60 @@ static struct folio *filemap_read_rcu_lookup(struct xa_state *xas,
 	return folio;
 }
 
+/*
+ * How much of @bytes, starting @offset into page @index, can be copied from
+ * @folio.  A folio is in all the slots of its range or in none: when the slot
+ * of the last page holds it too, so do the slots in between, and the pages
+ * are this folio's.
+ */
+static size_t filemap_read_rcu_size(struct xa_state *xas, struct folio *folio,
+		pgoff_t index, size_t offset, size_t bytes)
+{
+	pgoff_t end = index + DIV_ROUND_UP(offset + bytes, PAGE_SIZE);
+	pgoff_t next;
+
+	if (end - index > 1 && folio_test_large(folio)) {
+		/* Read without a reference: it only picks the page to check */
+		next = folio_next_index(folio);
+		if (next > index && next < end)
+			end = next;
+		xas_set(xas, end - 1);
+		/* A split after this copies PG_rcu_free to the new folios */
+		if (xas_load(xas) == folio)
+			return min(bytes, (end - index) * PAGE_SIZE - offset);
+	}
+	return min(bytes, PAGE_SIZE - offset);
+}
+
+/*
+ * Copy @bytes from @folio, starting @offset into its page at @index.  Page
+ * by page, as copy_page_to_iter() does, without its checks for each call.
+ * Not copy_to_iter(): its usercopy check reads the folio's order, which a
+ * split can change.
+ */
+static size_t filemap_read_rcu_copy(struct folio *folio, pgoff_t index,
+		size_t offset, size_t bytes, struct iov_iter *iter)
+{
+	struct page *page = folio_page(folio, index - folio->index);
+	size_t n = 0;
+
+	while (n < bytes) {
+		size_t len = min(bytes - n, PAGE_SIZE - offset);
+		size_t done;
+		void *kaddr;
+
+		kaddr = kmap_local_page(page);
+		done = _copy_to_iter(kaddr + offset, len, iter);
+		kunmap_local(kaddr);
+		n += done;
+		if (done < len)
+			break;
+		offset = 0;
+		page++;
+	}
+	return n;
+}
+
 /* Bytes one RCU read section copies at most: it holds up grace periods */
 #define FILEMAP_RCU_READ_MAX	SZ_512K
 
@@ -2944,10 +2995,9 @@ static bool filemap_read_rcu_batch(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 
 		bytes = min_t(loff_t, isize - pos, iov_iter_count(iter));
-		bytes = min3(bytes, budget, PAGE_SIZE - offset);
-		/* Not _nofault(): its usercopy check reads the folio's order */
-		n = copy_page_to_iter(folio_page(folio, index - folio->index),
-				      offset, bytes, iter);
+		bytes = filemap_read_rcu_size(&xas, folio, index, offset,
+					      min(bytes, budget));
+		n = filemap_read_rcu_copy(folio, index, offset, bytes, iter);
 		*copied += n;
 		iocb->ki_pos += n;
 		budget -= n;
-- 
2.54.0

