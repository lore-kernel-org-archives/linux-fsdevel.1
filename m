Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902D372B39
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528503; cv=none; b=FV37xObxpqJmiMIfHsASqI7E+iqoNAz/wXflVtfVdTseYMAzSOVepJNoY3Ua8ELU5/T3hdH4Vq8mRalJrtqGw2PiYWN6N6N94hyJJjSA8XdAX9gXdRQwekNyLCOYeKTOvRZiJ4iMgYOl74Tho8wDTz4IaVdOOP2o50nZyPiBBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528503; c=relaxed/simple;
	bh=U3xQm2tcAV3BACUdA0tzu7kkn6YM8WEKFFqjys7NWj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIyyDWInzuC3tSRaZ65LMED7R1wynZNyzqxWv7frDn3e24Cnqj+LC3F5ohH7dm2dVikKFxtn29DhVNbM6OL5YG5pBGB+obzTaEkGOiuwboYhE/LwtwfIfqVT0iMcuL1S8gRZ2txub+4NpJjBGsNS6zdr5EVCnljy9UHtnnQVoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qJsf/3bM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJsf/3bM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=E2ER2w8+MMrXnv4m+kudfL9RHNepNzRG57k1o/CVENk=; b=qJsf/3bMrtj2dJEDjuQYieP0wM
	imeGJ0ZCm6W1R+mBxI7fQ7M39VFQPgA/mnlyG/cCEjl4JYDab6gYhR9YOJe8CZdHzBPC9RTEGC0EM
	bjHuCmJ7NCF+SJdoi9cO44GGlhAqv+u6Qx04Z/ScIEbf8+y4EwpSD7rGmwHp+uyFd1Mnf6zwe6t6z
	B3pEbUxkZ6OYFm0xMNxSwRbLhafjAxSUHRmjfsUOXIadqe4qPb4v17tdmn5S6OL1yFHpTfBODxcap
	FFpqIXHMUIA9LhsHDLLjuww4c2l7WtK7YGYirQgSSm9WU+e2W42TM35cOC/w/paXToiO5ZufbVhGa
	XXMArKzg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWW-00000002PfF-0X1B;
	Fri, 31 Jul 2026 20:08:04 +0000
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
Subject: [PATCH v8 02/15] memory-failure: Prevent hugetlb freeing during unpoisoning
Date: Fri, 31 Jul 2026 21:07:47 +0100
Message-ID: <20260731200802.574821-3-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731200802.574821-1-willy@infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
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

