Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F731282F
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782623787; cv=none; b=uyaCRch7jeLNrHKCnkqV83wIUTxugAjOLG/0eEI/Mg/QsXsT2c1Nis6WEO3Q7Lr5MeixoZNtYcANi/twGRWYPkEYiTdix7uLk1o74YUt3Ss72GS5UlnzZnrXgVTv7Di2H/0WxsQjbKumwRXRj5U4hSdul8igKP2BkmifkIRBtDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782623787; c=relaxed/simple;
	bh=SXl5D/BlDVsejfFrpDPgXQRClqdPsp542N30vqnskyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkz99nVqjY+mKb1HbljhwCYGs/a/6KnzbcoB+NDhk6nutazI9QqqXbe3VsjREgRKWMOJcGRZWV3IVOGbcN+Cc4hsMCbB/lmKlcpF6SzHH8DH35VKnGLoStnPqtMKSA3igh2KEZ0LdHQP1jiT87bysxfRCHY8IOB8UvDvhNfQsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfELKye7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfELKye7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c969ad04c1dso151070a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782623783; x=1783228583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFli2uebtZixFxwm0HRwCLMhMgEfjPZEU2EyMYnNRKk=;
        b=nfELKye7SmcxyCZpIXlqkYilcmyH6h5o+Bcg1wUvCauiV2KAgwQ1mg5gq0rObiNeeq
         zpj8k8EExOK/6dyKcoQhtsGizXTl/PXVqOUMq8XTE7qNmhT/vAaPU9Q73uNcncZQeE8w
         WcbwyAfmWg8uwXh5sX3XVuAChmEGHWaN8h5M+Frk10GaZinlio0MUjl2zhbn+oB8hPVI
         qETOnFGr2RSdguoBwTrEku/QipHz/MqDd1Re9sObvwylbhJumnV1cGZKcRWqtdzf50Qz
         YjDxgVjnTme8RamJ8qrW3eyJmcjGoY0rn5ikg5Eu9Eynl7UQHYAcL9ozyFMTixGpse1C
         m76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782623783; x=1783228583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFli2uebtZixFxwm0HRwCLMhMgEfjPZEU2EyMYnNRKk=;
        b=TzISoY47Mb7hhcLpE7fRpCDIFp48TsWQ96sWhMMvI58RKg7kRBSbqwUfwFokPcfqbS
         P+LYs5b9kJrSPb6gI/39HnbN01j3ouRLK9IwIxwXr64c+TBqS3BUp8fWNhAH5+2bKuQi
         w1IinWO5sGKOPBFqrLv/azfsF/3G2KSEAlABuJdhNJhugkehru2YJkwwyO7E5Jf1YG4X
         Iy6IsDX3XsRdWFrdtEogtlA+3nNVuDsqCdTAQLrknLKaEECf1XwVmXvYJFSzop4XjKTp
         i3+PytINMAnz5+NonEk2lNZ0HzAkNC/Cn0nP3qfmT5OK5IyWn2qcCf0CP53GnKFjFLvP
         hINg==
X-Gm-Message-State: AOJu0Yz5B6JhKqKuN/8Z9Jsbv02oEcaf2DpIuaWpghN1jKxgjR8vNr30
	XoDG2BwjfWXWLY/34+n6noIF0DVtWakThLnkzUbPjQT+Rmhzw/btghk9pxLSVluN
X-Gm-Gg: AfdE7clwVcM6BAqB5E6fhT7rCrajTNXQ+ad8vDEMlGubuFJC+ljoD7Q4GSJi1B8KSx+
	plUAQ5Iqmk5SP+mqpLUMOUD5JjzmyGT2aRKCzG+gDHXh+NakevlMVdOdq0uLryLHAL3WmgfTevz
	7kny3+uIjei/OLs2KeoP4JxWTsPaZiBvsZwLJTXNBT47kT/lZhO/z/u0yLrhNTEStN5b8ZVhfTS
	eZYhP9WGAwp/KcdxV3/12nsLq6SYMDLOCBNa+LUTQp25bLQgeVOB0L3ZcdkM5vtR03DP5nlMwCZ
	4pMQruVasIPQHu1ZsvrA/h07Lwl5c5tQjMxk3blntPQ9NkaO4rakozKdMBp+vCRJwH/r2lapfFU
	NetOAgoLMSf0xd8JQLENKAVomj8rn+MboX1YSM8jUnxQcI6F6kCPeNhfCMwsS/RM=
X-Received: by 2002:a05:6a20:9e4b:b0:3b4:84c5:45c8 with SMTP id adf61e73a8af0-3bd4aea2e39mr14152158637.24.1782623783116;
        Sat, 27 Jun 2026 22:16:23 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm5793263a12.9.2026.06.27.22.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:16:22 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	hch@infradead.org,
	viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v2 4/4] minix: fix symlink and truncate for iomap
Date: Sat, 27 Jun 2026 22:15:56 -0700
Message-ID: <81d473d2763a781069f5a4cc1a7147fda469f62a.1782619718.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782619718.git.jbingham@gmail.com>
References: <cover.1782619718.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original minix iomap conversion patches had a couple of issues
exposed by syzbot:

1. NULL pointer dereferences in page_symlink. Since the iomap based
minix_aops no longer used write_begin and write_end, when page_link
attempted to call aops->write_begin there was a crash because there was
no longer a pointer assigned to aops->write_begin. This was fixed with a
custom function that writes the symlink target directly to a newly
allocated data block acquired with minix_new_block and sb_getblk, thus
bypassing the aops write path entirely. The symlink read path was in
turn replaced with a new minix_get_link that reads the target from the
first data block directly with sb_bread, similar to how ext4_get_link
does it.

2. Truncate crashed. There was a conflict in minix's truncate() function
between buffer_head and iomap where block_truncate_page was attaching
buffer_heads to folios, but this ran up against how iomap works. Fixed
this by using iomap_truncate_page for inodes using minix_aops and
block_truncate_page for inodes with minix_dir_aops.

Also, minix_symlink_inode_operations now has .setattr = minix_setattr so
symlinks can be truncated more properly through iomap rather than using
the default simple_setattr.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/inode.c        |   4 +-
 fs/minix/itree_common.c |  11 +++-
 fs/minix/minix.h        |   5 +-
 fs/minix/namei.c        | 137 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 2ba6766fce51..b113c44764ff 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -573,8 +573,9 @@ static const struct address_space_operations minix_dir_aops = {
 };
 
 static const struct inode_operations minix_symlink_inode_operations = {
-	.get_link	= page_get_link,
+	.get_link	= minix_get_link,
 	.getattr	= minix_getattr,
+	.setattr	= minix_setattr,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
@@ -838,4 +839,3 @@ module_init(init_minix_fs)
 module_exit(exit_minix_fs)
 MODULE_DESCRIPTION("Minix file system");
 MODULE_LICENSE("GPL");
-
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
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 76718f789369..d1a890e96abe 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -57,7 +57,7 @@ int minix_new_block(struct inode *inode);
 void minix_free_block(struct inode *inode, unsigned long block);
 unsigned long minix_count_free_blocks(struct super_block *sb);
 int minix_getattr(struct mnt_idmap *, const struct path *,
-		struct kstat *, u32, unsigned int);
+		struct kstat *, u32, unsigned);
 int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct iattr *attr);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
@@ -82,6 +82,9 @@ int minix_make_empty(struct inode*, struct inode*);
 int minix_empty_dir(struct inode*);
 int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		struct inode *inode);
+extern const char *minix_get_link(struct dentry *dentry, struct inode *inode,
+		struct delayed_call *callback);
+
 struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
 ino_t minix_inode_by_name(struct dentry*);
 
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 263e4ba8b1c8..e245f55a68ff 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -6,6 +6,8 @@
  */
 
 #include "minix.h"
+#include <linux/buffer_head.h>
+#include <linux/namei.h>
 
 static int add_nondir(struct dentry *dentry, struct inode *inode)
 {
@@ -69,6 +71,101 @@ static int minix_create(struct mnt_idmap *idmap, struct inode *dir,
 	return minix_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
 
+static inline u16 *v1_i_data(struct inode *inode)
+{
+	return (u16 *)minix_i(inode)->u.i1_data;
+}
+
+static inline u32 *v2_i_data(struct inode *inode)
+{
+	return (u32 *)minix_i(inode)->u.i2_data;
+}
+
+static inline u16 cpu_to_v1_block(sector_t n)
+{
+	return n;
+}
+
+static inline u32 cpu_to_v2_block(sector_t n)
+{
+	return n;
+}
+
+static inline sector_t v1_block_to_cpu(u16 n)
+{
+	return n;
+}
+
+static inline sector_t v2_block_to_cpu(u32 n)
+{
+	return n;
+}
+
+/* Reimplement page_symlink's general logic while avoiding using buffer head
+ * based aops operations like aops->write_begin so things behave better with
+ * the new regime of iomap based aops operations. Cribbing from page_symlink in
+ * fs/namei.c and ext4's ext4_init_symlink_block.
+ */
+static int __page_symlink(struct inode *inode, const char *symname, int len)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh;
+	char *kaddr;
+	int err = 0;
+	u16 *p16; /* v1 16 bit block */
+	u32 *p32; /* v2/3 32 bit block */
+
+	sector_t phys;
+
+	phys = minix_new_block(inode);
+	if (!phys) {
+		err = -ENOSPC;
+		goto ps_out;
+	}
+
+	if (INODE_VERSION(inode) == MINIX_V1) {
+		p16 = v1_i_data(inode);
+		*p16 = cpu_to_v1_block(phys);
+	} else {
+		p32 = v2_i_data(inode);
+		*p32 = cpu_to_v2_block(phys);
+	}
+
+	bh = sb_getblk(sb, phys);
+	if (!bh) {
+		err = -ENOMEM;
+		goto ps_fail;
+	}
+
+	lock_buffer(bh);
+	kaddr = (char *)bh->b_data;
+	memset(kaddr, 0, sb->s_blocksize);
+	memcpy(kaddr, symname, len);
+	inode->i_size = len - 1;
+	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
+
+	mmb_mark_buffer_dirty(bh, &minix_i(inode)->i_metadata_bhs);
+	if (inode_needs_sync(inode)) {
+		sync_dirty_buffer(bh);
+		if (buffer_req(bh) && !buffer_uptodate(bh)) {
+			pr_err("i/o error syncing itable block");
+			err = -EIO;
+		}
+
+	}
+
+	mark_inode_dirty(inode);
+	brelse(bh);
+
+ps_out:
+	return err;
+
+ps_fail:
+	minix_free_block(inode, phys);
+	goto ps_out;
+}
+
 static int minix_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
@@ -84,7 +181,7 @@ static int minix_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return PTR_ERR(inode);
 
 	minix_set_inode(inode, 0);
-	err = page_symlink(inode, symname, i);
+	err = __page_symlink(inode, symname, i);
 	if (unlikely(err)) {
 		inode_dec_link_count(inode);
 		iput(inode);
@@ -273,6 +370,44 @@ static int minix_rename(struct mnt_idmap *idmap,
 	return err;
 }
 
+/* straight up thievery here; stolen verbatim from ext4_get_link */
+static void minix_free_link(void *bh)
+{
+	brelse(bh);
+}
+
+/* Borrowing from ext4_get_link to a degree; since minix inodes and symlinks
+ * are significantly simpler, we don't need to do nearly as much as ext4
+ * requires for old-timey ext4 slow links.
+ */
+const char *minix_get_link(struct dentry *dentry, struct inode *inode,
+		struct delayed_call *callback)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh;
+	sector_t blk;
+
+	/* Get yon block, depending on what version of the minix fs this is. */
+	if (INODE_VERSION(inode) == MINIX_V1)
+		blk = v1_block_to_cpu(*(v1_i_data(inode)));
+	else
+		blk = v2_block_to_cpu(*(v2_i_data(inode)));
+
+	bh = sb_bread(sb, blk);
+	if (IS_ERR(bh))
+		return ERR_CAST(bh);
+	if (!bh) {
+		pr_err("bad symlink on inode %llu", inode->i_ino);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
+	set_delayed_call(callback, minix_free_link, bh);
+	nd_terminate_link(bh->b_data, inode->i_size,
+			inode->i_sb->s_blocksize - 1);
+
+	return bh->b_data;
+}
+
 /*
  * directories can handle most operations...
  */
-- 
2.47.3

