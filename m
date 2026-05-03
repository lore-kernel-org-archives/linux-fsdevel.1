Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979D2F6910
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777783486; cv=none; b=fjL9xBTBn/eglq97w5GvBIYNeM+lMqC2DwrLQi9sA6bwtjMYI2CNdNXu0+hjHDLlF3xN10jFmDi9cckdyRZjI9wBRSWInh8IFgAULP6k4qUrChzFJaSewx2+/w/fZJx6sVb8ithQjOEdWu4tL4HGS/DyZqlsePkqg9fZ6CR7RH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777783486; c=relaxed/simple;
	bh=1JowNWLjEUChrOcuuF9uWSrjogzZuS2TKvbBHuC8FoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kk7BD0z+iE/GWYqWYR4Mta2QxaObgjKEulNt/ickaWb05bMnJQXUTHuhEBqzGT6ahzPdSrL58qiKOu9YMtJwo6dVkrHNlKmbBJ0EluwdFB1RfidPF0pOq9wqLS4Hq3qFk2Z+3QhdyHZJUW9Rcw2/ZMUVTq3h+jAJ3OFKe3LAzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGJtj4aN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGJtj4aN"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-364d72f2986so1966813a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2026 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777783484; x=1778388284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0KlbiYM6L5YTGL2mTuB6xAXXvLmSJ6xenJk9Cafzqo=;
        b=LGJtj4aN2VE78MjohH3IdjdTvV+4Y2xgxGnxEQWmdcr32WE8xHRdP1ON2CEaCxMSOS
         bw4ZLwBLFoU9nixNImns3f32AEH9nXQMAfiMP2qU+8H7eahpEmrYbnswuI2iKMidNXKP
         2xqYrepCpzZusHu9DlksbehptjQSbscw25V1D6Lqcx+tQlVWI42f8F0hNIkLJ13auuGA
         h0EMGg3MteyStJdcu6C59r44Cbfp6okXwOIVfNxeMgOz4OfHxYobduyb0T6USnaRYTJd
         VG7IiyDJ0QT/f7qYArjDJDlfdBIwEzj8eMnY3ASUdDEXsWdsm9kd8UeeC5S4tPSjkvd3
         INGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777783484; x=1778388284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0KlbiYM6L5YTGL2mTuB6xAXXvLmSJ6xenJk9Cafzqo=;
        b=UuecyvJkpH5iCYpAou+XTUetnHtl2Pw33U0jEpdwXEBVw25A+1hC/ae0D3wqTfSpdI
         mhCRhEfTq1hRB3SNEgN2Nd/K4puoO3sSQaF5DY0HPUQt2puO2wovpjP1B+oHrqBYK0hP
         bGfv6TPl2UnTp/lW5RlyI7OtdifvZvWxdaQLoqCaL58slEhFzeoiuFxt1bnfxW7+ZXso
         5yiCmKqCM5bNV3vt3upCRP9AsLDIvQ19Z36TOEXmZdH9+2b4/oj9vlNSRj7MKlR4xrov
         m4MRQkwgjN9ibXQN6YO5JfSY3DUb0/p7VlevqX4pJWjHIXMNeX2xxVEDfWpWsXYCOox5
         jM8g==
X-Gm-Message-State: AOJu0YzNJ23cMDFbU8upn0CvoGbrWUdfgBftbWObjWCpLExqtX9pRpjY
	dfX33HL7mkdv8Du9yOYpv/bsbZNIvfBxbA+wVumgITsz+0rONH+Yvx05
X-Gm-Gg: AeBDievMd45obShHHPYN/8KuxXzRq3UieZQVA2mwcxc9HY4OOK6+HCDyfltwzI0/lgl
	84hd5resg7OKuEOWzW/yNUpCTurI5t7z675NGbMV0xLjcmQ+6xuEyLdl8mVKFEki9dXik0TVnYD
	aQNbhc1ccr/zufcOecqKPkQj7piquIaiQ/v38w5limjYbo06RL1J0MCadBHfXIPOBzCBWTuDUuN
	KUNbZKdg53EiJknzbibwar8ePMZvNroqvA5YLUKVr8embLkAAYhcJrNihlHxW5lIMMYwSabs0g7
	a1PDbHYMLYn0q7BgKyN/aXqYqSWDm3+ZXL8Ak4qIut0pmnbu8LNPtJKz6DMkjXOQHHgLQGq9W8n
	CGEPb1uaCHUgnNC+pC5gcGj67lEF0W4C3k3OVdUv4qyqpM0sF94GdAVByTjdCOQ1An/OIRygTp9
	Cw6RH51BsGIY2PQzHJZYp4qhnIiV2ul4oTxSqPABl0/94TmkQI3M1V4Jvlg/kukhfgTp/AfeQND
	6jO4BQL7YC6bNMAUA==
X-Received: by 2002:a17:90b:35cf:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-3650cec0ce2mr5401099a91.20.1777783484018;
        Sat, 02 May 2026 21:44:44 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:23e4:d2bb:1114:1271])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f47b14fdsm3339322a91.3.2026.05.02.21.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 21:44:43 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH v5] hfsplus: fix null-ptr-deref by creating hidden dir on remount rw
Date: Sun,  3 May 2026 10:14:36 +0530
Message-ID: <20260503044436.130823-1-kartikey406@gmail.com>
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
 fs/hfsplus/super.c | 97 +++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 40a0feda716b..f37d5abc84cf 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -375,6 +375,54 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
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
+		mutex_unlock(&sbi->vh_mutex);
+		return -ENOMEM;
+	}
+
+	err = hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
+				 str, sbi->hidden_dir);
+	if (err) {
+		mutex_unlock(&sbi->vh_mutex);
+		goto out_put_hidden_dir;
+	}
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
+		mutex_unlock(&sbi->vh_mutex);
+		goto out_put_hidden_dir;
+	}
+
+	mutex_unlock(&sbi->vh_mutex);
+	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
+				 HFSPLUS_I_CAT_DIRTY);
+	hfsplus_mark_inode_dirty(sbi->hidden_dir,
+				 HFSPLUS_I_CAT_DIRTY);
+	return 0;
+
+out_put_hidden_dir:
+	cancel_delayed_work_sync(&sbi->sync_work);
+	iput(sbi->hidden_dir);
+	sbi->hidden_dir = NULL;
+	return err;
+}
+
 static int hfsplus_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -403,6 +451,18 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
 		}
+
+		/*
+		 * Create hidden dir if remounting read-write and it
+		 * does not exist - required for link/unlink/rename.
+		 */
+		if (!(fc->sb_flags & SB_RDONLY) && !sbi->hidden_dir) {
+			struct qstr str;
+
+			str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
+			str.name = HFSP_HIDDENDIR_NAME;
+			return hfsplus_create_hidden_dir(sb, &str);
+		}
 	}
 	return 0;
 }
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

