Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37134DCD2;
	Wed, 29 Apr 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473530; cv=none; b=tT70W272LZ3BCsLiWu+YqJfqGOY1d90Gi2N2xZCtyWZ5svl2Zj1M3+jxOcG0mFw6M/C+wePCCi75NU6J8UT8aG1xzuH1AWgGgUwHv9qjHdYqkM9VyiXz7XT0Jc1P8lvbBSAwgIRw9GjgaKz0/8Zx6as967FN1GIbY4tgsUZwkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473530; c=relaxed/simple;
	bh=NL6tidfVaH7kJOMKuOTyNN9p0Wh4R+ObRWblADbMau8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCbC6FIWRTJc9hThWgtz3ERq1EJSKpVDSNqvp7+RaxZieCnbZeSPs150ArSuG5lpy47swkaK1+H8GDO5utsjCI6+6G88f2qsCXxVx5QitzNE5aVETP/JZesfaHY7sNk+tNSASGHSW1vEbxjPg46IK/gtn3i6Bd7P3ZmcykD13t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXgZQyKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXgZQyKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96097C19425;
	Wed, 29 Apr 2026 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473529;
	bh=NL6tidfVaH7kJOMKuOTyNN9p0Wh4R+ObRWblADbMau8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iXgZQyKQjAaa1592eCt+AcR/d+ROhtHlvz67Zy9fOxRIp1Y7lKG31JTVZUX2p5XyD
	 eofSLOTwB8S8J/ItbIgMyJjUv53svP+W1tq2mhqYAWaTk7LM+6GLxlyS6xw+nkwmAB
	 a70f82cGC9TeB9HM0ip4KbwBPRp0T6z9ehgE+eQiuDprMnKrLgBeU+Kl2zzz1o1/H1
	 PWytuIGri922OL1/Q/k/HBwQUhJrUvET2iiCEapzgVTcgeY+vuidE+Qo/76P+moRSI
	 RqmyR/JJFDNne0eRHLLeNjpHTumRbbZ3TgevokKOhSUwXbnxNEmx1XVYP9RB3mJECs
	 t7NnT5TWX0g3A==
Date: Wed, 29 Apr 2026 07:38:49 -0700
Subject: [PATCH 1/2] fuse: allow privileged mount helpers to pre-approve iomap
 usage
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207517.4104197.2708127799087809184.stgit@frogsfrogsfrogs>
In-Reply-To: <177747207487.4104197.2228921108809032839.stgit@frogsfrogsfrogs>
References: <177747207487.4104197.2228921108809032839.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

For the upcoming safemount functionality in libfuse, we will create a
privileged "mount.safe" helper that starts the fuse server in a
completely unprivileged systemd container.  The mount helper will pass
the mount options and fds for /dev/fuse and any other files requested by
the fuse server into the container via a Unix socket.

Currently, the ability to turn on iomap for fuse depends on a module
parameter and the process that calls mount() having the CAP_SYS_RAWIO
capability.  However, the unprivilged fuse server might want to query
the /dev/fuse fd for iomap capabilities before mount or FUSE_INIT so
that it can get ready.

Similar to FUSE_DEV_SYNC_INIT, add a new bit for iomap that can be
squirreled away in file->private_data and an ioctl to set that bit.
That way the privileged mount helper can pass its iomap privilege to the
contained fuse server without the fuse server needing to have
CAP_SYS_RAWIO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   10 ++++++++++
 fs/fuse/fuse_iomap.h      |    2 ++
 include/uapi/linux/fuse.h |    1 +
 fs/fuse/dev.c             |    2 ++
 fs/fuse/fuse_iomap.c      |   32 ++++++++++++++++++++++++++++++--
 fs/fuse/inode.c           |    7 +++++--
 6 files changed, 50 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 91f399a7a9a990..a491b80c2afacf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -623,6 +623,9 @@ struct fuse_dev {
 	/** Issue FUSE_INIT synchronously */
 	bool sync_init;
 
+	/** Allow fuse server to ask for IOMAP */
+	bool may_iomap;
+
 	/** Fuse connection for this device */
 	struct fuse_conn *fc;
 
@@ -981,6 +984,13 @@ struct fuse_conn {
 	/* Enable fs/iomap for file operations */
 	unsigned int iomap:1;
 
+	/*
+	 * Are filesystems using this connection allowed to use iomap?  This is
+	 * determined by the privilege level of the process that initiated the
+	 * mount() call.
+	 */
+	unsigned int may_iomap:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 79625897dded50..636d75e44cda82 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -72,6 +72,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 				  u64 written);
 
+int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
@@ -109,6 +110,7 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_iomap_copied_file_range(...)	((void)0)
+# define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 035e1a59ce50d3..1132493c66d266 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1212,6 +1212,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fcee1a23375cee..fc2875cfffdb3b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2789,6 +2789,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_support(file, argp);
 	case FUSE_DEV_IOC_SET_NOFS:
 		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
+	case FUSE_DEV_IOC_ADD_IOMAP:
+		return fuse_dev_ioctl_add_iomap(file);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 8d3c7273dda810..3c2821c5f74c03 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -10,6 +10,7 @@
 #include <linux/fadvise.h>
 #include <linux/swap.h>
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
@@ -80,6 +81,12 @@ bool fuse_iomap_enabled(void)
 	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
 }
 
+static inline bool fuse_iomap_may_enable(void)
+{
+	/* Same as above, but this time we log the denial in audit log */
+	return enable_iomap && capable(CAP_SYS_RAWIO);
+}
+
 /* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
 #define XMAP(word) \
 	case IOMAP_##word: \
@@ -2537,14 +2544,35 @@ fuse_iomap_fallocate(
 	return 0;
 }
 
+int fuse_dev_ioctl_add_iomap(struct file *file)
+{
+	int err = -EINVAL;
+	struct fuse_dev *fud = fuse_file_to_fud(file);
+
+	mutex_lock(&fuse_mutex);
+	if (!fuse_dev_fc_get(fud)) {
+		fud->may_iomap = true;
+		err = 0;
+	}
+	mutex_unlock(&fuse_mutex);
+	return err;
+}
+
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp)
 {
 	struct fuse_iomap_support ios = { };
+	struct fuse_dev *fud = fuse_file_to_fud(file);
+	struct fuse_conn *fc;
 
-	if (fuse_iomap_enabled())
+	mutex_lock(&fuse_mutex);
+	fc = fuse_dev_fc_get(fud);
+	if ((fc && fc != FUSE_DEV_FC_DISCONNECTED && fc->may_iomap) ||
+	    (!fc && fud->may_iomap) ||
+	    fuse_iomap_enabled())
 		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
 			    FUSE_IOMAP_SUPPORT_ATOMIC;
+	mutex_unlock(&fuse_mutex);
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;
@@ -2615,7 +2643,7 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 
 static inline bool can_set_nofs(struct fuse_dev *fud)
 {
-	if (fud && fud->fc && fud->fc->iomap)
+	if (fud && fud->fc && (fud->fc->iomap || fud->fc->may_iomap))
 	       return true;
 
 	return capable(CAP_SYS_RESOURCE);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1a09b9e1446919..ca7981c38d5a1c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1076,6 +1076,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 	fc->root_nodeid = FUSE_ROOT_ID;
+	fc->may_iomap = fuse_iomap_enabled();
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1610,7 +1611,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
 
-			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
+			if ((flags & FUSE_IOMAP) && fc->may_iomap) {
 				fc->iomap = 1;
 				pr_warn(
  "EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
@@ -1697,7 +1698,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	 */
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
-	if (fuse_iomap_enabled())
+	if (fm->fc->may_iomap)
 		flags |= FUSE_IOMAP;
 
 	ia->in.flags = flags;
@@ -2093,6 +2094,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 			goto err_unlock;
 		if (fud->sync_init)
 			fc->sync_init = 1;
+		if (fud->may_iomap)
+			fc->may_iomap = 1;
 	}
 
 	err = fuse_ctl_add_conn(fc);

