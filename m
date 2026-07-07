Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC6347500
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466955; cv=none; b=omBnBKVFZrM4Nyjy35+EkoA+fQdD0uVqp9I7+EWhMErW3eORjr7h0XAnj1C4i1uSYG6BErmJ9TqZ86KPi7vcRosI58bwlFUOpXTdR9+ZfTh3PXk6csHQ50dEBwGtTJZtseBNR58Qtyd45+bjKlvfMNGcfvwKAWMn5nIYMTlWXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466955; c=relaxed/simple;
	bh=sHliB8Yz1FIpJ+7zS2z3Zwvdu3V3VbZKFukqTDCDvqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StSJsMdAKYOT5sLjuuKl7yt2DHUkFsU3kpb7hFJoP87hianK5doEZBi6iExhPCdnmcqbou1oEaK3CRG0S7oAQ63ohCJNfCKN+nKA7pi0eEx765WWymJlWDdK3jS8l+kavtbtRWFS0JfnGG9b6+NbAGNA5T4dkmLghpFFZqOq4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STyBixTv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STyBixTv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so398955e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 16:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783466952; x=1784071752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76TP4lXM4GuDNUnyOn48UBM2adopJo/ru0q4bh+ao5I=;
        b=STyBixTvnD8uh2Hn+wln2iBFAoWrQh4F4H2DoPssjlL1BlECD1tSJfFM+HHTnS5vy4
         09uN6+TVTgEDpGcWUQXY4ttgtn0AY/r0A+Wz3quq9JgM1M4fOOk0l6faiiHYqk196o9S
         TfUI8Coy6+cSpkd3aGKzwFMPZTg44TOhcug+7YbwUUc8/wjMlPQNEbWsgTCqXfXyzCEX
         ccQzEdoIEocQI95yf14cn5zAjPczjJHc5polcuT1geArwbTC5cIDOXAl2jVbNMCmTd2+
         OsrULoPvtNLMhnrSPLFK+lVJmRjUhuyeOZP6tyUX5vJImaUPMFFDGDnmJxod9JRKbPQ7
         6vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783466952; x=1784071752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=76TP4lXM4GuDNUnyOn48UBM2adopJo/ru0q4bh+ao5I=;
        b=aJGQXoYd6nXpPL5+YTcaeZOs7RspIEYWCpJJrRC/zKkV83qUZBoScFy3ftRZzRU/0Z
         o4DwBWhDZtarBFM3pPIhjnf8HP7lIpCRE7T8Up7RrE25nYFl3CFp1TwfTsKBrTaAacA2
         E1ZKpKPTnE9RyxrWMpY8ONjNhCF+ApI5i4CUgE4UoJkxg5gsf6/u1/5sJf3p0gAXdYBx
         PFIC14dGjevs64CtN4Q7xAuRWXheVEcIbQixPw5B6ik9d1pcWDfBlAPA0xpqoQGv7Nui
         wEy+Oaq8x7CPNxhHxg3LVo6/N9L1cKV8MzwpxG1PY0G5IojjjhLXUY6srryxOifi9zaH
         aCbA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2zTp5clb4j1aeoW7CB6azbMLo8PnxYwz+LI3g2nSO+XTVNunWf8N2+gUrfZib8G2mLcydErL9D18Y2lB/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QuJKenbJXbCaH8rzqIsw54eAARMDwHL1PhnQftam8ok51uSC
	jr/IlS1Pnpazkwup8NBPnfhbSGnajqyST6PeH2H6OSu/3eramiVWc+Iu
X-Gm-Gg: AfdE7cmP8/bX2YqldxNzTYAI1g45akKBbRS3f3bRuHw86mEZrs8LgxBIgVzuRvFL6Sv
	ttMgJFeTpfsIns5qp4DeTKDAAgapYOgKRjAvJ9NUTVQgeIVh0uwoqle2Ym0f/eqmETpr3fCnqET
	hUpq35DxwD986vq87e3r68YJNap8J3fqP3t5wlFVSnldSJdiucp7cyCQIVpJUGm7CBbK4AO6wF6
	m5NO7W3fxCSAeKidq2JCJZxE2sGB5QC2jD67BzhwDVWpYxe6kPwKiOBqdX/CIJ7z/0IRufKAmRj
	DfJr2fSnPr/+PsTLGvhWYQzm5E1oej4yVXSx6aaOkRS1OJzFfbB6FKFC4eN5CEmYdagELQHK80p
	hBJ7p/qTPVsRK2cAMQ73aEV22j4X8lOE9rEAgkVpLZLe7CZcMv8rlZ/LiZHCVYkMb5YtTh8oISX
	kqnSAYINiWjBEY/KupXVCF/Jx/AsYKau25exPZzzrYixjG3ZCvCqxUCFfaPuzFpmdwSz0PFZRGi
	M8w+NDoepX8yBwXA+R0XXqU1FZ3uhOyrfPWhsxXaC3whAZ4O4IAaxeV/eV48YkAQEI1OUpv7V6n
	uSGE/FQOcg==
X-Received: by 2002:a05:600c:6990:b0:493:915b:dc4a with SMTP id 5b1f17b1804b1-493df055999mr84259345e9.8.1783466951918;
        Tue, 07 Jul 2026 16:29:11 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm38581225f8f.25.2026.07.07.16.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 16:29:11 -0700 (PDT)
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
Subject: [PATCH v4] hfs: validate catalog CNIDs before instantiating inodes
Date: Tue,  7 Jul 2026 23:28:50 +0000
Message-ID: <20260707232850.510374-1-davemadmaxxx@gmail.com>
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
 fs/hfs/inode.c   | 12 +++++++++---
 fs/hfs/super.c   |  5 +++++
 4 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 1bfa36d71e24..e672a4ba6dc7 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -182,6 +182,40 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 			  key2->cat.CName.name, key2->cat.CName.len);
 }
 
+static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd, u32 cnid)
+{
+	hfs_cat_rec rec;
+	u32 found_cnid;
+	size_t rec_len;
+
+	rec_len = fd->entrylength;
+	if (rec_len <= 0 || rec_len > sizeof(rec))
+		return -EIO;
+
+	memset(&rec, 0, sizeof(rec));
+	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
+
+	switch (rec.type) {
+	case HFS_CDR_FIL:
+		if (rec_len != sizeof(struct hfs_cat_file))
+			return -EIO;
+		found_cnid = be32_to_cpu(rec.file.FlNum);
+		break;
+	case HFS_CDR_DIR:
+		if (rec_len != sizeof(struct hfs_cat_dir))
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

