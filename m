Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7115FA81
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018501; cv=none; b=IMbFMx8h/JOFK5FlpcavZpRkx3Yf9wzEkry1bzcJts2RvZdowZO57Nk4UvtFEXu7bpvbxmiNOjFAMbWdpMAYjzELk942c1L8yjKJue7NGVtpN6wwbBxYP4RdUQ0GdpDYDzseRcVNFd8QW1vl0cbQFYGwiDqSN69//feTJ7yGthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018501; c=relaxed/simple;
	bh=LKA16h5VDUn0t35u+k1BiGLV5sHU3fkhJaiFA8e00Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPo2ln1Gk9d0vbA940pHnVZLN0RYo9XneKS1QttZGH+ALRCXdsfvIHTcBg8t+TQZsx7jiiQWb+zcjEGVAiqAGJb0GYkXCGUeWVzWjJ+TwOH3vGKOIytPsfMJ/lGRffeD2EBrVR99sJhREG8LmZq1JZXVEzwybWfdNSJ71AR+lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=iV18rpw4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="iV18rpw4"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79885f4a8ffso56842367b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778018498; x=1778623298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R2MeVIg4VpP+9zwLnJOlZvfGC5R5bmW9a18q0/iM5VE=;
        b=iV18rpw4n7mE+3HtSQugXIwzgFDbnQEIh7LYtIIjZk7BLXMA0RJTNNXVB2qtTNx8BA
         P9F8BD6ueqOaHeNlUVDo12WrrRuuEshAaEnBWUuBC3tlg90smfYnW6tZJasm4AtJ1Ku5
         ep603VXONqh33RaDTsLn+yPPA6W1c8b1+NjSzWgW9f/7jvOCxIBtQHVFNBNhE0U8wy+R
         zG2/zB0dYUTdDrHZI17uqOTT0TGAVPjVuJMbqbua9jEPyHgbbaJPX0Ob5fnY9tBLfKOg
         1dwjdzbvk4Xmjek4bTjuMYTg/WzCnXpH1riqEfbG7WTxh7HeT5QIc2psZNvGkRCaMNPp
         4j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018498; x=1778623298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2MeVIg4VpP+9zwLnJOlZvfGC5R5bmW9a18q0/iM5VE=;
        b=OlHAySs3AVqe0l8eUcPO7NEYvmb5s4R2kVR+1NLx8+RhcGk8bPSxKc3CXvgTihXXJY
         YmDSZq8c7vmfkQslgjS5lVjE05lW4VgA4G1usm/JZZ/A6BhLoKOwhoPkJ3ByRCUg64Tw
         CP56HPjHz7ofKyWVvVdU0tj79fqpb9aw32gJfzDcZw6KaWMdIDof/EhdVUdRWJyl/o9J
         miaVg70k1OQq5t7UZVLDYxTJqiGF7qSuHSdzmwHY5aUoVuSPW2SQHBkUKs+cKCftTJYr
         qRwaXdpnDv5QswIi4QSglPLQvQo0o87ogY7o09TiMagt3+yhws6FMiQXWqkRDmJbHn3V
         oUUg==
X-Forwarded-Encrypted: i=1; AFNElJ8HlBNTGdr1d2bhzlmQLStHUDtjxed3WA0JnTDE9m2DfXfXGzxPALOYN0mfgrpm4wSDhf18mFZzd5ZXYdAl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wSC9Ozukigxh0MrIqkHBMbWJtWmbX3anUFe+SyXTK6ciZOLT
	cenGHlbq7MTJwf73M06buiOjpPzR1ShdE+Eb5uBViaO51cpS0wtKZBN5e/YlvSIVFRk=
X-Gm-Gg: AeBDietjL5HF6ElnRW1bdUt3GZM38eO35tJAOWi+JbwzUbSveACstlkrtjZ+LBeQCZr
	Vx7ziJ3Fgb5rkmVT+O3c1KQMLP21r2CLOvNyXw2u0e5uJk67XXAMfrP0PTtltBNG2WxorU66ho2
	iVh+JcNNkusgyz+YW9lzcCUPWip1nXdcv7rK9FnNuDAQKt8JnXNJdS5sAJan07N/GVPWgs5ET4z
	OhB/0urBWN513zMgu/J/WAr7CcIOlSWNb6FPkcmg093fMCSR4VKXpoaS/fgLH5nG27jmrNktSjj
	D4QTZW14VAe2y1+TxVskbwLom27eCBeg0l/agRctHw6q89JHV7B4Q7amnGrFYopJsTMHVAfyxei
	0NGKkXAeRh5za/dd1ipa/0FHfCUCu53Xg5OmeyTinVIfyNuDhTyWIAATPlg5YxM8Ea+VFmsoDgG
	kHoCaordmR8w8y++zeC4YmRuZlwSwOT+2pF8YcKzVVIwY2T8tT/qusDQLl/JaUvqym4V/2SXr+/
	RsVClUp/xo8xDFPqWbRDk7mfT+8cf9yhd8=
X-Received: by 2002:a05:690c:6ac6:b0:7ba:ef98:9712 with SMTP id 00721157ae682-7bdf5da082bmr13599277b3.11.1778018498143;
        Tue, 05 May 2026 15:01:38 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:2774:549a:b50b:270e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7aff693fsm169989d50.19.2026.05.05.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:01:37 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: rework hfsplus_readdir() logic
Date: Tue,  5 May 2026 15:00:52 -0700
Message-ID: <20260505220051.2854696-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/637 fails with error:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

QA output created by 637
entries 7 and 8 have duplicate d_off 8
Found unlinked files in open dir (see xfstests-dev/results//generic/637.full for details)

Debugging of the hfsplus_readdir() logic showed this:

hfsplus: hfsplus_readdir(): 163 ctx->pos 0
hfsplus: hfsplus_readdir(): 189 ctx->pos 1
hfsplus: hfsplus_readdir(): 264 ctx->pos 2, ino 18
hfsplus: hfsplus_readdir(): 264 ctx->pos 3, ino 19
hfsplus: hfsplus_readdir(): 264 ctx->pos 4, ino 28
hfsplus: hfsplus_readdir(): 264 ctx->pos 5, ino 118
hfsplus: hfsplus_readdir(): 264 ctx->pos 6, ino 29
hfsplus: hfsplus_readdir(): 264 ctx->pos 7, ino 30
hfsplus: hfsplus_readdir(): 264 ctx->pos 8, ino 31
hfsplus: hfsplus_readdir(): 304 ctx->pos 8
hfsplus: hfsplus_unlink():420 dir->i_ino 17, inode->i_ino 28
hfsplus: hfsplus_readdir(): 141 ctx->pos 7
hfsplus: hfsplus_readdir(): 264 ctx->pos 7, ino 31
hfsplus: hfsplus_readdir(): 264 ctx->pos 8, ino 32
hfsplus: hfsplus_readdir(): 264 ctx->pos 9, ino 33

It means that hfsplus_readdir() stopped the processing of
folder's items on ctx->pos 8, then, item with ino 28 has
been deleted and hfsplus_readdir() re-started the logic
from ctx->pos 7. As a result, previous and new sets of
folder's items have overlapping values for the case of
d_off 8.

Currently, HFS+ has very complicated and fragile logic
of rd->file->f_pos correction in hfsplus_delete_cat().
This patch removes this logic and it stores the current
pos into hfsplus_readdir_data. Finally, if rd->pos == ctx->pos
then hfsplus_readdir() tries to find the position in
b-tree's node by means of hfsplus_cat_key. This position is
used to re-start the folder's content traversal.

sudo ./check generic/637
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.1.0-rc1+ #44 SMP PREEMPT_DYNAMIC Mon May  4 15:58:45 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/637  22s ...  22s
Ran: generic/637
Passed all 1 tests

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/198
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/catalog.c    | 11 -----------
 fs/hfsplus/dir.c        | 28 +++++++++++-----------------
 fs/hfsplus/hfsplus_fs.h |  5 +----
 fs/hfsplus/inode.c      |  2 --
 fs/hfsplus/super.c      |  2 --
 5 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 9bc8a6c48fd3..776ce36cf076 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -333,7 +333,6 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	struct super_block *sb = dir->i_sb;
 	struct hfs_find_data fd;
 	struct hfsplus_fork_raw fork;
-	struct list_head *pos;
 	int err, off;
 	u16 type;
 
@@ -392,16 +391,6 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 		hfsplus_free_fork(sb, cnid, &fork, HFSPLUS_TYPE_RSRC);
 	}
 
-	/* we only need to take spinlock for exclusion with ->release() */
-	spin_lock(&HFSPLUS_I(dir)->open_dir_lock);
-	list_for_each(pos, &HFSPLUS_I(dir)->open_dir_list) {
-		struct hfsplus_readdir_data *rd =
-			list_entry(pos, struct hfsplus_readdir_data, list);
-		if (fd.tree->keycmp(fd.search_key, (void *)&rd->key) < 0)
-			rd->file->f_pos--;
-	}
-	spin_unlock(&HFSPLUS_I(dir)->open_dir_lock);
-
 	err = hfs_brec_remove(&fd);
 	if (err)
 		goto out;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 47194370c2c5..8bf6c7cdd9a8 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -185,7 +185,15 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 	}
 	if (ctx->pos >= inode->i_size)
 		goto out;
-	err = hfs_brec_goto(&fd, ctx->pos - 1);
+	rd = file->private_data;
+	if (rd && rd->pos == ctx->pos) {
+		memcpy(fd.search_key, &rd->key, sizeof(struct hfsplus_cat_key));
+		err = hfs_brec_find(&fd, hfs_find_rec_by_key);
+		if (err == -ENOENT)
+			err = hfs_brec_goto(&fd, 1);
+	} else {
+		err = hfs_brec_goto(&fd, ctx->pos - 1);
+	}
 	if (err)
 		goto out;
 	for (;;) {
@@ -261,7 +269,6 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 		if (err)
 			goto out;
 	}
-	rd = file->private_data;
 	if (!rd) {
 		rd = kmalloc_obj(struct hfsplus_readdir_data);
 		if (!rd) {
@@ -269,15 +276,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		file->private_data = rd;
-		rd->file = file;
-		spin_lock(&HFSPLUS_I(inode)->open_dir_lock);
-		list_add(&rd->list, &HFSPLUS_I(inode)->open_dir_list);
-		spin_unlock(&HFSPLUS_I(inode)->open_dir_lock);
 	}
-	/*
-	 * Can be done after the list insertion; exclusion with
-	 * hfsplus_delete_cat() is provided by directory lock.
-	 */
+	rd->pos = ctx->pos;
 	memcpy(&rd->key, fd.key, sizeof(struct hfsplus_cat_key));
 out:
 	kfree(strbuf);
@@ -287,13 +287,7 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 
 static int hfsplus_dir_release(struct inode *inode, struct file *file)
 {
-	struct hfsplus_readdir_data *rd = file->private_data;
-	if (rd) {
-		spin_lock(&HFSPLUS_I(inode)->open_dir_lock);
-		list_del(&rd->list);
-		spin_unlock(&HFSPLUS_I(inode)->open_dir_lock);
-		kfree(rd);
-	}
+	kfree(file->private_data);
 	return 0;
 }
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c..1c3ce2b9e3aa 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -214,8 +214,6 @@ struct hfsplus_inode_info {
 	sector_t fs_blocks;
 	u8 userflags;		/* BSD user file flags */
 	u32 subfolders;		/* Subfolder count (HFSX only) */
-	struct list_head open_dir_list;
-	spinlock_t open_dir_lock;
 	loff_t phys_size;
 
 	struct inode vfs_inode;
@@ -272,8 +270,7 @@ struct hfs_find_data {
 };
 
 struct hfsplus_readdir_data {
-	struct list_head list;
-	struct file *file;
+	loff_t pos;
 	struct hfsplus_cat_key key;
 };
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 036ca516d851..1de9cc97b42e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -483,8 +483,6 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 	simple_inode_init_ts(inode);
 
 	hip = HFSPLUS_I(inode);
-	INIT_LIST_HEAD(&hip->open_dir_list);
-	spin_lock_init(&hip->open_dir_lock);
 	mutex_init(&hip->extents_lock);
 	atomic_set(&hip->opencnt, 0);
 	hip->extent_state = 0;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 40a0feda716b..5777e31de45a 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -91,8 +91,6 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	HFSPLUS_I(inode)->fs_blocks = 0;
 	HFSPLUS_I(inode)->userflags = 0;
 	HFSPLUS_I(inode)->subfolders = 0;
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
 	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
-- 
2.43.0

