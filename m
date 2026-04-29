Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9ED33263B;
	Wed, 29 Apr 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472809; cv=none; b=ccNdyRL09vav8EDgd73lsGzSyqvAmHgL8cg7K0DrOKbkheY+LKC5F6EwEdtBzBRsiynUdupFeznKh0PpkA3OG+kPh0MJyCGhHydfVe+8dzRfBtG08aKM67NotBhSHQmr/4uT7kybvsRwmaqNZx6ZC4VP4TGZw9G0ihb/y4plFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472809; c=relaxed/simple;
	bh=zeIuPvnii97QgDztQoCVq/ooEukGqqtRzTzQWaXkqVE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQ2cDIYSB/FrM9SWJhU58LnuCMSyCn6FAEfi7OZ7O5CWLOdpLJh0vOquTLMqZSSTiA6ruM7J/eTRmo8+8IYFg9O/T7w5bSOEZWu0Sr3MMVD5amOqE2rn8uMCOr+l6depX8RPwBHhfDrdDSoQdvso+UoSGJaz1EqEhQ1l1v5Fgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9KBTudV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9KBTudV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D660C19425;
	Wed, 29 Apr 2026 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472809;
	bh=zeIuPvnii97QgDztQoCVq/ooEukGqqtRzTzQWaXkqVE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=O9KBTudV15fil2remvVsICyFCgJqztx8hUani/8TK1uo1JwXLIfNs5O4TC4kAySeH
	 wsYwiC+w+Je9RB2GU+OYhh1vJr+1IoAR+Rzgmc+drmRRmfrU5f8Drc1CwsFbw8XJJi
	 evC+Y3QbhS+VaADNuKEXbhbowU0oProPEeNjLF1A300K0WGVS4IkCS3kCjEH1dB3HZ
	 g1mKWbQDYe/S7e482qzVjJf3hZtJH3g+NTaA6qJyXeOAZrcEdhOpLwd95ChKf9azdO
	 2SQzcwhQzGcIEP5OA9WAHfIW78DxSlAtQPGMjZTelezriAPiOgxVLYPKAYcJQyAQDH
	 rNO0Yt3RGR3Vw==
Date: Wed, 29 Apr 2026 07:26:49 -0700
Subject: [PATCH 12/33] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205408.4101881.8022593459391808175.stgit@frogsfrogsfrogs>
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

Implement the basic file mapping reporting functions like FIEMAP, BMAP,
and SEEK_DATA/HOLE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h |    8 ++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   13 ++++++++++
 fs/fuse/fuse_iomap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 89 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 34f2c75416eb62..8ba30a496545f5 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -33,6 +33,11 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 
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
@@ -41,6 +46,9 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
 # define fuse_inode_has_iomap(...)		(false)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1bb0302f7ce8bb..2ed19e21d90702 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2505,6 +2505,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2a807c49792d53..67cb0844181851 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2593,6 +2593,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
+	if (fuse_inode_has_iomap(inode)) {
+		sector_t alt_sec = fuse_iomap_bmap(mapping, block);
+		if (alt_sec > 0)
+			return alt_sec;
+	}
+
 	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
 		return 0;
 
@@ -2628,6 +2634,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
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
index dccfc9a2c9847c..32ddf2fa6bdf78 100644
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
@@ -539,7 +540,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	return 0;
 }
 
-const struct iomap_ops fuse_iomap_ops = {
+static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
@@ -669,3 +670,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
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

