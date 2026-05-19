Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCF35C1A9;
	Tue, 19 May 2026 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230001; cv=none; b=Fz7noupIqQv/CLSYVQ0MjqVr2L+8v8FHIhYAQKRIbB4yVuLXvCXKdcHORig0r/fqJVE0bZoLPIixmWpkYrHBaedmAx8rmiF4+4b7hkOYbLPH5Wy5FLc5qQqn9T1+V2mlc/ep3IiaJTSUpEb2XFqS+mni4dxTEDp1OtGav+RYCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230001; c=relaxed/simple;
	bh=8LWE+lWUS9powpoIxvF5fLW10gdYzOFtjXj66HaIwUk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmZKa/zpyXBUMLjvyZ+ejzXRi2C3nShDSq880Idp48AvHGbLy53fqNY2inZ13jHwAAMeqFuNoZtl0RCPZtDL4NnhEEaH6k79fuwL+5F3s03/bpX/ct3XGKOSyCZ31rD7soJL4e1zDXEGH7tG6JD4eTtLlaZ8hbx6MyC7k2GclqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrWj7+Kc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrWj7+Kc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1D4671F00899;
	Tue, 19 May 2026 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229996;
	bh=3O7+rEQFMzx5GYzX6h+431+W4es+VodHQGLSfgFFSdI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=RrWj7+Kc749ynMDJd2fsnIun4hiT0TNccRfGR+9Dm1+LHKt7w3DOHf4cChN2cLaBe
	 oWwG9dymPPFUKZmL7Fz5TUpCYmwstawU6wRBYb0rC9/gxYSuxcedVng+PxoFxZaD/I
	 6EITmpn+41hxOzmf9e9Ccn050TBCkjCSX9fpGZECTglc2jvZJTgE9X8MWCrEkIttcs
	 PdAlO6MV46cXKerTisav8f6kx5ilsiWpM9EHJj2F/wsU8Me1EJakqL+merhk8IHjR2
	 EuumCOvr7bUpBcc8thMl9Q/Kuy9nz8nB/79m0k9Cey4fJkY8q4atQWJKA3avcJuX1V
	 QK+Y+P/AFJGUg==
Date: Tue, 19 May 2026 15:33:15 -0700
Subject: [PATCH 9/9] fuse: set iomap backing device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946372.2439242.13829037107289830266.stgit@frogsfrogsfrogs>
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

Add a new ioctl so that an unprivileged fuse server can set the block
size of a bdev that's opened for iomap usage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    3 +++
 include/uapi/linux/fuse.h |    8 ++++++++
 fs/fuse/dev.c             |    2 ++
 fs/fuse/fuse_iomap.c      |   27 +++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index f40d202c64c822..3cfef073cbe5aa 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -69,6 +69,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 int fuse_iomap_backing_inval(struct fuse_conn *fc,
 			     const struct fuse_iomap_backing_inval_out *arg);
+int fuse_iomap_backing_set_blocksize(struct file *file,
+				     struct fuse_iomap_backing_info __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -97,6 +99,7 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
 # define fuse_iomap_backing_inval(...)		(-ENOSYS)
+# define fuse_iomap_backing_set_blocksize(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 899964f8d6616a..0b67938bb7baf0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1173,6 +1173,11 @@ struct fuse_iomap_support {
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
@@ -1184,6 +1189,9 @@ struct fuse_iomap_support {
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
+#define FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE \
+					_IOW(FUSE_DEV_IOC_MAGIC, 102, \
+					     struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 06f52114b9aef2..d6ba8d6b1a8875 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2746,6 +2746,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
 	case FUSE_DEV_IOC_ADD_IOMAP:
 		return fuse_dev_ioctl_add_iomap(file);
+	case FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE:
+		return fuse_iomap_backing_set_blocksize(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index ba54eb694dbbac..2deed4749738cb 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2448,3 +2448,30 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+int fuse_iomap_backing_set_blocksize(struct file *file,
+				     struct fuse_iomap_backing_info __user *argp)
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

