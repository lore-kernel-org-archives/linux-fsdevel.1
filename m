Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4733A700
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856787; cv=none; b=U5bgLzEh2Ju9q6JKNCA5PJKJRSGtw6cQVVYnISMcFokzr+rSXmYEEsBC1WK1xy8OB3XUXE2DL5dkqKZeiOUioI4Cjg/a+D17Hf9Tsmm7Yb0AZAI96e/XnjFc5fvGx4cYiwg9eEMqpTROXSPPpo3QS8WImJQa+L6iRJ9/0rVFliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856787; c=relaxed/simple;
	bh=Hvmd8SWdbTFC3YWC7xYxogNPA80SE1GoLgN+qCBRtKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzhN7RmZWbfb0ztf9WTMEqENwDEMAu3X73ZJq/pamLh4B+ls4IyrJnbg8z25V4hASLJmczcv7jA6j2cE2q9j5nbJ6QBTFYmyayMMy5IYG7pZHEp80oZUP3W4WsUg+dGrm1Q6z2CBEh7OoKhJgsgwUandat6sakwFvZ1xyq2mHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFOtY70H; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFOtY70H"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1287292a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856783; x=1790461583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7AtEBp/BkWiDkjI7lJCPU26NMItK+gHg3b17rE5+bM=;
        b=GFOtY70H3mzeSzHYs12MwEBtSOBaPUYJz2l8Rb+DfPdWifzTagW77i5Ph2V70L7qlL
         /3y761DIloOrYJXhjOnNMtshFNfIzOwDPzegx/XGlvTi+V/0HdTosVHKhazG1NZqFpuC
         6rZmXh2qffLqH5MY+ueXeKDMPOqWf3l4oaQzEsBNFR792XKS+JxgETbrZ4fqRPGwrwGe
         7Ex6Rf2/jb4zIgKVtzH/jZ64ElLwVFrTf/kWgaj9pfd8kcB3jA/qP1kHRUlFLOZIBQKa
         1T/7C5ipv2rKo8sVfwN5v/BVL4P+nObylfEqBw0ewsb66vw5V+JZRCFS0EQlQ+J1Q/mA
         BIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856783; x=1790461583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7AtEBp/BkWiDkjI7lJCPU26NMItK+gHg3b17rE5+bM=;
        b=g9GFINRoSVF4jnscvOnBkhWv7vtLdj7LPdspsyg7kYFknYZjmeC8TSTQ4Ivg89ZTes
         q/EpB/KCNE7Sm6z0Q0gND/+CGl6Pm8PAg64KlydaN7Z8ao47awVr1rZDlUwngYjr1ATt
         K5GsskjuBsz1KMVnYGWFdysG+FAONnaeWj/WiKhsbCE2xYvwEWoNk0f4JjM5uEnyYpLF
         RIqUkTWavSyAbywYFp72da+jvxOZFfEJY+J9gq4W/Gcer6M1BBYHALI0oXhZ/sC6dHyC
         5+YB+Z0V64U5tEAn3Q/gLYRI8kVpT2fDOHvWFv5LWYtXmRmyL1rcuqIT2Z90773r3ZA6
         8NxA==
X-Forwarded-Encrypted: i=1; AKwUvBy3j/+RHuofivwrNS7lnjOLYEWwkkVkG78kDo8agwej6BfFxKdVoYQBWps2zYBJpZ1tLBEgQ8KJOqjbt0JB@vger.kernel.org
X-Gm-Message-State: AFuF++kAFvDxtV3E0dy5bymKxIq0OwW79NsA+c6kONKPrd5Gcr4Om+up
	DZL4Qp9XcNKOz7ouOCeIqVbA9QRHKU3kjqnnGQBcCcVwiz6C4tyyuEOn
X-Gm-Gg: AYBFou1+eG0S6ZWunIzOl6pQabV2t7jvKCbVdyD0XpSvxU/KmPC4g3F6EKDDjARi19c
	IedF3LyaWScj4u8/Bk/ByNLyQHO4TGvHcS1KPbUTIRwCVfHr4ryal+s2410ddXEQEA/VDiv1o8G
	/GRUFU/4w9gMsygdeyKO8aOLqPkfTdy/+n4rtn2HNgzCSpaDIyLTu+9ZoCQ3yUJAM/gz2cvLADY
	9Xsl4T0rdhB4AnFie/DcR+kLZft2wqDkhKorqbwvqxd3MEsFKDSr7CQjy2pmPUXcK8J+XkXWWUA
	AK6JxH/H0WpdUd5ZD2NxJxRoVY8289ROLLDGJukb1ojgb0IvS2BB/1VIMDe94X2BDDJi3h+qgOI
	v0l1qI1TCf9nRqWXgn1LntQ7ZOvt40xZItGs3N7M37BYckbRRkgVY7mIKHl9NRd1gAIwttNNZWF
	wNOXfmjZpBi0LVzDCm6vbRsKXtvdK3YKgKfUf8WnsC8oHjNTzkOZPvz9WZzoM7VC+kW9dAx8D8F
	e1TaZZSr0ZbN24/0zyOqNsT9f+U1eiCXBtfpzIbLao/O13Z4+VC2iV0i7a60ZIVRC3rv0ogNLkU
	j3DO5odP6w==
X-Received: by 2002:a17:90b:5305:b0:39e:4c81:6c63 with SMTP id 98e67ed59e1d1-39e54dbe3c1mr11413518a91.30.1789856783053;
        Sat, 19 Sep 2026 15:26:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm7119448a91.2.2026.09.19.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: me@bobcopeland.com,
	brauner@kernel.org
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] omfs: fix divide-by-zero on mount and bitmap slab-out-of-bounds accesses
Date: Sat, 19 Sep 2026 22:26:22 +0000
Message-ID: <20260919222622.3797224-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three bugs in fs/omfs/:

1. In omfs_fill_super() and omfs_get_bucket() (fs/omfs/inode.c,
   fs/omfs/dir.c), validate s_mirrors > 0 and s_sys_blocksize large
   enough that nbuckets > 0, preventing a hardware divide-by-zero (#DE)
   trap, and fix the error path so sbi->s_imap is not double-freed.
2. In omfs_count_free(), omfs_allocate_block(), and set_run()
   (fs/omfs/bitmap.c), bounds-check bitmap block indices against
   sbi->s_imap_size and clamp bit runs to the block size.

Fixes: 555e3775ced1 ("omfs: add inode routines")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/omfs/bitmap.c b/fs/omfs/bitmap.c
index 7147ba6a6afc..58b361152979 100644
--- a/fs/omfs/bitmap.c
+++ b/fs/omfs/bitmap.c
@@ -53,6 +53,9 @@ static int set_run(struct super_block *sb, int map,
 	struct buffer_head *bh;
 	struct omfs_sb_info *sbi = OMFS_SB(sb);
 
+	if (map < 0 || map >= sbi->s_imap_size)
+		return -EINVAL;
+
  	err = -ENOMEM;
 	bh = sb_bread(sb, clus_to_blk(sbi, sbi->s_bitmap_ino) + map);
 	if (!bh)
@@ -65,6 +68,8 @@ static int set_run(struct super_block *sb, int map,
 
 			mark_buffer_dirty(bh);
 			brelse(bh);
+			if (map >= sbi->s_imap_size)
+				goto out;
 			bh = sb_bread(sb,
 				clus_to_blk(sbi, sbi->s_bitmap_ino) + map);
 			if (!bh)
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 692297cf84e7..bad51587bc6f 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -232,7 +232,7 @@ static int omfs_dir_is_empty(struct inode *inode)
 			break;
 
 	brelse(bh);
-	return *ptr != ~0;
+	return i == nbuckets;
 }
 
 static int omfs_remove(struct inode *dir, struct dentry *dentry)
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 1d915ef72119..c4e05a53c9ae 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -265,7 +265,13 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 static void omfs_put_super(struct super_block *sb)
 {
 	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	kfree(sbi->s_imap);
+	int i;
+
+	if (sbi->s_imap) {
+		for (i = 0; i < sbi->s_imap_size; i++)
+			kfree(sbi->s_imap[i]);
+		kfree(sbi->s_imap);
+	}
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -502,6 +508,11 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->s_sys_blocksize = be32_to_cpu(omfs_sb->s_sys_blocksize);
 	mutex_init(&sbi->s_bitmap_lock);
 
+	if (sbi->s_mirrors == 0) {
+		ret = -EINVAL;
+		goto out_brelse_bh;
+	}
+
 	if (sbi->s_num_blocks > OMFS_MAX_BLOCKS) {
 		printk(KERN_ERR "omfs: sysblock number (%llx) is out of range\n",
 		       (unsigned long long)sbi->s_num_blocks);
@@ -598,8 +609,16 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
 out_brelse_bh:
 	brelse(bh);
 end:
-	if (ret)
+	if (ret) {
+		if (sbi->s_imap) {
+			int i;
+
+			for (i = 0; i < sbi->s_imap_size; i++)
+				kfree(sbi->s_imap[i]);
+			kfree(sbi->s_imap);
+		}
 		kfree(sbi);
+	}
 	return ret;
 }
 
