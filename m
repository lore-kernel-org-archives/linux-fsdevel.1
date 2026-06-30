Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18E47B420
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853171; cv=none; b=aSujXUR0N+6C8YxfId1ZC8dlASQgTdgAQOe0wSgOH8IZRvRUdqkqGhOQjlS5ULslX+EqbbIhC9eVNIw73yos79Yf48xyz7H2GS64IsHqd/J2JAQR+bnYL1PbF1Djuaxw8erdWIAdoFRxptOO9mHupIyef1m491g9qniT9h4m8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853171; c=relaxed/simple;
	bh=7nWDFp++odGju4EQD247gPaFq+1N0ocPJ/Yr1tUzCE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFTgZ2URiEOkFaGOPe0QcXMVGZVjfybM/+ZvNvpgwZBCRE0k50F91AodRg5PzaU6+KPqgfUk7j1SaALCJdxReHLBFqHZgaNS/OD5jKOagrUY/3R7kgSneSYifS6B7tVXLeBU1CriPLBtU1Vpd+wJKL+egfDvmqucRNT1MEhHPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+us4pzz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+us4pzz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ba701891so8076235e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853168; x=1783457968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7uWj5buZ7MVbleckY0RL8j/yUJ1pj8LCM17PMcJDxA=;
        b=l+us4pzzq0sU2wEGynDHy42q4eFwUFucNJ/8QXD2fwEUlq7t8SotNIIy5lahN3KKDW
         z+9ulY8xphwCGaqr8b42J8HrJpxs2ih+YRH3bTfhhQf5ih6LIKtK9T5qmCmNoW2rIyAN
         mfy6PwU0/f6oaNtqZvQfpuUW92y0YPujwJ1kxi1An0wOW0zp4ZE8LbxmUq5VkbjVTBUC
         aYySXs/h3ThUDrfvb0QoXTyfld/89Ad7I4lk1TGyTDX8OSEoU+7FjfvX2SJ4JM8RXlsn
         10/EVIfj5PECXSVRj3FobFj9ZZHtf7FttKJZXaDLpaFj/rA6+C6pX+TxTFQr1tftj+9M
         qHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853168; x=1783457968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7uWj5buZ7MVbleckY0RL8j/yUJ1pj8LCM17PMcJDxA=;
        b=ILIvQmpjx3OELls8IPSAywoVGmyy3JwnTakPGNGZoXXjRZD3oMd/k3+cjGH/bUILbw
         LLF5oLqCXQcWQrMSQlVeG5HJP5yeyBOCiWiMCYrrO6kTWNVQ6s5rulcwbDqnC/wWsjp6
         4XTw0CbDp4kOlF3niEpHxGEUjHwhSug1he9yL4xupGPrG+OMV7oVyFLe59SQLf2srNyb
         mP1ibfyKQaAWKupCDrCbQT7NnhxTrjWvHLE8nU1YXuIgteDOOpXqtt1k126tIohntwZG
         rMHBfb9XnxkcKOH0fXErAulLRdFXHggzv/IHLf4TroV06Tj4bwUHbVj8LfNTxU0pEL58
         iX0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8qfvyL/pYyh9pCA8wcbttCUf3No4U7tbpF+3TJCafiN2ivxXC0ExiBedVbYoqRAKD+TgkZ/4RYON1c4bSX@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOmKUY0mA/BXH9TkSeqHB/yg5G6i0VBCnU+0nBsEBftqG2AJZ
	8idPfpVw1MW4TW72I3/Lt6/qP0blid9kxL2FJy7h5JbbYQHI0fikTxil
X-Gm-Gg: AfdE7clbDl7t75PPIAy1nFAkGtsxaTdoLPjXMIVYNrdeVsM/iBxdTDbW4zpVPZRnOZA
	R9tVPx/Ax8wS/D40iKuZabI6Zhy6wIeWVfZul9rzfKOo+1T8ReI2AHVPVV2hUrtd48TqkkaI8eQ
	QjhOR1Z+KLViL9uZP3ou26JCGtqWhYER1jZZAzmuqsaR5JxLgbSOuJdQnPng9R8glzgTmt+XplY
	j8VdyiBQgLvxTzL9Ep0CUV7FsBhoC4see8hUvTeTWHQB3JcBqHQWE2K9gan1+L/SIWbxrINSETu
	x+HzJzBm1709MRPhagWruotLkCIz48SjQH6PMFSZjeWHrBExL0PhIigLcLw4//U6o2wbZUcdgig
	3oHA0SSTEK3/jA+hWhmYU88DdmCyruk5fHFGpsBmdgJRcYeXN+gfzw4Zwz8OZJqy83AZobOgB4+
	Tm3JlZRXNlDy9LI/eE4eWCA7eCUoDBYyxbq/aD9/3i+JrpGKWk2U6KGurr+wK2V4oDY7V9Su6lu
	55VC3iCRar/wA98A8F/UwSESjSPgIQJJVFNAF/TbDTcJFM3OvzHaOavIT8XRH5F0BGEsTBMCi0=
X-Received: by 2002:a05:600c:4585:b0:493:a96b:fa0b with SMTP id 5b1f17b1804b1-493b82ae872mr72441315e9.24.1782853168134;
        Tue, 30 Jun 2026 13:59:28 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfdd5sm37500745e9.1.2026.06.30.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:59:27 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	David <davemadmaxxx@gmail.com>
Subject: [PATCH/RFC] hfs: validate catalog CNIDs before writeback
Date: Tue, 30 Jun 2026 20:59:24 +0000
Message-ID: <20260630205924.896357-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Thank you again for the previous review.

I reworked the HFS patch following your feedback. This version
uses a focused CNID validator for catalog records.

The patch now:

- adds hfs_is_valid_cnid();
- validates file and directory CNIDs in hfs_read_inode();
- marks invalid catalog records as bad inodes;
- rejects a bad root inode in hfs_fill_super();
- validates the found catalog record in hfs_cat_find_brec();
- keeps BUG() in hfs_write_inode() for internal impossible state.

Local validation:

- git diff --check: pass
- reverse apply check: pass
- checkpatch strict: 0 errors
- make fs/hfs/: pass
- make bzImage: pass
- QEMU HFS repro: started and completed
- no kernel BUG, Oops, panic, KASAN, UBSAN, or GPF observed

The goal is to treat corrupted on-disk catalog metadata as
filesystem corruption, without crashing the kernel.

Please let me know whether this matches the expected direction.

Thanks,
David

---
diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 632c226a3..87aa45db4 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -184,6 +184,31 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 
 /* Try to get a catalog entry for given catalog id */
 // move to read_super???
+static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd)
+{
+	hfs_cat_rec rec;
+	int err;
+
+	err = hfs_brec_read(fd, &rec, sizeof(rec));
+	if (err)
+		return err;
+
+	switch (rec.type) {
+	case HFS_CDR_FIL:
+		if (!hfs_is_valid_cnid(be32_to_cpu(rec.file.FlNum), HFS_CDR_FIL))
+			return -EFSCORRUPTED;
+		break;
+	case HFS_CDR_DIR:
+		if (!hfs_is_valid_cnid(be32_to_cpu(rec.dir.DirID), HFS_CDR_DIR))
+			return -EFSCORRUPTED;
+		break;
+	default:
+		return -EFSCORRUPTED;
+	}
+
+	return 0;
+}
+
 int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
 		      struct hfs_find_data *fd)
 {
@@ -208,7 +233,11 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
 		return -EIO;
 	}
 	memcpy(fd->search_key->cat.CName.name, rec.thread.CName.name, len);
-	return hfs_brec_find(fd);
+	err = hfs_brec_find(fd);
+	if (err)
+		return err;
+
+	return hfs_cat_validate_found_cnid(fd);
 }
 
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 49d02524e..d0eb10c4b 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -186,6 +186,30 @@ extern void hfs_cat_build_key(struct super_block *, btree_key *, u32, const stru
 
 /* dir.c */
 extern const struct file_operations hfs_dir_operations;
+
+/*
+ * Validate the CNID of a catalog record.
+ */
+static inline bool hfs_is_valid_cnid(u32 cnid, u8 type)
+{
+	if (likely(cnid >= HFS_FIRSTUSER_CNID))
+		return true;
+
+	switch (cnid) {
+	case HFS_ROOT_CNID:
+		return type == HFS_CDR_DIR;
+	case HFS_EXT_CNID:
+	case HFS_CAT_CNID:
+		return type == HFS_CDR_FIL;
+	case HFS_POR_CNID:
+	case HFS_BAD_CNID:
+	case HFS_EXCH_CNID:
+		return false;
+	default:
+		return false;
+	}
+}
+
 extern const struct inode_operations hfs_dir_inode_operations;
 
 /* extent.c */
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 61ed76d10..90d676dc9 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -344,6 +344,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (!hfs_is_valid_cnid(be32_to_cpu(rec->file.FlNum), HFS_CDR_FIL)) {
+			pr_warn_ratelimited("hfs: invalid file CNID %u; run fsck\n",
+					    be32_to_cpu(rec->file.FlNum));
+			goto bad_inode;
+		}
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -365,6 +370,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (!hfs_is_valid_cnid(be32_to_cpu(rec->dir.DirID), HFS_CDR_DIR)) {
+			pr_warn_ratelimited("hfs: invalid directory CNID %u; run fsck\n",
+					    be32_to_cpu(rec->dir.DirID));
+			goto bad_inode;
+		}
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
@@ -375,9 +385,15 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_fop = &hfs_dir_operations;
 		break;
 	default:
-		make_bad_inode(inode);
+		pr_warn_ratelimited("hfs: invalid catalog record type %u; run fsck\n",
+				    rec->type);
+		goto bad_inode;
 	}
 	return 0;
+
+bad_inode:
+	make_bad_inode(inode);
+	return 0;
 }
 
 /*
@@ -435,20 +451,20 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (res)
 		return res;
 
-	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
-		switch (inode->i_ino) {
-		case HFS_ROOT_CNID:
-			break;
-		case HFS_EXT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
-			return 0;
-		case HFS_CAT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
-			return 0;
-		default:
-			BUG();
-			return -EIO;
-		}
+	if (!hfs_is_valid_cnid(inode->i_ino,
+			       S_ISDIR(inode->i_mode) ? HFS_CDR_DIR :
+			       HFS_CDR_FIL))
+		BUG();
+
+	switch (inode->i_ino) {
+	case HFS_EXT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
+		return 0;
+	case HFS_CAT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
+		return 0;
+	default:
+		break;
 	}
 
 	if (HFS_IS_RSRC(inode))
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 53800105e..9428cd7fe 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -432,7 +432,7 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	res = -EINVAL;
 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
-	if (!root_inode)
+	if (!root_inode || is_bad_inode(root_inode))
 		goto bail_no_root;
 
 	sb->s_d_op = &hfs_dentry_operations;
