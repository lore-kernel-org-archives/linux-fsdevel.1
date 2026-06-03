Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED223CD8BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500442; cv=none; b=PABrjNKuE45uHf/AJt//PklGzb5d/x31Y1Ei2qXb6LBY/KQcS0jwnuO91Lc7UrcwffvktxOr6dHxfz7hxpdySC8BApMuWkgqXn3OiXqgVvlbc85hPkxvDOOQwQa1ISNXDZyediYOUyHNHgsAmQe42pfqfK6+LWZBdQM+LYwnKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500442; c=relaxed/simple;
	bh=WgFokW2hxL8erPmsgWpMcr/ZLhxC1VCeWGN40iBICLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3l221YM+ChwqXvB9PAZFsiXsSVpAeflbrC9R/Jr63RigIhDw0gVzE5k+RKgKozDwLfU+E/9/lqOeRMcFlQZwBfFogDVz8CUsRlzZxcmh2ZtytaM5wRK8qq3qIeHCspSD8TQtFgJ97BL0Tuiy9az6It7aZWKxAqSHKVoqVoBC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euz1YIFz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euz1YIFz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842848fd613so845427b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780500440; x=1781105240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl216YFiZ512+PmqvdQwO4TlYRKu97scKPP1QrqOY84=;
        b=Euz1YIFzYKnnDrJenanaXCFZD8FVHIM2BbFr9oPJy3wFQWysCFusPQ9iOCxT6l7AsG
         xQLB+q68Hywm610HJaly/CGlt9CSvqHf+kiom00wVtXYt13wtV5Td7ZxnaUD657URzA9
         gO5GNvTd4R3ePoEJEObHfIvWzoQTupRbehykqpCt0FpZEyMurxg4BbYa8PSMQ/YSJABI
         Qlucj5K4b5GqmdlWAVj3d1W4ENGCSWLD4RNk7n7zciTHy1Nj2KKsKSRanBDvoGfmWqtX
         fdFUxpN+YDS7RrqjyVSK7iv6fiHJKs7gy/0xm18ETwTE3nY/UznZRCQ7HGu9cF3DjX/H
         Hv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500440; x=1781105240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zl216YFiZ512+PmqvdQwO4TlYRKu97scKPP1QrqOY84=;
        b=FSdYIAjuSPAQmMq83W+P0+xbGkSAZlpNtwa2pdTjC73VfXoQh9wh0lz5mw87o3XOnn
         HBjWE7KslWJSOiM8t7iJriIHDxuG96tGlS/RczATc8ghAZxVnf1xg5U6DHNXBspBLxk8
         Gpi5GRlgriB8103TtzWfu879TClW4IydEoPtl2zck71Xm6ZovFGCptqir1wTXXdKtctE
         MOiVtGq41whFq4Jms4h5zSss41wtYoIAZ8iFloyxC5RNMZ/gqvVDZuIWOkzIp8gNGHFJ
         GgqUBf6XsUX8kd9pV0UtFUqmwuakczf+DhVxXeSSKyBH7HSkU652/Uf5bo7pDHBUxO27
         maFg==
X-Gm-Message-State: AOJu0YwXZIZY/mig1Vu4V4XhwYXsl0k02XwhCAWQndBRGufH1HLlUiXE
	ZVnEP+AdNNINA7BPT620y0DIVi+BT2l4ldRxr4BZKgtJaQc05269ZNn5
X-Gm-Gg: Acq92OGTDFxIqI2hK4Xi1u5D8Mbw8TMFiFOFKgwwi9rDIX5rGfAv1NvhHzoQRmzgQdC
	DMCtNzbRsx4ctCs/GpXepXk0hyiW5/mB02DXLcQjifQs2E6wk58UzKdMw/cCeKiwDOffyoPImds
	T6qvlXi/e5k2zSGOc86nnlI5rrMohDrA/mHPX66xpdSB+3ldTkooAskyHTAVHHzRy2bB1uqtq25
	P8ZVWNCDiZbM5rscQwFfk/j7/jUsrihpV5XwHYJjKQq7hV+m7WH80Yd58qPJta0pv7RkKEZRpfJ
	a6S5cIXM7kIrRJvpx6jII01MD+0hWGYHgFzm9sxMaSVugFRyn2WCKJ0j5pQwIrf19ZdxQIzdaNP
	XgGXG6ZgHVCfzWiMHYK+i2+ZojaXBgJ1RpZ4FeoqKYrm4lfbq6MUNYgMLQ0Mwm39mk3X2cN2hc0
	UoWZnoOCfPsbukslIq5DvxemdGTbs9NIsfwpdnnMhHO14ksw==
X-Received: by 2002:a05:6a00:1d8d:b0:842:2cda:7aa2 with SMTP id d2e1a72fcca58-84284ed9c20mr3901791b3a.30.1780500439344;
        Wed, 03 Jun 2026 08:27:19 -0700 (PDT)
Received: from gmail.com ([218.106.182.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm4158556b3a.44.2026.06.03.08.27.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 08:27:18 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
Date: Wed,  3 Jun 2026 23:23:25 +0800
Message-ID: <20260603152711.6446-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <61ad2475a5c156f69697d46a0278982878624421.camel@dubeyko.com>
References: <61ad2475a5c156f69697d46a0278982878624421.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 2, 2026 at 2:46 AM <slava@dubeyko.com> wrote:
>
> I don't quite follow what you mean here. If you take a look into the
> hfs_inode_write_fork():
>
> void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
>                           __be32 *log_size, __be32 *phys_size)
> {
>         memcpy(ext, HFS_I(inode)->first_extents,
> sizeof(hfs_extent_rec));
>
>         if (log_size)
>                 *log_size = cpu_to_be32(inode->i_size);
>         if (phys_size)
>                 *phys_size = cpu_to_be32(HFS_I(inode)->alloc_blocks *
>                                          HFS_SB(inode->i_sb)-
> >alloc_blksz);
> }
>
> You can see that it is simply extracting values into buffers and
> nothing more. No mdb_bh->b_data operations are involved.

Thanks, I explained this part poorly.

I agree that hfs_inode_write_fork() itself does not know anything about
mdb_bh. My concern is about the actual buffers passed by
hfs_mdb_commit().

In hfs_mdb_get(), the primary MDB is set up by sb_bread512():

        bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
        ...
        HFS_SB(sb)->mdb_bh = bh;
        HFS_SB(sb)->mdb = mdb;

and sb_bread512() sets the data pointer like this:

        data = (void *)(__bh->b_data + __offset);

So after mount:

        sbi->mdb == sbi->mdb_bh->b_data + __offset

Then in the HFS_FLG_ALT_MDB_DIRTY path we pass MDB fields to
hfs_inode_write_fork():

        hfs_inode_write_fork(sbi->ext_tree->inode, mdb->drXTExtRec,
                             &mdb->drXTFlSize, NULL);
        hfs_inode_write_fork(sbi->cat_tree->inode, mdb->drCTExtRec,
                             &mdb->drCTFlSize, NULL);

In this call site, the ext and log_size arguments point into the primary
MDB buffer. The memcpy() writes drXTExtRec/drCTExtRec, and the
*log_size assignment writes drXTFlSize/drCTFlSize. So the function is
only writing to the buffers passed to it, but these buffers are fields
inside sbi->mdb_bh->b_data.

The race I am worried about is with generic buffer writeback, not with
another hfs_mdb_commit() caller. The new mdb_lock serializes HFS MDB
commits, but generic writeback does not take this filesystem-private
mutex. It synchronizes with buffer users through the buffer_head lock.

One possible interleaving with the shortened mdb_bh lock is:

CPU0: hfs_mdb_commit()                 CPU1: generic buffer writeback
--------------------------------       ------------------------------

mutex_lock(&sbi->mdb_lock)

if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, ...)) {
        lock_buffer(sbi->mdb_bh)
        update primary MDB fields
        unlock_buffer(sbi->mdb_bh)

        mark_buffer_dirty(sbi->mdb_bh)
}

/* about to handle HFS_FLG_ALT_MDB_DIRTY */
<preempted here>
                                       write_dirty_buffer(sbi->mdb_bh)

                                         lock_buffer(sbi->mdb_bh)
                                         test_clear_buffer_dirty(sbi->mdb_bh)

                                         submit_bh()

                                           submit_bh_wbc()

                                             bio_add_folio_nofail(
                                               bio, bh->b_folio,
                                               bh->b_size, bh_offset(bh))

                                             blk_crypto_submit_bio(bio)

                                       /*
                                        * BH_Lock stays held until I/O
                                        * completion unlocks the buffer.
                                        */

<resumed>
if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, ...) && sbi->alt_mdb) {
        hfs_inode_write_fork(..., mdb->drXTExtRec,
                             &mdb->drXTFlSize, NULL)

          memcpy(ext, ...)
                 ^ ext points inside sbi->mdb_bh->b_data

          *log_size = ...
                 ^ log_size points inside sbi->mdb_bh->b_data

        hfs_inode_write_fork(..., mdb->drCTExtRec,
                             &mdb->drCTFlSize, NULL)

          memcpy(ext, ...)
                 ^ ext points inside sbi->mdb_bh->b_data

          *log_size = ...
                 ^ log_size points inside sbi->mdb_bh->b_data
}

At this point CPU1 holds the buffer lock for I/O, but CPU0 does not try
to take that lock before modifying the same buffer contents. The HFS
mutex does not help here because CPU1 does not take it. The result could
be that the submitted write observes a partially updated primary MDB, or
that the dirty bit is cleared before the ALT_MDB_DIRTY updates are made.

This is why I think the mdb_bh lock still needs to cover both the
HFS_FLG_MDB_DIRTY field updates and the HFS_FLG_ALT_MDB_DIRTY
hfs_inode_write_fork() calls. The lock does not need to cover the whole
commit anymore; it only needs to cover direct modifications of the
primary MDB buffer and mark_buffer_dirty(mdb_bh).

>
> I don't know how to review attachments. If you would like to share some
> code for review, then, please, include the diff into the body of email.

Sure. Sorry about the attachment. The draft diffs are included inline
below. They are still for discussion, not a formal v3 submission yet.

The first diff reworks the locking. The second diff handles the
corrupted volume-bitmap layout separately by forcing read-only instead
of rejecting the mount with -EIO, and by checking before consuming dirty
bits in hfs_mdb_commit().

Thanks,
Yue

--- draft diff 1: hfs: serialize MDB commits and narrow mdb_bh locking ---
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..e4ed9071c498 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -124,6 +124,7 @@ struct hfs_sb_info {
 
 	int session, part;
 	struct nls_table *nls_io, *nls_disk;
+	struct mutex mdb_lock;			/* serializes MDB updates */
 	struct mutex bitmap_lock;
 	unsigned long flags;
 	u16 blockoffset;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..991013ae0c33 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -286,60 +286,74 @@ int hfs_mdb_get(struct super_block *sb)
  */
 void hfs_mdb_commit(struct super_block *sb)
 {
-	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
+	struct hfs_sb_info *sbi = HFS_SB(sb);
+	struct hfs_mdb *mdb = sbi->mdb;
+	bool mdb_dirty, alt_dirty, bitmap_dirty;
 
 	if (sb_rdonly(sb))
 		return;
 
-	lock_buffer(HFS_SB(sb)->mdb_bh);
-	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
+	mutex_lock(&sbi->mdb_lock);
+	if (sb_rdonly(sb))
+		goto out;
+
+	mdb_dirty = test_and_clear_bit(HFS_FLG_MDB_DIRTY, &sbi->flags);
+	alt_dirty = test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &sbi->flags) &&
+		    sbi->alt_mdb;
+	bitmap_dirty = test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &sbi->flags);
+
+	if (mdb_dirty || alt_dirty)
+		lock_buffer(sbi->mdb_bh);
+	if (mdb_dirty) {
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
-		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
+		mdb->drFreeBks = cpu_to_be16(sbi->free_ablocks);
 		mdb->drNxtCNID =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
-		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
-		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
+			cpu_to_be32((u32)atomic64_read(&sbi->next_id));
+		mdb->drNmFls = cpu_to_be16(sbi->root_files);
+		mdb->drNmRtDirs = cpu_to_be16(sbi->root_dirs);
 		mdb->drFilCnt =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
+			cpu_to_be32((u32)atomic64_read(&sbi->file_count));
 		mdb->drDirCnt =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
-
-		/* write MDB to disk */
-		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
+			cpu_to_be32((u32)atomic64_read(&sbi->folder_count));
 	}
 
 	/* write the backup MDB, not returning until it is written.
 	 * we only do this when either the catalog or extents overflow
 	 * files grow. */
-	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)->flags) &&
-	    HFS_SB(sb)->alt_mdb) {
-		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
+	if (alt_dirty) {
+		hfs_inode_write_fork(sbi->ext_tree->inode, mdb->drXTExtRec,
 				     &mdb->drXTFlSize, NULL);
-		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
+		hfs_inode_write_fork(sbi->cat_tree->inode, mdb->drCTExtRec,
 				     &mdb->drCTFlSize, NULL);
+	}
+	if (mdb_dirty || alt_dirty) {
+		mark_buffer_dirty(sbi->mdb_bh);
+		unlock_buffer(sbi->mdb_bh);
+	}
 
-		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
-		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb, HFS_SECTOR_SIZE);
-		HFS_SB(sb)->alt_mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
-		HFS_SB(sb)->alt_mdb->drAtrb &= cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
-		unlock_buffer(HFS_SB(sb)->alt_mdb_bh);
+	if (alt_dirty) {
+		lock_buffer(sbi->alt_mdb_bh);
+		memcpy(sbi->alt_mdb, sbi->mdb, HFS_SECTOR_SIZE);
+		sbi->alt_mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
+		sbi->alt_mdb->drAtrb &= cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
+		unlock_buffer(sbi->alt_mdb_bh);
 
-		mark_buffer_dirty(HFS_SB(sb)->alt_mdb_bh);
-		sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
+		mark_buffer_dirty(sbi->alt_mdb_bh);
+		sync_dirty_buffer(sbi->alt_mdb_bh);
 	}
 
-	if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->flags)) {
+	if (bitmap_dirty) {
 		struct buffer_head *bh;
 		sector_t block;
 		char *ptr;
 		int off, size, len;
 
-		block = be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_start;
+		block = be16_to_cpu(sbi->mdb->drVBMSt) + sbi->part_start;
 		off = (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
 		block >>= sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;
-		size = (HFS_SB(sb)->fs_ablocks + 7) / 8;
-		ptr = (u8 *)HFS_SB(sb)->bitmap;
+		size = (sbi->fs_ablocks + 7) / 8;
+		ptr = (u8 *)sbi->bitmap;
 		while (size) {
 			bh = sb_bread(sb, block);
 			if (!bh) {
@@ -360,7 +374,9 @@ void hfs_mdb_commit(struct super_block *sb)
 			size -= len;
 		}
 	}
-	unlock_buffer(HFS_SB(sb)->mdb_bh);
+
+out:
+	mutex_unlock(&sbi->mdb_lock);
 }
 
 void hfs_mdb_close(struct super_block *sb)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..60a93c31b3ff 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -339,6 +339,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;
+	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);

--- draft diff 2: hfs: detect volume bitmap overlap with MDB ---
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e4ed9071c498..df6ed1298151 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -138,6 +138,7 @@ struct hfs_sb_info {
 #define HFS_FLG_BITMAP_DIRTY	0
 #define HFS_FLG_MDB_DIRTY	1
 #define HFS_FLG_ALT_MDB_DIRTY	2
+#define HFS_FLG_VBM_OVERLAP	3
 
 /* bitmap.c */
 extern u32 hfs_vbm_search_free(struct super_block *sb, u32 goal, u32 *num_bits);
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 991013ae0c33..4b6f1df5e4a8 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -85,6 +85,24 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 	return !corrupted;
 }
 
+static bool hfs_vbm_overlaps_mdb(struct super_block *sb)
+{
+	struct hfs_sb_info *sbi = HFS_SB(sb);
+	sector_t mdb_start, vbm_start, vbm_end;
+	u32 vbm_bytes, vbm_sectors;
+
+	vbm_bytes = (sbi->fs_ablocks + 7) / 8;
+	if (!vbm_bytes)
+		return false;
+
+	mdb_start = sbi->part_start + HFS_MDB_BLK;
+	vbm_start = sbi->part_start + be16_to_cpu(sbi->mdb->drVBMSt);
+	vbm_sectors = DIV_ROUND_UP(vbm_bytes, HFS_SECTOR_SIZE);
+	vbm_end = vbm_start + vbm_sectors;
+
+	return vbm_start < mdb_start + 1 && mdb_start < vbm_end;
+}
+
 /*
  * hfs_mdb_get()
  *
@@ -185,6 +203,12 @@ int hfs_mdb_get(struct super_block *sb)
 		sb->s_flags |= SB_RDONLY;
 	}
 
+	if (hfs_vbm_overlaps_mdb(sb)) {
+		pr_warn("volume bitmap overlaps MDB, running fsck.hfs is recommended. Mounting read-only.\n");
+		set_bit(HFS_FLG_VBM_OVERLAP, &HFS_SB(sb)->flags);
+		sb->s_flags |= SB_RDONLY;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
@@ -296,6 +320,13 @@ void hfs_mdb_commit(struct super_block *sb)
 	mutex_lock(&sbi->mdb_lock);
 	if (sb_rdonly(sb))
 		goto out;
+	if (test_bit(HFS_FLG_VBM_OVERLAP, &sbi->flags) ||
+	    hfs_vbm_overlaps_mdb(sb)) {
+		pr_err("volume bitmap overlaps MDB, forcing read-only\n");
+		set_bit(HFS_FLG_VBM_OVERLAP, &sbi->flags);
+		sb->s_flags |= SB_RDONLY;
+		goto out;
+	}
 
 	mdb_dirty = test_and_clear_bit(HFS_FLG_MDB_DIRTY, &sbi->flags);
 	alt_dirty = test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &sbi->flags) &&
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 60a93c31b3ff..81de9607ab24 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -133,6 +133,10 @@ static int hfs_reconfigure(struct fs_context *fc)
 			pr_warn("filesystem is marked locked, leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
+		} else if (test_bit(HFS_FLG_VBM_OVERLAP, &HFS_SB(sb)->flags)) {
+			pr_warn("volume bitmap overlaps MDB, running fsck.hfs is recommended.  leaving read-only.\n");
+			sb->s_flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
 		}
 	}
 	return 0;
