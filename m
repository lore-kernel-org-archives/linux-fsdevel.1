Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288773E3177
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756314; cv=none; b=J64mchgElDxQZgmpC+rcIKIVnvFxW9noiKZu7zYq4GZGAYutkopp4c8N5kBFvjR/qmw+UAih7WZ3KOT6psSeeMt6WGJ+mgBHQzSIYv4laWNZnZLD8hnZgcTBJeuxcEYhOl1fySXIAbdsksay/QeWEmpG0wid8LuCZTv3EnpiU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756314; c=relaxed/simple;
	bh=ELnKRg8dlyxeeXTaKvYwEccKvr0wquSjfzAMyifl3T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMbyObXPUEMvUef6Q5CWRXFdBx5Vc7M3v6WqdivE+Vfg3TofEX9jUbSTzFNu25VQ2l5C5MhG5VTnSk7TVFjrytkAidCiiaXa06nk1BAOW+enoAkoA1ci6H3QZPllf3h6GfigpitMgNHtUp9YgyYqZIjCVD1TM/FhI8083uy1nZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=uEA2TK/7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="uEA2TK/7"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80814edb536so100763927b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756312; x=1785361112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2f4tBS9VUm8O9MlnBIYjif2caaXm4cYtDUEdOB8FTPg=;
        b=uEA2TK/72sfHJRp5mqSzbPgg3ekHCQ1BGOCqy/gA3/k74MH7m7EdYp6OMeDbqU+Edv
         cXClNo9Cg77WO1aLoDn736aLGwUlEbuo2C6Y49zJBOHaWJ5yG49Heex2AvyLw5+UFCop
         CfbyRpEDsWIpqVm+dzTvfTbYJmFEqO89YH7S5T0mB+6agGBka0ctDZ/yK/QO1A8QAeJI
         asi7g4gb3PFa8JYX6mTpPTOFvhna15app4n0m4c2QL0Co85PV1SFvh7I/rzMipmaR+Up
         lUYHC9w/ThrVftKVW5JyhRc+PM/i9GmGuQ9+Gx/PbrLnfosLUDhgts+CvlCWkkJY73pe
         DJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756312; x=1785361112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2f4tBS9VUm8O9MlnBIYjif2caaXm4cYtDUEdOB8FTPg=;
        b=d7ZrfEdnWzrtoxer55d9PfU3KVqCGkFYXbrEomXADO92fW3/grDyP6A0kVUQDYvtqU
         y8ZvmccKwmU8GWA7yvA6DOHRjqA+DCM2yu88HuJmG81NXwlhaL3zfADoxIza4qFlWHjU
         fAP2SMpifIi8wF5e1ToUl3M7UTkJTuuU1svdE9z9NFsLBTr+SeJvZZM9Er61i/+zR0dK
         2gA1uSvChUuAp4DRSxYaDc8HuCC3hx+2ip0F4JVgNvrpamc9dpxEXAW1bTJqd8ghXuu6
         gP0oYaPS8RtyPFwW2W0AWOrbe/7bkb5NOpaBYHYta1GD2I/NYU/OlDqdOj0lT6SCJixt
         K0Tg==
X-Gm-Message-State: AOJu0YxryseHNvmdrbvSbyfhg8G+kacBeGcaaNeXEbQEZPM1HInSgoC1
	QcFUwx6Rpuic8qn+0uU7GfpI+ayqyARscd74BqCcb1W3PmcvDrxq3fePL8e4qc690ug=
X-Gm-Gg: AR+sD10Od85zFGmt4xa+eMohpSCSwI9F4rMBHbBpeDJF6Mjb5Sa9O4CUDg3cWs8RUhR
	cGChA7Y+TrBbGSO+kH/I8hxf7wabNcXxBk82VlYV89k1R5yu2m13gmAqawUQ9UsErQgg93/Lp9R
	g7II7dUpt2dglbb0Ht/9LmXotCnHVOM8NkGVwl5NvTtolCaaByrQYhe17cghNpaLsAmYyJWFSVb
	kulsqyXVZyXMbgLf52tt/K4AQ0PByUBrMQVvU2ArUcSf6DPuKUpqTLyQDHGc5/zK1i/iYH7+xeL
	viDH6F0kmmirF0Q+4d6ZzPPyuRWA2wMDWxife93YEFD1k5GYbb8hlHEjH0JwUrF4PSSLd4q7jjk
	V+/mUYo/y7DVJ1Fp9flefL0ghyI0vIexCNIa/awwqQoNXQOaVmxxhk4RWp5HUXwZEQWwHI0kjzj
	0kKjOamHmPG0vlBNK+y1WezRP7OuYriWxUAsHfUe4wKjdPap7gly4lJE3QTcmuEW/0YY3HvIhuA
	3mYIliwftQ8Bs4QmBe7K1VWkAD2LgeVU0A=
X-Received: by 2002:a05:690c:46c1:b0:81e:1702:1752 with SMTP id 00721157ae682-81f4c413f51mr1013617b3.61.1784756311955;
        Wed, 22 Jul 2026 14:38:31 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:31 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 6/6] hfsplus: switch address_space_operations on iomap-based support
Date: Wed, 22 Jul 2026 14:37:58 -0700
Message-ID: <20260722213759.1360225-7-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722213759.1360225-1-slava@dubeyko.com>
References: <20260722213759.1360225-1-slava@dubeyko.com>
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

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/Kconfig      |   1 -
 fs/hfsplus/extents.c    |  39 +++++++----
 fs/hfsplus/hfsplus_fs.h |   1 +
 fs/hfsplus/inode.c      | 142 +++++++++++++++++++---------------------
 4 files changed, 96 insertions(+), 87 deletions(-)

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
index c1c9b21814a0..8f7f560cec64 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -15,6 +15,7 @@
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
+#include "iomap.h"
 
 /* Compare two extents keys, returns 0 on same, pos/neg for difference */
 int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
@@ -605,20 +606,32 @@ void hfsplus_file_truncate(struct inode *inode)
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
index ea0e35119d73..79d9134b284e 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -461,6 +461,7 @@ void hfsplus_file_truncate(struct inode *inode);
 
 /* inode.c */
 extern const struct address_space_operations hfsplus_aops;
+extern const struct address_space_operations hfsplus_symlink_aops;
 extern const struct address_space_operations hfsplus_btree_aops;
 extern const struct dentry_operations hfsplus_dentry_operations;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 9d25e6224ee5..1ac99ce0dd3b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -18,12 +18,14 @@
 #include <linux/cred.h>
 #include <linux/uio.h>
 #include <linux/fileattr.h>
+#include <linux/iomap.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 #include "xattr.h"
+#include "iomap.h"
 
-static int hfsplus_read_folio(struct file *file, struct folio *folio)
+static int hfsplus_legacy_read_folio(struct file *file, struct folio *folio)
 {
 	return block_read_full_folio(folio, hfsplus_get_block);
 }
@@ -128,66 +130,7 @@ static bool hfsplus_release_folio(struct folio *folio, gfp_t mask)
 	return res ? try_to_free_buffers(folio) : false;
 }
 
-static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
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
-}
-
-static int hfsplus_writepages(struct address_space *mapping,
+static int hfsplus_legacy_writepages(struct address_space *mapping,
 			      struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, hfsplus_get_block);
@@ -196,8 +139,8 @@ static int hfsplus_writepages(struct address_space *mapping,
 const struct address_space_operations hfsplus_btree_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= hfsplus_read_folio,
-	.writepages	= hfsplus_writepages,
+	.read_folio	= hfsplus_legacy_read_folio,
+	.writepages	= hfsplus_legacy_writepages,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.migrate_folio	= buffer_migrate_folio,
@@ -205,18 +148,59 @@ const struct address_space_operations hfsplus_btree_aops = {
 	.release_folio	= hfsplus_release_folio,
 };
 
-const struct address_space_operations hfsplus_aops = {
+const struct address_space_operations hfsplus_symlink_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= hfsplus_read_folio,
+	.read_folio	= hfsplus_legacy_read_folio,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfsplus_bmap,
-	.direct_IO	= hfsplus_direct_IO,
-	.writepages	= hfsplus_writepages,
+	.writepages	= hfsplus_legacy_writepages,
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
@@ -290,10 +274,22 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 	    attr->ia_size != i_size_read(inode)) {
 		inode_dio_wait(inode);
 		if (attr->ia_size > inode->i_size) {
-			error = generic_cont_expand_simple(inode,
-							   attr->ia_size);
-			if (error)
-				return error;
+			if (S_ISREG(inode->i_mode)) {
+				loff_t old_size = inode->i_size;
+
+				i_size_write(inode, attr->ia_size);
+				error = hfsplus_iomap_cont_expand(inode,
+								  attr->ia_size);
+				if (error) {
+					i_size_write(inode, old_size);
+					return error;
+				}
+			} else {
+				error = generic_cont_expand_simple(inode,
+								   attr->ia_size);
+				if (error)
+					return error;
+			}
 		}
 		truncate_setsize(inode, attr->ia_size);
 		hfsplus_file_truncate(inode);
@@ -399,7 +395,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		sbi->file_count++;
 		inode->i_op = &hfsplus_symlink_inode_operations;
 		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &hfsplus_aops;
+		inode->i_mapping->a_ops = &hfsplus_symlink_aops;
 		hip->clump_blocks = 1;
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
@@ -540,7 +536,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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

