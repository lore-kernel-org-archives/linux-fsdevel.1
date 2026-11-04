Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797400;
	b=q4E/2CNvfEP6tE9pQGH7YpDh2/UyYMcA/JPD2ztqbYjhp4A5E34cRMqhnaEHy0PKrC+L
	 zQ0QNO4FCVzHfWb4xYAWv6yKcgEFMSrZtG7nDqfjbBqMm36VJvnYygf/u8swA35Bigh9f
	 tjs2l/aU/1CXpaf04VaxpYsfYxudi2fFTD7Nywt/ur5qulgiGlbgDb5Tv2JBOOTUI4jCj
	 5ttulcYf+dLcIU5dZBNI6SzilOpprkANCOWwUBBy2boRxBC6jve3aQ0Uyz7jYjzvIs9NG
	 wfVX/AVieVuPAOwGIsDR+xW33s999w6EZHKM/SPnXlqXTOV9QyCtjg8IB2bOGT6jW6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797400;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n4Lerps2lD0Mw1JlyAS7XwS+swB42xH028WT2k07pwY=;
	b=oZz0VehqOTcdklPgwaZKxF6FqiMUpE+OxSQvPguNlvUxRR7bKUVdCnK++ntNQmW4dkA4
	 f85DWQZOLLQKhEJasFWIPvy+nO9Jjsyyp/gX6cEpI3mr/xJzrTdDAc9xMrArLzsuesaAf
	 YodKzPfgPwX1H93Fnkygv0DJGMFk3y+3yVWCcmT39sKh7DMACO1ayRqHVneKrbp6buu+e
	 2Ft62qKH2+33aNTMNSZl38eGj+bKTfKs3cPFwFlt1c9qQ8n4mEFeYIw87bodNKXQEqQaw
	 4w608VvzfsqPZHN/aR/uGdIURzt9NGoLXql07TdGCifgI3d0+Oflt+xGjvjaBqwkDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcnEORRK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D1606EEB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcnEORRK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E3A1F00919;
	Wed,  4 Nov 2026 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797399;
	bh=n4Lerps2lD0Mw1JlyAS7XwS+swB42xH028WT2k07pwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcnEORRK0xRjjrKJZoF9rCkhES79//9BhLXvgZfyVbaQ/EkZiDFhlxYs8CzFWXCkq
	 utDNldPdMaTBE20gG4Xm/rMeR+GLmg15cOin/lCfuivDbjMWSVdlL7K7TaUO4aBT9v
	 TupWTvhcNV6J+VzdtJU6c08AwT2oIPBkckOUDrY4ynyH2Q8nw8MB1hVa80KZQ63lER
	 oKYtC9vxtzulWvq4ptl0bcbegCdibjDzxR452M0F/8lzOUqCrWuOQ8uk5p+DRRlEmd
	 SAQLAcOq1OWycgPFbdAAklk0PSQlHdadnXMKo3HgPo36hPxK0BlL4K5w2oKDJ1Y7gO
	 HGR7X+lWMJZKA==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5718F1980052;
	Wed,  4 Nov 2026 08:03:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 04 Nov 2026 08:03:16 -0500
X-ME-Sender: <xms:Dy3rasvOZLRorb5Y7XVip4fp4u6VdMfGeH3EQ_kRQSi2pTaTi_RLVg>
    <xme:Dy3rauuBt8SLKdmFox98xDaW_7D3C47nxk6XazFb-E4-bi4XXo2voh0KXBx3tjLjf
    e2UFTdR3bXItk7AjYufdS1uS9LFOcbSumkWhYR_E8EtbIBA7o71yRCt>
X-ME-Received: <xmr:Dy3raqbCy1NgIotKuM19qURDgk8WpBrPETTvs04pcj86_qP52HLNaXO8ll0>
X-ME-Proxy-Cause: dmFkZTEMr2WhNOOY7faPMgOVA86T3X6FAd5Ao5Ndgx8HItBF0IoaqscGd+eHtrr6ZU+W1R
    wMCQkezO/jqDpIXHtWbk1cX7511CWG9nytvgA72O7/GyWPbnFJH1/KoC1oU4eTzQz4uQU5
    XlfKyFGwpRspKwzN+UK6QdrS6nHZaHNe/uNaFH4uocVUyYawgtQju2cVEawUWtGw6nseJ9
    0L4J0ssTWIjAVgg3c4pDpTeUfzUmFwAMWTRVDjkJafKYOQzvk6rFVN4JhIZhnU3qcRTinO
    hOXkX2soZGBKWYo9BWQOgOkNg7aqmmDYjwTnBv89mK8xPBsHNPD99ZxyAasIZtmzxuPIXi
    47fzPLe+sdOALN2WIadaz+v0V41yPbH6g7q0GyrIjlQUEVJ6nKkgOeTR/rwyBciFRt7EHH
    g58VksmLOzWMXLyL3a0htP1FPDOdEr9zZ6g+VxGgoaYryYqBgXtjhUqYvzTZHgcDeIC13f
    6fQIJ3s9NDwRSOYZtqbqX4JtxvQ5tfpXi1KPsQ2ztE0Zdg6KdQdDxdSQvje5bS/vmKJaa+
    1CuYd7Bzw9clj+ohoHK43v4Ya9rMycfJibPWMGaiyBlijmK0ODsTQlZWCdqtAldwiFxi5A
    vR1D9ohmfAuKzdozzhI8WiCVONvLPeLa71yfmZjAYNtPitelHF6AMjM6W0Sg
X-ME-Proxy: <xmx:Dy3rau4gcuXjmPqROjLhx61d3mx9ZM6ALSf-8-GgsAe8LAQ4yiQ2yQ>
    <xmx:Dy3ratlnrq_yIUM4B22Y6ZEvT_aAVw1ihqtBIqK5rjKui9KuPcUgeQ>
    <xmx:Dy3rauo_9K0Jvo6cJMTIlVUVkf2ukYGefcRyY_2y15fuU1AY4ozj_Q>
    <xmx:Dy3rao-so6FzhzXTdMeiQilkuR46dbGPO5Gjavnvnclyv5K9V9OYhA>
    <xmx:Dy3ran44aLjryARxqInszue3VlwsFclKt5yec3-daayw4gskEMXGDEAG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:03:11 -0500 (EST)
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
Subject: [RFC PATCH v2 18/18] mm/filemap: add a debugfs switch for lockless page cache reads
Date: Wed,  4 Nov 2026 13:01:14 +0000
Message-ID: <20261104130118.2507513-19-kas@kernel.org>
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

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/Kconfig   |  3 +++
 mm/filemap.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 6e5341b0bf64..768873ebc71c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -733,6 +733,9 @@ config PAGE_RCU_FREE
 	  32-bit.  Not on PREEMPT_RT, where expedited grace periods are
 	  normal ones, so freeing the waiting pages on demand would stall.
 
+	  Writing 0 to lockless_page_cache_read in debugfs turns these
+	  reads off.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/filemap.c b/mm/filemap.c
index e148490db4da..eff29d501f58 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -48,6 +48,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
+#include <linux/debugfs.h>
 #include <linux/pgalloc.h>
 
 #include <asm/tlbflush.h>
@@ -2759,6 +2760,50 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
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
@@ -2769,7 +2814,7 @@ static void filemap_mark_hot(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+	if (!lockless_read_enabled())
 		return;
 	if (folio_test_rcu_free(folio) || !folio_test_uptodate(folio) ||
 	    folio_test_dropbehind(folio) || folio_test_unevictable(folio))
@@ -3028,8 +3073,8 @@ size_t filemap_read_rcu(struct kiocb *iocb, struct iov_iter *iter,
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

