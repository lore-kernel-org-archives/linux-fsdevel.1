Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A1367B90;
	Tue, 19 May 2026 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229935; cv=none; b=a+qqf/FfO9jIE4vYGixTqnCKhxxVzjQrKArcCgJFjuKuAo9GGMCmRIboNiHHoNdM7hX7uMxlHvS/PTIE76xHdpcooVNSNGTCIzWKQZBdgYYBoDN0ejg2EAJW90at3ggMGuj+c6C5ozXphcF5WeAfDdjL+c6E7E1mfxFm954YxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229935; c=relaxed/simple;
	bh=qeGoVKXjvQ72Y14DQzWgug6mDd5aE/VYN0UzSiyORGE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODwvTqcnDe8zvK0iGFJGynH7U311C6KSzEZEdE6WrB2RYR3Bzt98Bo0YAEOa6+80Nz98H+8fTI5x4mpom2KFpiGT+vR2TkcAq2r03GolDdoPvZ4n3yup50SrQgRhrDxBcuwkXn37DMLzQwmKbveC3cRACCqyUdNWLlcmLBGRIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKA3wI6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKA3wI6/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D61BA1F000E9;
	Tue, 19 May 2026 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229933;
	bh=JEHI2creFQkDphRs719/B2kdkZeC8L7ubjll2rJ8Nf8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=LKA3wI6/xzczrTs9QutQ79H+qt25ETarqqCwmhTcsAw7OlQYsjFAsvWrogtOsOBNg
	 Duw3AWMHoRuO79YJ02NYkPBIm42Z0Ol0qMiyIqfEq37gi4pBWjLOiGjgTQj9ddzXu4
	 0ERtpjOocdXeaZAxpfze+2zEEXvG+B1Yk3RP2EPKI13Vq1YEdYrdn8vpkOowFeqE+D
	 NS/zoqWXGYrlxQY9AWxGPm2eWpCQiHWl1m0bsW0uq2DyQIXYbOXOEnoK178F60i2tm
	 k9cqEwO+NKMjW+/nmm8AK7SH4hCz0j9j+MCqVic8zNszWlDJmignGkBNXbR8+fpMdu
	 QY1wQFbxX2YSQ==
Date: Tue, 19 May 2026 15:32:13 -0700
Subject: [PATCH 5/9] fuse: disable direct fs reclaim for any fuse server that
 uses iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946285.2439242.7541001281415676309.stgit@frogsfrogsfrogs>
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

Any fuse server that uses iomap can create a substantial amount of dirty
pages in the pagecache because we don't write dirty stuff until reclaim
or fsync.  Therefore, memory reclaim on any fuse iomap server musn't
ever recurse back into the same filesystem.  We must also never throttle
the fuse server writes to a bdi because that will just slow down
metadata operations.

Add a new ioctl that the fuse server can call on the fuse device to set
PF_MEMALLOC_NOFS and PF_LOCAL_THROTTLE.  Either the fuse connection must
have already enabled iomap, or the caller must have CAP_SYS_RESOURCE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    2 ++
 include/uapi/linux/fuse.h |    1 +
 fs/fuse/dev.c             |    2 ++
 fs/fuse/fuse_iomap.c      |   40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 0635bd8b012e6d..921836cb6c9686 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -65,6 +65,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -90,6 +91,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 867a0bc54f5b93..43a1bbcce576d5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1179,6 +1179,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 75e1e3f8a4ddd1..3257292387e0a6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2714,6 +2714,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	case FUSE_DEV_IOC_IOMAP_SUPPORT:
 		return fuse_dev_ioctl_iomap_support(file, argp);
+	case FUSE_DEV_IOC_SET_NOFS:
+		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index df68dec16f98c1..3d9f5ecba43e28 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -13,6 +13,7 @@
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
+#include "fuse_dev_i.h"
 
 static bool __read_mostly enable_iomap =
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
@@ -2314,3 +2315,42 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 		return -EFAULT;
 	return 0;
 }
+
+static inline bool can_set_nofs(struct fuse_dev *fud)
+{
+	if (fud && fud->fc && fud->fc->iomap)
+	       return true;
+
+	return capable(CAP_SYS_RESOURCE);
+}
+
+int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp)
+{
+	uint32_t flags;
+	struct fuse_dev *fud = fuse_get_dev(file);
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!can_set_nofs(fud))
+		return -EPERM;
+
+	if (copy_from_user(&flags, argp, sizeof(flags)))
+		return -EFAULT;
+
+	/*
+	 * The fuse server could be asked to perform a substantial amount of
+	 * writeback, so prohibit reclaim from recursing into fuse or the
+	 * kernel from throttling any bdis that the fuse server might write to.
+	 */
+	switch (flags) {
+	case 1:
+		current->flags |= PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE;
+		return 0;
+	case 0:
+		current->flags &= ~(PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}

