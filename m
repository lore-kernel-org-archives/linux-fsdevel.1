Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEF44D015
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992867; cv=none; b=XlwUtK5mcnRv8wC+DrhiUII97tyMlpEHSz5388WolA6VNf3ie/XXI04ZkJhWgmdrvX6vNmTUXqh983b4DFGNk7jzH2v4uULBImf1UfzT2rmB38mJCO3h8rAGrlLk7Xj4ih8USy03Tx0mqjb1gIt8Up+VoR1yvd6rOsCIOn9IVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992867; c=relaxed/simple;
	bh=0+6LrMbcL9jYWLDGznXtdt+CLQpbx0KpzwShtcsb6Z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcM7fSAltGtRXtOsMHeCukpQoAp4gvTzWyWlGXCs3yfm7+WDNXSgwHGVPG9UadNnV8lVjJ8sADCil6WVh/kgMrZPx8AvUHG6aJhb/5V7afHsnOcQY1dyUyHMTmVchNLCYlhkD9ka+KTddjG9CPtkAfAWq02crEN32RFK+JADqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Pf3afDLq; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Pf3afDLq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KhzUYKwVkNICuNRrpLwwscb9mfOPrWSyd5JLo0nzv2I=;
	b=Pf3afDLqRkSI9vKEHk2TTMIRoWQz4ogBZ+ZWbahPqN23mJfAdWinXKrUa3gphLb37FiDchFUc
	Sm1SeeZikCxuumjYDlEdj7h+jyFx2H22J30WA/whcL+rZSUv+o4xeuUJCztd6JiU8yCuJCxnQTV
	mJaSJ1aFKXxh+PY8BZM82QQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4grZFS6xs8zLm05;
	Thu,  2 Jul 2026 19:21:00 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 53DB34056A;
	Thu,  2 Jul 2026 19:30:11 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Jul
 2026 19:30:10 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH 2/2] fs: stable_page_flags(): use folio_test_*() helpers
Date: Thu, 2 Jul 2026 19:06:14 +0800
Message-ID: <20260702110614.2176986-3-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702110614.2176986-1-tujinjiang@huawei.com>
References: <20260702110614.2176986-1-tujinjiang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)

stable_page_flags() currently accesses folio->flags.f directly. Since
commit 476d87d6a061 ("fs: stable_page_flags(): use snapshot_page()"), we
can replace these raw flag accesses with the existing folio_test_*()
helpers, thereby cleaning up the open‑coded flag handling.

For KPF_IDLE, set_ps_flags() already handles both 64‑bit and 32‑bit
cases, so the duplicate code in stable_page_flags() that deals with
CONFIG_PAGE_IDLE_FLAG for the 64‑bit case is removed.

The flag bits that has no folio_test_*() helpers are left unchanged,
including PG_owner_priv_1, PG_arch_*.

No functional change is intended.

Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 fs/proc/page.c | 94 ++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 2717dbb0431b..0dbd46fa84ea 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -148,8 +148,6 @@ u64 stable_page_flags(const struct page *page)
 	const struct folio *folio;
 	struct page_snapshot ps;
 	unsigned long k;
-	unsigned long mapping;
-	bool is_anon;
 	u64 u = 0;
 
 	/*
@@ -163,17 +161,14 @@ u64 stable_page_flags(const struct page *page)
 	folio = &ps.folio_snapshot;
 
 	k = folio->flags.f;
-	mapping = (unsigned long)folio->mapping;
-	is_anon = mapping & FOLIO_MAPPING_ANON;
-
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
 	 */
 	if (folio_mapped(folio))
 		u |= BIT_ULL(KPF_MMAP);
-	if (is_anon) {
+	if (folio_test_anon(folio)) {
 		u |= BIT_ULL(KPF_ANON);
-		if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
+		if (folio_test_ksm(folio))
 			u |= BIT_ULL(KPF_KSM);
 	}
 
@@ -181,10 +176,12 @@ u64 stable_page_flags(const struct page *page)
 	 * compound pages: export both head/tail info
 	 * they together define a compound page's start/end pos and order
 	 */
-	if (ps.idx == 0)
-		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
-	else
+	if (ps.idx == 0) {
+		if (folio_test_head(folio))
+			u |= BIT_ULL(KPF_COMPOUND_HEAD);
+	} else {
 		u |= BIT_ULL(KPF_COMPOUND_TAIL);
+	}
 	if (folio_test_hugetlb(folio))
 		u |= BIT_ULL(KPF_HUGE);
 	else if (folio_test_large(folio) &&
@@ -201,6 +198,9 @@ u64 stable_page_flags(const struct page *page)
 	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
 		u |= BIT_ULL(KPF_BUDDY);
 
+	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
+		u |= BIT_ULL(KPF_IDLE);
+
 	if (folio_test_offline(folio))
 		u |= BIT_ULL(KPF_OFFLINE);
 	if (folio_test_pgtable(folio))
@@ -208,42 +208,46 @@ u64 stable_page_flags(const struct page *page)
 	if (folio_test_slab(folio))
 		u |= BIT_ULL(KPF_SLAB);
 
-#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
-	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
-#else
-	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
-		u |= BIT_ULL(KPF_IDLE);
-#endif
-
-	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
-	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
-	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
-
-	u |= kpf_copy_bit(k, KPF_LRU,		PG_lru);
-	u |= kpf_copy_bit(k, KPF_REFERENCED,	PG_referenced);
-	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
-	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
-
-#define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
-	if ((k & SWAPCACHE) == SWAPCACHE)
-		u |= 1 << KPF_SWAPCACHE;
-	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
-
-	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
-	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
-
-#ifdef CONFIG_MEMORY_FAILURE
-	if (u & (1 << KPF_HUGE))
-		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
-	else
-		u |= kpf_copy_bit(ps.page_snapshot.flags.f, KPF_HWPOISON, PG_hwpoison);
-#endif
+	if (folio_test_locked(folio))
+		u |= BIT_ULL(KPF_LOCKED);
+	if (folio_test_dirty(folio))
+		u |= BIT_ULL(KPF_DIRTY);
+	if (folio_test_uptodate(folio))
+		u |= BIT_ULL(KPF_UPTODATE);
+	if (folio_test_writeback(folio))
+		u |= BIT_ULL(KPF_WRITEBACK);
+
+	if (folio_test_lru(folio))
+		u |= BIT_ULL(KPF_LRU);
+	if (folio_test_referenced(folio))
+		u |= BIT_ULL(KPF_REFERENCED);
+	if (folio_test_active(folio))
+		u |= BIT_ULL(KPF_ACTIVE);
+	if (folio_test_reclaim(folio))
+		u |= BIT_ULL(KPF_RECLAIM);
+
+	if (folio_test_swapcache(folio))
+		u |= BIT_ULL(KPF_SWAPCACHE);
+	if (folio_test_swapbacked(folio))
+		u |= BIT_ULL(KPF_SWAPBACKED);
+	if (folio_test_unevictable(folio))
+		u |= BIT_ULL(KPF_UNEVICTABLE);
+	if (folio_test_mlocked(folio))
+		u |= BIT_ULL(KPF_MLOCKED);
+
+	if ((folio_test_hugetlb(folio) && folio_test_hwpoison(folio))
+		|| PageHWPoison(&ps.page_snapshot))
+		u |= BIT_ULL(KPF_HWPOISON);
+
+	if (folio_test_reserved(folio))
+		u |= BIT_ULL(KPF_RESERVED);
+	if (folio_test_owner_2(folio))
+		u |= BIT_ULL(KPF_OWNER_2);
+	if (folio_test_private(folio))
+		u |= BIT_ULL(KPF_PRIVATE);
+	if (folio_test_private_2(folio))
+		u |= BIT_ULL(KPF_PRIVATE_2);
 
-	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
-	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
-	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
-	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
 #ifdef CONFIG_ARCH_USES_PG_ARCH_2
-- 
2.43.0

