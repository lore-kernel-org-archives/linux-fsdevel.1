Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D12418A3C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296639; cv=none; b=Xo8FhxIx3lWMvT0c2c8TLGdM+q1Mu3COAmkhYcXK6T+584E/dd/x1Ffs5eRD3n5b2bNUKgwIM5MTvDsxkTE2B0T0o0ielIk9BxayGllxRSdch3oudw20y/eresbZFW2LFz9KqHLo2vu/hcYs0w0wp9YyY/WbauNWx2CbfVmF7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296639; c=relaxed/simple;
	bh=caOKfx6B2XcA3ehRz8C1l7+eNtvfKH4daoD9G2NW1zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyuyLfBc5By14S+ZXg89SoNlfbKWdkdEp1TfJZhME0NQttLkoOX45TtOF31Fs2KbvgZWQ2Kmx4bbuLYd0m/ckr98aaJyxKoFh+oo39lQNCNA5bNs1GBwH+TSoW/MoQ9VYYz6s+xkUYgpe8+xkXi0eKCmdazKy3K6UooDPlGJ+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJQX+QAC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJQX+QAC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caf228a910so61135195ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296637; x=1784901437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zt4gTOHlvvJNaD8TVC3OR3v/eBR3xfE1fkkvJ/nYdqs=;
        b=ZJQX+QACImV+g7x6PEqU+c947qN42A1QvxQauAmiNd5PkWpCMtYnYY42+fdo2Z6bag
         486QhQ4LZSEQAatFRqDuXNFhbngQ+rhPAD+S3kQSTOz79gVqlJeDTNidHhyol8+YnHEp
         BpybEOLPRcL28NrL6Harcvv5/9tMlPnyACL8xM8SZmGqdWr6RogqvUr855/0T9yze4Lc
         HMuvXqLsP3m58fiUjt5/eaiTk8FlHg9VNQY6qAbwoYvUzj/57OUreVuWpdwOjnJ2veBA
         2VLqttzhQGBP9W7tbM3PcZXIJJqrXxN0URuu+4QqCewYa2W1qPlRe8ZxIXVkeWaGb3An
         Z83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296637; x=1784901437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zt4gTOHlvvJNaD8TVC3OR3v/eBR3xfE1fkkvJ/nYdqs=;
        b=iNvWMYcrbLk5xWn7L8jFoOAOWpHhvpINC9T+UgYLIOuD6i34kHOJeZhliGBI1wlbHx
         IjEBFRzy5lHyIG8CjVvCZpHY4hvBVntF/SNftkQxYyUwOAEGE5QA2ccAnjLsRhz7MBYE
         Al4GqOg2CSDXVhLL7N77ChmxYh+2LFGopkaeJGLrtQmH19IQBB5eZjqtrOaeVgpOo0Xu
         ZXQW7LssgdRACKpsaa6a5/XW9rl9bV0RmOzBTbFxmZnkgtgP251gSahZS2L259mFykqk
         Mpy0YuBlf1subvMPzcXncBc6lszUfB8hdhBlFaxBY2/Eo0oSg9Fu/A/mD0VfUSUqXRZg
         2ovQ==
X-Gm-Message-State: AOJu0Yw3d2eks6VPDQKCraNHPRujDtm5IVJAlIqHt1QgTxqNtVJ4tWub
	W4XatZb8IaJINCX1EY7s7JL/YhhnwPSObLcd0YQBibTJ6QPUM0NA3HzB0XW4OQ==
X-Gm-Gg: AfdE7cmbLkuy1IyyxRrk6gSNrQMAeWZ6MnIDYkcYPvvZcRbf3ZSA8eyQZh0Zckg+4kD
	PjfFi9A50GpRCfwDPrz1iRagr35u34v90aIddopzC1FMP7O1/MOkBF9RlAG/kASgSq3ovG1AaLd
	kBoGAk0TJBfeA3njqsanY4WkM+bnwdOaPSd6g/AkwLk70EASkyJmo7XlyJQ83Rzq/giMxdG9w2T
	UrMjZ31cwHvzMiQOjRYAlTOe7CO+Zn/KX+B1hKYKm/VQcZA1aGrAdwlULNta27wleLsy9ENOzR7
	xvBapjbR/Kel4ZdWmG3LiJ3vV6jUx7MhHWt8Q+op8xQEYQUzEs/E3wBF3KLN9nsb3ciGJ607mbj
	4Sg9ZnSr+IwiYR/gil/BwZ5gNhXFAsCNxwe86siYbzCzGi3Wuqxc7xIiiJp8CThRRum6EIkyzoU
	D4zlqbNq9thfkIS6pwsw3hv3y5M0Nv66oQFIPGYneQ5zvXSI1lroNhqs0Ljg==
X-Received: by 2002:a17:90b:2dcc:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-38e4b447015mr2905293a91.15.1784296636811;
        Fri, 17 Jul 2026 06:57:16 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:d901:b10d:5266:6c96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d44fsm7009406eec.1.2026.07.17.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:57:16 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH v7] hfsplus: fix null-ptr-deref by creating hidden dir on remount rw
Date: Fri, 17 Jul 2026 19:27:06 +0530
Message-ID: <20260717135706.42918-1-kartikey406@gmail.com>
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
Changes in v7:
  - Call hfsplus_prepare_volume_header_for_commit() and
    hfsplus_sync_fs() for all rw remounts in reconfigure
    not just when hidden_dir is NULL, as suggested by
    Vyacheslav Dubeyko.
  - Remove redundant inner hidden_dir NULL check.

Changes in v6:
  - Use single mutex_unlock() in error path of helper.
  - Rename label out_put_hidden_dir to out inside helper.
  - Use QSTR_INIT() in reconfigure and compound literal
    cast in fill_super.
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
 fs/hfsplus/super.c | 102 ++++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 40a0feda716b..3983e8160302 100644
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
@@ -403,6 +449,20 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
 		}
+
+		/*
+		 * Create hidden dir if remounting read-write and it
+		 * does not exist - required for link/unlink/rename.
+		 */
+		if (!(fc->sb_flags & SB_RDONLY)) {
+			hfsplus_prepare_volume_header_for_commit(vhdr);
+			hfsplus_sync_fs(sb, 1);
+			if (!sbi->hidden_dir) {
+				struct qstr str = QSTR_INIT(HFSP_HIDDENDIR_NAME,
+						    sizeof(HFSP_HIDDENDIR_NAME) - 1);
+				return hfsplus_create_hidden_dir(sb, &str);
+			}
+		}
 	}
 	return 0;
 }
@@ -589,8 +649,8 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out_put_alloc_file;
 	}
 
-	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
-	str.name = HFSP_HIDDENDIR_NAME;
+	str = (struct qstr)QSTR_INIT(HFSP_HIDDENDIR_NAME,
+				     sizeof(HFSP_HIDDENDIR_NAME) - 1);
 	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
 	if (err == -ENOENT) {
 		/*
@@ -620,40 +680,9 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
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
 
@@ -661,9 +690,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
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

