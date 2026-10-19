Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7895262E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421517; cv=none; b=nwgrwfyaBJe35xlabDUggRXVozbUaoO4gUOcApl1Jy9y7XJ463x+wagMNQHC/cMM8hL2bDyszIThi0L1kK7oCVfUPm/mQVOgdpc5mPxh5a6pZpY5C18AiOxk0z14ipPPUHKFol3e2s977L6AemvCVy925qbtWJz/EuXy1RC4Cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421517; c=relaxed/simple;
	bh=OS3RjvTZKP3UaJklYbK9sB+V63Y6DN3wUzkSBglWg5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfApgEP0G6WCvIFJLvJzzAjI2EzWKkSY2dugvftWfAqIUBMsdzXR16pPrSUUa1zY6TcZI45eGzj15Va4t6hF65yEkkFAEb2M2HegRILmhXLv1l5n428Chhnd1Q/kPMmCL9ugMxjE/Qk+LGOmVCf+g6ycZ/Pgi4/tq1/Psz5UNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PacGApps; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PacGApps"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso723651a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421513; x=1793026313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGRHy/sMAY7OcwK1PcI7sNiKddnuCRwq/lOJ2F0twSw=;
        b=PacGAppsprDvek4AnfHecP/6FrintDc12I9+/umdb1Ymecyjgv8iGR8AhsRMYxco/0
         1c4HJQ4mMx1txdAG8SG4I4vVGeq4sFLk5/9mbPNf/EqRhEoiWw7K57Iy1JRXX1bBnYAg
         4MZuMFBQ+yOWYAKFX7XL0Uj56kGkOwguVFWnSwN2n6/koUXgUcTNHlwhbA5S5O07MR38
         +3Kwq1NYJ7sm543R8PMUyKlwC+E3va+hCHvV72fFyTlpfq4vJbB3RU8xeDg0qBPJfar7
         6ZdyI2karGdz4c6O5/dNRDzB+sHJ8tIaB30zea90bvlgWrdCC6klIU9ydfWYgFq1uDOk
         hs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421513; x=1793026313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGRHy/sMAY7OcwK1PcI7sNiKddnuCRwq/lOJ2F0twSw=;
        b=PZVNFEMSQ5bqeuPacLnMK5dSrEBPz5Id+wvqqXgrg7u4OE0Ry3TXcMOExvDJFrojvO
         3c7P18C0mzs/qZTR7RXpzHRa2RAUssaMf94Nxe3i3DKg7lWM874MO4rkqaFenPfN0SlL
         +ocVboUbooQQM14FbWWb4Rlft8cjMXw44c6bICNfAM8xHLrkzYXgkxq0GrQ1SXQEDFPb
         DbTINH/Glv3mYDwfpueckaDz3yBMjFSN9UzEqAUb31eqpjfYRupSrLsluwpxvsER2/5E
         1hc50QNiME7E/KzKBmZMx/KC343J6JkzhzQ6wJMB2oIruw2uR8hmDUrhHotvPKkzsbJH
         k/HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzF80XL4EjvzWpsJUq59uVAjMTgnSg4Xyb3LZRfYtnd0OrgGVPYFeckopEbmxwkBg/lszBFimA5qnrh0yE/@vger.kernel.org
X-Gm-Message-State: AFq9FYI2Hs62pmv4Dvn/6UwxwdPeuqGN5OngO9XJAOaICIwYXW+5Ramq
	UDXj9J3v9ncMUyJlwpUztYkcI0WhS0u0zG/ZhlCn2Gpjyt50vQ5xj7t7
X-Gm-Gg: AYBFou2T6Y9cNkNWbxmLH6tZ0EpSbRotl7MzZEi3FhfTGjWnHvLWXe3Ur+qQJmiXpZy
	0T+/EpXyDT2JCNahJyGcmr1BUGtxdgqpMsun3+2UT/B+bjYpUQPxKt4D9zF3ytBWqR8BhkY3UrX
	tdJYKKbXlV1bKnkDAYJwAZm85Ctp5yNRkOKYAaLPnfZeXxaxItrPPwPNp8yHEqWsNjUbFTV0cST
	v8d9rHDYYCU0FnpDItB5OHk4ys+zjwT2sUR2aYfhZcOifaZP73UJUTgn+/hny2FQlsLf81jth+7
	Ai5dEw6R/WUbYA+gJcIJrHAwGSEJJCxW2XzsWiPzXRChFoiucmucQFvoLswb7qy+M2zqZL7vuHm
	o262GBfLR9rqklOqyPh0EiQuDchWfQaz9HYOwFEQCN1qh1vnxNISShOV48dvS8uCI0Tld+ZOGNa
	MJcLJQ3hgfbYy2Sh/CWh5eyzDXfLl/ZSCpiZ1JoTfisiEXnYOqGDNGugGUTcE14AV3NLR3er7YH
	boe2K8i2mcwcWx85hIYHsSc1DERJKX/iOFpwOkoGb6WzP9SInx4ffNLj/bPzBdP/z/IpBa1yEFA
	pwz+tTSvlJH83xBKeCM/brk48D7vMYXl3SCh7PCypjzIpf+B/bwXie4lHAbV5DT8j/EgQ+y+JeY
	M3vrBfkTcdfJdY6ImFz54ubifhQwkXOIuIfhEvdkMqi1Nmif9rVh52A==
X-Received: by 2002:a05:6402:190f:b0:6b1:d2d6:4013 with SMTP id 4fb4d7f45d1cf-6b3a816f513mr5295973a12.17.1792421512862;
        Mon, 19 Oct 2026 07:51:52 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b1347sm4128982a12.12.2026.10.19.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:51:52 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: [PATCH v4] fat: make rename recovery safe after metadata write errors
Date: Mon, 19 Oct 2026 16:51:45 +0200
Message-ID: <20261019145146.539233-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <878q3uhv4h.fsf@mail.parknet.co.jp>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com> <20260929090029.742579-1-krystianmkaniewski@gmail.com> <87ld8j4161.fsf@mail.parknet.co.jp> <1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com> <87bj90m6dq.fsf@mail.parknet.co.jp> <20261014082315.190262-1-krystianmkaniewski@gmail.com> <87qzhqvloo.fsf@mail.parknet.co.jp> <55a1f016-a7a2-469f-b481-37223d695f29@gmail.com> <87cxt921rc.fsf@mail.parknet.co.jp> <f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com> <875wz11xfg.fsf@mail.parknet.co.jp> <c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com> <878q3uhv4h.fsf@mail.parknet.co.jp>
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
where a complete rollback can no longer be guaranteed.

An inode-position write can also fail through another associated metadata
buffer. In that case the retained new-entry buffer remains uptodate, so
remove the added entry directly. Check the buffer state and dirty the
entry while holding the buffer lock. If the entry buffer itself failed
writeback, leave it untouched instead of reading it again and submitting
another write from FAT.

Keep the existing replacement and exchange inode-position recovery. When
recovery starts after an exchange position write fails, attempt both
restorations so a failure of one does not suppress the other.

Report recovery errors as corruption and preserve the original forward
error.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes in v4:
- Trust a final block-layer write error. Do not reread or retry the retained
  new-entry buffer from FAT when it is no longer uptodate.
- Remove the added entry directly when its retained buffer remains uptodate.
  Hold the buffer lock across the state check, entry mutation and dirty mark.
- Keep failed dotdot writes and failed old-entry removal on the v3
  no-rollback path.

v3: https://lore.kernel.org/all/20261014082315.190262-1-krystianmkaniewski@gmail.com/

 fs/fat/dir.c         | 27 +++++++++++++++++--
 fs/fat/fat.h         |  2 ++
 fs/fat/namei_msdos.c | 37 +++++++++----------------
 fs/fat/namei_vfat.c  | 64 ++++++++++++++++----------------------------
 4 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 35bdb62944a2e..70433361359cb 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1066,7 +1066,9 @@ static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
 	return err;
 }
 
-int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
+static int fat_remove_entries_internal(struct inode *dir,
+				       struct fat_slot_info *sinfo,
+				       bool require_uptodate)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_dir_entry *de;
@@ -1079,8 +1081,15 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 	 */
 	nr_slots = sinfo->nr_slots;
 	de = sinfo->de;
-	sinfo->de = NULL;
 	bh = sinfo->bh;
+	if (require_uptodate) {
+		lock_buffer(bh);
+		if (!buffer_uptodate(bh)) {
+			unlock_buffer(bh);
+			return -EIO;
+		}
+	}
+	sinfo->de = NULL;
 	sinfo->bh = NULL;
 	while (nr_slots && de >= (struct msdos_dir_entry *)bh->b_data) {
 		de->name[0] = DELETED_FLAG;
@@ -1088,6 +1097,8 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 		nr_slots--;
 	}
 	mmb_mark_buffer_dirty(bh, &MSDOS_I(dir)->i_metadata_bhs);
+	if (require_uptodate)
+		unlock_buffer(bh);
 	if (IS_DIRSYNC(dir))
 		err = sync_dirty_buffer(bh);
 	brelse(bh);
@@ -1116,8 +1127,20 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 
 	return 0;
 }
+
+int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
+{
+	return fat_remove_entries_internal(dir, sinfo, false);
+}
 EXPORT_SYMBOL_GPL(fat_remove_entries);
 
+int fat_remove_entries_if_uptodate(struct inode *dir,
+				   struct fat_slot_info *sinfo)
+{
+	return fat_remove_entries_internal(dir, sinfo, true);
+}
+EXPORT_SYMBOL_GPL(fat_remove_entries_if_uptodate);
+
 static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
 			      struct buffer_head **bhs, int nr_bhs)
 {
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 61338413d9f3e..003d311ae5523 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -343,6 +343,8 @@ extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
 extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			   struct fat_slot_info *sinfo);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
+int fat_remove_entries_if_uptodate(struct inode *dir,
+				   struct fat_slot_info *sinfo);
 
 /* fat/fatent.c */
 struct fat_entry {
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index d46d1a3851f25..6c833ed1affb3 100644
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
@@ -561,37 +561,24 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
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
+		/* Do not retry a write error reported for this buffer. */
+		rollback_err = fat_remove_entries_if_uptodate(new_dir, &sinfo);
 	}
-	if (corrupt < 0) {
+	if (rollback_err < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
 			     __func__, sinfo.i_pos);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index da3e89c0b16ac..898f98e4459d3 100644
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
@@ -1009,34 +1009,23 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
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
+		/* Do not retry a write error reported for this buffer. */
+		rollback_err = fat_remove_entries_if_uptodate(new_dir, &sinfo);
 	}
-	if (corrupt < 0) {
+	if (rollback_err < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
 			     __func__, new_i_pos);
@@ -1067,7 +1056,7 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 	struct inode *old_inode, *new_inode;
 	struct timespec64 ts = current_time(old_dir);
 	loff_t old_i_pos, new_i_pos;
-	int err, corrupt = 0;
+	int err, rollback_err = 0;
 	struct super_block *sb = old_dir->i_sb;
 
 	old_inode = d_inode(old_dentry);
@@ -1106,13 +1095,13 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
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
@@ -1135,24 +1124,17 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 
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

