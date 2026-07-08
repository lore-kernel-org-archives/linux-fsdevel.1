Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E93F6C50
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547821; cv=none; b=uGGO9mLeUEDYq8oDpKSg9m3tMLUJU7+AHA8a9sjkpIF7zoP1kXKNMNn4T4WLKZ5DqgGKacDI5AxrkSY88sx+qRV0hgQVTARx4P2ZrU6O9dkB+oO0wQe6XDLUAw8LpoPhVhPuHqFHZkWni8MFfYcyfHG1dLgHC9Tl7A16x65fi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547821; c=relaxed/simple;
	bh=QVe4jKuvOfiDfxX99HxaTw8rx+AGVuMl/WCBbZs9h+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcuZ3Tr7muROfWpO47YjcBgQXXKRg+OiMQVqMY6gJune6VdJHxQn1/WbW7sLXL+we0Ml/kR05RHXX1n3MDTwuzf3YCshLYZ9UtIok7Dn2WcM19RTNyNlWqclHBaXvMuStGch8zfJbAbMGGXbKwAAsul4uO1/xuzFffp9vez+QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6Q0Ya5D; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6Q0Ya5D"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1001807f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547818; x=1784152618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdybbrtKvGdEqvgwrw3pOU8rtcJK360EeNTJSGHkHGk=;
        b=j6Q0Ya5DO/vExx+fCfORerZJeHqqo6MKuOscolSaSGgeh8RhOCNDfROugg/Y3sHcEW
         lSkWwtvqL24VQ9h+bj+xbx0mJ9Np8uoIDG1gGSQ9/rWh+KMxGLJoQVvDpZveD8qnRzGI
         +Hk1nsWC+N2szL+eOZPIFgiFVAXG8Tib27yo4YdxLcfu5cv2OJqWUU7VWaCbYAzRb0Jv
         gbKtoVNVvx4KgCH/CKzLQKDfVEaBYmdc63P9mkdBXwThqfN0aHVBnDE0UDSo93LfQ6lH
         xOmpTYypWvT39QIOlfBmG7Eun0uuFrj/m7BQkajsyTXqhv5pS21pE+jmbu0EVm0E/bT1
         MKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547818; x=1784152618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CdybbrtKvGdEqvgwrw3pOU8rtcJK360EeNTJSGHkHGk=;
        b=q8ovY2VVlDNSSTiUHQUs/FKLisgvlqroIojkWNb600nMYE1Qqwl/mYb7FRU9uyjiR3
         xLfsRFEopdy0v4K5HvPi7RtrhZyPZfbox+Szm4TrQpZRyMOKJo9des/OxW1K1SmNdExl
         U6vOQVtomBcYg8D7CkURi6MxCalNON6pACDFzcToV1xY3tTGiqS5J9q18o/Q+HL4iS+g
         Swg108JP8E5IZNVFoo/csYv6OF0lTVmCDT/Xx1vV26b5n9NdHRgaf1CSiZoSce0jqAn6
         p+aaZduivNhTzwZLDizL8Y7G+03c5WKLLUYsMVMgsBybqcgQ1BcavKFdUl4RZWisaWuc
         kOag==
X-Forwarded-Encrypted: i=1; AHgh+RpGOPKy5sxtaAQ7j4NAwUGNa/46WGHXGwygWgO2GW+ZCa/t68Va3/ZpNwqcXSKYkyZgbT6oPmjibWVhzMWp@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFdFmzV0q1Qwp4ZhDCkbehS5xyRaDPHdDtoqE6YiLtN8jM9l2
	tnxX6awzcm2RprMO6UpmNvQJciY4rzEDWMCyGHIaDdbwaxQqXD+itxh/
X-Gm-Gg: AfdE7clgg/b8IAbes5KfknDGDpu3MZE2f08syt+4k5CxrdB1QZjonVhavKT0fhKJTWE
	CodElXyYXmSxE40H1Ha2+00rwHHLJQ42stJ2mBKW5J2VQfjpDVO+GK7dUJlgwtyYVH+f5Q4xGyB
	GIqlScrsQ9Nmc02Wsij+xfrYP7ATSipyhIilv8gaIhpNbbpRVWTbKRZ2iE0zQjj0wRAR50KmBFn
	P/L3HNuITivupOQcDrDiL05pW3lPf49Avs0pDSIz5o3XowxsAKcaFxmLT0PLVa1aIS0OWS1Ndnl
	vpjao6ZtaZA/nkXIZTUbNk+6oEuEB+LGr1pnezHpsUnvUrxCu1nyAvNAEb7065JkQmJFiG3GKUm
	3I+G4j1gmOnT7ixQs7sV1zk50S1iEIFYRcKT6HIs7P4cUpsZsaDiaPQSuA4d7tWzMOqvNMW3aG0
	KSelSIJQFK9wxTx7PofpI1cwW263ftoorsWLkhoWAq4o8kX5cOZxKn9EQfY2p6PoT4/W6alWQ2c
	u46OFzngZ/pTu2OsnuRvURBNpSI9oFlKfnv8hhZ0R5cKwowJPakN7A+sLYG7eRH1bSD8g5sQVs=
X-Received: by 2002:a5d:5846:0:b0:472:edc7:b4c9 with SMTP id ffacd0b85a97d-47df07896demr4322003f8f.38.1783547818244;
        Wed, 08 Jul 2026 14:56:58 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (15.22.156.34.bc.googleusercontent.com. [34.156.22.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm44738344f8f.20.2026.07.08.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:56:57 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: [PATCH v5] hfs: validate catalog CNIDs before instantiating inodes
Date: Wed,  8 Jul 2026 21:56:36 +0000
Message-ID: <20260708215636.73815-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707232850.510374-1-davemadmaxxx@gmail.com>
References: <20260707232850.510374-1-davemadmaxxx@gmail.com>
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

Validate the record found by the second lookup before returning it.
Read the already-found record with hfs_bnode_read(), require the exact
fixed size for file and directory records, reject other record types,
and verify that the stored CNID matches the requested CNID.

Also validate reserved CNIDs in hfs_read_inode() before populating the
inode, propagate hfs_read_inode() failures from the resource-fork lookup
path, and reject bad resource-fork and root inodes.

Keep hfs_write_inode() unchanged, so corrupted catalog records are
rejected before reaching its existing reserved-CNID BUG() path.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Cc: George Anthony Vernon <contact@gvernon.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
---
Changes in v5:
- Keep rec_len signed by using int to match fd->entrylength, making
  the non-positive length check meaningful before passing the validated
  value to hfs_bnode_read().
- Use (size_t) casts when comparing rec_len against record sizes to
  avoid signed/unsigned comparisons.
- Preserve the original error code in hfs_file_lookup(), returning
  -EIO separately only when the inode is marked bad.

Changes in v4:
- Combine the catalog record length validation into one check.
- Require exact sizes for file and directory catalog records.
- Keep hfs_write_inode() unchanged following maintainer feedback.
- Revalidate the exact final patch with the HFS build and QEMU repro.

Changes in v3:
- Drop the stray blank line in hfs_file_lookup().

Changes in v2:
- Use size_t for the catalog record length.
- Reject catalog records larger than hfs_cat_rec.
- Treat non-file/non-directory records as invalid.
- Propagate hfs_read_inode() failures from resource-fork lookup.
- Reject bad resource-fork and root inodes.

 fs/hfs/catalog.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 fs/hfs/hfs_fs.h  | 19 +++++++++++++++++++
 fs/hfs/inode.c   | 13 ++++++++++++-
 fs/hfs/super.c   |  5 +++++
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 1bfa36d71e24..490c5e130da3 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -182,6 +182,40 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 			  key2->cat.CName.name, key2->cat.CName.len);
 }
 
+static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd, u32 cnid)
+{
+	hfs_cat_rec rec;
+	u32 found_cnid;
+	int rec_len;
+
+	rec_len = fd->entrylength;
+	if (rec_len <= 0 || (size_t)rec_len > sizeof(rec))
+		return -EIO;
+
+	memset(&rec, 0, sizeof(rec));
+	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
+
+	switch (rec.type) {
+	case HFS_CDR_FIL:
+		if ((size_t)rec_len != sizeof(struct hfs_cat_file))
+			return -EIO;
+		found_cnid = be32_to_cpu(rec.file.FlNum);
+		break;
+	case HFS_CDR_DIR:
+		if ((size_t)rec_len != sizeof(struct hfs_cat_dir))
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
@@ -208,7 +242,12 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
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
index ac4a9055c5c0..c9e75c2e576a 100644
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
@@ -571,13 +577,18 @@ static struct dentry *hfs_file_lookup(struct inode *dir, struct dentry *dentry,
 	res = hfs_brec_read(&fd, &rec, sizeof(rec));
 	if (!res) {
 		struct hfs_iget_data idata = { NULL, &rec };
-		hfs_read_inode(inode, &idata);
+		res = hfs_read_inode(inode, &idata);
 	}
 	hfs_find_exit(&fd);
 	if (res) {
 		iput(inode);
 		return ERR_PTR(res);
 	}
+
+	if (is_bad_inode(inode)) {
+		iput(inode);
+		return ERR_PTR(-EIO);
+	}
 	HFS_I(inode)->rsrc_inode = dir;
 	HFS_I(dir)->rsrc_inode = inode;
 	igrab(dir);
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

