Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2F352013;
	Tue, 19 May 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229951; cv=none; b=Fq4a8Jg43kBu1FTYrPF0JEZiAH53nR/NQTWmePv1OzQS3/kuemHIZJGtFtuePULTorFm4hoPlO2SDsJxYjPPAuPmgs5mQTwI5mSeuc9+STjSUdPo33Ek7kgay2OH8hZdb8oSXf6CjSyVrb41Omt5vqECdfhkOvWT1BCoemHSEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229951; c=relaxed/simple;
	bh=vRbhMpo2na24RsFtXek1pFokc4qrfai6wGCBV2w3uY0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TO+D9JX/rLdva6vkx1T5o8BIH7NzOtSNTzlXEBnBQDD+DZElsaW6VbG1qQd1HaxM2yVrZcxh7D9uWwq5qIbaTd3RMPSRjD/hlph9znVaiw1CRjOpRazn5keb9YbaUv41grLSEWroa3ijE4VsYjVqoHJJIB4Z5Dd1tRcyEjb9g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g34CWLii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g34CWLii"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 673F41F000E9;
	Tue, 19 May 2026 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229949;
	bh=ZyHRPIvXky1NGQbVAWIgoe2opugO47LbWGvCTGbvCvc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=g34CWLiiwIOQgqmSL+weZ6hpzTlIswyqij5j6jVmCxrcbclL+gU6mc4jYF+24i9Ux
	 zqU7D27hxRHWfhs5HkdblRuVCRYSAWSerRygA8+GMAFfNV4F84DVymNiT8HpaIxywr
	 Vo9EpCKgp9F0W+/TTOEW70tIrgWALGC0JRNsxpopt+L99KbfDWqB4KmS9sM16SOiQn
	 BKfzKdtTYxGsRcIDY0bSmiligUZBOPoMM8GPojLxaX9khhJFJOvJSW8RgH2qegIGSh
	 mo4H5qewHiYFeSvpe/PPfd1bUL2ju78UASU18OiVqD2CY6bpP+3lpbxxluFDDdRTAf
	 yz1eeETpLIo2Q==
Date: Tue, 19 May 2026 15:32:29 -0700
Subject: [PATCH 6/9] fuse: allow privileged mount helpers to pre-approve iomap
 usage
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946306.2439242.4214293518846047238.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_iomap.c      |   44 ++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/inode.c           |    7 +++++--
 6 files changed, 60 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9e73522b8ed96e..9d6ad5b629ffdc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -617,6 +617,9 @@ struct fuse_dev {
 	/** Issue FUSE_INIT synchronously */
 	bool sync_init;
 
+	/** Allow fuse server to ask for IOMAP */
+	bool may_iomap;
+
 	/** Fuse connection for this device */
 	struct fuse_conn *fc;
 
@@ -973,6 +976,13 @@ struct fuse_conn {
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
index 921836cb6c9686..c4b98123072a37 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -63,6 +63,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 
+int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
 int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
@@ -90,6 +91,7 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
+# define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 43a1bbcce576d5..0366101be3a321 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1180,6 +1180,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3257292387e0a6..9ccf691451b609 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2716,6 +2716,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_support(file, argp);
 	case FUSE_DEV_IOC_SET_NOFS:
 		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
+	case FUSE_DEV_IOC_ADD_IOMAP:
+		return fuse_dev_ioctl_add_iomap(file);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3d9f5ecba43e28..72b530bbeb0934 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -10,6 +10,7 @@
 #include <linux/fadvise.h>
 #include <linux/fserror.h>
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
@@ -75,12 +76,21 @@ bool fuse_iomap_enabled(void)
 	 * There are fears that a fuse+iomap server could somehow DoS the
 	 * system by doing things like going out to lunch during a writeback
 	 * related iomap request.  Only allow iomap access if the fuse server
-	 * has rawio capabilities since those processes can mess things up
-	 * quite well even without our help.
+	 * or a mount helper has rawio capabilities since those processes can
+	 * mess things up quite well even without our help.
 	 */
 	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
 }
 
+static inline bool fuse_iomap_may_enable(void)
+{
+	/* Don't let anyone touch iomap until the end of the patchset. */
+	return false;
+
+	/* Same as above, but this time we log the denial in audit log */
+	return enable_iomap && capable(CAP_SYS_RAWIO);
+}
+
 /* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
 #define XMAP(word) \
 	case IOMAP_##word: \
@@ -2303,13 +2313,39 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
 	return ret;
 }
 
+int fuse_dev_ioctl_add_iomap(struct file *file)
+{
+	int err;
+	struct fuse_dev *fud = fuse_file_to_fud(file);
+
+	if (!fuse_iomap_may_enable())
+		return -EPERM;
+
+	mutex_lock(&fuse_mutex);
+	if (fuse_dev_fc_get(fud)) {
+		err = -EINVAL;
+	} else {
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
 		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+	mutex_unlock(&fuse_mutex);
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;
@@ -2318,7 +2354,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 
 static inline bool can_set_nofs(struct fuse_dev *fud)
 {
-	if (fud && fud->fc && fud->fc->iomap)
+	if (fud && fud->fc && (fud->fc->iomap || fud->fc->may_iomap))
 	       return true;
 
 	return capable(CAP_SYS_RESOURCE);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 781c9cd4ea014e..e87e7df2c63bdb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1067,6 +1067,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
+	fc->may_iomap = fuse_iomap_enabled();
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1526,7 +1527,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
 
-			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
+			if ((flags & FUSE_IOMAP) && fc->may_iomap) {
 				fc->iomap = 1;
 				pr_warn(
  "EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
@@ -1619,7 +1620,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	 * locking works correctly.  This is not compatible with creating
 	 * shadow inode objects for a submount.
 	 */
-	if (fuse_iomap_enabled() && !(flags & FUSE_SUBMOUNTS))
+	if (fm->fc->may_iomap && !(flags & FUSE_SUBMOUNTS))
 		flags |= FUSE_IOMAP;
 
 	ia->in.flags = flags;
@@ -2016,6 +2017,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 			goto err_unlock;
 		if (fud->sync_init)
 			fc->sync_init = 1;
+		if (fud->may_iomap)
+			fc->may_iomap = 1;
 	}
 
 	err = fuse_ctl_add_conn(fc);

