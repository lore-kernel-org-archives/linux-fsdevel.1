Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A03E168C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963972; cv=none; b=g+J7UZp7M6NQJCMJgqepgwpCg6PKso2yZ6ivdKD77GW809ghLNGNHdEm5v3WF3nPcQBKNgf2psK7pJ0eCT6msqOOklnAxILsCrWksKhaG4KyqExnvUcyOuAASAUxKVkZsd2KNOocs1eNRtndkttRLUyjJ3DtDbc1y1kIXgfcpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963972; c=relaxed/simple;
	bh=WQSYqmfOnmYJa/HiP2ZNCXgVNXO63USpy4V9S4heZUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5MhSJd2juMq5uaRDXWdTd75uek/R0x6U7xsLaDpyV6qiRuAJn4kA7bq5ScPrh0fYPGg8HePxJM5q7SPdxntYF55+o9EhEEzG8O49rGO+3vOeEMpywSWxdxrz27PEwTYfnpFw+XlX4O6xGRAnJmiBrelUeZ6vjllTb2WVaBgebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IfEARI/z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfEARI/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=mBAMuD0vGLB0sX/9Wbvb9nt9t7JYO00L3Qa101+B9rM=; b=IfEARI/zxUvMlo88rH2Rh62LB0
	9pGDfqLmf565OLeyt/5BU+1etI4kKoPVoBZxEs78sIpNNZt1g/PAnA4qiuoYM8GE67TirUhahem2G
	UOmPWVBgby8oi9qpWR5T197QjHb/XrEUT/wa2S9KRAvfMtFW3CWU/Hs0tcQvIZj1AoUm6SAQe5QyZ
	NZQfyQwXUB+9qnIviULYkE3pNKytQmCBEJj7hziA9gGkrX12rTZ5NbnO/YhtH5oIKGZkogiBEzwPJ
	oH10aVn7XB3Ay2kVA6+X4oEhURApPRpUo42jUSYu6ZWeptJL73QtZnLifg0bj6KlBWtpzKR5twBST
	0HBCdl9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrioJ-00000004h63-0SM8;
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
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v9 00/15] Use generic_file_read_iter() in hugetlbfs
Date: Wed,  5 Aug 2026 22:05:40 +0100
Message-ID: <20260805210557.1118966-1-willy@infradead.org>
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

v8 here:
https://lore.kernel.org/linux-mm/20260731200802.574821-1-willy@infradead.org/

Changes from v7:
 - Fix the KPF_HWPOISON blooper
 - Expand HVO in a comment
 - Collect R-b tags from Gregory & Jane

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
 include/linux/page-flags.h |  64 ++++++++++--
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
 17 files changed, 368 insertions(+), 269 deletions(-)

-- 
2.47.3

