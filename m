Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265472C86D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768580; cv=none; b=JuY4010RGDNtLhF0XNG6Nay1vcA9r0unQDwxZzJbmiIBwK7SIOAsbNQs3RBKAa81/4h5QxVzbUOCIiBB3lITH4NGceM+me4SQb0/TY/kQfD/2yfFSo/kwa2iLhFrTK/SbnGS2M5kLa7ss15isyWKBJjmyXk32APbWjBbHLHI6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768580; c=relaxed/simple;
	bh=B7p/Yr6KIUXHY9xeKP6wCZcbcmTeppPjtg4Fzq/9ZtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uy3G1spaG+JT92IBQqMcCs2XuIGPlQnlBkXNiyk5DQEtR8o+nKq+H8Yb5qveDJvq1vVeOPZvcPFn/1CxCSh3uHzZVEOKG6pXbc82WDjrderde7W6jIDy6npHOH2bWTRuzpwwKOyrHgljfczlCBM9sQJdKyx4h5TrTCEJmz1iuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxPSsAr0; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxPSsAr0"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a3d77e72ffso45182eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784768577; x=1785373377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dL5sSve182iKi7PGGdT5iIYPlCpUxk3FPMQ0kRAvoaQ=;
        b=KxPSsAr0TM3pnpflTeqCrQC0CdUieGyaRqnUpG9psc7ZmlFpJlEFQHD7J7AvV8J7P4
         wkCMjygyz4Mb17t2AXJMJLAiEiHR4u6vsKvGtCXwkG+qAY8VVQRv5RBM5yo91L12aDvi
         EJlw6HR6jPcEg63DKLTdMjFJOuGjt6j1VuCwHqAQ9yylh3YknUGq2I7b+oyXptKQj9Dj
         Dmf+KbJ5isAVhjGcUwBlToO9wHIWQvIjUOLcGr65unEeJVOraSMolxqwykXYxJpLm6Zd
         UjigYmaariSlci2pYa+krglVl9u56+issno+R8rvMN4+ca8OUmDKIcFDDAg8B2o5Bkfd
         TyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784768577; x=1785373377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dL5sSve182iKi7PGGdT5iIYPlCpUxk3FPMQ0kRAvoaQ=;
        b=tTewSL0BSRqF07SEGXTTKlO8e8SSWlitw53RumtC4rE1yQMYQfC+cHNy5lQ3GiMWmy
         uq2JCmKL6jVWyMi3luAi/KwIl7G/PCeUNgrSQRzwJwxAQ7XB1FeNG3gPUwSspUnnM1VA
         ztOFfC4/C12L1IorNhCOQLoUnOS2EbBlpWjJb9o2SVACbNcuznZhc0zRhZYhEbyKSWML
         Flv33IYnpUVSZY3XD8azqhMD93Z06Kpd/4fOS8enqPaKU3RomO3ioiuDesNzp557Gd6U
         7On8/JxJ/Ux+TO7dln23i01Ntvy026an9dxn37cBGDQR4Za+bWaVnn2zOPJQuv9nLuD2
         F+bQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiTrEfbc8pOocJcWreJnr75lG0NsfCXNU/HSAFWeU1n6rOv4RyPpp79I1Sy7j1SbsQhV6tLG0h5wvpW1dX@vger.kernel.org
X-Gm-Message-State: AOJu0YySdDVd8NS6zBRRx40WOH0URT6NwaXnJCnvFjpdKpIZpPeY0QTS
	Er0eFfLe7WNyvyltyFHdxJ+Ca2p9NYGx1efH9TMGXaIQQJGcqsJYI0jB
X-Gm-Gg: AR+sD11EMvf3EPSESj9WpPcxtsjQeUntWUh7w+gWI+HJoKwu3lXWxd13+Sba5X1CsRm
	NvEz+sUnSWxgqtRVOGCBkNDkCF+l+3kBMWJo6DxNnWXd1jZB4J7AwOa1rpWhqasooPgVC7TLwxa
	9ZYjMkj6+um5lqeMVupSikjqDOBq1POw0HpRkYR0j2YvhY0Uiv7lpMXSrr+c8ElQgQS/lxUVWIB
	SvTe/+wL21usvnPR+idxWjWAiEsZLcgt0nkJaII6MJWB15++PjcKLE/VXNJAWKp6aLy1uuWM8td
	tr06J5gL250W2M6vKqEDENbX9nwrSMn1gLa21kNqdjnhJT/Hw9SAux8tyFkp849mR+Ilc8Ojyky
	HY2bYMsjbcCkZzQYFPIMrrWVBxzYFCRsx9+YjSPcf8kJi+tjETld6Vz0eswcIR8vfagm2y8Xg
X-Received: by 2002:a4a:e84b:0:b0:6a3:94bc:bdcf with SMTP id 006d021491bc7-6aad41758d3mr381511eaf.57.1784768576918;
        Wed, 22 Jul 2026 18:02:56 -0700 (PDT)
Received: from fedora ([187.142.231.66])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766f16dfcsm3312320fac.7.2026.07.22.18.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:02:55 -0700 (PDT)
From: Cihan Karadag <cihan.cihan@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Cihan Karadag <cihan.cihan@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] fat: preserve reserved lcase bits across rename
Date: Wed, 22 Jul 2026 19:02:25 -0600
Message-ID: <20260723010227.88190-1-cihan.cihan@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lcase field of struct msdos_dir_entry
(include/uapi/linux/msdos_fs.h) has only two bits the kernel
interprets, CASE_LOWER_BASE and CASE_LOWER_EXT; the rest are reserved
and other implementations may use them to carry their own metadata
(e.g. the Windows EFS "encrypted file" bit pattern).

vfat_rename() currently loses those reserved bits in both of its
paths: when the destination name doesn't already exist, a brand new
directory entry is built from scratch with a freshly computed lcase
byte, zeroing anything outside the two known bits; when the rename
overwrites an existing destination, the destination's own (unrelated)
reserved bits are left in place instead of the source file's.

Add vfat_overwrite_lcase_reserved_bits() and call it once new_i_pos is
established inside vfat_rename(), overwriting the surviving entry's
reserved lcase bits with the original file's, so the metadata is
carried over across the rename instead of being lost.

Tested by booting the patched kernel under QEMU and replaying the bug
report's own before/after FAT32 images: the renamed entry's lcase byte
now matches the source's reserved bits instead of being zeroed.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215093
Signed-off-by: Cihan Karadag <cihan.cihan@gmail.com>
---
 fs/fat/namei_vfat.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index e909447873e36..d4677c1eaabc3 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -931,6 +931,38 @@ static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
 		mark_inode_dirty(dir);
 }
 
+/*
+ * Overwrite the reserved lcase bits (those not used by the
+ * kernel) of the entry at i_pos with those from the source
+ * lcase byte.
+ */
+static int vfat_overwrite_lcase_reserved_bits(struct inode *dir, loff_t i_pos,
+					      unsigned char src_lcase)
+{
+	/* lcase bits the kernel actually assigns meaning to */
+	const unsigned char lcase_unreserved_bits = CASE_LOWER_BASE | CASE_LOWER_EXT;
+	struct super_block *sb = dir->i_sb;
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	sector_t blocknr;
+	int offset, err = 0;
+
+	fat_get_blknr_offset(MSDOS_SB(sb), i_pos, &blocknr, &offset);
+	bh = sb_bread(sb, blocknr);
+	if (!bh)
+		return -EIO;
+
+	de = &((struct msdos_dir_entry *)bh->b_data)[offset];
+	de->lcase = (de->lcase & lcase_unreserved_bits) |
+		    (src_lcase & ~lcase_unreserved_bits);
+
+	mmb_mark_buffer_dirty(bh, &MSDOS_I(dir)->i_metadata_bhs);
+	if (IS_DIRSYNC(dir))
+		err = sync_dirty_buffer(bh);
+	brelse(bh);
+	return err;
+}
+
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry)
 {
@@ -974,6 +1006,17 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out;
 		new_i_pos = sinfo.i_pos;
 	}
+
+	/*
+	 * The kernel only interprets some of the lcase bits; make
+	 * sure the rest carry over from old_dentry's lcase instead
+	 * of being silently clobbered.
+	 */
+	err = vfat_overwrite_lcase_reserved_bits(new_dir, new_i_pos,
+						 old_sinfo.de->lcase);
+	if (err)
+		goto error_inode;
+
 	inode_inc_iversion(new_dir);
 
 	fat_detach(old_inode);
-- 
2.54.0

