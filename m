Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE033507C;
	Wed, 29 Apr 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472997; cv=none; b=mK+IHxNIHn/tfXhb9+yPKeyXb3RTIiGvN+ltlksR6SFxbgVETp0h3SeB4CA9art7bSX/DWzNqdqRjuXWszxm8gtWoC0hPMimJQNYu9EsIDFlOpAqFHUOnaj2XkMJlVq871nm7JlgeUw+jjzpigeuI2JLs42d0hWhvdsJQm9p5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472997; c=relaxed/simple;
	bh=oWXbbYlSGgD/8TRICv5G7lv7NKpEfjcer4MBxfsq/EI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsUI6uQ1aREy092laRXl6zAN5cLW7TalVxyvqTK3ibbep60V9rHWR0r3I6/VzyK+/nVQpajLDhG2jsjG054DcrPxSD91V+1sdNjWsdgBqkLYrisoslwfDc9PrIUig9k7XTxSTOljMXHJDOQ4F9JHsGD+5TgFbCRMSuv2zdxtRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyzVZfPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyzVZfPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2976DC19425;
	Wed, 29 Apr 2026 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472997;
	bh=oWXbbYlSGgD/8TRICv5G7lv7NKpEfjcer4MBxfsq/EI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UyzVZfPFzG5EC2IrhsggOQrgDnoHCMrPolYjtVntIOqICPOEcpVmBGwE3h/qd0SAU
	 uyn1OwdpiA8Nnn9pLhLTfrVEQZ3regkJKuwD5trhY8GhfonJjEGF43fvoxFyOvkQ4d
	 RrwPB7+1iC4PkmFGcdxBh2RHCOS2BSYd1TdpFnKfPqdGkyLErKWQgoYmKPHM8Xl5eM
	 A3R7h7HvM4Q987/XtcV6cxomMomADjvvQYKGEYfSrYvRJb8X6r1A0dyr9cTqUAaQ/O
	 9wYBnGH624cWNbNmoBwpr71BXJ1OZQoAXrWQelOO7IG1YOyCb18Tq/4IOHve0+9f6L
	 DgI1htFnuJoUw==
Date: Wed, 29 Apr 2026 07:29:56 -0700
Subject: [PATCH 24/33] fuse: invalidate ranges of block devices being used for
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205664.4101881.1577494548948279604.stgit@frogsfrogsfrogs>
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

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.  Right now, the only way to do this
is with fadvise, which ignores and doesn't wait for pages undergoing
writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    3 +++
 include/uapi/linux/fuse.h |   16 ++++++++++++++++
 fs/fuse/dev.c             |   27 +++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c      |   41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 17d0507a243b59..31d6f7b392771c 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -65,6 +65,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
@@ -92,6 +94,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 #endif /* CONFIG_FUSE_IOMAP */
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 33668d66e9c4b4..1ef7152306a24f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -247,6 +247,7 @@
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -701,6 +702,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
+	FUSE_NOTIFY_CODE_MAX,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1491,4 +1494,17 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_range {
+	uint64_t offset;
+	uint64_t length;
+};
+
+struct fuse_iomap_dev_inval_out {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	/* range of bdev pagecache to invalidate, in bytes */
+	struct fuse_range range;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 75e1e3f8a4ddd1..9918911fe44855 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1848,6 +1848,30 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_iomap_dev_inval(struct fuse_conn *fc, unsigned int size,
+				       struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_dev_inval_out outarg;
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
+	return fuse_iomap_dev_inval(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2138,6 +2162,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_PRUNE:
 		return fuse_notify_prune(fc, size, cs);
 
+	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
+		return fuse_notify_iomap_dev_inval(fc, size, cs);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index ad7c526545776e..fe937529543b0c 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2002,3 +2002,44 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
 		inode_unlock_shared(inode);
 	return ret;
 }
+
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg)
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
+	if (check_add_overflow(arg->range.offset, arg->range.length, &end) ||
+	    arg->range.offset >= bdev_nr_bytes(bdev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	end = min(end, bdev_nr_bytes(bdev));
+	truncate_inode_pages_range(bdev->bd_mapping, arg->range.offset,
+				   end - 1);
+
+out_unlock:
+	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
+	fuse_backing_put(fb);
+out_killsb:
+	up_read(&fc->killsb);
+	return ret;
+}

