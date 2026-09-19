Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C453955E3
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856760; cv=none; b=inQJqv6/KS/HvOxNJyakAJbbdzIClcBhclUwDR/S8xTinK93Jb92wDs6I9mdBUi4Qm74LCb0gMAD2SVxjiOyOpyRxSQsKw2i8r0Rgl1cPIlRh2N1En0Fgsfpto+XV4AV1QvfZpAO5CshHjbOuPV8allQmBt9Jh5awLTRhFxZ8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856760; c=relaxed/simple;
	bh=xNQwH62g/JqmUeU/ubF+uzPeD2Dq1WT1mt5tcvgWD3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dcQt/Fgv8KjCh5dDKSZQfaz5oBkcmOGsbzRrIYRnGjKcjpkFZ2wvtPfAzTL0nH3Pms4uukzy2YsWpBYpbV32Z0x7+QrDGtTgw1vDHcd4TU0Q6t85x+YJmiMTSBLZHlmQVHxNE8/P7f9XmUjWx4KM4K5LL6XEI2M7g8gTXYZkfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtc1kIvD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtc1kIvD"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0135fso17996135ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856758; x=1790461558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/MNqjqxirQpmsC9DWQIwWbU2XOq2TVyvQ9irLpQkP0=;
        b=rtc1kIvDi5yN3JbpdmA+ZEqyf9ZXOh0CseaTtarRv+nY+rOn/x0Rk5Puk1j3U3kAZo
         JeRzINJj05UgNQlsAGjgHMzDS1ZH0SEHuFhsNizxE906/nDIjsSo8fdof2GQN7xxcuQz
         kNVM0xdYy5xOLyEp3yG1zaUbLmF9hRQV+7p+6qbyc+FfRRpk9LXZ8Rhz/EbleqNaDRJC
         o9WCeTk1aCU4Tylky+xSmkDhBfqKY2ACzbEXt30sw6J0d2UKi+ThtsMlINr7MLcs8poA
         QgF1xCB/XY6jkkDB7vt8kNfUniq/kuN2kLOTZrgZvVU7GdStZnMnb1viWLP2CK1Q6ST1
         z6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856758; x=1790461558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/MNqjqxirQpmsC9DWQIwWbU2XOq2TVyvQ9irLpQkP0=;
        b=HoL2TdX7P3BTdHkSoliCgotcXJ2J1iBuZoZDbZtOyKM3i6Ap52auX8aKLbZ3sybAUl
         8/RkcfQIyf7ZtzyDmd54yrp8dGFPCOfPETMaIT3Qv4836JM4X3nyxBe3lVboBxpDI93V
         8yVU0PbcBOE77mblD/F6e6o4+jC3LcMYhpv+X4tSy8bLHiq06mkVoosqidoLnz8Dp47F
         UP2FsCjBicEVk7VtEpJ0htpqdLsse7WOqQ4BQkzsGNO9mna5jAQcJSX/kcRsUhvky4Kj
         JIYbVDUiX1X3L85+hJ6pWhH/18YjZyqpxPpHD38gn0SW69vz0MHHrH+3KIQW8hjqTUPb
         7FQA==
X-Gm-Message-State: AFuF++nwLqGRoBBDjdEqT7qjuW9mSe1EV8fQjGfq9VBekuJVxPk+zaYT
	v77CjYvbpSuEJgGmbwXR1HFFWyV73Aaus0tKMx/MAm2BBbyEHf53xgjj
X-Gm-Gg: AYBFou0wtfQWZkM0QGq//UXgJTx+dxATTLic8a23xdDFMyBwbiKX5iPsLGr+q6xBHm6
	klICdoJK5CBYxe73XEEgv30wnfOqUVwQ0iS7/Z4qEJQDwjGcBqWDtB5wiDkCMz4SeD+FlHhAJI9
	fo2lTX1VtCWLNn1fdMs+4ziHPFe61TIrUzWtSEBEcFFUb0VLRCeBOqG+CDVlxzdao7w0tL3+z1T
	fGjf/Awop3W/EFK/owFNtnYHFMcKmVqckzRAjuDgeGAFwRoAFBxxqXNBw6d1OCxmWvvQUKHgxn7
	JJtNcN4JXe0LHqFrzOmtUASNL02b1UBT+Hs/MCno9ZD80w4FW6+Y6ESStgRD2HGd/dlV2tsgEq+
	sfnxRgrV79gxWT7oyoXG/p84GrfMeZYuyoY2aRxAAF1u5xnbE45z+mNLZmQOw9PO7eLaatwvM3Z
	gFebhu1qsJP+hIuPrFjiVq+bL7FBJywtu8r6uiAgqOYNPE4rxL0CAZVkt2SsPl6ltrQJCp+/CkF
	aCt1qx6tl8eIXvwBw9rF1iXWjQLlQKVCVY6sZ9/oxc4GZ3bYHkEKter3lhZoIpg307WKk12KBr/
	3qHT8AH5tw==
X-Received: by 2002:a17:903:324f:b0:2dd:c053:9c6c with SMTP id d9443c01a7336-2ddc0539d9cmr52572835ad.34.1789856757711;
        Sat, 19 Sep 2026 15:25:57 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17888f2sm13411685ad.20.2026.09.19.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:25:57 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	jack@suse.cz,
	dlemoal@kernel.org,
	jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] qnx6: validate di_filelevels in qnx6_iget() and fix mount error handling
Date: Sat, 19 Sep 2026 22:25:56 +0000
Message-ID: <20260919222556.3792829-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in fs/qnx6/:

1. In qnx6_iget(), reject raw_inode->di_filelevels > QNX6_PTR_MAX_LEVELS
   so computing the maximum block count does not trigger shift-out-of-
   bounds undefined behavior or out-of-bounds block pointer array walks.
2. In qnx6_fill_super() and qnx6_mmi_fill_super(), prevent MS_SILENT
   from bypassing superblock magic validation and ensure sbi->sb_buf is
   released exactly once on failure.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 6de49333acad..04214b829e10 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -144,8 +144,10 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 		levelptr = (no >> bitdelta) & mask;
 		ptr = ((__fs32 *)bh->b_data)[levelptr];
 
-		if (!qnx6_check_blockptr(ptr))
+		if (!qnx6_check_blockptr(ptr)) {
+			brelse(bh);
 			return 0;
+		}
 
 		block = qnx6_get_devblock(s, ptr);
 		brelse(bh);
@@ -397,12 +399,14 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 		sbi->sb_buf = bh1;
 		sbi->sb = (struct qnx6_super_block *)bh1->b_data;
 		brelse(bh2);
+		bh2 = NULL;
 		pr_info("superblock #1 active\n");
 	} else {
 		/* superblock #2 active */
 		sbi->sb_buf = bh2;
 		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
 		brelse(bh1);
+		bh1 = NULL;
 		pr_info("superblock #2 active\n");
 	}
 mmi_success:
@@ -463,6 +467,8 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 out1:
 	iput(sbi->inodes);
 out:
+	if (sbi->sb_buf && sbi->sb_buf != bh1 && sbi->sb_buf != bh2)
+		brelse(sbi->sb_buf);
 	brelse(bh1);
 	brelse(bh2);
 outnobh:
@@ -560,6 +566,13 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	memcpy(&ei->di_block_ptr, &raw_inode->di_block_ptr,
 				sizeof(raw_inode->di_block_ptr));
 	ei->di_filelevels = raw_inode->di_filelevels;
+	if (ei->di_filelevels > QNX6_PTR_MAX_LEVELS) {
+		pr_err("invalid filelevels (%u) in inode %u\n",
+		       ei->di_filelevels, ino);
+		folio_release_kmap(folio, raw_inode);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_fop = &generic_ro_fops;
diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index b8afb6f388b2..28cb9322278e 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -51,10 +51,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 	sbi = QNX6_SB(s);
 	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
-		if (!silent) {
+		if (!silent)
 			pr_err("wrong signature (magic) in superblock #1.\n");
-			goto out;
-		}
+		goto out;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
@@ -64,15 +63,16 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
-	/* calculate second superblock blocknumber */
-	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
-					fs32_to_cpu(sbi, sb1->sb_blocksize);
-
 	/* set new blocksize */
 	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
 		pr_err("unable to set blocksize\n");
 		goto out;
 	}
+
+	/* calculate second superblock blocknumber */
+	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
+					fs32_to_cpu(sbi, sb1->sb_blocksize);
+
 	/* blocksize invalidates bh - pull it back in */
 	brelse(bh1);
 	bh1 = sb_bread(s, 0);
