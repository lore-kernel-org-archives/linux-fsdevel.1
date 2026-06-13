Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD0390CB5
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349292; cv=none; b=hDJlDJO5l8LerpHMdCZ0AnTnE0BFByYPBP6YwZijDBeEApWSmcT1aGFxBnubcp7I+UUQ0no9pSRxsuiJ6HUzx8t5HJ3g4whPbRQ9eWDOw7lF4rD2gW+dple9+FoK6GDEr0+3GRbUyCKZvwm/MXJLrdYX4YvSrZL3to0eEH0Hwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349292; c=relaxed/simple;
	bh=atRoFdNh3f1rJed1exEcF03yaHeSVpCb/5BFWokgwsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/gANzmbGKzOAAz2ur3IJm2fgJg6wx9Dwa+9S61HcjVh++H00idljSOB3ALYGkOAAdtbBmjj004woPxUx77i0lJofwHZEovP5vTkKQQF1SzMXo74EEdqMFgxGVGn0EkXdOaPZHQWFI8gK56P7fz4bQ42Mw1tv3Coc98w8A3o7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLC9Bh/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLC9Bh/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437751F000E9;
	Sat, 13 Jun 2026 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349290;
	bh=DwCeaELPnu96A41Yq/wMGk2eR0Y+r4CqfBNoXOoesB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLC9Bh/8Cx8Ao92NCLZkYy+T78BuUm7Yl0tE3Jkc+61JgOrrjOEv+eDz1fIA9vB3l
	 tT4Wr6/Ye+SZ6g/Q0IZzSSHmJQys1cdVP2+EjS9iZ7YchS7b19fz6vS8N/V+3j77sz
	 w98CGb/6NrtsQqH2bVcTj5uVqTeml+/W0X0b87t6vfq0kP1tULN+s+LEyjyZQw3BPi
	 7r7lBgfwJwrH5E0f/AVXUnyTQeqHmKlaWZfv6/xW2Gu1ZZ86qr5T4AWkCt2OlArTCu
	 4ChzU6pm/s7IwABZjsPI2NOh7Fb1bzAatRxZ8Z6yUKDC1AgBXLs+4CyTx4uah1dLZn
	 TWESuq5pjfC5Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/8] fs/configfs: dynamically allocate super_info
Date: Sat, 13 Jun 2026 13:14:31 +0200
Message-ID: <20260613111437.101763-3-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

Define 'struct configfs_super_info' to hold all required structures
and allocate the filesystem contents dynamically.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/configfs_internal.h |  13 ++++
 fs/configfs/dir.c               |  40 ++++++-----
 fs/configfs/mount.c             | 117 +++++++++++++++++++++++++-------
 3 files changed, 127 insertions(+), 43 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index acdeea8e2d69..e91f4249b83a 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -44,6 +44,17 @@ struct configfs_dirent {
 	struct configfs_fragment *s_frag;
 };
 
+struct configfs_super_info {
+	struct configfs_dirent root;
+	struct config_group group;
+	struct list_head subsys_list;
+	struct mutex subsys_mutex;
+	struct vfsmount *mnt;
+	unsigned int mnt_count;
+	u64 ns_id;
+	refcount_t ref;
+};
+
 #define CONFIGFS_ROOT		0x0001
 #define CONFIGFS_DIR		0x0002
 #define CONFIGFS_ITEM_ATTR	0x0004
@@ -81,6 +92,8 @@ extern int configfs_setattr(struct mnt_idmap *idmap,
 
 extern struct dentry *configfs_pin_fs(void);
 extern void configfs_release_fs(void);
+extern struct configfs_super_info *configfs_get_super_info(u64 ns_id);
+extern void configfs_put_super_info(struct configfs_super_info *info);
 
 extern const struct file_operations configfs_dir_operations;
 extern const struct file_operations configfs_file_operations;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 4da2fec2b64e..57719bee0c07 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -34,14 +34,6 @@
  */
 DEFINE_SPINLOCK(configfs_dirent_lock);
 
-/*
- * All of link_obj/unlink_obj/link_group/unlink_group require that
- * subsys->su_mutex is held.
- * But parent configfs_subsystem is NULL when config_item is root.
- * Use this mutex when config_item is root.
- */
-static DEFINE_MUTEX(configfs_subsystem_mutex);
-
 static void configfs_d_iput(struct dentry * dentry,
 			    struct inode * inode)
 {
@@ -1841,20 +1833,27 @@ EXPORT_SYMBOL(configfs_unregister_default_group);
 
 int configfs_register_subsystem(struct configfs_subsystem *subsys)
 {
-	int err;
+	struct configfs_super_info *info = configfs_get_super_info(0);
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry;
 	struct dentry *root;
 	struct configfs_dirent *sd;
 	struct configfs_fragment *frag;
+	int err;
+
+	if (IS_ERR(info))
+		return PTR_ERR(info);
 
 	frag = new_fragment();
-	if (!frag)
+	if (!frag) {
+		configfs_put_super_info(info);
 		return -ENOMEM;
+	}
 
 	root = configfs_pin_fs();
 	if (IS_ERR(root)) {
 		put_fragment(frag);
+		configfs_put_super_info(info);
 		return PTR_ERR(root);
 	}
 
@@ -1862,9 +1861,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
 
 	sd = root->d_fsdata;
-	mutex_lock(&configfs_subsystem_mutex);
+	mutex_lock(&info->subsys_mutex);
 	link_group(to_config_group(sd->s_element), group);
-	mutex_unlock(&configfs_subsystem_mutex);
+	mutex_unlock(&info->subsys_mutex);
 
 	inode_lock_nested(d_inode(root), I_MUTEX_PARENT);
 
@@ -1892,26 +1891,32 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	if (err) {
-		mutex_lock(&configfs_subsystem_mutex);
+		mutex_lock(&info->subsys_mutex);
 		unlink_group(group);
-		mutex_unlock(&configfs_subsystem_mutex);
+		mutex_unlock(&info->subsys_mutex);
 		configfs_release_fs();
 	}
 	put_fragment(frag);
-
+	configfs_put_super_info(info);
 	return err;
 }
 
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
+	struct configfs_super_info *info = configfs_get_super_info(0);
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
 
+	if (WARN_ON(IS_ERR(info)))
+		return;
+
 	if (dentry->d_parent != root) {
 		pr_err("Tried to unregister non-subsystem!\n");
+		dput(dentry);
+		configfs_put_super_info(info);
 		return;
 	}
 
@@ -1941,10 +1946,11 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 
 	dput(dentry);
 
-	mutex_lock(&configfs_subsystem_mutex);
+	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);
-	mutex_unlock(&configfs_subsystem_mutex);
+	mutex_unlock(&info->subsys_mutex);
 	configfs_release_fs();
+	configfs_put_super_info(info);
 }
 
 EXPORT_SYMBOL(configfs_register_subsystem);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index e5c01d5e4d2d..f49c8636eccb 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -22,10 +22,9 @@
 /* Random magic number */
 #define CONFIGFS_MAGIC 0x62656570
 
-static struct vfsmount *configfs_mount = NULL;
 struct kmem_cache *configfs_dir_cachep;
-static int configfs_mnt_count = 0;
-
+static DEFINE_XARRAY(configfs_super_xa);
+static struct configfs_super_info *configfs_root = NULL;
 
 static void configfs_free_inode(struct inode *inode)
 {
@@ -40,13 +39,6 @@ static const struct super_operations configfs_ops = {
 	.free_inode	= configfs_free_inode,
 };
 
-static struct config_group configfs_root_group = {
-	.cg_item = {
-		.ci_namebuf	= "root",
-		.ci_name	= configfs_root_group.cg_item.ci_namebuf,
-	},
-};
-
 int configfs_is_root(struct config_item *item)
 {
 	struct configfs_dirent *sd =
@@ -54,16 +46,67 @@ int configfs_is_root(struct config_item *item)
 	return sd->s_type == CONFIGFS_ROOT;
 }
 
-static struct configfs_dirent configfs_root = {
-	.s_sibling	= LIST_HEAD_INIT(configfs_root.s_sibling),
-	.s_children	= LIST_HEAD_INIT(configfs_root.s_children),
-	.s_element	= &configfs_root_group.cg_item,
-	.s_type		= CONFIGFS_ROOT,
-	.s_iattr	= NULL,
-};
+static void configfs_fill_super_info(struct configfs_super_info *info)
+{
+	INIT_LIST_HEAD(&info->root.s_sibling);
+	INIT_LIST_HEAD(&info->root.s_children);
+	info->root.s_type = CONFIGFS_ROOT;
+	info->root.s_element = &info->group.cg_item;
+	strcpy(info->group.cg_item.ci_namebuf, "root");
+	info->group.cg_item.ci_name = info->group.cg_item.ci_namebuf;
+	config_group_init(&info->group);
+	INIT_LIST_HEAD(&info->subsys_list);
+	mutex_init(&info->subsys_mutex);
+	refcount_set(&info->ref, 1);
+	info->mnt_count = 0;
+}
+
+struct configfs_super_info *configfs_get_super_info(u64 ns_id)
+{
+	struct configfs_super_info *info;
+	int err;
+
+	info = xa_load(&configfs_super_xa, ns_id);
+	if (info) {
+		if (!refcount_inc_not_zero((&info->ref))) {
+			pr_warn("%s: ns %llu already freed\n",
+				__func__, ns_id);
+			return ERR_PTR(-EBUSY);
+		}
+		pr_info("%s: use ns %llu\n",
+			__func__, ns_id);
+		return info;
+	}
+	info = kzalloc_obj(*info);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->ns_id = ns_id;
+	configfs_fill_super_info(info);
+	err = xa_insert(&configfs_super_xa, ns_id,
+			info, GFP_KERNEL);
+	if (err < 0) {
+		kfree(info);
+		return ERR_PTR(err);
+	}
+	pr_info("%s: alloc ns %llu\n", __func__, info->ns_id);
+	return info;
+}
+
+void configfs_put_super_info(struct configfs_super_info *info)
+{
+	if (refcount_dec_and_test(&info->ref)) {
+		pr_info("%s: ns %llu free fs info\n",
+			__func__, info->ns_id);
+		xa_erase(&configfs_super_xa, info->ns_id);
+		WARN_ON(!list_empty(&info->subsys_list));
+		kfree(info);
+	}
+}
 
 static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct configfs_super_info *info = configfs_get_super_info(0);
 	struct inode *inode;
 	struct dentry *root;
 
@@ -74,7 +117,7 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_gran = 1;
 
 	inode = configfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
-				   &configfs_root, sb);
+				   &info->root, sb);
 	if (inode) {
 		inode->i_op = &configfs_root_inode_operations;
 		inode->i_fop = &configfs_dir_operations;
@@ -82,18 +125,21 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		inc_nlink(inode);
 	} else {
 		pr_debug("could not get root inode\n");
+		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
 
 	root = d_make_root(inode);
 	if (!root) {
 		pr_debug("%s: could not get root dentry!\n",__func__);
+		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
-	config_group_init(&configfs_root_group);
-	configfs_root_group.cg_item.ci_dentry = root;
-	root->d_fsdata = &configfs_root;
+	config_group_init(&info->group);
+	info->group.cg_item.ci_dentry = root;
+	root->d_fsdata = &info->root;
 	sb->s_root = root;
+	sb->s_fs_info = info;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	sb->s_d_flags |= DCACHE_DONTCACHE;
 	return 0;
@@ -114,24 +160,33 @@ static int configfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void configfs_kill_sb(struct super_block *sb)
+{
+	struct configfs_super_info *info = sb->s_fs_info;
+
+	kill_anon_super(sb);
+	configfs_put_super_info(info);
+	sb->s_fs_info = NULL;
+}
+
 static struct file_system_type configfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "configfs",
 	.init_fs_context = configfs_init_fs_context,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= configfs_kill_sb,
 };
 MODULE_ALIAS_FS("configfs");
 
 struct dentry *configfs_pin_fs(void)
 {
-	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
-			     &configfs_mnt_count);
-	return err ? ERR_PTR(err) : configfs_mount->mnt_root;
+	int err = simple_pin_fs(&configfs_fs_type, &configfs_root->mnt,
+			     &configfs_root->mnt_count);
+	return err ? ERR_PTR(err) : configfs_root->mnt->mnt_root;
 }
 
 void configfs_release_fs(void)
 {
-	simple_release_fs(&configfs_mount, &configfs_mnt_count);
+	simple_release_fs(&configfs_root->mnt, &configfs_root->mnt_count);
 }
 
 
@@ -153,7 +208,16 @@ static int __init configfs_init(void)
 	if (err)
 		goto out3;
 
+	configfs_root = configfs_get_super_info(0);
+	if (IS_ERR(configfs_root)) {
+		err = PTR_ERR(configfs_root);
+		goto out4;
+	}
+
 	return 0;
+out4:
+	pr_err("Unable to get initlal root context\n");
+	unregister_filesystem(&configfs_fs_type);
 out3:
 	pr_err("Unable to register filesystem!\n");
 	sysfs_remove_mount_point(kernel_kobj, "config");
@@ -166,6 +230,7 @@ static int __init configfs_init(void)
 
 static void __exit configfs_exit(void)
 {
+	configfs_put_super_info(configfs_root);
 	unregister_filesystem(&configfs_fs_type);
 	sysfs_remove_mount_point(kernel_kobj, "config");
 	kmem_cache_destroy(configfs_dir_cachep);
-- 
2.51.0

