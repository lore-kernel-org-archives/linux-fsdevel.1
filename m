Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859453B3C15
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=DWx/p2VOeZp04Tg/7IfgRzggQG0HPbCVfnhs40hP5RzQ5u+7dewaHUJ/cSAaconpvSU3pAeFfGUvbxqH9y87EdDEvPmLwaQBM0mxTqQtIBkSAW3nOeqQCIDdfvdkUMylLk38qNacRQlRZY8i3JMoR3NAybbvO9BKva0gS+BGWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=wdYaZ8JkreF78BaHG1LMs9Dtt8bXl++MkwY9xgMuxUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRg9csy/lZfnqtCWNSbL25a/nQHETmbYcAjeihx0HwWu772XjFqoJA6a67Dza5Il4l/4cNSkKOtvkho+zUWAIq1IZfWQsBQDwvQU6K0ShuMxKWMPXnQPAMc5TVqHKIcHQ56X7J2XlAvphZaGen1Hn4ls3YND8ABlHu/pwoF0UvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AzPEBlPo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AzPEBlPo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=A6Ko5KCM+JFm0H6+8ncqhgfeQT4DkISlqdhTcCmvC0w=; b=AzPEBlPouaXIGW9g2dp1JlYn95
	JOJ/m5OwWuNSwbaEzts2yacsGzd7cWp51kRylHqD4d1u35RM/wY6WA9Hhs8nWEffP1/1ktpMjUcHH
	iF9LqKEM0j+7qW0mJ5hLSdlMTDbYNrZXfWGvz3J5i6D+IgusWjxEHvhJHIJ+RtELTWQsF3XiaCtYR
	A8Mb7BAlGth6w30uvcix4gURfyex6bdxGbGddk47PmmJpKfbUmt0RGDno2jp/fFR29j0p9zdgwkVZ
	RR1grIk0zGzVZ+PyeV1wHZlGIvNamr7oUw5W0kdI0eH6qPkPxyrq/Akpyn9WNUM21q5V908qg6KFj
	g28NcE2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008UwN-0wKS;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 10/14] switch configfs_detach_{group,item}() to passing dentry
Date: Tue, 19 May 2026 08:06:29 +0100
Message-ID: <20260519070633.2025485-11-viro@zeniv.linux.org.uk>
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

... and there's no need to grab/drop it, or check for NULL - none
of the callers would even get there with NULL dentry and all of
them have the sucker pinned

Note that if sd is a directory configfs_dirent, we have sd->s_element
pointing to config_item with item->ci_dentry equal to sd->s_dentry.
Which is the only reason why detach_groups() gets away with using
the latter for locking the inode and the former for removal.

Aren't redundant data structures wonderful, for obfuscation if nothing
else?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index deb18689aa0a..39a496749dc2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -621,18 +621,14 @@ static int configfs_attach_group(struct config_item *parent_item,
 				 struct config_item *item,
 				 struct dentry *dentry,
 				 struct configfs_fragment *frag);
-static void configfs_detach_group(struct config_item *item);
+static void configfs_detach_group(struct dentry *dentry);
 
-static void detach_groups(struct config_group *group)
+static void detach_groups(struct dentry *dentry)
 {
-	struct dentry * dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *child;
 	struct configfs_dirent *parent_sd;
 	struct configfs_dirent *sd, *tmp;
 
-	if (!dentry)
-		return;
-
 	parent_sd = dentry->d_fsdata;
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element ||
@@ -643,7 +639,7 @@ static void detach_groups(struct config_group *group)
 
 		inode_lock(d_inode(child));
 
-		configfs_detach_group(sd->s_element);
+		configfs_detach_group(child);
 		d_inode(child)->i_flags |= S_DEAD;
 		dont_mount(child);
 
@@ -652,11 +648,6 @@ static void detach_groups(struct config_group *group)
 		d_delete(child);
 		dput(child);
 	}
-
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
-	dput(dentry);
 }
 
 /*
@@ -800,14 +791,10 @@ static void link_group(struct config_group *parent_group, struct config_group *g
 }
 
 /* Caller holds the mutex of the item's inode */
-static void configfs_detach_item(struct config_item *item)
+static void configfs_detach_item(struct dentry *dentry)
 {
-	struct dentry *dentry = dget(item->ci_dentry);
-	if (dentry) {
-		detach_attrs(dentry);
-		configfs_remove_dir(dentry);
-		dput(dentry);
-	}
+	detach_attrs(dentry);
+	configfs_remove_dir(dentry);
 }
 
 /*
@@ -842,7 +829,7 @@ static int configfs_attach_item(struct config_item *parent_item,
 			 * we must lock them as rmdir() would.
 			 */
 			inode_lock(d_inode(dentry));
-			configfs_detach_item(item);
+			configfs_detach_item(dentry);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 			inode_unlock(d_inode(dentry));
@@ -854,10 +841,10 @@ static int configfs_attach_item(struct config_item *parent_item,
 }
 
 /* Caller holds the mutex of the group's inode */
-static void configfs_detach_group(struct config_item *item)
+static void configfs_detach_group(struct dentry *dentry)
 {
-	detach_groups(to_config_group(item));
-	configfs_detach_item(item);
+	detach_groups(dentry);
+	configfs_detach_item(dentry);
 }
 
 static int configfs_attach_group(struct config_item *parent_item,
@@ -886,7 +873,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 		configfs_adjust_dir_dirent_depth_before_populate(sd);
 		ret = populate_groups(to_config_group(item), frag);
 		if (ret) {
-			configfs_detach_group(item);
+			configfs_detach_group(dentry);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 		}
@@ -1522,13 +1509,13 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		dead_item_owner = item->ci_type->ct_owner;
 
 	if (sd->s_type & CONFIGFS_USET_DIR) {
-		configfs_detach_group(item);
+		configfs_detach_group(dentry);
 
 		mutex_lock(&subsys->su_mutex);
 		client_disconnect_notify(parent_item, item);
 		unlink_group(to_config_group(item));
 	} else {
-		configfs_detach_item(item);
+		configfs_detach_item(dentry);
 
 		mutex_lock(&subsys->su_mutex);
 		client_disconnect_notify(parent_item, item);
@@ -1781,7 +1768,7 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_prep(sd, NULL);
 	spin_unlock(&configfs_dirent_lock);
 
-	configfs_detach_group(&group->cg_item);
+	configfs_detach_group(dentry);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	d_drop(dentry);
@@ -1930,7 +1917,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	}
 	spin_unlock(&configfs_dirent_lock);
 	mutex_unlock(&configfs_symlink_mutex);
-	configfs_detach_group(&group->cg_item);
+	configfs_detach_group(dentry);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	inode_unlock(d_inode(dentry));
-- 
2.47.3

