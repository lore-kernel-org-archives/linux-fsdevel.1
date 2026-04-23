Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E934402B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980003; cv=none; b=AGJWJUeLWmGbDfs2yvTLvijtxj++ZqrFrkE78nkP6JJHitECAeeEujzs+9q1GeWLIuPGf7EtzJbO90YTpb34TpyoHYCQjUgKvN0vkLsYEHf5uWM+qtN2oVa33oGFz5MLayY72xKddld3QdLrzy8WdN7SUZSIgRDEJ/qCqU4qTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980003; c=relaxed/simple;
	bh=HgTsfrGj1nc3Wh+9GYc0GuJMVDjCiD0eCArem+m4sBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6643MAFK9UW5BsUzBPAPprfO4MqkFfTEjKh5LMZziXsPiktfvEN/oUuOmP6XfyZsxNcO2eCVVspZ01n4+FZhKd6LwrAw6fPgREvMygqTHvxJq3CoSsuaEBeYYXz1VfWi0/oODZvKAyq/98c/F5DOkGBFCp8OHnLO81R+MN/U1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O48FIs+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O48FIs+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B78DC2BCAF;
	Thu, 23 Apr 2026 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776980003;
	bh=HgTsfrGj1nc3Wh+9GYc0GuJMVDjCiD0eCArem+m4sBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O48FIs+x7lkdgkjoz4FJJV/No1MdgK5f7Ls0duJNIFnxKwP/kG6lz3MeyjteS/y5w
	 DJhQJGA12sUW6vhc/fdOlFYdNtql7lk3SJHjdTRe9ODJeQtYVjWDRriWE4yflqv9pD
	 oEBAmwG4Km9t3cvU4MoVRCyut3aQCbpXoayPbah11NdWAKC8xwfjn+FFOCKacblPWN
	 hLb/gciS3ZQje3g2f9qvSLhK7tmfPCPVUkFQESkfmGszk8e+6b4Ml6BO5ErD4DymaV
	 LnaGBNTGIirOrRe3XiFqoGSxKUrSWzxPFF/ibta2ZXTPS42pwQwWCdadnpOy78Q1gt
	 v2w6+2kccQySg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: brauner@kernel.org,
	djwong@kernel.org,
	hyc.lee@gmail.com
Cc: willy@infradead.org,
	xiang@kernel.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 2/2] ntfs: use direct pointer for inline data to avoid redundant allocation
Date: Fri, 24 Apr 2026 06:32:03 +0900
Message-Id: <20260423213203.5533-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260423213203.5533-1-linkinjeon@kernel.org>
References: <20260423213203.5533-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, NTFS used page allocation for IOMAP_INLINE to ensure that
the inline_data pointer was page-aligned, avoiding strict boundary checks
in the iomap core. Since the previous patch has removed the over-strict
PAGE_SIZE boundary check in iomap, NTFS can now safely point
iomap::inline_data directly to the MFT record.
This change eliminates redundant memory allocations and memcpy operations
in both read and write paths. It also simplifies the iomap_ops by removing
the need for a iomap_end callback that was previously used to free
the temporary page.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/iomap.c | 76 ++++---------------------------------------------
 1 file changed, 6 insertions(+), 70 deletions(-)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 7a170df39e72..ca8e221e5b7b 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -89,7 +89,6 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	u32 attr_len;
 	int err = 0;
 	char *kattr;
-	struct page *ipage;
 
 	if (NInoAttr(ni))
 		base_ni = ni->ext.base_ntfs_ino;
@@ -130,18 +129,10 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 
 	kattr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
 
-	ipage = alloc_page(GFP_NOFS | __GFP_ZERO);
-	if (!ipage) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	memcpy(page_address(ipage), kattr, attr_len);
 	iomap->type = IOMAP_INLINE;
-	iomap->inline_data = page_address(ipage);
+	iomap->inline_data = kattr;
 	iomap->offset = 0;
 	iomap->length = attr_len;
-	iomap->private = ipage;
 
 out:
 	if (ctx)
@@ -286,21 +277,8 @@ static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t leng
 			srcmap, true);
 }
 
-static int ntfs_read_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-		ssize_t written, unsigned int flags, struct iomap *iomap)
-{
-	if (iomap->type == IOMAP_INLINE) {
-		struct page *ipage = iomap->private;
-
-		put_page(ipage);
-	}
-
-	return written;
-}
-
 const struct iomap_ops ntfs_read_iomap_ops = {
 	.iomap_begin = ntfs_read_iomap_begin,
-	.iomap_end = ntfs_read_iomap_end,
 };
 
 /*
@@ -358,7 +336,6 @@ static const struct iomap_ops ntfs_zero_read_iomap_ops = {
 
 const struct iomap_ops ntfs_seek_iomap_ops = {
 	.iomap_begin = ntfs_seek_iomap_begin,
-	.iomap_end = ntfs_read_iomap_end,
 };
 
 int ntfs_dio_zero_range(struct inode *inode, loff_t offset, loff_t length)
@@ -659,7 +636,6 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	u32 attr_len;
 	int err = 0;
 	char *kattr;
-	struct page *ipage;
 
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
 	if (!ctx) {
@@ -680,24 +656,18 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	attr_len = le32_to_cpu(a->data.resident.value_length);
 	kattr = (u8 *)a + le16_to_cpu(a->data.resident.value_offset);
 
-	ipage = alloc_page(GFP_NOFS | __GFP_ZERO);
-	if (!ipage) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	memcpy(page_address(ipage), kattr, attr_len);
 	iomap->type = IOMAP_INLINE;
-	iomap->inline_data = page_address(ipage);
+	iomap->inline_data = kattr;
 	iomap->offset = 0;
-	/* iomap requires there is only one INLINE_DATA extent */
 	iomap->length = attr_len;
-	iomap->private = ipage;
 
 out:
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
-	mutex_unlock(&ni->mrec_lock);
+
+	if (err)
+		mutex_unlock(&ni->mrec_lock);
+
 	return err;
 }
 
@@ -778,43 +748,9 @@ static int ntfs_write_iomap_end_resident(struct inode *inode, loff_t pos,
 					 unsigned int flags, struct iomap *iomap)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
-	struct ntfs_attr_search_ctx *ctx;
-	u32 attr_len;
-	int err;
-	char *kattr;
-	struct page *ipage = iomap->private;
-
-	mutex_lock(&ni->mrec_lock);
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
-	if (!ctx) {
-		written = -ENOMEM;
-		mutex_unlock(&ni->mrec_lock);
-		return written;
-	}
-
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			       CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (err) {
-		if (err == -ENOENT)
-			err = -EIO;
-		written = err;
-		goto err_out;
-	}
 
-	/* The total length of the attribute value. */
-	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
-	if (pos >= attr_len || pos + written > attr_len)
-		goto err_out;
-
-	kattr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
-	memcpy(kattr + pos, iomap_inline_data(iomap, pos), written);
-	mark_mft_record_dirty(ctx->ntfs_ino);
-err_out:
-	ntfs_attr_put_search_ctx(ctx);
-	put_page(ipage);
 	mutex_unlock(&ni->mrec_lock);
 	return written;
-
 }
 
 static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-- 
2.25.1

