Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33576330662;
	Wed, 29 Apr 2026 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472794; cv=none; b=ol6kP10153VmZb14hwyaJe1GQGW++N3N3NnLPw+jB/wh3zapOo8i7UORfk5l5GFoeg2AIXulbX65ooQyHwt0BBhih/bMZmEyBmjeRsrKr3mzRs5dDBpneJlwAfU4lzLSVX1z2h+OmiP/2kMJI9TStVRr5UcMO/ANit740EDmywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472794; c=relaxed/simple;
	bh=B6r2FGnwRHFJyvsHuB+KJBOa7vXGk9+G9xObb2a8ymA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqQ5huQGV1rJOcPLQPJW1EWyAHKpze2l/K6G2Kmo0w8fdiSGcrS2BOgtf7GLMpY6DXl5T299fvb1xVeK39BEyejCO/hhezO3h0A65uJcrOl5co7JntKpVMg8SaH1ompkSfn9TDBe79wy14QW+wlHfzA/VbFhYKGfJF/sZ804bKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfek5dfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfek5dfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA03C19425;
	Wed, 29 Apr 2026 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472794;
	bh=B6r2FGnwRHFJyvsHuB+KJBOa7vXGk9+G9xObb2a8ymA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Nfek5dfolKoB+Gu/LCzUAGyui17Yhmhs0ZejyrbQVTUg9FOjqi0vEneXcTD14wBq5
	 9M8YlNF7MGIybAa+6/C0snBtuoGSfXECrBA++LJQkZEUQtE1bjpRsA756+GjItJ85+
	 XaOGdjbE4wtMg8PbZffYWy4f52vZKmwTzxq6+KQwoSqE8Z5I0DLSiQgEgx1u1IDZjG
	 8IYrxUFzoDkd5Po4WLCDFJhrfh3uIP58nfuznFU+sS2jwh6gpr6YRZPyVZgMEHKngr
	 2RjtVh1hV/2RaeiYUiqqPMxJ8N/I5Lpl6guuX5xEGrpC2BuLDOY8U+OXgNUP8HCj3k
	 Y5Gnavy3Qn5VA==
Date: Wed, 29 Apr 2026 07:26:33 -0700
Subject: [PATCH 11/33] fuse: isolate the other regular file IO paths from
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205386.4101881.2569175274476427605.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
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
 fs/fuse/file.c   |   18 +++++++++++++-----
 fs/fuse/inode.c  |    3 ++-
 fs/fuse/iomode.c |    3 ++-
 4 files changed, 26 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 996d81f263d637..1bb0302f7ce8bb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2200,6 +2200,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	FUSE_ARGS(args);
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
 	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
 	loff_t oldsize;
@@ -2257,12 +2258,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -2334,7 +2338,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!is_wb || is_truncate)
 		i_size_write(inode, outarg.attr.size);
 
-	if (is_truncate) {
+	if (is_truncate && !is_iomap) {
 		/* NOTE: this may release/reacquire fi->lock */
 		__fuse_release_nowrite(inode);
 	}
@@ -2358,7 +2362,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 
 error:
-	if (is_truncate)
+	if (is_truncate && !is_iomap)
 		fuse_release_nowrite(inode);
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8d55d2f4dd4cc9..2a807c49792d53 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -257,6 +257,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
@@ -278,7 +279,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			goto out_inode_unlock;
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_set_nowrite(inode);
 
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
@@ -291,7 +292,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			fuse_truncate_update_attr(inode, file);
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
 		if (is_truncate)
@@ -539,12 +540,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
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
@@ -555,7 +558,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (err)
 		goto out;
 
-	fuse_sync_writes(inode);
+	if (need_sync_writes)
+		fuse_sync_writes(inode);
 
 	/*
 	 * Due to implementation of fuse writeback
@@ -579,7 +583,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 		err = 0;
 	}
 out:
-	inode_unlock(inode);
+	if (need_sync_writes)
+		inode_unlock(inode);
 
 	return err;
 }
@@ -2015,6 +2020,9 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
 {
 	struct fuse_file *ff;
 
+	if (fuse_inode_has_iomap(&fi->inode))
+		return NULL;
+
 	spin_lock(&fi->lock);
 	ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
 				      write_entry);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f8e5c03580e56b..3cb2ef161ef7c5 100644
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

