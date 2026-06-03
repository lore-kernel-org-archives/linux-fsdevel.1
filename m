Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3A40758D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472910; cv=none; b=Ewh0KxzKQEmFtc1yfw11soZsshua3SucTY6DBHnxmYlmYukqFqKuhj+rjq4ACOCrCm3QNF0k/jPRZnAIlX9JL64AYcvd3IoLKKXQKOFvkfsXU2mk+FZT4iHRyDgRCeCvwWqg7nOPXTJmGBqSNkjIairTwS3j/izp6Cw4vVhisfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472910; c=relaxed/simple;
	bh=YmModbMDR4K0lG6rRzL+qhOCv2RSS2mqro+76rphw50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6YK/Yq358pq4RCgf/hTwyaaLy84S6xABuiBbpjzUebP8nkpmHGl/BQMTDxKavcDwRniPEG0Z3IiG182n3FHlVPqqe9hMkXEG6XBdacf8YxNwxyNcrlw0YKfoUIBGz89XVwFx13snDNd4Idji7m44LVeRYUxzFkHoRYDdsT1kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iuxNT0hd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iuxNT0hd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HceomrWY/2nuNnMKZnB035ROSHXMXcoBcr2zruJy4mc=; b=iuxNT0hdvlJmp2SGYUCs55NUrD
	DguIEAVwQvmVF8k+9dJmyf9e3WVxoxAicFpNRsvp0tGbvcyqv4Rkk9tnqdCInFqdAKH0iG8yRbVdY
	7+kesxaCNkYXc1nLSf10RmEj63A5oQ/ZJJwjo1cYm3sMrIsGoVxI5kiaKiM5xpiSUyTSI1o7LGVqn
	1WBhUBns5fDYDwyLnbsg8DAsB67Dn/Rw0eJ5JqAgm6SOp9oKefTG6syG6jbeh5bfHe7RAe6yBaokH
	0rV46lD6yHQ/2kPOe3SKvOLZy6lrufM5zBA9NWIzh3WpEwiBwtbktcT6AqdWp66UsELrnEBYlSylC
	2o7DRalw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjHD-2hOD;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 15/18] configfs_create(): lift parent timestamp updates into callers
Date: Wed,  3 Jun 2026 08:48:12 +0100
Message-ID: <20260603074815.3033766-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c   | 6 +++++-
 fs/configfs/inode.c | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 4a4bad1741cf..b382d60e7ebc 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -296,6 +296,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 	struct dentry *p = dentry->d_parent;
+	struct inode *p_inode = d_inode(p);
 	struct inode *inode;
 
 	BUG_ON(!item);
@@ -316,7 +317,8 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_make_persistent(dentry, inode);
-	inc_nlink(d_inode(p));
+	inc_nlink(p_inode);
+	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
 	item->ci_dentry = dentry;
 	return 0;
 
@@ -370,6 +372,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 	int err = 0;
 	umode_t mode = S_IFLNK | S_IRWXUGO;
 	struct configfs_dirent *p = parent->d_fsdata;
+	struct inode *p_inode = d_inode(parent);
 	struct inode *inode;
 
 	err = configfs_make_dirent(p, dentry, target, mode, CONFIGFS_ITEM_LINK,
@@ -384,6 +387,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
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

