Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51617C203;
	Fri, 19 Jun 2026 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868562; cv=none; b=hSTI/9rQMAJNndo8gRH4jiGmXT8Y3Nf98S2VJagctinz32QottCMA9pD/1L3NjtCONognxAWnF9+DNCAkBGVaTCnLPKWLj8iH6EE8OQFjDomwp4Gm4o/nLxgVENaIh5OkgfahQ1t2TfBPh671pUWx7x3o5H98SbOXmxvvSzZp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868562; c=relaxed/simple;
	bh=XsME9557hSExWe97v9dfcEs0s0Jj+li+DyhcNO1hZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/IJNfqIXEXUVjgWZXMTh6U061GaWW5abvJrWbl3l3j5+THv2hTEbvIIhCeeJRdl63aKjd66lfR3Cy+ZvNyerKIIOrMUwia9SyQ/juckGSM8nuzz/5VPAgCP2YY7d4+XNoySbZXSCoa83Hm4QjnjAgBxMbzGh4eZz3w5ZI3h/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SelOo/Ad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SelOo/Ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE461F00A3A;
	Fri, 19 Jun 2026 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781868561;
	bh=XVCrf8HvVxE+bRl5h9tNkVxezrW+pDd7ettEGUKaEVs=;
	h=From:To:Cc:Subject:Date;
	b=SelOo/AdQuAQPpsjvtqYcU4+edYFOmKso1hIFDz4VNHx0xcz2YLDyxMzuy36UTYU7
	 ENjCp3PtBoSHMEdo7smxnYERQDVeRrS13nOai9nzAmb4fEDkkH6O8Go2jwieye0Qzv
	 tPhKNfA4mesrHRIIbGo3wT7kBFqhyLMhjJR4qtgqdcK8jjy6LrQPOOv3IfH41VmbDZ
	 5eZ0oVfoxFlkBuz8jNUbeXrU6sg+jOtFhIIsS+QwJJuvlRNuWbuRtATJTjfiwkro3Q
	 84Nr695J9D5QR1MQ2TxrUO4txh6pKyGZB+uDwv2+EoqlhfgWAPB/kPlo/CIw9TD8cf
	 uCFBIYIdZPl9w==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frederick Mayle <fmayle@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to VMA boundaries"
Date: Fri, 19 Jun 2026 12:28:51 +0100
Message-ID: <20260619112852.104213-1-ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.

This patch caused a significant performance regression, so revert it, and
we can determine whether the approach is sensible or not moving forwards,
and if so how to avoid this.

There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
PG_readahead on EOF"), care was taken to ensure that the revert retained the
behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
filemap_fault readahead to VMA boundaries") only.

Fixes: 7b32f64bc512 ("mm: limit filemap_fault readahead to VMA boundaries")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202606181547.617a6967-lkp@intel.com
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/pagemap.h | 2 --
 mm/filemap.c            | 4 ----
 mm/readahead.c          | 6 +-----
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 627771e82eb1..2c3718d592d6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1348,7 +1348,6 @@ struct readahead_control {
 	struct file_ra_state *ra;
 /* private: use the readahead_* accessors instead */
 	pgoff_t _index;
-	pgoff_t _max_index; /* limit readahead to _max_index, inclusive */
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
 	bool dropbehind;
@@ -1362,7 +1361,6 @@ struct readahead_control {
 		.mapping = m,						\
 		.ra = r,						\
 		._index = i,						\
-		._max_index = ULONG_MAX,				\
 	}

 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
diff --git a/mm/filemap.c b/mm/filemap.c
index dc3a0e960b9f..17a64837597c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3312,8 +3312,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned int thp_order = 0;
 	unsigned short mmap_miss;

-	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
-
 	/* Use the readahead code, even if readahead is disabled */
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
 		/*
@@ -3409,7 +3407,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * mmap read-around
 		 */
 		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
-		ra->start = max(ra->start, vmf->vma->vm_pgoff);
 		ra->size = ra->ra_pages;
 		ra->async_size = ra->ra_pages / 4;
 		ra->order = 0;
@@ -3457,7 +3454,6 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	}

 	if (folio_test_readahead(folio)) {
-		ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_ra(&ractl, folio, ra->ra_pages);
 	}
diff --git a/mm/readahead.c b/mm/readahead.c
index 38ce16e3fcbd..558c92957518 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -335,8 +335,6 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 		return;

 	end_index = (isize - 1) >> PAGE_SHIFT;
-	if (end_index > ractl->_max_index)
-		end_index = ractl->_max_index;
 	if (index > end_index)
 		return;
 	/* Don't read past the page containing the last byte of the file */
@@ -487,7 +485,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
 	unsigned int min_order = mapping_min_folio_order(mapping);
-	pgoff_t limit;
+	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark;
 	unsigned int nofs;
 	int err = 0;
@@ -500,8 +498,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		goto fallback;
 	}

-	limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
-	limit = min(limit, ractl->_max_index);
 	if (limit > index + ra->size - 1) {
 		limit = index + ra->size - 1;
 		mark = index + ra->size - ra->async_size;
--
2.54.0
