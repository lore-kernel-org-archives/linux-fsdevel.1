Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425084;
	b=ZF+itmaoaa7OuMYF3C89alzoAsgG5lc2oL6mBJojNqhibh0HHYG1+OZcAnEMUuWVIcUm
	 pOZ0OngFhJUisMOBIwuAXhETnco/VNchGfiDkVCa4wRtZ5Cku0Gv+KFzGJLSZ5N1+eZMR
	 sdidh/j+IXiPdNqz6ze/k56F3agKa/uZJZPQK8qeHRb/WlpG4alHxOq9jIv4SZ5m8pA8A
	 BggNVvKjsCmITE8v8tFVZGp0aJ53A/K/Iwa45EbLq/A8+fz5I22oy2z8/eMG62vjhX06k
	 wJr/tdi4eJljpnmvDmRlruM67kCeMO/c3OmSg3edHgIho3Zie9pqWIqMWfYVVknOlgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425084;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V7LU7B522G/Nt7R0FiWPQqjn9CdYZiUxBthyqwKOD9Q=;
	b=NFp2a1225O/l2u1LPM9RxhUXkgwcxyCPjUIykYY3kKqtrHO5Vqy8XcGpxs0TcJ069NiU
	 Pt5qucWcoyXTPqG0QgAlSY3SHHWl1Jazfq/gDwU+GVFf+mUebC02d6pFRZ2YuKJRkY9ee
	 VAlRFqW6n9HpZpyxdewERgsnqI6euF0C28HOFW6MQfZIr8s0+uHkgLxMBODlLo5UII1vH
	 VvxVJw6qqZlvp5j9Bu/oNmq65FJ9CeIDqqTkj9YnJrKbu6K3cqmMyDxpkG7yILXtBfu5l
	 Zr22jNZwa4VeYG9SsTTfrhF7qfqfRj1Mry/nCerEG7b4Pus5zPkFhQIawC/uu97VUnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j5mv/sgP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212D606AFAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5mv/sgP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE031F000C7;
	Mon, 19 Oct 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425084;
	bh=V7LU7B522G/Nt7R0FiWPQqjn9CdYZiUxBthyqwKOD9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5mv/sgPvRDjlSSgi/KLxGr1Bndb/BpmvtZN5fck7Ojqxhckcal8Eweak2ZdA0oZv
	 W6xS84c32iJ3RY0cKZimfZ3vjk8v8j2BEYOlGcjAqGBNaBbQ3SUOefZjsAsY7W6Dge
	 nvMalS1cE/jxwlCkrV3XSKk44qHXJ4pXCymOdJj/CWo4sU/NQOeLoNLO8iJpWl9y6T
	 92u3yhBHVi2Bhze8PbRSACprvNNiaHJ/0WzIPPliB4xmIPYCLPAyXX64NMpnmyMEnA
	 dz3JAA1RXVj9rlIwWdq3GfPjhP5wOErklxqiJ3etrScQUxlMZmKNKHlLQWgNg+lo1X
	 73g2NM/JlmS5g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id A1B74198003A;
	Mon, 19 Oct 2026 11:51:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 11:51:20 -0400
X-ME-Sender: <xms:dDzWau9M3FbVzylKyeuMuTbSvRi5IhIiOm5vggdDvmx2WLA7P_-HbQ>
    <xme:dDzWaj-PHM48Ndlhrsp1ztoB7LRirKXS6TUWSubRL-nmTgJ5xnjPzKegBHPYb6Apa
    lWzc8x9JYUVJwFZoc-_UAzZlg-D1yIhQhkrMadsKkA2-juVj8DIWp6B>
X-ME-Received: <xmr:dDzWamrnOz-IYgpENDf9AHxZdMqOzb7vuLX2QCJm9BzNQsb3vG9t-cpq8-4>
X-ME-Proxy-Cause: dmFkZTETM5HXVFLzPUxauAkBxER+Z+lTRQkwgIjXhOFN5THGlO0HVgKRB8Wd4BSXaHA5Bq
    7Hki4AkN29JlsW7Oz4whntE9FU2sRh3n5MV6IVyinOcMZqrY6k/BF1c/BxQBvNlfSnbHPl
    QW/SZQekiA5aLb3GJIUgrXyjACrHk/syVIVjTZfD7jaDpyMg1O/dYDf4I6wLOAEwx8xESw
    vWlPZzevy9W/Bx8Vy1OTZuF/dkabbhGDCVd6eGxAa35wXpSJUVy0LPc7oPWN1fg8RR92+D
    ECpc3fgxZvfIHD4VEls/NZQ+K0gffqxM1pWJS3eaXhIg/AZa9YCFosiagiRdAJgbrCIzoM
    o7gldHTvIc7eDhtIlvlXL3C53Ed6FccoFxHkqxXLx6DesQwcRIq2OCKsz71WAjXT1lm5TM
    Kg1S+IlqYIxSJe9HD2GKza9Xs/DT9IRo/iXi4/lAIHvx7zS5svU1pmtsJwFoiXOifXFOJS
    c8+Oeh3NCwMTZdMLywvQlmAwW/Y7WDCES6B0jmV7pMkS4HcOooYUKfO5TR9lAZ5VoW9a8r
    /Sd6cK2NtDUvPD7I9Une5gCLCi06S4ZQdRtRBV9yijBm9YZ31pf3G36MsRdGWua/hTa0oz
    IXvg1wkV9fllJ5EjieDzrGee0JsCZ2XwYMKjT3W5rPPzBpPVPhNKsKgec/1w
X-ME-Proxy: <xmx:dDzWamLg6cF_WAVSMmPrj6q7Spq9p4LSEZCHn9AirSi8MJz72J-B9g>
    <xmx:dDzWaj0knTs9fAMwlRv2eWSSw3MmAJ-GD7Ro5x3412yILKFqsCQDGA>
    <xmx:dDzWan5ODCRnQyiDwSCOgnm3bWqisXfjJ722uVIweErdBv-sNprqtg>
    <xmx:dDzWapPZak97h7nUxuzK1D5s1DiIbQa1A6wNNRF5GxQLRsE0MFuLKQ>
    <xmx:dDzWajL7V6ATZJcx30Qa3GWHT7z1tZ55WDYLNjnvd5l-RPejyxFAhMfr>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:51:15 -0400 (EDT)
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
Subject: [RFC PATCH 18/18] mm/filemap: add a debugfs switch for lockless page cache reads
Date: Mon, 19 Oct 2026 16:49:11 +0100
Message-ID: <20261019154913.1765974-19-kas@kernel.org>
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

Reading hot folios without a reference defers the free of their memory
by an RCU grace period.  A workload that loses on that trade, or a bug
in the lockless read, has no way to turn it off: CONFIG_PAGE_RCU_FREE is
on in every 64-bit kernel.

Add lockless_page_cache_read to debugfs.  Writing 0 stops filemap_read()
and shmem_file_read_iter() from setting PG_rcu_free and from copying
without a reference.  A static key keeps the test off the read path.
debugfs, not a sysctl: the switch is not ABI and can go once the reads
have proven themselves.

Folios that have the flag keep it, and their free stays deferred: a read
that tested the key before the switch may still be copying from them.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/Kconfig   |  3 +++
 mm/filemap.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 5af00db23f90..1ad1cb7969e7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -730,6 +730,9 @@ config PAGE_RCU_FREE
 	  64-bit only: it takes a page flag, and those are scarce on
 	  32-bit.
 
+	  Writing 0 to lockless_page_cache_read in debugfs turns these
+	  reads off.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/filemap.c b/mm/filemap.c
index cde7bc68b32d..7021ed2ab6c9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -48,6 +48,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
+#include <linux/debugfs.h>
 #include <linux/pgalloc.h>
 
 #include <asm/tlbflush.h>
@@ -2765,6 +2766,50 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+#ifdef CONFIG_PAGE_RCU_FREE
+/* Writing 0 to lockless_page_cache_read in debugfs turns the reads off */
+static DEFINE_STATIC_KEY_TRUE(lockless_read_key);
+
+static bool lockless_read_enabled(void)
+{
+	return static_branch_likely(&lockless_read_key);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int lockless_read_get(void *data, u64 *val)
+{
+	*val = static_key_enabled(&lockless_read_key);
+	return 0;
+}
+
+static int lockless_read_set(void *data, u64 val)
+{
+	if (val > 1)
+		return -EINVAL;
+	if (val)
+		static_branch_enable(&lockless_read_key);
+	else
+		static_branch_disable(&lockless_read_key);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(lockless_read_fops, lockless_read_get,
+			 lockless_read_set, "%llu\n");
+
+static int __init lockless_read_debugfs_init(void)
+{
+	debugfs_create_file_unsafe("lockless_page_cache_read", 0644, NULL, NULL,
+				   &lockless_read_fops);
+	return 0;
+}
+late_initcall(lockless_read_debugfs_init);
+#endif
+#else
+static bool lockless_read_enabled(void)
+{
+	return false;
+}
+#endif
+
 /*
  * Reads keep coming back to @folio: free it only after an RCU grace period
  * from now on.  Not if its next read needs a reference anyway.  Not if it
@@ -2775,7 +2820,7 @@ static void filemap_mark_hot(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+	if (!lockless_read_enabled())
 		return;
 	if (folio_test_rcu_free(folio) || !folio_test_uptodate(folio) ||
 	    folio_test_dropbehind(folio) || folio_test_unevictable(folio))
@@ -3025,8 +3070,8 @@ size_t filemap_read_rcu(struct kiocb *iocb, struct iov_iter *iter,
 	pgoff_t last_index = (last_pos - 1) >> PAGE_SHIFT;
 	size_t copied = 0;
 
-	/* Not on an inode that never had a folio flagged */
-	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE) ||
+	/* Not when switched off, or on an inode that never had a folio flagged */
+	if (!lockless_read_enabled() ||
 	    !mapping_rcu_read(iocb->ki_filp->f_mapping))
 		return 0;
 
-- 
2.54.0

