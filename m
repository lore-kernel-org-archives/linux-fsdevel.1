Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A733DDDCF
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249664; cv=none; b=gSJBmXcLLbyIoZbdX5JcabN+NEo2Iy7x038qSPXIh5b3WCE10KzCIOoklQ/lcKTxf8bukE8zGlSYEjYVdVZRdhZ/tQoV9FRrWpNnVtytH2C3rm5OaxNj+BErcYXnx9bZGJJ8r7O81XU6OJ5SZv5SB7waQwkFzxuGJlULAckgygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249664; c=relaxed/simple;
	bh=KqSqilY0ijZFreMZbLAoYl/M5mFXulOq1pM6ojshWJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCdLO/R+OYZb2JbV9ZyP5/pRpdPfX7HyxTrow2gzuoeLcpa0ZsOeqUXqF44Ld/HomWluADYbpiwTr/Ns90KvGjMS+k94UbrKQyMu4x5EwerPcLESMK8I2F2uOecvIQgleQlBfXgcQWktwWaI2QE6OYw74lJoheHuwON3LX84sS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrBz2m11; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrBz2m11"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422871b42dso460471b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249662; x=1781854462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nop5N/hEOjU5X2276Pe6qrUkwLZI0X0UM3t8w9tHFEo=;
        b=lrBz2m11hBAm/lNi8Ca/QMsHqZZ+maryKLIlw95j0js1XVF4K2rzWN493D4/vUjHZC
         7ucStHdxKJS4gCjvd5CyHkVr8Rvty7nSKieW8raFAw+wTFB43JSJOEoa2l1N7LWaiYgF
         l/u4HckSzDglJZ+vBKFYud3CCnZiyUF62SIoddjbDWFBLsKVaHIBRinnZxKa9kdNUmlf
         Uy1WVqjxb2jGbHeT3a1cTse09bllCKMkqgmxc9SLN+a7HuPK9YJcSHLUJFp7IN2pgzYo
         wNGoUcQkAvHBLVapRRWYqzEBcqarxYcFbFJgolQTh+nVaKW3UtGfBd0xAB+6Q9nHIKEh
         eE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249662; x=1781854462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nop5N/hEOjU5X2276Pe6qrUkwLZI0X0UM3t8w9tHFEo=;
        b=Iz+Ugtq1c3hmwsjn9p9NYv8ApiAe5ZefaBb1oktFztv/XfxrNzpCPwhwtNR814gfm+
         VLcm+A8JYnCzquROArZEiMRL3tLICPQamWhkqYaNTAtIqPi2Rb9TUIGSQcTTHzaW/Pa5
         liOFcSOTN4gV3Wn+OU1SZ6U5s4z98wGyp+pIo+BVyx/aoH32YHZmVukWPmKxM3U2P2Hz
         3Zu2h44IjCoWAFgM0K68CQAJGqIIxFg/tWdqea91N1vmPvL82EYmjcx9FPSk0XIpe3bs
         HBA/F7FbbUtcg5N2nS/12VqVF+4MbAHd4ANOkGgHZoBCdvuGp2Ea2XUX2DEGaJJMG1wp
         8IgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+4O1Qz0bjtNAiLZDHNed+c+Cmbh2quW1BIy9fJW5YOhbwnvpnTKBXA0vgPkihIGwrBkC//eDJpBa5ZZ7c@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1ImcdowcgFLRLe0hUrX94UWOulOTXPPn87KxUL2ULqzHupgU
	7iz6KCATs1XIEPH6c40qg5s01OVHUK12JKJsEZ4VfqniBZn3eyeZ/X2K
X-Gm-Gg: Acq92OG9WAOTKqN56D3kav9QsWs9gzD89XWjhsSqOUWgkE025kqUVTWNwRFLI/Rvhf4
	kujEMJjZlk5L3eLCQ8SlAlF57yawUWOLm3YcD9UKXUUsGW/GMKBuZj/h8zX0HrIwqoTJc5rXO4d
	wX/dH6MqEsZCVBGmYWy/XOCefbcxhGKAGl1h37iXHPpDmPvMX6p9Fm+ORggFTZlXBGFurFsRtTA
	WvZ7RyBKTtNMArjl0S+hbl8zgUz5DI/XjTMfaHHoFnW2tS0XvqeiCY1tGKWO2tvNPDKp0TwE4Df
	zv6h0qRoFy9HGO3PHEzR1XHWqfFwDiS98MiwpQ+R7QvfYz+EvNYAXhd/8RA4GKqOTQ9t87MtvgH
	N0McI951xxAPQaSmR/PNpjqHCEnTsrlnEQO9bQk1qUmwd2D8u6e3rNUYbqgyqAK2DB7NKROwT3j
	G3QkscF4Gphkigdo2ZTvHIBwxq53ANTA==
X-Received: by 2002:a05:6a00:2e28:b0:835:45bf:9659 with SMTP id d2e1a72fcca58-8434cec4688mr1740685b3a.41.1781249662081;
        Fri, 12 Jun 2026 00:34:22 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:21 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ntfs: clean up target name conversion for WSL symlinks
Date: Fri, 12 Jun 2026 16:33:35 +0900
Message-ID: <20260612-topic-symlink-v1-5-cc1ebf9528e1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4863; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=KqSqilY0ijZFreMZbLAoYl/M5mFXulOq1pM6ojshWJI=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7XvitdcMXcmyhATQEC/yglTK3VcKtZA31w5l
 iaDzZuqO3iJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17wAKCRA08jD6945I
 08O1D/wLKeKElk0RPnP/d7z/9OrjwxA0mTPRT//wk//X1HiQEPV7fhIKIqP4RfM/Yxg6W+aUgiT
 58KtUB+GXrwm/W5lhQmK3K4kI5yIpbllrdxCDCK/aY7stwKAuf5FuY2eUGShSxne6d9NFOJDe2E
 qa5a0C8Z1rdoyGf4K53QVyilOeV/p76le2BfPifZaDD1LNY3VRBo3/ZmcqiK0jX84MRP07h876t
 jdIuRVGdWfVM5baXVQouMZrkSlDwSSq2t5SBj5mLKCifm9kL3jksdqslyuv9UZXowIc16IrSRhB
 AHO1B5fGZIPcMVftKxI0pE0sonBf4v7kiWauj5JegrW4mEmhkoLL6U7v04fWu1ozQg2KFv2PacV
 HDPyGhIzIlxg2pp2eupPhk4/e/u5pPm9cAVHlOvsA8/y9CDiz8AJ0kWPORcYqdFLohCl0zrjSjr
 gDGV7P7LBxW5r2y4dPBk/ofwpZ1vUWAq512/wMJo/iSChK3HGrdv3fpN8SPCUO9sSUutoL2rHGj
 UUmlHnKaEmZB7qjhJ7T3NZ8ZUxX4kQfuiOW/T4z1UVqKH4Zj1iyjOnFsd1aZVxL1Y2cmPdO+8j/
 5D6LfxVqXbPXyelNKgE18Ko3kP3e50hC8+pVFiWsdsqXGsjfEDCUe615j4m+bZ9eNMcZhI+EYu+ IyRay8MYTfdDwWw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

WSL symlink target names are stored as narrow NLS/UTF-8 strings on
disk. Converting the target name to Unicode in ntfs_symlink and
converting it back to NLS in ntfs_reparse_set_wsl_symlink is
redundant.

Remove this conversion and pass the symname directly to the reparse
data setter.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/namei.c   | 17 ++---------------
 fs/ntfs/reparse.c | 49 ++++++++++++++++++++++++-------------------------
 fs/ntfs/reparse.h |  2 +-
 3 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 9c1c36acfad2..88c0b05dde3b 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -394,7 +394,7 @@ static int ntfs_sd_add_everyone(struct ntfs_inode *ni)
 
 static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		__le16 *name, u8 name_len, mode_t mode, dev_t dev,
-		__le16 *target, int target_len)
+		const char *target, int target_len)
 {
 	struct ntfs_inode *dir_ni = NTFS_I(dir);
 	struct ntfs_volume *vol = dir_ni->vol;
@@ -1409,9 +1409,7 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	int err = 0;
 	struct ntfs_inode *ni;
 	__le16 *usrc;
-	__le16 *utarget;
 	int usrc_len;
-	int utarget_len;
 	int symlen = strlen(symname);
 
 	if (NVolShutdown(vol))
@@ -1432,23 +1430,12 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	utarget_len = ntfs_nlstoucs(vol, symname, symlen, &utarget,
-				    PATH_MAX);
-	if (utarget_len < 0) {
-		if (utarget_len != -ENAMETOOLONG)
-			ntfs_error(sb, "Failed to convert target name to Unicode.");
-		err =  -ENOMEM;
-		kmem_cache_free(ntfs_name_cache, usrc);
-		goto out;
-	}
-
 	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
 		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
-			utarget, utarget_len);
+			   symname, symlen);
 	kmem_cache_free(ntfs_name_cache, usrc);
-	kvfree(utarget);
 	if (IS_ERR(ni)) {
 		err = PTR_ERR(ni);
 		goto out;
diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index fb8c42a27699..eb1e4424e50d 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -750,39 +750,38 @@ static int ntfs_set_ntfs_reparse_data(struct ntfs_inode *ni, char *value, size_t
  * Set reparse data for a WSL type symlink
  */
 int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
-		const __le16 *target, int target_len)
+				 const char *target, int target_len)
 {
 	int err = 0;
-	int len;
 	int reparse_len;
-	unsigned char *utarget = NULL;
 	struct reparse_point *reparse;
 	struct wsl_link_reparse_data *data;
 
-	len = ntfs_ucstonls(ni->vol, target, target_len, &utarget, 0);
-	if (len <= 0)
-		return -EINVAL;
-
-	reparse_len = sizeof(struct reparse_point) + sizeof(data->type) + len;
+	reparse_len = sizeof(struct reparse_point) + sizeof(data->type) +
+		target_len;
 	reparse = kvzalloc(reparse_len, GFP_NOFS);
-	if (!reparse) {
-		err = -ENOMEM;
-		kfree(utarget);
-	} else {
-		data = (struct wsl_link_reparse_data *)reparse->reparse_data;
-		reparse->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
-		reparse->reparse_data_length =
-			cpu_to_le16(sizeof(data->type) + len);
-		reparse->reserved = 0;
-		data->type = cpu_to_le32(2);
-		memcpy(data->link, utarget, len);
-		err = ntfs_set_ntfs_reparse_data(ni,
-				(char *)reparse, reparse_len);
+	if (!reparse)
+		return -ENOMEM;
+
+	ni->target = kstrdup(target, GFP_NOFS);
+	if (!ni->target) {
 		kvfree(reparse);
-		if (!err)
-			ni->target = utarget;
-		else
-			kfree(utarget);
+		return -ENOMEM;
+	}
+
+	data = (struct wsl_link_reparse_data *)reparse->reparse_data;
+	reparse->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
+	reparse->reparse_data_length =
+		cpu_to_le16(sizeof(data->type) + target_len);
+	reparse->reserved = 0;
+	data->type = cpu_to_le32(2);
+	memcpy(data->link, target, target_len);
+	err = ntfs_set_ntfs_reparse_data(ni,
+					 (char *)reparse, reparse_len);
+	kvfree(reparse);
+	if (err) {
+		kfree(ni->target);
+		ni->target = NULL;
 	}
 	return err;
 }
diff --git a/fs/ntfs/reparse.h b/fs/ntfs/reparse.h
index ed7b93c359c1..e36557f29677 100644
--- a/fs/ntfs/reparse.h
+++ b/fs/ntfs/reparse.h
@@ -14,7 +14,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 int ntfs_translate_symlink_path(struct dentry *dentry, const char *target,
 				char **translated);
 int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
-			const __le16 *target, int target_len);
+				 const char *target, int target_len);
 int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode);
 int ntfs_delete_reparse_index(struct ntfs_inode *ni);
 int ntfs_remove_ntfs_reparse_data(struct ntfs_inode *ni);

-- 
2.43.0

