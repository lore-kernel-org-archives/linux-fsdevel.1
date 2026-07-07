Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB33AB28E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406561; cv=none; b=GzsHFTAe2k98cCgD2USWxPm7hTFvCaKMWMJGEePyHTfNO2McumvAgGIPMKWNBJa5kfghjzhT3GkPoBpbN9XJfEbOzlE4goOT6ZUFyo1A75MeLJOuVcUQYRUV20bG3+GRCiq9hDmK4wZuX/Y/Qbn19SLNUuRTWCUQ9MTCyOc/GGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406561; c=relaxed/simple;
	bh=FfLOofdQ6pJgqD1a5mL+lGAGtlmF6Myh0B9T0zRtyYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eDMQpD8ESn0plaPZBA2OC69HFfrbeEdq+EVD8a3a+53K6iCwAS13UZTnIPjZIUPnAVuRFjjzTn9B9DDXJ6u4K8UsW1QrV3lpSS/NhEj4VF/GxURVYn5HSePgpXGlGYdO/J73MCjR3S5isFuPAhVvuq0RIUmNiMRmT+3gNhJSaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9LSvjo/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9LSvjo/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso3371537a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783406558; x=1784011358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3/6FtQizBI37BpPuKE5LV5SzdpXotLVZrr6UgpgZPY=;
        b=V9LSvjo/3ayu2tOo+35eTB6VMxUmK+rptHbf7XKUecF3izWbIcARIFoG8G94I1MuYo
         bLuBIdKK6G4kTAri2ywx2AAgbARze7ygWFZlJEhhcEd+klxnHXidOyZF6BnJCqnESN4W
         ZnoKFz6kjXnqlZ60dMAXV0DXyfopycpr3AUaEYzW0CkW62q5EDqRRFillfEM88j6yn2L
         LJLAIPe9Ou2ySRpiyYcrLb2hocODT1fyAovaH6qRdk//wGavcZOcf6HKBtHp8s/nlQDY
         IWqP6/MACFOpbM++fX0V8dDM3F3SztmkDmcwS23OWbTuA7HPk5y5COlqe3/HWUafmTPY
         Tc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406558; x=1784011358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3/6FtQizBI37BpPuKE5LV5SzdpXotLVZrr6UgpgZPY=;
        b=nR602/XdFlvJElryZkKfN1j4vyehmub91Fbu521hl+upqUJmo4H9EIrrMVAseyVDHU
         vl4/SHSaPIvaHTsJtgU8LR4R3dLJjeCQZnxSuLxVayj8H2sl1P/Cxdux2xkyQsqxpmBX
         RCGgg/ec8nJPLTsUjCNLE7EQgYJA8l5rGRrYauQt1MSyz7EH6v8J7lcS9WhQRlpa0DZm
         mwkbaAgwAcWoEfJYzErrQ9Qt1ZzzsjpgbL0xiiq9jD5XghOcmsmWmKk3cZ/ljYLQGbnD
         9OCJ9pvfAh3557bFzdygm30W4wb8DdnvC1CH5ZQ9SaEYufc1aJNcUyejpCVAjsJ3dESK
         JqUw==
X-Forwarded-Encrypted: i=1; AHgh+RqYcNsaXB3jNSvbMzFhSW64ptdObE296NY3c0cENed90ddfILTWo1ey0TDx83xFej5zYTC8xrRwP005gPQC@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzipDPy4nJWsTTeanWU+5Zpk1A02Nijd4omcs6kbF/tX879Ce
	akhMpHCexy71DxOEFt+zD7ONc8iKr1TUSaMn/QyW55yslFY9GoIEYjEn84OoLI2iKlT4QWJwRtY
	EgIM3U9eGLacGEVm8B2zAaQxL8A==
X-Received: from plba2.prod.google.com ([2002:a17:903:1002:b0:2ca:f1f8:e9f8])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc5:b0:37f:9ce0:af36 with SMTP id 98e67ed59e1d1-38757c78e6dmr4191418a91.33.1783406558283;
 Mon, 06 Jul 2026 23:42:38 -0700 (PDT)
Date: Tue,  7 Jul 2026 06:42:31 +0000
In-Reply-To: <20260707064235.1386552-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707064235.1386552-1-souravpanda@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707064235.1386552-3-souravpanda@google.com>
Subject: [PATCH 2/6] mm/hugetlb: implement cache recycling and allocation
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

Implement the core recycling and allocation logic for the HugeTLB dynamic
cache.

Recycle surplus hugepages in free_huge_folio() up to max_cached_huge_pages.
Allocate from the cache in alloc_surplus_hugetlb_folio() if pages are
available.

To ensure safety and architecture correctness:
- Skip recycling of hardware-poisoned pages in free_huge_folio() and
  skip poisoned pages in the cache during allocation.
- Call arch_clear_hugetlb_flags() before caching a page to clear stale
  architecture-specific metadata (e.g. ARM64 MTE tags, dcache dirty).
- Use MRU (Most Recently Used) policy for allocation (taking from the
  tail of the cache list) to prefer hot pages.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 include/linux/hugetlb.h |  4 +++
 mm/hugetlb.c            | 76 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4768f52ddd35..e882c99780b6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -650,6 +650,10 @@ HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
 HPAGEFLAG(Cma, cma)
 #ifdef CONFIG_HUGETLB_CACHE
 HPAGEFLAG(Cached, cached)
+#else
+static inline bool folio_test_hugetlb_cached(const struct folio *folio) { return false; }
+static inline void folio_clear_hugetlb_cached(struct folio *folio) { }
+static inline void folio_set_hugetlb_cached(struct folio *folio) { }
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 15be3cf54606..d00aa67b8e13 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -125,6 +125,11 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
+#ifdef CONFIG_HUGETLB_CACHE
+static void hugetlb_cache_add(struct hstate *h, struct folio *folio, bool from_surplus);
+static void hugetlb_cache_remove(struct hstate *h, struct folio *folio, bool to_surplus);
+#endif
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -1796,6 +1801,15 @@ void free_huge_folio(struct folio *folio)
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_hugetlb_folio(h, folio, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
+#ifdef CONFIG_HUGETLB_CACHE
+		if (h->nr_cached_hugepages < h->max_cached_huge_pages &&
+		    !folio_test_hwpoison(folio)) {
+			arch_clear_hugetlb_flags(folio);
+			hugetlb_cache_add(h, folio, true);
+			spin_unlock_irqrestore(&hugetlb_lock, flags);
+			return;
+		}
+#endif
 		/* remove the page from active list */
 		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
@@ -2035,8 +2049,14 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
 		struct hstate *h = folio_hstate(folio);
 		bool adjust_surplus = false;
 
-		if (!available_huge_pages(h))
+		if (!available_huge_pages(h) && !folio_test_hugetlb_cached(folio))
+			goto out;
+
+		/* If the folio is currently isolated for page reporting, skip it */
+		if (folio_test_hugetlb_cached(folio) && list_empty(&folio->lru)) {
+			rc = -EBUSY;
 			goto out;
+		}
 
 		/*
 		 * We should make sure that the page is already on the free list
@@ -2128,6 +2148,50 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn, unsigned long end_pfn)
 	return rc;
 }
 
+#ifdef CONFIG_HUGETLB_CACHE
+static struct folio *get_cached_folio(struct hstate *h, int nid, nodemask_t *nmask)
+{
+	int node;
+	struct folio *folio;
+
+	if (h->nr_cached_hugepages == 0)
+		return NULL;
+
+	if (nid != NUMA_NO_NODE && (!nmask || node_isset(nid, *nmask))) {
+		list_for_each_entry_reverse(folio, &h->hugepage_cache_lists[nid], lru) {
+			if (!folio_test_hwpoison(folio))
+				goto found;
+		}
+	}
+
+	if (nmask) {
+		for_each_node_mask(node, *nmask) {
+			list_for_each_entry_reverse(folio, &h->hugepage_cache_lists[node], lru) {
+				if (!folio_test_hwpoison(folio))
+					goto found;
+			}
+		}
+	} else {
+		for_each_node_state(node, N_MEMORY) {
+			list_for_each_entry_reverse(folio, &h->hugepage_cache_lists[node], lru) {
+				if (!folio_test_hwpoison(folio))
+					goto found;
+			}
+		}
+	}
+	return NULL;
+
+found:
+	hugetlb_cache_remove(h, folio, true);
+	return folio;
+}
+#else
+static inline struct folio *get_cached_folio(struct hstate *h, int nid, nodemask_t *nmask)
+{
+	return NULL;
+}
+#endif
+
 /*
  * Allocates a fresh surplus page from the page allocator.
  */
@@ -2136,10 +2200,16 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 {
 	struct folio *folio = NULL;
 
+	spin_lock_irq(&hugetlb_lock);
+	folio = get_cached_folio(h, nid, nmask);
+	if (folio) {
+		spin_unlock_irq(&hugetlb_lock);
+		return folio;
+	}
+
 	if (hstate_is_gigantic_no_runtime(h))
-		return NULL;
+		goto out_unlock;
 
-	spin_lock_irq(&hugetlb_lock);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

