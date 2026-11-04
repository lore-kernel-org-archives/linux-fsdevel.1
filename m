Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797370;
	b=RNXsVWGKk6Y1bqSXmWZiM85pqTOASO+4uuP7mD02yGJsMFSSta5mFLUmeV7yBslVcrYK
	 e9HXtd7nTD4OOwucz+Jo16QrF3BoU3sa955c1Zd+24UJvDF1BT2Z2aRE19DaKy9XjGAqT
	 Xc+RhRy1eR5EMCPLjWcP6xPdXLKsq2LcrUhE1Eseq8Wh/ClwlGMlEYbdg9Z6QHmQ46ezU
	 MCzOiwKWvdG3ghluICDpIyps1N2UKsoEC2GmRC1eBCmQEpG1AGzKdOKuqJXHhy+sbNOIO
	 BLh7B2uh7yogwhVW12klJpY3wTGUQQT//N40o/uS4KethPsAw4fep5ST8AGszxhU9jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797370;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XGUet/nX42bSwKZ2KUnEC+LBbDrNBhAuR79ZtGWgPZ8=;
	b=1zl88w0RxKT9OSaGCZxZrgYF8bk2F+yAZfjcepw/r6vlZRlI29ZVSPS89wRl8Zk0mDWv
	 gin/rWfsgujnmxKl85R7/xrvA8kMJKsDYfYsWQ36faECl2gm7iLB2xgc7H2sPqjFTlYEb
	 2koHnRyONC25//BPIeEs79juPYckTLFpgCEDnwCwzsAPUXtQTrLAenFM1H3E3Pq1mXMzt
	 zMy4+nsAas8T7bZiaADc3wI2hDEILk5CX7jIuUY3bAXYsTnt1vf4kGOCuta08mxC2BadL
	 l43sfKANxJrDf1+gyqLPuYxeJIJosseGkVMn+31Md2JD51ALYf/sKUeLRyjCYjjkJ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTyF6sJh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB563606D82A;
	Wed,  4 Nov 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTyF6sJh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF71F00A23;
	Wed,  4 Nov 2026 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797369;
	bh=XGUet/nX42bSwKZ2KUnEC+LBbDrNBhAuR79ZtGWgPZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTyF6sJhyMGVnZa/UWJodxB/dDMmwuunKXCbuD/suEE9A/vq5suIGbIdo8yHO7El5
	 fyk4bM2O+6u6g/6dld+JarguhE+EZ2Wf/uRiWTbwl+NhERMMvGriPF1sEZ6XitxZZi
	 fa2WrTocGRDQ/fGK5irXh61jn8i8NXJSCbbkWvpwIRMCphfHf4pxJhmktKKTjn868d
	 SF1ENHGukPb2+KHgsP41bCXnjVqZVv3UKJym8wt58+WtriNI5n454a1Qd5XMs8jdWO
	 q4FuBXcpuY309a55x9ZqGz8LiVmGfDV1Fv28jR3nLW2G7TeeiG3JzrKxH2021jN/u6
	 fahSZm5ikZpOw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9577D1980054;
	Wed,  4 Nov 2026 08:02:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 04 Nov 2026 08:02:45 -0500
X-ME-Sender: <xms:8SzrapKIhd-cwbaN6so_lThcYd7PjY5k5sSOR2TysUrY3PEARg4ElA>
    <xme:8SzraqZlA164U-tMpWxTKFChyZK-Sa_RO0Fl_F4DMDHi6bBYs5sC0G8ynASLFVu7T
    hP5XH0wkD720QbBY2mNNtZJF0QtSl7M6PacJgQ4L7K54mnVCqJNRLaM>
X-ME-Received: <xmr:8SzrakW7GeKiXcNXnhBZ9-HKUi_JAo54d7O0BgZ_0xLanfhqXYMdIHvMly0>
X-ME-Proxy-Cause: dmFkZTEk66d9wDCrVwGV2KJIuy/ruy5O0lHCepBxGNrlOaBp07skOmfpvndHRI5OELNSRA
    yGn0MCxfDBFvgtyU/Ak4d/WAic24VoVtjIR75/P/ngQIuraqmEs9ZkAXJhPO2VIG+d1IXF
    8IM0H4JyLf1Zvo7c0MMOZUL01NImbyo67v4VfXk76TAaVongE51xEXOR6TwNiSJMyPmHzO
    yvy//RxDs7szi5OqCFXsHX0nUmlJzvH+fYd32en08T2wupH37oWBqHCmwt7iQGlRXBtll9
    wmwpz0VKkZxr490s373q3pKsnGNjbIq7dF2jWYGBMXYWabdlQXgHC7ofo/k0KNKzla0CUC
    U6wwdcotS31awyT+o/wr6p9VDSEpn0ZpF4pwW9xlQyOh7TDLHcL5cKPyqnRe9rgU0FWYaH
    T8Z8lVHEiaZ4l1qriH7SJHJgb27kPF/nXHy0GHvJXUbT6t2R/tLSL5EMTO1BVfk5vt9L+n
    5f3C9aBDjNQLjGpTszqMtmEYobi47ZD43JIXzlz4PesRU7jhLrKbUeNmAZQ4l+tyA723I3
    xADPtB+fOkSQdO58lgyn/vMWGsk5tl5QxEJGV0KPdKQFEZ6k9PdKnQ+ClBkQF0D8m+TIYy
    1t/mRoZCZabukbXq0clcILi20Nep6CsJ1Ogs7uOABQFSxHKH/zHQSm8VZkZw
X-ME-Proxy: <xmx:8SzraqHWl55Rjxbvja8vOkfQysEq15RiYTJpCl4TVXHvPmDc48JU5Q>
    <xmx:8SzrahCX_yDMRZR8mQa_huksDJdjIFF3B542plDCXnKPlx_SleDt7w>
    <xmx:8SzralXEpBbya0F58yOB4C-j_AmD2gzAatB37XVoaLS_d2F-8eYT2g>
    <xmx:8Szrah4waKjWbrxU07uQeD_CS0kTL1Zl4tLQ9hwKZNs6coWVENeXmQ>
    <xmx:8SzramG2GnIP9aTpvj31XvphF5ZCNsfa_SGXxsqHkfBs0-Fe-7f1Ftsd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:40 -0500 (EST)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Harry Yoo <harry@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC PATCH v2 13/18] mm/filemap: read from the page cache without folio references
Date: Wed,  4 Nov 2026 13:01:09 +0000
Message-ID: <20261104130118.2507513-14-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104130118.2507513-1-kas@kernel.org>
References: <20261104130118.2507513-1-kas@kernel.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Small reads of one file from many CPUs all take and drop a reference on
the same folio, and its refcount bounces between the CPUs.

Before taking a reference, copy what can be copied under rcu_read_lock()
from folios with PG_rcu_free, with page faults disabled.  A flagged
folio is not reused before rcu_read_unlock(), so a folio still in its
slot after the flag test is this file's page until then.  A folio that
leaves the page cache during the copy reads as the file did when it
left.  Read i_size between the flag and the second look at the slot: a
write that extends the file fills the slot before it moves i_size.

Leave to the slow path a folio that is not uptodate, needs readahead or
dropbehind, is not hot, or has a poisoned page.  Leave large folios
there too: looking one up for every page is slower than one reference
for all of its pages.  A split clears PG_head before the new folios
replace the old one in their slots, so copy an order-0 folio only at its
own index.  Copy at most 512 KiB per rcu_read_lock() section, and skip
files that never had a folio flagged or that are writably mapped where
flush_dcache_folio() is needed.

Declare the folio batch in the loop: with stack auto-initialisation,
the compiler zeroes it where it is declared, and the copy without
references does not use it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: i_size before the second look at the slot, poisoned folio check,
 large folios left to the slow path, 512 KiB sections, folio batch in
 the loop, shorter comments and changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b732ecaa78a9..e99705a66c1d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2821,6 +2821,168 @@ static void filemap_end_dropbehind_read(struct folio *folio)
 	}
 }
 
+/*
+ * Whether filemap_read_rcu_batch() can copy from @folio, or has to leave it
+ * to the slow path, which holds a reference for readahead, dropbehind and
+ * folio_mark_accessed(), and deals with poisoned pages.  @last_index is the
+ * page the previous copy ended in.
+ */
+static bool filemap_read_rcu_can_copy(struct folio *folio, pgoff_t index,
+				      pgoff_t last_index)
+{
+	if (!folio_test_uptodate(folio))
+		return false;
+	if (folio_test_readahead(folio) || folio_test_dropbehind(folio))
+		return false;
+	/* One reference covers all of a large folio's pages */
+	if (folio_test_large(folio))
+		return false;
+	/* A split clears PG_head before it puts the new folios in their slots */
+	if (folio->index != index)
+		return false;
+	/* memory_failure() waits only for readers that got past this */
+	if (folio_test_hwpoison(folio))
+		return false;
+
+	/*
+	 * The slow path does not call folio_mark_accessed() on the folio that
+	 * the previous read ended in, so copying from it skips nothing.  The
+	 * folio's size can change without a reference: compare pages instead.
+	 */
+	if (index == last_index)
+		return true;
+
+	/* Otherwise only if folio_mark_accessed() would leave it as it is */
+	if (lru_gen_enabled()) {
+		unsigned long all = LRU_REFS_FLAGS | BIT(PG_workingset);
+
+		return folio_test_unevictable(folio) ||
+		       (READ_ONCE(folio->flags.f) & all) == all;
+	}
+	return folio_test_referenced(folio) && !folio_test_idle(folio) &&
+	       (folio_test_active(folio) || folio_test_unevictable(folio));
+}
+
+/*
+ * Return the folio at @pos if it is this file's page until rcu_read_unlock(),
+ * and read i_size into @isize.  A folio with PG_rcu_free is freed only after
+ * an RCU grace period.  Without a reference, the folio that xas_load()
+ * returned can be freed and its memory reused as another folio before the
+ * flag is tested, so look at the slot again after the flag.
+ */
+static struct folio *filemap_read_rcu_lookup(struct xa_state *xas,
+		struct inode *inode, loff_t pos, loff_t *isize)
+{
+	struct folio *folio;
+
+	xas_set(xas, pos >> PAGE_SHIFT);
+	folio = xas_load(xas);
+	if (xas_retry(xas, folio) || !folio || xa_is_value(folio))
+		return NULL;
+
+	/* Not folio_test_rcu_free(): it may not be a folio any more */
+	if (!(READ_ONCE(folio->flags.f) & __PG_RCU_FREE))
+		return NULL;
+	/* Read i_size and slot after the flag: it implies uptodate */
+	smp_rmb();
+	*isize = i_size_read(inode);
+	if (pos >= *isize)
+		return NULL;
+	/* i_size_read() is an acquire; a write fills the slot first */
+	if (xas_reload(xas) != folio)
+		return NULL;
+	/* Read the rest of the folio only once the slot holds it */
+	smp_rmb();
+	return folio;
+}
+
+/* Bytes one RCU read section copies at most: it holds up grace periods */
+#define FILEMAP_RCU_READ_MAX	SZ_512K
+
+/*
+ * Copy from folios with PG_rcu_free without taking references, at most
+ * FILEMAP_RCU_READ_MAX bytes under one rcu_read_lock().  Return true if that
+ * much was copied and the read is not done.  *last_index is the page the
+ * previous copy ended in, set as the slow path sets last_pos.
+ */
+static bool filemap_read_rcu_batch(struct kiocb *iocb, struct iov_iter *iter,
+		pgoff_t *last_index, size_t *copied)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct inode *inode = mapping->host;
+	XA_STATE(xas, &mapping->i_pages, 0);
+	size_t budget = FILEMAP_RCU_READ_MAX;
+	bool more = false;
+
+	/* flush_dcache_folio() is not known to be safe without a reference */
+	if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE &&
+	    mapping_writably_mapped(mapping))
+		return false;
+
+	/* A user fault cannot sleep in the RCU read section: it ends the copy */
+	rcu_read_lock();
+	pagefault_disable();
+	while (iov_iter_count(iter)) {
+		loff_t pos = iocb->ki_pos;
+		pgoff_t index = pos >> PAGE_SHIFT;
+		size_t offset = offset_in_page(pos);
+		struct folio *folio;
+		size_t bytes, n;
+		loff_t isize;
+
+		if (!budget) {
+			more = true;
+			break;
+		}
+		folio = filemap_read_rcu_lookup(&xas, inode, pos, &isize);
+		if (!folio)
+			break;
+		if (!filemap_read_rcu_can_copy(folio, index, *last_index))
+			break;
+
+		bytes = min_t(loff_t, isize - pos, iov_iter_count(iter));
+		bytes = min3(bytes, budget, PAGE_SIZE - offset);
+		/* Not _nofault(): its usercopy check reads the folio's order */
+		n = copy_page_to_iter(folio_page(folio, index - folio->index),
+				      offset, bytes, iter);
+		*copied += n;
+		iocb->ki_pos += n;
+		budget -= n;
+		if (n)
+			*last_index = (pos + n - 1) >> PAGE_SHIFT;
+		if (n < bytes)
+			break;
+	}
+	pagefault_enable();
+	rcu_read_unlock();
+
+	return more;
+}
+
+/*
+ * Copy from the page cache without folio references, in batches, and
+ * return how much was copied.  The slow path reads the rest.
+ */
+static size_t filemap_read_rcu(struct kiocb *iocb, struct iov_iter *iter,
+		loff_t last_pos)
+{
+	/* The page the previous read ended in; ULONG_MAX if none */
+	pgoff_t last_index = (last_pos - 1) >> PAGE_SHIFT;
+	size_t copied = 0;
+
+	/* Not on an inode that never had a folio flagged */
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE) ||
+	    !mapping_rcu_read(iocb->ki_filp->f_mapping))
+		return 0;
+
+	while (filemap_read_rcu_batch(iocb, iter, &last_index, &copied)) {
+		if (fatal_signal_pending(current))
+			break;
+		cond_resched();
+	}
+	return copied;
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2841,11 +3003,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct folio_batch fbatch;
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
 	loff_t last_pos = ra->prev_pos;
+	size_t fast_read;
 
 	if (unlikely(iocb->ki_pos < 0))
 		return -EINVAL;
@@ -2855,9 +3017,19 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		return 0;
 
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
-	folio_batch_init(&fbatch);
+
+	fast_read = filemap_read_rcu(iocb, iter, last_pos);
+	if (fast_read) {
+		already_read += fast_read;
+		last_pos = iocb->ki_pos;
+		if (!iov_iter_count(iter))
+			goto out;
+	}
 
 	do {
+		struct folio_batch fbatch;
+
+		folio_batch_init(&fbatch);
 		cond_resched();
 
 		/*
@@ -2931,9 +3103,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			filemap_end_dropbehind_read(folio);
 			folio_put(folio);
 		}
-		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
+out:
 	file_accessed(filp);
 	ra->prev_pos = last_pos;
 	return already_read ? already_read : error;
-- 
2.54.0

