Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1344D031
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033790; cv=none; b=BWRICYfJyxqjRs76S6b/pOQLPJgRmuyXRpOHQmN+rYT/cBzwQs6AH1YpkvKzy7anwP8Tv5IzX0WbwpgYFU8kxy3TkDcs3iZqrAFpQR3u4v5SOaZHKskQHnlsb0/4/2WOXO6V1x2KCVbLAT67IerOIeU3rw3s44LBxJKhIJwdGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033790; c=relaxed/simple;
	bh=JHifkVKVp3e/g6TqfsKYoWJUq6knhLTqWrBcW6jRaug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IR8AFKadgG3eVQUNFiR3hXZ5tq5EJeIBj0K7jbA5ipHo37G3WInoUxop948S84EFLq3CCTKC0lnYHGdW5qI0uJBB9hl0lJYH+YseKcK9opla91eEcL9/NxJ9j2Gwb1Sq9GfBsm3Bs6mWC2LuOlY1k2jKXFxUJkIkvqI8iNmUU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayU/yNqj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayU/yNqj"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487088510aso4108744b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784033789; x=1784638589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvvAjK+VgafLRm2EGvJtPAQqm3Swr3OQi+qwBFRBFJk=;
        b=ayU/yNqjG6T1WjYKte78aYKRc/App6igvmMxzs6mmkLG/I3Ncs2Gr8GnQpezpyWSln
         5vwYiqsqP5WeqLw5qJMmhPGIggdyrbzW7a4B7XIIR8K+92rGhDGO4UFBwi14+q9gqvFO
         3uAAvG47ZhegTfEFGi0rmEqU4NQIwDTNfSSBx9dP7gsK+w+2ecNnYzcQBMZqMHtvW4FR
         wNP1lPA8HAmkovzZcLCGz8zeNs973WuQVsTvy5iWDD9PnTPUYWJyXeWhbbkuusvM+Zz1
         zvtjVToLiuyX7zLYKb1XKHhLN0GqX2rVZZy6zEcKlBosw6C8xYtj6LdHzzz50SV/WI2r
         uQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033789; x=1784638589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvvAjK+VgafLRm2EGvJtPAQqm3Swr3OQi+qwBFRBFJk=;
        b=fz5yJO+aASnrem9oq3FkjA+NYA90mMwoaNg/I2KN9eHOpJRE9viv2gQmh0K1FnkCmv
         OXeQYPsc570S0HnK5EvpeDcnNhrAKepqkBoJtb6IMHqXeeZJXk3eii7tU4s2Ac5te7VD
         Vb0RLNpGi2rao0j6paClFtSj4u5nX2UDXAZALJ/snOiG8t83F9geOKQIfAptejy3Irkb
         +vbOddDxejuaU80C6pzmIC0S7f4LPxNfrqjubBZ+tiezaDSYSIOy8YXhgm92RMSge0sP
         1aolW2DalB36oT7jnj0Q1ci8EOkGQiZwzcI6eytdb3H7RLwBz0DG1OZS+QxKnKsj33xB
         z6ig==
X-Gm-Message-State: AOJu0YyhDNG568VjqHL1KBh1yjhSGbWqHDnWdsgy4jdEDz3gRsUSqGWd
	Q/zT/iuHPzdygBJlIbBQCrEU82xZ8gDd/s/wZZb7XkUzoAYZPmLtqXlC
X-Gm-Gg: AfdE7cmZe0rkBas4AJhw0u3Nynq4Kwb90QwlKVOjamDVg4o9p7C0VRXzW7g4ZDcYT6c
	JpGlS9HT5eAGx1+511f8IgQrSOD938e7X0FL7o13TMh6WjNVh14TILBI1sR8bYZ7iAIK4Z+SBR+
	og5dtu3PeWuYIYBD/QZW5VcKBlQQhiKrOvWB28rEX2H58sZzjr7e3AGMFgj7Y/j12OVqbWhNHa+
	CSRNI7ZWj8/0W/6MwbIko97EDdf+yvQj6uWzZbuT8a5KNWxy7gYv0vlumOVJMnR1i5pdEfpaR+8
	rSgUy9yT/HLUU3/XLAPAoBBV43h51PRAaC8GzgRkU/bFDCuOTeNvM1q+1arwpYXcG1w167JLmES
	w/0XN7rY12hHQMcC8nu67mfulygsDss8jgjqq9V9L4xmQscK+7zK17i3YsPKtfKceA+RZ3S4v5s
	ohbn0VTQ6SzExZqVCHp4cF55WRSmjVfMWExLwkFwFN/tuk6vsDfN1YIyyXHmrdHLvSZrkm
X-Received: by 2002:a05:6a00:1819:b0:848:4742:90a6 with SMTP id d2e1a72fcca58-84a5140d4b5mr3313577b3a.15.1784033788469;
        Tue, 14 Jul 2026 05:56:28 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:c4e6:34d3:11cb:ba2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f2389e8sm1465042b3a.8.2026.07.14.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:56:27 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH v6] hfsplus: fix null-ptr-deref by creating hidden dir on remount rw
Date: Tue, 14 Jul 2026 18:26:20 +0530
Message-ID: <20260714125620.11119-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_reconfigure() does not create the hidden directory when
remounting from read-only to read-write, leaving sbi->hidden_dir
as NULL. This causes a null-ptr-deref when any subsequent
link/unlink/rename operation dereferences it.

Extract hidden directory creation logic from hfsplus_fill_super()
into a new helper hfsplus_create_hidden_dir() and call it from
hfsplus_reconfigure() when switching to read-write mode and
hidden_dir is NULL, ensuring hidden_dir is always valid on any
read-write mount.

Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v6:
  - Use single mutex_unlock() in error path of helper.
  - Rename label out_put_hidden_dir to out inside helper.
  - Use QSTR_INIT() in both fill_super and reconfigure.
  - Add hfsplus_prepare_volume_header_for_commit() and
    hfsplus_sync_fs() before creating hidden dir in reconfigure
    to avoid inconsistent state on crash, as suggested by
    Vyacheslav Dubeyko.

Changes in v5:
  - Pass str as input argument to hfsplus_create_hidden_dir()
    to avoid duplication, as suggested by Vyacheslav Dubeyko.
  - Use !(fc->sb_flags & SB_RDONLY) as guard in reconfigure
    instead of !sb_rdonly(sb).
  - Restore cancel_delayed_work_sync() in cleanup path.
  - Restore HFSPLUS_CAT_TREE_I dirty mark.

Changes in v4:
  - Correct fix: extract hidden dir creation into helper and call
    from hfsplus_reconfigure() on remount rw, as suggested by
    Vyacheslav Dubeyko.

Changes in v3:
  - Correct fix location: guard sbi->hidden_dir in hfsplus_link()
    and hfsplus_unlink() in dir.c.

Changes in v2:
  - Fixed commit message: hfsplus_delete_cat() has multiple callers,
    not just hfsplus_unlink() as incorrectly stated in v1.
---
 fs/hfsplus/super.c | 100 ++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 40a0feda716b..56138881c35f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -375,6 +375,52 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static int hfsplus_create_hidden_dir(struct super_block *sb,
+				     const struct qstr *str)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	struct inode *root = d_inode(sb->s_root);
+	int err;
+
+	mutex_lock(&sbi->vh_mutex);
+	sbi->hidden_dir = hfsplus_new_inode(sb, root, S_IFDIR);
+	if (!sbi->hidden_dir) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
+				 str, sbi->hidden_dir);
+	if (err)
+		goto out;
+
+	err = hfsplus_init_security(sbi->hidden_dir, root, str);
+	if (err == -EOPNOTSUPP)
+		err = 0; /* Operation is not supported. */
+	else if (err) {
+		/*
+		 * Try to delete anyway without
+		 * error analysis.
+		 */
+		hfsplus_delete_cat(sbi->hidden_dir->i_ino, root, str);
+		goto out;
+	}
+
+	mutex_unlock(&sbi->vh_mutex);
+	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
+				 HFSPLUS_I_CAT_DIRTY);
+	hfsplus_mark_inode_dirty(sbi->hidden_dir,
+				 HFSPLUS_I_CAT_DIRTY);
+	return 0;
+
+out:
+	mutex_unlock(&sbi->vh_mutex);
+	cancel_delayed_work_sync(&sbi->sync_work);
+	iput(sbi->hidden_dir);
+	sbi->hidden_dir = NULL;
+	return err;
+}
+
 static int hfsplus_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -403,6 +449,18 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
 		}
+
+		/*
+		 * Create hidden dir if remounting read-write and it
+		 * does not exist - required for link/unlink/rename.
+		 */
+		if (!(fc->sb_flags & SB_RDONLY) && !sbi->hidden_dir) {
+			struct qstr str = QSTR_INIT(HFSP_HIDDENDIR_NAME,
+						    sizeof(HFSP_HIDDENDIR_NAME) - 1);
+			hfsplus_prepare_volume_header_for_commit(vhdr);
+			hfsplus_sync_fs(sb, 1);
+			return hfsplus_create_hidden_dir(sb, &str);
+		}
 	}
 	return 0;
 }
@@ -589,8 +647,8 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out_put_alloc_file;
 	}
 
-	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
-	str.name = HFSP_HIDDENDIR_NAME;
+	str = (struct qstr)QSTR_INIT(HFSP_HIDDENDIR_NAME,
+				     sizeof(HFSP_HIDDENDIR_NAME) - 1);
 	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
 	if (err == -ENOENT) {
 		/*
@@ -620,40 +678,9 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		hfsplus_sync_fs(sb, 1);
 
 		if (!sbi->hidden_dir) {
-			mutex_lock(&sbi->vh_mutex);
-			sbi->hidden_dir = hfsplus_new_inode(sb, root, S_IFDIR);
-			if (!sbi->hidden_dir) {
-				mutex_unlock(&sbi->vh_mutex);
-				err = -ENOMEM;
+			err = hfsplus_create_hidden_dir(sb, &str);
+			if (err)
 				goto out_put_root;
-			}
-			err = hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
-						 &str, sbi->hidden_dir);
-			if (err) {
-				mutex_unlock(&sbi->vh_mutex);
-				goto out_put_hidden_dir;
-			}
-
-			err = hfsplus_init_security(sbi->hidden_dir,
-							root, &str);
-			if (err == -EOPNOTSUPP)
-				err = 0; /* Operation is not supported. */
-			else if (err) {
-				/*
-				 * Try to delete anyway without
-				 * error analysis.
-				 */
-				hfsplus_delete_cat(sbi->hidden_dir->i_ino,
-							root, &str);
-				mutex_unlock(&sbi->vh_mutex);
-				goto out_put_hidden_dir;
-			}
-
-			mutex_unlock(&sbi->vh_mutex);
-			hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
-						 HFSPLUS_I_CAT_DIRTY);
-			hfsplus_mark_inode_dirty(sbi->hidden_dir,
-						 HFSPLUS_I_CAT_DIRTY);
 		}
 	}
 
@@ -661,9 +688,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->nls = nls;
 	return 0;
 
-out_put_hidden_dir:
-	cancel_delayed_work_sync(&sbi->sync_work);
-	iput(sbi->hidden_dir);
 out_put_root:
 	dput(sb->s_root);
 	sb->s_root = NULL;
-- 
2.43.0

