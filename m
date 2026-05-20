Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFF3D75CF;
	Wed, 20 May 2026 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272395; cv=none; b=VOhel/qj0qXRPHH6fYrKwFnHoHsxImHiOLaKgW8eeGcTC5ynOC+3Fhl1CkPOMkRW5H6X2yV8/R254KhBo+DGr1k9QMWt2Kc3PzKdb6maWi42MvrhrOpW2rUdTN20zuDUmovregJH8lDXWKsMkKGg3PptbBkJy3PoTYcasfwsoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272395; c=relaxed/simple;
	bh=j1SC3CWyTpLRoSsCegCksqPOhFsaSmPh/3cUQzXMzDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF2Ttj98jzNlS/T8MWZB2wFga58kVAChUQPztBQnfel7vinqgHCIS50GvGAsGPstANpAuDBfLWz14KFoTjuOZ+Z1khAfy0DNaYNLCTiM1kurBayKQRHAeHpgWdBXecEQKUUrta0i+KKcV2TwrCMqZIKHZmjMLDLuaa9S0804wfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bjPI6Jhy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bjPI6Jhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PO
	Y07p4j3GPNthuCu4k23r6LNTlq73DDrD9MKLgmiwk=; b=bjPI6JhyYxNG7cJPhz
	OGjxgBVi3zkiNRH/3i+lshSHVTH24MxKIYauZD+5SBvgzQWsezV4h2+64cYie76f
	uv28g+XqDwsRzDUgD8bim6RipQNFx138Z1I96Ei5JAfgWRtda+9IeqorWlpieuP3
	7n9R9gbRlPYJVkReKTkh5exwg=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXbbprig1qQK31EQ--.641S7;
	Wed, 20 May 2026 18:18:26 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
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
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 5/5] mm/shmem: optimize file read with folio batching
Date: Wed, 20 May 2026 18:15:38 +0800
Message-ID: <20260520101538.58745-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520101538.58745-1-chizhiling@163.com>
References: <20260520101538.58745-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXbbprig1qQK31EQ--.641S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF13ur1kJF4UXr4fKryfZwb_yoWrXrWxpF
	W3KwnxWrWxGw43Wr4fJF48Za4rK3s3tFW5JFyxG3W3Z3W5J3s8KF18t34Y9FW5Jry7C3WI
	gw1vkr18X3Wjvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jISoJUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xKcOmoNinIMpwAA33

From: Chi Zhiling <chizhiling@kylinos.cn>

Optimize shmem file read by using filemap_get_folios_contig() to
batch fetch contiguous folios from the page cache, reducing the
overhead of repeated shmem_get_folio() calls.

When the folio batch is exhausted, attempt to refill it with
filemap_get_folios_contig(). If no folios are found (hole or swapped
out pages), fall back to shmem_get_folio() to handle these cases
individually.

Additionally:
- Defer folio_put() until the batch is exhausted or on exit
- Add folio_test_uptodate() check before copying to ensure data
  validity

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/shmem.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 96ea5a4c0aff..e0eacc23cccd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3355,11 +3355,14 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
+	struct folio_batch fbatch;
 	pgoff_t index;
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
 
+	folio_batch_init(&fbatch);
+
 	for (;;) {
 		struct folio *folio = NULL;
 		struct page *page = NULL;
@@ -3372,18 +3375,38 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			break;
 
 		index = iocb->ki_pos >> PAGE_SHIFT;
-		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
-		if (error) {
-			if (error == -EINVAL)
-				error = 0;
-			break;
+fetch:
+		folio = folio_batch_next(&fbatch);
+		if (!folio) {
+			pgoff_t start = index;
+			pgoff_t end = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;
+
+			if (folio_batch_count(&fbatch)) {
+				for (int i = 0; i < folio_batch_count(&fbatch); i++)
+					folio_put(fbatch.folios[i]);
+				folio_batch_reinit(&fbatch);
+			}
+
+			filemap_get_folios_contig(inode->i_mapping, &start, end, &fbatch);
+			if (folio_batch_count(&fbatch))
+				goto fetch;
+
+			error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
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
-		if (folio) {
-			folio_unlock(folio);
 
+		if (folio) {
 			page = folio_file_page(folio, index);
 			if (PageHWPoison(page)) {
-				folio_put(folio);
 				error = -EIO;
 				break;
 			}
@@ -3398,11 +3421,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -3411,7 +3432,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		offset = iocb->ki_pos & (fsize - 1);
 		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
 
-		if (folio) {
+		if (folio && folio_test_uptodate(folio)) {
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
@@ -3437,7 +3458,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				ret = copy_folio_to_iter(folio, offset, nr, to);
 			else
 				ret = copy_page_to_iter(page, offset, nr, to);
-			folio_put(folio);
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
@@ -3466,6 +3486,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		cond_resched();
 	}
 
+	for (int i = 0; i < folio_batch_count(&fbatch); i++)
+		folio_put(fbatch.folios[i]);
 	file_accessed(file);
 	return retval ? retval : error;
 }
-- 
2.43.0

