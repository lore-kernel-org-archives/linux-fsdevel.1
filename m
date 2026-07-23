Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E142AFB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817053; cv=none; b=SCSUv472xIS0uzysBZ8A5zUseFXkTgY8idSqyE/GdFfRWDsdH7Bbo3Ccu1aqT6bDYT6SvYrL4ps1fi8o2qyYduRlqXfb5BWcmA4x5JgFXb95oUkY/XDheAyuFrOSHeAMf5CzlKEhxYm9eylj9o5hQxSNf4elkOn3HLUnZhtu1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817053; c=relaxed/simple;
	bh=zWWnk2ahsRmlcDQl6VX/ZfwP4ZFt21ab9AiuLQRPtww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwSJEqMfehzOPJHb9YoPjkTVGgx9MrhIjZnAO9JNaDH96wivhorBNCVILLe5qYXLnHCvl2NeW+7rCtBu5DTwV0NWBfRe66EF4vfX17tSgvoDB0C4+6RW/HWJTBj1c7V3fyCYaYAbEUrFHzarbQDRkfZUOUDf9vp0k7WKjcKDCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p0BjXa2k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p0BjXa2k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cwsU3Mhrg9KcuFxTAl0Tes+dvmZix99ipM91bAbmnN8=; b=p0BjXa2kEzvTX3Es+vq2+xSUBh
	yMDm18HK8DuM1ZL/O43br5EnYTlMFmswaGnixSTRvIi/62M74RVfGJJ9MsDxMkip/QR7Tp8I7vfBc
	LxJE0vnlOGEns0fF+c1/u9fRsr1Ggk+HbVb3G0Bu8s3cYjI/iNwLlJ3sryLtgIQElsveLp0mnzkEM
	BPja3cde6PwbqXTBCd1D7oVZi0/XcUN0Xl46EYds+Ku8Shi805YWRGTfwS2tJWW4XMEMXbFFJ9tAO
	Fwj1HMjKQgKOVIL8jeOcKtNkGeXb0Z1VB12O3FbmYm2Qk+NWe8HjWcMy+ARt+QRPjX4rFrxpUGpp2
	FBCiGZzg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRY-00000000jht-2pEi;
	Thu, 23 Jul 2026 14:30:36 +0000
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
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v4 03/14] mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
Date: Thu, 23 Jul 2026 15:30:20 +0100
Message-ID: <20260723143034.175661-4-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143034.175661-1-willy@infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a better name for this predicate.  Also make the argument const
to allow other callers to be made const.  No functional change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/page-flags.h | 4 ++--
 mm/huge_memory.c           | 2 +-
 mm/memory_hotplug.c        | 2 +-
 mm/shmem.c                 | 2 +-
 mm/vmscan.c                | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7223f6f4e2b4..4185a03a45cf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1083,10 +1083,10 @@ static inline bool is_page_hwpoison(const struct page *page)
 	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
 }
 
-static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
+static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
 {
 	return folio_test_hwpoison(folio) ||
-	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
+	       (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
 }
 
 bool is_free_buddy_page(const struct page *page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..353340309107 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4413,7 +4413,7 @@ static bool thp_underused(struct folio *folio)
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
-	if (folio_contain_hwpoisoned_page(folio))
+	if (folio_has_hwpoisoned_page(folio))
 		return false;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7ac19fab2263..33007e8e546a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1813,7 +1813,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (folio_test_large(folio))
 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
 
-		if (folio_contain_hwpoisoned_page(folio)) {
+		if (folio_has_hwpoisoned_page(folio)) {
 			/*
 			 * unmap_poisoned_folio() cannot handle large folios
 			 * in all cases yet.
diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..492c9bef3620 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3240,7 +3240,7 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	if (folio_contain_hwpoisoned_page(folio)) {
+	if (folio_has_hwpoisoned_page(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return -EIO;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35c3bb15ae96..70e54ace0e74 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1086,7 +1086,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (!folio_trylock(folio))
 			goto keep;
 
-		if (folio_contain_hwpoisoned_page(folio)) {
+		if (folio_has_hwpoisoned_page(folio)) {
 			/*
 			 * unmap_poisoned_folio() can't handle large
 			 * folio, just skip it. memory_failure() will
-- 
2.47.3

