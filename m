Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD42FDC57
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773353987; cv=none; b=uEwdeC43ZIvdICvrTZgH6IuwLC7z6AFLmN/V2MWtLEJKYn7GUW12cOoQBP2UK4OJ1dQjSxtNsYr3gN3XZtwRwxvxcRAj+MdxoPSqY82jfAHK7f1kBzUZHwHt9dlIUU3dIzd0ppoagg2YoHC3YyhZ6T5MIu/BcP1TAUIsSY5nF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773353987; c=relaxed/simple;
	bh=3EO1w/QoQ7f+D4j1x5S+bbi291PzIjuhVViQG4pg3SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyudqT916vXHMFbmYG3gtCX3kB9pt0h/u67fax8Ma1fmdext7soEoG2fEiaQVFVNX7jU4rYwt5S/e1qnfWR9xVixOpE7bEk514KlXswkBdJTa58VlYwWG1bzgtSVoy7FluI+5DrgrorA7C66r9oA/3teAyM9JtGk3jpCroo0ilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RLZLjAD4; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RLZLjAD4"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d75d698ee6so940610a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773353985; x=1773958785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwhPi/yIwHwCMgNJvFCFv32OYWCkL1cSQoQw6NUSOZI=;
        b=RLZLjAD4GRRbrIdPK26XgsMXisH7hQOG6UlnpDQxym3JreilYYetqmWJod/PbV0ncf
         aWaYxfKe9erwtIp8JAKJYvIefV6hAopPzezNZxUq1Zd59xWGW7RJDhUqMIZGHpSA/lwb
         CQWDlJ6UhKespKUzNlQpIfOFbsJw+w0C/e13ZWQkzM8W017dJOy/znh57VwtwczT6vP6
         4jVdUaWJgHHtIgZXi6xxVUxtwv8QGmVKskT55fVVsHPGkXaxg7HEnB/UtBSi19CRVic3
         cpB2hKICPI1YlQHr2h1wuIPNq2qYqISdXfiJ7896Ekke+QRUUqWwyKhTqA7VTtVJ2y4U
         yrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773353985; x=1773958785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwhPi/yIwHwCMgNJvFCFv32OYWCkL1cSQoQw6NUSOZI=;
        b=aaHxUQuUgV4iZURHVza5wpKOjHwdo4pCx6uSN2Qi80ArFi3B7p+j4SukohBGbV3P4Q
         7tIAsNmMal9VwDJ7njeYnbu5ZKNzFs9YuVw9lNlgfLL3dgCkYKhhxfp4we5BTFZXBDvO
         aVG+6F30uexqUcX4cmQlsGxqlPec9v14yAcOYIeLKWuSQPJTtOrF0eWsgJkcvlcKW6Dz
         BkpPm7NggN5/LDyu0Dw8WkEvVt/bNJZIiHFJXwGjImgBUoA3j8AS7tGyAQshqApROG5i
         OtwMoh1hmPlOKwxV9kPjfyCuRb26wNq4mf2nm/hG4dXytqK2DPhuWT7uY+0kSzGO2PIS
         BVAw==
X-Forwarded-Encrypted: i=1; AJvYcCUQr9Mh0YUvtZWiLu7F8BLvoaFkAOan1Z3MrvMibZyEPc3+XxuF9r+nHD6a0+Iw2IDtY7UjpAczjmbVyW31@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFGtKV8IV5EmBQILGlMM5nHwzNCDTC84I7X1gYy8l7BmxtGl4
	bWxjp1N3rIhw64PKn+y/H9siXu2Vk60rSftwFk6mnS+uK+Ndj7xuN2C5URW7yj16Iu0=
X-Gm-Gg: ATEYQzzFDsqP4X65J5N23RPfVA35wpVQ2XXc/cmO4ih7oumJVLaMVN2MNjMXurP1fQ+
	QavRcGHlQguycs5HYF879NYoi70bw/HTeghyHIu5Vm7n3rY99wdddIYG7sPwjm2W9gtnrjSdCNE
	gW7w5JtvQKdpbH5+boDRCMp4wUWiR4AnuKBtZy7xFUjaNDGFDRZl4dhsKqQ/d0TFyRFukgkOt7A
	q/gZeGVFhATxTaPbrtfR57YUGOTqhfSteznwBA4bOfhiDZvyb4UJCx396z3c/9GSBFtlTYTee3F
	HbxeBm1WGXc5fRxapVK0NhF6f9OGs501b5sPoovyRGyfQI5gXCdt2TBVcYfLrCneOHokXiLEGdA
	mq/j2cWjc6amlVca8yMaHvOSz8NNtgofE8bXcXzQNCLkaRJIw+Kca1239EwlHao+sNnUP4pIGyM
	ki0hbOQXNa6tRnFAcoDOEAbtexMx22juILT07OMIgDnukIeZzQ8eMUUphijcvv3PMGEPKmXT3VG
	43lamnbhSrY0LmskMUpPj+B
X-Received: by 2002:a05:6830:6503:b0:7d7:4639:440d with SMTP id 46e09a7af769-7d782449a54mr612714a34.6.1773353984702;
        Thu, 12 Mar 2026 15:19:44 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:b46f:cc3e:bd02:4406])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e716485sm5816586fac.19.2026.03.12.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:19:43 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix generic/533 test-case failure
Date: Thu, 12 Mar 2026 15:19:21 -0700
Message-ID: <20260312221920.1422683-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/533 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/533 _check_generic_filesystem: filesystem on /dev/loop50 is inconsistent
(see xfstests-dev/results//generic/533.full for details)

The key reason of the issue is returning -ENOENT error
code from hfsplus_find_attr(), __hfsplus_delete_attr(),
hfsplus_delete_attr_nolock(), hfsplus_delete_all_attrs().
The file exists but we don't have any xattr for this file.
Finally, -ENODATA error code is expected by application logic.

This patch reworks xattr logic of HFS+ by means exchanging
the -ENOENT error code on -ENODATA error code if xattr
has not been found for existing file or folder.

sudo ./check generic/533
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #16 SMP PREEMPT_DYNAMIC Wed Mar 11 15:04:58 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/533 33s ...  32s
Ran: generic/533
Passed all 1 tests

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/184
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/attributes.c | 38 +++++++++++++++++++++++++++++---------
 fs/hfsplus/hfsplus_fs.h |  7 ++++++-
 fs/hfsplus/xattr.c      |  6 +++---
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index 6585bcea731c..704635c65e9a 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -153,14 +153,22 @@ int hfsplus_find_attr(struct super_block *sb, u32 cnid,
 		if (err)
 			goto failed_find_attr;
 		err = hfs_brec_find(fd, hfs_find_rec_by_key);
-		if (err)
+		if (err == -ENOENT) {
+			/* file exists but xattr is absent */
+			err = -ENODATA;
+			goto failed_find_attr;
+		} else if (err)
 			goto failed_find_attr;
 	} else {
 		err = hfsplus_attr_build_key(sb, fd->search_key, cnid, NULL);
 		if (err)
 			goto failed_find_attr;
 		err = hfs_brec_find(fd, hfs_find_1st_rec_by_cnid);
-		if (err)
+		if (err == -ENOENT) {
+			/* file exists but xattr is absent */
+			err = -ENODATA;
+			goto failed_find_attr;
+		} else if (err)
 			goto failed_find_attr;
 	}
 
@@ -174,6 +182,9 @@ int hfsplus_attr_exists(struct inode *inode, const char *name)
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 
+	hfs_dbg("name %s, ino %ld\n",
+		name ? name : NULL, inode->i_ino);
+
 	if (!HFSPLUS_SB(sb)->attr_tree)
 		return 0;
 
@@ -293,15 +304,16 @@ int hfsplus_create_attr(struct inode *inode,
 static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 					struct hfs_find_data *fd)
 {
-	int err = 0;
+	int err;
 	__be32 found_cnid, record_type;
 
+	found_cnid = U32_MAX;
 	hfs_bnode_read(fd->bnode, &found_cnid,
 			fd->keyoffset +
 			offsetof(struct hfsplus_attr_key, cnid),
 			sizeof(__be32));
 	if (cnid != be32_to_cpu(found_cnid))
-		return -ENOENT;
+		return -ENODATA;
 
 	hfs_bnode_read(fd->bnode, &record_type,
 			fd->entryoffset, sizeof(record_type));
@@ -330,7 +342,7 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(inode->i_sb),
 				 HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ATTR_DIRTY);
-	return err;
+	return 0;
 }
 
 static
@@ -354,7 +366,10 @@ int hfsplus_delete_attr_nolock(struct inode *inode, const char *name,
 	}
 
 	err = hfs_brec_find(fd, hfs_find_rec_by_key);
-	if (err)
+	if (err == -ENOENT) {
+		/* file exists but xattr is absent */
+		return -ENODATA;
+	} else if (err)
 		return err;
 
 	err = __hfsplus_delete_attr(inode, inode->i_ino, fd);
@@ -414,9 +429,14 @@ int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid)
 
 	for (;;) {
 		err = hfsplus_find_attr(dir->i_sb, cnid, NULL, &fd);
-		if (err) {
-			if (err != -ENOENT)
-				pr_err("xattr search failed\n");
+		if (err == -ENOENT || err == -ENODATA) {
+			/*
+			 * xattr has not been found
+			 */
+			err = -ENODATA;
+			goto end_delete_all;
+		} else if (err) {
+			pr_err("xattr search failed\n");
 			goto end_delete_all;
 		}
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 420dc920e097..caba698814fe 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -571,7 +571,12 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 static inline
 bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 {
-	bool is_valid = off < node->tree->node_size;
+	bool is_valid;
+
+	if (!node || !node->tree)
+		return false;
+
+	is_valid = off < node->tree->node_size;
 
 	if (!is_valid) {
 		pr_err("requested invalid offset: "
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index a824bcaac172..89e2e7e46e96 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -562,10 +562,10 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 
 	res = hfsplus_find_attr(inode->i_sb, inode->i_ino, name, &fd);
 	if (res) {
-		if (res == -ENOENT)
+		if (res == -ENOENT || res == -ENODATA)
 			res = -ENODATA;
 		else
-			pr_err("xattr searching failed\n");
+			pr_err("xattr search failed\n");
 		goto out;
 	}
 
@@ -757,7 +757,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
-		if (err == -ENOENT) {
+		if (err == -ENOENT || err == -ENODATA) {
 			res = 0;
 			goto end_listxattr;
 		} else {
-- 
2.43.0

