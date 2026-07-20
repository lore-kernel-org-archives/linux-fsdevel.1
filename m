Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05145395AE9
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519727; cv=none; b=lc6trOSg2u1MshymOIf2bZ7jfNFyqhxy7Uw1gjKuD0hPJRLZUGaMj4NMrQUp/XcO3fIldiZUf1zrKHFDlY6q4AK609U7ICpCXi4W0qHbOKq1Zaw9fb0PM+TKY/IM4/QZODaw1ytpmoFGXdoZvK/zfWVWCajwPjqKdDqFnike0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519727; c=relaxed/simple;
	bh=8ivd3il2zDTuc94gGIsc+4kTK+q3zkf3tgKl12W0RuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI7ovyDkHY7ryaLVRdXCH7U3H3s2KwdfnMqIGGjVnH7c5MX06ufVHona2sT0ec0ZO32IRSXHV1h1hF0+I8cuL2YaDQpFZmM/SEe0rxvV+9LOyxGMJaLt/w5I3zclnnQy0DaeAaIiVLbO/gE7VqRe4hhDr3amajuW93uC2GrWX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tSyM/jk/; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tSyM/jk/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BeDXJ1GH6u80+km2Mx/ZY9/6+inc9EkBSDAiip49A38=;
	b=tSyM/jk/lOLlTHOcSgyBfEdncp3mh7QY9+QjM1ylC7ywQfjuqYHXBVEHdTvvaO3P93AsAOf7E
	BTFeabim1p3C6Ze6+b0dZ97a62cYRelNCOFvXl3nt3HK9hhwU3LZGVti/trKuNsCOAHdPBJSnij
	gNBnODcPdv84ZMS1YkDEP3Y=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h3RJ42rRHzcZyH;
	Mon, 20 Jul 2026 11:45:56 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 11A9D40575;
	Mon, 20 Jul 2026 11:55:21 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Jul
 2026 11:55:20 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH v2 2/3] fs: stable_page_flags(): use folio_test_*() helpers
Date: Mon, 20 Jul 2026 11:30:20 +0800
Message-ID: <20260720033021.4091944-3-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720033021.4091944-1-tujinjiang@huawei.com>
References: <20260720033021.4091944-1-tujinjiang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Since commit 304daa8132a9 ("maps4: add /proc/kpageflags interface"),
/proc/kpageflags directly operates on page->flags to determine page status.
Later, commit 177975495914 ("proc: export more page flags in
/proc/kpageflags") started using page helper functions when exposing new
flags, leading to a mix of both approaches.

For tail pages, the original code did not return corresponding status.
commit 0a71649cb724 ("/proc/kpageflags: return KPF_SLAB for slab tail
pages") and commit 832fc1de01ae ("/proc/kpageflags: return KPF_BUDDY for
"tail" buddy pages") made tail slab/buddy pages also return corresponding
status. Then commit dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
made all tail pages return the same status as their head page, except for
hwpoison and mapped flags. It also cached the folio's flags and operate on
the flags directly to avoid concurrency issues if using folio_test_*()
helpers.

Since commit 476d87d6a061 ("fs: stable_page_flags(): use snapshot_page()"),
we can now safely switch to folio_test_*() helpers instead of directly
operating on flags, which is more readable and consistent with the rest of
the kernel. Only convert cfolio-specific flags (i.e., anon, ksm, swapcache)
to folio_test_*() helpers, which reduces redundant code. Keep others
unchanged due to they aren't folio-specific flags or coverting them doesn't
cleanup.

No functional change is intended.

Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 fs/proc/page.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index ee39b321f1c6..b3c1d7a7604d 100644
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
@@ -161,19 +159,16 @@ u64 stable_page_flags(const struct page *page)
 
 	snapshot_page(&ps, page);
 	folio = &ps.folio_snapshot;
-
 	k = folio->flags.f;
-	mapping = (unsigned long)folio->mapping;
-	is_anon = mapping & FOLIO_MAPPING_ANON;
 
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
 
@@ -225,11 +220,10 @@ u64 stable_page_flags(const struct page *page)
 	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
 	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
 
-#define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
-	if ((k & SWAPCACHE) == SWAPCACHE)
+	if (folio_test_swapcache(folio))
 		u |= BIT_ULL(KPF_SWAPCACHE);
-	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 
+	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
-- 
2.43.0

