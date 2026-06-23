Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFF3CF96D;
	Tue, 23 Jun 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206186; cv=none; b=CjrktjuNaI+IQdRRbv7mty3wDHUCsniO7JDPFuXXW89w2Toi41WsuxJPKhVlczJ0iHOARd6IoKnKJap2EPMgGWP69TuNAPa3u9P8l1OruNALT37sh6ZZtI8ANpzmk5XwekFPE5mjXRJ/erd0Oypm9M9LNf//Mi3S4XrOHhX9qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206186; c=relaxed/simple;
	bh=MVTYWmct97EfJDIEhTaWhdq0zmtVBW7sYPmXGxzAlyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlGzqIgDq44UAWtvSeZZJAWpfnUPgmNc8rDBre38rAfm8+VhILk9m5awxEEL7bcrua/pIDy5Pj6aBRpdT96oHIH20t0gKOYh+GFUByFi+yTJWDhZb0OAcYNAovYSKFcsyBfFFaPcicN8vcF7OeP66dgsZnPxx/z4Z7Fm9gJZlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofkqs4YW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofkqs4YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC71F000E9;
	Tue, 23 Jun 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206184;
	bh=4Hwti9nFw4mnx7748PeCxxo0AdZPbRq8oHtQ+0eU24M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ofkqs4YW0dUVIhyMyN65kKDjbkgYoPFqCBXzqyIKNH9z1MQegN8/yOiHGN74n0mcl
	 ImTRS8dG4vWR0XPhuiTdHtVBXscdlMCLzeO15S1x8O4OUnCVTOo1ah6pChrCjaUIam
	 A/e7PHe7+GD0qvX5lcKXTSUMLSITKuu2W/IfqDYNZzgjfQ8w2RVcDbxnJLEuj74GnK
	 c4gdRoHEvBN1J+R+cbKd491BZ3KeG/JR7UBGdzWWQywX4KM/bJO7oscolgxns782LD
	 0dLQ7zBD+6Hg6U4HSzzn/J5KrRkq0maSk6QyxVjUXiy6V35K5E8ip4HkqXGmu6IK54
	 JZ4xiFrfe21OQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:53 +0200
Subject: [PATCH RFC v3 08/12] fs/configfs: open-code simple_pin_fs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-8-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=2713;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=MVTYWmct97EfJDIEhTaWhdq0zmtVBW7sYPmXGxzAlyY=;
 b=/PTNkMAqVNGned+QZ3KhGslq1fV4jf88UcqmrXEJeX6Gc052gwg43cAmnNNkAv3K792rYMwb4
 qv39DzYHUwLC7dAHvDObGnVlpmitvoketMPm8PWuM6wtbs0uBgML7lb
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

simple_pin_fs() is protected by an internal spin lock, to
protect against concurrent use of simple_release_fs().
But as we also need to clone the mountpoint we cannot
easily expand the scope of the lock as it's internal to
fs/libfs. So open-code simple_pin_fs() and simple_release_fs()
to be able to use a lock covering all use-cases.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/mount.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index bcc403f96d25d8385f6c903d40fa752da2610979..095a480b6ea27db9a43b067af7e6352fd0ae50ee 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -25,6 +25,7 @@
 struct kmem_cache *configfs_dir_cachep;
 static DEFINE_XARRAY(configfs_super_xa);
 static struct configfs_super_info *configfs_root;
+static DEFINE_SPINLOCK(configfs_pin_lock);
 
 static u64 configfs_ns_id(struct net *net_ns)
 {
@@ -219,21 +220,60 @@ MODULE_ALIAS_FS("configfs");
 
 struct dentry *configfs_pin_fs(struct super_block *sb)
 {
-	struct configfs_super_info *info = configfs_root;
-	int err;
-
-	err = simple_pin_fs(&configfs_fs_type, &info->mnt, &info->mnt_count);
-	if (err)
-		return ERR_PTR(err);
+	struct configfs_super_info *info;
 
+	spin_lock(&configfs_pin_lock);
+	if (sb) {
+		struct configfs_super_info *root = configfs_root;
+		struct dentry *dentry = sb->s_root;
+
+		info = sb->s_fs_info;
+		if (!info->mnt) {
+			struct vfsmount *mnt;
+
+			spin_unlock(&configfs_pin_lock);
+			mnt = mnt_clone_direct(root->mnt, dentry);
+			if (IS_ERR(mnt))
+				return ERR_CAST(mnt);
+			spin_lock(&configfs_pin_lock);
+			info->mnt = mnt;
+		} else {
+			mntget(info->mnt);
+		}
+	} else {
+		info = configfs_root;
+		if (!info->mnt) {
+			struct vfsmount *mnt;
+
+			spin_unlock(&configfs_pin_lock);
+			mnt = vfs_kern_mount(&configfs_fs_type, SB_KERNMOUNT,
+					     configfs_fs_type.name, NULL);
+			if (IS_ERR(mnt))
+				return ERR_CAST(mnt);
+			spin_lock(&configfs_pin_lock);
+			info->mnt = mnt;
+		} else {
+			mntget(info->mnt);
+		}
+	}
+	info->mnt_count++;
+	spin_unlock(&configfs_pin_lock);
 	return info->mnt->mnt_root;
 }
 
 void configfs_release_fs(struct super_block *sb)
 {
 	struct configfs_super_info *info = configfs_root;
-
-	simple_release_fs(&info->mnt, &info->mnt_count);
+	struct vfsmount *mnt;
+
+	spin_lock(&configfs_pin_lock);
+	if (sb)
+		info = sb->s_fs_info;
+	mnt = info->mnt;
+	if (--info->mnt_count)
+		info->mnt = NULL;
+	spin_unlock(&configfs_pin_lock);
+	mntput(mnt);
 }
 
 static int __init configfs_init(void)

-- 
2.51.0

