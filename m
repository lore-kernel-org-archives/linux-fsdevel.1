Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43850396562
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114387; cv=none; b=HlGu6EcT3VS+tmnfmWcQtODJQRcYHfnLUW8OLmLVuydUbBEbM27xtS9AlS/8q6gwnmfDBAQ5PXvU3+/fbvg1OD3dCIdr+qtm0xpOAKNribO820LSEWCs9JTO9nNV8wSBiN4bHaPytfOf489ppy5GE9wZQs4MFXMyc9NRoYOx0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114387; c=relaxed/simple;
	bh=+r1Y3kHnY4xi3Jk1Q7GHUslpyQv7/s2wi8tCMEA0jz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeOQ91srxMKv5f7NGVJkxIVpWW1HrGXKwY0hcLH9bVE/RsSVngofIP6aysAOe4tG01H9s5rp56bZTXO4W9XML1wTdygN5OUIqY7D5UOy0Ar7XN5GfToeUILOcb9eNgw58UmPwpJIS9Cx2PU+Clh2XwPGM5bk8U8gKKxM/tWvFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48880947b7dso6520995e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114383; x=1776719183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLhHtjSxaas4v+h5EWtZjmwyeBl0aB7UUhjqllpkU1I=;
        b=qYzcmnMGrS7CpFUiSsm6j7lRJLa+vBBv7y3zjUTWZyke+4z/HojXjZWmCQknyxD9XG
         zKhwOV1uh8hCoc7V1lEaYHSdAuuewzn8IBoho0IT7uMr2YFVna6K10y8G6liNG7COxUM
         RPhGWGavhtcMN0uymEzB3xLBKUgz0USmKpCw2PEN6Ric/HdQB4aslVRbc3x2y2thDKf7
         y9S6FRBQQ8SuAk4YAjv+qV6rLWJpm36ANmW0uYelZInCiFHRJgl7t7cVqLCB+54AktaU
         h+ND0Ek8dX0Pnr+DQ8IxTez2XIVSgnzUR4tfS4kVOYR4Ftaot78NB2BClWAiTAn2Mq3m
         EMMQ==
X-Gm-Message-State: AOJu0YwFWoLwJoOmYayAhiABmu8sqYTRFR4A7QF6hw1KZNMQ7+lSwJK1
	QbUOz787cYCeB9InCzyjYaNlLk6XDIw8YC15jRcYsikwXac1gisJSQQL2IoBpEUMfkg=
X-Gm-Gg: AeBDiet7sSa3C2ReWIkrEj5TUt7x1OOMF/hHiTlV76qHsjUZvbk6qbmbWCQMUxxMFrl
	AhrA3HfOa+JDdPbi2eJwDEY2G2LO1ZYjrPaMN0ZpAsHa3D2wsQlKGSHLE7TfJZipl2ICBYyAmBt
	5DO81EyS4Ugx5K9e4Bd6qmLW2dr8I5xWX9t6YQvFb0+zPBKpRRUFI6+po/Y8tsR6Xfsm6PilG35
	9ONCR1AgoEqlPVybo5PAMy6kGoynSe8kKcLwdzQ0Rkah3oQiVafd0+MrP+HFlYIvXsMAwXvaT0M
	MKEERJyrU0vsPZkh2V5CgpwpSEL8aXvCjo4x9URFaiPxbhYqnegTAe2fLwQox0+Q/V/NLgyv9ok
	2wn/hVAe8Kz9hnWCUhf6UO1kOJVlZWKdLtHfOHieY+7mUB+TwfRwChE/w2Bf6p86jVICM1jBzNq
	fiYIunNVa3lAT5Xfych9cJ2Kzmtan3iyySBHZHTjZp9m+I0QbR8ppI3nZS4ePL/wIwoyzeIiF+D
	lnQ
X-Received: by 2002:a05:600c:4689:b0:488:93c5:4dc with SMTP id 5b1f17b1804b1-488d7f76192mr120984355e9.7.1776114383341;
        Mon, 13 Apr 2026 14:06:23 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:22 -0700 (PDT)
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
Subject: [PATCH v2 04/11] ftrfs: add directory operations
Date: Tue, 14 Apr 2026 01:05:45 +0200
Message-ID: <20260413230601.525400-5-aurelien@hackers.camp>
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

Implement directory iteration and lookup:

- ftrfs_readdir(): iterate directory entries from direct blocks,
  emit via dir_emit_dots() then dir_emit() for real entries,
  use ctx->pos as entry index with INT_MAX as EOF sentinel
- ftrfs_lookup(): search directory blocks for a matching name,
  call ftrfs_iget() on match and return via d_splice_alias()

Both functions scan ftrfs_dir_entry records in direct block
pointers only (no indirect block support yet).

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/dir.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 fs/ftrfs/dir.c

diff --git a/fs/ftrfs/dir.c b/fs/ftrfs/dir.c
new file mode 100644
index 000000000..dbf0102a4
--- /dev/null
+++ b/fs/ftrfs/dir.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — Directory operations
+ * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
+ */
+
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+#include "ftrfs.h"
+
+/*
+ * ftrfs_readdir — iterate directory entries
+ */
+static int ftrfs_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct inode       *inode = file_inode(file);
+	struct super_block *sb    = inode->i_sb;
+	struct ftrfs_inode_info *fi = FTRFS_I(inode);
+	struct buffer_head *bh;
+	struct ftrfs_dir_entry *de;
+	unsigned long block_idx, block_no;
+	unsigned int  offset;
+
+	/* EOF guard */
+	if (ctx->pos == INT_MAX)
+		return 0;
+	/* Emit . and .. (ctx->pos: 0=., 1=.., 2+=real entries) */
+	if (ctx->pos < 2) {
+		if (!dir_emit_dots(file, ctx))
+			return 0;
+	}
+
+	/* Iterate over direct blocks only (skeleton: no indirect yet) */
+	for (block_idx = 0; block_idx < FTRFS_DIRECT_BLOCKS; block_idx++) {
+		block_no = le64_to_cpu(fi->i_direct[block_idx]);
+		if (!block_no)
+			break;
+
+		bh = sb_bread(sb, block_no);
+		if (!bh)
+			continue;
+
+		offset = 0;
+		while (offset < FTRFS_BLOCK_SIZE) {
+			de = (struct ftrfs_dir_entry *)(bh->b_data + offset);
+
+			if (!de->d_rec_len)
+				break; /* end of dir block */
+
+			if (de->d_ino && de->d_name_len) {
+				if (!dir_emit(ctx,
+					      de->d_name,
+					      de->d_name_len,
+					      le64_to_cpu(de->d_ino),
+					      de->d_file_type)) {
+					brelse(bh);
+					return 0;
+				}
+				ctx->pos++;
+			}
+
+			offset += le16_to_cpu(de->d_rec_len);
+		}
+
+		brelse(bh);
+	}
+
+	ctx->pos = INT_MAX;
+	return 0;
+}
+
+/*
+ * ftrfs_lookup — find dentry in directory
+ */
+struct dentry *ftrfs_lookup(struct inode *dir,
+				   struct dentry *dentry,
+				   unsigned int flags)
+{
+	struct super_block      *sb = dir->i_sb;
+	struct ftrfs_inode_info *fi = FTRFS_I(dir);
+	struct buffer_head      *bh;
+	struct ftrfs_dir_entry  *de;
+	struct inode            *inode = NULL;
+	unsigned long            block_idx, block_no;
+	unsigned int             offset;
+
+	if (dentry->d_name.len > FTRFS_MAX_FILENAME)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	for (block_idx = 0; block_idx < FTRFS_DIRECT_BLOCKS; block_idx++) {
+		block_no = le64_to_cpu(fi->i_direct[block_idx]);
+		if (!block_no)
+			break;
+
+		bh = sb_bread(sb, block_no);
+		if (!bh)
+			continue;
+
+		offset = 0;
+		while (offset < FTRFS_BLOCK_SIZE) {
+			de = (struct ftrfs_dir_entry *)(bh->b_data + offset);
+
+			if (!de->d_rec_len)
+				break; /* end of dir block */
+
+			if (de->d_ino &&
+			    de->d_name_len == dentry->d_name.len &&
+			    !memcmp(de->d_name, dentry->d_name.name,
+				    de->d_name_len)) {
+				unsigned long ino = le64_to_cpu(de->d_ino);
+
+				brelse(bh);
+				inode = ftrfs_iget(sb, ino);
+				goto found;
+			}
+
+			offset += le16_to_cpu(de->d_rec_len);
+		}
+		brelse(bh);
+	}
+
+found:
+	return d_splice_alias(inode, dentry);
+}
+
+const struct file_operations ftrfs_dir_operations = {
+	.llseek  = generic_file_llseek,
+	.read    = generic_read_dir,
+	.iterate_shared = ftrfs_readdir,
+};
+
+
-- 
2.52.0

