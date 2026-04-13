Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3973C456C
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083059; cv=none; b=rzg5MlthvUfi0oevkfjQxQD1/s5+a2P8zXIDXaFC+Z6oPQ0fAmZETQqAS6B1sn201Ip6bqwDX4aGRmn9sgkfEQbQ+wdzDkeaV4l38fjueAPrYlfwnWIrGJKaZOaXavyCvKZKpRRADJfYr47JpKWhTc6bQxIK9S3U83oQgq3m6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083059; c=relaxed/simple;
	bh=yiXDPjYkO81D1LyoV9hGUo5Orc17aNP1k5Gp61/ee1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxHfdw63hT5769t2m2DLFQyC/0XJ79j6ks0HiGs84Pce4/eVOzkP4Mm9JkQwvDAB/fyrqW4Qq+Idb+9KeBNEKcRyQFyrOhRDVJnGaRgHy1BajTdI4J1kGK1ytpcoIuB1srRyWzilajtJepJwGrCBMXioYLuXZuxj3RfReGrs4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf7190580so252585f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083055; x=1776687855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gEXSZ+uScr7KRUr40EnRlVlFvf/yGJPhJ4k6WJeHh8=;
        b=X8/z9tl2C08iPDmf4t2KZK4T5l3O+5JUrPuMqjge7/ko/AWlVNjbbPo67MvB6b/Hn1
         7Nf/6X1knKLF0JHmizxOmT/eEXXtVDh1ClSTtSylmLtuMMzQkyPg6WQIe6d0S1AIb+Uu
         0/LMDLjh24bdedJM6iF1ZVNMSbwaUWIUmsdaxH+GR+tQV7p5Oc4XHrpFFyRjyveGeFyd
         iTgplCEUPurIJS1/sm5pODgzK6lgrEF3jV8qMX7eQqSKXIR8ZmXEuW2ZaK+8fOhKqjer
         LbUxMSzq3y3nRRWysgijkCB9z1wP6SoggHbZaI9JDRYLbr9s1Nvei0XzzMQ1S+oTZVL1
         f9fQ==
X-Gm-Message-State: AOJu0YwGpphmN+AOkuUoVtEq2LKxRmggKztgdpJzPP870CcOklEEbCbO
	eefGHfkxY39Cn7nz6VKQtdhsnu+U9xCRUciROxaB7EfeWx7aXYZuR02cysQg2yXnKlU=
X-Gm-Gg: AeBDiev5watVV0ucdajBitI7FUH7fl61+0U5xEjwSuJndH1elaJ6N3qs6EaAVlMEYsX
	qRSvhVYh6+/2nHnKQjbykXQ5TmGU1TdfX0KG4o9yBeVo7fTf/mlUXf3h0T9zeEYNG5wkINcE51U
	ytSV5m/WMvaxOkDx3wA3gbAK3D++bgCMFKkxGyw3rNpvvkd3L+ksBsydJMiJ2Cv8MMpZK6Qd4CM
	OKe5YAK06QTy2YubYG8g0gPiBx6aVRycrZEvNm48MzWyjwWd6IFsvAT8EEsOzJa1mJN/z2NoMQd
	qZdY+hrRBOPdMq4EsbmzqtSfG3M1xgKIiunSCgLVAIpM/1raBf5tBQT/U432etk9X65/4waGguZ
	BRXrLEh2NgB3LvOJ8NmYoHyMIi8tmYUJbhGuypxXGfCS/FiUONpJ6cTSxt6c3kfUrQbV7qJtkK1
	se9x+mbBb8NL9OoHJ53ZtPe45EQHs6zP/iRDTKK9IGPO1m34+M/QvRVS0YAfHPNIZNpQ==
X-Received: by 2002:a05:600c:1c06:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-488d7e21466mr98392275e9.0.1776083055395;
        Mon, 13 Apr 2026 05:24:15 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:14 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 02/10] ftrfs: add superblock operations
Date: Mon, 13 Apr 2026 16:23:48 +0200
Message-ID: <20260413142357.515792-3-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aurélien DESBRIERES <aurelien@hackers.camp>

Implement VFS superblock operations for FTRFS:

- ftrfs_fill_super(): read and validate on-disk superblock (magic,
  CRC32), allocate ftrfs_sb_info, read root inode, initialize
  in-memory free block bitmap
- ftrfs_put_super(): release bitmap and buffer heads on unmount
- ftrfs_statfs(): report filesystem statistics
- ftrfs_write_inode(): persist inode to disk via namei.c
- ftrfs_init_fs_context() / ftrfs_get_tree(): kernel 5.15+ mount API
- ftrfs_free_inode(): kernel 5.9+ inode freeing API

Module init/exit registers ftrfs as a filesystem type and allocates
a dedicated slab cache for ftrfs_inode_info objects.

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/super.c | 274 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 fs/ftrfs/super.c

diff --git a/fs/ftrfs/super.c b/fs/ftrfs/super.c
new file mode 100644
index 000000000..8acc62921
--- /dev/null
+++ b/fs/ftrfs/super.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — Superblock operations
+ * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+#include <linux/statfs.h>
+#include "ftrfs.h"
+
+/* Inode cache (slab allocator) */
+static struct kmem_cache *ftrfs_inode_cachep;
+
+/*
+ * alloc_inode — allocate a new inode with ftrfs_inode_info embedded
+ */
+static struct inode *ftrfs_alloc_inode(struct super_block *sb)
+{
+	struct ftrfs_inode_info *fi;
+
+	fi = kmem_cache_alloc(ftrfs_inode_cachep, GFP_KERNEL);
+	if (!fi)
+		return NULL;
+
+	memset(fi->i_direct, 0, sizeof(fi->i_direct));
+	fi->i_indirect  = 0;
+	fi->i_dindirect = 0;
+	fi->i_flags     = 0;
+
+	return &fi->vfs_inode;
+}
+
+/*
+ * free_inode — return inode to slab cache (kernel 5.9+ uses free_inode)
+ */
+static void ftrfs_free_inode(struct inode *inode)
+{
+	kmem_cache_free(ftrfs_inode_cachep, FTRFS_I(inode));
+}
+
+/*
+ * statfs — filesystem statistics
+ */
+static int ftrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block   *sb  = dentry->d_sb;
+	struct ftrfs_sb_info *sbi = FTRFS_SB(sb);
+
+	buf->f_type    = FTRFS_MAGIC;
+	buf->f_bsize   = sb->s_blocksize;
+	buf->f_blocks  = le64_to_cpu(sbi->s_ftrfs_sb->s_block_count);
+	buf->f_bfree   = sbi->s_free_blocks;
+	buf->f_bavail  = sbi->s_free_blocks;
+	buf->f_files   = le64_to_cpu(sbi->s_ftrfs_sb->s_inode_count);
+	buf->f_ffree   = sbi->s_free_inodes;
+	buf->f_namelen = FTRFS_MAX_FILENAME;
+
+	return 0;
+}
+
+/*
+ * put_super — release superblock resources
+ */
+static void ftrfs_put_super(struct super_block *sb)
+{
+	struct ftrfs_sb_info *sbi = FTRFS_SB(sb);
+
+	if (sbi) {
+		ftrfs_destroy_bitmap(sb);
+		brelse(sbi->s_sbh);
+		kfree(sbi->s_ftrfs_sb);
+		kfree(sbi);
+		sb->s_fs_info = NULL;
+	}
+}
+
+static const struct super_operations ftrfs_super_ops = {
+	.alloc_inode    = ftrfs_alloc_inode,
+	.free_inode     = ftrfs_free_inode,
+	.put_super      = ftrfs_put_super,
+		.write_inode    = ftrfs_write_inode,
+	.statfs         = ftrfs_statfs,
+};
+
+/*
+ * ftrfs_fill_super — read superblock from disk and initialize VFS sb
+ */
+int ftrfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct ftrfs_sb_info     *sbi;
+	struct ftrfs_super_block *fsb;
+	struct buffer_head       *bh;
+	struct inode             *root_inode;
+	__u32                     crc;
+	int                       ret = -EINVAL;
+
+	/* Set block size */
+	if (!sb_set_blocksize(sb, FTRFS_BLOCK_SIZE)) {
+		errorf(fc, "ftrfs: unable to set block size %d", FTRFS_BLOCK_SIZE);
+		return -EINVAL;
+	}
+
+	/* Read block 0 — superblock */
+	bh = sb_bread(sb, 0);
+	if (!bh) {
+		errorf(fc, "ftrfs: unable to read superblock");
+		return -EIO;
+	}
+
+	fsb = (struct ftrfs_super_block *)bh->b_data;
+
+	/* Verify magic */
+	if (le32_to_cpu(fsb->s_magic) != FTRFS_MAGIC) {
+		errorf(fc, "ftrfs: bad magic 0x%08x (expected 0x%08x)",
+		       le32_to_cpu(fsb->s_magic), FTRFS_MAGIC);
+		goto out_brelse;
+	}
+
+	/* Verify CRC32 of superblock (excluding the crc32 field itself) */
+	crc = ftrfs_crc32(fsb, offsetof(struct ftrfs_super_block, s_crc32));
+	if (crc != le32_to_cpu(fsb->s_crc32)) {
+		errorf(fc, "ftrfs: superblock CRC32 mismatch (got 0x%08x, expected 0x%08x)",
+		       crc, le32_to_cpu(fsb->s_crc32));
+		goto out_brelse;
+	}
+
+	/* Allocate in-memory sb info */
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi) {
+		ret = -ENOMEM;
+		goto out_brelse;
+	}
+
+	sbi->s_ftrfs_sb = kzalloc(sizeof(*sbi->s_ftrfs_sb), GFP_KERNEL);
+	if (!sbi->s_ftrfs_sb) {
+		ret = -ENOMEM;
+		goto out_free_sbi;
+	}
+
+	memcpy(sbi->s_ftrfs_sb, fsb, sizeof(*fsb));
+	sbi->s_sbh         = bh;
+	sbi->s_free_blocks = le64_to_cpu(fsb->s_free_blocks);
+	sbi->s_free_inodes = le64_to_cpu(fsb->s_free_inodes);
+	spin_lock_init(&sbi->s_lock);
+
+	sb->s_fs_info  = sbi;
+	sb->s_magic    = FTRFS_MAGIC;
+	sb->s_op       = &ftrfs_super_ops;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+
+	/* Read root inode (inode 1) */
+	root_inode = ftrfs_iget(sb, 1);
+	if (IS_ERR(root_inode)) {
+		ret = PTR_ERR(root_inode);
+		pr_err("ftrfs: failed to read root inode: %d\n", ret);
+		goto out_free_fsb;
+	}
+
+	sb->s_root = d_make_root(root_inode);
+	if (!sb->s_root) {
+		ret = -ENOMEM;
+		goto out_free_fsb;
+	}
+
+	if (ftrfs_setup_bitmap(sb)) {
+		ret = -ENOMEM;
+		goto out_free_fsb;
+	}
+
+	pr_info("ftrfs: mounted (blocks=%llu free=%lu inodes=%llu)\n",
+		le64_to_cpu(fsb->s_block_count),
+		sbi->s_free_blocks,
+		le64_to_cpu(fsb->s_inode_count));
+
+	return 0;
+
+out_free_fsb:
+	kfree(sbi->s_ftrfs_sb);
+out_free_sbi:
+	kfree(sbi);
+	sb->s_fs_info = NULL;
+out_brelse:
+	brelse(bh);
+	return ret;
+}
+
+/*
+ * fs_context ops — kernel 5.15+ mount API
+ */
+static int ftrfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, ftrfs_fill_super);
+}
+
+static const struct fs_context_operations ftrfs_context_ops = {
+	.get_tree = ftrfs_get_tree,
+};
+
+static int ftrfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &ftrfs_context_ops;
+	return 0;
+}
+
+static struct file_system_type ftrfs_fs_type = {
+	.owner            = THIS_MODULE,
+	.name             = "ftrfs",
+	.init_fs_context  = ftrfs_init_fs_context,
+	.kill_sb          = kill_block_super,
+	.fs_flags         = FS_REQUIRES_DEV,
+};
+
+/*
+ * Inode cache constructor
+ */
+static void ftrfs_inode_init_once(void *obj)
+{
+	struct ftrfs_inode_info *fi = obj;
+
+	inode_init_once(&fi->vfs_inode);
+}
+
+/*
+ * Module init / exit
+ */
+static int __init ftrfs_init(void)
+{
+	int ret;
+
+	ftrfs_inode_cachep = kmem_cache_create(
+		"ftrfs_inode_cache",
+		sizeof(struct ftrfs_inode_info),
+		0,
+		SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+		ftrfs_inode_init_once);
+
+	if (!ftrfs_inode_cachep) {
+		pr_err("ftrfs: failed to create inode cache\n");
+		return -ENOMEM;
+	}
+
+	ret = register_filesystem(&ftrfs_fs_type);
+	if (ret) {
+		pr_err("ftrfs: failed to register filesystem: %d\n", ret);
+		kmem_cache_destroy(ftrfs_inode_cachep);
+		return ret;
+	}
+
+	pr_info("ftrfs: module loaded (FTRFS Fault-Tolerant Radiation-Robust FS)\n");
+	return 0;
+}
+
+static void __exit ftrfs_exit(void)
+{
+	unregister_filesystem(&ftrfs_fs_type);
+	rcu_barrier();
+	kmem_cache_destroy(ftrfs_inode_cachep);
+	pr_info("ftrfs: module unloaded\n");
+}
+
+module_init(ftrfs_init);
+module_exit(ftrfs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>");
+MODULE_DESCRIPTION("FTRFS: Fault-Tolerant Radiation-Robust Filesystem");
+MODULE_VERSION("0.1.0");
+MODULE_ALIAS_FS("ftrfs");
-- 
2.52.0

