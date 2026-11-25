Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632649;
	b=BZQBXRPyihgC5QQ+YQ05Ij73Vp//LCdwjHJNBdCA32r6m0yhFplIlR9Cp+UXj1jlaS9D
	 TsdJHJRP/+Qc+XbxpRXWxLl3l80iOE6mXBmqRc7RkkG+JNMFYOXe4F82wmpBor/JsXJ+9
	 wJK0iumnzEJEmB8WK8DFhdPAxWJnLfHmYF8ReMRwxiDz8wrGx54MrwrbaFs+6DWK9FXRS
	 siOvoTipLvcX96fG9a+VTGEiesmaiytus7GTZhiY/EPNhAm8m9P+YUlN2qGrUrjelpiIW
	 EhYa9eJRNqvM3G8p9OXp2HZRttlws3oeB0gt74iOOLVrGeM4p3UgwKhqZ+RAQxruuyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UbXWaEM5nKbkOF2P0JaiG5+ZZSOXQJTuSKPmrzbQaYk=;
	b=JI1oU2NIShGzTuuTJmvWi1E+Tdk/shINaF5GJ1FZoxjsPSHHIiYvJFSrCFF2pkJWN+Ih
	 VASxMKdweofHcVEoCGuby8kU9TzYLqJv7MIR3M1RVLLHU7dr+tlBn04SXM/wrfl6zFkfg
	 EXJTIaRAN/GLIovCG3VaaU2bIzWUfWFrqO9pXDyfm7jCC5W8UQmK/Anmbsg390FKOaJp2
	 7KmhmvhCgB0kwK/naqjfGJ8tYsad9esoeRD71zZg6BdF0x07djJAVghar+vgxA0cdo+DI
	 jy7zHDSi2Kmcn1z8eix/JGg8NK8qK2OrGBRSjsa7ktq0Y6rkfm1LBRUCFGsjjNbbsWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr6UB6oi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5F606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr6UB6oi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6671F000C0;
	Wed, 25 Nov 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632649;
	bh=UbXWaEM5nKbkOF2P0JaiG5+ZZSOXQJTuSKPmrzbQaYk=;
	h=From:To:Cc:Subject:Date;
	b=Cr6UB6oiczNKVEJ89QZAkQcC+aBnWUzAqaPkZxQ9vzvbGWIVaEFECHIMLUnUPX+Bq
	 JFud5LEu/vazwKMyumtSFCtYUFaMoyw19cQ0KVh67s+91qZR6O8FGGoR2fmX3yyqAw
	 VFT2TdKVuvelwfy0uDYTdJX0I4sb+7dnhzX2jiJx8mxB8gaFt8K0ihNJ+ESUTIyxfR
	 qZFlJlA/KprUyYD+GCvJ6nUBfBT9orF7iOXKwM5Nd15VohJQS0gawy1KFnEyQz6zTi
	 Lff9kRjka2O8ExCya43MMISlAPgtsqbTupEJG/D0LB6g6PR2fEO99LpkgYWHe0o7zB
	 6Z6bVpcCjRreQ==
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH] orangefs: move up to 2 MiB through the page cache
Date: Wed, 25 Nov 2026 13:50:28 -0500
Message-ID: <20261125185043.431330-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

The bufmap can copy a 2 MiB hugepage in one piece. The page cache was
still order-0, so each read and write walked one page and
orangefs_write_range described that page.

Allow regular-file folios up to one 2 MiB chunk, and never larger than
the bufmap slot. orangefs_write_range stays one byte range on that
folio. Cap the range to the folio actually returned, and launder the
recorded range before replacing it. A non-contiguous write used to
point the range at the new offset before the copy, which dropped the
previous bytes.

Write back and read a folio in slot-sized pieces when the folio is
larger than the slot. Copy bvec and xarray iterators a folio at a
time, so a contiguous 2 MiB page cache folio moves in one memcpy.
User buffers still use copy_from_iter() and copy_to_iter().

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c           | 140 ++++++++++++++++++++++++++++------
 fs/orangefs/orangefs-bufmap.c | 114 +++++++++++++++++++++++++--
 fs/orangefs/orangefs-kernel.h |   5 ++
 3 files changed, 229 insertions(+), 30 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7b17af735a9e..a3f50a0a2c85 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -24,7 +24,7 @@ static int orangefs_writepage_locked(struct folio *folio,
 	struct iov_iter iter;
 	struct bio_vec bv;
 	size_t wlen;
-	ssize_t ret;
+	ssize_t ret = 0;
 	loff_t len, off;
 
 	folio_start_writeback(folio);
@@ -55,14 +55,29 @@ static int orangefs_writepage_locked(struct folio *folio,
 	}
 
 	WARN_ON(wlen == 0);
-	bvec_set_folio(&bv, folio, wlen, offset_in_folio(folio, off));
-	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
+	/*
+	 * A folio can be larger than one bufmap slot. Write it in slot-sized
+	 * pieces from the same orangefs_write_range.
+	 */
+	while (wlen) {
+		size_t this_len = wlen;
+		int slot = orangefs_bufmap_size_query();
 
-	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
-	    len, wr, NULL, NULL);
-	if (ret < 0) {
-		mapping_set_error(folio->mapping, ret);
-	} else {
+		if (slot > 0 && this_len > slot)
+			this_len = slot;
+
+		bvec_set_folio(&bv, folio, this_len,
+			       offset_in_folio(folio, off));
+		iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, this_len);
+
+		ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter,
+					 this_len, len, wr, NULL, NULL);
+		if (ret < 0) {
+			mapping_set_error(folio->mapping, ret);
+			break;
+		}
+		wlen -= this_len;
+		off += this_len;
 		ret = 0;
 	}
 	kfree(folio_detach_private(folio));
@@ -154,6 +169,12 @@ static int orangefs_writepages_callback(struct folio *folio,
 
 	ret = -1;
 	if (ow->nfolios == 0) {
+		/*
+		 * One folio may already be larger than a slot. Let
+		 * orangefs_writepage_locked split that write range.
+		 */
+		if (wr->len > orangefs_bufmap_size_query())
+			goto done;
 		ow->off = wr->pos;
 		ow->len = wr->len;
 		ow->uid = wr->uid;
@@ -169,6 +190,8 @@ static int orangefs_writepages_callback(struct folio *folio,
 		goto done;
 	}
 	if (ow->off + ow->len == wr->pos) {
+		if (ow->len + wr->len > orangefs_bufmap_size_query())
+			goto done;
 		ow->len += wr->len;
 		ow->folios[ow->nfolios++] = folio;
 		ret = 0;
@@ -317,20 +340,54 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct iov_iter iter;
 	struct bio_vec bv;
-	ssize_t ret;
+	ssize_t ret = 0;
 	loff_t off; /* offset of this folio in the file */
+	size_t offset = 0;
+	size_t remaining = folio_size(folio);
 
 	if (folio_test_dirty(folio))
 		orangefs_launder_folio(folio);
 
 	off = folio_pos(folio);
-	bvec_set_folio(&bv, folio, folio_size(folio), 0);
-	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, folio_size(folio));
+	while (remaining) {
+		size_t this_size = remaining;
+		int slot = orangefs_bufmap_size_query();
+
+		if (slot > 0 && this_size > slot)
+			this_size = slot;
+
+		bvec_set_folio(&bv, folio, this_size, offset);
+		iov_iter_bvec(&iter, ITER_DEST, &bv, 1, this_size);
 
-	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
-			folio_size(folio), inode->i_size, NULL, NULL, file);
-	/* this will only zero remaining unread portions of the folio data */
-	iov_iter_zero(~0U, &iter);
+		ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
+					 this_size, inode->i_size, NULL, NULL,
+					 file);
+		if (ret < 0)
+			break;
+
+		/*
+		 * Short read. Zero the unread tail of this folio, including
+		 * any bytes past this bufmap-sized piece.
+		 */
+		if (ret < this_size) {
+			iov_iter_zero(~0U, &iter);
+			offset += ret;
+			remaining -= ret;
+			if (remaining) {
+				bvec_set_folio(&bv, folio, remaining, offset);
+				iov_iter_bvec(&iter, ITER_DEST, &bv, 1,
+					      remaining);
+				iov_iter_zero(~0U, &iter);
+			}
+			ret = 0;
+			break;
+		}
+
+		remaining -= this_size;
+		offset += this_size;
+		off += this_size;
+		ret = 0;
+	}
 	/* takes care of potential aliasing */
 	flush_dcache_folio(folio);
 	if (ret > 0)
@@ -348,13 +405,19 @@ static int orangefs_write_begin(const struct kiocb *iocb,
 	struct folio *folio;
 	int ret;
 
-	folio = __filemap_get_folio(mapping, pos / PAGE_SIZE, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
+	folio = write_begin_get_folio(iocb, mapping, pos / PAGE_SIZE, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
 	*foliop = folio;
 
+	/*
+	 * generic_perform_write() can ask for more bytes than the folio it
+	 * gets back. orangefs_write_range describes only this folio.
+	 */
+	if (len > folio_size(folio) - offset_in_folio(folio, pos))
+		len = folio_size(folio) - offset_in_folio(folio, pos);
+
 	if (folio_test_dirty(folio) && !folio_test_private(folio)) {
 		/*
 		 * Should be impossible.  If it happens, launder the page
@@ -374,11 +437,16 @@ static int orangefs_write_begin(const struct kiocb *iocb,
 			wr->len += len;
 			goto okay;
 		} else {
-			wr->pos = pos;
-			wr->len = len;
+			/*
+			 * Launder the range already recorded in wr. Updating
+			 * wr first would write the new offset before its
+			 * bytes are copied in, and drop the old range.
+			 */
 			ret = orangefs_launder_folio(folio);
 			if (ret)
 				return ret;
+			if (folio_test_private(folio))
+				kfree(folio_detach_private(folio));
 		}
 	}
 
@@ -432,14 +500,15 @@ static int orangefs_write_end(const struct kiocb *iocb,
 
 	/* zero the stale part of the folio if we did a short copy */
 	if (!folio_test_uptodate(folio)) {
-		unsigned from = pos & (PAGE_SIZE - 1);
+		size_t fsize = folio_size(folio);
+		unsigned int from = offset_in_folio(folio, pos);
 		if (copied < len) {
 			folio_zero_range(folio, from + copied, len - copied);
 		}
-		/* Set fully written pages uptodate. */
+		/* Set fully written folios uptodate. */
 		if (pos == folio_pos(folio) &&
-		    (len == PAGE_SIZE || pos + len == inode->i_size)) {
-			folio_zero_segment(folio, from + copied, PAGE_SIZE);
+		    (len == fsize || pos + len == inode->i_size)) {
+			folio_zero_segment(folio, from + copied, fsize);
 			folio_mark_uptodate(folio);
 		}
 	}
@@ -457,7 +526,10 @@ static void orangefs_invalidate_folio(struct folio *folio,
 {
 	struct orangefs_write_range *wr = folio_get_private(folio);
 
-	if (offset == 0 && length == PAGE_SIZE) {
+	if (!wr)
+		return;
+
+	if (offset == 0 && length == folio_size(folio)) {
 		kfree(folio_detach_private(folio));
 		return;
 	/* write range entirely within invalidate range (or equal) */
@@ -1035,6 +1107,25 @@ static const struct inode_operations orangefs_file_inode_operations = {
 	.fileattr_set = orangefs_fileattr_set,
 };
 
+/*
+ * Folios may be as large as one bufmap hugepage chunk (2 MiB), and never
+ * larger than the bufmap slot. A slot is two of those chunks when
+ * hugepages are available.
+ */
+static void orangefs_set_mapping_order(struct inode *inode)
+{
+	size_t max_bytes = SZ_2M;
+	unsigned int order;
+	int slot = orangefs_bufmap_size_query();
+
+	if (slot > 0 && (size_t)slot < max_bytes)
+		max_bytes = slot;
+	order = filemap_get_order(max_bytes);
+	if (order > MAX_PAGECACHE_ORDER)
+		order = MAX_PAGECACHE_ORDER;
+	mapping_set_folio_order_range(inode->i_mapping, 0, order);
+}
+
 static int orangefs_init_iops(struct inode *inode)
 {
 	inode->i_mapping->a_ops = &orangefs_address_operations;
@@ -1043,6 +1134,7 @@ static int orangefs_init_iops(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &orangefs_file_inode_operations;
 		inode->i_fop = &orangefs_file_operations;
+		orangefs_set_mapping_order(inode);
 		break;
 	case S_IFLNK:
 		inode->i_op = &orangefs_symlink_inode_operations;
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index a557e1cf7436..9028e5152ed5 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -642,6 +642,108 @@ void orangefs_readdir_index_put(int buffer_index)
 	put(&readdir_map, buffer_index);
 }
 
+/*
+ * Copy between a mapped bufmap address and a page-cache iterator.
+ * bvec and xarray iterators are folios. Copy each folio in one piece
+ * when the folio is contiguous, so a 2 MiB folio moves 2 MiB at a time.
+ * Other iterators are user buffers and use the usual copy helpers.
+ */
+static size_t orangefs_copy_bvec(char *kaddr, size_t bytes,
+				 struct iov_iter *iter, bool from_iter)
+{
+	size_t copied = 0;
+
+	while (bytes && iter->nr_segs) {
+		const struct bio_vec *bv = iter->bvec;
+		size_t skip = iter->iov_offset;
+		struct folio *folio;
+		size_t folio_off, chunk;
+
+		if (skip >= bv->bv_len)
+			break;
+
+		folio = page_folio(bv->bv_page);
+		folio_off = folio_page_idx(folio, bv->bv_page) * PAGE_SIZE +
+			    bv->bv_offset + skip;
+		chunk = min_t(size_t, bytes, bv->bv_len - skip);
+		if (folio_off >= folio_size(folio))
+			break;
+		if (chunk > folio_size(folio) - folio_off)
+			chunk = folio_size(folio) - folio_off;
+
+		if (from_iter)
+			memcpy_from_folio(kaddr, folio, folio_off, chunk);
+		else
+			memcpy_to_folio(folio, folio_off, kaddr, chunk);
+
+		kaddr += chunk;
+		copied += chunk;
+		bytes -= chunk;
+		iov_iter_advance(iter, chunk);
+	}
+	return copied;
+}
+
+static size_t orangefs_copy_xarray(char *kaddr, size_t bytes,
+				   struct iov_iter *iter, bool from_iter)
+{
+	struct folio *folio;
+	size_t copied = 0;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	XA_STATE(xas, iter->xarray, index);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t offset, flen;
+
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		offset = offset_in_folio(folio, start + copied);
+		flen = min_t(size_t, folio_size(folio) - offset, bytes);
+		if (!flen)
+			break;
+
+		if (from_iter)
+			memcpy_from_folio(kaddr, folio, offset, flen);
+		else
+			memcpy_to_folio(folio, offset, kaddr, flen);
+
+		kaddr += flen;
+		copied += flen;
+		bytes -= flen;
+		if (!bytes)
+			break;
+	}
+	rcu_read_unlock();
+	iov_iter_advance(iter, copied);
+	return copied;
+}
+
+static size_t orangefs_copy_iter(void *kaddr, size_t bytes,
+				 struct iov_iter *iter, bool from_iter)
+{
+	char *addr = kaddr;
+
+	if (bytes > iov_iter_count(iter))
+		bytes = iov_iter_count(iter);
+	if (!bytes)
+		return 0;
+
+	if (iov_iter_is_bvec(iter))
+		return orangefs_copy_bvec(addr, bytes, iter, from_iter);
+	if (iov_iter_is_xarray(iter))
+		return orangefs_copy_xarray(addr, bytes, iter, from_iter);
+	if (from_iter)
+		return copy_from_iter(kaddr, bytes, iter);
+	return copy_to_iter(kaddr, bytes, iter);
+}
+
 /*
  * we've been handed an iovec, we need to copy it to
  * the shared memory descriptor at "buffer_index".
@@ -686,7 +788,7 @@ int orangefs_bufmap_copy_from_iovec(struct iov_iter *iter,
 
 		/* First 2 MiB chunk */
 		kaddr = kmap_local_folio(to->folio_array[0], 0);
-		copied = copy_from_iter(kaddr, first, iter);
+		copied = orangefs_copy_iter(kaddr, first, iter, true);
 		kunmap_local(kaddr);
 		if (copied != first)
 			return -EFAULT;
@@ -696,7 +798,7 @@ int orangefs_bufmap_copy_from_iovec(struct iov_iter *iter,
 
 		/* Second 2 MiB chunk */
 		kaddr = kmap_local_folio(to->folio_array[1], 0);
-		copied = copy_from_iter(kaddr, second, iter);
+		copied = orangefs_copy_iter(kaddr, second, iter, true);
 		kunmap_local(kaddr);
 		if (copied != second)
 			return -EFAULT;
@@ -724,7 +826,7 @@ int orangefs_bufmap_copy_from_iovec(struct iov_iter *iter,
 		folio_avail = folio_nr_pages(folio) * PAGE_SIZE - folio_offset;
 		copy_amount = min(remaining, folio_avail);
 		kaddr = kmap_local_folio(folio, folio_offset);
-		copied = copy_from_iter(kaddr, copy_amount, iter);
+		copied = orangefs_copy_iter(kaddr, copy_amount, iter, true);
 		kunmap_local(kaddr);
 
 		if (copied != copy_amount)
@@ -783,7 +885,7 @@ int orangefs_bufmap_copy_to_iovec(struct iov_iter *iter,
 
 		/* First 2 MiB chunk */
 		kaddr = kmap_local_folio(from->folio_array[0], 0);
-		copied = copy_to_iter(kaddr, first, iter);
+		copied = orangefs_copy_iter(kaddr, first, iter, false);
 		kunmap_local(kaddr);
 		if (copied != first)
 			return -EFAULT;
@@ -793,7 +895,7 @@ int orangefs_bufmap_copy_to_iovec(struct iov_iter *iter,
 
 		/* Second 2 MiB chunk */
 		kaddr = kmap_local_folio(from->folio_array[1], 0);
-		copied = copy_to_iter(kaddr, second, iter);
+		copied = orangefs_copy_iter(kaddr, second, iter, false);
 		kunmap_local(kaddr);
 		if (copied != second)
 			return -EFAULT;
@@ -822,7 +924,7 @@ int orangefs_bufmap_copy_to_iovec(struct iov_iter *iter,
 		copy_amount = min(remaining, folio_avail);
 
 		kaddr = kmap_local_folio(folio, folio_offset);
-		copied = copy_to_iter(kaddr, copy_amount, iter);
+		copied = orangefs_copy_iter(kaddr, copy_amount, iter, false);
 		kunmap_local(kaddr);
 
 		if (copied != copy_amount)
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 348fe340c5d5..0a8b9bbffc4b 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -226,6 +226,11 @@ struct orangefs_cached_xattr {
 	unsigned long timeout;
 };
 
+/*
+ * One dirty byte range on a folio. The folio may be a 2 MiB hugepage,
+ * so pos/len are not limited to PAGE_SIZE. A folio has only one range;
+ * a non-contiguous write launders the recorded range first.
+ */
 struct orangefs_write_range {
 	loff_t pos;
 	size_t len;
-- 
2.56.1

