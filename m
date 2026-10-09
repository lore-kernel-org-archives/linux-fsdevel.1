Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347634CFC6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564927; cv=none; b=X1Zhl7FRnhkHDfp5yeze1g26YhojdFH2yCae9AdZ5eNJearcQOGT3f/+ZRrH4UIoRH1phmvRLFuIPoeHS8zxN45zJ2K2I/b9JCJsRnhFRkJ7dzriKV9YTDQg6GpaYCmgz8YIBqA8pV1Pi1mrtoed275T5i9Zx5wbQEfHHBk7WxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564927; c=relaxed/simple;
	bh=dMl+CoA/VqFNozNyfVRSenSOBFt7x9PjXLXUSJc3TIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcH2vnslK2Ujmqaoe431FSeSXbUzJj06zk+JSeSJcW3z8BbIZzLS8A/CXJ1IQZRws7G+V326zKGM6C+XXgRWDTE/54O3fsITY3LSzgac0AwRFlD0Ejrgi7AswsIfIH7AKwgH1TczzNUshcVR8j0nbchSVg2op8zWMm3edFetf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hk9gKhlv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hk9gKhlv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=sJ0QLUJbB8GL4J29eH2wQvGHtd7BOI8S/MTobEfkKmI=; b=Hk9gKhlv3kRasCsAQqRe9ihI/A
	tihmh+XcPPf5skvCU90zcg+vVoJCXAi/QawwTRCUO23Knxcym7+M3kx9zsxEhWQ0jqv5t15tIUWUT
	veqipLMPv61Z6I3c7Q95qO+NPL/fsIumgTzWL7ay9SUgkb8WNLw9Nq5k8PV94su4Vkdknj27czkxY
	nZTpB9XG1L9KYjD/28X6niwBR03olcMrpDbUXFOxsZ7avSspDS61xr3TBhywQlRO5ebzJw1tQP/ud
	uzWpr6ijEyUZmoBuSbvJJhL4avWYadCkzj29/odoaKNEgGnJC8dCKP7ACkkiTykKJMK8mEmHaa6AI
	gPpzB1cw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDsN-0000000GDDG-25Wb;
	Fri, 09 Oct 2026 16:55:19 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Tal Zussman <tz2294@columbia.edu>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: [RFC PATCH 0/2] Removing add_to_page_cache_lru()
Date: Fri,  9 Oct 2026 17:55:10 +0100
Message-ID: <20261009165518.3863950-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the build bots actually test NOMMU, they'll blow up on this.
I'm looking for human feedback on how best to proceed with removing
the last user of add_to_page_cache_lru().  Assuming that ramfs-nommu is
a useful tool to have around (and Daniel recently sent a patch to it,
so that seems like a good assumption).

Since there's no MMU, if we want to be able to mmap a file, we have to
allocate all the memory for the file contiguously.  Right now, we do
that by allocating a high-order, non-compound page, calling split_page()
and adding the resulting pages to the page cache one at a time.

This patch uses folio_split() instead.  This uses the generic
huge_memory code which will happily drop the pages which are past i_size.
Unfortunately, we currently have to select TRANSPARENT_HUGEPAGE on NOMMU
which feels really weird.

I have a patch to add CONFIG_LARGE_FOLIO, selected by TRANSPARENT_HUGEPAGE
and HUGETLBFS_PAGE, but it's buried in the hugetlb-hwpoisn patch series.
And it doesn't actually split apart the large folio code from the
THP code.  But it'd be a start, and we could finish that work off later.

What do people think?  Is that the right path forward?

Matthew Wilcox (Oracle) (2):
  ramfs: Use filemap_add_folio() on nommu systems
  mm: Remove add_to_page_cache_lru()

 fs/ramfs/file-nommu.c   | 53 +++++++++++++----------------------------
 include/linux/pagemap.h |  2 --
 mm/folio-compat.c       |  7 ------
 3 files changed, 17 insertions(+), 45 deletions(-)

-- 
2.47.3

