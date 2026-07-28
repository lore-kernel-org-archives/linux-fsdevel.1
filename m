Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301E42125B
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271478; cv=none; b=ov9Rs78Mpa7qhH9kxfF8MQUUJaUi65XfD8d8ou79u5Hom1dL6+OVbmbZHv2lukNWZmqQslDvybUecRV1ShyFmWbKupE2mZFO3xCWbKiZUmH15sDtWbahN9zZmT0Ydv+JG5SLmrUWclqJQ/QSEsbTi745xsGjzCIpWuzVQar3184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271478; c=relaxed/simple;
	bh=AyQWgSo8XWTUphonEAuyYBrdrjkAJEvZbg2IOcYNkbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU76bZDWTefjgTW4NVyQUw0Onalhk288KFVzTgGhYpahoEoMjTDvWuqG/gxT3TrXB5UbBVVAGJEkBisfnnU6jTVvA5NPtZCc51q5Zl/8Z0+thL4ampK2Mw2LcrTtfpFD4Qove1naedDd08SG7NmY3NXtMWmxyC7//sEK5LGDTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XezzPoDm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XezzPoDm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xPkMEYO9mjH/Ia6rRtWcuKRSGQrQUxUN5Ze4piyRhiI=; b=XezzPoDm+9iAq/loN7TsqBgWTJ
	JOsPtROhdL/+DdTC4DoGeWreGorMDVigUg2KSGC04dZkLG0NAOfiKCgW9ehJSbGjSjtSrRGrG7icF
	PT2c8IyrhHMZHP0DwVaFVvaDXvNh84HIs7R+pcFLBfTHWOBaXVTODR31EMpBriqbVP+q6YoxqjjrG
	DJ2vD7+qAGB+YM/JCUiBTJhgcI02+eb5r+1pO9g5M1ZyGLqsl45SaMvlC3WrnF67SpPTnWAycRlUB
	mr9h8HAUJECfxGmJjqp+BRyEYSOm9KHTyXQs/IqvHYelsi5xs+1+psaZI66eQvikqm02eFr3HqkBP
	chd8UWhw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooeq-0000000EFWr-0BUg;
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
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v7 09/13] filemap: Add hwpoison handling to filemap_read()
Date: Tue, 28 Jul 2026 21:44:01 +0100
Message-ID: <20260728204409.3396238-10-willy@infradead.org>
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

Add hwpoison handling to filemap_read() such that .read_iter() could
make best effort copying data out of clean pages without risking
MCE in case page cache contains HWpoison.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Co-developed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/hugetlb.h    |  2 --
 include/linux/page-flags.h | 11 +++++++++++
 mm/filemap.c               | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 325f0404a7eb..1878642e75ec 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1069,8 +1069,6 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
-bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
-
 static inline unsigned long huge_page_mask_align(struct file *file)
 {
 	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ee026ba9b0b5..07cc7854b2de 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1094,6 +1094,7 @@ static inline bool PageHuge(const struct page *page)
 	return folio_test_hugetlb(page_folio(page));
 }
 
+bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
 bool hugetlb_unref_page_hwpoison(const struct page *page);
 
 /*
@@ -1115,6 +1116,16 @@ static inline bool is_page_hwpoison(const struct page *page)
 	return PageHWPoison(page);
 }
 
+static inline bool is_ref_page_hwpoison(const struct folio *folio,
+		const struct page *page)
+{
+	if (PageHWPoison(page))
+		return true;
+	if (folio_test_hugetlb(folio))
+		return hugetlb_page_hwpoison(folio, page);
+	return false;
+}
+
 static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
 {
 	return PageHWPoison(&folio->page) ||
diff --git a/mm/filemap.c b/mm/filemap.c
index 58eb9d240643..26a5f18121f9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2483,6 +2483,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio))
 			break;
+		if (folio_has_hwpoisoned_page(folio))
+			break;
 		if (!folio_test_uptodate(folio))
 			break;
 		if (folio_test_readahead(folio))
@@ -2749,6 +2751,29 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+static size_t adjust_range_hwpoison(const struct folio *folio, size_t offset,
+		size_t bytes)
+{
+	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	size_t safe_bytes;
+
+	if (!folio_has_hwpoisoned_page(folio))
+		return bytes;
+	if (is_ref_page_hwpoison(folio, page))
+		return 0;
+
+	/* Safe to read the remaining bytes in this page. */
+	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
+	page++;
+
+	/* Check each remaining page as long as we are not done yet. */
+	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
+		if (is_ref_page_hwpoison(folio, page))
+			break;
+
+	return min(safe_bytes, bytes);
+}
+
 static void filemap_end_dropbehind_read(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
@@ -2862,14 +2887,18 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			if (writably_mapped)
 				flush_dcache_folio(folio);
 
-			copied = copy_folio_to_iter(folio, offset, bytes, iter);
+			copied = adjust_range_hwpoison(folio, offset, bytes);
+			if (copied < bytes)
+				error = -EIO;
+			copied = copy_folio_to_iter(folio, offset, copied, iter);
 
 			already_read += copied;
 			iocb->ki_pos += copied;
 			last_pos = iocb->ki_pos;
 
 			if (copied < bytes) {
-				error = -EFAULT;
+				if (!error)
+					error = -EFAULT;
 				break;
 			}
 		}
-- 
2.47.3

