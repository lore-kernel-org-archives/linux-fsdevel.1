Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D9480968
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948641; cv=none; b=rqojXMcXyXfcT9Z4mcgdIWvVNjVSeivWGdKLX2T2SNtrYZaGaXzWk7Qeq0HDIBY1JyaO1KdBM0lZCcOQ9STHpoQBdZCLcjqsx2iT8Ah6LvVxUH7Cp9d5/CDAghdGx4vuvHopc2vBst9IzAOytBj4nWqjLUnJ3fNC6c7UiQOBo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948641; c=relaxed/simple;
	bh=Nl2aWnpl9PJ0LxPZtRAvgWYfvRX7U1TdZDpmUGZ7ruU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gskOLpJ0GQoQaH7QVwHgR3oZI1dPWlt+13S1CZGx4j9/JG3IfVZOHp7d5HYL51ooVGVRKrOyIRYHg6Brsy6B3K63y0pI96NVHjThL7+iWucQAsfVw0HFowb10F93Qy/sIyAnD7yZ1ZNR0MluvDkD9tEwuU/ULkAmz1WnLKtd1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L52QjaNc; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L52QjaNc"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afe3b2383so2441305f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790948637; x=1791553437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mn+udfucuciyXQimcC48axZ4iQXC1W9g3f3Q40uLmHU=;
        b=L52QjaNc+3OqrDjXRbow3V0V5VVGQNjolELCe61S2DdEHAAsLRVkg4xJ80WN06fvLV
         deN6NKFPJD5CQ7AlcnM40Tz9i5mpCXWRfHiyvXw4QX0O/uR9/w9oGIfNdAEpQ8zITaqL
         mVoGMx4dnLelr5+r05LahwzNj8mMRQ5MrbK1bDgiVTw/uOSJK06zo1saYcochZfZb+9C
         d81d27CBua3U45lEPR96Zn5krAE22P6GOrYiYvVoRahsfapdd7eynX0brQwwaywCyqEi
         GqSGJXAVZd8fJz4iWhKWjeU+zr/3aiPWoa+ZEeTiGJ1UW7CRbP3OnE3lC6PbU2NVrPgC
         ad6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948637; x=1791553437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mn+udfucuciyXQimcC48axZ4iQXC1W9g3f3Q40uLmHU=;
        b=EeaQvi9pNQkjjBAyOmHWFoh5rbKbdRywceUx66Z8DOBa0dRRbk9S10ZM+N215JXxO1
         SXp4ir22h7vgd/i0u4W8WtPL/EruY3FyOxXvPmvwqTBRul8ZpY9WGHfB3mKiVHke0FZ4
         vA1ki7s0jbzBcCZtBq7flmrvp3XKYQKP1/7BY+40US6nQP8AfoTVPqJTyZgZAK1hEUFk
         qeQJwLzE+IPnot7CFcsFKr9rzoblYBptMgf/qZUSQiPea1QGPYU5dLlxp4TRI+8SAVYm
         /WCjaXDZDyokYtYZUthHeqJfrHR7wL4LZd8CHw/zj1mtqHvExLKQ3u0L8E5/wt1Vzq7j
         53fg==
X-Forwarded-Encrypted: i=1; AKwUvBw0c8zmE5kpAvHUXURWV11/UEKkON98n1PqabTxLa8CL4BNOCji7+9AAcIiuWRCo9JNMfAbzB8xmUH441LP@vger.kernel.org
X-Gm-Message-State: AFq9FYKeG9VKvhvLS2c+sweaxNtred4e0ng+nQKOhb/1pClJukoGPFpg
	d7KN7zzkgScSYXGyheEgn6s7jsJ1RWwfVHNhxB6dQQIOnZ7tju9U02W1
X-Gm-Gg: AYBFou345JzMCfHe+c9yERaKq8P0xVSlLwDbnc4rbUAQNXxkcobON/8Be/EpOGjUTGr
	VW8aBp2KWFAkQXYRhqIQeyOFGOGNf9TAO93637XqsT+I27fkHGDPC3h1xCT5KvCOfX9ClFdTaYR
	p7MoIJJ2VodRILrsF7N4TX0IllvwCrwTWL1UtYYFrWdtRYJqsMjxRFSbIbKXDJZPMrWJ5T59xsn
	NKpAd5Nqbuxw3Ap4pAay50gfex2QZEPrTboO9Lz1JRfdNBb8sCcmqrmBOLp9lTcm4/yccOcwjXb
	6qCidVUezzpWW3LYeQRpySENlgPhqWTan3543DOVQtEzxPamJL2Xol+4L4OhiW3XzkM2D+RIdgM
	iJhkZDpZx7al3WUnyF5i1lH+FfHXB/aCjM/48pRoBjg31d+S1OA1IBmXohOT9fATdzrFTq2FwtG
	R52dRNQDG/J3SfWqKKzLf120miTqGg9+vx/qg61NigbbQ7jNhU55AGAw1hK+82d07nzcn1IS2yU
	a/byRwjYxRmEV6QEBTDhnd/JjBXeTNzkMCQLw6vMNhGxNBDk4rz1Qbv84LokgRXXds5BXdA5Cf/
	5HZNTyw/TM4ppJJfwBVwXZuUiQSOdg/SXI5xXq5wxhHV68t27DJGm1T6/wrVUnLlMyciziFlU1o
	Q4ll0F/tPtLpLPgAq9HM9TEhWftLn
X-Received: by 2002:a05:6000:2613:b0:48a:f509:c22a with SMTP id ffacd0b85a97d-48b1256b860mr5488351f8f.0.1790948637088;
        Fri, 02 Oct 2026 06:43:57 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104f89sm6381538f8f.30.2026.10.02.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:43:56 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: [PATCH v2] fat: skip rename rollback on buffers with failed I/O
Date: Fri,  2 Oct 2026 15:43:48 +0200
Message-ID: <1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87ld8j4161.fsf@mail.parknet.co.jp>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com> <20260929090029.742579-1-krystianmkaniewski@gmail.com> <87ld8j4161.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A synchronous directory-entry write can fail after clearing BH_Uptodate.
The rename error path then attempts rollback by modifying and dirtying the
same buffer. mark_buffer_dirty() warns on the resulting !buffer_uptodate
buffer, and retrying the write cannot repair the underlying I/O failure.

Once a synchronous update fails, record whether the new entry shares that
buffer and do not touch it again. Before fat_remove_entries() releases the
old-entry buffer, record aliases so later failures also avoid rolling back
through it. For RENAME_EXCHANGE, restore the first ".." update only when it
does not share the buffer on which the second update failed.

Keep the existing forced synchronous MS-DOS rollback when it targets a
different buffer. For skipped rollbacks, retain the original error and
report filesystem corruption through fat_fs_error().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes in v2:
- Avoid buffer locking and waiting in the normal update path, as suggested
  by OGAWA Hirofumi.
- Give up rollback after a synchronous failure on the affected buffer.
- Track buffer aliases before fat_remove_entries() releases the old buffer.
- Keep forced synchronization for an MS-DOS rollback on another buffer.

 fs/fat/namei_msdos.c | 28 ++++++++++++++++++++-----
 fs/fat/namei_vfat.c  | 50 +++++++++++++++++++++++++++++---------------
 2 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index d46d1a3851f25..079f8bb61647f 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -441,6 +441,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
+	bool dotdot_in_old_bh, new_in_old_bh;
+	bool new_bh_failed = false;
 	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
@@ -532,14 +534,20 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 				      &MSDOS_I(old_inode)->i_metadata_bhs);
 		if (IS_DIRSYNC(new_dir)) {
 			err = sync_dirty_buffer(dotdot_bh);
-			if (err)
-				goto error_dotdot;
+			if (err) {
+				corrupt = err;
+				new_bh_failed = sinfo.bh == dotdot_bh;
+				goto error_inode;
+			}
 		}
 		drop_nlink(old_dir);
 		if (!new_inode)
 			inc_nlink(new_dir);
 	}
 
+	/* Remember aliases before fat_remove_entries() releases the buffer. */
+	dotdot_in_old_bh = dotdot_bh == old_sinfo.bh;
+	new_in_old_bh = sinfo.bh == old_sinfo.bh;
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
 	if (err)
@@ -564,12 +572,22 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 error_dotdot:
 	/* data cluster is shared, serious corruption */
 	corrupt = 1;
+	if (dotdot_in_old_bh || new_in_old_bh) {
+		/* Give up rollback on the buffer whose write failed. */
+		corrupt = err;
+		new_bh_failed = new_in_old_bh;
+	}
+
+	if (update_dotdot && !dotdot_in_old_bh) {
+		int dotdot_err;
 
-	if (update_dotdot) {
 		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
 		mmb_mark_buffer_dirty(dotdot_bh,
 				      &MSDOS_I(old_inode)->i_metadata_bhs);
-		corrupt |= sync_dirty_buffer(dotdot_bh);
+		dotdot_err = sync_dirty_buffer(dotdot_bh);
+		corrupt |= dotdot_err;
+		if (dotdot_err && sinfo.bh == dotdot_bh)
+			new_bh_failed = true;
 	}
 error_inode:
 	fat_detach(old_inode);
@@ -581,7 +599,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 			mark_inode_dirty(new_inode);
 			corrupt |= sync_inode_metadata(new_inode, 1);
 		}
-	} else {
+	} else if (!new_bh_failed) {
 		/*
 		 * If new entry was not sharing the data cluster, it
 		 * shouldn't be serious corruption.
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index da3e89c0b16ac..b6a32f39a6f88 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -938,6 +938,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
+	bool dotdot_in_old_bh, new_in_old_bh;
+	bool new_bh_failed = false;
 	int err, is_dir, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
 
@@ -983,13 +985,19 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (dotdot_de) {
 		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
 					    dotdot_de);
-		if (err)
-			goto error_dotdot;
+		if (err) {
+			corrupt = err;
+			new_bh_failed = sinfo.bh == dotdot_bh;
+			goto error_inode;
+		}
 		drop_nlink(old_dir);
 		if (!new_inode)
  			inc_nlink(new_dir);
 	}
 
+	/* Remember aliases before fat_remove_entries() releases the buffer. */
+	dotdot_in_old_bh = dotdot_bh == old_sinfo.bh;
+	new_in_old_bh = sinfo.bh == old_sinfo.bh;
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
 	old_sinfo.bh = NULL;
 	if (err)
@@ -1012,10 +1020,19 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 error_dotdot:
 	/* data cluster is shared, serious corruption */
 	corrupt = 1;
+	if (dotdot_in_old_bh || new_in_old_bh) {
+		/* Give up rollback on the buffer whose write failed. */
+		corrupt = err;
+		new_bh_failed = new_in_old_bh;
+	}
 
-	if (dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
-						 dotdot_de);
+	if (dotdot_de && !dotdot_in_old_bh) {
+		int dotdot_err = vfat_update_dotdot_de(old_dir, old_inode,
+						       dotdot_bh, dotdot_de);
+
+		corrupt |= dotdot_err;
+		if (dotdot_err && sinfo.bh == dotdot_bh)
+			new_bh_failed = true;
 	}
 error_inode:
 	fat_detach(old_inode);
@@ -1026,7 +1043,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			mark_inode_dirty(new_inode);
 			corrupt |= sync_inode_metadata(new_inode, 1);
 		}
-	} else {
+	} else if (!new_bh_failed) {
 		/*
 		 * If new entry was not sharing the data cluster, it
 		 * shouldn't be serious corruption.
@@ -1105,14 +1122,18 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 	if (old_dotdot_de) {
 		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
 					    old_dotdot_de);
-		if (err)
-			goto error_old_dotdot;
+		if (err) {
+			corrupt = err;
+			goto error_exchange;
+		}
 	}
 	if (new_dotdot_de) {
 		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
 					    new_dotdot_de);
-		if (err)
-			goto error_new_dotdot;
+		if (err) {
+			corrupt = err;
+			goto error_old_dotdot;
+		}
 	}
 
 	/* if cross directory and only one is a directory, adjust nlink */
@@ -1135,14 +1156,9 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 
 	return err;
 
-error_new_dotdot:
-	if (new_dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
-						 new_dotdot_bh, new_dotdot_de);
-	}
-
 error_old_dotdot:
-	if (old_dotdot_de) {
+	/* Both entries may share the buffer whose write failed. */
+	if (old_dotdot_de && old_dotdot_bh != new_dotdot_bh) {
 		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
 						 old_dotdot_bh, old_dotdot_de);
 	}

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

