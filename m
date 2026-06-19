Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886F36073E;
	Fri, 19 Jun 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858225; cv=none; b=HH4mPwWorMxG+/G3rcfwGe41CjJSPEt6DaiodSWz5nhoG0/Ix7ojfH7UTlEOcSgsf1/GdOHrj7DFfURTbP3KlPrfCbeDeZ4hgAVLT9gKTK9F+6b41nXwqhlV9qLs08tYQh1qawuunG/F7+p/VtbrIX7rOMdb96fnYdKf6OWtyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858225; c=relaxed/simple;
	bh=r1DNmk84hXKEZ6j4Gfn0RktmT2G4VNQgpnGEvFbxY+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpDbYLeyy82/oU6K1DZEFn34WmqVXcph8UeE+5Qp0xi8ernd1WlO7EdwCBzxI35ksP/hyAlyuxsN3kf2CcbVhhwi/O6+8QQyKqPplXEOJRVPfwxLf4F/Hm+NJUG2igEeT36ng0ddxHpMBwIw3rNYsGMwwataeUYfA1YVfujK3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcyZ5XGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcyZ5XGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8591F00A3D;
	Fri, 19 Jun 2026 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858223;
	bh=0DubRTU6Iz/Ro7e394EwWw2nggdKXXszNCIb49yLvpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KcyZ5XGJugPQr28ihVd68Mex1S8XV0jnx19U8HCmRULdGYVbxFD4IgVuhGaGgUudM
	 W+ZH/1VxVW3ij2l2aCAZaqsEus2PY70nsGK8QXuRvcYJZGr9AeYjua8P7YINDgi4/Q
	 HeF45lUTw+9iHguoVfAVSUg3u1/5kofwGv6A5SYaEiNulbMXMw/TSqyQDsX/6BTjca
	 fxm2gVCR1kw84CqPQE7xlgg9fEqxElRg/+rVfeO7qtDREyyS2cQxrtJURjB1kJpyFU
	 p/Zywlk5YfXZH0UQ6I1GjnFIlGZ32+LagbB63p8UAoz9rJU1fZtLXDL7x9y4Ehaja6
	 bTvrC+Wm8+eUg==
From: hare@kernel.org
Date: Fri, 19 Jun 2026 10:36:43 +0200
Subject: [PATCH RFC v2 03/12] fs/configfs: separate out
 configfs_{link,unlink}_root()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-3-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=3492;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=yHAhB9e1/FR+axXJqTRcqWkjtSmawCZhBgvgAWNFAhA=;
 b=T8B1redzS1+XhYlL1Oibl9F9RL4WrP+6ueh2IM1ucsBM42ITWELCTpWMmmRI/NpByqf3Lnb6S
 su4hpfhEweQDI1CSIf78RapRIQFpk+VEdK8KL3uAg0ExHwg3Nwuyb6t
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

From: Hannes Reinecke <hare@suse.de>

Separate out functions to link and unlink subsystem groups.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/dir.c | 68 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 2cd64c13538699683487b0669e8950f5c7bedd54..c9e1ae47fb0d7796121fa6b45aeb10a832a69cff 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1861,31 +1861,19 @@ void configfs_unregister_default_group(struct config_group *group)
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
@@ -1923,32 +1911,47 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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
+static bool configfs_unlink_root(struct configfs_subsystem *subsys)
+{
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
 
-	if (WARN_ON(IS_ERR(info))) {
-		dput(dentry);
-		return;
-	}
-
 	if (dentry->d_parent != root) {
 		pr_err("Tried to unregister non-subsystem!\n");
 		dput(dentry);
-		configfs_put_super_info(info);
-		return;
+		return false;
 	}
 
 	down_write(&frag->frag_sem);
@@ -1976,6 +1979,19 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	dput(dentry);
+	return true;
+}
+
+void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+{
+	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct config_group *group = &subsys->su_group;
+
+	if (WARN_ON(IS_ERR(info)))
+		return;
+
+	if (!configfs_unlink_root(subsys))
+		return;
 
 	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);

-- 
2.51.0

