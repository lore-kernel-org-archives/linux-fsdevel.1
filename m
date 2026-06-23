Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C723ED6A;
	Tue, 23 Jun 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239413; cv=none; b=cocncTsETeR3VDjjvhKocFZmPRAEL7eHtTz2Q/dx7c4mImagJW3T8vXvyTIPjUiOekAOeHeJn56LNJpuk8j2TzNG21KwCo50xpX1rKVivjC7KaWymd0zWMnXQ81HqsS65CetKyc5RFvUiHzywL1WohNtXGcqUulS3+COVNQGhlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239413; c=relaxed/simple;
	bh=cauNCxemlfXcWdKrywV6jl2Ewg0CzuNZ2CxI6oHXkqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MLv/XV9nte9uJ0S98dyxrXMsakP08k+cu0V4RsmkgRvk1yNAkvu5lUI86KElhfXk0O47+dqZCAmyd9GnGQd9Dn/foKMCx3Qj4gYKSs7Hh8TGdfA8tXxYezjliSp55QCCQMLogAsVuXHc0CBQr4+9NK45THehzkwS4Qpgz5+SokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPjOnoxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPjOnoxu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A292FC2BCB8;
	Tue, 23 Jun 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782239412;
	bh=cauNCxemlfXcWdKrywV6jl2Ewg0CzuNZ2CxI6oHXkqE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VPjOnoxuLTqVHl7ZvukVqgulFO4xMB5R6wFS9ZHKZpXEiR9GAGYZQOhWsGY1sFl9y
	 REs5syZLps7uUu4Lk0vke77Ltbh7TNV8nZZ1JwtIymCd0A+VZPHWxqm9nPlV3NPbID
	 IxJURzYaazunqd1meAGjzFDB3o3IW+S2okcXtn8as6dn48mzdXF5KR0iyYu+0ZFZGB
	 bTogmA7X9/u/k3dJruZU0MZTmGnnvIbofsQxFufHqRSbRyv6X8LQ93kO5J3QLGmtNN
	 Vf9x17V3VPz1yDGnG067keu5IAzo/7YC+iStp+s+62ZcToi5+Bbir9SPasCISP2l7Y
	 1LRnH5U0iZs9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E346CDB46F;
	Tue, 23 Jun 2026 18:30:12 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 23 Jun 2026 13:30:11 -0500
Subject: [PATCH v2] cramfs: bound the XIP direct-mapping reads to the image
 size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-b4-disp-9da6aca1-v2-1-d681e7b7b76f@proton.me>
X-B4-Tracking: v=1; b=H4sIALLQOmoC/x3MTQqAIBBA4avIrBswC/u5SrQwHWs2JgoRiHdPW
 n6L9wpkSkwZVlEg0cOZ79CgOgH2MuEkZNcMSiottRrwGNFxjrg4o401PVq/9LMfpsNbCS2LiTy
 //3Lba/0ApjwfM2IAAAA=
To: Nicolas Pitre <nico@fluxnic.net>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782239410; l=6010;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=HZ4EqI8da2F69EBTgflMPcXggBhDyhlQuUpDNeOpteg=;
 b=n5IaVc6zSFmaSJiwSxBMaGona3KqtSveailGSW8V6bVHpQehRUP0tAjMXUEri/Vorx5pSrZCW
 l5pHHCdWr2kDfX7ElJtMCd7OAWUBRhWTCJUvxGh1TZalNqzf/0z8h+3
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

The physically-mapped (XIP) fast path dereferences the linear filesystem
image directly using offsets taken from the untrusted on-disk inode.
Unlike the normal read path (cramfs_direct_read()), neither
cramfs_get_block_range() nor cramfs_last_page_is_shared() bounds those
offsets against the image size before reading the block pointers and the
mapped data.  A crafted image with the CRAMFS_FLAG_EXT_BLOCK_POINTERS
feature and an out-of-range inode offset thus dereferences memory outside
the mapped image, and mmap()ing a regular file on it faults in the kernel.

Factor the bound cramfs_direct_read() already applies into a
cramfs_range_in_image() helper and use it for every linear-image
dereference in the XIP path, falling back to the bounded paging path on any
out-of-range access.

Fixes: eddcd97659e3 ("cramfs: add mmap support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: Per Christian Brauner's review, factor the four open-coded image-bounds
    checks into a shared cramfs_range_in_image() static inline (the same bound
    cramfs_direct_read() already applied), and use it on every XIP dereference
    plus in cramfs_direct_read() itself. No functional change from v1.
    v1: https://lore.kernel.org/all/20260607064146.302647-1-hexlabsecurity@proton.me/

The helper is the same predicate the v1 open-coded checks computed, verified
equivalent (no functional change):

  - Userspace AddressSanitizer, -m64 and -m32: the helper form is bit-identical
    to the v1 inline reject form on every boundary class (interior, exact-fit,
    one-over, off==size, off>size, len>size, huge-offset, and the 32-bit 4 GiB
    cross where sbi->size is a 32-bit unsigned long), and the unguarded deref
    faults exactly on the out-of-range rows while the guarded deref stays clean.
  - In-kernel KASAN: with the guard those rows are KASAN-clean; the unguarded
    one-past-the-end read is a KASAN slab-out-of-bounds ("0 bytes to the right
    of the allocated region").

Reproducer available on request.
---
 fs/cramfs/inode.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 4edbfccd0bbe..223d2eeca275 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -257,6 +257,20 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 	return read_buffers[buffer] + offset;
 }
 
+/*
+ * Return true if the byte range [offset, offset + len) lies within the
+ * mapped linear image.  Offsets and lengths used on the direct-mapping
+ * paths come from the (untrusted) on-disk inode, so every direct
+ * dereference of the image must pass this bound first.  The arguments are
+ * u64 so the page-count arithmetic in the callers cannot overflow, and the
+ * len check guards the size - len subtraction against underflow.
+ */
+static inline bool cramfs_range_in_image(struct cramfs_sb_info *sbi,
+					 u64 offset, u64 len)
+{
+	return len <= sbi->size && offset <= sbi->size - len;
+}
+
 /*
  * Return a pointer to the linearly addressed cramfs image in memory.
  */
@@ -267,7 +281,7 @@ static void *cramfs_direct_read(struct super_block *sb, unsigned int offset,
 
 	if (!len)
 		return NULL;
-	if (len > sbi->size || offset > sbi->size - len)
+	if (!cramfs_range_in_image(sbi, offset, len))
 		return page_address(ZERO_PAGE(0));
 	return sbi->linear_virt_addr + offset;
 }
@@ -298,13 +312,22 @@ static u32 cramfs_get_block_range(struct inode *inode, u32 pgoff, u32 *pages)
 {
 	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
 	int i;
-	u32 *blockptrs, first_block_addr;
+	u32 *blockptrs, first_block_addr, data_addr;
 
 	/*
 	 * We can dereference memory directly here as this code may be
 	 * reached only when there is a direct filesystem image mapping
 	 * available in memory.
+	 *
+	 * The block pointer array lives at OFFSET(inode) inside the image,
+	 * and both OFFSET() and the block pointers come from the (untrusted)
+	 * on-disk inode, so bound every access to the image before
+	 * dereferencing it.
 	 */
+	if (!cramfs_range_in_image(sbi, OFFSET(inode),
+				   ((u64)pgoff + *pages) * 4))
+		return 0;
+
 	blockptrs = (u32 *)(sbi->linear_virt_addr + OFFSET(inode) + pgoff * 4);
 	first_block_addr = blockptrs[0] & ~CRAMFS_BLK_FLAGS;
 	i = 0;
@@ -324,7 +347,13 @@ static u32 cramfs_get_block_range(struct inode *inode, u32 pgoff, u32 *pages)
 	} while (++i < *pages);
 
 	*pages = i;
-	return first_block_addr << CRAMFS_BLK_DIRECT_PTR_SHIFT;
+
+	/* The mapped data range must also lie within the image. */
+	data_addr = first_block_addr << CRAMFS_BLK_DIRECT_PTR_SHIFT;
+	if (!cramfs_range_in_image(sbi, data_addr, (u64)*pages * PAGE_SIZE))
+		return 0;
+
+	return data_addr;
 }
 
 #ifdef CONFIG_MMU
@@ -345,9 +374,21 @@ static bool cramfs_last_page_is_shared(struct inode *inode)
 	if (!partial)
 		return false;
 	last_page = inode->i_size >> PAGE_SHIFT;
+
+	/*
+	 * The block pointer and the tail data are read directly from the
+	 * image at offsets derived from the untrusted on-disk inode; bound
+	 * both accesses.  Treat the last page as shared on any overflow so
+	 * the caller falls back to the bounded paging path.
+	 */
+	if (!cramfs_range_in_image(sbi, OFFSET(inode),
+				   ((u64)last_page + 1) * 4))
+		return true;
 	blockptrs = (u32 *)(sbi->linear_virt_addr + OFFSET(inode));
 	blockaddr = blockptrs[last_page] & ~CRAMFS_BLK_FLAGS;
 	blockaddr <<= CRAMFS_BLK_DIRECT_PTR_SHIFT;
+	if (!cramfs_range_in_image(sbi, blockaddr, PAGE_SIZE))
+		return true;
 	tail_data = sbi->linear_virt_addr + blockaddr + partial;
 	return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;
 }

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260623-b4-disp-9da6aca1-cf918f37bfc0

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


