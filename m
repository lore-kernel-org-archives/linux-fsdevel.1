Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33E3EB0ED;
	Tue, 14 Jul 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021300; cv=none; b=p+FX3IOlBf1lmMeCI+hLzsnrR5XlaBfqsAzduUx52SHv37EXsFAWD5NGvufrXaBsUn13O04NUS6trs7YwA6AGC3EEGLUrw1Y+JoPcJ6oupRw9DY2HuiVOc05Fgj/A3EycKki1uVyqzJSAT16TUtBUok2zOsPGqyF2TERF0OUuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021300; c=relaxed/simple;
	bh=U07ydkqMcRM6PYx/K+gMTO0DQy3bVKsl6MnHGw+TjAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWTkMM4X0E4243g76q6DDPkcA8zfsKuOelPtdYWKLOoHKdJnq+9nLRELq4I8EDSmRYi09brDC2KL60ZxSv/5XPTURcDesaM+g+UnWPTfyHbHhpeVwfMzCRexkwBdnoVsiHVK7urHjufGflsWpwNy1H8hKudzw9MdwWwH9shy9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4f045fba7f6611f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8736ac21-773c-49f6-9a8a-c1cd333a92d5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0da4ae78c7b721b123bd192d7981210a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4f045fba7f6611f1aa26b74ffac11d73-20260714
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1263517067; Tue, 14 Jul 2026 17:28:01 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chentaotao@didiglobal.com, chuck.lever@oracle.com, dlemoal@kernel.org, liuxixin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] affs: restore directory entry after failed rename insert
Date: Tue, 14 Jul 2026 17:05:29 +0800
Message-ID: <e7143a723ffadee9e62ebbd9bf045a20455c1a56.1784019929.git.kylinos.cn>
In-Reply-To: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
References: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: affs/send-local.py

affs_rename() removes the object from the old directory hash before
inserting it under the new name. If insert_hash() fails, the object
keeps the new name but is linked in neither directory.

On failure, restore the original name from old_dentry and re-insert into
the old directory. Still return the insert error; warn if rollback fails.
Apply the same best-effort rollback to affs_xrename().

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 fs/affs/namei.c | 93 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index c3c6532da4b0..08edfdaeefc3 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -401,6 +401,38 @@ affs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 	return affs_add_entry(dir, inode, dentry, ST_LINKFILE);
 }
 
+/* Write dentry name into header and insert into dir (success or rollback). */
+static int affs_reinsert_with_name(struct inode *dir, struct buffer_head *bh,
+				   struct dentry *dentry)
+{
+	struct super_block *sb = dir->i_sb;
+	int err;
+
+	affs_copy_name(AFFS_TAIL(sb, bh)->name, dentry);
+	affs_fix_checksum(sb, bh);
+	affs_lock_dir(dir);
+	err = affs_insert_hash(dir, bh);
+	affs_unlock_dir(dir);
+	return err;
+}
+
+/* Put both exchange objects back under their original names/dirs. */
+static void affs_xrename_restore(struct inode *old_dir, struct inode *new_dir,
+				 struct buffer_head *bh_old,
+				 struct buffer_head *bh_new,
+				 struct dentry *old_dentry,
+				 struct dentry *new_dentry)
+{
+	if (affs_reinsert_with_name(old_dir, bh_old, old_dentry))
+		affs_warning(old_dir->i_sb, "xrename",
+			     "failed to restore inode %lu",
+			     (unsigned long)bh_old->b_blocknr);
+	if (affs_reinsert_with_name(new_dir, bh_new, new_dentry))
+		affs_warning(new_dir->i_sb, "xrename",
+			     "failed to restore inode %lu",
+			     (unsigned long)bh_new->b_blocknr);
+}
+
 static int
 affs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	    struct inode *new_dir, struct dentry *new_dentry)
@@ -434,13 +466,15 @@ affs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (retval)
 		goto done;
 
-	/* And insert it into the new directory with the new name. */
-	affs_copy_name(AFFS_TAIL(sb, bh)->name, new_dentry);
-	affs_fix_checksum(sb, bh);
-	affs_lock_dir(new_dir);
-	retval = affs_insert_hash(new_dir, bh);
-	affs_unlock_dir(new_dir);
-	/* TODO: move it back to old_dir, if error? */
+	/* Insert into the new directory with the new name. */
+	retval = affs_reinsert_with_name(new_dir, bh, new_dentry);
+	if (retval) {
+		/* old_dentry still has the original name; put the object back. */
+		if (affs_reinsert_with_name(old_dir, bh, old_dentry))
+			affs_warning(sb, "rename",
+				     "failed to restore inode %lu",
+				     (unsigned long)bh->b_blocknr);
+	}
 
 done:
 	mmb_mark_buffer_dirty(bh,
@@ -453,11 +487,10 @@ static int
 affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	     struct inode *new_dir, struct dentry *new_dentry)
 {
-
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *bh_old = NULL;
 	struct buffer_head *bh_new = NULL;
-	int retval;
+	int retval, retval2;
 
 	bh_old = affs_bread(sb, d_inode(old_dentry)->i_ino);
 	if (!bh_old)
@@ -480,25 +513,41 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	affs_lock_dir(new_dir);
 	retval = affs_remove_hash(new_dir, bh_new);
 	affs_unlock_dir(new_dir);
-	if (retval)
+	if (retval) {
+		/* Names unchanged; only put old back into old_dir. */
+		if (affs_reinsert_with_name(old_dir, bh_old, old_dentry))
+			affs_warning(sb, "xrename",
+				     "failed to restore inode %lu",
+				     (unsigned long)bh_old->b_blocknr);
 		goto done;
+	}
 
 	/* Insert old into the new directory with the new name. */
-	affs_copy_name(AFFS_TAIL(sb, bh_old)->name, new_dentry);
-	affs_fix_checksum(sb, bh_old);
-	affs_lock_dir(new_dir);
-	retval = affs_insert_hash(new_dir, bh_old);
-	affs_unlock_dir(new_dir);
+	retval = affs_reinsert_with_name(new_dir, bh_old, new_dentry);
+	if (retval) {
+		affs_xrename_restore(old_dir, new_dir, bh_old, bh_new,
+				     old_dentry, new_dentry);
+		goto done;
+	}
 
 	/* Insert new into the old directory with the old name. */
-	affs_copy_name(AFFS_TAIL(sb, bh_new)->name, old_dentry);
-	affs_fix_checksum(sb, bh_new);
-	affs_lock_dir(old_dir);
-	retval = affs_insert_hash(old_dir, bh_new);
-	affs_unlock_dir(old_dir);
+	retval = affs_reinsert_with_name(old_dir, bh_new, old_dentry);
+	if (retval) {
+		/* Undo the first insert, then restore both originals. */
+		affs_lock_dir(new_dir);
+		retval2 = affs_remove_hash(new_dir, bh_old);
+		affs_unlock_dir(new_dir);
+		if (retval2)
+			affs_warning(sb, "xrename",
+				     "undo insert of inode %lu failed (%d)",
+				     (unsigned long)bh_old->b_blocknr, retval2);
+		affs_xrename_restore(old_dir, new_dir, bh_old, bh_new,
+				     old_dentry, new_dentry);
+	}
+
 done:
-	mmb_mark_buffer_dirty(bh_old, &AFFS_I(new_dir)->i_metadata_bhs);
-	mmb_mark_buffer_dirty(bh_new, &AFFS_I(old_dir)->i_metadata_bhs);
+	mmb_mark_buffer_dirty(bh_old, &AFFS_I(retval ? old_dir : new_dir)->i_metadata_bhs);
+	mmb_mark_buffer_dirty(bh_new, &AFFS_I(retval ? new_dir : old_dir)->i_metadata_bhs);
 	affs_brelse(bh_old);
 	affs_brelse(bh_new);
 	return retval;
-- 
2.43.0

