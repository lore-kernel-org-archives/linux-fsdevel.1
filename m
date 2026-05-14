Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F63BED6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788608; cv=none; b=re9ZKsdHTcXAVlcyitsGwsH/9ml166U4DrgnQTIQbPwjDO785pvvxCfbMDp76riOYlAZ+zet21kZDU8FA58uwTCbVONqPG/zZ+yDFW/oHms/ZIxhutqQVkPB2oV7S8i2vNFdGqJxteNONd4vnfjwpp2lDPSF9LxEkwXIvM5+NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788608; c=relaxed/simple;
	bh=LRAGrgn7vwK/hWd+rQIwVSGGpZaG4rwGKgUKqWxFIao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ye/gfY2w+cWSLumG79qoXw1o4N9c6UYDbzkMfbTUnJ6WBWcXPAyjp4xLuQnlLLD9kW+TruyHaiuBhI5DSmO8hX1t7jGYendyKJOVmXyGA1L4Y5u5+ijzZtpNGoRyOr9yjdSG2bUxt3TqyHBiSApmu01wOMlruWJR03RFZHjwrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=R/su2szx; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="R/su2szx"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so10717307d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778788604; x=1779393404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tUfip5c03IVkPEOQ0+1zQ1Q++dyKHsYyMnXfVts0RE=;
        b=R/su2szxSqfKaHnYXmCdAzRwn7QVvtGGbTMU0l7wfev1kc93Yi3HOVsIl7oBtL+wtr
         55Gs3MBVWCd01VOVb2ttQNwrukgM6t/hanX2sefvpVFbTNzYq0ekP3dVQaY81e/tpuRu
         Fe7VcLFAtFrBpLCLcz3EaKuVpHO0HvQ2+DTRn1j17Y2bNvA24ytZfphVww5JwGwpNcUm
         Ol/XGAiIMq2rmPmoaqixI58lghRaFaTWt95arNoVpJslt642IkxV+ePfqzZqyf2Yj20+
         NHPfXQIKjMBx8tVjSlh3jFtxIrp1bl1m6TtSxMyaPOCFjiZVMhc0RZMc1AYi8I5TDKih
         OHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778788604; x=1779393404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tUfip5c03IVkPEOQ0+1zQ1Q++dyKHsYyMnXfVts0RE=;
        b=IMO8BAkeMRZg1LPRx3qqlFeKoUZg8DulxqTBfqe9LgW2Y+3HD/vuc0idaUTvdgqewN
         IVSLZXimU8TacWf/F1vKD1PBwJPJM2TFpRecIQ9ZvTDkUXZcc2tOLReUf6Oed4Ezz9Jl
         ffw09dmPkp9acV8m2c/B2qTNgXMtZw1bGBujHqh9uJn9gAYdagk18f4QIY7qXyE7ElD9
         8NQtbgPg+4HJMqkWSqqUsgoe/2A6QzOMqRHpKCJ1eGw8qnyt8npBJKr0vyRVyswiTFCj
         nBFt4iBqIooUBnHC+A1W3twx33Qavo/ddkkyP/IrsexG1gX8dm4q1BBh4h0CvyNZ2Q+N
         lRaw==
X-Forwarded-Encrypted: i=1; AFNElJ9FcFXdNe3nK/sgy3pvpGU3ip61LLIiZDMkKeDuPGZ10auxab4iIhXAm8vtLMZgHS6dbWEM7WxffzWOkKrM@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXhGzfBAXkP2yz5OPNYNfIAIu/VodQnPRp9V0lAXF1vp0iv67
	xxMW+/KFsNsSmtyA6W884RrRXUAv7j3yR/NNCKkQ9iZksPN/azH7Dt6umwbwvdykcAo=
X-Gm-Gg: Acq92OHfJhuO83vpGXWPDDbsW2Ybh2l8qSMbOBdiXN8T/KYYlFfmeXtGOisd1AZDNe+
	HNm5K8bU/AJ2BmW03qvupigsRJBqI0W+teEkFpufJ2vfAqoKsLiAsl+fYnO4euqbmAzrUue4LVs
	VShsWyXo5WEl0o2fI53xa+RgV6nYCbvi/unJG8ltZGqDjFuFTs62zsvv72lO4zhhkHJpaqcIDnv
	fwN5fKN419UZZfkot8CJiLrqWeywgw8GCP40Fp4rR2A44g1a1fwd42u5YCrivU3edMNlbjBly3j
	QIGOzqeDAUQ+imiXgOCvXGcQUWyGSWAKrbITAoy7JBws7WcxV/tn34ciY5jlphN+X4xlgVqa95R
	Dae+bcyEO1+QPJ0iJZUFU1vE5PZ34CtyIj3lWU962of/SXcamFt+zP4qqausKM7mI4pd5TwPlg2
	Mr4m4EHZLWeZpyoMmPLaLPODSsp7NLnHw0tDOt4VqYfulWwq81e/xYSZQhMfr7b8njJWNVB1j1C
	1JCwl0T5Ey3jHjaGAy2ZA==
X-Received: by 2002:a05:690c:d91:b0:7ba:f677:8c32 with SMTP id 00721157ae682-7c9599a5a0emr9292227b3.15.1778788604237;
        Thu, 14 May 2026 12:56:44 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1475:85f:92c5:666])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db6b47fsm1519271d50.16.2026.05.14.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:56:43 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: disable the updating of file access times (atime)
Date: Thu, 14 May 2026 12:56:31 -0700
Message-ID: <20260514195630.354206-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/003 fails with errors:

sudo ./check generic/003
FSTYP -- hfs
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #18 SMP PREEMPT_DYNAMIC Fri Mar 13 17:54:19 PDT 2026
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

output mismatch
QA output created by 003
ERROR: access time has changed for file1 after remount
ERROR: access time has changed after modifying file1
ERROR: change time has not been updated after changing file1
ERROR: access time has changed for file in read-only filesystem
Silence is golden

This patch fixes the issue with change time by
adding inode_set_ctime_current() and mark_inode_dirty()
in hfs_rename(). Also, it reworks hfs_inode_setattr() by
changing simple_inode_init_ts() on inode_set_mtime_to_ts()
and inode_set_ctime_current() calls.

HFS hasn't any field in on-disk layout that can keep
the file/folder access times (atime). It was added
setting of SB_NOATIME in SB_NOATIME.

Finally, we have only atime related errors in
generic/003 output:

sudo ./check generic/003
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.1.0-rc1+ #52 SMP PREEMPT_DYNAMIC Wed May 13 15:04:37 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

QA output created by 003
ERROR: access time has not been updated after accessing file1 first time
ERROR: access time has not been updated after accessing file2
ERROR: access time has not been updated after accessing file3 second time
ERROR: access time has not been updated after accessing file3 third time
Silence is golden

The generic/003 test-case needs to be disabled for HFS case
because it cannot support the file/folder access times (atime).

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/3
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/dir.c   |  9 +++++++--
 fs/hfs/inode.c | 15 ++++++++++-----
 fs/hfs/super.c |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index f5e7efe924e7..702c16ea954b 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -306,10 +306,15 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	res = hfs_cat_move(d_inode(old_dentry)->i_ino,
 			   old_dir, &old_dentry->d_name,
 			   new_dir, &new_dentry->d_name);
-	if (!res)
+	if (!res) {
+		struct inode *inode = d_inode(old_dentry);
+
 		hfs_cat_build_key(old_dir->i_sb,
-				  (btree_key *)&HFS_I(d_inode(old_dentry))->cat_key,
+				  (btree_key *)&HFS_I(inode)->cat_key,
 				  new_dir->i_ino, &new_dentry->d_name);
+		inode_set_ctime_current(inode);
+		mark_inode_dirty(inode);
+	}
 	return res;
 }
 
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 89b33a9d46d5..d52f7bcf13cd 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -348,6 +348,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	struct hfs_iget_data *idata = data;
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
 	hfs_cat_rec *rec;
+	struct timespec64 mtime;
 
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
@@ -383,8 +384,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
 			inode->i_mode |= S_IWUGO;
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
-		inode_set_mtime_to_ts(inode,
-				      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->file.MdDat))));
+		mtime = hfs_m_to_utime(rec->file.MdDat);
+		inode_set_ctime_to_ts(inode, mtime);
+		inode_set_atime_to_ts(inode, mtime);
+		inode_set_mtime_to_ts(inode, mtime);
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -394,8 +397,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-		inode_set_mtime_to_ts(inode,
-				      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
+		mtime = hfs_m_to_utime(rec->dir.MdDat);
+		inode_set_ctime_to_ts(inode, mtime);
+		inode_set_atime_to_ts(inode, mtime);
+		inode_set_mtime_to_ts(inode, mtime);
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
@@ -665,7 +670,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 		truncate_setsize(inode, attr->ia_size);
 		hfs_file_truncate(inode);
-		simple_inode_init_ts(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..a466c401f6bb 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -338,7 +338,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->sb = sb;
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
-	sb->s_flags |= SB_NODIRATIME;
+	sb->s_flags |= SB_NOATIME | SB_NODIRATIME;
 	mutex_init(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
-- 
2.43.0

