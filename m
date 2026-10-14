Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C231B130
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938277; cv=none; b=Z4IysHMIu6QH52VLE7V1KVmI0Ih/GU6KGlnxaJ1PlU9UrZl5gDCPotmcXXYGeNKhZUtw6rSrsIdEr1qw1ClIU2UTiC2Obznta+qKtnQ8y4JOWU1ce7CTKXSXtGYtCKue7yjEB66qY/fOabQkzO1pDJujtToXy3LQ1Zv5y+A1aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938277; c=relaxed/simple;
	bh=imnwL4fXgIYkkD/JA/JlKie1gpJ15Od6kignYphjV2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrAk7d+s4IthW8S/Z4zvojnsszwP/BQ63F0ps1ugdOf1nljuLEswRebtxIwE05ZyjqQ56OEZjbYzSUbXXQ0fh+JjrZGc7y6U4OSHkC+EaDdUwz4gazIajMrMKeI4FLpAzYcqthPCiTx//8fOLVWLsJZ4YcLI6g2eGXwyyrZDi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=JfZh1ziZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="JfZh1ziZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8726acc5eadso28389547b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 17:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791938273; x=1792543073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dEmQ8zEiN/32BuJ67BePaUFQm64RAD0KljLmDtGyKSo=;
        b=JfZh1ziZSWLy0yEpYUAlB6i+CQug2Pliltzlw6pBu/chWlZW3dt4++pIC3x1N+9w2m
         P/32Tkk5mB4NeAxdfaHGyuhXG8TsxT9WO5WQyVxn/XkF42PwVW/Lna16GqKz3PiVxaPa
         jXKHac+E5CGmEkemqnu+/TvrKiM6DwFBcDyMWpUtW96EJMN9Ru+rBpwg7cANcKPIKQAo
         aYor73n/lG0QtXekbklhckDuYVp623XuznhZww05LofRy1g7PoiBq6fgMB/rY+SFDyU9
         BxETrhExgIQI3ZBHr9uWM2CwdFjFlJP5XfSJiOYXhlJ4h9lTVxSzwE1q3yr2dkGnPx2b
         tkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791938273; x=1792543073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dEmQ8zEiN/32BuJ67BePaUFQm64RAD0KljLmDtGyKSo=;
        b=ufzdMT9wodQSvecwguiEXyKCPkKcNCjjxbYNUjmBDPQb5KVp9T8s6t3xse7kzHJxYt
         FCqZcWKoBxg566YvKlOBsrcI61Trw8+MzMTkabcL/3R8X9aHL98TVaeu66ZKZW1VQQRj
         KDQ5t77YlvNs4gN8HvLeu0zPqcDONwl4egFp4Ih41kYMjPoSArIJuhySJ7QeaUYWiUGH
         G4L4QyFfJR1ptMDFTBtQ9GEzS2XXGmMwybQyzb7TcdGtDrMekXEpOWQhTVrsLT1NEJw0
         jqg1BBIyjxWSvhWJNBf15i1ZlQOLg8WFLhWbOt7sDc9zhoYrVW76tCinfT1oARzgAlUc
         FIVw==
X-Gm-Message-State: AFq9FYKVEEdXFGe0OE1QicC/hf8fZ0IRI4xrbTbWH6hXlIS2lkpvevZi
	NxhXEXGbia2tSYJTD975pTRc+rMockdoJRs1+v2++AFfAtxGf2DopvIc36M1wIRxIro=
X-Gm-Gg: AYBFou2TeXV+T3Vr8kkn934SDsOYw2oHgLzCHYPDyRtw5LJ7r7W6WJ44r/oAdASgKYI
	initLKAJNvXEhToUpKR4nzJQegR1GkW7EB1eJm3CMyMiXrU+WGg6AR/xxxrblsDYvL4mLErh2v8
	SKHwinfqKDi1bxLD1b/Pj4swwo7oHN/c2cn9MJ8JvKsGwlO/0UFqVbq2NhqWLF4seESIWEYTbj1
	p0hblOcqQxt3b+lOMAtJBolG/uMKBuJHD/nnm4sl4BTt9J6GvhHJHrA6LUp6kaRKn4+HwZcKVKx
	qiRqpDnzW+KLFPsIHwTGt/orHWQ0YhVYd7g4uvWBT15W6jF2EA1mq0BziMphYF2t4Y/xzSqF4F+
	7MKHVUodPP9YTJvTRx0RfEIrj7qEwzQ/MisTJkRrzEPH1Q8eEppLUZegb7NVOPlmJE6rxsE49kV
	h61wuxm73fZpz36wV5DeNoMA6O/xWtfdR1hxj6RFQRzHbg0mIfRxCkix80ZRFYPmoUNJuOjeHxt
	V0zv0uwzoCSG9kiPWCy+Dhd7WYzkZ2RptZSQeVf39s9MQ/6z09N0s+nNmJgIVEc7iuziTnxSJGk
	YNcMWcbNIzOHhDr01DG4CPvCLOk3
X-Received: by 2002:a05:690e:13cc:b0:677:d251:ccf2 with SMTP id 956f58d0204a3-67936aa4e70mr4709122d50.87.1791938272400;
        Tue, 13 Oct 2026 17:37:52 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:98d3:ec2f:c938:3bc1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a15c13sm463194d50.7.2026.10.13.17.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:37:51 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 2/3] hfsplus: store timestamps after February 2040 in xattrs
Date: Tue, 13 Oct 2026 17:37:30 -0700
Message-ID: <20261014003731.369728-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014003731.369728-1-slava@dubeyko.com>
References: <20261014003731.369728-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timestamp wrapping issue has been fixed but it
restricts the supported time range to the one that the 32-bit
on-disk field can represent: from January 1, 1904 till
February 6, 2040. Any timestamp after February 6, 2040 is
clamped now.

Extend the supported time range by means of internal extended
attributes. If a timestamp cannot be represented by the 32-bit
on-disk field, then the maximal value (0xFFFFFFFF,
HFSPLUS_EXT_TIMESTAMP_MARK) is stored into the catalog record
and the real value is stored into the xattr of the catalog
record as big-endian 64-bit number of seconds since
January 1, 1970:

linux_hfs.create_date_u64
linux_hfs.content_mod_date_u64
linux_hfs.attribute_mod_date_u64
linux_hfs.access_date_u64

The HFSPLUS_XATTR_EXISTS flag of the catalog record is kept
in sync with the presence of xattrs. As a result, sb->s_time_max
is set to TIME64_MAX.

Read path: if the on-disk timestamp is equal to
HFSPLUS_EXT_TIMESTAMP_MARK, then hfsplus_read_timestamp() takes
the real value from the xattr. If the xattr is absent (for
example, the record has been created by Mac OS X or the volume
has no Attributes File), then HFS_MAX_TIMESTAMP_SECS is used.

Write path: hfsplus_cat_write_inode() stores the timestamps
while the catalog tree is locked. It is the same lock ordering
(catalog tree -> attributes tree) that __hfsplus_setxattr()
uses. The hfsplus_set_attr_cnid() method has been introduced
to create or replace the xattr of a given catalog record ID.
The xattr is not rewritten if the timestamp has not been
changed. The stale xattr is removed if the timestamp becomes
representable by the on-disk field again. The per-inode
HFSPLUS_I_{A,M,C}TIME_XATTR bits track which timestamps are
stored in xattrs. A failure of the xattr operation is not
fatal: the timestamp is clamped by HFS_MAX_TIMESTAMP_SECS and
the rest of the catalog record is saved anyway.

Creation date: hfsplus_create_cat() stores the creation date
into the xattr if the record is created after February 2040.
The hfsplus_inode_info keeps the on-disk value (create_date)
and the real value (birthdate). The getattr() method reports
birthdate as btime. A hard link record inherits the creation
date of the hidden directory without changing the creation date
of the linked inode. The is_create_date_identical() method
compares the 64-bit creation dates in hfsplus_lookup() if
the on-disk values are equal to HFSPLUS_EXT_TIMESTAMP_MARK.

Other changes:
(1) __hfsp_ut2mt() clamps the value into the supported range
    instead of wrapping it.
(2) hfsplus_create_attributes_file() stores the fork of
    Attributes File into the volume header right away.
    Otherwise, if Attributes File is created by
    hfsplus_cat_write_inode() in the middle of sync,
    the writeback can skip the dirty Attributes File inode
    and the volume header is committed without it.
(3) The internal linux_hfs.* xattrs are hidden from listxattr()
    and cannot be retrieved or changed by means of
    the osx.* namespace.
(4) The -ENODATA error code is treated as an absent xattr
    in the getxattr and remove logic.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/attributes.c |  85 +++++++++---
 fs/hfsplus/catalog.c    | 110 +++++++++++++--
 fs/hfsplus/dir.c        |  49 ++++++-
 fs/hfsplus/hfsplus_fs.h |  45 +++++-
 fs/hfsplus/inode.c      | 297 +++++++++++++++++++++++++++++++++++++---
 fs/hfsplus/super.c      |   4 +
 fs/hfsplus/xattr.c      | 202 ++++++++++++++++++++++++---
 fs/hfsplus/xattr.h      |  32 ++++-
 8 files changed, 744 insertions(+), 80 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index 7c2e589d4553..51b18d780f2c 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -206,7 +206,8 @@ int hfsplus_attr_exists(struct inode *inode, const char *name)
 }
 
 static
-int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
+int hfsplus_create_attr_nolock(struct inode *inode, u32 cnid,
+				const char *name,
 				const void *value, size_t size,
 				struct hfs_find_data *fd,
 				hfsplus_attr_entry *entry_ptr)
@@ -215,12 +216,12 @@ int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
 	int entry_size;
 	int err;
 
-	hfs_dbg("name %s, ino %llu\n",
-		name ? name : NULL, inode->i_ino);
+	hfs_dbg("name %s, ino %llu, cnid %u\n",
+		name ? name : NULL, inode->i_ino, cnid);
 
 	if (name) {
 		err = hfsplus_attr_build_key(sb, fd->search_key,
-						inode->i_ino, name);
+						cnid, name);
 		if (err)
 			return err;
 	} else
@@ -229,7 +230,7 @@ int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
 	/* Mac OS X supports only inline data attributes. */
 	entry_size = hfsplus_attr_build_record(entry_ptr,
 					HFSPLUS_ATTR_INLINE_DATA,
-					inode->i_ino,
+					cnid,
 					value, size);
 	if (entry_size == HFSPLUS_INVALID_ATTR_RECORD) {
 		if (size > HFSPLUS_MAX_INLINE_DATA_SIZE)
@@ -289,8 +290,8 @@ int hfsplus_create_attr(struct inode *inode,
 	if (err)
 		goto failed_create_attr;
 
-	err = hfsplus_create_attr_nolock(inode, name, value, size,
-					 &fd, entry_ptr);
+	err = hfsplus_create_attr_nolock(inode, (u32)inode->i_ino, name,
+					 value, size, &fd, entry_ptr);
 	if (err)
 		goto failed_create_attr;
 
@@ -347,18 +348,19 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 }
 
 static
-int hfsplus_delete_attr_nolock(struct inode *inode, const char *name,
+int hfsplus_delete_attr_nolock(struct inode *inode, u32 cnid,
+				const char *name,
 				struct hfs_find_data *fd)
 {
 	struct super_block *sb = inode->i_sb;
 	int err;
 
-	hfs_dbg("name %s, ino %llu\n",
-		name ? name : NULL, inode->i_ino);
+	hfs_dbg("name %s, ino %llu, cnid %u\n",
+		name ? name : NULL, inode->i_ino, cnid);
 
 	if (name) {
 		err = hfsplus_attr_build_key(sb, fd->search_key,
-						inode->i_ino, name);
+						cnid, name);
 		if (err)
 			return err;
 	} else {
@@ -373,7 +375,7 @@ int hfsplus_delete_attr_nolock(struct inode *inode, const char *name,
 	} else if (err)
 		return err;
 
-	err = __hfsplus_delete_attr(inode, inode->i_ino, fd);
+	err = __hfsplus_delete_attr(inode, cnid, fd);
 	if (err)
 		return err;
 
@@ -403,7 +405,7 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
 	if (err)
 		goto out;
 
-	err = hfsplus_delete_attr_nolock(inode, name, &fd);
+	err = hfsplus_delete_attr_nolock(inode, (u32)inode->i_ino, name, &fd);
 	if (err)
 		goto out;
 
@@ -481,12 +483,12 @@ int hfsplus_replace_attr(struct inode *inode,
 	if (err)
 		goto failed_replace_attr;
 
-	err = hfsplus_delete_attr_nolock(inode, name, &fd);
+	err = hfsplus_delete_attr_nolock(inode, (u32)inode->i_ino, name, &fd);
 	if (err)
 		goto failed_replace_attr;
 
-	err = hfsplus_create_attr_nolock(inode, name, value, size,
-					 &fd, entry_ptr);
+	err = hfsplus_create_attr_nolock(inode, (u32)inode->i_ino, name,
+					 value, size, &fd, entry_ptr);
 	if (err)
 		goto failed_replace_attr;
 
@@ -497,3 +499,54 @@ int hfsplus_replace_attr(struct inode *inode,
 	hfsplus_destroy_attr_entry(entry_ptr);
 	return err;
 }
+
+/*
+ * Create or replace the xattr @name of catalog record @cnid.
+ * The @inode is used only for access to the superblock and for
+ * marking the attributes tree as dirty. It is the caller's
+ * responsibility to set HFSPLUS_XATTR_EXISTS in the catalog record.
+ */
+int hfsplus_set_attr_cnid(struct inode *inode, u32 cnid,
+			  const char *name,
+			  const void *value, size_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct hfs_find_data fd;
+	hfsplus_attr_entry *entry_ptr;
+	int err = 0;
+
+	hfs_dbg("name %s, ino %llu, cnid %u\n",
+		name ? name : NULL, inode->i_ino, cnid);
+
+	if (!HFSPLUS_SB(sb)->attr_tree) {
+		pr_err("attributes file doesn't exist\n");
+		return -EINVAL;
+	}
+
+	entry_ptr = hfsplus_alloc_attr_entry();
+	if (!entry_ptr)
+		return -ENOMEM;
+
+	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
+	if (err)
+		goto failed_init_set_attr;
+
+	/* Fail early and avoid ENOSPC during the btree operation */
+	err = hfs_bmap_reserve(fd.tree, fd.tree->depth + 1);
+	if (err)
+		goto failed_set_attr;
+
+	err = hfsplus_delete_attr_nolock(inode, cnid, name, &fd);
+	if (err && err != -ENOENT && err != -ENODATA)
+		goto failed_set_attr;
+
+	err = hfsplus_create_attr_nolock(inode, cnid, name,
+					 value, size, &fd, entry_ptr);
+
+failed_set_attr:
+	hfs_find_exit(&fd);
+
+failed_init_set_attr:
+	hfsplus_destroy_attr_entry(entry_ptr);
+	return err;
+}
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index fe11c4b6dd99..d710419db359 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -12,6 +12,7 @@
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
+#include "xattr.h"
 
 int hfsplus_cat_case_cmp_key(const hfsplus_btree_key *k1,
 			     const hfsplus_btree_key *k2)
@@ -102,10 +103,63 @@ void hfsplus_cat_set_perms(struct inode *inode, struct hfsplus_perm *perms)
 		perms->dev = 0;
 }
 
+static void hfsplus_copy_timestamps2folder(struct hfsplus_timestamps *timestamps,
+					    struct hfsplus_cat_folder *folder)
+{
+	folder->create_date = timestamps->create_date;
+	folder->content_mod_date = timestamps->content_mod_date;
+	folder->attribute_mod_date = timestamps->attribute_mod_date;
+	folder->access_date = timestamps->access_date;
+}
+
+static void hfsplus_copy_timestamps2file(struct hfsplus_timestamps *timestamps,
+					  struct hfsplus_cat_file *file)
+{
+	file->create_date = timestamps->create_date;
+	file->content_mod_date = timestamps->content_mod_date;
+	file->attribute_mod_date = timestamps->attribute_mod_date;
+	file->access_date = timestamps->access_date;
+}
+
+/*
+ * Set creation date of new inode. The creation date after February 2040
+ * is stored as HFSPLUS_EXT_TIMESTAMP_MARK in the catalog record. The real
+ * value is saved into internal xattr by hfsplus_create_cat().
+ */
+static void hfsplus_set_create_date(struct inode *inode,
+				     struct hfsplus_timestamps *timestamps)
+{
+	time64_t ut = ktime_get_real_seconds();
+	__be32 create_date = __hfsp_ut2mt(ut);
+
+	HFSPLUS_I(inode)->birthdate = ut;
+	HFSPLUS_I(inode)->create_date = create_date;
+
+	timestamps->create_date = create_date;
+	timestamps->content_mod_date = create_date;
+	timestamps->attribute_mod_date = create_date;
+	timestamps->access_date = create_date;
+}
+
+/*
+ * Real creation date of new catalog record. The hard link record
+ * inherits the creation date of the hidden directory.
+ */
+static time64_t hfsplus_cat_record_birthdate(u32 cnid, struct inode *inode)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+
+	if (!S_ISDIR(inode->i_mode) && cnid != inode->i_ino)
+		return HFSPLUS_I(sbi->hidden_dir)->birthdate;
+
+	return HFSPLUS_I(inode)->birthdate;
+}
+
 static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
-		u32 cnid, struct inode *inode)
+				    u32 cnid, struct inode *inode)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_timestamps timestamps = {0};
 
 	if (S_ISDIR(inode->i_mode)) {
 		struct hfsplus_cat_folder *folder;
@@ -116,11 +170,12 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
 			folder->flags |= cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT);
 		folder->id = cpu_to_be32(inode->i_ino);
-		HFSPLUS_I(inode)->create_date =
-			folder->create_date =
-			folder->content_mod_date =
-			folder->attribute_mod_date =
-			folder->access_date = hfsp_now2mt();
+
+		hfsplus_set_create_date(inode, &timestamps);
+		hfsplus_copy_timestamps2folder(&timestamps, folder);
+		if (hfsp_ut_needs_xattr(HFSPLUS_I(inode)->birthdate))
+			folder->flags |= cpu_to_be16(HFSPLUS_XATTR_EXISTS);
+
 		hfsplus_cat_set_perms(inode, &folder->permissions);
 		if (inode == sbi->hidden_dir)
 			/* invisible and namelocked */
@@ -134,11 +189,23 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		file->type = cpu_to_be16(HFSPLUS_FILE);
 		file->flags = cpu_to_be16(HFSPLUS_FILE_THREAD_EXISTS);
 		file->id = cpu_to_be32(cnid);
-		HFSPLUS_I(inode)->create_date =
-			file->create_date =
-			file->content_mod_date =
-			file->attribute_mod_date =
-			file->access_date = hfsp_now2mt();
+
+		if (cnid == inode->i_ino) {
+			hfsplus_set_create_date(inode, &timestamps);
+		} else {
+			/*
+			 * Hard link record: don't change creation date
+			 * of the linked inode.
+			 */
+			__be32 now = __hfsp_ut2mt(ktime_get_real_seconds());
+
+			timestamps.create_date = now;
+			timestamps.content_mod_date = now;
+			timestamps.attribute_mod_date = now;
+			timestamps.access_date = now;
+		}
+		hfsplus_copy_timestamps2file(&timestamps, file);
+
 		if (cnid == inode->i_ino) {
 			hfsplus_cat_set_perms(inode, &file->permissions);
 			if (S_ISLNK(inode->i_mode)) {
@@ -169,6 +236,10 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 			file->permissions.dev =
 				cpu_to_be32(HFSPLUS_I(inode)->linkid);
 		}
+
+		if (hfsp_ut_needs_xattr(hfsplus_cat_record_birthdate(cnid, inode)))
+			file->flags |= cpu_to_be16(HFSPLUS_XATTR_EXISTS);
+
 		return sizeof(*file);
 	}
 }
@@ -256,6 +327,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	struct super_block *sb = dir->i_sb;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	time64_t birthdate;
 	int entry_size;
 	int err;
 
@@ -309,6 +381,22 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	if (err)
 		goto err1;
 
+	birthdate = hfsplus_cat_record_birthdate(cnid, inode);
+	if (hfsp_ut_needs_xattr(birthdate)) {
+		/*
+		 * Failure is not critical: the creation date
+		 * will be read as HFS_MAX_TIMESTAMP_SECS.
+		 */
+		err = hfsplus_set_timestamp_xattr(inode, cnid,
+						  XATTR_LINUX_CREATE_DATE_NAME,
+						  birthdate);
+		if (err) {
+			pr_warn("fail to save creation date: cnid %u, err %d\n",
+				cnid, err);
+			err = 0;
+		}
+	}
+
 	dir->i_size++;
 	if (S_ISDIR(inode->i_mode))
 		hfsplus_subfolders_inc(dir);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 51fcba2e6d40..af0520ebced7 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -26,6 +26,43 @@ static inline void hfsplus_instantiate(struct dentry *dentry,
 	d_instantiate(dentry, inode);
 }
 
+/*
+ * Check that creation date of catalog record @cnid is identical to
+ * creation date of @inode. If the creation date is after February 2040,
+ * then the real value is compared by means of internal xattr.
+ */
+static inline bool is_create_date_identical(struct inode *inode,
+					    u32 cnid, __be32 create_date)
+{
+	time64_t timestamp;
+	bool has_xattr;
+	int err;
+
+	if (create_date != HFSPLUS_I(inode)->create_date)
+		return false;
+
+	if (!hfsp_mt_is_ext_timestamp(create_date))
+		return true;
+
+	err = hfsplus_read_timestamp(inode->i_sb, cnid,
+				     XATTR_LINUX_CREATE_DATE_NAME,
+				     create_date, &timestamp, &has_xattr);
+	if (err) {
+		pr_err("timestamp extraction failure: cnid %u, err %d\n",
+			cnid, err);
+		return false;
+	}
+
+	/*
+	 * The record without xattr (for example, created by Mac OS X)
+	 * cannot be distinguished by means of 64-bit timestamp.
+	 */
+	if (!has_xattr)
+		return true;
+
+	return timestamp == HFSPLUS_I(inode)->birthdate;
+}
+
 /* Find the entry inside dir named dentry->d_name */
 static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 				     unsigned int flags)
@@ -78,12 +115,12 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 				entry.file.user_info.fdCreator ==
 				cpu_to_be32(HFSP_HFSPLUS_CREATOR) &&
 				HFSPLUS_SB(sb)->hidden_dir &&
-				(entry.file.create_date ==
-					HFSPLUS_I(HFSPLUS_SB(sb)->hidden_dir)->
-						create_date ||
-				entry.file.create_date ==
-					HFSPLUS_I(d_inode(sb->s_root))->
-						create_date)) {
+				(is_create_date_identical(
+					HFSPLUS_SB(sb)->hidden_dir,
+					cnid, entry.file.create_date) ||
+				is_create_date_identical(
+					d_inode(sb->s_root),
+					cnid, entry.file.create_date))) {
 			struct qstr str;
 			char name[32];
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index cd51afa22ece..e38f4a128313 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -176,6 +176,13 @@ static inline struct hfsplus_sb_info *HFSPLUS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+struct hfsplus_timestamps {
+	__be32 create_date;
+	__be32 content_mod_date;
+	__be32 attribute_mod_date;
+	__be32 access_date;
+	__be32 backup_date;
+};
 
 struct hfsplus_inode_info {
 	atomic_t opencnt;
@@ -197,7 +204,8 @@ struct hfsplus_inode_info {
 	 * Immutable data.
 	 */
 	struct inode *rsrc_inode;
-	__be32 create_date;
+	__be32 create_date;	/* on-disk (maybe clamped) creation date */
+	time64_t birthdate;	/* real creation date (seconds since 1970) */
 
 	/*
 	 * Protected by sbi->vh_mutex.
@@ -228,6 +236,9 @@ struct hfsplus_inode_info {
 #define HFSPLUS_I_EXT_DIRTY	2	/* has changes in the extent tree */
 #define HFSPLUS_I_ALLOC_DIRTY	3	/* has changes in the allocation file */
 #define HFSPLUS_I_ATTR_DIRTY	4	/* has changes in the attributes tree */
+#define HFSPLUS_I_ATIME_XATTR	5	/* access date is stored in xattr */
+#define HFSPLUS_I_MTIME_XATTR	6	/* content mod date is stored in xattr */
+#define HFSPLUS_I_CTIME_XATTR	7	/* attribute mod date is stored in xattr */
 
 #define HFSPLUS_IS_RSRC(inode) \
 	test_bit(HFSPLUS_I_RSRC, &HFSPLUS_I(inode)->flags)
@@ -352,6 +363,9 @@ int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid);
 int hfsplus_replace_attr(struct inode *inode,
 			 const char *name,
 			 const void *value, size_t size);
+int hfsplus_set_attr_cnid(struct inode *inode, u32 cnid,
+			  const char *name,
+			  const void *value, size_t size);
 
 /* bitmap.c */
 int hfsplus_block_allocate(struct super_block *sb, u32 size, u32 offset,
@@ -468,6 +482,9 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct file_kattr *fa);
+int hfsplus_read_timestamp(struct super_block *sb, u32 cnid,
+			   const char *name, __be32 mt,
+			   time64_t *ut, bool *has_xattr);
 
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
@@ -525,6 +542,21 @@ bool is_hfs_thread_record_type(u16 type)
 
 int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
 
+/*
+ * time helpers: convert between 1904-base and 1970-base timestamps
+ *
+ * The on-disk 32-bit timestamps cover the range from
+ * HFS_MIN_TIMESTAMP_SECS (Jan. 1, 1904) till HFS_MAX_TIMESTAMP_SECS
+ * (Feb. 6, 2040). The timestamps out of this range are clamped.
+ * The on-disk value HFSPLUS_EXT_TIMESTAMP_MARK (maximal value) means
+ * that real timestamp could be stored in the internal xattr of
+ * the catalog record. It is Linux specific extension of
+ * HFS+ on-disk layout. It makes possible to support timestamps
+ * till HFSPLUS_MAX_TIMESTAMP_SECS.
+ */
+#define HFSPLUS_EXT_TIMESTAMP_MARK	cpu_to_be32(U32_MAX)
+#define HFSPLUS_MAX_TIMESTAMP_SECS	TIME64_MAX
+
 static inline time64_t __hfsp_mt2ut(__be32 mt)
 {
 	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
@@ -534,10 +566,21 @@ static inline time64_t __hfsp_mt2ut(__be32 mt)
 
 static inline __be32 __hfsp_ut2mt(time64_t ut)
 {
+	ut = clamp_t(time64_t, ut,
+		     HFS_MIN_TIMESTAMP_SECS, HFS_MAX_TIMESTAMP_SECS);
 	ut += HFS_UTC_OFFSET;
 
 	return cpu_to_be32(lower_32_bits(ut));
+}
+
+static inline bool hfsp_ut_needs_xattr(time64_t ut)
+{
+	return ut >= HFS_MAX_TIMESTAMP_SECS;
+}
 
+static inline bool hfsp_mt_is_ext_timestamp(__be32 mt)
+{
+	return mt == HFSPLUS_EXT_TIMESTAMP_MARK;
 }
 
 static inline enum hfsplus_btree_mutex_classes
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 2ce6de574fa6..c2ee1906589d 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -344,7 +344,8 @@ int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	if (request_mask & STATX_BTIME) {
 		stat->result_mask |= STATX_BTIME;
-		stat->btime = hfsp_mt2ut(hip->create_date);
+		stat->btime.tv_sec = hip->birthdate;
+		stat->btime.tv_nsec = 0;
 	}
 
 	if (inode->i_flags & S_APPEND)
@@ -598,9 +599,138 @@ void hfsplus_inode_write_fork(struct inode *inode,
 	fork->total_blocks = cpu_to_be32(HFSPLUS_I(inode)->alloc_blocks);
 }
 
+/*
+ * hfsplus_read_timestamp - convert on-disk timestamp into 1970-base one
+ * @sb: superblock
+ * @cnid: catalog record ID
+ * @name: name of internal xattr that can keep the real timestamp
+ * @mt: on-disk timestamp
+ * @ut: pointer on converted timestamp [out]
+ * @has_xattr: pointer on flag that xattr exists [out]
+ *
+ * If on-disk timestamp is equal to HFSPLUS_EXT_TIMESTAMP_MARK, then
+ * the real timestamp (after February 2040) could be stored in
+ * the internal xattr. If the xattr is absent (for example, the record
+ * has been created by Mac OS X), then HFS_MAX_TIMESTAMP_SECS is used.
+ */
+int hfsplus_read_timestamp(struct super_block *sb, u32 cnid,
+			   const char *name, __be32 mt,
+			   time64_t *ut, bool *has_xattr)
+{
+	time64_t timestamp;
+	int err;
+
+	*ut = __hfsp_mt2ut(mt);
+	*has_xattr = false;
+
+	if (!hfsp_mt_is_ext_timestamp(mt))
+		return 0;
+
+	err = hfsplus_get_timestamp_xattr(sb, cnid, name, &timestamp);
+	if (err == -ENODATA || err == -EOPNOTSUPP) {
+		/* timestamp is really equal to HFS_MAX_TIMESTAMP_SECS */
+		return 0;
+	} else if (unlikely(err)) {
+		pr_warn("fail to extract timestamp: cnid %u, name %s, err %d\n",
+			cnid, name, err);
+		return err;
+	}
+
+	if (timestamp < HFS_MAX_TIMESTAMP_SECS) {
+		pr_warn("invalid timestamp in xattr: cnid %u, name %s, timestamp %lld\n",
+			cnid, name, timestamp);
+		/* keep xattr to be deleted or overwritten */
+		*has_xattr = true;
+	} else {
+		*ut = timestamp;
+		*has_xattr = true;
+	}
+
+	return 0;
+}
+
+static int hfsplus_inode_read_timestamps(struct inode *inode,
+					 struct hfsplus_timestamps *timestamps)
+{
+	struct super_block *sb = inode->i_sb;
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	u32 cnid = inode->i_ino;
+	struct timespec64 ts = {0};
+	bool has_xattr;
+	int res = 0;
+
+	res = hfsplus_read_timestamp(sb, cnid,
+				     XATTR_LINUX_ACCESS_DATE_NAME,
+				     timestamps->access_date,
+				     &ts.tv_sec, &has_xattr);
+	if (res)
+		goto finish_read_timestamps;
+
+	inode_set_atime_to_ts(inode, ts);
+	if (has_xattr)
+		set_bit(HFSPLUS_I_ATIME_XATTR, &hip->flags);
+
+	res = hfsplus_read_timestamp(sb, cnid,
+				     XATTR_LINUX_CONTENT_MOD_DATE_NAME,
+				     timestamps->content_mod_date,
+				     &ts.tv_sec, &has_xattr);
+	if (res)
+		goto finish_read_timestamps;
+
+	inode_set_mtime_to_ts(inode, ts);
+	if (has_xattr)
+		set_bit(HFSPLUS_I_MTIME_XATTR, &hip->flags);
+
+	res = hfsplus_read_timestamp(sb, cnid,
+				     XATTR_LINUX_ATTRIBUTE_MOD_DATE_NAME,
+				     timestamps->attribute_mod_date,
+				     &ts.tv_sec, &has_xattr);
+	if (res)
+		goto finish_read_timestamps;
+
+	inode_set_ctime_to_ts(inode, ts);
+	if (has_xattr)
+		set_bit(HFSPLUS_I_CTIME_XATTR, &hip->flags);
+
+	res = hfsplus_read_timestamp(sb, cnid,
+				     XATTR_LINUX_CREATE_DATE_NAME,
+				     timestamps->create_date,
+				     &hip->birthdate, &has_xattr);
+	if (res)
+		goto finish_read_timestamps;
+
+	hip->create_date = timestamps->create_date;
+
+finish_read_timestamps:
+	return res;
+}
+
+static inline void
+hfsplus_copy_folder2timestamps(struct hfsplus_cat_folder *folder,
+				struct hfsplus_timestamps *timestamps)
+{
+	timestamps->create_date = folder->create_date;
+	timestamps->content_mod_date = folder->content_mod_date;
+	timestamps->attribute_mod_date = folder->attribute_mod_date;
+	timestamps->access_date = folder->access_date;
+	timestamps->backup_date = folder->backup_date;
+}
+
+static inline void
+hfsplus_copy_file2timestamps(struct hfsplus_cat_file *file,
+			     struct hfsplus_timestamps *timestamps)
+{
+	timestamps->create_date = file->create_date;
+	timestamps->content_mod_date = file->content_mod_date;
+	timestamps->attribute_mod_date = file->attribute_mod_date;
+	timestamps->access_date = file->access_date;
+	timestamps->backup_date = file->backup_date;
+}
+
 int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 {
 	hfsplus_cat_entry entry;
+	struct hfsplus_timestamps timestamps = {0};
 	int res = 0;
 	u16 type;
 
@@ -622,12 +752,14 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			goto out;
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
-		inode_set_atime_to_ts(inode, hfsp_mt2ut(folder->access_date));
-		inode_set_mtime_to_ts(inode,
-				      hfsp_mt2ut(folder->content_mod_date));
-		inode_set_ctime_to_ts(inode,
-				      hfsp_mt2ut(folder->attribute_mod_date));
-		HFSPLUS_I(inode)->create_date = folder->create_date;
+
+		hfsplus_copy_folder2timestamps(folder, &timestamps);
+		res = hfsplus_inode_read_timestamps(inode, &timestamps);
+		if (res) {
+			res = -EIO;
+			goto out;
+		}
+
 		HFSPLUS_I(inode)->fs_blocks = 0;
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
 			HFSPLUS_I(inode)->subfolders =
@@ -668,12 +800,13 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
-		inode_set_atime_to_ts(inode, hfsp_mt2ut(file->access_date));
-		inode_set_mtime_to_ts(inode,
-				      hfsp_mt2ut(file->content_mod_date));
-		inode_set_ctime_to_ts(inode,
-				      hfsp_mt2ut(file->attribute_mod_date));
-		HFSPLUS_I(inode)->create_date = file->create_date;
+
+		hfsplus_copy_file2timestamps(file, &timestamps);
+		res = hfsplus_inode_read_timestamps(inode, &timestamps);
+		if (res) {
+			res = -EIO;
+			goto out;
+		}
 	} else {
 		pr_err("bad catalog entry used to create inode\n");
 		res = -EIO;
@@ -682,12 +815,126 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	return res;
 }
 
+struct hfsplus_xattr_changes {
+	bool added;
+	bool removed;
+};
+
+/*
+ * Convert @ts into on-disk timestamp. The timestamp after February 2040
+ * is stored as HFSPLUS_EXT_TIMESTAMP_MARK with the real value in
+ * the internal xattr @name. The stale xattr is removed if timestamp
+ * becomes representable by on-disk field.
+ */
+static int hfsplus_inode_save_timestamp(struct inode *inode,
+					const char *name, int xattr_bit,
+					struct timespec64 ts, __be32 *date,
+					struct hfsplus_xattr_changes *xattr)
+{
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	time64_t stored;
+	int err;
+
+	*date = __hfsp_ut2mt(ts.tv_sec);
+
+	if (hfsp_ut_needs_xattr(ts.tv_sec)) {
+		/* don't rewrite xattr if nothing has been changed */
+		if (test_bit(xattr_bit, &hip->flags)) {
+			err = hfsplus_get_timestamp_xattr(inode->i_sb,
+							  inode->i_ino,
+							  name,
+							  &stored);
+			if (!err && stored == ts.tv_sec)
+				return 0;
+		}
+
+		err = hfsplus_set_timestamp_xattr(inode, inode->i_ino,
+						  name, ts.tv_sec);
+		if (err) {
+			clear_bit(xattr_bit, &hip->flags);
+			return err;
+		}
+
+		set_bit(xattr_bit, &hip->flags);
+		xattr->added = true;
+	} else if (test_bit(xattr_bit, &hip->flags)) {
+		err = hfsplus_remove_timestamp_xattr(inode, name);
+		if (err)
+			return err;
+
+		clear_bit(xattr_bit, &hip->flags);
+		xattr->removed = true;
+	}
+
+	return 0;
+}
+
+static void hfsplus_inode_save_timestamps(struct inode *inode,
+					  struct hfsplus_timestamps *timestamps,
+					  struct hfsplus_xattr_changes *changes)
+{
+	int res;
+
+	/*
+	 * Failure of xattr operation is not critical. The timestamp
+	 * is clamped by HFS_MAX_TIMESTAMP_SECS in such case.
+	 * But the rest of the catalog record must be saved anyway.
+	 */
+
+	res = hfsplus_inode_save_timestamp(inode,
+					   XATTR_LINUX_ACCESS_DATE_NAME,
+					   HFSPLUS_I_ATIME_XATTR,
+					   inode_get_atime(inode),
+					   &timestamps->access_date,
+					   changes);
+	if (res) {
+		pr_warn_ratelimited("fail to save access date: ino %llu, err %d\n",
+				    inode->i_ino, res);
+	}
+
+	res = hfsplus_inode_save_timestamp(inode,
+					   XATTR_LINUX_CONTENT_MOD_DATE_NAME,
+					   HFSPLUS_I_MTIME_XATTR,
+					   inode_get_mtime(inode),
+					   &timestamps->content_mod_date,
+					   changes);
+	if (res) {
+		pr_warn_ratelimited("fail to save content mod date: ino %llu, err %d\n",
+				    inode->i_ino, res);
+	}
+
+	res = hfsplus_inode_save_timestamp(inode,
+					   XATTR_LINUX_ATTRIBUTE_MOD_DATE_NAME,
+					   HFSPLUS_I_CTIME_XATTR,
+					   inode_get_ctime(inode),
+					   &timestamps->attribute_mod_date,
+					   changes);
+	if (res) {
+		pr_warn_ratelimited("fail to save attribute mod date: ino %llu, err %d\n",
+				    inode->i_ino, res);
+	}
+}
+
+static inline __be16
+hfsplus_update_xattr_exists_flag(struct inode *inode, __be16 flags,
+				 struct hfsplus_xattr_changes *xattr)
+{
+	if (xattr->added)
+		flags |= cpu_to_be16(HFSPLUS_XATTR_EXISTS);
+	else if (xattr->removed && !hfsplus_attr_exists(inode, NULL))
+		flags &= cpu_to_be16(~HFSPLUS_XATTR_EXISTS);
+
+	return flags;
+}
+
 int hfsplus_cat_write_inode(struct inode *inode)
 {
 	struct inode *main_inode = inode;
 	struct hfs_btree *tree = HFSPLUS_SB(inode->i_sb)->cat_tree;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	struct hfsplus_timestamps timestamps = {0};
+	struct hfsplus_xattr_changes changes = {0};
 	int res = 0;
 
 	hfs_dbg("inode->i_ino %llu\n", inode->i_ino);
@@ -718,9 +965,15 @@ int hfsplus_cat_write_inode(struct inode *inode)
 					sizeof(struct hfsplus_cat_folder));
 		/* simple node checks? */
 		hfsplus_cat_set_perms(inode, &folder->permissions);
-		folder->access_date = hfsp_ut2mt(inode_get_atime(inode));
-		folder->content_mod_date = hfsp_ut2mt(inode_get_mtime(inode));
-		folder->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
+
+		hfsplus_inode_save_timestamps(inode, &timestamps, &changes);
+		folder->access_date = timestamps.access_date;
+		folder->content_mod_date = timestamps.content_mod_date;
+		folder->attribute_mod_date = timestamps.attribute_mod_date;
+		folder->flags = hfsplus_update_xattr_exists_flag(inode,
+								 folder->flags,
+								 &changes);
+
 		folder->valence = cpu_to_be32(inode->i_size - 2);
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
 			folder->subfolders =
@@ -753,9 +1006,15 @@ int hfsplus_cat_write_inode(struct inode *inode)
 			file->flags |= cpu_to_be16(HFSPLUS_FILE_LOCKED);
 		else
 			file->flags &= cpu_to_be16(~HFSPLUS_FILE_LOCKED);
-		file->access_date = hfsp_ut2mt(inode_get_atime(inode));
-		file->content_mod_date = hfsp_ut2mt(inode_get_mtime(inode));
-		file->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
+
+		hfsplus_inode_save_timestamps(inode, &timestamps, &changes);
+		file->access_date = timestamps.access_date;
+		file->content_mod_date = timestamps.content_mod_date;
+		file->attribute_mod_date = timestamps.attribute_mod_date;
+		file->flags = hfsplus_update_xattr_exists_flag(inode,
+							       file->flags,
+							       &changes);
+
 		hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
 					 sizeof(struct hfsplus_cat_file));
 	}
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 657dfa40bdf3..b10b53f6f8f9 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -86,6 +86,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	mutex_init(&HFSPLUS_I(inode)->extents_lock);
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
 	HFSPLUS_I(inode)->create_date = 0;
+	HFSPLUS_I(inode)->birthdate = 0;
 	HFSPLUS_I(inode)->linkid = 0;
 	HFSPLUS_I(inode)->flags = 0;
 	HFSPLUS_I(inode)->fs_blocks = 0;
@@ -513,6 +514,9 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_time_gran = NSEC_PER_SEC;
 	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS;
+	/*
+	 * Timestamps after HFS_MAX_TIMESTAMP_SECS are stored in xattrs.
+	 */
 	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS;
 
 	err = -EFBIG;
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c71f..d3b173449616 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -50,6 +50,12 @@ static bool is_known_namespace(const char *name)
 	return true;
 }
 
+static bool is_linux_hfs_internal_xattr(const char *name)
+{
+	return !strncmp(name, XATTR_LINUX_HFS_PREFIX,
+			XATTR_LINUX_HFS_PREFIX_LEN);
+}
+
 static u32 hfsplus_init_header_node(struct inode *attr_file,
 					u32 clump_size,
 					char *buf, u16 node_size)
@@ -319,6 +325,19 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 
 	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
 
+	/*
+	 * Store the fork of AttributesFile into the volume header right now.
+	 * The AttributesFile can be created by hfsplus_cat_write_inode()
+	 * (timestamps after 2040 are stored in xattrs) in the middle of
+	 * sync operation. Then, the dirty AttributesFile's inode can be
+	 * skipped by writeback and the volume header will be committed
+	 * without AttributesFile. As a result, the AttributesFile will be
+	 * not opened during the next mount.
+	 */
+	hfsplus_inode_write_fork(attr_file, &sbi->s_vhdr->attr_file);
+	set_bit(HFSPLUS_SB_WRITEBACKUP, &sbi->flags);
+	hfsplus_mark_mdb_dirty(sb);
+
 	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
 	if (!sbi->attr_tree)
 		pr_err("failed to load attributes file\n");
@@ -339,8 +358,7 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	return err;
 }
 
-static inline
-bool is_xattr_operation_supported(struct inode *inode)
+static inline bool is_xattr_operation_supported(struct inode *inode)
 {
 	if (HFSPLUS_IS_RSRC(inode))
 		return false;
@@ -609,8 +627,9 @@ static ssize_t hfsplus_getxattr_finder_info(struct inode *inode,
 	return res;
 }
 
-ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
-			 void *value, size_t size)
+static ssize_t __hfsplus_getxattr_nocheck(struct super_block *sb,
+					  u32 cnid, const char *name,
+					  void *value, size_t size)
 {
 	struct hfs_find_data fd;
 	hfsplus_attr_entry *entry;
@@ -619,13 +638,7 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 	u16 record_length = 0;
 	ssize_t res;
 
-	if (!is_xattr_operation_supported(inode))
-		return -EOPNOTSUPP;
-
-	if (!strcmp_xattr_finder_info(name))
-		return hfsplus_getxattr_finder_info(inode, value, size);
-
-	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
+	if (!HFSPLUS_SB(sb)->attr_tree)
 		return -EOPNOTSUPP;
 
 	entry = hfsplus_alloc_attr_entry();
@@ -634,18 +647,18 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 		return -ENOMEM;
 	}
 
-	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->attr_tree, &fd);
+	res = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
 	if (res) {
 		pr_err("can't init xattr find struct\n");
 		goto failed_getxattr_init;
 	}
 
-	res = hfsplus_find_attr(inode->i_sb, inode->i_ino, name, &fd);
+	res = hfsplus_find_attr(sb, cnid, name, &fd);
 	if (res) {
 		if (res == -ENOENT || res == -ENODATA)
 			res = -ENODATA;
 		else
-			pr_err("xattr search failed\n");
+			pr_err("xattr searching failed\n");
 		goto out;
 	}
 
@@ -693,6 +706,38 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 	return res;
 }
 
+static inline ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
+					 void *value, size_t size)
+{
+	if (!is_xattr_operation_supported(inode))
+		return -EOPNOTSUPP;
+
+	if (!strcmp_xattr_finder_info(name))
+		return hfsplus_getxattr_finder_info(inode, value, size);
+
+	return __hfsplus_getxattr_nocheck(inode->i_sb, (u32)inode->i_ino,
+					  name, value, size);
+}
+
+static inline char *hfsplus_build_xattr_name(const char *name,
+					     const char *prefix,
+					     size_t prefixlen)
+{
+	char *xattr_name;
+	size_t len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1;
+
+	xattr_name = kzalloc(len, GFP_KERNEL);
+	if (!xattr_name)
+		return ERR_PTR(-ENOMEM);
+
+	if (snprintf(xattr_name, len, "%s%s", prefix, name) >= len) {
+		kfree(xattr_name);
+		return ERR_PTR(-ENAMETOOLONG);
+	}
+
+	return xattr_name;
+}
+
 ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 			 void *value, size_t size,
 			 const char *prefix, size_t prefixlen)
@@ -704,13 +749,9 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 		inode->i_ino, name ? name : NULL,
 		prefix ? prefix : NULL);
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
-			     GFP_KERNEL);
-	if (!xattr_name)
-		return -ENOMEM;
-
-	strcpy(xattr_name, prefix);
-	strcpy(xattr_name + prefixlen, name);
+	xattr_name = hfsplus_build_xattr_name(name, prefix, prefixlen);
+	if (IS_ERR(xattr_name))
+		return PTR_ERR(xattr_name);
 
 	res = __hfsplus_getxattr(inode, xattr_name, value, size);
 	kfree(xattr_name);
@@ -718,7 +759,114 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 	hfs_dbg("finished: res %d\n", res);
 
 	return res;
+}
+
+static ssize_t hfsplus_getxattr_nocheck(struct super_block *sb, u32 cnid,
+					const char *name,
+					void *value, size_t size,
+					const char *prefix, size_t prefixlen)
+{
+	int res;
+	char *xattr_name;
 
+	hfs_dbg("cnid %u, name %s, prefix %s\n",
+		cnid, name ? name : NULL,
+		prefix ? prefix : NULL);
+
+	xattr_name = hfsplus_build_xattr_name(name, prefix, prefixlen);
+	if (IS_ERR(xattr_name))
+		return PTR_ERR(xattr_name);
+
+	res = __hfsplus_getxattr_nocheck(sb, cnid, xattr_name, value, size);
+	kfree(xattr_name);
+
+	hfs_dbg("finished: res %d\n", res);
+
+	return res;
+}
+
+/*
+ * Get the timestamp stored in the internal xattr @name
+ * of catalog record @cnid. The caller can hold the catalog tree lock.
+ */
+int hfsplus_get_timestamp_xattr(struct super_block *sb, u32 cnid,
+				const char *name, time64_t *ts)
+{
+	__be64 value;
+	ssize_t res;
+
+	res = hfsplus_getxattr_nocheck(sb, cnid, name,
+					&value, sizeof(value),
+					XATTR_LINUX_HFS_PREFIX,
+					XATTR_LINUX_HFS_PREFIX_LEN);
+	if (res < 0)
+		return res;
+
+	if (res != sizeof(value))
+		return -EIO;
+
+	*ts = (time64_t)be64_to_cpu(value);
+	return 0;
+}
+
+/*
+ * Store the timestamp @ts into the internal xattr @name of catalog
+ * record @cnid. The caller must hold the catalog tree lock and it is
+ * caller's responsibility to set HFSPLUS_XATTR_EXISTS flag in
+ * the catalog record.
+ */
+int hfsplus_set_timestamp_xattr(struct inode *inode, u32 cnid,
+				const char *name, time64_t ts)
+{
+	struct super_block *sb = inode->i_sb;
+	char xattr_name[XATTR_LINUX_HFS_NAME_MAX];
+	__be64 value = cpu_to_be64(ts);
+	int err;
+
+	hfs_dbg("ino %llu, cnid %u, name %s, ts %lld\n",
+		inode->i_ino, cnid, name, ts);
+
+	if (!HFSPLUS_SB(sb)->attr_tree) {
+		err = hfsplus_create_attributes_file(sb);
+		if (unlikely(err))
+			return err;
+
+		if (!HFSPLUS_SB(sb)->attr_tree)
+			return -EIO;
+	}
+
+	if (snprintf(xattr_name, sizeof(xattr_name), "%s%s",
+		     XATTR_LINUX_HFS_PREFIX, name) >= sizeof(xattr_name))
+		return -ENAMETOOLONG;
+
+	return hfsplus_set_attr_cnid(inode, cnid, xattr_name,
+				     &value, sizeof(value));
+}
+
+/*
+ * Remove the internal xattr @name of @inode. The caller must hold
+ * the catalog tree lock and it is caller's responsibility to update
+ * HFSPLUS_XATTR_EXISTS flag in the catalog record.
+ */
+int hfsplus_remove_timestamp_xattr(struct inode *inode, const char *name)
+{
+	char xattr_name[XATTR_LINUX_HFS_NAME_MAX];
+	int err;
+
+	hfs_dbg("ino %llu, name %s\n", inode->i_ino, name);
+
+	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
+		return 0;
+
+	if (snprintf(xattr_name, sizeof(xattr_name), "%s%s",
+		     XATTR_LINUX_HFS_PREFIX, name) >= sizeof(xattr_name))
+		return -ENAMETOOLONG;
+
+	err = hfsplus_delete_attr(inode, xattr_name);
+	if (err == -ENOENT || err == -ENODATA)
+		err = 0;
+
+	return err;
 }
 
 static inline int can_list(const char *xattr_name)
@@ -726,6 +874,10 @@ static inline int can_list(const char *xattr_name)
 	if (!xattr_name)
 		return 0;
 
+	/* Internal xattrs of the driver are hidden */
+	if (is_linux_hfs_internal_xattr(xattr_name))
+		return 0;
+
 	return strncmp(xattr_name, XATTR_TRUSTED_PREFIX,
 			XATTR_TRUSTED_PREFIX_LEN) ||
 				capable(CAP_SYS_ADMIN);
@@ -998,6 +1150,10 @@ static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
 	if (is_known_namespace(name))
 		return -EOPNOTSUPP;
 
+	/* Internal xattrs of the driver are hidden */
+	if (is_linux_hfs_internal_xattr(name))
+		return -EOPNOTSUPP;
+
 	/*
 	 * osx is the namespace we use to indicate an unprefixed
 	 * attribute on the filesystem (like the ones that OS X
@@ -1020,6 +1176,10 @@ static int hfsplus_osx_setxattr(const struct xattr_handler *handler,
 	if (is_known_namespace(name))
 		return -EOPNOTSUPP;
 
+	/* Internal xattrs of the driver cannot be changed by user */
+	if (is_linux_hfs_internal_xattr(name))
+		return -EOPNOTSUPP;
+
 	/*
 	 * osx is the namespace we use to indicate an unprefixed
 	 * attribute on the filesystem (like the ones that OS X
diff --git a/fs/hfsplus/xattr.h b/fs/hfsplus/xattr.h
index 15cc55e41410..8f6283f85f13 100644
--- a/fs/hfsplus/xattr.h
+++ b/fs/hfsplus/xattr.h
@@ -12,6 +12,24 @@
 
 #include <linux/xattr.h>
 
+/*
+ * Internal xattrs of Linux HFS+ driver. Timestamps beyond
+ * HFS_MAX_TIMESTAMP_SECS (February 2040) cannot be represented by
+ * 32-bit on-disk fields. Such timestamp is stored as the maximal value
+ * (HFSPLUS_EXT_TIMESTAMP_MARK) in the catalog record and the real value
+ * is kept in the xattr as big-endian 64-bit seconds since
+ * 00:00 GMT, Jan. 1, 1970.
+ */
+#define XATTR_LINUX_HFS_PREFIX "linux_hfs."
+#define XATTR_LINUX_HFS_PREFIX_LEN \
+	(sizeof(XATTR_LINUX_HFS_PREFIX) - 1)
+#define XATTR_LINUX_HFS_NAME_MAX	64
+#define XATTR_LINUX_CREATE_DATE_NAME "create_date_u64"
+#define XATTR_LINUX_CONTENT_MOD_DATE_NAME "content_mod_date_u64"
+#define XATTR_LINUX_ATTRIBUTE_MOD_DATE_NAME "attribute_mod_date_u64"
+#define XATTR_LINUX_ACCESS_DATE_NAME "access_date_u64"
+#define XATTR_LINUX_BACKUP_DATE_NAME "backup_date_u64"
+
 extern const struct xattr_handler hfsplus_xattr_osx_handler;
 extern const struct xattr_handler hfsplus_xattr_user_handler;
 extern const struct xattr_handler hfsplus_xattr_trusted_handler;
@@ -23,16 +41,18 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags);
 
 int hfsplus_setxattr(struct inode *inode, const char *name,
-				   const void *value, size_t size, int flags,
-				   const char *prefix, size_t prefixlen);
-
-ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
-			   void *value, size_t size);
-
+		     const void *value, size_t size, int flags,
+		     const char *prefix, size_t prefixlen);
 ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 			 void *value, size_t size,
 			 const char *prefix, size_t prefixlen);
 
+int hfsplus_get_timestamp_xattr(struct super_block *sb, u32 cnid,
+				const char *name, time64_t *ts);
+int hfsplus_set_timestamp_xattr(struct inode *inode, u32 cnid,
+				const char *name, time64_t ts);
+int hfsplus_remove_timestamp_xattr(struct inode *inode, const char *name);
+
 ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size);
 
 int hfsplus_init_security(struct inode *inode, struct inode *dir,
-- 
2.43.0

