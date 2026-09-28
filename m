Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6ED4F3930
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625880; cv=none; b=qJr2JP0dtWDvl46UvVn2Fh0Gs7ik4jRTkNYu+cL/DosvMCM/HWMC5Tbxz1LVsmVv/DEyNpxQl9aboBG3oNx3biXiRngowkX0q6viWriq6E6/Hmucc5UDag19YK3jsrc8oIzxfRc444CD6KOq1dTc5yV/nWOmDXuypr5i4SOKJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625880; c=relaxed/simple;
	bh=d9nL9I6R3DveoH1VMpvRLjKSP7r6/lxGxPf+d6sGZQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atwiZmK2RZhEbDXzK4b6+hcpJrz1tmJw+1+jQsOinQj1N7ypl0LL8QuH5v5Onz0pbUHf0goLmPCBaa7F2gtutR/rLR4EaGAxs1qxM2y8Th/56jBPvVF0j5ptfF9yb8g0o+PZWORUzwEwy8Fj3hAHznDob4cNHw/Jra3cEGfl3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPlFegb9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPlFegb9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so1298383a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625877; x=1791230677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vs9qES+0w4GRNlGVbpqn0JZK4q5Urbf1sGBldeOBkj4=;
        b=bPlFegb938A38/ZgBWALxvV5fxOD6w29RCA0u7vvZaLLTM4vIUQf29Ozp+iyiHLGcf
         KZQKaaIxA8gfqyfROR2kWLTGDVKNwZXN9dT/d/HAW3YEqUV5EfW6X1/7qnxourKkef4s
         dYl0kQRrHhBsAgRGEZg25ZFHmCO9O9V+nvz8/Ek6WjRRJ+5IsKzsAzle2ywkcvFvimea
         x8j6iEbZEOKUdg80ySKmyThF5zQglynebIyGmsrTsf5bhXu5K9MFbkhVElkJX3Uzfe4W
         8M38465HaW5k2JAOVbFsmRYYFSjBMVzLF+uGkcRyzA6yJ6PPtRf4iwmAMT+eSSfYLDli
         sFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625877; x=1791230677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vs9qES+0w4GRNlGVbpqn0JZK4q5Urbf1sGBldeOBkj4=;
        b=T3n/vFbl7ay3+13WNXmqV/t0Z7/pgzY4cJr82HuirRNvIVrnQVE65Fg9kvEfbiVZHM
         jKrR/PgxYC9AN/jSnekP2/v6eDerwlTynaLN3aCY7cwDTdM5oguvKd3KNuNtg5Sci5lr
         uZH1lBLUMZPonzOxd32knslzdTPGm1VEHFc8ub9ZrLG/Yasd9bb2Xvipj2Em23Xj7uyB
         YOj8ykog7ktfK54Gn2SkOeM5n9bR7FVblYZm4jClGQfHHUwDDNok8n1O0FTgrZRJGIUN
         2ROT+qixD/fMnBpT3dHtCzpkh/q6qGh6BG5DTRWV+qyDptsIKTjScEH0WUMCOenFR0p8
         cnbA==
X-Gm-Message-State: AFq9FYJFgiCrlQ3hX1ddGcDQ9lL27fTMgW4nlvfRWGip6JZUK9+lUS2N
	O39YEqd7cLarJi75v4NxljjyNIb8xzve/57rL431TSU3CWeueoY0B8A4S3do+GYS
X-Gm-Gg: AYBFou1bEtp237Hwr3lYIXIH2LdTFl0pP23QJ7e3V2FRUTnRAXWjOCjDw3TWhGOnwq0
	y+PD2JREfcNB5XOmECmAzJM1UJwf7i9N531SOD/kowTvxA6UoforfIMZyX0mfdXoyiJHZoX2nOu
	tUF6FC4AxM5qo1W3YFUlzP1OF/divZpKyK7sOqQR5gPgoJ4gh8d2a5fGkOCjwFPpOAzZMZIgRl8
	uImJlJ3x250piXYGpthUL6Hl2M/hSEK8vJcIUEHeBUPf0AjV5Mdw1v1uBND3F08N746OHfMLoE7
	aTa9CrGPO5qnNnFSKlVj4RlOD1SytOyIGy17NcalwWo0d/Z6PK8ce/JzZzWgfdWrqccwhRq7wou
	divg5BrCBUzsPbwVxl23oB4byGuzswxjkRwrnHC8fPMs279yB91N5FDyUKfDfOjmx2gQZEDTHz4
	HnzYI6jvB06hPmIly3rOgkQusCimSpQOd/EUMAJOq66MtHd6+zivm4mEphdGXHMD6cWn2x7v9y7
	7CSE+i/QorE/hjt74+QwzOlRlDsEEFF7Gg=
X-Received: by 2002:a17:90b:5102:b0:3a0:78b6:588e with SMTP id 98e67ed59e1d1-3a49c165d3emr140654a91.23.1790625876362;
        Mon, 28 Sep 2026 13:04:36 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498057a62sm1049038a91.13.2026.09.28.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:04:35 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	hch@infradead.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v1 1/1] minix: consolidate itree* files into one itree.c file
Date: Mon, 28 Sep 2026 13:04:26 -0700
Message-ID: <29e5bed16cef4904e9649a9b77d42ec10cd33051.1790359547.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790359547.git.jbingham@gmail.com>
References: <cover.1790359547.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the itree functions by adding fields to the superblock info
struct to store the number of direct blocks and levels of indirect
blocks because the different versions of the minix filesystems have
differing numbers of indirect block pointers and different block pointer
sizes. This allows consolidating the itree functions into one itree.c
file instead of a system with version specific itree files with version
specific definitions and wrapper functions that #include a common
itree_common.c file that are in turn called by wrapper functions
elsewhere in the code that call the version specific wrapper functions.

No functional changes are intended for this patch. 

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/Makefile       |   2 +-
 fs/minix/inode.c        |  38 +--
 fs/minix/itree.c        | 672 ++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_common.c | 374 ----------------------
 fs/minix/itree_v1.c     |  67 ----
 fs/minix/itree_v2.c     |  75 -----
 fs/minix/minix.h        |  26 +-
 7 files changed, 702 insertions(+), 552 deletions(-)
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
index daf83e4ff25c..352ab563902e 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -301,6 +301,16 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 	} else
 		goto out_no_fs;
 
+	/*
+	 * Set the direct block and indirect block depth now that the rest of
+	 * the version-specific settings have been set.
+	 */
+	sbi->s_direct = MINIX_DIRECT;
+	if (sbi->s_version == MINIX_V1)
+		sbi->s_depth = MINIX_V1_DEPTH;
+	else
+		sbi->s_depth = MINIX_V2_DEPTH;
+
 	if (!minix_check_superblock(s))
 		goto out_illegal_sb;
 
@@ -439,15 +449,6 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -731,27 +732,12 @@ int minix_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	if (INODE_VERSION(inode) == MINIX_V1)
-		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
-	else
-		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size, sb);
+
+	stat->blocks = (sb->s_blocksize / 512) * minix_blocks(stat->size, sb);
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
index 000000000000..9c81a9847c0f
--- /dev/null
+++ b/fs/minix/itree.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
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
+/*
+ * Accessor functions for Indirect structs to provide a unified interface for
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
+/*
+ * Use accessor functions for the i_data arrays in the inode info union instead
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
+static inline int v1_block_to_path(struct inode *inode, long block,
+		int *offsets)
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
+static inline int v2_block_to_path(struct inode *inode, long block,
+		int *offsets)
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
+static inline void add_chain(Indirect *p, struct buffer_head *bh, block_t *v,
+		u8 is_v1)
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
+static inline Indirect *get_branch(struct inode *inode, int depth, int *offsets,
+		Indirect *chain, int *err)
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
+		add_chain(++p, bh, blk_ptr_offset(bh->b_data, *++offsets,
+				is_v1), is_v1);
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
+static int alloc_branch(struct inode *inode, int num, int *offsets,
+		Indirect *branch)
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
+static inline int splice_branch(struct inode *inode, Indirect *chain,
+		Indirect *where, int num)
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
+int minix_get_block(struct inode *inode, sector_t block, struct buffer_head *bh,
+		int create)
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
+static Indirect *find_shared(struct inode *inode, int depth, int *offsets,
+		Indirect *chain, block_t *top)
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
+
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
+static void v1_free_branches(struct inode *inode, v1_block_t *p, v1_block_t *q,
+		int depth)
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
+/*
+ * The function called for file truncation.
+ */
+void minix_truncate(struct inode *inode)
+{
+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+			S_ISLNK(inode->i_mode)))
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
index 78722ce22e1e..3d88dd651f6f 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -11,13 +11,22 @@
 #define MINIX_V2		0x0002		/* minix V2 fs */
 #define MINIX_V3		0x0003		/* minix V3 fs */
 
+/*
+ * Block storage layout. All versions have 7 direct blocks, but they have
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
@@ -41,6 +50,8 @@ struct minix_sb_info {
 	struct minix_super_block * s_ms;
 	unsigned short s_mount_state;
 	unsigned short s_version;
+	unsigned short s_direct;
+	unsigned short s_depth;
 };
 
 void __minix_error_inode(struct inode *inode, const char *function,
@@ -60,14 +71,11 @@ int minix_getattr(struct mnt_idmap *, const struct path *,
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 
-extern void V1_minix_truncate(struct inode *);
-extern void V2_minix_truncate(struct inode *);
-extern void minix_truncate(struct inode *);
+void minix_truncate(struct inode *inode);
 extern void minix_set_inode(struct inode *, dev_t);
-extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern unsigned V1_minix_blocks(loff_t, struct super_block *);
-extern unsigned V2_minix_blocks(loff_t, struct super_block *);
+int minix_get_block(struct inode *inode, sector_t block,
+		struct buffer_head *bh, int create);
+unsigned int minix_blocks(loff_t size, struct super_block *sb);
 
 struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio **);
 int minix_add_link(struct dentry*, struct inode*);
-- 
2.47.3

