Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCFD38E8B2
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850897; cv=none; b=hYRU+CJkSizy+feeFHxljjEKyu5BTI0UBR94SF/MOXAP3mwdU4ksTQw0dKqtiOuMmbPhbTZLVnVO7MfmRyKk7l0Mh98dj0jRxhhIs/xGGZjA8jjSJ5o9O0mzBa7vKOoWknKQbDMIJv2887RzmWGmWGwpiJ+zqstpL0Ovn9eVt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850897; c=relaxed/simple;
	bh=Xb6YmybDYOpffDEcr8Qpz3o3baljqAvw1OLCUNDOILc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEunWgX5gk6Jf+bTBc+k/Hr/v9YdNQxpqyDZ8+LDiTJa0kBEmawrvXvgZTk9KOk7Q8Ep2dB+6suHkbJqhMD1QgiogqHY3zQk1Gx2qrhOSidTq4DVpAdFH/TlP5IrUGo45cIzw5cmbFJ4H+EL8XVW4f0U/oPBZYw3YHoaiEDbjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuWKQ04+; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuWKQ04+"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so1376706b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850892; x=1790455692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8coy9Idjf1Xbt6E4H3MvvQY7vOxDVZhrZENv3R8zOc=;
        b=AuWKQ04+RdJ1Ccrl2bfOx/J6pBmZwjkvWyVFE2lCtBa0Kmwqc5Li7Q0uTAHPGLTn42
         0ZPVphfxoPP7+Bz7aXPoFBUeFYubdUtpSKhgGsQQ5r0hrpH/KZf5HbpTKydSQ/hsMIoy
         YGNvLBqjOpiDoUVq/qU751zsPPkTmIGrN7jFaj23e7S0y70BoW9GoVQWTFx+xq/s5jcV
         5thcgj1uthL4XK1AFYvjR33SX+rWJKSc3S3CK3/UJRGcu1aM49RM4wCdiIoVbQnZJxwo
         IXHqzcMURdTzpWtdQPfOKGN1M9xR93ucFGRGcH2HJcw0N0tpZLNYJrdGxU5T0isB48xA
         4zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850892; x=1790455692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8coy9Idjf1Xbt6E4H3MvvQY7vOxDVZhrZENv3R8zOc=;
        b=Np6N6DUSqZedIbsij7aLcJEWtl5jD676Ho3a+q57CA8ZCPpK5EZk8B2HxbeQ1feQAk
         U0JZ2u+4Hou/Gjk4mTa9aojCb41Ha3xptUwuNcKY9dC8Yvh2JTxxq3T6jUT0kJoXBAUt
         pLmR3qjuUPcVXAsQrOhxVwP3Jpnjr/vzsd3uiVeuXqDYzbCL1O3UQtT30L+L6h8TURrU
         Ib1N2OtpGRw+fUX9s958JiM/Xw5dySBjj/g3A55rZhW9J0xG3NQwHpU7YYJ/cwg1nff4
         TjHaJ6UYvLzjdEm2P7J9SlA2ooCITt3bSS/d1VtU+WK8FcNNsISgj+5pj2oRc6eZwgQf
         Il0g==
X-Forwarded-Encrypted: i=1; AKwUvBwhjx+0mVWiKpDbUA2ShB3pby6tG11BgD+7YttRz4Rcd32im8gKkZy0uYttPTtWHIEVUSB+JR9TJSlvpjDN@vger.kernel.org
X-Gm-Message-State: AFuF++mxhto6zi4lhbGTyU6Y9LTP2RNc/v3sKoFKRv586tczOZPQQ2Up
	R8P0JsEavxn6qQu6fv5drOhJEpyVyHohGLadtS+qKmvlxUvQ8gQPbIGtBDZTxMJd
X-Gm-Gg: AYBFou2LnZAqfO8CNxtOwV0956DWfykiG4Qa2lQJcXMkpTxM3Z1mnCGEzk6OK6/s+d7
	BKkKjE8wz/NsXNW43WCtwT6ZcmSr6SyzVTvjyDBvGJ3OcCWdEGok2zqzdCoibS4XmxuVPPDmf+6
	l8H3H4N6KMXmBF4J9jkDWxqbekgTsMFo4txKzzYfDIxzm6BSIBcn6Jtc23cc8VlyX1kww4FQx4K
	kgKse/efKUpARoz5GBC4CALw09rtF+BJXCweI1lnc8QD+u+uby6Dbf8OJop690T1YyDN5nBwHqR
	/8J4bpg4ENeM++T6tYbKgms9IWDXL1bWNwdblbeLBF0HQPsfbtvWtefs6wXqsanRZfcxAQ1WBvi
	t8CiKc3uRrRKN82AoppTTvQuLmgfOJVhmUSRolC/3Z/MN69XkupzyqvWoug4qHc6q6yxXEahLcb
	YxlqRMyJsp1dn0O1wfs18jvXN/SGMEJsLtU5sxwFtV4cpTRHXGFFeX41FBofBjyDACQKkMiZoNG
	VcThh8RNujGrb14zb5USXV++FHzQ7uwg8ymURV/o0mR7hNeAMKO7e6Xj8iM53JiuPJJkfWXwrZG
	moPaQTi65Q==
X-Received: by 2002:a05:6a00:1a0f:b0:877:b053:2e12 with SMTP id d2e1a72fcca58-877b05337a5mr2996714b3a.10.1789850892092;
        Sat, 19 Sep 2026 13:48:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b18689sm1299910b3a.40.2026.09.19.13.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:48:11 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fat: avoid freeing clusters on failed directory validation or read-only mounts
Date: Sat, 19 Sep 2026 20:48:10 +0000
Message-ID: <20260919204810.2813594-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fat_fill_inode(), set_nlink(inode, fat_subdirs(inode)) is called
before fat_validate_dir(inode). If a directory has zero valid
subdirectories (so fat_subdirs(inode) returns 0) and fat_validate_dir()
subsequently returns -EIO (due to a missing or malformed '.'/'..'
entry), fat_build_inode() calls iput(inode) with inode->i_nlink == 0 and
inode->i_start still populated.

fat_evict_inode() then checks !inode->i_nlink without checking
is_bad_inode(inode) or sb_rdonly(inode->i_sb) and calls
fat_truncate_blocks(inode, 0), freeing the cluster chain on disk even on
a read-only (MS_RDONLY) mount.

Validate the directory before setting i_nlink in fat_fill_inode(), mark
the inode bad on error in fat_build_inode(), and guard cluster
truncation and metadata writeback in fat_evict_inode() with
!is_bad_inode(inode) && !sb_rdonly(inode->i_sb).

Fixes: a3082d526f2d ("fat: add simple validation for directory inode")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -535,11 +535,11 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			return error;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
-		set_nlink(inode, fat_subdirs(inode));
-
 		error = fat_validate_dir(inode);
 		if (error < 0)
 			return error;
+
+		set_nlink(inode, fat_subdirs(inode));
 	} else { /* not a directory */
 		inode->i_generation |= 1;
 		inode->i_mode = fat_make_mode(sbi, de->attr,
@@ -610,6 +610,7 @@ struct inode *fat_build_inode(struct super_block *sb,
 	inode_set_iversion(inode, 1);
 	err = fat_fill_inode(inode, de);
 	if (err) {
+		make_bad_inode(inode);
 		iput(inode);
 		inode = ERR_PTR(err);
 		goto out;
@@ -688,12 +689,14 @@ static void fat_free_eofblocks(struct inode *inode)
 static void fat_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
-	if (!inode->i_nlink) {
-		inode->i_size = 0;
-		fat_truncate_blocks(inode, 0);
-	} else {
-		mmb_sync(&MSDOS_I(inode)->i_metadata_bhs);
-		fat_free_eofblocks(inode);
+	if (!is_bad_inode(inode) && !sb_rdonly(inode->i_sb)) {
+		if (!inode->i_nlink) {
+			inode->i_size = 0;
+			fat_truncate_blocks(inode, 0);
+		} else {
+			mmb_sync(&MSDOS_I(inode)->i_metadata_bhs);
+			fat_free_eofblocks(inode);
+		}
 	}
 
 	mmb_invalidate(&MSDOS_I(inode)->i_metadata_bhs);
-- 
2.43.0
