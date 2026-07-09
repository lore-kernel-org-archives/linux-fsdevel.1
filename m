Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDF3C3458
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622896; cv=none; b=K8y7MPoaff/n2ks8tz1o+8iRXYdctnAXcz6OLOIWtfrPmKn1IXDbXReXA4OQSQwMqaOuMnNW33GiDADeUqX8f79KbbtFIn3WD1pHgn76P9efuVg1kE34WHp77aKD7sPqN9wiA0dmhbKYlo/bLTQFrWrRj7BdVWNNZTSZ6Jw0sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622896; c=relaxed/simple;
	bh=0takknVpbv6eKl/Di9EMt/HX4aw3+XDSeR0v8UJC1H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNHZBvpueRquueQn9Yl/RUvJl69QIMNgbELKTmY1w34LVMR2jv5liGurVHs3StkwZQX8xmp9OIDW6VFhL8wyTDeDluNr59EAF4HLEM2zSxWVjzkbbuAFVI5bE2pIL398oZI1tLoHfZALAvcyqgQt/cYLs6L/2gbYXiAJIKYt5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BRu1AQYd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BRu1AQYd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6DkfM0ynaDTwpMKXO2jTjsFjcq8c046BhsnBelGIuf8=; b=BRu1AQYdLlfhUAtc4vKYCvLVJp
	Rj0eZ2FVn9YbIqQUDCQFd1O9FjxTcQ/UcUG5PsFMZ+d630tg2ROSE6CfBs/Au5ctjnlmHw4QuhHQ1
	hgzVNcr9L/lqtgzlIUB7b7hZCI7r8s9V1Il8nps+xV1FkzI4I/sa8IRAxBcB7Bm/DH5KgRaJiG9Eq
	nGD8efn30vfM/eqoyre+tfKvSKCfmcwiM0aIIxDjzecUhWds23MoXd2DyKVx9Cw7Z1QRkQ+qDMZvh
	1qh1OSs2CU5sS1w4JRbTh+SuXLM/tksILwxQCT2aVQkoD0RYu/BAShdoMclsYdmEIYb0RDz+A8bdY
	xpf34lMA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtmg-00000005Oh9-0kjm;
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
Subject: [PATCH v2 00/10] Use generic_file_read_iter() in hugetlbfs
Date: Thu,  9 Jul 2026 19:47:28 +0100
Message-ID: <20260709184740.1286561-1-willy@infradead.org>
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

v1 here: https://lore.kernel.org/linux-mm/20260707181713.208282-1-willy@infradead.org/
Sashiko had a lot of valuable feedback on that, and that's all addressed
here except for the things that I don't think are relevant.

Jane Chu (2):
  filemap: Add hwpoison handling to filemap_read()
  hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()

Matthew Wilcox (Oracle) (8):
  mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
  hugetlb: Mark some function arguments as const
  filemap: Remove checks in mapping_set_folio_order_range()
  hugetlb: Set mapping folio order
  memory-failure: Remove raw_hwp_list_head()
  memory-failure: Prevent UAF in raw_hwp_page list
  mm: Handle hugetlb correctly in is_page_hwpoison()
  filemap: Add support for authoritative mappings

 fs/hugetlbfs/inode.c       | 122 ++++---------------------------------
 include/linux/hugetlb.h    |  24 +++-----
 include/linux/mm_types.h   |   4 +-
 include/linux/page-flags.h |  28 ++++++---
 include/linux/pagemap.h    |  32 +++++-----
 mm/filemap.c               |  46 +++++++++++++-
 mm/huge_memory.c           |   2 +-
 mm/hugetlb.c               |   2 +-
 mm/memory-failure.c        |  39 ++++++------
 mm/memory_hotplug.c        |   2 +-
 mm/shmem.c                 |   2 +-
 mm/vmscan.c                |   2 +-
 12 files changed, 128 insertions(+), 177 deletions(-)

-- 
2.47.3

