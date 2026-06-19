Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA19364926;
	Fri, 19 Jun 2026 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858230; cv=none; b=Z8ZbxJSQ+8PYs9Or+1hTgUz0WdVSukD50KIUZvSZ4Qf2IFDOkziUolZcggLd39J8d+2xbuSsVyNmYIYxqUI55EAeUledjLJTVWuczu2ylfHh4mOqklEl5N0irq7K/9UNq65z1Pwozsgh5/xblnv2UKbG+K5c4T39Fo3RZ15Bfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858230; c=relaxed/simple;
	bh=b0JLZ6RASLDI+YIWaCBzx3Uelur6q/zuN25Ek3VaKn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wk6yzXII4IYBHKCIa80PXGE6sxUsZ15Iv7YNrfaWLjfl/vJMbvTLanOfZgkNnhOm/N7owS7YlO5ulARGs/ykPmPVTKy9tRfh8gM6WQjd776F8UlAyTr3VFIE3AD88KUsqWrWOu3oeQuK04bQcrU0CI/4j3+DtwlRb1rWTwv3mAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdYL9o7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdYL9o7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ABD1F00A3D;
	Fri, 19 Jun 2026 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858229;
	bh=jbUuCX3vx9aLYGBX988mlwiGk5Wln7VCA85d3B3BDv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LdYL9o7PUfBJgqpLUvabvIn8e1uS0Wi4qxLsFzreV0SljqTPwrBl7CfNC8XjN576b
	 xrIm+AqQIffdOVmr3JXo4+1P+FHy/hM2BzFmrJulgkmZD/IbGy4tW6otsGiDbZNDs5
	 F3v5HxK2FM9RJXQFtHilZQpuh8xNygSP0k6JRQjL/OiK2lLrYlmISBBC0AaX68AnXY
	 20wEJnPmPAxms9jIxtwfVVXxz1sA1F+uaIbHyrtd3U9pFlRET2yfQi/jzmwtD8Ul9T
	 Sp6CKpPAFk1dcEfGI2OZOK8UoIf8xmCE2I+Hyl5NvcbyV7miRRjBXdvCsNxYplXW0j
	 akqzvHGf6ezxQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:45 +0200
Subject: [PATCH RFC v2 05/12] fs/configfs: add 'fill_subsystem' and
 'clear_subsystem' callbacks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-5-82fd7094b8dc@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=6940;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=b0JLZ6RASLDI+YIWaCBzx3Uelur6q/zuN25Ek3VaKn4=;
 b=TG4JLWpL1thcAmUkgEmD8d2P8v9mRqXmfImmO08BUimzqyTdWMXgdOPs63pAejfF8pet96OfO
 QjO1Ug39zyrDngFahxGJCRfzILX9BPUVxNRghlI/iS323RIDmrEyhTy
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

When creating a new per-namespace filesystem static initialisation
doesn't work, so implement a 'fill_subsystem' and 'clear_subsystem'
callbacks to 'struct configfs_subsystem' to allow for every driver
to populate the subsystem structure dynamicall.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |   4 ++
 fs/configfs/dir.c               | 101 +++++++++++++++++++++++++++++++++++++++-
 fs/configfs/mount.c             |   4 ++
 include/linux/configfs.h        |   5 ++
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index a4f10dd8ce0f46873d2053860a9fd25f3ee4c809..35eddc274b88796442c080fe4fe8a6ea68762185 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -94,6 +94,10 @@ extern struct dentry *configfs_pin_fs(struct super_block *sb);
 extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(struct net *net_ns);
 extern void configfs_put_super_info(struct configfs_super_info *info);
+extern void configfs_link_subsystems(struct super_block *sb,
+				     struct configfs_super_info *info);
+extern void configfs_unlink_subsystems(struct super_block *sb,
+				       struct configfs_super_info *info);
 
 extern const struct file_operations configfs_dir_operations;
 extern const struct file_operations configfs_file_operations;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 9b3738f58ccb891a8269708f0e875b0a75c1ab8e..891238ef0088a98467d6d63a10d633a40fc19c8b 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1931,15 +1931,92 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		goto out_put;
 	}
 
+	if (subsys->fill_subsystem) {
+		INIT_LIST_HEAD(&subsys->su_link);
+		mutex_init(&subsys->su_mutex);
+		config_group_init(&subsys->su_group);
+		err = subsys->fill_subsystem(subsys, info->ns_id);
+		if (err)
+			goto out_release;
+	}
+
 	err = configfs_link_root(info, subsys, root);
+	if (err) {
+		if (subsys->clear_subsystem)
+			subsys->clear_subsystem(subsys, info->ns_id);
+		goto out_release;
+	}
+
+	mutex_lock(&info->subsys_mutex);
+	list_add(&subsys->su_link, &info->subsys_list);
+	mutex_unlock(&info->subsys_mutex);
+
+out_release:
 	if (err)
 		configfs_release_fs(NULL);
-
 out_put:
 	configfs_put_super_info(info);
 	return err;
 }
 
+void configfs_link_subsystems(struct super_block *sb,
+			      struct configfs_super_info *info)
+{
+	struct configfs_subsystem *s;
+	struct configfs_super_info *parent = configfs_get_super_info(0);
+	LIST_HEAD(subsys_list);
+
+	if (WARN_ON(IS_ERR(parent)))
+		return;
+	if ((info->ns_id == 0) || WARN_ON(parent == info))
+		return;
+	mutex_lock(&parent->subsys_mutex);
+	list_splice_init(&parent->subsys_list, &subsys_list);
+	mutex_unlock(&parent->subsys_mutex);
+	list_for_each_entry(s, &subsys_list, su_link) {
+		struct configfs_subsystem *subsys;
+		struct dentry *root;
+		int err;
+
+		if (!s->fill_subsystem)
+			continue;
+		subsys = kzalloc_obj(*subsys);
+		if (!subsys)
+			continue;
+		subsys->fill_subsystem = s->fill_subsystem;
+		subsys->clear_subsystem = s->clear_subsystem;
+		INIT_LIST_HEAD(&subsys->su_link);
+		mutex_init(&subsys->su_mutex);
+		err = subsys->fill_subsystem(subsys, info->ns_id);
+		if (err) {
+			kfree(subsys);
+			continue;
+		}
+		root = configfs_pin_fs(sb);
+		if (IS_ERR(root)) {
+			if (subsys->clear_subsystem)
+				subsys->clear_subsystem(subsys, info->ns_id);
+			kfree(subsys);
+			continue;
+		}
+		err = configfs_link_root(info, subsys, root);
+		if (err) {
+			configfs_release_fs(sb);
+			if (subsys->clear_subsystem)
+				subsys->clear_subsystem(subsys, info->ns_id);
+			kfree(subsys);
+			continue;
+		}
+		mutex_lock(&info->subsys_mutex);
+		list_add(&subsys->su_link, &info->subsys_list);
+		mutex_unlock(&info->subsys_mutex);
+	}
+	mutex_lock(&parent->subsys_mutex);
+	list_splice(&subsys_list, &parent->subsys_list);
+	mutex_unlock(&parent->subsys_mutex);
+	configfs_put_super_info(parent);
+}
+
 static bool configfs_unlink_root(struct configfs_subsystem *subsys)
 {
 	struct config_group *group = &subsys->su_group;
@@ -1982,6 +2059,25 @@ static bool configfs_unlink_root(struct configfs_subsystem *subsys)
 	return true;
 }
 
+void configfs_unlink_subsystems(struct super_block *sb,
+				struct configfs_super_info *info)
+{
+	struct configfs_subsystem *subsys, *s;
+
+	mutex_lock(&info->subsys_mutex);
+	list_for_each_entry_safe(subsys, s, &info->subsys_list, su_link) {
+		list_del_init(&subsys->su_link);
+		if (!configfs_unlink_root(subsys))
+			continue;
+		if (subsys->clear_subsystem)
+			subsys->clear_subsystem(subsys, info->ns_id);
+		unlink_group(&subsys->su_group);
+		configfs_release_fs(sb);
+		kfree(subsys);
+	}
+	mutex_unlock(&info->subsys_mutex);
+}
+
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
 	struct configfs_super_info *info = configfs_get_super_info(0);
@@ -1994,6 +2090,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 		return;
 
 	mutex_lock(&info->subsys_mutex);
+	list_del_init(&subsys->su_link);
+	if (subsys->clear_subsystem)
+		subsys->clear_subsystem(subsys, info->ns_id);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
 	configfs_release_fs(NULL);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 8b26ceb7b0d4a03a17c251de42902aaabef5a652..d36fc4a6f6439bea645e62b8423b518a5d7d51c1 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -157,6 +157,9 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = root;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	sb->s_d_flags |= DCACHE_DONTCACHE;
+
+	configfs_link_subsystems(sb, info);
+
 	return 0;
 }
 
@@ -179,6 +182,7 @@ static void configfs_kill_sb(struct super_block *sb)
 {
 	struct configfs_super_info *info = sb->s_fs_info;
 
+	configfs_unlink_subsystems(sb, info);
 	kill_anon_super(sb);
 	configfs_put_super_info(info);
 	sb->s_fs_info = NULL;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 19165e36da810c75500bb584702ae3a594c3510d..c1cdadba0a48f0abea30da5ee324807b9ac4ff8f 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -227,8 +227,13 @@ struct configfs_group_operations {
 };
 
 struct configfs_subsystem {
+	struct list_head	su_link;
 	struct config_group	su_group;
 	struct mutex		su_mutex;
+	int (*fill_subsystem)(struct configfs_subsystem *subsys,
+			      u64 ns_id);
+	void (*clear_subsystem)(struct configfs_subsystem *subsys,
+				u64 ns_id);
 };
 
 static inline struct configfs_subsystem *to_configfs_subsystem(struct config_group *group)

-- 
2.51.0

