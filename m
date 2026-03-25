Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BF279DC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420656; cv=none; b=Jj/v0HLDts67yT1Jy+cAJgr7rI5/hVmCBXnx52sA0QCNtGYhOgj427c/4XLx9mAXxgxWlg9aTPhXYI6X5+acokeb8itwlqL5ly4LfovS0bOmTZcRvHqu+XTh04nZPIBIhOBpRWfLTq8TDB0mGViHuaqIjUJQ6wIVVS6tLHLMA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420656; c=relaxed/simple;
	bh=HdrKBmMDA6oCqhCuV7vi9/BQtIl4pZNfU9SWCgBhGI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSIr9lQtBJtyyUWcdDqwaO68MDXc51VUCUMpwHScnztBR1he/mUtjp4Kv8OjLfi3El6pLoI8Q+VxoQVck2QNTjeoMiJ0LmpGYFf1ixm0OKfU8WPPTft1mmpd8KvbMEYl5eZUkbvsw/HSyQAVnm13dJo4mO1dMQOg2Q517ujT4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yexasdyB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yexasdyB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NzsYuJODTFiPULELs3ydRb+fz02eDrbwXutrFNARfk4=; b=yexasdyBKDbw2UzQuBDax3y85C
	r7WRdBqeMNXIRHPXu1DpRZhycVeQZQec8AqBSXh7dJAPUDpU1THdSyMruW5YB/r7JhzOV6tmSX0zx
	OgC7ubczMUxZQ5G4aYmQLFG2J3JHyJO9I7X7PwENdUyGb4NnzMbAijybq81BynKfZa846l9ROElJu
	VTAMCHE+i+G36uI1X8Ew43BoJIb9JXKMFl/Etv4sRwy1niPYZz/JPxBFJvcbO42RiYVcCbw+b1qvq
	lRD9OPfH74h3BfjDkaatPg4UafXFYkjyg2xrX6esEqi3Fx6Pt4rvbvN37hIxiqgURX5T8WbC4DAtN
	5BbR+Trw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Hrx-00000002nNa-1B0V;
	Wed, 25 Mar 2026 06:37:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] affs: rename affs_notify_change to affs_setattr
Date: Wed, 25 Mar 2026 07:36:50 +0100
Message-ID: <20260325063711.3298685-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325063711.3298685-1-hch@lst.de>
References: <20260325063711.3298685-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Make the function name match the method that it implements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/affs/affs.h    | 2 +-
 fs/affs/dir.c     | 2 +-
 fs/affs/file.c    | 2 +-
 fs/affs/inode.c   | 5 ++---
 fs/affs/symlink.c | 2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index ac4e9a02910b..43e20b02b449 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -184,7 +184,7 @@ extern int	affs_rename2(struct mnt_idmap *idmap,
 /* inode.c */
 
 extern struct inode		*affs_new_inode(struct inode *dir);
-extern int			 affs_notify_change(struct mnt_idmap *idmap,
+extern int			 affs_setattr(struct mnt_idmap *idmap,
 					struct dentry *dentry, struct iattr *attr);
 extern void			 affs_evict_inode(struct inode *inode);
 extern struct inode		*affs_iget(struct super_block *sb,
diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index 5c8d83387a39..c53b98f7c687 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -71,7 +71,7 @@ const struct inode_operations affs_dir_inode_operations = {
 	.mkdir		= affs_mkdir,
 	.rmdir		= affs_rmdir,
 	.rename		= affs_rename2,
-	.setattr	= affs_notify_change,
+	.setattr	= affs_setattr,
 };
 
 static int
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 6c9258359ddb..cede4bb1134e 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -1013,5 +1013,5 @@ const struct file_operations affs_file_operations = {
 };
 
 const struct inode_operations affs_file_inode_operations = {
-	.setattr	= affs_notify_change,
+	.setattr	= affs_setattr,
 };
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0bfc7d151dcd..f660e76584b3 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -213,13 +213,12 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 int
-affs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
-		   struct iattr *attr)
+affs_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	pr_debug("notify_change(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
+	pr_debug("setattr(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
 
 	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index 094aec8d17b8..af6147e1d975 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -71,5 +71,5 @@ const struct address_space_operations affs_symlink_aops = {
 
 const struct inode_operations affs_symlink_inode_operations = {
 	.get_link	= page_get_link,
-	.setattr	= affs_notify_change,
+	.setattr	= affs_setattr,
 };
-- 
2.47.3

