Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B623D667F;
	Fri, 24 Apr 2026 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038586; cv=none; b=D1bvW4n1/RNWDHZOWqIan6EGQufXWTnCmddPa4HmWpz6PlHHaiztQhGOTjcQGh4ZfW7czKOFz9lPaCYRP6C+NElmqBamhzV9hJuTlZBvw0LwxYNpApIpx2L0/rF9CSDr8q+e9MVIjug9hgQJWlZxriuq5cVlBVhEMo1OzxAfDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038586; c=relaxed/simple;
	bh=/2Sez41FsNaweY+WdNKa2z5SdDP5Vo8Tt5zxAa1mHZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5F9hVpZQfjnMFcFSYhUgvSVfoM6a8V5zTAFuv5OSgSp1yBfBSmXkDtr+pi1ixBYdbNl6IF/6MRA+ZhrfdDgY9iaE3p09rXy3jaaZA4M7Du9FwRMKcGRmw5+HKgm85nYUD0rS/yz0b/MYReRd5bO6i5msW321veSOJPeWNnzMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B+JHNK7B; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B+JHNK7B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/48QvvlpBcIIFGC6FKPGf9Mt7wqfbZazpashAFNf9wo=; b=B+JHNK7BFS8PsCss6NTlgouB7X
	dhmdKC7Q8H2z6fNhD7LV9mXsmi+kuJ+cupH9+XUbHR9ZRaZZFhMJIGBchVYfdoUPqyR1jHD8YHRSJ
	G8Uc8aSxYYYRu9CJE2ynb4LYyXdvKUdj4FO5yi/efsn911FEzUNatSzyLkJZ4Dp98mglUxlaYsEIo
	RsCS4PGId40WK4oyQSsq//CfpkGNa/roykpXiCmqoKTFkMdtN6NiaNIfuLic7ppD47pfxiv74DxUu
	lYONUxlQfu8x6or50ts7djoog1LiaK6jJcqlafuwvwrpDau856w/6TpTFTRGfQ3igntvm4oTAAd58
	Atx0SRXA==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGGuX-001cQb-W2; Fri, 24 Apr 2026 15:49:37 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] fuse: fix race between inode/dentry invalidation and readdir
Date: Fri, 24 Apr 2026 14:49:35 +0100
Message-ID: <20260424134935.16161-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there's a readdir in progress, doing a FUSE_NOTIFY_INVAL_{INODE,ENTRY}
on an inode or dentry may result in stale directory info being cached.  This
is because the invalidation does not reset the readdir cache.

This patch fixes this issue by adding a call to fuse_rdc_reset() (modified
to include the required locking) to these two operations, allowing the
readdir cache to be invalidated while it's being filled-in.

Assisted-by: Claude:claude-opus-4-5
Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c     |  5 +++--
 fs/fuse/fuse_i.h  | 13 +++++++++++++
 fs/fuse/inode.c   |  1 +
 fs/fuse/readdir.c |  6 +++---
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12..6e5851de3613 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1615,6 +1615,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	if (!(flags & FUSE_EXPIRE_ONLY))
 		d_invalidate(entry);
 	fuse_invalidate_entry_cache(entry);
+	fuse_rdc_reset(entry->d_inode);
 
 	if (child_nodeid != 0) {
 		inode_lock(d_inode(entry));
@@ -1637,7 +1638,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 		dont_mount(entry);
 		clear_nlink(d_inode(entry));
 		err = 0;
- badentry:
+badentry:
 		inode_unlock(d_inode(entry));
 		if (!err)
 			d_delete(entry);
@@ -1646,7 +1647,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	}
 
 	end_removing(entry);
- put_parent:
+put_parent:
 	dput(dir);
 	iput(parent);
 	return err;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..0f31065f8046 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1494,6 +1494,19 @@ int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
 
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
+void __fuse_rdc_reset(struct inode *inode);
+
+static inline void fuse_rdc_reset(struct inode *inode)
+{
+	struct fuse_inode *fi;
+
+	if (S_ISDIR(inode->i_mode)) {
+		fi = get_fuse_inode(inode);
+		spin_lock(&fi->rdc.lock);
+		__fuse_rdc_reset(inode);
+		spin_unlock(&fi->rdc.lock);
+	}
+}
 
 /**
  * Return the number of bytes in an arguments list
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c795abe47a4f..4d8220f573f2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -570,6 +570,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
 	spin_unlock(&fi->lock);
 
+	fuse_rdc_reset(inode);
 	fuse_invalidate_attr(inode);
 	forget_all_cached_acls(inode);
 	if (offset >= 0) {
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..e7e1f051e45c 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -430,7 +430,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 	return res;
 }
 
-static void fuse_rdc_reset(struct inode *inode)
+void __fuse_rdc_reset(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -493,7 +493,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 
 		if (inode_peek_iversion(inode) != fi->rdc.iversion ||
 		    !timespec64_equal(&fi->rdc.mtime, &mtime)) {
-			fuse_rdc_reset(inode);
+			__fuse_rdc_reset(inode);
 			goto retry_locked;
 		}
 	}
@@ -541,7 +541,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		 * Uh-oh: page gone missing, cache is useless
 		 */
 		if (fi->rdc.version == ff->readdir.version)
-			fuse_rdc_reset(inode);
+			__fuse_rdc_reset(inode);
 		goto retry_locked;
 	}
 
