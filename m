Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E138E8D5
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995262; cv=none; b=uFM/PhA/dz0+oB5PutCuNW4HTCBQoj12li8HWd6kj0/hAs3wGgYhE0Tq7qrrjxsKS4WHqxWiBn6+nekP4LAK+Yg3mIWM3nlVie+/iPHDMxgzGVp8y/iVqPFXleuXhy00s3K9hrZVrpQREvgt5kAdytCPDmf+XQDwUn9SrWB0TiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995262; c=relaxed/simple;
	bh=2fIX/85D+hzx3jTRC3BR6fq0y+avPg6SEGS8l68L4Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tjmbzud+yFWykBUcleAiPZA4DiYee7+VwQmCC0FProQvQptXaYJq6kRcpwJuF03woFP3h6j1YQMm5wQE8nQlYMhzFAnKPC3SKGfQ6Gp3hElYVtVyu41Y/42ec5Cvkf+lKnONWbHBFztVtGsSa8Jyojgjd0U/ByqGSvhzrtaF/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IiU4gVgB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IiU4gVgB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=r0YooHR0oUdoStXTpiZOrGMf2KhFuxnhMN59+dhjZGM=; b=IiU4gVgBH/eoIMXPP1PKoA/BUZ
	qxNvdTWqGVlJrIKHWZsO3UVrxsGGiKqTR3Wjn4m/YJwgLCuziBYc9fweBJ47p3TZC5GT1qM+dYGL9
	sqBM3ErDnaPlLXEwKc0lQroA9vkzvTTPFSv3tP33s6oCUBiWQCMZ3m33c9VzG1rqW7yBIxmhSM23H
	DjkfeQSSMbAavDkDnrlSIWxibJP1fZvareh8eF+DAp15cF2YCuSCq1yQ8tQ7l+R+s/IsPpMiB1LDe
	HNXn/J2NoZW2qGh6xO3ycWy2sl/jdv8tOPeQrHDWzB8fZYrEBti58LbiZJwhK2pos7FJdNrvWAj2T
	XZAAssKg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnenr-00000006X7O-17aY;
	Sat, 25 Jul 2026 16:00:43 +0000
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
Subject: [PATCH v5 00/12] Use generic_file_read_iter() in hugetlbfs
Date: Sat, 25 Jul 2026 17:00:28 +0100
Message-ID: <20260725160042.1557264-1-willy@infradead.org>
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

v4 here:
https://lore.kernel.org/all/20260723143034.175661-1-willy@infradead.org/

Changes from v4:
 - Drop patch "Test the page is hwpoison before taking the mutex".
   It's not necessary for this series, and Sashiko points out a bad
   possibility.
 - Fix try_to_unmap() checking of HWPoison for hugetlb folios
 - Protect the folio->hugetlb_hwpoison list with its own spinlock
 - Fold the "Remove raw_hwp_list_head" patch into the "Remove locking
   mf_mutex in is_raw_hwpoison_page_in_hugepage" patch
 - Make folio_test_huge_poison() always false if CONFIG_MEMORY_FAILURE not set
 - Fix CONFIG_FILEMAP_LARGE_FOLIO -> CONFIG_LARGE_FOLIO conversion
 - Fix hugetlb_clear_poison() to clear has_hwpoisoned last
 - Add tags from Ackerley & Sean for guest_memfd patch

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (10):
  memory-failure: Fix hardware poison check in unpoison_memory() again
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  guest_memfd: Use folio_has_hwpoisoned_page()
  hugetlb: Use the has_hwpoisoned flag
  mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
  mm: Check individual hugetlb pages for poison
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  filemap: Add support for authoritative mappings

 fs/Kconfig                 |   2 +-
 fs/hugetlbfs/inode.c       | 123 +++---------------------
 include/linux/hugetlb.h    |  24 ++---
 include/linux/mm_types.h   |   4 +-
 include/linux/page-flags.h |  63 +++++++++++--
 include/linux/pagemap.h    |  45 +++++----
 mm/Kconfig                 |   6 +-
 mm/filemap.c               |  51 +++++++++-
 mm/huge_memory.c           |   2 +-
 mm/hugetlb.c               |  16 ++--
 mm/memory-failure.c        | 186 ++++++++++++++++++++++++-------------
 mm/memory_hotplug.c        |   2 +-
 mm/rmap.c                  |  43 +++++----
 mm/shmem.c                 |   2 +-
 mm/vmscan.c                |   2 +-
 virt/kvm/guest_memfd.c     |   2 +-
 16 files changed, 321 insertions(+), 252 deletions(-)

-- 
2.47.3

