Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C956363C6F;
	Fri, 19 Jun 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858228; cv=none; b=FzuK2oOpvgNGAR2oYebxVZtHl4zOTu7JuFV8nzqAaS1pybxj4+cCjh8jlC7HxeK7AwO8dAhFKc9/KBW/ted/diLRhIc+O3EGMFDqXQlhfMHs2pcgvkwGSAcAzers+IuQj76f3k62eaYwR9M+ygUbGfMbjLC1ZtfiS9SauOfMAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858228; c=relaxed/simple;
	bh=7+L3mpgcNe7yGJ6ShbldurTj7C8a4t5OmF/0klX0+bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5nLrTIKhspvxZ6uYglfirdJADSZwIf5TGYMxy2ONGs8EHn/O0AtTCF6g6vWQCDemsY7jaooAClIsq+kutx/Pc3Ofmhw3YHPJT1UciSSqH1/qyW1Wgjtx6PrLJej5WxUp8uWTFUmcaNucZnMgFnwMihdJjNKCbmIDct2aKH6C+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp1Yian5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp1Yian5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396EB1F000E9;
	Fri, 19 Jun 2026 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858226;
	bh=Lfs48cC0n8zDR1pRf4XEhhhQ8nkUbB/ZVaA2FDFAHNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vp1Yian5s6eaDP6hP/bSypPo+61k/tCRKFVDfuc23eiFykRxtjvsQQkAmp9VqBIZ0
	 Ey6pS6qFqV/P0ht+Z1KEcd6363d0XMRN9HtOqUNd/Wid0kBLYlgwrb2F4dDvQH+onN
	 Kw7FIBmHQ6sy4rZ78FDSWpwZ87mcS1WF86ppPrttdirtVfQ/xI4pXnm1F0KGRVJxIw
	 O/rZD9ja42ojPMa0vfBRbkaLJuV7vqzP1d5T27jsMUhNdKROmnKJgUMmnUpxWIOIKZ
	 18A/ziLjSO1spxDxqGeNa0HJjYDRqqO7JiW0rtUGwKx5EBnHn5lroh/vx8M/OU7smh
	 07zKbbxYpYDrg==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:44 +0200
Subject: [PATCH RFC v2 04/12] fs/configfs: add superblock as attribute to
 configfs_pin_fs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-4-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=4037;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=7+L3mpgcNe7yGJ6ShbldurTj7C8a4t5OmF/0klX0+bU=;
 b=z6MeZA5EeQGgg6okfnIKLBsZHMUi21Pu5KENsFQMdtIVOT0yd7Dwg+/lsnH8gqDTcqaRBChWn
 wyRTqEB7s1wBKe54NwPHHNAslhTJobyFdB/EuuQaAdWx3sFvmhHf9cD
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Each namspace might have its own superblock, so add it as an argument
to configfs_pin_fs() to ensure that the correct filesystem instance
will be pinned.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |  4 ++--
 fs/configfs/dir.c               | 10 +++++-----
 fs/configfs/mount.c             | 20 +++++++++++++-------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 94b9e306709150e7a123c46bb359077c6dc917ad..a4f10dd8ce0f46873d2053860a9fd25f3ee4c809 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -90,8 +90,8 @@ extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
-extern struct dentry *configfs_pin_fs(void);
-extern void configfs_release_fs(void);
+extern struct dentry *configfs_pin_fs(struct super_block *sb);
+extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(struct net *net_ns);
 extern void configfs_put_super_info(struct configfs_super_info *info);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index c9e1ae47fb0d7796121fa6b45aeb10a832a69cff..9b3738f58ccb891a8269708f0e875b0a75c1ab8e 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1144,7 +1144,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * Pin the configfs filesystem.  This means we can safely access
 	 * the root of the configfs filesystem.
 	 */
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
@@ -1171,7 +1171,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * If we succeeded, the fs is pinned via other methods.  If not,
 	 * we're done with it anyway.  So release_fs() is always right.
 	 */
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 
 	return ret;
 }
@@ -1925,7 +1925,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	if (WARN_ON(IS_ERR(info)))
 		return PTR_ERR(info);
 
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
 		goto out_put;
@@ -1933,7 +1933,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 
 	err = configfs_link_root(info, subsys, root);
 	if (err)
-		configfs_release_fs();
+		configfs_release_fs(NULL);
 
 out_put:
 	configfs_put_super_info(info);
@@ -1996,7 +1996,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 	configfs_put_super_info(info);
 }
 
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 067bb1099a52ca2216d1b2881429a3fd1811c706..8b26ceb7b0d4a03a17c251de42902aaabef5a652 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -192,18 +192,24 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
-struct dentry *configfs_pin_fs(void)
+struct dentry *configfs_pin_fs(struct super_block *sb)
 {
-	int err = simple_pin_fs(&configfs_fs_type, &configfs_root->mnt,
-			     &configfs_root->mnt_count);
-	return err ? ERR_PTR(err) : configfs_root->mnt->mnt_root;
+	struct configfs_super_info *info = configfs_root;
+	int err;
+
+	err = simple_pin_fs(&configfs_fs_type, &info->mnt, &info->mnt_count);
+	if (err)
+		return ERR_PTR(err);
+
+	return info->mnt->mnt_root;
 }
 
-void configfs_release_fs(void)
+void configfs_release_fs(struct super_block *sb)
 {
-	simple_release_fs(&configfs_root->mnt, &configfs_root->mnt_count);
-}
+	struct configfs_super_info *info = configfs_root;
 
+	simple_release_fs(&info->mnt, &info->mnt_count);
+}
 
 static int __init configfs_init(void)
 {

-- 
2.51.0

