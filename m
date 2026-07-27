Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F323536B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176019; cv=none; b=IbJRhGqVE1EOWtvlRLRy6grFbnZ0AZJyTik18NDm1L2natYFYZzjGNathftje1Yo94XNfM0eB83nLmYeB+/u94u9mIpKg4R7/2ShzKmDkL/+jcqx2CBv2ztwXkGZ288VPnBq6Xo49ttC4lX0JgoYUMrpHhEEskV/TX0beJNw1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176019; c=relaxed/simple;
	bh=cMU3iwUXmSzbVS+ztVnMfkIbWw4T+3xXuJerdXZHX8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxKYM+ADV/05xHdtRRLa6oGLXmg9kdXkGPrIAgIi+m3bX4//9P2iV0orzqU5ly/z0TlVLn3zhZMDPbOMWLodWdTO0fttyFidbLKbHFKZCgHC1RjY3b3y8EKMMGqvQy34S5EzTXCU/9aaxLsYNCnsok2mcRpCRiUrCyFtSLN9zqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aGYXYXsf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aGYXYXsf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YiJptwzuHVJ9HDL+jrIMqP8ge/TVdk1lJOQr0HqI1/Q=; b=aGYXYXsfARgJbvYzf3mIsd/A3/
	1U66Jfu2m6Bx0sw6dmtlTZygBYgyyDO+3nl7aXsKfxaFopykjnhhlcO9xGpclUWgGBTpw2kC5lVxN
	uxSikTqaWvlodigfEVSWPVLpfOwjicgCKIkVqJgnT5riiyxYhLL0x8JXpzXRgB/ztcnyReoNCypui
	L/PG+DgYmGNhxj5WOilAxtF7XCJFNfpZAn69cOkHmTzj4zx6Jno1RigPB8ySOSMglrktnjloqX7i0
	OBDdyH77IyiHs7f1ghCQCvmk5dz/9JO0FUHoNpWW0Kj+HDg4gQ7YxIGyXjt+dCDbFUBRqiM4xmxbW
	WdgBZ6QA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPpB-0000000BD7k-0ddm;
	Mon, 27 Jul 2026 18:13:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v6 12/12] hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()
Date: Mon, 27 Jul 2026 19:13:08 +0100
Message-ID: <20260727181310.2671972-13-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727181310.2671972-1-willy@infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jane Chu <jane.chu@oracle.com>

generic_file_read_iter() now handles hugetlb poison, hugetlb page
size and missing folios correctly, so we no longer need a separate
hugetlbfs_read_iter().

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c | 110 +------------------------------------------
 1 file changed, 2 insertions(+), 108 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 8d15413a67ee..cef7e61b827d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -187,113 +187,6 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	return mm_get_unmapped_area_vmflags(file, addr0, len, pgoff, flags, 0);
 }
 
-/*
- * Someone wants to read @bytes from a HWPOISON hugetlb @folio from @offset.
- * Returns the maximum number of bytes one can read without touching the 1st raw
- * HWPOISON page.
- */
-static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
-		size_t bytes)
-{
-	struct page *page = folio_page(folio, offset / PAGE_SIZE);
-	size_t safe_bytes;
-
-	if (hugetlb_page_hwpoison(folio, page))
-		return 0;
-	/* Safe to read the remaining bytes in this page. */
-	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
-	page++;
-
-	/* Check each remaining page as long as we are not done yet. */
-	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
-		if (hugetlb_page_hwpoison(folio, page))
-			break;
-
-	return min(safe_bytes, bytes);
-}
-
-/*
- * Support for read() - Find the page attached to f_mapping and copy out the
- * data. This provides functionality similar to filemap_read().
- */
-static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
-{
-	struct file *file = iocb->ki_filp;
-	struct hstate *h = hstate_file(file);
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	unsigned long index = iocb->ki_pos >> huge_page_shift(h);
-	unsigned long offset = iocb->ki_pos & ~huge_page_mask(h);
-	unsigned long end_index;
-	loff_t isize;
-	ssize_t retval = 0;
-
-	while (iov_iter_count(to)) {
-		struct folio *folio;
-		size_t nr, copied, want;
-
-		/* nr is the maximum number of bytes to copy from this page */
-		nr = huge_page_size(h);
-		isize = i_size_read(inode);
-		if (!isize)
-			break;
-		end_index = (isize - 1) >> huge_page_shift(h);
-		if (index > end_index)
-			break;
-		if (index == end_index) {
-			nr = ((isize - 1) & ~huge_page_mask(h)) + 1;
-			if (nr <= offset)
-				break;
-		}
-		nr = nr - offset;
-
-		/* Find the folio */
-		folio = filemap_lock_hugetlb_folio(h, mapping, index);
-		if (IS_ERR(folio)) {
-			/*
-			 * We have a HOLE, zero out the user-buffer for the
-			 * length of the hole or request.
-			 */
-			copied = iov_iter_zero(nr, to);
-		} else {
-			folio_unlock(folio);
-
-			if (!folio_test_has_hwpoisoned(folio))
-				want = nr;
-			else {
-				/*
-				 * Adjust how many bytes safe to read without
-				 * touching the 1st raw HWPOISON page after
-				 * offset.
-				 */
-				want = adjust_range_hwpoison(folio, offset, nr);
-				if (want == 0) {
-					folio_put(folio);
-					retval = -EIO;
-					break;
-				}
-			}
-
-			/*
-			 * We have the folio, copy it to user space buffer.
-			 */
-			copied = copy_folio_to_iter(folio, offset, want, to);
-			folio_put(folio);
-		}
-		offset += copied;
-		retval += copied;
-		if (copied != nr && iov_iter_count(to)) {
-			if (!retval)
-				retval = -EFAULT;
-			break;
-		}
-		index += offset >> huge_page_shift(h);
-		offset &= ~huge_page_mask(h);
-	}
-	iocb->ki_pos = ((loff_t)index << huge_page_shift(h)) + offset;
-	return retval;
-}
-
 static int hugetlbfs_write_begin(const struct kiocb *iocb,
 			struct address_space *mapping,
 			loff_t pos, unsigned len,
@@ -891,6 +784,7 @@ static void hugetlbfs_init_regular_inode(struct inode *inode)
 	inode->i_op = &hugetlbfs_inode_operations;
 	inode->i_fop = &hugetlbfs_file_operations;
 	mapping_set_folio_order_range(inode->i_mapping, order, order);
+	mapping_set_authoritative(inode->i_mapping);
 }
 
 /*
@@ -1215,7 +1109,7 @@ static void init_once(void *foo)
 }
 
 static const struct file_operations hugetlbfs_file_operations = {
-	.read_iter		= hugetlbfs_read_iter,
+	.read_iter		= generic_file_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
-- 
2.47.3

