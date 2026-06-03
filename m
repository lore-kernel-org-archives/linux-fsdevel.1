Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B12403EAC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472909; cv=none; b=iiQkuPxcG9mF4O5pRvya6wRema2oBIS4tLXFu/upaaczie2F7FGBrWx3V6xLXDyrMozoyeeow8Nfi0/YiCh9aMjoYzJqQ9H/IkJeajwTFGb/KecnnzFNwPsO+OYZzNz1yDX4nMUw82OHGhljG8FCNIapteGvMB+XEdpfbmLXdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472909; c=relaxed/simple;
	bh=rO8Tg+MbXi1EFiblsikxDdRTJFmm2Wpg2sTrIfDcByE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eakS4rdimTj4fqUtFWI06EdVvUYk6ZKYEq+Nc+nIS8WQ654WXyQzdE2O3KDNABSm3SkGNtzPOthmmZUGcVfVZPyDCts5NGD0iqeKV8kPM8/Gqc75nevjF22MQdyW8MAUTTWdkxVOSt28Blu9t3+Ao99R1L9Gvr7kT9+dtY+k/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kMxiE+ra; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kMxiE+ra"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DDNmW3ibxPgAzcA0zKWI8BZyqfREysNFMiVk9Hj2QEY=; b=kMxiE+raXWzdc/iY/rg8AdgJQE
	6ATJ0f1jQOp2tCvC7bSpsEEe/vq7Utw+cwgQC/Bv7JzxzodvJ5xfwjKP3XgT0b6Gm1ROLsVX0i3vy
	giJLsfabRAQRQCYfQIzvZNYn6YLU2OKVg94cZF04qOKrhcZcHzWvMrhOuhk0LyeTk9Arlb57h5uFv
	etSyKmXw2hiy91xOao4dKBOHV+vazWDw2RlrafVsUkLFm40faW0GnwTXH2qjBZ5aOc3nsWkJ5Y3fV
	HKLYnAOBQycQfG+nAEPCJ0JX8KiF/tFCqru08yZvIos7Pdbi0KqFhump8tmUXAYGAcTnvmull+Dxp
	EPIcNIcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjGi-0hce;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 11/18] switch configfs_detach_{group,item}() to passing dentry
Date: Wed,  3 Jun 2026 08:48:08 +0100
Message-ID: <20260603074815.3033766-15-viro@zeniv.linux.org.uk>
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

... and there's no need to grab/drop it, or check for NULL - none
of the callers would even get there with NULL dentry and all of
them have the sucker pinned

Note that if sd is a directory configfs_dirent, we have sd->s_element
pointing to config_item with item->ci_dentry equal to sd->s_dentry.
Which is the only reason why detach_groups() gets away with using
the latter for locking the inode and the former for removal.

Aren't redundant data structures wonderful, for obfuscation if nothing
else?

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 11e2597fb1e2..87a0847d88b9 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -642,18 +642,14 @@ static int configfs_attach_group(struct config_item *parent_item,
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
 	struct configfs_dirent *sd, *next;
 
-	if (!dentry)
-		return;
-
 	parent_sd = dentry->d_fsdata;
 	spin_lock(&configfs_dirent_lock);
 	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
@@ -666,7 +662,7 @@ static void detach_groups(struct config_group *group)
 
 		inode_lock(d_inode(child));
 
-		configfs_detach_group(sd->s_element);
+		configfs_detach_group(child);
 		d_inode(child)->i_flags |= S_DEAD;
 		dont_mount(child);
 
@@ -677,11 +673,6 @@ static void detach_groups(struct config_group *group)
 		spin_lock(&configfs_dirent_lock);
 	}
 	spin_unlock(&configfs_dirent_lock);
-
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
-	dput(dentry);
 }
 
 /*
@@ -825,14 +816,10 @@ static void link_group(struct config_group *parent_group, struct config_group *g
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
@@ -867,7 +854,7 @@ static int configfs_attach_item(struct config_item *parent_item,
 			 * we must lock them as rmdir() would.
 			 */
 			inode_lock(d_inode(dentry));
-			configfs_detach_item(item);
+			configfs_detach_item(dentry);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 			inode_unlock(d_inode(dentry));
@@ -879,10 +866,10 @@ static int configfs_attach_item(struct config_item *parent_item,
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
@@ -911,7 +898,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 		configfs_adjust_dir_dirent_depth_before_populate(sd);
 		ret = populate_groups(to_config_group(item), frag);
 		if (ret) {
-			configfs_detach_group(item);
+			configfs_detach_group(dentry);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 		}
@@ -1549,13 +1536,13 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -1808,7 +1795,7 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_prep(sd, NULL);
 	spin_unlock(&configfs_dirent_lock);
 
-	configfs_detach_group(&group->cg_item);
+	configfs_detach_group(dentry);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	d_drop(dentry);
@@ -1957,7 +1944,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
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

