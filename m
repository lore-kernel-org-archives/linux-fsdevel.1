Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9843C7DE8;
	Tue, 23 Jun 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206183; cv=none; b=jtIdoYePIziEZ6ctiC1WNOGW39bUvV7QNsvPeR+MN6WDcaEHzhIgYILmIVTyNwQ5biNkAevqE93ZsTai4VvCc8Pt9UTXNdUmpTwl4hvJBPvMS07EhSH7GpX5SOOawEny5SLq17gG8+Hr1Wl80Gd0sD3+MLrGpbSQ2NgwBaFslwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206183; c=relaxed/simple;
	bh=FJV4Qtadh95tNUoGTBfTx4N6VClvPDUcz3P43AJFQLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iq2hZLZ7K03xSlZXCF2ojoyRsg/dyvUDRFpm9oLX6kXNOEC43xR2WEvcgqkkjBhZsQzobJwdl66bhRC55x50vwgIMO+jVfBCA1YLDJI5xJb58cs4ugZ9SW/gHe1Ln5xxA8j1MmiZmR8GTGNZspCXveYLXLt8ftVu7APc8DlEndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz1N5Ce0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz1N5Ce0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5981F00A3D;
	Tue, 23 Jun 2026 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206181;
	bh=cTu6x6XxRI5vzWe/MWN740NA2s7n0Z9WiTKtNaIwedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qz1N5Ce0e66067aoO61H349OhKtAtb804mnwRcQ8wbhDjbm7qoH1FZNVKCLeTklEJ
	 lTOO2UcnNN4BnrNNl6n4XD6TLcZE/qDgRM3QYzds+2wwbKSGKPuIevN19mHYuq8ZOa
	 LuZjWlHk4AXhQ+IzRjnNj+ifZagYRqlqBl9HrgQxdHd0c8fXE8X8ucH9/i0QvjPq6v
	 QAgI6vrYawbB9Pip9VgRDb99MhjBiWHcnTv09PFcumChLwCyYRvRuAT4uKTNjfjUlI
	 59PEIJXEvt4k7QbCyonHikTfFSIivO+BHivo9bmW9AiYYLafI1+Kwicl+0K9uYMqVK
	 +a77oyR2thYGg==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:52 +0200
Subject: [PATCH RFC v3 07/12] fs/configfs: switch to get_tree_keyed()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-7-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=2892;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=FJV4Qtadh95tNUoGTBfTx4N6VClvPDUcz3P43AJFQLc=;
 b=F7pBShUXZ875Ba2ORmmZ30mK3V91nwhxZYI1QftOCGqDTMxjDZUrP6p4woUTKd+7hpfi6HQqp
 RaHl/4ov/KBAX5bPCGRAxIdNq+9fGfm7ka7CWpnHcgM6GLoDw18QGnv
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Switch to get_tree_keyed() to instatiate a new superblock whenever
the mount namespace changed.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/mount.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d36fc4a6f6439bea645e62b8423b518a5d7d51c1..bcc403f96d25d8385f6c903d40fa752da2610979 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -123,11 +123,10 @@ void configfs_put_super_info(struct configfs_super_info *info)
 
 static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct configfs_super_info *info = configfs_get_super_info(&init_net);
+	struct configfs_super_info *info = sb->s_fs_info;
 	struct inode *inode;
 	struct dentry *root;
 
-	sb->s_fs_info = info;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = CONFIGFS_MAGIC;
@@ -138,7 +137,6 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 				   &info->root, sb);
 	if (IS_ERR(inode)) {
 		pr_debug("could not get root inode\n");
-		configfs_put_super_info(info);
 		return PTR_ERR(inode);
 	}
 	inode->i_op = &configfs_root_inode_operations;
@@ -149,7 +147,6 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	root = d_make_root(inode);
 	if (!root) {
 		pr_debug("%s: could not get root dentry!\n",__func__);
-		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
 	info->group.cg_item.ci_dentry = root;
@@ -165,15 +162,38 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int configfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, configfs_fill_super);
+	struct net *net_ns = fc->fs_private;
+	struct configfs_super_info *info;
+	int err;
+
+	info = configfs_get_super_info(net_ns);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	err = get_tree_keyed(fc, configfs_fill_super, info);
+	if (err && fc->s_fs_info)
+		configfs_put_super_info(info);
+	return err;
+}
+
+static void configfs_fs_context_free(struct fs_context *fc)
+{
+	struct net *net_ns = fc->fs_private;
+
+	fc->fs_private = NULL;
+	put_net(net_ns);
 }
 
 static const struct fs_context_operations configfs_context_ops = {
 	.get_tree	= configfs_get_tree,
+	.free		= configfs_fs_context_free,
 };
 
 static int configfs_init_fs_context(struct fs_context *fc)
 {
+	struct net *net_ns = get_net(current->nsproxy->net_ns);
+
+	fc->fs_private = net_ns;
 	fc->ops = &configfs_context_ops;
 	return 0;
 }
@@ -193,6 +213,7 @@ static struct file_system_type configfs_fs_type = {
 	.name		= "configfs",
 	.init_fs_context = configfs_init_fs_context,
 	.kill_sb	= configfs_kill_sb,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 MODULE_ALIAS_FS("configfs");
 

-- 
2.51.0

