Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797394;
	b=JDZ9GmZylU4qIRye/nfGOLQqg2OQ13a3eujjw7dR5TYzFJ+qODrCREQ0W4usP06wZNXT
	 xQmM4mtS1aW1IL+OMs6YR60hzp6BDGQT2f5G+XURV+K5OHd70P8Y52pJ8ALcPdD4wZieE
	 z7IMPKsPH+SBek/ZhYBP7H+0YwizW5jA0L+axs1kUIbrEPwCXco8zQ3HSINlhMVp3W+h9
	 8tGvcIxjnv0fEOmJ0gUNhrlwg8SjbOo+6GUPBSPEsB4O19EW/smA96WctIHCJGGgI95sE
	 0YtMqE/2rP1PcWYjBbHbsm2E4Lgipr6+JtshNy2hn/jI0up/wb1QA/2Lx6JAoNsUYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797394;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T6Io+8KMRKdZfFLT9BPvR1kCng9N5oVop+UTdq2d9CA=;
	b=JFTISwXbasIgSLS8TKOXX6YYhx3+IQVdvOWC3Cd4NiX02SFp1Wr0tMfE8PQ0cxHQoR11
	 ntjditGFMFTGtUTu7nC22OPM72p8lF660KQZjDbztNjimhHB5VXUU11LqeBsuyQnGqQD7
	 tKxM1WewXp+4LQ648v87LOVSdI4XAd6A6W4OXI174k9w7QH6MqHfN13vkMCWtRI0+PM7r
	 XzM6arBfYYGsvYXzYdcbv6pKuY98SFBQluwz1Jw9jYvqhQng/4BfCI47wzCOmJ7x7dweW
	 Wt6+IiTgpfIA83QKXT2xM37dpWPYSx2+jTWn9qhTlb3iHX0gNEZ0olBsp/dnRFJM54w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcp1cpCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDF606EEA8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcp1cpCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93161F00A15;
	Wed,  4 Nov 2026 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797393;
	bh=T6Io+8KMRKdZfFLT9BPvR1kCng9N5oVop+UTdq2d9CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcp1cpCtdyWWDNBLy7IFUDoKiBmWCfhnEoevfoKKd5FCk+5e+GyDqXGX8mYyLeCGL
	 O99cgOtk99NLsSZVKy0RxTo7No8qzSjBoA5o2a6zmbvImEqe0igoroKMRo4RGVinkK
	 9TQDiDatTbY8ZTKarBQFK8Ozl8x+h3BH91gG1aL214mjyFPuR3BN7CSoLV7nv2M4YL
	 OKrvtxER5Bizv4ozI2oUnMjh+XtIHgfYecEYfdGBBjfsGca+cZ87ajnYC9lO1U2c31
	 mMOSCUp+EIB5DJd5jGKCrdk4DKWHbRLTVB54sqQG4kCxMVhDbm+1mKCZZLXjDkq3SK
	 hBeb5o+L96h4A==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id BB07F1980058;
	Wed,  4 Nov 2026 08:03:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 08:03:09 -0500
X-ME-Sender: <xms:CS3rattHkCoQiFep-bB5gzpVapNr_fcSEsmtmDCdgdkZ6EawYap9iA>
    <xme:CS3rarttvp6o0E4bYxQj0zXixktP8TVOri7Kqo5eyLNQkq2t6W8NrmvCc-J7nqu43
    IkgnufDjfoHoWPsK7WohZ7fpi5gTzreWi_hKoBESzsd64833aftlw1c>
X-ME-Received: <xmr:CS3rajYKWyTDEwJPi2_WOMT581mPMw5US80erg5LHFT0hhemeNvPbfLFukA>
X-ME-Proxy-Cause: dmFkZTEvV2YAkGfM/7KQTdNUPKASUoKivbf8aK7reNbiRWx6UbSyYJoBiI1aLFQD0JmJIL
    suuLzf8FPF5XXOxsI4n3uatEJISIq8lfLQzWs4ZXVY70I4vMqmzsMJ7lGJ46GbcAPXP+27
    nbqWstaujK1I6YUZb9z+ZqV1uLZr3rGJG+0r4w/gGbN8dNbDx0uz9q+Ln5gHW/zJfXd0Mx
    LucPAfkwgcRoeIu9xH9pdJvf2Akov2r7sS+tvQQtk9VR5hmZMO56kjZiFGarxbHYybrUXu
    m8XGCL1PIBUAW4CkGGSJ7es6S7rupClQfiIG4ieqXTbHyX1rEMGh3ihwL/bhr1XVL0tAmZ
    JSSwADdVM0zOM680rMMzpcwnkR7i6sXqNVT8pP/kSrFp/QUJposbYhRg6EweZH2u9za8zV
    /QvxHBLDuwQBgrSh4KtcjxDU/shF+aHeNsgIoYEtTdy1I9qGVm/AwiI65KkzrmE/ejcfdi
    Kte3e1f7WB7dCZOWkQHckvXXr0x+BjnF05Dm3HudpBr//PxPuT/vRKwpPdC4/ELI1mny2P
    BIpwqKAmpEAiZTN6mvMLKEewys2S83UXacplDVrqPXe444P9hB8kwo4mRMUFd50OAzA5F2
    Ma2vivh4juI9U/JJDS5U/kKqbPQhGubXz5qMEaJeOc+EdWIq2ZcHPOWDADrg
X-ME-Proxy: <xmx:CS3raj75fkVPiLY1uys-NJmZkDd1Q_dZpd6zrXqV-aR0h6Ah_CjmiA>
    <xmx:CS3raulhPuk-GPnjPLsNqaMc5OP0H7Pn-8VLZ05NoRQF7FWYANKkIA>
    <xmx:CS3raroYrPFivpnC-vgKrnNo4Rb95GA6KSuQPkX3LpTUdbiaYYwPnQ>
    <xmx:CS3rah_ddeN0rYex3UTW0knhNHKDTiyiTCwP100Xi7SH81CF5KeU3A>
    <xmx:CS3ras5FSDv1i5lts89nrpkq72Dprt3l4OSdayrPYLzAJtYRhCknF8nx>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:03:04 -0500 (EST)
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
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
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
	kernel-team@meta.com
Subject: [RFC PATCH v2 17/18] mm/shmem: read without folio references
Date: Wed,  4 Nov 2026 13:01:13 +0000
Message-ID: <20261104130118.2507513-18-kas@kernel.org>
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

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c  |  7 ++++---
 mm/internal.h |  2 ++
 mm/shmem.c    | 11 +++++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 65d414ad9d85..e148490db4da 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2831,9 +2831,10 @@ static void filemap_end_dropbehind_read(struct folio *folio)
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
 	/* A split clears PG_head before it puts the new folios in their slots */
 	if (!folio_test_large(folio) && folio->index != index)
@@ -3020,7 +3021,7 @@ static bool filemap_read_rcu_batch(struct kiocb *iocb, struct iov_iter *iter,
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
index 1c700fa9666d..8700b03a8a5e 100644
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
 	file->f_ra.prev_pos = last_pos;
 	return retval ? retval : error;
-- 
2.54.0

