Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09E933507C;
	Wed, 29 Apr 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472982; cv=none; b=XWiExSFkxUQbTl+Rxtjxaghvq6DvK3h83hvOvFSKPMSm4NpeP8ib8BG72dGZhuKFuTAbagNPnbnJXB8tbNybjqA5LgtMZVBmgdcKuYnkKTs+SKZLsj8e/b1yekF4ujZ9M0Xcft2fWstaRb2qcHXpoip0yD0WS27qcUrUkKCahhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472982; c=relaxed/simple;
	bh=78BYXrb9I7m/2tEusMx0iTi0pmkb92qXkdbFPyh0fAA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvYsFFKu/LCzYACRyuq5LOlnTceg2mTtL9CCd3OA2tfsf9X4/ZRVGLSinrT17EN+YSTqVgQpdIj3gABC9GwN9Wiz3nnaNC7xzR57H4RlpQ0fUt9MPxzeXbA6p72E5y7kOI+7kI7ur4X1wi/yI84pVjbnJv1p6XHYv4l4WiKoKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETpXGFFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETpXGFFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E703C19425;
	Wed, 29 Apr 2026 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472981;
	bh=78BYXrb9I7m/2tEusMx0iTi0pmkb92qXkdbFPyh0fAA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ETpXGFFzeXiKO2FrZpeqNs601VilpDqOIXUM6bbfEh94s1njCcpd+wv/nIGv6IonO
	 5ltj2Xp1Mur0SvtO1aVWrRqVAR5uJIQ/hndbTh+Y2e4emiqgudgj0Q9oCz8t+gYEnZ
	 Z4531FM1PpxKxOv7SMjxRj3Q6moBJzadP52qgzAtCwWT3YLU/2MaH+aW3PtVxrPDE5
	 ssMT6BmTZefsJfsmmArNrMHv86qmRA/XaK05H6tQ8woPFFDvMqPysN4b9fIq0nyS2n
	 KAzrQjelF0GSas8DceJb35noj9XW1vJu5mUE51J8kXPH+TsrJdfpRreyqUhZRZErEP
	 74wY5OS5tQIjA==
Date: Wed, 29 Apr 2026 07:29:41 -0700
Subject: [PATCH 23/33] fuse: implement fadvise for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205643.4101881.5145081517115780569.stgit@frogsfrogsfrogs>
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

If userspace asks us to perform readahead on a file, take i_rwsem so
that it can't race with hole punching or writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h |    3 +++
 fs/fuse/file.c       |    1 +
 fs/fuse/fuse_iomap.c |   20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 13b5c5c896f25a..17d0507a243b59 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -65,6 +65,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -90,6 +92,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_fadvise			NULL
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6471952489aa2e..fa67b20f5ad3ae 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3257,6 +3257,7 @@ static const struct file_operations fuse_file_operations = {
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
 	.setlease	= generic_setlease,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 9a856617234f78..ad7c526545776e 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -7,6 +7,7 @@
 #include <linux/fiemap.h>
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -1982,3 +1983,22 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 		return -EFAULT;
 	return 0;
 }
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
+{
+	struct inode *inode = file_inode(file);
+	bool needlock = advice == POSIX_FADV_WILLNEED &&
+			fuse_inode_has_iomap(inode);
+	int ret;
+
+	/*
+	 * Operations creating pages in page cache need protection from hole
+	 * punching and similar ops
+	 */
+	if (needlock)
+		inode_lock_shared(inode);
+	ret = generic_fadvise(file, start, end, advice);
+	if (needlock)
+		inode_unlock_shared(inode);
+	return ret;
+}

