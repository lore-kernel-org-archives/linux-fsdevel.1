Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115A3E276D
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229718; cv=none; b=ELqhx4BpE6HdjotFWJ2+DxOJT55sXrjSyCRB1ZfUgBFBlx/238bfIyAtvinyO6xISHO7n5N3Aw4ZiPUjaHgl0Fc9cRryWf29ezey6hW0n5lkhnFDI4no3gDjkUlXlAIsJT4ZLhy6ufknAYHrrpq13g7VVEXujPfN7kU3IytZV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229718; c=relaxed/simple;
	bh=KIVHt/Acn752h2cOaLugQTdQEBPTHGaFFPjZXQHUZbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hI1nwWtsEs2sdQUicer/vxW2TG1fpwM5f38jFK6pK+i2bRFJ2/9xa8zemYvSsr7oO9KbPkw5UC56yBFPLMOHquatWxQXkhxt6v0VHEJ+ZiRYINmnMnS3OtgW9o02Fmv0wKcsWvWXWBj2p6oo/RV6H8jdlveN04eZcydPXXKPz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=mTGdCSng; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="mTGdCSng"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7c58e6eb3edso37387537b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779229716; x=1779834516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zex7Nwrg+w3EzJgM6i+AzTmX4qAFfpfNhfflpDAV6AU=;
        b=mTGdCSngv74uSdq/JdLE/55rfZ3CB7wezVxTqRsV40w9PvcBbv+Pk6IwcRcT38gr6J
         vB+n8uIMLfrcODdBFWPYrwI+91eHNynW30lZDuZjsZr1NKhvxveU1xt2Q8r9n6oW+ckc
         6IozagKMb6tKLtUhDyrrALgLv+NvQI4MVWsQ2tFpflJsaeer5dKstcNqMJGFtAbSuFnP
         NxSt6a/58CaTzA0PT+kWShRvBOR1D/FFTuPmPzgCetJGn1BcGMoW5wIpHBfX5gJW2+F5
         60BoD78xVUxuASYWFDsLTjS9uA5F9w/sepiVu+sCfkUqn4UxI3ZspA0tQtMwYtwUzRc0
         kMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229716; x=1779834516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zex7Nwrg+w3EzJgM6i+AzTmX4qAFfpfNhfflpDAV6AU=;
        b=aay1KymGPy/sLr8pBbK1XxZJLjMvLolVynmH1QDO3Avx8CFisxbwXlMIhHnnpWt3Bp
         zFMptakrO/G+tb4YdOLlxmwndGMdSlWMllVdAS0MPak6JJpEj2UiRu48DMZHmZj86FvV
         UloJl94tYoYSLaR9XrXBtTk8Joq/5ab+cIODGTMHrHSR5vzDUEoyt5EOpEL4jSKtL7dV
         F7psrye9/gpuhuVbDQBHz2/lrGSrjlAZC/Hm3sNWnbuC00d9w+1e16JZ50ZINDg7ViwU
         ylyIVT23+08cSIBZIJqNs/rcmQv98InkAnxVYSAl18eCh6IuxWACdSEu3hMqstfu8zok
         c7lg==
X-Forwarded-Encrypted: i=1; AFNElJ/jHsxRlAUubMyHPXkihpH9rHC9EBx/5vaosXElrFZoxhppvzmMNUBEvbR8VqUFW+F5RB2+fzKmgH0m6dtZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbyItzzhkxu6pKSl220US0rW2aHC/OUuebtjiMEeaM2468WXl
	Asfg4Fy4NAVo3Xth2QRqiK0i2+07B7iI8/708Q17IpyDjPgPSAusvky/wX561AB5pV8=
X-Gm-Gg: Acq92OFOTIB8S+8tmAWRCokee3fmPOjo4ieJxp6IjR/PYUuVcTos+DP4wrFOtx9qFVa
	AHtT9d7rz/69CJGarVc9zsfcPQBF4C0Pr9BPhO7A74+HH6OCqL7BT62HEHPjPQBsVY85SQanrxp
	ThMfimzUmzl8Tn2s0u+L7a0tPpTBQZxTdfw29jmAEXWENQsWZt+S+1B6cN91k3uppMCvTj+I8GT
	wJtKJndB80r9b8ysabsJoJUoGc7brfwCfTjNcq+4c1nruXwrtZVto3Gef2dKRDS41WAmo96THlR
	HGpdroJhHuVofhFvgcMvQen3EcjYeTnd7x5EiUeQrdpQr71V36azhCf9yfpvEEieTwWXoB46+if
	vlhT2evIy66nh1S/buOkV2Eqkcv4puKlaN98NKnZ9BkoQMXNsahILL6FiyyF/Ln07EpXpxxCCsA
	YMkBc7X9tMFUZjDCOqQlOn0yUchND+nt7PLAKYeaPZQx5xkFUo+GNrKRyho/RPI3n+kWyIeudZl
	onNJ5p3hyUmH7HQOaszDhQ=
X-Received: by 2002:a05:690c:9693:b0:7d0:79f:338f with SMTP id 00721157ae682-7d0079f3793mr32900097b3.33.1779229716051;
        Tue, 19 May 2026 15:28:36 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:78e9:5500:c36:65ac])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccc4sm43720977b3.31.2026.05.19.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:28:35 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: rework hfsplus_readdir() logic
Date: Tue, 19 May 2026 15:28:12 -0700
Message-ID: <20260519222811.1311071-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/637 fails with error:

FSTYP -- hfs
PLATFORM -- Linux/x86_64 kvm-xfstests 6.15.0-rc4-xfstests-g00b827f0cffa #1 SMP PREEMPT_DYNAMIC Fri May 25
MKFS_OPTIONS -- /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /vdc

QA output created by 637
entries 7 and 8 have duplicate d_off 8
Found unlinked files in open dir (see xfstests-dev/results//generic/637.full for details)

Likewise HFS+, currently, HFS has very complicated and
fragile logic of rd->file->f_pos correction in hfs_delete_cat().
This patch removes this logic and it stores the current
pos into hfs_readdir_data. Finally, if rd->pos == ctx->pos
then hfs_readdir() tries to find the position in
b-tree's node by means of hfs_cat_key. This position is
used to re-start the folder's content traversal.

sudo ./check generic/637
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.1.0-rc1+ #55 SMP PREEMPT_DYNAMIC Tue May 19 15:18:02 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/637  32s ...  31s
Ran: generic/637
Passed all 1 tests

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/65
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/catalog.c |  9 ---------
 fs/hfs/dir.c     | 28 +++++++++++-----------------
 fs/hfs/hfs.h     |  3 +--
 fs/hfs/hfs_fs.h  |  2 --
 fs/hfs/inode.c   |  4 ----
 5 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 7f5339ee57c1..1bfa36d71e24 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -340,7 +340,6 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 {
 	struct super_block *sb;
 	struct hfs_find_data fd;
-	struct hfs_readdir_data *rd;
 	int res, type;
 
 	hfs_dbg("name %s, cnid %u\n", str ? str->name : NULL, cnid);
@@ -366,14 +365,6 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 		}
 	}
 
-	/* we only need to take spinlock for exclusion with ->release() */
-	spin_lock(&HFS_I(dir)->open_dir_lock);
-	list_for_each_entry(rd, &HFS_I(dir)->open_dir_list, list) {
-		if (fd.tree->keycmp(fd.search_key, (void *)&rd->key) < 0)
-			rd->file->f_pos--;
-	}
-	spin_unlock(&HFS_I(dir)->open_dir_lock);
-
 	res = hfs_brec_remove(&fd);
 	if (res)
 		goto out;
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 702c16ea954b..509c77a99625 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -97,7 +97,15 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 	if (ctx->pos >= inode->i_size)
 		goto out;
-	err = hfs_brec_goto(&fd, ctx->pos - 1);
+	rd = file->private_data;
+	if (rd && rd->pos == ctx->pos) {
+		memcpy(fd.search_key, &rd->key, sizeof(struct hfs_cat_key));
+		err = hfs_brec_find(&fd);
+		if (err == -ENOENT)
+			err = hfs_brec_goto(&fd, 1);
+	} else {
+		err = hfs_brec_goto(&fd, ctx->pos - 1);
+	}
 	if (err)
 		goto out;
 
@@ -146,7 +154,6 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 		if (err)
 			goto out;
 	}
-	rd = file->private_data;
 	if (!rd) {
 		rd = kmalloc_obj(struct hfs_readdir_data);
 		if (!rd) {
@@ -154,15 +161,8 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		file->private_data = rd;
-		rd->file = file;
-		spin_lock(&HFS_I(inode)->open_dir_lock);
-		list_add(&rd->list, &HFS_I(inode)->open_dir_list);
-		spin_unlock(&HFS_I(inode)->open_dir_lock);
 	}
-	/*
-	 * Can be done after the list insertion; exclusion with
-	 * hfs_delete_cat() is provided by directory lock.
-	 */
+	rd->pos = ctx->pos;
 	memcpy(&rd->key, &fd.key->cat, sizeof(struct hfs_cat_key));
 out:
 	hfs_find_exit(&fd);
@@ -171,13 +171,7 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 
 static int hfs_dir_release(struct inode *inode, struct file *file)
 {
-	struct hfs_readdir_data *rd = file->private_data;
-	if (rd) {
-		spin_lock(&HFS_I(inode)->open_dir_lock);
-		list_del(&rd->list);
-		spin_unlock(&HFS_I(inode)->open_dir_lock);
-		kfree(rd);
-	}
+	kfree(file->private_data);
 	return 0;
 }
 
diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 3f2293ff6fdd..2e958c46bc0a 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -14,8 +14,7 @@
 /*======== Data structures kept in memory ========*/
 
 struct hfs_readdir_data {
-	struct list_head list;
-	struct file *file;
+	loff_t pos;
 	struct hfs_cat_key key;
 };
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..97e8d1f96d6d 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -36,8 +36,6 @@ struct hfs_inode_info {
 
 	struct hfs_cat_key cat_key;
 
-	struct list_head open_dir_list;
-	spinlock_t open_dir_lock;
 	struct inode *rsrc_inode;
 
 	struct mutex extents_lock;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index b2329de151ec..ab52ad2d2ad8 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -195,8 +195,6 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	err = -ERANGE;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
-	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
-	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
 	if (next_id > U32_MAX) {
@@ -353,8 +351,6 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	mutex_init(&HFS_I(inode)->extents_lock);
-	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
-	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 
 	/* Initialize the inode */
 	inode->i_uid = hsb->s_uid;
-- 
2.43.0

