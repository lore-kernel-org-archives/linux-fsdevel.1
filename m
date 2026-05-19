Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA32F7EF5;
	Tue, 19 May 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229812; cv=none; b=rz9qxyw59VVfNdkh3hscRGyaDU/fSHrW2E0o8jX6Em/m55KvGGuSsje+9Acjp3R21aFVYlZTZ69aMEfjFfyaBxK35QjD5Z5j02eBl6jwIvFh++1kmRY8027mEZ+rUIIslNirv9eZcr64Z7WNLDYosqnWoo6v13wFuY4bcqfNzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229812; c=relaxed/simple;
	bh=Cm3KFiQTgUnPUBUBpJlc4Y+AJ7gEHsTrbLyArOvpIwI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAmKtPTPii/UuJHrNNA2uD2DTK3dW7ffC4vjPwddbM/k+RsXHwGjwp41Qk/K3E9B/6dv9R/clOaOVhQRqpWVi88NnwFklEMZXz/swe0AE51Mp3jux9ARq1p7CvDb9eqidPNXIyh5ve6BMBZDtWadav9HgLW2tu5h6NoXKSeW3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi06EI6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi06EI6k"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AB9271F000E9;
	Tue, 19 May 2026 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229809;
	bh=MJ1Pwtn/Xd7ecFQ7z3GGHYRwZUCySf5bUABsc229P8o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=oi06EI6kjPXDwenlkZeitfuAxF+DPfnp71lX8rSQYEmSVD1mUSN+ulARhz02eqkY6
	 da/mwabxGB++lfy+fv2XJuBlp5QjS4h8WWnOIjdSwNWE2bF/aq4NK5zbz9D54bIgqT
	 nV+93yoaiuzq9IHbCvefKyK/kyLpbZllp8aGwGynqT5zsYkzTyleKK75hGlpWTUy0i
	 2rrijiOTSxQ/+PJmhZIrm6hC6VczRKKgbrNLppxEvsqIORNamX14TCSApRVeP+Fgt1
	 IsolvxH+RFjLu/UMMNaKCDvD2STBHTszsbh1OOcgknk+q28KPIjlxaYo8khSOh6f9n
	 yKVBF5kS1NwJA==
Date: Tue, 19 May 2026 15:30:09 -0700
Subject: [PATCH 3/6] fuse: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945806.2437300.8770832813886142318.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
References: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement pagecache IO with iomap, complete with hooks into truncate and
fallocate so that the fuse server needn't implement disk block zeroing
of post-EOF and unaligned punch/zero regions.  As a result, the kernel
only needs to upcall the fuse server to find out where to direct its
file IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    7 
 fs/fuse/fuse_iomap.h      |   13 +
 include/uapi/linux/fuse.h |    2 
 fs/fuse/dev.c             |   10 +
 fs/fuse/dir.c             |   23 +
 fs/fuse/file.c            |   62 +++-
 fs/fuse/fuse_iomap.c      |  704 ++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 790 insertions(+), 31 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5b219ce8a6c918..31193345f709b5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -194,6 +194,11 @@ struct fuse_inode {
 #ifdef CONFIG_FUSE_IOMAP
 			/* file size as reported by fuse server */
 			loff_t i_disk_size;
+
+			/* pending io completions */
+			spinlock_t ioend_lock;
+			struct work_struct ioend_work;
+			struct list_head ioend_list;
 #endif
 		};
 
@@ -1741,4 +1746,6 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+sector_t fuse_bmap(struct address_space *mapping, sector_t block);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index a7c30ebd46dda7..714ab728066631 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -51,6 +51,14 @@ int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
 
 ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from);
+
+int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
+int fuse_iomap_setsize_start(struct inode *inode, loff_t newsize);
+int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
+			 loff_t length, loff_t new_size);
+int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
+				 loff_t endpos);
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -68,6 +76,11 @@ ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from);
 # define fuse_iomap_setsize_finish(...)		(-ENOSYS)
 # define fuse_iomap_read_iter(...)		(-ENOSYS)
 # define fuse_iomap_write_iter(...)		(-ENOSYS)
+# define fuse_iomap_mmap(...)			(-ENOSYS)
+# define fuse_iomap_setsize_start(...)		(-ENOSYS)
+# define fuse_iomap_fallocate(...)		(-ENOSYS)
+# define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_fadvise			NULL
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index ad977782eef231..1f1f9392a441f5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1441,6 +1441,8 @@ struct fuse_iomap_end_in {
 #define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
 /* is append ioend */
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+/* is pagecache writeback */
+#define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
 
 struct fuse_iomap_ioend_in {
 	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2708e17bc46949..d21eebbe12d4c9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -9,6 +9,7 @@
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -1794,6 +1795,12 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	if (!inode)
 		goto out_up_killsb;
 
+	/* no backchannels for messing with the pagecache */
+	if (fuse_inode_has_iomap(inode)) {
+		err = -EOPNOTSUPP;
+		goto out_iput;
+	}
+
 	mapping = inode->i_mapping;
 	file_size = i_size_read(inode);
 	end = pos + num;
@@ -1873,6 +1880,9 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	struct fuse_args *args;
 	loff_t pos = outarg->offset;
 
+	if (fuse_inode_has_iomap(inode))
+		return -EOPNOTSUPP;
+
 	offset = offset_in_page(pos);
 	file_size = i_size_read(inode);
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 9daac6af7d3a22..30fcb1492dda18 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2232,7 +2232,10 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (is_iomap && is_truncate) {
+		filemap_invalidate_lock(mapping);
+		fault_blocked = true;
+	} else if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
@@ -2247,6 +2250,18 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
 		WARN_ON(attr->ia_size != 0);
 		if (fc->atomic_o_trunc) {
+			if (is_iomap) {
+				/*
+				 * fuse_open already set the size to zero and
+				 * truncated the pagecache, and we've since
+				 * cycled the inode locks.  Another thread
+				 * could have performed an appending write, so
+				 * we don't want to touch the file further.
+				 */
+				filemap_invalidate_unlock(mapping);
+				return 0;
+			}
+
 			/*
 			 * No need to send request to userspace, since actual
 			 * truncation has already been done by OPEN.  But still
@@ -2280,6 +2295,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
+
+		if (is_iomap) {
+			err = fuse_iomap_setsize_start(inode, attr->ia_size);
+			if (err)
+				goto error;
+		}
 	}
 
 	memset(&inarg, 0, sizeof(inarg));
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 279a5229a51a9e..e8e264121e480e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -412,7 +412,7 @@ static int fuse_release(struct inode *inode, struct file *file)
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
 	 */
-	if (fc->writeback_cache)
+	if (fc->writeback_cache || fuse_inode_has_iomap(inode))
 		write_inode_now(inode, 1);
 
 	fuse_release_common(file, false);
@@ -2404,6 +2404,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(file);
 	int rc;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_mmap(file, vma);
+
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_mmap(file, vma);
@@ -2602,7 +2605,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 	return err;
 }
 
-static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
+sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -2956,8 +2959,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
 {
-	int err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
+	int err;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_flush_unmap_range(inode, start, end);
+
+	err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
 	if (!err)
 		fuse_sync_writes(inode);
 
@@ -2993,7 +3000,10 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-	if (block_faults) {
+	if (is_iomap) {
+		filemap_invalidate_lock(inode->i_mapping);
+		block_faults = true;
+	} else if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
@@ -3008,6 +3018,17 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 			goto out;
 	}
 
+	/*
+	 * If we are using iomap for file IO, fallocate must wait for all AIO
+	 * to complete before we continue as AIO can change the file size on
+	 * completion without holding any locks we currently hold. We must do
+	 * this first because AIO can update the in-memory inode size, and the
+	 * operations that follow require the in-memory size to be fully
+	 * up-to-date.
+	 */
+	if (is_iomap)
+		inode_dio_wait(inode);
+
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    offset + length > i_size_read(inode)) {
 		err = inode_newsize_ok(inode, offset + length);
@@ -3036,21 +3057,23 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (err)
 		goto out;
 
-	/* we could have extended the file */
-	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-		if (is_iomap && newsize > 0) {
-			err = fuse_iomap_setsize_finish(inode, newsize);
-			if (err)
-				goto out;
+	if (is_iomap) {
+		err = fuse_iomap_fallocate(file, mode, offset, length,
+					   newsize);
+		if (err)
+			goto out;
+	} else {
+		/* we could have extended the file */
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			if (fuse_write_update_attr(inode, newsize, length))
+				file_update_time(file);
 		}
 
-		if (fuse_write_update_attr(inode, offset + length, length))
-			file_update_time(file);
+		if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
+			truncate_pagecache_range(inode, offset,
+						 offset + length - 1);
 	}
 
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
-		truncate_pagecache_range(inode, offset, offset + length - 1);
-
 	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 
 out:
@@ -3094,6 +3117,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t err;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
+	const bool is_iomap = fuse_inode_has_iomap(inode_out);
 	bool is_unstable = (!fc->writeback_cache) &&
 			   ((pos_out + len) > inode_out->i_size);
 
@@ -3137,6 +3161,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
+	/* See inode_dio_wait comment in fuse_file_fallocate */
+	if (is_iomap)
+		inode_dio_wait(inode_out);
+
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
@@ -3177,7 +3205,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	truncate_inode_pages_range(inode_out->i_mapping,
+	if (!is_iomap)
+		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
 
@@ -3232,6 +3261,7 @@ static const struct file_operations fuse_file_operations = {
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
 	.setlease	= generic_setlease,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index ed6d9ba32c47b2..30f173847edba9 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -5,6 +5,9 @@
  */
 #include <linux/iomap.h>
 #include <linux/fiemap.h>
+#include <linux/pagemap.h>
+#include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -764,14 +767,7 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.post_open = fuse_iomap_post_open,
 };
 
-static inline void fuse_inode_set_iomap(struct inode *inode)
-{
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_mount *fm = get_fuse_mount(inode);
-
-	set_bit(FUSE_I_IOMAP, &fi->state);
-	atomic64_inc(&fm->fc->iomap_conn.inodes);
-}
+static inline void fuse_inode_set_iomap(struct inode *inode);
 
 static inline void fuse_inode_clear_iomap(struct inode *inode)
 {
@@ -1003,17 +999,107 @@ static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
 	.end_io		= fuse_iomap_dio_write_end_io,
 };
 
+static const struct iomap_write_ops fuse_iomap_write_ops = {
+};
+
+static int
+fuse_iomap_zero_range(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			len,
+	bool			*did_zero)
+{
+	return iomap_zero_range(inode, pos, len, did_zero, &fuse_iomap_ops,
+				&fuse_iomap_write_ops, NULL);
+}
+
+/* Take care of zeroing post-EOF blocks when they might exist. */
+static ssize_t
+fuse_iomap_write_zero_eof(
+	struct kiocb		*iocb,
+	struct iov_iter		*from,
+	bool			*drained_dio)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t			isize;
+	int			error;
+
+	/*
+	 * We need to serialise against EOF updates that occur in IO
+	 * completions here. We want to make sure that nobody is changing the
+	 * size while we do this check until we have placed an IO barrier (i.e.
+	 * hold i_rwsem exclusively) that prevents new IO from being
+	 * dispatched.  The spinlock effectively forms a memory barrier once we
+	 * have i_rwsem exclusively so we are guaranteed to see the latest EOF
+	 * value and hence be able to correctly determine if we need to run
+	 * zeroing.
+	 */
+	spin_lock(&fi->lock);
+	isize = i_size_read(inode);
+	if (iocb->ki_pos <= isize) {
+		spin_unlock(&fi->lock);
+		return 0;
+	}
+	spin_unlock(&fi->lock);
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	if (!(*drained_dio)) {
+		/*
+		 * We now have an IO submission barrier in place, but AIO can
+		 * do EOF updates during IO completion and hence we now need to
+		 * wait for all of them to drain.  Non-AIO DIO will have
+		 * drained before we are given the exclusive i_rwsem, and so
+		 * for most cases this wait is a no-op.
+		 */
+		inode_dio_wait(inode);
+		*drained_dio = true;
+		return 1;
+	}
+
+	filemap_invalidate_lock(mapping);
+	error = fuse_iomap_zero_range(inode, isize, iocb->ki_pos - isize, NULL);
+	filemap_invalidate_unlock(mapping);
+
+	return error;
+}
+
 static ssize_t
 fuse_iomap_write_checks(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
 	ssize_t			error;
+	bool			drained_dio = false;
 
+restart:
 	error = generic_write_checks(iocb, from);
 	if (error <= 0)
 		return error;
 
+	/*
+	 * If the offset is beyond the size of the file, we need to zero all
+	 * blocks that fall between the existing EOF and the start of this
+	 * write.
+	 *
+	 * We can do an unlocked check for i_size here safely as I/O completion
+	 * can only extend EOF.  Truncate is locked out at this point, so the
+	 * EOF cannot move backwards, only forwards. Hence we only need to take
+	 * the slow path when we are at or beyond the current EOF.
+	 */
+	if (fuse_inode_has_iomap(inode) &&
+	    iocb->ki_pos > i_size_read(inode)) {
+		error = fuse_iomap_write_zero_eof(iocb, from, &drained_dio);
+		if (error == 1)
+			goto restart;
+		if (error)
+			return error;
+	}
+
 	return kiocb_modified(iocb);
 }
 
@@ -1087,6 +1173,349 @@ void fuse_iomap_open_truncate(struct inode *inode)
 	spin_unlock(&fi->lock);
 }
 
+struct fuse_writepage_ctx {
+	struct iomap_writepage_ctx ctx;
+};
+
+static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
+{
+	struct inode *inode = ioend->io_inode;
+	unsigned int ioendflags = FUSE_IOMAP_IOEND_WRITEBACK;
+	unsigned int nofs_flag;
+	int err2;
+	int error = blk_status_to_errno(ioend->io_bio.bi_status);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/* We still have to clean up the ioend even if the inode is dead */
+	if (!error && fuse_is_bad(inode))
+		error = -EIO;
+
+	if (ioend->io_flags & IOMAP_IOEND_SHARED)
+		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
+	if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
+		ioendflags |= FUSE_IOMAP_IOEND_UNWRITTEN;
+
+	/*
+	 * We can allocate memory here while doing writeback on behalf of
+	 * memory reclaim.  To avoid memory allocation deadlocks set the
+	 * task-wide nofs context for the following operations.
+	 */
+	nofs_flag = memalloc_nofs_save();
+	err2 = fuse_iomap_ioend(inode, ioend->io_offset, ioend->io_size, error,
+				ioendflags, ioend->io_bio.bi_bdev,
+				ioend->io_sector);
+	if (err2 && !error)
+		error = err2;
+	iomap_finish_ioends(ioend, error);
+	memalloc_nofs_restore(nofs_flag);
+}
+
+static inline bool
+fuse_iomap_move_ioends(struct fuse_inode *fi, struct list_head *tmp)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fi->ioend_lock, flags);
+	list_replace_init(&fi->ioend_list, tmp);
+	spin_unlock_irqrestore(&fi->ioend_lock, flags);
+
+	return !list_empty(tmp);
+}
+
+/*
+ * Finish all pending IO completions that require transactional modifications.
+ *
+ * We try to merge physical and logically contiguous ioends before completion to
+ * minimise the number of transactions we need to perform during IO completion.
+ * Both unwritten extent conversion and COW remapping need to iterate and modify
+ * one physical extent at a time, so we gain nothing by merging physically
+ * discontiguous extents here.
+ *
+ * The ioend chain length that we can be processing here is largely unbound in
+ * length and we may have to perform significant amounts of work on each ioend
+ * to complete it. Hence we have to be careful about holding the CPU for too
+ * long in this loop.
+ */
+static void fuse_iomap_end_io(struct work_struct *work)
+{
+	struct fuse_inode *fi =
+		container_of(work, struct fuse_inode, ioend_work);
+	struct iomap_ioend *ioend;
+	struct list_head tmp;
+
+	while (fuse_iomap_move_ioends(fi, &tmp)) {
+		iomap_sort_ioends(&tmp);
+		while ((ioend = list_first_entry_or_null(&tmp, struct
+						iomap_ioend, io_list))) {
+			list_del_init(&ioend->io_list);
+			iomap_ioend_try_merge(ioend, &tmp);
+			fuse_iomap_end_ioend(ioend);
+			cond_resched();
+		}
+	}
+}
+
+static void fuse_iomap_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+	struct inode *inode = ioend->io_inode;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned long flags;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	spin_lock_irqsave(&fi->ioend_lock, flags);
+	if (list_empty(&fi->ioend_list))
+		queue_work(system_unbound_wq, &fi->ioend_work);
+	list_add_tail(&ioend->io_list, &fi->ioend_list);
+	spin_unlock_irqrestore(&fi->ioend_lock, flags);
+}
+
+/*
+ * If the folio has delalloc blocks on it, the caller is asking us to punch them
+ * out. If we don't, we can leave a stale delalloc mapping covered by a clean
+ * page that needs to be dirtied again before the delalloc mapping can be
+ * converted. This stale delalloc mapping can trip up a later direct I/O read
+ * operation on the same region.
+ *
+ * We prevent this by truncating away the delalloc regions on the folio. Because
+ * they are delalloc, we can do this without needing a transaction. Indeed - if
+ * we get ENOSPC errors, we have to be able to do this truncation without a
+ * transaction as there is no space left for block reservation (typically why
+ * we see a ENOSPC in writeback).
+ */
+static void fuse_iomap_discard_folio(struct folio *folio, loff_t pos, int error)
+{
+	struct inode *inode = folio->mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t end = folio_pos(folio) + folio_size(folio);
+
+	if (fuse_is_bad(inode))
+		return;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	printk_ratelimited(KERN_ERR
+		"page discard on page %px, inode 0x%llx, pos %llu.",
+			folio, fi->orig_ino, pos);
+
+	/* Userspace may need to remove delayed allocations */
+	fuse_iomap_ioend(inode, pos, end - pos, error, 0, NULL,
+			 FUSE_IOMAP_NULL_ADDR);
+}
+
+static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
+					  struct folio *folio, u64 offset,
+					  unsigned int len, u64 end_pos)
+{
+	ssize_t ret;
+
+	if (fuse_is_bad(wpc->inode)) {
+		ret = -EIO;
+		goto discard_folio;
+	}
+
+	ASSERT(fuse_inode_has_iomap(wpc->inode));
+
+	if (!iomap_writeback_map_valid(wpc, offset))
+		ret = iomap_writeback_map(wpc, folio, offset, len, end_pos,
+					  &fuse_iomap_ops);
+	else
+		ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+
+discard_folio:
+	if (ret < 0)
+		fuse_iomap_discard_folio(folio, offset, ret);
+	return ret;
+}
+
+static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
+				       int error)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
+	ASSERT(fuse_inode_has_iomap(ioend->io_inode));
+
+	/* always call our ioend function, even if we cancel the bio */
+	ioend->io_bio.bi_end_io = fuse_iomap_end_bio;
+	return iomap_ioend_writeback_submit(wpc, error);
+}
+
+static const struct iomap_writeback_ops fuse_iomap_writeback_ops = {
+	.writeback_range	= fuse_iomap_writeback_range,
+	.writeback_submit	= fuse_iomap_writeback_submit,
+};
+
+static int fuse_iomap_writepages(struct address_space *mapping,
+				 struct writeback_control *wbc)
+{
+	struct fuse_writepage_ctx wpc = {
+		.ctx = {
+			.inode = mapping->host,
+			.wbc = wbc,
+			.ops = &fuse_iomap_writeback_ops,
+		},
+	};
+
+	ASSERT(fuse_inode_has_iomap(mapping->host));
+
+	return iomap_writepages(&wpc.ctx);
+}
+
+static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(file)));
+
+	iomap_bio_read_folio(folio, &fuse_iomap_ops);
+	return 0;
+}
+
+static void fuse_iomap_readahead(struct readahead_control *rac)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(rac->file)));
+
+	iomap_bio_readahead(rac, &fuse_iomap_ops);
+}
+
+static const struct address_space_operations fuse_iomap_aops = {
+	.read_folio		= fuse_iomap_read_folio,
+	.readahead		= fuse_iomap_readahead,
+	.writepages		= fuse_iomap_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate  = iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+
+	/* These aren't pagecache operations per se */
+	.bmap			= fuse_bmap,
+};
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+
+	inode->i_data.a_ops = &fuse_iomap_aops;
+
+	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
+	INIT_LIST_HEAD(&fi->ioend_list);
+	spin_lock_init(&fi->ioend_lock);
+	set_bit(FUSE_I_IOMAP, &fi->state);
+	atomic64_inc(&fm->fc->iomap_conn.inodes);
+}
+
+/*
+ * Locking for serialisation of IO during page faults. This results in a lock
+ * ordering of:
+ *
+ * mmap_lock (MM)
+ *   sb_start_pagefault(vfs, freeze)
+ *     invalidate_lock (vfs - truncate serialisation)
+ *       page_lock (MM)
+ *         i_lock (FUSE - extent map serialisation)
+ */
+static vm_fault_t fuse_iomap_page_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	vm_fault_t ret;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
+
+	filemap_invalidate_lock_shared(mapping);
+	ret = iomap_page_mkwrite(vmf, &fuse_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(mapping);
+
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct fuse_iomap_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= fuse_iomap_page_mkwrite,
+};
+
+int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(file)));
+
+	file_accessed(file);
+	vma->vm_ops = &fuse_iomap_vm_ops;
+	return 0;
+}
+
+static ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret = 0;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (!iov_iter_count(to))
+		goto out; /* skip atime */
+
+	ret = fuse_iomap_ilock_iocb(iocb, SHARED);
+	if (ret)
+		goto out;
+
+	ret = generic_file_read_iter(iocb, to);
+	if (ret > 0)
+		file_accessed(iocb->ki_filp);
+	inode_unlock_shared(inode);
+
+out:
+	return ret;
+}
+
+static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
+					 struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t pos = iocb->ki_pos;
+	ssize_t ret = 0;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (!iov_iter_count(from))
+		goto out;
+
+	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
+	if (ret)
+		goto out;
+
+	ret = fuse_iomap_write_checks(iocb, from);
+	if (ret)
+		goto out_unlock;
+
+	if (inode->i_size < pos + iov_iter_count(from))
+		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+	ret = iomap_file_buffered_write(iocb, from, &fuse_iomap_ops,
+					&fuse_iomap_write_ops, NULL);
+
+	if (ret > 0)
+		fuse_write_update_attr(inode, pos + ret, ret);
+	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+out_unlock:
+	inode_unlock(inode);
+
+	if (ret > 0) {
+		/* Handle various SYNC-type writes */
+		ret = generic_write_sync(iocb, ret);
+	}
+out:
+	return ret;
+}
+
 static inline bool fuse_iomap_force_directio(const struct kiocb *iocb)
 {
 	struct fuse_file *ff = iocb->ki_filp->private_data;
@@ -1100,9 +1529,33 @@ ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	ASSERT(fuse_inode_has_iomap(file_inode(iocb->ki_filp)));
 
-	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio)
-		return fuse_iomap_direct_read(iocb, to);
-	return -EIO;
+	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio) {
+		ssize_t ret = fuse_iomap_direct_read(iocb, to);
+
+		switch (ret) {
+		case -ENOTBLK:
+		case -ENOSYS:
+			/*
+			 * We fall back to a buffered read if:
+			 *
+			 *  - ENOTBLK means iomap told us to do it
+			 *  - ENOSYS means the fuse server wants it
+			 *
+			 * Don't fall back if we were forced to do it.
+			 */
+			if (force_directio)
+				return -EIO;
+			break;
+		default:
+			/* errors, no progress, or partial progress */
+			return ret;
+		}
+
+		/* do not let generic_file_read_iter fall into ->direct_IO */
+		iocb->ki_flags &= ~IOCB_DIRECT;
+	}
+
+	return fuse_iomap_buffered_read(iocb, to);
 }
 
 ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -1111,7 +1564,230 @@ ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ASSERT(fuse_inode_has_iomap(file_inode(iocb->ki_filp)));
 
-	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio)
-		return fuse_iomap_direct_write(iocb, from);
-	return -EIO;
+	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio) {
+		ssize_t ret = fuse_iomap_direct_write(iocb, from);
+
+		switch (ret) {
+		case -ENOTBLK:
+		case -ENOSYS:
+			/*
+			 * We fall back to a buffered write if:
+			 *
+			 *  - ENOTBLK means iomap told us to do it
+			 *  - ENOSYS means the fuse server wants it
+			 *
+			 * Either way, try the write again as a synchronous
+			 * buffered write unless we were forced to do directio.
+			 */
+			if (force_directio)
+				return -EIO;
+			iocb->ki_flags |= IOCB_SYNC;
+			break;
+		default:
+			/* errors, no progress, or partial progress */
+			return ret;
+		}
+	}
+
+	return fuse_iomap_buffered_write(iocb, from);
+}
+
+static int
+fuse_iomap_truncate_page(
+	struct inode *inode,
+	loff_t			pos,
+	bool			*did_zero)
+{
+	return iomap_truncate_page(inode, pos, did_zero, &fuse_iomap_ops,
+				   &fuse_iomap_write_ops, NULL);
+}
+/*
+ * Truncate pagecache for a file before sending the truncate request to
+ * userspace.  Must have write permission and not be a directory.
+ *
+ * Caution: The caller of this function is responsible for calling
+ * setattr_prepare() or otherwise verifying the change is fine.
+ */
+int
+fuse_iomap_setsize_start(
+	struct inode		*inode,
+	loff_t			newsize)
+{
+	loff_t			oldsize = i_size_read(inode);
+	int			error;
+	bool			did_zeroing = false;
+
+	rwsem_assert_held_write(&inode->i_rwsem);
+	rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+	ASSERT(S_ISREG(inode->i_mode));
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/*
+	 * Wait for all direct I/O to complete.
+	 */
+	inode_dio_wait(inode);
+
+	/*
+	 * File data changes must be complete and flushed to disk before we
+	 * call userspace to modify the inode.
+	 *
+	 * Start with zeroing any data beyond EOF that we may expose on file
+	 * extension, or zeroing out the rest of the block on a downward
+	 * truncate.
+	 */
+	if (newsize > oldsize)
+		error = fuse_iomap_zero_range(inode, oldsize, newsize - oldsize,
+					      &did_zeroing);
+	else
+		error = fuse_iomap_truncate_page(inode, newsize, &did_zeroing);
+	if (error)
+		return error;
+
+	/*
+	 * We've already locked out new page faults, so now we can safely
+	 * remove pages from the page cache knowing they won't get refaulted
+	 * until we drop the mapping invalidation lock after the extent
+	 * manipulations are complete. The truncate_setsize() call also cleans
+	 * folios spanning EOF on extending truncates and hence ensures
+	 * sub-page block size filesystems are correctly handled, too.
+	 *
+	 * And we update in-core i_size and truncate page cache beyond newsize
+	 * before writing back the whole file, so we're guaranteed not to write
+	 * stale data past the new EOF on truncate down.
+	 */
+	truncate_setsize(inode, newsize);
+
+	/*
+	 * Flush the entire pagecache to ensure the fuse server logs the inode
+	 * size change and all dirty data that might be associated with it.
+	 * We don't know the ondisk inode size, so we only have this clumsy
+	 * hammer.
+	 */
+	return filemap_write_and_wait(inode->i_mapping);
+}
+
+/*
+ * Prepare for a file data block remapping operation by flushing and unmapping
+ * all pagecache for the entire range.
+ */
+int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
+				 loff_t endpos)
+{
+	loff_t			start, end;
+	unsigned int		rounding;
+	int			error;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/*
+	 * Make sure we extend the flush out to extent alignment boundaries so
+	 * any extent range overlapping the start/end of the modification we
+	 * are about to do is clean and idle.
+	 */
+	rounding = max_t(unsigned int, i_blocksize(inode), PAGE_SIZE);
+	start = round_down(pos, rounding);
+	end = round_up(endpos + 1, rounding) - 1;
+
+	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
+	if (error)
+		return error;
+	truncate_pagecache_range(inode, start, end);
+	return 0;
+}
+
+static int fuse_iomap_punch_range(struct inode *inode, loff_t offset,
+				  loff_t length)
+{
+	loff_t isize = i_size_read(inode);
+	int error;
+
+	/*
+	 * Now that we've unmap all full blocks we'll have to zero out any
+	 * partial block at the beginning and/or end.  iomap_zero_range is
+	 * smart enough to skip holes and unwritten extents, including those we
+	 * just created, but we must take care not to zero beyond EOF, which
+	 * would enlarge i_size.
+	 */
+	if (offset >= isize)
+		return 0;
+	if (offset + length > isize)
+		length = isize - offset;
+	error = fuse_iomap_zero_range(inode, offset, length, NULL);
+	if (error)
+		return error;
+
+	/*
+	 * If we zeroed right up to EOF and EOF straddles a page boundary we
+	 * must make sure that the post-EOF area is also zeroed because the
+	 * page could be mmap'd and iomap_zero_range doesn't do that for us.
+	 * Writeback of the eof page will do this, albeit clumsily.
+	 */
+	if (offset + length >= isize && offset_in_page(offset + length) > 0) {
+		error = filemap_write_and_wait_range(inode->i_mapping,
+					round_down(offset + length, PAGE_SIZE),
+					LLONG_MAX);
+	}
+
+	return error;
+}
+
+int
+fuse_iomap_fallocate(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			length,
+	loff_t			new_size)
+{
+	struct inode *inode = file_inode(file);
+	int error;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/*
+	 * If we unmapped blocks from the file range, then we zero the
+	 * pagecache for those regions and push them to disk rather than make
+	 * the fuse server manually zero the disk blocks.
+	 */
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
+		error = fuse_iomap_punch_range(inode, offset, length);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * If this is an extending write, we need to zero the bytes beyond the
+	 * new EOF and bounce the new size out to userspace.  There's no need
+	 * to call fuse_iomap_setsize_finish because the writeback completions
+	 * will update i_disk_size for us.
+	 */
+	if (new_size) {
+		error = fuse_iomap_setsize_start(inode, new_size);
+		if (error)
+			return error;
+
+		fuse_write_update_attr(inode, new_size, length);
+	}
+
+	file_update_time(file);
+	return 0;
+}
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
+{
+	struct inode *inode = file_inode(file);
+	bool needlock = advice == POSIX_FADV_WILLNEED &&
+			fuse_inode_has_iomap(inode);
+	int ret;
+
+	/*
+	 * Operations creating pages in page cache need protection from hole
+	 * punching and similar ops
+	 */
+	if (needlock)
+		inode_lock_shared(inode);
+	ret = generic_fadvise(file, start, end, advice);
+	if (needlock)
+		inode_unlock_shared(inode);
+	return ret;
 }

