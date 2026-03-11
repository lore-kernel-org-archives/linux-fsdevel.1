Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993736493F;
	Wed, 11 Mar 2026 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266223; cv=none; b=WzND2f102+7ejD9FxsTN11Di5fQC66j33mUa6pnZEOT/PI4dxvt2NMdx7ho7mAOotz6Aarn65cHkP0Qi+cHsooupyIgUpg5ihkzigVOnwtbmzH8/UuhM7Kb9ddxoqjI8UAfSov8dRWCX8Nnw65uPojafrd6bxNy+Bitgu6O3AU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266223; c=relaxed/simple;
	bh=mGo5vgPxXKHRdLRU9ukAme3eIep7Ijcwdt87UtWZBEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlncJYDCQkb5YpbLN/6SoOeE2nllH34eVzj5h+e/5UIRgublWKbSaYn0O+X3dIwhDBhmPestIVaLk/kdNDE0u0mOmpipVhdR4PO7Z+qdHtFvtTwYoaTm7elB7jMAobfeKpIlLj6OJl5sVPU748LE1WzMxAAWMAmgS9L94tdCiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k41r6gxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k41r6gxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B220C2BC9E;
	Wed, 11 Mar 2026 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266223;
	bh=mGo5vgPxXKHRdLRU9ukAme3eIep7Ijcwdt87UtWZBEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k41r6gxKuRdpEeIuyFgrm3Gogs3TDNQh9fcKon0zj1xJIdMJr6/0xl2fJtKIt8VZV
	 WfNgJOg3n2YmASOzKUBHmuCyCM/KqQRH9y7E9vFrZDBsqEPxKeeeR+sNpVamB7c/0Q
	 f0tNlPpNx+FUZsoQ0KfnGWtHut0Thuw9Zs1lwMqqjzPIcmdENk5Djd31Je5Jyi+DKq
	 Mc7CkOUl1zsx6ZLdz3fV201XB5zYqJ1yjYq/gUyn/3wC4Bsr+c9SagmGCpav7O9xgk
	 uchPqYIigfjfBjt9YNMp01p3O8eZks1gfhTGDK1WYnLfLP1zrYsS9i8CoWZSC7CgA8
	 ZSdWQHmvMpN6w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:04 +0100
Subject: [PATCH RFC v3 21/26] fs: add kthread_mntns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-21-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mGo5vgPxXKHRdLRU9ukAme3eIep7Ijcwdt87UtWZBEM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJTdG691hr1FJMFm9Tzsze/V+zqtlX++3AVw9RlT
 u6Gq8zjOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyfhcjw5V9Wcv87n8uz7nY
 Jc3zeHrs74f825QimxI93rZKBS/4xMTwP3HBi/knjd/+8Vlc1CP2WmdB6u/ary6T7i7N6TQyY1O
 ezAwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow kthreads to create a private mount namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c        | 30 ++++++++++++++++++++++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..e23d2fa7e255 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6200,6 +6200,36 @@ static void __init init_mount_tree(void)
 	ns_tree_add(&init_mnt_ns);
 }
 
+/*
+ * Allow to give a specific kthread a private mount namespace anchored
+ * in the userspace nullfs (mount id 1) so it can mount.
+ */
+int __init kthread_mntns(void)
+{
+	struct mount *m;
+	struct path root;
+	int ret;
+
+	/* Only allowed for kthreads in the initial mount namespace. */
+	VFS_WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
+	VFS_WARN_ON_ONCE(current->nsproxy->mnt_ns != &init_mnt_ns);
+
+	/*
+	 * TODO: switch to creating a completely empty mount namespace
+	 * once that series lands.
+	 */
+	ret = ksys_unshare(CLONE_NEWNS);
+	if (ret)
+		return ret;
+
+	m = current->nsproxy->mnt_ns->root;
+	root.mnt = &m->mnt;
+	root.dentry = root.mnt->mnt_root;
+	set_fs_pwd(current->fs, &root);
+	set_fs_root(current->fs, &root);
+	return 0;
+}
+
 void __init mnt_init(void)
 {
 	int err;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..69d61f21b548 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -106,6 +106,7 @@ int do_mount(const char *, const char __user *,
 extern const struct path *collect_paths(const struct path *, struct path *, unsigned);
 extern void drop_collected_paths(const struct path *, const struct path *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
+int __init kthread_mntns(void);
 
 extern int cifs_root_data(char **dev, char **opts);
 

-- 
2.47.3

