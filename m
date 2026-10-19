Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425037;
	b=kp0mvP6KjQsU6i62XxZaGnUc38s92BDaTCJCE+KLR7imZbxXnRgCPOgWx8gaqkPovLiK
	 oYeMxNrPCedxNdc5oAT9C4nfAm2dcV3bfXOZ9/MXjOVNPqy8VY/jgxoyXQxmgKkuJjynH
	 GTIkdySfdkQFzAlq8vqZOj9g2P7P69UdEIX5UFHrEOX8B5Ps0cr8WnB+N/IbiWJnHFzNF
	 URc5T9dQqxoPMjz3sZB2PpF8VZq3BaUlVX04F36cAQB2djkQ1DPrzRa9FwbMrHPTPvr3r
	 9jWlSBA2sl6X92jwfOF5uWnEJaAxPuRaJIqBe63pm/26MaYGu1zjo6IUWlABByvZE6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425037;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UMGOxPNVHDCZHjJ/y4wrnwe474JMBsZe9H8zYo9bB5E=;
	b=39C1qY4VrCfex9krgdlUlz2MR69bv2VaPNB5IUQnBt9q2YU7waNks2CVYqOOItz9okTx
	 tWL83Oy/JifJuX45z9iwTXqJ6hdGOOm118pewLR0MtIQsH9755tE+LQB69lKMolHGkvSu
	 QfRXjC/SvgD33D0CuHTSnN6X8dSIkAnpqemcMK/J5V2wCZZJTbeYGhS9waHtlIkuAqvM6
	 +c7dxjAqSMYJA6azCgto/FLNEE6nsErC2w68PsXwN2j5mUXvbH1R8+u7gj0b9DKT8thOP
	 VZIILzNR4GQskl+YDksSrxrrKz+nB+ll8pHBa3xVT+1Gh7uXCiampsjh9eiN8HTLP1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hufKA1g9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8D607F489
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hufKA1g9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473581F000C4;
	Mon, 19 Oct 2026 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425037;
	bh=UMGOxPNVHDCZHjJ/y4wrnwe474JMBsZe9H8zYo9bB5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hufKA1g97EKvBWIP9U+sEXfnsKRj7lxnGOyTt0Xt9hgyR0V/Mo7z+NOxdKx48r8m9
	 MNQ/yZ1HcpdUeTq9MIKjHEdIslhkAz3yFFhBTd0ugIp2k2DOMSEuYWn65uKrt4wOnR
	 TqwnI28qJcjbNinfyPf/xYD0CZWzOOlBBQXNNG1X3wYJBe+iLOIVyQ7NzKnrTmlYtW
	 FVTV3v1cnRYTbh5b07M4qVHylGvjzfLatA/9myYFGp7lglyFfQbAvsuKDUyoEAowM/
	 AHC9dV1vRe3/zxbp9roLIYqQwb9nvw7h2mXB4BybUJDZcC8wVYDtVy68jkB7m9B3l3
	 IHaQqq+gIntfA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 486601980047;
	Mon, 19 Oct 2026 11:50:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 11:50:34 -0400
X-ME-Sender: <xms:RTzWarrRMrVUJFi54EKx0DCmuyXlEG2ELefD-0EKzI8czGQ9GWmoVA>
    <xme:RTzWasm31JalJVkj10loaHy77uZH3Ty5ZxKMaK7SBY_NTxYyvpPs3ti6kmQPM7jZi
    _XtFAoTtmPuAy0eQHLJyF47YBkS8v0481twj1BfJoiXz3HQcvTLB0j4>
X-ME-Received: <xmr:RTzWatXyw9LMVHLJz5MnfBiZPogV4NQxnsGEm0-LU067yKXiVW0mA8nhrRU>
X-ME-Proxy-Cause: dmFkZTE+kjgISKw/D5xbtovMvE/5+MXw9OAGtDBfqR9Zk5dZNOqhNWGTcEGO5Lmn7qsaMJ
    P+2+K5eT4SfShSSEvxMo9+0NhMtUrbV4W6Uy0A3XpuEB672w8089GbqFaxEF0wWgdpl5Mt
    ZGUplA1E9XDXzNgkO2MrFgMfcNS4u61SieDRP0v46gjH0l2eZ2DL9zme+jYfCIiYlLA1YJ
    nvbn1HssXPAJFHKdL+OCiEp78jaTWZC2fJHjA4vCnfghQrymIXyUGAHupLMJJEm2bjt0nv
    kEsuBoXYnW/I4u0Q3SZjAxl07Y4ERxrcHOAeD/N6wYko4+jO11wXgs98kOmjLgJ2rMOJLr
    4FP7CSXILgep+V+bnFblzLb2zNX5VOi9HTV33Avp2CU2x/3slL9UpGUX8QP3dV/RyCFMFG
    7imraoXV3UkaOEWfGmHh0OoG9j6M1axwhaJN6nA2HyYr2TdqTNigjbOhwoon6MyVdyyZ+U
    9DK1iVoT/QBuGfOV2J/7tFEPGkQChXo/3aa8Xv7Il7b4za6LWrtfdMTzCHeTrHOuCuyBi+
    7sZr0XoHceQEgIL5FXJB/u/mTl9LrcQBv3ckBqQ40FYXHHMxv6YS0bNZIBfxbsZ3EpISc7
    FhCZ+mKuDN/rcicdBgn/vjQLHJDQGooDmhyDm5AYtLzSQEnR+OVRpfY12e7g
X-ME-Proxy: <xmx:RTzWajRRDhEXwNdv4QdP0IIVDhzS757ZHwZeCSwxqJe02U5VhKd1Tg>
    <xmx:RTzWaqldVlkDWLJJTq6z3PL5cmBNLrOmpBc9C8GUUHT8H_Bbcb4Deg>
    <xmx:RTzWauLwN8-iEtFQpRKWyz_SLVPxzM5NymW_8F2UJGthEucpDGN5aw>
    <xmx:RTzWatXhb0yp2qE_Nc50LD2PMAYq1wBFgDVYpnHWI5ywE3RZIILLtg>
    <xmx:RTzWajF8Q58INwrzpSXejkJdDR5V-g124CSsLWrJZoASPgC4ioqqoNu_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:28 -0400 (EDT)
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
Subject: [RFC PATCH 11/18] mm/filemap: set PG_rcu_free on the folios that reads keep coming back to
Date: Mon, 19 Oct 2026 16:49:04 +0100
Message-ID: <20261019154913.1765974-12-kas@kernel.org>
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

A folio with PG_rcu_free can be read without a reference, but its
memory is held back for a grace period after it is freed.  That trade
is worth making only for folios that readers look up again and again.
Flagging every page cache folio would also delay the free of streaming
reads, truncated files and reclaimed cold data, which no reader comes
back to.

Set the flag in filemap_read(), under the read's reference, when the
folio turns out to be hot:

 - folio_mark_accessed() finds it as accessed as the LRU records, or
 - the read goes back to bytes that the previous read through the same
   open file has just read.

filemap_read() does not mark accessed the folio that the previous read
ended in, so re-reads through one open file do not make a folio hotter.
The second test is for that folio.

Leave alone a folio whose next read needs a reference anyway: not
uptodate, readahead or dropbehind.  Leave alone unevictable folios too.
folio_mark_accessed() calls them hot after at most one access, so every
ramfs folio that is read would get the flag.  An initramfs deleted at
switch_root would then have the free of all its folios deferred.

AS_RCU_READ records that an inode has had a folio flagged, so that a
lockless read can skip the inodes that never had one.

pgfree_rcu_mark in /proc/vmstat counts the pages that get the flag.

Assisted-by: LLM
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: count the marks, AS_RCU_READ, 64-bit only, shorter comment,
 rewrote the changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/pagemap.h       | 12 +++++++++++
 include/linux/vm_event_item.h |  1 +
 mm/filemap.c                  | 40 +++++++++++++++++++++++++++++++++--
 mm/vmstat.c                   |  1 +
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0adfa6605653..6c7f58803eee 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
+	AS_RCU_READ = 11,	/* a folio has had PG_rcu_free */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -269,6 +270,17 @@ static inline bool mapping_unevictable(const struct address_space *mapping)
 	return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
 }
 
+static inline void mapping_set_rcu_read(struct address_space *mapping)
+{
+	if (!test_bit(AS_RCU_READ, &mapping->flags))
+		set_bit(AS_RCU_READ, &mapping->flags);
+}
+
+static inline bool mapping_rcu_read(const struct address_space *mapping)
+{
+	return test_bit(AS_RCU_READ, &mapping->flags);
+}
+
 static inline void mapping_set_exiting(struct address_space *mapping)
 {
 	set_bit(AS_EXITING, &mapping->flags);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7626a3e3a07a..c1a63f070aa7 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -37,6 +37,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(PGSCAN_SKIP)
 		PGFREE, PGACTIVATE, PGDEACTIVATE, PGLAZYFREE,
 		PGFREE_RCU, PGFREE_RCU_EXPEDITE, PGFREE_RCU_DRAIN,
+		PGFREE_RCU_MARK,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
 		PGREUSE,
diff --git a/mm/filemap.c b/mm/filemap.c
index 3508eea44ad9..b732ecaa78a9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2759,18 +2759,54 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+/*
+ * Reads keep coming back to @folio: free it only after an RCU grace period
+ * from now on.  Not if its next read needs a reference anyway.  Not if it
+ * is unevictable: folio_mark_accessed() calls such a folio hot after at
+ * most one access, so every ramfs folio that is read would get the flag.
+ */
+static void filemap_mark_hot(struct folio *folio)
+{
+	struct address_space *mapping;
+
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+		return;
+	if (folio_test_rcu_free(folio) || !folio_test_uptodate(folio) ||
+	    folio_test_readahead(folio) || folio_test_dropbehind(folio) ||
+	    folio_test_unevictable(folio))
+		return;
+	if (folio_test_set_rcu_free(folio))
+		return;
+
+	count_vm_events(PGFREE_RCU_MARK, folio_nr_pages(folio));
+	/* NULL if the folio was truncated meanwhile */
+	mapping = READ_ONCE(folio->mapping);
+	if (mapping)
+		mapping_set_rcu_read(mapping);
+}
+
 /*
  * filemap_read() is about to copy from @folio at @pos.  @last_pos is where
  * the previous read of this open file ended, or how far this one has got.
  *
  * Reading on in the folio that the last read ended in is not another access
  * to it: a folio read in small pieces is marked accessed once.
+ *
+ * The folio is hot when folio_mark_accessed() finds it as accessed as the
+ * LRU records, or when this open file goes back to data that it has just
+ * read.
  */
 static void filemap_read_accessed(struct folio *folio, loff_t pos,
 				  loff_t last_pos)
 {
-	if (!pos_same_folio(pos, last_pos - 1, folio))
-		folio_mark_accessed(folio);
+	bool hot;
+
+	if (pos_same_folio(pos, last_pos - 1, folio))
+		hot = pos < last_pos;
+	else
+		hot = folio_mark_accessed(folio);
+	if (hot)
+		filemap_mark_hot(folio);
 }
 
 static void filemap_end_dropbehind_read(struct folio *folio)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d994de1fd739..c27caad017e3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1347,6 +1347,7 @@ const char * const vmstat_text[] = {
 	[I(PGFREE_RCU)]				= "pgfree_rcu",
 	[I(PGFREE_RCU_EXPEDITE)]		= "pgfree_rcu_expedite",
 	[I(PGFREE_RCU_DRAIN)]			= "pgfree_rcu_drain",
+	[I(PGFREE_RCU_MARK)]			= "pgfree_rcu_mark",
 
 	[I(PGFAULT)]				= "pgfault",
 	[I(PGMAJFAULT)]				= "pgmajfault",
-- 
2.54.0

