Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E7333727;
	Wed, 29 Apr 2026 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472935; cv=none; b=piqRMQHwCXqPJqrRu1bSDJTfhN5j6mb+cqZt+R+ub3cbbkTQD9W4uiXAe9/4wsdwM5Sp1XwK2t0m+2bvPGOfiuX1j0CgUwzwFKyD3UL4Al32ObLmz/MJaVNHhGyonvACD1pekcahME+GwEZFPgW+lXqKtuZTDHEFJHIkOO7I1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472935; c=relaxed/simple;
	bh=iR4NntJeEM1euqckkpTd8lSaLLajsI0KvXbuSc1CQjc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGxwnsogZKO/+fUkvv6Ihc1Jh6CeCa/7hHqjrvER5bF+2rukpXSrmF7Fnx84u1vOS2QS7+LHUvo/VZ9bkVl29VL41yr8IugyLO3n2OXyAMGPuA46ivquMb3/dFLEYsOrpoeOShK16IP21uyz85lT8xZhXt27ku+rlMtKtjHaXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9Qmd1oA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9Qmd1oA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B820DC19425;
	Wed, 29 Apr 2026 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472934;
	bh=iR4NntJeEM1euqckkpTd8lSaLLajsI0KvXbuSc1CQjc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t9Qmd1oA8rlxDxC7jKbAAxZvVwuQRjm3AUlTiNlEeNET9ZyzaSn7++ZUYy73szRu3
	 kc/GifVczOy/H9ZNcCXeVWwP7c5FfASroZd2RApAXmzpYAQNV/jx8NerIpH8laOzaw
	 S1G8pTcyIgihZABolc4xMfp9oWyuSsVE01R6HpnWl4GMGZUzWiC351kPhPn6yX2FcW
	 5iP8BIi/zFNg5Y36DBib94wSN0v3YM6K8775eh+956TD0pR2q+1DztMXsiZO5nAZUC
	 MGfQp+545/Kpb6Fi2UeD+dx8SCjt55MzMZoBN3ukZsY4x9n0uQKOOBDehgcoiptdNi
	 4nz4+oFk47Yow==
Date: Wed, 29 Apr 2026 07:28:54 -0700
Subject: [PATCH 20/33] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205579.4101881.16849819963783474708.stgit@frogsfrogsfrogs>
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

Advertise our new IO paths programmatically by creating an ioctl that
can return the capabilities of the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    4 ++++
 include/uapi/linux/fuse.h |    9 +++++++++
 fs/fuse/dev.c             |    3 +++
 fs/fuse/fuse_iomap.c      |   13 +++++++++++++
 4 files changed, 29 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index be37ddac2f1e25..9b17f4414dcca4 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -61,6 +61,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -84,6 +87,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 71b216262c84cb..de9b56e6e8d250 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1156,6 +1156,13 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic file I/O functionality through iomap */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1163,6 +1170,8 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d21eebbe12d4c9..75e1e3f8a4ddd1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2712,6 +2712,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3519d5a9c836ba..f57e0317f7324e 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1822,3 +1822,16 @@ fuse_iomap_fallocate(
 	file_update_time(file);
 	return 0;
 }
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fuse_iomap_enabled())
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+
+	if (copy_to_user(argp, &ios, sizeof(ios)))
+		return -EFAULT;
+	return 0;
+}

