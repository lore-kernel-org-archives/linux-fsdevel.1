Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9230EF92;
	Sun, 11 Oct 2026 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757022; cv=none; b=hOPmRc4R+HGlQGBloIUF+hUw6QsU0F/mqp7NPYhAY4VirrjM2guWabxA3AjFB4zhCjEC/qyE6gbNxLkj8i52cqg93Yhhv78vtvKj0PqFAChFqbQq3600bKUCz/XPve4IrsyhEILd6fcYlu3BqTGua7pBYGP7Cu/a5s+igjFaAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757022; c=relaxed/simple;
	bh=ezzoSx8oyAVzIaSTdOmVlXautFS21YB6b6NUPvgdyfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hY1Upjz2lz4EyNWoIGp3l6P3q6jYveS5Zs37yyMzimjbgAFyRM96chgFTkjXLjX5xbxOqhvUUXZEQwqqAwI9tCy17ESkr5Yf/IIO45ym8iboxhvenZvK9xnjp4thD0tiq7kWLuQi2CjZyIXGPTiiSltFNzPfP+SmAV1LYlwThwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeXDUvay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeXDUvay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F601F0089C;
	Sun, 11 Oct 2026 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791757017;
	bh=xeIfhlgG6LUD7K2W7/6tr3QeDVc2Flba7J/FxcgGybI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeXDUvaytVxDtzErNiX2x1aYObEQXjv2q6xQ4M/x2TBWDEKuJvbDLriNCUHPpf7fc
	 JwD54+JlSX66vG3HeY8NXbI9koVNbHJgef6Mdx9clVb3H6XV6Lr0EDgfp8qQqrEag2
	 UquCbefPIp8I7OdqPlQZ58gWum2BK1OWQOxG16r/1Z9nbcyM7Y15K95/hsQzWXmHoG
	 +o8DhX3VaKE/apKsqV5xfh25zCTF4E0Y7KbNg+5DNYqCI4QppUG94J4BsvBl8E1jvy
	 1zYB7RJ0KAv7bQaCX/Q0EgeeFmqoCEpm2mFI/O23ddhdtCcwbBIX8R66CMCLniPaH7
	 /Dvadknoexcvw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 2/4] ntfs: add pathname access for named streams
Date: Mon, 12 Oct 2026 07:16:46 +0900
Message-Id: <20261011221648.6811-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261011221648.6811-1-linkinjeon@kernel.org>
References: <20261011221648.6811-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional Windows-style pathname interface for named $DATA streams,
enabled with streams_interface=windows. The option defaults to none, and
the named-stream ioctls remain available regardless of this setting.

Support lookup, creation, and removal of named streams for existing regular
files and directories. A stream is opened as a regular file through the
base-name and stream-name form in the final path component. A stream can be
created only for an existing file or directory. The pathname interface
accepts a base file name and stream name only. It rejects paths that also
specify an NTFS attribute type such as $DATA. In windows mode, ordinary
filenames containing a colon are hidden from directory listings and cannot
be accessed through the pathname interface.

Match stream names case-insensitively. Streams and their base objects
report the same inode number. Removing the base object while a stream is
open detaches the stream from the namespace. Since NTFS has no
orphan-stream list, a crash can leave the stream data unreachable on disk.

Expose named streams as regular file descriptors for the file operations
requested by Wine, including read, write, fsync, fdatasync,
sync_file_range, file locking, mmap, futimes, fstat, ftruncate, SEEK_DATA,
SEEK_HOLE, fallocate, and pathname unlink. Stream timestamps are shared
with the base file. fstat reports the base metadata and inode number with
the stream's own size and allocation.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/attrib.c       |  40 +-
 fs/ntfs/attrib.h       |   2 +-
 fs/ntfs/dir.c          |   7 +-
 fs/ntfs/ea.c           |  21 +-
 fs/ntfs/file.c         | 117 ++++--
 fs/ntfs/inode.c        |  18 +-
 fs/ntfs/iomap.c        |  64 +--
 fs/ntfs/named_stream.c | 907 ++++++++++++++++++++++++++++++++++++++++-
 fs/ntfs/namei.c        | 132 +++++-
 fs/ntfs/stream.h       |  38 ++
 fs/ntfs/super.c        |  33 ++
 fs/ntfs/volume.h       |   3 +
 fs/ntfs/wof.c          |   6 +-
 13 files changed, 1300 insertions(+), 88 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 15131e9401e2..fce7144d7bef 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5487,34 +5487,46 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 	return !ret;
 }
 
+/*
+ * If @attr_vi is non-NULL, the attribute inode reference is returned to the
+ * caller, which must release it after dropping ni->mrec_lock.
+ */
 int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
-		u32 name_len)
+		u32 name_len, struct inode **attr_vi)
 {
 	int err;
-	struct inode *attr_vi;
+	struct inode *vi;
 	struct ntfs_inode *attr_ni;
 
 	ntfs_debug("Entering\n");
 
+	if (attr_vi)
+		*attr_vi = NULL;
 	if (!ni)
 		return -EINVAL;
 
-	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
-	if (IS_ERR(attr_vi)) {
-		err = PTR_ERR(attr_vi);
-		ntfs_error(ni->vol->sb,
-			"Failed to open attribute 0x%02x of inode 0x%llx",
-			type, (unsigned long long)ni->mft_no);
+	vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
+	if (IS_ERR(vi)) {
+		err = PTR_ERR(vi);
+		ntfs_error(ni->vol->sb, "Failed to open attribute 0x%02x of inode 0x%llx",
+				type, (unsigned long long)ni->mft_no);
 		return err;
 	}
-	attr_ni = NTFS_I(attr_vi);
+	attr_ni = NTFS_I(vi);
 
 	err = ntfs_attr_rm(attr_ni);
-	if (err)
-		ntfs_error(ni->vol->sb,
-			"Failed to remove attribute 0x%02x of inode 0x%llx",
-			type, (unsigned long long)ni->mft_no);
-	iput(attr_vi);
+	if (err) {
+		ntfs_error(ni->vol->sb, "Failed to remove attribute 0x%02x of inode 0x%llx",
+				type, (unsigned long long)ni->mft_no);
+	} else {
+		NInoClearDirty(attr_ni);
+		clear_nlink(vi);
+		remove_inode_hash(vi);
+	}
+	if (attr_vi)
+		*attr_vi = vi;
+	else
+		iput(vi);
 	return err;
 }
 
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 6b4fa9f57640..bee91c9f6f81 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -124,7 +124,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni);
 int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len);
 int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
-		u32 name_len);
+		u32 name_len, struct inode **attr_vi);
 int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx);
 int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode *ni);
 int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index b95173f068cb..5a0e21e7c283 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/string.h>
 
 #include "dir.h"
 #include "mft.h"
@@ -624,7 +625,6 @@ static inline int ntfs_filldir(struct ntfs_volume *vol,
 		ntfs_debug("Skipping hidden file.");
 		return 0;
 	}
-
 	name_len = ntfs_ucstonls(vol, (__le16 *)&ie->key.file_name.file_name,
 			ie->key.file_name.file_name_length, &name,
 			NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1);
@@ -633,7 +633,10 @@ static inline int ntfs_filldir(struct ntfs_volume *vol,
 				(long long)MREF_LE(ie->data.dir.indexed_file));
 		return 0;
 	}
-
+	if (NVolStreamsWindows(vol) && strchr((char *)name, ':')) {
+		ntfs_debug("Skipping file name containing a stream separator.");
+		return 0;
+	}
 	mref = MREF_LE(ie->data.dir.indexed_file);
 	if (ie->key.file_name.file_attributes & FILE_ATTR_REPARSE_POINT)
 		dt_type = ntfs_reparse_tag_dt_types(vol, mref);
diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index ff69fb07f84a..1104fd72cd2a 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -246,7 +246,7 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 			goto out;
 
 		if (ntfs_attr_exist(ni, AT_EA, AT_UNNAMED, 0)) {
-			err = ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0);
+			err = ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0, NULL);
 			if (err)
 				goto out;
 		}
@@ -301,11 +301,12 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 		p_ea_info->ea_query_length = cpu_to_le32(ea_info_qsize);
 
 		if ((flags & XATTR_REPLACE) && !val_size && !ea_info_qsize) {
-			err = ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0);
+			err = ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0, NULL);
 			if (err)
 				goto out;
 
-			err = ntfs_attr_remove(ni, AT_EA_INFORMATION, AT_UNNAMED, 0);
+			err = ntfs_attr_remove(ni, AT_EA_INFORMATION, AT_UNNAMED,
+					0, NULL);
 			if (err) {
 				/* Restore the original $EA if $EA_INFORMATION removal failed. */
 				ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, old_ea_buf,
@@ -610,6 +611,14 @@ static int ntfs_getxattr(const struct xattr_handler *handler,
 	struct ntfs_inode *ni = NTFS_I(inode);
 	int err;
 
+	/*
+	 * Stream permissions and privileges belong to the base inode. This
+	 * also lets VFS killpriv helpers find the base security attributes.
+	 */
+	if (ntfs_inode_is_named_stream(ni)) {
+		ni = ni->ext.base_ntfs_ino;
+		inode = VFS_I(ni);
+	}
 	if (NVolShutdown(ni->vol))
 		return -EIO;
 
@@ -716,8 +725,8 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 			goto err_out;
 
 		ntfs_attr_reinit_search_ctx(ctx);
-		err = ntfs_attr_lookup(ni->type, ni->name,
-				ni->name_len, CASE_SENSITIVE,
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE,
 				0, NULL, 0, ctx);
 		if (err) {
 			err = -EINVAL;
@@ -883,6 +892,8 @@ static int ntfs_setxattr(const struct xattr_handler *handler,
 	int err;
 	__le32 fattr;
 
+	if (ntfs_inode_is_named_stream(ni))
+		return -EOPNOTSUPP;
 	if (NVolShutdown(ni->vol))
 		return -EIO;
 
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 7818d88b2133..a2e843cf947c 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -17,8 +17,10 @@
 #include <linux/falloc.h>
 #include <linux/file.h>
 #include <linux/filelock.h>
+#include <linux/list.h>
 #include <linux/overflow.h>
 #include <linux/security.h>
+#include <linux/slab.h>
 #include <uapi/linux/ntfs.h>
 
 #include "lcnalloc.h"
@@ -142,6 +144,11 @@ int ntfs_file_release(struct inode *vi, struct file *filp)
 	return 0;
 }
 
+struct ntfs_fsync_attr {
+	struct list_head list;
+	struct inode *inode;
+};
+
 /*
  * ntfs_file_fsync - sync a file to disk
  * @filp:	file to be synced
@@ -171,6 +178,8 @@ int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	int err, ret = 0;
 	struct inode *parent_vi, *ia_vi;
 	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_fsync_attr *attr, *next;
+	LIST_HEAD(attrs);
 	bool non_resident, stream;
 
 	ntfs_debug("Entering for inode 0x%llx.", ni->mft_no);
@@ -195,8 +204,7 @@ int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 
 	/*
 	 * file_write_and_wait_range() already flushed this stream mapping.
-	 * Do not walk sibling attribute mappings while holding the base MFT
-	 * lock; ordinary file fsync retains its existing behavior below.
+	 * A stream fsync does not need to flush sibling attribute mappings.
 	 */
 	if (stream)
 		goto sync_volume;
@@ -232,22 +240,53 @@ int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 			name = (__le16 *)((u8 *)ctx->attr + le16_to_cpu(ctx->attr->name_offset));
 			if (ctx->attr->type == AT_DATA && ctx->attr->name_length == 0)
 				continue;
+			if (ctx->attr->type == AT_DATA &&
+			    ntfs_stream_unlinked(ni, name, ctx->attr->name_length))
+				continue;
 
+			attr = kmalloc_obj(*attr, GFP_NOFS);
+			if (!attr) {
+				err = -ENOMEM;
+				break;
+			}
 			attr_vi = ntfs_attr_iget(vi, ctx->attr->type,
 						 name, ctx->attr->name_length);
-			if (IS_ERR(attr_vi))
+			if (IS_ERR(attr_vi)) {
+				kfree(attr);
 				continue;
-			spin_lock(&attr_vi->i_lock);
-			if (inode_state_read_once(attr_vi) & I_DIRTY_PAGES) {
-				spin_unlock(&attr_vi->i_lock);
-				filemap_write_and_wait(attr_vi->i_mapping);
-			} else
-				spin_unlock(&attr_vi->i_lock);
-			iput(attr_vi);
+			}
+			if (ntfs_inode_is_named_stream(NTFS_I(attr_vi)))
+				atomic_inc(&NTFS_I(attr_vi)->stream_open_count);
+			attr->inode = attr_vi;
+			list_add_tail(&attr->list, &attrs);
 		}
 	}
 	mutex_unlock(&ni->mrec_lock);
 	ntfs_attr_put_search_ctx(ctx);
+	if (err != -ENOENT && !ret)
+		ret = err;
+
+	/* Attribute writeback takes the base inode's MFT record lock. */
+	list_for_each_entry_safe(attr, next, &attrs, list) {
+		struct inode *attr_vi = attr->inode;
+
+		err = filemap_write_and_wait(attr_vi->i_mapping);
+		if (err && !ret)
+			ret = err;
+		if (ntfs_inode_is_named_stream(NTFS_I(attr_vi))) {
+			err = ntfs_stream_put(attr_vi);
+			if (err && !ret)
+				ret = err;
+		}
+		iput(attr_vi);
+		list_del(&attr->list);
+		kfree(attr);
+	}
+
+	/* Attribute writeback may have updated the base mapping pairs. */
+	err = write_inode_now(vi, 1);
+	if (err && !ret)
+		ret = err;
 
 sync_volume:
 	write_inode_now(vol->mftbmp_ino, 1);
@@ -295,7 +334,6 @@ int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
-	struct inode *time_vi = vi;
 	bool stream = ntfs_inode_is_named_stream(ni);
 	int err;
 	loff_t old_size = vi->i_size;
@@ -333,7 +371,6 @@ int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		mutex_unlock(&base_ni->mrec_lock);
 		if (err)
 			goto out_unlock_mapping;
-		time_vi = VFS_I(base_ni);
 	} else {
 		filemap_invalidate_lock(vi->i_mapping);
 	}
@@ -361,14 +398,10 @@ int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		goto out_unlock_mapping;
 	}
 
-	if (stream) {
-		inode_set_mtime_to_ts(time_vi,
-				inode_set_ctime_current(time_vi));
-		mark_inode_dirty(time_vi);
-	}
-
 out_unlock_mapping:
 	filemap_invalidate_unlock(vi->i_mapping);
+	if (!err && stream)
+		ntfs_stream_update_base_time(base_ni);
 
 	return err;
 }
@@ -500,6 +533,24 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+/*
+ * Validate a stream before VFS write handling removes privileges or updates
+ * timestamps on its base inode.
+ */
+static int ntfs_file_modified(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	int err;
+
+	if (ntfs_inode_is_named_stream(NTFS_I(inode))) {
+		err = ntfs_stream_validate_for_mutation(inode,
+				iocb->ki_flags & IOCB_NOWAIT);
+		if (err)
+			return err;
+	}
+	return kiocb_modified(iocb);
+}
+
 loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -710,7 +761,7 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		goto out_lock;
 
-	err = file_modified(iocb->ki_filp);
+	err = ntfs_file_modified(iocb);
 	if (err) {
 		ret = err;
 		goto out_lock;
@@ -788,13 +839,24 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct address_space *mapping = inode->i_mapping;
+	bool stream = ntfs_inode_is_named_stream(NTFS_I(inode));
+	int err;
 	vm_fault_t ret;
 
 	if (NInoWofCompressed(NTFS_I(inode)))
 		return VM_FAULT_SIGBUS;
 
 	sb_start_pagefault(inode->i_sb);
-	file_update_time(vmf->vma->vm_file);
+	if (stream) {
+		err = ntfs_stream_validate_for_mutation(inode, false);
+		if (err)
+			goto out_error;
+		err = file_update_time(vmf->vma->vm_file);
+		if (err)
+			goto out_error;
+	} else {
+		file_update_time(vmf->vma->vm_file);
+	}
 
 	/*
 	 * Serialize against truncate/fallocate which hold the lock
@@ -805,6 +867,10 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_unlock_shared(mapping);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
+
+out_error:
+	sb_end_pagefault(inode->i_sb);
+	return vmf_error(err);
 }
 
 static const struct vm_operations_struct ntfs_file_vm_ops = {
@@ -1281,6 +1347,13 @@ long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		inode_unlock(vi);
 		return -EOPNOTSUPP;
 	}
+	if (stream) {
+		err = ntfs_stream_validate_for_mutation(vi, false);
+		if (err) {
+			inode_unlock(vi);
+			return err;
+		}
+	}
 	old_size = i_size_read(vi);
 
 	inode_dio_wait(vi);
@@ -1322,9 +1395,7 @@ long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	if (!err) {
 		if (stream) {
-			inode_set_mtime_to_ts(VFS_I(base_ni),
-					inode_set_ctime_current(VFS_I(base_ni)));
-			mark_inode_dirty(VFS_I(base_ni));
+			ntfs_stream_update_base_time(base_ni);
 		} else {
 			NInoSetFileNameDirty(ni);
 			inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 1ab9d25b712c..93680a11fdcc 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1547,6 +1547,10 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		vi->i_blocks = ni->itype.compressed.size >> 9;
 	else
 		vi->i_blocks = ni->allocated_size >> 9;
+	if (ni->type == AT_DATA && ni->name_len) {
+		vi->i_op = &ntfs_stream_inode_ops;
+		vi->i_fop = &ntfs_stream_file_ops;
+	}
 	/*
 	 * Make sure the base inode does not go away and attach it to the
 	 * attribute inode.
@@ -2537,6 +2541,10 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_puts(sf, ",symlink=native");
 	else
 		seq_puts(sf, ",symlink=wsl");
+	if (NVolStreamsWindows(vol))
+		seq_puts(sf, ",streams_interface=windows");
+	else
+		seq_puts(sf, ",streams_interface=none");
 	if (vol->sb->s_flags & SB_POSIXACL)
 		seq_puts(sf, ",acl");
 	return 0;
@@ -2597,15 +2605,19 @@ int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
 int ntfs_truncate_vfs(struct inode *vi, loff_t new_size, loff_t i_size)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	int err;
 
-	mutex_lock(&ni->mrec_lock);
+	mutex_lock(&mrec_ni->mrec_lock);
 	err = __ntfs_attr_truncate_vfs(ni, new_size, i_size);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 	if (err < 0)
 		return err;
 
-	inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
+	if (ntfs_inode_is_named_stream(ni))
+		ntfs_stream_update_base_time(mrec_ni);
+	else
+		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
 	return 0;
 }
 
diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 754d5d91b6dc..2940a5587add 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -64,11 +64,7 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	int err = 0;
 	char *kattr;
 
-	if (NInoAttr(ni))
-		base_ni = ni->ext.base_ntfs_ino;
-	else
-		base_ni = ni;
-
+	base_ni = ntfs_base_inode(ni);
 	mutex_lock(&base_ni->mrec_lock);
 
 	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
@@ -114,7 +110,8 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 
-	if (!err && keep_mrec_lock && iomap->type == IOMAP_INLINE) {
+	if (!err && keep_mrec_lock &&
+	    iomap->type == IOMAP_INLINE) {
 		iomap->private = base_ni;
 		return 0;
 	}
@@ -399,6 +396,8 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 						      loff_t length, struct iomap *iomap)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
+			ntfs_base_inode(ni) : ni;
 	struct ntfs_volume *vol = ni->vol;
 	loff_t vcn_ofs, rl_length;
 	struct runlist_element *rl, *rlc;
@@ -417,7 +416,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 		up_read(&ni->runlist.lock);
 		err = ntfs_map_runlist(ni, vcn);
 		if (err) {
-			mutex_unlock(&ni->mrec_lock);
+			mutex_unlock(&mrec_ni->mrec_lock);
 			return -ENOENT;
 		}
 		down_read(&ni->runlist.lock);
@@ -431,7 +430,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 	rl = __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 		return -EIO;
 	}
 	lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
@@ -452,7 +451,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 	 */
 	if (lcn == LCN_RL_NOT_MAPPED) {
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 		return map_err == -ENOMEM ? -ENOMEM : -EIO;
 	}
 
@@ -462,7 +461,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 				"runlist(vcn : %lld, length : %lld) is corrupted\n",
 				rl->vcn, rl->length);
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 		return -EIO;
 	}
 
@@ -476,7 +475,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			if (max_clu_count < 0) {
 				err = max_clu_count;
 				up_write(&ni->runlist.lock);
-				mutex_unlock(&ni->mrec_lock);
+				mutex_unlock(&mrec_ni->mrec_lock);
 				return err;
 			}
 		}
@@ -491,7 +490,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 					GFP_NOFS);
 			if (!rlc) {
 				up_write(&ni->runlist.lock);
-				mutex_unlock(&ni->mrec_lock);
+				mutex_unlock(&mrec_ni->mrec_lock);
 				return -ENOMEM;
 			}
 
@@ -508,7 +507,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			if (IS_ERR(rl)) {
 				ntfs_error(vol->sb, "Failed to merge runlists");
 				up_write(&ni->runlist.lock);
-				mutex_unlock(&ni->mrec_lock);
+				mutex_unlock(&mrec_ni->mrec_lock);
 				kvfree(rlc);
 				return PTR_ERR(rl);
 			}
@@ -518,7 +517,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			ni->i_dealloc_clusters += max_clu_count;
 		}
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 
 		if (lcn < LCN_DELALLOC)
 			ntfs_hold_dirty_clusters(vol, max_clu_count);
@@ -570,7 +569,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 		}
 	} else {
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = ntfs_cluster_to_bytes(vol, lcn) + vcn_ofs;
@@ -595,6 +594,8 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 		struct iomap *iomap, int ntfs_iomap_flags)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
+			ntfs_base_inode(ni) : ni;
 	struct ntfs_volume *vol = ni->vol;
 	loff_t vcn_ofs, rl_length;
 	s64 vcn, start_lcn, lcn_count;
@@ -613,7 +614,7 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 			max_clu_count, &balloc, update_mp,
 			ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK);
 	up_write(&ni->runlist.lock);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 	if (err) {
 		ni->i_dealloc_clusters = 0;
 		return err;
@@ -667,8 +668,8 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 
 	if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_MKWRITE &&
 	    iomap->offset + iomap->length > ni->initialized_size) {
-		err = ntfs_attr_set_initialized_size(ni, iomap->offset +
-				iomap->length);
+		err = ntfs_attr_set_initialized_size(ni,
+				iomap->offset + iomap->length);
 	}
 
 	return err;
@@ -678,13 +679,15 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 		struct iomap *iomap)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
+			ntfs_base_inode(ni) : ni;
 	struct attr_record *a;
-	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_attr_search_ctx *ctx = NULL;
 	u32 attr_len;
 	int err = 0;
 	char *kattr;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(mrec_ni, NULL);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
@@ -707,13 +710,14 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	iomap->inline_data = kattr;
 	iomap->offset = 0;
 	iomap->length = attr_len;
+	iomap->private = mrec_ni;
 
 out:
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 
 	if (err)
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 
 	return err;
 }
@@ -722,7 +726,12 @@ static int ntfs_write_iomap_begin_non_resident(struct inode *inode, loff_t offse
 					       loff_t length, unsigned int flags,
 					       struct iomap *iomap, int ntfs_iomap_flags)
 {
-	mutex_lock(&NTFS_I(inode)->mrec_lock);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
+			ntfs_base_inode(ni) : ni;
+
+	mutex_lock(&mrec_ni->mrec_lock);
+
 	if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
 		return  ntfs_write_simple_iomap_begin_non_resident(inode, offset,
 								   length, iomap);
@@ -738,12 +747,15 @@ static int __ntfs_write_iomap_begin(struct inode *inode, loff_t offset,
 				    struct iomap *iomap, int ntfs_iomap_flags)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *mrec_ni;
 
 	if (NVolShutdown(ni->vol))
 		return -EIO;
 
 	if (!NInoNonResident(ni)) {
-		mutex_lock(&ni->mrec_lock);
+		mrec_ni = ntfs_inode_is_named_stream(ni) ?
+				ntfs_base_inode(ni) : ni;
+		mutex_lock(&mrec_ni->mrec_lock);
 		return ntfs_write_iomap_begin_resident(inode, offset, iomap);
 	}
 	return  ntfs_write_iomap_begin_non_resident(inode, offset, length, flags,
@@ -762,10 +774,10 @@ static int ntfs_write_iomap_end_resident(struct inode *inode, loff_t pos,
 					 loff_t length, ssize_t written,
 					 unsigned int flags, struct iomap *iomap)
 {
-	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *base_ni = iomap->private;
 
-	mark_mft_record_dirty(ni);
-	mutex_unlock(&ni->mrec_lock);
+	mark_mft_record_dirty(base_ni);
+	mutex_unlock(&base_ni->mrec_lock);
 	return written;
 }
 
diff --git a/fs/ntfs/named_stream.c b/fs/ntfs/named_stream.c
index 5c76cae66ed2..e44dbf09057b 100644
--- a/fs/ntfs/named_stream.c
+++ b/fs/ntfs/named_stream.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/file.h>
+#include <linux/namei.h>
 #include <linux/overflow.h>
 
 #include <uapi/linux/ntfs.h>
@@ -176,6 +177,598 @@ bool ntfs_stream_unlinked(struct ntfs_inode *base_ni,
 	return unlinked;
 }
 
+/*
+ * ntfs_stream_path_parse() - Split a pathname stream component
+ * @vol: NTFS volume
+ * @qname: final pathname component
+ * @path: receives slices of @qname on success
+ *
+ * Parse the ``file:stream`` form when the Windows pathname interface is
+ * enabled. This does not convert or validate the component names.
+ *
+ * Return: 1 if stream syntax was parsed, 0 if streams are disabled or no
+ * stream separator is present, or -EINVAL for malformed syntax.
+ */
+int ntfs_stream_path_parse(struct ntfs_volume *vol,
+		const struct qstr *qname, struct ntfs_stream_path *path)
+{
+	const unsigned char *colon;
+
+	if (!NVolStreamsWindows(vol))
+		return 0;
+
+	colon = memchr(qname->name, ':', qname->len);
+	if (!colon)
+		return 0;
+	if (colon == qname->name || colon + 1 == qname->name + qname->len)
+		return -EINVAL;
+	if (memchr(colon + 1, ':', qname->name + qname->len - colon - 1))
+		return -EINVAL;
+
+	path->base_name = (const char *)qname->name;
+	path->base_len = colon - qname->name;
+	path->stream_name = (const char *)colon + 1;
+	path->stream_len = qname->name + qname->len - colon - 1;
+	return 1;
+}
+
+/*
+ * ntfs_stream_path_has_colon() - Check for a pathname stream separator
+ * @vol: NTFS volume
+ * @qname: final pathname component
+ *
+ * Return: true if the Windows pathname interface is enabled and @qname
+ * contains a colon, or false otherwise.
+ */
+bool ntfs_stream_path_has_colon(struct ntfs_volume *vol,
+		const struct qstr *qname)
+{
+	return NVolStreamsWindows(vol) &&
+		memchr(qname->name, ':', qname->len);
+}
+
+/*
+ * ntfs_stream_path_check() - Reject stream syntax for unsupported operations
+ * @vol: NTFS volume
+ * @qname: final pathname component
+ *
+ * Return: 0 for an ordinary name or when streams are disabled,
+ * -EOPNOTSUPP for parsed stream syntax, or -EINVAL for malformed syntax.
+ */
+int ntfs_stream_path_check(struct ntfs_volume *vol,
+		const struct qstr *qname)
+{
+	struct ntfs_stream_path path;
+	int ret;
+
+	ret = ntfs_stream_path_parse(vol, qname, &path);
+	if (ret < 0)
+		return ret;
+	return ret ? -EOPNOTSUPP : 0;
+}
+
+/*
+ * ntfs_stream_lookup_inode_by_name() - Look up a base inode by name
+ * @dir_ino: directory containing the base file or directory
+ * @uname: UTF-16LE base name
+ * @uname_len: Length of @uname in UTF-16 code units
+ *
+ * Resolve the directory entry and verify its MFT reference before returning
+ * the inode.
+ *
+ * Return: Referenced inode on success, or ERR_PTR() on failure.
+ */
+struct inode *ntfs_stream_lookup_inode_by_name(struct inode *dir_ino,
+		__le16 *uname, int uname_len)
+{
+	struct ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
+	struct ntfs_name *name = NULL;
+	struct inode *inode;
+	u64 mref;
+
+	mutex_lock(&NTFS_I(dir_ino)->mrec_lock);
+	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len,
+			&name);
+	mutex_unlock(&NTFS_I(dir_ino)->mrec_lock);
+	kfree(name);
+
+	if (IS_ERR_MREF(mref))
+		return ERR_PTR(MREF_ERR(mref));
+
+	inode = ntfs_iget(vol->sb, MREF(mref));
+	if (IS_ERR(inode))
+		return inode;
+	if (MSEQNO(mref) != NTFS_I(inode)->seq_no &&
+	    MREF(mref) != FILE_MFT) {
+		iput(inode);
+		return ERR_PTR(-EIO);
+	}
+	return inode;
+}
+
+/*
+ * Recheck that a stream dentry still names the same base inode and DATA
+ * attribute.
+ */
+static int ntfs_stream_d_revalidate(struct inode *dir,
+		const struct qstr *qname, struct dentry *dentry,
+		unsigned int flags)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni;
+	struct ntfs_stream_path path;
+	struct inode *base_vi;
+	__le16 *base_name = NULL, *stream_name = NULL;
+	int base_len, stream_len, err, ret = 0;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+	if (!inode)
+		return 0;
+	if (!inode->i_nlink)
+		return 0;
+	if (NVolShutdown(NTFS_SB(dir->i_sb)))
+		return 0;
+
+	ni = NTFS_I(inode);
+	if (!ntfs_inode_is_named_stream(ni))
+		return 0;
+
+	err = ntfs_stream_path_parse(NTFS_SB(dir->i_sb), qname, &path);
+	if (err <= 0)
+		return 0;
+	base_len = ntfs_nlstoucs(NTFS_SB(dir->i_sb), path.base_name,
+			path.base_len, &base_name, NTFS_MAX_NAME_LEN);
+	if (base_len < 0)
+		goto out;
+	stream_len = ntfs_nlstoucs(NTFS_SB(dir->i_sb), path.stream_name,
+			path.stream_len, &stream_name, NTFS_MAX_NAME_LEN);
+	if (stream_len < 0)
+		goto out;
+	if (ntfs_check_stream_name(stream_name, stream_len))
+		goto out;
+	if (stream_len != ni->name_len ||
+	    !ntfs_names_are_equal(stream_name, stream_len, ni->name,
+			ni->name_len, IGNORE_CASE, ni->vol->upcase,
+			ni->vol->upcase_len))
+		goto out;
+
+	base_vi = ntfs_stream_lookup_inode_by_name(dir, base_name, base_len);
+	if (IS_ERR(base_vi))
+		goto out;
+	if (NTFS_I(base_vi) != ni->ext.base_ntfs_ino) {
+		iput(base_vi);
+		goto out;
+	}
+
+	mutex_lock(&NTFS_I(base_vi)->mrec_lock);
+	err = ntfs_stream_inode_validate(inode);
+	mutex_unlock(&NTFS_I(base_vi)->mrec_lock);
+	iput(base_vi);
+	if (!err)
+		ret = 1;
+out:
+	if (stream_name)
+		kmem_cache_free(ntfs_name_cache, stream_name);
+	if (base_name)
+		kmem_cache_free(ntfs_name_cache, base_name);
+	return ret;
+}
+
+/* Revalidate stream paths while leaving ordinary NTFS dentries cacheable. */
+static int ntfs_dentry_revalidate(struct inode *dir,
+		const struct qstr *qname, struct dentry *dentry,
+		unsigned int flags)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_volume *vol = NTFS_SB(dir->i_sb);
+
+	if (ntfs_stream_path_has_colon(vol, qname))
+		return ntfs_stream_d_revalidate(dir, qname, dentry, flags);
+	if (inode && ntfs_inode_is_named_stream(NTFS_I(inode)))
+		return 0;
+	return 1;
+}
+
+/* Drop stream-path aliases so future lookups recheck their backing attribute. */
+static int ntfs_dentry_delete(const struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_volume *vol = NTFS_SB(dentry->d_sb);
+
+	if (ntfs_stream_path_has_colon(vol, &dentry->d_name) ||
+	    (inode && ntfs_inode_is_named_stream(NTFS_I(inode))))
+		return always_delete_dentry(dentry);
+	return 0;
+}
+
+static const struct dentry_operations ntfs_dentry_ops = {
+	.d_revalidate	= ntfs_dentry_revalidate,
+	.d_delete		= ntfs_dentry_delete,
+};
+
+/*
+ * ntfs_set_default_dentry_ops() - Install stream-aware dentry operations
+ * @sb: superblock on which to install the operations
+ *
+ * Ensure pathname stream dentries are revalidated and not kept as stale
+ * aliases.
+ */
+void ntfs_set_default_dentry_ops(struct super_block *sb)
+{
+	set_default_d_op(sb, &ntfs_dentry_ops);
+}
+
+/*
+ * ntfs_lookup_stream() - Look up a named stream by pathname
+ * @dir_ino: directory containing the base file or directory
+ * @dent: dentry for the pathname component
+ * @path: parsed base and stream name slices
+ *
+ * Find the existing base inode and its named DATA attribute, then splice the
+ * stream inode into @dent.
+ *
+ * Return: NULL if @dent was instantiated, an alternate dentry if a
+ * disconnected alias was spliced, or ERR_PTR() on failure.
+ */
+struct dentry *ntfs_lookup_stream(struct inode *dir_ino,
+		struct dentry *dent, const struct ntfs_stream_path *path)
+{
+	struct ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
+	struct inode *base_vi, *stream_vi;
+	__le16 *base_uname = NULL, *stream_uname = NULL;
+	int base_len, stream_len, err;
+
+	if (NVolShutdown(vol))
+		return ERR_PTR(-EIO);
+
+	base_len = ntfs_nlstoucs(vol, path->base_name, path->base_len,
+			&base_uname, NTFS_MAX_NAME_LEN);
+	if (base_len < 0)
+		return ERR_PTR(base_len);
+
+	stream_len = ntfs_nlstoucs(vol, path->stream_name, path->stream_len,
+			&stream_uname, NTFS_MAX_NAME_LEN);
+	if (stream_len < 0) {
+		kmem_cache_free(ntfs_name_cache, base_uname);
+		return ERR_PTR(stream_len);
+	}
+	err = ntfs_check_stream_name(stream_uname, stream_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, base_uname);
+		kmem_cache_free(ntfs_name_cache, stream_uname);
+		return ERR_PTR(err);
+	}
+
+	base_vi = ntfs_stream_lookup_inode_by_name(dir_ino, base_uname,
+			base_len);
+	kmem_cache_free(ntfs_name_cache, base_uname);
+	if (IS_ERR(base_vi)) {
+		err = PTR_ERR(base_vi);
+		kmem_cache_free(ntfs_name_cache, stream_uname);
+		if (err == -ENOENT)
+			return d_splice_alias(NULL, dent);
+		return ERR_PTR(err);
+	}
+
+	if (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)) {
+		iput(base_vi);
+		kmem_cache_free(ntfs_name_cache, stream_uname);
+		return ERR_PTR(-ENOTDIR);
+	}
+
+	mutex_lock(&NTFS_I(base_vi)->mrec_lock);
+	stream_vi = ntfs_attr_iget(base_vi, AT_DATA, stream_uname, stream_len);
+	if (!IS_ERR(stream_vi)) {
+		if (NInoStreamUnlinked(NTFS_I(stream_vi)))
+			err = -ENOENT;
+		else
+			err = ntfs_stream_inode_validate(stream_vi);
+	}
+	mutex_unlock(&NTFS_I(base_vi)->mrec_lock);
+	if (!IS_ERR(stream_vi) && err) {
+		iput(stream_vi);
+		stream_vi = ERR_PTR(err);
+	}
+	iput(base_vi);
+	kmem_cache_free(ntfs_name_cache, stream_uname);
+
+	if (IS_ERR(stream_vi)) {
+		err = PTR_ERR(stream_vi);
+		if (err == -ENOENT || err == -ESTALE)
+			return d_splice_alias(NULL, dent);
+		return ERR_PTR(err);
+	}
+
+	return d_splice_alias(stream_vi, dent);
+}
+
+/*
+ * ntfs_stream_path_names() - Convert and validate pathname stream names
+ * @vol: NTFS volume
+ * @qname: final pathname component
+ * @base_name: receives the allocated UTF-16LE base name
+ * @base_len: receives the base name length in UTF-16 code units
+ * @stream_name: receives the allocated UTF-16LE stream name
+ * @stream_len: receives the stream name length in UTF-16 code units
+ *
+ * Return: 1 if stream names were produced, 0 if @qname has no stream syntax,
+ * or a negative errno. The caller owns both name buffers on success.
+ */
+int ntfs_stream_path_names(struct ntfs_volume *vol,
+		const struct qstr *qname, __le16 **base_name, int *base_len,
+		__le16 **stream_name, int *stream_len)
+{
+	struct ntfs_stream_path path;
+	int err;
+
+	*base_name = NULL;
+	*stream_name = NULL;
+	err = ntfs_stream_path_parse(vol, qname, &path);
+	if (err <= 0)
+		return err;
+
+	*base_len = ntfs_nlstoucs(vol, path.base_name, path.base_len,
+			base_name, NTFS_MAX_NAME_LEN);
+	if (*base_len < 0)
+		return *base_len;
+
+	*stream_len = ntfs_nlstoucs(vol, path.stream_name, path.stream_len,
+			stream_name, NTFS_MAX_NAME_LEN);
+	if (*stream_len < 0) {
+		kmem_cache_free(ntfs_name_cache, *base_name);
+		*base_name = NULL;
+		return *stream_len;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, *base_name, *base_len);
+	if (err)
+		goto out_free;
+	err = ntfs_check_stream_name(*stream_name, *stream_len);
+	if (err)
+		goto out_free;
+	err = ntfs_check_bad_windows_name(vol, *stream_name, *stream_len);
+	if (err)
+		goto out_free;
+	return 1;
+
+out_free:
+	kmem_cache_free(ntfs_name_cache, *stream_name);
+	kmem_cache_free(ntfs_name_cache, *base_name);
+	*stream_name = NULL;
+	*base_name = NULL;
+	return err;
+}
+
+/*
+ * ntfs_create_named_stream() - Create a named DATA stream
+ * @idmap: mount idmap used for permission checks
+ * @dir: directory containing the base object
+ * @base_name: UTF-16LE base name
+ * @base_len: length of @base_name in UTF-16 code units
+ * @stream_name: UTF-16LE stream name
+ * @stream_len: length of @stream_name in UTF-16 code units
+ *
+ * Create the stream on an existing regular file or directory.
+ *
+ * Return: Referenced stream inode on success, or ERR_PTR() on failure.
+ */
+struct inode *ntfs_create_named_stream(struct mnt_idmap *idmap,
+		struct inode *dir, __le16 *base_name, int base_len,
+		__le16 *stream_name, int stream_len)
+{
+	struct ntfs_inode *base_ni;
+	struct inode *base_vi, *stream_vi;
+	struct inode *rollback_vi = NULL;
+	struct ntfs_attr_search_ctx *ctx;
+	bool stream_created = false;
+	int err, rollback_err;
+
+	base_vi = ntfs_stream_lookup_inode_by_name(dir, base_name, base_len);
+	if (IS_ERR(base_vi))
+		return base_vi;
+	if (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)) {
+		iput(base_vi);
+		return ERR_PTR(-ENOTDIR);
+	}
+	err = inode_permission(idmap, base_vi, MAY_OPEN | MAY_WRITE);
+	if (err)
+		goto out_iput;
+	if (IS_APPEND(base_vi) || IS_IMMUTABLE(base_vi)) {
+		err = -EPERM;
+		goto out_iput;
+	}
+	if (!(NTFS_SB(base_vi->i_sb)->vol_flags & VOLUME_IS_DIRTY)) {
+		err = ntfs_set_volume_flags(NTFS_SB(base_vi->i_sb),
+				VOLUME_IS_DIRTY);
+		if (err)
+			goto out_iput;
+	}
+
+	base_ni = NTFS_I(base_vi);
+	mutex_lock(&base_ni->mrec_lock);
+	if (NVolShutdown(base_ni->vol)) {
+		err = -EIO;
+		goto out_unlock;
+	}
+	if (NInoBeingDeleted(base_ni) || !base_vi->i_nlink) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+	if (IS_APPEND(base_vi) || IS_IMMUTABLE(base_vi)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	err = ntfs_attr_lookup(AT_DATA, stream_name, stream_len,
+			IGNORE_CASE, 0, NULL, 0, ctx);
+	if (!err) {
+		if (ntfs_stream_unlinked(base_ni, stream_name, stream_len))
+			err = -EBUSY;
+		else
+			err = -EEXIST;
+	} else if (err == -ENOENT) {
+		if (NVolShutdown(base_ni->vol)) {
+			err = -EIO;
+			goto out_put_ctx;
+		}
+		err = ntfs_attr_add(base_ni, AT_DATA, stream_name, stream_len,
+				NULL, 0);
+		if (!err) {
+			stream_created = true;
+			mark_mft_record_dirty(base_ni);
+		}
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	if (err)
+		goto out_unlock;
+
+	stream_vi = ntfs_attr_iget(base_vi, AT_DATA, stream_name, stream_len);
+	if (!IS_ERR(stream_vi))
+		err = ntfs_stream_inode_validate(stream_vi);
+	else
+		err = PTR_ERR(stream_vi);
+	if (err) {
+		if (stream_created) {
+			rollback_err = ntfs_attr_remove(base_ni, AT_DATA,
+					stream_name, stream_len, &rollback_vi);
+			if (rollback_err) {
+				ntfs_error(base_ni->vol->sb,
+					"Failed to roll back named stream creation.\n");
+				if (rollback_err == -ENOMEM ||
+				    rollback_err == -EINTR ||
+				    rollback_err == -ERESTARTSYS) {
+					err = rollback_err;
+				} else {
+					NVolSetErrors(base_ni->vol);
+					NVolSetShutdown(base_ni->vol);
+					err = -EIO;
+				}
+			}
+		}
+		mutex_unlock(&base_ni->mrec_lock);
+		if (stream_created)
+			ntfs_stream_update_base_time(base_ni);
+		if (!IS_ERR(stream_vi))
+			iput(stream_vi);
+		if (rollback_vi)
+			iput(rollback_vi);
+		iput(base_vi);
+		return ERR_PTR(err);
+	}
+	mutex_unlock(&base_ni->mrec_lock);
+	if (stream_created)
+		ntfs_stream_update_base_time(base_ni);
+	iput(base_vi);
+	return stream_vi;
+
+out_put_ctx:
+	ntfs_attr_put_search_ctx(ctx);
+out_unlock:
+	mutex_unlock(&base_ni->mrec_lock);
+out_iput:
+	iput(base_vi);
+	return ERR_PTR(err);
+}
+
+/*
+ * ntfs_unlink_named_stream() - Remove a pathname named stream
+ * @dir: directory containing the base object
+ * @dentry: dentry for the named stream
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int ntfs_unlink_named_stream(struct inode *dir, struct dentry *dentry)
+{
+	struct ntfs_volume *vol = NTFS_SB(dir->i_sb);
+	struct inode *base_vi;
+	__le16 *base_name = NULL, *stream_name = NULL;
+	int base_len, stream_len, path_result, err;
+
+	path_result = ntfs_stream_path_names(vol, &dentry->d_name, &base_name,
+			&base_len, &stream_name, &stream_len);
+	if (path_result < 0)
+		return path_result;
+	if (!path_result)
+		return -EINVAL;
+
+	base_vi = ntfs_stream_lookup_inode_by_name(dir, base_name, base_len);
+	if (IS_ERR(base_vi)) {
+		err = PTR_ERR(base_vi);
+		goto out_free;
+	}
+	if (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)) {
+		err = -ENOTDIR;
+		goto out_iput;
+	}
+	if (!ntfs_inode_is_named_stream(NTFS_I(dentry->d_inode))) {
+		err = -ESTALE;
+		goto out_iput;
+	}
+	if (NTFS_I(dentry->d_inode)->ext.base_ntfs_ino != NTFS_I(base_vi)) {
+		err = -ESTALE;
+		goto out_iput;
+	}
+
+	/*
+	 * VFS authorizes pathname removal via the parent directory, not base
+	 * file write access. The shared helper enforces NTFS delete restrictions.
+	 */
+	err = ntfs_remove_named_stream(NTFS_I(base_vi), stream_name,
+			stream_len, dentry->d_inode);
+
+out_iput:
+	iput(base_vi);
+out_free:
+	kmem_cache_free(ntfs_name_cache, stream_name);
+	kmem_cache_free(ntfs_name_cache, base_name);
+	return err;
+}
+
+/* Obtain a dentry for the base inode behind a stream inode. */
+static struct dentry *ntfs_stream_base_dentry(struct inode *inode)
+{
+	struct inode *base_vi =
+		VFS_I(NTFS_I(inode)->ext.base_ntfs_ino);
+	struct dentry *dentry;
+
+	dentry = d_find_alias(base_vi);
+	if (dentry)
+		return dentry;
+	if (!igrab(base_vi))
+		return ERR_PTR(-ESTALE);
+	return d_obtain_alias(base_vi);
+}
+
+/*
+ * ntfs_stream_validate_for_mutation() - Validate a stream before mutation
+ * @inode: stream inode to validate
+ * @nowait: do not wait for the base MFT-record lock
+ *
+ * Return: 0 if the backing DATA attribute is valid, -EAGAIN if a nonblocking
+ * lock attempt fails, or another negative errno.
+ */
+int ntfs_stream_validate_for_mutation(struct inode *inode, bool nowait)
+{
+	struct ntfs_inode *base_ni = NTFS_I(inode)->ext.base_ntfs_ino;
+	int err;
+
+	if (nowait) {
+		if (!mutex_trylock(&base_ni->mrec_lock))
+			return -EAGAIN;
+	} else {
+		mutex_lock(&base_ni->mrec_lock);
+	}
+	err = ntfs_stream_inode_validate(inode);
+	mutex_unlock(&base_ni->mrec_lock);
+	return err;
+}
+
 /*
  * Hold a temporary stream reference so unlink cannot remove its attribute
  * while an operation is using it.
@@ -201,6 +794,213 @@ static int ntfs_stream_claim(struct inode *inode)
 	return err;
 }
 
+/* Stream permission checks use the base inode's permissions. */
+static int ntfs_stream_permission(struct mnt_idmap *idmap,
+		struct inode *inode, int mask)
+{
+	return inode_permission(idmap,
+			VFS_I(NTFS_I(inode)->ext.base_ntfs_ino), mask);
+}
+
+/* Report base metadata with the stream's own size and allocation. */
+static int ntfs_stream_getattr(struct mnt_idmap *idmap,
+		const struct path *path, struct kstat *stat,
+		unsigned int request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct inode *base_vi = VFS_I(ni->ext.base_ntfs_ino);
+
+	generic_fillattr(idmap, request_mask, base_vi, stat);
+	stat->size = i_size_read(inode);
+	stat->blocks = (((u64)ni->i_dealloc_clusters <<
+			NTFS_SB(inode->i_sb)->cluster_size_bits) >> 9) +
+			inode->i_blocks;
+	stat->blksize = NTFS_SB(inode->i_sb)->cluster_size;
+	stat->result_mask |= STATX_BTIME;
+	stat->btime = NTFS_I(base_vi)->i_crtime;
+
+	if (NInoCompressed(ni))
+		stat->attributes |= STATX_ATTR_COMPRESSED;
+	if (NInoEncrypted(ni))
+		stat->attributes |= STATX_ATTR_ENCRYPTED;
+	if (base_vi->i_flags & S_IMMUTABLE)
+		stat->attributes |= STATX_ATTR_IMMUTABLE;
+	if (base_vi->i_flags & S_APPEND)
+		stat->attributes |= STATX_ATTR_APPEND;
+	stat->attributes_mask |= STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED |
+			STATX_ATTR_IMMUTABLE | STATX_ATTR_APPEND;
+	stat->mode = (stat->mode & ~S_IFMT) | S_IFREG;
+
+	if (request_mask & STATX_DIOALIGN) {
+		unsigned int align =
+			bdev_logical_block_size(inode->i_sb->s_bdev);
+
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!NInoCompressed(ni) && !NInoEncrypted(ni)) {
+			stat->dio_mem_align = align;
+			stat->dio_offset_align = align;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Apply size changes to the stream and route shared inode metadata changes to
+ * its base inode.
+ */
+static int ntfs_stream_setattr_common(struct mnt_idmap *idmap,
+		struct inode *inode, struct iattr *attr)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct inode *base_vi = VFS_I(ni->ext.base_ntfs_ino);
+	struct dentry *base_dentry = NULL;
+	struct iattr base_attr = *attr;
+	int err;
+
+	base_attr.ia_valid &= ~ATTR_FILE;
+	base_attr.ia_file = NULL;
+	if (base_attr.ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
+		base_attr.ia_valid &= ~ATTR_MODE;
+	else if (base_attr.ia_valid & ATTR_MODE)
+		base_attr.ia_mode = (base_attr.ia_mode & ~S_IFMT) |
+				(base_vi->i_mode & S_IFMT);
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		err = inode_permission(idmap, base_vi, MAY_WRITE);
+		if (err)
+			goto out;
+		if (IS_APPEND(base_vi) || IS_IMMUTABLE(base_vi)) {
+			err = -EPERM;
+			goto out;
+		}
+		if (!(ni->vol->vol_flags & VOLUME_IS_DIRTY)) {
+			err = ntfs_set_volume_flags(ni->vol, VOLUME_IS_DIRTY);
+			if (err)
+				goto out;
+		}
+		base_attr.ia_valid &= ~ATTR_SIZE;
+	}
+
+	if ((attr->ia_valid & ATTR_SIZE) || base_attr.ia_valid) {
+		base_dentry = ntfs_stream_base_dentry(inode);
+		if (IS_ERR(base_dentry)) {
+			err = PTR_ERR(base_dentry);
+			base_dentry = NULL;
+			goto out;
+		}
+		inode_lock_nested(base_vi, I_MUTEX_PARENT);
+		err = ntfs_stream_validate_for_mutation(inode, false);
+		if (err) {
+			inode_unlock(base_vi);
+			goto out;
+		}
+		if (base_attr.ia_valid)
+			err = notify_change(idmap, base_dentry, &base_attr,
+					NULL);
+		else
+			err = 0;
+		if (!err)
+			ntfs_stream_inode_refresh(inode);
+		inode_unlock(base_vi);
+		if (err)
+			goto out;
+	}
+
+	if (attr->ia_valid & ATTR_SIZE)
+		err = ntfs_setattr_size(inode, attr);
+	else
+		err = 0;
+out:
+	dput(base_dentry);
+	return err;
+}
+
+/* Hold the stream against unlink while applying VFS setattr operations. */
+static int ntfs_stream_setattr(struct mnt_idmap *idmap,
+		struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	bool claimed = false;
+	int err;
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
+	if (!(attr->ia_valid & ATTR_FILE)) {
+		err = ntfs_stream_claim(inode);
+		if (err)
+			return err;
+		claimed = true;
+	}
+
+	err = ntfs_stream_setattr_common(idmap, inode, attr);
+	if (claimed)
+		ntfs_stream_put(inode);
+	return err;
+}
+
+/*
+ * Apply stream timestamp updates to the base inode after validating the
+ * backing attribute under its MFT-record lock. Nonblocking callers get
+ * -EAGAIN.
+ */
+static int ntfs_stream_update_time_common(struct inode *inode,
+		enum fs_update_time type, unsigned int flags)
+{
+	struct ntfs_inode *base_ni = NTFS_I(inode)->ext.base_ntfs_ino;
+	struct inode *base_vi = VFS_I(base_ni);
+	int err;
+
+	if (NVolShutdown(base_ni->vol))
+		return -EIO;
+	if (flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	mutex_lock(&base_ni->mrec_lock);
+	if (NVolShutdown(base_ni->vol)) {
+		err = -EIO;
+		goto out_mrec;
+	}
+	err = ntfs_stream_inode_validate(inode);
+	if (!err) {
+		err = generic_update_time(base_vi, type, flags);
+		if (!err)
+			ntfs_stream_inode_refresh(inode);
+	}
+out_mrec:
+	mutex_unlock(&base_ni->mrec_lock);
+	return err;
+}
+
+static int ntfs_stream_update_time(struct inode *inode,
+		enum fs_update_time type, unsigned int flags)
+{
+	return ntfs_stream_update_time_common(inode, type, flags);
+}
+
+static ssize_t ntfs_stream_listxattr(struct dentry *dentry, char *buffer,
+		size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+#ifdef CONFIG_NTFS_FS_POSIX_ACL
+static struct posix_acl *ntfs_stream_get_acl(struct mnt_idmap *idmap,
+		struct dentry *dentry, int type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static int ntfs_stream_set_acl(struct mnt_idmap *idmap,
+		struct dentry *dentry, struct posix_acl *acl, int type)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * Remove an unlinked stream's DATA attribute after its final active reference
  * is released. Base-inode deletion handles the attribute when the base is
@@ -335,8 +1135,9 @@ int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
 	clear_nlink(attr_vi);
 	mutex_unlock(&ni->mrec_lock);
 
-	ntfs_stream_update_base_time(ni);
 	err = ntfs_stream_finish_remove(attr_vi);
+	if (!err)
+		ntfs_stream_update_base_time(ni);
 	iput(attr_vi);
 	return err;
 
@@ -349,6 +1150,80 @@ int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
 	return err;
 }
 
+/*
+ * Validate access against the base inode and hold the stream against unlink
+ * until the file is released.
+ */
+static int ntfs_stream_file_open(struct inode *inode, struct file *file)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
+	struct inode *base_vi = VFS_I(base_ni);
+	int mask = MAY_OPEN;
+	int err;
+
+	if (file->f_mode & FMODE_READ)
+		mask |= MAY_READ;
+	if (file->f_mode & FMODE_WRITE)
+		mask |= MAY_WRITE;
+	err = inode_permission(file_mnt_idmap(file), base_vi, mask);
+	if (err)
+		return err;
+
+	mutex_lock(&base_ni->mrec_lock);
+	if (NInoStreamUnlinked(ni))
+		err = -ENOENT;
+	else
+		err = ntfs_stream_inode_validate(inode);
+	if (err)
+		goto out_unlock;
+	if ((file->f_mode & FMODE_WRITE) &&
+	    (IS_IMMUTABLE(base_vi) ||
+	     (IS_APPEND(base_vi) && !(file->f_flags & O_APPEND)))) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if ((file->f_flags & O_TRUNC) && IS_APPEND(base_vi)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if ((file->f_flags & O_NOATIME) &&
+	    !inode_owner_or_capable(file_mnt_idmap(file), base_vi)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	err = ntfs_file_open(inode, file);
+	if (err)
+		goto out_unlock;
+	if (file->f_mode & FMODE_WRITE) {
+		err = get_write_access(base_vi);
+		if (err)
+			goto out_unlock;
+		file->private_data = base_vi;
+	}
+
+	atomic_inc(&ni->stream_open_count);
+out_unlock:
+	mutex_unlock(&base_ni->mrec_lock);
+	return err;
+}
+
+/* Drop open-time references and complete any deferred stream unlink. */
+static int ntfs_stream_file_release(struct inode *inode, struct file *file)
+{
+	int err, remove_err;
+
+	err = ntfs_file_release(inode, file);
+	if (file->private_data) {
+		put_write_access(file->private_data);
+		file->private_data = NULL;
+	}
+	remove_err = ntfs_stream_put(inode);
+	if (!err)
+		err = remove_err;
+	return err;
+}
+
 enum ntfs_stream_ioctl_op {
 	NTFS_STREAM_IOCTL_READ,
 	NTFS_STREAM_IOCTL_WRITE,
@@ -618,6 +1493,9 @@ static long ntfs_ioctl_stream(struct file *filp, unsigned long arg,
 			file_accessed(filp);
 	} else {
 		inode_lock(stream_vi);
+		inode_dio_wait(stream_vi);
+		/* Exclude faults before taking MFT record and folio locks. */
+		filemap_invalidate_lock(stream_vi->i_mapping);
 		err = inode_newsize_ok(stream_vi, pos + data_size);
 		if (!err) {
 			ret = ntfs_inode_attr_pwrite(stream_vi, pos, data_size,
@@ -627,6 +1505,7 @@ static long ntfs_ioctl_stream(struct file *filp, unsigned long arg,
 			else
 				req->bytes_returned = ret;
 		}
+		filemap_invalidate_unlock(stream_vi->i_mapping);
 		inode_unlock(stream_vi);
 	}
 	if (claimed) {
@@ -914,3 +1793,29 @@ int ntfs_ioctl_list_streams(struct file *filp, unsigned long arg)
 	kvfree(kbuf);
 	return ret;
 }
+
+const struct file_operations ntfs_stream_file_ops = {
+	.llseek		= ntfs_file_llseek,
+	.read_iter	= ntfs_file_read_iter,
+	.write_iter	= ntfs_file_write_iter,
+	.fsync		= ntfs_file_fsync,
+	.fallocate	= ntfs_fallocate,
+	.mmap_prepare	= ntfs_file_mmap_prepare,
+	.open		= ntfs_stream_file_open,
+	.release	= ntfs_stream_file_release,
+	.splice_read	= ntfs_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+};
+
+const struct inode_operations ntfs_stream_inode_ops = {
+	.permission	= ntfs_stream_permission,
+	.setattr	= ntfs_stream_setattr,
+	.getattr	= ntfs_stream_getattr,
+	.listxattr	= ntfs_stream_listxattr,
+#ifdef CONFIG_NTFS_FS_POSIX_ACL
+	.get_acl	= ntfs_stream_get_acl,
+	.set_acl	= ntfs_stream_set_acl,
+#endif
+	.update_time	= ntfs_stream_update_time,
+	.fiemap		= ntfs_fiemap,
+};
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 3cf58befd77f..9251951a76fb 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -8,6 +8,7 @@
 
 #include <linux/exportfs.h>
 #include <linux/iversion.h>
+#include <linux/namei.h>
 
 #include "ntfs.h"
 #include "time.h"
@@ -15,6 +16,7 @@
 #include "reparse.h"
 #include "object_id.h"
 #include "ea.h"
+#include "stream.h"
 
 static const __le16 aux_name_le[3] = {
 	cpu_to_le16('A'), cpu_to_le16('U'), cpu_to_le16('X')
@@ -57,7 +59,18 @@ static inline int ntfs_check_bad_char(const __le16 *wc, unsigned int wc_len)
 	return 0;
 }
 
-static int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
+/*
+ * ntfs_check_bad_windows_name() - Validate a name against Windows rules
+ * @vol: NTFS volume
+ * @wc: UTF-16LE name
+ * @wc_len: length of @wc in UTF-16 code units
+ *
+ * When Windows-name checks are enabled, reject disallowed characters,
+ * trailing spaces or dots, and reserved DOS device names.
+ *
+ * Return: 0 if valid, or -EINVAL otherwise.
+ */
+int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
 				       const __le16 *wc,
 				       unsigned int wc_len)
 {
@@ -167,19 +180,29 @@ static int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
  *
  * Locking: Caller must hold i_mutex on the directory.
  */
+
 static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		unsigned int flags)
 {
 	struct ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
+	struct ntfs_stream_path stream_path;
 	struct inode *dent_inode;
 	__le16 *uname;
 	struct ntfs_name *name = NULL;
 	u64 mref;
 	unsigned long dent_ino;
 	int uname_len;
+	int stream_path_len;
 
 	ntfs_debug("Looking up %pd in directory inode 0x%llx.",
 			dent, NTFS_I(dir_ino)->mft_no);
+	stream_path_len = ntfs_stream_path_parse(vol, &dent->d_name,
+			&stream_path);
+	if (stream_path_len < 0)
+		return ERR_PTR(stream_path_len);
+	if (stream_path_len)
+		return ntfs_lookup_stream(dir_ino, dent, &stream_path);
+
 	/* Convert the name of the dentry to Unicode. */
 	uname_len = ntfs_nlstoucs(vol, dent->d_name.name, dent->d_name.len,
 				  &uname, NTFS_MAX_NAME_LEN);
@@ -405,6 +428,7 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 	struct inode *vi;
 	struct mft_record *ni_mrec, *dni_mrec;
 	struct super_block *sb = dir_ni->vol->sb;
+	struct inode *rollback_data_vi = NULL, *rollback_sd_vi = NULL;
 	__le64 parent_mft_ref;
 	u64 child_mft_ref;
 	__le16 ea_size;
@@ -694,11 +718,25 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 	return ni;
 
 err_out:
-	if (rollback_sd)
-		ntfs_attr_remove(ni, AT_SECURITY_DESCRIPTOR, AT_UNNAMED, 0);
+	if (rollback_sd) {
+		int rollback_err;
 
-	if (rollback_data)
-		ntfs_attr_remove(ni, AT_DATA, AT_UNNAMED, 0);
+		rollback_err = ntfs_attr_remove(ni,
+				AT_SECURITY_DESCRIPTOR, AT_UNNAMED, 0,
+				&rollback_sd_vi);
+		if (rollback_err)
+			ntfs_error(sb,
+				"Failed to roll back security descriptor.\n");
+	}
+
+	if (rollback_data) {
+		int rollback_err;
+
+		rollback_err = ntfs_attr_remove(ni, AT_DATA, AT_UNNAMED,
+				0, &rollback_data_vi);
+		if (rollback_err)
+			ntfs_error(sb, "Failed to roll back DATA attribute.\n");
+	}
 
 	if (rollback_reparse)
 		ntfs_delete_reparse_index(ni);
@@ -726,6 +764,10 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 	mutex_unlock(&dir_ni->mrec_lock);
 	mutex_unlock(&ni->mrec_lock);
 
+	if (rollback_data_vi)
+		iput(rollback_data_vi);
+	if (rollback_sd_vi)
+		iput(rollback_sd_vi);
 	remove_inode_hash(vi);
 	discard_new_inode(vi);
 	return ERR_PTR(err);
@@ -736,12 +778,35 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct ntfs_volume *vol = NTFS_SB(dir->i_sb);
 	struct ntfs_inode *ni;
-	__le16 *uname;
-	int uname_len, err;
+	struct inode *stream_vi = NULL;
+	__le16 *uname, *base_name = NULL, *stream_name = NULL;
+	int uname_len, stream_len, path_result, err;
 
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	path_result = ntfs_stream_path_names(vol, &dentry->d_name, &base_name,
+			&uname_len, &stream_name, &stream_len);
+	if (path_result) {
+		if (path_result < 0)
+			return path_result;
+		stream_vi = ntfs_create_named_stream(idmap, dir, base_name,
+				uname_len, stream_name, stream_len);
+		if (IS_ERR(stream_vi)) {
+			err = PTR_ERR(stream_vi);
+			goto out_free_stream_names;
+		}
+		kmem_cache_free(ntfs_name_cache, stream_name);
+		kmem_cache_free(ntfs_name_cache, base_name);
+		d_instantiate(dentry, stream_vi);
+		return 0;
+
+out_free_stream_names:
+		kmem_cache_free(ntfs_name_cache, stream_name);
+		kmem_cache_free(ntfs_name_cache, base_name);
+		return err;
+	}
+
 	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
 				  &uname, NTFS_MAX_NAME_LEN);
 	if (uname_len < 0) {
@@ -758,7 +823,8 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 
 	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
-	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0, NULL, 0);
+	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0,
+			NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
 	if (IS_ERR(ni))
 		return PTR_ERR(ni);
@@ -850,10 +916,10 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	struct file_name_attr *fn = NULL;
 	bool looking_for_dos_name = false, looking_for_win32_name = false;
 	bool case_sensitive_match = true;
+	bool link_count_zero = false;
 	int err = 0;
 	struct mft_record *ni_mrec;
 	struct super_block *sb;
-	bool link_count_zero = false;
 
 	ntfs_debug("Entering.\n");
 
@@ -1025,6 +1091,11 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	if (ntfs_stream_path_has_colon(vol, &dentry->d_name))
+		return ntfs_unlink_named_stream(dir, dentry);
+	if (NInoAttr(ni))
+		return -EOPNOTSUPP;
+
 	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
 				  &uname, NTFS_MAX_NAME_LEN);
 	if (uname_len < 0) {
@@ -1068,6 +1139,10 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (NVolShutdown(vol))
 		return ERR_PTR(-EIO);
 
+	err = ntfs_stream_path_check(vol, &dentry->d_name);
+	if (err)
+		return ERR_PTR(err);
+
 	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
 				  &uname, NTFS_MAX_NAME_LEN);
 	if (uname_len < 0) {
@@ -1084,7 +1159,8 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
-	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL, 0);
+	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0,
+			NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
 	if (IS_ERR(ni)) {
 		err = PTR_ERR(ni);
@@ -1108,6 +1184,10 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	err = ntfs_stream_path_check(vol, &dentry->d_name);
+	if (err)
+		return err;
+
 	ni = NTFS_I(vi);
 	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
 				  &uname, NTFS_MAX_NAME_LEN);
@@ -1272,6 +1352,13 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (NVolShutdown(old_dir_ni->vol))
 		return -EIO;
 
+	err = ntfs_stream_path_check(vol, &old_dentry->d_name);
+	if (err)
+		return err;
+	err = ntfs_stream_path_check(vol, &new_dentry->d_name);
+	if (err)
+		return err;
+
 	if (flags & (RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
@@ -1419,6 +1506,10 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	err = ntfs_stream_path_check(vol, &dentry->d_name);
+	if (err)
+		return err;
+
 	usrc_len = ntfs_nlstoucs(vol, dentry->d_name.name,
 				 dentry->d_name.len, &usrc, NTFS_MAX_NAME_LEN);
 	if (usrc_len < 0) {
@@ -1464,6 +1555,10 @@ static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	err = ntfs_stream_path_check(vol, &dentry->d_name);
+	if (err)
+		return err;
+
 	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name,
 			dentry->d_name.len, &uname, NTFS_MAX_NAME_LEN);
 	if (uname_len < 0) {
@@ -1516,6 +1611,13 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	if (NInoAttr(ni))
+		return -EOPNOTSUPP;
+
+	err = ntfs_stream_path_check(vol, &dentry->d_name);
+	if (err)
+		return err;
+
 	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name,
 			dentry->d_name.len, &uname, NTFS_MAX_NAME_LEN);
 	if (uname_len < 0) {
@@ -1669,11 +1771,19 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
 				    ntfs_nfs_get_inode);
 }
 
+static int ntfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+		struct inode *parent)
+{
+	if (ntfs_inode_is_named_stream(NTFS_I(inode)))
+		return -EOPNOTSUPP;
+	return generic_encode_ino32_fh(inode, fh, max_len, parent);
+}
+
 /*
  * Export operations allowing NFS exporting of mounted NTFS partitions.
  */
 const struct export_operations ntfs_export_ops = {
-	.encode_fh = generic_encode_ino32_fh,
+	.encode_fh	= ntfs_encode_fh,
 	.get_parent	= ntfs_get_parent,	/* Find the parent of a given directory. */
 	.fh_to_dentry	= ntfs_fh_to_dentry,
 	.fh_to_parent	= ntfs_fh_to_parent,
diff --git a/fs/ntfs/stream.h b/fs/ntfs/stream.h
index da0096d2b751..5cbf6e8f6b68 100644
--- a/fs/ntfs/stream.h
+++ b/fs/ntfs/stream.h
@@ -7,8 +7,38 @@
 struct ntfs_inode;
 struct ntfs_volume;
 
+struct ntfs_stream_path {
+	const char *base_name;
+	unsigned int base_len;
+	const char *stream_name;
+	unsigned int stream_len;
+};
+
+int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
+		const __le16 *name, unsigned int name_len);
 int ntfs_check_stream_name(const __le16 *name, unsigned int name_len);
 
+int ntfs_stream_path_parse(struct ntfs_volume *vol,
+		const struct qstr *qname, struct ntfs_stream_path *path);
+bool ntfs_stream_path_has_colon(struct ntfs_volume *vol,
+		const struct qstr *qname);
+int ntfs_stream_path_check(struct ntfs_volume *vol,
+		const struct qstr *qname);
+int ntfs_stream_path_names(struct ntfs_volume *vol,
+		const struct qstr *qname, __le16 **base_name, int *base_len,
+		__le16 **stream_name, int *stream_len);
+
+struct inode *ntfs_stream_lookup_inode_by_name(struct inode *dir,
+		__le16 *name, int name_len);
+struct dentry *ntfs_lookup_stream(struct inode *dir, struct dentry *dentry,
+		const struct ntfs_stream_path *path);
+struct inode *ntfs_create_named_stream(struct mnt_idmap *idmap,
+		struct inode *dir, __le16 *base_name, int base_len,
+		__le16 *stream_name, int stream_len);
+int ntfs_unlink_named_stream(struct inode *dir, struct dentry *dentry);
+
+void ntfs_set_default_dentry_ops(struct super_block *sb);
+
 void ntfs_stream_inode_refresh(struct inode *inode);
 int ntfs_stream_inode_validate(struct inode *inode);
 void ntfs_stream_update_base_time(struct ntfs_inode *base_ni);
@@ -18,11 +48,19 @@ int ntfs_stream_put(struct inode *inode);
 int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *name,
 		u32 name_len, struct inode *expected_inode);
 
+int ntfs_stream_validate_for_mutation(struct inode *inode, bool nowait);
 long ntfs_ioctl_stream_read(struct file *file, unsigned long arg);
 long ntfs_ioctl_stream_write(struct file *file, unsigned long arg);
 long ntfs_ioctl_stream_remove(struct file *file, unsigned long arg);
 int ntfs_ioctl_list_streams(struct file *file, unsigned long arg);
 
+extern const struct file_operations ntfs_stream_file_ops;
+extern const struct inode_operations ntfs_stream_inode_ops;
+
+/*
+ * Common file operations used by both ordinary files and named streams.
+ * Their implementations remain in file.c.
+ */
 int ntfs_file_open(struct inode *inode, struct file *file);
 int ntfs_file_release(struct inode *inode, struct file *file);
 int ntfs_file_fsync(struct file *file, loff_t start, loff_t end,
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index d174867b9f5f..242fb19ced2b 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -23,6 +23,7 @@
 #include "ea.h"
 #include "bitmap.h"
 #include "volume.h"
+#include "stream.h"
 
 /* A global default upcase table and a corresponding reference count. */
 static __le16 *default_upcase;
@@ -67,6 +68,17 @@ static const struct constant_table ntfs_symlink_enums[] = {
 	{}
 };
 
+enum {
+	STREAMS_INTERFACE_NONE,
+	STREAMS_INTERFACE_WINDOWS,
+};
+
+static const struct constant_table ntfs_streams_interface_enums[] = {
+	{ "none",	STREAMS_INTERFACE_NONE },
+	{ "windows",	STREAMS_INTERFACE_WINDOWS },
+	{}
+};
+
 enum {
 	Opt_uid,
 	Opt_gid,
@@ -92,6 +104,7 @@ enum {
 	Opt_nocase,
 	Opt_native_symlink,
 	Opt_symlink,
+	Opt_streams_interface,
 };
 
 static const struct fs_parameter_spec ntfs_parameters[] = {
@@ -119,6 +132,8 @@ static const struct fs_parameter_spec ntfs_parameters[] = {
 	fsparam_flag("nocase",			Opt_nocase),
 	fsparam_enum("native_symlink",		Opt_native_symlink, ntfs_native_symlink_enums),
 	fsparam_enum("symlink",			Opt_symlink, ntfs_symlink_enums),
+	fsparam_enum("streams_interface",	Opt_streams_interface,
+		     ntfs_streams_interface_enums),
 	{}
 };
 
@@ -255,6 +270,22 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		else
 			NVolClearSymlinkNative(vol);
 		break;
+	case Opt_streams_interface: {
+		bool streams_windows =
+			result.uint_32 == STREAMS_INTERFACE_WINDOWS;
+
+		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE &&
+		    NVolStreamsWindows(vol) != streams_windows) {
+			ntfs_error(vol->sb,
+				   "Cannot change streams_interface on remount.");
+			return -EINVAL;
+		}
+		if (streams_windows)
+			NVolSetStreamsWindows(vol);
+		else
+			NVolClearStreamsWindows(vol);
+		break;
+	}
 	case Opt_sparse:
 		break;
 	default:
@@ -2725,6 +2756,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * operations and associated address space operations to function.
 	 */
 	sb->s_op = &ntfs_sops;
+	if (NVolStreamsWindows(vol))
+		ntfs_set_default_dentry_ops(sb);
 	tmp_ino = new_inode(sb);
 	if (!tmp_ino) {
 		if (!silent)
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index 6d9d6eb79a7c..ed5c0ccb9cd9 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -197,6 +197,7 @@ struct ntfs_volume {
  * NV_DisableSparse		Disable creation of sparse regions.
  * NV_NativeSymlinkRel		Translate absolute Windows reparse targets (native_symlink=rel).
  * NV_MftBootstrap		Mount is still assembling $MFT's own runlist.
+ * NV_StreamsWindows		Interpret the final path component as file:stream.
  */
 enum {
 	NV_Errors,
@@ -218,6 +219,7 @@ enum {
 	NV_NativeSymlinkRel,
 	NV_SymlinkNative,
 	NV_MftBootstrap,
+	NV_StreamsWindows,
 };
 
 /*
@@ -258,6 +260,7 @@ DEFINE_NVOL_BIT_OPS(DisableSparse)
 DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
 DEFINE_NVOL_BIT_OPS(SymlinkNative)
 DEFINE_NVOL_BIT_OPS(MftBootstrap)
+DEFINE_NVOL_BIT_OPS(StreamsWindows)
 
 static inline void ntfs_inc_free_clusters(struct ntfs_volume *vol, s64 nr)
 {
diff --git a/fs/ntfs/wof.c b/fs/ntfs/wof.c
index 9847259e5b1a..294dbe5d711f 100644
--- a/fs/ntfs/wof.c
+++ b/fs/ntfs/wof.c
@@ -311,7 +311,8 @@ static int parse_wof_chunk_table(struct ntfs_inode *base_ni,
 			goto out_unlock_mrec;
 		}
 		ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				       CASE_SENSITIVE, 0, NULL, 0, ctx);
+				       CASE_SENSITIVE,
+				       0, NULL, 0, ctx);
 		if (ret)
 			goto out_put_ctx;
 
@@ -399,7 +400,8 @@ static int ntfs_read_wof_chunk(struct ntfs_volume *vol,
 	}
 
 	err = ntfs_attr_lookup(wof_ni->type, wof_ni->name, wof_ni->name_len,
-			       CASE_SENSITIVE, 0, NULL, 0, ctx);
+			       CASE_SENSITIVE,
+			       0, NULL, 0, ctx);
 	if (err)
 		goto out_put_ctx;
 
-- 
2.25.1

