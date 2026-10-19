Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425059;
	b=arvN3Ibybs2S8fHl3vsqGYZPWF4G9oWu+jGMfFStWHu9dTKwJkQOSQZn9GZEsPpwS2Nr
	 k8vGGnDENNuC5KOUOKl7Yt2kyMlrPrA+T8oujBOBHTqdcqBzRUEmN36zT/gBUGuZY8yQx
	 PM9Hx+hzvyhXp18LSrOGohJXkkFWVhdaFGR8vgzet0ABdJIz3BCBaZm1HwPdb1GSfKve7
	 EiaDoOeMJTmMy4BcAQua4bErnqOO4RaRnna+0VtCIDrujjdqARMGeNqIA9z0w9NtZxudK
	 dLz0XrofOexqbV2kKYkkPmnZtAI1XV+kVBUJ2QqDZZ5Z1AuhVfhBYjLVpdqW4JqUSbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425059;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aHFgwB1QQdeguUBHh1LZeUKmP2EVveCA6ywncN+4824=;
	b=Sk/VzCdv+3aw5R3k3/73PBwCnUtZy+PDR7pHDj8Ce+o7dGVkKDBrSeVaN2U5pAv8rr3r
	 BEgqmpBj0kFnySnSlYXki9DlSY2kLua7yuq7SWUA73CRp9ERTY8ikNjfX9E0iPFnX+8h5
	 TvImJ99XSQF+mSoGyXhZcEH8Sf8XMHItdtiJxcS3Dd8Tw1IgSaoR6weoFYVoud9J+md0B
	 9D94I5Kag3VwrKoieLvVhzMWwKJKb5OdAB/ZYMYn4k2AA1h7SfsIDHQ7ILYo5LQMrYs+Q
	 XCKWxWShPZpnvnnmlGRKetCoiHgaWWAjLxfRLjYiCmyDRBkUuBqKpsql8XMquaIzn/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp4vxbWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE48606AAE8;
	Mon, 19 Oct 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp4vxbWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2211F000C5;
	Mon, 19 Oct 2026 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425059;
	bh=aHFgwB1QQdeguUBHh1LZeUKmP2EVveCA6ywncN+4824=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jp4vxbWn/yUn9LtCGVPYeakTPX4tsFvUU8YEjhzMI69M/pjH6/p8DSxtcx1C4St4U
	 RXbBFZuCtQB4RFNmOQZsv0T73MCepho+ltYc6dNsTSFubutrPYmOtMw93qvE6HNQ0q
	 ZQpcKYr7r0OTsf46NJoCBJEbReflGrlaQaGiI0pVPQApA3LIDyFISlFYY07coARWX9
	 8XEXEh/T3YNljIgALCohedAoA6sFnRZc3GDGTGXdBXqFh0MmScqYgA/dbCx8Hq/7np
	 1KUPsn7FfTMikCHOF+xskyIhBmuuw89MOgRDsUHBJFLB0r7TY75tTL2/PqNKq6iFNk
	 fzQtVF/R7DBqQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9D590198003A;
	Mon, 19 Oct 2026 11:50:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 11:50:53 -0400
X-ME-Sender: <xms:WTzWankDtQBpbX8-A7KeHpUkJjxA23ulY2hVup8-Qb1LuawvvpvDOw>
    <xme:WTzWagFEmsa7ABjv5spb4NJ4aLEvtMHnJrl6zn9-JUUj1AhTJeu4K-CVWTEI6NctE
    f3N-Rt5Z6KotvmEcPzJtcu9xtRJPKan50NVFzOpFUKwgcat-nG8PNkt>
X-ME-Received: <xmr:WTzWagQqANz65r9kGtUpU6Yt2nXXnsNcnUxFtQRBDwO4obnWVffcojBgET0>
X-ME-Proxy-Cause: dmFkZTEPqwHCv5IVDOfp+gppQpoSvl4iKuiR2RK5Y+mCZyyWO88dcIgYD60QXY0H8fSG9y
    +i/Fi66FpUhP2Ikf7ONks1QGsKRJt/NoxWDxl5HXxNylv75I6mtGV03osn/+lvccKEBd4W
    KnTaLXmzxvblXRRW+RSShg/hHxynElJxqWehmOFUYq4U1x7ifoitgX+ne3vp8F3h8AQ/N0
    /m2r4CY1m8XbTmLiUOTFaC6q0oQJ3XXcpirfEfr7IPSxVFCOUTfbQW2d5jjoyFzJhvq7h+
    uIBkQwMZCXw2y5U40pZhX7XPPqGR7Z3fiyae5UDORfmXvndjR9BDrzyAINzfPzRUg9LHlX
    k0IkKTk9iNht3cIGRTIZ2lUZssI02DI2+r4CLzf9ALJvkCYS2731J2VpdbOY6W6ssdpZaq
    q61aKe5jdOQRiHmCzGbTuNUnnXQMa1s1MYT7kWNp2XXUjLgPn0z5+PtISNXTEW1SsTC/56
    +/AywSZLo+AmKJldqc/DJBr3AuzCUlzce5s0eOrs/wPTX9AWPQRJ2MMmZjPzhLopP1eoxw
    0j3F+Ye0cf+APkDpVznsTTVhYZQ/Y+ausVHhYcDlznuhBSu6aojjhGD6qDJ/85Df8I+5JH
    JS6uR59Nu8GhniM7xqxNRP1zUGEDjgGFmqzlorj6gQzkBYvu0Z9eOmDJZvKw
X-ME-Proxy: <xmx:WTzWavSXSMe8mjKSzEv9M4YKuLHRTpBFS2_rZQEn9KcEbkpE86Z-qg>
    <xmx:WTzWamd5dnT_wLS9RyyG-aJ8l_6aCHDceWsgY9CBv4X1i-uzXVTmXw>
    <xmx:WTzWamBN0Ym3A7UqT0MT-OzVeZYdxtAF_PNglcqQceTWkA7aoY637A>
    <xmx:WTzWas1ropU3sQtK5b2EIVmByal3_RmrXIW-sCzaLxFIM3sDKoUD1g>
    <xmx:WTzWauRZ2YzWDO3s7IXVJyAWhpnG6gU3u4bnavYuv9vCkdlKPAhC1ASH>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:48 -0400 (EDT)
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
Cc: Miklos Szeredi <miklos@szeredi.hu>,
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
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC PATCH 14/18] mm/filemap: read from the page cache without folio references
Date: Mon, 19 Oct 2026 16:49:07 +0100
Message-ID: <20261019154913.1765974-15-kas@kernel.org>
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
for all of its pages.  Copy at most 512 KiB per rcu_read_lock()
section, and skip files that never had a folio flagged or that are
writably mapped where flush_dcache_folio() is needed.

Assisted-by: LLM
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: i_size before the second look at the slot, poisoned folio check,
 large folios left to the slow path, 512 KiB sections, shorter comments
 and changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 960d53b61d4b..55fc471c0489 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2827,6 +2827,165 @@ static void filemap_end_dropbehind_read(struct folio *folio)
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
+	/* memory_failure() waits only for readers that got past this */
+	if (folio_contain_hwpoisoned_page(folio))
+		return false;
+	/* One reference covers all of a large folio's pages */
+	if (folio_test_large(folio))
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
@@ -2852,6 +3011,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	bool writably_mapped;
 	loff_t isize, end_offset;
 	loff_t last_pos = ra->prev_pos;
+	size_t fast_read;
 
 	if (unlikely(iocb->ki_pos < 0))
 		return -EINVAL;
@@ -2863,6 +3023,14 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
 	folio_batch_init(&fbatch);
 
+	fast_read = filemap_read_rcu(iocb, iter, last_pos);
+	if (fast_read) {
+		already_read += fast_read;
+		last_pos = iocb->ki_pos;
+		if (!iov_iter_count(iter))
+			goto out;
+	}
+
 	do {
 		cond_resched();
 
@@ -2940,6 +3108,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
+out:
 	file_accessed(filp);
 	/* Readers sharing the file would bounce the line for nothing */
 	if (ra->prev_pos != last_pos)
-- 
2.54.0

