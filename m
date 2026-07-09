Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2443B8D70
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622878; cv=none; b=nMMEAsfZafg5I+p/YT1qHfV6XdSY4T6ekBFPBp70mpWMAGZPOPAfph/QW1xSZEwlk4ytY0BYwx/B0oPRGN6xSytZSK7Q1zWqAlU1MJX7Qg5IMm3rjJGtRYkOxkx3nyG0OdgH+Nk+yJiR20+b7t8YoS3yzCpiJ9NJH5bETNVpGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622878; c=relaxed/simple;
	bh=8yp0puiSlOvP+Dj8zMKMa8JLMEE8gQiLDQIxK46Gplg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuKR+0WoadhHktFk7hNXuFX3S8Gjcp+iWsT7oV/WBoXvkvz4obS3yHj7Zk5YpnzjG/Hk7/WV4o3dUNKO5lIBuhwhOT1PSW70aoRKQAnwOqjVNFvFa318yE0g0wBuj43D81qrNsN4xfHBH/7c6SI2fHGUCWHPtLUAJM+RNeqpMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MtyA5ZeV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MtyA5ZeV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XL9R1G3dyEaarb6lw/J5PyiVcp4sbNIv8CdXMAaDtfk=; b=MtyA5ZeVXBoOI9psFl/B6HoT/N
	V01G58BuNmT8GstWVG1FiMNABoQol2IzmRPjkGijyG8Lm3fko6OZIeiSvHRklLpQNr37tgXpRdnA4
	b+Zy16wA1dpzOswIq4OZ1wBMAuV53brj/gSlxHZWgXdtmqLBLGOl45XulW/IlWimg/Sl9B6lpANr4
	3ds6DlXcaCTRml1eITRAeCSzg/Zh7piv9JImW6YReDeiGGpIeJLLzboH288qk+pKzIsPJsIVDgSQG
	HULkwx79D2q9XdIumJ76OW/tDTn8l4oFeikaxUTN073NQ5tNBln6Q9Lr+nYMx39JlpvxL6lwM87DQ
	+o52shXg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtmg-00000005OhL-3lje;
	Thu, 09 Jul 2026 18:47:42 +0000
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
	Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
Date: Thu,  9 Jul 2026 19:47:34 +0100
Message-ID: <20260709184740.1286561-7-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709184740.1286561-1-willy@infradead.org>
References: <20260709184740.1286561-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most accesses to the raw_hwp_page list are protected by mf_mutex.
However, the call to folio_clear_hugetlb_hwpoison() in mm/hugetlb.c
does not.  This is probably OK today as this is in the freeing path and
I think all current calls to is_raw_hwpoison_page_in_hugepage() hold a
reference to the folio.  However, the next patch will call this function
without holding a reference on the folio, which will expose this race.

Rename the current folio_clear_hugetlb_hwpoison() to
__folio_clear_hugetlb_hwpoison() and wrap it with a new
folio_clear_hugetlb_hwpoison() for the benefit of external callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 53063e2a1f97..353288cce1b2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1935,7 +1935,7 @@ static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	return __folio_free_raw_hwp(folio, move_flag);
 }
 
-void folio_clear_hugetlb_hwpoison(struct folio *folio)
+static void __folio_clear_hugetlb_hwpoison(struct folio *folio)
 {
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
@@ -1945,6 +1945,13 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 	folio_free_raw_hwp(folio, true);
 }
 
+void folio_clear_hugetlb_hwpoison(struct folio *folio)
+{
+	mutex_lock(&mf_mutex);
+	__folio_clear_hugetlb_hwpoison(folio);
+	mutex_unlock(&mf_mutex);
+}
+
 static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				 bool *migratable_cleared)
 {
@@ -2051,7 +2058,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
 	folio_lock(folio);
 
 	if (hwpoison_filter(p)) {
-		folio_clear_hugetlb_hwpoison(folio);
+		__folio_clear_hugetlb_hwpoison(folio);
 		if (migratable_cleared)
 			folio_set_hugetlb_migratable(folio);
 		folio_unlock(folio);
-- 
2.47.3

