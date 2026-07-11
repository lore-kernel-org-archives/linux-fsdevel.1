Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845830EF8F
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803579; cv=none; b=jni6xxGrsWH8jci4ykadnJ+kvRc5+2yoaIV7tS2NZz696P+XxLUwNEV4GR25OEl9LS31l5ov4B/N1BDhCnuAm2CbeRk9ash/fX6YpzCxTqiTHlvRWWhkAE19l98VI4jxSEiWgCx0hkbNGoijzdOwcZGt3IKum/tXl3dDHaKOuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803579; c=relaxed/simple;
	bh=S2c+amldauTM7YnNw3EfHUsePk7PpfRxalX3JOB2TqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBVlj839QAWkuxRrK1wSPsVOfctqAmfeiYo36E2thmrGo6vnuFfPEa2oOkIcwkr4CGPrm5/LN6gboPCSuJkTf07iLqggR2lKXMbwDPnxJb+r9ASQhPT8pc0HWfPyLOJsgrc4bkBtt5+vl61eXILvk5WwRLx0K+E20f/A7ZsAW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/TZhbi+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/TZhbi+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84874b52eabso2447779b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783803577; x=1784408377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsTZk/W1iYG8o2QI+sZ33lAhlke6YlquVhNA6dVDEoU=;
        b=W/TZhbi+Lw2b17fWzRpJ5ALRNgpWRvHn/RSyptK9SLZdlZk8mnSRa1wSTkIS10d63g
         WJ9BzqOP2PImzj7C8K/FflZugZIEbtkQJ9t1BUy8HWVKvZdFJUu+qJwGb9gADtPVXwf1
         jgJcwcJ7mAyZh4rGE5fHU2ExkkzxTi4aJB7yc4925bnTOeeWqsyp+kQifaWhNUiVmx8D
         mrT0oE2aQq2y7lauerqB+5WTs0ULaVrjxyLRzfSmroV77G9RmAnkXl3u7jPF7jk+vkQc
         tFs3XnEpINauAHf9IRV9eXmEc6LmkLthI0+QpbbY3rIVlPCC7lNvlI3B6LgoAb6j7Nmg
         ysRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803577; x=1784408377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsTZk/W1iYG8o2QI+sZ33lAhlke6YlquVhNA6dVDEoU=;
        b=X4ZwvjqLkJGOzK0rR7hUW6yUPbZZoNzU41i777DCo0olaiybNvaNNt87RivdQR8uCz
         /FttjcJl1UyUnO0YCrfc3LCcQVndzjKqb7cWZMX9+snN+oXyQ03qa9Ay3K50GWf99X8J
         3Ye/q+w2jF1SZibqH6YRmteznfLa4zwNaqD5p/F+VWWrnnc4/g9MG5k6Sq00lZhRVaSZ
         GeP99w5lsuBuEvjpNSykEe+z+UCYl4wQLEIOKcYGyGpnjZP0l1Yzwv2O14Xl/flR8BYB
         cKkIWnFJmi0RCsiD6YRyysgkGlyxFsUi77c+m2M2zbgFITOYI95lC45dXNlNL2ubEwr+
         3xIA==
X-Gm-Message-State: AOJu0YwH3UR6h9Q/umE2QTLgGOAxOFu27Y2TgzqcbNuRMuCkZWeJpOkf
	EYYFxbTuMFzSJExwFVR25XDSfgjp9kz8eq52jnpxNNnUzGdZUa6k2h1kGROMhw==
X-Gm-Gg: AfdE7cmwTPRPj6/Gznxz64KF3Sw0oHNp+5GetIfJfR+gZeLkf8s1hc67rj0EWc/RnVR
	R5JuXhVx7EAunCIOTTRPG93rFVVSsBV68PutaZJKivuzZLPB5fG0LeX0c9Phh/KyAz/Wl9b2lqP
	7o83qi4pKaev2EoiB8f9M7XtANLudeWI+04aU8DPUE2Usxk9upc77loZFigr/oRly3yu3azcr2m
	ceNPHHi2jhnD51rl3AERu+pcXvtrPbKMormz1R3mOI/5Pl7277pi6oRgFwxt4HMNCCH6rlHLvf6
	/VgmRNdFdB7uAHmbuWmRDFYtj7Zyx6oNSulbBB4O0/rSGDFQ6vWVuBjrzYajlGMj1MG1e4pwFU8
	xS95wLQJZv8GHnC4BS1YC7VkdukAn+1hpyDTegg4EF+rqb6LoGcimEbcZSiiN9PgP4ikM+ijM6w
	==
X-Received: by 2002:a05:6a00:1ca3:b0:848:2f77:e2de with SMTP id d2e1a72fcca58-848897aa4femr3468325b3a.71.1783803576746;
        Sat, 11 Jul 2026 13:59:36 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm2092057b3a.20.2026.07.11.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:59:36 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v3 5/5] minix: iomap inode operations
Date: Sat, 11 Jul 2026 13:59:09 -0700
Message-ID: <5eaea9f680ed89adc933ed72391c3e762ca4ad9b.1783707063.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783707063.git.jbingham@gmail.com>
References: <cover.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire the new iomap functionality into the inode operations. Entirely new
functions for writeback and a minix_writeback_ops struct have been
added, and the address space operation functions have been updated to
use iomap. Since directory operations still work the old way, the old
functions have been preserved with new names. Directories also get their
own address operation struct.

Also, bmap support is dropped entirely per Darrick Wong's suggestion.

This patch also updates minix_symlink to use the new iomap_symlink_write
function, removing the need to bypass iomap to read and write symlinks
directly. This was also suggested by Darrick Wong.

Suggested-by: Darrick J. Wong <djwong@kernel.org>

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/inode.c | 85 +++++++++++++++++++++++++++++++++++++++++-------
 fs/minix/namei.c |  8 ++++-
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index d5ba72f51049..f6747bacdb14 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -436,6 +436,31 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
+	struct folio *folio, u64 pos, unsigned int len, u64 end_pos)
+{
+	int error;
+
+	if (pos < wpc->iomap.offset ||
+			pos >= wpc->iomap.offset + wpc->iomap.length) {
+		if (INODE_VERSION(wpc->inode) == MINIX_V1)
+			error = V1_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
+				&wpc->iomap, NULL);
+		else
+			error = V2_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
+				&wpc->iomap, NULL);
+		if (error)
+			return error;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, pos, end_pos, len);
+}
+
+static const struct iomap_writeback_ops minix_writeback_ops = {
+	.writeback_range = minix_writeback_range,
+	.writeback_submit = iomap_ioend_writeback_submit,
+};
+
 static int minix_get_block(struct inode *inode, sector_t block,
 		    struct buffer_head *bh_result, int create)
 {
@@ -445,17 +470,45 @@ static int minix_get_block(struct inode *inode, sector_t block,
 		return V2_minix_get_block(inode, block, bh_result, create);
 }
 
-static int minix_writepages(struct address_space *mapping,
+/* The old minix_writepages, preserved for directory operations. */
+static int minix_block_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, minix_get_block);
 }
 
+static int minix_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = {
+		.inode = mapping->host,
+		.wbc = wbc,
+		.ops = &minix_writeback_ops,
+	};
+	return iomap_writepages(&wpc);
+}
+
 static int minix_read_folio(struct file *file, struct folio *folio)
+{
+	const struct iomap_ops *ops = minix_iomap_ops_ver(folio->mapping->host);
+
+	iomap_bio_read_folio(folio, ops);
+	return 0;
+}
+
+/* The old minix_read_folio, preserved for directory operations. */
+static int minix_block_read_folio(struct file *file, struct folio *folio)
 {
 	return block_read_full_folio(folio, minix_get_block);
 }
 
+static void minix_readahead(struct readahead_control *rac)
+{
+	const struct iomap_ops *ops = minix_iomap_ops_ver(rac->mapping->host);
+
+	iomap_bio_readahead(rac, ops);
+}
+
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
 	return __block_write_begin(folio, pos, len, minix_get_block);
@@ -485,26 +538,35 @@ static int minix_write_begin(const struct kiocb *iocb,
 	return ret;
 }
 
-static sector_t minix_bmap(struct address_space *mapping, sector_t block)
-{
-	return generic_block_bmap(mapping,block,minix_get_block);
-}
-
 const struct address_space_operations minix_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio	= iomap_dirty_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 	.read_folio = minix_read_folio,
+	.readahead = minix_readahead,
 	.writepages = minix_writepages,
+	.migrate_folio = filemap_migrate_folio,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
+	.release_folio = iomap_release_folio,
+	.error_remove_folio = generic_error_remove_folio,
+};
+
+/* A special aops for directories that keeps using the buffer head chunks, at
+ * least for the time being.
+ */
+static const struct address_space_operations minix_dir_aops = {
+	.dirty_folio = block_dirty_folio,
+	.invalidate_folio = block_invalidate_folio,
+	.read_folio = minix_block_read_folio,
 	.write_begin = minix_write_begin,
 	.write_end = generic_write_end,
 	.migrate_folio = buffer_migrate_folio,
-	.bmap = minix_bmap,
-	.direct_IO = noop_direct_IO
+	.writepages = minix_block_writepages,
 };
 
 static const struct inode_operations minix_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.getattr	= minix_getattr,
+	.setattr	= minix_setattr,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
@@ -516,7 +578,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &minix_dir_inode_operations;
 		inode->i_fop = &minix_dir_operations;
-		inode->i_mapping->a_ops = &minix_aops;
+		inode->i_mapping->a_ops = &minix_dir_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
 		inode->i_op = &minix_symlink_inode_operations;
 		inode_nohighmem(inode);
@@ -768,4 +830,3 @@ module_init(init_minix_fs)
 module_exit(exit_minix_fs)
 MODULE_DESCRIPTION("Minix file system");
 MODULE_LICENSE("GPL");
-
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 263e4ba8b1c8..bb5892f9fb2a 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -6,6 +6,7 @@
  */
 
 #include "minix.h"
+#include <linux/iomap.h>
 
 static int add_nondir(struct dentry *dentry, struct inode *inode)
 {
@@ -84,12 +85,17 @@ static int minix_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return PTR_ERR(inode);
 
 	minix_set_inode(inode, 0);
-	err = page_symlink(inode, symname, i);
+	err = iomap_symlink_write(inode, symname, i, minix_iomap_ops_ver(inode), NULL, NULL);
+
+	if (!err)
+		i_size_write(inode, i - 1);
+
 	if (unlikely(err)) {
 		inode_dec_link_count(inode);
 		iput(inode);
 		return err;
 	}
+
 	return add_nondir(dentry, inode);
 }
 
-- 
2.47.3

