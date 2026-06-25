Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AF3002A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424098; cv=none; b=jvrWKc7CHfBad3VqQjxfpbgxB5WqprKCgh/8aYnuXduqY2Yj9NbD+mpZDnhxjvldEvtzp+9xmuZawCGOIASOYdJCqyueFYbMnnAF6mK1FOdbOj0xh9mzwxAu/a1gUasgpxJb2MWA5MIaQrPKGDaP7C8PsneiN63n7sRflp0DfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424098; c=relaxed/simple;
	bh=lOKV1xdNPTEK+lBZEnTVgA7QfbMRGPxv4jKtu4852UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0K+we3VpSOHWZnjgGVqfd/4JbWoHN41nphz8xG9SAfdo/CSfB7bl0/K4QPBvutLjcVZe7DNG3pdyx2pjl9HkDKBwH87o9XiiKS1/PFueVab3+p3/U+7ntKHNinWL/u6UbZ9Qi2gWdg1aUaIJctE53Lexzs6Z1L2PJWj4yHHJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+smrOeR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+smrOeR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8456005a6c4so130557b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424097; x=1783028897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew/TmwldetYc2Px2XW60WZn++KPk6ICws2LlGAgoP9E=;
        b=f+smrOeRKNLGUqJIC+c18bGL0OddXOnxWoSc9bEzFWdMNbDPFQyCZk40NU/PX0D2E9
         NLL7oW2n5nXmSO+4AKqF2cVO+QJHAHFvoF2Mw1zYqKMnQVdhdLemQ94uFQZjBN9avAIk
         Iq9ogjmpjaRBQNPre67U71tKvSpu0sgDWper847Fc+nRPXdN1xReVd7SKBZcpA5Z28bb
         fdJUuR6YoFagEAjL9owIh6cVKq/1L/notSII7bWUpvyu6JcE8Jd9mcruyOQW3DffXfiv
         TNcJlrQEL2UYPfdAmiQcH6QQyWfLFv7yU1T5LokFNSkQFenrw5kaQOdKlARrwsKRp9xX
         FESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424097; x=1783028897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ew/TmwldetYc2Px2XW60WZn++KPk6ICws2LlGAgoP9E=;
        b=WSUYoXmOnah5zc66gCHYHY55WSRA0bMi6GQSUKtw764Hl7uLV/7ooeEzXmnvzXwsWO
         NvJFOR6vb2grnsDmsEoNRTwSTgAR+R84fPd3QnzXwzCZcp0c6Iw95PrZ5KbVfD/gAsx0
         Fx+CX149D2603LpR2BrXzcA2ANGhBYOr3plDsKC5k0MhRxdwfE8FxluSwpquOoo6ljMJ
         Aij8ZhWW5anExn3Ff8KGlOmAa5uMkOAM/id198gafw0ctAfEghSTsdGYM8m8KdZbeqnF
         mJV5eNZZsLulkEc34ZEj1zsGDVA7KFAUn7KqXxsB+0hgc2Bg2B6QGiL2kaYscIOrid+8
         hWlQ==
X-Gm-Message-State: AOJu0YwqtM2rxWQ2Z5utDkBGZFZImi7eJ6E3EwJli4zlNKzr5AWs7iik
	n9gDpEw97+URhxS/E0NWWmcfwVlnaIRbtEAEx+cQo2/ZrPkFuVejDa+rS1DuiA==
X-Gm-Gg: AfdE7cnLR7/WOY23/XWA5qqeImUIP7mSuIYEfZHrp99XbGAqOQ9SdCQmRQcdqwu6ECu
	0I3oJE1QuE5FHW4os3/8avFOpQ6+8MRzdQR6PdzaSFjAJAKBF/P9rWhwhXuIVTJ5HoazH5lzlzi
	gp9mcKtQsU2gvbNCOhXEQaViwYR6GPcr9HttaIJCRP/kb7WzfjHasGv1HqHDMaRh5g9JrwlIWJi
	wfU52x5S0EqoaTZrXuAwXHSZzH0r0I//ypykXk1Qwl5jTEMC5s8AewHNV7fDRFlLY+RkimG06Ff
	06xXEVEOrG+ztdLC7UoNXRBNOFJH8CS5n4V1TdVNaDDJl0ejuxNwnWX+ipLNHWn2Gn1aAJilc5R
	g3LRrn9/3YDut0zxatAk1wBtgpVxAl6cv0HpaZe6QFB0YKfzkZkBAqYkzec6O5KQ=
X-Received: by 2002:a05:6a00:94d6:b0:845:bd8d:704e with SMTP id d2e1a72fcca58-845bd8d7227mr2625431b3a.2.1782424096605;
        Thu, 25 Jun 2026 14:48:16 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c39fsm6192134b3a.55.2026.06.25.14.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:48:15 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 2/3] minix: convert address space operations to iomap
Date: Thu, 25 Jun 2026 14:48:04 -0700
Message-ID: <253660638c14057720cdcafe7d1ca2828457caa1.1782422707.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782422707.git.jbingham@gmail.com>
References: <cover.1782422707.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the regular file address space operations from the buffer_head
API to the iomap API.  The minix_aops struct now uses iomap_dirty_folio,
iomap_invalidate_folio, iomap-based read_folio/readahead, iomap_writepages
with a minix_writeback_ops writeback callback, iomap_bmap, and associated
folio lifecycle helpers (migrate, release, is_partially_uptodate,
error_remove).

Directories continue to use buffer_head-based operations via a new
minix_dir_aops, which retains the old block_read_full_folio readpath,
block_write_begin/write_end, mpage_writepages, and buffer_migrate_folio.
minix_set_inode now assigns minix_dir_aops for directories instead of
minix_aops.

The old minix_writepages and minix_read_folio are preserved as
minix_block_writepages and minix_block_read_folio for directory use.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/inode.c | 83 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index c30cc590698d..cd12e59ce9b9 100644
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
+			error = V1_minix_iomap_begin(wpc->inode, pos, len, 0,
+				&wpc->iomap, NULL);
+		else
+			error = V2_minix_iomap_begin(wpc->inode, pos, len, 0,
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
+	const struct iomap_ops *ops = minix_iomap_ops_ver(file->f_inode);
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
+	const struct iomap_ops *ops = minix_iomap_ops_ver(rac->file->f_inode);
+
+	iomap_bio_readahead(rac, ops);
+}
+
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
 	return __block_write_begin(folio, pos, len, minix_get_block);
@@ -487,19 +540,36 @@ static int minix_write_begin(const struct kiocb *iocb,
 
 static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping,block,minix_get_block);
+	const struct iomap_ops *ops = minix_iomap_ops_ver(mapping->host);
+
+	return iomap_bmap(mapping, block, ops);
 }
 
 static const struct address_space_operations minix_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio	= iomap_dirty_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 	.read_folio = minix_read_folio,
+	.readahead = minix_readahead,
 	.writepages = minix_writepages,
+	.migrate_folio = filemap_migrate_folio,
+	.bmap = minix_bmap,
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
 	.bmap = minix_bmap,
-	.direct_IO = noop_direct_IO
+	.writepages = minix_block_writepages,
 };
 
 static const struct inode_operations minix_symlink_inode_operations = {
@@ -516,7 +586,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &minix_dir_inode_operations;
 		inode->i_fop = &minix_dir_operations;
-		inode->i_mapping->a_ops = &minix_aops;
+		inode->i_mapping->a_ops = &minix_dir_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
 		inode->i_op = &minix_symlink_inode_operations;
 		inode_nohighmem(inode);
@@ -768,4 +838,3 @@ module_init(init_minix_fs)
 module_exit(exit_minix_fs)
 MODULE_DESCRIPTION("Minix file system");
 MODULE_LICENSE("GPL");
-
-- 
2.47.3

