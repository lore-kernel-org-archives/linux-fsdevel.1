Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EA4756A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271466; cv=none; b=Yod3baXrxtw1H0JBxCkPv+Czw2ChkDXb2tBTQrG2Y5DccGxDMkAMAF/hYGUg5xJlETKA7rdrF65lQyjepmd8WTXNUmohxpM4uNM1OiIaSpN2sCfVMbVWAG6obr9ZFt4a+7BFlW72xf5Z+WLNCmoOVH3X+GbcKiliEKDyuzI+Bi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271466; c=relaxed/simple;
	bh=cMU3iwUXmSzbVS+ztVnMfkIbWw4T+3xXuJerdXZHX8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm48FvqdynvldU4C+eOfwBNLzABwoUTTF2lcSR01HT1xHqBDccbWF2CNPO/9wuoFcvdCqIeLcK68EqR33WmZSwYm3nP6o4CqjKXGgrcYyQdXB7Wa1uOXtpJFYu/OvO9JCwUgo0pTFhs/vN8ABKZ6I4dfnC1VSd68Wpgul4KeJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ebFTlQJs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ebFTlQJs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YiJptwzuHVJ9HDL+jrIMqP8ge/TVdk1lJOQr0HqI1/Q=; b=ebFTlQJsaq7X5DMy6DIStSRYLi
	A+ci2DkHXQVWC1m5F6hsGPhujLv3iYgpN5gn0RpSJ+rsc4dZENyvmJDjvP3reCfwJS8iLzBrORwrv
	KaFi0mFouqOd7x0svNpiSFz6Gh6VSaBZ9QgW8DF81CRgM/J7j9XBrZycPZ5L1hwAe0kW8tVj4KUGq
	dELona07MqwrfOK1nhdLgBGvtuIxrY7GuRHY/xFfwPKjLK+xqXfk0taUodmBl07wL6+Vz4Vq/RKDn
	sMsUqYrO/Wf4SeV66zPvYr5y0WZV1hy6IrtvUvZWjR6eXyInIx3/w4RY6GH/r6m7JbSEebAJM6T1U
	ZqTH1eaw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooeq-0000000EFX3-2jpP;
	Tue, 28 Jul 2026 20:44:12 +0000
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
Subject: [PATCH v7 13/13] hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()
Date: Tue, 28 Jul 2026 21:44:05 +0100
Message-ID: <20260728204409.3396238-14-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728204409.3396238-1-willy@infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
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

