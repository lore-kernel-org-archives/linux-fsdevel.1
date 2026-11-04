Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797388;
	b=RUmwKhBhapTTYrW/hGXJ05ZWTzRvvIOspAE+iAPonNWdrXj80+JmSAC40QYbb2qs2cC4
	 ct2+0thIYla6H71XykLyWhDmsRZ8QYd4TjGBSeIkxnI0ZBZvUCFpc4aLmskowt2vLwz+H
	 QFhDuQON5XvPKxyDs/otopNU6oQ1+9WGrJt+/B8zOnnnGEo2mRruZsZODQXwYrpKm8ojH
	 N4+LyTATf5WvnMxbBRm7HDkrNFotiH+bAjD7NH95p+6aFqO8dR4jl6MRweO/r02uEKPFb
	 3CwNLRzN+TpR8XLXMJLAJXcH0PP2UYRA80IK2LGK7hhErxhCkmQTlQQSu0tz7V+J/Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797388;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LyJ5LhydnHWMWHiwLye8xdx6/6doxNo3rjssOxw/XEA=;
	b=4b54HWBJ4ZN7scEbHc26Qo4ZAe4E5V2wjEO/DthFgHVniSpySAsNTBsP3qFIObhGEpBb
	 6AES4D/0NVet+/r1UpeJYx0J18n5eqshtdJc3TRqHMUxQz+qsMC1obWhcLrQhXTq9uWzS
	 /AU94d/Kb2RryvFcERydLzQ6K5bCopsIYFgw5poCqlAM0W3NU+H287L3eWcGIlCmrNFKF
	 TbOkfzF1/IQN3kvrSYQFsjCh/vqZRZQV7vYtMDHKVmwrsh7OdT7eXhZfb9yQpACwxkC2t
	 M/jHMl7gRS7BaumhakkZxSfrjAgZ7/3CCewHQuMmJsYUAmUxu+Eclln7VuTWuDhCYgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLbBmCrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE2606EE98;
	Wed,  4 Nov 2026 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLbBmCrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0111F00A02;
	Wed,  4 Nov 2026 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797387;
	bh=LyJ5LhydnHWMWHiwLye8xdx6/6doxNo3rjssOxw/XEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLbBmCrtUa60xuCrBC8BAWP/XK96WIAWbFKNGpsqirSqKkQUrQWxXrvksO2J16c+/
	 0WKIE4wdeJ1xe2E59FE47afAqMbxqXhya+lnTkkPHCfH3heH1TDb81UrG7pkc0evE4
	 wh1nYcwXRvgx0Y+1HI9FMp4QWkcEJoRTNan6hC27YLnHoSbkB1wmCVnvNXim9pVz+B
	 qFcR9T7DTvB/kYyKng78VXIipAci6WWVCjTZsnouWFHUTBHrkbtU8AKToK3FfCdW4X
	 /zWDp1c5UWNSftYVLo7Omq0nTpMreSHRZkSBWpgB6qehF/TfjSDntxnrgN77BZumCV
	 MJfM0VrkjoqiQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id B995C1980052;
	Wed,  4 Nov 2026 08:02:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 08:03:03 -0500
X-ME-Sender: <xms:Ay3ranYgkY_XrLO06Rt2zxbZ81RQuV72zKk2jsGLwvKhRYruiA7gqA>
    <xme:Ay3ratUlCel_qAS_Di9AObYS-U98a6yBO_z3Ge9POWcq9SjHtX5KDbuAF5p4ffJ9M
    4ezofs2lBMvbMMYjPRjfNhNrIFCC3FQpO6q4qAEgH-S1oEMX6jwB1I>
X-ME-Received: <xmr:Ay3ravGVBcnfEuNF7sjgeA-O-pMSZkjMK3jxL6T178epMdym2fDxWgR631E>
X-ME-Proxy-Cause: dmFkZTEkTGQme7AYtjF3GuVS96P2KQmK7WXeTlUb1QwwiuzIvAmashPSlbgOXzJn8Vwnwy
    GtuimX8GVaozomoo/zh+dZJa/50iMsle5DQ+rz1xv6q7s8h1ROZ32xDIMTiguWiavpmC2D
    BBwjWvlIRSWZcXI9bWu6+sLs7omuy7lLW9/gOc6hVkazqru7j3LnWdj5tmV/csyW0bsTmS
    EsxaoHyCeNrVLjcn3op2UYLn5kjIXtndJ2M5CWyKjF23KtNnUBacMFKYutyyEO2UkxXzYe
    RLi75JY7cBimTx0NOw8ItiGvjmUs48xoopmJA34QoNHmlECPZN6WTQStnLRujBuoPTyyqY
    WNZVZSQNCEd6xp+B5OcigglVi/M4vyTQAOp8DAvxQ6AAu7fsihetgvFDtIIDS5ObEaNW2s
    U6wxXPW0s9rD0+XTraAtlBvBIpvjMETR3urx6nwBgBwLzX9c7PCB1JeSjKkqKBzMFpyxyp
    D31IEO9Hn2FTO+eQ+QIw9D38MApBAMgD+do7ngt4xMfXhbY3T7wqbAu65VS2ZUtSfwfYKq
    kWXnicU5R9b31F5IhRxjhTGPQM0+wpZm3zSfBP56ZMPQV3QGtEnX2jeAKyTTDvPWG5w/wq
    qPiCgH8vCH8FQifqh4DXfGoRyFm0vh6aooGv+EocCSZF8jDUXaZH8fzYqqyg
X-ME-Proxy: <xmx:Ay3raiDsW4mhWHofLCiwXi87nnuRdmiG3xcWyAVOKXg42RDrH7lqPw>
    <xmx:Ay3raiVcIcXJxXU8-ZuS5ACNt_e8L9f_7DVbEjG0ZnHYyEhlRpb7JQ>
    <xmx:Ay3raq6zmTd4ddo3YhxVWmKr3TywONNuMCsLdbUiGR4WYOe9vrCMog>
    <xmx:Ay3rarEaIw-IXBTza2AXmYn9SNvhb9NqvxYARyWegRJcmKQOBwx5Wg>
    <xmx:Ay3rat1ZeL1JZQXP0cbJEvUpHP-6iXUb5N58dA-wUg2uhNELNoOnhxi8>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:58 -0500 (EST)
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
Subject: [RFC PATCH v2 16/18] mm/shmem: count accesses to a folio the way filemap_read() does
Date: Wed,  4 Nov 2026 13:01:12 +0000
Message-ID: <20261104130118.2507513-17-kas@kernel.org>
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

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c  | 9 +++++----
 mm/internal.h | 1 +
 mm/shmem.c    | 9 ++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5998de3d6697..65d414ad9d85 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2772,8 +2772,10 @@ static void filemap_mark_hot(struct folio *folio)
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
@@ -2796,8 +2798,7 @@ static void filemap_mark_hot(struct folio *folio)
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
index 848316eaa7f4..1c700fa9666d 100644
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
@@ -3421,6 +3419,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 
 	file_accessed(file);
+	file->f_ra.prev_pos = last_pos;
 	return retval ? retval : error;
 }
 
-- 
2.54.0

