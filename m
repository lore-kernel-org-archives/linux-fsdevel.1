Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D73345CA5;
	Mon,  1 Jun 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293494; cv=none; b=tHS3xVgMFimyTt+1+RGxGNg7hdOYM+IiRqPwTobXiP5GQYAtkTYCf2xL0kNozpYT5dWlyOE4vqisIWSBJCOwSEDwYJh3/PCINRUF8AK1PsqDsVds0HebzD3lOO5yl5oNDPkZfYsyMWcoBJtNPZZT8ywW7IiZGmCXQ3qffcMOrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293494; c=relaxed/simple;
	bh=Posza5aSe4A/ZDQYZQwTpCrA94Vi1sSARixQYgqr0RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3VdPtAdxluMxECAGeyq84j1HU9KFmJyupVOiS8GpI27Uo79GXe16HuUmEAnWc5B0/+6w7FQr3LZOsJb0x83C6OrewAOiZJ/X+wJ2Ipvp+Ha2R6i/yzSo/HJPjYTBZysz6slUcmUVnB0HH05H6gRzS4ybVE2crOXYhO3MGjsfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BvOaqovQ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BvOaqovQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=uD
	FqU2w9pHRcm8QTKIbB6nvNnwHJfSBH479J/vtIl7g=; b=BvOaqovQ3mE7YeTvEm
	gYj756jset545UWabWC0ifzfxwm6IYv7JKAQM/28XgmBs/VEo4LD0uJXLrTp/UUp
	mKnKyZeI49ZYbFSsOKunpFrwGO5dGqrJa1tNPg6/NcS38JtNUPA/7uq74CzckZrS
	U53BRo2AJFTM9E26kwN0iPxEg=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_7Q6Hx1qsb0MAw--.47504S7;
	Mon, 01 Jun 2026 13:57:23 +0800 (CST)
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
Subject: [PATCH v2 5/5] mm/shmem: optimize file read with folio batching
Date: Mon,  1 Jun 2026 13:57:04 +0800
Message-ID: <20260601055704.167436-6-chizhiling@163.com>
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
X-CM-TRANSID:_____wD3_7Q6Hx1qsb0MAw--.47504S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1xKF18Gr1rAFWUuFy3Jwb_yoWrZr17pF
	W3KasxKrZ7G3y3Wr1fJF18Z3WrK3sayFW5Ja4fG3W3A3W5Jas8KF1xt34YgFW5JrZrC3WI
	gw1vkr1UW3WjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeuWdUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wO5V2odH0Nu4gAA3R

From: Chi Zhiling <chizhiling@kylinos.cn>

Optimize shmem file read by using filemap_get_folios_contig() to batch
fetch contiguous folios from the page cache, reducing the overhead of
repeated shmem_get_folio() calls.

This patch checks the uptodate flag without holding the folio lock, so
it may observe a non-uptodate state on a locked folio that is still
being initialized. This is safe because only zero-filled data can be
copied to the user buffer in that scenario.

A non-uptodate folio in the swap cache cannot be added to the shmem page
cache. This creates a semantic conflict, as shmem zeroes the folio out,
but the swap cache would fill it by reading from the swap backing store.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/shmem.c | 57 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index cac355685e49..61937582f08c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -891,6 +891,14 @@ int shmem_add_to_page_cache(struct folio *folio,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
 
+	/*
+	 * Don't add a non-uptodate folio that is in swap cache to page
+	 * cache, since shmem will zero it instead of reading from swap
+	 * backing.
+	 */
+	VM_BUG_ON_FOLIO(folio_test_swapcache(folio) &&
+			!folio_test_uptodate(folio), folio);
+
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
 	folio->index = index;
@@ -3382,11 +3390,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t index;
+	struct folio_batch fbatch;
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
 
+	folio_batch_init(&fbatch);
+
 	for (;;) {
 		struct folio *folio = NULL;
 		unsigned long nr, ret;
@@ -3395,15 +3405,33 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		if (unlikely(iocb->ki_pos >= i_size))
 			break;
+fetch:
+		folio = folio_batch_next(&fbatch);
+		if (!folio) {
+			pgoff_t start = iocb->ki_pos >> PAGE_SHIFT;
+			pgoff_t end = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;
+
+			if (folio_batch_count(&fbatch)) {
+				for (int i = 0; i < folio_batch_count(&fbatch); i++)
+					folio_put(fbatch.folios[i]);
+				folio_batch_reinit(&fbatch);
+			}
 
-		index = iocb->ki_pos >> PAGE_SHIFT;
-		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
-		if (folio)
-			folio_unlock(folio);
-		if (error) {
-			if (error == -EINVAL)
-				error = 0;
-			break;
+			filemap_get_folios_contig(inode->i_mapping, &start, end, &fbatch);
+			if (folio_batch_count(&fbatch))
+				goto fetch;
+
+			error = shmem_get_folio(inode, start, 0, &folio, SGP_READ);
+			if (unlikely(error)) {
+				if (error == -EINVAL)
+					error = 0;
+				break;
+			}
+			if (folio) {
+				folio_unlock(folio);
+				folio_batch_add(&fbatch, folio);
+				fbatch.i++;
+			}
 		}
 
 		/*
@@ -3411,17 +3439,15 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		 * are called without i_rwsem protection against truncate
 		 */
 		i_size = i_size_read(inode);
-		if (unlikely(iocb->ki_pos >= i_size)) {
-			if (folio)
-				folio_put(folio);
+		if (unlikely(iocb->ki_pos >= i_size))
 			break;
-		}
+
 		fsize = folio ? folio_size(folio) : PAGE_SIZE;
 		offset = iocb->ki_pos & (fsize - 1);
 		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
 		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
 
-		if (folio) {
+		if (folio && folio_test_uptodate(folio)) {
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
@@ -3443,7 +3469,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				ret = copy_folio_to_iter(folio, offset, nr, to);
 			else
 				ret = copy_pages_to_iter(folio, offset, nr, to, &error);
-			folio_put(folio);
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
@@ -3474,6 +3499,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		cond_resched();
 	}
 
+	for (int i = 0; i < folio_batch_count(&fbatch); i++)
+		folio_put(fbatch.folios[i]);
 	file_accessed(file);
 	return retval ? retval : error;
 }
-- 
2.43.0

