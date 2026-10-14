Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F5367B6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966202; cv=none; b=k52BFEnlhd2Z78YNwvftwUlVM+u9RuzEM8mNsfromodGHQCpGcRS9jekHEMZVXUGEOUVd0/ZYy407iozEzD/2K49xibNnlbH0BZGQMnOzN44KJkuKTBIvJjL97m/cVpvc52x/GDmiqEJKNDV+jwCmdjIVHDUOlK/U8drTAwC5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966202; c=relaxed/simple;
	bh=YI3iNmmxA40Va2OzlxQlTCwHPo4qTgCwakdv7YPAbe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfMLN62VI6Cp2wAVhkrtptZvvn7EY7naKUiEbttNTiVntLqMJXBifMPCS38xccYJe3biGHeFgmmkPqBVexLzcOVbHJVNjPC6oxguBlMlKa3Qt+xQMNfjztUrGKhH7+8FpzVAJe9Ppb11/RPVzOyw+E34nR8wJS6VTUb8mZg2WkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9r0V4f7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9r0V4f7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e6df2742cso588414666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966199; x=1792570999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+CddHoMiKHEmSbyvHKrxG8TmghYVIrQpeea/wq5UA4=;
        b=d9r0V4f7hJa/W/1UX+wqgdIL9gmmPrMGQHCuEOKEssHyx7CVRwtrAoe8x3lRzX2LPa
         gel+3/mkru0tKEvJ2fwUGHhZ0J3NQ55ZymeYQ3Bymxyqv7Cf5d5VtiPXgaS5t8YC79wm
         ummdsCRecRUF1ZhgV3T+x6O0JZQD/imzclCpgk3hhZ7FPKGsLbCUTzR+vLcbNn6WF2SC
         3QsNp8K4HLqzxL9bJoKLx6wUksR6ZfW9f3etviP7HaSUOlQD5z8SCp7pejoatCS5Wb1x
         sFX///7/k5XM1dK9ye67OT5pTd95VWuELRtesRfDDKEW8b77MAfwI1IJZqfwouyP5zaE
         rdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966199; x=1792570999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+CddHoMiKHEmSbyvHKrxG8TmghYVIrQpeea/wq5UA4=;
        b=El8+rXmU29CRxfZCsyQQ2st+OWQYlbJc4HCjwIvLzGI6CJyBa7AGq5bVEDD0hUCdFV
         G/wm5RTAmm5Z5J6LNl2D5907t2qc9oKaNvKe0vxpwAvDHNPfNajlStIsxDAkY9BSA1le
         hTRIN8WmhEeNI43nzYpSo6WHImtA29uitX7VgNlJ5Kt1mAhjARsdEsRg4qc2yWMeTc4A
         KR5ic9QEG/H8t5snWSRNYTuO9/wV+GPBIq69fiNvF2+68I+td9m1ePC52WGnlgmqIQPT
         BsBUytoiycp/Aqc7eeQgHRxtwwDaI85foEuC3fYcJ7Lkmzzy89BSZYugkFfkKDFTsLvt
         3YQg==
X-Forwarded-Encrypted: i=1; AKwUvBx69h3W+4/9011CCoXgSVh1KEPHwMXOaISSxGOHML1XzVk0fKB5UctwrLYjpM3zJAMr63YeIpCEQjlEgQrS@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7ntkdWIhRMv27dWh+kZiakcq0ICJ//cDCwqfDLpaBHwckdRgU
	BDnWLcjPWBUU1fPyKFah4annXKzBOgTjdpCWNtOHEfKw8+Lw0nEYoBcH
X-Gm-Gg: AYBFou2sv/H8LD1rYWIFY1BpktobhZCB+k/738EADtsupKva33T2esS7fFu+jYbyjkQ
	tws+XpjluqkdCOFYBVRp1Xxwbzd2w078PckVeg2DGMdvf/4ZttpK6b7uYwtD/IUygqwGrK6sbeW
	gp5pY4tu7UIUmDc6nIx+LMm6CCWSAviUICdxW5gzZZBgXad/JyJr2GFb1BlcZH1p3IRHB+un9uf
	tNuO4Ws3J5PkkBhnETqhdKszg74yjvxJG44yhG+JupB8fHiVEqULJs70YXkKwidqK5WsJWjkbTV
	iCYlSw1rAHbuvJfFcliJT6jTaNGyG9Wv51OCaPaDOOSfe7iygEQbBuqISmlUWDzY505/ybWAsS5
	5MnGGboV+RyDsePXGf66s0SYvADxbyUgA6cjJJMmNCJrCAEfZT6MRoOmzyB08i/D+xpJzqn3J68
	HPSAaVmY9JfA5ZYCadSC4DSuh/0pXG69B8ImXjCjrEkuZOeqWGI58pWefEel0ackMAgfOxB/2V3
	qfqBu8OkqDAcfj9Ocd67MyT6kkY0fZoC//qP2xroIGL9OJOHozEldR54CWbr0wMBO++K1f9Q/If
	Vn898xVL/Jjoo4C/Qy9G+T/cmPkMC5AWBRAX4miTRQQe3oGpBpyZvPlOz++hIHUbakfQXq1UkjD
	4EAF0gLhxkDwuLCI1KdX+
X-Received: by 2002:a17:907:6d1f:b0:c2d:d1d8:b220 with SMTP id a640c23a62f3a-c31aa091a32mr1450110266b.42.1791966198640;
        Wed, 14 Oct 2026 01:23:18 -0700 (PDT)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c388b601c2bsm108453666b.66.2026.10.14.01.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:23:18 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: [PATCH v3] fat: make rename recovery safe after metadata write errors
Date: Wed, 14 Oct 2026 10:23:12 +0200
Message-ID: <20261014082315.190262-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87bj90m6dq.fsf@mail.parknet.co.jp>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com> <20260929090029.742579-1-krystianmkaniewski@gmail.com> <87ld8j4161.fsf@mail.parknet.co.jp> <1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com> <87bj90m6dq.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed synchronous FAT metadata write clears BH_Uptodate. Rename
recovery can then modify and dirty the same retained buffer, which
triggers the !buffer_uptodate warning in mark_buffer_dirty().

Stop on-disk rollback after a failed dotdot update or old-entry removal,
where a complete rollback can no longer be guaranteed. At an
inode-position failure no dotdot update or source-entry removal has
started, so rereading the affected entry block and restoring the changed
entry slots can still complete the rollback.

Read a retained new-entry buffer again before removing the entry.
Replacement and exchange recovery use inode writeback, which reacquires
the directory-entry buffer. When the second exchange position write
fails, the first has already reached disk, so attempt both restorations
even if retrying the failed block also fails.

Report recovery errors returned by these steps as corruption and preserve
the original forward error.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes in v3:
- Give up the on-disk rollback entirely after a failed dotdot update or
  old-entry removal, as suggested by OGAWA Hirofumi, instead of tracking
  buffer aliases and reverting what is still possible.
- After a failed inode-position write, read the retained new-entry buffer
  again with bh_read() before removing the entry, and write a replaced
  target entry back through inode writeback.
- New subject, since rollback is no longer skipped per buffer.

v2: https://lore.kernel.org/all/1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com/

 fs/fat/namei_msdos.c | 39 ++++++++++----------------
 fs/fat/namei_vfat.c  | 66 +++++++++++++++++---------------------------
 2 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index d46d1a3..0aab2b1 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -441,7 +441,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
-	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
+	int err, old_attrs, is_dir, update_dotdot, rollback_err = 0;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
 	old_inode = d_inode(old_dentry);
@@ -533,7 +533,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		if (IS_DIRSYNC(new_dir)) {
 			err = sync_dirty_buffer(dotdot_bh);
 			if (err)
-				goto error_dotdot;
+				goto error_no_rollback;
 		}
 		drop_nlink(old_dir);
 		if (!new_inode)
@@ -543,7 +543,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
 	if (err)
-		goto error_dotdot;
+		goto error_no_rollback;
 	inode_inc_iversion(old_dir);
 	fat_truncate_time(old_dir, &ts, FAT_UPDATE_CMTIME);
 	mark_inode_dirty(old_dir);
@@ -561,37 +561,26 @@ out:
 	brelse(old_sinfo.bh);
 	return err;
 
-error_dotdot:
-	/* data cluster is shared, serious corruption */
-	corrupt = 1;
-
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
-		mmb_mark_buffer_dirty(dotdot_bh,
-				      &MSDOS_I(old_inode)->i_metadata_bhs);
-		corrupt |= sync_dirty_buffer(dotdot_bh);
-	}
+error_no_rollback:
+	/* Do not continue an on-disk rollback that cannot be completed. */
+	rollback_err = err;
 error_inode:
 	fat_detach(old_inode);
 	fat_attach(old_inode, old_sinfo.i_pos);
 	MSDOS_I(old_inode)->i_attrs = old_attrs;
 	if (new_inode) {
 		fat_attach(new_inode, new_i_pos);
-		if (corrupt) {
+		if (!rollback_err) {
 			mark_inode_dirty(new_inode);
-			corrupt |= sync_inode_metadata(new_inode, 1);
+			rollback_err = sync_inode_metadata(new_inode, 1);
 		}
-	} else {
-		/*
-		 * If new entry was not sharing the data cluster, it
-		 * shouldn't be serious corruption.
-		 */
-		int err2 = fat_remove_entries(new_dir, &sinfo);
-		if (corrupt)
-			corrupt |= err2;
-		sinfo.bh = NULL;
+	} else if (!rollback_err) {
+		/* Read the entry block again if a failed write invalidated it. */
+		rollback_err = bh_read(sinfo.bh, 0);
+		if (rollback_err >= 0)
+			rollback_err = fat_remove_entries(new_dir, &sinfo);
 	}
-	if (corrupt < 0) {
+	if (rollback_err < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
 			     __func__, sinfo.i_pos);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index da3e89c..f10828c 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -938,7 +938,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
-	int err, is_dir, corrupt = 0;
+	int err, is_dir, rollback_err = 0;
 	struct super_block *sb = old_dir->i_sb;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
@@ -984,7 +984,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
 					    dotdot_de);
 		if (err)
-			goto error_dotdot;
+			goto error_no_rollback;
 		drop_nlink(old_dir);
 		if (!new_inode)
  			inc_nlink(new_dir);
@@ -993,7 +993,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
 	if (err)
-		goto error_dotdot;
+		goto error_no_rollback;
 	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
@@ -1009,34 +1009,25 @@ out:
 
 	return err;
 
-error_dotdot:
-	/* data cluster is shared, serious corruption */
-	corrupt = 1;
-
-	if (dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
-						 dotdot_de);
-	}
+error_no_rollback:
+	/* Do not continue an on-disk rollback that cannot be completed. */
+	rollback_err = err;
 error_inode:
 	fat_detach(old_inode);
 	fat_attach(old_inode, old_sinfo.i_pos);
 	if (new_inode) {
 		fat_attach(new_inode, new_i_pos);
-		if (corrupt) {
+		if (!rollback_err) {
 			mark_inode_dirty(new_inode);
-			corrupt |= sync_inode_metadata(new_inode, 1);
+			rollback_err = sync_inode_metadata(new_inode, 1);
 		}
-	} else {
-		/*
-		 * If new entry was not sharing the data cluster, it
-		 * shouldn't be serious corruption.
-		 */
-		int err2 = fat_remove_entries(new_dir, &sinfo);
-		if (corrupt)
-			corrupt |= err2;
-		sinfo.bh = NULL;
+	} else if (!rollback_err) {
+		/* Read the entry block again if a failed write invalidated it. */
+		rollback_err = bh_read(sinfo.bh, 0);
+		if (rollback_err >= 0)
+			rollback_err = fat_remove_entries(new_dir, &sinfo);
 	}
-	if (corrupt < 0) {
+	if (rollback_err < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
 			     __func__, new_i_pos);
@@ -1067,7 +1058,7 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 	struct inode *old_inode, *new_inode;
 	struct timespec64 ts = current_time(old_dir);
 	loff_t old_i_pos, new_i_pos;
-	int err, corrupt = 0;
+	int err, rollback_err = 0;
 	struct super_block *sb = old_dir->i_sb;
 
 	old_inode = d_inode(old_dentry);
@@ -1106,13 +1097,13 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
 					    old_dotdot_de);
 		if (err)
-			goto error_old_dotdot;
+			goto error_no_rollback;
 	}
 	if (new_dotdot_de) {
 		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
 					    new_dotdot_de);
 		if (err)
-			goto error_new_dotdot;
+			goto error_no_rollback;
 	}
 
 	/* if cross directory and only one is a directory, adjust nlink */
@@ -1135,24 +1126,17 @@ out:
 
 	return err;
 
-error_new_dotdot:
-	if (new_dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
-						 new_dotdot_bh, new_dotdot_de);
-	}
-
-error_old_dotdot:
-	if (old_dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
-						 old_dotdot_bh, old_dotdot_de);
-	}
-
+error_no_rollback:
+	/* Do not start a partial on-disk rollback after a failed ".." write. */
+	rollback_err = err;
 error_exchange:
 	vfat_exchange_ipos(old_inode, new_inode, new_i_pos, old_i_pos);
-	corrupt |= vfat_sync_ipos(new_dir, new_inode);
-	corrupt |= vfat_sync_ipos(old_dir, old_inode);
+	if (!rollback_err) {
+		rollback_err |= vfat_sync_ipos(new_dir, new_inode);
+		rollback_err |= vfat_sync_ipos(old_dir, old_inode);
+	}
 
-	if (corrupt < 0) {
+	if (rollback_err < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld, %lld)",
 			     __func__, old_i_pos, new_i_pos);
-- 
2.53.0

