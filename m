Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B534D93B;
	Wed, 29 Apr 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473076; cv=none; b=II0m0QnCAUCK9PNecULmLOZs6+oj8wrnhUAtARNlvIkpatpfDZXUe7Eq03uHv4MS9dwhz9xaINpcOsAv4/qmFcI/Uaz1l5Q19yZwZQVZELu7cllxMe3KiOnyA1QGghoYCdQ5tiEUxRNJggG94k1crbOzTHpudwFhfzLMJRGvxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473076; c=relaxed/simple;
	bh=zDho/Dr0AIxkHYNOEfJwtcTUBgH19HTEPlb/Uxt0seI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCcXA0uHZ+Bo9Ve9kuNls44q5OLxbsNNb57JpQjASPTKWr6BvN4w2blF++iBeUaHRw8oPHJfae6yVvpPRksgY9SCaLQ3TNghjVW50znvrhV+juGFAssjD+AFBVMDkig4JJmDmpLcqJ1cLYgg9+c0pOXGO2CQrYHhQjubth7tz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnUL+Gi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnUL+Gi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472F1C19425;
	Wed, 29 Apr 2026 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473076;
	bh=zDho/Dr0AIxkHYNOEfJwtcTUBgH19HTEPlb/Uxt0seI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DnUL+Gi0MEApoY8BABcYB1JFceSvFYIDdfM2lkiOoakMhHwKHGhiBULRLgfoHYHn/
	 v+JPsS9+6qtiAzRcPi4jUhYni52m5PA+D5LeRHCD0EpNjx0/e8TsIXLYcLfvepFTjX
	 Lo9RhCwH7She6XotHhdINjwA97to65yF6lCeianeJkMCMCWpgHu9ntC6H7bWMFTAFU
	 +s5tID89F9hX2rF0eboyUlsq7mezr3X4jkTvZoy1iyVmhsGGcSTtUlB4iD93e6Kp5/
	 XcWsx1o1vnfovT6ZN2yk7+yzM5iPHDdK4UhhO5W/F1lru0sBntIMXfcc8iqH8Uc9s1
	 4UG9WuTUtShYw==
Date: Wed, 29 Apr 2026 07:31:15 -0700
Subject: [PATCH 29/33] fuse: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205771.4101881.11707084862266764532.stgit@frogsfrogsfrogs>
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

Enable untorn writes of up to a single fsblock, if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    2 ++
 fs/fuse/fuse_iomap.h      |    7 +++++++
 include/uapi/linux/fuse.h |    5 +++++
 fs/fuse/fuse_iomap.c      |   42 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 55 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0d9ac3ff18eedf..c7c7f2e888bb8b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -276,6 +276,8 @@ enum {
 	FUSE_I_EXCLUSIVE,
 	/* Use iomap for this inode */
 	FUSE_I_IOMAP,
+	/* Enable untorn writes */
+	FUSE_I_ATOMIC,
 };
 
 struct fuse_conn;
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 31d6f7b392771c..ca44df00f113d2 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -35,6 +35,13 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline bool fuse_inode_has_atomic(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index aa96b4cbdfa255..c454cea83083d3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -248,6 +248,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -604,11 +605,13 @@ struct fuse_file_lock {
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
+#define FUSE_ATTR_ATOMIC	(1 << 4)
 
 /**
  * Open flags
@@ -1176,6 +1179,8 @@ struct fuse_backing_map {
 
 /* basic file I/O functionality through iomap */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 struct fuse_iomap_support {
 	uint64_t	flags;
 	uint64_t	padding;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 8be8e49605bb85..94ed7c69d892d3 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1114,6 +1114,20 @@ static inline void fuse_inode_clear_iomap(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline void fuse_inode_set_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	set_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
+static inline void fuse_inode_clear_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	ASSERT(get_fuse_conn(inode)->iomap);
@@ -1140,6 +1154,8 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 	}
 
 	fuse_inode_set_iomap(inode);
+	if (attr->flags & FUSE_ATTR_ATOMIC)
+		fuse_inode_set_atomic(inode);
 
 	trace_fuse_iomap_init_inode(inode);
 }
@@ -1150,6 +1166,7 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	trace_fuse_iomap_evict_inode(inode);
 
+	fuse_inode_clear_atomic(inode);
 	fuse_inode_clear_iomap(inode);
 }
 
@@ -1227,6 +1244,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 	ASSERT(fuse_inode_has_iomap(inode));
 
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_inode_has_atomic(inode))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 }
 
 int fuse_iomap_finish_open(const struct fuse_file *ff,
@@ -1438,6 +1457,17 @@ fuse_iomap_write_checks(
 	return kiocb_modified(iocb);
 }
 
+static inline ssize_t fuse_iomap_atomic_write_valid(struct kiocb *iocb,
+						    struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iov_iter_count(from) != i_blocksize(inode))
+		return -EINVAL;
+
+	return generic_atomic_write_valid(iocb, from);
+}
+
 static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
 				       struct iov_iter *from)
 {
@@ -1452,6 +1482,12 @@ static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
 	if (!count)
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = fuse_iomap_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Unaligned direct writes require zeroing of unwritten head and tail
 	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
@@ -1882,6 +1918,9 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
 	if (!iov_iter_count(from))
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return -EOPNOTSUPP;
+
 	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
 	if (ret)
 		return ret;
@@ -2181,7 +2220,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 	struct fuse_iomap_support ios = { };
 
 	if (fuse_iomap_enabled())
-		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
+			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;

