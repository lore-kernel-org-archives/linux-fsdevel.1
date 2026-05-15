Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42443D4EC;
	Fri, 15 May 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838520; cv=none; b=up0YhkviDC6UsX0EM38L3nq3+cX+nfk+HTDBuPk2uZm4Hn5SJGJWi1D1oSEKHO9HyzXKpNNVPjoW+TR9WNiewdHdYzjEqhM95IWxHoPUOX5goFjEJM0RTWxcpLYbLBTEpwzi//I9xMqjcSUa3GaAPMVYUflgqJKPSQXCoC+F4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838520; c=relaxed/simple;
	bh=99KWN40sl8xDbpH9FMFsdsJAphPitUxrXoKeVFzgbhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkxIdy0KwozN+K6RRrAIgyLHSrfqjPwzHIvJzQDA0YQNqbFmbcjGstwcwKyKeaIfVn5ce7D/BU8rOdCJmRg7rw0DbaNAZwQuaTD3xbRibKHKuMSpulWT0/pLOrRuLrTv/eQt4S2CusOvKgcZ5kcj1DyLE3pvwkXXfLkwWWwPiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G15ZBj01; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G15ZBj01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x1
	ch1LMRZ8v16TQ/TGRFBp+464EezxW+tb87/9Sva4E=; b=G15ZBj01k81TcQUSs0
	3m3R/MrQfVi/YrxYMDFwaXQ3HGMNWCJG2D9HuyzGaKEdO4LG59WXiZVLgz2wJ0cl
	f7GoyiIKBpZRqsS3hLdmf9JOv763sgYA9MA15aroJoU/bLkMTgO8oUzzavq2n2RB
	VYfSarMnHTyYRgBhW46HDGjEo=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnVxek6wZq6RobBg--.38248S5;
	Fri, 15 May 2026 17:47:19 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 3/4] mm/shmem: optimize file read with folio batching
Date: Fri, 15 May 2026 17:47:01 +0800
Message-ID: <20260515094702.1092355-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515094702.1092355-1-chizhiling@163.com>
References: <20260515094702.1092355-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVxek6wZq6RobBg--.38248S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1xtr18Gr4rAry5trWxXrb_yoWrtF15pF
	WUK3ZIqrWxGr43ur4fJFWkZa4rK392qrW5JayxG3W3Z3W5J3Z0kF18t34YvFW5ArW5C3WI
	g3WFk3W8W3Wjyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLWrXUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wdA3WoG66dn2wAA3x

From: Chi Zhiling <chizhiling@kylinos.cn>

Optimize shmem file read by implementing folio batching in the read
iteration path. Only uptodate folios are added to the batch, ensuring
all folios in the batch are valid and ready for use without additional
checking.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/shmem.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 767610f78d0d..4bc4e463ca97 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3348,16 +3348,100 @@ shmem_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	return copied;
 }
 
+static pgoff_t shmem_get_read_batch(struct address_space *mapping,
+		pgoff_t index, pgoff_t max, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	struct folio *folio;
+	pgoff_t end = max;
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, max) {
+		if (xas_retry(&xas, folio))
+			continue;
+		if (xa_is_value(folio)) {
+			end = xas.xa_index;
+			break;
+		}
+		if (!folio_try_get(folio))
+			goto retry;
+
+		if (unlikely(folio != xas_reload(&xas)))
+			goto put_folio;
+
+		end = folio_next_index(folio);
+
+		if (!folio_test_uptodate(folio)) {
+			xas_advance(&xas, end - 1);
+			folio_put(folio);
+			continue;
+		}
+		if (!folio_batch_add(fbatch, folio))
+			break;
+		xas_advance(&xas, end - 1);
+		continue;
+put_folio:
+		folio_put(folio);
+retry:
+		xas_reset(&xas);
+	}
+	rcu_read_unlock();
+
+	return end;
+}
+
+static inline int shmem_get_folio_from_batch(struct inode *inode,
+		pgoff_t index, pgoff_t last_index, struct folio **folio,
+		struct folio_batch *fbatch, pgoff_t *batch_end)
+{
+	struct folio *next;
+	int error;
+
+	if (*batch_end > index) {
+retry:
+		next = folio_batch_next(fbatch);
+		if (next) {
+			if (next->index > index) {
+				next = NULL;
+				fbatch->i--;	/* revert folio_batch_next */
+			}
+		}
+		*folio = next;
+		return 0;
+	}
+
+	for (int i = 0; i < folio_batch_count(fbatch); i++)
+		folio_put(fbatch->folios[i]);
+	folio_batch_init(fbatch);
+
+	*batch_end = shmem_get_read_batch(inode->i_mapping, index,
+					  last_index, fbatch);
+	if (*batch_end > index)
+		goto retry;
+
+	error = shmem_get_folio(inode, index, 0, folio, SGP_GET);
+	if (unlikely(error))
+		return error;
+	if (*folio) {
+		folio_batch_add(fbatch, *folio);
+		goto retry;
+	}
+	return 0;
+}
+
 static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t index;
+	struct folio_batch fbatch;
+	pgoff_t index, last_index, fbatch_end = 0;
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
 
+	folio_batch_init(&fbatch);
+
 	for (;;) {
 		struct folio *folio = NULL;
 		struct page *page = NULL;
@@ -3370,8 +3454,10 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			break;
 
 		index = iocb->ki_pos >> PAGE_SHIFT;
-		error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
-		if (error) {
+		last_index = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;
+		error = shmem_get_folio_from_batch(inode, index, last_index, &folio,
+						   &fbatch, &fbatch_end);
+		if (unlikely(error)) {
 			if (error == -EINVAL)
 				error = 0;
 			break;
@@ -3379,7 +3465,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (folio) {
 			page = folio_file_page(folio, index);
 			if (PageHWPoison(page)) {
-				folio_put(folio);
 				error = -EIO;
 				break;
 			}
@@ -3394,11 +3479,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
 		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
 		if (folio && likely(!fallback_page_copy))
 			fsize = folio_size(folio);
@@ -3433,7 +3516,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				ret = copy_folio_to_iter(folio, offset, nr, to);
 			else
 				ret = copy_page_to_iter(page, offset, nr, to);
-			folio_put(folio);
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
@@ -3462,6 +3544,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		cond_resched();
 	}
 
+	for (int i = 0; i < folio_batch_count(&fbatch); i++)
+		folio_put(fbatch.folios[i]);
 	file_accessed(file);
 	return retval ? retval : error;
 }
-- 
2.43.0

