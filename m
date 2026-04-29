Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BD32FA2E;
	Wed, 29 Apr 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472747; cv=none; b=b2zG0hK1Bw+FCOki5BsWtzxCBl0JUWxPi5/V+Se98/KyujYiTEWi0nD2gH6AsbqlSQToJEdD7WBHDEF5los6hBxeSp46U/86HCiOBCojLwvJixHMxo8UlwygqLe+6gcvtDz6IBicvbLT1Zmo465blu5e9l6OsX66kwGzKXBqs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472747; c=relaxed/simple;
	bh=mh8+/fQ//0c1m6OI7gfoC98fJpTk2pfJlc1+QIiRDmM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aweqtfg9/ns90PLhkWD4DvSKNtO+QhskKumHwbLhmCep5mZyHP95tKWPb6Cqt5OCkOVa0wJRt0vwSVaSHscuypAX8MZ206V601mmpZngGujKrA/4LrC/7QRt/Q32PbG59Cr+mEPlJ8H9CHlwIcnl/6XhVupqxqCd9NZFWnuOI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibRjzlVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibRjzlVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0DFC2BCB8;
	Wed, 29 Apr 2026 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472747;
	bh=mh8+/fQ//0c1m6OI7gfoC98fJpTk2pfJlc1+QIiRDmM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ibRjzlVdp4UC0Uu8SYDnYry3ly1SdrWJSe/0gmGGJgDvYUQjUF2N1DnkgqoB/LmMN
	 OasGyOpvWWde+2g8jzwOvVb7JvQow8u7X7C1VU+P0/pmsUwhKlIzqoTtbISgmq1ZbH
	 IUgXGwP53g7olJ30ad8jHQM61NsxvACfMBp3A+EX9doHxU1sXa5VD7OkHs53MJP7I2
	 EvgVVGHpMBkFz1PA0v0tdompkR5+dLBa5+dZ3nl6u1ZuJb2dKvCsVkLYYNk2+7i1qn
	 LdYYtQnIREG7Y140ltcqRh2JeOzwKzXT515MVDdPcYUZ48XyhHH+RAnImFt914ODCE
	 vzKHz98mkuj0w==
Date: Wed, 29 Apr 2026 07:25:46 -0700
Subject: [PATCH 08/33] fuse: create a per-inode flag for setting exclusive
 mode.
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205321.4101881.130891634127766129.stgit@frogsfrogsfrogs>
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

Create a per-inode flag to control whether or not this inode can use
exclusive mode.  This enables more aggressive use of cached file
attributes for things such as ACL inheritance and transformations.

The initial user will be iomap filesystems, where we hoist the IO path
into the kernel and need ACLs to work for regular files and directories
in the manner that most local filesystems expect.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   17 +++++++++++++++++
 include/uapi/linux/fuse.h |    4 ++++
 fs/fuse/inode.c           |    5 +++++
 3 files changed, 26 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740589d5dc6c2d..07ad5abc48f70f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1116,6 +1116,23 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
 
+static inline void fuse_inode_set_exclusive(const struct fuse_conn *fc,
+					    struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/* This flag wasn't added until kernel API 7.99 */
+	if (fc->minor >= 99)
+		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
+static inline void fuse_inode_clear_exclusive(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
 static inline bool fuse_inode_is_exclusive(const struct inode *inode)
 {
 	const struct fuse_inode *fi = get_fuse_inode(inode);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5ae6b05de623d7..2d35dcfbf8aaf5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -244,6 +244,7 @@
  *  7.99
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -584,9 +585,12 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
+ * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 
 /**
  * Open flags
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bf86edbfa22d6b..36814b5de46879 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -197,6 +197,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	fuse_inode_clear_exclusive(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)
@@ -436,6 +438,9 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
 
+	if (attr->flags & FUSE_ATTR_EXCLUSIVE)
+		fuse_inode_set_exclusive(fc, inode);
+
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		fuse_init_file_inode(inode, attr);

