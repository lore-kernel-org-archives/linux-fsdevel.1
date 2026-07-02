Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D841B354
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991825; cv=none; b=mzlqYtZQRpFaUlMaTG2O33Fu3YLxxMzQSmQ92lxYxcwRqAhyvmdNIxHgP1PtO4X57V+QcyNfPNMQ5nfRRFS247c6PKP0kIPL3fvbocAVUvQv273sBULvqJXiWaSD6jUTBukWpr2Mz6arBGNRW9/FZKES0CrqdbjjGTLci6i0uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991825; c=relaxed/simple;
	bh=zRRx1dIqBhrlqZMNbjX6tfAPwfuQxRFeez/D1suSqHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvfjQBdPhEqN919DyWnC6bFFoNvHeN8Bwz72imHXB/FwIVhZc6OHw/nb5sBhDroh1mMinbrfNRwMlKvydjbMODC9nhgA6FqESGHjGiOVfKs0vhKoVuKypfCTwUzydaUXJCZkIldm8SrEh+E5s/F6Wgo5SJTeKEuEn22vafDzNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cU9ghqQX; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cU9ghqQX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c6spe87TeODtMCQYh5DHSqjATPrCJwLTYCaRZNSADXM=;
	b=cU9ghqQXG0eWjz6aYGqwm5styPynJqhUwB5tQ3jnYN863aM7UvaFr5mnoaZIQNrsshptoLtvo
	NjELlY5x/f2hS67swVCtz8U80WWthJY4KTMpGL8R6+1yj0cYvglvZTtm03NMkKlMP7fImjTtth3
	964EwVHIiCmqpKfB/8mm9Ac=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4grZFS1cZ1zmV7h;
	Thu,  2 Jul 2026 19:21:00 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id BE50E4056A;
	Thu,  2 Jul 2026 19:30:10 +0800 (CST)
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
Subject: [PATCH 1/2] fs: stable_page_flags(): use BIT_ULL() for KPF flags
Date: Thu, 2 Jul 2026 19:06:13 +0800
Message-ID: <20260702110614.2176986-2-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702110614.2176986-1-tujinjiang@huawei.com>
References: <20260702110614.2176986-1-tujinjiang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)

The stable_page_flags() function currently sets page flag bits using
"1 << KPF_xxx" for various KPF_* definitions. KPF_* may be larger than 32,
which will trigger -Wshift-count-overflow warning. All KPF_* values
currently used in "1 << KPF_xxx" are smaller than 33, so no warning is
triggered with current code. However, the later patch will cleanup
stable_page_flags() and "1 << KPF_xxx" will be used for KPF_* values larger
than 32, such as KPF_MLOCKED.

Replace all occurrences of "1 << KPF_*" with the BIT_ULL() macro to
ensure all shifts are performed on a 64-bit unsigned type. This makes
the code robust, and safe for future extension.

No functional change is intended.

Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 fs/proc/page.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 7d9387143435..2717dbb0431b 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -157,7 +157,7 @@ u64 stable_page_flags(const struct page *page)
 	 * it differentiates a memory hole from a page with no flags
 	 */
 	if (!page)
-		return 1 << KPF_NOPAGE;
+		return BIT_ULL(KPF_NOPAGE);
 
 	snapshot_page(&ps, page);
 	folio = &ps.folio_snapshot;
@@ -170,11 +170,11 @@ u64 stable_page_flags(const struct page *page)
 	 * pseudo flags for the well known (anonymous) memory mapped pages
 	 */
 	if (folio_mapped(folio))
-		u |= 1 << KPF_MMAP;
+		u |= BIT_ULL(KPF_MMAP);
 	if (is_anon) {
-		u |= 1 << KPF_ANON;
+		u |= BIT_ULL(KPF_ANON);
 		if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
-			u |= 1 << KPF_KSM;
+			u |= BIT_ULL(KPF_KSM);
 	}
 
 	/*
@@ -184,35 +184,35 @@ u64 stable_page_flags(const struct page *page)
 	if (ps.idx == 0)
 		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
 	else
-		u |= 1 << KPF_COMPOUND_TAIL;
+		u |= BIT_ULL(KPF_COMPOUND_TAIL);
 	if (folio_test_hugetlb(folio))
-		u |= 1 << KPF_HUGE;
+		u |= BIT_ULL(KPF_HUGE);
 	else if (folio_test_large(folio) &&
 	         folio_test_large_rmappable(folio)) {
 		/* Note: we indicate any THPs here, not just PMD-sized ones */
-		u |= 1 << KPF_THP;
+		u |= BIT_ULL(KPF_THP);
 	} else if (is_huge_zero_pfn(ps.pfn)) {
-		u |= 1 << KPF_ZERO_PAGE;
-		u |= 1 << KPF_THP;
+		u |= BIT_ULL(KPF_ZERO_PAGE);
+		u |= BIT_ULL(KPF_THP);
 	} else if (is_zero_pfn(ps.pfn)) {
-		u |= 1 << KPF_ZERO_PAGE;
+		u |= BIT_ULL(KPF_ZERO_PAGE);
 	}
 
 	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
-		u |= 1 << KPF_BUDDY;
+		u |= BIT_ULL(KPF_BUDDY);
 
 	if (folio_test_offline(folio))
-		u |= 1 << KPF_OFFLINE;
+		u |= BIT_ULL(KPF_OFFLINE);
 	if (folio_test_pgtable(folio))
-		u |= 1 << KPF_PGTABLE;
+		u |= BIT_ULL(KPF_PGTABLE);
 	if (folio_test_slab(folio))
-		u |= 1 << KPF_SLAB;
+		u |= BIT_ULL(KPF_SLAB);
 
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
 #else
 	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
-		u |= 1 << KPF_IDLE;
+		u |= BIT_ULL(KPF_IDLE);
 #endif
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-- 
2.43.0

