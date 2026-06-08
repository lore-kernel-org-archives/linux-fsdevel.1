Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C7313E29
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952790; cv=none; b=KiHLvTx+YLmKqyHJ7M5JHd8eSwFfzroHn+8nzReoTbA35SESBE+oyNoK4GY+IHzM7fpIsRg/JDGKsXoD/Lj3mnZ4cTTLXYNmbP20hFfxpEGD8XWGJC0c1gO5WWF2bACtKnMKsLVC634mX2xSPKl/0aDtbYR6e6Pm5txOHEYiw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952790; c=relaxed/simple;
	bh=QLk8aXqgEHDCNI36dH4jTg9TLSoqJo986mSCfZWLjDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeKTM9WmxXGH8mtv25z024lmlLUJW2D4jDbkn0KBcjVG6W6TD0HZFheTrsqf80V659bAanCnt3J2ch18pknhQt5MlRnj5oA3vPmTD3Vum+3AtzpbytudfntYWtU+/4MdnUsaTHWCMaIjm2iUx7Gab7IwAr+0iw7gX5tFVzHHEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LKy54eoQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LKy54eoQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=f381bunMVrNL/C5c9XWgPM0aHnXBUcQ0fqjfggVLbzc=; b=LKy54eoQxdcNjWIjMYELZKf8wY
	aUPM7LLesS5MzlJJuXuELR5XdSssdP1suhJ4G+ZNEEb8GA+qeGi0R4i2y2btjUc6sJYVDFrXl/SKF
	De+VDros5JsddJIqspWx+7DBzwyzNkp9Yd/DfiHFxQ83lTvYjpptUxG6KOFmfF8d9QNHjg+Hgxbf8
	tHyUzY8xjMEbKiOwHHN8QCaxMtFabgmcrogT7O5Fajr2xjMYdJ47ycuIHLpqiyCb0t0rJC9Eghxt3
	b409+r6uYHXPXsBrmpMat0Q+JrlEJPIApTtflvhFbqTkWXO11CtGajsl4pliaLRmWcoSU1MU6iZ7A
	qUBKOeMw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAq-0000000EQBC-1nks;
	Mon, 08 Jun 2026 21:06:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
Date: Mon,  8 Jun 2026 22:06:12 +0100
Message-ID: <20260608210618.3437216-3-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608210618.3437216-1-willy@infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody is supposed to use page->__folio_index.  Use page_offset()
instead, and simplify by working exclusively in loff_t instead of mixing
up loff_t and pgoff_t.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/compress.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index c904858dff3d..b279f38636d6 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -105,13 +105,14 @@ void free_compression_buffers(void)
 static inline void handle_bounds_compressed_page(struct page *page,
 		const loff_t i_size, const s64 initialized_size)
 {
-	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
-			(initialized_size < i_size)) {
+	loff_t pos = page_offset(page);
+
+	if ((pos >= initialized_size) && (initialized_size < i_size)) {
 		u8 *kp = page_address(page);
 		unsigned int kp_ofs;
 
 		ntfs_debug("Zeroing page region outside initialized size.");
-		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
+		if (pos >= initialized_size) {
 			clear_page(kp);
 			return;
 		}
-- 
2.47.3

