Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C622301;
	Wed, 29 Apr 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473232; cv=none; b=ZnKznpH70BFS2H5TAEI06AXNQCrE3SaZaRGK73PlUKc4kgA0DR3kFfGXpQcyIa8ndyXLeYOAacu6U997kCPtyPruWRUf7AckZrezggfww4DkXxUH6isHyHSuPecuFemOefrDKWumczuBjxc5aoHYjxN06C0VIBSWj4UyQ7d2APY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473232; c=relaxed/simple;
	bh=eDmlvNxQCN5NyeynZDVrzpZRN/RJm1tGyYOs6W6vmnI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flCklQvAV+yw30QXSLB0BUuQQAZWg0D+2LnzcJlU9MEi4125kmMAyW/cGckPRkcIvRby1c633DhU4lQThtcpH+Ojvf50K4xlg6yIs121Y/t8qQisPHE1Wkw8Evf2sMzCATXVawaUmL+ucroDFpc2RVNkJLf3p3MmnVgiRwZFJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDYmZXVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDYmZXVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE6AC2BCB8;
	Wed, 29 Apr 2026 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473232;
	bh=eDmlvNxQCN5NyeynZDVrzpZRN/RJm1tGyYOs6W6vmnI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XDYmZXVfZzyZb9gXhTmV9+Mw3ofw9vyg4jrKzIKktvcmAJVQCArRrdH9ALhDGSFCe
	 H16ouuqpot5KetaNbIWseymT7sk+GHvxvXVX+9d472xL3MFYgjXDACpmQxqdHs3jhw
	 A8VOL4ctmnj0zZ/K1vJLF9PAmT5BX7sN/AQ+9SyRiJRJZbjzkR86RuMTqs0KoT9tTh
	 tMmsxHDDgZJZWfYub1EiNrUHJCMsY4K0sM3qsaRwLKzMJN58bJ+DK5cVmwsp8hfzom
	 v9tHxHIXmAlXVIpUfp0bcl09tUU5Vo7fW2+KjzlkMGGBnc3H1qdCAZ5XEECE28TDy/
	 whd1/yw+ROksw==
Date: Wed, 29 Apr 2026 07:33:51 -0700
Subject: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206552.4103309.6736684975553576273.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

There are three inode flags (immutable, append, sync) that are enforced
by the VFS.  Whenever we go around setting iflags, let's update the VFS
state so that they actually work.  Make it so that the fuse server can
set these three inode flags at load time and have the kernel advertise
and enforce them.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    1 +
 include/uapi/linux/fuse.h |    8 +++++++
 fs/fuse/dir.c             |    1 +
 fs/fuse/inode.c           |    1 +
 fs/fuse/ioctl.c           |   50 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 95b37f4660cc1d..3b38b98dc0096c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1651,6 +1651,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct file_kattr *fa);
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b6fa828776b82f..bf8514a5ee27af 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -249,6 +249,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -606,12 +608,18 @@ struct fuse_file_lock {
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
  * FUSE_ATTR_ATOMIC: Enable untorn writes
+ * FUSE_ATTR_SYNC: File writes are synchronous
+ * FUSE_ATTR_IMMUTABLE: File is immutable
+ * FUSE_ATTR_APPEND: File is append-only
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
 #define FUSE_ATTR_ATOMIC	(1 << 4)
+#define FUSE_ATTR_SYNC		(1 << 5)
+#define FUSE_ATTR_IMMUTABLE	(1 << 6)
+#define FUSE_ATTR_APPEND	(1 << 7)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 11898102adefe2..53fda7f63b11c8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1450,6 +1450,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
+	generic_fill_statx_attr(inode, stat);
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2513ea108ff9a8..aa9f880b9a2ea6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -544,6 +544,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
+		fuse_fileattr_init(inode, attr);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 07529db21fb781..bd2caf191ce2e0 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -502,6 +502,53 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
 	fuse_file_release(inode, ff, O_RDONLY, NULL, S_ISDIR(inode->i_mode));
 }
 
+static inline void update_iflag(struct inode *inode, unsigned int iflag,
+				bool set)
+{
+	if (set)
+		inode->i_flags |= iflag;
+	else
+		inode->i_flags &= ~iflag;
+}
+
+static void fuse_fileattr_update_inode(struct inode *inode,
+				       const struct file_kattr *fa)
+{
+	unsigned int old_iflags = inode->i_flags;
+
+	if (!fuse_inode_is_exclusive(inode))
+		return;
+
+	if (fa->flags_valid) {
+		update_iflag(inode, S_SYNC, fa->flags & FS_SYNC_FL);
+		update_iflag(inode, S_IMMUTABLE, fa->flags & FS_IMMUTABLE_FL);
+		update_iflag(inode, S_APPEND, fa->flags & FS_APPEND_FL);
+	} else if (fa->fsx_valid) {
+		update_iflag(inode, S_SYNC, fa->fsx_xflags & FS_XFLAG_SYNC);
+		update_iflag(inode, S_IMMUTABLE,
+					fa->fsx_xflags & FS_XFLAG_IMMUTABLE);
+		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
+	}
+
+	if (old_iflags != inode->i_flags)
+		fuse_invalidate_attr(inode);
+}
+
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
+{
+	if (!fuse_inode_is_exclusive(inode))
+		return;
+
+	if (attr->flags & FUSE_ATTR_SYNC)
+		inode->i_flags |= S_SYNC;
+
+	if (attr->flags & FUSE_ATTR_IMMUTABLE)
+		inode->i_flags |= S_IMMUTABLE;
+
+	if (attr->flags & FUSE_ATTR_APPEND)
+		inode->i_flags |= S_APPEND;
+}
+
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
@@ -572,7 +619,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
+		if (err)
+			goto cleanup;
 	}
+	fuse_fileattr_update_inode(inode, fa);
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);

