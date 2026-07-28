Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3D4749D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271490; cv=none; b=PPHWn3yqSoy1ibEnumESncx8Re2ryudIpu0K/JJGPgxnO/2+TLpxuKdH+mTgajp1K1PjiTFXWGQXxy9vr3+qcqtaLSDKfzSk/V20flwN6hoZ/vPn/mRC+GuGIt9ggK4V/Ke+VWydqa/RaiUxmcYirKgy+TzxOoCaj92wb/D6GuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271490; c=relaxed/simple;
	bh=OkvDMtuH7huFEoClGKgcaAjj4wMsCSZk0nFvFDspWQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=We9iLP1wpGsEzWasXnQqLOl/HuilUfnTmfjl5RLDt5bkD31NrnD3QwDtQpRrsCYvgLYYQI7fEh/gnDmzxT1Jh6HD8ghP6haipjw71jsfC5iDMJp4EydAxaUg8WdDRLzQM/1OwCpIrAWdClUvr/vc7ARi/GCmGU8FB/hM44RYn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dl+rfaiT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dl+rfaiT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zkJgvL5cRVJ0qHx2GRGP0XkrlNl3kn6ET+UT28ycGEc=; b=dl+rfaiTgRa+Fw10iqJ8SlPBV+
	+uS7QuxIDOODOnfQ0k8dNQBXp2V0V+nPHJrm3sYnB0vlXWTS/zedOsTV4QYxZuPC9qltb6QjYKTB0
	B2NIAhwnAMR0zD0EaKuLXGQBYJHDdPCR3evYB14ypswAqlDJoxX6rOgxkPE5cBT03K575TfUk/wqQ
	zuvzsSgUyiNTzkL1XWs2fCV0mBhV+rSc21/FMJdxiI7p+fdskwzSkq/iyulIgEd+xruRPqdqXEjg6
	GquWz1FAG5dwzXPzUXoL0xUL9bCNQQOqEJJ4MvgzKVVrphRkQ9RwClNLcNEbROvxDKxfIZz3lLEj7
	lV/PFBRg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooeo-0000000EFWN-2cqU;
	Tue, 28 Jul 2026 20:44:10 +0000
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
Subject: [PATCH v7 00/13] Use generic_file_read_iter() in hugetlbfs
Date: Tue, 28 Jul 2026 21:43:52 +0100
Message-ID: <20260728204409.3396238-1-willy@infradead.org>
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

v6 here:
https://lore.kernel.org/linux-mm/20260727181310.2671972-1-willy@infradead.org/

Changes from v6:
 - Add folio_clear_hugetlb() helper in hugetlb.c to make sure we move
   the hwpoison flag to individual pages before clearing the hugetlb
   page type.
 - Add missing spin_unlock in an unpoison_memory() error path.
 - Add some R-b tags

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (11):
  memory-failure: Fix hardware poison check in unpoison_memory() again
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  guest_memfd: Use folio_has_hwpoisoned_page()
  hugetlb: Move poison to pages before clearing hugetlb page type
  hugetlb: Use the has_hwpoisoned flag
  mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
  mm: Check individual hugetlb pages for poison
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  filemap: Add support for authoritative mappings

 fs/Kconfig                 |   2 +-
 fs/hugetlbfs/inode.c       | 123 +++--------------------
 include/linux/hugetlb.h    |  24 ++---
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
 16 files changed, 346 insertions(+), 263 deletions(-)

-- 
2.47.3

