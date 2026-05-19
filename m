Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A83C7E15;
	Tue, 19 May 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229780; cv=none; b=nJWrht2VqQuulHHVEZtV3za3jYEbWDI5x9SEFdp9qbKyZQTjcwkSLS5E+EhDXfY9A6RLgwUNM9uyiJixQVp/qOZnjLwAzhFdAfaJCMPjZaMOPSRAEJrkavvYu1Kw/Q1kfpsx/cYWUbQo1NdsSPVSumD3yVdmKSr6HvZCxnlmHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229780; c=relaxed/simple;
	bh=jIvCkyo/Aq+Z6kYgAZuprZT69cPZ+t0ri++wHA+Wymc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnn8NB9tAbIOJn3rR4cZ7/Ua41coByPg+MAaKgxHvklXnoFbX9yV8UVjtth9J7Vx7N7RPCt5mIIK8qnj3hMPdK65ZFaT3ky/L2O/IfvmALCA7hS5Ao1LeoS6HZrMotTHWxLNjmpF5aXdQdc7gubDyOp9KhYgogn2Kmt0WvKYivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojGZYWYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojGZYWYo"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9C7551F000E9;
	Tue, 19 May 2026 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229778;
	bh=WCH03JC9H2Qx1pooLy6cr9mX1uXYe9brMUX3KQ2S3PQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=ojGZYWYolTk86+JhslocIMuGHhHvP48uHyGRFoxaYDK5HMgOwjXS2H0RQzMfAQJPI
	 i/TVttv4GMLmb+zhqacKiDidoy8jUD87VlAwqfJHBiNo4ihuTo4z1XIcBUKpk/7J3T
	 2IU7MMuv7IbC6AozsnQvmGZ/mIAoHrD1RRHr//Vz87a9EUnzT+KwPd1K6AKVl5iaoF
	 fZXF2tXvHaeovrEHQYurXBqpuJajKR3zvqCgHj+iFW2A2JX7N/2397a8n7ED5JMgKF
	 MXF7n4Ps+pvXlrwJS8AkloPz8loP8EiZ4d+CZKSGG3oyN0LhjeqnK+0GyEwpsPUnkT
	 UnTsVzAQhTQDA==
Date: Tue, 19 May 2026 15:29:38 -0700
Subject: [PATCH 1/6] fuse: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945762.2437300.11434081373277790266.stgit@frogsfrogsfrogs>
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

Start implementing the fuse-iomap file I/O paths by adding direct I/O
support and all the signalling flags that come with it.  Buffered I/O
is much more complicated, so we leave that to a subsequent patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   11 +
 fs/fuse/fuse_iomap.h      |   18 ++
 include/uapi/linux/fuse.h |   27 ++++
 fs/fuse/dir.c             |   13 ++
 fs/fuse/file.c            |   29 +++-
 fs/fuse/fuse_iomap.c      |  337 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    2 
 fs/fuse/iomode.c          |    2 
 8 files changed, 433 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4ffdb2b9c39129..5b219ce8a6c918 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -190,6 +190,11 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+
+#ifdef CONFIG_FUSE_IOMAP
+			/* file size as reported by fuse server */
+			loff_t i_disk_size;
+#endif
 		};
 
 		/* readdir cache (directory only) */
@@ -664,6 +669,12 @@ struct fuse_sync_bucket {
 struct fuse_iomap_conn {
 	/**  number of inodes that have iomap enabled */
 	atomic64_t inodes;
+
+	/* fuse server doesn't implement iomap_end */
+	unsigned int no_end:1;
+
+	/* fuse server doesn't implement iomap_ioend */
+	unsigned int no_ioend:1;
 };
 #endif
 
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 4196c6ed5466bc..4ea34082e01a15 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -35,6 +35,17 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
 sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
+
+void fuse_iomap_open(struct inode *inode, struct file *file);
+int fuse_iomap_finish_open(const struct fuse_file *ff,
+			   const struct inode *inode);
+void fuse_iomap_open_truncate(struct inode *inode);
+
+void fuse_iomap_set_disk_size(struct fuse_inode *fi, loff_t newsize);
+int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
+
+ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -44,6 +55,13 @@ sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 # define fuse_iomap_fiemap			NULL
 # define fuse_iomap_lseek(...)			(-ENOSYS)
 # define fuse_iomap_bmap(...)			(-ENOSYS)
+# define fuse_iomap_open(...)			((void)0)
+# define fuse_iomap_finish_open(...)		(-ENOSYS)
+# define fuse_iomap_open_truncate(...)		((void)0)
+# define fuse_iomap_set_disk_size(...)		((void)0)
+# define fuse_iomap_setsize_finish(...)		(-ENOSYS)
+# define fuse_iomap_read_iter(...)		(-ENOSYS)
+# define fuse_iomap_write_iter(...)		(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 9cf63b4c4a3e9d..ad977782eef231 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -682,6 +682,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1430,4 +1431,30 @@ struct fuse_iomap_end_in {
 	struct fuse_iomap_io	map;
 };
 
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+
+struct fuse_iomap_ioend_in {
+	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
+	int32_t error;		/* negative errno or 0 */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t new_addr;	/* disk offset of new mapping, in bytes */
+	uint64_t written;	/* bytes processed */
+	uint32_t dev;		/* device cookie */
+	uint32_t pad;		/* zero */
+};
+
+struct fuse_iomap_ioend_out {
+	uint64_t newsize;	/* new ondisk size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 18b9a43a69f6e8..9daac6af7d3a22 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -908,6 +908,10 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	entry->d_time = epoch;
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
+
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (!err) {
 		file->private_data = ff;
@@ -1955,6 +1959,9 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -2315,6 +2322,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto error;
 	}
 
+	if (is_iomap && is_truncate) {
+		err = fuse_iomap_setsize_finish(inode, outarg.attr.size);
+		if (err)
+			goto error;
+	}
+
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a6b8d6bf62d6d2..279a5229a51a9e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -226,7 +226,10 @@ int fuse_finish_open(struct inode *inode, struct file *file)
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err;
 
-	err = fuse_file_io_open(file, inode);
+	if (fuse_inode_has_iomap(inode))
+		err = fuse_iomap_finish_open(ff, inode);
+	else
+		err = fuse_file_io_open(file, inode);
 	if (err)
 		return err;
 
@@ -269,6 +272,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (is_iomap)
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -299,9 +305,11 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		if (is_truncate)
+		if (is_truncate) {
 			truncate_pagecache(inode, 0);
-		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			if (is_iomap)
+				fuse_iomap_open_truncate(inode);
+		} else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 	if (dax_truncate)
@@ -1831,6 +1839,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_read_iter(iocb, to);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1852,6 +1863,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_write_iter(iocb, from);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
@@ -2964,7 +2978,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.length = length,
 		.mode = mode
 	};
+	loff_t newsize = 0;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool block_faults = FUSE_IS_DAX(inode) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
@@ -2997,6 +3013,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		err = inode_newsize_ok(inode, offset + length);
 		if (err)
 			goto out;
+		newsize = offset + length;
 	}
 
 	err = file_modified(file);
@@ -3021,6 +3038,12 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 
 	/* we could have extended the file */
 	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+		if (is_iomap && newsize > 0) {
+			err = fuse_iomap_setsize_finish(inode, newsize);
+			if (err)
+				goto out;
+		}
+
 		if (fuse_write_update_attr(inode, offset + length, length))
 			file_update_time(file);
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3c6bf865ff4d43..5e23c662b972fa 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -519,10 +519,15 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 }
 
 /* Decide if we send FUSE_IOMAP_END to the fuse server */
-static bool fuse_should_send_iomap_end(const struct iomap *iomap,
+static bool fuse_should_send_iomap_end(const struct fuse_mount *fm,
+				       const struct iomap *iomap,
 				       unsigned int opflags, loff_t count,
 				       ssize_t written)
 {
+	/* Not implemented on fuse server */
+	if (fm->fc->iomap_conn.no_end)
+		return false;
+
 	/* fuse server demanded an iomap_end call. */
 	if (iomap->flags & IOMAP_F_PRIVATE)
 		return true;
@@ -547,7 +552,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	int err;
 
-	if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
+	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
 		struct fuse_iomap_end_in inarg = {
 			.opflags = fuse_iomap_op_to_server(opflags),
 			.attr_ino = fi->orig_ino,
@@ -572,6 +577,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			 * libfuse returns ENOSYS for servers that don't
 			 * implement iomap_end
 			 */
+			fm->fc->iomap_conn.no_end = 1;
 			err = 0;
 		}
 		if (err) {
@@ -588,6 +594,119 @@ static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_end		= fuse_iomap_end,
 };
 
+static inline bool
+fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
+			     const struct fuse_iomap_ioend_in *inarg)
+{
+	/* Not implemented on fuse server */
+	if (fm->fc->iomap_conn.no_ioend)
+		return false;
+
+	/* Always send an ioend for errors. */
+	if (inarg->error)
+		return true;
+
+	/* Send an ioend if we performed an IO involving metadata changes. */
+	return inarg->written > 0 &&
+	       (inarg->flags & (FUSE_IOMAP_IOEND_SHARED |
+				FUSE_IOMAP_IOEND_UNWRITTEN |
+				FUSE_IOMAP_IOEND_APPEND));
+}
+
+int
+fuse_iomap_setsize_finish(
+	struct inode		*inode,
+	loff_t			newsize)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	spin_lock(&fi->lock);
+	fi->i_disk_size = newsize;
+	spin_unlock(&fi->lock);
+	return 0;
+}
+
+static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
+			    int error, unsigned ioendflags,
+			    struct block_device *bdev, sector_t new_addr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_iomap_ioend_in inarg = {
+		.flags = ioendflags,
+		.error = error,
+		.attr_ino = fi->orig_ino,
+		.pos = pos,
+		.written = written,
+		.dev = fuse_iomap_find_backing_id(fm->fc, bdev),
+		.new_addr = new_addr,
+	};
+	struct fuse_iomap_ioend_out outarg = { };
+
+	spin_lock(&fi->lock);
+	if (pos + written > fi->i_disk_size)
+		inarg.flags |= FUSE_IOMAP_IOEND_APPEND;
+
+	outarg.newsize = max_t(loff_t, fi->i_disk_size, pos + written),
+	spin_unlock(&fi->lock);
+
+	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
+		FUSE_ARGS(args);
+		int iomap_error;
+
+		args.opcode = FUSE_IOMAP_IOEND;
+		args.nodeid = get_node_id(inode);
+		args.in_numargs = 1;
+		args.in_args[0].size = sizeof(inarg);
+		args.in_args[0].value = &inarg;
+		args.out_numargs = 1;
+		args.out_args[0].size = sizeof(outarg);
+		args.out_args[0].value = &outarg;
+		iomap_error = fuse_simple_request(fm, &args);
+		switch (iomap_error) {
+		case -ENOSYS:
+			/*
+			 * fuse servers can return ENOSYS if ioend processing
+			 * is never needed for this filesystem.  Don't pass
+			 * that up to iomap.
+			 */
+			fm->fc->iomap_conn.no_ioend = 1;
+			break;
+		case 0:
+			break;
+		default:
+			/*
+			 * If the write IO failed, return the failure code to
+			 * the caller no matter what happens with the ioend.
+			 * If the write IO succeeded but the ioend did not,
+			 * pass the new error up to the caller.
+			 */
+			if (!error)
+				error = iomap_error;
+			break;
+		}
+	}
+
+	/*
+	 * Pass whatever error iomap gave us (or any new errors since then)
+	 * back to iomap.
+	 */
+	if (error)
+		return error;
+
+	/*
+	 * If there weren't any ioend errors, update the incore isize, which
+	 * confusingly takes the new i_size as "pos".
+	 */
+	spin_lock(&fi->lock);
+	fi->i_disk_size = max_t(loff_t, fi->i_disk_size, outarg.newsize);
+	spin_unlock(&fi->lock);
+	fuse_write_update_attr(inode, pos + written, written);
+	return 0;
+}
+
 static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
 {
 	if (!fc->iomap)
@@ -764,3 +883,217 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 		return offset;
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
+
+void fuse_iomap_open(struct inode *inode, struct file *file)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+}
+
+int fuse_iomap_finish_open(const struct fuse_file *ff,
+			   const struct inode *inode)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/* no weird modes, iomap only handles seekable regular files */
+	if (ff->open_flags & (FOPEN_PASSTHROUGH |
+			      FOPEN_STREAM |
+			      FOPEN_NONSEEKABLE))
+		return -EINVAL;
+
+	return 0;
+}
+
+enum fuse_ilock_type {
+	SHARED,
+	EXCL,
+};
+
+static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
+				 enum fuse_ilock_type type)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		switch (type) {
+		case SHARED:
+			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
+		case EXCL:
+			return inode_trylock(inode) ? 0 : -EAGAIN;
+		default:
+			ASSERT(0);
+			return -EIO;
+		}
+
+		/* shut up gcc */
+		return 0;
+	}
+
+	switch (type) {
+	case SHARED:
+		inode_lock_shared(inode);
+		break;
+	case EXCL:
+		inode_lock(inode);
+		break;
+	default:
+		ASSERT(0);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret = 0;
+
+	if (!iov_iter_count(to))
+		goto out; /* skip atime */
+
+	ret = fuse_iomap_ilock_iocb(iocb, SHARED);
+	if (ret)
+		goto out;
+
+	ret = iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0);
+	if (ret > 0)
+		file_accessed(iocb->ki_filp);
+	inode_unlock_shared(inode);
+
+out:
+	return ret;
+}
+
+static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
+				       int error, unsigned dioflags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	unsigned int ioendflags = FUSE_IOMAP_IOEND_DIRECT;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (dioflags & IOMAP_DIO_COW)
+		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
+	if (dioflags & IOMAP_DIO_UNWRITTEN)
+		ioendflags |= FUSE_IOMAP_IOEND_UNWRITTEN;
+
+	return fuse_iomap_ioend(inode, iocb->ki_pos, written, error,
+				ioendflags, NULL, FUSE_IOMAP_NULL_ADDR);
+}
+
+static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
+	.end_io		= fuse_iomap_dio_write_end_io,
+};
+
+static ssize_t
+fuse_iomap_write_checks(
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	ssize_t			error;
+
+	error = generic_write_checks(iocb, from);
+	if (error <= 0)
+		return error;
+
+	return kiocb_modified(iocb);
+}
+
+static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
+				       struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t blockmask = i_blocksize(inode) - 1;
+	size_t count = iov_iter_count(from);
+	unsigned int flags = IOMAP_DIO_COMP_WORK;
+	ssize_t ret = 0;
+
+	if (!count)
+		goto out;
+
+	/*
+	 * Unaligned direct writes require zeroing of unwritten head and tail
+	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
+	 * The zeroing writes must complete before we return the direct write
+	 * to userspace.  Don't even bother trying the fast path.
+	 */
+	if ((iocb->ki_pos | count) & blockmask)
+		flags |= IOMAP_DIO_FORCE_WAIT;
+
+	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
+	if (ret)
+		goto out;
+
+	ret = fuse_iomap_write_checks(iocb, from);
+	if (ret)
+		goto out_unlock;
+
+	/*
+	 * If we are doing exclusive unaligned I/O, this must be the only I/O
+	 * in-flight.  Otherwise we risk data corruption due to unwritten
+	 * extent conversions from the AIO end_io handler.  Wait for all other
+	 * I/O to drain first.
+	 */
+	if (flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(inode);
+
+	ret = iomap_dio_rw(iocb, from, &fuse_iomap_ops,
+			   &fuse_iomap_dio_write_ops, flags, NULL, 0);
+out_unlock:
+	inode_unlock(inode);
+out:
+	return ret;
+}
+
+void fuse_iomap_set_disk_size(struct fuse_inode *fi, loff_t newsize)
+{
+	lockdep_assert_held(&fi->lock);
+
+	if (fuse_inode_has_iomap(&fi->inode))
+		fi->i_disk_size = newsize;
+}
+
+void fuse_iomap_open_truncate(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	spin_lock(&fi->lock);
+	fi->i_disk_size = 0;
+	spin_unlock(&fi->lock);
+}
+
+static inline bool fuse_iomap_force_directio(const struct kiocb *iocb)
+{
+	struct fuse_file *ff = iocb->ki_filp->private_data;
+
+	return ff->open_flags & FOPEN_DIRECT_IO;
+}
+
+ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	const bool force_directio = fuse_iomap_force_directio(iocb);
+
+	ASSERT(fuse_inode_has_iomap(file_inode(iocb->ki_filp)));
+
+	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio)
+		return fuse_iomap_direct_read(iocb, to);
+	return -EIO;
+}
+
+ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	const bool force_directio = fuse_iomap_force_directio(iocb);
+
+	ASSERT(fuse_inode_has_iomap(file_inode(iocb->ki_filp)));
+
+	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio)
+		return fuse_iomap_direct_write(iocb, from);
+	return -EIO;
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 98f2464389d026..c94f47779f9966 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -303,6 +303,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	else
 		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
 
+	fuse_iomap_set_disk_size(fi, attr->size);
+
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
 	 * to check permissions.  This prevents failures due to the
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 9be9ae3520003e..ed666b39cf8af4 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -204,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
+	if (FUSE_IS_DAX(inode) || !ff->args)
 		return 0;
 
 	/*

