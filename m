Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B63A9DBA
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349297; cv=none; b=FlkINjyzIFcHLLzadmv52deT/MDCuX9fe9e8CfCOnO9qT/u5HZ+y9VsbrJBfK4Xn140XY1fSbaiIrNvDNheT6EtrHDwn9wlRju6HRaxRPNuyA7dAuF3kCuELDR52EoP3pr2Dk0iDEGT9JuDVYQvRjKahtdBhOxJY2dEWqz9PeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349297; c=relaxed/simple;
	bh=WC2uJiNrHqnHd5a+4+Um8s3GApgumUc3Ij8vTHRQsmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2vrl3EuWV5Rc1mCpwes2W0xogg8cnlggJBjb3/Jv7jZ5OZv9QOkH2qCd3u+dra6Y0UJlaPsTYs60ziiqNGlxCKKOfxI+jgA5KsNwwKv5USHXq/38+/8yuZ9WCi5LyB6pHkUs0qfeK1t8SUl4TBBoIqBkPO/WEt2okRrxYlfFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6tWoE2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6tWoE2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A021F00A3A;
	Sat, 13 Jun 2026 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349296;
	bh=iu6rBvjoOvKNSLxUBR2DOeDWWTvyfxrhpfZm8j2G/EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e6tWoE2soNdNngx+ebFBwQ29/VqDMitXwAc4bcAljbPSEhbJc3ut/yHHyj8XcvRUR
	 GJ5V0tjAXt2pyKyAfLr5k4IRRTeuXD7N8vFBKZDKaJGB/dyjM69HaSgG/Zi9lvofpM
	 s9b/FnO3U5HKGFf36CFUrIFCyfYL5uL1o0qRHlZ/UdjdDWJl2iae1DAjWacFX2OON3
	 W/42Si+T4DP1eNAMinZh9E5VfgKoGKrKH7H2mbC0kqWZqrfs39o3XQxlS2qiK9ekb7
	 CHAYPd3Kwh9VO9SvBUenCPRaH+53RS3DyJAy9wZNDg7kLkrONWMA6nrkC/XYi9dCHF
	 mxAt1O0MlB3iQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/8] fs/configfs: add superblock as attribute to configfs_pin_fs()
Date: Sat, 13 Jun 2026 13:14:34 +0200
Message-ID: <20260613111437.101763-6-hare@kernel.org>
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

Each namspace might have its own superblock, so add it as an argument
to configfs_pin_fs() to ensure that the correct filesystem instance
will be pinned.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |  4 +--
 fs/configfs/dir.c               | 10 ++++----
 fs/configfs/mount.c             | 44 +++++++++++++++++++++++++++------
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index e91f4249b83a..a91e97194c3d 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -90,8 +90,8 @@ extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
-extern struct dentry *configfs_pin_fs(void);
-extern void configfs_release_fs(void);
+extern struct dentry *configfs_pin_fs(struct super_block *sb);
+extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(u64 ns_id);
 extern void configfs_put_super_info(struct configfs_super_info *info);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index cf89c76ea7e6..6e111e3fd0e0 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1114,7 +1114,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * Pin the configfs filesystem.  This means we can safely access
 	 * the root of the configfs filesystem.
 	 */
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
@@ -1141,7 +1141,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * If we succeeded, the fs is pinned via other methods.  If not,
 	 * we're done with it anyway.  So release_fs() is always right.
 	 */
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 
 	return ret;
 }
@@ -1896,7 +1896,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	if (WARN_ON(IS_ERR(info)))
 		return PTR_ERR(info);
 
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
 		goto out_put;
@@ -1904,7 +1904,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 
 	err = configfs_link_root(info, subsys, root);
 	if (err)
-		configfs_release_fs();
+		configfs_release_fs(NULL);
 
 out_put:
 	configfs_put_super_info(info);
@@ -1964,7 +1964,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_unlink_root(subsys);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 	configfs_put_super_info(info);
 }
 
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index f49c8636eccb..8cf4bda14bec 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -177,18 +177,48 @@ static struct file_system_type configfs_fs_type = {
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
+	if (sb) {
+		struct configfs_super_info *root = info;
+		struct dentry *dentry = sb->s_root;
+		struct vfsmount *mnt;
+
+		info = sb->s_fs_info;
+		if (!info->mnt) {
+			mnt = mnt_clone_direct(root->mnt, dentry);
+			if (IS_ERR(mnt))
+				return ERR_CAST(mnt);
+			info->mnt = mnt;
+		}
+		dget(dentry);
+		mntget(info->mnt);
+		info->mnt_count++;
+		return info->mnt->mnt_root;
+	}
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
 
+	if (sb) {
+		info = sb->s_fs_info;
+		dput(sb->s_root);
+	}
+
+	pr_debug("release ns %llu\n", info->ns_id);
+	simple_release_fs(&info->mnt, &info->mnt_count);
+}
 
 static int __init configfs_init(void)
 {
-- 
2.51.0

