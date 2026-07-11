Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4631715C
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803569; cv=none; b=YKpKATVSy4LYDT9j8MZ4pVQcMtriVu9NGwW8x2MDwC2AoggDZLhvtdJLoNfC933AttZldQkxYZMps1jdnNeVCS9eAnDkRQJq3t9H90HrYNF5I28I7GC3kRd7Ecl6MMcY9+9REkvircWxXM9J7EioOqzmKg9fnjv6hGpC/9zsCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803569; c=relaxed/simple;
	bh=boYaWVocRfbrcKGoZTui9P+AmxLmomIzyo6TpT4aqOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHiuFJNzj6DT/jP8hVAABKB0GEfdWKtcy0cgSZkfM/lTGzkjM7g8KznRigJNfFhpfSwSg4zY2dldmCxD3Za/PUs3y7Rxs8hidxK8/6/fq42u2VId3NpffZ+r6m4+VgYCkAQhRf+9lZAwQJCiKp6Np3Q4l4QpWoGkYl/5hxrydD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRqvV3TN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRqvV3TN"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1032317a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783803566; x=1784408366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rE/h4apMqet61W9gglIUxnNvssBld20bJ32fR1C6+VY=;
        b=NRqvV3TNnWDkDeg1zcQttOtt4KsavLT2dWmMZFJeYC7lh9N7nkfdkjxpOhIdwP3G4X
         XDo8tdCxHhvZ/zx3SCmMMROImHclli2FoXAKTIhxK0wgXXS3+37Qcu1vq9QJkPMa7MHG
         DSNm7GnstWWLWfqh68fUPP0odD1Fhmjm9pUSDUVWLRqLDDuL5lllY6gkxy3WHbgHIk3K
         KUBH2ybcIRsk3grXVkAOT4L73cXJ7GX5rmbbF59IAMcGV4hk4sRkny2Tp7Fmf1odLkz5
         Phqz3o5YMoMb0fJFtJznQyYIojFzo9cOCTAtTFpHXusc0eSxjOxdbtfMO5wfovHnDSCU
         SaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803566; x=1784408366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rE/h4apMqet61W9gglIUxnNvssBld20bJ32fR1C6+VY=;
        b=iz6wJFTbh9VmPyHZ8ZzJ06xieSCHH+F+LeSZCU5SIsJU4ryev3VyndEYeQpnFYJDBl
         0OLnFOPvs8yVvnLXB6NBgFZqRVFKx65y+3Qlw7hwHn4AFM9SllQiydu259NA8kKHrKqD
         JeE+OHwte+Cj4Kq424HahR5yt/ed6Vf2y/w51hSJb+dtVfRheZE92hDJ5OJ0d9q441ZI
         wh/mZ05OVRymw49lEaXiio4bydgvMJ3YdTzlTabf1wmT6mXOFtWEL5U+vfO2tx3oXKOl
         X34yCvHyP/B3ZoF1gaPNkzgf6T+uqFfRUZisBtvZEKRJf+Q2Z7qznm8/gRTUI87R+yAZ
         y5mw==
X-Gm-Message-State: AOJu0Yztm/ZdqazDiCTWcxVDnZdquVKBgeJEGGKlWaheAnFWaNd6zpau
	rGBQ0bY7BMTXp4DMMof7I21/LaazeaVwjAl09Us7eScgcNciIGRWdmG8lxLNSQ==
X-Gm-Gg: AfdE7clMOFM2zXYdsgVpC0zy3uTajW7a3cWqOtyzaw0iR66GFAJWu8m55pbpFl/ZKTE
	4ip714Fdv99iYZEEgbRfywYNflNW0vlFzzF7doejQYlH1kxhG80e/t8gkqs1TK5Mr6QeJxlhT3Z
	O7BbOAIsV1qJpnFIJnx31MY4K89GSXfpDBxj/qZGMULjVOejiDgvJEj7O5H700gaw4CHIum7U1I
	On0+JYe1wEwjOjDhdhkYPXqxDyHff/rsdfK0LwZGw0+r3N+dsHa836STU2SOHyVoR2lc5CmTRNB
	itLmTfG6S3TtvQNoc7LESH5GIPh2WUR9OT+9aI/VoL2V7DZj+VTJJhjO2fPPl2xRARbxU/m8UdM
	F56HR+jDZenqiUxS90kHMGfCzpvK9i2iK+75R+Cv09+MygTbXTqgtE9TwIlcvRTs=
X-Received: by 2002:a05:6a00:893:b0:847:5ec4:9a1d with SMTP id d2e1a72fcca58-848897aca47mr3628664b3a.62.1783803566128;
        Sat, 11 Jul 2026 13:59:26 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm2092057b3a.20.2026.07.11.13.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:59:25 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v3 3/5] minix: update itree* files to add iomap functions
Date: Sat, 11 Jul 2026 13:59:07 -0700
Message-ID: <82e67921d4515cc88ad7df09bc3ccb8dffce0b89.1783707063.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783707063.git.jbingham@gmail.com>
References: <cover.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that iomap.c is in place, update itree_v1.c, itree_v2.c, and
itree_common.c to use iomap. This also updates the exports in minix.h,
adds a convenient helper function to get the right version of
minix_iomap_ops, and exports the previously static minix_aops struct
from inode.c.

There are a couple of odd things in here that need to be explicitly
called out and explained:

First, in itree_common.c there is now a check on inode->i_mapping->a_ops
where if it is equal to &minix_aops. If it is, it calls
iomap_truncate_page; otherwise, it calls block_truncate_page. This is
because unlike everything else directory operations still use
buffer_heads and have their own address_space_operations struct.

Second, instead of standing alone iomap.c is #included into itree_v1.c
and itree_v2.c the same way itree_common.c is. This is an existing
pattern that has been present in this module as far back as the git
history goes to accomodate the different block pointer sizes and number
of indirect block levels the different versions of the minix filesystem
has. The way it is now does look very strange, but it avoids massive
changes that might not be appreciated.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/inode.c        |  2 +-
 fs/minix/itree_common.c | 11 ++++++++++-
 fs/minix/itree_v1.c     | 25 ++++++++++++++++++++++++-
 fs/minix/itree_v2.c     | 17 ++++++++++++++++-
 fs/minix/minix.h        | 22 ++++++++++++++++++++--
 5 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index c30cc590698d..d5ba72f51049 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -490,7 +490,7 @@ static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping,block,minix_get_block);
 }
 
-static const struct address_space_operations minix_aops = {
+const struct address_space_operations minix_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = minix_read_folio,
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index c3cd2c75af9c..5a8b73a7beda 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -311,7 +311,16 @@ static inline void truncate (struct inode * inode)
 	long iblock;
 
 	iblock = (inode->i_size + sb->s_blocksize -1) >> sb->s_blocksize_bits;
-	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
+
+	/* Depending on what address space operations are being used by the
+	 * inode being truncated, we need to either call iomap_truncate_page or
+	 * block_truncate_page.
+	 */
+	if (inode->i_mapping->a_ops == &minix_aops)
+		iomap_truncate_page(inode, inode->i_size, NULL,
+			minix_iomap_ops_ver(inode), NULL, NULL);
+	else
+		block_truncate_page(inode->i_mapping, inode->i_size, get_block);
 
 	n = block_to_path(inode, iblock, offsets);
 	if (!n)
diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 1fed906042aa..58c29f4443d3 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -49,6 +49,18 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 }
 
 #include "itree_common.c"
+/* NOTA BENE:
+ *
+ * This is icky to me, but at the same time having it be a standalone C file
+ * that's compiled to object form and linked separately like one would think is
+ * much nastier in minix because of the different versions of the minix fs that
+ * have some very, very different aspects, like the size of block_t. I don't
+ * like it, but since minix already has this pattern where a common itree file
+ * is included in the itree_v1 and itree_v2(and v3) files, I'm including iomap.c
+ * in these files as well. It does at least avoid exporting some currently
+ * static functions that aren't needed anywhere but itree_common.c and iomap.c.
+ */
+#include "iomap.c"
 
 int V1_minix_get_block(struct inode * inode, long block,
 			struct buffer_head *bh_result, int create)
@@ -61,7 +73,18 @@ void V1_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V1_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
+
+int V1_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+}
+
+const struct iomap_ops V1_minix_iomap_ops = {
+	.iomap_begin = V1_minix_iomap_begin,
+	.iomap_end   = minix_iomap_end,
+};
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index 9d00f31a2d9d..fc7a5ae8fa1c 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -57,6 +57,10 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 }
 
 #include "itree_common.c"
+/* See the note in itree_v1 in a comment that starts "NOTA BENE" for an
+ * explanation for why iomap.c is included here.
+ */
+#include "iomap.c"
 
 int V2_minix_get_block(struct inode * inode, long block,
 			struct buffer_head *bh_result, int create)
@@ -69,7 +73,18 @@ void V2_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V2_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
+
+int V2_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+}
+
+const struct iomap_ops V2_minix_iomap_ops = {
+	.iomap_begin = V2_minix_iomap_begin,
+	.iomap_end   = minix_iomap_end,
+};
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 9e52d4302f0d..cf85edfb5bfa 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/minix_fs.h>
+#include <linux/iomap.h>
 
 #define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
 #define MINIX_V1		0x0001		/* original minix fs */
@@ -77,13 +78,24 @@ int minix_make_empty(struct inode*, struct inode*);
 int minix_empty_dir(struct inode*);
 int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		struct inode *inode);
+
 struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
 ino_t minix_inode_by_name(struct dentry*);
 
+extern int V1_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+extern int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+
+extern const struct address_space_operations minix_aops;
 extern const struct inode_operations minix_file_inode_operations;
 extern const struct inode_operations minix_dir_inode_operations;
 extern const struct file_operations minix_file_operations;
 extern const struct file_operations minix_dir_operations;
+extern const struct iomap_ops V1_minix_iomap_ops;
+extern const struct iomap_ops V2_minix_iomap_ops;
 
 static inline struct minix_sb_info *minix_sb(struct super_block *sb)
 {
@@ -95,11 +107,17 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 	return container_of(inode, struct minix_inode_info, vfs_inode);
 }
 
-static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
+static inline unsigned int minix_blocks_needed(unsigned int bits, unsigned int blocksize)
 {
 	return DIV_ROUND_UP_POW2(bits, blocksize * 8);
 }
 
+static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode *inode)
+{
+	return (INODE_VERSION(inode) == MINIX_V1) ?
+		&V1_minix_iomap_ops : &V2_minix_iomap_ops;
+}
+
 #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
 	defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
 
@@ -129,7 +147,7 @@ static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
  * big-endian 16bit indexed bitmaps
  */
 
-static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
+static inline int minix_find_first_zero_bit(const void *vaddr, unsigned int size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
 	unsigned short num;
-- 
2.47.3

