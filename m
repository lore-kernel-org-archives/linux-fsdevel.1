Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029783C7E15;
	Tue, 19 May 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229749; cv=none; b=hwIv2FwHJbf8lcZdRUPCVvMCE8dFTxj6+JiPrYcmXqk6x+Lhy7KqTgN2F4Yge0nAELA5tcEJcHX93jWEYSx8QhkXMFHitC72pP20FykIFdLu8BlnjMBYDS/dgxSW3oQ9QjNN/V1xF/s7lc8bzoLjKiFB6ELXKQ9VWK1Bw0Xg51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229749; c=relaxed/simple;
	bh=f3mUMlw94TbWJmqWj80WjJRUuPQ2x+toy5RX52R5gCc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDvgSqdIzlXo4SDFF0AoopqPUGBFy4DZ1aV6JJzSgFNe69oihKvQgEJcpd81N6tpKJ2zSZKRVDGlKVO9FjY4AiGe4ZFjP5zcerLZbe85Za2tfxqabaEe74S0AnnGMagzwJ+TFZEfzie6SAeVbywvmz0wwtOrZhfNgbwmDRgDcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBqRxvRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBqRxvRY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8A3F11F000E9;
	Tue, 19 May 2026 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229747;
	bh=tlq/RpxonJS3JBy3IgNOuETEIjX4nP8CKQ3yWQ6UjYU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=jBqRxvRYDl8S6fsotkbp0WnvsBIdxezP9PaYJQGfLEJNq/2jsxOl/2p2DP72+8Ak+
	 fn6YEor3SueiNhgCYCi8tjXyAhFY+u1VUcLPiHmvkVgfAJ9rkCD14uySrta3ebz0ml
	 PzUc8dJTpa8TRoEhYMCH2PeCZS+du08Sgt1++4FCh03c05MtFm2tHq6YZJaFFUPQGt
	 UGlRn6950rhvORr42VQgLLrreFH2RxzYxXhJE9I0J3gxeKFkOd/nbHffWPg3tih9sa
	 ijKncp6o68HUAVbNp5Hm8IyQ+bVWiYn+VtRjQuEp/U741V8P4gl7T8PkLgwTyX5k7j
	 BJVRuHQVYykqQ==
Date: Tue, 19 May 2026 15:29:07 -0700
Subject: [PATCH 10/11] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945456.2436837.16389811345034810728.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement the basic file mapping reporting functions like FIEMAP, BMAP,
and SEEK_DATA/HOLE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h |    8 ++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   15 ++++++++++-
 fs/fuse/fuse_iomap.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 91 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 66a95e8635339a..4196c6ed5466bc 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -30,12 +30,20 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 length);
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
 # define fuse_inode_has_iomap(...)		(false)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1641223f76d8c6..18b9a43a69f6e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2508,6 +2508,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8edb2f089277a1..a6b8d6bf62d6d2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2597,7 +2597,13 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
-	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
+	if (!inode->i_sb->s_bdev)
+		return 0;
+
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_bmap(mapping, block);
+
+	if (fm->fc->no_bmap)
 		return 0;
 
 	memset(&inarg, 0, sizeof(inarg));
@@ -2632,6 +2638,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	struct fuse_lseek_out outarg;
 	int err;
 
+	if (fuse_inode_has_iomap(inode)) {
+		loff_t alt_pos = fuse_iomap_lseek(file, offset, whence);
+
+		if (alt_pos != -ENOSYS)
+			return alt_pos;
+	}
+
 	if (fm->fc->no_lseek)
 		goto fallback;
 
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index b6d2fe11c0e17b..9ac3fc86ceb623 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -4,6 +4,7 @@
  * Author: Darrick J. Wong <djwong@kernel.org>
  */
 #include <linux/iomap.h>
+#include <linux/fiemap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -582,7 +583,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	return 0;
 }
 
-const struct iomap_ops fuse_iomap_ops = {
+static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
@@ -693,3 +694,69 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	fuse_inode_clear_iomap(inode);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 count)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int error;
+
+	/*
+	 * We are called directly from the vfs so we need to check per-inode
+	 * support here explicitly.
+	 */
+	if (!fuse_inode_has_iomap(inode))
+		return -EOPNOTSUPP;
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
+		return -EOPNOTSUPP;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	inode_lock_shared(inode);
+	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	return error;
+}
+
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
+{
+	ASSERT(fuse_inode_has_iomap(mapping->host));
+	ASSERT(mapping->host->i_sb->s_bdev != NULL);
+
+	return iomap_bmap(mapping, block, &fuse_iomap_ops);
+}
+
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	switch (whence) {
+	case SEEK_HOLE:
+		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);
+		break;
+	case SEEK_DATA:
+		offset = iomap_seek_data(inode, offset, &fuse_iomap_ops);
+		break;
+	default:
+		return generic_file_llseek(file, offset, whence);
+	}
+
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}

