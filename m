Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CC18FDDE;
	Tue, 19 May 2026 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229889; cv=none; b=epxLJUULXeFStvWGO43E5LigUpOB06Ep1M+Liw2vaweKFElWrMiK6l90Gx+TbAvyXGeu1nb+rPKWuq/iybEVQjQ8PtxCQD2Ss0qsrCs1gsLuxu+Rgg85yrScGlfHvAZRxwjBdFpECA7e6xMx3+v2kefDF7j16e6e1UYA/ll2xEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229889; c=relaxed/simple;
	bh=Kx3xFcGO3uBOBTjeh3Z6+KTAq8auscKFKvMhvEtnBsw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY2cuS62wKYB7om6dDERPJbMwNmOez/dT+SuC/Zk/SvhGAX3AwT0wl5+F8CJ7cG7Bx5RGnrgdGPXBXpYKTSEWOFhO28+0yidagMROTxhsy7KU5C6FGmt8B1AdWuT/F8v3d+thDuF2tfgAulzg8NHI23UtfFQpFD5ohK0hoWXL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS+v8uww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS+v8uww"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 45E2C1F000E9;
	Tue, 19 May 2026 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229887;
	bh=VHzsa/rtxynkO2cYQTinsr/cOuGtg1Fo9yMA8ICe4l4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=QS+v8uwwKiL1/URGjOz4WNh4bJwySDB8+VjT2v8Ch2NXRTMEEIEdcmMkbM2Nj12WW
	 jnvsaLPKuom0b4rWTAF5Ba9wjuxF2MtVGDePhCWTZFe1kH50LsZxIYy+Ljyg9L7d5n
	 TazJO49UB2VaA+Xn4A/9Y7bteUcbyfz4dnPxlMBYd2o54BTLiRl+j9JLkdHuasExTM
	 Wn8bcc4Y5tVi+74NByPdHT46Yug+gUQBKpw+FffblcXSsYZlTsPmD4Ni6aiyCZLBGv
	 Lk0R6EN34UYiNi7eH67SJrCZsdqkIDW/k0sbei2uCJAXAQvipOzZSsuJJgLZhJgRZC
	 m0D64Tq/OZcEQ==
Date: Tue, 19 May 2026 15:31:27 -0700
Subject: [PATCH 2/9] fuse: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946220.2439242.8580449245706567958.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new upcall to the fuse server so that the kernel can request
filesystem geometry bits when iomap mode is in use.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    4 +
 fs/fuse/fuse_iomap.h      |    5 +
 include/uapi/linux/fuse.h |   39 ++++++++++
 fs/fuse/fuse_iomap.c      |  175 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   39 +++++++++-
 5 files changed, 257 insertions(+), 5 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 31193345f709b5..ecacfc65e95a99 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1036,6 +1036,9 @@ struct fuse_conn {
 	struct fuse_ring *ring;
 #endif
 
+	/** How many subsystems still need initialization? */
+	atomic_t need_init;
+
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
@@ -1452,6 +1455,7 @@ struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_put(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
+void fuse_finish_init(struct fuse_conn *fc, bool ok);
 
 /**
  * Fill in superblock and initialize fuse connection
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 144ff1a579674d..0635bd8b012e6d 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -21,6 +21,9 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
+int fuse_iomap_mount_sync(struct fuse_mount *fm);
+void fuse_iomap_mount_async(struct fuse_mount *fm);
+
 void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr);
 void fuse_iomap_evict_inode(struct inode *inode);
 
@@ -65,6 +68,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
+# define fuse_iomap_mount_sync(...)		(0)
+# define fuse_iomap_mount_async(...)		((void)0)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
 # define fuse_inode_has_iomap(...)		(false)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 0344ab22411837..867a0bc54f5b93 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -246,6 +246,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -682,6 +683,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1468,4 +1470,41 @@ struct fuse_iomap_ioend_out {
 	uint64_t newsize;	/* new ondisk size */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
+	int64_t maxbytes;	/* maximum supported file size */
+	uint64_t padding[6];	/* zero */
+};
+
+/* Which fields are set in fuse_iomap_config_out? */
+#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
+#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
+#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
+#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
+#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
+#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+
+struct fuse_iomap_config_out {
+	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
+
+	char s_id[32];		/* Informational name */
+	char s_uuid[16];	/* UUID */
+
+	uint8_t s_uuid_len;	/* length of s_uuid */
+
+	uint8_t s_pad[3];	/* must be zeroes */
+
+	uint32_t s_blocksize;	/* fs block size */
+	uint32_t s_max_links;	/* max hard links */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	uint32_t s_time_gran;
+
+	/* Time limits for c/m/atime in seconds */
+	int64_t s_time_min;
+	int64_t s_time_max;
+
+	int64_t s_maxbytes;	/* max file size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 14e86791c4d8f9..06d8832401de8f 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1001,6 +1001,181 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.post_open = fuse_iomap_post_open,
 };
 
+struct fuse_iomap_config_args {
+	struct fuse_args args;
+	struct fuse_iomap_config_in inarg;
+	struct fuse_iomap_config_out outarg;
+};
+
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_SID | \
+			       FUSE_IOMAP_CONFIG_UUID | \
+			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			       FUSE_IOMAP_CONFIG_TIME | \
+			       FUSE_IOMAP_CONFIG_MAXBYTES)
+
+static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
+				     const struct fuse_iomap_config_out *outarg)
+{
+	struct super_block *sb = fm->sb;
+
+	switch (error) {
+	case 0:
+		break;
+	case -ENOSYS:
+		return 0;
+	default:
+		return error;
+	}
+
+	if (BAD_DATA(outarg->flags & ~FUSE_IOMAP_CONFIG_ALL))
+		return -EINVAL;
+
+	if (BAD_DATA(outarg->s_uuid_len > sizeof(outarg->s_uuid)))
+		return -EINVAL;
+
+	if (BAD_DATA(memchr_inv(outarg->s_pad, 0, sizeof(outarg->s_pad))))
+		return -EINVAL;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		if (BAD_DATA(outarg->s_time_gran == 0) ||
+		    BAD_DATA(outarg->s_time_gran > NSEC_PER_SEC))
+			return -EINVAL;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES) {
+		if (BAD_DATA(outarg->s_maxbytes < 0) ||
+		    BAD_DATA(outarg->s_maxbytes > MAX_LFS_FILESIZE))
+			return -EINVAL;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE) {
+		if (BAD_DATA(outarg->s_blocksize > PAGE_SIZE))
+			return -EINVAL;
+
+		if (BAD_DATA(blk_validate_block_size(outarg->s_blocksize) != 0))
+			return -EINVAL;
+
+		if (sb->s_bdev) {
+#ifdef CONFIG_BLOCK
+			if (BAD_DATA(sb_set_blocksize(sb, outarg->s_blocksize) !=
+				     outarg->s_blocksize))
+				return -EINVAL;
+#else
+			/*
+			 * It's not possible to have a bdev filesystem without
+			 * CONFIG_BLOCK, but we'll prevent this weird situation
+			 * anyway.
+			 */
+			BAD_DATA(1);
+			return -EINVAL;
+#endif
+		} else {
+			sb->s_blocksize = outarg->s_blocksize;
+			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
+		}
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_SID) {
+		memcpy(sb->s_id, outarg->s_id, sizeof(sb->s_id));
+		sb->s_id[sizeof(sb->s_id) - 1] = 0;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_UUID) {
+		memcpy(&sb->s_uuid, outarg->s_uuid, outarg->s_uuid_len);
+		sb->s_uuid_len = outarg->s_uuid_len;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		sb->s_max_links = outarg->s_max_links;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		sb->s_time_gran = outarg->s_time_gran;
+		sb->s_time_min = outarg->s_time_min;
+		sb->s_time_max = outarg->s_time_max;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		sb->s_maxbytes = outarg->s_maxbytes;
+
+	return 0;
+}
+
+static void fuse_iomap_config_reply(struct fuse_mount *fm,
+				    struct fuse_args *args, int error)
+{
+	struct fuse_iomap_config_args *ia =
+		container_of(args, struct fuse_iomap_config_args, args);
+	int res;
+
+	res = fuse_iomap_process_config(fm, error, &ia->outarg);
+	if (res)
+		printk(KERN_ERR "%s: could not configure iomap, err=%d",
+		       fm->sb->s_id, res);
+
+	kfree(ia);
+	fuse_finish_init(fm->fc, !res);
+}
+
+static struct fuse_iomap_config_args *
+fuse_iomap_new_mount(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia;
+
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
+	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
+	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
+
+	ia->args.opcode = FUSE_IOMAP_CONFIG;
+	ia->args.nodeid = 0;
+	ia->args.in_numargs = 1;
+	ia->args.in_args[0].size = sizeof(ia->inarg);
+	ia->args.in_args[0].value = &ia->inarg;
+	ia->args.out_argvar = true;
+	ia->args.out_numargs = 1;
+	ia->args.out_args[0].size = sizeof(ia->outarg);
+	ia->args.out_args[0].value = &ia->outarg;
+	ia->args.force = true;
+	ia->args.nocreds = true;
+
+	return ia;
+}
+
+int fuse_iomap_mount_sync(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
+	int err;
+
+	ASSERT(fm->fc->sync_init);
+
+	err = fuse_simple_request(fm, &ia->args);
+	/* Ignore size of iomap_config reply */
+	if (err > 0)
+		err = 0;
+
+	err = fuse_iomap_process_config(fm, err, &ia->outarg);
+	if (err)
+		printk(KERN_ERR "%s: could not configure iomap, err=%d",
+		       fm->sb->s_id, err);
+
+	kfree(ia);
+	fuse_finish_init(fm->fc, !err);
+	return err;
+}
+
+void fuse_iomap_mount_async(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
+	int err;
+
+	ASSERT(!fm->fc->sync_init);
+
+	ia->args.end = fuse_iomap_config_reply;
+	err = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
+	if (err)
+		fuse_iomap_config_reply(fm, &ia->args, -ENOTCONN);
+}
+
 static inline void fuse_inode_set_iomap(struct inode *inode);
 
 static inline void fuse_inode_clear_iomap(struct inode *inode)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c94f47779f9966..781c9cd4ea014e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1391,6 +1391,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_init_out *arg = &ia->out;
 	bool ok = true;
 
+	atomic_inc(&fc->need_init);
+
 	if (error || arg->major != FUSE_KERNEL_VERSION)
 		ok = false;
 	else {
@@ -1546,13 +1548,27 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	}
 	kfree(ia);
 
-	if (!ok) {
+	if (!ok)
 		fc->conn_init = 0;
+
+	if (ok && fc->iomap) {
+		atomic_inc(&fc->need_init);
+		if (!fc->sync_init)
+			fuse_iomap_mount_async(fm);
+	}
+
+	fuse_finish_init(fc, ok);
+}
+
+void fuse_finish_init(struct fuse_conn *fc, bool ok)
+{
+	if (!ok)
 		fc->conn_error = 1;
-	}
 
-	fuse_set_initialized(fc);
-	wake_up_all(&fc->blocked_waitq);
+	if (atomic_dec_and_test(&fc->need_init)) {
+		fuse_set_initialized(fc);
+		wake_up_all(&fc->blocked_waitq);
+	}
 }
 
 static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
@@ -2042,7 +2058,20 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	fm = get_fuse_mount_super(sb);
 
-	return fuse_send_init(fm);
+	err = fuse_send_init(fm);
+	if (err)
+		return err;
+
+	if (fm->fc->conn_init && fm->fc->sync_init && fm->fc->iomap) {
+		err = fuse_iomap_mount_sync(fm);
+		if (err)
+			return err;
+	}
+
+	if (fm->fc->conn_error)
+		return -EIO;
+
+	return 0;
 }
 
 /*

