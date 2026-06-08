Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060239F17F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952792; cv=none; b=R8n25rsUeijDvuDPfRNJhuuAtlR/ptwHMzivSplaFmFcYZHCL5lltMXAcR+N8UqfYSDuQWpQ7+bLNOKfpD46hJawAGKEIW6S1ROdIlqqLqJyQtDSaMbcvK9ewQrgO1zqWZjg9emAp6k7KoKGh/iD6czrwKdmM0g0TrMVZIC8kOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952792; c=relaxed/simple;
	bh=QcTDZgfrNucgGbb9KqjahxU71mO8TAuQ8ZYbVVQnnNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4uyBl7SnLArrmpdoXhRRwTIzHdwbxFZptA9ynhb1ah+uUwrEDYEg+8UH6A22TZKPbj+2sGF5L6cLVPUpI8J0MyHVqGENn34Lxv54LJRNhz5jOXQWg0YWtTWtFX2SXoaO6AbMjTZ0K0eIUCL9wHSTQxgryqFFlqgCAnn98CXsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDm86ncH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDm86ncH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bpCN61J5lII0MiD6qqFT91HWJ8XVANmnLIHdvgttKXk=; b=XDm86ncHSIbY6RyiBvgtOYzEVk
	uMIuqwiMquT4N/f2w/+XRUoCL2CIn4o/kGQ49Itu0h+JdBFb5/zhnUf+moTEoVn6JbnBxorZYn+Kq
	SIhrFbn+4klySjlNuLrmw5uUTfzeMIoonDNH9qok68CHCVzZOM8UOSP4DUH8ohF77WLRe1kIpVumb
	w2y0Xoc5uFQZuLRFzvs9luc5GJKTEggYLy/aFSsLlLL9hqwSymi/chK49qJ1hRjmTVqQyUFuOpHAp
	Ua4qp+U9rg62AdNdk1fln050nTxnWF6dCX8apYzL9tpfdurCKIJFBWJYPw5QdPqDpDWlfDgKpIn8V
	3IJHK/Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAq-0000000EQBA-1FXn;
	Mon, 08 Jun 2026 21:06:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 1/6] ntfs: Inline zero_partial_compressed_page()
Date: Mon,  8 Jun 2026 22:06:11 +0100
Message-ID: <20260608210618.3437216-2-willy@infradead.org>
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

zero_partial_compressed_page() has one caller and the next commit
will make changes to it that make it inelegant to split across two
functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806b41ed..c904858dff3d 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -96,26 +96,6 @@ void free_compression_buffers(void)
 	mutex_unlock(&ntfs_cb_lock);
 }
 
-/*
- * zero_partial_compressed_page - zero out of bounds compressed page region
- * @page: page to zero
- * @initialized_size: initialized size of the attribute
- */
-static void zero_partial_compressed_page(struct page *page,
-		const s64 initialized_size)
-{
-	u8 *kp = page_address(page);
-	unsigned int kp_ofs;
-
-	ntfs_debug("Zeroing page region outside initialized size.");
-	if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
-		clear_page(kp);
-		return;
-	}
-	kp_ofs = initialized_size & ~PAGE_MASK;
-	memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
-}
-
 /*
  * handle_bounds_compressed_page - test for&handle out of bounds compressed page
  * @page: page to check and handle
@@ -126,8 +106,18 @@ static inline void handle_bounds_compressed_page(struct page *page,
 		const loff_t i_size, const s64 initialized_size)
 {
 	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
-			(initialized_size < i_size))
-		zero_partial_compressed_page(page, initialized_size);
+			(initialized_size < i_size)) {
+		u8 *kp = page_address(page);
+		unsigned int kp_ofs;
+
+		ntfs_debug("Zeroing page region outside initialized size.");
+		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
+			clear_page(kp);
+			return;
+		}
+		kp_ofs = initialized_size & ~PAGE_MASK;
+		memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
+	}
 }
 
 /*
-- 
2.47.3

