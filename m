Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A93644A4;
	Tue, 23 Jun 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206171; cv=none; b=t2lccuyxiJrTuXVLgtl15t/Kktm4JDhOAHu7YkP0WFDjkS4bPAkY0JTpAJ9uR/YjbWKAz5oSv4dgD0HrpxSZgZJT+cCknJ1ISwHImrWsJQsCQFgVVfrcdFAyDdUHH0RYF+IJsTGg8EOxWsScSeqwoJH5E1YJhzdzXUjzxq9pVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206171; c=relaxed/simple;
	bh=AbOvo5csGGhKO8qSenOs73H9nrtomlMUlevoJuGVZH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIU9IN5G3HOOTGOQxiz7UXFvQZOzqSs15y909rSOBudbuMfW4xhX2MJvZ3jHPEKNPrcTrnwR+bMXn5DJQip5jRDJ3YQO2hpsGLGYXZaSaZTRoflDAUyh/FgAD5DZYDkwMZCEwQKTbWR9b4lABAXpygF7YmZK0seGH2NLaSqOBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptl4OIcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptl4OIcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFE91F000E9;
	Tue, 23 Jun 2026 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206170;
	bh=ZuOCy0Ub9zV1vVbHEmvRKz2G/+khR/RY/v9YB/RFdmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ptl4OIclXbLCb0Y9GjUF9E09X9wvAyOPD5j7/3B8Bz7VD0ZmvLjI5Xuo0ls3fyeBC
	 wYEuGn1JzDDmVhDncy0x3wrS3HYVSrXpBDro/OWa4M5IhL4zep8YzhIDMujxYjnrBP
	 WfAYYRWg8pRTigLeCLGCmFNw1C/DvvMK2yUowdlHrLTOFAYnGAD8L1aYSDddsE0pBS
	 QqLP1Tab9oiWq0fO1lSbHw7wIZkpUWXhgIqZAHlyzGF9bMtf+8e9NRoz2EK3Ttm/Jc
	 TkoQuMqL8sGxjwPAqx07QP1P3h4TEFVNrf/j7H2yU6Cq1A575wGm3Qv31QhX5Tlptl
	 1YHC4XEn7ulAA==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:48 +0200
Subject: [PATCH RFC v3 03/12] fs/configfs: separate out
 configfs_{link,unlink}_root()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-3-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=3634;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=AbOvo5csGGhKO8qSenOs73H9nrtomlMUlevoJuGVZH4=;
 b=Q+bp0/DYD3dz8Rx5ZHMxWf54LUeVBbSsj2SPji/DM4S46c2HHnaadOUrkgv9+ShpYSGc2jFKV
 2pQSka5qAZBAK4dE4TPY8xb2a93xuYbDit7ajPFDBv8knGiPjy9RVBB
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Separate out functions to link and unlink subsystem groups.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/dir.c | 74 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 1e9c82e02741798930b08c96fb59a2767c7e00fc..ffd0e302cff1756f2161bdb58f1d8c1ac0cf893a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1861,32 +1861,19 @@ void configfs_unregister_default_group(struct config_group *group)
 }
 EXPORT_SYMBOL(configfs_unregister_default_group);
 
-int configfs_register_subsystem(struct configfs_subsystem *subsys)
+static int configfs_link_root(struct configfs_super_info  *info,
+			      struct configfs_subsystem *subsys,
+			      struct dentry *root)
 {
-	struct configfs_super_info *info;
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry;
-	struct dentry *root;
 	struct configfs_dirent *sd;
 	struct configfs_fragment *frag;
 	int err;
 
-	info = configfs_get_super_info(&init_net);
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
@@ -1924,33 +1911,48 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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
 	struct configfs_super_info *info;
+	struct dentry *root;
+	int err;
+
+	info = configfs_get_super_info(&init_net);
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
 
-	info = configfs_get_super_info(&init_net);
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
@@ -1978,6 +1980,22 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	dput(dentry);
+	return true;
+}
+
+void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+{
+	struct configfs_super_info *info;
+	struct config_group *group = &subsys->su_group;
+
+	info = configfs_get_super_info(&init_net);
+	if (WARN_ON(IS_ERR(info)))
+		return;
+
+	if (!configfs_unlink_root(subsys)) {
+		configfs_put_super_info(info);
+		return;
+	}
 
 	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);

-- 
2.51.0

