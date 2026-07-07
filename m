Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E163AE195
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406566; cv=none; b=gyzTjkR46Wikyq3Ye/aEk9oE7kzh+MQzwB+W2ChAroWgwTcJJajy54rRGBCsGS3XYU3cHViaTFU0kBJPPTWMZxBiyrc2sIiY87QxOAWEzu0LjIy0oD5yuyx85J5CNauTjcpnxGge+7he92mkGw9mLEd2qUEMsbNZtglzq86mJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406566; c=relaxed/simple;
	bh=bACI+1p7dWUgOc9CiEORGW8gR6VAgYkgPmefTHvT2VA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dl21W6QKJ+fcpvlHVUYV4Qw4wEYfYiodqbZp1wbpQLJXrxytbqFuQvQ+CXQhJb+ZJV1eo4w1DnaK1b6T24s6uALcUcFWg/SRNd43gdR/Fs8wYB/qhHUKXdxjgutojxc+FAjpv4DBPFd+3ZYQzdJvfUDgCWBX/39Kk/abP7w/4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1dbaDFH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1dbaDFH"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84770f89b99so6203623b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783406564; x=1784011364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw6BVJ/QVNzRTvmuXXHDf40tgOrCadUtgbpK+Kq2rCY=;
        b=A1dbaDFHoahtc5Jvi4HGZMU8QxT2fQAh8e7cIP8xZAB14tOJyFMOP0F2CssDnEjgPu
         v+L+JiiR/6jsiSDJU4bhMjtWl4zuRg4/xY3xKC2/FWsBE5uBU4ORZru3qlyLk/Oaq6Bq
         ZGmmoWnOKDYPwvEeiUtD4BeHjQ0h1sEGdiYXmCQTBekIwDBLhx/YO21v5HWCiB4Ohvuh
         8IGy491nItv4NJASb0O50qyeRRi6VWM5LKDJV+LdrG7rpl7E+ZNtDEWuHoV2iQolz0Ov
         rdgWFG5AeLirYfol3depzhXBzLdC8ys0unjXQzxQj/xwPqahtRyAvnzyO02+ZKIIDe5A
         9Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406564; x=1784011364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw6BVJ/QVNzRTvmuXXHDf40tgOrCadUtgbpK+Kq2rCY=;
        b=G7w55Zw8lWq+8BCwx9jWrREKTm3wfbdhHtRSftbrXSAZ+DN1b1ovIxm81WdTaNBtgG
         b0I7sxqXoQcM5HuYPKMCt6ZkLliUj5ukw6JeJziULaDQKW2ZAre0w1I5d1qxlGyGl8Wk
         fNrBAVt5kesK8E01XF0kSjMz4TRxUa7dxKFJpVXRiDtrGPFikAXuIj74T444V9ywFRJO
         OvgkAxQc+i85MC6m3OOvOnMX0kxiQdb5FRMGbw2gvHTi2SVD6ox6UhOoTN5YGROt+aln
         ODghP+u7eAQo6klcIph2oksZa+YC+VuSVT0C6KvOBe/7wfsi4+70/LbsfJGAs2uzS1SV
         ghNA==
X-Forwarded-Encrypted: i=1; AHgh+RqNIAZQ144GBnHoi9bw3bvehGA6gq7qiUXpscFiX3QXgNSaA1XiZfEpV4zBsPNRYABnaw52QAHQoMCvSVVW@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlsd9msv7q7i/PB+4vrWbR2GHY9hyMmJz2QvPtktgyOAnEcSU
	yaXo9Hq2R3SHbXSfB/9ioUG/YOBO9zKKtA3VYjIOr9VRQBEgMJsF6JIOphSi24TAkQEzUhbsAnl
	TLfhZmoPuSuz2ORl3/84vP+1Q4w==
X-Received: from pfbbj20.prod.google.com ([2002:a05:6a00:3194:b0:847:74c2:35f5])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8085:b0:846:8b21:6304 with SMTP id d2e1a72fcca58-84826bb949bmr3922339b3a.14.1783406564179;
 Mon, 06 Jul 2026 23:42:44 -0700 (PDT)
Date: Tue,  7 Jul 2026 06:42:35 +0000
In-Reply-To: <20260707064235.1386552-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707064235.1386552-1-souravpanda@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707064235.1386552-7-souravpanda@google.com>
Subject: [PATCH 6/6] mm/hugetlb: support free page reporting for cached hugepages
From: Sourav Panda <souravpanda@google.com>
To: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org
Cc: david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mst@redhat.com, 
	mhklinux@outlook.com, souravpanda@google.com, fvdl@google.com, 
	gthelen@google.com, mike.kravetz@oracle.com, pasha.tatashin@soleen.com, 
	rientjes@google.com, riel@surriel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Implement free page reporting for the HugeTLB dynamic cache.

Register HugeTLB hstates with the page reporting framework if they
support caching.

When pages are added to the cache (either via recycling in
free_huge_folio or direct population via sysfs nr_cached_hugepages),
trigger a page reporting cycle.

Page reporting isolates pages from the cache list, reports them to the
hypervisor via virtio-balloon, and then drains them back to the cache
list, marking them as reported (HPG_reported).

If a page is allocated from the cache, or reclaimed, clear the reported
flag.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 include/linux/hugetlb.h        |  27 +++++++
 include/linux/page_reporting.h |   1 +
 mm/hugetlb.c                   | 125 +++++++++++++++++++++++++++++++++
 mm/page_reporting.c            |  10 ++-
 mm/page_reporting.h            |   6 ++
 5 files changed, 163 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e882c99780b6..bde23edcb803 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -587,6 +587,7 @@ enum hugetlb_page_flags {
 	HPG_cma,
 #ifdef CONFIG_HUGETLB_CACHE
 	HPG_cached,
+	HPG_reported,
 #endif
 	__NR_HPAGEFLAGS,
 };
@@ -650,10 +651,14 @@ HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
 HPAGEFLAG(Cma, cma)
 #ifdef CONFIG_HUGETLB_CACHE
 HPAGEFLAG(Cached, cached)
+HPAGEFLAG(Reported, reported)
 #else
 static inline bool folio_test_hugetlb_cached(const struct folio *folio) { return false; }
 static inline void folio_clear_hugetlb_cached(struct folio *folio) { }
 static inline void folio_set_hugetlb_cached(struct folio *folio) { }
+static inline bool folio_test_hugetlb_reported(const struct folio *folio) { return false; }
+static inline void folio_clear_hugetlb_reported(struct folio *folio) { }
+static inline void folio_set_hugetlb_reported(struct folio *folio) { }
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1093,6 +1098,20 @@ void hugetlb_unregister_node(struct node *node);
  */
 bool is_raw_hwpoison_page_in_hugepage(struct page *page);
 
+#ifdef CONFIG_HUGETLB_CACHE
+struct page_reporting_dev_info;
+int hugetlb_page_reporting(struct page_reporting_dev_info *prdev,
+			   struct scatterlist *sgl);
+#else /* !CONFIG_HUGETLB_CACHE */
+struct page_reporting_dev_info;
+struct scatterlist;
+static inline int hugetlb_page_reporting(struct page_reporting_dev_info *prdev,
+					 struct scatterlist *sgl)
+{
+	return 0;
+}
+#endif /* CONFIG_HUGETLB_CACHE */
+
 static inline unsigned long huge_page_mask_align(struct file *file)
 {
 	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
@@ -1311,6 +1330,14 @@ static inline bool hugetlbfs_pagecache_present(
 static inline void hugetlb_bootmem_alloc(void)
 {
 }
+
+struct page_reporting_dev_info;
+struct scatterlist;
+static inline int hugetlb_page_reporting(struct page_reporting_dev_info *prdev,
+					 struct scatterlist *sgl)
+{
+	return 0;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 9d4ca5c218a0..bd5a5a293dc3 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -27,4 +27,5 @@ struct page_reporting_dev_info {
 /* Tear-down and bring-up for page reporting devices */
 void page_reporting_unregister(struct page_reporting_dev_info *prdev);
 int page_reporting_register(struct page_reporting_dev_info *prdev);
+extern unsigned int page_reporting_order;
 #endif /*_LINUX_PAGE_REPORTING_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1bc0198a695c..110c566efc3b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -46,7 +46,9 @@
 #include <linux/io.h>
 #include <linux/node.h>
 #include <linux/page_owner.h>
+#include <linux/page_reporting.h>
 #include "internal.h"
+#include "page_reporting.h"
 #include "hugetlb_vmemmap.h"
 #include "hugetlb_cma.h"
 #include "hugetlb_internal.h"
@@ -1414,6 +1416,7 @@ static void hugetlb_cache_remove(struct hstate *h, struct folio *folio, bool to_
 	list_del_init(&folio->lru);
 	folio_clear_hugetlb_freed(folio);
 	folio_clear_hugetlb_cached(folio);
+	folio_clear_hugetlb_reported(folio);
 	h->nr_cached_hugepages--;
 	h->nr_cached_hugepages_node[nid]--;
 	if (to_surplus) {
@@ -1806,6 +1809,7 @@ void free_huge_folio(struct folio *folio)
 		    !folio_test_hwpoison(folio)) {
 			arch_clear_hugetlb_flags(folio);
 			hugetlb_cache_add(h, folio, true);
+			page_reporting_notify_free(h->order);
 			spin_unlock_irqrestore(&hugetlb_lock, flags);
 			return;
 		}
@@ -4231,6 +4235,7 @@ static int adjust_cached_huge_pages(struct hstate *h, long count, bool is_delta,
 			account_new_hugetlb_folio(h, folio);
 
 			hugetlb_cache_add(h, folio, false);
+			page_reporting_notify_free(h->order);
 			spin_unlock_irq(&hugetlb_lock);
 			cond_resched();
 		}
@@ -4310,6 +4315,7 @@ static int adjust_cached_huge_pages(struct hstate *h, long count, bool is_delta,
 			account_new_hugetlb_folio(h, folio);
 
 			hugetlb_cache_add(h, folio, false);
+			page_reporting_notify_free(h->order);
 			spin_unlock_irq(&hugetlb_lock);
 			cond_resched();
 		}
@@ -7763,3 +7769,122 @@ void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 	if (is_vm_hugetlb_page(vma))
 		clear_vma_resv_huge_pages(vma);
 }
+
+#ifdef CONFIG_HUGETLB_CACHE
+static void page_reporting_drain_hugetlb(struct hstate *h,
+					 struct scatterlist *sgl, unsigned int nents, bool reported)
+{
+	struct scatterlist *sg = sgl;
+	unsigned int left = nents;
+
+	spin_lock_irq(&hugetlb_lock);
+	do {
+		struct page *page = sg_page(sg);
+		struct folio *folio = page_folio(page);
+
+		hugetlb_cache_add(h, folio, false);
+
+		if (reported)
+			folio_set_hugetlb_reported(folio);
+	} while (--left && (sg = sg_next(sg)));
+	spin_unlock_irq(&hugetlb_lock);
+
+	sg_init_table(sgl, nents);
+}
+
+static int hugetlb_page_reporting_cycle(struct page_reporting_dev_info *prdev,
+					struct hstate *h, int nid,
+					struct scatterlist *sgl, unsigned int *offset)
+{
+	struct list_head *list = &h->hugepage_cache_lists[nid];
+	unsigned int page_len = huge_page_size(h);
+	struct folio *folio, *next;
+	long budget = 100; /* Limit */
+	int err = 0;
+
+	if (list_empty(list))
+		return err;
+
+	spin_lock_irq(&hugetlb_lock);
+
+	list_for_each_entry_safe(folio, next, list, lru) {
+		if (folio_test_hugetlb_reported(folio))
+			continue;
+
+		if (budget < 0) {
+			atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
+			break;
+		}
+
+		if (*offset) {
+			/* Isolate */
+			hugetlb_cache_remove(h, folio, false);
+
+			--(*offset);
+			sg_set_page(&sgl[*offset], &folio->page, page_len, 0);
+			continue;
+		}
+
+		spin_unlock_irq(&hugetlb_lock);
+
+		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
+		if (!err) {
+			pr_info("HugeTLB page reporting: reported %u pages of size %luKB\n",
+				PAGE_REPORTING_CAPACITY, huge_page_size(h) / 1024);
+		}
+
+		*offset = PAGE_REPORTING_CAPACITY;
+		budget--;
+
+		page_reporting_drain_hugetlb(h, sgl, PAGE_REPORTING_CAPACITY, !err);
+
+		spin_lock_irq(&hugetlb_lock);
+
+		if (list_empty(list))
+			break;
+		next = list_first_entry(list, struct folio, lru);
+
+		if (err)
+			break;
+	}
+
+	spin_unlock_irq(&hugetlb_lock);
+	return err;
+}
+
+int hugetlb_page_reporting(struct page_reporting_dev_info *prdev,
+			   struct scatterlist *sgl)
+{
+	struct hstate *h;
+	int err = 0;
+	int nid;
+
+	for_each_hstate(h) {
+		if (h->order < page_reporting_order)
+			continue;
+
+		for_each_online_node(nid) {
+			unsigned int offset = PAGE_REPORTING_CAPACITY;
+
+			err = hugetlb_page_reporting_cycle(prdev, h, nid, sgl, &offset);
+			if (err)
+				return err;
+
+			/* Report leftovers */
+			unsigned int leftover = PAGE_REPORTING_CAPACITY - offset;
+
+			if (leftover) {
+				struct scatterlist *sg = &sgl[offset];
+
+				err = prdev->report(prdev, sg, leftover);
+				page_reporting_drain_hugetlb(h, sg, leftover, !err);
+				if (err)
+					return err;
+				pr_info("HugeTLB page reporting: reported %u pages of size %luKB\n",
+					leftover, huge_page_size(h) / 1024);
+			}
+		}
+	}
+	return 0;
+}
+#endif
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 7418f2e500bb..882496b8b2c9 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -2,6 +2,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/page_reporting.h>
+#include <linux/hugetlb.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -50,12 +51,6 @@ EXPORT_SYMBOL_GPL(page_reporting_order);
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
-enum {
-	PAGE_REPORTING_IDLE = 0,
-	PAGE_REPORTING_REQUESTED,
-	PAGE_REPORTING_ACTIVE
-};
-
 /* request page reporting */
 static void
 __page_reporting_request(struct page_reporting_dev_info *prdev)
@@ -334,6 +329,9 @@ static void page_reporting_process(struct work_struct *work)
 			break;
 	}
 
+	if (!err)
+		err = hugetlb_page_reporting(prdev, sgl);
+
 	kfree(sgl);
 err_out:
 	/*
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index c51dbc228b94..74e05af4bac1 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -11,6 +11,12 @@
 #include <linux/scatterlist.h>
 
 #ifdef CONFIG_PAGE_REPORTING
+enum {
+	PAGE_REPORTING_IDLE = 0,
+	PAGE_REPORTING_REQUESTED,
+	PAGE_REPORTING_ACTIVE
+};
+
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 extern unsigned int page_reporting_order;
 void __page_reporting_notify(void);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

