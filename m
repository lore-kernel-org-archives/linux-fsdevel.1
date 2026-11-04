Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797365;
	b=I1wclFRiHtLY+lvfWszMiG4rGj9RYuONcB1VI3amX4Sv3FRIssjr42IYYZuYU0a4g1Fg
	 HcpSJiq9GGcImGhsxQnqMabc1L3hfu0nUtQ2FakOY9ErZdlXJYcwgBig8j+TaqEvweoMp
	 Kx3r8DTthH4CmCTKGedGIbpnkxAL6m14E5Dsc2SDqRUuCXSCi+fo2iW7DOwJRXWh4NhKl
	 7bIHlg2qPpYU8+Fsf+cNYjhiD4WJ4Hob9347wI3hi9KJjuA/tQvk25m7yF84fH0v8j084
	 fMux61tTfxhTmzkwIXlkryKeMF3lOVXZ8QNtSfZJmv9252fI3Jxi5J6HpYJiFMLDKuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797365;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m6xwni03PfAM2cWecuEikX6+gVfqDGMam7JV3RwA/00=;
	b=VnDjklpmy8+hRHAf9PwgGOGw+wLp0yZC6ly9hMBkRPDwMn9CyDKSdVedpW1zT67JW36Q
	 uZp5zhgys7ZruZyN7dTzKsDg40KADdikKhobv0sfvVYgAMtHS2dTzy2DEJaUIV92NmsuW
	 KqVg+Q/9rKLRwWPjB0l0Um0QPHTb2jDse9hVQMzSvbHnT0OMbjZDHK4GbAY3bT2spDgAQ
	 5ThSqA/KmlrMtNnJffKv86RCROYivqNAD6V7V5On4bOvCu3x3RARDhCqDkKhF+/swii5R
	 b3kf++0QDD1dec9ZQoOhIj0ofAoODR4kQqGABwFa2NWpn6vIC4rkktHqkAi0PxQhlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl0bVr9s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7D6082BFC;
	Wed,  4 Nov 2026 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl0bVr9s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5AC1F00A1B;
	Wed,  4 Nov 2026 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797364;
	bh=m6xwni03PfAM2cWecuEikX6+gVfqDGMam7JV3RwA/00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gl0bVr9sIGprDntcvxsHGzoDFbwYldomWHY+V1rKErVnUHDhDrsORBUSEix5/0B0f
	 wj11uowS+fY/tfC4nbGDaHng3mRD93gABTVpnAUHYIGKo63ZvV+mn1j1SRdUbpTN/f
	 FM12/T++l/Rv7X/N4bcOxH3s7aSLbIJCXnz4XD0f2QI1t6Hlaf5u7TmWq/eVRo3+BC
	 Er4DxxOUrIFSBNufz8dh9slJr0P6mrv7XfdKOI7/HXKFLq+c2WGOpI3kFMhYnH3eWC
	 qJiu/Sm35Xy7ybS9QKMMt9bkn0f67oOWOpIyA4P7bVOiLyRDpr3eFS3kIrAOR/dhe1
	 szhNooLae9zGA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9737D1980052;
	Wed,  4 Nov 2026 08:02:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 08:02:39 -0500
X-ME-Sender: <xms:6yzrah3dCOaUn4w_fdvNgr9fFu4O-dFEnxMIpYOD0MInUteHXVr-mg>
    <xme:6yzratVGB5zIJKkPhXw8lEzQCZU7b86vxPmeqjXLIv1aF2DY1dz5NgGf3qBpAT2jg
    3yKgrvNmPwWfm5dJK1DbjZ03e14K3FwSAXki6bLgJGPRsO8R9pv4fQ>
X-ME-Received: <xmr:6yzrakjWZB9vBAugsnw2QrYmtFXOjLorYTPxwTqwzpUqf0ucL5L2Q_ssLLU>
X-ME-Proxy-Cause: dmFkZTEkTGQme7AYtjF3GuVS96P2KQmK7WXeTlUb1QwwiuzIvAmashPSlbgOXzJn8Vwnwy
    GtuimX8GVaozomoo/zh+dZJa/50iMsle5DQ+rz1xv6q7s8h1ROZ32xDIMTiguWiavpmC2D
    BBwjWvlIRSWZcXI9bWu6+sLs7omuy7lLW9/gOc6hVkazqru7j3LnWdj5tmV/csyW0bsTmS
    EsxaoHyCeNrVLjcn3op2UYLn5kjIXtndJ2M5CWyKjF23KtNnUBacMFKYutyyEO2UkxXzYe
    RLi75JY7cBimTx0NOw8ItiGvjmUs48xoopmJA34QoNHmlECPZN6WTQStnLRujBuoPTyyAL
    RZqBSN8icGx9O20vLT7l2QclXCVUSZ9An1bc6x7PXtyywU0CbZAQUO3CeU9qmOHR+OqhaU
    mqcwjgmdE6/tw/BZqJGNjLqOwYk4vNbmC6b87jlwaNGKro2HQy5/yZdmchcMQl6O+1p70w
    5JZHpUmu9YQmaqyxE2DudQ7HpdJ8cYa2CwbkfAcut4JoxG8dSCocdQ6MBXaECCKxkEDq8/
    Dexam+4JamIR3UHMtV1TBxcSnuIjd5NgKAtzaKXUqojjFJQUJPxjjrAnH+LUAR3Bw+nbOQ
    kci1Qy31il8ic/peoAbkKwEOFFOuYxDZOENv0T3jnpl5XW3RUMNCCNi6oSMA
X-ME-Proxy: <xmx:6yzraugIm7LEaAbRjbY2LeeCKAoI4fEOj05mkdS8Rcsrpw-Xx19PyA>
    <xmx:6yzrakvJ-3BCGQVdUzt_3K7p0vng9q_htTKIeWlcWnqAuf-9Srt58g>
    <xmx:6yzranQpizLjex5p2e5xROmYqadHdJHjo1UnRZ8MF4JvIg-hnRXI5g>
    <xmx:6yzralEY76JYarv8x4zscqn5ntzMUgskNp_oE8szU2yeQVcBUpdW6Q>
    <xmx:6yzrahhmLZu8e3g1Ou8j3upRiJ6-tH-Ca4O0kYROTH4MfDk3e4TGSUkh>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:34 -0500 (EST)
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
Subject: [RFC PATCH v2 12/18] mm/filemap: set PG_rcu_free on the folios that reads keep coming back to
Date: Wed,  4 Nov 2026 13:01:08 +0000
Message-ID: <20261104130118.2507513-13-kas@kernel.org>
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

