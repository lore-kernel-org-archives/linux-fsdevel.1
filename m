Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394739A7F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114401; cv=none; b=gSJIxwLDBn52IlDn0KTSQDXsyyJzKbuPR2c6KQuMYS+tsdp5nSl7wQyuTreoMS/jpi0CwHoupvY1lmOXVtwoIVVl3HGoFOFr84dpQ4XeXJd9buhJ37Qfs6BhVGXVGLhBaVxWpv/jtMVFmmTSIyYW1D37658ySrtnOZOgM38kf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114401; c=relaxed/simple;
	bh=TyU6+ssBtqPgFmfmLc9euL6NS91bHT4L+VKtdARJXGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxsNQDxXNkV9H7LxcKYYzJTPPw4ezH6uR7FOh1d2LoV5bZwxUCG6/rcKI3ytcJt3Ep2FG8X+sCtIPfLQILgI6vYBrd8BnUm7rsETTQBgPkrKEz9Sl1H6+/S1ahKqVXmoBYPAb2RqtnTNN6pxdmvAsOf5M3mBkcTgCXWKHiEhyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso9049075e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114391; x=1776719191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gJQ66QUToDidVWPBgx6Nn5WDzL1O5AXEnR6bvMEbjR8=;
        b=D4Eg8Kv9S+XmZSMC7aTno9LsaEMk7m0atAxsx6MqDK78UjoiL2NMkjOqWOHl0NrY5i
         YrHK9HW89E2ueT5ZX/ucMhwNt4o2FXpeHKe2Edopmq7uRl+1Meq2RzUSkPHxwJlsO5UJ
         sqs7nl0Icn1qzpHepihzGBhVCG+BcVQVNSYOzRQbqSldcFoYjUGzdYY4sZFaAlL4T9lr
         bBPTajcIlPqtCX358x1dRoAmuh8aIktGTImUhTXm/AtILgD+aabzpeP8BqSUIgmnH4Pz
         do7aUI8ziZCeH4WEhQErDvkJ1Lmo77E6eCZIwdVI7fDWkh7ZWotol0nxF53aBiH4YSaV
         p/HA==
X-Gm-Message-State: AOJu0YxqbCwx1vv23jGeDWzq/wdB7OX/sxu0M6oqNRliS8TFYOWO4Ygs
	3oOEc841GPtQ5HkWJWfikqse+StOb1hkX0dxtjmrN5d7WSNSYmbW6kwiKdOosaPZdqE=
X-Gm-Gg: AeBDiesBsaxo37KThlqSisqY8sy6O5N1enKNocO+qeCnAPtnIOJYa0d4MBqWHUXm61q
	jJQ1BzbajwCJ+ME88E4DRktu4AaJff4ZxKp9mwDXNBDOSXHo59xoeUh5zRkaIsxgZSIRtQL9w7c
	byeCr5K6I0xO1UKyedpOauocejUcbi57FUevVc65p4xp4bR4AmAqk9/YNHCkty4VW8Ql/rhItgj
	PW/eaMfXbRq55QEWIshBG/u6CsVSQ2aGCckO0Lr8GsuDAbtsTYJ13L25Y3ZXkhqQVIDrKd0Iq4q
	jPt8D+txW2PxubqB3r9gCIpbd0NGjbE7gy1Of5YjEa5maCqH9xCXqEFfts2ELiIDGXjp7bIPddx
	D5xIb65nczGg/6tq1ulsWs8Z8170c0yPTtkx0enTuMYne98yx3MNlBx9KoJi2Mh3t1kukkHp922
	SCyJv9J/GR9HqsjpB2Z+FtKrI086q+6LL8zit6QwvYKWkwW2AKphehz+wXJtQNl7IdFnK+wFgbF
	AlA
X-Received: by 2002:a05:600c:c4a2:b0:485:3bc7:a224 with SMTP id 5b1f17b1804b1-488d68609e0mr113121175e9.6.1776114391341;
        Mon, 13 Apr 2026 14:06:31 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:30 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger@dilger.ca,
	pfalcato@suse.de
Subject: [PATCH v2 11/11] =?UTF-8?q?ftrfs:=20v2=20fixes=20=E2=80=94=20writ?= =?UTF-8?q?e=20path,=20inode=20lifecycle,=20on-disk=20format?=
Date: Tue, 14 Apr 2026 01:05:52 +0200
Message-ID: <20260413230601.525400-12-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413230601.525400-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

address_space_operations:
- Implement ftrfs_get_block with block allocation (create=1)
- Return -EIO for holes on read (create=0), not 0
- Set bh_result->b_size = 1 << i_blkbits on all mapped paths
- Add ftrfs_write_begin, ftrfs_write_end, ftrfs_readahead, ftrfs_bmap
- Add dirty_folio, invalidate_folio to ftrfs_aops

Inode lifecycle:
- Use insert_inode_locked() instead of insert_inode_hash()
  new_inode() does not set I_NEW; insert_inode_locked() does
- Move unlock_new_inode() to callers after d_instantiate()
- Add unlock_new_inode() on error paths

On-disk format:
- ftrfs_inode: 128 -> 256 bytes
- uid/gid: __le16 -> __le32 (standard kernel convention)
- Add i_tindirect: triple indirect (~512 GiB max file size)
- Remove i_blocks: redundant, calculable from i_size
- i_reserved[84]: explicit padding to 256 bytes
- Superblock padding: 3948 -> 3980 bytes (enforce 4096)
- Add BUILD_BUG_ON for both structure sizes

Directory:
- Skip . and .. in readdir data blocks (dir_emit_dots emits them)

Compat:
- Add ftrfs_inode_is_new macro for inode_state_read_once API

Tested on arm64 kernel 7.0-rc7 (Yocto KVM):
- mount, write, mkdir, read: all working
- 0 BUG/WARN/Oops in dmesg

Addresses review feedback from:
- Matthew Wilcox: address_space_operations now implemented
- Darrick J. Wong: i_size __le64 intentional, BUILD_BUG_ON documents limits
- Andreas Dilger: DO-178C/ECSS certification rationale documented

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/dir.c   | 88 +++++++++++++++++++++-----------------------
 fs/ftrfs/file.c  | 95 +++++++++++++++++++++++++++++++++++++++++++++---
 fs/ftrfs/ftrfs.h | 35 +++++++++++++-----
 fs/ftrfs/inode.c |  9 +++--
 fs/ftrfs/namei.c | 21 +++++++----
 fs/ftrfs/super.c |  2 +
 6 files changed, 177 insertions(+), 73 deletions(-)

diff --git a/fs/ftrfs/dir.c b/fs/ftrfs/dir.c
index dbf0102a4..fd06910bf 100644
--- a/fs/ftrfs/dir.c
+++ b/fs/ftrfs/dir.c
@@ -3,7 +3,6 @@
  * FTRFS — Directory operations
  * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
  */
-
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
 #include "ftrfs.h"
@@ -13,24 +12,23 @@
  */
 static int ftrfs_readdir(struct file *file, struct dir_context *ctx)
 {
-	struct inode       *inode = file_inode(file);
-	struct super_block *sb    = inode->i_sb;
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
 	struct ftrfs_inode_info *fi = FTRFS_I(inode);
 	struct buffer_head *bh;
 	struct ftrfs_dir_entry *de;
 	unsigned long block_idx, block_no;
-	unsigned int  offset;
+	unsigned int offset;
 
-	/* EOF guard */
 	if (ctx->pos == INT_MAX)
 		return 0;
+
 	/* Emit . and .. (ctx->pos: 0=., 1=.., 2+=real entries) */
 	if (ctx->pos < 2) {
 		if (!dir_emit_dots(file, ctx))
 			return 0;
 	}
 
-	/* Iterate over direct blocks only (skeleton: no indirect yet) */
 	for (block_idx = 0; block_idx < FTRFS_DIRECT_BLOCKS; block_idx++) {
 		block_no = le64_to_cpu(fi->i_direct[block_idx]);
 		if (!block_no)
@@ -43,25 +41,28 @@ static int ftrfs_readdir(struct file *file, struct dir_context *ctx)
 		offset = 0;
 		while (offset < FTRFS_BLOCK_SIZE) {
 			de = (struct ftrfs_dir_entry *)(bh->b_data + offset);
-
 			if (!de->d_rec_len)
-				break; /* end of dir block */
-
-			if (de->d_ino && de->d_name_len) {
-				if (!dir_emit(ctx,
-					      de->d_name,
-					      de->d_name_len,
-					      le64_to_cpu(de->d_ino),
-					      de->d_file_type)) {
-					brelse(bh);
-					return 0;
-				}
-				ctx->pos++;
+				break;
+
+			/* Skip . and .. — emitted by dir_emit_dots */
+			if (!de->d_ino || !de->d_name_len)
+				goto next;
+			if (de->d_name_len == 1 && de->d_name[0] == '.')
+				goto next;
+			if (de->d_name_len == 2 && de->d_name[0] == '.'
+			    && de->d_name[1] == '.')
+				goto next;
+
+			if (!dir_emit(ctx, de->d_name, de->d_name_len,
+				      le64_to_cpu(de->d_ino),
+				      de->d_file_type)) {
+				brelse(bh);
+				return 0;
 			}
-
+			ctx->pos++;
+next:
 			offset += le16_to_cpu(de->d_rec_len);
 		}
-
 		brelse(bh);
 	}
 
@@ -73,22 +74,19 @@ static int ftrfs_readdir(struct file *file, struct dir_context *ctx)
  * ftrfs_lookup — find dentry in directory
  */
 struct dentry *ftrfs_lookup(struct inode *dir,
-				   struct dentry *dentry,
-				   unsigned int flags)
+			    struct dentry *dentry,
+			    unsigned int flags)
 {
-	struct super_block      *sb = dir->i_sb;
+	struct super_block *sb = dir->i_sb;
 	struct ftrfs_inode_info *fi = FTRFS_I(dir);
-	struct buffer_head      *bh;
-	struct ftrfs_dir_entry  *de;
-	struct inode            *inode = NULL;
-	unsigned long            block_idx, block_no;
-	unsigned int             offset;
-
-	if (dentry->d_name.len > FTRFS_MAX_FILENAME)
-		return ERR_PTR(-ENAMETOOLONG);
+	struct ftrfs_dir_entry *de;
+	struct buffer_head *bh;
+	unsigned int offset;
+	unsigned long block_no;
+	int i;
 
-	for (block_idx = 0; block_idx < FTRFS_DIRECT_BLOCKS; block_idx++) {
-		block_no = le64_to_cpu(fi->i_direct[block_idx]);
+	for (i = 0; i < FTRFS_DIRECT_BLOCKS; i++) {
+		block_no = le64_to_cpu(fi->i_direct[i]);
 		if (!block_no)
 			break;
 
@@ -97,30 +95,28 @@ struct dentry *ftrfs_lookup(struct inode *dir,
 			continue;
 
 		offset = 0;
-		while (offset < FTRFS_BLOCK_SIZE) {
+		while (offset + sizeof(*de) <= FTRFS_BLOCK_SIZE) {
 			de = (struct ftrfs_dir_entry *)(bh->b_data + offset);
-
 			if (!de->d_rec_len)
-				break; /* end of dir block */
-
+				break;
 			if (de->d_ino &&
 			    de->d_name_len == dentry->d_name.len &&
 			    !memcmp(de->d_name, dentry->d_name.name,
-				    de->d_name_len)) {
-				unsigned long ino = le64_to_cpu(de->d_ino);
+				    dentry->d_name.len)) {
+				u64 ino = le64_to_cpu(de->d_ino);
+				struct inode *inode;
 
 				brelse(bh);
 				inode = ftrfs_iget(sb, ino);
-				goto found;
+				return d_splice_alias(inode, dentry);
 			}
-
 			offset += le16_to_cpu(de->d_rec_len);
+			if (!de->d_rec_len)
+				break;
 		}
 		brelse(bh);
 	}
-
-found:
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias(NULL, dentry);
 }
 
 const struct file_operations ftrfs_dir_operations = {
@@ -128,5 +124,3 @@ const struct file_operations ftrfs_dir_operations = {
 	.read    = generic_read_dir,
 	.iterate_shared = ftrfs_readdir,
 };
-
-
diff --git a/fs/ftrfs/file.c b/fs/ftrfs/file.c
index ef121359b..1807ac698 100644
--- a/fs/ftrfs/file.c
+++ b/fs/ftrfs/file.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * FTRFS — File operations (skeleton)
+ * FTRFS — File operations
  * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
- *
- * NOTE: read/write use generic_file_* for now.
- * The EDAC/RS layer will intercept at the block I/O level (next iteration).
  */
-
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/buffer_head.h>
+#include <linux/mpage.h>
 #include "ftrfs.h"
 
 const struct file_operations ftrfs_file_operations = {
@@ -23,3 +21,90 @@ const struct file_operations ftrfs_file_operations = {
 const struct inode_operations ftrfs_file_inode_operations = {
 	.getattr        = simple_getattr,
 };
+
+/*
+ * ftrfs_get_block — map logical block to physical block
+ * Handles allocation when create=1, returns -EIO for holes on read.
+ */
+static int ftrfs_get_block(struct inode *inode, sector_t iblock,
+			   struct buffer_head *bh_result, int create)
+{
+	struct ftrfs_inode_info *fi = FTRFS_I(inode);
+	u64 new_block;
+	__le64 phys;
+
+	if (iblock >= FTRFS_DIRECT_BLOCKS) {
+		pr_err("ftrfs: indirect block not yet supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	phys = fi->i_direct[iblock];
+	if (phys) {
+		map_bh(bh_result, inode->i_sb, le64_to_cpu(phys));
+		bh_result->b_size = 1 << inode->i_blkbits;
+		return 0;
+	}
+
+	if (!create)
+		return -EIO;
+
+	new_block = ftrfs_alloc_block(inode->i_sb);
+	if (!new_block) {
+		pr_err("ftrfs: no free blocks\n");
+		return -ENOSPC;
+	}
+
+	fi->i_direct[iblock] = cpu_to_le64(new_block);
+	map_bh(bh_result, inode->i_sb, new_block);
+	bh_result->b_size = 1 << inode->i_blkbits;
+	set_buffer_new(bh_result);
+	return 0;
+}
+
+static int ftrfs_read_folio(struct file *file, struct folio *folio)
+{
+	return block_read_full_folio(folio, ftrfs_get_block);
+}
+
+static int ftrfs_writepages(struct address_space *mapping,
+			    struct writeback_control *wbc)
+{
+	return mpage_writepages(mapping, wbc, ftrfs_get_block);
+}
+
+static void ftrfs_readahead(struct readahead_control *rac)
+{
+	mpage_readahead(rac, ftrfs_get_block);
+}
+
+static int ftrfs_write_begin(const struct kiocb *iocb,
+			     struct address_space *mapping,
+			     loff_t pos, unsigned int len,
+			     struct folio **foliop, void **fsdata)
+{
+	return block_write_begin(mapping, pos, len, foliop, ftrfs_get_block);
+}
+
+static int ftrfs_write_end(const struct kiocb *iocb,
+			   struct address_space *mapping,
+			   loff_t pos, unsigned int len, unsigned int copied,
+			   struct folio *folio, void *fsdata)
+{
+	return generic_write_end(iocb, mapping, pos, len, copied, folio, fsdata);
+}
+
+static sector_t ftrfs_bmap(struct address_space *mapping, sector_t block)
+{
+	return generic_block_bmap(mapping, block, ftrfs_get_block);
+}
+
+const struct address_space_operations ftrfs_aops = {
+	.read_folio       = ftrfs_read_folio,
+	.readahead        = ftrfs_readahead,
+	.write_begin      = ftrfs_write_begin,
+	.write_end        = ftrfs_write_end,
+	.writepages       = ftrfs_writepages,
+	.bmap             = ftrfs_bmap,
+	.dirty_folio      = block_dirty_folio,
+	.invalidate_folio = block_invalidate_folio,
+};
diff --git a/fs/ftrfs/ftrfs.h b/fs/ftrfs/ftrfs.h
index 82502c9fb..1f2d8a954 100644
--- a/fs/ftrfs/ftrfs.h
+++ b/fs/ftrfs/ftrfs.h
@@ -13,6 +13,10 @@
 #include <linux/fs_context.h>
 #include <linux/types.h>
 
+/* inode_state_read_once returns inode_state_flags in kernel 7.0 */
+#define ftrfs_inode_is_new(inode) \
+	(inode_state_read_once(inode) & I_NEW)
+
 /* Magic number: 'FTRF' */
 #define FTRFS_MAGIC         0x46545246
 
@@ -49,29 +53,38 @@ struct ftrfs_super_block {
 	__le32  s_crc32;            /* CRC32 of this superblock */
 	__u8    s_uuid[16];         /* UUID */
 	__u8    s_label[32];        /* Volume label */
-	__u8    s_pad[3948];        /* Padding to 4096 bytes */
+	__u8    s_pad[3980];        /* Padding to 4096 bytes */
 } __packed;
 
 /*
  * On-disk inode
- * Size: 128 bytes
+ * Size: 256 bytes
+ *
+ * Addressing capacity:
+ *   direct  (12)  =              48 KiB
+ *   indirect (1)  =               2 MiB
+ *   dindirect (1) =               1 GiB
+ *   tindirect (1) =             512 GiB
+ *
+ * uid/gid: __le32 to support uid > 65535 (standard kernel convention)
+ * timestamps: __le64 nanoseconds (required for space mission precision)
  */
 struct ftrfs_inode {
 	__le16  i_mode;             /* File mode */
-	__le16  i_uid;              /* Owner UID */
-	__le16  i_gid;              /* Owner GID */
 	__le16  i_nlink;            /* Hard link count */
-	__le64  i_size;             /* File size in bytes */
+	__le32  i_uid;              /* Owner UID */
+	__le32  i_gid;              /* Owner GID */
+	__le64  i_size;             /* File size in bytes (64-bit, future-proof) */
 	__le64  i_atime;            /* Access time (ns) */
 	__le64  i_mtime;            /* Modification time (ns) */
 	__le64  i_ctime;            /* Change time (ns) */
-	__le32  i_blocks;           /* Block count */
 	__le32  i_flags;            /* Inode flags */
+	__le32  i_crc32;            /* CRC32 of inode (excluding this field) */
 	__le64  i_direct[FTRFS_DIRECT_BLOCKS];    /* Direct block pointers */
-	__le64  i_indirect;         /* Single indirect */
-	__le64  i_dindirect;        /* Double indirect */
-	__le32  i_crc32;            /* CRC32 of inode */
-	__u8    i_pad[2];           /* Padding to 128 bytes */
+	__le64  i_indirect;         /* Single indirect (~2 MiB) */
+	__le64  i_dindirect;        /* Double indirect (~1 GiB) */
+	__le64  i_tindirect;        /* Triple indirect (~512 GiB) */
+	__u8    i_reserved[84];     /* Padding to 256 bytes */
 } __packed;
 
 /* Inode flags */
@@ -111,6 +124,7 @@ struct ftrfs_inode_info {
 	__le64          i_direct[FTRFS_DIRECT_BLOCKS];
 	__le64          i_indirect;
 	__le64          i_dindirect;
+	__le64          i_tindirect;
 	__u32           i_flags;
 	struct inode    vfs_inode;  /* Must be last */
 };
@@ -140,6 +154,7 @@ extern const struct inode_operations ftrfs_dir_inode_operations;
 /* file.c */
 extern const struct file_operations ftrfs_file_operations;
 extern const struct inode_operations ftrfs_file_inode_operations;
+extern const struct address_space_operations ftrfs_aops;
 
 /* edac.c */
 __u32 ftrfs_crc32(const void *buf, size_t len);
diff --git a/fs/ftrfs/inode.c b/fs/ftrfs/inode.c
index e1279c796..f655ccbd9 100644
--- a/fs/ftrfs/inode.c
+++ b/fs/ftrfs/inode.c
@@ -34,7 +34,7 @@ struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino)
 		return ERR_PTR(-ENOMEM);
 
 	/* Already in cache */
-	if (!(inode_state_read_once(inode) & I_NEW))
+	if (!ftrfs_inode_is_new(inode))
 		return inode;
 
 	inodes_per_block = FTRFS_BLOCK_SIZE / sizeof(struct ftrfs_inode);
@@ -63,11 +63,10 @@ struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino)
 
 	/* Populate VFS inode */
 	inode->i_mode  = le16_to_cpu(raw->i_mode);
-	inode->i_uid   = make_kuid(sb->s_user_ns, le16_to_cpu(raw->i_uid));
-	inode->i_gid   = make_kgid(sb->s_user_ns, le16_to_cpu(raw->i_gid));
+	inode->i_uid   = make_kuid(sb->s_user_ns, le32_to_cpu(raw->i_uid));
+	inode->i_gid   = make_kgid(sb->s_user_ns, le32_to_cpu(raw->i_gid));
 	set_nlink(inode, le16_to_cpu(raw->i_nlink));
 	inode->i_size  = le64_to_cpu(raw->i_size);
-	inode->i_blocks = le32_to_cpu(raw->i_blocks);
 
 	inode_set_atime(inode,
 		le64_to_cpu(raw->i_atime) / NSEC_PER_SEC,
@@ -83,6 +82,7 @@ struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino)
 	memcpy(fi->i_direct, raw->i_direct, sizeof(fi->i_direct));
 	fi->i_indirect  = raw->i_indirect;
 	fi->i_dindirect = raw->i_dindirect;
+	fi->i_tindirect = raw->i_tindirect;
 	fi->i_flags     = le32_to_cpu(raw->i_flags);
 
 	/* Set ops based on file type */
@@ -92,6 +92,7 @@ struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino)
 	} else if (S_ISREG(inode->i_mode)) {
 		inode->i_op  = &ftrfs_file_inode_operations;
 		inode->i_fop = &ftrfs_file_operations;
+		inode->i_mapping->a_ops = &ftrfs_aops;
 	} else {
 		/* Special files: use generic */
 		init_special_inode(inode, inode->i_mode, 0);
diff --git a/fs/ftrfs/namei.c b/fs/ftrfs/namei.c
index a8c1f79eb..d37ad8b7b 100644
--- a/fs/ftrfs/namei.c
+++ b/fs/ftrfs/namei.c
@@ -38,11 +38,10 @@ static int ftrfs_write_inode_raw(struct inode *inode)
 	raw = (struct ftrfs_inode *)bh->b_data + offset;
 
 	raw->i_mode   = cpu_to_le16(inode->i_mode);
-	raw->i_uid    = cpu_to_le16(i_uid_read(inode));
-	raw->i_gid    = cpu_to_le16(i_gid_read(inode));
+	raw->i_uid    = cpu_to_le32(i_uid_read(inode));
+	raw->i_gid    = cpu_to_le32(i_gid_read(inode));
 	raw->i_nlink  = cpu_to_le16(inode->i_nlink);
 	raw->i_size   = cpu_to_le64(inode->i_size);
-	raw->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw->i_atime  = cpu_to_le64(inode_get_atime_sec(inode) * NSEC_PER_SEC
 				     + inode_get_atime_nsec(inode));
 	raw->i_mtime  = cpu_to_le64(inode_get_mtime_sec(inode) * NSEC_PER_SEC
@@ -54,6 +53,7 @@ static int ftrfs_write_inode_raw(struct inode *inode)
 	memcpy(raw->i_direct, fi->i_direct, sizeof(fi->i_direct));
 	raw->i_indirect  = fi->i_indirect;
 	raw->i_dindirect = fi->i_dindirect;
+	raw->i_tindirect = fi->i_tindirect;
 
 	raw->i_crc32 = ftrfs_crc32(raw,
 				    offsetof(struct ftrfs_inode, i_crc32));
@@ -145,7 +145,6 @@ static int ftrfs_add_dirent(struct inode *dir, const struct qstr *name,
 
 	fi->i_direct[i] = cpu_to_le64(block_no);
 	dir->i_size += FTRFS_BLOCK_SIZE;
-	dir->i_blocks++;
 	inode_set_mtime_to_ts(dir, current_time(dir));
 	mark_inode_dirty(dir);
 
@@ -223,7 +222,6 @@ struct inode *ftrfs_new_inode(struct inode *dir, umode_t mode)
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino    = ino;
-	inode->i_blocks = 0;
 	inode->i_size   = 0;
 	inode_set_atime_to_ts(inode, current_time(inode));
 	inode_set_mtime_to_ts(inode, current_time(inode));
@@ -242,12 +240,17 @@ struct inode *ftrfs_new_inode(struct inode *dir, umode_t mode)
 	} else {
 		inode->i_op  = &ftrfs_file_inode_operations;
 		inode->i_fop = &ftrfs_file_operations;
+		inode->i_mapping->a_ops = &ftrfs_aops;
 		set_nlink(inode, 1);
 	}
 
-	insert_inode_hash(inode);
+	if (insert_inode_locked(inode) < 0) {
+		make_bad_inode(inode);
+		iput(inode);
+		return ERR_PTR(-EIO);
+	}
 	mark_inode_dirty(inode);
-	return ERR_CAST(inode);
+	return inode;
 }
 
 /* ------------------------------------------------------------------ */
@@ -277,9 +280,11 @@ static int ftrfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_iput;
 
 	d_instantiate(dentry, inode);
+	unlock_new_inode(inode);
 	return 0;
 
 out_iput:
+	unlock_new_inode(inode);
 	iput(inode);
 	return ret;
 }
@@ -327,9 +332,11 @@ static struct dentry *ftrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_fail;
 
 	d_instantiate(dentry, inode);
+	unlock_new_inode(inode);
 	return NULL;
 
 out_fail:
+	unlock_new_inode(inode);
 	inode_dec_link_count(inode);
 	inode_dec_link_count(inode);
 	iput(inode);
diff --git a/fs/ftrfs/super.c b/fs/ftrfs/super.c
index 8acc62921..bce7148ee 100644
--- a/fs/ftrfs/super.c
+++ b/fs/ftrfs/super.c
@@ -252,6 +252,8 @@ static int __init ftrfs_init(void)
 		return ret;
 	}
 
+	BUILD_BUG_ON(sizeof(struct ftrfs_super_block) != FTRFS_BLOCK_SIZE);
+	BUILD_BUG_ON(sizeof(struct ftrfs_inode) != 256);
 	pr_info("ftrfs: module loaded (FTRFS Fault-Tolerant Radiation-Robust FS)\n");
 	return 0;
 }
-- 
2.52.0

