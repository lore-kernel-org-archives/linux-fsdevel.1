Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340023;
	b=FCFk4UdRS+/7OMKwR3qTJNOffOtnxiy1XP1E4UPuFcrjO0bd9nsTwmC2Dj2IsB1sUWPn
	 l45dmE8ovDxjYU4929PUeN89idcMYZ8Q0xak/s4f90n/WEW6RkegBuaASzjolqK/8di1g
	 vSwMPDJKhYR/xR6UV6uJ+41XjTQlQB50kkalPTWWVuMXLbhWpfs5lCDSixNE5HbQ43LqS
	 iu4kSs+gcxXgmasfAKIMnHpFojDOx7QJHDB9u2+tP8oQ1yXyoJtTED6nNDD8C7fkyTy3o
	 GYUuNQAUxcmUArnq8iVwE6KKiCN/RWswjc4RoD2qp2/EK13XcoCxl3hymloslLGAYTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/6bqAv1/Jm5xeOExYjkOudRYuHmH74jNAMEu3UFrpqM=;
	b=j5KCO6y5Ze10NSULPXMc1LbnP9LTbVYUvuw2q0MmVVF3ueq0s/GQ46B8Ed5laRgnxGzD
	 q45XEfrths7HsPSSILXqnhw9d6xs/xaQ4CRA3KpOP9ZLWolnHIMRopjAWpWU4bucQ0PxR
	 16b1NCBMyV51Vdvdbz2rUj5+qdG5JFF6DAK48Dy+DTKtL0/O2nxYhjIEXVWOustV6AyVZ
	 M7uNkaEM1NfzX22XuO7bdYQCcnluz2iGvEZUllpMsJFpCMBtf/Zon69HC+wOrARBqmSqz
	 Equaaw7sT65KMZX2W1hAAff0cFeM3k4bM6MTP668d95IIOFUoKeadBW3Kl86Gh+DsxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfiuqSdg;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68409606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 06:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68409606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfiuqSdg
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so683931eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793340022; x=1793944822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6bqAv1/Jm5xeOExYjkOudRYuHmH74jNAMEu3UFrpqM=;
        b=hfiuqSdgGTyi3DgDanEABTUkeTWUf9tE0vV1yMhwhlDpkwVFWU7y0V8y80TLGzKTQi
         p9Z7zIgcyDWyHKCgcl4Wf/UqvNquZcX+2FS1WruyZyY4bEfsSi82bGHVrmNv5C9fZC/p
         h5K0zy2lJLwfTQBhvQ2NGnQ9MFJaR8LMsV+3E2qefIx8deA4LBAnSdWQC/Vxpr/x59nt
         I5o6LpJLGPc9n+MQnr3RP3XCdaay8q0WgJ2w3F8xWXKbm9718GJk4tZx7WikAG/ccMJk
         KQigOP0f4mRJvNJ+3W8bHqocfcxuatZd8V6q4AsOO4ckf0V4YWttLVg+HgUoebfjkU/C
         Qr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793340022; x=1793944822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6bqAv1/Jm5xeOExYjkOudRYuHmH74jNAMEu3UFrpqM=;
        b=uMJD5gg+tmlxNsGkXLgreTRLjEbsttjGZQIIoqpOv73xRxKI5HtzYl7jRyW29ZoO1t
         jKaEJvFbME+T0Z7MADrOfBtU3LLgmCOWyv+Y1ktuPHI0JLmVLxA+LzWjqzhnWXF7ESYl
         9H8Hi8l8t83kqzKUmco7sUIwFnu8eas/7EewSmIZhFlq6mCYzA9ZrgBCYt3pvhtkwu3L
         l7+CppAspKo/NVAbTdLRMIErfhNit+e7Hxcr76vp5YPf1jVJv1QHG208xow3/3n99UiZ
         48LjjBDv9kBgTloZJKowXblMuv40V/pglfQTOMZ5f7mm7z0EQrQqTsB+ZUSjlDzEyqmc
         F96w==
X-Forwarded-Encrypted: i=1; AKwUvByIJ+MYJ2tDq7A46iXFc6l7h4ptwGFpR3ZLWr6+Jc8HKmWp4WULhpw8gr/M+pUHJm5xnzidXCe/sjREkLIO@vger.kernel.org
X-Gm-Message-State: AFq9FYLJcwP181tZlpyZGXHpwgh6Zb9EJpwXkQZh6MrPIawsL8m72Awq
	QLPyUdccorApAIt/x9rKQi+HhE84UkUHgtIZm5qPLPSR6rFO8+Wvm2XMVHhFNbs0oXY=
X-Gm-Gg: AYBFou1pP+x6T/XnFMWQN0XmyomjYQO5vO3i9Swp5wqVZpjHG8R+uV+bdIPit2K0nsb
	cejP8a5LXMP9lhgqHMlthazSvMpxmWHS5m6uYIVovpkR3WuF2c2fR+wT2z777etG6pIZUCpuvuk
	8+jsHNk/xgOTT2vcXj/43QtqCUX28cakAWZUT9VWqgA2FPHNZHxqSsf30LFZUnDsEvhsOMb2Tu8
	Ha8uAN1a+4qhKuh7xmxhn8Tm09GZEgO3dvVdlai1kDBz9Uih8oYXNJQnAGbP+FJOfGe6M4dLrpg
	phEMbu91+xkSw743DQXgdd1IdN07AL3HgYPpsRtIj6K15N5LouYnKpEh/qWH2n3mKOoyl3uJy84
	w7f/SHEDal3EmG574LCs5jC/e5kyMPzx+SJe4IsenIWr0Sk5KvUdkWljAEdJKt9Jykd40WSlz9h
	3GBNHOk400cb281LVNCqRUDYvvrOQIByUbK5JWszz1ZZgxEWkaeMk5JiGZbz85aQMr/bwS+WpDj
	WDX3kQbUs12W7fhohN4DvQFVtc4FTs+kFZWw9HOPTG2LArAeKG7PloCcikubj735x6AAdsH/oOF
	5ELgGOzFZVk4/k6qbCkdj3zgJVOkxbiHETOukVsko38F+2brZZOTMSsr
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id 5a478bee46e88-36a423b3dffmr1914478eec.24.1793340022086;
        Thu, 29 Oct 2026 23:00:22 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm3833306eec.27.2026.10.29.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:00:21 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v3] fat: fix parent link count when replacing a sibling directory
Date: Fri, 30 Oct 2026 06:00:11 +0000
Message-ID: <20261030060011.70237-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vfat_rename() and do_msdos_rename() adjust parent link counts only when
updating the dotdot entry for a move between different parents. Replacing
an existing empty directory in the same parent also removes a
subdirectory, but leaves the parent's link count unchanged.

For example, renaming one of two sibling directories over the other
leaves the parent with four links instead of three. stat and ls report
the stale count, and find -links 3 does not match the parent.

Drop the parent's link count for this case after the source entry has
been removed successfully. Leave cross-parent renames, regular files
and the existing error paths unchanged.

Share the parent link count check with rmdir through fat_dir_drop_nlink().
Only decrement counts of at least three and report a filesystem error
otherwise, rather than reducing a corrupted directory's count below two.
Export the helper for the VFAT and MSDOS modules.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v3:
- Move the parent link count check into fat_dir_drop_nlink() in the FAT
  module and export it with EXPORT_SYMBOL_GPL(), as requested by
  OGAWA Hirofumi.
- Use the helper in all four places: the VFAT and MSDOS rmdir paths and
  the two sibling-directory replacement paths.
- Retain Hirofumi's Acked-by from v1.

Changes in v2:
- Check the parent link count before decrementing it and report low
  counts with fat_fs_error(), matching rmdir(), as noted by Sashiko.

v1: https://lore.kernel.org/r/20261028211626.26103-1-dennylin0707@gmail.com

 fs/fat/dir.c         | 10 ++++++++++
 fs/fat/fat.h         |  1 +
 fs/fat/namei_msdos.c |  9 +++------
 fs/fat/namei_vfat.c  |  9 +++------
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 35bdb62944a2..0cebcaf82426 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -963,6 +963,16 @@ int fat_dir_empty(struct inode *dir)
 }
 EXPORT_SYMBOL_GPL(fat_dir_empty);
 
+void fat_dir_drop_nlink(struct inode *dir)
+{
+	if (dir->i_nlink >= 3)
+		drop_nlink(dir);
+	else
+		fat_fs_error(dir->i_sb, "parent dir link count too low (%u)",
+			     dir->i_nlink);
+}
+EXPORT_SYMBOL_GPL(fat_dir_drop_nlink);
+
 /*
  * fat_subdirs counts the number of sub-directories of dir. It can be run
  * on directories being created.
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 76978a268410..a8a3ca4f465b 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -332,6 +332,7 @@ extern const struct file_operations fat_dir_operations;
 extern int fat_search_long(struct inode *inode, const unsigned char *name,
 			   int name_len, struct fat_slot_info *sinfo);
 extern int fat_dir_empty(struct inode *dir);
+void fat_dir_drop_nlink(struct inode *dir);
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const unsigned char *name,
 		    struct fat_slot_info *sinfo);
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index c7500c2859e0..5a43d042eb01 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -333,12 +333,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	if (dir->i_nlink >= 3)
-		drop_nlink(dir);
-	else {
-		fat_fs_error(sb, "parent dir link count too low (%u)",
-			dir->i_nlink);
-	}
+	fat_dir_drop_nlink(dir);
 
 	clear_nlink(inode);
 	fat_detach(inode);
@@ -565,6 +560,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		(void)sync_inode_metadata(old_dir, 1);
 
 	if (new_inode) {
+		if (is_dir && old_dir == new_dir)
+			fat_dir_drop_nlink(old_dir);
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index ff7652bf0410..791f2d7b8509 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -809,12 +809,7 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	if (dir->i_nlink >= 3)
-		drop_nlink(dir);
-	else {
-		fat_fs_error(sb, "parent dir link count too low (%u)",
-			dir->i_nlink);
-	}
+	fat_dir_drop_nlink(dir);
 
 	clear_nlink(inode);
 	fat_truncate_time(inode, NULL, FAT_UPDATE_ATIME | FAT_UPDATE_CMTIME);
@@ -1011,6 +1006,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
+		if (is_dir && old_dir == new_dir)
+			fat_dir_drop_nlink(old_dir);
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

