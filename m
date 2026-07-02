Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348C353A66
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017501; cv=none; b=mPQsUCyTCisZ0Mi224lSUZfUFf8wzdYQpjuxBECNiXHESI2+ODkgsWjYyB2xHFXn1XPdPkDWOD9T+AdY37nnRH5vAbPtvtPKvm9C4ghZtVALFbe6xQ0MDhQFMavublXG1EIE7jzsziOW5aIEMDUXM1thTe/0KqW/S3B3FrUQCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017501; c=relaxed/simple;
	bh=pkDT55GlUcqyPIHBBVxClAyIF+qymIflZ290LHGCWws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhONZniYykiqBrmo14/IULCd5kbQFzXHPdAKcVmGxi19Iq9CIg/r9+zSrqewlG9KlbPfmMRrzLGIonnXIFzgNoNiIeTN6pmqo3u6eHQAkDULcdcldxT32bi+z0WH0r49es2kxvii6yv8Yp//4K3hUS+kpq/zxTUNzw1BwEJqOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMpf1hMm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMpf1hMm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493be1b9682so16009545e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783017498; x=1783622298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XitSBQ4uFF4GuKPO+2f3/tjxjU6DpM7EbQl+SeeTcZU=;
        b=RMpf1hMmeaAeTlWseW9bfU2rRmNcnJvk/3E1tXSuhG9Tv52YxmSzHDEl63G6iIorAz
         dzlJ64z9Fh+7EH7M6jQ+GQx9z4B4+59dCUDg8QtdUPzLqB99+zJGB5XiEE2ei0BMso9m
         3XAolCT9OlWCAnNsCaD6Y9g+Y1MuAFw5nWd51Av+k9X6H+7ZIu4vNjQejE2pizwDWigW
         H5A2Uvqv0BdQFP++qADb65eznfouZ/KhwpTR7n1Cv818Hapyh2YWrBSEJwmR+WWEl5rf
         38hZtYtyNuo1KNgoJy0PMwLV33ctttnImijjZOY2mZ4TTf810+/mgkHHjQSoJ66+GR0w
         nLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783017498; x=1783622298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XitSBQ4uFF4GuKPO+2f3/tjxjU6DpM7EbQl+SeeTcZU=;
        b=JzduE7d35hvIQHgNatOaPnXNH0uJC9w8oLz1bxUSXDi6NoTeg7+Tax8nrC7i8JG48Y
         /pdqg6HxoN+a1akGiTu1iOdO4z616j7il7NeV4TDfxn4VJeB7PXdCwsduTA5nvQAKyxn
         aSXGgHroacazIY/aeyo97GeNC9C2ZpCZMylvM1DoZFNz5F7Mg3ejpS6Akplk4HZVy0GU
         gYWlEROPe+4uoF6iCTYat2UlXVNur1Nh3CgVyQg/wJmlc2eZtoHL9Ag17TQr8Yucdyrz
         faJp/kbwNinB78EG7s6GNFtlKjPFcTcv+XDKBUja72C31xUHcBF0Fe06YbuM1SXHdb2t
         1GYg==
X-Forwarded-Encrypted: i=1; AFNElJ+8+X4EjY2j58bb0Pr8kxo9LPZn+uOxcCAXRMxI8aanX25nHbHFHk6u63UakBDjYAtk+msvGzcoW1mUh1SS@vger.kernel.org
X-Gm-Message-State: AOJu0YxZETa7iYpf/gaGDi+IOzKPnR4aEuXlUKKJwjx5eoqI3F1cxQfW
	fT8gZSkwabOMiV7ukfCz/gOFjFB2p49Q9CF0+TbGIzcbUNoepMZnFQDE7h0C6sY1nYo=
X-Gm-Gg: AfdE7ckpvXm11kgS6Zmpathih1ZxRye8Xu6Rhae2EMBDHgpUtHvkTNOSntglTiFhcxV
	Awv6l6KwEKYKIZnnE9aOZvQudzjJyXZQiw0455Cc4sj2vid5aVITx5EOk7CC8fhVw92M9c0VaON
	U+qJnHxN0P4ke8/2uxGytb1rhRpReHH7oZor0/IYIyP4Z17iEqJG67TWKZU1fLiVMUNSNeDzCHz
	gT92t7XBBfEra2uwd4jHLakwFKlU96LIzCV9EGdzwKxcqoHzP4bXcAxdoGYwinQK/ePvCNO99hT
	CT/Obhr1y6aH+xVIpQesKAfkNambNGOQ1wbuHbimf6dLzrT/QO5sHG3HK65YStZ7uEldhswVrNR
	vNEyjGZrdNls6Ti5tTuW3BUjvHi++rjCgPzPJyUmsWB1IVadRM6A4epMVRuvmDQhYO7vqT5cqQg
	ucVZElVR3EiuvSuUqMJyzoXMbasHCwXup/tbAjeAoBNa79gFje42BeS6ymMEGNUAdEtvReK9WeE
	nJSEHVlBXjP9OQGOLCmwROQZ3vLhQQ6K3ATdre9autKdh/QDEctayiIiw/Gh6yQ9xOLqBKHEyw=
X-Received: by 2002:a05:600c:310f:b0:493:b6e2:1b10 with SMTP id 5b1f17b1804b1-493c2ba0bc7mr98308805e9.31.1783017497607;
        Thu, 02 Jul 2026 11:38:17 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6364770sm100764395e9.6.2026.07.02.11.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:38:17 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: [PATCH] hfs: validate catalog CNIDs before instantiating inodes
Date: Thu,  2 Jul 2026 18:38:00 +0000
Message-ID: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_cat_find_brec() first resolves a catalog thread record by CNID and
then looks up the corresponding catalog record by parent/name. On a
corrupted filesystem image, the second lookup may find a record whose
CNID does not match the CNID that was requested.

Validate the catalog record found by the second lookup before returning
it to callers. Inspect the already-found record with hfs_bnode_read(),
not hfs_brec_read(), and reject records whose CNID is invalid for their
record type or does not match the requested CNID.

Also validate CNIDs in hfs_read_inode() before the inode is populated,
and propagate hfs_read_inode() errors from the resource-fork lookup path.
For the root inode path, require the root catalog record to be a directory
with DirID == HFS_ROOT_CNID, and drop the root inode reference if it was
instantiated as a bad inode.

This keeps hfs_write_inode() unchanged and prevents corrupted catalog
records from reaching the existing reserved-CNID BUG() path during
writeback.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Cc: George Anthony Vernon <contact@gvernon.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
---
 fs/hfs/catalog.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/hfs/hfs_fs.h  | 19 +++++++++++++++++++
 fs/hfs/inode.c   |  9 ++++++++-
 fs/hfs/super.c   |  8 +++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 1bfa36d71e24..fa2a0a5975e3 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -182,6 +182,47 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 			  key2->cat.CName.name, key2->cat.CName.len);
 }
 
+static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd, u32 cnid)
+{
+	hfs_cat_rec rec;
+	u32 found_cnid;
+	unsigned int rec_len;
+	size_t cnid_off;
+
+	if (fd->entrylength <= 0)
+		return -EIO;
+
+	if ((unsigned int)fd->entrylength > sizeof(rec))
+		rec_len = sizeof(rec);
+	else
+		rec_len = fd->entrylength;
+
+	memset(&rec, 0, sizeof(rec));
+	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
+
+	switch (rec.type) {
+	case HFS_CDR_FIL:
+		cnid_off = offsetof(struct hfs_cat_file, FlNum);
+		if ((size_t)rec_len < cnid_off + sizeof(rec.file.FlNum))
+			return -EIO;
+		found_cnid = be32_to_cpu(rec.file.FlNum);
+		break;
+	case HFS_CDR_DIR:
+		cnid_off = offsetof(struct hfs_cat_dir, DirID);
+		if ((size_t)rec_len < cnid_off + sizeof(rec.dir.DirID))
+			return -EIO;
+		found_cnid = be32_to_cpu(rec.dir.DirID);
+		break;
+	default:
+		return -EIO;
+	}
+
+	if (!hfs_is_valid_cnid(found_cnid, rec.type) || found_cnid != cnid)
+		return -EIO;
+
+	return 0;
+}
+
 /* Try to get a catalog entry for given catalog id */
 // move to read_super???
 int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
@@ -208,7 +249,12 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
 		return -EIO;
 	}
 	memcpy(fd->search_key->cat.CName.name, rec.thread.CName.name, len);
-	return hfs_brec_find(fd);
+
+	res = hfs_brec_find(fd);
+	if (res)
+		return res;
+
+	return hfs_cat_validate_found_cnid(fd, cnid);
 }
 
 static inline
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index f3624514fcb0..670638f17438 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -155,6 +155,25 @@ extern int hfs_cat_move(u32 cnid, struct inode *src_dir,
 extern void hfs_cat_build_key(struct super_block *sb, btree_key *key,
 			      u32 parent, const struct qstr *name);
 
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
+	default:
+		return false;
+	}
+}
+
 /* dir.c */
 extern const struct file_operations hfs_dir_operations;
 extern const struct inode_operations hfs_dir_inode_operations;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ac4a9055c5c0..c685f1bb7009 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -367,6 +367,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (!hfs_is_valid_cnid(be32_to_cpu(rec->file.FlNum), rec->type))
+			return -EIO;
+
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -390,6 +393,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (!hfs_is_valid_cnid(be32_to_cpu(rec->dir.DirID), rec->type))
+			return -EIO;
+
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
@@ -571,7 +577,8 @@ static struct dentry *hfs_file_lookup(struct inode *dir, struct dentry *dentry,
 	res = hfs_brec_read(&fd, &rec, sizeof(rec));
 	if (!res) {
 		struct hfs_iget_data idata = { NULL, &rec };
-		hfs_read_inode(inode, &idata);
+
+		res = hfs_read_inode(inode, &idata);
 	}
 	hfs_find_exit(&fd);
 	if (res) {
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a466c401f6bb..5275936304c7 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -361,7 +361,8 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR ||
+		    be32_to_cpu(rec.dir.DirID) != HFS_ROOT_CNID)
 			res = -EIO;
 	}
 	if (res)
@@ -372,6 +373,11 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root_inode)
 		goto bail_no_root;
 
+	if (is_bad_inode(root_inode)) {
+		iput(root_inode);
+		goto bail_no_root;
+	}
+
 	set_default_d_op(sb, &hfs_dentry_operations);
 	res = -ENOMEM;
 	sb->s_root = d_make_root(root_inode);
-- 
2.43.0

