Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8A318B9C
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782623779; cv=none; b=dLjtaR0oB5QtH6U3OTYZNNs9fVx1GEa3wAGOeyUl1z34BR+nLJKnxJrFTrUX66CKgqjcoH8zMYr2Brn5a+tOmCKFTkBZaJNU2ovo7XjJJwybvHiKGuOXDgfKqZb71DiEUME4Md4CKxrGkcGPloJTtR69FpeOAdPVm6Yws0yc0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782623779; c=relaxed/simple;
	bh=CDB1YAuEU/AWEbt0bgTzVLcDx4GZouzNp8kS3O/TJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6edIIiu4PyrpvicKjkcoKIQ/QgkXIW/GJZyPJqFdb/Sue7fmqtXvbyXzWJjcz+HnFDsjV5RcQG45AywMfMHPRIATdgQzlnZVBKN1DgkNO8rMuKqHF3V3bkMqPi6hktweXQkDiLxCYfLKyt7iWMOH/M6vFtFBW2uiahu3tZHpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFQf9CC0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFQf9CC0"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96cb024ee0so137159a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 22:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782623775; x=1783228575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWJjfTOBpBEV2X+WNtet2gIZCD/awlQi0piqg/96Rk8=;
        b=XFQf9CC0OtwxJ8wrW8ty2PKwk/Ifs5tjsdYSHqaqIAC8Da0hTa4KqQejqhMVIL+Y2Z
         TRMFG6TTkuf7p7LYVqB5hurP2kEjaFN8PTnN2uLqBh8Bfst3pncAfIKjqPRCjAR/DRId
         UiKSNazkHULqy9Mr/WigtLlA/AzwOqV2AAv5EBOfV/xt3w3io+vjgBxeIc9R4oR8nlcb
         srzZwXzUkfqPMTbradjc7dkzz0AsOQyqv03gCReH2iLVZrF/2cnVr5nWzwzPiEH6qoBn
         cNrNDXhVqyFnMD+xRaiYhi/XXwkcgq85SP62EQEFbzOQMJqLn1YH2pwsiMII6Z3AYJ/C
         2LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782623775; x=1783228575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWJjfTOBpBEV2X+WNtet2gIZCD/awlQi0piqg/96Rk8=;
        b=awL3qJG+fpZ/9k4ku6Cbd6GtmZg+bP783Io2fjIHMRJ72l2i/d+aVu6hPKv+KhWW5h
         efBlvMDvpMnKAaftUShtdyOCxw+D5Fv8EWW28xLBew8EAUdeqCKhAb6xtK9TmXJhva6d
         9pIsj32TjrzS4fm+PcyQH98DZj3Y3HSsjdJ1ZCKTNP0tnJ3zMtowsywWZowKrH1lkMvf
         WtzZJp07FM9/eEsr+1JpkgAtC/pPeJYHcUSVbEvbXLdYdnNZknjy8Lqie5o17hsxo0fr
         AGbOH1QIEOu2w92BFlTHjQ/TWymE6eOCzYyYmGgkrUwNwxp4Ikx1Inm4WTgw5eudmMcb
         YgbA==
X-Gm-Message-State: AOJu0YxHbngAvtZmVmDjJvLTsbXsR4sdThXVkKAwMDcbJPIclu1VSzUX
	hx2iKs6LSI5FAKnC4vxhw1eXd4dqC4BvF/4TlOOSJkWi4oWof443G23udi12Ko7X
X-Gm-Gg: AfdE7cl05nW3J3achOsLpEHP6iFA/k19nHsZQF9bDQlAmY55zM/stSHvskEAtgseUj7
	OCh5V7YCHrYMqE1BSZVhS1PpDX2TMvlA220lRgo6nqkBNB+5wqAdAIwpUwFdfw7hTRZbhl3kcs9
	m6wN2+PdpZLQ3ovVJ8RVwwNerKWvU6NJorcDpFBU8KXFug30mmv7hC3mmZ5cBttJZfh9AVoTaSU
	6rCO76kzviTloBaATxpmxoMYnphy7z8ADAPMlhJj+nFFZjtsyShMVPcc9ekB8J82mF7ctzcMIff
	T/nrPxDGrxdjfOl1E67q6TA4o9SPy7iSWKk0ZYknjsyBWbHJA0rzIBMkgj5q93M/g68TV0v0Hzx
	PIvK8MlgSEI5sFMuKwxbSPZUFSZB1yXDuhfArzUhNG3FCZtGqHoGPD5/xhNJIMYU=
X-Received: by 2002:a05:6a21:7991:b0:3bf:6f15:6d08 with SMTP id adf61e73a8af0-3bf6f156fabmr4316959637.30.1782623775154;
        Sat, 27 Jun 2026 22:16:15 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm5793263a12.9.2026.06.27.22.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:16:14 -0700 (PDT)
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
Subject: [PATCH v2 2/4] minix: convert address space operations to iomap
Date: Sat, 27 Jun 2026 22:15:54 -0700
Message-ID: <7060fde4f164617c58eeac616a40e5bd89b921d2.1782619718.git.jbingham@gmail.com>
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

Convert minix regular file and symlink address space operations from
buffer_head to iomap. The new minix_aops uses iomap_dirty_folio,
iomap_invalidate_folio, iomap_bio_read_folio, iomap_bio_readahead,
iomap_writepages, iomap_bmap, and related iomap helpers.
The write_begin/write_end callbacks are removed since buffered writes
now go through iomap_file_buffered_write in file.c.

Directories keep using buffer_heads via a new minix_dir_aops, which
retains the old block_dirty_folio, block_read_full_folio,
block_write_begin, generic_write_end, and mpage_writepages. This is
necessary because directory entry manipulation (minix_prepare_chunk,
minix_write_begin) still uses the buffer_head chunk protocol.

minix_bmap is converted from generic_block_bmap to iomap_bmap.

The minix_get_block function is exported (non-static) so the
directory aops can still use it for block_write_begin and
mpage_writepages.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/inode.c | 86 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index c30cc590698d..2ba6766fce51 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -436,7 +436,32 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static int minix_get_block(struct inode *inode, sector_t block,
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
+int minix_get_block(struct inode *inode, sector_t block,
 		    struct buffer_head *bh_result, int create)
 {
 	if (INODE_VERSION(inode) == MINIX_V1)
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
@@ -487,19 +540,36 @@ static int minix_write_begin(const struct kiocb *iocb,
 
 static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping,block,minix_get_block);
+	const struct iomap_ops *ops = minix_iomap_ops_ver(mapping->host);
+
+	return iomap_bmap(mapping, block, ops);
 }
 
-static const struct address_space_operations minix_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+const struct address_space_operations minix_aops = {
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
-- 
2.47.3

