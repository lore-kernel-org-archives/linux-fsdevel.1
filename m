Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194953128AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052547; cv=none; b=E+s94sgCca4uJUTd1Wwg7x+2jdbRLVCZeRmYx+XCRQed93UzjtjhoGM5T5WsOdrpnASHyUvLQA+C9Zc8NJzfeMEoApp08ceRyWbZkou7JumjvikjgS4jpMq+QtcsixsR8uFQaYxr1hFXeL73FpuP/e9ncvHJ3o8hH17l3iDXuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052547; c=relaxed/simple;
	bh=sVU4NvWSrvZZn65QoyuOzvbtYx9lewbiWGLqrW/THuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqga2FJhAYuWLTlAfxhn4itqsZwX8DaDsgODxO0QZbAmjWG0JZbVuGuwdoGWsW2UdXWBifIoSj5SkNl0hmxGFxXUWig4Wpm3P2+obOT7BIPRdo+pG4bwWUW/7ZyUMoN/+qE1woUnK2KQHyh1bqeG6CpyhjMNjZYcyVNVOcqP5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YguRKqYc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YguRKqYc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=D4UHE2aMrlLfsSQ1GFII5ZbKd0oEikGw4iB1n/r35n0=; b=YguRKqYcBeI4mb+IQtO1ZyWKgS
	AEnA1FUinKY1oH1LZUw7+KMV+1Ou8btsXg4UFOaDVzzT9/GsrVbjBXXA+UOl5LZILkMvJOpyHpU9e
	/auHMO+rXhh6zuteCoVK2gjZW6Cl16zXQgrewyKgo5NCuvuzXVy+7kzQbVbLFghpHGc+qk30OUtVL
	QAa5xcAV6xJwnGUmS9qwOMuxTrYolzZUfHiPA+grMddntZ/1PdddieJR2/c93xuv6KcTH4R6mLmW2
	N759uc2hL6fS+tY7S9VY/qaY7dU1j8v8t7F1ZCxPJX794VD+XrXuWT7TVxbJ8IiZMLtOHeAgG0JvJ
	FqD+L3ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjhYh-0000000Fega-0iHa;
	Tue, 14 Jul 2026 18:08:43 +0000
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
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 5/9] filemap: Add hwpoison handling to filemap_read()
Date: Tue, 14 Jul 2026 19:08:35 +0100
Message-ID: <20260714180840.3731244-6-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714180840.3731244-1-willy@infradead.org>
References: <20260714180840.3731244-1-willy@infradead.org>
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
 mm/filemap.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 58eb9d240643..0f3ada4d8cff 100644
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
+	if (is_page_hwpoison(page))
+		return 0;
+
+	/* Safe to read the remaining bytes in this page. */
+	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
+	page++;
+
+	/* Check each remaining page as long as we are not done yet. */
+	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
+		if (is_page_hwpoison(page))
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

