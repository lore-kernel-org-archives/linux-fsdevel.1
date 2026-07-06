Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71342CB06
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341462; cv=none; b=ldhlTzvBS2OGaZ8Tw+f+nHFgw4YmeHFj/Pn5aPTo1WL0y3j9wyvMeIKLuVoEEbvUn5FbNsae+LKHJDVGTvA2zC9RAIHYky0Fbw+QlrFYRFWCJi3jpobg+BeWPxLFMbkn4Bebj0nOYqT31zTgm39X4h9VcFzETt2ZasPDc8FxwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341462; c=relaxed/simple;
	bh=n0HJqRssJDx8YbMYEaS146Avet8e8dofpS5OVWr1p8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNFmzfk1JWb5choOUFG6UfUrxdAfp/XvPYZaMQ7RtAcqINFfPjiz2grqeYzlG1cqnyioKeZoBNfKgo+NaQh2T3ct/e7QV+ibjyKVLYpomefupfNtFPvPn16kwujGdYXjGw5cnlbTXzBjqu3E09gG2lFzEyq08ZkKkCke3d+bInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YinHWbqZ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YinHWbqZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XcjJCQ7WOmAP4qXUsDLNV9IJzWl6RyrThMLDcVOXfcU=;
	b=YinHWbqZeRk/dXs+INd3Ti7tLZUCUJnEozuknBbjb7SrB79m2FF+T6qYADJUVvkBhKmia++2g
	SEsSdyYWhf3ZCzmH2vJdwkuMNFchOamLQfedfbvoBMlLbNneAdCooppjvGGqJfXvYGU/k+Q8Dly
	rPI/p/pOOatgoRplLHDvZ4g=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gv3Yb0ccJz1T4Fk;
	Mon,  6 Jul 2026 20:28:35 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 22D6240538;
	Mon,  6 Jul 2026 20:37:33 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 6 Jul
 2026 20:37:32 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>, <liam@infradead.org>,
	<ljs@kernel.org>, <vbabka@kernel.org>, <jannh@google.com>,
	<pfalcato@suse.de>, <xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH] fs/proc/task_mmu: count KSM-placed zero pages in smaps
Date: Mon, 6 Jul 2026 20:13:22 +0800
Message-ID: <20260706121323.1149847-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
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

When KSM deduplicates a page to the kernel zero page (i.e. when
/sys/kernel/mm/ksm/use_zero_pages=1), it places a zero PTE with the dirty
bit set. vm_normal_page() returns NULL for such PTEs, so smaps_pte_entry()
bails out before reaching smaps_account() and these pages are never counted
into mss->ksm. As a result /proc/<pid>/smaps and smaps_rollup report a KSM
value of 0 even though the region is fully merged.

Count KSM-placed zero pages directly in smaps_pte_entry() using
is_ksm_zero_pte().

Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 fs/proc/task_mmu.c  | 3 +++
 include/linux/ksm.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d32408f7cd5e..3f446e9f59b6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1061,6 +1061,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
 		present = true;
+
+		if (is_ksm_zero_pte(ptent))
+			mss->ksm += PAGE_SIZE;
 	} else if (pte_none(ptent)) {
 		smaps_pte_hole_lookup(addr, walk);
 	} else {
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d39d0d5483a2..abb41b3b7f4b 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -127,6 +127,8 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+#define is_ksm_zero_pte(pte) false
+
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 }
-- 
2.43.0

