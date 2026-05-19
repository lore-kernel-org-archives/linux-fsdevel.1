Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F03E3D96;
	Tue, 19 May 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229733; cv=none; b=qAQT1Ch2N6I4iMQqbTbvcMTCE5NK3Wel+rxGr0CSuIjPMNDT9446yZKsb3HQSQc+x57KF+195p+qTzDyYfGLuYViA7kYHzUp6QYXzwJ4jXCoRkxDO8uqeDJtEVmSmKrHTJ8P0807nzwMa4BdlKx1gBsf8YVrTp+wUusdhne2QMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229733; c=relaxed/simple;
	bh=WQnjrUHH/+I13y/zESs62XTmir0wC5LzaDb7cE0e0+Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiPhu+qTjQnqIL7JgyhEpVxPIwCK2PCVVe1S5F2jdv4hPhFFwmhK4qDa4QpFdxSAGZ0B5XweDGkQ69lGWu26eJCzhddDZwguK6jewSkhes1SZQzUVZaPgSbsPHqO4dEwMThJNO4YmTsidff+UaW35Wci9RF9qlVkn265x9F0m1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgTx1Nfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgTx1Nfm"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DDD041F000E9;
	Tue, 19 May 2026 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229732;
	bh=OC3KqlSzN3a06rtlgCRbw+9QLGoI5ChCJShxuRYTHY0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=PgTx1NfmeTXQOA+0C/0lQkPZYxLsy81M2YHfQCfhHjuv1GEhhhOn3BfvoCDStwvvz
	 bMQBWFnz4NMmeq5yRJ2N5RCTGk0NAA9CGEKqRueONq1DvIf6nWPbpnUXnPudIIWGda
	 dsf/QI0byrCD8bEzfOEpT3fdP6WbKFqQsvm0o72n4yloDptNfQnv4JNN7Lmf30lifw
	 R8BmBcTmRUQaKtQ+Es5DrZxdVsZjfnUdnvfMwOCiSMdvwBJxnTEeRzf73Ys6C8/fQj
	 dbuHbcNETC6ABip9dHPhEuE4SHpuS0wMGomymEPmgsTZ1PT/X/uEJdLOqBfL0/euVY
	 T/5Ha+eYvyoOg==
Date: Tue, 19 May 2026 15:28:51 -0700
Subject: [PATCH 09/11] fuse: isolate the other regular file IO paths from
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945435.2436837.4187590963088494368.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

iomap completely takes over all regular file IO, so we don't need to
access any of the other mechanisms at all.  Gate them off so that we can
eventually overlay them with a union to save space in struct fuse_inode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c    |   14 +++++++++-----
 fs/fuse/file.c   |   22 +++++++++++++++++-----
 fs/fuse/inode.c  |    3 ++-
 fs/fuse/iomode.c |    3 ++-
 4 files changed, 30 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ca201ce3499040..1641223f76d8c6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2203,6 +2203,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	FUSE_ARGS(args);
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
 	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
 	loff_t oldsize;
@@ -2260,12 +2261,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (err)
 			return err;
 
-		fuse_set_nowrite(inode);
-		fuse_release_nowrite(inode);
+		if (!is_iomap) {
+			fuse_set_nowrite(inode);
+			fuse_release_nowrite(inode);
+		}
 	}
 
 	if (is_truncate) {
-		fuse_set_nowrite(inode);
+		if (!is_iomap)
+			fuse_set_nowrite(inode);
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
@@ -2337,7 +2341,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!is_wb || is_truncate)
 		i_size_write(inode, outarg.attr.size);
 
-	if (is_truncate) {
+	if (is_truncate && !is_iomap) {
 		/* NOTE: this may release/reacquire fi->lock */
 		__fuse_release_nowrite(inode);
 	}
@@ -2361,7 +2365,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 
 error:
-	if (is_truncate)
+	if (is_truncate && !is_iomap)
 		fuse_release_nowrite(inode);
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8d55d2f4dd4cc9..8edb2f089277a1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -206,6 +206,10 @@ static void fuse_link_write_file(struct file *file)
 	struct inode *inode = file_inode(file);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_file *ff = file->private_data;
+
+	if (fuse_inode_has_iomap(&fi->inode))
+		return;
+
 	/*
 	 * file may be written through mmap, so chain it onto the
 	 * inodes's write_file list
@@ -257,6 +261,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
@@ -278,7 +283,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			goto out_inode_unlock;
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_set_nowrite(inode);
 
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
@@ -291,7 +296,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			fuse_truncate_update_attr(inode, file);
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
 		if (is_truncate)
@@ -539,12 +544,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	const bool need_sync_writes = !fuse_inode_has_iomap(inode);
 	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	inode_lock(inode);
+	if (need_sync_writes)
+		inode_lock(inode);
 
 	/*
 	 * Start writeback against all dirty pages of the inode, then
@@ -555,7 +562,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (err)
 		goto out;
 
-	fuse_sync_writes(inode);
+	if (need_sync_writes)
+		fuse_sync_writes(inode);
 
 	/*
 	 * Due to implementation of fuse writeback
@@ -579,7 +587,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 		err = 0;
 	}
 out:
-	inode_unlock(inode);
+	if (need_sync_writes)
+		inode_unlock(inode);
 
 	return err;
 }
@@ -2015,6 +2024,9 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
 {
 	struct fuse_file *ff;
 
+	if (fuse_inode_has_iomap(&fi->inode))
+		return NULL;
+
 	spin_lock(&fi->lock);
 	ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
 				      write_entry);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 59113da7d31f5e..98f2464389d026 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -192,7 +192,8 @@ static void fuse_evict_inode(struct inode *inode)
 		if (inode->i_nlink > 0)
 			atomic64_inc(&fc->evict_ctr);
 	}
-	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
+	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode) &&
+	    !fuse_inode_has_iomap(inode)) {
 		WARN_ON(fi->iocachectr != 0);
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f307..9be9ae3520003e 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -203,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_DAX(inode) || !ff->args)
+	if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
 		return 0;
 
 	/*

