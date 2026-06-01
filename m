Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603732ED27;
	Mon,  1 Jun 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293491; cv=none; b=LvjLe6vbK9QxiwVH1Pr9wngnNk5qR1wKYYTpOMYRqx34FpBkz3gpDJNW5i1Wq2NudyPGemlP/jBXT7yOCstk/1H06iIbxP+sUyrdZqOtuZpfdvi4+JbyZ/T+spOLqe3Y0Tpz9WQco1hxEP2iky9Ad+bK24N3vU6Nd2CphEQkTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293491; c=relaxed/simple;
	bh=j43uHXa6eXfEW8A4IsZeegZRPNbSqERL6PtFpiBJVBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFWFlQwg8vAL588t1Sr/pRfHVTnodEnmK+5B7H5JZ5SxtoU1j8d/nnMY7Y747ZENSt6i7gXnhLPa2KkKKQePPvZvOd9acSSdzECR5t9Jj5wO5snSVzSoCoMikcM73QTXtj8CC7/tJgcRRPIvKKGfa4itFVQ3xAudgOuitZDZg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ND7AD0lX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ND7AD0lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9+
	6KLnho3oezstBwK6DjSQ5GUBc1NeDmONzGfJ6sfTU=; b=ND7AD0lX3Pw6CblwZR
	ne7nKzAjfBi6+VNGaDazXYvQ2e/OV8wq2YI/gr5wnKvO6Deoxmyw3RcL9CDvKEAY
	984cD5HEAgPcOEsRcoNUG8NGtOJuupYBnu2HaWK4sNYfs4QWdZfkn+5SZra5iJFa
	QicBpYy42Xf5N6kzCLl4Rhsa4=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_7Q6Hx1qsb0MAw--.47504S6;
	Mon, 01 Jun 2026 13:57:22 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 4/5] mm/shmem: remove page-copy fallback in shmem read path
Date: Mon,  1 Jun 2026 13:57:03 +0800
Message-ID: <20260601055704.167436-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601055704.167436-1-chizhiling@163.com>
References: <20260601055704.167436-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_7Q6Hx1qsb0MAw--.47504S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1DWF1xCFW7Kr17Wr17ZFb_yoWrCw4xpF
	W3KasIyrWxJw43Gr17JFs8Za4rK3s3JFWUJFyfG3WfA3Z3tryrKFyUta4F9FWfJ34UC3WI
	gw4qyr1UWa1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeE_NUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AK5V2odH0JEmQAA3j

From: Chi Zhiling <chizhiling@kylinos.cn>

This is perp patch for folio batch support which removing the fallback
to page-copy mode from shmem reads.

The existing hwpoison fallback would require fetching the same folio
multiple times to read its each pages, which complicates the
batching model. Instead, move hwpoison handling into
copy_each_pages_to_iter(), allowing the error path to be centralized.

This simplifies the shmem fast read path and avoids special-case
handling that conflicts with folio batching support.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/shmem.c | 63 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b08118fbd275..cac355685e49 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3353,6 +3353,30 @@ static size_t copy_zero_to_iter(size_t bytes, struct iov_iter *i)
 	return written;
 }
 
+static size_t copy_pages_to_iter(struct folio *folio, size_t offset,
+		size_t bytes, struct iov_iter *i, int *error)
+{
+	struct page *page;
+	unsigned long off, nr, ret, written = 0;
+
+	do {
+		page = folio_page(folio, offset >> PAGE_SHIFT);
+		if (PageHWPoison(page)) {
+			*error = -EIO;
+			break;
+		}
+
+		off = offset_in_page(offset);
+		nr = min(PAGE_SIZE - off, bytes - written);
+
+		ret = copy_page_to_iter(page, off, nr, i);
+		offset += ret;
+		written += ret;
+	} while (written < bytes && ret == nr);
+
+	return written;
+}
+
 static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -3365,10 +3389,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	for (;;) {
 		struct folio *folio = NULL;
-		struct page *page = NULL;
 		unsigned long nr, ret;
 		loff_t end_offset, i_size = i_size_read(inode);
-		bool fallback_page_copy = false;
 		size_t fsize;
 
 		if (unlikely(iocb->ki_pos >= i_size))
@@ -3376,25 +3398,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		index = iocb->ki_pos >> PAGE_SHIFT;
 		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
+		if (folio)
+			folio_unlock(folio);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
 			break;
 		}
-		if (folio) {
-			folio_unlock(folio);
-
-			page = folio_file_page(folio, index);
-			if (PageHWPoison(page)) {
-				folio_put(folio);
-				error = -EIO;
-				break;
-			}
-
-			if (folio_test_large(folio) &&
-			    folio_test_has_hwpoisoned(folio))
-				fallback_page_copy = true;
-		}
 
 		/*
 		 * We must evaluate after, since reads (unlike writes)
@@ -3406,12 +3416,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				folio_put(folio);
 			break;
 		}
-		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
-		if (folio && likely(!fallback_page_copy))
-			fsize = folio_size(folio);
-		else
-			fsize = PAGE_SIZE;
+		fsize = folio ? folio_size(folio) : PAGE_SIZE;
 		offset = iocb->ki_pos & (fsize - 1);
+		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
 		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
 
 		if (folio) {
@@ -3420,12 +3427,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (mapping_writably_mapped(mapping)) {
-				if (likely(!fallback_page_copy))
-					flush_dcache_folio(folio);
-				else
-					flush_dcache_page(page);
-			}
+			if (mapping_writably_mapped(mapping))
+				flush_dcache_folio(folio);
 
 			/*
 			 * Mark the folio accessed if we read the beginning.
@@ -3436,10 +3439,10 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * Ok, we have the page, and it's up-to-date, so
 			 * now we can copy it to user space...
 			 */
-			if (likely(!fallback_page_copy))
+			if (likely(!folio_contain_hwpoisoned_page(folio)))
 				ret = copy_folio_to_iter(folio, offset, nr, to);
 			else
-				ret = copy_page_to_iter(page, offset, nr, to);
+				ret = copy_pages_to_iter(folio, offset, nr, to, &error);
 			folio_put(folio);
 		} else if (user_backed_iter(to)) {
 			/*
@@ -3462,6 +3465,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		if (!iov_iter_count(to))
 			break;
+		if (unlikely(error))
+			break;
 		if (ret < nr) {
 			error = -EFAULT;
 			break;
-- 
2.43.0

