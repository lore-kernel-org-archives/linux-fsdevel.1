Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125DC14A;
	Thu, 16 Jul 2026 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170052; cv=none; b=PySHGgiKmMomcwBmTVu72r53myOMrkQJx2C6QhgAt5Ojbi2PiqXX0xpZvHJIRmNCUd4equcgeVs4ze0gzRoh39EwTzH72lqhdluFc3q1S1cVm/PQJ53PNAftw/O1OPgv363hKLN3o1mHXfQXRjcV8AKjFhoPmhinS1D5seTgvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170052; c=relaxed/simple;
	bh=bkgGfAtw6Zc0M8STuODUgWOkxj8/LfhGDCMEzmclJuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yx9Gx6u02R6a8RJbuM/E2TYCLaThoDAauuNrZWE5M/v7/WHbK1hTc5rJtFvrLEJ6nzVLUPTuHeW8AbmxaZMzVgslUeCSesFZByzFcEam48eHCQ9MRwIrMHTQSSQ6P+VTEPnAznoXoGZuH9lwwAxf916jhcN/r7yBbt6hK81pC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFXiXruh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFXiXruh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0691F000E9;
	Thu, 16 Jul 2026 02:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170050;
	bh=fEqVQAjJdCHcrakS7WTOQ/eOTNMTCg+t4DD8+sZ+i5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFXiXruhakqkYFplvHOuxKTjZRCnFTdH1COrQwOnHAZoHMuj3UmwTfzU2ao6vQXSW
	 rV3XllrDNBKhSDqrgCfPuuJtAINX+uDiuBfGy/7iZMuig/c9my95e4eYEasYd6A5Yz
	 lqjTVJqwC9L63v0iodR1TAP1G1KkEcovZ5ki76keLtjBJT/SA3Tmy+csDBe0p1dtd1
	 N0r1Q7hGmWpQXp+3mmQ6Y/ZaGFnUHhml1KxxKzmRt8ADSt8BeTla5jOuhudwebbVd9
	 K7vbRBoLT2PEautWjfCSXPxJkJ/qtkBDdTfz5RNiPrklBdAZxYU3Qo6k+jZwsYRrP+
	 6hilbnyZGAv8Q==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] ntfs: fix kmap_local_page() usage in compress
Date: Thu, 16 Jul 2026 11:46:38 +0900
Message-Id: <20260716024640.13396-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260716024640.13396-1-linkinjeon@kernel.org>
References: <20260716024640.13396-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several compressed I/O paths discard the address returned by
kmap_local_page() and later access or unmap the page using page_address().
This is invalid for highmem pages, and local mappings must also be unmapped
using the address returned by kmap_local_page().

Map each destination page in ntfs_decompress() only while producing the
current sub-block. Use memcpy_from_page(), memcpy_to_page(), and
memzero_page() for the other page accesses. Remove unnecessary local
mappings from ntfs_write_cb(), where pages are accessed through the vmap()
mapping.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index d83d3e8e06ae..e866f43ca30b 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -177,6 +177,7 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 
 	/* Variables for uncompressed data / destination. */
 	struct page *dp;	/* Current destination page being worked on. */
+	u8 *dp_kaddr;		/* Local kmap for the current destination page. */
 	u8 *dp_addr;		/* Current pointer into dp. */
 	u8 *dp_sb_start;	/* Start of current sub-block in dp. */
 	u8 *dp_sb_end;		/* End of current sb in dp (dp_sb_start + NTFS_SB_SIZE). */
@@ -191,6 +192,7 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 	/* Default error code. */
 	int err = -EOVERFLOW;
 
+	dp_kaddr = NULL;
 	ntfs_debug("Entering, cb_size = 0x%x.", cb_size);
 do_next_sb:
 	ntfs_debug("Beginning sub-block at offset = 0x%zx in the cb.",
@@ -223,7 +225,6 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 				 */
 				handle_bounds_compressed_page(dp, i_size,
 						initialized_size);
-				kunmap_local(page_address(dp));
 				SetPageUptodate(dp);
 				unlock_page(dp);
 				if (di == xpage)
@@ -269,7 +270,8 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 	}
 
 	/* We have a valid destination page. Setup the destination pointers. */
-	dp_addr = (u8 *)page_address(dp) + do_sb_start;
+	dp_kaddr = kmap_local_page(dp);
+	dp_addr = dp_kaddr + do_sb_start;
 
 	/* Now, we are ready to process the current sub-block (sb). */
 	if (!(le16_to_cpup((__le16 *)cb) & NTFS_SB_IS_COMPRESSED)) {
@@ -290,6 +292,8 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 		/* Advance destination position to next sub-block. */
 		*dest_ofs += NTFS_SB_SIZE;
 		*dest_ofs &= ~PAGE_MASK;
+		kunmap_local(dp_kaddr);
+		dp_kaddr = NULL;
 		if (!(*dest_ofs)) {
 finalize_page:
 			/*
@@ -324,6 +328,8 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 		}
 		/* We have finished the current sub-block. */
 		*dest_ofs &= ~PAGE_MASK;
+		kunmap_local(dp_kaddr);
+		dp_kaddr = NULL;
 		if (!(*dest_ofs))
 			goto finalize_page;
 		goto do_next_sb;
@@ -429,6 +435,8 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 	goto do_next_tag;
 
 return_overflow:
+	if (dp_kaddr)
+		kunmap_local(dp_kaddr);
 	ntfs_error(NULL, "Failed. Returning -EOVERFLOW.");
 	goto return_error;
 }
@@ -557,7 +565,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 			 * least wasting our time.
 			 */
 			if (!PageDirty(page) && (!PageUptodate(page))) {
-				kmap_local_page(page);
 				continue;
 			}
 			unlock_page(page);
@@ -643,8 +650,7 @@ int ntfs_read_compressed_block(struct folio *folio)
 		}
 
 		lock_page(lpage);
-		memcpy(cb_pos, page_address(lpage) + page_ofs,
-		       vol->cluster_size);
+		memcpy_from_page(cb_pos, lpage, page_ofs, vol->cluster_size);
 		unlock_page(lpage);
 		put_page(lpage);
 		cb_pos += vol->cluster_size;
@@ -683,14 +689,7 @@ int ntfs_read_compressed_block(struct folio *folio)
 		for (; cur_page < cb_max_page; cur_page++) {
 			page = pages[cur_page];
 			if (page) {
-				if (likely(!cur_ofs))
-					clear_page(page_address(page));
-				else
-					memset(page_address(page) + cur_ofs, 0,
-							PAGE_SIZE -
-							cur_ofs);
-				flush_dcache_page(page);
-				kunmap_local(page_address(page));
+				memzero_page(page, cur_ofs, PAGE_SIZE - cur_ofs);
 				SetPageUptodate(page);
 				unlock_page(page);
 				if (cur_page == xpage)
@@ -708,8 +707,7 @@ int ntfs_read_compressed_block(struct folio *folio)
 		if (cb_max_ofs && cb_pos < cb_end) {
 			page = pages[cur_page];
 			if (page)
-				memset(page_address(page) + cur_ofs, 0,
-						cb_max_ofs - cur_ofs);
+				memzero_page(page, cur_ofs, cb_max_ofs - cur_ofs);
 			/*
 			 * No need to update cb_pos at this stage:
 			 *	cb_pos += cb_max_ofs - cur_ofs;
@@ -730,7 +728,7 @@ int ntfs_read_compressed_block(struct folio *folio)
 		for (; cur_page < cb_max_page; cur_page++) {
 			page = pages[cur_page];
 			if (page)
-				memcpy(page_address(page) + cur_ofs, cb_pos,
+				memcpy_to_page(page, cur_ofs, cb_pos,
 						PAGE_SIZE - cur_ofs);
 			cb_pos += PAGE_SIZE - cur_ofs;
 			cur_ofs = 0;
@@ -741,7 +739,7 @@ int ntfs_read_compressed_block(struct folio *folio)
 		if (cb_max_ofs && cb_pos < cb_end) {
 			page = pages[cur_page];
 			if (page)
-				memcpy(page_address(page) + cur_ofs, cb_pos,
+				memcpy_to_page(page, cur_ofs, cb_pos,
 						cb_max_ofs - cur_ofs);
 			cb_pos += cb_max_ofs - cur_ofs;
 			cur_ofs = cb_max_ofs;
@@ -758,7 +756,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 				 */
 				handle_bounds_compressed_page(page, i_size,
 						initialized_size);
-				kunmap_local(page_address(page));
 				SetPageUptodate(page);
 				unlock_page(page);
 				if (cur2_page == xpage)
@@ -794,7 +791,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 				page = pages[prev_cur_page];
 				if (page) {
 					flush_dcache_page(page);
-					kunmap_local(page_address(page));
 					unlock_page(page);
 					if (prev_cur_page != xpage)
 						put_page(page);
@@ -818,7 +814,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 				"Still have pages left! Terminating them with extreme prejudice.  Inode 0x%llx, page index 0x%lx.",
 				ni->mft_no, folio->index);
 			flush_dcache_folio(folio);
-			kunmap_local(page_address(page));
 			folio_unlock(folio);
 			if (cur_page != xpage)
 				folio_put(folio);
@@ -856,7 +851,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 		page = pages[i];
 		if (page) {
 			flush_dcache_page(page);
-			kunmap_local(page_address(page));
 			unlock_page(page);
 			if (i != xpage)
 				put_page(page);
@@ -1308,7 +1302,6 @@ static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
 		}
 		pages_disk[i] = pg;
 		lock_page(pg);
-		kmap_local_page(pg);
 	}
 
 	outbuf = vmap(pages_disk, pages_count, VM_MAP, PAGE_KERNEL);
@@ -1443,7 +1436,6 @@ static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
 	for (i = 0; i < pages_count; i++) {
 		pg = pages_disk[i];
 		if (pg) {
-			kunmap_local(page_address(pg));
 			unlock_page(pg);
 			put_page(pg);
 		}
-- 
2.25.1

