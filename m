Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425072;
	b=etyFesbGnrHcY1gsuKFfq8mqxZjBPiexhzzXTQAPms7/x7L6nDhbjtfpUwL+PsqF2/yn
	 LrzY8iBLRzTouB+IBzdfKrhCOtPv9/N/D4PMSV2MNDs4nO7k7KkE5+yDHfOBPVcd9eXQS
	 VDtjvXy/h7C4pnznNaE6E1km8dtw6AiUFS+ptH6EfGnRnAHPuM/7bEjaAFuOwKoP2jLdG
	 AAfKLoWHFyIcOMpxx4c129dNKhatO5daLxQuBiVaUEueEGSYWdDDKm0rfFZaC687SmsZ4
	 n04JSLF3s8EHk6RGUmuRehDz756TLf/mqZZfkowpqkuQbhGDyAFyiUHYMDqchO0eabw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425072;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nzf5AOZecE/pgMusAub/Smm2ReUG3xW+PWHZuYHUyt4=;
	b=Flo4SiMoTFTPLywsfy94Mpe48DXVovq+74hkOEA3xj6kntSK0bmM33OBYoU4eZrJrJTH
	 qhAm0iDi4+ah82UmWUBOxJRQFuVIJMNloKfg3vGPcZnwI9p+womKgeYrX2aLt4NFHjCG6
	 7IQ4K27fLMLqlphGQHwBydMWWS11yW2mOPXZMsbyB7yNAIogkNhpOeUX9tRzrCRrm2V8v
	 fMrxHX1LZUc1Vtx6IL2WY6/Lk5R49XqAthGYWmPO4C/fQY6JzhjWjWLFWEwUnCUe0fGoc
	 24QZrhUuTpxNhtR1bJBwZBDGphH9ctJDYjCgHoLQXXgSShQkCHbIfvWkwAAzvsWJy1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZXlHTq2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8AE60A6F7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZXlHTq2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BABB1F000C8;
	Mon, 19 Oct 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425071;
	bh=nzf5AOZecE/pgMusAub/Smm2ReUG3xW+PWHZuYHUyt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZXlHTq2D2mZP+Nt8654lG/kzhIjyY7ZCfBFjAVIqhdWVJk2cK/5EUKkTcBVPS8j/
	 6hc7IK0i3HJjXrtTi3PLROvIrFhP5tYmVNxxZSimnGNsyHVDZ7FxY3ji+aFC6fenue
	 aJz8vdzmiXCw84EJ2JB/1HQb/rZlIcvaPv+iwcVHqcL0gFg6khL3L2CUaz1chq+duM
	 xBkeU7bzjWTWh+0mG+xHeDqhuYkUvovZeUxYyrV5+I/9W1cVMF5EU8ykZDLPhEvNsh
	 nZsnctB851O3tispsQhWSTXwWsefeBEECXN+TpaxYLp87gzkBzbxARNK9G/QU294Pm
	 nRGmYuy29I35A==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9F85D198003A;
	Mon, 19 Oct 2026 11:51:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 11:51:07 -0400
X-ME-Sender: <xms:ZzzWagvnHzpi2QV3TgoGU420L-mLrWpe4ZeZ3YsBGoAYKAOlKwHuPA>
    <xme:ZzzWakaRmRX07FGWx-lFgXP_y55PfBey5tiqcPlbsYljwRnVNudZgeGeuMi9oI-MP
    l3nFIYQPYr3VDIZDhdI-wKfeNfkILHkWdqsvKtI1CvawJgwDAqx_xo>
X-ME-Received: <xmr:ZzzWag7bNo07-OVAYs9B8KdVDMf0PsYoWGshMCbKlaITt0nmYvXi_P-P5p4>
X-ME-Proxy-Cause: dmFkZTESqR4vElUNfwe4Wb1kabMg9MdYUtHyNIvlHi5jfGRsEd0tjiYfzpqh5FemuLlMuA
    +QzWL/iolJzzDzQk8vzuoT2/u2xyL/YZG/CihU2eaSQe3uAw7YKu/Z/hQfgMIJpEQrBQkK
    hH3KJVpCmjg+gNXnnOIkdBMKpJa1pvTLqzuojrt68Uovke10kpOzVhZrNEf3d58NDgoR+6
    GBwzdAiHoLFFDGJo3/r+XBHeUTBbw+IeFaYdgC0j5JEQlKAOMB5I7tBUfVMuw5hMfUnXf2
    vE1DwOk7N/x2FbtU++Y3QX/1ODQhD5sTVGp3EMvK4jUTItTZrn4RBPsK+PhnbeHfl8JcpJ
    c2LUHcVVlnTmrxA40olgviWRl9T+26cUEoz3aZJIdT1EfpFsU+0thKqzxFC9q6r9alkT7P
    UjijYajoIbQcUwCvES00HGkFx6tcOfQlzfxTtLaIAWuifAZVmXruOnjSB2KfmIGd1Tp9h8
    pT7XR7J6tU0+2PVC3G7YK2c6UKb8RdB87PPzk5qtMsP2YH1aNuaOcR9AoL/bstgEKQzsbg
    t6Ubf6j8Uiwe5o955Rjad4bmK7153G+aKl6kgw9QxprBMlsBHQpSij80iErZkMlHPp5FCS
    lHriB7oqc0/oTiW+ZSU9MPqkYvzaUVlCHKrJhXKPuBMUw+OJ0rG24eS8p+yg
X-ME-Proxy: <xmx:ZzzWanlnKjOnpqouLmcZBHTvvQZAhOmIx28gpgaFrGTPuBZ4WXkrpQ>
    <xmx:ZzzWagrX6Xgxxskve5xmxtyfDhrB1FnQjMlC3CRer3mcBjheEo2dGA>
    <xmx:ZzzWai_Fe8OhMS5ikxCMThpHx3RGb5NTGTJgIUNrfuKyzoKEY0ZniQ>
    <xmx:ZzzWap50Crsvkz0DJ5oSQ2M8pG2fFH-AZ9Ga4gWMwCxQvkjGLJdxxQ>
    <xmx:ZzzWasaRQDbFeEJeYYHn_EpIsUNRWZjO0GImBaEDkaeVCkMQ5avkpNes>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:51:02 -0400 (EDT)
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
Subject: [RFC PATCH 16/18] mm/shmem: count accesses to a folio the way filemap_read() does
Date: Mon, 19 Oct 2026 16:49:09 +0100
Message-ID: <20261019154913.1765974-17-kas@kernel.org>
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

shmem_file_read_iter() marks a folio accessed only when a read starts at
the beginning of the folio.  Small reads that start anywhere else never
count, so a folio that is read over and over at one offset ages as if it
were never read.

Count accesses with filemap_read_accessed(), as filemap_read() does: a
read marks the folio accessed unless it goes on in the folio that the
previous read through the file ended in.  Reading the same bytes again
through one open file counts once, as for other files, where it used to
count each time it started at the beginning of the folio.  The end of
the previous read is kept in f_ra.prev_pos, as for other files.

This also sets PG_rcu_free on the tmpfs folios that reads keep coming
back to.  On a shmem folio the PG_readahead bit is PG_reclaim, and shmem
does no readahead, so do not let that bit keep the flag off.  A write
marks a tmpfs folio accessed too, so a folio written in several pieces
can get the flag on its first read.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c  |  9 +++++----
 mm/internal.h |  1 +
 mm/shmem.c    | 11 ++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ace6b1fd6b9e..4b5b7ba78f39 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2778,8 +2778,10 @@ static void filemap_mark_hot(struct folio *folio)
 	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
 		return;
 	if (folio_test_rcu_free(folio) || !folio_test_uptodate(folio) ||
-	    folio_test_readahead(folio) || folio_test_dropbehind(folio) ||
-	    folio_test_unevictable(folio))
+	    folio_test_dropbehind(folio) || folio_test_unevictable(folio))
+		return;
+	/* shmem does no readahead: there the bit is PG_reclaim */
+	if (folio_test_readahead(folio) && !folio_test_swapbacked(folio))
 		return;
 	if (folio_test_set_rcu_free(folio))
 		return;
@@ -2802,8 +2804,7 @@ static void filemap_mark_hot(struct folio *folio)
  * LRU records, or when this open file goes back to data that it has just
  * read.
  */
-static void filemap_read_accessed(struct folio *folio, loff_t pos,
-				  loff_t last_pos)
+void filemap_read_accessed(struct folio *folio, loff_t pos, loff_t last_pos)
 {
 	bool hot;
 
diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..18391dc50418 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1248,6 +1248,7 @@ struct migration_target_control {
  */
 size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 			      struct folio *folio, loff_t fpos, size_t size);
+void filemap_read_accessed(struct folio *folio, loff_t pos, loff_t last_pos);
 
 static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 848316eaa7f4..43ddb50974a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3309,6 +3309,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
+	loff_t last_pos = file->f_ra.prev_pos;
 	pgoff_t index;
 	unsigned long offset;
 	int error = 0;
@@ -3378,11 +3379,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 					flush_dcache_page(page);
 			}
 
-			/*
-			 * Mark the folio accessed if we read the beginning.
-			 */
-			if (!offset)
-				folio_mark_accessed(folio);
+			filemap_read_accessed(folio, iocb->ki_pos, last_pos);
 			/*
 			 * Ok, we have the page, and it's up-to-date, so
 			 * now we can copy it to user space...
@@ -3410,6 +3407,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		retval += ret;
 		iocb->ki_pos += ret;
+		last_pos = iocb->ki_pos;
 
 		if (!iov_iter_count(to))
 			break;
@@ -3421,6 +3419,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 
 	file_accessed(file);
+	/* Readers sharing the file would bounce the line for nothing */
+	if (file->f_ra.prev_pos != last_pos)
+		file->f_ra.prev_pos = last_pos;
 	return retval ? retval : error;
 }
 
-- 
2.54.0

