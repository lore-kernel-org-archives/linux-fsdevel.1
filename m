Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3C3ACEE2;
	Tue, 19 May 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229593; cv=none; b=oIdw6zNMTw9FWTRw/CiikbPemDw1YqWtGTUsPgaUNl5xvsy54jAvbVlBEhRnRIlBmlA8/9jdTNjrz9N4uTcjsDMofMu4HBOFELQzqhMdkUpl1cVl9NXD4wt0AmsevRgSauGmy0x//hkqUDiQlhOEwyOyBaG+3BzQFHNjtJ4CXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229593; c=relaxed/simple;
	bh=l37kGo7lf8+EG5n/kuM3L1daPXlzThzJyTUl5Zf0pgQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4vcZGLhI1Unhb4/dmMjzOUVfgauzSUqlUGUh3PYJUgKRGB/XdApTPQWYTprbDLAe2YyjcvXIMtrDraHV1u6qhbetGkrn2upfYUTWquZTx68yGeVmJRD9fSBYH/Gqar5VDtU+h7sm2yZBaFYCYU+OzEuw/8/AfRKca2Do3U/Za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsLKL43I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsLKL43I"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E12881F00893;
	Tue, 19 May 2026 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229592;
	bh=9jGw67sdqzenjIKypdr1omejKDfLOdla1xn0iuaJKsU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=IsLKL43IkqCfqcVxfgiobJoijejhFwol9PO2yBP5w0GkR0se3YN+T9rLujbS1t/Hy
	 rwNZfAMt+GobSkvvLUyXWZqmnMGSWqDQBNYj9Xl7DOvHcaO2XH8EC76mA+q8FXSjHA
	 TgNZR5YhttfWlm5H0H7Ai+Q8qMJrABbq6TQl4xrgY9YyYmAd/KzVZ/OgKvnvJXC7JE
	 qxJyF0oT0aWM09Ia2sibD3mTwNh3AI/7ngpPHDL3MZKEX9U+2RU2CPuOkV9OGUjcL8
	 NRCJgXXLIpS93u/PkCjp+jISjcLnmuJyY0ly9Q3uqdevQvEaiwL8CDtBrpgeEAU8ws
	 8ZD0N4uojlYtQ==
Date: Tue, 19 May 2026 15:26:31 -0700
Subject: [PATCH 4/4] fuse: clean up per-file type inode initialization
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922944908.2436629.11613259519544206776.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Clean up the per-filetype inode initialization in fuse_init_inode before
we start adding more functionality here.  Primarily this consists of
refactoring to use a switch statement and passing the file attr struct
around.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 +-
 fs/fuse/file.c   |    5 +++--
 fs/fuse/inode.c  |   36 +++++++++++++++++++++++++-----------
 3 files changed, 29 insertions(+), 14 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b0a11a31bb5955..de27949d31a72a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1226,7 +1226,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 /**
  * Initialize file operations on a regular file
  */
-void fuse_init_file_inode(struct inode *inode, unsigned int flags);
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Initialize inode operations on regular files and special files
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8da0..5e7fe7ef87d2e4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3199,11 +3199,12 @@ static const struct address_space_operations fuse_file_aops  = {
 	.direct_IO	= fuse_direct_IO,
 };
 
-void fuse_init_file_inode(struct inode *inode, unsigned int flags)
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	fuse_init_common(inode);
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
 	if (fc->writeback_cache)
@@ -3217,5 +3218,5 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	init_waitqueue_head(&fi->direct_io_waitq);
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
-		fuse_dax_inode_init(inode, flags);
+		fuse_dax_inode_init(inode, attr->flags);
 }
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c04d9ae42bb008..afaabc1734d8cf 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -421,6 +421,12 @@ static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
 	refcount_set(&sl->count, 1);
 }
 
+static void fuse_init_special(struct inode *inode, struct fuse_attr *attr)
+{
+	fuse_init_common(inode);
+	init_special_inode(inode, inode->i_mode, new_decode_dev(attr->rdev));
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -428,20 +434,28 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode->i_size = attr->size;
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
-	if (S_ISREG(inode->i_mode)) {
-		fuse_init_common(inode);
-		fuse_init_file_inode(inode, attr->flags);
-	} else if (S_ISDIR(inode->i_mode))
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		fuse_init_file_inode(inode, attr);
+		break;
+	case S_IFDIR:
 		fuse_init_dir(inode);
-	else if (S_ISLNK(inode->i_mode))
+		break;
+	case S_IFLNK:
 		fuse_init_symlink(inode);
-	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-		fuse_init_common(inode);
-		init_special_inode(inode, inode->i_mode,
-				   new_decode_dev(attr->rdev));
-	} else
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		fuse_init_special(inode, attr);
+		break;
+	default:
 		BUG();
+		break;
+	}
+
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.

