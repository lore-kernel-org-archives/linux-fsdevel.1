Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816A42CB0D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332003; cv=none; b=GCmDs3o80lAUTTveV05GlcX/VRdKlCi3BTVYi1Q+1Eeh9jfRrhT6B+hvs6vDZ9hxrMNP++udtHV8hEwgufiXzitVT6/vsKnni/Ns/bpj3srZM5l/94oB2K3MTN3iS8rmIWID34QdQwmXcY1OkKw++KN5NsDQrIUPX3LSyaFI3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332003; c=relaxed/simple;
	bh=w6sZ8dlNxqGW/t2mjusQAMjI+NuYcFsMQW/LXcBprC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnbLRaXAsM0blXWREmvfEwYilsgxZGab43t9xRmlUwMr6hf4gtBeuPMnOg7Qo8S/ADDEnNHY7ttuZ01Q4dDisOU9/D/FXccfbl/sM56hLtwAgu11V9ftzelS8UFowJdZA3wonAnjtIPe4c9LynIp/vLJ9WO6R9pdn+pOQGa0CjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoP1RFaZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoP1RFaZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493d28b1930so20774825e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783332000; x=1783936800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v40kMaQLD/Lmdy1Knawwn7CoV1pGwsDRx2YycJTqKJw=;
        b=PoP1RFaZUUcI6Hl38ERbtxnw8mXPiXvtBBki9ljdJGkcV3Kb/aL2mOY+6AOgAQ2OhZ
         eIEhhm2V/oP4/zHWhV9uq8ee7Wij+lPKFULq4cigLbbUfxMKDBJTBsB1siBb61XlN2rR
         1zIUe/pCk274JbylwuhERt654JBg2ghC/frMQ39ro703lDHz/cLgcLBO8oShYlzYyc05
         pW39zg6RS7nvDGUTo4B7cY8Fc794nsQbZ+OdtSvEol9Lk6+HMqVV6t414AcG82r6NreZ
         Sx2h23AaIogBeTSwtFkUCbUQ0IqXqZnalTSdpPDi0WESzpTp159EAxFXMiuOl4MvD9Y4
         2U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332000; x=1783936800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v40kMaQLD/Lmdy1Knawwn7CoV1pGwsDRx2YycJTqKJw=;
        b=ARPJR0klRL1zj/tnjLQ3vvSdm1Slyr7DiBPDoYLNAW6mm5KrUHNn+Nax6FT3giEykP
         aUGpEUgHnW3o53CT1f4hMAOcqUJ8Iap23NnJ/XEJPxf/4c8PRcdXomPK17m2GOGopEu8
         SYYH0f6Mx5BGgNJh1juq7qwIAoFGSkqEuA1GPsgJ3E4c0cBv378O9xh0I/VyaTASjldy
         ytW+60f/SJQcjTz5amu+m8Ukj4gfjHb5MRg17m9xtHEI44CUra9CDYoEKx6U9yaJaXcr
         hD7usMhYAJX3apG7zhpmtrzm/CitSGr+q/ovNE5Sd+WgGCaZchnEgMIBM1TM+yXkZrSp
         hLQg==
X-Forwarded-Encrypted: i=1; AHgh+RoQc0un21TDdthcqj1Pfeg8/In20hY0OyUVe49FvTk1sqect/qp7GZYxf0y9kwLyAA57hU3p/VuRXVN71Tr@vger.kernel.org
X-Gm-Message-State: AOJu0YwX64Wck3+PXVRDewUfs3WIsz2C5ywK268qQFIXBlzvoRK7OR+5
	VkQU3FKyoUVib2ZzePwTFMnxoUqJ8J5en6rYforxQfrA3/SA1G6udwKV
X-Gm-Gg: AfdE7cnX/lPdB0S71+m0EwaaR4xbo1HbGGkc3uLhLEYKjQRGYC1zH4inRYSVf3nNMqq
	2kCgjPktlF2QJmMAS+wivLlW2K89dRzuCslaAWJkAlSJzPnbilCD5uc1dqISXN06rA3NpQyNQWn
	kWH/drdYRHk4UjuGNEHr72fttreV3RWghCRm3CpnXNt6JePsX8vidz09cL/6OBrNyNDFFAWhYYd
	MRSPFhPn89WBpTg11WpkEJzm6wRDIHWZUIgub982yl9SjHx1+DbQWVhNk4oZkIWyuT/Se+URb3i
	h4rPyHVsDUTI4i7xkNm8MvvKkF411SsLxebgExF+BxabhEP1m2tffaF0K4WOASa8ex9Z1VKDR3n
	x6hAx0RTtXZcxsItUHXVSkPGnHWeQWXDM6CaQkcTfNpD/yJ3Nh58MiCvl/3pngGDGwwL0Vmn04O
	/ukzVS37Zxc+UXrEV/L88l5VpB0ZmNumhR4M56KZoBjU9oJu6N3VgXxPglF0AwADN5Sf5Zsoae/
	liGtV17fh1Rp3kYec/Nq0ll/hF1CLm3MCykVyTQ5+xS5D51PNtH/IRJLzH6LkFfrfoaWo9YF28=
X-Received: by 2002:a05:600c:4686:b0:493:c42c:7e88 with SMTP id 5b1f17b1804b1-493d11fecddmr108286315e9.34.1783331999577;
        Mon, 06 Jul 2026 02:59:59 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm22931218f8f.24.2026.07.06.02.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:59:59 -0700 (PDT)
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
Subject: [PATCH v3 RESEND] hfs: validate catalog CNIDs before instantiating inodes
Date: Mon,  6 Jul 2026 09:59:43 +0000
Message-ID: <20260706095943.258065-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
References: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
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
Changes in v3:
- Drop the stray blank line before assigning the hfs_read_inode() result
  in hfs_file_lookup().

Changes in v2:
- Use size_t for the catalog record length.
- Return -EIO when fd->entrylength is larger than hfs_cat_rec instead of
  truncating the record length.
- Compare catalog record lengths against sizeof(struct hfs_cat_file) and
  sizeof(struct hfs_cat_dir).
- Drop the hfs_is_valid_cnid() call from the found-record CNID
  comparison; found_cnid != cnid is enough there.
- Treat non-file/non-directory records found by the second lookup as
  invalid for this path.
- Check is_bad_inode() in the resource-fork lookup error path.
- Drop the redundant root DirID check from hfs_fill_super().

 fs/hfs/catalog.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 fs/hfs/hfs_fs.h  | 19 +++++++++++++++++++
 fs/hfs/inode.c   | 12 +++++++++---
 fs/hfs/super.c   |  5 +++++
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 1bfa36d71e24..50ee709d966f 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -182,6 +182,43 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 			  key2->cat.CName.name, key2->cat.CName.len);
 }
 
+static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd, u32 cnid)
+{
+	hfs_cat_rec rec;
+	u32 found_cnid;
+	size_t rec_len;
+
+	if (fd->entrylength <= 0)
+		return -EIO;
+
+	rec_len = fd->entrylength;
+	if (rec_len > sizeof(rec))
+		return -EIO;
+
+	memset(&rec, 0, sizeof(rec));
+	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
+
+	switch (rec.type) {
+	case HFS_CDR_FIL:
+		if (rec_len < sizeof(struct hfs_cat_file))
+			return -EIO;
+		found_cnid = be32_to_cpu(rec.file.FlNum);
+		break;
+	case HFS_CDR_DIR:
+		if (rec_len < sizeof(struct hfs_cat_dir))
+			return -EIO;
+		found_cnid = be32_to_cpu(rec.dir.DirID);
+		break;
+	default:
+		return -EIO;
+	}
+
+	if (found_cnid != cnid)
+		return -EIO;
+
+	return 0;
+}
+
 /* Try to get a catalog entry for given catalog id */
 // move to read_super???
 int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
@@ -208,7 +245,12 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
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
index ac4a9055c5c0..ee10a9257a13 100644
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
@@ -571,12 +577,12 @@ static struct dentry *hfs_file_lookup(struct inode *dir, struct dentry *dentry,
 	res = hfs_brec_read(&fd, &rec, sizeof(rec));
 	if (!res) {
 		struct hfs_iget_data idata = { NULL, &rec };
-		hfs_read_inode(inode, &idata);
+		res = hfs_read_inode(inode, &idata);
 	}
 	hfs_find_exit(&fd);
-	if (res) {
+	if (res || is_bad_inode(inode)) {
 		iput(inode);
-		return ERR_PTR(res);
+		return ERR_PTR(-EIO);
 	}
 	HFS_I(inode)->rsrc_inode = dir;
 	HFS_I(dir)->rsrc_inode = inode;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a466c401f6bb..98b80795bcde 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -372,6 +372,11 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
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

