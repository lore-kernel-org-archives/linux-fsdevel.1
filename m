Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF43C7E15;
	Tue, 19 May 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229702; cv=none; b=uY6+/uyD0QD5U0kO51TIXrN0143rZT9jhhw/I2SCHl+lSjLbV59Vq2auYkjXS4/4QN9DyWbvifZtUqJIBwDCCgATWOWvYkUAolndVaO22JsyJvLUiIh1wmfkbqeCNwGrCay+wrbVhShdXy7R9XY67zRsuaWGqA6PdNapsKM9D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229702; c=relaxed/simple;
	bh=SKrneEXp1zCHgVnagNEydweodi8qU2GqlDIBYhF37Cw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emQv5ydMV0pAFtssuP0gedFltg3LZeEh9tKTkCp2UkTNGLv04X2lsCcbjOr6RW+gpje0TWGpgwIEgrM5CSCWUn5KxrSKeV5GnRZXZgLB2G8AzWuOn9CjMW9O0CFEAl+pf/lQ1HzYutvWRK0Xnf2ZMvUgp1eAjuyNltgV342Lm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbh7zBIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbh7zBIL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CA0C91F000E9;
	Tue, 19 May 2026 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229700;
	bh=wXCbQ4Oo80WpmzcUDeSvD0Io4GSMY0LfBfwHVvo3qaA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=fbh7zBILsd4yljkzOCk4oigBkHtTeQfBTIYv96YuAF2JCAXXCJc/Px0b+M6Mlckgq
	 M8bLMSBm8zgYfdiiDsOa/Ps2H7jtM16e1wYOFtL/3kvKeDvQVa1i9NMcOW7wGjdQ6l
	 qi4l6Y+3wxF0R0C15jj7cis45AUQ/4aJGEddI+wL/szpduD4AEizBOEAgySfP+bPMq
	 sHZLnLC8om9CUsU5e0vce3yqhwfn+Q7vApIm22mzrHXGOy8pwrJR2Pq8tb+TiDW8jx
	 clb3S4BwUXq2v3n7fRXCpFeLwE4+0cJ1J1g5ncf6obdn2X4ak/L+VTcts6NjoJme6d
	 xY8wFC/RhcKbQ==
Date: Tue, 19 May 2026 15:28:20 -0700
Subject: [PATCH 07/11] fuse: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945391.2436837.16330555348391143708.stgit@frogsfrogsfrogs>
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

Create a per-inode flag to control whether or not this inode actually
uses iomap.  This is required for non-regular files because iomap
doesn't apply there; and enables fuse filesystems to provide some
non-iomap files if desired.

Note that more code will be added to fuse_iomap_init_inode in subsequent
patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h          |   18 +++++++++++-
 fs/fuse/fuse_iomap.h      |   13 +++++++++
 include/uapi/linux/fuse.h |    6 ++++
 fs/fuse/dir.c             |   14 ++++++++--
 fs/fuse/file.c            |    3 ++
 fs/fuse/fuse_iomap.c      |   66 +++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/inode.c           |    6 +++-
 7 files changed, 114 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 822b77da7a144c..4ffdb2b9c39129 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -266,6 +266,8 @@ enum {
 	 * or the fuse server has an exclusive "lease" on distributed fs
 	 */
 	FUSE_I_EXCLUSIVE,
+	/* Use iomap for this inode */
+	FUSE_I_IOMAP,
 };
 
 struct fuse_conn;
@@ -658,6 +660,13 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+#ifdef CONFIG_FUSE_IOMAP
+struct fuse_iomap_conn {
+	/**  number of inodes that have iomap enabled */
+	atomic64_t inodes;
+};
+#endif
+
 /**
  * A Fuse connection.
  *
@@ -1019,6 +1028,11 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
+
+#ifdef CONFIG_FUSE_IOMAP
+	/** iomap information */
+	struct fuse_iomap_conn iomap_conn;
+#endif
 };
 
 /*
@@ -1258,12 +1272,12 @@ void fuse_init_common(struct inode *inode);
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
index 43562ef23fb325..66a95e8635339a 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -20,9 +20,22 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 }
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
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
+# define fuse_iomap_init_inode(...)		((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_inode_has_iomap(...)		(false)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7f4a7b7ba1e613..9cf63b4c4a3e9d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,6 +245,7 @@
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -589,10 +590,15 @@ struct fuse_file_lock {
  *     kernel can use cached attributes more aggressively (e.g. ACL
  *     inheritance).  Must be set in the initial LOOKUP/GETATTR response.
  *     Cannot be cleared.
+ * FUSE_ATTR_IOMAP: Use iomap for this inode.  Must be set in the initial
+ *     LOOKUP/GETATTR response, and only for regular files.  Cannot be cleared.
+ *     This flag supplies FUSE_ATTR_EXCLUSIVE.
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
+#define __FUSE_ATTR_IOMAP	(1 << 3)
+#define FUSE_ATTR_IOMAP		(FUSE_ATTR_EXCLUSIVE | __FUSE_ATTR_IOMAP)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 572a764a5eb803..ca201ce3499040 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2517,9 +2518,10 @@ void fuse_init_common(struct inode *inode)
 	inode->i_op = &fuse_common_inode_operations;
 }
 
-void fuse_init_dir(struct inode *inode)
+void fuse_init_dir(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_op = &fuse_dir_inode_operations;
 	inode->i_fop = &fuse_dir_operations;
@@ -2529,6 +2531,9 @@ void fuse_init_dir(struct inode *inode)
 	fi->rdc.size = 0;
 	fi->rdc.pos = 0;
 	fi->rdc.version = 0;
+
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 }
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
@@ -2547,9 +2552,14 @@ static const struct address_space_operations fuse_symlink_aops = {
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
index ea11a47e773b6c..3e8eb9642f1adb 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -507,10 +507,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	}
 
 	/*
-	 * XXX: if we ever want to support closing devices, we need a way to
-	 * track the fuse_backing refcount all the way through bio endios.
-	 * For now we put the refcount here because you can't remove an iomap
-	 * device until unmount time.
+	 * It's ok to put the refcount here because you can't remove an iomap
+	 * device unless there are zero iomap inodes.
 	 */
 out_write_dev:
 	fuse_backing_put(write_dev);
@@ -620,8 +618,13 @@ static int fuse_iomap_post_open(struct fuse_conn *fc, struct fuse_backing *fb)
 static int fuse_iomap_may_close(struct fuse_conn *fc,
 				const struct fuse_backing *fb)
 {
-	/* We only support closing iomap block devices at unmount */
-	return -EBUSY;
+	/*
+	 * It's only safe to close the iomap backing device if there are no
+	 * iomap inodes that might be using it or have IO in progress.
+	 */
+	if (atomic64_read(&fc->iomap_conn.inodes) > 0)
+		return -EBUSY;
+	return 0;
 }
 
 const struct fuse_backing_ops fuse_iomap_backing_ops = {
@@ -633,3 +636,54 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.may_close = fuse_iomap_may_close,
 	.post_open = fuse_iomap_post_open,
 };
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+
+	set_bit(FUSE_I_IOMAP, &fi->state);
+	atomic64_inc(&fm->fc->iomap_conn.inodes);
+}
+
+static inline void fuse_inode_clear_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+
+	atomic64_dec(&fm->fc->iomap_conn.inodes);
+	clear_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
+{
+	ASSERT(get_fuse_conn(inode)->iomap);
+
+	if (!(attr->flags & __FUSE_ATTR_IOMAP))
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
index 3ba80514bd59eb..59113da7d31f5e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -198,6 +198,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
 
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_evict_inode(inode);
 	fuse_inode_clear_exclusive(inode);
 }
 
@@ -455,10 +457,10 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
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

