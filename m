Received: from mail-ej2-f20.google.com (mail-ej2-f20.google.com [74.125.228.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C83603EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672441; cv=none; b=Z54V3Y75Yom6s5yxXh+NuQFioNH0b9OREHetg9sW6050PdaJFQY3AdpoYFpmuhe+Y/ytmjjH5ZsD3mfqDz7b57ZKGwQWwDWfX+sK5ZPJTIdpv/iXLiC6ZHECAu3yZ92yAL4ifSpu6ifE0L2M6r+GirsY1bhRDy41gtqMVwHQqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672441; c=relaxed/simple;
	bh=bQA5o9AqXzJwW4CulCIQr+JTNGnfWLy+R04SGuzJykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYMDoVXE07xWcFkBGcVt4MXfDL38QJ+Xco43UEhvZRDlcGYnTxsW5e0yCkxaR5PTXc6u6/6ZzYRC1utbWxnG/RiHl0noqhz9fEcC785ZwrIc+Od539MKDy9jMUgrVu8aOP0sfMxo0hYJ7zVwvN/yWPN+MEW5eoN831iKlCbbVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqd/CQBJ; arc=none smtp.client-ip=74.125.228.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqd/CQBJ"
Received: by mail-ej2-f20.google.com with SMTP id a640c23a62f3a-c293c683202so567668166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790672438; x=1791277238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEcK1L0L4Llql2vChYhSAW1uTFo7IcbEPKL8xbGwNtM=;
        b=Xqd/CQBJIWkGWzIu67eMt/Xr1cLpBJ6tmpTYzUIWJWuRJwk5Z4cjnNHaFNKZuj136t
         5SmFUIQdEbHxtuSiSpOvJzJn+Tbf9DuW/KimcrZukyXT1tRERPDctaLn/Gc3QhU4BzSQ
         W73bodiyTMz0/v0o1BT+c68Z+Fq7N6rCra0l5zCjkSQ2tTqGRtmk5Nj/BSgGoEbtIews
         nXlKLSZR2UO9AHuMMyJGFke6eh7RgCxNzO1RXt6cHtoPbeljpwfMreSoQBxJZg7+PQk+
         FtOtol0bX01ia8CBeqE8nX17fJvVlfnJ3bRLlTfSAuxMEAuCDHDIjjJactIWI4+VTB7k
         C5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672438; x=1791277238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEcK1L0L4Llql2vChYhSAW1uTFo7IcbEPKL8xbGwNtM=;
        b=TkivzsxnOrasghfabyIxVi9CnTZbATCQBnXLW6MEbc/kDBZ7eyeRwLA9nRbOOMImTE
         9il2CQE5AOB7QmCJh5vRI7Rgo3c9KTgmXoEBKRq78nZL5bq4GHPqNhBKiDx3ESZYRLdG
         8/q+pjH4fwuqqW/YuI8S/Vf6VRhYXfq2/oKfc9S2n2cDv1DhCJBYj0h8Sa7wXNAXSY9a
         mI8IldLE7u5C3NiYArbC+oaWnb3vg9GfsqAqGTdHkcL6OM3u1WpaMefeCi4yVqfIJsRk
         yU2oLLsNX4PquqwIAsGn4bOZjvrX8pwPGmsS/j0Uo4kp7DNhoRdgch1URyVZQRNLkbr8
         6w1g==
X-Forwarded-Encrypted: i=1; AKwUvByWl1B/NjN6XZB1DcamVpdtpFyJk67RiBBMiCCHVfD9vjmw91yQP+wFMWfin+ZJSSs6r59ZMvEaHKpdGNaQ@vger.kernel.org
X-Gm-Message-State: AFuF++nUjuewalScEV9B+6temWSKdcqFFGgR18qj/faOZju9FFMW/3Sy
	3EGNXng4esQKEdi1OnYzM6MXgOCnaehnvrSBtJnFXdrwYbFQjSksxvTJ
X-Gm-Gg: AYBFou1r4+D3P4xnjBCLdxWwREOdsgoTZG8I4J9sdXFM6bfTFaMrKO742+f5zZOpkYZ
	y1fSpEgSrtgaBL7xZkcCbnWXACjJaWob08S0fO3kKN8WBR4mJ4hUNG0mkE+xN9J98ClsS9HwAXg
	JZAfO/lC7R+L+NeD7QoW7bxmvZ/YFTBE6T6Q6lvTZGl5ft6QMFq2witMLWdqq6h7ULapQi43TOe
	aMYICP49ZMSzWBmMqbzf+yGGPZvVHoZBQAQ9BaX8f4+Vl9uVGcCvRA27yrZZHWHTx6Y2w0ZUsVr
	r/y5IPb952enbiyyg1G5xbT3+5Yt7exz2hlP7iGuqCbC6iKEf5PXjvL70ALmA47u0/q3uGxYUeC
	i/tFKoXC2bqhkH403qGEIYY3q7uGCH/oH/iV5BYMB2WcsfAvBs1GHO1Izbn8G6D2r0AhQ+b87gs
	ItaPJA29RBitKEIvWBprL8sJ+LaSaiclxO0wXOoz5wpOpzlEFNc0tYFps8PjGEZ/CMMInd8g0M5
	WvHsQWIxkc6LQcdfzJlnjX+V5SHfxbqhHA2OS8MbfZ7k5T9Rw353Y0Akv5Mg9hJ1B48oa9j0P79
	zcdQw9M5Z2I+iLPJhGBcA4+5VHw7P8eR5Wk9lJkCA2Gl3ylieDQ4KSEeLda4lHHPrl5ygYpyKpe
	n0xDg8mdPndX0bmOPjIZSPGF7rsPg3N+hcXu67rU=
X-Received: by 2002:a17:907:d409:b0:c2a:6bee:77c9 with SMTP id a640c23a62f3a-c2ae97a1007mr896070366b.4.1790672437498;
        Tue, 29 Sep 2026 02:00:37 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae77be187sm594314466b.46.2026.09.29.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:00:37 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: [PATCH] fat: validate dotdot buffers in VFAT and MSDOS rename and rollback
Date: Tue, 29 Sep 2026 11:00:28 +0200
Message-ID: <20260929090029.742579-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During cross-directory rename operations with synchronous directory updates
enabled in VFAT and MSDOS, updating the ".." directory entry writes the
buffer via sync_dirty_buffer(). If this write fails due to an I/O error,
the block layer clears the BH_Uptodate flag. When rename enters its error
rollback path, it attempts to update the ".." directory entry again with
the same buffer head, which calls mmb_mark_buffer_dirty() and triggers a
"!buffer_uptodate(bh)" warning in mark_buffer_dirty().

Fix this by introducing fat_update_dotdot_de() and
fat_sync_update_dotdot_de() in fs/fat/dir.c, used by both VFAT and MSDOS
cross-directory rename and rollback paths. The helpers lock the buffer head
and check buffer_uptodate() before modifying the entry. If the buffer is
not uptodate, unlock it and return -EIO, preventing mmb_mark_buffer_dirty()
from being called on a non-uptodate buffer. fat_sync_update_dotdot_de()
preserves the unconditional buffer sync in the MSDOS rename rollback path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Gemini:gemini-3.8-flash syzbot
Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
Link: https://syzkaller.appspot.com/ai_job?id=f915c371-eb83-48b9-af21-45cf1fd21ba0
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>

---
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 35bdb6294..cee06e635 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -941,6 +941,40 @@ int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 }
 EXPORT_SYMBOL_GPL(fat_get_dotdot_entry);
 
+static int __fat_update_dotdot_de(struct inode *dir, struct inode *inode,
+				  struct buffer_head *dotdot_bh,
+				  struct msdos_dir_entry *dotdot_de,
+				  bool force_sync)
+{
+	lock_buffer(dotdot_bh);
+	if (!buffer_uptodate(dotdot_bh)) {
+		unlock_buffer(dotdot_bh);
+		return -EIO;
+	}
+	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
+	mmb_mark_buffer_dirty(dotdot_bh, &MSDOS_I(inode)->i_metadata_bhs);
+	unlock_buffer(dotdot_bh);
+	if (force_sync || IS_DIRSYNC(dir))
+		return sync_dirty_buffer(dotdot_bh);
+	return 0;
+}
+
+int fat_update_dotdot_de(struct inode *dir, struct inode *inode,
+			 struct buffer_head *dotdot_bh,
+			 struct msdos_dir_entry *dotdot_de)
+{
+	return __fat_update_dotdot_de(dir, inode, dotdot_bh, dotdot_de, false);
+}
+EXPORT_SYMBOL_GPL(fat_update_dotdot_de);
+
+int fat_sync_update_dotdot_de(struct inode *dir, struct inode *inode,
+			      struct buffer_head *dotdot_bh,
+			      struct msdos_dir_entry *dotdot_de)
+{
+	return __fat_update_dotdot_de(dir, inode, dotdot_bh, dotdot_de, true);
+}
+EXPORT_SYMBOL_GPL(fat_sync_update_dotdot_de);
+
 /* See if directory is empty */
 int fat_dir_empty(struct inode *dir)
 {
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 61338413d..d51d3c11e 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -339,6 +339,12 @@ extern int fat_scan_logstart(struct inode *dir, int i_logstart,
 			     struct fat_slot_info *sinfo);
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 				struct msdos_dir_entry **de);
+extern int fat_update_dotdot_de(struct inode *dir, struct inode *inode,
+				struct buffer_head *dotdot_bh,
+				struct msdos_dir_entry *dotdot_de);
+extern int fat_sync_update_dotdot_de(struct inode *dir, struct inode *inode,
+				     struct buffer_head *dotdot_bh,
+				     struct msdos_dir_entry *dotdot_de);
 extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
 extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			   struct fat_slot_info *sinfo);
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index d46d1a385..31faaeae8 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -527,14 +527,10 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	}
 
 	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(new_dir)->i_logstart);
-		mmb_mark_buffer_dirty(dotdot_bh,
-				      &MSDOS_I(old_inode)->i_metadata_bhs);
-		if (IS_DIRSYNC(new_dir)) {
-			err = sync_dirty_buffer(dotdot_bh);
-			if (err)
-				goto error_dotdot;
-		}
+		err = fat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
+					   dotdot_de);
+		if (err)
+			goto error_dotdot;
 		drop_nlink(old_dir);
 		if (!new_inode)
 			inc_nlink(new_dir);
@@ -565,12 +561,9 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	/* data cluster is shared, serious corruption */
 	corrupt = 1;
 
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
-		mmb_mark_buffer_dirty(dotdot_bh,
-				      &MSDOS_I(old_inode)->i_metadata_bhs);
-		corrupt |= sync_dirty_buffer(dotdot_bh);
-	}
+	if (update_dotdot)
+		corrupt |= fat_sync_update_dotdot_de(old_dir, old_inode,
+						     dotdot_bh, dotdot_de);
 error_inode:
 	fat_detach(old_inode);
 	fat_attach(old_inode, old_sinfo.i_pos);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index da3e89c0b..56da78455 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -909,16 +909,6 @@ static int vfat_sync_ipos(struct inode *dir, struct inode *inode)
 	return 0;
 }
 
-static int vfat_update_dotdot_de(struct inode *dir, struct inode *inode,
-				 struct buffer_head *dotdot_bh,
-				 struct msdos_dir_entry *dotdot_de)
-{
-	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
-	mmb_mark_buffer_dirty(dotdot_bh, &MSDOS_I(inode)->i_metadata_bhs);
-	if (IS_DIRSYNC(dir))
-		return sync_dirty_buffer(dotdot_bh);
-	return 0;
-}
 
 static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
 {
@@ -981,8 +971,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto error_inode;
 
 	if (dotdot_de) {
-		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
-					    dotdot_de);
+		err = fat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
+					   dotdot_de);
 		if (err)
 			goto error_dotdot;
 		drop_nlink(old_dir);
@@ -1014,8 +1004,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	corrupt = 1;
 
 	if (dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
-						 dotdot_de);
+		corrupt |= fat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
+						dotdot_de);
 	}
 error_inode:
 	fat_detach(old_inode);
@@ -1103,14 +1093,14 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 
 	/* update ".." directory entry info */
 	if (old_dotdot_de) {
-		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
-					    old_dotdot_de);
+		err = fat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
+					   old_dotdot_de);
 		if (err)
 			goto error_old_dotdot;
 	}
 	if (new_dotdot_de) {
-		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
-					    new_dotdot_de);
+		err = fat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
+					   new_dotdot_de);
 		if (err)
 			goto error_new_dotdot;
 	}
@@ -1137,14 +1127,14 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 
 error_new_dotdot:
 	if (new_dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
-						 new_dotdot_bh, new_dotdot_de);
+		corrupt |= fat_update_dotdot_de(new_dir, new_inode,
+						new_dotdot_bh, new_dotdot_de);
 	}
 
 error_old_dotdot:
 	if (old_dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
-						 old_dotdot_bh, old_dotdot_de);
+		corrupt |= fat_update_dotdot_de(old_dir, old_inode,
+						old_dotdot_bh, old_dotdot_de);
 	}
 
 error_exchange:

base-commit: 93f51579e7df248780214094418f205253383cc5
