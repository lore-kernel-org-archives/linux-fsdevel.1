Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6483D1ABD;
	Tue, 23 Jun 2026 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206169; cv=none; b=FoTcVZ3kNMzD7e0Rn44wDa8izRTTgmU3Bo9PfW7GNrbz+QE1cffPIKzAwBIdz+k6L26NOse2SYdrCiuNnzDDBtpjS0qUoCxpUlOMAk4TTWK5JqI/EipTPwdO/jbBZrhr+WBNzRhvT1/keIk7/SUhGZkqoTKotCBTkGeTAUYAbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206169; c=relaxed/simple;
	bh=iNsltz5OiH6WYq6fAVXSjmuZtT6w1ufouZ2duXEv+F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARy6BZ8s6M7i8D29jcoynRPv8+AUPDzPpHCwUQbQA8+Dy8g66cDN2YDTgwpkSE5dvFYfzJi74litsO98NM8LeCxG2m2hXVc6Mpo7HZ7gV07pUwogtpsAPo77nWX/vgIxWfkr4eypDGSydsnNjGiDQdwD19OTK1ZFvCIl6P2mWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIehM6YV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIehM6YV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCCA1F00ACF;
	Tue, 23 Jun 2026 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206167;
	bh=I/fYVh3wx3Xwz49Y3Zh/d0bpE4ADpjmyTklRBoP8YJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HIehM6YV/Fy7AlcE6HoAZZGRViDm7bSB9iImjuXKT0FMRLNuA372f9bv5vmTV8dzV
	 y1CfisJIJHjWDR9hNy4A3t4zGF0li0iusQ2mRwqoUU0JN/T4AYVN4cdkMJBif0F/Wn
	 gHgNSVBBbJstcZkannHSY0JURm0PXlkChKopOBgv0gV8MGedDXAi7P/Wow1e95FatF
	 SLy64IQvlX2jpGCPwoeCcC5ii26A1iVR1xbyCEYlFWVB5lx1X4T19ieSPoEMtRhBHe
	 fFvrSbX1ylNX/tZm6LQxUOqJjb+JB1TaN7ATbJruQFC2KSKWh00+Mfx7+SHRingF0h
	 3ad0vC1bSJO3w==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:47 +0200
Subject: [PATCH RFC v3 02/12] fs/configfs: dynamically allocate super_info
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-2-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=12467;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=iNsltz5OiH6WYq6fAVXSjmuZtT6w1ufouZ2duXEv+F4=;
 b=CD/qUhzaE3bNqI+7poxjEenia+VLuxdcwuL2lxrbP+VKi/JAUah0d7pydoIIlLhOMBD9mhU2l
 r1pD5HJhm3KDZQYcmMYweVjQfXv7vdXSkWh1craXszn44yWY/kwbFQm
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Define 'struct configfs_super_info' to hold all required structures
and allocate the filesystem contents dynamically.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |  13 ++++
 fs/configfs/dir.c               |  44 +++++++-----
 fs/configfs/mount.c             | 148 ++++++++++++++++++++++++++++++----------
 include/linux/configfs.h        |   1 +
 4 files changed, 154 insertions(+), 52 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 6261e1f3ec201a58a5d46b08dfbced8c2a44d82b..94b9e306709150e7a123c46bb359077c6dc917ad 100644
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
+	int mnt_count;
+	struct net *net_ns;
+	refcount_t ref;
+};
+
 #define CONFIGFS_ROOT		0x0001
 #define CONFIGFS_DIR		0x0002
 #define CONFIGFS_ITEM_ATTR	0x0004
@@ -81,6 +92,8 @@ extern int configfs_setattr(struct mnt_idmap *idmap,
 
 extern struct dentry *configfs_pin_fs(void);
 extern void configfs_release_fs(void);
+extern struct configfs_super_info *configfs_get_super_info(struct net *net_ns);
+extern void configfs_put_super_info(struct configfs_super_info *info);
 
 extern const struct file_operations configfs_dir_operations;
 extern const struct file_operations configfs_file_operations;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 3c88f13f1ca2e9f0ee61ab5003356c070f2c05be..1e9c82e02741798930b08c96fb59a2767c7e00fc 100644
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
@@ -1871,20 +1863,28 @@ EXPORT_SYMBOL(configfs_unregister_default_group);
 
 int configfs_register_subsystem(struct configfs_subsystem *subsys)
 {
-	int err;
+	struct configfs_super_info *info;
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry;
 	struct dentry *root;
 	struct configfs_dirent *sd;
 	struct configfs_fragment *frag;
+	int err;
+
+	info = configfs_get_super_info(&init_net);
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
 
@@ -1892,9 +1892,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
 
 	sd = root->d_fsdata;
-	mutex_lock(&configfs_subsystem_mutex);
+	mutex_lock(&info->subsys_mutex);
 	link_group(to_config_group(sd->s_element), group);
-	mutex_unlock(&configfs_subsystem_mutex);
+	mutex_unlock(&info->subsys_mutex);
 
 	inode_lock_nested(d_inode(root), I_MUTEX_PARENT);
 
@@ -1921,26 +1921,35 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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
+	struct configfs_super_info *info;
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
 
+	info = configfs_get_super_info(&init_net);
+	if (WARN_ON(IS_ERR(info))) {
+		dput(dentry);
+		return;
+	}
+
 	if (dentry->d_parent != root) {
 		pr_err("Tried to unregister non-subsystem!\n");
+		dput(dentry);
+		configfs_put_super_info(info);
 		return;
 	}
 
@@ -1970,10 +1979,11 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 
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
index 88da7b428e52f2f4ab139ad3907101f685d617b1..067bb1099a52ca2216d1b2881429a3fd1811c706 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -22,10 +22,18 @@
 /* Random magic number */
 #define CONFIGFS_MAGIC 0x62656570
 
-static struct vfsmount *configfs_mount = NULL;
 struct kmem_cache *configfs_dir_cachep;
-static int configfs_mnt_count = 0;
+static DEFINE_XARRAY(configfs_super_xa);
+static struct configfs_super_info *configfs_root;
 
+static u64 configfs_ns_id(struct net *net_ns)
+{
+	struct ns_common *ns = net_ns ? to_ns_common(net_ns) : NULL;
+
+	if (!ns || net_ns == &init_net)
+		return 0;
+	return ns->ns_id;
+}
 
 static void configfs_free_inode(struct inode *inode)
 {
@@ -40,13 +48,6 @@ static const struct super_operations configfs_ops = {
 	.free_inode	= configfs_free_inode,
 };
 
-static struct config_group configfs_root_group = {
-	.cg_item = {
-		.ci_namebuf	= "root",
-		.ci_name	= configfs_root_group.cg_item.ci_namebuf,
-	},
-};
-
 bool configfs_is_root(struct config_item *item)
 {
 	struct configfs_dirent *sd;
@@ -57,19 +58,76 @@ bool configfs_is_root(struct config_item *item)
 	return !!(sd->s_type & CONFIGFS_ROOT);
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
+	strscpy(info->group.cg_item.ci_namebuf, "root", 4);
+	info->group.cg_item.ci_name = info->group.cg_item.ci_namebuf;
+	config_group_init(&info->group);
+	INIT_LIST_HEAD(&info->subsys_list);
+	mutex_init(&info->subsys_mutex);
+	refcount_set(&info->ref, 1);
+	info->mnt_count = 0;
+}
+
+struct configfs_super_info *configfs_get_super_info(struct net *net_ns)
+{
+	struct configfs_super_info *info;
+	u64 ns_id = configfs_ns_id(net_ns);
+	int err;
+
+	xa_lock(&configfs_super_xa);
+	info = xa_load(&configfs_super_xa, ns_id);
+	if (info) {
+		if (!refcount_inc_not_zero((&info->ref)))
+			info = ERR_PTR(-EBUSY);
+		xa_unlock(&configfs_super_xa);
+		return info;
+	}
+	info = kzalloc_obj(*info);
+	if (!info) {
+		xa_unlock(&configfs_super_xa);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	info->net_ns = get_net(net_ns);
+	configfs_fill_super_info(info);
+	err = __xa_insert(&configfs_super_xa, ns_id,
+			  info, GFP_KERNEL);
+	xa_unlock(&configfs_super_xa);
+	if (err < 0) {
+		put_net(info->net_ns);
+		kfree(info);
+		return ERR_PTR(err);
+	}
+	return info;
+}
+
+void configfs_put_super_info(struct configfs_super_info *info)
+{
+	u64 ns_id = configfs_ns_id(info->net_ns);
+
+	xa_lock(&configfs_super_xa);
+	if (!refcount_dec_and_test(&info->ref)) {
+		xa_unlock(&configfs_super_xa);
+		return;
+	}
+	__xa_erase(&configfs_super_xa, ns_id);
+	xa_unlock(&configfs_super_xa);
+	put_net(info->net_ns);
+	kfree(info);
+}
 
 static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct configfs_super_info *info = configfs_get_super_info(&init_net);
 	struct inode *inode;
 	struct dentry *root;
 
+	sb->s_fs_info = info;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = CONFIGFS_MAGIC;
@@ -77,25 +135,25 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_gran = 1;
 
 	inode = configfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
-				   &configfs_root, sb);
-	if (inode) {
-		inode->i_op = &configfs_root_inode_operations;
-		inode->i_fop = &configfs_dir_operations;
-		/* directory inodes start off with i_nlink == 2 (for "." entry) */
-		inc_nlink(inode);
-	} else {
+				   &info->root, sb);
+	if (IS_ERR(inode)) {
 		pr_debug("could not get root inode\n");
-		return -ENOMEM;
+		configfs_put_super_info(info);
+		return PTR_ERR(inode);
 	}
+	inode->i_op = &configfs_root_inode_operations;
+	inode->i_fop = &configfs_dir_operations;
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
 
 	root = d_make_root(inode);
 	if (!root) {
 		pr_debug("%s: could not get root dentry!\n",__func__);
+		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
-	config_group_init(&configfs_root_group);
-	configfs_root_group.cg_item.ci_dentry = root;
-	root->d_fsdata = &configfs_root;
+	info->group.cg_item.ci_dentry = root;
+	root->d_fsdata = &info->root;
 	sb->s_root = root;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	sb->s_d_flags |= DCACHE_DONTCACHE;
@@ -117,24 +175,33 @@ static int configfs_init_fs_context(struct fs_context *fc)
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
 
 
@@ -148,18 +215,27 @@ static int __init configfs_init(void)
 	if (!configfs_dir_cachep)
 		goto out;
 
+	configfs_root = configfs_get_super_info(&init_net);
+	if (IS_ERR(configfs_root)) {
+		err = PTR_ERR(configfs_root);
+		goto out2;
+	}
+
 	err = sysfs_create_mount_point(kernel_kobj, "config");
 	if (err)
-		goto out2;
+		goto out3;
 
 	err = register_filesystem(&configfs_fs_type);
 	if (err)
-		goto out3;
+		goto out4;
 
 	return 0;
-out3:
+out4:
 	pr_err("Unable to register filesystem!\n");
 	sysfs_remove_mount_point(kernel_kobj, "config");
+out3:
+	configfs_put_super_info(configfs_root);
+	configfs_root = NULL;
 out2:
 	kmem_cache_destroy(configfs_dir_cachep);
 	configfs_dir_cachep = NULL;
@@ -171,6 +247,8 @@ static void __exit configfs_exit(void)
 {
 	unregister_filesystem(&configfs_fs_type);
 	sysfs_remove_mount_point(kernel_kobj, "config");
+	configfs_put_super_info(configfs_root);
+	configfs_root = NULL;
 	kmem_cache_destroy(configfs_dir_cachep);
 	configfs_dir_cachep = NULL;
 }
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75beeaad87d33a18e86ac47bf2994705f2e..19165e36da810c75500bb584702ae3a594c3510d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -24,6 +24,7 @@
 #include <linux/list.h>   /* struct list_head */
 #include <linux/kref.h>   /* struct kref */
 #include <linux/mutex.h>  /* struct mutex */
+#include <net/net_namespace.h> /* struct net */
 
 #define CONFIGFS_ITEM_NAME_LEN	20
 

-- 
2.51.0

