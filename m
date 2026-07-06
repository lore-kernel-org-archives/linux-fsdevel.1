Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B085306B37
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326962; cv=none; b=jk+R0xeAzaLRJlKaHIZuwXSIAzvnF1+K2dIvXlcUnLUdvcvfulLO9ehGgJf3geoWYKDFAO/tIycLwyBKLsEFPFhuVGAmMUDpuynGxO5KN06D0MKGjVqe+Y9ggJjEr66fipnXgTxJraGmhms611/plLDstxg8wi9Ykxtt+ofg0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326962; c=relaxed/simple;
	bh=JEDKuTGhTRGphnpCStLcvg1cTmBJ0zKma8m/3V+RiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGyEEPPBj85lLdtZdIav1VepoKIy4x7hf4pczsV7lcNz9uyRnPK6nDdbDFC3ygeMAsRZqblWH+Bw31iUyxr4ncjOp7GhSi33mY+cYM212ZtMLsIivTTVne1RI3ZhsdKbaBM01AwCd1EDQTk6wdN2qVXBSW3mvaIykf6g+tjkLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=si+0u1KI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si+0u1KI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cae134bdc8so13748095ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783326950; x=1783931750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUqgxIG0Zf9AkdA8MlYEMOcAlVA3mm5v6ky2VZcBuh8=;
        b=si+0u1KIoP4FZk9B2eZkjJdYQIV4isDxz7dygs64fwuC/rpFWr6y7jxNLGUnkwBg+K
         xrww+ebAgsbi2Bca9cEkAhYRrp13eS/+FVH/F4tB0qcVknWhr7Bgudo4KYAUQJoou/RS
         DYsk1wTPS0fyVPSFxvxR50ve9sNrmJEzhGQ5wrPBNfl7sMVUykkDGu3TUxsBKC81cNNC
         3j/tyVnM0/0Fol1FgP50a0OkXdzPq60hfsUX8jmVPCIfYiEzSgrKsvPnxYMzKA3tXf66
         4DbBQVbuAr+Pm1btYylZ05QqH6Vlcjmo81X5zaKtLM4X2dPQ1HCbVrA1VS2z/AGIqrXI
         EZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326950; x=1783931750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUqgxIG0Zf9AkdA8MlYEMOcAlVA3mm5v6ky2VZcBuh8=;
        b=Vwisraenx/2MHnJ68ikDQ8RXhsBlgHXqRcVtKGtZF8p1wyTwsLjylDGvI35dKQDf4T
         JOgQOj+Z0TVRGjFFYPxWirtY1XnSgnUkU7esWssyXJnQS1bBak4hHUHYmklYwkRyVpnh
         0/7Ti2nZSljyS4GwfDpz6u+5XPGfKf1u9T9xsAR3lprC8egPXd8c+32LS1aBXc0A4WMO
         4WjPYA/EWdMOXpss2bowf7GOv41DoL973dzhpak5O41hfTuLYWqSHlUGjLqp98nSipap
         69RMwmgHmhmoU98Y7CJvK1WGdo7HluCIajDJb+3wDkiZIf19K/lfBKNtjketwFGXIFqk
         KugQ==
X-Gm-Message-State: AOJu0YxYCjzREBOLwLFugDfVHwJsHg5VkyuRiizClOKihEJ30xjZUOyX
	d1lJj4W3b+t1L91g8RJdPLn1w1eQuvvx/NyH1aQDza2RfbPmFNKwZyqXFVHnqA==
X-Gm-Gg: AfdE7ckMZyDOEovKGldPT1VPYMu3nWhF38RvC8RDFL2EnGDPmBGjgakF3fCUsZQMgku
	EsvxrqzqIg+MYGu44M6z6HugHfYHwlS/fALRcwpzionQL9sEgDCHYbMOfeSoOhVUZyDxNoWH5aL
	DtiAWYRpo1CUm+dcNBpA1cV7XmyWQzizHO4PfS3af4pCcWccstcrDyyJ98g1/GKUS6B0yc9QJmq
	THA40AgtYWepgHkac5atlcZeMhadwJGwCYmcEPcSGHbNZaO8B6lC6bt+aH5G/ySRAaT5GWyhOIG
	CRbCNSz3cuaTCvsMdfK6uV1XB1A+x8bVmkPu7rzlOLMl9kkivpBppA/DgtMnyEr9XNXZs40cvUI
	KWfQ99vVD9r36/WyLtXuo5Ugne2PaEa7N6lrp+HpABqe7uWgqvFt4jXaVnBQEbB0=
X-Received: by 2002:a17:902:ef45:b0:2cc:86a9:ebfb with SMTP id d9443c01a7336-2cc86a9f157mr45078565ad.33.1783326949130;
        Mon, 06 Jul 2026 01:35:49 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccb0e77725sm5109815ad.71.2026.07.06.01.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:35:48 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [RFC PATCH 1/1] minix: unify the v1 and v2/v3 itree code paths
Date: Mon,  6 Jul 2026 01:35:36 -0700
Message-ID: <d9f07a9037d019043ed24d8245d9a58ce2c669f0.1783324260.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783324260.git.jbingham@gmail.com>
References: <cover.1783324260.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having two separate itree_v1.c and itree_v2.c files for the
different versions, this patch brings them together. Version 1 of the
Minix filesystem has doubly indirect block pointers and 16 bit block
pointers, while versions 2 and 3 have trebly indirect block pointers
and 32 bit block pointers. Both itree_v1.c and itree_v2.c then included
itree_common.c and provided version specific wrappers for
itree_common.c's functions. Code in other files would then call one
wrapper or the other depending on the filesystem's version number. All
of this was in lieu of just defining the number of direct blocks and
levels of indirect blocks in the superblock info struct. Now,
itree.c brings those paths together.

Added superblock info fields to the superblock info struct to store the
numbers of direct blocks and levels of indirect blocks inodes have, then
storing that information while filling the superblock struct. The
different versions of the minix filesystem have different levels of
indirect blocks, and this makes that information available in one
central place.

Also added a define for number of elements in the arrays in the union
in the inode information struct.

This patch also removes itree_v1.c and itree_v2.c from the Makefile,
adds itree.c in their place, deletes the dead itree files, removes some
wrapper functions in inode.c that aren't necessary anymore, update some
function calls in inode.c that no longer need versioned calls, and
update function definitions in minix.h.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/Makefile       |   2 +-
 fs/minix/inode.c        |  35 +-
 fs/minix/itree.c        | 744 ++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_common.c | 374 --------------------
 fs/minix/itree_v1.c     |  67 ----
 fs/minix/itree_v2.c     |  75 ----
 fs/minix/minix.h        |  26 +-
 7 files changed, 774 insertions(+), 549 deletions(-)
 create mode 100644 fs/minix/itree.c
 delete mode 100644 fs/minix/itree_common.c
 delete mode 100644 fs/minix/itree_v1.c
 delete mode 100644 fs/minix/itree_v2.c

diff --git a/fs/minix/Makefile b/fs/minix/Makefile
index a2d3ab58d187..a71fc7502597 100644
--- a/fs/minix/Makefile
+++ b/fs/minix/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_MINIX_FS) += minix.o
 
-minix-objs := bitmap.o itree_v1.o itree_v2.o namei.o inode.o file.o dir.o
+minix-objs := bitmap.o itree.o namei.o inode.o file.o dir.o
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index c30cc590698d..fa81f834aafc 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -298,6 +298,15 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 	} else
 		goto out_no_fs;
 
+	/* Set the direct block and indirect block depth now that the rest of
+	 * the version-specific settings have been set.
+	 */
+	sbi->s_direct = MINIX_DIRECT; /* Always the same. */
+	if (sbi->s_version == MINIX_V1)
+		sbi->s_depth = MINIX_V1_DEPTH;
+	else
+		sbi->s_depth = MINIX_V2_DEPTH;
+
 	if (!minix_check_superblock(s))
 		goto out_illegal_sb;
 
@@ -436,15 +445,6 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static int minix_get_block(struct inode *inode, sector_t block,
-		    struct buffer_head *bh_result, int create)
-{
-	if (INODE_VERSION(inode) == MINIX_V1)
-		return V1_minix_get_block(inode, block, bh_result, create);
-	else
-		return V2_minix_get_block(inode, block, bh_result, create);
-}
-
 static int minix_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -714,26 +714,13 @@ int minix_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 	if (INODE_VERSION(inode) == MINIX_V1)
-		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
+		stat->blocks = (BLOCK_SIZE / 512) * minix_blocks(stat->size, sb);
 	else
-		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size, sb);
+		stat->blocks = (sb->s_blocksize / 512) * minix_blocks(stat->size, sb);
 	stat->blksize = sb->s_blocksize;
 	return 0;
 }
 
-/*
- * The function that is called for file truncation.
- */
-void minix_truncate(struct inode * inode)
-{
-	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
-		return;
-	if (INODE_VERSION(inode) == MINIX_V1)
-		V1_minix_truncate(inode);
-	else
-		V2_minix_truncate(inode);
-}
-
 static struct file_system_type minix_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "minix",
diff --git a/fs/minix/itree.c b/fs/minix/itree.c
new file mode 100644
index 000000000000..7ebc5fca759a
--- /dev/null
+++ b/fs/minix/itree.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  linux/fs/minix/inode.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  Copyright (C) 1996  Gertjan van Wingerde
+ *	Minix V2 fs support.
+ *
+ *  Modified for 680x0 by Andreas Schwab
+ *  Updated to filesystem version 3 by Daniel Aragones
+ *
+ *  Disparate itree_v1.c, itree_v2.c, itree_common.c unified by Jeremy Bingham.
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+#include "minix.h"
+
+#define DIRCOUNT 7
+#define INDIRCOUNT(sb) (1 << ((sb)->s_blocksize_bits - 2))
+#define MINIX_V1_BLK 512
+#define MINIX_V1_BLK_SHIFT 9
+
+/* The different versions of the Minix filesystem also have different block
+ * sizes. In order to unify the itree functions and not have the split that's
+ * been in place for decades, we're going to have two separate types for v1 and
+ * v2/v3 block sizes. This does require having explicit version checks and
+ * casting block pointers to v1_block_t and a few cases where there's a special
+ * v1 version of a function that gets called where it's necessary to do it that
+ * way.
+ *
+ * To maintain type safety with this unified approach to the minix itree
+ * functions, both the direct and indirect block pointer data and structures
+ * need to use accessor functions. This way, the number of places that require
+ * conditionally casting block pointers can be kept confined to a few places
+ * while the general filesystem logic can be kept in common.
+ *
+ * NB: Formerly, this module had the itree functions split into three files:
+ *     - itree_v1.c, with defines, some inline helper functions, and wrapper
+ *       functions tailored to version 1 of the Minix filesystem.
+ *     - itree_v2.c, as above but for versions 2 and 3 of the Minix filesystem.
+ *     - itree_common.c, an aptly named file that held functions that were
+ *       common to both v1 and v2/v3 of the Minix filesystem.
+ *
+ * The odd part of this was that itree_v1.c and itree_v2.c each had their own
+ * definitions of DEPTH - 3 for v1, 4 for v2/v3, and their own special block_t
+ * typedefs. Version 1 only has doubly indirect blocks and 16 bit block
+ * pointers, while versions 2 and 3 have trebly indirect blocks and 32 bit
+ * block pointers. Both itree_v1.c and itree_v2.c then included itree_common.c
+ * and provided version specific wrappers for itree_common.c's functions. Code
+ * in other files would then call one wrapper or the other depending on the
+ * filesystem's version number. All of this was in lieu of just defining the
+ * number of direct blocks and levels of indirect blocks in the superblock info
+ * struct.
+ *
+ * While there are more explicit pointer casts here now, this code should
+ * hopefully be clearer than having two very similar but subtly different code
+ * paths where it is not always obvious what's different.
+ *
+ * Should anyone need to refer to the itree_v1.c, itree_v2.c, or itree_common.c
+ * files, the last master commit before they were merged and altered was
+ * 87320be9f0d24fce67631b7eef919f0b79c3e45c.
+ */
+
+typedef u32 block_t;
+typedef u16 v1_block_t;
+
+typedef struct {
+	void	*p;
+	block_t	key;
+	struct buffer_head *bh;
+	u8 is_v1;
+} Indirect;
+
+/* Accessor functions for Indirect structs to provide a unified interface for
+ * both v1 and v2/v3 filesystems. This way we can keep the number of places we
+ * need to dance around the different block sizes to a relative minimum.
+ */
+static inline block_t indir_get(Indirect *ip)
+{
+	if (ip->is_v1)
+		return *(v1_block_t *)ip->p;
+	return *(block_t *)ip->p;
+}
+
+static inline void indir_set(Indirect *ip, block_t n)
+{
+	if (ip->is_v1)
+		*(v1_block_t *)ip->p = (v1_block_t)n;
+	else
+		*(block_t *)ip->p = n;
+}
+
+static inline void indir_set_ptr(Indirect *ip, void *base, int offset)
+{
+	if (ip->is_v1)
+		ip->p = (v1_block_t *)base + offset;
+	else
+		ip->p = (block_t *)base + offset;
+}
+
+/* Pointer arithmetic where the poor block pointer is violently coerced into
+ * different forms depending on what block pointer size we're working with,
+ * which depends on the filesystem version.
+ */
+static inline block_t *blk_ptr_offset(void *base, int offset, u8 is_v1)
+{
+	block_t *p;
+
+	if (is_v1)
+		p = (block_t *)((v1_block_t *)base + offset);
+	else
+		p = (block_t *)base + offset;
+
+	return p;
+}
+
+static DEFINE_RWLOCK(pointers_lock);
+
+static inline v1_block_t block_to_v1_block(block_t n)
+{
+	return n;
+}
+
+static inline block_t v1_block_to_block(v1_block_t n)
+{
+	return n;
+}
+
+static inline unsigned long block_to_cpu(block_t n)
+{
+	return n;
+}
+
+static inline block_t cpu_to_block(unsigned long n)
+{
+	return n;
+}
+
+/* Use accessor functions for the i_data arrays in the inode info union instead
+ * of trying to forcibly coerce the u16 version into a u32 array. It might be
+ * a bit clunky, but it's not as fraught with peril as the headache of dealing
+ * with the allocated coerced u32 array floating around and potentially leaking
+ * accidentally.
+ */
+static inline block_t *i_data_get(struct inode *inode, int i)
+{
+	if (INODE_VERSION(inode) == MINIX_V1)
+		return (block_t *)(v1_block_t *)&minix_i(inode)->u.i1_data[i];
+	return (block_t *)&minix_i(inode)->u.i2_data[i];
+}
+
+static inline void i_data_set(struct inode *inode, int i, block_t n)
+{
+	if (INODE_VERSION(inode) == MINIX_V1)
+		minix_i(inode)->u.i1_data[i] = (v1_block_t)n;
+	else
+		minix_i(inode)->u.i2_data[i] = n;
+}
+
+static inline block_t i_data_read(struct inode *inode, int i)
+{
+	if (INODE_VERSION(inode) == MINIX_V1)
+		return minix_i(inode)->u.i1_data[i];
+	return minix_i(inode)->u.i2_data[i];
+}
+
+static inline int v1_block_to_path(struct inode *inode, long block, int *offsets)
+{
+	int n = 0;
+	struct super_block *sb = inode->i_sb;
+
+	if ((u64)block * BLOCK_SIZE >= sb->s_maxbytes)
+		return 0;
+
+	if (block < DIRCOUNT) {
+		offsets[n++] = block;
+	} else if ((block - DIRCOUNT) < MINIX_V1_BLK) {
+		block -= DIRCOUNT;
+		offsets[n++] = DIRCOUNT;
+		offsets[n++] = block;
+	} else {
+		block -= MINIX_V1_BLK;
+		offsets[n++] = DIRCOUNT + 1;
+		offsets[n++] = block>>MINIX_V1_BLK_SHIFT;
+		offsets[n++] = block & (MINIX_V1_BLK - 1);
+	}
+	return n;
+}
+
+static inline int v2_block_to_path(struct inode *inode, long block, int *offsets)
+{
+	int n = 0;
+	struct super_block *sb = inode->i_sb;
+
+	if ((u64)block * (u64)sb->s_blocksize >= sb->s_maxbytes)
+		return 0;
+
+	if (block < DIRCOUNT) {
+		offsets[n++] = block;
+	} else if ((block - DIRCOUNT) < INDIRCOUNT(sb)) {
+		block -= DIRCOUNT;
+		offsets[n++] = DIRCOUNT;
+		offsets[n++] = block;
+	} else if ((block - INDIRCOUNT(sb)) < INDIRCOUNT(sb) * INDIRCOUNT(sb)) {
+		block -= INDIRCOUNT(sb);
+		offsets[n++] = DIRCOUNT + 1;
+		offsets[n++] = block / INDIRCOUNT(sb);
+		offsets[n++] = block % INDIRCOUNT(sb);
+	} else {
+		block -= INDIRCOUNT(sb) * INDIRCOUNT(sb);
+		offsets[n++] = DIRCOUNT + 2;
+		offsets[n++] = (block / INDIRCOUNT(sb)) / INDIRCOUNT(sb);
+		offsets[n++] = (block / INDIRCOUNT(sb)) % INDIRCOUNT(sb);
+		offsets[n++] = block % INDIRCOUNT(sb);
+	}
+	return n;
+}
+
+/* *offsets has DEPTH elements. The exact value of DEPTH depends on whether or
+ * not this is a v1 minix fs or v2/v3.
+ *
+ * This function also unavoidably wraps version specific functions, because
+ * they're different enough that completely reconciling the two versions is
+ * pointless.
+ */
+static int block_to_path(struct inode *inode, long block, int *offsets)
+{
+	int ret = 0;
+
+	if (block < 0) {
+		pr_warn("MINIX-fs: %s: block %ld < 0 on dev %pg\n", __func__,
+			block, inode->i_sb->s_bdev);
+		return ret;
+	}
+
+	if (INODE_VERSION(inode) == MINIX_V1)
+		ret = v1_block_to_path(inode, block, offsets);
+	else
+		ret = v2_block_to_path(inode, block, offsets);
+
+	return ret;
+}
+
+static inline void add_chain(Indirect *p, struct buffer_head *bh, block_t *v, u8 is_v1)
+{
+	p->key = (is_v1) ? *(v1_block_t *)(p->p = v) : *(block_t *)(p->p = v);
+	p->bh = bh;
+	p->is_v1 = is_v1;
+}
+
+static inline int verify_chain(Indirect *from, Indirect *to)
+{
+	while (from <= to && from->key == indir_get(from))
+		from++;
+	return (from > to);
+}
+
+static inline block_t *block_end(struct buffer_head *bh)
+{
+	return (block_t *)((char *)bh->b_data + bh->b_size);
+}
+
+/* chain has DEPTH elements as described elsewhere. */
+static inline Indirect *get_branch(struct inode *inode,
+					int depth,
+					int *offsets,
+					Indirect *chain,
+					int *err)
+{
+	struct super_block *sb = inode->i_sb;
+	Indirect *p = chain;
+	struct buffer_head *bh;
+	u8 is_v1 = INODE_VERSION(inode) == MINIX_V1;
+
+	*err = 0;
+
+	add_chain(chain, NULL, i_data_get(inode, *offsets), is_v1);
+	if (!p->key)
+		goto no_block;
+	while (--depth) {
+		bh = sb_bread(sb, block_to_cpu(p->key));
+		if (!bh)
+			goto failure;
+		read_lock(&pointers_lock);
+		if (!verify_chain(chain, p))
+			goto changed;
+		add_chain(++p, bh, blk_ptr_offset(bh->b_data, *++offsets, is_v1), is_v1);
+		read_unlock(&pointers_lock);
+		if (!p->key)
+			goto no_block;
+	}
+	return NULL;
+
+changed:
+	read_unlock(&pointers_lock);
+	brelse(bh);
+	*err = -EAGAIN;
+	goto no_block;
+failure:
+	*err = -EIO;
+no_block:
+	return p;
+}
+
+static int alloc_branch(struct inode *inode,
+			     int num,
+			     int *offsets,
+			     Indirect *branch)
+{
+	int n = 0;
+	int i;
+	int parent = minix_new_block(inode);
+	int err = -ENOSPC;
+	u8 is_v1 = INODE_VERSION(inode) == MINIX_V1;
+
+	/* set is_v1 to be extra safe. Belt, suspenders, etc. */
+	branch[0].is_v1 = is_v1;
+	branch[0].key = cpu_to_block(parent);
+	if (parent)
+		for (n = 1; n < num; n++) {
+			struct buffer_head *bh;
+			/* Allocate the next block */
+			int nr = minix_new_block(inode);
+
+			if (!nr)
+				break;
+
+			branch[n].is_v1 = is_v1;
+			branch[n].key = cpu_to_block(nr);
+			bh = sb_getblk(inode->i_sb, parent);
+
+			if (!bh) {
+				minix_free_block(inode, nr);
+				err = -ENOMEM;
+				break;
+			}
+
+			lock_buffer(bh);
+			memset(bh->b_data, 0, bh->b_size);
+			branch[n].bh = bh;
+			indir_set_ptr(&branch[n], bh->b_data, offsets[n]);
+			indir_set(&branch[n], branch[n].key);
+			set_buffer_uptodate(bh);
+			unlock_buffer(bh);
+			mmb_mark_buffer_dirty(bh,
+				&minix_i(inode)->i_metadata_bhs);
+			parent = nr;
+		}
+	if (n == num)
+		return 0;
+
+	/* Allocation failed, free what we already allocated */
+	for (i = 1; i < n; i++)
+		bforget(branch[i].bh);
+	for (i = 0; i < n; i++)
+		minix_free_block(inode, block_to_cpu(branch[i].key));
+	return err;
+}
+
+/* same business with chain as before */
+static inline int splice_branch(struct inode *inode,
+				     Indirect *chain,
+				     Indirect *where,
+				     int num)
+{
+	int i;
+
+	write_lock(&pointers_lock);
+
+	/* Verify that place we are splicing to is still there and vacant */
+	if (!verify_chain(chain, where-1) || indir_get(where))
+		goto changed;
+
+	indir_set(where, where->key);
+
+	write_unlock(&pointers_lock);
+
+	/* We are done with atomic stuff, now do the rest of housekeeping */
+
+	inode_set_ctime_current(inode);
+
+	/* had we spliced it onto indirect block? */
+	if (where->bh)
+		mmb_mark_buffer_dirty(where->bh,
+				      &minix_i(inode)->i_metadata_bhs);
+
+	mark_inode_dirty(inode);
+	return 0;
+
+changed:
+	write_unlock(&pointers_lock);
+	for (i = 1; i < num; i++)
+		bforget(where[i].bh);
+	for (i = 0; i < num; i++)
+		minix_free_block(inode, block_to_cpu(where[i].key));
+	return -EAGAIN;
+}
+
+/* offsets and chain have DEPTH elements. Since DEPTH varies between versions of
+ * the minix filesystems, instead of having two different definitions of DEPTH
+ * and two different versions of this function just allocate the offsets and
+ * chain arrays dynamically. This does require remembering to free them.
+ */
+int minix_get_block(struct inode *inode, sector_t block,
+			struct buffer_head *bh, int create)
+{
+	struct super_block *sb = inode->i_sb;
+	struct minix_sb_info *sbi = minix_sb(sb);
+	u8 s_depth = sbi->s_depth;
+	int err = -EIO;
+	int *offsets = kmalloc_array(s_depth, sizeof(int), GFP_KERNEL);
+	Indirect *chain = kmalloc_array(s_depth, sizeof(Indirect), GFP_KERNEL);
+
+	if (offsets == NULL || chain == NULL) {
+		err = -ENOMEM;
+		if (offsets != NULL)
+			kfree(offsets);
+		if (chain != NULL)
+			kfree(chain);
+		goto out;
+	}
+
+	Indirect *partial;
+	int left;
+	int depth = block_to_path(inode, block, offsets);
+
+	if (depth == 0)
+		goto out;
+
+reread:
+	partial = get_branch(inode, depth, offsets, chain, &err);
+
+	/* Simplest case - block found, no allocation needed */
+	if (!partial) {
+got_it:
+		map_bh(bh, inode->i_sb, block_to_cpu(chain[depth-1].key));
+		/* Clean up and exit */
+		partial = chain+depth-1; /* the whole chain */
+		goto cleanup;
+	}
+
+	/* Next simple case - plain lookup or failed read of indirect block */
+	if (!create || err == -EIO) {
+cleanup:
+		while (partial > chain) {
+			brelse(partial->bh);
+			partial--;
+		}
+
+		kfree(offsets);
+		kfree(chain);
+out:
+		return err;
+	}
+
+	/*
+	 * Indirect block might be removed by truncate while we were
+	 * reading it. Handling of that case (forget what we've got and
+	 * reread) is taken out of the main path.
+	 */
+	if (err == -EAGAIN)
+		goto changed;
+
+	left = (chain + depth) - partial;
+	err = alloc_branch(inode, left, offsets+(partial-chain), partial);
+	if (err)
+		goto cleanup;
+
+	if (splice_branch(inode, chain, partial, left) < 0)
+		goto changed;
+
+	set_buffer_new(bh);
+	goto got_it;
+
+changed:
+	while (partial > chain) {
+		brelse(partial->bh);
+		partial--;
+	}
+	goto reread;
+}
+
+static inline int all_zeroes(Indirect *b, block_t *p, block_t *q)
+{
+	v1_block_t *pv1;
+	v1_block_t *qv1;
+
+	if (b->is_v1) {
+		pv1 = (v1_block_t *)p;
+		qv1 = (v1_block_t *)q;
+		while (pv1 < qv1)
+			if (*pv1++)
+				return 0;
+	} else {
+		while (p < q)
+			if (*p++)
+				return 0;
+	}
+
+	return 1;
+}
+
+/* offset and chains, etc. etc. */
+static Indirect *find_shared(struct inode *inode,
+				int depth,
+				int *offsets,
+				Indirect *chain,
+				block_t *top)
+{
+	Indirect *partial, *p;
+	int k, err;
+
+	*top = 0;
+	for (k = depth; k > 1 && !offsets[k-1]; k--)
+		;
+	partial = get_branch(inode, k, offsets, chain, &err);
+
+	write_lock(&pointers_lock);
+	if (!partial)
+		partial = chain + k-1;
+	if (!partial->key && indir_get(partial)) {
+		write_unlock(&pointers_lock);
+		goto no_top;
+	}
+	for (p = partial; p > chain && all_zeroes(p, (block_t *)p->bh->b_data,
+			(block_t *)p->p); p--)
+		;
+	if (p == chain + k - 1 && p > chain) {
+		indir_set_ptr(p, p->p, -1);
+	} else {
+		*top = indir_get(p);
+		indir_set(p, 0);
+	}
+	write_unlock(&pointers_lock);
+
+	while (partial > p) {
+		brelse(partial->bh);
+		partial--;
+	}
+no_top:
+	return partial;
+}
+
+static inline void v1_free_data(struct inode *inode, v1_block_t *p,
+		v1_block_t *q)
+{
+	unsigned long nr;
+
+	for ( ; p < q; p++) {
+		nr = block_to_cpu(v1_block_to_block(*p));
+		if (nr) {
+			*p = 0;
+			minix_free_block(inode, nr);
+		}
+	}
+}
+static inline void free_data(struct inode *inode, block_t *p, block_t *q)
+{
+	unsigned long nr;
+
+	/* Take the easy way out if we're minix v1. */
+	if (INODE_VERSION(inode) == MINIX_V1) {
+		v1_free_data(inode, (v1_block_t *)p, (v1_block_t *)q);
+		return;
+	}
+
+	for ( ; p < q ; p++) {
+		nr = block_to_cpu(*p);
+		if (nr) {
+			*p = 0;
+			minix_free_block(inode, nr);
+		}
+	}
+}
+
+/* Once again, the easy way out may well be the best. */
+static void v1_free_branches(struct inode *inode, v1_block_t *p,
+	v1_block_t *q, int depth)
+{
+	struct buffer_head *bh;
+	unsigned long nr;
+
+	/* At least in this function we can go straight to the v1 functions. */
+	if (depth--) {
+		for ( ; p < q ; p++) {
+			nr = block_to_cpu(v1_block_to_block(*p));
+			if (!nr)
+				continue;
+			*p = 0;
+			bh = sb_bread(inode->i_sb, nr);
+			if (!bh)
+				continue;
+			v1_free_branches(inode, (v1_block_t *)bh->b_data,
+				      (v1_block_t *)block_end(bh), depth);
+			bforget(bh);
+			minix_free_block(inode, nr);
+			mark_inode_dirty(inode);
+		}
+	} else
+		v1_free_data(inode, p, q);
+}
+
+static void free_branches(struct inode *inode, block_t *p, block_t *q,
+	int depth)
+{
+	struct buffer_head *bh;
+	unsigned long nr;
+
+	if (INODE_VERSION(inode) == MINIX_V1) {
+		v1_free_branches(inode, (v1_block_t *)p, (v1_block_t *)q,
+				depth);
+		return;
+	}
+
+	if (depth--) {
+		for ( ; p < q ; p++) {
+			nr = block_to_cpu(*p);
+			if (!nr)
+				continue;
+			*p = 0;
+			bh = sb_bread(inode->i_sb, nr);
+			if (!bh)
+				continue;
+			free_branches(inode, (block_t *)bh->b_data,
+				      block_end(bh), depth);
+			bforget(bh);
+			minix_free_block(inode, nr);
+			mark_inode_dirty(inode);
+		}
+	} else
+		free_data(inode, p, q);
+}
+
+/* The function called for file truncation. *offsets and *chain have DEPTH
+ * elements; the value of DEPTH depends on the version of the minix filesystem
+ * being worked with. Dynamically allocate and free offsets and chain with the
+ * appropriate DEPTH value for the filesystem in question.
+ */
+void minix_truncate(struct inode *inode)
+{
+	/* Instead of leaving this as an internal function wrapped by
+	 * minix_truncate in inode.c, just do the inode type check here before
+	 * we define and set any variables.
+	 */
+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
+		return;
+
+	struct super_block *sb = inode->i_sb;
+	struct minix_sb_info *sbi = minix_sb(sb);
+	u8 direct = sbi->s_direct;
+	u8 depth = sbi->s_depth;
+	int *offsets = kmalloc_array(depth, sizeof(int), GFP_KERNEL);
+	Indirect *chain = kmalloc_array(depth, sizeof(Indirect), GFP_KERNEL);
+	Indirect *partial;
+	block_t nr = 0;
+	int n;
+	int first_whole;
+	long iblock;
+
+	/* check for nullness, bail if anything failed. */
+	if (offsets == NULL || chain == NULL)
+		goto do_free;
+
+	iblock = (inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+	block_truncate_page(inode->i_mapping, inode->i_size, minix_get_block);
+
+	n = block_to_path(inode, iblock, offsets);
+	if (!n)
+		goto do_free;
+
+	if (n == 1) {
+		free_data(inode, i_data_get(inode, offsets[0]),
+			i_data_get(inode, direct));
+		first_whole = 0;
+		goto do_indirects;
+	}
+
+	first_whole = offsets[0] + 1 - direct;
+	partial = find_shared(inode, n, offsets, chain, &nr);
+	if (nr) {
+		if (partial == chain)
+			mark_inode_dirty(inode);
+		else
+			mmb_mark_buffer_dirty(partial->bh,
+					      &minix_i(inode)->i_metadata_bhs);
+		free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
+	}
+	/* Clear the ends of indirect blocks on the shared branch */
+	while (partial > chain) {
+		free_branches(inode, blk_ptr_offset(partial->p, 1,
+			partial->is_v1), block_end(partial->bh),
+				(chain+n-1) - partial);
+		mmb_mark_buffer_dirty(partial->bh,
+				      &minix_i(inode)->i_metadata_bhs);
+		brelse(partial->bh);
+		partial--;
+	}
+do_indirects:
+	/* Kill the remaining (whole) subtrees */
+	while (first_whole < depth-1) {
+		nr = i_data_read(inode, direct+first_whole);
+		if (nr) {
+			i_data_set(inode, direct+first_whole, 0);
+			mark_inode_dirty(inode);
+			free_branches(inode, &nr, &nr+1, first_whole+1);
+		}
+		first_whole++;
+	}
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	mark_inode_dirty(inode);
+
+do_free:
+	if (offsets != NULL)
+		kfree(offsets);
+	if (chain != NULL)
+		kfree(chain);
+}
+
+unsigned int minix_blocks(loff_t size, struct super_block *sb)
+{
+	struct minix_sb_info *sbi = minix_sb(sb);
+	int k = sb->s_blocksize_bits - 10;
+	unsigned int blocks, res;
+	unsigned int direct = sbi->s_direct;
+	unsigned int i = sbi->s_depth;
+
+	blocks = (size + sb->s_blocksize - 1) >> (BLOCK_SIZE_BITS + k);
+	res = blocks;
+	size_t bsize = (sbi->s_version == MINIX_V1) ? sizeof(v1_block_t) :
+			sizeof(block_t);
+
+	while (--i && blocks > direct) {
+		blocks -= direct;
+		blocks += sb->s_blocksize/bsize - 1;
+		blocks /= sb->s_blocksize/bsize;
+		res += blocks;
+		direct = 1;
+	}
+
+	return res;
+}
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
deleted file mode 100644
index c3cd2c75af9c..000000000000
--- a/fs/minix/itree_common.c
+++ /dev/null
@@ -1,374 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Generic part */
-
-typedef struct {
-	block_t	*p;
-	block_t	key;
-	struct buffer_head *bh;
-} Indirect;
-
-static DEFINE_RWLOCK(pointers_lock);
-
-static inline void add_chain(Indirect *p, struct buffer_head *bh, block_t *v)
-{
-	p->key = *(p->p = v);
-	p->bh = bh;
-}
-
-static inline int verify_chain(Indirect *from, Indirect *to)
-{
-	while (from <= to && from->key == *from->p)
-		from++;
-	return (from > to);
-}
-
-static inline block_t *block_end(struct buffer_head *bh)
-{
-	return (block_t *)((char*)bh->b_data + bh->b_size);
-}
-
-static inline Indirect *get_branch(struct inode *inode,
-					int depth,
-					int *offsets,
-					Indirect chain[DEPTH],
-					int *err)
-{
-	struct super_block *sb = inode->i_sb;
-	Indirect *p = chain;
-	struct buffer_head *bh;
-
-	*err = 0;
-	/* i_data is not going away, no lock needed */
-	add_chain (chain, NULL, i_data(inode) + *offsets);
-	if (!p->key)
-		goto no_block;
-	while (--depth) {
-		bh = sb_bread(sb, block_to_cpu(p->key));
-		if (!bh)
-			goto failure;
-		read_lock(&pointers_lock);
-		if (!verify_chain(chain, p))
-			goto changed;
-		add_chain(++p, bh, (block_t *)bh->b_data + *++offsets);
-		read_unlock(&pointers_lock);
-		if (!p->key)
-			goto no_block;
-	}
-	return NULL;
-
-changed:
-	read_unlock(&pointers_lock);
-	brelse(bh);
-	*err = -EAGAIN;
-	goto no_block;
-failure:
-	*err = -EIO;
-no_block:
-	return p;
-}
-
-static int alloc_branch(struct inode *inode,
-			     int num,
-			     int *offsets,
-			     Indirect *branch)
-{
-	int n = 0;
-	int i;
-	int parent = minix_new_block(inode);
-	int err = -ENOSPC;
-
-	branch[0].key = cpu_to_block(parent);
-	if (parent) for (n = 1; n < num; n++) {
-		struct buffer_head *bh;
-		/* Allocate the next block */
-		int nr = minix_new_block(inode);
-		if (!nr)
-			break;
-		branch[n].key = cpu_to_block(nr);
-		bh = sb_getblk(inode->i_sb, parent);
-		if (!bh) {
-			minix_free_block(inode, nr);
-			err = -ENOMEM;
-			break;
-		}
-		lock_buffer(bh);
-		memset(bh->b_data, 0, bh->b_size);
-		branch[n].bh = bh;
-		branch[n].p = (block_t*) bh->b_data + offsets[n];
-		*branch[n].p = branch[n].key;
-		set_buffer_uptodate(bh);
-		unlock_buffer(bh);
-		mmb_mark_buffer_dirty(bh, &minix_i(inode)->i_metadata_bhs);
-		parent = nr;
-	}
-	if (n == num)
-		return 0;
-
-	/* Allocation failed, free what we already allocated */
-	for (i = 1; i < n; i++)
-		bforget(branch[i].bh);
-	for (i = 0; i < n; i++)
-		minix_free_block(inode, block_to_cpu(branch[i].key));
-	return err;
-}
-
-static inline int splice_branch(struct inode *inode,
-				     Indirect chain[DEPTH],
-				     Indirect *where,
-				     int num)
-{
-	int i;
-
-	write_lock(&pointers_lock);
-
-	/* Verify that place we are splicing to is still there and vacant */
-	if (!verify_chain(chain, where-1) || *where->p)
-		goto changed;
-
-	*where->p = where->key;
-
-	write_unlock(&pointers_lock);
-
-	/* We are done with atomic stuff, now do the rest of housekeeping */
-
-	inode_set_ctime_current(inode);
-
-	/* had we spliced it onto indirect block? */
-	if (where->bh)
-		mmb_mark_buffer_dirty(where->bh,
-				      &minix_i(inode)->i_metadata_bhs);
-
-	mark_inode_dirty(inode);
-	return 0;
-
-changed:
-	write_unlock(&pointers_lock);
-	for (i = 1; i < num; i++)
-		bforget(where[i].bh);
-	for (i = 0; i < num; i++)
-		minix_free_block(inode, block_to_cpu(where[i].key));
-	return -EAGAIN;
-}
-
-static int get_block(struct inode * inode, sector_t block,
-			struct buffer_head *bh, int create)
-{
-	int err = -EIO;
-	int offsets[DEPTH];
-	Indirect chain[DEPTH];
-	Indirect *partial;
-	int left;
-	int depth = block_to_path(inode, block, offsets);
-
-	if (depth == 0)
-		goto out;
-
-reread:
-	partial = get_branch(inode, depth, offsets, chain, &err);
-
-	/* Simplest case - block found, no allocation needed */
-	if (!partial) {
-got_it:
-		map_bh(bh, inode->i_sb, block_to_cpu(chain[depth-1].key));
-		/* Clean up and exit */
-		partial = chain+depth-1; /* the whole chain */
-		goto cleanup;
-	}
-
-	/* Next simple case - plain lookup or failed read of indirect block */
-	if (!create || err == -EIO) {
-cleanup:
-		while (partial > chain) {
-			brelse(partial->bh);
-			partial--;
-		}
-out:
-		return err;
-	}
-
-	/*
-	 * Indirect block might be removed by truncate while we were
-	 * reading it. Handling of that case (forget what we've got and
-	 * reread) is taken out of the main path.
-	 */
-	if (err == -EAGAIN)
-		goto changed;
-
-	left = (chain + depth) - partial;
-	err = alloc_branch(inode, left, offsets+(partial-chain), partial);
-	if (err)
-		goto cleanup;
-
-	if (splice_branch(inode, chain, partial, left) < 0)
-		goto changed;
-
-	set_buffer_new(bh);
-	goto got_it;
-
-changed:
-	while (partial > chain) {
-		brelse(partial->bh);
-		partial--;
-	}
-	goto reread;
-}
-
-static inline int all_zeroes(block_t *p, block_t *q)
-{
-	while (p < q)
-		if (*p++)
-			return 0;
-	return 1;
-}
-
-static Indirect *find_shared(struct inode *inode,
-				int depth,
-				int offsets[DEPTH],
-				Indirect chain[DEPTH],
-				block_t *top)
-{
-	Indirect *partial, *p;
-	int k, err;
-
-	*top = 0;
-	for (k = depth; k > 1 && !offsets[k-1]; k--)
-		;
-	partial = get_branch(inode, k, offsets, chain, &err);
-
-	write_lock(&pointers_lock);
-	if (!partial)
-		partial = chain + k-1;
-	if (!partial->key && *partial->p) {
-		write_unlock(&pointers_lock);
-		goto no_top;
-	}
-	for (p=partial;p>chain && all_zeroes((block_t*)p->bh->b_data,p->p);p--)
-		;
-	if (p == chain + k - 1 && p > chain) {
-		p->p--;
-	} else {
-		*top = *p->p;
-		*p->p = 0;
-	}
-	write_unlock(&pointers_lock);
-
-	while(partial > p)
-	{
-		brelse(partial->bh);
-		partial--;
-	}
-no_top:
-	return partial;
-}
-
-static inline void free_data(struct inode *inode, block_t *p, block_t *q)
-{
-	unsigned long nr;
-
-	for ( ; p < q ; p++) {
-		nr = block_to_cpu(*p);
-		if (nr) {
-			*p = 0;
-			minix_free_block(inode, nr);
-		}
-	}
-}
-
-static void free_branches(struct inode *inode, block_t *p, block_t *q, int depth)
-{
-	struct buffer_head * bh;
-	unsigned long nr;
-
-	if (depth--) {
-		for ( ; p < q ; p++) {
-			nr = block_to_cpu(*p);
-			if (!nr)
-				continue;
-			*p = 0;
-			bh = sb_bread(inode->i_sb, nr);
-			if (!bh)
-				continue;
-			free_branches(inode, (block_t*)bh->b_data,
-				      block_end(bh), depth);
-			bforget(bh);
-			minix_free_block(inode, nr);
-			mark_inode_dirty(inode);
-		}
-	} else
-		free_data(inode, p, q);
-}
-
-static inline void truncate (struct inode * inode)
-{
-	struct super_block *sb = inode->i_sb;
-	block_t *idata = i_data(inode);
-	int offsets[DEPTH];
-	Indirect chain[DEPTH];
-	Indirect *partial;
-	block_t nr = 0;
-	int n;
-	int first_whole;
-	long iblock;
-
-	iblock = (inode->i_size + sb->s_blocksize -1) >> sb->s_blocksize_bits;
-	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
-
-	n = block_to_path(inode, iblock, offsets);
-	if (!n)
-		return;
-
-	if (n == 1) {
-		free_data(inode, idata+offsets[0], idata + DIRECT);
-		first_whole = 0;
-		goto do_indirects;
-	}
-
-	first_whole = offsets[0] + 1 - DIRECT;
-	partial = find_shared(inode, n, offsets, chain, &nr);
-	if (nr) {
-		if (partial == chain)
-			mark_inode_dirty(inode);
-		else
-			mmb_mark_buffer_dirty(partial->bh,
-					      &minix_i(inode)->i_metadata_bhs);
-		free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
-	}
-	/* Clear the ends of indirect blocks on the shared branch */
-	while (partial > chain) {
-		free_branches(inode, partial->p + 1, block_end(partial->bh),
-				(chain+n-1) - partial);
-		mmb_mark_buffer_dirty(partial->bh,
-				      &minix_i(inode)->i_metadata_bhs);
-		brelse (partial->bh);
-		partial--;
-	}
-do_indirects:
-	/* Kill the remaining (whole) subtrees */
-	while (first_whole < DEPTH-1) {
-		nr = idata[DIRECT+first_whole];
-		if (nr) {
-			idata[DIRECT+first_whole] = 0;
-			mark_inode_dirty(inode);
-			free_branches(inode, &nr, &nr+1, first_whole+1);
-		}
-		first_whole++;
-	}
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-	mark_inode_dirty(inode);
-}
-
-static inline unsigned nblocks(loff_t size, struct super_block *sb)
-{
-	int k = sb->s_blocksize_bits - 10;
-	unsigned blocks, res, direct = DIRECT, i = DEPTH;
-	blocks = (size + sb->s_blocksize - 1) >> (BLOCK_SIZE_BITS + k);
-	res = blocks;
-	while (--i && blocks > direct) {
-		blocks -= direct;
-		blocks += sb->s_blocksize/sizeof(block_t) - 1;
-		blocks /= sb->s_blocksize/sizeof(block_t);
-		res += blocks;
-		direct = 1;
-	}
-	return res;
-}
diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
deleted file mode 100644
index 1fed906042aa..000000000000
--- a/fs/minix/itree_v1.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/buffer_head.h>
-#include <linux/slab.h>
-#include "minix.h"
-
-enum {DEPTH = 3, DIRECT = 7};	/* Only double indirect */
-
-typedef u16 block_t;	/* 16 bit, host order */
-
-static inline unsigned long block_to_cpu(block_t n)
-{
-	return n;
-}
-
-static inline block_t cpu_to_block(unsigned long n)
-{
-	return n;
-}
-
-static inline block_t *i_data(struct inode *inode)
-{
-	return (block_t *)minix_i(inode)->u.i1_data;
-}
-
-static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
-{
-	int n = 0;
-
-	if (block < 0) {
-		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
-			block, inode->i_sb->s_bdev);
-		return 0;
-	}
-	if ((u64)block * BLOCK_SIZE >= inode->i_sb->s_maxbytes)
-		return 0;
-
-	if (block < 7) {
-		offsets[n++] = block;
-	} else if ((block -= 7) < 512) {
-		offsets[n++] = 7;
-		offsets[n++] = block;
-	} else {
-		block -= 512;
-		offsets[n++] = 8;
-		offsets[n++] = block>>9;
-		offsets[n++] = block & 511;
-	}
-	return n;
-}
-
-#include "itree_common.c"
-
-int V1_minix_get_block(struct inode * inode, long block,
-			struct buffer_head *bh_result, int create)
-{
-	return get_block(inode, block, bh_result, create);
-}
-
-void V1_minix_truncate(struct inode * inode)
-{
-	truncate(inode);
-}
-
-unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
-{
-	return nblocks(size, sb);
-}
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
deleted file mode 100644
index 9d00f31a2d9d..000000000000
--- a/fs/minix/itree_v2.c
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/buffer_head.h>
-#include "minix.h"
-
-enum {DIRECT = 7, DEPTH = 4};	/* Have triple indirect */
-
-typedef u32 block_t;	/* 32 bit, host order */
-
-static inline unsigned long block_to_cpu(block_t n)
-{
-	return n;
-}
-
-static inline block_t cpu_to_block(unsigned long n)
-{
-	return n;
-}
-
-static inline block_t *i_data(struct inode *inode)
-{
-	return (block_t *)minix_i(inode)->u.i2_data;
-}
-
-#define DIRCOUNT 7
-#define INDIRCOUNT(sb) (1 << ((sb)->s_blocksize_bits - 2))
-
-static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
-{
-	int n = 0;
-	struct super_block *sb = inode->i_sb;
-
-	if (block < 0) {
-		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
-			block, sb->s_bdev);
-		return 0;
-	}
-	if ((u64)block * (u64)sb->s_blocksize >= sb->s_maxbytes)
-		return 0;
-
-	if (block < DIRCOUNT) {
-		offsets[n++] = block;
-	} else if ((block -= DIRCOUNT) < INDIRCOUNT(sb)) {
-		offsets[n++] = DIRCOUNT;
-		offsets[n++] = block;
-	} else if ((block -= INDIRCOUNT(sb)) < INDIRCOUNT(sb) * INDIRCOUNT(sb)) {
-		offsets[n++] = DIRCOUNT + 1;
-		offsets[n++] = block / INDIRCOUNT(sb);
-		offsets[n++] = block % INDIRCOUNT(sb);
-	} else {
-		block -= INDIRCOUNT(sb) * INDIRCOUNT(sb);
-		offsets[n++] = DIRCOUNT + 2;
-		offsets[n++] = (block / INDIRCOUNT(sb)) / INDIRCOUNT(sb);
-		offsets[n++] = (block / INDIRCOUNT(sb)) % INDIRCOUNT(sb);
-		offsets[n++] = block % INDIRCOUNT(sb);
-	}
-	return n;
-}
-
-#include "itree_common.c"
-
-int V2_minix_get_block(struct inode * inode, long block,
-			struct buffer_head *bh_result, int create)
-{
-	return get_block(inode, block, bh_result, create);
-}
-
-void V2_minix_truncate(struct inode * inode)
-{
-	truncate(inode);
-}
-
-unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
-{
-	return nblocks(size, sb);
-}
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f2025c9b5825..bd5ce88db69f 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -11,13 +11,21 @@
 #define MINIX_V2		0x0002		/* minix V2 fs */
 #define MINIX_V3		0x0003		/* minix V3 fs */
 
+/* Block storage layout. All versions have 7 direct blocks, but they have
+ * differing depths: V1 only has doubly indirect blocks, while V2/V3 have
+ * trebly indirect blocks. Thus, V1 depth is 3 while V2 and V3 are 4.
+ */
+enum {MINIX_DIRECT = 7, MINIX_V1_DEPTH = 3, MINIX_V2_DEPTH = 4};
+
 /*
  * minix fs inode data in memory
  */
+#define MINIX_INODE_DATA_ELEMENTS 16
+
 struct minix_inode_info {
 	union {
-		__u16 i1_data[16];
-		__u32 i2_data[16];
+		__u16 i1_data[MINIX_INODE_DATA_ELEMENTS];
+		__u32 i2_data[MINIX_INODE_DATA_ELEMENTS];
 	} u;
 	struct mapping_metadata_bhs i_metadata_bhs;
 	struct inode vfs_inode;
@@ -41,6 +49,11 @@ struct minix_sb_info {
 	struct minix_super_block * s_ms;
 	unsigned short s_mount_state;
 	unsigned short s_version;
+	/* Just set the # of direct blocks and depth of indirect blocks once
+	 * in the sb info instead of having split itree functions and all that.
+	 */
+	unsigned short s_direct;
+	unsigned short s_depth;
 };
 
 void __minix_error_inode(struct inode *inode, const char *function,
@@ -61,14 +74,11 @@ int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 
-extern void V1_minix_truncate(struct inode *);
-extern void V2_minix_truncate(struct inode *);
 extern void minix_truncate(struct inode *);
 extern void minix_set_inode(struct inode *, dev_t);
-extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern unsigned V1_minix_blocks(loff_t, struct super_block *);
-extern unsigned V2_minix_blocks(loff_t, struct super_block *);
+extern int minix_get_block(struct inode *inode, sector_t block,
+		struct buffer_head *bh, int create);
+extern unsigned int minix_blocks(loff_t size, struct super_block *sb);
 
 struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio **);
 int minix_add_link(struct dentry*, struct inode*);
-- 
2.47.3

