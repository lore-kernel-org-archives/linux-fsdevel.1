Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2D3B3C11
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=VXn6CxAcat3f5HW+JE+cm5k3n8phgWo322bluZxrLqLXrGxwSM2ib3O1uyKl96zNmvyOcbaN9anyFcRiLn6ksiF3ZE3Dli+s/c8e3l12fkZekLPNSBAe+w3ecnvLiA/oayUntvwREOwzL0ZV0LgDZcqVQ1oibinJ7hzfmZptQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=C9tE1McR3hdlbO+2LghdLfX/fkSejKzPgYdy8Im7lSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2SUNs4ZPxgZK99y4KubNQX6CDh3x7rm6155VnDpkkzXNy/QelGndb1gr6izOYpALGtN5PZnacYGZY0wAxbfZamWHTEDb03bcNeUk4w4RV+1O+IxKcp5+B05XY3XLnMvuRqFW3Fx1o2nlbS5+OMFjUHQjCzlkUZ7Vb6JPIdEhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XuBo2TTu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XuBo2TTu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vOQHUmMVJW57nHTkQluAttkz0xKoWABQ/Iogtyjbz18=; b=XuBo2TTuWpuQgqUorHeAPgq5Sn
	LTYA9ZwAJ/bqkkCWyMMtFTfO/N+plyiHmLSowKARz2CtjJOzkXHh1P1TnLKNC1ON/F/FjL1wMWwju
	S24AlgHG9Qf9GUOir2GFG5Wp6RSWAXWJWIUaxlgETbFJ7nYRS8DJr/FX5lFxX/zWjwKdp2EeAEKrs
	AafmouZkCj3mnzn+bIIyLIXqG1pHuEBl+zRRHha2XUWRTM0n9RDgQMl+nQif4FSRlW7vtCLShkQ80
	iBZ7GFpG6V5YVgovjgQgBBIFvkfOEGAvgE0fTSaZ/1fLQYmeeQ0QjpilrVbJLoj0bKsywNl03I07k
	YTX79QaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008Uwo-3BYM;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 14/14] configfs_create(): lift parent timestamp updates into callers
Date: Tue, 19 May 2026 08:06:33 +0100
Message-ID: <20260519070633.2025485-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and do *not* do it in ->lookup() case.  stat foo/bar
should not update mtime of foo, TYVM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c   | 6 +++++-
 fs/configfs/inode.c | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index a2bb602fb38c..4da2fec2b64e 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -295,6 +295,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 	struct dentry *p = dentry->d_parent;
+	struct inode *p_inode = d_inode(p);
 	struct inode *inode;
 
 	BUG_ON(!item);
@@ -315,7 +316,8 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_make_persistent(dentry, inode);
-	inc_nlink(d_inode(p));
+	inc_nlink(p_inode);
+	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
 	item->ci_dentry = dentry;
 	return 0;
 
@@ -369,6 +371,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 	int err = 0;
 	umode_t mode = S_IFLNK | S_IRWXUGO;
 	struct configfs_dirent *p = parent->d_fsdata;
+	struct inode *p_inode = d_inode(parent);
 	struct inode *inode;
 
 	err = configfs_make_dirent(p, dentry, target, mode, CONFIGFS_ITEM_LINK,
@@ -383,6 +386,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 	inode->i_link = body;
 	inode->i_op = &configfs_symlink_inode_operations;
 	d_make_persistent(dentry, inode);
+	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
 	return 0;
 
 out_remove:
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 3c26b6c443be..68290fe0e374 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -157,7 +157,6 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode = NULL;
 	struct configfs_dirent *sd;
-	struct inode *p_inode;
 
 	if (!dentry)
 		return ERR_PTR(-ENOENT);
@@ -170,8 +169,6 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	p_inode = d_inode(dentry->d_parent);
-	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
 	configfs_set_inode_lock_class(sd, inode);
 	return inode;
 }
-- 
2.47.3

