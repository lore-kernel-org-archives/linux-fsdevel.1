Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850037C10D;
	Wed, 15 Apr 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253622; cv=none; b=EUnHUo1iiKApwpEbXZ7grRHZq0QbYEjEvU+5oFmQaCcd2pwCa2X2RGP40bD5YfkHo/hsa7ZUR24VYgkOJm4/6KRg8SEHBO5ymWRAtliCajhqGyL+R7vdmKrZ0NeRUR4p946Y6ghArNP58vphe0je3VX5DW9MYPJhWPIYDYUVtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253622; c=relaxed/simple;
	bh=cNBDjH5NKl2EKIuoKHsCvrkBImcBW/Qk4OH34bhxOb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0Dgkx+KSx9opMBb/RPc+q2BLE1zLtr61e9ZJyMg8R4cmg57Ew6p7bIB+1xz1eASGPVsFAMj6p7ERx4ioLY3ZqqiWyJNBF2p0Fo/V7z660sKssSteChAGxLnMXoTFV05a/AQsaLWwCdzAdMfHEiK3T5nhnO7j/afD4FMZiBmoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwfW56W0TzHnH57;
	Wed, 15 Apr 2026 19:46:41 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id DC6FB4056B;
	Wed, 15 Apr 2026 19:46:57 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 14:46:57 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<ljs@kernel.org>, <Liam.Howlett@oracle.com>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<artem.kuzin@huawei.com>, <gutierrez.asier@huawei-partners.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Anatoly Stepanov
	<stepanov.anatoly@huawei.com>
Subject: [RFC PATCH 1/2] procfs: add contpte info into smaps
Date: Thu, 16 Apr 2026 03:28:52 +0800
Message-ID: <20260415192853.3470423-2-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
---
 fs/proc/task_mmu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7..22bcd36b9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -874,6 +874,7 @@ struct mem_size_stats {
 	unsigned long shared_hugetlb;
 	unsigned long private_hugetlb;
 	unsigned long ksm;
+	unsigned long cont_pte;
 	u64 pss;
 	u64 pss_anon;
 	u64 pss_file;
@@ -915,7 +916,7 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		bool compound, bool young, bool dirty, bool locked,
-		bool present)
+		bool present, bool cont)
 {
 	struct folio *folio = page_folio(page);
 	int i, nr = compound ? compound_nr(page) : 1;
@@ -938,6 +939,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		mss->ksm += size;
 
 	mss->resident += size;
+	if (cont)
+		mss->cont_pte += PAGE_SIZE;
 	/* Accumulate the size in pages that have been accessed. */
 	if (young || folio_test_young(folio) || folio_test_referenced(folio))
 		mss->referenced += size;
@@ -1015,6 +1018,10 @@ static void smaps_pte_hole_lookup(unsigned long addr, struct mm_walk *walk)
 #endif
 }
 
+#ifndef pte_cont
+#define pte_cont(pte) (false)
+#endif
+
 static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		struct mm_walk *walk)
 {
@@ -1023,12 +1030,14 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
 	bool present = false, young = false, dirty = false;
+	bool cont = false;
 	pte_t ptent = ptep_get(pte);
 
 	if (pte_present(ptent)) {
 		page = vm_normal_page(vma, addr, ptent);
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
+		cont = pte_cont(ptent);
 		present = true;
 	} else if (pte_none(ptent)) {
 		smaps_pte_hole_lookup(addr, walk);
@@ -1058,7 +1067,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, young, dirty, locked, present);
+	smaps_account(mss, page, false, young, dirty, locked, present, cont);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1096,7 +1105,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		mss->file_thp += HPAGE_PMD_SIZE;
 
 	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
-		      locked, present);
+		      locked, present, false);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -1356,6 +1365,11 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
 	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
 	SEQ_PUT_DEC(" kB\nFilePmdMapped:  ", mss->file_thp);
+	if (mss->cont_pte) {
+		SEQ_PUT_DEC(" kB\nContPTE(Rss):        ", mss->cont_pte);
+		SEQ_PUT_DEC(" ", mss->resident);
+	}
+
 	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
 	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb: ",
 				  mss->private_hugetlb >> 10, 7);
-- 
2.34.1

