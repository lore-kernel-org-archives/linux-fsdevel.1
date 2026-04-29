Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE032ED34;
	Wed, 29 Apr 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472763; cv=none; b=spqG2nmDXp+MM51051sw//+hfmA0TmpmFYoBCCov7SMDliqUloe5vL7i5fKtIWsh8LmgADhWefKSpFD998uBQqWSR/5gpMcuJJbK1tvl7sDpYt9OQ06XY5XofxBghn5j27hx5vqKpvrPglMgonYRWat29scq5z41lRzdNQqu4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472763; c=relaxed/simple;
	bh=7cTEVlL3qkzN3EPmpg/M7EbdhM5HOiEWpUNWVTQC/8o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CslbymjmmQrgKjZ+TtM6lanW+qOhs3f24ZkrXgSDZLXp+x1hfgxwZxDRXENVzsD8w3iuiCj3Wj30QUmIpmjBlDXK2PTQg30oijLVz7/jKYa0Q6KVyGZnIFCweq8IXdX2qnUoN13yQ9L817t56mI8VSLGD8Yw1P2PGiamcUGPmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFH8rpme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFH8rpme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DDEC2BCB8;
	Wed, 29 Apr 2026 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472762;
	bh=7cTEVlL3qkzN3EPmpg/M7EbdhM5HOiEWpUNWVTQC/8o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nFH8rpme59PyY01KoK/T9WcZTqRPZREDMDlYOrliynIDoGI84O0AIwunXIgwiEVNr
	 vC1OGOLvwXAsxebqw4BzQiu+WgzkAD5WmRY9arF+7dICTPmbgAk6SWkAbaagOBLj+g
	 Ri7KeYhhH2gLDq5wz+oDu/4JrDQCCTXmUn0AgK5s1r1bfhXxeNT0BAjoH/ZjWaC0ls
	 q0kyCbE+QWEKIcRsOVUEq6c+6pf9HQabpRdjm0Dp8kkJLZmxiMo3uMQSmoBUTFUGqm
	 b+cz3rZWAp395zZvQ9ZT8buIVn9/aoZ0dZeKYdK5D5v8PWu/pSdvHUvXSIu7O7Txc7
	 mvG5PoJ+nKYSQ==
Date: Wed, 29 Apr 2026 07:26:02 -0700
Subject: [PATCH 09/33] fuse: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205343.4101881.1445722009300775395.stgit@frogsfrogsfrogs>
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

Create a per-inode flag to control whether or not this inode actually
uses iomap.  This is required for non-regular files because iomap
doesn't apply there; and enables fuse filesystems to provide some
non-iomap files if desired.

Note that more code will be added to fuse_iomap_init_inode in subsequent
patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h          |    6 ++++--
 fs/fuse/fuse_iomap.h      |   13 ++++++++++++
 include/uapi/linux/fuse.h |    3 +++
 fs/fuse/dir.c             |   14 +++++++++++--
 fs/fuse/file.c            |    3 +++
 fs/fuse/fuse_iomap.c      |   47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    6 ++++--
 7 files changed, 86 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 07ad5abc48f70f..a4d64fd2837778 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -264,6 +264,8 @@ enum {
 	 * or the fuse server has an exclusive "lease" on distributed fs
 	 */
 	FUSE_I_EXCLUSIVE,
+	/* Use iomap for this inode */
+	FUSE_I_IOMAP,
 };
 
 struct fuse_conn;
@@ -1256,12 +1258,12 @@ void fuse_init_common(struct inode *inode);
 /**
  * Initialize inode and file operations on a directory
  */
-void fuse_init_dir(struct inode *inode);
+void fuse_init_dir(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Initialize inode operations on a symlink
  */
-void fuse_init_symlink(struct inode *inode);
+void fuse_init_symlink(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Change attributes of an inode
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 129680b056ebea..34f2c75416eb62 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -23,11 +23,24 @@ extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
 void fuse_iomap_mount(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
+
+void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr);
+void fuse_iomap_evict_inode(struct inode *inode);
+
+static inline bool fuse_inode_has_iomap(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_IOMAP, &fi->state);
+}
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_mount(...)			((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
+# define fuse_iomap_init_inode(...)		((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_inode_has_iomap(...)		(false)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2d35dcfbf8aaf5..88f76f4be749a7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,6 +245,7 @@
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -587,10 +588,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
+#define FUSE_ATTR_IOMAP		(1 << 3)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c5c97065984557..996d81f263d637 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2514,9 +2515,10 @@ void fuse_init_common(struct inode *inode)
 	inode->i_op = &fuse_common_inode_operations;
 }
 
-void fuse_init_dir(struct inode *inode)
+void fuse_init_dir(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_op = &fuse_dir_inode_operations;
 	inode->i_fop = &fuse_dir_operations;
@@ -2526,6 +2528,9 @@ void fuse_init_dir(struct inode *inode)
 	fi->rdc.size = 0;
 	fi->rdc.pos = 0;
 	fi->rdc.version = 0;
+
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 }
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
@@ -2544,9 +2549,14 @@ static const struct address_space_operations fuse_symlink_aops = {
 	.read_folio	= fuse_symlink_read_folio,
 };
 
-void fuse_init_symlink(struct inode *inode)
+void fuse_init_symlink(struct inode *inode, struct fuse_attr *attr)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
 	inode->i_op = &fuse_symlink_inode_operations;
 	inode->i_data.a_ops = &fuse_symlink_aops;
 	inode_nohighmem(inode);
+
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5e7fe7ef87d2e4..8d55d2f4dd4cc9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -3217,6 +3218,8 @@ void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
 
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, attr->flags);
 }
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 4b63bb32167877..39c9239c64435a 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -616,3 +616,50 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
 	fuse_flush_requests(fc);
 	fuse_send_destroy(fm);
 }
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	set_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+static inline void fuse_inode_clear_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
+{
+	ASSERT(get_fuse_conn(inode)->iomap);
+
+	if (!(attr->flags & FUSE_ATTR_IOMAP))
+		return;
+
+	/*
+	 * Any file being used in conjunction with iomap must also have the
+	 * exclusive flag set because iomap requires cached file attributes to
+	 * be correct at any time.  This applies even to non-regular files
+	 * (e.g. directories) because we need to do ACL and attribute
+	 * inheritance the same way a local filesystem would do.  If exclusive
+	 * mode isn't set, then we won't use iomap.
+	 */
+	if (!fuse_inode_is_exclusive(inode)) {
+		ASSERT(fuse_inode_is_exclusive(inode));
+		return;
+	}
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	fuse_inode_set_iomap(inode);
+}
+
+void fuse_iomap_evict_inode(struct inode *inode)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_inode_clear_iomap(inode);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 36814b5de46879..f8e5c03580e56b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -198,6 +198,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
 
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_evict_inode(inode);
 	fuse_inode_clear_exclusive(inode);
 }
 
@@ -446,10 +448,10 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 		fuse_init_file_inode(inode, attr);
 		break;
 	case S_IFDIR:
-		fuse_init_dir(inode);
+		fuse_init_dir(inode, attr);
 		break;
 	case S_IFLNK:
-		fuse_init_symlink(inode);
+		fuse_init_symlink(inode, attr);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:

