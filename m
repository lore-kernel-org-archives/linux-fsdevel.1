Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629821;
	b=WyCj2PY7R5jf7WLWZu0vjHT/dHV9BWiEDv1L5bmUlf7AtQ9/1yWKH6OZ9dT7Ru0kwKTg
	 VusnpAjNOHlYh3l9ZLBm5Z0v1AfqR3eUnaWuElMlyksvyvufLJPduG8NlKCSyktqo1cDs
	 7qhbMyol5vgTiBmr2+QU6N01y9GUnuHsB6O7yUDWYuND+JvTBgJ13eK2pr5M34m+HjL0W
	 S3r/ZsG3x5tiY+e3rx6NkgdskF1HuxJWwaSwtHVqnf48tPVDpyrXBBI1Jcp+y7zQJ3GWA
	 bVpokRYhaqT4koulNiOJ37KS+NDKbQ3iLuhVSi9he3X3/uXRLmV0LCbR2uCuxZNNTpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mXHogYunGIIHp13OaEAp6oxEyB+S12eFq5Vq8y+h0aU=;
	b=WrKG+d9+fZ3sR2LYmg9Bsr44n5dx6QrocskK0i78PRUVM6qXANp5vdUkLmag/DQTWavs
	 85XdV8a759+5LeDOco6soTlLAL+bc2iDJ8nUh/+Gef4cPUprGB6rfJtWrHdg5oNJ/RLEY
	 mLb2PAwfo3EBSZmmjkeVGmlKaXvXGVAFQa1fzPu9Z6o7kRt8nxpYiPM+A2fwoLSp8nazp
	 gBNGBusO5RIufKCIEvLSgmiwJGzNVkiIfSYbZtG1/N6fSqJ6naniD1OlEFtHxeAhcJFFg
	 tw1qvCLxTmRFNoeSycqCSBAq929gFIATvIZcV6H6oXDKPZ8WF5DobGzTZ3oh49nr0pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="sZXSqb/z";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDC6070C80
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 14:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EDDC6070C80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sZXSqb/z
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so24918955e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 06:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793629819; x=1794234619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXHogYunGIIHp13OaEAp6oxEyB+S12eFq5Vq8y+h0aU=;
        b=sZXSqb/zq/KtwCmum70LI7SsdTCOJhUSRW7CLlkB8I8qrCYZbZharyt10TdSEHjDIV
         PjJuK0Waj81QyKbY8ysdoEcc79TDQvj5fdfvcANR/A75x09VJsGJznFw7RGvot/3u7i0
         7/uWXQRnBTCruuS95FR1eTdRMRCrbdJaXE1XDEtMPArDMlOXQR/0smpsZgBw7vnGn820
         FD8V65XulM/XcuEIn6ZLg2Cc28kTS9bWozjU0HTSJgmYeWpkKK6GZ4hE8fnvP+cUfK2o
         wuwECoRkrktIQYbWb572tG3ieEwykqfb6bBCkJRuBZTTD7kxo6HdPXxh0Dl5BYq6fQjO
         2Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629819; x=1794234619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXHogYunGIIHp13OaEAp6oxEyB+S12eFq5Vq8y+h0aU=;
        b=Tb9INMv8ScO36O0fkKhC395wSysx2PeyLuQdqTGiWwzYZFc61LoIcKF90j0V+n3oGY
         HQ4d88NHnFIFF2rkaFFA+JV4agZ3Xx509fBURFWng/6J3RqOp4B+0PkFW1RIu3HIZkXy
         TQWqGS7pC7x2cxIoY/5IoSiZDLZdDrUQ1pfB8X27gHX/9GGhyBAyWcj1tCV54Ff/PhjY
         1LWbJlNdE7Qbzxoc4UpB61Mpv4gZVwlgPdYiVVfEw/SPhe41IoJGN1FnJ8JAlaaeX6ED
         mhso9Qs30ZxA5gpROAeBBl7g3dzgtisPvbEaOpoAJ1i1mBoSVr/KT+Cj0HHdB1A3tCJl
         HSJA==
X-Forwarded-Encrypted: i=1; AKwUvBxElrdGOCF9hXRc1G23PKc41Xf5nB6g20OEXPcBXNtLj2At/Aw/JCr8Q7pHOtg9qusHWOSX9dumtc0zT0rk@vger.kernel.org
X-Gm-Message-State: AFq9FYJDeTk+mAfEbc6Ra1zh5UNdLR0rTcxMYMWtPcLN7CeQXJGjVCJ3
	UfUs2hPG5ROvfRvE0eGOzwniCRkD9+vZUHpckad/Fg5j9iqauLrdzoCWwRxD3JbrHp+LBA==
X-Gm-Gg: AYBFou0DCE0Zf+YAa3yZqdnyjRm+9PctRaSc/8TfYtvzMnj7yeiU4YPQ6FBJVnboQ6X
	ctnRxi2/kxQRW30bI21OtZX1D2bDjxf0OsynQq4Q4x7H8ovv2YJc60pA1xI3eiOufvoJfrVZ739
	vaijKgW7Ak7sf99ka9ER3pkY3eF9L0WV3D6wZV/kAnRxOLCTzq6oVs+cAGewY+ZEwHX2/EH+sdr
	KPu8aFfdvAKYn5Qqikz3pK87igsEQpPaDyNqf6HviEMGq6KFtgpPt4xjNkg4EeleBtUtQjY1HkK
	HWJDLg+zvrEpIals3pyzDvmtuYidiOnQqWhITjnAYYBMw8K7DBxr+icFWjVgnZv1OKdwNrmUKPT
	Z23Imty5GhnRq0uIJdRLjwxFghA0p8okeCp5V9vLfw+dccESzORyxKojAR6DuVFRBqUi2VOMFsG
	xmV0ezD6LdTh4RYGSZ/xgp5iTgGMlN3/yCnvaxMENx0jooLwF+gc7z79cfYy0M1q5OQuPvv+KE/
	+/kLVA+0RiR08pts0MUlmdcscGZYEapiGnF50ST0mpBXp7vLw3ebFOYYcNv4p40FIdrM1tzP+Am
	m10J425YueO3Jd2HXehr837GdU1b3bk71GV9qreBp2Q9g5qn5imKuX4yl8wVGciFQo4ZLQBIo58
	0MEORe93z8NMIGm2KgSjDKH1w0YDZZEdrOJlpL5ta1NF5qJ7dMEhs6QSEjepCWneX88jjs5ip6Z
	SjT/Fa18rr4v6jRQ1pC5sj71I+U2npH6nvg+prLld3bEf1XadKsVc=
X-Received: by 2002:a05:600c:e555:10b0:4b2:61e5:b2f4 with SMTP id 5b1f17b1804b1-4b261e5b38bmr7366625e9.11.1793629818800;
        Mon, 02 Nov 2026 06:30:18 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2640sm344739885e9.6.2026.11.02.06.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:30:18 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: [PATCH v5] fat: make rename recovery safe after metadata write errors
Date: Mon,  2 Nov 2026 15:30:11 +0100
Message-ID: <20261102143013.492650-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2ba329a1-ad8c-4b6a-8dd6-1f93c85224c0@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com> <20260929090029.742579-1-krystianmkaniewski@gmail.com> <87ld8j4161.fsf@mail.parknet.co.jp> <1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com> <87bj90m6dq.fsf@mail.parknet.co.jp> <20261014082315.190262-1-krystianmkaniewski@gmail.com> <87qzhqvloo.fsf@mail.parknet.co.jp> <55a1f016-a7a2-469f-b481-37223d695f29@gmail.com> <87cxt921rc.fsf@mail.parknet.co.jp> <f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com> <875wz11xfg.fsf@mail.parknet.co.jp> <c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com> <878q3uhv4h.fsf@mail.parknet.co.jp> <20261019145146.539233-1-krystianmkaniewski@gmail.com> <87wlrdy8ch.fsf@mail.parknet.co.jp> <2ba329a1-ad8c-4b6a-8dd6-1f93c85224c0@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed synchronous FAT metadata write clears BH_Uptodate. Rename
recovery can then modify and dirty the same retained buffer, which
triggers the !buffer_uptodate warning in mark_buffer_dirty().

Check the retained buffers in the rename error paths and skip only the
recovery step whose buffer is no longer uptodate. The other steps run as
before, including the rollback after a failed source-entry removal,
where only the source-entry buffer failed. VFAT keeps no slot
information for a replaced entry. Resolve its saved position with a
cache-only lookup before dirtying the inode, because FAT inode
writeback would otherwise reread and retry a failed block.

For exchange, do not rewrite the dotdot buffer whose write failed,
restore an earlier dotdot update only while its buffer is uptodate, and
restore both inode positions as before. A skipped step is reported as
filesystem corruption, and the original error is returned.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes in v5:
- Check buffer_uptodate() directly in the rename error paths and drop the
  helper and the buffer lock of v4.
- Skip only the recovery step of a buffer that is no longer uptodate and
  keep the rest of the existing recovery, also after a failed dotdot write
  and in exchange.
- Keep the existing rollback after a failed source-entry removal. The reply
  to v4 proposed stopping there, but fat_remove_entries() fails only when
  the old_sinfo buffer write fails, so the source entry is still in place.
  Stopping left an invalid ".." entry and shared clusters in my tests,
  while the existing rollback leaves the filesystem clean.
- Look up the cached VFAT target entry block from its inode position,
  because that path has no slot information.
- Clarify the recovery-state comments without changing behavior.

v4: https://lore.kernel.org/all/20261019145146.539233-1-krystianmkaniewski@gmail.com/

 fs/fat/namei_msdos.c | 18 ++++++++++++----
 fs/fat/namei_vfat.c  | 50 +++++++++++++++++++++++++++++++-------------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index d46d1a3851f25f..51d49a3ca93c14 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -562,14 +562,20 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	return err;
 
 error_dotdot:
-	/* data cluster is shared, serious corruption */
+	/*
+	 * Complete the remaining rollback. Report corruption only if a
+	 * recovery step cannot be completed.
+	 */
 	corrupt = 1;
 
-	if (update_dotdot) {
+	/* A failed sync write clears BH_Uptodate, leave that buffer alone. */
+	if (update_dotdot && buffer_uptodate(dotdot_bh)) {
 		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
 		mmb_mark_buffer_dirty(dotdot_bh,
 				      &MSDOS_I(old_inode)->i_metadata_bhs);
 		corrupt |= sync_dirty_buffer(dotdot_bh);
+	} else if (update_dotdot) {
+		corrupt = err;
 	}
 error_inode:
 	fat_detach(old_inode);
@@ -577,11 +583,13 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	MSDOS_I(old_inode)->i_attrs = old_attrs;
 	if (new_inode) {
 		fat_attach(new_inode, new_i_pos);
-		if (corrupt) {
+		if (corrupt && buffer_uptodate(sinfo.bh)) {
 			mark_inode_dirty(new_inode);
 			corrupt |= sync_inode_metadata(new_inode, 1);
+		} else if (corrupt) {
+			corrupt = err;
 		}
-	} else {
+	} else if (buffer_uptodate(sinfo.bh)) {
 		/*
 		 * If new entry was not sharing the data cluster, it
 		 * shouldn't be serious corruption.
@@ -590,6 +598,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		if (corrupt)
 			corrupt |= err2;
 		sinfo.bh = NULL;
+	} else {
+		corrupt = err;
 	}
 	if (corrupt < 0) {
 		fat_fs_error(new_dir->i_sb,
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index da3e89c0b16ac8..31f9882f0a9ffe 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1010,12 +1010,18 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 
 error_dotdot:
-	/* data cluster is shared, serious corruption */
+	/*
+	 * Complete the remaining rollback. Report corruption only if a
+	 * recovery step cannot be completed.
+	 */
 	corrupt = 1;
 
-	if (dotdot_de) {
+	/* A failed sync write clears BH_Uptodate, leave that buffer alone. */
+	if (dotdot_de && buffer_uptodate(dotdot_bh)) {
 		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
 						 dotdot_de);
+	} else if (dotdot_de) {
+		corrupt = err;
 	}
 error_inode:
 	fat_detach(old_inode);
@@ -1023,10 +1029,27 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (new_inode) {
 		fat_attach(new_inode, new_i_pos);
 		if (corrupt) {
-			mark_inode_dirty(new_inode);
-			corrupt |= sync_inode_metadata(new_inode, 1);
+			struct buffer_head *target_bh;
+			sector_t blocknr;
+			int offset;
+
+			/*
+			 * A replaced entry has no slot info. Use its saved
+			 * position for a cache-only lookup so recovery does
+			 * not reread a failed block.
+			 */
+			fat_get_blknr_offset(MSDOS_SB(sb), new_i_pos,
+					     &blocknr, &offset);
+			target_bh = sb_find_get_block_nonatomic(sb, blocknr);
+			if (target_bh && buffer_uptodate(target_bh)) {
+				mark_inode_dirty(new_inode);
+				corrupt |= sync_inode_metadata(new_inode, 1);
+			} else {
+				corrupt = err;
+			}
+			brelse(target_bh);
 		}
-	} else {
+	} else if (buffer_uptodate(sinfo.bh)) {
 		/*
 		 * If new entry was not sharing the data cluster, it
 		 * shouldn't be serious corruption.
@@ -1035,6 +1058,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (corrupt)
 			corrupt |= err2;
 		sinfo.bh = NULL;
+	} else {
+		corrupt = err;
 	}
 	if (corrupt < 0) {
 		fat_fs_error(new_dir->i_sb,
@@ -1106,13 +1131,13 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
 					    old_dotdot_de);
 		if (err)
-			goto error_old_dotdot;
+			goto error_dotdot;
 	}
 	if (new_dotdot_de) {
 		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
 					    new_dotdot_de);
 		if (err)
-			goto error_new_dotdot;
+			goto error_dotdot;
 	}
 
 	/* if cross directory and only one is a directory, adjust nlink */
@@ -1135,14 +1160,9 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
 
 	return err;
 
-error_new_dotdot:
-	if (new_dotdot_de) {
-		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
-						 new_dotdot_bh, new_dotdot_de);
-	}
-
-error_old_dotdot:
-	if (old_dotdot_de) {
+error_dotdot:
+	corrupt = err;
+	if (old_dotdot_de && buffer_uptodate(old_dotdot_bh)) {
 		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
 						 old_dotdot_bh, old_dotdot_de);
 	}

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

