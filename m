Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C935C1A9;
	Tue, 19 May 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229966; cv=none; b=h+P4fhVAfTDUYOvAYpR0NU7Mu5HNPuWwCHgClfaNX6Es2Qp+S6oiq+BmSx4uuDFPb62ZvpMw7Tom9n5Y1UeM0sLttY/ti6yARPtV5nqFf+YfJ6AuL4PnPr/2RzchnCd9dJiHzh9W2zxwgEHLsov6m/XcwqovMibr+EU4/EsIYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229966; c=relaxed/simple;
	bh=/GdASbCvrZ6qbtS+9Xtoi8grGckpISFgaeZTMikYSOc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlzzsEvhWvyQGOM2pfbh+k2J8AD0ysBlfRE7T7OeXBzHpSCJqAxZBsFX0vI2M5w8b9m3izA2tLyqoSPHaFxhTqVwvpx4E8rq/zI2yJJtSGjAr4/Ohl2jpBKr8zZpGRHE4u7nOH0WJ23nsN2EgDGknWCgH+JHvaADSTgXGr1ERPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfPSRfhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfPSRfhR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 23FAE1F000E9;
	Tue, 19 May 2026 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229965;
	bh=W9xD32InSn9qXCDGGIuDqmIteGS3KSPRKIglPaGYrZk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=bfPSRfhRvhvDAZp74RCpmSduQKRG+F6RAT7pZRtbgNXTqZwb9Y/FQbhQ638TarhyF
	 GkiG5MQvJgyVHu9BOI+255UFpylZVEbAfRocnuY1MvNNfRO8xYz+xHbJEpgOA4aLMF
	 05iyyPFSqO34drpl4qQgInqhZQgaMDwp0ad2OPl+kOpRlWzOwymD7SX9czEp/+fDqA
	 Bq0xh/NU/PaR+PcCKiDWQLLbDVWMaXaM0dr+T+BQgUiGZ0P5bhiLS5vu4II2SDpn01
	 MuIdx/d0GanhMyePvIHNjAAnr3IFpsGJ0Kvw3CNtR+UpO3ngfOIkk+ctSob2eqxCEV
	 r7Gk5miVbXrfQ==
Date: Tue, 19 May 2026 15:32:44 -0700
Subject: [PATCH 7/9] fuse: invalidate ranges of backing devices being used for
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946329.2439242.17189876954349215664.stgit@frogsfrogsfrogs>
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

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.  Right now, the only way to do this
is with fadvise, which ignores and doesn't wait for pages undergoing
writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    3 ++
 include/uapi/linux/fuse.h |   20 ++++++++++++++++
 fs/fuse/dev.c             |   28 +++++++++++++++++++++++
 fs/fuse/fuse_iomap.c      |   56 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index c4b98123072a37..f40d202c64c822 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -67,6 +67,8 @@ int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
 int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
+int fuse_iomap_backing_inval(struct fuse_conn *fc,
+			     const struct fuse_iomap_backing_inval_out *arg);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -94,6 +96,7 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 # define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
+# define fuse_iomap_backing_inval(...)		(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 0366101be3a321..899964f8d6616a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -247,6 +247,7 @@
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_BACKING_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -706,6 +707,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
+	FUSE_NOTIFY_IOMAP_BACKING_INVAL = 99,
+	FUSE_NOTIFY_CODE_MAX,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1509,4 +1512,21 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_range {
+	uint64_t offset;
+	uint64_t length;
+};
+
+struct fuse_iomap_backing_inval_out {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	/*
+	 * Range of backing file pagecache to invalidate, in bytes.  After
+	 * the call completes, the range will be non-dirty and hence cannot
+	 * be written to by the bdev pagecache.
+	 */
+	struct fuse_range range;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9ccf691451b609..06f52114b9aef2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1848,6 +1848,31 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_iomap_backing_inval(struct fuse_conn *fc,
+					   unsigned int size,
+					   struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_backing_inval_out outarg;
+	int err = -EINVAL;
+
+	if (size != sizeof(outarg))
+		goto err;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		goto err;
+	if (outarg.reserved) {
+		err = -EINVAL;
+		goto err;
+	}
+	fuse_copy_finish(cs);
+
+	return fuse_iomap_backing_inval(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2138,6 +2163,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_PRUNE:
 		return fuse_notify_prune(fc, size, cs);
 
+	case FUSE_NOTIFY_IOMAP_BACKING_INVAL:
+		return fuse_notify_iomap_backing_inval(fc, size, cs);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 72b530bbeb0934..8d259c8d239b07 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2390,3 +2390,59 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp)
 		return -EINVAL;
 	}
 }
+
+int fuse_iomap_backing_inval(struct fuse_conn *fc,
+			     const struct fuse_iomap_backing_inval_out *arg)
+{
+	struct fuse_backing *fb;
+	struct block_device *bdev;
+	loff_t end;
+	int ret = 0;
+
+	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
+		return -EINVAL;
+
+	down_read(&fc->killsb);
+	fb = fuse_backing_lookup(fc, &fuse_iomap_backing_ops, arg->dev);
+	if (!fb) {
+		ret = -ENODEV;
+		goto out_killsb;
+	}
+	bdev = fb->bdev;
+
+	inode_lock(bdev->bd_mapping->host);
+	filemap_invalidate_lock(bdev->bd_mapping);
+
+	if (arg->range.offset >= bdev_nr_bytes(bdev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (arg->range.length == 0) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	if (check_add_overflow(arg->range.offset, arg->range.length, &end)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * Removes page cache for full base pages within the requested range,
+	 * and zeroes and cleans unaligned edges.  We don't care about this
+	 * distinction; all we care about is not having dirty bufferheads that
+	 * would get written out after iomap starts issuing writes directly to
+	 * the block device.
+	 */
+	end = min(end, bdev_nr_bytes(bdev)) - 1;
+	truncate_inode_pages_range(bdev->bd_mapping, arg->range.offset, end);
+
+out_unlock:
+	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
+	fuse_backing_put(fb);
+out_killsb:
+	up_read(&fc->killsb);
+	return ret;
+}

