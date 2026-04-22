Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE393CD8C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854802; cv=none; b=J9AqEv5Fnx/JwxASPAliGOLGbZbki6IypxdHF5lMLizTF+JOuPrZdpTdR0QinFi64UtqSLB6dh/iFMqxyIQspvrXF1olPYztFx2NYYAnxuyla60pUSa4kjsCAq3kfAq/G5y1HvJ33x5cw6tKKiKTpoYN56e1Y7tN/rs8ZI5KdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854802; c=relaxed/simple;
	bh=5lbpARbOkT3OQP+km4Ha3rgfNOdk4eo6s+8n598ed6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JgRKacyaEselKLbq8E7TAFcYoFh+7o2urROdvsNQ0gK92Yh4ShNsvUmR5V3Dp1nHi07Y8h8TXN+gmNrSL29Ow7jmISQ8NRGMPc4SbMIaE7O/MpccwB9GuINcRyqI1G7NhrTwsb088da+Bm3a23RftEN0oe191DNnYC5oO7cNpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDnT5HMN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDnT5HMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F879C2BCB3;
	Wed, 22 Apr 2026 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776854802;
	bh=5lbpARbOkT3OQP+km4Ha3rgfNOdk4eo6s+8n598ed6I=;
	h=From:To:Cc:Subject:Date:From;
	b=FDnT5HMNT58c4dpPtak1l/+TeWY0ReiRLZBphStlwWybMXTJG9jk50XDGt4FHOKhH
	 c5JP0XTp9rkmC5VLlSZVxe6QB+yRkv4qV19gACXlDAFHSk4wZbiWXIPEouR9q4MxRQ
	 2ynV/4xip+gRWmKTTxCE9tYKiSLU92BjhxR41LODRN9dCIsNARo7NYw5SJR/awFlY4
	 YR7oOlNd+JjNjop7IMeOtnBsNtGQdzL2CX1aIdepE9UJQnuxfHUZI8h09DmGT3dEHy
	 TEDqDXE620fE1WHjrKaSAzdy9TqHg0EyZTY3IMopM3RE/k6is6JtxYTOuSSRZHucuP
	 jTK5XhJbFn5bw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: use page allocation for resident attribute inline data
Date: Wed, 22 Apr 2026 19:46:27 +0900
Message-Id: <20260422104627.8193-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current kmemdup() based allocation for IOMAP_INLINE can result in
inline_data pointer having a non-zero page offset. This causes
iomap_inline_data_valid() to fail the check:

    iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data)

and triggers the kernel BUG at fs/iomap/buffered-io.c:1061.

This particularly affects workloads with frequent small file access
(e.g. Firefox Nightly profile on NTFS with bind mount) when using the
new ntfs. This fix this by allocating a full page with alloc_page() so that
page_address() always returns a page-aligned address.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/iomap.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 3d1458dea90f..74a4d3e971f4 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -89,6 +89,7 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	u32 attr_len;
 	int err = 0;
 	char *kattr;
+	struct page *ipage;
 
 	if (NInoAttr(ni))
 		base_ni = ni->ext.base_ntfs_ino;
@@ -129,15 +130,18 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 
 	kattr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
 
-	iomap->inline_data = kmemdup(kattr, attr_len, GFP_KERNEL);
-	if (!iomap->inline_data) {
+	ipage = alloc_page(GFP_NOFS | __GFP_ZERO);
+	if (!ipage) {
 		err = -ENOMEM;
 		goto out;
 	}
 
+	memcpy(page_address(ipage), kattr, attr_len);
 	iomap->type = IOMAP_INLINE;
+	iomap->inline_data = page_address(ipage);
 	iomap->offset = 0;
 	iomap->length = attr_len;
+	iomap->private = ipage;
 
 out:
 	if (ctx)
@@ -285,8 +289,11 @@ static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t leng
 static int ntfs_read_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
-	if (iomap->type == IOMAP_INLINE)
-		kfree(iomap->inline_data);
+	if (iomap->type == IOMAP_INLINE) {
+		struct page *ipage = iomap->private;
+
+		put_page(ipage);
+	}
 
 	return written;
 }
@@ -652,6 +659,7 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	u32 attr_len;
 	int err = 0;
 	char *kattr;
+	struct page *ipage;
 
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
 	if (!ctx) {
@@ -672,16 +680,19 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	attr_len = le32_to_cpu(a->data.resident.value_length);
 	kattr = (u8 *)a + le16_to_cpu(a->data.resident.value_offset);
 
-	iomap->inline_data = kmemdup(kattr, attr_len, GFP_KERNEL);
-	if (!iomap->inline_data) {
+	ipage = alloc_page(GFP_NOFS | __GFP_ZERO);
+	if (!ipage) {
 		err = -ENOMEM;
 		goto out;
 	}
 
+	memcpy(page_address(ipage), kattr, attr_len);
 	iomap->type = IOMAP_INLINE;
+	iomap->inline_data = page_address(ipage);
 	iomap->offset = 0;
 	/* iomap requires there is only one INLINE_DATA extent */
 	iomap->length = attr_len;
+	iomap->private = ipage;
 
 out:
 	if (ctx)
@@ -771,6 +782,7 @@ static int ntfs_write_iomap_end_resident(struct inode *inode, loff_t pos,
 	u32 attr_len;
 	int err;
 	char *kattr;
+	struct page *ipage = iomap->private;
 
 	mutex_lock(&ni->mrec_lock);
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
@@ -799,7 +811,7 @@ static int ntfs_write_iomap_end_resident(struct inode *inode, loff_t pos,
 	mark_mft_record_dirty(ctx->ntfs_ino);
 err_out:
 	ntfs_attr_put_search_ctx(ctx);
-	kfree(iomap->inline_data);
+	put_page(ipage);
 	mutex_unlock(&ni->mrec_lock);
 	return written;
 
-- 
2.25.1

