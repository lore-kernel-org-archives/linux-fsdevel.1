Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA83C7DF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161254; cv=none; b=FFyDXuGSQGVXsJ/whHbEE504tNpy6CNtlA2WVF+5+IDrYNgs5i7VoX3EU8LQP3ABR6w3CyogaPvV1Umv47kQT4u0UAlc+U8ecUem942gbBvrB6TWXB4yXn5Ee243KI+iANKzMFfXJ8fcgmGMk0PEmRW/Wm66AgAD+q3Gbzy5e+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161254; c=relaxed/simple;
	bh=1uSkaXzm2P0Wj7bPdxog4gc8N/ZNllWGiJvhmN98OSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9yhLgUPEmoBUVfWMteBYn6zoDupnUqjvaPzAVjdUxEcWtVQzKsP8/bt1kL+uJY92V2sFiK+HxUvO9wsn9WdDXRgD0HWxpcus8ckrnj3CcX22C9tjKNP771eGxcsFySpyvCkTq60XR+NOKQBEgltXEMpVfaG3Or8KRcCxhZGXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf5f6d2eeso258361f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161251; x=1776766051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukvcN/hPEzbhoZ6n0snMbQkF8J76XlbxpRq52+vBCOk=;
        b=r2fvAzV/HYUstl71F2VATugmJOK7Tc2I5br/SK9qLjgk2w1JATvear9ovid8bx1PzP
         hISDR8p0D6eM0qpQbSAkvfHr1iogAQ4EzNQ7JA5U/UNOA2R9oh+kQ147jL/GaIuhVive
         0CnpW+XpANu64czPoNgKXUUI9/IMwvUngQhH/QjFr0d1at23ijj4rQMClCCR/GinmYRL
         M2mfgNnvK7DRuDbtrILDWT9XEC4VDHuCZSp+ffBBVhI8HQ6L9X6DOWE2WlEVpAFZabfb
         Oa6Y0R8hpGD1OFm5FG8OTJvRcrJU+c4rBWPPOzUgIuCYWGQTwEZR2Rug32GsTDzzBsQE
         zT5g==
X-Gm-Message-State: AOJu0YyNRVkn+51t5gCngU5utaVpY846AsiDNC91DU2MB0wJhUF2gpLU
	tGh2/jYfjg7w3r4zUYpuq9V99DbuFX8IndpqFnq1bZlLp+4DdCOvjIiHAWcRxQTV
X-Gm-Gg: AeBDiesigQg4ODtOnXTXlYhxPKU9qj/iZluqtxo+XTSfdJSEnquoXcX5daRMHu9j0ic
	/K8Fik9gaT0Q4n7W3m7VqaExxo4x+YXh5j12WBjZ8BCNjLjpmgWFgaIwTr1u5gbXe5rWQ7ye/3l
	W5b9x4OoDlbOVBr67fxxqzx/CaoW962HGk7dY+61liBvqh/pGNVcP6uLPDlSBexAxln5eWWf5OQ
	oTo+u6iVlafDhNT2tbxaOuvd8nvDYEkctX+r7zSQ2C7QW21VdW2DSackIIf+mye1DflwFBZyEVW
	mMgHit6RJQ81RlsWmLqH26A071kKo9w/gssTy7JJ8VMyQE+klyQ3B1jtR4hCuwMhgC2Y9ckECFH
	wJGksbMtVNbXPtrgnPjWNQdaydREjiH5CXDPkNtMHxTTul4fK5NWc600xcSKZeIsEGH1lkd/8LK
	OsV9roqPymVb9YMXbBiDJ0OfIQRnIq1b/ljXbdKrsD5EQX/rNgQtW04WkI6xtyxjsYPksGiGwzd
	LI=
X-Received: by 2002:a05:600c:c4a2:b0:486:fdc0:4504 with SMTP id 5b1f17b1804b1-488d6864e49mr132033995e9.4.1776161250841;
        Tue, 14 Apr 2026 03:07:30 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:30 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 02/12] ftrfs: add superblock operations
Date: Tue, 14 Apr 2026 14:07:15 +0200
Message-ID: <20260414120726.5713-3-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/super.c | 274 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 fs/ftrfs/super.c

diff --git a/fs/ftrfs/super.c b/fs/ftrfs/super.c
new file mode 100644
index 000000000000..8acc6292124b
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

