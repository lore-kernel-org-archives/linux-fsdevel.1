Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575738D007
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114378; cv=none; b=AmZt8QlMyIfHHdRXQCwJ04wN6+oUHo6KaaVVpUidnU7bnz4syjTQdEjxSrUgiWxmladajXm7Jk0ZJD/lmyWMf/Snan4s5NQxbn7PA/6R/v2uIxkU0moslN+GJYfUeJ/8xgMYyy4SiiUfXkLa9lpfarhX+PtTr0Th5EPu9b1nOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114378; c=relaxed/simple;
	bh=VhjFbMSlOshu11yavoVTfVmUUwRlwLSHPzn80gEY9fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijZHF5HkcchuYJXaui452GzHUO+7J1V5kF1eS5XUMfBR7/0u1pTpvRxtLLbesJKiSRx/Wc5/MIESP2VsNetFw/8YHG5LTMC7ASAn+8qAR/Jo+8Qadg2ncj3xVub1w21wYvtLqnUXGNyRoOryHEpFGnYGnLY0XPe+3dWAhKbgdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so7778855e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114374; x=1776719174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ky4MuvaYCkkHfYmDAn86zRZn9P/nobrWNgfD4GBihFk=;
        b=nWMVOAlCDMJWHbkEylDPQ9kjBZtn6mhc9S2PWkwahJXecY27mUmZk2rqS/ZMvdpZwo
         FPm3hVLlpqSl8CcrtOpTj49iHDg/2E0yKn3c8RNtaSZ/SgLMsQhtiJDBocB42ECyowGq
         HaabUvBke4YyWJ8q05WS/HmU7VX+YPzB2eeJ8AhFfVX3b6ZDbw5l/ItZp+jFNMX0tZIE
         +Bs5gQaxZyjLRBi0FpcTyx9urhXlbD8Ex0nErztDT2OWN57DU/akffPTQC+GnzTBXgfP
         iSBTcWYatksHcd0phsDJo7zjogPNXBCnTa8k0PUJqKhxNt+W1lIh08wxPa7bWITnX8Cz
         GWpQ==
X-Gm-Message-State: AOJu0YyzBXYQU+L7dOCQLTDV8fDSkeqcH7hcWgKieFYzbAtAVqSSexcO
	oLHtlu+BCK0LjlQYL/knXZCdCEGTkcoy0f763gj7Q+EaDFO2T7TkXjOWOFH1BNbphD4=
X-Gm-Gg: AeBDiev3Fx7QFOVOI/iObJsl8Ad5wpi/zNDsXDzVdGtXN3PEXFRhIHJH4Ez7PYdwrX4
	pUPfTx3kVQB5iAFZhXbk8etgU9DnfA4rGceftfNoD9+hbJ9uh4pixztAXVGnInu7FkWCFcckFa7
	GmNnMhT9A3RITjouBzbOhTqEFf2LP4/Br7Is902Su/+eLS9+gTk/YPmYpRSc19toKkF//W/WM1w
	SR6nV695N0N8/lG5NSlUVgwvapPyhwy63IJllAW8F0mPxfefa3Laa8wPFFtokVyo9bQzrS76QVv
	sQ2bt96amHTJulSJhV5a61haJNCXLJfgBFsWI6pLcJ4JOO42PKbzIRf+CGx1m5K9l6o41GWKNVD
	skVRA3AdyQq/gX8k0Jul687LbXO/NQcK+7mrEjtVVC2kgvAhROm3xAYWVo283v+pv2nHMAfzRcf
	fn3CDSimxpW2xvicG1CEVoe/NldnNgxmNjYLNtgjfny0H3TGikG8Y4cyi4GqLJqP+u3wALtTL2G
	Bjn
X-Received: by 2002:a05:600c:4fca:b0:485:f1d6:2b1d with SMTP id 5b1f17b1804b1-488d6658dafmr121717735e9.0.1776114373746;
        Mon, 13 Apr 2026 14:06:13 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:13 -0700 (PDT)
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
Subject: [PATCH v2 01/11] ftrfs: add on-disk format and in-memory data structures
Date: Tue, 14 Apr 2026 01:05:42 +0200
Message-ID: <20260413230601.525400-2-aurelien@hackers.camp>
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

Add the core header defining FTRFS on-disk layout and in-memory
VFS structures.

On-disk layout:
  Block 0         : superblock (magic 0x46545246, CRC32-protected)
  Block 1..N      : inode table (128 bytes/inode, CRC32 per inode)
  Block N+1..end  : data blocks (CRC32 per block, RS FEC planned)

Structures:
  ftrfs_super_block  : on-disk superblock
  ftrfs_inode        : on-disk inode (12 direct + 1 indirect + 1 dindirect)
  ftrfs_dir_entry    : on-disk directory entry (256-byte name)
  ftrfs_sb_info      : in-memory superblock info (VFS sb->s_fs_info)
  ftrfs_inode_info   : in-memory inode (embedded VFS inode)

FTRFS targets POSIX-compatible block devices (MRAM, NOR flash, eMMC)
for use in radiation-intensive environments (space applications).

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/ftrfs.h | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 fs/ftrfs/ftrfs.h

diff --git a/fs/ftrfs/ftrfs.h b/fs/ftrfs/ftrfs.h
new file mode 100644
index 000000000..82502c9fb
--- /dev/null
+++ b/fs/ftrfs/ftrfs.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * FTRFS — Fault-Tolerant Radiation-Robust Filesystem
+ * Based on: Fuchs, Langer, Trinitis — ARCS 2015
+ *
+ * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
+ */
+
+#ifndef _FTRFS_H
+#define _FTRFS_H
+
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/types.h>
+
+/* Magic number: 'FTRF' */
+#define FTRFS_MAGIC         0x46545246
+
+/* Block size: 4096 bytes */
+#define FTRFS_BLOCK_SIZE    4096
+#define FTRFS_BLOCK_SHIFT   12
+
+/* RS FEC: 16 parity bytes per 239-byte subblock (RS(255,239)) */
+#define FTRFS_RS_PARITY     16
+#define FTRFS_SUBBLOCK_DATA 239
+#define FTRFS_SUBBLOCK_TOTAL (FTRFS_SUBBLOCK_DATA + FTRFS_RS_PARITY)
+
+/* Filesystem limits */
+#define FTRFS_MAX_FILENAME  255
+#define FTRFS_DIRECT_BLOCKS 12
+#define FTRFS_INDIRECT_BLOCKS 1
+#define FTRFS_DINDIRECT_BLOCKS 1
+
+/*
+ * On-disk superblock — block 0
+ * Total size: fits in one 4096-byte block
+ */
+struct ftrfs_super_block {
+	__le32  s_magic;            /* FTRFS_MAGIC */
+	__le32  s_block_size;       /* Block size in bytes */
+	__le64  s_block_count;      /* Total blocks */
+	__le64  s_free_blocks;      /* Free blocks */
+	__le64  s_inode_count;      /* Total inodes */
+	__le64  s_free_inodes;      /* Free inodes */
+	__le64  s_inode_table_blk;  /* Block where inode table starts */
+	__le64  s_data_start_blk;   /* First data block */
+	__le32  s_version;          /* Filesystem version */
+	__le32  s_flags;            /* Flags */
+	__le32  s_crc32;            /* CRC32 of this superblock */
+	__u8    s_uuid[16];         /* UUID */
+	__u8    s_label[32];        /* Volume label */
+	__u8    s_pad[3948];        /* Padding to 4096 bytes */
+} __packed;
+
+/*
+ * On-disk inode
+ * Size: 128 bytes
+ */
+struct ftrfs_inode {
+	__le16  i_mode;             /* File mode */
+	__le16  i_uid;              /* Owner UID */
+	__le16  i_gid;              /* Owner GID */
+	__le16  i_nlink;            /* Hard link count */
+	__le64  i_size;             /* File size in bytes */
+	__le64  i_atime;            /* Access time (ns) */
+	__le64  i_mtime;            /* Modification time (ns) */
+	__le64  i_ctime;            /* Change time (ns) */
+	__le32  i_blocks;           /* Block count */
+	__le32  i_flags;            /* Inode flags */
+	__le64  i_direct[FTRFS_DIRECT_BLOCKS];    /* Direct block pointers */
+	__le64  i_indirect;         /* Single indirect */
+	__le64  i_dindirect;        /* Double indirect */
+	__le32  i_crc32;            /* CRC32 of inode */
+	__u8    i_pad[2];           /* Padding to 128 bytes */
+} __packed;
+
+/* Inode flags */
+#define FTRFS_INODE_FL_RS_ENABLED   0x0001  /* RS FEC enabled */
+#define FTRFS_INODE_FL_VERIFIED     0x0002  /* Integrity verified */
+
+/*
+ * On-disk directory entry
+ */
+struct ftrfs_dir_entry {
+	__le64  d_ino;              /* Inode number */
+	__le16  d_rec_len;          /* Record length */
+	__u8    d_name_len;         /* Name length */
+	__u8    d_file_type;        /* File type */
+	char    d_name[FTRFS_MAX_FILENAME + 1]; /* Filename */
+} __packed;
+
+/*
+ * In-memory superblock info (stored in sb->s_fs_info)
+ */
+struct ftrfs_sb_info {
+	/* Block allocator */
+	unsigned long    *s_block_bitmap;  /* In-memory free block bitmap */
+	unsigned long     s_nblocks;       /* Number of data blocks */
+	unsigned long     s_data_start;    /* First data block number */
+	struct ftrfs_super_block *s_ftrfs_sb; /* On-disk superblock copy */
+	struct buffer_head       *s_sbh;      /* Buffer head for superblock */
+	spinlock_t                s_lock;     /* Superblock lock */
+	unsigned long             s_free_blocks;
+	unsigned long             s_free_inodes;
+};
+
+/*
+ * In-memory inode info (embedded in VFS inode via container_of)
+ */
+struct ftrfs_inode_info {
+	__le64          i_direct[FTRFS_DIRECT_BLOCKS];
+	__le64          i_indirect;
+	__le64          i_dindirect;
+	__u32           i_flags;
+	struct inode    vfs_inode;  /* Must be last */
+};
+
+static inline struct ftrfs_inode_info *FTRFS_I(struct inode *inode)
+{
+	return container_of(inode, struct ftrfs_inode_info, vfs_inode);
+}
+
+static inline struct ftrfs_sb_info *FTRFS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+/* Function prototypes */
+/* super.c */
+int ftrfs_fill_super(struct super_block *sb, struct fs_context *fc);
+
+/* inode.c */
+struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino);
+struct inode *ftrfs_new_inode(struct inode *dir, umode_t mode);
+
+/* dir.c */
+extern const struct file_operations ftrfs_dir_operations;
+extern const struct inode_operations ftrfs_dir_inode_operations;
+
+/* file.c */
+extern const struct file_operations ftrfs_file_operations;
+extern const struct inode_operations ftrfs_file_inode_operations;
+
+/* edac.c */
+__u32 ftrfs_crc32(const void *buf, size_t len);
+int ftrfs_rs_encode(uint8_t *data, uint8_t *parity);
+int ftrfs_rs_decode(uint8_t *data, uint8_t *parity);
+
+/* block.c */
+
+#endif /* _FTRFS_H */
+
+/*
+ */
+
+/* alloc.c */
+int  ftrfs_setup_bitmap(struct super_block *sb);
+void ftrfs_destroy_bitmap(struct super_block *sb);
+u64  ftrfs_alloc_block(struct super_block *sb);
+void ftrfs_free_block(struct super_block *sb, u64 block);
+u64  ftrfs_alloc_inode_num(struct super_block *sb);
+
+/* dir.c */
+struct dentry *ftrfs_lookup(struct inode *dir, struct dentry *dentry,
+			    unsigned int flags);
+
+/* namei.c */
+int ftrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
-- 
2.52.0

