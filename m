Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636D32F76D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528504; cv=none; b=jB19TCUh27XUeH6dgPJlFYOHm0xuKK1W9i/LcJMI65cDGF73pAjVUkbulaFHbvOXpWUktdtBLtGmO5cAEPEIU8Ws88g5UWyn2uTeLyNjLQGcPv8/6A5MTbBZeYDsN8dh3w0Levh53UyaP0jd2RJViStCHT3GpuBF5X0CqngcoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528504; c=relaxed/simple;
	bh=QoqjI1CKmiGOwrtVOsEzOVgzcsJtLs5dldKJm6ykrSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fn1/mYsKEtDg+T1f+13pGVnE4KXHjNODvGiR/ZJNz2rP17fgsw1363qxv4P4T6CQefiOHH9t5UtioX/zv1J3TjlFkcTC/gS2PYTWEnLk5hwa8j02mQFxvSr0MjgCRUnNwmWfv+wc08PAuvw95l68eATQcoJOKJ0QViVL2lvLfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nBxlqtTP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBxlqtTP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=pfcGJd0Zogu5lBcBZbtpBfo+xRnEBjukcFUlsBluOJU=; b=nBxlqtTP27i8+63bzV0/yMQxEU
	7PK6NVE7qj4Rhqa+qiBgZlElQfCN8B9Z6SNEn4TwGrGzer2YSVE268m5b9EkKTbSKEZ4QGsyuD1xb
	CgNzUVAHyexiyvhwMgmMLwL6HJvS9FkTvl053rgVxriPGnyNCRmlPKSRqIIMW6NBPjA19G1ttbKyP
	b/uB6O6I1ytzJLim6X/nKrnUEy2s8G/Z1n5+vsCjLT8qCi+rpDAapdQ5cs2qKd82O3BEb8uxK3gnA
	a7zgd8Y8l9/FLopT96H2S5V9eC7uQVU6kacWh4pGcjfYfZqPPo9rkRaV1Yj8FbhmKc/7ZbVd/Amfd
	vA2CFmmg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWV-00000002Pen-3RaC;
	Fri, 31 Jul 2026 20:08:03 +0000
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
Subject: [PATCH v8 00/15] Use generic_file_read_iter() in hugetlbfs
Date: Fri, 31 Jul 2026 21:07:45 +0100
Message-ID: <20260731200802.574821-1-willy@infradead.org>
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

We need three things to use filemap_read_iter() instead of a hugetlbfs
specific read_iter: hwpoison handling, treating gaps in the pagecache as
holes, and having hugetlb set the folio size in the mapping.  hwopison
handling turned out to need a lot of prep work; the other two things
are fairly straightforward.

Sashiko complains that the implementation of AS_AUTHORITATIVE is
incomplete, but hugetlbfs doesn't use any of that functionality.
We'll add it when we need it, either when hugetlbfs uses it, or when we
convert shmem to use filemap.

v7 here:
https://lore.kernel.org/linux-mm/20260728204409.3396238-1-willy@infradead.org/

Changes from v7:
 - Split preventing freeing of a hugetlb folio into its own patch
 - Add hugetlb_lock_irq() abstraction to fix compile bug with HUGETLB disabled
 - Use is_page_poisoned() in kpageflags
 - Collect tags from various people

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (13):
  memory-failure: Fix hardware poison check in unpoison_memory() again
  memory-failure: Prevent hugetlb freeing during unpoisoning
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  guest_memfd: Use folio_has_hwpoisoned_page()
  kpageflags: Use is_page_hwpoison() to set KPF_HWPOISON
  hugetlb: Move poison to pages before clearing hugetlb page type
  hugetlb: Use the has_hwpoisoned flag
  mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
  mm: Check individual hugetlb pages for poison
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  filemap: Add support for authoritative mappings

 fs/Kconfig                 |   2 +-
 fs/hugetlbfs/inode.c       | 123 +++--------------------
 fs/proc/page.c             |   8 +-
 include/linux/hugetlb.h    |  43 +++++---
 include/linux/mm_types.h   |   4 +-
 include/linux/page-flags.h |  63 ++++++++++--
 include/linux/pagemap.h    |  45 +++++----
 mm/Kconfig                 |   6 +-
 mm/filemap.c               |  51 +++++++++-
 mm/huge_memory.c           |   2 +-
 mm/hugetlb.c               |  41 ++++----
 mm/memory-failure.c        | 197 +++++++++++++++++++++++++------------
 mm/memory_hotplug.c        |   2 +-
 mm/rmap.c                  |  43 +++++---
 mm/shmem.c                 |   2 +-
 mm/vmscan.c                |   2 +-
 virt/kvm/guest_memfd.c     |   2 +-
 17 files changed, 367 insertions(+), 269 deletions(-)

-- 
2.47.3

