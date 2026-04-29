Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E434DCD2;
	Wed, 29 Apr 2026 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473545; cv=none; b=YVWsuo0q29txZOE04IFD18JLIOZ9CEVcZlXqqnP3nvfjBai2+csjSXz362GYishzTPIOK0aQ3MpEVws/J7QUcgpoympbUiQkt3VyeTFqWS4LtyEoDvH13PkiA5rLM7mRomEocscQjQmtf0lo/T9fv3vRLY+9ITQgtfZ+5Ivfnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473545; c=relaxed/simple;
	bh=yTvG1AoJbDrZmSFVkLEGl1tI1Mw/1DdJXr7KjHGvh24=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3xeILW1brYmZzPNEgFv3MjnE0Ap9E2Q9qm+rKMPwdY39YZzhA7Sw8uuP8WLCIcJZ8GAXMMl2/Uf19CiaaU6KONvpUb2vM5Jp3F/mjczcvh5qdxZjGNRwiT8+wZ4H6hKpxCQlr/fXQDvd7Dk6/gW2BTbWCzXwxiKlgHj+lUCgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po8pT1U1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po8pT1U1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AA7C19425;
	Wed, 29 Apr 2026 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473545;
	bh=yTvG1AoJbDrZmSFVkLEGl1tI1Mw/1DdJXr7KjHGvh24=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Po8pT1U1s5vEEnIrSUOnHnsP29IV1lrwkQuE8uIYM0cxVwXoW8yiooOCIepjcWK/a
	 pV6vV+Fx0W9Skb70pj9LAAAypIp29P6r3ijosSTMCiaGpGaw9Ndvjn6qlw9e3ZgZdy
	 3StkkwmP9gg/G4Ht13JR1gYZlCuzYaLAobepSmkoxnPq/PRuxxbXVJEPCqUDbbtp4c
	 KrgDQcLjvyNYInc4viuQBuL2aZvW0rX1NZdFYhyk4JQvi4MxbW7JWZU7bN7XENHOUW
	 uLn8yACZWrj2X1r0PTY6xwHAKkXojddHb2zYpqjaf1dg1Kz4XH6jCxipG0A16h5FJf
	 qcYWexU39XEGA==
Date: Wed, 29 Apr 2026 07:39:04 -0700
Subject: [PATCH 2/2] fuse: set iomap backing device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207539.4104197.15774379061288512517.stgit@frogsfrogsfrogs>
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

Add a new ioctl so that an unprivileged fuse server can set the block
size of a bdev that's opened for iomap usage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    3 +++
 include/uapi/linux/fuse.h |    7 +++++++
 fs/fuse/dev.c             |    2 ++
 fs/fuse/fuse_iomap.c      |   27 +++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 636d75e44cda82..39da52bfdbe622 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -75,6 +75,8 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
 			 const struct fuse_iomap_dev_inval_out *arg);
 
@@ -112,6 +114,7 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 # define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_dev_ioctl_iomap_set_blocksize(...) (-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1132493c66d266..94e99a01af5da7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1202,6 +1202,11 @@ struct fuse_iomap_support {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_backing_info {
+	uint32_t	backing_id;
+	uint32_t	blocksize;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1213,6 +1218,8 @@ struct fuse_iomap_support {
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 102, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fc2875cfffdb3b..f7da6fb8c60d58 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2791,6 +2791,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
 	case FUSE_DEV_IOC_ADD_IOMAP:
 		return fuse_dev_ioctl_add_iomap(file);
+	case FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE:
+		return fuse_dev_ioctl_iomap_set_blocksize(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3c2821c5f74c03..57c0539f78a1d7 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2933,3 +2933,30 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp)
+{
+	struct fuse_iomap_backing_info fbi;
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_backing *fb;
+	int ret;
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!fud->fc->iomap)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&fbi, argp, sizeof(fbi)))
+		return -EFAULT;
+
+	fb = fuse_backing_lookup(fud->fc, &fuse_iomap_backing_ops,
+				 fbi.backing_id);
+	if (!fb)
+		return -ENOENT;
+
+	ret = set_blocksize(fb->file, fbi.blocksize);
+	fuse_backing_put(fb);
+	return ret;
+}

