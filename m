Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F413A7F58
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349293; cv=none; b=qMTx+T7FRC8lpr4Lbo/6441FhOmVOUvYv3pKYlbNOxSnpwMa5n2+86AUGauKznMhqQDIlm5QS5nkwdyqu+6HIx5wqWXo/G+kos1IbuPDg113siupk+4mwYvBAVYsKjSLheMR8fov0wM/pDYibv0qZ2xb7KdZz4wqCdcKTcccDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349293; c=relaxed/simple;
	bh=kPuP3XPrsqu5Vif7bmQKf/+76wu/svzJM/Tc8MPxEyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMTV8EjOyD5r8UWjSTpZjGN9GBElmj8iuNXVGs50xrr9kIV78CdE9StHmBbnQ2YnMOTjsMXU7IN5NTP2qa8hoXoBpGYDfCRESrs11HHFWGdRP5LmaMl6ya3QSZo8gRrWVhN7a1dVL3tB4+0VI01x+USBQPWj/IQADmRh0y+pXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvDPhA5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvDPhA5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7DA1F00A3A;
	Sat, 13 Jun 2026 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349292;
	bh=R03/AF2xU5C+Qg8eoSjwp1j2DlW2r4g5h2ejCWMVZWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fvDPhA5RLFey1qjcqlOjNuErYTcdrKdaS3fgvgxjzz5YAct7ICdT9Tq35FZrqZfkM
	 ArkCJoRkdfTi8/0drfzkQhIhOVEBNq0lLPKyYz6qYI1Akc544A3Gu7HenUwCJqOBsR
	 +JztAHb8u/MCxi9uTnj75a4lvzpVtDmwXijBam+/fWc9nIHoaYGfVa3hHAJeA/cMAE
	 EzgaIwQJsEN4Ns5KJyRSVBHl4QYGI2KG1A5saUKraDSdL3gk6nvvaUU8nJlP1RiZxp
	 ZhDdb5KvtvYytxk69O9SH5QW/gHkKAD3dRCKg2M9LWBM5cY7O6xHTIxmbvsBdSpWQe
	 vf723ds82mD/A==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/8] fs/configfs: separate out configfs_{link,unlink}_root()
Date: Sat, 13 Jun 2026 13:14:32 +0200
Message-ID: <20260613111437.101763-4-hare@kernel.org>
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

Separate out functions to link and unlink subsystem groups.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/dir.c | 61 +++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 57719bee0c07..cf89c76ea7e6 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1831,31 +1831,19 @@ void configfs_unregister_default_group(struct config_group *group)
 }
 EXPORT_SYMBOL(configfs_unregister_default_group);
 
-int configfs_register_subsystem(struct configfs_subsystem *subsys)
+static int configfs_link_root(struct configfs_super_info  *info,
+			      struct configfs_subsystem *subsys,
+			      struct dentry *root)
 {
-	struct configfs_super_info *info = configfs_get_super_info(0);
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry;
-	struct dentry *root;
 	struct configfs_dirent *sd;
 	struct configfs_fragment *frag;
 	int err;
 
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
 	frag = new_fragment();
-	if (!frag) {
-		configfs_put_super_info(info);
+	if (!frag)
 		return -ENOMEM;
-	}
-
-	root = configfs_pin_fs();
-	if (IS_ERR(root)) {
-		put_fragment(frag);
-		configfs_put_super_info(info);
-		return PTR_ERR(root);
-	}
 
 	if (!group->cg_item.ci_name)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
@@ -1894,29 +1882,46 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		mutex_lock(&info->subsys_mutex);
 		unlink_group(group);
 		mutex_unlock(&info->subsys_mutex);
-		configfs_release_fs();
 	}
 	put_fragment(frag);
-	configfs_put_super_info(info);
 	return err;
 }
 
-void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+int configfs_register_subsystem(struct configfs_subsystem *subsys)
 {
 	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct dentry *root;
+	int err;
+
+	if (WARN_ON(IS_ERR(info)))
+		return PTR_ERR(info);
+
+	root = configfs_pin_fs();
+	if (IS_ERR(root)) {
+		err = PTR_ERR(root);
+		goto out_put;
+	}
+
+	err = configfs_link_root(info, subsys, root);
+	if (err)
+		configfs_release_fs();
+
+out_put:
+	configfs_put_super_info(info);
+	return err;
+}
+
+static void configfs_unlink_root(struct configfs_subsystem *subsys)
+{
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
 
-	if (WARN_ON(IS_ERR(info)))
-		return;
-
 	if (dentry->d_parent != root) {
 		pr_err("Tried to unregister non-subsystem!\n");
 		dput(dentry);
-		configfs_put_super_info(info);
 		return;
 	}
 
@@ -1945,8 +1950,18 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	dput(dentry);
+}
+
+void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+{
+	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct config_group *group = &subsys->su_group;
+
+	if (WARN_ON(IS_ERR(info)))
+		return;
 
 	mutex_lock(&info->subsys_mutex);
+	configfs_unlink_root(subsys);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
 	configfs_release_fs();
-- 
2.51.0

