Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CB3CCFBA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161257; cv=none; b=o3bt9uSiVxUR2/w/opmne+21l1cgys2WHTUMMFE2Pv3YXVyJp6drQEbv1RWOi6ppyB59Yjvlh5JHq3VhsecKFfYsm8XV4rWDblt/6W1rMj9NmjdmwB+XOH+Iitx7m1c8QnYvdlsIR34BMaBfrB1q+C3gCgRyp0Ik888vANVXSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161257; c=relaxed/simple;
	bh=UpYZeqLlO7XAI8xioHTCGc+EjyJYzK1FRJsK8WUWOeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peyOKFXgv1dAXO0VGctRTIAOnv6rGqp1+5aHN2aVUNAvxzZW1wrhhMZPXtRq0s/BvEM2tT23ozlg0H0r21hcXaW+eSj5bJOtG2UUxmX2MJOjhCQcPxHrwFs/ZYp/lo4aWwkldQJmOwF2CegbfF12D4Zisb5AsYKPeLM8T+eZjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483708b697cso8693165e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161253; x=1776766053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZYlrpG6ibaaLw+Sa4FOLMlMfX1UHEtv7mMrIDu+G+Y=;
        b=YPHc47heSXagZMXYHWPpK5Ctb3jiFiJPYCJO1RABtos0vwp3F4Tr660SnLLtt5NrDM
         in4AchuuK9p5/jLxbZZGohwqpq9+Hj0SDIlBzwFcTyJyCXHRVHVRQ+z5ckSVl8EN3MOK
         zZ5XujIksvxdmphmrx3i1lrYAPBS6iN0xsewj9UInfzXx1RESFjxUMm1nDjkRYSYuV9N
         7CWNyckT2wiyQTC4ulLMj3jyX2vVVULARqqOmX8hHDhz9HlxscaCzwBETO1Qeyo9tuia
         /p879ZG9nT6JppXaWm74+kX5jo6o2zRxjJl8mkzB67MbOMmTEnydJH1zdBQ3oul3l5uv
         S9gw==
X-Gm-Message-State: AOJu0Yw9l29PnpwM8bQsXQKcmLnjh9sZBN8acjjbaVUs9UAaGLZntnc0
	Po+uiNPR5lt3ow20eGO4GeQF0p2Dz6M4iQDSv5aLmX+lo1VoGM4UXo9ZFtZgmemw
X-Gm-Gg: AeBDieu8VIszlBFiDnKYpZIVLbYIMwuqFQIxCIcbZJeLPC+nwmHPvq868NYeulEZlC2
	M2w4iPcEPatoagRU3L7FKs0N7B+Y7mDS+LsOXHz9EZxcwm9DAjkE4T1StzSXQUvhRLy9HFhUvfM
	T5ADhMevw9ici8kOc/etjDHowk3G9+kyyJr8ajbbx71Fc/CALnOrpdKxh5rpXOT0y73tQPyw/pU
	ripbNUlbc4KSJqnMeOJ3u5XLJDn0CmNkOMni909r2FyJDubguj3Poj+iqRvbNBrhVpreFU94kXd
	piqMl2rRTozmII1MKurJgV5jY7IOTnhmhK3nIjgOBf8nqgGuf4bhd3UIO6H8uxKuP+LVeEnRNzS
	BK3qrrtM3JiHH7grWNiAJcMhODTMsw24hI/ozHrfEVQL68/edc+BOJBR9UgyyZpju4pwDAzoned
	I19BX6yRW6FdQBYobA5cex2HHlUQ0DYDy3kceNUIwCl5qs7qqPMg3ULlO3wu/A2NIeRV1Be17nA
	Vk=
X-Received: by 2002:a05:600c:b85:b0:486:fb8a:fed with SMTP id 5b1f17b1804b1-488d68a0975mr124812685e9.8.1776161253251;
        Tue, 14 Apr 2026 03:07:33 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:32 -0700 (PDT)
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
Subject: [PATCH v3 04/12] ftrfs: add directory operations
Date: Tue, 14 Apr 2026 14:07:17 +0200
Message-ID: <20260414120726.5713-5-aurelien@hackers.camp>
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
index 000000000000..dbf0102a40f3
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

