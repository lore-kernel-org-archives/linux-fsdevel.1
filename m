Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498D34D91F;
	Wed, 29 Apr 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473154; cv=none; b=QWtT39u4vMiiJNc64kXTEo27yhJ3565elaxpm3y6B+X2U/1q+GzlSBrRcv8gY2UhKTwOLtWXqcBvqgLeIGdKrarHAQEBtfGN2PK4I8CEOX4KtWm5TWali3cNd941eOi9B4uAEu32NwTIEqsTYj0M0+/L48StEFa+xlJotkRAxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473154; c=relaxed/simple;
	bh=4uF1VqMN5mpag+SGsBr52egen7racNg7zyQUdveh2lo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgnBtB/LbD1uva2GYQKxtwwQAFpI+I687SZnnfaTLzjDuvaWbAcb8RyFrrpR5/tMwsmU0lT3ywLMs6kEmzPhc5ew5LG4JHbqdAnuGDTWbMyclt14R53O2tXEAXQG6nvWMtbO6HuxzlbEZMPDODNaa9iPxM4QqgplVPgbLk+WpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maELAELv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maELAELv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EA4C19425;
	Wed, 29 Apr 2026 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473154;
	bh=4uF1VqMN5mpag+SGsBr52egen7racNg7zyQUdveh2lo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=maELAELvUAl5meJLSd5hm57u4DSd+xVWH5NA2j67mdlKljX31Oo4J9QUppxO+iZQZ
	 spGQUnNR9cD/ZGumAMnx7zgaKRtPFdVvC+N+JDxY4koaPBMkXgFbtZy92E2nChrKeH
	 JgAjbGl8iIrB9q4waVPJ0IP6Bo0Fj3LMZXiur20Me4wc8JX7UjurXtp3xhdXj4osq5
	 iAqM1zcXTEQd2LC4ttZSZl1v4vVXg3b1TpkFnnDUv6Cr0h2XLXw960e9r6URwu49ag
	 1MIvNxqFed8b/IPov/aKL3T15GDNccpuzYUzdPNFDBpzVD8hCniuW5xdlBmIthdaVj
	 RtQaZoxnu43Rg==
Date: Wed, 29 Apr 2026 07:32:33 -0700
Subject: [PATCH 1/3] fuse: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206145.4103135.16263150644393951842.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
References: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Change this from a hardcoded constant to a dynamic field so that fuse
servers don't need to translate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h  |    7 +++++--
 fs/fuse/dir.c     |   10 ++++++----
 fs/fuse/inode.c   |   11 +++++++----
 fs/fuse/readdir.c |   10 +++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c7c7f2e888bb8b..a9ca0e936524e7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -701,6 +701,9 @@ struct fuse_conn {
 
 	struct rcu_head rcu;
 
+	/* node id of the root directory */
+	u64 root_nodeid;
+
 	/** The user id for this mount */
 	kuid_t user_id;
 
@@ -1116,9 +1119,9 @@ static inline u64 get_node_id(struct inode *inode)
 	return get_fuse_inode(inode)->nodeid;
 }
 
-static inline int invalid_nodeid(u64 nodeid)
+static inline int invalid_nodeid(const struct fuse_conn *fc, u64 nodeid)
 {
-	return !nodeid || nodeid == FUSE_ROOT_ID;
+	return !nodeid || nodeid == fc->root_nodeid;
 }
 
 static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2db88bc364bb50..3a76eea04c6425 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -584,7 +584,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
-	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+	if (outarg->nodeid == fm->fc->root_nodeid && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
 		outarg->generation = 0;
 	}
@@ -634,7 +634,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -EIO;
-	if (inode && get_node_id(inode) == FUSE_ROOT_ID)
+	if (inode && get_node_id(inode) == fc->root_nodeid)
 		goto out_iput;
 
 	newent = d_splice_alias(inode, entry);
@@ -885,7 +885,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_free_ff;
 
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
+	if (!S_ISREG(outentry.attr.mode) ||
+	    invalid_nodeid(fm->fc, outentry.nodeid) ||
 	    fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
@@ -1032,7 +1033,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
+	if (invalid_nodeid(fm->fc, outarg.nodeid) ||
+	    fuse_invalid_attr(&outarg.attr))
 		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6d4ff08ad3069a..d883c9e3543f5c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1059,6 +1059,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
+	fc->root_nodeid = FUSE_ROOT_ID;
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1116,12 +1117,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
 static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mode)
 {
 	struct fuse_attr attr;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+
 	memset(&attr, 0, sizeof(attr));
 
 	attr.mode = mode;
-	attr.ino = FUSE_ROOT_ID;
+	attr.ino = fc->root_nodeid;
 	attr.nlink = 1;
-	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
+	return fuse_iget(sb, fc->root_nodeid, 0, &attr, 0, 0, 0);
 }
 
 struct fuse_inode_handle {
@@ -1165,7 +1168,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		goto out_iput;
 
 	entry = d_obtain_alias(inode);
-	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(entry) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(entry);
 
 	return entry;
@@ -1258,7 +1261,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	}
 
 	parent = d_obtain_alias(inode);
-	if (!IS_ERR(parent) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(parent) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(parent);
 
 	return parent;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec10305a..5ba19ca9d8a949 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -189,12 +189,12 @@ static int fuse_direntplus_link(struct file *file,
 			return 0;
 	}
 
-	if (invalid_nodeid(o->nodeid))
-		return -EIO;
-	if (fuse_invalid_attr(&o->attr))
-		return -EIO;
-
 	fc = get_fuse_conn(dir);
+	if (invalid_nodeid(fc, o->nodeid))
+		return -EIO;
+	if (fuse_invalid_attr(&o->attr))
+		return -EIO;
+
 	epoch = atomic_read(&fc->epoch);
 
 	name.hash = full_name_hash(parent, name.name, name.len);

