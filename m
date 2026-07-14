Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCD32ED54
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052542; cv=none; b=FgND/GOJ5CTJi4d8ScmG3gLGEpkx2N0Btd04GgbbsBb70Iqxx5+qdR8NmSM8JXgPKMvurHlF5eChGEtOVBSv+E73wtfhgsMcIpFhxuSHII7o+Cy67HfgmwUIZboDxMI2ogCkERRV1Z5LMKIGoWl71YdEY7dGE/BiHrJx2TKDfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052542; c=relaxed/simple;
	bh=71rh2Zhtjfm5cR9tzf5OIAjNi3Zq+HH8TUiAL4XuBMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wu5XNSOAJpeDoLD5HUmqKXE6rBtdrsIl+oWJS7ZcBHjp4mQfQrFtb8d++O8Srlt12viXXhHX3IyJZ5Fyj1pVfERZ8O7xxZL/uu/5j1pVmbKsZBR2pJxRgRcPIudtAChXFVAg4UgwZcFyl7/KNBRuBBBliQ5wZf7Q6l98dAq4fnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q3B9eheO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q3B9eheO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9lX01UwLV7UAXCKe79JoK7OX7vyBJAoMehKWTs9zGjE=; b=Q3B9eheO9hBpEJSLxvfbrZwdd8
	2lR4t/cZ3h+MB0UgrmT0ErbhHru3FHk+5P1tyTgFCe76wfXPPWl/k2F2VZV4Fw9PF/rIOhQAehMrk
	NT2/QVIS/rLDrjyWAEFBtg+bp4mc0NAj3cUK/T7BcTeXfYUt2KRkYwLBdsUk0cEWw72S9wj++6oFD
	Nr+YUvX1Kce6Hg8MFXYjqrXnOyU59xi+sJsqxJCmMxhIMWGgI827Vx9VsWInhE8XobP5AFtTy4nrc
	XJlIro1AluTcgCf192CiblhBz4GnzVHz8W+o8lrlvPErQUl1D01bpVMeGXr6Wp/B1Oi0cGbkgZa//
	ed1E3gBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjhYg-0000000FegN-2K3I;
	Tue, 14 Jul 2026 18:08:42 +0000
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
Subject: [PATCH v3 0/9] Use generic_file_read_iter() in hugetlbfs
Date: Tue, 14 Jul 2026 19:08:30 +0100
Message-ID: <20260714180840.3731244-1-willy@infradead.org>
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

There's enough potentially controversial things in here that I think
it's worth considering them by themselves.  First, handling hwpoison
in filemap_read().  I want this for shmem as well as for hugetlbfs (a
later patchset, maybe).  Second, handling misses in the pagecache as
holes rather than opportunities to populate the pagecache.

Sashiko review of v2 here: 
https://sashiko.dev/#/patchset/20260709184740.1286561-1-willy%40infradead.org

Changes:
 - Introduce CONFIG_FILEMAP_LARGE_FOLIO
 - Reordered the patches to do all the hwpoison handling first
 - Picked up Usama's Acked-by on a couple of patches
 - Rewrote handling of hugetlb hwpoison completely
 - Return -EIO instead of -EFAULT when a read touches a hwpoison page
 - Add a call to mapping_set_authoritative() in hugetlbfs

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (7):
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  memory-failure: Track hugetlb poison in a hash table
  mm: Handle hugetlb correctly in is_page_hwpoison()
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  filemap: Add support for authoritative mappings

 fs/Kconfig                 |   1 +
 fs/hugetlbfs/inode.c       | 122 ++++---------------------------------
 include/linux/hugetlb.h    |  24 +++-----
 include/linux/mm_types.h   |   2 -
 include/linux/page-flags.h |  28 ++++++---
 include/linux/pagemap.h    |  45 ++++++++------
 mm/Kconfig                 |   4 ++
 mm/filemap.c               |  51 +++++++++++++++-
 mm/huge_memory.c           |   2 +-
 mm/hugetlb.c               |   2 +-
 mm/memory-failure.c        |  80 ++++++++++++------------
 mm/memory_hotplug.c        |   2 +-
 mm/shmem.c                 |   2 +-
 mm/vmscan.c                |   2 +-
 14 files changed, 167 insertions(+), 200 deletions(-)

-- 
2.47.3

