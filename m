Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581F45A2BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817073; cv=none; b=KljSOFTFOKyV1yyIEAkNG3RYiZQG/Tor8/785INqDO5jxbvvViFkw1j/oalS/NdIA8eWTKJ4j8RNW+emHvRHtIT93EO1FErc2FfEcVkqozptSXh+EAAQ2/UuDgf5e9Dg4Wd+LaS/tuhJIqHwADrVzZodZKcThMj9Vh0+UAfx8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817073; c=relaxed/simple;
	bh=Fsw9XjjiDTu4zEfxfwen45eIvVCiLssIXrZdDkJC/dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7YO5+pNxGx8Q+JRI2y61SwgIs1ZfP53jXv7U8ZBFFIViZzvug4/0Bi8PTEgXuBJ9D2aHi2jN4+pDfL9i14DoXuRpSkCQhGIoMj+O1aWXhnxgBktiL1SBn1Squh0vuUpTs2Ypg8fytF7vX+zJZ+Q6OYIIV6QG6YuaStXoUbZeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uBy4itk1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBy4itk1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=010wDpCrLd3D32pyHmx+75SFv1G0aLKQNuZGYw4i5+M=; b=uBy4itk1n3e7Lkx6cb5SDL32sp
	LcADm4P9fz5I9zbs/4rvqcP7lMQzRs65RVu91befmKCIU9NYda/XoXkcEKmcQe3pokk6zHb9qHWsh
	z4/CVMRVILANqMMj2vOje7//9sDQNe4qRJNUH8FPSgDaoj11U5O2cj954q/KA9zTMKqF+3WOPwGle
	UNS6Q/prVtBenR+Y1FMIMbEBjUkqjw9w8N9ZIE8CpcwkvB7cKb8Zk3Hm8U1flvaDHS9fs9oMjS1E4
	pjeqtQ+hAeECvKR04915iEpQRxTTkmwUfuiiXcck2CZRyOj28yHsbcefQFOYiUdF/VYjQKMCBoVca
	tNDQ0EFA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRY-00000000jhl-0K9s;
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
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v4 00/14] Use generic_file_read_iter() in hugetlbfs
Date: Thu, 23 Jul 2026 15:30:17 +0100
Message-ID: <20260723143034.175661-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches are separated out from Jane's earlier series.
https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/

I've made a lot of changes over the last week; mostly with regard to
hwpoison handling of hugetlb memory.  Thanks to Miaohe Lin for
suggesting using the hugetlb_lock to stablise the hugetlb folio.

v3 here:
https://lore.kernel.org/linux-mm/20260714180840.3731244-1-willy@infradead.org/

Changes from v3:
 - Fix unpoisoning a hugetlb folio
 - Went back to hugetlb_hwpoison in the folio instead of having a global
   list of poisoned pages
 - Rename CONFIG_FILEMAP_LARGE_FOLIO to CONFIG_LARGE_FOLIO
 - Added missing call to mapping_set_authoritative()
 - Fixed polarity of check in mapping_set_folio_order_range()
 - Added is_ref_page_hwpoison() so we don't need to do the extra work
   of handling an unreferenced folio
 - Use the has_hwpoisoned() flag for hugetlb as well as THP
 - Added folio_set_huge_poison() so we can detect unreferenced
   hwpoisoned hugetlb folios reliably

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (12):
  memory-failure: Fix hardware poison check in unpoison_memory() again
  memory-failure: Test the page is hwpoison before taking the mutex
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  guest_memfd: Use folio_has_hwpoisoned_page()
  memory-failure: Remove raw_hwp_list_head()
  hugetlb: Use the has_hwpoisoned flag
  mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
  mm: Check individual hugetlb pages for poison
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  filemap: Add support for authoritative mappings

 fs/Kconfig                 |   2 +-
 fs/hugetlbfs/inode.c       | 123 ++++---------------------------
 include/linux/hugetlb.h    |  24 +++---
 include/linux/mm_types.h   |   4 +-
 include/linux/page-flags.h |  59 ++++++++++++---
 include/linux/pagemap.h    |  45 +++++++-----
 mm/Kconfig                 |   6 +-
 mm/filemap.c               |  51 ++++++++++++-
 mm/huge_memory.c           |   2 +-
 mm/hugetlb.c               |  16 ++--
 mm/memory-failure.c        | 146 +++++++++++++++++++++++--------------
 mm/memory_hotplug.c        |   2 +-
 mm/shmem.c                 |   2 +-
 mm/vmscan.c                |   2 +-
 virt/kvm/guest_memfd.c     |   2 +-
 15 files changed, 258 insertions(+), 228 deletions(-)

-- 
2.47.3

