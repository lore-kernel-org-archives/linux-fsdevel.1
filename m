Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BE3AE185
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472910; cv=none; b=iAw5RW8lnuwgt+rRh+GtkciVzIIxE56HMH33SG1k8B5C3M3GKSoQ16B0D7KZd4OiYiojyie/YTijtfDwtP3Ser6pEUS1NNFfF4kDEhNZv8rNEo+bqYfmBrH719HCNZTYAngZCwtYMP+SGxQ/H8f0CVyPXMBCYEgJ3jJpfAzAU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472910; c=relaxed/simple;
	bh=T862CHglmc2VLGhBAoVr7BTxm7j8gxGGEYoSHFBcrWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h26v4YbVEDbNmBvWgiHOSwPTbDqeH5iSBu9p6lEl24bFNfWsSstJ++w7pBa11yS1yKS/A8vzyNIBOf7apC7znEYsqzYKwVwSTCPWIU1WzI9ivHPFD9HV/xE6nz7VEOynoNVVSuWHLYjw4dz61SBWYim6xcNOdR5tl4j+BZSx+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dGZHAZ3E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dGZHAZ3E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BwVcPxCfLGlV4vN6xe8ZwAkQTUm1FbMVn9j/oC9Xv8I=; b=dGZHAZ3Ebq2qrP5BTC+In+x3Vv
	uDDI6RwGbDDachs/EHj1CPc6CmtU3o6lrTo7Q9ux04IgOFb6HvzssEc7qUBqNsI3Qic4GsKX+hbu+
	7ak5sA8yNCb7RKz6kCAbwlHxwCsdNj2jzVsBu2/GWbkNseeG6v3hOdfbTmXTLiD1tFUJLCVN4KE4U
	s5mF+0b58fxRlm9rsEmcFrzvBOCvRHz82GvXxZIz085oXBa8P15e3stBJ1t2fkOYBPqbS+TFfx0kk
	Oyz7Ye4uL8kGb4tu/BEPxF65TjxAHalvhhzS0Fs9P4HwTHfJsScxgzbdKDjtERNdHT1kVi28qa6ZG
	05BZhrig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjGv-1WUg;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 13/18] configfs: mark pinned dentries persistent
Date: Wed,  3 Jun 2026 08:48:10 +0100
Message-ID: <20260603074815.3033766-17-viro@zeniv.linux.org.uk>
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

on the removal side we can (finally) get rid of __simple_unlink()
and __simple_rmdir() kludges now that dentries in question are
properly marked persistent - simple_unlink() and simple_rmdir()
will do the right thing for those.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c     | 13 +++----------
 fs/configfs/symlink.c |  3 +--
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 4836ffb3b70f..479d37b8d806 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -315,9 +315,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	inode->i_fop = &configfs_dir_operations;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	/* already hashed */
-	dget(dentry);  /* pin directory dentries in core */
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(p));
 	item->ci_dentry = dentry;
 	return 0;
@@ -385,8 +383,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 
 	inode->i_link = body;
 	inode->i_op = &configfs_symlink_inode_operations;
-	d_instantiate(dentry, inode);
-	dget(dentry);  /* pin link dentries in core */
+	d_make_persistent(dentry, inode);
 	return 0;
 
 out_remove:
@@ -413,12 +410,8 @@ static void configfs_remove_dir(struct dentry *d)
 	configfs_remove_dirent(d);
 
 	if (d_really_is_positive(d)) {
-		if (likely(simple_empty(d))) {
-			__simple_rmdir(d_inode(parent),d);
-			dput(d);
-		} else {
+		if (unlikely(simple_rmdir(d_inode(parent), d)))
 			pr_warn("remove_dir (%pd): attributes remain", d);
-		}
 	}
 
 	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index f3f79c67add5..31eb28b27309 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -229,9 +229,8 @@ int configfs_unlink(struct inode *dir, struct dentry *dentry)
 	spin_lock(&configfs_dirent_lock);
 	list_del_init(&sd->s_sibling);
 	spin_unlock(&configfs_dirent_lock);
-	configfs_drop_dentry(sd, dentry->d_parent);
-	dput(dentry);
 	configfs_put(sd);
+	simple_unlink(dir, dentry);
 
 	/*
 	 * drop_link() must be called before
-- 
2.47.3

