Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3164483A8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901515; cv=none; b=FNi1FlmsRgzi5d+FwbkV6w7CA40+uo5JAhN/Ck92B+hAAhiP7hNZJqN5ugq23PN1lZR9aDDURKiniG7MqffGRc8T6h/eyBgd0KQjyrevdNuEH6VPAmzINhPFGFMWxUiCUSalt+TPd0xkSOtIdGIxVF89ukOP5ufuJq4VYrNAKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901515; c=relaxed/simple;
	bh=67SyYzIwQeaVB8qECauKzU1vkj6OlxuDbwBH9VfjrDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK+FWsnRYdQOGWcKRby71P1bkIWA3R9JaMSgD3/mNBxJLtYB3tcsAqzyOvsNrwTJPWAk6FHHlx0Xftd3VGEikxh94JnpCAo4IBrNf2/yTwiOzNbBFdNS6wHLmjOQ7dYEhBY+ANQFE1MBAybdssSrK63lHxjIDthOZjIrG/NSrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=H8/ov4IQ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="H8/ov4IQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c744a00edso4402455d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788901512; x=1789506312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b82npGyG+u9YzhjLZY8NY3sClLJXpbhUpD4i89Dp3Kw=;
        b=H8/ov4IQHoWfy92miFqKjYIsQ5FrXXJqCLZx/Vi2YeE1oUNWx9ALy3IjtqgbDHSI/N
         aPOl1KuEHfGKpWcd5+3bM4uy5PjCuu8TGg7X6E1YmYcGzWS4lgaExrZ4BeD1OgkdmscW
         2vFPhTUR9PUIh6jKUlb3rWukTZqpbdNljIDUJxwFKUg4BllEZO++/GqXY0hJsfDhoFZp
         jomvNt+qV2IJeX7Pl88RVcSBrS/0mF8DmpEho9N7zDLQU5cAGPaKxA6dH/88i+TAI9sY
         K25Qbg1fcAlDPUPmOantWGc3vw2wDs50PjW3jP8t94Ps3C6yFBxQ/8fHq0ekw48zebYY
         alkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901512; x=1789506312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b82npGyG+u9YzhjLZY8NY3sClLJXpbhUpD4i89Dp3Kw=;
        b=h5hQFZuSD/PKf903qH20OAYHZ1yga7AVG6rXIGnw/8TqvCtODGLthGWDWed8OnKvOD
         umRS30icAdkPE6gP/v1z0VWV6+l/+qGXN2B5+Ybu5B5o+fnye7hofhAfzATcHE8M2SOx
         ImDsz/ZbotkURGA+mEylIi6ZHXnG6Xc7S1SdCh34TmGDaITTyofhVaimMWjFRUuFhPYv
         nJsLnShIejqJMMHX9IvyPuWkL5nDIY8bAww86sYn7wyusH/CE2AKRCPvDTz3am5zlV+5
         dQzsr9p/zoDKZe/75GDlWf9ydpGtHX8d8mVa+l/2zlRb7I+GS744uXL7THqN0hUnX9DQ
         FziA==
X-Gm-Message-State: AFuF++lyXKIuvEZ3sPa5fRyEc7m1vzwoliIZyqr1BOikYJwpNLPuaPi+
	QPLP85d12EEAQe9M01ITDqlhlDkfFp96Ohi0AxiqKLLgVUJuBfF2vdT60yFZROh/izs=
X-Gm-Gg: AYBFou2pf1rbM/kn5eGJ5QhQUu0jdr8jkrsAwYKRo342EFCDQVpMZOBFSZjM/kmgOx3
	gfBySQ8xtnaZ29c2lhSupLHj5JgCK8InEQa1gA0Lmkl0rbNrXW1yAh/07IHiMl87eNBbM+P0CL2
	kvXmVVkKB4Ost3p8Cs+zkUEHS+EgpATJ+/U8I2mYCTD8pXzha4ai/P5xFNPo7nxhMZIJXsYYqwA
	l09meSiVJHIYVtXcmsK3tZuDx/FFsQWPz4h2rLt/X5CSgA7/ORGeN2yxHpaBSZN/9p/WTKxnsVo
	BWPKIRSujyVOfpFTAOcLGlVOZhuHLZsd8djK2QTu3Z2K3yOGCXdkorTmaqb1Bz8+o571sPcjPVA
	NtlEyzG52PDMKsR8gWl4o2qVxsAhb2WLcmam+IAmkXuMSKJ8s3tYBm/EgO5t20EVyEFs/O4eZ91
	d73sNhqLaaHfTSLTVlO4xrR4rt9vpSelM34XiWJ8ZJBArGT+ACO5toHTkvQ9fjeYCM/D8P27lVH
	PEelG/XK5T1IHxuyQ1d0bMp5AahzqhwYU/wjnDWxRTAEeKeBbiN5RRBH+jsV6/MlGnzOius9qNR
	oP+Yz51LzJkKxGjb
X-Received: by 2002:a05:690e:2366:b0:66d:632:9afc with SMTP id 956f58d0204a3-66fb5a6f933mr7761340d50.30.1788901512177;
        Tue, 08 Sep 2026 14:05:12 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb495eccesm11078129d50.18.2026.09.08.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:05:11 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 7/7] hfsplus: switch address_space_operations on iomap-based support
Date: Tue,  8 Sep 2026 14:04:48 -0700
Message-ID: <20260908210448.296772-8-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908210448.296772-1-slava@dubeyko.com>
References: <20260908210448.296772-1-slava@dubeyko.com>
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
v2
The hfsplus_btree_aops uses hfsplus_btree_read_folio() and
hfsplus_btree_writepages() methods. The hfsplus_symlink_aops
uses hfsplus_symlink_read_folio() and hfsplus_symlink_writepages()
methods. Also, hfsplus_setattr() doesn't distinguish the regular
and not regular file cases anymore.

v3
Fix failures in generic/091, generic/521, and generic/551.
---
 fs/hfsplus/Kconfig      |   1 -
 fs/hfsplus/extents.c    |  46 ++++++++----
 fs/hfsplus/hfsplus_fs.h |   1 +
 fs/hfsplus/inode.c      | 159 +++++++++++++++++++++-------------------
 4 files changed, 117 insertions(+), 90 deletions(-)

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
index ffd52ad8867c..fb2b12473cb2 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -15,6 +15,7 @@
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
+#include "iomap.h"
 
 /* Compare two extents keys, returns 0 on same, pos/neg for difference */
 int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
@@ -275,6 +276,8 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
 		*max_blocks = hfsplus_ext_find_block(hip->first_extents,
 						     ablock,
 						     dblock);
+		if (!*max_blocks)
+			return -EIO;
 		return 0;
 	}
 
@@ -302,6 +305,9 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
 	if (was_dirty)
 		mark_inode_dirty(inode);
 
+	if (!*max_blocks)
+		return -EIO;
+
 	return 0;
 }
 
@@ -342,7 +348,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 
 	if (create) {
 		set_buffer_new(bh_result);
-		hip->phys_size += sb->s_blocksize;
+		hip->phys_size = (loff_t)(iblock + 1) << sb->s_blocksize_bits;
 		hip->fs_blocks++;
 		inode_add_bytes(inode, sb->s_blocksize);
 		mark_inode_dirty(inode);
@@ -607,20 +613,32 @@ void hfsplus_file_truncate(struct inode *inode)
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
index 9d25e6224ee5..717831dc5cca 100644
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
@@ -290,13 +285,27 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
 	    attr->ia_size != i_size_read(inode)) {
 		inode_dio_wait(inode);
 		if (attr->ia_size > inode->i_size) {
-			error = generic_cont_expand_simple(inode,
-							   attr->ia_size);
+			loff_t old_size = inode->i_size;
+
+			i_size_write(inode, attr->ia_size);
+			error = hfsplus_iomap_cont_expand(inode, attr->ia_size);
+			if (error) {
+				i_size_write(inode, old_size);
+				return error;
+			}
+			truncate_setsize(inode, attr->ia_size);
+		} else {
+			bool did_zero = false;
+
+			error = iomap_truncate_page(inode, attr->ia_size,
+						    &did_zero,
+						    &hfsplus_write_iomap_ops,
+						    NULL, NULL);
 			if (error)
 				return error;
+			truncate_setsize(inode, attr->ia_size);
+			hfsplus_file_truncate(inode);
 		}
-		truncate_setsize(inode, attr->ia_size);
-		hfsplus_file_truncate(inode);
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 
@@ -399,7 +408,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		sbi->file_count++;
 		inode->i_op = &hfsplus_symlink_inode_operations;
 		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &hfsplus_aops;
+		inode->i_mapping->a_ops = &hfsplus_symlink_aops;
 		hip->clump_blocks = 1;
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
@@ -540,7 +549,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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

