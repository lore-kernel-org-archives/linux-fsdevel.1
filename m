Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E83BB12B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430320; cv=none; b=Ag1DNkjwCz8exWRulFObIua1opR07e5gw9+Eh1NPtmtXyNj/dh6KJi7KVyFTLGgWjxsIOr7BXuV9G8jcwOpBgSdwGB245+iGDsiVGucFllwBeJ8he7tX39tgSiKwBhSNxUFB4vbJl96lEYe32ZeCjWdooTythxx/hAPowu15L/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430320; c=relaxed/simple;
	bh=bwI+O/pyoUP6/u/jgH/ZyOAn0pFSwhf1MdYKeKdFt2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TR/LTWRO2MJmY/d9qFuDZDUyvwIbWeiItJDQ01XYQJqVpmbMXMV/1ae2hgeueH4b9BWuq3U3aJNeyaZhFLGW9wKy2qo5CTAy6W9AggI9aq8wIX2GIvls7TQS/mNf20W/3WK7pMFCA0Dds4RJjiZ04VHO+zIoGOvTdGHw/6Li3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crH8qHfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crH8qHfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D511F000FF;
	Sat, 26 Sep 2026 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430319;
	bh=+kW5TYROHYRHWr84pQN2NFY3qRwR6rql4SGUqcfs8IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=crH8qHfZQID9AMMjxBWBVf6akTA1P0BoiBZ2j/CBV3RBWTNYTk3E2UWYMWjRY4Q7u
	 cOFscUghQVCMJUGOSuBQ7bysGEEq63k7ppyEC5cas2JJ2NZZz+I+GUiOBtLwlJvkgU
	 2yKIY8thg3aHtLJoC3WK9NL8NVVWVka2ro2ygWrmtZpuCisOpXuTlXgthxrz17yn5k
	 hvOAq//plcLvqY92J71g4tUTVWZv7V739c+6DJj40DRcINnUx3NH1ZUciYxtfRjGYi
	 YQpxemE7hNolc6yvdJDIwBz6zKQ/RMPKLc5WSS2KsTABuL6TjLWLqVhgkMoTKYMlAN
	 yEYLUEQusug8w==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:31 +0200
Subject: [PATCH 08/10] namespace: drop the file's reference first in
 dissolve_on_fput()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-8-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bwI+O/pyoUP6/u/jgH/ZyOAn0pFSwhf1MdYKeKdFt2k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxN9/0Tseq0K6VK9tcx7hb2ufRFeIfn+xrnLhQVKd
 anzNvzV7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI7RlGhneLRL8GrthTs/5a
 rfBErvfpq6Je7tGO+HRk5o6tH42WP5Vm+B9/v7TVQG57TcShtWe5Ltp0pR96krLaerJXSti/qaw
 L97EBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A detached mount tree is held alive by a file. dissolve_on_fput()
unmounts the detached tree attached to that file.

Currently dissolve_on_fput() leaves the file's reference to the root of
the tree to the caller. So either __fput(), open_detached_copy(), or
fsmount() drop the mount.

That's backwards. The reference keeps the tree around and is dropped
when the tree is already gone. Instead, let dissolve_on_fput() the mount
and drop it after umount_tree() with namespace_sem still held. After
umount_tree() the mntput() is never the last reference and so the root
gets unmounted before its children.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file_table.c | 3 ++-
 fs/namespace.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c68b8c0a4097..e2665eaa6f8c 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -520,7 +520,8 @@ static void __fput(struct file *file)
 	dput(dentry);
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
 		dissolve_on_fput(mnt);
-	mntput(mnt);
+	else
+		mntput(mnt);
 out:
 	file_free(file);
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index de28fe9058ab..5b44eee28f39 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2312,9 +2312,11 @@ void drop_collected_paths(const struct path *paths, const struct path *prealloc)
 
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 
+/* Consumes the caller's reference to @mnt. */
 void dissolve_on_fput(struct vfsmount *mnt)
 {
-	struct mount *m = real_mount(mnt);
+	struct vfsmount *p __free(mntput) = mnt;
+	struct mount *m = real_mount(p);
 
 	/*
 	 * m used to be the root of anon namespace; if it still is one,
@@ -2339,6 +2341,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 		lock_mount_hash();
 		umount_tree(m, UMOUNT_CONNECTED);
 		unlock_mount_hash();
+		mntput(no_free_ptr(p));
 	}
 }
 
@@ -3109,7 +3112,7 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 	path->mnt = mntget(&ns->root->mnt);
 	file = dentry_open(path, O_PATH, current_cred());
 	if (IS_ERR(file))
-		dissolve_on_fput(path->mnt);
+		dissolve_on_fput(no_free_ptr(path->mnt));
 	else
 		file->f_mode |= FMODE_NEED_UNMOUNT;
 	return file;
@@ -4566,7 +4569,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
 		   dentry_open(&new_path, O_PATH, fc->cred));
 	if (fdf.err) {
-		dissolve_on_fput(new_path.mnt);
+		dissolve_on_fput(no_free_ptr(new_path.mnt));
 		return fdf.err;
 	}
 

-- 
2.53.0

