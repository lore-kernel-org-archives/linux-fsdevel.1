Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C831EEA49
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514647; cv=none; b=XsE3ImgKYsRUiD5PkJtfgUqTZZwic3vzx6O2ZNruj/t5GC8apeZJWtyKLDe50OI2lzZbPrSM5dqrGATti/5qdzlMTbO/nSew708qy72Wcub7wMYarYrU506ao5lU7y+Cf/dhOIunFTcXRoaa1QhQANWiI+8Q35DJeYFhpvksKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514647; c=relaxed/simple;
	bh=BPlMwhuat8Z2DNDWGK62GNqN1Lw6WWTq4lLI/wwLvFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVwjvRTYMhKJDdZVCTyDq6oEHJjIkGu8FQAIqk7uSlEcJ2lVJPFTjbAz4bx/oAPipQf5z8SM5X0fZtebMqJumS2OlSAww11e5HU8Hmi3cFZQr0n7IPGiCRh1QKb5ILRfWtTITRm2ED3pvqAfDM4XhjuA80t3Xl6/bhTJahKqckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb5AC/GY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb5AC/GY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82418b0178cso227192b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777514646; x=1778119446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvrYR2j0ICuUKwoOORo2Jsr4bEEaaxRMCJzK85U8m3Y=;
        b=Gb5AC/GYZLDJHw3B23FMI9IFgPzhS0CSCo/gunbN/L9Do1Ba8ylJpxUeMWnu9Hh+7M
         mNfb8VrlCPk54nwBN/CMN7FBFyP+mkRPCVo6393C0OovJjw8FgN9TtgC/qzcqTzLo+QQ
         yS++NZfTgmy4pxQX4CLONrgz6g8CzGJ30VjDxhnoMfXUikGpRK5Wx2xuC8K7OLkVRCPR
         3ouBHugenCcovpdCOdWrhS4A+4jBb2r1ZrRXlMzvjZfdLPzSSbJazqDE6HYMIZ8EyMGw
         QgMpgVw1Qga2+F5h1ByISr6Wp5KKyP1+3WfPTXyPfhqsRyoSHnURrsOXeP721t837KT4
         a8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777514646; x=1778119446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvrYR2j0ICuUKwoOORo2Jsr4bEEaaxRMCJzK85U8m3Y=;
        b=bLL3fet2DJWMEsKQoNkWnVy8q476njrr2pKpaQocfoX1+atN3fQoh4n+mK4yvr/vwa
         4jnVpHtnwXK0QEUvQiTW5ENkoPY0q4+R+LHS8dOTuyteXOtQFrSvuAVL+xAUAPUSdmaD
         JES3GsubKpNsiDLVP4XuJmNP0c0wp3IjndceBQ8udB/5Q8nmv8vVy8P0YLLkRuBxq5XY
         uTPlL2etcWcc+HaMb4PGpn1m3QbBXz6cM3guqDrpi2Hb5SuRoKrMtCaucIUC2tsNZZeX
         70ZIF8BjpoiXxb9a4WKepVOt4t/0PpPALqdactIZfr/V3EWITd8DGmCSEF/8WDj7rWNt
         e0jQ==
X-Gm-Message-State: AOJu0Yy0MoQPMqRIUGUd/1O6vfJd5/zLlwYKIzJrI1EETjJbBjYZJJ/l
	6+wANMZH3ndcAsh0GzoXot/+Ja5DFFk8SfP0uJLIgLKRueyy4DOMrIdf
X-Gm-Gg: AeBDietUs9e0pemj1SBF7WaMgSuBbr2zZxvOsKhNmCqf1ecGjsx6OCJRdFnKqs+Gk6s
	7zrNcMehGFWCR7r6UFo7nHPJzezzyM0KS1mDo2fAzqxkIXn7oFPGPQt8PduEhr6AvsCVeSYG+s0
	sPeOdJwo6N3KJHIH2kF23JXQ+lrEPrScK3ZtNIXUpgVwev/RbkFcq9EO08DXW9Q19Ml/Tlcbdu2
	BWTLerYKLjCnodkqGbtvKEsmwZ277tklvkaxW1oTaE1Xg+xVIn5+g+J233hzGIkDSTuttqq+E01
	UUBtu5LHQYI+pb95sW3Fbagh9u4sIcpVjp9oJE+uEAP1ROo4lTvt79nKMdvNuJWpPhK2UH3qm1W
	O6ZTSEU+6fbtQlNpANmnosBx7nICEyf9mw/de6l4XFOWiUDoRfcxKVo6GqzsNXherjgT+LrRNNG
	7sivrJBEiYVsfbMV4FC+OJX10KmG8uMkGMWgocRfIdAB+0h8tkB1QgUDDQqH9BuGliP5EUxrkgD
	tGPGO6kuHyyUuerWA==
X-Received: by 2002:a05:6a00:8007:b0:82d:24f:2509 with SMTP id d2e1a72fcca58-834fdb19a0emr1170284b3a.1.1777514645497;
        Wed, 29 Apr 2026 19:04:05 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:e9bf:615b:4859:6e22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80ec94sm3431157b3a.52.2026.04.29.19.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 19:04:04 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH v4] hfsplus: fix null-ptr-deref by creating hidden dir on remount rw
Date: Thu, 30 Apr 2026 07:33:58 +0530
Message-ID: <20260430020358.111052-1-kartikey406@gmail.com>
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

Extract hidden directory creation into a helper and call it from
hfsplus_reconfigure() when switching to read-write mode.

Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
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
 fs/hfsplus/super.c | 88 ++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7229a8ae89f9..8b5c39ce4d48 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -372,15 +372,59 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static int hfsplus_create_hidden_dir(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	struct inode *root = d_inode(sb->s_root);
+	struct qstr str;
+	int err;
+
+	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
+	str.name = HFSP_HIDDENDIR_NAME;
+
+	mutex_lock(&sbi->vh_mutex);
+	sbi->hidden_dir = hfsplus_new_inode(sb, root, S_IFDIR);
+	if (!sbi->hidden_dir) {
+		mutex_unlock(&sbi->vh_mutex);
+		return -ENOMEM;
+	}
+
+	err = hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
+				 &str, sbi->hidden_dir);
+	if (err) {
+		mutex_unlock(&sbi->vh_mutex);
+		goto out_put_hidden_dir;
+	}
+
+	err = hfsplus_init_security(sbi->hidden_dir, root, &str);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+	else if (err) {
+		hfsplus_delete_cat(sbi->hidden_dir->i_ino, root, &str);
+		mutex_unlock(&sbi->vh_mutex);
+		goto out_put_hidden_dir;
+	}
+
+	mutex_unlock(&sbi->vh_mutex);
+	hfsplus_mark_inode_dirty(sbi->hidden_dir,
+				 HFSPLUS_I_CAT_DIRTY);
+	return 0;
+
+out_put_hidden_dir:
+	iput(sbi->hidden_dir);
+	sbi->hidden_dir = NULL;
+	return err;
+}
+
 static int hfsplus_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 
 	sync_filesystem(sb);
 	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
 	if (!(fc->sb_flags & SB_RDONLY)) {
-		struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 		struct hfsplus_vh *vhdr = sbi->s_vhdr;
 
 		if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
@@ -401,6 +445,12 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			fc->sb_flags |= SB_RDONLY;
 		}
 	}
+	/*
+	 * Create hidden dir if remounting read-write and it does
+	 * not exist - required for link/unlink/rename operations.
+	 */
+	if (!sb_rdonly(sb) && !sbi->hidden_dir)
+		return hfsplus_create_hidden_dir(sb);
 	return 0;
 }
 
@@ -595,38 +645,9 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		hfsplus_sync_fs(sb, 1);
 
 		if (!sbi->hidden_dir) {
-			mutex_lock(&sbi->vh_mutex);
-			sbi->hidden_dir = hfsplus_new_inode(sb, root, S_IFDIR);
-			if (!sbi->hidden_dir) {
-				mutex_unlock(&sbi->vh_mutex);
-				err = -ENOMEM;
+			err = hfsplus_create_hidden_dir(sb);
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
-			hfsplus_mark_inode_dirty(sbi->hidden_dir,
-						 HFSPLUS_I_CAT_DIRTY);
 		}
 	}
 
@@ -634,9 +655,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
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


