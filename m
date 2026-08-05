Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFB421227
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963991; cv=none; b=LZ29OMOJX58POMniVMgZht4xf1+3YxbN4NdsEfezGG78kOo3JHTjGyifqP6LZdEmLevwoO3fOFebHD7H+YyOGCi4hCVl8fu2ZVpGcS4gp57Nr/vUTHvOOMafGqrH6oW0En2bxhuw6hnyoNksJ4hr8tTi/Nz9Dy5HBmiApl6BmSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963991; c=relaxed/simple;
	bh=Mhrejw94KCwkFDizRtcQe5KTo7KCEXM0BZ4WBe/629c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHvdpj3hf2XwNrdpkzLkBvPQ6VGeunZ7sXxTH6sBm++ycbL+PbyiVbz8z1wfjgBBZDClZbmzGPcRhnNHH/fkL0t5s30bsBBldjihO5VC6s/YM4YDsTfv8xUyl0pWkTvXh9b5UCl/dzqUWAviWwKZ+VpsBQgcKY9UZBTmCYw4QMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HY7LIADl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HY7LIADl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xU1EGnxu1zA/QCvrmcvsW9FFSAGjB7CeJF+feg1bhls=; b=HY7LIADl+h5kenkBUynlodcWX3
	2/0Wr63ay76B3ZaBFt1sjaxZygjmV3Bb4bOOaFJCd+mG3ViHMVvh/zGCVy2rVomHmKVYT+JLHgFQn
	Yx6Dqke/5av22WwET+2BiZXz3Mu8yjOZW/dIn+r8rF7oM/299f3Kj4jPM/Nd7yu4Q/bugHB68VL2u
	P1tx/PncY0c0nW57woah389eTh2p4jCoyc8akENNs4OpOlO5OpWz2a5r0FRfQ0n62VIPYZYtwp0bq
	Dme7zfAsZyVQIRXxJcKTD+6M+q5NctzcSpSCFXQOo+4sGjIZoKo+QDqH/g/zGuKgh2XtlkR5TnJMU
	hBdTW84g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrioJ-00000004h67-1ooi;
	Wed, 05 Aug 2026 21:05:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH v9 02/15] memory-failure: Prevent hugetlb freeing during unpoisoning
Date: Wed,  5 Aug 2026 22:05:42 +0100
Message-ID: <20260805210557.1118966-3-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805210557.1118966-1-willy@infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we fail to get a reference on the hugetlb folio, then it might be
freed as we operate on it.  Prevent the freeing and the attendant races
around manipulation of the raw_hwp list by holding the hugetlb_lock,
which is also held by the hugetlb code when freeing hugetlb folios.

Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
---
 include/linux/hugetlb.h | 19 +++++++++++++++++++
 mm/memory-failure.c     |  6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2abaf99321e9..50eab2c23299 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -110,6 +110,17 @@ extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
 
 extern spinlock_t hugetlb_lock;
+
+static inline void hugetlb_lock_irq(void)
+{
+	spin_lock_irq(&hugetlb_lock);
+}
+
+static inline void hugetlb_unlock_irq(void)
+{
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 extern int hugetlb_max_hstate __read_mostly;
 #define for_each_hstate(h) \
 	for ((h) = hstates; (h) < &hstates[hugetlb_max_hstate]; (h)++)
@@ -279,6 +290,14 @@ unsigned int arch_hugetlb_cma_order(void);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
+static inline void hugetlb_lock_irq(void)
+{
+}
+
+static inline void hugetlb_unlock_irq(void)
+{
+}
+
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 944e6e1d4971..1dd0e7b99bb1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2725,13 +2725,17 @@ int unpoison_memory(unsigned long pfn)
 
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
+		hugetlb_lock_irq();
 		if (folio_test_hugetlb(folio)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
-			if (count == 0)
+			if (count == 0) {
+				hugetlb_unlock_irq();
 				goto unlock_mutex;
+			}
 		}
 		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
+		hugetlb_unlock_irq();
 	} else if (ghp < 0) {
 		if (ghp == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
-- 
2.47.3

