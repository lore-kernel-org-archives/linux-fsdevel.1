Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F23C65E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083061; cv=none; b=usnWMBHbs136QJ9yWhlRyiVI0JpwETXge+e6do/KJllFud203QAJiWgAlZVWpRz47Upj8LPTtFXZg6wYOj7DeqO/QjmdfQ0QUJn51mBH7QbBB1nJTXB8iWq4W8TLSlwqx9YIe/P4rih16iQpRb7nNB648YgotdoHbSNgROKK5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083061; c=relaxed/simple;
	bh=yt6AQEGexMi31bn9lGbYxFgju7CUboUcmrk812jtz6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK+/JShtAon1etO6Tg6ZU0iRkvRp5cSxxjZoEiq7kLPm/1kqUbBuBc6Rnh5h+EOOGSKu0MB0t1zxh6XUiTAY8cOPBEGbNT3SKuXtRLA+r9bNwS6kNPFslVYeSPMuPBSY/S/drwjx1tfspMlg4qIUnSUqfAjF15SEEsKQjbxfAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so5428325e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083058; x=1776687858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5Jn05Q3TPNOW6ydFxJw6VAfsd3poytYHJlGPnxkM3g=;
        b=VLRf3ZLqLcWc8mnhJeb8M6BVablCrbETusYC9kXc9F9+vbW5+k3d8O6St79PEmCZZw
         +akgYRSMBTzuld6wiRlRGaXakAhie3jEUZ6KtRTgSmfxYoSG3lgvvDHkFMddfNobPySQ
         Ji6EoxOE6ffBnDSM9VizjEElurNdjEqz71nbslRZu8kQF8E1LXatuKkxqm8nQQghzSi6
         uBdesPqAHwISyQdzMGvU4sx+AOhcomfx+eWy/TdZ/1X6u3DNWZv4ixZre8+a6JJztCSF
         P3E43wONWUhyITi3JvOZsN7a6lUe+uA7bDq1OYq8DB4o3R/C6zwdpj0iXZDjUB6grIpO
         XYcQ==
X-Gm-Message-State: AOJu0Yz3AqqIl8iKFNdbIowvyxV7GsV7HfFRxZFzWn0qwjAQ2hGSc6PO
	tM0IzGFUwkdHiCIm7g1wRzCH2gUXgjVnhW5BsbPMG260bEYzyj+jYUHkcVE2AVXk0Kc=
X-Gm-Gg: AeBDiesn2H2FDKB7Ir8IfqqQ85ex3bqx0FksPz1hedxyfVPZ0vkn0URiLJKb28fN+P/
	yc10urNqu43DoR45z4tvmgp/Dwhzxi+s3zStYQg9Y50LMfHSyeCus8ZjHqEMzwR+K22ZFhckiho
	dRaBfmy3fF8a2fNDG7Lm3iYs27BpPGISEapf/5ZNznDshJ3Ryv4eDGAZzkVXMzUO5FOx/E8NIAu
	QVApBdeqtb32yDSUD1CD58LU0ctTHoDqISE8/vXb3yCRjms4/VWVasHv77qfZkjCyGIXDeLHtAk
	W5DToavFz0r/W5xwsvXmzLRoin5cx0JTY/PSDPAcj/k4TpjkrOdcaqLkh7qu0iSd/RHFVeU+uXH
	DIf41ZgmtPj+bj9cRnuIWg8uc6erRRHc7yregbwWq/swNrAwyy8MGYqfWCHpSWc/rnSscG3u/z1
	a4ZxwZrbPn31RZiST6yPhya3cRX7mXWKiv4u9aMOdbew72GrxmPfBAEGdXZ6HVuljZKg==
X-Received: by 2002:a05:600c:1395:b0:485:329b:24e with SMTP id 5b1f17b1804b1-488d68603bemr95525415e9.5.1776083057460;
        Mon, 13 Apr 2026 05:24:17 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:17 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 04/10] ftrfs: add directory operations
Date: Mon, 13 Apr 2026 16:23:50 +0200
Message-ID: <20260413142357.515792-5-aurelien@hackers.camp>
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

Implement directory iteration and lookup:

- ftrfs_readdir(): iterate directory entries from direct blocks,
  emit via dir_emit_dots() then dir_emit() for real entries,
  use ctx->pos as entry index with INT_MAX as EOF sentinel
- ftrfs_lookup(): search directory blocks for a matching name,
  call ftrfs_iget() on match and return via d_splice_alias()

Both functions scan ftrfs_dir_entry records in direct block
pointers only (no indirect block support yet).

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
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

