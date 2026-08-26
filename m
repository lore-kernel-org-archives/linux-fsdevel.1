Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92633494827
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785021; cv=none; b=tVQN6/rGNvIbFwRZk+rkmm/MiIw98ix5UPB6ma0bEjcYEAfRBWbvR+3hurZgdZ/8K+oH+HN9cvvs1vgzlv6JRcLIvHiEMMIn9P6IvMZoqzL59o0tVGEaeb1ksk0q980cDg5ayAF5w7HPAp3gqJeYBBY558815D3zmdSWTHQidH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785021; c=relaxed/simple;
	bh=Yu077xavb+kfNJ59UBiem5cKf/Xeg5jfbl6dbGUU2GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHA8lFCOtEf7gvm7LsDtGzETN6bp59+YQcfOGwOaeFzOyjNRod72SgPfH8YNNsrhVc8nXu/8PU5qHVXWogP8MUI8/1YbWIM9JpcgdMaWcWBKtmRtirBhgrLrg4SKdN7m8VpqytfpuPWj0vyS+ZS7Pfc0eBIwHjAgPtkP/xF6Z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=MoZOY7ZZ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="MoZOY7ZZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c70d73210so2221991d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787785017; x=1788389817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlcZQnkNuXS5xezZ8MX/NOB96RJI0MmEXtmT2OihvtQ=;
        b=MoZOY7ZZ/rxR/2x/1kXe8M5y9WEI4i0u+UeiEVSTj8C5S5vdq85XtqXbI7UnN3r0VO
         rO0sCtkd4UWGo4Vxt7KGsViolMam/0CS+l8YsDgNaEiMn3nkaWNXURvLh0BsUKeILrNa
         /97qzL/KipjWCjWst/BaMHSryjHdQHjtRCNdIWZskUSaNOJGYxrPeIkyxzNKtABTFMRJ
         IYaRNMSSfiZahCquA9cu4VzQh+hsmScXLJSYjcd/h8pXFfSgKopQkmMxzb2S9DpbrJaW
         N3ouv5pHiLZ/G3GkoqF7kbSQKf32aUkK7OMb4GzlHGAzDgwZQ/kqFcuCuF3hgZ+mLkML
         L5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785017; x=1788389817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlcZQnkNuXS5xezZ8MX/NOB96RJI0MmEXtmT2OihvtQ=;
        b=hcij/FmYsoBP2xkzjYfOw4ar+BZ8r9GG+ptTKA9IJFDoImYt4OyIsO+FYwuehrjByp
         kFXpCk6aKB4A23HnVnbG6XqJMGAxSI449aTivGtsK4xPb2Wwv8t9bYRE+RuwMGemXxvK
         d9deOwxf4+72ziRymnX6+WHFkzcp+7Fr/inhg7dycatCrhvh7BUsyKG3GUFqJB1fystX
         S8ibphBITCnWLZ1jRtmzG5j13ezadT1z21eITmEvc/MlEVTC1EG7ZRe08m98o23YGiGO
         7Fqb3bpmJmPfNZ/Jbhsvg1WBGdvCYacUQlKFbjhN8A6AsMAYTwvCRXCNMdlJAbEd6GWB
         4LBw==
X-Gm-Message-State: AFuF++mtiJwvF1qRtakDB5Fk89X8nj4a2kow6ixD/dmQGGNR1vXAYfwm
	oX9sRMqXJ0SczCZrnzGi2Z8/9oUZUKIKH/kNmap4LVC2tsmFpmPuv95d4xVd2J87ayw=
X-Gm-Gg: AR+sD1148iS8Sf1AprYn2iTun17DjRWAy2dcYRMr0TalHOU3y2MbJgdWiqf9pFQB2jA
	HNddk003wZDTjnCATDmuK5qH8EgANv2QxXDewK2Cr7b7OkLv0OwMcGK3XoatXKG/H9be400lq9h
	5DkCtF+CwemMyO+CfLGOu9T4Lf6trZxEQ6qfE9F8DSBGuXbl9wo9qPp9IThIz2KmZEduTiDmFlg
	ZrR6SATXI7+igQI4NjUX798DuyvoM2HpBfHJ66ZGkE2L1JXNPh/xIIoMYMiT1q/vEGj2jK2qfgZ
	WCdyAVouSLnoLv1+yMZlPNWsTPjQ6jRvm2Qn7QuM1LrW8ApytMILwVEvKWX0yQ/UuFnCrMUdIn5
	puoNUPUGfkNgrvSmF/6y3bRiCBY2Mjd58zOCd1Xrpr5SxB5I4DWGagVbI5HdKgoXzMfMfs7LCSU
	loOrW2gHTkS8VjzQ76n0L+XmpIiJ+NxKMk1aso9C+kNtoAFoaUiM2fcCfkdEcbVXYDxPdxc1gRl
	Nrkc0qwxdlQi+wLEv/fjkY5XSHh5KskvCdIi4526huiLDz7jPBWwvsejob9jjHyFTgp2EqjMfG6
	dxzoZehaVVybBANqlw==
X-Received: by 2002:a05:690e:d47:b0:66d:1452:5fa8 with SMTP id 956f58d0204a3-66d2565a7ccmr3478191d50.1.1787785016712;
        Wed, 26 Aug 2026 15:56:56 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:56 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 7/7] hfsplus: switch address_space_operations on iomap-based support
Date: Wed, 26 Aug 2026 15:56:14 -0700
Message-ID: <20260826225614.486112-8-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826225614.486112-1-slava@dubeyko.com>
References: <20260826225614.486112-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch switches the regular file operations on iomap-based
ones. The hfsplus_aops is redefined as the iomap-based
operations. As a result, hfsplus_direct_IO() has been completely
removed as a user of blockdev_direct_IO(). Also, unnecessary
LEGACY_DIRECT_IO dependency has been removed from Kconfig.

v2
The hfsplus_btree_aops uses hfsplus_btree_read_folio() and
hfsplus_btree_writepages() methods. The hfsplus_symlink_aops
uses hfsplus_symlink_read_folio() and hfsplus_symlink_writepages()
methods. Also, hfsplus_setattr() doesn't distinguish the regular
and not regular file cases anymore.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/Kconfig      |   1 -
 fs/hfsplus/extents.c    |  39 +++++++----
 fs/hfsplus/hfsplus_fs.h |   1 +
 fs/hfsplus/inode.c      | 147 ++++++++++++++++++++--------------------
 4 files changed, 100 insertions(+), 88 deletions(-)

diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
index 865a1966f395..b4432c64db3b 100644
--- a/fs/hfsplus/Kconfig
+++ b/fs/hfsplus/Kconfig
@@ -5,7 +5,6 @@ config HFSPLUS_FS
 	select BUFFER_HEAD
 	select NLS
 	select NLS_UTF8
-	select LEGACY_DIRECT_IO
 	select FS_IOMAP
 	help
 	  If you say Y here, you will be able to mount extended format
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index ffd52ad8867c..90375ba5e748 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -15,6 +15,7 @@
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
+#include "iomap.h"
 
 /* Compare two extents keys, returns 0 on same, pos/neg for difference */
 int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
@@ -607,20 +608,32 @@ void hfsplus_file_truncate(struct inode *inode)
 		inode->i_ino, (long long)hip->phys_size, inode->i_size);
 
 	if (inode->i_size > hip->phys_size) {
-		struct address_space *mapping = inode->i_mapping;
-		struct folio *folio;
-		void *fsdata = NULL;
-		loff_t size = inode->i_size;
+		if (S_ISREG(inode->i_mode)) {
+			res = hfsplus_iomap_cont_expand(inode, inode->i_size);
+			if (res)
+				return;
+
+			mark_inode_dirty(inode);
+		} else {
+			struct address_space *mapping = inode->i_mapping;
+			struct folio *folio;
+			void *fsdata = NULL;
+
+			res = hfsplus_write_begin(NULL, mapping,
+						  inode->i_size, 0,
+						  &folio, &fsdata);
+			if (res)
+				return;
+
+			res = generic_write_end(NULL, mapping,
+						inode->i_size, 0, 0,
+						folio, fsdata);
+			if (res < 0)
+				return;
+
+			mark_inode_dirty(inode);
+		}
 
-		res = hfsplus_write_begin(NULL, mapping, size, 0,
-					  &folio, &fsdata);
-		if (res)
-			return;
-		res = generic_write_end(NULL, mapping, size, 0, 0,
-					folio, fsdata);
-		if (res < 0)
-			return;
-		mark_inode_dirty(inode);
 		return;
 	} else if (inode->i_size == hip->phys_size)
 		return;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 190c7de704fd..844027679a75 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -466,6 +466,7 @@ void hfsplus_file_truncate(struct inode *inode);
 
 /* inode.c */
 extern const struct address_space_operations hfsplus_aops;
+extern const struct address_space_operations hfsplus_symlink_aops;
 extern const struct address_space_operations hfsplus_btree_aops;
 extern const struct dentry_operations hfsplus_dentry_operations;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 9d25e6224ee5..4405918ee1c4 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -18,15 +18,12 @@
 #include <linux/cred.h>
 #include <linux/uio.h>
 #include <linux/fileattr.h>
+#include <linux/iomap.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 #include "xattr.h"
-
-static int hfsplus_read_folio(struct file *file, struct folio *folio)
-{
-	return block_read_full_folio(folio, hfsplus_get_block);
-}
+#include "iomap.h"
 
 static void hfsplus_write_failed(struct address_space *mapping, loff_t to)
 {
@@ -128,67 +125,13 @@ static bool hfsplus_release_folio(struct folio *folio, gfp_t mask)
 	return res ? try_to_free_buffers(folio) : false;
 }
 
-static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+static int hfsplus_btree_read_folio(struct file *file, struct folio *folio)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	loff_t isize;
-	size_t count = iov_iter_count(iter);
-	loff_t end = iocb->ki_pos + count;
-	ssize_t ret;
-
-	/*
-	 * The hfsplus_get_block() only allows creating the next sequential block.
-	 * For direct writes beyond EOF, expand the file first.
-	 */
-	if (iov_iter_rw(iter) == WRITE && iocb->ki_pos > i_size_read(inode)) {
-		loff_t start_off, end_off;
-		loff_t start_page, end_page;
-
-		isize = i_size_read(inode);
-
-		/*
-		 * Wait for any in-flight DIO on this inode to finish before
-		 * calling generic_cont_expand_simple().
-		 */
-		inode_dio_wait(inode);
-
-		ret = generic_cont_expand_simple(inode, iocb->ki_pos);
-		if (ret)
-			return ret;
-
-		start_off = isize;
-		end_off = (end > 0) ? end - 1 : end;
-
-		ret = filemap_write_and_wait_range(mapping, start_off, end_off);
-		if (ret)
-			return ret;
-
-		start_page = start_off >> PAGE_SHIFT;
-		end_page = end_off >> PAGE_SHIFT;
-
-		invalidate_inode_pages2_range(mapping, start_page, end_page);
-	}
-
-	ret = blockdev_direct_IO(iocb, inode, iter, hfsplus_get_block);
-
-	/*
-	 * In case of error extending write may have instantiated a few
-	 * blocks outside i_size. Trim these off again.
-	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
-		isize = i_size_read(inode);
-
-		if (end > isize)
-			hfsplus_write_failed(mapping, end);
-	}
-
-	return ret;
+	return block_read_full_folio(folio, hfsplus_get_block);
 }
 
-static int hfsplus_writepages(struct address_space *mapping,
-			      struct writeback_control *wbc)
+static int hfsplus_btree_writepages(struct address_space *mapping,
+				    struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, hfsplus_get_block);
 }
@@ -196,8 +139,8 @@ static int hfsplus_writepages(struct address_space *mapping,
 const struct address_space_operations hfsplus_btree_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= hfsplus_read_folio,
-	.writepages	= hfsplus_writepages,
+	.read_folio	= hfsplus_btree_read_folio,
+	.writepages	= hfsplus_btree_writepages,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.migrate_folio	= buffer_migrate_folio,
@@ -205,18 +148,70 @@ const struct address_space_operations hfsplus_btree_aops = {
 	.release_folio	= hfsplus_release_folio,
 };
 
-const struct address_space_operations hfsplus_aops = {
+static int hfsplus_symlink_read_folio(struct file *file, struct folio *folio)
+{
+	return block_read_full_folio(folio, hfsplus_get_block);
+}
+
+static int hfsplus_symlink_writepages(struct address_space *mapping,
+				      struct writeback_control *wbc)
+{
+	return mpage_writepages(mapping, wbc, hfsplus_get_block);
+}
+
+const struct address_space_operations hfsplus_symlink_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= hfsplus_read_folio,
+	.read_folio	= hfsplus_symlink_read_folio,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfsplus_bmap,
-	.direct_IO	= hfsplus_direct_IO,
-	.writepages	= hfsplus_writepages,
+	.writepages	= hfsplus_symlink_writepages,
 	.migrate_folio	= buffer_migrate_folio,
 };
 
+static int hfsplus_read_folio(struct file *file, struct folio *folio)
+{
+	iomap_bio_read_folio(folio, &hfsplus_iomap_ops);
+	return 0;
+}
+
+static void hfsplus_readahead(struct readahead_control *rac)
+{
+	iomap_bio_readahead(rac, &hfsplus_iomap_ops);
+}
+
+static int hfsplus_writepages(struct address_space *mapping,
+			      struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = {
+		.inode	= mapping->host,
+		.wbc	= wbc,
+		.ops	= &hfsplus_writeback_ops,
+	};
+
+	return iomap_writepages(&wpc);
+}
+
+static sector_t hfsplus_aop_bmap(struct address_space *mapping, sector_t block)
+{
+	return iomap_bmap(mapping, block, &hfsplus_iomap_ops);
+}
+
+const struct address_space_operations hfsplus_aops = {
+	.read_folio		= hfsplus_read_folio,
+	.readahead		= hfsplus_readahead,
+	.writepages		= hfsplus_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.bmap			= hfsplus_aop_bmap,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.swap_activate		= hfsplus_iomap_swap_activate,
+};
+
 const struct dentry_operations hfsplus_dentry_operations = {
 	.d_hash       = hfsplus_hash_dentry,
 	.d_compare    = hfsplus_compare_dentry,
@@ -290,10 +285,14 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 	    attr->ia_size != i_size_read(inode)) {
 		inode_dio_wait(inode);
 		if (attr->ia_size > inode->i_size) {
-			error = generic_cont_expand_simple(inode,
-							   attr->ia_size);
-			if (error)
+			loff_t old_size = inode->i_size;
+
+			i_size_write(inode, attr->ia_size);
+			error = hfsplus_iomap_cont_expand(inode, attr->ia_size);
+			if (error) {
+				i_size_write(inode, old_size);
 				return error;
+			}
 		}
 		truncate_setsize(inode, attr->ia_size);
 		hfsplus_file_truncate(inode);
@@ -399,7 +398,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		sbi->file_count++;
 		inode->i_op = &hfsplus_symlink_inode_operations;
 		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &hfsplus_aops;
+		inode->i_mapping->a_ops = &hfsplus_symlink_aops;
 		hip->clump_blocks = 1;
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
@@ -540,7 +539,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		} else if (S_ISLNK(inode->i_mode)) {
 			inode->i_op = &hfsplus_symlink_inode_operations;
 			inode_nohighmem(inode);
-			inode->i_mapping->a_ops = &hfsplus_aops;
+			inode->i_mapping->a_ops = &hfsplus_symlink_aops;
 		} else {
 			inode->i_op = &hfsplus_special_inode_operations;
 			init_special_inode(inode, inode->i_mode,
-- 
2.43.0

